Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6AEE77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF728069A;
	Wed, 15 Jan 2025 02:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Htv/jSe6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A4E8069A; Wed, 15 Jan 2025 02:41:29 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 244BB8060C
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6e9586b82so521140585a.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736905286; x=1737510086; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s1gi4fHzaBC3ykExHgBjWxEDJ1zewX9IGhKrx40yvO0=;
 b=Htv/jSe6HHG4vi70qLk+SkeBm8dRrKsB5YpkE0sP1aRkQwTZWI3zU8pbJZF2R0HF3Q
 xyLzmFeGQxUmab6oLuL7pEuTnett7JVeCa1YYwyra9F87nple3jR9sxdhYnZdU9lkNwZ
 QgyvUDoygi2W0hVJEarAdsqiibnIiguct12nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736905286; x=1737510086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1gi4fHzaBC3ykExHgBjWxEDJ1zewX9IGhKrx40yvO0=;
 b=nOEbP+hWdikL+r+aDqyPaHUfnsqQqQBMx1tWnSmlEgukubg6wURawERnO1RSOp2mnw
 4GaJ4QqQ0rXeqKowoYkDMzPjJiqV+uA0+Aqg0fOTSoyWbkN8N3kl8MA76CHlHEgx5ih8
 5FL0osT1t62yyaQnEuSmc93otj9ALPAwJBFAff4zqIXxWz/aLQ3V9fEk6pPTEfixOXt5
 j69weSrdk/4nCgalHzeuty/LUTvJV/lYku0K90g2uULiI21jCy40hINsRqiXbeO0Kf0U
 deeSmtv1OxxSTsWKlMlmKKOHBQ7L/LUuelZUss8RxCabtov5mo0bW8B+q28E6nIbECxP
 Rrfw==
X-Gm-Message-State: AOJu0YwGnxhnN2Cu8itcImTLoR5mr6bp/S09vVa7rMq25fGHkbS8C/Ky
 f3x+BWPSxSeUZEIZrUPBshxr93LGSY1xqiconFiO7JiLbYP+JCEO1PhYA4nchV7uqc8e1joltkr
 x
X-Gm-Gg: ASbGncvZXcATiXZ6GuZLCR5uxFaSOJVckwQPVCrv5Uje58WaNFaGtnzOZtYEpGDoDxR
 dr1NfZYutM4ePBUBiIv6bo8qz5gqyKvMNgH2FgeFxhj2e25JJUqaAaqd+ZR/RZtozhhHRFfJq5A
 IkK/9aofL+NCJXUvqBmAkE/KXO+iSBJAMwizvuV0QLxyniClCmf8TrGSuwYBaigiVLYmbdvNkBV
 +bBwFewM7lvnmgdO4aKTFAlE/mONmNXRqrkI+xelrLFkYr+f+hqJg==
X-Google-Smtp-Source: AGHT+IH+bjEPozdeEt6sqcbislO/kPhEaAsTD34FAoJkMInluSXEIDAIcMcx0y3VxhozxwL/VVa2UA==
X-Received: by 2002:a05:620a:24c6:b0:7b6:f34b:cdd2 with SMTP id
 af79cd13be357-7bcd97a4e6cmr4892402585a.53.1736905285898; 
 Tue, 14 Jan 2025 17:41:25 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce350393dsm666008485a.89.2025.01.14.17.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:41:24 -0800 (PST)
Date: Tue, 14 Jan 2025 19:41:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 01/15] vbe: Split out some VBE code into a common file
Message-ID: <20250115014121.GT3476@bill-the-cat>
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-2-sjg@chromium.org>
 <20250114012226.GG3476@bill-the-cat>
 <CAFLszTj9zAE_KniCZ2xHGHt1fK7jhTBHzfkdSif6XNuzKtWOTA@mail.gmail.com>
 <20250114165801.GJ3476@bill-the-cat>
 <20250114173343.GO3476@bill-the-cat>
 <CAFLszTi1epQ+6AGMK_pkjnTQmDU8--xS-NXfk5iM=q_wi6xyWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a/0N2A5lx+myxqXI"
Content-Disposition: inline
In-Reply-To: <CAFLszTi1epQ+6AGMK_pkjnTQmDU8--xS-NXfk5iM=q_wi6xyWw@mail.gmail.com>
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


--a/0N2A5lx+myxqXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 06:18:26PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 14 Jan 2025 at 10:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 10:58:01AM -0600, Tom Rini wrote:
> > > On Tue, Jan 14, 2025 at 05:58:04AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 13 Jan 2025 at 18:22, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jan 09, 2025 at 05:29:56AM -0700, Simon Glass wrote:
> > > > >
> > > > > > Loading a FIT is useful for other VBE methods, such as ABrec, s=
o start
> > > > > > a new common file. Add functions for reading the version and nv=
data.
> > > > > > Also add a function to get the block device.
> > > > >
> > > > > This is not a good commit message when you're also introducing
> > > > > functional changes (blk_dread -> blk_read).
> > > >
> > > > Yes, I did not actually notice this size change at all, as mentione=
d,
> > > > as I only built for a few boards (firefly rk3399/rk3288 and a few
> > > > sandbox ones). The blk_dread() function is the old API for reading
> > >
> > > You have much faster build machines available than I do, it would be
> > > good to run a world build before/after (it might take an hour on
> > > alexandra) before posting these big series.
>=20
> OK. I used to do this, but with CI sometimes grabbing the machines it
> ends up with a huge load and sometimes runs out of memory. I suppose I
> can stop the runner before doing it and remember to restart it
> afterwards. Or perhaps Alex has enough memory per thread? (96GB).

Personally, I would make the script that does the world build for size
test turn off the runner before starting and turn it back on when done
otherwise build time will suffer greatly and you would have been better
served doing it all on a slower class of machine.

