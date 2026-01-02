Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5914DFA3751
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 21:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D283284241;
	Fri,  2 Jan 2026 22:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PM8avG1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B408428C; Fri,  2 Jan 2026 22:51:32 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8729183B49
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 22:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7c75b829eb6so7934674a34.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 13:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767390688; x=1767995488; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hvYUCplYGOxM3rC6JSq4MDupkw4IKSzJvhMkr/Z8Ry8=;
 b=PM8avG1DV887EpYbtbJvdA70hHitDhdrMy/93FS3ZQIVaLT2ZkE0ocL26/KCNcphjc
 qQHYfc1X8sgqLr6BeKIfcY7u5Jn3SItG5zIRwj/PWeoFUW0oSeAvh7/WnrCmzv5AawUb
 GxrJ16d9uiErwnNvqOjklcjz5JzM6LwiXumT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390688; x=1767995488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvYUCplYGOxM3rC6JSq4MDupkw4IKSzJvhMkr/Z8Ry8=;
 b=Cq/lg/WPg6YwifXiS2gi0KozHeF2fGbVGvxwGeQ5EdwTd71sxGuOSx7EureKU6u0HN
 m6R7PiplZsB/hJF3Jsiay/pLfNRHJ0NRpa59rJXjQ88Upxauej9mpq0Mp3Fk+nUncNsM
 EzyPpSrxB172kjzNrMxsvNhWp4bpyFFqISaR7smu/McYbq6FZMKLnWBD6AMKKYon15p2
 Oyotk0gmVNCVKV75YvXwLg1nq1c6PhKSIO7aXjTBOTJj01yblb8WAkdxEHl/17+wI2KZ
 nIeNEWpZ+xEpJziBGNETmYfpIAeh03/23QABJTvj9BQebjONHIpTDffGkq0YrAh98ZNF
 70rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOqgWjRKLnsLjxg1NSl3c1sY+jJS5IxAuSm2CUx/NbPXwJIsa1T49/PhFblpCRFch95ay0kbw=@lists.denx.de
X-Gm-Message-State: AOJu0YyHRPnzYAYrcCiFVZw3B45aTFQFVtoMXsjsrfxexmqmSxvthsfc
 w0zBgD8IkK1TA2tT7xKahCOCeICC2vo2FlpjOLlX97HuKmeWl5WgUwFFOXQIxdFPe0Q=
X-Gm-Gg: AY/fxX6y1RstsFYOmtEpU3z+1LfGyqd7IGvQlxv0xco5+DCDkGSL0w8S/83eysYaO/g
 WgF2b3irf/N6C4vFQOVeyssfYClCmtcFFxbuipW/ZHJX5AFCqubzfqjCdVSHj5Cp1Nja8akjh1F
 cVGYJOdXoJS1glfr3dG8kgzTBdB/KOFSxRETE8f7ceAbpfpie+gDVFJa5jBOU+j/o3Rmb2oSp/k
 g9DLsFQ+OgX/+YdGyhrqNgVLcXy+fkihHP57VjBm58AEwL9IueCXwwdSbJNou0urMlAktF462+A
 BwJ9ZujqBtW49CU98D1msQwmwy62JUqH+U29QOTo4vXBhHi7iMwKGrrshhx6AeeiF4XAnlRL2hH
 guyP5bC7Vpz5Zr67H0oi5aqEMJTZuzFEfAJKLzo0Rq/KnbUc5nvKjz405PMyK1/OtoMXN/ohi8e
 oA9SsQf3eOHWyb8xUARPrbDgVPmE2frf4dehF0KoFGjbH2V0PCjVVNmnATnT4ueBZavwYySh+Gq
 ORdoZkKETkVkOxXGm0RMxfgR/D+/JVkBuGlRAE=
X-Google-Smtp-Source: AGHT+IEUQzcQ13O0ac2ZD4x//pGV72B42E+kOJccBLMc+DBUqQuwf+mJowG4dkl2hjC8MJttJHbv1w==
X-Received: by 2002:a05:6830:2b0f:b0:7c9:594f:2d16 with SMTP id
 46e09a7af769-7cc667f7d5dmr21239572a34.0.1767390688208; 
 Fri, 02 Jan 2026 13:51:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667d572asm28955355a34.14.2026.01.02.13.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:51:27 -0800 (PST)
