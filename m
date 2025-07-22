Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E41C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 20:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6978183403;
	Tue, 22 Jul 2025 22:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nzhnb.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nzhnb-com.20200927.dkim.feishu.cn header.i=@nzhnb-com.20200927.dkim.feishu.cn header.b="ef1Ei0U6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4319833F1; Tue, 22 Jul 2025 19:47:45 +0200 (CEST)
Received: from lf-1-35.ptr.blmpb.com (lf-1-35.ptr.blmpb.com [103.149.242.35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E61A8339C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 19:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nzhnb.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhihong@nzhnb.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=nzhnb-com.20200927.dkim.feishu.cn; t=1753206451;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=PuyxAjMQoyA3IyrbDrnvxHtP2CGfZQuyWPQA+01igRI=;
 b=ef1Ei0U6jKbFyAK6b8+qPzFUpzpCOP6zVRFjMr5EVjmnLbLY6RCHM2KUcsMwUi3yPGlnRv
 MQkOdKde1Sj5PPAgS53Oub+K7oDGIU3mJRo6i2rG554hs8Mhylra3ESRKRPmV2hJaGmhkR
 E/UX44U+iAlTbZ5iU1V5H5G8X5EYpUWWli28Gu2vD52HW3im2yZXHddMtIPqyFMEmVl93Y
 qyl7JU1eqLk8YkDONdC9dOT1K0TymHFPnnK2tI5ymGJyics05p0Sglrk/5bRrNuvSeBNL8
 9LO3Nb5oQwbpDxkzDAIB0klrt/6CweVAYqV+fVadTQcPwLOfzKksjjTksF/Pyw==
To: <u-boot@lists.denx.de>
Subject: [PATCH] board: rockchip: Add Xunlong Orange Pi 5 Ultra
Received: from nzhpc.lan ([116.234.144.157]) by smtp.feishu.cn with ESMTPS;
 Wed, 23 Jul 2025 01:47:29 +0800
From: "Zhihong" <zhihong@nzhnb.com>
Date: Wed, 23 Jul 2025 01:47:24 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 7bit
X-Original-From: Zhihong <zhihong@nzhnb.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Niu Zhihong" <zhihong@nzhnb.com>
Message-Id: <20250722174724.414401-1-zhihong@nzhnb.com>
X-Lms-Return-Path: <lba+2687fceb2+79425f+lists.denx.de+zhihong@nzhnb.com>
X-Mailman-Approved-At: Tue, 22 Jul 2025 22:22:40 +0200
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

From: Niu Zhihong <zhihong@nzhnb.com>

The Orange Pi 5 Ultra is another board in the Orange Pi 5 family.

Orange Pi 5 Ultra uses Rockchip RK3588,
a new generation of octa-core 64-bit ARM processor,
which includes quad-core A76 and quad-core A55.

Features tested on a Orange Pi 5 Ultra 16GB:
- SD-card boot
- eMMC boot
- PCIe/NVMe
- USB 2.0 host
- Ethernet
- WiFi

Signed-off-by: Niu Zhihong <zhihong@nzhnb.com>
---
 .../dts/rk3588-orangepi-5-ultra-u-boot.dtsi   | 20 +++++
 board/rockchip/evb_rk3588/MAINTAINERS         |  6 ++
 board/xunlong/orangepi-5-ultra-rk3588/Kconfig | 12 +++
 .../orangepi-5-ultra-rk3588/MAINTAINERS       |  6 ++
 configs/orangepi-5-ultra-rk3588_defconfig     | 88 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 6 files changed, 133 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi
 create mode 100644 board/xunlong/orangepi-5-ultra-rk3588/Kconfig
 create mode 100644 board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
 create mode 100644 configs/orangepi-5-ultra-rk3588_defconfig

diff --git a/arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi b/arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi
new file mode 100644
index 00000000000..1ab31a4ec5a
--- /dev/null
+++ b/arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-u-boot.dtsi"
+
+&fspim1_pins {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
+
+&sfc {
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
index 1232f05a387..379c85f48a4 100644
--- a/board/rockchip/evb_rk3588/MAINTAINERS
+++ b/board/rockchip/evb_rk3588/MAINTAINERS
@@ -48,3 +48,9 @@ S:	Maintained
 F:	configs/orangepi-5-plus-rk3588_defconfig
 F:	arch/arm/dts/rk3588-orangepi-5-plus.dts
 F:	arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
+
+ORANGEPI-5-RK3588-ULTRA
+M:	Niu Zhihong <zhihong@nzhnb.com>
+S:	Maintained
+F:	configs/orangepi-5-ultra-rk3588_defconfig
+F:	arch/arm/dts/rk3588-orangepi-5-ultra-u-boot.dtsi
diff --git a/board/xunlong/orangepi-5-ultra-rk3588/Kconfig b/board/xunlong/orangepi-5-ultra-rk3588/Kconfig
new file mode 100644
index 00000000000..43fc96b04c0
--- /dev/null
+++ b/board/xunlong/orangepi-5-ultra-rk3588/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_ORANGEPI_5_ULTRA_RK3588
+
+config SYS_BOARD
+	default "orangepi-5-ultra-rk3588"
+
+config SYS_VENDOR
+	default "xunlong"
+
+config SYS_CONFIG_NAME
+	default "evb_rk3588"
+
+endif
diff --git a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
new file mode 100644
index 00000000000..be9c93f6b9d
--- /dev/null
+++ b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
@@ -0,0 +1,6 @@
+ORANGEPI-5-RK3588-ULTRA
+M:	Niu Zhihong <zhihong@nzhnb.com>
+S:	Maintained
+F:	board/xunlong/orangepi-5-rk3588-ultra
+F:	configs/orangepi-5-ultra-rk3588_defconfig
+F:	arch/arm/dts/rk3588-orangepi-5-ultra.dts
diff --git a/configs/orangepi-5-ultra-rk3588_defconfig b/configs/orangepi-5-ultra-rk3588_defconfig
new file mode 100644
index 00000000000..f3274325922
--- /dev/null
+++ b/configs/orangepi-5-ultra-rk3588_defconfig
@@ -0,0 +1,88 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=80000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-orangepi-5-ultra"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_EVB_RK3588=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-ultra.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI_PCI=y
+CONFIG_DWC_AHCI=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_PHYLIB=y
+CONFIG_RTL8169=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b88299cbba2..4f2eea09e06 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -161,6 +161,7 @@ List of mainline supported Rockchip boards:
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Max (orangepi-5-max-rk3588)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
+     - Xunlong Orange Pi 5 Ultra (orangepi-5-ultra-rk3588)
      - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
      - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
      - Yanyi Tech CoolPi CM5 GenBook (coolpi-cm5-genbook-rk3588)
-- 
2.43.0
