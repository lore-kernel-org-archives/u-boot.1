Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C598CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 05:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7588847C3;
	Thu, 18 Jun 2026 07:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rwi6CKRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F06847EF; Thu, 18 Jun 2026 07:55:50 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3147B8460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 07:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCbBzqSSro4nqGuyc4Hl3hkB7rTlwIG930EKknzZqkcj3nhrl1CUTypFfmDWfnFXdmR5xqgDurQVzAEVTWSame8Ifr+2mrizHT9RAhTSzOvvo2OzxeeeeMxdjrAMiZdDlKThhPk+06Y6roMD6H74BI/Vw1YV308HAF5UiNsITzxJ+PuqePkVmFKqPAPC70lKV/BAERUHiZaAVpRgLIsldv4jkwSzc1Q4jud724X4rrHo6+88ejwFTu7bJOzaGATa/USyBgLwyc2Q3USZ3WH8B9ODzSyKXJBKCnnY9KH9pTb1FDkG3FBS2NoWdCffg+bXvOIriRaII1WvHWUpCMJcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aywUWGh9cdNOOYhVTKrXXAtwqoFm+EcbCVhVxevsz0=;
 b=OxzjNAJOBv1F5GNpEYi5xnr8cKLbkvjfuDKLbG2yw0BTUxcxymBu9CTaLFyeIu3UbF8PXB1TymFTpN7n/eCu5MuTt6nea5Iadzc5ApX4ovktM0iFjqOwNKWB6N9Rmfv1ILrnfGOtEw+drwNNyMzCYhZnRM6JRzf2v7K3Zif/OPe0LL0wvM3iDToJABt1eDXYf5TXy9xHcOf5hEiXJ2/WrGuPtXhZgTGpxyhBcx1YddBNwKpxTk/ed2PC6+EVX8BxEKJXEpYPwtSBMBR+D1/xBOXSYojYIQHDIwkKAGbQnQXV7kJGL5KsMeCARtq2K5D9zOq+E++KdQCKqpKzqI3ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aywUWGh9cdNOOYhVTKrXXAtwqoFm+EcbCVhVxevsz0=;
 b=rwi6CKRmZFDQk++izOUoSkKY2Hcaq0GwP64VW9wPoItbWX8AkkVvgPcaARakkYy456LR98oERys/GWK3SzH5l2p/YT9hmSJLOgHZ14ivile4lKNXGzAPWMS9k5uVR+zdDksCWOa/PSCubpbv2zuM39yATV7gH36XI9PXlnHXm6H7tQxLVJzcixhBYBIcaePw07bzN+puAkOPYSqFa28exWLb4TyP0A2KyJkaz99GTgc6bZaEp68hwj+tiHKCHHGlDtHL0M0WOCcGWqyJQ95uOVzg7kENhJOkuhl7Bj/WPQCUTIxkC6dBAt7rTC8gNstR1jlQ/3yWVbIVBZnG6OnQaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by DU4PR04MB10696.eurprd04.prod.outlook.com (2603:10a6:10:590::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 05:55:46 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 05:55:46 +0000
From: ye.li@oss.nxp.com
To: lukma@denx.de, festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com
Cc: uboot-imx@nxp.com
Subject: [PATCH] clk: imx: imx8mq: Fix iMX8MQ PLL issue
Date: Thu, 18 Jun 2026 13:58:56 +0800
Message-Id: <20260618055856.3185658-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|DU4PR04MB10696:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff4b273-e331-46ef-a096-08deccfe3d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|19092799006|376014|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: O2oZIW8KJWtcqA/t/BCgccF1VxKVYZjBHrCMTa56JnMJllwFbb4ZZ0v7HiuA+Gcl/+iCEyPMTPLq23T9xVOvr0iy5xHz71zlE6PZiH60IChWplX1ri1iw+1p4wfZ1nXx6sg9Lii+I+7vaCNAIN0+rIjTRtYjVpMRBoPSwxRpdzZ3aPiUKyy8mde92Wk6hdNZSzO/FYNsKaddInydJiRpDzPsDgoYXh6TTuLMu5dGS7ujNIiClZ5P3wDjvRmssManma7ayrGIDIBVtO5bVkT29kP4bFawU53BcbEFxTGOx67CokQ8eqfOAk9BoOBl+07MD79mQrVGgTo+SWuguMDODYIGvhfaV9a5j4RBHECm4JK11mhNUdt+HLg/CYKv2GUY+iWq5vVblZY8KJo7fqDdxA+DXOOxCF1ixGp/KkELQFMRklfbZoaY2TaQj6rmnKwwi4ydG6lmZGjxiIT4fnunzINpWkRH3MudUXQXImVjRrG+/RqrfsgAocNPg4Y0QfcPs2d/iq0DgpYxTI+LuU3GA0nVlWaJhaEOcYgoeLM9fDsEal6OIBerm+4l4eUKtFN/szwONMs0bDa3KOK/P3ShEWn5qYQWhHDZEhZzbTgYu4H/3jMT/fh+7FyLf8cAxnemhrkIvcHEo87LXzY4S0Lq7aaMZEigqSgQOkitrTo+H3isIIsbCFJ0ZsIJH7zOMv2g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(19092799006)(376014)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8U9mokcDW9BkH0k+qZCeRiCt5HQ5c2Ch6qx8t91ck7l345pVBfP2sOK6/BYV?=
 =?us-ascii?Q?IAYiYxbNx+HOhwQjJ8a14xQscGF7M09+MzlzPb1shC0317SrXKs1ZgDMn6o2?=
 =?us-ascii?Q?Bk3Ba0bcrQiEbbsOOiR0cmlA93SQueOL2gDVTs2X9xSFLhFBhEgKdClWRDUy?=
 =?us-ascii?Q?v4LDwr/vzHXPqJ5PjOXT87VovXJ5WmK1pbGWVYjrvyA020IdxPwwE7e0yWDE?=
 =?us-ascii?Q?3j5VBd2kOccxfjF96Kp6nJsd1o0NxrGuwMhcYHsZwwcs25+xh9dTRi2syaQv?=
 =?us-ascii?Q?+LNsioxtyEXboIrv56qQPMvedJhVe3WNsn6eKTKz/6x3JFhpwVuREMMsmoSt?=
 =?us-ascii?Q?S1zFc7wdQ0KGOkVsrEHRRKfCD0+yB8gsKbQpJPWtNAoQZFg1ixy2gcrL14Ii?=
 =?us-ascii?Q?37dvrpBJxqr6gHHFOU5fkgi47YlSwv3ww36MrausYxuNZe4nP9fPjk6q6TcE?=
 =?us-ascii?Q?U0jFGn3vxo2at3zJ9r+amOyU+ttrK/PhKbKpTTJdlZ/Dc9pEq/0X9Jl1G7LC?=
 =?us-ascii?Q?Ivy6I4apG4XFzjimU8L7YVXSw87VaNSm0xeU299OoyUaPk1HXKCfjdIE6YA0?=
 =?us-ascii?Q?gARTClTUT6+Svt19BBxee9ARL4CX5mD67R6bQLNnHQwjsuWCMaWqW28Ek73b?=
 =?us-ascii?Q?ffwpGFVEYo0VKHTUqx7hZjJLOKyqT0g8dk7YeuGL9VEjLfJbf0vwDsvkJHyT?=
 =?us-ascii?Q?oaA1bvtreguQCe2eFVYwgr25eU4TZfzN7xLlobgHjnGTZ2N60ThQcQo9qvj3?=
 =?us-ascii?Q?+9Gdr/l2fzkd8GYcK5mqFNthETvGtKvjnnBDUs0Ur0onMDn2tmhIwj2piXoJ?=
 =?us-ascii?Q?1T0WmS8ynOBjxexcJP+5rN67xd0F1JwWMjVGJIRWaAlmw81G55GK9KN0I4CM?=
 =?us-ascii?Q?OGvvKawq5ZKdLW0vSb1l6876VGLjuj9VyRS5IfK2/rDSjTlvPfWoChmk2tqg?=
 =?us-ascii?Q?df6pgc/qNnRttFVQ2VzBKZJ3ML7SXpGGwqFZh670JZSI/g2CAp3vgpVfECXv?=
 =?us-ascii?Q?MjFAdBi9Gr+5GQiJKEjo1ry/2dE5DNguMfZUaP7/1FqRSXf0PCf7ju4UMi8o?=
 =?us-ascii?Q?xtWBviUmq0H59LB3q3f2sZBn1hPYVIGtBAgIgWkiUhvljuh1Kpvt+Tp8doHe?=
 =?us-ascii?Q?sWWeFhV1nk+VM0OBI1z7C1+y5u2pW5NLwGGyY/0tIC2dGfK44DBFRjxC1o+G?=
 =?us-ascii?Q?LwUN80183vpCsts88MpZgYWmnhW3nlHoQU2hHj2ZKqhzooUPmZtTAP/GFB2o?=
 =?us-ascii?Q?TlSSlitVxoTqX5GldHOuJntolguxWwnz/Hv07L7FQfNZZaYe6xFWoDNgArIo?=
 =?us-ascii?Q?dcfjy/rapLjwKSO97W2HFiT9Y16hXeuljIWj+hhRpeaHGYOBFGjq6bSSrFAR?=
 =?us-ascii?Q?boR3wsFj//1ygihfwp6cvuidCOFhSvhH7KJaL59Xeno2/JrFnb+xQIEs+7Ox?=
 =?us-ascii?Q?upe8zqClPlqH/0bSoHE2PfL8MjyapvIMOrzwmZwsGlb8UzBSxhwd6hgKJ1C1?=
 =?us-ascii?Q?aD+v4QvG9Oz/VuuCZi90tt0G0JFpiCE0Yzvg3tngU72JgrZd7lBGPEU75S7K?=
 =?us-ascii?Q?OW5nx5uNeZuuPtT6M5ghqFNygozQOKr8UfwxGZWk0OqFyFnMR8YVqS01p05F?=
 =?us-ascii?Q?8QoN8n4FxxC32UzAEMtcH9IGypmqlWzbH4mAYQsNeHCddasoXInI/3dviPsx?=
 =?us-ascii?Q?H6jqVs1gGLTNhZXTW1pk4fA+3kYm51LE0ds9IZH7c/+qjb0i9SlmEokkey6G?=
 =?us-ascii?Q?rZ4oQbp2ZaoRNYtxzr4mgs9qZfPDOXA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff4b273-e331-46ef-a096-08deccfe3d3e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:55:45.9550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWEkYqFoZqSkrokMszISzvA0LUcymufhyeb1FhhBMejQGIkBuDlEjlCLt7K0rCxFHOeauBEPZO1p0n5TEOOLV+0ax38Z3oLahdUHBD+jXCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10696
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

Signed-off-by: Ye Li <ye.li@nxp.com>
---
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

