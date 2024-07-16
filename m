Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F55C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 16:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987F888980;
	Tue, 16 Jul 2024 18:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MBykQW4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C5B889EB; Tue, 16 Jul 2024 18:18:09 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD58D8880B
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 18:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d9400a1ad9so3287626b6e.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721146685; x=1721751485; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LdCCmKdHcSBYk+rFhev4o6OxnKopszrTomFzvQwYEY4=;
 b=MBykQW4US8VOlXLrHQfCtXClenMEi7cdSEffF/WptExMvDEJu90cVUp4t1fqnCGAoB
 HrmkioJUrtAaOd2gLMGhAikYYfFekBqqNMnW9VnjaWns95JXVW8nE/m//9pWi/m3bd5y
 QuqeYCAXlKI+uVXQEn5VQx81umj6MqfikoSRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721146685; x=1721751485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdCCmKdHcSBYk+rFhev4o6OxnKopszrTomFzvQwYEY4=;
 b=aOKmGeVsUxEj4W3QVaL1DYcY8j4sUbQIZdvziqnpqzkUs7FuUxIOiTU4A/q8mchFRO
 k+yInxjfm7ScRWZsF7w3Cs2UfQbm0l3gPw4NFLWAbUgkX3zfmN3YI0SGjn4cXi7yD7mn
 qiCw++Z+ZWebXxAAQhu5LB7VRihZkVGlPuTg4Zxw/7XT14Sw9yd7/rwpvI235dGfQm3U
 yu9Yy4zdRiE7HEqbMDXQYZQGF6BRD72lyqQpHfwVzVt8WgqCw8mrygK8DpyoShujjeUB
 wc++1wjYaaWuph7+R4DZJVQcGeVu1/e2FajpL1nAt7bQLlCjIHR2fgn1gUEv8s+Na2Ys
 wYIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIcLRRawecyC055t98M2E8V0uXfVQadN20qPi0XiELjosETD145PEP05XmfohKT+F2kaB/hmyVklzBXaBjOm1NF7mGuQ==
X-Gm-Message-State: AOJu0YxCCAedpUwh1OYfSeYTULytdlvmf79Y0JJVFqQ3Qh0tos58zZAZ
 ga6TMBq52FtYKOqO62Tfl/yBY8Kdb8XzSvZ+QACV+pwmjFD/FSQ1Kpf3GNzinqM=
X-Google-Smtp-Source: AGHT+IECfFiZxrIlHhabYXg7m1f050cHoSdgwj+1/EU83T7V615my9sZaWvqk8dyO/lkeWtH0tRXIw==
X-Received: by 2002:a05:6870:5493:b0:254:79a2:38d1 with SMTP id
 586e51a60fabf-260bdd83853mr2278917fac.4.1721146685468; 
 Tue, 16 Jul 2024 09:18:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260752a6261sm1438195fac.43.2024.07.16.09.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:18:04 -0700 (PDT)
Date: Tue, 16 Jul 2024 10:18:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Dahl <ada@thorsis.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 E Shattow <lucent@gmail.com>, Jaewon Jung <jaewon8868@gmail.com>,
 Janne Grunau <j@jannau.net>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/13] doc: Move bootstd into its own directory
Message-ID: <20240716161801.GE561963@bill-the-cat>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-3-sjg@chromium.org>
 <22edf937-af4d-4cf5-a251-095c1615cb4a@gmx.de>
 <CAFLszTim9eiN5rObbZbGYa6ZgCV0G=7s6v1Bji3QO=o1fOiiaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cAWnO79wyraTTylz"
Content-Disposition: inline
In-Reply-To: <CAFLszTim9eiN5rObbZbGYa6ZgCV0G=7s6v1Bji3QO=o1fOiiaQ@mail.gmail.com>
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


