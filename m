Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CB3C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6BC8387E;
	Tue, 22 Jul 2025 13:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="fjNlz/yy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1906F83281; Tue, 22 Jul 2025 13:42:05 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6F38833D1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN7y2pEdgT/RErzje/gspm6pcykM9VyP0am/O7vMeOBC7iI7OJF/8hGdTRq9rwXwcgNAr9/FN33Ktf/BHV9gHB6hkkask0e3/BxHOhzvE/o67/sZYlciSQ3hw6X7vFbqnJWnGG6Bu9Pxj0X0Qi3hNcwiqx8hudd9R3vKg29ETop3NTt5SEmFA4rQRtaLy1ci8LcBHEVxhyZiQIOufXFkj9xRxRDSVnDKCucDc09jM4jHxirwOxoWik2XKgFp3IMBo4hhhOlL9bDBXTwp+iFQ+f7mITbhTA5XbkifHAFVTd9YjAPBELOnKlYJldreAfa8aWVM5IyBIWmDAhpGEzv3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpbXnn6DY20jJOtBeiQ5nd2dW0hUh87EMimBLfaBjVk=;
 b=Ex3FMUDACJi1Kh4K3GLQeHv2hB0vkaaj3mvsWjf90UYk5oaZyiRMxf5M+DXz1yQkT1aGWGkyI9TYKVr/eQde+vNdsYcSBkd1q2bnTa1XrjS/z+hwhk8B5BrYKThFria5LVL3LLAoIU0r7iH7EvrVvCiUEY2hAUcsae221uzldTNaLzzpzAotdTPwKLAOwarBV7irSSvyr81ZbGWK83Jq91N2QwetleVM7pqVyHns/F1pRpinFcOH1+Ddip8zLdfAOShUvxpO1sej95P1PauCnraXYnBfAYk4uU1sHBMASiXR9avgO7stGOwY2QGFedsBbCiIZzfwpjBWggT7uWRFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpbXnn6DY20jJOtBeiQ5nd2dW0hUh87EMimBLfaBjVk=;
 b=fjNlz/yy0DQ3D1elP8Zg/fXA3omfruxEBsPIo6+I3NbFI+vgqhDSNibKICk/pngI6E3srzuxujm+8B1HmW5aY+q4wjsyllcxzV5CryP9EbbvVaJPNqI7tlj7Koq9iHvo+yrszLFbeni7nRsmJKMVik3+bTdS6wQPC8q89GpoRqD//W3zcWZYNCw1h5n6MavKbhKnT9QmCyXy/H598imqyOw4hFo4AqV9xbiAKY4kXLoNYrJfGlOEawtu3+Y5vIxJ+qfRxvHQU8c3AEf3grKo0LYpB+9QyB2EHmCSCGx6YrVv3SQB0vXD0qijcu5OlToVnHct0ps4lyZea3avN9RJtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:41:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:41:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 05/19] mtd: spinand: simulate behavior of linux's function
 spinand_wait()
