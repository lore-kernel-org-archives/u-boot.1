Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3F9C47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 22:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED23D87D69;
	Fri, 26 Jan 2024 23:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CISkU73h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C55287D48; Fri, 26 Jan 2024 23:15:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF68E87D57
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 23:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1706307338; bh=lqA6/5DDpY8tvBdG26kZCcB02LjalIxjqR0XdcZhLBI=;
 b=CISkU73hjQn6Y/25NnU48MxO26gw3yStIXFzo6pqmYlcIAjqb67+QuLOGNszdZef7GdDyb/X5
 OuceiR94lUAwlJojVkd0OH7e8pFFNLhFXQhuHx3rlW7GTp76ydsDAeJmZa70aR3M6vrDxrdscoU
 rpqpwDxTvMnRV6QMgU925RcBL9MkT87S9ANu7YuuaANLOPEv46FJzs5/LUg1BAJyeCoOmP30Jq9
 KJ0gDO/xc2vrRvqw3LnCxATxaM8mas/JuEr2GqkeGUYwKqFItw1YEI4Ly8a3zG4zYq0zL3/QQ/N
 rdgz6bit+lf5HYRxNtuwsnlvRUSgS0lm5XjPmeSKpv9A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@edgeble.ai>, John Clark <inindev@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Eugen
 Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
Subject: [PATCH 5/7] rockchip: rk3588: Sync device tree from linux v6.8-rc1
Date: Fri, 26 Jan 2024 22:14:53 +0000
Message-ID: <20240126221508.4093334-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126221508.4093334-1-jonas@kwiboo.se>
References: <20240126221508.4093334-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b42f090365e20062645638
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

Sync rk3588 device tree from linux v6.8-rc1.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-edgeble-neu6a-io.dts |   4 -
 arch/arm/dts/rk3588-edgeble-neu6b-io.dts |   6 +-
 arch/arm/dts/rk3588-evb1-v10.dts         |  99 ++++++++++++++++++-
 arch/arm/dts/rk3588-nanopc-t6.dts        |  10 +-
 arch/arm/dts/rk3588-orangepi-5-plus.dts  |   1 -
 arch/arm/dts/rk3588-quartzpro64.dts      |   2 +-
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi  |   8 --
 arch/arm/dts/rk3588-rock-5b.dts          |  13 ++-
 arch/arm/dts/rk3588-turing-rk1.dtsi      |   2 -
 arch/arm/dts/rk3588s-orangepi-5.dts      |   7 +-
 arch/arm/dts/rk3588s-rock-5a.dts         |  10 +-
 arch/arm/dts/rk3588s-u-boot.dtsi         |   5 -
 arch/arm/dts/rk3588s.dtsi                | 116 +++++++++++++++++++++++
 include/dt-bindings/soc/rockchip,vop2.h  |   4 +
 14 files changed, 251 insertions(+), 36 deletions(-)

diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io.dts b/arch/arm/dts/rk3588-edgeble-neu6a-io.dts
index b51543892078..be6a4f4f90f6 100644
--- a/arch/arm/dts/rk3588-edgeble-neu6a-io.dts
+++ b/arch/arm/dts/rk3588-edgeble-neu6a-io.dts
@@ -12,10 +12,6 @@
 	compatible = "edgeble,neural-compute-module-6a-io",
 		     "edgeble,neural-compute-module-6a", "rockchip,rk3588";
 
-	aliases {
-		serial2 = &uart2;
-	};
-
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io.dts b/arch/arm/dts/rk3588-edgeble-neu6b-io.dts
index 9933765e4097..070baeb63431 100644
--- a/arch/arm/dts/rk3588-edgeble-neu6b-io.dts
+++ b/arch/arm/dts/rk3588-edgeble-neu6b-io.dts
@@ -9,13 +9,9 @@
 
 / {
 	model = "Edgeble Neu6B IO Board";
-	compatible = "edgeble,neural-compute-module-6b-io",
+	compatible = "edgeble,neural-compute-module-6a-io",
 		     "edgeble,neural-compute-module-6b", "rockchip,rk3588";
 
-	aliases {
-		serial2 = &uart2;
-	};
-
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
diff --git a/arch/arm/dts/rk3588-evb1-v10.dts b/arch/arm/dts/rk3588-evb1-v10.dts
index b9d789d57862..ac7c677b0fb9 100644
--- a/arch/arm/dts/rk3588-evb1-v10.dts
+++ b/arch/arm/dts/rk3588-evb1-v10.dts
@@ -16,8 +16,8 @@
 	compatible = "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
 
 	aliases {
+		ethernet0 = &gmac0;
 		mmc0 = &sdhci;
-		serial2 = &uart2;
 	};
 
 	chosen {
@@ -56,6 +56,63 @@
 		};
 	};
 
