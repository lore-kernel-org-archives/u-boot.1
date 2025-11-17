Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA636CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 14:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FFB883956;
	Mon, 17 Nov 2025 15:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KlXzbHNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0AF839A1; Mon, 17 Nov 2025 15:21:12 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDEC683623
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 15:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-65745a436e6so626821eaf.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 06:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763389268; x=1763994068; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fIwUnRXCLoDvBytr7TNWl5kqvxtNHlQSrq5Pu4TldxI=;
 b=KlXzbHNe53dYT9igELn6qE68M0cT/iBfOn23JZgyDVn8cFZfSaHUSmU1z1zNFAoiEd
 TjWpmRYvg+Vc8u0A9/luAuUQBdPL6Jy3Esr/OHs1YxQepP3Vows4yBXQeUa8TaSr0b+Y
 TyRX/fBZ06nOitJQ1iLaF9fkHoNjXJI1EJo1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763389268; x=1763994068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIwUnRXCLoDvBytr7TNWl5kqvxtNHlQSrq5Pu4TldxI=;
 b=VfrePcTs0fyX7ia7fauZAIS0Uex9pq5CD0lJSqgoj4IliBwX26m9fY5BYiO04VBX59
 h08tVxUtbmwPdgiBVEGRYlDJUMzDDFjnjZJC2QR/+JE7nrDM9zqM3sEZ4lsDnq6KqLvh
 /HDKpdXcqMjyFIHOnmiZ0b8JBj6GAxNVXLyF0vc2SZoC2ZHYq7hrPAsZ3WqLIkgUqpNW
 PUyxa08VD9frK/Te+eoQj6cvf8B5K2fiK7pcpTC+2xZB1VYJi7nZXDPzHD0Kj9kvPO6b
 IGCNqMBu9ilmHtbXgLX83WEau9ugxSZz8ywTYYVv3zP+5jsr5jotcPSLlxxh0yNiEQRo
 VZtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm+zpWRm/CMFA5nsYoeXLDXeprI8Jyg2PlqwJm7MlYS81eapAqo2MRyNF6/7A3NGpjJB1a6sw=@lists.denx.de
X-Gm-Message-State: AOJu0YzpaseNm1FdyG2G/mouvFVfBGx/cSZaZKSJX5LvDRKtngBUjUo5
 o40Y6UC6TauyY7ds9nNGkgIiu+sI562rSHr/tWewptbN7K3RwlylWS9DqvICvY5kFxU=
X-Gm-Gg: ASbGnctcaNUmcnQb2xbubE6VhUXzTy+Em1flirSIYXkQAhbjgPLqHgKpvniP4kNxrXC
 cIhOPsNmdLAd0iOevhtODAui3nhavXhmNtwpj+i4B0t+VIIsZfQuwUEO7JA9nLSCJkJoZ4sEt7V
 Ewymu+Mp9iR7JbUETN+OgQ7FikhMvzKHcF/SBhLyhbMz4E73oTQbxeKrn6yd+djG35W+SxT7oOj
 FCLai8Y79RU2cMO5qcLli+E7RC+pQOlw2GH0algMgXqC3l7Hqlh+sexi1rtFQP9TZvsNC90MJs4
 jf2r8eM1hp9IAHzsaDHPr9Uc2QafT5xi2yqx5m2PeV7n/fKZNdpK0D5CXYzeER7L1kLhoXTsEwO
 vuQ/S3pzAoFirYaGVvSapDghaSenYEmS3dG9zY8rA32FwN06I8bhFSCY8UEH1IsvgNqJPCHW2IV
 T/ZYjpxW2nMO8c/WVzL/69oHx/9a7NRqOEfw7zMzk=
X-Google-Smtp-Source: AGHT+IEPIlv5DonLqrs8k3+Vw23B7cBCchsK07dZTC0lfVcHm569vJIFT+W7SWi59yBPw9+dbrmtYg==
X-Received: by 2002:a05:6820:290b:b0:657:4d77:55c4 with SMTP id
 006d021491bc7-6574d7756f8mr2331078eaf.2.1763389268506; 
 Mon, 17 Nov 2025 06:21:08 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6575c42ab42sm439266eaf.2.2025.11.17.06.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 06:21:07 -0800 (PST)
Date: Mon, 17 Nov 2025 08:21:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
Message-ID: <20251117142105.GG2125796@bill-the-cat>
References: <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
 <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
 <bed4a846-6356-463f-a8a9-3d4bf05439a4@mailbox.org>
 <CAFLszTiLZaMkCUxk2_x=gwKBxJeg-02iO-w=JufXEtqhqHZyTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ba4K9yj5Zznnd6Tw"
