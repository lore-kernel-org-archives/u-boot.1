Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433D3C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 08:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDD68349B;
	Thu, 31 Jul 2025 10:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kBycJ6Bg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E4583444; Thu, 31 Jul 2025 10:01:58 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 635AF83414
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 10:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V81jfc2955329;
 Thu, 31 Jul 2025 03:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753948905;
 bh=ldeFiRPO+bmzBPsdpzauQqZplQ6WYpEl93IwbADTfFw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kBycJ6BgX8zDpPqkGsbE4KiOpQ3BvIoNzoqSeT7Htajd97Mz6BvvN4c5HHJiSDtfb
 uiArSGBCMqkMtZ2gJf2GD46/qc6E243TUWTf7QSygQCjlfIhvK8cWGNC8+mV6wEzYM
 WefsZLksOyeNZzNwsvW5TnyJJaUR2sFnGV3JmkeI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V81jHl2549232
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 03:01:45 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:01:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:01:44 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V80dIl2573731;
 Thu, 31 Jul 2025 03:00:40 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Richard Genoud <richard.genoud@bootlin.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Santhosh Kumar K <s-k6@ti.com>, "Jonathan
 Humphreys" <j-humphreys@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bhavya Kapoor <b-kapoor@ti.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>, Sughosh
 Ganu <sughosh.ganu@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, "Simon Glass" <sjg@chromium.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 18/21] arm: mach-k3: j784s4: Update SoC auto-gen data to
 enable Ethernet boot
Date: Thu, 31 Jul 2025 13:29:53 +0530
Message-ID: <20250731075956.605474-19-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731075956.605474-1-c-vankar@ti.com>
References: <20250731075956.605474-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 31 Jul 2025 10:19:27 +0200
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

Update dev-data and clk-data to include CPSW device which is required to
enable Ethernet boot for SK-AM69.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is newly introduced in this series.

 arch/arm/mach-k3/r5/j784s4/clk-data.c | 54 ++++++++++++++++++++++++---
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  1 +
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
index 97d969271ec..24780eb6562 100644
--- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
@@ -57,6 +57,25 @@ static const char * const wkup_gpio0_clksel_out0_parents[] = {
 	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk",
 };
 
