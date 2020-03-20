SET SERVEROUTPUT ON;
create or replace procedure cus2(am in number)
	is

	


 c_id   customer.customer_id%Type ; 
c_name  customer.customer_name%Type;
c_no    customer.contact_no%Type ;	
brn_id	   customer.branch_id%Type;



	bill_id int;
	date_recorded date;
        amount int;
	product_id int;
        customer_id int;
        employee_id int;
	payment_type varchar(30);
	branch_id int;

 pur number;
    
   



	cursor hello1 is
	
   SELECT c.customer_id,SUM(b.amount) 
   FROM BILLS b join
   CUSTOMER c 
   on c.customer_id=b.customer_id
   where date_recorded ='&date'
   GROUP BY c.customer_id 
   HAVING MAX(amount)>=&amount
order by  MAX(b.amount) desc;

   
      

	BEGIN
	OPEN hello1;
	dbms_output.put_line('CustomerID'||'            '||'PurchaseAmount');
	DBMS_OUTPUT.NEW_LINE;
	

	loop

		fetch hello1 into  c_id ,pur;
		dbms_output.put_line(c_id||'                    '||pur);
                exit when hello1%notfound;

	end loop;
	CLOSE hello1;
	EXCEPTION
	WHEN no_data_found THEN 
      dbms_output.put_line('No such data found!');
     WHEN others THEN
      dbms_output.put_line('Other error occured!');
	end cus2;
	/