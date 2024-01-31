/* KPI's*/

/* Total Revenue*/
select round(sum(total_price),2) as total_revenue from pizza_sales;

/* Average order Value*/

select sum(total_price)/ count(distinct order_id) as Avg_order
from pizza_sales;

/* Total Pizza Sold*/

select sum(quantity) as total_pizza_sold 
from pizza_sales;

/* Total Orders*/

select count(distinct order_id) as total_orders
from pizza_sales;

/* Avg Pizza Per order*/

select round(sum(quantity)/count(distinct order_id),1) as total_orders
from pizza_sales;

/* -------- */
UPDATE pizza_sales
SET order_date = REPLACE(order_date, '-', '/');


ALTER TABLE pizza_sales
MODIFY COLUMN order_date VARCHAR(20);


UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%m/%d/%Y');
;


/* Chart Requirements */
 -- day trends--
SELECT 
    weekday(order_date) +1 as week_no,
    dayname(order_date) AS week,
    round(SUM(total_price),2) AS total,
    COUNT(DISTINCT order_id) as total_order
FROM 
    pizza_sales
GROUP BY week, week_no
order by week_no;


 -- monthly trends--
SELECT 
    month(order_date) as month_no,
    monthname(order_date) AS month,
    round(SUM(total_price),2) AS total,
    COUNT(DISTINCT order_id) as total_order
FROM 
    pizza_sales
GROUP BY month_no,month
order by month_no ;

-- % sales by Pizza category --

SELECT 
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_sales,
    ROUND((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100, 2) AS percentage_sales
FROM 
    pizza_sales
GROUP BY 
    pizza_category
ORDER BY 
    total_sales DESC;

-- Pizza sales by category---

SELECT 
     pizza_category,
     round(sum(total_price),2) as total_sales
FROM 
    pizza_sales
GROUP BY pizza_category
order by total_sales desc;

-- % of sales by Pizza size---

Select
	pizza_size,
    ROUND(SUM(total_price), 2) AS total_sales,
    ROUND((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100, 2) AS percentage_sales
FROM 
    pizza_sales
GROUP BY 
    pizza_size
ORDER BY 
    total_sales DESC;
    
-- Total pizza sold by category---
Select
	pizza_category,
	sum(quantity) as total_sold
FROM 
    pizza_sales
GROUP BY 
    pizza_category
ORDER BY 
    total_sold DESC;

-- Top 5 Best Sellers by Revenue---
SELECT 
       pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
Limit 5;

-- Top 5 Best Sellers by Total Quantity---
SELECT 
       pizza_name, SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity DESC
Limit 5;
-- Top 5 Best Sellers by Total Orders---
SELECT 
       pizza_name, count(distinct order_id) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC
Limit 5;

-- Bottom 5 Best Sellers by Revenue---
SELECT 
       pizza_name, round(SUM(total_price),2) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue asc
Limit 5;
-- Bottom 5 Best Sellers by Total Quantity---
SELECT 
       pizza_name, SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity
Limit 5;
-- Bottom 5 Best Sellers by Total Orders---
SELECT 
       pizza_name, count(distinct order_id) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders
Limit 5;
