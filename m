Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9921C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 14:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 089D9874B7;
	Sat,  9 Dec 2023 15:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fGLXWWvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107EF87215; Sat,  9 Dec 2023 15:14:13 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F5A874B7
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 15:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dbc4df9fb11so1646946276.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702131248; x=1702736048; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3wTolmskpcAm/8p1vquNUbOXK1jhrwr1QLMxvSP9Q/s=;
 b=fGLXWWvdEAz5VjxVFJ0Md8EvLH4L3ewPNbYThfLtVob14n/SJc74aueXpDRhoABtod
 UUsq1lHIDiXqITe96aCXkBqgy+U2zHGQvubMDtbl8GQjFOLeWY50DyxobkPBrGFxLw04
 uSzZ2vJGXmiCdaL7mTJbQAS40GkjXWnaywiEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702131248; x=1702736048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wTolmskpcAm/8p1vquNUbOXK1jhrwr1QLMxvSP9Q/s=;
 b=aCXdIb+6y7+KGSnGeaSq7lHIiAbg9hO7uKBO5bE2MrqBWyTaJmSpCfdNJhUctAt6Ml
 Qf4LTNYNO9HVjrSboTz4RZjB6vSJXA12NOSqe6zmEj9FnXa6XqtUqMeoNK+OAQUx6GMg
 BfFlAWf901/LsxEWsAMJ80/ex1YNdQciBZ5jJx4S5Y61cNkV+PS43kHZqyQu0ello8zK
 wtQGFxagRvkM7ySLyihOGLxPLuFFyJV/ed0Rn8RSpYwco9w6HIrLavIJUVwnogsNy6s6
 1nNImTBslaYh6JqrawVYcZ9ETb25IrxlgEWgtR+RgAOkfyFqzTIB1j0YNMtvV1Y40kE1
 GuFA==
X-Gm-Message-State: AOJu0YyIMi1ZSRxGD5PU8cGk+y9wCHDzNpdNqb/Yv+pcL/AZRLIEHgeG
 +6uimYTzoh2SVlpDq+kDr7tlSA==
X-Google-Smtp-Source: AGHT+IH+vQvjTAyG/pR70iVVcq2ggyeVCEY24tAYWhZev3lcQDaJaROk1fFN9BgXkDkVNbVt8qnGIQ==
X-Received: by 2002:a5b:206:0:b0:db7:dacf:59d0 with SMTP id
 z6-20020a5b0206000000b00db7dacf59d0mr973776ybl.68.1702131248628; 
 Sat, 09 Dec 2023 06:14:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a5b0b05000000b00da0c63aa9f1sm1280883ybp.20.2023.12.09.06.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 06:14:08 -0800 (PST)
Date: Sat, 9 Dec 2023 09:14:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/8] Convert Tegra pinctrl to DM
Message-ID: <20231209141406.GF2513409@bill-the-cat>
References: <20231204082054.4943-1-clamor95@gmail.com>
 <ZW2pYqo6hjGqKo_-@orome.fritz.box>
 <CAPVz0n1XDNvD8G06i_qEdr3SNXwWtFfkyURp6uZbr86rbH2jQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="80vc7tJnbl287aL6"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1XDNvD8G06i_qEdr3SNXwWtFfkyURp6uZbr86rbH2jQA@mail.gmail.com>
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


