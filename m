Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FF6CCD195
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 16:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B037A838EF;
	Sun, 19 Oct 2025 18:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="G0tD+DVI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7D2838D5; Sun, 19 Oct 2025 18:51:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0863D838B7
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 18:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1760892669; bh=gjWMrWzc1m6nJi6MHiLyFK8a21hWUkjDUvhL5d8g/Oc=;
 b=G0tD+DVI70+l2PLWKud7IF+0L5mbljn0/xhk5CLd4KMqK+Nza4ZHCCOV2TNsMsCYVVkEdr3Ts
 7HYUfjCe+p+le0hJNSOvsWG+5gBLgNgSvevNzgEyGWf7VOJsYZUs0EgYbGmUq0d4VdcsKmblfIK
 1kNtRn1eYehLCLXPuZHFam7LDf+1ujfrFmP3jA3yphFEx8IO2NZ7KlV0x4VfMvPJStyhnbUFkfA
 maqa5n0ZJtombSmG33iv3+YLhYro+AAu7cAlmOZGfUugHh19SAPVj0zAkcw0zxVw926uHjYk0V/
 C1RIkLeChU3USjO5GkXDc8DLeyGWMyk3wLmmapXYgO8w==
X-Forward-Email-ID: 68f516fa5ea0c67427244200
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: John Clark <inindev@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/2] board: rockchip: Add Luckfox Omni3576
Date: Sun, 19 Oct 2025 16:50:50 +0000
Message-ID: <20251019165056.885394-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019165056.885394-1-jonas@kwiboo.se>
References: <20251019165056.885394-1-jonas@kwiboo.se>
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

Luckfox Omni3576 Carrier Board with Core3576 Module, powered by the
Rockchip RK3576 SoC with four Cortex-A72 cores, four Cortex-A53 cores,
and a Mali-G52 MC3 GPU.

Features tested with a Core3576 Rev1.1 on a Omni3576 carrier board:
- SD-card boot
- eMMC boot
- LED
- PCIe/NVMe
- USB2.0 HOST

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 .../dts/rk3576-luckfox-omni3576-u-boot.dtsi   | 11 ++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  6 ++
 configs/omni3576-rk3576_defconfig             | 63 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 4 files changed, 81 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-luckfox-omni3576-u-boot.dtsi
 create mode 100644 configs/omni3576-rk3576_defconfig

diff --git a/arch/arm/dts/rk3576-luckfox-omni3576-u-boot.dtsi b/arch/arm/dts/rk3576-luckfox-omni3576-u-boot.dtsi
new file mode 100644
index 000000000000..28773696b972
--- /dev/null
+++ b/arch/arm/dts/rk3576-luckfox-omni3576-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3576-u-boot.dtsi"
+
+&green_led {
+	default-state = "on";
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+};
diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index 54c75f451f0f..e236163992d7 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -4,6 +4,12 @@ S:	Maintained
 F:	arch/arm/dts/rk3576-generic*
 F:	configs/generic-rk3576_defconfig
 
+OMNI3576-RK3576
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3576-luckfox-omni3576*
+F:	configs/omni3576-rk3576_defconfig
+
 ROCK-4D-RK3576
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/omni3576-rk3576_defconfig b/configs/omni3576-rk3576_defconfig
new file mode 100644
index 000000000000..13ef3112f1b8
--- /dev/null
+++ b/configs/omni3576-rk3576_defconfig
@@ -0,0 +1,63 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-luckfox-omni3576"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-luckfox-omni3576.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 0ec56c8d068a..426c38b7189f 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -137,6 +137,7 @@ List of mainline supported Rockchip boards:
      - ArmSoM Sige5 (sige5-rk3576)
      - Firefly ROC-RK3576-PC (roc-pc-rk3576)
      - Generic RK3576 (generic-rk3576)
+     - Luckfox Omni3576 (omni3576-rk3576)
      - Radxa ROCK 4D (rock-4d-rk3576)
 
 * rk3588
-- 
2.51.0

