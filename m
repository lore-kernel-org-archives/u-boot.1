Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0875C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0E787C38;
	Thu,  1 Feb 2024 04:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GzHUieUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A753F87C38; Thu,  1 Feb 2024 04:00:46 +0100 (CET)
Received: from mail-m127208.xmail.ntesmail.com
 (mail-m127208.xmail.ntesmail.com [115.236.127.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAEDC87C40
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GzHUieUw58LVyHK/dlRmft+91VIWEQBzAWN6RcUCuJFVcmaTjJHyslOukuxJ70Gvi8szzH1HZD4+mSf+/FBQVdJcJI+ETH33nKR+iYBIxjdHwmL0QDeHDzuqjk1PF/HLE9RwRySHfEJ79RlPlzQkj0fcZjzozbnEQhZw8xwsMik=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=ZEl7C7WqN/08uW0lC+iAebpI58A6iAxPsqSF+JgGny0=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id CBADC900112;
 Thu,  1 Feb 2024 11:00:28 +0800 (CST)
Message-ID: <72708e45-6d95-42ac-a4d2-193ced53a062@rock-chips.com>
Date: Thu, 1 Feb 2024 11:00:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] rockchip: rk356x: Sync device tree from linux v6.7
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Joseph Chen
 <chenjh@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Tianling Shen <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240126221508.4093334-1-jonas@kwiboo.se>
 <20240126221508.4093334-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240126221508.4093334-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJDSVYfS00YTx9KT08YQx1VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d629c59f803a9kunmcbadc900112
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46FSo6OTMQNk1OLR88ITUd
 AhgKCzNVSlVKTEtNTE5NT0hKS0JDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTENPQjcG
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


On 2024/1/27 06:14, Jonas Karlman wrote:
> Sync rk356x device tree from linux v6.7.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3566-anbernic-rgxx3.dtsi | 42 +++++++++++++------------
>   arch/arm/dts/rk3566-quartz64-a.dts      |  2 --
>   arch/arm/dts/rk3566-quartz64-b.dts      |  2 --
>   arch/arm/dts/rk3566-radxa-cm3-io.dts    |  4 +--
>   arch/arm/dts/rk3566-soquartz.dtsi       |  3 --
>   arch/arm/dts/rk3568-evb.dts             |  3 --
>   arch/arm/dts/rk3568-lubancat-2.dts      |  3 --
>   arch/arm/dts/rk3568-nanopi-r5s.dtsi     |  3 --
>   arch/arm/dts/rk3568-odroid-m1.dts       |  3 --
>   arch/arm/dts/rk3568-radxa-cm3i.dtsi     |  3 --
>   arch/arm/dts/rk3568-rock-3a.dts         |  7 +++--
>   arch/arm/dts/rk356x.dtsi                | 20 +++++++++++-
>   include/dt-bindings/clock/rk3568-cru.h  |  1 +
>   13 files changed, 48 insertions(+), 48 deletions(-)
>
> diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
> index ad43fa199ca5..8cbf3d9a4f22 100644
> --- a/arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
> +++ b/arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
> @@ -191,30 +191,30 @@
>   		};
>   	};
>   
> -	leds: gpio-leds {
> -		compatible = "gpio-leds";
> -		pinctrl-0 = <&led_pins>;
> -		pinctrl-names = "default";
> +	leds: pwm-leds {
> +		compatible = "pwm-leds";
>   
>   		green_led: led-0 {
>   			color = <LED_COLOR_ID_GREEN>;
>   			default-state = "on";
>   			function = LED_FUNCTION_POWER;
> -			gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
> +			max-brightness = <255>;
> +			pwms = <&pwm6 0 25000 0>;
>   		};
>   
>   		amber_led: led-1 {
>   			color = <LED_COLOR_ID_AMBER>;
>   			function = LED_FUNCTION_CHARGING;
> -			gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
> -			retain-state-suspended;
> +			max-brightness = <255>;
> +			pwms = <&pwm7 0 25000 0>;
>   		};
>   
>   		red_led: led-2 {
>   			color = <LED_COLOR_ID_RED>;
>   			default-state = "off";
>   			function = LED_FUNCTION_STATUS;
> -			gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
> +			max-brightness = <255>;
> +			pwms = <&pwm0 0 25000 0>;
>   		};
>   	};
>   
> @@ -356,7 +356,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-name = "vdd_logic";
> @@ -371,7 +370,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-name = "vdd_gpu";
> @@ -533,7 +531,6 @@
>   		regulator-boot-on;
>   		regulator-min-microvolt = <712500>;
>   		regulator-max-microvolt = <1390000>;
> -		regulator-init-microvolt = <900000>;
>   		regulator-name = "vdd_cpu";
>   		regulator-ramp-delay = <2300>;
>   		vin-supply = <&vcc_sys>;
> @@ -597,15 +594,6 @@
>   		};
>   	};
>   
> -	gpio-led {
> -		led_pins: led-pins {
> -			rockchip,pins =
> -				<0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>,
> -				<0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>,
> -				<0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
>   	joy-mux {
>   		joy_mux_en: joy-mux-en {
>   			rockchip,pins =
> @@ -654,10 +642,24 @@
>   	vccio7-supply = <&vcc_3v3>;
>   };
>   
> +&pwm0 {
> +	pinctrl-0 = <&pwm0m1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>   &pwm5 {
>   	status = "okay";
>   };
>   
> +&pwm6 {
> +	status = "okay";
> +};
> +
> +&pwm7 {
> +	status = "okay";
> +};
> +
>   &saradc {
>   	vref-supply = <&vcc_1v8>;
>   	status = "okay";
> diff --git a/arch/arm/dts/rk3566-quartz64-a.dts b/arch/arm/dts/rk3566-quartz64-a.dts
> index 25a8c781f4e7..854d02b46e6f 100644
> --- a/arch/arm/dts/rk3566-quartz64-a.dts
> +++ b/arch/arm/dts/rk3566-quartz64-a.dts
> @@ -366,7 +366,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-name = "vdd_logic";
> @@ -381,7 +380,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-name = "vdd_gpu";
> diff --git a/arch/arm/dts/rk3566-quartz64-b.dts b/arch/arm/dts/rk3566-quartz64-b.dts
> index b276eb0810c7..2d92713be2a0 100644
> --- a/arch/arm/dts/rk3566-quartz64-b.dts
> +++ b/arch/arm/dts/rk3566-quartz64-b.dts
> @@ -277,7 +277,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   
>   				regulator-state-mem {
> @@ -292,7 +291,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <900000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   
>   				regulator-state-mem {
> diff --git a/arch/arm/dts/rk3566-radxa-cm3-io.dts b/arch/arm/dts/rk3566-radxa-cm3-io.dts
> index 5e4236af4fcb..1b1c67d5b1ef 100644
> --- a/arch/arm/dts/rk3566-radxa-cm3-io.dts
> +++ b/arch/arm/dts/rk3566-radxa-cm3-io.dts
> @@ -137,8 +137,8 @@
>   
>   &mdio1 {
>   	rgmii_phy1: ethernet-phy@0 {
> -		compatible="ethernet-phy-ieee802.3-c22";
> -		reg= <0x0>;
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x0>;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/rk3566-soquartz.dtsi b/arch/arm/dts/rk3566-soquartz.dtsi
> index 31aa2b8efe39..63bae36b8f7e 100644
> --- a/arch/arm/dts/rk3566-soquartz.dtsi
> +++ b/arch/arm/dts/rk3566-soquartz.dtsi
> @@ -234,7 +234,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-state-mem {
> @@ -249,7 +248,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-initial-mode = <0x2>;
>   					regulator-state-mem {
> @@ -272,7 +270,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-name = "vdd_npu";
>   				regulator-state-mem {
> diff --git a/arch/arm/dts/rk3568-evb.dts b/arch/arm/dts/rk3568-evb.dts
> index 674792567fa6..19f8fc369b13 100644
> --- a/arch/arm/dts/rk3568-evb.dts
> +++ b/arch/arm/dts/rk3568-evb.dts
> @@ -293,7 +293,6 @@
>   				regulator-name = "vdd_logic";
>   				regulator-always-on;
>   				regulator-boot-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -307,7 +306,6 @@
>   			vdd_gpu: DCDC_REG2 {
>   				regulator-name = "vdd_gpu";
>   				regulator-always-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -331,7 +329,6 @@
>   
>   			vdd_npu: DCDC_REG4 {
>   				regulator-name = "vdd_npu";
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> diff --git a/arch/arm/dts/rk3568-lubancat-2.dts b/arch/arm/dts/rk3568-lubancat-2.dts
> index e653b067aa5d..a8a4cc190eb3 100644
> --- a/arch/arm/dts/rk3568-lubancat-2.dts
> +++ b/arch/arm/dts/rk3568-lubancat-2.dts
> @@ -243,7 +243,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-initial-mode = <0x2>;
>   
> @@ -258,7 +257,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-initial-mode = <0x2>;
>   
> @@ -284,7 +282,6 @@
>   				regulator-boot-on;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> -				regulator-init-microvolt = <900000>;
>   				regulator-ramp-delay = <6001>;
>   				regulator-initial-mode = <0x2>;
>   
> diff --git a/arch/arm/dts/rk3568-nanopi-r5s.dtsi b/arch/arm/dts/rk3568-nanopi-r5s.dtsi
> index 58ba328ea782..93189f830640 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5s.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5s.dtsi
> @@ -232,7 +232,6 @@
>   				regulator-name = "vdd_logic";
>   				regulator-always-on;
>   				regulator-boot-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -246,7 +245,6 @@
>   			vdd_gpu: DCDC_REG2 {
>   				regulator-name = "vdd_gpu";
>   				regulator-always-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -270,7 +268,6 @@
>   
>   			vdd_npu: DCDC_REG4 {
>   				regulator-name = "vdd_npu";
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> diff --git a/arch/arm/dts/rk3568-odroid-m1.dts b/arch/arm/dts/rk3568-odroid-m1.dts
> index 59ecf868dbd0..a337f547caf5 100644
> --- a/arch/arm/dts/rk3568-odroid-m1.dts
> +++ b/arch/arm/dts/rk3568-odroid-m1.dts
> @@ -291,7 +291,6 @@
>   				regulator-name = "vdd_logic";
>   				regulator-always-on;
>   				regulator-boot-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -305,7 +304,6 @@
>   			vdd_gpu: DCDC_REG2 {
>   				regulator-name = "vdd_gpu";
>   				regulator-always-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -329,7 +327,6 @@
>   
>   			vdd_npu: DCDC_REG4 {
>   				regulator-name = "vdd_npu";
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> diff --git a/arch/arm/dts/rk3568-radxa-cm3i.dtsi b/arch/arm/dts/rk3568-radxa-cm3i.dtsi
> index c50fbdd48680..45b03dcbbad4 100644
> --- a/arch/arm/dts/rk3568-radxa-cm3i.dtsi
> +++ b/arch/arm/dts/rk3568-radxa-cm3i.dtsi
> @@ -163,7 +163,6 @@
>   				regulator-name = "vdd_logic";
>   				regulator-always-on;
>   				regulator-boot-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -177,7 +176,6 @@
>   			vdd_gpu: DCDC_REG2 {
>   				regulator-name = "vdd_gpu";
>   				regulator-always-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -201,7 +199,6 @@
>   
>   			vdd_npu: DCDC_REG4 {
>   				regulator-name = "vdd_npu";
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> diff --git a/arch/arm/dts/rk3568-rock-3a.dts b/arch/arm/dts/rk3568-rock-3a.dts
> index 917f5b2b8aab..a5e974ea659e 100644
> --- a/arch/arm/dts/rk3568-rock-3a.dts
> +++ b/arch/arm/dts/rk3568-rock-3a.dts
> @@ -15,6 +15,7 @@
>   		ethernet0 = &gmac1;
>   		mmc0 = &sdhci;
>   		mmc1 = &sdmmc0;
> +		mmc2 = &sdmmc2;
>   	};
>   
>   	chosen: chosen {
> @@ -350,7 +351,6 @@
>   				regulator-name = "vdd_logic";
>   				regulator-always-on;
>   				regulator-boot-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -364,7 +364,6 @@
>   			vdd_gpu: DCDC_REG2 {
>   				regulator-name = "vdd_gpu";
>   				regulator-always-on;
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -388,7 +387,6 @@
>   
>   			vdd_npu: DCDC_REG4 {
>   				regulator-name = "vdd_npu";
> -				regulator-init-microvolt = <900000>;
>   				regulator-initial-mode = <0x2>;
>   				regulator-min-microvolt = <500000>;
>   				regulator-max-microvolt = <1350000>;
> @@ -750,6 +748,9 @@
>   	non-removable;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&sdmmc2m0_bus4 &sdmmc2m0_cmd &sdmmc2m0_clk>;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
>   	sd-uhs-sdr104;
>   	vmmc-supply = <&vcc3v3_sys>;
>   	vqmmc-supply = <&vcc_1v8>;
> diff --git a/arch/arm/dts/rk356x.dtsi b/arch/arm/dts/rk356x.dtsi
> index 61680c7ac489..c19c0f1b3778 100644
> --- a/arch/arm/dts/rk356x.dtsi
> +++ b/arch/arm/dts/rk356x.dtsi
> @@ -613,6 +613,17 @@
>   		#iommu-cells = <0>;
>   	};
>   
> +	rga: rga@fdeb0000 {
> +		compatible = "rockchip,rk3568-rga", "rockchip,rk3288-rga";
> +		reg = <0x0 0xfdeb0000 0x0 0x180>;
> +		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru CLK_RGA_CORE>;
> +		clock-names = "aclk", "hclk", "sclk";
> +		resets = <&cru SRST_RGA_CORE>, <&cru SRST_A_RGA>, <&cru SRST_H_RGA>;
> +		reset-names = "core", "axi", "ahb";
> +		power-domains = <&power RK3568_PD_RGA>;
> +	};
> +
>   	vepu: video-codec@fdee0000 {
>   		compatible = "rockchip,rk3568-vepu";
>   		reg = <0x0 0xfdee0000 0x0 0x800>;
> @@ -948,6 +959,13 @@
>   		reg = <0x0 0xfe1a8100 0x0 0x20>;
>   	};
>   
> +	dfi: dfi@fe230000 {
> +		compatible = "rockchip,rk3568-dfi";
> +		reg = <0x00 0xfe230000 0x00 0x400>;
> +		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +		rockchip,pmu = <&pmugrf>;
> +	};
> +
>   	pcie2x1: pcie@fe260000 {
>   		compatible = "rockchip,rk3568-pcie";
>   		reg = <0x3 0xc0000000 0x0 0x00400000>,
> @@ -959,7 +977,7 @@
>   			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "sys", "pmc", "msi", "legacy", "err";
> +		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
>   		bus-range = <0x0 0xf>;
>   		clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
>   			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
> diff --git a/include/dt-bindings/clock/rk3568-cru.h b/include/dt-bindings/clock/rk3568-cru.h
> index c1942422a438..d29890865150 100644
> --- a/include/dt-bindings/clock/rk3568-cru.h
> +++ b/include/dt-bindings/clock/rk3568-cru.h
> @@ -478,6 +478,7 @@
>   #define CPLL_50M		415
>   #define CPLL_25M		416
>   #define CPLL_100M		417
> +#define SCLK_DDRCLK		418
>   
>   #define PCLK_CORE_PVTM		450
>   
