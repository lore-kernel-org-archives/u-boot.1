Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B893C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7365B82EB8;
	Wed, 30 Jul 2025 14:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753879152;
	bh=TvIX3XO7Us3C1BwKLJdUDkdQHsDXeU/2e33a8laR5Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h3HpY/kpNi3lg81++WGnYayHxhCggiMqi4SMxlgo52GhaXTO1C3Z68s1f3VyEZq3O
	 nP5pqUodkMMpSvcHP/mFWLGzhhs9WV7uhA+OjLwaJamI5ZXSTZZQNcIf30S7CxcRdg
	 GEpWOMnB8QtQ0e1R64DXig0Pr4JWI+bXjkPLD4UvhD85baXEGga6Hy1z7SczbCsjQp
	 atwWtX2GFkmuGi5Jrix2yIVRXmnlVOx/2TFMQ5H3Jv7WnH5VObEI5gzRnVUkM3fYi+
	 1y6t7mKXNL3d5qo0tXuv0oRHyvV9ZiRblOz+f15eVOYxWs4Bq+VFwBL6CCTKAcmS2i
	 5kdnDIIG3gRnA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B802B80FA1; Wed, 30 Jul 2025 14:39:11 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CDBF830B4
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ggHfOQNZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 308801038C128; 
 Wed, 30 Jul 2025 14:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753879148; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=TvIX3XO7Us3C1BwKLJdUDkdQHsDXeU/2e33a8laR5Is=;
 b=ggHfOQNZH1Re//haunGj7bCJsIPFUtMk2GQYU5U6xlkrehybqvWhF7RFfjnF8NPKyuwYd4
 bPHx+Ty3Pqp/ewkhhfH0qYysosZki0qxfMlI+vVl1QZ/+NXvZWGj32cplEHYtB1XUdzDdJ
 uJ/5/q+xWj2JuDtIi9qZktoeYn2/kcrju1duGdpJe1cG32Fay5dhCXo12TcO+8rX1c4rgC
 pCgYnXAWkE8FxYWEaTvnzaOt2JNWiCjOq1AyMcN8LnGTDY8NeADSBq3iWzxQG2rt7XFooG
 eHyrvjVbPsNObcDVmT5rM8t/A5Mv5dVTtoQxXEV4C18rRTDJzPNDJbFvVfkJBQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v5 4/4] mips: mt7628: Add Onion Omega2/2+ board support
Date: Wed, 30 Jul 2025 14:38:33 +0200
Message-Id: <20250730123833.249923-5-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730123833.249923-1-pro@denx.de>
References: <20250730123833.249923-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The Omega2 / Omega2+ are based on the MediaTek MT7688 SoC with the
following features:
    - 64 / 128MB of DDR2 memory
    - 16 / 32MB of SPI NOR flash
    - USB, WiFi and many more peripherals

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v5: none
    
    Changes in v4:
    	- Adapt bootcmd
    	- Rebase defconfig
    
    Changes in v3:
    	- Adapt defconfig to [PATCH 1/2] (SPL_SIZE_LIMIT)
    
    Changes in v2:
    	- Fix style issues as reported by checkpatch
    	- Add MAINTAINERS file

 arch/mips/dts/Makefile               |   1 +
 arch/mips/dts/onion-omega2p.dts      |  58 ++++++++++++
 arch/mips/mach-mtmips/mt7628/Kconfig |   7 ++
 board/onion/omega2p/Kconfig          |  12 +++
 board/onion/omega2p/MAINTAINERS      |  10 ++
 board/onion/omega2p/Makefile         |   3 +
 board/onion/omega2p/board.c          | 134 +++++++++++++++++++++++++++
 board/onion/omega2p/omega2p.env      |  32 +++++++
 configs/onion-omega2p_defconfig      |  82 ++++++++++++++++
 include/configs/onion-omega2p.h      |  15 +++
 10 files changed, 354 insertions(+)
 create mode 100644 arch/mips/dts/onion-omega2p.dts
 create mode 100644 board/onion/omega2p/Kconfig
 create mode 100644 board/onion/omega2p/MAINTAINERS
 create mode 100644 board/onion/omega2p/Makefile
 create mode 100644 board/onion/omega2p/board.c
 create mode 100644 board/onion/omega2p/omega2p.env
 create mode 100644 configs/onion-omega2p_defconfig
 create mode 100644 include/configs/onion-omega2p.h

