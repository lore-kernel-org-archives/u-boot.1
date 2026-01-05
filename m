Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E63C79F9C
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 14:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE1E183D8A;
	Mon,  5 Jan 2026 15:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SsDwWZd9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F00E283DB6; Mon,  5 Jan 2026 15:43:14 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB868399B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 15:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e3dac349easo15521034fac.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 06:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767624187; x=1768228987; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oKqEXuw/6v+eNlAX/rtLmtjUgSnf5I2/tnDIRtf/eNI=;
 b=SsDwWZd9CEzP4ZPkDYtvT+yLLUpvnujFwDiMbwEYmJArPgeHIEuMHj2VdhPqVgva7H
 BO5Js51oW1mcWAY9m/DkmcdtZhFvE/15NoJvVzh56/xKMffFt9NwfwAU/SPMyLlLyiLJ
 uDb8QrBnc/GgAIN2NTjTrCafCOqgVr2OVbY7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767624187; x=1768228987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKqEXuw/6v+eNlAX/rtLmtjUgSnf5I2/tnDIRtf/eNI=;
 b=JRjxxyu6a/ubjDPVjspyD7eOkAgZ4JqQpE1ui7Wv/+TFkBZllN47vqqpoTi1UdCqNO
 kZMzKnIzGekyNjhvlVDG0M14ZOAWHHBN/JSlSO2JnOsiuNylyhRkEnbVZexSaYMUTFdH
 LZiS5tirjt+alG4V7+Gy8hZ1PiF/yVczPsjaR+vP8klJqg0OD2nFv23/x+4ic2FADrx9
 jsFMRsLOJDnyDAX/lAeqoEyFoXzCtofkO7f3csHAakAhHYkMAXROb/uZlVjMnX+hl3GU
 KhXKFXEgg9CsswW9urA2LZ4EdlKFIJyDjuhmm3MkLXgUSz8cDN41pBak6otnu/Ec6HCV
 MjiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNy6ZCl0c+UORTN3AeEXzwpIAd0onMXE9jCj75EeC7DsdF5xbDalnAVHggrnd8yvBCNTw0a+A=@lists.denx.de
X-Gm-Message-State: AOJu0YxdHgC9Vi5xgYB8z1USIrMQuEDXeFvOOw2BDgx6bKI5dM1p+DKT
 7UaGzGhE5VDNJE5vYrU4zgtdXAbiCoK3MsoH5dM8DRvd1P+BCVifZvlUXjk5QLEWwyk=
X-Gm-Gg: AY/fxX7rAz29n07R/CfEmB55iyQi9k+B+dI+LyZHsibhY4zt3CPkOWYS0sG9lVGnFcl
 9By3eIOQDOF7uy8jnvc/kkJm2RDzXT6ACezRgcJ+DZ8rHxfU6HXfmbGR0XjQqHwYC3YZLi9JOn1
 omyOEsn/SJlDX6A8U4fGGcmjzlE+3Ivjst4Xl1L2ElRdLSLPjCBeMOLiMK+Q77+3UrYjq0mdv95
 gCtGcj1yPUcKlBXnPbXgUY9JGturEgZGK6UD077JhmCt87wdW2NgSo+4+ThzJm9zLz2Lw6vbPbB
 D/xyhtO8mMopBU96tYJHUyiZRXTt03zbvW6iZJHmNLiwzPtsN6xgLB83V/o/1K3gFt6SH7T4m4o
 NnqEAlGBXbmVLztRaQRYsEs44JBHxt4VYJE0V+e5AOK7q5L3GxreKepKusS4JfQOt0HV+YX63NH
 B49SGgcrh0oHEJTXkXzVgeJImz9VEPjKZ+5UTGSppUgEchasSTrnXZk5C0ud4HJQhPOI1DoNCh1
 GqfQGpJEJuqw+AebpeC/UJZECikIV2NiyTg2kw=
X-Google-Smtp-Source: AGHT+IGyYL0TuG/8TFQH+4ABEhxxWmhKM6WCzFmGkoq5syJ7oGEZxYZsFPiewF5KqYLRR6eCP87G6A==
X-Received: by 2002:a05:6870:a251:b0:3ec:47d6:ea0b with SMTP id
 586e51a60fabf-3fda56a4915mr25868980fac.21.1767624187347; 
 Mon, 05 Jan 2026 06:43:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab65763sm30247571fac.13.2026.01.05.06.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 06:43:06 -0800 (PST)
Date: Mon, 5 Jan 2026 08:43:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, alison.wang@nxp.com, angelo@kernel-space.org
Subject: Re: [PATCH v4 1/6] serial: Add Goldfish TTY driver
Message-ID: <20260105144304.GL6124@bill-the-cat>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-2-visitorckw@gmail.com>
 <618be257-d247-4811-9cfd-e58017aba579@canonical.com>
 <855488fb-4ae9-4468-aa2e-68575ce4dc8e@canonical.com>
 <aVg9HhznRcwPLMeo@google.com> <20260102215125.GH6124@bill-the-cat>
 <aVhRVhPLF7Sx6vY1@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xce/yRR1K+YgBAaF"
