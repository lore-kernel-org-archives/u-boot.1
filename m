Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46704D10372
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 02:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09F6840B1;
	Wed, 26 Nov 2025 03:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="EuXJZfks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869428416F; Wed, 26 Nov 2025 03:04:37 +0100 (CET)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB5A840B0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 03:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqpL+VHn84HWOzSJb86XXGa2PAH2bq2Hq1S6EDYGbi1Vn21Tq3sS60fYOaen2n+FPav79McDZDfQuNnWzYU4GaZp+gUNEGhYgJpIHcSXJTrzkAPE5i4sUOsUYayLFhawfwcUHaY8YjCIVIyTHDQ4ttTGASR/EfVW/HfgqgdQ6vb6TgHU9RherZv5mbTidr0tTPrwVvZuMpYG5vHLUpTUIykAZSvx6NMsx2bVbc9Wgt9385Aw8yZ1jnaizw3YNyIlOLYvSh5GUHhVlMh3tbE3lotJEaGMAl4hVAzJDUSbqrOI/FjKXsEhPvL30Tz1r/z+5U0UKuAvBKKSNrJs899hdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnfH2zSuGd56564jarwTwis77Tyjd9CC5Mo967sM3HI=;
 b=BcNl+w6K9rnqzAU+RUpn7B97Be+8ZybWxIaAR3E0K9g8iNekx6Ir+6ep3j4wr7sFAKjI2npN/GBMOn6GFxf+VHvily5uOMsyaP6I26aXaYjbCLfxTHKTC8g3H0tmuQnXJZR4bL/2uN0R3CNF133UygNp6AKUeCZWF9coG+VbJLKzE51Cz1ghBZlXWwOhOGSUQQnP2mq4PYmJ2grTjHk1xD17bhkUH9R9sNyAPldgIMAZS12XDyW93tw2kyVV7i57LuQ6Hn8+dttgJ8MABDmwUpDdq4JljV4hLXOLZfnfXVrt+KVU87KSxD3QatwrcwMjfiIrRcVlNHahsD8zBiJ/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnfH2zSuGd56564jarwTwis77Tyjd9CC5Mo967sM3HI=;
 b=EuXJZfks88LfRPNpxc1x0g/4hI+Upbi91l7Yc1SajlylmCVe4amUAaT0ng/TPGfu5JYaFoVC0XJfQoBI4e+PiTei1mEsiqOUD3v9EtGvKHseH7p3+MC5s420ShmHielQBkCu2GAxJZBqT2ZizcrE3fKABh5PpJ3ybCRYMLM6qGReV/I71q7YYnn62j6NpdK5LMaASnbhqtdwyq+E13upg5U8+elF38/RgNiSLlTN42JrD8pYz2DNm84ZmurpBgvqWkWno6TVnVvcQxrQ7L9q4OhY/C8mNELrEw+3PnBg+8m/EdVd6cmDaeKW28va7EzXRoRyYIHZnrBwZR5J2eUxFw==
