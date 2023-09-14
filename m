Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFD6EDE9B3
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 12:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE0086A8F;
	Thu, 14 Sep 2023 14:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCE086A09; Thu, 14 Sep 2023 13:46:42 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 299C086EEB
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 13:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38EBkSPN073568;
 Thu, 14 Sep 2023 19:46:28 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 14 Sep 2023 19:46:24 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>
Subject: [PATCH] andes: rearrange defconfig and dts and memory layout for SPL.
Date: Thu, 14 Sep 2023 19:45:49 +0800
Message-ID: <20230914114549.1934199-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38EBkSPN073568
X-Mailman-Approved-At: Thu, 14 Sep 2023 14:09:23 +0200
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

Modify "CONFIG_AE350" to "CONFIG_ANDES_AE350"
Unify the memory layout for u-boot SPL.

Signed-off-by: Randolph <randolph@andestech.com>
---
 arch/riscv/Kconfig                   |  4 +-
 arch/riscv/dts/Makefile              |  2 +-
 arch/riscv/dts/ae350-u-boot.dtsi     |  1 +
 arch/riscv/dts/ae350_32.dts          | 61 ++++++++++++++--------------
 arch/riscv/dts/ae350_64.dts          |  1 -
 board/AndesTech/ae350/Kconfig        | 28 ++++++++++++-
 configs/ae350_rv32_defconfig         |  3 +-
 configs/ae350_rv32_spl_defconfig     | 21 ++++------
 configs/ae350_rv32_spl_xip_defconfig | 18 ++++----
 configs/ae350_rv32_xip_defconfig     |  3 +-
 configs/ae350_rv64_defconfig         |  3 +-
 configs/ae350_rv64_spl_defconfig     | 19 ++++-----
 configs/ae350_rv64_spl_xip_defconfig | 16 ++++----
 configs/ae350_rv64_xip_defconfig     |  3 +-
 14 files changed, 101 insertions(+), 82 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6771d8d919..aff1f33665 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -8,8 +8,8 @@ choice
 	prompt "Target select"
 	optional
 
-config TARGET_AE350
-	bool "Support ae350"
+config TARGET_ANDES_AE350
+	bool "Support Andes ae350"
 
 config TARGET_MICROCHIP_ICICLE
 	bool "Support Microchip PolarFire-SoC Icicle Board"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index f1525cb668..be6c8a4227 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-$(CONFIG_TARGET_AE350) += ae350_32.dtb ae350_64.dtb
+dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
diff --git a/arch/riscv/dts/ae350-u-boot.dtsi b/arch/riscv/dts/ae350-u-boot.dtsi
index aef9159b7a..ff5725501f 100644
--- a/arch/riscv/dts/ae350-u-boot.dtsi
+++ b/arch/riscv/dts/ae350-u-boot.dtsi
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
+#include CONFIG_SPL_LOAD_FIT_CONFIG
 
 / {
 	cpus {
diff --git a/arch/riscv/dts/ae350_32.dts b/arch/riscv/dts/ae350_32.dts
index 61af6d5465..3dde0e1dfa 100644
--- a/arch/riscv/dts/ae350_32.dts
+++ b/arch/riscv/dts/ae350_32.dts
@@ -2,12 +2,11 @@
 
 /dts-v1/;
 
-#include "binman.dtsi"
 #include "ae350-u-boot.dtsi"
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 	compatible = "andestech,a25";
 	model = "andestech,a25";
 
@@ -115,7 +114,7 @@
 		compatible = "cache";
 		cache-level = <2>;
 		cache-size = <0x40000>;
-		reg = <0xe0500000 0x40000>;
+		reg = <0x0 0xe0500000 0x0 0x40000>;
 		andes,inst-prefetch = <3>;
 		andes,data-prefetch = <3>;
 		/* The value format is <XRAMOCTL XRAMICTL> */
@@ -125,12 +124,12 @@
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x00000000 0x40000000>;
+		reg = <0x0 0x00000000 0x0 0x40000000>;
 	};
 
 	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		compatible = "simple-bus";
 		ranges;
 
@@ -138,7 +137,7 @@
 			compatible = "riscv,plic0";
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			reg = <0xe4000000 0x2000000>;
+			reg = <0x0 0xe4000000 0x0 0x2000000>;
 			riscv,ndev=<71>;
 			interrupts-extended = <&CPU0_intc 11 &CPU0_intc 9
 				&CPU1_intc 11 &CPU1_intc 9
@@ -148,9 +147,9 @@
 
 		plicsw: interrupt-controller@e6400000 {
 			compatible = "andestech,plicsw";
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 			interrupt-controller;
-			reg = <0xe6400000 0x400000>;
+			reg = <0x0 0xe6400000 0x0 0x400000>;
 			riscv,ndev=<2>;
 			interrupts-extended = <&CPU0_intc 3
 				&CPU1_intc 3
@@ -164,7 +163,7 @@
 				&CPU1_intc 7
 				&CPU2_intc 7
 				&CPU3_intc 7>;
-			reg = <0xe6000000 0x100000>;
+			reg = <0x0 0xe6000000 0x0 0x100000>;
 		};
 	};
 