Date: Fri, 2 Jan 2026 15:51:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, alison.wang@nxp.com, angelo@kernel-space.org
Subject: Re: [PATCH v4 1/6] serial: Add Goldfish TTY driver
Message-ID: <20260102215125.GH6124@bill-the-cat>
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-2-visitorckw@gmail.com>
 <618be257-d247-4811-9cfd-e58017aba579@canonical.com>
 <855488fb-4ae9-4468-aa2e-68575ce4dc8e@canonical.com>
 <aVg9HhznRcwPLMeo@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fPGlo1tKZdr9GDrs"
Content-Disposition: inline
In-Reply-To: <aVg9HhznRcwPLMeo@google.com>
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


--fPGlo1tKZdr9GDrs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2026 at 05:48:14AM +0800, Kuan-Wei Chiu wrote:
> Hi Heinrich,
>=20
> On Fri, Jan 02, 2026 at 09:40:39AM +0100, Heinrich Schuchardt wrote:
> > On 1/2/26 09:29, Heinrich Schuchardt wrote:
> > > On 1/1/26 18:54, Kuan-Wei Chiu wrote:
> > > > Add support for the Google Goldfish TTY serial device. This virtual
> > > > device is commonly used in QEMU virtual machines (such as the m68k
> > > > virt machine) and Android emulators.
> > > >=20
> > > > The driver implements basic console output and input polling using =
the
> > > > Goldfish MMIO interface.
> > > >=20
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Reviewed-by: Yao Zi <me@ziyao.cc>
> > > > Tested-by: Daniel Palmer <daniel@0x0f.com>
> > >=20
> > > Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>=20
> Thanks for the review.
>=20
> > >=20
> > > > ---
> > > > Changes in v4:
> > > > - Support DT probing with platform data as a fallback.
> > > >=20
> > > > =A0 MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0=A0 6 ++
> > > > =A0 drivers/serial/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 8 =
+++
> > > > =A0 drivers/serial/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> > > > =A0 drivers/serial/serial_goldfish.c | 109 ++++++++++++++++++++++++=
+++++++
> > > > =A0 include/goldfish_tty.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 18 ++=
+++
> > > > =A0 5 files changed, 142 insertions(+)
> > > > =A0 create mode 100644 drivers/serial/serial_goldfish.c
> > > > =A0 create mode 100644 include/goldfish_tty.h
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 6ce0bbce13d..da4a6e4d518 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -1259,6 +1259,12 @@ S:=A0=A0=A0 Maintained
> > > > =A0 F:=A0=A0=A0 drivers/misc/gsc.c
> > > > =A0 F:=A0=A0=A0 include/gsc.h
> > > > +GOLDFISH SERIAL DRIVER
> > > > +M:=A0=A0=A0 Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > +S:=A0=A0=A0 Maintained
> > > > +F:=A0=A0=A0 drivers/serial/serial_goldfish.c
> > > > +F:=A0=A0=A0 include/goldfish_tty.h
> > > > +
> >=20
> > Applying: serial: Add Goldfish TTY driver
> > Patch failed at 0001 serial: Add Goldfish TTY driver
> > error: patch failed: MAINTAINERS:1259
> > error: MAINTAINERS: patch does not apply
> >=20
> > Should a respin of the series be needed, please, check that the series
> > applies to origin/next before sending.
>=20
> To make sure I base the next version on the correct tree, should I base
> it on the ColdFire tree's next branch:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
>=20
> Or the main U-Boot repository's next branch:
>=20
> https://source.denx.de/u-boot/u-boot.git

The main U-Boot tree. Custodian trees are not always up to date (and
with the renewed interest in m68k, I was going to ask if someone else
would like to step up as co-maintainer as part of all of this, Angelo
might like some help).

--=20
Tom

--fPGlo1tKZdr9GDrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVg92QAKCRAr4qD1Cr/k
CnpfAQCfZHzP8qt4v+QU4xr1xsUgXbQkakNUhswOJ+xXOan/VwEAnIg7RYYT4DcK
0Pa2tovd8kOBjoxJZsA7PYLKl8SBswg=
=9AlQ
-----END PGP SIGNATURE-----

--fPGlo1tKZdr9GDrs--
