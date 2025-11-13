create database zeptonew;
use zeptonew;
create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,	
quantity INTEGER
);

select count(*) from zepto_v2;

SELECT * FROM zepto_v2
LIMIT 10;
SELECT * FROM zepto_v2
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

SELECT DISTINCT category
FROM zepto_v2
ORDER BY category;

SELECT outOfStock, COUNT(*) AS cnt
FROM zepto_v2
GROUP BY outOfStock;

SELECT name, COUNT(*) AS Number_of_SKUs
FROM zepto
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

UPDATE zepto_v2
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;
    
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
ORDER BY discountPercent DESC
LIMIT 10;

SELECT category,
       SUM(discountedSellingPrice * COALESCE(availableQuantity,0)) AS total_revenue
FROM zepto_v2
GROUP BY category
ORDER BY total_revenue DESC;

SELECT category,
       SUM(discountedSellingPrice * COALESCE(availableQuantity,0)) AS total_revenue
FROM zepto_v2
GROUP BY category
ORDER BY total_revenue DESC;

SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto_v2
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice / NULLIF(weightInGms,0), 2) AS price_per_gram
FROM zepto_v2
WHERE weightInGms >= 100
ORDER BY price_per_gram;

SELECT DISTINCT name, weightInGms,
       CASE
         WHEN weightInGms < 1000 THEN 'Low'
         WHEN weightInGms < 5000 THEN 'Medium'
         ELSE 'Bulk'
       END AS weight_category
FROM zepto_v2;

SELECT category,
       SUM(COALESCE(weightInGms,0) * COALESCE(availableQuantity,0)) AS total_weight
FROM zepto_v2
GROUP BY category
ORDER BY total_weight DESC;