Received: from TYRPR01MB15552.jpnprd01.prod.outlook.com
 (2603:1096:405:288::10) by TYWPR01MB10790.jpnprd01.prod.outlook.com
 (2603:1096:400:2a6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 02:04:30 +0000
Received: from TYRPR01MB15552.jpnprd01.prod.outlook.com
 ([fe80::51c:51f:5c37:3562]) by TYRPR01MB15552.jpnprd01.prod.outlook.com
 ([fe80::51c:51f:5c37:3562%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 02:04:30 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] mtd: spi-nor-ids: remove duplicate IDs for w25q32 and w25q512
 series
Date: Wed, 26 Nov 2025 10:04:09 +0800
Message-ID: <TYRPR01MB155526AD71D445F89066AA77FBCDEA@TYRPR01MB15552.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::14) To TYRPR01MB15552.jpnprd01.prod.outlook.com
 (2603:1096:405:288::10)
X-Microsoft-Original-Message-ID: <20251126020409.506471-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB15552:EE_|TYWPR01MB10790:EE_
X-MS-Office365-Filtering-Correlation-Id: 0929704b-157d-4945-9aff-08de2c902229
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnpXB0xcNeDVdCapwJT98fjMjp6r1KtZAZGirzyYIBOlzHIfQc9eWMlZ2J8o896Gqmxb1fqbTSCfUKioYKHrmrCL1qcbm+6jbMBOxQx/FIqTbby4JRRjTlVX/MJjMQDEVUlFJlYOSZRDt5HYV2Xn0tuwOgV+6G90RKFQwGhTdeweu1AZmZp1FdLtCUPOo1Ffs9XbtUm9EwbeHCVzAl9Xq+hQhZ7cPs9zssMsaa7CXIB1G37u6zpsh1R0Mjj2elZt63Xn1gMCBG6BsfbZhskmpbtOEtJU27eu6wvlpwqVOx46zHTwzI6JJ7X7MWHMqgNI5I+7XqJRfqFcEqB+zEJ2aTtVX1wG/zHNcpQ8fsfNGywO/6vZz/pphYlw23fcYba5C7zMvfD+Fsy0rMxY5LKAD+wTuHyqd+9uBYUix0iHwv3yDln0KLFGEANikrTP1FZC9l0tIXTvo3vODeWRnfzvc8HQjNBoRXSs1dKL+JbFpNVR+fP64z/RHSYWVShxsnlLVGlqWN2iGxOsqR67H6tv4ne/2ZmAqf4A6BrZcQH6Pg8ZwjAqiqjTWjE261QvRrdidsYjtQ9WdjYWDhFu+LkTNd7HDSJtRENLCiCujpY+jlaF8Ktd01OsjrIfyZvBvZOWzSC0YjdiCyg4/rTQgxPFg9UYEdZf06OdhyqI7mzXiWjeZE3wxP9nRbpuVPU2MmGgSP/FVSReAWHZqjIQGoAfvjwLhnXO2Vsi4mJi1fwQ/eG3hiNfSH7tUUyqypf2oglk2ho=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|461199028|5062599005|5072599009|23021999003|15080799012|8060799015|19110799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WK/qxx9g84jskMBCfVtsGJXoNaaq2qJcHM5zF/jjlKmq2VoCJn+wMFrMB4yW?=
 =?us-ascii?Q?UayxZpzqlQBsBmBC23OKgkqBV9+ttkIkPS0MiRP02SBen/gCllCBfUfnsECl?=
 =?us-ascii?Q?+oswL93oDBxXojKkR6v0Z/DetOICzF6i9dQwDAgHgNFXJ78X6bkXOXx1owmD?=
 =?us-ascii?Q?EkLZqnBVfamqtq5cGXvZJol7aXt3fKAL6+cYdccB9OlNiNMDZ6DvEqgDDBLI?=
 =?us-ascii?Q?DZLJ1TP5RRiu8XYMXXetjH+RSg6q4O7TmGcdaZlU1RIKakLLHTkkdiYvSXOW?=
 =?us-ascii?Q?uVwufXf139EzCtF/zrehCyYK6W5xpa05vnchWvu3O7xhdKqXf9jvHn4A7Nx6?=
 =?us-ascii?Q?7y/2O6Y7VcJmJk5dm1lmolwSrzZE5FAPWaDCqbCCe5Yb4iebEUzvoEDMGHRB?=
 =?us-ascii?Q?R+Tq1pTdFD8mWzIh5KkjHqGwZ38an4ipsaHdxtcEp0UGa3B3iPdzdMa0zoaT?=
 =?us-ascii?Q?LBfgaR+P9HNLcpsK4dygZXeobtA/ThwbRpbWpIRxvMEAsvwa/FT8cd2O/0Jg?=
 =?us-ascii?Q?xI1B4ZbO4HpwPLxB/g89cLMngIElW+2A9FZxXFHr/J8w5RHt9M0dYPpz7pqK?=
 =?us-ascii?Q?3ci4Zk7pMLSG6GcG4FCmDTShOL5oAb1NfB8pHWv/wYJ9O8BpBgmPFWpFYDv5?=
 =?us-ascii?Q?LfTEFCikxW3mSnFCvHLyGXKqMePITy+5jSIxIp+DUMWhhIbB5P6bT/Xxfs57?=
 =?us-ascii?Q?/ug8/LulJ+rcB3AkKIFZ2GRpgkQDubzo4vZOmovBUoFWUUxTzKN1krNmc76Q?=
 =?us-ascii?Q?+dQGj7FNPY9/Nz3fBcg2cDKY521AVp3eYf95+AcXKRrG9jiYcsQptsm9nwIL?=
 =?us-ascii?Q?QaYMOXiuBDD98lv0IkiVFiasoMDjfifxKdFv5SxeIIOwVKjEzgWYgW6VuUrS?=
 =?us-ascii?Q?jMqmWixw4SORNWaomkoPd2wvIWQ0kbZWMF2jbBxqZmrMxmMDn3rpKh4s49UQ?=
 =?us-ascii?Q?va8vAf98abvC9JdOcqykuC3tltn/7TG3Klhd1J7KhuPwGpNCYDLqHE8qGByJ?=
 =?us-ascii?Q?EprQMWQ3yQVD5/FRAYi/6nL6gcFsHJEBSH8+oNP+H3dSmknZX2Y4p+OgSW11?=
 =?us-ascii?Q?LBpyDA9br86qda/QjCmAEhfTF5d0JRpvSDAQ3/ZQ0o9DW4i9QsobGP8uXo19?=
 =?us-ascii?Q?0Mwx4duKEfr3A/WJbJH9uj6cNhRaprZzBFC0nj+M3oKNLDGrQvLouzlUPlQZ?=
 =?us-ascii?Q?MPiZhv0oz5DHflQZtZ6xDSqIdp7Mh5PkSIVmZDX3HPJSlMizDab1Eun1Sao?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UoSbxF6Vgt/EFUVGQNodhmsMBGd1yzhcGjEzdtmaXpm1E95jF3o/CtIZHmq7?=
 =?us-ascii?Q?LAWYNqcNt3Fi5pknNQhUIb3BUXsS/1Mrq1kXoQHiD6ZX1/FSFfDH4gTJrQ0C?=
 =?us-ascii?Q?A1u7Swq1ZxfB3zyO9kdkBRXF4y+8VCVjh+eoeFFAPf/Kxf9l5NWUc+z87R4j?=
 =?us-ascii?Q?TG55Zf+2k8TABD93+dMUa4Mqopt/NlXdUG/5oradYKHFKlDOZWwaKR2QEiot?=
 =?us-ascii?Q?3csv4d53Xnl4Oln6eG67Lcu75W56Xkz9fAWrzBNYUG/EzE0PS86peqQk6kNC?=
 =?us-ascii?Q?OYwPZI7+KupMdJOkrQbNI3aSypnY4QuEUj3LrSoifxBUaYjtNWbSTtK4rXXg?=
 =?us-ascii?Q?YJ3+CmSb2WF3CGvdUA5h9S2nqTVvasA3RPxDCIQVsbBUV8ceN9oRDD9TTNbi?=
 =?us-ascii?Q?no/C82N2hjlUGTpjKyUTUUX0FrymeNWl+dNgxEBbkIyv1kbir9lhEimcTRWt?=
 =?us-ascii?Q?5Di1D7QS8jwhNnpUeRzDIxbuOa/NxsfQw0oWlGfgR76W2hRXrhkgSnTiYUig?=
 =?us-ascii?Q?FTKmGOzieC3WJAW4qhkERXB+BYjh0ImwXskU/PJZoVzAhPKW5PJeX1BherkB?=
 =?us-ascii?Q?KW0epIHjcQFQOq/GfNnnSxg1RChiMCAj8a/prVQWh373MeHZnOJijM2PDLs9?=
 =?us-ascii?Q?yRHzEX0+ioindgxK/UP7N3caeNp966Yf2MHKlXIdd2HSi46XlRF82Jj+6NMl?=
 =?us-ascii?Q?FO4lim2EQd9qzEiAZfo34bD1TWWeDTMEGLHj+YCHtAFOHe0kVu7sduq2MpcU?=
 =?us-ascii?Q?12xefi1XFeod+oOOsu9CjlnAaapq7uJoFK2kOoGPfXAC6FcyTNrQhniXuG5X?=
 =?us-ascii?Q?W/EeGpvW/XkJjbGGgr3GqwdaM57RaexDhhXrcgcY+nrFwg8EnhEBLUq/Sybl?=
 =?us-ascii?Q?AEAuWlglcNVcNW/+rCswYh1PR5K+OW0GN9UiPsW4DxM8wNbeExLU5vYUEWcB?=
 =?us-ascii?Q?AMBAfFCgbaqawfs6RttjIttXSyVybwjGch1jMLjNID130lYcbVUQQGMs4q08?=
 =?us-ascii?Q?PqRtlnHemFmq33NjA8Q+qxRZL6Jwu3qVVU9GzZIyusDxaJ7FYkdCqcHuxX0j?=
 =?us-ascii?Q?FomCIMGR75otpQKcZvX1++Ke4BF3juRcvL7wBDB77OnwyM5y71d+kryI8I1X?=
 =?us-ascii?Q?EE9Exn1IPOxipADkviICPoxEAANeGrGahW8MKmhZtz1+bClUrVmSxs8kC5IS?=
 =?us-ascii?Q?kWOnLUH1NeE68FraNAY2oeAz71+j9OPrApO7kKszC0y7jHHsbCNLjWLIMv96?=
 =?us-ascii?Q?ZBUGEH2npBQ87Ws8M9un?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0929704b-157d-4945-9aff-08de2c902229
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15552.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 02:04:29.8819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10790
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Some Winbond Flash chips share the same device ID. Names are not that
important for the SPI Flash, hence we don't need these duplicate ID
definitions. And the Flash size of w25q512jv is actually wrong. Clean
them up to keep the source file tidy.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 16bc7b8eb87..e8d180a8c76 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -484,7 +484,6 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("w25q20cl", 0xef4012, 0, 64 * 1024,  4, SECT_4K) },
 	{ INFO("w25q20bw", 0xef5012, 0, 64 * 1024,  4, SECT_4K) },
 	{ INFO("w25q20ew", 0xef6012, 0, 64 * 1024,  4, SECT_4K) },
-	{ INFO("w25q32", 0xef4016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{
 		INFO("w25q16dw", 0xef6015, 0, 64 * 1024,  32,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
@@ -550,11 +549,6 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
-	{
-		INFO("w25q512jv", 0xef7119, 0, 64 * 1024, 512,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
 	{
 		INFO("w25q512nwq", 0xef6020, 0, 64 * 1024, 1024,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
@@ -592,7 +586,7 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
-	{ INFO("w25q32bv", 0xef4016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("w25q32", 0xef4016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25q64cv", 0xef4017, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25q128", 0xef4018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-- 
2.51.0

