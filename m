Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E314DCD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 04:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB7984C5B;
	Fri,  8 May 2026 06:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD8CD84BBD; Fri,  8 May 2026 02:29:43 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B44984B39
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 02:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 8 May
 2026 08:29:35 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 8 May 2026 08:29:35 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 8 May 2026 08:29:30 +0800
Subject: [PATCH] clk: ast2700: add clock driver support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260508-ast2700_clk-v1-1-2797a626a238@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAGku/WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNz3cTiEiNzA4P45JxsXSNTi9TE5CTLFHMDYyWgjoKi1LTMCrBp0bG
 1tQDiJNLZXQAAAA==
X-Change-ID: 20260327-ast2700_clk-258eacb9d703
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Chia-Wei
 Wang" <chiawei_wang@aspeedtech.com>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778200175; l=44553;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=wd6b9zsI7cr0J1VqIglfpQdiABtvCGiYdN2TKxnVYgk=;
 b=tpw0qPVmkJo7H+t9F+CcY3oqYSTy6cqbUQGzUwa/n14wAiP4fKBHnwHyP9i9i98+R7uCO+XMD
 i4eVYMDjVwbCswhQLFYb4HT5Wod8ze9BpuYyJnkMfUB7Akz0doNVG9S
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Fri, 08 May 2026 06:08:20 +0200
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

Add clock controller driver for the dual-die AST2700 SoC. The chip
has two SCUs (SoC0/CPU at 0x12c02000, SoC1/IO at 0x14c02000), each
with its own PLLs (HPLL/APLL/DPLL/MPLL), clock dividers and clock
gate controls. This commit registers two UCLASS_CLK drivers
matching "aspeed,ast2700-scu0" and "aspeed,ast2700-scu1".

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
AST2700 is the 8th generation of Integrated Remote Management Processor
introduced by ASPEED Technology Inc. Which is Board Management controller
(BMC) SoC family. AST2700 have two SoC connected, one is SoC0, another
is SoC1, it has it's own scu, this driver inlcude SCU0 and SCU1 driver.
---
 arch/arm/include/asm/arch-aspeed/scu_ast2700.h | 514 +++++++++++++
 drivers/clk/aspeed/Makefile                    |   1 +
 drivers/clk/aspeed/clk_ast2700.c               | 952 +++++++++++++++++++++++++
 3 files changed, 1467 insertions(+)

