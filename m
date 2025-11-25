Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47621D0E6CD
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 12:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C126284011;
	Tue, 25 Nov 2025 13:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kew0ehwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA2083FCF; Tue, 25 Nov 2025 10:46:56 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F064083FA5
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 10:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6YXjrvY2usJz3CT8G4NbmEW/UPpnYp4SH1yVGuCFNplLwjAxmgvd0ifBVG6b8FsEfED6FC2c53R/vVgxtVVLU3LA1Vz+JDoDtcYYBH3+Kq2tpkE6KwBKmmyJFedhgDAtR2cvc4WO6xlRYhFqMGnIXnsIwwDGzpGkcI6hIFvYj1Qjb0ia5HZ8Rr+F27iLO3VVmXrmTQ5mh8d2eHr5pLn3ZOnQQO/JGoltyHAagRYy+sx2OnO3VBFhhG1lAvcdE6/bnood8Wl6Ld15SQBs4XjH2dTXuQxPbuY4x6U3Po2huJ4w3U9tflM3IZ5l0cgBRZS4NXstVxke08QcpGHyxAYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hfycff26nq5Z+JA/FT0keDonQwyOckuKHlkhRa45uiI=;
 b=X39XD4tIyVO0Cny5X5qkWkDyaZOiTEpu/iqQRAo22PGTPGb+HKPwS8kl3zm186lWygrsg+j/SR+mI2yHuDFLc07mNHgU+/EGxxb3+Y+8XhWJk0c17IyBbnt0IdzCzajJITRxw7bzmY5KQMJEPEQhBT6kvl2Hl+MmLwJZ9MwPjxB6Y5ZJ/PbxLSME9DEJThkn+7ka5nZBhK5jjfoU+OCHvAP2MSBd0fWNjUjIYSJXBtc4awOuRCzIKnhaH/LnaO1S96g5Gv9mcYKSlamZz4szo/OQqwIth0Kx6HLUWo4yT8+wtqIhvFhcKMSkD0PlwZtSoyGGE+xpuDTmFxuWtl4Ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hfycff26nq5Z+JA/FT0keDonQwyOckuKHlkhRa45uiI=;
 b=kew0ehwMI9Z0mEp2rvOJJ1wOPNvm7CQf47kOwy4RLDPv7Oz2do4jit1esFSaEsL9QE8pv2JwasrW1UB5rZK47CunfNgXQgBXQxjwDGRR5HRMiQFWOMW14b/4L/vo8vBW50TYZ1xrN3DfWDAK9ecWxLJBsimIcW8k55a2Hl5kZn0=
Received: from CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::6)
 by CYYPR10MB7565.namprd10.prod.outlook.com (2603:10b6:930:bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 09:46:48 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::91) by CH5P222CA0014.outlook.office365.com
 (2603:10b6:610:1ee::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 09:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 09:46:48 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 03:46:46 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 03:46:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 03:46:46 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AP9kjbE3467115;
 Tue, 25 Nov 2025 03:46:46 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <mwalle@kernel.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH] arm: mach-k3: j722s: Update SoC auto-gen data
