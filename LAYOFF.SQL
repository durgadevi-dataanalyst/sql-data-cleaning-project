USE LAYOFF
SELECT*FROM LAYOFFS

CREATE TABLE LAYOFFS_STAGGING LIKE LAYOFFS
INSERT LAYOFFS_STAGGING SELECT* FROM LAYOFFS

SELECT* FROM LAYOFFS_STAGGING

-- REMOVING DUPLICATES FROM LAYOFFS DATA

SELECT *,ROW_NUMBER() OVER(PARTITION BY COMPANY,LOCATION,INDUSTRY,TOTAL_LAID_OFF,PERCENTAGE_LAID_OFF, 'DATE',STAGE,COUNTRY ) AS ROW_NUM FROM LAYOFFS_STAGGING


WITH DUPLICATE_CTE AS
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY COMPANY,LOCATION,INDUSTRY,TOTAL_LAID_OFF,PERCENTAGE_LAID_OFF, 'DATE',STAGE,COUNTRY ) 
AS ROW_NUM FROM LAYOFFS_STAGGING
)
SELECT* FROM DUPLICATE_CTE WHERE ROW_NUM >1


SELECT* FROM LAYOFFS_STAGGING WHERE COMPANY='BETTER.COM';    









WITH DUPLICATE_CTE AS
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY COMPANY,LOCATION,INDUSTRY,TOTAL_LAID_OFF,PERCENTAGE_LAID_OFF, 'DATE',STAGE,COUNTRY ) 
AS ROW_NUM FROM LAYOFFS_STAGGING
)
DELETE FROM DUPLICATE_CTE WHERE ROW_NUM >1







CREATE TABLE `layoffs_stagging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;







SELECT* FROM LAYOFFS_STAGGING2

INSERT INTO LAYOFFS_STAGGING2
SELECT *,ROW_NUMBER() OVER(PARTITION BY COMPANY,LOCATION,INDUSTRY,TOTAL_LAID_OFF,PERCENTAGE_LAID_OFF, 'DATE',STAGE,COUNTRY ) 
AS ROW_NUM FROM LAYOFFS_STAGGING;

SET SQL_SAFE_UPDATES=0;
DELETE FROM LAYOFFS_STAGGING2 WHERE ROW_NUM>1;


-- STANDARDIZING DATA
SELECT COMPANY,trim(COMPANY)FROM LAYOFFS_STAGGING2

UPDATE LAYOFFS_STAGGING2 
SET COMPANY=TRIM(COMPANY);

SELECT  distinct INDUSTRY FROM LAYOFFS_STAGGING2

SELECT DISTINCT LOCATION FROM  LAYOFFS_STAGGING2 ORDER BY 1;

UPDATE LAYOFFS_STAGGING2 
SET INDUSTRY=TRIM(INDUSTRY);

select distinct country,trim(trailing '-' from country)
from layoffs_stagging2 order by 1;

update LAYOFFS_STAGGING2 set country= trim(trailing '-' from country)
where country like 'united states'

select * from LAYOFFS_STAGGING2

update LAYOFFS_STAGGING2 
set company=trim(company),
industry=trim(company),country=trim(country)

--updating the date text to date format

select `date`, str_to_date(`date`,'%m/%d/%y') 
from LAYOFFS_STAGGING2;

update LAYOFFS_STAGGING2 set `date`=str_to_date(`date`,'%m/%d/%Y') 

ALTER TABLE LAYOFFS_STAGGING2
MODIFY COLUMN `date` DATE ;
 update LAYOFFS_STAGGING2
 set country=null where country=' ';
 
 select  distinct company from LAYOFFS_STAGGING2 where company is null or company= ' ';
 
 --join
  select * from LAYOFFS_STAGGING2 t1
  join LAYOFFS_STAGGING2 t2
  on t1.company=t2.company
  and t1.location=t2.location
  where (t1.industry is null or t1.industry =' ')
  and t2.industry is not null
  
  update LAYOFFS_STAGGING2 t1
  join LAYOFFS_STAGGING2 t2
  on t1.company=t2.company
  and t1.location=t2.location
  set t1.industry= t2.industry
  where (t1.industry is null or t1.industry =' ')
  and t2.industry is not null
 
 
 select*from LAYOFFS_STAGGING2
 
 
 
 
 
 
 
 
 
 
 
 
 
 

 





