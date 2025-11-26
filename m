Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB85D0EE10
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 01:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 274338416F;
	Wed, 26 Nov 2025 02:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="W83cV0Bl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A551284187; Wed, 26 Nov 2025 02:38:17 +0100 (CET)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D1C84142
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 02:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLociw4nCGWYV/htyI1s+50EQoWX/aZ/gu/RrcUIan0j9Z0jAeS3/I9t4pYyMv4liGpcwU3iBfixJGCCNgrNZ/OifIK696JWcQjr313uVC7m40b9NDxmvqoLeeYQ2Cc2CrYS4EDSmZvfbyE9fQqDRRkEx1okJyKLIfdpNsUx/Y4985JZbRhvC9EEI3Gew5cYvs2og32HdDXVVMM7Ky9TgKkvEuAsnf6wcmOMejFlg5fxTUI9ybRawfUfocS4CepwKdDtvfr3Tg1XMprPJ2gxnW07dQdbSoV9h3GcgGMTf7cYtq1XgG9JUd2uo+G8eSnNg18v6cmsYBnVnvv0jgj+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW5fhItM9WEMz4wBUsJdb8PqDFxSGCH8Qb7GjCGWJYc=;
 b=DNrccUQ/iNDcTsUGBC2hsnKseV5oRUdTmk7t0ETWXoKDc0yEhIK+pkqH+6acTbbDWBrXFCuBSU2OH6ag8WFldppa2hBYH+YIfaYmQVv5zHC7A0zXGkObZNeG18UrA2hkNvZse1kBFjpV8FNd79qkPgQxTHCBtbLxzAduckaxgbSIElhX25Qx0MjBpJNS1frNdacXDBI7o+CCUx4H/PheRu3lrdil9G7f5m04+4kGr7NED3s7wLSp4QR36t1ffU0giGBRk2FjpNhUNb26Za/M1/C3PHLJwQT0o28pEdN7e2c9cNP4pPpl5ABvZKP/9tcAIMm4doKCL3WdZgzHtiEpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW5fhItM9WEMz4wBUsJdb8PqDFxSGCH8Qb7GjCGWJYc=;
 b=W83cV0BlZdtlcK2WNfyb/7Y4XLCAHQhMvCo4uKn8D3aP84uC2ZpD5F4cF1/RGf8g5OpCjk9M8XwgakIxfP5Rl2yX6OVtCAT61yJS+hg1fs1NNiM5L+0WXYVh3m1BON09LN1Lj2vn6J015riBgfgBXHwfwhhNgNc3LZ+eSG93qmmOkirDmjFUnzIITEBRYDsMP7kJuTuyrt3hY3vLblO5yIdPeDAPhIjS+BP6wtvKA3b7/+tu3ZzZ+Jd5N70R5leDez0eD53DN4BPvKLdbpL7is/PosCWq8BPOLWdKwu6lDu3RVBgTxTuFIq8dM031cc0yq/NBufc+f52G5PuWYBnKw==
