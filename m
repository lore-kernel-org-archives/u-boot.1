Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28390C369A5
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BBBA82CAE;
	Tue,  8 Apr 2025 16:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KkEESEQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7541382CAE; Tue,  8 Apr 2025 16:27:05 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A96E820AA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c7e5fb8c38so3452899fac.1
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744122421; x=1744727221; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V/qQs6z03S/Hpx4hCkkM8+GJOBL5Hno3igfzFC2solQ=;
 b=KkEESEQBkPdlLANjUFAkypFF29+C/vhLwVoU/um1RA3TPdu/7pAkQrGOLza9CRWRjn
 +0v8OuI1BWUoJqEUONVikAZ4+hODSFmsWEnpjBCZXcZwZOMDz52fWDjAot+AKUIqUBvP
 6cglSWcxCyAFy+562jKnKMBUNRIocOyGmPqRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744122421; x=1744727221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/qQs6z03S/Hpx4hCkkM8+GJOBL5Hno3igfzFC2solQ=;
 b=oMywYcl1VW1GQmIDK3AZoxszB/rQgJMV0b8zRPPIFbCT6lXvS9VJzqk5sBKQy7Gj30
 l6EVNKZiNEKXPPk+QJoAO1D63+55u4gGJQYPIqti1MxK3MymQgfj/O6IttlAdOPBW3AN
 qfTk4g+S38j99h1+ECp/GJr23hlX8XlRVqvF7JvO83VFxm2Mi2RIO9rmAj2HnB/b3dHZ
 0iqT21aWgCkFgNKXrfG2g66MCp6ljdXuC0UaviEMe46co+PWRV1JFLweyEfb/iPQso+6
 uuByvdVVKXervgNKnfXih1MNCgU5rCV4zCg1wFm7UmzybZ4knwu47mFCA/1k10bmzY5o
 rnZw==
X-Gm-Message-State: AOJu0YygM2AtBlpcBl5fdqSvUkeCOGZJubz9LmkUPvV2se4he9hMoSZr
 kCDZYqnA1uEnUifrDxVs7OVUbfk+2dRv5oexnUx0+kUnohEVERp+lhbQrG1Lehc=
X-Gm-Gg: ASbGncuI9fe8fRtR4QNhfOAkNSrOtIBFQM8tMuddsLysnKXVLnJP79GE/QgfyR1Dzty
 6poucAVlMP0Ty99voyF4hr6rwsPOGmCIfzHuNjaKMiZ4CrVYkIlxOjEE5C6ynL5VkIJwU2jduLq
 zaOUd1BMlwR5x3CQ97mONxzWUfccda2UBPx65+LvxhK9+b5JA0EY3b/05xaqVpiMoBkYc963oOF
 lOnCYZBWu14MfgbUZMzGFrP7jUu2ITgPKqGVTFRTaS4Z1jMwE2XwFugPT+ZsEXwN+q0lFAzcpPR
 zkuEnlm7wFIr0KD+v7k1YDK0oHVwra/Sy8HmLbGTuxYaEKDD6+zjSBv3Z6a+06OGt2ZISl9rXn8
 uEjxFNg==
X-Google-Smtp-Source: AGHT+IFAaf0N01gxNEOdPklv7jkxC+whyPsBstj5dof87ZRjgfHUwMq6uOnjdtO1sBr6BSxMlOhoDQ==
X-Received: by 2002:a05:6871:22cb:b0:2b8:306f:c5b5 with SMTP id
 586e51a60fabf-2cd32e21919mr7593128fac.7.1744122421141; 
 Tue, 08 Apr 2025 07:27:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e6526ed82sm464207a34.59.2025.04.08.07.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 07:27:00 -0700 (PDT)
Date: Tue, 8 Apr 2025 08:26:57 -0600
From: Tom Rini <trini@konsulko.com>
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 "Meng, Tingting" <tingting.meng@altera.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@altera.com>,
 "Lim, Jit Loon" <jit.loon.lim@altera.com>,
 "Tang, Sieu Mun" <sieu.mun.tang@altera.com>
