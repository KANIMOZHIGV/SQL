Select * from Projects..CovidDeaths$
where continent is not null
order by 3,4

--selecting the data that we are going to be using

Select Location,date, total_cases, new_cases, total_deaths, population 
from Projects..CovidDeaths$
order  by 1,2
 

--Looking at Total Cases vs Total Deaths
Select Location,date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from Projects..CovidDeaths$
where location like 'India'
order  by 1,2

--Looking at Total Cases Vs Population
--Shows what percentage of poopulation affected by covid
Select Location,date,population, total_cases,(total_cases/population)*100 as PopulationPercentage
from Projects..CovidDeaths$
where location like 'India'
order  by 1,2

--Looking at countries with highest infection rate compared to population
Select Location,population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from Projects..CovidDeaths$
Group by location,population
order  by	PercentPopulationInfected desc


--Highest infection rate in India
Select Location,population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from Projects..CovidDeaths$
where location like 'India'
Group by location,population
order  by	PercentPopulationInfected desc

--showing countries with highest death count per population

Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
from Projects..CovidDeaths$
where continent is not null
Group by location,population
order  by TotalDeathCount desc

-- By Continent
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from Projects..CovidDeaths$
where continent is not null
Group by continent
order  by TotalDeathCount desc

--Global numbers
Select SUM(new_cases) as total_cases ,SUM(cast(new_deaths as int)) as total_deaths,sum(cast(new_deaths as int))/SUM(new_cases)*100 as deathPercentage
from Projects..CovidDeaths$
where continent is not null
order by 1,2

--Total population vs Vaccinations
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
from Projects..CovidDeaths$ dea
join Projects..CovidVaccinations$ vac
    On dea.location=vac.location
	and dea.date=vac.date
where dea.continent is not null
order by 2,3

