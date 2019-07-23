IF OBJECT_ID('MovieActor') IS NOT NULL DROP TABLE MovieActor;
IF OBJECT_ID('Movie') IS NOT NULL DROP TABLE Movie;
IF OBJECT_ID('Actor') IS NOT NULL DROP TABLE Actor; 
 

/****** Object:  Table [dbo].[Movie]    ******/

CREATE TABLE [dbo].[Movie](
	[movieId] [int] NOT NULL,
	[title] [char](1000) NULL,
	[yearReleased] [smallint] NULL,
	[totalRevenue] [float] NULL
	constraint moviePk Primary Key ([movieId])
);

/****** Object:  Table [dbo].[Actor]    ******/

CREATE TABLE [dbo].[Actor](
	[actorId] [int] NOT NULL,
	[name] [char](50) NULL,
	[agentPhone] [text] NULL
	constraint actorPk Primary Key ([actorId])
);

/****** Object:  Table [dbo].[MovieActor]   ******/

CREATE TABLE [dbo].[MovieActor](
	[movieId] [int] NOT NULL,
	[actorId] [int] NOT NULL
	constraint MovieActorCPk Primary Key ([movieId],[actorId]),
	constraint movieIdFk Foreign Key ([movieId]) REFERENCES [dbo].[Movie]([movieId]),
	constraint actorIdFk Foreign Key ([actorId]) REFERENCES [dbo].[Actor]([actorId])
);


/***** INSERTING in Table [dbo].[Movie]  *******/
INSERT INTO [dbo].[Movie] values (101, 'Titanic', 1997, 2185372302);
INSERT INTO [dbo].[Movie] values (102, 'The Avengers', 2012, 1511288162);
INSERT INTO [dbo].[Movie] values (103, 'Star Wars: The Force Awakens', 2015, 2068178225);
INSERT INTO [dbo].[Movie] values (104, 'Indiana Jones 4', 2008, 786636033);
INSERT INTO [dbo].[Movie] values (105, 'Star Trek', 2009, 385680446);
INSERT INTO [dbo].[Movie] values (106, 'Iron Man 3', 2013, 1147234000);

/***** INSERTING in Table [dbo].[Actor]  *******/
INSERT INTO [dbo].[Actor] values (1, 'Kate Winslet', '265-555-3267');
INSERT INTO [dbo].[Actor] values (2, 'Robert Downey, Jr.', '443-555-2300');
INSERT INTO [dbo].[Actor] values (3, 'Harrison Ford', '649-555-3992');
INSERT INTO [dbo].[Actor] values (4, 'Chris Hemsworth', '668-555-7475');

/***** INSERTING in Table [dbo].[MovieActor]  *******/
INSERT INTO [dbo].[MovieActor] values (103, 3);
INSERT INTO [dbo].[MovieActor] values (101, 1);
INSERT INTO [dbo].[MovieActor] values (105, 4);
INSERT INTO [dbo].[MovieActor] values (106, 2);
INSERT INTO [dbo].[MovieActor] values (104, 3);
INSERT INTO [dbo].[MovieActor] values (102, 4);
INSERT INTO [dbo].[MovieActor] values (102, 2);

/****** SELECTING The Required Output *******/
SELECT a.[name], AVG(m.[totalRevenue]) as AVGRevenue
FROM [dbo].[MovieActor] ma LEFT JOIN [dbo].[Actor] a 
ON  a.[actorId] = ma.[actorId]
LEFT JOIN [dbo].[Movie] m 
ON  m.[movieId] = ma.[movieId]
GROUP BY a.[name]
ORDER BY AVGRevenue desc