+static const char * const cpsw2g_cpts_rclk_sel_out0_parents[] = {
+	"hsdiv4_16fft_main_3_hsdivout1_clk",
+	"postdiv3_16fft_main_0_hsdivout6_clk",
+	"board_0_mcu_cpts0_rft_clk_out",
+	"board_0_cpts0_rft_clk_out",
+	"board_0_mcu_ext_refclk0_out",
+	"board_0_ext_refclk1_out",
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
+	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
+};
+
 static const char * const mcu_usart_clksel_out0_parents[] = {
 	"hsdiv4_16fft_mcu_1_hsdivout3_clk",
 	"postdiv3_16fft_main_1_hsdivout5_clk",
@@ -132,6 +151,11 @@ static const char * const main_pll_hfosc_sel_out8_parents[] = {
 	"board_0_hfosc1_clk_out",
 };
 
+static const char * const mcu_clkout_mux_out0_parents[] = {
+	"hsdiv4_16fft_mcu_2_hsdivout0_clk",
+	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
+};
+
 static const char * const usb0_refclk_sel_out0_parents[] = {
 	"gluelogic_hfosc0_clkout",
 	"board_0_hfosc1_clk_out",
@@ -142,11 +166,6 @@ static const char * const emmcsd1_lb_clksel_out0_parents[] = {
 	"board_0_mmc1_clk_out",
 };
 
-static const char * const mcu_clkout_mux_out0_parents[] = {
-	"hsdiv4_16fft_mcu_2_hsdivout0_clk",
-	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
-};
-
 static const char * const k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents[] = {
 	"main_pll_hfosc_sel_out0",
 	"hsdiv4_16fft_main_0_hsdivout0_clk",
@@ -201,7 +220,11 @@ static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("board_0_hfosc1_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mcu_ospi0_dqs_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mcu_ospi1_dqs_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mcu_rgmii1_rxc_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mcu_rmii1_ref_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_wkup_i2c0_scl_out", 0, 0),
+	CLK_FIXED_RATE("cpsw_2guss_mcu_0_mdio_mdclk_o", 0, 0),
+	CLK_FIXED_RATE("cpsw_2guss_mcu_0_rgmii1_txc_o", 0, 0),
 	CLK_FIXED_RATE("fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n", 0, 0),
 	CLK_FIXED_RATE("fss_mcu_0_hyperbus1p0_0_hpb_out_clk_p", 0, 0),
 	CLK_FIXED_RATE("fss_mcu_0_ospi_0_ospi_oclk_clk", 0, 0),
@@ -224,6 +247,7 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("mcu_ospi_ref_clk_sel_out0", mcu_ospi_ref_clk_sel_out0_parents, 2, 0x40f08030, 0, 1, 0),
 	CLK_MUX("mcu_ospi_ref_clk_sel_out1", mcu_ospi_ref_clk_sel_out1_parents, 2, 0x40f08034, 0, 1, 0),
 	CLK_MUX("wkup_gpio0_clksel_out0", wkup_gpio0_clksel_out0_parents, 4, 0x43008070, 0, 2, 0),
+	CLK_MUX("cpsw2g_cpts_rclk_sel_out0", cpsw2g_cpts_rclk_sel_out0_parents, 16, 0x40f08050, 8, 4, 0),
 	CLK_MUX("mcu_usart_clksel_out0", mcu_usart_clksel_out0_parents, 2, 0x40f081c0, 0, 1, 0),
 	CLK_MUX("wkup_i2c_mcupll_bypass_out0", wkup_i2c_mcupll_bypass_out0_parents, 2, 0x43008060, 0, 1, 0),
 	CLK_MUX("wkup_usart_clksel_out0", wkup_usart_clksel_out0_parents, 2, 0x43008064, 0, 1, 0),
@@ -317,6 +341,24 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(61, 15, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
 	DEV_CLK(61, 16, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(61, 17, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(63, 0, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(63, 3, "cpsw2g_cpts_rclk_sel_out0"),
+	DEV_CLK(63, 4, "hsdiv4_16fft_main_3_hsdivout1_clk"),
+	DEV_CLK(63, 5, "postdiv3_16fft_main_0_hsdivout6_clk"),
+	DEV_CLK(63, 6, "board_0_mcu_cpts0_rft_clk_out"),
+	DEV_CLK(63, 7, "board_0_cpts0_rft_clk_out"),
+	DEV_CLK(63, 8, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(63, 9, "board_0_ext_refclk1_out"),
+	DEV_CLK(63, 18, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
+	DEV_CLK(63, 19, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(63, 20, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(63, 21, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(63, 22, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(63, 24, "board_0_mcu_rgmii1_rxc_out"),
+	DEV_CLK(63, 27, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(63, 28, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(63, 29, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(63, 30, "board_0_mcu_rmii1_ref_clk_out"),
 	DEV_CLK(78, 0, "postdiv3_16fft_main_0_hsdivout8_clk"),
 	DEV_CLK(78, 1, "hsdiv4_16fft_main_0_hsdivout2_clk"),
 	DEV_CLK(78, 2, "hsdiv4_16fft_main_0_hsdivout3_clk"),
@@ -353,10 +395,12 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 176, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
 	DEV_CLK(157, 179, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_p"),
 	DEV_CLK(157, 180, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n"),
+	DEV_CLK(157, 190, "cpsw_2guss_mcu_0_mdio_mdclk_o"),
 	DEV_CLK(157, 224, "fss_mcu_0_ospi_0_ospi_oclk_clk"),
 	DEV_CLK(157, 226, "fss_mcu_0_ospi_0_ospi_oclk_clk"),
 	DEV_CLK(157, 228, "fss_mcu_0_ospi_1_ospi_oclk_clk"),
 	DEV_CLK(157, 230, "fss_mcu_0_ospi_1_ospi_oclk_clk"),
+	DEV_CLK(157, 233, "cpsw_2guss_mcu_0_rgmii1_txc_o"),
 	DEV_CLK(157, 239, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 243, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 245, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
diff --git a/arch/arm/mach-k3/r5/j784s4/dev-data.c b/arch/arm/mach-k3/r5/j784s4/dev-data.c
index b32b4ba9588..19901821225 100644
--- a/arch/arm/mach-k3/r5/j784s4/dev-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/dev-data.c
@@ -54,6 +54,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
 };
 
 static struct ti_dev soc_dev_list[] = {
+	PSC_DEV(63, &soc_lpsc_list[0]),
 	PSC_DEV(35, &soc_lpsc_list[0]),
 	PSC_DEV(160, &soc_lpsc_list[0]),
 	PSC_DEV(161, &soc_lpsc_list[0]),
-- 
2.34.1

