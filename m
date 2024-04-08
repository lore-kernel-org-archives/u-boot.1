Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EF7C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C56688148;
	Mon,  8 Apr 2024 20:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CItmsdOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA298816D; Mon,  8 Apr 2024 20:15:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39DBE88118
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712600110; bh=jZtq4cWvceuIpvMlqDWoEEyZTB33MIWsk6SW1b3h2NA=;
 b=CItmsdOT8xrrIpZBboMIJNokq1pnZxbItMeERNXcUbD8ELfz3GExS+JmCI9M65DPcGXPCBr9c
 eyWaoVGZb5jk/24rbwkwWpRLzzTdlWGJ/9LfwzrQAb/DAgxdy0CCAxsDH7gDJeVYq+0VCW3Q1u4
 dFZ8kuo9e88omqt/SSrvnAOT9TselS2t5Gz0mcZ5xfkihIAGKsdxFuM19qcNyAjiikLBCqigb9q
 kSBSUmuG/MOcTeeHGEcvKS+4j5Ha2zf6sTyk6nWC/xUb0NU4ANGY4F2BGQ/fr4VC4sCMbxOsmKm
 fONh+k7q1jIBaZWAfJr/UpqFLkykGootPNKrHx5hYKMw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 10/14] rockchip: rk3308: Sync device tree from linux v6.8
Date: Mon,  8 Apr 2024 18:14:07 +0000
Message-ID: <20240408181429.3676856-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408181429.3676856-1-jonas@kwiboo.se>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6614342d45fff4c2aa5b4aae
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

Sync device tree from linux v6.8 and rename the rockchip,rk3308-mac
compatible in gmac_rockchip driver to match upstream linux.

Also move rk3308-roc-cc gmac node to u-boot.dtsi to not break features
not enabled in upstream device tree.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Sort bootph-all prop after compatible and reg props
---
 arch/arm/dts/rk3308-evb.dts               |  104 +-
 arch/arm/dts/rk3308-roc-cc-u-boot.dtsi    |   19 +
 arch/arm/dts/rk3308-roc-cc.dts            |   83 +-
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi |    4 +
 arch/arm/dts/rk3308-rock-pi-s.dts         |  100 +-
 arch/arm/dts/rk3308-u-boot.dtsi           |   14 +-
 arch/arm/dts/rk3308.dtsi                  | 1205 +++++++++++----------
 drivers/net/gmac_rockchip.c               |    2 +-
 8 files changed, 837 insertions(+), 694 deletions(-)

diff --git a/arch/arm/dts/rk3308-evb.dts b/arch/arm/dts/rk3308-evb.dts
index 124a24086684..184b84fdde07 100644
--- a/arch/arm/dts/rk3308-evb.dts
+++ b/arch/arm/dts/rk3308-evb.dts
@@ -23,7 +23,7 @@
 		poll-interval = <100>;
 		keyup-threshold-microvolt = <1800000>;
 