--cAWnO79wyraTTylz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 08:04:38AM +0100, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Mon, 15 Jul 2024 at 22:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 7/15/24 12:13, Simon Glass wrote:
> > > Before adding more files, move the bootstd docs into a new directory,
> > > with an index.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >   MAINTAINERS                                       |  2 +-
> > >   doc/board/starfive/milk-v_mars_cm.rst             |  2 +-
> > >   doc/develop/board_best_practices.rst              |  2 +-
> > >   doc/develop/bootstd/index.rst                     |  9 +++++++++
> > >   doc/develop/{bootstd.rst =3D> bootstd/overview.rst} | 14 +++++++---=
----
> > >   doc/develop/index.rst                             |  2 +-
> > >   doc/usage/cmd/bootdev.rst                         |  2 +-
> > >   doc/usage/cmd/bootflow.rst                        |  2 +-
> > >   doc/usage/cmd/bootmeth.rst                        |  2 +-
> > >   doc/usage/environment.rst                         |  2 +-
> > >   10 files changed, 24 insertions(+), 15 deletions(-)
> > >   create mode 100644 doc/develop/bootstd/index.rst
> > >   rename doc/develop/{bootstd.rst =3D> bootstd/overview.rst} (99%)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9bee9284cca..86b830aa997 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -927,7 +927,7 @@ F:        boot/bootmeth*.c
> > >   F:  boot/bootstd.c
> > >   F:  cmd/bootdev.c
> > >   F:  cmd/bootflow.c
> > > -F:   doc/develop/bootstd.rst
> > > +F:   doc/develop/bootstd/
> > >   F:  doc/usage/bootdev.rst
> > >   F:  doc/usage/bootflow.rst
> > >   F:  doc/usage/bootmeth.rst
> > > diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfi=
ve/milk-v_mars_cm.rst
> > > index b31de6043bb..52d4e5e9098 100644
> > > --- a/doc/board/starfive/milk-v_mars_cm.rst
> > > +++ b/doc/board/starfive/milk-v_mars_cm.rst
> > > @@ -89,7 +89,7 @@ provide a default value.
> > >
> > >   The variable *$fdtfile* is used in the boot process to automaticall=
y load
> > >   a device-tree provided by the operating system. For details of the =
boot
> > > -process refer to the :doc:`U-Boot Standard Boot <../../../develop/bo=
otstd>`
> > > +process refer to the :doc:`/develop/bootstd/index`
> > >   description.
> > >
> > >   Boot source selection
> > > diff --git a/doc/develop/board_best_practices.rst b/doc/develop/board=
_best_practices.rst
> > > index f44401eab7d..09632c80ce7 100644
> > > --- a/doc/develop/board_best_practices.rst
> > > +++ b/doc/develop/board_best_practices.rst
> > > @@ -7,7 +7,7 @@ In addition to the regular best practices such as usi=
ng :doc:`checkpatch` and
> > >   following the :doc:`docstyle` and the :doc:`codingstyle` there are =
some things
> > >   which are specific to creating a new board port.
> > >
> > > -* Implement :doc:`bootstd` to ensure that most operating systems wil=
l be
> > > +* Implement :doc:`bootstd/index` to ensure that most operating syste=
ms will be
> > >     supported by the platform.
> > >
> > >   * The platform defconfig file must be generated via `make savedefco=
nfig`.
> > > diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/inde=
x.rst
> > > new file mode 100644
> > > index 00000000000..f4f87c7787c
> > > --- /dev/null
> > > +++ b/doc/develop/bootstd/index.rst
> > > @@ -0,0 +1,9 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+:
> > > +
> > > +Standard Boot
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +.. toctree::
> > > +   :maxdepth: 2
> > > +
> > > +   overview
> > > diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd/overview.r=
st
> > > similarity index 99%
> > > rename from doc/develop/bootstd.rst
> > > rename to doc/develop/bootstd/overview.rst
> > > index 34631089ae0..761f61a573b 100644
> > > --- a/doc/develop/bootstd.rst
> > > +++ b/doc/develop/bootstd/overview.rst
> > > @@ -1,7 +1,7 @@
> > >   .. SPDX-License-Identifier: GPL-2.0+:
> > >
> > > -U-Boot Standard Boot
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +Standard Boot Overview
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> >
> >
> >
> > The text is not optimized for readability, e.g.
> >
> > "- bootdev  - a device which can hold or access a distro (e.g. MMC,
> > Ethernet)"
> >
> > Please, consistently replace the non-words in the boot standard
> > documentation:
> >
> > %s/bootdev/boot device/
> > %s/bootmeth/boot method/
> > %s/bootflow/boot flow/
>=20
> I do want to keep the terms, It is easy to search for bootdev or
> bootmeth in the code and docs. Once people learn what they mean it is
> pretty simple.

I agree, this is the documentation for "bootdev" and "bootmeth" and
"bootflow" not for "boot device" and so forth.

> > "distro" isn't a dictionary word either. Do you mean operating system?
>=20
> I mean a linux distro, in the sense that 'distro boot' uses it.

Maybe an initial statement early about starting your operating system
distribution (distro), and then it's OK to say distro later on? This
does also work on non-Linux distributions :)

--=20
Tom

--cAWnO79wyraTTylz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaWnTYACgkQFHw5/5Y0
tyx1SAwAiWXV/6YDEHRDW6ZZpPOjzCwpzRekstL3h4j9VrG6kAPc45v1agKIQ/eV
0EGEwjYZK3ECvE+dmljWBQa8sWZTwfPX6uFjDZ5ne5hlMpAPTcr83MwmtFsQarmE
YNWuOGpyyCMK6JwkvgIXlRwk1XprBsO6kRlNHVJ7241b/CtVCRFj4Cm1yUf1EquQ
8TNlfrXDSoYcg8hBt67cFQSlXSLnxHFFIQaw6pzXU8UvUjqrUXngAIyjHsW5U4DI
s43HqhtyJt1P1AjJXBByU8InSZXVVxyBNaEYyS4gwr8W4gYxXe5BDwhRZi6kcfbX
gyY2Qk3A4Jx4I5oBEYt4ICKbZ5BLWODMUg4wTDMqyDtpiQ9tZcPEbtToJTrM2ZRx
QEIkViQsLlDTjzyCzoK3oXVi0cI4Gleqjsk7jKb5FwUAYSyxwCEwNX3KtyJ2NBin
nGUV+sBp2+fNK0B7MgCDoY5TmQ9hxiJeLQrDwIliX4n45izmczdp9iNtvqoJzSSN
KFmBUPWP
=ZEvK
-----END PGP SIGNATURE-----

--cAWnO79wyraTTylz--
