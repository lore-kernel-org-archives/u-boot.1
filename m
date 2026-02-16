Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D4EE7BD88
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6984983AA9;
	Mon, 16 Feb 2026 11:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xK9gjXC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5357983B8A; Mon, 16 Feb 2026 11:27:48 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EBA68063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9V5mZPjbPd8XpSQ50rp/4pZQlm6Oxe78PvW4F8IRbOfsosgGUpD6sa3nPq8mPCk0KOdWm5wd+5OD/JV2k/oMhQYFWjrzle4nrBg0+/7zWg+4gNdNLehyALSlaEaBZQ1wONzav++v/xRxEBRVWO493+73iy6N/F5KgnsSi92/hJHFZ3RXgPzW3XM1fdw/vH2bH3jLrehRXQM4w8fzy5z3lbWv1BCUHjdSAVY4/f1Zk5AMyZNFjpC3sMGV9MIXtJMPuR0em3r/TmryUO9a6tdKCZCz/OulRfZai8ag36JOVJx1xfKmuCAnDtwrTJS1QFMkvftjtwB96ZQw6FifdVwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlEbb8nHiuhkAj4n3eCHjhbqMjPYntdW/3GMGlntUaI=;
 b=Om6F8PdrIQrORaTf8J3GguzNC04JglAA8ZPx5i07egUyIsudFKqM6HaiKTmOo0uLuPvHJ0wnKL7OeOf8v0ThxtLdw3+8GubToc5+IwMod5nT+s8nN5vQ6t9dXDatGrrLNPpv1/DJZav5KMP/j1h0lR0VO43HSAAqYI+RlERnJ7WtOErAaVRJzIVJAT2uMgDzOzHZetH1jwmYbcxq6/jloy4k41herCs4rtVYZ13/CN7TT36sGDijucqVp7UIq5Zm4zs43MBMX4b+x8VToa+qa0sIGLaf7sMkCrMpfLisghoGy5IY7iNUtCxabcxxeKUz+vRf8ATKDuDC90uROxsDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlEbb8nHiuhkAj4n3eCHjhbqMjPYntdW/3GMGlntUaI=;
 b=xK9gjXC1QnvaXBWBFfDvr9jEvdLG1KjdeaP2HZ6Oz1M+u2KW/4gyYgETwXTuZszVRDvtEOFnYHdWqh/qYOn+b7qSFYOZ7Z44MVhKYx2cHbgmREYv0uSAdq/XIs4ueWiEmUsgk1Fc1EdGvBLLSPwSnrVTJxx7VLJ45KV5iYUa9ew=
Received: from SA1PR05CA0019.namprd05.prod.outlook.com (2603:10b6:806:2d2::26)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:27:42 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::54) by SA1PR05CA0019.outlook.office365.com
 (2603:10b6:806:2d2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 10:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:27:40 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:40 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:27:40 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHa1147835;
 Mon, 16 Feb 2026 04:27:35 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 01/10] arm: mach-k3: j784s4: Update SoC autogen data to
 enable PCIe boot
