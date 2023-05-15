CREATE VIEW listar_vendedor AS
    SELECT 
        v.ID_VENDEDOR AS 'ID Vendedor',
        v.NOMBRE AS 'Nombre Vendedor',
        o.ID_ORDEN AS 'CODIGO DE ORDEN',
        o.VALOR AS 'Valor',
        o.FECHA_PEDIDO AS 'Fecha de pedido'
    FROM
        vendedores as v
        JOIN facturas as f ON v.ID_VENDEDOR = f.ID_VENDEDOR
        JOIN ordenes as o ON o.ID_ORDEN = f.ID_ORDEN;
select * from listar_vendedor;

DELIMITER //
CREATE PROCEDURE ACTUALIZAR()
BEGIN
UPDATE vendedores SET FECHA_ACTUALIZACION = CURDATE();
END //
DELIMITER ;

CALL ACTUALIZAR();

select * from vendedores;

delimiter //
create trigger vendedores_duplicados
before insert on vendedores for each row
begin
if(exists(select 1 from vendedores where ID_VENDEDOR = new.ID_VENDEDOR)) then signal sqlstate value '4500'set message_text = 'el vendedor se encuentra ya registrado';
end if;
end//
delimiter ;

INSERT INTO `tienda`.`vendedores` (`ID_VENDEDOR`, `NOMBRE`, `DIRECCION`, `FECHA_DE_NACIMIENTO`, `SUELDO`, `TELEFONO`, `EMAIL`, `FECHA_ACTUALIZACION`) VALUES ('2001', 'jj', 'fdghf', '1999-01-01', '4645645', '45645645', 'gfhfdd', '2023-03-18');
show triggers;

select * from producto_factura;
delimiter //
create procedure punto_cuatro()
begin
declare fin int default 0;
declare PRODUCTO_ID int;
declare TOTAL int;
declare cursor_TOTAL cursor for select CANTIDAD * PRECIO from producto_factura;
declare cursor_ID_PRODUCTO cursor for select ID_PRODUCTO from producto_factura;
declare continue handler for not found set fin = 1;

open cursor_ID_PRODUCTO;
open cursor_TOTAL;

multiplicacion: loop
fetch cursor_TOTAL into TOTAL;
fetch cursor_ID_PRODUCTO into PRODUCTO_ID;
if fin = 1 then leave multiplicacion;
end if;
select PRODUCTO_ID,TOTAL;
end loop multiplicacion;

close cursor_ID_PRODUCTO; 
close cursor_TOTAL;
end //

delimiter ;

call punto_cuatro();


CREATE tablespace dfVentas
add datafile 'dfventas.ibd' ENGINE=InnoDB;

CREATE TABLESPACE dffacturas
ADD DATAFILE 'dffacturas.ibd'
ENGINE = INNODB
INITIAL_SIZE = 1M
MAX_SIZE = 1400K
EXTENT_SIZE = 16K
;

CREATE TABLESPACE dfordenes
ADD DATAFILE 'dfordenesas.ibd'
ENGINE = INNODB
INITIAL_SIZE = 1M
MAX_SIZE = 1400K
EXTENT_SIZE = 16K
;

CREATE USER 'ZinedineU'@'localhost' IDENTIFIED BY 'Ingzine93*';

GRANT CREATE SESSION ON tienda TO 'ZinedineU'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON tienda.vendedores TO 'MI_PROPIO_ROL';
CREATE USER 'Ventas10'@'localhost' IDENTIFIED BY 'Ventas10*'; 
GRANT ALL PRIVILEGES ON tienda TO 'Ventas10'



