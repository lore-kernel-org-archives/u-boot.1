Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397EBD1266C
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 19:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0DB183F00;
	Tue,  2 Dec 2025 20:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DmSDwKfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4CB483EDF; Tue,  2 Dec 2025 20:52:12 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A9083F00
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 20:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c75178c05fso1694672a34.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764705126; x=1765309926; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R6xfJ/W4EBaU4h1f/Pbv5TMTa4mItDSq8h4GStM1t8c=;
 b=DmSDwKfoYZuMbyWmcaZsJoQfmeI9VLaYOIhxV2gO+cF3xdDsuwfSm5acYgLEmthLQs
 NiWYeHaaF6k4/UChLBtFvla+NccwsnMjS37qXTMbVyhgLML09Enr6BcKrp9H5t3uam/8
 oZecrcvd7z9mqnNCuWhfKZrAMB4p8krUwkjak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764705126; x=1765309926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6xfJ/W4EBaU4h1f/Pbv5TMTa4mItDSq8h4GStM1t8c=;
 b=w4QIIr6PZhdNZLPpmxLxPeqmWMlx/NgLi3fM0sEAzeZUapCJxvPJPvbTx/xMwv1jth
 B4uQKRAwmTa5gYtLyuc20b/hs//BPKPwKJ5uilXYTImL2uhyI0PUzFA0HH/L8Q2HRMvg
 zq0gsJ6bymM4nm0tO2K4EhKg2mebDl1JhvMaNp1ljH1wfKVWil1RNsPI5fJZuvCMizGz
 pGhk+Hym52wtrEYEtp8BVU68FuJL9vrvH9KcZasLpGaPwHYPvXWBA+Q56Q8XQ0hHJQzE
 vpkpk1teykLCmnS/oIWlKNd5x+ixFwFi/cMuZgvyX9Itw2tJtVRnBexFkORkK6akt44l
 0uJw==
X-Gm-Message-State: AOJu0YyMrWiZwoqMmKds1TUXwERWSivOxULeWxmCz7LQ6o75gyV5B8rx
 jUvdAx9JUfZrECDCfoVL8KpN7bvqpMW0jCRSw09N1LIq4LFWCv0ddEEQGyehkjwmjwk=
X-Gm-Gg: ASbGncvUeAUFQDI9kgBE5fqTE9cXQBscBLuertof39lGZHs1ttvNLvGfh6WjWzIppTF
 1BPB6U2k9/TyvVkPTg74jP4mINz88tkquZs3vxpdHrvR54a1Q61W9C9v/iyCDu2xtMDzQgEY2KN
 OTcl8EstIKRcJ6JNKW88WSwBQ0+4NCVzNz3PPzdojoYs6/PXauh4C0ySVv/YnwqWfnkOR8JNXnn
 zuvszt1IrevUzP/4FoyrD5EhV+GyHUfkRlmN+NbiDH2Z4WS/pZ5PFiJojYYSW2MN/S/QQWCl5zk
 bae/NQbfyYX4IjFUWW/jeC+zuqxRxDaHAEyYX7TI/kp04QjwaXYuy+mmn5euYcgTBM/X/aeDDa8
 IQ8SBtCTUIQUiuXExkbsq4WeOZTQz9oTtXQF79Y+VeHU3RFyYeHB7MTgPnrDO3HZquK9Q1T9yDs
 r4CLBz7hj8+kdhjhWYJd/GSldrBjFHGQfME6oLEIk6/VyuFrBBhzX5Srulr6oe
X-Google-Smtp-Source: AGHT+IE9Vqp7gBOkdkbzUIppWkabNMxc5C+M4ZoJ48YKSEUYodJQQaym24t7do6/YR1BainJzQ/Rqg==
X-Received: by 2002:a05:6830:909:b0:7c7:8280:9207 with SMTP id
 46e09a7af769-7c798ce83fbmr26085546a34.37.1764705125612; 
 Tue, 02 Dec 2025 11:52:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0be23sm7133873a34.21.2025.12.02.11.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 11:52:05 -0800 (PST)
Date: Tue, 2 Dec 2025 13:52:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
Message-ID: <20251202195203.GI303283@bill-the-cat>
References: <20251202182403.GF303283@bill-the-cat>
 <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
 <20251202185222.GG303283@bill-the-cat>
 <877bv4braq.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q3MSuCMeqNqN4yM8"
Content-Disposition: inline
In-Reply-To: <877bv4braq.fsf@bloch.sibelius.xs4all.nl>
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


