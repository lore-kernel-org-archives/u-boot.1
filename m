Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AE1CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 18:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A7F83BDD;
	Mon, 17 Nov 2025 19:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hp98GPDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF76683BE1; Mon, 17 Nov 2025 19:02:21 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9567483AEF
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 19:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3e3dac349easo2564035fac.2
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763402538; x=1764007338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RiYlk0l3hx967h0yKFHyR17JXN/ETHK1i9NMNf+pdL8=;
 b=hp98GPDGCf5I6JHO6cp2hTAjE4FmfS3S7Cx3pxrmnXfBHmtpOiL3/KeIdXGlgnzRmH
 JhjnKcH6glI0tkCTLdgyeqoNE6On0bP4j4zsBEkfUzqVipaAIPtp/Q9tP6Avewgea6gk
 vanrgZ+znZc+mZBTuJveNAuesG4IRzz0RV/6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402538; x=1764007338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RiYlk0l3hx967h0yKFHyR17JXN/ETHK1i9NMNf+pdL8=;
 b=GscpebZbhAxKyTczrXpGLIU+AQxC+lXlzxr+0G2lDjan7FggWT3jBJY8bLfFDDQB+r
 lJ0PzsJ6vtQfAftzT2lzmDrXBETTkyh42QAAoH+0QVol3H+dKEMB2EZOlWjhwzFuCBTQ
 LrrC5CjtPmBesZSWE6+tARZ1DZDx+zbm0NndUfIFr2RrqPGiuU7X/MM30abM3xQg/C0Q
 wy5+AIErX5NWqlTHZMAB6JIS7NXma8LEwuzrp4WdwdzHV6kkuqdJx5HkFR35Ba1adoGB
 Y1TqFFMGU1DFn48c38qA+xe73C6ZiUWzK4jpEU/1MGQpYNJaMaQimR2pg8Nbb+H1DQ96
 4yvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP19Yimdv7lmaNsccw82Qj/viesObvgYaAwghDGe2Ds/+S2mNOvI6ldbS03vrUOHZ8AR8Jvqk=@lists.denx.de
X-Gm-Message-State: AOJu0YxmHEBAM3vtO0yA8wRqy5ll/lrbi22rJ3dDY4TfTH1t83u+tsTK
 rCIX5uqYYbz1DKaif3LdVafDSd9bR4tG/MTUmN4Jf5klJ12CjkIMJ5bOFJ2XWF6Ogb4=
X-Gm-Gg: ASbGncuo9JkAnMPtx0fGc9zJA1WDTSpBK1GIabeQ5NcKs7vB8a1s7W8pi+tAkbQAHzB
 Fch3Zi5UDRwbRlJd3hfXHV5DcxmQBdDSeB1EtsO7gqLZLkhMYF6lnbbkqOhJ7vCGKTSv5JAs4Ac
 2HXZKrmvihik6Btu+ZIQi+y198FNmsJ8zXtRQOaRXhlnNmv48/lU9jSmolOgOfMo+nZQYWqZyyz
 BE/rDWChU6vQ/VyBBhxIJs+KoBgHWCO48szslDq+ylcorhUXz25uYYhgLiVKEld1mntPbHgfjpS
 wSW7HlUJRjtA5FqyNZc0stpDUsb0JT1QAhcz8uVI1Wd8zFlJdgUms+cSpu/mDCP4x8UkLs23khK
 5lHhSf7TiPd7Jaw9wm48Yor3dgkonPc1A0ABmKRYursNLvAksCf4DyBUzmYxEyI8NEb2WFMf44h
 1pBU0CSXRYDsy8Zi0hPyK11Uk+YIqwnm/Fx6Rog6CjNWisYw5sKQ==
X-Google-Smtp-Source: AGHT+IFkdG6Z9v23oF6GZGGeBYCDjC7cknemgs15+FBMgOL/bYpAtIiDXnJweDPy5eMdXMXBwRRjZA==
X-Received: by 2002:a05:6871:79c:b0:3d1:93ab:eaa2 with SMTP id
 586e51a60fabf-3e868f4f18amr5541952fac.20.1763402538131; 
 Mon, 17 Nov 2025 10:02:18 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c75610f638sm2258832a34.21.2025.11.17.10.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 10:02:17 -0800 (PST)
Date: Mon, 17 Nov 2025 12:02:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
Message-ID: <20251117180215.GL2125796@bill-the-cat>
References: <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
 <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
 <bed4a846-6356-463f-a8a9-3d4bf05439a4@mailbox.org>
 <CAFLszTiLZaMkCUxk2_x=gwKBxJeg-02iO-w=JufXEtqhqHZyTA@mail.gmail.com>
 <20251117142105.GG2125796@bill-the-cat>
 <CAFLszThiza12FcSeEVg3xWJcP1zZVrfxDgTDT4mZNfEUKvZpWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4nWBzPJ69P0hbAT8"
Content-Disposition: inline
In-Reply-To: <CAFLszThiza12FcSeEVg3xWJcP1zZVrfxDgTDT4mZNfEUKvZpWQ@mail.gmail.com>
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


