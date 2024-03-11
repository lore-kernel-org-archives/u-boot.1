Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AABC54E49
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 01:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C00D87EA3;
	Mon, 11 Mar 2024 02:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Onj7W50t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF8C9878ED; Mon, 11 Mar 2024 02:51:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D673587E50
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 02:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=jitloonl@ecsmtp.png.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710121902; x=1741657902;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fXACeHrZkWFCU3BK7W9H20GJiK8gnG1JjGXdbApZrEA=;
 b=Onj7W50tj3Tv96c/5xpHAwiDuQbSpMcdAe5xKYbo+lP8xaIGjAv6wh35
 NYlfeZRxSM7OaK04bJehzAPrkqlwnPTVc+CEmykcpRJ9JwnVhBl9R2ZIy
 IRal1rguUgcPXPPR/DS3YtwL3RrWQL0bPImnr1cblRAsbpIf1Ye+mid+m
 ShzsCfgZ2majGDa3quCnJXCqOxclVlAuUoXFH5c0XflT0rfkSu2ceqCus
 H/gl2fVCCf96bMoER5NfO3GmvcyNwGDRxl+IefbxZJzne3pjCnh8xxKmf
 qWvghsBAbAlQ6th2dsyqlazqPosu3sGFHaTsc5FA8CG8rVnkRqVssORUl Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22289965"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="22289965"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 18:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; d="scan'208";a="48471260"
Received: from pglmail07.png.intel.com ([10.126.73.9])
 by orviesa001.jf.intel.com with ESMTP; 10 Mar 2024 18:51:36 -0700
Received: from localhost (pgli0121.png.intel.com [10.221.240.84])
 by pglmail07.png.intel.com (Postfix) with ESMTP id 904CE167ED;
 Mon, 11 Mar 2024 09:51:34 +0800 (+08)
Received: by localhost (Postfix, from userid 12048045)
 id 8E0691481D; Mon, 11 Mar 2024 09:51:34 +0800 (+08)
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
Subject: [PATCH v3 v3 1/1] arch: arm: Agilex5 enablement
Date: Mon, 11 Mar 2024 09:51:31 +0800
Message-Id: <20240311015131.24528-2-jit.loon.lim@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20240311015131.24528-1-jit.loon.lim@intel.com>
References: <20240311015131.24528-1-jit.loon.lim@intel.com>
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

Changes v2 -> v3:
- Added FPGA 240G DDR region
Changes v1 -> v2:
- fixed git auto merge issue
---
 arch/arm/Kconfig                              |   4 +-
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |  71 ++
 arch/arm/dts/socfpga_agilex5.dtsi             | 575 ++++++++++++++
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 133 ++++
 arch/arm/dts/socfpga_agilex5_socdk.dts        | 163 ++++
 arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |  38 +-
 arch/arm/mach-socfpga/Kconfig                 |  19 +-
 arch/arm/mach-socfpga/Makefile                |  14 +-
 arch/arm/mach-socfpga/board.c                 |  56 +-
 arch/arm/mach-socfpga/clock_manager_agilex5.c |  89 +++
 .../include/mach/base_addr_soc64.h            |  38 +-
 .../mach-socfpga/include/mach/clock_manager.h |   4 +-
 .../include/mach/clock_manager_agilex5.h      |  12 +
 .../mach-socfpga/include/mach/handoff_soc64.h |  31 +-
 .../mach-socfpga/include/mach/mailbox_s10.h   |   1 +
 arch/arm/mach-socfpga/mmu-arm64_s10.c         |  59 +-
 board/intel/agilex5-socdk/MAINTAINERS         |   8 +
 configs/socfpga_agilex5_defconfig             | 116 +++
 drivers/clk/altera/Makefile                   |   1 +
 drivers/clk/altera/clk-agilex5.c              | 743 ++++++++++++++++++
 drivers/clk/altera/clk-agilex5.h              | 284 +++++++
 include/configs/socfpga_agilex5_socdk.h       |  12 +
 include/configs/socfpga_soc64_common.h        | 143 +++-
 include/dt-bindings/clock/agilex5-clock.h     |  71 ++
 include/dt-bindings/reset/altr,rst-mgr-agx5.h |  80 ++
 26 files changed, 2730 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_agilex5-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk.dts
 create mode 100644 arch/arm/mach-socfpga/clock_manager_agilex5.c
 create mode 100644 arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h
 create mode 100644 board/intel/agilex5-socdk/MAINTAINERS
 create mode 100644 configs/socfpga_agilex5_defconfig
 create mode 100644 drivers/clk/altera/clk-agilex5.c
 create mode 100644 drivers/clk/altera/clk-agilex5.h
 create mode 100644 include/configs/socfpga_agilex5_socdk.h
 create mode 100644 include/dt-bindings/clock/agilex5-clock.h
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-agx5.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fde85dc0d5..6df805f44c 100644
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
@@ -1124,7 +1125,8 @@ config ARCH_SOCFPGA
 	select SYS_THUMB_BUILD if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
 	select SYSRESET
 	select SYSRESET_SOCFPGA if TARGET_SOCFPGA_GEN5 || TARGET_SOCFPGA_ARRIA10
-	select SYSRESET_SOCFPGA_SOC64 if TARGET_SOCFPGA_SOC64
+	select SYSRESET_SOCFPGA_SOC64 if !TARGET_SOCFPGA_AGILEX5 && \
+	  TARGET_SOCFPGA_SOC64
 	imply CMD_DM
 	imply CMD_MTDPARTS
 	imply CRC32_VERIFY
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
index 0000000000..a8167e5c14
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -0,0 +1,71 @@
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
index 0000000000..03b5504049
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5.dtsi
@@ -0,0 +1,575 @@
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
index 0000000000..a24b0482bb
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -0,0 +1,133 @@
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
+		u-boot,spl-boot-order = &mmc,&flash0,"/memory";
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
+&binman {
+	/delete-node/ kernel;
+};
+#endif
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
index 84b91e8df0..15306db600 100644
--- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
@@ -2,7 +2,7 @@
 /*
  * U-Boot additions
  *
- * Copyright (C) 2020 Intel Corporation <www.intel.com>
+ * Copyright (C) 2020-2024 Intel Corporation <www.intel.com>
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
index 114d243812..1008232cac 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -8,7 +8,8 @@ config NR_DRAM_BANKS
 
 config SOCFPGA_SECURE_VAB_AUTH
 	bool "Enable boot image authentication with Secure Device Manager"
-	depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X
+	depends on TARGET_SOCFPGA_AGILEX || TARGET_SOCFPGA_N5X || \
+	  TARGET_SOCFPGA_AGILEX5
 	select FIT_IMAGE_POST_PROCESS
 	select SHA384
 	select SHA512
@@ -58,6 +59,15 @@ config TARGET_SOCFPGA_AGILEX
 	select SPL_CLK if SPL
 	select TARGET_SOCFPGA_SOC64
 
+config TARGET_SOCFPGA_AGILEX5
+	bool
+	select BINMAN if SPL_ATF
+	select CLK
+	select FPGA_INTEL_SDM_MAILBOX
+	select GICV3
+	select SPL_CLK if SPL
+	select TARGET_SOCFPGA_SOC64
+
 config TARGET_SOCFPGA_ARRIA5
 	bool
 	select TARGET_SOCFPGA_GEN5
@@ -129,6 +139,10 @@ config TARGET_SOCFPGA_AGILEX_SOCDK
 	bool "Intel SOCFPGA SoCDK (Agilex)"
 	select TARGET_SOCFPGA_AGILEX
 
+config TARGET_SOCFPGA_AGILEX5_SOCDK
+	bool "Intel SOCFPGA SoCDK (Agilex5)"
+	select TARGET_SOCFPGA_AGILEX5
+
 config TARGET_SOCFPGA_ARIES_MCVEVK
 	bool "Aries MCVEVK (Cyclone V)"
 	select TARGET_SOCFPGA_CYCLONE5
@@ -202,6 +216,7 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
 endchoice
 
 config SYS_BOARD
+	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "agilex-socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "arria5-socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
 	default "arria10-socdk" if TARGET_SOCFPGA_ARRIA10_SOCDK
@@ -223,6 +238,7 @@ config SYS_BOARD
 	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
 
 config SYS_VENDOR
+	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "intel" if TARGET_SOCFPGA_N5X_SOCDK
 	default "altera" if TARGET_SOCFPGA_ARRIA5_SOCDK
@@ -245,6 +261,7 @@ config SYS_SOC
 	default "socfpga"
 
 config SYS_CONFIG_NAME
+	default "socfpga_agilex5_socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
 	default "socfpga_agilex_socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "socfpga_arria5_secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
 	default "socfpga_arria5_socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index ec38b64dd4..67c6a8dfec 100644
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
@@ -56,6 +56,15 @@ obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
 endif
 
+ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
+obj-y	+= clock_manager_agilex5.o
+obj-y	+= mailbox_s10.o
+obj-y	+= misc_soc64.o
+obj-y	+= mmu-arm64_s10.o
+obj-y	+= reset_manager_s10.o
+obj-y	+= wrap_pll_config_soc64.o
+endif
+
 ifdef CONFIG_TARGET_SOCFPGA_N5X
 obj-y	+= clock_manager_n5x.o
 obj-y	+= lowlevel_init_soc64.o
@@ -95,6 +104,9 @@ endif
 ifdef CONFIG_TARGET_SOCFPGA_N5X
 obj-y	+= spl_n5x.o
 endif
+ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
+obj-y	+= spl_soc64.o
+endif
 else
 obj-$(CONFIG_SPL_ATF) += secure_reg_helper.o
 obj-$(CONFIG_SPL_ATF) += smc_api.o
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
diff --git a/arch/arm/mach-socfpga/clock_manager_agilex5.c b/arch/arm/mach-socfpga/clock_manager_agilex5.c
new file mode 100644
index 0000000000..b92f0b3af8
--- /dev/null
+++ b/arch/arm/mach-socfpga/clock_manager_agilex5.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ *
+ */
+
+#include <clk.h>
+#include <config.h>
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <malloc.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <time.h>
+#include <vsprintf.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/u-boot.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/arch/clock_manager.h>
+#include <asm/arch/system_manager.h>
+#include <dt-bindings/clock/agilex5-clock.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static ulong cm_get_rate_dm(u32 id)
+{
+	struct udevice *dev;
+	struct clk clk;
+	ulong rate;
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_CLK,
+					  DM_DRIVER_GET(socfpga_agilex5_clk),
+					  &dev);
+	if (ret)
+		return 0;
+
+	clk.id = id;
+	ret = clk_request(dev, &clk);
+	if (ret < 0)
+		return 0;
+
+	rate = clk_get_rate(&clk);
+
+	if ((rate == (unsigned long)-ENOSYS) ||
+	    (rate == (unsigned long)-ENXIO) ||
+	    (rate == (unsigned long)-EIO)) {
+		debug("%s id %u: clk_get_rate err: %ld\n",
+		      __func__, id, rate);
+		return 0;
+	}
+
+	return rate;
+}
+
+static u32 cm_get_rate_dm_khz(u32 id)
+{
+	return cm_get_rate_dm(id) / 1000;
+}
+
+unsigned long cm_get_mpu_clk_hz(void)
+{
+	return cm_get_rate_dm(AGILEX5_MPU_CLK);
+}
+
+unsigned int cm_get_l4_sys_free_clk_hz(void)
+{
+	return cm_get_rate_dm(AGILEX5_L4_SYS_FREE_CLK);
+}
+
+void cm_print_clock_quick_summary(void)
+{
+	printf("MPU       %10d kHz\n",
+	       cm_get_rate_dm_khz(AGILEX5_MPU_CLK));
+	printf("L4 Main	    %8d kHz\n",
+	       cm_get_rate_dm_khz(AGILEX5_L4_MAIN_CLK));
+	printf("L4 sys free %8d kHz\n",
+	       cm_get_rate_dm_khz(AGILEX5_L4_SYS_FREE_CLK));
+	printf("L4 MP       %8d kHz\n",
+	       cm_get_rate_dm_khz(AGILEX5_L4_MP_CLK));
+	printf("L4 SP       %8d kHz\n",
+	       cm_get_rate_dm_khz(AGILEX5_L4_SP_CLK));
+	printf("SDMMC       %8d kHz\n",
+	       cm_get_rate_dm_khz(AGILEX5_SDMMC_CLK));
+}
diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
index 3f899fcfa3..65721098b2 100644
--- a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
@@ -1,11 +1,46 @@
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
@@ -44,5 +79,6 @@
 #define SOCFPGA_OCRAM_ADDRESS			0xffe00000
 #define GICD_BASE				0xfffc1000
 #define GICC_BASE				0xfffc2000