+	analog-sound {
+		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_detect>;
+		simple-audio-card,name = "RK3588 EVB1 Audio";
+		simple-audio-card,aux-devs = <&amp_headphone>, <&amp_speaker>;
+		simple-audio-card,bitclock-master = <&masterdai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&masterdai>;
+		simple-audio-card,hp-det-gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,pin-switches = "Headphones", "Speaker";
+		simple-audio-card,routing =
+			"Speaker Amplifier INL", "LOUT2",
+			"Speaker Amplifier INR", "ROUT2",
+			"Speaker", "Speaker Amplifier OUTL",
+			"Speaker", "Speaker Amplifier OUTR",
+			"Headphones Amplifier INL", "LOUT1",
+			"Headphones Amplifier INR", "ROUT1",
+			"Headphones", "Headphones Amplifier OUTL",
+			"Headphones", "Headphones Amplifier OUTR",
+			"LINPUT1", "Onboard Microphone",
+			"RINPUT1", "Onboard Microphone",
+			"LINPUT2", "Microphone Jack",
+			"RINPUT2", "Microphone Jack";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Microphone", "Onboard Microphone",
+			"Headphone", "Headphones",
+			"Speaker", "Speaker";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0_8ch>;
+		};
+
+		masterdai: simple-audio-card,codec {
+			sound-dai = <&es8388>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+
+	amp_headphone: headphone-amplifier {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&headphone_amplifier_en>;
+		sound-name-prefix = "Headphones Amplifier";
+	};
+
+	amp_speaker: speaker-amplifier {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&speaker_amplifier_en>;
+		sound-name-prefix = "Speaker Amplifier";
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		power-supply = <&vcc12v_dcin>;
@@ -240,6 +297,32 @@
 	};
 };
 
