Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6336DC02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 17:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9173980085;
	Sun, 19 Jan 2025 18:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A12C801CF; Sun, 19 Jan 2025 17:43:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 81B84805C5
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 17:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 666111424;
 Sun, 19 Jan 2025 08:44:04 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D981C3F66E;
 Sun, 19 Jan 2025 08:43:34 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] sunxi: switch Allwinner A10 boards to OF_UPSTREAM
Date: Sun, 19 Jan 2025 16:41:55 +0000
Message-ID: <20250119164157.23648-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250119164157.23648-1-andre.przywara@arm.com>
References: <20250119164157.23648-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 19 Jan 2025 18:17:31 +0100
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

In contrast to some other Allwinner SoCs, there is no difference between
the DTs for the Allwinner A10 SoCs (sun4i) between the U-Boot and the
Linux kernel repository.

Remove the old copies of the A10 related .dts and .dtsi files, and switch
most of sun4i boards over to use OF_UPSTREAM.

There are two boards for which we don't have DTs in the kernel tree.
Keep those two .dts files, plus the base .dtsi in the legacy U-Boot DT
directory, and let their defconfig opt out of OF_UPSTREAM.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/Makefile                         |  24 +-
 arch/arm/dts/sun4i-a10-a1000.dts              | 255 -------------
 arch/arm/dts/sun4i-a10-ba10-tvbox.dts         | 151 --------
 arch/arm/dts/sun4i-a10-chuwi-v7-cw0825.dts    | 159 --------
 arch/arm/dts/sun4i-a10-cubieboard.dts         | 255 -------------
 arch/arm/dts/sun4i-a10-dserve-dsrv9703c.dts   | 218 -----------
 arch/arm/dts/sun4i-a10-gemei-g9.dts           | 192 ----------
 arch/arm/dts/sun4i-a10-hackberry.dts          | 140 -------
 arch/arm/dts/sun4i-a10-hyundai-a7hd.dts       | 115 ------
 arch/arm/dts/sun4i-a10-inet1.dts              | 229 -----------
 arch/arm/dts/sun4i-a10-inet97fv2.dts          | 203 ----------
 arch/arm/dts/sun4i-a10-inet9f-rev03.dts       | 357 ------------------
 .../dts/sun4i-a10-itead-iteaduino-plus.dts    | 126 -------
 arch/arm/dts/sun4i-a10-jesurun-q5.dts         | 181 ---------
 arch/arm/dts/sun4i-a10-marsboard.dts          | 182 ---------
 arch/arm/dts/sun4i-a10-mini-xplus.dts         | 144 -------
 arch/arm/dts/sun4i-a10-mk802.dts              | 144 -------
 arch/arm/dts/sun4i-a10-mk802ii.dts            | 111 ------
 arch/arm/dts/sun4i-a10-olinuxino-lime.dts     | 225 -----------
 arch/arm/dts/sun4i-a10-pcduino.dts            | 200 ----------
 arch/arm/dts/sun4i-a10-pcduino2.dts           |  67 ----
 arch/arm/dts/sun4i-a10-pov-protab2-ips9.dts   | 206 ----------
 arch/arm/dts/sun4i-a10-topwise-a721.dts       | 242 ------------
 arch/arm/mach-sunxi/Kconfig                   |   1 +
 configs/A10-OLinuXino-Lime_defconfig          |   2 +-
 configs/Chuwi_V7_CW0825_defconfig             |   2 +-
 configs/Cubieboard_defconfig                  |   2 +-
 configs/Hyundai_A7HD_defconfig                |   2 +-
 configs/Linksprite_pcDuino_defconfig          |   2 +-
 configs/Marsboard_A10_defconfig               |   2 +-
 configs/Mele_A1000_defconfig                  |   2 +-
 configs/Mini-X_defconfig                      |   2 +-
 configs/ba10_tv_box_defconfig                 |   2 +-
 configs/dserve_dsrv9703c_defconfig            |   2 +-
 configs/iNet_3F_defconfig                     |   1 +
 configs/iNet_3W_defconfig                     |   1 +
 configs/inet1_defconfig                       |   2 +-
 configs/inet97fv2_defconfig                   |   2 +-
 configs/inet9f_rev03_defconfig                |   2 +-
 configs/jesurun_q5_defconfig                  |   2 +-
 configs/mk802_defconfig                       |   2 +-
 configs/mk802ii_defconfig                     |   2 +-
 configs/pov_protab2_ips9_defconfig            |   2 +-
 configs/sunxi_Gemei_G9_defconfig              |   2 +-
 44 files changed, 22 insertions(+), 4143 deletions(-)
 delete mode 100644 arch/arm/dts/sun4i-a10-a1000.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-ba10-tvbox.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-chuwi-v7-cw0825.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-cubieboard.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-dserve-dsrv9703c.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-gemei-g9.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-hackberry.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-hyundai-a7hd.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-inet1.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-inet97fv2.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-inet9f-rev03.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-itead-iteaduino-plus.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-jesurun-q5.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-marsboard.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-mini-xplus.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-mk802.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-mk802ii.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-olinuxino-lime.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-pcduino.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-pcduino2.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-pov-protab2-ips9.dts
 delete mode 100644 arch/arm/dts/sun4i-a10-topwise-a721.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 5627daa94db..6a483f6743c 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -531,30 +531,8 @@ dtb-$(CONFIG_STM32H7) += stm32h743i-disco.dtb \
 	stm32h750i-art-pi.dtb
 
 dtb-$(CONFIG_MACH_SUN4I) += \
