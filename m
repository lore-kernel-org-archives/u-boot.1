Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840FFD1F9D1
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B5A83C40;
	Thu,  4 Dec 2025 13:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QUMSBMx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36B083FE9; Thu,  4 Dec 2025 13:21:43 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE0283B4F
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 13:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+hKwhTjuC/vwbhNbxQdC0Po6roOKSltlFKKaK4NiCWi3mo32v2kYg1GrqkrbiRbq4K5AguuTBmYY827LNNLDQLnkFc7u1rj86Yn+EmcIDbNFhcQLDE4ClkA/Rv60jnGfnaNqoWRBpoZYrhEi/bfm+zf7ifTjQf3UEgoeIQUoFzi83rzScBFLvJqI6v1A5ItaS4RlsYccMeyRXYIb36A0ZaR56uYi7ZsKGNpg4BHcdQYoEkryMD5vM7H5dtMDge2RSHWxR8iAMXZdthvYofPcH35bJ8d3tYzIJDmPxChq28D9N90H1ahi4NyCvV3CRMh8OVOOXAXqvZFdoFYgy8xPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7XcNWvpYRR/Z8fOF5gCVY+F32J7UFUlSk+Zl4S6FCI=;
 b=DMOBxVmfaAeigggc/n2W8RA/aLhffvjvZkROKK8S4tei5wdzAz2PSE+anSD/dodK9mE49SDh9L7cWs5UC53brt2HwX0Uikcof99elYPlTvt0GDTNaSl+PD7xZt4vmMBWyvWtpT48VdIpI/FJWNPRgh7VA3PwmR302WjGvyTG88K6240kDWC2Q1hSYlQH1YehmsLjhoLFmjtbdwiLhKmUDljEyiuM0A3POJLXcSgKMmOly57t0aqWKYaqHM/UD4X5F1rO0Cbl14djDAzyrZfDB2YNNcim8LWOzRGM98QQhtKJBBn/29ec6F7Kf/Cz8d8NbcJ2G/p3aqYK/UTzh9uSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7XcNWvpYRR/Z8fOF5gCVY+F32J7UFUlSk+Zl4S6FCI=;
 b=QUMSBMx/VWnuYwXXz2kjfLG69c4DJEfvuoO+oKzQSd9QwG5q4GffSYTNuiv/dVsk/HJXrI/3hJ2n1C7yJchgoCyVxDvo2ltFv9vcoExTqtIDZm6W7hhgNU8EZ95rHw5Jds3Bdfs3ws9mNckzU0S3MigGsQlj9V5G3quMEA507rQ=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by PH0PR10MB997570.namprd10.prod.outlook.com (2603:10b6:510:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 4 Dec
 2025 12:21:33 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::42) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 12:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 12:21:31 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 06:21:31 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 06:21:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 06:21:31 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4CLUTE1533546;
 Thu, 4 Dec 2025 06:21:30 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Chintan Vankar <c-vankar@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <mwalle@kernel.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH v3] arm: mach-k3: j722s: Fix eMMC boot functionality broken by
 Ethernet boot
