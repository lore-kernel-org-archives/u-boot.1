Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77E2CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 12:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83EDE84815;
	Wed, 20 May 2026 14:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBD98460E; Wed, 20 May 2026 10:25:00 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85A6846AD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 20 May
 2026 16:24:49 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 20 May 2026 16:24:49 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 20 May 2026 16:24:52 +0800
Subject: [PATCH v2 5/5] ram: aspeed: add SDRAM controller driver for
 AST2700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260520-ast2700_clk-v2-5-c778b2908e5e@aspeedtech.com>
References: <20260520-ast2700_clk-v2-0-c778b2908e5e@aspeedtech.com>
In-Reply-To: <20260520-ast2700_clk-v2-0-c778b2908e5e@aspeedtech.com>
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
 "Ryan Chen" <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779265488; l=16174;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=HMK+RNdvJKrPqnO+SNUZRZNI3rhTL8xi7pb+DSTdLZE=;
 b=3cO9hwrBQkUrlR0MWRDveaEJHySvMIKgIZDA9UwK/hfnRg38TDVXmAfbjOGxfr5+AxcoCVbUZ
 AsvSL52Smn1AQNj65Eq3YyXJ1bOoanAjqRKTSm9edqD4SlQ//kwAdCc
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Wed, 20 May 2026 14:49:56 +0200
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

Add a SDRAM controller driver for the AST2700, derived from the
existing AST2700 controller code used by the Ibex SPL but adapted
to run from ARM U-Boot proper on the Cortex-A35 cores.

The DDR4/DDR5 controller and its DesignWare PHY are programmed by
the Ibex SPL before ARM U-Boot proper takes over. This driver
reads back the configuration left by the SPL, probes the
controller, and exposes ram_info (base and size, with the VGA
carve-out subtracted) via UCLASS_RAM so that dram_init() can
populate gd->ram_size.

The PHY firmware-load entry points (dwc_ddrphy_phyinit_userCustom_*)
are kept compiled but call a __weak fmc_hdr_get_prebuilt() stub
when ARM U-Boot proper is the caller; the real implementation is
provided by the Ibex SPL via the same fmc_hdr.h descriptor format
(here added for the ARM build).

Adds the supporting register-layout headers under
arch/arm/include/asm/arch-aspeed/:
  - sdram.h:   SDRAM controller and DWC PHY register definitions
  - scu.h:     SCU bits referenced by the SDRAM driver
  - fmc_hdr.h: prebuilt-blob descriptor (binary-compatible with
               arch/riscv/include/asm/arch-ast2700/fmc_hdr.h used
               by the Ibex SPL)

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm/include/asm/arch-aspeed/fmc_hdr.h |  52 +++++++++++
 arch/arm/include/asm/arch-aspeed/scu.h     | 145 +++++++++++++++++++++++++++++
 arch/arm/include/asm/arch-aspeed/sdram.h   | 137 +++++++++++++++++++++++++++
 drivers/ram/aspeed/Kconfig                 |   4 +-
 drivers/ram/aspeed/Makefile                |   2 +-
 drivers/ram/aspeed/sdram_ast2700.c         |  15 ++-
 6 files changed, 347 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/arch-aspeed/fmc_hdr.h b/arch/arm/include/asm/arch-aspeed/fmc_hdr.h
