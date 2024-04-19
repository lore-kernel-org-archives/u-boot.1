Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4E3C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 06:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982F38869A;
	Fri, 19 Apr 2024 08:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="F9H972Uh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C39C88699; Fri, 19 Apr 2024 08:51:34 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9705E8863C
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713509489; x=1716101489;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=roiymwZOF844anhc6U6cvQ7UJcFHwxvLE1cI3tbZwSw=;
 b=F9H972UhlA4MsAKUx9feDr99KIMhxb9keW8LpJWVx1Lobj8uOIck2wYhBkrxFfrC
 PpuHaaOrMz1y/RQkR7d/kxMnk++oZLpewu8NeGFuaEKV7OxdhBl+rhPpHg+hDY0N
 w0LX2Na7yz0QAcDQQLYomusArjIHY/x4TI3BWmJ8llU=;
X-AuditID: ac14000a-fadff7000000290d-78-66221471ee4d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id BB.95.10509.17412266;
 Fri, 19 Apr 2024 08:51:29 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 08:51:29 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>
Subject: [PATCH 3/3] phycore-rk3288: Migrate to OF_UPSTREAM
Date: Fri, 19 Apr 2024 08:51:17 +0200
Message-ID: <20240419065117.2305346-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419065117.2305346-1-w.egorov@phytec.de>
References: <20240419065117.2305346-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWyRpKBR7dQRCnN4MVUQYu3ezvZLbrfqTsw
 eZy9s4PRo7+7hTWAKYrLJiU1J7MstUjfLoErY/23VsaC1/sZK073XWRvYHw5jbGLkZNDQsBE
 Yt+az8xdjFwcQgJLmCQuLfsE5TxmlHi5/BtYFZuAusSdDd9YQWwRASmJl50bgYo4OJgF5CSW
 9ReBhIUFrCWmdO1nAbFZBFQlLn5bwghSwitgKbF5nT/ELnmJmZe+s4PYnAJWEm9fLmMGsYWA
 SqbPaATbxCsgKHFy5hOwMcxA9c1bZzND2BISB1+8gKqXl3hxaTkLzMxp514zQ9ihElu/bGea
 wCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoAAWYeDawdg3x+MQIxMH
 4yFGCQ5mJRFeMw7FNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2Cy
 TBycUg2M7ubthquXGLRdLDe66ea7vOC+BK/FXuf4avsf82qTNjnNtReeat2opfI66tqtg68u
 2EwX475nvWrCqs5tLMpNk3sdDsyW4f7gfz/u3PQtzKKrzp0SE/4joOP5T9Uw1STZqOfBhA/2
 u15c+s59Kfn2fga9rzKhvMLJa5XfmL3O1p1pUWj29K6ZEktxRqKhFnNRcSIA1G2UXU4CAAA=
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

The phycore-rk3288 can be migrated to OF_UPSTREAM.
Drop redundant device tree files, update MAINTAINERS and
defconfig's DEFAULT_DEVICE_TREE for rockchip vendor prefix accordingly.
Move device tree nodes required for u-boot to rk3288-phycore-rdk-u-boot.dtsi
such as chosen, i2c_eeprom_id and it's alias.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/Makefile                       |   1 -
 arch/arm/dts/rk3288-phycore-rdk-u-boot.dtsi |  19 +
 arch/arm/dts/rk3288-phycore-rdk.dts         | 271 -----------
 arch/arm/dts/rk3288-phycore-som.dtsi        | 506 --------------------
 board/phytec/phycore_rk3288/MAINTAINERS     |   2 -
 configs/phycore-rk3288_defconfig            |   7 +-
 6 files changed, 23 insertions(+), 783 deletions(-)
 delete mode 100644 arch/arm/dts/rk3288-phycore-rdk.dts
 delete mode 100644 arch/arm/dts/rk3288-phycore-som.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 48a2b85542..a7a97a9f08 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -81,7 +81,6 @@ dtb-$(CONFIG_ROCKCHIP_RK3288) += \
 	rk3288-evb.dtb \
 	rk3288-firefly.dtb \
 	rk3288-miqi.dtb \
