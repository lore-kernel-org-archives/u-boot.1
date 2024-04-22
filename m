Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3861CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80C787D49;
	Mon, 22 Apr 2024 10:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YMq6bUDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F13DD87E53; Mon, 22 Apr 2024 10:45:01 +0200 (CEST)
Received: from mail-m15577.qiye.163.com (mail-m15577.qiye.163.com
 [101.71.155.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89C1787D1D
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YMq6bUDYQfKOX/4HASt9LyvwB14FBC1NBHY5nPN918dgGiJbVbTJ3tQKsWHF4xkAhQhZDAq7m9ZSxdcGsPFQySjB3pZLgtK+QKD1dbvCwnpTVUAqlZGxXez6ljSk1NSK8Ng8VQQWUaUnAU/zfyAB8l9XlLmpmQ9ALZ53ehlV7CU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=tTxELcIEVcOhd9hH4aGAqIVeJIWvPNiImdtvaPTM15Y=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 19D8A9002DD;
 Mon, 22 Apr 2024 16:44:44 +0800 (CST)
Message-ID: <b1d69093-db1a-4213-bbc6-8aba3b47ec3e@rock-chips.com>
Date: Mon, 22 Apr 2024 16:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] rockchip: rk3308: Enable random generator
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de
References: <20240408181429.3676856-1-jonas@kwiboo.se>
 <20240408181429.3676856-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240408181429.3676856-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlMH1YfGk9JQx9LHU9CSklVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04faa22e03a9kunm19d8a9002dd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6Pgw6NjNIIjoIQio8Vh8T
 MwpPCRBVSlVKTEpITExOT0NOQkxDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0JJNwY+
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


On 2024/4/9 02:14, Jonas Karlman wrote:
> The RK3308 SoC contain a crypto engine block that can generate random
> numbers.
>
> Add rng node to soc u-boot.dtsi and enable Kconfig options to take
> advantage of the random generator.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: No change
> ---
>   arch/arm/dts/rk3308-u-boot.dtsi | 5 +++++
>   arch/arm/mach-rockchip/Kconfig  | 2 ++
>   2 files changed, 7 insertions(+)
>
> diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
> index 436f66d1b87d..fa31c838d34d 100644
> --- a/arch/arm/dts/rk3308-u-boot.dtsi
> +++ b/arch/arm/dts/rk3308-u-boot.dtsi
> @@ -26,6 +26,11 @@
>   			reg = <0x07 0x10>;
>   		};
>   	};
> +
> +	rng: rng@ff2f0000 {
> +		compatible = "rockchip,cryptov2-rng";
> +		reg = <0x0 0xff2f0000 0x0 0x4000>;
> +	};
>   };
>   
>   &cru {
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 6e07a70bf4ae..fa5917236a43 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -162,9 +162,11 @@ config ROCKCHIP_RK3308
>   	select SPL_LOAD_FIT
>   	imply ARMV8_CRYPTO
>   	imply ARMV8_SET_SMPEN
> +	imply DM_RNG
>   	imply LEGACY_IMAGE_FORMAT
>   	imply MISC
>   	imply MISC_INIT_R
> +	imply RNG_ROCKCHIP
>   	imply ROCKCHIP_COMMON_BOARD
>   	imply ROCKCHIP_OTP
>   	imply SPL_CLK
