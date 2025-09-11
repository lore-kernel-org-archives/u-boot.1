Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BFECA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D3283564;
	Thu, 11 Sep 2025 14:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CByhbstK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 344DD833BF; Thu, 11 Sep 2025 12:56:46 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E642E833D1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLdjL8BA2cHyHIxOx7yY4LKDSldPs87PjZxCsDVte0rjDCJa35p7/3dhOSy1TmuAWkEf/jSfjUFOrpo5pD8GtIIKiO9nQTZ0KX7PJepHB1wyay8NzNs+6y6Q26/0dsh3PfpLv76DxXHYrHMqRj9CHCRd446+Eg9WBSxuqODnz/YvD9fBysAae/xGbPKA670lXGGipXsaVewME9MnH5k/Jvf5F5246yn1B/ObtcNdckYDJKmop/ElRMJS/uKYzl2Cm8VObnXzwTgRHrit5n66WnHGU72+ZI9Tz29c3Mfle2gX6leDkvloMKFJed8OrKbnl9PdN9GDVXj8lhVgWLGHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX+hDS+BoTjsjMTiOfpPWHsw2IMf7f2Te6eRe7xaqyw=;
 b=sn8inIkfZ9nveyydEKc+kltu7twcv2RCEp1tpLMw85Kk1Grb9cZ5cJtuHIKaqtWfqiOOiiF5RiumRLbA0t5DEAZ1t0LbVv5qX3Wul90ReX7h6Y0jiG80b4oZDT6WubCOuRz1EH84qlCfrPw6cu99aCe7lVrHBMXi2rZzw6Dbo1K3Ow+FyGcfQ+zRwIzKo9b7tN32PM78H5A6Mu9/JwSi3AJk9hjE4L0ZvWeZoHOTzqUowXLFp6Zz1+kAb0WbwbMv2AAqExbl0JnP7YukwKlta8rhoH9XlC9r9ZRNl+3QKHMMvV2c602XnoJRsEoLHR3C795Vk0p2qJpWvOKRygIPKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX+hDS+BoTjsjMTiOfpPWHsw2IMf7f2Te6eRe7xaqyw=;
 b=CByhbstKMykiizHoEW5bpaJbza7vN+XJZTCMUII1iKHLujy97dlZtiXt9hWudp9cD4tzga5THsPanGmtx1NbDE2SDG9Vm7CoQyKopCreUBAotwTtCEcED/mrJFty3r1eORuSu3jJ9tiG+cHJ2nrgNXBmc4tj/QemlD1hkA915ceEedjQW0vRXScYsx00MXG7b9UkE9xPcUnWAenNXUf/PWPp0EEWYHtX2bIkPa54Qd2hBYpfXJ22AiG5CtECDPc9n1v00OEyC3YdpzZSlr+on/4CYs8/YEGODMh8ElXKnXW6z+s51o0dX/agXsx38Sd9EeZfSlo8ThF42rCv8rjYFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV4PR04MB11752.eurprd04.prod.outlook.com (2603:10a6:150:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:56:42 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 10:56:42 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com
Subject: [RESEND PATCH 3/8] clk: imx: Add imx95 blkctrl clock driver
Date: Thu, 11 Sep 2025 18:56:06 +0800
Message-Id: <20250911105611.3664965-4-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911105611.3664965-1-ye.li@nxp.com>
References: <20250911105611.3664965-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GV4PR04MB11752:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e74ba1-165c-479b-ab4a-08ddf121e428
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uyqT29hnYyylHITL+bzHb2zSslIKftgrErwo0TLBX3XRDY1t9IAeWAQWRLxv?=
 =?us-ascii?Q?B3LkzBtpqn1PIIfp7Knyjy5FCMMaSWKPd/gNo4ejzAYD+e2w6PwYEDN0ZfHe?=
 =?us-ascii?Q?LVORsCV1QZgx2pV3ChRfDwmpZvtC3xJxID2bQSd92+9kkTZvb6OCRQBMsexk?=
 =?us-ascii?Q?VWAZ8dMkvUSxwF6EdMOacDB7qQD0l2kVvpMSacQHcsmTqMvbDGPXpHA1Jmr3?=
 =?us-ascii?Q?zoMvvxRknJdr1ljbI3+gV4BWCsyAjYrQx5jrD6NbV87E6tsBQV9qH+Ty6bZW?=
 =?us-ascii?Q?G6siyCczT4ND7dpKwM2RUE4epJdGBSTkmxt7qfVZnDgqUs3brRh24yi9vLVt?=
 =?us-ascii?Q?1nwj0J9fWX1Nd8ADxlvRPllczTdQ+nEibQdPFlUt7oMNE+jyj63LRbZ5+Gmn?=
 =?us-ascii?Q?J+cQiWkpTlzKgNWIvenr1L3KxNVa9Wz2anaGz/VCvBtrCoJH8ayO4flitC97?=
 =?us-ascii?Q?nF8CgRA326FOv/3Op88+v6N401GH5MFn6Yb/mo9g1ir6eo9sKfYdyrWF9tFy?=
 =?us-ascii?Q?F8MP1OLuYGs5jRbZXiz2rJL5RxdYagFFRjSzZQYHh8lxfa5AcaOVxh4/0wXh?=
 =?us-ascii?Q?CXOmux8sIqJzpj7nbp6eQ30lKNhrDkWXjE71VpvGM2vuELEJ6FjS64xdreLa?=
 =?us-ascii?Q?ZltZcmPWrHs/e/h9+H13t1qs5u4tDCgRCPbDX++hXKjadmIMUWaDGypvTJgS?=
 =?us-ascii?Q?Z09nPnlJpOrMUco3hidzpSP+54l3UMIabOX0I6UwR6YJGFz6hC18rvTPfScu?=
 =?us-ascii?Q?9f0WndxLIKQ7gf1BqJjd5WltqfJZo16qqIcC2FE3TCVY0Qsxh8d6CRsbz2RA?=
 =?us-ascii?Q?56n0khKwqK0EaTz/vq8C1OTATlM0EMWn8JbXdDtMYjjYx4q/hHeHRw+LXZmJ?=
 =?us-ascii?Q?hQIdzbEK/ld4XE5DcWTrFdq9ozuWtLPdVwLr3BZIFdaTEnFrQ2aeXcEGJoIY?=
 =?us-ascii?Q?6QcqAGUZKiQf1z/6/uzaYeEyinrYaKIId4iiiTSnM/nYd/ZZiF1dYEZ3uwXA?=
 =?us-ascii?Q?59bZYGOJkkkSUjope5gmk3LAqfoTAPFK5z+NtAE47H+o3VXLOxZU+97w7yV2?=
 =?us-ascii?Q?YiuGuCFZpDNBeFZfyHIMN2RHYed0VplCMU2TWOXPZA30KEkABchrc8zeg7bj?=
 =?us-ascii?Q?7zVakQwf6d/u09g0aY1SLLRTeZH56p24tyP9GXFAwiSUju/tsXzvyxC3/p5n?=
 =?us-ascii?Q?lzZ8MV5CNCqPwdtEQBftl/13IDFwuNhBtsGNs8rEo1JF2/Tu5pRdF96JHCAt?=
 =?us-ascii?Q?nN8VBJAShphtkglLo0m8wK/zjoI3Gh7qlBVKTTlILfsWHFT4O1WBJ7YHmKX1?=
 =?us-ascii?Q?rZdq3MT2zihcy5RQHRTZtD7lb5mvpRDhqZMzQUpZBHH0UXAh4jXdFZvCNHSD?=
 =?us-ascii?Q?X8W/2FM9zgWl9HcChs/rvMq9gB0X8Q+hgtXnl01WCTe6/IVSk7eRSa1JG7HR?=
 =?us-ascii?Q?zr8kdlppVTRy9GIHrrScFwKHRnjX4xaWWauqr7cmiULiwSnih5beMpmTKEEh?=
 =?us-ascii?Q?L+0U0lWl5Hk3xkY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBi3u2dp9zwVSDbYEFt/Wwg1LudbXV96ZDSblArc/QQ+sRCgQlSF/TFNY0sk?=
 =?us-ascii?Q?JBTrUVZThDa40lbeRHcQJO9P8c7/4W2QdCkfzBtEuzmdhhC48RDPwBmTuXyn?=
 =?us-ascii?Q?JbKYnchRZCBBjalMLNRGTQ5sVgnJrPBWL8P7ic6Gb1f6BO09FRM8gwL7gINd?=
 =?us-ascii?Q?BfIFmiblJi2OOfWqJdzVdhlzXrS+FkqRxrtc4uPlpqA991+EALIKV580AHx5?=
 =?us-ascii?Q?EzCOudkzGHCiYK8dUXL4zuI9a0TZmAfpLqHck2J3aGW9QiW0ZTZQtB2lff5/?=
 =?us-ascii?Q?d7E5/NrcWJ0CdV+jynN2kf1yYZlkxUDberFAOyiewYMcCNPCv7fTxmTa31hQ?=
 =?us-ascii?Q?5bdDemVtGptUBvSGbKCzOOqF+oCXiThBCWGLyvsRQZpeD4XvyD1ZyJHLoMCx?=
 =?us-ascii?Q?IaYZyHzUAglgfd6U3eyqCq3WTNHZYjB7SPzH9fnkHpSK+GJTanZmkhPUDBvI?=
 =?us-ascii?Q?EbOze787HL2H/4SpN7JZWPWorAVZaEOt9b90Xz9UgdPE+ZhOY+9khV9ws7b1?=
 =?us-ascii?Q?B8KUXGLq7C8eTuHM3lxsxeXtbiC+tDh5YfWIdSEGHbsToNvsKe16AbsMZXaa?=
 =?us-ascii?Q?s6vgCzHXBrig5OAg0OBJGDEe2WttgkJx2TYbxaG1llR1Ch2H9GV1J/hbO0Qp?=
 =?us-ascii?Q?+B5C3CfyVj38ZOZYyl+b/yvebCYc8IBPpHJaj1czLEKd6PVKygEhkAHBrZAJ?=
 =?us-ascii?Q?lfK+2tK/LFx5cQN8MzML9wDg20LWBWIf2qHcvfVN6/lmY4if5AGr44VAwp4+?=
 =?us-ascii?Q?SQjbgQu6C/76xg3kTjj/NQHrxjBfsbSjj3vO9Z+dCKXUAi/G7tfUelX3tJzK?=
 =?us-ascii?Q?BpkYgHUtnnNmQQ4cN8xTPdHWIyeOUc2YL6yWG6ecm+1/yAai+oOKQ9OMdL8M?=
 =?us-ascii?Q?cNoUnJjqPTLKD3VC5mAucaS2s5vou4I7WXBOcl6eqhqc0PtLv2Vbcrcn3PJ9?=
 =?us-ascii?Q?vzzIaB98iXJoTeg/owdMEYJVniGG1qrk4yz/HMEDcTmqLtscqgDZuwnypXGv?=
 =?us-ascii?Q?3GJTewFUANHPp7vzVhFi67EWvo2IWP0InhcnlRSfsDKeni1/XLSYCopec/+x?=
 =?us-ascii?Q?p/wCHdKKvPjZbXkbkUwbYaWCqrcmfQBuG9ErpuIEv/rJz+7qlr28MNKHDzLi?=
 =?us-ascii?Q?Jq9wpL8Kqt19BNXKt0wuomngMFESdj+o4Gp6RhuZlIWoejICpI/ZC+DSuoqw?=
 =?us-ascii?Q?E0E7LtPNokQwnHIJ8m1EUCjDhpaPUph506GhB8chGvQ368KGlPRgadu7qC+G?=
 =?us-ascii?Q?Dw8+SOuXJxrL8kTB7TwehByOZpvDuxlpVvMYXwf8URpaeFIrz2HEDsJiiCyB?=
 =?us-ascii?Q?UqFbHm7/dfdklYuRE4Zj1TzproXYCJ48aS/z0I2+LMoVbKMof94nC5kZ8GXX?=
 =?us-ascii?Q?jXTC4617V5QO501JcrekQHjuaZvGlBkyI2gkReZZN1zKd3wJO17oDnZb2k55?=
 =?us-ascii?Q?av/XbPYrU5WH7osmw6xHBVDDWvg9zcx4NrPn4+0XeZZjH8XdgbeYSw6q0ZaT?=
 =?us-ascii?Q?5/x1N5yoSjFS5hdDxjdQ/X/FS0TFufVcq59fpZoFs5IHcuW2tEiKvj6XEDwe?=
 =?us-ascii?Q?zyBTcomjN35qu6peEq0FwDACdEH1WK1mvll2b/sH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e74ba1-165c-479b-ab4a-08ddf121e428
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:56:42.3113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3W1zDBKv8AVj6vTKKfOxqmsvYHu2cWMlMQKWA9hYuVIYm6X/z+KNkuIK90ZrAIp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11752
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
 drivers/clk/imx/clk-imx95-blkctrl.c | 170 ++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx95-blkctrl.c

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 74d5fe73f94..644ab162af4 100644
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
index b10221a195c..f2fd6ff8ca0 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_$(PHASE_)CLK_IMX93) += clk-imx93.o clk-fracn-gppll.o \
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1020) += clk-imxrt1020.o
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1050) += clk-imxrt1050.o
 obj-$(CONFIG_$(PHASE_)CLK_IMXRT1170) += clk-imxrt1170.o
+obj-$(CONFIG_CLK_IMX95_BLKCTRL) += clk-imx95-blkctrl.o
diff --git a/drivers/clk/imx/clk-imx95-blkctrl.c b/drivers/clk/imx/clk-imx95-blkctrl.c
new file mode 100644
index 00000000000..3bf6f9415e2
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
2.37.1

