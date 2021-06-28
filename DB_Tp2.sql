use freedbtech_negocioRopaWeb;
-- call SP_Triggers;
show tables;
drop  table if exists control;
create table control(
	id int auto_increment primary key,
    tabla varchar(25) not null,
    accion enum('INSERT','DELETE','UPDATE'),
    fecha date,
    hora time,
    usuario varchar(50),
    idRegistro int
);


 truncate control;
-- describe control;


-- call SP_Triggers;
drop trigger if exists TR_Articulos_Insert;
drop trigger if exists TR_Articulos_Delete;
drop trigger if exists TR_Articulos_Update;



delimiter //
create trigger TR_Articulos_Insert
	after insert on articulos
    for each row
    begin
		insert into control (tabla,accion,fecha,hora,usuario,idRegistro) 
        values ('articulos','insert',current_date(),current_time(),current_user(),NEW.id);
    end;
// delimiter ;
delimiter //
create trigger TR_Articulos_Delete
	before delete on articulos
    for each row
    begin
		insert into control (tabla,accion,fecha,hora,usuario,idRegistro) 
        values ('articulos','delete',current_date(),current_time(),current_user(),OLD.id);
    end;
// delimiter ;
delimiter //
create trigger TR_Articulos_Update
	after update on articulos
    for each row
    begin
		insert into control(tabla,accion,fecha,hora,usuario,idRegistro) 
        values ('articulos','update',current_date(),current_time(),current_user(),OLD.id);
    end;
// delimiter ;
show tables;
describe articulos;
insert into articulos (descripcion,tipo,color,talle_num,stock,stockMin,stockMax,costo,precio,temporada)
values('Vestido','ROPA','rojo','1',5,20,40,100,120,'VERANO');
update articulos set color="negro" where id=14;
delete from articulos where id = 12;

select * from control;
drop  table if exists controlArticulosDelete;
create table controlArticulosDelete(
	id int auto_increment primary key,
    tabla varchar(25) not null,
    accion enum('INSERT','DELETE','UPDATE'),
    fecha date,
    hora time,
    usuario varchar(50),
    idRegistro int,
    descripcion varchar(25) not null,
	tipo enum('CALZADO','ROPA'),
	color varchar(20),
	talle_num varchar(20),
	stock int,
    stockMin int,
    stockMax int,
    costo double,
    precio double,
	temporada enum('VERANO','OTOÑO','INVIERNO')
    
);
drop trigger if exists TR_Control_Articulos_Delete;
delimiter //
create trigger TR_Control_Articulos_Delete
	before delete on articulos
    for each row
    begin
		insert into controlArticulosDelete
        (tabla,accion,fecha,hora,usuario,idRegistro,descripcion,tipo,
         color,talle_num,stock,stockMin,stockMax,costo,precio,temporada) 
        values 
        ('articulos','delete',current_date(),current_time(),current_user(),OLD.id,OLD.descripcion,OLD.tipo,
        OLD.color,OLD.talle_num,OLD.stock,OLD.stockMin,OLD.stockMax,OLD.costo,OLD.precio,OLD.temporada);
    end;
// delimiter ;
select*from articulos;
delete from articulos where id = 19;
select * from controlArticulosDelete;
select * from articulos;
select* from control;