Date: Mon, 16 Feb 2026 15:58:29 +0530
Message-ID: <20260216102858.2745657-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SA2PR10MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: 779094db-c0b6-4496-d2ef-08de6d4603a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ADUvfXLO0k5h1kiHACNiNZB92MhiHwMw6wJVwJJ9wASAD6df2o8r9LBj3C2?=
 =?us-ascii?Q?k0wuQiqz7n3BG4sIL3pMXRc6nw1hjCEmN72neIMomTn+oQrBnAH2R2KMHiLd?=
 =?us-ascii?Q?iCo0razl9V7ejtqGwjnMNkq+NbyaLT4XB5i5QI0uMTocIl1lw8RcEfpi8yhd?=
 =?us-ascii?Q?FVVjcJM3yfBtJsFZqnyvIt28h0JXHTfjFOX4IG/1J/bKFdOufKBMMKhnGhOP?=
 =?us-ascii?Q?O2BcwdFb3JWxJjclIzOWDw51AlJGm33YwrvMqFj/3L1dkm0v4LMflaO3ADY9?=
 =?us-ascii?Q?bP5kpV4TESN2IeE/AToHMWbgHZ+InDWtoDtOWw8qWK4XxbCLauM0yqGvrZ2U?=
 =?us-ascii?Q?Tz6iye/W0vvzytDQhrJBjdGcM2oK6442iTcJyOe3XEp7RRy+QN9UiRMJPdiv?=
 =?us-ascii?Q?CjODzBuslLaHGJbmGMUKcZVSitOv5e9Dtcftv45I8bk8ys4Z+3p4oVAGd/kU?=
 =?us-ascii?Q?5c5TSHlwdFbmIE6S+M/De9Pd8Kf4wKsk2YTAq5a9Zv96opSNxfryF2c4GvG+?=
 =?us-ascii?Q?VSps1XAdLQ6JC+2H3um1eadHzrEWQERDMOi7COaQMGDvZdyRPb0QfMnbbMgq?=
 =?us-ascii?Q?qL7it6UH4XNuUAmCxGo86m+b+9f0vSME+KiuCLVIkkfMblmAoYTrLCqhUo3l?=
 =?us-ascii?Q?Tzbq85I+47NVMNPNh0Vd9FtXm3HQilVsXuGpmmp6Qzr8F82KJ5asQxBTnaV4?=
 =?us-ascii?Q?lE7IJv/cJs2Dx2NupMo9cERdDz5U+kE22rrxSgKNIGqsrmJuN9LrsWjpldBG?=
 =?us-ascii?Q?xthXPXaUIfOnQfo0toWVT2lNae2Fnr0jXnFYj82H8OvELrWbnQ6wl7nEUxS9?=
 =?us-ascii?Q?6PBzPNdkiLT8C0ZyfFrxmjuS0OToqwXf5hmK1YWz+YsgB1+M6OmoQdgqD6ED?=
 =?us-ascii?Q?SU33feLi/R4gahOqyRyfzprn3cb5zdLf5g44x5cCI7tZPU2cLQvzYrrwV1vH?=
 =?us-ascii?Q?d/u0G7RToUOkZPcGMKNw3ODi34JER2tSQQduIpYFqxrYeOBQMwQH90Rm8gzj?=
 =?us-ascii?Q?Kaq3UWx8kaWuN7U38R9pzFaJ5mUgi3whtU6qlaOeR4mRWImSMwA603Y3P8m6?=
 =?us-ascii?Q?XjF0Ft8A6RHKX33Owf7RxyZRM5MoDh0iLnClTXpF87ElG4WN6wDnYnWeoMC7?=
 =?us-ascii?Q?U/rjdEBfhWspl2h7BDszQM4QF0p0shnAuwFTu03UCz1FPIvcdjbhJmCaV27c?=
 =?us-ascii?Q?KiXD8fp4Lrq0kQqcZY8elfMj/rdbGjWU11h26Sxl0nEeawYHrwZtgHW+ycua?=
 =?us-ascii?Q?m2N7ZEDFOJQlCSZbm6dSHzh95B2/RCEdZsNVFBjklAh5iu5vLkS95+N+6umE?=
 =?us-ascii?Q?+pkm3sAZ+e4Wz1FIc9hzFbr2OhNfhe91mm0b9Ha87L0vg7f17psadCbwL6Y6?=
 =?us-ascii?Q?3OVHQDfqDc+4BmgOAYJ5WaR/Z2AEogFC8A2MooRp70ZFN3yAOuWJyhlx8wn3?=
 =?us-ascii?Q?c7CxiDVKFXg5NEhDqUcm2JXmfGeYFo5QEciLK86pgCG1bBvzbqiWSps0eWZr?=
 =?us-ascii?Q?ZxVQ8wvWJSSmKWwiAPSgd5rbrdtmx4+uW4KpWh0yLMnrGZHxKQTJ+wYMjvDn?=
 =?us-ascii?Q?yB+xAKd2mwsWYLcbsQ28NpFgYPVL1JW2nURbh4D37mW6llwb1aOo77piibMS?=
 =?us-ascii?Q?JqV6VECcvSpFO9aC+x77HEg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tv29cv0SZ4iccXWI/uAFwF8Nfiu1IQ71aEcAYpRB8+1hGsxJPcrrJzfAHDIJIvcr4BqCGfw/WKda9y0/G2SamEB1iGX9XLEQ0+h/0eMblRgwNairdP0pBw47KIzEMN5iGTcVgZNb307eR3pY8mN5css7DwQy2aNgoEhYwpFHbxI3rNM7FDrEF8m9UJquzesHhBtNTRbJcPoHHMGltecGjYUYcInnu4zXleMhqeIqmCovriyGJrds45I2tIwgdhZpZf8DodSiCGVOqjxU2xstHi+sf2WhBUsEQhjutvnXJW3hl2SSHyWWxt+ylobBGdjKRMd5+offqYP43+7MqY1ePs57i2B9qLXju0eOi9DMzxIj0S0SXpEqAgC2d6yX0cp8aMKHh0nP48n8IimhCtl5eNPOlj5L/Ek3Sq8CVj4oBua9fA+otxou12atdKGdbpK/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:27:40.8625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779094db-c0b6-4496-d2ef-08de6d4603a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570
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

