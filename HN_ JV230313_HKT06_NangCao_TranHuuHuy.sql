create database quanlisinhvien_hackathon06_NangCao;
use quanlisinhvien_hackathon06_NangCao;

create table  khoa(
Makhoa varchar(20) primary key ,
tenkhoa varchar(255)
);
create table dmnganh(
Manganh int auto_increment primary key,
tennganh varchar(255),
makhoa varchar(20),
foreign key (makhoa) references khoa(makhoa)
);
create table sinhvien(
masv int auto_increment primary key,
hoten varchar(255),
malop varchar(20),
foreign key (malop) references dmlop(malop),
gioitinh tinyint(1),
ngaysinh date,
diachi varchar(255)
);
create table diemhp(
id int auto_increment primary key ,
masv int ,
mahp int ,
foreign key (masv) references sinhvien(masv),
foreign key (mahp) references dmhocphan(mahp),
diemhp float
);
create table dmlop(
malop varchar(20) primary key,
tenlop varchar(255) ,
manganh int ,
foreign key (manganh) references dmnganh(manganh),
khoahoc int ,
hedt varchar(255),
namnhaphoc int
);
create table dmhocphan(
mahp int primary key ,
tenhp varchar(255),
sodvht int ,
manganh int,
foreign key (manganh) references dmnganh (manganh),
hocky int
);

insert into khoa (Makhoa,tenkhoa) values
('cntt','Công Nghệ Thông Tin'),
('Kt','Kế Toán'),
('Sp','Sư Phạm');

insert into dmnganh(Manganh,tennganh,makhoa) values 
(140902,'Sư Phạm Toán Tin','Sp'),
(480202,'Tin Học Ứng Dụng','CNTT');

insert into dmlop(malop,tenlop,manganh,khoahoc,hedt,namnhaphoc) values 
('Ct11','Cao Đẳng Tin Học',480202,11,'TC','2013'),
('Ct12','Cao Đẳng Tin Học',480202,12,'CD','2013'),
('Ct13','Cao Đẳng Tin Học',480202,13,'TC','2014');

insert into dmhocphan(mahp,tenhp,sodvht,manganh,hocky)values
(1,'Toán cao cấp A1',4,480202,1),
(2,'Tiếng anh 1',3,480202,1),
(3,'Vật lí đại cương',4,480202,1),
(4,'Tiếng anh 2',7,480202,1),
(5,'TIếng anh 1',3,140902,2),
(6,'Xác suất thống kê',4,480202,2);

insert into sinhvien(masv,hoten,malop,gioitinh,ngaysinh,diachi) values 
(1,'Phan Thanh','Ct12',0, '1990-09-12','Tuy Phước'),
(2,'Nguyễn Thị Cẩm ','Ct12',1, '1994-01-12','Quy Nhơn'),
(3,'Võ Thị Hà','Ct12',1, '1995-07-02','An Nhơn'),
(4,'Trần Hoài Nam','Ct12',0, '1994-04-05','Tây Sơn'),
(5,'Trần Văn Hoàng','Ct13',0, '1995-08-04','VĨnh Thạnh'),
(6,'Đặng Thị Thảo','Ct13',1, '1995-06-12','Quy Nhơn'),
(7,'Lê Thị Sen','Ct13',1, '1994-08-12','Phù Mỹ'),
(8,'Nguyễn Văn Huy','Ct11',0, '1995-06-04','Tuy Phước'),
(9,'Trần THị Hoa','Ct11',1, '1994-08-09','Hoài Nhơn');

insert into diemhp(masv,mahp,diemhp)values
(2,2,5.9),
(2,3,4.5),
(3,1,4.3),
(3,2,6.7),
(3,3,7.3),
(4,1,4),
(4,2,5.2),
(4,3,3.5),
(5,1,9.8),
(5,2,7.9),
(5,3,7.5),
(6,1,6.1),
(6,2,5.6),
(6,3,4),
(7,1,6.2);

-- 1. Cho biết họ tên sinh viên KHÔNG học học phần nào (5đ)
select masv,hoten from sinhvien
where masv not in (select distinct masv from diemhp);

-- 2.Cho biết họ tên sinh viên CHƯA học học phần nào có mã 1 (5đ)
select masv,hoten from sinhvien 
where  masv not in (select masv from diemhp where mahp = 1);

-- 3.Cho biết Tên học phần KHÔNG có sinh viên điểm HP <5. (5đ)
select mahp,tenhp from dmhocphan hp
where not exists (select 1 from diemhp dh  WHERE hp.mahp = dh.mahp AND dh.diemhp < 5);

-- 4.Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP<5 (5đ)
select masv,hoten from sinhvien 
where masv not in (select masv from diemhp where diemhp < 5);

