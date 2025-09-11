Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820B8CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA7683429;
	Thu, 11 Sep 2025 14:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kyu0eZ1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BAD283323; Thu, 11 Sep 2025 11:59:17 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D3E78331B
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDY8IfXkUD2r8y9Of1O39RiqLRg3g2CUxA9+YyXu2z82AIbqP4DUl7kc9oo7Hq+Z79Gcy+GWzmVG2R/3l5CAZZPK8UEd33FOkVdJ+VPwRO6EWsxw9GnbimKdkouTmkOju/zmByNrN/rt3l49e+EXG1ReNQIJSlAHDFs7+XzntniKWUBb+95D2rJkZE6ydr3xVzLXbdmxvAva+HGedGzPI4RYPPKGvh9G5itTwXCDW9n5bScHpFu4IDVEWqZQYuGEBia/Lr1CD7Q41+UUFcMEETblnRiRndTDFvvf18GyS+QVMFjsKzvNfk9P/hrXpdrJF9GXHvGWArLTBIuNzFbNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P148WuzPMJl4vCY0Tv8kRJV4dU3cbwHwOtJIm+7brvM=;
 b=V2DnwumGEn0Wpbu8Pfp9hS1n1gFINaqZvx+9jiFrfeunaeP+uTyrO/xNQ2wiEJG/T1837yspHYf50q5/cUZUw5R5dw6QuNAfM/Xg2a454sJy6M/cLJYdigD3JMn3iYka9efqYOMVskpsEVnGDCZtYn7Qre6pzgdjuAZqKcii07PVZnU0apAP+YezpWAaqsQaGv+Sgg8ePsjqOkYIQL000jmzpoQ9xlVFLtFo8Y6s9BmJifVdyz2N1lWwCM9yKtTZyzq20kQ9oX1RloIpe/pveFaDOrzmreEIiUftu0oH25eMvuYJMKGflJrLdp14rVtTvwMAERf/J4+CZ1FnM1j1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P148WuzPMJl4vCY0Tv8kRJV4dU3cbwHwOtJIm+7brvM=;
 b=kyu0eZ1zq/gD6VmDxSg3bFLl99SOXz14lfZyo20ngsuGVUac/Qf61RLtLtpZygvc3rXb/9qkXO6i1JRyPe71krci655gc/okSM6yEtdnKM8f1LR6pezcDxdnYBY8VTtvDBOG5PXS5f7JwBJHZ/zrvkjG1pue81OmTuciHT4DIlZENcuokM+OEOgk+LzJek32iMx5hbXPNRORGLQJJcL2yxDN1XGT6BHW5aznmy5Gu1XPjwx/N0m1IHLl8NOLvww3KXIYIR23INNehOS8AFXHkZogVgV5X5FjNEO5v7XLeAWJrzLgL9k4Q33kNv8PBzMbhq//9WP7DLC+vzl3SvJBAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DB8PR04MB7131.eurprd04.prod.outlook.com (2603:10a6:10:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Thu, 11 Sep
 2025 09:59:13 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 09:59:13 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com, sumit.garg@linaro.org
