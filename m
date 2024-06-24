Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C392CC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 20:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B85E882DC;
	Mon, 24 Jun 2024 22:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D79882DC; Mon, 24 Jun 2024 22:45:57 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4979B87CFE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 22:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 45OKjdWx011336; Tue, 25 Jun 2024 05:45:39 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 banglang.huang@foxmail.com, jonas@kwiboo.se,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH] rockchip: add support for Radxa ROCK Pi E v3.0
Date: Tue, 25 Jun 2024 05:45:29 +0900
Message-ID: <20240624204529.34742-1-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
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

ROCK Pi E v3.0 uses DDR4 SDRAM instead of DDR3 SDRAM used in v1.2x.

prepare new rk3328-rock-pi-e-v3.dts in u-boot which just includes
upstream rk3328-rock-pi-e.dts.

defconfig still uses
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"

because v3.0 and prior are compatible.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 ...dtsi => rk3328-rock-pi-e-base-u-boot.dtsi} |  1 -
 arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi     | 47 +--------
 arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi  |  4 +
 arch/arm/dts/rk3328-rock-pi-e-v3.dts          |  4 +
 board/rockchip/evb_rk3328/MAINTAINERS         |  4 +-
 configs/rock-pi-e-v3-rk3328_defconfig         | 97 +++++++++++++++++++
 6 files changed, 111 insertions(+), 46 deletions(-)
 copy arch/arm/dts/{rk3328-rock-pi-e-u-boot.dtsi => rk3328-rock-pi-e-base-u-boot.dtsi} (94%)
 rewrite arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi (88%)
 create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3328-rock-pi-e-v3.dts
 create mode 100644 configs/rock-pi-e-v3-rk3328_defconfig

diff --git a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
similarity index 94%
copy from arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
copy to arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
index d314bfad6f..39bb66c4fc 100644
--- a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock-pi-e-base-u-boot.dtsi
@@ -4,7 +4,6 @@
  */
 
 #include "rk3328-u-boot.dtsi"
-#include "rk3328-sdram-ddr3-666.dtsi"
 
 / {
 	smbios {
diff --git a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
dissimilarity index 88%
index d314bfad6f..8e82f6a6f1 100644
--- a/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
@@ -1,43 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2020 Radxa
- */
-
-#include "rk3328-u-boot.dtsi"
-#include "rk3328-sdram-ddr3-666.dtsi"
-
-/ {
-	smbios {
-		compatible = "u-boot,sysinfo-smbios";
-
-		smbios {
-			system {
-				manufacturer = "radxa";
-				product = "rock-pi-e_rk3328";
-			};
-
-			baseboard {
-				manufacturer = "radxa";
-				product = "rock-pi-e_rk3328";
-			};
-
-			chassis {
-				manufacturer = "radxa";
-				product = "rock-pi-e_rk3328";
-			};
-		};
-	};
-};
-
-&u2phy_host {
-	phy-supply = <&vcc_host_5v>;
-};
-
-&vcc_host_5v {
-	/delete-property/ regulator-always-on;
-	/delete-property/ regulator-boot-on;
-};
-
-&vcc_sd {
-	bootph-pre-ram;
-};
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3328-rock-pi-e-base-u-boot.dtsi"
+#include "rk3328-sdram-ddr3-666.dtsi"
diff --git a/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi b/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
new file mode 100644
index 0000000000..4d89ae54e6
--- /dev/null
+++ b/arch/arm/dts/rk3328-rock-pi-e-v3-u-boot.dtsi
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3328-rock-pi-e-base-u-boot.dtsi"
+#include "rk3328-sdram-ddr4-666.dtsi"
diff --git a/arch/arm/dts/rk3328-rock-pi-e-v3.dts b/arch/arm/dts/rk3328-rock-pi-e-v3.dts
new file mode 100644
index 0000000000..f1c1c36a99
--- /dev/null
+++ b/arch/arm/dts/rk3328-rock-pi-e-v3.dts
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+#include "rk3328-rock-pi-e.dts"
diff --git a/board/rockchip/evb_rk3328/MAINTAINERS b/board/rockchip/evb_rk3328/MAINTAINERS
index 675b72dd06..8f619e54e0 100644
--- a/board/rockchip/evb_rk3328/MAINTAINERS
+++ b/board/rockchip/evb_rk3328/MAINTAINERS
@@ -64,5 +64,5 @@ M:      Banglang Huang <banglang.huang@foxmail.com>
 R:      Jonas Karlman <jonas@kwiboo.se>
 S:      Maintained
 F:      configs/rock-pi-e-rk3328_defconfig
-F:      arch/arm/dts/rk3328-rock-pi-e.dts
-F:      arch/arm/dts/rk3328-rock-pi-e-u-boot.dtsi
+F:      configs/rock-pi-e-v3-rk3328_defconfig
+F:      arch/arm/dts/rk3328-rock-pi-e*
diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
new file mode 100644
index 0000000000..4c6cc634bd
--- /dev/null
+++ b/configs/rock-pi-e-v3-rk3328_defconfig
@@ -0,0 +1,97 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=20000000
+CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock-pi-e-v3"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3328=y
+CONFIG_DEBUG_UART_BASE=0xFF130000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_POWER=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_TPL_OF_CONTROL=y
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_TPL_OF_PLATDATA=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_TPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_TPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_TPL_SYSCON=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_TPL_RAM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_SYSRESET=y
+# CONFIG_TPL_SYSRESET is not set
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_TPL_TINY_MEMSET=y
+CONFIG_ERRNO_STR=y
-- 
2.43.0

