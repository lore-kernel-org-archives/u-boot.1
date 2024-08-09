Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596FEC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D67CA8708B;
	Fri,  9 Aug 2024 11:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JyvGXSKz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B98588708B; Fri,  9 Aug 2024 11:17:10 +0200 (CEST)
Received: from mail-m3291.qiye.163.com (mail-m3291.qiye.163.com
 [220.197.32.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFCF86BF1
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JyvGXSKz5xi9R2NA/7ixY6SYlnFnoJaVHAWZXmB7tYzEqY2UsQUn3dfTUVBSHQpeRyqCiDxv3T1vzosm0yeI9b3XuL/cFmWOPRbmUfFMaF0kdM/EvrvdxAc1CiWfiQsGkdxMoXoQHobWbFZOqeOG7Nh4euUYMnUMTVjNMbrTYP4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=nfKpwui+iN7Xh8aq7YYM3dyYnl2vvcvKCWsiJ67W1T4=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id E2042900608;
 Fri,  9 Aug 2024 17:16:45 +0800 (CST)
Message-ID: <ea8287b6-352d-48cf-b370-0d90d2990f08@rock-chips.com>
Date: Fri, 9 Aug 2024 17:16:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: fix dts for Radxa ROCK 4C+
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, sjg@chromium.org, philipp.tomsich@vrull.eu,
 dsimic@manjaro.org
References: <20240808221902.2006-1-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240808221902.2006-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSBpPVk9LSU9MHU5LQh0dTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91366d1df603a9kunme2042900608
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MlE6Mgw5MTI#SA5CPzw6NAg6
 MhoaCkJVSlVKTElISkJOS0tMS01JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlMT0k3Bg++
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


On 2024/8/9 06:19, FUKAUMI Naoki wrote:
> Radxa ROCK Pi 4 series and Radxa ROCK 4C+ are not compatible.

A little bit more detail about why not compatible?

The eMMC is different?

Thanks,

- Kever

> add
> rk3399-rock-pi-4-u-boot.dtsi contents and remove dependency of it.
>
> no functional change is intended.
>
> Fixes: 71a95e2efd30 ("arm: dts: rockchip: add Radxa ROCK 4C+")
> Suggested-by: Dragan Simic <dsimic@manjaro.org>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>   arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> index 5ec15a845c1..50dae5cb5ef 100644
> --- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> @@ -1,8 +1,10 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
> + * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
>    * Copyright (c) 2023 Radxa Limited
>    */
> -#include "rk3399-rock-pi-4-u-boot.dtsi"
> +#include "rk3399-u-boot.dtsi"
> +#include "rk3399-sdram-lpddr4-100.dtsi"
>   
>   &pcfg_pull_none_18ma {
>   	bootph-pre-ram;
> @@ -14,6 +16,12 @@
>   	bootph-some-ram;
>   };
>   
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +};
> +
>   &spi1 {
>   	status = "okay";
>   
> @@ -25,3 +33,7 @@
>   		spi-max-frequency = <10000000>;
>   	};
>   };
> +
> +&vdd_log {
> +	regulator-init-microvolt = <950000>;
> +};
