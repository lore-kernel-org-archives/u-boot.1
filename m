Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CF5C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 07:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5395487E87;
	Mon, 26 Feb 2024 08:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="klJoUwtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8664D87E94; Mon, 26 Feb 2024 08:07:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B8C87E87
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 08:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=jitloonl@ecsmtp.png.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708931234; x=1740467234;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QrHGMcFsEeLXGwqj5KfcBNlCYIe4eSzvkobF80/sxg0=;
 b=klJoUwtqzXKIw0l3LauD0zM6QUU9hGnh0f9AMQU3q/ZMmMD2X2DRGoBB
 OefQWnZYbBA8/WliOhmLOFDUBBrG+gRfg/CKG+iUHe/CM3yIJAcnoZDdq
 CQE0yuLBGUEgqd3PjJ1SXcRzCphM63qbJYwTMgr6hCfri4FUyqFhZOIFK
 yn1ikt4TQX7WfrJEZUETVSCOFKERN+i3EziMCO0ShR1/DdosZS7dYCuLW
 7jzAv9GkHHW+BCrQ9JY95uMQkmqyo00keZNP92UD8K37RKZCHZIyHXARw
 OuoGDuYfdzT4Wz0ih60+7Jabz8Ewlec/DRJo38duSS8MFGg2Lm5HyUdvu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3061228"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3061228"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 23:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11160121"
Received: from pglmail07.png.intel.com ([10.126.73.9])
 by fmviesa003.fm.intel.com with ESMTP; 25 Feb 2024 23:07:09 -0800
Received: from localhost (pgli0121.png.intel.com [10.221.240.84])
 by pglmail07.png.intel.com (Postfix) with ESMTP id 6D5351644C;
 Mon, 26 Feb 2024 15:07:08 +0800 (+08)
Received: by localhost (Postfix, from userid 12048045)
 id 6A08B8E; Mon, 26 Feb 2024 15:07:08 +0800 (+08)
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
Subject: [PATCH v2 1/1] arch:arm: Agilex5 enablement
Date: Mon, 26 Feb 2024 15:07:04 +0800
Message-Id: <20240226070704.15153-2-jit.loon.lim@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240226070704.15153-1-jit.loon.lim@intel.com>
References: <20240226070704.15153-1-jit.loon.lim@intel.com>
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
Changes v1 -> v2:
- fixed git auto merge issue
---
 arch/arm/Kconfig                              |  13 +-
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      | 458 ++++++++++++
 arch/arm/dts/socfpga_agilex5.dtsi             | 654 ++++++++++++++++++
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 144 ++++
 arch/arm/dts/socfpga_agilex5_socdk.dts        | 163 +++++
 arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |  38 +-
 arch/arm/mach-socfpga/Kconfig                 |  69 +-
 arch/arm/mach-socfpga/Makefile                |   4 +-
 arch/arm/mach-socfpga/board.c                 |  56 +-
 .../include/mach/base_addr_soc64.h            |  44 +-
 board/intel/agilex5-socdk/MAINTAINERS         |   8 +
 board/intel/agilex5-socdk/Makefile            |   7 +
 configs/socfpga_agilex5_defconfig             | 113 +++
 include/configs/socfpga_agilex5_socdk.h       |  12 +
 include/configs/socfpga_soc64_common.h        | 209 +++++-
 16 files changed, 1957 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_agilex5-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk.dts
 create mode 100644 board/intel/agilex5-socdk/MAINTAINERS
 create mode 100644 board/intel/agilex5-socdk/Makefile
 create mode 100644 configs/socfpga_agilex5_defconfig
 create mode 100644 include/configs/socfpga_agilex5_socdk.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fde85dc0d5..baecb0463d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -28,6 +28,7 @@ config COUNTER_FREQUENCY
 			ROCKCHIP_RK3288 || ROCKCHIP_RK322X || ROCKCHIP_RK3036
 	default 25000000 if ARCH_LX2160A || ARCH_LX2162A || ARCH_LS1088A
 	default 100000000 if ARCH_ZYNQMP
+	default 200000000 if ARCH_SOCFPGA && ARM64 && TARGET_SOCFPGA_AGILEX5
 	default 0
 	help
 	  For platforms with ARMv8-A and ARMv7-A which features a system
@@ -1116,6 +1117,8 @@ config ARCH_SOCFPGA
 	select SPL_LIBGENERIC_SUPPORT
 	select SPL_OF_CONTROL
 	select SPL_SEPARATE_BSS if TARGET_SOCFPGA_SOC64
+	select SPL_DRIVERS_MISC if TARGET_SOCFPGA_SOC64
+	select SPL_SOCFPGA_SEC_REG if TARGET_SOCFPGA_SOC64
 	select SPL_SERIAL
 	select SPL_SYSRESET
 	select SPL_WATCHDOG
@@ -1124,7 +1127,8 @@ config ARCH_SOCFPGA
 	select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select SYSRESET
 	select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
-	select SYSRESET_SOCFPGA_SOC64 if TARGET_SOCFPGA_SOC64
+	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 && TARGET_SOCFPGA_SOC64
+	imply SYSRESET_SOCFPGA_AGILEX5 if TARGET_SOCFPGA_AGILEX5
 	imply CMD_DM
 	imply CMD_MTDPARTS
 	imply CRC32_VERIFY
@@ -1158,7 +1162,9 @@ config ARCH_SUNXI
 	select DM_SPI_FLASH if SPI && MTD
 	select DM_KEYBOARD
 	select DM_MMC if MMC
+	select DM_SCSI if SCSI
 	select DM_SERIAL
+	select GPIO_EXTRA_HEADER
 	select OF_BOARD_SETUP
 	select OF_CONTROL
 	select OF_SEPARATE
@@ -1865,7 +1871,7 @@ config TARGET_SL28
 	select PCI
 	select DM_RNG
 	select DM_RTC
-	select SCSI
+	select DM_SCSI
 	select DM_SERIAL
 	select DM_SPI
 	select GPIO_EXTRA_HEADER
@@ -2082,6 +2088,7 @@ config TARGET_POMELO
 	select PCI
 	select DM_PCI
 	select SCSI
+	select DM_SCSI
 	select DM_SERIAL
 	imply CMD_PCI
 	help
@@ -2375,4 +2382,4 @@ source "board/xen/xenguest_arm64/Kconfig"
 
 source "arch/arm/Kconfig.debug"
 
-endmenu
+endmenu
\ No newline at end of file
diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d9725030d5..2b4f896ad2 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -548,6 +548,7 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_agilex_socdk.dtb			\
+	socfpga_agilex5_socdk.dtb			\
 	socfpga_arria5_secu1.dtb			\
 	socfpga_arria5_socdk.dtb			\
 	socfpga_arria10_chameleonv3_270_2.dtb		\
diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
new file mode 100644
index 0000000000..daa8c982da
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#include "socfpga_soc64_fit-u-boot.dtsi"
+
+/{
+	memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		bootph-all;
+	};
+
+	soc {
+		bootph-all;
+
+		/* socfpga_secreg: socfpga-secreg { */
+			/* compatible = "intel,socfpga-secreg"; */
+			/* #address-cells = <1>; */
+			/* #size-cells = <1>; */
+			/* bootph-all; */
+
+			/* DSU */
+			i_ccu_caiu0@1c000000 {
+				reg = <0x1c000000 0x00001000>;
+				intel,offset-settings =
+					/* CAIUAMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* CAIUMIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DII1_MPFEREGS */
+					<0x00000414 0x00018000 0xffffffff>,
+					<0x00000418 0x00000000 0x000000ff>,
+					<0x00000410 0xc0e00200 0xc1f03e1f>,
+					/* DII2_GICREGS */
+					<0x00000424 0x0001d000 0xffffffff>,
+					<0x00000428 0x00000000 0x000000ff>,
+					<0x00000420 0xc0800400 0xc1f03e1f>,
+					/* NCAIU0_LWSOC2FPGA */
+					<0x00000444 0x00020000 0xffffffff>,
+					<0x00000448 0x00000000 0x000000ff>,
+					<0x00000440 0xc1100006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_1G */
+					<0x00000454 0x00040000 0xffffffff>,
+					<0x00000458 0x00000000 0x000000ff>,
+					<0x00000450 0xc1200006 0xc1f03e1f>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_16G */
+					<0x00000474 0x00400000 0xffffffff>,
+					<0x00000478 0x00000000 0x000000ff>,
+					<0x00000470 0xc1600006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_256G */
+					<0x00000494 0x04000000 0xffffffff>,
+					<0x00000498 0x00000000 0x000000ff>,
+					<0x00000490 0xc1a00006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>,
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* FPGA2SOC */
+			i_ccu_ncaiu0@1c001000 {
+				reg = <0x1c001000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU0AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* NCAIU0MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* PSS */
+					<0x00000404 0x00010000 0xffffffff>,
+					<0x00000408 0x00000000 0x000000ff>,
+					<0x00000400 0xC0F00000 0xc1f03e1f>,
+					/* DII1_MPFEREGS */
+					<0x00000414 0x00018000 0xffffffff>,
+					<0x00000418 0x00000000 0x000000ff>,
+					<0x00000410 0xc0e00200 0xc1f03e1f>,
+					/* NCAIU0_LWSOC2FPGA */
+					<0x00000444 0x00020000 0xffffffff>,
+					<0x00000448 0x00000000 0x000000ff>,
+					<0x00000440 0xc1100006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_1G */
+					<0x00000454 0x00040000 0xffffffff>,
+					<0x00000458 0x00000000 0x000000ff>,
+					<0x00000450 0xc1200006 0xc1f03e1f>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_16G */
+					<0x00000474 0x00400000 0xffffffff>,
+					<0x00000478 0x00000000 0x000000ff>,
+					<0x00000470 0xc1600006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* NCAIU0_SOC2FPGA_256G */
+					<0x00000494 0x04000000 0xffffffff>,
+					<0x00000498 0x00000000 0x000000ff>,
+					<0x00000490 0xc1a00006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>,
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* GIC_M */
+			i_ccu_ncaiu1@1c002000 {
+				reg = <0x1c002000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU1AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* NCAIU1MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>,
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* PSS NOC */
+			i_ccu_ncaiu3@1c004000 {
+				reg = <0x1c004000 0x00001000>;
+				intel,offset-settings =
+					/* NCAIU3AMIGR */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* NCAIU3MIFSR */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DII1_MPFEREGS */
+					<0x00000414 0x00018000 0xffffffff>,
+					<0x00000418 0x00000000 0x000000ff>,
+					<0x00000410 0xc0e00200 0xc1f03e1f>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>,
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE0 */
+			i_ccu_dce0@1c005000 {
+				reg = <0x1c005000 0x00001000>;
+				intel,offset-settings =
+					/* DCEUAMIGR0 */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DCEUMIFSR0 */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>,
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DCE1 */
+			i_ccu_dce1@1c006000 {
+				reg = <0x1c006000 0x00001000>;
+				intel,offset-settings =
+					/* DCEUAMIGR1 */
+					<0x000003c0 0x00000003 0x0000001f>,
+					/* DCEUMIFSR1 */
+					<0x000003c4 0x00000000 0x07070777>,
+					/* DMI_SDRAM_2G */
+					<0x00000464 0x00080000 0xffffffff>,
+					<0x00000468 0x00000000 0x000000ff>,
+					<0x00000460 0x81300006 0xc1f03e1f>,
+					/* DMI_SDRAM_30G */
+					<0x00000484 0x00800000 0xffffffff>,
+					<0x00000488 0x00000000 0x000000ff>,
+					<0x00000480 0x81700006 0xc1f03e1f>,
+					/* DMI_SDRAM_480G */
+					<0x000004a4 0x08000000 0xffffffff>,
+					<0x000004a8 0x00000000 0x000000ff>,
+					<0x000004a0 0x81b00006 0xc1f03e1f>;
+				bootph-all;
+			};
+
+			/* DMI0 */
+			i_ccu_dmi0@1c007000 {
+				reg = <0x1c007000 0x00001000>;
+				intel,offset-settings =
+					/* DMIUSMCTCR */
+					<0x00000300 0x00000003 0x00000003>;
+				bootph-all;
+			};
+
+			/* DMI1 */
+			i_ccu_dmi0@1c008000 {
+				reg = <0x1c008000 0x00001000>;
+				intel,offset-settings =
+					/* DMIUSMCTCR */
+					<0x00000300 0x00000003 0x00000003>;
+				bootph-all;
+			};
+
+			/* L4 peripherals firewall */
+			noc_fw_l4_per@10d21000 {
+				reg = <0x10d21000 0x0000008c>;
+				intel,offset-settings =
+					/* NAND */
+					<0x00000000 0x01010001 0x01010001>,
+					/* USB0 */
+					<0x0000000c 0x01010001 0x01010001>,
+					/* USB1 */
+					<0x00000010 0x01010001 0x01010001>,
+					/* SPI_MAIN0 */
+					<0x0000001c 0x01010301 0x01010301>,
+					/* SPI_MAIN1 */
+					<0x00000020 0x01010301 0x01010301>,
+					/* SPI_SECONDARY0 */
+					<0x00000024 0x01010301 0x01010301>,
+					/* SPI_SECONDARY1 */
+					<0x00000028 0x01010301 0x01010301>,
+					/* EMAC0 */
+					<0x0000002c 0x01010001 0x01010001>,
+					/* EMAC1 */
+					<0x00000030 0x01010001 0x01010001>,
+					/* EMAC2 */
+					<0x00000034 0x01010001 0x01010001>,
+					/* SDMMC */
+					<0x00000040 0x01010001 0x01010001>,
+					/* GPIO0 */
+					<0x00000044 0x01010301 0x01010301>,
+					/* GPIO1 */
+					<0x00000048 0x01010301 0x01010301>,
+					/* I2C0 */
+					<0x00000050 0x01010301 0x01010301>,
+					/* I2C1 */
+					<0x00000054 0x01010301 0x01010301>,
+					/* I2C2 */
+					<0x00000058 0x01010301 0x01010301>,
+					/* I2C3 */
+					<0x0000005c 0x01010301 0x01010301>,
+					/* I2C4 */
+					<0x00000060 0x01010301 0x01010301>,
+					/* SP_TIMER0 */
+					<0x00000064 0x01010301 0x01010301>,
+					/* SP_TIMER1 */
+					<0x00000068 0x01010301 0x01010301>,
+					/* UART0 */
+					<0x0000006c 0x01010301 0x01010301>,
+					/* UART1 */
+					<0x00000070 0x01010301 0x01010301>,
+					/* I3C0 */
+					<0x00000074 0x01010301 0x01010301>,
+					/* I3C1 */
+					<0x00000078 0x01010301 0x01010301>,
+					/* DMA0 */
+					<0x0000007c 0x01010001 0x01010001>,
+					/* DMA1 */
+					<0x00000080 0x01010001 0x01010001>,
+					/* COMBO_PHY */
+					<0x00000084 0x01010001 0x01010001>,
+					/* NAND_SDMA */
+					<0x00000088 0x01010301 0x01010301>;
+				bootph-all;
+			};
+
+			/* L4 system firewall */
+			noc_fw_l4_sys@10d21100 {
+				reg = <0x10d21100 0x00000098>;
+				intel,offset-settings =
+					/* DMA_ECC */
+					<0x00000008 0x01010001 0x01010001>,
+					/* EMAC0RX_ECC */
+					<0x0000000c 0x01010001 0x01010001>,
+					/* EMAC0TX_ECC */
+					<0x00000010 0x01010001 0x01010001>,
+					/* EMAC1RX_ECC */
+					<0x00000014 0x01010001 0x01010001>,
+					/* EMAC1TX_ECC */
+					<0x00000018 0x01010001 0x01010001>,
+					/* EMAC2RX_ECC */
+					<0x0000001c 0x01010001 0x01010001>,
+					/* EMAC2TX_ECC */
+					<0x00000020 0x01010001 0x01010001>,
+					/* NAND_ECC */
+					<0x0000002c 0x01010001 0x01010001>,
+					/* NAND_READ_ECC */
+					<0x00000030 0x01010001 0x01010001>,
+					/* NAND_WRITE_ECC */
+					<0x00000034 0x01010001 0x01010001>,
+					/* OCRAM_ECC */
+					<0x00000038 0x01010001 0x01010001>,
+					/* SDMMC_ECC */
+					<0x00000040 0x01010001 0x01010001>,
+					/* USB0_ECC */
+					<0x00000044 0x01010001 0x01010001>,
+					/* USB1_CACHEECC */
+					<0x00000048 0x01010001 0x01010001>,
+					/* CLOCK_MANAGER */
+					<0x0000004c 0x01010001 0x01010001>,
+					/* IO_MANAGER */
+					<0x00000054 0x01010001 0x01010001>,
+					/* RESET_MANAGER */
+					<0x00000058 0x01010001 0x01010001>,
+					/* SYSTEM_MANAGER */
+					<0x0000005c 0x01010001 0x01010001>,
+					/* OSC0_TIMER */
+					<0x00000060 0x01010301 0x01010301>,
+					/* OSC1_TIMER0*/
+					<0x00000064 0x01010301 0x01010301>,
+					/* WATCHDOG0 */
+					<0x00000068 0x01010301 0x01010301>,
+					/* WATCHDOG1 */
+					<0x0000006c 0x01010301 0x01010301>,
+					/* WATCHDOG2 */
+					<0x00000070 0x01010301 0x01010301>,
+					/* WATCHDOG3 */
+					<0x00000074 0x01010301 0x01010301>,
+					/* DAP */
+					<0x00000078 0x03010001 0x03010001>,
+					/* WATCHDOG4 */
+					<0x0000007c 0x01010301 0x01010301>,
+					/* POWER_MANAGER */
+					<0x00000080 0x01010001 0x01010001>,
+					/* USB1_RXECC */
+					<0x00000084 0x01010001 0x01010001>,
+					/* USB1_TXECC */
+					<0x00000088 0x01010001 0x01010001>,
+					/* L4_NOC_PROBES */
+					<0x00000090 0x01010001 0x01010001>,
+					/* L4_NOC_QOS */
+					<0x00000094 0x01010001 0x01010001>;
+				bootph-all;
+			};
+
+			/* Light weight SoC2FPGA */
+			noc_fw_lwsoc2fpga@10d21300 {
+				reg = <0x10d21300 0x0000004>;
+				intel,offset-settings =
+					/* LWSOC2FPGA_CSR */
+					<0x00000000 0x0ffe0301>;
+				bootph-all;
+			};
+
+			/* SoC2FPGA */
+			noc_fw_soc2fpga@10d21200 {
+				reg = <0x10d21200 0x0000004>;
+				intel,offset-settings =
+					/* SOC2FPGA_CSR */
+					<0x00000000 0x0ffe0301 0x0ffe0301>;
+				bootph-all;
+			};
+
+			/* TCU */
+			noc_fw_tcu@10d21400 {
+				reg = <0x10d21400 0x0000004>;
+				intel,offset-settings =
+					/* TCU_CSR */
+					<0x00000000 0x01010001 0x01010001>;
+				bootph-all;
+			};
+		};
+	};
+};
+
+&clkmgr {
+	bootph-all;
+};
+
+&i2c0 {
+	reset-names = "i2c";
+};
+
+&i2c1 {
+	reset-names = "i2c";
+};
+
+&i2c2 {
+	reset-names = "i2c";
+};
+
+&i2c3 {
+	reset-names = "i2c";
+};
+
+&mmc {
+	resets = <&rst SDMMC_RESET>, <&rst SDMMC_OCP_RESET>;
+};
+
+&porta {
+	bank-name = "porta";
+};
+
+&portb {
+	bank-name = "portb";
+};
+
+&qspi {
+	bootph-all;
+};
+
+&rst {
+	compatible = "altr,rst-mgr";
+	altr,modrst-offset = <0x24>;
+	bootph-all;
+};
+
+&sdr {
+	compatible = "intel,sdr-ctl-agilex5";
+	reg = <0x18000000 0x400000>,
+	      <0x18400000 0x400000>,
+	      <0x18800000 0x400000>;
+	resets = <&rst DDRSCH_RESET>;
+	bootph-all;
+};
+
+&sysmgr {
+	compatible = "altr,sys-mgr", "syscon";
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/socfpga_agilex5.dtsi b/arch/arm/dts/socfpga_agilex5.dtsi
new file mode 100644
index 0000000000..0be51d8e72
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5.dtsi
@@ -0,0 +1,654 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/reset/altr,rst-mgr-agx5.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/agilex5-clock.h>
+
+/ {
+	compatible = "intel,socfpga-agilex";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		service_reserved: svcbuffer@0 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x0 0x0 0x1000000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a55";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x1>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a76";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x2>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a76";
+			device_type = "cpu";
+			enable-method = "psci";
+			reg = <0x3>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <0 170 4>,
+			     <0 171 4>,
+			     <0 172 4>,
+			     <0 173 4>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
+		interrupt-parent = <&intc>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	intc: intc@fffc1000 {
+		compatible = "arm,gic-400", "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0x1d000000 0x0 0x10000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		device_type = "soc";
+		interrupt-parent = <&intc>;
+		ranges = <0 0 0 0xffffffff>;
+
+		base_fpga_region {
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			compatible = "fpga-region";
+			fpga-mgr = <&fpga_mgr>;
+		};
+
+		clkmgr: clock-controller@10d10000 {
+			compatible = "intel,agilex5-clkmgr";
+			reg = <0x10d10000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clocks {
+			cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+			};
+
+			cb_intosc_ls_clk: cb-intosc-ls-clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+			};
+
+			f2s_free_clk: f2s-free-clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+			};
+
+			osc1: osc1 {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+			};
+
+			qspi_clk: qspi-clk {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <200000000>;
+			};
+		};
+		gmac0: ethernet@10810000 {
+			compatible = "intel,socfpga-dwxgmac", "snps,dwxgmac-2.10", "snps,dwxgmac";
+			reg = <0x10810000 0x3500>;
+			interrupts = <0 190 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];
+			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
+			reset-names = "stmmaceth", "stmmaceth-ocp";
+			tx-fifo-depth = <32768>;
+			rx-fifo-depth = <16384>;
+			iommus = <&smmu 1>;
+			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
+			clocks = <&clkmgr AGILEX5_EMAC0_CLK>;
+			clock-names = "stmmaceth";
+			status = "disabled";
+		};
+
+		gmac1: ethernet@10820000 {
+			compatible = "intel,socfpga-dwxgmac", "snps,dwxgmac-2.10", "snps,dwxgmac";
+			reg = <0x10820000 0x3500>;
+			interrupts = <0 207 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];
+			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
+			reset-names = "stmmaceth", "stmmaceth-ocp";
+			tx-fifo-depth = <32768>;
+			rx-fifo-depth = <16384>;
+			iommus = <&smmu 2>;
+			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
+			clocks = <&clkmgr AGILEX5_EMAC1_CLK>;
+			clock-names = "stmmaceth";
+			status = "disabled";
+		};
+
+		gmac2: ethernet@10830000 {
+			compatible = "intel,socfpga-dwxgmac", "snps,dwxgmac-2.10", "snps,dwxgmac";
+			reg = <0x10830000 0x3500>;
+			interrupts = <0 224 4>;
+			interrupt-names = "macirq";
+			mac-address = [00 00 00 00 00 00];
+			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
+			reset-names = "stmmaceth", "stmmaceth-ocp";
+			tx-fifo-depth = <32768>;
+			rx-fifo-depth = <16384>;
+			iommus = <&smmu 3>;
+			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
+			clocks = <&clkmgr AGILEX5_EMAC2_CLK>;
+			clock-names = "stmmaceth";
+			status = "disabled";
+		};
+
+		gpio0: gpio@10c03200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x10c03200 0x80>;
+			resets = <&rst GPIO0_RESET>;
+			status = "disabled";
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <24>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 110 4>;
+			};
+		};
+
+		gpio1: gpio@10c03300 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x10c03300 0x80>;
+			resets = <&rst GPIO1_RESET>;
+			status = "disabled";
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <24>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 111 4>;
+			};
+		};
+
+		i2c0: i2c@10c02800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0x10c02800 0x100>;
+			interrupts = <0 103 4>;
+			resets = <&rst I2C0_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@10c02900 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0x10c02900 0x100>;
+			interrupts = <0 104 4>;
+			resets = <&rst I2C1_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@10c02a00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0x10c02a00 0x100>;
+			interrupts = <0 105 4>;
+			resets = <&rst I2C2_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@10c02b00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0x10c02b00 0x100>;
+			interrupts = <0 106 4>;
+			resets = <&rst I2C3_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@10c02c00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0x10c02c00 0x100>;
+			interrupts = <0 107 4>;
+			resets = <&rst I2C4_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
+			status = "disabled";
+		};
+
+		i3c0: i3c@10da0000 {
+			compatible = "snps,dw-i3c-master-1.00a";
+			reg = <0x10da0000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 164 4>;
+			resets = <&rst I3C0_RESET>;
+			max_devices = <11>;
+			clocks = <&clkmgr AGILEX5_L4_MP_CLK>;
+			status = "disabled";
+		};
+
+		i3c1: i3c@10da1000 {
+			compatible = "snps,dw-i3c-master-1.00a";
+			reg = <0x10da1000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 165 4>;
+			resets = <&rst I3C1_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_MP_CLK>;
+			max_devices = <11>;
+			status = "disabled";
+		};
+
+		combophy0: combophy@0 {
+			#phy-cells = <0>;
+			phy-type = <1>;
+			compatible = "cdns,combophy";
+			reg = <0x10808000 0x1000>;
+			resets = <&rst COMBOPHY_RESET>;
+			reset-names = "reset";
+			status = "disabled";
+		};
+
+		mmc: mmc0@10808000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "cdns,sd4hc";
+			reg = <0x10808000 0x1000>;
+			interrupts = <0 96 4>;
+			phys = <&combophy0>;
+			phy-names = "combo-phy";
+			clocks = <&clkmgr AGILEX5_L4_MP_CLK>,
+				 <&clkmgr AGILEX5_SDMMC_CLK>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x800>;
+			resets = <&rst SDMMC_RESET>;
+			reset-names = "reset";
+			iommus = <&smmu 5>;
+			status = "disabled";
+		};
+
+		nand: nand@10b80000 {
+			compatible = "cdns,nand";
+			reg = <0x10b80000 0x10000>,
+				<0x10840000 0x1000>;
+			reg-names = "reg", "sdma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 97 4>;
+			clocks = <&clkmgr AGILEX5_NAND_CLK>;
+			resets = <&rst NAND_RESET>, <&rst COMBOPHY_RESET>;
+			cdns,board-delay-ps = <4830>;
+			status = "disabled";
+		};
+
+		ocram: sram@00000000 {
+			compatible = "mmio-sram";
+			reg = <0x00000000 0x200000>;
+		};
+
+		rst: rstmgr@10d11000 {
+			#reset-cells = <1>;
+			compatible = "altr,stratix10-rst-mgr";
+			reg = <0x10d11000 0x1000>;
+		};
+
+		smmu: iommu@16000000 {
+			compatible = "arm,mmu-500", "arm,smmu-v2";
+			reg = <0x16000000 0x40000>;
+			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 128 4>,	/* Global Secure Fault */
+				<0 129 4>, /* Global Non-secure Fault */
+				/* Non-secure Context Interrupts (32) */
+				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
+				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
+				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
+				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
+				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
+				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
+				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
+				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
+			stream-match-mask = <0x7ff0>;
+			status = "disabled";
+		};
+
+		spi0: spi@10da4000 {
+			compatible = "intel,agilex-spi",
+				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x10da4000 0x1000>;
+			interrupts = <0 99 4>;
+			resets = <&rst SPIM0_RESET>;
+			reg-io-width = <4>;
+			num-cs = <4>;
+			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>;
+			status = "disabled";
+		};
+
+		spi1: spi@10da5000 {
+			compatible = "intel,agilex-spi",
+				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x10da5000 0x1000>;
+			interrupts = <0 100 4>;
+			resets = <&rst SPIM1_RESET>;
+			reg-io-width = <4>;
+			num-cs = <4>;
+			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>;
+			status = "disabled";
+		};
+
+		sysmgr: sysmgr@10d12000 {
+			compatible = "altr,sys-mgr-s10","altr,sys-mgr";
+			reg = <0x10d12000 0x500>;
+		};
+
+		/* Local timer */
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <1 13 0xf08>,
+				     <1 14 0xf08>,
+				     <1 11 0xf08>,
+				     <1 10 0xf08>;
+		};
+
+		timer0: timer0@10c03000 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 113 4>;
+			reg = <0x10c03000 0x100>;
+			resets = <&rst SPTIMER0_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
+			clock-names = "timer";
+			status = "disabled";
+		};
+
+		timer1: timer1@10c03100 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 114 4>;
+			reg = <0x10c03100 0x100>;
+			resets = <&rst SPTIMER1_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
+			clock-names = "timer";
+			status = "disabled";
+		};
+
+		timer2: timer2@10d00000 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 115 4>;
+			reg = <0x10d00000 0x100>;
+			resets = <&rst L4SYSTIMER0_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			clock-names = "timer";
+			status = "disabled";
+		};
+
+		timer3: timer3@10d00100 {
+			compatible = "snps,dw-apb-timer";
+			interrupts = <0 116 4>;
+			reg = <0x10d00100 0x100>;
+			resets = <&rst L4SYSTIMER1_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			clock-names = "timer";
+			status = "disabled";
+		};
+
+		uart0: serial0@10c02000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x10c02000 0x100>;
+			interrupts = <0 108 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			resets = <&rst UART0_RESET>;
+			status = "disabled";
+			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
+			clock-frequency = <100000000>;
+		};
+
+		uart1: serial1@10c02100 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x10c02100 0x100>;
+			interrupts = <0 109 4>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			resets = <&rst UART1_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
+			status = "disabled";
+		};
+
+		usbphy0: usbphy@0 {
+			#phy-cells = <0>;
+			compatible = "usb-nop-xceiv";
+			clocks = <&clkmgr AGILEX5_USB_CLK>;
+			status = "disabled";
+		};
+
+		usb0: usb@10b00000 {
+			compatible = "snps,dwc2";
+			reg = <0x10b00000 0x40000>;
+			interrupts = <0 93 4>;
+			phys = <&usbphy0>;
+			phy-names = "usb2-phy";
+			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
+			reset-names = "dwc2", "dwc2-ecc";
+			clocks = <&clkmgr AGILEX5_USB_CLK>;
+			iommus = <&smmu 6>;
+			status = "disabled";
+		};
+
+		usb31: usb31@11000000 {
+			compatible = "snps,dwc3";
+			reg = <0x11000000 0x100000>;
+			resets = <&rst USB1_RESET>;
+			phys = <&usbphy0>, <&usbphy0>;
+			phy-names = "usb2-phy", "usb3-phy";
+			dr_mode = "host";
+			maximum-speed = "super-speed";
+			snps,dis_u2_susphy_quirk;
+			status = "disabled";
+		};
+
+		watchdog0: watchdog@10d00200 {
+			compatible = "snps,dw-wdt";
+			reg = <0x10d00200 0x100>;
+			interrupts = <0 117 4>;
+			resets = <&rst WATCHDOG0_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			status = "disabled";
+		};
+
+		watchdog1: watchdog@10d00300 {
+			compatible = "snps,dw-wdt";
+			reg = <0x10d00300 0x100>;
+			interrupts = <0 118 4>;
+			resets = <&rst WATCHDOG1_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			status = "disabled";
+		};
+
+		watchdog2: watchdog@10d00400 {
+			compatible = "snps,dw-wdt";
+			reg = <0x10d00400 0x100>;
+			interrupts = <0 125 4>;
+			resets = <&rst WATCHDOG2_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			status = "disabled";
+		};
+
+		watchdog3: watchdog@10d00500 {
+			compatible = "snps,dw-wdt";
+			reg = <0x10d00500 0x100>;
+			interrupts = <0 126 4>;
+			resets = <&rst WATCHDOG3_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			status = "disabled";
+		};
+
+		watchdog4: watchdog@10d00600 {
+			compatible = "snps,dw-wdt";
+			reg = <0x10d00600 0x100>;
+			interrupts = <0 175 4>;
+			resets = <&rst WATCHDOG4_RESET>;
+			clocks = <&clkmgr AGILEX5_L4_SYS_FREE_CLK>;
+			status = "disabled";
+		};
+
+		sdr: sdr@10d21000 {
+			compatible = "altr,sdr-ctl", "syscon";
+			reg = <0x10d21000 0xc0>;
+		};
+
+		/* TODO: Update the ECC registers */
+		eccmgr {
+			compatible = "altr,socfpga-s10-ecc-manager",
+				     "altr,socfpga-a10-ecc-manager";
+			altr,sysmgr-syscon = <&sysmgr>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupts = <0 15 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ranges;
+
+			sdramedac {
+				compatible = "altr,sdram-edac-s10";
+				altr,sdr-syscon = <&sdr>;
+				interrupts = <16 4>;
+			};
+
+			ocram-ecc@ff8cc000 {
+				compatible = "altr,socfpga-s10-ocram-ecc",
+					     "altr,socfpga-a10-ocram-ecc";
+				reg = <0xff8cc000 0x100>;
+				altr,ecc-parent = <&ocram>;
+				interrupts = <1 4>;
+			};
+
+			usb0-ecc@ff8c4000 {
+				compatible = "altr,socfpga-s10-usb-ecc",
+					     "altr,socfpga-usb-ecc";
+				reg = <0xff8c4000 0x100>;
+				altr,ecc-parent = <&usb0>;
+				interrupts = <2 4>;
+			};
+
+			emac0-rx-ecc@ff8c0000 {
+				compatible = "altr,socfpga-s10-eth-mac-ecc",
+					     "altr,socfpga-eth-mac-ecc";
+				reg = <0xff8c0000 0x100>;
+				altr,ecc-parent = <&gmac0>;
+				interrupts = <4 4>;
+			};
+
+			emac0-tx-ecc@ff8c0400 {
+				compatible = "altr,socfpga-s10-eth-mac-ecc",
+					     "altr,socfpga-eth-mac-ecc";
+				reg = <0xff8c0400 0x100>;
+				altr,ecc-parent = <&gmac0>;
+				interrupts = <5 4>;
+			};
+
+			sdmmca-ecc@ff8c8c00 {
+				compatible = "altr,socfpga-s10-sdmmc-ecc",
+					     "altr,socfpga-sdmmc-ecc";
+				reg = <0xff8c8c00 0x100>;
+				altr,ecc-parent = <&mmc>;
+				interrupts = <14 4>,
+					     <15 4>;
+			};
+		};
+
+		/* QSPI address not available yet */
+		qspi: spi@108d2000 {
+			compatible = "cdns,qspi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x108d2000 0x100>,
+			      <0x10900000 0x100000>;
+			interrupts = <0 3 4>;
+			cdns,fifo-depth = <128>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x00000000>;
+			clocks = <&qspi_clk>;
+
+			status = "disabled";
+		};
+
+		firmware {
+			svc {
+				compatible = "intel,stratix10-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+
+				fpga_mgr: fpga-mgr {
+					compatible = "intel,stratix10-soc-fpga-mgr";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
new file mode 100644
index 0000000000..28e1c140c2
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	memory {
+		/* 8GB */
+		reg = <0 0x80000000 0 0x80000000>,
+		      <8 0x80000000 1 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	cap-mmc-highspeed;
+	bootph-all;
+};
+
+&combophy0 {
+	status = "okay";
+	bootph-all;
+	cdns,phy-use-ext-lpbk-dqs = <1>;
+	cdns,phy-use-lpbk-dqs = <1>;
+	cdns,phy-use-phony-dqs = <1>;
+	cdns,phy-use-phony-dqs-cmd = <1>;
+	cdns,phy-io-mask-always-on = <0>;
+	cdns,phy-io-mask-end = <5>;
+	cdns,phy-io-mask-start = <0>;
+	cdns,phy-data-select-oe-end = <1>;
+	cdns,phy-sync-method = <1>;
+	cdns,phy-sw-half-cycle-shift = <0>;
+	cdns,phy-rd-del-sel = <52>;
+	cdns,phy-underrun-suppress = <1>;
+	cdns,phy-gate-cfg-always-on = <1>;
+	cdns,phy-param-dll-bypass-mode = <1>;
+	cdns,phy-param-phase-detect-sel = <2>;
+	cdns,phy-param-dll-start-point = <254>;
+	cdns,phy-read-dqs-cmd-delay = <0>;
+	cdns,phy-clk-wrdqs-delay = <0>;
+	cdns,phy-clk-wr-delay = <0>;
+	cdns,phy-read-dqs-delay = <0>;
+	cdns,phy-phony-dqs-timing = <0>;
+	cdns,hrs09-rddata-en = <1>;
+	cdns,hrs09-rdcmd-en = <1>;
+	cdns,hrs09-extended-wr-mode = <1>;
+	cdns,hrs09-extended-rd-mode = <1>;
+	cdns,hrs10-hcsdclkadj = <3>;
+	cdns,hrs16-wrdata1-sdclk-dly = <0>;
+	cdns,hrs16-wrdata0-sdclk-dly = <0>;
+	cdns,hrs16-wrcmd1-sdclk-dly = <0>;
+	cdns,hrs16-wrcmd0-sdclk-dly = <0>;
+	cdns,hrs16-wrdata1-dly = <0>;
+	cdns,hrs16-wrdata0-dly = <0>;
+	cdns,hrs16-wrcmd1-dly = <0>;
+	cdns,hrs16-wrcmd0-dly = <0>;
+	cdns,hrs07-rw-compensate = <10>;
+	cdns,hrs07-idelay-val = <0>;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
+
+#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&fdt_0_blob {
+	filename = "arch/arm/dts/socfpga_agilex5_socdk.dtb";
+};
+
+/* To add NAND dtb when ready in future */
+
+&binman {
+	/delete-node/ kernel;
+};
+#endif
+
diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
new file mode 100644
index 0000000000..852e1e5ae3
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 SoCDK";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet2 = &gmac2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps2 {
+			label = "hps_led2";
+			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i3c0 {
+	status = "okay";
+};
+
+&i3c1 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&timer1 {
+	status = "okay";
+};
+
+&timer2 {
+	status = "okay";
+};
+
+&timer3 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&qspi {
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu02g";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x04200000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x04200000 0x0BE00000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
index 84b91e8df0..7a5af489c5 100644
--- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
@@ -2,7 +2,7 @@
 /*
  * U-Boot additions
  *
- * Copyright (C) 2020 Intel Corporation <www.intel.com>
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
  */
 
 #if defined(CONFIG_FIT)
@@ -21,14 +21,18 @@
 			description = "FIT with firmware and bootloader";
 			#address-cells = <1>;
 
-			images {
+			images: images {
 				uboot {
 					description = "U-Boot SoC64";
 					type = "standalone";
 					os = "U-Boot";
 					arch = "arm64";
 					compression = "none";
+				#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+					load = <0x80200000>;
+				#else
 					load = <0x00200000>;
+				#endif
 					uboot_blob: blob-ext {
 						filename = "u-boot-nodtb.bin";
 					};
@@ -43,8 +47,13 @@
 					os = "arm-trusted-firmware";
 					arch = "arm64";
 					compression = "none";
+				#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+					load = <0x80000000>;
+					entry = <0x80000000>;
+				#else
 					load = <0x00001000>;
 					entry = <0x00001000>;
+				#endif
 					atf_blob: blob-ext {
 						filename = "bl31.bin";
 					};
@@ -53,11 +62,11 @@
 					};
 				};
 
-				fdt {
-					description = "U-Boot SoC64 flat device-tree";
+				fdt-0 {
+					description = "socfpga_socdk";
 					type = "flat_dt";
 					compression = "none";
-					uboot_fdt_blob: blob-ext {
+					fdt_0_blob: blob-ext {
 						filename = "u-boot.dtb";
 					};
 					hash {
@@ -66,17 +75,18 @@
 				};
 			};
 
-			configurations {
-				default = "conf";
-				conf {
-					description = "Intel SoC64 FPGA";
+			board_config: configurations {
+				default = "board-0";
+
+				board-0 {
+					description = "board_0";
 					firmware = "atf";
 					loadables = "uboot";
-					fdt = "fdt";
+					fdt = "fdt-0";
 					signature {
 						algo = "crc32";
 						key-name-hint = "dev";
-						sign-images = "atf", "fdt", "uboot";
+						sign-images = "atf", "uboot", "fdt-0";
 					};
 				};
 			};
@@ -96,8 +106,8 @@
 					arch = "arm64";
 					os = "linux";
 					compression = "none";
-					load = <0x4080000>;
-					entry = <0x4080000>;
+					load = <0x6000000>;
+					entry = <0x6000000>;
 					kernel_blob: blob-ext {
 						filename = "Image";
 					};
@@ -146,7 +156,7 @@
 	filename = "signed-bl31.bin";
 };
 
-&uboot_fdt_blob {
+&fdt_0_blob {
 	filename = "signed-u-boot.dtb";
 };
 
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 114d243812..bb61e91ac3 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -8,7 +8,7 @@ config NR_DRAM_BANKS
 
 config SOCFPGA_SECURE_VAB_AUTH
 	bool "Enable boot image authentication with Secure Device Manager"
-	depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X
+	depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X || TARGET_SOCFPGA_AGILEX5
 	select FIT_IMAGE_POST_PROCESS
 	select SHA384
 	select SHA512
@@ -54,10 +54,51 @@ config TARGET_SOCFPGA_AGILEX
 	select BINMAN if SPL_ATF
 	select CLK
 	select FPGA_INTEL_SDM_MAILBOX
+	select GICV2
 	select NCORE_CACHE
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
 
+config TARGET_SOCFPGA_AGILEX5
+	bool
+	select BINMAN if SPL_ATF
+	select CLK
+	select FPGA_INTEL_SDM_MAILBOX
+	select GICV3
+	select NCORE_CACHE
+	select SPL_CLK if SPL
+	select TARGET_SOCFPGA_SOC64
+
+config TARGET_SOCFPGA_AGILEX5_OOBE2
+	bool "Enable build that bootable only on Agilex5 OOBE2 DevKit"
+	help
+	 This is for Agilex5 platform.
+	 It enable build that bootable only on Agilex5 OOBE2 DevKit.
+
+config TARGET_SOCFPGA_AGILEX5_NAND2
+	bool "Enable build that bootable only on Agilex5 NAND2 DevKit"
+	help
+	 This is for Agilex5 platform.
+	 Enable build that bootable only on Agilex5 NAND2 DevKit.
+
+config TARGET_SOCFPGA_AGILEX5_TSN_AIC0
+	bool "Enable build that bootable only on Agilex5 TSN_PHY_AIC0 MuDV"
+	help
+	 This is for Agilex5 platform.
+	 Enable build that bootable only on Agilex5 TSN_PHY_AIC0 MuDV.
+
+config TARGET_SOCFPGA_AGILEX5_TSN_AIC1
+	bool "Enable build that bootable only on Agilex5 TSN_PHY_AIC1 MuDV"
+	help
+	 This is for Agilex5 platform.
+	 Enable build that bootable only on Agilex5 TSN_PHY_AIC1 MuDV.
+
+config TARGET_SOCFPGA_AGILEX5_TSN_AIC2
+	bool "Enable build that bootable only on Agilex5 TSN_PHY_AIC2 MuDV"
+	help
+	 This is for Agilex5 platform.
+	 Enable build that bootable only on Agilex5 TSN_PHY_AIC2 MuDV.
+
 config TARGET_SOCFPGA_ARRIA5
 	bool
 	select TARGET_SOCFPGA_GEN5
@@ -121,6 +162,25 @@ config TARGET_SOCFPGA_STRATIX10
 	select FPGA_INTEL_SDM_MAILBOX
 	select TARGET_SOCFPGA_SOC64
 
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
+	select TARGET_SOCFPGA_SOC64
+
 choice
 	prompt "Altera SOCFPGA board select"
 	optional
@@ -129,6 +189,10 @@ config TARGET_SOCFPGA_AGILEX_SOCDK
 	bool "Intel SOCFPGA SoCDK (Agilex)"
 	select TARGET_SOCFPGA_AGILEX
 
+config TARGET_SOCFPGA_AGILEX5_SOCDK
+	bool "Intel SOCFPGA SoCDK (Agilex5)"
+	select TARGET_SOCFPGA_AGILEX5
+
 config TARGET_SOCFPGA_ARIES_MCVEVK
 	bool "Aries MCVEVK (Cyclone V)"
 	select TARGET_SOCFPGA_CYCLONE5
@@ -202,6 +266,7 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
 endchoice
 
 config SYS_BOARD
+	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "agilex-socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "arria5-socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
 	default "arria10-socdk" if TARGET_SOCFPGA_ARRIA10_SOCDK
@@ -223,6 +288,7 @@ config SYS_BOARD
 	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
 config SYS_VENDOR
+	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "intel" if TARGET_SOCFPGA_N5X_SOCDK
 	default "altera" if TARGET_SOCFPGA_ARRIA5_SOCDK
@@ -245,6 +311,7 @@ config SYS_SOC
 	default "socfpga"
 
 config SYS_CONFIG_NAME
+	default "socfpga_agilex5_socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "socfpga_agilex_socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "socfpga_arria5_secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
 	default "socfpga_arria5_socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index ec38b64dd4..181bb01fdd 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 # Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
-# Copyright (C) 2017-2021 Intel Corporation <www.intel.com>
+# Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
 
 obj-y	+= board.o
 obj-y	+= clock_manager.o
@@ -94,6 +94,8 @@ obj-y	+= spl_agilex.o
 endif
 ifdef CONFIG_TARGET_SOCFPGA_N5X
 obj-y	+= spl_n5x.o
+ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
+obj-y	+= spl_soc64.o
 endif
 else
 obj-$(CONFIG_SPL_ATF) += secure_reg_helper.o
diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 09e09192fb..616e1afe5d 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -7,9 +7,11 @@
 
 #include <common.h>
 #include <asm/arch/clock_manager.h>
+#include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/secure_vab.h>
+#include <asm/arch/smc_api.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
@@ -23,6 +25,8 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define DEFAULT_JTAG_USERCODE 0xFFFFFFFF
+
 void s_init(void) {
 #ifndef CONFIG_ARM64
 	/*
@@ -92,13 +96,50 @@ int g_dnl_board_usb_cable_connected(void)
 }
 #endif
 
-#ifdef CONFIG_SPL_BUILD
-__weak int board_fit_config_name_match(const char *name)
+u8 socfpga_get_board_id(void)
 {
-	/* Just empty function now - can't decide what to choose */
-	debug("%s: %s\n", __func__, name);
+	u8 board_id = 0;
+	u32 jtag_usercode;
+	int err;
 
-	return 0;
+#if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_SPL_ATF)
+	err = smc_get_usercode(&jtag_usercode);
+#else
+	u32 resp_len = 1;
+
+	err = mbox_send_cmd(MBOX_ID_UBOOT, MBOX_GET_USERCODE, MBOX_CMD_DIRECT, 0,
+			    NULL, 0, &resp_len, &jtag_usercode);
+#endif
+
+	if (err) {
+		puts("Fail to read JTAG Usercode. Default Board ID to 0\n");
+		return board_id;
+	}
+
+	debug("Valid JTAG Usercode: %u\n", jtag_usercode);
+
+	if (jtag_usercode == DEFAULT_JTAG_USERCODE) {
+		debug("JTAG Usercode is not set. Default Board ID to 0\n");
+	} else if (jtag_usercode >= 0 && jtag_usercode <= 255) {
+		board_id = jtag_usercode;
+		debug("Valid JTAG Usercode. Set Board ID to %u\n", board_id);
+	} else {
+		puts("Board ID is not in range 0 to 255\n");
+	}
+
+	return board_id;
+}
+
+#if IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
+int board_fit_config_name_match(const char *name)
+{
+	char board_name[10];
+
+	sprintf(board_name, "board_%u", socfpga_get_board_id());
+
+	debug("Board name: %s\n", board_name);
+
+	return strcmp(name, board_name);
 }
 #endif
 
@@ -116,6 +157,8 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 #if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_FIT)
 void board_prep_linux(struct bootm_headers *images)
 {
+	bool use_fit = false;
+
 	if (!images->fit_uname_cfg) {
 		if (IS_ENABLED(CONFIG_SOCFPGA_SECURE_VAB_AUTH) &&
 		    !IS_ENABLED(CONFIG_SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE)) {
@@ -127,12 +170,13 @@ void board_prep_linux(struct bootm_headers *images)
 			hang();
 		}
 	} else {
+		use_fit = true;
 		/* Update fdt_addr in enviroment variable */
 		env_set_hex("fdt_addr", (ulong)images->ft_addr);
 		debug("images->ft_addr = 0x%08lx\n", (ulong)images->ft_addr);
 	}
 
-	if (IS_ENABLED(CONFIG_CADENCE_QSPI)) {
+	if (use_fit && IS_ENABLED(CONFIG_CADENCE_QSPI)) {
 		if (env_get("linux_qspi_enable"))
 			run_command(env_get("linux_qspi_enable"), 0);
 	}
diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
index 3f899fcfa3..8215238ac7 100644
--- a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
@@ -1,21 +1,59 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2016-2021 Intel Corporation <www.intel.com>
+ * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
  */
 
 #ifndef _SOCFPGA_SOC64_BASE_HARDWARE_H_
 #define _SOCFPGA_SOC64_BASE_HARDWARE_H_
 
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define SOCFPGA_CCU_ADDRESS			0x1c000000
+#define SOCFPGA_F2SDRAM_MGR_ADDRESS		0x18001000
+#define SOCFPGA_SMMU_ADDRESS			0x16000000
+#define SOCFPGA_OCRAM_FIREWALL_ADDRESS		0x108cc400
+#define SOCFPGA_MAILBOX_ADDRESS			0x10a30000
+#define SOCFPGA_UART0_ADDRESS			0x10c02000
+#define SOCFPGA_UART1_ADDRESS			0x10c02100
+#define SOCFPGA_SPTIMER0_ADDRESS		0x10c03000
+#define SOCFPGA_SPTIMER1_ADDRESS		0x10c03100
+#define SOCFPGA_SYSTIMER0_ADDRESS		0x10d00000
+#define SOCFPGA_SYSTIMER1_ADDRESS		0x10d00100
+#define SOCFPGA_L4WD0_ADDRESS			0x10d00200
+#define SOCFPGA_L4WD1_ADDRESS			0x10d00300
+#define SOCFPGA_L4WD2_ADDRESS			0x10d00400
+#define SOCFPGA_L4WD3_ADDRESS			0x10d00500
+#define SOCFPGA_L4WD4_ADDRESS			0x10d00600
+#define SOCFPGA_GTIMER_SEC_ADDRESS		0x10d01000
+#define SOCFPGA_GTIMER_NSEC_ADDRESS		0x10d02000
+#define SOCFPGA_CLKMGR_ADDRESS			0x10d10000
+#define SOCFPGA_RSTMGR_ADDRESS			0x10d11000
+#define SOCFPGA_SYSMGR_ADDRESS			0x10d12000
+#define SOCFPGA_OCRAM_ADDRESS			0x00000000
+#define SOCFPGA_FW_DDR_CCU_DMI0_ADDRESS		0x18000800
+#define SOCFPGA_FW_DDR_CCU_DMI1_ADDRESS		0x18000A00
+#define SOCFPGA_FW_TBU2NOC_ADDRESS		0x18000C00
+#define SOCFPGA_FIREWALL_L4_PER			0x10d21000
+#define SOCFPGA_FIREWALL_L4_SYS			0x10d21100
+#define SOCFPGA_FIREWALL_SOC2FPGA		0x10d21200
+#define SOCFPGA_FIREWALL_LWSOC2FPGA		0x10d21300
+#define SOCFPGA_FIREWALL_TCU			0x10d21400
+#define SOCFPGA_FIREWALL_PRIV_MEMORYMAP_PRIV	0x10d24800
+#define GICD_BASE				0x1d000000
+#define GICR_BASE				0x1d060000
+#else
 #define SOCFPGA_CCU_ADDRESS			0xf7000000
 #define SOCFPGA_SDR_SCHEDULER_ADDRESS		0xf8000400
 #define SOCFPGA_HMC_MMR_IO48_ADDRESS		0xf8010000
 #define SOCFPGA_SDR_ADDRESS			0xf8011000
+#define SOCFPGA_FW_MPFE_SCR_ADDRESS		0xf8020000
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7)
 #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS		0xf8020200
 #else
 #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS		0xf8020100
 #endif
+#define SOCFPGA_F2SDRAM_MGR_ADDRESS		0xf8024000
 #define SOCFPGA_SMMU_ADDRESS			0xfa000000
 #define SOCFPGA_MAILBOX_ADDRESS			0xffa30000
 #define SOCFPGA_UART0_ADDRESS			0xffc02000
@@ -39,10 +77,12 @@
 #define SOCFPGA_FIREWALL_SOC2FPGA		0xffd21200
 #define SOCFPGA_FIREWALL_LWSOC2FPGA		0xffd21300
 #define SOCFPGA_FIREWALL_TCU			0xffd21400
+#define SOCFPGA_FIREWALL_PRIV_MEMORYMAP_PRIV	0xffd24800
 #define SOCFPGA_DMANONSECURE_ADDRESS		0xffda0000
 #define SOCFPGA_DMASECURE_ADDRESS		0xffda1000
 #define SOCFPGA_OCRAM_ADDRESS			0xffe00000
 #define GICD_BASE				0xfffc1000
 #define GICC_BASE				0xfffc2000
+#endif /* IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) */
 
 #endif /* _SOCFPGA_SOC64_BASE_HARDWARE_H_ */
diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-socdk/MAINTAINERS
new file mode 100644
index 0000000000..b696f788c8
--- /dev/null
+++ b/board/intel/agilex5-socdk/MAINTAINERS
@@ -0,0 +1,8 @@
+SOCFPGA BOARD
+M:	Tien Fong Chee <tien.fong.chee@intel.com>
+M:	Teik Heng Chong <teik.heng.chong@intel.com>
+M:	Jit Loon Lim <jit.loon.lim@intel.com>
+S:	Maintained
+F:	board/intel/agilex5-socdk/
+F:	include/configs/socfpga_agilex5_socdk.h
+F:	configs/socfpga_agilex5_defconfig
diff --git a/board/intel/agilex5-socdk/Makefile b/board/intel/agilex5-socdk/Makefile
new file mode 100644
index 0000000000..d598d249e5
--- /dev/null
+++ b/board/intel/agilex5-socdk/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2024 Intel Corporation <www.intel.com>
+#
+# SPDX-License-Identifier:	GPL-2.0
+#
+
+obj-y	:= socfpga.o
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
new file mode 100644
index 0000000000..415c8e4a2b
--- /dev/null
+++ b/configs/socfpga_agilex5_defconfig
@@ -0,0 +1,113 @@
+CONFIG_ARM=y
+CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x04100000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
+CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=y
+CONFIG_IDENT_STRING="socfpga_agilex5"
+CONFIG_SPL_FS_FAT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+# CONFIG_USE_SPL_FIT_GENERATOR is not set
+CONFIG_QSPI_BOOT=y
+CONFIG_BOOTDELAY=5
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 initrd=0x90000000 root=/dev/ram0 rw init=/sbin/init ramdisk_size=10000000 earlycon panic=-1 nosmp kvm-arm.mode=nvhe"
+CONFIG_LEGACY_IMAGE_FORMAT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_CRC32=y
+CONFIG_SPL_CACHE=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SYS_PROMPT="SOCFPGA_AGILEX5 # "
+CONFIG_CMD_NVEDIT_SELECT=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_SF=y
+CONFIG_DOS_PARTITION=y
+CONFIG_SPL_DOS_PARTITION=y
+CONFIG_SPL_SYS_DISABLE_DCACHE_OPS=y
+CONFIG_CMD_MTD=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_CACHE=y
+CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_CMD_UBI=y
+CONFIG_CMD_UBIFS=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_WL_THRESHOLD=4096
+CONFIG_MTD_UBI_BEB_LIMIT=20
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_OF_LIST=""
+CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_UBI_PART="root"
+CONFIG_ENV_UBI_VOLUME="env"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_ALTERA_SDRAM=y
+CONFIG_FPGA_INTEL_PR=y
+CONFIG_DWAPB_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_DW=y
+CONFIG_MISC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_SF_DEFAULT_MODE=0x2003
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_UBI_SILENCE_MSG=y
+CONFIG_DM_ETH=y
+CONFIG_RGMII=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_DESIGNWARE_SPI=y
+CONFIG_USB=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_UBIFS_SILENCE_MSG=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_PANIC_HANG=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_WDT=y
+CONFIG_CMD_WDT=y
+CONFIG_DESIGNWARE_WATCHDOG=y
+CONFIG_SPL_WDT=y
+CONFIG_WATCHDOG_AUTOSTART=n
+CONFIG_TIMER=y
+CONFIG_DESIGNWARE_APB_TIMER=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xbff00000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK=0x7f000
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0xbfa00000
+CONFIG_SYS_SPL_MALLOC_SIZE=0x500000
+CONFIG_SPL_BSS_MAX_SIZE=0x100000
+# CONFIG_EFI_LOADER is not set
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
+CONFIG_CMD_I3C=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_TIMER=y
diff --git a/include/configs/socfpga_agilex5_socdk.h b/include/configs/socfpga_agilex5_socdk.h
new file mode 100644
index 0000000000..b5b5bd767f
--- /dev/null
+++ b/include/configs/socfpga_agilex5_socdk.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ *
+ */
+
+#ifndef __CONFIG_SOCFGPA_AGILEX5_H__
+#define __CONFIG_SOCFGPA_AGILEX5_H__
+
+#include <configs/socfpga_soc64_common.h>
+
+#endif	/* __CONFIG_SOCFGPA_AGILEX5_H__ */
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 820372c28b..26a7ad1a5c 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
  *
  */
 
@@ -14,29 +14,193 @@
 /*
  * U-Boot general configurations
  */
-/* sysmgr.boot_scratch_cold4 & 5 (64bit) will be used for PSCI_CPU_ON call */
-#define CPU_RELEASE_ADDR		0xFFD12210
 
 /*
  * U-Boot console configurations
  */
 
-/* Extend size of kernel image for uncompression */
-
 /*
  * U-Boot run time memory configurations
  */
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define CFG_SYS_INIT_RAM_ADDR	0x0
+#define CFG_SYS_INIT_RAM_SIZE	0x80000
+#else
 #define CFG_SYS_INIT_RAM_ADDR	0xFFE00000
 #define CFG_SYS_INIT_RAM_SIZE	0x40000
+#endif
 
 /*
  * U-Boot environment configurations
  */
+/*
+ * NAND support
+ */
+#ifdef CONFIG_NAND_DENALI
+#define CONFIG_SYS_NAND_ONFI_DETECTION
+#define CONFIG_SYS_MAX_NAND_DEVICE	1
+
+#define CFG_SYS_NAND_U_BOOT_SIZE	(1 * 1024 * 1024)
+#define CFG_SYS_NAND_U_BOOT_DST	CONFIG_TEXT_BASE
+#endif /* CONFIG_NAND_DENALI */
 
 /*
  * Environment variable
  */
+#if IS_ENABLED(CONFIG_SPL_ATF)
+#define CONFIG_BOOTFILE "kernel.itb"
+#else
+#define CONFIG_BOOTFILE "Image"
+#endif
+
+#if IS_ENABLED(CONFIG_DISTRO_DEFAULTS)
+#if IS_ENABLED(CONFIG_CMD_MMC)
+#define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0)
+#else
+#define BOOT_TARGET_DEVICES_MMC(func)
+#endif
+
+#if IS_ENABLED(CONFIG_CMD_SF)
+#define BOOT_TARGET_DEVICES_QSPI(func) func(QSPI, qspi, na)
+#else
+#define BOOT_TARGET_DEVICES_QSPI(func)
+#endif
+
+#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
+	"bootcmd_qspi=ubi detach; sf probe && " \
+	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
+	"setenv mtdparts 'mtdparts=nor0:66m(u-boot),190m(root);" \
+	"nand.0:2m(u-boot),500m(nand_root)' && env select UBI; saveenv && " \
+	"ubi part root && " \
+	"if ubi part root && ubi readvol ${scriptaddr} script; " \
+	"then echo QSPI: Running script from UBIFS; " \
+	"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; " \
+	"then echo QSPI: Running script from JFFS2; fi; " \
+	"echo QSPI: Trying to boot script at ${scriptaddr} && " \
+	"source ${scriptaddr}; " \
+	"echo QSPI: SCRIPT FAILED: continuing...; ubi detach;\0"
+
+#define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
+	"qspi "
+
+#if IS_ENABLED(CONFIG_CMD_NAND)
+# define BOOT_TARGET_DEVICES_NAND(func)	func(NAND, nand, na)
+#else
+# define BOOT_TARGET_DEVICES_NAND(func)
+#endif
+
+#define BOOTENV_DEV_NAND(devtypeu, devtypel, instance) \
+	"bootcmd_nand=ubi detach && " \
+	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
+	"setenv mtdparts 'mtdparts=nor0:66m(u-boot),190m(qspi_root);" \
+	"nand.0:2m(u-boot),500m(root)' && env select UBI; saveenv && " \
+	"ubi part root && " \
+	"ubi readvol ${scriptaddr} script && " \
+	"echo NAND: Trying to boot script at ${scriptaddr} && " \
+	"source ${scriptaddr}; " \
+	"echo NAND: SCRIPT FAILED: continuing...; ubi detach;\0"
+
+#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
+	"nand "
+
+#define BOOT_TARGET_DEVICES(func) \
+	BOOT_TARGET_DEVICES_MMC(func) \
+	BOOT_TARGET_DEVICES_QSPI(func) \
+	BOOT_TARGET_DEVICES_NAND(func)
+
+#include <config_distro_bootcmd.h>
+
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+
 #define CFG_EXTRA_ENV_SETTINGS \
+	"kernel_addr_r=0x82000000\0" \
+	"fdt_addr_r=0x86000000\0" \
+	"qspiscriptaddr=0x02110000\0" \
+	"scriptsize=0x00010000\0" \
+	"qspibootimageaddr=0x02120000\0" \
+	"bootimagesize=0x03200000\0" \
+	"loadaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
+	"bootfile=" CONFIG_BOOTFILE "\0" \
+	"mmcroot=/dev/mmcblk0p2\0" \
+	"mtdids=" CONFIG_MTDIDS_DEFAULT "\0" \
+	"mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0" \
+	"linux_qspi_enable=if sf probe; then " \
+		"echo Enabling QSPI at Linux DTB...;" \
+		"fdt addr ${fdt_addr}; fdt resize;" \
+		"fdt set /soc/spi@108d2000 status okay;" \
+		"if fdt set /clocks/qspi-clk clock-frequency" \
+		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
+		" elif fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency" \
+		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
+		" else fdt set /clocks/qspi-clk clock-frequency" \
+		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
+	"scriptaddr=0x81000000\0" \
+	"scriptfile=boot.scr\0" \
+	"nandroot=ubi0:rootfs\0" \
+	"nandfitboot=setenv bootargs " CONFIG_BOOTARGS \
+			" root=${nandroot} rw rootwait rootfstype=ubifs ubi.mtd=1; " \
+			"bootm ${loadaddr}\0" \
+	"nandfitload=ubi part root; ubi readvol ${loadaddr} kernel\0" \
+	"socfpga_legacy_reset_compat=1\0" \
+	"rsu_status=rsu dtb; rsu display_dcmf_version; "\
+		"rsu display_dcmf_status; rsu display_max_retry\0" \
+	"smc_fid_rd=0xC2000007\0" \
+	"smc_fid_wr=0xC2000008\0" \
+	"smc_fid_upd=0xC2000009\0 " \
+	BOOTENV
+
+#else
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	"kernel_addr_r=0x2000000\0" \
+	"fdt_addr_r=0x6000000\0" \
+	"qspiscriptaddr=0x02110000\0" \
+	"scriptsize=0x00010000\0" \
+	"qspibootimageaddr=0x02120000\0" \
+	"bootimagesize=0x03200000\0" \
+	"loadaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
+	"bootfile=" CONFIG_BOOTFILE "\0" \
+	"mmcroot=/dev/mmcblk0p2\0" \
+	"mtdids=" CONFIG_MTDIDS_DEFAULT "\0" \
+	"mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0" \
+	"linux_qspi_enable=if sf probe; then " \
+		"echo Enabling QSPI at Linux DTB...;" \
+		"fdt addr ${fdt_addr}; fdt resize;" \
+		"fdt set /soc/spi@ff8d2000 status okay;" \
+		"if fdt set /soc/clocks/qspi-clk clock-frequency" \
+		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
+		" elif fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency" \
+		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
+		" else fdt set /clocks/qspi-clk clock-frequency" \
+		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
+	"scriptaddr=0x05FF0000\0" \
+	"scriptfile=boot.scr\0" \
+	"nandroot=ubi0:rootfs\0" \
+	"socfpga_legacy_reset_compat=1\0" \
+	"rsu_status=rsu dtb; rsu display_dcmf_version; "\
+		"rsu display_dcmf_status; rsu display_max_retry\0" \
+	"smc_fid_rd=0xC2000007\0" \
+	"smc_fid_wr=0xC2000008\0" \
+	"smc_fid_upd=0xC2000009\0 " \
+	BOOTENV
+#endif /*#IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)*/
+
+#else
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	"kernel_comp_addr_r=0x9000000\0" \
+	"kernel_comp_size=0x01000000\0" \
+	"qspibootimageaddr=0x020E0000\0" \
+	"qspifdtaddr=0x020D0000\0" \
+	"bootimagesize=0x01F00000\0" \
+	"fdtimagesize=0x00010000\0" \
+	"qspiload=sf read ${loadaddr} ${qspibootimageaddr} ${bootimagesize};" \
+		"sf read ${fdt_addr} ${qspifdtaddr} ${fdtimagesize}\0" \
+	"qspiboot=setenv bootargs earlycon root=/dev/mtdblock1 rw " \
+		"rootfstype=jffs2 rootwait;booti ${loadaddr} - ${fdt_addr}\0" \
+	"qspifitload=sf read ${loadaddr} ${qspibootimageaddr} ${bootimagesize}\0" \
+	"qspifitboot=setenv bootargs earlycon root=/dev/mtdblock1 rw " \
+		"rootfstype=jffs2 rootwait;bootm ${loadaddr}\0" \
 	"loadaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"bootfile=" CONFIG_BOOTFILE "\0" \
 	"fdt_addr=8000000\0" \
@@ -53,24 +217,51 @@
 		"bootm ${loadaddr}\0" \
 	"mmcfitload=mmc rescan;" \
 		"load mmc 0:1 ${loadaddr} ${bootfile}\0" \
+	"mtdids=" CONFIG_MTDIDS_DEFAULT "\0" \
+	"mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0" \
 	"linux_qspi_enable=if sf probe; then " \
 		"echo Enabling QSPI at Linux DTB...;" \
 		"fdt addr ${fdt_addr}; fdt resize;" \
 		"fdt set /soc/spi@ff8d2000 status okay;" \
-		"fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency " \
-		" ${qspi_clock}; fi; \0" \
+		"if fdt set /soc/clocks/qspi-clk clock-frequency" \
+		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
+		" elif fdt set /soc/clkmgr/clocks/qspi_clk clock-frequency" \
+		" ${qspi_clock}; then echo QSPI clock frequency updated;" \
+		" else fdt set /clocks/qspi-clk clock-frequency" \
+		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
 	"scriptaddr=0x02100000\0" \
 	"scriptfile=u-boot.scr\0" \
 	"fatscript=if fatload mmc 0:1 ${scriptaddr} ${scriptfile};" \
-		   "then source ${scriptaddr}; fi\0" \
-	"socfpga_legacy_reset_compat=1\0"
+		   "then source ${scriptaddr}:script; fi\0" \
+	"nandroot=ubi0:rootfs\0" \
+	"nandload=ubi part root; ubi readvol ${loadaddr} kernel; ubi readvol ${fdt_addr} dtb\0" \
+	"nandboot=setenv bootargs " CONFIG_BOOTARGS \
+			" root=${nandroot} rw rootwait rootfstype=ubifs ubi.mtd=1; " \
+			"booti ${loadaddr} - ${fdt_addr}\0" \
+	"nandfitboot=setenv bootargs " CONFIG_BOOTARGS \
+			" root=${nandroot} rw rootwait rootfstype=ubifs ubi.mtd=1; " \
+			"bootm ${loadaddr}\0" \
+	"nandfitload=ubi part root; ubi readvol ${loadaddr} kernel\0" \
+	"socfpga_legacy_reset_compat=1\0" \
+	"rsu_status=rsu dtb; rsu display_dcmf_version; "\
+		"rsu display_dcmf_status; rsu display_max_retry\0" \
+	"smc_fid_rd=0xC2000007\0" \
+	"smc_fid_wr=0xC2000008\0" \
+	"smc_fid_upd=0xC2000009\0 "
+#endif /*#if IS_ENABLED(CONFIG_DISTRO_DEFAULTS)*/
 
 /*
  * External memory configurations
  */
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define PHYS_SDRAM_1			0x80000000
+#define PHYS_SDRAM_1_SIZE		(1 * 1024 * 1024 * 1024)
+#define CFG_SYS_SDRAM_BASE		0x80000000
+#else
 #define PHYS_SDRAM_1			0x0
 #define PHYS_SDRAM_1_SIZE		(1 * 1024 * 1024 * 1024)
 #define CFG_SYS_SDRAM_BASE		0
+#endif
 
 /*
  * Serial / UART configurations
-- 
2.26.2

