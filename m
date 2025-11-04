Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650ABCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2DD83979;
	Tue,  4 Nov 2025 19:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="GJnIMP8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E358144A; Tue,  4 Nov 2025 18:20:01 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456088003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 18:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqWjfWi0e+XTgJP4alJ/vBr8BSJhEWAi2z2hIXQz0tzaHYYdGqtzvH+cFpR0jJLXma5snS3LUDz1CBFCoUIOo1tNf8NE8k/WVw74cdHzcYsB6PGgFiLS3hm8bpm12IwA4/Pfk+VFBDGSdAvyVeLZ22w4uKjgOokE07AeTaN6geOFfb+Y2P1+e+nWm9gNw/fpxqY3CpN6Rxhps0mPHBkson3Z6Y/vFjs70PNLtGQrD92DaaxBz9fnriNz32Gui9sJo2VaGJxz2dlcFTmlDoXjaAwwyvg4uViwM5Iyl3IFo1D3t8iGlhozLrOQ0V5oj1F9VpleKhRRFYWLBuj6W+WDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLz9ACsd2hBjagz8q5ujXpW5J3IpNGPZP8v6GfO2uMo=;
 b=iiM3uA0uOJS4RfgxK9rCFOrn6VUKIIzbrNkxD3Aqfj4brJHhxUZS8dTXnvHUSbG7CvZd5ACLFzBlkVoT1IYwwo3D51Jd8FmHbxDYspTZ87BIWRaA/BsAcdA3I2/mmbQ3ba3rMn5Dt2JvS95PSqrjBCRDdqu8HJw5DxbMVA4QYBoJbRr1LYqJ+8ajS01KOgweOx/adA0MiPeauBsuzHqnQxEtp7EjYPP3ubdFK85EAIqFG2KY+yc/6V6j395vTO0OWtKjlQpdTvIH6P0WjclrKjIPcO27a3B6o1OSNEg3ZTRF7T7HjSp6GbU2UxautTfQ0v1VuZpbz5BkXUNyQ1fU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLz9ACsd2hBjagz8q5ujXpW5J3IpNGPZP8v6GfO2uMo=;
 b=GJnIMP8lVpYMd3Y7Yp2FSebOawlybMm4G5DNYp0RQNAObnpFxYCaHYx3t5JLs/15v+DG+psJWz85ePBI5/8FP1dsJjpGkkt4Va2iYotQRtCL4N/rWjhMXr3xm0USomIHc3XVaROVSeQEeltRccVHvsBSqY0ADNTAhZSsoQ54a3pimE/z1dIyLZCvTBR9h0TdTShcpWLGfzGvy97Vq7jkNHciIJg4dcM+64YfxV1BQJp0y64yBS/teAhIsfM2c2VRXblzyB9yNZGznqxelrXrlScuuSu8gGq0Z4Hgy1iKHB45f3/I2E2VPdRzFYFmDPUFY1plhOPXrdsDV01R0/NL1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS0PR03MB8245.namprd03.prod.outlook.com (2603:10b6:8:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:19:56 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 17:19:56 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, david regan <dregan@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] nand: denali: enable SoC64 SPL NAND boot with proper Kconfig
 selection
