CREATE OR ALTER TRIGGER CalculateCount
ON FirstPerk
AFTER INSERT, UPDATE
AS
BEGIN

DECLARE @PerkName AS VARCHAR(25), @Percentage AS NUMERIC(5,2), @Counts AS FLOAT, @Count AS INT, @Votes AS INT

SELECT @Votes = 127

SELECT @PerkName = Perkname FROM inserted
SELECT @Percentage = percentage FROM inserted
SELECT @Counts = SUM(@Votes * (percentage / 100)) FROM inserted

IF PARSENAME(@Percentage, 1) >= 50 (
	SELECT @Count = CEILING(@Counts)
) else IF PARSENAME (@Percentage, 1) < 50 (
	SELECT @Count = FLOOR(@Counts)
)

BEGIN
	UPDATE FirstPerk SET Counts = @Count WHERE PerkName = @PerkName
	PRINT 'Count Inserted'
END
END
