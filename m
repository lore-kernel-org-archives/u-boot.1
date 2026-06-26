Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31BACDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386ED8496E;
	Fri, 26 Jun 2026 12:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QKsacH/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE138498B; Fri, 26 Jun 2026 12:41:35 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E176E8460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm6qhfVkBUb1J9Yy2hkKVBWuJewkHtV+yEzLCFkFWEC+q92lVGe0D1s4qu8qDLZnO7SauxQVjvlwQohHjo/dCtecr+GrlgBCNj7KJVu1zT8XnynAQMHgNxHDDnOZNt+Up1ep+D9Ad+m2QUESlG+cAlWhswsVxOgngb86FwVn88BIRlMp+KyXVbRi/58ESoHdQAQzxaXFcsH6xxn+FPqEWz53J1zCmrnsskRdCXlQclfXtnFNAyeW5EEzt/AtZUOR7vt/7lcRpZ45OLaHIaKi7WJOKsJdcBeznq09fNmaQ5DymFz7kKpRMcNS321jB3kD32l6W72YneKZ1/5MMLZF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twmsCuHTM20lOZD14AYrlMBl9PmIg5eparaiMZ7KPao=;
 b=Um1iIvHPnmyeFOrrYVqY6l9EQ8RTDml3ILn0Xm7CYmSrYXXjMMsb7H9VmOj/GtP98TlLr/XouYxfHAgaoA31+PB44R+R2g8JBD2WdcArxojdNU4jTzYUt9qJ5Q4OgmqARZ2uN/rMQb7V9KNx2r5UXcqgCpI4ttxZgoqwGwmKBsW12PWxLai8HOYRy8ihyAMvLVnyNfCF4/usu4oi85ACmXl+qMXOu6F/HrGQzUK38/zIVVaZPHFsfRPccVDDGhCYMuCMT1VhvyBh2JbwJ3Tj5QOJbkzEZF/wLSLj6YebZgGtsN/w1eXAMKkwqCAyFLLJ4rqEO1C5GW8RI5AwTl3tLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twmsCuHTM20lOZD14AYrlMBl9PmIg5eparaiMZ7KPao=;
 b=QKsacH/64YA9DnfovZ//pQMeR+LwCRyA+plrSj361bK7siBwqDJ0+no8XP6tDRlmh3XkFsBMO0RYehePi6u0HGU/cWN1cpbWIOy54CzEjV2mRyaO5HZWvY7eUa6uR6NXKbdpZkidoABWNWiFoNgciypYH2fftFT7aOkGpLbsLScsPvftJg/RZ3tGTBnuluJ3cmAJSx1B7keitI1qxEFcDhWnqdM9eoG4uSeET5F+U47bXfuAJUw9yjwwGHGFbb745aHhCfDFuCGocisYEnhmz8Je+O4aBFjfvReMmoAY0lJBfZBPFZm2SEuQ2Ac7ICGB6L7lTtGiirx4C8NGeuNMvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by VI0PR04MB12323.eurprd04.prod.outlook.com (2603:10a6:800:320::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 10:41:31 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 10:41:30 +0000
