Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBDDC36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 05:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D17A812BC;
	Mon, 31 Mar 2025 07:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ewnNbvwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B9748144A; Mon, 31 Mar 2025 07:51:37 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8532280F9C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 07:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394a823036so38322395e9.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 22:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743400295; x=1744005095; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTRlZhiNl2mFYJAO1JOIZtRxxGOOLHqljREG0uQ3URc=;
 b=ewnNbvwNObB0AofHv2CcUGT2rmLCfWF/oPfHOXmdiTIZ6C9YPCgxFXBJAA5p/Gy75Z
 snaQfRH+LR7Uwh3Dr9AfbCPdnow21lVavj0/kX3kza7+hDjMQWs9vV44uE8LKyHY+oi2
 cIRfelhlqnt8ev9Vy4EMqkMw4eFq/Z8mAM2evoioCrBe8yRugg4kH/rjQptKkfmLZe1r
 E+WYbbiIjKQeXbEARmOjaZOqjRJyokcu3aJ+fun52v28S1FV1d43u07fohulhgWrsDfz
 R7ej6/PzHO3XKBmuD9LV6jtlyJ4St7fkFZujUwL26ofwfiIbwNqjC8WJHxzvEs8s+9oy
 1fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743400295; x=1744005095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTRlZhiNl2mFYJAO1JOIZtRxxGOOLHqljREG0uQ3URc=;
 b=Ey2ax0OvsCwpix5PFRIPSwqxTVnSnhUUdB0ST4zh5X1eav5LYuYAjR+Ituwxq2+Hit
 jK/D83QNU/h7bV/RuDGQuQSixesTR4lVWaJ4N3CixEYK0is7Au+862HhEg/SqsBTTPzp
 brzx1QQ9yZssHHDX3oVzGK/vFAU+PtON6m/Mbi+FdSLXgu1fiMpnX5bLO9sd47LaatLg
 rPEsEwlhNhzx8dwalHgDaqkt6k3dnL9gCOzzDB0uqpHFeDtbr+RZQUk7NY70vGY497cf
 j1asNbexit52c8LLKJSf80rNVID9B5veC4XBP/VGkCyUZmKjcE6oC2+frFaX9Z7LxTuu
 G3ZQ==
X-Gm-Message-State: AOJu0Yy0DyWAcJSqZWXyRbM/NSTzVR38JgEb9UccXzW4D3AEiRctCbES
 rMAjCrR4P+QBukznXTjBEVxwuAGx96BrOQakglJlaSOK7XZFHAJ19+tMfN6EhRkYGnGLc4jAjY4
 +bzMThG0vtfAAQZgojlYiI2o8N8c=
X-Gm-Gg: ASbGncslcmrygB7qBk3U6uQm7qtcO+IyiswxhJR/PA7Qwmp6TiAdT8uIKriQW4L4B+x
 MV/Za5IkPIy73q9Wk11uWQ2U4hBsiVPf1MVYE+N2/uYwPYgjbCRfzQE5ycKCNQyI6unWF3vEG89
 NaP7rq3ZFQ4ub/89CDGL2qNp55oe0=
X-Google-Smtp-Source: AGHT+IHUl3o/amDGLmO+SrgWu6WxAREacMtHjJAMyJ/rXqbe6hq/SFMQROcTZQ560vayuiD6dnloR3/Sn8AIGiOkqGM=
X-Received: by 2002:a05:600c:3ca6:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-43db61dc71dmr68801295e9.3.1743400294691; Sun, 30 Mar 2025
 22:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
 <20250330212638.v2.3.I45a1ec3470905b1a7313ef907a83999f1163bb3b@changeid>
In-Reply-To: <20250330212638.v2.3.I45a1ec3470905b1a7313ef907a83999f1163bb3b@changeid>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 31 Mar 2025 08:51:23 +0300
X-Gm-Features: AQ5f1Jr7uiS0JtW11X2lCKLm-jnXNVwuP1UvavokachIuVFLkDpN_NvrVm99FpM
Message-ID: <CAPVz0n0fRLgc7aOCpjVVRaX=dPMB9D9UDyNck8gsCJTpfh1pBg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tegra: allow to expose UART on microSD slot
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Stephen Warren <swarren@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>
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

