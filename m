Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E254CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 11:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0073F88BC2;
	Tue,  3 Sep 2024 13:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vRunY8ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC00188BBE; Tue,  3 Sep 2024 13:44:15 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90BCC88A3A
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 13:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483BiB1D059509;
 Tue, 3 Sep 2024 06:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725363851;
 bh=gn/8uhVGQ+tWsEn6WuzzUI077nFCgNc6zALCwBANZ/E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vRunY8mlHCg3RPYteTobB3rZ7tjIzQse5jDUEwrsLPRhCvXlauyxCMo2xXAhY4amF
 tKEja/zuUtzG95QECYUjagMxlqR22XtKSBNvc5w1eFyQV8FXc+CA2BMxuohSzlHJsd
 Gu/jExyb6Mwa8zQVo2FP6J3+BnjsszbS1jIo+MTU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483BiBPH015397;
 Tue, 3 Sep 2024 06:44:11 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 06:44:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 06:44:10 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483Bi2R3056540;
 Tue, 3 Sep 2024 06:44:07 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [RFC PATCH 1/6] arm: mach-k3: j784s4: Add clk and power support for
 MAIN_R5_2_x PBIST
Date: Tue, 3 Sep 2024 17:13:57 +0530
Message-ID: <20240903114402.2155740-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903114402.2155740-1-n-francis@ti.com>
References: <20240903114402.2155740-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add clock and power domains for MAIN_R5_2_0, MAIN_R5_2_1 and PBIST_14.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/r5/j784s4/clk-data.c | 13 +++++++++++++
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
index 793bcac9324..1a7687d5189 100644
--- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
@@ -82,6 +82,11 @@ static const char * const main_pll_hfosc_sel_out12_parents[] = {
 	"board_0_hfosc1_clk_out",
 };
 
+static const char * const main_pll_hfosc_sel_out14_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
 static const char * const main_pll_hfosc_sel_out19_parents[] = {
 	"gluelogic_hfosc0_clkout",
 	"board_0_hfosc1_clk_out",
@@ -219,6 +224,7 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("main_pll_hfosc_sel_out0", main_pll_hfosc_sel_out0_parents, 2, 0x43008080, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out1", main_pll_hfosc_sel_out1_parents, 2, 0x43008084, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out12", main_pll_hfosc_sel_out12_parents, 2, 0x430080b0, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out14", main_pll_hfosc_sel_out14_parents, 2, 0x430080b8, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out19", main_pll_hfosc_sel_out19_parents, 2, 0x430080cc, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out2", main_pll_hfosc_sel_out2_parents, 2, 0x43008088, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out26_0", main_pll_hfosc_sel_out26_0_parents, 2, 0x430080e8, 0, 1, 0),
@@ -246,6 +252,7 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV("pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk_subdiv", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681038, 16, 3, 0, CLK_DIVIDER_ONE_BASED),
 	CLK_DIV("pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk_subdiv", 0x681038, 24, 3, 0, CLK_DIVIDER_ONE_BASED),
 	CLK_PLL("pllfracf2_ssmod_16fft_main_12_foutvcop_clk", "main_pll_hfosc_sel_out12", 0x68c000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_14_foutvcop_clk", "main_pll_hfosc_sel_out14", 0x68e000, 0),
 	CLK_PLL("pllfracf2_ssmod_16fft_main_19_foutvcop_clk", "main_pll_hfosc_sel_out19", 0x693000, 0),
 	CLK_PLL("pllfracf2_ssmod_16fft_main_2_foutvcop_clk", "main_pll_hfosc_sel_out2", 0x682000, 0),
 	CLK_PLL("pllfracf2_ssmod_16fft_main_26_foutvcop_clk", "main_pll_hfosc_sel_out26_0", 0x69a000, 0),
@@ -267,6 +274,7 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV("hsdiv0_16fft_main_7_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_7_foutvcop_clk", 0x687080, 0, 7, 0, 0),
 	CLK_DIV("hsdiv0_16fft_main_8_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_8_foutvcop_clk", 0x688080, 0, 7, 0, 0),
 	CLK_DIV("hsdiv1_16fft_main_19_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_19_foutvcop_clk", 0x693080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv2_16fft_main_14_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_14_foutvcop_clk", 0x68e088, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_0_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680080, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_0_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680088, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_0_hsdivout3_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x68008c, 0, 7, 0, 0),
@@ -397,6 +405,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(194, 5, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(201, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(201, 1, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(237, 7, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(243, 0, "j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk"),
 	DEV_CLK(243, 1, "gluelogic_hfosc0_clkout"),
 	DEV_CLK(243, 2, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
@@ -405,6 +414,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(279, 2, "wkup_i2c_mcupll_bypass_out0"),
 	DEV_CLK(279, 3, "hsdiv4_16fft_mcu_1_hsdivout3_clk"),
 	DEV_CLK(279, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(343, 0, "hsdiv2_16fft_main_14_hsdivout2_clk"),
+	DEV_CLK(343, 1, "hsdiv2_16fft_main_14_hsdivout2_clk"),
+	DEV_CLK(344, 0, "hsdiv2_16fft_main_14_hsdivout2_clk"),
+	DEV_CLK(344, 1, "hsdiv2_16fft_main_14_hsdivout2_clk"),
 	DEV_CLK(392, 0, "usart_programmable_clock_divider_out5"),
 	DEV_CLK(392, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(395, 0, "usart_programmable_clock_divider_out8"),
diff --git a/arch/arm/mach-k3/r5/j784s4/dev-data.c b/arch/arm/mach-k3/r5/j784s4/dev-data.c
index d66ba8b16e0..843b9a2df36 100644
--- a/arch/arm/mach-k3/r5/j784s4/dev-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/dev-data.c
@@ -25,6 +25,7 @@ static struct ti_pd soc_pd_list[] = {
 	[5] = PSC_PD(15, &soc_psc_list[2], &soc_pd_list[4]),
 	[6] = PSC_PD(16, &soc_psc_list[2], &soc_pd_list[4]),
 	[7] = PSC_PD(38, &soc_psc_list[2], NULL),
+	[8] = PSC_PD(39, &soc_psc_list[2], NULL),
 };
 
 static struct ti_lpsc soc_lpsc_list[] = {
@@ -51,6 +52,9 @@ static struct ti_lpsc soc_lpsc_list[] = {
 	[20] = PSC_LPSC(81, &soc_psc_list[2], &soc_pd_list[6], &soc_lpsc_list[18]),
 	[21] = PSC_LPSC(120, &soc_psc_list[2], &soc_pd_list[7], &soc_lpsc_list[22]),
 	[22] = PSC_LPSC(121, &soc_psc_list[2], &soc_pd_list[7], NULL),
+	[23] = PSC_LPSC(122, &soc_psc_list[2], &soc_pd_list[8], NULL),
+	[24] = PSC_LPSC(123, &soc_psc_list[2], &soc_pd_list[8], NULL),
+	[25] = PSC_LPSC(124, &soc_psc_list[2], &soc_pd_list[8], &soc_lpsc_list[24]),
 };
 
 static struct ti_dev soc_dev_list[] = {
@@ -84,6 +88,9 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(203, &soc_lpsc_list[20]),
 	PSC_DEV(133, &soc_lpsc_list[21]),
 	PSC_DEV(193, &soc_lpsc_list[22]),
+	PSC_DEV(343, &soc_lpsc_list[23]),
+	PSC_DEV(344, &soc_lpsc_list[24]),
+	PSC_DEV(237, &soc_lpsc_list[25]),
 };
 
 const struct ti_k3_pd_platdata j784s4_pd_platdata = {
-- 
2.34.1

