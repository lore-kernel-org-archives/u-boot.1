Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3BFCCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D1E68467E;
	Thu, 30 Apr 2026 10:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D4NdwyYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4438466F; Thu, 30 Apr 2026 10:23:21 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B1284653
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIjhdPTP7ZHJo294uJpAiBpzWhPTHj+eQ5k+dqP2zwEBiM3tSbIVzeNvAaOIW/2YnCMURYF/ttjFIL0UlyWbR3D+AtqIib0z1nBNgLciS0RqwbVs/72PSI5czBgLwjJDemZLZg+w4R+m/g8p4lt9ZNwUg44aHnLCvU1OOrZFtM945eGNMYFNVMvaGZQW4tGBAqAc4lUU/6onB1JzSRTaKlY8tAgAqJqGkUS06laNenYLQPlGFCWPMTbYcBElVngYomhjRFFcsdh1mA9ZLTHlYoFojGS+qb34B9DNaTm/NFebww/7ujljjh+Sqy/b8D3vnE7VI25uZ6jmuaxAAWIiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG88w6I7wA6IyFWj91LNOWuTomx03J5NAC1TFc8KmqY=;
 b=sSPhL9V7tYtWxre023nmAShJ4JbAu85EXc4El1/OyOeIQOC485OIl/qk/UirkdwXSSw7+F3xOp55Cb78E1t4imrQ6wSlQh4fwmTZ+Z7u22MgN6afY/vDLQgSKQzvT+1loLotTu8jV6iSC4YANreah8btSpKLsT2CqfI+FzFlR5msu18WNX8FyPsFHpR+USIk9aewXbL6ii3bgfxcdN5M5WRqpwNDrQ3ug5dXYPr4mltimUumA37fZyGOU1N9KL6kU3kMY9rqPbXjcc8v9O2gut5QOG/R2nG3rntgub8r/+TG8xCqwpioTYJUEy8ITnwx7ehfboWVlE+hqWA+CEP60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG88w6I7wA6IyFWj91LNOWuTomx03J5NAC1TFc8KmqY=;
 b=D4NdwyYdTGpoI/T1eNz5r2CYIwiy3V1bwU2u1ZI28Z04+EmErHWryYiYIBtX4sd57GKOaGp5OkNELcn/HBs/C7mFplp/Sl3vDt2fZukmm83dsqt7Gg1MRD5UBMPmz0VTj8EPPhA2iTav4tIhcv/7jtrnyKyWo6w1jznuReAbSRabtSy14dWJyQWUcehzy6SrNiV8rgaW6tKM+3AuXYCoSReAm+PFLd6njXuhJXdA0V+KCAsLwDQEMnYax5xbSOZPLUq18Rgtz3Hdx3bWM3kd38Iq4m9+kVXWEFrUnzMxZwMqXV89k4p4FXreMSgsq7m9bduRyRXHc7ndFYXFJAHJVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 08:23:17 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 08:23:17 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, marex@nabladev.com,
 joao.goncalves@toradex.com, ravi@prevas.dk, ping.bai@nxp.com,
 ji.luo@nxp.com, qijian.guo@nxp.com
Subject: [PATCH v4 3/4] board: nxp: imx9{4, 5,
 52}_evk: Add qb save option in SPL
