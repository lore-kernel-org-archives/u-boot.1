Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC3ACF34C3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 20:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F3F88F95;
	Thu,  3 Oct 2024 22:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qZjF/zOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B769E88F6B; Thu,  3 Oct 2024 22:00:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 154D588F57
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 22:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a5dc=RA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1727985600; bh=O6Ze9EZsNyZ0N8X3O2erT90FLjocwY7A5jf7iRQpyiE=;
 b=qZjF/zOxZj8HG6T3RrKmktlPYKqcjlkz3HHqRf2tFWC5p8/eHif1qgaloVfWCSRfEt5X3ceu6
 aKxffg/X+poldrQAmj2FHS6nhI9uBVyhVQX3Yu3pjb8Zl6vfB4vOLUpGLKWgOUSTOrqgL1s3LV9
 s3UIAu9oZD+y82+IDDL7DGhMdktBrKFS2qk6Pfxt5J4/QEAkja879fWLy8oPXqqMCQ4TZsSw5U5
 EZX+SALT+PFZ4GsIeq5Syk3cL3btGvE0N/j/TOKj75sl4vg7PpszTuHOIYT15WwzsZmF9JFp7TU
 kcHtBzI63yL8mIpIgG6S+YHiK2sai7lhwLATzWE8HZXA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 2/2] board: rockchip: Add Hardkernel ODROID-M2
Date: Thu,  3 Oct 2024 19:59:34 +0000
Message-ID: <20241003195941.340519-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003195941.340519-1-jonas@kwiboo.se>
References: <20241003195941.340519-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66fef7bd5caab3e1f31096f2
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

The Hardkernel ODROID-M2 is a single-board computer based on Rockchip
RK3588S2 SoC. It features e.g. 8/16 GB LPDDR5 RAM, 64 GB eMMC, SD-card,
GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0/Type-C.

Features tested on a ODROID-M2 16GB rev1.0 20240611:
- SD-card boot
- eMMC boot
- Ethernet
- PCIe/NVMe
- USB gadget
- USB host

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi |  3 +
 arch/arm/mach-rockchip/rk3588/Kconfig      |  7 ++
 board/hardkernel/odroid_m2/Kconfig         | 12 +++
 board/hardkernel/odroid_m2/MAINTAINERS     |  7 ++
 configs/odroid-m2-rk3588s_defconfig        | 96 ++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst            |  1 +
 include/configs/odroid_m2.h                | 11 +++
 7 files changed, 137 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
 create mode 100644 board/hardkernel/odroid_m2/Kconfig
 create mode 100644 board/hardkernel/odroid_m2/MAINTAINERS
 create mode 100644 configs/odroid-m2-rk3588s_defconfig
 create mode 100644 include/configs/odroid_m2.h

diff --git a/arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi b/arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
new file mode 100644
index 000000000000..853ed58cfe58
--- /dev/null
+++ b/arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index a76a470cc981..6f28a3133255 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -134,6 +134,12 @@ config TARGET_NOVA_RK3588
 	  includes socket for eMMC storage, an SDMMC slot, and a 40-pin
 	  GPIO header for expansion.
 
+config TARGET_ODROID_M2_RK3588S
+	bool "Hardkernel ODROID-M2"
+	select BOARD_LATE_INIT
+	help
+	  Hardkernel ODROID-M2 single board computer with a RK3588S2 SoC.
+
 config TARGET_RK3588_NEU6
 	bool "Edgeble Neural Compute Module 6(Neu6) SoM"
 	select BOARD_LATE_INIT
@@ -366,6 +372,7 @@ source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
 source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
 source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
+source "board/hardkernel/odroid_m2/Kconfig"
 source "board/indiedroid/nova/Kconfig"
 source "board/pine64/quartzpro64-rk3588/Kconfig"
 source "board/turing/turing-rk1-rk3588/Kconfig"
diff --git a/board/hardkernel/odroid_m2/Kconfig b/board/hardkernel/odroid_m2/Kconfig
new file mode 100644
index 000000000000..b537459c879d
--- /dev/null
+++ b/board/hardkernel/odroid_m2/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_ODROID_M2_RK3588S
+
+config SYS_BOARD
+	default "odroid_m2"
+
+config SYS_VENDOR
+	default "hardkernel"
+
+config SYS_CONFIG_NAME
+	default "odroid_m2"
+
+endif
diff --git a/board/hardkernel/odroid_m2/MAINTAINERS b/board/hardkernel/odroid_m2/MAINTAINERS
new file mode 100644
index 000000000000..13c0a8ba5b7a
--- /dev/null
+++ b/board/hardkernel/odroid_m2/MAINTAINERS
@@ -0,0 +1,7 @@
+ODROID-M2
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	board/hardkernel/odroid_m2/
+F:	include/configs/odroid_m2.h
+F:	configs/odroid-m2-rk3588s_defconfig
+F:	arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
new file mode 100644
index 000000000000..d612ef394c47
--- /dev/null
+++ b/configs/odroid-m2-rk3588s_defconfig
@@ -0,0 +1,96 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-odroid-m2"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_ODROID_M2_RK3588S=y
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-odroid-m2.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_INI=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_CRAMFS=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI_PCI=y
+CONFIG_DWC_AHCI=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
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
+CONFIG_FS_CRAMFS=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 43a62e8c3a71..571bcf494065 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -134,6 +134,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
      - FriendlyElec NanoPi R6S (nanopi-r6s-rk3588s)
      - Generic RK3588S/RK3588 (generic-rk3588)
+     - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
      - Indiedroid Nova (nova-rk3588s)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
      - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
diff --git a/include/configs/odroid_m2.h b/include/configs/odroid_m2.h
new file mode 100644
index 000000000000..c5ed42cd2e72
--- /dev/null
+++ b/include/configs/odroid_m2.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ODROID_M2_H
+#define __ODROID_M2_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+	"cramfsaddr=0x0c000000\0"
+
+#include <configs/rk3588_common.h>
+
+#endif
-- 
2.46.2

