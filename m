Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3433ACD6E41
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 14:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9566E846D1;
	Wed, 27 May 2026 16:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QvBZRx6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BAAE846F8; Wed, 27 May 2026 16:41:45 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A65E844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-479d85152c9so4248877b6e.2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779892902; x=1780497702; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oWJX82wHxwQhf8Pn2IZj0Uam4CJ2JYYoaPu6Zl3qjJg=;
 b=QvBZRx6UgOv/8p09Ppb3sSX5g6tAn+eRUFGo04T6xaNwP+PUlPadrPHUeWzSoaZwXm
 ZREMj2Y2T1ytWEwz0vwjdAU9U6Z3AMRXzlGGDYytwMZyeh9E6i2ZLb9RYuz7bMq+zFBj
 aYPf0cN7p2cmnC2ou3+B4VkoTzVRkCRuWIg2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779892902; x=1780497702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWJX82wHxwQhf8Pn2IZj0Uam4CJ2JYYoaPu6Zl3qjJg=;
 b=sq+XujHW3tFw7n6J0Wy+tA4/dQeKoN9F+z3zkm76dyKGvUpiYcngjrMWuFcG8eQ28X
 GLqoiMk1ZB7BMHOxQW1lWsI9GbzLiaPhR1CyCeNVHoIeZN9BqbFDWYmJRZMJyue2jilj
 7OC+Ahz/mzt4O4m19xauXBiPpB4lQQqJMDK27ZvdQ4qPOxUpskHnvAKziFpDbGmDJHnb
 gyUloziTOIHdJw2Z/mAVusxGv58SzDtec/kPWEXf0DaPYCp5xAvmiXvr3k0CYx/ruuFg
 YjakR5OUx/4iJSAO7I8Tn73gf6M1fAx5OO/Fi528ckhSkhd1UbMHZyprAw5V0QcznYb8
 v4/w==
X-Gm-Message-State: AOJu0YzAvwqW723ZEooMa07IN2Jsx5mbGnSWjfT+2Ruz5WLAobh+OKf4
 I87jFKYMHpmLjjW/OUpL8euzlfSR5YF0VszTVJgd+3shVZiHR8fsey2UsOtAhBY9rjEFHEvSlvH
 8qmFNZF8=
X-Gm-Gg: Acq92OEdOOGdE+9K81Og4YvbKq+SrYovCQkLY5+zb6r6p5FJTUZnorU22JVNpVTEwwk
 6M4QOG22l7etyZIAxZ6E8sEy9L6eBLuz6XqWQfmxITI62r+Tnw+JUL3H+g3IgtGCWV3u+55R7AW
 c4TX5zhhPBa9AzYfPSHWvk7ZmI7xsk1Gf0eG++vsw3xtsfrOgG5JrkVJeC0aSOTANiKhfPomZ8b
 M6FKVxfqSz6woSc7+8icl8Q4MMwzIoi79Pae7bDk6uzPoznxjGgPeT/ktVmzASJqObipY2fcyan
 Ru29UNJcFPZQBGQS4NvaryuyaQfMDHnV0spXiSJ2UCv3ZgumdkNqJSZleGhVuQybiqkESr+lOzZ
 twLCyMgDGgjB+F7TYMS1o9syrCb3v36sZQNbj+PIK1aS+sTxJsQqtTT7tdGYBLfaijyqNMd2/Zv
 nKA8AhMfc2KceeyH7pZD+RaA18BGDKnvSZglB45rCP2ToJ6LEXMLvrlItJM/RrD6XxgR6fJ2L2n
 pFdKYaUNUmxdxPXtCXoJUIETwo34V1JASo6xD/swdOxhA==
X-Received: by 2002:a05:6808:c1fb:b0:47c:3768:3f89 with SMTP id
 5614622812f47-4854a27852amr15741660b6e.31.1779892902039; 
 Wed, 27 May 2026 07:41:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b63976d57sm16803257fac.9.2026.05.27.07.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 07:41:41 -0700 (PDT)
Date: Wed, 27 May 2026 08:41:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anton Ivanov <anton@binarly.io>
Subject: Re: [PATCH 2/2] dtc: libfdt: Introduce a can_assume check in
 fdt_check_full
Message-ID: <20260527144139.GD1858239@bill-the-cat>
References: <20260526202218.4004070-1-trini@konsulko.com>
 <20260526202218.4004070-3-trini@konsulko.com>
 <CAFLszTgeaOPAkcLR3eKm_s+feXMoHzs15ZY9KEnmM2wSrTNC+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pK/+8nykdgxGREc3"
Content-Disposition: inline
In-Reply-To: <CAFLszTgeaOPAkcLR3eKm_s+feXMoHzs15ZY9KEnmM2wSrTNC+w@mail.gmail.com>
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


--pK/+8nykdgxGREc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 11:41:26PM -0500, Simon Glass wrote:
> Hi Tom,
>=20
> On 2026-05-26T20:19:26, Tom Rini <trini@konsulko.com> wrote:
> > dtc: libfdt: Introduce a can_assume check in fdt_check_full
> >
> > The current upstream method of having a function omit various tests is
> > to use the can_assume macro. Take the logic we had previously been using
> > and instead make it a can_assume(PERFECT) check within fdt_check_full
> > itself.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> >
> > scripts/dtc/libfdt/fdt_check.c | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> > diff --git a/scripts/dtc/libfdt/fdt_check.c b/scripts/dtc/libfdt/fdt_ch=
eck.c
> > @@ -21,6 +21,8 @@ int fdt_check_full(const void *fdt, size_t bufsize)
> >       const char *propname;
> >       bool expect_end =3D false;
> >
> > +     if (can_assume(PERFECT))
> > +             return 0;
>=20
> Just to note that this of course affects image-fit.c too, so FITs are
> no-longer validated if used in SPL. People can change the mask though.

There's no functional change to what we have today, actually, really.

--=20
Tom

--pK/+8nykdgxGREc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahcCnwAKCRAr4qD1Cr/k
CnCgAPwNG8ze1vdRN94sZao7jLGU+P6I5JisjCCkf92q2+k0igEA/MLuJ1WUGhH2
jVHkq7jaEgOT4oYZSUOfPvPLEJ7O2g4=
=ehvJ
-----END PGP SIGNATURE-----

--pK/+8nykdgxGREc3--
