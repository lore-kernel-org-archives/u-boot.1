Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E507C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B808322F;
	Tue,  8 Apr 2025 00:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YPtzg7GY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD75D8322F; Tue,  8 Apr 2025 00:49:17 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5037831B0
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066151; bh=p1MSAtP2FFPk9Bo4MvvjsH42aS2F/oefXCovOYoivbE=;
 b=YPtzg7GYhT2qoO6lfRNG6ZuHKE039wCQeRx450XG4Tb1latJh+2eC61aOZ25uo3mheWgATNOa
 gvLF+e00lTknePFEIZcWWP6Zq9dePKHXPDH6qbCvvVrPAJ7Gp7kwpkQGejN5G8qpVXiAjj+cWlw
 eGW2Z3PND3uHsgfBq8ho8TgXStkPoVgl7QIIeVPo2itWHs3t2LlyAvTkg/MlHc0g1tfRspQVwrV
 Cg1tjyESVD8sVaIL6dee5ZrGAWTldiqfvSjZt9QTepMJTHJ/vgu2doKyk1fY8c5yD0YhwnLPmDS
 JMIuyT1RmOJ/qQZkwunuiKpl+vtOqZysA0rtcpXzGIhw==
X-Forward-Email-ID: 67f456509fd75b9b965128b4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v2 16/30] clk: rockchip: Add support for RK3528
Date: Mon,  7 Apr 2025 22:46:49 +0000
Message-ID: <20250407224743.2423921-17-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
MIME-Version: 1.0
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

From: Joseph Chen <chenjh@rock-chips.com>

Add clock driver for RK3528.

Imported from vendor U-Boot linux-6.1-stan-rkr5 tag with minor
adjustments and fixes for mainline.

Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Use mainline Linux dt-bindings headers and rst-rk3528
- Add TCLK_EMMC, BCLK_EMMC, ACLK_BUS_VOPGL_ROOT and XIN_OSC0_DIV
- Add missing break for CLK_I2C5
---
 arch/arm/include/asm/arch-rockchip/clock.h    |   17 +
 .../include/asm/arch-rockchip/cru_rk3528.h    |  388 ++++
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_pll.c                |   23 +-
 drivers/clk/rockchip/clk_rk3528.c             | 1754 +++++++++++++++++
 drivers/reset/Makefile                        |    2 +-
 drivers/reset/rst-rk3528.c                    |  302 +++
 7 files changed, 2480 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3528.h
 create mode 100644 drivers/clk/rockchip/clk_rk3528.c
 create mode 100644 drivers/reset/rst-rk3528.c

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 73e5283108b1..a9921fbb6e42 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -15,6 +15,13 @@ struct udevice;
 #define RKCLK_PLL_MODE_NORMAL		1
 #define RKCLK_PLL_MODE_DEEP		2
 
