USE [bluewinds]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 07/07/2018 19:27:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](40) NOT NULL,
	[LastName] [nvarchar](40) NOT NULL,
	[City] [nvarchar](40) NULL,
	[Country] [nvarchar](40) NULL,
	[Phone] [nvarchar](20) NULL,
 CONSTRAINT [PK_CUSTOMER] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 07/07/2018 19:27:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[UnitPrice] [decimal](12, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_ORDERITEM] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 07/07/2018 19:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[OrderNumber] [nvarchar](10) NULL,
	[CustomerId] [int] NOT NULL,
	[TotalAmount] [decimal](12, 2) NULL,
 CONSTRAINT [PK_ORDER] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 07/07/2018 19:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[SupplierId] [int] NOT NULL,
	[UnitPrice] [decimal](12, 2) NULL,
	[Package] [nvarchar](30) NULL,
	[IsDiscontinued] [bit] NOT NULL,
 CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 07/07/2018 19:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](50) NULL,
	[ContactTitle] [nvarchar](40) NULL,
	[City] [nvarchar](40) NULL,
	[Country] [nvarchar](40) NULL,
	[Phone] [nvarchar](30) NULL,
	[Fax] [nvarchar](30) NULL,
 CONSTRAINT [PK_SUPPLIER] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderItems] ADD  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[OrderItems] ADD  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [TotalAmount]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [IsDiscontinued]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_ORDERITE_REFERENCE_ORDER] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_ORDERITE_REFERENCE_ORDER]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_ORDERITE_REFERENCE_PRODUCT] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_ORDERITE_REFERENCE_PRODUCT]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_REFERENCE_CUSTOMER] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_ORDER_REFERENCE_CUSTOMER]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_PRODUCT_REFERENCE_SUPPLIER] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_PRODUCT_REFERENCE_SUPPLIER]
GO
