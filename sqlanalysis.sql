-- 1. Total Orders & Revenue
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_revenue
FROM orders;

-- 2. Revenue by Category
SELECT 
    category,
    SUM(sales) AS revenue
FROM orders
GROUP BY category
ORDER BY revenue DESC;

-- 3. Top 5 Customers by Revenue
SELECT 
    customer_id,
    SUM(sales) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 4. Monthly Sales Trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

-- 5. Average Order Value
SELECT 
    SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value
FROM orders;

-- 6. Customer Ranking (Window Function)
SELECT 
    customer_id,
    SUM(sales) AS total_spent,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS customer_rank
FROM orders
GROUP BY customer_id;

-- 7. Sales Growth (LAG Function)
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS revenue,
    LAG(SUM(sales)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) AS prev_month_revenue
FROM orders
GROUP BY month;

-- 8. Top Products by Sales
SELECT 
    product_name,
    SUM(sales) AS total_sales
FROM orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;