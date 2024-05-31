Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FC5C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 21:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C1C88288;
	Fri, 31 May 2024 23:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Bpww8zWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ADE4882BE; Fri, 31 May 2024 23:43:03 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7BC88246
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 23:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717191781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJVQeS5w05QXX1w9x+ypjFZNEYRLjYRTQ7bMpfqCJ6M=;
 b=Bpww8zWVzi2sD5o9OPxBABRV8/NrtjvkBZHvYHzEbsI8WfVM6w6d2N3qaEdKnJxrNOxU0I
 SoRzhtWw+PiWhyGWsc9QwfTA07I3AdG/OlXlM+YaBZYgr2oNhsPE/oMMti775l3cqU4C2v
 FsXtGj+Ye2FMiQ4t0mzdOTZ3Vbm/saZ6ODAp7OOf5iYKZNZEBOkxma+BTLlWiOy/wJCIck
 GVodaiZnbPKSh2RW2URlZ5PmTx7/HDSSd4142bwwJBpO6fgO/s8rLMr9xchnlawZvLuf1q
 tb3Jv926hggsA7c1kMOcSH+dT7JvSgbbyX0Vl2o9X1LIJ2tMqTBqfy2hlFFtnw==
Date: Fri, 31 May 2024 23:43:00 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Kever
 Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, Jonas
 Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>, Anand
 Moon <anand@edgeble.ai>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC v2 01/23] rockchip: RK3328: Read the reset cause from
 clock reset unit for RK3328 SoC
In-Reply-To: <20240531141837.13189-2-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-2-linux.amoon@gmail.com>
Message-ID: <83f05efcf7e3d475e9071194faddf3b6@manjaro.org>
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
> Read the reset cause from clock reset unit for RK3328 SoC.
> 
> Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
>  arch/arm/mach-rockchip/cpu-info.c        | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru.h
> b/arch/arm/include/asm/arch-rockchip/cru.h
> index 9778790f34..a1499e9652 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru.h
> @@ -13,6 +13,8 @@
> 
>  #if defined(CONFIG_ROCKCHIP_RK3288)
>  # include <asm/arch-rockchip/cru_rk3288.h>
> +#elif defined(CONFIG_ROCKCHIP_RK3328)
> +#include <asm/arch-rockchip/cru_rk3328.h>

A single space character should be added between "#" and "include",
for consistency.

>  #elif defined(CONFIG_ROCKCHIP_RK3399)
>  # include <asm/arch-rockchip/cru_rk3399.h>
>  #elif defined(CONFIG_ROCKCHIP_RK3568)
> diff --git a/arch/arm/mach-rockchip/cpu-info.c
> b/arch/arm/mach-rockchip/cpu-info.c
> index a62ff53c6a..86b0c02970 100644
> --- a/arch/arm/mach-rockchip/cpu-info.c
> +++ b/arch/arm/mach-rockchip/cpu-info.c
> @@ -14,7 +14,9 @@
> 
>  char *get_reset_cause(void)
>  {
> -	struct rockchip_cru *cru = rockchip_get_cru();
> +#if IS_ENABLED(CONFIG_ROCKCHIP_RK3328)
> +	struct rk3328_cru *cru = rockchip_get_cru();
> +#endif
>  	char *cause = NULL;
> 
>  	if (IS_ERR(cru))
