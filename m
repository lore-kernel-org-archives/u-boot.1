Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E752C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBEC82D21;
	Sat, 12 Jul 2025 00:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JID8+aAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0ECB82FCA; Sat, 12 Jul 2025 00:22:01 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190E982FAB
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752272515; bh=0uBnyE6tQvZGywGWmPjn6D2ZSPun5S5+GAlNYO/L/10=;
 b=JID8+aAsgzZWd/Z3ZAB1wWcsrL/f78REvHyAvh2+YjWPP3dh1u6igcHYQYdiO0XHt4QaFnkYj
 bdAoSBI0rpMfRpWsq0aruONc+Lz0eyaqhMPp5IX+uZHYvI+m9vyifiylSrZwbPEAerGoZTbZ+/i
 iJGouFP3AI5lC+mOyf7doFlf0vE7F5T+D2AryJUJpN6xIQKxZIesk7MyINYN8KqP/G/gs144fxW
 tJct2Oh1FgjLEx08etXTOVkNdBRKWbylhJbE2OPCFsyPkgA5srlffnXsWK7jWytAKTrPi5nr8KS
 gJMNJgnbdq3IJlwRDPzRTYPSO4Pp/2fJdgxXhFjSfELA==
X-Forward-Email-ID: 68718e8126dc7c4d2555fd36
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 4/6] board: rockchip: Add minimal generic RK3576 board
Date: Fri, 11 Jul 2025 22:21:19 +0000
Message-ID: <20250711222132.204344-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711222132.204344-1-jonas@kwiboo.se>
References: <20250711222132.204344-1-jonas@kwiboo.se>
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

Add a minimal generic RK3576 board that only have eMMC, SDMMC and USB
OTG enabled. This defconfig can be used to boot from eMMC or SD-card on
most RK3576 boards that follow reference board design.

eMMC and SD-card boot tested on:
- ArmSoM CM5
- ArmSoM Sige5
- FriendlyElec NanoPi M5
- Luckfox Omni3576
- Toybrick TB-RK3576D

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Add nodes and Kconfig options for USB OTG
---
 arch/arm/dts/rk3576-generic-u-boot.dtsi   |  3 ++
 arch/arm/dts/rk3576-generic.dts           | 65 +++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS |  5 ++
 configs/generic-rk3576_defconfig          | 51 ++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 5 files changed, 125 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-generic.dts
 create mode 100644 arch/arm/mach-rockchip/rk3576/MAINTAINERS
 create mode 100644 configs/generic-rk3576_defconfig

diff --git a/arch/arm/dts/rk3576-generic-u-boot.dtsi b/arch/arm/dts/rk3576-generic-u-boot.dtsi
new file mode 100644
index 000000000000..632fabb6af56
--- /dev/null
+++ b/arch/arm/dts/rk3576-generic-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3576-u-boot.dtsi"
diff --git a/arch/arm/dts/rk3576-generic.dts b/arch/arm/dts/rk3576-generic.dts
new file mode 100644
index 000000000000..d984fa3746e0
--- /dev/null
+++ b/arch/arm/dts/rk3576-generic.dts
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Minimal generic DT for RK3576 with eMMC, SD-card and USB OTG enabled
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "rk3576.dtsi"
+
+/ {
+	model = "Generic RK3576";
+	compatible = "rockchip,rk3576";
+
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0m0_xfer>;
+	status = "okay";
+};
+
+&usb_drd0_dwc3 {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
+
+&usbdp_phy {
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
new file mode 100644
index 000000000000..b5190c818468
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -0,0 +1,5 @@
+GENERIC-RK3576
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3576-generic*
+F:	configs/generic-rk3576_defconfig
diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
new file mode 100644
index 000000000000..a5b82f219aa4
--- /dev/null
+++ b/configs/generic-rk3576_defconfig
@@ -0,0 +1,51 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rk3576-generic"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-generic.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_NO_NET=y
+# CONFIG_ADC is not set
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1e46f2b56192..6a8a3b386d22 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -138,6 +138,7 @@ List of mainline supported Rockchip boards:
 
 * rk3576
      - Firefly ROC-RK3576-PC (roc-pc-rk3576)
+     - Generic RK3576 (generic-rk3576)
 
 * rk3588
      - ArmSoM Sige7 (sige7-rk3588)
-- 
2.49.0