+#endif /* IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) */
 
 #endif /* _SOCFPGA_SOC64_BASE_HARDWARE_H_ */
diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager.h b/arch/arm/mach-socfpga/include/mach/clock_manager.h
index a8cb07a1c4..6c9d32b9dd 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- *  Copyright (C) 2013-2017 Altera Corporation <www.altera.com>
+ *  Copyright (C) 2013-2024 Altera Corporation <www.altera.com>
  */
 
 #ifndef _CLOCK_MANAGER_H_
@@ -28,6 +28,8 @@ int cm_set_qspi_controller_clk_hz(u32 clk_hz);
 #include <asm/arch/clock_manager_s10.h>
 #elif defined(CONFIG_TARGET_SOCFPGA_AGILEX)
 #include <asm/arch/clock_manager_agilex.h>
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#include <asm/arch/clock_manager_agilex5.h>
 #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 #include <asm/arch/clock_manager_n5x.h>
 #endif
diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h b/arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h
new file mode 100644
index 0000000000..1ae0a92603
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#ifndef _CLOCK_MANAGER_AGILEX5_
+#define _CLOCK_MANAGER_AGILEX5_
+
+#include <asm/arch/clock_manager_soc64.h>
+#include "../../../../../drivers/clk/altera/clk-agilex5.h"
+
+#endif /* _CLOCK_MANAGER_AGILEX5_ */
diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index 9b85e5865b..2684b84a08 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright (C) 2016-2021 Intel Corporation <www.intel.com>
+ * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
  *
  */
 
@@ -17,7 +17,12 @@
 #define SOC64_HANDOFF_MAGIC_FPGA	0x46504741
 #define SOC64_HANDOFF_MAGIC_DELAY	0x444C4159
 #define SOC64_HANDOFF_MAGIC_CLOCK	0x434C4B53
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define SOC64_HANDOFF_MAGIC_PERI	0x50455249
+#define SOC64_HANDOFF_MAGIC_SDRAM	0x5344524d
+#else
 #define SOC64_HANDOFF_MAGIC_MISC	0x4D495343
+#endif
 
 #define SOC64_HANDOFF_OFFSET_LENGTH	0x4
 #define SOC64_HANDOFF_OFFSET_DATA	0x10
@@ -27,6 +32,8 @@
 	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX)
 #define SOC64_HANDOFF_BASE		0xFFE3F000
 #define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE + 0x610)
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define SOC64_HANDOFF_BASE		0x0007F000
 #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 #define SOC64_HANDOFF_BASE		0xFFE5F000
 #define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE + 0x630)
@@ -58,13 +65,21 @@
 #define SOC64_HANDOFF_FPGA		(SOC64_HANDOFF_BASE + 0x330)
 #define SOC64_HANDOFF_DELAY		(SOC64_HANDOFF_BASE + 0x3F0)
 #define SOC64_HANDOFF_CLOCK		(SOC64_HANDOFF_BASE + 0x580)
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define SOC64_HANDOFF_PERI		(SOC64_HANDOFF_BASE + 0x620)
+#define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE + 0x634)
+#define SOC64_HANDOFF_SDRAM_LEN		1
+#endif
 
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
-#define SOC64_HANDOFF_CLOCK_OSC	(SOC64_HANDOFF_BASE + 0x608)
-#define SOC64_HANDOFF_CLOCK_FPGA	(SOC64_HANDOFF_BASE + 0x60C)
+#define SOC64_HANDOFF_CLOCK_OSC			(SOC64_HANDOFF_BASE + 0x608)
+#define SOC64_HANDOFF_CLOCK_FPGA		(SOC64_HANDOFF_BASE + 0x60C)
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define SOC64_HANDOFF_CLOCK_OSC			(SOC64_HANDOFF_BASE + 0x60c)
+#define SOC64_HANDOFF_CLOCK_FPGA		(SOC64_HANDOFF_BASE + 0x610)
 #else
-#define SOC64_HANDOFF_CLOCK_OSC	(SOC64_HANDOFF_BASE + 0x5fc)
-#define SOC64_HANDOFF_CLOCK_FPGA	(SOC64_HANDOFF_BASE + 0x600)
+#define SOC64_HANDOFF_CLOCK_OSC			(SOC64_HANDOFF_BASE + 0x5fc)
+#define SOC64_HANDOFF_CLOCK_FPGA		(SOC64_HANDOFF_BASE + 0x600)
 #endif
 
 #define SOC64_HANDOFF_MUX_LEN			96
@@ -78,6 +93,12 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
+enum endianness {
+	LITTLE_ENDIAN = 0,
+	BIG_ENDIAN,
+	UNKNOWN_ENDIANNESS
+};
+
 int socfpga_get_handoff_size(void *handoff_address);
 int socfpga_handoff_read(void *handoff_address, void *table, u32 table_len);
 #endif
diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
index fbaf11597e..2cc7c89044 100644
--- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
@@ -119,6 +119,7 @@ enum ALT_SDM_MBOX_RESP_CODE {
 #define MBOX_RECONFIG_DATA	8
 #define MBOX_RECONFIG_STATUS	9
 #define MBOX_VAB_SRC_CERT		11
+#define MBOX_GET_USERCODE		19
 #define MBOX_QSPI_OPEN		50
 #define MBOX_QSPI_CLOSE		51
 #define MBOX_QSPI_DIRECT	59
diff --git a/arch/arm/mach-socfpga/mmu-arm64_s10.c b/arch/arm/mach-socfpga/mmu-arm64_s10.c
index a55b7b7cf3..91c6d7c55f 100644
--- a/arch/arm/mach-socfpga/mmu-arm64_s10.c
+++ b/arch/arm/mach-socfpga/mmu-arm64_s10.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
+ * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
  *
  */
 
@@ -10,6 +10,62 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+static struct mm_region socfpga_agilex5_mem_map[] = {
+	{
+		/* OCRAM 512KB */
+		.virt	= 0x00000000UL,
+		.phys	= 0x00000000UL,
+		.size	= 0x00080000UL,
+		.attrs	= PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+				PTE_BLOCK_NON_SHARE,
+	}, {
+		/* DEVICE */
+		.virt	= 0x10808000UL,
+		.phys	= 0x10808000UL,
+		.size	= 0x0F7F8000UL,
+		.attrs	= PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+				PTE_BLOCK_NON_SHARE |
+				PTE_BLOCK_PXN | PTE_BLOCK_UXN,
+	}, {
+		/* FPGA 1.5GB */
+		.virt	= 0x20000000UL,
+		.phys	= 0x20000000UL,
+		.size	= 0x60000000UL,
+		.attrs	= PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+				PTE_BLOCK_NON_SHARE |
+				PTE_BLOCK_PXN | PTE_BLOCK_UXN,
+	}, {
+		/* FPGA 15GB */
+		.virt	= 0x440000000UL,
+		.phys	= 0x440000000UL,
+		.size	= 0x3C0000000UL,
+		.attrs	= PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+				PTE_BLOCK_NON_SHARE |
+				PTE_BLOCK_PXN | PTE_BLOCK_UXN,
+	}, {
+		/* FPGA 240GB */
+		.virt	= 0x4400000000UL,
+		.phys	= 0x4400000000UL,
+		.size	= 0x3C00000000UL,
+		.attrs	= PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+				PTE_BLOCK_NON_SHARE |
+				PTE_BLOCK_PXN | PTE_BLOCK_UXN,
+	}, {
+		/* MEM 2GB */
+		.virt	= 0x80000000UL,
+		.phys	= 0x80000000UL,
+		.size	= 0x80000000UL,
+		.attrs	= PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				PTE_BLOCK_INNER_SHARE,
+	}, {
+		/* List terminator */
+	},
+};
+
+struct mm_region *mem_map = socfpga_agilex5_mem_map;
+
+#else
 static struct mm_region socfpga_stratix10_mem_map[] = {
 	{
 		/* MEM 2GB*/
@@ -70,3 +126,4 @@ static struct mm_region socfpga_stratix10_mem_map[] = {
 };
 
 struct mm_region *mem_map = socfpga_stratix10_mem_map;
+#endif
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
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
new file mode 100644
index 0000000000..f39954aea8
--- /dev/null
+++ b/configs/socfpga_agilex5_defconfig
@@ -0,0 +1,116 @@
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
+# CONFIG_BOOTFILE="Image" is not set for CONFIG_SPL_ATF=y
+CONFIG_USE_BOOTFILE=y
+CONFIG_BOOTFILE="kernel.itb"
diff --git a/drivers/clk/altera/Makefile b/drivers/clk/altera/Makefile
index 33db092918..61ffa4179a 100644
--- a/drivers/clk/altera/Makefile
+++ b/drivers/clk/altera/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += clk-agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += clk-arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += clk-n5x.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += clk-mem-n5x.o
+obj-$(CONFIG_TARGET_SOCFPGA_AGILEX5) += clk-agilex5.o
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
new file mode 100644
index 0000000000..c3b614ace4
--- /dev/null
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -0,0 +1,743 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#include <clk-uclass.h>
+#include <config.h>
+#include <errno.h>
+#include <dm.h>
+#include <log.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <time.h>
+#include <vsprintf.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/u-boot.h>
+#include <dm/lists.h>
+#include <dm/util.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/arch/clock_manager.h>
+#include <dt-bindings/clock/agilex5-clock.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct socfpga_clk_plat {
+	void __iomem *regs;
+};
+
+/*
+ * function to write the bypass register which requires a poll of the
+ * busy bit
+ */
+static void clk_write_bypass_mainpll(struct socfpga_clk_plat *plat, u32 val)
+{
+	CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_BYPASS);
+	cm_wait_for_fsm();
+}
+
+static void clk_write_bypass_perpll(struct socfpga_clk_plat *plat, u32 val)
+{
+	CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_BYPASS);
+	cm_wait_for_fsm();
+}
+
+/* function to write the ctrl register which requires a poll of the busy bit */
+static void clk_write_ctrl(struct socfpga_clk_plat *plat, u32 val)
+{
+	CM_REG_WRITEL(plat, val, CLKMGR_CTRL);
+	cm_wait_for_fsm();
+}
+
+static const struct {
+	u32 reg;
+	u32 val;
+	u32 mask;
+} membus_pll[] = {
+	{
+		MEMBUS_CLKSLICE_REG,
+		/*
+		 * BIT[7:7]
+		 * Enable source synchronous mode
+		 */
+		BIT(7),
+		BIT(7)
+	},
+	{
+		MEMBUS_SYNTHCALFOSC_INIT_CENTERFREQ_REG,
+		/*
+		 * BIT[0:0]
+		 * Sets synthcalfosc_init_centerfreq=1 to limit overshoot
+		 * frequency during lock
+		 */
+		BIT(0),
+		BIT(0)
+	},
+	{
+		MEMBUS_SYNTHPPM_WATCHDOGTMR_VF01_REG,
+		/*
+		 * BIT[0:0]
+		 * Sets synthppm_watchdogtmr_vf0=1 to give the pll more time
+		 * to settle before lock is asserted.
+		 */
+		BIT(0),
+		BIT(0)
+	},
+	{
+		MEMBUS_CALCLKSLICE0_DUTY_LOCOVR_REG,
+		/*
+		 * BIT[6:0]
+		 * Centering duty cycle for clkslice0 output
+		 */
+		0x4a,
+		GENMASK(6, 0)
+	},
+	{
+		MEMBUS_CALCLKSLICE1_DUTY_LOCOVR_REG,
+		/*
+		 * BIT[6:0]
+		 * Centering duty cycle for clkslice1 output
+		 */
+		0x4a,
+		GENMASK(6, 0)
+	},
+};
+
+static int membus_wait_for_req(struct socfpga_clk_plat *plat, u32 pll,
+			       int timeout)
+{
+	int cnt = 0;
+	u32 req_status;
+
+	if (pll == MEMBUS_MAINPLL)
+		req_status = CM_REG_READL(plat, CLKMGR_MAINPLL_MEM);
+	else
+		req_status = CM_REG_READL(plat, CLKMGR_PERPLL_MEM);
+
+	while ((cnt < timeout) && (req_status & CLKMGR_MEM_REQ_SET_MSK)) {
+		if (pll == MEMBUS_MAINPLL)
+			req_status = CM_REG_READL(plat, CLKMGR_MAINPLL_MEM);
+		else
+			req_status = CM_REG_READL(plat, CLKMGR_PERPLL_MEM);
+		cnt++;
+	}
+
+	if (cnt >= timeout)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int membus_write_pll(struct socfpga_clk_plat *plat, u32 pll,
+			    u32 addr_offset, u32 wdat, int timeout)
+{
+	u32 addr;
+	u32 val;
+
+	addr = ((addr_offset | CLKMGR_MEM_ADDR_START) & CLKMGR_MEM_ADDR_MASK);
+
+	val = (CLKMGR_MEM_REQ_SET_MSK | CLKMGR_MEM_WR_SET_MSK |
+	       (wdat << CLKMGR_MEM_WDAT_LSB_OFFSET) | addr);
+
+	if (pll == MEMBUS_MAINPLL)
+		CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_MEM);
+	else
+		CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_MEM);
+
+	debug("MEMBUS: Write 0x%08x to addr = 0x%08x\n", wdat, addr);
+
+	return membus_wait_for_req(plat, pll, timeout);
+}
+
+static int membus_read_pll(struct socfpga_clk_plat *plat, u32 pll,
+			   u32 addr_offset, u32 *rdata, int timeout)
+{
+	u32 addr;
+	u32 val;
+
+	addr = ((addr_offset | CLKMGR_MEM_ADDR_START) & CLKMGR_MEM_ADDR_MASK);
+
+	val = ((CLKMGR_MEM_REQ_SET_MSK & ~CLKMGR_MEM_WR_SET_MSK) | addr);
+
+	if (pll == MEMBUS_MAINPLL)
+		CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_MEM);
+	else
+		CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_MEM);
+
+	*rdata = 0;
+
+	if (membus_wait_for_req(plat, pll, timeout))
+		return -ETIMEDOUT;
+
+	if (pll == MEMBUS_MAINPLL)
+		*rdata = CM_REG_READL(plat, CLKMGR_MAINPLL_MEMSTAT);
+	else
+		*rdata = CM_REG_READL(plat, CLKMGR_PERPLL_MEMSTAT);
+
+	debug("MEMBUS: Read 0x%08x from addr = 0x%08x\n", *rdata, addr);
+
+	return 0;
+}
+
+static void membus_pll_configs(struct socfpga_clk_plat *plat, u32 pll)
+{
+	int i;
+	u32 rdata;
+
+	for (i = 0; i < ARRAY_SIZE(membus_pll); i++) {
+		membus_read_pll(plat, pll, membus_pll[i].reg,
+				&rdata, MEMBUS_TIMEOUT);
+		membus_write_pll(plat, pll, membus_pll[i].reg,
+			 ((rdata & ~membus_pll[i].mask) | membus_pll[i].val),
+			 MEMBUS_TIMEOUT);
+	}
+}
+
+static u32 calc_vocalib_pll(u32 pllm, u32 pllglob)
+{
+	u32 mdiv, refclkdiv, arefclkdiv, drefclkdiv, mscnt, hscnt, vcocalib;
+
+	mdiv = pllm & CLKMGR_PLLM_MDIV_MASK;
+	arefclkdiv = (pllglob & CLKMGR_PLLGLOB_AREFCLKDIV_MASK) >>
+		      CLKMGR_PLLGLOB_AREFCLKDIV_OFFSET;
+	drefclkdiv = (pllglob & CLKMGR_PLLGLOB_DREFCLKDIV_MASK) >>
+		      CLKMGR_PLLGLOB_DREFCLKDIV_OFFSET;
+	refclkdiv = (pllglob & CLKMGR_PLLGLOB_REFCLKDIV_MASK) >>
+		     CLKMGR_PLLGLOB_REFCLKDIV_OFFSET;
+	mscnt = CLKMGR_VCOCALIB_MSCNT_CONST / (mdiv * BIT(drefclkdiv));
+	if (!mscnt)
+		mscnt = 1;
+	hscnt = (mdiv * mscnt * BIT(drefclkdiv) / refclkdiv) -
+		CLKMGR_VCOCALIB_HSCNT_CONST;
+	vcocalib = (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
+		   ((mscnt << CLKMGR_VCOCALIB_MSCNT_OFFSET) &
+		     CLKMGR_VCOCALIB_MSCNT_MASK);
+
+	/* Dump all the pll calibration settings for debug purposes */
+	debug("mdiv          : %d\n", mdiv);
+	debug("arefclkdiv    : %d\n", arefclkdiv);
+	debug("drefclkdiv    : %d\n", drefclkdiv);
+	debug("refclkdiv     : %d\n", refclkdiv);
+	debug("mscnt         : %d\n", mscnt);
+	debug("hscnt         : %d\n", hscnt);
+	debug("vcocalib      : 0x%08x\n", vcocalib);
+
+	return vcocalib;
+}
+
+/*
+ * Setup clocks while making no assumptions about previous state of the clocks.
+ */
+static void clk_basic_init(struct udevice *dev,
+			   const struct cm_config * const cfg)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(dev);
+	u32 vcocalib;
+
+	if (!cfg)
+		return;
+
+	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_EMU)) {
+		/* Take both PLL out of reset and power up */
+		CM_REG_SETBITS(plat, CLKMGR_MAINPLL_PLLGLOB,
+			       CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
+		CM_REG_SETBITS(plat, CLKMGR_PERPLL_PLLGLOB,
+			       CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
+
+		cm_wait_for_lock(CLKMGR_STAT_ALLPLL_LOCKED_MASK);
+
+		/* Put both PLLs in bypass */
+		clk_write_bypass_mainpll(plat, CLKMGR_BYPASS_MAINPLL_ALL);
+		clk_write_bypass_perpll(plat, CLKMGR_BYPASS_PERPLL_ALL);
+
+		/* Take all PLLs out of bypass */
+		clk_write_bypass_mainpll(plat, 0);
+		clk_write_bypass_perpll(plat, 0);
+
+		/* Out of boot mode */
+		clk_write_ctrl(plat,
+			       CM_REG_READL(plat, CLKMGR_CTRL) & ~CLKMGR_CTRL_BOOTMODE);
+	} else {
+#ifdef CONFIG_SPL_BUILD
+		/* Always force clock manager into boot mode before any configuration */
+		clk_write_ctrl(plat,
+			       CM_REG_READL(plat, CLKMGR_CTRL) | CLKMGR_CTRL_BOOTMODE);
+#else
+		/* Skip clock configuration in SSBL if it's not in boot mode */
+		if (!(CM_REG_READL(plat, CLKMGR_CTRL) & CLKMGR_CTRL_BOOTMODE))
+			return;
+#endif
+
+		/* Put both PLLs in bypass */
+		clk_write_bypass_mainpll(plat, CLKMGR_BYPASS_MAINPLL_ALL);
+		clk_write_bypass_perpll(plat, CLKMGR_BYPASS_PERPLL_ALL);
+
+		/* Put both PLLs in Reset and Power Down */
+		CM_REG_CLRBITS(plat, CLKMGR_MAINPLL_PLLGLOB,
+			       CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
+		CM_REG_CLRBITS(plat, CLKMGR_PERPLL_PLLGLOB,
+			       CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
+
+		/* setup main PLL dividers where calculate the vcocalib value */
+		vcocalib = calc_vocalib_pll(cfg->main_pll_pllm, cfg->main_pll_pllglob);
+		CM_REG_WRITEL(plat, cfg->main_pll_pllglob & ~CLKMGR_PLLGLOB_RST_MASK,
+			      CLKMGR_MAINPLL_PLLGLOB);
+		CM_REG_WRITEL(plat, cfg->main_pll_fdbck, CLKMGR_MAINPLL_FDBCK);
+		CM_REG_WRITEL(plat, vcocalib, CLKMGR_MAINPLL_VCOCALIB);
+		CM_REG_WRITEL(plat, cfg->main_pll_pllc0, CLKMGR_MAINPLL_PLLC0);
+		CM_REG_WRITEL(plat, cfg->main_pll_pllc1, CLKMGR_MAINPLL_PLLC1);
+		CM_REG_WRITEL(plat, cfg->main_pll_pllc2, CLKMGR_MAINPLL_PLLC2);
+		CM_REG_WRITEL(plat, cfg->main_pll_pllc3, CLKMGR_MAINPLL_PLLC3);
+		CM_REG_WRITEL(plat, cfg->main_pll_pllm, CLKMGR_MAINPLL_PLLM);
+		CM_REG_WRITEL(plat, cfg->main_pll_nocclk, CLKMGR_MAINPLL_NOCCLK);
+		CM_REG_WRITEL(plat, cfg->main_pll_nocdiv, CLKMGR_MAINPLL_NOCDIV);
+
+		/* setup peripheral PLL dividers where calculate the vcocalib value */
+		vcocalib = calc_vocalib_pll(cfg->per_pll_pllm, cfg->per_pll_pllglob);
+		CM_REG_WRITEL(plat, cfg->per_pll_pllglob & ~CLKMGR_PLLGLOB_RST_MASK,
+			      CLKMGR_PERPLL_PLLGLOB);
+		CM_REG_WRITEL(plat, cfg->per_pll_fdbck, CLKMGR_PERPLL_FDBCK);
+		CM_REG_WRITEL(plat, vcocalib, CLKMGR_PERPLL_VCOCALIB);
+		CM_REG_WRITEL(plat, cfg->per_pll_pllc0, CLKMGR_PERPLL_PLLC0);
+		CM_REG_WRITEL(plat, cfg->per_pll_pllc1, CLKMGR_PERPLL_PLLC1);
+		CM_REG_WRITEL(plat, cfg->per_pll_pllc2, CLKMGR_PERPLL_PLLC2);
+		CM_REG_WRITEL(plat, cfg->per_pll_pllc3, CLKMGR_PERPLL_PLLC3);
+		CM_REG_WRITEL(plat, cfg->per_pll_pllm, CLKMGR_PERPLL_PLLM);
+		CM_REG_WRITEL(plat, cfg->per_pll_emacctl, CLKMGR_PERPLL_EMACCTL);
+		CM_REG_WRITEL(plat, cfg->per_pll_gpiodiv, CLKMGR_PERPLL_GPIODIV);
+
+		/* Configure ping pong counters in control group */
+		CM_REG_WRITEL(plat, cfg->ctl_emacactr, CLKMGR_CTL_EMACACTR);
+		CM_REG_WRITEL(plat, cfg->ctl_emacbctr, CLKMGR_CTL_EMACBCTR);
+		CM_REG_WRITEL(plat, cfg->ctl_emacptpctr, CLKMGR_CTL_EMACPTPCTR);
+		CM_REG_WRITEL(plat, cfg->ctl_gpiodbctr, CLKMGR_CTL_GPIODBCTR);
+		CM_REG_WRITEL(plat, cfg->ctl_s2fuser0ctr, CLKMGR_CTL_S2FUSER0CTR);
+		CM_REG_WRITEL(plat, cfg->ctl_s2fuser1ctr, CLKMGR_CTL_S2FUSER1CTR);
+		CM_REG_WRITEL(plat, cfg->ctl_psirefctr, CLKMGR_CTL_PSIREFCTR);
+		CM_REG_WRITEL(plat, cfg->ctl_usb31ctr, CLKMGR_CTL_USB31CTR);
+		CM_REG_WRITEL(plat, cfg->ctl_dsuctr, CLKMGR_CTL_DSUCTR);
+		CM_REG_WRITEL(plat, cfg->ctl_core01ctr, CLKMGR_CTL_CORE01CTR);
+		CM_REG_WRITEL(plat, cfg->ctl_core23ctr, CLKMGR_CTL_CORE23CTR);
+		CM_REG_WRITEL(plat, cfg->ctl_core2ctr, CLKMGR_CTL_CORE2CTR);
+		CM_REG_WRITEL(plat, cfg->ctl_core3ctr, CLKMGR_CTL_CORE3CTR);
+
+		/* Take both PLL out of reset and power up */
+		CM_REG_SETBITS(plat, CLKMGR_MAINPLL_PLLGLOB,
+			       CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
+		CM_REG_SETBITS(plat, CLKMGR_PERPLL_PLLGLOB,
+			       CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
+
+		/* Membus programming for mainpll */
+		membus_pll_configs(plat, MEMBUS_MAINPLL);
+		/* Membus programming for peripll */
+		membus_pll_configs(plat, MEMBUS_PERPLL);
+
+		/* Enable Main pll clkslices */
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC0) |
+				CLKMGR_PLLCX_EN_SET_MSK,
+				CLKMGR_MAINPLL_PLLC0);
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC1) |
+				CLKMGR_PLLCX_EN_SET_MSK,
+				CLKMGR_MAINPLL_PLLC1);
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC2) |
+				CLKMGR_PLLCX_EN_SET_MSK,
+				CLKMGR_MAINPLL_PLLC2);
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC3) |
+				CLKMGR_PLLCX_EN_SET_MSK,
+				CLKMGR_MAINPLL_PLLC3);
+
+		/* Enable Periph pll clkslices */
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_PERPLL_PLLC0) |
+				CLKMGR_PLLCX_EN_SET_MSK,
+				CLKMGR_PERPLL_PLLC0);
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_PERPLL_PLLC1) |
+				CLKMGR_PLLCX_EN_SET_MSK,
+				CLKMGR_PERPLL_PLLC1);
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_PERPLL_PLLC2) |
+				CLKMGR_PLLCX_EN_SET_MSK,
+				CLKMGR_PERPLL_PLLC2);
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_PERPLL_PLLC3) |
+				CLKMGR_PLLCX_EN_SET_MSK,
+				CLKMGR_PERPLL_PLLC3);
+
+		cm_wait_for_lock(CLKMGR_STAT_ALLPLL_LOCKED_MASK);
+
+		CM_REG_WRITEL(plat, CLKMGR_LOSTLOCK_SET_MASK, CLKMGR_MAINPLL_LOSTLOCK);
+		CM_REG_WRITEL(plat, CLKMGR_LOSTLOCK_SET_MASK, CLKMGR_PERPLL_LOSTLOCK);
+
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_MAINPLL_PLLGLOB) |
+				CLKMGR_PLLGLOB_CLR_LOSTLOCK_BYPASS_MASK,
+				CLKMGR_MAINPLL_PLLGLOB);
+		CM_REG_WRITEL(plat, CM_REG_READL(plat, CLKMGR_PERPLL_PLLGLOB) |
+				CLKMGR_PLLGLOB_CLR_LOSTLOCK_BYPASS_MASK,
+				CLKMGR_PERPLL_PLLGLOB);
+
+		/* Take all PLLs out of bypass */
+		clk_write_bypass_mainpll(plat, 0);
+		clk_write_bypass_perpll(plat, 0);
+
+		/* Clear the loss of lock bits (write 1 to clear) */
+		CM_REG_CLRBITS(plat, CLKMGR_INTRCLR,
+			       CLKMGR_INTER_PERPLLLOST_MASK |
+			       CLKMGR_INTER_MAINPLLLOST_MASK);
+
+		/* Take all ping pong counters out of reset */
+		CM_REG_CLRBITS(plat, CLKMGR_CTL_EXTCNTRST,
+			       CLKMGR_CTL_EXTCNTRST_ALLCNTRST);
+
+#ifdef COUNTER_FREQUENCY_REAL
+	u32 cntfrq = COUNTER_FREQUENCY_REAL;
+	u32 counter_freq = 0;
+
+	/* Update with accurate clock frequency */
+	if (current_el() == 3) {
+		asm volatile("msr cntfrq_el0, %0" : : "r" (cntfrq) : "memory");
+		asm volatile("mrs %0, cntfrq_el0" : "=r" (counter_freq));
+		debug("Counter freq = 0x%x\n", counter_freq);
+	}
+#endif
+
+		/* Out of boot mode */
+		clk_write_ctrl(plat,
+			       CM_REG_READL(plat, CLKMGR_CTRL) & ~CLKMGR_CTRL_BOOTMODE);
+	}
+}
+
+static u64 clk_get_vco_clk_hz(struct socfpga_clk_plat *plat,
+			      u32 pllglob_reg, u32 pllm_reg)
+{
+	 u64 fref, arefdiv, mdiv, reg, vco;
+
+	reg = CM_REG_READL(plat, pllglob_reg);
+
+	fref = (reg & CLKMGR_PLLGLOB_VCO_PSRC_MASK) >>
+		CLKMGR_PLLGLOB_VCO_PSRC_OFFSET;
+
+	switch (fref) {
+	case CLKMGR_VCO_PSRC_EOSC1:
+		fref = cm_get_osc_clk_hz();
+		break;
+	case CLKMGR_VCO_PSRC_INTOSC:
+		fref = cm_get_intosc_clk_hz();
+		break;
+	case CLKMGR_VCO_PSRC_F2S:
+		fref = cm_get_fpga_clk_hz();
+		break;
+	}
+
+	arefdiv = (reg & CLKMGR_PLLGLOB_AREFCLKDIV_MASK) >>
+		   CLKMGR_PLLGLOB_AREFCLKDIV_OFFSET;
+
+	mdiv = CM_REG_READL(plat, pllm_reg) & CLKMGR_PLLM_MDIV_MASK;
+
+	vco = fref / arefdiv;
+	vco = vco * mdiv;
+
+	return vco;
+}
+
+static u64 clk_get_main_vco_clk_hz(struct socfpga_clk_plat *plat)
+{
+	return clk_get_vco_clk_hz(plat, CLKMGR_MAINPLL_PLLGLOB,
+				 CLKMGR_MAINPLL_PLLM);
+}
+
+static u64 clk_get_per_vco_clk_hz(struct socfpga_clk_plat *plat)
+{
+	return clk_get_vco_clk_hz(plat, CLKMGR_PERPLL_PLLGLOB,
+				 CLKMGR_PERPLL_PLLM);
+}
+
+static u32 clk_get_5_1_clk_src(struct socfpga_clk_plat *plat, u64 reg)
+{
+	u32 clksrc = CM_REG_READL(plat, reg);
+
+	return (clksrc & CLKMGR_CLKSRC_MASK) >> CLKMGR_CLKSRC_OFFSET;
+}
+
+static u64 clk_get_clksrc_hz(struct socfpga_clk_plat *plat, u32 clksrc_reg,
+			     u32 main_reg, u32 per_reg)
+{
+	u64 clock;
+	u32 clklsrc = clk_get_5_1_clk_src(plat, clksrc_reg);
+
+	switch (clklsrc) {
+	case CLKMGR_CLKSRC_MAIN:
+		clock = clk_get_main_vco_clk_hz(plat);
+		clock /= (CM_REG_READL(plat, main_reg) &
+			  CLKMGR_CLKCNT_MSK);
+		break;
+
+	case CLKMGR_CLKSRC_PER:
+		clock = clk_get_per_vco_clk_hz(plat);
+		clock /= (CM_REG_READL(plat, per_reg) &
+			  CLKMGR_CLKCNT_MSK);
+		break;
+
+	case CLKMGR_CLKSRC_OSC1:
+		clock = cm_get_osc_clk_hz();
+		break;
+
+	case CLKMGR_CLKSRC_INTOSC:
+		clock = cm_get_intosc_clk_hz();
+		break;
+
+	case CLKMGR_CLKSRC_FPGA:
+		clock = cm_get_fpga_clk_hz();
+		break;
+	default:
+		return 0;
+	}
+
+	return clock;
+}
+
+static u64 clk_get_mpu_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock;
+	u32 ctr_reg;
+	u32 cpu = ((read_mpidr() >> MPIDR_AFF1_OFFSET) & MPIDR_AFF1_OFFSET);
+
+	if (cpu > CORE1) {
+		ctr_reg = CLKMGR_CTL_CORE23CTR;
+
+		clock = clk_get_clksrc_hz(plat, ctr_reg,
+					  CLKMGR_MAINPLL_PLLC0,
+					  CLKMGR_PERPLL_PLLC0);
+	} else {
+		ctr_reg = CLKMGR_CTL_CORE01CTR;
+
+		clock = clk_get_clksrc_hz(plat, ctr_reg,
+					  CLKMGR_MAINPLL_PLLC1,
+					  CLKMGR_PERPLL_PLLC0);
+	}
+
+	if (cpu == CORE3)
+		ctr_reg = CLKMGR_CTL_CORE3CTR;
+	else if (cpu == CORE2)
+		ctr_reg = CLKMGR_CTL_CORE2CTR;
+	else
+		ctr_reg = CLKMGR_CTL_CORE01CTR;
+
+	clock /= 1 + (CM_REG_READL(plat, ctr_reg) &
+		 CLKMGR_CLKCNT_MSK);
+
+	return clock;
+}
+
+static u32 clk_get_l3_main_clk_hz(struct socfpga_clk_plat *plat)
+{
+	return clk_get_clksrc_hz(plat, CLKMGR_MAINPLL_NOCCLK,
+				      CLKMGR_MAINPLL_PLLC3,
+				      CLKMGR_PERPLL_PLLC1);
+}
+
+static u32 clk_get_l4_main_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock = clk_get_l3_main_clk_hz(plat);
+
+	return clock;
+}
+
+static u32 clk_get_l4_sp_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock = clk_get_l3_main_clk_hz(plat);
+	clock /= BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
+		      CLKMGR_NOCDIV_L4SPCLK_OFFSET) &
+		      CLKMGR_NOCDIV_DIVIDER_MASK);
+
+	return clock;
+}
+
+static u32 clk_get_l4_mp_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock = clk_get_l3_main_clk_hz(plat);
+
+	clock /= BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
+		      CLKMGR_NOCDIV_L4MPCLK_OFFSET) &
+		      CLKMGR_NOCDIV_DIVIDER_MASK);
+
+	return clock;
+}
+
+static u32 clk_get_sdmmc_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock = clk_get_l4_mp_clk_hz(plat);
+
+	clock /= BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
+		      CLKMGR_NOCDIV_SOFTPHY_OFFSET) &
+		      CLKMGR_NOCDIV_DIVIDER_MASK);
+
+	return clock;
+}
+
+static u32 clk_get_l4_sys_free_clk_hz(struct socfpga_clk_plat *plat)
+{
+	if (CM_REG_READL(plat, CLKMGR_STAT) & CLKMGR_STAT_BOOTMODE)
+		return clk_get_l3_main_clk_hz(plat) / 2;
+
+	return clk_get_l3_main_clk_hz(plat) / 4;
+}
+
+static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
+{
+	u32 ctl;
+	u32 ctr_reg;
+	u32 clock;
+	u32 div;
+	u32 reg;
+
+	if (emac_id == AGILEX5_EMAC_PTP_CLK) {
+		reg = CM_REG_READL(plat, CLKMGR_CTL_EMACPTPCTR);
+		ctr_reg = CLKMGR_CTL_EMACPTPCTR;
+	} else {
+		reg = CM_REG_READL(plat, CLKMGR_CTL_EMACACTR);
+		ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
+		if (emac_id == AGILEX5_EMAC0_CLK)
+			ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
+				CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
+		else if (emac_id == AGILEX5_EMAC1_CLK)
+			ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
+				CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
+		else if (emac_id == AGILEX5_EMAC2_CLK)
+			ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
+				CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
+		else
+			return 0;
+
+		if (ctl) {
+			/* EMAC B source */
+			ctr_reg = CLKMGR_CTL_EMACBCTR;
+		} else {
+			/* EMAC A source */
+			ctr_reg = CLKMGR_CTL_EMACACTR;
+		}
+	}
+	/* Get EMAC clock source */
+	clock = (reg & CLKMGR_CTL_EMACCTR_SRC_MASK)
+		 >> CLKMGR_CTL_EMACCTR_SRC_OFFSET;
+
+	reg = CM_REG_READL(plat, ctr_reg);
+	div = (reg & CLKMGR_CTL_EMACCTR_CNT_MASK)
+		>> CLKMGR_CTL_EMACCTR_CNT_OFFSET;
+
+	switch (clock) {
+	case CLKMGR_CLKSRC_MAIN:
+		clock = clk_get_main_vco_clk_hz(plat);
+
+		if (emac_id == AGILEX5_EMAC_PTP_CLK) {
+			clock /= (CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC3) &
+				  CLKMGR_CLKCNT_MSK);
+		} else {
+			clock /= (CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC1) &
+				  CLKMGR_CLKCNT_MSK);
+		}
+		break;
+
+	case CLKMGR_CLKSRC_PER:
+		clock = clk_get_per_vco_clk_hz(plat);
+
+		clock /= (CM_REG_READL(plat, CLKMGR_PERPLL_PLLC3) &
+			  CLKMGR_CLKCNT_MSK);
+		break;
+
+	case CLKMGR_CLKSRC_OSC1:
+		clock = cm_get_osc_clk_hz();
+		break;
+
+	case CLKMGR_CLKSRC_INTOSC:
+		clock = cm_get_intosc_clk_hz();
+		break;
+
+	case CLKMGR_CLKSRC_FPGA:
+		clock = cm_get_fpga_clk_hz();
+		break;
+	}
+
+	clock /= 1 + div;
+
+	return clock;
+}
+
+static ulong socfpga_clk_get_rate(struct clk *clk)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
+
+	switch (clk->id) {
+	case AGILEX5_MPU_CLK:
+		return clk_get_mpu_clk_hz(plat);
+	case AGILEX5_L4_MAIN_CLK:
+		return clk_get_l4_main_clk_hz(plat);
+	case AGILEX5_L4_SYS_FREE_CLK:
+		return clk_get_l4_sys_free_clk_hz(plat);
+	case AGILEX5_L4_MP_CLK:
+		return clk_get_l4_mp_clk_hz(plat);
+	case AGILEX5_L4_SP_CLK:
+		return clk_get_l4_sp_clk_hz(plat);
+	case AGILEX5_SDMMC_CLK:
+	case AGILEX5_NAND_CLK:
+		return clk_get_sdmmc_clk_hz(plat);
+	case AGILEX5_EMAC0_CLK:
+	case AGILEX5_EMAC1_CLK:
+	case AGILEX5_EMAC2_CLK:
+	case AGILEX5_EMAC_PTP_CLK:
+		return clk_get_emac_clk_hz(plat, clk->id);
+	case AGILEX5_USB_CLK:
+	case AGILEX5_NAND_X_CLK:
+		return clk_get_l4_mp_clk_hz(plat);
+	default:
+		return -ENXIO;
+	}
+}
+
+static int socfpga_clk_enable(struct clk *clk)
+{
+	return 0;
+}
+
+static int socfpga_clk_probe(struct udevice *dev)
+{
+	const struct cm_config *cm_default_cfg = cm_get_default_config();
+
+	clk_basic_init(dev, cm_default_cfg);
+
+	return 0;
+}
+
+static int socfpga_clk_of_to_plat(struct udevice *dev)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	plat->regs = (void __iomem *)addr;
+
+	return 0;
+}
+
+static struct clk_ops socfpga_clk_ops = {
+	.enable		= socfpga_clk_enable,
+	.get_rate	= socfpga_clk_get_rate,
+};
+
+static const struct udevice_id socfpga_clk_match[] = {
+	{ .compatible = "intel,agilex5-clkmgr" },
+	{}
+};
+
+U_BOOT_DRIVER(socfpga_agilex5_clk) = {
+	.name		= "clk-agilex5",
+	.id		= UCLASS_CLK,
+	.of_match	= socfpga_clk_match,
+	.ops		= &socfpga_clk_ops,
+	.probe		= socfpga_clk_probe,
+	.of_to_plat = socfpga_clk_of_to_plat,
+	.plat_auto	= sizeof(struct socfpga_clk_plat),
+};
diff --git a/drivers/clk/altera/clk-agilex5.h b/drivers/clk/altera/clk-agilex5.h
new file mode 100644
index 0000000000..a4ddc1a60d
--- /dev/null
+++ b/drivers/clk/altera/clk-agilex5.h
@@ -0,0 +1,284 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#ifndef	_CLK_AGILEX5_
+#define	_CLK_AGILEX5_
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+#define CORE0		1
+#define CORE1		2
+#define CORE2		3
+#define CORE3		4
+
+/* Derived from l4_main_clk (PSS clock) */
+#define COUNTER_FREQUENCY_REAL	400000000
+
+#define CM_REG_READL(plat, reg)				\
+	readl((plat)->regs + (reg))
+
+#define CM_REG_WRITEL(plat, data, reg)			\
+	writel(data, (plat)->regs + (reg))
+
+#define CM_REG_CLRBITS(plat, reg, clear)		\
+	clrbits_le32((plat)->regs + (reg), (clear))
+
+#define CM_REG_SETBITS(plat, reg, set)			\
+	setbits_le32((plat)->regs + (reg), (set))
+
+struct cm_config {
+	/* main group */
+	u32 main_pll_nocclk;
+	u32 main_pll_nocdiv;
+	u32 main_pll_pllglob;
+	u32 main_pll_fdbck;
+	u32 main_pll_pllc0;
+	u32 main_pll_pllc1;
+	u32 main_pll_pllc2;
+	u32 main_pll_pllc3;
+	u32 main_pll_pllm;
+
+	/* peripheral group */
+	u32 per_pll_emacctl;
+	u32 per_pll_gpiodiv;
+	u32 per_pll_pllglob;
+	u32 per_pll_fdbck;
+	u32 per_pll_pllc0;
+	u32 per_pll_pllc1;
+	u32 per_pll_pllc2;
+	u32 per_pll_pllc3;
+	u32 per_pll_pllm;
+
+	/* control group */
+	u32 ctl_emacactr;
+	u32 ctl_emacbctr;
+	u32 ctl_emacptpctr;
+	u32 ctl_gpiodbctr;
+	u32 ctl_s2fuser0ctr;
+	u32 ctl_s2fuser1ctr;
+	u32 ctl_psirefctr;
+	u32 ctl_usb31ctr;
+	u32 ctl_dsuctr;
+	u32 ctl_core01ctr;
+	u32 ctl_core23ctr;
+	u32 ctl_core2ctr;
+	u32 ctl_core3ctr;
+
+	/* incoming clock */
+	u32 hps_osc_clk_hz;
+	u32 fpga_clk_hz;
+	u32 spare[3];
+};
+
+/* Clock Manager registers */
+#define CLKMGR_CTRL				0
+#define CLKMGR_STAT				4
+#define CLKMGR_TESTIOCTRL			8
+#define CLKMGR_INTRGEN				0x0c
+#define CLKMGR_INTRMSK				0x10
+#define CLKMGR_INTRCLR				0x14
+#define CLKMGR_INTRSTS				0x18
+#define CLKMGR_INTRSTK				0x1c
+#define CLKMGR_INTRRAW				0x20
+
+/* Clock Manager Main PPL group registers */
+#define CLKMGR_MAINPLL_EN			0x24
+#define CLKMGR_MAINPLL_ENS			0x28
+#define CLKMGR_MAINPLL_ENR			0x2c
+#define CLKMGR_MAINPLL_BYPASS			0x30
+#define CLKMGR_MAINPLL_BYPASSS			0x34
+#define CLKMGR_MAINPLL_BYPASSR			0x38
+#define CLKMGR_MAINPLL_NOCCLK			0x40
+#define CLKMGR_MAINPLL_NOCDIV			0x44
+#define CLKMGR_MAINPLL_PLLGLOB			0x48
+#define CLKMGR_MAINPLL_FDBCK			0x4c
+#define CLKMGR_MAINPLL_MEM			0x50
+#define CLKMGR_MAINPLL_MEMSTAT			0x54
+#define CLKMGR_MAINPLL_VCOCALIB			0x58
+#define CLKMGR_MAINPLL_PLLC0			0x5c
+#define CLKMGR_MAINPLL_PLLC1			0x60
+#define CLKMGR_MAINPLL_PLLC2			0x64
+#define CLKMGR_MAINPLL_PLLC3			0x68
+#define CLKMGR_MAINPLL_PLLM			0x6c
+#define CLKMGR_MAINPLL_FHOP			0x70
+#define CLKMGR_MAINPLL_SSC			0x74
+#define CLKMGR_MAINPLL_LOSTLOCK			0x78
+
+/* Clock Manager Peripheral PPL group registers */
+#define CLKMGR_PERPLL_EN			0x7c
+#define CLKMGR_PERPLL_ENS			0x80
+#define CLKMGR_PERPLL_ENR			0x84
+#define CLKMGR_PERPLL_BYPASS			0x88
+#define CLKMGR_PERPLL_BYPASSS			0x8c
+#define CLKMGR_PERPLL_BYPASSR			0x90
+#define CLKMGR_PERPLL_EMACCTL			0x94
+#define CLKMGR_PERPLL_GPIODIV			0x98
+#define CLKMGR_PERPLL_PLLGLOB			0x9c
+#define CLKMGR_PERPLL_FDBCK			0xa0
+#define CLKMGR_PERPLL_MEM			0xa4
+#define CLKMGR_PERPLL_MEMSTAT			0xa8
+#define CLKMGR_PERPLL_VCOCALIB			0xac
+#define CLKMGR_PERPLL_PLLC0			0xb0
+#define CLKMGR_PERPLL_PLLC1			0xb4
+#define CLKMGR_PERPLL_PLLC2			0xb8
+#define CLKMGR_PERPLL_PLLC3			0xbc
+#define CLKMGR_PERPLL_PLLM			0xc0
+#define CLKMGR_PERPLL_FHOP			0xc4
+#define CLKMGR_PERPLL_SSC			0xc8
+#define CLKMGR_PERPLL_LOSTLOCK			0xcc
+
+/* Clock Manager Control group registers */
+#define CLKMGR_CTL_JTAG			0xd0
+#define CLKMGR_CTL_EMACACTR			0xd4
+#define CLKMGR_CTL_EMACBCTR			0xd8
+#define CLKMGR_CTL_EMACPTPCTR			0xdc
+#define CLKMGR_CTL_GPIODBCTR			0xe0
+#define CLKMGR_CTL_S2FUSER0CTR			0xe8
+#define CLKMGR_CTL_S2FUSER1CTR			0xec
+#define CLKMGR_CTL_PSIREFCTR			0xf0
+#define CLKMGR_CTL_EXTCNTRST			0xf4
+#define CLKMGR_CTL_USB31CTR				0xf8
+#define CLKMGR_CTL_DSUCTR				0xfc
+#define CLKMGR_CTL_CORE01CTR			0x100
+#define CLKMGR_CTL_CORE23CTR			0x104
+#define CLKMGR_CTL_CORE2CTR				0x108
+#define CLKMGR_CTL_CORE3CTR				0x10C
+
+#define CLKMGR_CTRL_BOOTMODE			BIT(0)
+
+#define CLKMGR_STAT_BUSY			BIT(0)
+#define CLKMGR_STAT_MAINPLL_LOCKED		BIT(8)
+#define CLKMGR_STAT_MAIN_TRANS			BIT(9)
+#define CLKMGR_STAT_PERPLL_LOCKED		BIT(16)
+#define CLKMGR_STAT_PERF_TRANS			BIT(17)
+#define CLKMGR_STAT_BOOTMODE			BIT(24)
+#define CLKMGR_STAT_BOOTCLKSRC			BIT(25)
+
+#define CLKMGR_STAT_ALLPLL_LOCKED_MASK		\
+	(CLKMGR_STAT_MAINPLL_LOCKED | CLKMGR_STAT_PERPLL_LOCKED)
+
+#define CLKMGR_INTER_MAINPLLLOCKED_MASK		0x00000001
+#define CLKMGR_INTER_PERPLLLOCKED_MASK		0x00000002
+#define CLKMGR_INTER_MAINPLLLOST_MASK		0x00000004
+#define CLKMGR_INTER_PERPLLLOST_MASK		0x00000008
+
+#define CLKMGR_CLKSRC_MASK			GENMASK(18, 16)
+#define CLKMGR_CLKSRC_OFFSET			16
+#define CLKMGR_CLKSRC_MAIN			0
+#define CLKMGR_CLKSRC_PER			1
+#define CLKMGR_CLKSRC_OSC1			2
+#define CLKMGR_CLKSRC_INTOSC			3
+#define CLKMGR_CLKSRC_FPGA			4
+#define CLKMGR_CLKCNT_MSK			GENMASK(10, 0)
+
+#define CLKMGR_BYPASS_MAINPLL_ALL		0xf6
+#define CLKMGR_BYPASS_PERPLL_ALL		0xef
+
+#define CLKMGR_NOCDIV_SOFTPHY_DIV_ONE		0
+#define CLKMGR_NOCDIV_SOFTPHY_DIV_TWO		1
+#define CLKMGR_NOCDIV_SOFTPHY_DIV_FOUR		2
+#define CLKMGR_NOCDIV_L4SYSFREECLK_OFFSET		0
+#define CLKMGR_NOCDIV_L4MPCLK_OFFSET		4
+#define CLKMGR_NOCDIV_L4SPCLK_OFFSET		6
+#define CLKMGR_NOCDIV_SOFTPHY_OFFSET		16
+#define CLKMGR_NOCDIV_CCU_OFFSET			18
+#define CLKMGR_NOCDIV_MPUPERIPH_OFFSET		20
+#define CLKMGR_NOCDIV_CSATCLK_OFFSET		24
+#define CLKMGR_NOCDIV_CSTRACECLK_OFFSET		26
+#define CLKMGR_NOCDIV_CSPDBGCLK_OFFSET		28
+#define CLKMGR_NOCDIV_DIVIDER_MASK		0x3
+
+#define CLKMGR_PLLGLOB_PD_MASK				BIT(0)
+#define CLKMGR_PLLGLOB_RST_MASK				BIT(1)
+#define CLKMGR_PLLGLOB_AREFCLKDIV_MASK			GENMASK(11, 8)
+#define CLKMGR_PLLGLOB_DREFCLKDIV_MASK			GENMASK(13, 12)
+#define CLKMGR_PLLGLOB_REFCLKDIV_MASK			GENMASK(13, 8)
+#define CLKMGR_PLLGLOB_MODCLKDIV_MASK			GENMASK(24, 27)
+#define CLKMGR_PLLGLOB_AREFCLKDIV_OFFSET		8
+#define CLKMGR_PLLGLOB_DREFCLKDIV_OFFSET		12
+#define CLKMGR_PLLGLOB_REFCLKDIV_OFFSET			8
+#define CLKMGR_PLLGLOB_MODCLKDIV_OFFSET			24
+#define CLKMGR_PLLGLOB_VCO_PSRC_MASK			GENMASK(17, 16)
+#define CLKMGR_PLLGLOB_VCO_PSRC_OFFSET			16
+#define CLKMGR_PLLGLOB_CLR_LOSTLOCK_BYPASS_MASK		BIT(29)
+
+#define CLKMGR_VCO_PSRC_EOSC1			0
+#define CLKMGR_VCO_PSRC_INTOSC			1
+#define CLKMGR_VCO_PSRC_F2S			2
+
+#define CLKMGR_MEM_REQ_SET_MSK			BIT(24)
+#define CLKMGR_MEM_WR_SET_MSK			BIT(25)
+#define CLKMGR_MEM_ERR_MSK			BIT(26)
+#define CLKMGR_MEM_WDAT_LSB_OFFSET		16
+#define CLKMGR_MEM_ADDR_MASK			GENMASK(15, 0)
+#define CLKMGR_MEM_ADDR_START			0x00004000
+
+#define CLKMGR_PLLCX_EN_SET_MSK			BIT(27)
+#define CLKMGR_PLLCX_MUTE_SET_MSK		BIT(28)
+
+#define CLKMGR_VCOCALIB_MSCNT_MASK		GENMASK(23, 16)
+#define CLKMGR_VCOCALIB_MSCNT_OFFSET		16
+#define CLKMGR_VCOCALIB_HSCNT_MASK		GENMASK(9, 0)
+#define CLKMGR_VCOCALIB_MSCNT_CONST		100
+#define CLKMGR_VCOCALIB_HSCNT_CONST		4
+
+#define CLKMGR_PLLM_MDIV_MASK			GENMASK(9, 0)
+
+#define CLKMGR_LOSTLOCK_SET_MASK		BIT(0)
+
+#define CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK		BIT(5)
+#define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET	26
+#define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK		BIT(26)
+#define CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET	27
+#define CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK		BIT(27)
+#define CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET	28
+#define CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK		BIT(28)
+
+#define CLKMGR_CTL_EMACCTR_SRC_OFFSET		16
+#define CLKMGR_CTL_EMACCTR_SRC_MASK		GENMASK(18, 16)
+#define CLKMGR_CTL_EMACCTR_CNT_OFFSET		0
+#define CLKMGR_CTL_EMACCTR_CNT_MASK		GENMASK(10, 0)
+
+#define CLKMGR_CTL_EXTCNTRST_EMACACNTRST	BIT(0)
+#define CLKMGR_CTL_EXTCNTRST_EMACBCNTRST	BIT(1)
+#define CLKMGR_CTL_EXTCNTRST_EMACPTPCNTRST	BIT(2)
+#define CLKMGR_CTL_EXTCNTRST_GPIODBCNTRST	BIT(3)
+#define CLKMGR_CTL_EXTCNTRST_S2FUSER0CNTRST	BIT(5)
+#define CLKMGR_CTL_EXTCNTRST_S2FUSER1CNTRST	BIT(6)
+#define CLKMGR_CTL_EXTCNTRST_PSIREFCNTRST	BIT(7)
+#define CLKMGR_CTL_EXTCNTRST_USB31REFCNTRST	BIT(8)
+#define CLKMGR_CTL_EXTCNTRST_DSUCNTRST		BIT(10)
+#define CLKMGR_CTL_EXTCNTRST_CORE01CNTRST	BIT(11)
+#define CLKMGR_CTL_EXTCNTRST_CORE2CNTRST	BIT(12)
+#define CLKMGR_CTL_EXTCNTRST_CORE3CNTRST	BIT(13)
+#define CLKMGR_CTL_EXTCNTRST_ALLCNTRST		\
+	(CLKMGR_CTL_EXTCNTRST_EMACACNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_EMACBCNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_EMACPTPCNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_GPIODBCNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_S2FUSER0CNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_S2FUSER1CNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_PSIREFCNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_USB31REFCNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_DSUCNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_CORE01CNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_CORE2CNTRST |	\
+	 CLKMGR_CTL_EXTCNTRST_CORE3CNTRST)
+
+#define MEMBUS_MAINPLL				0
+#define MEMBUS_PERPLL				1
+#define MEMBUS_TIMEOUT				1000
+
+#define MEMBUS_CLKSLICE_REG				0x27
+#define MEMBUS_SYNTHCALFOSC_INIT_CENTERFREQ_REG		0xb3
+#define MEMBUS_SYNTHPPM_WATCHDOGTMR_VF01_REG		0xe6
+#define MEMBUS_CALCLKSLICE0_DUTY_LOCOVR_REG		0x03
+#define MEMBUS_CALCLKSLICE1_DUTY_LOCOVR_REG		0x07
+
+#define MPIDR_AFF1_OFFSET	8
+#define MPIDR_AFF1_MASK		0x3
+#endif /* _CLK_AGILEX5_ */
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
index 820372c28b..b7ee1dbf20 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright (C) 2017-2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
  *
  */
 
