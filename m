Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC1AC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FB081E3E;
	Tue, 25 Mar 2025 04:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RQAEXGfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD8180EEF; Tue, 25 Mar 2025 04:58:43 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::726])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B5381026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acQln0zFyo80EQL4EZi0RteyynnJd7TKKXxnOLt896sULpYk75f1J8xXBjGgt2Lw870QS+kFlXD7tuVZ2AGIsCTqwqgkrpizO2fzfR09M5vE7FcXTugnsiBSt8yxyp+cyaeVLKGqp0EAhx+sDP/mfMZPUinXVHu3mKVlwsI4pXpc04aXRrEuMP/3yW1DzPL5n/MiQrghUbdfb26RVMFkt8yKR95DMh9HOEMYsO7vLnS1VsT+R2tw1Ela1bBeMtuK+Sg1cC76r6N6HLQ0u6YWA4aHr4sbjQjr82hyuDaJd1kH+M7fiKnuB2si2r3++BwoHChWG6OkQ+03vADYI9zrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKx57rFiJNuV9fDoXyFgVXtdGT+IiYR44CWdFuMe2rE=;
 b=nTFhRNgeQP+LOLX2n30WzBWI2J4AGQowG59J3UxtYQPReuM70n9Y8UdQNmfQnh8fnr3jSZJcVds5bFucsUxammDqt19zayos6J/tDy2knMOoNTFnExNJ2Lp4vU0ehLoCNzZ/FskPOxDnhU5dHvGwTw5mGgs+Bfv2BE35iBH08TIzktcYAlvTdj3rFi40ku3Mxf18xjyVEQ8b68qMzmReKiKCkOMDLMPHf6dv3NgvzxzBnkmmBQr9e+ugB6UkaHik89wUGn6xHMEEwJaUqg8SM5VCe3J2xLJy2nUHPus9F9nyc558OC6TcIIc3knU+ybUzezUOqHm2+wlx82xTVkJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKx57rFiJNuV9fDoXyFgVXtdGT+IiYR44CWdFuMe2rE=;
 b=RQAEXGfuBXJoMY09zcO3++/jXsNMtIKLixsekeN8RGQCXercU14R5Dg+8sTx6znrNwncbM7ObDlfmFV2BrKh4kHALu01DvuROB2Px4F3R8TuUIak0IwHCOz1eNPkAMRDEpyAdPTULjeGe3JRdqNtBORDxagk2ko7XyEpeMfSa9s08mnOdL9X/tQkM+NhOqPG2rZSklfFz6WKN3yo6umxVe2ZbSDSOGym1mz1H8TwlYoaRL9jnj+mhXDJCcq0M+Bb7KbnJP7GOqGnQIigR6bvKzvRfdjW+okz8jBl625pJEtdQWp8AQlnCltWDjoF7UFEgjQhiq4NEIN9KVMhvvQlEw==
