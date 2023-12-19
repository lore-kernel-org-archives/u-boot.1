Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7482C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 19:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CA1876CF;
	Tue, 19 Dec 2023 20:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OPni0rSq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A5787603; Tue, 19 Dec 2023 20:16:38 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78489876F3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJGNqF103883;
 Tue, 19 Dec 2023 13:16:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703013383;
 bh=y7RnKAOow+hxs56C1V835iDAdFB95XOKYqx5Kn1SD6s=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=OPni0rSqHpkby26dfIsYxtzMPFbYqOnNryZ74Q18W3Tscc4BpOrIb6oYJdkw1qIMy
 JUzAcU9ff8FwNsvYi0UxROTFWZXHk/A7oJ0QXIwtSGHoJ+fooc88L9F63PdCZsixEx
 goW0EEu+6Y7UchEHbBVOiB6qBaV3TZXlm+rubrlk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJJGMJi011832
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 13:16:23 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 13:16:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 13:16:23 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.69.34] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJFcAF065909;
 Tue, 19 Dec 2023 13:16:17 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v7 06/17] arm: mach-k3: j784s4: Add clk and power support
Date: Wed, 20 Dec 2023 00:45:26 +0530
Message-ID: <20231219191537.4039361-7-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191537.4039361-1-a-nandan@ti.com>
References: <20231219191537.4039361-1-a-nandan@ti.com>
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

Add clk and device data which can be used by respective drivers
to configure clocks and PSC.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---
 arch/arm/mach-k3/r5/j784s4/Makefile    |   7 +
 arch/arm/mach-k3/r5/j784s4/clk-data.c  | 428 +++++++++++++++++++++++++
 arch/arm/mach-k3/r5/j784s4/dev-data.c  |  98 ++++++
 drivers/clk/ti/clk-k3.c                |   6 +
 drivers/power/domain/ti-power-domain.c |   6 +
 include/k3-clk.h                       |   1 +
 include/k3-dev.h                       |   1 +
 7 files changed, 547 insertions(+)
 create mode 100644 arch/arm/mach-k3/r5/j784s4/Makefile
 create mode 100644 arch/arm/mach-k3/r5/j784s4/clk-data.c
 create mode 100644 arch/arm/mach-k3/r5/j784s4/dev-data.c

