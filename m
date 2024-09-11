Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFB0EE57C1
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 16:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2F8892CA;
	Wed, 11 Sep 2024 18:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YU+bjpN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A9F888CA8; Wed, 11 Sep 2024 18:25:12 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E987892CA
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7a7f8b0b7d0so613985a.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726071908; x=1726676708; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x9aeOgN8xMtMgMDmTT/h3ulinJsjS4y8oC1yyzYlb38=;
 b=YU+bjpN+ZEcVqUvl2M+ampYtc7t7/F2jpe8GaJCmquwstL5to5wK877oHTGJOmqCXQ
 0XKOa0bNN8qtvQK+7iLXU0VLXVfTs96DEcguhXCanL5ocDlAHINxr5bPkb2PjH43I4Pz
 1qe9+aVaaziltKCjTlOgW6j2FgK8retietkUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726071908; x=1726676708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9aeOgN8xMtMgMDmTT/h3ulinJsjS4y8oC1yyzYlb38=;
 b=V1m+KZ991fc5WGGYGGdC6dMEA3Q2Xhk8g2iTh8zy9EHF1/B5CTwAIgR/P08XPUIg/V
 xSbQgqR6yBVZFwcyX80j42ZRlXCUJd20NhPbYaijStVAImXNEiRvPZTergQ5lUoYYFTz
 Lr3FsdQtepGwuMR8CB1W+A53qQTDllu9x6cgGTcO54eGfSuIOvcr0XP41M5ZyNwO5Vxx
 3H0Opo8Gey7dL9G0iSy+pk2jgDY4iqX01P8IU5oEYd+Uvor2AbrSGz9Iu8FXqYXNPHfv
 9Pd+LJaMbe/rij5YvQM5XSSkyAmY20OHd1zbUnI2r+LcYSHwgQpbPlY7i+/BU9eqzfPC
 EUCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVimh10YvwJo9BRvZ24dGczkg7GhvqKE9OcNP24VWigGkWtSEktyUlcdasBqb52JeBpJsVwbiU=@lists.denx.de
X-Gm-Message-State: AOJu0YxnhVlwUBGDM0ngiOvnIVsGtaKIcFdj65fej4+r9xY9hdcrXmv0
 An8eEYSoiTUfZBiozxHSN7tFU0lpPF98uGD3+hdi+9MiL/MImhzAYn3lFxwJFUw=
X-Google-Smtp-Source: AGHT+IHgCATOhfD2w17tP2+icZgruUKYgHQ8g2cQhzGDqI5oAhF+y/wid/ws1zpD53j5nlOs9m9k2w==
X-Received: by 2002:a05:620a:1a1e:b0:7a9:a3e3:7270 with SMTP id
 af79cd13be357-7a9a3e3a396mr2482949485a.62.1726071907923; 
 Wed, 11 Sep 2024 09:25:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e7f569sm42725791cf.31.2024.09.11.09.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:25:07 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:25:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
Message-ID: <20240911162503.GQ4252@bill-the-cat>
References: <CAPVz0n3Ji1sKQK+Lnq8rP3ZqwX3o-kXe2btj93UuVBa3T5C=qw@mail.gmail.com>
 <eced1020-2157-44a4-98a9-845e218529d9@denx.de>
 <45c74c58-98cf-43df-b837-c48b0341c551@denx.de>
 <CAPVz0n2-DCKDcVrAi00kF6yDcE2bN1mtUhzBcw7JDiZoXgzu0w@mail.gmail.com>
 <e5837ce4-0a14-4822-960d-6ab667a9f4b1@denx.de>
 <CAPVz0n323ktF6kb3WHR9JcE+xOzQr9-aWOR47+ZvwQr=ib18rg@mail.gmail.com>
 <f778366b-bdaf-415d-a94e-c995f62e8c71@denx.de>
 <CAPVz0n0ru1rPb9SNw515mkwfs4=nNSOPjZY74JVkqnGbEouSLQ@mail.gmail.com>
 <cfc1a158-6c35-4288-aed0-fcc78a8db832@denx.de>
 <CAPVz0n1Vh7Vgnt8_Lx6U8p42QvtVnHB9yvb=RmjYrS=w1G3u1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="esSR2Cp/8Y/3KA2m"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1Vh7Vgnt8_Lx6U8p42QvtVnHB9yvb=RmjYrS=w1G3u1A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--esSR2Cp/8Y/3KA2m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 02:12:12PM +0300, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 11 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 14:01 Ma=
