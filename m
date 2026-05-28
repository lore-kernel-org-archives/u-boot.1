Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A20CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 18:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7709584659;
	Thu, 28 May 2026 20:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dafqs0Pt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0CF7846AE; Thu, 28 May 2026 20:18:07 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8901D84659
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 20:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-43acb9730f4so8291072fac.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779992284; x=1780597084; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uboOc+5EsnvrBl8Og0ZtiJuPURBagTiWtFjYTH5dOA4=;
 b=dafqs0Ptm8s3Hl7ZkLsJsYhzvMi3OlIuVNjdC6ndntjC6wG3ZOYHgpT0TTKNeZaACi
 hBq57WqFMZ4hzglewwfzWsXn7+JyVgRnsxrjFbRctZkgj0+HSi0cjOehneDfEsKXZMkb
 yrWfttbVS5JmbRPhwikeRLPP1/jdxOuRPYLBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779992284; x=1780597084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uboOc+5EsnvrBl8Og0ZtiJuPURBagTiWtFjYTH5dOA4=;
 b=fZAabzRAIVsBB2lFL09o83HOz5MB/uwE+K/vY+Xgve2Xw2hmgQZ62/rSnzZJIdwtdp
 5ibVnzSZ6xUkjOX8E1xz12yzqXbdtHvTcffU9TSCxDw28mQ0hWs9koqXnDrkCMimMABi
 NNpc4mXw1X1nH+qby7DyiYEZpSS1UOhy64ONWlZQw44fCg99eWD5Jq3FkWFu7lHAu1N6
 R0si09+ow4brYCSQg0WJN+iJq/7xJHqTLfBbz8/f+6YwD0MftopK3Hs173BolJY7djnA
 5vL6e5YFUBnefnFPyAlw4hxaSlJrN1xQvNJN8jTD19KHs3iAUqRMUaZOBQ+2tew/TLmE
 7U2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bawWyd+lh/jjIM6CGaQMvNDbXJ5uKpng1kvlyQ6+DMwpZxPAIjNwl0vIRN7xMqp/OVv5fN+Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2dVvXHz/YAfqzNVacyFg275XOuqoXRrDriqK74lDsNRrTV7bS
 stKrXGRswBgNKDHzacfBtzUO1IlwS7qH+LoW5SZTBw71yzp51PCkYCsxe4Unge0zZdY=
X-Gm-Gg: Acq92OFylLHu7OywisRGbkZbgUSHfEuCc3e/8KnB5wme+Q/lQYIJq6cY6LaNBq7twDS
 EVIklk9te8s4KwcjfuHUmRT/8gtSRQjiOyBi4j0YrRaleQpgfYYIyCuEJP4W9RPmVUVwdYlp35w
 AsjJjETO1kgdKvzFmcvLQIb2ikax3lFqViAagEcU1c3Rr9YcQ5W6g/H17himAZmft2dvm7cv7rL
 CuYq661iQcsoEudXBcVqTUyNnhIkKD28Z4L+Fti+1T0iTtG+c/fZhq1rdpmXNzL9/PlyBlSuQSW
 3vTJgZYQcMsWCDk2mFjcLtZ+1ucgeatB9juiCgiFd5wvlMg9mJnK4HbutvzI09Iv4HmWxkDsvdU
 xFYlOyxodcL/16A+beZ7hD16cUbM6q4OSgyPYyid/Gas6Ra/H5ZdhbJyIA32/P1SuxkVwGjI6d9
 ts0PxIY/DVaHNaqoayQJQ+KSsRg4pSXwaRWvKrcUfI6juWkBvjCEcx1ClDgMotrLmbMENy9Wuce
 D2xmM1lPLrRECmJJ70TnzuP5BrPRYQlovqb8QBP3UuE0sO1mwVyI9YF
X-Received: by 2002:a05:6870:a787:b0:43a:c821:19b2 with SMTP id
 586e51a60fabf-43b5ab0a5famr16003627fac.15.1779992284245; 
 Thu, 28 May 2026 11:18:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b63a15569sm20680396fac.16.2026.05.28.11.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 11:18:03 -0700 (PDT)
Date: Thu, 28 May 2026 12:18:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 02/13] alist: Allow inclusion from OS headers
Message-ID: <20260528181801.GG93986@bill-the-cat>
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-3-sjg@chromium.org>
 <6fc3e71a-8872-4c35-969a-f54ce2869947@gmx.de>
 <20260527194345.GA93986@bill-the-cat>
 <CAFLszTh+vVMydNuHwJsK8J6adZX-ptiYvWSYza-QKEZ-XQnAcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z0Y+hp+Aou1d2d23"
