Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AF2C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 15:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4233842C7;
	Wed,  6 Aug 2025 17:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gmx2fPYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F14842CE; Wed,  6 Aug 2025 17:16:04 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11AC842AB
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b7834f2e72so4205836f8f.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754493360; x=1755098160; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eSKJgGSQjzqfymLOVs4kkTjMGqgnUN+u5oVTXqzwyw=;
 b=Gmx2fPYrHrKL4pPTjQYKRhtcr2hxuO20/RqEDnsDYygGeSYbs2xB93AD+BU6FK06rN
 yQcB3Mhc/UWB2YX3Nex3FOErnJzJPL5t/IiY2+yP0u0DXFBjYRQYz/EtPACJ+/2PyQO+
 BjwWpTMmd896AysApHdUbALMCTENpy/Wmg9OqLBJjtvmMPHSwZ0OWUam0KCGodxwAI3h
 iCbVrobXxX6yFeXrfS3YUuskb4bW5sBBzBamajRCiv67l8KdiLKRxgB/gcbAhcb7EFQe
 SxPx0/dVzm9lG1Yoc2jXggbuVU482XfLqRhkOuhHJ8G5gKKlLdKO4lpalL9yn7mP4hcx
 dCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754493360; x=1755098160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2eSKJgGSQjzqfymLOVs4kkTjMGqgnUN+u5oVTXqzwyw=;
 b=DuAH8krFAVXTwG7u2SF9joLhf50zfrSz4mq4BcOzqU+4SjrPH1x0sIdViSCEauEmmS
 gC8U5SIdyLQGtsM61bXsMfBv3ULzjK1323M2brb6S2EXB/g/owWEc3BFOt8AUfTFpQiW
 N9r3vngup7Em2lvsti+/6HrIR4Xf9Ao6D+j/WeINkOMr+hEMcmgHu7iLU+eF+cVa4xSE
 VvmjhK2q7AdbnZdQCqDb70MbmhewqXjleC1fTWQMLkqRjQlx8v8nhsG/0pxJgdJz5F8q
 NEuZ7RAH0UX+E6EHDBc2J0m3fmYAVSaWzlb9f86OpJEfk9BDS7qTFRVguXnVdWIRkjBW
 kgmg==
X-Gm-Message-State: AOJu0YwWrMYQKBCD6EJP0uBE6x3V50NG7F30+i67qD1pTfJVIhN1AZLX
 Hi1k8SWWxsRcjkD3A4S+b0n7T6zGTkYk/1BG5AHVNJuzopwhmcY4BJRKc/UqGP6MEv20qlVkf+k
 aYPfZU2N9CwcqXM54qK3m1UKQpGUYcBFhH5cR
X-Gm-Gg: ASbGnct3aH7jQFQABI061kpDfoyk0f8gfno4A/VxcYmgJzg8eSPHMEyvDBFDfuz3Tr+
 5DCDZfoWkAjAhtBEt3qbGdYlaKSKKA/Giu3IUILJh6r5ZrWYYD0bn8CQTM/et83DLQhcqiiaL7V
 zJ9tusgBzPJjJF1IF8o8Rzq9gDKFVPZ4DV7LpkVrDTXM3uo7afDyzxj+WdKZQjr+RsbdD/nRJJ9
 Scem95c
X-Google-Smtp-Source: AGHT+IHOZAG5M7cA9sL5yfU/kjvXO1zFnh0CX+dUXvenfI05Z4cKdSaAhb4wha7HVA9sjb8WNpSk/7jkW8zSGMjojTc=
X-Received: by 2002:a05:6000:24c6:b0:3b3:9ca4:ac8e with SMTP id
 ffacd0b85a97d-3b8f41b5227mr2936072f8f.44.1754493359857; Wed, 06 Aug 2025
 08:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250806145649.1664724-1-trini@konsulko.com>
 <20250806145649.1664724-3-trini@konsulko.com>
In-Reply-To: <20250806145649.1664724-3-trini@konsulko.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 6 Aug 2025 18:15:48 +0300
X-Gm-Features: Ac12FXwY-Q1w2hhUKwIPK0f5nXHxyNI_8rIhRY-IhsniYKLDT-ikcjJVdTGC_1U
Message-ID: <CAPVz0n2YxuUZKa9B+kMRYkWGOikqNEkEqL9rsbngvWTVENggdA@mail.gmail.com>
Subject: Re: [PATCH 3/8] video: tegra: Rework some of the driver dependencies
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=81=D1=80, 6 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 17:56=
 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Looking these drivers over, all of them cannot build without access to
