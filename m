Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC82C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 16:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727988022E;
	Tue, 14 Jan 2025 17:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ik3Flcmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B308060C; Tue, 14 Jan 2025 17:58:10 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C8F8007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so480167885a.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736873886; x=1737478686; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vij2ZQxhT97IoSiRhLaEV6bxSn8cnKJiXYxTFoef9HY=;
 b=Ik3FlcmmMadauh/PqmjrZXPamSfCCFRnbcNVrtjeSnfWUkHltiMoGM6Spa4gpDyHHU
 W7OqMZ6WK4RcC8BM8H6O9Dr4csijSucfTYgz7KqIApXEGRXcTtTHzanRCjim+am/swsm
 8fS/j/aURhOAtqDC/06zKtrSaUizNpdHN9vMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873886; x=1737478686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vij2ZQxhT97IoSiRhLaEV6bxSn8cnKJiXYxTFoef9HY=;
 b=pCGae4dpEZzlCYqLmUkw5O2F9vsZPjnlCaOcS5zxcyO7d0i6U5vMK5dqbFbstMG1pB
 srqfnTxFlERiUFXK8x9WlGTIHL9w7WD4Pa7+7F8Ll3AEGdJQBNJlGDnXfAhmjNL+n9uJ
 ZTBmTMvpsuSYPnjV7YwgXcPpppCukZcHugfiZSjvVJmhEmZmHNKrvmB9zgw1a/JgpZC5
 hzd/piACLajjmY5pc6WFC9+tnCkxs2ij0PuxYzHFCbCXtz6EXC85hGgDxwxpZQf571L8
 aV7vZRF0MGozMZ1h+jysqh+sx7A7OrwkDznBuvpwCpxSYxkPWd8vYgS6lO7omeY/tKr+
 UKoA==
X-Gm-Message-State: AOJu0YzjvF8TBcEa6jEV5CpyPzEIKmrgo+dkFX1Y+7AmRsRNJy3t9Uof
 xZQ0ZrbKcO+kMxgkProLPS4P7yHn1vdFOhw5CQTL3oCq6kVRqmL6nzSVOqIYDCA=
X-Gm-Gg: ASbGncvTgn3ruutmjVDLiEV0OGnjER9hbNcmbJm6B1BkSrd4ybW+DkFEqh8cx4E9lwO
 UkHNGBJ++tT9YJ64JauoiZLNXY+WazthD6wsFCOC1BOvMdmfL243zf+HYvcTYWi2fGwiir4Dwxs
 wCXbwIRRYbYAdypxw+8OJT5W73uVi38ml4R8JebroB4wf79Z0I3VluoNm7fqp08wmJqoFduBc9b
 9ZbUfmL8bRTI1ZDGO4yejfeOH0Nqerx8YUdhMnFpVwoOsC+kEIQcg==
X-Google-Smtp-Source: AGHT+IFyaji9QzZnjMNFxoZpKl4E6tr4qgDO4tp5Co8i1K/23m0K5kKxtGcNS9UQ9UuApkArQH754Q==
X-Received: by 2002:a05:620a:9359:b0:7be:2f20:60b3 with SMTP id
 af79cd13be357-7be2f2061cdmr1373785785a.23.1736873886200; 
 Tue, 14 Jan 2025 08:58:06 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce324890csm618381485a.39.2025.01.14.08.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 08:58:05 -0800 (PST)
Date: Tue, 14 Jan 2025 10:58:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 01/15] vbe: Split out some VBE code into a common file
Message-ID: <20250114165801.GJ3476@bill-the-cat>
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-2-sjg@chromium.org>
 <20250114012226.GG3476@bill-the-cat>
 <CAFLszTj9zAE_KniCZ2xHGHt1fK7jhTBHzfkdSif6XNuzKtWOTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Os7bBMxWcnTZkkul"
Content-Disposition: inline
In-Reply-To: <CAFLszTj9zAE_KniCZ2xHGHt1fK7jhTBHzfkdSif6XNuzKtWOTA@mail.gmail.com>
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


