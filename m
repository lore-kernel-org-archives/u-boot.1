Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2B2CDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 17:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8596F86F2B;
	Tue, 17 Oct 2023 19:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pLada+I7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23D186EE7; Tue, 17 Oct 2023 19:02:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C3886F45
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 19:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=165c=GA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1697562146; bh=shmafYZJ26uOAO7tgEl9d+V4i8y8NNPMV3s5MNuZxSI=;
 b=pLada+I7tyv6+LKSG8l8pMlrhRy//N1jvKiAJ1lRRyVE7C1GC43WOjxbOfbYaWlaYoPe/sGk1
 nSqdzkPmmYZSKJqaFIMGQzjg9WzJseqM5MKbOy9HzHFY5VHlnaMW1HVd8Z9cmT8ySynTlW8AwXT
 7+F2UBVjw40E+mmXWX5+WFSeWY1RB8Y7FHVzVfO+6Zii0zJL6bTpovqVQbGKaWayznJ2P+JJl8w
 6/PsuyOI5rLS6AI4CJd6w7t4RgKNTTF5ojZtxa/2h91vDWw+I29ClVl8MM5lRZBw/zCppcq3tfq
 28n6zn/MFJmwWESH/dCce1lPYmkEGdEF7KidJo5z6eOQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v2 1/4] rockchip: rk3588: Sync device tree from
 v6.7-rockchip-dts64-1 tag
Date: Tue, 17 Oct 2023 17:02:08 +0000
Message-ID: <20231017170216.1627789-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017170216.1627789-1-jonas@kwiboo.se>
References: <20231017170216.1627789-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 652ebe207b04e7479c18eab1
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

Sync rk3588 device tree from v6.7-rockchip-dts64-1 tag.

Adds PCIe, button and led nodes to rk3588-evb1-v10 and rk3588-rock-5b
boards. Also remove includes from u-boot.dtsi-files that is no longer
needed.

Linux commits:
42145b7a8235 ("arm64: dts: rockchip: add PCIe network controller to rock-5b")
199cbd5f195a ("arm64: dts: rockchip: add PCIe for M.2 M-key to rock-5b")
da447ec38780 ("arm64: dts: rockchip: add PCIe for M.2 E-Key to rock-5b")
86a2024d95e2 ("arm64: dts: rockchip: add PCIe2 network controller to rk3588-evb1")
46bb398ea1d8 ("arm64: dts: rockchip: add PCIe3 bus to rk3588-evb1")
1c9a53ff7ece ("arm64: dts: rockchip: Add sdio node to rock-5b")
3eaf2abd11aa ("arm64: dts: rockchip: Add sfc node to rk3588s")
bf012368bb0a ("arm64: dts: rockchip: Add I2S2 M0 pin definitions to rk3588s")
3d77a3e51b0f ("arm64: dts: rockchip: Add UART9 M0 pin definitions to rk3588s")
0002c377e862 ("arm64: dts: rockchip: Remove duplicate regulator vcc3v3_wf from rock-5b")
a6169ab36923 ("arm64: dts: rockchip: Enable UART6 on rock-5b")
dd6dc0c4c126 ("arm64: dts: rockchip: Add AV1 decoder node to rk3588s")
afa933c208e5 ("arm64: dts: rockchip: add ADC buttons to rk3588-evb1")
7952cbbda301 ("arm64: dts: rockchip: add status LED to rock-5b")

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Sync with "Rockchip dts64 changes for 6.7" PR [1]
- Collect r-b tags

[1] https://lore.kernel.org/all/1870252.CQOukoFCf9@phil/

 arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi |  11 +-
 arch/arm/dts/rk3588-evb1-v10.dts         | 136 +++++++++++++++++++++
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi  |  60 ----------
 arch/arm/dts/rk3588-rock-5b.dts          | 145 +++++++++++++++++++++++
 arch/arm/dts/rk3588-u-boot.dtsi          |   1 -
 arch/arm/dts/rk3588s-pinctrl.dtsi        |  44 +++++++
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi |   4 -
 arch/arm/dts/rk3588s-u-boot.dtsi         |  10 --
 arch/arm/dts/rk3588s.dtsi                |  24 ++++
 9 files changed, 350 insertions(+), 85 deletions(-)

