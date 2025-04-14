Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9666DC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6295E8215F;
	Mon, 14 Apr 2025 22:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="zglP1c6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B7048215E; Mon, 14 Apr 2025 22:01:56 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C64FE82102
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Rh3mGJZBZLrCR4nzNGFL+5jWNwAM3qq0Db0vL5z4sjE=; b=zglP1c6g62H81rFRxXIztWKxdq
 xUIm6ZfhWuGu4ShqoBntjl9NAkey1LAN0HDJdEx4WHC/lVczLXX9M60REQdZshObH8e5eQ8kzH6JE
 Z+0LFDWhgfqtbNzomxn4FjzdRSB7JmafIviEV8eXeLaA9H58gqHVljBPglgaTkF8+OxHFaizrUH3D
 byInX736y3d2p7DQ92ucx1eRNp2P2w+QG0JTnARCPU/luRDlTDlSMbMZyddbk+y1rW/wYMZfxALd8
 0uFgYTe08q6KwNhTIROrWl1J8TZWiiiJbx4ZdhTpoSCmpV80SJaZG42V4SOx6fx03oAOehjpeb4pJ
 wImtkLSQ==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4Pzv-0001rf-4E; Mon, 14 Apr 2025 22:01:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 06/16] clk: rockchip: Add rk3576 clk support
Date: Mon, 14 Apr 2025 22:01:01 +0200
Message-ID: <20250414200111.1357867-7-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414200111.1357867-1-heiko@sntech.de>
References: <20250414200111.1357867-1-heiko@sntech.de>
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

From: Elaine Zhang <zhangqing@rock-chips.com>

