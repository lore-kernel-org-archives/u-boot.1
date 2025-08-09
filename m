Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5554BC87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81EF9847B9;
	Sat,  9 Aug 2025 03:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vPC/hKfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3463847A0; Sat,  9 Aug 2025 03:05:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BC6847A0
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcVEx6PMPvNUDlyT3TPm+EKJ+EOrG/xq6Gg68s54DWv/TVIc/5dDW3t8SyUqYdWUPvCJ6T1NZPQTRmKBQufSdMfvUfMyzLVSbqx4Rk+dYQMXRo/W+1I1AmXlCqSKaghbweSj1kLrodz6BHndnI/GUJiysBxk9MKkmlJThIB4nar/QmQY3urAh74fb0dwnMFlMY8OAyKMVR7QqW2/iVh4HTRRlKJfvC6PCT5UpC3/ZHj7GTL+ev71S4acs3sU477fzSXxmvS62BLuSgVx2SWMTnH5crVBprkOmbMfmSeKh7AloiISuLsuU55MJBCB9vsSVxHd6qqcRDIqWYQt7xK8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpbXnn6DY20jJOtBeiQ5nd2dW0hUh87EMimBLfaBjVk=;
 b=aCgPhLhhhEMpRlByp619lznDDadcrGPIuYf0PYDloqric+ARb7GYEZSz0xuVicyIutoG9otv2ILvmrbm8nd26fQ3oRUlzB52VmHDj+E9bIYg/k7Ub7MK1qZWABXO9Q/2Amhh91t1DzK5DoJ/bQBWNscFYUZW6TJEBFwz3zqUSJJiXsS24KLlzjmcD2BVdhy64SR8fc42ptsVEBfCCfCOf8Gq7npiX3UFpq8v0IvP4w8Jz3Sub6X9XGgOT3cZLNS8/NxBVlXCA+p0iyRmad+KnpUjMXF2UeYGAPMWehiZZv9+adeqNeGmiAlTyaX8MbELSqnBRDsD4yB8ze/H2pBPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpbXnn6DY20jJOtBeiQ5nd2dW0hUh87EMimBLfaBjVk=;
 b=vPC/hKfqWudNIyC7sLwnvtD18YSFgYA4Jbi4rfoeQoGOVEmQw91ZnP83+NZogVXknUzbmZ5uAzt/Mwg2OPI5fx4L8rqQrRqHNoAQHM/lebBC3sfakzyP90A5f5/VrJA8zSEaNdHWs8aSOGOB/RNYwzmpTmbY5DMwRZkFvntQT8v5DxSAU3AEZjOYNOfOY/ywL7JMm1qUC8gpQOlIkr+xK8l22sPECaiBvQ6ZmlbwoXOwyPTyBKMBmWzPrG1gHnVJNMhrs+KCYewTDGStXot/plqQM/X9KHpmI0XILVRc1CrW7shFdFiWNNuup6G3Wor5kZo7/ryl3KUGdo7SCL37uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 05/24] mtd: spinand: simulate behavior of linux's function
 spinand_wait()