Received: from TYRPR01MB15552.jpnprd01.prod.outlook.com
 (2603:1096:405:288::10) by TYVPR01MB11201.jpnprd01.prod.outlook.com
 (2603:1096:400:365::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 01:38:10 +0000
Received: from TYRPR01MB15552.jpnprd01.prod.outlook.com
 ([fe80::51c:51f:5c37:3562]) by TYRPR01MB15552.jpnprd01.prod.outlook.com
 ([fe80::51c:51f:5c37:3562%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 01:38:10 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] mtd: spi-nor-tiny: fix 4-Byte address instructions for
 Cypress and ISSI
Date: Wed, 26 Nov 2025 09:37:41 +0800
Message-ID: <TYRPR01MB155520F5FD75A2AAE0A992875BCDEA@TYRPR01MB15552.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To TYRPR01MB15552.jpnprd01.prod.outlook.com
 (2603:1096:405:288::10)
X-Microsoft-Original-Message-ID: <20251126013741.490665-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB15552:EE_|TYVPR01MB11201:EE_
X-MS-Office365-Filtering-Correlation-Id: 256ecca9-0280-4c8b-2807-08de2c8c7470
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TUsv+cEJZg5fVJ94wuUkF2+PEIPzvWvwUSOinmeFxx2nIS3Gdcfgjoyw67GtyZWrTXO3gSbghj+0M57mX8+yhyHyKsv070s4upom2aVRVOsfb/haga4JZdquhZYAfry0LYnEfX7IAuBHy9DTLnjRHqZDFivMG0xpM2ecpYilqB7Wpce8BEkLEPHAas8lSyvRUwgSStWpdvtRLoiCFMfAsb/Z70o6P/4RssFWOQECQUs1P4JIeSsc131Jc5eQUxU6EPnpC+ZWYpJ4bFtQXOdj4+a8wCTlVWhC0QsbuBY+Quy9hQJQ7q7N8iSmN+SDAViSrZMiMeLhiPut9AsbBldufiR85zITzuEKibxK/eUGMLdnkTFG/01Rn37BsDizuYWO6KrCt0JRWfaO53pI7OyAoVKlNtITUkDPSakzLAH+imquEfhfY3BJ7OW15Lt/NOAdJmBkpoYUviaoue27aEquxxVX81q7QxI9a316SuiBO0lumWANMFN7C+6W8L9H5DfRi3aGbTHH0Md9g11fjlrhxT5m0apbL9/NLOHPmyV3ULNtXZfdIsVoqFHYtAPG8ZXZfolEymvSFpFBTUHtpHRHX6tKzWkvguR2WgJ8c4GU0mMVkWAU2phSvK46JlJ8PiVW7sJLrj5ApbqlAKmvKlnr07W8stkoJKY1So6fmc4aDPk/S4G1qPy0hziOK9q7mF83mt9vqntWvK6tJ1jEkDKbdWMWCD4dRQRlSa2zBCNtRxX6zGUpZVhso9mQ4YAzMzCrWjQZvkL13kcUmeuwGncenl4V7dcOcWsknM=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|41001999006|19110799012|15080799012|23021999003|461199028|5072599009|39105399006|5062599005|13041999003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9ZAcNQc9TObcxiJeGDv7pYvlLAuYEU6CHZkZowBID5EOl5T6HW6EK0PUWPd2?=
 =?us-ascii?Q?iiTTQiqotB1orRKHWOsh0PjEa+vL+aaB5qdi2k9RM6OCoEGgtBbeu4KDfbU9?=
 =?us-ascii?Q?nj0AnDk/fhsrH3tPD2N0rBp3W7NpQvZvEoYYDr3uEBJKUCFNOr9ecttzc8aF?=
 =?us-ascii?Q?kbE3kbTMi13X0yf/GdBS3fLzMoi7LqjEuaCTmkReEVWuVR6DZMOl2u5eoO+P?=
 =?us-ascii?Q?5OPsRf4zyIV0xDwzXXuiy89ZypD2i5jk54wapiy7efPzVX0cLRawKWKEAeyg?=
 =?us-ascii?Q?08B9naheziculdkQP8yfwCjcTfwCDN6lQYJ3tLuC01anqk7v2DswZP5h6lRF?=
 =?us-ascii?Q?wnwIXxy09mXncr22gNxBChRq6AJLN1zDtGJkyla93N1zEbyaCPOioHfNzUO8?=
 =?us-ascii?Q?RZ3Bsq6Z5aE6iGTOuoQF/HQr9A5FZFNFrALpQWVsTynnMpKOexAWZjsLSC7U?=
 =?us-ascii?Q?J/JTZ6Rg5N4SchGUHhq1CBdP03ahLl57T5xSSZZe0t7xuouQt8bWkEfUEGRx?=
 =?us-ascii?Q?PGvaSY+sSRhKSX4IkNgMR/OpOhU65zjD7rEdGxQOSyWFI6tiTIoyNiPHwgHb?=
 =?us-ascii?Q?gEPpt9h6Pmp5RxSjZFq6fzbc+c/RXuqeF0pmOLcjuVt9Q/w920wbYYp7Dlb/?=
 =?us-ascii?Q?rechS1Shrqoa1pT/1WMbeNzJbshbKCxGwlVfoM+DEyJsnsTFg9dNRb8DgOd7?=
 =?us-ascii?Q?7XAK6haelEUAlIz+7yK1a7tHbFcAyihjROK7ExWEz/yZ2YLUIVa4vCSVDptH?=
 =?us-ascii?Q?dCErXO66ZgvLxbjalbojkZ2RdStFqgd/RMNZZFL8hdv0tBCpbDYV7vJA4LEh?=
 =?us-ascii?Q?DbhiFP29w3+7sE+5ZxamN3X3VwyUsB0Mje1cTRTndZOReyh5VFHJM9teWvpY?=
 =?us-ascii?Q?4aFyhymRxmIw+xoKy2o7Q2mDyXKp57z5NKLZaxZX0JauaeXiDIFxad0SdT3h?=
 =?us-ascii?Q?/KpmovEYSMI/8lUkjxtq4vnpecLSl5qNMuaSxaZl24HHlK+nIYyQL3mLGV3a?=
 =?us-ascii?Q?ZYnLTh3EWGCxpkJsXlKUlpNP8MvOsm7ixDoiQkHnlVyWSz6caLGq12aVIVWx?=
 =?us-ascii?Q?grlsSbyM0JF8JBOlHeamk6FEaaqW/dkXp79UL7yMYnwVda2dcu1wWX70cpVo?=
 =?us-ascii?Q?+0tbxpP2E6K/iikouxTFiBh1ctRTC09KFW59lI+IExXbMudxkQ6ISvjnjfEW?=
 =?us-ascii?Q?JLJ7oOy1kkRQ9LL3lvXiTmxuCm5Dw+jjIxVezjebyQIH3h4EKQ01Csj+qOUt?=
 =?us-ascii?Q?FqEBtJ2j1TSbmwj14TTwsstkPdgqwX/A5CeuSOpuK4Wd/9sFgmSxGf7qvrDR?=
 =?us-ascii?Q?Gyk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sKeFW5ymodEmYl2Nwp8SCZLxf7xcPOFQYr7WjJPA4rUFuasZ4k6u79SF424E?=
 =?us-ascii?Q?ml10Dnlw3OYfVfn+oGLk5OFT0uZm+3lCWQhT7BW00R+2a0LPAefdebAfHbz9?=
 =?us-ascii?Q?o4P0j9AAz8L/Fd67H+vp4/lZ3Irzsey2KN4EU+TEJ6nrGyzjJnCEQuNz0Lq0?=
 =?us-ascii?Q?ZQNNQlGmpOmKxff8U9j+s0cyK8C+3w0fh8RTGVt7bJOVhTRbl2d/amm0Mo8u?=
 =?us-ascii?Q?qGpqkMHPMpgCpr+681N4kw+09q9ivR3Phh8FKobUUw3XT9nP0WUBVukIAApz?=
 =?us-ascii?Q?2LK3+Vzd60j0w9LNdEY/TsIERpeOZobmfoSFKlvpCY8CWnjDdUzg4BGcbLv0?=
 =?us-ascii?Q?re5RyRN3EnuEzePwGV7F/GXMzeQNn9LReKb3sSmB/hPeqw/dhK4cURrLmMo9?=
 =?us-ascii?Q?zajFKcgkc3VjuulaIPE0A2Ya+ARvV3OUCIEB7ZudffjtN1QWWYgRzn0ygRD/?=
 =?us-ascii?Q?YFeB7jFOchyOeoaAru0nwxnDNoEhM03GkWT5gvVpRuE3DyAVzPGEbUki3a35?=
 =?us-ascii?Q?yR+YEZ7+8Fe9cuscDCIJzkq/pv/7bLXZ/yvALbmIuHH2iOmNYxywb8dz/7Pe?=
 =?us-ascii?Q?gxdHqffHptnebnWQqEVCknHBmfIScGPZ6SLs3XGFd2PIQAzGThoU+RzKUgYy?=
 =?us-ascii?Q?q6uEXIrJ9mwqHqtpt54qBh8D+5pvo2MshufMjMUcVGJ1KWpTwF2UpVxBqf5u?=
 =?us-ascii?Q?PCU2JEFSnulDY5zQcNtEqrn52MfhSVY1mR19MvTMoBwIv31PVPigtntukv0Q?=
 =?us-ascii?Q?5SyLuOagylIULN9oV5xKCjv50FkSEWwpqzcEafip78cVV67VxM8b82rwJn/b?=
 =?us-ascii?Q?fj7qSeH9jAxhHvbLTcvILiBZe1haMNjTzNt7NacOLl0xuOUoq8bfBUChvT4+?=
 =?us-ascii?Q?DdMPdz6KGiq27BN/z3P6b7UAXtlUGkxqCfotp7Mcx6m6u5SQYJS2qNOJDqZO?=
 =?us-ascii?Q?YVDAQQgkVWtScyuCHjIX2lJP2o8hmnLpNCYz/9Sxr8LezXHM3zP8UFqA9m5U?=
 =?us-ascii?Q?x9Px2VG+fz0QoUqIw+XKN2IxtF8QoLpsIpyev6pv+n/0iO0tZuM1v9ap1O/G?=
 =?us-ascii?Q?CgVtCmPCATS+30AwbAd0VLtbrzIatr6GVKuTV630Guul7QA8f+2bd6ugJ8vj?=
 =?us-ascii?Q?PLpQXW006U7gQE3Gh00fUl6Fyy3wsbEs7kztNxA1TkZx0NL0kRTn8kaW6Kyt?=
 =?us-ascii?Q?UqSxDOzovOqRlmoWKAvk9Vt2M1/XNk350ac5Acevha0DlaItit/YiiCA07fy?=
 =?us-ascii?Q?x4wq+xoiIg5jLYg8gStJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ecca9-0280-4c8b-2807-08de2c8c7470
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15552.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 01:38:10.3014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11201
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

In theory, for the same vendor, we should use the same instructions as
the spi-nor-core implementation.

Fixes: 72151ad10f8d ("mtd: spi-nor-core: Add Cypress manufacturer ID in set_4byte")
Fixes: 5bf3f3dd11db ("mtd: spi-nor: Enable QE bit for ISSI flash")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/mtd/spi/spi-nor-tiny.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index 23de64a1520..cf00473ee83 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -220,6 +220,7 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 		/* Some Micron need WREN command; all will accept it */
 		need_wren = true;
 		fallthrough;
+	case SNOR_MFR_ISSI:
 	case SNOR_MFR_MACRONIX:
 	case SNOR_MFR_WINBOND:
 		if (need_wren)
@@ -246,6 +247,9 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 		}
 
 		return status;
+	case SNOR_MFR_CYPRESS:
+		cmd = enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B_CYPRESS;
+		return spi_nor_write_reg(nor, cmd, NULL, 0);
 	default:
 		/* Spansion style */
 		nor->cmd_buf[0] = enable << 7;
-- 
2.51.0

