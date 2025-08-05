Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85241C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 07:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA3183340;
	Tue,  5 Aug 2025 09:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k1NnI9+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE4DF833D1; Tue,  5 Aug 2025 09:53:18 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F5A8318E
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 09:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-af958127df5so441968866b.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754380396; x=1754985196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TictHvZpsRek9qIa4LDmi3ByH1pwWIL8fRDIN7ICxtg=;
 b=k1NnI9+BXnALv60t/uxsr80nM90Auia8KWQujpOakjVMpFGJuM38cgiFdiw4sgdI4X
 8vyoAffunBmPUqbSrytp5GnRHjHPGfQ/qcWp/HVAjM0zGi4AjmdLCxRjc05gqz2A3xyD
 Znd2M9TmhM7gTpN1GdNLlC/nixfk551+8YZIVY270VE9NB8ZskNOyB/IJZb+OcjPcDy6
 GLBsGYUsYb/7b3yDsPlVhWI57swd4TbeMSMSuE1oqcskK/V65Vyx3xT1kUELSmbrj9Sq
 kzRKkukhpryV00J1NZdax3gBN3ERZSKUI7JetvgWnFBY9FRjxurbslcpJnz41GwMzZkt
 bbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754380396; x=1754985196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TictHvZpsRek9qIa4LDmi3ByH1pwWIL8fRDIN7ICxtg=;
 b=E7BevM8SJhA9B0R83jJqDEGI9QNZKUHI33ox6nhnPb23r3K5LufSCSF4PRZvOPpRj5
 xbHdHAW2s1jLBH0r8ww7fd8tJV8AmSwGrcHeg4HUGqVPCorfq5kgV/BK8+lgYtJN7Tfu
 pzfN2CHL6fmG1+zxxInztF3YW2wdxJ9gI6YTGwTBx+FV+TKct7gkGVqpTui+4/bgoQxZ
 x991wt43Zb1153fYNkP4l358kgsz4vJ8/cIoLcuRhDGZ9pf6yMk+Xtf38R7Eq4+nQgX+
 X4rIkniBW831EV6JW9ib0mmY3/rEAzKwQzBePbe9HL3WtQMEUaigd6kSoxMJn7AK0rre
 fDvg==
X-Gm-Message-State: AOJu0YyhjYPRrJ4j9so4ATz08KwMugmhzMrKJcl0NyDYXwPYpIGU4aM2
 064izNG/gJgxVuKLQwlfufJrHR/eLQmJJL/sSwO3c8lSEkUd1Ew+kRVesn5l8RQ0sC17WJwJdBG
 3QGk0Ju2grazInUr2XiOf6XECc+R+kWU=
X-Gm-Gg: ASbGnct9/tFRHu0bR3YiGRcmE7wipHqeVj3vBp2OSuR9tGLqq/I3EvFVpSFuuIfLXmf
 xrYiZwIsjzCLtrtRBN//X/sHYQfNMHEylx+//chidk9w6tyUPrUDyWdW5Tu8z99e8xlVTdBWvJq
 l5ZB+kstfeTpEsT8uxWSNSvj6uPTk10zMfgchCvI6Iax5sIbB2nPhhnmE6zWRu/So5Pbwzv20fV
 nIJqMDuZ3vQ6Byv8gMKoejXbAl0zpCpQuU=
X-Google-Smtp-Source: AGHT+IHEq4mC+cjgYnaGDt8dVsKLr5XknUbmi+V65qFueRfuSIVAHM/MxaLeRoYJn+9l76wAYZKZl7K89o7v+DLldB0=
X-Received: by 2002:a17:907:3f21:b0:af9:81cd:ccd9 with SMTP id
 a640c23a62f3a-af981cde247mr151250466b.28.1754380395486; Tue, 05 Aug 2025
 00:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250804215719.1413106-1-trini@konsulko.com>
 <20250804215719.1413106-7-trini@konsulko.com>
In-Reply-To: <20250804215719.1413106-7-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Aug 2025 08:53:04 +0100
X-Gm-Features: Ac12FXyVEbi53U9aRQVpEgE-dThdHQKZpVRALq8796ftOD18NerWrNscfgTEXFs
Message-ID: <CALeDE9M+ZC7iEfw+vq6KNLbFpkuryZ3yUUZ_gU6xH+t292s9VQ@mail.gmail.com>
Subject: Re: [PATCH] sound: Tighten some sound driver dependencies
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 4 Aug 2025 at 23:15, Tom Rini <trini@konsulko.com> wrote:
>
> A few sound drivers cannot build without access to some platform
> specific header files. Express those requirements in Kconfig as well.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/sound/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/sound/Kconfig b/drivers/sound/Kconfig
> index 0948d8caab06..81de9b30f397 100644
> --- a/drivers/sound/Kconfig
> +++ b/drivers/sound/Kconfig
> @@ -23,7 +23,7 @@ config I2S
>
>  config I2S_ROCKCHIP
>         bool "Enable I2S support for Rockchip SoCs"
> -       depends on I2S
> +       depends on I2S && ARCH_ROCKCHIP
>         help
>           Rockchip SoCs support an I2S interface for sending audio data to an
>           audio codec. This option enables support for this, using one of the
> @@ -32,7 +32,7 @@ config I2S_ROCKCHIP
>
>  config I2S_SAMSUNG
>         bool "Enable I2C support for Samsung SoCs"
> -       depends on I2S
> +       depends on I2S && ARCH_EXYNOS
>         help
>           Samsung Exynos SoCs support an I2S interface for sending audio
>           data to an audio codec. This option enables support for this,
> @@ -51,7 +51,7 @@ config SOUND_DA7219
>
>  config SOUND_I8254
>         bool "Intel i8254 timer / beeper"
> -       depends on SOUND
> +       depends on SOUND && X86
>         help
>           This enables support for a beeper that uses the i8254 timer chip.
>           This can emit beeps at a fixed frequency. It is possible to control
> @@ -82,7 +82,7 @@ config SOUND_IVYBRIDGE
>
>  config I2S_TEGRA
>         bool "Enable I2S support for Nvidia Tegra SoCs"
> -       depends on I2S
> +       depends on I2S && ARCH_TEGRA
>         select TEGRA124_DMA
>         help
>           Nvidia Tegra SoCs support several I2S interfaces for sending audio
> --
> 2.43.0
>
