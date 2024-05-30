Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4612AC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 09:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31567886C9;
	Thu, 30 May 2024 11:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NRgGkete";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9C5886D4; Thu, 30 May 2024 11:30:08 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B4488684
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 11:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetbo@gmail.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-48a39be0e32so213094137.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717061405; x=1717666205; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yNpGS7wyrWlJ6Mp7tFARpFkPflX+3ZES+9CF3nNbYGc=;
 b=NRgGketeJj7jxdllhe228UOJ3Rpssa+g3HXc/urJ2Tzyj8aaBhXTLa1R4J73mZxeko
 EEnCEaoeBKhG+bTD4K0M06D5mesuFLzC6Fj7rc/NZkDaWatwDn5RWtucB6+BzP9l9WI9
 t/3e1r6e+MRJRUnRvDP9o+OZi1Shon1G5XnMzZP/JCxahDh0FBxTyDthch8m3A49aJFg
 skwSLh84FmLb3QN1uuiF/qUbx2vcBKKeCvalYunzkmTG+l1vA7YBGxo5OtZIni/55UnF
 7+LCdixvYlPMSxYf4SRS9Uho4ubdIRgO+BitEkZY4/ToxfDzhPgdfFz7yjlke/GuRXYU
 rcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717061405; x=1717666205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yNpGS7wyrWlJ6Mp7tFARpFkPflX+3ZES+9CF3nNbYGc=;
 b=PGRmAATGz7YKsNgYvM9CV2OGJMKuN6aP+YGco3CgVpJeB2HSPTLlB++lmROyUZaFd/
 ZnRQl0UnEJ9eF9cY+KxT7ImZLHz2JTihh8QHRgNEdcHXh3rFgMWK5j4BBYE+TCH+aEM+
 9SeFXiHhXTzvjHNq6/aHGtyFJQ00NRkBHemoxWCuF/t3Q+BchOgrO5Z7L0hUhr/EupjI
 NB0pnKvA4qhQBIMZDdQpaKiyGOUglSDjzD74vrSrC71XxMicUiAXi82XtmG9fikl7HWm
 7oiCUCObttq+sD63qq2YU2tojHwTnsPoKfMrCSXUa4R7V/UKx6CtpN4zaFA57Hclzor8
 zYYQ==
X-Gm-Message-State: AOJu0Yz3W7dj/8tHTNwzerSazTr4NLMipdm3Nn8i5YM5L81zNv06yQ43
 lVARmoUrWZpJNPipyw6fWkg9E0+fM+AcAlFglpQN97WUXBdbUYI0Mv9hwyYZtRacyiF+GvE5L/t
 +Bay3LLfy40wrvmBcbwXEtLDEtug=
X-Google-Smtp-Source: AGHT+IF9ThuI/48fKwUy+gy2Y73FxeTAE365g+rK7RW0UItFuIATlrT+im9lOQtXRgFUqakNtGwAS7Y/ZbcxBjaqLC0=
X-Received: by 2002:a05:6102:26c6:b0:48a:3670:e100 with SMTP id
 ada2fe7eead31-48bae9af88amr2208287137.6.1717061405468; Thu, 30 May 2024
 02:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240518130622.219031-1-javier@dowhile0.org>
 <20240518130622.219031-2-javier@dowhile0.org>
In-Reply-To: <20240518130622.219031-2-javier@dowhile0.org>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 30 May 2024 11:29:54 +0200
Message-ID: <CAFqH_52GkC7B=O44P3tqXd5JPn-ztpsb1Wu6v1iLgvT2SV3NeQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/4] omap3: igep00x0: Increase malloc() pool size
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: u-boot@lists.denx.de, Javier Martinez Canillas <javierm@redhat.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Javier,

Many thanks for your patches. They look great


Missatge de Javier Martinez Canillas <javier@dowhile0.org> del dia
ds., 18 de maig 2024 a les 15:06:
>
> From: Javier Martinez Canillas <javierm@redhat.com>
>
> The IGEPv2 board boot started to fail since the commit afd4f15a39de ("spi:
> omap3_spi: Read platform data in ofdata_to_platdata()"). Because this made
> the OMAP3 SPI controller driver to allocate its platform data before doing
> a relocation, but the igep0x00 config sets this pool size to just 1 KiB.
>
> Increase the pre-relocation malloc heap size to 16 KiB, as is set by other
> OMAP3 boards. This not only restores booting but also makes it consistent.
>
> Leave the SPL pool size to the previous 1 KiB size since 16 KiB may not be
> a possible size in that constrained environment and is also the value that
> is set by other OMAP3 boards.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Enric Balletbo i Serra <eballetbo@gmail.com>

> ---
>
>  configs/igep00x0_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
> index 261f71acc1dd..e4d25556e3f3 100644
> --- a/configs/igep00x0_defconfig
> +++ b/configs/igep00x0_defconfig
> @@ -1,6 +1,6 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_OMAP2PLUS=y
> -CONFIG_SYS_MALLOC_F_LEN=0x400
> +CONFIG_SYS_MALLOC_F_LEN=0x4000
>  CONFIG_TI_COMMON_CMD_OPTIONS=y
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> @@ -10,6 +10,7 @@ CONFIG_DEFAULT_DEVICE_TREE="omap3-igep0020"
>  CONFIG_SPL_TEXT_BASE=0x40200000
>  CONFIG_TARGET_OMAP3_IGEP00X0=y
>  CONFIG_SYS_MONITOR_LEN=262144
> +CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
>  CONFIG_SPL=y
>  CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_BOOTDELAY=3
> --
> 2.45.0
>
