Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B76AC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 21:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B3EC88288;
	Fri, 31 May 2024 23:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="sgrCpeDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76745882BE; Fri, 31 May 2024 23:45:42 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD4788246
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 23:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717191940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/KWdJaN/F5eZcMWT9P1EZSdIskGNdNcBdlzkQ1Zm5SA=;
 b=sgrCpeDqzCvBxGfYsJ3eNc+bOrtICJt+oM9WMb8Ct6Q0iKwGG14se8UhVHo7K2GMrxFyaf
 kf+k2ZClHlzBrip3CSTViD41lW98K7I9lbHF8XwMPKRNhs+OwF6jDdfVYneIobUVZVo/f8
 uFE6JBnhzyYQjP5elMYYJD2bKJws6znHWiqGegB1YUWIiDnI4O087/oC3/dpWDlfnejzGR
 +EYPeqXBjeOV6dKMLEoo99DOR7sG5sdk8/IszQ2U4+mP1GH7qd7qiJSy/hYQFJ6HKDR5Pg
 h6se1I8imHrkORNNsDZAjOfqMmkyoG6yNpLrpK2GReS2vjRFAdWT5s1UlACTCQ==
Date: Fri, 31 May 2024 23:45:39 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Kever
 Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, Jonas
 Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>, Anand
 Moon <anand@edgeble.ai>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC v2 08/23] rockchip: RK3588: Read the reset cause from
 clock reset unit for RK3588 SoC
In-Reply-To: <20240531141837.13189-9-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-9-linux.amoon@gmail.com>
Message-ID: <8ed96b96e17cd12eca50d323ccb44cf1@manjaro.org>
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
> Read the reset cause from clock reset unit for RK3588 SoC.
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
> index a1499e9652..19bd2b405b 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru.h
> @@ -19,6 +19,8 @@
>  # include <asm/arch-rockchip/cru_rk3399.h>
>  #elif defined(CONFIG_ROCKCHIP_RK3568)
>  #include <asm/arch-rockchip/cru_rk3568.h>

Although not related to this patch directly, single space character
should be added between "#" and "include", for consistency.

> +#elif defined(CONFIG_ROCKCHIP_RK3588)
> +#include <asm/arch-rockchip/cru_rk3588.h>

The same comment as above, bit this time related to this patch.

>  #endif
> 
>  /* CRU_GLB_RST_ST */
> diff --git a/arch/arm/mach-rockchip/cpu-info.c
> b/arch/arm/mach-rockchip/cpu-info.c
> index e12f84a1d2..113a03acdf 100644
> --- a/arch/arm/mach-rockchip/cpu-info.c
> +++ b/arch/arm/mach-rockchip/cpu-info.c
> @@ -20,6 +20,8 @@ char *get_reset_cause(void)
>  	struct rockchip_cru *cru = rockchip_get_cru();
>  #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3568)
>  	struct rk3568_cru *cru = rockchip_get_cru();
> +#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3588)
> +	struct rk3588_cru *cru = rockchip_get_cru();
>  #endif
>  	char *cause = NULL;