--Q3MSuCMeqNqN4yM8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 08:46:21PM +0100, Mark Kettenis wrote:
> > Date: Tue, 2 Dec 2025 12:52:22 -0600
> > From: Tom Rini <trini@konsulko.com>
> >=20
> > On Tue, Dec 02, 2025 at 07:49:07PM +0100, Mark Kettenis wrote:
> > > > Date: Tue, 2 Dec 2025 12:24:03 -0600
> > > > From: Tom Rini <trini@konsulko.com>
> > >=20
> > > Hi Tom,
> > >=20
> > > > Hey all,
> > > >=20
> > > > I am wondering if at this point in time, anyone still builds our ho=
st
> > > > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> > > > Windows, natively.
> > > >=20
> > > > I ask for two reasons. The first of which is that a reason we still=
 have
> > > > to support Azure (despite its slowness) for CI is it's where we have
> > > > macOS and Windows hosts. But at this point in time there's so many =
ways
> > > > to have Linux userspace running on Windows or macOS that I don't kn=
ow
> > > > that there's any value to these builds.
> > > >=20
> > > > The second reason is more macOS specific and is that with:
> > > >=20
> > > > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> > > > Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > Date:   Thu Nov 13 12:54:51 2025 +0100
> > > >=20
> > > >     boot: Assure FDT is always at 8-byte aligned address
> > > >    =20
> > > >     The fitImage may contain FDT at 4-byte aligned address, because=
 alignment
> > > >     of DT tags is 4 bytes. However, libfdt and also Linux expects D=
T to be at
> > > >     8-byte aligned address. Make sure that the DTs embedded in fitI=
mages are
> > > >     always used from 8-byte aligned addresses. In case the DT is de=
compressed,
> > > >     make sure the target buffer is 8-byte aligned. In case the DT i=
s only
> > > >     loaded, make sure the target buffer is 8-byte aligned too.
> > > >    =20
> > > >     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > >=20
> > > > Which does things we must do, we now don't build on macOS. Why? As =
best
> > > > I can tell (and for a general purpose OS, is a good call), memalign=
(..)
> > > > doesn't exist and you need to use posix_memalign, a not drop-in
> > > > replacement. We could spend some time reworking the code here for t=
hat,
> > > > but for now I've instead gone with this workaround so that CI can
> > > > continue:
> > > > https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsu=
lko.com/
> > >=20
> > > Are you sure about this?
> > >=20
> > > The code in boot/image-fdt.c is part of U-Boot itself, not the host
> > > tools.  As such it should be irrelevant whether the host OS provides
> > > memalign() or not; U-Boot provides its own implementation.
> >=20
> > We use parts of this code as-is (and some other less obvious files) when
> > building host tools.
> >=20
> > > OpenBSD doesn't have memalign() either.  But I can still build the
> > > targets I care about on OpenBSD.
> > >=20
> > > Or is this about sandbox?  Did sandbox ever work on macOS?
> >=20
> > It's about "tools-only" build target, but also I suspect that if you try
> > the next branch right now it'll also fail and we'll need to figure
> > something out.
>=20
> Ah, it is only on the next branch.  Yes
>=20
>   In file included from tools/generated/boot/image-fit.c:1:
>   In file included from ./tools/../boot/image-fit.c:38:
>   include/malloc.h:824:20: error: conflicting types for 'sbrk'
>     824 | extern Void_t*     sbrk(ptrdiff_t);
>         |                    ^
>   /usr/include/unistd.h:449:7: note: previous declaration is here
>     449 | void    *sbrk(int);
>         |          ^
>   1 error generated.
>=20
> Which points out another issue with sharing code between U-Boot itself
> and the host tools this way.

Yes, it does. We only kinda-sorta made out OK before this change, and
now it's really exposing a few problems. I'd be more inclined to worry
about renaming include/malloc.h to include/u-boot/malloc.h (and in turn
using <malloc.h> for USE_HOSTCC and <u-boot/malloc.h> normally) to
support *BSD than I would be just for macOS / Windows as I do know there
are *BSD users out there, along with yourself of course.

--=20
Tom

--Q3MSuCMeqNqN4yM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS9DXwAKCRAr4qD1Cr/k
CgJfAQDQ2ghbVHuoBlxXLmB+lNcd8Ep3KzfIOwriF/mijyf+KgD8DcFN+4S8MJ9y
r7MVa+YTJxfTR1H0Y468Ig6Mxs5OVQ8=
=WYem
-----END PGP SIGNATURE-----

--Q3MSuCMeqNqN4yM8--
