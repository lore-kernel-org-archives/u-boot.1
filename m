Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C100D1266E
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 20:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A3383F50;
	Tue,  2 Dec 2025 21:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RzXEI+GS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE77E83EE4; Tue,  2 Dec 2025 21:12:50 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BB783F15
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 21:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4511f736011so163272b6e.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764706364; x=1765311164; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2HrjTr1ZAuPate70OWuwBLHbtJhKnmkyO5JG3z0x2l0=;
 b=RzXEI+GSDlrHCuLzCQpNlih5ib0uQYsQq3WaC5EQ1PiUFsTJe5HI072Uwz0uwGx2Nf
 DdXQVuDGOjxlGKmg2/V4g7g9TB+6djyO50mJPMLlX90a4VPSLEjJKaJk2LGoBc/RL0ID
 zAxpGoi3hpeqB9Wf/qt8XyhGSLBO4Xf7VjV8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764706364; x=1765311164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HrjTr1ZAuPate70OWuwBLHbtJhKnmkyO5JG3z0x2l0=;
 b=lHwMTbmvCXcIxs7es3XbT31uyd5Pit3zaYfIp0z1vn23sqKZhfSm8z0veiiOiNs3cc
 v0pbgsf6RiEPafJvlMvGBs7Hu8iX9s2yETJQkYs3sc4roFdn2vVpQNkzNfqzjfH3GPzB
 oy2UoQ6UGP0ejiB/CSccnydEAVellD2eptaAEPYWV1jJmdrsv051lhU7LBo3jDywSDrP
 x5B2sGt8yJgWE7Kyuy8w5qN7H5voc4k63er723IM+oaICcCexyewVZMYIe/92dv/UsNj
 oROc8w6QyQoaJO9gtaMdHydJSmL80WOQ0es/o9fOel+591qskg0J80cIQtWKA5DD0Y2B
 j0lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/TEyZ+rcZ66if5MKfhHLTDhG3wEZs89J0ATIZi7pSrAArIuq/cSHnMjrMge/jXN/mdJ0PgJs=@lists.denx.de
X-Gm-Message-State: AOJu0YxWemUOwkMhPEgCml5DieFZX6NtR1tRiUUM4iIFrNCT6fMUM/iu
 /yBoaMHBXYJ7Sj5XFS+UNyYJOHaa+50XjHRy2lMqr0KjkWq+ZJdswt2C4hVSftVDaf4=
X-Gm-Gg: ASbGncugY9RvLNqjcJr/HOnxHri8gH35yiKbP87384oeVJW+3gbYjKHdy9TuS3RwltE
 QkEjJ+exiXNcO3MBRb+OeEmLQC7rhonYg1r6QSBn+JItav91O8EurKOvxLUQZqCfAmisJxEBps3
 qdBu4+rBRyTWPtUPQRtQD9v2JFcWH3QrR3+xF35CPsUy6f3VPx7OwGU4cM0TErLRGqAtXkud7VG
 wopGn8TJ1EGwDsHA2Xlt8Kgrl8cf2UH91MQV6aEJ0ciogisWTRwUWm8kyZEiWYZt4oVLStTaT6H
 uAJhODB6BxVIy1Lf0nhnOHBNjCzof+IzN27y23tY7Xx5n1M9sLZJtVojm/kfxIkpc/3uyCtG1hy
 9SIig2ZOj8b+qYwbDiskwAhkli4IEcu8ElleR8a3e6US2GiwsdxzME+odEGFavn9I6R1cUnLXC9
 EjhKW43z9S6HSxyjl/47yQ9+Ws6+slpazqWU+YytyEBQbp6uhKjQ==
X-Google-Smtp-Source: AGHT+IFttnegqhacxf8YCR3stK0BGobFvf1l94EaMv0HND1+KPHax0i2v6kwC2DL5+Q7ZfNygqb1Fg==
X-Received: by 2002:a54:4883:0:b0:453:5e88:29b9 with SMTP id
 5614622812f47-4535e884cc0mr1797442b6e.28.1764706363768; 
 Tue, 02 Dec 2025 12:12:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453170cc9desm5995297b6e.15.2025.12.02.12.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 12:12:43 -0800 (PST)
Date: Tue, 2 Dec 2025 14:12:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-board-maintainers@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-custodians@lists.denx.de
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
Message-ID: <20251202201241.GK303283@bill-the-cat>
References: <20251202182403.GF303283@bill-the-cat>
 <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
 <20251202185222.GG303283@bill-the-cat>
 <877bv4braq.fsf@bloch.sibelius.xs4all.nl>
 <DAE792B8-A6F7-4725-8F1F-6D874B508B74@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kCZK/BciFuBJG4Ut"