new file mode 100644
index 00000000000..c60277e1a81
--- /dev/null
+++ b/arch/arm/include/asm/arch-aspeed/fmc_hdr.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
+#ifndef __ASM_AST2700_FMC_HDR_H__
+#define __ASM_AST2700_FMC_HDR_H__
+
+#include <linux/types.h>
+
+#define HDR_MAGIC		0x48545341	/* ASTH */
+#define HDR_PB_MAX		30
+
+enum prebuilt_type {
+	PBT_END_MARK = 0x0,
+
+	PBT_DDR4_PMU_TRAIN_IMEM,
+	PBT_DDR4_PMU_TRAIN_DMEM,
+	PBT_DDR4_2D_PMU_TRAIN_IMEM,
+	PBT_DDR4_2D_PMU_TRAIN_DMEM,
+	PBT_DDR5_PMU_TRAIN_IMEM,
+	PBT_DDR5_PMU_TRAIN_DMEM,
+	PBT_DP_FW,
+	PBT_UEFI_X64_AST2700,
+
+	PBT_NUM
+};
+
+struct fmc_hdr_preamble {
+	u32 magic;
+	u32 version;
+};
+
+struct fmc_hdr_body {
+	u32 fmc_size;
+	union {
+		struct {
+			u32 type;
+			u32 size;
+		} pbs[0];
+		u32 raz[29];
+	};
+};
+
+struct fmc_hdr {
+	struct fmc_hdr_preamble preamble;
+	struct fmc_hdr_body body;
+} __packed;
+
+int fmc_hdr_get_prebuilt(u32 type, u32 *ofst, u32 *size);
+
+#endif
diff --git a/arch/arm/include/asm/arch-aspeed/scu.h b/arch/arm/include/asm/arch-aspeed/scu.h
new file mode 100644
index 00000000000..1aa7d38bace
--- /dev/null
+++ b/arch/arm/include/asm/arch-aspeed/scu.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) Aspeed Technology Inc.
+ */
+#ifndef __ASM_AST2700_SCU_H__
+#define __ASM_AST2700_SCU_H__
+
+/* SCU0: CPU-die SCU */
+#define SCU0_HWSTRAP				0x010
+#define   SCU0_HWSTRAP_DIS_RVAS			BIT(30)
+#define   SCU0_HWSTRAP_DIS_WDTFULL		BIT(25)
+#define   SCU0_HWSTRAP_DISARMICE_TZ		BIT(22)
+#define   SCU0_HWSTRAP_DISABLE_XHCI		BIT(21)
+#define   SCU0_HWSTRAP_BOOTEMMCSPEED		BIT(20)
+#define   SCU0_HWSTRAP_VGA_CC			BIT(18)
+#define   SCU0_HWSTRAP_EN_OPROM			BIT(17)
+#define   SCU0_HWSTRAP_DISARMICE		BIT(16)
+#define   SCU0_HWSTRAP_TSPRSNTSEL		BIT(9)
+#define   SCU0_HWSTRAP_DISDEBUG			BIT(8)
+#define   SCU0_HWSTRAP_HCLKHPLL			BIT(7)
+#define   SCU0_HWSTRAP_HCLKSEL			GENMASK(6, 5)
+#define   SCU0_HWSTRAP_CPUHPLL			BIT(4)
+#define   SCU0_HWSTRAP_HPLLFREQ			GENMASK(3, 2)
+#define   SCU0_HWSTRAP_BOOTSPI			BIT(1)
+#define   SCU0_HWSTRAP_HWSTRAP_DISCPU		BIT(0)
+#define SCU0_DBGCTL				0x0c8
+#define   SCU0_DBGCTL_MASK			GENMASK(14, 0)
+#define   SCU0_DBGCTL_UARTDBG			BIT(1)
+#define SCU0_RSTCTL1				0x200
+#define   SCU0_RSTCTL1_EMMC			BIT(17)
+#define   SCU0_RSTCTL1_HACE			BIT(4)
+#define SCU0_RSTCTL1_CLR			0x204
+#define   SCU0_RSTCTL1_CLR_EMMC			BIT(17)
+#define   SCU0_RSTCTL1_CLR_HACE			BIT(4)
+#define SCU0_CLKGATE1				0x240
+#define   SCU0_CLKGATE1_EMMC			BIT(27)
+#define   SCU0_CLKGATE1_HACE			BIT(13)
+#define   SCU0_CLKGATE1_DDRPHY			BIT(11)
+#define SCU0_CLKGATE1_CLR			0x244
+#define   SCU0_CLKGATE1_CLR_EMMC		BIT(27)
+#define   SCU0_CLKGATE1_CLR_HACE		BIT(13)
+#define   SCU0_CLKGATE1_CLR_DDRPHY		BIT(11)
+#define SCU0_VGA0_SCRATCH			0x900
+#define   SCU0_VGA0_SCRATCH_DRAM_INIT		BIT(6)
+#define SCU0_PCI_MISC70				0xa70
+#define   SCU0_PCI_MISC70_EN_PCIEXHCI0		BIT(3)
+#define   SCU0_PCI_MISC70_EN_PCIEEHCI0		BIT(2)
+#define   SCU0_PCI_MISC70_EN_PCIEVGA0		BIT(0)
+#define SCU0_PCI_MISC80				0xa80
+#define   SCU0_PCI_MISC80_EN_PCIEXHCI1		BIT(3)
+#define   SCU0_PCI_MISC80_EN_PCIEEHCI1		BIT(2)
+#define   SCU0_PCI_MISC80_EN_PCIEVGA1		BIT(0)
+#define SCU0_PCI_MISCF0				0xaf0
+#define   SCU0_PCI_MISCF0_EN_PCIEXHCI1		BIT(3)
+#define   SCU0_PCI_MISCF0_EN_PCIEEHCI1		BIT(2)
+#define   SCU0_PCI_MISCF0_EN_PCIEVGA1		BIT(0)
+#define SCU0_WPROT1				0xe04
+#define   SCU0_WPROT1_0C8			BIT(18)
+
+/* SCU1: IO-die SCU */
+#define SCU1_REVISION				0x000
+#define   SCU1_REVISION_HWID			GENMASK(23, 16)
+#define   SCU1_REVISION_CHIP_EFUSE		GENMASK(15, 8)
+#define SCU1_HWSTRAP1				0x010
+#define   SCU1_HWSTRAP1_DIS_CPTRA		BIT(30)
+#define   SCU1_HWSTRAP1_RECOVERY_USB_PORT	GENMASK(29, 28)
+#define   SCU1_HWSTRAP1_RECOVERY_INTERFACE	GENMASK(27, 26)
+#define   SCU1_HWSTRAP1_RECOVERY_I3C		(BIT(26) | BIT(27))
+#define   SCU1_HWSTRAP1_RECOVERY_I2C		BIT(27)
+#define   SCU1_HWSTRAP1_RECOVERY_USB		BIT(26)
+#define   SCU1_HWSTRAP1_SPI_FLASH_4_BYTE_MODE	BIT(25)
+#define   SCU1_HWSTRAP1_SPI_FLASH_WAIT_READY	BIT(24)
+#define   SCU1_HWSTRAP1_BOOT_UFS		BIT(23)
+#define   SCU1_HWSTRAP1_DIS_ROM			BIT(22)
+#define   SCU1_HWSTRAP1_DIS_CPTRAJTAG		BIT(20)
+#define   SCU1_HWSTRAP1_UARTDBGSEL		BIT(19)
+#define   SCU1_HWSTRAP1_DIS_UARTDBG		BIT(18)
+#define   SCU1_HWSTRAP1_DIS_WDTFULL		BIT(17)
+#define   SCU1_HWSTRAP1_DISDEBUG1		BIT(16)
+#define   SCU1_HWSTRAP1_LTPI0_IO_DRIVING	GENMASK(15, 14)
+#define   SCU1_HWSTRAP1_ACPI_1			BIT(13)
+#define   SCU1_HWSTRAP1_ACPI_0			BIT(12)
+#define   SCU1_HWSTRAP1_BOOT_EMMC_UFS		BIT(11)
+#define   SCU1_HWSTRAP1_DDR4			BIT(10)
+#define   SCU1_HWSTRAP1_LOW_SECURE		BIT(8)
+#define   SCU1_HWSTRAP1_EN_EMCS			BIT(7)
+#define   SCU1_HWSTRAP1_EN_GPIOPT		BIT(6)
+#define   SCU1_HWSTRAP1_EN_SECBOOT		BIT(5)
+#define   SCU1_HWSTRAP1_EN_RECOVERY_BOOT	BIT(4)
+#define   SCU1_HWSTRAP1_LTPI0_EN		BIT(3)
+#define   SCU1_HWSTRAP1_LTPI_IDX		BIT(2)
+#define   SCU1_HWSTRAP1_LTPI1_EN		BIT(1)
+#define   SCU1_HWSTRAP1_LTPI_MODE		BIT(0)
+#define SCU1_HWSTRAP2				0x030
+#define   SCU1_HWSTRAP2_FMC_ABR_SINGLE_FLASH	BIT(29)
+#define   SCU1_HWSTRAP2_FMC_ABR_CS_SWAP_DIS	BIT(28)
+#define   SCU1_HWSTRAP2_SPI_TPM_PCR_EXT_EN	BIT(27)
+#define   SCU1_HWSTRAP2_SPI_TPM_HASH_ALGO	GENMASK(26, 25)
+#define   SCU1_HWSTRAP2_BOOT_SPI_FREQ		GENMASK(24, 23)
+#define   SCU1_HWSTRAP2_RESERVED		GENMASK(22, 19)
+#define   SCU1_HWSTRAP2_FWSPI_CRTM		GENMASK(18, 17)
+#define   SCU1_HWSTRAP2_EN_FWSPIAUX		BIT(16)
+#define   SCU1_HWSTRAP2_FWSPISIZE		GENMASK(15, 13)
+#define   SCU1_HWSTRAP2_DIS_REC			BIT(12)
+#define   SCU1_HWSTRAP2_EN_CPTRA_DBG		BIT(11)
+#define   SCU1_HWSTRAP2_TPM_PCR_INDEX		GENMASK(6, 2)
+#define   SCU1_HWSTRAP2_ROM_CLEAR_SRAM		BIT(1)
+#define   SCU1_HWSTRAP2_ABR			BIT(0)
+#define SCU1_RSTLOG0				0x050
+#define   SCU1_RSTLOG0_BMC_CPU			BIT(12)
+#define   SCU1_RSTLOG0_ABR			BIT(2)
+#define   SCU1_RSTLOG0_EXTRSTN			BIT(1)
+#define   SCU1_RSTLOG0_SRST			BIT(0)
+#define SCU1_MISC1				0x0c0
+#define   SCU1_MISC1_UARTDBG_ROUTE		GENMASK(23, 22)
+#define   SCU1_MISC1_UART12_ROUTE		GENMASK(21, 20)
+#define SCU1_DBGCTL				0x0c8
+#define   SCU1_DBGCTL_MASK			GENMASK(7, 0)
+#define   SCU1_DBGCTL_UARTDBG			BIT(6)
+#define SCU1_RNG_DATA				0x0f4
+#define SCU1_RSTCTL1				0x200
+#define   SCU1_RSTCTL1_I3C(x)			(BIT(16) << (x))
+#define SCU1_RSTCTL1_CLR			0x204
+#define   SCU1_RSTCTL1_CLR_I3C(x)		(BIT(16) << (x))
+#define SCU1_RSTCTL2				0x220
+#define   SCU1_RSTCTL2_LTPI1			BIT(22)
+#define   SCU1_RSTCTL2_LTPI0			BIT(20)
+#define   SCU1_RSTCTL2_I2C			BIT(15)
+#define   SCU1_RSTCTL2_CPTRA			BIT(9)
+#define SCU1_RSTCTL2_CLR			0x224
+#define   SCU1_RSTCTL2_CLR_I2C			BIT(15)
+#define   SCU1_RSTCTL2_CLR_CPTRA		BIT(9)
+#define SCU1_CLKGATE1				0x240
+#define   SCU1_CLKGATE1_I3C(x)			(BIT(16) << (x))
+#define   SCU1_CLKGATE1_I2C			BIT(15)
+#define SCU1_CLKGATE1_CLR			0x244
+#define   SCU1_CLKGATE1_CLR_I3C(x)		(BIT(16) << (x))
+#define   SCU1_CLKGATE1_CLR_I2C			BIT(15)
+#define SCU1_CLKGATE2				0x260
+#define   SCU1_CLKGATE2_LTPI1_TX		BIT(19)
+#define   SCU1_CLKGATE2_LTPI_AHB		BIT(10)
+#define   SCU1_CLKGATE2_LTPI0_TX		BIT(9)
+#define SCU1_CLKGATE2_CLR			0x264
+
+#endif
diff --git a/arch/arm/include/asm/arch-aspeed/sdram.h b/arch/arm/include/asm/arch-aspeed/sdram.h
new file mode 100644
index 00000000000..daf48dd6ed1
--- /dev/null
+++ b/arch/arm/include/asm/arch-aspeed/sdram.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) Aspeed Technology Inc.
+ */
+#ifndef __ASM_AST2700_SDRAM_H__
+#define __ASM_AST2700_SDRAM_H__
+
+struct sdrammc_regs {
+	u32 prot_key;
+	u32 intr_status;
+	u32 intr_clear;
+	u32 intr_mask;
+	u32 mcfg;
+	u32 mctl;
+	u32 msts;
+	u32 error_status;
+	u32 actime1;
+	u32 actime2;
+	u32 actime3;
+	u32 actime4;
+	u32 actime5;
+	u32 actime6;
+	u32 actime7;
+	u32 dfi_timing;
+	u32 dcfg;
+	u32 dctl;
+	u32 mrctl;
+	u32 mrwr;
+	u32 mrrd;
+	u32 mr01;
+	u32 mr23;
+	u32 mr45;
+	u32 mr67;
+	u32 refctl;
+	u32 refmng_ctl;
+	u32 refsts;
+	u32 zqctl;
+	u32 ecc_addr_range;
+	u32 ecc_failure_status;
+	u32 ecc_failure_addr;
+	u32 ecc_test_control;
+	u32 ecc_test_status;
+	u32 arbctl;
+	u32 enccfg;
+	u32 protect_lock_set;
+	u32 protect_lock_status;
+	u32 protect_lock_reset;
+	u32 enc_min_addr;
+	u32 enc_max_addr;
+	u32 enc_key[4];
+	u32 enc_iv[3];
+	u32 bistcfg;
+	u32 bist_addr;
+	u32 bist_size;
+	u32 bist_patt;
+	u32 bist_res;
+	u32 bist_fail_addr;
+	u32 bist_fail_data[4];
+	u32 reserved2[2];
+	u32 debug_control;
+	u32 debug_status;
+	u32 phy_intf_status;
+	u32 testcfg;
+	u32 gfmcfg;
+	u32 gfm0ctl;
+	u32 gfm1ctl;
+	u32 reserved3[0xf8];
+};
+
+#define DRAMC_UNLK_KEY	0x1688a8a8
+
+/* offset 0x04 */
+#define DRAMC_IRQSTA_PWRCTL_ERR			BIT(16)
+#define DRAMC_IRQSTA_PHY_ERR			BIT(15)
+#define DRAMC_IRQSTA_LOWPOWER_DONE		BIT(12)
+#define DRAMC_IRQSTA_FREQ_CHG_DONE		BIT(11)
+#define DRAMC_IRQSTA_REF_DONE			BIT(10)
+#define DRAMC_IRQSTA_ZQ_DONE			BIT(9)
+#define DRAMC_IRQSTA_BIST_DONE			BIT(8)
+#define DRAMC_IRQSTA_ECC_RCVY_ERR		BIT(5)
+#define DRAMC_IRQSTA_ECC_ERR			BIT(4)
+#define DRAMC_IRQSTA_PROT_ERR			BIT(3)
+#define DRAMC_IRQSTA_OVERSZ_ERR			BIT(2)
+#define DRAMC_IRQSTA_MR_DONE			BIT(1)
+#define DRAMC_IRQSTA_PHY_INIT_DONE		BIT(0)
+
+/* offset 0x14 */
+#define DRAMC_MCTL_WB_SOFT_RESET		BIT(24)
+#define DRAMC_MCTL_PHY_CLK_DIS			BIT(18)
+#define DRAMC_MCTL_PHY_RESET			BIT(17)
+#define DRAMC_MCTL_PHY_POWER_ON			BIT(16)
+#define DRAMC_MCTL_FREQ_CHG_START		BIT(3)
+#define DRAMC_MCTL_PHY_LOWPOWER_START		BIT(2)
+#define DRAMC_MCTL_SELF_REF_START		BIT(1)
+#define DRAMC_MCTL_PHY_INIT_START		BIT(0)
+
+/* offset 0x40 */
+#define DRAMC_DFICFG_WD_POL			BIT(18)
+#define DRAMC_DFICFG_CKE_OUT			BIT(17)
+#define DRAMC_DFICFG_RESET			BIT(16)
+
+/* offset 0x48 */
+#define DRAMC_MRCTL_ERR_STATUS			BIT(31)
+#define DRAMC_MRCTL_READY_STATUS		BIT(30)
+#define DRAMC_MRCTL_MR_ADDR			BIT(8)
+#define DRAMC_MRCTL_CMD_DLL_RST			BIT(7)
+#define DRAMC_MRCTL_CMD_DQ_SEL			BIT(6)
+#define DRAMC_MRCTL_CMD_TYPE			BIT(2)
+#define DRAMC_MRCTL_CMD_WR_CTL			BIT(1)
+#define DRAMC_MRCTL_CMD_START			BIT(0)
+
+/* offset 0xC0 */
+#define DRAMC_BISTRES_RUNNING			BIT(10)
+#define DRAMC_BISTRES_FAIL			BIT(9)
+#define DRAMC_BISTRES_DONE			BIT(8)
+#define DRAMC_BISTCFG_INIT_MODE			BIT(7)
+#define DRAMC_BISTCFG_PMODE			GENMASK(6, 4)
+#define DRAMC_BISTCFG_BMODE			GENMASK(3, 2)
+#define DRAMC_BISTCFG_ENABLE			BIT(1)
+#define DRAMC_BISTCFG_START			BIT(0)
+#define BIST_PMODE_CRC				(3)
+#define BIST_BMODE_RW_SWITCH			(3)
+
+/* DRAMC048 MR Control Register */
+#define MR_TYPE_SHIFT				2
+#define MR_RW					(0 << MR_TYPE_SHIFT)
+#define MR_MPC					BIT(2)
+#define MR_VREFCS				(2 << MR_TYPE_SHIFT)
+#define MR_VREFCA				(3 << MR_TYPE_SHIFT)
+#define MR_ADDRESS_SHIFT			8
+#define MR_ADDR(n)				(((n) << MR_ADDRESS_SHIFT) | DRAMC_MRCTL_CMD_WR_CTL)
+#define MR_NUM_SHIFT				4
+#define MR_NUM(n)				((n) << MR_NUM_SHIFT)
+#define MR_DLL_RESET				BIT(7)
+#define MR_1T_MODE				BIT(16)
+
+#endif
diff --git a/drivers/ram/aspeed/Kconfig b/drivers/ram/aspeed/Kconfig
index e4918460de6..37f2a2f8348 100644
--- a/drivers/ram/aspeed/Kconfig
+++ b/drivers/ram/aspeed/Kconfig
@@ -1,7 +1,7 @@
 menuconfig ASPEED_RAM
 	bool "ASPEED SDRAM configuration"
 	depends on RAM