diff --git a/arch/mips/dts/Makefile b/arch/mips/dts/Makefile
index 7c4ee8b668b..cb33f96edee 100644
--- a/arch/mips/dts/Makefile
+++ b/arch/mips/dts/Makefile
@@ -21,6 +21,7 @@ dtb-$(CONFIG_BOARD_MT7621_NAND_RFB) += mediatek,mt7621-nand-rfb.dtb
 dtb-$(CONFIG_BOARD_MT7628_RFB) += mediatek,mt7628-rfb.dtb
 dtb-$(CONFIG_BOARD_GARDENA_SMART_GATEWAY_MT7688) += gardena-smart-gateway-mt7688.dtb
 dtb-$(CONFIG_BOARD_LINKIT_SMART_7688) += linkit-smart-7688.dtb
+dtb-$(CONFIG_BOARD_ONION_OMEGA2) += onion-omega2p.dtb
 dtb-$(CONFIG_TARGET_OCTEON_EBB7304) += mrvl,octeon-ebb7304.dtb
 dtb-$(CONFIG_TARGET_OCTEON_NIC23) += mrvl,octeon-nic23.dtb
 dtb-$(CONFIG_BOARD_NETGEAR_CG3100D) += netgear,cg3100d.dtb
diff --git a/arch/mips/dts/onion-omega2p.dts b/arch/mips/dts/onion-omega2p.dts
new file mode 100644
index 00000000000..64fecba1db9
--- /dev/null
+++ b/arch/mips/dts/onion-omega2p.dts
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Zheng Han <zh@onioniot.com>, Lazar Demin <lazar@onioniot.com>
+ */
+
+/dts-v1/;
+
+#include "mt7628a.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	compatible = "onion,omega2", "onion,omega2p", "ralink,mt7628a-soc";
+	model = "Onion Omega2/Omega2+";
+
+	aliases {
+		serial0 = &uart0;
+		spi0 = &spi0;
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&pinctrl {
+	state_default: pin_state {
+		p0led {
+			groups = "p0led_a";
+			function = "led";
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+	num-cs = <2>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_dual_pins>;
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <40000000>;
+		reg = <0>;
+	};
+};
+
+&eth {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ephy_iot_mode>;
+	mediatek,poll-link-phy = <0>;
+};
diff --git a/arch/mips/mach-mtmips/mt7628/Kconfig b/arch/mips/mach-mtmips/mt7628/Kconfig
index 79b2ddc6692..a75196eaefd 100644
--- a/arch/mips/mach-mtmips/mt7628/Kconfig
+++ b/arch/mips/mach-mtmips/mt7628/Kconfig
@@ -27,6 +27,12 @@ config BOARD_MT7628_RFB
 	  SPI-NOR flash, 1 built-in switch with 5 ports, 1 UART, 1 USB host,
 	  1 SDXC, 1 PCIe socket and JTAG pins.
 
+config BOARD_ONION_OMEGA2
+	bool "Onion Omega2/2+"
+	help
+	  Onion Omega2/2+ IoT computer. Has a MT7688 SoC with 64/128 MiB of DDR2
+	  RAM and 16/32 MiB of SPI flash.
+
 config BOARD_VOCORE2
 	bool "VoCore2"
 	select SPL_SERIAL
@@ -52,6 +58,7 @@ config SYS_CONFIG_NAME
 	default "mt7628" if BOARD_MT7628_RFB
 
 source "board/gardena/smart-gateway-mt7688/Kconfig"
+source "board/onion/omega2p/Kconfig"
 source "board/seeed/linkit-smart-7688/Kconfig"
 source "board/vocore/vocore2/Kconfig"
 
diff --git a/board/onion/omega2p/Kconfig b/board/onion/omega2p/Kconfig
new file mode 100644
index 00000000000..45c18ee27ef
--- /dev/null
+++ b/board/onion/omega2p/Kconfig
@@ -0,0 +1,12 @@
+if BOARD_ONION_OMEGA2
+
+config SYS_BOARD
+	default "omega2p"
+
+config SYS_VENDOR
+	default "onion"
+
+config SYS_CONFIG_NAME
+	default "onion-omega2p"
+
+endif
diff --git a/board/onion/omega2p/MAINTAINERS b/board/onion/omega2p/MAINTAINERS
new file mode 100644
index 00000000000..4532c1c6d3e
--- /dev/null
+++ b/board/onion/omega2p/MAINTAINERS
@@ -0,0 +1,10 @@
+ONION OMEGA2/2+
+M:	Philip Oberfichtner <pro@denx.de>
+S:	Maintained
+F:	arch/mips/dts/onion-omega2p.dts
+F:	board/onion/omega2p/Kconfig
+F:	board/onion/omega2p/Makefile
+F:	board/onion/omega2p/board.c
+F:	board/onion/omega2p/omega2p.env
+F:	configs/onion-omega2p_defconfig
+F:	include/configs/onion-omega2p.h
diff --git a/board/onion/omega2p/Makefile b/board/onion/omega2p/Makefile
new file mode 100644
index 00000000000..70cd7a8e568
--- /dev/null
+++ b/board/onion/omega2p/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += board.o
diff --git a/board/onion/omega2p/board.c b/board/onion/omega2p/board.c
new file mode 100644
index 00000000000..b56fbf262ad
--- /dev/null
+++ b/board/onion/omega2p/board.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Zheng Han <zh@onioniot.com>, Lazar Demin <lazar@onioniot.com>
+ * Copyright (C) 2025 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
+ */
+
+#include <asm/io.h>
+#include <env.h>
+#include <init.h>
+#include <mtd.h>
+
+#define OMEGA2_REG(x)		(*((u32 *)(x)))
+#define OMEGA2_SYSCTL_BASE	0xB0000000
+#define OMEGA2_SYS_CNTL_BASE	(OMEGA2_SYSCTL_BASE)
+#define OMEGA2_REG_PIODIR	(OMEGA2_SYSCTL_BASE + 0x600)
+
+static int detect_rst(void)
+{
+	u32 val = OMEGA2_REG(0xb0000624); // Read GPIO 44 (reset button)
+
+	return (val & 1 << 6) ? 1 : 0;
+}
+
+static void gpio_init(void)
+{
+	u32 val;
+
+	printf("Initializing MT7688 GPIO system.\n");
+
+	//set gpio2_mode - setting wled, and p0,p1,p2,p3,p4 LED pins to GPIO mode
+	val = 0x555;
+	OMEGA2_REG(OMEGA2_SYS_CNTL_BASE + 0x64) = val; // GPIO2_MODE register
+	// GINT_FEDGE_1: setting "Enable falling edge triggered" for GPIOs 39-42
+	OMEGA2_REG(0xb0000644) = 0x0f << 7;
+
+	// set gpio_ctrl_1 register: set GPIO44 to output
+	//gpio44 output gpio_ctrl_1 bit3=1
+	val = OMEGA2_REG(OMEGA2_REG_PIODIR + 0x04);
+	val |= 1 << 12;
+	OMEGA2_REG(OMEGA2_REG_PIODIR + 0x04) = val;
+
+	// set gpio1_mode register: set WDT_MODE to GPIO mode
+	//set gpio1_mode 14=1b1
+	val = OMEGA2_REG(OMEGA2_SYS_CNTL_BASE + 0x60);
+	val |= 1 << 14;
+	OMEGA2_REG(OMEGA2_SYS_CNTL_BASE + 0x60) = val;
+
+	// set gpio_ctrl_1 resgister: set GPIO38 to input
+	//gpio38 input gpio_ctrl_1 bit5=0
+	val = OMEGA2_REG(OMEGA2_REG_PIODIR + 0x04);
+	val &= ~1 << 6;
+	OMEGA2_REG(OMEGA2_REG_PIODIR + 0x04) = val;
+}
+
+enum onion_board_variant {
+	OMEGA2,
+	OMEGA2P,
+	UNKNOWN,
+};
+
+static enum onion_board_variant board_variant(void)
+{
+	struct mtd_info *mtd;
+
+	mtd_probe_devices();
+
+	mtd_for_each_device(mtd) {
+		if (mtd->type != MTD_NORFLASH)
+			continue;
+
+		switch (mtd->size) {
+		case 16 * 1024 * 1024: // 16 MB
+			return OMEGA2;
+
+		case 32 * 1024 * 1024: // 32 MB
+			return OMEGA2P;
+
+		default:
+			break;
+		}
+	}
+
+	return UNKNOWN;
+}
+
+#define ONION_MTDPARTS_BASE "spi0.0:192k(u-boot),64k(u-boot-env),64k(factory)"
+
+static void set_mtdparts(void)
+{
+	switch (board_variant()) {
+	case OMEGA2P:
+		printf("Detected board variant OMEGA2+: ");
+		env_set("mtdparts", ONION_MTDPARTS_BASE ",32448k(firmware)");
+		break;
+
+	case OMEGA2:
+		printf("Detected board variant OMEGA2: ");
+		env_set("mtdparts", ONION_MTDPARTS_BASE ",16064k(firmware)");
+		break;
+
+	default:
+		printf("Unable to detect board variant! Using default value: ");
+		env_set("mtdparts", ONION_MTDPARTS_BASE);
+	}
+
+	printf("mtdparts=\"%s\"\n", env_get("mtdparts"));
+}
+
+#define WELCOME_MESSAGE                                                     \
+	"\n\n"                                                              \
+	"   *************************************************************\n"\
+	"   *  For more info on using U-Boot, visit                     *\n"\
+	"   *  https://documentation.onioniot.com/bootloader/overview   *\n"\
+	"   *                                                           *\n"\
+	"   *  Hold the reset button to enter the U-Boot commandline.   *\n"\
+	"   *************************************************************\n"\
+	"\n"
+
+int board_late_init(void)
+{
+	gpio_init();
+
+	printf(WELCOME_MESSAGE);
+
+	set_mtdparts();
+
+	if (detect_rst()) {
+		printf("Reset button pressed - entering shell ...\n");
+		env_set("reset_pressed", "1");
+		// This env variable is evaluated by our bootcmd.
+	}
+
+	return 0;
+}
diff --git a/board/onion/omega2p/omega2p.env b/board/onion/omega2p/omega2p.env
new file mode 100644
index 00000000000..f8c10b584e2
--- /dev/null
+++ b/board/onion/omega2p/omega2p.env
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2025 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
+
+# Boot options
+bootargs=console=ttyS0,115200 rootfstype=squashfs,jffs2
+bootfile=firmware.bin
+boot_linux=sf probe && mtd read firmware 81800000 0 400000 && bootm 81800000
+
+# unset temporary variable and make the environment persist if necessary.
+env_check= \
+	env set reset_pressed; \
+	if env info -p -d -q; then \
+		echo "No valid environment found on flash. Write out the defaults."; \
+		env save; \
+	fi
+
+bootcmd= \
+	if test -z "${reset_pressed}"; then \
+		run env_check; \
+		run boot_linux; \
+	else \
+		run env_check; \
+	fi
+
+# Network configuration
+serverip=192.168.8.100
+ipaddr=192.168.8.8
+loadaddr=0x81800000
+
+# MTD settings
+mtdids=nor0=spi0.0
+# mtdparts will be set at runtime, according to the specific board variant.
diff --git a/configs/onion-omega2p_defconfig b/configs/onion-omega2p_defconfig
new file mode 100644
index 00000000000..a73d1cd3d60
--- /dev/null
+++ b/configs/onion-omega2p_defconfig
@@ -0,0 +1,82 @@
+CONFIG_MIPS=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x30000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DEFAULT_DEVICE_TREE="onion-omega2p"
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x80000
+CONFIG_SPL_BSS_START_ADDR=0x80010000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_SPL=y
+CONFIG_ARCH_MTMIPS=y
+CONFIG_SOC_MT7628=y
+CONFIG_BOARD_ONION_OMEGA2=y
+CONFIG_SYS_MIPS_TIMER_FREQ=290000000
+CONFIG_MIPS_CACHE_SETUP=y
+CONFIG_MIPS_CACHE_DISABLE=y
+CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
+# CONFIG_MIPS_BOOT_ENV_LEGACY is not set
+CONFIG_MIPS_BOOT_FDT=y
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_BOOTDELAY=0
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SYS_MALLOC_BOOTPARAMS=y
+CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT=0x30000
+CONFIG_SPL_MAX_SIZE=0x10000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_NOR_SUPPORT=y
+CONFIG_HUSH_PARSER=y
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_INFO=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/onion/omega2p/omega2p.env"
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_IPADDR=y
+CONFIG_IPADDR="192.168.8.8"
+CONFIG_USE_SERVERIP=y
+CONFIG_SERVERIP="192.168.8.100"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_LED=y
+CONFIG_LED_BLINK=y
+CONFIG_LED_GPIO=y
+CONFIG_DM_MTD=y
+CONFIG_SPI_FLASH_BAR=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_MT7628_ETH=y
+CONFIG_PHY=y
+CONFIG_SPI=y
+CONFIG_MT7621_SPI=y
+CONFIG_LZMA=y
+# CONFIG_GZIP is not set
+CONFIG_SPL_LZMA=y
diff --git a/include/configs/onion-omega2p.h b/include/configs/onion-omega2p.h
new file mode 100644
index 00000000000..ca170b22a40
--- /dev/null
+++ b/include/configs/onion-omega2p.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Zheng Han <zh@onioniot.com>, Lazar Demin <lazar@onioniot.com>
+ */
+#ifndef __CONFIG_ONION_OMEGA2P_H
+#define __CONFIG_ONION_OMEGA2P_H
+
+/* RAM */
+#define CFG_SYS_SDRAM_BASE      0x80000000
+#define CFG_SYS_INIT_SP_OFFSET  0x400000
+
+/* Dummy value */
+#define CFG_SYS_UBOOT_BASE      0
+
+#endif /* __CONFIG_ONION_OMEGA2P_H */
-- 
2.39.5

