Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99885D7876B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DEB4891B1;
	Thu, 21 Nov 2024 15:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="IdmhNzH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF42D89773; Thu, 21 Nov 2024 15:29:42 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8223F8974F
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZqATr59Kn7CbKw2YjcUXKxmFHJ5A64cPzToK8ETsmic=; b=IdmhNzH3V0QHSsejWFJvRt0v6o
 Zsw1DA0XO9Aw/XsbJxMMD6PhYmS8MYAYINUQj0fO6lZfGC7LVdkmdP/NrSwad3CwR938P2zzwZKla
 ENAVqP7pBn8gX0UjljQbq0JvP5sIr2vcytgDWJPJgRYFv4cBluhwBE+UPUJMAj0dA0GlnT17YFL7S
 c+ZPoTRjOp//HTfIxVcbACzqCw/7lNkfQtiu1vaF262mt2U1mSok9NzbT9luS1wTjvjrmbZsfGq9z
 AfD+s1xiepqfemEtAczVYViSypsYTR2+fZbNFuxGEMATWUaf1I6PMycG60FTDZ6DHTgfNtZT683Sp
 t6ENMn7g==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A7-0007f9-Qu; Thu, 21 Nov 2024 15:28:03 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH 20/20] rockchip: rk3576: Add support for ROC-RK3576-PC board
Date: Thu, 21 Nov 2024 15:27:31 +0100
Message-ID: <20241121142731.1202209-21-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
References: <20241121142731.1202209-1-heiko@sntech.de>
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

The ROC-RK3576-PC is a SBC made by Firefly, designed around the RK3576
SoC. This adds the needed board infrastructure and config for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi  | 12 ++++
 arch/arm/mach-rockchip/rk3576/Kconfig   |  9 +++
 board/firefly/roc-pc-rk3576/Kconfig     | 12 ++++
 board/firefly/roc-pc-rk3576/MAINTAINERS |  7 +++
 configs/roc-pc-rk3576_defconfig         | 77 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  3 +
 include/configs/roc-pc-rk3576.h         | 15 +++++
 7 files changed, 135 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
 create mode 100644 board/firefly/roc-pc-rk3576/Kconfig
 create mode 100644 board/firefly/roc-pc-rk3576/MAINTAINERS
 create mode 100644 configs/roc-pc-rk3576_defconfig
 create mode 100644 include/configs/roc-pc-rk3576.h

diff --git a/arch/arm/dts/rk3576-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
new file mode 100644
index 00000000000..0cfc7b5dcd6
--- /dev/null
+++ b/arch/arm/dts/rk3576-roc-pc-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Joshua Riek <jjriek@verizon.net>
+ *
+ */
+
+#include "rk3576-u-boot.dtsi"
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
diff --git a/arch/arm/mach-rockchip/rk3576/Kconfig b/arch/arm/mach-rockchip/rk3576/Kconfig
index 2e46b2b90d2..4c2328e5699 100644
--- a/arch/arm/mach-rockchip/rk3576/Kconfig
+++ b/arch/arm/mach-rockchip/rk3576/Kconfig
@@ -1,5 +1,12 @@
 if ROCKCHIP_RK3576
 
+config TARGET_ROC_PC_RK3576
+	bool "ROC_PC_RK3576"
+	select BOARD_LATE_INIT
+	help
+	  ROC-RK3576-PC is a single board computer from Firefly
+	  using the Rockchp RK3576.
+
 config ROCKCHIP_BOOT_MODE_REG
 	default 0x26024040
 
@@ -45,4 +52,6 @@ config SPL_STACK_R_ADDR
 config SPL_STACK_R_MALLOC_SIMPLE_LEN
 	default 0x200000
 
+source board/firefly/roc-pc-rk3576/Kconfig
+
 endif
diff --git a/board/firefly/roc-pc-rk3576/Kconfig b/board/firefly/roc-pc-rk3576/Kconfig
new file mode 100644
index 00000000000..2fc0f913c37
--- /dev/null
+++ b/board/firefly/roc-pc-rk3576/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_ROC_PC_RK3576
+
+config SYS_BOARD
+	default "roc-pc-rk3576"
+
+config SYS_VENDOR
+	default "firefly"
+
+config SYS_CONFIG_NAME
+	default "roc-pc-rk3576"
+
+endif
diff --git a/board/firefly/roc-pc-rk3576/MAINTAINERS b/board/firefly/roc-pc-rk3576/MAINTAINERS
new file mode 100644
index 00000000000..aa8897c16fc
--- /dev/null
+++ b/board/firefly/roc-pc-rk3576/MAINTAINERS
@@ -0,0 +1,7 @@
+ROC-RK3576-PC
+M:	Heiko Stuebner <heiko@sntech.de>
+S:	Maintained
+F:	board/firefly/roc-pc-rk3576
+F:	include/configs/roc-pc-rk3576.h
+F:	configs/roc-pc-rk3576_defconfig
+F:	arch/arm/dts/rk3576-roc-pc*
diff --git a/configs/roc-pc-rk3576_defconfig b/configs/roc-pc-rk3576_defconfig
new file mode 100644
index 00000000000..25e4fa1e8f6
--- /dev/null
+++ b/configs/roc-pc-rk3576_defconfig
@@ -0,0 +1,77 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-roc-pc"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_ROC_PC_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-roc-pc.dtb"
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
+CONFIG_SPL_CLK=y
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
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 6b544e957b2..5b01d536c05 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -125,6 +125,9 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK 3A (rock-3a-rk3568)
      - Radxa ROCK 3B (rock-3b-rk3568)
 
+* rk3576
+     - Firefly ROC-RK3576-PC (roc-pc-rk3576)
+
 * rk3588
      - ArmSoM Sige7 (sige7-rk3588)
      - Rockchip EVB (evb-rk3588)
diff --git a/include/configs/roc-pc-rk3576.h b/include/configs/roc-pc-rk3576.h
new file mode 100644
index 00000000000..ac98d516478
--- /dev/null
+++ b/include/configs/roc-pc-rk3576.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef __ROC_PC_RK3576_H
+#define __ROC_PC_RK3576_H
+
+#include <configs/rk3576_common.h>
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#endif
-- 
2.45.2

