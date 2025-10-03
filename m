Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E790CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 17:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D5C83835;
	Fri,  3 Oct 2025 19:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X0/WOskG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14DA83839; Fri,  3 Oct 2025 19:51:53 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AFBD8381D
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 19:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so1534200f8f.2
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759513911; x=1760118711; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=579nd2OVGELnXkgPXs5qv0m64UoVuWWxTkUTcvw5zQw=;
 b=X0/WOskG8it5K+Q9+9FUvHc30WDwpOIqMM6Y7NkTSrVfVdcOsItMudPLOmyQKF2bIG
 HNRnAR04ab0jdHM/Zxb/EuQDbqTyA2IF0TM8+7g42F5USrOhpZ4QP3gFKAhA7d3Fgot5
 OdUZX6F/DQdA6flKjAzWpDOAy2UuN+C8XadnCd0EEOBKUf+DWNMqHbYS3fAtbDjKiYv3
 fEB9Mu3P5IwDajmS73MhNzmxn6rlLqb8gBoTf6u806kb6hLL9Wy042NM9bE68OZZTbqs
 tJAz4TmGzgkIf93V/cNTPz6iuY+U4AF72G/HcGxuZ/NXefNOqiTHBl3LdLESxMnkfbnT
 M4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759513911; x=1760118711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=579nd2OVGELnXkgPXs5qv0m64UoVuWWxTkUTcvw5zQw=;
 b=raOA0aFHpHSURPQpTj0rWCnoBX0cT0JmTZFZeoPo0VapjVj4uN7BzvvYqaJNkVbbCo
 XP/17aJY0bIJMm4oT90kAuJ/9MUZCoMbx/y/FaGoZI1hz9VjO8jmSafBLeoD0rH7uNiQ
 bYlxem2HbPewIKCH1BqVA4Jrlazf3JtK8mXxYKAqOtJuod4ZD4LIbgELfln9lJjZdoAW
 xTI+l7UKep1eSEumlrC4QlyYnBXZV4ux+6vIjihyiBqg5l3MSm0qyJg46vLU7LTd2lfX
 Gl+3glwwXXA5lyz1+ccdR65/D+hGlfeX00JzAPS+H5gX/2ktw8f08IaOm0DlR+O0yz5L
 /+mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUthOGeRpy7AbR1x4sWqZghAtI9zImDSXd6HW/MiXwA2C6QMZwfky6hrjjME9BqAWTNydblMsw=@lists.denx.de
X-Gm-Message-State: AOJu0YyiGX1lwQ7c8ez5aNOPUGmg8Ifkf3Kb4gOTwGD9uqgmg0vk9lkW
 +FYe/3uOB6pVKqWE8cpMFpuO/G7BtanDI3MO06mAnZjFspDD/L5d8ApYw5IUgsz8tObmuMF+r2J
 gdK5ghzw64Szu92h+/hn3El9YmczVVZo=
X-Gm-Gg: ASbGnct1ZJZsgaDLIEESA29XyHWDctb6V8YyPdf7ApyonAd32Iz918BvaoHmomckhFk
 sZcwBvCZDnPoWNZhdUWOyC9n7+VxC9GWsosPwt/pGDTaWBs2bJ6J9xvKpnu+Co4+N2ioiccMlGI
 VfTpWhSoVNhGbWrmX0zHm/nmAbgnPTwa1vfqSMEnZgVn0X5+9yDz0AH1AWTAmMJBLvBUwzQJDl5
 R5IBd5bCHSrAoIiKw99cQF+Zv1a+Y9J
X-Google-Smtp-Source: AGHT+IFI6q57dPfTgWC8V2G4F567FDp3HnD9GGFjFSTR6tRqgPs3Ti0oE39OgJLXGcNlbcHoot5exEHl9lQirOwF//c=
X-Received: by 2002:a05:6000:610:b0:3fe:d6df:c679 with SMTP id
 ffacd0b85a97d-425671c1c62mr2692545f8f.55.1759513910645; Fri, 03 Oct 2025
 10:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250922141617.225861-1-lukma@nabladev.com>
 <CAPVz0n2iw7xZWFH46=fF3aPRjwx5QvQ0=yxY=v4tusNBj3qMvw@mail.gmail.com>
 <20250929092338.08d6b00a@wsk>
 <CAPVz0n3mm=84C25tDXxGaXbe_Dxygc+kSoADtx3NvhZoanX=LQ@mail.gmail.com>
 <20250929122201.7215f650@wsk>
