Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A03ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A337F88F7E;
	Tue, 10 Sep 2024 11:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D92B88FBF; Tue, 10 Sep 2024 11:39:32 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F0E88F90
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 10 Sep
 2024 17:39:21 +0800
Received: from mail.aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 10 Sep 2024 17:39:21 +0800
From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To: <rick@andestech.com>, <ycliang@andestech.com>, <trini@konsulko.com>,
 <ryan_chen@aspeedtech.com>, <joel@jms.id.au>, <u-boot@lists.denx.de>
Subject: [PATCH v2 4/8] riscv: Add AST2700 SoC initial platform support
Date: Tue, 10 Sep 2024 17:39:16 +0800
Message-ID: <20240910093920.1142455-5-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910093920.1142455-1-chiawei_wang@aspeedtech.com>
References: <20240910093920.1142455-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

AST2700 SoCs integrates a Ibex 32-bits RISC-V core as the boot MCU
for the first stage bootloader execution, namely SPL.

This patch implements the preliminary base to successfully run SPL
on this RV32-based MCU to the console banner message.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/Kconfig                        |   5 +
 arch/riscv/cpu/ast2700/Kconfig            |   6 +
 arch/riscv/cpu/ast2700/Makefile           |   1 +
 arch/riscv/cpu/ast2700/cpu.c              |  23 ++++
 arch/riscv/dts/Makefile                   |   1 +
 arch/riscv/dts/ast2700-ibex.dts           |  22 ++++
 arch/riscv/dts/ast2700-u-boot.dtsi        |  40 ++++++
 arch/riscv/dts/ast2700.dtsi               |  76 ++++++++++++
 arch/riscv/include/asm/arch-ast2700/scu.h | 145 ++++++++++++++++++++++
 arch/riscv/include/asm/arch-ast2700/sli.h |  82 ++++++++++++
 board/aspeed/ibex_ast2700/Kconfig         |  21 ++++
 board/aspeed/ibex_ast2700/MAINTAINERS     |   7 ++
 board/aspeed/ibex_ast2700/Makefile        |   2 +
 board/aspeed/ibex_ast2700/ibex_ast2700.c  |  85 +++++++++++++
 board/aspeed/ibex_ast2700/sli.c           |  72 +++++++++++
 configs/ibex-ast2700_defconfig            |  92 ++++++++++++++
 doc/board/aspeed/ibex-ast2700.rst         |  26 ++++
 doc/board/aspeed/index.rst                |   9 ++
 doc/board/index.rst                       |   1 +
 include/configs/ibex_ast2700.h            |  12 ++
 20 files changed, 728 insertions(+)
 create mode 100644 arch/riscv/cpu/ast2700/Kconfig
 create mode 100644 arch/riscv/cpu/ast2700/Makefile
 create mode 100644 arch/riscv/cpu/ast2700/cpu.c
 create mode 100644 arch/riscv/dts/ast2700-ibex.dts
 create mode 100644 arch/riscv/dts/ast2700-u-boot.dtsi
 create mode 100644 arch/riscv/dts/ast2700.dtsi
 create mode 100644 arch/riscv/include/asm/arch-ast2700/scu.h
 create mode 100644 arch/riscv/include/asm/arch-ast2700/sli.h
 create mode 100644 board/aspeed/ibex_ast2700/Kconfig
 create mode 100644 board/aspeed/ibex_ast2700/MAINTAINERS
 create mode 100644 board/aspeed/ibex_ast2700/Makefile
 create mode 100644 board/aspeed/ibex_ast2700/ibex_ast2700.c
 create mode 100644 board/aspeed/ibex_ast2700/sli.c
 create mode 100644 configs/ibex-ast2700_defconfig
 create mode 100644 doc/board/aspeed/ibex-ast2700.rst
 create mode 100644 doc/board/aspeed/index.rst
 create mode 100644 include/configs/ibex_ast2700.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d0476f975c2..6b854cc0b65 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -46,6 +46,9 @@ config TARGET_TH1520_LPI4A
 config TARGET_XILINX_MBV
 	bool "Support AMD/Xilinx MicroBlaze V"
 
