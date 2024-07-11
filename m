Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0A8C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 10:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD199886DB;
	Thu, 11 Jul 2024 12:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="6txjhL2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE67488665; Thu, 11 Jul 2024 12:22:14 +0200 (CEST)
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957F6886B6
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 12:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
 by shout02.mail.de (Postfix) with ESMTP id F10AE240F7C;
 Thu, 11 Jul 2024 12:22:11 +0200 (CEST)
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
 by postfix03.mail.de (Postfix) with ESMTP id D2FE48030C;
 Thu, 11 Jul 2024 12:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1720693331;
 bh=90wK1B1O/b8TlU4xx13C9+d34hzlG3GqUZBQht9jtdk=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=6txjhL2qiHSAJhAER8heYLwSAQNNr97q9LPvUy5grYZKg0vayt8XNfvS89UIVZAGf
 xucrcELTrc6xaEBNnmOx/ldSI0/PG5SRKf3mehQleds3APeszY85ui5heP4VWW7+DT
 sTlb1nHi+ID+8HCXOskV9svvw0TOY37ZS1CabIcE257g4uwa0vDFMRqgu+cPQqtO/5
 EjRC1RoRPedOXIbIaa2BqgGtg4B6itAGWxMvRHIKBfx0vmztpRHFrw4KFLVTOuLVT0
 cF4W0+gQlT4Lm6W9/RkjKEX+p7tIzp5DpMi8AGfeoU3TbG2qhx8g+kFQqJZs6dAeo7
 Qk/WiTkaD/0bQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 805BC240CFA;
 Thu, 11 Jul 2024 12:22:11 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Ulli Kehrle <ulli@vegan.im.it>,
 u-boot@lists.denx.de
Subject: [PATCH v3 2/2] board: rockchip: Add FriendlyElec NanoPi R6S
Date: Thu, 11 Jul 2024 12:15:18 +0200
Message-ID: <20240711101836.6721-2-seb-dev@mail.de>
In-Reply-To: <20240711101836.6721-1-seb-dev@mail.de>
References: <20240711101836.6721-1-seb-dev@mail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 7750
X-purgate-ID: 154282::1720693331-BFD29878-2F6CCBC5/0/0
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

The NanoPi R6S is a SBC by FriendlyElec based on the Rockchip RK3588s.
It comes with 4GB or 8GB of RAM, a microSD card slot, 32GB eMMC storage,
one RTL8211F 1GbE and two RTL8125 2.5GbE Ethernet ports, one USB 2.0
Type-A and one USB 3.0 Type-A port, a HDMI port, a 12-pin GPIO FPC
connector, a fan connector, IR receiver as well as some buttons and LEDs.

Add initial support for this board using the upstream devicetree sources.

Kernel commit:
f1b11f43b3e9 ("arm64: dts: rockchip: Add support for NanoPi R6S")

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi   |  3 +
 arch/arm/mach-rockchip/rk3588/Kconfig         | 13 +++
 board/friendlyelec/nanopi-r6s-rk3588s/Kconfig | 12 +++
 .../nanopi-r6s-rk3588s/MAINTAINERS            |  7 ++
 configs/nanopi-r6s-rk3588s_defconfig          | 82 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 include/configs/nanopi-r6s-rk3588s.h          | 12 +++
 7 files changed, 130 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi
 create mode 100644 board/friendlyelec/nanopi-r6s-rk3588s/Kconfig
 create mode 100644 board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS
 create mode 100644 configs/nanopi-r6s-rk3588s_defconfig
 create mode 100644 include/configs/nanopi-r6s-rk3588s.h

diff --git a/arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi b/arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi
new file mode 100644
index 0000000000..853ed58cfe
--- /dev/null
+++ b/arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 26e45f43ff..e751d64e1a 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -90,6 +90,18 @@ config TARGET_NANOPI_R6C_RK3588S
 	  Type-A port, a HDMI port, a 30-pin GPIO header as well as some
 	  buttons and LEDs.
 
+config TARGET_NANOPI_R6S_RK3588S
+	bool "FriendlyElec NanoPi R6S"
+	select BOARD_LATE_INIT
+	help
+	  The NanoPi R6S is a SBC by FriendlyElec based on the Rockchip
+	  RK3588s.
+	  It comes with 4GB or 8GB of RAM, a microSD card slot, 32GB eMMC
+	  storage, one RTL8211F 1GbE and two RTL8125 2.5GbE Ethernet ports,
+	  one USB 2.0 Type-A and one USB 3.0 Type-A port, a HDMI port, a
+	  12-pin GPIO FPC connector, a fan connector, IR receiver as well
+	  as some buttons and LEDs.
+
 config TARGET_NOVA_RK3588
 	bool "Indiedroid Nova RK3588"
 	select BOARD_LATE_INIT
@@ -301,6 +313,7 @@ source "board/armsom/sige7-rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
 source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
+source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
 source "board/indiedroid/nova/Kconfig"
 source "board/pine64/quartzpro64-rk3588/Kconfig"
 source "board/turing/turing-rk1-rk3588/Kconfig"
diff --git a/board/friendlyelec/nanopi-r6s-rk3588s/Kconfig b/board/friendlyelec/nanopi-r6s-rk3588s/Kconfig
new file mode 100644
index 0000000000..4d579816b1
--- /dev/null
+++ b/board/friendlyelec/nanopi-r6s-rk3588s/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_NANOPI_R6S_RK3588S
+
+config SYS_BOARD
+	default "nanopi-r6s-rk3588s"
+
+config SYS_VENDOR
+	default "friendlyelec"
+
+config SYS_CONFIG_NAME
+	default "nanopi-r6s-rk3588s"
+
+endif
diff --git a/board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS b/board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS
new file mode 100644
index 0000000000..76288b4320
--- /dev/null
+++ b/board/friendlyelec/nanopi-r6s-rk3588s/MAINTAINERS
@@ -0,0 +1,7 @@
+NANOPI-R6S
+M:	Sebastian Kropatsch <seb-dev@mail.de>
+S:	Maintained
+F:	arch/arm/dts/rk3588s-nanopi-r6s-u-boot.dtsi
+F:	board/friendlyelec/nanopi-r6s-rk3588s
+F:	configs/nanopi-r6s-rk3588s_defconfig
+F:	include/configs/nanopi-r6s-rk3588s.h
diff --git a/configs/nanopi-r6s-rk3588s_defconfig b/configs/nanopi-r6s-rk3588s_defconfig
new file mode 100644
index 0000000000..f7b364655f
--- /dev/null
+++ b/configs/nanopi-r6s-rk3588s_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-nanopi-r6s"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_NANOPI_R6S_RK3588S=y
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-nanopi-r6s.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+# CONFIG_SPI_FLASH is not set
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_RTL8169=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index d04fc6d3c6..6b951cda52 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -125,6 +125,7 @@ List of mainline supported Rockchip boards:
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
+     - FriendlyElec NanoPi R6S (nanopi-r6s-rk3588s)
      - Generic RK3588S/RK3588 (generic-rk3588)
      - Indiedroid Nova (nova-rk3588s)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
diff --git a/include/configs/nanopi-r6s-rk3588s.h b/include/configs/nanopi-r6s-rk3588s.h
new file mode 100644
index 0000000000..a1b19783c5
--- /dev/null
+++ b/include/configs/nanopi-r6s-rk3588s.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __NANOPI_R6S_RK3588S_H
+#define __NANOPI_R6S_RK3588S_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __NANOPI_R6S_RK3588S_H */
-- 
2.43.0

