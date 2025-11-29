-- Day 15/50 SQL Challenge 


-- Creating the orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

-- Inserting records for the current month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
('2025-01-05', 101, 2, 499.99),
('2025-01-11', 102, 1, 299.50),
('2025-01-20', 103, 3, 199.00),
('2025-01-25', 101, 1, 499.99),
('2025-01-30', 104, 5, 149.25),

('2025-02-03', 101, 1, 499.99),
('2025-02-08', 102, 2, 299.50),
('2025-02-12', 103, 1, 199.00),
('2025-02-16', 104, 3, 149.25),
('2025-02-27', 105, 4, 249.75),

('2025-03-01', 101, 3, 499.99),
('2025-03-05', 102, 1, 299.50),
('2025-03-10', 103, 2, 199.00),
('2025-03-18', 104, 4, 149.25),
('2025-03-22', 105, 2, 249.75);



/*

Write an SQL query to retrieve the product details for items whose revenue 
decreased compared to the previous month. 

Display the product ID, quantity sold, 
and revenue for both the current and previous months.

*/
-- ---------------
-- MY Solution
-- ---------------


-- product_id total sale for current
-- current month
-- group by product_id

SELECT * FROM orders;

WITH current_month_revenue
AS
(    
    SELECT
        product_id,
        SUM(quantity) as qty_sold,
        SUM(price * quantity) as current_month_rev
    FROM orders
    WHERE EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM CURRENT_DATE) 
    GROUP BY product_id
),
prev_month_revenue
AS    
(
    SELECT
        product_id,
        SUM(quantity) as qty_sold,
        SUM(price * quantity) as prev_month_rev
    FROM orders
    WHERE EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM CURRENT_DATE)-1 
    GROUP BY product_id
)

SELECT
    cr.product_id,
    cr.qty_sold as cr_month_qty,
     pr.qty_sold as pr_month_qty,
    cr.current_month_rev,
    pr.prev_month_rev
FROM current_month_revenue as cr
JOIN 
prev_month_revenue as pr
ON cr.product_id = pr.product_id
WHERE cr.current_month_rev < pr.prev_month_rev









-- Task: Write a SQL query to find the products whose total revenue has decreased by more than 10% from the previous month to the current month.





