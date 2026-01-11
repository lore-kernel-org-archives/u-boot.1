Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ABFD2502E
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 16:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8717583CAA;
	Sun, 11 Jan 2026 17:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fkqN98M2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD5183A79; Sun, 11 Jan 2026 17:31:45 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED6D883CAA
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 17:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64b5b68a9bdso1082742a12.3
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768149101; x=1768753901; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D8+DcyPfs9WNGuau8sW0ZEc0aCCRQJRGJTtz98QoeBI=;
 b=fkqN98M2m/xLjmTMqC9MD3zta5b1ciHBbInpjkPBVoRFkMQzDQCwU/6N9lGLyLPCw7
 KbMtIZJ3kG8DPqJOLq7q/5pPHP4+c8CRCC4Di0WLXd82RrXUDxB3Urgz/SlBPWY/AB0e
 ScxXRjYEUlLHEjSdP0oBTK2D9OVRAoZrXzK8Sh24la7kNEhisxYAFMgdLDLLhkBiAvqW
 Uybf+MhZ2Efz2UjWXW5ujvVTbv7yBGvwy7/Ah5KRcRLRX19J1PXhLPdri2y7kbaFHuWB
 hxFE9TIIkTISM+tmFdVsBvUsl5+lfQRMGPjI+KMAX5IPC3pyrsDOGZ1RN0tRqbq7SVqQ
 9Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768149101; x=1768753901;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D8+DcyPfs9WNGuau8sW0ZEc0aCCRQJRGJTtz98QoeBI=;
 b=DYqhL5wNDPWrJ0i2W/GyecboCLqrZvcsyViTNm9FdQ7c+ODL1263//Ss3uD0Y98k9Y
 XsaxwWRbmo1DAx/2bMz4wt0c35sFyCPMSXD7b+V6GQQ3yQ/eysbvwhNPh7QMAVr9v7KT
 RacxSrNIALqwwxM7Al9hrXZWqBBKeoKEkedb9X5pkrwTQeyll7YV+SMUrqRMFP3hkFWQ
 TafynsE4QLS//IFc6a/g97W9haVPg7MccNC1CznzTAnmDsxUGHevswj0QVLFUVcua6Sf
 1ipighGvV8SLjvJHv719o+3Lt0+dKWUlvmNaisYNRBiefvu6zAUmpbsqxK9xn8vIDoJa
 /LcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4EHP/iCRFDXyPs1IA9/timwG64bMyUYXHrQYRePGt7lR20I80H+sQQ6F7GRCiwC8VhhSTsMM=@lists.denx.de
X-Gm-Message-State: AOJu0YxLml8YtKNs7T1grs3K69vlwRKUC3NALsgAIBFnj8uhaCd/iWyB
 UkVA2UUg7dxXGCwCQFmywClBcSD6rmG+VXkCtPztYF1TwYSh8Cpl1Gqq
X-Gm-Gg: AY/fxX6T9lWpfTX16rE3cTroFl63ST2D84b/AeGcu1G563QxjhzrCOA0Mf+GeIeSCuS
 TFJUjFdBV0igq6d7N7eS40OL/4voYwtW6Qqd6qvyPmLXqFwhhoj4ZbtWbvqN6hB5duCRbPQN8A8
 8mXKY2Z2r6T9vJhvw7iXub6YIgW29s0S2B6A220T72q27TugmjfDfxZ6PmvvBQLyFen8jtu33lj
 QJv9PXSUBfpkfFr6MjOT1rID8yzQhw1QWIOgeC8pDR6mG5EmbVSOvNmdkr76poyXNbnJx7HtDoU
 XaSiP/TdK/atGcJogQWbYypwFmMVTON6QqGVU4qwCyAky8cMO43D3PSuTzCXZnIs4qpC7kzuMKO
 h42JrZuf++W2VzgOIQ0EoqBkAdaON8n8RixW2eVUiQ2z0pcvt5dtF/uoXZ/Cje7zjp9IJynxYjF
 XbjG0TvGf5J3dWVUt+ox4KnfLCBLYzKdejObzKxEUjLwL38uYPJA==
X-Google-Smtp-Source: AGHT+IFSAXdSphtrLBB+vLY2p9Jp11KINzilPnSnpctw9YnXM2JuscCwRSJ4HcPfcV0rXZY9gPV99w==
X-Received: by 2002:a17:907:1c18:b0:b87:1eaf:3762 with SMTP id
 a640c23a62f3a-b871eaf3f94mr7109566b.7.1768149100595; 
 Sun, 11 Jan 2026 08:31:40 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b870813a9efsm258063466b.38.2026.01.11.08.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 08:31:40 -0800 (PST)
Message-ID: <35312f9b-becc-4630-846d-8c72fd2aa186@gmail.com>
Date: Sun, 11 Jan 2026 17:31:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 5/6] rockchip: Switch remaining rk3288 boards to upstream
 devicetree
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
Content-Language: en-US
In-Reply-To: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Switch remaining rk3288 boards to upstream devicetree.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 ...boot.dtsi => rk3288-evb-rk808-u-boot.dtsi} |   0
 arch/arm/dts/rk3288-evb.dts                   |  20 -
 arch/arm/dts/rk3288-evb.dtsi                  | 476 ---------------
 arch/arm/dts/rk3288-popmetal.dts              |  20 -
 arch/arm/dts/rk3288-popmetal.dtsi             | 547 ------------------
 arch/arm/dts/rk3288-rock-pi-n8.dts            |  17 -
 arch/arm/dts/rk3288-rock2-som.dtsi            | 278 ---------
 arch/arm/dts/rk3288-rock2-square.dts          | 181 ------
 arch/arm/dts/rk3288-vmarc-som.dtsi            | 361 ------------
 arch/arm/dts/rk3288-vyasa.dts                 | 473 ---------------
 .../dts/rockchip-radxa-dalang-carrier.dtsi    | 137 -----
 board/amarula/vyasa-rk3288/MAINTAINERS        |   1 -
 board/chipspark/popmetal_rk3288/MAINTAINERS   |   1 -
 board/radxa/rock2/MAINTAINERS                 |   1 -
 board/rockchip/evb_rk3288/MAINTAINERS         |   6 +-
 ...8_defconfig => evb-rk3288-rk808_defconfig} |   5 +-
 configs/phycore-rk3288_defconfig              |   2 +-
 configs/popmetal-rk3288_defconfig             |   5 +-
 configs/rock-pi-n8-rk3288_defconfig           |   3 +-
 configs/rock2_defconfig                       |   5 +-
 configs/vyasa-rk3288_defconfig                |   5 +-
 doc/board/rockchip/rockchip.rst               |   8 +-
 22 files changed, 22 insertions(+), 2530 deletions(-)
 rename arch/arm/dts/{rk3288-evb-u-boot.dtsi => rk3288-evb-rk808-u-boot.dtsi} (100%)
 delete mode 100644 arch/arm/dts/rk3288-evb.dts
 delete mode 100644 arch/arm/dts/rk3288-evb.dtsi
 delete mode 100644 arch/arm/dts/rk3288-popmetal.dts
 delete mode 100644 arch/arm/dts/rk3288-popmetal.dtsi
 delete mode 100644 arch/arm/dts/rk3288-rock-pi-n8.dts
 delete mode 100644 arch/arm/dts/rk3288-rock2-som.dtsi
 delete mode 100644 arch/arm/dts/rk3288-rock2-square.dts
 delete mode 100644 arch/arm/dts/rk3288-vmarc-som.dtsi
 delete mode 100644 arch/arm/dts/rk3288-vyasa.dts
 delete mode 100644 arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi
 rename configs/{evb-rk3288_defconfig => evb-rk3288-rk808_defconfig} (94%)

