Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18A9D2C13E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3EE88913F;
	Tue,  5 Nov 2024 16:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f0ZJRoh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CB488D35; Tue,  5 Nov 2024 16:44:55 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0637891D0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b15416303aso408901585a.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730821491; x=1731426291; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x3lhu+qxfbIvYCpChl6xJ257fR93tLz84uVZI7w+ZSY=;
 b=f0ZJRoh/A9fEFgj/Es8buqFw7NDbMDIHtNRVwZwkYyMQkMsoMADiLx1fQI2IJ3IAzQ
 HylNI/mnoGdo8HongYpgzqA1t6Y58pev7la0ES4+l1NNLyGX2cAed0YeRskZEFckoB7O
 IAzvtufhGMdoCCkwSMoBBVArGvkblNn+JH0GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730821491; x=1731426291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3lhu+qxfbIvYCpChl6xJ257fR93tLz84uVZI7w+ZSY=;
 b=Hry9yYuTyn1EUbNEGqxu6uH/SUBLs1ztP+4DhuPZ3gdlH2McukVj1Tx4+dO/Afmfof
 /WXlUzIP3KgRB3mASiCnhtqm8LUoAamDZPp6ryEHVM4iYTlRXV1VOGWD//mWjvGyaCEv
 KHCwQ/pfiTOFRBAdus/kSbzBgHgwlSym9T3kyNq6HS0onzFZRHAIgs/hbIKRvnHYBJlB
 ozU4tHxjuuy7EpS3T1f5gVR2Heomdl/Iy7D4GZoxXJG6XbP/lmn2xwxzZugOD2MNFjB2
 sNututyv1zooG/qFXryeqw/Yg6+WfLzTTqWpMvdMImxwE8OiccW1UJQDnxP15d1F3DgC
 XaKA==
X-Gm-Message-State: AOJu0YxfkX/tuWdJPg0nQ923l3n9mUqK4JEA6yu9QU341+G72mNTEDkg
 ISDqt8woCnV/NUeM1GtoJ3oyIDh5L0RalJo88saGWO1QZuqEyDHGbiGIIG7zkdQ=
X-Google-Smtp-Source: AGHT+IFa6MR+2tz0wS90i71/p6Ksl564nSZt1vVjFOkctPSHxtYdygjcKYvJkl9Dg8Pp/n7F+5sLXQ==
X-Received: by 2002:a05:620a:190c:b0:7b1:3fe8:8f11 with SMTP id
 af79cd13be357-7b2fb982995mr2499988485a.33.1730821491573; 
 Tue, 05 Nov 2024 07:44:51 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a1172csm533779085a.71.2024.11.05.07.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:44:50 -0800 (PST)
Date: Tue, 5 Nov 2024 09:44:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 5/9] docker: Drop grub for arm64
Message-ID: <20241105154447.GH3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-6-sjg@chromium.org>
 <20241104135632.GK3600562@bill-the-cat>
 <CAFLszTi4YEqRCVJ=vRTVHtSP=Ux2C8W=vg=3+VedVAdZuef3+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tNDkEPd2eLhpgWh7"
Content-Disposition: inline
In-Reply-To: <CAFLszTi4YEqRCVJ=vRTVHtSP=Ux2C8W=vg=3+VedVAdZuef3+A@mail.gmail.com>
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


--tNDkEPd2eLhpgWh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 08:15:05AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 4 Nov 2024 at 06:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Nov 04, 2024 at 06:39:49AM -0700, Simon Glass wrote:
> >
> > > This doesn't build on arm64 at present, so drop it for now. We only
> > > expect to run sandbox tests, so perhaps it isn't needed.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  tools/docker/Dockerfile | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > What is the build failure? Depending on what other prospects for arm64
> > build hardware come through I'm hoping to look harder at more build
> > options, not just sandbox (but of course, QEMU shouldn't matter what the
> > host is).
>=20
> field-initializers -Wnonnull -Woverflow -Wvla -Wpointer-to-int-cast
> -Wstrict-aliasing -Wvariadic-macros -Wvolatile-register-var
> -Wpointer-sign -Wmissing-include-dirs -Wmissing-prototypes
> -Wmissing-declarations -Wformat=3D2
> 686.0 checking for aarch64-gcc...
> /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc
> 686.0 checking for aarch64-objcopy...
> /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-objcopy
> 686.0 checking for aarch64-strip...
> /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-strip
> 686.0 checking for aarch64-nm...
> /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-nm
> 686.0 checking for aarch64-ranlib...
> /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-ranlib
> 686.0 ./configure: line 32517:
> /opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc: No such
> file or directory
> 686.1 checking which extra warnings work...
> 689.6 checking if compiling with clang... yes
> 689.8 checking for options to compile assembly...
> 689.8 checking whether -freg-struct-return works... no
> 690.0 checking for options to get soft-float... no
> 690.8 configure: error: could not force soft-float
>=20
> I suspect it is just that the toolchains need fiddling. I'd much
> rather get something running and iterate on it after that.

That's the toolchain that should be used to build sandbox, so you should
figure out what's going on. And I think you missed fiddling with
~/.buildman so that it sets the sandbox toolchain to the right one and
not x86_64.

--=20
Tom

--tNDkEPd2eLhpgWh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqPW8ACgkQFHw5/5Y0
tyxxAAwAj4ZjLwmEV8lnYkBuD+VyEx9U51XxphD70eEVwFwjxuA30hdS7FCPXbKL
K05981FwchGLhEqpKmiElingg2N2e0hQZWd2v7bXN7UcDZypKhY9b4aVX4BDOkkH
hU+MqVTQMX0Mr/8CJowL4ykwzIIBXJyc/V8R9zmd4AtxL/A2ivCVhSFa50VtDtwy
ACCmEATvpwCBWzopWYywG/LXV5ZlLJ2454tw/Z53cNvDjk5ZL/VNIJuBfNPT1sK1
ncdXh0a/F6WPbGveVBKre3l0lmiVO3MtBoGoHX36fKhhjki42Po16RNtvF2WYWO3
j81CZIe3unU+TbjenLFTuEKUnqJ1I59Fv8mx+t2tZco3c5y9VivztI78+elroC/d
m4wzEe7M1awdNqxKgguQp0TkUbUcClSWxXsCw8EY9F87XZUI2c+p+oXkRFGBCQ+i
p1rhoOyxxY0/vTdwp4m39hHYmcI4PPIQIOwPyvNGoaSrv7XQ16RfEJtMSAxOkQns
ZD0eOpc8
=bo8A
-----END PGP SIGNATURE-----

--tNDkEPd2eLhpgWh7--