Content-Disposition: inline
In-Reply-To: <CAFLszTiLZaMkCUxk2_x=gwKBxJeg-02iO-w=JufXEtqhqHZyTA@mail.gmail.com>
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


--Ba4K9yj5Zznnd6Tw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 09:07:19AM -0700, Simon Glass wrote:
> Hi Marek,
>=20
> On Sat, 15 Nov 2025 at 17:20, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >
> > On 11/14/25 1:45 PM, Simon Glass wrote:
> >
> > Hello Simon,
> >
> > >>>>> Which is different from disagreeing with your specific feedback a=
bout
> > >>>>> how we get there, to be clear.
> > >>>
> > >>> And again, since your feedback to this patch was "Don't?", I'm sayi=
ng we
> > >>> need to. But the rest of your feedback was structural on moving tow=
ards
> > >>> resolving it and so I assume Marek will respond.
> > >>
> > >> The "blast radius" are these patches, that's all that tripped the te=
sts:
> > >>
> > >>    - boot: android: Always use 8-byte aligned DT with libfdt
> > >>    - test/py: android: Point fdt command to aligned addresses
> > >>    - test/py: Use aligned address for overlays in 'extension' test
> > >>    - sandbox: Fix DT compiler address warnings in sandbox DTs
> > >>    - sandbox: Fix DT compiler pin warnings in sandbox DTs
> > >>    - boot: Assure FDT is always at 8-byte aligned address
> > >>    - arm: qemu: Eliminate fdt_high and initrd_high misuse
> > >>    - efi_loader: Assure fitImage from capsule is used from 8-byte al=
igned
> > >> address
> > >>    - MIPS: Assure end of U-Boot is at 8-byte aligned offset
> > >>
> > >> Regarding last minute alignment, the problem with this android image
> > >> seems to be in the android image itself, which packs in badly aligned
> > >> FDT. We therefore have to copy it out and realign.
> > >
> > > My request is to implement these checks as part of the boot flow
> > > (bootm, etc.) rather than adding memory allocations in leaf function.
> > > We already support copying the FDT to a different address so we can
> > > expand it and add things. Can we make use of that code?
> > It seems the 'abootomg' command is extracting DTB from a container where
> > the DTB can be at 4-byte aligned address. Thus far, the command
> > internally used that possibly 4-byte aligned address, which is wrong. It
> > also returned that address which was used by further U-Boot commands
> > as-is, which is also wrong.
> >
> > This DTB usage here has nothing to do with any boot flow, this is
> > incorrect DTB alignment during manipulation, which is not part of boot.
> >
> > What exactly do you propose should be changed with this patch ?
>=20
> Actually this patch seems to adjust code which is just handling a
> command. How about creating a common function which can put an FDT
> into an abuf, either just using it in place, or allocating memory and
> copying it? An abuf is ideal for this. E.g. something like (untested):
>=20
> /**
>  * fdt_ensure_aligned() - Obtain an abuf with a devicetree, aligning if n=
eeded
>  *
>  * @buf: Returns abuf containing FDT on success; caller must abuf_uninit(=
buf)
>  * @addr: Address of FDT
>  * Return: 0 on success, -EINVAL if not an FDT, -ENOMEM if out of memory
>  */
> int fdt_ensure_aligned(struct abuf *buf, void *fdt)
> {
>    struct fdt_header fdth __aligned(8);
>=20
>    memcpy(&fdth, fdt, sizeof(struct fdt_header));
>    if (fdt_check_header(&fdth) !=3D 0)
>       return -EINVAL;
>=20
>    abuf_init_const(buf, fdt, fdt_totalsize(&fdth));
>=20
>    /* The device tree must be at an 8-byte aligned address */
>    if ((uintptr_t)fdt & 7) {
>       void *fulldt;
>=20
>       // a function like abuf_realloc_align(struct abuf *buf, int
> align) would help
>       fulldt =3D memalign(8, buf->size);
>       if (!fulldt)
>          return -ENOMEM;
>=20
>       memcpy(fulldt, fdt, buf->size);
>       buf->data =3D fulldt;
>       buf->alloced =3D true;
>    }
>=20
>    return 0;
> }
>=20
> Then you can use this in various places as needed.

That looks like massively more code than is needed to just ensure that
the thing we deal with today is also correctly aligned? We don't need to
pull abuf into everything.

--=20
Tom

--Ba4K9yj5Zznnd6Tw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRsvUQAKCRAr4qD1Cr/k
CjJCAQD1DLkNZ06JZyDzpY10vW/lUY5H9r88M4qUXCd6BDQa1wEAx23pl23qUvxd
6BmDL3/SUIiSXtZe/1ELRpfEn54xUwQ=
=6eAP
-----END PGP SIGNATURE-----

--Ba4K9yj5Zznnd6Tw--
