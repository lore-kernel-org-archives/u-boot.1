Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09656D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 06:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A858397D;
	Mon,  1 Dec 2025 07:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QsQIUvOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4FCA83981; Mon,  1 Dec 2025 07:08:51 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B760E83966
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 07:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvON0aOZpyEKYhis4AXSONrmvJ11yyu94FyKNLHN+rP6orgId0NW1BPgGv+/RA+wMUswM6hxdpNcIJCWwa1qCUitrAlkZ6CFvgkSIrqygqJJu2i+KT0j2kpWzEbZf21tkMnrpr9cJzGFy841+/MWhYNpMKO9MooG1ta4LQfkqAD0xDeQdyhjjAHz50NYFaHFdnFUNhZM8FnotG5SdKfcz4tnnhifm+5Q9CJ5rAClSULijhFibmvwpreHM3uLilDTANJdkmMYUfqrylFF1LHAUPqQ+R3IMNiiMxxchrEwLFYhrcIfVeQDSKr6QoIZ2npkSPleL0dgy3soG6yCVTe7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb6u0cvz3x1dehpxy4ClpbRmfQwh562n8MjX+4TvpWQ=;
 b=Pg75CWjd+VLtxSGppFxQ01NrZ3w8nO9WN/GbLfvU2mH4xSO5kXixyk+HEIzk4oN/c8p5KNqTMGTmBDYx9UywTjFmp3dPmt8QOqiXSMAaakBzPFJkjtv9f02AV7Te96tdn3AgqtHhcyS1SvQDK4YcjozbxXaG6Ol/VNXyXaCvU1vnJOIdxSFXtDErZVWdndXKRdTGCE4/6y6tpBwdgmBSNZ1Hmgwp7fVaEo7pcZykRFjDqe6v6Uz2uakjooYgcDlNaIR1kwGx7djjjhQm0los1cv/zMyXGr/lLwlWZ9hGCC4kLGxGTQVsZ/RiiGRLwD+gy+XU7UxFSsKFxA+G2ZWdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb6u0cvz3x1dehpxy4ClpbRmfQwh562n8MjX+4TvpWQ=;
 b=QsQIUvOI5zmxeRD3klOkXTHNmnNDU8R3wrGfSzC+q+1beu7XehWaocMu5UWZlTSThGovxGMHZFkKyTg9SNcGMhn74r/g3DBo5G3yZ1bgsL9rtQZN27m18BlSTdOeRV7J7umlRdp9O2gNwh5HoSYmgPOlRyJAFvmFnpCyvaa6AzU=
Received: from DM5PR07CA0089.namprd07.prod.outlook.com (2603:10b6:4:ae::18) by
 MW4PR10MB6394.namprd10.prod.outlook.com (2603:10b6:303:1eb::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Mon, 1 Dec 2025 06:08:45 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:4:ae:cafe::d) by DM5PR07CA0089.outlook.office365.com
 (2603:10b6:4:ae::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 06:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Mon, 1 Dec 2025 06:08:44 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 00:08:43 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 00:08:43 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 00:08:43 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B168gii4108739;
 Mon, 1 Dec 2025 00:08:43 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <mwalle@kernel.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2] arm: mach-k3: j722s: Fix eMMC boot functionality broken by
 Ethernet boot
