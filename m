Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E27C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 20:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D848091A;
	Thu, 15 May 2025 22:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jxriVXPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 293728129F; Thu, 15 May 2025 22:44:23 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC81806D8
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 22:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72bb9725de1so537922a34.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747341858; x=1747946658; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Oldm8Tju1+NV1+hS8R+CDCIIwitj51ON0Hxb9yZAK78=;
 b=jxriVXPxZAOAKiiPHnQSw3rZBu/aY7mQd5P7dw4uj/NxskY1Brb07SK8wFcH/1Qpwi
 FYd46lQon5Ofc14MQNhlP8WPNEKCJ59AxIxvzCLaOcddcIffVF30UDTYhPqgyTo7qA2B
 1Bhe6ZzYY/rwRcgxdTzJcztdFskPtbF2G5G8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747341858; x=1747946658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oldm8Tju1+NV1+hS8R+CDCIIwitj51ON0Hxb9yZAK78=;
 b=dobzk3N4PHI+rPwmLfES/spfoDbdEtvI4fXrNKLHtg2p85WejSlddGuZWZn/YpEGYt
 lYF8nTpYQvSWl4Y/dnQ6khkdeyBqVf0FgUFekwuOEnkcM3lZ2b5YE3FoGQSMtePt97Me
 TzmsDvg9XDvmvHn4DYXWyK9l1wHW5fQft57nS8VOE1wXHYTd3seFjRUKjgiME+u4UqOS
 K9aoeStqXxaKolh/+YwbHIDh9PYNkPbdMbdLMtSk8QcLaCV5YWhokQIh+kMnuyf4WhPY
 YCgFVfjosqsRHGEwf9sF4smvntCuflYfj+xCKPvdXODScAUVzAXJ+fB9FCuG7PofMm0E
 cgPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKQysBzdT3bmrSm2l/qmp/FlPq6h6pBurZFi3ViSHJgjL3jKvwfAJtFX9bA++nsQOMkRxONtA=@lists.denx.de
X-Gm-Message-State: AOJu0YwJIHJzgyNSBNz4L8VrAcGAaA8rMTo0NmwKDdFkm2hNN39c9+CQ
 OskBI1ect8Uu7WNEmnqofjsWd05xNh2tQHdJ2plGhd4vHgO40y5XJRcz9f1QzY7185s=
X-Gm-Gg: ASbGnctRHEWwqbxRspjZFDz2PLdkXqGv9JQmN+e6itctDi5aqfCgjPttLAY7kbZm7Bb
 3cZ42rEgR+OJgcd7QVi2s0fk1fqI4t8dcgjIO2ziUvzKgIO2cXrqRPgvPw7+A2w/+o3rEtIQu4a
 epse7U+0mXZ3E+2Id31w8thZI8439pNSRkaPHNDvXRsKD95XlWvJSBtH7q0/1WOlFvXweCGuOkO
 En/MeIqKvs6TMT7lLcC8VHnRF3Vswnx0nJFRKRMbaHm454knuZaZsZ8m5dE5Tz0Kkqj8YPfyjNO
 KHVOjoIr8Vlz9jLyWDjc7to1bdj5nXHhpKBTwCAF10pPh6FjflBHDrCFKbU8leCIkMF7Kx2OncV
 Tq6Cx0Km8wxuA
X-Google-Smtp-Source: AGHT+IFax+tpbktphyPK7AWrmAaYSZhhi3ODBlVWZsBt3rF5p+9jru4LgNrB7kWVT5ohe9jbjSrimQ==
X-Received: by 2002:a05:6830:6805:b0:731:e808:be5f with SMTP id
 46e09a7af769-734f998f112mr112181a34.28.1747341857994; 
 Thu, 15 May 2025 13:44:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a4b1d1sm101254a34.10.2025.05.15.13.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 13:44:17 -0700 (PDT)