Content-Disposition: inline
In-Reply-To: <aVhRVhPLF7Sx6vY1@google.com>
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


--Xce/yRR1K+YgBAaF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2026 at 07:14:30AM +0800, Kuan-Wei Chiu wrote:

> Hi Tom,
>=20
> On Fri, Jan 02, 2026 at 03:51:25PM -0600, Tom Rini wrote:
> > On Sat, Jan 03, 2026 at 05:48:14AM +0800, Kuan-Wei Chiu wrote:
> > > Hi Heinrich,
> > >=20
> > > On Fri, Jan 02, 2026 at 09:40:39AM +0100, Heinrich Schuchardt wrote:
> > > > On 1/2/26 09:29, Heinrich Schuchardt wrote:
> > > > > On 1/1/26 18:54, Kuan-Wei Chiu wrote:
> > > > > > Add support for the Google Goldfish TTY serial device. This vir=
tual
> > > > > > device is commonly used in QEMU virtual machines (such as the m=
68k
> > > > > > virt machine) and Android emulators.
> > > > > >=20
> > > > > > The driver implements basic console output and input polling us=
ing the
> > > > > > Goldfish MMIO interface.
> > > > > >=20
> > > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > Reviewed-by: Yao Zi <me@ziyao.cc>
> > > > > > Tested-by: Daniel Palmer <daniel@0x0f.com>
> > > > >=20
> > > > > Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >=20
> > > Thanks for the review.
> > >=20
> > > > >=20
> > > > > > ---
> > > > > > Changes in v4:
> > > > > > - Support DT probing with platform data as a fallback.
> > > > > >=20
> > > > > > =A0 MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 6 ++
> > > > > > =A0 drivers/serial/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 8 +++
> > > > > > =A0 drivers/serial/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =
1 +
> > > > > > =A0 drivers/serial/serial_goldfish.c | 109 ++++++++++++++++++++=
+++++++++++
> > > > > > =A0 include/goldfish_tty.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1=
8 +++++
> > > > > > =A0 5 files changed, 142 insertions(+)
> > > > > > =A0 create mode 100644 drivers/serial/serial_goldfish.c
> > > > > > =A0 create mode 100644 include/goldfish_tty.h
> > > > > >=20
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index 6ce0bbce13d..da4a6e4d518 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -1259,6 +1259,12 @@ S:=A0=A0=A0 Maintained
> > > > > > =A0 F:=A0=A0=A0 drivers/misc/gsc.c
> > > > > > =A0 F:=A0=A0=A0 include/gsc.h
> > > > > > +GOLDFISH SERIAL DRIVER
> > > > > > +M:=A0=A0=A0 Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > +S:=A0=A0=A0 Maintained
> > > > > > +F:=A0=A0=A0 drivers/serial/serial_goldfish.c
> > > > > > +F:=A0=A0=A0 include/goldfish_tty.h
> > > > > > +
> > > >=20
> > > > Applying: serial: Add Goldfish TTY driver
> > > > Patch failed at 0001 serial: Add Goldfish TTY driver
> > > > error: patch failed: MAINTAINERS:1259
> > > > error: MAINTAINERS: patch does not apply
> > > >=20
> > > > Should a respin of the series be needed, please, check that the ser=
ies
> > > > applies to origin/next before sending.
> > >=20
> > > To make sure I base the next version on the correct tree, should I ba=
se
> > > it on the ColdFire tree's next branch:
> > >=20
> > > https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
> > >=20
> > > Or the main U-Boot repository's next branch:
> > >=20
> > > https://source.denx.de/u-boot/u-boot.git
> >=20
> > The main U-Boot tree. Custodian trees are not always up to date (and
>=20
> Thanks for the clarification.
> I will base v5 on the main U-Boot tree's next branch.
>=20
> > with the renewed interest in m68k, I was going to ask if someone else
> > would like to step up as co-maintainer as part of all of this, Angelo
> > might like some help).
>=20
> TBH, being relatively new to the U-Boot community, I'm not sure if I
> have gained enough trust or shown enough knowledge of the m68k code and
> development workflow just yet.
>=20
> However, if help is needed, I'm happy to help review and test
> m68k-related patches.

I understand, and yes, starting with reviewing things is fine. But this
is also the most activity m68k has gotten in a decade or so, so I do
believe you to be on the forefront of how the code is :)

--=20
Tom

--Xce/yRR1K+YgBAaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVvN6gAKCRAr4qD1Cr/k
Ci7cAP9ejelLuBi9vdMibaAlNaZmbSAUqUwZoJX4v9GQ2mAJNQD/QwZKiWBIKamb
l7TOAuGjDSe77Osqg2qQ+yB9M/N3yQo=
=VQpH
-----END PGP SIGNATURE-----

--Xce/yRR1K+YgBAaF--
