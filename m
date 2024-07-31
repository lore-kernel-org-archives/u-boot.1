Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDA9C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 21:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59D388A7B;
	Wed, 31 Jul 2024 23:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0MaulCEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0615488580; Wed, 31 Jul 2024 23:12:52 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A8988A61
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 23:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72bb=PA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722460360; bh=bpHkrA4IAjn/ccFiLfAaHRL59ksuThBkmkoF5NI/FXE=;
 b=0MaulCEj3cXtjbEah3WBOD9V4wph06vsX+7KRtTMurjPeNE256Blq/uPDkUhKPk5K8ZR7F7gX
 H6xYm2eg+2tu+WBoGZYH7OW6puglGWS2NQfZaL7qKCvC8cM/Xb7mRWv3VVnZUVDLXSAlbbxPE7f
 7kIsD3RJpjR/e7Ep0o4td4Mm9+MCNFgCCw43SNLP2AoOrhTgwKbgRNN2NjyWBiuCDQvTwt1QNtd
 NidxMkyvC3yVxdvIubZRw+kAPyOPneWFnBz0qBOXJA6E+Gc47Lc/YsnS+QRvOOHu/aPapf7IpVc
 xlH4ii1ExqXZV/AvnxssEZlQnrAX0dsixbQ8jZSYgvcg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Sebastian Kropatsch <seb-dev@mail.de>, u-boot@lists.denx.de
Subject: [PATCH 2/2] board: rockchip: Add FriendlyElec CM3588 NAS
Date: Wed, 31 Jul 2024 21:12:16 +0000
Message-ID: <20240731211221.1523453-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731211221.1523453-1-jonas@kwiboo.se>
References: <20240731211221.1523453-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66aaa8c506984f15edfbc5a8
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

The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based
on the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.

Features tested on a CM3588 NAS Kit with 8GB RAM 64GB eMMC module:
- SD-card boot
- eMMC boot
- Ethernet
- PCIe/NVMe
- USB gadget
- USB host

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 ...rk3588-friendlyelec-cm3588-nas-u-boot.dtsi |  8 ++
 arch/arm/mach-rockchip/rk3588/Kconfig         | 24 +++++
 board/friendlyelec/cm3588-nas-rk3588/Kconfig  | 12 +++
 .../cm3588-nas-rk3588/MAINTAINERS             |  6 ++
 configs/cm3588-nas-rk3588_defconfig           | 90 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 6 files changed, 141 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-friendlyelec-cm3588-nas-u-boot.dtsi
 create mode 100644 board/friendlyelec/cm3588-nas-rk3588/Kconfig
 create mode 100644 board/friendlyelec/cm3588-nas-rk3588/MAINTAINERS
 create mode 100644 configs/cm3588-nas-rk3588_defconfig

diff --git a/arch/arm/dts/rk3588-friendlyelec-cm3588-nas-u-boot.dtsi b/arch/arm/dts/rk3588-friendlyelec-cm3588-nas-u-boot.dtsi
new file mode 100644
index 000000000000..2e60f2dce8f1
--- /dev/null
+++ b/arch/arm/dts/rk3588-friendlyelec-cm3588-nas-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-u-boot.dtsi"
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 0dcf2249fb48..a76a470cc981 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -6,6 +6,29 @@ config TARGET_EVB_RK3588
 	help
 	  RK3588 EVB is a evaluation board for Rockchp RK3588.
 
+config TARGET_CM3588_NAS_RK3588
+	bool "FriendlyElec CM3588 NAS"
+	select BOARD_LATE_INIT
+	help
+	  The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based
+	  on the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
+
+	  Hardware features:
+	  - Rockchip RK3588 SoC
+	  - 4GB/8GB/16GB LPDDR4x RAM
+	  - 0GB/64GB HS400 eMMC
+	  - MicroSD card slot
+	  - 1x RTL8125B 2.5G Ethernet
+	  - 4x M.2 M-Key with PCIe 3.0 x1 (via bifurcation) for NVMe SSDs
+	  - 2x USB 3.0 (USB 3.1 Gen1) Type-A, 1x USB 2.0 Type-A
+	  - 1x USB 3.0 Type-C with DP AltMode support
+	  - 2x HDMI 2.1 out, 1x HDMI in
+	  - MIPI-CSI Connector, MIPI-DSI Connector
+	  - 40-pin GPIO header
+	  - 4 buttons: power, reset, recovery, MASK, user button
+	  - 3.5mm Headphone out, 2.0mm PH-2A Mic in
+	  - 5V Fan connector, PWM beeper, IR receiver, RTC battery connector
+
 config TARGET_JAGUAR_RK3588
 	bool "Theobroma Systems SBC-RK3588-AMR (Jaguar)"
 	select BOARD_LATE_INIT
@@ -339,6 +362,7 @@ config TEXT_BASE
 
 source "board/armsom/sige7-rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
+source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
 source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
 source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
diff --git a/board/friendlyelec/cm3588-nas-rk3588/Kconfig b/board/friendlyelec/cm3588-nas-rk3588/Kconfig
new file mode 100644
index 000000000000..fdc458a42643
--- /dev/null
+++ b/board/friendlyelec/cm3588-nas-rk3588/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_CM3588_NAS_RK3588
+
+config SYS_BOARD
+	default "cm3588-nas-rk3588"
+
+config SYS_VENDOR
+	default "friendlyelec"
+
+config SYS_CONFIG_NAME
+	default "nanopc-t6-rk3588"
+
+endif
diff --git a/board/friendlyelec/cm3588-nas-rk3588/MAINTAINERS b/board/friendlyelec/cm3588-nas-rk3588/MAINTAINERS
new file mode 100644
index 000000000000..92b958ada6fa
--- /dev/null
+++ b/board/friendlyelec/cm3588-nas-rk3588/MAINTAINERS
@@ -0,0 +1,6 @@
+CM3588-NAS-RK3588
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	board/friendlyelec/cm3588-nas-rk3588
+F:	configs/cm3588-nas-rk3588_defconfig
+F:	arch/arm/dts/rk3588-friendlyelec-cm3588-nas*
diff --git a/configs/cm3588-nas-rk3588_defconfig b/configs/cm3588-nas-rk3588_defconfig
new file mode 100644
index 000000000000..d6d82757a2de
--- /dev/null
+++ b/configs/cm3588-nas-rk3588_defconfig
@@ -0,0 +1,90 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-friendlyelec-cm3588-nas"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_CM3588_NAS_RK3588=y
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
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-friendlyelec-cm3588-nas.dtb"
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
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
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
+CONFIG_PHYLIB=y
+CONFIG_RTL8169=y
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
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 637d489f8428..0f9cb404d934 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -127,6 +127,7 @@ List of mainline supported Rockchip boards:
      - Rockchip EVB (evb-rk3588)
      - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
+     - FriendlyElec CM3588 NAS (cm3588-nas-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
      - FriendlyElec NanoPi R6S (nanopi-r6s-rk3588s)
-- 
2.45.2

