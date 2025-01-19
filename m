Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F575C02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 17:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED8448061B;
	Sun, 19 Jan 2025 18:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7372E801CF; Sun, 19 Jan 2025 17:43:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BC19B80141
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 17:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A05701692;
 Sun, 19 Jan 2025 08:44:05 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BB743F66E;
 Sun, 19 Jan 2025 08:43:36 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] sunxi: switch Allwinner A10s/A13 boards to OF_UPSTREAM
Date: Sun, 19 Jan 2025 16:41:56 +0000
Message-ID: <20250119164157.23648-4-andre.przywara@arm.com>
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
the DTs for the Allwinner A10s/A13 SoCs (sun5i) between the U-Boot and the
Linux kernel repository.

Remove the old copies of the A10s/A13 related .dts and .dtsi files, and
switch most of sun5i boards over to use OF_UPSTREAM.

There are two boards for which we don't have DTs in the kernel tree.
Keep those two .dts files, plus the base .dtsi in the legacy U-Boot DT
directory, and let their defconfig opt out of OF_UPSTREAM.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/Makefile                         |  22 +-
 arch/arm/dts/sun5i-a10s-auxtek-t003.dts       | 137 -------
 arch/arm/dts/sun5i-a10s-auxtek-t004.dts       | 149 --------
 arch/arm/dts/sun5i-a10s-mk802.dts             | 127 -------
 arch/arm/dts/sun5i-a10s-olinuxino-micro.dts   | 272 --------------
 arch/arm/dts/sun5i-a10s-r7-tv-dongle.dts      | 118 -------
 arch/arm/dts/sun5i-a10s-wobo-i5.dts           | 195 ----------
 arch/arm/dts/sun5i-a10s.dtsi                  | 173 ---------
 arch/arm/dts/sun5i-a13-difrnce-dit4350.dts    |  50 ---
 .../dts/sun5i-a13-empire-electronix-d709.dts  | 190 ----------
 .../dts/sun5i-a13-empire-electronix-m712.dts  |  51 ---
 arch/arm/dts/sun5i-a13-hsg-h702.dts           | 182 ----------
 arch/arm/dts/sun5i-a13-inet-98v-rev2.dts      |  50 ---
 arch/arm/dts/sun5i-a13-licheepi-one.dts       | 214 -----------
 arch/arm/dts/sun5i-a13-olinuxino-micro.dts    | 141 --------
 arch/arm/dts/sun5i-a13-olinuxino.dts          | 247 -------------
 .../dts/sun5i-a13-pocketbook-touch-lux-3.dts  | 258 --------------
 arch/arm/dts/sun5i-a13-q8-tablet.dts          |  80 -----
 arch/arm/dts/sun5i-a13-utoo-p66.dts           | 116 ------
 arch/arm/dts/sun5i-a13.dtsi                   | 118 -------
 arch/arm/dts/sun5i-gr8-chip-pro.dts           | 238 -------------
 arch/arm/dts/sun5i-gr8-evb.dts                | 333 ------------------
 arch/arm/dts/sun5i-gr8.dtsi                   | 126 -------
 arch/arm/dts/sun5i-r8-chip.dts                | 282 ---------------
 arch/arm/dts/sun5i-r8.dtsi                    |  47 ---
 .../dts/sun5i-reference-design-tablet.dtsi    | 194 ----------
 arch/arm/mach-sunxi/Kconfig                   |   1 +
 configs/A10s-OLinuXino-M_defconfig            |   2 +-
 configs/A13-OLinuXinoM_defconfig              |   2 +-
 configs/A13-OLinuXino_defconfig               |   2 +-
 configs/Ampe_A76_defconfig                    |   1 +
 configs/Auxtek-T003_defconfig                 |   2 +-
 configs/Auxtek-T004_defconfig                 |   2 +-
 configs/CHIP_defconfig                        |   2 +-
 configs/CHIP_pro_defconfig                    |   2 +-
 configs/Empire_electronix_d709_defconfig      |   2 +-
 configs/Empire_electronix_m712_defconfig      |   2 +-
 configs/UTOO_P66_defconfig                    |   2 +-
 configs/Wobo_i5_defconfig                     |   2 +-
 configs/difrnce_dit4350_defconfig             |   2 +-
 configs/iNet_86VS_defconfig                   |   1 +
 configs/inet98v_rev2_defconfig                |   2 +-
 configs/mk802_a10s_defconfig                  |   2 +-
 configs/q8_a13_tablet_defconfig               |   2 +-
 configs/r7-tv-dongle_defconfig                |   2 +-
 45 files changed, 20 insertions(+), 4125 deletions(-)
 delete mode 100644 arch/arm/dts/sun5i-a10s-auxtek-t003.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-auxtek-t004.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-mk802.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-olinuxino-micro.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-r7-tv-dongle.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s-wobo-i5.dts
 delete mode 100644 arch/arm/dts/sun5i-a10s.dtsi
 delete mode 100644 arch/arm/dts/sun5i-a13-difrnce-dit4350.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-empire-electronix-d709.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-empire-electronix-m712.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-hsg-h702.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-inet-98v-rev2.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-licheepi-one.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-olinuxino-micro.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-olinuxino.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-pocketbook-touch-lux-3.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-q8-tablet.dts
 delete mode 100644 arch/arm/dts/sun5i-a13-utoo-p66.dts
 delete mode 100644 arch/arm/dts/sun5i-a13.dtsi
 delete mode 100644 arch/arm/dts/sun5i-gr8-chip-pro.dts
 delete mode 100644 arch/arm/dts/sun5i-gr8-evb.dts
 delete mode 100644 arch/arm/dts/sun5i-gr8.dtsi
 delete mode 100644 arch/arm/dts/sun5i-r8-chip.dts
 delete mode 100644 arch/arm/dts/sun5i-r8.dtsi
 delete mode 100644 arch/arm/dts/sun5i-reference-design-tablet.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 6a483f6743c..6f20c3aeffd 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -534,28 +534,8 @@ dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-inet-3f.dtb \
 	sun4i-a10-inet-3w.dtb
 dtb-$(CONFIG_MACH_SUN5I) += \
-	sun5i-a10s-auxtek-t003.dtb \
-	sun5i-a10s-auxtek-t004.dtb \
-	sun5i-a10s-mk802.dtb \
-	sun5i-a10s-olinuxino-micro.dtb \
-	sun5i-a10s-r7-tv-dongle.dtb \
-	sun5i-a10s-wobo-i5.dtb \
 	sun5i-a13-ampe-a76.dtb \
-	sun5i-a13-difrnce-dit4350.dtb \
-	sun5i-a13-empire-electronix-d709.dtb \
-	sun5i-a13-empire-electronix-m712.dtb \
-	sun5i-a13-hsg-h702.dtb \
-	sun5i-a13-inet-86vs.dtb \
-	sun5i-a13-inet-98v-rev2.dtb \
-	sun5i-a13-licheepi-one.dtb \
-	sun5i-a13-olinuxino.dtb \
-	sun5i-a13-olinuxino-micro.dtb \
-	sun5i-a13-pocketbook-touch-lux-3.dtb \
-	sun5i-a13-q8-tablet.dtb \
-	sun5i-a13-utoo-p66.dtb \
-	sun5i-gr8-chip-pro.dtb \
-	sun5i-gr8-evb.dtb \
-	sun5i-r8-chip.dtb
+	sun5i-a13-inet-86vs.dtb
 dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31-app4-evb1.dtb \
 	sun6i-a31-colombus.dtb \