--4nWBzPJ69P0hbAT8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:04:00AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Nov 2025 at 07:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Nov 16, 2025 at 09:07:19AM -0700, Simon Glass wrote:
> > > Hi Marek,
> > >
> > > On Sat, 15 Nov 2025 at 17:20, Marek Vasut <marek.vasut@mailbox.org> w=
rote:
> > > >
> > > > On 11/14/25 1:45 PM, Simon Glass wrote:
> > > >
> > > > Hello Simon,
> > > >
> > > > >>>>> Which is different from disagreeing with your specific feedba=
ck about
> > > > >>>>> how we get there, to be clear.
> > > > >>>
> > > > >>> And again, since your feedback to this patch was "Don't?", I'm =
saying we
> > > > >>> need to. But the rest of your feedback was structural on moving=
 towards
> > > > >>> resolving it and so I assume Marek will respond.
> > > > >>
> > > > >> The "blast radius" are these patches, that's all that tripped th=
e tests:
> > > > >>
> > > > >>    - boot: android: Always use 8-byte aligned DT with libfdt
> > > > >>    - test/py: android: Point fdt command to aligned addresses
> > > > >>    - test/py: Use aligned address for overlays in 'extension' te=
st
> > > > >>    - sandbox: Fix DT compiler address warnings in sandbox DTs
> > > > >>    - sandbox: Fix DT compiler pin warnings in sandbox DTs
> > > > >>    - boot: Assure FDT is always at 8-byte aligned address
> > > > >>    - arm: qemu: Eliminate fdt_high and initrd_high misuse
> > > > >>    - efi_loader: Assure fitImage from capsule is used from 8-byt=
e aligned
> > > > >> address
> > > > >>    - MIPS: Assure end of U-Boot is at 8-byte aligned offset
> > > > >>
> > > > >> Regarding last minute alignment, the problem with this android i=
mage
> > > > >> seems to be in the android image itself, which packs in badly al=
igned
> > > > >> FDT. We therefore have to copy it out and realign.
> > > > >
> > > > > My request is to implement these checks as part of the boot flow
> > > > > (bootm, etc.) rather than adding memory allocations in leaf funct=
ion.
> > > > > We already support copying the FDT to a different address so we c=
an
> > > > > expand it and add things. Can we make use of that code?
> > > > It seems the 'abootomg' command is extracting DTB from a container =
where
> > > > the DTB can be at 4-byte aligned address. Thus far, the command
> > > > internally used that possibly 4-byte aligned address, which is wron=
g. It
> > > > also returned that address which was used by further U-Boot commands
> > > > as-is, which is also wrong.
> > > >
> > > > This DTB usage here has nothing to do with any boot flow, this is
> > > > incorrect DTB alignment during manipulation, which is not part of b=
oot.
> > > >
> > > > What exactly do you propose should be changed with this patch ?
> > >
> > > Actually this patch seems to adjust code which is just handling a
> > > command. How about creating a common function which can put an FDT
> > > into an abuf, either just using it in place, or allocating memory and
> > > copying it? An abuf is ideal for this. E.g. something like (untested):
> > >
> > > /**
> > >  * fdt_ensure_aligned() - Obtain an abuf with a devicetree, aligning =
if needed
> > >  *
> > >  * @buf: Returns abuf containing FDT on success; caller must abuf_uni=
nit(buf)
> > >  * @addr: Address of FDT
> > >  * Return: 0 on success, -EINVAL if not an FDT, -ENOMEM if out of mem=
ory
> > >  */
> > > int fdt_ensure_aligned(struct abuf *buf, void *fdt)
> > > {
> > >    struct fdt_header fdth __aligned(8);
> > >
> > >    memcpy(&fdth, fdt, sizeof(struct fdt_header));
> > >    if (fdt_check_header(&fdth) !=3D 0)
> > >       return -EINVAL;
> > >
> > >    abuf_init_const(buf, fdt, fdt_totalsize(&fdth));
> > >
> > >    /* The device tree must be at an 8-byte aligned address */
> > >    if ((uintptr_t)fdt & 7) {
> > >       void *fulldt;
> > >
> > >       // a function like abuf_realloc_align(struct abuf *buf, int
> > > align) would help
> > >       fulldt =3D memalign(8, buf->size);
> > >       if (!fulldt)
> > >          return -ENOMEM;
> > >
> > >       memcpy(fulldt, fdt, buf->size);
> > >       buf->data =3D fulldt;
> > >       buf->alloced =3D true;
> > >    }
> > >
> > >    return 0;
> > > }
> > >
> > > Then you can use this in various places as needed.
> >
> > That looks like massively more code than is needed to just ensure that
> > the thing we deal with today is also correctly aligned? We don't need to
> > pull abuf into everything.
>=20
> It is 27 lines of code, less than Marek's delta. Plus by the sounds of
> it, we can call it from more than one place. I think it is better to
> have a common function than to open-code this stuff in multiple
> places. I also think separating out the map_sysmem() stuff would make
> sense, since it is a bit convoluted at present.
>=20
> Re abuf I believe it is a useful abstraction and I wish I had thought
> of it some years ago. It is particularly good when you may or may not
> need to allocate something. Should we discuss abuf in one of the
> U-Boot meetings?

No, I think you've lost the thread on some of the problems
unfortunately.

--=20
Tom

--4nWBzPJ69P0hbAT8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRtjIwAKCRAr4qD1Cr/k
ClURAQDJwjIVD/lAAs+GcR/+1b6m0XuNhJUanBRnK/adzNezewD/UF3rtBkb5zjo
lstjdQziMC+0RNFnCXSTq+G1h+GPKAg=
=G1bz
-----END PGP SIGNATURE-----

--4nWBzPJ69P0hbAT8--