Date: Thu, 4 Dec 2025 17:51:27 +0530
Message-ID: <20251204122127.717108-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|PH0PR10MB997570:EE_
X-MS-Office365-Filtering-Correlation-Id: b83cc628-4755-4e02-241d-08de332fa8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tWyXsEfs/KPG8citaj+285fGKUYWnnKWe5pYLso46x19NHcUoJEi8YuqHY+/?=
 =?us-ascii?Q?bWTfb0LdCq+s1g1cS66TvckEg8o4ixoeYnRVfEJ3sCdACOvO0IMtE50wZXPi?=
 =?us-ascii?Q?Kut9Vw0zTjpJyq/TPs0gDZXmdjVKQvt0JwHXCxppMthXyl8laEWLryGCD0wK?=
 =?us-ascii?Q?ivXNoXPCVA1IxlDbqmvNS35qYWOZKSZTNy9q8HFBiacMOC6xBZu+ITA794qY?=
 =?us-ascii?Q?KX/FUJHcs/2/TI/PFgRDdtHeC6TL0WmEIfagucHcnexFN/g658A2RYtglbOA?=
 =?us-ascii?Q?sHp9jnGsZxXIsM5pGZaeyBLFO7HA0rDRC9FsmOKNQKm3OlHpVjr5YSbFJxUp?=
 =?us-ascii?Q?gzQj9Tr2SXXVn5PKb0E+xP12B0AyZT4gdWP092L3ijKw/K7y8g7p8xRPcarT?=
 =?us-ascii?Q?rmo4CjS9DPMPatkTxRtcBIrOaI1RyVgbf/yBKqKgf7VCHeQF2gd+fyjQFSdh?=
 =?us-ascii?Q?ybMAhbxs1OmkGbtcoARNpIzjpdeVbzAtbFF5xfnehylEWkuoXYpk2+xbvCjo?=
 =?us-ascii?Q?lrNdkHT2JcO0YsKisEiojZismc5LjtUPQa8Gsl6g/Tlx+BoLmSWH0P3ZTxVl?=
 =?us-ascii?Q?X0YYhuRETI0JSGIeX3jQQBrlnngZfQxZhbXaKJyqS3QfGf0eit10mqdv5TPR?=
 =?us-ascii?Q?Eu03+PCX/WSesUhxkjqnZhgSd9F2coRYh0UPi7m6PixCszq63csiTNJJEkBq?=
 =?us-ascii?Q?XDfazxMgYP2bxO9yBjRSdlywRZJFm/sVzGTvd6CbP/xmA4+CDOfbtFryv0vJ?=
 =?us-ascii?Q?MpAkwJSmWlGCJRlY/fyVKlPpAknAC3adcgwyFTh+bUnnIOeeAesT7mk7qx/V?=
 =?us-ascii?Q?Coy4HeqjHcVRa9/VBwOXJTnnt7I/FJ07g3fI71R72ZHzeIG9X0Y05jmMJYyM?=
 =?us-ascii?Q?kWyTbmCoLKT3yCkH1FHWkoakOZuBtjcn1i4roafEzS+ne40NWuGM1Vk4oc0h?=
 =?us-ascii?Q?nQphtkDtpVLpGIyvK17DxoJySZBLMGYle0+8Df1HTI06pwSEUdnvJaiHIARk?=
 =?us-ascii?Q?xtpY8kCff1UPxrkkZWdW1zxNItQ94hMxCrW9NyxW21rta7xD8hP6NwRLfJWG?=
 =?us-ascii?Q?8pMN1K+QOnM+qEyiErrSXY+F/DsUuFZxY/cpcIrG4m8HmgTpqPJStyIzIpnh?=
 =?us-ascii?Q?8TmRaC3TUlWeDDbZ8gaPztjJ5+KOEvBs2UfYF5tW/uE3hH4aTXrYd8TF4/5m?=
 =?us-ascii?Q?zT3lNstVaN8XCDj6bgFMPAuLSzCT6xp9gbNkg+7zk+kSBORW5/Ib8CRa0xbi?=
 =?us-ascii?Q?2+B/GKR4Vg9sxf2zS52TWONKjyT2v8Bmx2aDJtKF/e0jAMY52ULOe6T+VLqD?=
 =?us-ascii?Q?8bYdcy+31xCTv2/L3rLWrZ3rlemOPLFIhEUdTpcr8jR822vfBw/OzlpeaY/V?=
 =?us-ascii?Q?qrTb9elqtiBlOg8q6XllSADZrhhhJhpZrUjTgWw63QG5+ZyU6HaGY8h8fxfM?=
 =?us-ascii?Q?4rkNEzugDjPpdXcErjw0f1J20Gx/mMENfiuNS3wQL/qLSPL+0bwmOLpvjNHK?=
 =?us-ascii?Q?HTo5UG1feU7HIg4sxO8f9iRg4FX+EuZ0DCr/AhF82AU4bDD8uGIBZK/z5EKu?=
 =?us-ascii?Q?jtLTozwtgJgZvOECnHI=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 12:21:31.7720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b83cc628-4755-4e02-241d-08de332fa8a3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997570
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

While adding CPSW device support to enable Ethernet boot for J722S,
dev-data and clk-data for eMMC was removed by mistake, which leads to eMMC
boot failure. Update the dev-data and clk-data to fix that.

Fixes: a02009f3a816 ("arm: mach-k3: j722s: Update SoC autogenerated data to enable Ethernet boot")
Reported-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
Tested-by: Michael Walle <mwalle@kernel.org>
---

This patch is based on commit '69c8ea98a713' of origin/master branch of
u-boot.

Link to v2:
https://lore.kernel.org/r/20251201060839.777816-1-c-vankar@ti.com/

Changes from v2 to v3:
- Updated commit message as suggested by Udit Kumar.

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