Date: Mon, 1 Dec 2025 11:38:39 +0530
Message-ID: <20251201060839.777816-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|MW4PR10MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: f441ebc4-eb99-461b-cbf5-08de30a01591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ktr2iSDQTbmAC0z5FO0xJCIYBMSsl5sNLgoLHWPDd1ytCPwGufErkEQFefs9?=
 =?us-ascii?Q?/XNgUG36pkpJb4xz2wkyS1TrLx90AHKE9tPMSFosPD4vxHgLtTWAl2xB1g8H?=
 =?us-ascii?Q?ybxXIhnbh8BZHixyJkS0ODamEQyaa4ghEk7tkocEgixFsNTAVSThApYI0CEN?=
 =?us-ascii?Q?EXB83OUQ21lhkKv1b0LAN9XdnxDZffFSi5yB6AXsjhq4vtKowvXH43DpnP65?=
 =?us-ascii?Q?uu3hE9e8Y+2zP7tlR6zEWXv+B66WZdTE3QPdsfuIF2InSAxT7jqJtNRzfzI3?=
 =?us-ascii?Q?HlPX/cqCcw5fBfk6IJ0x0MWPFW+j4BgXV3UFQ7QyU1NDuMUr2a9zZ3zo4xsf?=
 =?us-ascii?Q?hBs8uOdxP1SO+N37Zp+bF/adzspPSEyX/jlzyEVvQZ2meF6ae5C5yISXVffx?=
 =?us-ascii?Q?MVOvDMzl2IcFx4hxJp4uRqjrX/iT0sE0/XPm4BCc0vWwHZEyhlqzODKQXq0H?=
 =?us-ascii?Q?8U51qUnIVLBEHQQ56jPRWN+bKeTLfJd97/dVFwgtQwnua0pWTE0U8apT4in8?=
 =?us-ascii?Q?6jcnWhx9aRnuQBMo/Fn725jdXH+PFzZ8dwLU6KJql/7TWAa+ISCI74KZmGdD?=
 =?us-ascii?Q?E3OnIsMSGy2Ii7iA7twuASrhORPU0Tr1D0bpltggD0/C840QkAM92Jl7cR2t?=
 =?us-ascii?Q?UcgiAzozgNeIYjpwiMikdyB8SkZlRr20BefGxnHCMhkRUKmxF3DAVDrWNASv?=
 =?us-ascii?Q?ZZjir+Y9ASN7X3V2Tg0WbVDmUsqPo9VjhX9WmGpvn/TnwIAqbDB1FvWriOhe?=
 =?us-ascii?Q?77k9/i3zPoEsICTVDgSXTvweLJYCJHjp7teB3zQGe2k4UNzqj84aCDyIqmOG?=
 =?us-ascii?Q?Epv/0GVdOpMvJ14HCxmm7meFu/SICSyb8Ie38i/QbblwFv7UC4JfG6oO7hIO?=
 =?us-ascii?Q?2W/4liJiXDrt1qHqBSTrVnzrGM5viN8U6Fvin37bo1mMHAxNoWvzXLXJ+CN+?=
 =?us-ascii?Q?6zJwPBp3oqzpBk5Es7xKTBpBWwUOwMqEEAbq2sauRZcuNQfTyJiEf4VUw5AG?=
 =?us-ascii?Q?GOdyeX4jiMpc0vu/wPTVySfS75217stTsSMHfbLVDVeo2Yyfq7UVoPu2ltq3?=
 =?us-ascii?Q?jfdTD3Hb1VQkjZRhncYnpx9pbAIRf+f7X9JeXjb35g8/yssd5Va0L/E5g7cz?=
 =?us-ascii?Q?9YGubDSyvM+ivEStXHeXxCfnZ1/8MLCbImRo+3Qb0JrMeCB24AZBsPPcZdPh?=
 =?us-ascii?Q?tX+fQc9JOi7LaO0jtVZHWauxKPnmwsLmGygH3WNZKki6HmX1VL5rSMuY9nXl?=
 =?us-ascii?Q?uxqkWgM0PjgGhYpsHynsiDY/CIYpBPGzYZfQ/aCfSjHgfBsteA3ZYuDJolFQ?=
 =?us-ascii?Q?S5q7jcgYC0TQx4ijOQbUnFxoOlV8k2MueTDMR+3wP/GLb7RWqVWruznANBTL?=
 =?us-ascii?Q?6cwNXGhM3QH9fSHvD6yRw1NkvaZfNPyJdD1W+SsT5r3ImxsAV5JzL84OOaBW?=
 =?us-ascii?Q?Vz2Iz+EjxANQZDaONowR5tKQ/z6FPfYJFPHmJh23lVmxpLPjFPtT0pQMMdeL?=
 =?us-ascii?Q?L6zdtTSpWcP0FMNbug6zRz78s/syCDzIn6G6OLv++k5Ps3XpZcJFIGEWHBuC?=
 =?us-ascii?Q?is47Hanaope4V9kin3g=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 06:08:44.6949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f441ebc4-eb99-461b-cbf5-08de30a01591
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6394
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