diff --git a/arch/arm/include/asm/arch-aspeed/scu_ast2700.h b/arch/arm/include/asm/arch-aspeed/scu_ast2700.h
new file mode 100644
index 00000000000..b973fcc6610
--- /dev/null
+++ b/arch/arm/include/asm/arch-aspeed/scu_ast2700.h
@@ -0,0 +1,514 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) Aspeed Technology Inc.
+ */
+#ifndef _ASM_ARCH_SCU_AST2700_H
+#define _ASM_ARCH_SCU_AST2700_H
+
+#include <linux/types.h>
+
+/* SoC0 SCU Register */
+#define SCU_CPU_REVISION_ID_HW			GENMASK(23, 16)
+#define SCU_CPU_REVISION_ID_EFUSE		GENMASK(15, 8)
+
+#define SCU_CPU_HWSTRAP_DIS_RVAS		BIT(30)
+#define SCU_CPU_HWSTRAP_DP_SRC			BIT(29)
+#define SCU_CPU_HWSTRAP_DAC_SRC			BIT(28)
+#define SCU_CPU_HWSTRAP_VRAM_SIZE		GENMASK(11, 10)
+#define SCU_CPU_HWSTRAP_DIS_CPU			BIT(0)
+
+#define SCU_CPU_MISC_DP_RESET_SRC		BIT(11)
+#define SCU_CPU_MISC_XDMA_CLIENT_EN		BIT(4)
+#define SCU_CPU_MISC_2D_CLIENT_EN		BIT(3)
+
+#define SCU_CPU_RST_SSP				BIT(30)
+#define SCU_CPU_RST_DPMCU			BIT(29)
+#define SCU_CPU_RST_DP				BIT(28)
+#define SCU_CPU_RST_XDMA1			BIT(26)
+#define SCU_CPU_RST_XDMA0			BIT(25)
+#define SCU_CPU_RST_EMMC			BIT(17)
+#define SCU_CPU_RST_EN_DP_PCI			BIT(15)
+#define SCU_CPU_RST_CRT				BIT(13)
+#define SCU_CPU_RST_RVAS1			BIT(10)
+#define SCU_CPU_RST_RVAS0			BIT(9)
+#define SCU_CPU_RST_2D				BIT(7)
+#define SCU_CPU_RST_VIDEO			BIT(6)
+#define SCU_CPU_RST_SOC				BIT(5)
+#define SCU_CPU_RST_DDRPHY			BIT(1)
+
+#define SCU_CPU_RST2_VGA			BIT(12)
+#define SCU_CPU_RST2_E2M1			BIT(11)
+#define SCU_CPU_RST2_E2M0			BIT(10)
+#define SCU_CPU_RST2_TSP			BIT(9)
+
+#define SCU_CPU_VGA_FUNC_DAC_OUTPUT		GENMASK(11, 10)
+#define SCU_CPU_VGA_FUNC_DP_OUTPUT		GENMASK(9, 8)
+#define SCU_CPU_VGA_FUNC_DAC_DISABLE		BIT(7)
+
+#define SCU_CPU_PCI_MISC0C_FB_SIZE		GENMASK(4, 0)
+
+#define SCU_CPU_PCI_MISC70_EN_XHCI		BIT(3)
+#define SCU_CPU_PCI_MISC70_EN_EHCI		BIT(2)
+#define SCU_CPU_PCI_MISC70_EN_IPMI		BIT(1)
+#define SCU_CPU_PCI_MISC70_EN_VGA		BIT(0)
+
+#define SCU_CPU_HPLL_P				GENMASK(22, 19)
+#define SCU_CPU_HPLL_N				GENMASK(18, 13)
+#define SCU_CPU_HPLL_M				GENMASK(12, 0)
+
+#define SCU_CPU_HPLL2_LOCK			BIT(31)
+#define SCU_CPU_HPLL2_BWADJ			GENMASK(11, 0)
+
+#define SCU_CPU_SSP_TSP_RESET_STS		BIT(8)
+#define SCU_CPU_SSP_TSP_SRAM_SD			BIT(7)
+#define SCU_CPU_SSP_TSP_SRAM_DSLP		BIT(6)
+#define SCU_CPU_SSP_TSP_SRAM_SLP		BIT(5)
+#define SCU_CPU_SSP_TSP_NIDEN			BIT(4)
+#define SCU_CPU_SSP_TSP_DBGEN			BIT(3)
+#define SCU_CPU_SSP_TSP_DBG_ENABLE		BIT(2)
+#define SCU_CPU_SSP_TSP_RESET			BIT(1)
+#define SCU_CPU_SSP_TSP_ENABLE			BIT(0)
+
+/* SoC1 SCU Register */
+#define SCU_IO_HWSTRAP_UFS			BIT(23)
+#define SCU_IO_HWSTRAP_EMMC			BIT(11)
+#define SCU_IO_HWSTRAP_SECBOOT			BIT(5)
+#define SCU_IO_HWSTRAP_LTPI0_EN			BIT(3)
+#define SCU_IO_HWSTRAP_LTPI1_EN			BIT(1)
+
+/* CLK information */
+#define CLKIN_25M 25000000UL
+
+#define SCU_CPU_CLKGATE1_RVAS1			BIT(28)
+#define SCU_CPU_CLKGATE1_RVAS0			BIT(25)
+#define SCU_CPU_CLKGATE1_E2M1			BIT(19)
+#define SCU_CPU_CLKGATE1_DP			BIT(18)
+#define SCU_CPU_CLKGATE1_DAC			BIT(17)
+#define SCU_CPU_CLKGATE1_E2M0			BIT(12)
+#define SCU_CPU_CLKGATE1_VGA1			BIT(10)
+#define SCU_CPU_CLKGATE1_VGA0			BIT(5)
+
+/*
+ * Clock divider/multiplier configuration struct.
+ * For H-PLL and M-PLL the formula is
+ * (Output Frequency) = CLKIN * ((M + 1) / (N + 1)) / (P + 1)
+ * M - Numerator
+ * N - Denumerator
+ * P - Post Divider
+ * They have the same layout in their control register.
+ *
+ */
+union ast2700_pll_reg {
+	u32 w;
+	struct {
+		uint16_t m : 13;		/* bit[12:0]	*/
+		uint8_t n : 6;			/* bit[18:13]	*/
+		uint8_t p : 4;			/* bit[22:19]	*/
+		uint8_t off : 1;		/* bit[23]	*/
+		uint8_t bypass : 1;		/* bit[24]	*/
+		uint8_t reset : 1;		/* bit[25]	*/
+		uint8_t reserved : 6;		/* bit[31:26]	*/
+	} b;
+};
+
+struct ast2700_pll_cfg {
+	union ast2700_pll_reg reg;
+	unsigned int ext_reg;
+};
+
+struct ast2700_pll_desc {
+	u32 in;
+	u32 out;
+	struct ast2700_pll_cfg cfg;
+};
+
+struct aspeed_clks {
+	ulong id;
+	const char *name;
+};
+
+#ifndef __ASSEMBLY__
+struct ast2700_scu0 {
+	u32 chip_id1;		/* 0x000 */
+	u32 rsv_0x04[3];		/* 0x004 ~ 0x00C */
+	u32 hwstrap1;		/* 0x010 */
+	u32 hwstrap1_clr;		/* 0x014 */
+	u32 rsv_0x18[2];		/* 0x018 ~ 0x01C */
+	u32 hwstrap1_lock;		/* 0x020 */
+	u32 hwstrap1_sec1;	/* 0x024 */
+	u32 hwstrap1_sec2;	/* 0x028 */
+	u32 hwstrap1_sec3;	/* 0x02C */
+	u32 rsv_0x30[8];		/* 0x030 ~ 0x4C */
+	u32 sysrest_log1;		/* 0x050 */
+	u32 sysrest_log1_sec1;	/* 0x054 */
+	u32 sysrest_log1_sec2;	/* 0x058 */
+	u32 sysrest_log1_sec3;	/* 0x05C */
+	u32 sysrest_log2;		/* 0x060 */
+	u32 sysrest_log2_sec1;	/* 0x064 */
+	u32 sysrest_log2_sec2;	/* 0x068 */
+	u32 sysrest_log2_sec3;	/* 0x06C */
+	u32 sysrest_log3;		/* 0x070 */
+	u32 sysrest_log3_sec1; /* 0x074 */
+	u32 sysrest_log3_sec2; /* 0x078 */
+	u32 sysrest_log3_sec3; /* 0x07C */
+	u32 rsv_0x80[8];		/* 0x080 ~ 0x9C */
+	u32 probe_sig_select;	/* 0x0A0 */
+	u32 probe_sig_enable1;	/* 0x0A4 */
+	u32 probe_sig_enable2; /* 0x0A8 */
+	u32 uart_dbg_rate;		/* 0x0AC */
+	u32 rsv_0xB0[4];		/* 0x0B0 ~ 0xBC*/
+	u32 misc;			/* 0x0C0 */
+	u32 rsv_0xC4;		/* 0x0C4 */
+	u32 debug_ctrl;		/* 0x0C8 */
+	u32 rsv_0xCC[5];		/* 0x0CC ~ 0x0DC */
+	u32 free_counter_read_low;		/* 0x0E0 */
+	u32 free_counter_read_high;	/* 0x0E4 */
+	u32 rsv_0xE8[2];		/* 0x0E8 ~ 0x0EC */
+	u32 random_num_ctrl;	/* 0x0F0 */
+	u32 random_num_data;	/* 0x0F4 */
+	u32 rsv_0xF8[10];		/* 0x0F8 ~ 0x11C */
+	u32 ssp_ctrl_1;		/* 0x120 */
+	u32 ssp_ctrl_2;		/* 0x124 */
+	u32 ssp_ctrl_3;		/* 0x128 */
+	u32 ssp_ctrl_4;		/* 0x12C */
+	u32 ssp_ctrl_5;		/* 0x130 */
+	u32 ssp_ctrl_6;		/* 0x134 */
+	u32 ssp_ctrl_7;		/* 0x138 */
+	u32 rsv_0x13c[1];		/* 0x13C */
+	u32 ssp_remap0_base;	/* 0x140 */
+	u32 ssp_remap0_size;	/* 0x144 */
+	u32 ssp_remap1_base;	/* 0x148 */
+	u32 ssp_remap1_size;	/* 0x14c */
+	u32 ssp_remap2_base;	/* 0x150 */
+	u32 ssp_remap2_size;	/* 0x154 */
+	u32 rsv_0x158[2];		/* 0x158 ~ 0x15C */
+	u32 tsp_ctrl_1;		/* 0x160 */
+	u32 rsv_0x164[1];		/* 0x164 */
+	u32 tsp_ctrl_3;		/* 0x168 */
+	u32 tsp_ctrl_4;		/* 0x16C */
+	u32 tsp_ctrl_5;		/* 0x170 */
+	u32 tsp_ctrl_6;		/* 0x174 */
+	u32 tsp_ctrl_7;		/* 0x178 */
+	u32 rsv_0x17c[6];		/* 0x17C ~ 0x190 */
+	u32 tsp_remap_size;	/* 0x194 */
+	u32 rsv_0x198[26];		/* 0x198 ~ 0x1FC */
+	u32 modrst1_ctrl;		/* 0x200 */
+	u32 modrst1_clr;		/* 0x204 */
+	u32 rsv_0x208[2];		/* 0x208 ~ 0x20C */
+	u32 modrst1_lock;		/* 0x210 */
+	u32 modrst1_prot1;		/* 0x214 */
+	u32 modrst1_prot2;		/* 0x218 */
+	u32 modrst1_prot3;		/* 0x21C */
+	u32 modrst2_ctrl;		/* 0x220 */
+	u32 modrst2_clr;		/* 0x224 */
+	u32 rsv_0x228[2];		/* 0x228 ~ 0x22C */
+	u32 modrst2_lock;		/* 0x230 */
+	u32 modrst2_prot1;		/* 0x234 */
+	u32 modrst2_prot2;		/* 0x238 */
+	u32 modrst2_prot3;		/* 0x23C */
+	u32 clkgate_ctrl;		/* 0x240 */
+	u32 clkgate_clr;		/* 0x244 */
+	u32 rsv_0x248[2];		/* 0x248 */
+	u32 clkgate_lock;		/* 0x250 */
+	u32 clkgate_secure1;	/* 0x254 */
+	u32 clkgate_secure2;	/* 0x258 */
+	u32 clkgate_secure3;	/* 0x25c */
+	u32 rsv_0x260[8];		/* 0x260 */
+	u32 clk_sel1;		/* 0x280 */
+	u32 clk_sel2;		/* 0x284 */
+	u32 clk_sel3;		/* 0x288 */
+	u32 rsv_0x28c;		/* 0x28c */
+	u32 clk_sel1_lock;		/* 0x290 */
+	u32 clk_sel2_lock;		/* 0x294 */
+	u32 clk_sel3_lock;		/* 0x298 */
+	u32 rsv_0x29c;		/* 0x29c */
+	u32 clk_sel1_secure1;	/* 0x2a0 */
+	u32 clk_sel1_secure2;	/* 0x2a4 */
+	u32 clk_sel1_secure3;	/* 0x2a8 */
+	u32 rsv_0x2ac;		/* 0x2ac */
+	u32 clk_sel2_secure1;	/* 0x2b0 */
+	u32 clk_sel2_secure2;	/* 0x2b4 */
+	u32 clk_sel2_secure3;	/* 0x2b8 */
+	u32 rsv_0x2bc;		/* 0x2bc */
+	u32 clk_sel3_secure1;	/* 0x2c0 */
+	u32 clk_sel3_secure2;	/* 0x2c4 */
+	u32 clk_sel3_secure3;	/* 0x2c8 */
+	u32 rsv_0x2cc[9];		/* 0x2cc */
+	u32 extrst_sel;		/* 0x2f0 */
+	u32 rsv_0x2f4[3];		/* 0x2f4 */
+	u32 hpll;			/* 0x300 */
+	u32 hpll_ext;		/* 0x304 */
+	u32 dpll;			/* 0x308 */
+	u32 dpll_ext;		/* 0x30C */
+	u32 mpll;			/* 0x310 */
+	u32 mpll_ext;		/* 0x314 */
+	u32 rsv_0x318[2];		/* 0x318 ~ 0x31C */
+	u32 d1clk_para;		/* 0x320 */
+	u32 rsv_0x324[3];		/* 0x324 ~ 0x32C */
+	u32 d2clk_para;		/* 0x330 */
+	u32 rsv_0x334[3];		/* 0x334 ~ 0x33C */
+	u32 crt1clk_para;		/* 0x340 */
+	u32 rsv_0x344[3];		/* 0x344 ~ 0x34C */
+	u32 crt2clk_para;		/* 0x350 */
+	u32 rsv_0x354[3];		/* 0x354 ~ 0x35C */
+	u32 mphyclk_para;		/* 0x360 */
+	u32 rsv_0x364[7];		/* 0x364 ~ 0x37C */
+	u32 clkduty_meas_ctrl;	/* 0x380 */
+	u32 clkduty1;		/* 0x384 */
+	u32 clkduty2;		/* 0x368 */
+	u32 clkduty_meas_res;	/* 0x38c */
+	u32 rsv_0x390[4];		/* 0x390 ~ 0x39C */
+	u32 freq_counter_ctrl;	/* 0x3a0 */
+	u32 freq_counter_cmp;	/* 0x3a4 */
+	u32 prog_delay_ring_ctrl0;	/* 0x3a8 */
+	u32 prog_delay_ring_ctrl1;	/* 0x3ac */
+	u32 freq_counter_readback;	/* 0x3b0 */
+	u32 rsv_0x3b4[19];		/* 0x3b4 */
+	u32 pinmux1;		/* 0x400 */
+	u32 pinmux2;		/* 0x404 */
+	u32 pinmux3;		/* 0x408 */
+	u32 rsv_0x40c;		/* 0x40C */
+	u32 pinmux4;		/* 0x410 */
+	u32 vga_func_ctrl;		/* 0x414 */
+	u32 rsv_0x418[2];	/* 0x418 */
+	u32 pinmux_lock0;	/* 0x420 */
+	u32 pinmux_lock1;	/* 0x424 */
+	u32 pinmux_lock2;	/* 0x428 */
+	u32 rsv_0x42c;
+	u32 pinmux_lock3;	/* 0x430 */
+	u32 pinmux_lock4;	/* 0x434 */
+	u32 rsv_0x438[18];
+	u32 gpio18d0_ioctrl;	/* 0x480 */
+	u32 gpio18d1_ioctrl;	/* 0x484 */
+	u32 gpio18d2_ioctrl;	/* 0x488 */
+	u32 gpio18d3_ioctrl;	/* 0x48c */
+	u32 gpio18d4_ioctrl;	/* 0x490 */
+	u32 gpio18d5_ioctrl;	/* 0x494 */
+	u32 gpio18d6_ioctrl;	/* 0x498 */
+	u32 gpio18d7_ioctrl;	/* 0x49c */
+	u32 gpio18e0_ioctrl;	/* 0x4a0 */
+	u32 gpio18e1_ioctrl;	/* 0x4a4 */
+	u32 gpio18e2_ioctrl;	/* 0x4a8 */
+	u32 gpio18e3_ioctrl;	/* 0x4ac */
+	u32 jtag_ioctrl;	/* 0x4b0 */
+	u32 uart_ioctrl;	/* 0x4b4 */
+	u32 misc_ioctrl;	/* 0x4b8 */
+	u32 rsv_0x4bc[17];		/* 0x4bc ~ 0x4fc */
+	u32 pinmux_seucre0_0;	/* 0x500 */
+	u32 pinmux_seucre0_1;	/* 0x504 */
+	u32 pinmux_seucre0_2;	/* 0x508 */
+	u32 rsv_0x50c;
+	u32 pinmux_seucre0_3;	/* 0x510 */
+	u32 pinmux_seucre0_4;	/* 0x514 */
+	u32 rsv_0x518[58];
+	u32 pinmux_seucre1_0;	/* 0x600 */
+	u32 pinmux_seucre1_1;	/* 0x604 */
+	u32 pinmux_seucre1_2;	/* 0x608 */
+	u32 rsv_0x60c;
+	u32 pinmux_seucre1_3;	/* 0x610 */
+	u32 pinmux_seucre1_4;	/* 0x614 */
+	u32 rsv_0x618[58];
+	u32 pinmux_seucre2_0;	/* 0x700 */
+	u32 pinmux_seucre2_1;	/* 0x704 */
+	u32 pinmux_seucre2_2;	/* 0x708 */
+	u32 rsv_0x70c;
+	u32 pinmux_seucre2_3;	/* 0x710 */
+	u32 pinmux_seucre2s_4;	/* 0x714 */
+	u32 rsv_0x718[26];
+	u32 cpu_scratch[96];	/* 0x780 ~ 0x8FC */
+	u32 vga0_scratch1[4];	/* 0x900 ~ 0x90C */
+	u32 vga1_scratch1[4];	/* 0x910 ~ 0x91C */
+	u32 vga0_scratch2[8];	/* 0x920 ~ 0x93C */
+	u32 vga1_scratch2[8];	/* 0x940 ~ 0x95C */
+	u32 pci_cfg1[3];		/* 0x960 ~ 0x968 */
+	u32 rsv_0x96c;		/* 0x96C */
+	u32 pcie_cfg1;		/* 0x970 */
+	u32 mmio_decode1;		/* 0x974 */
+	u32 reloc_ctrl_decode1[2];	/* 0x978 ~ 0x97C */
+	u32 rsv_0x980[4];		/* 0x980 ~ 0x98C */
+	u32 mbox_decode1;		/* 0x990 */
+	u32 shared_sram_decode1[2];/* 0x994 ~ 0x998 */
+	u32 rsv_0x99c;		/* 0x99C */
+	u32 pci_cfg2[3];		/* 0x9A0 ~ 0x9A8 */
+	u32 rsv_0x9ac;		/* 0x9AC */
+	u32 pcie_cfg2;		/* 0x9B0 */
+	u32 mmio_decode2;		/* 0x9B4 */
+	u32 reloc_ctrl_decode2[2];	/* 0x9B8 ~ 0x9BC */
+	u32 rsv_0x9c0[4];		/* 0x9C0 ~ 0x9CC */
+	u32 mbox_decode2;		/* 0x9D0 */
+	u32 shared_sram_decode2[2];/* 0x9D4 ~ 0x9D8 */
+	u32 rsv_0x9dc[9];		/* 0x9DC ~ 0x9FC */
+	u32 pci0_misc[32];		/* 0xA00 ~ 0xA7C */
+	u32 pci1_misc[32];		/* 0xA80 ~ 0xAFC */
+};
+
+struct ast2700_scu1 {
+	u32 chip_id1;		/* 0x000 */
+	u32 rsv_0x04[3];		/* 0x004 ~ 0x00C */
+	u32 hwstrap1;		/* 0x010 */
+	u32 hwstrap1_clr;		/* 0x014 */
+	u32 rsv_0x18[2];		/* 0x018 ~ 0x01C */
+	u32 hwstrap1_lock;		/* 0x020 */
+	u32 hwstrap1_sec1;	/* 0x024 */
+	u32 hwstrap1_sec2;	/* 0x028 */
+	u32 hwstrap1_sec3;	/* 0x02C */
+	u32 hwstrap2;		/* 0x030 */
+	u32 hwstrap2_clr;		/* 0x034 */
+	u32 rsv_0x38[2];		/* 0x038 ~ 0x03C */
+	u32 hwstrap2_lock;		/* 0x040 */
+	u32 hwstrap2_sec1;	/* 0x044 */
+	u32 hwstrap2_sec2;	/* 0x048 */
+	u32 hwstrap2_sec3;	/* 0x04C */
+	u32 sysrest_log1;		/* 0x050 */
+	u32 sysrest_log1_sec1;	/* 0x054 */
+	u32 sysrest_log1_sec2;	/* 0x058 */
+	u32 sysrest_log1_sec3;	/* 0x05C */
+	u32 sysrest_log2;		/* 0x060 */
+	u32 sysrest_log2_sec1;	/* 0x064 */
+	u32 sysrest_log2_sec2;	/* 0x068 */
+	u32 sysrest_log2_sec3;	/* 0x06C */
+	u32 sysrest_log3;		/* 0x070 */
+	u32 sysrest_log3_sec1; /* 0x074 */
+	u32 sysrest_log3_sec2; /* 0x078 */
+	u32 sysrest_log3_sec3; /* 0x07C */
+	u32 sysrest_log4;		/* 0x080 */
+	u32 sysrest_log4_sec1; /* 0x084 */
+	u32 sysrest_log4_sec2; /* 0x088 */
+	u32 sysrest_log4_sec3; /* 0x08C */
+	u32 rsv_0x90[7];		/* 0x090 ~ 0xA8 */
+	u32 uart_dbg_rate;		/* 0x0AC */
+	u32 rsv_0xB0[4];		/* 0x0B0 ~ 0xBC*/
+	u32 misc;			/* 0x0C0 */
+	u32 rsv_0xC4;		/* 0x0C4 */
+	u32 debug_ctrl;		/* 0x0C8 */
+	u32 rsv_0xCC;		/* 0x0CC */
+	u32 dac_ctrl;		/* 0x0D0 */
+	u32 dac_crc_ctrl;		/* 0x0D4 */
+	u32 rsv_0xD8[2];		/* 0x0D8 ~ 0x0DC */
+	u32 video_input_ctrl;		/* 0x0E0 */
+	u32 rsv_0xE4[3];		/* 0x0E4 ~ 0x0EC */
+	u32 random_num_ctrl;	/* 0x0F0 */
+	u32 random_num_data;	/* 0x0F4 */
+	u32 rsv_0xF0[2];		/* 0x0F8 ~ 0x0FC */
+	u32 rsv_0x100[32];		/* 0x100 ~ 0x17C */
+	u32 scratch[32];		/* 0x180 ~ 0x1FC */
+	u32 modrst1_ctrl;		/* 0x200 */
+	u32 modrst1_clr;		/* 0x204 */
+	u32 rsv_0x208[2];		/* 0x208 ~ 0x20C */
+	u32 modrst_lock1;		/* 0x210 */
+	u32 modrst1_sec1;		/* 0x214 */
+	u32 modrst1_sec2;		/* 0x218 */
+	u32 modrst1_sec3;		/* 0x21C */
+	u32 modrst2_ctrl;		/* 0x220 */
+	u32 modrst2_clr;		/* 0x224 */
+	u32 rsv_0x228[2];		/* 0x228 ~ 0x22C */
+	u32 modrst2_lock;		/* 0x230 */
+	u32 modrst2_prot1;		/* 0x234 */
+	u32 modrst2_prot2;		/* 0x238 */
+	u32 modrst2_prot3;		/* 0x23C */
+	u32 clkgate_ctrl1;		/* 0x240 */
+	u32 clkgate_clr1;		/* 0x244 */
+	u32 rsv_0x248[2];		/* 0x248 */
+	u32 clkgate_lock1;		/* 0x250 */
+	u32 clkgate_secure11;		/* 0x254 */
+	u32 clkgate_secure12;		/* 0x258 */
+	u32 clkgate_secure13;		/* 0x25c */
+	u32 clkgate_ctrl2;		/* 0x260 */
+	u32 clkgate_clr2;		/* 0x264 */
+	u32 rsv_0x268[2];		/* 0x268 */
+	u32 clkgate_lock2;		/* 0x270 */
+	u32 clkgate_secure21;		/* 0x274 */
+	u32 clkgate_secure22;		/* 0x278 */
+	u32 clkgate_secure23;		/* 0x27c */
+	u32 clk_sel1;		/* 0x280 */
+	u32 clk_sel2;		/* 0x284 */
+	u32 rsv_0x288[2];		/* 0x288 */
+	u32 clk_sel1_lock;		/* 0x290 */
+	u32 clk_sel2_lock;		/* 0x294 */
+	u32 rsv_0x298[2];		/* 0x298 */
+	u32 clk_sel1_secure1;		/* 0x2a0 */
+	u32 clk_sel1_secure2;		/* 0x2a4 */
+	u32 rsv_0x2a8[2];		/* 0x2a8 */
+	u32 clk_sel2_secure1;		/* 0x2b0 */
+	u32 clk_sel2_secure2;		/* 0x2b4 */
+	u32 rsv_0x2b8[2];		/* 0x2b8 */
+	u32 clk_sel3_secure1;		/* 0x2c0 */
+	u32 clk_sel3_secure2;		/* 0x2c4 */
+	u32 rsv_0x2c8[10];		/* 0x2c8 */
+	u32 extrst_sel1;		/* 0x2f0 */
+	u32 extrst_sel2;		/* 0x2f4 */
+	u32 rsv_0x2f8[2];		/* 0x2f8 */
+	u32 hpll;			/* 0x300 */
+	u32 hpll_ext;		/* 0x304 */
+	u32 rsv_0x308[2];		/* 0x308 ~ 0x30C */
+	u32 apll;			/* 0x310 */
+	u32 apll_ext;		/* 0x314 */
+	u32 rsv_0x318[2];		/* 0x318 ~ 0x31C */
+	u32 dpll;			/* 0x320 */
+	u32 dpll_ext;		/* 0x324 */
+	u32 rsv_0x328[2];		/* 0x328 ~ 0x32C */
+	u32 uxclk_ctrl;		/* 0x330 */
+	u32 huxclk_ctrl;		/* 0x334 */
+	u32 rsv_0x338[18];		/* 0x338 ~ 0x37C */
+	u32 clkduty_meas_ctrl;	/* 0x380 */
+	u32 clkduty1;		/* 0x384 */
+	u32 clkduty2;		/* 0x388 */
+	u32 rsv_0x38c;		/* 0x38c */
+	u32 mac_delay;		/* 0x390 */
+	u32 mac_100m_delay;		/* 0x394 */
+	u32 mac_10m_delay;		/* 0x398 */
+	u32 rsv_0x39c;		/* 0x39c */
+	u32 freq_counter_ctrl;	/* 0x3a0 */
+	u32 freq_counter_cmp;	/* 0x3a4 */
+	u32 rsv_0x3a8[2];		/* 0x3a8 ~ 0x3aC */
+	u32 usb_ctrl;		/* 0x3b0 */
+	u32 usb_lock;		/* 0x3b4 */
+	u32 usb_secure1;	/* 0x3b8 */
+	u32 usb_secure2;	/* 0x3bc */
+	u32 usb_secure3;	/* 0x3c0 */
+	u32 rsv_0x3c4[15];	/* 0x3c4 ~ 0x3fc */
+	u32 pinumx1;		/* 0x400 */
+	u32 pinumx2;		/* 0x404 */
+	u32 pinumx3;		/* 0x408 */
+	u32 pinumx4;		/* 0x40c */
+	u32 pinumx5;		/* 0x410 */
+	u32 pinumx6;		/* 0x414 */
+	u32 pinumx7;		/* 0x418 */
+	u32 pinumx8;		/* 0x41c */
+	u32 pinumx9;		/* 0x420 */
+	u32 pinumx10;		/* 0x424 */
+	u32 pinumx11;		/* 0x428 */
+	u32 pinumx12;		/* 0x42c */
+	u32 pinumx13;		/* 0x430 */
+	u32 pinumx14;		/* 0x434 */
+	u32 pinumx15;		/* 0x438 */
+	u32 pinumx16;		/* 0x43c */
+	u32 pinumx17;		/* 0x440 */
+	u32 pinumx18;		/* 0x444 */
+	u32 pinumx19;		/* 0x448 */
+	u32 pinumx20;		/* 0x44c */
+	u32 pinumx21;		/* 0x450 */
+	u32 pinumx22;		/* 0x454 */
+	u32 pinumx23;		/* 0x458 */
+	u32 pinumx24;		/* 0x45c */
+	u32 pinumx25;		/* 0x460 */
+	u32 pinumx26;		/* 0x464 */
+	u32 pinumx27;		/* 0x468 */
+	u32 rsv_0x46c[4];	/* 0x46c ~ 0x478 */
+	u32 pinumx31;		/* 0x47c */
+	u32 pull_down_dis[8];	/* 0x480 ~ 0x49c */
+	u32 pin_conf;		/* 0x4a0 */
+	u32 rsv_0x4a4[7];	/* 0x4a4 ~ 0x4bc */
+	u32 io_driving0;	/* 0x4c0 */
+	u32 io_driving1;	/* 0x4c4 */
+	u32 io_driving2;	/* 0x4c8 */
+	u32 io_driving3;	/* 0x4cc */
+	u32 io_driving4;	/* 0x4d0 */
+	u32 io_driving5;	/* 0x4d4 */
+	u32 io_driving6;	/* 0x4d8 */
+	u32 io_driving7;	/* 0x4dc */
+	u32 io_driving8;	/* 0x4e0 */
+};
+
+#endif
+#endif
diff --git a/drivers/clk/aspeed/Makefile b/drivers/clk/aspeed/Makefile
index 84776e5265e..285180b67cf 100644
--- a/drivers/clk/aspeed/Makefile
+++ b/drivers/clk/aspeed/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_ASPEED_AST2500) += clk_ast2500.o
 obj-$(CONFIG_ASPEED_AST2600) += clk_ast2600.o