Date: Wed,  5 Nov 2025 01:19:02 +0800
Message-ID: <20251104171902.15039-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS0PR03MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0a5fe0-84e0-4e01-eac4-08de1bc65fed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LVso943BjmJ0/kLSJboEVSCPZCdihXAFbf8iMcJshvpLGBnoDc8ooSPosIlt?=
 =?us-ascii?Q?Q/Z4FGybYU2KLUEYGZkdIycmmgSVTlV6SMPOpRWQWWwB2J4y+mKmYYvtlD5l?=
 =?us-ascii?Q?iGmrXOdlm7iXfpVNXTM0Fjb/XJNUG/la9zzHIcyoPrXu+8jXZmZsgG5+BavE?=
 =?us-ascii?Q?s4HG0N7lArse0MGY6T/vlmI4cfwurUdnU+ovUSqpXONMjGt1puJ8zIN2CZpD?=
 =?us-ascii?Q?qEUIAde8d2553aOkKNx2S+ddSAd2x7SGjwLvggB08mrBbw65QS8BrKx523Go?=
 =?us-ascii?Q?te+JYGzwM6OPzo7z7t6ihSLiAg/8D1vmGiXIzleZOVZHH/f+Ww696k6NIQ6s?=
 =?us-ascii?Q?nvZeewKBmRieTrgKgtAR1d4siu/06iT2nNnyIGgB3JdWD5sjyjmVqBV13iau?=
 =?us-ascii?Q?cpte901wbOTaYm7ffDAwliJmv/RsVyRky3ODOu/ub5ZZm7sKEN1Yl3sT6OVL?=
 =?us-ascii?Q?Gs9BfmW9CvcmpRI/Jt8E8i/4GA2imv52zf6A7jTEXNRRYuSeZ4OKDK1w+0Li?=
 =?us-ascii?Q?/XyCMIfpfCbtesIZjLvK8sbZn2mYfmCoh4tOJqTcJXQK5xWGLn3dtzFpBQPN?=
 =?us-ascii?Q?+NQI3TDZvbia8hXrYmbMuzLZfrjOxj+Jal65cUz4UiWaI7t5ZluMcpxNulTl?=
 =?us-ascii?Q?VOqjjn4QoxTOA+UE3tPmvWl40BuohAW6s7fnPC/hjZQgECYOK/iR+ablKT4a?=
 =?us-ascii?Q?iaB03RLS08zS6Oh5e4WBsLfNgWYwFvtaXOe9tCOl2m1xW5q/unE8uzR2bs/s?=
 =?us-ascii?Q?kh5UvnfPnwRu6j5YweibZg226eoxiPcL64ExKxx1WO4O4jJce6p5d3EEPqR9?=
 =?us-ascii?Q?EGweyRgW+sRJTnW144j1kL5rtSAHIAKh+v7N5j82IoPamx4LYdZndpEXMLzT?=
 =?us-ascii?Q?bRL0Lklut+mpGhxhRyVkE9jC0EO7YEfiPg2m0bRBuE9uAPC/IP3YCP5X7vGW?=
 =?us-ascii?Q?RZXLsK8+iYpQg5MMVcnaQVktRn/xfql2vwGwesKceRu7CmQRRcLyr2I5q6SV?=
 =?us-ascii?Q?wXwH+hpraZvvZcUDaUQamkAH7cl8QeuVPBRhMS0SkQRPsVhnySQ3IkjdgAIS?=
 =?us-ascii?Q?KXIAjQJDeA77I/iaBzzI2I0H19k/2rUNpmucELwr2ZIQ6j7ACM7FlP3Y/3Xz?=
 =?us-ascii?Q?YsqcliFQzodCVR6nWnLfFgMjmt1A7TowTfgOhHNrrUJrwXGo98OgZyclgi1l?=
 =?us-ascii?Q?ChJALNqupQBc7s/qKY2IaW4m8Lykxcmrx7C2jT9c/sgWZaZRQDYlLNlpXpeE?=
 =?us-ascii?Q?G46b0JzKmCtf7bYNSY1v9NGZun+fyEarMT7kBql0BzxNBKiTrzD/337wyk+P?=
 =?us-ascii?Q?Nei51157aux5HyvbPq9YHRCXjALO/Zc3N8YZD2imk5XVrTCExXK49EtJqMu4?=
 =?us-ascii?Q?aEUX3hpMlrXx7LX7DTxpFyxuS5d8RP/jyItIz7n9U3cCyxoV1DFA474FPMLF?=
 =?us-ascii?Q?jLIJ0l1/iYPkM0eXcGeubeJlixogHhEK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jzDX30qeQY2ebx6aLlX3pkTXC27qit3ubWNmgDuKlVA1RVFMIzTGu+AWA/qe?=
 =?us-ascii?Q?vUseVHK/pofx3gI1KGmZ8ULkg9fFVH0y6xZ+gM3StdzsAXoB2ADevHsEXaPo?=
 =?us-ascii?Q?FXoIRi5ATWX8gWf2xDu31kKvRV1i7eX8NEi+2OIk5sYObBK+vSMqsTbIQfxM?=
 =?us-ascii?Q?dXNJuk3os0x2NMAf6RAb3ei/pcWIckwMd86qGUt5xayUU9EuQd69zO0jfSbX?=
 =?us-ascii?Q?lbwC2ilM5uOleAo+o4gBgp/Q2EtTAGJrunLEmQOtmthHr3MdyCBP6pOtGtnF?=
 =?us-ascii?Q?HtYubnIn1znVYXkbIzwzaiUR822zBZTkBmsTUIHdggqahaSYGWsxp97fFeXy?=
 =?us-ascii?Q?cgHnmaRM6SGj7RccnGhtlAEKy/H5y3vDw72yDWL8aF7JcGI42QNqv8Ka2AY9?=
 =?us-ascii?Q?iQ1hSvqbxyBGYZVOqvoU4zuMDmc2nwUczK1dTd5oaFlLcCbA28nYgk/I3LNy?=
 =?us-ascii?Q?knlq4ffy9x4tj7t/2JQuaWKkptSIObqVGab+AkBDCrqZZX3lF9Cgt5rardbR?=
 =?us-ascii?Q?mzzinzlkNIv+v6Yxk5YQ4iphKRFs0EoDZwlcGLR9tfeiR6dMXE3uMUKvEypT?=
 =?us-ascii?Q?jCvt71LT4wuaujWxqKHumXgZz/COipdQonSVr34meEnqVqbxxmlTvb25hhfj?=
 =?us-ascii?Q?mjWLV4/gs1i3unVNrP4RWOM8WDvGx66IMB6nxuNfli6IdQwP3brwkBPq6ZtV?=
 =?us-ascii?Q?0/bQC4omO19Lv/WLNTuGpa2KnPt9QSpgo3oDBMToUQ1JjgrVilm1z7WXnneJ?=
 =?us-ascii?Q?tx9lHtvm2aktJw2go6lrij3brKuq/ERvn5cxE+fBAKrNBh2IXMa0tfOWjpAd?=
 =?us-ascii?Q?OadGRKlBsFmC972u5/9ldA5bYCoGueo9c52qjFcHf4ugDxZ9cssF6LcQMKWE?=
 =?us-ascii?Q?rBuI13ifU229s9dCEf/aePVYWc8XT1mPTNjCe5yICf72Sw12iRR9n0yEx1Cy?=
 =?us-ascii?Q?G24iJEjasSXA9ERNklW/REsjyGCs5xQbSqKPLuyLZwSOQLokRnrekiEh1af6?=
 =?us-ascii?Q?Y8AXYShYvvkxkyKlTwgFAZOVUCP/Nq4VB8xiMZhFLaM4WoLU71JFWtM8y/SB?=
 =?us-ascii?Q?A+/s29bwhfOw1tVJc7mgL99kaor0GftibvcL2bgrV+XpRkc8n/VJTB6ONftn?=
 =?us-ascii?Q?zy0OfmbZvdMX/G45iF7mGSwOcSYxKnLAoB4xoSIlfOtcobiyZ8vCDl5l0WyG?=
 =?us-ascii?Q?zuPyUzTeH9BM+y/pBoCjelTl1rOeQsIUugZvXfBJsJSBeTqDFxAf29s8VL/w?=
 =?us-ascii?Q?Sty21bWESWEcTpX/ObwSrZQ4A3VtvvzyR8eBFZPTOe/Df+FyD0tlQ+ZmOCBq?=
 =?us-ascii?Q?y3TIt1dFSEVcUhkEeC/dfvX/gzUBEAYw1jxecYqhTc5qfQS9R6maLwI8B5ib?=
 =?us-ascii?Q?6cCpkiwsT44db1GfpgY0IepNrhTvaUM6r456gaUh23jhab/HFZkUT7dNvgTk?=
 =?us-ascii?Q?E853qJ+RenXDTBldh55LWXTlcBXBZ6ktm7NIAlGou797gWego2tIgY5B4DN6?=
 =?us-ascii?Q?Ge2+9DJ4aA3ATMxPHOTNve/w4ojjx2/bH0Dh2oDK+TKNdV1xvYNu0bxB1L04?=
 =?us-ascii?Q?/NqArj9SSDmYBS9xs7fHurqNdg9IFYg1gqaUMml+KS3wL5W3Cgbtnriw6OPQ?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0a5fe0-84e0-4e01-eac4-08de1bc65fed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:19:56.3277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DQb3T/WwJiin1dyMQidG5jZg5IrhnWqvKvUtE/JaOO8yO2VoLiFi6wXICYGQf4vb4APMAN7NqF99w3FJokSoBFhHh9KUJ/+UoBj+tb/+TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8245
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:32:11 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add SoC64-specific NAND SPL load support in denali_spl.c and update the
related Kconfig dependencies.