-	sun4i-a10-a1000.dtb \
-	sun4i-a10-ba10-tvbox.dtb \
-	sun4i-a10-chuwi-v7-cw0825.dtb \
-	sun4i-a10-cubieboard.dtb \
-	sun4i-a10-dserve-dsrv9703c.dtb \
-	sun4i-a10-gemei-g9.dtb \
-	sun4i-a10-hackberry.dtb \
-	sun4i-a10-hyundai-a7hd.dtb \
-	sun4i-a10-inet1.dtb \
 	sun4i-a10-inet-3f.dtb \
-	sun4i-a10-inet-3w.dtb \
-	sun4i-a10-inet97fv2.dtb \
-	sun4i-a10-inet9f-rev03.dtb \
-	sun4i-a10-itead-iteaduino-plus.dtb \
-	sun4i-a10-jesurun-q5.dtb \
-	sun4i-a10-marsboard.dtb \
-	sun4i-a10-mini-xplus.dtb \
-	sun4i-a10-mk802.dtb \
-	sun4i-a10-mk802ii.dtb \
-	sun4i-a10-olinuxino-lime.dtb \
-	sun4i-a10-pcduino.dtb \
-	sun4i-a10-pcduino2.dtb \
-	sun4i-a10-pov-protab2-ips9.dtb \
-	sun4i-a10-topwise-a721.dtb
+	sun4i-a10-inet-3w.dtb
 dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a10s-auxtek-t003.dtb \
 	sun5i-a10s-auxtek-t004.dtb \
