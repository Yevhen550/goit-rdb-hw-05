====================================


SELECT 
  od.*, 
  (SELECT o.customer_id 
   FROM orders o 
   WHERE o.id = od.order_id) AS customer_id
FROM order_details od;


====================================


SELECT * 
FROM order_details od
WHERE od.order_id IN (
  SELECT o.id 
  FROM orders o 
  WHERE o.shipper_id = 3
);


===================================


SELECT 
  sub.order_id,
  AVG(sub.quantity) AS avg_quantity
FROM (
  SELECT * 
  FROM order_details
  WHERE quantity > 10
) AS sub
GROUP BY sub.order_id;

===================================

WITH temp AS (
  SELECT * 
  FROM order_details 
  WHERE quantity > 10
)
SELECT 
  order_id,
  AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;


=================================


DROP FUNCTION IF EXISTS divide_quantity;

DELIMITER //

CREATE FUNCTION divide_quantity(a FLOAT, b FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
  RETURN a / b;
END;
//

DELIMITER ;

SELECT 
  id,
  product_id,
  quantity,
  divide_quantity(quantity, 2.0) AS half_quantity
FROM order_details;
