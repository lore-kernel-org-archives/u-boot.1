Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F288CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 783518460E;
	Fri, 26 Jun 2026 12:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bqZPB20d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA9A84704; Fri, 26 Jun 2026 12:21:49 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 267A38404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udVr3HTWnvYes3hRHiYs3GM+qod3x6LAvaM1b/qXZQtCZkWrheG/+Exz0HgC+6+jMDlHA4nvnHuJu9YziQ+yZSMBgHUC0hGD15VGPUeC4tfnNaE/boiJxLb7sUia1Cz3A/ybcaINA1hZG/ycWDz3OBl8ZreOBaFf9lOpkdsp57lr1XxphmxrKRuaXyCQVGy3Dp/iZ3xZ6AEV+QyOjsUp2zlZjR6okJT4jsYM1+Ut8Q6657n+MtWskNv5fQtCAOGEZhLoV+o1p7Lv+Pk0F+ESSEPH0VZ7ZYW3Ev2sDCuWz6S6JWQehTQPNg49qqVMX9hdKAo6cXp5SOoOfRb/6r74cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vtdm/FqH0f/PABANvmQdBn4zHaeAmGtWVIgFIhB1vg=;
 b=sOFgGRRi8zGH/SbyQ8Bn0Q5AxcS8l60bIm8ulA+qtYFtfLDM8KCUFOe5dbcIchMQ4pMY884pXtYpNRpXkKlti00C/Lm+OfJiH/Khx0oVnif1X2+TM1M7D91+aSsOgkZ+lj0EK7VQaqobI/x9up5TyR7R5kPdXqEDrzSoZhPcV317JQy+5fhFKn9myhjJFOUK9xKGN5sKVCwhH4bSaAxanFlxQvhvgy7oEjcmuK9VMTx/WbFxSLSMVsqjMTflRCU7ISVupTNYaANZXM7HwbZDC0D3b0UCgl1HTzFzMQo4HcfQXLM7gjPoThyJkuXCnwKR+Yli848tdbo1KmrVRzzyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vtdm/FqH0f/PABANvmQdBn4zHaeAmGtWVIgFIhB1vg=;
 b=bqZPB20dOMkImfoguaaDs7d8avEj97i+acgePqMochaTfI7BWPt9zFtqD7/VVTNvL1zqUK6ePN9cINewM3ATNB9IKtswzw9FITzMED7c7VfmeEzDPXTBHIKlqEmruyk2Uc3mkmtVE12B1vC09IOv6ibCE0kKqSGwWYzTyK9bAfuBovM6jzwVWBkNRb+PV2nbNdN5WWyziQzVWg/dul+pSJuUTWFyb8KAVmoqNCDPrJ2tsfpbeJO2QcnnavNPBVXD8kp5X/72rQz40B6PWYwUF6ROG2vjbhCmRZHEJ85VrJfdYoJ7YCQ+TNVjsVYUJeRImd7VyAL4QM81PzJdnKeuFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by GV2PR04MB11448.eurprd04.prod.outlook.com (2603:10a6:150:2a3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 10:21:45 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 10:21:44 +0000
From: ye.li@oss.nxp.com
To: lukma@denx.de, festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com
Cc: uboot-imx@nxp.com
Subject: [PATCH v2] clk: imx: imx8mq: Fix iMX8MQ PLL issue
Date: Fri, 26 Jun 2026 18:25:00 +0800
Message-Id: <20260626102500.2335099-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|GV2PR04MB11448:EE_
X-MS-Office365-Filtering-Correlation-Id: 5222f763-4956-4182-727a-08ded36cb81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|376014|366016|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: Ql9bK7Zy6q7vxxgRoK31JLDI7Y/q/Mm1TiOD4UvM2ZqIokPz+w+Zo8Ji/EFrCjhdvi20u/DKfSnSAWUaNKArCE/mCpS12kRkKa92st5mA/jrLP3bBWyUgys9wHoj5+fAi8LWcpRhuXrbmj9AYssC0wTvo/BzAVSqR6mCjzc6fLYuU62+gmDYzQKOzd5/wmCaQFpflI+74zOdw5FWxBjYcxPLwUlan6YeVEWSOcSkxDTWo6bMb1F2gWrWTXV8ohMZtprRgMRnMgZBuF5ntDeakk7xeUwOdvm/ewlywgZW2Q1672ZJmye22EkXPMvS4gQDNsBLZ8Q31gpPo57dq/ITEzPvl3L71FAmkuyE516kHplSAFiWys8dIPW+m+Ag1MR6D1y9a3gxOez8iVKIYn0moY4K/84jKygz8rpORIDrPpeZZ/3gB47qwYbRCdUgaE+wkbjc9Wp9KLDh71ilKKDgkGF2OT6pnSuCOfZeMPhhXlaiAJ5k3CfUP8zbHcE4uE63OGOhYW+nJkVrIletnuuCksIbDYVQZLO3y0WjA2EiDvlfPmPIr/4n9K/CnoKlZdSRWBBj0tYfjunGgFSXlMz+aoHWOlt3URODU+zvW1YTQUtAzPZaSmsPpiP4RMFslLywSYlzdLq8koF9l4901hnTZ2zVo8Ay/7c2E+8/EzIbYcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(56012099006)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jEgWs86egQgp+WIlRGtUVONdjQgGxaKG72ekv/DunedujKqsxgwHSQACSEhf?=
 =?us-ascii?Q?+slAmvsJ1m9wp1E47C6R+bJwoXfA6+POUuOBUKzhWx7jqb8XHiDDxwQCl9QA?=
 =?us-ascii?Q?sAxWdeskqZLYCjAGyQJZAhoGmWa+BMav6i2X3qAO05RSo7h4KiUIFKmAKjOM?=
 =?us-ascii?Q?9EIFVHLh76M4Kuxc7cCJ4Hz+/IOf9oClrBecS53WR6q4JL+uCQy7mBZVlsWl?=
 =?us-ascii?Q?HkzX8YPgX6vSjWNhd1mxUbmgCu3Ng6jkjiICC7MsiQ85CG4AA2T9z1w+Aw5X?=
 =?us-ascii?Q?Zl78BMi03dge0oLMqY4dm5+sK4TLCVWffZVPdY9Xc3Ubz66KfyevNPxCgDk9?=
 =?us-ascii?Q?hxa8u9QfxDD/p2qhPPGB1NwGZn5LoLWafgACLT6qwHvCLm+pmusDZKW7iQJ/?=
 =?us-ascii?Q?C/+G6d0bcuKVY/n4wNgWm6rnRDFYKNwap/4XvxtLBJmvwCT2HwI/9uV9gXTT?=
 =?us-ascii?Q?iU2U1gvPkhy0wKY35SB+7DzjxeAjvOSLE7NynZmaMkQadC7PMG5vNO24R/Zg?=
 =?us-ascii?Q?FPrI7ImJWr+OHPOWQMeTmzzec7w5EIEbMb0+8LbNQXwmS+Eie2LX1jV9CDg0?=
 =?us-ascii?Q?nEmkA2vJ/D94PYTAm1DuYXjJFzQoZkIcicePK6+mftp4IogOO5yxcHZY0lM4?=
 =?us-ascii?Q?asPGUI0Zk+fq23YoVzj1AAOOg92aDXRSQC+eOgirr0ovxX8OdWPWZr8anmq1?=
 =?us-ascii?Q?QdFQ6h1ceONnq0UnWsLooeOPK0zYappvx9UWvzLB58FPlXH3Yn0fF6x1gYL2?=
 =?us-ascii?Q?rpZyHhEbuOTo0SvCmqlwRxjOFsdiaOY0mJ1MZ6sdFcSFiJL/Zf1NZ8Axd2WX?=
 =?us-ascii?Q?vu2zYR9rzxPmS4dYKpF/Y6g1UpfUuUKkWAaN625lmDNdaIZy2BeU1ZW7+23H?=
 =?us-ascii?Q?he3hZZFCWxNXMxzAE9UuXMOJBIjgsqJF7u9CbTyuM6R/EM8QWbeeVf3VUNX3?=
 =?us-ascii?Q?YC5OgjSkRYGclwhbGvcj87hG+Tu9uogwqiyYgZmxuNDmKSttZ0G8lGcZASGy?=
 =?us-ascii?Q?U98o0JqC8p0026Tyd//+GgVp3CT201nfrB2B3YUEwqNBoQD496Bdx/bhK3Rt?=
 =?us-ascii?Q?D9S75+UFn8eTOEYh24Fc4T9rEVVTI6W0dyaWTlTX4H2Jl65Ay2UrUX6JHDJn?=
 =?us-ascii?Q?Uqqn2o4WaUoO/3LyobgW7NVOeb3mH5lIhLwVvnJudaGYSK3raUc2lRNQKJ31?=
 =?us-ascii?Q?yE8AnjjyGxtbz7ctfMscie7qYpFlaijq9/YWVNPAiLhOPhK7iuXwGAITBfdQ?=
 =?us-ascii?Q?psLocXUVllgA10U7b+MUyEFkKIlNTGy3AFMo5pqBjjRs0GoKvlyvvQgzRJXA?=
 =?us-ascii?Q?MjfgIr4GgmPsR0p5CQeQ4w1+MWC1J7FH2A7hXvI7Q1azpc+T89UJ53pxK+zH?=
 =?us-ascii?Q?TpcgM9Y8LuZ4K/Sq6oz2VtNbi7XE6jMXse/HCV4iCWQxkppnsMW8cP8yPggl?=
 =?us-ascii?Q?O1ATJMol4UUzHInQwL2GiDuqMe59abzudm3AV3lpZUAyB08c9QXT6WntvIDd?=
 =?us-ascii?Q?ULfu4LD1fXpL0HKgGN0psjPuO+V79UNDdnurTeoiHHWB3tltCP9nsDostVMd?=
 =?us-ascii?Q?NQYVQb+T++sw57bocoBAD35M9ZNeLyQmrdLe/x+9B2lGpgSJyk0Dh5CQ7iRV?=
 =?us-ascii?Q?+3o8cI7JRQ2sBajyJDiecbApJJ8wFxJXb6nvVtrJ7Vjh7IjdVpuhLFypdWzg?=
 =?us-ascii?Q?GzUY+BfMHbZ9DIyUWzLfzEU2aH5vuSK+7ApPYIUebJalFEQHem2iuvpM1mC1?=
 =?us-ascii?Q?QelkdN4niWx+smWDr5ogkFbRzjUkBjo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5222f763-4956-4182-727a-08ded36cb81d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:21:44.3659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyDupVS+OsW3mqRDszxwXoYPq7cGj9JUCUcyvH7CYqALdZbk0KIMz2/G5em3x7TRXxHEtNb34flXuj3CAhNI6s4FDGYlpoTuLJWTC1VMdEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11448
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

From: Ye Li <ye.li@nxp.com>

The fractional PLL used on iMX8MQ is not pll14xx, it is different
PLL and not exist in u-boot. Add this fractional PLL driver and
update iMX8MQ clock driver to adapt this fraction PLL.

Fixes: 11c8ab01f3ed ("clk: imx8mq: Add a clock driver for the imx8mq")
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
 - Update copyright
 - Add fixes tag in commit log 

 drivers/clk/imx/Makefile       |   2 +-
 drivers/clk/imx/clk-frac-pll.c | 199 +++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mq.c   |  55 +++++----
 drivers/clk/imx/clk.h          |   3 +
 4 files changed, 237 insertions(+), 22 deletions(-)
 create mode 100644 drivers/clk/imx/clk-frac-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index f2fd6ff8ca0..a825ed9988f 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_$(PHASE_)CLK_IMX8MN) += clk-imx8mn.o clk-pll14xx.o \
 				clk-composite-8m.o
 obj-$(CONFIG_$(PHASE_)CLK_IMX8MP) += clk-imx8mp.o clk-pll14xx.o \
 				clk-composite-8m.o
