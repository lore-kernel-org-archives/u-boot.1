Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D86FEDA09
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 01:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0908784114;
	Wed, 18 Mar 2026 02:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LGoCIysg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEBA78419E; Tue, 17 Mar 2026 23:40:36 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F79840CF
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 23:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmU/du7fOIdiZOM4a/zknohT4Jt8WPZ7MTD18oa7e2vCa8pxWimJZPFJY30ICs0yYRbYvZ90uXQOO9nAjw9ymGI6liZu77bB2DlI2MSRl6x8jwFEvU43ZAB8IBGkjo93g4EnxsPYqPSa3bka08qMjSi3s7WLiVJputY5t00OgjLsLv+yJoiHzfW43g+ZohT03OusvG4yFixW+urkA0NTSttvrhdjcHAFsSofHrX5YhqzsxjgEw2lv2e6TPsI5P0Z5vBTQeQ2bOMgSbfakcWypfn2Aou4A14gQ4orYfHA11Z3MQENhkvm3G4uuydlK8hbfcpxepXOxOar80yUCFGzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQO1gzHTkm5aqj91X6T0qIMxZJETFFEEif9jfps0bJc=;
 b=flWo9pIus5k7zICpVMKBlUonybo+8NX7jdxU5Gv/fp7s2+t2PRF76Jia4sHbWi5ta77pu3RIr6S3y0IO1oUMY63EBPQu9JktcBPOdB6iSum62l7Ue2hUew4y+u/wIy1zafKPL0PJxSurVFzdplPYXARxZLyu4RqIikmBDDEyHlR9qaKLqOGt802++MZX8OzQycEbuhqtWg4JC5EPl1LklLL4zrAmNYCMsj7b+CJQJhUmHQq2MbNDu1zGpPHriJ3S73Fk0IH4a1qN9thuG8MpdD54/OzS7WOI+OmySyUtrLXG+3JCzLIUdSz/m0V4LfrsWhE0aPCpF2f6Hmt4HM/FUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQO1gzHTkm5aqj91X6T0qIMxZJETFFEEif9jfps0bJc=;
 b=LGoCIysgRHsjKkX3jWdnaC4Rrc2qWZyAGKf3DcnT28uDUFF+eb+EdjAmQ+CcXDGytasKb16GOnu7yNnruqKahFbd1XghN84XuljWGvMdPE62nlcTWikzgEFGLnPcUeXzm7jy6olnPl7SsfK7vY/d6b0CqkSBY4RqBjLPK9Yc+Kc=
Received: from BN9PR03CA0290.namprd03.prod.outlook.com (2603:10b6:408:f5::25)
 by CY8PR10MB6562.namprd10.prod.outlook.com (2603:10b6:930:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 22:38:45 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::fe) by BN9PR03CA0290.outlook.office365.com
 (2603:10b6:408:f5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 22:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 22:38:45 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 17:38:38 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 17:38:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 17:38:37 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62HMcb4k3952594;
 Tue, 17 Mar 2026 17:38:37 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <bb@ti.com>, <nm@ti.com>, <trini@konsulko.com>, 
 <afd@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 1/3] arm: mach-k3: am62: add &main_uart6 to clock and pwr tree
Date: Tue, 17 Mar 2026 17:37:58 -0500
Message-ID: <20260317223800.776581-2-rs@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317223800.776581-1-rs@ti.com>
References: <20260317223800.776581-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|CY8PR10MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbbfa93-bb34-44d9-4839-08de8475f2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: GlHIvLvtAQcoNihGvVNNUWVUqlTLIh7tNrpeWShBoajbDOO7tQKuws+flY/vQxE9m0JmbJndOjAXSvAq9P4l2UoIrHVBdFrp1uwbvLyN3vDX/L2139A88Pi56VbCX0gcojGEb0yOgvqA1wukBK81MhJLvPFhMFaP3Qax/Bj4wmPTpBoj92fO+QOh6nu3wn7FE6Naqbki3IJ0AkuJ8pPdgchopQ2HpsimRQHJD5TpiPc2IpTEhB/bXMrQ/nbAMhyX+XlpCSXYYCqu2Fx7nO9QbDdDz17nu1ei8KMrbekNjGeUh/CZqEAXucnB6yaYg8DPcBnIwpuZfxyz2BI8EJkhfUHKWK7I/7617F5NqIJaQSr0RcutzDcqlnTqmvr6q+4kY73JrZ+95JuDq0DIyRcpf9wuy1eaEO4rUIqTr2Ga4LR6dTPuDWk8ibAMeyyBAlE82UB0lWUV90WkIN1G4DhIenheB7GrOBtc+NMJ00jqSVLVhOFCKyTgdM1R+L5A8dIyc5G6gSdC5N2ClUypWKMPN5YABREvMjNeMv1JKEE9PnEDlfOC/W2dgKhB4ggm9DqmcyJ2u4aTZSy4l82SAhroRyIvls2UYqj5ObbRgFk/SKJnoRTiAZuIvRg8Dlwgn4bJ6ElEzbMOMaliWtpDlZ53WlH6g4goVldJSDrfk38+oy3uk+l4MKj6Wr8kKWcW2zoceCZqttN1R9qIHF2O/QInashU8SK/NyatBm5xxiVlXuU=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bOqo6qfAic/vX10RcGqnHVPr9+qqxrnEqEW2yzsFmMe7Zw9GX14OPL4/LgtLehFnD375ERWCqAi8pxaPtmRlI/6EThJYiTj2GMclRf/DXZNr8sRW2ozjvd0J27B6Ds316BHdCw8Gw/DsfVhI6XmG6U5eM8fzkMZ3yr/XOL4TWp0M9AuURpASaZBIZ5LI5+j/ZgaaTeAVd0peYNjf2fjkvkUeFm+tonO9dvgES+btho9UfRmUVFxINTP8pScCvyEKW/W/tCMp+JLhNeMkoVA6xDQkfqCwe95TM9lVI6VEWj9DeS6ygtUJIPLa7Mc411lAp+V4NMXOhdSpYalulx3ot6ryIo4hCk1aLb1UObQGxqJ4WovD9gz/fWIfPXgOLMQywmI6kA8fR8+hmlWia1aFN2OPUVVxQaWBA409l4qP9z+9rCSN9yanAGk1ecjzQUtS
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 22:38:45.0691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbbfa93-bb34-44d9-4839-08de8475f2be
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6562
X-Mailman-Approved-At: Wed, 18 Mar 2026 02:21:10 +0100
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