While adding CPSW device support to enable Ethernet boot for J722S in
dev-data, the eMMC boot functionality was broken. Fix this by adding the
missing device ID 57 and its associated clock configurations.

Fixes: a02009f3a816 ("arm: mach-k3: j722s: Update SoC autogenerated data to enable Ethernet boot")
Reported-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
Tested-by: Michael Walle <mwalle@kernel.org>
---

This patch is based on commit '31bf4a1c30877' of origin/master branch of
u-boot.

Changes from v1 to v2:
- Updated commit subject and message to convey what has changed by this
  patch.
- Collected "Tested-by" tag from Michael Walle. 

 arch/arm/mach-k3/r5/j722s/clk-data.c | 12 +++++++
 arch/arm/mach-k3/r5/j722s/dev-data.c | 50 +++++++++++++++-------------
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-k3/r5/j722s/clk-data.c b/arch/arm/mach-k3/r5/j722s/clk-data.c
index 238d57d0aa0..cb3d864c5a3 100644
--- a/arch/arm/mach-k3/r5/j722s/clk-data.c
+++ b/arch/arm/mach-k3/r5/j722s/clk-data.c
@@ -68,6 +68,11 @@ static const char * const main_cp_gemac_cpts_clk_sel_out0_parents[] = {
 	"sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk",
 };
 
