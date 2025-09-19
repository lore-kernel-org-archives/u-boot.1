Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFFCCAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 13:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD5383071;
	Fri, 19 Sep 2025 15:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FBeMbOMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7517B8319C; Fri, 19 Sep 2025 15:13:20 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7355F81E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 15:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so1183248f8f.2
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758287598; x=1758892398; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdmbOLpb1idpMyrm230409ctJilISNyl+LGTzndgaJk=;
 b=FBeMbOMwCzQqpNYshzwR9jGZ3lnD31Us79zal+RgkNajoVeaoNjvKvFJTCHMCEUUSS
 fRlJx5uvUcUZkSftB0I+LNfebwLgPvFcB/kPfzUYDwHzrEM9XnjD8AdF41KUjO5XBfqb
 N1SHmDs4Rf18EDOPpMYb3gwVTYqnkn8iVk/EW8C7dLtAc0lVfuxmx/CCzcRCVTBYynS2
 wUg5HorDW6ZRHuir+GeEWe/3QODfg71L16YeFC3O+aQQsPtXptzC1H96cD/VTIyIz1FN
 oV3PDhuSZ4CGc0TgosRudqLDAAT1oGMLBlQYpbuUk4Db/xd+ADNeYpOvzoQxncSXwyOB
 fXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758287598; x=1758892398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdmbOLpb1idpMyrm230409ctJilISNyl+LGTzndgaJk=;
 b=jy+UnswjLL5wv+QCuXZ+toVyz08IJ2NmMTvKuhZZr4MaPIhiYU2+llW/f9bDm7nLhP
 qQowVL9qFCKTKVD1XPLbdYa11xnzC1GLG/TF4pQHhGgpTXhzx2q/dPe1rGeg3+I6p6WZ
 wnQEaS72N2Bwj3L/OOJwTZaJrn9ZJ7pDQ2IbsBzvHMJsSoyjU9XVTjIDlwcbe5ZSHW7H
 FC5BiHCNKcZ1uysdrJK8q9EfThnIZvoqzyLRysWtzemBfwVfTcxElvgboO2T2yqhstXU
 X5xneod2ePwj08X5r9BUP/bTR/JF6ckupB+aXT6/dXwh8LCTWXX+FaaMY6luskIu1svd
 WQSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyRSE4HoYL3SBE+faqvDUnpMfDFxaKZyKEXjNO92aeAc7zEmQdD0RKLenl6NX4Au5HRx2yyis=@lists.denx.de
X-Gm-Message-State: AOJu0Ywi370pBo7A9I5KHHIaYBGdf+q/TcA/3FURfBJu/qgNa4pVXd0A
 SppHF9cmXuDj4PY4fie/uvTNyycLvfZDPU/+MHsY9kkYPIGKuy8pDws9K87Oe6fcYARWvoDAsMh
 dAngABQn/OSaL7tqDpz/NZFI9kEeTC1Vcy7r7
X-Gm-Gg: ASbGnctoHlVDf6YCQTNCv/XDtJI7SMCLxObETqYgdaX58aouyV0oOQp6ORrTT6cyktp
 2r7HE+6+jUyDvawSCZ9XoxRra6M3TU4S3KFvo67AZ00EOpoaxenytCb7yVQ6FqRMwVfkGm0PzoD
 KQt0T15kJO720xr/k9KJwTVvm3YhWm4sS2nWf03hpUKDnoQD3Ku/0spX4DsOE+aijGouQ6k2m9U
 Pr0dusA
X-Google-Smtp-Source: AGHT+IGglKbj3+0+yUkNx13xQ8M4cmeGTK1NNgV8F4Hn+AeSQe6C5U8qY94ZExQEN6ubLpTwGw1Cw+u2AkK/1uyzV3A=
X-Received: by 2002:a05:6000:1ac9:b0:3ec:db87:e88f with SMTP id
 ffacd0b85a97d-3ee87cb34aamr2444251f8f.58.1758287597525; Fri, 19 Sep 2025
 06:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250919101117.853194-1-lukma@nabladev.com>
