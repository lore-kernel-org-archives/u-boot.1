Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19B7CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E777E84940;
	Tue, 26 May 2026 02:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992618495A; Tue, 26 May 2026 02:36:51 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6E384913
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 26 May
 2026 08:36:41 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 26 May 2026 08:36:41 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 26 May 2026 08:36:38 +0800
Subject: [PATCH v3 1/5] arm: aspeed: add ASPEED AST2700 SoC family support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260526-ast2700_clk-v3-1-a4cd24c214d6@aspeedtech.com>
References: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
In-Reply-To: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Chia-Wei
 Wang" <chiawei_wang@aspeedtech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Andre Przywara
 <andre.przywara@arm.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>, "Johan
 Jonker" <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David
 Lechner <dlechner@baylibre.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, Paul
 Kocialkowski <contact@paulk.fr>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, "Kuan-Wei
 Chiu" <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 "Quentin Schulz" <quentin.schulz@cherry.de>, Stefan Roese
 <stefan.roese@mailbox.org>, Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779755800; l=43982;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=dwxSwRSVXESueS4VwsmvUWaomBd7s9AoA/b8/TrGxgs=;
 b=muBQ/HIyc9YLNqszAsrUQjwa3Jz2jvOBLsYk1W63dJNKcslf199UeorLTG9hJWRUO4cfIUIwh
 7hF1YIwJOq2C79rzStw6+7NRzz3XHxJJ/IVbDD31NfZsExqub0ou7EG
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Tue, 26 May 2026 02:42:34 +0200
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

Add initial support for the ASPEED AST2700, an arm64 (Cortex-A35)
Baseboard Management Controller (BMC) SoC. AST2700 is Aspeed's 8th
generation BMC and uses a dual-die architecture: SoC0 (the "CPU"
die) hosts the four Cortex-A35 cores and its own SCU at 0x12c02000,
while SoC1 (the "IO" die) hosts the peripherals and its own SCU at
0x14c02000.

