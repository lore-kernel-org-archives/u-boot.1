Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8000C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C1C87D8D;
	Tue, 20 Feb 2024 15:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Oq0LGcPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D9B877FB; Tue, 20 Feb 2024 15:36:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128FE87D8D
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=jitloonl@ecsmtp.png.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708439791; x=1739975791;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Uk3x1HDiNyEMMdx6fU3rLFwDPgVhQdwGMNZ6BO8OpXo=;
 b=Oq0LGcPePgc/r4qbiwkh/seiYxRRz8CQIFkQ9FdnGVuAEyGp3FsA67K6
 /sC3mhr5Dl8uach3nUY9QAp2EjphZmoSwMCmPTTzs0RmfLhmm0CXWcDBI
 AjoAkX/B/345FX2DTqNEo6foM8CxHdBxoN4HCyc9265RU6PEYbWdqm1fb
 utFoaTe5zpd8/Evjq8fG9O6kJ0m98Nm63Tgn26ihkPbzaczotdOqjstBN
 y8jUPxRF4f8uWVKjOLWsxewbNNDW9z3PiJGdHPzteMf1ke7Y3yJUWyMk1
 Q6lE4S9I1Fb15cTaXyULixQG8iRwPW6xDFHTJkkEMKYGkynln3+X23Zwn w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="20077620"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; d="scan'208";a="20077620"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 06:36:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9435073"
Received: from pglmail07.png.intel.com ([10.126.73.9])
 by orviesa003.jf.intel.com with ESMTP; 20 Feb 2024 06:36:06 -0800
Received: from localhost (pgli0121.png.intel.com [10.221.240.84])
 by pglmail07.png.intel.com (Postfix) with ESMTP id 13F1C16432;
 Tue, 20 Feb 2024 22:36:05 +0800 (+08)
Received: by localhost (Postfix, from userid 12048045)
 id 115C92B62; Tue, 20 Feb 2024 22:36:05 +0800 (+08)
From: Jit Loon Lim <jit.loon.lim@intel.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v1 1/1] arch:arm: Agilex5 enablement
Date: Tue, 20 Feb 2024 22:36:03 +0800
Message-Id: <20240220143603.22091-1-jit.loon.lim@intel.com>
X-Mailer: git-send-email 2.26.2
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

This patch is to enable Agilex5 platform for Intel
product. Changes, modification and new files are
created for board, dts, configs and makefile to
create the base for Agilex5.

Signed-off-by: Jit Loon Lim <jit.loon.lim@intel.com>
---
 arch/arm/Kconfig                              |   9 +-
 arch/arm/dts/Makefile                         |  32 +----
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  11 +-
 arch/arm/dts/socfpga_agilex5_socdk.dts        |  67 +---------
 arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |   2 +-
 arch/arm/mach-socfpga/Kconfig                 | 125 +++++-------------
 arch/arm/mach-socfpga/Makefile                |  99 +-------------
 arch/arm/mach-socfpga/board.c                 |   2 -
 .../include/mach/base_addr_soc64.h            |  16 +--
 board/intel/agilex5-socdk/MAINTAINERS         |   2 +
 board/intel/agilex5-socdk/Makefile            |   2 +-
 board/intel/agilex5-socdk/socfpga.c           |   2 +-
 configs/socfpga_agilex5_defconfig             |  33 -----
 include/configs/socfpga_agilex5_socdk.h       |   2 +-
 include/configs/socfpga_soc64_common.h        |  40 +-----
 15 files changed, 63 insertions(+), 381 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43d5ad346f..c8d91669da 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -28,7 +28,7 @@ config COUNTER_FREQUENCY
 			ROCKCHIP_RK3288 || ROCKCHIP_RK322X || ROCKCHIP_RK3036
 	default 25000000 if ARCH_LX2160A || ARCH_LX2162A || ARCH_LS1088A
 	default 100000000 if ARCH_ZYNQMP
-	default 400000000 if ARCH_SOCFPGA && ARM64
+	default 200000000 if ARCH_SOCFPGA && ARM64 && TARGET_SOCFPGA_AGILEX5
 	default 0
 	help
 	  For platforms with ARMv8-A and ARMv7-A which features a system
@@ -1088,14 +1088,14 @@ config ARCH_SNAPDRAGON
 	select SPMI
 	imply CMD_DM
 
-config ARCH_SOCFPGA
-	bool "Altera SOCFPGA family"
+bool "Altera SOCFPGA family"
 	select ARCH_EARLY_INIT_R
 	select ARCH_MISC_INIT if !TARGET_SOCFPGA_ARRIA10
 	select ARM64 if TARGET_SOCFPGA_SOC64
 	select CPU_V7A if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select DM
 	select DM_SERIAL