diff --git a/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi b/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
index bd2e25948633..e8566785e965 100644
--- a/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
@@ -6,16 +6,7 @@
 #include "rk3588-u-boot.dtsi"
 
 / {
-	aliases {
-		mmc0 = &sdmmc;
-		mmc1 = &sdhci;
-	};
-
 	chosen {
-		u-boot,spl-boot-order = &sdhci;
+		u-boot,spl-boot-order = "same-as-spl", &sdhci;
 	};
 };
-
-&sdhci {
-	bootph-all;
-};
diff --git a/arch/arm/dts/rk3588-evb1-v10.dts b/arch/arm/dts/rk3588-evb1-v10.dts
index 229a9111f5eb..b9d789d57862 100644
--- a/arch/arm/dts/rk3588-evb1-v10.dts
+++ b/arch/arm/dts/rk3588-evb1-v10.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include "rk3588.dtsi"
 
@@ -23,12 +24,84 @@
 		stdout-path = "serial2:1500000n8";
 	};
 
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			press-threshold-microvolt = <17000>;
+		};
+
+		button-vol-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			press-threshold-microvolt = <417000>;
+		};
+
+		button-menu {
+			label = "Menu";
+			linux,code = <KEY_MENU>;
+			press-threshold-microvolt = <890000>;
+		};
+
+		button-escape {
+			label = "Escape";
+			linux,code = <KEY_ESC>;
+			press-threshold-microvolt = <1235000>;
+		};
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		power-supply = <&vcc12v_dcin>;
 		pwms = <&pwm2 0 25000 0>;
 	};
 
+	pcie20_avdd0v85: pcie20-avdd0v85-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie20_avdd0v85";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <850000>;
+		regulator-max-microvolt = <850000>;
+		vin-supply = <&avdd_0v85_s0>;
+	};
+
+	pcie20_avdd1v8: pcie20-avdd1v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie20_avdd1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&avcc_1v8_s0>;
+	};
+
+	pcie30_avdd0v75: pcie30-avdd0v75-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd0v75";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <750000>;
+		regulator-max-microvolt = <750000>;
+		vin-supply = <&avdd_0v75_s0>;
+	};
+
+	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&avcc_1v8_s0>;
+	};
+
 	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -38,6 +111,19 @@
 		regulator-max-microvolt = <12000000>;
 	};
 
+	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie30";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc12v_dcin>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc3v3_pcie30_en>;
+	};
+
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
@@ -87,6 +173,10 @@
 	status = "okay";
 };
 
+&combphy2_psu {
+	status = "okay";
+};
+
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
@@ -163,7 +253,32 @@
 	};
 };
 