Add clock driver support for Rockchip RK3576 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
[adapted to mainline u-boot]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../include/asm/arch-rockchip/cru_rk3576.h    |  491 ++++
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk_rk3576.c             | 2513 +++++++++++++++++
 3 files changed, 3005 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3576.h
 create mode 100644 drivers/clk/rockchip/clk_rk3576.c

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
new file mode 100644
index 00000000000..c51750beff2
--- /dev/null
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -0,0 +1,491 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Rockchip Electronics Co. Ltd.
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#ifndef _ASM_ARCH_CRU_RK3576_H
+#define _ASM_ARCH_CRU_RK3576_H
+
+#define MHz		1000000
+#define KHz		1000
+#define OSC_HZ		(24 * MHz)
+
+#define CPU_PVTPLL_HZ	(1008 * MHz)
+#define LPLL_HZ		(816 * MHz)
+#define GPLL_HZ		(1188 * MHz)
+#define CPLL_HZ		(1000 * MHz)
+#define PPLL_HZ		(1100 * MHz)
+#define GMAC0_PTP_REFCLK_IN	(24 * MHz)
+#define GMAC1_PTP_REFCLK_IN	(24 * MHz)
+
+/* RK3576 pll id */
+enum rk3576_pll_id {
+	BPLL,
+	LPLL,
+	DPLL,
+	CPLL,
+	GPLL,
+	VPLL,
+	AUPLL,
+	SPLL,
+	PPLL,
+	PLL_COUNT,
+};
+
+struct rk3576_clk_priv {
+	struct rk3576_cru *cru;
+	ulong ppll_hz;
+	ulong gpll_hz;
+	ulong cpll_hz;
+	ulong vpll_hz;
+	ulong aupll_hz;
+	ulong spll_hz;
+	ulong lpll_hz;
+	ulong bpll_hz;
+	ulong armclk_hz;
+	ulong armclk_enter_hz;
+	ulong armclk_init_hz;
+	bool sync_kernel;
+	bool set_armclk_rate;
+};
+
+struct rk3576_pll {
+	unsigned int con0;
+	unsigned int con1;
+	unsigned int con2;
+	unsigned int con3;
+	unsigned int con4;
+	unsigned int reserved0[3];
+};
+
+struct rk3576_cru {
+	struct rk3576_pll pll[18];
+	unsigned int reserved0[16];/* Address Offset: 0x0240 */
+	unsigned int mode_con00;/* Address Offset: 0x0280 */
+	unsigned int reserved1[31];/* Address Offset: 0x0284 */
+	unsigned int clksel_con[181]; /* Address Offset: 0x0300 */
+	unsigned int reserved2[139];/* Address Offset: 0x05d4 */
+	unsigned int clkgate_con[80];/* Address Offset: 0x0800 */
+	unsigned int reserved3[48];/* Address Offset: 0x0938 */
+	unsigned int softrst_con[80];/* Address Offset: 0x0400 */
+	unsigned int reserved4[48];/* Address Offset: 0x0b38 */
+	unsigned int glb_cnt_th;/* Address Offset: 0x0c00 */
+	unsigned int glb_rst_st;/* Address Offset: 0x0c04 */
+	unsigned int glb_srst_fst;/* Address Offset: 0x0c08 */
+	unsigned int glb_srsr_snd; /* Address Offset: 0x0c0c */
+	unsigned int glb_rst_con;/* Address Offset: 0x0c10 */
+	unsigned int reserved5[43];/* Address Offset: 0x0c14 */
+	unsigned int smoth_divfree_con[3];/* Address Offset: 0x0cc0 */
+	unsigned int fracdiv_high_con[4];/* Address Offset: 0x0ccc */
+	unsigned int reserved8[32137];/* Address Offset: 0x0c38 */
+	unsigned int pmuclksel_con[22]; /* Address Offset: 0x20300 */
+	unsigned int reserved9[298];/* Address Offset: 0x20358 */
+	unsigned int pmuclkgate_con[8]; /* Address Offset: 0x20800 */
+	unsigned int reserved10[32440];/* Address Offset: 0x20820 */
+	unsigned int litclksel_con[4]; /* Address Offset: 0x40300 */
+};
+
+check_member(rk3576_cru, mode_con00, 0x280);
+check_member(rk3576_cru, pmuclksel_con[1], 0x20304);
+
+struct pll_rate_table {
+	unsigned long rate;
+	unsigned int m;
+	unsigned int p;
+	unsigned int s;
+	unsigned int k;
+};
+
+#define RK3576_PHP_CRU_BASE		0x8000
+#define RK3576_PMU_CRU_BASE		0x20000
+#define RK3576_BIGCORE_CRU_BASE		0x38000
+#define RK3576_LITCORE_CRU_BASE		0x40000
+#define RK3576_CCI_CRU_BASE		0x48000
+#define RK3576_CRU_BASE			0x27200000
+#define RK3576_SCRU_BASE		0x27214000
+
+#define RK3576_BIGCORE_GRF_BASE		0x2600C000
+#define RK3576_LITCORE_GRF_BASE		0x2600E000
+#define RK3576_CCI_GRF_BASE		0x26010000
+
+#define RK3576_PLL_CON(x)		((x) * 0x4)
+#define RK3576_MODE_CON0		0x280
+#define RK3576_BPLL_MODE_CON0		(RK3576_BIGCORE_CRU_BASE + 0x280)
+#define RK3576_LPLL_MODE_CON0		(RK3576_LITCORE_CRU_BASE + 0x280)
+#define RK3576_PPLL_MODE_CON0		(RK3576_PHP_CRU_BASE + 0x280)
+#define RK3576_CLKSEL_CON(x)		((x) * 0x4 + 0x300)
+#define RK3576_CLKGATE_CON(x)		((x) * 0x4 + 0x800)
+#define RK3576_SOFTRST_CON(x)		((x) * 0x4 + 0xa00)
+#define RK3576_GLB_CNT_TH		0xc00
+#define RK3576_GLB_SRST_FST		0xc08
+#define RK3576_GLB_SRST_SND		0xc0c
+#define RK3576_GLB_RST_CON		0xc10
+#define RK3576_GLB_RST_ST		0xc04
+#define RK3576_SDIO_CON0		0xC24
+#define RK3576_SDIO_CON1		0xC28
+#define RK3576_SDMMC_CON0		0xC30
+#define RK3576_SDMMC_CON1		0xC34
+
+#define RK3576_PHP_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x300)
+#define RK3576_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x800)
+#define RK3576_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0xa00)
+
+#define RK3576_PMU_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)
+#define RK3576_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x300)
+#define RK3576_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x800)
+#define RK3576_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0xa00)
+
+#define RK3576_CCI_CLKSEL_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x300)
+#define RK3576_CCI_CLKGATE_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x800)
+#define RK3576_CCI_SOFTRST_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0xa00)
+
+#define RK3576_BPLL_CON(x)		((x) * 0x4 + RK3576_BIGCORE_CRU_BASE)
+#define RK3576_BIGCORE_CLKSEL_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x300)
+#define RK3576_BIGCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x800)
+#define RK3576_BIGCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0xa00)
+#define RK3576_LPLL_CON(x)		((x) * 0x4 + RK3576_CCI_CRU_BASE)
+#define RK3576_LITCORE_CLKSEL_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0x300)
+#define RK3576_LITCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0x800)
+#define RK3576_LITCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0xa00)
+
+enum {
+	/* CRU_CLK_SEL8_CON */
+	PCLK_TOP_SEL_SHIFT		= 7,
+	PCLK_TOP_SEL_MASK		= 3 << PCLK_TOP_SEL_SHIFT,
+	PCLK_TOP_SEL_100M		= 0,
+	PCLK_TOP_SEL_50M,
+	PCLK_TOP_SEL_OSC,
+
+	/* CRU_CLK_SEL9_CON */
+	ACLK_TOP_SEL_SHIFT		= 5,
+	ACLK_TOP_SEL_MASK		= 3 << ACLK_TOP_SEL_SHIFT,
+	ACLK_TOP_SEL_GPLL		= 0,
+	ACLK_TOP_SEL_CPLL,
+	ACLK_TOP_SEL_AUPLL,
+	ACLK_TOP_DIV_SHIFT		= 0,
+	ACLK_TOP_DIV_MASK		= 0x1f << ACLK_TOP_DIV_SHIFT,
+
+	/* CRU_CLK_SEL10_CON */
+	ACLK_TOP_MID_SEL_SHIFT		= 5,
+	ACLK_TOP_MID_SEL_MASK		= 1 << ACLK_TOP_MID_SEL_SHIFT,
+	ACLK_TOP_MID_SEL_GPLL		= 0,
+	ACLK_TOP_MID_SEL_CPLL,
+	ACLK_TOP_MID_DIV_SHIFT		= 0,
+	ACLK_TOP_MID_DIV_MASK		= 0x1f << ACLK_TOP_MID_DIV_SHIFT,
+
+	/* CRU_CLK_SEL19_CON */
+	HCLK_TOP_SEL_SHIFT		= 2,
+	HCLK_TOP_SEL_MASK		= 3 << HCLK_TOP_SEL_SHIFT,
+	HCLK_TOP_SEL_200M		= 0,
+	HCLK_TOP_SEL_100M,
+	HCLK_TOP_SEL_50M,
+	HCLK_TOP_SEL_OSC,
+
+	/* CRU_CLK_SEL25_CON */
+	CLK_UART_FRAC_NUMERATOR_SHIFT	= 16,
+	CLK_UART_FRAC_NUMERATOR_MASK	= 0xffff << 16,
+	CLK_UART_FRAC_DENOMINATOR_SHIFT	= 0,
+	CLK_UART_FRAC_DENOMINATOR_MASK	= 0xffff,
+
+	/* CRU_CLK_SEL26_CON */
+	CLK_UART_SRC_SEL_SHIFT		= 0,
+	CLK_UART_SRC_SEL_MASK		= 0x3 << CLK_UART_SRC_SEL_SHIFT,
+	CLK_UART_SRC_SEL_GPLL		= 0,
+	CLK_UART_SRC_SEL_CPLL,
+	CLK_UART_SRC_SEL_AUPLL,
+	CLK_UART_SRC_SEL_OSC,
+
+	/* CRU_CLK_SEL27_CON */
+	CLK_UART1_SRC_SEL_SHIFT		= 13,
+	CLK_UART1_SRC_SEL_MASK		= 0x7 << CLK_UART1_SRC_SEL_SHIFT,
+	CLK_UART1_SRC_DIV_SHIFT		= 5,
+	CLK_UART1_SRC_DIV_MASK		= 0xff << CLK_UART1_SRC_DIV_SHIFT,
+
+	/* CRU_CLK_SEL30_CON */
+	CLK_GMAC0_125M_DIV_SHIFT	= 10,
+	CLK_GMAC0_125M_DIV_MASK		= 0x1f << CLK_GMAC0_125M_DIV_SHIFT,
+
+	/* CRU_CLK_SEL31_CON */
+	CLK_GMAC1_125M_DIV_SHIFT	= 0,
+	CLK_GMAC1_125M_DIV_MASK		= 0x1f << CLK_GMAC1_125M_DIV_SHIFT,
+
+	/* CRU_CLK_SEL33_CON */
+	REF_CLK0_OUT_PLL_SEL_SHIFT	= 8,
+	REF_CLK0_OUT_PLL_SEL_MASK	= 7 << REF_CLK0_OUT_PLL_SEL_SHIFT,
+	REF_CLK0_OUT_PLL_SEL_GPLL	= 0,
+	REF_CLK0_OUT_PLL_SEL_CPLL,
+	REF_CLK0_OUT_PLL_SEL_SPLL,
+	REF_CLK0_OUT_PLL_SEL_AUPLL,
+	REF_CLK0_OUT_PLL_SEL_LPLL,
+	REF_CLK0_OUT_PLL_SEL_OSC,
+	REF_CLK0_OUT_PLL_DIV_SHIFT	= 0,
+	REF_CLK0_OUT_PLL_DIV_MASK	= 0xff << REF_CLK0_OUT_PLL_DIV_SHIFT,
+
+	/* CRU_CLK_SEL55_CON */
+	ACLK_BUS_ROOT_SEL_SHIFT		= 9,
+	ACLK_BUS_ROOT_SEL_MASK		= 1 << ACLK_BUS_ROOT_SEL_SHIFT,
+	ACLK_BUS_ROOT_SEL_GPLL		= 0,
+	ACLK_BUS_ROOT_SEL_CPLL,
+	ACLK_BUS_ROOT_DIV_SHIFT		= 4,
+	ACLK_BUS_ROOT_DIV_MASK		= 0x1f << ACLK_BUS_ROOT_DIV_SHIFT,
+	PCLK_BUS_ROOT_SEL_SHIFT		= 2,
+	PCLK_BUS_ROOT_SEL_MASK		= 3 << PCLK_BUS_ROOT_SEL_SHIFT,
+	PCLK_BUS_ROOT_SEL_100M		= 0,
+	PCLK_BUS_ROOT_SEL_50M,
+	PCLK_BUS_ROOT_SEL_OSC,
+	HCLK_BUS_ROOT_SEL_SHIFT		= 0,
+	HCLK_BUS_ROOT_SEL_MASK		= 3 << HCLK_BUS_ROOT_SEL_SHIFT,
+	HCLK_BUS_ROOT_SEL_200M		= 0,
+	HCLK_BUS_ROOT_SEL_100M,
+	HCLK_BUS_ROOT_SEL_50M,
+	HCLK_BUS_ROOT_SEL_OSC,
+
+	/* CRU_CLK_SEL57_CON */
+	CLK_I2C8_SEL_SHIFT		= 14,
+	CLK_I2C8_SEL_MASK		= 3 << CLK_I2C8_SEL_SHIFT,
+	CLK_I2C7_SEL_SHIFT		= 12,
+	CLK_I2C7_SEL_MASK		= 3 << CLK_I2C7_SEL_SHIFT,
+	CLK_I2C6_SEL_SHIFT		= 10,
+	CLK_I2C6_SEL_MASK		= 3 << CLK_I2C6_SEL_SHIFT,
+	CLK_I2C5_SEL_SHIFT		= 8,
+	CLK_I2C5_SEL_MASK		= 3 << CLK_I2C5_SEL_SHIFT,
+	CLK_I2C4_SEL_SHIFT		= 6,
+	CLK_I2C4_SEL_MASK		= 3 << CLK_I2C4_SEL_SHIFT,
+	CLK_I2C3_SEL_SHIFT		= 4,
+	CLK_I2C3_SEL_MASK		= 3 << CLK_I2C3_SEL_SHIFT,
+	CLK_I2C2_SEL_SHIFT		= 2,
+	CLK_I2C2_SEL_MASK		= 3 << CLK_I2C2_SEL_SHIFT,
+	CLK_I2C1_SEL_SHIFT		= 0,
+	CLK_I2C1_SEL_MASK		= 3 << CLK_I2C1_SEL_SHIFT,
+	CLK_I2C_SEL_200M		= 0,
+	CLK_I2C_SEL_100M,
+	CLK_I2C_SEL_50M,
+	CLK_I2C_SEL_OSC,
+
+	/* CRU_CLK_SEL58_CON */
+	CLK_SARADC_SEL_SHIFT		= 12,
+	CLK_SARADC_SEL_MASK		= 0x1 << CLK_SARADC_SEL_SHIFT,
+	CLK_SARADC_SEL_GPLL		= 0,
+	CLK_SARADC_SEL_OSC,
+	CLK_SARADC_DIV_SHIFT		= 4,
+	CLK_SARADC_DIV_MASK		= 0xff << CLK_SARADC_DIV_SHIFT,
+	CLK_I2C9_SEL_SHIFT		= 0,
+	CLK_I2C9_SEL_MASK		= 3 << CLK_I2C9_SEL_SHIFT,
+
+	/* CRU_CLK_SEL59_CON */
+	CLK_TSADC_DIV_SHIFT		= 0,
+	CLK_TSADC_DIV_MASK		= 0xff << CLK_TSADC_DIV_SHIFT,
+
+	/* CRU_CLK_SEL60_CON */
+	CLK_UART_SEL_SHIFT		= 8,
+	CLK_UART_SEL_MASK		= 7 << CLK_UART_SEL_SHIFT,
+	CLK_UART_SEL_GPLL		= 0,
+	CLK_UART_SEL_CPLL,
+	CLK_UART_SEL_AUPLL,
+	CLK_UART_SEL_OSC,
+	CLK_UART_SEL_FRAC0,
+	CLK_UART_SEL_FRAC1,
+	CLK_UART_SEL_FRAC2,
+	CLK_UART_DIV_SHIFT		= 0,
+	CLK_UART_DIV_MASK		= 0xff << CLK_UART_DIV_SHIFT,
+
+	/* CRU_CLK_SEL70_CON */
+	CLK_SPI0_SEL_SHIFT		= 13,
+	CLK_SPI0_SEL_MASK		= 3 << CLK_SPI0_SEL_SHIFT,
+	CLK_SPI_SEL_200M		= 0,
+	CLK_SPI_SEL_100M,
+	CLK_SPI_SEL_50M,
+	CLK_SPI_SEL_OSC,
+
+	/* CRU_CLK_SEL71_CON */
+	CLK_PWM1_SEL_SHIFT		= 8,
+	CLK_PWM1_SEL_MASK		= 3 << CLK_PWM1_SEL_SHIFT,
+	CLK_SPI4_SEL_SHIFT		= 6,
+	CLK_SPI4_SEL_MASK		= 3 << CLK_SPI4_SEL_SHIFT,
+	CLK_SPI3_SEL_SHIFT		= 4,
+	CLK_SPI3_SEL_MASK		= 3 << CLK_SPI3_SEL_SHIFT,
+	CLK_SPI2_SEL_SHIFT		= 2,
+	CLK_SPI2_SEL_MASK		= 3 << CLK_SPI2_SEL_SHIFT,
+	CLK_SPI1_SEL_SHIFT		= 0,
+	CLK_SPI1_SEL_MASK		= 3 << CLK_SPI1_SEL_SHIFT,
+	CLK_PWM_SEL_100M		= 0,
+	CLK_PWM_SEL_50M,
+	CLK_PWM_SEL_OSC,
+
+	/* CRU_CLK_SEL72_CON */
+	DCLK_DECOM_SEL_SHIFT		= 5,
+	DCLK_DECOM_SEL_MASK		= 1 << DCLK_DECOM_SEL_SHIFT,
+	DCLK_DECOM_SEL_GPLL		= 0,
+	DCLK_DECOM_SEL_SPLL,
+	DCLK_DECOM_DIV_SHIFT		= 0,
+	DCLK_DECOM_DIV_MASK		= 0x1f << DCLK_DECOM_DIV_SHIFT,
+
+	/* CRU_CLK_SEL74_CON */
+	CLK_PWM2_SEL_SHIFT		= 6,
+	CLK_PWM2_SEL_MASK		= 3 << CLK_PWM2_SEL_SHIFT,
+
+	/* CRU_CLK_SEL89_CON */
+	CCLK_EMMC_SEL_SHIFT		= 14,
+	CCLK_EMMC_SEL_MASK		= 3 << CCLK_EMMC_SEL_SHIFT,
+	CCLK_EMMC_SEL_GPLL		= 0,
+	CCLK_EMMC_SEL_CPLL,
+	CCLK_EMMC_SEL_OSC,
+	CCLK_EMMC_DIV_SHIFT		= 8,
+	CCLK_EMMC_DIV_MASK		= 0x3f << CCLK_EMMC_DIV_SHIFT,
+	SCLK_FSPI_SEL_SHIFT		= 6,
+	SCLK_FSPI_SEL_MASK		= 3 << SCLK_FSPI_SEL_SHIFT,
+	SCLK_FSPI_SEL_GPLL		= 0,
+	SCLK_FSPI_SEL_CPLL,
+	SCLK_FSPI_SEL_OSC,
+	SCLK_FSPI_DIV_SHIFT		= 0,
+	SCLK_FSPI_DIV_MASK		= 0x3f << SCLK_FSPI_DIV_SHIFT,
+
+	/* CRU_CLK_SEL90_CON */
+	BCLK_EMMC_SEL_SHIFT		= 0,
+	BCLK_EMMC_SEL_MASK		= 3 << BCLK_EMMC_SEL_SHIFT,
+	BCLK_EMMC_SEL_200M		= 0,
+	BCLK_EMMC_SEL_100M,
+	BCLK_EMMC_SEL_50M,
+	BCLK_EMMC_SEL_OSC,
+
+	/* CRU_CLK_SEL104_CON */
+	CLK_GMAC1_PTP_SEL_SHIFT		= 13,
+	CLK_GMAC1_PTP_SEL_MASK		= 3 << CLK_GMAC1_PTP_SEL_SHIFT,
+	CLK_GMAC1_PTP_SEL_GPLL		= 0,
+	CLK_GMAC1_PTP_SEL_CPLL,
+	CLK_GMAC1_PTP_SEL_REFIN,
+	CLK_GMAC1_PTP_DIV_SHIFT		= 8,
+	CLK_GMAC1_PTP_DIV_MASK		= 0x1f << CLK_GMAC1_PTP_DIV_SHIFT,
+	CCLK_SDIO_SRC_SEL_SHIFT		= 6,
+	CCLK_SDIO_SRC_SEL_MASK		= 3 << CCLK_SDIO_SRC_SEL_SHIFT,
+	CCLK_SDIO_SRC_SEL_GPLL		= 0,
+	CCLK_SDIO_SRC_SEL_CPLL,
+	CCLK_SDIO_SRC_SEL_OSC,
+	CCLK_SDIO_SRC_DIV_SHIFT		= 0,
+	CCLK_SDIO_SRC_DIV_MASK		= 0x3f << CCLK_SDIO_SRC_DIV_SHIFT,
+
+	/* CRU_CLK_SEL105_CON */
+	CCLK_SDMMC0_SRC_SEL_SHIFT	= 13,
+	CCLK_SDMMC0_SRC_SEL_MASK	= 3 << CCLK_SDMMC0_SRC_SEL_SHIFT,
+	CCLK_SDMMC0_SRC_SEL_GPLL	= 0,
+	CCLK_SDMMC0_SRC_SEL_CPLL,
+	CCLK_SDMMC0_SRC_SEL_OSC,
+	CCLK_SDMMC0_SRC_DIV_SHIFT	= 7,
+	CCLK_SDMMC0_SRC_DIV_MASK	= 0x3f << CCLK_SDMMC0_SRC_DIV_SHIFT,
+	CLK_GMAC0_PTP_SEL_SHIFT		= 5,
+	CLK_GMAC0_PTP_SEL_MASK		= 3 << CLK_GMAC0_PTP_SEL_SHIFT,
+	CLK_GMAC0_PTP_SEL_GPLL		= 0,
+	CLK_GMAC0_PTP_SEL_CPLL,
+	CLK_GMAC0_PTP_SEL_REFIN,
+	CLK_GMAC0_PTP_DIV_SHIFT		= 0,
+	CLK_GMAC0_PTP_DIV_MASK		= 0x1f << CLK_GMAC0_PTP_DIV_SHIFT,
+
+	/* CRU_CLK_SEL123_CON */
+	DCLK_EBC_SEL_SHIFT		= 12,
+	DCLK_EBC_SEL_MASK		= 7 << DCLK_EBC_SEL_SHIFT,
+	DCLK_EBC_SEL_GPLL		= 0,
+	DCLK_EBC_SEL_CPLL,
+	DCLK_EBC_SEL_VPLL,
+	DCLK_EBC_SEL_AUPLL,
+	DCLK_EBC_SEL_LPLL,
+	DCLK_EBC_SEL_FRAC_SRC,
+	DCLK_EBC_SEL_OSC,
+	DCLK_EBC_DIV_SHIFT		= 3,
+	DCLK_EBC_DIV_MASK		= 0x1ff << DCLK_EBC_DIV_SHIFT,
+	DCLK_EBC_FRAC_SRC_SEL_SHIFT	= 0,
+	DCLK_EBC_FRAC_SRC_SEL_MASK	= 7 << DCLK_EBC_FRAC_SRC_SEL_SHIFT,
+	DCLK_EBC_FRAC_SRC_SEL_GPLL	= 0,
+	DCLK_EBC_FRAC_SRC_SEL_CPLL,
+	DCLK_EBC_FRAC_SRC_SEL_VPLL,
+	DCLK_EBC_FRAC_SRC_SEL_AUPLL,
+	DCLK_EBC_FRAC_SRC_SEL_OSC,
+
+	/* CRU_CLK_SEL144_CON */
+	PCLK_VOP_ROOT_SEL_SHIFT		= 12,
+	PCLK_VOP_ROOT_SEL_MASK		= 3 << PCLK_VOP_ROOT_SEL_SHIFT,
+	PCLK_VOP_ROOT_SEL_100M		= 0,
+	PCLK_VOP_ROOT_SEL_50M,
+	PCLK_VOP_ROOT_SEL_OSC,
+	HCLK_VOP_ROOT_SEL_SHIFT		= 10,
+	HCLK_VOP_ROOT_SEL_MASK		= 3 << HCLK_VOP_ROOT_SEL_SHIFT,
+	HCLK_VOP_ROOT_SEL_200M		= 0,
+	HCLK_VOP_ROOT_SEL_100M,
+	HCLK_VOP_ROOT_SEL_50M,
+	HCLK_VOP_ROOT_SEL_OSC,
+	ACLK_VOP_ROOT_SEL_SHIFT		= 5,
+	ACLK_VOP_ROOT_SEL_MASK		= 7 << ACLK_VOP_ROOT_SEL_SHIFT,
+	ACLK_VOP_ROOT_SEL_GPLL		= 0,
+	ACLK_VOP_ROOT_SEL_CPLL,
+	ACLK_VOP_ROOT_SEL_AUPLL,
+	ACLK_VOP_ROOT_SEL_SPLL,
+	ACLK_VOP_ROOT_SEL_LPLL,
+	ACLK_VOP_ROOT_DIV_SHIFT		= 0,
+	ACLK_VOP_ROOT_DIV_MASK		= 0x1f << ACLK_VOP_ROOT_DIV_SHIFT,
+
+	/* CRU_CLK_SEL145_CON */
+	DCLK0_VOP_SRC_SEL_SHIFT		= 8,
+	DCLK0_VOP_SRC_SEL_MASK		= 7 << DCLK0_VOP_SRC_SEL_SHIFT,
+	DCLK_VOP_SRC_SEL_GPLL		= 0,
+	DCLK_VOP_SRC_SEL_CPLL,
+	DCLK_VOP_SRC_SEL_VPLL,
+	DCLK_VOP_SRC_SEL_BPLL,
+	DCLK_VOP_SRC_SEL_LPLL,
+	DCLK0_VOP_SRC_DIV_SHIFT		= 0,
+	DCLK0_VOP_SRC_DIV_MASK		= 0xff << DCLK0_VOP_SRC_DIV_SHIFT,
+
+	/* CRU_CLK_SEL147_CON */
+	DCLK2_VOP_SEL_SHIFT		= 13,
+	DCLK2_VOP_SEL_MASK		= 1 << DCLK2_VOP_SEL_SHIFT,
+	DCLK1_VOP_SEL_SHIFT		= 12,
+	DCLK1_VOP_SEL_MASK		= 1 << DCLK1_VOP_SEL_SHIFT,
+	DCLK0_VOP_SEL_SHIFT		= 11,
+	DCLK0_VOP_SEL_MASK		= 1 << DCLK0_VOP_SEL_SHIFT,
+
+	/* CRU_CLK_SEL149_CON */
+	ACLK_VO0_ROOT_SEL_SHIFT		= 5,
+	ACLK_VO0_ROOT_SEL_MASK		= 3 << ACLK_VO0_ROOT_SEL_SHIFT,
+	ACLK_VO0_ROOT_SEL_GPLL		= 0,
+	ACLK_VO0_ROOT_SEL_CPLL,
+	ACLK_VO0_ROOT_SEL_LPLL,
+	ACLK_VO0_ROOT_SEL_BPLL,
+	ACLK_VO0_ROOT_DIV_SHIFT		= 0,
+	ACLK_VO0_ROOT_DIV_MASK		= 0x1f << ACLK_VO0_ROOT_DIV_SHIFT,
+
+	/* CRU_CLK_SEL151_CON */
+	CLK_DSIHOST0_SEL_SHIFT		= 7,
+	CLK_DSIHOST0_SEL_MASK		= 7 << CLK_DSIHOST0_SEL_SHIFT,
+	CLK_DSIHOST0_SEL_GPLL		= 0,
+	CLK_DSIHOST0_SEL_CPLL,
+	CLK_DSIHOST0_SEL_SPLL,
+	CLK_DSIHOST0_SEL_VPLL,
+	CLK_DSIHOST0_SEL_BPLL,
+	CLK_DSIHOST0_SEL_LPLL,
+	CLK_DSIHOST0_DIV_SHIFT		= 0,
+	CLK_DSIHOST0_DIV_MASK		= 0x7f << CLK_DSIHOST0_DIV_SHIFT,
+
+	/* PMUCRU_CLK_SEL5_CON */
+	CLK_PMU1PWM_SEL_SHIFT		= 2,
+	CLK_PMU1PWM_SEL_MASK		= 3 << CLK_PMU1PWM_SEL_SHIFT,
+
+	/* PMUCRU_CLK_SEL6_CON */
+	CLK_I2C0_SEL_SHIFT		= 7,
+	CLK_I2C0_SEL_MASK		= 3 << CLK_I2C0_SEL_SHIFT,
+
+	/* PMUCRU_CLK_SEL8_CON */
+	CLK_UART1_SEL_SHIFT		= 0,
+	CLK_UART1_SEL_MASK		= 1 << CLK_UART1_SEL_SHIFT,
+	CLK_UART1_SEL_TOP		= 0,
+	CLK_UART1_SEL_OSC,
+
+	/* LITCRU_CLK_SEL0_CON */
+	CLK_LITCORE_SEL_SHIFT		= 12,
+	CLK_LITCORE_SEL_MASK		= 3 << CLK_LITCORE_SEL_SHIFT,
+	CLK_LITCORE_SEL_LPLL		= 0,
+	CLK_LITCORE_SEL_GPLL,
+	CLK_LITCORE_SEL_PVTPLL,
+	CLK_LITCORE_DIV_SHIFT		= 7,
+	CLK_LITCORE_DIV_MASK		= 0x1f << CLK_LITCORE_DIV_SHIFT,
+
+};
+#endif
diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 70be03164e8..34b63d4df34 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ROCKCHIP_RK3368) += clk_rk3368.o
 obj-$(CONFIG_ROCKCHIP_RK3399) += clk_rk3399.o
 obj-$(CONFIG_ROCKCHIP_RK3528) += clk_rk3528.o
 obj-$(CONFIG_ROCKCHIP_RK3568) += clk_rk3568.o