+config TARGET_ASPEED_AST2700_IBEX
+	bool "Support Ibex RISC-V cores on Aspeed AST2700 SoC"
+
 endchoice
 
 config SYS_ICACHE_OFF
@@ -81,6 +84,7 @@ config SPL_ZERO_MEM_BEFORE_USE
 
 # board-specific options below
 source "board/andestech/ae350/Kconfig"
+source "board/aspeed/ibex_ast2700/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
 source "board/microchip/mpfs_icicle/Kconfig"
 source "board/openpiton/riscv64/Kconfig"
@@ -97,6 +101,7 @@ source "arch/riscv/cpu/andes/Kconfig"
 source "arch/riscv/cpu/cv1800b/Kconfig"
 source "arch/riscv/cpu/fu540/Kconfig"
 source "arch/riscv/cpu/fu740/Kconfig"
+source "arch/riscv/cpu/ast2700/Kconfig"
 source "arch/riscv/cpu/generic/Kconfig"
 source "arch/riscv/cpu/jh7110/Kconfig"
 
diff --git a/arch/riscv/cpu/ast2700/Kconfig b/arch/riscv/cpu/ast2700/Kconfig
new file mode 100644
index 00000000000..b16f0fc7cad
--- /dev/null
+++ b/arch/riscv/cpu/ast2700/Kconfig
@@ -0,0 +1,6 @@
+config RISCV_AST2700
+	bool
+	imply CPU
+	imply CPU_RISCV
+	help
+	  Run U-Boot on AST2700 with IBex RISC-V CPU integrated.
diff --git a/arch/riscv/cpu/ast2700/Makefile b/arch/riscv/cpu/ast2700/Makefile
new file mode 100644
index 00000000000..1f843c706ad
--- /dev/null
+++ b/arch/riscv/cpu/ast2700/Makefile
@@ -0,0 +1 @@
+obj-y += cpu.o
diff --git a/arch/riscv/cpu/ast2700/cpu.c b/arch/riscv/cpu/ast2700/cpu.c
new file mode 100644
index 00000000000..c1540546a9a
--- /dev/null
+++ b/arch/riscv/cpu/ast2700/cpu.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+ * Copyright (C) 2024, Aspeed Technology Inc.
+ */
+
+#include <irq_func.h>
+#include <asm/cache.h>
+
+/*
+ * cleanup_before_linux() is called just before we call linux
+ * it prepares the processor for linux
+ *
+ * we disable interrupt and caches.
+ */
+int cleanup_before_linux(void)
+{
+	disable_interrupts();
+
+	cache_flush();
+
+	return 0;
+}
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 17cda483e12..c4c44057bad 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -11,6 +11,7 @@ dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
 dtb-$(CONFIG_TARGET_STARFIVE_VISIONFIVE2) += jh7110-starfive-visionfive-2.dtb
 dtb-$(CONFIG_TARGET_TH1520_LPI4A) += th1520-lichee-pi-4a.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
+dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) += ast2700-ibex.dtb
 
 include $(srctree)/scripts/Makefile.dts
 
