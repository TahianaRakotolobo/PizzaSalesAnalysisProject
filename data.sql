-- ALTER TABLE public."Sales"
-- ALTER COLUMN pizza_id TYPE integer;

SET datestyle = 'DMY';

COPY public."Sales" (
    pizza_id,
    order_id,
    pizza_name_id,
    quantity,
    order_date,
    order_time,
    unit_price,
    total_price,
    pizza_size,
    pizza_category,
    pizza_ingredients,
    pizza_name
)
FROM 'D:/Work/DataAnalysisProject/PizzaSalesProject/data/pizza_sales.csv'
DELIMITER ','
CSV HEADER
QUOTE '"'
ESCAPE '''';

SELECT * FROM public."Sales";

-- Total Revenue
SELECT SUM(total_price) AS total_revenue FROM public."Sales";

-- Average Order Value
SELECT (SUM(total_price)/COUNT(DISTINCT(order_id))) AS avg_order_value FROM public."Sales";

-- Total Pizza sold
SELECT SUM(quantity) AS total_quantity FROM public."Sales";

-- Total Orders
SELECT COUNT(DISTINCT(order_id)) AS total_orders FROM public."Sales";

-- Average Pizzas per order
SELECT SUM(quantity)/COUNT(DISTINCT(order_id)) AS average_pizzas_order FROM public."Sales";

-- Daily trend for total orders
SELECT 
	to_char(order_date, 'Day') AS day_name, 
	COUNT(DISTINCT(order_id)) AS daily_trend_order 
FROM public."Sales" 
GROUP BY to_char(order_date, 'Day')
ORDER BY daily_trend_order DESC;

-- Monthly trend for total orders
SELECT 
	to_char(order_date, 'Month') AS month_name, 
	COUNT(DISTINCT(order_id)) AS monthly_trend_order 
FROM public."Sales" 
GROUP BY to_char(order_date, 'Month')
ORDER BY monthly_trend_order DESC;

-- Percentage of sales by pizza category
SELECT 
	pizza_category, 
	SUM(total_price)*100/(SELECT SUM(total_price) FROM public."Sales") AS percetange_sales_cat 
FROM public."Sales" 
GROUP BY pizza_category;

-- Percentage of sales by pizza size
SELECT 
	pizza_size, 
	SUM(total_price)*100/(SELECT SUM(total_price) FROM public."Sales") AS percetange_sales_size 
FROM public."Sales" 
GROUP BY pizza_size;

-- Total pizza sold per pizza category
SELECT 
	pizza_category, 
	SUM(quantity) 
FROM public."Sales" 
GROUP BY pizza_category;

-- Top 5 pizza sold by revenue
SELECT 
	pizza_name, 
	SUM(total_price) AS revenue_pizza 
FROM public."Sales" 
GROUP BY pizza_name
ORDER BY revenue_pizza DESC
LIMIT 5;
-- Top 5 pizza sold by quantity
SELECT 
	pizza_name, 
	SUM(quantity) AS quantity_pizza 
FROM public."Sales" 
GROUP BY pizza_name
ORDER BY quantity_pizza DESC
LIMIT 5;

-- Bottom 5 pizza sold by revenue
SELECT 
	pizza_name, 
	SUM(total_price) AS revenue_pizza 
FROM public."Sales" 
GROUP BY pizza_name
ORDER BY revenue_pizza ASC
LIMIT 5;
-- Bottom 5 pizza sold by quantity
SELECT 
	pizza_name, 
	SUM(quantity) AS quantity_pizza 
FROM public."Sales" 
GROUP BY pizza_name
ORDER BY quantity_pizza ASC
LIMIT 5;