Content-Disposition: inline
In-Reply-To: <DAE792B8-A6F7-4725-8F1F-6D874B508B74@gmx.de>
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


--kCZK/BciFuBJG4Ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 09:01:26PM +0100, Heinrich Schuchardt wrote:
> Am 2. Dezember 2025 20:46:21 MEZ schrieb Mark Kettenis <mark.kettenis@xs4=
all.nl>:
> >> Date: Tue, 2 Dec 2025 12:52:22 -0600
> >> From: Tom Rini <trini@konsulko.com>
> >>=20
> >> On Tue, Dec 02, 2025 at 07:49:07PM +0100, Mark Kettenis wrote:
> >> > > Date: Tue, 2 Dec 2025 12:24:03 -0600
> >> > > From: Tom Rini <trini@konsulko.com>
> >> >=20
> >> > Hi Tom,
> >> >=20
> >> > > Hey all,
> >> > >=20
> >> > > I am wondering if at this point in time, anyone still builds our h=
ost
> >> > > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> >> > > Windows, natively.
> >> > >=20
> >> > > I ask for two reasons. The first of which is that a reason we stil=
l have
> >> > > to support Azure (despite its slowness) for CI is it's where we ha=
ve
> >> > > macOS and Windows hosts. But at this point in time there's so many=
 ways
> >> > > to have Linux userspace running on Windows or macOS that I don't k=
now
> >> > > that there's any value to these builds.
> >> > >=20
> >> > > The second reason is more macOS specific and is that with:
> >> > >=20
> >> > > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> >> > > Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> > > Date:   Thu Nov 13 12:54:51 2025 +0100
> >> > >=20
> >> > >     boot: Assure FDT is always at 8-byte aligned address
> >> > >    =20
> >> > >     The fitImage may contain FDT at 4-byte aligned address, becaus=
e alignment
> >> > >     of DT tags is 4 bytes. However, libfdt and also Linux expects =
DT to be at
> >> > >     8-byte aligned address. Make sure that the DTs embedded in fit=
Images are
> >> > >     always used from 8-byte aligned addresses. In case the DT is d=
ecompressed,
> >> > >     make sure the target buffer is 8-byte aligned. In case the DT =
is only
> >> > >     loaded, make sure the target buffer is 8-byte aligned too.
> >> > >    =20
> >> > >     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> > >=20
> >> > > Which does things we must do, we now don't build on macOS. Why? As=
 best
> >> > > I can tell (and for a general purpose OS, is a good call), memalig=
n(..)
> >> > > doesn't exist and you need to use posix_memalign, a not drop-in
> >> > > replacement. We could spend some time reworking the code here for =
that,
> >> > > but for now I've instead gone with this workaround so that CI can
> >> > > continue:
> >> > > https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@kons=
ulko.com/
> >> >=20
> >> > Are you sure about this?
> >> >=20
> >> > The code in boot/image-fdt.c is part of U-Boot itself, not the host
> >> > tools.  As such it should be irrelevant whether the host OS provides
> >> > memalign() or not; U-Boot provides its own implementation.
> >>=20
> >> We use parts of this code as-is (and some other less obvious files) wh=
en
> >> building host tools.
> >>=20
> >> > OpenBSD doesn't have memalign() either.  But I can still build the
> >> > targets I care about on OpenBSD.
>=20
> We require C11 for building U-Boot. C11 defines function aligned_alloc().=
 If we add that function in our U-Boot library we can rid of the #ifdef in =
Tom's patch.

If we don't run in to link issues on the host side (a thing I hit a few
times when trying alternatives here) then we can, for this file, just
define aligned_alloc to memalign as they share syntax. I should have
seen that when browsing man pages. I'll give that a try soon for
everything, but Mark can you try a quick change there and see if it
works on OpenBSD? Thanks everyone!

--=20
Tom

--kCZK/BciFuBJG4Ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS9IOAAKCRAr4qD1Cr/k
Cs00AP9Eo+8qw9CByELNYQfWSBHh6wIuBd3/h6rhdtO2XM3Z1AD/b6k60xoj+7nz
dvo2oJ7yuJnmfVE2PcmCRZx4CQIDJgw=
=c+uF
-----END PGP SIGNATURE-----

--kCZK/BciFuBJG4Ut--