+obj-$(CONFIG_ROCKCHIP_RK3576) += clk_rk3576.o
 obj-$(CONFIG_ROCKCHIP_RK3588) += clk_rk3588.o
 obj-$(CONFIG_ROCKCHIP_RV1108) += clk_rv1108.o
 obj-$(CONFIG_ROCKCHIP_RV1126) += clk_rv1126.o
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
new file mode 100644
index 00000000000..e84a0943a94
--- /dev/null
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -0,0 +1,2513 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Fuzhou Rockchip Electronics Co., Ltd
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#include <bitfield.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <syscon.h>
+#include <asm/arch-rockchip/cru_rk3576.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dt-bindings/clock/rockchip,rk3576-cru.h>
+#include <linux/delay.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define DIV_TO_RATE(input_rate, div)	((input_rate) / ((div) + 1))
+
+static struct rockchip_pll_rate_table rk3576_24m_pll_rates[] = {
+	/* _mhz, _p, _m, _s, _k */
+	RK3588_PLL_RATE(1500000000, 2, 250, 1, 0),
+	RK3588_PLL_RATE(1200000000, 1, 100, 1, 0),
+	RK3588_PLL_RATE(1188000000, 2, 198, 1, 0),
+	RK3588_PLL_RATE(1150000000, 3, 575, 2, 0),
+	RK3588_PLL_RATE(1100000000, 3, 550, 2, 0),
+	RK3588_PLL_RATE(1008000000, 2, 336, 2, 0),
+	RK3588_PLL_RATE(1000000000, 3, 500, 2, 0),
+	RK3588_PLL_RATE(900000000, 2, 300, 2, 0),
+	RK3588_PLL_RATE(850000000, 3, 425, 2, 0),
+	RK3588_PLL_RATE(816000000, 2, 272, 2, 0),
+	RK3588_PLL_RATE(786432000, 2, 262, 2, 9437),
+	RK3588_PLL_RATE(786000000, 1, 131, 2, 0),
+	RK3588_PLL_RATE(742500000, 4, 495, 2, 0),
+	RK3588_PLL_RATE(722534400, 8, 963, 2, 24850),
+	RK3588_PLL_RATE(600000000, 2, 200, 2, 0),
+	RK3588_PLL_RATE(594000000, 2, 198, 2, 0),
+	RK3588_PLL_RATE(200000000, 3, 400, 4, 0),
+	RK3588_PLL_RATE(100000000, 3, 400, 5, 0),
+	{ /* sentinel */ },
+};
+
+static struct rockchip_pll_clock rk3576_pll_clks[] = {
+	[BPLL] = PLL(pll_rk3588, PLL_BPLL, RK3576_PLL_CON(0),
+		      RK3576_BPLL_MODE_CON0, 0, 15, 0,
+		      rk3576_24m_pll_rates),
+	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3576_LPLL_CON(16),
+		     RK3576_LPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
+	[VPLL] = PLL(pll_rk3588, PLL_VPLL, RK3576_PLL_CON(88),
+		      RK3576_LPLL_MODE_CON0, 4, 15, 0, rk3576_24m_pll_rates),
+	[AUPLL] = PLL(pll_rk3588, PLL_AUPLL, RK3576_PLL_CON(96),
+		      RK3576_MODE_CON0, 6, 15, 0, rk3576_24m_pll_rates),
+	[CPLL] = PLL(pll_rk3588, PLL_CPLL, RK3576_PLL_CON(104),
+		     RK3576_MODE_CON0, 8, 15, 0, rk3576_24m_pll_rates),
+	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
+		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
+	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PMU_PLL_CON(128),
+		     RK3576_MODE_CON0, 10, 15, 0, rk3576_24m_pll_rates),
+};
+
+#ifdef CONFIG_SPL_BUILD
+#ifndef BITS_WITH_WMASK
+#define BITS_WITH_WMASK(bits, msk, shift) \
+	((bits) << (shift)) | ((msk) << ((shift) + 16))
+#endif
+#endif
+
+#ifndef CONFIG_SPL_BUILD
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
+#endif
+
+static ulong rk3576_bus_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 con, sel, div, rate;
+
+	switch (clk_id) {
+	case ACLK_BUS_ROOT:
+		con = readl(&cru->clksel_con[55]);
+		sel = (con & ACLK_BUS_ROOT_SEL_MASK) >>
+		      ACLK_BUS_ROOT_SEL_SHIFT;
+		div = (con & ACLK_BUS_ROOT_DIV_MASK) >>
+		      ACLK_BUS_ROOT_DIV_SHIFT;
+		if (sel == ACLK_BUS_ROOT_SEL_CPLL)
+			rate = DIV_TO_RATE(priv->cpll_hz, div);
+		else
+			rate = DIV_TO_RATE(priv->gpll_hz, div);
+		break;
+	case HCLK_BUS_ROOT:
+		con = readl(&cru->clksel_con[55]);
+		sel = (con & HCLK_BUS_ROOT_SEL_MASK) >>
+		      HCLK_BUS_ROOT_SEL_SHIFT;
+		if (sel == HCLK_BUS_ROOT_SEL_200M)
+			rate = 198 * MHz;
+		else if (sel == HCLK_BUS_ROOT_SEL_100M)
+			rate = 100 * MHz;
+		else if (sel == HCLK_BUS_ROOT_SEL_50M)
+			rate = 50 * MHz;
+		else
+			rate = OSC_HZ;
+		break;
+	case PCLK_BUS_ROOT:
+		con = readl(&cru->clksel_con[55]);
+		sel = (con & PCLK_BUS_ROOT_SEL_MASK) >>
+		      PCLK_BUS_ROOT_SEL_SHIFT;
+		if (sel == PCLK_BUS_ROOT_SEL_100M)
+			rate = 100 * MHz;
+		else if (sel == PCLK_BUS_ROOT_SEL_50M)
+			rate = 50 * MHz;
+		else
+			rate = OSC_HZ;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rate;
+}
+
+static ulong rk3576_bus_set_clk(struct rk3576_clk_priv *priv,
+				ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	int src_clk, src_clk_div;
+
+	switch (clk_id) {
+	case ACLK_BUS_ROOT:
+		if (!(priv->cpll_hz % rate)) {
+			src_clk = ACLK_BUS_ROOT_SEL_CPLL;
+			src_clk_div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		} else {
+			src_clk = ACLK_BUS_ROOT_SEL_GPLL;
+			src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		}
+		rk_clrsetreg(&cru->clksel_con[55],
+			     ACLK_BUS_ROOT_SEL_MASK,
+			     src_clk << ACLK_BUS_ROOT_SEL_SHIFT);
+		assert(src_clk_div - 1 <= 31);
+		rk_clrsetreg(&cru->clksel_con[55],
+			     ACLK_BUS_ROOT_DIV_MASK |
+			     ACLK_BUS_ROOT_SEL_MASK,
+			     (src_clk <<
+			      ACLK_BUS_ROOT_SEL_SHIFT) |
+			     (src_clk_div - 1) << ACLK_BUS_ROOT_DIV_SHIFT);
+		break;
+	case HCLK_BUS_ROOT:
+		if (rate >= 198 * MHz)
+			src_clk = HCLK_BUS_ROOT_SEL_200M;
+		else if (rate >= 99 * MHz)
+			src_clk = HCLK_BUS_ROOT_SEL_100M;
+		else if (rate >= 50 * MHz)
+			src_clk = HCLK_BUS_ROOT_SEL_50M;
+		else
+			src_clk = HCLK_BUS_ROOT_SEL_OSC;
+		rk_clrsetreg(&cru->clksel_con[55],
+			     HCLK_BUS_ROOT_SEL_MASK,
+			     src_clk << HCLK_BUS_ROOT_SEL_SHIFT);
+		break;
+	case PCLK_BUS_ROOT:
+		if (rate >= 99 * MHz)
+			src_clk = PCLK_BUS_ROOT_SEL_100M;
+		else if (rate >= 50 * MHz)
+			src_clk = PCLK_BUS_ROOT_SEL_50M;
+		else
+			src_clk = PCLK_BUS_ROOT_SEL_OSC;
+		rk_clrsetreg(&cru->clksel_con[55],
+			     PCLK_BUS_ROOT_SEL_MASK,
+			     src_clk << PCLK_BUS_ROOT_SEL_SHIFT);
+		break;
+	default:
+		printf("do not support this center freq\n");
+		return -EINVAL;
+	}
+
+	return rk3576_bus_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_top_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 con, sel, div, rate, prate;
+
+	switch (clk_id) {
+	case ACLK_TOP:
+		con = readl(&cru->clksel_con[9]);
+		div = (con & ACLK_TOP_DIV_MASK) >>
+		      ACLK_TOP_DIV_SHIFT;
+		sel = (con & ACLK_TOP_SEL_MASK) >>
+		      ACLK_TOP_SEL_SHIFT;
+		if (sel == ACLK_TOP_SEL_CPLL)
+			prate = priv->cpll_hz;
+		else if (sel == ACLK_TOP_SEL_AUPLL)
+			prate = priv->aupll_hz;
+		else
+			prate = priv->gpll_hz;
+		return DIV_TO_RATE(prate, div);
+	case ACLK_TOP_MID:
+		con = readl(&cru->clksel_con[10]);
+		div = (con & ACLK_TOP_MID_DIV_MASK) >>
+		      ACLK_TOP_MID_DIV_SHIFT;
+		sel = (con & ACLK_TOP_MID_SEL_MASK) >>
+		      ACLK_TOP_MID_SEL_SHIFT;
+		if (sel == ACLK_TOP_MID_SEL_CPLL)
+			prate = priv->cpll_hz;
+		else
+			prate = priv->gpll_hz;
+		return DIV_TO_RATE(prate, div);
+	case PCLK_TOP_ROOT:
+		con = readl(&cru->clksel_con[8]);
+		sel = (con & PCLK_TOP_SEL_MASK) >> PCLK_TOP_SEL_SHIFT;
+		if (sel == PCLK_TOP_SEL_100M)
+			rate = 100 * MHz;
+		else if (sel == PCLK_TOP_SEL_50M)
+			rate = 50 * MHz;
+		else
+			rate = OSC_HZ;
+		break;
+	case HCLK_TOP:
+		con = readl(&cru->clksel_con[19]);
+		sel = (con & HCLK_TOP_SEL_MASK) >> HCLK_TOP_SEL_SHIFT;
+		if (sel == HCLK_TOP_SEL_200M)
+			rate = 200 * MHz;
+		else if (sel == HCLK_TOP_SEL_100M)
+			rate = 100 * MHz;
+		else if (sel == HCLK_TOP_SEL_50M)
+			rate = 50 * MHz;
+		else
+			rate = OSC_HZ;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rate;
+}
+
+static ulong rk3576_top_set_clk(struct rk3576_clk_priv *priv,
+				ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	int src_clk, src_clk_div;
+
+	switch (clk_id) {
+	case ACLK_TOP:
+		if (!(priv->cpll_hz % rate)) {
+			src_clk = ACLK_TOP_SEL_CPLL;
+			src_clk_div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		} else {
+			src_clk = ACLK_TOP_SEL_GPLL;
+			src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		}
+		assert(src_clk_div - 1 <= 31);
+		rk_clrsetreg(&cru->clksel_con[9],
+			     ACLK_TOP_DIV_MASK |
+			     ACLK_TOP_SEL_MASK,
+			     (src_clk <<
+			      ACLK_TOP_SEL_SHIFT) |
+			     (src_clk_div - 1) << ACLK_TOP_SEL_SHIFT);
+		break;
+	case ACLK_TOP_MID:
+		if (!(priv->cpll_hz % rate)) {
+			src_clk = ACLK_TOP_MID_SEL_CPLL;
+			src_clk_div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		} else {
+			src_clk = ACLK_TOP_MID_SEL_GPLL;
+			src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		}
+		rk_clrsetreg(&cru->clksel_con[10],
+			     ACLK_TOP_MID_DIV_MASK |
+			     ACLK_TOP_MID_SEL_MASK,
+			     (ACLK_TOP_MID_SEL_GPLL <<
+			      ACLK_TOP_MID_SEL_SHIFT) |
+			     (src_clk_div - 1) << ACLK_TOP_MID_DIV_SHIFT);
+		break;
+	case PCLK_TOP_ROOT:
+		if (rate >= 99 * MHz)
+			src_clk = PCLK_TOP_SEL_100M;
+		else if (rate >= 50 * MHz)
+			src_clk = PCLK_TOP_SEL_50M;
+		else
+			src_clk = PCLK_TOP_SEL_OSC;
+		rk_clrsetreg(&cru->clksel_con[8],
+			     PCLK_TOP_SEL_MASK,
+			     src_clk << PCLK_TOP_SEL_SHIFT);
+		break;
+	case HCLK_TOP:
+		if (rate >= 198 * MHz)
+			src_clk = HCLK_TOP_SEL_200M;
+		else if (rate >= 99 * MHz)
+			src_clk = HCLK_TOP_SEL_100M;
+		else if (rate >= 50 * MHz)
+			src_clk = HCLK_TOP_SEL_50M;
+		else
+			src_clk = HCLK_TOP_SEL_OSC;
+		rk_clrsetreg(&cru->clksel_con[19],
+			     HCLK_TOP_SEL_MASK,
+			     src_clk << HCLK_TOP_SEL_SHIFT);
+		break;
+	default:
+		printf("do not support this top freq\n");
+		return -EINVAL;
+	}
+
+	return rk3576_top_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_i2c_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 sel, con;
+	ulong rate;
+
+	switch (clk_id) {
+	case CLK_I2C0:
+		con = readl(&cru->pmuclksel_con[6]);
+		sel = (con & CLK_I2C0_SEL_MASK) >> CLK_I2C0_SEL_SHIFT;
+		break;
+	case CLK_I2C1:
+		con = readl(&cru->clksel_con[57]);
+		sel = (con & CLK_I2C1_SEL_MASK) >> CLK_I2C1_SEL_SHIFT;
+		break;
+	case CLK_I2C2:
+		con = readl(&cru->clksel_con[57]);
+		sel = (con & CLK_I2C2_SEL_MASK) >> CLK_I2C2_SEL_SHIFT;
+		break;
+	case CLK_I2C3:
+		con = readl(&cru->clksel_con[57]);
+		sel = (con & CLK_I2C3_SEL_MASK) >> CLK_I2C3_SEL_SHIFT;
+		break;
+	case CLK_I2C4:
+		con = readl(&cru->clksel_con[57]);
+		sel = (con & CLK_I2C4_SEL_MASK) >> CLK_I2C4_SEL_SHIFT;
+		break;
+	case CLK_I2C5:
+		con = readl(&cru->clksel_con[57]);
+		sel = (con & CLK_I2C5_SEL_MASK) >> CLK_I2C5_SEL_SHIFT;
+		break;
+	case CLK_I2C6:
+		con = readl(&cru->clksel_con[57]);
+		sel = (con & CLK_I2C6_SEL_MASK) >> CLK_I2C6_SEL_SHIFT;
+		break;
+	case CLK_I2C7:
+		con = readl(&cru->clksel_con[57]);
+		sel = (con & CLK_I2C7_SEL_MASK) >> CLK_I2C7_SEL_SHIFT;
+		break;
+	case CLK_I2C8:
+		con = readl(&cru->clksel_con[57]);
+		sel = (con & CLK_I2C8_SEL_MASK) >> CLK_I2C8_SEL_SHIFT;
+		break;
+	case CLK_I2C9:
+		con = readl(&cru->clksel_con[58]);
+		sel = (con & CLK_I2C9_SEL_MASK) >> CLK_I2C9_SEL_SHIFT;
+		break;
+
+	default:
+		return -ENOENT;
+	}
+	if (sel == CLK_I2C_SEL_200M)
+		rate = 200 * MHz;
+	else if (sel == CLK_I2C_SEL_100M)
+		rate = 100 * MHz;
+	else if (sel == CLK_I2C_SEL_50M)
+		rate = 50 * MHz;
+	else
+		rate = OSC_HZ;
+
+	return rate;
+}
+
+static ulong rk3576_i2c_set_clk(struct rk3576_clk_priv *priv, ulong clk_id,
+				ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	int src_clk;
+
+	if (rate >= 198 * MHz)
+		src_clk = CLK_I2C_SEL_200M;
+	else if (rate >= 99 * MHz)
+		src_clk = CLK_I2C_SEL_100M;
+	if (rate >= 50 * MHz)
+		src_clk = CLK_I2C_SEL_50M;
+	else
+		src_clk = CLK_I2C_SEL_OSC;
+
+	switch (clk_id) {
+	case CLK_I2C0:
+		rk_clrsetreg(&cru->pmuclksel_con[6], CLK_I2C0_SEL_MASK,
+			     src_clk << CLK_I2C0_SEL_SHIFT);
+		break;
+	case CLK_I2C1:
+		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C1_SEL_MASK,
+			     src_clk << CLK_I2C1_SEL_SHIFT);
+		break;
+	case CLK_I2C2:
+		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C2_SEL_MASK,
+			     src_clk << CLK_I2C2_SEL_SHIFT);
+		break;
+	case CLK_I2C3:
+		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C3_SEL_MASK,
+			     src_clk << CLK_I2C3_SEL_SHIFT);
+		break;
+	case CLK_I2C4:
+		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C4_SEL_MASK,
+			     src_clk << CLK_I2C4_SEL_SHIFT);
+		break;
+	case CLK_I2C5:
+		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C5_SEL_MASK,
+			     src_clk << CLK_I2C5_SEL_SHIFT);
+		break;
+	case CLK_I2C6:
+		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C6_SEL_MASK,
+			     src_clk << CLK_I2C6_SEL_SHIFT);
+		break;
+	case CLK_I2C7:
+		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C7_SEL_MASK,
+			     src_clk << CLK_I2C7_SEL_SHIFT);
+		break;
+	case CLK_I2C8:
+		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C8_SEL_MASK,
+			     src_clk << CLK_I2C8_SEL_SHIFT);
+	case CLK_I2C9:
+		rk_clrsetreg(&cru->clksel_con[58], CLK_I2C9_SEL_MASK,
+			     src_clk << CLK_I2C9_SEL_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rk3576_i2c_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_spi_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 sel, con;
+
+	switch (clk_id) {
+	case CLK_SPI0:
+		con = readl(&cru->clksel_con[70]);
+		sel = (con & CLK_SPI0_SEL_MASK) >> CLK_SPI0_SEL_SHIFT;
+		break;
+	case CLK_SPI1:
+		con = readl(&cru->clksel_con[71]);
+		sel = (con & CLK_SPI1_SEL_MASK) >> CLK_SPI1_SEL_SHIFT;
+		break;
+	case CLK_SPI2:
+		con = readl(&cru->clksel_con[71]);
+		sel = (con & CLK_SPI2_SEL_MASK) >> CLK_SPI2_SEL_SHIFT;
+		break;
+	case CLK_SPI3:
+		con = readl(&cru->clksel_con[71]);
+		sel = (con & CLK_SPI3_SEL_MASK) >> CLK_SPI3_SEL_SHIFT;
+		break;
+	case CLK_SPI4:
+		con = readl(&cru->clksel_con[71]);
+		sel = (con & CLK_SPI4_SEL_MASK) >> CLK_SPI4_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	switch (sel) {
+	case CLK_SPI_SEL_200M:
+		return 200 * MHz;
+	case CLK_SPI_SEL_100M:
+		return 100 * MHz;
+	case CLK_SPI_SEL_50M:
+		return 50 * MHz;
+	case CLK_SPI_SEL_OSC:
+		return OSC_HZ;
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rk3576_spi_set_clk(struct rk3576_clk_priv *priv,
+				ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	int src_clk;
+
+	if (rate >= 198 * MHz)
+		src_clk = CLK_SPI_SEL_200M;
+	else if (rate >= 99 * MHz)
+		src_clk = CLK_SPI_SEL_100M;
+	else if (rate >= 50 * MHz)
+		src_clk = CLK_SPI_SEL_50M;
+	else
+		src_clk = CLK_SPI_SEL_OSC;
+
+	switch (clk_id) {
+	case CLK_SPI0:
+		rk_clrsetreg(&cru->clksel_con[70],
+			     CLK_SPI0_SEL_MASK,
+			     src_clk << CLK_SPI0_SEL_SHIFT);
+		break;
+	case CLK_SPI1:
+		rk_clrsetreg(&cru->clksel_con[71],
+			     CLK_SPI1_SEL_MASK,
+			     src_clk << CLK_SPI1_SEL_SHIFT);
+		break;
+	case CLK_SPI2:
+		rk_clrsetreg(&cru->clksel_con[71],
+			     CLK_SPI2_SEL_MASK,
+			     src_clk << CLK_SPI2_SEL_SHIFT);
+		break;
+	case CLK_SPI3:
+		rk_clrsetreg(&cru->clksel_con[71],
+			     CLK_SPI3_SEL_MASK,
+			     src_clk << CLK_SPI3_SEL_SHIFT);
+		break;
+	case CLK_SPI4:
+		rk_clrsetreg(&cru->clksel_con[71],
+			     CLK_SPI4_SEL_MASK,
+			     src_clk << CLK_SPI4_SEL_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rk3576_spi_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_pwm_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 sel, con;
+
+	switch (clk_id) {
+	case CLK_PWM1:
+		con = readl(&cru->clksel_con[71]);
+		sel = (con & CLK_PWM1_SEL_MASK) >> CLK_PWM1_SEL_SHIFT;
+		break;
+	case CLK_PWM2:
+		con = readl(&cru->clksel_con[74]);
+		sel = (con & CLK_PWM2_SEL_MASK) >> CLK_PWM2_SEL_SHIFT;
+		break;
+	case CLK_PMU1PWM:
+		con = readl(&cru->pmuclksel_con[5]);
+		sel = (con & CLK_PMU1PWM_SEL_MASK) >> CLK_PMU1PWM_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	switch (sel) {
+	case CLK_PWM_SEL_100M:
+		return 100 * MHz;
+	case CLK_PWM_SEL_50M:
+		return 50 * MHz;
+	case CLK_PWM_SEL_OSC:
+		return OSC_HZ;
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rk3576_pwm_set_clk(struct rk3576_clk_priv *priv,
+				ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	int src_clk;
+
+	if (rate >= 99 * MHz)
+		src_clk = CLK_PWM_SEL_100M;
+	else if (rate >= 50 * MHz)
+		src_clk = CLK_PWM_SEL_50M;
+	else
+		src_clk = CLK_PWM_SEL_OSC;
+
+	switch (clk_id) {
+	case CLK_PWM1:
+		rk_clrsetreg(&cru->clksel_con[71],
+			     CLK_PWM1_SEL_MASK,
+			     src_clk << CLK_PWM1_SEL_SHIFT);
+		break;
+	case CLK_PWM2:
+		rk_clrsetreg(&cru->clksel_con[74],
+			     CLK_PWM2_SEL_MASK,
+			     src_clk << CLK_PWM2_SEL_SHIFT);
+		break;
+	case CLK_PMU1PWM:
+		rk_clrsetreg(&cru->pmuclksel_con[5],
+			     CLK_PMU1PWM_SEL_MASK,
+			     src_clk << CLK_PMU1PWM_SEL_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rk3576_pwm_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_adc_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 div, sel, con, prate;
+
+	switch (clk_id) {
+	case CLK_SARADC:
+		con = readl(&cru->clksel_con[58]);
+		div = (con & CLK_SARADC_DIV_MASK) >> CLK_SARADC_DIV_SHIFT;
+		sel = (con & CLK_SARADC_SEL_MASK) >>
+		      CLK_SARADC_SEL_SHIFT;
+		if (sel == CLK_SARADC_SEL_OSC)
+			prate = OSC_HZ;
+		else
+			prate = priv->gpll_hz;
+		return DIV_TO_RATE(prate, div);
+	case CLK_TSADC:
+		con = readl(&cru->clksel_con[59]);
+		div = (con & CLK_TSADC_DIV_MASK) >>
+		      CLK_TSADC_DIV_SHIFT;
+		prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rk3576_adc_set_clk(struct rk3576_clk_priv *priv,
+				ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	int src_clk_div;
+
+	switch (clk_id) {
+	case CLK_SARADC:
+		if (!(OSC_HZ % rate)) {
+			src_clk_div = DIV_ROUND_UP(OSC_HZ, rate);
+			assert(src_clk_div - 1 <= 255);
+			rk_clrsetreg(&cru->clksel_con[58],
+				     CLK_SARADC_SEL_MASK |
+				     CLK_SARADC_DIV_MASK,
+				     (CLK_SARADC_SEL_OSC <<
+				      CLK_SARADC_SEL_SHIFT) |
+				     (src_clk_div - 1) <<
+				     CLK_SARADC_DIV_SHIFT);
+		} else {
+			src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
+			assert(src_clk_div - 1 <= 255);
+			rk_clrsetreg(&cru->clksel_con[59],
+				     CLK_SARADC_SEL_MASK |
+				     CLK_SARADC_DIV_MASK,
+				     (CLK_SARADC_SEL_GPLL <<
+				      CLK_SARADC_SEL_SHIFT) |
+				     (src_clk_div - 1) <<
+				     CLK_SARADC_DIV_SHIFT);
+		}
+		break;
+	case CLK_TSADC:
+		src_clk_div = DIV_ROUND_UP(OSC_HZ, rate);
+		assert(src_clk_div - 1 <= 255);
+		rk_clrsetreg(&cru->clksel_con[58],
+			     CLK_TSADC_DIV_MASK,
+			     (src_clk_div - 1) <<
+			     CLK_TSADC_DIV_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+	return rk3576_adc_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_mmc_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 sel, con, prate, div = 0;
+
+	switch (clk_id) {
+	case CCLK_SRC_SDIO:
+	case HCLK_SDIO:
+		con = readl(&cru->clksel_con[104]);
+		div = (con & CCLK_SDIO_SRC_DIV_MASK) >> CCLK_SDIO_SRC_DIV_SHIFT;
+		sel = (con & CCLK_SDIO_SRC_SEL_MASK) >>
+		      CCLK_SDIO_SRC_SEL_SHIFT;
+		if (sel == CCLK_SDIO_SRC_SEL_GPLL)
+			prate = priv->gpll_hz;
+		else if (sel == CCLK_SDIO_SRC_SEL_CPLL)
+			prate = priv->cpll_hz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	case CCLK_SRC_SDMMC0:
+	case HCLK_SDMMC0:
+		con = readl(&cru->clksel_con[105]);
+		div = (con & CCLK_SDMMC0_SRC_DIV_MASK) >> CCLK_SDMMC0_SRC_DIV_SHIFT;
+		sel = (con & CCLK_SDMMC0_SRC_SEL_MASK) >>
+		      CCLK_SDMMC0_SRC_SEL_SHIFT;
+		if (sel == CCLK_SDMMC0_SRC_SEL_GPLL)
+			prate = priv->gpll_hz;
+		else if (sel == CCLK_SDMMC0_SRC_SEL_CPLL)
+			prate = priv->cpll_hz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	case CCLK_SRC_EMMC:
+	case HCLK_EMMC:
+		con = readl(&cru->clksel_con[89]);
+		div = (con & CCLK_EMMC_DIV_MASK) >> CCLK_EMMC_DIV_SHIFT;
+		sel = (con & CCLK_EMMC_SEL_MASK) >>
+		      CCLK_EMMC_SEL_SHIFT;
+		if (sel == CCLK_EMMC_SEL_GPLL)
+			prate = priv->gpll_hz;
+		else if (sel == CCLK_EMMC_SEL_CPLL)
+			prate = priv->cpll_hz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	case BCLK_EMMC:
+		con = readl(&cru->clksel_con[90]);
+		sel = (con & BCLK_EMMC_SEL_MASK) >>
+		      BCLK_EMMC_SEL_SHIFT;
+		if (sel == BCLK_EMMC_SEL_200M)
+			prate = 200 * MHz;
+		else if (sel == BCLK_EMMC_SEL_100M)
+			prate = 100 * MHz;
+		else if (sel == BCLK_EMMC_SEL_50M)
+			prate = 50 * MHz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	case SCLK_FSPI_X2:
+		con = readl(&cru->clksel_con[89]);
+		div = (con & SCLK_FSPI_DIV_MASK) >> SCLK_FSPI_DIV_SHIFT;
+		sel = (con & SCLK_FSPI_SEL_MASK) >>
+		      SCLK_FSPI_SEL_SHIFT;
+		if (sel == SCLK_FSPI_SEL_GPLL)
+			prate = priv->gpll_hz;
+		else if (sel == SCLK_FSPI_SEL_CPLL)
+			prate = priv->cpll_hz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	case SCLK_FSPI1_X2:
+		con = readl(&cru->clksel_con[106]);
+		div = (con & SCLK_FSPI_DIV_MASK) >> SCLK_FSPI_DIV_SHIFT;
+		sel = (con & SCLK_FSPI_SEL_MASK) >>
+		      SCLK_FSPI_SEL_SHIFT;
+		if (sel == SCLK_FSPI_SEL_GPLL)
+			prate = priv->gpll_hz;
+		else if (sel == SCLK_FSPI_SEL_CPLL)
+			prate = priv->cpll_hz;
+		else
+			prate = OSC_HZ;
+		return DIV_TO_RATE(prate, div);
+	case DCLK_DECOM:
+		con = readl(&cru->clksel_con[72]);
+		div = (con & DCLK_DECOM_DIV_MASK) >> DCLK_DECOM_DIV_SHIFT;
+		sel = (con & DCLK_DECOM_SEL_MASK) >> DCLK_DECOM_SEL_SHIFT;
+		if (sel == DCLK_DECOM_SEL_SPLL)
+			prate = priv->spll_hz;
+		else
+			prate = priv->gpll_hz;
+		return DIV_TO_RATE(prate, div);
+
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rk3576_mmc_set_clk(struct rk3576_clk_priv *priv,
+				ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	int src_clk, div = 0;
+
+	switch (clk_id) {
+	case CCLK_SRC_SDIO:
+	case CCLK_SRC_SDMMC0:
+	case CCLK_SRC_EMMC:
+	case SCLK_FSPI_X2:
+	case SCLK_FSPI1_X2:
+	case HCLK_SDMMC0:
+	case HCLK_EMMC:
+	case HCLK_SDIO:
+		if (!(OSC_HZ % rate)) {
+			src_clk = SCLK_FSPI_SEL_OSC;
+			div = DIV_ROUND_UP(OSC_HZ, rate);
+		} else if (!(priv->cpll_hz % rate)) {
+			src_clk = SCLK_FSPI_SEL_CPLL;
+			div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		} else {
+			src_clk = SCLK_FSPI_SEL_GPLL;
+			div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		}
+		break;
+	case BCLK_EMMC:
+		if (rate >= 198 * MHz)
+			src_clk = BCLK_EMMC_SEL_200M;
+		else if (rate >= 99 * MHz)
+			src_clk = BCLK_EMMC_SEL_100M;
+		else if (rate >= 50 * MHz)
+			src_clk = BCLK_EMMC_SEL_50M;
+		else
+			src_clk = BCLK_EMMC_SEL_OSC;
+		break;
+	case DCLK_DECOM:
+		if (!(priv->spll_hz % rate)) {
+			src_clk = DCLK_DECOM_SEL_SPLL;
+			div = DIV_ROUND_UP(priv->spll_hz, rate);
+		} else {
+			src_clk = DCLK_DECOM_SEL_GPLL;
+			div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		}
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	switch (clk_id) {
+	case CCLK_SRC_SDIO:
+	case HCLK_SDIO:
+		rk_clrsetreg(&cru->clksel_con[104],
+			     CCLK_SDIO_SRC_SEL_MASK |
+			     CCLK_SDIO_SRC_DIV_MASK,
+			     (src_clk << CCLK_SDIO_SRC_SEL_SHIFT) |
+			     (div - 1) << CCLK_SDIO_SRC_DIV_SHIFT);
+		break;
+	case CCLK_SRC_SDMMC0:
+	case HCLK_SDMMC0:
+		rk_clrsetreg(&cru->clksel_con[105],
+			     CCLK_SDMMC0_SRC_SEL_MASK |
+			     CCLK_SDMMC0_SRC_DIV_MASK,
+			     (src_clk << CCLK_SDMMC0_SRC_SEL_SHIFT) |
+			     (div - 1) << CCLK_SDMMC0_SRC_DIV_SHIFT);
+		break;
+	case CCLK_SRC_EMMC:
+	case HCLK_EMMC:
+		rk_clrsetreg(&cru->clksel_con[89],
+			     CCLK_EMMC_DIV_MASK |
+			     CCLK_EMMC_SEL_MASK,
+			     (src_clk << CCLK_EMMC_SEL_SHIFT) |
+			     (div - 1) << CCLK_EMMC_DIV_SHIFT);
+		break;
+	case SCLK_FSPI_X2:
+		rk_clrsetreg(&cru->clksel_con[89],
+			     SCLK_FSPI_DIV_MASK |
+			     SCLK_FSPI_SEL_MASK,
+			     (src_clk << SCLK_FSPI_SEL_SHIFT) |
+			     (div - 1) << SCLK_FSPI_DIV_SHIFT);
+		break;
+	case SCLK_FSPI1_X2:
+		rk_clrsetreg(&cru->clksel_con[106],
+			     SCLK_FSPI_DIV_MASK |
+			     SCLK_FSPI_SEL_MASK,
+			     (src_clk << SCLK_FSPI_SEL_SHIFT) |
+			     (div - 1) << SCLK_FSPI_DIV_SHIFT);
+		break;
+	case BCLK_EMMC:
+		rk_clrsetreg(&cru->clksel_con[90],
+			     BCLK_EMMC_SEL_MASK,
+			     src_clk << BCLK_EMMC_SEL_SHIFT);
+		break;
+	case DCLK_DECOM:
+		rk_clrsetreg(&cru->clksel_con[72],
+			     DCLK_DECOM_DIV_MASK |
+			     DCLK_DECOM_SEL_MASK,
+			     (src_clk << DCLK_DECOM_SEL_SHIFT) |
+			     (div - 1) << DCLK_DECOM_DIV_SHIFT);
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	return rk3576_mmc_get_clk(priv, clk_id);
+}
+
+#ifndef CONFIG_SPL_BUILD
+
+static ulong rk3576_aclk_vop_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 div, sel, con, parent = 0;
+
+	switch (clk_id) {
+	case ACLK_VOP_ROOT:
+	case ACLK_VOP:
+		con = readl(&cru->clksel_con[144]);
+		div = (con & ACLK_VOP_ROOT_DIV_MASK) >> ACLK_VOP_ROOT_DIV_SHIFT;
+		sel = (con & ACLK_VOP_ROOT_SEL_MASK) >> ACLK_VOP_ROOT_SEL_SHIFT;
+		if (sel == ACLK_VOP_ROOT_SEL_GPLL)
+			parent = priv->gpll_hz;
+		else if (sel == ACLK_VOP_ROOT_SEL_CPLL)
+			parent = priv->cpll_hz;
+		else if (sel == ACLK_VOP_ROOT_SEL_AUPLL)
+			parent = priv->aupll_hz;
+		else if (sel == ACLK_VOP_ROOT_SEL_SPLL)
+			parent = priv->spll_hz;
+		else if (sel == ACLK_VOP_ROOT_SEL_LPLL)
+			parent = priv->lpll_hz / 2;
+		return DIV_TO_RATE(parent, div);
+	case ACLK_VO0_ROOT:
+		con = readl(&cru->clksel_con[149]);
+		div = (con & ACLK_VO0_ROOT_DIV_MASK) >> ACLK_VO0_ROOT_DIV_SHIFT;
+		sel = (con & ACLK_VO0_ROOT_SEL_MASK) >> ACLK_VO0_ROOT_SEL_SHIFT;
+		if (sel == ACLK_VO0_ROOT_SEL_GPLL)
+			parent = priv->gpll_hz;
+		else if (sel == ACLK_VO0_ROOT_SEL_CPLL)
+			parent = priv->cpll_hz;
+		else if (sel == ACLK_VO0_ROOT_SEL_LPLL)
+			parent = priv->lpll_hz / 2;
+		else if (sel == ACLK_VO0_ROOT_SEL_BPLL)
+			parent = priv->bpll_hz / 4;
+		return DIV_TO_RATE(parent, div);
+	case ACLK_VO1_ROOT:
+		con = readl(&cru->clksel_con[158]);
+		div = (con & ACLK_VO0_ROOT_DIV_MASK) >> ACLK_VO0_ROOT_DIV_SHIFT;
+		sel = (con & ACLK_VO0_ROOT_SEL_MASK) >> ACLK_VO0_ROOT_SEL_SHIFT;
+		if (sel == ACLK_VO0_ROOT_SEL_GPLL)
+			parent = priv->gpll_hz;
+		else if (sel == ACLK_VO0_ROOT_SEL_CPLL)
+			parent = priv->cpll_hz;
+		else if (sel == ACLK_VO0_ROOT_SEL_LPLL)
+			parent = priv->lpll_hz / 2;
+		else if (sel == ACLK_VO0_ROOT_SEL_BPLL)
+			parent = priv->bpll_hz / 4;
+		return DIV_TO_RATE(parent, div);
+	case HCLK_VOP_ROOT:
+		con = readl(&cru->clksel_con[144]);
+		sel = (con & HCLK_VOP_ROOT_SEL_MASK) >> HCLK_VOP_ROOT_SEL_SHIFT;
+		if (sel == HCLK_VOP_ROOT_SEL_200M)
+			return 200 * MHz;
+		else if (sel == HCLK_VOP_ROOT_SEL_100M)
+			return 100 * MHz;
+		else if (sel == HCLK_VOP_ROOT_SEL_50M)
+			return 50 * MHz;
+		else
+			return OSC_HZ;
+	case PCLK_VOP_ROOT:
+		con = readl(&cru->clksel_con[144]);
+		sel = (con & PCLK_VOP_ROOT_SEL_MASK) >> PCLK_VOP_ROOT_SEL_SHIFT;
+		if (sel == PCLK_VOP_ROOT_SEL_100M)
+			return 100 * MHz;
+		else if (sel == PCLK_VOP_ROOT_SEL_50M)
+			return 50 * MHz;
+		else
+			return OSC_HZ;
+
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rk3576_aclk_vop_set_clk(struct rk3576_clk_priv *priv,
+				     ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	int src_clk, div;
+
+	switch (clk_id) {
+	case ACLK_VOP_ROOT:
+	case ACLK_VOP:
+		if (rate == 700 * MHz) {
+			src_clk = ACLK_VOP_ROOT_SEL_SPLL;
+			div = 1;
+		} else if (!(priv->cpll_hz % rate)) {
+			src_clk = ACLK_VOP_ROOT_SEL_CPLL;
+			div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		} else {
+			src_clk = ACLK_VOP_ROOT_SEL_GPLL;
+			div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		}
+		rk_clrsetreg(&cru->clksel_con[144],
+			     ACLK_VOP_ROOT_DIV_MASK |
+			     ACLK_VOP_ROOT_SEL_MASK,
+			     (src_clk << ACLK_VOP_ROOT_SEL_SHIFT) |
+			     (div - 1) << ACLK_VOP_ROOT_DIV_SHIFT);
+		break;
+	case ACLK_VO0_ROOT:
+		if (!(priv->cpll_hz % rate)) {
+			src_clk = ACLK_VO0_ROOT_SEL_CPLL;
+			div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		} else {
+			src_clk = ACLK_VO0_ROOT_SEL_GPLL;
+			div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		}
+		rk_clrsetreg(&cru->clksel_con[149],
+			     ACLK_VO0_ROOT_DIV_MASK |
+			     ACLK_VO0_ROOT_SEL_MASK,
+			     (src_clk << ACLK_VO0_ROOT_SEL_SHIFT) |
+			     (div - 1) << ACLK_VO0_ROOT_DIV_SHIFT);
+		break;
+	case ACLK_VO1_ROOT:
+		if (!(priv->cpll_hz % rate)) {
+			src_clk = ACLK_VO0_ROOT_SEL_CPLL;
+			div = DIV_ROUND_UP(priv->cpll_hz, rate);
+		} else {
+			src_clk = ACLK_VO0_ROOT_SEL_GPLL;
+			div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		}
+		rk_clrsetreg(&cru->clksel_con[158],
+			     ACLK_VO0_ROOT_DIV_MASK |
+			     ACLK_VO0_ROOT_SEL_MASK,
+			     (src_clk << ACLK_VO0_ROOT_SEL_SHIFT) |
+			     (div - 1) << ACLK_VO0_ROOT_DIV_SHIFT);
+		break;
+	case HCLK_VOP_ROOT:
+		if (rate == 200 * MHz)
+			src_clk = HCLK_VOP_ROOT_SEL_200M;
+		else if (rate == 100 * MHz)
+			src_clk = HCLK_VOP_ROOT_SEL_100M;
+		else if (rate == 50 * MHz)
+			src_clk = HCLK_VOP_ROOT_SEL_50M;
+		else
+			src_clk = HCLK_VOP_ROOT_SEL_OSC;
+		rk_clrsetreg(&cru->clksel_con[144],
+			     HCLK_VOP_ROOT_SEL_MASK,
+			     src_clk << HCLK_VOP_ROOT_SEL_SHIFT);
+		break;
+	case PCLK_VOP_ROOT:
+		if (rate == 100 * MHz)
+			src_clk = PCLK_VOP_ROOT_SEL_100M;
+		else if (rate == 50 * MHz)
+			src_clk = PCLK_VOP_ROOT_SEL_50M;
+		else
+			src_clk = PCLK_VOP_ROOT_SEL_OSC;
+		rk_clrsetreg(&cru->clksel_con[144],
+			     PCLK_VOP_ROOT_SEL_MASK,
+			     src_clk << PCLK_VOP_ROOT_SEL_SHIFT);
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	return rk3576_aclk_vop_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_dclk_vop_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 div, sel, con, parent;
+
+	switch (clk_id) {
+	case DCLK_VP0:
+	case DCLK_VP0_SRC:
+		con = readl(&cru->clksel_con[145]);
+		div = (con & DCLK0_VOP_SRC_DIV_MASK) >> DCLK0_VOP_SRC_DIV_SHIFT;
+		sel = (con & DCLK0_VOP_SRC_SEL_MASK) >> DCLK0_VOP_SRC_SEL_SHIFT;
+		break;
+	case DCLK_VP1:
+	case DCLK_VP1_SRC:
+		con = readl(&cru->clksel_con[146]);
+		div = (con & DCLK0_VOP_SRC_DIV_MASK) >> DCLK0_VOP_SRC_DIV_SHIFT;
+		sel = (con & DCLK0_VOP_SRC_SEL_MASK) >> DCLK0_VOP_SRC_SEL_SHIFT;
+		break;
+	case DCLK_VP2:
+	case DCLK_VP2_SRC:
+		con = readl(&cru->clksel_con[147]);
+		div = (con & DCLK0_VOP_SRC_DIV_MASK) >> DCLK0_VOP_SRC_DIV_SHIFT;
+		sel = (con & DCLK0_VOP_SRC_SEL_MASK) >> DCLK0_VOP_SRC_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (sel == DCLK_VOP_SRC_SEL_VPLL)
+		parent = priv->vpll_hz;
+	else if (sel == DCLK_VOP_SRC_SEL_BPLL)
+		parent = priv->bpll_hz / 4;
+	else if (sel == DCLK_VOP_SRC_SEL_LPLL)
+		parent = priv->lpll_hz / 2;
+	else if (sel == DCLK_VOP_SRC_SEL_GPLL)
+		parent = priv->gpll_hz;
+	else
+		parent = priv->cpll_hz;
+
+	return DIV_TO_RATE(parent, div);
+}
+
+#define RK3576_VOP_PLL_LIMIT_FREQ 600000000
+
+static ulong rk3576_dclk_vop_set_clk(struct rk3576_clk_priv *priv,
+				     ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	ulong pll_rate, now, best_rate = 0;
+	u32 i, conid, con, sel, div, best_div = 0, best_sel = 0;
+	u32 mask, div_shift, sel_shift;
+
+	switch (clk_id) {
+	case DCLK_VP0:
+	case DCLK_VP0_SRC:
+		conid = 145;
+		con = readl(&cru->clksel_con[conid]);
+		sel = (con & DCLK0_VOP_SRC_SEL_MASK) >> DCLK0_VOP_SRC_SEL_SHIFT;
+		mask = DCLK0_VOP_SRC_SEL_MASK | DCLK0_VOP_SRC_DIV_MASK;
+		div_shift = DCLK0_VOP_SRC_DIV_SHIFT;
+		sel_shift = DCLK0_VOP_SRC_SEL_SHIFT;
+		break;
+	case DCLK_VP1:
+	case DCLK_VP1_SRC:
+		conid = 146;
+		con = readl(&cru->clksel_con[conid]);
+		sel = (con & DCLK0_VOP_SRC_SEL_MASK) >> DCLK0_VOP_SRC_SEL_SHIFT;
+		mask = DCLK0_VOP_SRC_SEL_MASK | DCLK0_VOP_SRC_DIV_MASK;
+		div_shift = DCLK0_VOP_SRC_DIV_SHIFT;
+		sel_shift = DCLK0_VOP_SRC_SEL_SHIFT;
+		break;
+	case DCLK_VP2:
+	case DCLK_VP2_SRC:
+		conid = 147;
+		con = readl(&cru->clksel_con[conid]);
+		sel = (con & DCLK0_VOP_SRC_SEL_MASK) >> DCLK0_VOP_SRC_SEL_SHIFT;
+		mask = DCLK0_VOP_SRC_SEL_MASK | DCLK0_VOP_SRC_DIV_MASK;
+		div_shift = DCLK0_VOP_SRC_DIV_SHIFT;
+		sel_shift = DCLK0_VOP_SRC_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (sel == DCLK_VOP_SRC_SEL_VPLL) {
+		pll_rate = rockchip_pll_get_rate(&rk3576_pll_clks[VPLL],
+						 priv->cru, VPLL);
+		if (pll_rate >= RK3576_VOP_PLL_LIMIT_FREQ && pll_rate % rate == 0) {
+			div = DIV_ROUND_UP(pll_rate, rate);
+			rk_clrsetreg(&cru->clksel_con[conid],
+				     mask,
+				     DCLK_VOP_SRC_SEL_VPLL << sel_shift |
+				     ((div - 1) << div_shift));
+		} else {
+			div = DIV_ROUND_UP(RK3576_VOP_PLL_LIMIT_FREQ, rate);
+			if (div % 2)
+				div = div + 1;
+			rk_clrsetreg(&cru->clksel_con[conid],
+				     mask,
+				     DCLK_VOP_SRC_SEL_VPLL << sel_shift |
+				     ((div - 1) << div_shift));
+			rockchip_pll_set_rate(&rk3576_pll_clks[VPLL],
+					      priv->cru, VPLL, div * rate);
+			priv->vpll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[VPLL],
+							      priv->cru, VPLL);
+		}
+	} else {
+		for (i = 0; i <= DCLK_VOP_SRC_SEL_LPLL; i++) {
+			switch (i) {
+			case DCLK_VOP_SRC_SEL_GPLL:
+				pll_rate = priv->gpll_hz;
+				break;
+			case DCLK_VOP_SRC_SEL_CPLL:
+				pll_rate = priv->cpll_hz;
+				break;
+			case DCLK_VOP_SRC_SEL_BPLL:
+				pll_rate = 0;
+				break;
+			case DCLK_VOP_SRC_SEL_LPLL:
+				pll_rate = 0;
+				break;
+			case DCLK_VOP_SRC_SEL_VPLL:
+				pll_rate = 0;
+				break;
+			default:
+				printf("do not support this vop pll sel\n");
+				return -EINVAL;
+			}
+
+			div = DIV_ROUND_UP(pll_rate, rate);
+			if (div > 255)
+				continue;
+			now = pll_rate / div;
+			if (abs(rate - now) < abs(rate - best_rate)) {
+				best_rate = now;
+				best_div = div;
+				best_sel = i;
+			}
+			debug("p_rate=%lu, best_rate=%lu, div=%u, sel=%u\n",
+			      pll_rate, best_rate, best_div, best_sel);
+		}
+
+		if (best_rate) {
+			rk_clrsetreg(&cru->clksel_con[conid],
+				     mask,
+				     best_sel << sel_shift |
+				     (best_div - 1) << div_shift);
+		} else {
+			printf("do not support this vop freq %lu\n", rate);
+			return -EINVAL;
+		}
+	}
+
+	return rk3576_dclk_vop_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_clk_csihost_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 div, sel, con, parent;
+
+	switch (clk_id) {
+	case CLK_DSIHOST0:
+		con = readl(&cru->clksel_con[151]);
+		div = (con & CLK_DSIHOST0_DIV_MASK) >> CLK_DSIHOST0_DIV_SHIFT;
+		sel = (con & CLK_DSIHOST0_SEL_MASK) >> CLK_DSIHOST0_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (sel == CLK_DSIHOST0_SEL_VPLL)
+		parent = priv->vpll_hz;
+	else if (sel == CLK_DSIHOST0_SEL_BPLL)
+		parent = priv->bpll_hz / 4;
+	else if (sel == CLK_DSIHOST0_SEL_LPLL)
+		parent = priv->lpll_hz / 2;
+	else if (sel == CLK_DSIHOST0_SEL_GPLL)
+		parent = priv->gpll_hz;
+	else if (sel == CLK_DSIHOST0_SEL_SPLL)
+		parent = priv->spll_hz;
+	else
+		parent = priv->cpll_hz;
+
+	return DIV_TO_RATE(parent, div);
+}
+
+static ulong rk3576_clk_csihost_set_clk(struct rk3576_clk_priv *priv,
+					ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	ulong pll_rate, now, best_rate = 0;
+	u32 i, con, div, best_div = 0, best_sel = 0;
+	u32 mask, div_shift, sel_shift;
+
+	switch (clk_id) {
+	case CLK_DSIHOST0:
+		con = 151;
+		mask = CLK_DSIHOST0_SEL_MASK | CLK_DSIHOST0_DIV_MASK;
+		div_shift = CLK_DSIHOST0_DIV_SHIFT;
+		sel_shift = CLK_DSIHOST0_SEL_SHIFT;
+		break;
+	default:
+		return -ENOENT;
+	}
+	for (i = 0; i <= CLK_DSIHOST0_SEL_LPLL; i++) {
+		switch (i) {
+		case CLK_DSIHOST0_SEL_GPLL:
+			pll_rate = priv->gpll_hz;
+			break;
+		case CLK_DSIHOST0_SEL_CPLL:
+			pll_rate = priv->cpll_hz;
+			break;
+		case CLK_DSIHOST0_SEL_BPLL:
+			pll_rate = 0;
+			break;
+		case CLK_DSIHOST0_SEL_LPLL:
+			pll_rate = 0;
+			break;
+		case CLK_DSIHOST0_SEL_VPLL:
+			pll_rate = 0;
+			break;
+		case CLK_DSIHOST0_SEL_SPLL:
+			pll_rate = priv->spll_hz;
+			break;
+		default:
+			printf("do not support this vop pll sel\n");
+			return -EINVAL;
+		}
+
+		div = DIV_ROUND_UP(pll_rate, rate);
+		if (div > 255)
+			continue;
+		now = pll_rate / div;
+		if (abs(rate - now) < abs(rate - best_rate)) {
+			best_rate = now;
+			best_div = div;
+			best_sel = i;
+		}
+		debug("p_rate=%lu, best_rate=%lu, div=%u, sel=%u\n",
+		      pll_rate, best_rate, best_div, best_sel);
+	}
+
+	if (best_rate) {
+		rk_clrsetreg(&cru->clksel_con[con],
+			     mask,
+			     best_sel << sel_shift |
+			     (best_div - 1) << div_shift);
+	} else {
+		printf("do not support this vop freq %lu\n", rate);
+		return -EINVAL;
+	}
+
+	return rk3576_clk_csihost_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_dclk_ebc_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 div, sel, con, parent;
+	unsigned long m = 0, n = 0;
+
+	switch (clk_id) {
+	case DCLK_EBC:
+		con = readl(&cru->clksel_con[123]);
+		div = (con & DCLK_EBC_DIV_MASK) >> DCLK_EBC_DIV_SHIFT;
+		sel = (con & DCLK_EBC_SEL_MASK) >> DCLK_EBC_SEL_SHIFT;
+		if (sel == DCLK_EBC_SEL_CPLL)
+			parent = priv->cpll_hz;
+		else if (sel == DCLK_EBC_SEL_VPLL)
+			parent = priv->vpll_hz;
+		else if (sel == DCLK_EBC_SEL_AUPLL)
+			parent = priv->aupll_hz;
+		else if (sel == DCLK_EBC_SEL_LPLL)
+			parent = priv->lpll_hz / 2;
+		else if (sel == DCLK_EBC_SEL_GPLL)
+			parent = priv->gpll_hz;
+		else if (sel == DCLK_EBC_SEL_FRAC_SRC)
+			parent = rk3576_dclk_ebc_get_clk(priv, DCLK_EBC_FRAC_SRC);
+		else
+			parent = OSC_HZ;
+		return DIV_TO_RATE(parent, div);
+	case DCLK_EBC_FRAC_SRC:
+		con = readl(&cru->clksel_con[123]);
+		div = readl(&cru->clksel_con[122]);
+		sel = (con & DCLK_EBC_FRAC_SRC_SEL_MASK) >> DCLK_EBC_FRAC_SRC_SEL_SHIFT;
+		if (sel == DCLK_EBC_FRAC_SRC_SEL_GPLL)
+			parent = priv->gpll_hz;
+		else if (sel == DCLK_EBC_FRAC_SRC_SEL_CPLL)
+			parent = priv->cpll_hz;
+		else if (sel == DCLK_EBC_FRAC_SRC_SEL_VPLL)
+			parent = priv->vpll_hz;
+		else if (sel == DCLK_EBC_FRAC_SRC_SEL_AUPLL)
+			parent = priv->aupll_hz;
+		else
+			parent = OSC_HZ;
+
+		n = div & CLK_UART_FRAC_NUMERATOR_MASK;
+		n >>= CLK_UART_FRAC_NUMERATOR_SHIFT;
+		m = div & CLK_UART_FRAC_DENOMINATOR_MASK;
+		m >>= CLK_UART_FRAC_DENOMINATOR_SHIFT;
+		return parent * n / m;
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rk3576_dclk_ebc_set_clk(struct rk3576_clk_priv *priv,
+				     ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	ulong pll_rate, now, best_rate = 0;
+	u32 i, con, sel, div, best_div = 0, best_sel = 0;
+	unsigned long m = 0, n = 0, val;
+
+	switch (clk_id) {
+	case DCLK_EBC:
+		con = readl(&cru->clksel_con[123]);
+		sel = (con & DCLK_EBC_SEL_MASK) >> DCLK_EBC_SEL_SHIFT;
+		if (sel == DCLK_EBC_SEL_VPLL) {
+			pll_rate = rockchip_pll_get_rate(&rk3576_pll_clks[VPLL],
+							 priv->cru, VPLL);
+			if (pll_rate >= RK3576_VOP_PLL_LIMIT_FREQ &&
+			    pll_rate % rate == 0) {
+				div = DIV_ROUND_UP(pll_rate, rate);
+				rk_clrsetreg(&cru->clksel_con[123],
+					     DCLK_EBC_DIV_MASK,
+					     (div - 1) << DCLK_EBC_DIV_SHIFT);
+			} else {
+				div = DIV_ROUND_UP(RK3576_VOP_PLL_LIMIT_FREQ,
+						   rate);
+				if (div % 2)
+					div = div + 1;
+				rk_clrsetreg(&cru->clksel_con[123],
+					     DCLK_EBC_DIV_MASK,
+					     (div - 1) << DCLK_EBC_DIV_SHIFT);
+				rockchip_pll_set_rate(&rk3576_pll_clks[VPLL],
+						      priv->cru,
+						      VPLL, div * rate);
+				priv->vpll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[VPLL],
+								      priv->cru,
+								      VPLL);
+			}
+		} else if (sel == DCLK_EBC_SEL_FRAC_SRC) {
+			rk3576_dclk_ebc_set_clk(priv, DCLK_EBC_FRAC_SRC, rate);
+			div = rk3576_dclk_ebc_get_clk(priv, DCLK_EBC_FRAC_SRC) / rate;
+			rk_clrsetreg(&cru->clksel_con[123],
+				     DCLK_EBC_DIV_MASK,
+				     (div - 1) << DCLK_EBC_DIV_SHIFT);
+		} else {
+			for (i = 0; i <= DCLK_EBC_SEL_LPLL; i++) {
+				switch (i) {
+				case DCLK_EBC_SEL_GPLL:
+					pll_rate = priv->gpll_hz;
+					break;
+				case DCLK_EBC_SEL_CPLL:
+					pll_rate = priv->cpll_hz;
+					break;
+				case DCLK_EBC_SEL_VPLL:
+					pll_rate = 0;
+					break;
+				case DCLK_EBC_SEL_AUPLL:
+					pll_rate = priv->aupll_hz;
+					break;
+				case DCLK_EBC_SEL_LPLL:
+					pll_rate = 0;
+					break;
+				default:
+					printf("not support ebc pll sel\n");
+					return -EINVAL;
+				}
+
+				div = DIV_ROUND_UP(pll_rate, rate);
+				if (div > 255)
+					continue;
+				now = pll_rate / div;
+				if (abs(rate - now) < abs(rate - best_rate)) {
+					best_rate = now;
+					best_div = div;
+					best_sel = i;
+				}
+			}
+
+			if (best_rate) {
+				rk_clrsetreg(&cru->clksel_con[123],
+					     DCLK_EBC_DIV_MASK |
+					     DCLK_EBC_SEL_MASK,
+					     best_sel <<
+					     DCLK_EBC_SEL_SHIFT |
+					     (best_div - 1) <<
+					     DCLK_EBC_DIV_SHIFT);
+			} else {
+				printf("do not support this vop freq %lu\n",
+				       rate);
+				return -EINVAL;
+			}
+		}
+		break;
+	case DCLK_EBC_FRAC_SRC:
+		sel = DCLK_EBC_FRAC_SRC_SEL_GPLL;
+		div = 1;
+		rational_best_approximation(rate, priv->gpll_hz,
+					    GENMASK(16 - 1, 0),
+					    GENMASK(16 - 1, 0),
+					    &m, &n);
+
+		if (m < 4 && m != 0) {
+			if (n % 2 == 0)
+				val = 1;
+			else
+				val = DIV_ROUND_UP(4, m);
+
+			n *= val;
+			m *= val;
+			if (n > 0xffff)
+				n = 0xffff;
+		}
+
+		rk_clrsetreg(&cru->clksel_con[123],
+			     DCLK_EBC_FRAC_SRC_SEL_MASK,
+			     (sel << DCLK_EBC_FRAC_SRC_SEL_SHIFT));
+		if (m && n) {
+			val = m << CLK_UART_FRAC_NUMERATOR_SHIFT | n;
+			writel(val, &cru->clksel_con[122]);
+		}
+		break;
+	default:
+		return -ENOENT;
+	}
+	return rk3576_dclk_ebc_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_gmac_get_clk(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 con, div, src, p_rate;
+
+	switch (clk_id) {
+	case CLK_GMAC0_PTP_REF_SRC:
+	case CLK_GMAC0_PTP_REF:
+		con = readl(&cru->clksel_con[105]);
+		div = (con & CLK_GMAC0_PTP_DIV_MASK) >> CLK_GMAC0_PTP_DIV_SHIFT;
+		src = (con & CLK_GMAC0_PTP_SEL_MASK) >> CLK_GMAC0_PTP_SEL_SHIFT;
+		if (src == CLK_GMAC0_PTP_SEL_GPLL)
+			p_rate = priv->gpll_hz;
+		else if (src == CLK_GMAC0_PTP_SEL_CPLL)
+			p_rate = priv->cpll_hz;
+		else
+			p_rate = GMAC0_PTP_REFCLK_IN;
+		return DIV_TO_RATE(p_rate, div);
+	case CLK_GMAC1_PTP_REF_SRC:
+	case CLK_GMAC1_PTP_REF:
+		con = readl(&cru->clksel_con[104]);
+		div = (con & CLK_GMAC1_PTP_DIV_MASK) >> CLK_GMAC0_PTP_DIV_SHIFT;
+		src = (con & CLK_GMAC1_PTP_SEL_MASK) >> CLK_GMAC1_PTP_SEL_SHIFT;
+		if (src == CLK_GMAC1_PTP_SEL_GPLL)
+			p_rate = priv->gpll_hz;
+		else if (src == CLK_GMAC1_PTP_SEL_CPLL)
+			p_rate = priv->cpll_hz;
+		else
+			p_rate = GMAC1_PTP_REFCLK_IN;
+		return DIV_TO_RATE(p_rate, div);
+	case CLK_GMAC0_125M_SRC:
+		con = readl(&cru->clksel_con[30]);
+		div = (con & CLK_GMAC0_125M_DIV_MASK) >> CLK_GMAC0_125M_DIV_SHIFT;
+		return DIV_TO_RATE(priv->cpll_hz, div);
+	case CLK_GMAC1_125M_SRC:
+		con = readl(&cru->clksel_con[31]);
+		div = (con & CLK_GMAC1_125M_DIV_MASK) >> CLK_GMAC1_125M_DIV_SHIFT;
+		return DIV_TO_RATE(priv->cpll_hz, div);
+	default:
+		return -ENOENT;
+	}
+}
+
+static ulong rk3576_gmac_set_clk(struct rk3576_clk_priv *priv,
+				 ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	int div, src;
+
+	div = DIV_ROUND_UP(priv->cpll_hz, rate);
+
+	switch (clk_id) {
+	case CLK_GMAC0_PTP_REF_SRC:
+	case CLK_GMAC0_PTP_REF:
+		if (rate == GMAC0_PTP_REFCLK_IN) {
+			src = CLK_GMAC0_PTP_SEL_REFIN;
+			div = 1;
+		} else if (!(priv->gpll_hz % rate)) {
+			src = CLK_GMAC0_PTP_SEL_GPLL;
+			div = priv->gpll_hz / rate;
+		} else {
+			src = CLK_GMAC0_PTP_SEL_CPLL;
+			div = priv->cpll_hz / rate;
+		}
+		rk_clrsetreg(&cru->clksel_con[105],
+			     CLK_GMAC0_PTP_DIV_MASK | CLK_GMAC0_PTP_SEL_MASK,
+			     src << CLK_GMAC0_PTP_SEL_SHIFT |
+			     (div - 1) << CLK_GMAC0_PTP_DIV_SHIFT);
+		break;
+	case CLK_GMAC1_PTP_REF_SRC:
+	case CLK_GMAC1_PTP_REF:
+		if (rate == GMAC1_PTP_REFCLK_IN) {
+			src = CLK_GMAC1_PTP_SEL_REFIN;
+			div = 1;
+		} else if (!(priv->gpll_hz % rate)) {
+			src = CLK_GMAC1_PTP_SEL_GPLL;
+			div = priv->gpll_hz / rate;
+		} else {
+			src = CLK_GMAC1_PTP_SEL_CPLL;
+			div = priv->cpll_hz / rate;
+		}
+		rk_clrsetreg(&cru->clksel_con[104],
+			     CLK_GMAC1_PTP_DIV_MASK | CLK_GMAC1_PTP_SEL_MASK,
+			     src << CLK_GMAC1_PTP_SEL_SHIFT |
+			     (div - 1) << CLK_GMAC1_PTP_DIV_SHIFT);
+		break;
+
+	case CLK_GMAC0_125M_SRC:
+		rk_clrsetreg(&cru->clksel_con[30],
+			     CLK_GMAC0_125M_DIV_MASK,
+			     (div - 1) << CLK_GMAC0_125M_DIV_SHIFT);
+		break;
+	case CLK_GMAC1_125M_SRC:
+		rk_clrsetreg(&cru->clksel_con[31],
+			     CLK_GMAC1_125M_DIV_MASK,
+			     (div - 1) << CLK_GMAC1_125M_DIV_SHIFT);
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return rk3576_gmac_get_clk(priv, clk_id);
+}
+
+static ulong rk3576_uart_frac_get_rate(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 reg, con, fracdiv, p_src, p_rate;
+	unsigned long m, n;
+
+	switch (clk_id) {
+	case CLK_UART_FRAC_0:
+		reg = 21;
+		break;
+	case CLK_UART_FRAC_1:
+		reg = 23;
+		break;
+	case CLK_UART_FRAC_2:
+		reg = 25;
+		break;
+	default:
+		return -ENOENT;
+	}
+	con = readl(&cru->clksel_con[reg + 1]);
+	p_src = (con & CLK_UART_SRC_SEL_MASK) >> CLK_UART_SRC_SEL_SHIFT;
+	if (p_src == CLK_UART_SRC_SEL_GPLL)
+		p_rate = priv->gpll_hz;
+	else if (p_src == CLK_UART_SRC_SEL_CPLL)
+		p_rate = priv->cpll_hz;
+	else if (p_src == CLK_UART_SRC_SEL_AUPLL)
+		p_rate = priv->aupll_hz;
+	else
+		p_rate = OSC_HZ;
+
+	fracdiv = readl(&cru->clksel_con[reg]);
+	n = fracdiv & CLK_UART_FRAC_NUMERATOR_MASK;
+	n >>= CLK_UART_FRAC_NUMERATOR_SHIFT;
+	m = fracdiv & CLK_UART_FRAC_DENOMINATOR_MASK;
+	m >>= CLK_UART_FRAC_DENOMINATOR_SHIFT;
+	return p_rate * n / m;
+}
+
+static ulong rk3576_uart_frac_set_rate(struct rk3576_clk_priv *priv,
+				       ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 reg, clk_src, p_rate;
+	unsigned long m = 0, n = 0, val;
+
+	if (priv->cpll_hz % rate == 0) {
+		clk_src = CLK_UART_SRC_SEL_CPLL;
+		p_rate = priv->cpll_hz;
+	} else if (rate == OSC_HZ) {
+		clk_src = CLK_UART_SRC_SEL_OSC;
+		p_rate = OSC_HZ;
+	} else {
+		clk_src = CLK_UART_SRC_SEL_GPLL;
+		p_rate = priv->cpll_hz;
+	}
+
+	rational_best_approximation(rate, p_rate, GENMASK(16 - 1, 0),
+				    GENMASK(16 - 1, 0), &m, &n);
+
+	if (m < 4 && m != 0) {
+		if (n % 2 == 0)
+			val = 1;
+		else
+			val = DIV_ROUND_UP(4, m);
+
+		n *= val;
+		m *= val;
+		if (n > 0xffff)
+			n = 0xffff;
+	}
+
+	switch (clk_id) {
+	case CLK_UART_FRAC_0:
+		reg = 21;
+		break;
+	case CLK_UART_FRAC_1:
+		reg = 23;
+		break;
+	case CLK_UART_FRAC_2:
+		reg = 25;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	rk_clrsetreg(&cru->clksel_con[reg + 1],
+		     CLK_UART_SRC_SEL_MASK,
+		     (clk_src << CLK_UART_SRC_SEL_SHIFT));
+	if (m && n) {
+		val = m << CLK_UART_FRAC_NUMERATOR_SHIFT | n;
+		writel(val, &cru->clksel_con[reg]);
+	}
+
+	return rk3576_uart_frac_get_rate(priv, clk_id);
+}
+
+static ulong rk3576_uart_get_rate(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 con, div, src, p_rate;
+
+	switch (clk_id) {
+	case SCLK_UART0:
+		con = readl(&cru->clksel_con[60]);
+		break;
+	case SCLK_UART1:
+		con = readl(&cru->pmuclksel_con[8]);
+		src = (con & CLK_UART1_SEL_MASK) >> CLK_UART1_SEL_SHIFT;
+		if (src == CLK_UART1_SEL_OSC)
+			return OSC_HZ;
+		con = readl(&cru->clksel_con[27]);
+		break;
+	case SCLK_UART2:
+		con = readl(&cru->clksel_con[61]);
+		break;
+	case SCLK_UART3:
+		con = readl(&cru->clksel_con[62]);
+		break;
+	case SCLK_UART4:
+		con = readl(&cru->clksel_con[63]);
+		break;
+	case SCLK_UART5:
+		con = readl(&cru->clksel_con[64]);
+		break;
+	case SCLK_UART6:
+		con = readl(&cru->clksel_con[65]);
+		break;
+	case SCLK_UART7:
+		con = readl(&cru->clksel_con[66]);
+		break;
+	case SCLK_UART8:
+		con = readl(&cru->clksel_con[67]);
+		break;
+	case SCLK_UART9:
+		con = readl(&cru->clksel_con[68]);
+		break;
+	case SCLK_UART10:
+		con = readl(&cru->clksel_con[69]);
+		break;
+	case SCLK_UART11:
+		con = readl(&cru->clksel_con[70]);
+		break;
+	default:
+		return -ENOENT;
+	}
+	if (clk_id == SCLK_UART1) {
+		src = (con & CLK_UART1_SRC_SEL_SHIFT) >> CLK_UART1_SRC_SEL_SHIFT;
+		div = (con & CLK_UART1_SRC_DIV_MASK) >> CLK_UART1_SRC_DIV_SHIFT;
+	} else {
+		src = (con & CLK_UART_SEL_MASK) >> CLK_UART_SEL_SHIFT;
+		div = (con & CLK_UART_DIV_MASK) >> CLK_UART_DIV_SHIFT;
+	}
+	if (src == CLK_UART_SEL_GPLL)
+		p_rate = priv->gpll_hz;
+	else  if (src == CLK_UART_SEL_CPLL)
+		p_rate = priv->cpll_hz;
+	else  if (src == CLK_UART_SEL_AUPLL)
+		p_rate = priv->aupll_hz;
+	else  if (src == CLK_UART_SEL_FRAC0)
+		p_rate = rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_0);
+	else  if (src == CLK_UART_SEL_FRAC1)
+		p_rate = rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_1);
+	else  if (src == CLK_UART_SEL_FRAC2)
+		p_rate = rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_2);
+	else
+		p_rate = OSC_HZ;
+
+	return DIV_TO_RATE(p_rate, div);
+}
+
+static ulong rk3576_uart_set_rate(struct rk3576_clk_priv *priv,
+				  ulong clk_id, ulong rate)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 reg, clk_src = 0, div = 0;
+
+	if (!(priv->gpll_hz % rate)) {
+		clk_src = CLK_UART_SEL_GPLL;
+		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+	} else if (!(priv->cpll_hz % rate)) {
+		clk_src = CLK_UART_SEL_CPLL;
+		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+	} else if (!(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_0) % rate)) {
+		clk_src = CLK_UART_SEL_FRAC0;
+		div = DIV_ROUND_UP(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_0), rate);
+	} else if (!(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_1) % rate)) {
+		clk_src = CLK_UART_SEL_FRAC1;
+		div = DIV_ROUND_UP(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_1), rate);
+	} else if (!(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_2) % rate)) {
+		clk_src = CLK_UART_SEL_FRAC2;
+		div = DIV_ROUND_UP(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_2), rate);
+	} else if (!(OSC_HZ % rate)) {
+		clk_src = CLK_UART_SEL_OSC;
+		div = DIV_ROUND_UP(OSC_HZ, rate);
+	}
+
+	switch (clk_id) {
+	case SCLK_UART0:
+		reg = 60;
+		break;
+	case SCLK_UART1:
+		if (rate == OSC_HZ) {
+			rk_clrsetreg(&cru->pmuclksel_con[8],
+				     CLK_UART1_SEL_MASK,
+				     CLK_UART1_SEL_OSC << CLK_UART1_SEL_SHIFT);
+			return 0;
+		}
+
+		rk_clrsetreg(&cru->clksel_con[27],
+			     CLK_UART1_SRC_SEL_MASK | CLK_UART1_SRC_DIV_MASK,
+			     (clk_src << CLK_UART1_SRC_SEL_SHIFT) |
+			     ((div - 1) << CLK_UART1_SRC_DIV_SHIFT));
+		rk_clrsetreg(&cru->pmuclksel_con[8],
+			     CLK_UART1_SEL_MASK,
+			     CLK_UART1_SEL_TOP << CLK_UART1_SEL_SHIFT);
+		return 0;
+	case SCLK_UART2:
+		reg = 61;
+		break;
+	case SCLK_UART3:
+		reg = 62;
+		break;
+	case SCLK_UART4:
+		reg = 63;
+		break;
+	case SCLK_UART5:
+		reg = 64;
+		break;
+	case SCLK_UART6:
+		reg = 65;
+		break;
+	case SCLK_UART7:
+		reg = 66;
+		break;
+	case SCLK_UART8:
+		reg = 67;
+		break;
+	case SCLK_UART9:
+		reg = 68;
+		break;
+	case SCLK_UART10:
+		reg = 69;
+		break;
+	case SCLK_UART11:
+		reg = 70;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	rk_clrsetreg(&cru->clksel_con[reg],
+		     CLK_UART_SEL_MASK |
+		     CLK_UART_DIV_MASK,
+		     (clk_src << CLK_UART_SEL_SHIFT) |
+		     ((div - 1) << CLK_UART_DIV_SHIFT));
+
+	return rk3576_uart_get_rate(priv, clk_id);
+}
+#endif
+
+static ulong rk3576_ufs_ref_get_rate(struct rk3576_clk_priv *priv, ulong clk_id)
+{
+	struct rk3576_cru *cru = priv->cru;
+	u32 src, div;
+
+	src = readl(&cru->pmuclksel_con[3]) & 0x3;
+	div = readl(&cru->pmuclksel_con[1]) & 0xff;
+	if (src == 0)
+		return OSC_HZ;
+	else if (src == 2)
+		return priv->ppll_hz / (div + 1);
+	else
+		return 26000000;
+}
+
+static ulong rk3576_clk_get_rate(struct clk *clk)
+{
+	struct rk3576_clk_priv *priv = dev_get_priv(clk->dev);
+	ulong rate = 0;
+
+	if (!priv->gpll_hz) {
+		printf("%s gpll=%lu\n", __func__, priv->gpll_hz);
+		return -ENOENT;
+	}
+
+	if (!priv->ppll_hz) {
+		priv->ppll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[PPLL],
+						      priv->cru, PPLL);
+	}
+
+	switch (clk->id) {
+	case PLL_LPLL:
+		rate = rockchip_pll_get_rate(&rk3576_pll_clks[LPLL], priv->cru,
+					     LPLL);
+		priv->lpll_hz = rate;
+		break;
+	case PLL_BPLL:
+		rate = rockchip_pll_get_rate(&rk3576_pll_clks[BPLL], priv->cru,
+					     BPLL);
+		priv->bpll_hz = rate;
+		break;
+	case PLL_GPLL:
+		rate = rockchip_pll_get_rate(&rk3576_pll_clks[GPLL], priv->cru,
+					     GPLL);
+		break;
+	case PLL_CPLL:
+		rate = rockchip_pll_get_rate(&rk3576_pll_clks[CPLL], priv->cru,
+					     CPLL);
+		break;
+	case PLL_VPLL:
+		rate = rockchip_pll_get_rate(&rk3576_pll_clks[VPLL], priv->cru,
+					     VPLL);
+		break;
+	case PLL_AUPLL:
+		rate = rockchip_pll_get_rate(&rk3576_pll_clks[AUPLL], priv->cru,
+					     AUPLL);
+		break;
+	case PLL_PPLL:
+		rate = rockchip_pll_get_rate(&rk3576_pll_clks[PPLL], priv->cru,
+					     PPLL) * 2;
+		break;
+	case ACLK_BUS_ROOT:
+	case HCLK_BUS_ROOT:
+	case PCLK_BUS_ROOT:
+		rate = rk3576_bus_get_clk(priv, clk->id);
+		break;
+	case ACLK_TOP:
+	case HCLK_TOP:
+	case PCLK_TOP_ROOT:
+	case ACLK_TOP_MID:
+		rate = rk3576_top_get_clk(priv, clk->id);
+		break;
+	case CLK_I2C0:
+	case CLK_I2C1:
+	case CLK_I2C2:
+	case CLK_I2C3:
+	case CLK_I2C4:
+	case CLK_I2C5:
+	case CLK_I2C6:
+	case CLK_I2C7:
+	case CLK_I2C8:
+	case CLK_I2C9:
+		rate = rk3576_i2c_get_clk(priv, clk->id);
+		break;
+	case CLK_SPI0:
+	case CLK_SPI1:
+	case CLK_SPI2:
+	case CLK_SPI3:
+	case CLK_SPI4:
+		rate = rk3576_spi_get_clk(priv, clk->id);
+		break;
+	case CLK_PWM1:
+	case CLK_PWM2:
+	case CLK_PMU1PWM:
+		rate = rk3576_pwm_get_clk(priv, clk->id);
+		break;
+	case CLK_SARADC:
+	case CLK_TSADC:
+		rate = rk3576_adc_get_clk(priv, clk->id);
+		break;
+	case CCLK_SRC_SDIO:
+	case CCLK_SRC_SDMMC0:
+	case CCLK_SRC_EMMC:
+	case BCLK_EMMC:
+	case SCLK_FSPI_X2:
+	case SCLK_FSPI1_X2:
+	case DCLK_DECOM:
+	case HCLK_SDMMC0:
+	case HCLK_EMMC:
+	case HCLK_SDIO:
+		rate = rk3576_mmc_get_clk(priv, clk->id);
+		break;
+	case TCLK_EMMC:
+	case TCLK_WDT0:
+		rate = OSC_HZ;
+		break;
+#ifndef CONFIG_SPL_BUILD
+	case ACLK_VOP_ROOT:
+	case ACLK_VOP:
+	case ACLK_VO0_ROOT:
+	case ACLK_VO1_ROOT:
+	case HCLK_VOP_ROOT:
+	case PCLK_VOP_ROOT:
+		rate = rk3576_aclk_vop_get_clk(priv, clk->id);
+		break;
+	case DCLK_VP0:
+	case DCLK_VP0_SRC:
+	case DCLK_VP1:
+	case DCLK_VP1_SRC:
+	case DCLK_VP2:
+	case DCLK_VP2_SRC:
+		rate = rk3576_dclk_vop_get_clk(priv, clk->id);
+		break;
+	case CLK_GMAC0_PTP_REF_SRC:
+	case CLK_GMAC1_PTP_REF_SRC:
+	case CLK_GMAC0_PTP_REF:
+	case CLK_GMAC1_PTP_REF:
+	case CLK_GMAC0_125M_SRC:
+	case CLK_GMAC1_125M_SRC:
+		rate = rk3576_gmac_get_clk(priv, clk->id);
+		break;
+	case CLK_UART_FRAC_0:
+	case CLK_UART_FRAC_1:
+	case CLK_UART_FRAC_2:
+		rate = rk3576_uart_frac_get_rate(priv, clk->id);
+		break;
+	case SCLK_UART0:
+	case SCLK_UART1:
+	case SCLK_UART2:
+	case SCLK_UART3:
+	case SCLK_UART4:
+	case SCLK_UART5:
+	case SCLK_UART6:
+	case SCLK_UART7:
+	case SCLK_UART8:
+	case SCLK_UART9:
+	case SCLK_UART10:
+	case SCLK_UART11:
+		rate = rk3576_uart_get_rate(priv, clk->id);
+		break;
+	case CLK_DSIHOST0:
+		rate = rk3576_clk_csihost_get_clk(priv, clk->id);
+		break;
+	case DCLK_EBC:
+	case DCLK_EBC_FRAC_SRC:
+		rate = rk3576_dclk_ebc_get_clk(priv, clk->id);
+		break;
+#endif
+	case CLK_REF_UFS_CLKOUT:
+	case CLK_REF_OSC_MPHY:
+		rate = rk3576_ufs_ref_get_rate(priv, clk->id);
+		break;
+
+	default:
+		return -ENOENT;
+	}
+
+	return rate;
+};
+
+static ulong rk3576_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct rk3576_clk_priv *priv = dev_get_priv(clk->dev);
+	ulong ret = 0;
+
+	if (!priv->ppll_hz) {
+		priv->ppll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[PPLL],
+						      priv->cru, PPLL);
+	}
+	if (!priv->aupll_hz) {
+		priv->aupll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[AUPLL],
+						       priv->cru, AUPLL);
+	}
+
+	switch (clk->id) {
+	case PLL_CPLL:
+		ret = rockchip_pll_set_rate(&rk3576_pll_clks[CPLL], priv->cru,
+					    CPLL, rate);
+		priv->cpll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[CPLL],
+						      priv->cru, CPLL);
+		break;
+	case PLL_GPLL:
+		ret = rockchip_pll_set_rate(&rk3576_pll_clks[GPLL], priv->cru,
+					    GPLL, rate);
+		priv->gpll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[GPLL],
+						      priv->cru, GPLL);
+		break;
+	case PLL_VPLL:
+		ret = rockchip_pll_set_rate(&rk3576_pll_clks[VPLL], priv->cru,
+					    VPLL, rate);
+		priv->vpll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[VPLL],
+						      priv->cru, VPLL);
+		break;
+	case PLL_AUPLL:
+		ret = rockchip_pll_set_rate(&rk3576_pll_clks[AUPLL], priv->cru,
+					    AUPLL, rate);
+		priv->aupll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[AUPLL],
+						       priv->cru, AUPLL);
+		break;
+	case PLL_PPLL:
+		ret = rockchip_pll_set_rate(&rk3576_pll_clks[PPLL], priv->cru,
+					    PPLL, rate);
+		priv->ppll_hz = rockchip_pll_get_rate(&rk3576_pll_clks[PPLL],
+						      priv->cru, PPLL) * 2;
+		break;
+	case ACLK_BUS_ROOT:
+	case HCLK_BUS_ROOT:
+	case PCLK_BUS_ROOT:
+		ret = rk3576_bus_set_clk(priv, clk->id, rate);
+		break;
+	case ACLK_TOP:
+	case HCLK_TOP:
+	case PCLK_TOP_ROOT:
+	case ACLK_TOP_MID:
+		ret = rk3576_top_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_I2C0:
+	case CLK_I2C1:
+	case CLK_I2C2:
+	case CLK_I2C3:
+	case CLK_I2C4:
+	case CLK_I2C5:
+	case CLK_I2C6:
+	case CLK_I2C7:
+	case CLK_I2C8:
+	case CLK_I2C9:
+		ret = rk3576_i2c_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_SPI0:
+	case CLK_SPI1:
+	case CLK_SPI2:
+	case CLK_SPI3:
+	case CLK_SPI4:
+		ret = rk3576_spi_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_PWM1:
+	case CLK_PWM2:
+	case CLK_PMU1PWM:
+		ret = rk3576_pwm_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_SARADC:
+	case CLK_TSADC:
+		ret = rk3576_adc_set_clk(priv, clk->id, rate);
+		break;
+	case CCLK_SRC_SDIO:
+	case CCLK_SRC_SDMMC0:
+	case CCLK_SRC_EMMC:
+	case BCLK_EMMC:
+	case SCLK_FSPI_X2:
+	case SCLK_FSPI1_X2:
+	case DCLK_DECOM:
+	case HCLK_SDMMC0:
+	case HCLK_EMMC:
+	case HCLK_SDIO:
+		ret = rk3576_mmc_set_clk(priv, clk->id, rate);
+		break;
+	case TCLK_EMMC:
+	case TCLK_WDT0:
+		ret = OSC_HZ;
+		break;
+
+	/* Might occur in cru assigned-clocks, can be ignored here */
+	case CLK_AUDIO_FRAC_0:
+	case CLK_AUDIO_FRAC_1:
+	case CLK_AUDIO_FRAC_0_SRC:
+	case CLK_AUDIO_FRAC_1_SRC:
+	case CLK_CPLL_DIV2:
+	case CLK_CPLL_DIV4:
+	case CLK_CPLL_DIV10:
+	case FCLK_DDR_CM0_CORE:
+	case ACLK_PHP_ROOT:
+		ret = 0;
+		break;
+#ifndef CONFIG_SPL_BUILD
+	case ACLK_VOP_ROOT:
+	case ACLK_VOP:
+	case ACLK_VO0_ROOT:
+	case ACLK_VO1_ROOT:
+	case HCLK_VOP_ROOT:
+	case PCLK_VOP_ROOT:
+		ret = rk3576_aclk_vop_set_clk(priv, clk->id, rate);
+		break;
+	case DCLK_VP0:
+	case DCLK_VP0_SRC:
+	case DCLK_VP1:
+	case DCLK_VP1_SRC:
+	case DCLK_VP2:
+	case DCLK_VP2_SRC:
+		ret = rk3576_dclk_vop_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_GMAC0_PTP_REF_SRC:
+	case CLK_GMAC1_PTP_REF_SRC:
+	case CLK_GMAC0_PTP_REF:
+	case CLK_GMAC1_PTP_REF:
+	case CLK_GMAC0_125M_SRC:
+	case CLK_GMAC1_125M_SRC:
+		ret = rk3576_gmac_set_clk(priv, clk->id, rate);
+		break;
+	case CLK_UART_FRAC_0:
+	case CLK_UART_FRAC_1:
+	case CLK_UART_FRAC_2:
+		ret = rk3576_uart_frac_set_rate(priv, clk->id, rate);
+		break;
+	case SCLK_UART0:
+	case SCLK_UART1:
+	case SCLK_UART2:
+	case SCLK_UART3:
+	case SCLK_UART4:
+	case SCLK_UART5:
+	case SCLK_UART6:
+	case SCLK_UART7:
+	case SCLK_UART8:
+	case SCLK_UART9:
+	case SCLK_UART10:
+	case SCLK_UART11:
+		ret = rk3576_uart_set_rate(priv, clk->id, rate);
+		break;
+	case CLK_DSIHOST0:
+		ret = rk3576_clk_csihost_set_clk(priv, clk->id, rate);
+		break;
+	case DCLK_EBC:
+	case DCLK_EBC_FRAC_SRC:
+		ret = rk3576_dclk_ebc_set_clk(priv, clk->id, rate);
+		break;
+#endif
+	default:
+		return -ENOENT;
+	}
+
+	return ret;
+};
+
+#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
+static int __maybe_unused rk3576_dclk_vop_set_parent(struct clk *clk,
+						     struct clk *parent)
+{
+	struct rk3576_clk_priv *priv = dev_get_priv(clk->dev);
+	struct rk3576_cru *cru = priv->cru;
+	u32 sel;
+	const char *clock_dev_name = parent->dev->name;
+
+	if (parent->id == PLL_VPLL)
+		sel = 2;
+	else if (parent->id == PLL_GPLL)
+		sel = 0;
+	else if (parent->id == PLL_CPLL)
+		sel = 1;
+	else if (parent->id == PLL_BPLL)
+		sel = 3;
+	else
+		sel = 4;
+
+	switch (clk->id) {
+	case DCLK_VP0_SRC:
+		rk_clrsetreg(&cru->clksel_con[145], DCLK0_VOP_SRC_SEL_MASK,
+			     sel << DCLK0_VOP_SRC_SEL_SHIFT);
+		break;
+	case DCLK_VP1_SRC:
+		rk_clrsetreg(&cru->clksel_con[146], DCLK0_VOP_SRC_SEL_MASK,
+			     sel << DCLK0_VOP_SRC_SEL_SHIFT);
+		break;
+	case DCLK_VP2_SRC:
+		rk_clrsetreg(&cru->clksel_con[147], DCLK0_VOP_SRC_SEL_MASK,
+			     sel << DCLK0_VOP_SRC_SEL_SHIFT);
+		break;
+	case DCLK_VP0:
+		if (!strcmp(clock_dev_name, "hdmiphypll_clk0"))
+			sel = 1;
+		else
+			sel = 0;
+		rk_clrsetreg(&cru->clksel_con[147], DCLK0_VOP_SEL_MASK,
+			     sel << DCLK0_VOP_SEL_SHIFT);
+		break;
+	case DCLK_VP1:
+		if (!strcmp(clock_dev_name, "hdmiphypll_clk0"))
+			sel = 1;
+		else
+			sel = 0;
+		rk_clrsetreg(&cru->clksel_con[147], DCLK1_VOP_SEL_MASK,
+			     sel << DCLK1_VOP_SEL_SHIFT);
+		break;
+	case DCLK_VP2:
+		if (!strcmp(clock_dev_name, "hdmiphypll_clk0"))
+			sel = 1;
+		else
+			sel = 0;
+		rk_clrsetreg(&cru->clksel_con[147], DCLK2_VOP_SEL_MASK,
+			     sel << DCLK2_VOP_SEL_SHIFT);
+		break;
+	case DCLK_EBC:
+		if (parent->id == PLL_GPLL)
+			sel = 0;
+		else if (parent->id == PLL_CPLL)
+			sel = 1;
+		else if (parent->id == PLL_VPLL)
+			sel = 2;
+		else if (parent->id == PLL_AUPLL)
+			sel = 3;
+		else if (parent->id == PLL_LPLL)
+			sel = 4;
+		else if (parent->id == DCLK_EBC_FRAC_SRC)
+			sel = 5;
+		else
+			sel = 6;
+		rk_clrsetreg(&cru->clksel_con[123], DCLK_EBC_SEL_MASK,
+			     sel << DCLK_EBC_SEL_SHIFT);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int __maybe_unused rk3576_ufs_ref_set_parent(struct clk *clk,
+						    struct clk *parent)
+{
+	struct rk3576_clk_priv *priv = dev_get_priv(clk->dev);
+	struct rk3576_cru *cru = priv->cru;
+	u32 sel;
+	const char *clock_dev_name = parent->dev->name;
+
+	if (parent->id == CLK_REF_MPHY_26M)
+		sel = 2;
+	else if (!strcmp(clock_dev_name, "xin24m"))
+		sel = 0;
+	else
+		sel = 1;
+
+	rk_clrsetreg(&cru->pmuclksel_con[3], 0x3, sel << 0);
+	return 0;
+}
+
+static int rk3576_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	switch (clk->id) {
+	case DCLK_VP0_SRC:
+	case DCLK_VP1_SRC:
+	case DCLK_VP2_SRC:
+	case DCLK_VP0:
+	case DCLK_VP1:
+	case DCLK_VP2:
+	case DCLK_EBC:
+		return rk3576_dclk_vop_set_parent(clk, parent);
+	case CLK_REF_OSC_MPHY:
+		return rk3576_ufs_ref_set_parent(clk, parent);
+	case CLK_AUDIO_FRAC_0_SRC:
+	case CLK_AUDIO_FRAC_1_SRC:
+		/* Might occur in cru assigned-clocks, can be ignored here */
+		return 0;
+	default:
+		return -ENOENT;
+	}
+
+	return 0;
+}
+#endif
+
+static struct clk_ops rk3576_clk_ops = {
+	.get_rate = rk3576_clk_get_rate,
+	.set_rate = rk3576_clk_set_rate,
+#if (IS_ENABLED(OF_CONTROL)) || (!IS_ENABLED(OF_PLATDATA))
+	.set_parent = rk3576_clk_set_parent,
+#endif
+};
+
+static void rk3576_clk_init(struct rk3576_clk_priv *priv)
+{
+	int ret;
+
+	priv->spll_hz = 702000000;
+
+	if (priv->cpll_hz != CPLL_HZ) {
+		ret = rockchip_pll_set_rate(&rk3576_pll_clks[CPLL], priv->cru,
+					    CPLL, CPLL_HZ);
+		if (!ret)
+			priv->cpll_hz = CPLL_HZ;
+	}
+	if (priv->gpll_hz != GPLL_HZ) {
+		ret = rockchip_pll_set_rate(&rk3576_pll_clks[GPLL], priv->cru,
+					    GPLL, GPLL_HZ);
+		if (!ret)
+			priv->gpll_hz = GPLL_HZ;
+	}
+	rk_clrsetreg(&priv->cru->clksel_con[123],
+		     DCLK_EBC_FRAC_SRC_SEL_MASK,
+		     (DCLK_EBC_FRAC_SRC_SEL_GPLL <<
+		      DCLK_EBC_FRAC_SRC_SEL_SHIFT));
+}
+
+static int rk3576_clk_probe(struct udevice *dev)
+{
+	struct rk3576_clk_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->sync_kernel = false;
+
+#ifdef CONFIG_SPL_BUILD
+	/* relase presetn_bigcore_biu/cru/grf */
+	writel(0x1c001c00, 0x26010010);
+	/* set spll to normal mode */
+	writel(BITS_WITH_WMASK(2, 0x7U, 6),
+	       RK3576_SCRU_BASE + RK3576_PLL_CON(137));
+	writel(BITS_WITH_WMASK(1, 0x3U, 0),
+	       RK3576_SCRU_BASE + RK3576_MODE_CON0);
+	/* fix ppll\aupll\cpll */
+	writel(BITS_WITH_WMASK(2, 0x7U, 6),
+	       RK3576_CRU_BASE + RK3576_PMU_PLL_CON(129));
+	writel(BITS_WITH_WMASK(2, 0x7U, 6),
+	       RK3576_CRU_BASE + RK3576_PLL_CON(97));
+	writel(BITS_WITH_WMASK(2, 0x7U, 6),
+	       RK3576_CRU_BASE + RK3576_PLL_CON(105));
+	writel(BITS_WITH_WMASK(1, 0x3U, 6),
+	       RK3576_CRU_BASE + RK3576_MODE_CON0);
+	writel(BITS_WITH_WMASK(1, 0x3U, 8),
+	       RK3576_CRU_BASE + RK3576_MODE_CON0);
+	/* init cci */
+	writel(0xffff0000, RK3576_CRU_BASE + RK3576_CCI_CLKSEL_CON(4));
+	rockchip_pll_set_rate(&rk3576_pll_clks[BPLL], priv->cru,
+			      BPLL, LPLL_HZ);
+	if (!priv->armclk_enter_hz) {
+		ret = rockchip_pll_set_rate(&rk3576_pll_clks[LPLL], priv->cru,
+					    LPLL, LPLL_HZ);
+		priv->armclk_enter_hz =
+			rockchip_pll_get_rate(&rk3576_pll_clks[LPLL],
+					      priv->cru, LPLL);
+		priv->armclk_init_hz = priv->armclk_enter_hz;
+		rk_clrsetreg(&priv->cru->litclksel_con[0], CLK_LITCORE_DIV_MASK,
+			     0 << CLK_LITCORE_DIV_SHIFT);
+	}
+	/* init cci */
+	writel(0xffff20cb, RK3576_CRU_BASE + RK3576_CCI_CLKSEL_CON(4));
+
+	/* Change bigcore rm from 4 to 3 */
+	writel(0x001c000c, RK3576_BIGCORE_GRF_BASE + 0x3c);
+	writel(0x001c000c, RK3576_BIGCORE_GRF_BASE + 0x44);
+	writel(0x00020002, RK3576_BIGCORE_GRF_BASE + 0x38);
+	udelay(1);
+	writel(0x00020000, RK3576_BIGCORE_GRF_BASE + 0x38);
+	/* Change litcore rm from 4 to 3 */
+	writel(0x001c000c, RK3576_LITCORE_GRF_BASE + 0x3c);
+	writel(0x001c000c, RK3576_LITCORE_GRF_BASE + 0x44);
+	writel(0x00020002, RK3576_LITCORE_GRF_BASE + 0x38);
+	udelay(1);
+	writel(0x00020000, RK3576_LITCORE_GRF_BASE + 0x38);
+	/* Change cci rm form 4 to 3 */
+	writel(0x001c000c, RK3576_CCI_GRF_BASE + 0x54);
+#endif
+
+	rk3576_clk_init(priv);
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
+static int rk3576_clk_ofdata_to_platdata(struct udevice *dev)
+{
+	struct rk3576_clk_priv *priv = dev_get_priv(dev);
+
+	priv->cru = dev_read_addr_ptr(dev);
+
+	return 0;
+}
+
+static int rk3576_clk_bind(struct udevice *dev)
+{
+	int ret;
+	struct udevice *sys_child;
+	struct sysreset_reg *priv;
+
+	/* The reset driver does not have a device node, so bind it here */
+	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
+				 &sys_child);
+	if (ret) {
+		debug("Warning: No sysreset driver: ret=%d\n", ret);
+	} else {
+		priv = malloc(sizeof(struct sysreset_reg));
+		priv->glb_srst_fst_value = offsetof(struct rk3576_cru,
+						    glb_srst_fst);
+		priv->glb_srst_snd_value = offsetof(struct rk3576_cru,
+						    glb_srsr_snd);
+		dev_set_priv(sys_child, priv);
+	}
+
+#if CONFIG_IS_ENABLED(RESET_ROCKCHIP)
+	ret = offsetof(struct rk3576_cru, softrst_con[0]);
+	ret = rk3576_reset_bind_lut(dev, ret, 32776);
+	if (ret)
+		debug("Warning: software reset driver bind failed\n");
+#endif
+
+	return 0;
+}
+
+static const struct udevice_id rk3576_clk_ids[] = {
+	{ .compatible = "rockchip,rk3576-cru" },
+	{ }
+};
+
+U_BOOT_DRIVER(rockchip_rk3576_cru) = {
+	.name		= "rockchip_rk3576_cru",
+	.id		= UCLASS_CLK,
+	.of_match	= rk3576_clk_ids,
+	.priv_auto	= sizeof(struct rk3576_clk_priv),
+	.of_to_plat	= rk3576_clk_ofdata_to_platdata,
+	.ops		= &rk3576_clk_ops,
+	.bind		= rk3576_clk_bind,
+	.probe		= rk3576_clk_probe,
+};
-- 
2.47.2

