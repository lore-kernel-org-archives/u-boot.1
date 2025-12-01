Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6650D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1322483B55;
	Mon,  1 Dec 2025 12:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nV1REQ8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F13F83B22; Mon,  1 Dec 2025 12:01:35 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D1A983AAC
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+PczDOOH7B/5ckNwhquBGd0v+oTw2CCIC0YWMoEMb1HjZuXdNFVQABPmUvNOzJeqY0GEVwRxEAgiOcngOjKxu2nGGUZSN0v8sViHNJxiPJzlocusg51jqAekEPcmwVOkAkV38p6U+O5yD7JLVcYE0ZG8eVXw7eFmnoHo75d6ZC+crQ0emRHapcyqgMx90iNx3RnXdD2/410NVGFpJDK8sTjFOhEeW4lIutOIB/yYi8zgyvE7USZlNAOeRkcB3TSoemgCeWKZnuicdvDAiQk9TBuaw+TKxC16wE+MzcMD2P8p7+/jUYtlN2zziiPoI4jbrdh1Pxxd3s0T4OgleR/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugBxetSz6Xh5sX1oH7sBXeG4hl67Z/hIk+/Z7Pexuvc=;
 b=Njb23zwh2IsgNtrsx7Qn23IORzI5gUh3VwlH4okjkHb6IPruY9zUqD9Yx2WKMmG1pNcdYIRstnCWmkPqUtxo6hxJrM548mAmNOonp5FLqkIjwc5OqfWMMZBvF0gFh9J8ySMqN+0mxYQMiJdos5L/W1X+Sn9vQVPfjQsVHCwIXreH9gkM9cKpqGXNqOffEld6xUl3z8rMOPeitmtlmmU6MbexBy7/KTLYJIlVilrGQTHgeseqwLME7kyAs7RVrmBSh7CDfspTWFixCe5gUFuOv4MaGpeV++EuDaWdMsJ3X2R9s/nApkN4td4Wiz78+cShUsddEDgj68CB9sc/nyuERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugBxetSz6Xh5sX1oH7sBXeG4hl67Z/hIk+/Z7Pexuvc=;
 b=nV1REQ8JWFo36fDgy0uXv6aI3SbvEzmokg5fZdw31tD7FksdErdVfPcqv0t9cjRU2Fdf+4pPpWHb8h7p2eklpUIq9umZ5p373X4sy9l/cXIC4sdHTYfl0y4R2x1nvk8Fq+7jiTLgmc4XPByJGvTyc4wQOQiMpnrXc46/brWiN8w=
Received: from CH2PR18CA0047.namprd18.prod.outlook.com (2603:10b6:610:55::27)
 by DS4PR10MB997621.namprd10.prod.outlook.com (2603:10b6:8:31c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 1 Dec
 2025 11:01:16 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::7e) by CH2PR18CA0047.outlook.office365.com
 (2603:10b6:610:55::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 11:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:16 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:14 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:13 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qY306512;
 Mon, 1 Dec 2025 05:01:09 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 01/10] arm: mach-k3: j784s4: Update SoC autogen data to
 enable PCIe boot
