Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A87E7718E
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 09:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCC5803D1;
	Thu, 26 Dec 2024 10:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FJlF4lgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33EF3803B9; Thu, 26 Dec 2024 10:21:03 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEFB80362
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=cnsztl@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21661be2c2dso64225505ad.1
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 01:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735204858; x=1735809658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FATTqR+sO8ZWykeKIfuycxHWNryNSyIBimnI5OasyM=;
 b=FJlF4lgdb0L8Gznu5CBP/8gnkIMa8GFpD+ohVNko/10FwfGOPcR2KfVVYgSTf+dTdN
 RjAi8ueL9LbgZlU5INsFYJzmVtaBRD6Z9FWjrUbYiZC2g6KCN/PaDZC3pC7Zbf69iilE
 H6Kw8iacdaXbCVMitcGNbCEKHqjCURWhW1F5lVPltlh05rgdHWf8w3WswCoyEiGUikrD
 gSbcb4WjgXIWksv4gOiOAdsHYyswQwj8YmMvIx0ODpXUgoujroDsb3PSI11PkrS8Y0HO
 MoF8oC7wV0TVQ68qJ9l9zyx5q/gnJ+aOm939Mu2gsyr0pDC/NJLnsr5yQtDJToTVA7cP
 HhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735204858; x=1735809658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FATTqR+sO8ZWykeKIfuycxHWNryNSyIBimnI5OasyM=;
 b=p0tbvID0Is40Ky26mZLp6oROJYTT4PazvvfoEOGdRLPyLzIhBArQJTXvgr8uStEip2
 /1mvTsj6F/yuN8OMAg59uhCdKNoS6TeA81A1cqJP/g/M8HMGN+lLbpgpMqlKYnFjCsWS
 hfeiR4RDn7Pi6HSSo9XUEvxvwnYIrfQXGLMP917EWuXXt/J0T0MUp6N8PuYIqlTityhd
 enTBauBDKxeHiOEFNv38SAsmBJ5ogFK4Ka+cJVfa3mMfn5B2jbgAGUTKbGCbI0OQjQY+
 HmuhjSngNyIHe/usmmfyMFrJ4Rak5CqNBLyxPKDrJhxZO9EmM68VHvK6Y4Y3adQNrp8o
 SB1w==
X-Gm-Message-State: AOJu0Yxd/xNboxfXDbjmGzeb5j34A0ZlsoX91zERQy74SCO5CFYZu61t
 f4M2boTnCpF2mq2+zDKbErXLgzFZaquW+wjiParHO3ZEGJc1Ok5u
X-Gm-Gg: ASbGncvhyVeG6aa47SrxwYwDM3q8qnf8GhbX1cA0IvjyGSCYY8FdGtaZFVURF1b3xlW
 Rq9iqPjNBGsLwyT+tm3mKxtlFK0emQJBxn+2nznWTmX2Oict6XwB/6TCXDVdPEH8LQhD3GiBOQ4
 Tl2ZUSGR3xIcJQWmE6wGlcUT/X65YxhHCmSpbiyN8O3ZmubJsUz1YUDTZjXSZwSCm22dmVXsd40
 B1ggXLO1Ag0dvZr/rIy0EZNQAJr3Makp2WI7TMhdkOBqduhv4wC1JNjGwM=
X-Google-Smtp-Source: AGHT+IGC9MOXIiH1QmobKag1PZn3P55hiwV2oe/SsV0PjdFnZumYd41sxsN5Un+ExwD+NAxRyR2xYQ==
X-Received: by 2002:a17:902:f681:b0:215:4394:40b5 with SMTP id
 d9443c01a7336-219e6f0e622mr314636385ad.43.1735204858012; 
 Thu, 26 Dec 2024 01:20:58 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8362:245d:5fa2:bc4b:53ff:fead:2725])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d948fsm116347985ad.150.2024.12.26.01.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 01:20:57 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/7] arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
Date: Thu, 26 Dec 2024 17:20:37 +0800
Message-ID: <20241226092043.419511-2-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241226092043.419511-1-cnsztl@gmail.com>
References: <20241226092043.419511-1-cnsztl@gmail.com>
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

The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
Ethernet ports designed and developed by FriendlyElec for IoT
applications.