Date: Tue, 25 Nov 2025 15:16:39 +0530
Message-ID: <20251125094639.1754402-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CYYPR10MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a46c5e5-2235-4a2c-234d-08de2c078d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cyNKEbrGC9c5j9niY86tl+T09Lp1wNgJ11HqMZbjuHXYRYEu4WXx9+cd8lvh?=
 =?us-ascii?Q?UAZggYVbhy1nZ7k01DHuZ58Mrb9gmjH5Z8OctMKo3T3ju0NbW0rzX4EdLtnt?=
 =?us-ascii?Q?TrelUn6mTsARBQV5lQhPxjeCP/z6levjABtsO8ZFUorergmVAGGqkMUGeu99?=
 =?us-ascii?Q?ZheFKAARFKCgl750nLyEUhmloSDnuuOv4aPwgWDbZ9SJG4njOxMjPgzCY8I9?=
 =?us-ascii?Q?ZZKrtbN7JxA5uii4zORgDShp1uKCFG6HN4crw1wyGNiJR0FO58OYBAlw2hQk?=
 =?us-ascii?Q?q/hC35/gFzg9mAsNNnDUEa9oj18FYi0Tjqui+A929MVWOoHSyqh6f9ZSk2zy?=
 =?us-ascii?Q?FKsLav+NuORyGh4P9Zjt892M1P8YNZ+NwBvESt8zOIKc/0e32Bpgj3VymeNX?=
 =?us-ascii?Q?wZpjbca7hPjFfRfV2FKScsb7xNmOzsxjfecZdLGDoLIRdGBgI4CUMAmoW4/i?=
 =?us-ascii?Q?onO6+JzoLIr9jHolQ4bmt1zvkTxwhqrFp+YUEuqvPv2dSUwv87N5i0WGTxke?=
 =?us-ascii?Q?AuLcikVv1VxSYiVkpT5yZ/d1u6dhBw1x2ktq/xDHOAhGJzCkWAxt6BRMul6Y?=
 =?us-ascii?Q?s2pGEi7kWlq1gRnhZ+U9EiLh8BjmNnNXK3Wb7rTOxWgFz1U21E4J8IFYz1i+?=
 =?us-ascii?Q?pS+XOd5m0UIn8IMZgnIM7Oev0DSd3TifmqqKF37YANkxqXX1PMA8BXVs4VCn?=
 =?us-ascii?Q?Nw4k4Fgb8A3CLcNqlaJoxrZhSyBLtPEhgAbP2FLyLdLphyqpyiCeXaxqqnrW?=
 =?us-ascii?Q?vLoP6G8952mze4BmnPeyrXq6k3hUL+gLY2SVq0IdDHJQ4U1KUw6XQvsUT3lZ?=
 =?us-ascii?Q?uGMJvrcHe+dg9em+svaGdMBS+M8uJyOsfLYBGfjwbGkKCAbPTxmBMn1JnteY?=
 =?us-ascii?Q?9sKEqvSTK6YOAjd56+Ii860ya0gRFMyyF1qOyDFrQ3rkWNkX2MjCMm5nkUzj?=
 =?us-ascii?Q?WxoHs2KVpqQH7ClA5YMdZNH5ClxbO5moHE3I7D+MCXJX4wALAWteHhUltkxv?=
 =?us-ascii?Q?6K0RkdQEU8cDpld78T7MY5lNg3LoMA4gxoo4t5rnBNQq7RyJHkFwxQQdnTkW?=
 =?us-ascii?Q?emagVXbHDwgz3WZYI2mCj+FI6yQcHDDCK8B981EQSwLEb1+T5nmfPP9rJPdv?=
 =?us-ascii?Q?41Omq4gtLnjnzmEQnOCOlLZfBoFb+WeCBXpISM2yb0rbHbmFT34kftTqSCrN?=
 =?us-ascii?Q?8ljPn/4HS2TeTDIt4kpsu4rLqQwiLxAf6bBFdazAQR3X7WVoBgIORoCBERNr?=
 =?us-ascii?Q?9I6x/xXCvGfEZHbz5Vvv77+3TlSmnvKfpu0GNWferCrXGibJCkcESJXF14nr?=
 =?us-ascii?Q?p29gGmMC0HhFNOEi1zqqXj+Rs+PP8hUUJ7vVxNUK+3qZTdA4we2vdrEMGwXT?=
 =?us-ascii?Q?Pyf0wpBJ7RZ+RQwQTh+Xi4B6Nc49yazg6EHVQQsMi1oyWplWxQbkwUeIuv1W?=
 =?us-ascii?Q?2RjC2l4/AUOuPry16Lhp1iVj7gOxiMEvqMDjVBrKzXj1PyZinQ0wLudkLeCG?=
 =?us-ascii?Q?DhLiI3CpPAHaMxKJZGKYWAAZINMosTO5umqCQuWuOA2d8wJe0HD45VFQPBlr?=
 =?us-ascii?Q?p+9clKHpbo511OIHAV8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:46:48.0052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a46c5e5-2235-4a2c-234d-08de2c078d54
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7565
X-Mailman-Approved-At: Tue, 25 Nov 2025 13:40:19 +0100
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

Update dev-data and clk-data to fix the eMMC boot for J722s-EVM.

Fixes: a02009f3a816 ("arm: mach-k3: j722s: Update SoC autogenerated data to enable Ethernet boot")
Reported-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on commit "4a4871e3dc38" of origin/next branch of
u-boot.

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

