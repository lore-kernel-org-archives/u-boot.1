Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECDEC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8901684114;
	Fri, 11 Apr 2025 16:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NJGNK8rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9148410B; Fri, 11 Apr 2025 16:52:48 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FF884127
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c7b2c14455so1237970fac.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744383164; x=1744987964; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q7hx+DMk0kQYihsWvakMW0Encqc8VLdtJW8xN+rpFPc=;
 b=NJGNK8rvDxBaEpDX7kBsLrhA2EgX6IQjBduDN1R24c32UPveXz7eO26G1xcmjHL7nU
 hrovIzLjiX8We4w0nHLj7lN9dvBQjTn0gsQeJP4D9EwSNCDMJw21fIrZfrycVau+kExH
 UkEGluHJonAZ6ZaQFS7lG9U/zUH4B0waYh4tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383164; x=1744987964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7hx+DMk0kQYihsWvakMW0Encqc8VLdtJW8xN+rpFPc=;
 b=vKlDDzLeb75Syf0mgis6rXN9t9TSKrbrzWyLLAX5X1FwJFpHRjrcgBCb9KYaS1TWJm
 9hNarvZsyN8uS5w8vCGZ0TiZRTTdWvHEBYnL1iEA1LxV9HTICq4pCtWMTtjQog/LbkkT
 FMc64Vbx31QIJv4k/m2wj54cmOBgJvCQPFH6IPiVyTSWikg1+sBaUFFPJ+pnqTORGWOC
 IExnpUHTDL/KpkvW7noba0EmymKyG4E33Bu7aOwvYNRLKE7fnEcxCmyPOvM+5Ljoii1h
 c7p3lXluhPxOcu8/UPLsRZ27Oc77ZXb9LAvw1lAmUkB6X/96HYjwI3I6WhnlIXqYgZRO
 ZDFQ==
X-Gm-Message-State: AOJu0YwvSPvi0Rv0d3w+Djwr1K/qN+Kmvi+3MDaZg9/trbyMpZukPsAW
 4PUro0/SSwt+ZrK2VhfL6qBL3CYOlmmS76Zqn5RZUWAVH0sq1k/1d7htvTmlxyU=
X-Gm-Gg: ASbGncvLVTaX2Y5WevzFW3Hc1FTv3UX8dqwewZ8GeTqZ+q0s8v5vAkYObQ+6YXTxxu8
 mxdW+UBZVUHtbXw4+IL1mlAnHcg2N9S8XoPu2H2xjLmJ9ukF8keoXoqJ+O0m+nbQanzVYLy68DQ
 z7T57+/a7oDW0zGxvQcAeMZCDWijwfjRHkUurbeZR00cmrXewWC3hHQ2j/0NUnKCeLhwFdww2Ow
 cVUD5syAnamSz/UlE5HX5aqYmcUtz5u08pC5MWxL/TRcX57zByNzobUwa3BC3LQECSTiAnKlK2O
 xhFz0lP3GiS54ANXjTqNVyPXKeRTJhttwYuzr1exbBONBeiIhS71FhZCZqwSKMVSlUZSc0SfCrv
 BTw==
X-Google-Smtp-Source: AGHT+IF/IC2PA4Po5qMnpZroV68xnfxUW6JxR2JJ5v6EIwqXjJRURNfB+GFzyO0osW/leXsCI0n3tQ==
X-Received: by 2002:a05:6871:a90d:b0:2c2:5579:7c10 with SMTP id
 586e51a60fabf-2d0d5cc6d33mr1785862fac.9.1744383163669; 
 Fri, 11 Apr 2025 07:52:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73e4d4a4sm962499a34.42.2025.04.11.07.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:52:43 -0700 (PDT)
Date: Fri, 11 Apr 2025 08:52:40 -0600
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
Message-ID: <20250411145240.GO5495@bill-the-cat>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
 <SA1PR03MB6370C3D360FC1E92B4766F3CF7B52@SA1PR03MB6370.namprd03.prod.outlook.com>
 <20250408142657.GX5495@bill-the-cat>
 <SA1PR03MB637095CF17776E7274561E5FF7B62@SA1PR03MB6370.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n1wKcPrkEGTRKCGI"
Content-Disposition: inline
In-Reply-To: <SA1PR03MB637095CF17776E7274561E5FF7B62@SA1PR03MB6370.namprd03.prod.outlook.com>
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


--n1wKcPrkEGTRKCGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 07:00:16AM +0000, Maniyam, Dinesh wrote:
>=20
>=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Tuesday, 8 April 2025 10:27 pm
> > To: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> > Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> > <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Dario
> > Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> > <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> > Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> > <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> > Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> > <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebasti=
an
> > Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> > <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> > Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai
> > <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> > <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> > <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> > <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> > Subject: Re: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
> >=20
> > On Tue, Apr 08, 2025 at 08:14:46AM +0000, Maniyam, Dinesh wrote:
> >=20
> > > Hi Tom Rini,
> > >
> > > > -----Original Message-----
> > > > From: Maniyam, Dinesh
> > > > Sent: Monday, 24 March 2025 4:40 pm
> > > > To: u-boot@lists.denx.de
> > > > Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> > > > Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Dario
> > > > Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org>; Heinrich Schuchardt
> > > > <xypron.glpk@gmx.de>; Jerome Forissier
> > > > <jerome.forissier@linaro.org>; Mattijs Korpershoek
> > > > <mkorpershoek@baylibre.com>; Ibai Erkiaga
> > > > <ibai.erkiaga-elorza@amd.com>; Michal Simek <michal.simek@amd.com>;
> > > > Dmitry Rokosov <ddrokosov@salutedevices.com>; Jonas Karlman
> > > > <jonas@kwiboo.se>; Sebastian Reichel
> > > > <sebastian.reichel@collabora.com>; Meng, Tingting
> > > > <tingting.meng@altera.com>; Chee, Tien Fong
> > > > <tien.fong.chee@altera.com>; Hea, Kok Kiang
> > > > <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> > > > <dinesh.maniyam@altera.com>; Ng, Boon Khai
> > > > <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> > > > <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> > > > <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> > > > <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> > > > Subject: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
> > > >
> > > > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> > > >
> > > > This patchset add Synopsys MIPI I3C Driver support for Intel Agilex=
5 devices.
> > > >
> > > > The i3c driver is leveraged from the master/dw-i3c-master.c,
> > > > i3c/device.c and i3c/master.c Linux version 6.6.37 LTS And few
> > > > header files included to be part of the migration; i3c/internals.h,
> > > > include/linux/i3c/ccc.h, include/linux/i3c/device.h and
> > include/linux/i3c/master.h.
> > > > Additional i3c uclass driver and command files added to support i3c
> > > > read and write in U-Boot.
> > > >
> > > > Patch status:
> > > >
> > > > Detail changelog can find in commit message.
> > > >
> > > > v3->v2:
> > > > --------
> > > > - Squash commit 10 to commit 9
> > > > - Resolve index for new files to pass the checkpatch
> > > >
> > > > Commit: sandbox_defconfig: Enable configs for sandbox i3c
> > > > Commit: agilex5_defconfig: Enable i3c configs for agilex5
> > > > - use savedefconfig
> > > >
> > > > drivers: Enabled Kconfig and Makefile for i3c support
> > > > - Add maintainer for i3c
> > > >
> > > > drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> > > > - Add empty lines for if/endif
> > > >
> > > > drivers: i3c: Add i3c sandbox simple test.
> > > > - Removed DECLARE_GLOBAL_DATA_PTR
> > > >
> > > > v1->v2:
> > > > --------
> > > > Reorder commits.
> > > >
> > > > Added commits:
> > > > - drivers: i3c: Add i3c sandbox simple test.
> > > > - test: cmd: Add simple test for i3c
> > > > - configs: sandbox_defconfig: Enable configs for sandbox i3c
> > > > - configs: agilex5_defconfig: Enable i3c configs for agilex5
> > > >
> > > > History:
> > > > --------
> > > > [v1]:
> > > > https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.5005
> > > > 1-1-
> > > > dinesh.maniyam@intel.com/
> > > > [v2]:
> > > > https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.4362
> > > > 1-1-
> > > > dinesh.maniyam@altera.com/
> > > >
> > > > Dinesh Maniyam (12):
> > > >   drivers: i3c: Add new i3c uclass id
> > > >   drivers: i3c: Add driver for MIPI DWI3C
> > > >   drivers: i3c: Add i3c uclass driver.
> > > >   drivers: Enabled Kconfig and Makefile for i3c support
> > > >   drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> > > >   drivers: i3c: Add i3c sandbox simple test.
> > > >   drivers: i3c: master: Enable probe i3c without slave device
> > > >   i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
> > > >   cmd: Add i3c command support.
> > > >   test: cmd: Add simple test for i3c
> > > >   configs: sandbox_defconfig: Enable configs for sandbox i3c
> > > >   configs: agilex5_defconfig: Enable i3c configs for agilex5
> > > >
> > > >  MAINTAINERS                        |    7 +
> > > >  arch/sandbox/dts/test.dts          |    8 +
> > > >  cmd/Kconfig                        |    6 +
> > > >  cmd/Makefile                       |    1 +
> > > >  cmd/i3c.c                          |  193 +++
> > > >  configs/sandbox_defconfig          |    4 +
> > > >  configs/socfpga_agilex5_defconfig  |    3 +
> > > >  doc/usage/cmd/i3c.rst              |   98 ++
> > > >  drivers/Kconfig                    |    2 +
> > > >  drivers/Makefile                   |    1 +
> > > >  drivers/i3c/Kconfig                |   27 +
> > > >  drivers/i3c/Makefile               |    5 +
> > > >  drivers/i3c/device.c               |  262 ++++
> > > >  drivers/i3c/i3c-uclass.c           |   38 +
> > > >  drivers/i3c/internals.h            |   26 +
> > > >  drivers/i3c/master.c               | 2072 ++++++++++++++++++++++++=
++++
> > > >  drivers/i3c/master/Kconfig         |   11 +
> > > >  drivers/i3c/master/Makefile        |    3 +
> > > >  drivers/i3c/master/dw-i3c-master.c | 1058 ++++++++++++++
> > > >  drivers/i3c/sandbox_i3c.c          |   56 +
> > > >  include/dm/device.h                |    2 +
> > > >  include/dm/uclass-id.h             |    1 +
> > > >  include/dw-i3c.h                   |  252 ++++
> > > >  include/i3c.h                      |   67 +
> > > >  include/linux/i3c/ccc.h            |  385 ++++++
> > > >  include/linux/i3c/device.h         |  286 ++++
> > > >  include/linux/i3c/master.h         |  698 ++++++++++
> > > >  test/cmd/Makefile                  |    1 +
> > > >  test/cmd/i3c.c                     |   52 +
> > > >  test/dm/Makefile                   |    1 +
> > > >  test/dm/i3c.c                      |   34 +
> > > >  31 files changed, 5660 insertions(+)  create mode 100644 cmd/i3c.c
> > > > create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
> > > > drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create
> > > > mode
> > > > 100644 drivers/i3c/device.c  create mode 100644
> > > > drivers/i3c/i3c-uclass.c  create mode 100644 drivers/i3c/internals.h
> > > > create mode 100644 drivers/i3c/master.c create mode 100644
> > > > drivers/i3c/master/Kconfig  create mode 100644
> > > > drivers/i3c/master/Makefile  create mode 100644
> > > > drivers/i3c/master/dw-i3c- master.c  create mode 100644
> > > > drivers/i3c/sandbox_i3c.c  create mode 100644 include/dw-i3c.h
> > > > create mode 100644 include/i3c.h  create mode 100644
> > > > include/linux/i3c/ccc.h  create mode 100644
> > > > include/linux/i3c/device.h  create mode 100644
> > > > include/linux/i3c/master.h  create mode 100644 test/cmd/i3c.c create
> > > > mode 100644 test/dm/i3c.c
> > > >
> > > > --
> > > > 2.26.2
> > >
> > > Please help to review the v3 of the patches.
> > > Thanks for your time.
> >=20
> > Please run this through CI, see
> > https://docs.u-boot.org/en/latest/develop/ci_testing.html, as there are=
 both
