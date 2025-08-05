Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE85C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 503C784183;
	Tue,  5 Aug 2025 10:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="X+VHVqJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0FA18304F; Tue,  5 Aug 2025 10:15:35 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04AF48414B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usme0N+ll6gvtO4Nab/OeSwoZ7SztN7g0Yp2KNS61jHovn5eipWYXUWbO3SKm5vUpcNHSRZ4m+Lvgyzy3XwwG8P0N1oljuR/lH3spwxkYGvdrxVNinPF6koCa4e3/KOkCT+rUynnGCcw5hArfFHztyw4oF+Z5x5N8pzxXvXFx3fs396WIPHkGJp+nWDXz5+EP6QsrUeLCjyRu9cvqn8iQAaAuUSnNJLwr9NnItQbgejj4omJAuwDSeTbNVjOjRUsuqdOI/oK6jeEKQk0I5e9Ra6MT3VUnPqRs8Ghld/4APdYuZK/vsiDvNIbOx9guU/PMW63zEaP6QrU/YYmfwyJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOAGeAbfzrc0hWT1l0NCFo084eRstuMdeXG85XY3aqk=;
 b=p7Vrf+pXVN5IhKQefB9OBXgbEoJur9Zy6WUaGG4QgmGfkiWZOE3I8Sn9vvFQD0XsX8IWMAThE4itlHmovJ1GgTw0J/RT0y/ttiDSvOpo4CjypQqLEDyXclfSFLkLAqNgxFchI2CWgSiBNkSAl33A/UG8bBZaNnBqDJnp0OxOV+2bMwTUgQpgAGW7vZVnoSkegEWUUJWlZK0tmc4+Px1DWlv++JYmqQPcgM9jITRfGaHdzNM7CyGh4iq+SEePHJuMXNhDSjlSaSCLQEj+6PZdjXfm/epp+SM6RTqyj8IVXu+a9dIkLGoJ0VOPZxNBgZdXEry7IHEBZOfDnBJHaGXTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOAGeAbfzrc0hWT1l0NCFo084eRstuMdeXG85XY3aqk=;
 b=X+VHVqJ6d+vxDK9pmWXiUvSV9oTyex+AtQeJAoQ7RjLH7tClAgsLmeD7OjlnFtpvPLcxGFVzz9myGjjvN9vowKTvVjE52fmnokhL/n5mkNogYjPbExRq8Kj/jnhQGOIx7EmMxGJ00wGveNZHPOzO6mx+gw3VLT35jwAVrMUnFuqjpMA3aXG5BemfhdCiqoReB4cPo8VMAI01d+66RGK1zRAevPjeFAoa/riYID9ThRYwKWKB65WGwOdGVqMAtcoX4GSN0Orj0YxN/DGuXfJ/luLzqtv455uPu2iUlcDCEluElxUdStsOM38OS4wHaoIhQ12Q+nd2fQYqXTl57seT/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 07/22] mtd: spinand: replace enable_ecc variable with
 disable_ecc and update corresponding logic