In-Reply-To: <20250919101117.853194-1-lukma@nabladev.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Sep 2025 16:13:06 +0300
X-Gm-Features: AS18NWCfpTrGa0v8Oi_NlfnXPuQVgL9fFiLzQ7ruDb6LWtvS_U88ejG1fLrpiYo
Message-ID: <CAPVz0n2VSmeyaHRn6WUfSN3uBu+7fw38Q2Wz22VWMjth8nTsPA@mail.gmail.com>
Subject: Re: [PATCH] arm: gpio: Add set_flags callback to the Tegra gpio driver
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

=D0=BF=D1=82, 19 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:11 Luka=
sz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> In some Tegra SoC (like e.g. T30) there is a possibility that one will
> configure at early boot state a pin as GPIO (to use it for e.g. carrier
> board detection). However, afterwards (i.e. in Linux) the same pin will
> be used as the special function one.
>
> Current Tegra gpio driver doesn't allow this, so callback for set_flags()
> has been defined to properly setup the GPIO when required.

Please write the commit message in the imperative mood.

> For now following flags are supported:
> - GPIOD_IS_AF (i.e. "alternate function").
> - GPIOD_IS_IN
> - GPIOD_IS_OUT
>
> In long term the tegra_gpio_set_flags() is going to replace
> direction_{input|output} callbacks.
>

It is not a book chapter, describe what the commit does briefly.

> Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> ---
>  drivers/gpio/tegra_gpio.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpio/tegra_gpio.c b/drivers/gpio/tegra_gpio.c
> index 3d1e18854f2..1e8bd051875 100644
> --- a/drivers/gpio/tegra_gpio.c
> +++ b/drivers/gpio/tegra_gpio.c
> @@ -258,6 +258,29 @@ static int tegra_gpio_rfree(struct udevice *dev, uns=
igned int offset)
>         return 0;
>  }
>
> +static int tegra_gpio_set_flags(struct udevice *dev, unsigned int offset=
,
> +                               ulong flags)
> +{
> +       struct tegra_port_info *state =3D dev_get_priv(dev);
> +       int gpio =3D state->base_gpio + offset;
> +
> +       debug("gpio_set_flags: pin =3D %d (port %d:bit %d), flag =3D %d\n=
",
> +             gpio, GPIO_FULLPORT(gpio), GPIO_BIT(gpio), flags);
> +

Have you even built this code yourself? "flags" is of type ulong, not int

> +       if (flags & GPIOD_IS_AF) {
> +               set_config(gpio, CFG_SFIO);
> +               return 0;
> +       } else if (flags & GPIOD_IS_IN) {
> +               return tegra_gpio_direction_input(dev, offset);
> +       } else if (flags & GPIOD_IS_OUT) {
> +               bool value =3D flags & GPIOD_IS_OUT_ACTIVE;
> +
> +               return tegra_gpio_direction_output(dev, offset, value);
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  static const struct dm_gpio_ops gpio_tegra_ops =3D {
>         .direction_input        =3D tegra_gpio_direction_input,
>         .direction_output       =3D tegra_gpio_direction_output,
> @@ -266,6 +289,7 @@ static const struct dm_gpio_ops gpio_tegra_ops =3D {
>         .get_function           =3D tegra_gpio_get_function,
>         .xlate                  =3D tegra_gpio_xlate,
>         .rfree                  =3D tegra_gpio_rfree,
> +       .set_flags              =3D tegra_gpio_set_flags,

If you are already touching this anyway, then touch it properly. Since
set_flags op is meant to remove direction ops, then remove latter too.

>  };
>
>  /*
> --
> 2.39.5
>

This commit causes regression on LG P990 board, backlight is located
on gpio i2c line and with this patch gpio i2c refuses to work

(bootloader) Core:  114 devices, 27 uclasses, devicetree: separate
(bootloader) MMC:   sdhci@c8000400: 1, sdhci@c8000600: 0
(bootloader) Loading Environment from MMC... Reading from MMC(0)... ***
(bootloader) Warning - bad CRC, using default environment
(bootloader)
(bootloader) Can't get i2c-5 gpios! Error: -22
(bootloader) Can't get i2c-5 gpios! Error: -16
(bootloader) In:    serial,usbkbd,button-kbd
(bootloader) Out:   serial,vidconsole
(bootloader) Err:   serial,vidconsole
(bootloader) Net:   No ethernet found.
(bootloader)
(bootloader) Autoboot in 0 seconds