-	depends on ARCH_ASPEED || TARGET_ASPEED_AST2700_IBEX
+	depends on ARCH_ASPEED || ASPEED_AST2700
 	default ARCH_ASPEED
 	help
 	 Configuration options for DDR SDRAM on ASPEED systems.
@@ -77,7 +77,7 @@ choice
 	prompt "AST2700 DDR target date rate"
 	default ASPEED_DDR_3200
 	depends on ASPEED_RAM
-	depends on TARGET_ASPEED_AST2700_IBEX
+	depends on ASPEED_AST2700
 
 config ASPEED_DDR_1600
 	bool "1600 Mbps"
diff --git a/drivers/ram/aspeed/Makefile b/drivers/ram/aspeed/Makefile
index 1f0b22c8e9f..5706e122491 100644
--- a/drivers/ram/aspeed/Makefile
+++ b/drivers/ram/aspeed/Makefile
@@ -2,4 +2,4 @@
 #
 obj-$(CONFIG_ASPEED_AST2500) += sdram_ast2500.o
 obj-$(CONFIG_ASPEED_AST2600) += sdram_ast2600.o
-obj-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += sdram_ast2700.o
+obj-$(CONFIG_ASPEED_AST2700) += sdram_ast2700.o
diff --git a/drivers/ram/aspeed/sdram_ast2700.c b/drivers/ram/aspeed/sdram_ast2700.c
index 4a019c4edb1..0cd2d0a479e 100644
--- a/drivers/ram/aspeed/sdram_ast2700.c
+++ b/drivers/ram/aspeed/sdram_ast2700.c
@@ -14,6 +14,11 @@
 #include <linux/sizes.h>
 #include <ram.h>
 