+	select GICV2
 	select GPIO_EXTRA_HEADER
 	select ENABLE_ARM_SOC_BOOT0_HOOK if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select OF_CONTROL
@@ -1109,7 +1109,7 @@ config ARCH_SOCFPGA
 	select SPL_SOCFPGA_SEC_REG if TARGET_SOCFPGA_SOC64
 	select SPL_SERIAL
 	select SPL_SYSRESET
-	select SPL_WATCHDOG
+	select SPL_WATCHDOG if !TARGET_SOCFPGA_AGILEX5
 	select SUPPORT_SPL
 	select SYS_NS16550
 	select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
@@ -1123,6 +1123,7 @@ config ARCH_SOCFPGA
 	imply DM_SPI
 	imply DM_SPI_FLASH
 	imply FAT_WRITE
+	imply MTD
 	imply SPL
 	imply SPL_DM
 	imply SPL_DM_SPI
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 90d933a9ae..646f4feaf7 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -543,37 +543,7 @@ dtb-$(CONFIG_TARGET_AM3517_EVM) += am3517-evm.dtb
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
-	socfpga_agilex_n6010.dtb			\
-	socfpga_agilex_socdk.dtb			\
-	socfpga_agilex_socdk_nand.dtb                   \
-	socfpga_agilex_socdk_qspi.dtb			\
-	socfpga_agilex5_socdk.dtb			\
-	socfpga_agilex5_emu.dtb			\
-	socfpga_agilex7m_socdk.dtb			\
-	socfpga_agilex7m_socdk_nand.dtb			\
-	socfpga_arria5_secu1.dtb			\
-	socfpga_arria5_socdk.dtb			\
-	socfpga_arria10_chameleonv3_270_2.dtb		\
-	socfpga_arria10_chameleonv3_270_3.dtb		\
-	socfpga_arria10_chameleonv3_480_2.dtb		\
-	socfpga_arria10_socdk_nand.dtb			\
-	socfpga_arria10_socdk_qspi.dtb			\
-	socfpga_arria10_socdk_sdmmc.dtb			\
-	socfpga_cyclone5_mcvevk.dtb			\
-	socfpga_cyclone5_is1.dtb			\
-	socfpga_cyclone5_socdk.dtb			\
-	socfpga_cyclone5_dbm_soc1.dtb			\
-	socfpga_cyclone5_de0_nano_soc.dtb		\
-	socfpga_cyclone5_de1_soc.dtb			\
-	socfpga_cyclone5_de10_nano.dtb			\
-	socfpga_cyclone5_sockit.dtb			\
-	socfpga_cyclone5_socrates.dtb			\
-	socfpga_cyclone5_sr1500.dtb			\
-	socfpga_cyclone5_vining_fpga.dtb		\
-	socfpga_n5x_socdk.dtb				\
-	socfpga_stratix10_socdk.dtb			\
-	socfpga_stratix10_socdk_nand.dtb                \
-	socfpga_stratix10_socdk_qspi.dtb
+	socfpga_agilex5_socdk.dtb
 
 dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb	\
 	dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb
diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index 5da93576c2..28e1c140c2 100755
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -2,7 +2,7 @@
 /*
  * U-Boot additions
  *
- * Copyright (C) 2022-2023 Intel Corporation <www.intel.com> 
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
  */
 
 #include "socfpga_agilex5-u-boot.dtsi"
@@ -14,16 +14,17 @@
 	};
 
 	soc {
-		freeze_controller: freeze_controller@f9000450 {
+		freeze_controller: freeze_controller@0x20000450 {
 			compatible = "altr,freeze-bridge-controller";
-			reg = <0xf9000450 0x00000010>;
+			reg = <0x20000450 0x00000010>;
 			status = "disabled";
 		};
 	};
 
 	memory {
-		/* 2GB on Simics*/
-		reg = <0 0x80000000 0 0x80000000>;
+		/* 8GB */
+		reg = <0 0x80000000 0 0x80000000>,
+		      <8 0x80000000 1 0x80000000>;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index b90b869e5a..c5d7352b75 100755
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
- * Copyright (C) 2019-2023 Intel Corporation <www.intel.com> 
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
  */
 #include "socfpga_agilex5.dtsi"
 
@@ -70,14 +70,6 @@
     status = "okay";
 };
 
-&mmc {
-	status = "okay";
-};
-
-&combophy0 {
-	status = "okay";
-};
-
 &uart0 {
 	status = "okay";
 };
@@ -91,10 +83,6 @@
 	disable-over-current;
 };
 
