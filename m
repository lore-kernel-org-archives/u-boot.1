Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D555BCCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 07:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED3A7809A5;
	Mon,  6 Oct 2025 09:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="VUC1lss2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A028206E; Mon,  6 Oct 2025 09:15:33 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C587807B1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 09:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B8F9F101CBC; Mon,  6 Oct 2025 09:15:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759734928;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=RfDJ1yd6BPrbwcHvaZ5+L92YKM0rN4PXh+L/DkTPxxs=;
 b=VUC1lss26txuHF0cqb2sVtnjWDYGgkBWqFhClN8rgkn5SArX/r8qkiMyhEixQQehBGZcB9
 xOtM9wMN6AH3SVFDvAPNWw4OGQr9grUAKBnSMeaJkooA7q+DBbVRbQSNjOfXfSDE8c6I1j
 7VG1ateiPFGKXCTpWogSQDBfHUXrwrII9cz3rnTd8X6yr4wNrh+GczITYUaQkUOGLZHZRy
 1XXP4UZMJ7vTCduV8Nyj4IP7iD6gSfk3zgPpcXAPbzBZW2K8uHtesbY4nD4I06RII+x74z
 yzh4cKWYXEEXaz1Yb1pvvayc+fC5jLHhO6MSdCkxM5Nspun9SNyDvdOFSQfsNg==
Date: Mon, 6 Oct 2025 09:15:25 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] arm: gpio: Add set_flags callback to the Tegra gpio
 driver
Message-ID: <20251006091525.04cecc64@wsk>
In-Reply-To: <CAPVz0n0wU8e_PBQ7V9_6pQam20WKv9PYhFfr8F+nXb-mSKRztQ@mail.gmail.com>
References: <20250922141617.225861-1-lukma@nabladev.com>
 <CAPVz0n2iw7xZWFH46=fF3aPRjwx5QvQ0=yxY=v4tusNBj3qMvw@mail.gmail.com>
 <20250929092338.08d6b00a@wsk>
 <CAPVz0n3mm=84C25tDXxGaXbe_Dxygc+kSoADtx3NvhZoanX=LQ@mail.gmail.com>
 <20250929122201.7215f650@wsk>
 <CAPVz0n0wU8e_PBQ7V9_6pQam20WKv9PYhFfr8F+nXb-mSKRztQ@mail.gmail.com>
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

> =D0=BF=D0=BD, 29 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:22 =
=C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> > =20
> > > =D0=BF=D0=BD, 29 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:2=
3 =C5=81ukasz Majewski <lukma@nabladev.com>
> > > =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > >
> > > > Hi Svyatoslav,
> > > > =20
> > > > > =D0=BF=D0=BD, 22 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE =
17:16 Lukasz Majewski
> > > > > <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > > > >
> > > > > > This patch adds support for the .set_flags callback.
> > > > > > For now following flags are supported:
> > > > > > - GPIOD_IS_AF (i.e. "alternate function").
> > > > > > - GPIOD_IS_IN
> > > > > > - GPIOD_IS_OUT
> > > > > >
> > > > > > Currently, the .set_flags in gpio-uclass.c (function
> > > > > > dm_gpio_set_value()) is used before .set_value callback, so
> > > > > > functionally replaces it. As a result the corresponding
> > > > > > tegra_gpio_set_value() can be removed.
> > > > > >
> > > > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > > > ---
> > > > > >
> > > > > > Changes for v2:
> > > > > > - Fix the format specifier for flags in debug() function
> > > > > > - Update commit message
> > > > > > - Remove tegra_gpio_set_value() method (as it is
> > > > > > functionally replaced by set_value()
> > > > > > - Prevent from returning errors when flags =3D 0 (problem with
> > > > > > e.g. I2C GPIO support)
> > > > > > ---
> > > > > >  drivers/gpio/tegra_gpio.c | 39
> > > > > > +++++++++++++++++++++++---------------- 1 file changed, 23
> > > > > > insertions(+), 16 deletions(-) =20
> > > > >
> > > > > Lukasz, thank you for this change I would really like to see
> > > > > it in mainline. ATM I have no capabilities to debug =20
> > > >
> > > > You mean test if it works?
> > > > =20
> > > > > this and I will return
> > > > > to it but that may not be soon unfortunately. =20
> > > >
> > > > This is a bit problematic for me, as:
> > > >
> > > > 1. Some future work depends on it (more details below).
> > > > 2. The "set_flags()" callback seems like being now the one to be
> > > > advised to being implemented and used.
> > > >
> > > >
> > > >
> > > > Can you predict when you will be able to come back to this
> > > > task? Is this the matter of weeks or months?
> > > > =20
> > >
> > > Weeks maybe, I will try to look into this when I have some spare
> > > time=20
> >
> > Ok.
> > =20
> > > > > In case you really need
> > > > > switch GPIO back to SFIO and Linux cannot handle this, you an
> > > > > use dm_gpio_free to release gpios in board_preboot_os in the
> > > > > board as a temporary measure. =20
> > > >
> > > > Yes, this is a temporary solution - i.e. dm_gpio_free() is
> > > > supposed to "free" the pin. IMHO, the set_flags() shall be
> > > > used, as I in fact do want to set the CFG_SFIO flag, not
> > > > release the gpio.=20
> > >
> > > dm_gpio_free in tegra case calls CFG_SFIO =20
> >
> > Yes, but as you said - this is not the "proper" solution.
> > =20
> > > =20
> > > > >
> > > > > Overall issue you are describing is not u-boot's it is
> > > > > kernels, kernel must reconfigure gpios for proper work
> > > > > regardless of their previous state. If it is not the case,
> > > > > then kernel device configuration is incomplete or wrong. =20
> > > >
> > > > This is how the pinmux in Linux for Tegra is written. You can
> > > > setup the PAD parameters, but you cannot set the pin's function.
> > > > =20
> > >
> > > WDYM? Tegra30+ has per-pin configuration, this includes FUNCTION,
> > > direction, tristate and pull for all pins =20
> >
> > With DTS pinmux description, you cannot change the PAD function
> > (special vs gpio) in Linux. It is assumed that bootloader would set
> > the function (which, yes, is IMHO a bug).
> > =20
> > > =20
> > > > In other words - you have to do it in bootloader (u-boot in this
> > > > case).
> > > >
> > > > In my case - customer uses the pin in u-boot as GPIO to check
> > > > carrier board version, then the same pin in Linux is going to be
> > > > used as special function one.
> > > >
> > > > Unfortunately, above "reconfiguration" cannot be done in Linux.
> > > >
> > > > As other "rework" of gpio code depends on it (use dm) - I would
> > > > like to postpone my work until this functionality is available
> > > > in mainline (and hence avoid "temporal solutions").
> > > >
> > > > --
> > > > Best regards, =20
>=20
> Try this
> https://source.denx.de/u-boot/custodians/u-boot-tegra/-/commit/d95d942b6e=
796429342845d153d95330f5257cdd
> I have combined your v1 and v2 and added a few tweaks. It works on
> star and olympus (tegra20), p895 and grouper (tegra30), tegratab and
> tf701t (tegra114) and mocha (tegra124).

I've tested it on Colibri T30. No issues observed.

Thanks for your tweaks.

Please add mine:
Tested-by: =C5=81ukasz Majewski <lukma@nabladev.com>


--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
