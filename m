Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B49CCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB968410C;
	Fri, 10 Oct 2025 13:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="LAX4ot4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C008404D; Fri, 10 Oct 2025 13:58:42 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E99583FCA
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EltxtgxNrNte2WCdJwEvWnh7W9c/fo6vqFQuVSZGq8knrP+XPikBEinzjyThyqOjlw3MwweXabHbTzjH1eKHvIK6P5OYPqXu4U7o2L3ZaHzr0wVqOKGbrYiLW2nn6BCGt+/eTB48ZTyG+LzbGMn2FVb2zWnTe5yIotNUptOylhNqR3R8WUEYRK5gp3NvF4StksSaUVYNE6DBMtzbzyBNSISAiidQbwKyPILGSUdjQ1ppQlIKZgEsLfLEc2CjuxYYEecF2oI2aCBs+uyzVdtNisFAff3y/Ah3YEjKsFofZSsXKPEfkLDnjRqwXQEHNY9Fj6bpviTVFhikhKFDvuiqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTO59+Z5UMO5/En91MaGz9PznMuT16/Hsyhpko/Sl3s=;
 b=ZwLaaTKxUQEOcSy3rTwgkwCC1KZWuPI8XVCuD1pcWru6wY+AjLecLc1ZCdDrRBDq7QlzGzh3U+xcjJ6gq4o19qn2oF+TaF+QYzheemmz33u9JVQ1bclpu+bR5XhOdpNzfTQRCJ0EYtoigT27Z9VJVyzRuwK39LVaz6f9Xar7ZMaPiMpwjkLgBdXYdS4FcMFeAMwxymjTy1Jw3rBVOVb2SnhyDS7NG6LKQZ439OkdXpWNn8hGEkzHwb5yuhMR2y+/mu6xg4fsEpWQfrZ54FjsPhwvXrz0e163z2T2kNamGbvGPgL5GeSMZu0xgKP79GrB+FE9hXQ1OzeQJn00JWMWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTO59+Z5UMO5/En91MaGz9PznMuT16/Hsyhpko/Sl3s=;
 b=LAX4ot4FB5IlxL8Utc6dYscUt4Phoc0CSehvk5Pd3LLKrIvcI96wFDzLhGrFO1G7mwdW6skREdIh8XcmkEXlGxXslRz/QclF2v7T6KKXwYaLirzBWw4HZOgFjmC9OHN+VuB2HXfvc9ixw6RXt1EkUCgGiraMcORjySAR3NViUPRAmCuuWWQAz70Bg+yyRmOGcgfNngCn0WSZMUAg1esHclwEPzipJqJUtV24OQ5aty2H8Nr6dON/cyxWpwdVkg975EQYg5OP+ikO0X7fINCdBw9TkQazD9JSI8C4jvxd5BHhDzGgA8K2hBV2O5Ehw12g8fSsQG3sdmAs9NVXpWxkFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 03/24] mtd: nand: Add a NAND page I/O request type
