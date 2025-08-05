Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D60C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C42FD84213;
	Tue,  5 Aug 2025 10:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="i+ODvYgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A05D84198; Tue,  5 Aug 2025 10:15:55 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D82F084181
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLIKDGLRyDc0LtR5ZkIxQF0j2qCRAfs8o9xFV4RFGlhzgZrLoGEwA8fFtJDHTgwXEYUXkDr6AbSBR70oupMwP2SZZ8CKPNguMaOIYyYs0IF5h+lZb1q/h31PYOqeEmYVjFSmwhhWzS3Y5OzKUYNe/R0JuKF48O8aA66u7umTxfFEOsCjEyYDo1LzR2rf5J0UaAMSlKHJnS5hyeKKCgAI0m/1sXvNUsMzx4FKAB3V4OOMGVJtGVqXhIk9IAb/BIYrRD27c/CcqigrUqzNQ2Immj1AiUhSjZBx48r/7o4ZxkIFnEVXFoHpoKiXNsDTn5+gknSlmIcpXc9RyzsfRI96og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIkt1B130WKGz5u3AEjJ6vs9uB4B2KpF0QoyhiQvK3c=;
 b=pk/axstd0eZVEizs63V/4mWLTaOZ0q9vLg4EQLPZPlJChp0YeI/70DpTsMWjG/Ik8ir2g3Dkd/gWxC4UyzcniygybXX4WU5U7wmgkhgOsvHVNOHI61axjpO/5Cde2RyrP947VpIp1hKZA5YyLsMf625/GGGc4x9OGZukHlFGUNpDC1ww+2tpUkH5EqI5/ppunLPz1ezeDg/Zu3eyUm81/uiUChyo+EofV1MB0IRIfylGZ7mMgXApTrldfoK2QuWyB4htOOh7Ivsca+JM94a2HKZ6z72A9NM/EtU9Jn+Qdti0ULX+8dgObrb3TenP5rS9Tn4sjnzt5Dmymav9V0N/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIkt1B130WKGz5u3AEjJ6vs9uB4B2KpF0QoyhiQvK3c=;
 b=i+ODvYgIyzh1341sZWBjCi8E7zk2xs06yxWIjFJLh5nY+mcSDhnsYzo3F2h24IOnK+6wzima0ftUAwaxI8rZKZZ3jR+2DdtYd+UgIEf9v8tvpij6oQUW0KsTFKVSPHqj183r4UDJ8HBNO3Jdf/Xf2bG+i8VYI8PkxamOjBUERvuZd311M7w7Vpreknz+egbNo7+TtZPvJC9KO+S9Zxw9bLsQvutJ/h5+1uel/+CqQbuHXpB+4Z+0DOzbUaqUa9Kbh3UcUjXxNjILT97YgBGs3kc3ICsiCzOAzF3AeJU1ZJrkEGUP9+rHxe4TEK5gu/F8rVExMnay28BrKWM1gv1Jrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11069.eurprd08.prod.outlook.com (2603:10a6:d10:139::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:47 +0000
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
Subject: [PATCH v3 22/22] mtd: spinand: repeat reading in regular mode if
 continuous reading fails
Date: Tue,  5 Aug 2025 11:15:11 +0300
Message-ID: <20250805081511.1482964-23-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: f88fa72b-ced2-40b6-dab2-08ddd3f84863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f5hPgCfxLtjFp0tPCLMCXbuhtzphqCwemVTFNc5N/pS01++v9bZ+zEGGTHim?=
 =?us-ascii?Q?6B43IsEqlzl4l9AKOH2Me3/i4hZGbBIrGxFLjYUflJaq3P4+AypreyhS1a8I?=
 =?us-ascii?Q?eKVuHRetsBGpkUEA8RqpenMjZWzjGAlkC7S1a4pP9nfi4nWJvwf1yuKdKfyh?=
 =?us-ascii?Q?jiNQh+nwIX7Rne9LxG080Ga2Kfq5KWh9qLxNstkFBlcifsKYr3MumWjix+tk?=
 =?us-ascii?Q?h2YWJCDcIfVcKRbHLk5iFD9Ze0Shf2UWBxwrXZelQzBpmnalf0HskfEG7lI8?=
 =?us-ascii?Q?T/iHPKANHlf4G8lp0zwnRUBp7/U0GtD2wBm84b3oH5ySrQGX47z2cwfNqnDS?=
 =?us-ascii?Q?WUwsIkTx4Ax5dijH9P/KfyeXJ+K0ShDJNT6NZ2xfhPzJ3cVAJiCLZJ1MLAxW?=
 =?us-ascii?Q?fC1myYcirwGxCjQuZbFJ/vkbl3Gs8IMV0QitYwJ5CNhmPfQqEjbqQNBVnIyU?=
 =?us-ascii?Q?oBdz2e71LwZzTAQ8B94CYvKtghDfAwy0PNSR+zhF6wL2acvJa9B9JJxM8j/n?=
 =?us-ascii?Q?g5caqdPjuNwlg9MFscGqE1Kpq5tdXoq0Omzeszv6nTjyb0O2nGhTj7iQQqyD?=
 =?us-ascii?Q?HxjT/YXiEPXQqM3qdXbBP4HYCxi8br+wSNw/1/1nTEDmci35Z0BR9Ai9I1Ez?=
 =?us-ascii?Q?LvaOU7/teUc8jGHZKVF3DtE/Cpfv8ei4l1Glg8nHJ9BrY0vPafuO9IkqJYZ8?=
 =?us-ascii?Q?nXpuiPunVHLwQti16CNWQ/9Y0KjCMAcDHvIp/hmQ4FnZNWo+OfiMovuqotEd?=
 =?us-ascii?Q?WrnATdAKSjFBcwi0ZAhPRABBnmkBb+aG+tHiY+5SkGMEis6xlu+NDs4zpU1T?=
 =?us-ascii?Q?nrOVURf30fRxsPXS9uuOb5KdJ7ugqdPAzuXSxgEJwYVi6JHYYhVy+ZeknBUJ?=
 =?us-ascii?Q?OxUMq1PTN0uGysPQWjcge79YSy4nLzZBW3BbfHv43DyZmJVARrVSlXInT/2d?=
 =?us-ascii?Q?qnV7vPWUNkBRvtrmwXvUS3k13ISjcJrxgu2ASl602tRaT2XyaBQt/7tQRbzG?=
 =?us-ascii?Q?FKJL9byqIJ8UEHj8lADrdOkDlLIHobWNk+hSbouEUdDuFUNrGOz8TA8bLLde?=
 =?us-ascii?Q?j74aCZLzWdon+k33npYbdNVByoNfjKCyTMyXUsO/2TztMX1EroIniC4FbcO4?=
 =?us-ascii?Q?VfZUfW8N75CuxmbhY0XkpBCpN2v9doZwdziactrQhAdLe3ro2fRplfuV4/Fz?=
 =?us-ascii?Q?SAOyeZx18jcRy/AMWAv/eFF9qJSlfZ/3HI0cWv17swPExduSccvbrLwnQvP6?=
 =?us-ascii?Q?Im00zEivc+dFFH4iKWKCBT8FIKMdhQclSnsujY7mL5WUGvRCVHF/QpddjXGG?=
 =?us-ascii?Q?torlikHyo0hXax/wbGh05g9cUbqhor4OZxluSIpV0DKMBhmmGYwh8h3x8nYS?=
 =?us-ascii?Q?C1WbZ5yp/bRlpmfhOO5sOr4SuuFJy5vZbK0cmROWIKHSOGhSjoeOARXQxG5w?=
 =?us-ascii?Q?dU4qRiP5hfjdLatzLI1iqZ/+vDugML24H1if+Ht1PEtQRS7LGA7rxmxvXpP+?=
 =?us-ascii?Q?T769z88DD+qQx3o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UPYkpZEGY0gwQUAGrNiwBz8x1xWfp9ukSyohW06jEb7g2jtZTYf7CvtsO/9S?=
 =?us-ascii?Q?uFE1EGW520ygMPTZJkaWL8gWLNz0cU5tDERCY7A1+eyg1RN1HHUV7O+IpN8Z?=
 =?us-ascii?Q?HBHPEHaieLdw2WNxljabYo/bz44C/4Efa5JuurGk7hO8VzptXM/BLtmB+uHL?=
 =?us-ascii?Q?e+WHZmlxGaVc3xkmzuJ2yw4ubqCViNgerB7KDVUcGyXDGNVDu2CnYdhQ6owN?=
 =?us-ascii?Q?NJcYCOnswkc6KqnIaYb2wOnI3Lk7vbgE6Cp/iI01NEO6oc/4oW/W3z+c80ta?=
 =?us-ascii?Q?wp+nO87fmwrUK00ZB6xShWHRDetBlScmNX1P/GhaTL88qjXQPB6bLLuinNym?=
 =?us-ascii?Q?teBP0wN1QROzPNoYLBUUP4H1oUCB2daMoO+XO7+HZBJAXPrvgGGu+vk+4mlq?=
 =?us-ascii?Q?UeRJ1n4/oJ+4xEH/0cmWWF9EnMie9xecRNZJCB4VQrIwP4rt76Ww2odZfC+6?=
 =?us-ascii?Q?4jRuSeSRTO6ZxoJwjp9gZVBwBhuSWU37W52uGGMWcdBo0yFIms2mTtFmEHnZ?=
 =?us-ascii?Q?mX8Nndng+OJUhl1whrSjLQqakptJxbobGMW6mxHu3fYYHHjjQ3khXj9ss65Z?=
 =?us-ascii?Q?FKRCZ7eXbuaa4QMVTpMHijlxEVSzgZAsMCckJoKnZq09OJsBuUGDDHzJkdDG?=
 =?us-ascii?Q?8bXiTajOc0VEQQaYMHZ6OaCqCeA9cg/9KalCbc4WrrU9ITU2vEgVQJBr+aTJ?=
 =?us-ascii?Q?Cio+gon/sZHebj3IGuRZkr6Dg7mriMojl+aI2bbK7Gd8gppZzqoqA53YhqnI?=
 =?us-ascii?Q?mniW5WX3uKQbedKrew2LtKh170/0OIjMGoOPvJDf0YJR/acEaeKjslGqlqt4?=
 =?us-ascii?Q?AwEb89LXq/APw0KmDkBXM4lq24Z5P7/IXwXPC9/oD4QBudHBGQJHJR8uKI2g?=
 =?us-ascii?Q?smndo1BEQNBQxCbyYuWITm1cFguMsDHWJvwAJ7/ZtQ7+oqUKCFhjiqau9bdj?=
 =?us-ascii?Q?DLZEMiH/Er+xrHrVP09qW/lue+Cr2gkE6nRziGqFocxXVBRepLVUuDAU1eEz?=
 =?us-ascii?Q?qo+jispmbAk8/2lCBuRCT7ii0ACtFwyTUwPCRtfBmr08LB7CFw95xSyRLb9L?=
 =?us-ascii?Q?QzVZG8+AGmqD4pEcsACHe32qOS0PAmY04UN09viyBLb6WvkZO27l5GP3aysv?=
 =?us-ascii?Q?XHjOqCmCKU3P7aeLStII+t4pYuZmYN43A1YBol98Lzq+buU8AiBs87DJq2FB?=
 =?us-ascii?Q?nM4QJf2mqTY3gvP1ter1D14ALrg1RWSKyszat5oZC1uc/F3isU6960d3+icg?=
 =?us-ascii?Q?80eROx377+veWp5KBEHJ2EB2SQEq/6/A7/a4/1N6FvCDYYbUV4O5zRNX9yy9?=
 =?us-ascii?Q?oN65vwYGoyISoqJgv1Rw7RqJA5M6TfVX2KodHA2it2yh7zabLRv5Iyrs/Ng5?=
 =?us-ascii?Q?7afEl0FH5F1I9eU2+TpR4n0XGob+tpLpHafStW4+8633RNTFrm+hZujZXQOC?=
 =?us-ascii?Q?IM2XKXFjoHcCOxKFst27pb+wI58K/ughvmoQct9QH5y6Gg7rP4885hfnlG0C?=
 =?us-ascii?Q?uxjqRvCFIANKSLwry6B33Skl5sH/Mk4IsxFJXJ8JSEQpEPj7HRPnq02caUe/?=
 =?us-ascii?Q?mvOK/XS0LOxzzUQan7Gls460TWqHA8rjoRDBQQljIW5uell5dOONNmafq3LW?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f88fa72b-ced2-40b6-dab2-08ddd3f84863
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:47.8099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsC/sE9elU3mXBRFpskyvcSObnU3cLl+5oHkSy7DsYyzfVj132aGq729RBIR+TRA9GE3WrxfIr/ax1jsul8EDHffGt+zJtDRANN9ah2COJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11069
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

Continuous reading may result in multiple flash pages reading in one
operation. Unfortunately, not all spi-nand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e9ca2b3c391..89c0738905e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -428,7 +428,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
 		if (nbytes && req->continuous)
-			return -EIO;
+			return -E2BIG;
 	}
 
 	if (req->datalen)
@@ -887,16 +887,28 @@ static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	unsigned int max_bitflips = 0;
-	int ret;
+	int ret = -E2BIG;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
 #endif
 
-	if (spinand_use_cont_read(mtd, from, ops))
+	if (spinand_use_cont_read(mtd, from, ops)) {
 		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
+		if (ret == -E2BIG) {
+			/*
+			 * Some spi controllers may not support reading up to
+			 * erase block size. They will read less data than
+			 * expected. If this happen disable continuous mode
+			 * and repeat reading in normal mode.
+			 */
+			spinand->cont_read_possible = false;
+		}
+	}
+
+	if (ret == -E2BIG)
 		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
 
 #ifndef __UBOOT__
-- 
2.47.2