+__weak int fmc_hdr_get_prebuilt(u32 type, u32 *ofst, u32 *size)
+{
+	return -ENOSYS;
+}
+
 enum ddr_type {
 	DDR4_1600 = 0x0,
 	DDR4_2400,
@@ -128,13 +133,13 @@ static size_t ast2700_sdrammc_get_vga_mem_size(struct sdrammc *sdrammc)
 
 	reg = readl(scu0 + SCU0_PCI_MISC70);
 	if (reg & SCU0_PCI_MISC70_EN_PCIEVGA0) {
-		debug("VGA0:%dMB\n", vga_memsz[sel] / SZ_1M);
+		debug("VGA0:%zuMB\n", vga_memsz[sel] / SZ_1M);
 		dual++;
 	}
 
 	reg = readl(scu0 + SCU0_PCI_MISC80);
 	if (reg & SCU0_PCI_MISC80_EN_PCIEVGA1) {
-		debug("VGA1:%dMB\n", vga_memsz[sel] / SZ_1M);
+		debug("VGA1:%zuMB\n", vga_memsz[sel] / SZ_1M);
 		dual++;
 	}
 
@@ -560,7 +565,7 @@ void dwc_get_mailbox(struct sdrammc *sdrammc, const int mode, u32 *mbox)
 	dwc_ddrphy_apb_wr(0xd0031, 1);
 }
 