> some platform specific header files. Express those requirements in
> Kconfig as well. Furthermore, update the logic a bit more to reflect
> which parts are optional when other drivers are enabled and which parts
> cannot be enabled (meaningfully) by themselves.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  configs/star_defconfig      |  1 +
>  drivers/video/tegra/Kconfig | 19 ++++++++++---------
>  2 files changed, 11 insertions(+), 9 deletions(-)
>

Thank you for cc-ing me in. Maybe it would be better/cleaner to gate
entire /tegra dir with ARCH_TEGRA dependency, after all, drivers in
there are all Tegra specific. With said or as is LGTM.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

> diff --git a/configs/star_defconfig b/configs/star_defconfig
> index 38cbdec1c3a0..1547f724f062 100644
> --- a/configs/star_defconfig
> +++ b/configs/star_defconfig
> @@ -89,4 +89,5 @@ CONFIG_VIDEO_LCD_LG_LH400WV3=3Dy
>  CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA=3Dy
>  CONFIG_BACKLIGHT_AAT2870=3Dy
>  CONFIG_VIDEO_BRIDGE=3Dy
> +CONFIG_VIDEO_TEGRA=3Dy
>  CONFIG_TEGRA_8BIT_CPU_BRIDGE=3Dy
> diff --git a/drivers/video/tegra/Kconfig b/drivers/video/tegra/Kconfig
> index f32972d937e5..8bc29f2838bd 100644
> --- a/drivers/video/tegra/Kconfig
> +++ b/drivers/video/tegra/Kconfig
> @@ -1,10 +1,12 @@
>  config HOST1X_TEGRA
> -       bool "NVIDIA Tegra host1x BUS support"
> -       depends on SIMPLE_BUS
> +       bool
> +       select SIMPLE_BUS
> +       help
> +         NVIDIA Tegra host1x BUS support
>
>  config VIDEO_TEGRA
>         bool "Enable Display Controller support on Tegra devices"
> -       depends on OF_CONTROL
> +       depends on OF_CONTROL && ARCH_TEGRA
>         select HOST1X_TEGRA
>         help
>            Enable support for Display Controller found in Tegra SoC. The
> @@ -17,7 +19,7 @@ config VIDEO_TEGRA
>
>  config VIDEO_DSI_TEGRA
>         bool "Enable DSI controller support on Tegra devices"
> -       depends on VIDEO_BRIDGE && PANEL && DM_GPIO
> +       depends on VIDEO_BRIDGE && PANEL && DM_GPIO && ARCH_TEGRA
>         select VIDEO_TEGRA
>         select VIDEO_MIPI_DSI
>         help
> @@ -27,7 +29,7 @@ config VIDEO_DSI_TEGRA
>
>  config VIDEO_HDMI_TEGRA
>         bool "Enable HDMI support on Tegra devices"
> -       depends on VIDEO_BRIDGE && DM_I2C
> +       depends on VIDEO_BRIDGE && DM_I2C && ARCH_TEGRA
>         select I2C_EDID
>         select VIDEO_TEGRA
>         help
> @@ -36,16 +38,14 @@ config VIDEO_HDMI_TEGRA
>
>  config TEGRA_BACKLIGHT_PWM
>         bool "Enable Tegra DC PWM backlight support"
> -       depends on BACKLIGHT
> -       select VIDEO_TEGRA
> +       depends on BACKLIGHT && VIDEO_TEGRA
>         help
>            Enable support for the Display Controller dependent PWM backli=
ght
>            found in the Tegra SoC and usually used with DSI panels.
>
>  config TEGRA_8BIT_CPU_BRIDGE
>         bool "Enable 8 bit panel communication protocol for Tegra 20/30"
> -       depends on VIDEO_BRIDGE && DM_GPIO
> -       select VIDEO_TEGRA
> +       depends on VIDEO_BRIDGE && DM_GPIO && VIDEO_TEGRA
>         select VIDEO_MIPI_DSI
>         help
>            Tegra 20 and Tegra 30 feature 8 bit CPU driver panel control
> @@ -54,6 +54,7 @@ config TEGRA_8BIT_CPU_BRIDGE
>
>  config VIDEO_TEGRA124
>         bool "Enable video support on Tegra124"
> +       depends on ARCH_TEGRA
>         imply VIDEO_DAMAGE
>         help
>            Tegra124 supports many video output options including eDP and
> --
> 2.43.0
>
