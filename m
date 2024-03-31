Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6A4CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8363688303;
	Sun, 31 Mar 2024 22:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Py1G4J9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3843188305; Sun, 31 Mar 2024 22:31:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 217408830C
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917085; bh=aGcLob6+woTsusIeSjdpPvu5k1+BifrYpKaeXVmoTik=;
 b=Py1G4J9bpvglrwvmxEWoTmVvpaX1eHMLY5+TnDgQVFSl+Qs39KZvpL3mWQPjRL0J38ui0Nq73
 PFluOgbnk2DpONaWQQjoUAf8BcG5tFpCyy7RaZpguaLNYg6brMmufPon9NYiAzX87OqQq5LpVJc
 hekGcsFCkhKWtQXjGL/dcZUqH1E4GOJECb3PfKX0WebvMURk3I4kQQGb7YCECoeOwjHUc7Ob6ZJ
 0L0ACUtxcR4rMPPcp+TVvjlL3JQmOv8+/P1cWe/k54VG9NnAD0IXFvwr7IGjU6rkfgJBTpwzFGh
 ObqW9PSLYSUqy4mVtmbOzcHsscfz0hnoHtYeGlNOXvOg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Deepak Das
 <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>, Xiaobo
 Tian <peterwillcn@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 25/31] rockchip: rk3399-nanopi-4: Sync device tree from linux
 v6.8
Date: Sun, 31 Mar 2024 20:28:31 +0000
Message-ID: <20240331202921.262323-26-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c81b8fc6b45ed44f7436
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

Sync rk3399-nanopi-4 related device tree from linux v6.8.

Add DM_RESET=y to support reset signals.

Add PCI=y, CMD_PCI=y and NVME_PCI=y to support PCIe and NVMe boot.

Add AHCI=y, SCSI_AHCI=y, AHCI_PCI=y and SCSI=y to support PCIe SATA boot.

Add ROCKCHIP_IODOMAIN=y to configure io-domain voltage.

Add MMC_SDHCI_SDMA=y to use DMA transfer for eMMC.

Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.

Add PHY_ROCKCHIP_INNO_USB2=y and PHY_ROCKCHIP_TYPEC=y to support USB PHY.

Remove REGULATOR_PWM=y, boards does not use pwm-regulator compatible.

Remove SPL_TINY_MEMSET=y to use full memset in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-nanopc-t4.dts       |  2 +-
 arch/arm/dts/rk3399-nanopi-m4-2gb.dts   | 55 +------------------------
 arch/arm/dts/rk3399-nanopi-m4b.dts      |  2 +-
 arch/arm/dts/rk3399-nanopi-r4s.dts      |  4 +-
 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi |  4 ++
 arch/arm/dts/rk3399-nanopi4.dtsi        |  7 ++--
 configs/nanopc-t4-rk3399_defconfig      | 14 +++++--
 configs/nanopi-m4-2gb-rk3399_defconfig  | 18 ++++++--
 configs/nanopi-m4-rk3399_defconfig      | 18 ++++++--
 configs/nanopi-m4b-rk3399_defconfig     | 18 ++++++--
 configs/nanopi-neo4-rk3399_defconfig    | 18 ++++++--
 configs/nanopi-r4s-rk3399_defconfig     | 12 +++---
 12 files changed, 91 insertions(+), 81 deletions(-)

diff --git a/arch/arm/dts/rk3399-nanopc-t4.dts b/arch/arm/dts/rk3399-nanopc-t4.dts
index 452728b82e42..3bf8f959e42c 100644
--- a/arch/arm/dts/rk3399-nanopc-t4.dts
+++ b/arch/arm/dts/rk3399-nanopc-t4.dts
@@ -39,7 +39,7 @@
 		keyup-threshold-microvolt = <1800000>;
 		poll-interval = <100>;
 
