Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A69AC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DEC588549;
	Thu, 27 Jun 2024 13:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="tW41Q9+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FBB88549; Thu, 27 Jun 2024 13:20:17 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B775288528
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI7vZtMnmxx7vpeE0RvXdwspampCDPdfsoClyScQ51vWLFztzCiSu9Y85Tl+YK600LXhc2C1D2pLaq0ZWnUpuCKeNsRIMXp5DomMk5iZiIQKla8Z7j2dyZGJ1Mh1RTX96xUVqymPQ8hi+VxZ9h5aa9+4lBBA45JS1UrvafzV+jRZ6Z5cLkaLLWJdwnA65Sg0MkGeJOqNIR36gSoWUKKpwXyyHKgDn2/zHu47Uc4vu9johLse2pLBwV7N85FWnKNWZSHBIpm2Xz2kGnypxgnQDCN48+6aKtWdharroX9lT5t6CGbtodZyRnnRRDF91TZahDa1DJcHJfC9lu5+piArAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHAbXyLYrOulpBoIoeSeQxV+AxwmC8D1VzTh9axr6JI=;
 b=DrC8K9T6oXN06xPJ31yUZyeM5vBuaPl8rhRSAD9BxG3OTwxMYaVMvgIC8p1KY/kwBZVf0grqHduitUHeiop2+FwBoesdVgal7O7NI6wpkzAGvzRbjh2uWwNU70ND1p/wHdq0+EUrUhTF6u58/80BW8lTZ0v5CrporRYHQAhkjjWZFZESOVxrR7wtoWVj/rzfvB9/TiLwUo+/jOLTkh3vXTikweeTxTMzpSHu25v06GrlYAgPjoDjjvyc4fu4/fAHvCCPnI+NELe18zfTnPzYN/MqArd8QkNfC+lhGce0K4rv8V4i7tbaRBrAm7raU6X6Thseoav2uoy5jZwgbbOKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHAbXyLYrOulpBoIoeSeQxV+AxwmC8D1VzTh9axr6JI=;
 b=tW41Q9+p4OSqodfxak0Kt6mgdxr3xONRrc+AsrSZPwgGExT3oYW05AGK4sImyuxpLVML5jpZMulPRkCPoWyyxNg0fBzeJ0HqBFyPpKSgZ2GwNE6LRbxrEiGzkqVR3SQaZJOTz+FV06TzYN4t2qkczy+LMaW9okNyO+KVKpkAFsq7FkkH7a23unM42/G/AP3vVL0ut/lUy/46p5txpwqbi7IstSM16jMUvzc71GtoKGi7zZeMvYhoY60AoZXgWIkkNpedRmG0gkPODmty7iYICmqdEAvs4IxOftJc9gAs9KXHhB5h4WvCxy5S2BFcO42oGDkth1Gohwx2jsqDWorGGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6064.eurprd08.prod.outlook.com (2603:10a6:102:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:20:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:20:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH 1/7] mtd: spinand: Use the spi-mem dirmap API