Content-Disposition: inline
In-Reply-To: <CAFLszTh+vVMydNuHwJsK8J6adZX-ptiYvWSYza-QKEZ-XQnAcg@mail.gmail.com>
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


--Z0Y+hp+Aou1d2d23
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 12:12:09PM -0500, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 27 May 2026 at 21:43, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 27, 2026 at 08:36:45PM +0200, Heinrich Schuchardt wrote:
> > > On 5/27/26 18:10, Simon Glass wrote:
> > > > Sandbox needs to include system headers in some files, but also wan=
ts
> > > > to use alist. Adjust the headers to permit this.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >   include/alist.h | 16 +++++++++++-----
> > > >   lib/alist.c     |  1 +
> > > >   2 files changed, 12 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/alist.h b/include/alist.h
> > > > index b00d9ea97d6..69d7cdb722f 100644
> > > > --- a/include/alist.h
> > > > +++ b/include/alist.h
> > > > @@ -10,8 +10,14 @@
> > > >   #define __ALIST_H
> > > >   #include <stdbool.h>
> > > > -#include <linux/bitops.h>
> > > > +
> > > > +#ifdef USE_HOSTCC
> > > > +#include <sys/types.h>
> > > > +#include <stdint.h>
> > > > +#else
> > > >   #include <linux/types.h>
> > > > +#endif
> > > > +#define BIT(nr)                    (1UL << (nr))
> > >
> > > BIT(nr) is already defined in include/linux/bitops.h.
> > >
> > > We must not assume that no module includes both alist.h and linux/bit=
ops.h.
> > > E.g. include/expo.h and include/lmb.h include both alist.h and
> > > linux/bitops.h. We should avoid redefinitions.
> > >
> > > The following is an abuse of the enum type:
> > >
> > > enum alist_flags {
> > >         ALISTF_FAIL     =3D BIT(0),
> > > };
> > >
> > > As this is the only use of BIT(), we could simply use the value "1" h=
ere.
> > >
> > > #define ALISTF_FAIL (1)
> > >
> > > But as ALISTF_FAIL is the only bit in flags used, the best solution w=
ould be
> > > replacing flags by a boolean called fail.
> >
> > I see this as another reminder about how frustrating it was that alist
> > was introduced under the guise of "must have this for an x86 feature"
> > but instead is a solution in need of a problem to solve, and whenever
> > it's used for something else, yet another problem with it is shown.
>=20
> The alist was motivated by its original commit. It allows easy
> iteration, uses less memory (no next/prev pointers in every element),
> uses fewer allocations than linked lists (one malloc() for the whole
> list instead of one for each node) and has much better cache locality
> as a result (i.e. improved performance).
>=20
> I asked my friendly AI to compare them:
>=20
>   - Reach for alist when you want a growable, index-addressable, cache-fr=
iendly
>   collection of small value objects you mostly append to and iterate (e.g.
>   bootflow/bootdev scan results, parsed tables).
>   - Reach for list_head when elements need O(1) removal/splice from arbit=
rary
>   positions, must keep stable identity while linked, or already exist as
>   independently-allocated objects (most driver-model / subsystem object l=
ists).
>=20
>   One nuance: alist_for_each is pure pointer arithmetic over the buffer, =
whereas
>    list_for_each_entry uses container_of to recover the enclosing struct =
=66rom
>   the embedded node =E2=80=94 a direct consequence of array-of-values vs.
>   intrusive-links.

This changes absolutely nothing about what I said the last time you
wanted to use alist more widely, and in turn what I said about it a year
ago, or whenever that was. I'm not going to go ask an unfriendly AI to
say what's wrong with alist, I'm just going to say that I already said
it.

--=20
Tom

--Z0Y+hp+Aou1d2d23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahiG2QAKCRAr4qD1Cr/k
CirpAQDRaf9xn769f6HCIQcdHOC92hlx2KEzIBcDTwPmdl/B8AD+KKVi77+cQ+89
vVLlAYGcfBurq6jjT4TaPu+rRg8Kqgk=
=7uXs
-----END PGP SIGNATURE-----

--Z0Y+hp+Aou1d2d23--