>=20
> > >
> > > > from a block. It didn't occur to me that blk_dread() would bypass t=
he
> > > > cache.
> > >
> > > Yes, how is that happening? That's what doesn't make sense.
>=20
> OK, I see. It is actually one level deeper than I thought.
>=20
> PARTITIONS is not enabled, for example on phycore_am62x_r5_usbdfu
> which means that blk_get_dev() returns NULL
>=20
> So long as all the code is in one module, blk_get_dev() returning NULL
> causes the calls to vbe_simple_read_state() and simple_read_nvdata()
> to be dropped, so their code is dropped too, so there is no
> blk_read()/blk_dread() call. It is optimised away. It just happens to
> be the only call in U-Boot

Ah, that is all also true, thanks.

> > > > > Further, this functional
> > > > > change seems to introduce some other code being pulled in very
> > > > > unexpectedly, and that needs to be explained. For example,
> > > > > phycore_am62x_r5_usbdfu is another case and that has
> > > > > CONFIG_BLOCK_CACHE=3Dy but CONFIG_SPL_BLOCK_CACHE=3Dn, and yet th=
e size
> > > > > growth is in full U-Boot.
> > > >
> > > > This board currently uses blk_dread(), but not blk_read(), so the
> > > > addition of a blk_read() call in non-SPL causes the BLK cache to be
> > > > pulled in.
> > >
> > > But, how? I mean, this sounds like some underlying bug that needs to =
be
> > > fixed. The platform sets CONFIG_BLK=3Dy and CONFIG_BLOCK_CACHE=3Dy and
> > > drivers/block/blk-uclass.c has:
> > > ulong blk_dread(struct blk_desc *desc, lbaint_t start, lbaint_t blkcn=
t,
> > >                 void *buffer)
> > > {
> > >         return blk_read(desc->bdev, start, blkcnt, buffer);
> > > }
> > >
> > > Or perhaps the answer / problem here is that I need to track down wha=
t's
> > > going wrong here instead of asking you to track this down.
> >
> > So, digging in to this, what's going on is that the platforms I've noted
> > here (and a few others) don't actually enable any block devices. That's
> > why, today, with VBE on still, they discard all of the code still. Your
> > rework means that while there's still no block devices, we're now
> > including the code. What to do? Both of:
> > - These platforms *should* disable the assorted block device related
> >   library options they have enabled if / when possible (it might not be
> >   a neat and easy un-tangle).
>=20
> As above, the issue seems to be PARTITIONS

Yes, I think we both agree there's a number of useless functionality
enabled on these handful of platforms. PARTITIONS explains how it gets
optimized away and all of the useless block-related things like MMC
core should also be dropped.

> > - VBE needs to handle the case where there's not a block device enabled
> >   and not fail the build. Part of this requires the Kconfig rework I
> >   linked to earlier (so that we can have BLK off) to be complete, but
> >   having the VBE code check for BLK being enabled either in Makefile or
> >   C code should be the same regardless.
>=20
> I thought you NAK'd my patch to drop the 'depends on BLK' for bootstd?

I know I NAK'd
https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-2-s=
jg@chromium.org/
as that should be instead done with
https://patchwork.ozlabs.org/project/uboot/list/?series=3D440336 instead.

With that series then yes, you should be able to have BOOTSTD not depend
on BLK. But in a practical sense I worry that your changes in this
series will break with BLK=3Dn. My point above is to please make sure it
still works in that case.

> From what I can tell EFI_LOADER doesn't do any block access unless
> PARTITIONS is enabled. I don't want that for VBE because the VBE data
> is not actually in a partition (although perhaps it could be in
> future).

In a practical sense EFI_LOADER depends on BLK and I've fixed the
dependency with my series and talked with Ilias and Heinrich about it.
Making EFI_LOADER buildable without BLK is a mechanical effort, but
making it usefully functional still might require a bit more work and
they'll cross that bridge when they come to it.

> Anyway, from what I can tell, the code-size increase is explainable
> and perhaps we should just accept it.

Other than the double buffer one, yes, I suppose it's not unreasonable
to ask me to fixup the oddball platforms with extraneous PARTITIONS and
other block type things enabled. Still need to get back to the buffer
one as 200 bytes isn't normal for re-organizing things such that the
compiler can't decide to inline something.

--=20
Tom

--a/0N2A5lx+myxqXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeHEj0ACgkQFHw5/5Y0
tyxZxgv5AbH0r2G0YeE8uwLCLK/V+ri7plk3GUP7htS1paIUs/0CT/thBV8VJKTC
I3Nmp0J62tjikBUKn/uqZlp91eqn0UTIPKzz/fPgVth9VAW1rtgedI6gbByuIsam
Lxs5iYQDwDgJzha8f1SZEjZcsYrlFGQ72veCo9iefb852JUnCGUgkmF1SXjaSnUD
vUcWGg5OiDANdb2iDqJJTwXHOm8CLziN/5EtQ8cfzBFuLF/gacBysEu5fEOFEEym
yMdNaYnvvWnb8A2Rn2RseXCMJXA3I1YGVDN6uZDQi7bdHihQdw436VpbGuFDjsIz
Tkc/56SqNlq1DgKaawfBeT6Adf5laNEiAe0xyGYPqQBzxNP46FH+7hThelbxJzmY
boiu2K13BgyKX5uAAuVhGj4hTmxFEdNaMF1P8Lhaaz7t32yFwzDiXIrFwDnUnoIK
R3OLxoteoII/PwRyqt6v057ELazjKf7/eg/+en2TyMamnUbI54gbN0av2pkGQ+hB
Pg6Ijzf2
=hKFf
-----END PGP SIGNATURE-----

--a/0N2A5lx+myxqXI--
