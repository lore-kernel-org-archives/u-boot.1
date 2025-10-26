Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D937CCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A923C836B2;
	Sun, 26 Oct 2025 16:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fTlbhN+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC8C836F0; Sun, 26 Oct 2025 16:42:14 +0100 (CET)
Received: from mail-m15579.qiye.163.com (mail-m15579.qiye.163.com
 [101.71.155.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6897482E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748f51;
 Sun, 26 Oct 2025 23:42:07 +0800 (GMT+08:00)
Message-ID: <b2b78a20-2c6d-43c0-8177-d483cd4b7b9f@rock-chips.com>
Date: Sun, 26 Oct 2025 23:42:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add ArmSoM Sige1
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20251019205849.954736-1-jonas@kwiboo.se>
 <20251019205849.954736-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251019205849.954736-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a212f1eff03afkunma095a4c14d2685
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHU5OVhpLQh8fSElCSU1MS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=fTlbhN+tEHLLTlCe01QH6eND4jRy2YWzECXy/HBiiSBSadS6k4XIKyDMsRUeDj8riBOpXb+ga1CUEeX//8/jgiVD5NoFBHnlLurkf8cRwB4dCHagWYK2GBjXPDCCXWU4yGEc/OnSAY5Oguh+Z6HRYvX/sxi7ocqTvpsXGNkzSDs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=yx8Mn2vJpLTEAUL0cCSeo79xo0m/rZQC300uSB5A5Bc=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/10/20 04:58, Jonas Karlman wrote:
> The Sige1 is a single board computer developed by ArmSoM, based on the
> Rockchip RK3528A SoC.
>
> Add initial device tree for the ArmSoM Sige1 board.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20250717103720.2853031-5-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 1c6b12ef9575bc18dad2393e50ca1ebf96f0a0c8 ]
>
> (cherry picked from commit 3ba04aa78ba71faab4a339f5ab15bc81a3e0a51b)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../arm64/rockchip/rk3528-armsom-sige1.dts    | 464 ++++++++++++++++++
>   1 file changed, 464 insertions(+)
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts b/dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts
> new file mode 100644
> index 000000000000..6e21579365a5
> --- /dev/null
> +++ b/dts/upstream/src/arm64/rockchip/rk3528-armsom-sige1.dts
> @@ -0,0 +1,464 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3528.dtsi"
> +
> +/ {
> +	model = "ArmSoM Sige1";
> +	compatible = "armsom,sige1", "rockchip,rk3528";
> +
> +	aliases {
> +		ethernet0 = &gmac1;
> +		i2c0 = &i2c0;
> +		mmc0 = &sdhci;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdio0;
> +		serial0 = &uart0;
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:1500000n8";
> +	};
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 0>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +		poll-interval = <100>;
> +
> +		button-maskrom {
> +			label = "MASKROM";
> +			linux,code = <KEY_SETUP>;
> +			press-threshold-microvolt = <0>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&g_led>, <&r_led>;
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "on";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_RED>;
> +			default-state = "on";
> +			function = LED_FUNCTION_STATUS;
> +			gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +	};
> +
> +	vcc0v6_ddr: regulator-0v6-vcc-ddr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc0v6_ddr";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <600000>;
> +		regulator-max-microvolt = <600000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vdd_0v9: regulator-0v9-vdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_0v9";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <900000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc_ddr: regulator-1v1-vcc-ddr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_ddr";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1100000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc_1v8: regulator-1v8-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_3v3>;
> +	};
> +
> +	vcc1v8_ddr: regulator-1v8-vcc-ddr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8_ddr";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc_3v3: regulator-3v3-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_3v3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_dcin>;
> +	};
> +
> +	vcc3v3_sd: regulator-3v3-vcc-sd {
> +		compatible = "regulator-fixed";
> +		gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc_pwren_l>;
> +		regulator-name = "vcc3v3_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3>;
> +	};
> +
> +	vcc5v0_sys: regulator-5v0-vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc_dcin>;
> +	};
> +
> +	vcc5v0_usb1_host: regulator-5v0-vcc-usb1-host {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio4 RK_PB1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb20_host1_drv_h>;
> +		regulator-name = "vcc5v0_usb1_host";
> +		regulator-always-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb2_host: regulator-5v0-vcc-usb2-host {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb20_host2_drv_h>;
> +		regulator-name = "vcc5v0_usb2_host";
> +		regulator-always-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb_otg: regulator-5v0-vcc-usb-otg {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb20_otg0_drv_h>;
> +		regulator-name = "vcc5v0_usb_otg";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc_dcin: regulator-vcc-dcin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vccio_sd: regulator-vccio-sd {
> +		compatible = "regulator-gpio";
> +		gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
> +		regulator-name = "vccio_sd";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		states = <1800000 0x0>, <3300000 0x1>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vdd_arm: regulator-vdd-arm {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm3 0 5000 PWM_POLARITY_INVERTED>;
> +		pwm-supply = <&vcc5v0_sys>;
> +		regulator-name = "vdd_arm";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <746000>;
> +		regulator-max-microvolt = <1201000>;
> +		regulator-settling-time-up-us = <250>;
> +	};
> +
> +	vdd_logic: regulator-vdd-logic {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm2 0 5000 PWM_POLARITY_INVERTED>;
> +		pwm-supply = <&vcc5v0_sys>;
> +		regulator-name = "vdd_logic";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <705000>;
> +		regulator-max-microvolt = <1006000>;
> +		regulator-settling-time-up-us = <250>;
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_reg_on_h>, <&clkm1_32k_out>;
> +		post-power-on-delay-ms = <200>;
> +		reset-gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy>;
> +	phy-mode = "rgmii-id";
> +	phy-supply = <&vcc_3v3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
> +		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>;
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_logic>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0m0_xfer>;
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtc_int_l>;
> +		wakeup-source;
> +	};
> +};
> +
> +&mdio1 {
> +	rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gmac1_rstn_l>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pinctrl {
> +	bluetooth {
> +		bt_reg_on_h: bt-reg-on-h {
> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_wake_host_h: bt-wake-host-h {
> +			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		host_wake_bt_h: host-wake-bt-h {
> +			rockchip,pins = <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	ethernet {
> +		gmac1_rstn_l: gmac1-rstn-l {
> +			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	leds {
> +		g_led: g-led {
> +			rockchip,pins = <3 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		r_led: r-led {
> +			rockchip,pins = <3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	rtc {
> +		rtc_int_l: rtc-int-l {
> +			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	sdmmc {
> +		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
> +			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		sdmmc_pwren_l: sdmmc-pwren-l {
> +			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	usb {
> +		usb20_host1_drv_h: usb20-host1-drv-h {
> +			rockchip,pins = <4 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		usb20_host2_drv_h: usb20-host2-drv-h {
> +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		usb20_otg0_drv_h: usb20-otg0-drv-h {
> +			rockchip,pins = <1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wifi {
> +		wifi_reg_on_h: wifi-reg-on-h {
> +			rockchip,pins = <1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wifi_wake_host_h: wifi-wake-host-h {
> +			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +};
> +
> +&pwm2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm2m0_pins>;
> +	status = "okay";
> +};
> +
> +&pwm3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm3m0_pins>;
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdio0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	no-mmc;
> +	no-sd;
> +	non-removable;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	wifi@1 {
> +		compatible = "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		clocks = <&cru CLK_DEEPSLOW>;
> +		clock-names = "lpo";
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wake";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_wake_host_h>;
> +	};
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc3v3_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0m0_xfer>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	dma-names = "tx", "rx";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2m1_xfer>, <&uart2m1_ctsn>, <&uart2m1_rtsn>;
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		clocks = <&cru CLK_DEEPSLOW>;
> +		clock-names = "lpo";
> +		device-wakeup-gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PC2 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wakeup";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_reg_on_h>, <&bt_wake_host_h>, <&host_wake_bt_h>;
> +		shutdown-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		vbat-supply = <&vcc_3v3>;
> +		vddio-supply = <&vcc_1v8>;
> +	};
> +};

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