Subject: Re: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
Message-ID: <20250408142657.GX5495@bill-the-cat>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
 <SA1PR03MB6370C3D360FC1E92B4766F3CF7B52@SA1PR03MB6370.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pVoMxKzNBxqv8fgO"
Content-Disposition: inline
In-Reply-To: <SA1PR03MB6370C3D360FC1E92B4766F3CF7B52@SA1PR03MB6370.namprd03.prod.outlook.com>
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


--pVoMxKzNBxqv8fgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 08:14:46AM +0000, Maniyam, Dinesh wrote:

> Hi Tom Rini,
>=20
> > -----Original Message-----
> > From: Maniyam, Dinesh
> > Sent: Monday, 24 March 2025 4:40 pm
> > To: u-boot@lists.denx.de
> > Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> > Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Dario
> > Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> > <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> > Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> > <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> > Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> > <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebasti=
an
> > Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> > <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> > Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> > <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> > Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad
> > Hazim Izzat <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> > <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> > Subject: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
> >=20
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >=20
> > This patchset add Synopsys MIPI I3C Driver support for Intel Agilex5 de=
vices.
> >=20
> > The i3c driver is leveraged from the master/dw-i3c-master.c, i3c/device=
=2Ec and
> > i3c/master.c Linux version 6.6.37 LTS And few header files included to =
be part of
> > the migration; i3c/internals.h, include/linux/i3c/ccc.h, include/linux/=
i3c/device.h
> > and include/linux/i3c/master.h.
> > Additional i3c uclass driver and command files added to support i3c rea=
d and
> > write in U-Boot.
> >=20
> > Patch status:
> >=20
> > Detail changelog can find in commit message.
> >=20
> > v3->v2:
> > --------
> > - Squash commit 10 to commit 9
> > - Resolve index for new files to pass the checkpatch
> >=20
> > Commit: sandbox_defconfig: Enable configs for sandbox i3c
> > Commit: agilex5_defconfig: Enable i3c configs for agilex5
> > - use savedefconfig
> >=20
> > drivers: Enabled Kconfig and Makefile for i3c support
> > - Add maintainer for i3c
> >=20
> > drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> > - Add empty lines for if/endif
> >=20
> > drivers: i3c: Add i3c sandbox simple test.
> > - Removed DECLARE_GLOBAL_DATA_PTR
> >=20
> > v1->v2:
> > --------
> > Reorder commits.
> >=20
> > Added commits:
> > - drivers: i3c: Add i3c sandbox simple test.
> > - test: cmd: Add simple test for i3c
> > - configs: sandbox_defconfig: Enable configs for sandbox i3c
> > - configs: agilex5_defconfig: Enable i3c configs for agilex5
> >=20
> > History:
> > --------
> > [v1]:
> > https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-
> > dinesh.maniyam@intel.com/
> > [v2]:
> > https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-
> > dinesh.maniyam@altera.com/
> >=20
> > Dinesh Maniyam (12):
> >   drivers: i3c: Add new i3c uclass id
> >   drivers: i3c: Add driver for MIPI DWI3C
> >   drivers: i3c: Add i3c uclass driver.
> >   drivers: Enabled Kconfig and Makefile for i3c support
> >   drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> >   drivers: i3c: Add i3c sandbox simple test.
> >   drivers: i3c: master: Enable probe i3c without slave device
> >   i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
> >   cmd: Add i3c command support.
> >   test: cmd: Add simple test for i3c
> >   configs: sandbox_defconfig: Enable configs for sandbox i3c
> >   configs: agilex5_defconfig: Enable i3c configs for agilex5
> >=20
> >  MAINTAINERS                        |    7 +
> >  arch/sandbox/dts/test.dts          |    8 +
> >  cmd/Kconfig                        |    6 +
> >  cmd/Makefile                       |    1 +
> >  cmd/i3c.c                          |  193 +++
> >  configs/sandbox_defconfig          |    4 +
> >  configs/socfpga_agilex5_defconfig  |    3 +
> >  doc/usage/cmd/i3c.rst              |   98 ++
> >  drivers/Kconfig                    |    2 +
> >  drivers/Makefile                   |    1 +
> >  drivers/i3c/Kconfig                |   27 +
> >  drivers/i3c/Makefile               |    5 +
> >  drivers/i3c/device.c               |  262 ++++
> >  drivers/i3c/i3c-uclass.c           |   38 +
> >  drivers/i3c/internals.h            |   26 +
> >  drivers/i3c/master.c               | 2072 ++++++++++++++++++++++++++++
> >  drivers/i3c/master/Kconfig         |   11 +
> >  drivers/i3c/master/Makefile        |    3 +
> >  drivers/i3c/master/dw-i3c-master.c | 1058 ++++++++++++++
> >  drivers/i3c/sandbox_i3c.c          |   56 +
> >  include/dm/device.h                |    2 +
> >  include/dm/uclass-id.h             |    1 +
> >  include/dw-i3c.h                   |  252 ++++
> >  include/i3c.h                      |   67 +
> >  include/linux/i3c/ccc.h            |  385 ++++++
> >  include/linux/i3c/device.h         |  286 ++++
> >  include/linux/i3c/master.h         |  698 ++++++++++
> >  test/cmd/Makefile                  |    1 +
> >  test/cmd/i3c.c                     |   52 +
> >  test/dm/Makefile                   |    1 +
> >  test/dm/i3c.c                      |   34 +
> >  31 files changed, 5660 insertions(+)
> >  create mode 100644 cmd/i3c.c
> >  create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
> > drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create mo=
de
> > 100644 drivers/i3c/device.c  create mode 100644 drivers/i3c/i3c-uclass.=
c  create
> > mode 100644 drivers/i3c/internals.h  create mode 100644 drivers/i3c/mas=
ter.c
> > create mode 100644 drivers/i3c/master/Kconfig  create mode 100644
> > drivers/i3c/master/Makefile  create mode 100644 drivers/i3c/master/dw-i=
3c-
> > master.c
> >  create mode 100644 drivers/i3c/sandbox_i3c.c  create mode 100644
> > include/dw-i3c.h  create mode 100644 include/i3c.h  create mode 100644
> > include/linux/i3c/ccc.h  create mode 100644 include/linux/i3c/device.h =
 create
