Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7648DC87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 08:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE367835A2;
	Thu, 31 Jul 2025 10:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vam4yo4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1006F8343F; Thu, 31 Jul 2025 10:02:01 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF7283423
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 10:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V81jEk2983956;
 Thu, 31 Jul 2025 03:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753948905;
 bh=DAxU4mvn+SMpwk00DAQfnu3T0VGhikjr7IUFLQiJVVI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vam4yo4F42vjkwp6AF18OGCfnGLQH1X9Opp6YTAjJsEB1lmWl1BWSEfSVWZRoLCFz
 bJeb6Nr3ONZko+rKrBtqxDhH8p5TDkBZkdCKNkSZk60C7UT1dY2XOHXADrdg22OI4d
 Rt5FY62CFO3+3eK4oRb7NDj815ERafE2We3+yYHY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V81jG63806386
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 03:01:45 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 03:01:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 03:01:44 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V80ERf2572556;
 Thu, 31 Jul 2025 03:00:15 -0500
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
Subject: [PATCH v4 05/21] arm: mach-k3: j721s2: Update SoC auto-gen data to
 enable Ethernet boot
Date: Thu, 31 Jul 2025 13:29:40 +0530
Message-ID: <20250731075956.605474-6-c-vankar@ti.com>
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
enable Ethernet boot.

Reviewed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v3:
https://lore.kernel.org/u-boot/20250225114903.2080616-4-c-vankar@ti.com/

Changes from v3 to v4:
- Updated commit message.

 arch/arm/mach-k3/r5/j721s2/clk-data.c | 58 +++++++++++++++++++++++++--
 arch/arm/mach-k3/r5/j721s2/dev-data.c |  3 +-
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/r5/j721s2/clk-data.c b/arch/arm/mach-k3/r5/j721s2/clk-data.c
index 0c5c321c1eb..0130c9c4b86 100644
--- a/arch/arm/mach-k3/r5/j721s2/clk-data.c
+++ b/arch/arm/mach-k3/r5/j721s2/clk-data.c
@@ -5,7 +5,7 @@
  * This file is auto generated. Please do not hand edit and report any issues
  * to Dave Gerlach <d-gerlach@ti.com>.
  *
- * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -55,6 +55,32 @@ static const char * const mcu_ospi_ref_clk_sel_out1_parents[] = {
 	"hsdiv4_16fft_mcu_2_hsdivout4_clk",
 };
 