Subject: [PATCH 3/8] clk: imx: Add imx95 blkctrl clock driver
Date: Thu, 11 Sep 2025 17:58:36 +0800
Message-Id: <20250911095841.3659022-4-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911095841.3659022-1-ye.li@nxp.com>
References: <20250911095841.3659022-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DB8PR04MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c01b5f8-ffb3-4bc4-1a39-08ddf119dc5f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|52116014|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JMWHPZrvHDQncbMsI2FUwl3jcSZGqPwx2c/Flc9AKldYXR+RK5hZ7DcWA16U?=
 =?us-ascii?Q?GRjFDor7iN7IXPHbqtxQmbV4DKRxVPMiiLxmvGjlAl/vh1c8tJF7WvS0XXPq?=
 =?us-ascii?Q?kMZHunoLPMazVtF/k4b0c7Y9VxyYdQRMAD2LKl2X8wW7VHlB+nawZUj/5M4p?=
 =?us-ascii?Q?GO75f75a//HsQczf/UJAltHpk4gJpQf3aG6Yy0IQffIAOjyRbgg8YA3kvmj/?=
 =?us-ascii?Q?tXFgRXORlOwbwYNO6Fyth+d4G1+I84tLzAeg4D4jVG26dUCCduX+tU5gFhOg?=
 =?us-ascii?Q?z2Lqp9wBGmHPYYzA5K7FVz8495Ut1G9I0AlMZ+MGa7c7YCw0xCvWVCbiBO+I?=
 =?us-ascii?Q?vNYq/8e2hisSpw/Bhxkcp+E+5E1YR0MxzRe73RTQ0BUTHZQR4HMv5gONoB0i?=
 =?us-ascii?Q?sJYIKwUxRiHIq6NrZ4KUPkGqqmSi5H9QFAnRVaWsmUr1tZ9J4tHx5T/NScQK?=
 =?us-ascii?Q?5FUtiU0jMc8ywF1t897C7Ll5hIjv8jUKuruTxNoj6mimcJ1cGtxDY7sN5Lmy?=
 =?us-ascii?Q?xhPdDMiXd+X3UIRQUUhzUNXh2uxvIjznyb5oY2OwJ4WHxXJBmwRz57dBikmo?=
 =?us-ascii?Q?emYG6RBNI5HMEaBIubT1LFluwOzqyIv21l86nywDjYfB05mdORPs1Z1+SG1Z?=
 =?us-ascii?Q?fi5O5bRL6GLUsIBnwLafB3qbyN11S9mx9J4R9ehhZZhqFKkXgtf8KZ6pqwyr?=
 =?us-ascii?Q?Sh1m0JUxecRivsFzUX2RC52IXgWOezZpSORnZ5rSph+JYEY5N5k9OL+Df3nI?=
 =?us-ascii?Q?85uuU4WWgs0byG1ALVPXIbrtfevVQlVc7X+rhbVEcuCkezi1j0+Ng+3F/Qgm?=
 =?us-ascii?Q?tZBvvrzeZfGFaEP2rdmadszPKcar0QL65GE7h++pJA3cPhdKUa+VLR/S9/2t?=
 =?us-ascii?Q?K6PYcmyPF7uRE5DCIUdNpF9Eyjg3ZvC6/yWiHMBFpSY+6BMQjDFAODrJKK27?=
 =?us-ascii?Q?jzBHWpzZVkBmVMxBZlQCLHEpCiYMNOLemyEI1m7v3U6d9fGWeoUlvVmrOkUp?=
 =?us-ascii?Q?cKHhmOytOlPr80x8h2JgUiN6HpgnEzx+100LPD/o1O65WzRmb26Cie9kl39A?=
 =?us-ascii?Q?mALg9uabtF9J3kYZiA+Q1nQUdq49TfgoM5mNhWOy3FE0tUPy3uUoWKhC2hSp?=
 =?us-ascii?Q?0xBjlzwVSqlWy0cxf8hhWzEDqTNboTSKago3h/l8LyJGHHlR2Qm78wRLsS8y?=
 =?us-ascii?Q?W5dPj6XVnMLluuXEBN6nun6XSln1pqrvVRkz4YKqfwTssP+lUpDBityrSSCf?=
 =?us-ascii?Q?+tFYEgBm1HTXvjTYi4oh5Rn42ieRYgMfwdg2VU8U/otTpm3UhAL+xv29o0f6?=
 =?us-ascii?Q?GOffJU++UkC56TGnyHORX2ZZveqAuX5N5a/qf9WTdFfD6bf2Ff5N8TfRYr3e?=
 =?us-ascii?Q?s1ZLUs8BSxzEuOoFdB0f9DzUFEZRYYiVSvkt15f0KC9YjLmdqzx+7moKeV4/?=
 =?us-ascii?Q?INCRMhPaNMpuRcczjRxcDnpyZje4FJLY3vw7yyRTiXz5qu0jDqfz/8guiEfD?=
 =?us-ascii?Q?VuD7iyunNQ2LrZM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxHqr4oY8Fr/B++I/RWQmyAU2cJvsxhZQKmC4+ckhKP+xgCffFjNhovBeRVJ?=
 =?us-ascii?Q?/W9yCitbLsuvPCAejHwEb8bxt4HNeSZp0w4c9jcTCvEMxBgcOcV1KstWzNN5?=
 =?us-ascii?Q?CvXKd6KaXLDnQjK9qaoAgFdQX4k+8PWnLhClSqgAyb1rQcUEySc0oTYq4+2U?=
 =?us-ascii?Q?EbDev/MrJ4yuZtsl4jBNEMnOkaGUNvTctLI1+DSOR2fzEXXUY/th2LAF9py2?=
 =?us-ascii?Q?VmyOtU4dKEJcBEMjiYN9bpYEGrTD1jb8gECXsFns5GjIHxJjbIrgUenu+7Vm?=
 =?us-ascii?Q?Kq86hR8gpimTKtVBa9Z/BE4KGTUvQV8fNXapVUfZVDXwtKKNhXFc/VmOisMK?=
 =?us-ascii?Q?L2vLHcfCnEesZFtPKwNz8ApqbCma4iySWF1pDIlEOQ1VfSeagMnN6bu/staz?=
 =?us-ascii?Q?Pq58V6e+LVR8a/GtJ54Bs8cg3xEff0O4wH8hBcaoEecSIxWQBVrJMckMVoMF?=
 =?us-ascii?Q?ADke4/FZhvQU5KaAEs7qA+xjahDKUKmjNCOBGPdhQGtFZ3mbJiPvr/voXzdQ?=
 =?us-ascii?Q?cUU7vuVT+DjaGJc3Wg+tHnPriE0OXp0b8N8tOA+PvCLtgg9mjMCqkcjpKO2b?=
 =?us-ascii?Q?RwCHGsz1ArRw57t9f0PVB0D4O693ejgd8B4yjyzaif0V+slJtkU8sUENAgY8?=
 =?us-ascii?Q?xd2MCyddbVT/KaUhj644F7sXb6k5n2GxRcNFhi8YZRtKLTEm5N2D8wLtc0Oe?=
 =?us-ascii?Q?ZrflWWE0z6i6GGtq24QLJYZTAFKQv+Wuyv2EWPbR73sMA+QWhNvpM0qH6IJj?=
 =?us-ascii?Q?ZlAdpUY0a63v+ta9QwUhlOXFAFEbwyqkoAs724+fTVlGn7G5YcsOa6KXrhiY?=
 =?us-ascii?Q?znppepMaeL4MXqHlVXTTVNWf13m5UIXPtr0225zcnPYY6MMPi1z/lQK6HiNw?=
 =?us-ascii?Q?PQdqjmrqR48OHL+XqN8ZooxgpQpjCgy08mrCOQ9ojxWwWDo6prQ664UeI1eX?=
 =?us-ascii?Q?OoBQOacB0A4FjMCihr0at+miSU6pJWb3/IvBuQ9ZSN0Vb0RkKfg/bA4ID4X1?=
 =?us-ascii?Q?B6eMq06p6HIsMY7YBA6XwD4w/pneNEO+wWXXb/0p3UlJcZz7oF3P7/NHR1T1?=
 =?us-ascii?Q?HE3042teyvkQWrJ6sTTU1YYjszINrcvjRbXDkkWVbVlyixJZN9u1x8XAFQWy?=
 =?us-ascii?Q?yLvg0TrMlw/ovQ6rWshFsFKac6INAQI96D5S0r8kmNHFQ+IdiUR55Tr5qEkx?=
 =?us-ascii?Q?UCG3HOv/Otsw/Ch0Hm3gH+XTOMTR/ITpYy5U40K/11RLX2x2RC4M+XqD+KGU?=
 =?us-ascii?Q?c0LzvYyhc//QzcrnQJDGhJhAu2ld3L0oZWyE9YPGvGRvVIJSkXpuiU2t3sMi?=
 =?us-ascii?Q?8osx58FgPocE8ugbpRkzqVjqJKhRXJbv5zQTyIC1JDcZ8sm3L8mSHVj08n+/?=
 =?us-ascii?Q?es4x3bti3iK66atzeAGeXLS1LBSWTsxZc2ji/5tBSY5KSAM757IIJDgNqPfT?=
 =?us-ascii?Q?/7HpKxFfKpD2Df3gNuuH+2Rkqbg2S72a7MDWEDg+VTY33aQIJC3E0lAPzSpe?=
 =?us-ascii?Q?+s6PT4VbXhSnNhorXBjsTt98LgcCpHihT9zaP8Ytjf5Vl9GK4HESABu9KaJx?=
 =?us-ascii?Q?Mv4g9Asj+jXlITJr/lc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c01b5f8-ffb3-4bc4-1a39-08ddf119dc5f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:59:13.2944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9P9oEN4F+ODZwDmctJNGGL9KdqvcsqyZUC05SqiJ3TJ1/T4O4Dkb0XbWYnG7ZYU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7131
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Add iMX95 blkctrl clock driver which implements clocks for HSIOMIX
blkctrl and LVDS blkctrl.
Since multiple blkctrl device for different blkctrl may be enabled,
and each has dedicated clock id from 0. We must enable CLK_AUTO_ID
to avoid conflict on clock id.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/imx/Kconfig             |   9 ++
 drivers/clk/imx/Makefile            |   1 +
 drivers/clk/imx/clk-imx95-blkctrl.c | 170 ++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx95-blkctrl.c

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 74d5fe73f944..644ab162af43 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -167,3 +167,12 @@ config CLK_IMXRT1170
 	select CLK_CCF
 	help
 	  This enables support clock driver for i.MXRT1170 platforms.
