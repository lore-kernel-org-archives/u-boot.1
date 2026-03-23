Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73914F46139
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE258418A;
	Mon, 23 Mar 2026 16:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s/DKNWbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2484A8419E; Mon, 23 Mar 2026 16:29:17 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7B2A84144
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4138136f02eso176466fac.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774279753; x=1774884553; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fMucKIpZyVfJ4X8Vd3Dpf3sMiebMCIFyXZUVjJ8l2B8=;
 b=s/DKNWbvzufGrQ8Im2FV5isjdHtexLcdAcEN//mv4LssZEzWOpi1po5uUWH5oEOUwr
 Xy/I2IntPuElSR4mq8fmovSk5HajXAEeSaNDWvLZfRxeR2jpd+e35DwAUZqKdQ5Ux2hb
 k3VB4s69YicBQLB0dB75ImI7OhKtrNW8ttcS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774279753; x=1774884553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMucKIpZyVfJ4X8Vd3Dpf3sMiebMCIFyXZUVjJ8l2B8=;
 b=InaRyTTRfopS3c/RLmANXOEpYSkYi3r6+tw2UXAUOikUe9evhWJldG3B76qd0IRN74
 OsG8NaTK7+hX5nL7mv89Llm7G+5TukYaTTGTf+pFlMX2wOQxQqooPb7CGqaOwDLshUTV
 DOp/QqECAKbhnto2Au3aUjgbFt4BYs8b8pQF/a4GyUfl0uCOAZCYjk11jGtWLCjR4Ic9
 ervYaU00uwoTjWfrSL9K6qBDVF3ch7VZr78d4d9vfKUkB8djG7XoLbKVfeB4+3fpTt4t
 +W+6nnJyxeonDHN4lnNUZAb129bucCfgrwUxexPBaERQFiB6xQrgvPAn2AeTPJc2Y3xb
 HsKg==
X-Gm-Message-State: AOJu0YyphCivZAAtPwBSUMJu1ruxyHgZWvTveDNCywtU6n/tm6t4436u
 xPZl/HyanFIu5onXCcwLra5rIE2MluO5Lo89PJxuzKOiQx3oYGgQVfLMsO5GvTEDsblXYDS6/RM
 MoZGhmZY=
X-Gm-Gg: ATEYQzwGkeRA1HCzE8d7oV+/gq/ZxIBsOUjOiySF5DSaZuoQI9mNXds6Bi3fMEcEdnZ
 Lm0oAQjFS+TXiOVTNdkRadcPXmc8lkugxN9lPufR3a+RfPvsD74Xn3gRvR3cWELzK5vx8pS1UDK
 kwcQuD6hp+etpeogrc1TAmFMvHU3Pt7nkUqq+oX2qeylAtTv2GmVq6wn8sXZ/gvbVHo1b9n7cca
 Udn4iHTE212Ugfecc8IKBzqJ9xwC2c5UOB9z1C8J/oGhk/+KjyViTcObL6Fa50Xz5610VTRRwom
 G8aJ9ZzbzJBhFNeXDs9/tnO4l/nGSlFh8vPAig7cItwqw4JIfn+B9uvoKwoohudwQTHM7CrJwEC
 C44imTo3PxRGhLyvBb8mczmtaZbY7C4E6HtrzmGPI+wuy9E/Kc0RjIufuKE/fwLEUL0rxOEOrGh
 MiBnJBfbMK0wu1bU28irtsHZfmNFZSS4X/6FqcCtG/exXVPefJqvVtis5aD6JoGKAqUL7Alzqk+
 IOT90UuLs4jOfI746ZstNc+CkMNh9abyR8tP8ey7fZkLHrZb3lFX/IWqjs=
X-Received: by 2002:a05:6870:219c:b0:417:565d:e3e with SMTP id
 586e51a60fabf-41c10ee8758mr7408506fac.1.1774279753476; 
 Mon, 23 Mar 2026 08:29:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14ddbcb3sm10520475fac.14.2026.03.23.08.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:29:12 -0700 (PDT)
