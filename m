Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974E8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 08:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE770886CA;
	Fri, 19 Apr 2024 10:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="qlrxiviJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9992788699; Fri, 19 Apr 2024 10:16:12 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D0988445
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 10:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: e0575e9f-fe24-11ee-99a6-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e0575e9f-fe24-11ee-99a6-005056999439;
 Fri, 19 Apr 2024 10:14:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=pplZ9RErv6AW/ydgJmm94w6lc6ntPvrVee4n6RngUp4=;
 b=qlrxiviJIiypniLhPGyWeD7Qw+fCnp3ZtLPpf1+gUMGxOLZ5qj5b/sJlDou2y1CmusoJyePFozeV/
 prMeGSeZm+cZ1hNreNrMoz2qD7FQLUByOBtsLDJCSxumgzV09ciJ1wLU/fbZahb+uJegINHFvrw94g
 4Fk8tuKioQJb4nWxsW0yzWBCM0FzuL2boSHuKOvgDA51PhXJ6cOKZrWXmDN93N83zE6QZn2swa+B19
 ypamPSUSq5xaVGKd010gQiVvlRCE4SCDWSk/S3xouxwSi5l/o+TdvFnOUWjtHSPPQ1RMYllaDsUO8r
 iyN30MESuZQ7q0bQ+vxOtrFSHBJhocQ==
X-KPN-MID: 33|xeV+d9U+pJlCagBcalF3fXCl8t3PcnOKTW1z9e/wdIC8JDSZ2hOpSk5BVqC/hAB
 JgDH6AeFyFP1oBBb3RxRFYXkELwlmtiPnc2OfGgIsd9w=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|dcLmLr4bjHVr6brwIRQ+TonRSTZPutMt7gQzZqntbO1YrOFv6kFugXk8Q0UsaGY
 9E/tVPLxOdX++EkRoHptrag==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 1396ea6e-fe25-11ee-9506-00505699b758;
 Fri, 19 Apr 2024 10:16:09 +0200 (CEST)
Date: Fri, 19 Apr 2024 10:16:09 +0200
Message-Id: <87r0f1g43a.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: j@jannau.net
Cc: kettenis@openbsd.org, trini@konsulko.com, sjg@chromium.org,
 u-boot@lists.denx.de, asahi@lists.linux.dev, j@jannau.net
In-Reply-To: <20240418-apple_config-v2-4-7e5c6b9a9db3@jannau.net> (message
 from Janne Grunau via B4 Relay on Thu, 18 Apr 2024 21:00:28 +0200)
Subject: Re: [PATCH v2 4/5] arm: apple: Switch to standard boot
References: <20240418-apple_config-v2-0-7e5c6b9a9db3@jannau.net>
 <20240418-apple_config-v2-4-7e5c6b9a9db3@jannau.net>
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

> From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
> Date: Thu, 18 Apr 2024 21:00:28 +0200
> 
> From: Janne Grunau <j@jannau.net>
> 
> Use standard boot instead of the distro boot scripts. Use
> BOOTSTD_FULL instead of BOOTSTD_DEFAULTS for easier interactive use.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  arch/arm/Kconfig        |  2 +-
>  include/configs/apple.h | 20 ++------------------
>  2 files changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 01d6556c42..9b83b2e6f8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1034,7 +1034,7 @@ config ARCH_APPLE
>  	select USB
>  	imply CMD_DM
>  	imply CMD_GPT
> -	imply DISTRO_DEFAULTS
> +	imply BOOTSTD_FULL
>  	imply OF_HAS_PRIOR_STAGE
>  
>  config ARCH_OWL
> diff --git a/include/configs/apple.h b/include/configs/apple.h
> index a70440b3ad..1e08b11448 100644
> --- a/include/configs/apple.h
> +++ b/include/configs/apple.h
> @@ -9,26 +9,10 @@
>  	"stdout=vidconsole,serial\0" \
>  	"stderr=vidconsole,serial\0"
>  
> -#if IS_ENABLED(CONFIG_CMD_NVME)
> -	#define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)
> -#else
> -	#define BOOT_TARGET_NVME(func)
> -#endif
> -
> -#if IS_ENABLED(CONFIG_CMD_USB)
> -	#define BOOT_TARGET_USB(func) func(USB, usb, 0)
> -#else
> -	#define BOOT_TARGET_USB(func)
> -#endif
> -
> -#define BOOT_TARGET_DEVICES(func) \
> -	BOOT_TARGET_NVME(func) \
> -	BOOT_TARGET_USB(func)
> -
> -#include <config_distro_bootcmd.h>
> +#define BOOT_TARGETS	"nvme usb"
>  
>  #define CFG_EXTRA_ENV_SETTINGS \
>  	ENV_DEVICE_SETTINGS \
> -	BOOTENV
> +	"boot_targets=" BOOT_TARGETS "\0"
>  
>  #endif
> 
> -- 
> 2.44.0
> 
> 
> 
> 
