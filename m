Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3928BC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 06:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA47988B56;
	Fri,  2 Aug 2024 08:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WL8Cly1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC6588B56; Fri,  2 Aug 2024 08:17:18 +0200 (CEST)
Received: from mail-m127218.xmail.ntesmail.com
 (mail-m127218.xmail.ntesmail.com [115.236.127.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2BE87C38
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 08:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WL8Cly1kWI/io0Uj3k6s1mc239da4E7aKdPTLtQP9YjYWJ6CYZwpZSJm1hxIA9RgE+eT/TjhD38mjZ+VcrYBlVu0eqPlOUrn9RbxjBiygqVEZD0r86jDAqKGfJCy5eGfGo9eIy2AoJJCwIdfsm04fdm8+bPyiCww3dNUB/WNuf8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=k3+lfOQaAYbmOpQR7dqMbDsaA/B80q5EdZ+h2QviAVg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 97AFA9003DF;
 Fri,  2 Aug 2024 14:16:59 +0800 (CST)
Message-ID: <01210e94-7a15-4cf2-9727-afb5d5acffdc@rock-chips.com>
Date: Fri, 2 Aug 2024 14:16:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add Radxa ROCK S0
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20240730194842.916502-1-jonas@kwiboo.se>
 <20240730194842.916502-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240730194842.916502-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGksfSVYYQkwaQ0tPTBoaT09WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9111bc03f903a9kunm97afa9003df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46Fzo4AjIrPSIVOA00M0gO
 Hw4KCylVSlVKTElJTkxCT0lLQ0hMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSEJNNwY+
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


On 2024/7/31 03:48, Jonas Karlman wrote:
> Radxa ROCK S0 is a single-board computer based on the Rockchip RK3308B
> SoC in an ultra-compact form factor.
>
> Add initial support for eMMC, SD-card, Ethernet, WiFi/BT and USB.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20240521212247.1240226-3-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: adeb5d2a4ba47910238b3c4f5fd960cc0c26a98b ]
>
> (cherry picked from commit e291d457b0378f2cb3d3ebb597032ca862cdb973)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3308-rock-s0.dts     | 293 ++++++++++++++++++
>   1 file changed, 293 insertions(+)
>   create mode 100644 dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts b/dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts
> new file mode 100644
> index 000000000000..bd6419a5c20a
> --- /dev/null
> +++ b/dts/upstream/src/arm64/rockchip/rk3308-rock-s0.dts
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include "rk3308.dtsi"
> +
> +/ {
> +	model = "Radxa ROCK S0";
> +	compatible = "radxa,rock-s0", "rockchip,rk3308";
> +
> +	aliases {
> +		ethernet0 = &gmac;
> +		mmc0 = &emmc;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdio;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:1500000n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwr_led>;
> +
> +		led-green {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "on";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	vdd_log: regulator-1v04-vdd-log {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_log";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1040000>;
> +		regulator-max-microvolt = <1040000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc_ddr: regulator-1v5-vcc-ddr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_ddr";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1500000>;
> +		regulator-max-microvolt = <1500000>;
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
> +		vin-supply = <&vcc_io>;
> +	};
> +
> +	vcc_io: regulator-3v3-vcc-io {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_io";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_sys: regulator-5v0-vcc-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vdd_core: regulator-vdd-core {
> +		compatible = "pwm-regulator";
> +		pwms = <&pwm0 0 5000 1>;
> +		pwm-supply = <&vcc5v0_sys>;
> +		regulator-name = "vdd_core";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <827000>;
> +		regulator-max-microvolt = <1340000>;
> +		regulator-settling-time-up-us = <250>;
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_reg_on>;
> +		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_core>;
> +};
> +
> +&emmc {
> +	cap-mmc-highspeed;
> +	no-sd;
> +	no-sdio;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_pwren>;
> +	vmmc-supply = <&vcc_io>;
> +	status = "okay";
> +};
> +
> +&gmac {
> +	clock_in_out = "output";
> +	phy-handle = <&rtl8201f>;
> +	phy-supply = <&vcc_io>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rtl8201f: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <1>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mac_rst>;
> +			reset-assert-us = <20000>;
> +			reset-deassert-us = <50000>;
> +			reset-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&io_domains {
> +	vccio0-supply = <&vcc_io>;
> +	vccio1-supply = <&vcc_io>;
> +	vccio2-supply = <&vcc_io>;
> +	vccio3-supply = <&vcc_io>;
> +	vccio4-supply = <&vcc_1v8>;
> +	vccio5-supply = <&vcc_io>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rtc_32k>;
> +
> +	bluetooth {
> +		bt_reg_on: bt-reg-on {
> +			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_wake_host: bt-wake-host {
> +			rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		host_wake_bt: host-wake-bt {
> +			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	gmac {
> +		mac_rst: mac-rst {
> +			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	leds {
> +		pwr_led: pwr-led {
> +			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	wifi {
> +		wifi_reg_on: wifi-reg-on {
> +			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wifi_wake_host: wifi-wake-host {
> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +};
> +
> +&pwm0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm0_pin_pull_down>;
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdio {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	max-frequency = <50000000>;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	no-mmc;
> +	no-sd;
> +	non-removable;
> +	vmmc-supply = <&vcc_io>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +
> +	brcmf: wifi@1 {
> +		compatible = "brcm,bcm43430a1-fmac", "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wake";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_wake_host>;
> +	};
> +};
> +
> +&sdmmc {
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	disable-wp;
> +	vmmc-supply = <&vcc_io>;
> +	status = "okay";
> +};
> +
> +&u2phy {
> +	status = "okay";
> +};
> +
> +&u2phy_host {
> +	status = "okay";
> +};
> +
> +&u2phy_otg {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_xfer>;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43430a1-bt";
> +		clocks = <&cru SCLK_RTC32K>;
> +		clock-names = "lpo";
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wakeup";
> +		device-wakeup-gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_HIGH>;
> +		shutdown-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_reg_on &bt_wake_host &host_wake_bt>;
> +		vbat-supply = <&vcc_io>;
> +		vddio-supply = <&vcc_1v8>;
> +	};
> +};
> +
> +&usb_host_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host_ohci {
> +	status = "okay";
> +};
> +
> +&usb20_otg {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&wdt {
> +	status = "okay";
> +};