Date: Sat,  9 Aug 2025 04:04:37 +0300
Message-ID: <20250809010457.3125925-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: a89f6545-a9fc-421d-95da-08ddd6e0ca47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PcmtMPUlgzL6Oxc+AeAaivWWQ8Du46w4nJIiog5LDBwtyQRMOZNboFhWD//v?=
 =?us-ascii?Q?eNRE0Cbqqux5nV8/8c4vYgEe90q+nxUNWrm45OnwlQUYQZy5peevNqWoVgKf?=
 =?us-ascii?Q?f1/7Dg3hnunrT0/T5pfSBQsanYG9TozDf6j/Bmd9WVeFEnGktb4XiC8/i/hl?=
 =?us-ascii?Q?l1BXwwhcMa+QEuhnTTdVL2jw3L+eqODFw7WTLD/vIFZvWbtTy1Gmp3QtvTmN?=
 =?us-ascii?Q?g06LSYM+ec3RvDB7CFJvs95pe+Tj9Ju9rSd8c7R2QmXqqtlegYGsuA6hs3Wk?=
 =?us-ascii?Q?P0bIcQNXEg47xsglJ/SaOUIQihU8V8GS49COaClZU6pbGSAwbic+48PB/NHY?=
 =?us-ascii?Q?nkUdukVDlSSLXuQXQxo7gtVtQTH1shVTdHl7aFp6EEmzB0Q7gqcSGxNJTynZ?=
 =?us-ascii?Q?0vio13W4BZKQDv9NxGLBgyXTZTnEFdioqkByRhKBQOPFTpVrm/UyeZvN0K6U?=
 =?us-ascii?Q?vKU877zU16eLun8uiU8gd52jF+/WdBhUaNdtg7ci7I61ySCPZLUa6B+IrdAL?=
 =?us-ascii?Q?JGP8pI0Cu84Hwo+9hw4O1dMZh42Lo8cvV2CZW0F5WIBsruaGOXHy9e1a8cJZ?=
 =?us-ascii?Q?2yFYgMsmw9FajnvnlVNDL+LEbKd6LCWL3AonXf+raxOyLnfMu8wmMbCwBrhL?=
 =?us-ascii?Q?DgMD85ZnG97bw4QjqiRTK+e/uesnyPLjDdMgyzSW4SMLr+UMi8VBh4l/Tj8c?=
 =?us-ascii?Q?RzuQoEw5vh0SnPBFs8nOVHYTlrAtMrkWqFjDq3iOww2ly6fQF3cQ7eRjlKJt?=
 =?us-ascii?Q?c11I1elJmMA7tZmC3jgsMKiwKrOt6rQK/eN6txlf3jNiY2EpsMSZ0vCw0G1P?=
 =?us-ascii?Q?6ZafAMfS73igThLs0LOY9qYFUdc6IEpu5MCUo70FCGEbsthi/eaZkYZRxdA3?=
 =?us-ascii?Q?h/busH/NLq93ueEjSdE4c3Q4CLEGIV2mVxlWFj+mvKI5qivMOVifOPN/9ePw?=
 =?us-ascii?Q?hRyUnsZs9xaLaOIKQKWO2iU1o258pa3442kYTt+tD82Xh54a8u2aNb+HZ6ZJ?=
 =?us-ascii?Q?584v0RrhJn1f8oiEHeDnNiis3RqRgzhb1ZuXRQJJzFeK2qR/ZDRYt8+q2LaR?=
 =?us-ascii?Q?tjohARNk6OOsVlHocWUedvFkne1cgF0+A9NNaMgxdqeb37x6ad0wQtCNOx1y?=
 =?us-ascii?Q?xypyEQQZzdhWEr7w7A3ZabTTs276/oG8bq4AnB4+aLa9K2uDfxrG2hBJ/v08?=
 =?us-ascii?Q?DVOJv++2xqlyOHtJmoAoRZoZJiucFBXKqm4Qp1Ph8nZCRwOmvmPsC/ZosC59?=
 =?us-ascii?Q?Q9fnfaM+tlF3yj9jAXBZVyE99khaUtvbuBKE0fVZkcjdi+Yi40G77y5foRr9?=
 =?us-ascii?Q?bihDd3Pn2MOPZNkZaxLeJjyHL5TK4DcTdm/T5xRrAUDBalDGK0G9V0CRtRZb?=
 =?us-ascii?Q?Mfl1Qs7La6mgaUIVJtNJMEIrXSYVrxM4b2nwkGJaNUg94Il2YMpGCYabnCbN?=
 =?us-ascii?Q?5qGD5YALNUFn+4xjhLU2ep+ojQep9XKAoCruQSRlmwRpTTBlTSrsDBLhqcQQ?=
 =?us-ascii?Q?GsNcUhLhT+X+klI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXPt2jPmmLSWy4PL21SI8ZYZI/22PvEnHnQuWyp7cHKAaBxhfa7/RiN+Op/R?=
 =?us-ascii?Q?IzrODjzgdSFV7CmXmOilEoGFbPfRxbuLOSSRZF/tlJZmtD5hCWOKI8/DouTU?=
 =?us-ascii?Q?S3qsND+ojuRqwBrYK4UiMIIwyn4bSqiKM1syd0AfwJrxj5NQM3wzuahnWlcD?=
 =?us-ascii?Q?3vJi5A4q5y/yxn8V3Yz5mWFCQ3H6xGPHtQMqpm66aCJj0ItUDbY1YKhBi2EV?=
 =?us-ascii?Q?lLICMwTuWfQYPXpjsAs/hvsVtXw59S78C62j0kRmxsWTKH/xPE2KaudR1mim?=
 =?us-ascii?Q?Ed/MSJrEHCcS3NeM6+4BTy+VJY9fGf3ohmtohkeyKKZAsjyVYEbtQgsG6I+e?=
 =?us-ascii?Q?DvNbB4H5N9pfBgea83vUUxIkgU1xB1ByqeHoyccHEpX5Ek/wEWUt8NrhHzmp?=
 =?us-ascii?Q?33jj2G4LDH4MFYmy67zH8Qn8s4N3wEA7LubSUO3+AiQvK8PN/M/U1Q94jUim?=
 =?us-ascii?Q?ibflrWVGxEpiq4m/uhMIlA+UuOkaI8Mqevh08Feh1qcqvB661/mWf7FVg1SO?=
 =?us-ascii?Q?tJ7B+wh6oWyaN25FheZ7kX7UjvaH2dY4wORPV3DdKTvSHZnur1YbViayyvXE?=
 =?us-ascii?Q?XuChFl1wmAW5sOe79ftQnDiTvfZkxhk+S84robtTXv9ORlY4o7cZsdODd2Yb?=
 =?us-ascii?Q?6h18GmWf5cnYG+Kk1rKqUidu1I9B2j8uSnpYUK+ClUDgRONURH/ePLyM2ag4?=
 =?us-ascii?Q?qVA+hnJggSSeDY7z4Ryn4BIbob3IdyUBONfBG+QmjhJzDXbWmCE6Md04gYYB?=
 =?us-ascii?Q?WMiG4F0zUtr/duhlDpaiuxSKSRdVB40Hkimdry9N0Qr3fiiq11myANA42pjh?=
 =?us-ascii?Q?orpOwtCTjOHI8NXxbDg4YorV6PygOVlLWPd1FeX74YjmF0KD5jF/oAhoivPj?=
 =?us-ascii?Q?/do/CU1J77D4T7jKHfL1821N/KjP2WWtSMwuUxQ3ZnRG80MhhFT5IgtApCDj?=
 =?us-ascii?Q?nZ5HJrmKSPwwsg7Ve8qsVp6Sx7Sh8hbhczNUQbkLSm7xAi/TkPdrcvvU8Wwc?=
 =?us-ascii?Q?a61vm1orRZ/9BZOnKF/8I1ve0q5fkvJDkIHalZzN8Oxe2bQnHBjkB8QBgr5y?=
 =?us-ascii?Q?4IPtZN1twzaQnrkJ4AOP8rOkvUr87V0ozN34vlyh4WZqkjlHBL9LFaxw0aaf?=
 =?us-ascii?Q?PFqM1FPooVqZiOn8vmqzm7sTWbUUcypj4fXSvyeke5X4LrgGAoLib1pSUXcN?=
 =?us-ascii?Q?ujeY/3RXrfJT6YjVaGA7E5gyc0oNhjvIyCQUruqGGD9TDGDuoSW5jh9F+gIG?=
 =?us-ascii?Q?qbMGqR95Ad1K/ZeWXvuc2JX6vq0hD35aJZdZjYGVA4fVbupNcGQrP7dZufDT?=
 =?us-ascii?Q?IBMJFCpKatB1c0KLmElj+3kdIqLUqd5XIvs3cgPr5qmgcbueV3/gmXmbD7wd?=
 =?us-ascii?Q?b9b6FqirT6aTk1hz9FYcfzIOojx8fIpyB/ACl6xbP3aNZQJ3hkLbOilHC803?=
 =?us-ascii?Q?ZHW8f5s+rwCWRio7pEcF7hPW/Q+oFSl49Y/QyDc6ou+qHZyCVHTwM6pKiToM?=
 =?us-ascii?Q?uCuXnmbJ2r+BGcryizZxTkYPV2Wu2s0tcdsDEN78ZA3fUICCCchJj3dR1RSU?=
 =?us-ascii?Q?KZaUGhActeTI5xmuQGwsSMZFjyk//nbJfkkt4D+KCvq/j2fIxIvwUuZzepfy?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a89f6545-a9fc-421d-95da-08ddd6e0ca47
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:11.2682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZK1tTtGcz8RVRxAFiB2oRGRTNFwxRCMxc9bdXWCOp+/1eLdWQCCQTgkmrBSdMQAkpbnhLP18F7dAQMubQVjAnM2TJPvr54C2EB6dF8ooTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9861
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

