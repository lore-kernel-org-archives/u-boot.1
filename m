Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F0ECCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 07:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 193F982991;
	Mon,  6 Oct 2025 09:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="APDeoo42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 862B882E34; Mon,  6 Oct 2025 09:18:16 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 200D7807B1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 09:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4256866958bso1670294f8f.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759735093; x=1760339893; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qq5qYn+LSe+xLWYOHT8VeQtI8GY0pQQjfFf4+bnbBwc=;
 b=APDeoo42JLiOABRPetGqWSH5rx8DMGXRZD3KHBOmJDihcNFSPyTX6PF2q+ut1bAP1g
 wDuAPpjBCCIZuZDruRM8LXgFblEIrP5ZE8YxT9odU/VgMUErgNRvsfMhgfGEup8TChU9
 gHAwMxuDQRY4HXPPY84qkL2Z/LXttFKMToxGhOGPl+odk3AMljAoYplsPQgYNgVb2sG1
 Em50D3gaV8c6WsuYU8vtdjGWFAu0t4tUJ165Td3qQpKIOSzifeKdW7GLELb51Euj22aU
 H2HSyxmRs3gy2EHSFENuEnDjA4gsMn2FzshTwQs/TKm3VlcfZWB2107BUQvkF/4GigRG
 WYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759735093; x=1760339893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qq5qYn+LSe+xLWYOHT8VeQtI8GY0pQQjfFf4+bnbBwc=;
 b=lqtBSCRFQgIpdzaoJ02LwB341Pd+ybp1VMF2nPaIX9NR8hGjK/CqrADKDrhWnpkzfq
 CqrFAOVAB+IQ5460jHHp961fuvqzZlxvQTgd0/XKt0/BTVUho9NWyFFd+zMXV6/nCSnT
 yUnY0qqEIxxZB0V7TbnLEudUydr+jAOmNPXP5alW4YmfYd/IEJDQ9nxheIW2cHC39hg4
 cedmAIHhJCcpVW9m91cvCik6NuflOv36tH75HCDOcb6anKm1uXs71bT8yiGV0ZazOFB6
 l8nowFZ8v8BRSXgB19+17Sf+kEIDqcBXAhuLVbbgOkggYz/gc4vLejuxSzoKmI6y3oV8
 ntsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBszYW2wdTcN4492eaZJXWaEtNZpJpxf153dXpqsk90IJsHz2r/V3K3h3S6c3nrMIi/AeqLfo=@lists.denx.de
X-Gm-Message-State: AOJu0YxzuK6yINoVbjnoghGKKNaTQ5bBn8Chc4vzT/+MWZJsstbrIYw2
 NSvJ8/n4J0uiAfYCKAE1/uroBAGJ8UYpii7o6dFr73H5XuNlLDb5t/YnlE+30uk6csnI2/G4d/e
 lnBpdyNw+akRR3BkTKfvfq+FN03twuCE=
X-Gm-Gg: ASbGncuY+SJB4grT0QpBRZqov/MAZn9fX+pEE2zwf1JXMWdMWEeAfi7n80TYUemMCFz
 K5EYP8Ftyqp45xshgEJ0+DWghYobMLQFfrLs4inF4WAxGkjt6j0N6uSdiwd3fLR4ahFK4CPSsTr
 T8bKjj8bqvJdXcnScTX/Y+uMo6GSYymUq3iL0Rl9q0Ju1pzNAM4EcPDBP8QCHdLvehDGPlMNtaM
 Hmpt23SG9oVmCKOTspCpMSuGLw8AffmV3hksKgmbRg=
X-Google-Smtp-Source: AGHT+IGwD5m8jKsJPqDiy/0CINQf2A8CVk3n410Er4hyTq9sI81dt3brMHPFpXjhW78n/qICp/aE3MK584txaOpcFQw=
X-Received: by 2002:a05:6000:310d:b0:3ec:db87:e88f with SMTP id
 ffacd0b85a97d-425671c1edamr6745204f8f.58.1759735093346; Mon, 06 Oct 2025
 00:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250922141617.225861-1-lukma@nabladev.com>
 <CAPVz0n2iw7xZWFH46=fF3aPRjwx5QvQ0=yxY=v4tusNBj3qMvw@mail.gmail.com>
 <20250929092338.08d6b00a@wsk>
 <CAPVz0n3mm=84C25tDXxGaXbe_Dxygc+kSoADtx3NvhZoanX=LQ@mail.gmail.com>
 <20250929122201.7215f650@wsk>
 <CAPVz0n0wU8e_PBQ7V9_6pQam20WKv9PYhFfr8F+nXb-mSKRztQ@mail.gmail.com>
 <20251006091525.04cecc64@wsk>
In-Reply-To: <20251006091525.04cecc64@wsk>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 6 Oct 2025 10:18:01 +0300
X-Gm-Features: AS18NWApbbaOQJmVdjgp1tSuJobEH0xGtXZmupgQml13NWoJ8Un-ikSiaqU37tQ
Message-ID: <CAPVz0n3err6NC+EdobA1JnDmx+0Yi6126g3jmUbN8tK+NGfPMQ@mail.gmail.com>
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

