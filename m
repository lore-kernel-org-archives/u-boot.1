Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD1C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 02:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F372487727;
	Tue,  6 Feb 2024 03:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="g2AZhKIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B0C68786E; Tue,  6 Feb 2024 03:38:49 +0100 (CET)
Received: from mail-m49230.qiye.163.com (mail-m49230.qiye.163.com
 [45.254.49.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA61786DBD
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 03:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=g2AZhKIg5ChmeQqCHj5HR1cFCCcLmiWxDNh36kF23ZyItIxklCKL/+P9lfnEH+Ciu1+4kzrSN07xo4xGAPOK/PBM+jaaWIaRBayo3luekz98oILV2AyxvvWjFVKGGC4clryhtcWDaXPwuXkSeyGPUTj20eQH8Z7vJ46bVJyLJlA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=8fiAv5aOMkJJ2xrSSf0U/dbs0bGAdQymGLWcTGB1F/g=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A114390014E;
 Tue,  6 Feb 2024 10:38:40 +0800 (CST)
Message-ID: <502f8fb5-667d-40f3-a1b3-8916883cb844@rock-chips.com>
Date: Tue, 6 Feb 2024 10:38:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: dts: rockchip: rk3566: Remove unnecessary clks
 from rgxx3
Content-Language: en-US
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, jonas@kwiboo.se,
 jagan@amarulasolutions.com, Chris Morgan <macromorgan@hotmail.com>
References: <20240205185855.21508-1-macroalpha82@gmail.com>
 <20240205185855.21508-2-macroalpha82@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240205185855.21508-2-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9PSFZOShgeGRlKTU1CSBpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d7c482bfa03a9kunma114390014e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxw6Mxw4DzMSKTMYGBEsTUMQ
 CzgwCw5VSlVKTEtMSkNMSklKTUhNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQkJMNwY+
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

Hi Chris,

On 2024/2/6 02:58, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Remove unnecessary clock frequency defines from the RGxx3 u-boot dts.
> Move the necessary defines to the RGxx3 main dts file.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

First of all, the dts should follow the one in mainline kernel;

and why you need to over write the cru in U-Boot for this board, I 
didn't see this change

in other boards.


Thanks,

- Kever

> ---
>   .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 31 -------------------
>   arch/arm/dts/rk3566-anbernic-rgxx3.dts        |  7 +++++
>   2 files changed, 7 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> index f986e1941e..ef4f81500b 100644
> --- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> @@ -15,37 +15,6 @@
>   	};
>   };
>   
> -&cru {
> -	assigned-clocks =
> -			<&pmucru CLK_RTC_32K>,
> -			<&pmucru PLL_PPLL>,
> -			<&pmucru PCLK_PMU>, <&cru PLL_CPLL>,
> -			<&cru PLL_GPLL>,
> -			<&cru ACLK_BUS>, <&cru PCLK_BUS>,
> -			<&cru ACLK_TOP_HIGH>, <&cru ACLK_TOP_LOW>,
> -			<&cru HCLK_TOP>, <&cru PCLK_TOP>,
> -			<&cru ACLK_PERIMID>, <&cru HCLK_PERIMID>,
> -			<&cru CPLL_500M>, <&cru CPLL_333M>,
> -			<&cru CPLL_250M>, <&cru CPLL_125M>,
> -			<&cru CPLL_100M>, <&cru CPLL_62P5M>,
> -			<&cru CPLL_50M>, <&cru CPLL_25M>;
> -		assigned-clock-rates =
> -			<32768>,
> -			<200000000>,
> -			<100000000>, <1000000000>,
> -			<1188000000>,
> -			<150000000>, <100000000>,
> -			<500000000>, <400000000>,
> -			<150000000>, <100000000>,
> -			<300000000>, <150000000>,
> -			<500000000>, <333333333>,
> -			<250000000>, <125000000>,
> -			<100000000>, <62500000>,
> -			<50000000>, <25000000>;
> -		assigned-clock-parents =
> -			<&pmucru CLK_RTC32K_FRAC>;
> -};
> -
>   &dsi_dphy0 {
>   	status = "okay";
>   };
> diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3.dts b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
> index 404dddfafb..9e0aa9e63b 100644
> --- a/arch/arm/dts/rk3566-anbernic-rgxx3.dts
> +++ b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
> @@ -16,3 +16,10 @@
>   		     "anbernic,rg353v", "anbernic,rg353vs",
>   		     "anbernic,rg503", "rockchip,rk3566";
>   };
> +
> +&cru {
> +	assigned-clocks = <&pmucru CLK_RTC_32K>, <&cru PLL_GPLL>,
> +			  <&pmucru PLL_PPLL>, <&cru PLL_VPLL>;
> +	assigned-clock-rates = <32768>, <1200000000>,
> +			       <200000000>, <241500000>;
> +};
