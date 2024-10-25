Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCFBD0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0319A88FCB;
	Fri, 25 Oct 2024 13:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eTwX1UkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2713D89011; Fri, 25 Oct 2024 13:59:17 +0200 (CEST)
Received: from mail-m15574.qiye.163.com (mail-m15574.qiye.163.com
 [101.71.155.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0A688FD5
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe5845;
 Fri, 25 Oct 2024 19:59:10 +0800 (GMT+08:00)
Message-ID: <28ff2408-22c0-4eba-bfda-0669b88cb5ee@rock-chips.com>
Date: Fri, 25 Oct 2024 19:59:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] arm64: dts: rockchip: add hdd leds to Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-9-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-9-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklCHlYfHR5KGEhMGU9OQ0lWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38b773e09d6kunmebe5845
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PhQ6FAw5IzIqDxdKKUtJNikD
 IgsKCxJVSlVKTElCQ05MTk5KT0xPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISk1NNwY+
DKIM-Signature: a=rsa-sha256;
 b=eTwX1UkR9kfgH3bhcnZsnCfASXwdn1INFNb5/pzv/EIJnSH38fCxc735sLTY8CUHN25lmSyE+o7m8O1lSNStxIQDMlXuBsDUSfUgFddyov3E4CqhD+2GDZ3G0B2ZU+P2TLHQNUT6ivp6pc0hxXji+pFnTCPQHKenqE0j0m73gRw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=tdkEVOTLdkUhKGdUNre8U3q8HzgpgU9AwqieUHrHLvQ=;
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


On 2024/10/14 03:24, Heiko Stuebner wrote:
> Add the 4 gpio-controlled LEDs to the Qnap-TS433.
>
> They are meant for individual disk activitivy, but I haven't found a
> way for how to connect them to their individual sata slot yet.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-9-heiko@sntech.de
>
> [ upstream commit: ea91aabf18bcad6f5eceae6848ea6570ea61f126 ]
>
> (cherry picked from commit 5a11b1bb40ac7b39e04077c045c3e3409fa352e2)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 59 +++++++++++++++++++
>   1 file changed, 59 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index 8be36250aa1..abeb00add42 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -6,6 +6,7 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/leds/common.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include "rk3568.dtsi"
>   
> @@ -23,6 +24,46 @@
>   		stdout-path = "serial2:115200n8";
>   	};
>   
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DISK;
> +			gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "disk-activity";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hdd1_led_pin>;
> +		};
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DISK;
> +			gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "disk-activity";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hdd2_led_pin>;
> +		};
> +
> +		led-2 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DISK;
> +			gpios = <&gpio1 RK_PD7 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "disk-activity";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hdd3_led_pin>;
> +		};
> +
> +		led-3 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_DISK;
> +			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "disk-activity";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hdd4_led_pin>;
> +		};
> +	};
> +
>   	dc_12v: regulator-dc-12v {
>   		compatible = "regulator-fixed";
>   		regulator-name = "dc_12v";
> @@ -161,6 +202,24 @@
>   };
>   
>   &pinctrl {
> +	leds {
> +		hdd1_led_pin: hdd1-led-pin {
> +			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		hdd2_led_pin: hdd2-led-pin {
> +			rockchip,pins = <1 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		hdd3_led_pin: hdd3-led-pin {
> +			rockchip,pins = <1 RK_PD7 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		hdd4_led_pin: hdd4_led-pin {
> +			rockchip,pins = <2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
>   	usb {
>   		vcc5v0_host_en: vcc5v0-host-en {
>   			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