+
+config CLK_IMX95_BLKCTRL
+	bool "Enable i.MX95 blkctrl clock driver"
+	depends on IMX95 || IMX94
+	select CLK
+	select CLK_CCF
+	select CLK_AUTO_ID
+	help
+	  Enable support for clocks in i.MX95 MIX blkctrl like HSIO and LVDS.
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b10221a195cb..f2fd6ff8ca07 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_$(PHASE_)CLK_IMX93) += clk-imx93.o clk-fracn-gppll.o \
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1020) += clk-imxrt1020.o
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1050) += clk-imxrt1050.o
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1170) += clk-imxrt1170.o
+obj-$(CONFIG_CLK_IMX95_BLKCTRL) += clk-imx95-blkctrl.o
diff --git a/drivers/clk/imx/clk-imx95-blkctrl.c b/drivers/clk/imx/clk-imx95-blkctrl.c
new file mode 100644
index 000000000000..3bf6f9415e22
--- /dev/null
+++ b/drivers/clk/imx/clk-imx95-blkctrl.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023-2025 NXP
+ *
+ */
+
+#include <asm/io.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dt-bindings/clock/nxp,imx95-clock.h>
+#include <linux/clk-provider.h>
+
+#include "clk.h"
+
+enum {
+	CLK_GATE,
+	CLK_DIVIDER,
+	CLK_MUX,
+};
+
+struct imx95_blk_ctl_clk_dev_data {
+	const char *name;
+	const char * const *parent_names;
+	u32 num_parents;
+	u32 reg;
+	u32 bit_idx;
+	u32 clk_type;
+	u32 flags;
+	u32 flags2;
+	u32 type;
+};
+
+struct imx95_blk_ctl_dev_data {
+	const struct imx95_blk_ctl_clk_dev_data *clk_dev_data;
+	u32 num_clks;
+	u32 clk_reg_offset;
+};
+
+static const struct imx95_blk_ctl_clk_dev_data hsio_blk_ctl_clk_dev_data[] = {
+	[0] = {
+		.name = "hsio_blk_ctl_clk",
+		.parent_names = (const char *[]){ "hsiopll", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 6,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+	}
+};
+
+static const struct imx95_blk_ctl_dev_data hsio_blk_ctl_dev_data = {
+	.num_clks = 1,
+	.clk_dev_data = hsio_blk_ctl_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static const struct imx95_blk_ctl_clk_dev_data imx95_lvds_clk_dev_data[] = {
+	[IMX95_CLK_DISPMIX_LVDS_PHY_DIV] = {
+		.name = "ldb_phy_div",
+		.parent_names = (const char *[]){ "ldbpll", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 0,
+		.type = CLK_DIVIDER,
+		.flags2 = CLK_DIVIDER_POWER_OF_TWO,
+	},
+
+    [IMX95_CLK_DISPMIX_LVDS_CH0_GATE] = {
+		.name = "lvds_ch0_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 1,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+    },
+    [IMX95_CLK_DISPMIX_LVDS_CH1_GATE] = {
+		.name = "lvds_ch1_gate",
+		.parent_names = (const char *[]){ "ldb_phy_div", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 2,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+    },
+    [IMX95_CLK_DISPMIX_PIX_DI0_GATE] = {
+		.name = "lvds_di0_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 3,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+    },
+    [IMX95_CLK_DISPMIX_PIX_DI1_GATE] = {
+		.name = "lvds_di1_gate",
+		.parent_names = (const char *[]){ "ldb_pll_div7", },
+		.num_parents = 1,
+		.reg = 0,
+		.bit_idx = 4,
+		.type = CLK_GATE,
+		.flags = CLK_SET_RATE_PARENT,
+		.flags2 = CLK_GATE_SET_TO_DISABLE,
+    },
+};
+
+static const struct imx95_blk_ctl_dev_data imx95_lvds_csr_dev_data = {
+	.num_clks = ARRAY_SIZE(imx95_lvds_clk_dev_data),
+	.clk_dev_data = imx95_lvds_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
+static int imx95_blkctrl_clk_probe(struct udevice *dev)
+{
+	int i;
+	void __iomem *addr;
+	struct imx95_blk_ctl_dev_data *dev_data = (void *)dev_get_driver_data(dev);
+	const struct imx95_blk_ctl_clk_dev_data *clk_dev_data;
+
+	addr = dev_read_addr_ptr(dev);
+	if (addr == (void *)FDT_ADDR_T_NONE) {
+		dev_err(dev, "No blkctrl register base address\n");
+		return -EINVAL;
+	}
+
+	if (!dev_data) {
+		dev_err(dev, "driver data is NULL\n");
+		return -EINVAL;
+	}
+
+	clk_dev_data = dev_data->clk_dev_data;
+	for (i = 0; i < dev_data->num_clks; i++) {
+		if (clk_dev_data[i].clk_type == CLK_GATE) {
+			dev_clk_dm(dev, i, clk_register_gate(dev, clk_dev_data[i].name, clk_dev_data[i].parent_names[0],
+					clk_dev_data[i].flags, addr + dev_data->clk_reg_offset, clk_dev_data[i].bit_idx,
+					clk_dev_data[i].flags2, NULL));
+		} else if (clk_dev_data[i].clk_type == CLK_DIVIDER) {
+			dev_clk_dm(dev, i,
+				clk_register_divider(dev, clk_dev_data[i].name, clk_dev_data[i].parent_names[0],
+					clk_dev_data[i].flags, addr + dev_data->clk_reg_offset, clk_dev_data[i].bit_idx, 1,
+					clk_dev_data[i].flags2));
+		} else if (clk_dev_data[i].clk_type == CLK_MUX) {
+			dev_clk_dm(dev, i,
+				clk_register_mux(dev, clk_dev_data[i].name, clk_dev_data[i].parent_names,
+					clk_dev_data[i].num_parents, clk_dev_data[i].flags, addr + dev_data->clk_reg_offset,
+					clk_dev_data[i].bit_idx, 1, clk_dev_data[i].flags2));
+		}
+	}
+
+	return 0;
+}
+
+static const struct udevice_id imx95_blkctrl_clk_ids[] = {
+	{ .compatible = "nxp,imx95-lvds-csr", .data = (ulong)&imx95_lvds_csr_dev_data, },
+	{ .compatible = "nxp,imx95-hsio-blk-ctl", .data = (ulong)&hsio_blk_ctl_dev_data,  },
+	{ },
+};
+
+U_BOOT_DRIVER(imx95_blkctrl_clk) = {
+	.name = "imx95_blkctrl_clk",
+	.id = UCLASS_CLK,
+	.of_match = imx95_blkctrl_clk_ids,
+	.ops = &ccf_clk_ops,
+	.probe = imx95_blkctrl_clk_probe,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.7.4