+static const char * const main_emmcsd0_refclk_sel_out0_parents[] = {
+	"postdiv4_16ff_main_0_hsdivout5_clk",
+	"hsdiv4_16fft_main_2_hsdivout2_clk",
+};
+
 static const char * const main_emmcsd1_refclk_sel_out0_parents[] = {
 	"postdiv4_16ff_main_0_hsdivout5_clk",
 	"hsdiv4_16fft_main_2_hsdivout2_clk",
@@ -106,6 +111,8 @@ static const char * const main_timerclkn_sel_out0_parents[] = {
 	NULL,
 	NULL,
 	NULL,
+	NULL,
+	NULL,
 };
 
 static const char * const wkup_clkout_sel_out0_parents[] = {
@@ -205,6 +212,7 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX_PLLCTRL("sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk_parents, 2, 0x4020000, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk", "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", 0x4020118, 0, 5, 0, 0),
 	CLK_MUX("clkout0_ctrl_out0", clkout0_ctrl_out0_parents, 2, 0x108010, 0, 1, 0),
+	CLK_MUX("main_emmcsd0_refclk_sel_out0", main_emmcsd0_refclk_sel_out0_parents, 2, 0x108160, 0, 1, 0),
 	CLK_MUX("main_cp_gemac_cpts_clk_sel_out0", main_cp_gemac_cpts_clk_sel_out0_parents, 8, 0x108140, 0, 3, 0),
 	CLK_MUX("main_emmcsd1_refclk_sel_out0", main_emmcsd1_refclk_sel_out0_parents, 2, 0x108168, 0, 1, 0),
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
@@ -262,6 +270,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(36, 10, "board_0_cp_gemac_cpts0_rft_clk_out"),
 	DEV_CLK(36, 11, "hsdiv4_16fft_main_1_hsdivout3_clk"),
 	DEV_CLK(36, 12, "postdiv4_16ff_main_2_hsdivout6_clk"),
+	DEV_CLK(57, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(57, 2, "main_emmcsd0_refclk_sel_out0"),
+	DEV_CLK(57, 3, "postdiv4_16ff_main_0_hsdivout5_clk"),
+	DEV_CLK(57, 4, "hsdiv4_16fft_main_2_hsdivout2_clk"),
 	DEV_CLK(36, 13, "cpsw_3guss_am67_main_0_cpts_genf0"),
 	DEV_CLK(36, 14, "cpsw_3guss_am67_main_0_cpts_genf1"),
 	DEV_CLK(58, 0, "main_emmcsd1_io_clklb_sel_out0"),
diff --git a/arch/arm/mach-k3/r5/j722s/dev-data.c b/arch/arm/mach-k3/r5/j722s/dev-data.c
index d6832266884..5f7e2a44fed 100644
--- a/arch/arm/mach-k3/r5/j722s/dev-data.c
+++ b/arch/arm/mach-k3/r5/j722s/dev-data.c
@@ -23,18 +23,19 @@ static struct ti_pd soc_pd_list[] = {
 
 static struct ti_lpsc soc_lpsc_list[] = {
 	[0] = PSC_LPSC(0, &soc_psc_list[0], &soc_pd_list[0], NULL),
-	[1] = PSC_LPSC(12, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[4]),
-	[2] = PSC_LPSC(13, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[4]),
-	[3] = PSC_LPSC(21, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[6]),
-	[4] = PSC_LPSC(23, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[6]),
-	[5] = PSC_LPSC(28, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[6]),
-	[6] = PSC_LPSC(34, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[6]),
-	[7] = PSC_LPSC(42, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[6]),
-	[8] = PSC_LPSC(53, &soc_psc_list[0], &soc_pd_list[1], &soc_lpsc_list[6]),
-	[9] = PSC_LPSC(56, &soc_psc_list[0], &soc_pd_list[2], &soc_lpsc_list[8]),
-	[10] = PSC_LPSC(72, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[6]),
-	[11] = PSC_LPSC(73, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[10]),
-	[12] = PSC_LPSC(74, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[11]),
+	[1] = PSC_LPSC(12, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[5]),
+	[2] = PSC_LPSC(13, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[5]),
+	[3] = PSC_LPSC(20, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[4] = PSC_LPSC(21, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[5] = PSC_LPSC(23, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[6] = PSC_LPSC(28, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[7] = PSC_LPSC(34, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[8] = PSC_LPSC(42, &soc_psc_list[0], &soc_pd_list[0], &soc_lpsc_list[7]),
+	[9] = PSC_LPSC(53, &soc_psc_list[0], &soc_pd_list[1], &soc_lpsc_list[7]),
+	[10] = PSC_LPSC(56, &soc_psc_list[0], &soc_pd_list[2], &soc_lpsc_list[9]),
+	[11] = PSC_LPSC(72, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[7]),
+	[12] = PSC_LPSC(73, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[11]),
+	[13] = PSC_LPSC(74, &soc_psc_list[0], &soc_pd_list[3], &soc_lpsc_list[12]),
 };
 
 static struct ti_dev soc_dev_list[] = {
@@ -43,18 +44,19 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(61, &soc_lpsc_list[0]),
 	PSC_DEV(178, &soc_lpsc_list[1]),
 	PSC_DEV(179, &soc_lpsc_list[2]),
-	PSC_DEV(58, &soc_lpsc_list[3]),
-	PSC_DEV(161, &soc_lpsc_list[4]),
-	PSC_DEV(75, &soc_lpsc_list[5]),
-	PSC_DEV(36, &soc_lpsc_list[6]),
-	PSC_DEV(102, &soc_lpsc_list[6]),
-	PSC_DEV(146, &soc_lpsc_list[6]),
-	PSC_DEV(13, &soc_lpsc_list[7]),
-	PSC_DEV(166, &soc_lpsc_list[8]),
-	PSC_DEV(135, &soc_lpsc_list[9]),
-	PSC_DEV(170, &soc_lpsc_list[10]),
-	PSC_DEV(177, &soc_lpsc_list[11]),
-	PSC_DEV(55, &soc_lpsc_list[12]),
+	PSC_DEV(57, &soc_lpsc_list[3]),
+	PSC_DEV(58, &soc_lpsc_list[4]),
+	PSC_DEV(161, &soc_lpsc_list[5]),
+	PSC_DEV(75, &soc_lpsc_list[6]),
+	PSC_DEV(36, &soc_lpsc_list[7]),
+	PSC_DEV(102, &soc_lpsc_list[7]),
+	PSC_DEV(146, &soc_lpsc_list[7]),
+	PSC_DEV(13, &soc_lpsc_list[8]),
+	PSC_DEV(166, &soc_lpsc_list[9]),
+	PSC_DEV(135, &soc_lpsc_list[10]),
+	PSC_DEV(170, &soc_lpsc_list[11]),
+	PSC_DEV(177, &soc_lpsc_list[12]),
+	PSC_DEV(55, &soc_lpsc_list[13]),
 };
 
 const struct ti_k3_pd_platdata j722s_pd_platdata = {
-- 
2.34.1

