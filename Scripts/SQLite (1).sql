SELECT * FROM Sales_with_NaNs_v13

  ---1. Remove Duplicates--
  
  SELECT *,
  ROW_NUMBER () over(Partition 
                    by customer_segment,sales_before,sales_after,
                     customer_satisfaction_before, customer_satisfaction_after,purchase_made) 
                     AS Row_Num
  FROM Sales_with_NaNs_v13
  
 WITH Duplicate_cte AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION
                       BY customer_segment, sales_before, sales_after, 
                       customer_satisfaction_before,customer_satisfaction_after, purchase_made)
      				   AS Row_Num
  FROM Sales_with_NaNs_v13
)
SELECT *
FROM Duplicate_cte
WHERE Row_Num > 1;

CREATE TABLE 'sales_with_NaNs'
    ('Group'text, 'customer_segment' text, 'sales_before' int,
     'sales_after' int,'customer_satisfaction_before' int,'customer_satisfaction_after' int,
     'purchase_made' text, 'Row_Num' int)
     
 INSERT INTO sales_with_NaNs
 			SELECT *,
  ROW_NUMBER () over(Partition by customer_segment,sales_before,sales_after,
                     customer_satisfaction_before,customer_satisfaction_after,purchase_made)
                     AS Row_Num
  FROM Sales_with_NaNs_v13
     
 SELECT * FROM sales_with_NaNs
 WHERE row_num > 1
 
 DELETE FROM sales_with_NaNs
 WHERE row_num > 1
 
 SELECT * FROM sales_with_NaNs
 WHERE row_num > 1

--- Working with Nulls Annd blank values-----
 
 SELECT *
 FROM sales_with_NaNs
 WHERE sales_before IS NULL
  
Delete FROM sales_with_NaNs
WHERE sales_before IS NULL
   Or sales_after Is NULL
   or customer_satisfaction_before Is NULL
   Or customer_satisfaction_after IS NULL;

UPDATE sales_with_NaNs
SET customer_segment = 'Not Segmented'
WHERE customer_segment IS NULL OR TRIM(customer_segment) = '';

SELECT *
FROM sales_with_NaNs 

 ----2.Standardizing Data-----
 
 SELECT * FROM sales_with_NaNs
 
 ALTER TABLE sales_with_NaNs
 RENAME 'Group' to 'Cluster'
 
 SELECT cluster FROM sales_with_NaNs
 
 UPDATE sales_with_NaNs
SET cluster = 'Control'
WHERE cluster IS NULL OR TRIM(cluster) = '';
 
 SELECT cluster, Trim(cluster)
 From sales_with_NaNs
 
 UPDATE sales_with_NaNs
 Set cluster = Trim(cluster)
 
 SELECT customer_segment, Trim(customer_segment)
 From sales_with_NaNs
 
 UPDATE sales_with_NaNs
 Set customer_segment = Trim(customer_segment)
 
SELECT 
ROUND(Sales_Before, 2) AS Sales_Before,
ROUND(Sales_After, 2) AS Sales_After,
ROUND(Customer_Satisfaction_Before, 2) AS Customer_Satisfaction_Before,
ROUND(Customer_Satisfaction_After, 2) AS Customer_Satisfaction_After,
Purchase_Made
FROM sales_with_NaNs;
    
   UPDATE sales_with_NaNs
   SET 
    Sales_Before = ROUND(Sales_Before, 2),
    Sales_After = ROUND(Sales_After, 2),
    Customer_Satisfaction_Before = ROUND(Customer_Satisfaction_Before, 2),
    Customer_Satisfaction_After = ROUND(Customer_Satisfaction_After, 2); 
    
 SELECT *
 FROM sales_with_NaNs
 
SELECT count (customer_segment) FROM sales_with_NaNs
 