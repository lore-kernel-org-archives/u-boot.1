Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EBBC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54CD488859;
	Fri,  9 Aug 2024 11:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Pvz9X2mx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB1188BC6; Fri,  9 Aug 2024 11:38:40 +0200 (CEST)
Received: from mail-aws19832.qiye.163.com (mail-aws19832.qiye.163.com
 [18.159.198.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE8388581
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Pvz9X2mxdnKsNPgmKbRuEnye0UiGgHdUNGbtbFt1qrC5Qz71fxHHwZONpLXhPM2ECX5J91WeWRdFyJU/NkDzsZNV4pNlQr591Wvh7v4aB9kPmz8tSL5CajVmXU4gHcNJ03sLrk+qhpGl4Y1PYNfBxSlT/FOvrybEDKUveS7Jr8U=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=zYmEiq6saxPucV1aaJSEHjil7VhEtUrTzZXhMrI/u4Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id EE76390013B;
 Fri,  9 Aug 2024 17:38:23 +0800 (CST)
Message-ID: <1cd6b2e5-e63c-40bd-b165-cf43c7d443c1@rock-chips.com>
Date: Fri, 9 Aug 2024 17:38:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] rockchip: gpio: Add gpio-ranges props
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Johan Jonker <jbx6244@gmail.com>
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802225705.2640999-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQh4YVh9OSk9JSh9JQx4fGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lIQkhCVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a913680ec7803a9kunmee76390013b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K1E6Pxw*UTI0PQ4#PTIQLUsa
 LE8KCgNVSlVKTElISkJNSEtOS09MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUJISUo3Bg++
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


On 2024/8/3 06:56, Jonas Karlman wrote:
> Add gpio-ranges props to supported SoCs based on the following Linux
> patches:
>
> ARM: dts: rockchip: add gpio-ranges property to gpio nodes
> https://lore.kernel.org/all/26007385-81dc-9961-05d5-8b9a0969d0b6@gmail.com/
>
> arm64: dts: rockchip: add gpio-ranges property to gpio nodes
> https://lore.kernel.org/all/18c8c89a-9962-40f0-814f-81e2c420c957@gmail.com/
>
> For RK3066 and RK3288 the gpio-ranges props is adjusted to match
> https://lore.kernel.org/all/541b7633-af3b-4392-ac29-7ee1f2c6f943@kwiboo.se/
>
> Re-enable gpio6 on RK3066 now that the pinctrl pin offset is used with
> get_gpio_mux().
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Collect r-b tag
>
> Cc: Johan Jonker <jbx6244@gmail.com>
> ---
>   arch/arm/dts/rk3036-u-boot.dtsi  | 12 ++++++++++++
>   arch/arm/dts/rk3066a-u-boot.dtsi |  3 +--
>   arch/arm/dts/rk3128-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/rk322x-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/rk3288-u-boot.dtsi  | 33 ++++++++++++++++++++++++++++++++
>   arch/arm/dts/rk3308-u-boot.dtsi  | 20 +++++++++++++++++++
>   arch/arm/dts/rk3328-u-boot.dtsi  | 13 +++++++++++++
>   arch/arm/dts/rk3368-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/rk3399-u-boot.dtsi  | 20 +++++++++++++++++++
>   arch/arm/dts/rv1108-u-boot.dtsi  | 16 ++++++++++++++++
>   arch/arm/dts/rv1126-u-boot.dtsi  | 14 ++++++++++++++
>   11 files changed, 177 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3036-u-boot.dtsi b/arch/arm/dts/rk3036-u-boot.dtsi
> index 41ac054b81e8..3e788187f630 100644
> --- a/arch/arm/dts/rk3036-u-boot.dtsi
> +++ b/arch/arm/dts/rk3036-u-boot.dtsi
> @@ -4,3 +4,15 @@
>    */
>   
>   #include "rockchip-u-boot.dtsi"
> +
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-boot.dtsi
> index 06f405ca2c5e..35b52d6fb7f3 100644
> --- a/arch/arm/dts/rk3066a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3066a-u-boot.dtsi
> @@ -24,6 +24,5 @@
>   };
>   
>   &gpio6 {
> -	status = "disabled";
> +	gpio-ranges = <&pinctrl 0 160 16>;
>   };
> -
> diff --git a/arch/arm/dts/rk3128-u-boot.dtsi b/arch/arm/dts/rk3128-u-boot.dtsi
> index 6d1965e6b520..dd1208e7cf40 100644
> --- a/arch/arm/dts/rk3128-u-boot.dtsi
> +++ b/arch/arm/dts/rk3128-u-boot.dtsi
> @@ -14,6 +14,22 @@
>   	bootph-all;
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> +
>   &grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rk322x-u-boot.dtsi b/arch/arm/dts/rk322x-u-boot.dtsi
> index aea917544b1c..f0e2a1f95aa0 100644
> --- a/arch/arm/dts/rk322x-u-boot.dtsi
> +++ b/arch/arm/dts/rk322x-u-boot.dtsi
> @@ -47,6 +47,22 @@
>   	max-frequency = <150000000>;
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> +
>   &grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
> index a43d320ade7b..0f8053a8b690 100644
> --- a/arch/arm/dts/rk3288-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-u-boot.dtsi
> @@ -95,8 +95,41 @@
>   	clock-names = "clk_edp", "clk_edp_24m", "pclk_edp";
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 24>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 24 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 56 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 88 32>;
> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 120 32>;
> +};
> +
> +&gpio5 {
> +	gpio-ranges = <&pinctrl 0 152 32>;
> +};
> +
> +&gpio6 {
> +	gpio-ranges = <&pinctrl 0 184 32>;
> +};
> +
>   &gpio7 {
>   	bootph-all;
> +	gpio-ranges = <&pinctrl 0 216 32>;
> +};
> +
> +&gpio8 {
> +	gpio-ranges = <&pinctrl 0 248 16>;
>   };
>   
>   &grf {
> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
> index b7964e2756f3..c2d56b532f80 100644
> --- a/arch/arm/dts/rk3308-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
> @@ -54,6 +54,26 @@
>   	bootph-some-ram;
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 128 32>;
> +};
> +
>   &grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
> index 0135bc08d491..3bc776146a82 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -57,6 +57,19 @@
>   
>   &gpio0 {
>   	bootph-pre-ram;
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
>   };
>   
>   &grf {
> diff --git a/arch/arm/dts/rk3368-u-boot.dtsi b/arch/arm/dts/rk3368-u-boot.dtsi
> index 811d59ac346e..be2ebda83529 100644
> --- a/arch/arm/dts/rk3368-u-boot.dtsi
> +++ b/arch/arm/dts/rk3368-u-boot.dtsi
> @@ -26,3 +26,19 @@
>   		reg = <0x0 0xff740000 0x0 0x1000>;
>   	};
>   };
> +
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index c4c8bb1401ea..cead23ea7c20 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -91,6 +91,26 @@
>   	bootph-some-ram;
>   };
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 128 32>;
> +};
> +
>   &grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rv1108-u-boot.dtsi b/arch/arm/dts/rv1108-u-boot.dtsi
> index ccf2d8bd83ec..f772d618bd1d 100644
> --- a/arch/arm/dts/rv1108-u-boot.dtsi
> +++ b/arch/arm/dts/rv1108-u-boot.dtsi
> @@ -5,6 +5,22 @@
>   
>   #include "rockchip-u-boot.dtsi"
>   
> +&gpio0 {
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +};
> +
> +&gpio1 {
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> +
>   &grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/rv1126-u-boot.dtsi b/arch/arm/dts/rv1126-u-boot.dtsi
> index 448598013578..3e6df1e433db 100644
> --- a/arch/arm/dts/rv1126-u-boot.dtsi
> +++ b/arch/arm/dts/rv1126-u-boot.dtsi
> @@ -31,10 +31,24 @@
>   
>   &gpio0 {
>   	bootph-pre-ram;
> +	gpio-ranges = <&pinctrl 0 0 32>;
>   };
>   
>   &gpio1 {
>   	bootph-pre-ram;
> +	gpio-ranges = <&pinctrl 0 32 32>;
> +};
> +
> +&gpio2 {
> +	gpio-ranges = <&pinctrl 0 64 32>;
> +};
> +
> +&gpio3 {
> +	gpio-ranges = <&pinctrl 0 96 32>;
> +};
> +
> +&gpio4 {
> +	gpio-ranges = <&pinctrl 0 128 2>;
>   };
>   
>   &grf {
