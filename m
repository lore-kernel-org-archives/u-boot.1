Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC89ED0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA7688FAC;
	Fri, 25 Oct 2024 13:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fzr17CFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D600888FEC; Fri, 25 Oct 2024 13:59:44 +0200 (CEST)
Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com
 [117.135.214.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E92488FAC
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe5857;
 Fri, 25 Oct 2024 19:59:30 +0800 (GMT+08:00)
Message-ID: <3c859a31-e59b-461c-b9f6-103a263f63d1@rock-chips.com>
Date: Fri, 25 Oct 2024 19:59:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/18] arm64: dts: rockchip: add gpio-keys to Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-11-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-11-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0geT1ZCSx4dSRhOT0xLH0hWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38bc5cd09d6kunmebe5857
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6Ngw*KzIjExciKUtMNh4e
 HFYKCT1VSlVKTElCQ05MTkxKSkxMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSEhPNwY+
DKIM-Signature: a=rsa-sha256;
 b=fzr17CFA7aGSHpIlXbTnWjdYr+8uoPyYdD5YkGh/2ylh3NJGReAVJygkC3g0zBziKxbTdJ5bj9gQSRHOYpn7DrfAeasGNnpm7ILU0rwFM6KICJoDHyXK9Bwqh99sUcnwYwFs2H9rkbo+vpYbOSJm1qyO51rrm9jbEXrPA26LlfY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=jVpyGLWpbh4PT2Vb1LxXz4mY0iv2gAQNVWykH9Ge3hM=;
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
> The TS433 has 3 buttons, power and copy in the front as well as a reset
> pinhole button on the back. The power-button is connected to the embedded
> controller while the other two buttons are just gpio connected.
>
> Add the gpio-keys definition for the two buttons we can handle right now.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-11-heiko@sntech.de
>
> [ upstream commit: 9b682d31b24f1f70b5b4d0618095d46e0722b9d8 ]
>
> (cherry picked from commit f0b858c751382ee9faf18f9b19b0817c6b50ac1c)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 29 +++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index 34fc31ea9a3..9f964b6f411 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -6,6 +6,7 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/input/input.h>
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include "rk3568.dtsi"
> @@ -24,6 +25,24 @@
>   		stdout-path = "serial2:115200n8";
>   	};
>   
> +	keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&copy_button_pin>, <&reset_button_pin>;
> +		pinctrl-names = "default";
> +
> +		key-copy {
> +			label = "copy";
> +			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_COPY>;
> +		};
> +
> +		key-reset {
> +			label = "reset";
> +			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_RESTART>;
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   
> @@ -202,6 +221,16 @@
>   };
>   
>   &pinctrl {
> +	keys {
> +		copy_button_pin: copy-button-pin {
> +			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		reset_button_pin: reset-button-pin {
> +			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
>   	leds {
>   		hdd1_led_pin: hdd1-led-pin {
>   			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