@@ -26,8 +26,13 @@
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
@@ -36,9 +41,121 @@
 /*
  * Environment variable
  */
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
+#define BOOT_TARGET_DEVICES(func) \
+	BOOT_TARGET_DEVICES_MMC(func) \
+	BOOT_TARGET_DEVICES_QSPI(func)
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
 	"loadaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"bootfile=" CONFIG_BOOTFILE "\0" \
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
+	"socfpga_legacy_reset_compat=1\0" \
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
+	"bootfile=" CONFIG_BOOTFILE  "\0" \
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
+	"socfpga_legacy_reset_compat=1\0" \
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
+	"loadaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
+	"bootfile=" CONFIG_BOOTFILE  "\0" \
 	"fdt_addr=8000000\0" \
 	"fdtimage=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	"mmcroot=/dev/mmcblk0p2\0" \
@@ -53,24 +170,40 @@
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
+	"socfpga_legacy_reset_compat=1\0" \
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
diff --git a/include/dt-bindings/clock/agilex5-clock.h b/include/dt-bindings/clock/agilex5-clock.h
new file mode 100644
index 0000000000..c84fa51540
--- /dev/null
+++ b/include/dt-bindings/clock/agilex5-clock.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024, Intel Corporation
+ */
+
+#ifndef __AGILEX5_CLOCK_H
+#define __AGILEX5_CLOCK_H
+
+/* fixed rate clocks */
+#define AGILEX5_OSC1			0
+#define AGILEX5_CB_INTOSC_HS_DIV2_CLK	1
+#define AGILEX5_CB_INTOSC_LS_CLK		2
+#define AGILEX5_L4_SYS_FREE_CLK		3
+#define AGILEX5_F2S_FREE_CLK		4
+
+/* PLL clocks */
+#define AGILEX5_MAIN_PLL_CLK		5
+#define AGILEX5_MAIN_PLL_C0_CLK		6
+#define AGILEX5_MAIN_PLL_C1_CLK		7
+#define AGILEX5_MAIN_PLL_C2_CLK		8
+#define AGILEX5_MAIN_PLL_C3_CLK		9
+#define AGILEX5_PERIPH_PLL_CLK		10
+#define AGILEX5_PERIPH_PLL_C0_CLK	11
+#define AGILEX5_PERIPH_PLL_C1_CLK	12
+#define AGILEX5_PERIPH_PLL_C2_CLK	13
+#define AGILEX5_PERIPH_PLL_C3_CLK	14
+#define AGILEX5_MPU_FREE_CLK		15
+#define AGILEX5_MPU_CCU_CLK		16
+#define AGILEX5_BOOT_CLK			17
+
+/* fixed factor clocks */
+#define AGILEX5_L3_MAIN_FREE_CLK		18
+#define AGILEX5_NOC_FREE_CLK		19
+#define AGILEX5_S2F_USR0_CLK		20
+#define AGILEX5_NOC_CLK			21
+#define AGILEX5_EMAC_A_FREE_CLK		22
+#define AGILEX5_EMAC_B_FREE_CLK		23
+#define AGILEX5_EMAC_PTP_FREE_CLK	24
+#define AGILEX5_GPIO_DB_FREE_CLK		25
+#define AGILEX5_SDMMC_FREE_CLK		26
+#define AGILEX5_S2F_USER0_FREE_CLK	27
+#define AGILEX5_S2F_USER1_FREE_CLK	28
+#define AGILEX5_PSI_REF_FREE_CLK		29
+
+/* Gate clocks */
+#define AGILEX5_MPU_CLK			30
+#define AGILEX5_MPU_PERIPH_CLK		31
+#define AGILEX5_L4_MAIN_CLK		32
+#define AGILEX5_L4_MP_CLK		33
+#define AGILEX5_L4_SP_CLK		34
+#define AGILEX5_CS_AT_CLK		35
+#define AGILEX5_CS_TRACE_CLK		36
+#define AGILEX5_CS_PDBG_CLK		37
+#define AGILEX5_CS_TIMER_CLK		38
+#define AGILEX5_S2F_USER0_CLK		39
+#define AGILEX5_EMAC0_CLK		40
+#define AGILEX5_EMAC1_CLK		41
+#define AGILEX5_EMAC2_CLK		42
+#define AGILEX5_EMAC_PTP_CLK		43
+#define AGILEX5_GPIO_DB_CLK		44
+#define AGILEX5_NAND_CLK			45
+#define AGILEX5_PSI_REF_CLK		46
+#define AGILEX5_S2F_USER1_CLK		47
+#define AGILEX5_SDMMC_CLK		48
+#define AGILEX5_SPI_M_CLK		49
+#define AGILEX5_USB_CLK			50
+#define AGILEX5_NAND_X_CLK		51
+#define AGILEX5_NAND_ECC_CLK		52
+#define AGILEX5_NUM_CLKS			53
+
+#endif	/* __AGILEX5_CLOCK_H */
diff --git a/include/dt-bindings/reset/altr,rst-mgr-agx5.h b/include/dt-bindings/reset/altr,rst-mgr-agx5.h
new file mode 100644
index 0000000000..1dba270aed
--- /dev/null
+++ b/include/dt-bindings/reset/altr,rst-mgr-agx5.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Intel Corporation. All rights reserved
+ */
+
+#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_AGX_EDGE_H
+#define _DT_BINDINGS_RESET_ALTR_RST_MGR_AGX_EDGE_H
+
+/* PER0MODRST */
+#define EMAC0_RESET		0
+#define EMAC1_RESET		1
+#define EMAC2_RESET		2
+#define USB0_RESET		3
+#define USB1_RESET		4
+#define NAND_RESET		5
+#define COMBOPHY_RESET		6
+#define SDMMC_RESET		7
+#define EMAC0_OCP_RESET		8
+#define EMAC1_OCP_RESET		9
+#define EMAC2_OCP_RESET		10
+#define USB0_OCP_RESET		11
+#define USB1_OCP_RESET		12
+#define NAND_OCP_RESET		13
+/* 14 is empty */
+#define SDMMC_OCP_RESET		15
+#define DMA_RESET		16
+#define SPIM0_RESET		17
+#define SPIM1_RESET		18
+#define SPIS0_RESET		19
+#define SPIS1_RESET		20
+#define DMA_OCP_RESET		21
+#define EMAC_PTP_RESET		22
+/* 23 is empty*/
+#define DMAIF0_RESET		24
+#define DMAIF1_RESET		25
+#define DMAIF2_RESET		26
+#define DMAIF3_RESET		27
+#define DMAIF4_RESET		28
+#define DMAIF5_RESET		29
+#define DMAIF6_RESET		30
+#define DMAIF7_RESET		31
+
+/* PER1MODRST */
+#define WATCHDOG0_RESET		32
+#define WATCHDOG1_RESET		33
+#define WATCHDOG2_RESET		34
+#define WATCHDOG3_RESET		35
+#define L4SYSTIMER0_RESET	36
+#define L4SYSTIMER1_RESET	37
+#define SPTIMER0_RESET		38
+#define SPTIMER1_RESET		39
+#define I2C0_RESET		40
+#define I2C1_RESET		41
+#define I2C2_RESET		42
+#define I2C3_RESET		43
+#define I2C4_RESET		44
+#define I3C0_RESET		45
+#define I3C1_RESET		46
+/* 47 is empty */
+#define UART0_RESET		48
+#define UART1_RESET		49
+/* 50-55 is empty */
+#define GPIO0_RESET		56
+#define GPIO1_RESET		57
+#define WATCHDOG4_RESET		58
+/* 59-63 is empty */
+
+/* BRGMODRST */
+#define SOC2FPGA_RESET		64
+#define LWHPS2FPGA_RESET	65
+#define FPGA2SOC_RESET		66
+#define F2SSDRAM_RESET		67
+/* 68-69 is empty */
+#define DDRSCH_RESET		70
+/* 71-95 is empty */
+
+/* DBGMODRST */
+#define DBG_RESET		192
+
+#endif
-- 
2.26.2

