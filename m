Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF5ED3C927
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 01:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF316892B9;
	Mon, 21 Oct 2024 03:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="P5sDiAxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFF888F8E; Mon, 21 Oct 2024 03:32:20 +0200 (CEST)
Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com
 [45.254.49.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 329C08926A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=P5sDiAxzow0Ylte4y6cn8bB3GYmxfQQyo33PyScQRYoAxjAz6CdRhqHlr6sw8DWM4XCY8kBJgZvnr2M/59cQg5xyhcE5YXNK0Vs9VO3edoQx99XSeuRBWfqts/MR81mADgmuwS1SjiekRcCFAecrHi4MrTwmBK0hBSSkYajZeRY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Q/P+4orA8Yl4lmw4l9hBySXaOWyCrBcsIx3rj/cgCjg=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id EB022520244;
 Mon, 21 Oct 2024 09:32:03 +0800 (CST)
Message-ID: <85f977b1-184c-4de5-8a2a-2b4ea35b1bd9@rock-chips.com>
Date: Mon, 21 Oct 2024 09:32:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add Hardkernel ODROID-M2
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20241003195941.340519-1-jonas@kwiboo.se>
 <20241003195941.340519-2-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241003195941.340519-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkofGFYfHhoaQ0IdQhgZTExWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92acb3ec0603afkunmeb022520244
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSo6SSo5CTIaTCgpKUgVThJN
 NT0KCgFVSlVKTElCT0xPSElNT0xOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTkhPSTcG
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


On 2024/10/4 03:59, Jonas Karlman wrote:
> The Hardkernel ODROID-M2 is a single-board computer based on Rockchip
> RK3588S2 SoC. It features e.g. 8/16 GB LPDDR5 RAM, 64 GB eMMC, SD-card,
> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0/Type-C.
>
> Add initial support for eMMC, SD-card, Ethernet, PCIe and USB.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240901112020.3224704-3-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: ce48b8c976ce439c336def6e06bf8224a8ff9125 ]
>
> (cherry picked from commit 7ba62d8b4cb010c6fcb7077550b46d5f5fb5af6d)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3588s-odroid-m2.dts  | 903 ++++++++++++++++++
>   1 file changed, 903 insertions(+)
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-odroid-m2.dts
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-odroid-m2.dts b/dts/upstream/src/arm64/rockchip/rk3588s-odroid-m2.dts
> new file mode 100644
> index 000000000000..63d91236ba9f
> --- /dev/null
> +++ b/dts/upstream/src/arm64/rockchip/rk3588s-odroid-m2.dts
> @@ -0,0 +1,903 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/usb/pd.h>
> +#include "rk3588s.dtsi"
> +
> +/ {
> +	model = "Hardkernel ODROID-M2";
> +	compatible = "hardkernel,odroid-m2", "rockchip,rk3588s";
> +
> +	aliases {
> +		ethernet0 = &gmac1;
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwr_led>, <&sys_led>;
> +
> +		led_pwr: led-0 {
> +			color = <LED_COLOR_ID_RED>;
> +			default-state = "on";
> +			function = LED_FUNCTION_POWER;
> +			gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		led_sys: led-1 {
> +			color = <LED_COLOR_ID_BLUE>;
> +			default-state = "on";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	fan: pwm-fan {
> +		compatible = "pwm-fan";
> +		#cooling-cells = <2>;
> +		cooling-levels = <0 192 224 255>;
> +		fan-supply = <&vcc5v0_sys>;
> +		pwms = <&pwm0 0 22222 0>;
> +	};
> +
> +	vcc_1v1_nldo_s3: regulator-1v1-vcc-nldo-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v1_nldo_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1100000>;
> +		vin-supply = <&vcc4v0_sys>;
> +	};
> +
> +	vcc3v3_lcd: regulator-3v3-vcc-lcd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lcd_pwren>;
> +		regulator-name = "vcc3v3_lcd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3_s3>;
> +	};
> +
> +	vcc3v3_pcie: regulator-3v3-vcc-pcie {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcie_pwren>;
> +		regulator-name = "vcc3v3_pcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3_s3>;
> +	};
> +
> +	vcc_3v3_s0: regulator-3v3-vcc-s0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3_s3>;
> +	};
> +
> +	vcc4v0_sys: regulator-4v0-vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc4v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <4800000>;
> +		regulator-max-microvolt = <4800000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc5v0_sys: regulator-5v0-vcc-sys {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_pwren>;
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc5v0_usb2_host: regulator-5v0-vcc-usb2-host {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb2_host_pwren>;
> +		regulator-name = "vcc5v0_usb2_host";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb3_host: regulator-5v0-vcc-usb3-host {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb3_host_pwren>;
> +		regulator-name = "vcc5v0_usb3_host";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb3_typec: regulator-5v0-vcc-usb3-typec {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb3_typec_pwren>;
> +		regulator-name = "vcc5v0_usb3_typec";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcca: regulator-5v0-vcca {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcca";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	vcc12v_dcin: regulator-12v0-vcc-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +};
> +
> +&combphy0_ps {
> +	status = "okay";
> +};
> +
> +&combphy2_psu {
> +	status = "okay";
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_big0_s0>;
> +};
> +
> +&cpu_b2 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_b3 {
> +	cpu-supply = <&vdd_cpu_big1_s0>;
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_lit_s0>;
> +};
> +
> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-id";
> +	phy-supply = <&vcc_3v3_s0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1_miim
> +		     &gmac1_tx_bus2
> +		     &gmac1_rx_bus2
> +		     &gmac1_rgmii_clk
> +		     &gmac1_rgmii_bus
> +		     &gmac1_clkinout>;
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu_s0>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m2_xfer>;
> +	status = "okay";
> +
> +	vdd_cpu_big0_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big0_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc4v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_cpu_big1_s0: regulator@43 {
> +		compatible = "rockchip,rk8603", "rockchip,rk8602";
> +		reg = <0x43>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu_big1_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <1050000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc4v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	vdd_npu_s0: regulator@42 {
> +		compatible = "rockchip,rk8602";
> +		reg = <0x42>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_npu_s0";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <550000>;
> +		regulator-max-microvolt = <950000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc4v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c8 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c8m2_xfer>;
> +	status = "okay";
> +
> +	usbc0: usb-typec@22 {
> +		compatible = "fcs,fusb302";
> +		reg = <0x22>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbc0_int>;
> +		vbus-supply = <&vcc5v0_usb3_typec>;
> +
> +		connector {
> +			compatible = "usb-c-connector";
> +			data-role = "dual";
> +			label = "USB-C";
> +			op-sink-microwatt = <1000000>;
> +			power-role = "dual";
> +			sink-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_USB_COMM)>;
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			try-power-role = "source";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					usbc0_role_switch: endpoint {
> +						remote-endpoint = <&usb_host0_xhci_role_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					usbc0_orientation_switch: endpoint {
> +						remote-endpoint = <&usbdp_phy0_orientation_switch>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					usbc0_dp_altmode_mux: endpoint {
> +						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	pcf8563: rtc@51 {
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pcf8563_int>;
> +		wakeup-source;
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-id001c.c916";
> +		reg = <1>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&package_thermal {
> +	polling-delay = <1000>;
> +
> +	trips {
> +		package_fan0: package-fan0 {
> +			hysteresis = <2000>;
> +			temperature = <60000>;
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map0 {
> +			cooling-device = <&fan 1 THERMAL_NO_LIMIT>;
> +			trip = <&package_fan0>;
> +		};
> +	};
> +};
> +
> +&pcie2x1l2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie20x1_pins>;
> +	reset-gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	lcd {
> +		lcd_pwren: lcd-pwren {
> +			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	leds {
> +		pwr_led: pwr-led {
> +			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		sys_led: sys-led {
> +			rockchip,pins = <1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pcie {
> +		pcie20x1_pins: pcie20x1-pins {
> +			rockchip,pins =
> +				<1 RK_PA0 4 &pcfg_pull_none>,
> +				<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>,
> +				<1 RK_PA1 4 &pcfg_pull_none>;
> +		};
> +
> +		pcie_pwren: pcie-pwren {
> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	regulator {
> +		vcc5v0_pwren: vcc5v0-pwren {
> +			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	rtc {
> +		pcf8563_int: pcf8563-int {
> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		usb2_host_pwren: usb2-host-pwren {
> +			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		usb3_host_pwren: usb3-host-pwren {
> +			rockchip,pins = <1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		usb3_typec_pwren: usb3-typec-pwren {
> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		usbc0_int: usbc0-int {
> +			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pwm0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm0m2_pins>;
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcca_1v8_s0>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	vmmc-supply = <&vcc_3v3_s0>;
> +	vqmmc-supply = <&vcc_1v8_s0>;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	no-mmc;
> +	no-sdio;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3_s3>;
> +	vqmmc-supply = <&vccio_sd_s0>;
> +	status = "okay";
> +};
> +
> +&spi2 {
> +	assigned-clocks = <&cru CLK_SPI2>;
> +	assigned-clock-rates = <200000000>;
> +	num-cs = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2m2_cs0>, <&spi2m2_pins>;
> +	status = "okay";
> +
> +	pmic@0 {
> +		compatible = "rockchip,rk806";
> +		reg = <0x0>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> +			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +		spi-max-frequency = <1000000>;
> +		system-power-controller;
> +
> +		vcc1-supply = <&vcc4v0_sys>;
> +		vcc2-supply = <&vcc4v0_sys>;
> +		vcc3-supply = <&vcc4v0_sys>;
> +		vcc4-supply = <&vcc4v0_sys>;
> +		vcc5-supply = <&vcc4v0_sys>;
> +		vcc6-supply = <&vcc4v0_sys>;
> +		vcc7-supply = <&vcc4v0_sys>;
> +		vcc8-supply = <&vcc4v0_sys>;
> +		vcc9-supply = <&vcc4v0_sys>;
> +		vcc10-supply = <&vcc4v0_sys>;
> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc4v0_sys>;
> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> +		vcca-supply = <&vcca>;
> +
> +		rk806_dvs1_null: dvs1-null-pins {
> +			pins = "gpio_pwrctrl1";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs2_null: dvs2-null-pins {
> +			pins = "gpio_pwrctrl2";
> +			function = "pin_fun0";
> +		};
> +
> +		rk806_dvs3_null: dvs3-null-pins {
> +			pins = "gpio_pwrctrl3";
> +			function = "pin_fun0";
> +		};
> +
> +		regulators {
> +			vdd_gpu_s0: dcdc-reg1 {
> +				regulator-name = "vdd_gpu_s0";
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <400>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_cpu_lit_s0: dcdc-reg2 {
> +				regulator-name = "vdd_cpu_lit_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_logic_s0: dcdc-reg3 {
> +				regulator-name = "vdd_logic_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdd_vdenc_s0: dcdc-reg4 {
> +				regulator-name = "vdd_vdenc_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_ddr_s0: dcdc-reg5 {
> +				regulator-name = "vdd_ddr_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <675000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};
> +
> +			vdd2_ddr_s3: dcdc-reg6 {
> +				regulator-name = "vdd2_ddr_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_2v0_pldo_s3: dcdc-reg7 {
> +				regulator-name = "vdd_2v0_pldo_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2000000>;
> +				regulator-max-microvolt = <2000000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <2000000>;
> +				};
> +			};
> +
> +			vcc_3v3_s3: dcdc-reg8 {
> +				regulator-name = "vcc_3v3_s3";
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
> +			vddq_ddr_s0: dcdc-reg9 {
> +				regulator-name = "vddq_ddr_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s3: dcdc-reg10 {
> +				regulator-name = "vcc_1v8_s3";
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
> +			vcc_1v8_s0: pldo-reg1 {
> +				regulator-name = "vcc_1v8_s0";
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
> +			vcca_1v8_s0: pldo-reg2 {
> +				regulator-name = "vcca_1v8_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdda_1v2_s0: pldo-reg3 {
> +				regulator-name = "vdda_1v2_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca_3v3_s0: pldo-reg4 {
> +				regulator-name = "vcca_3v3_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd_s0: pldo-reg5 {
> +				regulator-name = "vccio_sd_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <12500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8_s3_pldo6: pldo-reg6 {
> +				regulator-name = "vcc_1v8_s3_pldo6";
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
> +			vdd_0v75_s3: nldo-reg1 {
> +				regulator-name = "vdd_0v75_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <750000>;
> +				};
> +			};
> +
> +			vdda_ddr_pll_s0: nldo-reg2 {
> +				regulator-name = "vdda_ddr_pll_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};
> +
> +			vdda_0v75_s0: nldo-reg3 {
> +				regulator-name = "vdda_0v75_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <837500>;
> +				regulator-max-microvolt = <837500>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v85_s0: nldo-reg4 {
> +				regulator-name = "vdda_0v85_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			/* Schematics show not in use */
> +			nldo-reg5 {
> +			};
> +		};
> +	};
> +};
> +
> +&tsadc {
> +	status = "okay";
> +};
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&u2phy2 {
> +	status = "okay";
> +};
> +
> +&u2phy2_host {
> +	phy-supply = <&vcc5v0_usb2_host>;
> +	status = "okay";
> +};
> +
> +&u2phy3 {
> +	status = "okay";
> +};
> +
> +&u2phy3_host {
> +	phy-supply = <&vcc5v0_usb3_host>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2m0_xfer>;
> +	status = "okay";
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
> +	usb-role-switch;
> +	status = "okay";
> +
> +	port {
> +		usb_host0_xhci_role_switch: endpoint {
> +			remote-endpoint = <&usbc0_role_switch>;
> +		};
> +	};
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
> +&usb_host2_xhci {
> +	status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +	mode-switch;
> +	orientation-switch;
> +	sbu1-dc-gpios = <&gpio4 RK_PA0 GPIO_ACTIVE_HIGH>;
> +	sbu2-dc-gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbdp_phy0_orientation_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc0_orientation_switch>;
> +		};
> +
> +		usbdp_phy0_dp_altmode_mux: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&usbc0_dp_altmode_mux>;
> +		};
> +	};
> +};
