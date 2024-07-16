Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F3DC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 10:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E36DC88977;
	Tue, 16 Jul 2024 12:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TwlCFPKU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08DD88821; Tue, 16 Jul 2024 12:21:55 +0200 (CEST)
Received: from mail-m127215.xmail.ntesmail.com
 (mail-m127215.xmail.ntesmail.com [115.236.127.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88681889DE
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=TwlCFPKUohidSnOLvLBgeKAvgh67YeOBIgKaYmm3x9XfcFMEzhYt2ZAnxzgjsXUa0jsmRyyxTF/kPDbbkEHYYTFeWF477q4prTJYw8f6HR5SS3QRYkY4Oxaj8lNjpCEn6vHvv7FSo898ap6nyiNe1F837ezbDnANCEZxBAnLSU4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=dJhGHhcm5q9xfNDMHmbXYR5BJp4JU+KGlzZRhJLF120=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8C863900659;
 Tue, 16 Jul 2024 18:21:44 +0800 (CST)
Message-ID: <f0f2fcd1-5e28-454e-9355-76442c64afe4@rock-chips.com>
Date: Tue, 16 Jul 2024 18:21:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] rockchip: gpio: Add gpio-ranges props
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
 <20240512121633.1632597-10-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240512121633.1632597-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlITVZOSk1JQ00eTUlMSxpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a90bb0ffbd803a9kunm8c863900659
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORQ6Ljo4HzI#Mh0vAzAxMhY9
 IjpPCwxVSlVKTElKSklOSEtOTENPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCSENKNwY+
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


On 2024/5/12 20:16, Jonas Karlman wrote:
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
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
> index 684fa7abddb1..7d3cf55c33fa 100644
> --- a/arch/arm/dts/rk3308-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
> @@ -70,6 +70,26 @@
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
> index b6b43271172e..b85aac0ad0d1 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -80,6 +80,26 @@
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