This patch introduces new helper functions to enable NAND boot support
for SoCFPGA SoC64 devices using the Denali NAND controller during the
SPL stage:

- nand_get_mtd(): safely retrieves the active NAND device instance.
- nand_spl_load_image(): supports image loading with page alignment and
  bad block skipping using nand_read_skip_bad().
- Includes nand_util.c for required NAND utility helpers.
- Wrapped under IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64) to limit
  inclusion to SoC64 targets.

In addition, the SPL_NAND_DENALI Kconfig entry has been updated to:
- Select required NAND SPL components (BASE, DRIVERS, IDENT, INIT, ECC).
- Exclude NAND_DENALI_SPARE_AREA_SKIP_BYTES from SoC64 builds, as SoC64
  NAND handling no longer uses this configuration.

These changes collectively enable functional NAND SPL image loading
support for SoCFPGA SoC64 devices with Denali NAND.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/Kconfig      |  7 ++-
 drivers/mtd/nand/raw/denali_spl.c | 73 +++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 754b99bf3eb..5e567ca4993 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -781,6 +781,11 @@ config SPL_NAND_CADENCE
 
 config SPL_NAND_DENALI
 	bool "Support Denali NAND controller for SPL"
+	select SPL_NAND_BASE
+	select SPL_NAND_DRIVERS
+	select SPL_NAND_IDENT
+	select SPL_NAND_INIT
+	select SPL_NAND_ECC
 	depends on SPL_NAND_SUPPORT
 	help
 	  This is a small implementation of the Denali NAND controller
