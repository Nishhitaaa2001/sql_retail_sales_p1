-- Create TABLE
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    transactions_id   INT PRIMARY KEY,
    sale_date         DATE,
    sale_time         TIME,
    customer_id       INT,
    gender            VARCHAR(15),
    age               INT,
    category          VARCHAR(15),
    quantity          INT,
    price_per_unit    FLOAT,
    cogs              FLOAT,
    total_sale        FLOAT
);
select * from retail_sales;
-- 1. Get the total number of records in the table
SELECT COUNT(*) 
FROM retail_sales;


-- 2. Find rows where transactions_id is missing (NULL)
SELECT * 
FROM retail_sales
WHERE transactions_id IS NULL;


-- 3. Find rows where sale_date is missing (NULL)
SELECT * 
FROM retail_sales
WHERE sale_date IS NULL;

-- data cleaning
-- 4. Which rows in retail_sales have missing data

SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Data Exploration

-- 1. How many sales do we have?
SELECT COUNT(*) AS total_sales
FROM retail_sales;


-- 2. How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;


-- 3. What are the unique categories?
SELECT DISTINCT category
FROM retail_sales;


-- data analysis and busniess key problems and answers
-- Ques1 select all query to retrive all columns for sales made on '2022-11-05'?
SELECT *
FROM data_analysis_p1.retail_sales
WHERE sale_date = '2022-11-05';
-- Ques2 write a query to receive all transaction  where the categeory is 'clothing' and the quantity sold id more than 10 in the month of nov-2022 ?
SELECT *
FROM data_analysis_p1.retail_sales
WHERE category = 'clothing'
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
  AND quantity > 10;
  -- Ques3 write a sql query to calculate the total sales (total_sales) for the category?
SELECT 
    category,
    SUM(quantity * price_per_unit) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
-- ques 4 write a sql query to find the average of the customers who purchased items from the 'beauty' category?
select 
avg(AGE)
from data_analysis_p1.retail_sales
where category='beauty';
-- ques 5 write a sql query to find all transaction where the total_sale is greater than 1000?
SELECT *
FROM data_analysis_p1.retail_sales
WHERE total_sale > 1000;
-- ques6 write a sql query to find a total number of transaction (transaction_id) made by each gender in each categeory?
SELECT 
    category,
    gender,
    COUNT(transaction_id) AS total_trans
FROM data_analysis_p1.retail_sales
GROUP BY 
    category,
    gender
ORDER BY 
    category, gender;
-- ques7 write a sql query to calculate the average sale for each month. find out the best selling month of the year?
SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(quantity * price_per_unit) AS avg_sale
FROM data_analysis_p1.retail_sales
GROUP BY year, month
ORDER BY avg_sale DESC;
-- Ques8 write a sql query to find the top 5 customers based on the highest total sales
select 
     customers_id,
     sum(total_sales) as total_sales
from data_analysis_p1.retail_sales
group by customers_id;
-- ques9 write a sql query to find the number of unique customers who purchased items for each category?
SELECT
  category,
  COUNT(DISTINCT customer_id) AS unique_customers
FROM
  data_analysis_p1.retail_sales
GROUP BY
  category;
  -- ques10 write a sql query to create each shift and number of the orders( example <=12, afternoon between 12 & 17, evening >17)?
  WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END as shift
    FROM retail_sales
)
SELECT
    shift,
    COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift
-- end of project





  
