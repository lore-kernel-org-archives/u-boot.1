Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62C9CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 15:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EAD830B4;
	Tue,  9 Sep 2025 17:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GRShv7dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32D408318E; Tue,  9 Sep 2025 17:47:17 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD328309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 17:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-31981fa3c89so4491657fac.3
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757432833; x=1758037633; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BM76ZHeiy60J9DMC3ep3wsTPtoS3UEQScetG+SNGB+Y=;
 b=GRShv7dgG4XbiiYtzYuofzFWy9hQbCuleY4kQW3KlWLpMI7lGWdiiCMSNDVsnCzG9X
 u4d+7B5W5qJynx3Z8ZuYr08hezmviLNQNBdNnU15RuzQvevQBTQ2Q3NnQKFOi2mUx+dS
 /h1di/QW8U94NRwHoly+JipVSf7TRmd70ir98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757432833; x=1758037633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BM76ZHeiy60J9DMC3ep3wsTPtoS3UEQScetG+SNGB+Y=;
 b=BNW2KRp5evXCGY9RiTM1Is+mY3qtiObIZ3wI9cw++q0k/bwVVgRWN0/Qxy1QsGIXCZ
 QMIXeekuq4QP0iTnlX0V+alNvbX5zC0thfDAfs773dhjRNvlGoqYdjnTLnWvEZ3YYIu7
 6jJ95feqvNLj3qWyNf5g+/+dpK5uKuXXcPLhbvmaADmMK03kN158Q+xp94yqYA0RTITN
 dTFqAnIUjP8p2ycuk0Zwhj4Tjntgb2f0Ahz8sw8fSMP4Zx+TkJLHpc5pAadNbwU37Vy+
 LcxeC44ELCTgcps3kjTVCX1K+HBAukgoJZGL+y3N2agRyCE88LpumMmQT1B0WH/0a6b/
 8riA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBPg9aOnl4rfRfDbizX6PUDbVQ68YVW0j6uX9bFR9cdIW9gSHNUPZ00PFDgEUaW/7lkYoVnLA=@lists.denx.de
X-Gm-Message-State: AOJu0YyMJdSJBV8gWTdfP1rrKa54NUW/MaCZ4W7OB/mdEUVOsE+g5oDA
 YDleAto4EPi+2yuBQmOOAYT1CsHYF1CKXYg2u6ubcA1wH4T+gM/8vDD/WO1QSm2lCyQ=
X-Gm-Gg: ASbGncshNS6A33aVPqiqyrjDWUYytIMqazQ2z/9oncLuioGvZ17sCY0Oh+eU9N3teSv
 y9WDyFWMzfjMiccqp9+J0qMlvScY892BJ82wXdiwf9L8XDpD7tyKkaMsgtpZ7YUsZMGtwQPExWH
 w2Cl2HJKT5+Ht6sW+JZoFu2D4AgfIp37zyrGk+LVFs2d5K1haRkzBA2JXbdU0RquvQ/N5tnqkha
 dH/yXj8jkrZVdeDGAh9+Ku2zoIdktsDxX/ZVLf2dStusSL4/nYCT9JOP0gw4FTa9xSHa2P6JcpN
 RzZZhJsf5qqufc9StLxqW9zOuHitHmO3C6R82z9wkBM7qafIqjh+xHQMG4b/eywhc7nxq1wz/Yb
 P7eufFiG2i1C04VTW7iVpkE6lUPo9BfJZ3+q76NNjaKI3OHX7FKzyoS75DUvn3WDcBiw=
X-Google-Smtp-Source: AGHT+IFw46Z9tWNrIlX5jB61q2ylShBbzdXZ7IIU7dyO07ikXmi4UPTN81BXTehqMDnQxzMaE45T5w==
X-Received: by 2002:a05:6871:6010:b0:307:434:1aed with SMTP id
 586e51a60fabf-32262d94c77mr5334041fac.18.1757432833441; 
 Tue, 09 Sep 2025 08:47:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-319b6062719sm7497055fac.23.2025.09.09.08.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 08:47:12 -0700 (PDT)
Date: Tue, 9 Sep 2025 09:47:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,
 Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de,
 Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