Specification:
- Rockchip RK3566
- 2GB LPDDR4X RAM
- optional 32GB eMMC module
- SD card slot
- 2x 1000 Base-T
- 3x LEDs (POWER, LAN, WAN)
- 2x Buttons (Reset, MaskROM)
- 1x USB 3.0 Port
- Type-C 5V 2A Power

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20241020173946.225960-2-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 50decd493c8394c52d04561fe4ede34df27a46ba ]

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 .../src/arm64/rockchip/rk3566-nanopi-r3s.dts  | 554 ++++++++++++++++++
 1 file changed, 554 insertions(+)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts

diff --git a/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
new file mode 100644
index 0000000000..a7a55d68db
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3566-nanopi-r3s.dts
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2020 Rockchip Electronics Co., Ltd.
+ *
+ * Copyright (c) 2024 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * Copyright (c) 2024 Tianling Shen <cnsztl@gmail.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3566.dtsi"
+
+/ {
+	model = "FriendlyARM NanoPi R3S";
+	compatible = "friendlyarm,nanopi-r3s", "rockchip,rk3566";
+
+	aliases {
+		ethernet0 = &gmac1;
+		mmc0 = &sdmmc0;
+		mmc1 = &sdhci;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&reset_button_pin>;
+
+		button-reset {
+			label = "reset";
+			gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+			debounce-interval = <50>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&power_led_pin>, <&lan_led_pin>, <&wan_led_pin>;
+
+		power_led: led-0 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		lan_led: led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
+		};
+
+		wan_led: led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
+			gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	vcc3v3_sys: regulator-vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
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
+		vin-supply = <&vdd_usbc>;
+	};
+
+	vcc5v0_usb: regulator-vcc5v0_usb {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_host_en>;
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vdd_usbc: regulator-vdd-usbc {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usbc";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&combphy1 {
+	status = "okay";
+};
+
+&combphy2 {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-mode = "rgmii-id";
+	phy-handle = <&rgmii_phy1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m0_miim
+		     &gmac1m0_tx_bus2_level3
+		     &gmac1m0_rx_bus2
+		     &gmac1m0_rgmii_clk_level2
+		     &gmac1m0_rgmii_bus_level3>;
+	snps,reset-gpio = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 20ms, 100ms for rtl8211f */
+	snps,reset-delays-us = <0 20000 100000>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	vdd_cpu: regulator@1c {
+		compatible = "tcs,tcs4525";
+		reg = <0x1c>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		system-power-controller;
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		wakeup-source;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-name = "vdd_gpu";
+				regulator-always-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_npu: DCDC_REG4 {
+				regulator-name = "vdd_npu";
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG5 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_image: LDO_REG1 {
+				regulator-name = "vdda0v9_image";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <950000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-name = "vdda_0v9";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-name = "vdda0v9_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-name = "vccio_acodec";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-name = "vcc3v3_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG7 {
+				regulator-name = "vcca_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-name = "vcca1v8_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca1v8_image: LDO_REG9 {
+				regulator-name = "vcca1v8_image";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-name = "vcc3v3_sd";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
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
+		interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-source;
+	};
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&eth_phy_reset_pin>;
+	};
+};
+
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_reset_h>;
+	reset-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pinctrl {
+	gpio-leds {
+		lan_led_pin: lan-led-pin {
+			rockchip,pins = <3 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		power_led_pin: power-led-pin {
+			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wan_led_pin: wan-led-pin {
+			rockchip,pins = <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	gmac {
+		eth_phy_reset_pin: eth-phy-reset-pin {
+			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	pcie {
+		pcie_reset_h: pcie-reset-h {
+			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	rockchip-key {
+		reset_button_pin: reset-button-pin {
+			rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	rtc {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	usb {
+		vcc5v0_usb_host_en: vcc5v0-usb-host-en {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	status = "okay";
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio2-supply = <&vcc_1v8>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_3v3>;
+	vccio5-supply = <&vcc_1v8>;
+	vccio6-supply = <&vcc_3v3>;
+	vccio7-supply = <&vcc_3v3>;
+};
+
+&sdhci {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	no-sdio;
+	no-mmc;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr50;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&tsadc {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	extcon = <&usb2phy0>;
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
-- 
2.47.0