From: ye.li@oss.nxp.com
To: lukma@denx.de, festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com
Cc: uboot-imx@nxp.com
Subject: [PATCH v2 RESEND] clk: imx: imx8mq: Fix iMX8MQ PLL issue
Date: Fri, 26 Jun 2026 18:44:49 +0800
Message-Id: <20260626104449.2379558-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:4:297::17) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|VI0PR04MB12323:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b91f76-ae00-4cba-4f83-08ded36f7b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|19092799006|1800799024|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5jC/Tp5X7u1YB/y0NA+cvvCKAEyFvUwoB6F+07gtZESQ4kT6faOUh7rTEbaLwctqHD1OsLmKvgwSYCkBrXppBG/3pG32KQ5yNm50g4wZ1+4cbVfFWmAwcdh32eCJluVg62kzMGfx9AE4bUR5f9xxjvr1fKbOtsxXnFubi8yoc5ySo3/Npu0Ypmq7ldXrRB7sHK9NwafRSi/TBogZZZ2HPu/zJRyyJKSgp1JnKfxW1DehfVScj4CMQ+iTdmYprq1XHwmz8LxHvsPzlqB8Brdw22OcSxuHt95p2SBjNEIfgl1faZ7c37nYEMtQtTXjGlujnk2UcpGvOL14lfV142eIlrQvoa/cWrWazqpdX/sUrglpFerlV03c4oAftWmMeBe4SIg8dTaYKlHTJEWRrh6q07qEqqVgwYcwxBZEu090qGzrcNFUrTnjV7gqxertsj5Rv77aLZgsL8+vOfbrV3HEEuc5v77OK/Sqzq6hbwYxVXnjF5tc1yz6VxJYmNMK9tog5XKOd2yfhyPSteH0AMYymDNII3qk3l+QARgg/6rdcJccbj5uUridzg3VBhnYgW0Yj1xT09yFogq6l8KFmhu3oG52gn6omVIP3TMbjN66Wz686Ky/YC+3gJy040Dc7qlG8tiAL0PwD8AMmpKtd3kQNbCNWyahWMBO6isVCr0zeIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(3023799007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vkaFhYJiTUhuqwxCq8EzKBIQFIY6SAj40D5tkzzm9+GSIS2nqimfBUH9fXn?=
 =?us-ascii?Q?Wp9H5D1hqvlbaStrcuAzv/f9DFpVTmdGAF1GUPvXSeSYafoQnKqsFrAG7Q9M?=
 =?us-ascii?Q?jWxGtZ3jq5k4ghbEJa7/u/YFACE4S6JSOO5dJhwoIbg0burRYFa87Sv+dOoS?=
 =?us-ascii?Q?f6NfTd9Bzuvo7d46y8A2G9VjrrtNPb90wzSkT56ka/7l8rt97VdFODbRk6Kt?=
 =?us-ascii?Q?gdAMJWZjgEQbOcWP/jfEnGDVbTDImPEjaq982bXMjAULhHvNZTrFT3vs1Vs/?=
 =?us-ascii?Q?uvPFhbn/uukaOcK7HEBRWFHQpahMrbGGZZzu/v0ezdyDWc3k7IArgp99L68P?=
 =?us-ascii?Q?L7l4qCGJh8DL2BThPPDJ6J6QVAM717zYQskWSFrox18fUDZTvYYn7uvP4xIs?=
 =?us-ascii?Q?DFvwjWjyMzOo7dPLFIQBQjfAbp3n8+zhndtO96ItjwP5rKc6DwB55+fujY/N?=
 =?us-ascii?Q?yskTmyOjMg0YvhcYpXfke1xTYPlFxYWJeDmNIxfOCyVME+bQQojzLFZsdEbE?=
 =?us-ascii?Q?uyY/Ml/SOI6ZtDEU+Gb2hFOWRdAZcQSsonQvT3GI7L8Ki96eIdphADJVDeM6?=
 =?us-ascii?Q?zB1ZTkXxx+Efas3GnbjoT/iMXVb7Eu50lm8DwHJKUtXEkZuNLq/gfMSb1guQ?=
 =?us-ascii?Q?TFGTN6MWquaGWSa7hp474lB5G62EXKUSPx/au7RaSDzZ7F4eAScUJGnC0Ps9?=
 =?us-ascii?Q?LA+7ZBPjh+qiJ+87+rHNEOiAQ0elcfj9ju5bRFCcbY1Rc8M5oMqtF4tjzpa8?=
 =?us-ascii?Q?ucWh1+tuQ/ZC0MPv6ai5LNmJXCUoAYxhfDahSroEJR7gVpmHGhKjpBJepyXu?=
 =?us-ascii?Q?EtH6qwT4PWV6FipXl7O3VfweFpiNr50t1sbuV5Hsn4riIFWlSiHlWDzNRgH8?=
 =?us-ascii?Q?1j1sbr2+fYgHv+hJSo2aYD2JxNXxtB7jDMyr+cMOI0bgXApS1fxkwctKvtZj?=
 =?us-ascii?Q?Bke2hrk2GH+BvrspU1TcelnkQFEmq5rKzqfv6U9ksBcKvcUQR8oVYpWP7qbG?=
 =?us-ascii?Q?/xUXh/q0wFGa19CeRTdbzGxU+RtcPaxx4fAsVoVP6JMs0wWePw7F9aMqTDTK?=
 =?us-ascii?Q?921C6mCQssbVy7HOdlvMkIL00RxfHfgTQfMo6z8LrW51erSJMER8y9W9RwOM?=
 =?us-ascii?Q?N+07WOU/GWBsQC9Wl3qjVsO3a4vGtQiuAwf1GWyyWbtLIBuT6T1rKTZ0tWsQ?=
 =?us-ascii?Q?HYvnM4L1gwjS1NZe/Fc1KJkMX+bWLCFJOyQH4j74QGgTb7kcoYM+p0fRwgxI?=
 =?us-ascii?Q?3BMDni5TcQpBHp6YjX1/djwqqvgBuLcq7Emj4fE1F78CohyjSGLmREaz2UB4?=
 =?us-ascii?Q?q1IsmSRPpLw+fbTaB5Hne6BuAQsWrkr1kYTnl/Gg0JATKfzKRnRS5FZrujIV?=
 =?us-ascii?Q?TSbb37uPo8GG6WWqRI3FnJMINJY0cFsMiSVeYwrhb9+udVJUHT5ITQPOf1f5?=
 =?us-ascii?Q?DdDCmttjGWEuO1QZdlYqJsL/R9ibG0J8nTJ7o1ORT2zBvF8wT2vsl1hc3QU2?=
 =?us-ascii?Q?OP8MUf2XuFStWdfeq70mWJj1vjK7tW66hEAOjbEozjd3Tvp/dFRXHyk+RP+n?=
 =?us-ascii?Q?pka+8I3PH9OmxbncqzQVwPa2qtN7BHk+2p2TSv/Q2V8Z6MwZ+Pkb+5TaZnei?=
 =?us-ascii?Q?PFgagOJiMRcvLt5bwSJAVlPF4P5GtVhUlt4uJuisH0c4oCj3/nHWqhMuqi7J?=
 =?us-ascii?Q?jf09ZIOsbWoqlbYvTT8BYSNY9eaJDSLWELugUxzlaHT2nC6d0q0TnaH9Zrhd?=
 =?us-ascii?Q?z2Z96nGpI6Eu5Qw8kbJXzgwKszMjtIw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b91f76-ae00-4cba-4f83-08ded36f7b67
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:41:30.2039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7z4FYcdJzDiVFs3MoIZEDbiTtehKz8iiiyyKOlwOlN/1Fk2IMRJ4e/JnT3Io6i38A0jW36Y8RsWK8MvjRK0TmpMwzN991T+6Y1cqQKVgqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12323
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
index 00000000000..057389d3069
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2026 NXP
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

