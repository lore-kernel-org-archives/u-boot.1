Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE1ACD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA8C882F1;
	Sun, 31 Mar 2024 22:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jGFIlRvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C8A882F1; Sun, 31 Mar 2024 22:31:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A049882F1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917075; bh=9TahS6enAf5uqzJ9nAJz7PCR+20l8pB6vnbhNZDaCN0=;
 b=jGFIlRvn5QkxXjY7/aokAipuiG5EvEQmg7pHrmCqSDdCAQ5Cnc3OTU7k6xTt3iHP1n/UxDb3J
 VL2/2zMT+Esftf1mve7oMpJESW0PHaulbFQUd8XZf5UlnH+QqLrfP2ncYowhQtB7IuW6DyCDzjT
 RkasWxjuBn8Ei6+rbIajVJ+AlQWoFGc5daQfFdHkotjvy2c9vzz9ac3wpizrCuRhuxEBkwgJpNj
 Kg9VrPQjxGBTlOqIhkQvVkepN3Z/uW54eudS0Q/Up8SXGkuA7xEjR/qrvtGdva5e0xWDQ5dfx+u
 58VPsnwJLuXr1z+7MjoKaqQP3RagUSxER+G7MTbtd1yQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 23/31] rockchip: rk3399-orangepi: Sync device tree from linux
 v6.8
Date: Sun, 31 Mar 2024 20:28:29 +0000
Message-ID: <20240331202921.262323-24-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6609c8118fc6b45ed44f740b
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

Sync rk3399-orangepi device tree from linux v6.8.

Add DM_RESET=y to support reset signals.

Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.

Add ROCKCHIP_IODOMAIN=y to configure io-domain voltage.

Add MMC_SDHCI_SDMA=y to use DMA transfer for eMMC.

Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.

Add PHY_ROCKCHIP_INNO_USB2=y and PHY_ROCKCHIP_TYPEC=y to support USB PHY.

Remove SPL_TINY_MEMSET=y to use full memset in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-orangepi.dts  | 12 +++++++-----
 configs/orangepi-rk3399_defconfig | 10 ++++++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/rk3399-orangepi.dts b/arch/arm/dts/rk3399-orangepi.dts
index 04b54abea3cc..e7551449e718 100644
--- a/arch/arm/dts/rk3399-orangepi.dts
+++ b/arch/arm/dts/rk3399-orangepi.dts
@@ -7,6 +7,7 @@
 
 #include "dt-bindings/pwm/pwm.h"
 #include "dt-bindings/input/input.h"
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "dt-bindings/usb/pd.h"
 #include "rk3399.dtsi"
 #include "rk3399-opp.dtsi"
@@ -16,6 +17,7 @@
 	compatible = "rockchip,rk3399-orangepi", "rockchip,rk3399";
 
 	aliases {
+		ethernet0 = &gmac;
 		mmc0 = &sdio0;
 		mmc1 = &sdmmc;
 		mmc2 = &sdhci;
@@ -51,13 +53,13 @@
 			press-threshold-microvolt = <300000>;
 		};
 
-		back {
+		button-back {
 			label = "Back";
 			linux,code = <KEY_BACK>;
 			press-threshold-microvolt = <985000>;
 		};
 
-		menu {
+		button-menu {
 			label = "Menu";
 			linux,code = <KEY_MENU>;
 			press-threshold-microvolt = <1314000>;
@@ -77,7 +79,7 @@
 		compatible = "gpio-keys";
 		autorepeat;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
@@ -166,12 +168,12 @@
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
+		pwm-supply = <&vcc_sys>;
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
-		vin-supply = <&vcc_sys>;
 	};
 };
 
@@ -735,7 +737,7 @@
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wake";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_host_wake_l>;
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index 703732ad15f0..2d0c9b77e584 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -6,6 +6,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-orangepi"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
@@ -14,7 +15,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-orangepi.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -31,12 +32,18 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
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
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
@@ -58,5 +65,4 @@ CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