Date: Thu, 27 Jun 2024 14:19:59 +0300
Message-ID: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA79.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0625bcf4-2ae9-4891-abfe-08dc969b1cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QrIp1aJQVtnZ7tBoVGY7i32Ox9NHix/IQ4h7TwNoFAf+DFC4Kqp/rHZCNcED?=
 =?us-ascii?Q?lMg9Kf5tfqoJw5Ju7IfthKc9HWbdQ9HXk+OJWZm3LMGTeK2dOmI+eFduCt/a?=
 =?us-ascii?Q?svTdPRuFLbblfcoHsBtQFi3a1Fk7ujfqMl2l1rjDG+28XDJWwqxxwe59Xzl8?=
 =?us-ascii?Q?vEIRibp5/2iFcMOomL7dxHElLYR3yo8wGPKrFa/R2tQ2LQzYvat3PD+19JV8?=
 =?us-ascii?Q?NIe+Dx0gWUCkpeZBkpT5JZJdxf5USlSJANkeWhROsiPhrbVr924WvutyE3pU?=
 =?us-ascii?Q?ghjzGmBIQAVzngfJXqy8yM49ItHXdNcHwuMJpmiVvxFKWEUka5HvPKIZ8qvq?=
 =?us-ascii?Q?PVk9s3mClSxMyfZev/jBmJFThQmXSFK8jHF5cNVfYczpUP5AczDPBO4VKerU?=
 =?us-ascii?Q?DJ5PbWVZOF4xZievhmaNteYrx4rGUp/kMvsstJ1l/XrMiQ+lBSXCUfJxn/SJ?=
 =?us-ascii?Q?k5tEj43o8g6naGFKfxkHtWvoBVUj56/1+/KV61XscTHX23V+awvbSllVA+D4?=
 =?us-ascii?Q?5a3GIJfGbJd04a2aW6Q4cihyeYdIYPnA751LJbX2h7u+xu+nPq0j057/wONI?=
 =?us-ascii?Q?K13QCFdO8GzIyO7M3K4UsIOIGIR5FFC/7Xs27YZCge17sitkp16xxgSXA9L5?=
 =?us-ascii?Q?+zsNcw/ofjVbM3npCUmScoonz08Tm+bAIt1mkuh5P3TTTAGCrETwvBLx9OLC?=
 =?us-ascii?Q?tAEDrq8QVHDLvAgVEN3fnhXeAWcRXP+afaafnHiwd6UTJOsa9AUglekhVvmN?=
 =?us-ascii?Q?jeAAI2L+Rp39H5LLn5/0Fdr4lAppLiY2/TRvlL7Zf9AbrHI6nXrLNq/w+GdE?=
 =?us-ascii?Q?VekG09BOC7kWda0bDiT7vwejrtku3ksjrmLOV6A1WCqT6iaIB1uHZ1izjnQ9?=
 =?us-ascii?Q?uF46Ix4Q7DuEn02il0HvUeCoynOB96HGxUetsUoiOghcfKxsKYo/4PvxdRtP?=
 =?us-ascii?Q?AT/ucl4PkIgiFZEriS0ADhIb6coTHX7/tAJytkmhxZTFWaEISkN1j3eFnJNe?=
 =?us-ascii?Q?MMYE9+DVObbWcOuTApbdacGKKcaxLUBt+uBlZg9OLk1SUYIMAFVTdUabI3CP?=
 =?us-ascii?Q?913rw0kK5Y/QzwN7f+kyNjzkjNlkGAaqd1cYKUEjMCwxPPrYuHr9SKZ7+xzL?=
 =?us-ascii?Q?PFgu3ALCCPoui76jgtk8g9YKHGNwVy/Xp9bq06s+Qc2PMX0eeE1Wuvvaokm6?=
 =?us-ascii?Q?xc3y1PZSKiKh3xKRPho5rpLz7+8Tzm8q8fVJ9pBLmGC3VejDC2Pr7rNI1lTi?=
 =?us-ascii?Q?9zMSJfEAv4NcWy34OMaS6xFezBcSkOdTGhH9b1qvv7tYqCGNg3IqTCkaNyng?=
 =?us-ascii?Q?fMbU16qt4ulPZgq07qMCuBKNd4C5T7nEX+ffSa5Bo8/sGY2wS7msGzvZh8O5?=
 =?us-ascii?Q?lpakagRuIM6OD3VE+HPZDAsD0aQQb0e3lL1IgQ9QC48FctR0EiZMKWupuxuD?=
 =?us-ascii?Q?LIjq3SntPTk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GmaSTCy2mFix8QBtjoIqv6fps88lGxPWWNBrGs5NggzTOlxJYWtmKX795b/x?=
 =?us-ascii?Q?rmg2KFYO6i+v8qzDiG4GqfODPGkUIqnPXngaD4IqQn8wfzqcpeaF5IyyF/Lf?=
 =?us-ascii?Q?Be3zdTlHqshLeMe631lMRSZml3e4PjiBwuMR4XwX0vUK86D82BABjeGcwPPf?=
 =?us-ascii?Q?LeOkTkhWTaoPJP9bi7yQVfV/IefcSUX8/sJ3ejuyS5AON7BMLQTl4s+1Mk1K?=
 =?us-ascii?Q?8BBjg/2aYfcb/fVymdktWWQUdjYUqHKADKYQFM4v2g6dv+IZ6kXAiUxE8P11?=
 =?us-ascii?Q?fJWse6F0UOwrKdwLm83qOZgwl0zEiM6MdJRyXKu1L352I4ccUvCtcGouYw3d?=
 =?us-ascii?Q?r/wWSdoIA4dMp8GWacPYZZI+hJzTy9OpmEv8tbNbmVrP225L/Xoa7xbKniYz?=
 =?us-ascii?Q?ruLhQixN5RqX6Ne81buBO2+vmt5Ux1/DzNlNcgsVAf9b36H1RLiEpP2MTLW6?=
 =?us-ascii?Q?A81NiAyK80/diKBRvFz59iK8YYROc8F789kg5MlTEW4rRdy6+6D7B1UcAGlf?=
 =?us-ascii?Q?kA0mcAuZJOCtIB9kA4YqOah9/edGhYW5t3tkfQQzyYuvPRl7W3luMgBXkrq2?=
 =?us-ascii?Q?8qbzUu1KK+nHJEhnLa2cEy6TszpD70rS1ledP6e9S0ubFFff7MW1qmO3xI5N?=
 =?us-ascii?Q?KMAuTrd0jm9gwvH16eU6b4osvtodaZQmnR5gYsuPHUsSp61L3Z9g6pfVv1Aj?=
 =?us-ascii?Q?hNKz/q7vspGatrkAYgGM3RwaeyEGvPEkKrvQuV3kpxr09bIcJ7P97mzkI65I?=
 =?us-ascii?Q?b2iFmp2ilfJnopmN94lYWn7QEI4dwg9ukULeKS2zG+CtUuA//198VnoNYJUh?=
 =?us-ascii?Q?raSAOLCxaw5bnDhacp7DCX2JHo9UOBibLFeglrwnWDEJkVixtyvrlUEw638o?=
 =?us-ascii?Q?g/7vMTzwlzvUXsPQhV6aE3qniItFyxqwnLvKVqgwSkVBskSqUoo+dC2n3ztZ?=
 =?us-ascii?Q?lX9fHwX05mbIkNOgQOMYKcUB/kwt5hw1Lg3silvPM0TKVShRn5+Fa4G2HK8k?=
 =?us-ascii?Q?WDUeY64zcK0Pq97XxOfQsjk9QIPTq8d3XsZ3ZbHDZ8xjoO1GdMFD4C09K3aq?=
 =?us-ascii?Q?1u2x+LNjfb1pM0uDYCfIUf4Uv6FihW1hpIFsASqcUSQF3/mM4yUffqwo0AQl?=
 =?us-ascii?Q?vjNIrEjiLInKgovmhknh1GrCCQlrKJIZfC0vCcurGy/HZA7pvciUxNywzW6/?=
 =?us-ascii?Q?4IjUyhza8cjv+03sFCYP56C2QmSU3k8ixFgRp6qGPCvz+zhATQA3QlNuQeBj?=
 =?us-ascii?Q?DuayVnqtwmQNFfrTZRGY8r4gkkzoQy3F7mDgk6ocUTxi6qhScZxUO4bTg6SY?=
 =?us-ascii?Q?sa1yUxGSdDLL9d3ycCQC+cUjs1Y7iHpdK9aGQhkkim1iwDGq3XHKnzpbpAun?=
 =?us-ascii?Q?dPOX8YSRGFWd8AlMTUlswNXDoC9LJdmk7EO9VeGJqyDYEyoKea7PS0VwAdYE?=
 =?us-ascii?Q?qOdWoW17//emt0x5mkAqLHFAL8JKRyAjJ9dFvfp9NOAwEMCd/EVQ/DhHtU11?=
 =?us-ascii?Q?O0J9Ew9GvDZeVZKA42JrJ2rmMHu87GU6QoqfAcW4AuV+J1EeQDBztdE5G+1L?=
 =?us-ascii?Q?Mk6FFtwwsodvUVZFADXPZKu3W2hQCW9Q+c6UfaX179FW8umjPzF7IItVQRFS?=
 =?us-ascii?Q?1V/erA0E/GwPPIooAB9EA98=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0625bcf4-2ae9-4891-abfe-08dc969b1cba
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:20:12.7386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0xJ24tcAJP2QSI00sTd3UAFN4S7PToNtFre6GVQOj0FDEdE1TgnoFpunSMrL/luzKI7EeDVHiXkuRD4/OxILMQzQBhy4aZghqx70eaRyBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
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

