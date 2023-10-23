Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35A3C25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B5A87139;
	Mon, 23 Oct 2023 19:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tLauRPvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC58886FE5; Mon, 23 Oct 2023 19:24:35 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 958FE86FD6
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7c95b8d14so33694957b3.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698081871; x=1698686671; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zLN90QRfychBQEVdiU0tI4D7BgRq755rO15nGlx7aTA=;
 b=tLauRPvbwO8lOq9qm/qiy8tPFAlSa7ryXB+pNoZ2C6msmQ7fffnwCD4sKos0z9+TCa
 JrQjynDmCsp4rVhOLr5X3oQfEVa21ezmuY0x3Dn51pG0pVQEDUNADpwU1a+GgdHjyrVp
 E7FXdMiatQgVlKD34NM99GWR66C2CzSHMwc6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698081871; x=1698686671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLN90QRfychBQEVdiU0tI4D7BgRq755rO15nGlx7aTA=;
 b=DHIzyCSpQi3Dz2YitTJzXgSaZUeiWNsSF9txj5Px0cHlBYOJwgY9lg3F9z4O+MXiGx
 6a/udHHEsYip+JFNZ/qkQy8TMkY/UpI4PbQ8+l/HtIrjdRcZdYtwQVXIzT6KFqAWywH1
 b25m0FemRjwqp4lSaZPqRlrRtXuo37yj6ABCQxiGOb8H8Du3dEIE57Iavk/asYByQL7D
 0uG+CmES2dgKLufHfk6oa69n4p1OP/4O2dveA7MDq3EpXmH+/3G5Bp58Ne1rKasPhVKK
 VB8AgArAZ8lnYtDWk0QPnI6UgHFAsLrEPIxnahuIccWihyxnqAFFl5IrrTP6gkbYKUk/
 6r0Q==
X-Gm-Message-State: AOJu0YyrZ7Th8CWgHS7tdqaoAGgSkLWajAE+teuFKr+0cD/dehUFuG91
 LBiVYc/P2gNienk4YlIZ6E+kbA==
X-Google-Smtp-Source: AGHT+IGLvhxLnfQ+i/QY8d4gXjomgygMSzULOGo/TDITBCu7zPWixyNdjnG3sbs49sUFVJ4CCDqDAg==
X-Received: by 2002:a81:5441:0:b0:5a8:3f69:8832 with SMTP id
 i62-20020a815441000000b005a83f698832mr8413114ywb.50.1698081871367; 
 Mon, 23 Oct 2023 10:24:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a816007000000b0059b50f126fbsm3284532ywb.114.2023.10.23.10.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 10:24:30 -0700 (PDT)
Date: Mon, 23 Oct 2023 13:24:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] sandbox: eliminate unused functions from binaries
Message-ID: <20231023172428.GU496310@bill-the-cat>
References: <20231022233727.84947-1-heinrich.schuchardt@canonical.com>
 <20231023170258.GT496310@bill-the-cat>
 <CAPnjgZ0Lbgmga7EhWPq3mThYih81Y18h0rHBL0Wdn=_nRU4NNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8bIGv5LW53k1hncK"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0Lbgmga7EhWPq3mThYih81Y18h0rHBL0Wdn=_nRU4NNQ@mail.gmail.com>
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


