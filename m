Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEED3CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 10:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB9C83071;
	Mon, 29 Sep 2025 12:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="YDXRSWcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3304C83192; Mon, 29 Sep 2025 12:22:06 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212FF8206E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 12:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 798C2104DF1; Mon, 29 Sep 2025 12:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759141323;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vWhRQxkmc1ZiZrrgaOrB6MEEangUKyJEKbM+MOLOBxo=;
 b=YDXRSWcrOdXNnC/mQE7BJDf+LcndhqFxdxb6PJwTYE87ZAPQw8Wdt5uKTB/dXCdxU5R4UF
 v4CnEU5JRtkeN4d6zuMIU353qEKQ4p8yZb4MwVrFkFm49boRZRHowL50KBRohGHpxEFoYr
 xtU/9CWcvqTKQ/0YSiiJpVabR+m1eS/kzT42S9EqCb1tZfdohzTKURMt4QafOdz4ARZFeP
 nWbtRN/T0SVYtjGH6MDE4Ixg08KZ3HG/S/1cnlxD/IfibcieyvJAIZ6anMGdM+jO6lsP/p
 EK6NVURHMvERcedJj7mM6iVcRRb8ZoAbdqiQH4fu2XrrL9x6fY/czkOhxhhP6Q==
Date: Mon, 29 Sep 2025 12:22:01 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] arm: gpio: Add set_flags callback to the Tegra gpio
 driver
Message-ID: <20250929122201.7215f650@wsk>
In-Reply-To: <CAPVz0n3mm=84C25tDXxGaXbe_Dxygc+kSoADtx3NvhZoanX=LQ@mail.gmail.com>
References: <20250922141617.225861-1-lukma@nabladev.com>
 <CAPVz0n2iw7xZWFH46=fF3aPRjwx5QvQ0=yxY=v4tusNBj3qMvw@mail.gmail.com>
 <20250929092338.08d6b00a@wsk>
 <CAPVz0n3mm=84C25tDXxGaXbe_Dxygc+kSoADtx3NvhZoanX=LQ@mail.gmail.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Svyatoslav,

> =D0=BF=D0=BD, 29 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:23 =
=C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> > =20
> > > =D0=BF=D0=BD, 22 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:1=
6 Lukasz Majewski <lukma@nabladev.com>
> > > =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > >
> > > > This patch adds support for the .set_flags callback.
> > > > For now following flags are supported:
> > > > - GPIOD_IS_AF (i.e. "alternate function").
> > > > - GPIOD_IS_IN
> > > > - GPIOD_IS_OUT
> > > >
> > > > Currently, the .set_flags in gpio-uclass.c (function
> > > > dm_gpio_set_value()) is used before .set_value callback, so
> > > > functionally replaces it. As a result the corresponding
> > > > tegra_gpio_set_value() can be removed.
> > > >
> > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > ---
> > > >
> > > > Changes for v2:
> > > > - Fix the format specifier for flags in debug() function
> > > > - Update commit message
> > > > - Remove tegra_gpio_set_value() method (as it is functionally
> > > > replaced by set_value()
> > > > - Prevent from returning errors when flags =3D 0 (problem with
> > > > e.g. I2C GPIO support)
> > > > ---
> > > >  drivers/gpio/tegra_gpio.c | 39
> > > > +++++++++++++++++++++++---------------- 1 file changed, 23
> > > > insertions(+), 16 deletions(-) =20
> > >
> > > Lukasz, thank you for this change I would really like to see it in
> > > mainline. ATM I have no capabilities to debug =20
> >
> > You mean test if it works?
> > =20
> > > this and I will return
> > > to it but that may not be soon unfortunately. =20
> >
> > This is a bit problematic for me, as:
> >
> > 1. Some future work depends on it (more details below).
> > 2. The "set_flags()" callback seems like being now the one to be
> > advised to being implemented and used.
> >
> >
> >
> > Can you predict when you will be able to come back to this task? Is
> > this the matter of weeks or months?
> > =20
>=20
> Weeks maybe, I will try to look into this when I have some spare time
>=20

Ok.

> > > In case you really need
> > > switch GPIO back to SFIO and Linux cannot handle this, you an use
> > > dm_gpio_free to release gpios in board_preboot_os in the board as
> > > a temporary measure. =20
> >
> > Yes, this is a temporary solution - i.e. dm_gpio_free() is supposed
> > to "free" the pin. IMHO, the set_flags() shall be used, as I in
> > fact do want to set the CFG_SFIO flag, not release the gpio.
> > =20
>=20
> dm_gpio_free in tegra case calls CFG_SFIO

Yes, but as you said - this is not the "proper" solution.

>=20
> > >
> > > Overall issue you are describing is not u-boot's it is kernels,
> > > kernel must reconfigure gpios for proper work regardless of their
> > > previous state. If it is not the case, then kernel device
> > > configuration is incomplete or wrong. =20
> >
> > This is how the pinmux in Linux for Tegra is written. You can setup
> > the PAD parameters, but you cannot set the pin's function.
> > =20
>=20
> WDYM? Tegra30+ has per-pin configuration, this includes FUNCTION,
> direction, tristate and pull for all pins

With DTS pinmux description, you cannot change the PAD function
(special vs gpio) in Linux. It is assumed that bootloader would set the
function (which, yes, is IMHO a bug).

>=20
> > In other words - you have to do it in bootloader (u-boot in this
> > case).
> >
> > In my case - customer uses the pin in u-boot as GPIO to check
> > carrier board version, then the same pin in Linux is going to be
> > used as special function one.
> >
> > Unfortunately, above "reconfiguration" cannot be done in Linux.
> >
> > As other "rework" of gpio code depends on it (use dm) - I would
> > like to postpone my work until this functionality is available in
> > mainline (and hence avoid "temporal solutions").
> >
> > --
> > Best regards,
> >
> > Lukasz Majewski
> >
> > --
> > Nabla Software Engineering GmbH
> > HRB 40522 Augsburg
> > Phone: +49 821 45592596
> > E-Mail: office@nabladev.com
> > Geschftsfhrer : Stefano Babic =20



--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
