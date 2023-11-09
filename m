Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392E1C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 02:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078BC870DD;
	Thu,  9 Nov 2023 03:42:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y6hiafjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA430870A4; Thu,  9 Nov 2023 03:42:54 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37ECE870E1
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 03:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66d0c777bf0so2567466d6.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 18:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699497769; x=1700102569; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ygYhUE4xYLYtUVIlmrNUqFD1F+EJanhEVRbUoAxINRQ=;
 b=Y6hiafjS9ebdS5QCF8O0PXsetpwfvN63WXvvyclrNl1P2gkSglFYnq4dUgrC1Vpfi2
 aY5iLRB+m9JWv2kx4aQSs5ff76ErGttnTxFudqlavwfi80rP3LpQ9yjV3pLauUy8zLzi
 htZN53Y2/9SmvHa1cxJkflrTvnLHfPKPfcMmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699497769; x=1700102569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygYhUE4xYLYtUVIlmrNUqFD1F+EJanhEVRbUoAxINRQ=;
 b=MAuwxGsQ6OnsjvYx4JZEm371ey59/hDWrbhS6ZVJXHHzANAADXMmYM6oFDS41INUil
 LhS3HV3c1JHsGFOrP1hTpiaE/rOug7XlBjlQMq6guIdLs/gu1qc7w7sxctuaa/7UbECU
 YZBj7Sj8/imVbLBIhG2tDNVkKheCNZ7NgvELv+Q9DRkhc5NJKYS0Im3AXdVS1N6lX8Ip
 TFLrE1wa37ClVglI8QS0jkSvgu8RglwnH1fCM3IA/WGMz1PkdZrWGFdNxAfQylpEbWz3
 ZOMRv9p3hM/NAv+mIMYiZNJbxJhIoYKcr2vFzjs98JYTwtoHPlnMwm4aG53VxipPW0vo
 I7iQ==
X-Gm-Message-State: AOJu0YyZ6IkcgubKqOIxfPYQfLyjbibaPOo+Bg4cRd8rAxcIztNaih0x
 ZB7VASxJN8NQl0NrSActkjjSzA==
X-Google-Smtp-Source: AGHT+IEIFYAH+HkJ957X+X9146zwnpmoa8zJuYuoSgggh/FVgSeUN0dmtYXy/S23YkFCpk5BMGjKkw==
X-Received: by 2002:a05:6214:21ac:b0:66d:1e25:9777 with SMTP id
 t12-20020a05621421ac00b0066d1e259777mr3702487qvc.64.1699497768878; 
 Wed, 08 Nov 2023 18:42:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a0562140b2b00b0065b21b232bfsm1683786qvj.138.2023.11.08.18.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 18:42:48 -0800 (PST)
Date: Wed, 8 Nov 2023 21:42:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v11 00/24] Modernize U-Boot shell
Message-ID: <20231109024246.GZ6601@bill-the-cat>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
 <CALeDE9PChRKwgZfTR6-fuOR7pThzDynj44UvPVVw3P19_wGujA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MUuc8B6ClpPYIKQH"
Content-Disposition: inline
In-Reply-To: <CALeDE9PChRKwgZfTR6-fuOR7pThzDynj44UvPVVw3P19_wGujA@mail.gmail.com>
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