Make use of the spi-mem direct mapping API to let advanced controllers
optimize read/write operations when they support direct mapping.

This is a port of linux patch 981d1aa0697ce1393e00933f154d181e965703d0
created by Boris Brezillon <bbrezillon@kernel.org>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 185 +++++++++++++++++-------------------
 include/linux/mtd/spinand.h |   7 ++
 2 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 62c28aa422d..adc67d7a40d 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -37,21 +37,6 @@
 /* SPI NAND index visible in MTD names */
 static int spi_nand_idx;
 
-static void spinand_cache_op_adjust_colum(struct spinand_device *spinand,
-					  const struct nand_page_io_req *req,
-					  u16 *column)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-	unsigned int shift;
-
-	if (nand->memorg.planes_per_lun < 2)
-		return;
-
-	/* The plane number is passed in MSB just above the column address */
-	shift = fls(nand->memorg.pagesize);
-	*column |= req->pos.plane << shift;
-}
-
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
@@ -245,27 +230,21 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.read_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
+	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
 	u16 column = 0;
-	int ret;
+	ssize_t ret;
 
 	if (req->datalen) {
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.dataoffs = 0;
-		adjreq.databuf.in = spinand->databuf;
 		buf = spinand->databuf;
-		nbytes = adjreq.datalen;
+		nbytes = nanddev_page_size(nand);
+		column = 0;
 	}
 
 	if (req->ooblen) {
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		adjreq.oobbuf.in = spinand->oobbuf;
 		nbytes += nanddev_per_page_oobsize(nand);
 		if (!buf) {
 			buf = spinand->oobbuf;
@@ -273,28 +252,19 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-	op.addr.val = column;
+	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
 
-	/*
-	 * Some controllers are limited in term of max RX data size. In this
-	 * case, just repeat the READ_CACHE operation after updating the
-	 * column.
-	 */
 	while (nbytes) {
-		op.data.buf.in = buf;
-		op.data.nbytes = nbytes;
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
-			return ret;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	if (req->datalen)
@@ -318,14 +288,12 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.write_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
-	unsigned int nbytes = 0;
-	void *buf = NULL;
-	u16 column = 0;
-	int ret;
+	struct spi_mem_dirmap_desc *wdesc;
+	unsigned int nbytes, column = 0;
+	void *buf = spinand->databuf;
+	ssize_t ret;
 
 	/*
 	 * Looks like PROGRAM LOAD (AKA write cache) does not necessarily reset
@@ -334,19 +302,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
 	 */
-	memset(spinand->databuf, 0xff,
-	       nanddev_page_size(nand) +
-	       nanddev_per_page_oobsize(nand));
+	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+	memset(spinand->databuf, 0xff, nbytes);
 
-	if (req->datalen) {
+	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
 		       req->datalen);
-		adjreq.dataoffs = 0;
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.databuf.out = spinand->databuf;
-		nbytes = adjreq.datalen;
-		buf = spinand->databuf;
-	}
 
 	if (req->ooblen) {
 		if (req->mode == MTD_OPS_AUTO_OOB)
@@ -357,52 +318,21 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 		else
 			memcpy(spinand->oobbuf + req->ooboffs, req->oobbuf.out,
 			       req->ooblen);
-
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		nbytes += nanddev_per_page_oobsize(nand);
-		if (!buf) {
-			buf = spinand->oobbuf;
-			column = nanddev_page_size(nand);
-		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-
-	op = *spinand->op_templates.write_cache;
-	op.addr.val = column;
+	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
 
-	/*
-	 * Some controllers are limited in term of max TX data size. In this
-	 * case, split the operation into one LOAD CACHE and one or more
-	 * LOAD RANDOM CACHE.
-	 */
 	while (nbytes) {
-		op.data.buf.out = buf;
-		op.data.nbytes = nbytes;
-
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		/*
-		 * We need to use the RANDOM LOAD CACHE operation if there's
-		 * more than one iteration, because the LOAD operation resets
-		 * the cache to 0xff.
-		 */
-		if (nbytes) {
-			column = op.addr.val;
-			op = *spinand->op_templates.update_cache;
-			op.addr.val = column;
-		}
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	return 0;
@@ -815,6 +745,59 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static int spinand_create_dirmap(struct spinand_device *spinand,
+				 unsigned int plane)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_info info = {
+		.length = nanddev_page_size(nand) +
+			  nanddev_per_page_oobsize(nand),
+	};
+	struct spi_mem_dirmap_desc *desc;
+
+	/* The plane number is passed in MSB just above the column address */
+	info.offset = plane << fls(nand->memorg.pagesize);
+
+	info.op_tmpl = *spinand->op_templates.update_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	spinand->dirmaps[plane].wdesc = desc;
+
+	info.op_tmpl = *spinand->op_templates.read_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].rdesc = desc;
+
+	return 0;
+}
+
+static int spinand_create_dirmaps(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int i, ret;
+
+	spinand->dirmaps = devm_kzalloc(spinand->slave->dev,
+					sizeof(*spinand->dirmaps) *
+					nand->memorg.planes_per_lun,
+					GFP_KERNEL);
+	if (!spinand->dirmaps)
+		return -ENOMEM;
+
+	for (i = 0; i < nand->memorg.planes_per_lun; i++) {
+		ret = spinand_create_dirmap(spinand, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct nand_ops spinand_ops = {
 	.erase = spinand_erase,
 	.markbad = spinand_markbad,
@@ -1112,6 +1095,14 @@ static int spinand_init(struct spinand_device *spinand)
 		goto err_free_bufs;
 	}
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(spinand->slave->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_manuf_cleanup;
+	}
+
 	/* After power up, all blocks are locked, so unlock them here. */
 	for (i = 0; i < nand->memorg.ntargets; i++) {
 		ret = spinand_select_target(spinand, i);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 13b5a52f8b9..5934b7604cc 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -363,6 +363,11 @@ struct spinand_info {
 		__VA_ARGS__						\
 	}
 
+struct spinand_dirmap {
+	struct spi_mem_dirmap_desc *wdesc;
+	struct spi_mem_dirmap_desc *rdesc;
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -406,6 +411,8 @@ struct spinand_device {
 		const struct spi_mem_op *update_cache;
 	} op_templates;
 
+	struct spinand_dirmap *dirmaps;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.43.0

