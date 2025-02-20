USE [master]
GO
/****** Object:  Database [aslanlı tel arıza kayıt]    Script Date: 12.11.2024 18:38:59 ******/
CREATE DATABASE [aslanlı tel arıza kayıt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'aslanlı tel arıza kayıt', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\aslanlı tel arıza kayıt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'aslanlı tel arıza kayıt_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\aslanlı tel arıza kayıt_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [aslanlı tel arıza kayıt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET ARITHABORT OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET  DISABLE_BROKER 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET  MULTI_USER 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET QUERY_STORE = ON
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [aslanlı tel arıza kayıt]
GO
/****** Object:  Table [dbo].[Üretim]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Üretim](
	[TezgahID] [int] NOT NULL,
	[TezgahAdi] [nvarchar](50) NOT NULL,
	[ToplamUretimMiktarı] [decimal](18, 0) NOT NULL,
	[ToplamÇalışmaSaati] [decimal](18, 0) NOT NULL,
	[PanelKontrolTarihi] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DonemlikToplamCalismaSaati2023]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	--2023 yılındaki tüm dönemlere çalışma süresi
	CREATE VIEW [dbo].[DonemlikToplamCalismaSaati2023] AS
	
	SELECT 
    Üretim.TezgahAdi,
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-03-31' 
            THEN Üretim.ToplamÇalışmaSaati
            ELSE 0 
        END) AS "1. Dönem Toplam Çalışma Saati",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2023-04-01' AND '2023-06-30' 
            THEN Üretim.ToplamÇalışmaSaati
            ELSE 0 
        END) AS "2. Dönem Toplam Çalışma Saati",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2023-07-01' AND '2023-09-30' 
            THEN Üretim.ToplamÇalışmaSaati
            ELSE 0 
        END) AS "3. Dönem Toplam Çalışma Saati",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2023-10-01' AND '2023-12-31' 
            THEN Üretim.ToplamÇalışmaSaati
            ELSE 0 
        END) AS "4. Dönem Toplam Çalışma Saati",
    SUM(Üretim.ToplamÇalışmaSaati) AS "Yıl İçi Toplam Çalışma Saati"
FROM 
    Üretim
WHERE 
    Üretim.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    Üretim.TezgahAdi;
GO
/****** Object:  View [dbo].[DonemlikToplamCalismaSaati2024]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--2024 yılındaki tüm dönemlere çalışma süresi
	CREATE VIEW [dbo].[DonemlikToplamCalismaSaati2024] AS
	
	SELECT 
    Üretim.TezgahAdi,
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2024-01-01' AND '2024-03-31' 
            THEN Üretim.ToplamÇalışmaSaati
            ELSE 0 
        END) AS "1. Dönem Toplam Çalışma Saati",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2024-04-01' AND '2024-06-30' 
            THEN Üretim.ToplamÇalışmaSaati
            ELSE 0 
        END) AS "2. Dönem Toplam Çalışma Saati",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2024-07-01' AND '2024-09-30' 
            THEN Üretim.ToplamÇalışmaSaati
            ELSE 0 
        END) AS "3. Dönem Toplam Çalışma Saati",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2024-10-01' AND '2024-12-31' 
            THEN Üretim.ToplamÇalışmaSaati
            ELSE 0 
        END) AS "4. Dönem Toplam Çalışma Saati",
    SUM(Üretim.ToplamÇalışmaSaati) AS "Yıl İçi Toplam Çalışma Saati"
FROM 
    Üretim
WHERE 
    Üretim.PanelKontrolTarihi BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
    Üretim.TezgahAdi;
GO
/****** Object:  View [dbo].[DonemlikToplamUretimMiktari2023]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--2023 yılındaki tüm dönemlere ait üretim miktarı
	CREATE VIEW [dbo].[DonemlikToplamUretimMiktari2023] AS
	
	SELECT 
    Üretim.TezgahAdi,
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-03-31' 
            THEN Üretim.ToplamUretimMiktarı
            ELSE 0 
        END) AS "1. Dönem Toplam üretim miktarı",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2023-04-01' AND '2023-06-30' 
            THEN Üretim.ToplamUretimMiktarı
            ELSE 0 
        END) AS "2. Dönem Toplam üretim miktarı",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2023-07-01' AND '2023-09-30' 
            THEN Üretim.ToplamUretimMiktarı
            ELSE 0 
        END) AS "3. Dönem Toplam üretim miktarı",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2023-10-01' AND '2023-12-31' 
            THEN Üretim.ToplamUretimMiktarı
            ELSE 0 
        END) AS "4. Dönem Toplam üretim miktarı",
    SUM(Üretim.ToplamUretimMiktarı) AS "Yıl İçi Toplam üretim miktarı"
FROM 
    Üretim
WHERE 
    Üretim.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    Üretim.TezgahAdi;
GO
/****** Object:  View [dbo].[DonemlikToplamUretimMiktari2024]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--2024 yılındaki tüm dönemlere ait üretim miktarı
	CREATE VIEW [dbo].[DonemlikToplamUretimMiktari2024] AS
	
	SELECT 
    Üretim.TezgahAdi,
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2024-01-01' AND '2024-03-31' 
            THEN Üretim.ToplamUretimMiktarı
            ELSE 0 
        END) AS "1. Dönem Toplam üretim miktarı",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2024-04-01' AND '2024-06-30' 
            THEN Üretim.ToplamUretimMiktarı
            ELSE 0 
        END) AS "2. Dönem Toplam üretim miktarı",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2024-07-01' AND '2024-09-30' 
            THEN Üretim.ToplamUretimMiktarı
            ELSE 0 
        END) AS "3. Dönem Toplam üretim miktarı",
    SUM(CASE 
            WHEN Üretim.PanelKontrolTarihi BETWEEN '2024-10-01' AND '2024-12-31' 
            THEN Üretim.ToplamUretimMiktarı
            ELSE 0 
        END) AS "4. Dönem Toplam üretim miktarı",
    SUM(Üretim.ToplamUretimMiktarı) AS "Yıl İçi Toplam üretim miktarı"
FROM 
    Üretim
WHERE 
    Üretim.PanelKontrolTarihi BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
    Üretim.TezgahAdi;
GO
/****** Object:  Table [dbo].[ArizaKayitlari]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArizaKayitlari](
	[ArizaID] [int] IDENTITY(1,1) NOT NULL,
	[TezgahID] [int] NULL,
	[ArizaTarihi] [date] NULL,
	[ArizaSuresiSaat] [decimal](5, 2) NULL,
	[ArizaDetayi] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ArizaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tezgahlar]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tezgahlar](
	[TezgahID] [int] IDENTITY(1,1) NOT NULL,
	[TezgahAdi] [nvarchar](50) NOT NULL,
	[KurulumTarihi] [date] NOT NULL,
	[SatınAlmaFiyatı] [money] NULL,
 CONSTRAINT [PK__Tezgahla__75E79332E0B76A51] PRIMARY KEY CLUSTERED 
(
	[TezgahID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[yilici_ariza_sikligi_2023]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[yilici_ariza_sikligi_2023]
AS
SELECT 
     
    SUM(U.ToplamÇalışmaSaati) AS ToplamÇalışmaSaati, 
    COUNT(A.ArizaID) AS ToplamArizaSayisi,
    CASE 
        WHEN COUNT(A.ArizaID) > 0 
        THEN SUM(U.ToplamÇalışmaSaati) / COUNT(A.ArizaID)
        ELSE NULL 
    END AS SaatteBirAriza
FROM 
	 Tezgahlar T

LEFT JOIN 
    ArizaKayitlari A ON T.TezgahID = A.TezgahID 
    AND A.ArizaTarihi BETWEEN '2023-01-01' AND '2023-12-31'  
LEFT JOIN 
    Üretim U ON T.TezgahID = U.TezgahID 
    AND U.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31' 
    


    
GO
/****** Object:  View [dbo].[yilici_ariza_sikligi_2024]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[yilici_ariza_sikligi_2024]
AS
SELECT 
     
    SUM(U.ToplamÇalışmaSaati) AS ToplamÇalışmaSaati, 
    COUNT(A.ArizaID) AS ToplamArizaSayisi,
    CASE 
        WHEN COUNT(A.ArizaID) > 0 
        THEN SUM(U.ToplamÇalışmaSaati) / COUNT(A.ArizaID)
        ELSE NULL 
    END AS SaatteBirAriza
FROM 
	 Tezgahlar T

LEFT JOIN 
    ArizaKayitlari A ON T.TezgahID = A.TezgahID 
    AND A.ArizaTarihi BETWEEN '2024-01-01' AND '2024-12-31'  
LEFT JOIN 
    Üretim U ON T.TezgahID = U.TezgahID 
    AND U.PanelKontrolTarihi BETWEEN '2024-01-01' AND '2024-12-31' 
GO
/****** Object:  Table [dbo].[BakimKayitlari]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BakimKayitlari](
	[BakimID] [int] IDENTITY(1,1) NOT NULL,
	[TezgahID] [int] NOT NULL,
	[BakimTarihi] [date] NOT NULL,
	[BakimTuru] [nvarchar](50) NOT NULL,
	[BakimMaliyeti] [decimal](10, 2) NOT NULL,
	[DuruşSuresiSaat] [decimal](5, 2) NOT NULL,
	[BakımıYapanTeknisyen] [varchar](25) NOT NULL,
 CONSTRAINT [PK__BakimKay__7227287E85DDB2A0] PRIMARY KEY CLUSTERED 
(
	[BakimID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[yilici_toplam_bakim_maliyeti2023]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[yilici_toplam_bakim_maliyeti2023]
as
select Tezgahlar.TezgahAdi,
SUM(BakimKayitlari.BakimMaliyeti) as 'Yıliçi Toplam Bakım Maliyeti'
FROM Tezgahlar
left join BakimKayitlari
on Tezgahlar.TezgahID=BakimKayitlari.TezgahID
where BakimKayitlari.BakimTarihi <='20231231'
group by Tezgahlar.TezgahAdi
GO
/****** Object:  View [dbo].[yilici_toplam_bakim_maliyeti2024]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[yilici_toplam_bakim_maliyeti2024]
as
select Tezgahlar.TezgahAdi,
SUM(BakimKayitlari.BakimMaliyeti) as 'Yıliçi Toplam Bakım Maliyeti'
FROM Tezgahlar
left join BakimKayitlari
on Tezgahlar.TezgahID=BakimKayitlari.TezgahID
where BakimKayitlari.BakimTarihi between '20240101' and '20241231'
group by Tezgahlar.TezgahAdi
GO
/****** Object:  View [dbo].[BakimMaliyetiAzalmaOranlari]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BakimMaliyetiAzalmaOranlari]
AS
SELECT 
    T.TezgahAdi,
    -- 2023 yılı için toplam bakım maliyeti
    COALESCE(SUM(CASE WHEN B.BakimTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN B.BakimMaliyeti ELSE 0 END), 0) AS ToplamBakim2023,
    -- 2024 yılı için toplam bakım maliyeti
    COALESCE(SUM(CASE WHEN B.BakimTarihi BETWEEN '2024-01-01' AND '2024-12-31' THEN B.BakimMaliyeti ELSE 0 END), 0) AS ToplamBakim2024,
    -- Bakım maliyetinde azalma oranı
    CASE 
        WHEN COALESCE(SUM(CASE WHEN B.BakimTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN B.BakimMaliyeti ELSE 0 END), 0) > 0
        THEN 
            ((COALESCE(SUM(CASE WHEN B.BakimTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN B.BakimMaliyeti ELSE 0 END), 0) - 
            COALESCE(SUM(CASE WHEN B.BakimTarihi BETWEEN '2024-01-01' AND '2024-12-31' THEN B.BakimMaliyeti ELSE 0 END), 0)) / 
            COALESCE(SUM(CASE WHEN B.BakimTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN B.BakimMaliyeti ELSE 0 END), 1)) * 100
        ELSE NULL
    END AS AzalmaOrani
FROM 
    Tezgahlar T
LEFT JOIN 
    BakimKayitlari B ON T.TezgahID = B.TezgahID
GROUP BY 
    T.TezgahAdi
GO
/****** Object:  View [dbo].[calisma_saati_artıs_oranlari]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[calisma_saati_artıs_oranlari]
AS
SELECT 
    T.TezgahAdi,
    -- 2023 yılı için toplam çalışma saati
    COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN U.ToplamÇalışmaSaati ELSE 0 END), 0) AS ToplamCalismaSaati2023,
    -- 2024 yılı için toplam çalışma saati
    COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2024-01-01' AND '2024-12-31' THEN U.ToplamÇalışmaSaati ELSE 0 END), 0) AS ToplamCalismaSaati2024,
    -- Çalışma saatindeki artış oranı
    CASE 
        WHEN COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN U.ToplamÇalışmaSaati ELSE 0 END), 0) > 0
        THEN 
            ((COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2024-01-01' AND '2024-12-31' THEN U.ToplamÇalışmaSaati ELSE 0 END), 0) - 
            COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN U.ToplamÇalışmaSaati ELSE 0 END), 0)) / 
            COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN U.ToplamÇalışmaSaati ELSE 0 END), 1)) * 100
        ELSE NULL
    END AS ArtisOrani
FROM 
    Tezgahlar T
LEFT JOIN 
    Üretim U ON T.TezgahID = U.TezgahID
GROUP BY 
    T.TezgahAdi;
GO
/****** Object:  View [dbo].[uretim_miktari_artis_orani]    Script Date: 12.11.2024 18:39:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[uretim_miktari_artis_orani]
AS
SELECT 
    T.TezgahAdi,
    -- 2023 yılı için toplam üretim miktarı
    COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN U.ToplamUretimMiktarı ELSE 0 END), 0) AS ToplamUretimMiktari2023,
    -- 2024 yılı için toplam üretim miktarı
    COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2024-01-01' AND '2024-12-31' THEN U.ToplamUretimMiktarı ELSE 0 END), 0) AS ToplamUretimMiktari2024,
    -- Üretim miktarındaki artış oranı
    CASE 
        WHEN COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN U.ToplamUretimMiktarı ELSE 0 END), 0) > 0
        THEN 
            ((COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2024-01-01' AND '2024-12-31' THEN U.ToplamUretimMiktarı ELSE 0 END), 0) - 
            COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN U.ToplamUretimMiktarı ELSE 0 END), 0)) / 
            COALESCE(SUM(CASE WHEN U.PanelKontrolTarihi BETWEEN '2023-01-01' AND '2023-12-31' THEN U.ToplamUretimMiktarı ELSE 0 END), 1)) * 100
        ELSE NULL
    END AS ArtisOrani
FROM 
    Tezgahlar T
LEFT JOIN 
    Üretim U ON T.TezgahID = U.TezgahID
GROUP BY 
    T.TezgahAdi;
GO
ALTER TABLE [dbo].[ArizaKayitlari]  WITH CHECK ADD  CONSTRAINT [FK__ArizaKayi__Tezga__398D8EEE] FOREIGN KEY([TezgahID])
REFERENCES [dbo].[Tezgahlar] ([TezgahID])
GO
ALTER TABLE [dbo].[ArizaKayitlari] CHECK CONSTRAINT [FK__ArizaKayi__Tezga__398D8EEE]
GO
ALTER TABLE [dbo].[BakimKayitlari]  WITH CHECK ADD  CONSTRAINT [FK__BakimKayi__Tezga__3C69FB99] FOREIGN KEY([TezgahID])
REFERENCES [dbo].[Tezgahlar] ([TezgahID])
GO
ALTER TABLE [dbo].[BakimKayitlari] CHECK CONSTRAINT [FK__BakimKayi__Tezga__3C69FB99]
GO
USE [master]
GO
ALTER DATABASE [aslanlı tel arıza kayıt] SET  READ_WRITE 
GO
