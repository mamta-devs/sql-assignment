CREATE TABLE Customers2 (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO Customers2 (customer_id, name, city)
VALUES
(1, 'A', 'Delhi'),
(2, 'B', 'Mumbai'),
(3, 'C', 'Pune');

SELECT * FROM Customers2;


DROP TABLE  IF EXISTS Orders2;
CREATE TABLE Orders2 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers2(customer_id)
);


INSERT INTO Orders2 (order_id, customer_id, product, quantity, price, order_date)
VALUES
(101, 1, 'Laptop', 1, 50000, '2025-01-10'),
(102, 1, 'Mouse', 2, 800, '2025-01-12'),
(103, 2, 'Laptop', 1, 50000, '2025-02-15'),
(104, 3, 'Keyboard', 1, 1500, '2025-03-20'),
(105, 2, 'Mouse', 3, 800, '2025-03-25');

SELECT *  FROM Orders2;

--Section A – Basic (2 marks each)

--Q1. Display all customers.
SELECT * FROM Customers2;

--Q2. Show only customers from Mumbai.
SELECT * FROM Customers2
WHERE city='Mumbai';

--Q3. Display all orders where quantity is greater than 1.
SELECT * FROM Orders2
WHERE quantity>1;

--Q4. Find the total number of orders.
SELECT COUNT(*) AS Total_Orders
FROM Orders2;

--Q5. Show all unique products.
SELECT DISTINCT(product)
FROM Orders2;



--Section B – Intermediate (5 marks each)

--Q6. Find the total sales amount for each order (quantity × price).
SELECT order_id,
       quantity,
       price,
       (quantity * price) AS Total_Sales
FROM Orders2;


--Q7. Find the total revenue generated.
SELECT SUM(quantity * price) AS Total_Revenue
FROM Orders2;


--Q8. Find the top-selling product based on total quantity sold.
SELECT SUM(quantity) AS total_quantity,product
FROM Orders2
GROUP BY product 
ORDER BY total_quantity DESC LIMIT 1;

--Q9. Show customer names along with the products they ordered.
SELECT c.name,o.product,o.quantity
FROM Customers2 c
JOIN Orders2 o ON c.customer_id=o.customer_id;


--Q10. Find total spending by each customer.
SELECT SUM(o.price* o.quantity) AS Total_spend,c.customer_id,c.name
FROM Orders2 o
JOIN Customers2 c ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.name;



--Section C – Interview Level (10 marks each)

--Q11. Find the customer who spent the most.
SELECT SUM(o.price*o.quantity) AS Total_spend,c.customer_id,c.name
FROM Orders2 o
JOIN Customers2 c ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.name ORDER BY Total_spend DESC LIMIT 1;

--Q12. Find monthly sales.
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(quantity * price) AS monthly_sales
FROM Orders2
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

--Q13. Show customers who have placed more than one order.
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM Orders2
GROUP BY customer_id
HAVING COUNT(order_id) > 1;


--Q14. Find the average order value.

SELECT AVG(quantity * price) AS Average_Order_Value
FROM Orders2;



--Q15. Rank customers based on their total spending.
SELECT c.customer_id,
       c.name,
       SUM(o.quantity * o.price) AS Total_Spend,
       RANK() OVER (ORDER BY SUM(o.quantity * o.price) DESC) AS Customer_Rank
FROM Customers2 c
JOIN Orders2 o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;


SELECT * FROM Customers2;
SELECT *  FROM Orders2;