diff --git a/arch/arm/dts/sun4i-a10-a1000.dts b/arch/arm/dts/sun4i-a10-a1000.dts
deleted file mode 100644
index 20f9ed24485..00000000000
--- a/arch/arm/dts/sun4i-a10-a1000.dts
+++ /dev/null
@@ -1,255 +0,0 @@
-/*
- * Copyright 2013 Emilio López
- *
- * Emilio López <emilio@elopez.com.ar>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Mele A1000";
-	compatible = "mele,a1000", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	hdmi-connector {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con_in: endpoint {
-				remote-endpoint = <&hdmi_out_con>;
-			};
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			label = "a1000:red:usr";
-			gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-1 {
-			label = "a1000:blue:pwr";
-			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	reg_emac_3v3: emac-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "emac-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <20000>;
-		enable-active-high;
-		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>;
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "On-board SPDIF";
-
-		simple-audio-card,cpu {
-			sound-dai = <&spdif>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&spdif_out>;
-		};
-	};
-
-	spdif_out: spdif-out {
-		#sound-dai-cells = <0>;
-		compatible = "linux,spdif-dit";
-	};
-};
-
-&ahci {
-	status = "okay";
-};
-
-&codec {
-	status = "okay";
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&phy1>;
-	status = "okay";
-};
-
-&emac_sram {
-	status = "okay";
-};
-
-&de {
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&hdmi_out {
-	hdmi_out_con: endpoint {
-		remote-endpoint = <&hdmi_con_in>;
-	};
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		compatible = "x-powers,axp209";
-		reg = <0x34>;
-		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&ir0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins>;
-	status = "okay";
-};
-
-&mdio {
-	phy-supply = <&reg_emac_3v3>;
-	status = "okay";
-
-	phy1: ethernet-phy@1 {
-		reg = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-#include "axp209.dtsi"
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&spdif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spdif_tx_pin>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/dts/sun4i-a10-ba10-tvbox.dts
deleted file mode 100644
index 816d534ac09..00000000000
--- a/arch/arm/dts/sun4i-a10-ba10-tvbox.dts
+++ /dev/null
@@ -1,151 +0,0 @@
-/*
- * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "BA10 tvbox";
-	compatible = "allwinner,ba10-tvbox", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&phy1>;
-	status = "okay";
-};
-
-&emac_sram {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		compatible = "x-powers,axp209";
-		reg = <0x34>;
-		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&ir0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins>;
-	status = "okay";
-};
-
-&mdio {
-	status = "okay";
-
-	phy1: ethernet-phy@1 {
-		reg = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&reg_usb0_vbus {
-	regulator-boot-on;
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/dts/sun4i-a10-chuwi-v7-cw0825.dts
deleted file mode 100644
index 74262988881..00000000000
--- a/arch/arm/dts/sun4i-a10-chuwi-v7-cw0825.dts
+++ /dev/null
@@ -1,159 +0,0 @@
-/*
- * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "Chuwi V7 CW0825";
-	compatible = "chuwi,v7-cw0825", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		compatible = "x-powers,axp209";
-		reg = <0x34>;
-		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-
-	ft5306de4: touchscreen@38 {
-		compatible = "edt,edt-ft5406";
-		reg = <0x38>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
-		touchscreen-size-x = <1024>;
-		touchscreen-size-y = <768>;
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_vcc3v0>;
-	status = "okay";
-
-	button-800 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <800000>;
-	};
-
-	button-1000 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <1000000>;
-	};
-
-	button-1200 {
-		label = "Back";
-		linux,code = <KEY_BACK>;
-		channel = <0>;
-		voltage = <1200000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PH5 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-cubieboard.dts b/arch/arm/dts/sun4i-a10-cubieboard.dts
deleted file mode 100644
index 0645d606423..00000000000
--- a/arch/arm/dts/sun4i-a10-cubieboard.dts
+++ /dev/null
@@ -1,255 +0,0 @@
-/*
- * Copyright 2012 Stefan Roese
- * Stefan Roese <sr@denx.de>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Cubietech Cubieboard";
-	compatible = "cubietech,a10-cubieboard", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	hdmi-connector {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con_in: endpoint {
-				remote-endpoint = <&hdmi_out_con>;
-			};
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_cubieboard>;
-
-		led-0 {
-			label = "cubieboard:blue:usr";
-			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* LED1 */
-		};
-
-		led-1 {
-			label = "cubieboard:green:usr";
-			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* LED2 */
-			linux,default-trigger = "heartbeat";
-		};
-	};
-};
-
-&ahci {
-	target-supply = <&reg_ahci_5v>;
-	status = "okay";
-};
-
-&codec {
-	status = "okay";
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&de {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&phy1>;
-	status = "okay";
-};
-
-&emac_sram {
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&hdmi_out {
-	hdmi_out_con: endpoint {
-		remote-endpoint = <&hdmi_con_in>;
-	};
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&ir0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins>;
-	status = "okay";
-};
-
-&mdio {
-	status = "okay";
-
-	phy1: ethernet-phy@1 {
-		reg = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&pio {
-	led_pins_cubieboard: led-pins {
-		pins = "PH20", "PH21";
-		function = "gpio_out";
-		drive-strength = <20>;
-	};
-};
-
-&reg_ahci_5v {
-	status = "okay";
-};
-
-#include "axp209.dtsi"
-
-&ac_power_supply {
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1450000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pi_pins>,
-		    <&spi0_cs0_pi_pin>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/dts/sun4i-a10-dserve-dsrv9703c.dts
deleted file mode 100644
index 63e77c05bfd..00000000000
--- a/arch/arm/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- * Copyright 2016 Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	model = "Dserve DSRV9703C";
-	compatible = "dserve,dsrv9703c", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
-		power-supply = <&reg_vcc3v3>;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	haptics {
-		compatible = "regulator-haptic";
-		haptic-supply = <&reg_motor>;
-		min-microvolt = <3000000>;
-		max-microvolt = <3000000>;
-	};
-
-	reg_motor: reg-motor {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc-motor";
-		regulator-min-microvolt = <3000000>;
-		regulator-max-microvolt = <3000000>;
-		enable-active-high;
-		gpio = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
-	};
-};
-
-&codec {
-	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
-	status = "okay";
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&i2c1 {
-	/* pull-ups and devices require AXP209 LDO3 */
-	status = "failed";
-};
-
-&i2c2 {
-	status = "okay";
-
-	ft5406ee8: touchscreen@38 {
-		compatible = "edt,edt-ft5406";
-		reg = <0x38>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&pio 1 13 GPIO_ACTIVE_LOW>;
-		touchscreen-size-x = <1024>;
-		touchscreen-size-y = <768>;
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-400 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <400000>;
-	};
-
-	button-800 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <800000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pin>;
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PH5 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-gemei-g9.dts b/arch/arm/dts/sun4i-a10-gemei-g9.dts
deleted file mode 100644
index ea7a59dcf8f..00000000000
--- a/arch/arm/dts/sun4i-a10-gemei-g9.dts
+++ /dev/null
@@ -1,192 +0,0 @@
-/*
- * Copyright 2015 Priit Laes
- *
- * Priit Laes <plaes@plaes.org>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "Gemei G9 Tablet";
-	compatible = "gemei,g9", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-/*
- * TODO:
- *   2x cameras via CSI
- *   AXP battery management
- *   NAND
- *   OTG
- *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
- */
-&codec {
-	/* PH15 controls power to external amplifier (ft2012q) */
-	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&i2c1 {
-	status = "okay";
-
-	/* Accelerometer */
-	bma250@18 {
-		compatible = "bosch,bma250";
-		reg = <0x18>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 0 IRQ_TYPE_EDGE_RISING>; /* PH00 / EINT0 */
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-
-	status = "okay";
-
-	button-158 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <158730>;
-	};
-
-	button-349 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <349206>;
-	};
-
-	button-1142 {
-		label = "Esc";
-		linux,code = <KEY_ESC>;
-		channel = <0>;
-		voltage = <1142856>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH01 */
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-
-&uart0  {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-hackberry.dts b/arch/arm/dts/sun4i-a10-hackberry.dts
deleted file mode 100644
index 47dea092250..00000000000
--- a/arch/arm/dts/sun4i-a10-hackberry.dts
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
- * Copyright 2012 Maxime Ripard
- *
- * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Miniand Hackberry";
-	compatible = "miniand,hackberry", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	reg_emac_3v3: emac-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "emac-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <20000>;
-		enable-active-high;
-		gpio = <&pio 7 19 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&phy0>;
-	status = "okay";
-};
-
-&emac_sram {
-	status = "okay";
-};
-
-&ir0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins>;
-	status = "okay";
-};
-
-&mdio {
-	phy-supply = <&reg_emac_3v3>;
-	status = "okay";
-
-	phy0: ethernet-phy@0 {
-		reg = <0>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-hyundai-a7hd.dts b/arch/arm/dts/sun4i-a10-hyundai-a7hd.dts
deleted file mode 100644
index bf2044bac42..00000000000
--- a/arch/arm/dts/sun4i-a10-hyundai-a7hd.dts
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Hyundai A7HD";
-	compatible = "hyundai,a7hd", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		compatible = "x-powers,axp209";
-		reg = <0x34>;
-		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	gpio = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PH5 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-inet1.dts b/arch/arm/dts/sun4i-a10-inet1.dts
deleted file mode 100644
index 60e432a0ef1..00000000000
--- a/arch/arm/dts/sun4i-a10-inet1.dts
+++ /dev/null
@@ -1,229 +0,0 @@
-/*
- * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	model = "iNet-1";
-	compatible = "inet-tek,inet1", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
-		power-supply = <&reg_vcc3v3>;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&codec {
-	status = "okay";
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci0  {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&i2c1 {
-	status = "okay";
-
-	/* Accelerometer */
-	bma250@18 {
-		compatible = "bosch,bma250";
-		reg = <0x18>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 0 IRQ_TYPE_EDGE_RISING>; /* PH0 / EINT0 */
-	};
-};
-
-&i2c2 {
-	status = "okay";
-
-	ft5x: touchscreen@38 {
-		compatible = "edt,edt-ft5406";
-		reg = <0x38>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
-		wake-gpios = <&pio 1 13 GPIO_ACTIVE_HIGH>; /* PB13 */
-		touchscreen-size-x = <600>;
-		touchscreen-size-y = <1024>;
-		touchscreen-swapped-x-y;
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-200 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <200000>;
-	};
-
-	button-1000 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <1000000>;
-	};
-
-	button-1200 {
-		label = "Home";
-		linux,code = <KEY_HOMEPAGE>;
-		channel = <0>;
-		voltage = <1200000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0  {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pin>;
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PH5 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-inet97fv2.dts b/arch/arm/dts/sun4i-a10-inet97fv2.dts
deleted file mode 100644
index 76016f2ca29..00000000000
--- a/arch/arm/dts/sun4i-a10-inet97fv2.dts
+++ /dev/null
@@ -1,203 +0,0 @@
-/*
- * Copyright 2014 Open Source Support GmbH
- *
- * David Lanzendörfer <david.lanzendoerfer@o2s.ch>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "INet-97F Rev 02";
-	compatible = "primux,inet97fv2", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&i2c1 {
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-
-	ft5406ee8: touchscreen@38 {
-		compatible = "edt,edt-ft5406";
-		reg = <0x38>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
-		touchscreen-size-x = <800>;
-		touchscreen-size-y = <480>;
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-200 {
-		label = "Menu";
-		linux,code = <KEY_MENU>;
-		channel = <0>;
-		voltage = <200000>;
-	};
-
-	button-600 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <600000>;
-	};
-
-	button-800 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <800000>;
-	};
-
-	button-1000 {
-		label = "Home";
-		linux,code = <KEY_HOMEPAGE>;
-		channel = <0>;
-		voltage = <1000000>;
-	};
-
-	button-1200 {
-		label = "Esc";
-		linux,code = <KEY_ESC>;
-		channel = <0>;
-		voltage = <1200000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PH5 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/dts/sun4i-a10-inet9f-rev03.dts
deleted file mode 100644
index 62e7aa587f8..00000000000
--- a/arch/arm/dts/sun4i-a10-inet9f-rev03.dts
+++ /dev/null
@@ -1,357 +0,0 @@
-/*
- * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "iNet-9F Rev 03";
-	compatible = "inet-tek,inet9f-rev03", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys-polled";
-		poll-interval = <20>;
-
-		event-left-joystick-left {
-			label = "Left Joystick Left";
-			linux,code = <ABS_X>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <0xffffffff>; /* -1 */
-			gpios = <&pio 0 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA6 */
-		};
-
-		event-left-joystick-right {
-			label = "Left Joystick Right";
-			linux,code = <ABS_X>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <1>;
-			gpios = <&pio 0 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA5 */
-		};
-
-		event-left-joystick-up {
-			label = "Left Joystick Up";
-			linux,code = <ABS_Y>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <0xffffffff>; /* -1 */
-			gpios = <&pio 0 8 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA8 */
-		};
-
-		event-left-joystick-down {
-			label = "Left Joystick Down";
-			linux,code = <ABS_Y>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <1>;
-			gpios = <&pio 0 9 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA9 */
-		};
-
-		event-right-joystick-left {
-			label = "Right Joystick Left";
-			linux,code = <ABS_Z>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <0xffffffff>; /* -1 */
-			gpios = <&pio 0 1 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA1 */
-		};
-
-		event-right-joystick-right {
-			label = "Right Joystick Right";
-			linux,code = <ABS_Z>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <1>;
-			gpios = <&pio 0 0 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA0 */
-		};
-
-		event-right-joystick-up {
-			label = "Right Joystick Up";
-			linux,code = <ABS_RZ>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <0xffffffff>; /* -1 */
-			gpios = <&pio 0 3 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA3 */
-		};
-
-		event-right-joystick-down {
-			label = "Right Joystick Down";
-			linux,code = <ABS_RZ>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <1>;
-			gpios = <&pio 0 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA4 */
-		};
-
-		event-dpad-left {
-			label = "DPad Left";
-			linux,code = <ABS_HAT0X>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <0xffffffff>; /* -1 */
-			gpios = <&pio 7 23 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH23 */
-		};
-
-		event-dpad-right {
-			label = "DPad Right";
-			linux,code = <ABS_HAT0X>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <1>;
-			gpios = <&pio 7 24 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH24 */
-		};
-
-		event-dpad-up {
-			label = "DPad Up";
-			linux,code = <ABS_HAT0Y>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <0xffffffff>; /* -1 */
-			gpios = <&pio 7 25 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH25 */
-		};
-
-		event-dpad-down {
-			label = "DPad Down";
-			linux,code = <ABS_HAT0Y>;
-			linux,input-type = <EV_ABS>;
-			linux,input-value = <1>;
-			gpios = <&pio 7 26 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH26 */
-		};
-
-		event-x {
-			label = "Button X";
-			linux,code = <BTN_X>;
-			gpios = <&pio 0 16 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA16 */
-		};
-
-		event-y {
-			label = "Button Y";
-			linux,code = <BTN_Y>;
-			gpios = <&pio 0 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA14 */
-		};
-
-		event-a {
-			label = "Button A";
-			linux,code = <BTN_A>;
-			gpios = <&pio 0 17 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA17 */
-		};
-
-		event-b {
-			label = "Button B";
-			linux,code = <BTN_B>;
-			gpios = <&pio 0 15 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA15 */
-		};
-
-		event-select {
-			label = "Select Button";
-			linux,code = <BTN_SELECT>;
-			gpios = <&pio 0 11 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA11 */
-		};
-
-		event-start {
-			label = "Start Button";
-			linux,code = <BTN_START>;
-			gpios = <&pio 0 12 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA12 */
-		};
-
-		event-top-left {
-			label = "Top Left Button";
-			linux,code = <BTN_TL>;
-			gpios = <&pio 7 22 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PH22 */
-		};
-
-		event-top-right {
-			label = "Top Right Button";
-			linux,code = <BTN_TR>;
-			gpios = <&pio 0 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PA13 */
-		};
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&i2c1 {
-	status = "okay";
-
-	/* Accelerometer */
-	bma250@18 {
-		compatible = "bosch,bma250";
-		reg = <0x18>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 0 IRQ_TYPE_EDGE_RISING>; /* PH0 / EINT0 */
-	};
-};
-
-&i2c2 {
-	status = "okay";
-
-	ft5406ee8: touchscreen@38 {
-		compatible = "edt,edt-ft5406";
-		reg = <0x38>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
-		touchscreen-size-x = <800>;
-		touchscreen-size-y = <480>;
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-200 {
-		label = "Menu";
-		linux,code = <KEY_MENU>;
-		channel = <0>;
-		voltage = <200000>;
-	};
-
-	button-600 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <600000>;
-	};
-
-	button-800 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <800000>;
-	};
-
-	button-1000 {
-		label = "Home";
-		linux,code = <KEY_HOMEPAGE>;
-		channel = <0>;
-		voltage = <1000000>;
-	};
-
-	button-1200 {
-		label = "Esc";
-		linux,code = <KEY_ESC>;
-		channel = <0>;
-		voltage = <1200000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PH5 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-itead-iteaduino-plus.dts b/arch/arm/dts/sun4i-a10-itead-iteaduino-plus.dts
deleted file mode 100644
index d4e319d16aa..00000000000
--- a/arch/arm/dts/sun4i-a10-itead-iteaduino-plus.dts
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- * Copyright 2015 Josef Gajdusek <atx@atx.name>
- * Copyright 2015 - Marcus Cooper <codekipper@gmail.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-itead-core-common.dtsi"
-
-/ {
-	model = "Iteaduino Plus A10";
-	compatible = "itead,iteaduino-plus-a10", "allwinner,sun4i-a10";
-};
-
-&ahci {
-	target-supply = <&reg_ahci_5v>;
-	status = "okay";
-};
-
-&emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pins>;
-	phy-handle = <&phy1>;
-	status = "okay";
-};
-
-&emac_sram {
-	status = "okay";
-};
-
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-
-	axp209: pmic@34 {
-		interrupts = <0>;
-	};
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-	status = "okay";
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	status = "okay";
-};
-
-&ir0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins>;
-	status = "okay";
-};
-
-&mdio {
-	status = "okay";
-
-	phy1: ethernet-phy@1 {
-		reg = <1>;
-	};
-};
-
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&reg_ahci_5v {
-	status = "okay";
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pi_pins>,
-		    <&spi0_cs0_pi_pin>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-0 = <&uart0_pb_pins>;
-};
diff --git a/arch/arm/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/dts/sun4i-a10-jesurun-q5.dts
deleted file mode 100644
index 1aeb0bd5519..00000000000
--- a/arch/arm/dts/sun4i-a10-jesurun-q5.dts
+++ /dev/null
@@ -1,181 +0,0 @@
-/*
- * Copyright 2015 Gábor Nyers
- *
- * Gábor Nyers <gabor.nyers@gmail.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Jesurun Q5";
-	compatible = "jesurun,q5", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led {
-			label = "q5:green:usr";
-			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>;  /* PH20 */
-		};
-
-	};
-
-	reg_emac_3v3: emac-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "emac-3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		startup-delay-us = <20000>;
-		enable-active-high;
-		gpio = <&pio 7 19 GPIO_ACTIVE_HIGH>;   /* PH19 */
-	};
-};
-
-&ahci {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&phy1>;
-	status = "okay";
-};
-
-&emac_sram {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		compatible = "x-powers,axp209";
-		reg = <0x34>;
-		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&ir0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins>;
-	status = "okay";
-};
-
-&mdio {
-	phy-supply = <&reg_emac_3v3>;
-	status = "okay";
-
-	phy1: ethernet-phy@1 {
-		reg = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&reg_usb0_vbus {
-	regulator-boot-on;
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-marsboard.dts b/arch/arm/dts/sun4i-a10-marsboard.dts
deleted file mode 100644
index 81fdb217d33..00000000000
--- a/arch/arm/dts/sun4i-a10-marsboard.dts
+++ /dev/null
@@ -1,182 +0,0 @@
-/*
- * Copyright 2015 Aleksei Mamlin
- * Aleksei Mamlin <mamlinav@gmail.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "HAOYU Electronics Marsboard A10";
-	compatible = "haoyu,a10-marsboard", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			label = "marsboard:red1:usr";
-			gpios = <&pio 1 5 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-1 {
-			label = "marsboard:red2:usr";
-			gpios = <&pio 1 6 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-2 {
-			label = "marsboard:red3:usr";
-			gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-3 {
-			label = "marsboard:red4:usr";
-			gpios = <&pio 1 8 GPIO_ACTIVE_HIGH>;
-		};
-	};
-};
-
-&ahci {
-	status = "okay";
-};
-
-&codec {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&emac_sram {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&phy1>;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
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
-&mdio {
-	status = "okay";
-
-	phy1: ethernet-phy@1 {
-		reg = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&spi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pi_pins>,
-		    <&spi0_cs0_pi_pin>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-mini-xplus.dts b/arch/arm/dts/sun4i-a10-mini-xplus.dts
deleted file mode 100644
index f9d74e21031..00000000000
--- a/arch/arm/dts/sun4i-a10-mini-xplus.dts
+++ /dev/null
@@ -1,144 +0,0 @@
-/*
- * Copyright 2012 Maxime Ripard
- *
- * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "PineRiver Mini X-Plus";
-	compatible = "pineriver,mini-xplus", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		compatible = "x-powers,axp209";
-		reg = <0x34>;
-		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&ir0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pins>;
-	status = "okay";
-};
-
-&ir0_rx_pins {
-	/* The ir receiver is not always populated */
-	bias-pull-up;
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&reg_usb0_vbus {
-	regulator-boot-on;
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-mk802.dts b/arch/arm/dts/sun4i-a10-mk802.dts
deleted file mode 100644
index 059fe9c5d02..00000000000
--- a/arch/arm/dts/sun4i-a10-mk802.dts
+++ /dev/null
@@ -1,144 +0,0 @@
-/*
- * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "MK802";
-	compatible = "allwinner,mk802", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	hdmi-connector {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con_in: endpoint {
-				remote-endpoint = <&hdmi_out_con>;
-			};
-		};
-	};
-};
-
-&codec {
-	status = "okay";
-};
-
-&de {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&hdmi_out {
-	hdmi_out_con: endpoint {
-		remote-endpoint = <&hdmi_con_in>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-mk802ii.dts b/arch/arm/dts/sun4i-a10-mk802ii.dts
deleted file mode 100644
index 17dcdf03111..00000000000
--- a/arch/arm/dts/sun4i-a10-mk802ii.dts
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "MK802ii";
-	compatible = "allwinner,mk802ii", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		compatible = "x-powers,axp209";
-		reg = <0x34>;
-		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/dts/sun4i-a10-olinuxino-lime.dts
deleted file mode 100644
index 83d283cf663..00000000000
--- a/arch/arm/dts/sun4i-a10-olinuxino-lime.dts
+++ /dev/null
@@ -1,225 +0,0 @@
-/*
- * Copyright 2014 - Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Olimex A10-OLinuXino-LIME";
-	compatible = "olimex,a10-olinuxino-lime", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	hdmi-connector {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con_in: endpoint {
-				remote-endpoint = <&hdmi_out_con>;
-			};
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_olinuxinolime>;
-
-		led {
-			label = "a10-olinuxino-lime:green:usr";
-			gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-};
-
-&ahci {
-	target-supply = <&reg_ahci_5v>;
-	status = "okay";
-};
-
-&cpu0 {
-	/*
-	 * The A10-Lime is known to be unstable when running at 1008 MHz
-	 */
-	operating-points =
-		/* kHz	  uV */
-		<912000	1350000>,
-		<864000	1300000>,
-		<624000	1250000>;
-};
-
-&de {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&phy1>;
-	status = "okay";
-};
-
-&emac_sram {
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&hdmi_out {
-	hdmi_out_con: endpoint {
-		remote-endpoint = <&hdmi_con_in>;
-	};
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		compatible = "x-powers,axp209";
-		reg = <0x34>;
-		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&i2c1 {
-	status = "okay";
-
-	eeprom: eeprom@50 {
-		compatible = "atmel,24c16";
-		reg = <0x50>;
-		pagesize = <16>;
-	};
-};
-
-&mdio {
-	status = "okay";
-
-	phy1: ethernet-phy@1 {
-		reg = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&pio {
-	led_pins_olinuxinolime: led-pin {
-		pins = "PH2";
-		function = "gpio_out";
-		drive-strength = <20>;
-	};
-};
-
-&reg_ahci_5v {
-	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH5 */
-	usb0_vbus-supply   = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-pcduino.dts b/arch/arm/dts/sun4i-a10-pcduino.dts
deleted file mode 100644
index a332d61fd56..00000000000
--- a/arch/arm/dts/sun4i-a10-pcduino.dts
+++ /dev/null
@@ -1,200 +0,0 @@
-/*
- * Copyright 2014 Zoltan HERPAI
- * Zoltan HERPAI <wigyori@uid0.hu>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "LinkSprite pcDuino";
-	compatible = "linksprite,a10-pcduino", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-0 {
-			label = "pcduino:green:tx";
-			gpios = <&pio 7 15 GPIO_ACTIVE_LOW>;
-		};
-
-		led-1 {
-			label = "pcduino:green:rx";
-			gpios = <&pio 7 16 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		key-back {
-			label = "Key Back";
-			linux,code = <KEY_BACK>;
-			gpios = <&pio 7 17 GPIO_ACTIVE_LOW>;
-		};
-
-		key-home {
-			label = "Key Home";
-			linux,code = <KEY_HOME>;
-			gpios = <&pio 7 18 GPIO_ACTIVE_LOW>;
-		};
-
-		key-menu {
-			label = "Key Menu";
-			linux,code = <KEY_MENU>;
-			gpios = <&pio 7 19 GPIO_ACTIVE_LOW>;
-		};
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&emac {
-	phy-handle = <&phy1>;
-	status = "okay";
-};
-
-&emac_sram {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-&mdio {
-	status = "okay";
-
-	phy1: ethernet-phy@1 {
-		reg = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-#include "axp209.dtsi"
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb1_vbus-supply = <&reg_vcc5v0>; /* USB1 VBUS is always on */
-	usb2_vbus-supply = <&reg_vcc5v0>; /* USB2 VBUS is always on */
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-pcduino2.dts b/arch/arm/dts/sun4i-a10-pcduino2.dts
deleted file mode 100644
index bc4f128965e..00000000000
--- a/arch/arm/dts/sun4i-a10-pcduino2.dts
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * Copyright 2015 Siarhei Siamashka <siarhei.siamashka@gmail.com>
- *
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
-/*
- * The LinkSprite pcDuino2 board is almost identical to the older
- * LinkSprite pcDuino1 board. The only software visible difference
- * is that the pcDuino2 board got a USB VBUS voltage regulator, which
- * is controlled by the PD2 pin (pulled-up by default). Also one of
- * the USB host ports has been replaced with a USB WIFI chip.
- */
-
-#include "sun4i-a10-pcduino.dts"
-
-/ {
-	model = "LinkSprite pcDuino2";
-	compatible = "linksprite,a10-pcduino2", "allwinner,sun4i-a10";
-};
-
-&reg_usb2_vbus {
-	gpio = <&pio 3 2 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_vcc3v3>; /* USB WIFI is always on */
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/dts/sun4i-a10-pov-protab2-ips9.dts
deleted file mode 100644
index c3259694764..00000000000
--- a/arch/arm/dts/sun4i-a10-pov-protab2-ips9.dts
+++ /dev/null
@@ -1,206 +0,0 @@
-/*
- * Copyright 2015 Hans de Goede <hdegoede@redhat.com>
- *
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
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	model = "Point of View Protab2-IPS9";
-	compatible = "pov,protab2-ips9", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
-		power-supply = <&reg_vcc3v3>;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&codec {
-	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
-	status = "okay";
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&i2c1 {
-	/* pull-ups and devices require AXP209 LDO3 */
-	status = "failed";
-};
-
-&i2c2 {
-	status = "okay";
-
-	touchscreen@5c {
-		compatible = "pixcir,pixcir_tangoc";
-		reg = <0x5c>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
-		attb-gpio = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* PH21 */
-		enable-gpios = <&pio 0 5 GPIO_ACTIVE_LOW>;
-		wake-gpios = <&pio 1 13 GPIO_ACTIVE_LOW>;
-		touchscreen-size-x = <1024>;
-		touchscreen-size-y = <768>;
-		touchscreen-inverted-x;
-		touchscreen-inverted-y;
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-400 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <400000>;
-	};
-
-	button-800 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <800000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pin>;
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PH5 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun4i-a10-topwise-a721.dts b/arch/arm/dts/sun4i-a10-topwise-a721.dts
deleted file mode 100644
index 3628f12d252..00000000000
--- a/arch/arm/dts/sun4i-a10-topwise-a721.dts
+++ /dev/null
@@ -1,242 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2020 Pascal Roeleven <dev@pascalroeleven.nl>
- */
-
-/dts-v1/;
-#include "sun4i-a10.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	model = "Topwise A721";
-	compatible = "topwise,a721", "allwinner,sun4i-a10";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 100000 PWM_POLARITY_INVERTED>;
-		power-supply = <&reg_vbat>;
-		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
-		brightness-levels = <0 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	panel {
-		compatible = "starry,kr070pe2t";
-		backlight = <&backlight>;
-		power-supply = <&reg_lcd_power>;
-
-		port {
-			panel_input: endpoint {
-				remote-endpoint = <&tcon0_out_panel>;
-			};
-		};
-	};
-
-	reg_lcd_power: reg-lcd-power {
-		compatible = "regulator-fixed";
-		regulator-name = "reg-lcd-power";
-		gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
-		enable-active-high;
-	};
-
-	reg_vbat: reg-vbat {
-		compatible = "regulator-fixed";
-		regulator-name = "vbat";
-		regulator-min-microvolt = <3700000>;
-		regulator-max-microvolt = <3700000>;
-	};
-
-};
-
-&codec {
-	status = "okay";
-};
-
-&cpu0 {
-	cpu-supply = <&reg_dcdc2>;
-};
-
-&de {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&ac_power_supply {
-	status = "okay";
-};
-
-&battery_power_supply {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-
-	accelerometer@4c {
-		compatible = "fsl,mma7660";
-		reg = <0x4c>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-
-	touchscreen@38 {
-		compatible = "edt,edt-ft5406";
-		reg = <0x38>;
-		interrupt-parent = <&pio>;
-		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
-		touchscreen-size-x = <800>;
-		touchscreen-size-y = <480>;
-		vcc-supply = <&reg_vcc3v3>;
-	};
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-571 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <571428>;
-	};
-
-	button-761 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <761904>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH01 */
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&otg_sram {
-	status = "okay";
-};
-
-&pio {
-	vcc-pb-supply = <&reg_vcc3v3>;
-	vcc-pf-supply = <&reg_vcc3v3>;
-	vcc-ph-supply = <&reg_vcc3v3>;
-};
-
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pin>;
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1250000>;
-	regulator-max-microvolt = <1250000>;
-	regulator-name = "vdd-int-dll";
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-always-on;
-	regulator-min-microvolt = <3000000>;
-	regulator-max-microvolt = <3000000>;
-	regulator-name = "avcc";
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	status = "okay";
-};
-
-&reg_usb2_vbus {
-	status = "okay";
-};
-
-&tcon0_out {
-	tcon0_out_panel: endpoint@0 {
-		reg = <0>;
-		remote-endpoint = <&panel_input>;
-	};
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usb_power_supply {
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
-	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	usb2_vbus-supply = <&reg_usb2_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 866b55833c0..09d9f995d24 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -289,6 +289,7 @@ config MACH_SUN4I
 	select SUPPORT_SPL
 	imply SPL_SYS_I2C_LEGACY
 	imply SYS_I2C_LEGACY
+	imply OF_UPSTREAM
 
 config MACH_SUN5I
 	bool "sun5i (Allwinner A13)"
diff --git a/configs/A10-OLinuXino-Lime_defconfig b/configs/A10-OLinuXino-Lime_defconfig
index 57e91d0f017..96e3d19038b 100644
--- a/configs/A10-OLinuXino-Lime_defconfig
+++ b/configs/A10-OLinuXino-Lime_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-olinuxino-lime"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-olinuxino-lime"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=480
diff --git a/configs/Chuwi_V7_CW0825_defconfig b/configs/Chuwi_V7_CW0825_defconfig
index 02b3e69584f..40f52d1a8d3 100644
--- a/configs/Chuwi_V7_CW0825_defconfig
+++ b/configs/Chuwi_V7_CW0825_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-chuwi-v7-cw0825"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-chuwi-v7-cw0825"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/Cubieboard_defconfig b/configs/Cubieboard_defconfig
index ab3f65ad667..9fc57c23f43 100644
--- a/configs/Cubieboard_defconfig
+++ b/configs/Cubieboard_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-cubieboard"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-cubieboard"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=480
diff --git a/configs/Hyundai_A7HD_defconfig b/configs/Hyundai_A7HD_defconfig
index 482e0fb7a83..541f98db9e1 100644
--- a/configs/Hyundai_A7HD_defconfig
+++ b/configs/Hyundai_A7HD_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-hyundai-a7hd"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-hyundai-a7hd"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_EMR1=4
diff --git a/configs/Linksprite_pcDuino_defconfig b/configs/Linksprite_pcDuino_defconfig
index 49dcfa098ee..0e1a7780c3d 100644
--- a/configs/Linksprite_pcDuino_defconfig
+++ b/configs/Linksprite_pcDuino_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-pcduino"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-pcduino"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_USB1_VBUS_PIN=""
diff --git a/configs/Marsboard_A10_defconfig b/configs/Marsboard_A10_defconfig
index 3c5312d8824..c7608ed0fdc 100644
--- a/configs/Marsboard_A10_defconfig
+++ b/configs/Marsboard_A10_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-marsboard"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-marsboard"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_AHCI=y
diff --git a/configs/Mele_A1000_defconfig b/configs/Mele_A1000_defconfig
index 9ac2e4839d9..93e73ebe3f1 100644
--- a/configs/Mele_A1000_defconfig
+++ b/configs/Mele_A1000_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-a1000"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-a1000"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_VIDEO_VGA=y
diff --git a/configs/Mini-X_defconfig b/configs/Mini-X_defconfig
index e8bc1485766..e64352b4b6a 100644
--- a/configs/Mini-X_defconfig
+++ b/configs/Mini-X_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-mini-xplus"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-mini-xplus"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_USB0_VBUS_PIN="PB9"
diff --git a/configs/ba10_tv_box_defconfig b/configs/ba10_tv_box_defconfig
index b89dd8ea62b..c76f36ec37e 100644
--- a/configs/ba10_tv_box_defconfig
+++ b/configs/ba10_tv_box_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-ba10-tvbox"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-ba10-tvbox"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=384
diff --git a/configs/dserve_dsrv9703c_defconfig b/configs/dserve_dsrv9703c_defconfig
index f5ff69d7d63..06a79c935d7 100644
--- a/configs/dserve_dsrv9703c_defconfig
+++ b/configs/dserve_dsrv9703c_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-dserve-dsrv9703c"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-dserve-dsrv9703c"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_USB0_VBUS_PIN="PB9"
diff --git a/configs/iNet_3F_defconfig b/configs/iNet_3F_defconfig
index 5cc1a1d57f4..5ab210b345b 100644
--- a/configs/iNet_3F_defconfig
+++ b/configs/iNet_3F_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-inet-3f"
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/iNet_3W_defconfig b/configs/iNet_3W_defconfig
index 38b20109a57..415575cc228 100644
--- a/configs/iNet_3W_defconfig
+++ b/configs/iNet_3W_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-inet-3w"
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/inet1_defconfig b/configs/inet1_defconfig
index f81120b1197..68a6df50e42 100644
--- a/configs/inet1_defconfig
+++ b/configs/inet1_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-inet1"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-inet1"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/inet97fv2_defconfig b/configs/inet97fv2_defconfig
index d5d2dc32c93..a5414e2c502 100644
--- a/configs/inet97fv2_defconfig
+++ b/configs/inet97fv2_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-inet97fv2"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-inet97fv2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/inet9f_rev03_defconfig b/configs/inet9f_rev03_defconfig
index 4485f930236..5b0cda10f3b 100644
--- a/configs/inet9f_rev03_defconfig
+++ b/configs/inet9f_rev03_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-inet9f-rev03"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-inet9f-rev03"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/jesurun_q5_defconfig b/configs/jesurun_q5_defconfig
index c99be7cea4e..b41c2cf3c05 100644
--- a/configs/jesurun_q5_defconfig
+++ b/configs/jesurun_q5_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-jesurun-q5"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-jesurun-q5"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=312
diff --git a/configs/mk802_defconfig b/configs/mk802_defconfig
index 416565e5af2..8ebd5e9cbc3 100644
--- a/configs/mk802_defconfig
+++ b/configs/mk802_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-mk802"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-mk802"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_USB2_VBUS_PIN="PH12"
diff --git a/configs/mk802ii_defconfig b/configs/mk802ii_defconfig
index 965a9cd5c4b..c56a4c7c6a0 100644
--- a/configs/mk802ii_defconfig
+++ b/configs/mk802ii_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-mk802ii"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-mk802ii"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
diff --git a/configs/pov_protab2_ips9_defconfig b/configs/pov_protab2_ips9_defconfig
index a62c9f8fa37..330c97fd6dc 100644
--- a/configs/pov_protab2_ips9_defconfig
+++ b/configs/pov_protab2_ips9_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-pov-protab2-ips9"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-pov-protab2-ips9"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/sunxi_Gemei_G9_defconfig b/configs/sunxi_Gemei_G9_defconfig
index 3fee7c2e50c..4f3d0ec7443 100644
--- a/configs/sunxi_Gemei_G9_defconfig
+++ b/configs/sunxi_Gemei_G9_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun4i-a10-gemei-g9"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun4i-a10-gemei-g9"
 CONFIG_SPL=y
 CONFIG_MACH_SUN4I=y
 CONFIG_DRAM_CLK=432
-- 
2.46.2