Date: Mon, 1 Dec 2025 16:30:54 +0530
Message-ID: <20251201110103.845413-2-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|DS4PR10MB997621:EE_
X-MS-Office365-Filtering-Correlation-Id: 156881bf-6d71-455e-9032-08de30c8f31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nhQ6anYt4qAEcvguyollt6BHjb0biRTmjmcibp7+Pk2LFuiYoFEY1ywlmD9T?=
 =?us-ascii?Q?uXhcS/6XYt48q6zFZbdUobJxyJ5dRrOhv9uhxS7xxppo+X2LOwKIC8EqMOht?=
 =?us-ascii?Q?1wQsXXJaO+2Y4gU+3A/sRgKDcR0g8ntpfpax5GJgBQ0JhxxZ9EAe5OSxEyoK?=
 =?us-ascii?Q?4v/QtTfRqs9y35CdDRDK3W4Bo3AaLPuzJkV/OyuN0Io6OVggiX8CxairUUqs?=
 =?us-ascii?Q?pND8CINYDKD7aQIO8MLpyKVNhOWaA17Yv2UTrt/2DFopANMVBXv8VaYuyxqB?=
 =?us-ascii?Q?F51KB3CzsbNwAQpco618/yf+ey+CSz+tA3UsE5RLvihM9o2Qr4WH9U1dmxHU?=
 =?us-ascii?Q?ecyJO5xrcO3YrB609Dvofe8100pvao3jxrRxOSLBM2koHKsCaU/hogMpExT7?=
 =?us-ascii?Q?CObv8OxnHtmhxiJeTx2rTGjFZg+z+ZCJD6nbU6JihoAGVDkacjg6nal1eUpY?=
 =?us-ascii?Q?Q3hFnFlVb9U4svv6+DDiI0LXilXknSZ46tjkhNimGy+DYogx0U1oeIhQHz5O?=
 =?us-ascii?Q?YtxJoqdcpjJWi8iFt5idbt8e8f8iYv+mHnPx1CT08ayeP0FLoyVIwtZIqiYJ?=
 =?us-ascii?Q?6+gVRcW6InNhe/YWp5eviH1Tov9I9CRyrHW7fZt1xo3Y6fe5qUhSMZtpSmoS?=
 =?us-ascii?Q?YF+nW5NEX+5//q6wLh1M8c5zdVgAsNo8KdVXipNfhPMaceDIuhZRorOdkNdY?=
 =?us-ascii?Q?l3QMAo7GLlO81YltcmOZU+nUPXjAFlqgEJ6v2+va6mx2Odw1DCf+ixo+Dv0m?=
 =?us-ascii?Q?lR/EoCu4E9PpM1GSKgV4iFFUZws/MJ6cR3Rx1BhADzhx1BErbelsZMo40HW6?=
 =?us-ascii?Q?+or2LbjVJy3jRDqcOem7VLnsctcke9rIZD365z2DQ1qPAqzQGPeUa+ZY1kgd?=
 =?us-ascii?Q?Lmm2lau/VIuZdrkHMr8EgF6Chs+K14nHxR1E32H9pOuhXRVlV/k23/BdAt6j?=
 =?us-ascii?Q?nT5hFlHiJKHzLo8FB60KiiqpxohzKQV9r3IsZ2fUE40pyIMD95X2aZEDa51J?=
 =?us-ascii?Q?d08E6LOAS9e8zuqVkiYTIeL4dFK6/llhcoHP9t75kngM3pmZiGAZUhD2J9Y6?=
 =?us-ascii?Q?NPASTS8QtzeCsKQuszV6Fe/spRdxhLgZA+5d2da18d3p2456yfCuLOZQcD+D?=
 =?us-ascii?Q?6eaCMu4m98QsMynPXqfaWKYROFKebgQMOoo7eIsbnEuwXPXgIvhv8ez4ZNV9?=
 =?us-ascii?Q?yZHyZKdjdpP2SGZt+4ZVJEhcfeI/jLGL/eNEKWOzEleeWqRLYR0svpku5A7O?=
 =?us-ascii?Q?bvP/o6tkdHV4SEnka/sUdLJ34TYysAv3VjiA57XI7TQ8sX+UmKfCEsA5QqvV?=
 =?us-ascii?Q?0LGtHXiC36LL5WGfTjppcYQS7Hz7JczHck04RRphcQSjrmUOECNEUJiVpn/o?=
 =?us-ascii?Q?VBVD7/X+RxeFrg8QavjfWXM2KM5rLjLjKhJo/Gm6YSuzMeihY5tNklAMlk45?=
 =?us-ascii?Q?8XqAQUQZ0GerBqGqHEIyx66lXQqGfCiNvREp7V7gAJPhvLROsZSKNwF2gsW6?=
 =?us-ascii?Q?iO+/lyiZFpwFyU0GdJF9l3OaBr/aQRGPChNt8gaV5qVifuOxhi4hsAQL3smk?=
 =?us-ascii?Q?Q96C8SeWQDuEkKP3AyjASjQ5U6LtC4pNE1rDn/EY?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:16.2514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156881bf-6d71-455e-9032-08de30c8f31b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997621
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

To enable PCIe boot on J784S4 SoC SERDES0 and PCIE1 should be enabled
and configured at r5 stage. Add the required clk-data and dev-data
for SERDES0 and PCIE1.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm/mach-k3/r5/j784s4/clk-data.c | 184 ++++++++++++++++++++++++--
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  43 +++---
 2 files changed, 200 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
index 24780eb6562..ce111377e41 100644
--- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
@@ -5,7 +5,7 @@
  * This file is auto generated. Please do not hand edit and report any issues
  * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
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
index 19901821225..19ac1986b20 100644
--- a/arch/arm/mach-k3/r5/j784s4/dev-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/dev-data.c
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
2.34.1