@@ -176,7 +175,7 @@
 
 	timer0: timer@f0400000 {
 		compatible = "andestech,atcpit100";
-		reg = <0xf0400000 0x1000>;
+		reg = <0x0 0xf0400000 0x0 0x1000>;
 		clock-frequency = <60000000>;
 		interrupts = <3 4>;
 		interrupt-parent = <&plic0>;
@@ -184,7 +183,7 @@
 
 	serial0: serial@f0300000 {
 		compatible = "andestech,uart16550", "ns16550a";
-		reg = <0xf0300000 0x1000>;
+		reg = <0x0 0xf0300000 0x0 0x1000>;
 		interrupts = <9 4>;
 		clock-frequency = <19660800>;
 		reg-shift = <2>;
@@ -195,7 +194,7 @@
 
 	mac0: mac@e0100000 {
 		compatible = "andestech,atmac100";
-		reg = <0xe0100000 0x1000>;
+		reg = <0x0 0xe0100000 0x0 0x1000>;
 		interrupts = <19 4>;
 		interrupt-parent = <&plic0>;
 	};
@@ -205,7 +204,7 @@
 		max-frequency = <100000000>;
 		clock-freq-min-max = <400000 100000000>;
 		fifo-depth = <0x10>;
-		reg = <0xf0e00000 0x1000>;
+		reg = <0x0 0xf0e00000 0x0 0x1000>;
 		interrupts = <18 4>;
 		cap-sd-highspeed;
 		interrupt-parent = <&plic0>;
@@ -213,7 +212,7 @@
 
 	dma0: dma@f0c00000 {
 		compatible = "andestech,atcdmac300";
-		reg = <0xf0c00000 0x1000>;
+		reg = <0x0 0xf0c00000 0x0 0x1000>;
 		interrupts = <10 4 64 4 65 4 66 4 67 4 68 4 69 4 70 4 71 4>;
 		dma-channels = <8>;
 		interrupt-parent = <&plic0>;
@@ -221,19 +220,19 @@
 
 	lcd0: lcd@e0200000 {
 		compatible = "andestech,atflcdc100";
-		reg = <0xe0200000 0x1000>;
+		reg = <0x0 0xe0200000 0x0 0x1000>;
 		interrupts = <20 4>;
 		interrupt-parent = <&plic0>;
 	};
 
 	smc0: smc@e0400000 {
 		compatible = "andestech,atfsmc020";
-		reg = <0xe0400000 0x1000>;
+		reg = <0x0 0xe0400000 0x0 0x1000>;
 	};
 
 	snd0: snd@f0d00000 {
 		compatible = "andestech,atfac97";
-		reg = <0xf0d00000 0x1000>;
+		reg = <0x0 0xf0d00000 0x0 0x1000>;
 		interrupts = <17 4>;
 		interrupt-parent = <&plic0>;
 	};
@@ -245,71 +244,71 @@
 	virtio_mmio@fe007000 {
 		interrupts = <0x17 0x4>;
 		interrupt-parent = <0x2>;
-		reg = <0xfe007000 0x1000>;
+		reg = <0x0 0xfe007000 0x0 0x1000>;
 		compatible = "virtio,mmio";
 	};
 
 	virtio_mmio@fe006000 {
 		interrupts = <0x16 0x4>;
 		interrupt-parent = <0x2>;
-		reg = <0xfe006000 0x1000>;
+		reg = <0x0 0xfe006000 0x0 0x1000>;
 		compatible = "virtio,mmio";
 	};
 
 	virtio_mmio@fe005000 {
 		interrupts = <0x15 0x4>;
 		interrupt-parent = <0x2>;
-		reg = <0xfe005000 0x1000>;
+		reg = <0x0 0xfe005000 0x0 0x1000>;
 		compatible = "virtio,mmio";
 	};
 
 	virtio_mmio@fe004000 {
 		interrupts = <0x14 0x4>;
 		interrupt-parent = <0x2>;
-		reg = <0xfe004000 0x1000>;
+		reg = <0x0 0xfe004000 0x0 0x1000>;
 		compatible = "virtio,mmio";
 	};
 
 	virtio_mmio@fe003000 {
 		interrupts = <0x13 0x4>;
 		interrupt-parent = <0x2>;
-		reg = <0xfe003000 0x1000>;
+		reg = <0x0 0xfe003000 0x0 0x1000>;
 		compatible = "virtio,mmio";
 	};
 
 	virtio_mmio@fe002000 {
 		interrupts = <0x12 0x4>;
 		interrupt-parent = <0x2>;
-		reg = <0xfe002000 0x1000>;
+		reg = <0x0 0xfe002000 0x0 0x1000>;
 		compatible = "virtio,mmio";
 	};
 
 	virtio_mmio@fe001000 {
 		interrupts = <0x11 0x4>;
 		interrupt-parent = <0x2>;
-		reg = <0xfe001000 0x1000>;
+		reg = <0x0 0xfe001000 0x0 0x1000>;
 		compatible = "virtio,mmio";
 	};
 
 	virtio_mmio@fe000000 {
 		interrupts = <0x10 0x4>;
 		interrupt-parent = <0x2>;
-		reg = <0xfe000000 0x1000>;
+		reg = <0x0 0xfe000000 0x0 0x1000>;
 		compatible = "virtio,mmio";
 	};
 
 	nor@0,0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		compatible = "cfi-flash";
-		reg = <0x88000000 0x4000000>;
+		reg = <0x0 0x88000000 0x0 0x4000000>;
 		bank-width = <2>;
 		device-width = <1>;
 	};
 
 	spi: spi@f0b00000 {
 		compatible = "andestech,atcspi200";
-		reg = <0xf0b00000 0x1000>;
+		reg = <0x0 0xf0b00000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		num-cs = <1>;
diff --git a/arch/riscv/dts/ae350_64.dts b/arch/riscv/dts/ae350_64.dts
index 8c7db29b4f..9d5f6c743c 100644
--- a/arch/riscv/dts/ae350_64.dts
+++ b/arch/riscv/dts/ae350_64.dts
@@ -2,7 +2,6 @@
 
 /dts-v1/;
 
-#include "binman.dtsi"
 #include "ae350-u-boot.dtsi"
 
 / {
diff --git a/board/AndesTech/ae350/Kconfig b/board/AndesTech/ae350/Kconfig
index 75815bf99a..3b0d4c1733 100644
--- a/board/AndesTech/ae350/Kconfig
+++ b/board/AndesTech/ae350/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_AE350
+if TARGET_ANDES_AE350
 
 config SYS_CPU
 	default "andesv5"
@@ -41,4 +41,30 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply SPL_RAM_DEVICE
 	imply OF_HAS_PRIOR_STAGE
 
+choice
+	prompt "Fit type"
+	default SPL_LOAD_FIT_NORMAL
+
+config SPL_LOAD_FIT_NORMAL
+	bool "Enable SPL applying u-boot proper from FIT"
+	depends on SPL_LOAD_FIT
+	help
+	  Use fw_dynamic from the FIT image. Normal mode means that CPU will execute
+	  u-boot proper in next step.
+
+config SPL_LOAD_FIT_DYNAMIC
+	bool "Enable SPL (dynamic mode) applying linux from FIT"
+	depends on SPL_LOAD_FIT
+	help
+	  Use fw_dynamic from the FIT image. Dynamic mode means that CPU will execute
+	  linux in the next step.
+
+endchoice
+
+config SPL_LOAD_FIT_CONFIG
+	string "Default FIT configuration"
+	depends on SPL_LOAD_FIT
+	help
+	  Specify corresponding FIT configuration for each modes.
+
 endif
diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
index 06a683d986..eea919249d 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -9,7 +9,8 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index 75e55ba724..1479eb256e 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -1,4 +1,5 @@
 CONFIG_RISCV=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_TEXT_BASE=0x01800000
 CONFIG_SYS_MALLOC_LEN=0x80000
 CONFIG_NR_DRAM_BANKS=2
@@ -7,25 +8,23 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_PROMPT="RISC-V # "
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 # CONFIG_AVAILABLE_HARTS is not set
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x00200000
+CONFIG_PHYS_64BIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
 CONFIG_SYS_MONITOR_BASE=0x88000000
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
-CONFIG_DISPLAY_CPUINFO=y
-CONFIG_DISPLAY_BOARDINFO=y
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x100000
-CONFIG_SPL_BSS_START_ADDR=0x4000000
-CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BSS_START_ADDR=0x400000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
@@ -36,7 +35,6 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC=y
@@ -45,7 +43,6 @@ CONFIG_FTSDC010_SDIO=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
-CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_CFI_FLASH_STATUS_POLL=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index c2221b891e..142c5e29f2 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -1,4 +1,5 @@
 CONFIG_RISCV=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_TEXT_BASE=0x01800000
 CONFIG_SYS_MALLOC_LEN=0x80000
 CONFIG_NR_DRAM_BANKS=2
@@ -8,25 +9,24 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SYS_PROMPT="RISC-V # "
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_SPL_XIP=y
+# CONFIG_AVAILABLE_HARTS is not set
+CONFIG_PHYS_64BIT=y
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
-CONFIG_DISPLAY_CPUINFO=y
-CONFIG_DISPLAY_BOARDINFO=y
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x100000
-CONFIG_SPL_BSS_START_ADDR=0x4000000
-CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BSS_START_ADDR=0x400000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
@@ -37,7 +37,6 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC=y
@@ -46,7 +45,6 @@ CONFIG_FTSDC010_SDIO=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
-CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_CFI_FLASH_STATUS_POLL=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index 6d19400c2d..1b01b881ed 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -9,7 +9,8 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_XIP=y
 CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index 0d7f0a552e..cd13fc58a5 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -8,7 +8,8 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_ARCH_RV64I=y
 CONFIG_FIT=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index 6a72b5a047..f48838ddf9 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -1,4 +1,5 @@
 CONFIG_RISCV=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_TEXT_BASE=0x01800000
 CONFIG_SYS_MALLOC_LEN=0x80000
 CONFIG_NR_DRAM_BANKS=2
@@ -7,25 +8,23 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x10000000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SYS_PROMPT="RISC-V # "
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 # CONFIG_AVAILABLE_HARTS is not set
 CONFIG_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x00200000
-CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
+CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_BOOTDELAY=3
-CONFIG_DISPLAY_CPUINFO=y
-CONFIG_DISPLAY_BOARDINFO=y
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x100000
-CONFIG_SPL_BSS_START_ADDR=0x4000000
-CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BSS_START_ADDR=0x400000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
@@ -36,7 +35,6 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC=y
@@ -45,7 +43,6 @@ CONFIG_FTSDC010_SDIO=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
-CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_CFI_FLASH_STATUS_POLL=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 43581c79b1..15de9d9ef6 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -1,4 +1,5 @@
 CONFIG_RISCV=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_TEXT_BASE=0x01800000
 CONFIG_SYS_MALLOC_LEN=0x80000
 CONFIG_NR_DRAM_BANKS=2
@@ -8,25 +9,24 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SYS_PROMPT="RISC-V # "
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x100000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_SPL_XIP=y
+# CONFIG_AVAILABLE_HARTS is not set
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
-CONFIG_DISPLAY_CPUINFO=y
-CONFIG_DISPLAY_BOARDINFO=y
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SPL_MAX_SIZE=0x100000
-CONFIG_SPL_BSS_START_ADDR=0x4000000
-CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BSS_START_ADDR=0x400000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_CMD_IMLS=y
@@ -37,7 +37,6 @@ CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_NET_RETRY_COUNT=50
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC=y
@@ -46,7 +45,6 @@ CONFIG_FTSDC010_SDIO=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
-CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_CFI_FLASH_STATUS_POLL=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index 02d7694489..88c3869f75 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -8,7 +8,8 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SYS_PROMPT="RISC-V # "
 CONFIG_SYS_LOAD_ADDR=0x100000
-CONFIG_TARGET_AE350=y
+CONFIG_TARGET_ANDES_AE350=y
+CONFIG_SPL_LOAD_FIT_CONFIG="binman.dtsi"
 CONFIG_ARCH_RV64I=y
 CONFIG_XIP=y
 CONFIG_FIT=y
-- 
2.34.1