Received: from DU6P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::15)
 by AS1P195MB1472.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:58:35 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::e6) by DU6P191CA0014.outlook.office365.com
 (2603:10a6:10:540::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:58:35 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:33 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:33 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <afd@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <vigneshr@ti.com>, 
 <s-k6@ti.com>, <dannenberg@ti.com>, <bb@ti.com>
Subject: [PATCH 6/8] arch: arm: mach-k3: r5: am62ax: Update SoC auto-gen data
 to enable CPSW boot
Date: Tue, 25 Mar 2025 04:58:22 +0100
Message-ID: <20250325035824.2304200-7-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325035824.2304200-1-w.egorov@phytec.de>
References: <20250325035824.2304200-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|AS1P195MB1472:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3d644b-96eb-49c0-571b-08dd6b515156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Dyv9pIA42E6dz7uxsWQywDYWVkhYm0b34St/vHueaviOSf5eeFy4vI+zadr?=
 =?us-ascii?Q?dted75f9NJ7YurEV2atmK3QK1nmy650RiX8e83p50QUgPwryI9/58pekjQ0r?=
 =?us-ascii?Q?JvYjRx+AJm69/We5I7HRb7FGJDVz9UuNJT/leMGhkj1EhQMpVAvJtRZEbv4e?=
 =?us-ascii?Q?1uINg+e3yLzygeJiDOKWLwu9KaalP6ZFLsRusZvue6guhlK55FVeqalIpbn9?=
 =?us-ascii?Q?nWAXlQ58VPuFb76HP4mjM4TNppb1YCbY4yxRN8iqyVc1R+TdCaNtIzowLy0y?=
 =?us-ascii?Q?TX67JvM38+k7xK+TLkdLVjPx8qpBkxCCL0iu9ThsXfHOsy8/36lfCbcX05dm?=
 =?us-ascii?Q?8Lvi8FHy2zeDel+3mgwnVsoHqXF3CmubPocR4Y+TGtGclhIofRc6mviYjDMe?=
 =?us-ascii?Q?XAySOi7GbXjs15X7ZCmuekiLTBRdHuddY5xwDI+ZDQuLvSypWp5gDQiLotBX?=
 =?us-ascii?Q?4JDWxDNZMtZazN9wz4Gm7nrHI01gBbYdNiDnM+On3aqSDgVTlL3As26M9K7w?=
 =?us-ascii?Q?CTSMgidXrCKcWsHs5UI1Ki+6kwuOv6CFuMoWB3hgf27kQisR19kAA0zWbNIo?=
 =?us-ascii?Q?M87571nXcQOqUuGus59I7wMN0F+f9ztkptKrPu6iZ1ac7KJaUa7L6JD7Kfw5?=
 =?us-ascii?Q?44dGc5wOvfUSS9o4Z/IvPlnyHFKybk6Ld8ubxNX3eCyU1kvVbLo6OSkDrHEd?=
 =?us-ascii?Q?j28QXzpvGUjcTmMGPo/0qw3/EH5ApP6fSJYhKltDz15QjaCXRrZI55s0hP7l?=
 =?us-ascii?Q?sL5RNa+oWFLUZFGPzMHuRWSnk48haYC9vkrf/zscovvmcwESwZpJUK6Qnj8F?=
 =?us-ascii?Q?/mLG4TWn7HHIeBcacvlmmCECb8/+oI5kXRoeQhUwqRx6IS6VlQdN0/ZnKRvd?=
 =?us-ascii?Q?EOo7EQLJHrhYIfEZpjzW8NTREapOHNGO4g61hGbGP6mhMA8i+dUiyqcYePZ0?=
 =?us-ascii?Q?dL+RbByQLT6PKV1TN7NoB9XqPGucTQIq+/ZjmywgRRa0+s6WK6wIYULY9dP3?=
 =?us-ascii?Q?nRp5eF2JjAbW5UN2Jon4f8Zom8Dfs+xer5Q9CUA4AaxOvIkZNlopz06gQbvX?=
 =?us-ascii?Q?F2Jdzdfu7yqvcc2ODpQFlpmtbTs2rkNwUAJlKXGTnKIa/rgix5tvj6F4QTNv?=
 =?us-ascii?Q?T9s0mxXhTK2CeXPb+Jx+Uyhy5YEPjB9+72H0rA4mTnEllMYTs7XKTfTRzakO?=
 =?us-ascii?Q?ZC44h3ipNaOIYbQdE5zSKBIWN7tbqSDt3HsokBp3ilWlqnN8OeWIZJjLaHd8?=
 =?us-ascii?Q?VvHl9QLegUIk+woRr0rv3xp9spSLCoVIM1FlKVO09Q2zq2yFzqX2yH7Sl4+S?=
 =?us-ascii?Q?C7/TXt4OlA2e66AZ8CwEfzzatjFJeQbJXMaV3B82h5ty2W6Po56RtMhrA9t9?=
 =?us-ascii?Q?JJdEUtCR7WlYAfa6DuTWKI1TcIj8H41l2DTnZzC7iW+UB9FarVgT5NLocxVj?=
 =?us-ascii?Q?xQYSpEI5LUt6wfq6JXFrf8Zl4epsB3Hup9mZx3H1Ju4GzANhmxpEgiL2Bz4t?=
 =?us-ascii?Q?+3Zb77vu3UDCAsI=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:58:35.6833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3d644b-96eb-49c0-571b-08dd6b515156
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1472
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

From: Andreas Dannenberg <dannenberg@ti.com>

This data was generated using the ksswtool-autogen project with the
followig commit:

eed7492 ("soc: am62ax: Add cpsw_3guss_main_0 id to the dev list")

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/r5/am62ax/clk-data.c | 51 +++++++++++++++++++++++++--
 arch/arm/mach-k3/r5/am62ax/dev-data.c | 29 ++++++++-------
 2 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62ax/clk-data.c b/arch/arm/mach-k3/r5/am62ax/clk-data.c
index d950b35e0be..7f1b6d5b4e0 100644
--- a/arch/arm/mach-k3/r5/am62ax/clk-data.c
+++ b/arch/arm/mach-k3/r5/am62ax/clk-data.c
@@ -67,6 +67,17 @@ static const char * const clkout0_ctrl_out0_parents[] = {
 	"hsdiv4_16fft_main_2_hsdivout1_clk",
 };
 
+static const char * const main_cp_gemac_cpts_clk_sel_out0_parents[] = {
+	"postdiv4_16ff_main_2_hsdivout5_clk",
+	"postdiv4_16ff_main_0_hsdivout6_clk",
+	"board_0_cp_gemac_cpts0_rft_clk_out",
+	NULL,
+	"board_0_mcu_ext_refclk0_out",
+	"board_0_ext_refclk1_out",
+	"sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk",
+	"sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk",
+};
+
 static const char * const main_emmcsd0_refclk_sel_out0_parents[] = {
 	"postdiv4_16ff_main_0_hsdivout5_clk",
 	"hsdiv4_16fft_main_2_hsdivout2_clk",
@@ -137,7 +148,16 @@ static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("board_0_mmc1_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_ospi0_dqs_out", 0, 0),
 	CLK_FIXED_RATE("board_0_ospi0_lbclko_out", 0, 0),
+	CLK_FIXED_RATE("board_0_rgmii1_rxc_out", 0, 0),
+	CLK_FIXED_RATE("board_0_rgmii1_txc_out", 0, 0),
+	CLK_FIXED_RATE("board_0_rgmii2_rxc_out", 0, 0),
+	CLK_FIXED_RATE("board_0_rgmii2_txc_out", 0, 0),
+	CLK_FIXED_RATE("board_0_rmii1_ref_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_rmii2_ref_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_tck_out", 0, 0),
+	CLK_FIXED_RATE("cpsw_3guss_main_0_mdio_mdclk_o", 0, 0),
+	CLK_FIXED_RATE("cpsw_3guss_main_0_rgmii1_txc_o", 0, 0),
+	CLK_FIXED_RATE("cpsw_3guss_main_0_rgmii2_txc_o", 0, 0),
 	CLK_FIXED_RATE("emmcsd4ss_main_0_emmcsdss_io_clk_o", 0, 0),
 	CLK_FIXED_RATE("emmcsd8ss_main_0_emmcsdss_io_clk_o", 0, 0),
 	CLK_FIXED_RATE("fss_ul_main_0_ospi_0_ospi_oclk_clk", 0, 0),
@@ -187,6 +207,7 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX_PLLCTRL("sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk_parents, 2, 0x4020000, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk", "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", 0x4020118, 0, 5, 0, 0),
 	CLK_MUX("clkout0_ctrl_out0", clkout0_ctrl_out0_parents, 2, 0x108010, 0, 1, 0),
+	CLK_MUX("main_cp_gemac_cpts_clk_sel_out0", main_cp_gemac_cpts_clk_sel_out0_parents, 8, 0x108140, 0, 3, 0),
 	CLK_MUX("main_emmcsd0_refclk_sel_out0", main_emmcsd0_refclk_sel_out0_parents, 2, 0x108160, 0, 1, 0),
 	CLK_MUX("main_emmcsd1_refclk_sel_out0", main_emmcsd1_refclk_sel_out0_parents, 2, 0x108168, 0, 1, 0),
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
@@ -203,6 +224,29 @@ static const struct clk_data clk_list[] = {
 };
 
 static const struct dev_clk soc_dev_clk_data[] = {
+	DEV_CLK(13, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(13, 3, "main_cp_gemac_cpts_clk_sel_out0"),
+	DEV_CLK(13, 4, "postdiv4_16ff_main_2_hsdivout5_clk"),
+	DEV_CLK(13, 5, "postdiv4_16ff_main_0_hsdivout6_clk"),
+	DEV_CLK(13, 6, "board_0_cp_gemac_cpts0_rft_clk_out"),
+	DEV_CLK(13, 8, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(13, 9, "board_0_ext_refclk1_out"),
+	DEV_CLK(13, 10, "sam62_pll_ctrl_wrap_mcu_0_chip_div1_clk_clk"),
+	DEV_CLK(13, 11, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(13, 13, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 14, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 15, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 16, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 17, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 19, "board_0_rgmii1_rxc_out"),
+	DEV_CLK(13, 20, "board_0_rgmii1_txc_out"),
+	DEV_CLK(13, 22, "board_0_rgmii2_rxc_out"),
+	DEV_CLK(13, 23, "board_0_rgmii2_txc_out"),
+	DEV_CLK(13, 25, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 26, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 27, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(13, 28, "board_0_rmii1_ref_clk_out"),
+	DEV_CLK(13, 29, "board_0_rmii2_ref_clk_out"),
 	DEV_CLK(16, 0, "hsdiv4_16fft_main_0_hsdivout1_clk"),
 	DEV_CLK(16, 1, "hsdiv4_16fft_main_0_hsdivout2_clk"),
 	DEV_CLK(16, 2, "hsdiv4_16fft_main_0_hsdivout3_clk"),
@@ -277,11 +321,14 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 25, "board_0_ddr0_ck0_out"),
 	DEV_CLK(157, 40, "mshsi2c_main_0_porscl"),
 	DEV_CLK(157, 77, "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk"),
+	DEV_CLK(157, 82, "cpsw_3guss_main_0_mdio_mdclk_o"),
 	DEV_CLK(157, 83, "emmcsd8ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 85, "emmcsd8ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 87, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 89, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 130, "fss_ul_main_0_ospi_0_ospi_oclk_clk"),
+	DEV_CLK(157, 133, "cpsw_3guss_main_0_rgmii1_txc_o"),
+	DEV_CLK(157, 136, "cpsw_3guss_main_0_rgmii2_txc_o"),
 	DEV_CLK(157, 146, "sam62_pll_ctrl_wrap_main_0_sysclkout_clk"),
 	DEV_CLK(157, 159, "wkup_clkout_sel_io_out0"),
 	DEV_CLK(157, 160, "wkup_clkout_sel_out0"),
@@ -311,7 +358,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 
 const struct ti_k3_clk_platdata am62ax_clk_platdata = {
 	.clk_list = clk_list,
-	.clk_list_cnt = 80,
+	.clk_list_cnt = 90,
 	.soc_dev_clk_data = soc_dev_clk_data,
-	.soc_dev_clk_data_cnt = 104,
+	.soc_dev_clk_data_cnt = 130,
 };
diff --git a/arch/arm/mach-k3/r5/am62ax/dev-data.c b/arch/arm/mach-k3/r5/am62ax/dev-data.c
index 6cced9efd08..fe025923f1b 100644
--- a/arch/arm/mach-k3/r5/am62ax/dev-data.c
+++ b/arch/arm/mach-k3/r5/am62ax/dev-data.c
@@ -17,9 +17,10 @@ static struct ti_psc soc_psc_list[] = {
 
 static struct ti_pd soc_pd_list[] = {
 	[0] = PSC_PD(0, &soc_psc_list[1], NULL),
-	[1] = PSC_PD(3, &soc_psc_list[1], &soc_pd_list[0]),
-	[2] = PSC_PD(4, &soc_psc_list[1], &soc_pd_list[1]),
-	[3] = PSC_PD(13, &soc_psc_list[1], &soc_pd_list[0]),
+	[1] = PSC_PD(2, &soc_psc_list[1], &soc_pd_list[0]),
+	[2] = PSC_PD(3, &soc_psc_list[1], &soc_pd_list[0]),
+	[3] = PSC_PD(4, &soc_psc_list[1], &soc_pd_list[2]),
+	[4] = PSC_PD(13, &soc_psc_list[1], &soc_pd_list[0]),
 };
 
 static struct ti_lpsc soc_lpsc_list[] = {
@@ -32,11 +33,12 @@ static struct ti_lpsc soc_lpsc_list[] = {
 	[6] = PSC_LPSC(24, &soc_psc_list[1], &soc_pd_list[0], &soc_lpsc_list[8]),
 	[7] = PSC_LPSC(28, &soc_psc_list[1], &soc_pd_list[0], &soc_lpsc_list[8]),
 	[8] = PSC_LPSC(34, &soc_psc_list[1], &soc_pd_list[0], &soc_lpsc_list[8]),
-	[9] = PSC_LPSC(43, &soc_psc_list[1], &soc_pd_list[1], &soc_lpsc_list[8]),
-	[10] = PSC_LPSC(46, &soc_psc_list[1], &soc_pd_list[2], &soc_lpsc_list[9]),
-	[11] = PSC_LPSC(60, &soc_psc_list[1], &soc_pd_list[3], &soc_lpsc_list[8]),
-	[12] = PSC_LPSC(61, &soc_psc_list[1], &soc_pd_list[3], &soc_lpsc_list[11]),
-	[13] = PSC_LPSC(62, &soc_psc_list[1], &soc_pd_list[3], &soc_lpsc_list[12]),
+	[9] = PSC_LPSC(42, &soc_psc_list[1], &soc_pd_list[1], &soc_lpsc_list[8]),
+	[10] = PSC_LPSC(43, &soc_psc_list[1], &soc_pd_list[2], &soc_lpsc_list[8]),
+	[11] = PSC_LPSC(46, &soc_psc_list[1], &soc_pd_list[3], &soc_lpsc_list[10]),
+	[12] = PSC_LPSC(60, &soc_psc_list[1], &soc_pd_list[4], &soc_lpsc_list[8]),
+	[13] = PSC_LPSC(61, &soc_psc_list[1], &soc_pd_list[4], &soc_lpsc_list[12]),
+	[14] = PSC_LPSC(62, &soc_psc_list[1], &soc_pd_list[4], &soc_lpsc_list[13]),
 };
 
 static struct ti_dev soc_dev_list[] = {
@@ -55,11 +57,12 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(36, &soc_lpsc_list[8]),
 	PSC_DEV(102, &soc_lpsc_list[8]),
 	PSC_DEV(146, &soc_lpsc_list[8]),
-	PSC_DEV(166, &soc_lpsc_list[9]),
-	PSC_DEV(135, &soc_lpsc_list[10]),
-	PSC_DEV(170, &soc_lpsc_list[11]),
-	PSC_DEV(177, &soc_lpsc_list[12]),
-	PSC_DEV(55, &soc_lpsc_list[13]),
+	PSC_DEV(13, &soc_lpsc_list[9]),
+	PSC_DEV(166, &soc_lpsc_list[10]),
+	PSC_DEV(135, &soc_lpsc_list[11]),
+	PSC_DEV(170, &soc_lpsc_list[12]),
+	PSC_DEV(177, &soc_lpsc_list[13]),
+	PSC_DEV(55, &soc_lpsc_list[14]),
 };
 
 const struct ti_k3_pd_platdata am62ax_pd_platdata = {
-- 
2.34.1