diff --git a/arch/arm/dts/rk3288-evb-u-boot.dtsi b/arch/arm/dts/rk3288-evb-rk808-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/rk3288-evb-u-boot.dtsi
rename to arch/arm/dts/rk3288-evb-rk808-u-boot.dtsi
diff --git a/arch/arm/dts/rk3288-evb.dts b/arch/arm/dts/rk3288-evb.dts
deleted file mode 100644
index bb24a96cddf7..000000000000
--- a/arch/arm/dts/rk3288-evb.dts
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-/dts-v1/;
-#include "rk3288-evb.dtsi"
-
-/ {
-	model = "Evb-RK3288";
-	compatible = "evb-rk3288,evb-rk3288", "rockchip,rk3288";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-};
-
-&pwm1 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3288-evb.dtsi b/arch/arm/dts/rk3288-evb.dtsi
deleted file mode 100644
index 0e347beb154d..000000000000
--- a/arch/arm/dts/rk3288-evb.dtsi
+++ /dev/null
@@ -1,476 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-#include "rk3288.dtsi"
-
-/ {
-	memory {
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	ext_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-	};
-
-	keys: gpio-keys {
-		compatible = "gpio-keys";
-
-		button@0 {
-			gpio-key,wakeup = <1>;
-			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
-			label = "GPIO Power";
-			linux,code = <116>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pwr_key>;
-		};
-	};
-
-	vcc_sys: vsys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vcc_flash: flash-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_flash";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_io>;
-	};
-
-	vcc_5v: usb-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vcc_host_5v: usb-host-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
-		regulator-name = "vcc_host_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		vin-supply = <&vcc_5v>;
-	};
-
-	vcc_otg_5v: usb-otg-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&otg_vbus_drv>;
-		regulator-name = "vcc_otg_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		vin-supply = <&vcc_5v>;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		power-supply = <&vcc_sys>;
-		enable-gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
-		brightness-levels = <
-			  0   1   2   3   4   5   6   7
-			  8   9  10  11  12  13  14  15
-			 16  17  18  19  20  21  22  23
-			 24  25  26  27  28  29  30  31
-			 32  33  34  35  36  37  38  39
-			 40  41  42  43  44  45  46  47
-			 48  49  50  51  52  53  54  55
-			 56  57  58  59  60  61  62  63
-			 64  65  66  67  68  69  70  71
-			 72  73  74  75  76  77  78  79
-			 80  81  82  83  84  85  86  87
-			 88  89  90  91  92  93  94  95
-			 96  97  98  99 100 101 102 103
-			104 105 106 107 108 109 110 111
-			112 113 114 115 116 117 118 119
-			120 121 122 123 124 125 126 127
-			128 129 130 131 132 133 134 135
-			136 137 138 139 140 141 142 143
-			144 145 146 147 148 149 150 151
-			152 153 154 155 156 157 158 159
-			160 161 162 163 164 165 166 167
-			168 169 170 171 172 173 174 175
-			176 177 178 179 180 181 182 183
-			184 185 186 187 188 189 190 191
-			192 193 194 195 196 197 198 199
-			200 201 202 203 204 205 206 207
-			208 209 210 211 212 213 214 215
-			216 217 218 219 220 221 222 223
-			224 225 226 227 228 229 230 231
-			232 233 234 235 236 237 238 239
-			240 241 242 243 244 245 246 247
-			248 249 250 251 252 253 254 255>;
-		default-brightness-level = <50>;
-		pwms = <&pwm0 0 25000 0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwm0_pin>;
-		pwm-delay-us = <10000>;
-		status = "disabled";
-	};
-
-	panel: panel {
-		compatible = "simple-panel";
-		power-supply = <&vcc_io>;
-		backlight = <&backlight>;
-		enable-gpios = <&gpio7 3 GPIO_ACTIVE_HIGH>;
-		status = "disabled";
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-};
-
-&emmc {
-	broken-cd;
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	disable-wp;
-	non-removable;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_pwr>, <&emmc_bus8>;
-	status = "okay";
-};
-
-&gmac {
-	phy-mode = "rgmii";
-	clock_in_out = "input";
-	snps,reset-gpio = <&gpio4 7 0>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>;
-	tx_delay = <0x30>;
-	rx_delay = <0x10>;
-	status = "okay";
-};
-
-&hdmi {
-	ddc-i2c-bus = <&i2c5>;
-	status = "okay";
-};
-
-&i2c0 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	vdd_cpu: syr827@40 {
-		compatible = "silergy,syr827";
-		fcs,suspend-voltage-selector = <1>;
-		reg = <0x40>;
-		regulator-name = "vdd_cpu";
-		regulator-min-microvolt = <850000>;
-		regulator-max-microvolt = <1350000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vdd_gpu: syr828@41 {
-		compatible = "silergy,syr828";
-		fcs,suspend-voltage-selector = <1>;
-		reg = <0x41>;
-		regulator-name = "vdd_gpu";
-		regulator-min-microvolt = <850000>;
-		regulator-max-microvolt = <1350000>;
-		regulator-always-on;
-		vin-supply = <&vcc_sys>;
-	};
-
-	hym8563: hym8563@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "xin32k";
-		interrupt-parent = <&gpio7>;
-		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&rtc_int>;
-	};
-
-	act8846: act8846@5a {
-		compatible = "active-semi,act8846";
-		reg = <0x5a>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwr_hold>;
-		system-power-controller;
-
-		regulators {
-			vcc_ddr: REG1 {
-				regulator-name = "vcc_ddr";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
-			};
-
-			vcc_io: REG2 {
-				regulator-name = "vcc_io";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_log: REG3 {
-				regulator-name = "vdd_log";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-			};
-
-			vcc_20: REG4 {
-				regulator-name = "vcc_20";
-				regulator-min-microvolt = <2000000>;
-				regulator-max-microvolt = <2000000>;
-				regulator-always-on;
-			};
-
-			vccio_sd: REG5 {
-				regulator-name = "vccio_sd";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd10_lcd: REG6 {
-				regulator-name = "vdd10_lcd";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-			};
-
-			vcca_codec: REG7 {
-				regulator-name = "vcca_codec";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vcc_tp: REG8 {
-				regulator-name = "vcca_33";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vccio_pmu: REG9 {
-				regulator-name = "vccio_pmu";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			vdd_10: REG10 {
-				regulator-name = "vdd_10";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-			};
-
-			vcc_18: REG11 {
-				regulator-name = "vcc_18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			vcc18_lcd: REG12 {
-				regulator-name = "vcc18_lcd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&pinctrl {
-	pcfg_output_high: pcfg-output-high {
-		output-high;
-	};
-
-	pcfg_output_low: pcfg-output-low {
-		output-low;
-	};
-
-	act8846 {
-		pwr_hold: pwr-hold {
-			rockchip,pins = <0 9 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	hym8563 {
-		rtc_int: rtc-int {
-			rockchip,pins = <0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	keys {
-		pwr_key: pwr-key {
-			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	sdmmc {
-		sdmmc_pwr: sdmmc-pwr {
-			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_host {
-		host_vbus_drv: host-vbus-drv {
-			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_otg {
-		otg_vbus_drv: otg-vbus-drv {
-			rockchip,pins = <0 12 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&pwm0 {
-	status = "okay";
-};
-
-&saradc {
-	vref-supply = <&vcc_18>;
-	status = "okay";
-};
-
-&sdio0 {
-	broken-cd;
-	bus-width = <4>;
-	disable-wp;
-	non-removable;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
-	vmmc-supply = <&vcc_18>;
-	status = "disabled";
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	card-detect-delay = <200>;
-	disable-wp;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
-	vmmc-supply = <&vccio_sd>;
-	status = "okay";
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_clk>, <&spi0_cs0>, <&spi0_tx>, <&spi0_rx>, <&spi0_cs1>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&uart3 {
-	status = "okay";
-};
-
-&usb_host1 {
-	status = "okay";
-};
-
-&usb_otg {
-	status = "okay";
-};
-
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&vopl {
-	status = "okay";
-};
-
-&vopl_mmu {
-	status = "okay";
-};
-
-&mipi_dsi {
-	status = "disabled";
-	rockchip,panel = <&panel>;
-	display-timings {
-		timing0 {
-		bits-per-pixel = <24>;
-		clock-frequency = <160000000>;
-		hfront-porch = <120>;
-		hsync-len = <20>;
-		hback-porch = <21>;
-		hactive = <1200>;
-		vfront-porch = <21>;
-		vsync-len = <3>;
-		vback-porch = <18>;
-		vactive = <1920>;
-		hsync-active = <0>;
-		vsync-active = <0>;
-		de-active = <1>;
-		pixelclk-active = <0>;
-		};
-	};
-};
-
-&wdt {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3288-popmetal.dts b/arch/arm/dts/rk3288-popmetal.dts
deleted file mode 100644
index 736dc51e2615..000000000000
--- a/arch/arm/dts/rk3288-popmetal.dts
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-/dts-v1/;
-#include "rk3288-popmetal.dtsi"
-
-/ {
-	model = "PopMetal-RK3288";
-	compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-};
-
-&pwm1 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3288-popmetal.dtsi b/arch/arm/dts/rk3288-popmetal.dtsi
deleted file mode 100644
index ecff641b1099..000000000000
--- a/arch/arm/dts/rk3288-popmetal.dtsi
+++ /dev/null
@@ -1,547 +0,0 @@
-/*
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *  Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include <dt-bindings/input/input.h>
-#include "rk3288.dtsi"
-
-/ {
-	memory{
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	ext_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-		#clock-cells = <0>;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		autorepeat;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pwrbtn>;
-
-		power {
-			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
-			label = "GPIO Key Power";
-			linux,code = <KEY_POWER>;
-			linux,input-type = <1>;
-			wakeup-source;
-			debounce-interval = <100>;
-		};
-	};
-
-	ir: ir-receiver {
-		compatible = "gpio-ir-receiver";
-		gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ir_int>;
-	};
-
-	vcc_flash: flash-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_flash";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_io>;
-	};
-
-	vcc_sd: sdmmc-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_pwr>;
-		regulator-name = "vcc_sd";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <100000>;
-		vin-supply = <&vcc_io>;
-	};
-
-	vcc_sys: vsys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	/*
-	 * A PT5128 creates both dovdd_1v8 and vcc28_dvp, controlled
-	 * by the dvp_pwr pin.
-	 */
-	vcc18_dvp: vcc18-dvp-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc18-dvp";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc28_dvp>;
-	};
-
-	vcc28_dvp: vcc28-dvp-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&dvp_pwr>;
-		regulator-name = "vcc28_dvp";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		regulator-always-on;
-		vin-supply = <&vcc_io>;
-	};
-
-	vcc5v0_host: usb-host-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
-		regulator-name = "vcc5v0_host";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-};
-
-&emmc {
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	disable-wp;
-	non-removable;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
-	vmmc-supply = <&vcc_io>;
-	vqmmc-supply = <&vcc_flash>;
-	status = "okay";
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	card-detect-delay = <200>;
-	disable-wp;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
-	vmmc-supply = <&vcc_sd>;
-	vqmmc-supply = <&vccio_sd>;
-	status = "okay";
-};
-
-&gmac {
-	phy-supply = <&vcc_lan>;
-	phy-mode = "rgmii";
-	clock_in_out = "input";
-	snps,reset-gpio = <&gpio4 7 0>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>;
-	tx_delay = <0x30>;
-	rx_delay = <0x10>;
-	status = "okay";
-};
-
-&hdmi {
-	ddc-i2c-bus = <&i2c5>;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	rk808: pmic@1b {
-		compatible = "rockchip,rk808";
-		reg = <0x1b>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int &global_pwroff>;
-		rockchip,system-power-controller;
-		wakeup-source;
-		#clock-cells = <1>;
-		clock-output-names = "xin32k", "rk808-clkout2";
-
-		vcc1-supply = <&vcc_sys>;
-		vcc2-supply = <&vcc_sys>;
-		vcc3-supply = <&vcc_sys>;
-		vcc4-supply = <&vcc_sys>;
-		vcc6-supply = <&vcc_sys>;
-		vcc7-supply = <&vcc_sys>;
-		vcc8-supply = <&vcc_18>;
-		vcc9-supply = <&vcc_io>;
-		vcc10-supply = <&vcc_io>;
-		vcc11-supply = <&vcc_sys>;
-		vcc12-supply = <&vcc_io>;
-		vddio-supply = <&vcc_io>;
-
-		regulators {
-			vdd_cpu: DCDC_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-name = "vdd_arm";
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_gpu: DCDC_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1250000>;
-				regulator-name = "vdd_gpu";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc_ddr";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_io: DCDC_REG4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_io";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_lan: LDO_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_lan";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vccio_sd: LDO_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vccio_sd";
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_10: LDO_REG3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "vdd_10";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc18_lcd: LDO_REG4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc18_lcd";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			ldo5: LDO_REG5 {
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "ldo5";
-			};
-
-			vdd10_lcd: LDO_REG6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "vdd10_lcd";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_18: LDO_REG7 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-name = "vcc_18";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcca_33: LDO_REG8 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcca_33";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vccio_wl: SWITCH_REG1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vccio_wl";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_lcd: SWITCH_REG2 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-name = "vcc_lcd";
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-		};
-	};
-};
-
-&i2c1 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	ak8963: ak8963@0d {
-		compatible = "asahi-kasei,ak8975";
-		reg = <0x0d>;
-		interrupt-parent = <&gpio8>;
-		interrupts = <1 IRQ_TYPE_EDGE_RISING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&comp_int>;
-	};
-
-	l3g4200d: l3g4200d@68 {
-		compatible = "st,l3g4200d-gyro";
-		st,drdy-int-pin = <2>;
-		reg = <0x6b>;
-	};
-
-	mma8452: mma8452@1d {
-		compatible = "fsl,mma8452";
-		reg = <0x1d>;
-		interrupt-parent = <&gpio8>;
-		interrupts = <0 IRQ_TYPE_EDGE_RISING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&gsensor_int>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&io_domains {
-	audio-supply = <&vcca_33>;
-	bb-supply = <&vcc_io>;
-	dvp-supply = <&vcc18_dvp>;
-	flash0-supply = <&vcc_flash>;
-	flash1-supply = <&vcc_lan>;
-	gpio30-supply = <&vcc_io>;
-	gpio1830-supply = <&vcc_io>;
-	lcdc-supply = <&vcc_io>;
-	sdcard-supply = <&vccio_sd>;
-	wifi-supply = <&vccio_wl>;
-	status = "okay";
-};
-
-&pinctrl {
-	ak8963 {
-		comp_int: comp-int {
-			rockchip,pins = <8 1 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	buttons {
-		pwrbtn: pwrbtn {
-			rockchip,pins = <0 5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	dvp {
-		dvp_pwr: dvp-pwr {
-			rockchip,pins = <0 17 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	ir {
-		ir_int: ir-int {
-			rockchip,pins = <0 6 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	mma8452 {
-		gsensor_int: gsensor-int {
-			rockchip,pins = <8 0 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	pmic {
-		pmic_int: pmic-int {
-			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	sdmmc {
-		sdmmc_pwr: sdmmc-pwr {
-			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_host {
-		host_vbus_drv: host-vbus-drv {
-			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&saradc {
-	status = "okay";
-};
-
-&tsadc {
-	rockchip,hw-tshut-mode = <0>;
-	rockchip,hw-tshut-polarity = <0>;
-	status = "okay";
-};
-
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&vopl {
-	status = "okay";
-};
-
-&vopl_mmu {
-	status = "okay";
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&uart3 {
-	status = "okay";
-};
-
-&uart4 {
-	status = "okay";
-};
-
-&usb_host1 {
-	vbus-supply = <&vcc5v0_host>;
-	status = "okay";
-};
-
-&usbphy {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3288-rock-pi-n8.dts b/arch/arm/dts/rk3288-rock-pi-n8.dts
deleted file mode 100644
index c9894a60e703..000000000000
--- a/arch/arm/dts/rk3288-rock-pi-n8.dts
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
- * Copyright (c) 2019 Vamrs Limited
- * Copyright (c) 2019 Amarula Solutions(India)
- */
-
-/dts-v1/;
-#include "rk3288.dtsi"
-#include <rockchip-radxa-dalang-carrier.dtsi>
-#include "rk3288-vmarc-som.dtsi"
-
-/ {
-	model = "Radxa ROCK Pi N8";
-	compatible = "radxa,rockpi-n8", "vamrs,rk3288-vmarc-som",
-		     "rockchip,rk3288";
-};
diff --git a/arch/arm/dts/rk3288-rock2-som.dtsi b/arch/arm/dts/rk3288-rock2-som.dtsi
deleted file mode 100644
index 58e32fbb80f6..000000000000
--- a/arch/arm/dts/rk3288-rock2-som.dtsi
+++ /dev/null
@@ -1,278 +0,0 @@
-/*
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include <dt-bindings/pwm/pwm.h>
-#include "rk3288.dtsi"
-
-/ {
-	memory {
-		reg = <0x0 0x0 0x0 0x80000000>;
-		device_type = "memory";
-	};
-
-	emmc_pwrseq: emmc-pwrseq {
-		compatible = "mmc-pwrseq-emmc";
-		pinctrl-0 = <&emmc_reset>;
-		pinctrl-names = "default";
-		reset-gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
-	};
-
-	ext_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-	};
-
-	vcc_sys: vsys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-};
-
-&emmc {
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	disable-wp;
-	non-removable;
-	num-slots = <1>;
-	mmc-pwrseq = <&emmc_pwrseq>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
-	vmmc-supply = <&vcc_io>;
-	status = "okay";
-};
-
-&gmac {
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>;
-	clock_in_out = "input";
-	phy-mode = "rgmii";
-	phy-supply = <&vccio_pmu>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins &phy_rst>;
-	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 30000>;
-	rx_delay = <0x10>;
-	tx_delay = <0x30>;
-};
-
-&i2c0 {
-	status = "okay";
-
-	act8846: act8846@5a {
-		compatible = "active-semi,act8846";
-		reg = <0x5a>;
-		system-power-controller;
-		inl1-supply = <&vcc_io>;
-		inl2-supply = <&vcc_sys>;
-		inl3-supply = <&vcc_20>;
-		vp1-supply = <&vcc_sys>;
-		vp2-supply = <&vcc_sys>;
-		vp3-supply = <&vcc_sys>;
-		vp4-supply = <&vcc_sys>;
-
-		regulators {
-			vcc_ddr: REG1 {
-				regulator-name = "VCC_DDR";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-always-on;
-			};
-
-			vcc_io: REG2 {
-				regulator-name = "VCC_IO";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_log: REG3 {
-				regulator-name = "VDD_LOG";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-			};
-
-			vcc_20: REG4 {
-				regulator-name = "VCC_20";
-				regulator-min-microvolt = <2000000>;
-				regulator-max-microvolt = <2000000>;
-				regulator-always-on;
-			};
-
-			vccio_sd: REG5 {
-				regulator-name = "VCCIO_SD";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd10_lcd: REG6 {
-				regulator-name = "VDD10_LCD";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-			};
-
-			vcca_codec: REG7 {
-				regulator-name = "VCCA_CODEC";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vcca_tp: REG8 {
-				regulator-name = "VCCA_TP";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vccio_pmu: REG9 {
-				regulator-name = "VCCIO_PMU";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_10: REG10 {
-				regulator-name = "VDD_10";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-			};
-
-			vcc_18: REG11 {
-				regulator-name = "VCC_18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-
-			vcc18_lcd: REG12 {
-				regulator-name = "VCC18_LCD";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-			};
-		};
-	};
-
-	vdd_cpu: syr827@40 {
-		compatible = "silergy,syr827";
-		reg = <0x40>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-enable-ramp-delay = <300>;
-		regulator-name = "vdd_cpu";
-		regulator-min-microvolt = <850000>;
-		regulator-max-microvolt = <1350000>;
-		regulator-ramp-delay = <8000>;
-		vin-supply = <&vcc_sys>;
-	};
-
-	vdd_gpu: syr828@41 {
-		compatible = "silergy,syr828";
-		reg = <0x41>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-always-on;
-		regulator-enable-ramp-delay = <300>;
-		regulator-min-microvolt = <850000>;
-		regulator-max-microvolt = <1350000>;
-		regulator-name = "vdd_gpu";
-		regulator-ramp-delay = <8000>;
-		vin-supply = <&vcc_sys>;
-	};
-};
-
-&pinctrl {
-	pcfg_output_high: pcfg-output-high {
-		output-high;
-	};
-
-	emmc {
-			emmc_reset: emmc-reset {
-				rockchip,pins = <3 9 RK_FUNC_GPIO &pcfg_pull_none>;
-			};
-	};
-
-	gmac {
-		phy_rst: phy-rst {
-			rockchip,pins = <4 8 RK_FUNC_GPIO  &pcfg_output_high>;
-		};
-	};
-};
-
-&tsadc {
-	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
-	rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
-	status = "okay";
-};
-
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&vopl {
-	status = "okay";
-};
-
-&vopl_mmu {
-	status = "okay";
-};
-
-&wdt {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3288-rock2-square.dts b/arch/arm/dts/rk3288-rock2-square.dts
deleted file mode 100644
index 41676696ba33..000000000000
--- a/arch/arm/dts/rk3288-rock2-square.dts
+++ /dev/null
@@ -1,181 +0,0 @@
-/*
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/dts-v1/;
-#include "rk3288-rock2-som.dtsi"
-
-/ {
-	model = "Radxa Rock 2 Square";
-	compatible = "radxa,rock2-square", "rockchip,rk3288";
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	ir: ir-receiver {
-		compatible = "gpio-ir-receiver";
-		gpios = <&gpio8 1 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ir_int>;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "SPDIF";
-		simple-audio-card,dai-link@1 {  /* S/PDIF - S/PDIF */
-			cpu { sound-dai = <&spdif>; };
-			codec { sound-dai = <&spdif_out>; };
-		};
-	};
-
-	spdif_out: spdif-out {
-		compatible = "linux,spdif-dit";
-		#sound-dai-cells = <0>;
-	};
-
-	vcc_usb_host: vcc-host-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host_vbus_drv>;
-		/* Always on as the rockchip usb phy doesn't have a vbus-supply
-		 * property
-		 */
-		regulator-always-on;
-		regulator-name = "vcc_host";
-	};
-
-	vcc_sd: sdmmc-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_pwr>;
-		regulator-name = "vcc_sd";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_io>;
-	};
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	card-detect-delay = <200>;
-	disable-wp;	/* wp not hooked up */
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
-	vmmc-supply = <&vcc_sd>;
-	vqmmc-supply = <&vccio_sd>;
-	status = "okay";
-};
-
-&gmac {
-	status = "okay";
-};
-
-&hdmi {
-	ddc-i2c-bus = <&i2c5>;
-	status = "okay";
-};
-
-&i2c0 {
-	hym8563@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "xin32k";
-		interrupt-parent = <&gpio0>;
-		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>;
-
-	};
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&pinctrl {
-	ir {
-		ir_int: ir-int {
-			rockchip,pins = <8 1 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	pmic {
-		pmic_int: pmic-int {
-			rockchip,pins = <0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	usb {
-		host_vbus_drv: host-vbus-drv {
-			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sdmmc {
-		sdmmc_pwr: sdmmc-pwr {
-			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-};
-
-&spdif {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-	reg-shift = <2>;
-};
-
-&usbphy {
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3288-vmarc-som.dtsi b/arch/arm/dts/rk3288-vmarc-som.dtsi
deleted file mode 100644
index 793951655b73..000000000000
--- a/arch/arm/dts/rk3288-vmarc-som.dtsi
+++ /dev/null
@@ -1,361 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
- * Copyright (c) 2019 Vamrs Limited
- * Copyright (c) 2019 Amarula Solutions(India)
- */
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/rockchip.h>
-
-/ {
-	compatible = "vamrs,rk3288-vmarc-som", "rockchip,rk3288";
-
-	vccio_flash: vccio-flash-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vccio_flash";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_io>;
-	};
-};
-
-&emmc {
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	disable-wp;
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
-	vmmc-supply = <&vcc_io>;
-	vqmmc-supply = <&vccio_flash>;
-	status = "okay";
-};
-
-&gmac {
-	assigned-clocks = <&cru SCLK_MAC>;
-	phy-supply = <&vcc_io>;
-	snps,reset-gpio = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
-};
-
-&hdmi {
-	ddc-i2c-bus = <&i2c5>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&hdmi_cec_c0>;
-};
-
-&i2c0 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	rk808: pmic@1b {
-		compatible = "rockchip,rk808";
-		reg = <0x1b>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int &global_pwroff>;
-		rockchip,system-power-controller;
-		wakeup-source;
-		#clock-cells = <1>;
-		clock-output-names = "rk808-clkout1", "rk808-clkout2";
-
-		vcc1-supply = <&vcc5v0_sys>;
-		vcc2-supply = <&vcc5v0_sys>;
-		vcc3-supply = <&vcc5v0_sys>;
-		vcc4-supply = <&vcc5v0_sys>;
-		vcc6-supply = <&vcc5v0_sys>;
-		vcc7-supply = <&vcc5v0_sys>;
-		vcc8-supply = <&vcc_io>;
-		vcc9-supply = <&vcc_io>;
-		vcc10-supply = <&vcc5v0_sys>;
-		vcc11-supply = <&vcc5v0_sys>;
-		vcc12-supply = <&vcc_io>;
-		vddio-supply = <&vcc_io>;
-
-		regulators {
-			vdd_cpu: DCDC_REG1 {
-				regulator-name = "vdd_arm";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_gpu: DCDC_REG2 {
-				regulator-name = "vdd_gpu";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1250000>;
-				regulator-ramp-delay = <6000>;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_io: DCDC_REG4 {
-				regulator-name = "vcc_io";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_tp: LDO_REG1 {
-				regulator-name = "vcc_tp";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcca_codec: LDO_REG2 {
-				regulator-name = "vcca_codec";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vdd_10: LDO_REG3 {
-				regulator-name = "vdd_10";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_wl: LDO_REG4 {
-				regulator-name = "vcc_wl";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vdd10_lcd: LDO_REG6 {
-				regulator-name = "vdd10_lcd";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_18: LDO_REG7 {
-				regulator-name = "vcc_18";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc18_lcd: LDO_REG8 {
-				regulator-name = "vcc18_lcd";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_sd: SWITCH_REG1 {
-				regulator-name = "vcc_sd";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vcc_lcd: SWITCH_REG2 {
-				regulator-name = "vcc_lcd";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	hym8563: rtc@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
-		#clock-cells = <0>;
-		clock-output-names = "hym8563";
-		pinctrl-names = "default";
-		pinctrl-0 = <&hym8563_int>;
-	};
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&io_domains {
-	bb-supply = <&vcc_io>;
-	flash0-supply = <&vccio_flash>;
-	gpio1830-supply = <&vcc_18>;
-	gpio30-supply = <&vcc_io>;
-	sdcard-supply = <&vccio_sd>;
-	wifi-supply = <&vcc_wl>;
-	status = "okay";
-};
-
-&pinctrl {
-	hym8563 {
-		hym8563_int: hym8563-int {
-			rockchip,pins = <5 RK_PC3 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
-		drive-strength = <8>;
-	};
-
-	pcfg_pull_up_drv_8ma: pcfg-pull-up-drv-8ma {
-		bias-pull-up;
-		drive-strength = <8>;
-	};
-
-	pmic {
-		pmic_int: pmic-int {
-			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	sdio-pwrseq {
-		wifi_enable_h: wifi-enable-h {
-			rockchip,pins = <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sdmmc {
-		sdmmc_bus4: sdmmc-bus4 {
-			rockchip,pins =
-				<6 RK_PC0 1 &pcfg_pull_up_drv_8ma>,
-				<6 RK_PC1 1 &pcfg_pull_up_drv_8ma>,
-				<6 RK_PC2 1 &pcfg_pull_up_drv_8ma>,
-				<6 RK_PC3 1 &pcfg_pull_up_drv_8ma>;
-		};
-
-		sdmmc_clk: sdmmc-clk {
-			rockchip,pins = <6 RK_PC4 1 &pcfg_pull_none_drv_8ma>;
-		};
-
-		sdmmc_cmd: sdmmc-cmd {
-			rockchip,pins = <6 RK_PC5 1 &pcfg_pull_up_drv_8ma>;
-		};
-	};
-
-	vbus_host {
-		usb1_en_oc: usb1-en-oc {
-			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	vbus_typec {
-		usb0_en_oc: usb0-en-oc {
-			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-};
-
-&sdio_pwrseq {
-	/*
-	 * On the module itself this is one of these (depending
-	 * on the actual card populated):
-	 * - SDIO_RESET_L_WL_REG_ON
-	 * - PDN (power down when low)
-	 */
-	reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;	/* WIFI_REG_ON */
-};
-
-&usbphy {
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
-&usb_host1 {
-	status = "okay";
-};
-
-&usb_otg {
-	status = "okay";
-};
-
-&vbus_host {
-	enable-active-high;
-	gpio = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>; /* USB1_EN_OC# */
-};
-
-&vbus_typec {
-	enable-active-high;
-	gpio = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>; /* USB0_EN_OC# */
-};
diff --git a/arch/arm/dts/rk3288-vyasa.dts b/arch/arm/dts/rk3288-vyasa.dts
deleted file mode 100644
index 4193f7208cd0..000000000000
--- a/arch/arm/dts/rk3288-vyasa.dts
+++ /dev/null
@@ -1,473 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2017 Jagan Teki <jagan@amarulasolutions.com>
- */
-
-/dts-v1/;
-#include "rk3288.dtsi"
-
-/ {
-	model = "Amarula Vyasa-RK3288";
-	compatible = "amarula,vyasa-rk3288", "rockchip,rk3288";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	memory {
-		reg = <0x0 0x0 0x0 0x80000000>;
-		device_type = "memory";
-	};
-
-	dc12_vbat: dc12-vbat {
-		compatible = "regulator-fixed";
-		regulator-name = "dc12_vbat";
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vboot_3v3: vboot-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vboot_3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&dc12_vbat>;
-	};
-
-	vcc_sys: vsys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <3700000>;
-		regulator-max-microvolt = <3700000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&dc12_vbat>;
-	};
-
-	vboot_5v: vboot-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "vboot_sv";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&dc12_vbat>;
-	};
-
-	v3g_3v3: v3g-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "v3g_3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&dc12_vbat>;
-	};
-
-	vsus_5v: vsus-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "vsus_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_io>;
-	};
-
-	vcc50_hdmi: vcc50-hdmi {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc50_hdmi";
-		enable-active-high;
-		gpio = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>; /* HDMI_EN */
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc50_hdmi_en>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vsus_5v>;
-	};
-	vusb1_5v: vusb1-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "vusb1_5v";
-		enable-active-high;
-		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>; /* OTG_VBUS_DRV */
-		pinctrl-names = "default";
-		pinctrl-0 = <&otg_vbus_drv>;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vsus_5v>;
-	};
-
-	vusb2_5v: vusb2-5v {
-		compatible = "regulator-fixed";
-		regulator-name = "vusb2_5v";
-		enable-active-high;
-		gpio = <&gpio8 RK_PB1 GPIO_ACTIVE_HIGH>; /* USB2_PWR_EN */
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb2_pwr_en>;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vsus_5v>;
-	};
-
-	ext_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-};
-
-&emmc {
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
-	vmmc-supply = <&vcc_io>;
-	status = "okay";
-};
-
-&gmac {
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>;
-	clock_in_out = "input";
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
-	phy-supply = <&vcc_lan>;
-	phy-mode = "rgmii";
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
-	snps,reset-gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_LOW>;
-	tx_delay = <0x30>;
-	rx_delay = <0x10>;
-	status = "okay";
-};
-
-&gpu {
-	mali-supply = <&vdd_gpu>;
-	status = "okay";
-};
-
-&hdmi {
-	ddc-i2c-bus = <&i2c5>;
-	status = "okay";
-};
-
-&i2c0 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	rk808: pmic@1b {
-		compatible = "rockchip,rk808";
-		reg = <0x1b>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA4 IRQ_TYPE_LEVEL_LOW>;
-		#clock-cells = <1>;
-		clock-output-names = "xin32k", "rk808-clkout2";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int &global_pwroff>;
-		rockchip,system-power-controller;
-		wakeup-source;
-
-		vcc1-supply = <&vcc_sys>;
-		vcc2-supply = <&vcc_sys>;
-		vcc3-supply = <&vcc_sys>;
-		vcc4-supply = <&vcc_sys>;
-		vcc6-supply = <&vcc_sys>;
-		vcc7-supply = <&vcc_sys>;
-		vcc8-supply = <&vcc_io>;
-		vcc9-supply = <&vcc_sys>;
-		vcc10-supply = <&vcc_sys>;
-		vcc11-supply = <&vcc_sys>;
-		vcc12-supply = <&vcc_io>;
-
-		regulators {
-			vdd_cpu: DCDC_REG1 {
-				regulator-name = "vdd_arm";
-				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_gpu: DCDC_REG2 {
-				regulator-name = "vdd_gpu";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1250000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_io: DCDC_REG4 {
-				regulator-name = "vcc_io";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcca_tp: LDO_REG1 {
-				regulator-name = "vcc_tp";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_codec: LDO_REG2 {
-				regulator-name = "vcc_codec";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_10: LDO_REG3 {
-				regulator-name = "vdd_10";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_gps: LDO_REG4 {
-				regulator-name = "vcc_gps";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vdd10_lcd: LDO_REG6 {
-				regulator-name = "vdd10_lcd";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc_18: LDO_REG7 {
-				regulator-name = "vcc_18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc18_lcd: LDO_REG8 {
-				regulator-name = "vcc18_lcd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vcc_sd: SWITCH_REG1 {
-				regulator-name = "vcc_sd";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_lan: SWITCH_REG2 {
-				regulator-name = "vcc_lan";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-		};
-	};
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	card-detect-delay = <200>;
-	disable-wp;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
-	vmmc-supply = <&vcc_sd>;
-	vqmmc-supply = <&vccio_sd>;
-	status = "okay";
-};
-
-&tsadc {
-	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
-	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&usbphy {
-	status = "okay";
-};
-
-&usb_host0_ehci {
-	status = "okay";
-};
-
-&usb_host1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&phy_pwr_en>;
-	status = "okay";
-};
-
-&usb_otg {
-	status = "okay";
-};
-
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&vopl {
-	status = "okay";
-};
-
-&vopl_mmu {
-	status = "okay";
-};
-
-&wdt {
-	status = "okay";
-};
-
-&pinctrl {
-	pcfg_output_high: pcfg-output-high {
-		output-high;
-	};
-
-	gmac {
-		phy_int: phy-int {
-			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		phy_pmeb: phy-pmeb {
-			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		phy_rst: phy-rst {
-			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	hdmi {
-		vcc50_hdmi_en: vcc50-hdmi-en {
-			rockchip,pins = <7 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		pmic_int: pmic-int {
-			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	usb_host {
-		phy_pwr_en: phy-pwr-en {
-			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-
-		usb2_pwr_en: usb2-pwr-en {
-			rockchip,pins = <8 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_otg {
-		otg_vbus_drv: otg-vbus-drv {
-			rockchip,pins = <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
-
-		};
-	};
-};
diff --git a/arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi b/arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi
deleted file mode 100644
index da1d548b7330..000000000000
--- a/arch/arm/dts/rockchip-radxa-dalang-carrier.dtsi
+++ /dev/null
@@ -1,137 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd
- * Copyright (c) 2019 Radxa Limited
- * Copyright (c) 2019 Amarula Solutions(India)
- */
-
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	clkin_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <125000000>;
-		clock-output-names = "clkin_gmac";
-		#clock-cells = <0>;
-	};
-
-	sdio_pwrseq: sdio-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		clocks = <&hym8563>;
-		clock-names = "ext_clock";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_enable_h>;
-	};
-
-	vcc12v_dcin: vcc12v-dcin-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_dcin";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-	};
-
-	vcc5v0_sys: vcc5v0-sys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc12v_dcin>;
-	};
-
-	vbus_host: vbus-host {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb1_en_oc>;
-		regulator-name = "vbus_host"; /* HOST-5V */
-		regulator-always-on;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vbus_typec: vbus-typec {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb0_en_oc>;
-		regulator-name = "vbus_typec";
-		regulator-always-on;
-		vin-supply = <&vcc5v0_sys>;
-	};
-};
-
-&gmac {
-	assigned-clock-parents = <&clkin_gmac>;
-	clock_in_out = "input";
-	phy-mode = "rgmii";
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins>;
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 50000>;
-	tx_delay = <0x28>;
-	rx_delay = <0x11>;
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&pwm0 {
-	status = "okay";
-};
-
-&pwm2 {
-	status = "okay";
-};
-
-&sdio0 {
-	bus-width = <4>;
-	cap-sd-highspeed;
-	cap-sdio-irq;
-	keep-power-in-suspend;
-	mmc-pwrseq = <&sdio_pwrseq>;
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
-	sd-uhs-sdr104;
-	status = "okay";
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	disable-wp;
-	vqmmc-supply = <&vccio_sd>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts>;
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&vopl {
-	status = "okay";
-};
-
-&vopl_mmu {
-	status = "okay";
-};
diff --git a/board/amarula/vyasa-rk3288/MAINTAINERS b/board/amarula/vyasa-rk3288/MAINTAINERS
index 08ea208004a2..d9cf639a31d2 100644
--- a/board/amarula/vyasa-rk3288/MAINTAINERS
+++ b/board/amarula/vyasa-rk3288/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 F:	board/amarula/vyasa-rk3288
 F:	include/configs/vyasa-rk3288.h
 F:	configs/vyasa-rk3288_defconfig
-F:	arch/arm/dts/rk3288-vyasa.dts
 F:	arch/arm/dts/rk3288-vyasa-u-boot.dtsi
diff --git a/board/chipspark/popmetal_rk3288/MAINTAINERS b/board/chipspark/popmetal_rk3288/MAINTAINERS
index e12f128dcd70..c81905453f2f 100644
--- a/board/chipspark/popmetal_rk3288/MAINTAINERS
+++ b/board/chipspark/popmetal_rk3288/MAINTAINERS
@@ -1,7 +1,6 @@
 POPMETAL-RK3288
 M:	Lin Huang <hl@rock-chips.com>
 S:	Maintained
-F:	arch/arm/dts/rk3288-popmetal.dts
 F:	arch/arm/dts/rk3288-popmetal-u-boot.dtsi
 F:	board/chipspark/popmetal_rk3288
 F:	include/configs/popmetal_rk3288.h
diff --git a/board/radxa/rock2/MAINTAINERS b/board/radxa/rock2/MAINTAINERS
index af974c983047..a697e68281a4 100644
--- a/board/radxa/rock2/MAINTAINERS
+++ b/board/radxa/rock2/MAINTAINERS
@@ -1,7 +1,6 @@
 FIREFLY
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-F:	arch/arm/dts/rk3288-rock2*
 F:	board/radxa/rock2
 F:	include/configs/rock2.h
 F:	configs/rock2_defconfig
diff --git a/board/rockchip/evb_rk3288/MAINTAINERS b/board/rockchip/evb_rk3288/MAINTAINERS
index 9857ae335754..60f97d7eb3b9 100644
--- a/board/rockchip/evb_rk3288/MAINTAINERS
+++ b/board/rockchip/evb_rk3288/MAINTAINERS
@@ -1,12 +1,10 @@
 EVB-RK3288
 M:	Lin Huang <hl@rock-chips.com>
 S:	Maintained
-F:	arch/arm/dts/rk3288-evb.dts
-F:	arch/arm/dts/rk3288-evb.dtsi
-F:	arch/arm/dts/rk3288-evb-u-boot.dtsi
+F:	arch/arm/dts/rk3288-evb-rk808-u-boot.dtsi
 F:	board/rockchip/evb_rk3288
 F:	include/configs/evb_rk3288.h
-F:	configs/evb-rk3288_defconfig
+F:	configs/evb-rk3288-rk808_defconfig

 ROCK-PI-N8
 M:	Jagan Teki <jagan@amarulasolutions.com>
diff --git a/configs/evb-rk3288_defconfig b/configs/evb-rk3288-rk808_defconfig
similarity index 94%
rename from configs/evb-rk3288_defconfig
rename to configs/evb-rk3288-rk808_defconfig
index 02347b58c229..8e140d6e41cd 100644
--- a/configs/evb-rk3288_defconfig
+++ b/configs/evb-rk3288-rk808_defconfig
@@ -9,7 +9,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-evb"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-evb-rk808"
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
@@ -29,7 +29,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3288-evb-rk808.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-evb-rk808.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_NO_BSS_LIMIT=y
@@ -52,6 +52,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index ee9cc2bd8222..461fa5d432a8 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -26,7 +26,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_LTO=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3288-phycore-rdk.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-phycore-rdk.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_CONSOLE_MUX=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index 95c1097bc93e..4489c0393501 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -8,7 +8,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-popmetal"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-popmetal"
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -25,7 +25,7 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3288-popmetal.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-popmetal.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_CONSOLE_MUX=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -47,6 +47,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index 0a88037cefdb..ae2f9e9bb17f 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -10,7 +10,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-rock-pi-n8"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-rock-pi-n8"
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
@@ -45,6 +45,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index 35f449ab567e..dd296efaf1ad 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -8,7 +8,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-rock2-square"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-rock2-square"
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -25,7 +25,7 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3288-rock2-square.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-rock2-square.dtb"
 CONFIG_SILENT_CONSOLE=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -47,6 +47,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index c9de6f8ad26c..8ac1c9620c65 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -11,7 +11,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-vyasa"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-vyasa"
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
@@ -26,7 +26,7 @@ CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 CONFIG_USE_PREBOOT=y
-CONFIG_DEFAULT_FDT_FILE="rk3288-vyasa.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-vyasa.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_NO_BSS_LIMIT=y
@@ -53,6 +53,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 6ae4d4371ff6..08ab2ac69e50 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -40,15 +40,17 @@ List of mainline supported Rockchip boards:
 * rk3229
      - Rockchip Evb-RK3229 (evb-rk3229)
 * rk3288
-     - Rockchip Evb-RK3288 (evb-rk3288)
+     - Rockchip Evb-RK3288-rk808 (evb-rk3288-rk808)
      - Firefly-RK3288 (firefly-rk3288)
      - MQmaker MiQi (miqi-rk3288)
      - Phytec RK3288 PCM-947 (phycore-rk3288)
      - PopMetal-RK3288 (popmetal-rk3288)
      - Radxa Rock 2 Square (rock2)
+     - Radxa Rock Pi N8 (rock-pi-n8-rk3288)
      - Tinker-RK3288 (tinker-rk3288)
+     - Tinker-S-RK3288 (tinker-s-rk3288)
      - Google Jerry (chromebook_jerry)
-     - Google Mickey (chromebook_mickey)
+     - Google Mickey (chromebit_mickey)
      - Google Minnie (chromebook_minnie)
      - Google Speedy (chromebook_speedy)
      - Amarula Vyasa-RK3288 (vyasa-rk3288)
@@ -244,7 +246,7 @@ To build rk3288 boards:

 .. code-block:: bash

-        make evb-rk3288_defconfig
+        make evb-rk3288-mk808_defconfig
         make CROSS_COMPILE=arm-linux-gnueabihf-

 To build rk3308 boards:
--
2.39.5

