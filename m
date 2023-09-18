Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AC9CD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 17:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94BDC86A2A;
	Mon, 18 Sep 2023 19:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="QW54pAr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC20686A7B; Mon, 18 Sep 2023 19:52:35 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB7086998
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 19:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 2276cef6-564c-11ee-bf57-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 2276cef6-564c-11ee-bf57-00505699b430;
 Mon, 18 Sep 2023 19:52:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=vigmnBOpNM5fLivWPhxQij9zn96ElnyCYuy8+yEI9Nc=;
 b=QW54pAr6cktQzDhKt8PAXW3hYr/R9+x9S+1+AF57tJkbfebwiCHmORqKm6QWvzRbnaktB0ECVhQiW
 yox8Tntqlx3HJsCA2J78IVD97EcJvGTGMGtsr5SNu/PezadJyEf1CtRCBkF5PndJlLgaO++YZENIu8
 5drDLFW9kIiYQ62/SQvd+QtocJXEe13+Za2Of6q1+17iw1CIoRqH0atkXN4XyfqPv8aE0yOLF93ijt
 h5TKUogUsLfHoegdhSbp4DcrWDGtjcaz2qKm42C484zdixJ3k9ihoKLJy8V7OeRfnvI00ak7TgvGRB
 26RRq3lUXDlBCerxZRDOF4XrYvjpufA==
X-KPN-MID: 33|Rw4Fu2KdW0BqLo+8v6bvqHNngVrd9YdbQGEjk7UvEDv0dvYKUD/0o4zUQqLHv6B
 t1yOQntpWv8yIr2CXwQ60IRsNN4lI9GTLY8suNIHrCYs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|W1zoVXZtv4dRw7xjg4IUriwnBJaG8S+Ty3Y2i8zHuasArf/p3CrQ3Rd8xcBk6Xr
 lwQzNKDWUJqqOP0ETTiO8iQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 23c3358d-564c-11ee-ac77-00505699b758;
 Mon, 18 Sep 2023 19:52:32 +0200 (CEST)
Date: Mon, 18 Sep 2023 19:52:31 +0200
Message-Id: <87wmwne5cw.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Frank Wunderlich <linux@fw-web.de>
Cc: u-boot@lists.denx.de, frank-w@public-files.de, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, jonas@kwiboo.se
In-Reply-To: <20230918173624.31464-1-linux@fw-web.de> (message from Frank
 Wunderlich on Mon, 18 Sep 2023 19:36:24 +0200)
Subject: Re: [PATCH v4] board: rockchip: Add Bananapi R2Pro Board
References: <20230918173624.31464-1-linux@fw-web.de>
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

> From: Frank Wunderlich <linux@fw-web.de>
> Date: Mon, 18 Sep 2023 19:36:24 +0200
> 
> Add Bananapi R2 Pro board.
> 
> tested:
> - sdcard
> - both front usb-ports
> - sata
> - wan-port
> 
> lan-ports are connected to mt7531 switch where driver needs to be separated from mtk ethernet-driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> because iodomain is different to evb and now iodomain driver is sent as
> patch we need to separate between EVB and R2Pro else board can be bricked.
> ---
> v4:
> - add r2pro board to readme
> - update r2pro dts to linux version
> - remove switch node from linux dts
> - disable gmac0 because switch driver does not work yet
>   to solve timeout error:
>   ethernet@fe2a0000 Waiting for PHY auto negotiation to complete......... TIMEOUT!
>   phy_startup() failed: -110FAILED: -110ethernet@fe010000 Waiting for PHY auto nee
> - cleanup r2pro u-boot.dtsi like jonas suggests
> - update and reorder defconfig based on jonas suggestions
> - dts: disable usb_host0_ohci because of error on usb-start
>   scanning bus usb@fd840000 for devices...
>   ERROR: USB-error: DEVICENOTRESPONDING: Device did not respond to token (IN) or did
>   not provide a handshake (OUT) (5)
>   unable to get device descriptor (error=-1)
> - pcie is not yet working, so not adding these options
>   rockchip_pcie3phy phy@fe8c0000: lock failed 0x6890000
>   rockchip_pcie3phy phy@fe8c0000: PHY: Failed to init phy@fe8c0000: -110.
>   pcie_dw_rockchip pcie@fe270000: failed to init phy (ret=-110)
>   rockchip_pcie3phy phy@fe8c0000: lock failed 0x6890000
>   rockchip_pcie3phy phy@fe8c0000: PHY: Failed to init phy@fe8c0000: -110.
>   pcie_dw_rockchip pcie@fe280000: failed to init phy (ret=-110)
> - emmc not tested as it is empty on my board because it breaks sdcard boot
> 
> v3:
> - disable gmac0 as switch-driver is not yet ready to attach to the mac
> 
> v2:
> - drop switch-node for now as u-boot driver works differently to linux
> ---
>  arch/arm/dts/Makefile                     |   3 +-
>  arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi |  28 +
>  arch/arm/dts/rk3568-bpi-r2pro.dts         | 852 ++++++++++++++++++++++
>  configs/bpi-r2pro-rk3568_defconfig        |  95 +++
>  doc/board/rockchip/rockchip.rst           |   1 +
>  5 files changed, 978 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro.dts
>  create mode 100644 configs/bpi-r2pro-rk3568_defconfig
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 85fd5b1157b1..71c557e87e9e 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -183,7 +183,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>  	rk3568-nanopi-r5s.dtb \
>  	rk3568-odroid-m1.dtb \
>  	rk3568-radxa-e25.dtb \
> -	rk3568-rock-3a.dtb
> +	rk3568-rock-3a.dtb \
> +	rk3568-bpi-r2pro.dtb
>  
>  dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>  	rk3588-edgeble-neu6a-io.dtb \
> diff --git a/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
> new file mode 100644
> index 000000000000..089e54f8cece
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2021 Rockchip Electronics Co., Ltd
> + */
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart2;
> +	};
> +};
> +
> +&uart2 {
> +	clock-frequency = <24000000>;
> +	bootph-pre-ram;
> +	status = "okay";
> +};
> +
> +&gmac0 {
> +	status = "disabled";
> +};
> +
> +/delete-node/ &{/ethernet@fe2a0000/mdio/switch@0};

