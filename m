Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C25DC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 07:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98D888802;
	Mon, 29 Jul 2024 09:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ChjrRBrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFEA887F5; Mon, 29 Jul 2024 09:40:07 +0200 (CEST)
Received: from mail-m19731117.qiye.163.com (mail-m19731117.qiye.163.com
 [220.197.31.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C673D887E4
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ChjrRBrIXI3Ja3QR+H/z53QlnxBby/d0YiXki75aU2NwzYyGTgMnTbQD1i/XhOhnoUVtER4+FERILezCs+O70Ga+LCIN8gLIaL4S0KuyYhcFiLzSokz9JHQX/qPxNhb/AdkyMjqAeXEp1uqqwtD42NKxzPLquDaST7P/cyt9eJo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=jW5V5Ub66k/By8+SamZ+Rr0IIIZdXhpnsJyLe8aHYCY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9051B900599;
 Mon, 29 Jul 2024 15:39:52 +0800 (CST)
Message-ID: <051632c6-610d-4f22-ac1f-92af7ad76ba7@rock-chips.com>
Date: Mon, 29 Jul 2024 15:39:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-toybrick-x0: Migrate to OF_UPSTREAM
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Elon Zhang <zhangzj@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240724074732.2759697-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240724074732.2759697-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpNHlYYQh1MSUxNSkgZSE5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUNDSU
 1VSktLVUpCWQY+
X-HM-Tid: 0a90fd6e752e03a9kunm9051b900599
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6PDo*ATI8AzIyHTgiMxoT
 LBIKFDRVSlVKTElJSUhDTEJIQ0JDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS09PQzcG
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


On 2024/7/24 15:47, Jonas Karlman wrote:
> The device tree for Rockchip Toybrick TB-RK3588X has been merged into
> dts/upstream with devicetree-rebasing v6.10-dts, migrate board to
> OF_UPSTREAM.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-toybrick-x0.dts | 688 ----------------------------
>   configs/toybrick-rk3588_defconfig   |   3 +-
>   2 files changed, 1 insertion(+), 690 deletions(-)
>   delete mode 100644 arch/arm/dts/rk3588-toybrick-x0.dts
>
> diff --git a/arch/arm/dts/rk3588-toybrick-x0.dts b/arch/arm/dts/rk3588-toybrick-x0.dts
> deleted file mode 100644
> index 9090c5c99f2a..000000000000
> --- a/arch/arm/dts/rk3588-toybrick-x0.dts
> +++ /dev/null
> @@ -1,688 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
> - *
> - */
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rk3588.dtsi"
> -
> -/ {
> -	model = "Rockchip Toybrick TB-RK3588X Board";
> -	compatible = "rockchip,rk3588-toybrick-x0", "rockchip,rk3588";
> -
> -	aliases {
> -		mmc0 = &sdhci;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:1500000n8";
> -	};
> -
> -	adc-keys {
> -		compatible = "adc-keys";
> -		io-channels = <&saradc 1>;
> -		io-channel-names = "buttons";
> -		keyup-threshold-microvolt = <1800000>;
> -		poll-interval = <100>;
> -
> -		button-vol-up {
> -			label = "Volume Up";
> -			linux,code = <KEY_VOLUMEUP>;
> -			press-threshold-microvolt = <17000>;
> -		};
> -
> -		button-vol-down {
> -			label = "Volume Down";
> -			linux,code = <KEY_VOLUMEDOWN>;
> -			press-threshold-microvolt = <417000>;
> -		};
> -
> -		button-menu {
> -			label = "Menu";
> -			linux,code = <KEY_MENU>;
> -			press-threshold-microvolt = <890000>;
> -		};
> -
> -		button-escape {
> -			label = "Escape";
> -			linux,code = <KEY_ESC>;
> -			press-threshold-microvolt = <1235000>;
> -		};
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		power-supply = <&vcc12v_dcin>;
> -		pwms = <&pwm2 0 25000 0>;
> -	};
> -
> -	pcie20_avdd0v85: pcie20-avdd0v85-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pcie20_avdd0v85";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <850000>;
> -		regulator-max-microvolt = <850000>;
> -		vin-supply = <&vdd_0v85_s0>;
> -	};
> -
> -	pcie20_avdd1v8: pcie20-avdd1v8-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pcie20_avdd1v8";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&avcc_1v8_s0>;
> -	};
> -
> -	pcie30_avdd0v75: pcie30-avdd0v75-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pcie30_avdd0v75";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <750000>;
> -		regulator-max-microvolt = <750000>;
> -		vin-supply = <&avdd_0v75_s0>;
> -	};
> -
> -	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "pcie30_avdd1v8";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		vin-supply = <&avcc_1v8_s0>;
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc5v0_host: vcc5v0-host-regulator {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vcc5v0_host_en>;
> -		regulator-name = "vcc5v0_host";
> -		regulator-boot-on;
> -		regulator-always-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_usb>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc5v0_usbdcin: vcc5v0-usbdcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usbdcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> -	};
> -
> -	vcc5v0_usb: vcc5v0-usb-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_usb";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc5v0_usbdcin>;
> -	};
> -
> -	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_1v1_nldo_s3";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <1100000>;
> -		regulator-max-microvolt = <1100000>;
> -		vin-supply = <&vcc5v0_sys>;
> -	};
> -};
> -
> -&combphy0_ps {
> -	status = "okay";
> -};
> -
> -&combphy2_psu {
> -	status = "okay";
> -};
> -
> -&cpu_b0 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b1 {
> -	cpu-supply = <&vdd_cpu_big0_s0>;
> -};
> -
> -&cpu_b2 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_b3 {
> -	cpu-supply = <&vdd_cpu_big1_s0>;
> -};
> -
> -&cpu_l0 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l1 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l2 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&cpu_l3 {
> -	cpu-supply = <&vdd_cpu_lit_s0>;
> -};
> -
> -&gmac0 {
> -	clock_in_out = "output";
> -	phy-handle = <&rgmii_phy>;
> -	phy-mode = "rgmii-rxid";
> -	pinctrl-0 = <&gmac0_miim
> -		     &gmac0_tx_bus2
> -		     &gmac0_rx_bus2
> -		     &gmac0_rgmii_clk
> -		     &gmac0_rgmii_bus>;
> -	pinctrl-names = "default";
> -	rx_delay = <0x00>;
> -	tx_delay = <0x43>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c0m2_xfer>;
> -	status = "okay";
> -
> -	vdd_cpu_big0_s0: regulator@42 {
> -		compatible = "rockchip,rk8602";
> -		reg = <0x42>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big0_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -
> -	vdd_cpu_big1_s0: regulator@43 {
> -		compatible = "rockchip,rk8603", "rockchip,rk8602";
> -		reg = <0x43>;
> -		fcs,suspend-voltage-selector = <1>;
> -		regulator-name = "vdd_cpu_big1_s0";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <550000>;
> -		regulator-max-microvolt = <1050000>;
> -		regulator-ramp-delay = <2300>;
> -		vin-supply = <&vcc5v0_sys>;
> -
> -		regulator-state-mem {
> -			regulator-off-in-suspend;
> -		};
> -	};
> -};
> -
> -&i2c2 {
> -	status = "okay";
> -
> -	hym8563: rtc@51 {
> -		compatible = "haoyu,hym8563";
> -		reg = <0x51>;
> -		#clock-cells = <0>;
> -		clock-output-names = "hym8563";
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PD4 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&hym8563_int>;
> -		wakeup-source;
> -	};
> -};
> -
> -&mdio0 {
> -	rgmii_phy: ethernet-phy@1 {
> -		/* RTL8211F */
> -		compatible = "ethernet-phy-id001c.c916";
> -		reg = <0x1>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&rtl8211f_rst>;
> -		reset-assert-us = <20000>;
> -		reset-deassert-us = <100000>;
> -		reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> -	};
> -};
> -
> -&pinctrl {
> -	rtl8211f {
> -		rtl8211f_rst: rtl8211f-rst {
> -			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -	};
> -
> -	hym8563 {
> -		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	usb {
> -		vcc5v0_host_en: vcc5v0-host-en {
> -			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -};
> -
> -&pwm2 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc_1v8_s0>;
> -	status = "okay";
> -};
> -
> -&sdhci {
> -	bus-width = <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	no-sdio;
> -	no-sd;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -&spi2 {
> -	assigned-clocks = <&cru CLK_SPI2>;
> -	assigned-clock-rates = <200000000>;
> -	num-cs = <1>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> -	status = "okay";
> -
> -	pmic@0 {
> -		compatible = "rockchip,rk806";
> -		reg = <0x0>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> -			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> -		spi-max-frequency = <1000000>;
> -		system-power-controller;
> -
> -		vcc1-supply = <&vcc5v0_sys>;
> -		vcc2-supply = <&vcc5v0_sys>;
> -		vcc3-supply = <&vcc5v0_sys>;
> -		vcc4-supply = <&vcc5v0_sys>;
> -		vcc5-supply = <&vcc5v0_sys>;
> -		vcc6-supply = <&vcc5v0_sys>;
> -		vcc7-supply = <&vcc5v0_sys>;
> -		vcc8-supply = <&vcc5v0_sys>;
> -		vcc9-supply = <&vcc5v0_sys>;
> -		vcc10-supply = <&vcc5v0_sys>;
> -		vcc11-supply = <&vcc_2v0_pldo_s3>;
> -		vcc12-supply = <&vcc5v0_sys>;
> -		vcc13-supply = <&vcc_1v1_nldo_s3>;
> -		vcc14-supply = <&vcc_1v1_nldo_s3>;
> -		vcca-supply = <&vcc5v0_sys>;
> -
> -		rk806_dvs1_null: dvs1-null-pins {
> -			pins = "gpio_pwrctrl1";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs2_null: dvs2-null-pins {
> -			pins = "gpio_pwrctrl2";
> -			function = "pin_fun0";
> -		};
> -
> -		rk806_dvs3_null: dvs3-null-pins {
> -			pins = "gpio_pwrctrl3";
> -			function = "pin_fun0";
> -		};
> -
> -		regulators {
> -			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> -				regulator-name = "vdd_gpu_s0";
> -				regulator-boot-on;
> -				regulator-enable-ramp-delay = <400>;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
> -				regulator-name = "vdd_cpu_lit_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_log_s0: dcdc-reg3 {
> -				regulator-name = "vdd_log_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
> -				regulator-name = "vdd_vdenc_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <550000>;
> -				regulator-max-microvolt = <950000>;
> -				regulator-init-microvolt = <750000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_ddr_s0: dcdc-reg5 {
> -				regulator-name = "vdd_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <675000>;
> -				regulator-max-microvolt = <900000>;
> -				regulator-ramp-delay = <12500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			vdd2_ddr_s3: dcdc-reg6 {
> -				regulator-name = "vdd2_ddr_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_2v0_pldo_s3: dcdc-reg7 {
> -				regulator-name = "vdd_2v0_pldo_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <2000000>;
> -				regulator-max-microvolt = <2000000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <2000000>;
> -				};
> -			};
> -
> -			vcc_3v3_s3: dcdc-reg8 {
> -				regulator-name = "vcc_3v3_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vddq_ddr_s0: dcdc-reg9 {
> -				regulator-name = "vddq_ddr_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s3: dcdc-reg10 {
> -				regulator-name = "vcc_1v8_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avcc_1v8_s0: pldo-reg1 {
> -				regulator-name = "avcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_1v8_s0: pldo-reg2 {
> -				regulator-name = "vcc_1v8_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			avdd_1v2_s0: pldo-reg3 {
> -				regulator-name = "avdd_1v2_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1200000>;
> -				regulator-max-microvolt = <1200000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3_s0: pldo-reg4 {
> -				regulator-name = "vcc_3v3_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vccio_sd_s0: pldo-reg5 {
> -				regulator-name = "vccio_sd_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			pldo6_s3: pldo-reg6 {
> -				regulator-name = "pldo6_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_0v75_s3: nldo-reg1 {
> -				regulator-name = "vdd_0v75_s3";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <750000>;
> -				};
> -			};
> -
> -			vdd_ddr_pll_s0: nldo-reg2 {
> -				regulator-name = "vdd_ddr_pll_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <850000>;
> -				};
> -			};
> -
> -			avdd_0v75_s0: nldo-reg3 {
> -				regulator-name = "avdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <837500>;
> -				regulator-max-microvolt = <837500>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v85_s0: nldo-reg4 {
> -				regulator-name = "vdd_0v85_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <850000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -
> -			vdd_0v75_s0: nldo-reg5 {
> -				regulator-name = "vdd_0v75_s0";
> -				regulator-always-on;
> -				regulator-boot-on;
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <750000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -				};
> -			};
> -		};
> -	};
> -};
> -
> -&u2phy2 {
> -	status = "okay";
> -};
> -
> -&u2phy2_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&u2phy3 {
> -	status = "okay";
> -};
> -
> -&u2phy3_host {
> -	phy-supply = <&vcc5v0_host>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-0 = <&uart2m0_xfer>;
> -	status = "okay";
> -};
> -
> -&usb_host0_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host0_ohci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ehci {
> -	status = "okay";
> -};
> -
> -&usb_host1_ohci {
> -	status = "okay";
> -};
> diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
> index 5a190357e454..12a076aeeae0 100644
> --- a/configs/toybrick-rk3588_defconfig
> +++ b/configs/toybrick-rk3588_defconfig
> @@ -2,7 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_DEFAULT_DEVICE_TREE="rk3588-toybrick-x0"
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-toybrick-x0"
>   CONFIG_ROCKCHIP_RK3588=y
>   CONFIG_SPL_SERIAL=y
>   CONFIG_TARGET_TOYBRICK_RK3588=y
> @@ -31,7 +31,6 @@ CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_LIVE=y
> -# CONFIG_OF_UPSTREAM is not set
>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
