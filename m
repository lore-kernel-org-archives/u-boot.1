Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF537CFB441
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA7788B3F;
	Mon,  7 Oct 2024 15:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aRknYyX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9ACB888EB; Mon,  7 Oct 2024 13:08:34 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67890886B1
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 13:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-kapoor@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 497B7Brl008643;
 Mon, 7 Oct 2024 06:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728299231;
 bh=lq94D8c2MItvbm7iW/hp5T0bOagrJuowMPt4c0WdY94=;
 h=From:To:CC:Subject:Date;
 b=aRknYyX3eoTwp+kxI4SHE4NqBls9Q0GlgvDN7UjyjH8NXRqIWPQaERfGcMOaYBEqg
 /TZV0YyttnoU58REf3LIHk8+k64hTLuGigbKQUylvvwj+/kL1OuHY/w9WC0q48fkNo
 39mkwx+AOyCITngsT1N9FwKvbOYoJot68bazNGeQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 497B7BAO039151
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Oct 2024 06:07:11 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 06:07:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 06:07:10 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.68.216])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 497B7AXU034009;
 Mon, 7 Oct 2024 06:07:10 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <u-boot@lists.denx.de>
CC: <afd@ti.com>, <b-kapoor@ti.com>, <rogerq@kernel.org>,
 <emanuele.ghidoli@toradex.com>, <hnagalla@ti.com>, <a-nandan@ti.com>,
 <bb@ti.com>, <trini@konsulko.com>
Subject: [PATCH] arm: mach-k3: j784s4: Add clk and power support for wkup_uart
Date: Mon, 7 Oct 2024 16:37:09 +0530
Message-ID: <20241007110709.3335579-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 07 Oct 2024 15:25:58 +0200
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

Add clk and device data which can be used by wkup_uart driver
to configure clocks and PSC.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm/mach-k3/r5/j784s4/clk-data.c | 18 +++++++++++++++++-
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
index 793bcac932..97d969271e 100644
--- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
@@ -67,6 +67,16 @@ static const char * const wkup_i2c_mcupll_bypass_out0_parents[] = {
 	"gluelogic_hfosc0_clkout",
 };
 
+static const char * const wkup_usart_clksel_out0_parents[] = {
+	"hsdiv4_16fft_mcu_1_hsdivout3_clk",
+	"postdiv3_16fft_main_1_hsdivout5_clk",
+};
+
+static const char * const wkup_usart_mcupll_bypass_out0_parents[] = {
+	"wkup_usart_clksel_out0",
+	"gluelogic_hfosc0_clkout",
+};
+
 static const char * const main_pll_hfosc_sel_out0_parents[] = {
 	"gluelogic_hfosc0_clkout",
 	"board_0_hfosc1_clk_out",
@@ -206,7 +216,7 @@ static const struct clk_data clk_list[] = {
 	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_mcu_1_foutvcop_clk", "wkup_fref_clksel_out0", 0x40d01000, 0, 2400000000),
 	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", "wkup_fref_clksel_out0", 0x40d02000, 0, 2000000000),
 	CLK_DIV("hsdiv1_16fft_mcu_0_hsdivout0_clk", "pllfracf2_ssmod_16fft_mcu_0_foutvcop_clk", 0x40d00080, 0, 7, 0, 0),
-	CLK_DIV("hsdiv4_16fft_mcu_1_hsdivout3_clk", "pllfracf2_ssmod_16fft_mcu_1_foutvcop_clk", 0x40d0108c, 0, 7, 0, 0),
+	CLK_DIV_DEFFREQ("hsdiv4_16fft_mcu_1_hsdivout3_clk", "pllfracf2_ssmod_16fft_mcu_1_foutvcop_clk", 0x40d0108c, 0, 7, 0, 0, 96000000),
 	CLK_DIV("hsdiv4_16fft_mcu_1_hsdivout4_clk", "pllfracf2_ssmod_16fft_mcu_1_foutvcop_clk", 0x40d01090, 0, 7, 0, 0),
 	CLK_DIV_DEFFREQ("hsdiv4_16fft_mcu_2_hsdivout4_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02090, 0, 7, 0, 0, 166666666),
 	CLK_MUX_PLLCTRL("k3_pll_ctrl_wrap_wkup_0_sysclkout_clk", k3_pll_ctrl_wrap_wkup_0_sysclkout_clk_parents, 2, 0x42010000, 0),
@@ -216,6 +226,8 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("wkup_gpio0_clksel_out0", wkup_gpio0_clksel_out0_parents, 4, 0x43008070, 0, 2, 0),
 	CLK_MUX("mcu_usart_clksel_out0", mcu_usart_clksel_out0_parents, 2, 0x40f081c0, 0, 1, 0),
 	CLK_MUX("wkup_i2c_mcupll_bypass_out0", wkup_i2c_mcupll_bypass_out0_parents, 2, 0x43008060, 0, 1, 0),
+	CLK_MUX("wkup_usart_clksel_out0", wkup_usart_clksel_out0_parents, 2, 0x43008064, 0, 1, 0),
+	CLK_MUX("wkup_usart_mcupll_bypass_out0", wkup_usart_mcupll_bypass_out0_parents, 2, 0x43008060, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out0", main_pll_hfosc_sel_out0_parents, 2, 0x43008080, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out1", main_pll_hfosc_sel_out1_parents, 2, 0x43008084, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out12", main_pll_hfosc_sel_out12_parents, 2, 0x430080b0, 0, 1, 0),
@@ -409,6 +421,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(392, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(395, 0, "usart_programmable_clock_divider_out8"),
 	DEV_CLK(395, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(397, 0, "wkup_usart_mcupll_bypass_out0"),
+	DEV_CLK(397, 1, "wkup_usart_clksel_out0"),
+	DEV_CLK(397, 2, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(397, 7, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
 	DEV_CLK(398, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(398, 1, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(398, 2, "postdiv3_16fft_main_1_hsdivout7_clk"),
diff --git a/arch/arm/mach-k3/r5/j784s4/dev-data.c b/arch/arm/mach-k3/r5/j784s4/dev-data.c
index d66ba8b16e..b32b4ba958 100644
--- a/arch/arm/mach-k3/r5/j784s4/dev-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/dev-data.c
@@ -62,6 +62,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(149, &soc_lpsc_list[0]),
 	PSC_DEV(167, &soc_lpsc_list[1]),
 	PSC_DEV(279, &soc_lpsc_list[1]),
+	PSC_DEV(397, &soc_lpsc_list[1]),
 	PSC_DEV(161, &soc_lpsc_list[2]),
 	PSC_DEV(162, &soc_lpsc_list[3]),
 	PSC_DEV(160, &soc_lpsc_list[4]),
-- 
2.34.1