=D0=BD=D0=B4, 30 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:27 Artu=
r Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Tegra20 has mux allowing to repurpose microSD as UART on boards which
> use sdmmc3 controller for microSD. Add TEGRA_UARTA_MICROSD to enable
> this feature. It is currently supported on Transformer T20, support for
> other boards may require Device Tree changes.
>
> Update Transformer T20 DTS to select correct pinmux and stdout-path
> based on TEGRA_UARTA_MICROSD.
>
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> ---
>
> Changes in v2:
> - added TEGRA_UARTA_MICROSD Kconfig option
> - removed .dtsi for enabling UART over microSD
> - modified transformer DT to use UARTA and correct pinmux when
>   TEGRA_UARTA_MICROSD is enabled; it is enough to flip a single
>   switch to enable/disable UART over microSD
>
>  arch/arm/dts/tegra20-asus-transformer.dtsi | 24 ++++++++++++++++++++++
>  arch/arm/mach-tegra/tegra20/Kconfig        | 15 ++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/arch/arm/dts/tegra20-asus-transformer.dtsi b/arch/arm/dts/te=
gra20-asus-transformer.dtsi
> index 49efabbfd92..9ea323c81f3 100644
> --- a/arch/arm/dts/tegra20-asus-transformer.dtsi
> +++ b/arch/arm/dts/tegra20-asus-transformer.dtsi
> @@ -5,7 +5,13 @@
>
>  / {
>         chosen {
> +#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
> +               stdout-path =3D &uarta;
> +#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
>                 stdout-path =3D &uartd;
> +#else
> +#error Unsupported UART
> +#endif
>         };
>
>         aliases {
> @@ -195,10 +201,17 @@
>                                 nvidia,function =3D "i2c1";
>                         };
>
> +#if CONFIG_IS_ENABLED(TEGRA_UARTA_SDB_SDD)
> +                       dbguart {
> +                               nvidia,pins =3D "sdb", "sdd";
> +                               nvidia,function =3D "uarta";
> +                       };
> +#else
>                         sdb {
>                                 nvidia,pins =3D "sdb", "sdc", "sdd", "slx=
c", "slxk";
>                                 nvidia,function =3D "sdio3";
>                         };
> +#endif
>
>                         sdio1 {
>                                 nvidia,pins =3D "sdio1";
> @@ -376,7 +389,13 @@
>                 };
>         };
>
> +#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
> +       uarta: serial@70006000 {
> +#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
>         uartd: serial@70006300 {
> +#else
> +#error Unsupported UART
> +#endif
>                 status =3D "okay";
>                 clock-frequency =3D <216000000>;
>         };
> @@ -434,7 +453,12 @@
>         };
>
>         sdmmc3: sdhci@c8000400 {
> +#if CONFIG_IS_ENABLED(TEGRA_UARTA_MICROSD)
> +               /* Can't use both at the same time */
> +               status =3D "disabled";
> +#else
>                 status =3D "okay";
> +#endif
>                 bus-width =3D <4>;
>
>                 cd-gpios =3D <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/te=
gra20/Kconfig
> index 3349f1e2786..c2c51660216 100644
> --- a/arch/arm/mach-tegra/tegra20/Kconfig
> +++ b/arch/arm/mach-tegra/tegra20/Kconfig
> @@ -77,6 +77,21 @@ endchoice
>  config SYS_SOC
>         default "tegra20"
>
> +config TEGRA_UARTA_MICROSD
> +       bool "UARTA on MicroSD breakout board"
> +       default n
> +       depends on TEGRA_ENABLE_UARTA && TARGET_TRANSFORMER_T20
> +       select TEGRA_UARTA_SDB_SDD
> +       help
> +         Repurpose the SD card slot for getting access to the UARTA seri=
al
> +         console. Primarily useful only for low level u-boot debugging o=
n
> +         tablets, where normal UARTD is difficult to access and requires
> +         device disassembly and/or soldering. Enabling this option cause=
s
> +         UARTA TX to become exposed on SDD and RX on SDB pins which corr=
espond
> +         to microSD CLK and CMD pins respectively. Currently this is sup=
ported
> +         only on Transformer T20, support for other platforms may requir=
e DT
> +         and configs (from include/configs/*) updates.
> +
>  source "board/nvidia/harmony/Kconfig"
>  source "board/avionic-design/medcom-wide/Kconfig"
>  source "board/compal/paz00/Kconfig"
> --
> 2.48.1
>

This is not applicable since this is a hack by nature, BUT if you
contain this in the transformer t20 board and Kconfig (no dts
changes), this may be applied.