-	rk3288-phycore-rdk.dtb \
 	rk3288-popmetal.dtb \
 	rk3288-rock2-square.dtb \
 	rk3288-rock-pi-n8.dtb \
diff --git a/arch/arm/dts/rk3288-phycore-rdk-u-boot.dtsi b/arch/arm/dts/rk3288-phycore-rdk-u-boot.dtsi
index 383b383acc..12096eec54 100644
--- a/arch/arm/dts/rk3288-phycore-rdk-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-phycore-rdk-u-boot.dtsi
@@ -2,6 +2,16 @@
 
 #include "rk3288-u-boot.dtsi"
 
+/ {
+	aliases {
+		eeprom0 = &i2c_eeprom_id;
+	};
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
+
 &dmc {
 	rockchip,num-channels = <2>;
 	rockchip,pctl-timing = <0x29a 0xc8 0x1f8 0x42 0x4e 0x4 0xea 0xa
@@ -29,6 +39,15 @@
 			bootph-all;
 		};
 	};
+
+	/* M24C32-D Identification page */
+	i2c_eeprom_id: eeprom@58 {
+		bootph-all;
+
+		compatible = "atmel,24c32";
+		reg = <0x58>;
+		pagesize = <32>;
+	};
 };
 
 &pinctrl {
diff --git a/arch/arm/dts/rk3288-phycore-rdk.dts b/arch/arm/dts/rk3288-phycore-rdk.dts
deleted file mode 100644
index ebea8e67ea..0000000000
--- a/arch/arm/dts/rk3288-phycore-rdk.dts
+++ /dev/null
@@ -1,271 +0,0 @@
-/*
- * Device tree file for Phytec PCM-947 carrier board
- * Copyright (C) 2017 PHYTEC Messtechnik GmbH
- * Author: Wadim Egorov <w.egorov@phytec.de>
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
-
-#include <dt-bindings/input/input.h>
-#include "rk3288-phycore-som.dtsi"
-
-/ {
-	model = "Phytec RK3288 PCM-947";
-	compatible = "phytec,rk3288-pcm-947", "phytec,rk3288-phycore-som", "rockchip,rk3288";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	user_buttons: user-buttons {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&user_button_pins>;
-
-		button@0 {
-			label = "home";
-			linux,code = <KEY_HOME>;
-			gpios = <&gpio8 0 GPIO_ACTIVE_HIGH>;
-			wakeup-source;
-		};
-
-		button@1 {
-			label = "menu";
-			linux,code = <KEY_MENU>;
-			gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
-			wakeup-source;
-		};
-	};
-
-	vcc_host0_5v: usb-host0-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host0_vbus_drv>;
-		regulator-name = "vcc_host0_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		vin-supply = <&vdd_in_otg_out>;
-	};
-
-	vcc_host1_5v: usb-host1-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio2 0 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&host1_vbus_drv>;
-		regulator-name = "vcc_host1_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		vin-supply = <&vdd_in_otg_out>;
-	};
-
-	vcc_otg_5v: usb-otg-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&otg_vbus_drv>;
-		regulator-name = "vcc_otg_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		vin-supply = <&vdd_in_otg_out>;
-	};
-};
-
-&gmac {
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-
-	touchscreen@44 {
-		compatible = "st,stmpe811";
-		reg = <0x44>;
-	};
-
-	adc@64 {
-		compatible = "maxim,max1037";
-		reg = <0x64>;
-	};
-
-	i2c_rtc: rtc@68 {
-		compatible = "rv4162";
-		reg = <0x68>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c_rtc_int>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <10 0>;
-	};
-};
-
-&i2c3 {
-	status = "okay";
-
-	i2c_eeprom_cb: eeprom@51 {
-		compatible = "atmel,24c32";
-		reg = <0x51>;
-		pagesize = <32>;
-	};
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
-	pcfg_pull_up_drv_12ma: pcfg-pull-up-drv-12ma {
-		bias-pull-up;
-		drive-strength = <12>;
-	};
-
-	buttons {
-		user_button_pins: user-button-pins {
-			/* button 1 */
-			rockchip,pins = <8 3 RK_FUNC_GPIO &pcfg_pull_up>,
-			/* button 2 */
-					<8 0 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	rv4162 {
-		i2c_rtc_int: i2c-rtc-int {
-			rockchip,pins = <5 10 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	sdmmc {
-		/*
-		 * Default drive strength isn't enough to achieve even
-		 * high-speed mode on pcm-947 board so bump up to 12 mA.
-		 */
-		sdmmc_bus4: sdmmc-bus4 {
-			rockchip,pins = <6 16 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
-					<6 17 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
-					<6 18 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
-					<6 19 RK_FUNC_1 &pcfg_pull_up_drv_12ma>;
-		};
-
-		sdmmc_clk: sdmmc-clk {
-			rockchip,pins = <6 20 RK_FUNC_1 &pcfg_pull_none_12ma>;
-		};
-
-		sdmmc_cmd: sdmmc-cmd {
-			rockchip,pins = <6 21 RK_FUNC_1 &pcfg_pull_up_drv_12ma>;
-		};
-
-		sdmmc_pwr: sdmmc-pwr {
-			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	touchscreen {
-		ts_irq_pin: ts-irq-pin {
-			rockchip,pins = <5 15 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_host {
-		host0_vbus_drv: host0-vbus-drv {
-			rockchip,pins = <2 13 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		host1_vbus_drv: host1-vbus-drv {
-			rockchip,pins = <2 0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	usb_otg {
-		otg_vbus_drv: otg-vbus-drv {
-			rockchip,pins = <2 12 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
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
-	vmmc-supply = <&vdd_io_sd>;
-	vqmmc-supply = <&vdd_io_sd>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
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
-	status = "okay";
-};
-
-&usb_otg {
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3288-phycore-som.dtsi b/arch/arm/dts/rk3288-phycore-som.dtsi
deleted file mode 100644
index bde5910ff6..0000000000
--- a/arch/arm/dts/rk3288-phycore-som.dtsi
+++ /dev/null
@@ -1,506 +0,0 @@
-/*
- * Device tree file for Phytec phyCORE-RK3288 SoM
- * Copyright (C) 2017 PHYTEC Messtechnik GmbH
- * Author: Wadim Egorov <w.egorov@phytec.de>
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
-#include <dt-bindings/net/ti-dp83867.h>
-#include "rk3288.dtsi"
-
-/ {
-	model = "Phytec RK3288 phyCORE";
-	compatible = "phytec,rk3288-phycore-som", "rockchip,rk3288";
-
-	/*
-	 * Set the minimum memory size here and
-	 * let the bootloader set the real size.
-	 */
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	aliases {
-		rtc0 = &i2c_rtc;
-		rtc1 = &rk818;
-		eeprom0 = &i2c_eeprom_id;
-	};
-
-	ext_gmac: external-gmac-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-		clock-output-names = "ext_gmac";
-	};
-
-	leds: user-leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&user_led>;
-
-		user {
-			label = "green_led";
-			gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-			default-state = "keep";
-		};
-	};
-
-	vdd_emmc_io: vdd-emmc-io {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_emmc_io";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vdd_3v3_io>;
-	};
-
-	vdd_in_otg_out: vdd-in-otg-out {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_in_otg_out";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	vdd_misc_1v8: vdd-misc-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_misc_1v8";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-	operating-points = <
-		/* KHz    uV */
-		1800000	1400000
-		1608000	1350000
-		1512000 1300000
-		1416000 1200000
-		1200000 1100000
-		1008000 1050000
-		 816000 1000000
-		 696000  950000
-		 600000  900000
-		 408000  900000
-		 312000  900000
-		 216000  900000
-		 126000  900000
-	>;
-};
-
-&emmc {
-	status = "okay";
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	disable-wp;
-	non-removable;
-	num-slots = <1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
-	vmmc-supply = <&vdd_3v3_io>;
-	vqmmc-supply = <&vdd_emmc_io>;
-};
-
-&gmac {
-	assigned-clocks = <&cru SCLK_MAC>;
-	assigned-clock-parents = <&ext_gmac>;
-	clock_in_out = "input";
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_pins &phy_rst &phy_int>;
-	phy-handle = <&phy0>;
-	phy-supply = <&vdd_eth_2v5>;
-	phy-mode = "rgmii-id";
-	snps,reset-active-low;
-	snps,reset-delays-us = <0 10000 1000000>;
-	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_HIGH>;
-	tx_delay = <0x0>;
-	rx_delay = <0x0>;
-
-	mdio0 {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		phy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			interrupt-parent = <&gpio4>;
-			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
-			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-			enet-phy-lane-no-swap;
-		};
-	};
-};
-
-&hdmi {
-	ddc-i2c-bus = <&i2c5>;
-};
-
-&io_domains {
-	audio-supply = <&vdd_3v3_io>;
-	bb-supply = <&vdd_3v3_io>;
-	dvp-supply = <&vdd_3v3_io>;
-	flash0-supply = <&vdd_emmc_io>;
-	flash1-supply = <&vdd_misc_1v8>;
-	gpio1830-supply = <&vdd_3v3_io>;
-	gpio30-supply = <&vdd_3v3_io>;
-	lcdc-supply = <&vdd_3v3_io>;
-	sdcard-supply = <&vdd_io_sd>;
-	wifi-supply = <&vdd_3v3_io>;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-	clock-frequency = <400000>;
-
-	rk818: pmic@1c {
-		status = "okay";
-		compatible = "rockchip,rk818";
-		reg = <0x1c>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>;
-		rockchip,system-power-controller;
-		wakeup-source;
-		#clock-cells = <1>;
-
-		vcc1-supply = <&vdd_sys>;
-		vcc2-supply = <&vdd_sys>;
-		vcc3-supply = <&vdd_sys>;
-		vcc4-supply = <&vdd_sys>;
-		boost-supply = <&vdd_in_otg_out>;
-		vcc6-supply = <&vdd_sys>;
-		vcc7-supply = <&vdd_misc_1v8>;
-		vcc8-supply = <&vdd_misc_1v8>;
-		vcc9-supply = <&vdd_3v3_io>;
-		vddio-supply = <&vdd_3v3_io>;
-
-		regulators {
-			vdd_log: DCDC_REG1 {
-				regulator-name = "vdd_log";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			vdd_gpu: DCDC_REG2 {
-				regulator-name = "vdd_gpu";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1250000>;
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
-			vdd_3v3_io: DCDC_REG4 {
-				regulator-name = "vdd_3v3_io";
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
-			vdd_sys: DCDC_BOOST {
-				regulator-name = "vdd_sys";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5000000>;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <5000000>;
-				};
-			};
-
-			/* vcc9 */
-			vdd_sd: SWITCH_REG {
-				regulator-name = "vdd_sd";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-				};
-			};
-
-			/* vcc6 */
-			vdd_eth_2v5: LDO_REG2 {
-				regulator-name = "vdd_eth_2v5";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <2500000>;
-				};
-			};
-
-			/* vcc7 */
-			vdd_1v0: LDO_REG3 {
-				regulator-name = "vdd_1v0";
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
-			/* vcc8 */
-			vdd_1v8_lcd_ldo: LDO_REG4 {
-				regulator-name = "vdd_1v8_lcd_ldo";
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
-			/* vcc8 */
-			vdd_1v0_lcd: LDO_REG6 {
-				regulator-name = "vdd_1v0_lcd";
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
-			/* vcc7 */
-			vdd_1v8_ldo: LDO_REG7 {
-				regulator-name = "vdd_1v8_ldo";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			/* vcc9 */
-			vdd_io_sd: LDO_REG9 {
-				regulator-name = "vdd_io_sd";
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-		};
-	};
-
-	/* M24C32-D */
-	i2c_eeprom: eeprom@50 {
-		compatible = "atmel,24c32";
-		reg = <0x50>;
-		pagesize = <32>;
-	};
-
-	/* M24C32-D Identification page */
-	i2c_eeprom_id: eeprom@58 {
-		compatible = "atmel,24c32";
-		reg = <0x58>;
-		pagesize = <32>;
-	};
-
-	vdd_cpu: regulator@60 {
-		compatible = "fcs,fan53555";
-		reg = <0x60>;
-		fcs,suspend-voltage-selector = <1>;
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-enable-ramp-delay = <300>;
-		regulator-name = "vdd_cpu";
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1430000>;
-		regulator-ramp-delay = <8000>;
-		vin-supply = <&vdd_sys>;
-	};
-};
-
-&pinctrl {
-	pcfg_output_high: pcfg-output-high {
-		output-high;
-	};
-
-	emmc {
-		/*
-		 * We run eMMC at max speed; bump up drive strength.
-		 * We also have external pulls, so disable the internal ones.
-		 */
-		emmc_clk: emmc-clk {
-			rockchip,pins = <3 18 RK_FUNC_2 &pcfg_pull_none_12ma>;
-		};
-
-		emmc_cmd: emmc-cmd {
-			rockchip,pins = <3 16 RK_FUNC_2 &pcfg_pull_none_12ma>;
-		};
-
-		emmc_bus8: emmc-bus8 {
-			rockchip,pins = <3 0 RK_FUNC_2 &pcfg_pull_none_12ma>,
-					<3 1 RK_FUNC_2 &pcfg_pull_none_12ma>,
-					<3 2 RK_FUNC_2 &pcfg_pull_none_12ma>,
-					<3 3 RK_FUNC_2 &pcfg_pull_none_12ma>,
-					<3 4 RK_FUNC_2 &pcfg_pull_none_12ma>,
-					<3 5 RK_FUNC_2 &pcfg_pull_none_12ma>,
-					<3 6 RK_FUNC_2 &pcfg_pull_none_12ma>,
-					<3 7 RK_FUNC_2 &pcfg_pull_none_12ma>;
-		};
-	};
-
-	gmac {
-		phy_int: phy-int {
-			rockchip,pins = <4 2 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		phy_rst: phy-rst {
-			rockchip,pins = <4 8 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	leds {
-		user_led: user-led {
-			rockchip,pins = <7 2 RK_FUNC_GPIO &pcfg_output_high>;
-		};
-	};
-
-	pmic {
-		pmic_int: pmic-int {
-			rockchip,pins = <RK_GPIO0 4 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		/* Pin for switching state between sleep and non-sleep state */
-		pmic_sleep: pmic-sleep {
-			rockchip,pins = <RK_GPIO0 0 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&saradc {
-	status = "okay";
-	vref-supply = <&vdd_1v8_ldo>;
-};
-
-&spi2 {
-	status = "okay";
-
-	serial_flash: flash@0 {
-		compatible = "micron,n25q128a13", "jedec,spi-nor";
-		reg = <0x0>;
-		spi-max-frequency = <50000000>;
-		m25p,fast-read;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		status = "okay";
-	};
-};
-
-&tsadc {
-	status = "okay";
-	rockchip,hw-tshut-mode = <0>;
-	rockchip,hw-tshut-polarity = <0>;
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
diff --git a/board/phytec/phycore_rk3288/MAINTAINERS b/board/phytec/phycore_rk3288/MAINTAINERS
index 60471d478b..e3b0af98e9 100644
--- a/board/phytec/phycore_rk3288/MAINTAINERS
+++ b/board/phytec/phycore_rk3288/MAINTAINERS
@@ -1,9 +1,7 @@
 phyCORE-RK3288
 M:	Wadim Egorov <w.egorov@phytec.de>
 S:	Maintained
-F:	arch/arm/dts/rk3288-phycore-rdk.dts
 F:	arch/arm/dts/rk3288-phycore-rdk-u-boot.dtsi
-F:	arch/arm/dts/rk3288-phycore-som.dtsi
 F:	board/phytec/phycore_rk3288
 F:	include/configs/phycore_rk3288.h
 F:	configs/phycore-rk3288_defconfig
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index ce999e48df..87b259b71d 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -8,7 +8,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_DEFAULT_DEVICE_TREE="rk3288-phycore-rdk"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-phycore-rdk"
 CONFIG_SPL_TEXT_BASE=0xff704000
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
@@ -16,6 +16,8 @@ CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 CONFIG_TARGET_PHYCORE_RK3288=y
 CONFIG_SPL_STACK_R_ADDR=0x80000
 CONFIG_SPL_STACK=0xff718000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000
 CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
@@ -31,8 +33,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -48,6 +48,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-- 
2.25.1