also call schedule() to allow periodic actions

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 34e5ac33c63..f99568050fb 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 struct spinand_plat {
@@ -362,21 +363,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
 	int ret;
 
+	udelay(initial_delay_us);
 	start = get_timer(0);
-	stop = 400;
+	stop = SPINAND_WAITRDY_TIMEOUT_MS;
 	do {
+		schedule();
+
 		ret = spinand_read_status(spinand, &status);
 		if (ret)
 			return ret;
 
 		if (!(status & STATUS_BUSY))
 			goto out;
+
+		udelay(poll_delay_us);
 	} while (get_timer(start) < stop);
 
 	/*
@@ -418,7 +427,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -466,7 +478,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -498,9 +513,12 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
 	return ret;
 }
@@ -702,7 +720,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 163269313f6..ba6c2ba149d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -176,6 +176,28 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+/*
+ * For erase, write and read operation, we got the following timings :
+ * tBERS (erase) 1ms to 4ms
+ * tPROG 300us to 400us
+ * tREAD 25us to 100us
+ * In order to minimize latency, the min value is divided by 4 for the
+ * initial delay, and dividing by 20 for the poll delay.
+ * For reset, 5us/10us/500us if the device is respectively
+ * reading/programming/erasing when the RESET occurs. Since we always
+ * issue a RESET when the device is IDLE, 5us is selected for both initial
+ * and poll delay.
+ */
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+
+#define SPINAND_WAITRDY_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.47.2