From: Hrushikesh Salunke <h-salunke@ti.com>

To enable PCIe boot on J784S4 SoC SERDES0 and PCIE1 should be enabled
and configured at the R5 stage. Add the required clk-data and dev-data
for SERDES0 and PCIE1.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm/mach-k3/r5/j784s4/clk-data.c | 184 ++++++++++++++++++++++++--
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  45 ++++---
 2 files changed, 201 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
index 24780eb6562..228b424d3f2 100644
--- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
@@ -5,7 +5,7 @@
  * This file is auto generated. Please do not hand edit and report any issues
  * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -64,13 +64,13 @@ static const char * const cpsw2g_cpts_rclk_sel_out0_parents[] = {
 	"board_0_cpts0_rft_clk_out",
 	"board_0_mcu_ext_refclk0_out",
 	"board_0_ext_refclk1_out",
+	"wiz16b8m4ct3_main_0_ip2_ln0_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln1_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln2_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln3_txmclk",
 	NULL,
 	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
+	"wiz16b8m4ct3_main_0_ip1_ln2_txmclk",
 	NULL,
 	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
 	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
@@ -166,6 +166,31 @@ static const char * const emmcsd1_lb_clksel_out0_parents[] = {
 	"board_0_mmc1_clk_out",
 };
 
+static const char * const usb0_serdes_refclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_refclk",
+	NULL,
+};
+
+static const char * const usb0_serdes_rxclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_rxclk",
+	NULL,
+};
+
+static const char * const usb0_serdes_rxfclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_rxfclk",
+	NULL,
+};
+
+static const char * const usb0_serdes_txfclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_txfclk",
+	NULL,
+};
+
+static const char * const usb0_serdes_txmclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_txmclk",
+	NULL,
+};
+
 static const char * const k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents[] = {
 	"main_pll_hfosc_sel_out0",
 	"hsdiv4_16fft_main_0_hsdivout0_clk",
@@ -197,18 +222,44 @@ static const char * const gtc_clk_mux_out0_parents[] = {
 	"board_0_cpts0_rft_clk_out",
 	"board_0_mcu_ext_refclk0_out",
 	"board_0_ext_refclk1_out",
+	"wiz16b8m4ct3_main_0_ip2_ln0_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln1_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln2_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln3_txmclk",
 	NULL,
 	NULL,
+	"wiz16b8m4ct3_main_0_ip1_ln2_txmclk",
 	NULL,
+	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
+	"k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk",
+};
+
+static const char * const pcien_cpts_rclk_mux_out1_parents[] = {
+	"hsdiv4_16fft_main_3_hsdivout1_clk",
+	"postdiv3_16fft_main_0_hsdivout6_clk",
+	"board_0_mcu_cpts0_rft_clk_out",
+	"board_0_cpts0_rft_clk_out",
+	"board_0_mcu_ext_refclk0_out",
+	"board_0_ext_refclk1_out",
+	"wiz16b8m4ct3_main_0_ip2_ln0_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln1_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln2_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln3_txmclk",
 	NULL,
 	NULL,
-	NULL,
-	NULL,
+	"wiz16b8m4ct3_main_0_ip1_ln2_txmclk",
 	NULL,
 	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
 	"k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk",
 };
 
+static const char * const serdes0_core_refclk_out0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+	"hsdiv4_16fft_main_3_hsdivout4_clk",
+	"hsdiv4_16fft_main_2_hsdivout4_clk",
+};
+
 static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("osc_27_mhz", 27000000, 0),
 	CLK_FIXED_RATE("osc_26_mhz", 26000000, 0),