diff --git a/arch/arm/mach-k3/r5/j784s4/Makefile b/arch/arm/mach-k3/r5/j784s4/Makefile
new file mode 100644
index 0000000000..23e1ce51ac
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j784s4/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+obj-y += clk-data.o
+obj-y += dev-data.o
diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
new file mode 100644
index 0000000000..602489b16c
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * J784S4 specific clock platform data
+ *
+ * This file is auto generated. Please do not hand edit and report any issues
+ * to Bryan Brattlof <bb@ti.com>.
+ *
+ * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/clk-provider.h>
+#include "k3-clk.h"
+
+static const char * const gluelogic_hfosc0_clkout_parents[] = {
+	"osc_19_2_mhz",
+	"osc_20_mhz",
+	"osc_24_mhz",
+	"osc_25_mhz",
+	"osc_26_mhz",
+	"osc_27_mhz",
+};
+
+static const char * const mcu_ospi0_iclk_sel_out0_parents[] = {
+	"board_0_mcu_ospi0_dqs_out",
+	"fss_mcu_0_ospi_0_ospi_oclk_clk",
+};
+
+static const char * const mcu_ospi1_iclk_sel_out0_parents[] = {
+	"board_0_mcu_ospi1_dqs_out",
+	"fss_mcu_0_ospi_1_ospi_oclk_clk",
+};
+
+static const char * const wkup_fref_clksel_out0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk",
+};
+
+static const char * const k3_pll_ctrl_wrap_wkup_0_sysclkout_clk_parents[] = {
+	"wkup_fref_clksel_out0",
+	"hsdiv1_16fft_mcu_0_hsdivout0_clk",
+};
+
+static const char * const mcu_ospi_ref_clk_sel_out0_parents[] = {
+	"hsdiv4_16fft_mcu_1_hsdivout4_clk",
+	"hsdiv4_16fft_mcu_2_hsdivout4_clk",
+};
+
+static const char * const mcu_ospi_ref_clk_sel_out1_parents[] = {
+	"hsdiv4_16fft_mcu_1_hsdivout4_clk",
+	"hsdiv4_16fft_mcu_2_hsdivout4_clk",
+};
+
+static const char * const wkup_gpio0_clksel_out0_parents[] = {
+	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
+	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
+	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_32k_clk",
+	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk",
+};
+
+static const char * const mcu_usart_clksel_out0_parents[] = {
+	"hsdiv4_16fft_mcu_1_hsdivout3_clk",
+	"postdiv3_16fft_main_1_hsdivout5_clk",
+};
+
+static const char * const wkup_i2c_mcupll_bypass_out0_parents[] = {
+	"hsdiv4_16fft_mcu_1_hsdivout3_clk",
+	"gluelogic_hfosc0_clkout",
+};
+
+static const char * const main_pll_hfosc_sel_out0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out1_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out12_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out19_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out2_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out26_0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out27_0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out28_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out3_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out7_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const main_pll_hfosc_sel_out8_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const usb0_refclk_sel_out0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+};
+
+static const char * const emmcsd1_lb_clksel_out0_parents[] = {
+	"board_0_mmc1_clklb_out",
+	"board_0_mmc1_clk_out",
+};
+
+static const char * const mcu_clkout_mux_out0_parents[] = {
+	"hsdiv4_16fft_mcu_2_hsdivout0_clk",
+	"hsdiv4_16fft_mcu_2_hsdivout0_clk",
+};
+
+static const char * const k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents[] = {
+	"main_pll_hfosc_sel_out0",
+	"hsdiv4_16fft_main_0_hsdivout0_clk",
+};
+
+static const char * const dpi0_ext_clksel_out0_parents[] = {
+	"hsdiv1_16fft_main_19_hsdivout0_clk",
+	"board_0_vout0_extpclkin_out",
+};
+
+static const char * const emmcsd_refclk_sel_out0_parents[] = {
+	"hsdiv4_16fft_main_0_hsdivout2_clk",
+	"hsdiv4_16fft_main_1_hsdivout2_clk",
+	"hsdiv4_16fft_main_2_hsdivout2_clk",
+	"hsdiv4_16fft_main_3_hsdivout2_clk",
+};
+
+static const char * const emmcsd_refclk_sel_out1_parents[] = {
+	"hsdiv4_16fft_main_0_hsdivout2_clk",
+	"hsdiv4_16fft_main_1_hsdivout2_clk",
+	"hsdiv4_16fft_main_2_hsdivout2_clk",
+	"hsdiv4_16fft_main_3_hsdivout2_clk",
+};
+
+static const char * const gtc_clk_mux_out0_parents[] = {
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
+	"k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk",
+};
+
+static const struct clk_data clk_list[] = {
+	CLK_FIXED_RATE("osc_27_mhz", 27000000, 0),
+	CLK_FIXED_RATE("osc_26_mhz", 26000000, 0),
+	CLK_FIXED_RATE("osc_25_mhz", 25000000, 0),
+	CLK_FIXED_RATE("osc_24_mhz", 24000000, 0),
+	CLK_FIXED_RATE("osc_20_mhz", 20000000, 0),
+	CLK_FIXED_RATE("osc_19_2_mhz", 19200000, 0),
+	CLK_MUX("gluelogic_hfosc0_clkout", gluelogic_hfosc0_clkout_parents, 6, 0x43000030, 0, 3, 0),
+	CLK_FIXED_RATE("board_0_hfosc1_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mcu_ospi0_dqs_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mcu_ospi1_dqs_out", 0, 0),
+	CLK_FIXED_RATE("board_0_wkup_i2c0_scl_out", 0, 0),
+	CLK_FIXED_RATE("fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n", 0, 0),
+	CLK_FIXED_RATE("fss_mcu_0_hyperbus1p0_0_hpb_out_clk_p", 0, 0),
+	CLK_FIXED_RATE("fss_mcu_0_ospi_0_ospi_oclk_clk", 0, 0),
+	CLK_FIXED_RATE("fss_mcu_0_ospi_1_ospi_oclk_clk", 0, 0),
+	CLK_FIXED_RATE("j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk", 12500000, 0),
+	CLK_FIXED_RATE("j7am_wakeup_16ff_wkup_0_wkup_rcosc_32k_clk", 32000, 0),
+	CLK_MUX("mcu_ospi0_iclk_sel_out0", mcu_ospi0_iclk_sel_out0_parents, 2, 0x40f08030, 4, 1, 0),
+	CLK_MUX("mcu_ospi1_iclk_sel_out0", mcu_ospi1_iclk_sel_out0_parents, 2, 0x40f08034, 4, 1, 0),
+	CLK_FIXED_RATE("mshsi2c_wkup_0_porscl", 0, 0),
+	CLK_MUX("wkup_fref_clksel_out0", wkup_fref_clksel_out0_parents, 2, 0x43008050, 8, 1, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_mcu_0_foutvcop_clk", "wkup_fref_clksel_out0", 0x40d00000, 0),
+	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_mcu_1_foutvcop_clk", "wkup_fref_clksel_out0", 0x40d01000, 0, 2400000000),
+	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", "wkup_fref_clksel_out0", 0x40d02000, 0, 2000000000),
+	CLK_DIV("hsdiv1_16fft_mcu_0_hsdivout0_clk", "pllfracf2_ssmod_16fft_mcu_0_foutvcop_clk", 0x40d00080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_mcu_1_hsdivout3_clk", "pllfracf2_ssmod_16fft_mcu_1_foutvcop_clk", 0x40d0108c, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_mcu_1_hsdivout4_clk", "pllfracf2_ssmod_16fft_mcu_1_foutvcop_clk", 0x40d01090, 0, 7, 0, 0),
+	CLK_DIV_DEFFREQ("hsdiv4_16fft_mcu_2_hsdivout4_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02090, 0, 7, 0, 0, 166666666),
+	CLK_MUX_PLLCTRL("k3_pll_ctrl_wrap_wkup_0_sysclkout_clk", k3_pll_ctrl_wrap_wkup_0_sysclkout_clk_parents, 2, 0x42010000, 0),
+	CLK_DIV("k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk", "k3_pll_ctrl_wrap_wkup_0_sysclkout_clk", 0x42010118, 0, 5, 0, 0),
+	CLK_MUX("mcu_ospi_ref_clk_sel_out0", mcu_ospi_ref_clk_sel_out0_parents, 2, 0x40f08030, 0, 1, 0),
+	CLK_MUX("mcu_ospi_ref_clk_sel_out1", mcu_ospi_ref_clk_sel_out1_parents, 2, 0x40f08034, 0, 1, 0),
+	CLK_MUX("wkup_gpio0_clksel_out0", wkup_gpio0_clksel_out0_parents, 4, 0x43008070, 0, 2, 0),
+	CLK_MUX("mcu_usart_clksel_out0", mcu_usart_clksel_out0_parents, 2, 0x40f081c0, 0, 1, 0),
+	CLK_MUX("wkup_i2c_mcupll_bypass_out0", wkup_i2c_mcupll_bypass_out0_parents, 2, 0x43008060, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out0", main_pll_hfosc_sel_out0_parents, 2, 0x43008080, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out1", main_pll_hfosc_sel_out1_parents, 2, 0x43008084, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out12", main_pll_hfosc_sel_out12_parents, 2, 0x430080b0, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out19", main_pll_hfosc_sel_out19_parents, 2, 0x430080cc, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out2", main_pll_hfosc_sel_out2_parents, 2, 0x43008088, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out26_0", main_pll_hfosc_sel_out26_0_parents, 2, 0x430080e8, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out27_0", main_pll_hfosc_sel_out27_0_parents, 2, 0x430080ec, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out28", main_pll_hfosc_sel_out28_parents, 2, 0x430080f0, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out3", main_pll_hfosc_sel_out3_parents, 2, 0x4300808c, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out7", main_pll_hfosc_sel_out7_parents, 2, 0x4300809c, 0, 1, 0),
+	CLK_MUX("main_pll_hfosc_sel_out8", main_pll_hfosc_sel_out8_parents, 2, 0x430080a0, 0, 1, 0),
+	CLK_MUX("usb0_refclk_sel_out0", usb0_refclk_sel_out0_parents, 2, 0x1080e0, 0, 1, 0),
+	CLK_FIXED_RATE("board_0_cpts0_rft_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_ext_refclk1_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mcu_cpts0_rft_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mcu_ext_refclk0_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mmc1_clklb_out", 0, 0),
+	CLK_FIXED_RATE("board_0_mmc1_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_tck_out", 0, 0),
+	CLK_FIXED_RATE("board_0_vout0_extpclkin_out", 0, 0),
+	CLK_FIXED_RATE("emmcsd4ss_main_0_emmcsdss_io_clk_o", 0, 0),
+	CLK_DIV("hsdiv4_16fft_mcu_2_hsdivout0_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_mcu_2_hsdivout1_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02084, 0, 7, 0, 0),
+	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_main_0_foutvcop_clk", "main_pll_hfosc_sel_out0", 0x680000, 0, 2000000000),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk_subdiv", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680038, 16, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk_subdiv", 0x680038, 24, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_main_1_foutvcop_clk", "main_pll_hfosc_sel_out1", 0x681000, 0, 1920000000),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk_subdiv", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681038, 16, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_DIV("pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk_subdiv", 0x681038, 24, 3, 0, CLK_DIVIDER_ONE_BASED),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_12_foutvcop_clk", "main_pll_hfosc_sel_out12", 0x68c000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_19_foutvcop_clk", "main_pll_hfosc_sel_out19", 0x693000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_2_foutvcop_clk", "main_pll_hfosc_sel_out2", 0x682000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_26_foutvcop_clk", "main_pll_hfosc_sel_out26_0", 0x69a000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_27_foutvcop_clk", "main_pll_hfosc_sel_out27_0", 0x69b000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_28_foutvcop_clk", "main_pll_hfosc_sel_out28", 0x69c000, 0),
+	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_main_3_foutvcop_clk", "main_pll_hfosc_sel_out3", 0x683000, 0, 2000000000),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_7_foutvcop_clk", "main_pll_hfosc_sel_out7", 0x687000, 0),
+	CLK_PLL("pllfracf2_ssmod_16fft_main_8_foutvcop_clk", "main_pll_hfosc_sel_out8", 0x688000, 0),
+	CLK_DIV("postdiv3_16fft_main_0_hsdivout6_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", 0x680098, 0, 7, 0, 0),
+	CLK_DIV("postdiv3_16fft_main_0_hsdivout8_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", 0x6800a0, 0, 7, 0, 0),
+	CLK_DIV("postdiv3_16fft_main_1_hsdivout5_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", 0x681094, 0, 7, 0, 0),
+	CLK_DIV("postdiv3_16fft_main_1_hsdivout7_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", 0x68109c, 0, 7, 0, 0),
+	CLK_MUX("emmcsd1_lb_clksel_out0", emmcsd1_lb_clksel_out0_parents, 2, 0x1080b4, 16, 1, 0),
+	CLK_MUX("mcu_clkout_mux_out0", mcu_clkout_mux_out0_parents, 2, 0x40f08010, 0, 1, 0),
+	CLK_DIV("hsdiv0_16fft_main_12_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_12_foutvcop_clk", 0x68c080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv0_16fft_main_26_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_26_foutvcop_clk", 0x69a080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv0_16fft_main_27_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_27_foutvcop_clk", 0x69b080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv0_16fft_main_28_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_28_foutvcop_clk", 0x69c080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv0_16fft_main_7_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_7_foutvcop_clk", 0x687080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv0_16fft_main_8_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_8_foutvcop_clk", 0x688080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv1_16fft_main_19_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_19_foutvcop_clk", 0x693080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_0_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680080, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_0_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_0_hsdivout3_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x68008c, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_0_hsdivout4_clk", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680090, 0, 7, 0, 0),
+	CLK_DIV_DEFFREQ("hsdiv4_16fft_main_1_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681080, 0, 7, 0, 0, 192000000),
+	CLK_DIV("hsdiv4_16fft_main_1_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_2_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_3_hsdivout1_clk", "pllfracf2_ssmod_16fft_main_3_foutvcop_clk", 0x683084, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_3_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_3_foutvcop_clk", 0x683088, 0, 7, 0, 0),
+	CLK_MUX_PLLCTRL("k3_pll_ctrl_wrap_main_0_sysclkout_clk", k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents, 2, 0x410000, 0),
+	CLK_DIV("k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk", "k3_pll_ctrl_wrap_main_0_sysclkout_clk", 0x410118, 0, 5, 0, 0),
+	CLK_MUX("dpi0_ext_clksel_out0", dpi0_ext_clksel_out0_parents, 2, 0x108300, 0, 1, 0),
+	CLK_MUX("emmcsd_refclk_sel_out0", emmcsd_refclk_sel_out0_parents, 4, 0x1080b0, 0, 2, 0),
+	CLK_MUX("emmcsd_refclk_sel_out1", emmcsd_refclk_sel_out1_parents, 4, 0x1080b4, 0, 2, 0),
+	CLK_MUX("gtc_clk_mux_out0", gtc_clk_mux_out0_parents, 16, 0x108030, 0, 4, 0),
+	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081c0, 0, 2, 0, 0, 48000000),
+	CLK_DIV("usart_programmable_clock_divider_out5", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081d4, 0, 2, 0, 0),
+	CLK_DIV("usart_programmable_clock_divider_out8", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081e0, 0, 2, 0, 0),
+	CLK_DIV("k3_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "k3_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
+	CLK_DIV("k3_pll_ctrl_wrap_wkup_0_chip_div24_clk_clk", "k3_pll_ctrl_wrap_wkup_0_sysclkout_clk", 0x4201011c, 0, 5, 0, 0),
+};
+
+static const struct dev_clk soc_dev_clk_data[] = {
+	DEV_CLK(198, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
+	DEV_CLK(198, 3, "hsdiv0_16fft_main_7_hsdivout0_clk"),
+	DEV_CLK(198, 4, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(202, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
+	DEV_CLK(203, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
+	DEV_CLK(61, 0, "gtc_clk_mux_out0"),
+	DEV_CLK(61, 1, "hsdiv4_16fft_main_3_hsdivout1_clk"),
+	DEV_CLK(61, 2, "postdiv3_16fft_main_0_hsdivout6_clk"),
+	DEV_CLK(61, 3, "board_0_mcu_cpts0_rft_clk_out"),
+	DEV_CLK(61, 4, "board_0_cpts0_rft_clk_out"),
+	DEV_CLK(61, 5, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(61, 6, "board_0_ext_refclk1_out"),
+	DEV_CLK(61, 15, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
+	DEV_CLK(61, 16, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(61, 17, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(78, 0, "postdiv3_16fft_main_0_hsdivout8_clk"),
+	DEV_CLK(78, 1, "hsdiv4_16fft_main_0_hsdivout2_clk"),
+	DEV_CLK(78, 2, "hsdiv4_16fft_main_0_hsdivout3_clk"),
+	DEV_CLK(78, 3, "hsdiv4_16fft_main_0_hsdivout4_clk"),
+	DEV_CLK(78, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(78, 5, "board_0_hfosc1_clk_out"),
+	DEV_CLK(78, 6, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(78, 8, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(78, 9, "board_0_hfosc1_clk_out"),
+	DEV_CLK(78, 10, "j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk"),
+	DEV_CLK(78, 11, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(78, 12, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(140, 1, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(140, 2, "emmcsd_refclk_sel_out0"),
+	DEV_CLK(140, 3, "hsdiv4_16fft_main_0_hsdivout2_clk"),
+	DEV_CLK(140, 4, "hsdiv4_16fft_main_1_hsdivout2_clk"),
+	DEV_CLK(140, 5, "hsdiv4_16fft_main_2_hsdivout2_clk"),
+	DEV_CLK(140, 6, "hsdiv4_16fft_main_3_hsdivout2_clk"),
+	DEV_CLK(141, 0, "emmcsd1_lb_clksel_out0"),
+	DEV_CLK(141, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(141, 4, "emmcsd_refclk_sel_out1"),
+	DEV_CLK(141, 5, "hsdiv4_16fft_main_0_hsdivout2_clk"),
+	DEV_CLK(141, 6, "hsdiv4_16fft_main_1_hsdivout2_clk"),
+	DEV_CLK(141, 7, "hsdiv4_16fft_main_2_hsdivout2_clk"),
+	DEV_CLK(141, 8, "hsdiv4_16fft_main_3_hsdivout2_clk"),
+	DEV_CLK(146, 0, "usart_programmable_clock_divider_out0"),
+	DEV_CLK(146, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(149, 0, "mcu_usart_clksel_out0"),
+	DEV_CLK(149, 1, "hsdiv4_16fft_mcu_1_hsdivout3_clk"),
+	DEV_CLK(149, 2, "postdiv3_16fft_main_1_hsdivout5_clk"),
+	DEV_CLK(149, 5, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(157, 174, "mcu_clkout_mux_out0"),
+	DEV_CLK(157, 175, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(157, 176, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
+	DEV_CLK(157, 179, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_p"),
+	DEV_CLK(157, 180, "fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n"),
+	DEV_CLK(157, 224, "fss_mcu_0_ospi_0_ospi_oclk_clk"),
+	DEV_CLK(157, 226, "fss_mcu_0_ospi_0_ospi_oclk_clk"),
+	DEV_CLK(157, 228, "fss_mcu_0_ospi_1_ospi_oclk_clk"),
+	DEV_CLK(157, 230, "fss_mcu_0_ospi_1_ospi_oclk_clk"),
+	DEV_CLK(157, 239, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(157, 243, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
+	DEV_CLK(157, 245, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
+	DEV_CLK(157, 354, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(157, 359, "dpi0_ext_clksel_out0"),
+	DEV_CLK(157, 360, "mshsi2c_wkup_0_porscl"),
+	DEV_CLK(160, 0, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(160, 2, "hsdiv4_16fft_mcu_2_hsdivout4_clk"),
+	DEV_CLK(160, 4, "hsdiv4_16fft_mcu_2_hsdivout4_clk"),
+	DEV_CLK(160, 6, "hsdiv4_16fft_mcu_2_hsdivout4_clk"),
+	DEV_CLK(160, 8, "hsdiv4_16fft_mcu_2_hsdivout4_clk"),
+	DEV_CLK(161, 0, "board_0_mcu_ospi0_dqs_out"),
+	DEV_CLK(161, 1, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(161, 2, "mcu_ospi0_iclk_sel_out0"),
+	DEV_CLK(161, 3, "board_0_mcu_ospi0_dqs_out"),
+	DEV_CLK(161, 4, "fss_mcu_0_ospi_0_ospi_oclk_clk"),
+	DEV_CLK(161, 6, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(161, 7, "mcu_ospi_ref_clk_sel_out0"),
+	DEV_CLK(161, 8, "hsdiv4_16fft_mcu_1_hsdivout4_clk"),
+	DEV_CLK(161, 9, "hsdiv4_16fft_mcu_2_hsdivout4_clk"),
+	DEV_CLK(162, 0, "board_0_mcu_ospi1_dqs_out"),
+	DEV_CLK(162, 1, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(162, 2, "mcu_ospi1_iclk_sel_out0"),
+	DEV_CLK(162, 3, "board_0_mcu_ospi1_dqs_out"),
+	DEV_CLK(162, 4, "fss_mcu_0_ospi_1_ospi_oclk_clk"),
+	DEV_CLK(162, 6, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(162, 7, "mcu_ospi_ref_clk_sel_out1"),
+	DEV_CLK(162, 8, "hsdiv4_16fft_mcu_1_hsdivout4_clk"),
+	DEV_CLK(162, 9, "hsdiv4_16fft_mcu_2_hsdivout4_clk"),
+	DEV_CLK(167, 0, "wkup_gpio0_clksel_out0"),
+	DEV_CLK(178, 0, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(178, 1, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(188, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(188, 1, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(191, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(191, 1, "hsdiv0_16fft_main_12_hsdivout0_clk"),
+	DEV_CLK(191, 4, "hsdiv0_16fft_main_7_hsdivout0_clk"),
+	DEV_CLK(191, 5, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(192, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(192, 1, "hsdiv0_16fft_main_26_hsdivout0_clk"),
+	DEV_CLK(192, 4, "hsdiv0_16fft_main_7_hsdivout0_clk"),
+	DEV_CLK(192, 5, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(193, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(193, 1, "hsdiv0_16fft_main_27_hsdivout0_clk"),
+	DEV_CLK(193, 4, "hsdiv0_16fft_main_7_hsdivout0_clk"),
+	DEV_CLK(193, 5, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(194, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(194, 1, "hsdiv0_16fft_main_28_hsdivout0_clk"),
+	DEV_CLK(194, 4, "hsdiv0_16fft_main_7_hsdivout0_clk"),
+	DEV_CLK(194, 5, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(201, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(201, 1, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(243, 0, "j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk"),
+	DEV_CLK(243, 1, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(243, 2, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(279, 0, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(279, 1, "board_0_wkup_i2c0_scl_out"),
+	DEV_CLK(279, 2, "wkup_i2c_mcupll_bypass_out0"),
+	DEV_CLK(279, 3, "hsdiv4_16fft_mcu_1_hsdivout3_clk"),
+	DEV_CLK(279, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(392, 0, "usart_programmable_clock_divider_out5"),
+	DEV_CLK(392, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(395, 0, "usart_programmable_clock_divider_out8"),
+	DEV_CLK(395, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(398, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(398, 1, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(398, 2, "postdiv3_16fft_main_1_hsdivout7_clk"),
+	DEV_CLK(398, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(398, 20, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(398, 21, "usb0_refclk_sel_out0"),
+	DEV_CLK(398, 22, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(398, 23, "board_0_hfosc1_clk_out"),
+	DEV_CLK(398, 28, "board_0_tck_out"),
+};
+
+const struct ti_k3_clk_platdata j784s4_clk_platdata = {
+	.clk_list = clk_list,
+	.clk_list_cnt = ARRAY_SIZE(clk_list),
+	.soc_dev_clk_data = soc_dev_clk_data,
+	.soc_dev_clk_data_cnt = ARRAY_SIZE(soc_dev_clk_data),
+};
diff --git a/arch/arm/mach-k3/r5/j784s4/dev-data.c b/arch/arm/mach-k3/r5/j784s4/dev-data.c
new file mode 100644
index 0000000000..882efd8a4c
--- /dev/null
+++ b/arch/arm/mach-k3/r5/j784s4/dev-data.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * J784S4 specific device platform data
+ *
+ * This file is auto generated. Please do not hand edit and report any issues
+ * to Bryan Brattlof <bb@ti.com>.
+ *
+ * Copyright (C) 2020-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-dev.h"
+
+static struct ti_psc soc_psc_list[] = {
+	[0] = PSC(0, 0x42000000),
+	[1] = PSC(1, 0x00420000),
+	[2] = PSC(2, 0x00400000),
+};
+
+static struct ti_pd soc_pd_list[] = {
+	[0] = PSC_PD(0, &soc_psc_list[0], NULL),
+	[1] = PSC_PD(3, &soc_psc_list[1], NULL),
+	[2] = PSC_PD(0, &soc_psc_list[2], NULL),
+	[3] = PSC_PD(1, &soc_psc_list[2], &soc_pd_list[2]),
+	[4] = PSC_PD(14, &soc_psc_list[2], NULL),
+	[5] = PSC_PD(15, &soc_psc_list[2], &soc_pd_list[4]),
+	[6] = PSC_PD(16, &soc_psc_list[2], &soc_pd_list[4]),
+	[7] = PSC_PD(38, &soc_psc_list[2], NULL),
+};
+
+static struct ti_lpsc soc_lpsc_list[] = {
+	[0] = PSC_LPSC(0, &soc_psc_list[0], &soc_pd_list[0], NULL),
+	[1] = PSC_LPSC(3, &soc_psc_list[0], &soc_pd_list[0], NULL),
+	[2] = PSC_LPSC(10, &soc_psc_list[0], &soc_pd_list[0], NULL),
+	[3] = PSC_LPSC(11, &soc_psc_list[0], &soc_pd_list[0], NULL),
+	[4] = PSC_LPSC(12, &soc_psc_list[0], &soc_pd_list[0], NULL),
+	[5] = PSC_LPSC(12, &soc_psc_list[1], &soc_pd_list[1], &soc_lpsc_list[6]),
+	[6] = PSC_LPSC(13, &soc_psc_list[1], &soc_pd_list[1], NULL),
+	[7] = PSC_LPSC(0, &soc_psc_list[2], &soc_pd_list[2], NULL),
+	[8] = PSC_LPSC(9, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[2]),
+	[9] = PSC_LPSC(14, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[10]),
+	[10] = PSC_LPSC(15, &soc_psc_list[2], &soc_pd_list[2], NULL),
+	[11] = PSC_LPSC(16, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[12]),
+	[12] = PSC_LPSC(17, &soc_psc_list[2], &soc_pd_list[2], NULL),
+	[13] = PSC_LPSC(20, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
+	[14] = PSC_LPSC(23, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
+	[15] = PSC_LPSC(25, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
+	[16] = PSC_LPSC(43, &soc_psc_list[2], &soc_pd_list[3], NULL),
+	[17] = PSC_LPSC(45, &soc_psc_list[2], &soc_pd_list[3], NULL),
+	[18] = PSC_LPSC(78, &soc_psc_list[2], &soc_pd_list[4], NULL),
+	[19] = PSC_LPSC(80, &soc_psc_list[2], &soc_pd_list[5], &soc_lpsc_list[18]),
+	[20] = PSC_LPSC(81, &soc_psc_list[2], &soc_pd_list[6], &soc_lpsc_list[18]),
+	[21] = PSC_LPSC(120, &soc_psc_list[2], &soc_pd_list[7], &soc_lpsc_list[22]),
+	[22] = PSC_LPSC(121, &soc_psc_list[2], &soc_pd_list[7], NULL),
+};
+
+static struct ti_dev soc_dev_list[] = {
+	PSC_DEV(35, &soc_lpsc_list[0]),
+	PSC_DEV(160, &soc_lpsc_list[0]),
+	PSC_DEV(161, &soc_lpsc_list[0]),
+	PSC_DEV(162, &soc_lpsc_list[0]),
+	PSC_DEV(243, &soc_lpsc_list[0]),
+	PSC_DEV(149, &soc_lpsc_list[0]),
+	PSC_DEV(167, &soc_lpsc_list[1]),
+	PSC_DEV(279, &soc_lpsc_list[1]),
+	PSC_DEV(161, &soc_lpsc_list[2]),
+	PSC_DEV(162, &soc_lpsc_list[3]),
+	PSC_DEV(160, &soc_lpsc_list[4]),
+	PSC_DEV(139, &soc_lpsc_list[5]),
+	PSC_DEV(194, &soc_lpsc_list[6]),
+	PSC_DEV(78, &soc_lpsc_list[7]),
+	PSC_DEV(61, &soc_lpsc_list[8]),
+	PSC_DEV(131, &soc_lpsc_list[9]),
+	PSC_DEV(191, &soc_lpsc_list[10]),
+	PSC_DEV(132, &soc_lpsc_list[11]),
+	PSC_DEV(192, &soc_lpsc_list[12]),
+	PSC_DEV(398, &soc_lpsc_list[13]),
+	PSC_DEV(141, &soc_lpsc_list[14]),
+	PSC_DEV(140, &soc_lpsc_list[15]),
+	PSC_DEV(146, &soc_lpsc_list[16]),
+	PSC_DEV(392, &soc_lpsc_list[17]),
+	PSC_DEV(395, &soc_lpsc_list[17]),
+	PSC_DEV(198, &soc_lpsc_list[18]),
+	PSC_DEV(202, &soc_lpsc_list[19]),
+	PSC_DEV(203, &soc_lpsc_list[20]),
+	PSC_DEV(133, &soc_lpsc_list[21]),
+	PSC_DEV(193, &soc_lpsc_list[22]),
+};
+
+const struct ti_k3_pd_platdata j784s4_pd_platdata = {
+	.psc = soc_psc_list,
+	.pd = soc_pd_list,
+	.lpsc = soc_lpsc_list,
+	.devs = soc_dev_list,
+	.num_psc = ARRAY_SIZE(soc_psc_list),
+	.num_pd = ARRAY_SIZE(soc_pd_list),
+	.num_lpsc = ARRAY_SIZE(soc_lpsc_list),
+	.num_devs = ARRAY_SIZE(soc_dev_list),
+};
diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index eb76195bd7..10f6049797 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -86,6 +86,12 @@ static const struct soc_attr ti_k3_soc_clk_data[] = {
 		.family = "AM62AX",
 		.data = &am62ax_clk_platdata,
 	},
+#endif
+#ifdef CONFIG_SOC_K3_J784S4
+	{
+		.family = "J784S4",
+		.data = &j784s4_clk_platdata,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index b34c982f4f..fb4ca2dd6b 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -98,6 +98,12 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
 		.family = "AM62AX",
 		.data = &am62ax_pd_platdata,
 	},
+#endif
+#ifdef CONFIG_SOC_K3_J784S4
+	{
+		.family = "J784S4",
+		.data = &j784s4_pd_platdata,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/include/k3-clk.h b/include/k3-clk.h
index 1b6ab8fe65..e161f09c0f 100644
--- a/include/k3-clk.h
+++ b/include/k3-clk.h
@@ -176,6 +176,7 @@ extern const struct ti_k3_clk_platdata j7200_clk_platdata;
 extern const struct ti_k3_clk_platdata j721s2_clk_platdata;
 extern const struct ti_k3_clk_platdata am62x_clk_platdata;
 extern const struct ti_k3_clk_platdata am62ax_clk_platdata;
+extern const struct ti_k3_clk_platdata j784s4_clk_platdata;
 
 struct clk *clk_register_ti_pll(const char *name, const char *parent_name,
 				void __iomem *reg);
diff --git a/include/k3-dev.h b/include/k3-dev.h
index 072e10ba63..a9d1ada804 100644
--- a/include/k3-dev.h
+++ b/include/k3-dev.h
@@ -80,6 +80,7 @@ extern const struct ti_k3_pd_platdata j7200_pd_platdata;
 extern const struct ti_k3_pd_platdata j721s2_pd_platdata;
 extern const struct ti_k3_pd_platdata am62x_pd_platdata;
 extern const struct ti_k3_pd_platdata am62ax_pd_platdata;
+extern const struct ti_k3_pd_platdata j784s4_pd_platdata;
 
 u8 ti_pd_state(struct ti_pd *pd);
 u8 lpsc_get_state(struct ti_lpsc *lpsc);
-- 
2.34.1

