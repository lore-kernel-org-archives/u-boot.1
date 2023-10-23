Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5704EC001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1868878CF;
	Mon, 23 Oct 2023 12:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="guYUpizK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0364C878D9; Mon, 23 Oct 2023 12:11:37 +0200 (CEST)
Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com
 [45.254.49.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3D987024
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=guYUpizK8wn/Azgft8GENUtdhyw/bca3NskMuMXu1xzrSZMw9BR9ruuG2PlGYKMBBYT/KEX4K9CONnrP25XYOaMg6Mv2j8n7b+yLaSu3e+RzxuUHTHEJK1rLwfO0jTlNYOQdxeYi/moCGdeI4hOieAX1o/4THx2nX7Y++MU5eMY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=qKbOoj+ZNld6xkg6RgtO4c5mELjEhG8xVd1rjbbDhWY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 8DDCD400305;
 Mon, 23 Oct 2023 18:11:21 +0800 (CST)
Message-ID: <b626fa03-17b2-4653-83cc-6b2ffb8ac706@rock-chips.com>
Date: Mon, 23 Oct 2023 18:11:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] board: rockchip: Add Xunlong Orange Pi 5
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Muhammed Efe Cetin <efectn@6tel.net>
References: <20231017214031.1704250-1-jonas@kwiboo.se>
 <20231017214031.1704250-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231017214031.1704250-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk5DTVZKGRhMQ0sZTRhDQhlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b5c0485912eb3kusn8ddcd400305
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Hio6PDw#AzhIIkoPQi0T
 STMaCgtVSlVKTUJDS05OQ0NJTE9PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0xKQjcG
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


