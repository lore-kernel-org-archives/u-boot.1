Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF2FC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 17:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09FCB87E87;
	Fri,  9 Feb 2024 18:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="IaAPtOSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 038B487E88; Fri,  9 Feb 2024 18:55:57 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD7087E87
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 18:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707501353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xxuRTB13/QUhoop8En3m43QstIkymDi/fokbF3PrIA=;
 b=IaAPtOScBQkWF5OPV2cYsJ0Vbj+1ocnszbrCJ3qgKlJt671QUrlZy9zPmm1aQgxClLWWTo
 Gml2MuQjpBBQj21PTYgnSMMOWr5ZWPB/KNW+T9zF9sttz1lrAZCCK/Sks2DLt8Fp3fsb0y
 Zn02TPOeXTRFNGDqQNQpEZ3saq3ly2KB8uApm9QPRmgJp6gS6zUJKBETx+gTeEaBvZ5IW9
 n2JvBHOPUyBX0WhDhQNpQrMZLogni73XiveKkuHmTo6I5VYtJJewIunYr8dpo3xcqX/Epv
 sjbgrnhsN+Hpl0d6jojEGY6aNzmHaJYM4XqcTgJQ+kuLMZFcQhlFNM0YaFborA==
Date: Fri, 09 Feb 2024 18:55:53 +0100
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
 <agust@denx.de>, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2 05/20] rockchip: pine64: pinephone-pro: migrate to
 rockchip_early_misc_init_r
In-Reply-To: <20240209-jaguar-v2-5-6c9ffe09b924@theobroma-systems.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-5-6c9ffe09b924@theobroma-systems.com>
Message-ID: <36d64ebb2c3d5e37212689704de68fe7@manjaro.org>
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

On 2024-02-09 10:50, Quentin Schulz wrote:
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
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Looking good to me.  Thank you for including the changes suggested
in my earlier review.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

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