-&usb31 {
-	status = "okay";
-};
-
 &watchdog0 {
 	status = "okay";
 };
@@ -139,25 +127,6 @@
 	status = "okay";
 };
 
-&nand {
-	status = "okay";
-
-	flash1: flash@0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		partition@0 {
-			label = "u-boot";
-			reg = <0 0x200000>;
-		};
-		partition@200000 {
-			label = "root";
-			reg = <0x200000 0x3fe00000>;
-		};
-	};
-};
-
 &qspi {
 	flash0: flash@0 {
 		#address-cells = <1>;
@@ -192,37 +161,3 @@
 		};
 	};
 };
-
-&gmac0 {
-	status = "okay";
-	phy-mode = "rgmii";
-	phy-handle = <&emac0_phy0>;
-
-	max-frame-size = <9000>;
-
-	mdio0 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwxgmac-mdio";
-		emac0_phy0: ethernet-phy@1 {
-			reg = <1>;
-		};
-	};
-};
-
-&gmac2 {
-	status = "okay";
-	phy-mode = "rgmii";
-	phy-handle = <&emac2_phy0>;
-
-	max-frame-size = <9000>;
-
-	mdio0 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwxgmac-mdio";
-		emac2_phy0: ethernet-phy@1 {
-			reg = <1>;
-		};
-	};
-};
diff --git a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
index ddadde874d..7a5af489c5 100644
--- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
@@ -2,7 +2,7 @@
 /*
  * U-Boot additions
  *
- * Copyright (C) 2020-2023 Intel Corporation <www.intel.com>
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
  */
 
 #if defined(CONFIG_FIT)
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 622ac7861c..ba012e226d 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -6,24 +6,6 @@ config ERR_PTR_OFFSET
 config NR_DRAM_BANKS
 	default 1
 
-config SOCFPGA_RSU_MULTIBOOT
-	bool "Enable RSU Multiboot Selection Feature"
-	depends on TARGET_SOCFPGA_SOC64 && SPI_FLASH
-	default n
-	help
-	 Multiboot u-boot proper image (SSBL) selection feature for RSU.
-	 SPL will select the respective SSBL based on the partition it resides
-	 inside RSU QSPI flash layout.
-
-config SOCFPGA_RSU_MULTIFLASH
-	bool "Enable RSU Multiflash Feature"
-	depends on TARGET_SOCFPGA_SOC64 && SPI_FLASH
-	default n
-	help
-	 Multiflash selection feature for RSU.
-	 RSU will be able to perform operations on multiple flash on the platform
-	 given multiple flash configuration in programmer tool.
-
 config SOCFPGA_SECURE_VAB_AUTH
 	bool "Enable boot image authentication with Secure Device Manager"
 	depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X || TARGET_SOCFPGA_AGILEX5
@@ -48,6 +30,9 @@ config SPL_SIZE_LIMIT_PROVIDE_STACK
 config SPL_STACK_R_ADDR
 	default 0x00800000 if TARGET_SOCFPGA_GEN5
 
+config SPL_SYS_MALLOC_F
+	default y if TARGET_SOCFPGA_GEN5
+
 config SPL_SYS_MALLOC_F_LEN
 	default 0x800 if TARGET_SOCFPGA_GEN5
 
@@ -62,15 +47,6 @@ config TEXT_BASE
 	default 0x01000040 if TARGET_SOCFPGA_ARRIA10
 	default 0x01000040 if TARGET_SOCFPGA_GEN5
 
-config ARMV8_PSCI_NR_CPUS
-	default 4 if TARGET_SOCFPGA_SOC64
-
-config ARMV8_SECURE_BASE
-	default 0x00001000 if TARGET_SOCFPGA_SOC64 && ARMV8_PSCI
-
-config SYS_HAS_ARMV8_SECURE_BASE
-	default y if TARGET_SOCFPGA_SOC64 && ARMV8_PSCI
-
 config TARGET_SOCFPGA_AGILEX
 	bool
 	select ARMV8_MULTIENTRY
@@ -92,39 +68,31 @@ config TARGET_SOCFPGA_AGILEX5
 	select NCORE_CACHE
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
+config TARGET_SOCFPGA_AGILEX5_OOBE2
+	bool "Enable build that bootable only on Agilex5 OOBE2 DevKit"
 
