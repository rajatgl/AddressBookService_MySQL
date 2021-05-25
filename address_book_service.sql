#UC1: create address book db
create database if not exists address_book_service;

#UC2: create address table
use address_book_service;
select database();
create table if not exists address_book(
addressId int not null unique auto_increment,
firstname varchar(10),
lastname varchar(10),
address varchar(100),
city varchar(10),
state varchar(3),
pincode int8,
phone varchar(10) unique,
email varchar(50) unique,
primary key(addressid));

#UC3: insert contacts into table
insert into address_book(firstname,lastname,address,
city,state,pincode,phone,email) value
('rajat','gundi','shahu park,rajendranager',
'kolhapur','MH','416004','8496942482','glrajat@gmail.com');
insert into address_book(firstname,lastname,address,
city,state,pincode,phone,email) values
('rakshit','gundi','shahu park,rajendranager',
'kolhapur','MH','416004','8496942480','glrakshit@gmail.com'),
('sanjay','gowd','shahu park,rk colony',
'pune','MH','327004','8975756110','sanjgwd@msn.com');
select*from address_book;

#UC4: ability to edit existing contact using name
update address_book set address = 'shahu park, rajkumar colony' where firstname = 'sanjay'
 and lastname = 'gowd';
select*from address_book;

#UC5: ability to delete contact using name
delete from address_book where firstname = 'sanjay';

#UC6: fetch persons belonging to same city
select*from address_book where city = 'kolhapur';

#UC7: size of addressbook by count
select count(city) as BOOK_SIZE from address_book;    #2

#UC8: select sorted entries by name
select*from address_book order by firstname;
select*from address_book order by firstname desc;

#UC9: alter addressbook to include type of contact
alter table address_book add `contact type` varchar(10) after addressId;
update address_book set `contact type` = 'Family' where `lastname` = 'gundi';

insert into address_book(`contact type`,`firstname`,`lastname`,`address`,
`city`,`state`,`pincode`,`phone`,`email`) value
('Office','sanjay','gowd','shahu park,rk colony',
'pune','MH','327004','8975756110','sanjgwd@msn.com');

#UC10: get contact count by type
select count(`addressId`) as 'FAMILY COUNT'
 from address_book where `contact type` = 'Family';      #2

#UC11: add person to both friend and family
alter table address_book drop column `contact type`;

create table if not exists contact_table
 (`addressId` int not null,
 `contact type` varchar(10) not null,
 foreign key(`addressId`) references address_book(`addressId`)
 on delete cascade);

#assigning 'rajat' as both friend and family 
 insert into contact_table values ('1','Friend'),('2','Family'),('1','Family');
 
 select `firstname` as 'FirstName',`lastname`as 'LastName' from address_book inner join contact_table
 where contact_table.addressId = address_book.addressId
 and contact_table.`contact type`='Family'; 
 
 
 