@@ -788,7 +793,7 @@ config SPL_NAND_DENALI
 
 config NAND_DENALI_SPARE_AREA_SKIP_BYTES
 	int "Number of bytes skipped in OOB area"
-	depends on SPL_NAND_DENALI
+	depends on SPL_NAND_DENALI && !TARGET_SOCFPGA_SOC64
 	range 0 63
 	help
 	  This option specifies the number of bytes to skip from the beginning
diff --git a/drivers/mtd/nand/raw/denali_spl.c b/drivers/mtd/nand/raw/denali_spl.c
index b1e2c9d8161..78cdab51a5a 100644
--- a/drivers/mtd/nand/raw/denali_spl.c
+++ b/drivers/mtd/nand/raw/denali_spl.c
@@ -5,13 +5,84 @@
  */
 
 #include <config.h>
+#include <hang.h>
 #include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <nand.h>
+#include <system-constants.h>
 #include <asm/io.h>
 #include <asm/unaligned.h>
 #include <linux/delay.h>
 #include <linux/mtd/rawnand.h>
 #include "denali.h"
 
+/* Only compile this code for SoCFPGA SoC64 targets */
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
+
+struct mtd_info *nand_get_mtd(void)
+{
+	struct mtd_info *mtd;
+
+	mtd = get_nand_dev_by_index(nand_curr_device);
+	if (!mtd)
+		hang();
+
+	return mtd;
+}
+
+int nand_spl_load_image(u32 offset, u32 len, void *dst)
+{
+	size_t count = len, actual = 0, page_align_overhead = 0;
+	u32 page_align_offset = 0;
+	u8 *page_buffer;
+	int err = 0;
+	struct mtd_info *mtd;
+
+	if (!len || !dst)
+		return -EINVAL;
+
+	mtd = nand_get_mtd();
+
+	if ((offset & (mtd->writesize - 1)) != 0) {
+		page_buffer = malloc_cache_aligned(mtd->writesize);
+		if (!page_buffer) {
+			debug("Error: allocating buffer\n");
+			return -ENOMEM;
+		}
+
+		page_align_overhead = offset % mtd->writesize;
+		page_align_offset = (offset / mtd->writesize) * mtd->writesize;
+		count = mtd->writesize;
+
+		err = nand_read_skip_bad(mtd, page_align_offset, &count,
+					 &actual, mtd->size, page_buffer);
+
+		if (err)
+			return err;
+
+		count -= page_align_overhead;
+		count = min((size_t)len, count);
+		memcpy(dst, page_buffer + page_align_overhead, count);
+		free(page_buffer);
+
+		len -= count;
+		if (!len)
+			return err;
+
+		offset += count;
+		dst += count;
+		count = len;
+	}
+
+	return nand_read_skip_bad(mtd, offset, &count, &actual, mtd->size, dst);
+}
+
+void nand_deselect(void) {}
+#include "nand_util.c"
+
+#else
+
 #define DENALI_MAP01		(1 << 26)	/* read/write pages in PIO */
 #define DENALI_MAP10		(2 << 26)	/* high-level control plane */
 
@@ -240,3 +311,5 @@ unsigned int nand_page_size(void)
 }
 
 void nand_deselect(void) {}
+#endif
+
-- 
2.43.7