@@ -270,11 +321,17 @@ static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("board_0_mcu_ext_refclk0_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mmc1_clklb_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mmc1_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_serdes0_refclk_n_out", 0, 0),
+	CLK_FIXED_RATE("board_0_serdes0_refclk_p_out", 0, 0),
 	CLK_FIXED_RATE("board_0_tck_out", 0, 0),
 	CLK_FIXED_RATE("board_0_vout0_extpclkin_out", 0, 0),
 	CLK_FIXED_RATE("emmcsd4ss_main_0_emmcsdss_io_clk_o", 0, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_2_hsdivout0_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02080, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_2_hsdivout1_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02084, 0, 7, 0, 0),
+	CLK_FIXED_RATE("pcie_g3x4_128_main_1_pcie_lane0_txclk", 0, 0),
+	CLK_FIXED_RATE("pcie_g3x4_128_main_1_pcie_lane1_txclk", 0, 0),
+	CLK_FIXED_RATE("pcie_g3x4_128_main_1_pcie_lane2_txclk", 0, 0),
+	CLK_FIXED_RATE("pcie_g3x4_128_main_1_pcie_lane3_txclk", 0, 0),
 	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_main_0_foutvcop_clk", "main_pll_hfosc_sel_out0", 0x680000, 0, 2000000000),
 	CLK_DIV("pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk_subdiv", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680038, 16, 3, 0, CLK_DIVIDER_ONE_BASED),
 	CLK_DIV("pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk_subdiv", 0x680038, 24, 3, 0, CLK_DIVIDER_ONE_BASED),
@@ -294,8 +351,42 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV("postdiv3_16fft_main_0_hsdivout8_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", 0x6800a0, 0, 7, 0, 0),
 	CLK_DIV("postdiv3_16fft_main_1_hsdivout5_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", 0x681094, 0, 7, 0, 0),
 	CLK_DIV("postdiv3_16fft_main_1_hsdivout7_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", 0x68109c, 0, 7, 0, 0),
+	CLK_FIXED_RATE("usb3p0ss_16ffc_main_0_pipe_txclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_cmn_refclk_m", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_cmn_refclk_p", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip1_ln2_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_txmclk", 0, 0),
 	CLK_MUX("emmcsd1_lb_clksel_out0", emmcsd1_lb_clksel_out0_parents, 2, 0x1080b4, 16, 1, 0),
 	CLK_MUX("mcu_clkout_mux_out0", mcu_clkout_mux_out0_parents, 2, 0x40f08010, 0, 1, 0),