From: Bryan Brattlof <bb@ti.com>

The pocketbeagle2 uses the main_uart6 as the debug console. To get debug
console prints at the R5 SPL stage, add the &main_uart6 to the R5 clk
and dev data so we can configure the uart as early as possible during
the bootup of the pocketbeagle2

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/r5/am62x/clk-data.c | 19 +++++++++++++++----
 arch/arm/mach-k3/r5/am62x/dev-data.c |  5 +++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62x/clk-data.c b/arch/arm/mach-k3/r5/am62x/clk-data.c
index d7bfed0e031..05cced0b313 100644
--- a/arch/arm/mach-k3/r5/am62x/clk-data.c
+++ b/arch/arm/mach-k3/r5/am62x/clk-data.c
@@ -3,9 +3,9 @@
  * AM62X specific clock platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -125,6 +125,11 @@ static const char * const main_usart0_fclk_sel_out0_parents[] = {
 	"hsdiv4_16fft_main_1_hsdivout1_clk",
 };
 
+static const char * const main_usart6_fclk_sel_out0_parents[] = {
+	"usart_programmable_clock_divider_out6",
+	"hsdiv4_16fft_main_1_hsdivout1_clk",
+};
+
 static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("osc_26_mhz", 26000000, 0),
 	CLK_FIXED_RATE("osc_25_mhz", 25000000, 0),
@@ -210,9 +215,11 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
 	CLK_MUX("main_ospi_ref_clk_sel_out0", main_ospi_ref_clk_sel_out0_parents, 2, 0x108500, 0, 1, 0),
 	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108240, 0, 2, 0, 0, 48000000),
+	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out6", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108258, 0, 2, 0, 0, 48000000),
 	CLK_MUX("wkup_clkout_sel_out0", wkup_clkout_sel_out0_parents, 8, 0x43008020, 0, 3, 0),
 	CLK_MUX("wkup_clksel_out0", wkup_clksel_out0_parents, 2, 0x43008010, 0, 1, 0),
 	CLK_MUX("main_usart0_fclk_sel_out0", main_usart0_fclk_sel_out0_parents, 2, 0x108280, 0, 1, 0),
+	CLK_MUX("main_usart6_fclk_sel_out0", main_usart6_fclk_sel_out0_parents, 2, 0x108298, 0, 1, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout1_clk", "pllfracf_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040084, 0, 7, 0, 0),
 	CLK_FIXED_RATE("mshsi2c_wkup_0_porscl", 0, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
@@ -336,6 +343,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 164, "clk_32k_rc_sel_out0"),
 	DEV_CLK(157, 165, "gluelogic_rcosc_clkout"),
 	DEV_CLK(157, 166, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(158, 0, "main_usart6_fclk_sel_out0"),
+	DEV_CLK(158, 1, "usart_programmable_clock_divider_out6"),
+	DEV_CLK(158, 2, "hsdiv4_16fft_main_1_hsdivout1_clk"),
+	DEV_CLK(158, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 2, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
@@ -361,7 +372,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 
 const struct ti_k3_clk_platdata am62x_clk_platdata = {
 	.clk_list = clk_list,
-	.clk_list_cnt = 90,
+	.clk_list_cnt = 92,
 	.soc_dev_clk_data = soc_dev_clk_data,
-	.soc_dev_clk_data_cnt = 137,
+	.soc_dev_clk_data_cnt = 140,
 };
diff --git a/arch/arm/mach-k3/r5/am62x/dev-data.c b/arch/arm/mach-k3/r5/am62x/dev-data.c
index 59c95df2a88..ea1e76a8a75 100644
--- a/arch/arm/mach-k3/r5/am62x/dev-data.c
+++ b/arch/arm/mach-k3/r5/am62x/dev-data.c
@@ -3,9 +3,9 @@
  * AM62X specific device platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-dev.h"
@@ -61,6 +61,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(36, &soc_lpsc_list[11]),
 	PSC_DEV(102, &soc_lpsc_list[11]),
 	PSC_DEV(146, &soc_lpsc_list[11]),
+	PSC_DEV(158, &soc_lpsc_list[11]),
 	PSC_DEV(13, &soc_lpsc_list[12]),
 	PSC_DEV(166, &soc_lpsc_list[13]),
 	PSC_DEV(135, &soc_lpsc_list[14]),
-- 
2.53.0

