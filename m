Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FE8D5CCA1
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 12:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 061D08921B;
	Wed, 30 Oct 2024 13:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="X/QCXlKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E99D89208; Wed, 30 Oct 2024 13:09:52 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by phobos.denx.de (Postfix) with ESMTP id 0381F88B9F
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=nmheP
 RoX8gFT5v78T0L79RVnlUGkTzNl63xKNyNP6hc=; b=X/QCXlKYn+qo3Nuse6jDE
 OQSiZ2mWe5qxsS5HKJ9eMlc3SMzulB5BrJ7YWwPtsZs4qBjx4zkDphjebc94aF2E
 xUmG98HsU9SQaoPhrD7tdbDPF+/9Agf/8SnCpv1J7E/MzSqLZDIrfiiITrZQnVjC
 PTDxCzgeXknimE3YR5iz8M=
Received: from ProDesk.. (unknown [58.22.7.114])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgD3n7L3ISJn2HV2Ag--.48133S3;
 Wed, 30 Oct 2024 20:09:32 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kever.yang@rock-chips.com
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, dsimic@manjaro.org,
 jonas@kwiboo.se, Andy Yan <andyshrk@163.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v4 1/2] arm64: dts: rockchip: Add support for rk3588 based
 Cool Pi CM5 GenBook
Date: Wed, 30 Oct 2024 20:09:19 +0800
Message-ID: <20241030120926.399775-2-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241030120926.399775-1-andyshrk@163.com>
References: <20241030120926.399775-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgD3n7L3ISJn2HV2Ag--.48133S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyfZF15AF45urWUJw1rtFb_yoWfWF15pa
 9xurZ0kFZ5ZFW8Jw4DXa4xKF1rWa1vka97Cr97ZF48WrWqk3WDZas29r1rZF1kGrs7Xw43
 AFW5Zry7tFsFqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziLID7UUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwGIXmciHA1jpgABs0
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

Cool Pi CM5 GenBook works as a carrier board connect with CM5 [0].

Specification:
- Rockchip RK3588
- LPDDR5X 8/32 GB
- eMMC 64 GB
- HDMI Type A out x 1
- USB 3.0 Host x 1
- USB-C 3.0 with DisplayPort AltMode
- PCIE M.2 E Key for RTL8852BE Wireless connection
- PCIE M.2 M Key for NVME connection
- eDP panel with 1920x1080

This patch add basic support to bringup eMMC/USB HOST/WiFi/TouchPad/
Battery/PCIE NVME, and can also drive a HDMI output with out of tree
hdmi patches.

[0] https://www.crowdsupply.com/shenzhen-tianmao-technology-co-ltd/genbook-rk3588

Signed-off-by: Andy Yan <andyshrk@163.com>
Link: https://lore.kernel.org/r/20240730102433.540260-3-andyshrk@163.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 4a8c1161b843c366776fc872a6fe45b743b2983e ]

(cherry picked from commit dc6316da23734d9321e09f8c8a7669f4b4cb9f75)

---

(no changes since v2)

Changes in v2:
- Cherry pick it from https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git

 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 349 ++++++++++++++++++
 1 file changed, 349 insertions(+)
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
new file mode 100644
index 00000000000..6418286efe4
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include "rk3588-coolpi-cm5.dtsi"
+
+/ {
+	model = "CoolPi CM5 GenBook";
+	compatible = "coolpi,pi-cm5-genbook", "coolpi,pi-cm5", "rockchip,rk3588";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		enable-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en>;
+		power-supply = <&vcc12v_dcin>;
+		pwms = <&pwm6 0 25000 0>;
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <9800000>;
+		voltage-max-design-microvolt = <4350000>;
+		voltage-min-design-microvolt = <3000000>;
+	};
+
+	charger: dc-charger {
+		compatible = "gpio-charger";
+		charger-type = "mains";
+		gpios = <&gpio1 RK_PC0 GPIO_ACTIVE_LOW>;
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+
+		heartbeat_led: led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		wlan_led: led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN;
+			gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+		};
+
+		charging_red: led-2 {
+			function = LED_FUNCTION_CHARGING;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio3 RK_PD2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	vcc12v_dcin: vcc12v-dcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <7000000>;
+		regulator-max-microvolt = <7000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <7000000>;
+		regulator-max-microvolt = <7000000>;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_lcd: vcc3v3-lcd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_lcd";
+		enable-active-high;
+		gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcdpwr_en>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-boot-on;
+		regulator-always-on;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_pwren>;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vcc5v0_usb_host0: vcc5v0_usb30_host: vcc5v0-usb-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_host";
+		regulator-boot-on;
+		regulator-always-on;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_pwren>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m3_xfer>;
+
+	cw2015@62 {
+		compatible = "cellwise,cw2015";
+		reg = <0x62>;
+
+		cellwise,battery-profile = /bits/ 8 <
+			0x17 0x67 0x69 0x63 0x63 0x62 0x62 0x5F
+			0x52 0x73 0x4C 0x5A 0x5B 0x4B 0x42 0x3A
+			0x33 0x2D 0x29 0x28 0x2E 0x31 0x3C 0x49
+			0x2C 0x2C 0x0C 0xCD 0x30 0x51 0x50 0x66
+			0x74 0x74 0x75 0x78 0x41 0x1B 0x84 0x5F
+			0x0B 0x34 0x1C 0x45 0x89 0x92 0xA0 0x13
+			0x2C 0x55 0xAB 0xCB 0x80 0x5E 0x7B 0xCB
+			0x2F 0x00 0x64 0xA5 0xB5 0x10 0x18 0x21
+			>;
+
+		cellwise,monitor-interval-ms = <3000>;
+		monitored-battery = <&battery>;
+		power-supplies = <&charger>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5m3_xfer>;
+
+	touchpad: touchpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PD6 IRQ_TYPE_LEVEL_LOW>;
+		hid-descr-addr = <0x0020>;
+	};
+};
+
+&gmac0 {
+	status = "disabled";
+};
+
+/* M.2 E-Key */
+&pcie2x1l0 {
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_sys>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreq &pcie_wake &pcie_rst &wifi_pwron &bt_pwron>;
+	status = "okay";
+};
+
+&pcie2x1l2 {
+	status = "disabled";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+/* M.2 M-Key ssd */
+&pcie3x4 {
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_sys>;
+	status = "okay";
+};
+
+&pinctrl {
+	lcd {
+		lcdpwr_en: lcdpwr-en {
+			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		bl_en: bl-en {
+			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		usb_pwren: usb-pwren {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		usb_otg_pwren: usb-otg-pwren {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		usb_host_pwren: usb-host-pwren {
+			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	wifi {
+		bt_pwron: bt-pwron {
+			rockchip,pins = <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie_clkreq: pcie-clkreq {
+			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie_rst: pcie-rst {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		wifi_pwron: wifi-pwron {
+			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie_wake: pcie-wake {
+			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pwm6 {
+	pinctrl-0 = <&pwm6m1_pins>;
+	status = "okay";
+};
+
+&sdmmc {
+	status = "disabled";
+};
+
+&sfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspim2_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <100000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdp_phy0 {
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
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	phy-supply = <&vcc5v0_usb_host0>;
+	status = "okay";
+};
+
+&u2phy3_host {
+	phy-supply = <&vcc5v0_usb>;
+	status = "okay";
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
+/* For Keypad */
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/* Type C port */
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
+
+/* connected to a HUB for camera and BT */
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+/* USB A out */
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
-- 
2.34.1

