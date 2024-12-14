-- Encontrar el número de artículos en el menú.
SELECT COUNT(*) AS total_items
FROM menu_items;

SELECT * FROM menu_items;
SELECT * FROM order_details;
--
-- ¿Cuál es el artículo menos caro y el más caro en el menú?
SELECT item_name, price
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items);


-- ¿Cuántos platos americanos hay en el menú?
SELECT COUNT(*) AS total_American
FROM menu_items
WHERE category = 'American';



-- ¿Cuál es el precio promedio de los platos?
SELECT AVG(price) AS precio_promedio
FROM menu_items;

-------------------------

-- ¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT(DISTINCT order_id) AS total_pedidos
FROM order_details;


-- ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
SELECT order_id, COUNT(item_id) AS total_articulos
FROM order_details
GROUP BY order_id
ORDER BY total_articulos DESC
LIMIT 5;

SELECT * FROM order_details

-- ¿Cuándo se realizó el primer pedido y el último pedido?
SELECT 
    MIN(order_date) AS primer_pedido_fecha,
    MIN(order_time) AS primer_pedido_hora,
    MAX(order_date) AS ultimo_pedido_fecha,
    MAX(order_time) AS ultimo_pedido_hora
FROM order_details;


-- ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
SELECT COUNT(DISTINCT order_id) AS total_pedidos
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';


-- Realizar un left join entre order_details y menu_items con el identificador
--item_id(tabla order_details) y menu_item_id(tabla menu_items).
SELECT 
    od.order_id,
    od.order_date,
    od.order_time,
    od.item_id,
    mi.menu_item_id,
    mi.item_name,
    mi.category,
    mi.price
FROM order_details od
LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id;



--Realizar un análisis adicional utilizando este join entre las tablas. 
--El objetivo es identificar 5 puntos clave que puedan ser de utilidad
--para los dueños del restaurante en el lanzamiento de su nuevo menú.

--Query para conocer que platillos son los más pedidos por los clientes:
SELECT mi.item_name, COUNT(od.item_id) AS veces_solicitado
FROM order_details od
LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
GROUP BY mi.item_name
ORDER BY veces_solicitado DESC
LIMIT 10;


--Query para conocer que platillos son los que menos se venden:
SELECT mi.item_name, COUNT(od.item_id) AS veces_solicitado
FROM order_details od
LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
GROUP BY mi.item_name
ORDER BY veces_solicitado ASC
LIMIT 10;


--Para los dueños del restaurante es importante saber que platillos 
--son los más vendidos o menos vendidos, de esta manera podrán tener un estimado de ventas
--según los platillos y tomar decisiones sobre que platillos pueden mejorar o ser eliminados del
--menú y hacer más atractivos los platillos y atraer a más clientes.
