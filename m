Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079B0C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D8F8334F;
	Tue,  8 Apr 2025 05:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Shq4+C4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D57ED8334A; Tue,  8 Apr 2025 05:22:23 +0200 (CEST)
Received: from mail-m32122.qiye.163.com (mail-m32122.qiye.163.com
 [220.197.32.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098F68332E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1102089cb;
 Tue, 8 Apr 2025 11:22:15 +0800 (GMT+08:00)
Message-ID: <2a19dbeb-1913-4ca6-8aaf-ed9d1d85d14c@rock-chips.com>
Date: Tue, 8 Apr 2025 11:22:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/30] arm64: dts: rockchip: Add user button to Radxa
 E20C
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-12-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-12-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxNSlZMShlIT0xMSR0YGRhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136b865703afkunm1102089cb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6LSo6QzJJIUJIERVCTiwC
 Ig4KCTNVSlVKTE9PS0NJTkhMT0tIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTEJMNwY+
DKIM-Signature: a=rsa-sha256;
 b=Shq4+C4wGC9D2NLXkoa1pzfAuzVapZb3GRLiL+GvSrRz1h3FSbwEJhDLaTeVKRadocGnt8k9hfogyasx1/0LBc868tmQY5lFsyj+v8+QUJ5o/z8f77m8v+7K94rQkzLK96C9S1xM9VCC7GxTPuF6AIT3Kj8A3xnZT8msGLcR8F0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=rmxm8B4CYVRuIkt102wuZ0alkDwjRuiOobDnLg1f4Ns=;
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


On 2025/4/8 06:46, Jonas Karlman wrote:
> Radxa E20C has two buttons, one SARADC maskrom button and one GPIO user
> button.
>
> Add support for the user button using a gpio-keys node.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20250304201642.831218-3-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: ad8afc8813567994164f2720189c819da8c22b99 ]
>
> (cherry picked from commit 6793b56b79df26ab3323e5293b97577d0786ddb3)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3528-radxa-e20c.dts  | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> index 7f0237206405..b378774d2a4e 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> @@ -7,6 +7,7 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/input/input.h>
>   #include <dt-bindings/leds/common.h>
>   #include "rk3528.dtsi"
>   
> @@ -18,6 +19,19 @@
>   		stdout-path = "serial0:1500000n8";
>   	};
>   
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&user_key>;
> +
> +		button-user {
> +			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
> +			label = "USER";
> +			linux,code = <BTN_1>;
> +			wakeup-source;
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> @@ -50,6 +64,12 @@
>   };
>   
>   &pinctrl {
> +	gpio-keys {
> +		user_key: user-key {
> +			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
>   	leds {
>   		lan_led_g: lan-led-g {
>   			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