+/*
+ * PLL flags
+ */
+#define ROCKCHIP_PLL_SYNC_RATE		BIT(0)
+/* normal mode only. now only for pll_rk3036, pll_rk3328 type */
+#define ROCKCHIP_PLL_FIXED_MODE		BIT(1)
+
 enum {
 	ROCKCHIP_SYSCON_NOC,
 	ROCKCHIP_SYSCON_GRF,
@@ -207,6 +214,16 @@ int rockchip_reset_bind(struct udevice *pdev, u32 reg_offset, u32 reg_number);
  */
 int rockchip_reset_bind_lut(struct udevice *pdev, const int *lookup_table,
 			    u32 reg_offset, u32 reg_number);
+/*
+ * rk3528_reset_bind_lut() - Bind soft reset device as child of clock device
+ *			     using dedicated RK3528 lookup table
+ *
+ * @pdev: clock udevice
+ * @reg_offset: the first offset in cru for softreset registers
+ * @reg_number: the reg numbers of softreset registers
+ * Return: 0 success, or error value
+ */
+int rk3528_reset_bind_lut(struct udevice *pdev, u32 reg_offset, u32 reg_number);
 /*
  * rk3588_reset_bind_lut() - Bind soft reset device as child of clock device
  *			     using dedicated RK3588 lookup table
diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3528.h b/arch/arm/include/asm/arch-rockchip/cru_rk3528.h
new file mode 100644
index 000000000000..b4020958a046
--- /dev/null
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3528.h
@@ -0,0 +1,388 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ * Author: Joseph Chen <chenjh@rock-chips.com>
+ */
+
+#ifndef _ASM_ARCH_CRU_RK3528_H
+#define _ASM_ARCH_CRU_RK3528_H
+
+#define MHz		1000000
+#define KHz		1000
+#define OSC_HZ		(24 * MHz)
+
+#define CPU_PVTPLL_HZ	(1200 * MHz)
+#define APLL_HZ		(600 * MHz)
+#define GPLL_HZ		(1188 * MHz)
+#define CPLL_HZ		(996 * MHz)
+#define PPLL_HZ		(1000 * MHz)
+
+/* RK3528 pll id */
+enum rk3528_pll_id {
+	APLL,
+	CPLL,
+	GPLL,
+	PPLL,
+	DPLL,
+	PLL_COUNT,
+};
+
+struct rk3528_clk_priv {
+	struct rk3528_cru *cru;
+	unsigned long ppll_hz;
+	unsigned long gpll_hz;
+	unsigned long cpll_hz;
+	unsigned long armclk_hz;
+	unsigned long armclk_enter_hz;
+	unsigned long armclk_init_hz;
+	bool sync_kernel;
+};
+
+struct rk3528_pll {
+	unsigned int con0;
+	unsigned int con1;
+	unsigned int con2;
+	unsigned int con3;
+	unsigned int con4;
+	unsigned int reserved0[3];
+};
+
+#define RK3528_CRU_BASE			((struct rk3528_cru *)0xff4a0000)
+
+struct rk3528_cru {
+	unsigned int apll_con[5];
+	unsigned int reserved0014[3];
+	unsigned int cpll_con[5];
+	unsigned int reserved0034[11];
+	unsigned int gpll_con[5];
+	unsigned int reserved0074[51 + 32];
+	unsigned int reserved01c0[48];
+	unsigned int mode_con[1];
+	unsigned int reserved0284[31];
+	unsigned int clksel_con[91];
+	unsigned int reserved046c[229];
+	unsigned int gate_con[46];
+	unsigned int reserved08b8[82];
+	unsigned int softrst_con[47];
+	unsigned int reserved0abc[81];
+	unsigned int glb_cnt_th;
+	unsigned int glb_rst_st;
+	unsigned int glb_srst_fst;
+	unsigned int glb_srst_snd;
+	unsigned int glb_rst_con;
+	unsigned int reserved0c14[6];
+	unsigned int corewfi_con;
+	unsigned int reserved0c30[15604];
+
+	/* pmucru */
+	unsigned int reserved10000[192];
+	unsigned int pmuclksel_con[3];
+	unsigned int reserved1030c[317];
+	unsigned int pmugate_con[3];
+	unsigned int reserved1080c[125];
+	unsigned int pmusoftrst_con[3];
+	unsigned int reserved10a08[7550 + 8191];
+
+	/* pciecru */
+	unsigned int reserved20000[32];
+	unsigned int ppll_con[5];
+	unsigned int reserved20094[155];
+	unsigned int pcieclksel_con[2];
+	unsigned int reserved20308[318];
+	unsigned int pciegate_con;
+};
+
+check_member(rk3528_cru, pciegate_con, 0x20800);
+
+struct pll_rate_table {
+	unsigned long rate;
+	unsigned int fbdiv;
+	unsigned int postdiv1;
+	unsigned int refdiv;
+	unsigned int postdiv2;
+	unsigned int dsmpd;
+	unsigned int frac;
+};
+
+#define RK3528_PMU_CRU_BASE			0x10000
+#define RK3528_PCIE_CRU_BASE			0x20000
+#define RK3528_DDRPHY_CRU_BASE			0x28000
+#define RK3528_PLL_CON(x)			((x) * 0x4)
+#define RK3528_PCIE_PLL_CON(x)			((x) * 0x4 + RK3528_PCIE_CRU_BASE)
+#define RK3528_DDRPHY_PLL_CON(x)		((x) * 0x4 + RK3528_DDRPHY_CRU_BASE)
+#define RK3528_MODE_CON				0x280
+#define RK3528_CLKSEL_CON(x)			((x) * 0x4 + 0x300)
+#define RK3528_PMU_CLKSEL_CON(x)		((x) * 0x4 + 0x300 + RK3528_PMU_CRU_BASE)
+#define RK3528_PCIE_CLKSEL_CON(x)		((x) * 0x4 + 0x300 + RK3528_PCIE_CRU_BASE)
+#define RK3528_DDRPHY_MODE_CON			(0x280 + RK3528_DDRPHY_CRU_BASE)
+
+#define RK3528_DIV_ACLK_M_CORE_SHIFT		11
+#define RK3528_DIV_ACLK_M_CORE_MASK		(0x1f << RK3528_DIV_ACLK_M_CORE_SHIFT)
+#define RK3528_DIV_PCLK_DBG_SHIFT		1
+#define RK3528_DIV_PCLK_DBG_MASK		(0x1f << RK3528_DIV_PCLK_DBG_SHIFT)
+
+enum {
+	/* CRU_CLKSEL_CON00 */
+	CLK_MATRIX_50M_SRC_DIV_SHIFT		= 2,
+	CLK_MATRIX_50M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_50M_SRC_DIV_SHIFT,
+	CLK_MATRIX_100M_SRC_DIV_SHIFT		= 7,
+	CLK_MATRIX_100M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_100M_SRC_DIV_SHIFT,
+
+	/* CRU_CLKSEL_CON01 */
+	CLK_MATRIX_150M_SRC_DIV_SHIFT		= 0,
+	CLK_MATRIX_150M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_150M_SRC_DIV_SHIFT,
+	CLK_MATRIX_200M_SRC_DIV_SHIFT		= 5,
+	CLK_MATRIX_200M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_200M_SRC_DIV_SHIFT,
+	CLK_MATRIX_250M_SRC_DIV_SHIFT		= 10,
+	CLK_MATRIX_250M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_250M_SRC_DIV_SHIFT,
+	CLK_MATRIX_250M_SRC_SEL_SHIFT		= 15,
+	CLK_MATRIX_250M_SRC_SEL_MASK		= 0x1 << CLK_MATRIX_250M_SRC_SEL_SHIFT,
+
+	/* CRU_CLKSEL_CON02 */
+	CLK_MATRIX_300M_SRC_DIV_SHIFT		= 0,
+	CLK_MATRIX_300M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_300M_SRC_DIV_SHIFT,
+	CLK_MATRIX_339M_SRC_DIV_SHIFT		= 5,
+	CLK_MATRIX_339M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_339M_SRC_DIV_SHIFT,
+	CLK_MATRIX_400M_SRC_DIV_SHIFT		= 10,
+	CLK_MATRIX_400M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_400M_SRC_DIV_SHIFT,
+
+	/* CRU_CLKSEL_CON03 */
+	CLK_MATRIX_500M_SRC_DIV_SHIFT		= 6,
+	CLK_MATRIX_500M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_500M_SRC_DIV_SHIFT,
+	CLK_MATRIX_500M_SRC_SEL_SHIFT		= 11,
+	CLK_MATRIX_500M_SRC_SEL_MASK		= 0x1 << CLK_MATRIX_500M_SRC_SEL_SHIFT,
+
+	/* CRU_CLKSEL_CON04 */
+	CLK_MATRIX_600M_SRC_DIV_SHIFT		= 0,
+	CLK_MATRIX_600M_SRC_DIV_MASK		= 0x1F << CLK_MATRIX_600M_SRC_DIV_SHIFT,
+	CLK_MATRIX_250M_SRC_SEL_CLK_GPLL_MUX	= 0U,
+	CLK_MATRIX_250M_SRC_SEL_CLK_CPLL_MUX	= 1U,
+	CLK_MATRIX_500M_SRC_SEL_CLK_GPLL_MUX	= 0U,
+	CLK_MATRIX_500M_SRC_SEL_CLK_CPLL_MUX	= 1U,
+
+	/* PMUCRU_CLKSEL_CON00 */
+	CLK_I2C2_SEL_SHIFT			= 0,
+	CLK_I2C2_SEL_MASK			= 0x3 << CLK_I2C2_SEL_SHIFT,
+
+	/* PCIE_CRU_CLKSEL_CON01 */
+	PCIE_CLK_MATRIX_50M_SRC_DIV_SHIFT	= 7,
+	PCIE_CLK_MATRIX_50M_SRC_DIV_MASK	= 0x1f << PCIE_CLK_MATRIX_50M_SRC_DIV_SHIFT,
+	PCIE_CLK_MATRIX_100M_SRC_DIV_SHIFT	= 11,
+	PCIE_CLK_MATRIX_100M_SRC_DIV_MASK	= 0x1f << PCIE_CLK_MATRIX_100M_SRC_DIV_SHIFT,
+
+	/* CRU_CLKSEL_CON32 */
+	DCLK_VOP_SRC0_SEL_SHIFT			= 10,
+	DCLK_VOP_SRC0_SEL_MASK			= 0x1 << DCLK_VOP_SRC0_SEL_SHIFT,
+	DCLK_VOP_SRC0_DIV_SHIFT			= 2,
+	DCLK_VOP_SRC0_DIV_MASK			= 0xFF << DCLK_VOP_SRC0_DIV_SHIFT,
+
+	/* CRU_CLKSEL_CON33 */
+	DCLK_VOP_SRC1_SEL_SHIFT			= 8,
+	DCLK_VOP_SRC1_SEL_MASK			= 0x1 << DCLK_VOP_SRC1_SEL_SHIFT,
+	DCLK_VOP_SRC1_DIV_SHIFT			= 0,
+	DCLK_VOP_SRC1_DIV_MASK			= 0xFF << DCLK_VOP_SRC1_DIV_SHIFT,
+
+	/* CRU_CLKSEL_CON43 */
+	CLK_CORE_CRYPTO_SEL_SHIFT		= 14,
+	CLK_CORE_CRYPTO_SEL_MASK		= 0x3 << CLK_CORE_CRYPTO_SEL_SHIFT,
+	ACLK_BUS_VOPGL_ROOT_DIV_SHIFT		= 0U,
+	ACLK_BUS_VOPGL_ROOT_DIV_MASK		= 0x7U << ACLK_BUS_VOPGL_ROOT_DIV_SHIFT,
+
+	/* CRU_CLKSEL_CON44 */
+	CLK_PWM0_SEL_SHIFT			= 6,
+	CLK_PWM0_SEL_MASK			= 0x3 << CLK_PWM0_SEL_SHIFT,
+	CLK_PWM1_SEL_SHIFT			= 8,
+	CLK_PWM1_SEL_MASK			= 0x3 << CLK_PWM1_SEL_SHIFT,
+	CLK_PWM0_SEL_CLK_MATRIX_100M_SRC	= 0U,
+	CLK_PWM0_SEL_CLK_MATRIX_50M_SRC		= 1U,
+	CLK_PWM0_SEL_XIN_OSC0_FUNC		= 2U,
+	CLK_PWM1_SEL_CLK_MATRIX_100M_SRC	= 0U,
+	CLK_PWM1_SEL_CLK_MATRIX_50M_SRC		= 1U,
+	CLK_PWM1_SEL_XIN_OSC0_FUNC		= 2U,
+	CLK_PKA_CRYPTO_SEL_SHIFT		= 0,
+	CLK_PKA_CRYPTO_SEL_MASK			= 0x3 << CLK_PKA_CRYPTO_SEL_SHIFT,
+	CLK_CORE_CRYPTO_SEL_CLK_MATRIX_300M_SRC	= 0U,
+	CLK_CORE_CRYPTO_SEL_CLK_MATRIX_200M_SRC	= 1U,
+	CLK_CORE_CRYPTO_SEL_CLK_MATRIX_100M_SRC	= 2U,
+	CLK_CORE_CRYPTO_SEL_XIN_OSC0_FUNC	= 3U,
+	CLK_PKA_CRYPTO_SEL_CLK_MATRIX_300M_SRC	= 0U,
+	CLK_PKA_CRYPTO_SEL_CLK_MATRIX_200M_SRC	= 1U,
+	CLK_PKA_CRYPTO_SEL_CLK_MATRIX_100M_SRC	= 2U,
+	CLK_PKA_CRYPTO_SEL_XIN_OSC0_FUNC	= 3U,
+
+	/* CRU_CLKSEL_CON60 */
+	CLK_MATRIX_25M_SRC_DIV_SHIFT		= 2,
+	CLK_MATRIX_25M_SRC_DIV_MASK		= 0xff << CLK_MATRIX_25M_SRC_DIV_SHIFT,
+	CLK_MATRIX_125M_SRC_DIV_SHIFT		= 10,
+	CLK_MATRIX_125M_SRC_DIV_MASK		= 0x1f << CLK_MATRIX_125M_SRC_DIV_SHIFT,
+
+	/* CRU_CLKSEL_CON61 */
+	SCLK_SFC_DIV_SHIFT			= 6,
+	SCLK_SFC_DIV_MASK			= 0x3F << SCLK_SFC_DIV_SHIFT,
+	SCLK_SFC_SEL_SHIFT			= 12,
+	SCLK_SFC_SEL_MASK			= 0x3 << SCLK_SFC_SEL_SHIFT,
+	SCLK_SFC_SEL_CLK_GPLL_MUX		= 0U,
+	SCLK_SFC_SEL_CLK_CPLL_MUX		= 1U,
+	SCLK_SFC_SEL_XIN_OSC0_FUNC		= 2U,
+
+	/* CRU_CLKSEL_CON62 */
+	CCLK_SRC_EMMC_DIV_SHIFT			= 0,
+	CCLK_SRC_EMMC_DIV_MASK			= 0x3F << CCLK_SRC_EMMC_DIV_SHIFT,
+	CCLK_SRC_EMMC_SEL_SHIFT			= 6,
+	CCLK_SRC_EMMC_SEL_MASK			= 0x3 << CCLK_SRC_EMMC_SEL_SHIFT,
+	BCLK_EMMC_SEL_SHIFT			= 8,
+	BCLK_EMMC_SEL_MASK			= 0x3 << BCLK_EMMC_SEL_SHIFT,
+
+	/* CRU_CLKSEL_CON63 */
+	CLK_I2C3_SEL_SHIFT			= 12,
+	CLK_I2C3_SEL_MASK			= 0x3 << CLK_I2C3_SEL_SHIFT,
+	CLK_I2C5_SEL_SHIFT			= 14,
+	CLK_I2C5_SEL_MASK			= 0x3 << CLK_I2C5_SEL_SHIFT,
+	CLK_SPI1_SEL_SHIFT			= 10,
+	CLK_SPI1_SEL_MASK			= 0x3 << CLK_SPI1_SEL_SHIFT,
+
+	/* CRU_CLKSEL_CON64 */
+	CLK_I2C6_SEL_SHIFT			= 0,
+	CLK_I2C6_SEL_MASK			= 0x3 << CLK_I2C6_SEL_SHIFT,
+
+	/* CRU_CLKSEL_CON74 */
+	CLK_SARADC_DIV_SHIFT			= 0,
+	CLK_SARADC_DIV_MASK			= 0x7 << CLK_SARADC_DIV_SHIFT,
+	CLK_TSADC_DIV_SHIFT			= 3,
+	CLK_TSADC_DIV_MASK			= 0x1F << CLK_TSADC_DIV_SHIFT,
+	CLK_TSADC_TSEN_DIV_SHIFT		= 8,
+	CLK_TSADC_TSEN_DIV_MASK			= 0x1F << CLK_TSADC_TSEN_DIV_SHIFT,
+
+	/* CRU_CLKSEL_CON79 */
+	CLK_I2C1_SEL_SHIFT			= 9,
+	CLK_I2C1_SEL_MASK			= 0x3 << CLK_I2C1_SEL_SHIFT,
+	CLK_I2C0_SEL_SHIFT			= 11,
+	CLK_I2C0_SEL_MASK			= 0x3 << CLK_I2C0_SEL_SHIFT,
+	CLK_SPI0_SEL_SHIFT			= 13,
+	CLK_SPI0_SEL_MASK			= 0x3 << CLK_SPI0_SEL_SHIFT,
+
+	/* CRU_CLKSEL_CON83 */
+	ACLK_VOP_ROOT_DIV_SHIFT			= 12,
+	ACLK_VOP_ROOT_DIV_MASK			= 0x7 << ACLK_VOP_ROOT_DIV_SHIFT,
+	ACLK_VOP_ROOT_SEL_SHIFT			= 15,
+	ACLK_VOP_ROOT_SEL_MASK			= 0x1 << ACLK_VOP_ROOT_SEL_SHIFT,
+
+	/* CRU_CLKSEL_CON84 */
+	DCLK_VOP0_SEL_SHIFT			= 0,
+	DCLK_VOP0_SEL_MASK			= 0x1 << DCLK_VOP0_SEL_SHIFT,
+	DCLK_VOP_SRC_SEL_CLK_GPLL_MUX		= 0U,
+	DCLK_VOP_SRC_SEL_CLK_CPLL_MUX		= 1U,
+	ACLK_VOP_ROOT_SEL_CLK_GPLL_MUX		= 0U,
+	ACLK_VOP_ROOT_SEL_CLK_CPLL_MUX		= 1U,
+	DCLK_VOP0_SEL_DCLK_VOP_SRC0		= 0U,
+	DCLK_VOP0_SEL_CLK_HDMIPHY_PIXEL_IO	= 1U,
+
+	/* CRU_CLKSEL_CON85 */
+	CLK_I2C4_SEL_SHIFT			= 13,
+	CLK_I2C4_SEL_MASK			= 0x3 << CLK_I2C4_SEL_SHIFT,
+	CLK_I2C7_SEL_SHIFT			= 0,
+	CLK_I2C7_SEL_MASK			= 0x3 << CLK_I2C7_SEL_SHIFT,
+	CLK_I2C3_SEL_CLK_MATRIX_200M_SRC	= 0U,
+	CLK_I2C3_SEL_CLK_MATRIX_100M_SRC	= 1U,
+	CLK_I2C3_SEL_CLK_MATRIX_50M_SRC		= 2U,
+	CLK_I2C3_SEL_XIN_OSC0_FUNC		= 3U,
+	CLK_SPI1_SEL_CLK_MATRIX_200M_SRC	= 0U,
+	CLK_SPI1_SEL_CLK_MATRIX_100M_SRC	= 1U,
+	CLK_SPI1_SEL_CLK_MATRIX_50M_SRC		= 2U,
+	CLK_SPI1_SEL_XIN_OSC0_FUNC		= 3U,
+	CCLK_SRC_SDMMC0_DIV_SHIFT		= 0,
+	CCLK_SRC_SDMMC0_DIV_MASK		= 0x3F << CCLK_SRC_SDMMC0_DIV_SHIFT,
+	CCLK_SRC_SDMMC0_SEL_SHIFT		= 6,
+	CCLK_SRC_SDMMC0_SEL_MASK		= 0x3 << CCLK_SRC_SDMMC0_SEL_SHIFT,
+	CCLK_SRC_EMMC_SEL_CLK_GPLL_MUX		= 0U,
+	CCLK_SRC_EMMC_SEL_CLK_CPLL_MUX		= 1U,
+	CCLK_SRC_EMMC_SEL_XIN_OSC0_FUNC		= 2U,
+	BCLK_EMMC_SEL_CLK_MATRIX_200M_SRC	= 0U,
+	BCLK_EMMC_SEL_CLK_MATRIX_100M_SRC	= 1U,
+	BCLK_EMMC_SEL_CLK_MATRIX_50M_SRC	= 2U,
+	BCLK_EMMC_SEL_XIN_OSC0_FUNC		= 3U,
+	CCLK_SRC_SDMMC0_SEL_CLK_GPLL_MUX	= 0U,
+	CCLK_SRC_SDMMC0_SEL_CLK_CPLL_MUX	= 1U,
+	CCLK_SRC_SDMMC0_SEL_XIN_OSC0_FUNC	= 2U,
+
+	/* CRU_CLKSEL_CON04 */
+	CLK_UART0_SRC_DIV_SHIFT			= 5,
+	CLK_UART0_SRC_DIV_MASK			= 0x1F << CLK_UART0_SRC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON05 */
+	CLK_UART0_FRAC_DIV_SHIFT		= 0,
+	CLK_UART0_FRAC_DIV_MASK			= 0xFFFFFFFF << CLK_UART0_FRAC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON06 */
+	SCLK_UART0_SRC_SEL_SHIFT		= 0,
+	SCLK_UART0_SRC_SEL_MASK			= 0x3 << SCLK_UART0_SRC_SEL_SHIFT,
+	CLK_UART1_SRC_DIV_SHIFT			= 2,
+	CLK_UART1_SRC_DIV_MASK			= 0x1F << CLK_UART1_SRC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON07 */
+	CLK_UART1_FRAC_DIV_SHIFT		= 0,
+	CLK_UART1_FRAC_DIV_MASK			= 0xFFFFFFFF << CLK_UART1_FRAC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON08 */
+	SCLK_UART1_SRC_SEL_SHIFT		= 0,
+	SCLK_UART1_SRC_SEL_MASK			= 0x3 << SCLK_UART1_SRC_SEL_SHIFT,
+	CLK_UART2_SRC_DIV_SHIFT			= 2,
+	CLK_UART2_SRC_DIV_MASK			= 0x1F << CLK_UART2_SRC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON09 */
+	CLK_UART2_FRAC_DIV_SHIFT		= 0,
+	CLK_UART2_FRAC_DIV_MASK			= 0xFFFFFFFF << CLK_UART2_FRAC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON10 */
+	SCLK_UART2_SRC_SEL_SHIFT		= 0,
+	SCLK_UART2_SRC_SEL_MASK			= 0x3 << SCLK_UART2_SRC_SEL_SHIFT,
+	CLK_UART3_SRC_DIV_SHIFT			= 2,
+	CLK_UART3_SRC_DIV_MASK			= 0x1F << CLK_UART3_SRC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON11 */
+	CLK_UART3_FRAC_DIV_SHIFT		= 0,
+	CLK_UART3_FRAC_DIV_MASK			= 0xFFFFFFFF << CLK_UART3_FRAC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON12 */
+	SCLK_UART3_SRC_SEL_SHIFT		= 0,
+	SCLK_UART3_SRC_SEL_MASK			= 0x3 << SCLK_UART3_SRC_SEL_SHIFT,
+	CLK_UART4_SRC_DIV_SHIFT			= 2,
+	CLK_UART4_SRC_DIV_MASK			= 0x1F << CLK_UART4_SRC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON13 */
+	CLK_UART4_FRAC_DIV_SHIFT		= 0,
+	CLK_UART4_FRAC_DIV_MASK			= 0xFFFFFFFF << CLK_UART4_FRAC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON14 */
+	SCLK_UART4_SRC_SEL_SHIFT		= 0,
+	SCLK_UART4_SRC_SEL_MASK			= 0x3 << SCLK_UART4_SRC_SEL_SHIFT,
+	CLK_UART5_SRC_DIV_SHIFT			= 2,
+	CLK_UART5_SRC_DIV_MASK			= 0x1F << CLK_UART5_SRC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON15 */
+	CLK_UART5_FRAC_DIV_SHIFT		= 0,
+	CLK_UART5_FRAC_DIV_MASK			= 0xFFFFFFFF << CLK_UART5_FRAC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON16 */
+	SCLK_UART5_SRC_SEL_SHIFT		= 0,
+	SCLK_UART5_SRC_SEL_MASK			= 0x3 << SCLK_UART5_SRC_SEL_SHIFT,
+	CLK_UART6_SRC_DIV_SHIFT			= 2,
+	CLK_UART6_SRC_DIV_MASK			= 0x1F << CLK_UART6_SRC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON17 */
+	CLK_UART6_FRAC_DIV_SHIFT		= 0,
+	CLK_UART6_FRAC_DIV_MASK			= 0xFFFFFFFF << CLK_UART6_FRAC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON18 */
+	SCLK_UART6_SRC_SEL_SHIFT		= 0,
+	SCLK_UART6_SRC_SEL_MASK			= 0x3 << SCLK_UART6_SRC_SEL_SHIFT,
+	CLK_UART7_SRC_DIV_SHIFT			= 2,
+	CLK_UART7_SRC_DIV_MASK			= 0x1F << CLK_UART7_SRC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON19 */
+	CLK_UART7_FRAC_DIV_SHIFT		= 0,
+	CLK_UART7_FRAC_DIV_MASK			= 0xFFFFFFFF << CLK_UART7_FRAC_DIV_SHIFT,
+	/* CRU_CLKSEL_CON20 */
+	SCLK_UART7_SRC_SEL_SHIFT		= 0,
+	SCLK_UART7_SRC_SEL_MASK			= 0x3 << SCLK_UART7_SRC_SEL_SHIFT,
+	SCLK_UART0_SRC_SEL_CLK_UART0_SRC	= 0U,
+	SCLK_UART0_SRC_SEL_CLK_UART0_FRAC	= 1U,
+	SCLK_UART0_SRC_SEL_XIN_OSC0_FUNC	= 2U,
+
+	/* CRU_CLKSEL_CON60 */
+	CLK_GMAC1_VPU_25M_DIV_SHIFT		= 2,
+	CLK_GMAC1_VPU_25M_DIV_MASK		= 0xFF << CLK_GMAC1_VPU_25M_DIV_SHIFT,
+	/* CRU_CLKSEL_CON66 */
+	CLK_GMAC1_SRC_VPU_DIV_SHIFT		= 0,
+	CLK_GMAC1_SRC_VPU_DIV_MASK		= 0x3F << CLK_GMAC1_SRC_VPU_DIV_SHIFT,
+	/* CRU_CLKSEL_CON84 */
+	CLK_GMAC0_SRC_DIV_SHIFT			= 3,
+	CLK_GMAC0_SRC_DIV_MASK			= 0x3F << CLK_GMAC0_SRC_DIV_SHIFT,
+};
+
+#endif /* _ASM_ARCH_CRU_RK3528_H */
diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 9e379cc2e3b6..70be03164e8f 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ROCKCHIP_RK3308) += clk_rk3308.o
 obj-$(CONFIG_ROCKCHIP_RK3328) += clk_rk3328.o
 obj-$(CONFIG_ROCKCHIP_RK3368) += clk_rk3368.o
 obj-$(CONFIG_ROCKCHIP_RK3399) += clk_rk3399.o