-config TARGET_SOCFPGA_AGILEX7
-	bool
-	select ARMV8_MULTIENTRY
-	select ARMV8_SET_SMPEN
-	select BINMAN if SPL_ATF
-	select CLK
-	select FPGA_INTEL_SDM_MAILBOX
-	select GICV2
-	select NCORE_CACHE
-	select SPL_CLK if SPL
-	select TARGET_SOCFPGA_SOC64
+config TARGET_SOCFPGA_AGILEX5_NAND2
+	bool "Enable build that bootable only on Agilex5 NAND2 DevKit"
 
-config TARGET_SOCFPGA_AGILEX5_EMU
-	bool "Enable build that bootable only on Agilex5 Emulator"
+config TARGET_SOCFPGA_AGILEX5_TSN_AIC0
+	bool "Enable build that bootable only on Agilex5 TSN_PHY_AIC0 MuDV"
 
-config TARGET_SOCFPGA_AGILEX5_SIMICS
-	bool "Enable build that bootable only on Agilex5 Simics platform"
+config TARGET_SOCFPGA_AGILEX5_TSN_AIC1
+	bool "Enable build that bootable only on Agilex5 TSN_PHY_AIC1 MuDV"
 
+config TARGET_SOCFPGA_AGILEX5_TSN_AIC2
+	bool "Enable build that bootable only on Agilex5 TSN_PHY_AIC2 MuDV"
 config TARGET_SOCFPGA_ARRIA5
 	bool
 	select TARGET_SOCFPGA_GEN5
 
 config TARGET_SOCFPGA_ARRIA10
 	bool
-	select GICV2
 	select SPL_ALTERA_SDRAM
 	select SPL_BOARD_INIT if SPL
 	select SPL_CACHE if SPL
-	select SPL_WDT if SPL
 	select CLK
 	select SPL_CLK if SPL
-	select DESIGNWARE_WATCHDOG
 	select DM_I2C
 	select DM_RESET
 	select SPL_DM_RESET if SPL
@@ -133,40 +101,16 @@ config TARGET_SOCFPGA_ARRIA10
 	select SYSCON
 	select SPL_SYSCON if SPL
 	select ETH_DESIGNWARE_SOCFPGA
-	select WDT
 	imply FPGA_SOCFPGA
+	imply SPL_USE_TINY_PRINTF
 
 config TARGET_SOCFPGA_CYCLONE5
 	bool
 	select TARGET_SOCFPGA_GEN5
 
-config TARGET_SOCFPGA_N5X
-	bool
-	select TARGET_SOCFPGA_SOC64
-	select ARMV8_MULTIENTRY
-	select ARMV8_SET_SMPEN
-	select BINMAN if SPL_ATF
-	select CLK
-	select GICV2
-	select NCORE_CACHE
-	select SPL_ALTERA_SDRAM
-	select SPL_CLK if SPL
-
-config TARGET_SOCFPGA_AGILEX_N6010
-	bool "Intel SOCFPGA n6010 (Agilex)"
-	select TARGET_SOCFPGA_AGILEX
-	select BINMAN if !SPL_ATF
-
-config TARGET_SOCFPGA_N5X_SOCDK
-	bool "Intel SOCFPGA SoCDK (N5X)"
-	select TARGET_SOCFPGA_N5X
-
 config TARGET_SOCFPGA_GEN5
 	bool
-	select GICV2
-	select DESIGNWARE_WATCHDOG
 	select SPL_ALTERA_SDRAM
-	select SPL_CACHE if SPL
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
 	imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
@@ -181,17 +125,11 @@ config TARGET_SOCFPGA_N5X
 	select BINMAN if SPL_ATF
 	select CLK
 	select FPGA_INTEL_SDM_MAILBOX
-	select GICV2
 	select NCORE_CACHE
 	select SPL_ALTERA_SDRAM
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
 
-config TARGET_SOCFPGA_AGILEX_N6010
-	bool "Intel SOCFPGA n6010 (Agilex)"
-	select TARGET_SOCFPGA_AGILEX
-	select BINMAN if !SPL_ATF
-
 config TARGET_SOCFPGA_N5X_SOCDK
 	bool "Intel eASIC SoCDK (N5X)"
 	select TARGET_SOCFPGA_N5X
@@ -205,8 +143,25 @@ config TARGET_SOCFPGA_STRATIX10
 	select ARMV8_SET_SMPEN
 	select BINMAN if SPL_ATF
 	select FPGA_INTEL_SDM_MAILBOX
