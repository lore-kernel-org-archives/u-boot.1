Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AFCC47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F3F87C49;
	Thu,  1 Feb 2024 04:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="SWSOtTVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66ED587C61; Thu,  1 Feb 2024 04:00:51 +0100 (CET)
Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com
 [45.254.49.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEADA87C45
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=SWSOtTVAAP/EMxgGAivkk+SYh07nIffsjQLcP0aYGtgFfKb7Ma8d6QKtU+dEbaf5KsynrYdzWSH815QbU3WLe0TdtfzHYzvuRTKeG8HA9L6p7XN+U65HYGd1V4Vm9x2b6JgiPhLhsIaPf1jOsPFUGjFfn9InP94+cv5RU5fzw+I=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=8viueP4BEetmKTfX3Vlaif0IQeZvXMxn8aoXQbRYDjc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BD66B9001D9;
 Thu,  1 Feb 2024 11:00:38 +0800 (CST)
Message-ID: <a344b97b-17be-469c-abf8-033ed07915d3@rock-chips.com>
Date: Thu, 1 Feb 2024 11:00:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] rockchip: rk356x: Sync device tree from linux v6.8-rc1
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240126221508.4093334-1-jonas@kwiboo.se>
 <20240126221508.4093334-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240126221508.4093334-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MdGFZJQxofSkxPSUJLGhpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d629c7d3003a9kunmbd66b9001d9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBg6FQw5TzMcFE0VFx4wIS8t
 FU8aCRVVSlVKTEtNTE5NT0hCQ09LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSUhPNwY+
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
> Sync rk356x device tree from linux v6.8-rc1.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3566-quartz64-a.dts       | 5 +++--
>   arch/arm/dts/rk3566-radxa-cm3-io.dts     | 1 +
>   arch/arm/dts/rk3566-soquartz-blade.dts   | 4 ++++
>   arch/arm/dts/rk3566-soquartz-cm4.dts     | 4 ++++
>   arch/arm/dts/rk3566-soquartz-model-a.dts | 4 ++++
>   arch/arm/dts/rk3566-soquartz.dtsi        | 1 -
>   6 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/rk3566-quartz64-a.dts b/arch/arm/dts/rk3566-quartz64-a.dts
> index 854d02b46e6f..59843a7a199c 100644
> --- a/arch/arm/dts/rk3566-quartz64-a.dts
> +++ b/arch/arm/dts/rk3566-quartz64-a.dts
> @@ -31,8 +31,9 @@
>   	fan: gpio_fan {
>   		compatible = "gpio-fan";
>   		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> -		gpio-fan,speed-map = <0    0
> -				      4500 1>;
> +		gpio-fan,speed-map =
> +				<   0 0>,
> +				<4500 1>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&fan_en_h>;
>   		#cooling-cells = <2>;
> diff --git a/arch/arm/dts/rk3566-radxa-cm3-io.dts b/arch/arm/dts/rk3566-radxa-cm3-io.dts
> index 1b1c67d5b1ef..3ae24e39450a 100644
> --- a/arch/arm/dts/rk3566-radxa-cm3-io.dts
> +++ b/arch/arm/dts/rk3566-radxa-cm3-io.dts
> @@ -14,6 +14,7 @@
>   	compatible = "radxa,cm3-io", "radxa,cm3", "rockchip,rk3566";
>   
>   	aliases {
> +		ethernet0 = &gmac1;
>   		mmc1 = &sdmmc0;
>   	};
>   
> diff --git a/arch/arm/dts/rk3566-soquartz-blade.dts b/arch/arm/dts/rk3566-soquartz-blade.dts
> index 4e49bebf548b..fdbf1c783242 100644
> --- a/arch/arm/dts/rk3566-soquartz-blade.dts
> +++ b/arch/arm/dts/rk3566-soquartz-blade.dts
> @@ -13,6 +13,10 @@
>   	model = "PINE64 RK3566 SOQuartz on Blade carrier board";
>   	compatible = "pine64,soquartz-blade", "pine64,soquartz", "rockchip,rk3566";
>   
> +	aliases {
> +		ethernet0 = &gmac1;
> +	};
> +
>   	/* labeled VCC3V0_SD in schematic to not conflict with PMIC regulator */
>   	vcc3v0_sd: vcc3v0-sd-regulator {
>   		compatible = "regulator-fixed";
> diff --git a/arch/arm/dts/rk3566-soquartz-cm4.dts b/arch/arm/dts/rk3566-soquartz-cm4.dts
> index cddf6cd2fecb..6ed3fa4aee34 100644
> --- a/arch/arm/dts/rk3566-soquartz-cm4.dts
> +++ b/arch/arm/dts/rk3566-soquartz-cm4.dts
> @@ -8,6 +8,10 @@
>   	model = "Pine64 RK3566 SoQuartz with CM4-IO Carrier Board";
>   	compatible = "pine64,soquartz-cm4io", "pine64,soquartz", "rockchip,rk3566";
>   
> +	aliases {
> +		ethernet0 = &gmac1;
> +	};
> +
>   	/* labeled +12v in schematic */
>   	vcc12v_dcin: vcc12v-dcin-regulator {
>   		compatible = "regulator-fixed";
> diff --git a/arch/arm/dts/rk3566-soquartz-model-a.dts b/arch/arm/dts/rk3566-soquartz-model-a.dts
> index 2208dbfb7f0a..f2095dfa4eaf 100644
> --- a/arch/arm/dts/rk3566-soquartz-model-a.dts
> +++ b/arch/arm/dts/rk3566-soquartz-model-a.dts
> @@ -8,6 +8,10 @@
>   	model = "PINE64 RK3566 SOQuartz on Model A carrier board";
>   	compatible = "pine64,soquartz-model-a", "pine64,soquartz", "rockchip,rk3566";
>   
> +	aliases {
> +		ethernet0 = &gmac1;
> +	};
> +
>   	/* labeled DCIN_12V in schematic */
>   	vcc12v_dcin: vcc12v-dcin-regulator {
>   		compatible = "regulator-fixed";
> diff --git a/arch/arm/dts/rk3566-soquartz.dtsi b/arch/arm/dts/rk3566-soquartz.dtsi
> index 63bae36b8f7e..bfb7b952f4c5 100644
> --- a/arch/arm/dts/rk3566-soquartz.dtsi
> +++ b/arch/arm/dts/rk3566-soquartz.dtsi
> @@ -12,7 +12,6 @@
>   	compatible = "pine64,soquartz", "rockchip,rk3566";
>   
>   	aliases {
> -		ethernet0 = &gmac1;
>   		mmc0 = &sdmmc0;
>   		mmc1 = &sdhci;
>   		mmc2 = &sdmmc1;
