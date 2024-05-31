Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF45C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 21:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2A2882CD;
	Fri, 31 May 2024 23:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="MFWWfEWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916F688783; Fri, 31 May 2024 23:49:42 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFB088288
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 23:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717192180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqCxt5PSEwe3URSc2dgQx+8Oki6ZVmWW50lUeVQ7FiY=;
 b=MFWWfEWUVumeUS/dhyfCnz24Cko4+3P5es9zxsyrrQUetBwgCnO7f5I7tGn3k0BL1nfsqY
 k6XcUALkhABNA+TlEX+uJe+MQxvXAOqYD0oI4FrYXYp8Vqw7eQGk909RGpoKAOD9rkRIIV
 ULNUka0LbPbHIHyg4V5Jxf1Tcvzdls1v0JbirjjWCkK3gsQ7zfbt5L1Qpi8HCQpBjM2W7a
 lr3jMO/u+XhcJf1BHAMYOaioyEQ7gp3Tj5xZ8V+wWxPzadr0no1ywTIjZJ5E0Yd1crmjOj
 2HwKHrmvCsbBoA/HUcdosHpZDZ1TlupMKm0Q+ThlmSpEtsKwX3/3aKL8HaTtaA==
Date: Fri, 31 May 2024 23:49:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Kever
 Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, Jonas
 Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>, Anand
 Moon <anand@edgeble.ai>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC v2 14/23] rockchip: RK3308: Read the reset cause from
 clock reset unit for RK3308 SoC
In-Reply-To: <20240531141837.13189-15-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-15-linux.amoon@gmail.com>
Message-ID: <0d8d06a96e77ea1403799ef7a9eeffb3@manjaro.org>
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
> Read the reset cause from clock reset unit for RK3308 SoC.
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
> index 7a69a839e6..6fe73ad0cc 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru.h
> @@ -23,6 +23,8 @@
>  #include <asm/arch-rockchip/cru_rk3588.h>

Although not related to this patch directly, a single space character
should be added between "#" and "include", for consistency.

>  #elif defined(CONFIG_ROCKCHIP_PX30)
>  #include <asm/arch-rockchip/cru_px30.h>

The same comment as above.

> +#elif defined(CONFIG_ROCKCHIP_RK3308)
> +#include <asm/arch-rockchip/cru_rk3308.h>

The same comment as above, bit this time related to this patch.

>  #endif
> 
>  /* CRU_GLB_RST_ST */
> diff --git a/arch/arm/mach-rockchip/cpu-info.c
> b/arch/arm/mach-rockchip/cpu-info.c
> index 383aa3d2ee..dbc126c862 100644
> --- a/arch/arm/mach-rockchip/cpu-info.c
> +++ b/arch/arm/mach-rockchip/cpu-info.c
> @@ -26,6 +26,8 @@ char *get_reset_cause(void)
>  	struct px30_cru *cru = rockchip_get_cru();
>  #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3288)
>  	struct rockchip_cru *cru = rockchip_get_cru();
> +#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3308)
> +	struct rk3308_cru *cru = rockchip_get_cru();
>  #endif
>  	char *cause = NULL;
