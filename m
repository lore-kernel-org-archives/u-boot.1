Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA70C52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F03188859;
	Fri,  9 Aug 2024 11:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dfEdZK4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8775B88BC8; Fri,  9 Aug 2024 11:39:27 +0200 (CEST)
Received: from mail-m121146.qiye.163.com (mail-m121146.qiye.163.com
 [115.236.121.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0163088581
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dfEdZK4/XGkz1XtVHOxXOo/+5SnyOBORaM9fR0VEve0v0m4SUs9T4xCsUYOJbWFSnkcOU65iwau32aWL5csNrB3UvErArk6zNdA66Z8eZkrVF8qpcdcdQhKFdZ8yuMrFXvv7S9bkrOfkFgVM/KQvCbsoWB/zcmIe9tzqkC/K+UE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=dkpRCIRbyjWiGCHKRUuIQrczxsC3dpYGJiyTSUpXcgA=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 38582900653;
 Fri,  9 Aug 2024 17:39:14 +0800 (CST)
Message-ID: <72a786ce-74c1-455b-aa4d-910e02c52e28@rock-chips.com>
Date: Fri, 9 Aug 2024 17:39:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] rockchip: gpio: Add missing gpio aliases
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-11-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802225705.2640999-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGRhNVkNLGh0ZGUIdQk8ZSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a913681b05b03a9kunm38582900653
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6Eyo6TzI*Vg4dFzcVLBoK
 PUsKCh1VSlVKTElISkJNSE5OSk5MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9CQ0o3Bg++
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
> Add aliases for gpio controllers to soc u-boot dtsi files that are
> missing aliases in soc dtsi files to ensure dev_seq() return the
> expected number when a gpio controller is included in SPL.
>
> Also drop the aliases from rk3288-u-boot.dtsi, they are already part of
> rk3288.dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   arch/arm/dts/px30-u-boot.dtsi    | 4 ++++
>   arch/arm/dts/rk3066a-u-boot.dtsi | 7 +++++++
>   arch/arm/dts/rk3288-u-boot.dtsi  | 9 ---------
>   arch/arm/dts/rk3xxx-u-boot.dtsi  | 7 +++++++
>   arch/arm/dts/rv1108-u-boot.dtsi  | 9 +++++++++
>   arch/arm/dts/rv1126-u-boot.dtsi  | 8 ++++++++
>   6 files changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
> index abc6b49e6663..3dc70d4e432b 100644
> --- a/arch/arm/dts/px30-u-boot.dtsi
> +++ b/arch/arm/dts/px30-u-boot.dtsi
> @@ -7,6 +7,10 @@
>   
>   / {
>   	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
>   		mmc0 = &emmc;
>   		mmc1 = &sdmmc;
>   	};
> diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-boot.dtsi
> index 35b52d6fb7f3..60d18d2daeac 100644
> --- a/arch/arm/dts/rk3066a-u-boot.dtsi
> +++ b/arch/arm/dts/rk3066a-u-boot.dtsi
> @@ -3,6 +3,13 @@
>   #include "rockchip-u-boot.dtsi"
>   #include "rk3xxx-u-boot.dtsi"
>   
> +/ {
> +	aliases {
> +		gpio4 = &gpio4;
> +		gpio6 = &gpio6;
> +	};
> +};
> +
>   &gpio0 {
>   	gpio-ranges = <&pinctrl 0 0 32>;
>   };
> diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
> index 0f8053a8b690..379d9413adee 100644
> --- a/arch/arm/dts/rk3288-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-u-boot.dtsi
> @@ -7,15 +7,6 @@
>   
>   / {
>   	aliases {
> -		gpio0 = &gpio0;
> -		gpio1 = &gpio1;
> -		gpio2 = &gpio2;
> -		gpio3 = &gpio3;
> -		gpio4 = &gpio4;
> -		gpio5 = &gpio5;
> -		gpio6 = &gpio6;
> -		gpio7 = &gpio7;
> -		gpio8 = &gpio8;
>   		mmc0 = &emmc;
>   		mmc1 = &sdmmc;
>   		mmc2 = &sdio0;
> diff --git a/arch/arm/dts/rk3xxx-u-boot.dtsi b/arch/arm/dts/rk3xxx-u-boot.dtsi
> index 6af6a451ea78..097407ca72dc 100644
> --- a/arch/arm/dts/rk3xxx-u-boot.dtsi
> +++ b/arch/arm/dts/rk3xxx-u-boot.dtsi
> @@ -1,6 +1,13 @@
>   // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>   
>   / {
> +	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
> +	};
> +
>   	noc: syscon@10128000 {
>   		compatible = "rockchip,rk3188-noc", "syscon";
>   		reg = <0x10128000 0x2000>;
> diff --git a/arch/arm/dts/rv1108-u-boot.dtsi b/arch/arm/dts/rv1108-u-boot.dtsi
> index f772d618bd1d..58711e8b2f8a 100644
> --- a/arch/arm/dts/rv1108-u-boot.dtsi
> +++ b/arch/arm/dts/rv1108-u-boot.dtsi
> @@ -5,6 +5,15 @@
>   
>   #include "rockchip-u-boot.dtsi"
>   
> +/ {
> +	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
> +	};
> +};
> +
>   &gpio0 {
>   	gpio-ranges = <&pinctrl 0 0 32>;
>   };
> diff --git a/arch/arm/dts/rv1126-u-boot.dtsi b/arch/arm/dts/rv1126-u-boot.dtsi
> index 3e6df1e433db..05b5f5260dd5 100644
> --- a/arch/arm/dts/rv1126-u-boot.dtsi
> +++ b/arch/arm/dts/rv1126-u-boot.dtsi
> @@ -6,6 +6,14 @@
>   #include "rockchip-u-boot.dtsi"
>   
>   / {
> +	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +		gpio3 = &gpio3;
> +		gpio4 = &gpio4;
> +	};
> +
>   	chosen {
>   		u-boot,spl-boot-order = \
>   			"same-as-spl", &emmc, &sdmmc;