rek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On 9/11/24 7:57 AM, Svyatoslav Ryhel wrote:
> >
> > [...]
> >
> > >>>> You did mention something regarding I2C/PMIC driver probe timing, =
but it
> > >>>> seems the I2C driver and PMIC drivers probe roughly around the sam=
e time
> > >>>> in both pass and fail cases ?
> > >>>
> > >>> Yes, here I agree that they both probe and probe passes, but I assu=
me
> > >>> timing of i2c call is critical and there may be some dependency whi=
ch
> > >>> is not ready.
> > >>
> > >> My guess would be pinmux or clock, maybe the i2c controller is marke=
d as
> > >> bootph-* in DT and its pinmux/clock is not? Maybe the i2c on tegra w=
orks
> > >> by sheer coincidence right now? Can you have a look?
> > >
> > > Power i2c line (one that hosts PMIC) is configured extremely early in
> > > SPL since it is needed for cpu and core voltage setup so even if, as
> > > you say, tegra works by sheer coincidence, specifically this i2c line
> > > should work non the less, since it has all its pre-requisites (clock
> > > and pinmux) configured on early stage.
> >
> > Is it possible that this configuration is somehow reset or reconfigured
> > from DT early on in U-Boot proper ?
>=20
> No
>=20
> > Do you have serial console output in board_f.c time in U-Boot proper ,
> > possibly using DEUBG_UART , to check if there might be some prior
> > failing I2C transfer at that board_f.c time ?
>=20
> Haven't spotted anything weird there.
>=20
> > > As I have told, I was not able to determine exact reason why this
> > > happens, it should not and yet it does. This is why I have abandoned
> > > my attempt to implement same changes you are currently proposing.
> >
> > If tegra has a problem, it should be fixed on tegra side and not block
> > core plumbing. I am not seeing the problem on stm32 or imx systems, so I
> > am banking toward tegra-specific issue.
> >
>=20
> And yet you are pushing tegra breaking stuff. I will insist on
> reverting this is it passes.
>=20
> > Are you able to debug this ?
>=20
> No, I am not able find exact cuse of this behavior.

How do you propose we resolve this then, Svyatoslav? I threw this patch
at some TI platforms as well and they're all fine. Are you unable to get
some early debuging information out like Marek was asking? Thanks.

--=20
Tom

--esSR2Cp/8Y/3KA2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbhxFsACgkQFHw5/5Y0
tyw71wwAn/baxpBRJxptF4uekpATAo24mWw9w0JoKRSdXSBVgNui+btFcvkyQ1X/
VtJHwJWtem9hhKeIqbbYyQNVjb5dN1brT7ORRtBDN5cXtzTSG6Ylj+pd1ORs73bu
oHitL2pffneo+8ful/SkqOa8xTpaMZlNV/fb5hYf4gOrWNt++UOawM9NFG+BSK4r
PdAXmkpnNBMHBA+a8E4JcijdY2SoNsZF4YQpC+fJ7ErKB8BFx5HOd/4Sc86kmL+0
z964CJU0Rc8D/ZJT9qMvE8c2S7RImO8PXME6QiLIyfBAtG40whlQZrV5XrQqYYRU
71euKRzHE8s7PEQ3hLYlmdKYUYf5y8smAkx8+HBru4rkJylYpSBEToSH9Y7iOmKY
YGbtZgQ5rTHiegHftUXbAhMG97P9ThYUjG1XBg6VMKSVRsTBoRRkt5+DdoR1rxaY
FJrRr82pW3GWJwi4KsEnEcy1J+P7o2aXfNrtq/E6YZzuD6lO0KT8Z3VaQnWcOwOg
vzxf8SHc
=9uk4
-----END PGP SIGNATURE-----

--esSR2Cp/8Y/3KA2m--