Date: Thu, 30 Apr 2026 11:33:32 +0300
Message-ID: <37c24931119b858c4097cc7aadae9f58161944d5.1777536451.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777536451.git.simona.toaca@nxp.com>
References: <cover.1777536451.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::27) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|DB8PR04MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 53898e85-321f-470b-5cae-08dea691bad9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: WzRxZsQM0k5QqE2kjLCq3wUGJRKDAOgheO5Nl5/iG6IfpXkymrKu5mGZFvnVYvfGcxQIZMNKEKIf8/siEFySiSL4PKwNGjbonqRVohk9zZzqo+rLdT9BsKLg0yeH7BiSwBKrSaEf0MRST35pdfuNL3cB/NocQMkDzaczlX+3PB18p4u3ODaEXSlblcb6DIcS0sIEZ3XATQ78JOAH8OQXkm2OKA0mVcuW7XA+SSNkh5IjRTv/DKndMkuO03Un40LsLv1JhIq5TS9E79PludFjHf/fkHF+kEoKt5aYluxU+j7Y9WG8y6J3cP/+MzFUB7J+71pSEujjLBnqVV5A0bczoRgHJiobUNPYoYhCCBH/Gh9ByyN54Z73WI1HfSSY8PUxGZdlxJae2E/5KXfVfC/QyX0NsV4hM8jtJaRG4V7YI6WyCymf10wjJqcqegG2M/dYvBJ7ERQbeu33mfmE0usHW67Ye+2fQcSCdRIOF6PWY1LbwtHP22cxCn326eGQ7KQJSQRwq5xvfWwJgjpOpckczvquVXJJsP+4Fb+/EYL5wldVLi3/xrCYfmYifp51RRZrLEkWIyXd6+h7BuAxiiFcpNZL3eianjgLcI8fNLRtRcsQDheGfgxqKKPpqqdcPxmW4D8AuOkaxjDQMIKcW8o1DZEPAXvKw4l9IvammA/qcIsf1OUpeAFEuVJq0JzNE/uqUNNqC9PDKlVKOzCz+1SZz2wJHU2mvHDDDYwbrpwLsYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gCzlowTxzwni0IQqMhGlVyar1Xm7jWAv9S74jkaE6U+RXHr428EekhrVUw0j?=
 =?us-ascii?Q?wyzdlyA99Hml+klgYcfZ1e2fwmxTPHAy7Sft7xB83ilpVpQyUpvcix2mlbkd?=
 =?us-ascii?Q?Tqm6RhQvHr6SXhAFezSqiXW4cnKKUZnEn5iE/+kUkk/TWi5v31tN0qYhmhV/?=
 =?us-ascii?Q?Z10Y7MyfS7BPkRVHgRMj8Nnfb8vTE4JGCu2bYEH2Ur3b50TpOvW2EknTUKVi?=
 =?us-ascii?Q?XvX46MbDNx/90m2wOQUK2uGYSiiDvenUmnjSMmGLY8GtiMbLdSEnM48Pys1E?=
 =?us-ascii?Q?ODa+GaR8ErImtAiuWA5dfSw3w24pN+E+uNW7S9TjijLI+0ORmEwYJ2Bj+/ft?=
 =?us-ascii?Q?JCSiKjAgnxyRJ/u7jFQt4nlBrqc7Fy48RDNHJKWMRj5lj0p3NXFh/vWQTuDd?=
 =?us-ascii?Q?8qhVvyth8J2kHEItzAQ3BsDG7yu7WyxWlh/ceLs6O9WeThI94W/RSg4GzlDI?=
 =?us-ascii?Q?or+Sh8pLx3POgo2TPcmhLnWSc/O83sLiyTHhGuDwQ22/7uZcDjFtA0orHHtF?=
 =?us-ascii?Q?3QtqzRzNfbE+s2URgih3KVTZ8d8clXd2tBp5RTPYYtg8d36GVzDY4HZ9v5au?=
 =?us-ascii?Q?xo6jV7Gb0eznBbnjwxJddr7c4VBsQnETQbIz7QVtTA4aggqnpOlCmskBxN60?=
 =?us-ascii?Q?xsgLrG7QGmHq98Nt0/5/A/KHdud8K7ZQIgsHpcbF+Is/tjfGHo2p2zRl9l5q?=
 =?us-ascii?Q?gAtrBKvLc5ZWzsV6PT/mbp0IUZ04xt0djYaH1hYRVzATQVQ2cKpNCNcL1cXT?=
 =?us-ascii?Q?aB2uLJ7+VmCxxI8T2Iwzqw+ATdqnIFvrqPeZMpz08KC3GfBPkr/I8cMOhV2C?=
 =?us-ascii?Q?jLCDspZKPBF8zSTtMC3lXoHwsnti+HaXrDx6Xpijh3VUz3ElDFLwOELvOsYi?=
 =?us-ascii?Q?ekY9PLainHGnHm8UW1ytGQLPC/8gYXXpJXq8JdY4b01XijT7F4gfGVyoP76L?=
 =?us-ascii?Q?O04C506n7DIkmF0VCbfj5OQ0u505GtohS6ioiqlcVGLsRfVGdCYNeUh0AhKx?=
 =?us-ascii?Q?15HyD5OOwenGWQh5AAsHhj73Qs+T28Jf56NZhuXF5zYQEC//l9na5Efx1D+O?=
 =?us-ascii?Q?cOU2/jFLITN/woYENHmzhz8C9nkZwZIrZqU8HUyUkGuQedadjUf5Oqw0H2Hs?=
 =?us-ascii?Q?bINSAKmLVoywYlc1GcHS9RvMYnaAcQ55oBXchZx906LP3mvTJqr1esG2X3si?=
 =?us-ascii?Q?dH+rpGppkIPUgLLJFlybBaT9uafRtZ6oNDu3JtS7pIrkcPDw9DShAlXca+yk?=
 =?us-ascii?Q?cTUffbYWfmtAB9oPY3+StXzcil/7SwafyUUWYif7XwsKRqXWWA1otsQWk5dy?=
 =?us-ascii?Q?ENmXiDW6GsFy1PSAZln4COeCuAmV/ZzczLpZ8rE8EPn0W6qDoq/Y902L/5eT?=
 =?us-ascii?Q?lXKiqFQR1xGVyXHtsjolcaNeWpi8JCkqonludpHzpXab9jEYvlyWI582iyA/?=
 =?us-ascii?Q?BJJhIlDOc+3Bxr9EpJLNKXqVHyXo5KYF2/OAXtHqcVEhq2p53ze+yOAzwsJi?=
 =?us-ascii?Q?7L/LfCN7zYhmu6c1Xjy/FqoA8RvhQ7zMzctU04woYjUVWmfcwWgCRZQkb6IN?=
 =?us-ascii?Q?yLaQBrJTpz8OvS9Wn+lR8xWmJ/bH2OQ+pgE+rJcEAP4MIuCDeHq2OQ/GoiWX?=
 =?us-ascii?Q?J9Uv4602M6cpJgnpls63Wjip5jWcIZ4HaN1MGLLFtNgPM3DYEs3yd6y7JroG?=
 =?us-ascii?Q?Hb4vZzA5xY6R+UkU4cPic4olWrIU8ZisaHBtBbYBjUhlFyIW+AmQkWmOq2zT?=
 =?us-ascii?Q?1o2h0J8QtQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53898e85-321f-470b-5cae-08dea691bad9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:23:17.0630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8geFQfFKxBRRsFR3zh5w3wqIjiC0Cy2qaHpajkUFxA+KJ7CAf9CDaTfi46dglbNep1K/NSOWnBCngBtm/sZFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
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