diff --git a/arch/riscv/dts/ast2700-ibex.dts b/arch/riscv/dts/ast2700-ibex.dts
new file mode 100644
index 00000000000..f7a05e5771b
--- /dev/null
+++ b/arch/riscv/dts/ast2700-ibex.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+#include "ast2700.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart12;
+		tick-timer = &ast_ibex_timer;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+&uart12 {
+	status = "okay";
+	clock-frequency = <1846153>;
+};
diff --git a/arch/riscv/dts/ast2700-u-boot.dtsi b/arch/riscv/dts/ast2700-u-boot.dtsi
new file mode 100644
index 00000000000..ddc08a4bcef
--- /dev/null
+++ b/arch/riscv/dts/ast2700-u-boot.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/ {
+	cpus {
+		bootph-all;
+	};
+
+	memory@80000000 {
+		bootph-all;
+	};
+
+	soc0: soc@12000000 {
+		bootph-all;
+
+		sdrammc: sdrammc@12c00000 {
+			bootph-all;
+		};
+
+		syscon0: syscon@12c02000 {
+			bootph-all;
+		};
+	};
+
+	soc1: soc@14000000 {
+		bootph-all;
+
+		syscon1: syscon@14c02000 {
+			bootph-all;
+		};
+
+		uart12: serial@14c33b00 {
+			bootph-all;
+		};
+
+		ast_ibex_timer: timer {
+			bootph-all;
+		};
+	};
+
+};
diff --git a/arch/riscv/dts/ast2700.dtsi b/arch/riscv/dts/ast2700.dtsi
new file mode 100644
index 00000000000..9b482dfdd84
--- /dev/null
+++ b/arch/riscv/dts/ast2700.dtsi
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/ {
+	model = "Aspeed AST2700 Ibex BootMCU";
+	compatible = "aspeed,ast2700-ibex";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "lowrisc,ibex";
+			device_type = "cpu";
+			reg = <0>;
+			comptaible = "riscv";
+			riscv,isa = "rv32imc";
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x80000000>;
+	};
+
+	soc0: soc@12000000 {
+		compatible = "aspeed,soc1","simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		sdrammc: sdrammc@12c00000 {
+			compatible = "aspeed,ast2700-sdrammc";
+			reg = <0x12c00000 0x3000>, <0x13000000 0x1000>;
+			aspeed,scu0 = <&syscon0>;
+			aspeed,scu1 = <&syscon1>;
+		};
+
+		syscon0: syscon@12c02000 {
+			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+			reg = <0x12c02000 0x1000>;
+			ranges = <0 0x12c02000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
+
+	soc1: soc@14000000 {
+		compatible = "aspeed,soc1","simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		syscon1: syscon@14c02000 {
+			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
+			reg = <0x14c02000 0x1000>;
+			ranges = <0 0x14c02000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		uart12: serial@14c33b00 {
+			compatible = "ns16550a";
+			reg = <0x14c33b00 0x20>;
+			reg-shift = <2>;
+			no-loopback-test;
+			clock-frequency = <1846153>;
+			status = "disabled";
+		};
+
+		ast_ibex_timer: timer {
+			compatible = "aspeed,ast2700-ibex-timer";
+			clock-frequency = <200000000>;
+		};
+	};
+};
diff --git a/arch/riscv/include/asm/arch-ast2700/scu.h b/arch/riscv/include/asm/arch-ast2700/scu.h
new file mode 100644
index 00000000000..1aa7d38bace
--- /dev/null
+++ b/arch/riscv/include/asm/arch-ast2700/scu.h
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
diff --git a/arch/riscv/include/asm/arch-ast2700/sli.h b/arch/riscv/include/asm/arch-ast2700/sli.h
new file mode 100644
index 00000000000..42f0f9ac93d
--- /dev/null
+++ b/arch/riscv/include/asm/arch-ast2700/sli.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) Aspeed Technology Inc.
+ */
+#ifndef __ASM_AST2700_SLI_H__
+#define __ASM_AST2700_SLI_H__
+
+#define SLI_CPU_ADRBASE			0x12c17000
+#define SLI_IOD_ADRBASE			0x14c1e000
+#define SLIM_CPU_BASE			(SLI_CPU_ADRBASE + 0x000)
+#define SLIH_CPU_BASE			(SLI_CPU_ADRBASE + 0x200)
+#define SLIV_CPU_BASE			(SLI_CPU_ADRBASE + 0x400)
+#define SLIM_IOD_BASE			(SLI_IOD_ADRBASE + 0x000)
+#define SLIH_IOD_BASE			(SLI_IOD_ADRBASE + 0x200)
+#define SLIV_IOD_BASE			(SLI_IOD_ADRBASE + 0x400)
+
+#define SLI_CTRL_I			0x00
+#define   SLIV_RAW_MODE			BIT(15)
+#define   SLI_TX_MODE			BIT(14)
+#define   SLI_RX_PHY_LAH_SEL_REV	BIT(13)
+#define   SLI_RX_PHY_LAH_SEL_NEG	BIT(12)
+#define   SLI_AUTO_SEND_TRN_OFF		BIT(8)
+#define   SLI_CLEAR_BUS			BIT(6)
+#define   SLI_TRANS_EN			BIT(5)
+#define   SLI_CLEAR_RX			BIT(2)
+#define   SLI_CLEAR_TX			BIT(1)
+#define   SLI_RESET_TRIGGER		BIT(0)
+#define SLI_CTRL_II			0x04
+#define SLI_CTRL_III			0x08
+#define   SLI_CLK_SEL			GENMASK(31, 28)
+#define     SLI_CLK_500M		0x6
+#define     SLI_CLK_200M		0x3
+#define   SLI_PHYCLK_SEL		GENMASK(27, 24)
+#define     SLI_PHYCLK_25M		0x0
+#define     SLI_PHYCLK_800M		0x1
+#define     SLI_PHYCLK_400M		0x2
+#define     SLI_PHYCLK_200M		0x3
+#define     SLI_PHYCLK_788M		0x5
+#define     SLI_PHYCLK_500M		0x6
+#define     SLI_PHYCLK_250M		0x7
+#define   SLIH_PAD_DLY_TX1		GENMASK(23, 18)
+#define   SLIH_PAD_DLY_TX0		GENMASK(17, 12)
+#define   SLIH_PAD_DLY_RX1		GENMASK(11, 6)
+#define   SLIH_PAD_DLY_RX0		GENMASK(5, 0)
+#define   SLIM_PAD_DLY_RX3		GENMASK(23, 18)
+#define   SLIM_PAD_DLY_RX2		GENMASK(17, 12)
+#define   SLIM_PAD_DLY_RX1		GENMASK(11, 6)
+#define   SLIM_PAD_DLY_RX0		GENMASK(5, 0)
+#define SLI_CTRL_IV			0x0c
+#define   SLIM_PAD_DLY_TX3		GENMASK(23, 18)
+#define   SLIM_PAD_DLY_TX2		GENMASK(17, 12)
+#define   SLIM_PAD_DLY_TX1		GENMASK(11, 6)
+#define   SLIM_PAD_DLY_TX0		GENMASK(5, 0)
+#define SLI_INTR_EN			0x10
+#define SLI_INTR_STATUS			0x14
+#define   SLI_INTR_RX_SYNC		BIT(15)
+#define   SLI_INTR_RX_ERR		BIT(13)
+#define   SLI_INTR_RX_NACK		BIT(12)
+#define   SLI_INTR_RX_TRAIN_PKT		BIT(10)
+#define   SLI_INTR_RX_DISCONN		BIT(6)
+#define   SLI_INTR_TX_SUSPEND		BIT(4)
+#define   SLI_INTR_TX_TRAIN		BIT(3)
+#define   SLI_INTR_TX_IDLE		BIT(2)
+#define   SLI_INTR_RX_SUSPEND		BIT(1)
+#define   SLI_INTR_RX_IDLE		BIT(0)
+#define   SLI_INTR_RX_ERRORS                                                     \
+	  (SLI_INTR_RX_ERR | SLI_INTR_RX_NACK | SLI_INTR_RX_DISCONN)
+
+#define SLIM_MARB_FUNC_I		0x60
+#define   SLIM_SLI_MARB_RR		BIT(0)
+
+#define SLI_TARGET_PHYCLK		SLI_PHYCLK_400M
+#define SLIH_DEFAULT_DELAY		11
+#if (SLI_TARGET_PHYCLK == SLI_PHYCLK_800M) || (SLI_TARGET_PHYCLK == SLI_PHYCLK_788M)
+#define SLIM_DEFAULT_DELAY		5
+#define SLIM_LAH_CONFIG			1
+#else
+#define SLIM_DEFAULT_DELAY		12
+#define SLIM_LAH_CONFIG			0
+#endif
+#endif
+int sli_init(void);
diff --git a/board/aspeed/ibex_ast2700/Kconfig b/board/aspeed/ibex_ast2700/Kconfig
new file mode 100644
index 00000000000..469cea58d12
--- /dev/null
+++ b/board/aspeed/ibex_ast2700/Kconfig
@@ -0,0 +1,21 @@
+if TARGET_ASPEED_AST2700_IBEX
+
+config SYS_BOARD
+	default "ibex_ast2700"
+
+config SYS_VENDOR
+	default "aspeed"
+
+config SYS_CPU
+	default "ast2700"
+
+config SYS_CONFIG_NAME
+	default "ibex_ast2700"
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select RISCV_AST2700
+	select SUPPORT_SPL
+	imply SPL_DRIVERS_MISC
+
+endif
diff --git a/board/aspeed/ibex_ast2700/MAINTAINERS b/board/aspeed/ibex_ast2700/MAINTAINERS
new file mode 100644
index 00000000000..777f582a20d
--- /dev/null
+++ b/board/aspeed/ibex_ast2700/MAINTAINERS
@@ -0,0 +1,7 @@
+AST2700 using Ibex RISC-V Core as the boot MCU
+M:	Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
+S:	Maintained
+F:	arch/riscv/include/asm/arch-ast2700/
+F:	board/aspeed/ibex_ast2700/
+F:	configs/ibex-ast2700_defconfig
+F:	include/configs/ibex_ast2700.h
diff --git a/board/aspeed/ibex_ast2700/Makefile b/board/aspeed/ibex_ast2700/Makefile
new file mode 100644
index 00000000000..162f46fd46a
--- /dev/null
+++ b/board/aspeed/ibex_ast2700/Makefile
@@ -0,0 +1,2 @@
+obj-y += ibex_ast2700.o
+obj-y += sli.o
diff --git a/board/aspeed/ibex_ast2700/ibex_ast2700.c b/board/aspeed/ibex_ast2700/ibex_ast2700.c
new file mode 100644
index 00000000000..e697f9b8baa
--- /dev/null
+++ b/board/aspeed/ibex_ast2700/ibex_ast2700.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) Aspeed Technology Inc.
+ */
+#include <asm/io.h>
+#include <asm/arch/sli.h>
+#include <dm.h>
+#include <ram.h>
+#include <spl.h>
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
+		return ret;
+	}
+
+	ret = ram_get_info(dev, &ram);
+	if (ret) {
+		printf("cannot get DRAM information\n");
+		return ret;
+	}
+
+	gd->ram_size = ram.size;
+
+	return 0;
+}
+
+int spl_board_init_f(void)
+{
+	sli_init();
+
+	dram_init();
+
+	return 0;
+}
+
+struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
+{
+	return (struct legacy_img_hdr *)CONFIG_SYS_LOAD_ADDR;
+}
+
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return (void *)spl_get_load_buffer(sectors, bl_len);
+}
+
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_RAM;
+}
+
+int board_init(void)
+{
+	struct udevice *dev;
+	int i = 0;
+	int ret;
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
+
+int board_late_init(void)
+{
+	return 0;
+}
diff --git a/board/aspeed/ibex_ast2700/sli.c b/board/aspeed/ibex_ast2700/sli.c
new file mode 100644
index 00000000000..7868111d844
--- /dev/null
+++ b/board/aspeed/ibex_ast2700/sli.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) Aspeed Technology Inc.
+ */
+#include <asm/io.h>
+#include <asm/arch/sli.h>
+#include <asm/arch/scu.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+
+#define SLI_POLL_TIMEOUT_US	100
+
+static void sli_clear_interrupt_status(uint32_t base)
+{
+	writel(-1, (void *)base + SLI_INTR_STATUS);
+}
+
+static int sli_wait(uint32_t base, uint32_t mask)
+{
+	uint32_t value;
+
+	sli_clear_interrupt_status(base);
+
+	do {
+		value = readl((void *)base + SLI_INTR_STATUS);
+		if (value & SLI_INTR_RX_ERRORS)
+			return -1;
+	} while ((value & mask) != mask);
+
+	return 0;
+}
+
+static int sli_wait_suspend(uint32_t base)
+{
+	return sli_wait(base, SLI_INTR_TX_SUSPEND | SLI_INTR_RX_SUSPEND);
+}
+
+/*
+ * CPU die  --- downstream pads ---> I/O die
+ * CPU die  <--- upstream pads ----- I/O die
+ *
+ * US/DS PAD[3:0] : SLIM[3:0]
+ * US/DS PAD[5:4] : SLIH[1:0]
+ * US/DS PAD[7:6] : SLIV[1:0]
+ */
+int sli_init(void)
+{
+	uint32_t value;
+
+	/* The following training sequence is designed for AST2700A0 */
+	value = FIELD_GET(SCU1_REVISION_HWID, readl(SCU1_REVISION));
+	if (value)
+		return 0;
+
+	/* Return if SLI had been calibrated */
+	value = readl((void *)SLIH_IOD_BASE + SLI_CTRL_III);
+	value = FIELD_GET(SLI_CLK_SEL, value);
+	if (value) {
+		debug("SLI has been initialized\n");
+		return 0;
+	}
+
+	/* 25MHz PAD delay for AST2700A0 */
+	value = SLI_RX_PHY_LAH_SEL_NEG | SLI_TRANS_EN | SLI_CLEAR_BUS;
+	writel(value, (void *)SLIH_IOD_BASE + SLI_CTRL_I);
+	writel(value, (void *)SLIM_IOD_BASE + SLI_CTRL_I);
+	writel(value | SLIV_RAW_MODE, (void *)SLIV_IOD_BASE + SLI_CTRL_I);
+	sli_wait_suspend(SLIH_IOD_BASE);
+	sli_wait_suspend(SLIH_CPU_BASE);
+
+	return 0;
+}
diff --git a/configs/ibex-ast2700_defconfig b/configs/ibex-ast2700_defconfig
new file mode 100644
index 00000000000..22629b90489
--- /dev/null
+++ b/configs/ibex-ast2700_defconfig
@@ -0,0 +1,92 @@
+CONFIG_RISCV=y
+CONFIG_SYS_DCACHE_OFF=y
+# CONFIG_SPL_USE_ARCH_MEMCPY is not set
+# CONFIG_SPL_USE_ARCH_MEMMOVE is not set
+# CONFIG_SPL_USE_ARCH_MEMSET is not set
+CONFIG_TEXT_BASE=0x80000000
+CONFIG_SYS_MALLOC_LEN=0xf00
+CONFIG_SYS_MALLOC_F_LEN=0xf00
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x14bd7800
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="ast2700-ibex"
+CONFIG_SPL_TEXT_BASE=0x14bc0080
+CONFIG_DM_RESET=y
+CONFIG_SPL_BSS_START_ADDR=0x14bd7800
+CONFIG_SPL_BSS_MAX_SIZE=0x800
+CONFIG_SPL_SIZE_LIMIT=0x16000
+CONFIG_SPL=y
+CONFIG_SYS_MEM_TOP_HIDE=0x10000000
+CONFIG_SYS_LOAD_ADDR=0x83000000
+CONFIG_BUILD_TARGET=""
+CONFIG_TARGET_ASPEED_AST2700_IBEX=y
+# CONFIG_RISCV_ISA_F is not set
+# CONFIG_RISCV_ISA_A is not set
+# CONFIG_SPL_SMP is not set
+CONFIG_XIP=y
+CONFIG_SPL_XIP=y
+# CONFIG_AVAILABLE_HARTS is not set
+CONFIG_STACK_SIZE_SHIFT=11
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_STACK_SIZE=0x100000
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x200c0000
+# CONFIG_BOOTSTD is not set
+CONFIG_SYS_BOOTM_LEN=0x4000000
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+# CONFIG_CONSOLE_FLUSH_SUPPORT is not set
+# CONFIG_CONSOLE_MUX is not set
+CONFIG_SYS_STDIO_DEREGISTER=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x16000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+# CONFIG_CMD_BOOTD is not set
+# CONFIG_CMD_BOOTI is not set
+# CONFIG_BOOTM_LINUX is not set
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_FDT is not set
+# CONFIG_CMD_IMI is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_SAVEENV is not set
+# CONFIG_CMD_CRC32 is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_DEVICE_TREE_INCLUDES="ast2700-u-boot.dtsi"
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
+CONFIG_SYS_RX_ETH_BUFFER=2
+# CONFIG_DM_DEVICE_REMOVE is not set
+# CONFIG_DM_SEQ_ALIAS is not set
+# CONFIG_BLOCK_CACHE is not set
+# CONFIG_CPU is not set
+# CONFIG_GPIO is not set
+# CONFIG_I2C is not set
+CONFIG_MMC=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_MTD is not set
+# CONFIG_POWER is not set
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+# CONFIG_RAM_SIFIVE is not set
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_LOGO is not set
+# CONFIG_RSA is not set
+# CONFIG_EFI_LOADER is not set
diff --git a/doc/board/aspeed/ibex-ast2700.rst b/doc/board/aspeed/ibex-ast2700.rst
new file mode 100644
index 00000000000..511bd081ba2
--- /dev/null
+++ b/doc/board/aspeed/ibex-ast2700.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+IBex AST2700
+============
+
+AST2700 integrates an IBex RISC-V 32-bits CPU as the boot MCU to execute the
+first stage bootlaoder, namely SPL.
+
+Build
+-----
+
+1. Prepare the toolchains and make sure the $PATH to toolchains is correct.
+2. Use `make ibex-ast2700_defconfig` in u-boot root to build the image
+
+Running U-Boot SPL
+------------------
+
+The U-Boot SPL will boot in M mode and load the FIT image which includes
+the 2nd stage bootloaders executed by the main processor Cortex-A35.
+
+
+Burn U-Boot to SPI Flash
+------------------------
+
+Use SPI flash programmer (e.g. SF100) to program the u-book-spl.bin with the
+offset 0x80 bytes to the SPI flash beginning.
diff --git a/doc/board/aspeed/index.rst b/doc/board/aspeed/index.rst
new file mode 100644
index 00000000000..d784c88494f
--- /dev/null
+++ b/doc/board/aspeed/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Aspeed
+======
+
+.. toctree::
+   :maxdepth: 2
+
+   ibex-ast2700
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 417c128c7af..3fb7c84f10c 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -14,6 +14,7 @@ Board-specific doc
    anbernic/index
    apple/index
    armltd/index
+   aspeed/index
    asus/index
    atmel/index
    beacon/index
diff --git a/include/configs/ibex_ast2700.h b/include/configs/ibex_ast2700.h
new file mode 100644
index 00000000000..0f6850f7240
--- /dev/null
+++ b/include/configs/ibex_ast2700.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) Aspeed Technology Inc.
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE	CONFIG_TEXT_BASE
+#define CFG_SYS_SDRAM_BASE	0x80000000
+
+#endif	/* __CONFIG_H */
-- 
2.25.1