=D0=BF=D0=BD, 6 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 10:15=
 =C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> > =D0=BF=D0=BD, 29 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:22 =
=C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > > =D0=BF=D0=BD, 29 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10=
:23 =C5=81ukasz Majewski <lukma@nabladev.com>
> > > > =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > Hi Svyatoslav,
> > > > >
> > > > > > =D0=BF=D0=BD, 22 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=
=BE 17:16 Lukasz Majewski
> > > > > > <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > > >
> > > > > > > This patch adds support for the .set_flags callback.
> > > > > > > For now following flags are supported:
> > > > > > > - GPIOD_IS_AF (i.e. "alternate function").
> > > > > > > - GPIOD_IS_IN
> > > > > > > - GPIOD_IS_OUT
> > > > > > >
> > > > > > > Currently, the .set_flags in gpio-uclass.c (function
> > > > > > > dm_gpio_set_value()) is used before .set_value callback, so
> > > > > > > functionally replaces it. As a result the corresponding
> > > > > > > tegra_gpio_set_value() can be removed.
> > > > > > >
> > > > > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes for v2:
> > > > > > > - Fix the format specifier for flags in debug() function
> > > > > > > - Update commit message
> > > > > > > - Remove tegra_gpio_set_value() method (as it is
> > > > > > > functionally replaced by set_value()
> > > > > > > - Prevent from returning errors when flags =3D 0 (problem wit=
h
> > > > > > > e.g. I2C GPIO support)
> > > > > > > ---
> > > > > > >  drivers/gpio/tegra_gpio.c | 39
> > > > > > > +++++++++++++++++++++++---------------- 1 file changed, 23
> > > > > > > insertions(+), 16 deletions(-)
> > > > > >
> > > > > > Lukasz, thank you for this change I would really like to see
> > > > > > it in mainline. ATM I have no capabilities to debug
> > > > >
> > > > > You mean test if it works?
> > > > >
> > > > > > this and I will return
> > > > > > to it but that may not be soon unfortunately.
> > > > >
> > > > > This is a bit problematic for me, as:
> > > > >
> > > > > 1. Some future work depends on it (more details below).
> > > > > 2. The "set_flags()" callback seems like being now the one to be
> > > > > advised to being implemented and used.
> > > > >
> > > > >
> > > > >
> > > > > Can you predict when you will be able to come back to this
> > > > > task? Is this the matter of weeks or months?
> > > > >
> > > >
> > > > Weeks maybe, I will try to look into this when I have some spare
> > > > time
> > >
> > > Ok.
> > >
> > > > > > In case you really need
> > > > > > switch GPIO back to SFIO and Linux cannot handle this, you an
> > > > > > use dm_gpio_free to release gpios in board_preboot_os in the
> > > > > > board as a temporary measure.
> > > > >
> > > > > Yes, this is a temporary solution - i.e. dm_gpio_free() is
> > > > > supposed to "free" the pin. IMHO, the set_flags() shall be
> > > > > used, as I in fact do want to set the CFG_SFIO flag, not
> > > > > release the gpio.
> > > >
> > > > dm_gpio_free in tegra case calls CFG_SFIO
> > >
> > > Yes, but as you said - this is not the "proper" solution.
> > >
> > > >
> > > > > >
> > > > > > Overall issue you are describing is not u-boot's it is
> > > > > > kernels, kernel must reconfigure gpios for proper work
> > > > > > regardless of their previous state. If it is not the case,
> > > > > > then kernel device configuration is incomplete or wrong.
> > > > >
> > > > > This is how the pinmux in Linux for Tegra is written. You can
> > > > > setup the PAD parameters, but you cannot set the pin's function.
> > > > >
> > > >
> > > > WDYM? Tegra30+ has per-pin configuration, this includes FUNCTION,
> > > > direction, tristate and pull for all pins
> > >
> > > With DTS pinmux description, you cannot change the PAD function
> > > (special vs gpio) in Linux. It is assumed that bootloader would set
> > > the function (which, yes, is IMHO a bug).
> > >
> > > >
> > > > > In other words - you have to do it in bootloader (u-boot in this
> > > > > case).
> > > > >
> > > > > In my case - customer uses the pin in u-boot as GPIO to check
> > > > > carrier board version, then the same pin in Linux is going to be
> > > > > used as special function one.
> > > > >
> > > > > Unfortunately, above "reconfiguration" cannot be done in Linux.
> > > > >
> > > > > As other "rework" of gpio code depends on it (use dm) - I would
> > > > > like to postpone my work until this functionality is available
> > > > > in mainline (and hence avoid "temporal solutions").
> > > > >
> > > > > --
> > > > > Best regards,
> >
> > Try this
> > https://source.denx.de/u-boot/custodians/u-boot-tegra/-/commit/d95d942b=
6e796429342845d153d95330f5257cdd
> > I have combined your v1 and v2 and added a few tweaks. It works on
> > star and olympus (tegra20), p895 and grouper (tegra30), tegratab and
> > tf701t (tegra114) and mocha (tegra124).
>
> I've tested it on Colibri T30. No issues observed.
>
> Thanks for your tweaks.
>
> Please add mine:
> Tested-by: =C5=81ukasz Majewski <lukma@nabladev.com>
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot-tegra/staging, thank you!