-uint32_t dwc_readMsgBlock(struct sdrammc *sdrammc, const u32 addr_half)
+u32 dwc_readMsgBlock(struct sdrammc *sdrammc, const u32 addr_half)
 {
 	u32 data_word;
 
@@ -727,7 +732,7 @@ int dwc_ddrphy_phyinit_userCustom_D_loadIMEM(struct sdrammc *sdrammc, const int
 	fmc_hdr_get_prebuilt(pb_type, &imem_ofst, &imem_size);
 
 	memcpy(sdrammc->phy + (DWC_PHY_IMEM_OFST << 1),
-	       (void *)(0x20000000 + imem_ofst), imem_size);
+	       (void *)(uintptr_t)(0x20000000 + imem_ofst), imem_size);
 
 	return 0;
 }
@@ -746,7 +751,7 @@ int dwc_ddrphy_phyinit_userCustom_F_loadDMEM(struct sdrammc *sdrammc,
 	fmc_hdr_get_prebuilt(pb_type, &dmem_ofst, &dmem_size);
 
 	memcpy(sdrammc->phy + (DWC_PHY_DMEM_OFST << 1),
-	       (void *)(0x20000000 + dmem_ofst), dmem_size);
+	       (void *)(uintptr_t)(0x20000000 + dmem_ofst), dmem_size);
 
 	return 0;
 }

-- 
2.34.1

