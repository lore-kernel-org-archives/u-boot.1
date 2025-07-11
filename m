Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26D2C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 303D582D21;
	Sat, 12 Jul 2025 00:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kIrIl/Nv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B4A81FEE; Sat, 12 Jul 2025 00:45:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FCD83046
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752273916; bh=RLYuxlxJ+Zp07bna8hx4+QQQztuUztAVWUe6HAMc2ck=;
 b=kIrIl/Nv5/WwTEMibLusqXq20bshmEodyYJ0cUvc7NHAsAuPp4kS9C/Z6R60IccaN9KfWC7R5
 hR5x84SJHU4pJ4WICniZO7Azoerb3ZoeH6jtVVLnBzwjsszzCF3UMEFjoaCgNXcIc6JCCobrC/M
 d/rt047m6QuZGGgOvSjTlRDghOhH2RYiuWBQ9liIIIHwaZymXR3ex3iLUbY0PCICfL8b9D2/tZk
 YAxZEcYsEqZw1qtYPWbQQwB5qnkBs2zHdFMzsMUdzyynU1Xzdv2DHIYUx6BclxZJMNVm/rTf6v+
 FlmanvExjDljenOq/jLqclpqjX5rpR3Eu2ke8PTQAJYw==
X-Forward-Email-ID: 687193fa26dc7c4d255611e1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH v2 6/6] board: rockchip: Add ArmSoM Sige5
Date: Fri, 11 Jul 2025 22:44:36 +0000
Message-ID: <20250711224446.211511-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711224446.211511-1-jonas@kwiboo.se>
References: <20250711224446.211511-1-jonas@kwiboo.se>
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

ArmSoM-Sige5 adopts the second-generation 8nm high-performance AIOT
platform Rockchip RK3576, with a 6 TOPS computing power NPU and support
for up to 16GB of large memory. It supports 4K video encoding and
decoding, offers rich interfaces including dual gigabit Ethernet ports,
WiFi 6 & BT5, and various video outputs.

Features tested on a ArmSoM Sige5 v1.1:
- SD-card boot
- eMMC boot
- Ethernet
- PCIe NVMe

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v2:
- Enable PCIe, NVMe and USB Kconfig options
- Collect r-b tag
---
 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi | 18 ++++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS    |  6 ++
 configs/sige5-rk3576_defconfig               | 66 ++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  1 +
 4 files changed, 91 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
 create mode 100644 configs/sige5-rk3576_defconfig

diff --git a/arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi b/arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
new file mode 100644
index 000000000000..7e0530d85d16
--- /dev/null
+++ b/arch/arm/dts/rk3576-armsom-sige5-u-boot.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3576-u-boot.dtsi"
+
+/ {
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+	};
+};
+
+&red_led {
+	default-state = "on";
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+};
diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index b5190c818468..94ef74d429f9 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -3,3 +3,9 @@ M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	arch/arm/dts/rk3576-generic*
 F:	configs/generic-rk3576_defconfig
+
+SIGE5-RK3576
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3576-armsom-sige5*
+F:	configs/sige5-rk3576_defconfig
diff --git a/configs/sige5-rk3576_defconfig b/configs/sige5-rk3576_defconfig
new file mode 100644
index 000000000000..c515e1455952
--- /dev/null
+++ b/configs/sige5-rk3576_defconfig
@@ -0,0 +1,66 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-armsom-sige5"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-armsom-sige5.dtb"
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
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
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
index 591c664aa27c..05731f70f92c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -134,6 +134,7 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK 3B (rock-3b-rk3568)
 
 * rk3576
+     - ArmSoM Sige5 (sige5-rk3576)
      - Firefly ROC-RK3576-PC (roc-pc-rk3576)
      - Generic RK3576 (generic-rk3576)
 
-- 
2.49.0