From: Simona Toaca <simona.toaca@nxp.com>

Call qb save automatically in the board-specific
spl_board_init(), if SPL_IMX_QB option is enabled.
This makes sure qb_save is called before any image
loading is done by the SPL. This option is also
suitable for the case where U-Boot proper is
missing (Falcon mode).

qb save refers to saving DDR training data to NVM,
so that OEI runs Quickboot flow on next reboot,
skipping full training and achieveing a lower boot
time.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 arch/arm/mach-imx/Kconfig  | 8 ++++++++
 board/nxp/imx94_evk/spl.c  | 6 +++++-
 board/nxp/imx952_evk/spl.c | 4 ++++
 board/nxp/imx95_evk/spl.c  | 6 +++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index a40baf24631..66142a835ce 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -80,6 +80,14 @@ config IMX_QB
 	  memory to non-volatile storage. OEI uses the saved data to
 	  run Quickboot flow and skip re-training the DDR PHY.
 
+config SPL_IMX_QB
+	bool "Run qb save during SPL"
+	depends on SPL && IMX_QB
+	help
+	  Automatically save DDR training data (Quickboot data)
+	  to current boot device when needed (when OEI runs Training
+	  flow and saves qb data to volatile memory).
+
 config CMD_IMX_QB
 	bool "Support the 'qb' command"
 	default y
diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
index 6eb0fff99f4..739a5f1f559 100644
--- a/board/nxp/imx94_evk/spl.c
+++ b/board/nxp/imx94_evk/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <hang.h>
@@ -14,6 +14,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -44,6 +45,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_imx_qb_save();
 }
 
 static void xspi_nor_reset(void)
diff --git a/board/nxp/imx952_evk/spl.c b/board/nxp/imx952_evk/spl.c
index de9256dc267..615c3b67fb6 100644
--- a/board/nxp/imx952_evk/spl.c
+++ b/board/nxp/imx952_evk/spl.c
@@ -8,6 +8,7 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 #include <asm/sections.h>
 #include <hang.h>
 #include <init.h>
@@ -44,6 +45,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_imx_qb_save();
 }
 
 static void xspi_nor_reset(void)
diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
index 761a1a4a0f6..2fd69447e1e 100644
--- a/board/nxp/imx95_evk/spl.c
+++ b/board/nxp/imx95_evk/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <hang.h>
@@ -13,6 +13,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -41,6 +42,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_imx_qb_save();
 }
 
 void board_init_f(ulong dummy)
-- 
2.43.0

