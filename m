Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0BECD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 07:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F88288089;
	Fri,  5 Apr 2024 09:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oXGghtsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A94688089; Fri,  5 Apr 2024 09:33:35 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B9087E2C
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 09:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d4886a1cb4so23671361fa.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712302412; x=1712907212;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+fZFJVOFXpiZXRfLSdKBxclf2cHFIvhnjDj5FKsaL04=;
 b=oXGghtsIpWQnugyvtYg0iKXeavrXDcVFdzqBrKzne1wpcy05wxi9LyOvjbzaTG+FZs
 HU1FAdrg3Orhiso7DyxoRV17PAyKetHMCXBMHJp0tGy7LkXHcUU5qPUOXqGWsBcMZGcW
 ZDJWpfScHqdvPFvsgBDLg5R7Bj/nQmYgGDxFH8AgFJyDwZzGIslO/jlpyxlPlzH2FABw
 0Rkic1MOQIDJjuUUe9WvuRouOQweIdKNt53KY+oXXrraDuoZYLBCD2xYlJXVsC4q7b2c
 f3Puvpaxs8FMvjsjYXJZa2lIXxcqh6/quWC+yYAOURmMhbuieMg8aSjCPJgHrwHin6Q0
 ge8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712302412; x=1712907212;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+fZFJVOFXpiZXRfLSdKBxclf2cHFIvhnjDj5FKsaL04=;
 b=J0LTgpugOcVikRQDexRivlGqphWKuCZrACMpNDrKjCXbPtEEUxtKLBuZ4EKNTwljL8
 laMOrjbi1YMeIevZ/JzYPNCNL25SCR1HrY4J1BAWvUeeJawZlfoVvpDUhZcSdP10sRSZ
 uecaw1dKhNivM350KtEFg/iQ3TyVVs+mZ43GOxxb0MxLI5B/3b68jMRpTB9wK0PhUKij
 iYEe/zh/aE7l1K8fiv/64FbAt10cWqhZL329GbKyaTy9EmKR/Cy4CqHTL8Urj47rxmeY
 u3ch7XKOSZAPVb3kCP2wCo8tARahc4SVoehCTHL8RXzllUnSwGhdyGYPdCdnQPlLHBjD
 itmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCLiofxNSzf2+qJ13HZlcbkEdUGUnG0KRRX14v3ej+n9lDEpjBesDSYTw1FSYMhCgu4MD+yD0DjM2iuPhHAnyAixGDrQ==
X-Gm-Message-State: AOJu0YwpQS0kNyfRPoBuH0TPulB5xABk7+3gatOVyQ3CAT5KfoaoFOC/
 mZh3KItw/Yqn/TWmIvpgKCKclvVA/fq6rwOPBLowFa8bNbFblit4dkUK3a8p21c=
X-Google-Smtp-Source: AGHT+IEBQqlyy3F8Ar27N5PJ+3p47L2PAS8POO6tF55z286VaQF2ELef8YYVEkFY2ZYYO5lW55U1LA==
X-Received: by 2002:a2e:a408:0:b0:2d8:3e52:66bb with SMTP id
 p8-20020a2ea408000000b002d83e5266bbmr514924ljn.42.1712302412328; 
 Fri, 05 Apr 2024 00:33:32 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 m17-20020adfa3d1000000b0034355b7e995sm1348391wrb.13.2024.04.05.00.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 00:33:31 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitrii Merkurev <dimorinny@google.com>, u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Ying-Chun Liu <paul.liu@linaro.org>
Subject: Re: [PATCH 2/4] fastboot: blk: add block device flashing configuration
In-Reply-To: <20240306185921.1854109-2-dimorinny@google.com>
References: <20240306185921.1854109-1-dimorinny@google.com>
 <20240306185921.1854109-2-dimorinny@google.com>
Date: Fri, 05 Apr 2024 09:33:31 +0200
Message-ID: <87ttkgfelw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitrii,

Thank you for the patch and sorry for the review delay.

On mer., mars 06, 2024 at 18:59, Dmitrii Merkurev <dimorinny@google.com> wrote:

> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> ---
>  drivers/fastboot/Kconfig | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 5e5855a76c..460c5e98d7 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -87,7 +87,7 @@ config FASTBOOT_USB_DEV
>  config FASTBOOT_FLASH
>  	bool "Enable FASTBOOT FLASH command"
>  	default y if ARCH_SUNXI || ARCH_ROCKCHIP
> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
>  	select IMAGE_SPARSE
>  	help
>  	  The fastboot protocol includes a "flash" command for writing
> @@ -109,12 +109,16 @@ choice
>  
>  config FASTBOOT_FLASH_MMC
>  	bool "FASTBOOT on MMC"
> -	depends on MMC
> +	depends on MMC && BLK
>  
>  config FASTBOOT_FLASH_NAND
>  	bool "FASTBOOT on NAND"
>  	depends on MTD_RAW_NAND && CMD_MTDPARTS
>  
> +config FASTBOOT_FLASH_BLOCK
> +	bool "FASTBOOT on block device"
> +	depends on BLK
> +

If we just apply this patch, then this KConfig option is unused. Can we
please squash this into patch 3/4?

>  endchoice
>  
>  config FASTBOOT_FLASH_MMC_DEV
> @@ -189,6 +193,18 @@ config FASTBOOT_MMC_USER_NAME
>  	  defined here.
>  	  The default target name for erasing EMMC_USER is "mmc0".
>  
> +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
> +	string "Define FASTBOOT block interface name"
> +	depends on FASTBOOT_FLASH_BLOCK
> +	help
> +	  "Fastboot block interface name (mmc, virtio, etc)"

There is a finite list of supported options for this. Can we please
document all of them so that users know what is valid and what not?
If so, we can drop the "etc" part in the help string.

> +
> +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
> +	int "Define FASTBOOT block device id"
> +	depends on FASTBOOT_FLASH_BLOCK
> +	help
> +	  "Fastboot block device id"

When FASTBOOT_FLASH_BLOCK=="mmc", how is FASTBOOT_FLASH_BLOCK_DEVICE_ID
different from FASTBOOT_FLASH_MMC_DEV?

If they are similar, are we sure this symbol really needed?

> +
>  config FASTBOOT_GPT_NAME
>  	string "Target name for updating GPT"
>  	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
> -- 
> 2.44.0.278.ge034bb2e1d-goog