Date: Fri, 10 Oct 2025 14:58:04 +0300
Message-ID: <20251010115825.1531775-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d21640-75d2-42d3-25ec-08de07f45893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uuCripL/00cZhiTGGG0yMYjjiorUYyER+Jx786FeMhmoNc4RxidvtC6lidzA?=
 =?us-ascii?Q?QDnj4MUZCri/TXzlH12oR8QvEktgpUTOrd0xdKbaD0Fjwk8WqKuMRjXAqN2Q?=
 =?us-ascii?Q?5kdJHDfCIaHppmXY4jIc07uSXnbfytepzqSEug6y5vGJ0JSrdN30frmUvk2I?=
 =?us-ascii?Q?Wkey+AT0uwl60ki880I1kmKMICy03YagTMtLEoG5o1xsiB5Wppi3q79ONXvC?=
 =?us-ascii?Q?03FwEYynK5+Ut5dS/QrJnGDWCWKRmfWVxHFQjP5/sPhFZvyQi9xYvzJ2z20k?=
 =?us-ascii?Q?EH9vZASeXTr6Urw2q2QkdSccHIbC7gSmyViwjJSNCGQcpnvnBViZQdie/ZFq?=
 =?us-ascii?Q?63mhP81oAIjeZ7xV237t2MjU9x6dIJjlB/FO8EJIO43SInELZ07n53ZK79Fo?=
 =?us-ascii?Q?xHtUbl0PjGZS7Rfj9h1TmAfmnHMOIYFPyo3vERFKP0yD73drj+R8VSHWLgXa?=
 =?us-ascii?Q?Ic8QSKpmLwp45ocfKDkrlo1Czfx7llj1Ta2SkJam+pl0D/dic46h2NSK25jU?=
 =?us-ascii?Q?n9EKbPp3DUQwUYWN6k1lEmuO8CdD5uX+VYHl6IgJcs8xxx4MX3qxkprtYzZ1?=
 =?us-ascii?Q?H+kzxnl+dHhaj6QQtLythmss7cbNEDG5jDijWX7slc4MBxzS6u7hMVmgzRZh?=
 =?us-ascii?Q?X9OTcRlktOj7YzoxAWTBLAjjzUq8FUA/p9DtwVxf88QAkwlO8XegBLy8p7z0?=
 =?us-ascii?Q?Q4JPOqjPH7PfUSg1RjholBSSmNi5GhqayVhZ2hqrH2txJCuRR90oEaDkKMFo?=
 =?us-ascii?Q?nrezDMn5wgPG5CpSTiDlRN2CtaZHOsLbe7PyAGbJmYnyHi3RFcsAMHahfXfv?=
 =?us-ascii?Q?3dOyONiLVxZcwWVWR5kt8bj19vJQLKCC8QBq2BYvpf9Tw3BVsax4s0IHw94y?=
 =?us-ascii?Q?ksReI2mfx9GKlaEJc/DZWs1b6j0sbOkLW+bl7W8zltur/evb32kRVX18iGE+?=
 =?us-ascii?Q?pD0kbzdm0KWliRkm2RCVl5scNhA12ITBidaCzAqXXpws83YcVMgczQq7pP8F?=
 =?us-ascii?Q?U8VKxAlAN9uOKX5ERRRzzzecbhlMxsTwE/caAZu4v2GwuF92WdUA8qtQnZLa?=
 =?us-ascii?Q?KqGYIXuxNwg++RFNtfOH/cIz2O4xTVw3J4+kqESVewIG8I5nWwob5Q6n3hG/?=
 =?us-ascii?Q?23S1EUqvTPMkEy5ZGaiWxuWDBIFYRS8Ex1hXyqbnVVunBr7LSodatE4UcnQk?=
 =?us-ascii?Q?VYyw4NYm+oEfOCyXuCkuzfUR897MeLY5zhODuImN14tNXst8A8TnlQ9lZ8AA?=
 =?us-ascii?Q?dN4he07m1ZabhoVAUX7VYitJJ30yZ/O4x+b5zEUt2G3QSJkXEeHaSdThCJUW?=
 =?us-ascii?Q?JUUuBx1jlC8+Jxn48FexkvjR/Vf3lHMHCOuINkzZ2O7MzZqdzjQki6+ZvhgA?=
 =?us-ascii?Q?CN02AEwlEpAQYPwZkCwCs0Lwuqk+L+Q3wdc/dydMnhplqFsM1ZaHx78jFopB?=
 =?us-ascii?Q?iOybVcFM+TVH0c/tL3jgsOpVqzFg8dtlsJn/L4Jxy4qH+sp+YKgiBMoVeudX?=
 =?us-ascii?Q?YjJMda+1M6t6ICoFu6ADa/ihRl1omCIDqUeSYecIMG2+S3VIar6fHqjZeg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ASc2rMNMTiL/lWvdqypzFuSXL3CtsJ+iJaJJAqwpBClh6i/jFRUhwn0bIcwo?=
 =?us-ascii?Q?HnJjpQZmKpmBx/5L8If9cAp+Dxqh6SZSi9FOkXxenG4J402/B//mTJecMlW2?=
 =?us-ascii?Q?L9IJnrfChTu3qFvZHsFHX8NpWsvrxaHJX50Dp7uFnZc0JkL5Uzz2NLxcFwmT?=
 =?us-ascii?Q?buDeM1IhxpBdT9WYSItO6Ce5DeBdYP0UdpYU1a/geroMkYL5WBf0QTUA85F/?=
 =?us-ascii?Q?nOR19mC5zf5RuM6LmcspZ9Tw4CLhsMDkEHFLKC1KjKPgmShGZ0+F+rol0616?=
 =?us-ascii?Q?29HHbErtr6VSBcG6o3Ta/SBDZiJP/lx/5ZP9ffx8vcBqqQVZQVDMV3qPbkpG?=
 =?us-ascii?Q?pO70ya4mSOPX1+nCpjZdhSQwocE7a8OmgBTBu3XSNzUhhr6tmaNlfMtvr4nj?=
 =?us-ascii?Q?f3g+lzYG8jiEYCZ+HSfUQNutIU6G/CyTDP4uHcwhd16mwfYO7OX3n881HPwW?=
 =?us-ascii?Q?77J1cOMBQG9GomhlhfywVS/9/Et4Yyw6Bz5N7nfRkyiP4NBoRhjy+5u0YpFW?=
 =?us-ascii?Q?dBYyUaYD7E6nP2/8xei81WjSW/zEJKU0MnR71rMlXoDGIx80P+h1ERzwtTn4?=
 =?us-ascii?Q?MGn94zaCB1r9CskCy6yvTMLg5Wz+UBk4LLJqkFwg/68xMK/abChg4t/Im5S/?=
 =?us-ascii?Q?TSkhi5zfy1xeEwLlz/kbLUkArRpAC2Cz1s2iUL2ewKAF273jC8n7pkB/KsIj?=
 =?us-ascii?Q?Ai7n0XJ929w8pmGuaVpoaJhQStIMBYbMkRxO3gxnGpNgehJROxLdIXPx2pgs?=
 =?us-ascii?Q?P+W9jLNh8HOEppbOqnuXwa8cOhgMkozhQVyBgMj9OWPIvhiVoEzeoVBDrHVN?=
 =?us-ascii?Q?qPcPcET3vT6oix9MEGdyknFTdyHpF3I0JbKmF1Z8nU1hhSDiVUizrcZuGrcH?=
 =?us-ascii?Q?1i8i2uogBIeFLOhviyn+Pocgmnhvde7GUjDxuLRdkAZR6eGe/dEyhCPzYvc7?=
 =?us-ascii?Q?bD+LPWKBEji547BfIHvkCgAdZEapdAlKOHNGUSecElLO4jDQkODI3mb0sljW?=
 =?us-ascii?Q?CJRb4JPG5/B2lJsUBG2r4JjI5RgbqiG1TiMDR+YRw8y4pqy8zFFXYj405GDk?=
 =?us-ascii?Q?ZdsViBAmM2sFvn0MuZtlUz7lzOJcsuqRIOjkpFcxrthsY1g3YInlZkW1xQs4?=
 =?us-ascii?Q?JiMutxuv14wid14BKcHjpxI+jCAOdaNAY9K+utv6eqcCje3OThypeayi9YaX?=
 =?us-ascii?Q?0VLLjV78BqDMvb/KghFnrSQKRI+JvDLWRU+X50bIzgCVI6TnJL+HX32ZaKCl?=
 =?us-ascii?Q?NRp657dln1r/k9JEq1CPNg4gV8bZzZVgC7s9ztFtTwCiWo2gngxT0QmzwSHG?=
 =?us-ascii?Q?PV+u51GsUdHkf3vut/1A9pmRdeY7++W10H08CAN4S9glD2eA+8qcfdOwetvT?=
 =?us-ascii?Q?TPh1c8jnLzNFV1+1m6u6miq3maMM4jHtjQZ2H+yjciaaDVytRsnULVS5oXEU?=
 =?us-ascii?Q?rt0fw1tPNa9wLc42kTy1VJsTAUPM54S2vlxGZhG1U7xpKQAtTwXa7IGoU1Sz?=
 =?us-ascii?Q?pdQK8U8YADLqoFT/7zYe/aZbRwzlx2+NaLghoSqsOr6aABWstVg5WzK9wOBg?=
 =?us-ascii?Q?cNuMdCpRmp8VO14f5ir3YBCtoTE2Do0vxARLqf99IABNCpqaHdTn59uQkIJI?=
 =?us-ascii?Q?aUNJxeJbThQz6FfVfo7Bwbg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d21640-75d2-42d3-25ec-08de07f45893
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:37.5063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpKa0NQelyOAy2PadefTgok7lBYhRYU/d/4WdR2Gd6HBe+qXqpPaQfp5pw/oNUE38c791jOdEh+o/FsIOe/W9FhPb/Dz0mDZCafyZMXs2gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8464
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux commit
701981cab016 ("mtd: nand: Add a NAND page I/O request type")

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20200827085208.16276-5-miquel.raynal@bootlin.com
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c1b8b9627f2..d8abd03e919 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, to, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 651f8706df5..0afdaed5715 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -80,8 +80,19 @@ struct nand_pos {
 	unsigned int page;
 };
 
