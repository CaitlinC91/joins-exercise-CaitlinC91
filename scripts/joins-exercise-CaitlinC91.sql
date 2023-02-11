-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT film_title, release_year, revenue.worldwide_gross
FROM specs
INNER JOIN  revenue
USING (movie_id)
ORDER BY worldwide_gross
LIMIT 1;

-- Semi-Tough, 1977, 37187139

-- 2. What year has the highest average imdb rating?

SELECT release_year
FROM specs
INNER JOIN rating
USING (movie_id)
ORDER BY imdb_rating DESC
LIMIT 1;

-- 2008

-- 3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT film_title, distributors
FROM specs
INNER JOIN revenue
USING (movie_id)
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;

--Toy Story 4, Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT company_name, COUNT(t2.film_title)
FROM distributors AS t1
LEFT JOIN specs AS t2
ON t1.distributor_id = t2.domestic_distributor_id
GROUP BY company_name;

-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT t1.company_name, AVG(t2.film_budget) AS avg_budget
FROM distributors AS t1
INNER JOIN specs
ON t1.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue AS t2
ON specs.movie_id = t2.movie_id
GROUP BY t1.company_name
ORDER BY avg_budget DESC
LIMIT 5;


-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT company_name, film_title, COUNT(t1.movie_id), MAX(rating.imdb_rating)
FROM specs AS t1
INNER JOIN distributors AS t2
ON t1.domestic_distributor_id = t2.distributor_id 
INNER JOIN rating
USING(movie_id)
WHERE t2.headquarters NOT LIKE '%CA%'
GROUP BY company_name, film_title;

-- 2 movies, Dirty Dancing has highest imdb rating

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT COUNT(length_in_min), AVG(imdb_rating)
FROM specs
FULL JOIN rating
USING(movie_id)
WHERE length_in_min >120

UNION

SELECT COUNT(length_in_min), AVG(imdb_rating)
FROM specs
FULL JOIN rating
USING(movie_id)
WHERE length_in_min <120

-- Movies over 2 hours have higher rating




