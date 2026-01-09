Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7B5D26D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A0D8436C;
	Fri,  9 Jan 2026 19:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZyyZEgGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2755984383; Fri,  9 Jan 2026 19:06:19 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA7384206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so3708344a34.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767981970; x=1768586770; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MKCu5unrSB1dOWGsyyCrTfwyDfUU8kx5gFhP0ffAKew=;
 b=ZyyZEgGrCNk3RTY17AjjaqXbG55AULPS6Lcliv8ecjX1T1rtOExSDc32ojYuvY/c76
 Iiz9XL+X8GiQThtsvN/jEu9piZ4C1UA2UGS1+Y8Y83gV3TqOb7sOEthBWt0XW9f+wQrd
 qUz570+Z9v7MHb4K4Y+Tlq8KqPOMmXYZCl6HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767981970; x=1768586770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKCu5unrSB1dOWGsyyCrTfwyDfUU8kx5gFhP0ffAKew=;
 b=sBXkM5W0JB4YIDBTMJPVDQsA0ZM1J9KxUA2bqKhF7uiWwJVfZA3ZC7KjmrxwhRtWpd
 B6EuFZHAhkF4NAyuuZVRx1QddjBrAd8e8jkUrcYbT6fnwquCOqbsN/hCGBcen5Fbk6Dm
 RHW+RI9Jd7YD74sQj+j5BEH+cEgTDwehfWqG7tKrGvvFB/kQHb5sUyO5aSY6lMHNr0Ja
 as6niTOaePGdoSoRMXrfrxT4CkPETtlPtG4OHU2AWFlzNQeYmHs5wFssm9rPqR6f/zy3
 jZlIiLTzmDcGtPjAEckiSVBYdvcLyvmIyqEme6RoXfR/WcrTbX8c4yCJ8MC/j/ZqMseH
 RjMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu6yyhkTkwdMah6LyqkX4gby8mGWgkmtOln3gcSlx5xfUA+uPs/QL5C00poYH/yzZwN3r8kDU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8qHV43CpEqJnbimsVl+lNvt4XEHqoNeJIBhQ30zSfai4ivwQy
 MJXDLNspXD7IyhPVFqVXZlNoscy+ZQTr8XYC7TQr5Q2TVXh6U18rEjYNWXP7LRohu2U=
X-Gm-Gg: AY/fxX4EK7UZr5xC8x9Cdi5hoZ08saPngIgBuhrUOHMmpM3nmDz+hTQdMLOVqe12hHz
 Qr1YbJgMZRp0Y2l1cWpHhyzAZaC7oTN6YKPn/7sQh6nyqW42949tDr/K2Z3OO8bquqvaSdZ12LG
 bpaOEQExk8oVaj/Mk72nbY6WI2DVHleP541i7FlODZkhxgeO+isxkNhkYSLaTVCwbrJZyDU5HHy
 ZGu3TV4kyErQ6BkBwmeHV0dEsjH40lX3TAEoidQ8QhqbKiwv+24wnlVx0Lde+DIQt7vEmMAJa1d
 sSISMHY4N6bimfQScbYJX9dTLQmmbExX+d81hJLpj8XXHbCt0wl8p67bt+LFimPkm1VfVGeuKHB
 +9pjNaW0PG9JWINPuzSydDHs+kfBVV0h6fEle1IHZCKCRrB1fFWJ5IoyKYVdtr+75MyUxYpqfd6
 g7hXcnCqpAnUUd4IecMtpbKNJxi2UcevSMTGR3CLQvilAgy3PiF4+hivydFOv/j+AS23meYRZ5a
 saGFt6MsvP9tby8AT8BViQacFqvgBsK/rErWns=
X-Google-Smtp-Source: AGHT+IHrtRk0QtT7ZTA/hFKIOE4204rOebRYcbgbmGrixqAHoqC3GtqBLhTXx8zTUjS4cmCBWSTHvA==
X-Received: by 2002:a05:6808:4f29:b0:455:e5bd:414 with SMTP id
 5614622812f47-45a6bf812d8mr6077840b6e.66.1767981969898; 
 Fri, 09 Jan 2026 10:06:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5dfb6256sm5222604b6e.0.2026.01.09.10.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 10:06:09 -0800 (PST)
Date: Fri, 9 Jan 2026 12:06:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: j@jannau.net, u-boot@lists.denx.de, kettenis@openbsd.org,
 asahi@lists.linux.dev
Subject: Re: [PATCH] configs: apple: Enable SMBIOS / sysinfo
Message-ID: <20260109180607.GG3416603@bill-the-cat>
References: <20260109-apple-defconfig-smbios-v1-1-16477009c034@jannau.net>
 <20260109173351.GF3416603@bill-the-cat>
 <878qe6ad7s.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NjUixkueznanYzUN"
Content-Disposition: inline
In-Reply-To: <878qe6ad7s.fsf@bloch.sibelius.xs4all.nl>
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


--NjUixkueznanYzUN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 06:49:11PM +0100, Mark Kettenis wrote:
> > Date: Fri, 9 Jan 2026 11:33:51 -0600
> > From: Tom Rini <trini@konsulko.com>
> >=20
> > On Fri, Jan 09, 2026 at 06:20:30PM +0100, Janne Grunau wrote:
> >=20
> > > Enable verbose SMBIOS table generation so that user space applications
> > > can use the SMBIOS table to provide details about the system. The
> > > desired information is chassis-type to determine whether the system is
> > > laptop.
> > > Adding the chassis-type property is proposed for the upstream device
> > > trees in the Linux kernel in [1].
> > >=20
> > > Link: https://lore.kernel.org/asahi/20260109-apple-dt-usb-c-atc-dwc3-=
v1-0-ce0e92c1a016@jannau.net/ [1]
> > > Signed-off-by: Janne Grunau <j@jannau.net>
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
> > > ---
> > > I do not plan to update u-boot's in-tree device trees. The Linux devi=
ce
> > > trees have almost reached feature parity. The main missing features a=
re
> > > the USB Type-C ports (on track for next merge window) and the laptop
> > > keyboards. I think it makes more sense to close the feature gap and
> > > switch to upstream device trees instead of adding to the in-tree devi=
ce
> > > trees.
> >=20
> > This sounds like a good plan to me, thanks!
>=20
> Yes, it is probably time to remove the in-tree device trees for these
> devices.  They were never actually used in the build anyway.  Just
> added because a maintainer insisted on having them in the tree.  But
> now that we have the upstream device trees in the tree, the in-tree
> ones can go.

Note that a small challenge for today (I ran in to this as part of
fixing OF_OMIT_DTB not requiring building a dtb) is the instructions do
say to concatenate m1n1, u-boot.bin and a dtb in some cases. But taking
the upstream dtb for that instead is fine I assume.

--=20
Tom

--NjUixkueznanYzUN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWFDiwAKCRAr4qD1Cr/k
CrP7AQCuCIaHtuwJ6YDdfuspvrBLDim6UpQLGoQE2ChTKzFK8QEA7ewShYsnGHgm
0bp30lzfnTfaR/bZlOwfH5RkKgvyEgU=
=EnO5
-----END PGP SIGNATURE-----

--NjUixkueznanYzUN--