In-Reply-To: <20250929122201.7215f650@wsk>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 3 Oct 2025 20:51:39 +0300
X-Gm-Features: AS18NWA4ng7A4BykWT9n87YMD_je82ZcnktmEMYP0-WBrnfDx7qdbookabem2cY
Message-ID: <CAPVz0n0wU8e_PBQ7V9_6pQam20WKv9PYhFfr8F+nXb-mSKRztQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm: gpio: Add set_flags callback to the Tegra gpio
 driver
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
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

=D0=BF=D0=BD, 29 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:22 =C5=
=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> > =D0=BF=D0=BD, 29 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:23 =
=C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > > =D0=BF=D0=BD, 22 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17=
:16 Lukasz Majewski <lukma@nabladev.com>
> > > > =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > This patch adds support for the .set_flags callback.
> > > > > For now following flags are supported:
> > > > > - GPIOD_IS_AF (i.e. "alternate function").
> > > > > - GPIOD_IS_IN
> > > > > - GPIOD_IS_OUT
> > > > >
> > > > > Currently, the .set_flags in gpio-uclass.c (function
> > > > > dm_gpio_set_value()) is used before .set_value callback, so
> > > > > functionally replaces it. As a result the corresponding
> > > > > tegra_gpio_set_value() can be removed.
> > > > >
> > > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > > ---
> > > > >
> > > > > Changes for v2:
> > > > > - Fix the format specifier for flags in debug() function
> > > > > - Update commit message
> > > > > - Remove tegra_gpio_set_value() method (as it is functionally
> > > > > replaced by set_value()
> > > > > - Prevent from returning errors when flags =3D 0 (problem with
> > > > > e.g. I2C GPIO support)
> > > > > ---
> > > > >  drivers/gpio/tegra_gpio.c | 39
> > > > > +++++++++++++++++++++++---------------- 1 file changed, 23
> > > > > insertions(+), 16 deletions(-)
> > > >
> > > > Lukasz, thank you for this change I would really like to see it in
> > > > mainline. ATM I have no capabilities to debug
> > >
> > > You mean test if it works?
> > >
> > > > this and I will return
> > > > to it but that may not be soon unfortunately.
> > >
> > > This is a bit problematic for me, as:
> > >
> > > 1. Some future work depends on it (more details below).
> > > 2. The "set_flags()" callback seems like being now the one to be
> > > advised to being implemented and used.
> > >
> > >
> > >
> > > Can you predict when you will be able to come back to this task? Is
> > > this the matter of weeks or months?
> > >
> >
> > Weeks maybe, I will try to look into this when I have some spare time
> >
>
> Ok.
>
> > > > In case you really need
> > > > switch GPIO back to SFIO and Linux cannot handle this, you an use
> > > > dm_gpio_free to release gpios in board_preboot_os in the board as
> > > > a temporary measure.
> > >
> > > Yes, this is a temporary solution - i.e. dm_gpio_free() is supposed
> > > to "free" the pin. IMHO, the set_flags() shall be used, as I in
> > > fact do want to set the CFG_SFIO flag, not release the gpio.
> > >
> >
> > dm_gpio_free in tegra case calls CFG_SFIO
>
> Yes, but as you said - this is not the "proper" solution.
>
> >
> > > >
> > > > Overall issue you are describing is not u-boot's it is kernels,
> > > > kernel must reconfigure gpios for proper work regardless of their
> > > > previous state. If it is not the case, then kernel device
> > > > configuration is incomplete or wrong.
> > >
> > > This is how the pinmux in Linux for Tegra is written. You can setup
> > > the PAD parameters, but you cannot set the pin's function.
> > >
> >
> > WDYM? Tegra30+ has per-pin configuration, this includes FUNCTION,
> > direction, tristate and pull for all pins
>
> With DTS pinmux description, you cannot change the PAD function
> (special vs gpio) in Linux. It is assumed that bootloader would set the
> function (which, yes, is IMHO a bug).
>
> >
> > > In other words - you have to do it in bootloader (u-boot in this
> > > case).
> > >
> > > In my case - customer uses the pin in u-boot as GPIO to check
> > > carrier board version, then the same pin in Linux is going to be
> > > used as special function one.
> > >
> > > Unfortunately, above "reconfiguration" cannot be done in Linux.
> > >
> > > As other "rework" of gpio code depends on it (use dm) - I would
> > > like to postpone my work until this functionality is available in
> > > mainline (and hence avoid "temporal solutions").
> > >
> > > --
> > > Best regards,

Try this https://source.denx.de/u-boot/custodians/u-boot-tegra/-/commit/d95=
d942b6e796429342845d153d95330f5257cdd
I have combined your v1 and v2 and added a few tweaks. It works on
star and olympus (tegra20), p895 and grouper (tegra30), tegratab and
tf701t (tegra114) and mocha (tegra124).