-	select FPGA_STRATIX10
-	select GICV2
+	select TARGET_SOCFPGA_SOC64
+
+config ARMV8_PSCI_NR_CPUS
+	default 4 if TARGET_SOCFPGA_SOC64
+
+config ARMV8_SECURE_BASE
+	default 0x00001000 if TARGET_SOCFPGA_SOC64 && ARMV8_PSCI
+
+config SYS_HAS_ARMV8_SECURE_BASE
+	default y if TARGET_SOCFPGA_SOC64 && ARMV8_PSCI
+
+config TARGET_SOCFPGA_AGILEX5
+	bool
+	select BINMAN if SPL_ATF
+	select CLK
+	select FPGA_INTEL_SDM_MAILBOX
+	select GICV3
+	select NCORE_CACHE
+	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
 
 choice
@@ -221,10 +176,6 @@ config TARGET_SOCFPGA_AGILEX5_SOCDK
 	bool "Intel SOCFPGA SoCDK (Agilex5)"
 	select TARGET_SOCFPGA_AGILEX5
 
-config TARGET_SOCFPGA_AGILEX7_SOCDK
-	bool "Intel SOCFPGA SoCDK (Agilex7)"
-	select TARGET_SOCFPGA_AGILEX7
-
 config TARGET_SOCFPGA_ARIES_MCVEVK
 	bool "Aries MCVEVK (Cyclone V)"
 	select TARGET_SOCFPGA_CYCLONE5
@@ -298,9 +249,7 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
 endchoice
 
 config SYS_BOARD
-	default "agilex7-socdk" if TARGET_SOCFPGA_AGILEX7_SOCDK
 	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
-	default "agilex-n6010" if TARGET_SOCFPGA_AGILEX_N6010
 	default "agilex-socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "arria5-socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
 	default "arria10-socdk" if TARGET_SOCFPGA_ARRIA10_SOCDK
@@ -310,7 +259,6 @@ config SYS_BOARD
 	default "de0-nano-soc" if TARGET_SOCFPGA_TERASIC_DE0_NANO
 	default "de1-soc" if TARGET_SOCFPGA_TERASIC_DE1_SOC
 	default "de10-nano" if TARGET_SOCFPGA_TERASIC_DE10_NANO
-	default "n5x-socdk" if TARGET_SOCFPGA_N5X_SOCDK
 	default "de10-standard" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
 	default "is1" if TARGET_SOCFPGA_IS1
 	default "mcvevk" if TARGET_SOCFPGA_ARIES_MCVEVK
@@ -323,9 +271,7 @@ config SYS_BOARD
 	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
 config SYS_VENDOR
-	default "intel" if TARGET_SOCFPGA_AGILEX7_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
-	default "intel" if TARGET_SOCFPGA_AGILEX_N6010
 	default "intel" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "intel" if TARGET_SOCFPGA_N5X_SOCDK
 	default "altera" if TARGET_SOCFPGA_ARRIA5_SOCDK
@@ -348,9 +294,7 @@ config SYS_SOC
 	default "socfpga"
 
 config SYS_CONFIG_NAME
-	default "socfpga_agilex7_socdk" if TARGET_SOCFPGA_AGILEX7_SOCDK
 	default "socfpga_agilex5_socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
-	default "socfpga_agilex_n6010" if TARGET_SOCFPGA_AGILEX_N6010
 	default "socfpga_agilex_socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "socfpga_arria5_secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
 	default "socfpga_arria5_socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
@@ -361,7 +305,6 @@ config SYS_CONFIG_NAME
 	default "socfpga_de0_nano_soc" if TARGET_SOCFPGA_TERASIC_DE0_NANO
 	default "socfpga_de1_soc" if TARGET_SOCFPGA_TERASIC_DE1_SOC
 	default "socfpga_de10_nano" if TARGET_SOCFPGA_TERASIC_DE10_NANO
-	default "socfpga_n5x_socdk" if TARGET_SOCFPGA_N5X_SOCDK
 	default "socfpga_de10_standard" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
 	default "socfpga_is1" if TARGET_SOCFPGA_IS1
 	default "socfpga_mcvevk" if TARGET_SOCFPGA_ARIES_MCVEVK
@@ -372,4 +315,4 @@ config SYS_CONFIG_NAME
 	default "socfpga_stratix10_socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
 	default "socfpga_vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
-endif
\ No newline at end of file
+endif
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 575eab86ff..181bb01fdd 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 # Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
-# Copyright (C) 2017-2023 Intel Corporation <www.intel.com>
+# Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
 
 obj-y	+= board.o
 obj-y	+= clock_manager.o
@@ -35,22 +35,10 @@ obj-y	+= mailbox_s10.o
 obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
