Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD02C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 17:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 086C087E7C;
	Fri,  9 Feb 2024 18:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="hNwWvkxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C2987E71; Fri,  9 Feb 2024 18:56:19 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E054787E7C
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 18:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707501377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wi3SqbQ6ELfjMj53LYDhItf8QDMe4Uu2Zebg0TgYEBk=;
 b=hNwWvkxqd5I5qY/98CCFXYIO8/L10jVGH2RiJJ8nXu8xUtlVbx+Rr337268m438m7MmFN/
 qnGzU7NDUXx1NfUAzeur8AJVfyz5FADefcm9Vwkc9cjX6Kc7IDTHMAH0lFfbiODhAEbvn1
 /LNOWGmxlxX7d5zRrsKFyOaNViF+HZGmHdG/zx1AEUFC5C0blDxLPavbXP9PS0B7Zr1jZW
 wnm2paQElzNx/l/KjHSXuTnwsDKdZdA1LunBjJRtYfKNlxxM85cGh30kxBHSNA0nKCw3WE
 XNz8KhZJOVCy4UiOJemybPogIRCEarBJK9qiJKVu6tw8o9xUMh/RFkTmOd3GQw==
Date: Fri, 09 Feb 2024 18:56:17 +0100
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
Subject: Re: [PATCH v2 06/20] rockchip: pine64: rockpro64: migrate to
 rockchip_early_misc_init_r
In-Reply-To: <20240209-jaguar-v2-6-6c9ffe09b924@theobroma-systems.com>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-6-6c9ffe09b924@theobroma-systems.com>
Message-ID: <051ed506628b2d893d154da0c215f4d6@manjaro.org>
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
> Only setup_iodomain() differs from the original misc_init_r from
> Rockchip mach code, so let's use rockchip_early_misc_init_r instead of
> reimplementing the whole misc_init_r from Rockchip.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  board/pine64/rockpro64_rk3399/rockpro64-rk3399.c | 20 
> ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> index d79084614f1..d0a694ead1d 100644
> --- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> +++ b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> @@ -11,7 +11,6 @@
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/grf_rk3399.h>
>  #include <asm/arch-rockchip/hardware.h>
> -#include <asm/arch-rockchip/misc.h>
> 
>  #define GRF_IO_VSEL_BT565_SHIFT 0
>  #define PMUGRF_CON0_VSEL_SHIFT 8
> @@ -31,26 +30,11 @@ static void setup_iodomain(void)
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
> -
> -	ret = rockchip_setup_macaddr();
> -
> -	return ret;
> +	return 0;
>  }
> 
>  #endif
