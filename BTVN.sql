create database bai_tap;
use bai_tap;
create table CTPXuat(
SOPX int,
MAVTU varchar(15),
SLXUAT int not null,
DGXUAT double not null,
foreign key(SOPX) references PXUAT(SOPX),
foreign key(MAVTU) references VATTU(MAVTU)
);
insert into CTPXuat values(10,'VATTU1',100,150000);
insert into CTPXuat values(15,'VATTU2',200,200000);
insert into CTPXuat values(20,'VATTU3',300,250000);
insert into CTPXuat values(25,'VATTU4',400,300000);
insert into CTPXuat values(30,'VATTU5',500,350000);

create table PXUAT(
SOPX int not null primary key,
NGAYXUAT date not null,
TENKH varchar(30) not null
);

insert into PXUAT values(10,'2020/10/5','KE ANH');
insert into PXUAT values(15,'2020/10/7','ABC');
insert into PXUAT values(20,'2020/12/8','DUY');
insert into PXUAT values(25,'2020/9/20','HIEU');
insert into PXUAT values(30,'2020/1/27','HA');

create table VATTU(
MAVTU varchar(15) not null primary key,
TENVTU varchar(30) not null,
DVTINH text not null,
PHANTRAM text not null
);

insert into VATTU values('VATTU1','QUAN','1000','5%');
insert into VATTU values('VATTU2','AO','5000','9%');
insert into VATTU values('VATTU3','DEP','2000','15%');
insert into VATTU values('VATTU4','TUI','3000','4%');
insert into VATTU values('VATTU5','MU','8000','7%');

create table TONKHO(
NAMTHANG date not null primary key,
MAVTU varchar(15),
SLDAU int not null,
TONGSLN int not null,
TONGSLX int not null,
SLCUOI int not null,
foreign key(MAVTU) references VATTU(MAVTU)
);

insert into TONKHO values('2020/4/27','VATTU1',1000,20000,15000,5000);
insert into TONKHO values('2020/5/15','VATTU2',100,50000,16000,7000);
insert into TONKHO values('2020/6/10','VATTU3',5000,10000,78000,8000);
insert into TONKHO values('2020/7/22','VATTU4',10000,30000,65000,2000);
insert into TONKHO values('2020/8/30','VATTU5',3000,80000,43000,3000);

create table CTDONDH(
SODH int,
MAVTU varchar(15),
SLDAT int not null,
foreign key(SODH) references DONDH(SODH),
foreign key(MAVTU) references VATTU(MAVTU)
);
insert into CTDONDH values(1,'VATTU1',10);
insert into CTDONDH values(2,'VATTU2',15);
insert into CTDONDH values(3,'VATTU3',20);
insert into CTDONDH values(4,'VATTU4',25);
insert into CTDONDH values(5,'VATTU5',30);

create table DONDH(
SODH int not null primary key,
NGAYDH date not null,
MANHACC int,
foreign key(MANHACC) references NHACC(MANHACC)
);

insert into DONDH values(1,'2020/5/2',1);
insert into DONDH values(2,'2020/6/12',2);
insert into DONDH values(3,'2020/7/20',3);
insert into DONDH values(4,'2020/8/4',4);
insert into DONDH values(5,'2020/9/29',5);

create table CTPNHAP(
SOPN int,
MAVTU varchar(15),
SLNHAP int not null,
DGNHAP int not null,
foreign key (SOPN) references PNHAP(SOPN),
foreign key (MAVTU) references VATTU(MAVTU)
);
insert into CTPNHAP values(1,'VATTU1',15,20000);
insert into CTPNHAP values(2,'VATTU2',20,30000);
insert into CTPNHAP values(3,'VATTU3',25,40000);
insert into CTPNHAP values(4,'VATTU4',30,50000);
insert into CTPNHAP values(5,'VATTU5',35,60000);

create table PNHAP(
SOPN int not null primary key,
NHAPNHAP date not null,
SODH int,
foreign key(SODH) references DONDH(SODH)
);
insert into PNHAP values(1,'2020/5/20',1);
insert into PNHAP values(2,'2020/6/12',2);
insert into PNHAP values(3,'2020/7/3',3);
insert into PNHAP values(4,'2020/8/19',4);
insert into PNHAP values(5,'2020/9/15',5);

create table NHACC(
MANHACC int not null primary key,
TENNHACC varchar(50) not null,
DIACHI text not null,
DIENTHOAI text not null
);

insert into NHACC values(1,'ABC','HA NOI','0879657565');
insert into NHACC values(2,'FD','HCM','0879657565');
insert into NHACC values(3,'YTR','DA NANG','0879657565');
insert into NHACC values(4,'OIP','VINH','0879657565');
insert into NHACC values(5,'QWE','DA LAT','0879657565');

create view vw_CTPNHAP as select SOPN,MAVTU,SLNHAP,DGNHAP,sum(DGNHAP) from CTPNHAP group by MAVTU;
create view vw_CTPNHAP_V as select SOPN,VATTU.MAVTU,VATTU.TENVTU,SLNHAP,DGNHAP,sum(DGNHAP) from CTPNHAP join VATTU on CTPNHAP.MAVTU = VATTU.MAVTU group by TENVTU;
create view vw_CTPNHAP_loc as select SOPN,MAVTU,SLNHAP,DGNHAP,sum(DGNHAP) from CTPNHAP where SLNHAP > 5 group by MAVTU;

DELIMITER $$
USE `bai_tap`$$
CREATE PROCEDURE tong_so_luong_cuoi (in mavtu1 varchar(15))
BEGIN
select SLCUOI from tonkho where MAVTU = mavtu1;  
END$$
DELIMITER ;
select SLCUOI from tonkho where MAVTU = 'VATTU2'; 
call tong_so_luong_cuoi('VATTU2');

drop procedure tong_so_luong_cuoi;

DELIMITER $$
USE `bai_tap`$$
CREATE PROCEDURE `tong_so_tien_xuat` (mavtu1 varchar(15))
BEGIN
select sum(DGXUAT*SLXUAT) from CTPXuat where MAVTU = mavtu1;  
END$$
DELIMITER ;

call tong_so_tien_xuat('VATTU2');

DELIMITER $$
USE `bai_tap`$$
CREATE PROCEDURE `tong_so_don_dat_hang` (sodh1 int)
BEGIN
select SLDAT from CTDONDH where SODH = sodh1;  
END$$
DELIMITER ;

call tong_so_don_dat_hang(3);

DELIMITER $$
USE `bai_tap`$$
CREATE PROCEDURE `them_don_dat_hang` (sodh int,ngaydh date,manhacc int)
BEGIN
  insert into DONDH values(sodh,ngaydh,manhacc);
END$$
DELIMITER ;

call them_don_dat_hang(6,'2020/1/14',1);

DELIMITER $$
USE `bai_tap`$$
CREATE PROCEDURE `them_chi_tiet_don_dat_hang` (sodh int,mavtu varchar(15),sldat int)
BEGIN
  insert into CTDONDH values(sodh,mavtu,sldat);
END$$
DELIMITER ;

call them_chi_tiet_don_dat_hang(6,'VATTU2',100);