+&i2c7 {
+	status = "okay";
+
+	es8388: audio-codec@11 {
+		compatible = "everest,es8388";
+		reg = <0x11>;
+		clocks = <&cru I2S0_8CH_MCLKOUT>;
+		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
+		assigned-clock-rates = <12288000>;
+		AVDD-supply = <&avcc_1v8_codec_s0>;
+		DVDD-supply = <&avcc_1v8_codec_s0>;
+		HPVDD-supply = <&vcc_3v3_s0>;
+		PVDD-supply = <&vcc_3v3_s0>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&i2s0_8ch {
+	pinctrl-0 = <&i2s0_lrck
+		     &i2s0_mclk
+		     &i2s0_sclk
+		     &i2s0_sdi0
+		     &i2s0_sdo0>;
+	status = "okay";
+};
+
 &mdio0 {
 	rgmii_phy: ethernet-phy@1 {
 		/* RTL8211F */
@@ -273,6 +356,20 @@
 };
 
 &pinctrl {
+	audio {
+		hp_detect: headphone-detect {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		headphone_amplifier_en: headphone-amplifier-en {
+			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		speaker_amplifier_en: speaker-amplifier-en {
+			rockchip,pins = <1 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	rtl8111 {
 		rtl8111_isolate: rtl8111-isolate {
 			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
diff --git a/arch/arm/dts/rk3588-nanopc-t6.dts b/arch/arm/dts/rk3588-nanopc-t6.dts
index 97af4f912828..d7722772ecd8 100644
--- a/arch/arm/dts/rk3588-nanopc-t6.dts
+++ b/arch/arm/dts/rk3588-nanopc-t6.dts
@@ -19,7 +19,6 @@
 	aliases {
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
-		serial2 = &uart2;
 	};
 
 	chosen {
@@ -537,13 +536,12 @@
 };
 
 &sdmmc {
-	max-frequency = <200000000>;
-	no-sdio;
-	no-mmc;
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	disable-wp;
+	no-mmc;
+	no-sdio;
 	sd-uhs-sdr104;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vccio_sd_s0>;
@@ -570,6 +568,8 @@
 		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 
+		system-power-controller;
+
 		vcc1-supply = <&vcc4v0_sys>;
 		vcc2-supply = <&vcc4v0_sys>;
 		vcc3-supply = <&vcc4v0_sys>;
@@ -590,7 +590,7 @@
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/arch/arm/dts/rk3588-orangepi-5-plus.dts b/arch/arm/dts/rk3588-orangepi-5-plus.dts
index 298c183d6f4f..3e660ff6cd5f 100644
--- a/arch/arm/dts/rk3588-orangepi-5-plus.dts
+++ b/arch/arm/dts/rk3588-orangepi-5-plus.dts
@@ -19,7 +19,6 @@
 	aliases {
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
-		serial2 = &uart2;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/rk3588-quartzpro64.dts b/arch/arm/dts/rk3588-quartzpro64.dts
index 5c59f9571dce..87a0abf95f7d 100644
--- a/arch/arm/dts/rk3588-quartzpro64.dts
+++ b/arch/arm/dts/rk3588-quartzpro64.dts
@@ -17,9 +17,9 @@
 	compatible = "pine64,quartzpro64", "rockchip,rk3588";
 
 	aliases {
+		ethernet0 = &gmac0;
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
-		serial2 = &uart2;
 	};
 
 	chosen {
diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index b595ddef7028..5fa20cecc044 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -21,10 +21,6 @@
 	};
 };
 
-&combphy2_psu {
-	status = "okay";
-};
-
 &fspim2_pins {
 	bootph-all;
 };
@@ -129,10 +125,6 @@
 	status = "okay";
 };
 
-&usb_host2_xhci {
-	status = "okay";
-};
-
 &i2c4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c4m1_xfer>;
diff --git a/arch/arm/dts/rk3588-rock-5b.dts b/arch/arm/dts/rk3588-rock-5b.dts
index 741f631db345..a0e303c3a1dc 100644
--- a/arch/arm/dts/rk3588-rock-5b.dts
+++ b/arch/arm/dts/rk3588-rock-5b.dts
@@ -14,7 +14,6 @@
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
 		mmc2 = &sdio;
-		serial2 = &uart2;
 	};
 
 	chosen {
@@ -138,6 +137,10 @@
 	status = "okay";
 };
 
+&combphy2_psu {
+	status = "okay";
+};
+
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
@@ -423,6 +426,8 @@
 		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 
+		system-power-controller;
+
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
 		vcc3-supply = <&vcc5v0_sys>;
@@ -443,7 +448,7 @@
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
@@ -765,3 +770,7 @@
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&usb_host2_xhci {
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588-turing-rk1.dtsi b/arch/arm/dts/rk3588-turing-rk1.dtsi
index d88c0e852356..dc08da518a76 100644
--- a/arch/arm/dts/rk3588-turing-rk1.dtsi
+++ b/arch/arm/dts/rk3588-turing-rk1.dtsi
@@ -19,8 +19,6 @@
 	aliases {
 		ethernet0 = &gmac1;
 		mmc0 = &sdhci;
-		serial2 = &uart2;
-		serial9 = &uart9;
 	};
 
 	fan: pwm-fan {
diff --git a/arch/arm/dts/rk3588s-orangepi-5.dts b/arch/arm/dts/rk3588s-orangepi-5.dts
index e3a839a12dc6..25de4362af38 100644
--- a/arch/arm/dts/rk3588s-orangepi-5.dts
+++ b/arch/arm/dts/rk3588s-orangepi-5.dts
@@ -13,8 +13,8 @@
 	compatible = "xunlong,orangepi-5", "rockchip,rk3588s";
 
 	aliases {
+		ethernet0 = &gmac1;
 		mmc0 = &sdmmc;
-		serial2 = &uart2;
 	};
 
 	chosen {
@@ -314,6 +314,7 @@
 		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
 				<&rk806_dvs2_null>, <&rk806_dvs3_null>;
 		spi-max-frequency = <1000000>;
+		system-power-controller;
 
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
@@ -660,3 +661,7 @@
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&usb_host2_xhci {
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588s-rock-5a.dts b/arch/arm/dts/rk3588s-rock-5a.dts
index 8347adcbd003..2002fd0221fa 100644
--- a/arch/arm/dts/rk3588s-rock-5a.dts
+++ b/arch/arm/dts/rk3588s-rock-5a.dts
@@ -12,9 +12,9 @@
 	compatible = "radxa,rock-5a", "rockchip,rk3588s";
 
 	aliases {
+		ethernet0 = &gmac1;
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
-		serial2 = &uart2;
 	};
 
 	analog-sound {
@@ -114,6 +114,10 @@
 	};
 };
 
+&combphy2_psu {
+	status = "okay";
+};
+
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
@@ -734,3 +738,7 @@
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&usb_host2_xhci {
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index ebee2131ceeb..d251a210b313 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -7,11 +7,6 @@
 
 / {
 	aliases {
-		spi0 = &spi0;
-		spi1 = &spi1;
-		spi2 = &spi2;
-		spi3 = &spi3;
-		spi4 = &spi4;
 		spi5 = &sfc;
 	};
 
diff --git a/arch/arm/dts/rk3588s.dtsi b/arch/arm/dts/rk3588s.dtsi
index 8aa0499f9b03..36b1b7acfe6a 100644
--- a/arch/arm/dts/rk3588s.dtsi
+++ b/arch/arm/dts/rk3588s.dtsi
@@ -18,6 +18,38 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi3 = &spi3;
+		spi4 = &spi4;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -362,6 +394,11 @@
 		#clock-cells = <0>;
 	};
 
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop_out>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
@@ -474,6 +511,16 @@
 		reg = <0x0 0xfd58c000 0x0 0x1000>;
 	};
 
+	vop_grf: syscon@fd5a4000 {
+		compatible = "rockchip,rk3588-vop-grf", "syscon";
+		reg = <0x0 0xfd5a4000 0x0 0x2000>;
+	};
+
+	vo1_grf: syscon@fd5a8000 {
+		compatible = "rockchip,rk3588-vo-grf", "syscon";
+		reg = <0x0 0xfd5a8000 0x0 0x100>;
+	};
+
 	php_grf: syscon@fd5b0000 {
 		compatible = "rockchip,rk3588-php-grf", "syscon";
 		reg = <0x0 0xfd5b0000 0x0 0x1000>;
@@ -593,6 +640,74 @@
 		status = "disabled";
 	};
 
+	vop: vop@fdd90000 {
+		compatible = "rockchip,rk3588-vop";
+		reg = <0x0 0xfdd90000 0x0 0x4200>, <0x0 0xfdd95000 0x0 0x1000>;
+		reg-names = "vop", "gamma-lut";
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_VOP>,
+			 <&cru HCLK_VOP>,
+			 <&cru DCLK_VOP0>,
+			 <&cru DCLK_VOP1>,
+			 <&cru DCLK_VOP2>,
+			 <&cru DCLK_VOP3>,
+			 <&cru PCLK_VOP_ROOT>;
+		clock-names = "aclk",
+			      "hclk",
+			      "dclk_vp0",
+			      "dclk_vp1",
+			      "dclk_vp2",
+			      "dclk_vp3",
+			      "pclk_vop";
+		iommus = <&vop_mmu>;
+		power-domains = <&power RK3588_PD_VOP>;
+		rockchip,grf = <&sys_grf>;
+		rockchip,vop-grf = <&vop_grf>;
+		rockchip,vo1-grf = <&vo1_grf>;
+		rockchip,pmu = <&pmu>;
+		status = "disabled";
+
+		vop_out: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			vp0: port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+			};
+
+			vp1: port@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+			};
+
+			vp2: port@2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;
+			};
+
+			vp3: port@3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+			};
+		};
+	};
+
+	vop_mmu: iommu@fdd97e00 {
+		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdd97e00 0x0 0x100>, <0x0 0xfdd97f00 0x0 0x100>;
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
+		clock-names = "aclk", "iface";
+		#iommu-cells = <0>;
+		power-domains = <&power RK3588_PD_VOP>;
+		status = "disabled";
+	};
+
 	uart0: serial@fd890000 {
 		compatible = "rockchip,rk3588-uart", "snps,dw-apb-uart";
 		reg = <0x0 0xfd890000 0x0 0x100>;
@@ -916,6 +1031,7 @@
 				reg = <RK3588_PD_USB>;
 				clocks = <&cru PCLK_PHP_ROOT>,
 					 <&cru ACLK_USB_ROOT>,
+					 <&cru ACLK_USB>,
 					 <&cru HCLK_USB_ROOT>,
 					 <&cru HCLK_HOST0>,
 					 <&cru HCLK_HOST_ARB0>,
diff --git a/include/dt-bindings/soc/rockchip,vop2.h b/include/dt-bindings/soc/rockchip,vop2.h
index 6e66a802b96a..668f199df9f0 100644
--- a/include/dt-bindings/soc/rockchip,vop2.h
+++ b/include/dt-bindings/soc/rockchip,vop2.h
@@ -10,5 +10,9 @@
 #define ROCKCHIP_VOP2_EP_LVDS0	5
 #define ROCKCHIP_VOP2_EP_MIPI1	6
 #define ROCKCHIP_VOP2_EP_LVDS1	7
+#define ROCKCHIP_VOP2_EP_HDMI1	8
+#define ROCKCHIP_VOP2_EP_EDP1	9
+#define ROCKCHIP_VOP2_EP_DP0	10
+#define ROCKCHIP_VOP2_EP_DP1	11
 
 #endif /* __DT_BINDINGS_ROCKCHIP_VOP2_H */
-- 
2.43.0

