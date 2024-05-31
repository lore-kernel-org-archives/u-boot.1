Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E54C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 21:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D20887CB;
	Fri, 31 May 2024 23:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="f2tQKPve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D907887CB; Fri, 31 May 2024 23:51:07 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3318A882CD
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 23:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717192264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s75w0JmCIuLDVSWrMnovT3jMw5J+U7gPtyCXKZf3IfA=;
 b=f2tQKPveU1YQuBShVVw5fMcEbrWtAe3vDt77/OjNrvtIEp+k+ffe252tLWdvHvhbNzEFeo
 pjBLS8G+fDt+wYK7ZFHoFqQa6k1aNy/D7kDfrWDvNVvCCZPXG/ZO+a0BLGoV3O5bOL5vRt
 SM5fZgmsFLycz7Sg00fJyKNOzJHeU+t2ZNNZL61GGFikHMPIgr6JUNlg3403Rgsn32rRuP
 odvaigLlBwrIQQnjSlLaGvHVqeWfVzsyEgJ+B3s93XSG6SbaY9zHsIFmoT7/CSPxPVpQPo
 tyrdRFx9lMlgCNtIGV2aCAZBphMCIGzBq/vh41mPyWFqFHbHoxag+yIDLKQJ4w==
Date: Fri, 31 May 2024 23:51:04 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Kever
 Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, Jonas
 Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>, Anand
 Moon <anand@edgeble.ai>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC v2 16/23] rockchip: RK3368: Read the reset cause from
 clock reset unit for RK3368 SoC
In-Reply-To: <20240531141837.13189-17-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-17-linux.amoon@gmail.com>
Message-ID: <71e97b3fe6dfdb4e6a861992d6de0833@manjaro.org>
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

Hello Anand,

On 2024-05-31 16:18, Anand Moon wrote:
> From: Anand Moon <anand@edgeble.ai>
> 
> Read the reset cause from clock reset unit for RK3368 SoC.
> 
> Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
>  arch/arm/mach-rockchip/cpu-info.c        | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru.h
> b/arch/arm/include/asm/arch-rockchip/cru.h
> index 6fe73ad0cc..9cdd960fb1 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru.h
> @@ -25,6 +25,8 @@
>  #include <asm/arch-rockchip/cru_px30.h>

Although not related to this patch directly, a single space character
should be added between "#" and "include", for consistency.

>  #elif defined(CONFIG_ROCKCHIP_RK3308)
>  #include <asm/arch-rockchip/cru_rk3308.h>

The same comment as above.

> +#elif defined(CONFIG_ROCKCHIP_RK3368)
> +#include <asm/arch-rockchip/cru_rk3368.h>

The same comment as above, bit this time related to this patch.

>  #endif
> 
>  /* CRU_GLB_RST_ST */
> diff --git a/arch/arm/mach-rockchip/cpu-info.c
> b/arch/arm/mach-rockchip/cpu-info.c
> index dbc126c862..b9d2756a70 100644
> --- a/arch/arm/mach-rockchip/cpu-info.c
> +++ b/arch/arm/mach-rockchip/cpu-info.c
> @@ -28,6 +28,8 @@ char *get_reset_cause(void)
>  	struct rockchip_cru *cru = rockchip_get_cru();
>  #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3308)
>  	struct rk3308_cru *cru = rockchip_get_cru();
> +#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3368)
> +	struct rk3368_cru *cru = rockchip_get_cru();
>  #endif
>  	char *cause = NULL;
