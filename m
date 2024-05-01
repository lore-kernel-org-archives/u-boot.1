Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617DFC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 16:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5C088B8D;
	Wed,  1 May 2024 18:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bYWJpYn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E3788B4B; Wed,  1 May 2024 18:24:07 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857A288B8D
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 18:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=373c=MF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714580621; bh=P+pPIA5jxb86lOc5BTr95Ig97uAbrBYTpqchHU+NPbM=;
 b=bYWJpYn0h3lqSisODwl9Ufsowfs9ttcARiFXXl6+BLnKm9ola/QbZXyl7hcVVlnv0+ugFw4CZ
 tuOjAIPCWKvi3tWyGpDSUUqKZk9XP6R3725n9DBOMNBK/eUemUNAEocIT/JsWXrYKRCSVcbx5ME
 jkvKARsIlT3G/X32Sa+nr0yuU4sqMpdd17SwoqD16eNzF9OB/VjFjxn0FrcgloHrOl/4ifzA2+3
 PuDc7esdNQeN2unZqsw3njgOZJmBW/bMtKADIiAoU5JKaaapeVQS72n2YAKulOdyLzeShpOio0+
 WqFNZXIa4hFwN8DTsfVPolsy7UuuFN7Y8u17YxVvkNew==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Christopher Obbard
 <chris.obbard@collabora.com>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 07/22] rockchip: rk3399-puma: Sync DT from Linux kernel v6.8
Date: Wed,  1 May 2024 16:22:24 +0000
Message-ID: <20240501162308.875193-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501162308.875193-1-jonas@kwiboo.se>
References: <20240501162308.875193-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66326c8c3e72fadc559dba17
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

Sync rk3399-puma related device tree from Linux kernel v6.8.

The vdd_log node is already part of rk3399-puma.dtsi, only keep the
regulator-init-microvolt prop in u-boot.dtsi.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: The SPL_PAD_TO defconfig change was moved to own patch in part1
v2: Collect r-b tags
---
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 16 ++------
 arch/arm/dts/rk3399-puma-haikou.dts         | 42 ++++++++++++++++++---
 arch/arm/dts/rk3399-puma.dtsi               | 17 ++++++++-
 3 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
index 1930e5e10353..5a9bd320ec46 100644
--- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
@@ -30,18 +30,6 @@
 	aliases {
 		spi5 = &spi5;
 	};
-
-	vdd_log: vdd-log {
-		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 1>;
-		regulator-name = "vdd_log";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-init-microvolt = <950000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
 };
 
 &binman {
@@ -111,3 +99,7 @@
 	bootph-pre-sram;
 	bootph-pre-ram;
 };
+
+&vdd_log {
+	regulator-init-microvolt = <950000>;
+};
diff --git a/arch/arm/dts/rk3399-puma-haikou.dts b/arch/arm/dts/rk3399-puma-haikou.dts
index 115c14c0a3c6..18a98c4648ea 100644
--- a/arch/arm/dts/rk3399-puma-haikou.dts
+++ b/arch/arm/dts/rk3399-puma-haikou.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 #include "rk3399-puma.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Theobroma Systems RK3399-Q7 SoM";
@@ -18,6 +19,38 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&haikou_keys_pin>;
+		pinctrl-names = "default";
+
+		button-batlow-n {
+			gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
+			label = "BATLOW#";
+			linux,code = <KEY_BATTERY>;
+		};
+
+		button-slp-btn-n {
+			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_LOW>;
+			label = "SLP_BTN#";
+			linux,code = <KEY_SLEEP>;
+		};
+
+		button-wake-n {
+			gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_LOW>;
+			label = "WAKE#";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+
+		switch-lid-btn-n {
+			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+			label = "LID_BTN#";
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+		};
+	};
+
 	leds {
 		pinctrl-0 = <&module_led_pin>, <&sd_card_led_pin>;
 
@@ -165,11 +198,8 @@
 };
 
 &pinctrl {
-	pinctrl-names = "default";
-	pinctrl-0 = <&haikou_pin_hog>;
-
-	hog {
-		haikou_pin_hog: haikou-pin-hog {
+	buttons {
+		haikou_keys_pin: haikou-keys-pin {
 			rockchip,pins =
 			  /* LID_BTN */
 			  <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
@@ -177,7 +207,7 @@
 			  <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>,
 			  /* SLP_BTN# */
 			  <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_up>,
-			  /* BIOS_DISABLE# */
+			  /* WAKE# */
 			  <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
diff --git a/arch/arm/dts/rk3399-puma.dtsi b/arch/arm/dts/rk3399-puma.dtsi
index aa3e21bd6c8f..c08e69391c01 100644
--- a/arch/arm/dts/rk3399-puma.dtsi
+++ b/arch/arm/dts/rk3399-puma.dtsi
@@ -9,6 +9,7 @@
 
 / {
 	aliases {
+		ethernet0 = &gmac;
 		mmc0 = &sdhci;
 	};
 
@@ -27,7 +28,7 @@
 
 	extcon_usb3: extcon-usb3 {
 		compatible = "linux,extcon-usb-gpio";
-		id-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
+		id-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb3_id>;
 	};
@@ -119,6 +120,20 @@
 	drive-impedance-ohm = <33>;
 };
 
+&gpio0 {
+	/*
+	 * The BIOS_DISABLE hog is a feedback pin for the actual status of the
+	 * signal. This usually represents the state of a switch on the baseboard.
+	 * The pin has a 10k pull-up resistor connected, so no pull-up setting is needed.
+	 */
+	bios-disable-hog {
+		gpios = <RK_PB0 GPIO_ACTIVE_HIGH>;
+		gpio-hog;
+		input;
+		line-name = "bios_disable";
+	};
+};
+
 &gmac {
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
 	assigned-clock-parents = <&clkin_gmac>;
-- 
2.43.2