Date: Tue, 22 Jul 2025 14:41:21 +0300
Message-ID: <20250722114135.768998-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ef66cd-4837-4238-7d95-08ddc914c42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IYwZLNkyFIYmSyQwt35aHcglLkFDLrZUZXPN7o7yr3uxhHSZr/EK1NBlFFqs?=
 =?us-ascii?Q?ZZWwqxO9ikBejFNh9dM9L0RsV3+ijfz+zM1M4kw9hQjVoi7PrDqs/7sAjKN2?=
 =?us-ascii?Q?qvGsy6StsUaud5mr/Alvx6ZSpTuDN+SSuDKvq9gI9/8wH31cZaUGLLdDiLyI?=
 =?us-ascii?Q?kUnQpxF2KZFh2Nieq6iSuk2d/DqkNZ5p/DPBVeEQxl8/QdyYgwJFnnFCqvmY?=
 =?us-ascii?Q?4P7Pa9AD7uOOBg4VscJteyBqsMBdX8xPhEjB+9bgJYJOlc/aPm08eNvZR4eW?=
 =?us-ascii?Q?0gTvzYKZu9csUDGnZhkE9peIt1d8s49KvV34l7L84i2nsKUPIPCDSwZ7ZJYr?=
 =?us-ascii?Q?PRFoLHCzz47AorABU9+aTcKPRE+BrYED9uqkmX+JxquagrZodNOrcaf0BCmn?=
 =?us-ascii?Q?qyWJHw4g6EFzM2/SaJ/QojCwHjFXAMMBTy1HXgMJ4SLIos0YZhl1RXVZFIMq?=
 =?us-ascii?Q?VPMn/2kS9J3QoyXXJNcfkOU2WcQthsv3p1Agu5/qezt/fpfwGgSxUaODfBc8?=
 =?us-ascii?Q?O4tLlqrM/eT7MzXZpZpb4wB/bm2oy6uCjjgaoQdeMIudOLdtxC+IeaIAi0zP?=
 =?us-ascii?Q?qVQdxznx4nyeBjPgs9sb0VavM+Q1MfE99bGe4/YobULM42vcqe61MiFj+A/H?=
 =?us-ascii?Q?KMPMCvGe3qRXTGVi+6ZqWt6fUcx6yVdGBLYPwB/qcmyKLFFJF2MTB3cmZGbu?=
 =?us-ascii?Q?KI+HceGxlFgkdBK4nrvDncDQ5VR1yepVYjdw4ABgpbaq/L1QTAHb2oxAYAzK?=
 =?us-ascii?Q?2d63WI6evsVedHiIas7L6iOmBVev/V4MOR5vz3P19b8DO4vhEFroKJWmZVts?=
 =?us-ascii?Q?I/GtWikNH3mf2uYjrQ/HXSkI0BfGSZT2H2DOd++mHvhc/AgNmLm/sXwTKDe9?=
 =?us-ascii?Q?dl6mXGKFsfsZe6eEpqf8w43UrAd4HyvGcj91Q58eX8wCJKu/WeZ2EalUnft2?=
 =?us-ascii?Q?mQxnYtSNwoIGmPGkkQUA2/siWYGIHLK0EQ4q3+R4wp+HtRaOHY7vthyU3p9m?=
 =?us-ascii?Q?Q6byneQ39EaFy4Kme+Q70s3yFjhYXD6/U3GFOrMKc8NVrhbfzrEd45Rne420?=
 =?us-ascii?Q?OBFeVju8aRxBjM+coOLU/ataJ32qJkAZf2kmJOsR5x7C9yy6NkTQA53TpEXK?=
 =?us-ascii?Q?MYjPZ8Kz3Lrf7V86Wcgws/6Z0z9QcW8klPtnlnejGKL4Imt0dY6R2gUyRupV?=
 =?us-ascii?Q?cdLyYlyRg94x1UmoF89GR/G4QLRZk6eubjpK5CopN0BoiEVsgclBAmCao3Qd?=
 =?us-ascii?Q?1Cjz2Pux6nqt0i1fn84TG+OTBIWXb0hWJMGAUKlMmp4/ukcxCuZAliNkKMug?=
 =?us-ascii?Q?7jYR/dpSwqWDsRM/VBuq+f5g022ntH8if6tRUck461w2pFWjL71dxVX/FmCp?=
 =?us-ascii?Q?Dzkt2EAlUKuP1LptEjngjvGlzf0ErC9OM/nStvycRl2DgTOkfIy3oOWLeQ9M?=
 =?us-ascii?Q?1ohqcMJDp322SIjRx8fRRbHf6dVttCiUc7z35rOLJ+GTnC67GwD9/9gJI5VE?=
 =?us-ascii?Q?C275s5twypocSIo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?//xG8umD8R68wlX9d+jb+qwG+sqJVFLP82KSE3XtCum/6HuHcjodNv1a10PA?=
 =?us-ascii?Q?gUB7e42qiyFZUMN7n4fMN4eh77r/KNFfQwmweCnztgrCA++0zdt+0iSwd9TR?=
 =?us-ascii?Q?gYpgGsWVZj24PrjPJ2EvulZVjUyuj3qIWKYGCzhBBaAs0jYTQeIjUwqUVuUr?=
 =?us-ascii?Q?rJ2IcE2LJIssK5m+jUMYT2xASWiOP9mckfKaghBRUF/A/UU74T4MKkl3eqBb?=
 =?us-ascii?Q?aaqgVufWcKWSmr/7Hp3+VDonhE96mWYKb6j0qkJ3HgrlYMYlklzQmZB+TejU?=
 =?us-ascii?Q?dNv4ZImTWUjSKJ8aLkvVa/9pz8O8GqufSrepArezGCKydwSB4x/Hy7zgTYYX?=
 =?us-ascii?Q?8yYoX3Lla6/SMhzwCYynRRLVelZy/w6xlTnX0fA6Lqc9k6TUHRHz/JaGHNo/?=
 =?us-ascii?Q?uHEjS53FkNtOl/uAEE6fkftZOsqo2aPAumh+FZCtT//Id7qUrsBx3StFPc+c?=
 =?us-ascii?Q?qXtHuRJ4VrcLtY2BRYTChnfIC4oXwKknT0nbcCa92TpiTOAHP74zmG4u4041?=
 =?us-ascii?Q?/cW6DxxehMfRrA22Y4Mkbmf8YdRxVC5nT4Ze2EqhJdG3X5C9o8LKWwnBcfZt?=
 =?us-ascii?Q?tT6x2Z/dJK58zQZ9ucWhgxaJNbfRuwhK/vSFAk9yM99Sx8QHM27os5TlPtYi?=
 =?us-ascii?Q?FUktVSRlUsfrcZaSNBWE/Zdks+S1ey/MAlrBndzXkoYPunwMzEynY1AD2oW8?=
 =?us-ascii?Q?ZMDItoD7JyoQS6GmCvqguFBRW5UdyQ1HsyNO9A4t5B0kTYlUNwutvmVhDnHR?=
 =?us-ascii?Q?ppQSLS/I8mM5HNPhVC9Xa5wQ4cpbia1ktLHhd1OGbK5vl8FqwMq5YQbJv5kI?=
 =?us-ascii?Q?VTV+tU0+udLGXrrBBSDYQbW5+dPbLpLjWxCBZMxbthYP0/Kiy+NnMialMyZY?=
 =?us-ascii?Q?NE0rcZmQErHNhdYECvsKSVFjSVdx0V90Kjz7u14EPk1rXJsVJC8MX3S9L1xS?=
 =?us-ascii?Q?KHSCAE+d4CsiBMHyElElBk2yEOFUfzy4WCjhj1tqipcnoyxwxrbkkZ3S+8LA?=
 =?us-ascii?Q?tC7A+fNHxquJysi0wXrSE6bMBZL55QONNJc9GLYfvQzLMOPzwruUTPe/P1P8?=
 =?us-ascii?Q?PqBuu4VGzOW5h73F+WCPDwjxhhqMXi/d0+O/QkkT9wAXMvZZ1z0KnnnJ6yFj?=
 =?us-ascii?Q?cziN43QtgJjmCA6zVNRuYf+gNEt1UFsqLdAzXrFqqTrOjafgPHQljgw/WPkC?=
 =?us-ascii?Q?870dSYJ41+X401tSgMh0BlOzbPjyNWCAUyJxGUPH3qeKP3qZZf2pdYyKEbGL?=
 =?us-ascii?Q?NqIesWvz5MTkJJvO1PxgGHEofOSXPbx5zOzfPkCZQ0vFsrF2SFYGtXNa5J+9?=
 =?us-ascii?Q?6RPYkPE0wMMiit2Bv0L5xZozmCA2bbJVEf/V9Ck8VUgiDfsX8E/SicNt7eAb?=
 =?us-ascii?Q?DktlKtH1Cw9wuCFUlz5y4OHQOp4xV2cr8wcT7Djz8kZZMKph+DakrDoPVZi2?=
 =?us-ascii?Q?82TLhtAa03CdxzZEdSHj4mSxUJ9ggJPQlHdSC/rpa0/TG+9vgPg9i1tkDVFf?=
 =?us-ascii?Q?HyFwZKTnHl2DhFO11nvCDHAICWwgpcQNx79/wHb76yTSvqFdwqmsJNpeyIyM?=
 =?us-ascii?Q?VqwLJb4fYrYSPmpzd8MYneEf/dXTdO4PCocrRbtqolJvuU6GyHiMwIL3z+vW?=
 =?us-ascii?Q?NDzAY9YAR9mzV3gIyxAwRQg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ef66cd-4837-4238-7d95-08ddc914c42d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:41:58.6643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zv7yYBxJ62tJ7SvyfGAH8HXBRqKdLf/mLZ9L2gTCaO1xVCU+Tii958h/1esMD8iaSGXxCqIbOSp1jimUXrYAkcHZPtFbzPItnoUiqtqpv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