This commit adds:
  - ASPEED_AST2700 Kconfig option and the ast2700 mach subdir
    (mach Makefile, ast2700/Kconfig, board/aspeed/evb_ast2700/*)
  - arm64 MMU map covering the SoC device window and the DRAM
    region at 0x4_0000_0000 (up to 8 GiB)
  - lowlevel_init.S for early CPU bring-up
  - cpu-info: print SoC ID (AST2700/2720/2750 A0/A1/A2 variants)
    and reset cause (cold reset, EXT reset, WDT reset)
  - board_common: dram_init via UCLASS_RAM, AHBC timeout init
  - platform: env_get_location() that selects SPI/eMMC based on
    the IO-die HW strap; arch_misc_init() that exposes
    ${boot_device} and ${verify} to the boot script
  - SCU0/SCU1 register layout header (scu_ast2700.h)
  - configs/evb-ast2700_defconfig and include/configs/evb_ast2700.h
    for the AST2700 EVB board

The defconfig depends on ast2700-evb.dts, which is introduced in
a subsequent patch; this commit must be applied with the
remaining series for evb-ast2700_defconfig to build.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 MAINTAINERS                                    |   1 +
 arch/arm/include/asm/arch-aspeed/platform.h    |  30 +-
 arch/arm/include/asm/arch-aspeed/scu_ast2700.h | 514 +++++++++++++++++++++++++
 arch/arm/mach-aspeed/Kconfig                   |  11 +
 arch/arm/mach-aspeed/Makefile                  |   1 +
 arch/arm/mach-aspeed/ast2700/Kconfig           |  36 ++
 arch/arm/mach-aspeed/ast2700/Makefile          |   2 +
 arch/arm/mach-aspeed/ast2700/arm64-mmu.c       |  43 +++
 arch/arm/mach-aspeed/ast2700/board_common.c    |  90 +++++
 arch/arm/mach-aspeed/ast2700/cpu-info.c        | 114 ++++++
 arch/arm/mach-aspeed/ast2700/lowlevel_init.S   | 132 +++++++
 arch/arm/mach-aspeed/ast2700/platform.c        |  64 +++
 board/aspeed/evb_ast2700/Kconfig               |  13 +
 board/aspeed/evb_ast2700/Makefile              |   1 +
 board/aspeed/evb_ast2700/evb_ast2700.c         |   5 +
 configs/evb-ast2700_defconfig                  | 149 +++++++
 include/configs/evb_ast2700.h                  |  58 +++
 17 files changed, 1263 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea646f618a5..87c25dde7be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -224,6 +224,7 @@ F:	drivers/ram/aspeed/
 F:	drivers/reset/reset-ast2500.c
 F:	drivers/watchdog/ast_wdt.c
 N:	aspeed
+N:	ast2700
 
 ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
diff --git a/arch/arm/include/asm/arch-aspeed/platform.h b/arch/arm/include/asm/arch-aspeed/platform.h
index 589abd4a3f6..82699c03c00 100644
--- a/arch/arm/include/asm/arch-aspeed/platform.h
+++ b/arch/arm/include/asm/arch-aspeed/platform.h
@@ -18,8 +18,36 @@
 #define ASPEED_DRAM_BASE	0x80000000
 #define ASPEED_SRAM_BASE	0x10000000
 #define ASPEED_SRAM_SIZE	0x16000
+#elif defined(CONFIG_ASPEED_AST2700)
+#define ASPEED_CPU_AHBC_BASE	0x12000000
+#define ASPEED_CPU_REVISION_ID	0x12C02000
+#define ASPEED_CPU_SCU_BASE	0x12C02000
+#define ASPEED_CPU_HW_STRAP1	0x12C02010
+#define ASPEED_CPU_RESET_LOG1	0x12C02050
+#define ASPEED_CPU_RESET_LOG2	0x12C02060
+#define ASPEED_CPU_RESET_LOG3	0x12C02070
+#define ASPEED_MAC_COUNT	3
+#define ASPEED_DRAM_BASE	0x400000000
+#define ASPEED_SRAM_BASE	0x10000000
+#define ASPEED_SRAM_SIZE	0x20000
+#define ASPEED_FMC_REG_BASE	0x14000000
+#define ASPEED_FMC_CS0_BASE	0x100000000
+#define ASPEED_FMC_CS0_SIZE	0x80000000
+#define ASPEED_IO_MAC0_BASE	0x14050000
+#define ASPEED_IO_MAC1_BASE	0x14060000
+#define ASPEED_IO_AHBC_BASE	0x140b0000
+#define ASPEED_IO_REVISION_ID	0x14C02000
+#define CHIP_AST2700A1_ID_MASK	BIT(16)
+#define ASPEED_IO_SCU_BASE	0x14C02000
+#define ASPEED_IO_HW_STRAP1	0x14C02010
+#define ASPEED_IO_RESET_LOG1	0x14C02050
+#define ASPEED_IO_RESET_LOG2	0x14C02060
+#define ASPEED_IO_RESET_LOG3	0x14C02070
+#define ASPEED_IO_RESET_LOG4	0x14C02080
+#define ASPEED_IO_GPIO_BASE	0x14C0B000
+#define ASPEED_WDTA_BASE	0x14C37400
 #else
-#err "Unrecognized Aspeed platform."
+#error "Unrecognized Aspeed platform."
 #endif
 
 #endif
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
diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index c88b1e59366..f4b038ebd9e 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -36,9 +36,20 @@ config ASPEED_AST2600
 	  It is used as Board Management Controller on many server boards,
 	  which is enabled by support of LPC and eSPI peripherals.
 
+config ASPEED_AST2700
+	bool "Support Aspeed AST2700 SoC"
+	select ARM64
+	select SYS_ARCH_TIMER
+	help
+	  Support for the Aspeed AST2700, an arm64 (Cortex-A35) Baseboard
+	  Management Controller (BMC) SoC. This is the 8th-generation BMC
+	  SoC family from Aspeed and features a dual-die architecture
+	  (CPU die + I/O die) connected via an internal coherent bus.
+
 endchoice
 
 source "arch/arm/mach-aspeed/ast2500/Kconfig"
 source "arch/arm/mach-aspeed/ast2600/Kconfig"
+source "arch/arm/mach-aspeed/ast2700/Kconfig"
 
 endif
diff --git a/arch/arm/mach-aspeed/Makefile b/arch/arm/mach-aspeed/Makefile
index 42599c125b8..d0b4eb74c6c 100644
--- a/arch/arm/mach-aspeed/Makefile
+++ b/arch/arm/mach-aspeed/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_ARCH_ASPEED) += ast_wdt.o
 obj-$(CONFIG_ASPEED_AST2500) += ast2500/
 obj-$(CONFIG_ASPEED_AST2600) += ast2600/
+obj-$(CONFIG_ASPEED_AST2700) += ast2700/
diff --git a/arch/arm/mach-aspeed/ast2700/Kconfig b/arch/arm/mach-aspeed/ast2700/Kconfig
new file mode 100644
index 00000000000..3dd68db76db
--- /dev/null
+++ b/arch/arm/mach-aspeed/ast2700/Kconfig
@@ -0,0 +1,36 @@
+if ASPEED_AST2700
+
+config SYS_CPU
+	default "armv8"
+
+config SPI_KERNEL_FIT_ADDR
+	hex "SPI address of kernel FIT image"
+	default 0x100420000
+	help
+	  Address in the SPI flash where the kernel FIT image is stored.
+	  Used by the bootspi command to load and boot the kernel image
+	  from the SPI flash on AST2700 platforms.
+
+choice
+	prompt "AST2700 board select"
+	depends on ASPEED_AST2700
+	default TARGET_EVB_AST2700
+	help
+	  Select the AST2700 board model. Each board option configures
+	  the board-specific Kconfig, defaults and devicetree.
+
+config TARGET_EVB_AST2700
+	bool "EVB-AST2700"
+	depends on ASPEED_AST2700
+	select ARCH_MISC_INIT
+	help
+	  EVB-AST2700 is Aspeed evaluation board for AST2700A0 chip.
+	  It has 512M of RAM, 32M of SPI flash, two Ethernet ports,
+	  4 Serial ports, 4 USB ports, VGA port, PCIe, SD card slot,
+	  20 pin JTAG, pinouts for 14 I2Cs, 3 SPIs and eSPI, 8 PWMs.
+
+endchoice
+
+source "board/aspeed/evb_ast2700/Kconfig"
+
+endif
diff --git a/arch/arm/mach-aspeed/ast2700/Makefile b/arch/arm/mach-aspeed/ast2700/Makefile
new file mode 100644
index 00000000000..38bd52f3d5d
--- /dev/null
+++ b/arch/arm/mach-aspeed/ast2700/Makefile
@@ -0,0 +1,2 @@
+obj-y   += lowlevel_init.o board_common.o arm64-mmu.o platform.o
+obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
diff --git a/arch/arm/mach-aspeed/ast2700/arm64-mmu.c b/arch/arm/mach-aspeed/ast2700/arm64-mmu.c
new file mode 100644
index 00000000000..a068e6ede97
--- /dev/null
+++ b/arch/arm/mach-aspeed/ast2700/arm64-mmu.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
+#include <dm.h>
+#include <asm/armv8/mmu.h>
+
+static struct mm_region aspeed2700_mem_map[] = {
+	{
+		.virt =         0x0UL,
+		.phys =         0x0UL,
+		.size =  0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN,
+	},
+	{
+		.virt =  0x40000000UL,
+		.phys =  0x40000000UL,
+		.size = 0x2C0000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE,
+	},
+	{
+		.virt = 0x400000000UL,
+		.phys = 0x400000000UL,
+		.size = 0x200000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	},
+	{
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = aspeed2700_mem_map;
+
+u64 get_page_table_size(void)
+{
+	return 0x80000;
+}
diff --git a/arch/arm/mach-aspeed/ast2700/board_common.c b/arch/arm/mach-aspeed/ast2700/board_common.c
new file mode 100644
index 00000000000..6d2160bbca4
--- /dev/null
+++ b/arch/arm/mach-aspeed/ast2700/board_common.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
+#include <dm.h>
+#include <ram.h>
+#include <init.h>
+#include <timer.h>
+#include <asm/io.h>
+#include <asm/arch/timer.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <dm/uclass.h>
+#include <asm/arch-aspeed/scu_ast2700.h>
+
+#define AHBC_GROUP(x)				(0x40 * (x))
+#define AHBC_HREADY_WAIT_CNT_REG		0x34
+#define   AHBC_HREADY_WAIT_CNT_MAX		0x3f
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	int ret;
+	struct udevice *dev;
+	struct ram_info ram;
+
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret) {
+		printf("cannot get DRAM driver\n");
+		debug("cannot get DRAM driver\n");
+		return ret;
+	}
+
+	ret = ram_get_info(dev, &ram);
+	if (ret) {
+		debug("cannot get DRAM information\n");
+		return ret;
+	}
+
+	gd->ram_size = ram.size;
+
+	return 0;
+}
+
+static void ahbc_init(void)
+{
+	u32 reg_val;
+	int i;
+
+	reg_val = readl(ASPEED_CPU_REVISION_ID);
+	if (FIELD_GET(SCU_CPU_REVISION_ID_HW, reg_val))
+		return;
+
+	/* CPU-die AHBC timeout counter */
+	for (i = 0; i < 4; i++)
+		writel(AHBC_HREADY_WAIT_CNT_MAX,
+		       (void *)ASPEED_CPU_AHBC_BASE + AHBC_GROUP(i) + AHBC_HREADY_WAIT_CNT_REG);
+
+	/* IO-die AHBC timeout counter */
+	for (i = 0; i < 8; i++)
+		writel(AHBC_HREADY_WAIT_CNT_MAX,
+		       (void *)ASPEED_IO_AHBC_BASE + AHBC_GROUP(i) + AHBC_HREADY_WAIT_CNT_REG);
+}
+
+int board_init(void)
+{
+	struct udevice *dev;
+	int i = 0;
+	int ret;
+
+	ahbc_init();
+
+	/*
+	 * Loop over all MISC uclass drivers to call the comphy code
+	 * and init all CP110 devices enabled in the DT
+	 */
+	while (1) {
+		/* Call the comphy code via the MISC uclass driver */
+		ret = uclass_get_device(UCLASS_MISC, i++, &dev);
+
+		/* We're done, once no further CP110 device is found */
+		if (ret)
+			break;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-aspeed/ast2700/cpu-info.c b/arch/arm/mach-aspeed/ast2700/cpu-info.c
new file mode 100644
index 00000000000..7f29c4d8c33
--- /dev/null
+++ b/arch/arm/mach-aspeed/ast2700/cpu-info.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ * Ryan Chen <ryan_chen@aspeedtech.com>
+ */
+
+#include <command.h>
+#include <asm/io.h>
+#include <asm/arch/platform.h>
+#include <asm/arch/scu_ast2700.h>
+
+/* SoC mapping Table */
+#define SOC_ID(str, rev) { .name = str, .rev_id = rev, }
+
+struct soc_id {
+	const char *name;
+	u64 rev_id;
+};
+
+static struct soc_id soc_map_table[] = {
+	SOC_ID("AST2750-A0", 0x0600000306000003),
+	SOC_ID("AST2700-A0", 0x0600010306000103),
+	SOC_ID("AST2720-A0", 0x0600020306000203),
+	SOC_ID("AST2750-A1", 0x0601000306010003),
+	SOC_ID("AST2700-A1", 0x0601010306010103),
+	SOC_ID("AST2720-A1", 0x0601020306010203),
+	SOC_ID("AST2750-A2", 0x0602000306020003),
+	SOC_ID("AST2700-A2", 0x0602010306020103),
+	SOC_ID("AST2720-A2", 0x0602020306020203),
+};
+
+void ast2700_print_soc_id(void)
+{
+	int i;
+	u64 rev_id;
+
+	rev_id = readl(ASPEED_CPU_REVISION_ID);
+	rev_id = ((u64)readl(ASPEED_IO_REVISION_ID) << 32) | rev_id;
+
+	for (i = 0; i < ARRAY_SIZE(soc_map_table); i++) {
+		if (rev_id == soc_map_table[i].rev_id)
+			break;
+	}
+	if (i == ARRAY_SIZE(soc_map_table))
+		printf("Unknown-SOC: %llx\n", rev_id);
+	else
+		printf("SOC: %4s\n", soc_map_table[i].name);
+}
+
+#define SYS_DRAM_ECCRST	BIT(3)
+#define SYS_ABRRST		BIT(2)
+#define SYS_EXTRST		BIT(1)
+#define SYS_SRST		BIT(0)
+
+#define WDT_RST_BIT_MASK(s)	(GENMASK(3, 0) << (s))
+#define BIT_WDT_FULL(s)		(BIT(0) << (s))
+#define BIT_WDT_ARM(s)		(BIT(1) << (s))
+#define BIT_WDT_SOC(s)		(BIT(2) << (s))
+#define BIT_WDT_SW(s)		(BIT(3) << (s))
+
+void ast2700_print_wdtrst_info(void)
+{
+	u32 wdt_rst = readl(ASPEED_IO_RESET_LOG4);
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		if (wdt_rst & WDT_RST_BIT_MASK(i * 4)) {
+			printf("RST: WDT%d ", i);
+			if (wdt_rst & BIT_WDT_SOC(i * 4)) {
+				printf("SOC ");
+				writel(BIT_WDT_SOC(i * 4), ASPEED_IO_RESET_LOG4);
+			}
+			if (wdt_rst & BIT_WDT_FULL(i * 4)) {
+				printf("FULL ");
+				writel(BIT_WDT_FULL(i * 4), ASPEED_IO_RESET_LOG4);
+			}
+			if (wdt_rst & BIT_WDT_ARM(i * 4)) {
+				printf("ARM ");
+				writel(BIT_WDT_ARM(i * 4), ASPEED_IO_RESET_LOG4);
+			}
+			if (wdt_rst & BIT_WDT_SW(i * 4)) {
+				printf("SW ");
+				writel(BIT_WDT_SW(i * 4), ASPEED_IO_RESET_LOG4);
+			}
+			printf("\n");
+		}
+	}
+}
+
+#define SYS_EXTRST		BIT(1)
+#define SYS_SRST		BIT(0)
+
+void ast2700_print_sysrst_info(void)
+{
+	u32 sys_rst = readl(ASPEED_CPU_RESET_LOG1);
+
+	if (sys_rst & SYS_SRST) {
+		printf("RST: Power On\n");
+		writel(SYS_SRST, ASPEED_CPU_RESET_LOG1);
+	} else if (sys_rst & SYS_EXTRST) {
+		printf("RST: EXTRST\n");
+		writel(SYS_EXTRST, ASPEED_CPU_RESET_LOG1);
+	} else {
+		ast2700_print_wdtrst_info();
+	}
+}
+
+int print_cpuinfo(void)
+{
+	ast2700_print_soc_id();
+	ast2700_print_sysrst_info();
+
+	return 0;
+}
diff --git a/arch/arm/mach-aspeed/ast2700/lowlevel_init.S b/arch/arm/mach-aspeed/ast2700/lowlevel_init.S
new file mode 100644
index 00000000000..9b78fed0b26
--- /dev/null
+++ b/arch/arm/mach-aspeed/ast2700/lowlevel_init.S
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) ASPEED Technology Inc.
+ */
+#include <config.h>
+#include <linux/linkage.h>
+
+/*
+ *        SMP mailbox
+ * +-----------------------+ 0x40
+ * |                       |
+ * | mailbox insn. for     |
+ * | cpuN GO sign polling  |
+ * |                       |
+ * +-----------------------+ 0x20
+ * | cpu3 entrypoint       |
+ * +-----------------------+ 0x18
+ * | cpu2 entrypoint       |
+ * +-----------------------+ 0x10
+ * | cpu1 entrypoint       |
+ * +-----------------------+ 0x8
+ * | reserved              |
+ * +-----------------------+ 0x4
+ * | mailbox ready         |
+ * +-----------------------+ SCU_CPU + 0x780
+ */
+
+#define SCU_CPU_BASE		0x12c02000
+#define SCU_CPU_SMP_READY	(SCU_CPU_BASE + 0x780)
+#define SCU_CPU_SMP_EP1		(SCU_CPU_BASE + 0x788)
+#define SCU_CPU_SMP_EP2		(SCU_CPU_BASE + 0x790)
+#define SCU_CPU_SMP_EP3		(SCU_CPU_BASE + 0x798)
+#define SCU_CPU_SMP_POLLINSN	(SCU_CPU_BASE + 0x7a0)
+
+ENTRY(lowlevel_init)
+	/* backup LR */
+	mov	x29, lr
+
+#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
+	/* reset SMP mailbox ASAP */
+	ldr	x0, =SCU_CPU_SMP_READY
+	str	wzr, [x0]
+
+	/*
+	 * get cpu core id
+	 *
+	 * ast2700 has 1-cluster, 4-cores CPU topology.
+	 * Affinity level 0 in MPIDR is sufficient.
+	 */
+	mrs	x4, mpidr_el1
+	ands	x4, x4, #0xff
+
+	/* cpu0 is the primary core to setup SMP mailbox */
+	beq	do_primary_core_setup
+
+	/* hold cpuN until mailbox is ready */
+	ldr	x0, =SCU_CPU_SMP_READY
+	movz	w1, #0xcafe
+	movk	w1, #0xbabe, lsl #16
+
+poll_mailbox_ready:
+	wfe
+	ldr	w2, [x0]
+	cmp	w1, w2
+	bne	poll_mailbox_ready
+
+	/*
+	 * parameters for relocated SMP go polling insn.
+	 *  x4 = cpu id
+	 *  x5 = SCU_CPU_SMP_EPx
+	 */
+	add	x5, x0, x4, lsl #3
+
+	/* jump to the polling loop in SMP mailbox, no return */
+	ldr	x0, =SCU_CPU_SMP_POLLINSN
+	br	x0
+
+do_primary_core_setup:
+	/* relocate mailbox insn. for cpuN to poll for SMP go signal */
+	adr	x0, smp_mbox_insn
+	adr	x1, smp_mbox_insn_end
+	ldr	x2, =SCU_CPU_SMP_POLLINSN
+
+relocate_smp_mbox_insn:
+	ldr	w3, [x0], #0x4
+	str	w3, [x2], #0x4
+	cmp	x0, x1
+	bne relocate_smp_mbox_insn
+
+	/* reset cpuN entrypoints */
+	ldr	x0, =SCU_CPU_SMP_EP1
+	str	xzr, [x0], #8
+	str	xzr, [x0], #8
+	str	xzr, [x0]
+
+	/* notify cpuN that SMP mailbox is ready */
+	movz	w0, #0xcafe
+	movk	w0, #0xbabe, lsl #16
+	ldr	x1, =SCU_CPU_SMP_READY
+	str	w0, [x1]
+
+	sev
+#endif	/* !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) */
+
+	/* back to arch calling code */
+	mov	lr, x29
+	ret
+ENDPROC(lowlevel_init)
+
+/*
+ * insn. inside mailbox to poll SMP go signal.
+ *
+ * Note that this code will be relocated, any absolute
+ * addressing should NOT be used.
+ */
+smp_mbox_insn:
+	/*
+	 * x4 = cpu id
+	 * x5 = SCU_CPU_SMP_EPx
+	 */
+poll_smp_mbox_go:
+	wfe
+	ldr	x0, [x5]
+	cmp	x0, xzr
+	beq	poll_smp_mbox_go
+
+	/* jump to secondary core entrypoint */
+	br	x0
+
+smp_mbox_insn_end:
+	/* should never reach */
+	b	.
diff --git a/arch/arm/mach-aspeed/ast2700/platform.c b/arch/arm/mach-aspeed/ast2700/platform.c
new file mode 100644
index 00000000000..9cca85766f6
--- /dev/null
+++ b/arch/arm/mach-aspeed/ast2700/platform.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
+#include <dm.h>
+#include <asm/arch-aspeed/scu_ast2700.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <env.h>
+#include <env_internal.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	enum env_location env_loc = ENVL_UNKNOWN;
+	u32 strap = readl(ASPEED_IO_HW_STRAP1);
+
+	if (prio)
+		return env_loc;
+
+	if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE)) {
+		env_loc = ENVL_NOWHERE;
+	} else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH) &&
+		   !(strap & SCU_IO_HWSTRAP_EMMC)) {
+		env_loc = ENVL_SPI_FLASH;
+	} else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
+		   (strap & SCU_IO_HWSTRAP_EMMC) &&
+		   !(strap & SCU_IO_HWSTRAP_UFS)) {
+		env_loc = ENVL_MMC;
+	} else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH)) {
+		/*
+		 * This tree does not carry an ENV_IS_IN_UFS backend yet.
+		 * Fall back to SPI flash when that backend exists.
+		 */
+		env_loc = ENVL_SPI_FLASH;
+	} else {
+		env_loc = ENVL_NOWHERE;
+	}
+
+	return env_loc;
+}
+
+int arch_misc_init(void)
+{
+	if (IS_ENABLED(CONFIG_ARCH_MISC_INIT)) {
+		if ((readl(ASPEED_IO_HW_STRAP1) & SCU_IO_HWSTRAP_EMMC)) {
+			if ((readl(ASPEED_IO_HW_STRAP1) & SCU_IO_HWSTRAP_UFS))
+				env_set("boot_device", "ufs");
+			else
+				env_set("boot_device", "mmc");
+		} else {
+			env_set("boot_device", "spi");
+		}
+
+		if ((readl(ASPEED_IO_HW_STRAP1) & SCU_IO_HWSTRAP_SECBOOT))
+			env_set("verify", "yes");
+		else
+			env_set("verify", "no");
+	}
+
+	return 0;
+}
diff --git a/board/aspeed/evb_ast2700/Kconfig b/board/aspeed/evb_ast2700/Kconfig
new file mode 100644
index 00000000000..ede9eb7fb85
--- /dev/null
+++ b/board/aspeed/evb_ast2700/Kconfig
@@ -0,0 +1,13 @@
+if TARGET_EVB_AST2700
+
+config SYS_BOARD
+	default "evb_ast2700"
+
+config SYS_VENDOR
+	default "aspeed"
+
+config SYS_CONFIG_NAME
+	string "board configuration name"
+	default "evb_ast2700"
+
+endif
diff --git a/board/aspeed/evb_ast2700/Makefile b/board/aspeed/evb_ast2700/Makefile
new file mode 100644
index 00000000000..0c29700f5a9
--- /dev/null
+++ b/board/aspeed/evb_ast2700/Makefile
@@ -0,0 +1 @@
+obj-y += evb_ast2700.o
diff --git a/board/aspeed/evb_ast2700/evb_ast2700.c b/board/aspeed/evb_ast2700/evb_ast2700.c
new file mode 100644
index 00000000000..b34aa6e1682
--- /dev/null
+++ b/board/aspeed/evb_ast2700/evb_ast2700.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
diff --git a/configs/evb-ast2700_defconfig b/configs/evb-ast2700_defconfig
new file mode 100644
index 00000000000..f89d176419c
--- /dev/null
+++ b/configs/evb-ast2700_defconfig
@@ -0,0 +1,149 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+# CONFIG_INIT_SP_RELATIVE is not set
+CONFIG_ARM_SMCCC=y
+CONFIG_ARCH_ASPEED=y
+CONFIG_TEXT_BASE=0x400000000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_ASPEED_AST2700=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x403000000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x400000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="ast2700-evb"
+CONFIG_DM_RESET=y
+CONFIG_SYS_LOAD_ADDR=0x403000000
+CONFIG_DEBUG_UART_BASE=0x14c33b00
+CONFIG_DEBUG_UART_CLOCK=1846154
+# CONFIG_PSCI_RESET is not set
+CONFIG_ARMV8_CRYPTO=y
+CONFIG_ENV_ADDR=0x400000
+CONFIG_SYS_PCI_64BIT=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_SYS_MEMTEST_START=0x403000000
+CONFIG_SYS_MEMTEST_END=0x403001000
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+# CONFIG_BOOTMETH_EFILOADER is not set
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS12,115200n8 root=/dev/ram rw earlycon"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="echo Boot from ${boot_device}; if test ${boot_device} = mmc; then run bootmmc; fi; if test ${boot_device} = spi; then run bootspi; fi; if test ${boot_device} = ufs; then run bootufs; fi;"
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+# CONFIG_AUTO_COMPLETE is not set
+# CONFIG_CMD_CONSOLE is not set
+# CONFIG_CMD_BOOTFLOW is not set
+CONFIG_CMD_BOOTZ=y
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_BOOTEFI is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_EEPROM=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+# CONFIG_CMD_LZMADEC is not set
+# CONFIG_CMD_UNLZ4 is not set
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_UFS=y
+CONFIG_CMD_NCSI=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+# CONFIG_CMD_EFICONFIG is not set
+CONFIG_CMD_TPM=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_CMD_CYCLIC is not set
+CONFIG_DOS_PARTITION=y
+CONFIG_EFI_PARTITION=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_MMC_USE_DT=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="ast2700-evb"
+CONFIG_BOOTP_SEND_HOSTNAME=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DM_HASH=y
+CONFIG_DFU_RAM=y
+CONFIG_GPIO_HOG=y
+CONFIG_ASPEED_G7_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_AST2600=y
+# CONFIG_INPUT is not set
+CONFIG_DM_MAILBOX=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ASPEED=y
+CONFIG_MTD=y
+CONFIG_SPI_FLASH=y
+CONFIG_DM_MDIO=y
+CONFIG_FTGMAC100=y
+CONFIG_ASPEED_MDIO=y
+CONFIG_PHY_BROADCOM=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_NCSI=y
+CONFIG_DM_PCI_COMPAT=y
+CONFIG_PCI_CONFIG_HOST_BRIDGE=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_RAM=y
+CONFIG_SCSI=y
+CONFIG_DM_SERIAL=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SPI_ASPEED_SMC=y
+CONFIG_SYSRESET=y
+# CONFIG_TPM_V1 is not set
+CONFIG_TPM2_TIS_SPI=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="ASPEED"
+CONFIG_USB_GADGET_VENDOR_NUM=0x2245
+CONFIG_USB_GADGET_PRODUCT_NUM=0x2700
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_UFS=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+# CONFIG_WDT_ASPEED is not set
+CONFIG_ECDSA=y
+CONFIG_ECDSA_VERIFY=y
+CONFIG_TPM=y
+CONFIG_LZ4=y
+CONFIG_LZMA=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/include/configs/evb_ast2700.h b/include/configs/evb_ast2700.h
new file mode 100644
index 00000000000..6b73eddc1af
--- /dev/null
+++ b/include/configs/evb_ast2700.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <configs/aspeed-common.h>
+
+/* Extra ENV for Boot Command */
+#define STR_HELPER(n)	#n
+#define STR(n)		STR_HELPER(n)
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	"bootspi=fdt addr ${fdtspiaddr} && "				\
+		"fdt header get fitsize totalsize && "			\
+		"cp.b ${fdtspiaddr} ${loadaddr} ${fitsize} && "		\
+		"bootm ${loadaddr}; "					\
+		"echo Error loading kernel FIT image\0"			\
+	"loadaddr=" STR(CONFIG_SYS_LOAD_ADDR) "\0"			\
+	"bootside=a\0"							\
+	"rootfs=rofs-a\0"						\
+	"setmmcargs=setenv bootargs ${bootargs} "			\
+		"rootwait root=PARTLABEL=${rootfs}\0"			\
+	"boota=setenv bootpart 2; setenv rootfs rofs-a; "		\
+		"run setmmcargs; "					\
+		"ext4load mmc 0:${bootpart} ${loadaddr} fitImage && "	\
+		"bootm ${loadaddr}; "					\
+		"echo Error loading kernel FIT image\0"			\
+	"bootb=setenv bootpart 3; setenv rootfs rofs-b; "		\
+		"run setmmcargs; "					\
+		"ext4load mmc 0:${bootpart} ${loadaddr} fitImage && "	\
+		"bootm ${loadaddr}; "					\
+		"echo Error loading kernel FIT image\0"			\
+	"bootmmc=if test \"${bootside}\" = \"b\"; "			\
+		"then run bootb; run boota; "				\
+		"else run boota; run bootb; fi\0"			\
+	"setufsargs=setenv bootargs ${bootargs} "			\
+		"rootwait root=PARTLABEL=${rootfs}\0"			\
+	"ufsboota=setenv bootpart 2; setenv rootfs rofs-a; "		\
+		"run setufsargs; "					\
+		"ext4load scsi 0:${bootpart} ${loadaddr} fitImage && "	\
+		"bootm ${loadaddr}; "					\
+		"echo Error loading kernel FIT image\0"			\
+	"ufsbootb=setenv bootpart 3; setenv rootfs rofs-b; "		\
+		"run setufsargs; "					\
+		"ext4load scsi 0:${bootpart} ${loadaddr} fitImage && "	\
+		"bootm ${loadaddr}; "					\
+		"echo Error loading kernel FIT image\0"			\
+	"bootufs=if test \"${bootside}\" = \"b\"; "			\
+		"then run ufsbootb; run ufsboota; "			\
+		"else run ufsboota; run ufsbootb; fi\0"			\
+	"verify=no\0"							\
+	""
+#endif	/* __CONFIG_H */

-- 
2.34.1