Date: Thu, 15 May 2025 14:44:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Richard Weinberger <richard@nod.at>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/6] test: Update fs_helper to support passing in the image
Message-ID: <20250515204415.GB100073@bill-the-cat>
References: <20250511141828.2367318-2-sjg@chromium.org>
 <20250511141828.2367318-1-sjg@chromium.org>
 <CAFLszTjf_4E+spiD3FBFvXQbXtrnBxgoF1hCjNsauySom2SgFA@mail.gmail.com>
 <20250515135546.GF603748@bill-the-cat>
 <CAFLszTiOe56kP1i_AGLSZBRvyNOYWHMZXC45Qi0YsrP1rkjYAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CFBO6ZitaIghuH0E"
Content-Disposition: inline
In-Reply-To: <CAFLszTiOe56kP1i_AGLSZBRvyNOYWHMZXC45Qi0YsrP1rkjYAA@mail.gmail.com>
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


--CFBO6ZitaIghuH0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 09:33:18PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 15 May 2025 at 15:55, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 15, 2025 at 06:51:17AM -0700, Simon Glass wrote:
> > > This function is useful for other scripts, so add a parameter to spec=
ify
> > > the image name, if desired.
> > >
> > > Also add a flag to quieten the output of some of the tools, since in
> > > many cases we only want to see warnings / errors.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  test/py/tests/fs_helper.py | 18 +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > >
> > > Applied to sjg/master, thanks!
> >
> > You have been repeatedly asked to not send messages about your personal
> > tree to the list. Please stop sending these messages (and I hope you
> > didn't change the patchwork status too, again).
>=20
> We are still not really on the same page here.

Yes, you keep not following seemingly clear directions. You posted
something not against master, and that also continued adding things
which do not belong in the tree, to the tree.

> This series is showing as rejected in patchwork, so I've applied it to
> my tree and sent an appropriate message

There is no appropriate message to send to the public mailing list for
your downstream tree, stop doing that. And patchwork reflects mainline,
not your personal tree.

> While we are in this state of
> your rejecting my patches, I am not sure what else I can do. I have
> already renamed the tree, as you requested, so there should be no
> confusion that this is my tree. If there is still confusion, then
> perhaps the rename (which took quite a bit of effort) was not
> effective in resolving your concerns?

Your downstream tree is not a special tree. Others have explained how
they maintain downstream trees and work on upstreaming changes.

> If you do take a pull request (e.g. for one of the 100+ patches
> assigned to me in patchwork right now), the patches will then be in
> your tree, so presumably need to be marked 'accepted' in patchwork.
> When would be the best time for me to change this status?

The status of patches for mainline in patchwork is pretty easy. I even
run some helper scripts every tag to update (most) patches that might
have been missed.

> BTW, I'm really not sure why you have rejected this particular patch.
> Even if you don't want scripts maintained in your tree, this is really
> just a small tweak. It will help reduce the delta between our trees.

It was rejected either because it wasn't against mainline, or because it
contained changes that had already been rejected.

--=20
Tom

--CFBO6ZitaIghuH0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgmUhsACgkQFHw5/5Y0
tyyNIwv/Z7JVxAe72qLXHwgSeMrw3vguSWYdbnTK2C6IZBsrlRcH3tiseT9/udZE
op9sd4AoBEk8VwZADGTpHZ2CGQUQctR3y8fguzXRu/lHId5dEUbPjoYdT6ygbFHA
uXZk29vG+1EGvQ0v9tc6+9wbyN4J6ptvcpIjYl69q3CiBio67KQF/I6ryJLCx19t
r15DZnatszBlWYsfNSzEnX/eywwA3khIpnF1zd999JR+M02UmpRpCI8f43H4p1lD
JO4h2qDZqVwQq8/p6ZExhqXw/AGKHJ6MOa2pSDxzHtx6MrSyZlbyS/JaXN4HomO/
IZqS5TvR7K0GjRVK7eaicnipL2+UHVzJupUADvuq/l3EUAOMwzcG0Bgq0tWdFBVQ
+uhzLRgjSnP7iDHfxz6oyg2CeT8GEGILePii58RKs66r013zemku2IxafVFgTjXC
X90/lm0FzSgXpe0DZQCipDXnCFQ9CmPjO8W23GEYLKSkFERcTMvTSACf4RiKNGe7
mFqLsn/j
=Lzgk
-----END PGP SIGNATURE-----

--CFBO6ZitaIghuH0E--