> > mode 100644 include/linux/i3c/master.h  create mode 100644 test/cmd/i3c=
=2Ec
> > create mode 100644 test/dm/i3c.c
> >=20
> > --
> > 2.26.2
>=20
> Please help to review the v3 of the patches.
> Thanks for your time.

Please run this through CI, see
https://docs.u-boot.org/en/latest/develop/ci_testing.html, as there are
both easy and less-easy doc failures, and then compile warnings:
https://source.denx.de/u-boot/u-boot/-/jobs/1092473

--=20
Tom

--pVoMxKzNBxqv8fgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf1MjEACgkQFHw5/5Y0
tyy9yQwAp4CnVeaclbLDuL0mGFqBpYjcuSwzMxw8CgSWxt/qEMt1lgHLS3ny1ywz
GvSGUnzZ8eMscTPlMplAWzIQ+jTHjE1GRv76N0STu7L+O5o4kd7dvm6SHVpiPgMf
UCw50HPB73aJlDChc0DPclJsgKnf+rkKck2oZvpbqSyUPontB3e9mTr9oF2wbCPd
lMrhIzu2NYqOmlItF8zJxNy4cDe/eQ1L7drzg6KEljHx7DuXV+AfIjbt29mcmZb7
6TxmckHIBGLcyn0/fxEPugH5eZGbAEU/XZUIITuVhpxQzhpEQ4sHeiEtdmpOBj/N
LE9Q8CZc93A6bwLUVF11mYQQszpp8GiqKuUMHAZnCyDXaWw05ink4uMROKqIhbpS
43/hD3nBgUcP3ogb/vDSXDprJyK5Krh1YslYJ2dcFBcLg8/UjSWOVWUEVKnjVPaH
KYpC0la6rby6JXl45K8aKfDR53zm+jus0XIUNfYNSeufXG5PeNvhXfQb74WittOd
XRvx8HGM
=qZ3b
-----END PGP SIGNATURE-----

--pVoMxKzNBxqv8fgO--
