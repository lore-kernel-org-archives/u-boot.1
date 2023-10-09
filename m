Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE02CD610D
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28DCC86DE7;
	Mon,  9 Oct 2023 18:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C4186DD8; Mon,  9 Oct 2023 18:47:27 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 894F586DC4
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="182438618"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 10 Oct 2023 01:47:22 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.229])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2BCF5402A8D6;
 Tue, 10 Oct 2023 01:47:18 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 07/19] clk: renesas: Add RZ/G2L & RZ/G2LC CPG driver
Date: Mon,  9 Oct 2023 17:46:33 +0100
Message-Id: <20231009164645.164464-8-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This driver provides clock and reset control for the Renesas R9A07G044L
(RZ/G2L) and R9A07G044C (RZ/G2LC) SoC. It consists of two parts:

* driver code which is applicable to all SoCs in the RZ/G2L family.

* static data describing the clocks and resets which are specific to the
  R9A07G044{L,C} SoCs. The identifier r9a07g044 (without a final letter)
  is used to indicate that both SoCs are supported.

clk_set_rate() and clk_get_rate() are implemented only for the clocks
that are actually used in u-boot.

The CPG driver is marked with DM_FLAG_PRE_RELOC to ensure that its bind
function is called before the SCIF (serial port) driver is probed. This
is required so that we can de-assert the relevant reset signal during
the serial driver probe function.

This patch is based on the corresponding Linux v6.5 driver
(commit 52e12027d50affbf60c6c9c64db8017391b0c22e).

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
  * Added the exact Linux commit we imported from.
  * Sorted imply statements under config RZG2L.
  * Note that this CPG driver will also be used for the RZ/G2LC.
  * Clarify the way we use `r9a07g044` in the code.
  * Fix use of brackets in definitions & expressions.
  * Fix comment block style.
  * Fix mixed tabs/spaces usage.
  * Use const where possible for variables.

 arch/arm/mach-rmobile/Kconfig       |   1 +
 arch/arm/mach-rmobile/Kconfig.rzg2l |   1 +
 drivers/clk/renesas/Kconfig         |   9 +
 drivers/clk/renesas/Makefile        |   2 +
 drivers/clk/renesas/r9a07g044-cpg.c | 384 +++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.c     | 505 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h     | 319 ++++++++++++++++++
 7 files changed, 1221 insertions(+)
 create mode 100644 drivers/clk/renesas/r9a07g044-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.c
 create mode 100644 drivers/clk/renesas/rzg2l-cpg.h

diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
index 1d8d26d8367f..c5419e8d69c0 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-rmobile/Kconfig
@@ -70,6 +70,7 @@ config RZG2L
 	prompt "Renesas RZ/G2L Family ARM SoCs"
 	select GICV3
 	select RCAR_64
+	imply CLK_RZG2L
 	imply MULTI_DTB_FIT
 	imply MULTI_DTB_FIT_USER_DEFINED_AREA
 	imply RENESAS_SDHI
diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobile/Kconfig.rzg2l
index eda04df5c619..039d6b0a45aa 100644
--- a/arch/arm/mach-rmobile/Kconfig.rzg2l
+++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
@@ -5,6 +5,7 @@ if RZG2L
 
 config R9A07G044L
 	bool "Renesas R9A07G044L SoC"
+	imply CLK_R9A07G044
 	help
 	  Enable support for the Renesas R9A07G044L (RZ/G2L) SoC.
 
diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 437a82cd48be..927d62cf99a3 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -156,3 +156,12 @@ config CLK_R9A06G032
 	depends on CLK_RENESAS
 	help
 	  Enable this to support the clocks on Renesas R9A06G032 SoC.
+
+config CLK_RZG2L
+	bool "Renesas RZ/G2L family clock support"
+	depends on CLK_RENESAS
+	select DM_RESET
+
+config CLK_R9A07G044
+	bool "RZ/G2L (R9A07G044L) clock support"
+	depends on CLK_RZG2L
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 48373e61b901..df7e225e9ca4 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -23,3 +23,5 @@ obj-$(CONFIG_CLK_R8A779A0) += r8a779a0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779F0) += r8a779f0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779G0) += r8a779g0-cpg-mssr.o
 obj-$(CONFIG_CLK_R9A06G032) += r9a06g032-clocks.o
