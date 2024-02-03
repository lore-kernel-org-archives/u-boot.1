Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C769C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 13:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B4E878D0;
	Sat,  3 Feb 2024 14:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="xZ6Mh+Xb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9032087968; Sat,  3 Feb 2024 14:18:56 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A34378746C
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 14:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1706966334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0VssXrTCXdyFrsbfHhG9HV/Oi/Yzv0tK55h2g8OV6UY=;
 b=xZ6Mh+XbILEbN0iebIeKAin7vaAxmqgPjW3rLCxXq0wMaCTe/weqftrQAJyY7Rx6xfg/2l
 N8ENce2rwNCJ30mdPDS3dCdTamwY4wSocznjmq+0Ob/miQE2ubjS6h2o6xQ3JSwjuFiBJf
 kqFABUPn49LDjxapz7z9OwBqDOw3eZ+Zb3OSDDhkTKFxYgoYxBk3Uxm398MQBYRRFlPZ3W
 eMFobt7K6WLz6ue+ZR7Sdaim/+ult019al8QRlBKG798u/BfS8ygz60Msf6uXca9+KpnMo
 1HguZF05hTEz8ZZla+zcrPAY8SNfBH9S74kdFbKR0WxKs5h3dC4ikczHzW6kTg==
Date: Sat, 03 Feb 2024 14:18:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Tom Rini
 <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Peter
 Robinson <pbrobinson@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 07/18] rockchip: pine64: pinephone: migrate to
 rockchip_early_misc_init_r
In-Reply-To: <20240123-jaguar-v1-7-1eec1c34953c@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-7-1eec1c34953c@theobroma-systems.com>
Message-ID: <03bc1a9f1033a537d409c6f10f7c3f4f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

Please see my comments below.

On 2024-01-23 15:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Compared to the original misc_init_r from Rockchip mach code,
> setup_iodomain() is added and rockchip_setup_macaddr() is not called.
> 
> It is assumed adding rockchip_setup_macaddr() back is fine.
> Let's use rockchip_early_misc_init_r instead of reimplementing the 
> whole
> misc_init_r from Rockchip (the side effect being that
> rockchip_setup_macaddr() is back).

The patch subject should include "pinephone-pro" instead of just
"pinephone".  Those are two quite different devices.

Please see my comments on your 08/18 patch in this series, for the
RockPro64, which also apply to the Pinephone Pro.

> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  .../pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c  | 17 
> ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
> b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
> index b6ccbb9c1c4..de75ee329d8 100644
> --- a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
> +++ b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
> @@ -12,7 +12,6 @@
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/grf_rk3399.h>
>  #include <asm/arch-rockchip/hardware.h>
> -#include <asm/arch-rockchip/misc.h>
>  #include <power/regulator.h>
> 
>  #define GRF_IO_VSEL_BT565_GPIO2AB 1
> @@ -56,23 +55,11 @@ static void setup_iodomain(void)
>  	rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
>  }
> 
> -int misc_init_r(void)
> +int rockchip_early_misc_init_r(void)
>  {
> -	const u32 cpuid_offset = 0x7;
> -	const u32 cpuid_length = 0x10;
> -	u8 cpuid[cpuid_length];
> -	int ret;
> -
>  	setup_iodomain();
> 
> -	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
> -	if (ret)
> -		return ret;
> -
> -	ret = rockchip_cpuid_set(cpuid, cpuid_length);
> -	if (ret)
> -		return ret;
> +	return 0;
> 
> -	return ret;
>  }
>  #endif
