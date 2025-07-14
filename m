Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8243AC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 22:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F2583010;
	Tue, 15 Jul 2025 00:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZiUs+fX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9517E83043; Tue, 15 Jul 2025 00:34:33 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F00FB82E52
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 00:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752532468; bh=9op8D/77IM/Q6V9Lnq4bMIgKlFECOTfcOw8CK5ADo7Y=;
 b=ZiUs+fX1mqH4YGx+9XLkWPxEtT29617kXIkOjCTUjCxLn76KYhBnzn+Nxq+DuAa28i5Cw3vY7
 YDMgou3Q4JpGKQa22ti7CK7nEd87k80oEvQHaO8sE2HMwR4s2YKhVZrp6l9KTE75bAvfUQV1qT7
 NyiRXrPLYyaoVVgKMUjOkN6/c/27XDoosSGo/WQEYOaLWzwLzBJpnLbXYyUUW2DnaSa2Nexx5m4
 9553pv3/MCsv/WvRhYOkWm/ynFTNXxKkxWBlZeUuwV0rYASKwanu2JFAtE0E3pMv51yDmVZgUMi
 NlLgHl9WJ21hO4184C0GRkTH2oU+uBxmV9CHLp8GbeXA==
X-Forward-Email-ID: 687585f19931367d30116e50
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/4] arm64: dts: rockchip: move rock 5b to include file
Date: Mon, 14 Jul 2025 22:33:59 +0000
Message-ID: <20250714223410.1836893-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714223410.1836893-1-jonas@kwiboo.se>
References: <20250714223410.1836893-1-jonas@kwiboo.se>
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

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Radxa released some more boards, which are based on the original
Rock 5B. Move its board description into an include file to avoid
unnecessary duplication.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250508-rock5bp-for-upstream-v2-1-677033cc1ac2@kernel.org
Link: https://lore.kernel.org/r/20250508-rock5bp-for-upstream-v2-2-677033cc1ac2@kernel.org

[The original submission was split into two elements, renaming the file
 and then moving some nodes around. This was done to make review easier
 due to the diff being smaller. This commit is a squash of both of them
 to facilitate bisectability and was also intended by the original author]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: aadfbdcf7e1e7f3892e0e4bdcc3c9c7c9adfb723 ]

