USE FresherTrainingWithSTE07
CREATE TABLE STE.Trainee1(
	TraineeId INT IDENTITY(1,1) PRIMARY KEY,
	FullName NVARCHAR(50) NOT NULL,
	BirtDate DATE NOT NULL,
	Gender CHAR(6) CHECK(Gender='male' OR Gender='female'),
	EtIq INT CHECK(EtIq >= 0 AND etIq <=20),
	EtGmath INT CHECK(EtGmath BETWEEN 0 AND 20),
	EtEnglish INT CHECK(EtEnglish BETWEEN 0 AND 50),
	TrainingClass CHAR(20),
	EvaluationNote NTEXT,
)

--B
ALTER TABLE STE.Trainee1
ADD FsoftAccount CHAR(20) NOT NULL UNIQUE

UPDATE STE.Trainee1 SET BirtDate = '19450604' WHERE TraineeId = 7
--A
INSERT INTO STE.Trainee1(FullName,BirtDate,Gender,EtIq,EtGmath,EtEnglish,TrainingClass,EvaluationNote,FsoftAccount)
VALUES
	(N'Nguyễn Hoàng Lan', '20020705','female', 10, 10, 41, 'STE','Test','LanNguyen'),
	(N'Lê Mạnh Khánh', '20020511','male',11, 12, 32, 'STE','Test','KhanhLe'),
	(N'Phạm Chí Thanh', '19960603','male',15, 13, 23, 'STE','Test','ThanhPham'),
	(N'Nguyễn Hoàng Minh', '20101007','male', 8, 4, 14, 'STE','Test','MinhNguyen'),
	(N'Hoàng Thị Thủy', '19791001','female', 20, 15, 45, 'STE','Test','ThuyHoang'),
	(N'Nguyễn Quang Tùng', '19780818','male', 3, 6, 16, 'STE','Test','TungNguyen'),
	(N'Nguyễn Hoàng Phương Hà', '20230616','female', 7, 17, 7, 'STE','Test','HaNguyen'),
	(N'Hoàng Khánh Linh', '20090910','female', 17, 18, 8, 'STE','Test','LinhHoang'),
	(N'Hoàng Gia Khánh', '20030622','male', 19, 19, 22, 'STE','Test','KhanhHoang'),
	(N'Lê Quang Việt', '20130326','male', 10, 10, 20, 'STE','Test','VietLe')


--C
CREATE VIEW EtPassedTrainee1
AS
SELECT * FROM STE.Trainee1

SELECT * FROM EtPassedTrainee1

WHERE EtIq+ EtGmath >= 20 AND EtIq >= 8 AND EtGmath >= 8 AND EtEnglish >= 18;


--D
SELECT FullName,MONTH(BirtDate) as "Month"
FROM STE.Trainee1
WHERE EtIq+ EtGmath >= 20 AND EtIq >= 8 AND EtGmath >= 8 AND EtEnglish >= 18
GROUP BY MONTH(BirtDate), FullName

--E
SELECT TOP 1 WITH TIES 
	FullName,BirtDate,Gender,EtIq,EtGmath,EtEnglish,TrainingClass,EvaluationNote,FsoftAccount,
	DATEDIFF(YEAR, BirtDate, GETDATE()) AS Age
FROM STE.Trainee1
ORDER BY LEN(FullName) DESC