-- 5.Cho biết Tên lớp có sinh viên tên Hoa (5đ)
select dmlop.tenlop from dmlop
join sinhvien on dmlop.malop = sinhvien.malop
where sinhvien.hoten like '%Hoa'; 

-- 6.Cho biết HoTen sinh viên có điểm học phần 1 là <5.
select hoten from sinhvien 
join diemhp on diemhp.masv = sinhvien.masv
where diemhp.mahp =1 and diemhp.diemhp < 5;

-- 7.Cho biết danh sách các học phần có số đơn vị học trình lớn hơn hoặc
--  bằng số đơn vị học trình của học phần mã 1.
select * from dmhocphan
where sodvht >= (select sodvht from dmhocphan where mahp = 1);

-- 8.Cho biết HoTen sinh viên có DiemHP cao nhất. (ALL)
select masv,HoTen
from sinhvien
where masv = all (select masv from diemhp where diemhp = (select MAX(diemhp) from diemhp));

-- 9.Cho biết MaSV, HoTen sinh viên có điểm học phần mã 1 cao nhất. (ALL)
select sv.masv ,sv.hoten 
from sinhvien sv
join diemhp dh on sv.masv = dh.masv
where dh.mahp = 1 and dh.diemhp >= all (select diemhp from diemhp where mahp = 1);

-- 10.Cho biết MaSV, MaHP có điểm HP lớn hơn bất kì các điểm HP của sinh viên mã 3 (ANY).
select dh.masv MaSV,dh.mahp MaHP
from diemhp dh
where dh.diemhp > any (select diemhp from diemhp where masv = 3);

-- 11.Cho biết MaSV, HoTen sinh viên ít nhất một lần học học phần nào đó. (EXISTS)
select masv,hoten from sinhvien
where exists (select 1 from diemhp where sinhvien.masv = diemhp.masv );

-- 12.Cho biết MaSV, HoTen sinh viên đã không học học phần nào. (EXISTS)
select masv,hoten from sinhvien
where not exists (select 1 from diemhp where sinhvien.masv = diemhp.masv );

-- 13.Cho biết MaSV đã học ít nhất một trong hai học phần có mã 1, 2. 
select masv MaSV
from diemhp
where mahp = 1
union
select masv MaSV
from diemhp
where mahp = 2;

-- 14.Tạo thủ tục có tên KIEM_TRA_LOP cho biết 
-- HoTen sinh viên KHÔNG có điểm HP <5 ở lớp có mã chỉ định 
-- (tức là tham số truyền vào procedure là mã lớp).
--  Phải kiểm tra MaLop chỉ định có trong danh mục hay không, 
--  nếu không thì hiển thị thông báo ‘Lớp này không có trong danh mục’. 
--  Khi lớp tồn tại thì đưa ra kết quả.
-- Ví dụ gọi thủ tục: Call KIEM_TRA_LOP(‘CT12’).
DELIMITER //
create procedure KIEM_TRA_LOP(in ma_lop varchar(20))
begin
    declare lop_count int;
    select COUNT(*) into lop_count from dmlop where malop = ma_lop;
    if lop_count = 0 then
        select 'Lớp này không có trong danh mục' as Result;
    else
        select sv.hoten as HoTen
        from sinhvien as sv
        where sv.malop = ma_lop
        and not exists (select 1 from diemhp as dh where sv.masv = dh.masv and dh.diemhp < 5);
   end if;
end //
DELIMITER ;

-- 15.Tạo một trigger để kiểm tra tính hợp lệ của dữ liệu nhập vào bảng 
-- sinhvien là MaSV không được rỗng  Nếu rỗng hiển thị thông báo ‘Mã sinh viên phải được nhập’.
DELIMITER //
create trigger tr_check_msv_not_empty
before insert on sinhvien
for each row
begin
    if new.masv is null or new.masv = '' then
        signal sqlstate '45000' set MESSAGE_TEXT = 'Mã sinh viên phải được nhập';
    end if;
end //
DELIMITER ;

-- 16.Tạo một TRIGGER khi thêm một sinh viên trong bảng sinhvien ở một lớp nào đó thì cột SiSo 
-- của lớp đó trong bảng dmlop (các bạn tạo thêm một cột SiSo trong bảng dmlop) tự động tăng
--  lên 1, đảm bảo tính toàn vẹn dữ liệu khi thêm một sinh viên mới trong bảng sinhvien thì
--  sinh viên đó phải có mã lớp trong bảng dmlop. Đảm bảo tính toàn vẹn dữ liệu khi thêm là
--  mã lớp phải có trong bảng dmlop.
DELIMITER //
create trigger tr_update_siso
after insert on sinhvien
for each row
begin
    declare class_count int;
    select COUNT(*) into class_count from dmlop where malop = new.malop;
    if class_count = 0 then
        signal sqlstate '45000' set MESSAGE_TEXT = 'Mã lớp không tồn tại trong bảng dmlop';
    else
        update dmlop
        set siso = siso + 1
        where malop = new.malop;
    end if;
