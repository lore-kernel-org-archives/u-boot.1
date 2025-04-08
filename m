Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B912CC3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35DB5832B3;
	Tue,  8 Apr 2025 05:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="A95z3ZX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF50832B3; Tue,  8 Apr 2025 05:22:17 +0200 (CEST)
Received: from ec2-44-216-146-169.compute-1.amazonaws.com
 (ec2-44-216-146-169.compute-1.amazonaws.com [44.216.146.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD49D83334
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 11020899a;
 Tue, 8 Apr 2025 11:22:08 +0800 (GMT+08:00)
Message-ID: <d088fb76-b885-488d-a77e-89034a49734a@rock-chips.com>
Date: Tue, 8 Apr 2025 11:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/30] arm64: dts: rockchip: Add leds node to Radxa E20C
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hCGVYZHx9NGUlLQh5MTUpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136b6a1803afkunm11020899a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6Nzo4SzJRTEIYARA6Ti8Q
 TCowCixVSlVKTE9PS0NJTkhLS09OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISExNNwY+
DKIM-Signature: a=rsa-sha256;
 b=A95z3ZX8c1YITWCTKutiz+eBorE0Afr16hZBtCS9NHrt35EoID+1pCniEtYfAH8xs8iE8nqSX5KuOmCeHrb6WIej3iCqMEZSAcBKKvRWX9RgM2GEgIIW9GmLIbmxNa5LTsXlgLa0b0U6Fot9P9JjPsrk1PtqJPvLoQhKqShRPWQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=eUlAgtQ94CUGs8kyZc83yn90qYcTX/X8YMpWzwzCTv8=;
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
> Radxa E20C has three gpio controlled leds (sys, wan and lan).
>
> Add led nodes and set default trigger to heartbeat for the sys led and
> netdev for the lan and wan leds.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Link: https://lore.kernel.org/r/20250304201642.831218-2-jonas@kwiboo.se
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: 6a709e003492e9878d5f1357be0b2e1162e1e6a6 ]
>
> (cherry picked from commit a3556ede6b48c7760ac3608ad77601fca26d2ce0)
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3528-radxa-e20c.dts  | 48 +++++++++++++++++++
>   1 file changed, 48 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> index 5161d22330ab..7f0237206405 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3528-radxa-e20c.dts
> @@ -6,6 +6,8 @@
>    */
>   
>   /dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
>   #include "rk3528.dtsi"
>   
>   / {
> @@ -15,6 +17,52 @@
>   	chosen {
>   		stdout-path = "serial0:1500000n8";
>   	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&lan_led_g>, <&sys_led_g>, <&wan_led_g>;
> +
> +		led-lan {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_LAN;
> +			gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "netdev";
> +		};
> +
> +		led-sys {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "on";
> +			function = LED_FUNCTION_HEARTBEAT;
> +			gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-wan {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_WAN;
> +			gpios = <&gpio4 RK_PC0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "netdev";
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	leds {
> +		lan_led_g: lan-led-g {
> +			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		sys_led_g: sys-led-g {
> +			rockchip,pins = <4 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		wan_led_g: wan-led-g {
> +			rockchip,pins = <4 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
>   };
>   
>   &uart0 {