+&pcie2x1l1 {
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>;
+	status = "okay";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3_reset>;
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
 &pinctrl {
+	rtl8111 {
+		rtl8111_isolate: rtl8111-isolate {
+			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	rtl8211f {
 		rtl8211f_rst: rtl8211f-rst {
 			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -177,6 +292,22 @@
 		};
 	};
 
+	pcie2 {
+		pcie2_1_rst: pcie2-1-rst {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie3 {
+		pcie3_reset: pcie3-reset {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc3v3_pcie30_en: vcc3v3-pcie30-en {
+			rockchip,pins = <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -188,6 +319,11 @@
 	status = "okay";
 };
 
+&saradc {
+	vref-supply = <&vcc_1v8_s0>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	no-sdio;
diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index 96cc84e5aac9..3f390ef26a3f 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -4,9 +4,6 @@
  */
 
 #include "rk3588-u-boot.dtsi"
-#include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/usb/pd.h>
 
 / {
@@ -23,19 +20,6 @@
 		regulator-max-microvolt = <12000000>;
 	};
 
-	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_pcie30";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		enable-active-high;
-		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <5000>;
-		vin-supply = <&vcc5v0_sys>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pcie3_vcc3v3_en>;
-	};
-
 	vcc5v0_usbdcin: vcc5v0-usbdcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usbdcin";
@@ -69,53 +53,11 @@
 	};
 };
 
-&combphy0_ps {
-	status = "okay";
-};
-
 &fspim2_pins {
 	bootph-all;
 };
 
-&pcie2x1l2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2x1l2_pins &pcie_reset_h>;
-	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&pcie30phy {
-	status = "okay";
-};
-
-&pcie3x4 {
-	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc3v3_pcie30>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_rst>;
-	status = "okay";
-};
-
 &pinctrl {
-	pcie {
-		pcie_reset_h: pcie-reset-h {
-			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		pcie2x1l2_pins: pcie2x1l2-pins {
-			rockchip,pins = <3 RK_PC7 4 &pcfg_pull_none>,
-					<3 RK_PD0 4 &pcfg_pull_none>;
-		};
-
-		pcie3_rst: pcie3-rst {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
-			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	usb-typec {
 		usbc0_int: usbc0-int {
 			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -138,8 +80,6 @@
 	u-boot,spl-sfc-no-dma;
 	pinctrl-names = "default";
 	pinctrl-0 = <&fspim2_pins>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	status = "okay";
 
 	flash@0 {
diff --git a/arch/arm/dts/rk3588-rock-5b.dts b/arch/arm/dts/rk3588-rock-5b.dts
index 8ab60968f275..741f631db345 100644
--- a/arch/arm/dts/rk3588-rock-5b.dts
+++ b/arch/arm/dts/rk3588-rock-5b.dts
@@ -3,6 +3,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include "rk3588.dtsi"
 
 / {
@@ -12,6 +13,7 @@
 	aliases {
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
+		mmc2 = &sdio;
 		serial2 = &uart2;
 	};
 
@@ -36,6 +38,19 @@
 		pinctrl-0 = <&hp_detect>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_rgb_b>;
+
+		led_rgb_b {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	fan: pwm-fan {
 		compatible = "pwm-fan";
 		cooling-levels = <0 95 145 195 255>;
@@ -44,6 +59,43 @@
 		#cooling-cells = <2>;
 	};
 
+	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie2_0_vcc3v3_en>;
+		regulator-name = "vcc3v3_pcie2x1l0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <50000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_pcie2x1l2: vcc3v3-pcie2x1l2-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie2x1l2";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
+	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie3_vcc3v3_en>;
+		regulator-name = "vcc3v3_pcie30";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
@@ -78,6 +130,14 @@
 	};
 };
 
+&combphy0_ps {
+	status = "okay";
+};
+
+&combphy1_ps {
+	status = "okay";
+};
+
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
@@ -204,6 +264,34 @@
 	};
 };
 
+&pcie2x1l0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_0_rst>;
+	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
+	status = "okay";
+};
+
+&pcie2x1l2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_2_rst>;
+	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
+	status = "okay";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3_rst>;
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
 &pinctrl {
 	hym8563 {
 		hym8563_int: hym8563-int {
@@ -211,12 +299,42 @@
 		};
 	};
 
+	leds {
+		led_rgb_b: led-rgb-b {
+			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sound {
 		hp_detect: hp-detect {
 			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
+	pcie2 {
+		pcie2_0_rst: pcie2-0-rst {
+			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
+			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2_2_rst: pcie2-2-rst {
+			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie3 {
+		pcie3_rst: pcie3-rst {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
+			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		vcc5v0_host_en: vcc5v0-host-en {
 			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -258,6 +376,33 @@
 	status = "okay";
 };
 
+&sdio {
+	max-frequency = <200000000>;
+	no-sd;
+	no-mmc;
+	non-removable;
+	bus-width = <4>;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	wakeup-source;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_pcie2x1l0>;
+	vqmmc-supply = <&vcc_1v8_s3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdiom0_pins>;
+	status = "okay";
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart6m1_xfer &uart6m1_ctsn &uart6m1_rtsn>;
+	status = "okay";
+};
+
 &spi2 {
 	status = "okay";
 	assigned-clocks = <&cru CLK_SPI2>;
diff --git a/arch/arm/dts/rk3588-u-boot.dtsi b/arch/arm/dts/rk3588-u-boot.dtsi
index 68b419f3abd5..15de4706254e 100644
--- a/arch/arm/dts/rk3588-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-u-boot.dtsi
@@ -3,7 +3,6 @@
  * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
  */
 
-#include "rockchip-u-boot.dtsi"
 #include "rk3588s-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/rk3588s-pinctrl.dtsi b/arch/arm/dts/rk3588s-pinctrl.dtsi
index 48181671eacb..63151d9d2377 100644
--- a/arch/arm/dts/rk3588s-pinctrl.dtsi
+++ b/arch/arm/dts/rk3588s-pinctrl.dtsi
@@ -1349,6 +1349,41 @@
 	};
 
 	i2s2 {
+		/omit-if-no-ref/
+		i2s2m0_lrck: i2s2m0-lrck {
+			rockchip,pins =
+				/* i2s2m0_lrck */
+				<2 RK_PC0 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m0_mclk: i2s2m0-mclk {
+			rockchip,pins =
+				/* i2s2m0_mclk */
+				<2 RK_PB6 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m0_sclk: i2s2m0-sclk {
+			rockchip,pins =
+				/* i2s2m0_sclk */
+				<2 RK_PB7 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m0_sdi: i2s2m0-sdi {
+			rockchip,pins =
+				/* i2s2m0_sdi */
+				<2 RK_PC3 2 &pcfg_pull_none>;
+		};
+
+		/omit-if-no-ref/
+		i2s2m0_sdo: i2s2m0-sdo {
+			rockchip,pins =
+				/* i2s2m0_sdo */
+				<4 RK_PC3 2 &pcfg_pull_none>;
+		};
+
 		/omit-if-no-ref/
 		i2s2m1_lrck: i2s2m1-lrck {
 			rockchip,pins =
@@ -3307,6 +3342,15 @@
 	};
 
 	uart9 {
+		/omit-if-no-ref/
+		uart9m0_xfer: uart9m0-xfer {
+			rockchip,pins =
+				/* uart9_rx_m0 */
+				<2 RK_PC4 10 &pcfg_pull_up>,
+				/* uart9_tx_m0 */
+				<2 RK_PC2 10 &pcfg_pull_up>;
+		};
+
 		/omit-if-no-ref/
 		uart9m1_xfer: uart9m1-xfer {
 			rockchip,pins =
diff --git a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
index c47b0a7112c8..584476f77b13 100644
--- a/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
@@ -4,10 +4,6 @@
  */
 
 #include "rk3588s-u-boot.dtsi"
-#include <dt-bindings/pinctrl/rockchip.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/usb/pd.h>
 
 / {
 	chosen {
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 27b2d7eff87b..878936fa07d6 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -4,7 +4,6 @@
  */
 
 #include "rockchip-u-boot.dtsi"
-#include <dt-bindings/phy/phy.h>
 
 / {
 	aliases {
@@ -102,15 +101,6 @@
 		reg = <0x0 0xfd5c8000 0x0 0x4000>;
 	};
 
-	sfc: spi@fe2b0000 {
-		compatible = "rockchip,sfc";
-		reg = <0x0 0xfe2b0000 0x0 0x4000>;
-		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
-		clock-names = "clk_sfc", "hclk_sfc";
-		status = "disabled";
-	};
-
 	rng: rng@fe378000 {
 		compatible = "rockchip,trngv1";
 		reg = <0x0 0xfe378000 0x0 0x200>;
diff --git a/arch/arm/dts/rk3588s.dtsi b/arch/arm/dts/rk3588s.dtsi
index 5544f66c6ff4..61a9a11c3bb0 100644
--- a/arch/arm/dts/rk3588s.dtsi
+++ b/arch/arm/dts/rk3588s.dtsi
@@ -1424,6 +1424,17 @@
 		};
 	};
 
+	sfc: spi@fe2b0000 {
+		compatible = "rockchip,sfc";
+		reg = <0x0 0xfe2b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sdmmc: mmc@fe2c0000 {
 		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe2c0000 0x0 0x4000>;
@@ -2304,6 +2315,19 @@
 			#interrupt-cells = <2>;
 		};
 	};
+
+	av1d: video-codec@fdc70000 {
+		compatible = "rockchip,rk3588-av1-vpu";
+		reg = <0x0 0xfdc70000 0x0 0x800>;
+		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vdpu";
+		assigned-clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
+		assigned-clock-rates = <400000000>, <400000000>;
+		clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
+		clock-names = "aclk", "hclk";
+		power-domains = <&power RK3588_PD_AV1>;
+		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
+	};
 };
 
 #include "rk3588s-pinctrl.dtsi"
-- 
2.42.0