-		func-key {
+		button-func {
 			linux,code = <KEY_FN>;
 			label = "function";
 			press-threshold-microvolt = <18000>;
@@ -37,31 +37,31 @@
 		poll-interval = <100>;
 		keyup-threshold-microvolt = <1800000>;
 
-		esc-key {
+		button-esc {
 			linux,code = <KEY_MICMUTE>;
 			label = "micmute";
 			press-threshold-microvolt = <1130000>;
 		};
 
-		home-key {
+		button-home {
 			linux,code = <KEY_MODE>;
 			label = "mode";
 			press-threshold-microvolt = <901000>;
 		};
 
-		menu-key {
+		button-menu {
 			linux,code = <KEY_PLAY>;
 			label = "play";
 			press-threshold-microvolt = <624000>;
 		};
 
-		vol-down-key {
+		button-down {
 			linux,code = <KEY_VOLUMEDOWN>;
 			label = "volume down";
 			press-threshold-microvolt = <300000>;
 		};
 
-		vol-up-key {
+		button-up {
 			linux,code = <KEY_VOLUMEUP>;
 			label = "volume up";
 			press-threshold-microvolt = <18000>;
@@ -75,115 +75,115 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
-			wakeup-source;
 			debounce-interval = <100>;
+			wakeup-source;
 		};
 	};
 
 	vcc12v_dcin: vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
-		regulator-always-on;
-		regulator-boot-on;
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
 	};
 
 	vcc5v0_sys: vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc12v_dcin>;
-	};
-
-	vdd_core: vdd-core {
-		compatible = "pwm-regulator";
-		pwms = <&pwm0 0 5000 1>;
-		regulator-name = "vdd_core";
-		regulator-min-microvolt = <827000>;
-		regulator-max-microvolt = <1340000>;
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-settling-time-up-us = <250>;
-		pwm-supply = <&vcc5v0_sys>;
-	};
-
-	vdd_log: vdd-log {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_log";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1050000>;
-		regulator-max-microvolt = <1050000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vdd_1v0: vdd-1v0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_1v0";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1000000>;
-		regulator-max-microvolt = <1000000>;
-		vin-supply = <&vcc5v0_sys>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vccio_sdio: vcc_1v8: vcc-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v8";
-		regulator-always-on;
-		regulator-boot-on;
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc_io>;
 	};
 
 	vcc_ddr: vcc-ddr {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_ddr";
-		regulator-always-on;
-		regulator-boot-on;
 		regulator-min-microvolt = <1500000>;
 		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
 	vcc_io: vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
-		regulator-always-on;
-		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
 	vccio_flash: vccio-flash {
 		compatible = "regulator-fixed";
 		regulator-name = "vccio_flash";
-		regulator-always-on;
-		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc_io>;
 	};
 
 	vcc5v0_host: vcc5v0-host {
 		compatible = "regulator-fixed";
-		enable-active-high;
 		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb_drv>;
 		regulator-name = "vbus_host";
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	vdd_core: vdd-core {
+		compatible = "pwm-regulator";
+		pwms = <&pwm0 0 5000 1>;
+		regulator-name = "vdd_core";
+		regulator-min-microvolt = <827000>;
+		regulator-max-microvolt = <1340000>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-settling-time-up-us = <250>;
+		pwm-supply = <&vcc5v0_sys>;
+	};
+
+	vdd_log: vdd-log {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_log";
+		regulator-min-microvolt = <1050000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vdd_1v0: vdd-1v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_1v0";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
 };
 
 &cpu0 {
diff --git a/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi
index d823ac00c771..3e01e7af6113 100644
--- a/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi
@@ -4,6 +4,21 @@
  */
 #include "rk3308-u-boot.dtsi"
 
+/ {
+	aliases {
+		ethernet0 = &gmac;
+	};
+};
+
+&gmac {
+	assigned-clocks = <&cru SCLK_MAC>;
+	assigned-clock-parents = <&mac_clkin>;
+	clock_in_out = "input";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rmiim1_pins &macm1_refclk>;
+	status = "okay";
+};
+
 &gpio4 {
 	bootph-pre-ram;
 };
@@ -20,3 +35,7 @@
 &vcc_sd {
 	bootph-pre-ram;
 };
+
+&vdd_core {
+	regulator-init-microvolt = <1015000>;
+};
diff --git a/arch/arm/dts/rk3308-roc-cc.dts b/arch/arm/dts/rk3308-roc-cc.dts
index b4a54a852ce2..9232357f4fec 100644
--- a/arch/arm/dts/rk3308-roc-cc.dts
+++ b/arch/arm/dts/rk3308-roc-cc.dts
@@ -9,11 +9,17 @@
 / {
 	model = "Firefly ROC-RK3308-CC board";
 	compatible = "firefly,roc-rk3308-cc", "rockchip,rk3308";
+
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
-	ir_rx {
+	ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 RK_PC0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -27,14 +33,15 @@
 
 	leds {
 		compatible = "gpio-leds";
-		power {
+
+		power_led: led-0 {
 			label = "firefly:red:power";
 			linux,default-trigger = "ir-power-click";
 			default-state = "on";
 			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
 		};
 
-		user {
+		user_led: led-1 {
 			label = "firefly:blue:user";
 			linux,default-trigger = "ir-user-click";
 			default-state = "off";
@@ -45,10 +52,10 @@
 	typec_vcc5v: typec-vcc5v {
 		compatible = "regulator-fixed";
 		regulator-name = "typec_vcc5v";
-		regulator-always-on;
-		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
 	};
 
 	vcc5v0_sys: vcc5v0-sys {
@@ -61,29 +68,6 @@
 		vin-supply = <&typec_vcc5v>;
 	};
 
-	vdd_core: vdd-core {
-		compatible = "pwm-regulator";
-		pwms = <&pwm0 0 5000 1>;
-		regulator-name = "vdd_core";
-		regulator-min-microvolt = <827000>;
-		regulator-max-microvolt = <1340000>;
-		regulator-init-microvolt = <1015000>;
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-settling-time-up-us = <250>;
-		pwm-supply = <&vcc5v0_sys>;
-	};
-
-	vdd_log: vdd-log {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_log";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1050000>;
-		regulator-max-microvolt = <1050000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
 	vcc_io: vcc-io {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_io";
@@ -100,8 +84,8 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 		gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_HIGH>;
-		states = <1800000 0x0
-			  3300000 0x1>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
@@ -113,9 +97,30 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vim-supply = <&vcc_io>;
+		vin-supply = <&vcc_io>;
+	};
+
+	vdd_core: vdd-core {
+		compatible = "pwm-regulator";
+		pwms = <&pwm0 0 5000 1>;
+		regulator-name = "vdd_core";
+		regulator-min-microvolt = <827000>;
+		regulator-max-microvolt = <1340000>;
+		regulator-settling-time-up-us = <250>;
+		regulator-always-on;
+		regulator-boot-on;
+		pwm-supply = <&vcc5v0_sys>;
 	};
 
+	vdd_log: vdd-log {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_log";
+		regulator-min-microvolt = <1050000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
 };
 
 &cpu0 {
@@ -123,12 +128,9 @@
 };
 
 &emmc {
-	bus-width = <8>;
 	cap-mmc-highspeed;
-	supports-emmc;
-	disable-wp;
+	mmc-hs200-1_8v;
 	non-removable;
-	num-slots = <1>;
 	status = "okay";
 };
 
@@ -143,15 +145,6 @@
 	};
 };
 
-&mac {
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&mac_clkin>;
-	clock_in_out = "input";
-	pinctrl-names = "default";
-	pinctrl-0 = <&rmiim1_pins &macm1_refclk>;
-	status = "okay";
-};
-
 &pwm5 {
 	status = "okay";
 	pinctrl-names = "active";
@@ -181,10 +174,8 @@
 };
 
 &sdmmc {
-	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-	supports-sd;
 	card-detect-delay = <300>;
 	sd-uhs-sdr25;
 	sd-uhs-sdr50;
diff --git a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
index e458fb3142ee..8d34ed1b3a36 100644
--- a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
@@ -31,3 +31,7 @@
 &uart0_xfer {
 	bootph-all;
 };
+
+&vdd_core {
+	regulator-init-microvolt = <1015000>;
+};
diff --git a/arch/arm/dts/rk3308-rock-pi-s.dts b/arch/arm/dts/rk3308-rock-pi-s.dts
index b5a8691b3fe9..b47fe02c33fb 100644
--- a/arch/arm/dts/rk3308-rock-pi-s.dts
+++ b/arch/arm/dts/rk3308-rock-pi-s.dts
@@ -1,12 +1,10 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
- * Copyright (C) 2023 Akash Gajjar <gajjar04akash@gmail.com>
- * Copyright (c) 2023 Jagan Teki <jagan@openedev.com>
+ * Copyright (c) 2019 Akash Gajjar <akash@openedev.com>
+ * Copyright (c) 2019 Jagan Teki <jagan@openedev.com>
  */
 
 /dts-v1/;
-#include <dt-bindings/input/input.h>
 #include "rk3308.dtsi"
 
 / {
@@ -14,7 +12,7 @@
 	compatible = "radxa,rockpis", "rockchip,rk3308";
 
 	aliases {
-		ethernet0 = &mac;
+		ethernet0 = &gmac;
 		mmc0 = &emmc;
 		mmc1 = &sdmmc;
 	};
@@ -107,7 +105,6 @@
 		regulator-name = "vdd_core";
 		regulator-min-microvolt = <827000>;
 		regulator-max-microvolt = <1340000>;
-		regulator-init-microvolt = <1015000>;
 		regulator-settling-time-up-us = <250>;
 		regulator-always-on;
 		regulator-boot-on;
@@ -137,7 +134,7 @@
 	status = "okay";
 };
 
-&mac {
+&gmac {
 	clock_in_out = "output";
 	phy-supply = <&vcc_io>;
 	snps,reset-gpio = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
@@ -146,6 +143,68 @@
 	status = "okay";
 };
 
+&gpio0 {
+	gpio-line-names =
+		/* GPIO0_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_B0 - B7 */
+		"", "", "", "header1-pin3 [GPIO0_B3]",
+		"header1-pin5 [GPIO0_B4]", "", "",
+		"header1-pin11 [GPIO0_B7]",
+		/* GPIO0_C0 - C7 */
+		"header1-pin13 [GPIO0_C0]",
+		"header1-pin15 [GPIO0_C1]", "", "", "",
+		"", "", "",
+		/* GPIO0_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+		/* GPIO1_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_C0 - C7 */
+		"", "", "", "", "", "", "header1-pin21 [GPIO1_C6]",
+		"header1-pin19 [GPIO1_C7]",
+		/* GPIO1_D0 - D7 */
+		"header1-pin23 [GPIO1_D0]", "header1-pin24 [GPIO1_D1]",
+		"", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		/* GPIO2_A0 - A7 */
+		"header1-pin10 [GPIO2_A0]", "header1-pin8 [GPIO2_A1]",
+		"", "",
+		"header1-pin7 [GPIO2_A4]", "header1-pin12 [GPIO2_A5]",
+		"header2-pin46 [GPIO2_A6]", "header1-pin22 [GPIO1_A7]",
+		/* GPIO2_B0 - B7 */
+		"header2-pin45 [GPIO2_B0]", "header1-pin18 [GPIO2_B1]",
+		"header1-pin16 [GPIO2_B2]", "header2-pin44 [GPIO2_B3]",
+		"header2-pin43 [GPIO2_B4]", "header2-pin28 [GPIO2_B5]",
+		"header2-pin30 [GPIO2_B6]", "header2-pin32 [GPIO2_B7]",
+		/* GPIO2_C0 - C7 */
+		"header2-pin34 [GPIO2_C0]", "", "", "", "", "", "", "",
+		/* GPIO2_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		/* GPIO3_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO3_B0 - B7 */
+		"", "", "header2-pin42 [GPIO3_B2]",
+		"header2-pin41 [GPIO3_B3]", "header2-pin40 [GPIO3_B4]",
+		"header2-pin39 [GPIO3_B5]", "", "",
+		/* GPIO3_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO3_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -209,6 +268,20 @@
 	status = "okay";
 };
 
+&u2phy {
+	status = "okay";
+
+	u2phy_host: host-port {
+		phy-supply = <&vcc5v0_otg>;
+		status = "okay";
+	};
+
+	u2phy_otg: otg-port {
+		phy-supply = <&vcc5v0_otg>;
+		status = "okay";
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
@@ -223,6 +296,19 @@
 	};
 };
 
+&usb_host_ehci {
+	status = "okay";
+};
+
+&usb_host_ohci {
+	status = "okay";
+};
+
+&usb20_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index 26e1a94f2e1a..684fa7abddb1 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -15,6 +15,12 @@
 		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
 	};
 
+	dmc: dmc@ff010000 {
+		compatible = "rockchip,rk3308-dmc";
+		reg = <0x0 0xff010000 0x0 0x10000>;
+		bootph-all;
+	};
+
 	otp: nvmem@ff210000 {
 		compatible = "rockchip,rk3308-otp";
 		reg = <0x0 0xff210000 0x0 0x4000>;
@@ -41,10 +47,6 @@
 	bootph-all;
 };
 
-&dmc {
-	bootph-all;
-};
-
 &emmc {
 	bootph-pre-ram;
 	bootph-some-ram;
@@ -135,3 +137,7 @@
 	bootph-pre-ram;
 	bootph-some-ram;
 };
+
+&xin24m {
+	bootph-all;
+};
diff --git a/arch/arm/dts/rk3308.dtsi b/arch/arm/dts/rk3308.dtsi
index 9a152a8a9072..cfc0a87b5195 100644
--- a/arch/arm/dts/rk3308.dtsi
+++ b/arch/arm/dts/rk3308.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
  *
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -19,6 +20,11 @@
 	#size-cells = <2>;
 
 	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
@@ -39,7 +45,7 @@
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35", "arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLK>;
@@ -52,7 +58,7 @@
 
 		cpu1: cpu@1 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35", "arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -62,7 +68,7 @@
 
 		cpu2: cpu@2 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35", "arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -72,7 +78,7 @@
 
 		cpu3: cpu@3 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35", "arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -95,10 +101,12 @@
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-	cpu0_opp_table: cpu0-opp-table {
+	cpu0_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -126,7 +134,7 @@
 	};
 
 	arm-pmu {
-		compatible = "arm,cortex-a53-pmu";
+		compatible = "arm,cortex-a35-pmu";
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
@@ -163,12 +171,53 @@
 
 	grf: grf@ff000000 {
 		compatible = "rockchip,rk3308-grf", "syscon", "simple-mfd";
-		reg = <0x0 0xff000000 0x0 0x10000>;
+		reg = <0x0 0xff000000 0x0 0x08000>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x500>;
+			mode-bootloader = <BOOT_BL_DOWNLOAD>;
+			mode-loader = <BOOT_BL_DOWNLOAD>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-fastboot = <BOOT_FASTBOOT>;
+		};
 	};
 
-	dmc: dmc@0xff010000 {
-		compatible = "rockchip,rk3308-dmc";
-		reg = <0x0 0xff010000 0x0 0x10000>;
+	usb2phy_grf: syscon@ff008000 {
+		compatible = "rockchip,rk3308-usb2phy-grf", "syscon", "simple-mfd";
+		reg = <0x0 0xff008000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		u2phy: usb2phy@100 {
+			compatible = "rockchip,rk3308-usb2phy";
+			reg = <0x100 0x10>;
+			assigned-clocks = <&cru USB480M>;
+			assigned-clock-parents = <&u2phy>;
+			clocks = <&cru SCLK_USBPHY_REF>;
+			clock-names = "phyclk";
+			clock-output-names = "usb480m_phy";
+			#clock-cells = <0>;
+			status = "disabled";
+
+			u2phy_otg: otg-port {
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "otg-bvalid", "otg-id",
+						  "linestate";
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
+			u2phy_host: host-port {
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "linestate";
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+		};
 	};
 
 	detect_grf: syscon@ff00b000 {
@@ -183,7 +232,6 @@
 		reg = <0x0 0xff00c000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-
 	};
 
 	i2c0: i2c@ff040000 {
@@ -239,7 +287,7 @@
 	};
 
 	wdt: watchdog@ff080000 {
-		compatible = "snps,dw-wdt";
+		compatible = "rockchip,rk3308-wdt", "snps,dw-wdt";
 		reg = <0x0 0xff080000 0x0 0x100>;
 		clocks = <&cru PCLK_WDT>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
@@ -321,9 +369,8 @@
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&dmac0 0>, <&dmac0 1>;
 		dma-names = "tx", "rx";
-		pinctrl-names = "default", "high_speed";
+		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_clk &spi0_csn0 &spi0_miso &spi0_mosi>;
-		pinctrl-1 = <&spi0_clk_hs &spi0_csn0 &spi0_miso_hs &spi0_mosi_hs>;
 		status = "disabled";
 	};
 
@@ -337,9 +384,8 @@
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&dmac0 2>, <&dmac0 3>;
 		dma-names = "tx", "rx";
-		pinctrl-names = "default", "high_speed";
+		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_clk &spi1_csn0 &spi1_miso &spi1_mosi>;
-		pinctrl-1 = <&spi1_clk_hs &spi1_csn0 &spi1_miso_hs &spi1_mosi_hs>;
 		status = "disabled";
 	};
 
@@ -353,141 +399,140 @@
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&dmac1 16>, <&dmac1 17>;
 		dma-names = "tx", "rx";
-		pinctrl-names = "default", "high_speed";
+		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_clk &spi2_csn0 &spi2_miso &spi2_mosi>;
-		pinctrl-1 = <&spi2_clk_hs &spi2_csn0 &spi2_miso_hs &spi2_mosi_hs>;
 		status = "disabled";
 	};
 
 	pwm8: pwm@ff160000 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff160000 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm8_pin>;
 		clocks = <&cru SCLK_PWM2>, <&cru PCLK_PWM2>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm8_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm9: pwm@ff160010 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff160010 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm9_pin>;
 		clocks = <&cru SCLK_PWM2>, <&cru PCLK_PWM2>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm9_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm10: pwm@ff160020 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff160020 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm10_pin>;
 		clocks = <&cru SCLK_PWM2>, <&cru PCLK_PWM2>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm10_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm11: pwm@ff160030 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff160030 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm11_pin>;
 		clocks = <&cru SCLK_PWM2>, <&cru PCLK_PWM2>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm11_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm4: pwm@ff170000 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff170000 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm4_pin>;
 		clocks = <&cru SCLK_PWM1>, <&cru PCLK_PWM1>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm4_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm5: pwm@ff170010 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff170010 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm5_pin>;
 		clocks = <&cru SCLK_PWM1>, <&cru PCLK_PWM1>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm5_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm6: pwm@ff170020 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff170020 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm6_pin>;
 		clocks = <&cru SCLK_PWM1>, <&cru PCLK_PWM1>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm6_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm7: pwm@ff170030 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff170030 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm7_pin>;
 		clocks = <&cru SCLK_PWM1>, <&cru PCLK_PWM1>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm7_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm0: pwm@ff180000 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff180000 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm0_pin>;
 		clocks = <&cru SCLK_PWM0>, <&cru PCLK_PWM0>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm1: pwm@ff180010 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff180010 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm1_pin>;
 		clocks = <&cru SCLK_PWM0>, <&cru PCLK_PWM0>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm1_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm2: pwm@ff180020 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff180020 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm2_pin>;
 		clocks = <&cru SCLK_PWM0>, <&cru PCLK_PWM0>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm2_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
 	pwm3: pwm@ff180030 {
 		compatible = "rockchip,rk3308-pwm", "rockchip,rk3328-pwm";
 		reg = <0x0 0xff180030 0x0 0x10>;
-		#pwm-cells = <3>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm3_pin>;
 		clocks = <&cru SCLK_PWM0>, <&cru PCLK_PWM0>;
 		clock-names = "pwm", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm3_pin>;
+		#pwm-cells = <3>;
 		status = "disabled";
 	};
 
@@ -503,41 +548,34 @@
 		compatible = "rockchip,rk3308-saradc", "rockchip,rk3399-saradc";
 		reg = <0x0 0xff1e0000 0x0 0x100>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-		#io-channel-cells = <1>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
 		clock-names = "saradc", "apb_pclk";
+		#io-channel-cells = <1>;
 		resets = <&cru SRST_SARADC_P>;
 		reset-names = "saradc-apb";
 		status = "disabled";
 	};
 
-	amba {
-		compatible = "arm,amba-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
+	dmac0: dma-controller@ff2c0000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x0 0xff2c0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+		arm,pl330-periph-burst;
+		clocks = <&cru ACLK_DMAC0>;
+		clock-names = "apb_pclk";
+		#dma-cells = <1>;
+	};
 
-		dmac0: dma-controller@ff2c0000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x0 0xff2c0000 0x0 0x4000>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
-			#dma-cells = <1>;
-			clocks = <&cru ACLK_DMAC0>;
-			clock-names = "apb_pclk";
-			peripherals-req-type-burst;
-		};
-
-		dmac1: dma-controller@ff2d0000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x0 0xff2d0000 0x0 0x4000>;
-			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			#dma-cells = <1>;
-			clocks = <&cru ACLK_DMAC1>;
-			clock-names = "apb_pclk";
-			peripherals-req-type-burst;
-		};
+	dmac1: dma-controller@ff2d0000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x0 0xff2d0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+		arm,pl330-periph-burst;
+		clocks = <&cru ACLK_DMAC1>;
+		clock-names = "apb_pclk";
+		#dma-cells = <1>;
 	};
 
 	i2s_2ch_0: i2s@ff350000 {
@@ -572,7 +610,7 @@
 	};
 
 	spdif_tx: spdif-tx@ff3a0000 {
-		compatible = "rockchip,rk3308-spdif", "rockchip,rk3328-spdif";
+		compatible = "rockchip,rk3308-spdif", "rockchip,rk3066-spdif";
 		reg = <0x0 0xff3a0000 0x0 0x1000>;
 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_SPDIF_TX>, <&cru HCLK_SPDIFTX>;
@@ -584,16 +622,52 @@
 		status = "disabled";
 	};
 
+	usb20_otg: usb@ff400000 {
+		compatible = "rockchip,rk3308-usb", "rockchip,rk3066-usb",
+			     "snps,dwc2";
+		reg = <0x0 0xff400000 0x0 0x40000>;
+		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_OTG>;
+		clock-names = "otg";
+		dr_mode = "otg";
+		g-np-tx-fifo-size = <16>;
+		g-rx-fifo-size = <280>;
+		g-tx-fifo-size = <256 128 128 64 32 16>;
+		phys = <&u2phy_otg>;
+		phy-names = "usb2-phy";
+		status = "disabled";
+	};
+
+	usb_host_ehci: usb@ff440000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xff440000 0x0 0x10000>;
+		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host_ohci: usb@ff450000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xff450000 0x0 0x10000>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST>, <&cru HCLK_HOST_ARB>, <&u2phy>;
+		phys = <&u2phy_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	sdmmc: mmc@ff480000 {
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff480000 0x0 0x4000>;
-		max-frequency = <150000000>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		bus-width = <4>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+		max-frequency = <150000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_det &sdmmc_bus4>;
 		status = "disabled";
@@ -602,35 +676,49 @@
 	emmc: mmc@ff490000 {
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff490000 0x0 0x4000>;
-		max-frequency = <150000000>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		bus-width = <8>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+		max-frequency = <150000000>;
 		status = "disabled";
 	};
 
 	sdio: mmc@ff4a0000 {
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff4a0000 0x0 0x4000>;
-		max-frequency = <150000000>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		bus-width = <4>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu-drv", "ciu-sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
-		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		max-frequency = <150000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdio_bus4 &sdio_cmd &sdio_clk>;
 		status = "disabled";
 	};
 
-	mac: ethernet@ff4e0000 {
-		compatible = "rockchip,rk3308-mac";
+	nfc: nand-controller@ff4b0000 {
+		compatible = "rockchip,rk3308-nfc",
+			     "rockchip,rv1108-nfc";
+		reg = <0x0 0xff4b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
+		clock-names = "ahb", "nfc";
+		assigned-clocks = <&cru SCLK_NANDC>;
+		assigned-clock-rates = <150000000>;
+		pinctrl-0 = <&flash_ale &flash_bus8 &flash_cle &flash_csn0
+			     &flash_rdn &flash_rdy &flash_wrn>;
+		pinctrl-names = "default";
+		status = "disabled";
+	};
+
+	gmac: ethernet@ff4e0000 {
+		compatible = "rockchip,rk3308-gmac";
 		reg = <0x0 0xff4e0000 0x0 0x10000>;
-		rockchip,grf = <&grf>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "macirq";
 		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX_TX>,
@@ -646,40 +734,57 @@
 		pinctrl-0 = <&rmii_pins &mac_refclk_12ma>;
 		resets = <&cru SRST_MAC_A>;
 		reset-names = "stmmaceth";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
+	sfc: spi@ff4c0000 {
+		compatible = "rockchip,sfc";
+		reg = <0x0 0xff4c0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus4>;
+		pinctrl-names = "default";
 		status = "disabled";
 	};
 
 	cru: clock-controller@ff500000 {
 		compatible = "rockchip,rk3308-cru";
 		reg = <0x0 0xff500000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		assigned-clocks = <&cru SCLK_RTC32K>;
+		assigned-clock-rates = <32768>;
 	};
 
 	gic: interrupt-controller@ff580000 {
 		compatible = "arm,gic-400";
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		interrupt-controller;
-
 		reg = <0x0 0xff581000 0x0 0x1000>,
 		      <0x0 0xff582000 0x0 0x2000>,
 		      <0x0 0xff584000 0x0 0x2000>,
 		      <0x0 0xff586000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		#address-cells = <0>;
 	};
 
 	sram: sram@fff80000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0xfff80000 0x0 0x40000>;
+		ranges = <0 0x0 0xfff80000 0x40000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0 0x0 0xfff80000 0x40000>;
+
 		/* reserved for ddr dvfs and system suspend/resume */
 		ddr-sram@0 {
 			reg = <0x0 0x8000>;
 		};
+
 		/* reserved for vad audio buffer */
 		vad_sram: vad-sram@8000 {
 			reg = <0x8000 0x38000>;
@@ -692,62 +797,58 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		gpio0: gpio0@ff220000 {
+
+		gpio0: gpio@ff220000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff220000 0x0 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
 			gpio-controller;
 			#gpio-cells = <2>;
-
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 
-		gpio1: gpio1@ff230000 {
+		gpio1: gpio@ff230000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff230000 0x0 0x100>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
 			gpio-controller;
 			#gpio-cells = <2>;
-
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 
-		gpio2: gpio2@ff240000 {
+		gpio2: gpio@ff240000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff240000 0x0 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
 			gpio-controller;
 			#gpio-cells = <2>;
-
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 
-		gpio3: gpio3@ff250000 {
+		gpio3: gpio@ff250000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff250000 0x0 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
 			gpio-controller;
 			#gpio-cells = <2>;
-
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 
-		gpio4: gpio4@ff260000 {
+		gpio4: gpio@ff260000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff260000 0x0 0x100>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
 			gpio-controller;
 			#gpio-cells = <2>;
-
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
@@ -831,127 +932,312 @@
 			input-enable;
 		};
 
-		i2c0 {
-			i2c0_xfer: i2c0-xfer {
-				rockchip,pins =
-					<1 RK_PD0 2 &pcfg_pull_none_smt>,
-					<1 RK_PD1 2 &pcfg_pull_none_smt>;
-			};
-		};
-
-		i2c1 {
-			i2c1_xfer: i2c1-xfer {
+		emmc {
+			emmc_clk: emmc-clk {
 				rockchip,pins =
-					<0 RK_PB3 1 &pcfg_pull_none_smt>,
-					<0 RK_PB4 1 &pcfg_pull_none_smt>;
+					<3 RK_PB1 2 &pcfg_pull_none_8ma>;
 			};
-		};
 
-		i2c2 {
-			i2c2_xfer: i2c2-xfer {
+			emmc_cmd: emmc-cmd {
 				rockchip,pins =
-					<2 RK_PA2 3 &pcfg_pull_none_smt>,
-					<2 RK_PA3 3 &pcfg_pull_none_smt>;
+					<3 RK_PB0 2 &pcfg_pull_up_8ma>;
 			};
-		};
 
-		i2c3-m0 {
-			i2c3m0_xfer: i2c3m0-xfer {
+			emmc_pwren: emmc-pwren {
 				rockchip,pins =
-					<0 RK_PB7 2 &pcfg_pull_none_smt>,
-					<0 RK_PC0 2 &pcfg_pull_none_smt>;
+					<3 RK_PB3 2 &pcfg_pull_none>;
 			};
-		};
 
-		i2c3-m1 {
-			i2c3m1_xfer: i2c3m1-xfer {
+			emmc_rstn: emmc-rstn {
 				rockchip,pins =
-					<3 RK_PB4 2 &pcfg_pull_none_smt>,
-					<3 RK_PB5 2 &pcfg_pull_none_smt>;
+					<3 RK_PB2 2 &pcfg_pull_none>;
 			};
-		};
 
-		i2c3-m2 {
-			i2c3m2_xfer: i2c3m2-xfer {
+			emmc_bus1: emmc-bus1 {
 				rockchip,pins =
-					<2 RK_PA1 3 &pcfg_pull_none_smt>,
-					<2 RK_PA0 3 &pcfg_pull_none_smt>;
+					<3 RK_PA0 2 &pcfg_pull_up_8ma>;
 			};
-		};
 
-		i2s_2ch_0 {
-			i2s_2ch_0_mclk: i2s-2ch-0-mclk {
+			emmc_bus4: emmc-bus4 {
 				rockchip,pins =
-					<4 RK_PB4 1 &pcfg_pull_none>;
+					<3 RK_PA0 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA1 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA2 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA3 2 &pcfg_pull_up_8ma>;
 			};
 
-			i2s_2ch_0_sclk: i2s-2ch-0-sclk {
+			emmc_bus8: emmc-bus8 {
 				rockchip,pins =
-					<4 RK_PB5 1 &pcfg_pull_none>;
+					<3 RK_PA0 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA1 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA2 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA3 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA4 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA5 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA6 2 &pcfg_pull_up_8ma>,
+					<3 RK_PA7 2 &pcfg_pull_up_8ma>;
 			};
+		};
 
-			i2s_2ch_0_lrck: i2s-2ch-0-lrck {
+		flash {
+			flash_csn0: flash-csn0 {
 				rockchip,pins =
-					<4 RK_PB6 1 &pcfg_pull_none>;
+					<3 RK_PB5 1 &pcfg_pull_none>;
 			};
 
-			i2s_2ch_0_sdo: i2s-2ch-0-sdo {
+			flash_rdy: flash-rdy {
 				rockchip,pins =
-					<4 RK_PB7 1 &pcfg_pull_none>;
+					<3 RK_PB4 1 &pcfg_pull_none>;
 			};
 
-			i2s_2ch_0_sdi: i2s-2ch-0-sdi {
+			flash_ale: flash-ale {
 				rockchip,pins =
-					<4 RK_PC0 1 &pcfg_pull_none>;
+					<3 RK_PB3 1 &pcfg_pull_none>;
 			};
-		};
 
-		i2s_8ch_0 {
-			i2s_8ch_0_mclk: i2s-8ch-0-mclk {
+			flash_cle: flash-cle {
 				rockchip,pins =
-					<2 RK_PA4 1 &pcfg_pull_none>;
+					<3 RK_PB1 1 &pcfg_pull_none>;
 			};
 
-			i2s_8ch_0_sclktx: i2s-8ch-0-sclktx {
+			flash_wrn: flash-wrn {
 				rockchip,pins =
-					<2 RK_PA5 1 &pcfg_pull_none>;
+					<3 RK_PB0 1 &pcfg_pull_none>;
 			};
 
-			i2s_8ch_0_sclkrx: i2s-8ch-0-sclkrx {
+			flash_rdn: flash-rdn {
 				rockchip,pins =
-					<2 RK_PA6 1 &pcfg_pull_none>;
+					<3 RK_PB2 1 &pcfg_pull_none>;
 			};
 
-			i2s_8ch_0_lrcktx: i2s-8ch-0-lrcktx {
+			flash_bus8: flash-bus8 {
 				rockchip,pins =
-					<2 RK_PA7 1 &pcfg_pull_none>;
+					<3 RK_PA0 1 &pcfg_pull_up_12ma>,
+					<3 RK_PA1 1 &pcfg_pull_up_12ma>,
+					<3 RK_PA2 1 &pcfg_pull_up_12ma>,
+					<3 RK_PA3 1 &pcfg_pull_up_12ma>,
+					<3 RK_PA4 1 &pcfg_pull_up_12ma>,
+					<3 RK_PA5 1 &pcfg_pull_up_12ma>,
+					<3 RK_PA6 1 &pcfg_pull_up_12ma>,
+					<3 RK_PA7 1 &pcfg_pull_up_12ma>;
 			};
+		};
 
-			i2s_8ch_0_lrckrx: i2s-8ch-0-lrckrx {
+		sfc {
+			sfc_bus4: sfc-bus4 {
 				rockchip,pins =
-					<2 RK_PB0 1 &pcfg_pull_none>;
+					<3 RK_PA0 3 &pcfg_pull_none>,
+					<3 RK_PA1 3 &pcfg_pull_none>,
+					<3 RK_PA2 3 &pcfg_pull_none>,
+					<3 RK_PA3 3 &pcfg_pull_none>;
 			};
 
-			i2s_8ch_0_sdo0: i2s-8ch-0-sdo0 {
+			sfc_bus2: sfc-bus2 {
 				rockchip,pins =
-					<2 RK_PB1 1 &pcfg_pull_none>;
+					<3 RK_PA0 3 &pcfg_pull_none>,
+					<3 RK_PA1 3 &pcfg_pull_none>;
 			};
 
-			i2s_8ch_0_sdo1: i2s-8ch-0-sdo1 {
+			sfc_cs0: sfc-cs0 {
 				rockchip,pins =
-					<2 RK_PB2 1 &pcfg_pull_none>;
+					<3 RK_PA4 3 &pcfg_pull_none>;
 			};
 
-			i2s_8ch_0_sdo2: i2s-8ch-0-sdo2 {
+			sfc_clk: sfc-clk {
 				rockchip,pins =
-					<2 RK_PB3 1 &pcfg_pull_none>;
+					<3 RK_PA5 3 &pcfg_pull_none>;
 			};
+		};
 
-			i2s_8ch_0_sdo3: i2s-8ch-0-sdo3 {
+		gmac {
+			rmii_pins: rmii-pins {
 				rockchip,pins =
-					<2 RK_PB4 1 &pcfg_pull_none>;
-			};
-
+					/* mac_txen */
+					<1 RK_PC1 3 &pcfg_pull_none_12ma>,
+					/* mac_txd1 */
+					<1 RK_PC3 3 &pcfg_pull_none_12ma>,
+					/* mac_txd0 */
+					<1 RK_PC2 3 &pcfg_pull_none_12ma>,
+					/* mac_rxd0 */
+					<1 RK_PC4 3 &pcfg_pull_none>,
+					/* mac_rxd1 */
+					<1 RK_PC5 3 &pcfg_pull_none>,
+					/* mac_rxer */
+					<1 RK_PB7 3 &pcfg_pull_none>,
+					/* mac_rxdv */
+					<1 RK_PC0 3 &pcfg_pull_none>,
+					/* mac_mdio */
+					<1 RK_PB6 3 &pcfg_pull_none>,
+					/* mac_mdc */
+					<1 RK_PB5 3 &pcfg_pull_none>;
+			};
+
+			mac_refclk_12ma: mac-refclk-12ma {
+				rockchip,pins =
+					<1 RK_PB4 3 &pcfg_pull_none_12ma>;
+			};
+
+			mac_refclk: mac-refclk {
+				rockchip,pins =
+					<1 RK_PB4 3 &pcfg_pull_none>;
+			};
+		};
+
+		gmac-m1 {
+			rmiim1_pins: rmiim1-pins {
+				rockchip,pins =
+					/* mac_txen */
+					<4 RK_PB7 2 &pcfg_pull_none_12ma>,
+					/* mac_txd1 */
+					<4 RK_PA5 2 &pcfg_pull_none_12ma>,
+					/* mac_txd0 */
+					<4 RK_PA4 2 &pcfg_pull_none_12ma>,
+					/* mac_rxd0 */
+					<4 RK_PA2 2 &pcfg_pull_none>,
+					/* mac_rxd1 */
+					<4 RK_PA3 2 &pcfg_pull_none>,
+					/* mac_rxer */
+					<4 RK_PA0 2 &pcfg_pull_none>,
+					/* mac_rxdv */
+					<4 RK_PA1 2 &pcfg_pull_none>,
+					/* mac_mdio */
+					<4 RK_PB6 2 &pcfg_pull_none>,
+					/* mac_mdc */
+					<4 RK_PB5 2 &pcfg_pull_none>;
+			};
+
+			macm1_refclk_12ma: macm1-refclk-12ma {
+				rockchip,pins =
+					<4 RK_PB4 2 &pcfg_pull_none_12ma>;
+			};
+
+			macm1_refclk: macm1-refclk {
+				rockchip,pins =
+					<4 RK_PB4 2 &pcfg_pull_none>;
+			};
+		};
+
+		i2c0 {
+			i2c0_xfer: i2c0-xfer {
+				rockchip,pins =
+					<1 RK_PD0 2 &pcfg_pull_none_smt>,
+					<1 RK_PD1 2 &pcfg_pull_none_smt>;
+			};
+		};
+
+		i2c1 {
+			i2c1_xfer: i2c1-xfer {
+				rockchip,pins =
+					<0 RK_PB3 1 &pcfg_pull_none_smt>,
+					<0 RK_PB4 1 &pcfg_pull_none_smt>;
+			};
+		};
+
+		i2c2 {
+			i2c2_xfer: i2c2-xfer {
+				rockchip,pins =
+					<2 RK_PA2 3 &pcfg_pull_none_smt>,
+					<2 RK_PA3 3 &pcfg_pull_none_smt>;
+			};
+		};
+
+		i2c3-m0 {
+			i2c3m0_xfer: i2c3m0-xfer {
+				rockchip,pins =
+					<0 RK_PB7 2 &pcfg_pull_none_smt>,
+					<0 RK_PC0 2 &pcfg_pull_none_smt>;
+			};
+		};
+
+		i2c3-m1 {
+			i2c3m1_xfer: i2c3m1-xfer {
+				rockchip,pins =
+					<3 RK_PB4 2 &pcfg_pull_none_smt>,
+					<3 RK_PB5 2 &pcfg_pull_none_smt>;
+			};
+		};
+
+		i2c3-m2 {
+			i2c3m2_xfer: i2c3m2-xfer {
+				rockchip,pins =
+					<2 RK_PA1 3 &pcfg_pull_none_smt>,
+					<2 RK_PA0 3 &pcfg_pull_none_smt>;
+			};
+		};
+
+		i2s_2ch_0 {
+			i2s_2ch_0_mclk: i2s-2ch-0-mclk {
+				rockchip,pins =
+					<4 RK_PB4 1 &pcfg_pull_none>;
+			};
+
+			i2s_2ch_0_sclk: i2s-2ch-0-sclk {
+				rockchip,pins =
+					<4 RK_PB5 1 &pcfg_pull_none>;
+			};
+
+			i2s_2ch_0_lrck: i2s-2ch-0-lrck {
+				rockchip,pins =
+					<4 RK_PB6 1 &pcfg_pull_none>;
+			};
+
+			i2s_2ch_0_sdo: i2s-2ch-0-sdo {
+				rockchip,pins =
+					<4 RK_PB7 1 &pcfg_pull_none>;
+			};
+
+			i2s_2ch_0_sdi: i2s-2ch-0-sdi {
+				rockchip,pins =
+					<4 RK_PC0 1 &pcfg_pull_none>;
+			};
+		};
+
+		i2s_8ch_0 {
+			i2s_8ch_0_mclk: i2s-8ch-0-mclk {
+				rockchip,pins =
+					<2 RK_PA4 1 &pcfg_pull_none>;
+			};
+
+			i2s_8ch_0_sclktx: i2s-8ch-0-sclktx {
+				rockchip,pins =
+					<2 RK_PA5 1 &pcfg_pull_none>;
+			};
+
+			i2s_8ch_0_sclkrx: i2s-8ch-0-sclkrx {
+				rockchip,pins =
+					<2 RK_PA6 1 &pcfg_pull_none>;
+			};
+
+			i2s_8ch_0_lrcktx: i2s-8ch-0-lrcktx {
+				rockchip,pins =
+					<2 RK_PA7 1 &pcfg_pull_none>;
+			};
+
+			i2s_8ch_0_lrckrx: i2s-8ch-0-lrckrx {
+				rockchip,pins =
+					<2 RK_PB0 1 &pcfg_pull_none>;
+			};
+
+			i2s_8ch_0_sdo0: i2s-8ch-0-sdo0 {
+				rockchip,pins =
+					<2 RK_PB1 1 &pcfg_pull_none>;
+			};
+
+			i2s_8ch_0_sdo1: i2s-8ch-0-sdo1 {
+				rockchip,pins =
+					<2 RK_PB2 1 &pcfg_pull_none>;
+			};
+
+			i2s_8ch_0_sdo2: i2s-8ch-0-sdo2 {
+				rockchip,pins =
+					<2 RK_PB3 1 &pcfg_pull_none>;
+			};
+
+			i2s_8ch_0_sdo3: i2s-8ch-0-sdo3 {
+				rockchip,pins =
+					<2 RK_PB4 1 &pcfg_pull_none>;
+			};
+
 			i2s_8ch_0_sdi0: i2s-8ch-0-sdi0 {
 				rockchip,pins =
 					<2 RK_PB5 1 &pcfg_pull_none>;
@@ -1163,281 +1449,154 @@
 			};
 		};
 
-		spdif_in {
-			spdif_in: spdif-in {
+		pwm0 {
+			pwm0_pin: pwm0-pin {
 				rockchip,pins =
-					<0 RK_PC2 1 &pcfg_pull_none>;
+					<0 RK_PB5 1 &pcfg_pull_none>;
 			};
-		};
 
-		spdif_out {
-			spdif_out: spdif-out {
+			pwm0_pin_pull_down: pwm0-pin-pull-down {
 				rockchip,pins =
-					<0 RK_PC1 1 &pcfg_pull_none>;
+					<0 RK_PB5 1 &pcfg_pull_down>;
 			};
 		};
 
-		tsadc {
-			tsadc_otp_gpio: tsadc-otp-gpio {
+		pwm1 {
+			pwm1_pin: pwm1-pin {
 				rockchip,pins =
-					<0 RK_PB2 0 &pcfg_pull_none>;
+					<0 RK_PB6 1 &pcfg_pull_none>;
 			};
 
-			tsadc_otp_out: tsadc-otp-out {
+			pwm1_pin_pull_down: pwm1-pin-pull-down {
 				rockchip,pins =
-					<0 RK_PB2 1 &pcfg_pull_none>;
+					<0 RK_PB6 1 &pcfg_pull_down>;
 			};
 		};
 
-		uart0 {
-			uart0_xfer: uart0-xfer {
+		pwm2 {
+			pwm2_pin: pwm2-pin {
 				rockchip,pins =
-					<2 RK_PA1 1 &pcfg_pull_up>,
-					<2 RK_PA0 1 &pcfg_pull_up>;
+					<0 RK_PB7 1 &pcfg_pull_none>;
 			};
 
-			uart0_cts: uart0-cts {
+			pwm2_pin_pull_down: pwm2-pin-pull-down {
 				rockchip,pins =
-					<2 RK_PA2 1 &pcfg_pull_none>;
+					<0 RK_PB7 1 &pcfg_pull_down>;
 			};
+		};
 
-			uart0_rts: uart0-rts {
+		pwm3 {
+			pwm3_pin: pwm3-pin {
 				rockchip,pins =
-					<2 RK_PA3 1 &pcfg_pull_none>;
+					<0 RK_PC0 1 &pcfg_pull_none>;
 			};
 
-			uart0_rts_gpio: uart0-rts-gpio {
+			pwm3_pin_pull_down: pwm3-pin-pull-down {
 				rockchip,pins =
-					<2 RK_PA3 0 &pcfg_pull_none>;
+					<0 RK_PC0 1 &pcfg_pull_down>;
 			};
 		};
 
-		uart1 {
-			uart1_xfer: uart1-xfer {
+		pwm4 {
+			pwm4_pin: pwm4-pin {
 				rockchip,pins =
-					<1 RK_PD1 1 &pcfg_pull_up>,
-					<1 RK_PD0 1 &pcfg_pull_up>;
+					<0 RK_PA1 2 &pcfg_pull_none>;
 			};
 
-			uart1_cts: uart1-cts {
+			pwm4_pin_pull_down: pwm4-pin-pull-down {
 				rockchip,pins =
-					<1 RK_PC6 1 &pcfg_pull_none>;
+					<0 RK_PA1 2 &pcfg_pull_down>;
 			};
+		};
 
-			uart1_rts: uart1-rts {
+		pwm5 {
+			pwm5_pin: pwm5-pin {
 				rockchip,pins =
-					<1 RK_PC7 1 &pcfg_pull_none>;
+					<0 RK_PC1 2 &pcfg_pull_none>;
 			};
-		};
 
-		uart2-m0 {
-			uart2m0_xfer: uart2m0-xfer {
+			pwm5_pin_pull_down: pwm5-pin-pull-down {
 				rockchip,pins =
-					<1 RK_PC7 2 &pcfg_pull_up>,
-					<1 RK_PC6 2 &pcfg_pull_up>;
+					<0 RK_PC1 2 &pcfg_pull_down>;
 			};
 		};
 
-		uart2-m1 {
-			uart2m1_xfer: uart2m1-xfer {
+		pwm6 {
+			pwm6_pin: pwm6-pin {
 				rockchip,pins =
-					<4 RK_PD3 2 &pcfg_pull_up>,
-					<4 RK_PD2 2 &pcfg_pull_up>;
-			};
-		};
-
-		uart3 {
-			uart3_xfer: uart3-xfer {
-				rockchip,pins =
-					<3 RK_PB5 4 &pcfg_pull_up>,
-					<3 RK_PB4 4 &pcfg_pull_up>;
+					<0 RK_PC2 2 &pcfg_pull_none>;
 			};
-		};
 
-		uart3-m1 {
-			uart3m1_xfer: uart3m1-xfer {
+			pwm6_pin_pull_down: pwm6-pin-pull-down {
 				rockchip,pins =
-					<0 RK_PC2 3 &pcfg_pull_up>,
-					<0 RK_PC1 3 &pcfg_pull_up>;
+					<0 RK_PC2 2 &pcfg_pull_down>;
 			};
 		};
 
-		uart4 {
-
-			uart4_xfer: uart4-xfer {
-				rockchip,pins =
-					<4 RK_PB1 1 &pcfg_pull_up>,
-					<4 RK_PB0 1 &pcfg_pull_up>;
-			};
-
-			uart4_cts: uart4-cts {
-				rockchip,pins =
-					<4 RK_PA6 1 &pcfg_pull_none>;
-
-			};
-
-			uart4_rts: uart4-rts {
+		pwm7 {
+			pwm7_pin: pwm7-pin {
 				rockchip,pins =
-					<4 RK_PA7 1 &pcfg_pull_none>;
+					<2 RK_PB0 2 &pcfg_pull_none>;
 			};
 
-			uart4_rts_gpio: uart4-rts-gpio {
+			pwm7_pin_pull_down: pwm7-pin-pull-down {
 				rockchip,pins =
-					<4 RK_PA7 0 &pcfg_pull_none>;
+					<2 RK_PB0 2 &pcfg_pull_down>;
 			};
 		};
 
-		spi0 {
-			spi0_clk: spi0-clk {
-				rockchip,pins =
-					<2 RK_PA2 2 &pcfg_pull_up_4ma>;
-			};
-
-			spi0_csn0: spi0-csn0 {
-				rockchip,pins =
-					<2 RK_PA3 2 &pcfg_pull_up_4ma>;
-			};
-
-			spi0_miso: spi0-miso {
-				rockchip,pins =
-					<2 RK_PA0 2 &pcfg_pull_up_4ma>;
-			};
-
-			spi0_mosi: spi0-mosi {
-				rockchip,pins =
-					<2 RK_PA1 2 &pcfg_pull_up_4ma>;
-			};
-
-			spi0_clk_hs: spi0-clk-hs {
-				rockchip,pins =
-					<2 RK_PA2 2 &pcfg_pull_up_8ma>;
-			};
-
-			spi0_miso_hs: spi0-miso-hs {
+		pwm8 {
+			pwm8_pin: pwm8-pin {
 				rockchip,pins =
-					<2 RK_PA0 2 &pcfg_pull_up_8ma>;
+					<2 RK_PB2 2 &pcfg_pull_none>;
 			};
 
-			spi0_mosi_hs: spi0-mosi-hs {
+			pwm8_pin_pull_down: pwm8-pin-pull-down {
 				rockchip,pins =
-					<2 RK_PA1 2 &pcfg_pull_up_8ma>;
+					<2 RK_PB2 2 &pcfg_pull_down>;
 			};
-
 		};
 
-		spi1 {
-			spi1_clk: spi1-clk {
-				rockchip,pins =
-					<3 RK_PB3 3 &pcfg_pull_up_4ma>;
-			};
-
-			spi1_csn0: spi1-csn0 {
-				rockchip,pins =
-					<3 RK_PB5 3 &pcfg_pull_up_4ma>;
-			};
-
-			spi1_miso: spi1-miso {
-				rockchip,pins =
-					<3 RK_PB2 3 &pcfg_pull_up_4ma>;
-			};
-
-			spi1_mosi: spi1-mosi {
-				rockchip,pins =
-					<3 RK_PB4 3 &pcfg_pull_up_4ma>;
-			};
-
-			spi1_clk_hs: spi1-clk-hs {
-				rockchip,pins =
-					<3 RK_PB3 3 &pcfg_pull_up_8ma>;
-			};
-
-			spi1_miso_hs: spi1-miso-hs {
+		pwm9 {
+			pwm9_pin: pwm9-pin {
 				rockchip,pins =
-					<3 RK_PB2 3 &pcfg_pull_up_8ma>;
+					<2 RK_PB3 2 &pcfg_pull_none>;
 			};
 
-			spi1_mosi_hs: spi1-mosi-hs {
+			pwm9_pin_pull_down: pwm9-pin-pull-down {
 				rockchip,pins =
-					<3 RK_PB4 3 &pcfg_pull_up_8ma>;
+					<2 RK_PB3 2 &pcfg_pull_down>;
 			};
 		};
 
-		spi1-m1 {
-			spi1m1_miso: spi1m1-miso {
-				rockchip,pins =
-					<2 RK_PA4 2 &pcfg_pull_up_4ma>;
-			};
-
-			spi1m1_mosi: spi1m1-mosi {
-				rockchip,pins =
-					<2 RK_PA5 2 &pcfg_pull_up_4ma>;
-			};
-
-			spi1m1_clk: spi1m1-clk {
-				rockchip,pins =
-					<2 RK_PA7 2 &pcfg_pull_up_4ma>;
-			};
-
-			spi1m1_csn0: spi1m1-csn0 {
-				rockchip,pins =
-					<2 RK_PB1 2 &pcfg_pull_up_4ma>;
-			};
-
-			spi1m1_miso_hs: spi1m1-miso-hs {
-				rockchip,pins =
-					<2 RK_PA4 2 &pcfg_pull_up_8ma>;
-			};
-
-			spi1m1_mosi_hs: spi1m1-mosi-hs {
-				rockchip,pins =
-					<2 RK_PA5 2 &pcfg_pull_up_8ma>;
-			};
-
-			spi1m1_clk_hs: spi1m1-clk-hs {
+		pwm10 {
+			pwm10_pin: pwm10-pin {
 				rockchip,pins =
-					<2 RK_PA7 2 &pcfg_pull_up_8ma>;
+					<2 RK_PB4 2 &pcfg_pull_none>;
 			};
 
-			spi1m1_csn0_hs: spi1m1-csn0-hs {
+			pwm10_pin_pull_down: pwm10-pin-pull-down {
 				rockchip,pins =
-					<2 RK_PB1 2 &pcfg_pull_up_8ma>;
+					<2 RK_PB4 2 &pcfg_pull_down>;
 			};
 		};
 
-		spi2 {
-			spi2_clk: spi2-clk {
-				rockchip,pins =
-					<1 RK_PD0 3 &pcfg_pull_up_4ma>;
-			};
-
-			spi2_csn0: spi2-csn0 {
-				rockchip,pins =
-					<1 RK_PD1 3 &pcfg_pull_up_4ma>;
-			};
-
-			spi2_miso: spi2-miso {
-				rockchip,pins =
-					<1 RK_PC6 3 &pcfg_pull_up_4ma>;
-			};
-
-			spi2_mosi: spi2-mosi {
-				rockchip,pins =
-					<1 RK_PC7 3 &pcfg_pull_up_4ma>;
-			};
-
-			spi2_clk_hs: spi2-clk-hs {
+		pwm11 {
+			pwm11_pin: pwm11-pin {
 				rockchip,pins =
-					<1 RK_PD0 3 &pcfg_pull_up_8ma>;
+					<2 RK_PC0 4 &pcfg_pull_none>;
 			};
 
-			spi2_miso_hs: spi2-miso-hs {
+			pwm11_pin_pull_down: pwm11-pin-pull-down {
 				rockchip,pins =
-					<1 RK_PC6 3 &pcfg_pull_up_8ma>;
+					<2 RK_PC0 4 &pcfg_pull_down>;
 			};
+		};
 
-			spi2_mosi_hs: spi2-mosi-hs {
+		rtc {
+			rtc_32k: rtc-32k {
 				rockchip,pins =
-					<1 RK_PC7 3 &pcfg_pull_up_8ma>;
+					<0 RK_PC3 1 &pcfg_pull_none>;
 			};
 		};
 
@@ -1474,17 +1633,6 @@
 					<4 RK_PD2 1 &pcfg_pull_up_4ma>,
 					<4 RK_PD3 1 &pcfg_pull_up_4ma>;
 			};
-
-			sdmmc_gpio: sdmmc-gpio {
-				rockchip,pins =
-					<4 RK_PD0 0 &pcfg_pull_up_4ma>,
-					<4 RK_PD1 0 &pcfg_pull_up_4ma>,
-					<4 RK_PD2 0 &pcfg_pull_up_4ma>,
-					<4 RK_PD3 0 &pcfg_pull_up_4ma>,
-					<4 RK_PD4 0 &pcfg_pull_up_4ma>,
-					<4 RK_PD5 0 &pcfg_pull_up_4ma>,
-					<4 RK_PD6 0 &pcfg_pull_up_4ma>;
-			};
 		};
 
 		sdio {
@@ -1525,327 +1673,216 @@
 					<4 RK_PA2 1 &pcfg_pull_up_8ma>,
 					<4 RK_PA3 1 &pcfg_pull_up_8ma>;
 			};
-
-			sdio_gpio: sdio-gpio {
-				rockchip,pins =
-					<4 RK_PA0 0 &pcfg_pull_up_4ma>,
-					<4 RK_PA1 0 &pcfg_pull_up_4ma>,
-					<4 RK_PA2 0 &pcfg_pull_up_4ma>,
-					<4 RK_PA3 0 &pcfg_pull_up_4ma>,
-					<4 RK_PA4 0 &pcfg_pull_up_4ma>,
-					<4 RK_PA5 0 &pcfg_pull_up_4ma>;
-			};
 		};
 
-		emmc {
-			emmc_clk: emmc-clk {
-				rockchip,pins =
-					<3 RK_PB1 2 &pcfg_pull_none_8ma>;
-			};
-
-			emmc_cmd: emmc-cmd {
+		spdif_in {
+			spdif_in: spdif-in {
 				rockchip,pins =
-					<3 RK_PB0 2 &pcfg_pull_up_8ma>;
+					<0 RK_PC2 1 &pcfg_pull_none>;
 			};
+		};
 
-			emmc_pwren: emmc-pwren {
+		spdif_out {
+			spdif_out: spdif-out {
 				rockchip,pins =
-					<3 RK_PB3 2 &pcfg_pull_none>;
+					<0 RK_PC1 1 &pcfg_pull_none>;
 			};
+		};
 
-			emmc_rstn: emmc-rstn {
+		spi0 {
+			spi0_clk: spi0-clk {
 				rockchip,pins =
-					<3 RK_PB2 2 &pcfg_pull_none>;
+					<2 RK_PA2 2 &pcfg_pull_up_4ma>;
 			};
 
-			emmc_bus1: emmc-bus1 {
+			spi0_csn0: spi0-csn0 {
 				rockchip,pins =
-					<3 RK_PA0 2 &pcfg_pull_up_8ma>;
+					<2 RK_PA3 2 &pcfg_pull_up_4ma>;
 			};
 
-			emmc_bus4: emmc-bus4 {
+			spi0_miso: spi0-miso {
 				rockchip,pins =
-					<3 RK_PA0 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA1 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA2 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA3 2 &pcfg_pull_up_8ma>;
+					<2 RK_PA0 2 &pcfg_pull_up_4ma>;
 			};
 
-			emmc_bus8: emmc-bus8 {
+			spi0_mosi: spi0-mosi {
 				rockchip,pins =
-					<3 RK_PA0 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA1 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA2 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA3 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA4 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA5 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA6 2 &pcfg_pull_up_8ma>,
-					<3 RK_PA7 2 &pcfg_pull_up_8ma>;
+					<2 RK_PA1 2 &pcfg_pull_up_4ma>;
 			};
 		};
 
-		flash {
-			flash_csn0: flash-csn0 {
-				rockchip,pins =
-					<3 RK_PB5 1 &pcfg_pull_none>;
-			};
-
-			flash_rdy: flash-rdy {
-				rockchip,pins =
-					<3 RK_PB4 1 &pcfg_pull_none>;
-			};
-
-			flash_ale: flash-ale {
-				rockchip,pins =
-					<3 RK_PB3 1 &pcfg_pull_none>;
-			};
-
-			flash_cle: flash-cle {
+		spi1 {
+			spi1_clk: spi1-clk {
 				rockchip,pins =
-					<3 RK_PB1 1 &pcfg_pull_none>;
+					<3 RK_PB3 3 &pcfg_pull_up_4ma>;
 			};
 
-			flash_wrn: flash-wrn {
+			spi1_csn0: spi1-csn0 {
 				rockchip,pins =
-					<3 RK_PB0 1 &pcfg_pull_none>;
+					<3 RK_PB5 3 &pcfg_pull_up_4ma>;
 			};
 
-			flash_rdn: flash-rdn {
+			spi1_miso: spi1-miso {
 				rockchip,pins =
-					<3 RK_PB2 1 &pcfg_pull_none>;
+					<3 RK_PB2 3 &pcfg_pull_up_4ma>;
 			};
 
-			flash_bus8: flash-bus8 {
+			spi1_mosi: spi1-mosi {
 				rockchip,pins =
-					<3 RK_PA0 1 &pcfg_pull_up_12ma>,
-					<3 RK_PA1 1 &pcfg_pull_up_12ma>,
-					<3 RK_PA2 1 &pcfg_pull_up_12ma>,
-					<3 RK_PA3 1 &pcfg_pull_up_12ma>,
-					<3 RK_PA4 1 &pcfg_pull_up_12ma>,
-					<3 RK_PA5 1 &pcfg_pull_up_12ma>,
-					<3 RK_PA6 1 &pcfg_pull_up_12ma>,
-					<3 RK_PA7 1 &pcfg_pull_up_12ma>;
+					<3 RK_PB4 3 &pcfg_pull_up_4ma>;
 			};
 		};
 
-		pwm0 {
-			pwm0_pin: pwm0-pin {
+		spi1-m1 {
+			spi1m1_miso: spi1m1-miso {
 				rockchip,pins =
-					<0 RK_PB5 1 &pcfg_pull_none>;
+					<2 RK_PA4 2 &pcfg_pull_up_4ma>;
 			};
 
-			pwm0_pin_pull_down: pwm0-pin-pull-down {
+			spi1m1_mosi: spi1m1-mosi {
 				rockchip,pins =
-					<0 RK_PB5 1 &pcfg_pull_down>;
+					<2 RK_PA5 2 &pcfg_pull_up_4ma>;
 			};
-		};
 
-		pwm1 {
-			pwm1_pin: pwm1-pin {
+			spi1m1_clk: spi1m1-clk {
 				rockchip,pins =
-					<0 RK_PB6 1 &pcfg_pull_none>;
+					<2 RK_PA7 2 &pcfg_pull_up_4ma>;
 			};
 
-			pwm1_pin_pull_down: pwm1-pin-pull-down {
+			spi1m1_csn0: spi1m1-csn0 {
 				rockchip,pins =
-					<0 RK_PB6 1 &pcfg_pull_down>;
+					<2 RK_PB1 2 &pcfg_pull_up_4ma>;
 			};
 		};
 
-		pwm2 {
-			pwm2_pin: pwm2-pin {
+		spi2 {
+			spi2_clk: spi2-clk {
 				rockchip,pins =
-					<0 RK_PB7 1 &pcfg_pull_none>;
+					<1 RK_PD0 3 &pcfg_pull_up_4ma>;
 			};
 
-			pwm2_pin_pull_down: pwm2-pin-pull-down {
+			spi2_csn0: spi2-csn0 {
 				rockchip,pins =
-					<0 RK_PB7 1 &pcfg_pull_down>;
+					<1 RK_PD1 3 &pcfg_pull_up_4ma>;
 			};
-		};
 
-		pwm3 {
-			pwm3_pin: pwm3-pin {
+			spi2_miso: spi2-miso {
 				rockchip,pins =
-					<0 RK_PC0 1 &pcfg_pull_none>;
+					<1 RK_PC6 3 &pcfg_pull_up_4ma>;
 			};
 
-			pwm3_pin_pull_down: pwm3-pin-pull-down {
+			spi2_mosi: spi2-mosi {
 				rockchip,pins =
-					<0 RK_PC0 1 &pcfg_pull_down>;
+					<1 RK_PC7 3 &pcfg_pull_up_4ma>;
 			};
 		};
 
-		pwm4 {
-			pwm4_pin: pwm4-pin {
+		tsadc {
+			tsadc_otp_pin: tsadc-otp-pin {
 				rockchip,pins =
-					<0 RK_PA1 2 &pcfg_pull_none>;
+					<0 RK_PB2 0 &pcfg_pull_none>;
 			};
 
-			pwm4_pin_pull_down: pwm4-pin-pull-down {
+			tsadc_otp_out: tsadc-otp-out {
 				rockchip,pins =
-					<0 RK_PA1 2 &pcfg_pull_down>;
+					<0 RK_PB2 1 &pcfg_pull_none>;
 			};
 		};
 
-		pwm5 {
-			pwm5_pin: pwm5-pin {
+		uart0 {
+			uart0_xfer: uart0-xfer {
 				rockchip,pins =
-					<0 RK_PC1 2 &pcfg_pull_none>;
+					<2 RK_PA1 1 &pcfg_pull_up>,
+					<2 RK_PA0 1 &pcfg_pull_up>;
 			};
 
-			pwm5_pin_pull_down: pwm5-pin-pull-down {
+			uart0_cts: uart0-cts {
 				rockchip,pins =
-					<0 RK_PC1 2 &pcfg_pull_down>;
+					<2 RK_PA2 1 &pcfg_pull_none>;
 			};
-		};
 
-		pwm6 {
-			pwm6_pin: pwm6-pin {
+			uart0_rts: uart0-rts {
 				rockchip,pins =
-					<0 RK_PC2 2 &pcfg_pull_none>;
+					<2 RK_PA3 1 &pcfg_pull_none>;
 			};
 
-			pwm6_pin_pull_down: pwm6-pin-pull-down {
+			uart0_rts_pin: uart0-rts-pin {
 				rockchip,pins =
-					<0 RK_PC2 2 &pcfg_pull_down>;
+					<2 RK_PA3 0 &pcfg_pull_none>;
 			};
 		};
 
-		pwm7 {
-			pwm7_pin: pwm7-pin {
-				rockchip,pins =
-					<2 RK_PB0 2 &pcfg_pull_none>;
-			};
-
-			pwm7_pin_pull_down: pwm7-pin-pull-down {
+		uart1 {
+			uart1_xfer: uart1-xfer {
 				rockchip,pins =
-					<2 RK_PB0 2 &pcfg_pull_down>;
+					<1 RK_PD1 1 &pcfg_pull_up>,
+					<1 RK_PD0 1 &pcfg_pull_up>;
 			};
-		};
 
-		pwm8 {
-			pwm8_pin: pwm8-pin {
+			uart1_cts: uart1-cts {
 				rockchip,pins =
-					<2 RK_PB2 2 &pcfg_pull_none>;
+					<1 RK_PC6 1 &pcfg_pull_none>;
 			};
 
-			pwm8_pin_pull_down: pwm8-pin-pull-down {
+			uart1_rts: uart1-rts {
 				rockchip,pins =
-					<2 RK_PB2 2 &pcfg_pull_down>;
+					<1 RK_PC7 1 &pcfg_pull_none>;
 			};
 		};
 
-		pwm9 {
-			pwm9_pin: pwm9-pin {
-				rockchip,pins =
-					<2 RK_PB3 2 &pcfg_pull_none>;
-			};
-
-			pwm9_pin_pull_down: pwm9-pin-pull-down {
+		uart2-m0 {
+			uart2m0_xfer: uart2m0-xfer {
 				rockchip,pins =
-					<2 RK_PB3 2 &pcfg_pull_down>;
+					<1 RK_PC7 2 &pcfg_pull_up>,
+					<1 RK_PC6 2 &pcfg_pull_up>;
 			};
 		};
 
-		pwm10 {
-			pwm10_pin: pwm10-pin {
-				rockchip,pins =
-					<2 RK_PB4 2 &pcfg_pull_none>;
-			};
-
-			pwm10_pin_pull_down: pwm10-pin-pull-down {
+		uart2-m1 {
+			uart2m1_xfer: uart2m1-xfer {
 				rockchip,pins =
-					<2 RK_PB4 2 &pcfg_pull_down>;
+					<4 RK_PD3 2 &pcfg_pull_up>,
+					<4 RK_PD2 2 &pcfg_pull_up>;
 			};
 		};
 
-		pwm11 {
-			pwm11_pin: pwm11-pin {
-				rockchip,pins =
-					<2 RK_PC0 4 &pcfg_pull_none>;
-			};
-
-			pwm11_pin_pull_down: pwm11-pin-pull-down {
+		uart3 {
+			uart3_xfer: uart3-xfer {
 				rockchip,pins =
-					<2 RK_PC0 4 &pcfg_pull_down>;
+					<3 RK_PB5 4 &pcfg_pull_up>,
+					<3 RK_PB4 4 &pcfg_pull_up>;
 			};
 		};
 
-		gmac {
-			rmii_pins: rmii-pins {
-				rockchip,pins =
-					/* mac_txen */
-					<1 RK_PC1 3 &pcfg_pull_none_12ma>,
-					/* mac_txd1 */
-					<1 RK_PC3 3 &pcfg_pull_none_12ma>,
-					/* mac_txd0 */
-					<1 RK_PC2 3 &pcfg_pull_none_12ma>,
-					/* mac_rxd0 */
-					<1 RK_PC4 3 &pcfg_pull_none>,
-					/* mac_rxd1 */
-					<1 RK_PC5 3 &pcfg_pull_none>,
-					/* mac_rxer */
-					<1 RK_PB7 3 &pcfg_pull_none>,
-					/* mac_rxdv */
-					<1 RK_PC0 3 &pcfg_pull_none>,
-					/* mac_mdio */
-					<1 RK_PB6 3 &pcfg_pull_none>,
-					/* mac_mdc */
-					<1 RK_PB5 3 &pcfg_pull_none>;
-			};
-
-			mac_refclk_12ma: mac-refclk-12ma {
-				rockchip,pins =
-					<1 RK_PB4 3 &pcfg_pull_none_12ma>;
-			};
-
-			mac_refclk: mac-refclk {
+		uart3-m1 {
+			uart3m1_xfer: uart3m1-xfer {
 				rockchip,pins =
-					<1 RK_PB4 3 &pcfg_pull_none>;
+					<0 RK_PC2 3 &pcfg_pull_up>,
+					<0 RK_PC1 3 &pcfg_pull_up>;
 			};
 		};
 
-		gmac-m1 {
-			rmiim1_pins: rmiim1-pins {
+		uart4 {
+			uart4_xfer: uart4-xfer {
 				rockchip,pins =
-					/* mac_txen */
-					<4 RK_PB7 2 &pcfg_pull_none_12ma>,
-					/* mac_txd1 */
-					<4 RK_PA5 2 &pcfg_pull_none_12ma>,
-					/* mac_txd0 */
-					<4 RK_PA4 2 &pcfg_pull_none_12ma>,
-					/* mac_rxd0 */
-					<4 RK_PA2 2 &pcfg_pull_none>,
-					/* mac_rxd1 */
-					<4 RK_PA3 2 &pcfg_pull_none>,
-					/* mac_rxer */
-					<4 RK_PA0 2 &pcfg_pull_none>,
-					/* mac_rxdv */
-					<4 RK_PA1 2 &pcfg_pull_none>,
-					/* mac_mdio */
-					<4 RK_PB6 2 &pcfg_pull_none>,
-					/* mac_mdc */
-					<4 RK_PB5 2 &pcfg_pull_none>;
+					<4 RK_PB1 1 &pcfg_pull_up>,
+					<4 RK_PB0 1 &pcfg_pull_up>;
 			};
 
-			macm1_refclk_12ma: macm1-refclk-12ma {
+			uart4_cts: uart4-cts {
 				rockchip,pins =
-					<4 RK_PB4 2 &pcfg_pull_none_12ma>;
+					<4 RK_PA6 1 &pcfg_pull_none>;
 			};
 
-			macm1_refclk: macm1-refclk {
+			uart4_rts: uart4-rts {
 				rockchip,pins =
-					<4 RK_PB4 2 &pcfg_pull_none>;
+					<4 RK_PA7 1 &pcfg_pull_none>;
 			};
-		};
 
-		rtc {
-			rtc_32k: rtc-32k {
+			uart4_rts_pin: uart4-rts-pin {
 				rockchip,pins =
-					<0 RK_PC3 1 &pcfg_pull_none>;
+					<4 RK_PA7 0 &pcfg_pull_none>;
 			};
 		};
-
 	};
 };
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index c1bae3f68bd4..33fc36da5077 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -739,7 +739,7 @@ static const struct udevice_id rockchip_gmac_ids[] = {
 	  .data = (ulong)&rk3228_gmac_ops },
 	{ .compatible = "rockchip,rk3288-gmac",
 	  .data = (ulong)&rk3288_gmac_ops },
-	{ .compatible = "rockchip,rk3308-mac",
+	{ .compatible = "rockchip,rk3308-gmac",
 	  .data = (ulong)&rk3308_gmac_ops },
 	{ .compatible = "rockchip,rk3328-gmac",
 	  .data = (ulong)&rk3328_gmac_ops },
-- 
2.43.2

