-- Marketplace Revenue Leakage & Gap Analysis

-- 1. Revenue vs Profit Reality
SELECT 
    ROUND(SUM(o.selling_price * o.quantity), 2) AS total_revenue,
    ROUND(SUM(p.cost_price * o.quantity), 2) AS total_cost,
    ROUND(SUM((o.selling_price - p.cost_price) * o.quantity), 2) AS total_profit
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_status = 'DELIVERED';

-- 2. Category Performance
SELECT 
    p.category,
    ROUND(SUM(o.selling_price * o.quantity), 2) AS total_sales,
    ROUND(SUM((o.selling_price - p.cost_price) * o.quantity), 2) AS total_profit
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_status = 'DELIVERED'
GROUP BY p.category
ORDER BY total_profit DESC;

-- 3. Loss-Making Products
SELECT 
    p.product_id, p.category, p.brand,
    ROUND(SUM((o.selling_price - p.cost_price) * o.quantity), 2) AS total_profit
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_status = 'DELIVERED'
GROUP BY p.product_id, p.category, p.brand
HAVING total_profit < 0
ORDER BY total_profit ASC;

-- 4. Discount Usage Overview
SELECT
    COUNT(DISTINCT d.order_id) AS discounted_orders,
    ROUND(SUM(d.discount_amount), 2) AS total_discount_amount,
    (SELECT COUNT(*) FROM orders) AS total_orders
FROM discounts d;

-- 5. Payment Method Popularity
SELECT
    o.payment_method,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.selling_price * o.quantity), 2) AS total_sales_value,
    ROUND(AVG(o.selling_price * o.quantity), 2) AS avg_order_value
FROM orders o
WHERE o.order_status = 'DELIVERED'
GROUP BY o.payment_method
ORDER BY total_orders DESC;

-- 6. Return Revenue Loss
SELECT
    COUNT(r.return_id) AS total_returns,
    ROUND(SUM(o.selling_price * o.quantity), 2) AS revenue_lost,
    ROUND(SUM((o.selling_price - p.cost_price) * o.quantity), 2) AS profit_lost
FROM returns r
JOIN orders o ON r.order_id = o.order_id
JOIN products p ON o.product_id = p.product_id;

-- 7. Product Profit Ranking
SELECT 
    p.category, p.brand,
    ROUND(SUM((o.selling_price - p.cost_price) * o.quantity), 2) AS net_profit,
    RANK() OVER (ORDER BY SUM((o.selling_price - p.cost_price) * o.quantity) DESC) AS profit_rank
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_status = 'DELIVERED'
GROUP BY p.product_id, p.category, p.brand
ORDER BY profit_rank;

-- 8. Category Margin Stability
SELECT 
    p.category,
    ROUND(AVG((o.selling_price - p.cost_price) / NULLIF(o.selling_price, 0) * 100), 2) AS avg_margin_pct,
    ROUND(STDDEV((o.selling_price - p.cost_price) / NULLIF(o.selling_price, 0) * 100), 2) AS margin_stddev
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE o.order_status = 'DELIVERED'
GROUP BY p.category
ORDER BY margin_stddev DESC;