diff --git a/arch/arm/dts/sun5i-a10s-auxtek-t003.dts b/arch/arm/dts/sun5i-a10s-auxtek-t003.dts
deleted file mode 100644
index 04b0e6d2876..00000000000
--- a/arch/arm/dts/sun5i-a10s-auxtek-t003.dts
+++ /dev/null
@@ -1,137 +0,0 @@
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
-#include "sun5i-a10s.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Auxtek t003 A10s hdmi tv-stick";
-	compatible = "allwinner,auxtek-t003", "allwinner,sun5i-a10s";
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
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_t003>;
-
-		led {
-			label = "t003-tv-dongle:red:usr";
-			gpios = <&pio 1 2 GPIO_ACTIVE_HIGH>; /* PB2 */
-			default-state = "on";
-		};
-	};
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp152: pmic@30 {
-		compatible = "x-powers,axp152";
-		reg = <0x30>;
-		interrupts = <0>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
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
-&pio {
-	led_pins_t003: led-pin {
-		pins = "PB2";
-		function = "gpio_out";
-		drive-strength = <20>;
-	};
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
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
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/dts/sun5i-a10s-auxtek-t004.dts
deleted file mode 100644
index 667bc2dc1ea..00000000000
--- a/arch/arm/dts/sun5i-a10s-auxtek-t004.dts
+++ /dev/null
@@ -1,149 +0,0 @@
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
-#include "sun5i-a10s.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Auxtek t004 A10s hdmi tv-stick";
-	compatible = "allwinner,auxtek-t004", "allwinner,sun5i-a10s";
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
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_t004>;
-
-		led {
-			label = "t004-tv-dongle:red:usr";
-			gpios = <&pio 1 2 GPIO_ACTIVE_HIGH>; /* PB2 */
-			default-state = "on";
-		};
-	};
-
-	reg_vmmc1: vmmc1 {
-		compatible = "regulator-fixed";
-		regulator-name = "vmmc1";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		enable-active-high;
-		gpio = <&pio 1 18 GPIO_ACTIVE_HIGH>; /* PB18 */
-	};
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp152: pmic@30 {
-		compatible = "x-powers,axp152";
-		reg = <0x30>;
-		interrupts = <0>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
-	status = "okay";
-};
-
-&mmc1 {
-	vmmc-supply = <&reg_vmmc1>;
-	bus-width = <4>;
-	non-removable;
-	cap-sdio-irq;
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
-&pio {
-	led_pins_t004: led-pin {
-		pins = "PB2";
-		function = "gpio_out";
-		drive-strength = <20>;
-	};
-};
-
-&reg_usb1_vbus {
-	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
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
-	usb0_id_det-gpios = <&pio 6 12 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG12 */
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a10s-mk802.dts b/arch/arm/dts/sun5i-a10s-mk802.dts
deleted file mode 100644
index d0219404c23..00000000000
--- a/arch/arm/dts/sun5i-a10s-mk802.dts
+++ /dev/null
@@ -1,127 +0,0 @@
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
-#include "sun5i-a10s.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "MK802-A10s";
-	compatible = "allwinner,a10s-mk802", "allwinner,sun5i-a10s";
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
-			label = "mk802:red:usr";
-			gpios = <&pio 1 2 GPIO_ACTIVE_HIGH>; /* PB2 */
-		};
-	};
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-
-	axp152: pmic@30 {
-		compatible = "x-powers,axp152";
-		reg = <0x30>;
-		interrupts = <0>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
-	status = "okay";
-};
-
-&mmc1 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	non-removable;
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
-&reg_usb1_vbus {
-	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
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
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/dts/sun5i-a10s-olinuxino-micro.dts
deleted file mode 100644
index 5832bb31fc5..00000000000
--- a/arch/arm/dts/sun5i-a10s-olinuxino-micro.dts
+++ /dev/null
@@ -1,272 +0,0 @@
-/*
- * Copyright 2013 Maxime Ripard
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
-#include "sun5i-a10s.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "Olimex A10s-Olinuxino Micro";
-	compatible = "olimex,a10s-olinuxino-micro", "allwinner,sun5i-a10s";
-
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart2;
-		serial2 = &uart3;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	connector {
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
-		pinctrl-0 = <&led_pins_olinuxino>;
-
-		led {
-			label = "a10s-olinuxino-micro:green:usr";
-			gpios = <&pio 4 3 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-};
-
-&be0 {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pa_pins>;
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
-	axp152: pmic@30 {
-		reg = <0x30>;
-		interrupts = <0>;
-	};
-};
-
-#include "axp152.dtsi"
-
-&i2c1 {
-	status = "okay";
-
-	eeprom@50 {
-		compatible = "atmel,24c16";
-		pagesize = <16>;
-		reg = <0x50>;
-		read-only;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&lradc {
-	vref-supply = <&reg_vcc3v0>;
-	status = "okay";
-
-	button-191 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <191274>;
-	};
-
-	button-392 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <392644>;
-	};
-
-	button-601 {
-		label = "Menu";
-		linux,code = <KEY_MENU>;
-		channel = <0>;
-		voltage = <601151>;
-	};
-
-	button-795 {
-		label = "Enter";
-		linux,code = <KEY_ENTER>;
-		channel = <0>;
-		voltage = <795090>;
-	};
-
-	button-987 {
-		label = "Home";
-		linux,code = <KEY_HOMEPAGE>;
-		channel = <0>;
-		voltage = <987387>;
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
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
-	status = "okay";
-};
-
-&mmc1 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 13 GPIO_ACTIVE_LOW>; /* PG13 */
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
-&pio {
-	led_pins_olinuxino: led-pin {
-		pins = "PE3";
-		function = "gpio_out";
-		drive-strength = <20>;
-	};
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&spi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pb_pins>,
-		    <&spi2_cs0_pb_pin>;
-	status = "okay";
-};
-
-&tcon0 {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_pb_pins>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pc_pins>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pg_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 6 12 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG12 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/dts/sun5i-a10s-r7-tv-dongle.dts
deleted file mode 100644
index 964360f0610..00000000000
--- a/arch/arm/dts/sun5i-a10s-r7-tv-dongle.dts
+++ /dev/null
@@ -1,118 +0,0 @@
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
-#include "sun5i-a10s.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "R7 A10s hdmi tv-stick";
-	compatible = "allwinner,r7-tv-dongle", "allwinner,sun5i-a10s";
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
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_r7>;
-
-		led {
-			label = "r7-tv-dongle:green:usr";
-			gpios = <&pio 1 2 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 1 GPIO_ACTIVE_LOW>; /* PG1 */
-	status = "okay";
-};
-
-&mmc1 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&pio {
-	led_pins_r7: led-pin {
-		pins = "PB2";
-		function = "gpio_out";
-		drive-strength = <20>;
-	};
-};
-
-&reg_usb1_vbus {
-	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
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
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/dts/sun5i-a10s-wobo-i5.dts
deleted file mode 100644
index ef8baa99268..00000000000
--- a/arch/arm/dts/sun5i-a10s-wobo-i5.dts
+++ /dev/null
@@ -1,195 +0,0 @@
-/*
- * Copyright 2015 Jelle van der Waa <jelle@vdwaa.nl>
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
-#include "sun5i-a10s.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "A10s-Wobo i5";
-	compatible = "wobo,a10s-wobo-i5", "allwinner,sun5i-a10s";
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
-			label = "a10s-wobo-i5:blue:usr";
-			gpios = <&pio 1 2 GPIO_ACTIVE_HIGH>;
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
-		gpio = <&pio 0 2 GPIO_ACTIVE_HIGH>;
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
-&emac {
-	pinctrl-names = "default";
-	pinctrl-0 = <&emac_pd_pins>;
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
-#include "axp209.dtsi"
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
-	cd-gpios = <&pio 1 3 GPIO_ACTIVE_LOW>; /* PB3 */
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
-&reg_ldo3 {
-	regulator-always-on;
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi1";
-};
-
-&reg_ldo4 {
-	regulator-always-on;
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi2";
-};
-
-&reg_usb1_vbus {
-	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>;
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
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a10s.dtsi b/arch/arm/dts/sun5i-a10s.dtsi
deleted file mode 100644
index 09c486b608b..00000000000
--- a/arch/arm/dts/sun5i-a10s.dtsi
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * Copyright 2013 Maxime Ripard
- *
- * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
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
-#include "sun5i.dtsi"
-
-#include <dt-bindings/dma/sun4i-a10.h>
-
-/ {
-	aliases {
-		ethernet0 = &emac;
-	};
-
-	chosen {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		framebuffer-lcd0-hdmi {
-			compatible = "allwinner,simple-framebuffer",
-				     "simple-framebuffer";
-			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&ccu CLK_AHB_LCD>, <&ccu CLK_AHB_HDMI>,
-				 <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DRAM_DE_BE>,
-				 <&ccu CLK_DE_BE>, <&ccu CLK_HDMI>;
-			status = "disabled";
-		};
-	};
-
-	display-engine {
-		compatible = "allwinner,sun5i-a10s-display-engine";
-		allwinner,pipelines = <&fe0>;
-	};
-
-	soc {
-		hdmi: hdmi@1c16000 {
-			compatible = "allwinner,sun5i-a10s-hdmi";
-			reg = <0x01c16000 0x1000>;
-			interrupts = <58>;
-			clocks = <&ccu CLK_AHB_HDMI>, <&ccu CLK_HDMI>,
-				 <&ccu CLK_PLL_VIDEO0_2X>,
-				 <&ccu CLK_PLL_VIDEO1_2X>;
-			clock-names = "ahb", "mod", "pll-0", "pll-1";
-			dmas = <&dma SUN4I_DMA_NORMAL 16>,
-			       <&dma SUN4I_DMA_NORMAL 16>,
-			       <&dma SUN4I_DMA_DEDICATED 24>;
-			dma-names = "ddc-tx", "ddc-rx", "audio-tx";
-			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				hdmi_in: port@0 {
-					reg = <0>;
-
-					hdmi_in_tcon0: endpoint {
-						remote-endpoint = <&tcon0_out_hdmi>;
-					};
-				};
-
-				hdmi_out: port@1 {
-					reg = <1>;
-				};
-			};
-		};
-
-		pwm: pwm@1c20e00 {
-			compatible = "allwinner,sun5i-a10s-pwm";
-			reg = <0x01c20e00 0xc>;
-			clocks = <&ccu CLK_HOSC>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-	};
-};
-
-&ccu {
-	compatible = "allwinner,sun5i-a10s-ccu";
-};
-
-&mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins>;
-};
-
-&pio {
-	compatible = "allwinner,sun5i-a10s-pinctrl";
-
-	uart0_pb_pins: uart0-pb-pins {
-		pins = "PB19", "PB20";
-		function = "uart0";
-	};
-
-	uart2_pc_pins: uart2-pc-pins {
-		pins = "PC18", "PC19";
-		function = "uart2";
-	};
-
-	emac_pa_pins: emac-pa-pins {
-		pins = "PA0", "PA1", "PA2",
-				"PA3", "PA4", "PA5", "PA6",
-				"PA7", "PA8", "PA9", "PA10",
-				"PA11", "PA12", "PA13", "PA14",
-				"PA15", "PA16";
-		function = "emac";
-	};
-
-	mmc1_pins: mmc1-pins {
-		pins = "PG3", "PG4", "PG5",
-				 "PG6", "PG7", "PG8";
-		function = "mmc1";
-		drive-strength = <30>;
-	};
-
-	spi2_pb_pins: spi2-pb-pins {
-		pins = "PB12", "PB13", "PB14";
-		function = "spi2";
-	};
-
-	spi2_cs0_pb_pin: spi2-cs0-pb-pin {
-		pins = "PB11";
-		function = "spi2";
-	};
-};
-
-&tcon0_out {
-	tcon0_out_hdmi: endpoint@2 {
-		reg = <2>;
-		remote-endpoint = <&hdmi_in_tcon0>;
-		allwinner,tcon-channel = <1>;
-	};
-};
diff --git a/arch/arm/dts/sun5i-a13-difrnce-dit4350.dts b/arch/arm/dts/sun5i-a13-difrnce-dit4350.dts
deleted file mode 100644
index 894c4c4f9a1..00000000000
--- a/arch/arm/dts/sun5i-a13-difrnce-dit4350.dts
+++ /dev/null
@@ -1,50 +0,0 @@
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
-#include "sun5i-a13.dtsi"
-#include "sun5i-reference-design-tablet.dtsi"
-
-/ {
-	model = "Difrnce DIT4350";
-	compatible = "difrnce,dit4350", "allwinner,sun5i-a13";
-};
diff --git a/arch/arm/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/dts/sun5i-a13-empire-electronix-d709.dts
deleted file mode 100644
index d059388d725..00000000000
--- a/arch/arm/dts/sun5i-a13-empire-electronix-d709.dts
+++ /dev/null
@@ -1,190 +0,0 @@
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
-#include "sun5i-a13.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	model = "Empire Electronix D709 tablet";
-	compatible = "empire-electronix,d709", "allwinner,sun5i-a13";
-
-	aliases {
-		serial0 = &uart1;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-		power-supply = <&reg_vcc3v3>;
-		/* TODO: backlight uses axp gpio1 as enable pin */
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
-	status = "okay";
-
-	pcf8563: rtc@51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
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
-	button-400 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <400000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
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
-	regulator-name = "vdd-int-pll";
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
-&reg_ldo3 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi";
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 6 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG2 */
-	usb0_vbus_det-gpios = <&pio 6 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PG1 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_ldo3>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a13-empire-electronix-m712.dts b/arch/arm/dts/sun5i-a13-empire-electronix-m712.dts
deleted file mode 100644
index b1e2afd9de5..00000000000
--- a/arch/arm/dts/sun5i-a13-empire-electronix-m712.dts
+++ /dev/null
@@ -1,51 +0,0 @@
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
-#include "sun5i-a13.dtsi"
-#include "sun5i-reference-design-tablet.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "Empire Electronix M712 tablet";
-	compatible = "empire-electronix,m712", "allwinner,sun5i-a13";
-};
diff --git a/arch/arm/dts/sun5i-a13-hsg-h702.dts b/arch/arm/dts/sun5i-a13-hsg-h702.dts
deleted file mode 100644
index 9b9f2a57485..00000000000
--- a/arch/arm/dts/sun5i-a13-hsg-h702.dts
+++ /dev/null
@@ -1,182 +0,0 @@
-/*
- * Copyright 2014 Chen-Yu Tsai <wens@csie.org>
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
-#include "sun5i-a13.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "HSG H702";
-	compatible = "hsg,h702", "allwinner,sun5i-a13";
-
-	aliases {
-		serial0 = &uart1;
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
-&i2c1 {
-	status = "okay";
-
-	pcf8563: rtc@51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
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
-	button-400 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <400000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
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
-#include "axp209.dtsi"
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1500000>;
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
-&reg_ldo3 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi";
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 6 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG2 */
-	usb0_vbus_det-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_ldo3>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a13-inet-98v-rev2.dts b/arch/arm/dts/sun5i-a13-inet-98v-rev2.dts
deleted file mode 100644
index 439ae3b537d..00000000000
--- a/arch/arm/dts/sun5i-a13-inet-98v-rev2.dts
+++ /dev/null
@@ -1,50 +0,0 @@
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
-#include "sun5i-a13.dtsi"
-#include "sun5i-reference-design-tablet.dtsi"
-
-/ {
-	model = "INet-98V Rev 02";
-	compatible = "primux,inet98v-rev2", "allwinner,sun5i-a13";
-};
diff --git a/arch/arm/dts/sun5i-a13-licheepi-one.dts b/arch/arm/dts/sun5i-a13-licheepi-one.dts
deleted file mode 100644
index 3a6c4bd0a44..00000000000
--- a/arch/arm/dts/sun5i-a13-licheepi-one.dts
+++ /dev/null
@@ -1,214 +0,0 @@
-/*
- * Copyright 2016 Icenowy Zheng <icenowy@aosc.xyz>
- *
- * Based on sun5i-a13-olinuxino.dts, which is
- *   Copyright 2012 Maxime Ripard <maxime.ripard@free-electrons.com>
- *   Copyright 2013 Hans de Goede <hdegoede@redhat.com>
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
-#include "sun5i-a13.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "Lichee Pi One";
-	compatible = "licheepi,licheepi-one", "allwinner,sun5i-a13";
-
-	aliases {
-		serial0 = &uart1;
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
-			label = "licheepi:red:usr";
-			gpios = <&pio 2 5 GPIO_ACTIVE_LOW>;
-		};
-
-		led-1 {
-			label = "licheepi:green:usr";
-			gpios = <&pio 2 19 GPIO_ACTIVE_LOW>;
-			default-state = "on";
-		};
-
-		led-2 {
-			label = "licheepi:blue:usr";
-			gpios = <&pio 2 4 GPIO_ACTIVE_LOW>;
-		};
-
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
-	status = "disabled";
-};
-
-&i2c2 {
-	status = "disabled";
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-984 {
-		label = "Home";
-		linux,code = <KEY_HOMEPAGE>;
-		channel = <0>;
-		voltage = <984126>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	broken-cd;
-	status = "okay";
-};
-
-&mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_4bit_pc_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	broken-cd;
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
-#include "axp209.dtsi"
-
-&reg_dcdc2 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1500000>;
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
-&reg_ldo3 {
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <1800000>;
-	regulator-name = "csi-1.8v";
-};
-
-&reg_ldo4 {
-	regulator-min-microvolt = <2800000>;
-	regulator-max-microvolt = <2800000>;
-	regulator-name = "csi-2.8v";
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 */
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
-	usb0_vbus_det-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_vcc5v0>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/dts/sun5i-a13-olinuxino-micro.dts
deleted file mode 100644
index bfe1075e62c..00000000000
--- a/arch/arm/dts/sun5i-a13-olinuxino-micro.dts
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * Copyright 2012 Maxime Ripard <maxime.ripard@free-electrons.com>
- * Copyright 2013 Hans de Goede <hdegoede@redhat.com>
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
-#include "sun5i-a13.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Olimex A13-Olinuxino Micro";
-	compatible = "olimex,a13-olinuxino-micro", "allwinner,sun5i-a13";
-
-	aliases {
-		serial0 = &uart1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_olinuxinom>;
-
-		led {
-			label = "a13-olinuxino-micro:green:power";
-			gpios = <&pio 6 9 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-};
-
-&ehci0 {
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
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
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
-&pio {
-	led_pins_olinuxinom: led-pin {
-		pins = "PG9";
-		function = "gpio_out";
-		drive-strength = <20>;
-	};
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&reg_usb1_vbus {
-	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 6 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG2 */
-	usb0_vbus_det-gpios = <&pio 6 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PG1 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a13-olinuxino.dts b/arch/arm/dts/sun5i-a13-olinuxino.dts
deleted file mode 100644
index fadeae3cd8b..00000000000
--- a/arch/arm/dts/sun5i-a13-olinuxino.dts
+++ /dev/null
@@ -1,247 +0,0 @@
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
-#include "sun5i-a13.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-/ {
-	model = "Olimex A13-Olinuxino";
-	compatible = "olimex,a13-olinuxino", "allwinner,sun5i-a13";
-
-	aliases {
-		serial0 = &uart1;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_olinuxino>;
-
-		led {
-			gpios = <&pio 6 9 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	bridge {
-		compatible = "dumb-vga-dac";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				vga_bridge_in: endpoint {
-					remote-endpoint = <&tcon0_out_vga>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-
-				vga_bridge_out: endpoint {
-					remote-endpoint = <&vga_con_in>;
-				};
-			};
-		};
-	};
-
-	vga {
-		compatible = "vga-connector";
-
-		port {
-			vga_con_in: endpoint {
-				remote-endpoint = <&vga_bridge_out>;
-			};
-		};
-	};
-};
-
-&be0 {
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
-};
-
-&lradc {
-	vref-supply = <&reg_vcc3v0>;
-	status = "okay";
-
-	button-191 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <191274>;
-	};
-
-	button-392 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <392644>;
-	};
-
-	button-601 {
-		label = "Menu";
-		linux,code = <KEY_MENU>;
-		channel = <0>;
-		voltage = <601151>;
-	};
-
-	button-795 {
-		label = "Enter";
-		linux,code = <KEY_ENTER>;
-		channel = <0>;
-		voltage = <795090>;
-	};
-
-	button-987 {
-		label = "Home";
-		linux,code = <KEY_HOMEPAGE>;
-		channel = <0>;
-		voltage = <987387>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
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
-&pio {
-	led_pins_olinuxino: led-pin {
-		pins = "PG9";
-		function = "gpio_out";
-		drive-strength = <20>;
-	};
-};
-
-&reg_usb0_vbus {
-	status = "okay";
-	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
-};
-
-&reg_usb1_vbus {
-	gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&tcon0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&lcd_rgb666_pins>;
-	status = "okay";
-};
-
-&tcon0_out {
-	tcon0_out_vga: endpoint@0 {
-		reg = <0>;
-		remote-endpoint = <&vga_bridge_in>;
-	};
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 6 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG2 */
-	usb0_vbus_det-gpios = <&pio 6 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PG1 */
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a13-pocketbook-touch-lux-3.dts b/arch/arm/dts/sun5i-a13-pocketbook-touch-lux-3.dts
deleted file mode 100644
index d60407772e5..00000000000
--- a/arch/arm/dts/sun5i-a13-pocketbook-touch-lux-3.dts
+++ /dev/null
@@ -1,258 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright 2019 Ondrej Jirman <megous@megous.com>
- */
-
-/dts-v1/;
-#include "sun5i-a13.dtsi"
-#include "sunxi-common-regulators.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	model = "PocketBook Touch Lux 3";
-	compatible = "pocketbook,touch-lux-3", "allwinner,sun5i-a13";
-
-	aliases {
-		serial0 = &uart1;
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-	};
-
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
-		enable-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-		power-supply = <&reg_vcc3v3>;
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
-			gpios = <&pio 4 8 GPIO_ACTIVE_LOW>; /* PE8 */
-			default-state = "on";
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		autorepeat;
-		label = "GPIO Keys";
-
-		key-right {
-			label = "Right";
-			linux,code = <KEY_RIGHT>;
-			gpios = <&pio 6 9 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PG9 */
-		};
-
-		key-left {
-			label = "Left";
-			linux,code = <KEY_LEFT>;
-			gpios = <&pio 6 10 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PG10 */
-		};
-	};
-
-	reg_1v8: regulator-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd-1v8-nor-ctp";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&pio 2 15 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_1v8_nor: regulator-nor {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd-nor";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&pio 2 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		vin-supply = <&reg_1v8>;
-		regulator-always-on;
-	};
-
-	reg_1v8_ctp: regulator-ctp {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd-ctp";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&pio 2 13 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		vin-supply = <&reg_1v8>;
-	};
-
-	reg_3v3_mmc0: regulator-mmc0 {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd-mmc0";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&pio 4 4 GPIO_ACTIVE_LOW>; /* PE4 */
-		vin-supply = <&reg_vcc3v3>;
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
-	pcf8563: rtc@51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-
-	/* Touchpanel is connected here. */
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-200 {
-		label = "Home";
-		linux,code = <KEY_HOME>;
-		channel = <0>;
-		voltage = <200000>;
-	};
-
-	button-400 {
-		label = "Menu";
-		linux,code = <KEY_MENU>;
-		channel = <0>;
-		voltage = <400000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_3v3_mmc0>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
-	status = "okay";
-};
-
-&mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_4bit_pc_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	non-removable;
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
-	regulator-min-microvolt = <1200000>;
-	regulator-max-microvolt = <1200000>;
-	regulator-name = "vdd-int-pll";
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
-&reg_ldo3 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi";
-	/* We need this otherwise the LDO3 would overload */
-	regulator-soft-start;
-	regulator-ramp-delay = <1600>;
-};
-
-&spi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pe_pins>, <&spi2_cs0_pe_pin>;
-	status = "okay";
-
-	epd_flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "macronix,mx25u4033", "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <4000000>;
-	};
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	dr_mode = "peripheral";
-	status = "okay";
-};
-
-&battery_power_supply {
-	status = "okay";
-};
-
-&usb_power_supply {
-	status = "okay";
-};
-
-&usbphy {
-	usb1_vbus-supply = <&reg_ldo3>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-a13-q8-tablet.dts b/arch/arm/dts/sun5i-a13-q8-tablet.dts
deleted file mode 100644
index f9fc1c8b60b..00000000000
--- a/arch/arm/dts/sun5i-a13-q8-tablet.dts
+++ /dev/null
@@ -1,80 +0,0 @@
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
-#include "sun5i-a13.dtsi"
-#include "sun5i-reference-design-tablet.dtsi"
-
-/ {
-	model = "Q8 A13 Tablet";
-	compatible = "allwinner,q8-a13", "allwinner,sun5i-a13";
-
-	panel: panel {
-		compatible = "bananapi,s070wv20-ct16";
-		power-supply = <&reg_vcc3v3>;
-		enable-gpios = <&axp_gpio 0 GPIO_ACTIVE_HIGH>; /* AXP GPIO0 */
-		backlight = <&backlight>;
-
-		port {
-			panel_input: endpoint {
-				remote-endpoint = <&tcon0_out_lcd>;
-			};
-		};
-	};
-};
-
-&be0 {
-	status = "okay";
-};
-
-&tcon0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&lcd_rgb666_pins>;
-	status = "okay";
-};
-
-&tcon0_out {
-	tcon0_out_lcd: endpoint@0 {
-		reg = <0>;
-		remote-endpoint = <&panel_input>;
-	};
-};
diff --git a/arch/arm/dts/sun5i-a13-utoo-p66.dts b/arch/arm/dts/sun5i-a13-utoo-p66.dts
deleted file mode 100644
index be486d28d04..00000000000
--- a/arch/arm/dts/sun5i-a13-utoo-p66.dts
+++ /dev/null
@@ -1,116 +0,0 @@
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
-#include "sun5i-a13.dtsi"
-#include "sun5i-reference-design-tablet.dtsi"
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "Utoo P66";
-	compatible = "utoo,p66", "allwinner,sun5i-a13";
-
-	/* The P66 uses the uart pins as gpios */
-	aliases {
-		/delete-property/serial0;
-	};
-
-	chosen {
-		/delete-property/stdout-path;
-	};
-
-	i2c_lcd: i2c {
-		/* The lcd panel i2c interface is hooked up via gpios */
-		compatible = "i2c-gpio";
-		sda-gpios = <&pio 6 12 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG12 */
-		scl-gpios = <&pio 6 10 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG10 */
-		i2c-gpio,delay-us = <5>;
-	};
-};
-
-&backlight {
-	/* Note levels of 10 / 20% result in backlight off */
-	brightness-levels = <0 30 40 50 60 70 80 90 100>;
-	default-brightness-level = <6>;
-};
-
-&codec {
-	allwinner,pa-gpios = <&pio 6 3 GPIO_ACTIVE_HIGH>; /* PG3 */
-};
-
-&mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_8bit_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-
-	mmccard: mmccard@0 {
-		reg = <0>;
-		compatible = "mmc-card";
-		broken-hpi;
-	};
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
-};
-
-&touchscreen {
-	compatible = "chipone,icn8318";
-	reg = <0x40>;
-	/* The P66 uses a different EINT then the reference design */
-	interrupts = <6 9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */
-	/* The icn8318 binding expects wake-gpios instead of power-gpios */
-	wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
-	touchscreen-size-x = <800>;
-	touchscreen-size-y = <480>;
-	touchscreen-inverted-x;
-	touchscreen-swapped-x-y;
-	status = "okay";
-};
-
-&uart1 {
-	/* The P66 uses the uart pins as gpios */
-	status = "disabled";
-};
diff --git a/arch/arm/dts/sun5i-a13.dtsi b/arch/arm/dts/sun5i-a13.dtsi
deleted file mode 100644
index 2c9152b151b..00000000000
--- a/arch/arm/dts/sun5i-a13.dtsi
+++ /dev/null
@@ -1,118 +0,0 @@
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
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
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
-#include "sun5i.dtsi"
-
-#include <dt-bindings/thermal/thermal.h>
-
-/ {
-	thermal-zones {
-		cpu-thermal {
-			/* milliseconds */
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-			thermal-sensors = <&rtp>;
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert0>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-
-			trips {
-				cpu_alert0: cpu-alert0 {
-					/* milliCelsius */
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					/* milliCelsius */
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-		};
-	};
-
-	display-engine {
-		compatible = "allwinner,sun5i-a13-display-engine";
-		allwinner,pipelines = <&fe0>;
-	};
-
-	soc {
-		pwm: pwm@1c20e00 {
-			compatible = "allwinner,sun5i-a13-pwm";
-			reg = <0x01c20e00 0xc>;
-			clocks = <&ccu CLK_HOSC>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-
-	};
-};
-
-&ccu {
-	compatible = "allwinner,sun5i-a13-ccu";
-};
-
-&cpu0 {
-	clock-latency = <244144>; /* 8 32k periods */
-	operating-points =
-		/* kHz	  uV */
-		<1008000 1400000>,
-		<912000 1350000>,
-		<864000 1300000>,
-		<624000 1200000>,
-		<576000 1200000>,
-		<432000 1200000>;
-	#cooling-cells = <2>;
-};
-
-&pio {
-	compatible = "allwinner,sun5i-a13-pinctrl";
-};
diff --git a/arch/arm/dts/sun5i-gr8-chip-pro.dts b/arch/arm/dts/sun5i-gr8-chip-pro.dts
deleted file mode 100644
index ffbd99c176d..00000000000
--- a/arch/arm/dts/sun5i-gr8-chip-pro.dts
+++ /dev/null
@@ -1,238 +0,0 @@
-/*
- * Copyright 2016 Free Electrons
- * Copyright 2016 NextThing Co
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
-#include "sun5i-gr8.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "NextThing C.H.I.P. Pro";
-	compatible = "nextthing,chip-pro", "nextthing,gr8";
-
-	aliases {
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
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
-			label = "chip-pro:white:status";
-			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	mmc0_pwrseq: pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; /* PB10 */
-	};
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
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-
-		/*
-		* The interrupt is routed through the "External Fast
-		* Interrupt Request" pin (ball G13 of the module)
-		* directly to the main interrupt controller, without
-		* any other controller interfering.
-		*/
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&i2c1 {
-	status = "disabled";
-};
-
-&i2s0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2s0_mclk_pin>, <&i2s0_data_pins>;
-	status = "disabled";
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	mmc-pwrseq = <&mmc0_pwrseq>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-};
-
-&nfc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&nand_pins &nand_cs0_pin &nand_rb0_pin>;
-	status = "okay";
-
-	nand@0 {
-		reg = <0>;
-		allwinner,rb = <0>;
-		nand-ecc-mode = "hw";
-	};
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
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pin>, <&pwm1_pins>;
-	status = "disabled";
-};
-
-&reg_dcdc2 {
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-	regulator-always-on;
-};
-
-&reg_dcdc3 {
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1300000>;
-	regulator-name = "vdd-sys";
-	regulator-always-on;
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-min-microvolt = <2700000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "avcc";
-	regulator-always-on;
-};
-
-/*
- * Both LDO3 and LDO4 are used in parallel to power up the
- * WiFi/BT chip.
- */
-&reg_ldo3 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi-1";
-	regulator-always-on;
-};
-
-&reg_ldo4 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi-2";
-	regulator-always-on;
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pins>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2_pd_pins>, <&uart2_cts_rts_pd_pins>;
-	status = "disabled";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pg_pins>, <&uart3_cts_rts_pg_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	/*
-	 * The CHIP Pro doesn't have a controllable VBUS, nor does it
-	 * have any 5v rail on the board itself.
-	 *
-	 * If one wants to use it as a true OTG port, it should be
-	 * done in the baseboard, and its DT / overlay will add it.
-	 */
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usb_power_supply {
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
-	usb0_vbus_power-supply = <&usb_power_supply>;
-	usb1_vbus-supply = <&reg_vcc5v0>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-gr8-evb.dts b/arch/arm/dts/sun5i-gr8-evb.dts
deleted file mode 100644
index f4fe258ef06..00000000000
--- a/arch/arm/dts/sun5i-gr8-evb.dts
+++ /dev/null
@@ -1,333 +0,0 @@
-/*
- * Copyright 2016 Free Electrons
- * Copyright 2016 NextThing Co
- *
- * Mylène Josserand <mylene.josserand@free-electrons.com>
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
-#include "sun5i-gr8.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "NextThing GR8-EVB";
-	compatible = "nextthing,gr8-evb", "nextthing,gr8";
-
-	aliases {
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		serial0 = &uart1;
-		serial1 = &uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 10000 0>;
-		enable-gpios = <&axp_gpio 1 GPIO_ACTIVE_HIGH>;
-		power-supply = <&reg_vcc3v3>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-	};
-
-	sound-analog {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "gr8-evb-wm8978";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,mclk-fs = <512>;
-
-		simple-audio-card,cpu {
-			sound-dai = <&i2s0>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&wm8978>;
-		};
-	};
-
-	sound-spdif {
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
-&be0 {
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
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-
-		/*
-		* The interrupt is routed through the "External Fast
-		* Interrupt Request" pin (ball G13 of the module)
-		* directly to the main interrupt controller, without
-		* any other controller interfering.
-		*/
-		interrupts = <0>;
-	};
-};
-
-#include "axp209.dtsi"
-
-&i2c1 {
-	status = "okay";
-
-	wm8978: codec@1a {
-		#sound-dai-cells = <0>;
-		compatible = "wlf,wm8978";
-		reg = <0x1a>;
-	};
-
-	pcf8563: rtc@51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&i2s0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2s0_mclk_pin>, <&i2s0_data_pins>;
-	status = "okay";
-};
-
-&ir0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&ir0_rx_pin>;
-	status = "okay";
-};
-
-&lradc {
-	vref-supply = <&reg_ldo2>;
-	status = "okay";
-
-	button-190 {
-		label = "Volume Up";
-		linux,code = <KEY_VOLUMEUP>;
-		channel = <0>;
-		voltage = <190000>;
-	};
-
-	button-390 {
-		label = "Volume Down";
-		linux,code = <KEY_VOLUMEDOWN>;
-		channel = <0>;
-		voltage = <390000>;
-	};
-
-	button-600 {
-		label = "Menu";
-		linux,code = <KEY_MENU>;
-		channel = <0>;
-		voltage = <600000>;
-	};
-
-	button-800 {
-		label = "Search";
-		linux,code = <KEY_SEARCH>;
-		channel = <0>;
-		voltage = <800000>;
-	};
-
-	button-980 {
-		label = "Home";
-		linux,code = <KEY_HOMEPAGE>;
-		channel = <0>;
-		voltage = <980000>;
-	};
-
-	button-1180 {
-		label = "Esc";
-		linux,code = <KEY_ESC>;
-		channel = <0>;
-		voltage = <1180000>;
-	};
-
-	button-1400 {
-		label = "Enter";
-		linux,code = <KEY_ENTER>;
-		channel = <0>;
-		voltage = <1400000>;
-	};
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
-	status = "okay";
-};
-
-&nfc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&nand_pins &nand_cs0_pin &nand_rb0_pin>;
-
-	/* MLC Support sucks for now */
-	status = "disabled";
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
-&pwm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pin>;
-	status = "okay";
-};
-
-&reg_dcdc2 {
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-cpu";
-	regulator-always-on;
-};
-
-&reg_dcdc3 {
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1300000>;
-	regulator-name = "vdd-sys";
-	regulator-always-on;
-};
-
-&reg_ldo1 {
-	regulator-name = "vdd-rtc";
-};
-
-&reg_ldo2 {
-	regulator-min-microvolt = <2700000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "avcc";
-	regulator-always-on;
-};
-
-&reg_usb1_vbus {
-	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&rtp {
-	allwinner,ts-attached;
-};
-
-&spdif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spdif_tx_pin>;
-	status = "okay";
-};
-
-&tve0 {
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pins>;
-	status = "okay";
-};
-
-&usb_otg {
-	/*
-	 * The GR8-EVB has a somewhat interesting design. There's a
-	 * pin supposed to control VBUS, an ID pin, a VBUS detect pin,
-	 * so everything should work just fine.
-	 *
-	 * Except that the pin supposed to control VBUS is not
-	 * connected to any controllable output, neither to the SoC
-	 * through a GPIO or to the PMIC, and it is pulled down,
-	 * meaning that we will never be able to enable VBUS on this
-	 * board.
-	 */
-	dr_mode = "otg";
-	status = "okay";
-};
-
-&usb_power_supply {
-	status = "okay";
-};
-
-&usbphy {
-	usb0_id_det-gpios = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
-	usb0_vbus_det-gpios = <&pio 6 1 GPIO_ACTIVE_HIGH>; /* PG1 */
-	usb0_vbus_power-supply = <&usb_power_supply>;
-	usb1_vbus-supply = <&reg_usb1_vbus>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/sun5i-gr8.dtsi b/arch/arm/dts/sun5i-gr8.dtsi
deleted file mode 100644
index 98a8fd5e89e..00000000000
--- a/arch/arm/dts/sun5i-gr8.dtsi
+++ /dev/null
@@ -1,126 +0,0 @@
-/*
- * Copyright 2016 Mylène Josserand
- *
- * Mylène Josserand <mylene.josserand@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
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
-#include "sun5i.dtsi"
-
-#include <dt-bindings/clock/sun5i-ccu.h>
-#include <dt-bindings/dma/sun4i-a10.h>
-#include <dt-bindings/reset/sun5i-ccu.h>
-
-/ {
-	display-engine {
-		compatible = "allwinner,sun5i-a13-display-engine";
-		allwinner,pipelines = <&fe0>;
-	};
-
-	soc {
-		pwm: pwm@1c20e00 {
-			compatible = "allwinner,sun5i-a10s-pwm";
-			reg = <0x01c20e00 0xc>;
-			clocks = <&ccu CLK_HOSC>;
-			#pwm-cells = <3>;
-			status = "disabled";
-		};
-
-		spdif: spdif@1c21000 {
-			#sound-dai-cells = <0>;
-			compatible = "allwinner,sun4i-a10-spdif";
-			reg = <0x01c21000 0x400>;
-			interrupts = <13>;
-			clocks = <&ccu CLK_APB0_SPDIF>, <&ccu CLK_SPDIF>;
-			clock-names = "apb", "spdif";
-			dmas = <&dma SUN4I_DMA_NORMAL 2>,
-			       <&dma SUN4I_DMA_NORMAL 2>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		i2s0: i2s@1c22400 {
-			#sound-dai-cells = <0>;
-			compatible = "allwinner,sun4i-a10-i2s";
-			reg = <0x01c22400 0x400>;
-			interrupts = <16>;
-			clocks = <&ccu CLK_APB0_I2S>, <&ccu CLK_I2S>;
-			clock-names = "apb", "mod";
-			dmas = <&dma SUN4I_DMA_NORMAL 3>,
-			       <&dma SUN4I_DMA_NORMAL 3>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-	};
-};
-
-&ccu {
-	compatible = "nextthing,gr8-ccu";
-};
-
-&pio {
-	compatible = "nextthing,gr8-pinctrl";
-
-	i2s0_data_pins: i2s0-data-pins {
-		pins = "PB6", "PB7", "PB8", "PB9";
-		function = "i2s0";
-	};
-
-	i2s0_mclk_pin: i2s0-mclk-pin {
-		pins = "PB5";
-		function = "i2s0";
-	};
-
-	pwm1_pins: pwm1-pin {
-		pins = "PG13";
-		function = "pwm1";
-	};
-
-	spdif_tx_pin: spdif-tx-pin {
-		pins = "PB10";
-		function = "spdif";
-		bias-pull-up;
-	};
-
-	uart1_cts_rts_pins: uart1-cts-rts-pins {
-		pins = "PG5", "PG6";
-		function = "uart1";
-	};
-};
diff --git a/arch/arm/dts/sun5i-r8-chip.dts b/arch/arm/dts/sun5i-r8-chip.dts
deleted file mode 100644
index 8c784a2c086..00000000000
--- a/arch/arm/dts/sun5i-r8-chip.dts
+++ /dev/null
@@ -1,282 +0,0 @@
-/*
- * Copyright 2015 Free Electrons
- * Copyright 2015 NextThing Co
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
-#include "sun5i-r8.dtsi"
-#include "sunxi-common-regulators.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "NextThing C.H.I.P.";
-	compatible = "nextthing,chip", "allwinner,sun5i-r8", "allwinner,sun5i-a13";
-
-	aliases {
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		serial0 = &uart1;
-		serial1 = &uart3;
-		spi0 = &spi2;
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
-			label = "chip:white:status";
-			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
-	mmc0_pwrseq: pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&pio 2 19 GPIO_ACTIVE_LOW>; /* PC19 */
-	};
-
-	onewire {
-		compatible = "w1-gpio";
-		gpios = <&pio 3 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PD2 */
-	};
-};
-
-&be0 {
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
-&i2c0 {
-	status = "okay";
-
-	axp209: pmic@34 {
-		reg = <0x34>;
-
-		/*
-		 * The interrupt is routed through the "External Fast
-		 * Interrupt Request" pin (ball G13 of the module)
-		 * directly to the main interrupt controller, without
-		 * any other controller interfering.
-		 */
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
-	status = "disabled";
-};
-
-&i2c2 {
-	status = "okay";
-
-	xio: gpio@38 {
-		compatible = "nxp,pcf8574a";
-		reg = <0x38>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		interrupt-parent = <&pio>;
-		interrupts = <6 0 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-};
-
-&mmc0_pins {
-	bias-pull-up;
-};
-
-&mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
-	mmc-pwrseq = <&mmc0_pwrseq>;
-	bus-width = <4>;
-	non-removable;
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
-&reg_dcdc2 {
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "cpuvdd";
-	regulator-always-on;
-};
-
-&reg_dcdc3 {
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1300000>;
-	regulator-name = "corevdd";
-	regulator-always-on;
-};
-
-&reg_ldo1 {
-	regulator-name = "rtcvdd";
-};
-
-&reg_ldo2 {
-	regulator-min-microvolt = <2700000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "avcc";
-	regulator-always-on;
-};
-
-/*
- * Both LDO3 and LDO4 are used in parallel to power up the WiFi/BT
- * Chip.
- *
- * If those are not enabled, the SDIO part will not enumerate, and
- * since there's no way currently to pass DT infos to an SDIO device,
- * we cannot really do better than this ugly hack for now.
- */
-&reg_ldo3 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi-1";
-	regulator-always-on;
-};
-
-&reg_ldo4 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi-2";
-	regulator-always-on;
-};
-
-&reg_ldo5 {
-	regulator-min-microvolt = <1800000>;
-	regulator-max-microvolt = <1800000>;
-	regulator-name = "vcc-1v8";
-};
-
-&reg_usb0_vbus {
-	vin-supply = <&reg_vcc5v0>;
-	gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
-	status = "okay";
-};
-
-&spi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pe_pins>;
-	status = "disabled";
-};
-
-&tcon0 {
-	status = "okay";
-};
-
-&tve0 {
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pg_pins>,
-		    <&uart3_cts_rts_pg_pins>;
-	status = "okay";
-
-	bluetooth {
-		compatible = "realtek,rtl8723bs-bt";
-		device-wake-gpios = <&axp_gpio 3 GPIO_ACTIVE_HIGH>;
-		host-wake-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
-	};
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
-	status = "okay";
-
-	usb0_id_det-gpios = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
-	usb0_vbus_power-supply = <&usb_power_supply>;
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_vcc5v0>;
-};
diff --git a/arch/arm/dts/sun5i-r8.dtsi b/arch/arm/dts/sun5i-r8.dtsi
deleted file mode 100644
index de35dbcd119..00000000000
--- a/arch/arm/dts/sun5i-r8.dtsi
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * Copyright 2015 Free Electrons
- * Copyright 2015 NextThing Co
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
-#include "sun5i-a13.dtsi"
-
diff --git a/arch/arm/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/dts/sun5i-reference-design-tablet.dtsi
deleted file mode 100644
index 6847f66699a..00000000000
--- a/arch/arm/dts/sun5i-reference-design-tablet.dtsi
+++ /dev/null
@@ -1,194 +0,0 @@
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
-#include "sunxi-reference-design-tablet.dtsi"
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pwm/pwm.h>
-
-/ {
-	aliases {
-		serial0 = &uart1;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
-		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
-		default-brightness-level = <8>;
-		enable-gpios = <&axp_gpio 1 GPIO_ACTIVE_HIGH>; /* AXP GPIO1 */
-		power-supply = <&reg_vcc3v0>;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-};
-
-&codec {
-	allwinner,pa-gpios = <&pio 6 10 GPIO_ACTIVE_HIGH>; /* PG10 */
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
-	axp209: pmic@34 {
-		reg = <0x34>;
-		interrupts = <0>;
-	};
-};
-
-&i2c1 {
-	/*
-	 * The gsl1680 is rated at 400KHz and it will not work reliable at
-	 * 100KHz, this has been confirmed on multiple different q8 tablets.
-	 * All other devices on this bus are also rated for 400KHz.
-	 */
-	clock-frequency = <400000>;
-
-	touchscreen: touchscreen@40 {
-		reg = <0x40>;
-		interrupt-parent = <&pio>;
-		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>; /* EINT11 (PG11) */
-		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
-		/* Tablet dts must provide reg and compatible */
-		status = "disabled";
-	};
-
-	pcf8563: rtc@51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
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
-&lradc {
-	vref-supply = <&reg_ldo2>;
-};
-
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v0>;
-	bus-width = <4>;
-	cd-gpios = <&pio 6 0 GPIO_ACTIVE_LOW>; /* PG0 */
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
-	regulator-max-microvolt = <1500000>;
-	regulator-name = "vdd-cpu";
-};
-
-&reg_dcdc3 {
-	regulator-always-on;
-	regulator-min-microvolt = <1000000>;
-	regulator-max-microvolt = <1400000>;
-	regulator-name = "vdd-int-pll";
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
-&reg_ldo3 {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi";
-};
-
-&reg_usb0_vbus {
-	gpio = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pg_pins>;
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
-	usb0_id_det-gpios = <&pio 6 2 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PG2 */
-	usb0_vbus_det-gpios = <&pio 6 1 (GPIO_ACTIVE_HIGH | GPIO_PULL_DOWN)>; /* PG1 */
-	usb0_vbus_power-supply = <&usb_power_supply>;
-	usb0_vbus-supply = <&reg_usb0_vbus>;
-	usb1_vbus-supply = <&reg_ldo3>;
-	status = "okay";
-};
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 09d9f995d24..f941bf4a493 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -299,6 +299,7 @@ config MACH_SUN5I
 	select SUPPORT_SPL
 	imply SPL_SYS_I2C_LEGACY
 	imply SYS_I2C_LEGACY
+	imply OF_UPSTREAM
 
 config MACH_SUN6I
 	bool "sun6i (Allwinner A31)"
diff --git a/configs/A10s-OLinuXino-M_defconfig b/configs/A10s-OLinuXino-M_defconfig
index 841fe0d3f09..5a10fce7273 100644
--- a/configs/A10s-OLinuXino-M_defconfig
+++ b/configs/A10s-OLinuXino-M_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a10s-olinuxino-micro"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a10s-olinuxino-micro"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/A13-OLinuXinoM_defconfig b/configs/A13-OLinuXinoM_defconfig
index befe6d86b25..5001ce9ce52 100644
--- a/configs/A13-OLinuXinoM_defconfig
+++ b/configs/A13-OLinuXinoM_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-olinuxino-micro"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-olinuxino-micro"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/A13-OLinuXino_defconfig b/configs/A13-OLinuXino_defconfig
index 689ea533ee9..bc0fc0efe0a 100644
--- a/configs/A13-OLinuXino_defconfig
+++ b/configs/A13-OLinuXino_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-olinuxino"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-olinuxino"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/Ampe_A76_defconfig b/configs/Ampe_A76_defconfig
index 1087512235a..e38ecf56929 100644
--- a/configs/Ampe_A76_defconfig
+++ b/configs/Ampe_A76_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-ampe-a76"
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/Auxtek-T003_defconfig b/configs/Auxtek-T003_defconfig
index 7d81f12f766..520939538f8 100644
--- a/configs/Auxtek-T003_defconfig
+++ b/configs/Auxtek-T003_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a10s-auxtek-t003"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a10s-auxtek-t003"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/Auxtek-T004_defconfig b/configs/Auxtek-T004_defconfig
index 4c7154b04c4..8b3a9eac788 100644
--- a/configs/Auxtek-T004_defconfig
+++ b/configs/Auxtek-T004_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a10s-auxtek-t004"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a10s-auxtek-t004"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/CHIP_defconfig b/configs/CHIP_defconfig
index cd9bdbfd36f..c220d269ab6 100644
--- a/configs/CHIP_defconfig
+++ b/configs/CHIP_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-r8-chip"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-r8-chip"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_TIMINGS_DDR3_800E_1066G_1333J=y
diff --git a/configs/CHIP_pro_defconfig b/configs/CHIP_pro_defconfig
index 59df41a1502..05874125f4b 100644
--- a/configs/CHIP_pro_defconfig
+++ b/configs/CHIP_pro_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-gr8-chip-pro"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-gr8-chip-pro"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_TIMINGS_DDR3_800E_1066G_1333J=y
diff --git a/configs/Empire_electronix_d709_defconfig b/configs/Empire_electronix_d709_defconfig
index 4bd3b569392..18b1cfaa811 100644
--- a/configs/Empire_electronix_d709_defconfig
+++ b/configs/Empire_electronix_d709_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-empire-electronix-d709"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-empire-electronix-d709"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/Empire_electronix_m712_defconfig b/configs/Empire_electronix_m712_defconfig
index 18873dba340..abaf386563e 100644
--- a/configs/Empire_electronix_m712_defconfig
+++ b/configs/Empire_electronix_m712_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-empire-electronix-m712"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-empire-electronix-m712"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/UTOO_P66_defconfig b/configs/UTOO_P66_defconfig
index 88a082c0567..d74ef2127d9 100644
--- a/configs/UTOO_P66_defconfig
+++ b/configs/UTOO_P66_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-utoo-p66"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-utoo-p66"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/Wobo_i5_defconfig b/configs/Wobo_i5_defconfig
index 9e9bddb7649..9f6d2a78f48 100644
--- a/configs/Wobo_i5_defconfig
+++ b/configs/Wobo_i5_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a10s-wobo-i5"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a10s-wobo-i5"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/difrnce_dit4350_defconfig b/configs/difrnce_dit4350_defconfig
index f54a83d929d..b0604302c97 100644
--- a/configs/difrnce_dit4350_defconfig
+++ b/configs/difrnce_dit4350_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-difrnce-dit4350"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-difrnce-dit4350"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/iNet_86VS_defconfig b/configs/iNet_86VS_defconfig
index 2c8ecb51de0..42c9da9f947 100644
--- a/configs/iNet_86VS_defconfig
+++ b/configs/iNet_86VS_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-inet-86vs"
+# CONFIG_OF_UPSTREAM is not set
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=408
diff --git a/configs/inet98v_rev2_defconfig b/configs/inet98v_rev2_defconfig
index e4da6c14d04..48b20c0eefa 100644
--- a/configs/inet98v_rev2_defconfig
+++ b/configs/inet98v_rev2_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-inet-98v-rev2"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-inet-98v-rev2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/mk802_a10s_defconfig b/configs/mk802_a10s_defconfig
index 21f7a6e535d..d3d7402f828 100644
--- a/configs/mk802_a10s_defconfig
+++ b/configs/mk802_a10s_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a10s-mk802"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a10s-mk802"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=432
diff --git a/configs/q8_a13_tablet_defconfig b/configs/q8_a13_tablet_defconfig
index 36252e5f89a..93a257853b3 100644
--- a/configs/q8_a13_tablet_defconfig
+++ b/configs/q8_a13_tablet_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a13-q8-tablet"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a13-q8-tablet"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=384
diff --git a/configs/r7-tv-dongle_defconfig b/configs/r7-tv-dongle_defconfig
index 8875a09b2c9..0c9f6197c2c 100644
--- a/configs/r7-tv-dongle_defconfig
+++ b/configs/r7-tv-dongle_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
-CONFIG_DEFAULT_DEVICE_TREE="sun5i-a10s-r7-tv-dongle"
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun5i-a10s-r7-tv-dongle"
 CONFIG_SPL=y
 CONFIG_MACH_SUN5I=y
 CONFIG_DRAM_CLK=384
-- 
2.46.2