Date: Tue,  5 Aug 2025 11:14:56 +0300
Message-ID: <20250805081511.1482964-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 465bcebc-7216-4b9e-6ecf-08ddd3f83d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xxOOZpxX5SC0oKanp7styc/AP2oN9BPBOf767NcxMHmeJH9HBUeQNI+1leAJ?=
 =?us-ascii?Q?4Gpon6W6blPVTBZndt4O+6EQrKBWuU4smAxWzigvhb3+Iq3WB2Gp279dqbkJ?=
 =?us-ascii?Q?VPbo5eL3gMsbznrLFluZ9IwhV4tkFnvGnT5KGP4Hi3D3unLyyhPHQz9aJlKj?=
 =?us-ascii?Q?B5UknPcx9I8s76Lg7MtsIy3zCZoHezURAx+OXBOFU9Fju5XGyRXQjcyFgK6l?=
 =?us-ascii?Q?2FysHWxjE9ftCpEvIamHwfaB/FmszzdbaN/aSpEMW4EyZ4b+wc5yoDMl5FS7?=
 =?us-ascii?Q?mxALObc42gJ2qOim5d2+bjW6yrO7na8Yqj9BziEQ4ZWPjhsOofKKZqMRkNTC?=
 =?us-ascii?Q?g88a4GRlifKyOxStN+cSKJQz3vVePVKM76D6+itBSGZtcYDr7lyoAlce5LXV?=
 =?us-ascii?Q?cZNTQIUkmuwpYwfMnzMJ1cJP52aBRioIOI6v2c10UhmejfrgJg0t4s2LrJyY?=
 =?us-ascii?Q?dyR/MSG+s2e+gnCs1+v8e/XaEoxGLrYAm6P9+/RAWPdITjHLwmHo5qnUichU?=
 =?us-ascii?Q?lR6c+jo3anf8PvPSh69cdl3lM9vOGOwecq8MO6Qns54wXY4D0IfGN5QcNztf?=
 =?us-ascii?Q?v9VSEluTGgPf4r2hdd9PmSbulroByPqUveNhyZ77NHQJ5sEzkSp0ZQ9e8jhy?=
 =?us-ascii?Q?A8pX99zxOqaDhYnqWEVrWOgao5REeEFZa7C+urJJZFkVb1NN5x5o0KcAdcid?=
 =?us-ascii?Q?JY3ObeNnfzAkJ5JXfMwVoUbsu8VwSz0wemytFor+cKGcoSxpwzcYC9owxv78?=
 =?us-ascii?Q?Yno5iH/4En/JZvYiZvJpCU18zD8Z9UiQcvloiDFKjmGLzB53c2rs12VjDo+C?=
 =?us-ascii?Q?wM8ceDT5bqkyOmyBaOwhSZXTgplLYDBp1V9KERcIW/xp4kVrR9wDi7/YNoU3?=
 =?us-ascii?Q?Esz67e9ijhsSJSqsg2M5BIit9vjog7hqMHwryA7Sp+KuiP5UK8UaxckIq7bD?=
 =?us-ascii?Q?eVx8UkX9Uv1AxFbM0JUes0Ib3RM4ELhPkJTDp0NM1YIIJI7ItySbibeKMVdS?=
 =?us-ascii?Q?QSpXs8qHsTAX49C152uQlm2scdwyoeA992lSu4PiKhpJ0BaAMycUH0mbaMLc?=
 =?us-ascii?Q?KayFL9qc/A4BP3Uiv8VFlqWWS/RCrCXlgz8CQ31r+Lyo6jh/8F2CJlqDPPIS?=
 =?us-ascii?Q?q3Z7KWYvfn01E1AHjDwFhO//21w7xC+P1564FhhjBI4G5TdSHlWk0wkoSnAL?=
 =?us-ascii?Q?nEuXpmchSOvXNyyRmZNqYY/2DdO3QX+YBmovuGS4ixchlyHimg1j8uUqXcIN?=
 =?us-ascii?Q?6K1jD26nFXGoAODy+p+/BZmfh/HUdse80tJRkseHrkZL3vSRyGGr63qMz56b?=
 =?us-ascii?Q?DeIeLbvOhxvpmn2gXr6Jn8iLwnMf8yXSlT5/Rg4mNr28XCpU24YWv9mbdq2T?=
 =?us-ascii?Q?k0kK3RvDZ0l30QkyncSoG3QEZ07fDpt38F3bYknqNHqj/x7X9KSIkJNVbTXM?=
 =?us-ascii?Q?19Zw1VzMBelSw94SPZilRbJkVcRYX/igCqs3Bdsafm0IXaknNC5kxYhIiirk?=
 =?us-ascii?Q?U+6OGql/84eIgTI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NnFTDz0oGQ55mIj6frMlqYEI0qPHu4KWEFAIhzh1FCnnU6uxwqWxJKPIS67g?=
 =?us-ascii?Q?Zj4fXoKlCQIWFLCFkNPTJJKHVPLVTbYMPgb92r3ZKL56qM8yCKG/qvcJL5Zc?=
 =?us-ascii?Q?uGUkxB3x2QkKbu0OeE6vPpZ7+leA6CdYN40KgJFPVTuyrDM/BCtnHF3DxumD?=
 =?us-ascii?Q?yZOTKNVyccPXrregWNWKMNO/oCnP1AW+hd5GbpUT5Knvkbh/zn3UDfMlsJup?=
 =?us-ascii?Q?Ybq3zU02WT6IUl+8mcZ6wjrva3HaUSf8mMCOh1vrrrrFd4AzOtByRMTqW76o?=
 =?us-ascii?Q?ls4HLOX+Obp4uB5wn3uddVbY1fwzUvceehUbhcoW7PFLQLvoQYsxCQRCSSGp?=
 =?us-ascii?Q?Z+uAaTuVwxUTdWSwF8L0/0r+sM3uHdel7IrIxvr0RaBMJHx86XpJEzNbgCrY?=
 =?us-ascii?Q?PeytC6pMjNOww+DF6pTwKGXVDFHyPH8ODa6NbSd47s0IXbZ+7pHI6yqV6le+?=
 =?us-ascii?Q?7Wk/rObj2YP3vvDqCvoSiKNPibnDMRP9egc64X9qiT/4aBbMlDQbJwPTwVOq?=
 =?us-ascii?Q?5ljZHfKmSdqMzZQAwuIIEUsNnWn8ZMBvOjVuCNP8WEw0UQRV9iJB+ateCP2D?=
 =?us-ascii?Q?ZEalLalNJNDV+KreGDFwEMdUVireTVao0XRK3CNZVunRCog3nApSEB869pOs?=
 =?us-ascii?Q?DDpna6D5Cm/9wUojVh7VHRptwjDwSQWPfPoaJbZkiKQnkYISOksvVHukjQfC?=
 =?us-ascii?Q?8rmPGZtvIcROLGtzsrKieYZacanAPgUk/0QUIfUs9Y5/BIWx1a2kkLEUkhJk?=
 =?us-ascii?Q?H2f0daUO23mHnOYAqPRvtl/1rRXvR6pQUDiSv5SURjEp4qKOgjFyHlq49xf7?=
 =?us-ascii?Q?mmO+xCj1AVU3eq5l4VnC+whADnzLNo97HHe7wBVnS8leG6KsWl6zs5ikZJnM?=
 =?us-ascii?Q?Tkmbgi/Sn7t9BtN7att70REC3+xMNm1SMAUV1Og/I/tEI00oB3sJmgkJKxFX?=
 =?us-ascii?Q?iMI6lz3ycm5wooLsltTgddNujhzREPQ1MOhErF9yeNQ3S9tvHF7mzGFCsMgu?=
 =?us-ascii?Q?DFmmtTss+9yBSCa0M5MaFJCQIVLWwfwEXm8Ob4owWXz8Rs1BVY3I1QASfp0Z?=
 =?us-ascii?Q?9eXOM9G5NgiLplNPSPVIPHUZlaJ3F4Xy2puxdDf/0JzBNqw5/aBNpE5yBh+v?=
 =?us-ascii?Q?l4OWAVLUbXMkEg8EIi4TEtngKPkUy7iMYqh+6jF+CjaA8amgiIK+AUXyEl0+?=
 =?us-ascii?Q?33pLV8Q7maq4bx934iydSv146XkhAS7qn6TGnxk5M5tkyXvdMaB3SK2H3aVM?=
 =?us-ascii?Q?hi3lqcKGdplcgvvKfi6mhJ7hMZT8R1m+poRWB7tpUFmJ16BI8uUKiJjZZ7vV?=
 =?us-ascii?Q?ENNqyZpTr6vIjSIZHdv6sQV5mGZHHZOzYw30X+F18YQ1PAlOj0Z/v+aMbd2N?=
 =?us-ascii?Q?iglYkzILlTAH5NTZsPAaX7zLShIi8wp+hF6YUoZJ169zCXwuSSVxz2MtQSjz?=
 =?us-ascii?Q?6viAdhSP7972idZHw2/1drbdbHz9N5irwHa0NKjwoVR0j15MYNJk/Z4kMM3W?=
 =?us-ascii?Q?RSQid5ZDd6ITGW7tT6IVgxwMuus1LrHfwqp9UzwLQUIew0GpEdocPRyBMAU4?=
 =?us-ascii?Q?OpozVVe5xjRhg8LtY1gGRYNcdlBErcPWGHCQCfak5rkyLUDVa55aDTi1isWN?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 465bcebc-7216-4b9e-6ecf-08ddd3f83d12
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:28.8019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pZeSzmw8198AWCbzeEjE/GMsPjQv3h0YVWV1RTUbBJpQwUAVPfrzizKHRwjmmacV+IY1FfGszeUp7SRQ0nIBZQpov7dcDsf3ihW7L13RIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
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

This makes code closer to linux driver.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c16d3954245..098ed0c4cd2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -530,12 +530,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -543,15 +543,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -583,11 +586,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -595,11 +598,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-- 
2.47.2

