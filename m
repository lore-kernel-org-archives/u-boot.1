Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387BCC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 14:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA953879F3;
	Mon, 15 Apr 2024 16:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="a1GptqBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819FD879F3; Mon, 15 Apr 2024 16:24:54 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D8586DEE
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 16:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: bda76bb1-fb33-11ee-99a6-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id bda76bb1-fb33-11ee-99a6-005056999439;
 Mon, 15 Apr 2024 16:23:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=4egGE6y9Zm72AHZF7pctEsdpWMjrDWBhCYt5emihWHc=;
 b=a1GptqBEtdfYzMrWxnbGbmOYpbNnVU7Y2bEX95yKdjFQ70xNHEt2eaK54KfADu5hRey9mMFXYQHxL
 z+E/rwoy7ZXBb1nEaAhF1O6nBqzZoRWN1HCzMGbIM9Fpw0VAb+WFncEnkKN88O2CBbxQcmziHSxMMT
 MtYBfq5CoJiLLFImWbipAEo1fVRhAHw1vJYSrboUIbdiJPtcSehv/MubUkm71PODUz7a1bfE16q01F
 jT2Gv4BYVgeevQrOPHxAx4KOsyLC9xwAW3UOKPBDxHMa/SlVoyj+hoL++8EiaOvlCatvMkugXdQxAw
 OBhaazkWLv6aeefYTmRDpWEInh894dA==
X-KPN-MID: 33|zejDGefllvU3oKWQ20NPC7NZrBbQxGIUiujU+LUosYC/4fjxyW0NpLedv8mBlPb
 TTwAT6u/PRmVLNPSGTN1dOxpSfIdqLsMcpMYz34AKAPg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|63iHYI0bpA36NnccfbFyC83oFnEyUnzrhIBebDeOWomldKGJ+FxBxmYlPVSYpBL
 wn8DU1Kh2Ul0983coapB7Sg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id ebb40341-fb33-11ee-94ef-00505699b758;
 Mon, 15 Apr 2024 16:24:51 +0200 (CEST)
Date: Mon, 15 Apr 2024 16:24:51 +0200
Message-Id: <874jc2hff0.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, sjg@chromium.org,
 u-boot@lists.denx.de, asahi@lists.linux.dev, j@jannau.net
In-Reply-To: <20240317-apple_config-v1-4-1b862bc140a9@jannau.net> (message
 from Janne Grunau via B4 Relay on Sun, 17 Mar 2024 15:54:50 +0100)
Subject: Re: [PATCH 4/4] arm: apple: Switch to standard boot
References: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
 <20240317-apple_config-v1-4-1b862bc140a9@jannau.net>
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
> Date: Sun, 17 Mar 2024 15:54:50 +0100
> 
> From: Janne Grunau <j@jannau.net>
> 
> Use standard boot instead of the distro boot scripts.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

As per a somewhat recent discussion about this for the rockchip SoCs,
I think we want BOOTSTD_FULL instead of BOOTSTD_DEFAULT.  Even though
I think that BOOTSTD_FULL is a bit too chatty at the moment.

That also solves the issue that BOOTSTD_DEFAULTS doesn't run the EFI
bootmgr (which does happen with distroboot).  Although Heinrich has a
diff to fix that.

> ---
>  arch/arm/Kconfig        |  2 +-
>  include/configs/apple.h | 20 ++------------------
>  2 files changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 01d6556c42..ad89abde41 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1034,7 +1034,7 @@ config ARCH_APPLE
>  	select USB
>  	imply CMD_DM
>  	imply CMD_GPT
> -	imply DISTRO_DEFAULTS
> +	imply BOOTSTD_DEFAULTS
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