--Os7bBMxWcnTZkkul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 05:58:04AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 13 Jan 2025 at 18:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 09, 2025 at 05:29:56AM -0700, Simon Glass wrote:
> >
> > > Loading a FIT is useful for other VBE methods, such as ABrec, so start
> > > a new common file. Add functions for reading the version and nvdata.
> > > Also add a function to get the block device.
> >
> > This is not a good commit message when you're also introducing
> > functional changes (blk_dread -> blk_read).
>=20
> Yes, I did not actually notice this size change at all, as mentioned,
> as I only built for a few boards (firefly rk3399/rk3288 and a few
> sandbox ones). The blk_dread() function is the old API for reading

You have much faster build machines available than I do, it would be
good to run a world build before/after (it might take an hour on
alexandra) before posting these big series.

> from a block. It didn't occur to me that blk_dread() would bypass the
> cache.

Yes, how is that happening? That's what doesn't make sense.

>=20
> > Further, this functional
> > change seems to introduce some other code being pulled in very
> > unexpectedly, and that needs to be explained. For example,
> > phycore_am62x_r5_usbdfu is another case and that has
> > CONFIG_BLOCK_CACHE=3Dy but CONFIG_SPL_BLOCK_CACHE=3Dn, and yet the size
> > growth is in full U-Boot.
>=20
> This board currently uses blk_dread(), but not blk_read(), so the
> addition of a blk_read() call in non-SPL causes the BLK cache to be
> pulled in.

But, how? I mean, this sounds like some underlying bug that needs to be
fixed. The platform sets CONFIG_BLK=3Dy and CONFIG_BLOCK_CACHE=3Dy and
drivers/block/blk-uclass.c has:
ulong blk_dread(struct blk_desc *desc, lbaint_t start, lbaint_t blkcnt,
                void *buffer)
{
        return blk_read(desc->bdev, start, blkcnt, buffer);
}

Or perhaps the answer / problem here is that I need to track down what's
going wrong here instead of asking you to track this down.

> > Just moving code should not result in
> > unexpected size change.
>=20
> That's correct, so long as 'expected' size changes includes the normal
> function-call overhead and loss of intra-module optimisation.

Yes, but that's not what this series shows. There's (a) the above bug
and (b) you might be allocating buffers twice now instead of once?

> So, what to do here? I certainly don't want to use the old blk API.

Yes. I'm not 100% sure, especially after
https://patchwork.ozlabs.org/project/uboot/list/?series=3D437816&state=3D*
which I need to v2 what the non-SPL case is. And for new features, sure,
saying SPL_BLK is required too is fine. Heck, it *may* even be the case
that only TPL_BLK=3Dn is required to be valid, all of that would require
other investigation and removals.

> But I can perhaps do a patch which changes VBE to use the new one,
> first, so the size growth is within that commit. I looked up
> BLOCK_CACHE and it is used by 90% of boards.

Yes, BLOCK_CACHE should be used by everyone at this point, it was one of
those cases of "this grows the code but it's a universal speedup".

--=20
Tom

--Os7bBMxWcnTZkkul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeGl5UACgkQFHw5/5Y0
tyyexgv8DCRBTVQPS4vVnWFDEgWJAKXKH5SUSV4TmwQPySbVDpsQ28CBVrAVZuwh
h8kIJye9OCOu1DiY4td4nqSGKTcMPrDzqS0mjQOHPq49EAzL/+tCS5xTaS4Ybl6F
YjRUZ9AZ7D4B04XUUrDPBojHxHgTCukeJ+sO9IvTBKmbw5rjiIKQP6VUcpv0P327
KFTUmZR4TpRpMGvrXMs48XZa+pdxWg6qYE2g6oEmTGq31/qtw/6A7ebl1dcajhsw
nBniP0IdgCfEQrry6ZJChbfA1z9P0mZwMDkS0nY9nQbHembqhPwCglcskaz9h1Qs
/6bPEBUlqDTXCqeBdPNfYRm0SUI5qxIZB0UfuGiTKjXEqpBJwgsXMaaKmLuiu/FF
ny9RE+AuxMGlVg47Fl5la6dJXEqQp1JbQsRGaLrUMpYEG+8PNDLmNIpRwwD/sIqC
uyg5ynEyzwoL5Z3MBzT293KmkyF1eN2CAVAzTzOhSlUWSM6nOHWyMr5MnAPhRJBp
fzj4RxEs
=bw9C
-----END PGP SIGNATURE-----

--Os7bBMxWcnTZkkul--