> > easy and less-easy doc failures, and then compile warnings:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1092473
> >=20
> > --
> > Tom
>=20
> https://github.com/u-boot/u-boot
> Cloned the repo, tried to create and push a PR with the solution.
> Thought, CI test will be triggered automatically once push the PR.
> Since I'm not a maintainer I don't have the write access to push the PR.
>=20
> Can I have access to push a PR just to trigger the CI test so that I can =
see the result?
> Or any other way to do it?

Creating a PR triggers a CI run.

--=20
Tom

--n1wKcPrkEGTRKCGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5LLgACgkQFHw5/5Y0
tyyxGgv+PhdXc2VH+Qpu9X5eGqbttqExdhbjCMs4FhlUIfpaAsZ7P0RTxC/UzcBF
mkLtygIkPywD189kR1xerzaISyn+zvXfEe/Y14vFWDIifzqj1eLmFHWDqu4cImmM
Pu+1w+rYMm0iHgFK+WU8Yxe8aB0MqlyKpQ2AmU75u+iO3OWTucX8zPhh3STWJsPU
XpSquKVsgj9uPxnqefG3NsWtwQuT4snz10Bzn5hyHxOG1S12P9ll84i/o49psOWF
NWVlGq1yiz5D0Qp5zMEgcLCeITCYz75X/jkrLapXDsfKUu52rVQ/gN9+uXBi4GMC
9au8Z43gXRw+DGuUQS0hOXGZnYQ17d96NKOGKKE09k/jBtVxcHCRe8QZ2Yt0v8W6
TWIhMHe6/YvMsm/cRPhZxhF1mF0qFwo0vRIpLxmhO7ZqETtWPgro60McFOf77xGl
ouYhEaBYGPNMPApawI3LKAtT7wtKx2HUD6nVtbM/wuQrYtl5n/v5oRli7njr7N95
NVazlT6q
=dzhD
-----END PGP SIGNATURE-----

--n1wKcPrkEGTRKCGI--