-obj-$(CONFIG_$(PHASE_)CLK_IMX8MQ) += clk-imx8mq.o clk-pll14xx.o \
+obj-$(CONFIG_$(PHASE_)CLK_IMX8MQ) += clk-imx8mq.o clk-frac-pll.o \
 				clk-composite-8m.o
 obj-$(CONFIG_$(PHASE_)CLK_IMX93) += clk-imx93.o clk-fracn-gppll.o \
 				clk-gate-93.o clk-composite-93.o
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
new file mode 100644
index 00000000000..e286ed56d33
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2026 NXP.
+ *
+ */
+
+#include <asm/io.h>
+#include <malloc.h>
+#include <clk-uclass.h>
+#include <dm/device.h>
+#include <dm/devres.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <clk.h>
+#include <div64.h>
+#include <linux/printk.h>
+#include <linux/bitfield.h>
+
+#include "clk.h"
+
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+
+#define PLL_LOCK_STATUS		BIT(31)
+#define PLL_PD_MASK		BIT(19)
+#define PLL_BYPASS_MASK		BIT(14)
+#define PLL_NEWDIV_VAL		BIT(12)
+#define PLL_NEWDIV_ACK		BIT(11)
+#define PLL_FRAC_DIV_MASK	GENMASK(30, 7)
+#define PLL_INT_DIV_MASK	GENMASK(6, 0)
+#define PLL_OUTPUT_DIV_MASK	GENMASK(4, 0)
+#define PLL_FRAC_DENOM		0x1000000
+
+#define PLL_FRAC_LOCK_TIMEOUT	10000
+#define PLL_FRAC_ACK_TIMEOUT	500000
+
+struct clk_frac_pll {
+	struct clk			clk;
+	void __iomem			*base;
+};
+
+#define to_clk_frac_pll(_clk) container_of(_clk, struct clk_frac_pll, clk)
+
+static int clk_wait_lock(struct clk_frac_pll *pll)
+{
+	u32 val;
+
+	return readl_poll_timeout(pll->base, val, val & PLL_LOCK_STATUS,
+					PLL_FRAC_LOCK_TIMEOUT);
+}
+
+static int clk_wait_ack(struct clk_frac_pll *pll)
+{
+	u32 val;
+
+	/* return directly if the pll is in powerdown or in bypass */
+	if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
+		return 0;
+
+	/* Wait for the pll's divfi and divff to be reloaded */
+	return readl_poll_timeout(pll->base, val, val & PLL_NEWDIV_ACK,
+					PLL_FRAC_ACK_TIMEOUT);
+}
+
+static int clk_pll_prepare(struct clk *clk)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(clk);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_wait_lock(pll);
+}
+
+static int clk_pll_unprepare(struct clk *clk)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(clk);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return 0;
+}
+
+static unsigned long clk_pll_recalc_rate(struct clk *clk)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(clk);
+	u32 val, divff, divfi, divq;
+	ulong parent_rate = clk_get_parent_rate(clk);
+	u64 temp64 = parent_rate;
+	u64 rate;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	divq = (FIELD_GET(PLL_OUTPUT_DIV_MASK, val) + 1) * 2;
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	divff = FIELD_GET(PLL_FRAC_DIV_MASK, val);
+	divfi = FIELD_GET(PLL_INT_DIV_MASK, val);
+
+	temp64 *= 8;
+	temp64 *= divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+	do_div(temp64, divq);
+
+	rate = parent_rate * 8 * (divfi + 1);
+	do_div(rate, divq);
+	rate += temp64;
+
+	return rate;
+}
+
+static ulong clk_pll_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(clk);
+	ulong parent_rate = clk_get_parent_rate(clk);
+	u32 val, divfi, divff;
+	u64 temp64;
+	int ret;
+
+	parent_rate *= 8;
+	rate *= 2;
+	divfi = rate / parent_rate;
+	temp64 = parent_rate * divfi;
+	temp64 = rate - temp64;
+	temp64 *= PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff = temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	val &= ~(PLL_FRAC_DIV_MASK | PLL_INT_DIV_MASK);
+	val |= (divff << 7) | (divfi - 1);
+	writel_relaxed(val, pll->base + PLL_CFG1);
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~0x1f;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	/* Set the NEV_DIV_VAL to reload the DIVFI and DIVFF */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	ret = clk_wait_ack(pll);
+
+	/* clear the NEV_DIV_VAL */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	if (ret)
+		return ret;
+
+	return clk_pll_recalc_rate(clk);
+}
+
+static const struct clk_ops clk_frac_pll_ops = {
+	.enable		= clk_pll_prepare,
+	.disable	= clk_pll_unprepare,
+	.set_rate	= clk_pll_set_rate,
+	.get_rate	= clk_pll_recalc_rate,
+};
+
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base)
+{
+	struct clk_frac_pll *pll;
+	struct clk *clk;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	clk = &pll->clk;
+
+	ret = clk_register(clk, "imx_clk_frac_pll", name, parent_name);
+	if (ret) {
+		pr_err("%s: failed to register pll %s %d\n",
+		       __func__, name, ret);
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return clk;
+}
+
+U_BOOT_DRIVER(clk_frac_pll) = {
+	.name	= "imx_clk_frac_pll",
+	.id	= UCLASS_CLK,
+	.ops	= &clk_frac_pll_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index fe6cba19758..78156003ad9 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2019 NXP
+ * Copyright 2019, 2026 NXP
  * Copyright 2022 Purism
  * Peng Fan <peng.fan@nxp.com>
  */
@@ -155,39 +155,52 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	       imx_clk_mux(dev, "dram_pll_ref_sel", base + 0x60, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_ARM_PLL_REF_SEL,
-	       imx_clk_mux(dev, "arm_pll_ref_sel", base + 0x28, 0, 2,
+	       imx_clk_mux(dev, "arm_pll_ref_sel", base + 0x28, 16, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_GPU_PLL_REF_SEL,
-	       imx_clk_mux(dev, "gpu_pll_ref_sel", base + 0x18, 0, 2,
+	       imx_clk_mux(dev, "gpu_pll_ref_sel", base + 0x18, 16, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_VPU_PLL_REF_SEL,
-	       imx_clk_mux(dev, "vpu_pll_ref_sel", base + 0x20, 0, 2,
+	       imx_clk_mux(dev, "vpu_pll_ref_sel", base + 0x20, 16, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_SYS3_PLL1_REF_SEL,
 	       imx_clk_mux(dev, "sys3_pll_ref_sel", base + 0x48, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_AUDIO_PLL1_REF_SEL,
-	       imx_clk_mux(dev, "audio_pll1_ref_sel", base + 0x0, 0, 2,
+	       imx_clk_mux(dev, "audio_pll1_ref_sel", base + 0x0, 16, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_AUDIO_PLL2_REF_SEL,
-	       imx_clk_mux(dev, "audio_pll2_ref_sel", base + 0x8, 0, 2,
+	       imx_clk_mux(dev, "audio_pll2_ref_sel", base + 0x8, 16, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_VIDEO_PLL1_REF_SEL,
-	       imx_clk_mux(dev, "video_pll1_ref_sel", base + 0x10, 0, 2,
+	       imx_clk_mux(dev, "video_pll1_ref_sel", base + 0x10, 16, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_VIDEO2_PLL1_REF_SEL,
 	       imx_clk_mux(dev, "video_pll2_ref_sel", base + 0x54, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
+	clk_dm(IMX8MQ_ARM_PLL_REF_DIV,
+	       imx_clk_divider(dev, "arm_pll_ref_div", "arm_pll_ref_sel", base + 0x28, 5, 6));
+	clk_dm(IMX8MQ_GPU_PLL_REF_DIV,
+	       imx_clk_divider(dev, "gpu_pll_ref_div", "gpu_pll_ref_sel", base + 0x18, 5, 6));
+	clk_dm(IMX8MQ_VPU_PLL_REF_DIV,
+	       imx_clk_divider(dev, "vpu_pll_ref_div", "vpu_pll_ref_sel", base + 0x20, 5, 6));
+	clk_dm(IMX8MQ_AUDIO_PLL1_REF_DIV,
+	       imx_clk_divider(dev, "audio_pll1_ref_div", "audio_pll1_ref_sel", base + 0x0, 5, 6));
+	clk_dm(IMX8MQ_AUDIO_PLL2_REF_DIV,
+	       imx_clk_divider(dev, "audio_pll2_ref_div", "audio_pll2_ref_sel", base + 0x8, 5, 6));
+	clk_dm(IMX8MQ_VIDEO_PLL1_REF_DIV,
+	       imx_clk_divider(dev, "video_pll1_ref_div", "video_pll1_ref_sel", base + 0x10, 5, 6));
+
 	clk_dm(IMX8MQ_ARM_PLL,
-	       imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel",
-			       base + 0x28, &imx_1416x_pll));
+	       imx_clk_frac_pll("arm_pll", "arm_pll_ref_div",
+				base + 0x28));
 	clk_dm(IMX8MQ_GPU_PLL,
-	       imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel",
-			       base + 0x18, &imx_1416x_pll));
+	       imx_clk_frac_pll("gpu_pll", "gpu_pll_ref_div",
+				base + 0x18));
 	clk_dm(IMX8MQ_VPU_PLL,
-	       imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel",
-			       base + 0x20, &imx_1416x_pll));
+	       imx_clk_frac_pll("vpu_pll", "vpu_pll_ref_div",
+				base + 0x20));
 
 	clk_dm(IMX8MQ_SYS1_PLL1,
 	       clk_register_fixed_rate(NULL, "sys1_pll", 800000000));
@@ -196,14 +209,14 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MQ_SYS2_PLL1,
 	       clk_register_fixed_rate(NULL, "sys3_pll", 1000000000));
 	clk_dm(IMX8MQ_AUDIO_PLL1,
-	       imx_clk_pll14xx("audio_pll1", "audio_pll1_ref_sel",
-			       base + 0x0, &imx_1443x_pll));
+	       imx_clk_frac_pll("audio_pll1", "audio_pll1_ref_div",
+				base + 0x0));
 	clk_dm(IMX8MQ_AUDIO_PLL2,
-	       imx_clk_pll14xx("audio_pll2", "audio_pll2_ref_sel",
-			       base + 0x8, &imx_1443x_pll));
+	       imx_clk_frac_pll("audio_pll2", "audio_pll2_ref_div",
+				base + 0x8));
 	clk_dm(IMX8MQ_VIDEO_PLL1,
-	       imx_clk_pll14xx("video_pll1", "video_pll1_ref_sel",
-			       base + 0x10, &imx_1443x_pll));
+	       imx_clk_frac_pll("video_pll1", "video_pll1_ref_div",
+				base + 0x10));
 
 	/* PLL bypass out */
 	clk_dm(IMX8MQ_ARM_PLL_BYPASS,
@@ -356,8 +369,8 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MQ_CLK_A53_DIV,
 	       imx_clk_divider2(dev, "arm_a53_div", "arm_a53_cg",
 				base + 0x8000, 0, 3));
-	clk_dm(IMX8MQ_CLK_A53_CORE,
-	       imx_clk_mux2(dev, "arm_a53_src", base + 0x9880, 24, 1,
+	clk_dm(IMX8MQ_CLK_ARM,
+	       imx_clk_mux2(dev, "arm_a53_core", base + 0x9880, 24, 1,
 			    imx8mq_a53_core_sels, ARRAY_SIZE(imx8mq_a53_core_sels)));
 
 	clk_dm(IMX8MQ_CLK_AHB,
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index b53f35df84f..6aef72c0212 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -78,6 +78,9 @@ struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 			    void __iomem *base,
 			    const struct imx_pll14xx_clk *pll_clk);
 
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base);
+
 struct clk *clk_register_gate2(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx, u8 cgr_val,
-- 
2.34.1