-obj-y	+= smmu_s10.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
-ifndef CONFIG_SPL_BUILD
-obj-y   += rsu.o
-obj-y   += rsu_ll_qspi.o
-obj-y   += rsu_misc.o
-obj-y	+= rsu_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += psci.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_ecc_dbe_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_fpga_reconfig_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_registers_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_rsu_s10.o
-endif
 endif
 
 ifdef CONFIG_TARGET_SOCFPGA_AGILEX
@@ -61,72 +49,11 @@ obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
-obj-y	+= smmu_s10.o
-obj-y	+= system_manager_soc64.o
-obj-y	+= timer_s10.o
-obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
-obj-y	+= wrap_handoff_soc64.o
-obj-y	+= wrap_pll_config_soc64.o
-ifndef CONFIG_SPL_BUILD
-obj-y   += rsu.o
-obj-y   += rsu_ll_qspi.o
-obj-y   += rsu_misc.o
-obj-y	+= rsu_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += psci.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_ecc_dbe_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_fpga_reconfig_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_registers_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_rsu_s10.o
-endif
-endif
-
-ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
-obj-y	+= clock_manager_agilex5.o
-obj-y	+= lowlevel_init_agilex5.o
-obj-y	+= mailbox_s10.o
-obj-y	+= misc_soc64.o
-obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
-obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
-obj-y	+= smmu_agilex5.o
-obj-y	+= system_manager_soc64.o
-obj-y	+= timer_s10.o
-obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
-obj-y	+= wrap_handoff_soc64.o
-obj-y	+= wrap_pll_config_soc64.o
-ifndef CONFIG_SPL_BUILD
-obj-y   += rsu.o
-obj-y   += rsu_ll_qspi.o
-obj-y   += rsu_misc.o
-obj-y	+= rsu_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += psci.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_ecc_dbe_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_fpga_reconfig_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_registers_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_rsu_s10.o
-endif
-endif
-
-ifdef CONFIG_TARGET_SOCFPGA_AGILEX7
-obj-y	+= clock_manager_agilex.o
-obj-y	+= lowlevel_init_soc64.o
-obj-y	+= mailbox_s10.o
-obj-y	+= misc_soc64.o
-obj-y	+= mmu-arm64_s10.o
-obj-y	+= reset_manager_s10.o
-obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
-obj-y	+= smmu_s10.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
 obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
-ifndef CONFIG_SPL_BUILD
-obj-y   += rsu.o
-obj-y   += rsu_ll_qspi.o
-obj-y   += rsu_misc.o
-obj-y	+= rsu_s10.o
-endif
 endif
 
 ifdef CONFIG_TARGET_SOCFPGA_N5X
@@ -137,22 +64,11 @@ obj-y	+= misc_soc64.o
 obj-y	+= mmu-arm64_s10.o
 obj-y	+= reset_manager_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
-obj-y	+= smmu_s10.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
 obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
-ifndef CONFIG_SPL_BUILD
-obj-y   += rsu.o
-obj-y   += rsu_ll_qspi.o
-obj-y   += rsu_misc.o
-obj-y	+= rsu_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += psci.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_ecc_dbe_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_registers_s10.o
-obj-$(CONFIG_ARMV8_PSCI) += smc_rsu_s10.o
-endif
 endif
 
 ifdef CONFIG_SPL_BUILD
@@ -172,22 +88,13 @@ obj-y	+= spl_a10.o
 endif
 ifdef CONFIG_TARGET_SOCFPGA_STRATIX10
 obj-y	+= spl_s10.o
-obj-y	+= spl_soc64.o
 endif
 ifdef CONFIG_TARGET_SOCFPGA_AGILEX
 obj-y	+= spl_agilex.o
-obj-y	+= spl_soc64.o
 endif
 ifdef CONFIG_TARGET_SOCFPGA_N5X
 obj-y	+= spl_n5x.o
-obj-y	+= spl_soc64.o
-endif
 ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
-obj-y	+= spl_agilex5.o
-obj-y	+= spl_soc64.o
-endif
-ifdef CONFIG_TARGET_SOCFPGA_AGILEX7
-obj-y	+= spl_agilex7.o
 obj-y	+= spl_soc64.o
 endif
 else
@@ -195,10 +102,6 @@ obj-$(CONFIG_SPL_ATF) += secure_reg_helper.o
 obj-$(CONFIG_SPL_ATF) += smc_api.o
 endif
 
-ifdef CONFIG_SOCFPGA_RSU_MULTIBOOT
-obj-y	+= rsu_spl.o
-endif
-
 ifdef CONFIG_TARGET_SOCFPGA_GEN5
 # QTS-generated config file wrappers
 CFLAGS_wrap_iocsr_config.o	+= -I$(srctree)/board/$(BOARDDIR)
diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index a6ace9fd9f..219e3f9d74 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -183,8 +183,6 @@ void board_prep_linux(struct bootm_headers *images)
 	if (use_fit && IS_ENABLED(CONFIG_CADENCE_QSPI)) {
 		if (env_get("linux_qspi_enable"))
 			run_command(env_get("linux_qspi_enable"), 0);
-		if (env_get("rsu_status"))
-			run_command(env_get("rsu_status"), 0);
 	}
 }
 #endif
diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
index 20de892414..8215238ac7 100644
--- a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2016-2023 Intel Corporation <www.intel.com>
+ * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
  */
 
 #ifndef _SOCFPGA_SOC64_BASE_HARDWARE_H_
@@ -32,14 +32,12 @@
 #define SOCFPGA_FW_DDR_CCU_DMI0_ADDRESS		0x18000800
 #define SOCFPGA_FW_DDR_CCU_DMI1_ADDRESS		0x18000A00
 #define SOCFPGA_FW_TBU2NOC_ADDRESS		0x18000C00
-#define SOCFPGA_FIREWALL_L4_PER			0xffd21000 /* TODO */
-#define SOCFPGA_FIREWALL_L4_SYS			0xffd21100 /* TODO */
-#define SOCFPGA_FIREWALL_SOC2FPGA		0xffd21200 /* TODO */
-#define SOCFPGA_FIREWALL_LWSOC2FPGA		0xffd21300 /* TODO */
-#define SOCFPGA_FIREWALL_TCU			0xffd21400 /* TODO */
-#define SOCFPGA_FIREWALL_PRIV_MEMORYMAP_PRIV	0xffd24800 /* TODO */
-#define SOCFPGA_DMANONSECURE_ADDRESS		0xffda0000 /* TODO */
-#define SOCFPGA_DMASECURE_ADDRESS		0xffda1000 /* TODO */
+#define SOCFPGA_FIREWALL_L4_PER			0x10d21000
+#define SOCFPGA_FIREWALL_L4_SYS			0x10d21100
+#define SOCFPGA_FIREWALL_SOC2FPGA		0x10d21200
+#define SOCFPGA_FIREWALL_LWSOC2FPGA		0x10d21300
+#define SOCFPGA_FIREWALL_TCU			0x10d21400
+#define SOCFPGA_FIREWALL_PRIV_MEMORYMAP_PRIV	0x10d24800
 #define GICD_BASE				0x1d000000
 #define GICR_BASE				0x1d060000
 #else
diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-socdk/MAINTAINERS
index e198308c43..b696f788c8 100755
--- a/board/intel/agilex5-socdk/MAINTAINERS
+++ b/board/intel/agilex5-socdk/MAINTAINERS
@@ -1,5 +1,7 @@
 SOCFPGA BOARD
 M:	Tien Fong Chee <tien.fong.chee@intel.com>
+M:	Teik Heng Chong <teik.heng.chong@intel.com>
+M:	Jit Loon Lim <jit.loon.lim@intel.com>
 S:	Maintained
 F:	board/intel/agilex5-socdk/
 F:	include/configs/socfpga_agilex5_socdk.h
diff --git a/board/intel/agilex5-socdk/Makefile b/board/intel/agilex5-socdk/Makefile
index 52f7de8880..d598d249e5 100755
--- a/board/intel/agilex5-socdk/Makefile
+++ b/board/intel/agilex5-socdk/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2022 Intel Corporation <www.intel.com>
+# Copyright (C) 2024 Intel Corporation <www.intel.com>
 #
 # SPDX-License-Identifier:	GPL-2.0
 #
diff --git a/board/intel/agilex5-socdk/socfpga.c b/board/intel/agilex5-socdk/socfpga.c
index ae5c04557c..f1b5fd9a14 100755
--- a/board/intel/agilex5-socdk/socfpga.c
+++ b/board/intel/agilex5-socdk/socfpga.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2022 Intel Corporation <www.intel.com>
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
  *
  */
 
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index fd3e1efc65..415c8e4a2b 100755
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -9,7 +9,6 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x04100000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
-CONFIG_TARGET_SOCFPGA_AGILEX5_SIMICS=y
 CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_agilex5"
 CONFIG_SPL_FS_FAT=y