+obj-$(CONFIG_ROCKCHIP_RK3528) += clk_rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += clk_rk3568.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += clk_rk3588.o
 obj-$(CONFIG_ROCKCHIP_RV1108) += clk_rv1108.o
diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 44c6f14618d2..9dec40b1fe83 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -309,9 +309,11 @@ static int rk3036_pll_set_rate(struct rockchip_pll_clock *pll,
 	 * When power on or changing PLL setting,
 	 * we must force PLL into slow mode to ensure output stable clock.
 	 */
-	rk_clrsetreg(base + pll->mode_offset,
-		     pll->mode_mask << pll->mode_shift,
-		     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
+		rk_clrsetreg(base + pll->mode_offset,
+			     pll->mode_mask << pll->mode_shift,
+			     RKCLK_PLL_MODE_SLOW << pll->mode_shift);
+	}
 
 	/* Power down */
 	rk_setreg(base + pll->con_offset + 0x4,
@@ -345,8 +347,11 @@ static int rk3036_pll_set_rate(struct rockchip_pll_clock *pll,
 	while (!(readl(base + pll->con_offset + 0x4) & (1 << pll->lock_shift)))
 		udelay(1);
 
-	rk_clrsetreg(base + pll->mode_offset, pll->mode_mask << pll->mode_shift,
-		     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE)) {
+		rk_clrsetreg(base + pll->mode_offset,
+			     pll->mode_mask << pll->mode_shift,
+			     RKCLK_PLL_MODE_NORMAL << pll->mode_shift);
+	}
 	debug("PLL at %p: con0=%x con1= %x con2= %x mode= %x\n",
 	      pll, readl(base + pll->con_offset),
 	      readl(base + pll->con_offset + 0x4),
@@ -362,12 +367,18 @@ static ulong rk3036_pll_get_rate(struct rockchip_pll_clock *pll,
 	u32 refdiv, fbdiv, postdiv1, postdiv2, dsmpd, frac;
 	u32 con = 0, shift, mask;
 	ulong rate;
+	int mode;
 
 	con = readl(base + pll->mode_offset);
 	shift = pll->mode_shift;
 	mask = pll->mode_mask << shift;
 
-	switch ((con & mask) >> shift) {
+	if (!(pll->pll_flags & ROCKCHIP_PLL_FIXED_MODE))
+		mode = (con & mask) >> shift;
+	else
+		mode = RKCLK_PLL_MODE_NORMAL;
+
+	switch (mode) {
 	case RKCLK_PLL_MODE_SLOW:
 		return OSC_HZ;
 	case RKCLK_PLL_MODE_NORMAL:
diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
new file mode 100644
index 000000000000..06f20895accf
--- /dev/null
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -0,0 +1,1754 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ * Author: Joseph Chen <chenjh@rock-chips.com>
+ */
+
+#include <bitfield.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <syscon.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/cru_rk3528.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dt-bindings/clock/rockchip,rk3528-cru.h>
+#include <linux/delay.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define DIV_TO_RATE(input_rate, div)	((input_rate) / ((div) + 1))
+
+/*
+ *	PLL attention.
+ *
+ * [FRAC PLL]: GPLL, PPLL, DPLL
+ *   - frac mode: refdiv can be 1 or 2 only
+ *   - int mode:  refdiv has no special limit
+ *   - VCO range: [950, 3800] MHZ
+ *
+ * [INT PLL]:  CPLL, APLL
+ *   - int mode:  refdiv can be 1 or 2 only
+ *   - VCO range: [475, 1900] MHZ
+ *
+ * [PPLL]: normal mode only.
+ *
+ */
+static struct rockchip_pll_rate_table rk3528_pll_rates[] = {
+	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
+	RK3036_PLL_RATE(1896000000, 1, 79, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1800000000, 1, 75, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1704000000, 1, 71, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1608000000, 1, 67, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1512000000, 1, 63, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1416000000, 1, 59, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1296000000, 1, 54, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1200000000, 1, 50, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1188000000, 1, 99, 2, 1, 1, 0),		/* GPLL */
+	RK3036_PLL_RATE(1092000000, 2, 91, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1008000000, 1, 42, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1000000000, 1, 125, 3, 1, 1, 0),	/* PPLL */
+	RK3036_PLL_RATE(996000000, 2, 83, 1, 1, 1, 0),		/* CPLL */
+	RK3036_PLL_RATE(960000000, 1, 40, 1, 1, 1, 0),
+	RK3036_PLL_RATE(912000000, 1, 76, 2, 1, 1, 0),
+	RK3036_PLL_RATE(816000000, 1, 68, 2, 1, 1, 0),
+	RK3036_PLL_RATE(600000000, 1, 50, 2, 1, 1, 0),
+	RK3036_PLL_RATE(594000000, 2, 99, 2, 1, 1, 0),
+	RK3036_PLL_RATE(408000000, 1, 68, 2, 2, 1, 0),
+	RK3036_PLL_RATE(312000000, 1, 78, 6, 1, 1, 0),
+	RK3036_PLL_RATE(216000000, 1, 72, 4, 2, 1, 0),
+	RK3036_PLL_RATE(96000000, 1, 24, 3, 2, 1, 0),
+	{ /* sentinel */ },
+};
+
+static struct rockchip_pll_clock rk3528_pll_clks[] = {
+	[APLL] = PLL(pll_rk3328, PLL_APLL, RK3528_PLL_CON(0),
+		     RK3528_MODE_CON, 0, 10, 0, rk3528_pll_rates),
+
+	[CPLL] = PLL(pll_rk3328, PLL_CPLL, RK3528_PLL_CON(8),
+		     RK3528_MODE_CON, 2, 10, 0, rk3528_pll_rates),
+
+	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3528_PLL_CON(24),
+		     RK3528_MODE_CON, 4, 10, 0, rk3528_pll_rates),
+
+	[PPLL] = PLL(pll_rk3328, PLL_PPLL, RK3528_PCIE_PLL_CON(32),
+		     RK3528_MODE_CON, 6, 10, ROCKCHIP_PLL_FIXED_MODE, rk3528_pll_rates),
+
+	[DPLL] = PLL(pll_rk3328, PLL_DPLL, RK3528_DDRPHY_PLL_CON(16),
+		     RK3528_DDRPHY_MODE_CON, 0, 10, 0, rk3528_pll_rates),
+};
+
+#define RK3528_CPUCLK_RATE(_rate, _aclk_m_core, _pclk_dbg)	\
+{								\
+	.rate = _rate##U,					\
+	.aclk_div = (_aclk_m_core),				\
+	.pclk_div = (_pclk_dbg),				\
+}
+
+/* sign-off: _aclk_m_core: 550M, _pclk_dbg: 137.5M, */
+static struct rockchip_cpu_rate_table rk3528_cpu_rates[] = {
+	RK3528_CPUCLK_RATE(1896000000, 1, 13),
+	RK3528_CPUCLK_RATE(1800000000, 1, 12),
+	RK3528_CPUCLK_RATE(1704000000, 1, 11),
+	RK3528_CPUCLK_RATE(1608000000, 1, 11),
+	RK3528_CPUCLK_RATE(1512000000, 1, 11),
+	RK3528_CPUCLK_RATE(1416000000, 1, 9),
+	RK3528_CPUCLK_RATE(1296000000, 1, 8),
+	RK3528_CPUCLK_RATE(1200000000, 1, 8),
+	RK3528_CPUCLK_RATE(1188000000, 1, 8),
+	RK3528_CPUCLK_RATE(1092000000, 1, 7),
+	RK3528_CPUCLK_RATE(1008000000, 1, 6),
+	RK3528_CPUCLK_RATE(1000000000, 1, 6),
+	RK3528_CPUCLK_RATE(996000000, 1, 6),
+	RK3528_CPUCLK_RATE(960000000, 1, 6),
+	RK3528_CPUCLK_RATE(912000000, 1, 6),
+	RK3528_CPUCLK_RATE(816000000, 1, 5),
+	RK3528_CPUCLK_RATE(600000000, 1, 3),
+	RK3528_CPUCLK_RATE(594000000, 1, 3),
+	RK3528_CPUCLK_RATE(408000000, 1, 2),
+	RK3528_CPUCLK_RATE(312000000, 1, 2),
+	RK3528_CPUCLK_RATE(216000000, 1, 1),
+	RK3528_CPUCLK_RATE(96000000, 1, 0),
+};
+
+/*
+ *
+ * rational_best_approximation(31415, 10000,
+ *		(1 << 8) - 1, (1 << 5) - 1, &n, &d);
+ *
+ * you may look at given_numerator as a fixed point number,
+ * with the fractional part size described in given_denominator.
+ *
+ * for theoretical background, see:
+ * http://en.wikipedia.org/wiki/Continued_fraction
+ */
+static void rational_best_approximation(unsigned long given_numerator,
+					unsigned long given_denominator,
+					unsigned long max_numerator,
+					unsigned long max_denominator,
+					unsigned long *best_numerator,
+					unsigned long *best_denominator)
+{
+	unsigned long n, d, n0, d0, n1, d1;
+
+	n = given_numerator;
+	d = given_denominator;
+	n0 = 0;
+	d1 = 0;
+	n1 = 1;
+	d0 = 1;
+	for (;;) {
+		unsigned long t, a;
+
+		if (n1 > max_numerator || d1 > max_denominator) {
+			n1 = n0;
+			d1 = d0;
+			break;
+		}
+		if (d == 0)
+			break;
+		t = d;
+		a = n / d;
+		d = n % d;
+		n = t;
+		t = n0 + a * n1;
+		n0 = n1;
+		n1 = t;
+		t = d0 + a * d1;
+		d0 = d1;
+		d1 = t;
+	}
+	*best_numerator = n1;
+	*best_denominator = d1;
+}
+
+static int rk3528_armclk_set_clk(struct rk3528_clk_priv *priv, ulong new_rate)
+{
+	const struct rockchip_cpu_rate_table *rate;
+	struct rk3528_cru *cru = priv->cru;
+	ulong old_rate;
+
+	rate = rockchip_get_cpu_settings(rk3528_cpu_rates, new_rate);
+	if (!rate) {
+		printf("%s unsupported rate\n", __func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * set up dependent divisors for DBG and ACLK clocks.
+	 */
+	old_rate = rockchip_pll_get_rate(&rk3528_pll_clks[APLL], priv->cru, APLL);
+	if (old_rate > new_rate) {
+		if (rockchip_pll_set_rate(&rk3528_pll_clks[APLL],
+					  priv->cru, APLL, new_rate))
+			return -EINVAL;
+
+		rk_clrsetreg(&cru->clksel_con[40], RK3528_DIV_PCLK_DBG_MASK,
+			     rate->pclk_div << RK3528_DIV_PCLK_DBG_SHIFT);
+
+		rk_clrsetreg(&cru->clksel_con[39], RK3528_DIV_ACLK_M_CORE_MASK,
+			     rate->aclk_div << RK3528_DIV_ACLK_M_CORE_SHIFT);
+	} else if (old_rate < new_rate) {
+		rk_clrsetreg(&cru->clksel_con[40], RK3528_DIV_PCLK_DBG_MASK,
+			     rate->pclk_div << RK3528_DIV_PCLK_DBG_SHIFT);
+
+		rk_clrsetreg(&cru->clksel_con[39], RK3528_DIV_ACLK_M_CORE_MASK,
+			     rate->aclk_div << RK3528_DIV_ACLK_M_CORE_SHIFT);
+
+		if (rockchip_pll_set_rate(&rk3528_pll_clks[APLL],
+					  priv->cru, APLL, new_rate))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ulong rk3528_ppll_matrix_get_rate(struct rk3528_clk_priv *priv,
+					 ulong clk_id)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div, mask, shift;
+	void *reg;
+
+	switch (clk_id) {
+	case CLK_PPLL_50M_MATRIX:
+	case CLK_GMAC1_RMII_VPU:
+		mask = PCIE_CLK_MATRIX_50M_SRC_DIV_MASK;
+		shift = PCIE_CLK_MATRIX_50M_SRC_DIV_SHIFT;
+		reg = &cru->pcieclksel_con[1];
+		break;
+
+	case CLK_PPLL_100M_MATRIX:
+		mask = PCIE_CLK_MATRIX_100M_SRC_DIV_MASK;
+		shift = PCIE_CLK_MATRIX_100M_SRC_DIV_SHIFT;
+		reg = &cru->pcieclksel_con[1];
+		break;
+
+	case CLK_PPLL_125M_MATRIX:
+	case CLK_GMAC1_SRC_VPU:
+		mask = CLK_MATRIX_125M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_125M_SRC_DIV_SHIFT;
+		reg = &cru->clksel_con[60];
+		break;
+
+	case CLK_GMAC1_VPU_25M:
+		mask = CLK_MATRIX_25M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_25M_SRC_DIV_SHIFT;
+		reg = &cru->clksel_con[60];
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	div = (readl(reg) & mask) >> shift;
+
+	return DIV_TO_RATE(priv->ppll_hz, div);
+}
+
+static ulong rk3528_ppll_matrix_set_rate(struct rk3528_clk_priv *priv,
+					 ulong clk_id, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 id, div, mask, shift;
+	u8 is_pciecru = 0;
+
+	switch (clk_id) {
+	case CLK_PPLL_50M_MATRIX:
+		id = 1;
+		mask = PCIE_CLK_MATRIX_50M_SRC_DIV_MASK;
+		shift = PCIE_CLK_MATRIX_50M_SRC_DIV_SHIFT;
+		is_pciecru = 1;
+		break;
+
+	case CLK_PPLL_100M_MATRIX:
+		id = 1;
+		mask = PCIE_CLK_MATRIX_100M_SRC_DIV_MASK;
+		shift = PCIE_CLK_MATRIX_100M_SRC_DIV_SHIFT;
+		is_pciecru = 1;
+		break;
+
+	case CLK_PPLL_125M_MATRIX:
+		id = 60;
+		mask = CLK_MATRIX_125M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_125M_SRC_DIV_SHIFT;
+		break;
+	case CLK_GMAC1_VPU_25M:
+		id = 60;
+		mask = CLK_MATRIX_25M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_25M_SRC_DIV_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	div = DIV_ROUND_UP(priv->ppll_hz, rate);
+	if (is_pciecru)
+		rk_clrsetreg(&cru->pcieclksel_con[id], mask, (div - 1) << shift);
+	else
+		rk_clrsetreg(&cru->clksel_con[id], mask, (div - 1) << shift);
+
+	return rk3528_ppll_matrix_get_rate(priv, clk_id);
+}
+
+static ulong rk3528_cgpll_matrix_get_rate(struct rk3528_clk_priv *priv,
+					  ulong clk_id)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 sel, div, mask, shift, con;
+	u32 sel_mask = 0, sel_shift;
+	u8 is_gpll_parent = 1;
+	u8 is_halfdiv = 0;
+	ulong prate;
+
+	switch (clk_id) {
+	case CLK_MATRIX_50M_SRC:
+		con = 0;
+		mask = CLK_MATRIX_50M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_50M_SRC_DIV_SHIFT;
+		is_gpll_parent = 0;
+		break;
+
+	case CLK_MATRIX_100M_SRC:
+		con = 0;
+		mask = CLK_MATRIX_100M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_100M_SRC_DIV_SHIFT;
+		is_gpll_parent = 0;
+		break;
+
+	case CLK_MATRIX_150M_SRC:
+		con = 1;
+		mask = CLK_MATRIX_150M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_150M_SRC_DIV_SHIFT;
+		break;
+
+	case CLK_MATRIX_200M_SRC:
+		con = 1;
+		mask = CLK_MATRIX_200M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_200M_SRC_DIV_SHIFT;
+		break;
+
+	case CLK_MATRIX_250M_SRC:
+		con = 1;
+		mask = CLK_MATRIX_250M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_250M_SRC_DIV_SHIFT;
+		sel_mask = CLK_MATRIX_250M_SRC_SEL_MASK;
+		sel_shift = CLK_MATRIX_250M_SRC_SEL_SHIFT;
+		break;
+
+	case CLK_MATRIX_300M_SRC:
+		con = 2;
+		mask = CLK_MATRIX_300M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_300M_SRC_DIV_SHIFT;
+		break;
+
+	case CLK_MATRIX_339M_SRC:
+		con = 2;
+		mask = CLK_MATRIX_339M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_339M_SRC_DIV_SHIFT;
+		is_halfdiv = 1;
+		break;
+
+	case CLK_MATRIX_400M_SRC:
+		con = 2;
+		mask = CLK_MATRIX_400M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_400M_SRC_DIV_SHIFT;
+		break;
+
+	case CLK_MATRIX_500M_SRC:
+		con = 3;
+		mask = CLK_MATRIX_500M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_500M_SRC_DIV_SHIFT;
+		sel_mask = CLK_MATRIX_500M_SRC_SEL_MASK;
+		sel_shift = CLK_MATRIX_500M_SRC_SEL_SHIFT;
+		break;
+
+	case CLK_MATRIX_600M_SRC:
+		con = 4;
+		mask = CLK_MATRIX_600M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_600M_SRC_DIV_SHIFT;
+		break;
+
+	case ACLK_BUS_VOPGL_ROOT:
+	case ACLK_BUS_VOPGL_BIU:
+		con = 43;
+		mask = ACLK_BUS_VOPGL_ROOT_DIV_MASK;
+		shift = ACLK_BUS_VOPGL_ROOT_DIV_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	if (sel_mask) {
+		sel = (readl(&cru->clksel_con[con]) & sel_mask) >> sel_shift;
+		if (sel == CLK_MATRIX_250M_SRC_SEL_CLK_GPLL_MUX) // TODO
+			prate = priv->gpll_hz;
+		else
+			prate = priv->cpll_hz;
+	} else {
+		if (is_gpll_parent)
+			prate = priv->gpll_hz;
+		else
+			prate = priv->cpll_hz;
+	}
+
+	div = (readl(&cru->clksel_con[con]) & mask) >> shift;
+
+	/* NOTE: '-1' to balance the DIV_TO_RATE() 'div+1' */
+	return is_halfdiv ? DIV_TO_RATE(prate * 2, (3 + 2 * div) - 1) : DIV_TO_RATE(prate, div);
+}
+
+static ulong rk3528_cgpll_matrix_set_rate(struct rk3528_clk_priv *priv,
+					  ulong clk_id, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 sel, div, mask, shift, con;
+	u32 sel_mask = 0, sel_shift;
+	u8 is_gpll_parent = 1;
+	u8 is_halfdiv = 0;
+	ulong prate = 0;
+
+	switch (clk_id) {
+	case CLK_MATRIX_50M_SRC:
+		con = 0;
+		mask = CLK_MATRIX_50M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_50M_SRC_DIV_SHIFT;
+		is_gpll_parent = 0;
+		break;
+
+	case CLK_MATRIX_100M_SRC:
+		con = 0;
+		mask = CLK_MATRIX_100M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_100M_SRC_DIV_SHIFT;
+		is_gpll_parent = 0;
+		break;
+
+	case CLK_MATRIX_150M_SRC:
+		con = 1;
+		mask = CLK_MATRIX_150M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_150M_SRC_DIV_SHIFT;
+		break;
+
+	case CLK_MATRIX_200M_SRC:
+		con = 1;
+		mask = CLK_MATRIX_200M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_200M_SRC_DIV_SHIFT;
+		break;
+
+	case CLK_MATRIX_250M_SRC:
+		con = 1;
+		mask = CLK_MATRIX_250M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_250M_SRC_DIV_SHIFT;
+		sel_mask = CLK_MATRIX_250M_SRC_SEL_MASK;
+		sel_shift = CLK_MATRIX_250M_SRC_SEL_SHIFT;
+		break;
+
+	case CLK_MATRIX_300M_SRC:
+		con = 2;
+		mask = CLK_MATRIX_300M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_300M_SRC_DIV_SHIFT;
+		break;
+
+	case CLK_MATRIX_339M_SRC:
+		con = 2;
+		mask = CLK_MATRIX_339M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_339M_SRC_DIV_SHIFT;
+		is_halfdiv = 1;
+		break;
+
+	case CLK_MATRIX_400M_SRC:
+		con = 2;
+		mask = CLK_MATRIX_400M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_400M_SRC_DIV_SHIFT;
+		break;
+
+	case CLK_MATRIX_500M_SRC:
+		con = 3;
+		mask = CLK_MATRIX_500M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_500M_SRC_DIV_SHIFT;
+		sel_mask = CLK_MATRIX_500M_SRC_SEL_MASK;
+		sel_shift = CLK_MATRIX_500M_SRC_SEL_SHIFT;
+		break;
+
+	case CLK_MATRIX_600M_SRC:
+		con = 4;
+		mask = CLK_MATRIX_600M_SRC_DIV_MASK;
+		shift = CLK_MATRIX_600M_SRC_DIV_SHIFT;
+		break;
+
+	case ACLK_BUS_VOPGL_ROOT:
+	case ACLK_BUS_VOPGL_BIU:
+		con = 43;
+		mask = ACLK_BUS_VOPGL_ROOT_DIV_MASK;
+		shift = ACLK_BUS_VOPGL_ROOT_DIV_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	if (sel_mask) {
+		if (priv->gpll_hz % rate == 0) {
+			sel = CLK_MATRIX_250M_SRC_SEL_CLK_GPLL_MUX; // TODO
+			prate = priv->gpll_hz;
+		} else {
+			sel = CLK_MATRIX_250M_SRC_SEL_CLK_CPLL_MUX;
+			prate = priv->cpll_hz;
+		}
+	} else {
+		if (is_gpll_parent)
+			prate = priv->gpll_hz;
+		else
+			prate = priv->cpll_hz;
+	}
+
+	if (is_halfdiv)
+		/* NOTE: '+1' to balance the following rk_clrsetreg() 'div-1' */
+		div = DIV_ROUND_UP((prate * 2) - (3 * rate), 2 * rate) + 1;
+	else
+		div = DIV_ROUND_UP(prate, rate);
+
+	rk_clrsetreg(&cru->clksel_con[con], mask, (div - 1) << shift);
+	if (sel_mask)
+		rk_clrsetreg(&cru->clksel_con[con], sel_mask, sel << sel_shift);
+
+	return rk3528_cgpll_matrix_get_rate(priv, clk_id);
+}
+
+static ulong rk3528_i2c_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 id, sel, con, mask, shift;
+	u8 is_pmucru = 0;
+	ulong rate;
+
+	switch (clk_id) {
+	case CLK_I2C0:
+		id = 79;
+		mask = CLK_I2C0_SEL_MASK;
+		shift = CLK_I2C0_SEL_SHIFT;
+		break;
+
+	case CLK_I2C1:
+		id = 79;
+		mask = CLK_I2C1_SEL_MASK;
+		shift = CLK_I2C1_SEL_SHIFT;
+		break;
+
+	case CLK_I2C2:
+		id = 0;
+		mask = CLK_I2C2_SEL_MASK;
+		shift = CLK_I2C2_SEL_SHIFT;
+		is_pmucru = 1;
+		break;
+
+	case CLK_I2C3:
+		id = 63;
+		mask = CLK_I2C3_SEL_MASK;
+		shift = CLK_I2C3_SEL_SHIFT;
+		break;
+
+	case CLK_I2C4:
+		id = 85;
+		mask = CLK_I2C4_SEL_MASK;
+		shift = CLK_I2C4_SEL_SHIFT;
+		break;
+
+	case CLK_I2C5:
+		id = 63;
+		mask = CLK_I2C5_SEL_MASK;
+		shift = CLK_I2C5_SEL_SHIFT;
+		break;
+
+	case CLK_I2C6:
+		id = 64;
+		mask = CLK_I2C6_SEL_MASK;
+		shift = CLK_I2C6_SEL_SHIFT;
+		break;
+
+	case CLK_I2C7:
+		id = 86;
+		mask = CLK_I2C7_SEL_MASK;
+		shift = CLK_I2C7_SEL_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	if (is_pmucru)
+		con = readl(&cru->pmuclksel_con[id]);
+	else
+		con = readl(&cru->clksel_con[id]);
+	sel = (con & mask) >> shift;
+	if (sel == CLK_I2C3_SEL_CLK_MATRIX_200M_SRC)
+		rate = 200 * MHz;
+	else if (sel == CLK_I2C3_SEL_CLK_MATRIX_100M_SRC)
+		rate = 100 * MHz;
+	else if (sel == CLK_I2C3_SEL_CLK_MATRIX_50M_SRC)
+		rate = 50 * MHz;
+	else
+		rate = OSC_HZ;
+
+	return rate;
+}
+
+static ulong rk3528_i2c_set_clk(struct rk3528_clk_priv *priv, ulong clk_id,
+				ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 id, sel, mask, shift;
+	u8 is_pmucru = 0;
+
+	if (rate >= 198 * MHz)
+		sel = CLK_I2C3_SEL_CLK_MATRIX_200M_SRC;
+	else if (rate >= 99 * MHz)
+		sel = CLK_I2C3_SEL_CLK_MATRIX_100M_SRC;
+	else if (rate >= 50 * MHz)
+		sel = CLK_I2C3_SEL_CLK_MATRIX_50M_SRC;
+	else
+		sel = CLK_I2C3_SEL_XIN_OSC0_FUNC;
+
+	switch (clk_id) {
+	case CLK_I2C0:
+		id = 79;
+		mask = CLK_I2C0_SEL_MASK;
+		shift = CLK_I2C0_SEL_SHIFT;
+		break;
+
+	case CLK_I2C1:
+		id = 79;
+		mask = CLK_I2C1_SEL_MASK;
+		shift = CLK_I2C1_SEL_SHIFT;
+		break;
+
+	case CLK_I2C2:
+		id = 0;
+		mask = CLK_I2C2_SEL_MASK;
+		shift = CLK_I2C2_SEL_SHIFT;
+		is_pmucru = 1;
+		break;
+
+	case CLK_I2C3:
+		id = 63;
+		mask = CLK_I2C3_SEL_MASK;
+		shift = CLK_I2C3_SEL_SHIFT;
+		break;
+
+	case CLK_I2C4:
+		id = 85;
+		mask = CLK_I2C4_SEL_MASK;
+		shift = CLK_I2C4_SEL_SHIFT;
+		break;
+
+	case CLK_I2C5:
+		id = 63;
+		mask = CLK_I2C5_SEL_MASK;
+		shift = CLK_I2C5_SEL_SHIFT;
+		break;
+
+	case CLK_I2C6:
+		id = 64;
+		mask = CLK_I2C6_SEL_MASK;
+		shift = CLK_I2C6_SEL_SHIFT;
+		break;
+
+	case CLK_I2C7:
+		id = 86;
+		mask = CLK_I2C7_SEL_MASK;
+		shift = CLK_I2C7_SEL_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	if (is_pmucru)
+		rk_clrsetreg(&cru->pmuclksel_con[id], mask, sel << shift);
+	else
+		rk_clrsetreg(&cru->clksel_con[id], mask, sel << shift);
+
+	return rk3528_i2c_get_clk(priv, clk_id);
+}
+
+static ulong rk3528_spi_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 id, sel, con, mask, shift;
+	ulong rate;
+
+	switch (clk_id) {
+	case CLK_SPI0:
+		id = 79;
+		mask = CLK_SPI0_SEL_MASK;
+		shift = CLK_SPI0_SEL_SHIFT;
+		break;
+
+	case CLK_SPI1:
+		id = 63;
+		mask = CLK_SPI1_SEL_MASK;
+		shift = CLK_SPI1_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	con = readl(&cru->clksel_con[id]);
+	sel = (con & mask) >> shift;
+	if (sel == CLK_SPI1_SEL_CLK_MATRIX_200M_SRC)
+		rate = 200 * MHz;
+	else if (sel == CLK_SPI1_SEL_CLK_MATRIX_100M_SRC)
+		rate = 100 * MHz;
+	else if (sel == CLK_SPI1_SEL_CLK_MATRIX_50M_SRC)
+		rate = 50 * MHz;
+	else
+		rate = OSC_HZ;
+
+	return rate;
+}
+
+static ulong rk3528_spi_set_clk(struct rk3528_clk_priv *priv,
+				ulong clk_id, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 id, sel, mask, shift;
+
+	if (rate >= 198 * MHz)
+		sel = CLK_SPI1_SEL_CLK_MATRIX_200M_SRC;
+	else if (rate >= 99 * MHz)
+		sel = CLK_SPI1_SEL_CLK_MATRIX_100M_SRC;
+	else if (rate >= 50 * MHz)
+		sel = CLK_SPI1_SEL_CLK_MATRIX_50M_SRC;
+	else
+		sel = CLK_SPI1_SEL_XIN_OSC0_FUNC;
+
+	switch (clk_id) {
+	case CLK_SPI0:
+		id = 79;
+		mask = CLK_SPI0_SEL_MASK;
+		shift = CLK_SPI0_SEL_SHIFT;
+		break;
+
+	case CLK_SPI1:
+		id = 63;
+		mask = CLK_SPI1_SEL_MASK;
+		shift = CLK_SPI1_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	rk_clrsetreg(&cru->clksel_con[id], mask, sel << shift);
+
+	return rk3528_spi_get_clk(priv, clk_id);
+}
+
+static ulong rk3528_pwm_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 id, sel, con, mask, shift;
+	ulong rate;
+
+	switch (clk_id) {
+	case CLK_PWM0:
+		id = 44;
+		mask = CLK_PWM0_SEL_MASK;
+		shift = CLK_PWM0_SEL_SHIFT;
+		break;
+
+	case CLK_PWM1:
+		id = 44;
+		mask = CLK_PWM1_SEL_MASK;
+		shift = CLK_PWM1_SEL_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	con = readl(&cru->clksel_con[id]);
+	sel = (con & mask) >> shift;
+	if (sel == CLK_PWM0_SEL_CLK_MATRIX_100M_SRC)
+		rate = 100 * MHz;
+	if (sel == CLK_PWM0_SEL_CLK_MATRIX_50M_SRC)
+		rate = 50 * MHz;
+	else
+		rate = OSC_HZ;
+
+	return rate;
+}
+
+static ulong rk3528_pwm_set_clk(struct rk3528_clk_priv *priv,
+				ulong clk_id, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 id, sel, mask, shift;
+
+	if (rate >= 99 * MHz)
+		sel = CLK_PWM0_SEL_CLK_MATRIX_100M_SRC;
+	else if (rate >= 50 * MHz)
+		sel = CLK_PWM0_SEL_CLK_MATRIX_50M_SRC;
+	else
+		sel = CLK_PWM0_SEL_XIN_OSC0_FUNC;
+
+	switch (clk_id) {
+	case CLK_PWM0:
+		id = 44;
+		mask = CLK_PWM0_SEL_MASK;
+		shift = CLK_PWM0_SEL_SHIFT;
+		break;
+
+	case CLK_PWM1:
+		id = 44;
+		mask = CLK_PWM1_SEL_MASK;
+		shift = CLK_PWM1_SEL_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	rk_clrsetreg(&cru->clksel_con[id], mask, sel << shift);
+
+	return rk3528_pwm_get_clk(priv, clk_id);
+}
+
+static ulong rk3528_adc_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div, con;
+
+	con = readl(&cru->clksel_con[74]);
+	switch (clk_id) {
+	case CLK_SARADC:
+		div = (con & CLK_SARADC_DIV_MASK) >>
+			CLK_SARADC_DIV_SHIFT;
+		break;
+
+	case CLK_TSADC_TSEN:
+		div = (con & CLK_TSADC_TSEN_DIV_MASK) >>
+			CLK_TSADC_TSEN_DIV_SHIFT;
+		break;
+
+	case CLK_TSADC:
+		div = (con & CLK_TSADC_DIV_MASK) >>
+			CLK_TSADC_DIV_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	return DIV_TO_RATE(OSC_HZ, div);
+}
+
+static ulong rk3528_adc_set_clk(struct rk3528_clk_priv *priv,
+				ulong clk_id, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div, mask, shift;
+
+	switch (clk_id) {
+	case CLK_SARADC:
+		mask = CLK_SARADC_DIV_MASK;
+		shift =	CLK_SARADC_DIV_SHIFT;
+		break;
+
+	case CLK_TSADC_TSEN:
+		mask = CLK_TSADC_TSEN_DIV_MASK;
+		shift =	CLK_TSADC_TSEN_DIV_SHIFT;
+		break;
+
+	case CLK_TSADC:
+		mask = CLK_TSADC_DIV_MASK;
+		shift =	CLK_TSADC_DIV_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	div = DIV_ROUND_UP(OSC_HZ, rate);
+	rk_clrsetreg(&cru->clksel_con[74], mask, (div - 1) << shift);
+
+	return rk3528_adc_get_clk(priv, clk_id);
+}
+
+static ulong rk3528_sdmmc_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div, sel, con;
+	ulong prate;
+
+	con = readl(&cru->clksel_con[85]);
+	div = (con & CCLK_SRC_SDMMC0_DIV_MASK) >>
+		CCLK_SRC_SDMMC0_DIV_SHIFT;
+	sel = (con & CCLK_SRC_SDMMC0_SEL_MASK) >>
+		CCLK_SRC_SDMMC0_SEL_SHIFT;
+
+	if (sel == CCLK_SRC_SDMMC0_SEL_CLK_GPLL_MUX)
+		prate = priv->gpll_hz;
+	else if (sel == CCLK_SRC_SDMMC0_SEL_CLK_CPLL_MUX)
+		prate = priv->cpll_hz;
+	else
+		prate = OSC_HZ;
+
+	return DIV_TO_RATE(prate, div);
+}
+
+static ulong rk3528_sdmmc_set_clk(struct rk3528_clk_priv *priv,
+				  ulong clk_id, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div, sel;
+
+	if (OSC_HZ % rate == 0) {
+		div = DIV_ROUND_UP(OSC_HZ, rate);
+		sel = CCLK_SRC_SDMMC0_SEL_XIN_OSC0_FUNC;
+	} else if ((priv->cpll_hz % rate) == 0) {
+		div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		sel = CCLK_SRC_SDMMC0_SEL_CLK_CPLL_MUX;
+	} else {
+		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		sel = CCLK_SRC_SDMMC0_SEL_CLK_GPLL_MUX;
+	}
+
+	assert(div - 1 <= 63);
+	rk_clrsetreg(&cru->clksel_con[85],
+		     CCLK_SRC_SDMMC0_SEL_MASK |
+		     CCLK_SRC_SDMMC0_DIV_MASK,
+		     sel << CCLK_SRC_SDMMC0_SEL_SHIFT |
+		     (div - 1) << CCLK_SRC_SDMMC0_DIV_SHIFT);
+
+	return rk3528_sdmmc_get_clk(priv, clk_id);
+}
+
+static ulong rk3528_sfc_get_clk(struct rk3528_clk_priv *priv)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div, sel, con, parent;
+
+	con = readl(&cru->clksel_con[61]);
+	div = (con & SCLK_SFC_DIV_MASK) >>
+		SCLK_SFC_DIV_SHIFT;
+	sel = (con & SCLK_SFC_SEL_MASK) >>
+		SCLK_SFC_SEL_SHIFT;
+	if (sel == SCLK_SFC_SEL_CLK_GPLL_MUX)
+		parent = priv->gpll_hz;
+	else if (sel == SCLK_SFC_SEL_CLK_CPLL_MUX)
+		parent = priv->cpll_hz;
+	else
+		parent = OSC_HZ;
+
+	return DIV_TO_RATE(parent, div);
+}
+
+static ulong rk3528_sfc_set_clk(struct rk3528_clk_priv *priv, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	int div, sel;
+
+	if (OSC_HZ % rate == 0) {
+		div = DIV_ROUND_UP(OSC_HZ, rate);
+		sel = SCLK_SFC_SEL_XIN_OSC0_FUNC;
+	} else if ((priv->cpll_hz % rate) == 0) {
+		div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		sel = SCLK_SFC_SEL_CLK_CPLL_MUX;
+	} else {
+		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		sel = SCLK_SFC_SEL_CLK_GPLL_MUX;
+	}
+
+	assert(div - 1 <= 63);
+	rk_clrsetreg(&cru->clksel_con[61],
+		     SCLK_SFC_SEL_MASK |
+		     SCLK_SFC_DIV_MASK,
+		     sel << SCLK_SFC_SEL_SHIFT |
+		     (div - 1) << SCLK_SFC_DIV_SHIFT);
+
+	return rk3528_sfc_get_clk(priv);
+}
+
+static ulong rk3528_emmc_get_clk(struct rk3528_clk_priv *priv)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div, sel, con, parent;
+
+	con = readl(&cru->clksel_con[62]);
+	div = (con & CCLK_SRC_EMMC_DIV_MASK) >>
+		CCLK_SRC_EMMC_DIV_SHIFT;
+	sel = (con & CCLK_SRC_EMMC_SEL_MASK) >>
+		CCLK_SRC_EMMC_SEL_SHIFT;
+
+	if (sel == CCLK_SRC_EMMC_SEL_CLK_GPLL_MUX)
+		parent = priv->gpll_hz;
+	else if (sel == CCLK_SRC_EMMC_SEL_CLK_CPLL_MUX)
+		parent = priv->cpll_hz;
+	else
+		parent = OSC_HZ;
+
+	return DIV_TO_RATE(parent, div);
+}
+
+static ulong rk3528_emmc_set_clk(struct rk3528_clk_priv *priv, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div, sel;
+
+	if (OSC_HZ % rate == 0) {
+		div = DIV_ROUND_UP(OSC_HZ, rate);
+		sel = CCLK_SRC_EMMC_SEL_XIN_OSC0_FUNC;
+	} else if ((priv->cpll_hz % rate) == 0) {
+		div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		sel = CCLK_SRC_EMMC_SEL_CLK_CPLL_MUX;
+	} else {
+		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		sel = CCLK_SRC_EMMC_SEL_CLK_GPLL_MUX;
+	}
+
+	assert(div - 1 <= 63);
+	rk_clrsetreg(&cru->clksel_con[62],
+		     CCLK_SRC_EMMC_SEL_MASK |
+		     CCLK_SRC_EMMC_DIV_MASK,
+		     sel << CCLK_SRC_EMMC_SEL_SHIFT |
+		     (div - 1) << CCLK_SRC_EMMC_DIV_SHIFT);
+
+	return rk3528_emmc_get_clk(priv);
+}
+
+static ulong rk3528_dclk_vop_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div_mask, div_shift;
+	u32 sel_mask, sel_shift;
+	u32 id, con, sel, div;
+	ulong prate;
+
+	switch (clk_id) {
+	case DCLK_VOP0:
+		id = 32;
+		sel_mask = DCLK_VOP_SRC0_SEL_MASK;
+		sel_shift = DCLK_VOP_SRC0_SEL_SHIFT;
+		/* FIXME if need src: clk_hdmiphy_pixel_io */
+		div_mask = DCLK_VOP_SRC0_DIV_MASK;
+		div_shift = DCLK_VOP_SRC0_DIV_SHIFT;
+		break;
+
+	case DCLK_VOP1:
+		id = 33;
+		sel_mask = DCLK_VOP_SRC1_SEL_MASK;
+		sel_shift = DCLK_VOP_SRC1_SEL_SHIFT;
+		div_mask = DCLK_VOP_SRC1_DIV_MASK;
+		div_shift = DCLK_VOP_SRC1_DIV_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	con = readl(&cru->clksel_con[id]);
+	div = (con & div_mask) >> div_shift;
+	sel = (con & sel_mask) >> sel_shift;
+	if (sel == DCLK_VOP_SRC_SEL_CLK_GPLL_MUX)
+		prate = priv->gpll_hz;
+	else
+		prate = priv->cpll_hz;
+
+	return DIV_TO_RATE(prate, div);
+}
+
+static ulong rk3528_dclk_vop_set_clk(struct rk3528_clk_priv *priv,
+				     ulong clk_id, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 div_mask, div_shift;
+	u32 sel_mask, sel_shift;
+	u32 id, sel, div;
+	ulong prate;
+
+	switch (clk_id) {
+	case DCLK_VOP0:
+		id = 32;
+		sel_mask = DCLK_VOP_SRC0_SEL_MASK;
+		sel_shift = DCLK_VOP_SRC0_SEL_SHIFT;
+		/* FIXME if need src: clk_hdmiphy_pixel_io */
+		div_mask = DCLK_VOP_SRC0_DIV_MASK;
+		div_shift = DCLK_VOP_SRC0_DIV_SHIFT;
+		break;
+
+	case DCLK_VOP1:
+		id = 33;
+		sel_mask = DCLK_VOP_SRC1_SEL_MASK;
+		sel_shift = DCLK_VOP_SRC1_SEL_SHIFT;
+		div_mask = DCLK_VOP_SRC1_DIV_MASK;
+		div_shift = DCLK_VOP_SRC1_DIV_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	if ((priv->gpll_hz % rate) == 0) {
+		prate = priv->gpll_hz;
+		sel = (DCLK_VOP_SRC_SEL_CLK_GPLL_MUX << sel_shift) & sel_mask;
+	} else {
+		prate = priv->cpll_hz;
+		sel = (DCLK_VOP_SRC_SEL_CLK_CPLL_MUX << sel_shift) & sel_mask;
+	}
+
+	div = ((DIV_ROUND_UP(prate, rate) - 1) << div_shift) & div_mask;
+	rk_clrsetreg(&cru->clksel_con[id], sel, div);
+
+	return rk3528_dclk_vop_get_clk(priv, clk_id);
+}
+
+static ulong rk3528_uart_get_rate(struct rk3528_clk_priv *priv, ulong clk_id)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 sel_shift, sel_mask, div_shift, div_mask;
+	u32 sel, id, con, frac_div, div;
+	ulong m, n, rate;
+
+	switch (clk_id) {
+	case SCLK_UART0:
+		id = 6;
+		sel_shift = SCLK_UART0_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART0_SRC_SEL_MASK;
+		div_shift = CLK_UART0_SRC_DIV_SHIFT;
+		div_mask = CLK_UART0_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART1:
+		id = 8;
+		sel_shift = SCLK_UART1_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART1_SRC_SEL_MASK;
+		div_shift = CLK_UART1_SRC_DIV_SHIFT;
+		div_mask = CLK_UART1_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART2:
+		id = 10;
+		sel_shift = SCLK_UART2_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART2_SRC_SEL_MASK;
+		div_shift = CLK_UART2_SRC_DIV_SHIFT;
+		div_mask = CLK_UART2_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART3:
+		id = 12;
+		sel_shift = SCLK_UART3_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART3_SRC_SEL_MASK;
+		div_shift = CLK_UART3_SRC_DIV_SHIFT;
+		div_mask = CLK_UART3_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART4:
+		id = 14;
+		sel_shift = SCLK_UART4_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART4_SRC_SEL_MASK;
+		div_shift = CLK_UART4_SRC_DIV_SHIFT;
+		div_mask = CLK_UART4_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART5:
+		id = 16;
+		sel_shift = SCLK_UART5_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART5_SRC_SEL_MASK;
+		div_shift = CLK_UART5_SRC_DIV_SHIFT;
+		div_mask = CLK_UART5_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART6:
+		id = 18;
+		sel_shift = SCLK_UART6_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART6_SRC_SEL_MASK;
+		div_shift = CLK_UART6_SRC_DIV_SHIFT;
+		div_mask = CLK_UART6_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART7:
+		id = 20;
+		sel_shift = SCLK_UART7_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART7_SRC_SEL_MASK;
+		div_shift = CLK_UART7_SRC_DIV_SHIFT;
+		div_mask = CLK_UART7_SRC_DIV_MASK;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	con = readl(&cru->clksel_con[id - 2]);
+	div = (con & div_mask) >> div_shift;
+
+	con = readl(&cru->clksel_con[id]);
+	sel = (con & sel_mask) >> sel_shift;
+
+	if (sel == SCLK_UART0_SRC_SEL_CLK_UART0_SRC) {
+		rate = DIV_TO_RATE(priv->gpll_hz, div);
+	} else if (sel == SCLK_UART0_SRC_SEL_CLK_UART0_FRAC) {
+		frac_div = readl(&cru->clksel_con[id - 1]);
+		n = (frac_div & 0xffff0000) >> 16;
+		m = frac_div & 0x0000ffff;
+		rate = DIV_TO_RATE(priv->gpll_hz, div) * n / m;
+	} else {
+		rate = OSC_HZ;
+	}
+
+	return rate;
+}
+
+static ulong rk3528_uart_set_rate(struct rk3528_clk_priv *priv,
+				  ulong clk_id, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 sel_shift, sel_mask, div_shift, div_mask;
+	u32 sel, id, div;
+	ulong m = 0, n = 0, val;
+
+	if (rate == OSC_HZ) {
+		sel = SCLK_UART0_SRC_SEL_XIN_OSC0_FUNC;
+		div = DIV_ROUND_UP(OSC_HZ, rate);
+	} else if (priv->gpll_hz % rate == 0) {
+		sel = SCLK_UART0_SRC_SEL_CLK_UART0_SRC;
+		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+	} else {
+		sel = SCLK_UART0_SRC_SEL_CLK_UART0_FRAC;
+		div = 2;
+		rational_best_approximation(rate, priv->gpll_hz / div,
+					    GENMASK(16 - 1, 0),
+					    GENMASK(16 - 1, 0),
+					    &n, &m);
+	}
+
+	switch (clk_id) {
+	case SCLK_UART0:
+		id = 6;
+		sel_shift = SCLK_UART0_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART0_SRC_SEL_MASK;
+		div_shift = CLK_UART0_SRC_DIV_SHIFT;
+		div_mask = CLK_UART0_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART1:
+		id = 8;
+		sel_shift = SCLK_UART1_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART1_SRC_SEL_MASK;
+		div_shift = CLK_UART1_SRC_DIV_SHIFT;
+		div_mask = CLK_UART1_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART2:
+		id = 10;
+		sel_shift = SCLK_UART2_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART2_SRC_SEL_MASK;
+		div_shift = CLK_UART2_SRC_DIV_SHIFT;
+		div_mask = CLK_UART2_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART3:
+		id = 12;
+		sel_shift = SCLK_UART3_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART3_SRC_SEL_MASK;
+		div_shift = CLK_UART3_SRC_DIV_SHIFT;
+		div_mask = CLK_UART3_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART4:
+		id = 14;
+		sel_shift = SCLK_UART4_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART4_SRC_SEL_MASK;
+		div_shift = CLK_UART4_SRC_DIV_SHIFT;
+		div_mask = CLK_UART4_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART5:
+		id = 16;
+		sel_shift = SCLK_UART5_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART5_SRC_SEL_MASK;
+		div_shift = CLK_UART5_SRC_DIV_SHIFT;
+		div_mask = CLK_UART5_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART6:
+		id = 18;
+		sel_shift = SCLK_UART6_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART6_SRC_SEL_MASK;
+		div_shift = CLK_UART6_SRC_DIV_SHIFT;
+		div_mask = CLK_UART6_SRC_DIV_MASK;
+		break;
+
+	case SCLK_UART7:
+		id = 20;
+		sel_shift = SCLK_UART7_SRC_SEL_SHIFT;
+		sel_mask = SCLK_UART7_SRC_SEL_MASK;
+		div_shift = CLK_UART7_SRC_DIV_SHIFT;
+		div_mask = CLK_UART7_SRC_DIV_MASK;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	rk_clrsetreg(&cru->clksel_con[id - 2], div_mask, (div - 1) << div_shift);
+	rk_clrsetreg(&cru->clksel_con[id], sel_mask, sel << sel_shift);
+	if (m && n) {
+		val = n << 16 | m;
+		writel(val, &cru->clksel_con[id - 1]);
+	}
+
+	return rk3528_uart_get_rate(priv, clk_id);
+}
+
+static ulong rk3528_clk_get_rate(struct clk *clk)
+{
+	struct rk3528_clk_priv *priv = dev_get_priv(clk->dev);
+	ulong rate = 0;
+
+	if (!priv->gpll_hz || !priv->cpll_hz) {
+		printf("%s: gpll=%lu, cpll=%ld\n",
+		       __func__, priv->gpll_hz, priv->cpll_hz);
+		return -ENOENT;
+	}
+
+	switch (clk->id) {
+	case PLL_APLL:
+	case ARMCLK:
+		rate = rockchip_pll_get_rate(&rk3528_pll_clks[APLL], priv->cru,
+					     APLL);
+		break;
+	case PLL_CPLL:
+		rate = rockchip_pll_get_rate(&rk3528_pll_clks[CPLL], priv->cru,
+					     CPLL);
+		break;
+	case PLL_GPLL:
+		rate = rockchip_pll_get_rate(&rk3528_pll_clks[GPLL], priv->cru,
+					     GPLL);
+		break;
+
+	case PLL_PPLL:
+		rate = rockchip_pll_get_rate(&rk3528_pll_clks[PPLL], priv->cru,
+					     PPLL);
+		break;
+	case PLL_DPLL:
+		rate = rockchip_pll_get_rate(&rk3528_pll_clks[DPLL], priv->cru,
+					     DPLL);
+		break;
+
+	case TCLK_EMMC:
+	case TCLK_WDT_NS:
+		rate = OSC_HZ;
+		break;
+	case CLK_I2C0:
+	case CLK_I2C1:
+	case CLK_I2C2:
+	case CLK_I2C3:
+	case CLK_I2C4:
+	case CLK_I2C5:
+	case CLK_I2C6:
+	case CLK_I2C7:
+		rate = rk3528_i2c_get_clk(priv, clk->id);
+		break;
+	case CLK_SPI0:
+	case CLK_SPI1:
+		rate = rk3528_spi_get_clk(priv, clk->id);
+		break;
+	case CLK_PWM0:
+	case CLK_PWM1:
+		rate = rk3528_pwm_get_clk(priv, clk->id);
+		break;
+	case CLK_SARADC:
+	case CLK_TSADC:
+	case CLK_TSADC_TSEN:
+		rate = rk3528_adc_get_clk(priv, clk->id);
+		break;
+	case CCLK_SRC_EMMC:
+		rate = rk3528_emmc_get_clk(priv);
+		break;
+	case HCLK_SDMMC0:
+	case CCLK_SRC_SDMMC0:
+		rate = rk3528_sdmmc_get_clk(priv, clk->id);
+		break;
+	case SCLK_SFC:
+		rate = rk3528_sfc_get_clk(priv);
+		break;
+	case DCLK_VOP0:
+	case DCLK_VOP1:
+		rate = rk3528_dclk_vop_get_clk(priv, clk->id);
+		break;
+	case DCLK_CVBS:
+		rate = rk3528_dclk_vop_get_clk(priv, DCLK_VOP1) / 4;
+		break;
+	case DCLK_4X_CVBS:
+		rate = rk3528_dclk_vop_get_clk(priv, DCLK_VOP1);
+		break;
+	case SCLK_UART0:
+	case SCLK_UART1:
+	case SCLK_UART2:
+	case SCLK_UART3:
+	case SCLK_UART4:
+	case SCLK_UART5:
+	case SCLK_UART6:
+	case SCLK_UART7:
+		rate = rk3528_uart_get_rate(priv, clk->id);
+		break;
+	case CLK_MATRIX_50M_SRC:
+	case CLK_MATRIX_100M_SRC:
+	case CLK_MATRIX_150M_SRC:
+	case CLK_MATRIX_200M_SRC:
+	case CLK_MATRIX_250M_SRC:
+	case CLK_MATRIX_300M_SRC:
+	case CLK_MATRIX_339M_SRC:
+	case CLK_MATRIX_400M_SRC:
+	case CLK_MATRIX_500M_SRC:
+	case CLK_MATRIX_600M_SRC:
+	case ACLK_BUS_VOPGL_BIU:
+		rate = rk3528_cgpll_matrix_get_rate(priv, clk->id);
+		break;
+	case CLK_PPLL_50M_MATRIX:
+	case CLK_PPLL_100M_MATRIX:
+	case CLK_PPLL_125M_MATRIX:
+	case CLK_GMAC1_VPU_25M:
+	case CLK_GMAC1_RMII_VPU:
+	case CLK_GMAC1_SRC_VPU:
+		rate = rk3528_ppll_matrix_get_rate(priv, clk->id);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rate;
+};
+
+static ulong rk3528_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct rk3528_clk_priv *priv = dev_get_priv(clk->dev);
+	ulong ret = 0;
+
+	if (!priv->gpll_hz) {
+		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
+		return -ENOENT;
+	}
+
+	switch (clk->id) {
+	case PLL_APLL:
+	case ARMCLK:
+		if (priv->armclk_hz)
+			rk3528_armclk_set_clk(priv, rate);
+		priv->armclk_hz = rate;
+		break;
+	case PLL_CPLL:
+		ret = rockchip_pll_set_rate(&rk3528_pll_clks[CPLL], priv->cru,
+					    CPLL, rate);
+		priv->cpll_hz = rockchip_pll_get_rate(&rk3528_pll_clks[CPLL],
+						      priv->cru, CPLL);
+		break;
+	case PLL_GPLL:
+		ret = rockchip_pll_set_rate(&rk3528_pll_clks[GPLL], priv->cru,
+					    GPLL, rate);
+		priv->gpll_hz = rockchip_pll_get_rate(&rk3528_pll_clks[GPLL],
+						      priv->cru, GPLL);
+		break;
+	case PLL_PPLL:
+		ret = rockchip_pll_set_rate(&rk3528_pll_clks[PPLL], priv->cru,
+					    PPLL, rate);
+		priv->ppll_hz = rockchip_pll_get_rate(&rk3528_pll_clks[PPLL],
+						      priv->cru, PPLL);
+		break;
+	case TCLK_EMMC:
+	case TCLK_WDT_NS:
+		return (rate == OSC_HZ) ? 0 : -EINVAL;
+	case CLK_I2C0:
+	case CLK_I2C1:
+	case CLK_I2C2:
+	case CLK_I2C3:
+	case CLK_I2C4:
+	case CLK_I2C5:
+	case CLK_I2C6:
+	case CLK_I2C7:
+		ret = rk3528_i2c_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_SPI0:
+	case CLK_SPI1:
+		ret = rk3528_spi_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_PWM0:
+	case CLK_PWM1:
+		ret = rk3528_pwm_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_SARADC:
+	case CLK_TSADC:
+	case CLK_TSADC_TSEN:
+		ret = rk3528_adc_set_clk(priv, clk->id, rate);
+		break;
+	case HCLK_SDMMC0:
+	case CCLK_SRC_SDMMC0:
+		ret = rk3528_sdmmc_set_clk(priv, clk->id, rate);
+		break;
+	case SCLK_SFC:
+		ret = rk3528_sfc_set_clk(priv, rate);
+		break;
+	case CCLK_SRC_EMMC:
+		ret = rk3528_emmc_set_clk(priv, rate);
+		break;
+	case DCLK_VOP0:
+	case DCLK_VOP1:
+		ret = rk3528_dclk_vop_set_clk(priv, clk->id, rate);
+		break;
+	case SCLK_UART0:
+	case SCLK_UART1:
+	case SCLK_UART2:
+	case SCLK_UART3:
+	case SCLK_UART4:
+	case SCLK_UART5:
+	case SCLK_UART6:
+	case SCLK_UART7:
+		ret = rk3528_uart_set_rate(priv, clk->id, rate);
+		break;
+	case CLK_MATRIX_50M_SRC:
+	case CLK_MATRIX_100M_SRC:
+	case CLK_MATRIX_150M_SRC:
+	case CLK_MATRIX_200M_SRC:
+	case CLK_MATRIX_250M_SRC:
+	case CLK_MATRIX_300M_SRC:
+	case CLK_MATRIX_339M_SRC:
+	case CLK_MATRIX_400M_SRC:
+	case CLK_MATRIX_500M_SRC:
+	case CLK_MATRIX_600M_SRC:
+	case ACLK_BUS_VOPGL_BIU:
+		ret = rk3528_cgpll_matrix_set_rate(priv, clk->id, rate);
+		break;
+	case CLK_PPLL_50M_MATRIX:
+	case CLK_PPLL_100M_MATRIX:
+	case CLK_PPLL_125M_MATRIX:
+	case CLK_GMAC1_VPU_25M:
+		ret = rk3528_ppll_matrix_set_rate(priv, clk->id, rate);
+		break;
+	case CLK_GMAC1_RMII_VPU:
+	case CLK_GMAC1_SRC_VPU:
+		/* dummy set */
+		ret = rk3528_ppll_matrix_get_rate(priv, clk->id);
+		break;
+
+	/* Might occur in cru assigned-clocks, can be ignored here */
+	case ACLK_BUS_VOPGL_ROOT:
+	case BCLK_EMMC:
+	case XIN_OSC0_DIV:
+		ret = 0;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return ret;
+};
+
+static struct clk_ops rk3528_clk_ops = {
+	.get_rate = rk3528_clk_get_rate,
+	.set_rate = rk3528_clk_set_rate,
+};
+
+#ifdef CONFIG_XPL_BUILD
+
+#define COREGRF_BASE	0xff300000
+#define PVTPLL_CON0_L	0x0
+#define PVTPLL_CON0_H	0x4
+
+static int rk3528_cpu_pvtpll_set_rate(struct rk3528_clk_priv *priv, ulong rate)
+{
+	struct rk3528_cru *cru = priv->cru;
+	u32 length;
+
+	if (rate >= 1200000000)
+		length = 8;
+	else if (rate >= 1008000000)
+		length = 11;
+	else
+		length = 17;
+
+	/* set pclk dbg div to 9 */
+	rk_clrsetreg(&cru->clksel_con[40], RK3528_DIV_PCLK_DBG_MASK,
+		     9 << RK3528_DIV_PCLK_DBG_SHIFT);
+	/* set aclk_m_core div to 1 */
+	rk_clrsetreg(&cru->clksel_con[39], RK3528_DIV_ACLK_M_CORE_MASK,
+		     1 << RK3528_DIV_ACLK_M_CORE_SHIFT);
+
+	/* set ring sel = 1 */
+	writel(0x07000000 | (1 << 8), COREGRF_BASE + PVTPLL_CON0_L);
+	/* set length */
+	writel(0x007f0000 | length, COREGRF_BASE + PVTPLL_CON0_H);
+	/* enable pvtpll */
+	writel(0x00020002, COREGRF_BASE + PVTPLL_CON0_L);
+	/* start monitor */
+	writel(0x00010001, COREGRF_BASE + PVTPLL_CON0_L);
+
+	/* set core mux pvtpll */
+	writel(0x00010001, &cru->clksel_con[40]);
+	writel(0x00100010, &cru->clksel_con[39]);
+
+	/* set pclk dbg div to 8 */
+	rk_clrsetreg(&cru->clksel_con[40], RK3528_DIV_PCLK_DBG_MASK,
+		     8 << RK3528_DIV_PCLK_DBG_SHIFT);
+
+	return 0;
+}
+#endif
+
+static int rk3528_clk_init(struct rk3528_clk_priv *priv)
+{
+	int ret;
+
+	priv->sync_kernel = false;
+
+#ifdef CONFIG_XPL_BUILD
+	/*
+	 * BOOTROM:
+	 *	CPU 1902/2(postdiv1)=546M
+	 *	CPLL 996/2(postdiv1)=498M
+	 *	GPLL 1188/2(postdiv1)=594M
+	 *	   |-- clk_matrix_200m_src_div=1 => rate: 300M
+	 *	   |-- clk_matrix_300m_src_div=2 => rate: 200M
+	 *
+	 * Avoid overclocking when change GPLL rate:
+	 *	Change clk_matrix_200m_src_div to 5.
+	 *	Change clk_matrix_300m_src_div to 3.
+	 */
+	writel(0x01200120, &priv->cru->clksel_con[1]);
+	writel(0x00030003, &priv->cru->clksel_con[2]);
+
+	if (!priv->armclk_enter_hz) {
+		priv->armclk_enter_hz =
+			rockchip_pll_get_rate(&rk3528_pll_clks[APLL],
+					      priv->cru, APLL);
+		priv->armclk_init_hz = priv->armclk_enter_hz;
+	}
+
+	if (priv->armclk_init_hz != APLL_HZ) {
+		ret = rk3528_armclk_set_clk(priv, APLL_HZ);
+		if (!ret)
+			priv->armclk_init_hz = APLL_HZ;
+	}
+
+	if (!rk3528_cpu_pvtpll_set_rate(priv, CPU_PVTPLL_HZ)) {
+		debug("cpu pvtpll %d KHz\n", CPU_PVTPLL_HZ / 1000);
+		priv->armclk_init_hz = CPU_PVTPLL_HZ;
+	}
+#endif
+
+	if (priv->cpll_hz != CPLL_HZ) {
+		ret = rockchip_pll_set_rate(&rk3528_pll_clks[CPLL], priv->cru,
+					    CPLL, CPLL_HZ);
+		if (!ret)
+			priv->cpll_hz = CPLL_HZ;
+	}
+
+	if (priv->gpll_hz != GPLL_HZ) {
+		ret = rockchip_pll_set_rate(&rk3528_pll_clks[GPLL], priv->cru,
+					    GPLL, GPLL_HZ);
+		if (!ret)
+			priv->gpll_hz = GPLL_HZ;
+	}
+
+	if (priv->ppll_hz != PPLL_HZ) {
+		ret = rockchip_pll_set_rate(&rk3528_pll_clks[PPLL], priv->cru,
+					    PPLL, PPLL_HZ);
+		if (!ret)
+			priv->ppll_hz = PPLL_HZ;
+	}
+
+#ifdef CONFIG_XPL_BUILD
+	/* Init to override bootrom config */
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_50M_SRC,   50000000);
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_100M_SRC, 100000000);
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_150M_SRC, 150000000);
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_200M_SRC, 200000000);
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_250M_SRC, 250000000);
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_300M_SRC, 300000000);
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_339M_SRC, 340000000);
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_400M_SRC, 400000000);
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_500M_SRC, 500000000);
+	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_600M_SRC, 600000000);
+	rk3528_cgpll_matrix_set_rate(priv, ACLK_BUS_VOPGL_BIU,  500000000);
+
+	/* The default rate is 100Mhz, it's not friendly for remote IR module */
+	rk3528_pwm_set_clk(priv, CLK_PWM0, 24000000);
+	rk3528_pwm_set_clk(priv, CLK_PWM1, 24000000);
+#endif
+	return 0;
+}
+
+static int rk3528_clk_probe(struct udevice *dev)
+{
+	struct rk3528_clk_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = rk3528_clk_init(priv);
+	if (ret)
+		return ret;
+
+	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
+	ret = clk_set_defaults(dev, 1);
+	if (ret)
+		debug("%s clk_set_defaults failed %d\n", __func__, ret);
+	else
+		priv->sync_kernel = true;
+
+	return 0;
+}
+
+static int rk3528_clk_ofdata_to_platdata(struct udevice *dev)
+{
+	struct rk3528_clk_priv *priv = dev_get_priv(dev);
+
+	priv->cru = dev_read_addr_ptr(dev);
+
+	return 0;
+}
+
+static int rk3528_clk_bind(struct udevice *dev)
+{
+	struct udevice *sys_child;
+	struct sysreset_reg *priv;
+	int ret;
+
+	/* The reset driver does not have a device node, so bind it here */
+	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
+				 &sys_child);
+	if (ret) {
+		debug("Warning: No sysreset driver: ret=%d\n", ret);
+	} else {
+		priv = malloc(sizeof(struct sysreset_reg));
+		priv->glb_srst_fst_value = offsetof(struct rk3528_cru,
+						    glb_srst_fst);
+		priv->glb_srst_snd_value = offsetof(struct rk3528_cru,
+						    glb_srst_snd);
+		dev_set_priv(sys_child, priv);
+	}
+
+#if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
+	ret = offsetof(struct rk3528_cru, softrst_con[0]);
+	ret = rk3528_reset_bind_lut(dev, ret, 47);
+	if (ret)
+		debug("Warning: software reset driver bind failed\n");
+#endif
+
+	return 0;
+}
+
+static const struct udevice_id rk3528_clk_ids[] = {
+	{ .compatible = "rockchip,rk3528-cru" },
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3528_cru) = {
+	.name		= "rockchip_rk3528_cru",
+	.id		= UCLASS_CLK,
+	.of_match	= rk3528_clk_ids,
+	.priv_auto	= sizeof(struct rk3528_clk_priv),
+	.of_to_plat	= rk3528_clk_ofdata_to_platdata,
+	.ops		= &rk3528_clk_ops,
+	.bind		= rk3528_clk_bind,
+	.probe		= rk3528_clk_probe,
+};
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index b94943960138..53e7d3730653 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
 obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
-obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3588.o
+obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3528.o rst-rk3588.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_MEDIATEK) += reset-mediatek.o
diff --git a/drivers/reset/rst-rk3528.c b/drivers/reset/rst-rk3528.c
new file mode 100644
index 000000000000..f6e760d468d9
--- /dev/null
+++ b/drivers/reset/rst-rk3528.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ * Based on Sebastian Reichel's implementation for RK3588
+ */
+
+#include <dm.h>
+#include <asm/arch-rockchip/clock.h>
+#include <dt-bindings/reset/rockchip,rk3528-cru.h>
+
+/* 0xFF4A0000 + 0x0A00 */
+#define RK3528_CRU_RESET_OFFSET(id, reg, bit) [id] = (0 + reg * 16 + bit)
+
+/* mapping table for reset ID to register offset */
+static const int rk3528_register_offset[] = {
+	/* CRU_SOFTRST_CON03 */
+	RK3528_CRU_RESET_OFFSET(SRST_CORE0_PO, 3, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE1_PO, 3, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE2_PO, 3, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE3_PO, 3, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE0, 3, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE1, 3, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE2, 3, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE3, 3, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_NL2, 3, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_BIU, 3, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_CRYPTO, 3, 10),
+
+	/* CRU_SOFTRST_CON05 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_DBG, 5, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_POT_DBG, 5, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_NT_DBG, 5, 15),
+
+	/* CRU_SOFTRST_CON06 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_CORE_GRF, 6, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DAPLITE_BIU, 6, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CPU_BIU, 6, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_REF_PVTPLL_CORE, 6, 7),
+
+	/* CRU_SOFTRST_CON08 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_BUS_VOPGL_BIU, 8, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_A_BUS_H_BIU, 8, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_A_SYSMEM_BIU, 8, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_A_BUS_BIU, 8, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_H_BUS_BIU, 8, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_P_BUS_BIU, 8, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DFT2APB, 8, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_P_BUS_GRF, 8, 15),
+
+	/* CRU_SOFTRST_CON09 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_BUS_M_BIU, 9, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_A_GIC, 9, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_A_SPINLOCK, 9, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DMAC, 9, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_TIMER, 9, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER0, 9, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER1, 9, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER2, 9, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER3, 9, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER4, 9, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER5, 9, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_P_JDBCK_DAP, 9, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_JDBCK_DAP, 9, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_P_WDT_NS, 9, 15),
+
+	/* CRU_SOFTRST_CON10 */
+	RK3528_CRU_RESET_OFFSET(SRST_T_WDT_NS, 10, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_H_TRNG_NS, 10, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART0, 10, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART0, 10, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_PKA_CRYPTO, 10, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_A_CRYPTO, 10, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_H_CRYPTO, 10, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DMA2DDR, 10, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DMA2DDR, 10, 14),
+
+	/* CRU_SOFTRST_CON11 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_PWM0, 11, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_PWM0, 11, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_PWM1, 11, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_PWM1, 11, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_SCR, 11, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DCF, 11, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_P_INTMUX, 11, 12),
+
+	/* CRU_SOFTRST_CON25 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_VPU_BIU, 25, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VPU_BIU, 25, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VPU_BIU, 25, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VPU, 25, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VPU, 25, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CRU_PCIE, 25, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VPU_GRF, 25, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SFC, 25, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_S_SFC, 25, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_C_EMMC, 25, 15),
+
+	/* CRU_SOFTRST_CON26 */
+	RK3528_CRU_RESET_OFFSET(SRST_H_EMMC, 26, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_A_EMMC, 26, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_B_EMMC, 26, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_T_EMMC, 26, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPIO1, 26, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_DB_GPIO1, 26, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VPU_L_BIU, 26, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VPU_IOC, 26, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SAI_I2S0, 26, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SAI_I2S0, 26, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SAI_I2S2, 26, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SAI_I2S2, 26, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_ACODEC, 26, 13),
+
+	/* CRU_SOFTRST_CON27 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPIO3, 27, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_DB_GPIO3, 27, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_P_SPI1, 27, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_SPI1, 27, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART2, 27, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART2, 27, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART5, 27, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART5, 27, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART6, 27, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART6, 27, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART7, 27, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART7, 27, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C3, 27, 15),
+
+	/* CRU_SOFTRST_CON28 */
+	RK3528_CRU_RESET_OFFSET(SRST_I2C3, 28, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C5, 28, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C5, 28, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C6, 28, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C6, 28, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_A_MAC, 28, 5),
+
+	/* CRU_SOFTRST_CON30 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_PCIE, 30, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_PCIE_PIPE_PHY, 30, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_PCIE_POWER_UP, 30, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_PCIE_PHY, 30, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_PIPE_GRF, 30, 7),
+
+	/* CRU_SOFTRST_CON32 */
+	RK3528_CRU_RESET_OFFSET(SRST_H_SDIO0, 32, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SDIO1, 32, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_TS_0, 32, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_TS_1, 32, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CAN2, 32, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_CAN2, 32, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CAN3, 32, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_CAN3, 32, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_SARADC, 32, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_SARADC, 32, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_SARADC_PHY, 32, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_P_TSADC, 32, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_TSADC, 32, 15),
+
+	/* CRU_SOFTRST_CON33 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_USB3OTG, 33, 1),
+
+	/* CRU_SOFTRST_CON34 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_GPU_BIU, 34, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPU_BIU, 34, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_A_GPU, 34, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_REF_PVTPLL_GPU, 34, 9),
+
+	/* CRU_SOFTRST_CON36 */
+	RK3528_CRU_RESET_OFFSET(SRST_H_RKVENC_BIU, 36, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RKVENC_BIU, 36, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_RKVENC_BIU, 36, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_H_RKVENC, 36, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RKVENC, 36, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_RKVENC, 36, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SAI_I2S1, 36, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SAI_I2S1, 36, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C1, 36, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C1, 36, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C0, 36, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C0, 36, 14),
+
+	/* CRU_SOFTRST_CON37 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_SPI0, 37, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_SPI0, 37, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPIO4, 37, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_DB_GPIO4, 37, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_P_RKVENC_IOC, 37, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SPDIF, 37, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SPDIF, 37, 15),
+
+	/* CRU_SOFTRST_CON38 */
+	RK3528_CRU_RESET_OFFSET(SRST_H_PDM, 38, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_M_PDM, 38, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART1, 38, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART1, 38, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART3, 38, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART3, 38, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_RKVENC_GRF, 38, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CAN0, 38, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_CAN0, 38, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CAN1, 38, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_CAN1, 38, 10),
+
+	/* CRU_SOFTRST_CON39 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_VO_BIU, 39, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VO_BIU, 39, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VO_BIU, 39, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_H_RGA2E, 39, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RGA2E, 39, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_RGA2E, 39, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VDPP, 39, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VDPP, 39, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_VDPP, 39, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VO_GRF, 39, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CRU, 39, 15),
+
+	/* CRU_SOFTRST_CON40 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_VOP_BIU, 40, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VOP, 40, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_D_VOP0, 40, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_D_VOP1, 40, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VOP, 40, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_HDMI, 40, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_HDMI, 40, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_P_HDMIPHY, 40, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_H_HDCP_KEY, 40, 15),
+
+	/* CRU_SOFTRST_CON41 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_HDCP, 41, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_H_HDCP, 41, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_P_HDCP, 41, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_H_CVBS, 41, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_D_CVBS_VOP, 41, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_D_4X_CVBS_VOP, 41, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_A_JPEG_DECODER, 41, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_H_JPEG_DECODER, 41, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VO_L_BIU, 41, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_A_MAC_VO, 41, 10),
+
+	/* CRU_SOFTRST_CON42 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_JPEG_BIU, 42, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SAI_I2S3, 42, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SAI_I2S3, 42, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_MACPHY, 42, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VCDCPHY, 42, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPIO2, 42, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_DB_GPIO2, 42, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VO_IOC, 42, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SDMMC0, 42, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_P_OTPC_NS, 42, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_SBPI_OTPC_NS, 42, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_USER_OTPC_NS, 42, 13),
+
+	/* CRU_SOFTRST_CON43 */
+	RK3528_CRU_RESET_OFFSET(SRST_HDMIHDP0, 43, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_H_USBHOST, 43, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_H_USBHOST_ARB, 43, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_HOST_UTMI, 43, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART4, 43, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART4, 43, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C4, 43, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C4, 43, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C7, 43, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C7, 43, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_USBPHY, 43, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_USBPHY_POR, 43, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_USBPHY_OTG, 43, 15),
+
+	/* CRU_SOFTRST_CON44 */
+	RK3528_CRU_RESET_OFFSET(SRST_USBPHY_HOST, 44, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDRPHY_CRU, 44, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_H_RKVDEC_BIU, 44, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RKVDEC_BIU, 44, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RKVDEC, 44, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_H_RKVDEC, 44, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_HEVC_CA_RKVDEC, 44, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_REF_PVTPLL_RKVDEC, 44, 12),
+
+	/* CRU_SOFTRST_CON45 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDR_BIU, 45, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDRC, 45, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDRMON, 45, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER_DDRMON, 45, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_MSCH_BIU, 45, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDR_GRF, 45, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDR_HWLP, 45, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDRPHY, 45, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_MSCH_BIU, 45, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DDR_UPCTL, 45, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_DDR_UPCTL, 45, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_DDRMON, 45, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DDR_SCRAMBLE, 45, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_A_SPLIT, 45, 15),
+
+	/* CRU_SOFTRST_CON46 */
+	RK3528_CRU_RESET_OFFSET(SRST_DDR_PHY, 46, 0),
+};
+
+int rk3528_reset_bind_lut(struct udevice *pdev, u32 reg_offset, u32 reg_number)
+{
+	return rockchip_reset_bind_lut(pdev, rk3528_register_offset,
+				       reg_offset, reg_number);
+}
-- 
2.49.0

