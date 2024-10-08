-- Exploratory Data Analysis

select *
from layoffs_staging2;


select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

Select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2;

Select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select *
from layoffs_staging2;

Select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

Select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

Select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


Select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
;

With rolling_total as
(
Select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off 
,sum(total_off) over(order by `month`) as rolling_total
from rolling_total;

Select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

Select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
Order by company asc
;

Select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
Order by 3 desc
;

With Company_year (Company, Years, Total_laid_off) As
(
Select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
Order by 3 desc
), Company_Year_Rank as
(Select *,
Dense_rank() over (partition by years order by total_laid_off desc) as Ranking
from Company_year
where years is not null
)
Select *
From Company_Year_Rank
Where Ranking <= 5
;
