Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66665C54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 06:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C682487EA8;
	Tue, 26 Mar 2024 07:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c1KK6JPz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E7B87F9F; Tue, 26 Mar 2024 07:34:42 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21CF78272A
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 07:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-47679ac2798so1343817137.2
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 23:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711434879; x=1712039679; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KlMDFQd7hEyFPHEXVrOaJMLcvxPrBmWO7/IxI32LQzY=;
 b=c1KK6JPzD9gr7KN7V7GzhLauP1qOAzsmjTSlErn2EuAzcPKBqKhmFgpfnwDtHXNDct
 0nRb5rIl2vG8r5/PpLTRbCCSUt7e8X/RX2AhjcM2nV+2CH2ckjGuV39bGkeGqLBFpsbs
 Djtt22ZRKu+lnlZvAQHIy0Ik2q6amvZJ1nXbIGTjhJa1ppMHmqDiewwHCiHyrSWYFdBo
 JqTqPzckHa73som+rVDZ0R712EmjLFO9aWbphe0OoIX+Y6B3ZovjkMJKa+GKlKDpAF4U
 udUvtaEZ6gA5nYZAmNyv9IPxIPfekBazMWSkIaauTqE43D+T/goE6UKsy/opY6UxVOWT
 ozvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711434879; x=1712039679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlMDFQd7hEyFPHEXVrOaJMLcvxPrBmWO7/IxI32LQzY=;
 b=j1LjxYjRkagYWxRU6lDef4j/JslBj4K/Ie4Tz0/jrh+75D0eKLBruBLrCkXqeG8+L3
 xbQsiB1wRqmqnbZJ12F1GoqIcR2sg/80NIsjclxod97Natz02YQA/YbuXu39rAJk/Vdv
 Twoi/J3KwG7av9x2cfLvM2QzTUoJ7toQ5CB7KY7LYGHCF2875rI/NEeHtVay1ghmyKmj
 LadPOfL9gUIxaH4JQ+s67+/0Ve9gpo/Gw0gdMUqvrQrvSqdutJes/JerMEHhPSnujtKr
 QUXHVwJx4aQvingIZZgsIUSnYmmyv5kHFjLFCDQFWT6g3MJBYaiFhggc1O2r2WDmMVS7
 +VZw==
X-Gm-Message-State: AOJu0YxXEvjb8D8kaufcFEzp0YwUPrkYdfdpOeJ0w30KzSXcAhRbTooJ
 JLfYn5j1TjWJW8Hm0wcQDEHQn8gdV7m7s1b7pZm791gcIcx8eC3y/9IJqBpiAINbX/jt68s3EHE
 CBX+lSbmwmSQsv0Fzh/NH5RcoGwxWkKm5u8bf+w==
X-Google-Smtp-Source: AGHT+IGTXBFLIfdXA5Imv0EbMaVguDkH3vq1wKvF6jZFeJ+SlAG7nKsMKByxZ2MvQrgcrbbZrhTUjV3cOyQ54EEPqnw=
X-Received: by 2002:a67:cf09:0:b0:476:9fde:7886 with SMTP id
 y9-20020a67cf09000000b004769fde7886mr5621257vsl.18.1711434878837; Mon, 25 Mar
 2024 23:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240325081834.5519-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240325081834.5519-1-marek.vasut+renesas@mailbox.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Mar 2024 12:04:27 +0530