-		recovery {
+		button-recovery {
 			label = "Recovery";
 			linux,code = <KEY_VENDOR>;
 			press-threshold-microvolt = <18000>;
diff --git a/arch/arm/dts/rk3399-nanopi-m4-2gb.dts b/arch/arm/dts/rk3399-nanopi-m4-2gb.dts
index 60358ab8c7df..e9cf71f224a3 100644
--- a/arch/arm/dts/rk3399-nanopi-m4-2gb.dts
+++ b/arch/arm/dts/rk3399-nanopi-m4-2gb.dts
@@ -10,57 +10,4 @@
  */
 
 /dts-v1/;
-#include "rk3399-nanopi4.dtsi"
-
-/ {
-	model = "FriendlyElec NanoPi M4";
-	compatible = "friendlyarm,nanopi-m4", "rockchip,rk3399";
-
-	vdd_5v: vdd-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_5v";
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc5v0_core: vcc5v0-core {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_core";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vdd_5v>;
-	};
-
-	vcc5v0_usb1: vcc5v0-usb1 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb1";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc5v0_usb2: vcc5v0-usb2 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb2";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc5v0_sys>;
-	};
-};
-
-&vcc3v3_sys {
-	vin-supply = <&vcc5v0_core>;
-};
-
-&u2phy0_host {
-	phy-supply = <&vcc5v0_usb1>;
-};
-
-&u2phy1_host {
-	phy-supply = <&vcc5v0_usb2>;
-};
-
-&vbus_typec {
-	regulator-always-on;
-	vin-supply = <&vdd_5v>;
-};
+#include "rk3399-nanopi-m4.dts"
diff --git a/arch/arm/dts/rk3399-nanopi-m4b.dts b/arch/arm/dts/rk3399-nanopi-m4b.dts
index 72182c58cc46..65cb21837b0c 100644
--- a/arch/arm/dts/rk3399-nanopi-m4b.dts
+++ b/arch/arm/dts/rk3399-nanopi-m4b.dts
@@ -19,7 +19,7 @@
 		keyup-threshold-microvolt = <1500000>;
 		poll-interval = <100>;
 
-		recovery {
+		button-recovery {
 			label = "Recovery";
 			linux,code = <KEY_VENDOR>;
 			press-threshold-microvolt = <18000>;
diff --git a/arch/arm/dts/rk3399-nanopi-r4s.dts b/arch/arm/dts/rk3399-nanopi-r4s.dts
index cef4d18b599d..fe5b52610010 100644
--- a/arch/arm/dts/rk3399-nanopi-r4s.dts
+++ b/arch/arm/dts/rk3399-nanopi-r4s.dts
@@ -46,9 +46,9 @@
 	gpio-keys {
 		pinctrl-0 = <&reset_button_pin>;
 
-		/delete-node/ power;
+		/delete-node/ key-power;
 
-		reset {
+		key-reset {
 			debounce-interval = <50>;
 			gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
 			label = "reset";
diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
index e0d7a518dfc2..757361249968 100644
--- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
@@ -20,3 +20,7 @@
 &vcc3v0_sd {
 	bootph-pre-ram;
 };
+
+&vcc_sdio {
+	regulator-init-microvolt = <3000000>;
+};
diff --git a/arch/arm/dts/rk3399-nanopi4.dtsi b/arch/arm/dts/rk3399-nanopi4.dtsi
index 8c0ff6c96e03..b7f1e47978a6 100644
--- a/arch/arm/dts/rk3399-nanopi4.dtsi
+++ b/arch/arm/dts/rk3399-nanopi4.dtsi
@@ -18,6 +18,7 @@
 
 / {
 	aliases {
+		ethernet0 = &gmac;
 		mmc0 = &sdio0;
 		mmc1 = &sdmmc;
 		mmc2 = &sdhci;
@@ -111,7 +112,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&power_key>;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Key Power";
@@ -167,6 +168,7 @@
 };
 
 &emmc_phy {
+	rockchip,enable-strobe-pulldown;
 	status = "okay";
 };
 
@@ -267,7 +269,7 @@
 		interrupt-parent = <&gpio1>;
 		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int_l>;
+		pinctrl-0 = <&pmic_int_l>, <&ap_pwroff>, <&clk_32k>;
 		rockchip,system-power-controller;
 		wakeup-source;
 
@@ -374,7 +376,6 @@
 			vcc_sdio: LDO_REG4 {
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-init-microvolt = <3000000>;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc_sdio";
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index 89c36e273a9b..93d163b70f4f 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -14,9 +14,10 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopc-t4.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -32,20 +33,28 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
@@ -68,5 +77,4 @@ CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index eb1d2c1f51fc..10bd9fba5388 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -6,15 +6,18 @@ CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4-2gb"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-m4-2gb.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -22,6 +25,7 @@ CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
@@ -29,19 +33,28 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
@@ -63,5 +76,4 @@ CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index bc0b90b3d861..f5305549716c 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -6,15 +6,18 @@ CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-m4.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -22,6 +25,7 @@ CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
@@ -29,19 +33,28 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
@@ -63,5 +76,4 @@ CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index 678f4d9d823f..70de7e0a6d7f 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -6,15 +6,18 @@ CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-m4b"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-m4b.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -22,6 +25,7 @@ CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
@@ -29,19 +33,28 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
@@ -63,5 +76,4 @@ CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index d9b7a90e8402..95c5766a41f8 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -6,15 +6,18 @@ CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-neo4"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-neo4.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -22,6 +25,7 @@ CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
@@ -29,19 +33,28 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
@@ -63,5 +76,4 @@ CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index 1fcccf2bae6e..488d86605f67 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -6,6 +6,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-r4s"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
@@ -14,7 +15,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-r4s.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -31,14 +32,16 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
@@ -66,5 +69,4 @@ CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