--80vc7tJnbl287aL6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 04:45:38PM +0200, Svyatoslav Ryhel wrote:
> =D0=BF=D0=BD, 4 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=BE 12:=
26 Thierry Reding <treding@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, Dec 04, 2023 at 10:20:46AM +0200, Svyatoslav Ryhel wrote:
> > > Create a DM supported wrapper arround existing Tegra pinmux logic.
> > > This implementation is backwards compatible with all existing board
> > > setups and early stages of setup. All new boards must be device tree
> > > based. Linux dts pinmux nodes are fully compatible with this driver.
> > >
> > > As an example I have converted recently merged T30 boards to this
> > > layout (I have those devices and was able to test them properly) and
> > > Paz00 T20 board which was tested as well by owner.
> > >
> > > Svyatoslav Ryhel (8):
> > >   ARM: mach-tegra: rearrange SPL configs
> > >   drivers: pinctrl: create Tegra DM pinctrl driver
> > >   drivers: pinctrl: tegra: incorporate existing code
> > >   board: asus: grouper: switch to DM pinmux
> > >   board: lg: x3-t30: switch to DM pinmux
> > >   board: asus: transformer: switch to DM pinmux
> > >   board: htc: endeavoru: switch to DM pinmux
> > >   board: compal: paz00: clean up the board
> > >
> > >  arch/arm/dts/tegra20-paz00.dts                |    4 +-
> > >  arch/arm/dts/tegra30-asus-grouper-common.dtsi |  712 ++++++++++
> > >  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |  113 ++
> > >  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |  113 ++
> > >  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |  149 +++
> > >  arch/arm/dts/tegra30-asus-p1801-t.dts         |  982 ++++++++++++++
> > >  arch/arm/dts/tegra30-asus-tf201.dts           |   45 +
> > >  arch/arm/dts/tegra30-asus-tf300t.dts          |   45 +
> > >  arch/arm/dts/tegra30-asus-tf300tg.dts         |  128 ++
> > >  arch/arm/dts/tegra30-asus-tf300tl.dts         |  163 +++
> > >  arch/arm/dts/tegra30-asus-tf600t.dts          |  889 +++++++++++++
> > >  arch/arm/dts/tegra30-asus-tf700t.dts          |   53 +
> > >  arch/arm/dts/tegra30-asus-transformer.dtsi    |  984 ++++++++++++++
> > >  arch/arm/dts/tegra30-htc-endeavoru.dts        | 1147 +++++++++++++++=
++
> > >  arch/arm/dts/tegra30-lg-p880.dts              |   90 ++
> > >  arch/arm/dts/tegra30-lg-p895.dts              |   93 ++
> > >  arch/arm/dts/tegra30-lg-x3.dtsi               |  845 ++++++++++++
> > >  arch/arm/include/asm/arch-tegra114/pinmux.h   |  303 +++++
> > >  arch/arm/include/asm/arch-tegra124/pinmux.h   |  327 +++++
> > >  arch/arm/include/asm/arch-tegra20/pinmux.h    |  291 +++++
> > >  arch/arm/include/asm/arch-tegra210/pinmux.h   |  394 ++++++
> > >  arch/arm/include/asm/arch-tegra30/pinmux.h    |  381 ++++++
> > >  arch/arm/mach-tegra/Kconfig                   |   16 +-
> > >  arch/arm/mach-tegra/Makefile                  |    1 -
> > >  arch/arm/mach-tegra/board.c                   |    6 +-
> > >  arch/arm/mach-tegra/board2.c                  |    2 +-
> > >  arch/arm/mach-tegra/tegra114/Makefile         |    2 +-
> > >  arch/arm/mach-tegra/tegra124/Makefile         |    2 -
> > >  arch/arm/mach-tegra/tegra20/Makefile          |    2 +-
> > >  arch/arm/mach-tegra/tegra210/Makefile         |    1 -
> > >  arch/arm/mach-tegra/tegra30/Makefile          |    2 +-
> > >  board/asus/grouper/grouper.c                  |   18 -
> > >  board/asus/grouper/pinmux-config-grouper.h    |  362 ------
> > >  .../pinmux-config-transformer.h               |  365 ------
> > >  board/asus/transformer-t30/transformer-t30.c  |   23 -
> > >  board/compal/paz00/Makefile                   |    8 -
> > >  board/compal/paz00/paz00.c                    |   53 -
> > >  board/htc/endeavoru/endeavoru.c               |   14 -
> > >  board/htc/endeavoru/pinmux-config-endeavoru.h |  362 ------
> > >  board/lg/x3-t30/Kconfig                       |   12 -
> > >  board/lg/x3-t30/configs/p880.config           |    1 -
> > >  board/lg/x3-t30/configs/p895.config           |    1 -
> > >  board/lg/x3-t30/pinmux-config-x3.h            |  449 -------
> > >  board/lg/x3-t30/x3-t30.c                      |   23 -
> > >  configs/paz00_defconfig                       |    3 +
> > >  drivers/pinctrl/Kconfig                       |    1 +
> > >  drivers/pinctrl/Makefile                      |    1 +
> > >  drivers/pinctrl/tegra/Kconfig                 |   18 +
> > >  drivers/pinctrl/tegra/Makefile                |   16 +
> > >  .../pinctrl/tegra/funcmux-tegra114.c          |    0
> > >  .../pinctrl/tegra/funcmux-tegra124.c          |    0
> > >  .../pinctrl/tegra/funcmux-tegra20.c           |    0
> > >  .../pinctrl/tegra/funcmux-tegra210.c          |    0
> > >  .../pinctrl/tegra/funcmux-tegra30.c           |    0
> > >  drivers/pinctrl/tegra/pinctrl-tegra.c         |  248 ++++
> > >  drivers/pinctrl/tegra/pinctrl-tegra20.c       |  177 +++
> > >  .../pinctrl/tegra}/pinmux-common.c            |    0
> > >  .../pinctrl/tegra/pinmux-tegra114.c           |    0
> > >  .../pinctrl/tegra/pinmux-tegra124.c           |    0
> > >  .../pinctrl/tegra/pinmux-tegra20.c            |    0
> > >  drivers/pinctrl/tegra/pinmux-tegra210.c       |  190 +++
> > >  .../pinctrl/tegra/pinmux-tegra30.c            |    0
> > >  include/configs/x3-t30.h                      |   13 +-
> > >  63 files changed, 8920 insertions(+), 1723 deletions(-)
> >
> > So we're adding 7000 extra lines here just to get the same level of
> > functionality? Do we really want this?
>=20
> Tom, as a project maintainer, may you answer? Does U-Boot really want
> this? And ensure there will never ever be a forced pinmux DM
> migration.
>=20
> >
> > For things like the kernel this makes a bit more sense because we can
> > have generic kernel images for a wide variety of boards, and
> > additionally we can have dynamic reconfiguration of the pinmux at
> > runtime. We have neither of those in U-Boot, so do we really need to
> > move all this into DT and add this extra overhead?
>=20
> There would not be so much overhead if Linux kernel used numbers for
> pin definitions, not strings.