+obj-$(CONFIG_CLK_RZG2L) += rzg2l-cpg.o
+obj-$(CONFIG_CLK_R9A07G044) += r9a07g044-cpg.o
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
new file mode 100644
index 000000000000..2336028a7367
--- /dev/null
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G2L CPG driver
+ *
+ * Copyright (C) 2021-2023 Renesas Electronics Corp.
+ */
+
+#include <common.h>
+#include <dm/device.h>
+#include <dt-bindings/clock/r9a07g044-cpg.h>
+#include <linux/clk-provider.h>
+
+#include "rzg2l-cpg.h"
+
+/* Divider tables */
+static const struct clk_div_table dtable_1_8[] = {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{3, 8},
+	{0, 0},
+};
+
+static const struct clk_div_table dtable_1_32[] = {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{3, 8},
+	{4, 32},
+	{0, 0},
+};
+
+static const struct clk_div_table dtable_16_128[] = {
+	{0, 16},
+	{1, 32},
+	{2, 64},
+	{3, 128},
+	{0, 0},
+};
+
+/* Mux clock tables */
+static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
+static const char * const sel_pll5_4[] = { ".pll5_foutpostdiv", ".pll5_fout1ph0" };
+static const char * const sel_pll6_2[] = { ".pll6_250", ".pll5_250" };
+static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
+static const char * const sel_gpu2[] = { ".pll6", ".pll3_div2_2" };
+
+static const struct {
+	struct cpg_core_clk common[56];
+} core_clks = {
+	.common = {
+		/* External Clock Inputs */
+		DEF_INPUT("extal", CLK_EXTAL),
+
+		/* Internal Core Clocks */
+		DEF_FIXED(".osc", R9A07G044_OSCCLK, CLK_EXTAL, 1, 1),
+		DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
+		DEF_SAMPLL(".pll1", CLK_PLL1, CLK_EXTAL, PLL146_CONF(0)),
+		DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
+		DEF_FIXED(".pll2_533", CLK_PLL2_533, CLK_PLL2, 1, 3),
+		DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
+		DEF_FIXED(".pll3_400", CLK_PLL3_400, CLK_PLL3, 1, 4),
+		DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
+
+		DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
+		DEF_FIXED(".pll5_fout3", CLK_PLL5_FOUT3, CLK_PLL5, 1, 6),
+
+		DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
+
+		DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
+		DEF_FIXED(".clk_800", CLK_PLL2_800, CLK_PLL2, 1, 2),
+		DEF_FIXED(".clk_533", CLK_PLL2_SDHI_533, CLK_PLL2, 1, 3),
+		DEF_FIXED(".clk_400", CLK_PLL2_SDHI_400, CLK_PLL2_800, 1, 2),
+		DEF_FIXED(".clk_266", CLK_PLL2_SDHI_266, CLK_PLL2_SDHI_533, 1, 2),
+
+		DEF_FIXED(".pll2_div2_8", CLK_PLL2_DIV2_8, CLK_PLL2_DIV2, 1, 8),
+		DEF_FIXED(".pll2_div2_10", CLK_PLL2_DIV2_10, CLK_PLL2_DIV2, 1, 10),
+
+		DEF_FIXED(".pll2_533_div2", CLK_PLL2_533_DIV2, CLK_PLL2_533, 1, 2),
+
+		DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
+		DEF_FIXED(".pll3_div2_2", CLK_PLL3_DIV2_2, CLK_PLL3_DIV2, 1, 2),
+		DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
+		DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
+		DEF_MUX_RO(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3, sel_pll3_3),
+		DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3, DIVPL3C, dtable_1_32),
+
+		DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_FOUT3, 1, 2),
+		DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
+		DEF_MUX_RO(".sel_gpu2", CLK_SEL_GPU2, SEL_GPU2, sel_gpu2),
+		DEF_PLL5_FOUTPOSTDIV(".pll5_foutpostdiv", CLK_PLL5_FOUTPOSTDIV, CLK_EXTAL),
+		DEF_FIXED(".pll5_fout1ph0", CLK_PLL5_FOUT1PH0, CLK_PLL5_FOUTPOSTDIV, 1, 2),
+		DEF_PLL5_4_MUX(".sel_pll5_4", CLK_SEL_PLL5_4, SEL_PLL5_4, sel_pll5_4),
+		DEF_DIV(".div_dsi_lpclk", CLK_DIV_DSI_LPCLK, CLK_PLL2_533_DIV2,
+			DIVDSILPCLK, dtable_16_128),
+
+		/* Core output clk */
+		DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8),
+		DEF_DIV("P0", R9A07G044_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A, dtable_1_32),
+		DEF_FIXED("P0_DIV2", R9A07G044_CLK_P0_DIV2, R9A07G044_CLK_P0, 1, 2),
+		DEF_FIXED("TSU", R9A07G044_CLK_TSU, CLK_PLL2_DIV2_10, 1, 1),
+		DEF_DIV("P1", R9A07G044_CLK_P1, CLK_PLL3_DIV2_4, DIVPL3B, dtable_1_32),
+		DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A07G044_CLK_P1, 1, 2),
+		DEF_DIV("P2", R9A07G044_CLK_P2, CLK_PLL3_DIV2_4_2, DIVPL3A, dtable_1_32),
+		DEF_FIXED("M0", R9A07G044_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
+		DEF_FIXED("ZT", R9A07G044_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
+		DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2, sel_pll6_2),
+		DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
+		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
+		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, sel_shdi),
+		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, sel_shdi),
+		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
+		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
+		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8),
+		DEF_FIXED("M1", R9A07G044_CLK_M1, CLK_PLL5_FOUTPOSTDIV, 1, 1),
+		DEF_FIXED("M2", R9A07G044_CLK_M2, CLK_PLL3_533, 1, 2),
+		DEF_FIXED("M2_DIV2", CLK_M2_DIV2, R9A07G044_CLK_M2, 1, 2),
+		DEF_DSI_DIV("DSI_DIV", CLK_DSI_DIV, CLK_SEL_PLL5_4, CLK_SET_RATE_PARENT),
+		DEF_FIXED("M3", R9A07G044_CLK_M3, CLK_DSI_DIV, 1, 1),
+		DEF_FIXED("M4", R9A07G044_CLK_M4, CLK_DIV_DSI_LPCLK, 1, 1),
+	},
+};
+
+static const struct {
+	struct rzg2l_mod_clk common[79];
+} mod_clks = {
+	.common = {
+		DEF_MOD("gic",		R9A07G044_GIC600_GICCLK, R9A07G044_CLK_P1,
+					0x514, 0),
+		DEF_MOD("ia55_pclk",	R9A07G044_IA55_PCLK, R9A07G044_CLK_P2,
+					0x518, 0),
+		DEF_MOD("ia55_clk",	R9A07G044_IA55_CLK, R9A07G044_CLK_P1,
+					0x518, 1),
+		DEF_MOD("dmac_aclk",	R9A07G044_DMAC_ACLK, R9A07G044_CLK_P1,
+					0x52c, 0),
+		DEF_MOD("dmac_pclk",	R9A07G044_DMAC_PCLK, CLK_P1_DIV2,
+					0x52c, 1),
+		DEF_MOD("ostm0_pclk",	R9A07G044_OSTM0_PCLK, R9A07G044_CLK_P0,
+					0x534, 0),
+		DEF_MOD("ostm1_pclk",	R9A07G044_OSTM1_PCLK, R9A07G044_CLK_P0,
+					0x534, 1),
+		DEF_MOD("ostm2_pclk",	R9A07G044_OSTM2_PCLK, R9A07G044_CLK_P0,
+					0x534, 2),
+		DEF_MOD("mtu_x_mck",	R9A07G044_MTU_X_MCK_MTU3, R9A07G044_CLK_P0,
+					0x538, 0),
+		DEF_MOD("gpt_pclk",	R9A07G044_GPT_PCLK, R9A07G044_CLK_P0,
+					0x540, 0),
+		DEF_MOD("poeg_a_clkp",	R9A07G044_POEG_A_CLKP, R9A07G044_CLK_P0,
+					0x544, 0),
+		DEF_MOD("poeg_b_clkp",	R9A07G044_POEG_B_CLKP, R9A07G044_CLK_P0,
+					0x544, 1),
+		DEF_MOD("poeg_c_clkp",	R9A07G044_POEG_C_CLKP, R9A07G044_CLK_P0,
+					0x544, 2),
+		DEF_MOD("poeg_d_clkp",	R9A07G044_POEG_D_CLKP, R9A07G044_CLK_P0,
+					0x544, 3),
+		DEF_MOD("wdt0_pclk",	R9A07G044_WDT0_PCLK, R9A07G044_CLK_P0,
+					0x548, 0),
+		DEF_MOD("wdt0_clk",	R9A07G044_WDT0_CLK, R9A07G044_OSCCLK,
+					0x548, 1),
+		DEF_MOD("wdt1_pclk",	R9A07G044_WDT1_PCLK, R9A07G044_CLK_P0,
+					0x548, 2),
+		DEF_MOD("wdt1_clk",	R9A07G044_WDT1_CLK, R9A07G044_OSCCLK,
+					0x548, 3),
+		DEF_MOD("spi_clk2",	R9A07G044_SPI_CLK2, R9A07G044_CLK_SPI1,
+					0x550, 0),
+		DEF_MOD("spi_clk",	R9A07G044_SPI_CLK, R9A07G044_CLK_SPI0,
+					0x550, 1),
+		DEF_MOD("sdhi0_imclk",	R9A07G044_SDHI0_IMCLK, CLK_SD0_DIV4,
+					0x554, 0),
+		DEF_MOD("sdhi0_imclk2",	R9A07G044_SDHI0_IMCLK2, CLK_SD0_DIV4,
+					0x554, 1),
+		DEF_MOD("sdhi0_clk_hs",	R9A07G044_SDHI0_CLK_HS, R9A07G044_CLK_SD0,
+					0x554, 2),
+		DEF_MOD("sdhi0_aclk",	R9A07G044_SDHI0_ACLK, R9A07G044_CLK_P1,
+					0x554, 3),
+		DEF_MOD("sdhi1_imclk",	R9A07G044_SDHI1_IMCLK, CLK_SD1_DIV4,
+					0x554, 4),
+		DEF_MOD("sdhi1_imclk2",	R9A07G044_SDHI1_IMCLK2, CLK_SD1_DIV4,
+					0x554, 5),
+		DEF_MOD("sdhi1_clk_hs",	R9A07G044_SDHI1_CLK_HS, R9A07G044_CLK_SD1,
+					0x554, 6),
+		DEF_MOD("sdhi1_aclk",	R9A07G044_SDHI1_ACLK, R9A07G044_CLK_P1,
+					0x554, 7),
+		DEF_MOD("gpu_clk",	R9A07G044_GPU_CLK, R9A07G044_CLK_G,
+					0x558, 0),
+		DEF_MOD("gpu_axi_clk",	R9A07G044_GPU_AXI_CLK, R9A07G044_CLK_P1,
+					0x558, 1),
+		DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
+					0x558, 2),
+		DEF_MOD("cru_sysclk",   R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
+					0x564, 0),
+		DEF_MOD("cru_vclk",     R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
+					0x564, 1),
+		DEF_MOD("cru_pclk",     R9A07G044_CRU_PCLK, R9A07G044_CLK_ZT,
+					0x564, 2),
+		DEF_MOD("cru_aclk",     R9A07G044_CRU_ACLK, R9A07G044_CLK_M0,
+					0x564, 3),
+		DEF_MOD("dsi_pll_clk",	R9A07G044_MIPI_DSI_PLLCLK, R9A07G044_CLK_M1,
+					0x568, 0),
+		DEF_MOD("dsi_sys_clk",	R9A07G044_MIPI_DSI_SYSCLK, CLK_M2_DIV2,
+					0x568, 1),
+		DEF_MOD("dsi_aclk",	R9A07G044_MIPI_DSI_ACLK, R9A07G044_CLK_P1,
+					0x568, 2),
+		DEF_MOD("dsi_pclk",	R9A07G044_MIPI_DSI_PCLK, R9A07G044_CLK_P2,
+					0x568, 3),
+		DEF_MOD("dsi_vclk",	R9A07G044_MIPI_DSI_VCLK, R9A07G044_CLK_M3,
+					0x568, 4),
+		DEF_MOD("dsi_lpclk",	R9A07G044_MIPI_DSI_LPCLK, R9A07G044_CLK_M4,
+					0x568, 5),
+		DEF_COUPLED("lcdc_a",	R9A07G044_LCDC_CLK_A, R9A07G044_CLK_M0,
+					0x56c, 0),
+		DEF_COUPLED("lcdc_p",	R9A07G044_LCDC_CLK_P, R9A07G044_CLK_ZT,
+					0x56c, 0),
+		DEF_MOD("lcdc_clk_d",	R9A07G044_LCDC_CLK_D, R9A07G044_CLK_M3,
+					0x56c, 1),
+		DEF_MOD("ssi0_pclk",	R9A07G044_SSI0_PCLK2, R9A07G044_CLK_P0,
+					0x570, 0),
+		DEF_MOD("ssi0_sfr",	R9A07G044_SSI0_PCLK_SFR, R9A07G044_CLK_P0,
+					0x570, 1),
+		DEF_MOD("ssi1_pclk",	R9A07G044_SSI1_PCLK2, R9A07G044_CLK_P0,
+					0x570, 2),
+		DEF_MOD("ssi1_sfr",	R9A07G044_SSI1_PCLK_SFR, R9A07G044_CLK_P0,
+					0x570, 3),
+		DEF_MOD("ssi2_pclk",	R9A07G044_SSI2_PCLK2, R9A07G044_CLK_P0,
+					0x570, 4),
+		DEF_MOD("ssi2_sfr",	R9A07G044_SSI2_PCLK_SFR, R9A07G044_CLK_P0,
+					0x570, 5),
+		DEF_MOD("ssi3_pclk",	R9A07G044_SSI3_PCLK2, R9A07G044_CLK_P0,
+					0x570, 6),
+		DEF_MOD("ssi3_sfr",	R9A07G044_SSI3_PCLK_SFR, R9A07G044_CLK_P0,
+					0x570, 7),
+		DEF_MOD("usb0_host",	R9A07G044_USB_U2H0_HCLK, R9A07G044_CLK_P1,
+					0x578, 0),
+		DEF_MOD("usb1_host",	R9A07G044_USB_U2H1_HCLK, R9A07G044_CLK_P1,
+					0x578, 1),
+		DEF_MOD("usb0_func",	R9A07G044_USB_U2P_EXR_CPUCLK, R9A07G044_CLK_P1,
+					0x578, 2),
+		DEF_MOD("usb_pclk",	R9A07G044_USB_PCLK, R9A07G044_CLK_P1,
+					0x578, 3),
+		DEF_COUPLED("eth0_axi",	R9A07G044_ETH0_CLK_AXI, R9A07G044_CLK_M0,
+					0x57c, 0),
+		DEF_COUPLED("eth0_chi",	R9A07G044_ETH0_CLK_CHI, R9A07G044_CLK_ZT,
+					0x57c, 0),
+		DEF_COUPLED("eth1_axi",	R9A07G044_ETH1_CLK_AXI, R9A07G044_CLK_M0,
+					0x57c, 1),
+		DEF_COUPLED("eth1_chi",	R9A07G044_ETH1_CLK_CHI, R9A07G044_CLK_ZT,
+					0x57c, 1),
+		DEF_MOD("i2c0",		R9A07G044_I2C0_PCLK, R9A07G044_CLK_P0,
+					0x580, 0),
+		DEF_MOD("i2c1",		R9A07G044_I2C1_PCLK, R9A07G044_CLK_P0,
+					0x580, 1),
+		DEF_MOD("i2c2",		R9A07G044_I2C2_PCLK, R9A07G044_CLK_P0,
+					0x580, 2),
+		DEF_MOD("i2c3",		R9A07G044_I2C3_PCLK, R9A07G044_CLK_P0,
+					0x580, 3),
+		DEF_MOD("scif0",	R9A07G044_SCIF0_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 0),
+		DEF_MOD("scif1",	R9A07G044_SCIF1_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 1),
+		DEF_MOD("scif2",	R9A07G044_SCIF2_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 2),
+		DEF_MOD("scif3",	R9A07G044_SCIF3_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 3),
+		DEF_MOD("scif4",	R9A07G044_SCIF4_CLK_PCK, R9A07G044_CLK_P0,
+					0x584, 4),
+		DEF_MOD("sci0",		R9A07G044_SCI0_CLKP, R9A07G044_CLK_P0,
+					0x588, 0),
+		DEF_MOD("sci1",		R9A07G044_SCI1_CLKP, R9A07G044_CLK_P0,
+					0x588, 1),
+		DEF_MOD("rspi0",	R9A07G044_RSPI0_CLKB, R9A07G044_CLK_P0,
+					0x590, 0),
+		DEF_MOD("rspi1",	R9A07G044_RSPI1_CLKB, R9A07G044_CLK_P0,
+					0x590, 1),
+		DEF_MOD("rspi2",	R9A07G044_RSPI2_CLKB, R9A07G044_CLK_P0,
+					0x590, 2),
+		DEF_MOD("canfd",	R9A07G044_CANFD_PCLK, R9A07G044_CLK_P0,
+					0x594, 0),
+		DEF_MOD("gpio",		R9A07G044_GPIO_HCLK, R9A07G044_OSCCLK,
+					0x598, 0),
+		DEF_MOD("adc_adclk",	R9A07G044_ADC_ADCLK, R9A07G044_CLK_TSU,
+					0x5a8, 0),
+		DEF_MOD("adc_pclk",	R9A07G044_ADC_PCLK, R9A07G044_CLK_P0,
+					0x5a8, 1),
+		DEF_MOD("tsu_pclk",	R9A07G044_TSU_PCLK, R9A07G044_CLK_TSU,
+					0x5ac, 0),
+	},
+};
+
+static const struct rzg2l_reset r9a07g044_resets[] = {
+	DEF_RST(R9A07G044_GIC600_GICRESET_N, 0x814, 0),
+	DEF_RST(R9A07G044_GIC600_DBG_GICRESET_N, 0x814, 1),
+	DEF_RST(R9A07G044_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A07G044_DMAC_ARESETN, 0x82c, 0),
+	DEF_RST(R9A07G044_DMAC_RST_ASYNC, 0x82c, 1),
+	DEF_RST(R9A07G044_OSTM0_PRESETZ, 0x834, 0),
+	DEF_RST(R9A07G044_OSTM1_PRESETZ, 0x834, 1),
+	DEF_RST(R9A07G044_OSTM2_PRESETZ, 0x834, 2),
+	DEF_RST(R9A07G044_MTU_X_PRESET_MTU3, 0x838, 0),
+	DEF_RST(R9A07G044_GPT_RST_C, 0x840, 0),
+	DEF_RST(R9A07G044_POEG_A_RST, 0x844, 0),
+	DEF_RST(R9A07G044_POEG_B_RST, 0x844, 1),
+	DEF_RST(R9A07G044_POEG_C_RST, 0x844, 2),
+	DEF_RST(R9A07G044_POEG_D_RST, 0x844, 3),
+	DEF_RST(R9A07G044_WDT0_PRESETN, 0x848, 0),
+	DEF_RST(R9A07G044_WDT1_PRESETN, 0x848, 1),
+	DEF_RST(R9A07G044_SPI_RST, 0x850, 0),
+	DEF_RST(R9A07G044_SDHI0_IXRST, 0x854, 0),
+	DEF_RST(R9A07G044_SDHI1_IXRST, 0x854, 1),
+	DEF_RST(R9A07G044_GPU_RESETN, 0x858, 0),
+	DEF_RST(R9A07G044_GPU_AXI_RESETN, 0x858, 1),
+	DEF_RST(R9A07G044_GPU_ACE_RESETN, 0x858, 2),
+	DEF_RST(R9A07G044_CRU_CMN_RSTB, 0x864, 0),
+	DEF_RST(R9A07G044_CRU_PRESETN, 0x864, 1),
+	DEF_RST(R9A07G044_CRU_ARESETN, 0x864, 2),
+	DEF_RST(R9A07G044_MIPI_DSI_CMN_RSTB, 0x868, 0),
+	DEF_RST(R9A07G044_MIPI_DSI_ARESET_N, 0x868, 1),
+	DEF_RST(R9A07G044_MIPI_DSI_PRESET_N, 0x868, 2),
+	DEF_RST(R9A07G044_LCDC_RESET_N, 0x86c, 0),
+	DEF_RST(R9A07G044_SSI0_RST_M2_REG, 0x870, 0),
+	DEF_RST(R9A07G044_SSI1_RST_M2_REG, 0x870, 1),
+	DEF_RST(R9A07G044_SSI2_RST_M2_REG, 0x870, 2),
+	DEF_RST(R9A07G044_SSI3_RST_M2_REG, 0x870, 3),
+	DEF_RST(R9A07G044_USB_U2H0_HRESETN, 0x878, 0),
+	DEF_RST(R9A07G044_USB_U2H1_HRESETN, 0x878, 1),
+	DEF_RST(R9A07G044_USB_U2P_EXL_SYSRST, 0x878, 2),
+	DEF_RST(R9A07G044_USB_PRESETN, 0x878, 3),
+	DEF_RST(R9A07G044_ETH0_RST_HW_N, 0x87c, 0),
+	DEF_RST(R9A07G044_ETH1_RST_HW_N, 0x87c, 1),
+	DEF_RST(R9A07G044_I2C0_MRST, 0x880, 0),
+	DEF_RST(R9A07G044_I2C1_MRST, 0x880, 1),
+	DEF_RST(R9A07G044_I2C2_MRST, 0x880, 2),
+	DEF_RST(R9A07G044_I2C3_MRST, 0x880, 3),
+	DEF_RST(R9A07G044_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A07G044_SCIF1_RST_SYSTEM_N, 0x884, 1),
+	DEF_RST(R9A07G044_SCIF2_RST_SYSTEM_N, 0x884, 2),
+	DEF_RST(R9A07G044_SCIF3_RST_SYSTEM_N, 0x884, 3),
+	DEF_RST(R9A07G044_SCIF4_RST_SYSTEM_N, 0x884, 4),
+	DEF_RST(R9A07G044_SCI0_RST, 0x888, 0),
+	DEF_RST(R9A07G044_SCI1_RST, 0x888, 1),
+	DEF_RST(R9A07G044_RSPI0_RST, 0x890, 0),
+	DEF_RST(R9A07G044_RSPI1_RST, 0x890, 1),
+	DEF_RST(R9A07G044_RSPI2_RST, 0x890, 2),
+	DEF_RST(R9A07G044_CANFD_RSTP_N, 0x894, 0),
+	DEF_RST(R9A07G044_CANFD_RSTC_N, 0x894, 1),
+	DEF_RST(R9A07G044_GPIO_RSTN, 0x898, 0),
+	DEF_RST(R9A07G044_GPIO_PORT_RESETN, 0x898, 1),
+	DEF_RST(R9A07G044_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A07G044_ADC_PRESETN, 0x8a8, 0),
+	DEF_RST(R9A07G044_ADC_ADRST_N, 0x8a8, 1),
+	DEF_RST(R9A07G044_TSU_PRESETN, 0x8ac, 0),
+};
+
+const struct rzg2l_cpg_info r9a07g044_cpg_info = {
+	/* Core Clocks */
+	.core_clks = core_clks.common,
+	.num_core_clks = ARRAY_SIZE(core_clks.common),
+
+	/* Module Clocks */
+	.mod_clks = mod_clks.common,
+	.num_mod_clks = ARRAY_SIZE(mod_clks.common),
+	.num_hw_mod_clks = R9A07G044_TSU_PCLK + 1,
+
+	/* Resets */
+	.resets = r9a07g044_resets,
+	.num_resets = R9A07G044_TSU_PRESETN + 1, /* Last reset ID + 1 */
+
+	.has_clk_mon_regs = true,
+};
+
+static const struct udevice_id r9a07g044_cpg_ids[] = {
+	{
+		.compatible	= "renesas,r9a07g044-cpg",
+		.data		= (unsigned long)&r9a07g044_cpg_info,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(r9a07g044_cpg) = {
+	.name		= "r9a07g044-cpg",
+	.id		= UCLASS_NOP,
+	.of_match	= r9a07g044_cpg_ids,
+	.bind		= rzg2l_cpg_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
new file mode 100644
index 000000000000..3295ebb90ba2
--- /dev/null
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G2L Clock Pulse Generator
+ *
+ * Copyright (C) 2021-2023 Renesas Electronics Corp.
+ *
+ * Based on renesas-cpg-mssr.c
+ *
+ * Copyright (C) 2015 Glider bvba
+ * Copyright (C) 2013 Ideas On Board SPRL
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ */
+
+#include <common.h>
+#include <asm/io.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/lists.h>
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+#include <linux/clk-provider.h>
+#include <linux/iopoll.h>
+#include <reset-uclass.h>
+#include <reset.h>
+
+#include "rzg2l-cpg.h"
+
+#define CLK_MON_R(reg)		(0x180 + (reg))
+
+static ulong rzg2l_cpg_clk_get_rate_by_id(struct udevice *dev, unsigned int id);
+static ulong rzg2l_cpg_clk_get_rate_by_name(struct udevice *dev, const char *name);
+
+struct rzg2l_cpg_data {
+	void __iomem *base;
+	struct rzg2l_cpg_info *info;
+};
+
+/*
+ * The top 16 bits of the clock ID are used to identify if it is a core clock or
+ * a module clock.
+ */
+#define CPG_CLK_TYPE_SHIFT	16
+#define CPG_CLK_ID_MASK 	0xffff
+#define CPG_CLK_ID(x)		((x) & CPG_CLK_ID_MASK)
+#define CPG_CLK_PACK(type, id)	(((type) << CPG_CLK_TYPE_SHIFT) | CPG_CLK_ID(id))
+
+static inline bool is_mod_clk(unsigned int id)
+{
+	return (id >> CPG_CLK_TYPE_SHIFT) == CPG_MOD;
+}
+
+static int rzg2l_cpg_clk_set(struct clk *clk, bool enable)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(clk->dev);
+	const unsigned int cpg_clk_id = CPG_CLK_ID(clk->id);
+	const struct rzg2l_mod_clk *mod_clk = NULL;
+	u32 value;
+	unsigned int i;
+
+	dev_dbg(clk->dev, "%s %s clock %u\n", enable ? "enable" : "disable",
+		is_mod_clk(clk->id) ? "module" : "core", cpg_clk_id);
+	if (!is_mod_clk(clk->id)) {
+		dev_err(clk->dev, "ID %lu is not a module clock\n", clk->id);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < data->info->num_mod_clks; i++) {
+		if (data->info->mod_clks[i].id == cpg_clk_id) {
+			mod_clk = &data->info->mod_clks[i];
+			break;
+		}
+	}
+
+	if (!mod_clk) {
+		dev_err(clk->dev, "Module clock %u not found\n", cpg_clk_id);
+		return -ENODEV;
+	}
+
+	value = BIT(mod_clk->bit) << 16;
+	if (enable)
+		value |= BIT(mod_clk->bit);
+	writel(value, data->base + mod_clk->off);
+
+	if (enable && readl_poll_timeout(data->base + CLK_MON_R(mod_clk->off),
+					 value, (value & BIT(mod_clk->bit)),
+					 10)) {
+		dev_err(clk->dev, "Timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int rzg2l_cpg_clk_enable(struct clk *clk)
+{
+	return rzg2l_cpg_clk_set(clk, true);
+}
+
+static int rzg2l_cpg_clk_disable(struct clk *clk)
+{
+	return rzg2l_cpg_clk_set(clk, false);
+}
+
+static int rzg2l_cpg_clk_of_xlate(struct clk *clk,
+				  struct ofnode_phandle_args *args)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(clk->dev);
+	u32 cpg_clk_type, cpg_clk_id;
+	bool found = false;
+	unsigned int i;
+
+	if (args->args_count != 2) {
+		dev_dbg(clk->dev, "Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	cpg_clk_type = args->args[0];
+	cpg_clk_id = args->args[1];
+
+	switch (cpg_clk_type) {
+	case CPG_CORE:
+		for (i = 0; i < data->info->num_core_clks; i++) {
+			if (data->info->core_clks[i].id == cpg_clk_id) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			dev_dbg(clk->dev,
+				"Invalid second argument %u: Must be a valid core clock ID\n",
+				cpg_clk_id);
+			return -EINVAL;
+		}
+		break;
+	case CPG_MOD:
+		for (i = 0; i < data->info->num_mod_clks; i++) {
+			if (data->info->mod_clks[i].id == cpg_clk_id) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			dev_dbg(clk->dev,
+				"Invalid second argument %u: Must be a valid module clock ID\n",
+				cpg_clk_id);
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_dbg(clk->dev,
+			"Invalid first argument %u: Must be CPG_CORE or CPG_MOD\n",
+			cpg_clk_type);
+		return -EINVAL;
+	}
+
+	clk->id = CPG_CLK_PACK(cpg_clk_type, cpg_clk_id);
+
+	return 0;
+}
+
+static ulong rzg2l_sdhi_clk_get_rate(struct udevice *dev, const struct cpg_core_clk *cc)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(dev);
+	const ulong offset = CPG_CONF_OFFSET(cc->conf);
+	const int shift = CPG_CONF_BITPOS(cc->conf);
+	const u32 mask = CPG_CONF_BITMASK(cc->conf);
+	unsigned int sel;
+
+	sel = (readl(data->base + offset) >> shift) & mask;
+
+	if (!sel || sel > cc->num_parents) {
+		dev_err(dev, "Invalid SEL_SDHI%d_SET value %u\n", shift / 4, sel);
+		return -EIO;
+	}
+	return rzg2l_cpg_clk_get_rate_by_name(dev, cc->parent_names[sel - 1]);
+}
+
+static ulong rzg2l_div_clk_get_rate(struct udevice *dev, const struct cpg_core_clk *cc)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(dev);
+	const ulong offset = CPG_CONF_OFFSET(cc->conf);
+	const int shift = CPG_CONF_BITPOS(cc->conf);
+	const u32 mask = CPG_CONF_BITMASK(cc->conf);
+	unsigned int sel, i;
+
+	sel = (readl(data->base + offset) >> shift) & mask;
+
+	for (i = 0; cc->dtable[i].div; i++) {
+		if (cc->dtable[i].val == sel)
+			return rzg2l_cpg_clk_get_rate_by_id(dev, cc->parent) / cc->dtable[i].div;
+	}
+	dev_err(dev, "Invalid selector value %u for clock %s\n", sel, cc->name);
+	return -EINVAL;
+}
+
+static ulong rzg2l_core_clk_get_rate(struct udevice *dev, const struct cpg_core_clk *cc)
+{
+	switch (cc->type) {
+	case CLK_TYPE_FF:
+		const ulong parent_rate = rzg2l_cpg_clk_get_rate_by_id(dev, cc->parent);
+		return parent_rate * cc->mult / cc->div;
+	case CLK_TYPE_IN:
+		struct clk clk_in;
+		clk_get_by_name(dev, cc->name, &clk_in);
+		return clk_get_rate(&clk_in);
+	case CLK_TYPE_SD_MUX:
+		return rzg2l_sdhi_clk_get_rate(dev, cc);
+	case CLK_TYPE_DIV:
+		return rzg2l_div_clk_get_rate(dev, cc);
+	default:
+		dev_err(dev, "get_rate needed for clock %u, type %d\n", cc->id, cc->type);
+		return -ENOSYS;
+	}
+}
+
+static ulong rzg2l_cpg_clk_get_rate_by_id(struct udevice *dev, unsigned int id)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(dev);
+	const unsigned int cpg_clk_id = CPG_CLK_ID(id);
+	unsigned int i;
+
+	if (is_mod_clk(id)) {
+		for (i = 0; i < data->info->num_mod_clks; i++) {
+			if (data->info->mod_clks[i].id == cpg_clk_id)
+				return rzg2l_cpg_clk_get_rate_by_id(dev,
+								    data->info->mod_clks[i].parent);
+		}
+
+		dev_err(dev, "Module clock ID %u not found\n", cpg_clk_id);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < data->info->num_core_clks; i++) {
+		if (data->info->core_clks[i].id == cpg_clk_id)
+			return rzg2l_core_clk_get_rate(dev, &data->info->core_clks[i]);
+	}
+
+	dev_err(dev, "Core clock ID %u not found\n", cpg_clk_id);
+	return -ENODEV;
+}
+
+static ulong rzg2l_cpg_clk_get_rate_by_name(struct udevice *dev, const char *name)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(dev);
+	unsigned int i;
+
+	for (i = 0; i < data->info->num_mod_clks; i++) {
+		if (!strcmp(name, data->info->mod_clks[i].name))
+			return rzg2l_cpg_clk_get_rate_by_id(dev, data->info->mod_clks[i].parent);
+	}
+	for (i = 0; i < data->info->num_core_clks; i++) {
+		if (!strcmp(name, data->info->core_clks[i].name))
+			return rzg2l_core_clk_get_rate(dev, &data->info->core_clks[i]);
+	}
+
+	dev_err(dev, "Clock name %s not found\n", name);
+	return -EINVAL;
+}
+
+static ulong rzg2l_cpg_clk_get_rate(struct clk *clk)
+{
+	return rzg2l_cpg_clk_get_rate_by_id(clk->dev, clk->id);
+}
+
+static ulong rzg2l_sdhi_clk_set_rate(struct udevice *dev, const struct cpg_core_clk *cc, ulong rate)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(dev);
+	const ulong offset = CPG_CONF_OFFSET(cc->conf);
+	const int shift = CPG_CONF_BITPOS(cc->conf);
+	int channel, new_sel, prev_sel;
+	ulong target_rate;
+	unsigned int i;
+	u32 value;
+
+	prev_sel = (readl(data->base + offset) >> shift) & 0x3;
+	channel = shift / 4;
+
+	/*
+	 * Round the requested rate down, unless it is below the minimum
+	 * supported rate. Assume that the parent clock names are listed in
+	 * order of descending rate.
+	 */
+	for (i = 0; i < cc->num_parents; i++) {
+		target_rate = rzg2l_cpg_clk_get_rate_by_name(dev, cc->parent_names[i]);
+		if (rate >= target_rate) {
+			new_sel = i + 1;
+			break;
+		}
+	}
+	if (!new_sel)
+		new_sel = cc->num_parents - 1;
+
+	if (new_sel == prev_sel)
+		return target_rate;
+	dev_dbg(dev, "sdhi set_rate rate=%lu target_rate=%lu sel=%d\n",
+		rate, target_rate, new_sel);
+
+	/*
+	 * As per the HW manual, we should not directly switch from 533 MHz to
+	 * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
+	 * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
+	 * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
+	 * (400 MHz)).
+	 */
+	if (new_sel != SEL_SDHI_266MHz && prev_sel != SEL_SDHI_266MHz) {
+		u32 waitbit;
+		int ret;
+
+		dev_dbg(dev, "sdhi set_rate via 266MHz\n");
+		value = (SEL_SDHI_WRITE_ENABLE | SEL_SDHI_266MHz) << shift;
+		writel(value, data->base + offset);
+
+		/* Wait for the switch to complete. */
+		waitbit = channel ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
+		ret = readl_poll_timeout(data->base + CPG_CLKSTATUS, value,
+					 !(value & waitbit),
+					 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+		if (ret) {
+			dev_err(dev, "Failed to switch SDHI%d clock source\n", channel);
+			return -EIO;
+		}
+	}
+
+	value = (SEL_SDHI_WRITE_ENABLE | new_sel) << shift;
+	writel(value, data->base + offset);
+
+	return target_rate;
+}
+
+static ulong rzg2l_core_clk_set_rate(struct udevice *dev, const struct cpg_core_clk *cc, ulong rate)
+{
+	if (cc->type == CLK_TYPE_SD_MUX)
+		return rzg2l_sdhi_clk_set_rate(dev, cc, rate);
+
+	/*
+	 * The sdhi driver calls clk_set_rate for SD0_DIV4 and SD1_DIV4, even
+	 * though they're in a fixed relationship with SD0 and SD1 respectively.
+	 * To allow the driver to proceed, simply return the current rates
+	 * without making any change.
+	 */
+	if (cc->id == CLK_SD0_DIV4 || cc->id == CLK_SD1_DIV4)
+		return rzg2l_core_clk_get_rate(dev, cc);
+
+	dev_err(dev, "set_rate needed for clock %u, type %d\n", cc->id, cc->type);
+	return -ENOSYS;
+}
+
+static ulong rzg2l_cpg_clk_set_rate_by_id(struct udevice *dev, unsigned int id, ulong rate)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(dev);
+	const unsigned int cpg_clk_id = CPG_CLK_ID(id);
+	unsigned int i;
+
+	if (is_mod_clk(id)) {
+		for (i = 0; i < data->info->num_mod_clks; i++) {
+			if (data->info->mod_clks[i].id == cpg_clk_id)
+				return rzg2l_cpg_clk_set_rate_by_id(dev,
+								    data->info->mod_clks[i].parent,
+								    rate);
+		}
+
+		dev_err(dev, "Module clock ID %u not found\n", cpg_clk_id);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < data->info->num_core_clks; i++) {
+		if (data->info->core_clks[i].id == cpg_clk_id)
+			return rzg2l_core_clk_set_rate(dev, &data->info->core_clks[i], rate);
+	}
+
+	dev_err(dev, "Core clock ID %u not found\n", cpg_clk_id);
+	return -ENODEV;
+}
+
+static ulong rzg2l_cpg_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return rzg2l_cpg_clk_set_rate_by_id(clk->dev, clk->id, rate);
+}
+
+static const struct clk_ops rzg2l_cpg_clk_ops = {
+	.enable		= rzg2l_cpg_clk_enable,
+	.disable	= rzg2l_cpg_clk_disable,
+	.of_xlate	= rzg2l_cpg_clk_of_xlate,
+	.get_rate	= rzg2l_cpg_clk_get_rate,
+	.set_rate	= rzg2l_cpg_clk_set_rate,
+};
+
+U_BOOT_DRIVER(rzg2l_cpg_clk) = {
+	.name		= "rzg2l-cpg-clk",
+	.id		= UCLASS_CLK,
+	.ops		= &rzg2l_cpg_clk_ops,
+	.flags		= DM_FLAG_VITAL,
+};
+
+static int rzg2l_cpg_rst_set(struct reset_ctl *reset_ctl, bool asserted)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(reset_ctl->dev);
+	const struct rzg2l_reset *rst;
+	u32 value;
+
+	dev_dbg(reset_ctl->dev, "%s %lu\n", asserted ? "assert" : "deassert", reset_ctl->id);
+	if (reset_ctl->id >= data->info->num_resets) {
+		dev_err(reset_ctl->dev, "Invalid reset id %lu\n", reset_ctl->id);
+		return -EINVAL;
+	}
+	rst = &data->info->resets[reset_ctl->id];
+
+	value = BIT(rst->bit) << 16;
+	if (!asserted)
+		value |= BIT(rst->bit);
+	writel(value, data->base + rst->off);
+
+	return 0;
+}
+
+static int rzg2l_cpg_rst_assert(struct reset_ctl *reset_ctl)
+{
+	return rzg2l_cpg_rst_set(reset_ctl, true);
+}
+
+static int rzg2l_cpg_rst_deassert(struct reset_ctl *reset_ctl)
+{
+	return rzg2l_cpg_rst_set(reset_ctl, false);
+}
+
+static int rzg2l_cpg_rst_of_xlate(struct reset_ctl *reset_ctl,
+				  struct ofnode_phandle_args *args)
+{
+	struct rzg2l_cpg_data *data =
+		(struct rzg2l_cpg_data *)dev_get_driver_data(reset_ctl->dev);
+
+	if (args->args[0] >= data->info->num_resets)
+		return -EINVAL;
+
+	reset_ctl->id = args->args[0];
+	return 0;
+}
+
+static const struct reset_ops rzg2l_cpg_rst_ops = {
+	.rst_assert	= rzg2l_cpg_rst_assert,
+	.rst_deassert	= rzg2l_cpg_rst_deassert,
+	.of_xlate	= rzg2l_cpg_rst_of_xlate,
+};
+
+U_BOOT_DRIVER(rzg2l_cpg_rst) = {
+	.name		= "rzg2l-cpg-rst",
+	.id		= UCLASS_RESET,
+	.ops		= &rzg2l_cpg_rst_ops,
+	.flags		= DM_FLAG_VITAL,
+};
+
+int rzg2l_cpg_bind(struct udevice *parent)
+{
+	struct udevice *cdev, *rdev;
+	struct rzg2l_cpg_data *data;
+	struct driver *drv;
+	int ret;
+
+	data = devm_kmalloc(parent, sizeof(*data), 0);
+	if (!data)
+		return -ENOMEM;
+
+	data->base = dev_read_addr_ptr(parent);
+	if (!data->base)
+		return -EINVAL;
+
+	data->info = (struct rzg2l_cpg_info *)dev_get_driver_data(parent);
+	if (!data->info)
+		return -EINVAL;
+
+	drv = lists_driver_lookup_name("rzg2l-cpg-clk");
+	if (!drv)
+		return -ENOENT;
+
+	ret = device_bind_with_driver_data(parent, drv, parent->name,
+					   (ulong)data, dev_ofnode(parent),
+					   &cdev);
+	if (ret)
+		return ret;
+
+	drv = lists_driver_lookup_name("rzg2l-cpg-rst");
+	if (!drv) {
+		device_unbind(cdev);
+		return -ENOENT;
+	}
+
+	ret = device_bind_with_driver_data(parent, drv, parent->name,
+					   (ulong)data, dev_ofnode(parent),
+					   &rdev);
+	if (ret)
+		device_unbind(cdev);
+
+	return ret;
+}
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
new file mode 100644
index 000000000000..7cb6c481a629
--- /dev/null
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -0,0 +1,319 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RZ/G2L Clock Pulse Generator
+ *
+ * Copyright (C) 2021-2023 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __RENESAS_RZG2L_CPG_H__
+#define __RENESAS_RZG2L_CPG_H__
+
+#define CPG_SIPLL5_STBY		0x140
+#define CPG_SIPLL5_CLK1		0x144
+#define CPG_SIPLL5_CLK3		0x14C
+#define CPG_SIPLL5_CLK4		0x150
+#define CPG_SIPLL5_CLK5		0x154
+#define CPG_SIPLL5_MON		0x15C
+#define CPG_PL1_DDIV		0x200
+#define CPG_PL2_DDIV		0x204
+#define CPG_PL3A_DDIV		0x208
+#define CPG_PL6_DDIV		0x210
+#define CPG_PL2SDHI_DSEL	0x218
+#define CPG_CLKSTATUS		0x280
+#define CPG_PL3_SSEL		0x408
+#define CPG_PL6_SSEL		0x414
+#define CPG_PL6_ETH_SSEL	0x418
+#define CPG_PL5_SDIV		0x420
+#define CPG_RST_MON		0x680
+#define CPG_OTHERFUNC1_REG	0xBE8
+
+#define CPG_SIPLL5_STBY_RESETB		BIT(0)
+#define CPG_SIPLL5_STBY_RESETB_WEN	BIT(16)
+#define CPG_SIPLL5_STBY_SSCG_EN_WEN	BIT(18)
+#define CPG_SIPLL5_STBY_DOWNSPREAD_WEN	BIT(20)
+#define CPG_SIPLL5_CLK4_RESV_LSB	0xFF
+#define CPG_SIPLL5_MON_PLL5_LOCK	BIT(4)
+
+#define CPG_OTHERFUNC1_REG_RES0_ON_WEN	BIT(16)
+
+#define CPG_PL5_SDIV_DIV_DSI_A_WEN	BIT(16)
+#define CPG_PL5_SDIV_DIV_DSI_B_WEN	BIT(24)
+
+#define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
+#define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
+
+#define CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US	20000
+
+/* n = 0/1/2 for PLL1/4/6 */
+#define CPG_SAMPLL_CLK1(n)	(0x04 + (16 * (n)))
+#define CPG_SAMPLL_CLK2(n)	(0x08 + (16 * (n)))
+
+#define PLL146_CONF(n)	(CPG_SAMPLL_CLK1(n) << 22 | CPG_SAMPLL_CLK2(n) << 12)
+
+#define DDIV_PACK(offset, bitpos, size) \
+		(((offset) << 20) | ((bitpos) << 12) | ((size) << 8))
+#define DIVPL1A		DDIV_PACK(CPG_PL1_DDIV, 0, 2)
+#define DIVPL2A		DDIV_PACK(CPG_PL2_DDIV, 0, 3)
+#define DIVDSILPCLK	DDIV_PACK(CPG_PL2_DDIV, 12, 2)
+#define DIVPL3A		DDIV_PACK(CPG_PL3A_DDIV, 0, 3)
+#define DIVPL3B		DDIV_PACK(CPG_PL3A_DDIV, 4, 3)
+#define DIVPL3C		DDIV_PACK(CPG_PL3A_DDIV, 8, 3)
+#define DIVGPU		DDIV_PACK(CPG_PL6_DDIV, 0, 2)
+
+#define SEL_PLL_PACK(offset, bitpos, size) \
+		(((offset) << 20) | ((bitpos) << 12) | ((size) << 8))
+
+#define SEL_PLL3_3	SEL_PLL_PACK(CPG_PL3_SSEL, 8, 1)
+#define SEL_PLL5_4	SEL_PLL_PACK(CPG_OTHERFUNC1_REG, 0, 1)
+#define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
+#define SEL_GPU2	SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
+
+#define SEL_SDHI0	DDIV_PACK(CPG_PL2SDHI_DSEL, 0, 2)
+#define SEL_SDHI1	DDIV_PACK(CPG_PL2SDHI_DSEL, 4, 2)
+
+#define SEL_SDHI_533MHz		1
+#define SEL_SDHI_400MHz		2
+#define SEL_SDHI_266MHz		3
+#define SEL_SDHI_WRITE_ENABLE	0x10000
+
+/* Unpack CPG conf value create by DDIV_PACK() or SEL_PLL_PACK(). */
+#define CPG_CONF_OFFSET(x)	((x) >> 20)
+#define CPG_CONF_BITPOS(x)	(((x) >> 12) & 0xff)
+#define CPG_CONF_SIZE(x)	(((x) >> 8) & 0xf)
+#define CPG_CONF_BITMASK(x)	GENMASK(CPG_CONF_SIZE(x) - 1, 0)
+
+#define EXTAL_FREQ_IN_MEGA_HZ	24
+
+/**
+ * Definitions of CPG Core Clocks
+ *
+ * These include:
+ *   - Clock outputs exported to DT
+ *   - External input clocks
+ *   - Internal CPG clocks
+ */
+struct cpg_core_clk {
+	const char *name;
+	unsigned int id;
+	unsigned int parent;
+	unsigned int div;
+	unsigned int mult;
+	unsigned int type;
+	unsigned int conf;
+	const struct clk_div_table *dtable;
+	const char * const *parent_names;
+	int flag;
+	int mux_flags;
+	int num_parents;
+};
+
+enum clk_types {
+	/* Generic */
+	CLK_TYPE_IN,		/* External Clock Input */
+	CLK_TYPE_FF,		/* Fixed Factor Clock */
+	CLK_TYPE_SAM_PLL,
+
+	/* Clock with divider */
+	CLK_TYPE_DIV,
+
+	/* Clock with clock source selector */
+	CLK_TYPE_MUX,
+
+	/* Clock with SD clock source selector */
+	CLK_TYPE_SD_MUX,
+
+	/* Clock for SIPLL5 */
+	CLK_TYPE_SIPLL5,
+
+	/* Clock for PLL5_4 clock source selector */
+	CLK_TYPE_PLL5_4_MUX,
+
+	/* Clock for DSI divider */
+	CLK_TYPE_DSI_DIV,
+
+};
+
+#define DEF_TYPE(_name, _id, _type...) \
+	{ .name = _name, .id = _id, .type = _type }
+#define DEF_BASE(_name, _id, _type, _parent...) \
+	DEF_TYPE(_name, _id, _type, .parent = _parent)
+#define DEF_SAMPLL(_name, _id, _parent, _conf) \
+	DEF_TYPE(_name, _id, CLK_TYPE_SAM_PLL, .parent = _parent, .conf = _conf)
+#define DEF_INPUT(_name, _id) \
+	DEF_TYPE(_name, _id, CLK_TYPE_IN)
+#define DEF_FIXED(_name, _id, _parent, _mult, _div) \
+	DEF_BASE(_name, _id, CLK_TYPE_FF, _parent, .div = _div, .mult = _mult)
+#define DEF_DIV(_name, _id, _parent, _conf, _dtable) \
+	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
+		 .parent = _parent, .dtable = _dtable, \
+		 .flag = CLK_DIVIDER_HIWORD_MASK)
+#define DEF_DIV_RO(_name, _id, _parent, _conf, _dtable) \
+	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
+		 .parent = _parent, .dtable = _dtable, \
+		 .flag = CLK_DIVIDER_READ_ONLY)
+#define DEF_MUX(_name, _id, _conf, _parent_names) \
+	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
+		 .parent_names = _parent_names, \
+		 .num_parents = ARRAY_SIZE(_parent_names), \
+		 .mux_flags = CLK_MUX_HIWORD_MASK)
+#define DEF_MUX_RO(_name, _id, _conf, _parent_names) \
+	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
+		 .parent_names = _parent_names, \
+		 .num_parents = ARRAY_SIZE(_parent_names), \
+		 .mux_flags = CLK_MUX_READ_ONLY)
+#define DEF_SD_MUX(_name, _id, _conf, _parent_names) \
+	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, \
+		 .parent_names = _parent_names, \
+		 .num_parents = ARRAY_SIZE(_parent_names))
+#define DEF_PLL5_FOUTPOSTDIV(_name, _id, _parent) \
+	DEF_TYPE(_name, _id, CLK_TYPE_SIPLL5, .parent = _parent)
+#define DEF_PLL5_4_MUX(_name, _id, _conf, _parent_names) \
+	DEF_TYPE(_name, _id, CLK_TYPE_PLL5_4_MUX, .conf = _conf, \
+		 .parent_names = _parent_names, \
+		 .num_parents = ARRAY_SIZE(_parent_names))
+#define DEF_DSI_DIV(_name, _id, _parent, _flag) \
+	DEF_TYPE(_name, _id, CLK_TYPE_DSI_DIV, .parent = _parent, .flag = _flag)
+
+/**
+ * struct rzg2l_mod_clk - Module Clocks definitions
+ *
+ * @name: handle between common and hardware-specific interfaces
+ * @id: clock index in array containing all Core and Module Clocks
+ * @parent: id of parent clock
+ * @off: register offset
+ * @bit: ON/MON bit
+ * @is_coupled: flag to indicate coupled clock
+ */
+struct rzg2l_mod_clk {
+	const char *name;
+	unsigned int id;
+	unsigned int parent;
+	u16 off;
+	u8 bit;
+	bool is_coupled;
+};
+
+#define DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _is_coupled)	\
+	{ \
+		.name = (_name), \
+		.id = (_id), \
+		.parent = (_parent), \
+		.off = (_off), \
+		.bit = (_bit), \
+		.is_coupled = (_is_coupled), \
+	}
+
+#define DEF_MOD(_name, _id, _parent, _off, _bit)	\
+	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, false)
+
+#define DEF_COUPLED(_name, _id, _parent, _off, _bit)	\
+	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, true)
+
+/**
+ * struct rzg2l_reset - Reset definitions
+ *
+ * @off: register offset
+ * @bit: reset bit
+ * @monbit: monitor bit in CPG_RST_MON register, -1 if none
+ */
+struct rzg2l_reset {
+	u16 off;
+	u8 bit;
+	s8 monbit;
+};
+
+#define DEF_RST_MON(_id, _off, _bit, _monbit)	\
+	[_id] = { \
+		.off = (_off), \
+		.bit = (_bit), \
+		.monbit = (_monbit) \
+	}
+#define DEF_RST(_id, _off, _bit)	\
+	DEF_RST_MON(_id, _off, _bit, -1)
+
+/**
+ * struct rzg2l_cpg_info - SoC-specific CPG Description
+ *
+ * @core_clks: Array of Core Clock definitions
+ * @num_core_clks: Number of entries in core_clks[]
+ *
+ * @mod_clks: Array of Module Clock definitions
+ * @num_mod_clks: Number of entries in mod_clks[]
+ * @num_hw_mod_clks: Number of Module Clocks supported by the hardware
+ *
+ * @resets: Array of Module Reset definitions
+ * @num_resets: Number of entries in resets[]
+ *
+ * @has_clk_mon_regs: Flag indicating whether the SoC has CLK_MON registers
+ */
+struct rzg2l_cpg_info {
+	/* Core Clocks */
+	const struct cpg_core_clk *core_clks;
+	unsigned int num_core_clks;
+
+	/* Module Clocks */
+	const struct rzg2l_mod_clk *mod_clks;
+	unsigned int num_mod_clks;
+	unsigned int num_hw_mod_clks;
+
+	/* Resets */
+	const struct rzg2l_reset *resets;
+	unsigned int num_resets;
+
+	bool has_clk_mon_regs;
+};
+
+extern const struct rzg2l_cpg_info r9a07g044_cpg_info;
+
+int rzg2l_cpg_bind(struct udevice *parent);
+
+/*
+ * Clock IDs start at an offset to avoid overlapping with core & module clock
+ * IDs defined in the dt-bindings headers.
+ */
+enum clk_ids {
+	/* External Input Clocks */
+	CLK_EXTAL = 0x100,
+
+	/* Internal Core Clocks */
+	CLK_OSC_DIV1000 = 0x200,
+	CLK_PLL1,
+	CLK_PLL2,
+	CLK_PLL2_DIV2,
+	CLK_PLL2_DIV2_8,
+	CLK_PLL2_DIV2_10,
+	CLK_PLL3,
+	CLK_PLL3_400,
+	CLK_PLL3_533,
+	CLK_M2_DIV2,
+	CLK_PLL3_DIV2,
+	CLK_PLL3_DIV2_2,
+	CLK_PLL3_DIV2_4,
+	CLK_PLL3_DIV2_4_2,
+	CLK_SEL_PLL3_3,
+	CLK_DIV_PLL3_C,
+	CLK_PLL4,
+	CLK_PLL5,
+	CLK_PLL5_FOUTPOSTDIV,
+	CLK_PLL5_FOUT1PH0,
+	CLK_PLL5_FOUT3,
+	CLK_PLL5_250,
+	CLK_PLL6,
+	CLK_PLL6_250,
+	CLK_P1_DIV2,
+	CLK_PLL2_800,
+	CLK_PLL2_SDHI_533,
+	CLK_PLL2_SDHI_400,
+	CLK_PLL2_SDHI_266,
+	CLK_SD0_DIV4,
+	CLK_SD1_DIV4,
+	CLK_SEL_GPU2,
+	CLK_SEL_PLL5_4,
+	CLK_DSI_DIV,
+	CLK_PLL2_533,
+	CLK_PLL2_533_DIV2,
+	CLK_DIV_DSI_LPCLK,
+};
+
+#endif
-- 
2.39.2