--MUuc8B6ClpPYIKQH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 12:14:28PM +0000, Peter Robinson wrote:
> On Wed, Nov 8, 2023 at 12:49=E2=80=AFAM Francis Laniel
> <francis.laniel@amarulasolutions.com> wrote:
> >
> > Hi.
> >
> >
> > During 2021 summer, Sean Anderson wrote a contribution to add a new she=
ll, based
> > on LIL, to U-Boot [1, 2].
> > While one of the goals of this contribution was to address the fact act=
ual
> > U-Boot shell, which is based on Busybox hush, is old there was a discus=
sion
> > about adding a new shell versus updating the actual one [3, 4].
> >
> > So, in this series, with Harald Seiler, we updated the actual U-Boot sh=
ell to
> > reflect what is currently in Busybox source code.
> > Basically, this contribution is about taking a snapshot of Busybox shel=
l/hush.c
> > file (as it exists in commit 37460f5da) and adapt it to suit U-Boot nee=
ds.
> >
> > This contribution was written to be as backward-compatible as possible =
to avoid
> > breaking the existing.
> > So, the 2021 hush flavor offers the same as the actual, that is to say:
> > 1. Variable expansion.
> > 2. Instruction lists (;, && and ||).
> > 3. If, then and else.
> > 4. Loops (for, while and until).
> > No new features offered by Busybox hush were implemented (e.g. function=
s).
> >
> > It is possible to change the parser at runtime using the "cli" command:
> > =3D> cli print
> > old
> > =3D> cli set 2021
> > =3D> cli print
> > 2021
> > =3D> cli set old
> > The default parser is the old one.
> > Note that to use both parser, you would need to set both CONFIG_HUSH_20=
21_PARSER
> > and CONFIG_HUSH_OLD_PARSER.
> >
> > In terms of testing, new unit tests were added to ut to ensure the new =
behavior
> > is the same as the old one and it does not add regression.
> > Nonetheless, if old behavior was buggy and fixed upstream, the fix is t=
hen added
> > to U-Boot [5].
> > In sandbox, all of these tests pass smoothly:
> > =3D> printenv board
> > board=3Dsandbox
> > =3D> ut hush
> > Running 20 hush tests
> > ...
> > Failures: 0
> > =3D> parser set 2021
> > =3D> ut hush
> > Running 20 hush tests
> > ...
> > Failures: 0
> >
> > Thanks to the effort of Harald Seiler, I was successful booting a board:
> > =3D> printenv fdtfile
> > fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> > =3D> cli get
> > old
> > =3D> boot
> > ...
> > root@lepotato:~#
> > root@lepotato:~# reboot
> > ...
> > =3D> cli set 2021
> > =3D> cli get
> > 2021
> > =3D> printenv fdtfile
> > fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> > =3D> boot
> > ...
> > root@lepotato:~#
> >
> > I had to not use CONFIG_HUSH_2021_PARSER for the keymile board.
> > Indeed, the keymile board family is the only set of boards to call
> > get_local_var(), set_local_var() and unset_local_var().
> > Sadly, these functions are static in this contribution.
> > I could have change all of them to introduce code like this:
> > *_local_var(/*...*/)
> > {
> >         if (gd->flags & GD_FLG_HUSH_OLD_PARSER)
> >                 return *_local_var_old(/*...*/);
> >         if (gd->flags & GD_FLG_HUSH_2021_PARSER)
> >                 return *_local_var_2021(/*...*/);
> > }
> > But this would have mean renaming all old hush functions calls and I di=
d not
> > want to change the old hush particularly to avoid breaking things.
> > Instead, I change the keymile board to use environment variable instead=
 of local
> > ones.
> > I think this particularities can be addressed in future works.
> >
> > I also had to enable CONFIG_LTO for kirkwoord sheevaplug and phytec bk4=
r1, so
> > they do not hit their limits.
>=20
> With nearly 15K lines of code added and the above limits being reached
> how much does this increase the size of a binary if it's selected?
> Those sorts of details are useful in these cover letters. Also of the
> 13k lines in cli_hush_upstream.c how much of that functionality is
> actually used in U-Boot? You mention functions are not, while I
> understand adding it straight from busybox has it's advantages for
> easier rebasing, if it's also pulling in a lot of code that is never
> used there's also detractions to adding 13k lines of code.

I've put the world build on current next, before/after this series over
at: https://gist.github.com/trini/53d9a3d59c797ecdbb3aec8edbbb9a12 and
I'll have more commentary (aside from dropping common.h) tomorrow.

--=20
Tom

--MUuc8B6ClpPYIKQH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVMRyMACgkQFHw5/5Y0
tyzAOgv/cajX1tUA7Wa3N4ZG25LjnIJq9ctxcwR6IEVHzBtjK/8WKRYEQwNhlVw4
0ofc8JWRGOlvgL/hOEAYmKeFbJIieDzLPuBHcEo8DyO+t96AcviHHimb40ld4Jug
y8lgSwREDXmZd5P00FD1WFbhlr07ilu/Ca1aRyR1mFRDlQfoyubLNQWdTQtHdEMF
9F9vO56rfJrQCVMdPcegzTBj/s+oPv3gUObb1vcQiiITs2izxH214qeUmLlEc0J2
TrtvLvYCI47dVsnIioWHkbQe0j1kDBuLj1K0RwsMW8F9JJsBO3Ge1FnMUl+NGshp
libnRulfvzNjzFASuH6Spo/GinvY1wAtqT4fJMwItD7nwIhnYgOk+jssQz958WkJ
XyX8QhlbyCZt5SdU+BYGAhO0HLCrCYx9J9hGjxgrgQ8N96tJ5tijsETlcbI61yVZ
YPBmyX3jnptWLzJXNUZlGHtiD2xdzTBshTZ8s4Puj+kTm96hqFeYlaMEv6sxd0LB
dr6QIE97
=ILA0
-----END PGP SIGNATURE-----

--MUuc8B6ClpPYIKQH--