+obj-$(CONFIG_ASPEED_AST2700) += clk_ast2700.o
diff --git a/drivers/clk/aspeed/clk_ast2700.c b/drivers/clk/aspeed/clk_ast2700.c
new file mode 100644
index 00000000000..c05d2d642b4
--- /dev/null
+++ b/drivers/clk/aspeed/clk_ast2700.c
@@ -0,0 +1,952 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
+#include <asm/io.h>
+#include <aspeed/scu_ast2700.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/lists.h>
+#include <syscon.h>
+#include <linux/bitfield.h>
+
+#include <dt-bindings/clock/aspeed,ast2700-scu.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/**
+ * RGMII clock source tree
+ * HPLL -->|\
+ *         | |---->| divider |---->RGMII 125M for MAC#0 & MAC#1
+ * APLL -->|/
+ */
+#define RGMII_DEFAULT_CLK_SRC	SCU1_CLK_HPLL
+
+struct mac_delay_config {
+	u32 tx_delay_1000;
+	u32 rx_delay_1000;
+	u32 tx_delay_100;
+	u32 rx_delay_100;
+	u32 tx_delay_10;
+	u32 rx_delay_10;
+};
+
+typedef int (*ast2700_clk_init_fn)(struct udevice *dev);
+
+struct ast2700_clk_priv {
+	void __iomem *reg;
+	ast2700_clk_init_fn init;
+};
+
+static u32 ast2700_soc1_get_pll_rate(struct ast2700_scu1 *scu, int pll_idx)
+{
+	union ast2700_pll_reg pll_reg;
+	u32 mul = 1, div = 1;
+
+	switch (pll_idx) {
+	case SCU1_CLK_HPLL:
+		pll_reg.w = readl(&scu->hpll);
+		break;
+	case SCU1_CLK_APLL:
+		pll_reg.w = readl(&scu->apll);
+		break;
+	case SCU1_CLK_DPLL:
+		pll_reg.w = readl(&scu->dpll);
+		break;
+	}
+
+	if (!pll_reg.b.bypass) {
+		mul = (pll_reg.b.m + 1) / (pll_reg.b.n + 1);
+		div = (pll_reg.b.p + 1);
+	}
+
+	return ((CLKIN_25M * mul) / div);
+}
+
+#define SCU_CLKSEL2_HCLK_DIV_MASK		GENMASK(22, 20)
+#define SCU_CLKSEL2_HCLK_DIV_SHIFT		20
+
+static u32 ast2700_soc1_get_hclk_rate(struct ast2700_scu1 *scu)
+{
+	u32 rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_HPLL);
+	u32 clk_sel2 = readl(&scu->clk_sel2);
+	u32 hclk_div = (clk_sel2 & SCU_CLKSEL2_HCLK_DIV_MASK) >>
+			     SCU_CLKSEL2_HCLK_DIV_SHIFT;
+
+	if (!hclk_div)
+		hclk_div = 2;
+	else
+		hclk_div++;
+
+	return (rate / hclk_div);
+}
+
+#define SCU1_CLKSEL1_PCLK_DIV_MASK		GENMASK(20, 18)
+#define SCU1_CLKSEL1_PCLK_DIV_SHIFT		18
+
+static u32 ast2700_soc1_get_pclk_rate(struct ast2700_scu1 *scu)
+{
+	u32 rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_HPLL);
+
+	u32 clk_sel1 = readl(&scu->clk_sel1);
+	u32 pclk_div = (clk_sel1 & SCU1_CLKSEL1_PCLK_DIV_MASK) >>
+			     SCU1_CLKSEL1_PCLK_DIV_SHIFT;
+
+	return (rate / ((pclk_div + 1) * 2));
+}
+
+#define SCU_UART_CLKGEN_N_MASK			GENMASK(17, 8)
+#define SCU_UART_CLKGEN_N_SHIFT			8
+#define SCU_UART_CLKGEN_R_MASK			GENMASK(7, 0)
+#define SCU_UART_CLKGEN_R_SHIFT			0
+
+static u32 ast2700_soc1_get_uart_uxclk_rate(struct ast2700_scu1 *scu)
+{
+	u32 uxclk_sel = readl(&scu->clk_sel2) & GENMASK(1, 0);
+	u32 uxclk_ctrl = readl(&scu->uxclk_ctrl);
+	u32 rate;
+
+	switch (uxclk_sel) {
+	case 0:
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_APLL) / 4;
+		break;
+	case 1:
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_APLL) / 2;
+		break;
+	case 2:
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_APLL);
+		break;
+	case 3:
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_HPLL);
+		break;
+	}
+
+	u32 n = (uxclk_ctrl & SCU_UART_CLKGEN_N_MASK) >>
+		      SCU_UART_CLKGEN_N_SHIFT;
+	u32 r = (uxclk_ctrl & SCU_UART_CLKGEN_R_MASK) >>
+		      SCU_UART_CLKGEN_R_SHIFT;
+
+	return ((rate * r) / (n * 2));
+}
+
+#define SCU_HUART_CLKGEN_N_MASK			GENMASK(17, 8)
+#define SCU_HUART_CLKGEN_N_SHIFT		8
+#define SCU_HUART_CLKGEN_R_MASK			GENMASK(7, 0)
+#define SCU_HUART_CLKGEN_R_SHIFT		0
+
+static u32 ast2700_soc1_get_uart_huxclk_rate(struct ast2700_scu1 *scu)
+{
+	u32 huxclk_sel = (readl(&scu->clk_sel2) & GENMASK(4, 3)) >> 3;
+	u32 huxclk_ctrl = readl(&scu->huxclk_ctrl);
+	u32 n = (huxclk_ctrl & SCU_HUART_CLKGEN_N_MASK) >>
+		      SCU_HUART_CLKGEN_N_SHIFT;
+	u32 r = (huxclk_ctrl & SCU_HUART_CLKGEN_R_MASK) >>
+		      SCU_HUART_CLKGEN_R_SHIFT;
+	u32 rate;
+
+	switch (huxclk_sel) {
+	case 0:
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_APLL) / 4;
+		break;
+	case 1:
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_APLL) / 2;
+		break;
+	case 2:
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_APLL);
+		break;
+	case 3:
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_HPLL);
+		break;
+	}
+
+	return ((rate * r) / (n * 2));
+}
+
+#define SCU_CLKSRC1_SDIO_DIV_MASK		GENMASK(16, 14)
+#define SCU_CLKSRC1_SDIO_DIV_SHIFT		14
+#define SCU_CLKSRC1_SDIO_SEL			BIT(13)
+const int ast2700_sd_div_tbl[] = {
+	2, 2, 3, 4, 5, 6, 7, 8
+};
+
+static u32 ast2700_soc1_get_sdio_clk_rate(struct ast2700_scu1 *scu)
+{
+	u32 rate = 0;
+	u32 clk_sel1 = readl(&scu->clk_sel1);
+	u32 div = (clk_sel1 & SCU_CLKSRC1_SDIO_DIV_MASK) >>
+			     SCU_CLKSRC1_SDIO_DIV_SHIFT;
+
+	if (clk_sel1 & SCU_CLKSRC1_SDIO_SEL)
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_APLL);
+	else
+		rate = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_HPLL);
+
+	if (!div)
+		div = 1;
+
+	div++;
+
+	return (rate / div);
+}
+
+static void ast2700_init_sdclk(struct ast2700_scu1 *scu)
+{
+	u32 src_clk = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_HPLL);
+	u32 reg_280;
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		if (src_clk / ast2700_sd_div_tbl[i] <= 125000000)
+			break;
+	}
+
+	reg_280 = readl(&scu->clk_sel1);
+	reg_280 &= ~(SCU_CLKSRC1_SDIO_DIV_MASK | SCU_CLKSRC1_SDIO_SEL);
+	reg_280 |= i << SCU_CLKSRC1_SDIO_DIV_SHIFT;
+	writel(reg_280, &scu->clk_sel1);
+}
+
+static u32
+ast2700_soc1_get_uart_clk_rate(struct ast2700_scu1 *scu, int uart_idx)
+{
+	u32 rate = 0;
+
+	if (readl(&scu->clk_sel1) & BIT(uart_idx))
+		rate = ast2700_soc1_get_uart_huxclk_rate(scu);
+	else
+		rate = ast2700_soc1_get_uart_uxclk_rate(scu);
+
+	return rate;
+}
+
+static ulong ast2700_soc1_clk_get_rate(struct clk *clk)
+{
+	struct ast2700_clk_priv *priv = dev_get_priv(clk->dev);
+	struct ast2700_scu1 *scu = (struct ast2700_scu1 *)priv->reg;
+	ulong rate = 0;
+
+	switch (clk->id) {
+	case SCU1_CLK_HPLL:
+	case SCU1_CLK_APLL:
+	case SCU1_CLK_DPLL:
+		rate = ast2700_soc1_get_pll_rate(scu, clk->id);
+		break;
+	case SCU1_CLK_AHB:
+		rate = ast2700_soc1_get_hclk_rate(scu);
+		break;
+	case SCU1_CLK_APB:
+		rate = ast2700_soc1_get_pclk_rate(scu);
+		break;
+	case SCU1_CLK_GATE_UART0CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 0);
+		break;
+	case SCU1_CLK_GATE_UART1CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 1);
+		break;
+	case SCU1_CLK_GATE_UART2CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 2);
+		break;
+	case SCU1_CLK_GATE_UART3CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 3);
+		break;
+	case SCU1_CLK_GATE_UART5CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 5);
+		break;
+	case SCU1_CLK_GATE_UART6CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 6);
+		break;
+	case SCU1_CLK_GATE_UART7CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 7);
+		break;
+	case SCU1_CLK_GATE_UART8CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 8);
+		break;
+	case SCU1_CLK_GATE_UART9CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 9);
+		break;
+	case SCU1_CLK_GATE_UART10CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 10);
+		break;
+	case SCU1_CLK_GATE_UART11CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 11);
+		break;
+	case SCU1_CLK_GATE_UART12CLK:
+		rate = ast2700_soc1_get_uart_clk_rate(scu, 12);
+		break;
+	case SCU1_CLK_GATE_SDCLK:
+		rate = ast2700_soc1_get_sdio_clk_rate(scu);
+		break;
+	case SCU1_CLK_UXCLK:
+		rate = ast2700_soc1_get_uart_uxclk_rate(scu);
+		break;
+	case SCU1_CLK_HUXCLK:
+		rate = ast2700_soc1_get_uart_huxclk_rate(scu);
+		break;
+	default:
+		debug("%s: unknown clk %ld\n", __func__, clk->id);
+		return -ENOENT;
+	}
+
+	return rate;
+}
+
+static int ast2700_soc1_clk_enable(struct clk *clk)
+{
+	struct ast2700_clk_priv *priv = dev_get_priv(clk->dev);
+	struct ast2700_scu1 *scu = (struct ast2700_scu1 *)priv->reg;
+	u32 clkgate_bit;
+
+	if (clk->id >= 32)
+		clkgate_bit = BIT(clk->id - 32);
+	else
+		clkgate_bit = BIT(clk->id);
+
+	writel(clkgate_bit, &scu->clkgate_clr1);
+
+	return 0;
+}
+
+static const struct clk_ops ast2700_soc1_clk_ops = {
+	.get_rate = ast2700_soc1_clk_get_rate,
+	.enable = ast2700_soc1_clk_enable,
+};
+
+#define SCU_HW_REVISION_ID		GENMASK(23, 16)
+#define SCU_CPUCLK_MASK		GENMASK(4, 2)
+#define SCU_CPUCLK_SHIFT	2
+static u32 ast2700_soc0_get_hpll_rate(struct ast2700_scu0 *scu)
+{
+	u32 chip_id1 = readl(&scu->chip_id1);
+	u32 hwstrap1 = readl(&scu->hwstrap1);
+	union ast2700_pll_reg pll_reg;
+	u32 mul = 1, div = 1;
+	u32 rate;
+
+	pll_reg.w = readl(&scu->hpll);
+
+	if ((chip_id1 & SCU_HW_REVISION_ID) && (hwstrap1 & BIT(3))) {
+		switch ((hwstrap1 & GENMASK(4, 2)) >> 2) {
+		case 2:
+			rate = 1800000000;
+			break;
+		case 3:
+			rate = 1700000000;
+			break;
+		case 6:
+			rate = 1200000000;
+			break;
+		case 7:
+			rate = 800000000;
+			break;
+		default:
+			rate = 1600000000;
+		}
+	} else if (hwstrap1 & GENMASK(3, 2)) {
+		switch ((hwstrap1 & GENMASK(3, 2)) >> 2) {
+		case 1U:
+			rate = 1900000000;
+			break;
+		case 2U:
+			rate = 1800000000;
+			break;
+		case 3U:
+			rate = 1700000000;
+			break;
+		default:
+			rate = 1600000000;
+			break;
+		}
+	} else {
+		if (pll_reg.b.bypass == 0U) {
+			/* F = 25Mhz * [(M + 2) / 2 * (n + 1)] / (p + 1) */
+			mul = (pll_reg.b.m + 1) / ((pll_reg.b.n + 1) * 2);
+			div = (pll_reg.b.p + 1);
+		}
+		rate = ((CLKIN_25M * mul) / div);
+	}
+
+	return rate;
+}
+
+static u32 ast2700_soc0_get_pll_rate(struct ast2700_scu0 *scu, int pll_idx)
+{
+	union ast2700_pll_reg pll_reg;
+	u32 mul = 1, div = 1;
+	u32 rate;
+
+	switch (pll_idx) {
+	case SCU0_CLK_DPLL:
+		pll_reg.w = readl(&scu->dpll);
+		break;
+	case SCU0_CLK_MPLL:
+		pll_reg.w = readl(&scu->mpll);
+		break;
+	default:
+		pr_err("%s: invalid PSP clock source (%d)\n", __func__, pll_idx);
+		return 0;
+	}
+
+	if (pll_reg.b.bypass == 0U) {
+		if (pll_idx == SCU0_CLK_MPLL) {
+			/* F = 25Mhz * [M / (n + 1)] / (p + 1) */
+			mul = (pll_reg.b.m) / ((pll_reg.b.n + 1));
+			div = (pll_reg.b.p + 1);
+		} else {
+			/* F = 25Mhz * [(M + 2) / 2 * (n + 1)] / (p + 1) */
+			mul = (pll_reg.b.m + 1) / ((pll_reg.b.n + 1) * 2);
+			div = (pll_reg.b.p + 1);
+		}
+	}
+
+	rate = ((CLKIN_25M * mul) / div);
+
+	return rate;
+}
+
+/*
+ * AST2700A1
+ * SCU010[4:2]:
+ * 000: CPUCLK=MPLL=1.6GHz (MPLL default setting with SCU310, SCU314)
+ * 001: CPUCLK=HPLL=2.0GHz (HPLL default setting with SCU300, SCU304)
+ * 010: CPUCLK=HPLL=1.8GHz (HPLL frequency is constance and is not controlled by SCU300, SCU304)
+ * 011: CPUCLK=HPLL=1.7GHz (HPLL frequency is constance and is not controlled by SCU300, SCU304)
+ * 100: CPUCLK=MPLL/2=800MHz (MPLL default setting with SCU310, SCU314)
+ * 101: CPUCLK=HPLL/2=1.0GHz (HPLL default setting with SCU300, SCU304)
+ * 110: CPUCLK=HPLL=1.2GHz (HPLL frequency is constance and is not controlled by SCU300, SCU304)
+ * 111: CPUCLK=HPLL=800MHz (HPLL frequency is constance and is not controlled by SCU300, SCU304)
+ */
+
+static u32 ast2700_soc0_get_pspclk_rate(struct ast2700_scu0 *scu)
+{
+	u32 chip_id1 = readl(&scu->chip_id1);
+	u32 hwstrap1 = readl(&scu->hwstrap1);
+	u32 rate;
+	int cpuclk_set;
+
+	if (chip_id1 & SCU_HW_REVISION_ID) {
+		cpuclk_set = (hwstrap1 & SCU_CPUCLK_MASK) >> SCU_CPUCLK_SHIFT;
+		switch (cpuclk_set) {
+		case 0:
+			rate = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL);
+			break;
+		case 1:
+		case 2:
+		case 3:
+		case 6:
+		case 7:
+			rate = ast2700_soc0_get_hpll_rate(scu);
+			break;
+		case 4:
+			rate = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL) / 2;
+			break;
+		case 5:
+			rate = ast2700_soc0_get_hpll_rate(scu) / 2;
+			break;
+		default:
+			rate = ast2700_soc0_get_hpll_rate(scu);
+			break;
+		}
+	} else {
+		if (hwstrap1 & BIT(4))
+			rate = ast2700_soc0_get_hpll_rate(scu);
+		else
+			rate = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL);
+	}
+	return rate;
+}
+
+static u32 ast2700_soc0_get_axi0clk_rate(struct ast2700_scu0 *scu)
+{
+	return ast2700_soc0_get_pspclk_rate(scu) / 2;
+}
+
+#define SCU_AHB_DIV_MASK		GENMASK(6, 5)
+#define SCU_AHB_DIV_SHIFT		5
+static u32 hclk_ast2700a1_div_table[] = {
+	6, 5, 4, 7,
+};
+
+static u32 ast2700_soc0_get_hclk_rate(struct ast2700_scu0 *scu)
+{
+	u32 hwstrap1 = readl(&scu->hwstrap1);
+	u32 chip_id1 = readl(&scu->chip_id1);
+	u32 src_clk;
+	int div;
+
+	if (chip_id1 & SCU_HW_REVISION_ID) {
+		if (hwstrap1 & BIT(7))
+			src_clk = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL);
+		else
+			src_clk = ast2700_soc0_get_hpll_rate(scu);
+
+		div = (hwstrap1 & SCU_AHB_DIV_MASK) >> SCU_AHB_DIV_SHIFT;
+		div = hclk_ast2700a1_div_table[div];
+	} else {
+		if (hwstrap1 & BIT(7))
+			src_clk = ast2700_soc0_get_hpll_rate(scu);
+		else
+			src_clk = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL);
+
+		div = (hwstrap1 & SCU_AHB_DIV_MASK) >> SCU_AHB_DIV_SHIFT;
+
+		if (!div)
+			div = 4;
+		else
+			div = (div + 1) * 2;
+	}
+	return (src_clk / div);
+}
+
+static u32 ast2700_soc0_get_axi1clk_rate(struct ast2700_scu0 *scu)
+{
+	if (readl(&scu->chip_id1) & SCU_HW_REVISION_ID)
+		return ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL) / 4;
+	else
+		return ast2700_soc0_get_hclk_rate(scu);
+}
+
+#define SCU0_CLKSEL1_PCLK_DIV_MASK		GENMASK(25, 23)
+#define SCU0_CLKSEL1_PCLK_DIV_SHIFT		23
+
+static u32 ast2700_soc0_get_pclk_rate(struct ast2700_scu0 *scu)
+{
+	u32 rate = ast2700_soc0_get_axi0clk_rate(scu);
+	u32 clksel1 = readl(&scu->clk_sel1);
+	int div;
+
+	div = (clksel1 & SCU0_CLKSEL1_PCLK_DIV_MASK) >>
+			    SCU0_CLKSEL1_PCLK_DIV_SHIFT;
+
+	return (rate / ((div + 1) * 2));
+}
+
+#define SCU_CLKSEL1_MPHYCLK_SEL_MASK		GENMASK(19, 18)
+#define SCU_CLKSEL1_MPHYCLK_SEL_SHIFT		18
+#define SCU_CLKSEL1_MPHYCLK_DIV_MASK		GENMASK(7, 0)
+static u32 ast2700_soc0_get_mphyclk_rate(struct ast2700_scu0 *scu)
+{
+	int div = readl(&scu->mphyclk_para) & SCU_CLKSEL1_MPHYCLK_DIV_MASK;
+	u32 chip_id1 = readl(&scu->chip_id1);
+	u32 clk_sel2;
+	int clk_sel;
+	u32 rate = 0;
+
+	if (chip_id1 & SCU_HW_REVISION_ID) {
+		clk_sel2 = readl(&scu->clk_sel2);
+		clk_sel = (clk_sel2 & SCU_CLKSEL1_MPHYCLK_SEL_MASK)
+			  >> SCU_CLKSEL1_MPHYCLK_SEL_SHIFT;
+		switch (clk_sel) {
+		case 0:
+			rate = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL);
+			break;
+		case 1:
+			rate = ast2700_soc0_get_hpll_rate(scu);
+			break;
+		case 2:
+			rate = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_DPLL);
+			break;
+		case 3:
+			rate = 26000000;
+			break;
+		}
+	} else {
+		rate = ast2700_soc0_get_hpll_rate(scu);
+	}
+
+	return (rate / (div + 1));
+}
+
+static void ast2700_mphy_clk_init(struct ast2700_scu0 *scu)
+{
+	u32 clksrc1, rate = 0;
+	int i;
+
+	/* set mphy clk */
+	if (readl(&scu->chip_id1) & SCU_HW_REVISION_ID) {
+		clksrc1 = (readl(&scu->clk_sel2) & SCU_CLKSEL1_MPHYCLK_SEL_MASK)
+			  >> SCU_CLKSEL1_MPHYCLK_SEL_SHIFT;
+		switch (clksrc1) {
+		case 0:
+			rate = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL);
+			break;
+		case 1:
+			rate = ast2700_soc0_get_hpll_rate(scu);
+			break;
+		case 2:
+			rate = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_DPLL);
+			break;
+		case 3:
+			rate = 26000000;
+			break;
+		}
+	} else {
+		rate = ast2700_soc0_get_hpll_rate(scu);
+	}
+
+	for (i = 1; i < 256; i++) {
+		if ((rate / i) <= 26000000)
+			break;
+	}
+
+	/* register defined the value plus 1 is divider*/
+	i--;
+	writel(i, &scu->mphyclk_para);
+}
+
+#define SCU_CLKSRC1_EMMC_DIV_MASK		GENMASK(14, 12)
+#define SCU_CLKSRC1_EMMC_DIV_SHIFT		12
+#define SCU_CLKSRC1_EMMC_SEL			BIT(11)
+static u32 ast2700_soc0_get_emmcclk_rate(struct ast2700_scu0 *scu)
+{
+	u32 clksel1 = readl(&scu->clk_sel1);
+	u32 rate;
+	int div;
+
+	div = (clksel1 & SCU_CLKSRC1_EMMC_DIV_MASK) >> SCU_CLKSRC1_EMMC_DIV_SHIFT;
+
+	if (clksel1 & SCU_CLKSRC1_EMMC_SEL)
+		rate = ast2700_soc0_get_hpll_rate(scu) / 4;
+	else
+		rate = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL) / 4;
+
+	return (rate / ((div + 1) * 2));
+}
+
+static void ast2700_emmc_init(struct ast2700_scu0 *scu)
+{
+	u32 clksrc1, rate, div;
+	int i;
+
+	/* set clk/cmd driving */
+	writel(2, &scu->gpio18d0_ioctrl); /* clk driving */
+	writel(1, &scu->gpio18d1_ioctrl); /* cmd driving */
+	writel(1, &scu->gpio18d2_ioctrl); /* data0 driving */
+	writel(1, &scu->gpio18d3_ioctrl); /* data1 driving */
+	writel(1, &scu->gpio18d4_ioctrl); /* data2 driving */
+	writel(1, &scu->gpio18d5_ioctrl); /* data2 driving */
+
+	/* emmc clk: set clk src mpll/4:400Mhz */
+	clksrc1 = readl(&scu->clk_sel1);
+	rate = ast2700_soc0_get_pll_rate(scu, SCU0_CLK_MPLL) / 4;
+	for (i = 0; i < 8; i++) {
+		div = (i + 1) * 2;
+		if ((rate / div) <= 200000000)
+			break;
+	}
+
+	clksrc1 &= ~(SCU_CLKSRC1_EMMC_DIV_MASK | SCU_CLKSRC1_EMMC_SEL);
+	clksrc1 |= (i << SCU_CLKSRC1_EMMC_DIV_SHIFT);
+	writel(clksrc1, &scu->clk_sel1);
+}
+
+static void ast2700_vga_clk_init(struct ast2700_scu0 *scu)
+{
+	if ((readl(&scu->chip_id1) & SCU_HW_REVISION_ID) == 0)
+		return;
+
+	// Use d0clk/d1clk which generated from hpll for vga0/1 after A0
+	// Use CRT1clk as soc display source
+	setbits_le32(&scu->clk_sel3, BIT(14) | BIT(13) | BIT(12));
+}
+
+static u32 ast2700_soc0_get_uartclk_rate(struct ast2700_scu0 *scu)
+{
+	u32 clksel2 = readl(&scu->clk_sel2);
+	u32 div = 1;
+	u32 rate;
+
+	if (clksel2 & BIT(15))
+		rate = 192000000;
+	else
+		rate = 24000000;
+
+	if (clksel2 & BIT(30))
+		div = 13;
+	return (rate / div);
+}
+
+static ulong ast2700_soc0_clk_get_rate(struct clk *clk)
+{
+	struct ast2700_clk_priv *priv = dev_get_priv(clk->dev);
+	ulong rate = 0;
+
+	switch (clk->id) {
+	case SCU0_CLK_PSP:
+		rate = ast2700_soc0_get_pspclk_rate((struct ast2700_scu0 *)priv->reg);
+		break;
+	case SCU0_CLK_HPLL:
+		rate = ast2700_soc0_get_hpll_rate((struct ast2700_scu0 *)priv->reg);
+		break;
+	case SCU0_CLK_DPLL:
+	case SCU0_CLK_MPLL:
+		rate = ast2700_soc0_get_pll_rate((struct ast2700_scu0 *)priv->reg, clk->id);
+		break;
+	case SCU0_CLK_AXI0:
+		rate = ast2700_soc0_get_axi0clk_rate((struct ast2700_scu0 *)priv->reg);
+		break;
+	case SCU0_CLK_AXI1:
+		rate = ast2700_soc0_get_axi1clk_rate((struct ast2700_scu0 *)priv->reg);
+		break;
+	case SCU0_CLK_AHB:
+		rate = ast2700_soc0_get_hclk_rate((struct ast2700_scu0 *)priv->reg);
+		break;
+	case SCU0_CLK_APB:
+		rate = ast2700_soc0_get_pclk_rate((struct ast2700_scu0 *)priv->reg);
+		break;
+	case SCU0_CLK_GATE_EMMCCLK:
+		rate = ast2700_soc0_get_emmcclk_rate((struct ast2700_scu0 *)priv->reg);
+		break;
+	case SCU0_CLK_GATE_UART4CLK:
+		rate = ast2700_soc0_get_uartclk_rate((struct ast2700_scu0 *)priv->reg);
+		break;
+	case SCU0_CLK_MPHY:
+		rate = ast2700_soc0_get_mphyclk_rate((struct ast2700_scu0 *)priv->reg);
+		break;
+	default:
+		debug("%s: unknown clk %ld\n", __func__, clk->id);
+		return -ENOENT;
+	}
+
+	return rate;
+}
+
+static int ast2700_soc0_clk_enable(struct clk *clk)
+{
+	struct ast2700_clk_priv *priv = dev_get_priv(clk->dev);
+	struct ast2700_scu0 *scu = (struct ast2700_scu0 *)priv->reg;
+	u32 clkgate_bit = BIT(clk->id);
+
+	writel(clkgate_bit, &scu->clkgate_clr);
+
+	return 0;
+}
+
+static const struct clk_ops ast2700_soc0_clk_ops = {
+	.get_rate = ast2700_soc0_clk_get_rate,
+	.enable = ast2700_soc0_clk_enable,
+};
+
+static void ast2700_init_mac_clk(struct ast2700_scu1 *scu)
+{
+	u32 src_clk = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_HPLL);
+	u32 reg_280;
+	u8 div_idx;
+
+	/* The MAC source clock selects HPLL only, and the default clock
+	 * setting is 200 Mhz.
+	 * Calculate the corresponding divider:
+	 * 1: div 2
+	 * 2: div 3
+	 * ...
+	 * 7: div 8
+	 */
+	for (div_idx = 1; div_idx <= 7; div_idx++)
+		if (DIV_ROUND_UP(src_clk, div_idx + 1) == 200000000)
+			break;
+
+	if (div_idx == 8) {
+		pr_err("MAC clock cannot divide to 200 MHz\n");
+		return;
+	}
+
+	/* set HPLL clock divider */
+	reg_280 = readl(&scu->clk_sel1);
+	reg_280 &= ~GENMASK(31, 29);
+	reg_280 |= div_idx << 29;
+	writel(reg_280, &scu->clk_sel1);
+}
+
+static void ast2700_init_rgmii_clk(struct ast2700_scu1 *scu)
+{
+	u32 reg_284 = readl(&scu->clk_sel2);
+	u32 src_clk = ast2700_soc1_get_pll_rate(scu, RGMII_DEFAULT_CLK_SRC);
+
+	if (RGMII_DEFAULT_CLK_SRC == SCU1_CLK_HPLL) {
+		u32 reg_280;
+		u8 div_idx;
+
+		/* Calculate the corresponding divider:
+		 * 1: div 4
+		 * 2: div 6
+		 * ...
+		 * 7: div 16
+		 */
+		for (div_idx = 1; div_idx <= 7; div_idx++) {
+			u8 div = 4 + 2 * (div_idx - 1);
+
+			if (DIV_ROUND_UP(src_clk, div) == 125000000)
+				break;
+		}
+		if (div_idx == 8) {
+			pr_err("RGMII using HPLL cannot divide to 125 MHz\n");
+			return;
+		}
+
+		/* set HPLL clock divider */
+		reg_280 = readl(&scu->clk_sel1);
+		reg_280 &= ~GENMASK(27, 25);
+		reg_280 |= div_idx << 25;
+		writel(reg_280, &scu->clk_sel1);
+
+		/* select HPLL clock source */
+		reg_284 &= ~BIT(18);
+	} else {
+		/* APLL clock divider is fixed to 8 */
+		if (DIV_ROUND_UP(src_clk, 8) != 125000000) {
+			pr_err("RGMII using APLL cannot divide to 125 MHz\n");
+			return;
+		}
+
+		/* select APLL clock source */
+		reg_284 |= BIT(18);
+	}
+
+	writel(reg_284, &scu->clk_sel2);
+}
+
+static void ast2700_init_rmii_clk(struct ast2700_scu1 *scu)
+{
+	u32 src_clk = ast2700_soc1_get_pll_rate(scu, SCU1_CLK_HPLL);
+	u32 reg_280;
+	u8 div_idx;
+
+	/* The RMII source clock selects HPLL only.
+	 * Calculate the corresponding divider:
+	 * 1: div 8
+	 * 2: div 12
+	 * ...
+	 * 7: div 32
+	 */
+	for (div_idx = 1; div_idx <= 7; div_idx++) {
+		u8 div = 8 + 4 * (div_idx - 1);
+
+		if (DIV_ROUND_UP(src_clk, div) == 50000000)
+			break;
+	}
+	if (div_idx == 8) {
+		pr_err("RMII using HPLL cannot divide to 50 MHz\n");
+		return;
+	}
+
+	/* set RMII clock divider */
+	reg_280 = readl(&scu->clk_sel1);
+	reg_280 &= ~GENMASK(23, 21);
+	reg_280 |= div_idx << 21;
+	writel(reg_280, &scu->clk_sel1);
+}
+
+static void ast2700_init_spi(struct ast2700_scu1 *scu)
+{
+	writel(readl(&scu->io_driving8) | 0x0000aaaa, &scu->io_driving8);	/* fwspi driving */
+	writel(readl(&scu->io_driving3) | 0x00000aaa, &scu->io_driving3);	/* spi0 driving */
+	writel(readl(&scu->io_driving3) | 0x0aaa0000, &scu->io_driving3);	/* spi1 driving */
+	writel(readl(&scu->io_driving4) | 0x00002aaa, &scu->io_driving4);	/* spi2 driving */
+}
+
+#define SCU1_CLK_I3C_DIV_MASK	GENMASK(25, 23)
+#define SCU1_CLK_I3C_DIV(n)	((n) - 1)
+static void ast2700_init_i3c_clk(struct ast2700_scu1 *scu)
+{
+	u32 reg_284;
+
+	/* I3C 250MHz = HPLL/4 */
+	reg_284 = readl(&scu->clk_sel2);
+	reg_284 &= ~SCU1_CLK_I3C_DIV_MASK;
+	reg_284 |= FIELD_PREP(SCU1_CLK_I3C_DIV_MASK, SCU1_CLK_I3C_DIV(4));
+	writel(reg_284, &scu->clk_sel2);
+}
+
+static int ast2700_clk1_init(struct udevice *dev)
+{
+	struct ast2700_clk_priv *priv = dev_get_priv(dev);
+	struct ast2700_scu1 *scu = (struct ast2700_scu1 *)priv->reg;
+
+	ast2700_init_spi(scu);
+	ast2700_init_mac_clk(scu);
+	ast2700_init_rgmii_clk(scu);
+	ast2700_init_rmii_clk(scu);
+	ast2700_init_sdclk(scu);
+	ast2700_init_i3c_clk(scu);
+
+	return 0;
+}
+
+static int ast2700_clk0_init(struct udevice *dev)
+{
+	struct ast2700_clk_priv *priv = dev_get_priv(dev);
+	struct ast2700_scu0 *scu = (struct ast2700_scu0 *)priv->reg;
+
+	ast2700_emmc_init(scu);
+	ast2700_mphy_clk_init(scu);
+	ast2700_vga_clk_init(scu);
+
+	return 0;
+}
+
+static int ast2700_clk_probe(struct udevice *dev)
+{
+	struct ast2700_clk_priv *priv = dev_get_priv(dev);
+
+	priv->init = (ast2700_clk_init_fn)dev_get_driver_data(dev);
+	priv->reg =  (void __iomem *)dev_read_addr_ptr(dev);
+
+	if (priv->init)
+		return priv->init(dev);
+
+	return 0;
+}
+
+static int ast2700_clk_bind(struct udevice *dev)
+{
+	struct udevice *sysreset_dev, *rst_dev;
+	int ret;
+
+	/* The system reset driver does not have a device node, so bind it here */
+	ret = device_bind_driver(gd->dm_root, "ast_sysreset", "reset", &sysreset_dev);
+	if (ret)
+		debug("Warning: No sysreset driver: ret = %d\n", ret);
+
+	/* Bind the per-SCU reset controller to the same ofnode so that
+	 * <&syscon0/1 RESET_X> phandle references resolve to a UCLASS_RESET
+	 * device. This pairs with the airoha-style binding pattern.
+	 */
+	if (CONFIG_IS_ENABLED(RESET_AST2700)) {
+		ret = device_bind_driver_to_node(dev, "ast2700_reset", "reset",
+						 dev_ofnode(dev), &rst_dev);
+		if (ret)
+			debug("Warning: failed to bind reset controller: ret = %d\n", ret);
+	}
+
+	return 0;
+}
+
+static const struct udevice_id ast2700_soc1_clk_ids[] = {
+	{ .compatible = "aspeed,ast2700-scu1", .data = (ulong)&ast2700_clk1_init },
+	{ },
+};
+
+U_BOOT_DRIVER(aspeed_ast2700_soc1_clk) = {
+	.name = "aspeed_ast2700_scu1",
+	.id = UCLASS_CLK,
+	.of_match = ast2700_soc1_clk_ids,
+	.priv_auto = sizeof(struct ast2700_clk_priv),
+	.ops = &ast2700_soc1_clk_ops,
+	.probe = ast2700_clk_probe,
+	.bind = ast2700_clk_bind,
+};
+
+static const struct udevice_id ast2700_soc0_clk_ids[] = {
+	{ .compatible = "aspeed,ast2700-scu0", .data = (ulong)&ast2700_clk0_init },
+	{ },
+};
+
+U_BOOT_DRIVER(aspeed_ast2700_soc0_clk) = {
+	.name = "aspeed_ast2700_scu0",
+	.id = UCLASS_CLK,
+	.of_match = ast2700_soc0_clk_ids,
+	.priv_auto = sizeof(struct ast2700_clk_priv),
+	.ops = &ast2700_soc0_clk_ops,
+	.probe = ast2700_clk_probe,
+	.bind = ast2700_clk_bind,
+};

---
base-commit: e08877916e24cf97d3afc67aee65ed2204790f48
change-id: 20260327-ast2700_clk-258eacb9d703

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>