+static const char * const wkup_gpio0_clksel_out0_parents[] = {
+	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
+	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
+	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_32k_clk",
+	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk",
+};
+
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
@@ -174,7 +200,11 @@ static const struct clk_data clk_list[] = {
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
@@ -199,6 +229,8 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV("k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk", "k3_pll_ctrl_wrap_wkup_0_sysclkout_clk", 0x42010118, 0, 5, 0, 0),
 	CLK_MUX("mcu_ospi_ref_clk_sel_out0", mcu_ospi_ref_clk_sel_out0_parents, 2, 0x40f08030, 0, 1, 0),
 	CLK_MUX("mcu_ospi_ref_clk_sel_out1", mcu_ospi_ref_clk_sel_out1_parents, 2, 0x40f08034, 0, 1, 0),
+	CLK_MUX("wkup_gpio0_clksel_out0", wkup_gpio0_clksel_out0_parents, 4, 0x43008070, 0, 2, 0),
+	CLK_MUX("cpsw2g_cpts_rclk_sel_out0", cpsw2g_cpts_rclk_sel_out0_parents, 16, 0x40f08050, 8, 4, 0),
 	CLK_MUX("mcu_usart_clksel_out0", mcu_usart_clksel_out0_parents, 2, 0x40f081c0, 0, 1, 0),
 	CLK_MUX("wkup_i2c_mcupll_bypass_out0", wkup_i2c_mcupll_bypass_out0_parents, 2, 0x43008060, 0, 1, 0),
 	CLK_MUX("main_pll_hfosc_sel_out0", main_pll_hfosc_sel_out0_parents, 2, 0x43008080, 0, 1, 0),
@@ -275,6 +307,24 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(4, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
 	DEV_CLK(4, 1, "hsdiv0_16fft_main_7_hsdivout0_clk"),
 	DEV_CLK(4, 2, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(29, 3, "cpsw2g_cpts_rclk_sel_out0"),
+	DEV_CLK(29, 4, "hsdiv4_16fft_main_3_hsdivout1_clk"),
+	DEV_CLK(29, 5, "postdiv3_16fft_main_0_hsdivout6_clk"),
+	DEV_CLK(29, 6, "board_0_mcu_cpts0_rft_clk_out"),
+	DEV_CLK(29, 7, "board_0_cpts0_rft_clk_out"),
+	DEV_CLK(29, 8, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(29, 9, "board_0_ext_refclk1_out"),
+	DEV_CLK(29, 18, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
+	DEV_CLK(29, 19, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(29, 20, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(29, 21, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(29, 22, "board_0_mcu_rgmii1_rxc_out"),
+	DEV_CLK(29, 26, "board_0_mcu_rmii1_ref_clk_out"),
+	DEV_CLK(29, 28, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(29, 29, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(29, 30, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(29, 32, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(29, 33, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
 	DEV_CLK(43, 0, "postdiv3_16fft_main_0_hsdivout8_clk"),
 	DEV_CLK(43, 1, "hsdiv4_16fft_main_0_hsdivout3_clk"),
 	DEV_CLK(43, 2, "gluelogic_hfosc0_clkout"),
@@ -367,6 +417,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 187, "fss_mcu_0_ospi_1_ospi_oclk_clk"),
 	DEV_CLK(157, 194, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 197, "j7am_ddr_ew_wrap_dv_wrap_main_0_ddrss_io_ck_n"),
+	DEV_CLK(157, 207, "cpsw_2guss_mcu_0_mdio_mdclk_o"),
 	DEV_CLK(157, 208, "j7am_ddr_ew_wrap_dv_wrap_main_1_ddrss_io_ck_n"),
 	DEV_CLK(157, 214, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_p"),
 	DEV_CLK(157, 221, "mcu_clkout_mux_out0"),
@@ -374,6 +425,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 223, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
 	DEV_CLK(157, 225, "emmc8ss_16ffc_main_0_emmcss_io_clk"),
 	DEV_CLK(157, 231, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n"),
+	DEV_CLK(157, 244, "cpsw_2guss_mcu_0_rgmii1_txc_o"),
 	DEV_CLK(157, 352, "dpi0_ext_clksel_out0"),
 	DEV_CLK(180, 0, "gluelogic_hfosc0_clkout"),
 	DEV_CLK(180, 2, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
@@ -400,7 +452,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 
 const struct ti_k3_clk_platdata j721s2_clk_platdata = {
 	.clk_list = clk_list,
-	.clk_list_cnt = 105,
+	.clk_list_cnt = ARRAY_SIZE(clk_list),
 	.soc_dev_clk_data = soc_dev_clk_data,
-	.soc_dev_clk_data_cnt = 124,
+	.soc_dev_clk_data_cnt = ARRAY_SIZE(soc_dev_clk_data),
 };
diff --git a/arch/arm/mach-k3/r5/j721s2/dev-data.c b/arch/arm/mach-k3/r5/j721s2/dev-data.c
index df70c5e5d7c..b78550707c5 100644
--- a/arch/arm/mach-k3/r5/j721s2/dev-data.c
+++ b/arch/arm/mach-k3/r5/j721s2/dev-data.c
@@ -5,7 +5,7 @@
  * This file is auto generated. Please do not hand edit and report any issues
  * to Dave Gerlach <d-gerlach@ti.com>.
  *
- * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-dev.h"
@@ -47,6 +47,7 @@ static struct ti_lpsc soc_lpsc_list[] = {
 };
 
 static struct ti_dev soc_dev_list[] = {
+	PSC_DEV(29, &soc_lpsc_list[0]),
 	PSC_DEV(35, &soc_lpsc_list[0]),
 	PSC_DEV(108, &soc_lpsc_list[0]),
 	PSC_DEV(109, &soc_lpsc_list[0]),
-- 
2.34.1