Message-ID: <20250909154710.GZ124814@bill-the-cat>
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
 <20250909121537.1c2a95b1@wsk>
 <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
 <20250909153948.GY124814@bill-the-cat>
 <CAPVz0n1xCXPq6Qhd+EuJxkno=g8p5VXjxw0MaAz3ePumCzU4mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R6GZ9w9k/IUGVqZ1"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1xCXPq6Qhd+EuJxkno=g8p5VXjxw0MaAz3ePumCzU4mg@mail.gmail.com>
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


--R6GZ9w9k/IUGVqZ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 06:44:45PM +0300, Svyatoslav Ryhel wrote:
> =D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:39 Tom=
 Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue, Sep 09, 2025 at 02:26:19PM +0300, Svyatoslav Ryhel wrote:
> > > =D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:15=
 =C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > Hi Svyatoslav,
> > > >
> > > > > =D0=BF=D0=BD, 8 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 1=
5:41 =C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > >
> > > > > > Hi Svyatoslav,
> > > > > >
> > > > > > > =D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=
=80. =D0=BE 12:39 Lukasz Majewski <lukma@nabladev.com>
> > > > > > > =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > > > >
> > > > > > > > The Tegra30 SoC is a bit special, as it doesn't have the
> > > > > > > > separate IP block to provide watchdog functionality.
> > > > > > > >
> > > > > > > > Instead, timer IP block allows such functionality when prop=
erly
> > > > > > > > configured.
> > > > > > > >
> > > > > > > > As in the tegra30.dtsi there is a timer node, which "covers=
" all
> > > > > > > > timers, with 'nvidia,tegra30-timer' compatibility it was
> > > > > > > > necessary to manually bind U-Boot's WDT driver (based on
> > > > > > > > WDT_UCLASS).
> > > > > > > >
> > > > > > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > > > > > ---
> > > > > > > >  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
> > > > > > > >  1 file changed, 18 insertions(+)
> > > > > > > >
> > > > > > >
> > > > > > > What is the practical application for this diver in therms of
> > > > > > > Tegra and U-Boot overall?
> > > > > >
> > > > > > You have the WDT functionality working. It uses the same DTS
> > > > > > bindings as ones used in Linux.
> > > > >
> > > > > Why do we need WDT for Tegra in U-Boot at all?
> > > >
> > > > Can you correct me if I draw wrong conclusion - you ask why Tegra n=
eeds
> > > > to support watchdog in u-boot bootloader ?
> > > >
> > > > > It is not used and has
> > > > > no practical application.
> > > > >
> > > >
> > > > Yes, it has ...
> > > >
> > > > Customer has number of Tegra30 colibri modules in the field. They w=
ant
> > > > to switch to u-boot + linux kernel BSP.
> > > >
> > > > For their application - it would be welcome if the device could reb=
oot
> > > > and start emergency procedure in the case of not being able to start
> > > > Linux.
> > > >
> > > > The procedure is that we start Watchdog at very early boot - then w=
e do
> > > > have for example 30 seconds to "feed" the Watchdog in Linux
> > > >
> > > > When we fail, after watchdog reboot, we can switch to another rootfs
> > > > partition (the A/B scheme of booting) or start emergency system.
> > > >
> > >
> > > So when are you going to submit this board variant? If driver has no
> > > users, it is removed.
> >
> > I assume it would be enabled on colibri_t30_defconfig.
> >
>=20
> T30 colibri does not need it and does not use it with current
> configuration, hence I am asking about board submission.

It's a devkit where I'm pretty sure the watchdog exists, so we can
enable it there and be done. Just because it doesn't use it today
doesn't mean it can't use it in the future if we enable it, the "use
watchdog to make sure A/B system configures are stable" is a common use
case.

--=20
Tom

--R6GZ9w9k/IUGVqZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMBL/gAKCRAr4qD1Cr/k
CuTyAQDV1gsTMtjnG3I7nT4xghAh881J6+oNwZk01vZh3CSkZgD/dBsHcSSiFM4m
jv+9JORwfLwOGzaLk5k1jikmnYdRsQc=
=2e80
-----END PGP SIGNATURE-----

--R6GZ9w9k/IUGVqZ1--