Why are you deleting the switch node?  This way an OS that uses the
device tree provided by U-boot will not have a working switch...

> +
> +&usb_host0_ohci {
> +	status = "disabled";
> +};
> diff --git a/arch/arm/dts/rk3568-bpi-r2pro.dts b/arch/arm/dts/rk3568-bpi-r2pro.dts
> new file mode 100644
> index 000000000000..f9127ddfbb7d
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-bpi-r2pro.dts
> @@ -0,0 +1,852 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Author: Frank Wunderlich <frank-w@public-files.de>
> + *
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3568.dtsi"
> +
> +/ {
> +	model = "Bananapi-R2 Pro (RK3568) DDR4 Board";
> +	compatible = "rockchip,rk3568-bpi-r2pro", "rockchip,rk3568";
> +
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +		mmc0 = &sdmmc0;
> +		mmc1 = &sdhci;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&blue_led_pin &green_led_pin>;
> +
> +		blue_led: led-0 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			default-state = "off";
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		green_led: led-1 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "on";
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	dc_12v: dc-12v-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_12v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	ir-receiver {
> +		compatible = "gpio-ir-receiver";
> +		gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ir_receiver_pin>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie30_avdd0v9";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie30_avdd1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	/* pi6c pcie clock generator feeds both ports */
> +	vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_pcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <200000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	/* actually fed by vcc3v3_sys, dependent on pi6c clock generator */
> +	vcc3v3_minipcie: vcc3v3-minipcie-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_minipcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&minipcie_enable_h>;
> +		startup-delay-us = <50000>;
> +		vin-supply = <&vcc3v3_pi6c_05>;
> +	};
> +
> +	/* actually fed by vcc3v3_sys, dependent on pi6c clock generator */
> +	vcc3v3_ngff: vcc3v3-ngff-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_ngff";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ngffpcie_enable_h>;
> +		startup-delay-us = <50000>;
> +		vin-supply = <&vcc3v3_pi6c_05>;
> +	};
> +
> +	vcc5v0_usb: vcc5v0-usb-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_12v>;
> +	};
> +
> +	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_usb_host_en>;
> +		regulator-name = "vcc5v0_usb_host";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +
> +	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_usb_otg_en>;
> +		regulator-name = "vcc5v0_usb_otg";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_usb>;
> +	};
> +};
> +
> +&combphy0 {
> +	/* used for USB3 */
> +	status = "okay";
> +};
> +
> +&combphy1 {
> +	/* used for USB3 */
> +	status = "okay";
> +};
> +
> +&combphy2 {
> +	/* used for SATA */
> +	status = "okay";
> +};
> +
> +&gmac0 {
> +	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
> +	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
> +	clock_in_out = "input";
> +	phy-mode = "rgmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	/* Reset time is 20ms, 100ms for rtl8211f */
> +	snps,reset-delays-us = <0 20000 100000>;
> +	tx_delay = <0x4f>;
> +	rx_delay = <0x0f>;
> +	status = "okay";
> +
> +	fixed-link {
> +		speed = <1000>;
> +		full-duplex;
> +		pause;
> +	};
> +};
> +
> +&gmac1 {
> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +		     &gmac1m1_tx_bus2
> +		     &gmac1m1_rx_bus2
> +		     &gmac1m1_rgmii_clk
> +		     &gmac1m1_rgmii_bus>;
> +
> +	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	/* Reset time is 20ms, 100ms for rtl8211f */
> +	snps,reset-delays-us = <0 20000 100000>;
> +
> +	tx_delay = <0x3c>;
> +	rx_delay = <0x2f>;
> +
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	avdd-0v9-supply = <&vdda0v9_image>;
> +	avdd-1v8-supply = <&vcca1v8_image>;
> +	status = "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +		#clock-cells = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>;
> +		rockchip,system-power-controller;
> +		vcc1-supply = <&vcc3v3_sys>;
> +		vcc2-supply = <&vcc3v3_sys>;
> +		vcc3-supply = <&vcc3v3_sys>;
> +		vcc4-supply = <&vcc3v3_sys>;
> +		vcc5-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +		wakeup-source;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-name = "vdd_logic";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_gpu: DCDC_REG2 {
> +				regulator-name = "vdd_gpu";
> +				regulator-always-on;
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu: DCDC_REG4 {
> +				regulator-name = "vdd_npu";
> +				regulator-initial-mode = <0x2>;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: DCDC_REG5 {
> +				regulator-name = "vcc_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_image: LDO_REG1 {
> +				regulator-name = "vdda0v9_image";
> +				regulator-always-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9: LDO_REG2 {
> +				regulator-name = "vdda_0v9";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_pmu: LDO_REG3 {
> +				regulator-name = "vdda0v9_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-name = "vccio_acodec";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-name = "vccio_sd";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG6 {
> +				regulator-name = "vcc3v3_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcca_1v8: LDO_REG7 {
> +				regulator-name = "vcca_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_pmu: LDO_REG8 {
> +				regulator-name = "vcca1v8_pmu";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcca1v8_image: LDO_REG9 {
> +				regulator-name = "vcca1v8_image";
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: SWITCH_REG1 {
> +				regulator-name = "vcc_3v3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_sd: SWITCH_REG2 {
> +				regulator-name = "vcc3v3_sd";
> +				regulator-always-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PD3 IRQ_TYPE_EDGE_FALLING>;
> +		#clock-cells = <0>;
> +		clock-output-names = "rtcic_32kout";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		wakeup-source;
> +	};
> +};
> +
> +&i2c5 {
> +	/* pin 3 (SDA) + 4 (SCL) of header con2 */
> +	status = "disabled";
> +};
> +
> +&i2s0_8ch {
> +	/* hdmi sound */
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	switch@0 {
> +		compatible = "mediatek,mt7531";
> +		reg = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@1 {
> +				reg = <1>;
> +				label = "lan0";
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				label = "lan1";
> +			};
> +
> +			port@3 {
> +				reg = <3>;
> +				label = "lan2";
> +			};
> +
> +			port@4 {
> +				reg = <4>;
> +				label = "lan3";
> +			};
> +
> +			port@5 {
> +				reg = <5>;
> +				label = "cpu";
> +				ethernet = <&gmac0>;
> +				phy-mode = "rgmii";
> +
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +					pause;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x0>;
> +	};
> +};
> +
> +&pcie30phy {
> +	data-lanes = <1 2>;
> +	phy-supply = <&vcc3v3_pi6c_05>;
> +	status = "okay";
> +};
> +
> +&pcie3x1 {
> +	/* M.2 slot */
> +	num-lanes = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ngffpcie_reset_h>;
> +	reset-gpios = <&gpio3 RK_PA1 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_ngff>;
> +	status = "okay";
> +};
> +
> +&pcie3x2 {
> +	/* mPCIe slot */
> +	num-lanes = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&minipcie_reset_h>;
> +	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_minipcie>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	leds {
> +		blue_led_pin: blue-led-pin {
> +			rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +		green_led_pin: green-led-pin {
> +			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hym8563 {
> +		hym8563_int: hym8563-int {
> +			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	ir-receiver {
> +		ir_receiver_pin: ir-receiver-pin {
> +			rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		minipcie_enable_h: minipcie-enable-h {
> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none_drv_level_5>;
> +		};
> +
> +		ngffpcie_enable_h: ngffpcie-enable-h {
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none_drv_level_5>;
> +		};
> +
> +		minipcie_reset_h: minipcie-reset-h {
> +			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none_drv_level_5>;
> +		};
> +
> +		ngffpcie_reset_h: ngffpcie-reset-h {
> +			rockchip,pins = <3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none_drv_level_5>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int: pmic_int {
> +			rockchip,pins =
> +				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	usb {
> +		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc3v3_pmu>;
> +	pmuio2-supply = <&vcc3v3_pmu>;
> +	vccio1-supply = <&vccio_acodec>;
> +	vccio3-supply = <&vccio_sd>;
> +	vccio4-supply = <&vcc_3v3>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_1v8>;
> +	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&pwm8 {
> +	/* fan 5v - gnd - pwm */
> +	status = "okay";
> +};
> +
> +&pwm10 {
> +	/* pin 7 of header con2 */
> +	status = "disabled";
> +};
> +
> +&pwm11 {
> +	/* pin 15 of header con2 */
> +	status = "disabled";
> +};
> +
> +&pwm12 {
> +	/* pin 21 of header con2 */
> +	/* shared with uart9 + spi3 */
> +	pinctrl-0 = <&pwm12m1_pins>;
> +	status = "disabled";
> +};
> +
> +&pwm13 {
> +	/* pin 24 of header con2 */
> +	/* shared with uart9 */
> +	pinctrl-0 = <&pwm13m1_pins>;
> +	status = "disabled";
> +};
> +
> +&pwm14 {
> +	/* pin 23 of header con2 */
> +	/* shared with spi3 */
> +	pinctrl-0 = <&pwm14m1_pins>;
> +	status = "disabled";
> +};
> +
> +&pwm15 {
> +	/* pin 19 of header con2 */
> +	/* shared with spi3 */
> +	pinctrl-0 = <&pwm15m1_pins>;
> +	status = "disabled";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca_1v8>;
> +	status = "okay";
> +};
> +
> +&sata2 {
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
> +	status = "okay";
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&spi3 {
> +	/* pin 19 (MO) + 21 (MI) + 23 (CK) of header con2 */
> +	/* shared with pwm12/14/15 and uart9 */
> +	pinctrl-0 = <&spi3m1_pins>;
> +	status = "disabled";
> +};
> +
> +&tsadc {
> +	rockchip,hw-tshut-mode = <1>;
> +	rockchip,hw-tshut-polarity = <0>;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	/* pin 8 (TX) + 10 (RX) (RTS:16, CTS:18) of header con2 */
> +	status = "disabled";
> +};
> +
> +&uart2 {
> +	/* debug-uart */
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	/* pin 11 (TX) + 13 (RX) of header con2 */
> +	pinctrl-0 = <&uart7m1_xfer>;
> +	status = "disabled";
> +};
> +
> +&uart9 {
> +	/* pin 21 (TX) + 24 (RX) of header con2 */
> +	/* shared with pwm13 and pwm12/spi3 */
> +	pinctrl-0 = <&uart9m1_xfer>;
> +	status = "disabled";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +	status = "okay";
> +};
> +
> +&usb2phy0 {
> +	status = "okay";
> +};
> +
> +&usb2phy0_host {
> +	phy-supply = <&vcc5v0_usb_host>;
> +	status = "okay";
> +};
> +
> +&usb2phy0_otg {
> +	phy-supply = <&vcc5v0_usb_otg>;
> +	status = "okay";
> +};
> +
> +&usb2phy1 {
> +	/* USB for PCIe/M2 */
> +	status = "okay";
> +};
> +
> +&usb2phy1_host {
> +	status = "okay";
> +};
> +
> +&usb2phy1_otg {
> +	status = "okay";
> +};
> +
> +&vop {
> +	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
> +	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
> +	status = "okay";
> +};
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi_in_vp0>;
> +	};
> +};
> diff --git a/configs/bpi-r2pro-rk3568_defconfig b/configs/bpi-r2pro-rk3568_defconfig
> new file mode 100644
> index 000000000000..df4daed865f0
> --- /dev/null
> +++ b/configs/bpi-r2pro-rk3568_defconfig
> @@ -0,0 +1,95 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3568-bpi-r2pro"
> +CONFIG_SYS_PROMPT="BPI-R2PRO> "
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2pro"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_SYSBOOT=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_SUPPORT_EMMC_BOOT=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_UHCI_HCD=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> +# CONFIG_EFI_LOADER is not set
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de9fe8e642b1..a639215d904e 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
>  
>  * rk3568
>       - Rockchip Evb-RK3568 (evb-rk3568)
> +     - BananaPi R2 Pro (bpi-r2pro-rk3568_defconfig)
>       - EmbedFire LubanCat 2 (lubancat-2-rk3568)
>       - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
>       - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
> -- 
> 2.34.1
> 
> 