Date: Mon, 23 Mar 2026 09:29:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH 1/2] linker_lists: Fix end-marker alignment to prevent
 padding
Message-ID: <20260323152910.GI502704@bill-the-cat>
References: <20260321134626.516665-1-sjg@chromium.org>
 <20260321134626.516665-2-sjg@chromium.org>
 <87jyv2oon5.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ld536lrdPGzgUUBD"
Content-Disposition: inline
In-Reply-To: <87jyv2oon5.fsf@prevas.dk>
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


--Ld536lrdPGzgUUBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:56:14AM +0100, Rasmus Villemoes wrote:
> On Sat, Mar 21 2026, Simon Glass <sjg@chromium.org> wrote:
>=20
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > Change the alignment of end markers in ll_entry_end() and ll_end_decl()
> > from __aligned(4) and __aligned(CONFIG_LINKER_LIST_ALIGN) respectively
> > to __aligned(1).
> >
> > The linker places zero-size end markers at aligned boundaries based on
> > what follows them. When the next list's start marker has a high alignme=
nt
> > requirement (e.g., 32 bytes), padding gets inserted before the end
> > marker. This causes the byte span (end - start) to not be an exact
> > multiple of the struct size.
> >
> > The compiler optimises pointer subtraction (end - start) using
> > magic-number multiplication for division. This optimisation only produc=
es
> > correct results when the byte span is an exact multiple of the struct
> > size. With padding, the result is garbage (e.g., -858993444 instead of
> > 15).
> >
> > By using __aligned(1), the end marker is placed immediately after the
> > last entry with no padding, ensuring (end - start) equals exactly (n *
> > sizeof) where n is the number of entries.
>=20
> So I'm wondering why that is guaranteed. I mean, the linker is placing
> these sections one after another in order
>=20
>=20
>   2_foo_2_last_foo   size sizeof(struct foo), alignment max(4, alignof(st=
ruct foo))
>   2_foo_3            size 0, alignment 4 (1 with your patch)
>   2_bar_1            size 0, alignment CONFIG_LINKER_LIST_ALIGN
>   2_bar_2_first_bar  size sizeof(struct bar), alignment max(4, alignof(st=
ruct bar))
>=20
> So clearly the end of last_foo does have 4-byte alignment, yet it is
> observed that the linker sometimes makes 2_foo_3's address coincide with
> 2_bar_1's address?
>=20
> What I don't understand is that it seems that the linker could place the
> zero-size object 2_foo_3 at any 4-byte aligned address between the end
> of 2_foo_2_last_foo and 2_bar_1. And the same seems to be true when one
> changes it to have even smaller alignment requirement.
>=20
> So why does an align(1) stop the linker from placing that 0-size section
> at the same address as 2_bar_1, or even force it (as we need) to put it
> at the first possible address, i.e. immediately after last_foo? Unless
> alignment 1 is somehow special-cased to mean "place as early as
> possible", I can't see how this should provide any better guarantees
> than what we already have.
>=20
> So I don't oppose the patch at all, but I'd really like to understand
> how it actually works.

And as was recently demonstrated in getting device trees to be 8 byte
aligned in linker scripts, you need to be making changes in the linker
script to ensure output alignment matches what you expect and also it's
not always obvious what actually will happen in all cases (when you
haven't been dealing with the nuances of linker scripts for days on
end).

--=20
Tom

--Ld536lrdPGzgUUBD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacFcQwAKCRAr4qD1Cr/k
CuTkAP0dNc+myOCMwBVXI8mgaKsXCd+aEhzxU8bjC2JxjGXHfQEAwAz0D8Gnpupd
nc3gk6yFtWyhphi6IUObNRfiOZcJfA0=
=nNbz
-----END PGP SIGNATURE-----

--Ld536lrdPGzgUUBD--