+	CLK_MUX("usb0_serdes_refclk_mux_out0", usb0_serdes_refclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
+	CLK_MUX("usb0_serdes_rxclk_mux_out0", usb0_serdes_rxclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
+	CLK_MUX("usb0_serdes_rxfclk_mux_out0", usb0_serdes_rxfclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
+	CLK_MUX("usb0_serdes_txfclk_mux_out0", usb0_serdes_txfclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
+	CLK_MUX("usb0_serdes_txmclk_mux_out0", usb0_serdes_txmclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
 	CLK_DIV("hsdiv0_16fft_main_12_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_12_foutvcop_clk", 0x68c080, 0, 7, 0, 0),
 	CLK_DIV("hsdiv0_16fft_main_26_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_26_foutvcop_clk", 0x69a080, 0, 7, 0, 0),
 	CLK_DIV("hsdiv0_16fft_main_27_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_27_foutvcop_clk", 0x69b080, 0, 7, 0, 0),
@@ -310,14 +401,18 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV_DEFFREQ("hsdiv4_16fft_main_1_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681080, 0, 7, 0, 0, 192000000),
 	CLK_DIV("hsdiv4_16fft_main_1_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681088, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_2_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_2_hsdivout4_clk", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682090, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_3_hsdivout1_clk", "pllfracf2_ssmod_16fft_main_3_foutvcop_clk", 0x683084, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_3_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_3_foutvcop_clk", 0x683088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_3_hsdivout4_clk", "pllfracf2_ssmod_16fft_main_3_foutvcop_clk", 0x683090, 0, 7, 0, 0),
 	CLK_MUX_PLLCTRL("k3_pll_ctrl_wrap_main_0_sysclkout_clk", k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents, 2, 0x410000, 0),
 	CLK_DIV("k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk", "k3_pll_ctrl_wrap_main_0_sysclkout_clk", 0x410118, 0, 5, 0, 0),
 	CLK_MUX("dpi0_ext_clksel_out0", dpi0_ext_clksel_out0_parents, 2, 0x108300, 0, 1, 0),
 	CLK_MUX("emmcsd_refclk_sel_out0", emmcsd_refclk_sel_out0_parents, 4, 0x1080b0, 0, 2, 0),
 	CLK_MUX("emmcsd_refclk_sel_out1", emmcsd_refclk_sel_out1_parents, 4, 0x1080b4, 0, 2, 0),
 	CLK_MUX("gtc_clk_mux_out0", gtc_clk_mux_out0_parents, 16, 0x108030, 0, 4, 0),
+	CLK_MUX("pcien_cpts_rclk_mux_out1", pcien_cpts_rclk_mux_out1_parents, 16, 0x108084, 0, 4, 0),
+	CLK_MUX("serdes0_core_refclk_out0", serdes0_core_refclk_out0_parents, 4, 0x108400, 0, 2, 0),
 	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081c0, 0, 2, 0, 0, 48000000),
 	CLK_DIV("usart_programmable_clock_divider_out5", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081d4, 0, 2, 0, 0),
 	CLK_DIV("usart_programmable_clock_divider_out8", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081e0, 0, 2, 0, 0),
@@ -338,6 +433,11 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(61, 4, "board_0_cpts0_rft_clk_out"),
 	DEV_CLK(61, 5, "board_0_mcu_ext_refclk0_out"),
 	DEV_CLK(61, 6, "board_0_ext_refclk1_out"),
+	DEV_CLK(61, 7, "wiz16b8m4ct3_main_0_ip2_ln0_txmclk"),
+	DEV_CLK(61, 8, "wiz16b8m4ct3_main_0_ip2_ln1_txmclk"),
+	DEV_CLK(61, 9, "wiz16b8m4ct3_main_0_ip2_ln2_txmclk"),
+	DEV_CLK(61, 10, "wiz16b8m4ct3_main_0_ip2_ln3_txmclk"),
+	DEV_CLK(61, 13, "wiz16b8m4ct3_main_0_ip1_ln2_txmclk"),
 	DEV_CLK(61, 15, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
 	DEV_CLK(61, 16, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(61, 17, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
@@ -349,6 +449,11 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(63, 7, "board_0_cpts0_rft_clk_out"),
 	DEV_CLK(63, 8, "board_0_mcu_ext_refclk0_out"),
 	DEV_CLK(63, 9, "board_0_ext_refclk1_out"),
+	DEV_CLK(63, 10, "wiz16b8m4ct3_main_0_ip2_ln0_txmclk"),
+	DEV_CLK(63, 11, "wiz16b8m4ct3_main_0_ip2_ln1_txmclk"),
+	DEV_CLK(63, 12, "wiz16b8m4ct3_main_0_ip2_ln2_txmclk"),
+	DEV_CLK(63, 13, "wiz16b8m4ct3_main_0_ip2_ln3_txmclk"),
+	DEV_CLK(63, 16, "wiz16b8m4ct3_main_0_ip1_ln2_txmclk"),
 	DEV_CLK(63, 18, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
 	DEV_CLK(63, 19, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
 	DEV_CLK(63, 20, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
@@ -404,6 +509,8 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 239, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 243, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 245, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
+	DEV_CLK(157, 324, "wiz16b8m4ct3_main_0_cmn_refclk_m"),
+	DEV_CLK(157, 326, "wiz16b8m4ct3_main_0_cmn_refclk_p"),
 	DEV_CLK(157, 354, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 359, "dpi0_ext_clksel_out0"),
 	DEV_CLK(157, 360, "mshsi2c_wkup_0_porscl"),
@@ -461,6 +568,42 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(279, 2, "wkup_i2c_mcupll_bypass_out0"),
 	DEV_CLK(279, 3, "hsdiv4_16fft_mcu_1_hsdivout3_clk"),
 	DEV_CLK(279, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(333, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(333, 2, "pcien_cpts_rclk_mux_out1"),
+	DEV_CLK(333, 3, "hsdiv4_16fft_main_3_hsdivout1_clk"),
+	DEV_CLK(333, 4, "postdiv3_16fft_main_0_hsdivout6_clk"),
+	DEV_CLK(333, 5, "board_0_mcu_cpts0_rft_clk_out"),
+	DEV_CLK(333, 6, "board_0_cpts0_rft_clk_out"),
+	DEV_CLK(333, 7, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(333, 8, "board_0_ext_refclk1_out"),
+	DEV_CLK(333, 9, "wiz16b8m4ct3_main_0_ip2_ln0_txmclk"),
+	DEV_CLK(333, 10, "wiz16b8m4ct3_main_0_ip2_ln1_txmclk"),
+	DEV_CLK(333, 11, "wiz16b8m4ct3_main_0_ip2_ln2_txmclk"),
+	DEV_CLK(333, 12, "wiz16b8m4ct3_main_0_ip2_ln3_txmclk"),
+	DEV_CLK(333, 15, "wiz16b8m4ct3_main_0_ip1_ln2_txmclk"),
+	DEV_CLK(333, 17, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
+	DEV_CLK(333, 18, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(333, 19, "wiz16b8m4ct3_main_0_ip2_ln0_refclk"),
+	DEV_CLK(333, 20, "wiz16b8m4ct3_main_0_ip2_ln0_rxclk"),
+	DEV_CLK(333, 21, "wiz16b8m4ct3_main_0_ip2_ln0_rxfclk"),
+	DEV_CLK(333, 23, "wiz16b8m4ct3_main_0_ip2_ln0_txfclk"),
+	DEV_CLK(333, 24, "wiz16b8m4ct3_main_0_ip2_ln0_txmclk"),
+	DEV_CLK(333, 25, "wiz16b8m4ct3_main_0_ip2_ln1_refclk"),
+	DEV_CLK(333, 26, "wiz16b8m4ct3_main_0_ip2_ln1_rxclk"),
+	DEV_CLK(333, 27, "wiz16b8m4ct3_main_0_ip2_ln1_rxfclk"),
+	DEV_CLK(333, 29, "wiz16b8m4ct3_main_0_ip2_ln1_txfclk"),
+	DEV_CLK(333, 30, "wiz16b8m4ct3_main_0_ip2_ln1_txmclk"),
+	DEV_CLK(333, 31, "wiz16b8m4ct3_main_0_ip2_ln2_refclk"),
+	DEV_CLK(333, 32, "wiz16b8m4ct3_main_0_ip2_ln2_rxclk"),
+	DEV_CLK(333, 33, "wiz16b8m4ct3_main_0_ip2_ln2_rxfclk"),
+	DEV_CLK(333, 35, "wiz16b8m4ct3_main_0_ip2_ln2_txfclk"),
+	DEV_CLK(333, 36, "wiz16b8m4ct3_main_0_ip2_ln2_txmclk"),
+	DEV_CLK(333, 37, "wiz16b8m4ct3_main_0_ip2_ln3_refclk"),
+	DEV_CLK(333, 38, "wiz16b8m4ct3_main_0_ip2_ln3_rxclk"),
+	DEV_CLK(333, 39, "wiz16b8m4ct3_main_0_ip2_ln3_rxfclk"),
+	DEV_CLK(333, 41, "wiz16b8m4ct3_main_0_ip2_ln3_txfclk"),
+	DEV_CLK(333, 42, "wiz16b8m4ct3_main_0_ip2_ln3_txmclk"),
+	DEV_CLK(333, 43, "j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk"),
 	DEV_CLK(392, 0, "usart_programmable_clock_divider_out5"),
 	DEV_CLK(392, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(395, 0, "usart_programmable_clock_divider_out8"),
@@ -473,11 +616,36 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(398, 1, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(398, 2, "postdiv3_16fft_main_1_hsdivout7_clk"),
 	DEV_CLK(398, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(398, 4, "usb0_serdes_refclk_mux_out0"),
+	DEV_CLK(398, 5, "wiz16b8m4ct3_main_0_ip3_ln3_refclk"),
+	DEV_CLK(398, 7, "usb0_serdes_rxclk_mux_out0"),
+	DEV_CLK(398, 8, "wiz16b8m4ct3_main_0_ip3_ln3_rxclk"),
+	DEV_CLK(398, 10, "usb0_serdes_rxfclk_mux_out0"),
+	DEV_CLK(398, 11, "wiz16b8m4ct3_main_0_ip3_ln3_rxfclk"),
+	DEV_CLK(398, 14, "usb0_serdes_txfclk_mux_out0"),
+	DEV_CLK(398, 15, "wiz16b8m4ct3_main_0_ip3_ln3_txfclk"),
+	DEV_CLK(398, 17, "usb0_serdes_txmclk_mux_out0"),
+	DEV_CLK(398, 18, "wiz16b8m4ct3_main_0_ip3_ln3_txmclk"),
 	DEV_CLK(398, 20, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(398, 21, "usb0_refclk_sel_out0"),
 	DEV_CLK(398, 22, "gluelogic_hfosc0_clkout"),
 	DEV_CLK(398, 23, "board_0_hfosc1_clk_out"),
 	DEV_CLK(398, 28, "board_0_tck_out"),
+	DEV_CLK(404, 2, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(404, 3, "board_0_serdes0_refclk_n_out"),
+	DEV_CLK(404, 4, "board_0_serdes0_refclk_p_out"),
+	DEV_CLK(404, 5, "hsdiv4_16fft_main_3_hsdivout4_clk"),
+	DEV_CLK(404, 6, "serdes0_core_refclk_out0"),
+	DEV_CLK(404, 7, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(404, 8, "board_0_hfosc1_clk_out"),
+	DEV_CLK(404, 9, "hsdiv4_16fft_main_3_hsdivout4_clk"),
+	DEV_CLK(404, 10, "hsdiv4_16fft_main_2_hsdivout4_clk"),
+	DEV_CLK(404, 39, "pcie_g3x4_128_main_1_pcie_lane0_txclk"),
+	DEV_CLK(404, 45, "pcie_g3x4_128_main_1_pcie_lane1_txclk"),
+	DEV_CLK(404, 51, "pcie_g3x4_128_main_1_pcie_lane2_txclk"),
+	DEV_CLK(404, 57, "pcie_g3x4_128_main_1_pcie_lane3_txclk"),
+	DEV_CLK(404, 81, "usb3p0ss_16ffc_main_0_pipe_txclk"),
+	DEV_CLK(404, 129, "board_0_tck_out"),
 };
 
 const struct ti_k3_clk_platdata j784s4_clk_platdata = {
diff --git a/arch/arm/mach-k3/r5/j784s4/dev-data.c b/arch/arm/mach-k3/r5/j784s4/dev-data.c
index 19901821225..2bb1a88ab3b 100644
--- a/arch/arm/mach-k3/r5/j784s4/dev-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/dev-data.c
@@ -5,7 +5,7 @@
  * This file is auto generated. Please do not hand edit and report any issues
  * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-dev.h"
@@ -21,10 +21,11 @@ static struct ti_pd soc_pd_list[] = {
 	[1] = PSC_PD(3, &soc_psc_list[1], NULL),
 	[2] = PSC_PD(0, &soc_psc_list[2], NULL),
 	[3] = PSC_PD(1, &soc_psc_list[2], &soc_pd_list[2]),
-	[4] = PSC_PD(14, &soc_psc_list[2], NULL),
-	[5] = PSC_PD(15, &soc_psc_list[2], &soc_pd_list[4]),
-	[6] = PSC_PD(16, &soc_psc_list[2], &soc_pd_list[4]),
-	[7] = PSC_PD(38, &soc_psc_list[2], NULL),
+	[4] = PSC_PD(5, &soc_psc_list[2], NULL),
+	[5] = PSC_PD(14, &soc_psc_list[2], NULL),
+	[6] = PSC_PD(15, &soc_psc_list[2], &soc_pd_list[5]),
+	[7] = PSC_PD(16, &soc_psc_list[2], &soc_pd_list[5]),
+	[8] = PSC_PD(38, &soc_psc_list[2], NULL),
 };
 
 static struct ti_lpsc soc_lpsc_list[] = {
@@ -44,13 +45,15 @@ static struct ti_lpsc soc_lpsc_list[] = {
 	[13] = PSC_LPSC(20, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
 	[14] = PSC_LPSC(23, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
 	[15] = PSC_LPSC(25, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
-	[16] = PSC_LPSC(43, &soc_psc_list[2], &soc_pd_list[3], NULL),
-	[17] = PSC_LPSC(45, &soc_psc_list[2], &soc_pd_list[3], NULL),
-	[18] = PSC_LPSC(78, &soc_psc_list[2], &soc_pd_list[4], NULL),
-	[19] = PSC_LPSC(80, &soc_psc_list[2], &soc_pd_list[5], &soc_lpsc_list[18]),
-	[20] = PSC_LPSC(81, &soc_psc_list[2], &soc_pd_list[6], &soc_lpsc_list[18]),
-	[21] = PSC_LPSC(120, &soc_psc_list[2], &soc_pd_list[7], &soc_lpsc_list[22]),
-	[22] = PSC_LPSC(121, &soc_psc_list[2], &soc_pd_list[7], NULL),
+	[16] = PSC_LPSC(29, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
+	[17] = PSC_LPSC(43, &soc_psc_list[2], &soc_pd_list[3], NULL),
+	[18] = PSC_LPSC(45, &soc_psc_list[2], &soc_pd_list[3], NULL),
+	[19] = PSC_LPSC(64, &soc_psc_list[2], &soc_pd_list[4], NULL),
+	[20] = PSC_LPSC(78, &soc_psc_list[2], &soc_pd_list[5], NULL),
+	[21] = PSC_LPSC(80, &soc_psc_list[2], &soc_pd_list[6], &soc_lpsc_list[20]),
+	[22] = PSC_LPSC(81, &soc_psc_list[2], &soc_pd_list[7], &soc_lpsc_list[20]),
+	[23] = PSC_LPSC(120, &soc_psc_list[2], &soc_pd_list[8], &soc_lpsc_list[24]),
+	[24] = PSC_LPSC(121, &soc_psc_list[2], &soc_pd_list[8], NULL),
 };
 
 static struct ti_dev soc_dev_list[] = {
@@ -78,14 +81,16 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(398, &soc_lpsc_list[13]),
 	PSC_DEV(141, &soc_lpsc_list[14]),
 	PSC_DEV(140, &soc_lpsc_list[15]),
-	PSC_DEV(146, &soc_lpsc_list[16]),
-	PSC_DEV(392, &soc_lpsc_list[17]),
-	PSC_DEV(395, &soc_lpsc_list[17]),
-	PSC_DEV(198, &soc_lpsc_list[18]),
-	PSC_DEV(202, &soc_lpsc_list[19]),
-	PSC_DEV(203, &soc_lpsc_list[20]),
-	PSC_DEV(133, &soc_lpsc_list[21]),
-	PSC_DEV(193, &soc_lpsc_list[22]),
+	PSC_DEV(333, &soc_lpsc_list[16]),
+	PSC_DEV(146, &soc_lpsc_list[17]),
+	PSC_DEV(392, &soc_lpsc_list[18]),
+	PSC_DEV(395, &soc_lpsc_list[18]),
+	PSC_DEV(404, &soc_lpsc_list[19]),
+	PSC_DEV(198, &soc_lpsc_list[20]),
+	PSC_DEV(202, &soc_lpsc_list[21]),
+	PSC_DEV(203, &soc_lpsc_list[22]),
+	PSC_DEV(133, &soc_lpsc_list[23]),
+	PSC_DEV(193, &soc_lpsc_list[24]),
 };
 
 const struct ti_k3_pd_platdata j784s4_pd_platdata = {
-- 
2.51.1

