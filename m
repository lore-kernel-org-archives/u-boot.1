Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9F4C87FD2
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 07:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908AC833D7;
	Tue,  5 Aug 2025 09:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pl0G+KPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50833833E1; Tue,  5 Aug 2025 09:47:26 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48071833D1
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 09:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-af967835d0aso308980966b.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 00:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754380044; x=1754984844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D3ojOFK+hE3vwhFgbHr12hMDn75CbbCfeZlUwAvs3x8=;
 b=Pl0G+KPo1frv2Xa8TKY1tgn2ZwQI2IWwf+l7agGEFvoYAk6qPj1CTMykGBfCtpX92R
 ITCV/dPwyvmlp4oVsb0weCs0I/V/fCCCdzzyyskK73mLyMsZPHaInOEFxcWSj9hn+EU7
 xpTinFjDU0TtM9XhD/v937jqzes3szPb53gJuAEnSQOhyfcQDCa1I6Af3h1jLpRYzpZS
 tGDtVgKNm3XbUZjNxnpUvx4uIu6wc7yRPkRdc3aZqC1uLeOcdXc7g6aUxUJeHg/uxxSa
 TTFtYCHV+wOkTmDuQydNQ4U7lYuUl+4Y22pL+VecdWg+5qnxkzGAKXSwS0UhcOQzra0U
 YqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754380044; x=1754984844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D3ojOFK+hE3vwhFgbHr12hMDn75CbbCfeZlUwAvs3x8=;
 b=i0c+Z9UpwNSZaFpGJJhCqlcfCNZ7zYwixDD/vHkwmXFrscrT7Yzv6z7hiQg9/c4psM
 FQy3rSOGPYjsgceDhAboVO9jbrC4qlKdpAwMY28kYpRzeG+20V+/IZjGlNvRnHEYA7Y9
 q7+4Sxl/0SPwJZhzXsTWc8BlVckWlsG+iktuqRjSc/l2z37DWe02QzL2cNf++J/46xRr
 u08ScJNNen6YDTErVrOJcJW1klmrYw1ueClmsEUQsIQ6ZJ+zG0SdtVfREDixgh8WcFq1
 puccFME6fm43i+9rdif1ddrKRr7qoOoN4c01g0AZy1sm8c5dwqScYSVoiaDgvYgeevNg
 ahZg==
X-Gm-Message-State: AOJu0Yyl+OPRfXiWfwmWU4/kStudMpkNXdVn6wR3bRqqBMPTnMccCfwh
 c2RdZG67iDde5yigA6n747TQOqf9aV0f21ptlYEoLkND+L8dSrIoP21sU1TJxRQQNZOpdcodHnS
 au8md80qPnfVNqzIotdoPLBld/zTqcz1CNy93
X-Gm-Gg: ASbGncvB7nheWGLPU2LPDOFSpbrLg9HZvYPSyZ/sdxac8CQhXJQ5m+sga15bzP2DSBv
 Y/DVIooOfAlOnUt4frYlPDC3ulo3LzfYrTRWyjIOg7vXqrqdgAtQVg/MmKGEIjBoAAdHkqFFsjE
 s0GnWuFbC/TwdF9qCdKXKd8G1IzA4YAKUR2C/Lcos6mAXz6urVqHmCu0eGav6shoMwos/ySG8hR
 v9IX2LNAF4r0w04ygpV0/8HBZXE9GfliGJM4CuzHlzUjw==
X-Google-Smtp-Source: AGHT+IHV7/K0MSCSKsNZI5OnrW6fzl4mEwbMCkQg49F0r60tSDcjbI+4kzkz3NdJcM15kqwIF9gCuBBiNpSenF6JcS4=
X-Received: by 2002:a17:906:730e:b0:ade:198c:4b6f with SMTP id
 a640c23a62f3a-af93ffcc482mr1231976366b.1.1754380043381; Tue, 05 Aug 2025
 00:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250804215111.1412197-1-trini@konsulko.com>
In-Reply-To: <20250804215111.1412197-1-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Aug 2025 08:47:11 +0100
X-Gm-Features: Ac12FXwkv3-xCPNSgq601I9_8LJM6DzYqCLhx43QQEEIiNBC6d5Wz0voxQPIje8
Message-ID: <CALeDE9NzgruJHuXLHq7oDfVrtAQT0spuC49O64S2NZbKWijFYg@mail.gmail.com>
Subject: Re: [PATCH] sm: Rework the Kconfig logic here
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

On Mon, 4 Aug 2025 at 22:51, Tom Rini <trini@konsulko.com> wrote:
>
> The symbol "SM" is a library symbol and should not be prompted for. It
> should be selected by the drivers that use it. In this case we need to
> add a SANDBOX_SM symbol for the sandbox driver. The meson SM driver
> cannot build on other platforms, so add the appropriate dependency.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  configs/sandbox_defconfig |  2 +-
>  drivers/sm/Kconfig        | 11 ++++++++++-
>  drivers/sm/Makefile       |  4 ++--
>  3 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 0c030f4a7925..3ae198e448aa 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -320,7 +320,7 @@ CONFIG_RTC_RV8803=y
>  CONFIG_RTC_HT1380=y
>  CONFIG_SCSI=y
>  CONFIG_SANDBOX_SERIAL=y
> -CONFIG_SM=y
> +CONFIG_SANDBOX_SM=y
>  CONFIG_SMEM=y
>  CONFIG_SANDBOX_SMEM=y
>  CONFIG_SOUND=y
> diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
> index 926af2863308..8e500ed2ede5 100644
> --- a/drivers/sm/Kconfig
> +++ b/drivers/sm/Kconfig
> @@ -1,8 +1,17 @@
>  config SM
> -       bool "Enable Secure Monitor driver support"
> +       bool
>
>  config MESON_SM
>         bool "Amlogic Secure Monitor driver"
> +       depends on ARCH_MESON
>         select SM
>         help
>           Say y here to enable the Amlogic secure monitor driver.
> +
> +config SANDBOX_SM
> +       bool "Sandbox Secure Monitor driver"
> +       depends on SANDBOX
> +       select SM
> +       help
> +         Say y here to enable the Sandbox driver for the secure monitor
> +         uclass.
> diff --git a/drivers/sm/Makefile b/drivers/sm/Makefile
> index da81ee898abf..5ac947350bde 100644
> --- a/drivers/sm/Makefile
> +++ b/drivers/sm/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
> -obj-y += sm-uclass.o
> -obj-$(CONFIG_SANDBOX) += sandbox-sm.o
> +obj-$(CONFIG_SM) += sm-uclass.o
> +obj-$(CONFIG_SANDBOX_SM) += sandbox-sm.o
>  obj-$(CONFIG_MESON_SM) += meson-sm.o
> --
> 2.43.0
>
