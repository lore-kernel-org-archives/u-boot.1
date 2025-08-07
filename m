Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44606C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 07:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47BC783BEF;
	Thu,  7 Aug 2025 09:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754553463;
	bh=OqV9axSUCQ7sskNlmB9mJ8lGX/o8eP3xwtzBlG4vrAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gs61drTsJGUvShA9+lhNdOsM5axUZaqOrWWERRhblG86kXmjIz6H4VuMioL+78D3A
	 bgIyODD1W9K31LdnzVIy3S/6Qpxqv9VTWEKAa8djESm5bkllHviy/XfkHRJeMi4pPV
	 Vi1g3WEFeb5GfrOzkF8iEn+1oD/vY9Rt+/LlVJpPYV7GQQe+2xCfYMhvOTP8qzT9sw
	 XG4UV7nvkja3K3ReUNHPJS0jRZ9Tc0ulknCccy6OYY76rKzZ19MKjEx8xTuHAO1+Oz
	 DliJpFY2OojGC5X5jShsrDxZsELv2CRZFcMnE+CwQDQSRIswWSvXcxOKUrNQZ+xYMd
	 EI/Cgv6kN7/cQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9245983A97; Thu,  7 Aug 2025 09:57:41 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE1883BEF
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MAc+MjXG"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2DA411038C12A; 
 Thu,  7 Aug 2025 09:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754553457; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=OqV9axSUCQ7sskNlmB9mJ8lGX/o8eP3xwtzBlG4vrAM=;
 b=MAc+MjXGOTIkHibHecnNUvnuxVMsWcf+LmFQkfxCjwS/jnGMMBES0XBEQyD59WrNasxuB6
 XbHkuIxVedDvB6/qLM9gl1OZyELlErE8dLdJJRYVQtTlVekYGhFZI++d63Qe5hY3RG9xhe
 nb+nJQCDDumnKehRo0Oxv9ZzHdnO8DgshVaVM8qjdKgNwUQCt3JkBCy0TS2oTZKrFYIOs7
 FwfHRB2e3zTyN1FlnybBq54/qZpDJ/Kb+ngDxvyZEGdChn9jyhIHt44wRO22kAPU7BvB8H
 GKHPp+dTctiWJt6ZEaRo6EBQWblPN3KAVw1jqnvbLOYx/nE0QoZMtwEK7ooNkg==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v6 4/4] mips: mt7628: Add Onion Omega2/2+ board support
Date: Thu,  7 Aug 2025 09:56:53 +0200
Message-Id: <20250807075653.356088-5-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075653.356088-1-pro@denx.de>
References: <20250807075653.356088-1-pro@denx.de>
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
    Changes in v6:
    	As Daniel pointed out in his review, vendor specific
    	configurations should be kept in the downstream sources. All of
    	this non-generic code has been removed in v6. Most notably, that
    	is:
    		- custom environment and bootcommand
    		- network settings
    		- mtd partitioning
    
    	Apart from that, there are a few more simplifications, like the
    	removal of gpio_init() and superfluous spi drivers.
    
    Changes in v5: none
    
    Changes in v4:
    	- Adapt bootcmd
    	- Rebase defconfig
    
    Changes in v3:
    	- Adapt defconfig to [PATCH 1/2] (SPL_SIZE_LIMIT)
    
    Changes in v2:
    	- Fix style issues as reported by checkpatch
    	- Add MAINTAINERS file

 arch/mips/dts/Makefile               |  1 +
 arch/mips/dts/onion-omega2p.dts      | 58 ++++++++++++++++++++++
 arch/mips/mach-mtmips/mt7628/Kconfig |  7 +++
 board/onion/omega2p/Kconfig          | 12 +++++
 board/onion/omega2p/MAINTAINERS      |  6 +++
 configs/onion-omega2p_defconfig      | 73 ++++++++++++++++++++++++++++
 include/configs/onion-omega2p.h      | 15 ++++++
 7 files changed, 172 insertions(+)
 create mode 100644 arch/mips/dts/onion-omega2p.dts
 create mode 100644 board/onion/omega2p/Kconfig
 create mode 100644 board/onion/omega2p/MAINTAINERS
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
index 00000000000..aaa0214a681
--- /dev/null
+++ b/board/onion/omega2p/MAINTAINERS
@@ -0,0 +1,6 @@
+ONION OMEGA2/2+
+M:	Philip Oberfichtner <pro@denx.de>
+S:	Maintained
+F:	arch/mips/dts/onion-omega2p.dts
+F:	configs/onion-omega2p_defconfig
+F:	include/configs/onion-omega2p.h
diff --git a/configs/onion-omega2p_defconfig b/configs/onion-omega2p_defconfig
new file mode 100644
index 00000000000..d72ce42c375
--- /dev/null
+++ b/configs/onion-omega2p_defconfig
@@ -0,0 +1,73 @@
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
+# CONFIG_AUTOBOOT is not set
+CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200"
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
+CONFIG_MTDIDS_DEFAULT="nor0=spi0.0"
+CONFIG_MTDPARTS_DEFAULT="spi0.0:192k(u-boot),64k(u-boot-env)"
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_LED=y
+CONFIG_LED_BLINK=y
+CONFIG_LED_GPIO=y
+CONFIG_DM_MTD=y
+CONFIG_SPI_FLASH_BAR=y
+CONFIG_SPI_FLASH_MACRONIX=y
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