On 2023/10/18 05:40, Jonas Karlman wrote:
> Xunlong Orange Pi 5 is a single-board computer based on the Rockchip
> RK3588S SoC. The board provides abundant interfaces, HDMI output, GPIO
> interface, M.2 PCIe2.0, Type-C, Gigabit LAN port, 2*USB2.0, 1*USB3.0,
> etc.
>
> Features tested on a Orange Pi 5 4GB v1.2:
> - SD-card boot
> - SPI Flash boot
> - PCIe/NVMe
> - USB 2.0 host
> - Ethernet
>
> Device tree is imported from linux v6.7-rockchip-dts64-1 tag.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Muhammed Efe Cetin <efectn@6tel.net>
> ---
>   arch/arm/dts/Makefile                       |   1 +
>   arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi |  22 +
>   arch/arm/dts/rk3588s-orangepi-5.dts         | 662 ++++++++++++++++++++
>   board/rockchip/evb_rk3588/MAINTAINERS       |   7 +
>   configs/orangepi-5-rk3588s_defconfig        | 102 +++
>   doc/board/rockchip/rockchip.rst             |   1 +
>   6 files changed, 795 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
>   create mode 100644 arch/arm/dts/rk3588s-orangepi-5.dts
>   create mode 100644 configs/orangepi-5-rk3588s_defconfig
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 490709359553..fd99bb76fa6b 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -192,6 +192,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>   	rk3588-edgeble-neu6b-io.dtb \
>   	rk3588-evb1-v10.dtb \
>   	rk3588-nanopc-t6.dtb \
> +	rk3588s-orangepi-5.dtb \
>   	rk3588s-rock-5a.dtb \
>   	rk3588-rock-5b.dtb
>   
> diff --git a/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi b/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
> new file mode 100644
> index 000000000000..888d1b9c12d7
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc;
> +	};
> +};
> +
> +&fspim0_pins {
> +	bootph-all;
> +};
> +
> +&sfc {
> +	bootph-pre-ram;
> +	u-boot,spl-sfc-no-dma;
> +
> +	flash@0 {
> +		bootph-pre-ram;
> +	};
> +};
> diff --git a/arch/arm/dts/rk3588s-orangepi-5.dts b/arch/arm/dts/rk3588s-orangepi-5.dts
> new file mode 100644
> index 000000000000..8f399c4317bd
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-orangepi-5.dts
> @@ -0,0 +1,662 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3588s.dtsi"
> +
> +/ {
> +	model = "Xunlong Orange Pi 5";
> +	compatible = "xunlong,orangepi-5", "rockchip,rk3588s";
> +
> +	aliases {
> +		mmc0 = &sdmmc;
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 1>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		button-recovery {
> +			label = "Recovery";
> +			linux,code = <KEY_VENDOR>;
> +			press-threshold-microvolt = <1800>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 =<&leds_gpio>;
> +
> +		led-1 {
> +			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
> +			label = "status_led";
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	vbus_typec: vbus-typec-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&typec5v_pwren>;
> +		regulator-name = "vbus_typec";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc_3v3_sd_s0: vcc-3v3-sd-s0-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-low;
> +		gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_LOW>;
> +		regulator-name = "vcc_3v3_sd_s0";
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3_s3>;
> +	};
> +
> +	vcc3v3_pcie20: vcc3v3-pcie20-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vcc3v3_pcie20";
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		startup-delay-us = <50000>;
> +		vin-supply = <&vcc5v0_sys>;
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
> +	phy-mode = "rgmii-rxid";
> +	pinctrl-0 = <&gmac1_miim
> +		     &gmac1_tx_bus2
> +		     &gmac1_rx_bus2
> +		     &gmac1_rgmii_clk
> +		     &gmac1_rgmii_bus>;
> +	pinctrl-names = "default";
> +	tx_delay = <0x42>;
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
> +		vin-supply = <&vcc5v0_sys>;
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
> +		vin-supply = <&vcc5v0_sys>;
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
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6m3_xfer>;
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-source;
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pcie2x1l2 {
> +	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> +	vpcie3v3-supply = <&vcc3v3_pcie20>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	gpio-func {
> +		leds_gpio: leds-gpio {
> +			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	hym8563 {
> +		hym8563_int: hym8563-int {
> +			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb-typec {
> +		usbc0_int: usbc0-int {
> +			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		typec5v_pwren: typec5v-pwren {
> +			rockchip,pins = <3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&saradc {
> +	vref-supply = <&avcc_1v8_s0>;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	no-mmc;
> +	no-sdio;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3_sd_s0>;
> +	vqmmc-supply = <&vccio_sd_s0>;
> +	status = "okay";
> +};
> +
> +&sfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&fspim0_pins>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-max-frequency = <100000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <1>;
> +	};
> +};
> +
> +&spi2 {
> +	status = "okay";
> +	assigned-clocks = <&cru CLK_SPI2>;
> +	assigned-clock-rates = <200000000>;
> +	num-cs = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
> +
> +	pmic@0 {
> +		compatible = "rockchip,rk806";
> +		reg = <0x0>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
> +				<&rk806_dvs2_null>, <&rk806_dvs3_null>;
> +		spi-max-frequency = <1000000>;
> +
> +		vcc1-supply = <&vcc5v0_sys>;
> +		vcc2-supply = <&vcc5v0_sys>;
> +		vcc3-supply = <&vcc5v0_sys>;
> +		vcc4-supply = <&vcc5v0_sys>;
> +		vcc5-supply = <&vcc5v0_sys>;
> +		vcc6-supply = <&vcc5v0_sys>;
> +		vcc7-supply = <&vcc5v0_sys>;
> +		vcc8-supply = <&vcc5v0_sys>;
> +		vcc9-supply = <&vcc5v0_sys>;
> +		vcc10-supply = <&vcc5v0_sys>;
> +		vcc11-supply = <&vcc_2v0_pldo_s3>;
> +		vcc12-supply = <&vcc5v0_sys>;
> +		vcc13-supply = <&vcc_1v1_nldo_s3>;
> +		vcc14-supply = <&vcc_1v1_nldo_s3>;
> +		vcca-supply = <&vcc5v0_sys>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		rk806_dvs1_null: dvs1-null-pins {
> +			pins = "gpio_pwrctrl2";
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
> +			vdd_log_s0: dcdc-reg3 {
> +				regulator-name = "vdd_log_s0";
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
> +			vcc_1v1_nldo_s3: vdd2_ddr_s3: dcdc-reg6 {
> +				regulator-name = "vdd2_ddr_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-min-microvolt = <1100000>;
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
> +			avcc_1v8_s0: pldo-reg1 {
> +				regulator-name = "avcc_1v8_s0";
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
> +			vcc_1v8_s0: pldo-reg2 {
> +				regulator-name = "vcc_1v8_s0";
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
> +			avdd_1v2_s0: pldo-reg3 {
> +				regulator-name = "avdd_1v2_s0";
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
> +			vcc_3v3_s0: pldo-reg4 {
> +				regulator-name = "vcc_3v3_s0";
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
> +			pldo6_s3: pldo-reg6 {
> +				regulator-name = "pldo6_s3";
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
> +			vdd_ddr_pll_s0: nldo-reg2 {
> +				regulator-name = "vdd_ddr_pll_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <850000>;
> +				};
> +			};
> +
> +			avdd_0v75_s0: nldo-reg3 {
> +				regulator-name = "avdd_0v75_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_0v85_s0: nldo-reg4 {
> +				regulator-name = "vdd_0v85_s0";
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
> +			vdd_0v75_s0: nldo-reg5 {
> +				regulator-name = "vdd_0v75_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&tsadc {
> +	status = "okay";
> +};
> +
> +&u2phy2 {
> +	status = "okay";
> +};
> +
> +&u2phy2_host {
> +	status = "okay";
> +};
> +
> +&u2phy3 {
> +	status = "okay";
> +};
> +
> +&u2phy3_host {
> +	status = "okay";
> +};
> +
> +&uart2 {
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
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
> index 6b2c257a1705..c75f47254066 100644
> --- a/board/rockchip/evb_rk3588/MAINTAINERS
> +++ b/board/rockchip/evb_rk3588/MAINTAINERS
> @@ -6,3 +6,10 @@ F:	include/configs/evb_rk3588.h
>   F:	configs/evb-rk3588_defconfig
>   F:	arch/arm/dts/rk3588-evb1-v10.dts
>   F:	arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
> +
> +ORANGEPI-5-RK3588
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	configs/orangepi-5-rk3588s_defconfig
> +F:	arch/arm/dts/rk3588s-orangepi-5.dts
> +F:	arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
> diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
> new file mode 100644
> index 000000000000..feb45a53853b
> --- /dev/null
> +++ b/configs/orangepi-5-rk3588s_defconfig
> @@ -0,0 +1,102 @@
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
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3588s-orangepi-5"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_TARGET_EVB_RK3588=y
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5.dtb"
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
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index f8f0e66a9cde..a4b69b345d91 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -118,6 +118,7 @@ List of mainline supported Rockchip boards:
>        - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
>        - Radxa ROCK 5B (rock5b-rk3588)
> +     - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
>   
>   * rv1108
>        - Rockchip Evb-rv1108 (evb-rv1108)