+/**
+ * enum nand_page_io_req_type - Direction of an I/O request
+ * @NAND_PAGE_READ: from the chip, to the controller
+ * @NAND_PAGE_WRITE: from the controller, to the chip
+ */
+enum nand_page_io_req_type {
+	NAND_PAGE_READ = 0,
+	NAND_PAGE_WRITE,
+};
+
 /**
  * struct nand_page_io_req - NAND I/O request object
+ * @type: the type of page I/O: read or write
  * @pos: the position this I/O request is targeting
  * @dataoffs: the offset within the page
  * @datalen: number of data bytes to read from/write to this page
@@ -97,6 +108,7 @@ struct nand_pos {
  * specific commands/operations.
  */
 struct nand_page_io_req {
+	enum nand_page_io_req_type type;
 	struct nand_pos pos;
 	unsigned int dataoffs;
 	unsigned int datalen;
@@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
  * layer.
  */
 static inline void nanddev_io_iter_init(struct nand_device *nand,
+					enum nand_page_io_req_type reqtype,
 					loff_t offs, struct mtd_oob_ops *req,
 					struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
+	iter->req.type = reqtype;
 	iter->req.mode = req->mode;
 	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
 	iter->req.ooboffs = req->ooboffs;
@@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  *
  * Should be used for iterate over pages that are contained in an MTD request.
  */
-#define nanddev_io_for_each_page(nand, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, start, req, iter);		\
+#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
+	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
-- 
2.51.0