end //
DELIMITER ;

-- 17.	Viết một function DOC_DIEM đọc điểm chữ số thập phân thành chữ  Sau đó ứng dụng để lấy ra:
--  MaSV, HoTen, MaHP, DiemHP, DOC_DIEM(DiemHP) để đọc điểm HP của sinh viên đó thành chữ
-- Tạo hàm DOC_DIEM để chuyển điểm số thành chữ
delimiter //
create function DOC_DIEM(p_diem float) returns varchar(255)
deterministic
begin
    declare v_integer_part int;
    declare v_decimal_part int;
    declare v_result varchar(255);
    set v_integer_part = floor(p_diem);
    set v_decimal_part = round((p_diem - v_integer_part) * 10);
    set v_result = concat(cast(v_integer_part as char), ' phẩy ', cast(v_decimal_part as char), ' điểm');
    return v_result;
end //
delimiter ;
select
    sv.masv as MaSV,
    sv.hoten as HoTen,
    dh.mahp as MaHP,
    dh.diemhp as DiemHP,
    DOC_DIEM(dh.diemhp) as DiemHP_Text
from
    sinhvien as sv
join diemhp as dh on sv.masv = dh.masv;


-- 18.Tạo thủ tục: HIEN_THI_DIEM Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, MaHP 
-- của những sinh viên có DiemHP nhỏ hơn số chỉ định, nếu không có thì hiển thị thông báo 
-- không có sinh viên nào.
DELIMITER //
CREATE PROCEDURE HIEN_THI_DIEM(IN diem_threshold FLOAT)
BEGIN
    DECLARE num_rows INT;
    SELECT COUNT(*) INTO num_rows
    FROM sinhvien AS sv
    JOIN diemhp AS dh ON sv.masv = dh.masv
    WHERE dh.diemhp < diem_threshold;
    IF num_rows > 0 THEN
        SELECT sv.masv MaSV,sv.hoten HoTen,sv.malop MaLop,dh.diemhp DiemHP,dh.mahp MaHP
        FROM
            sinhvien sv
        JOIN diemhp dh ON sv.masv = dh.masv
        WHERE dh.diemhp < diem_threshold;
    ELSE
        SELECT 'Không có sinh viên nào có điểm HP nhỏ hơn ' Message;
    END IF;
END //
DELIMITER ;
Call HIEN_THI_DIEM(3);

-- 19.Tạo thủ tục: HIEN_THI_MAHP hiển thị HoTen sinh viên CHƯA học học phần có mã chỉ định. 
-- Kiểm tra mã học phần chỉ định có trong danh mục không. Nếu không có thì hiển thị thông báo
--  không có học phần này.
DELIMITER //
CREATE PROCEDURE HIEN_THI_MAHP(IN mahp_chidinh INT)
BEGIN
    DECLARE num_rows INT;
    SELECT COUNT(*) INTO num_rows
    FROM dmhocphan
    WHERE mahp = mahp_chidinh;
    IF num_rows = 0 THEN
        SELECT 'Không có học phần có mã ' Message, mahp_chidinh MaHP;
    ELSE
        SELECT
            sv.hoten HoTen
        FROM
            sinhvien sv
        WHERE sv.masv NOT IN (
            SELECT masv
            FROM diemhp
            WHERE mahp = mahp_chidinh
        );
    END IF;
END //
DELIMITER ;
Call HIEN_THI_MAHP(2);

-- 20.Tạo thủ tục: HIEN_THI_TUOI  Hiển thị danh sách gồm:
--  MaSV, HoTen, MaLop, NgaySinh, GioiTinh, Tuoi của sinh viên có tuổi trong khoảng chỉ định.
--  Nếu không có thì hiển thị không có sinh viên nào.
DELIMITER //
create procedure HIEN_THI_TUOI(in tuoi_min int, in tuoi_max int)
begin
    declare num_rows int;
    select COUNT(*) into num_rows
    from sinhvien
    where year(CURDATE()) - year(ngaysinh) between tuoi_min and tuoi_max;
    if num_rows = 0 then
        select 'Không có sinh viên nào trong độ tuổi từ '
        as Message, tuoi_min as TuoiMin, ' đến ' as Message, tuoi_max as TuoiMax;
    else
        select masv as MaSV,hoten as HoTen,malop as MaLop,ngaysinh as NgaySinh,
            case gioitinh when 0 then 'Nam' else 'Nữ' end as GioiTinh,
            year(CURDATE()) - year(ngaysinh) as Tuoi
        from
            sinhvien
        where year(CURDATE()) - year(ngaysinh) between tuoi_min and tuoi_max;
    end if ;
end //
DELIMITER ;
Call HIEN_THI_TUOI (20,30);