@@ -34,35 +33,18 @@ CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_SF=y
-CONFIG_PHY=y
-CONFIG_SPL_PHY=y
-CONFIG_PHY_CADENCE_COMBOPHY=y
-CONFIG_DM_MMC=y
-CONFIG_SPL_MMC=y
-CONFIG_SPL_DM_MMC=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_ADMA=y
-CONFIG_SPL_MMC_SDHCI_ADMA=y
-CONFIG_SYS_MMC_MAX_BLK_COUNT=256
-CONFIG_MMC_SDHCI_CADENCE=y
-CONFIG_CMD_FAT=y
 CONFIG_DOS_PARTITION=y
 CONFIG_SPL_DOS_PARTITION=y
 CONFIG_SPL_SYS_DISABLE_DCACHE_OPS=y
 CONFIG_CMD_MTD=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_CMD_NAND_TRIMFFS=y
-CONFIG_CMD_NAND_LOCK_UNLOCK=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_SPL_MTD_SUPPORT=y
-CONFIG_MTDIDS_DEFAULT="nand0=10b80000.nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=10b80000.nand.0:2m(u-boot),-(root)"
 CONFIG_CMD_UBI=y
 CONFIG_CMD_UBIFS=y
 CONFIG_MTD_UBI=y
@@ -83,31 +65,22 @@ CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_MISC=y
-CONFIG_MMC_DW=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x0
-CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=0x100000
 CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_UBI_SILENCE_MSG=y
-CONFIG_PHY_MARVELL=y
 CONFIG_DM_ETH=y
-CONFIG_DWC_ETH_XGMAC=y
 CONFIG_RGMII=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_DESIGNWARE_SPI=y
-CONFIG_NOP_PHY=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_USB_DWC3=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_UBIFS_SILENCE_MSG=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
@@ -136,11 +109,5 @@ CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_I3C=y
 CONFIG_DW_I3C_MASTER=y
 CONFIG_CMD_I3C=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_CADENCE=y
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_SPL_NAND_FRAMEWORK=y
-CONFIG_SPL_NAND_CADENCE=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_TIMER=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
diff --git a/include/configs/socfpga_agilex5_socdk.h b/include/configs/socfpga_agilex5_socdk.h
index ad2b5632d1..b5b5bd767f 100755
--- a/include/configs/socfpga_agilex5_socdk.h
+++ b/include/configs/socfpga_agilex5_socdk.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright (C) 2019-2022 Intel Corporation <www.intel.com>
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
  *
  */
 
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index c21d8eb891..a4b6999f40 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright (C) 2017-2023 Intel Corporation <www.intel.com>
+ * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
  *
  */
 
@@ -14,35 +14,6 @@
 /*
  * U-Boot general configurations
  */
-/* sysmgr.boot_scratch_cold4 & 5 (64bit) will be used for PSCI_CPU_ON call */
-#define CPU_RELEASE_ADDR		0xFFD12210
-/* sysmgr.boot_scratch_cold8 bit 17 (1bit) will be used to check whether CPU0
- * is being powered off/on from kernel
- */
-#define BOOT_SCRATCH_COLD8		0xFFD12220
-
-/*
- * sysmgr.boot_scratch_cold6 & 7 (64bit) will be used by master CPU to
- * store its VBAR_EL3 value. Other slave CPUs will read from this
- * location and update their VBAR_EL3 respectively
- */
-#define VBAR_EL3_BASE_ADDR		0xFFD12218
-/*
- * Share sysmgr.boot_scratch_cold6 & 7 (64bit) with VBAR_LE3_BASE_ADDR
- * Indicate L2 reset is done. HPS should trigger warm reset via RMR_EL3.
- */
-#define L2_RESET_DONE_REG		0xFFD12218
-
-/*
- * sysmgr.boot_scratch_cold8 bit 19 (1bit) will be used to check whether CPU0
- * is being powered off/on from kernel
- */
-#define BOOT_SCRATCH_COLD8		0xFFD12220
-
-/* Magic word to indicate L2 reset is completed */
-#define L2_RESET_DONE_STATUS		0x1228E5E7
-#define CONFIG_SYS_CACHELINE_SIZE	64
-#define CFG_SYS_MEM_RESERVE_SECURE	0	/* using OCRAM, not DDR */
 
 /*
  * U-Boot console configurations
@@ -62,8 +33,7 @@
 /*
  * U-Boot environment configurations
  */
-
- /*
+/*
  * NAND support
  */
 #ifdef CONFIG_NAND_DENALI
@@ -298,12 +268,6 @@
  */
 #define CFG_SYS_NS16550_CLK		100000000
 
-/*
-=======
- * Timer & watchdog configurations
- */
-#define COUNTER_FREQUENCY		400000000
-
 /*
  * SDMMC configurations
  */
-- 
2.26.2

