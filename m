Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B64C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 13:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B437B87DFA;
	Sat, 17 Feb 2024 14:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="CbesQkxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD1087E0F; Sat, 17 Feb 2024 14:14:05 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9738087C80
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 14:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 62ee75b2-cd96-11ee-99a2-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 62ee75b2-cd96-11ee-99a2-005056999439;
 Sat, 17 Feb 2024 14:13:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=3FyjYQI18JJFFK3n7UwZnnLp/CxwOpR/HRmJV0J3I1A=;
 b=CbesQkxdAHtLIlx+Ox7D6NzABSRjgPMYTsYoNyweJEpXUZj+g26+hrJ8tqe6t1A/o2W+UZEu3eagg
 ftrSKmhp0AkzIwf6w7prg1Q6Y9QQTTv9H+8zOsQH4YdopI/+e4KUkSk6wj1BxLkvGuS3ECUb3XUHyb
 MfQLummj7pb141DWfXHo4zzvO+gQAssc8aSL79s9bSUgbMNW4HUiENvS2DrdprRd2zQjnSPygwm7eC
 Dh8jlcMWzKryx88nGU3cstC+9TZAH4Zfnbr01MpRz23U3Z7e2C4MoeYoIVE+Wpb7S7aofa/vsXO3do
 CAtN5jjNgIq8fu1LT0J/97o/o+maFzw==
X-KPN-MID: 33|B4JHUWU5GGJRpsnpEA4cyYmEMthMXlBQwJxU1UZGOmcJrwu3Hs21YR8BFXj0JXc
 xEQpVGn0b+ErG6TfvKJAssq6L4gbi7wxJWLWuVotA4Xg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|DD5z/Rx0cIXb7S2EKzmwusaOxzoeCmzpGt/mgP+SxPKwhiwljPoIa7yWBQswgFs
 e5HWxQXK6v+17R6dcBcoNcw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 68550aba-cd96-11ee-9b17-005056998788;
 Sat, 17 Feb 2024 14:13:58 +0100 (CET)
Date: Sat, 17 Feb 2024 14:13:57 +0100
Message-Id: <87ttm7mdwq.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: kever.yang@rock-chips.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, trini@konsulko.com,
 jagan@amarulasolutions.com, u-boot@lists.denx.de, jonas@kwiboo.se
In-Reply-To: <20240217123406.2461548-1-jonas@kwiboo.se> (message from Jonas
 Karlman on Sat, 17 Feb 2024 12:34:04 +0000)
Subject: Re: [PATCH v4] rockchip: spl: Enable caches to speed up checksum
 validation
References: <20240217123406.2461548-1-jonas@kwiboo.se>
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

> From: Jonas Karlman <jonas@kwiboo.se>
> Date: Sat, 17 Feb 2024 12:34:04 +0000
> 
> FIT checksum validation is very slow in SPL due to D-cache not being
> enabled.
> 
> Enable caches in SPL on ARM64 SoCs to speed up FIT checksum validation,
> from seconds to milliseconds.
> 
> This change enables caches in SPL on all Rockchip ARM64 boards, the
> Kconfig options SPL_SYS_ICACHE_OFF and SPL_SYS_DCACHE_OFF can be used to
> disable caches for a specific board or SoC if needed.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> Changes in v4:
> - Include cpu_func.h to fix build on armv7
> - Remove common.h include
> 
> Changes in v3:
> - Limit to ARM64 SoCs
> - Fix build with SPL_SYS_ICACHE_OFF or SPL_SYS_DCACHE_OFF enabled
> - Use cleanup_before_linux() in spl_board_prepare_for_boot() to disable
>   caches before jumping from SPL to next stage
> - Collect r-b tag
> 
> Changes in v2:
> - None
> 
> This has been tested on multiple RK3328, RK3399, RK356x and RK3588
> boards without any issues, vendor U-Boot also enables caches in SPL for
> all SoCs.
> 
> This only worked on RK3288 because the default enable_caches() that does
> not enable caches was being used. Trying to enable caches on my RK3288
> froze my boards in mmu_setup(). So v3 limits the enable_caches() call to
> only include ARM64 SoCs.

FYI, enabling caches on 32-bit ARM SoCs is generally problematic
because of the presence of non-architected caches.  This poses a
problem for an OS since it can't easily do cache-management in early
boot code before SoC specific drivers attach.

So I agree that this is the right choice.

> Link to RFC: https://patchwork.ozlabs.org/patch/1802303/
> Link to v2: https://patchwork.ozlabs.org/patch/1889319/
> Link to v3: https://patchwork.ozlabs.org/patch/1891025/
> ---
>  arch/arm/mach-rockchip/spl.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index 87280e2ba7cc..1586a093fc37 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -3,7 +3,7 @@
>   * (C) Copyright 2019 Rockchip Electronics Co., Ltd
>   */
>  
> -#include <common.h>
> +#include <cpu_func.h>
>  #include <debug_uart.h>
>  #include <dm.h>
>  #include <hang.h>
> @@ -136,6 +136,20 @@ void board_init_f(ulong dummy)
>  	}
>  	gd->ram_top = gd->ram_base + get_effective_memsize();
>  	gd->ram_top = board_get_usable_ram_top(gd->ram_size);
> +
> +	if (IS_ENABLED(CONFIG_ARM64) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
> +		gd->relocaddr = gd->ram_top;
> +		arch_reserve_mmu();
> +		enable_caches();
> +	}
>  #endif
>  	preloader_console_init();
>  }
> +
> +void spl_board_prepare_for_boot(void)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64) || CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
> +		return;
> +
> +	cleanup_before_linux();
> +}
> -- 
> 2.43.0
> 
> 
