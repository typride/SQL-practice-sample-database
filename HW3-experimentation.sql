SELECT table_schema, table_name, table_rows
FROM information_schema.tables
WHERE TABLE_SCHEMA LIKE 'classic%';

-- SELECT * FROM CUSTOMERS WHERE country='Australia' order by city ASC
SELECT * FROM offices;

SELECT employeeNumber, lastName, firstName, extension FROM employees WHERE officeCode = '6';

SELECT productCode, productName, productVendor, quantityInStock, productLine FROM products WHERE quantityInStock > 4000 and quantityInStock < 5000;

--  SELECT productCode, productName, productVendor, buyPrice FROM products WHERE (SELECT MAX(MSRP MINUS buyPrice) from products);
 
 -- SELECT productName, MSRP, buyPrice from products WHERE productCode = (SELECT productCode FROM products WHERE MSRP = 
 
 -- 6
 SELECT customerName, country, COUNT(*) AS Customers FROM customers GROUP BY country HAVING COUNT(*) > 4;
 
 -- 7
 SELECT * from products;
 
 select * from orders;
 
 select * from orderdetails;
 
 SELECT productCode, SUM(quantityOrdered) as OrderCount from orderdetails GROUP BY productCode ORDER BY OrderCount DESC;

SELECT orderdetails.productCode, products.productName, (orderdetails.quantityOrdered) as OrderCount from orderdetails INNER JOIN products ON orderdetails.productCode=products.productCode;
 -- SELECT productCode, productName, COUNT(*) AS OrderCount FROM products 
 
 SELECT orderdetails.productCode, products.productName, MAX(orderdetails.quantityOrdered) from orderdetails INNER JOIN products ON orderdetails.productCode=products.productCode;
 
 -- SELECT from orderdetails
 SELECT orderdetails.productCode, SUM(orderdetails.quantityOrdered) as QuantityOrdered from orderdetails GROUP BY productCode ORDER BY QuantityOrdered DESC;
  
 SELECT orderdetails.productCode, SUM(orderdetails.quantityOrdered) as QuantityOrdered  from orderdetails GROUP BY productCode ORDER BY QuantityOrdered DESC;
 
 
 SELECT productName from products where productCode='S18_3232';
 
 SELECT SUM(orderdetails.quantityOrdered) AS quantityOrdered FROM orderdetails where orderdetails.productCode='S18_3232'; 
 
-- 9

SELECT lastName, firstName, employeeNumber FROM employees WHERE jobtitle = 'President';

-- 10

SELECT productName FROM products WHERE productLine = "Classic Cars" AND productName LIKE '%196%_';

-- 11

SELECT YEAR(orderDate) AS year, MONTH(orderDate) AS month , count(*) AS count FROM orders GROUP BY month ORDER BY count DESC LIMIT 2;

-- 12 

SELECT employees.firstName, employees.lastName FROM employees LEFT OUTER JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber WHERE customers.customerNumber is NULL AND employees.jobTitle = "Sales Rep";

-- 13

SELECT customers.customerName FROM customers LEFT OUTER JOIN orders ON customers.customerNumber = orders.customerNumber WHERE customers.country = "Switzerland" AND orders.orderNumber IS NULL;

-- 14 

SELECT customers.customerName, SUM(orderdetails.quantityOrdered) sumOrders FROM customers LEFT OUTER JOIN orders ON customers.customerNumber = orders.customerNumber LEFT OUTER JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber GROUP BY orders.customerNumber HAVING sumOrders < 500 ORDER BY sumOrders DESC;

-- 15

CREATE TABLE IF NOT EXISTS LowCustomers(
   CustomerNumber int NOT NULL,
   ContactDate date NOT NULL,
   OrderTotal Decimal(9,2) NOT NULL,
   CONSTRAINT LowCustomer_PK PRIMARY KEY (CustomerNumber)
);

-- 16

	INSERT INTO LowCustomers
		SELECT customers.customerNumber, Current_DATE(), SUM(orderdetails.priceEach * orderdetails.quantityOrdered)
        FROM customers, orderdetails, orders
        WHERE customers.customerNumber AND orderdetails.orderNumber = orders.orderNumber
        GROUP BY customers.customerNumber
        HAVING SUM(orderdetails.priceEach * orderdetails.quantityOrdered) < 50000;

-- 17

SELECT OrderTotal FROM LowCustomers ORDER BY OrderTotal DESC;

-- 18

	ALTER TABLE LowCustomers ADD OrderCount INT;
    
    
-- 19

UPDATE LowCustomers SET OrderCount = RAND() * 18;

-- 20

-- 3
SELECT productName, productVendor, productCode, quantityInStock, productLine FROM products WHERE quantityInStock BETWEEN 4000 AND 5000;

SELECT productName, MSRP, buyPrice, (MSRP - buyPrice) FROM products WHERE (MSRP - buyPrice) = (SELECT MIN(MSRP - buyPrice) FROM products);