(cherry picked from commit 4238190b0f4922314c15a8fe575cb90ee263825d)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../src/arm64/rockchip/rk3588-rock-5b.dts     | 953 +-----------------
 .../src/arm64/rockchip/rk3588-rock-5b.dtsi    | 945 +++++++++++++++++
 2 files changed, 955 insertions(+), 943 deletions(-)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dtsi

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts b/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts
index 17f4fd054cd3..9407a7c9910a 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dts
@@ -2,532 +2,11 @@
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/soc/rockchip,vop2.h>
-#include "rk3588.dtsi"
+#include "rk3588-rock-5b.dtsi"
 
 / {
 	model = "Radxa ROCK 5B";
 	compatible = "radxa,rock-5b", "rockchip,rk3588";
-
-	aliases {
-		mmc0 = &sdhci;
-		mmc1 = &sdmmc;
-		mmc2 = &sdio;
-	};
-
-	chosen {
-		stdout-path = "serial2:1500000n8";
-	};
-
-	analog-sound {
-		compatible = "audio-graph-card";
-		label = "rk3588-es8316";
-
-		widgets = "Microphone", "Mic Jack",
-			  "Headphone", "Headphones";
-
-		routing = "MIC2", "Mic Jack",
-			  "Headphones", "HPOL",
-			  "Headphones", "HPOR";
-
-		dais = <&i2s0_8ch_p0>;
-		hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&hp_detect>;
-	};
-
-	hdmi0-con {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi0_con_in: endpoint {
-				remote-endpoint = <&hdmi0_out_con>;
-			};
-		};
-	};
-
-	hdmi1-con {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi1_con_in: endpoint {
-				remote-endpoint = <&hdmi1_out_con>;
-			};
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_rgb_b>;
-
-		led_rgb_b {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	fan: pwm-fan {
-		compatible = "pwm-fan";
-		cooling-levels = <0 120 150 180 210 240 255>;
-		fan-supply = <&vcc5v0_sys>;
-		pwms = <&pwm1 0 50000 0>;
-		#cooling-cells = <2>;
-	};
-
-	rfkill {
-		compatible = "rfkill-gpio";
-		label = "rfkill-m2-wlan";
-		radio-type = "wlan";
-		shutdown-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
-	};
-
-	rfkill-bt {
-		compatible = "rfkill-gpio";
-		label = "rfkill-m2-bt";
-		radio-type = "bluetooth";
-		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
-	};
-
-	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pcie2_0_vcc3v3_en>;
-		regulator-name = "vcc3v3_pcie2x1l0";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <50000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc3v3_pcie2x1l2: regulator-vcc3v3-pcie2x1l2 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_pcie2x1l2";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <5000>;
-		vin-supply = <&vcc_3v3_s3>;
-	};
-
-	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pcie3_vcc3v3_en>;
-		regulator-name = "vcc3v3_pcie30";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <5000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc5v0_host: regulator-vcc5v0-host {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_host";
-		regulator-boot-on;
-		regulator-always-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		enable-active-high;
-		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_host_en>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc5v0_sys: regulator-vcc5v0-sys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_1v1_nldo_s3";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1100000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-};
-
-&combphy0_ps {
-	status = "okay";
-};
-
-&combphy1_ps {
-	status = "okay";
-};
-
-&combphy2_psu {
-	status = "okay";
-};
-
-&cpu_b0 {
-	cpu-supply = <&vdd_cpu_big0_s0>;
-};
-
-&cpu_b1 {
-	cpu-supply = <&vdd_cpu_big0_s0>;
-};
-
-&cpu_b2 {
-	cpu-supply = <&vdd_cpu_big1_s0>;
-};
-
-&cpu_b3 {
-	cpu-supply = <&vdd_cpu_big1_s0>;
-};
-
-&cpu_l0 {
-	cpu-supply = <&vdd_cpu_lit_s0>;
-};
-
-&cpu_l1 {
-	cpu-supply = <&vdd_cpu_lit_s0>;
-};
-
-&cpu_l2 {
-	cpu-supply = <&vdd_cpu_lit_s0>;
-};
-
-&cpu_l3 {
-	cpu-supply = <&vdd_cpu_lit_s0>;
-};
-
-&gpu {
-	mali-supply = <&vdd_gpu_s0>;
-	status = "okay";
-};
-
-&hdmi0 {
-	status = "okay";
-};
-
-&hdmi0_in {
-	hdmi0_in_vp0: endpoint {
-		remote-endpoint = <&vp0_out_hdmi0>;
-	};
-};
-
-&hdmi0_out {
-	hdmi0_out_con: endpoint {
-		remote-endpoint = <&hdmi0_con_in>;
-	};
-};
-
-&hdmi0_sound {
-	status = "okay";
-};
-
-&hdmi1 {
-	pinctrl-0 = <&hdmim0_tx1_cec &hdmim0_tx1_hpd
-		     &hdmim1_tx1_scl &hdmim1_tx1_sda>;
-	status = "okay";
-};
-
-&hdmi1_in {
-	hdmi1_in_vp1: endpoint {
-		remote-endpoint = <&vp1_out_hdmi1>;
-	};
-};
-
-&hdmi1_out {
-	hdmi1_out_con: endpoint {
-		remote-endpoint = <&hdmi1_con_in>;
-	};
-};
-
-&hdmi1_sound {
-	status = "okay";
-};
-
-&hdmi_receiver_cma {
-	status = "okay";
-};
-
-&hdmi_receiver {
-	hpd-gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
-	pinctrl-0 = <&hdmim1_rx_cec &hdmim1_rx_hpdin &hdmim1_rx_scl &hdmim1_rx_sda &hdmirx_hpd>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&hdptxphy0 {
-	status = "okay";
-};
-
-&hdptxphy1 {
-	status = "okay";
-};
-
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0m2_xfer>;
-	status = "okay";
-
-	vdd_cpu_big0_s0: regulator@42 {
-		compatible = "rockchip,rk8602";
-		reg = <0x42>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu_big0_s0";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <550000>;
-		regulator-max-microvolt = <1050000>;
-		regulator-ramp-delay = <2300>;
-		vin-supply = <&vcc5v0_sys>;
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
-	};
-
-	vdd_cpu_big1_s0: regulator@43 {
-		compatible = "rockchip,rk8603", "rockchip,rk8602";
-		reg = <0x43>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu_big1_s0";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <550000>;
-		regulator-max-microvolt = <1050000>;
-		regulator-ramp-delay = <2300>;
-		vin-supply = <&vcc5v0_sys>;
-
-		regulator-state-mem {
-			regulator-off-in-suspend;
-		};
-	};
-};
-
-&i2c6 {
-	status = "okay";
-
-	hym8563: rtc@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-output-names = "hym8563";
-		pinctrl-names = "default";
-		pinctrl-0 = <&hym8563_int>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
-		wakeup-source;
-	};
-};
-
-&i2c7 {
-	status = "okay";
-
-	es8316: audio-codec@11 {
-		compatible = "everest,es8316";
-		reg = <0x11>;
-		clocks = <&cru I2S0_8CH_MCLKOUT>;
-		clock-names = "mclk";
-		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
-		assigned-clock-rates = <12288000>;
-		#sound-dai-cells = <0>;
-
-		port {
-			es8316_p0_0: endpoint {
-				remote-endpoint = <&i2s0_8ch_p0_0>;
-			};
-		};
-	};
-};
-
-&i2s0_8ch {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2s0_lrck
-		     &i2s0_mclk
-		     &i2s0_sclk
-		     &i2s0_sdi0
-		     &i2s0_sdo0>;
-	status = "okay";
-
-	i2s0_8ch_p0: port {
-		i2s0_8ch_p0_0: endpoint {
-			dai-format = "i2s";
-			mclk-fs = <256>;
-			remote-endpoint = <&es8316_p0_0>;
-		};
-	};
-};
-
-&i2s5_8ch {
-	status = "okay";
-};
-
-&i2s6_8ch {
-	status = "okay";
-};
-
-&package_thermal {
-	polling-delay = <1000>;
-
-	trips {
-		package_fan0: package-fan0 {
-			temperature = <55000>;
-			hysteresis = <2000>;
-			type = "active";
-		};
-
-		package_fan1: package-fan1 {
-			temperature = <65000>;
-			hysteresis = <2000>;
-			type = "active";
-		};
-	};
-
-	cooling-maps {
-		map0 {
-			trip = <&package_fan0>;
-			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
-		};
-
-		map1 {
-			trip = <&package_fan1>;
-			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
-		};
-	};
-};
-
-&pcie2x1l0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_0_rst>;
-	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc3v3_pcie2x1l0>;
-	status = "okay";
-};
-
-&pcie2x1l2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie2_2_rst>;
-	reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc3v3_pcie2x1l2>;
-	status = "okay";
-};
-
-&pcie30phy {
-	status = "okay";
-};
-
-&pcie3x4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_rst>;
-	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc3v3_pcie30>;
-	status = "okay";
-};
-
-&pd_gpu {
-	domain-supply = <&vdd_gpu_s0>;
-};
-
-&pinctrl {
-	hdmirx {
-		hdmirx_hpd: hdmirx-5v-detection {
-			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	hym8563 {
-		hym8563_int: hym8563-int {
-			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	leds {
-		led_rgb_b: led-rgb-b {
-			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sound {
-		hp_detect: hp-detect {
-			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pcie2 {
-		pcie2_0_rst: pcie2-0-rst {
-			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
-			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		pcie2_2_rst: pcie2-2-rst {
-			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pcie3 {
-		pcie3_rst: pcie3-rst {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
-			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb {
-		vcc5v0_host_en: vcc5v0-host-en {
-			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&saradc {
-	vref-supply = <&avcc_1v8_s0>;
-	status = "okay";
-};
-
-&sdhci {
-	bus-width = <8>;
-	no-sdio;
-	no-sd;
-	non-removable;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	status = "okay";
-};
-
-&sdmmc {
-	max-frequency = <200000000>;
-	no-sdio;
-	no-mmc;
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
-	disable-wp;
-	sd-uhs-sdr104;
-	vmmc-supply = <&vcc_3v3_s3>;
-	vqmmc-supply = <&vccio_sd_s0>;
-	status = "okay";
 };
 
 &sdio {
@@ -551,435 +30,23 @@
 	status = "okay";
 };
 
-&sfc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&fspim2_pins>;
-	status = "okay";
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <104000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <1>;
-		vcc-supply = <&vcc_3v3_s3>;
-	};
-};
-
 &uart6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart6m1_xfer &uart6m1_ctsn &uart6m1_rtsn>;
 	status = "okay";
 };
 
-&spi2 {
-	status = "okay";
-	assigned-clocks = <&cru CLK_SPI2>;
-	assigned-clock-rates = <200000000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
-	num-cs = <1>;
-
-	pmic@0 {
-		compatible = "rockchip,rk806";
-		spi-max-frequency = <1000000>;
-		reg = <0x0>;
-
-		interrupt-parent = <&gpio0>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
-			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
-
-		system-power-controller;
-
-		vcc1-supply = <&vcc5v0_sys>;
-		vcc2-supply = <&vcc5v0_sys>;
-		vcc3-supply = <&vcc5v0_sys>;
-		vcc4-supply = <&vcc5v0_sys>;
-		vcc5-supply = <&vcc5v0_sys>;
-		vcc6-supply = <&vcc5v0_sys>;
-		vcc7-supply = <&vcc5v0_sys>;
-		vcc8-supply = <&vcc5v0_sys>;
-		vcc9-supply = <&vcc5v0_sys>;
-		vcc10-supply = <&vcc5v0_sys>;
-		vcc11-supply = <&vcc_2v0_pldo_s3>;
-		vcc12-supply = <&vcc5v0_sys>;
-		vcc13-supply = <&vcc_1v1_nldo_s3>;
-		vcc14-supply = <&vcc_1v1_nldo_s3>;
-		vcca-supply = <&vcc5v0_sys>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl1";
-			function = "pin_fun0";
-		};
-
-		rk806_dvs2_null: dvs2-null-pins {
-			pins = "gpio_pwrctrl2";
-			function = "pin_fun0";
-		};
-
-		rk806_dvs3_null: dvs3-null-pins {
-			pins = "gpio_pwrctrl3";
-			function = "pin_fun0";
-		};
-
-		regulators {
-			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
-				regulator-boot-on;
-				regulator-min-microvolt = <550000>;
-				regulator-max-microvolt = <950000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_gpu_s0";
-				regulator-enable-ramp-delay = <400>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <550000>;
-				regulator-max-microvolt = <950000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_cpu_lit_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_log_s0: dcdc-reg3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <675000>;
-				regulator-max-microvolt = <750000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_log_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <750000>;
-				};
-			};
-
-			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <550000>;
-				regulator-max-microvolt = <950000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_vdenc_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_ddr_s0: dcdc-reg5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <675000>;
-				regulator-max-microvolt = <900000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_ddr_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <850000>;
-				};
-			};
-
-			vdd2_ddr_s3: dcdc-reg6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vdd2_ddr_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_2v0_pldo_s3: dcdc-reg7 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <2000000>;
-				regulator-max-microvolt = <2000000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vdd_2v0_pldo_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <2000000>;
-				};
-			};
-
-			vcc_3v3_s3: dcdc-reg8 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_3v3_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vddq_ddr_s0: dcdc-reg9 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vddq_ddr_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_1v8_s3: dcdc-reg10 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc_1v8_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			avcc_1v8_s0: pldo-reg1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "avcc_1v8_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_1v8_s0: pldo-reg2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc_1v8_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			avdd_1v2_s0: pldo-reg3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-name = "avdd_1v2_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_3v3_s0: pldo-reg4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vcc_3v3_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vccio_sd_s0: pldo-reg5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-ramp-delay = <12500>;
-				regulator-name = "vccio_sd_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			pldo6_s3: pldo-reg6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "pldo6_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vdd_0v75_s3: nldo-reg1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
-				regulator-name = "vdd_0v75_s3";
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <750000>;
-				};
-			};
-
-			vdd_ddr_pll_s0: nldo-reg2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <850000>;
-				regulator-name = "vdd_ddr_pll_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <850000>;
-				};
-			};
-
-			avdd_0v75_s0: nldo-reg3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
-				regulator-name = "avdd_0v75_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_0v85_s0: nldo-reg4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <850000>;
-				regulator-name = "vdd_0v85_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_0v75_s0: nldo-reg5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <750000>;
-				regulator-name = "vdd_0v75_s0";
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
+&pinctrl {
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 };
 
-&tsadc {
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-0 = <&uart2m0_xfer>;
-	status = "okay";
-};
-
-&u2phy1 {
-	status = "okay";
-};
-
-&u2phy1_otg {
-	status = "okay";
-};
-
-&u2phy2 {
-	status = "okay";
-};
-
-&u2phy2_host {
-	/* connected to USB hub, which is powered by vcc5v0_sys */
-	phy-supply = <&vcc5v0_sys>;
-	status = "okay";
-};
-
-&u2phy3 {
-	status = "okay";
-};
-
-&u2phy3_host {
-	phy-supply = <&vcc5v0_host>;
-	status = "okay";
-};
-
-&usbdp_phy1 {
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host0_ohci {
-	status = "okay";
-};
-
-&usb_host1_ehci {
-	status = "okay";
-};
-
-&usb_host1_ohci {
-	status = "okay";
-};
-
-&usb_host1_xhci {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usb_host2_xhci {
-	status = "okay";
-};
-
-&vop {
-	status = "okay";
-};
-
-&vop_mmu {
-	status = "okay";
-};
-
-&vp0 {
-	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
-		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
-		remote-endpoint = <&hdmi0_in_vp0>;
-	};
-};
-
-&vp1 {
-	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
-		reg = <ROCKCHIP_VOP2_EP_HDMI1>;
-		remote-endpoint = <&hdmi1_in_vp1>;
-	};
+&vcc5v0_host {
+	enable-active-high;
+	gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc5v0_host_en>;
 };
diff --git a/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dtsi b/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dtsi
new file mode 100644
index 000000000000..6052787d2560
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3588-rock-5b.dtsi
@@ -0,0 +1,945 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3588.dtsi"
+
+/ {
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	analog-sound {
+		compatible = "audio-graph-card";
+		label = "rk3588-es8316";
+
+		widgets = "Microphone", "Mic Jack",
+			  "Headphone", "Headphones";
+
+		routing = "MIC2", "Mic Jack",
+			  "Headphones", "HPOL",
+			  "Headphones", "HPOR";
+
+		dais = <&i2s0_8ch_p0>;
+		hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_detect>;
+	};
+
+	hdmi0-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi0_con_in: endpoint {
+				remote-endpoint = <&hdmi0_out_con>;
+			};
+		};
+	};
+
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&hdmi1_out_con>;
+			};
+		};
+	};
+
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
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 120 150 180 210 240 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pwms = <&pwm1 0 50000 0>;
+		#cooling-cells = <2>;
+	};
+
+	rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-m2-wlan";
+		radio-type = "wlan";
+		shutdown-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	};
+
+	rfkill-bt {
+		compatible = "rfkill-gpio";
+		label = "rfkill-m2-bt";
+		radio-type = "bluetooth";
+		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
+	};
+
+	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
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
+	vcc3v3_pcie2x1l2: regulator-vcc3v3-pcie2x1l2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie2x1l2";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
+	vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
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
+	vcc5v0_host: regulator-vcc5v0-host {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_host";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_sys: regulator-vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v1_nldo_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&combphy0_ps {
+	status = "okay";
+};
+
+&combphy1_ps {
+	status = "okay";
+};
+
+&combphy2_psu {
+	status = "okay";
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	status = "okay";
+};
+
+&hdmi0 {
+	status = "okay";
+};
+
+&hdmi0_in {
+	hdmi0_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi0>;
+	};
+};
+
+&hdmi0_out {
+	hdmi0_out_con: endpoint {
+		remote-endpoint = <&hdmi0_con_in>;
+	};
+};
+
+&hdmi0_sound {
+	status = "okay";
+};
+
+&hdmi1 {
+	pinctrl-0 = <&hdmim0_tx1_cec &hdmim0_tx1_hpd
+		     &hdmim1_tx1_scl &hdmim1_tx1_sda>;
+	status = "okay";
+};
+
+&hdmi1_in {
+	hdmi1_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_hdmi1>;
+	};
+};
+
+&hdmi1_out {
+	hdmi1_out_con: endpoint {
+		remote-endpoint = <&hdmi1_con_in>;
+	};
+};
+
+&hdmi1_sound {
+	status = "okay";
+};
+
+&hdmi_receiver_cma {
+	status = "okay";
+};
+
+&hdmi_receiver {
+	hpd-gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&hdmim1_rx_cec &hdmim1_rx_hpdin &hdmim1_rx_scl &hdmim1_rx_sda &hdmirx_hpd>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&hdptxphy0 {
+	status = "okay";
+};
+
+&hdptxphy1 {
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0m2_xfer>;
+	status = "okay";
+
+	vdd_cpu_big0_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big0_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_cpu_big1_s0: regulator@43 {
+		compatible = "rockchip,rk8603", "rockchip,rk8602";
+		reg = <0x43>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big1_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-source;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	es8316: audio-codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru I2S0_8CH_MCLKOUT>;
+		clock-names = "mclk";
+		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
+		assigned-clock-rates = <12288000>;
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s0_8ch_p0_0>;
+			};
+		};
+	};
+};
+
+&i2s0_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s0_lrck
+		     &i2s0_mclk
+		     &i2s0_sclk
+		     &i2s0_sdi0
+		     &i2s0_sdo0>;
+	status = "okay";
+
+	i2s0_8ch_p0: port {
+		i2s0_8ch_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&es8316_p0_0>;
+		};
+	};
+};
+
+&i2s5_8ch {
+	status = "okay";
+};
+
+&i2s6_8ch {
+	status = "okay";
+};
+
+&package_thermal {
+	polling-delay = <1000>;
+
+	trips {
+		package_fan0: package-fan0 {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		package_fan1: package-fan1 {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map1 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
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
+&pd_gpu {
+	domain-supply = <&vdd_gpu_s0>;
+};
+
+&pinctrl {
+	hdmirx {
+		hdmirx_hpd: hdmirx-5v-detection {
+			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		led_rgb_b: led-rgb-b {
+			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sound {
+		hp_detect: hp-detect {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
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
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&avcc_1v8_s0>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	status = "okay";
+};
+
+&sdmmc {
+	max-frequency = <200000000>;
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vccio_sd_s0>;
+	status = "okay";
+};
+
+&sfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspim2_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+		vcc-supply = <&vcc_3v3_s3>;
+	};
+};
+
+&spi2 {
+	status = "okay";
+	assigned-clocks = <&cru CLK_SPI2>;
+	assigned-clock-rates = <200000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
+	num-cs = <1>;
+
+	pmic@0 {
+		compatible = "rockchip,rk806";
+		spi-max-frequency = <1000000>;
+		reg = <0x0>;
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
+			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
+
+		system-power-controller;
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc5v0_sys>;
+		vcc6-supply = <&vcc5v0_sys>;
+		vcc7-supply = <&vcc5v0_sys>;
+		vcc8-supply = <&vcc5v0_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+		vcc10-supply = <&vcc5v0_sys>;
+		vcc11-supply = <&vcc_2v0_pldo_s3>;
+		vcc12-supply = <&vcc5v0_sys>;
+		vcc13-supply = <&vcc_1v1_nldo_s3>;
+		vcc14-supply = <&vcc_1v1_nldo_s3>;
+		vcca-supply = <&vcc5v0_sys>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		rk806_dvs1_null: dvs1-null-pins {
+			pins = "gpio_pwrctrl1";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs2_null: dvs2-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs3_null: dvs3-null-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun0";
+		};
+
+		regulators {
+			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_gpu_s0";
+				regulator-enable-ramp-delay = <400>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_cpu_lit_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_log_s0: dcdc-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <750000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_log_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_vdenc_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_ddr_s0: dcdc-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <900000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_ddr_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			vdd2_ddr_s3: dcdc-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vdd2_ddr_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_2v0_pldo_s3: dcdc-reg7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_2v0_pldo_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <2000000>;
+				};
+			};
+
+			vcc_3v3_s3: dcdc-reg8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_3v3_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vddq_ddr_s0: dcdc-reg9 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vddq_ddr_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s3: dcdc-reg10 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			avcc_1v8_s0: pldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "avcc_1v8_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s0: pldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			avdd_1v2_s0: pldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "avdd_1v2_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3_s0: pldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vcc_3v3_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd_s0: pldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vccio_sd_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			pldo6_s3: pldo-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "pldo6_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_0v75_s3: nldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "vdd_0v75_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdd_ddr_pll_s0: nldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-name = "vdd_ddr_pll_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			avdd_0v75_s0: nldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "avdd_0v75_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_0v85_s0: nldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-name = "vdd_0v85_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_0v75_s0: nldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "vdd_0v75_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&tsadc {
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	/* connected to USB hub, which is powered by vcc5v0_sys */
+	phy-supply = <&vcc5v0_sys>;
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy3_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb_host2_xhci {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi0_in_vp0>;
+	};
+};
+
+&vp1 {
+	vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI1>;
+		remote-endpoint = <&hdmi1_in_vp1>;
+	};
+};
-- 
2.49.0