Message-ID: <CAFA6WYPA_rDTBOeODEGwMgBJ32OiOOu2EJTSDS1G-Uo0_uL44Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: renesas: Switch to using upstream DT
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 25 Mar 2024 at 13:48, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Enable OF_UPSTREAM to use upstream DT and add renesas/ prefix to the
> DEFAULT_DEVICE_TREE and OF_LIST. And thereby directly build DTB from
> dts/upstream/src/ including *-u-boot.dtsi files from arch/$(ARCH)/dts/
> directory.
>
> The configuration update has been done using the following script:
> ```
> sed -i '/^CONFIG_DEFAULT_DEVICE_TREE/ s@="@&renesas/@' `git grep -li renesas configs`
> sed -i '/^CONFIG_OF_LIST/ s@r8a@renesas/&@g' `git grep -li renesas configs`
> ```
>
> The RZN1 Snarc board does not seem to have a matching Linux kernel
> DT counterpart, this is currently not switched to OF upstream.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/Kconfig             | 1 +
>  configs/alt_defconfig        | 2 +-
>  configs/blanche_defconfig    | 2 +-
>  configs/gose_defconfig       | 2 +-
>  configs/grpeach_defconfig    | 2 +-
>  configs/koelsch_defconfig    | 2 +-
>  configs/lager_defconfig      | 2 +-
>  configs/porter_defconfig     | 2 +-
>  configs/rzn1_snarc_defconfig | 1 +
>  configs/silk_defconfig       | 2 +-
>  configs/stout_defconfig      | 2 +-
>  11 files changed, 11 insertions(+), 9 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a0842e19330..ab8f30f1142 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1068,6 +1068,7 @@ config ARCH_RENESAS
>         imply BOARD_EARLY_INIT_F
>         imply CMD_DM
>         imply FAT_WRITE
> +       imply OF_UPSTREAM
>         imply SYS_THUMB_BUILD
>         imply ARCH_MISC_INIT if DISPLAY_CPUINFO
>
> diff --git a/configs/alt_defconfig b/configs/alt_defconfig
> index 06e9e11f297..c9ca22cbe8f 100644
> --- a/configs/alt_defconfig
> +++ b/configs/alt_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0xC0000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a7794-alt"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7794-alt"
>  CONFIG_SPL_TEXT_BASE=0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING="Alt"
>  CONFIG_R8A7794=y
> diff --git a/configs/blanche_defconfig b/configs/blanche_defconfig
> index c392055e5a7..a2823a614a5 100644
> --- a/configs/blanche_defconfig
> +++ b/configs/blanche_defconfig
> @@ -12,7 +12,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0x40000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a7792-blanche"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7792-blanche"
>  CONFIG_ARCH_RENESAS_BOARD_STRING="Blanche"
>  CONFIG_R8A7792=y
>  CONFIG_TARGET_BLANCHE=y
> diff --git a/configs/gose_defconfig b/configs/gose_defconfig
> index 35edc677c48..0f76ae147ef 100644
> --- a/configs/gose_defconfig
> +++ b/configs/gose_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0xC0000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a7793-gose"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7793-gose"
>  CONFIG_SPL_TEXT_BASE=0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING="Gose"
>  CONFIG_R8A7793=y
> diff --git a/configs/grpeach_defconfig b/configs/grpeach_defconfig
> index 0c581b634a2..70a80088bfb 100644
> --- a/configs/grpeach_defconfig
> +++ b/configs/grpeach_defconfig
> @@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x10000
>  CONFIG_ENV_OFFSET=0x80000
>  CONFIG_ENV_SECT_SIZE=0x10000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r7s72100-gr-peach"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s72100-gr-peach"
>  CONFIG_RZA1=y
>  CONFIG_OF_LIBFDT_OVERLAY=y
>  CONFIG_SYS_MONITOR_LEN=524288
> diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
> index ad411b45141..a912e58cf4d 100644
> --- a/configs/koelsch_defconfig
> +++ b/configs/koelsch_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0xC0000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a7791-koelsch"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7791-koelsch"
>  CONFIG_SPL_TEXT_BASE=0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING="Koelsch"
>  CONFIG_R8A7791=y
> diff --git a/configs/lager_defconfig b/configs/lager_defconfig
> index f60d4db5ec2..03f29b8849b 100644
> --- a/configs/lager_defconfig
> +++ b/configs/lager_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0xC0000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a7790-lager"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7790-lager"
>  CONFIG_SPL_TEXT_BASE=0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING="Lager"
>  CONFIG_R8A7790=y
> diff --git a/configs/porter_defconfig b/configs/porter_defconfig
> index f05a0baf215..170ca3a5f43 100644
> --- a/configs/porter_defconfig
> +++ b/configs/porter_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0xC0000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a7791-porter"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7791-porter"
>  CONFIG_SPL_TEXT_BASE=0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING="Porter"
>  CONFIG_R8A7791=y
> diff --git a/configs/rzn1_snarc_defconfig b/configs/rzn1_snarc_defconfig
> index 29a96d1aefe..1c313d2d4da 100644
> --- a/configs/rzn1_snarc_defconfig
> +++ b/configs/rzn1_snarc_defconfig
> @@ -21,3 +21,4 @@ CONFIG_CADENCE_DDR_CTRL=y
>  CONFIG_SYS_NS16550=y
>  CONFIG_SYS_NS16550_MEM32=y
>  # CONFIG_EFI_LOADER is not set
> +# CONFIG_OF_UPSTREAM is not set
> diff --git a/configs/silk_defconfig b/configs/silk_defconfig
> index 40ac8759d08..2e4fab8ac54 100644
> --- a/configs/silk_defconfig
> +++ b/configs/silk_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0xC0000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a7794-silk"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7794-silk"
>  CONFIG_SPL_TEXT_BASE=0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING="Silk"
>  CONFIG_R8A7794=y
> diff --git a/configs/stout_defconfig b/configs/stout_defconfig
> index 428a0241986..ee87ea53d6e 100644
> --- a/configs/stout_defconfig
> +++ b/configs/stout_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0xC0000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a7790-stout"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a7790-stout"
>  CONFIG_SPL_TEXT_BASE=0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING="Stout"
>  CONFIG_R8A7790=y
> --
> 2.43.0
>