--8bIGv5LW53k1hncK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 10:13:55AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Mon, 23 Oct 2023 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 23, 2023 at 01:37:27AM +0200, Heinrich Schuchardt wrote:
> > > The sandbox should closely mimic other architectures.
> > >
> > > Place each function or data in a separate section and let the linker
> > > eliminate unused ones. This will reduce the binary size.
> > >
> > > In the linker script mark that u_boot_sandbox_getopt are to be kept.
> > >
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > > v2:
> > >       mark _u_boot_sandbox_getopt secitons a KEEP()
> > > ---
> > >  arch/sandbox/config.mk      | 4 +++-
> > >  arch/sandbox/cpu/u-boot.lds | 6 +++---
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
> > > index 2d184c5f65..c02f0229c2 100644
> > > --- a/arch/sandbox/config.mk
> > > +++ b/arch/sandbox/config.mk
> > > @@ -2,7 +2,7 @@
> > >  # Copyright (c) 2011 The Chromium OS Authors.
> > >
> > >  PLATFORM_CPPFLAGS +=3D -D__SANDBOX__ -U_FORTIFY_SOURCE
> > > -PLATFORM_CPPFLAGS +=3D -fPIC
> > > +PLATFORM_CPPFLAGS +=3D -fPIC -ffunction-sections -fdata-sections
> > >  PLATFORM_LIBS +=3D -lrt
> > >  SDL_CONFIG ?=3D sdl2-config
> > >
> > > @@ -26,6 +26,7 @@ cmd_u-boot__ =3D $(CC) -o $@ -Wl,-T u-boot.lds $(u-=
boot-init) \
> > >       $(KBUILD_LDFLAGS:%=3D-Wl,%) \
> > >       $(SANITIZERS) \
> > >       $(LTO_FINAL_LDFLAGS) \
> > > +     -Wl,--gc-section \
> > >       -Wl,--whole-archive \
> > >               $(u-boot-main) \
> > >               $(u-boot-keep-syms-lto) \
> > > @@ -37,6 +38,7 @@ cmd_u-boot-spl =3D (cd $(obj) && $(CC) -o $(SPL_BIN=
) -Wl,-T u-boot-spl.lds \
> > >       $(SANITIZERS) \
> > >       $(LTO_FINAL_LDFLAGS) \
> > >       $(patsubst $(obj)/%,%,$(u-boot-spl-init)) \
> > > +     -Wl,--gc-section \
> > >       -Wl,--whole-archive \
> > >               $(patsubst $(obj)/%,%,$(u-boot-spl-main)) \
> > >               $(patsubst $(obj)/%,%,$(u-boot-spl-platdata)) \
> >
> > There's already a call to --gc-sections for u-boot-spl on sandbox (in
> > the last line of the link command).  We should probably move the main
> > u-boot call there too, for consistency.
>=20
> For the moment I really don't want this in sandbox. I think I explain
> that there is very little benefit in terms of size and it takes us
> away from how native apps are normally built. It also seems to mask
> problems in your CMDLINE series

This fixes problems with sandbox not acting like a proper U-Boot target.
It is not at all about size reduction, it's about being able to use
normal conventions in U-Boot.

--=20
Tom

--8bIGv5LW53k1hncK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2rEkACgkQFHw5/5Y0
tyx7nAv7Bmi4JIEhZOVqpAE5QtF/OnQGKAPZCI/E7Bs2kcwOxCiUoAUrUCV5+JTC
dd+YesI/3REWMtPwtZIDOXSXnxSLQxeQ2MxPWbVEPt3qwWJe7W8gu2t+yFcOjVYB
Gk3A9TEG9XJKL7armdduy+W0Tibby7IdCgQtddiQFuDne08KSS37LFgC7LnguKxP
lJPcY0xn4BMJAUiPrJbJByvmbNXFLFRtS0T58ijAy9q7U2lRD2MSFRsoZu3EOS1G
UnVE4T2n4Z9KzTCo4o7/M0o9AqPiLtVJONY4eQdpkSaMU70TOSaUTlqLTT4l6Qgb
NeO2Dkdvw4rbCkVDgGjYat+Y8yzWZLN5BVibfbNkFWi7IodVKp3VZsTC4E8VdhNW
xnRO2+1egeZtsuDePk+0xd+e8VgRLrGi/PqQ4FVMOiaxS4Hb/Q5VKTQxya4jnnKA
Eszj6cOAmhHxHExOEIZFsLZw/Q6TS5EKoXDNtrxMNRJEaqyswJcH4mNugs1Swkbk
3eSizx2f
=SkTi
-----END PGP SIGNATURE-----

--8bIGv5LW53k1hncK--