Well, yes, this is the right direction. One of the goals is to be able
to use the linux device trees as-is and be able to pass that along to
the OS to use. And so we move a little away from the absolute thinnest
case that we used to be and a bit more towards a generic case just like
Linux did. In some cases, one can just change the device tree passed to
U-Boot and re-use the same binary. And if Tegra platforms moved in that
direction that's nice too.

--=20
Tom

--80vc7tJnbl287aL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0di4ACgkQFHw5/5Y0
tyw0zAv/XVSgxesrCwEk6SDV+KRp2fbULzJupNwgJcQWp5avKO0virHFAXQBfVYZ
nppvffM/4iMV/3DhQs3oWyDT8OUzEGarQl4wDqgrAf/wh7r42TDSGpTZU/1Cmhsy
fgmft4VZIHoBHP6QbwyfBttPq2e9c3e7P9TRiJzQ0ja2c3473iz7n4GsEHR5yCh1
Ld+ZO2X/6At74pktluF9oyjOKPN9C5N1heVCWo0oxH62h/pZ5XYFTKAb1brR6scg
CejP+XHB4TIGcMRPr98iRAZfle6vBWRnqP6mITENefE73S6ldek/jTMq67Cv+y7h
vNCsfXQEVMwvCMz2uV2T/5jZXSxfXF9HcdOxmlVPoXUzJJYB9Ejok1NFXwBlwYty
uiSBTZbJ/ejUvfgY+JYrUMQsSXm4aDtxqDv0Hmp8/cq6dAgkh9gwwDaAZOZlLDsH
NrOLPIJudMGCDxmHQRCuYk7jv9vLcPQ8ptBn20HTGwYeRVUipwaumJ3p5SnjvZwJ
pnpWnp7W
=gfad
-----END PGP SIGNATURE-----

--80vc7tJnbl287aL6--
