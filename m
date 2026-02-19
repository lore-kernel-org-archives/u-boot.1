Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD43E9A055
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E5A283CF5;
	Thu, 19 Feb 2026 18:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mIXKbgTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE15483D0B; Thu, 19 Feb 2026 18:28:43 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EEA683CEE
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-46394090d2fso378233b6e.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771522120; x=1772126920; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CqifEo2uD5QhHsSCFvVGWGI/eRZDUVL+EShG+NIHVBw=;
 b=mIXKbgTSxc1rO5AWKFAE/6A5Kvsv6qk/FmCmUXL3PQc6IB6XpIaCN2qLE+Cq3gpV2w
 6bRM/FXUqLYW5D7Rf8Bjv3ooRyQKhZJx3YidHQtgcGX666vB28xpXHNH05Fpf0Z5Srfs
 L7i8RprDFQ5K5DATgjPz/YFk8xqW+Y4OPsJls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522120; x=1772126920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CqifEo2uD5QhHsSCFvVGWGI/eRZDUVL+EShG+NIHVBw=;
 b=wyyIrhGSiuSi8RskImE4AyV5KQ0HDPEXdD8x80inck6ft4rY1bLay0bCxEsE1Nc/sx
 PBX79BOY1iUwBjVjzPUEpBbBZt1O8lYFoFwByXyJnWkY9xTpxdEgwDxDHinkdKDCyMUa
 xvO25KVhJqwXTg8dgh6joak/HWTw5D0zrQ9yYGQ4D4YASj7kjHaQmyHKpI8Zg6sWeSlR
 +0obIX53YGqLRLHMxIR2BqafhPZFtRydlIAUdNJ7v+J5rHHudgQ8IZYSNml2w0VEDubd
 dO+jpWIleldfqgJFQiJ7ISPTD0yzzW3jpb3HTKimQC83k8rXY7JScA78gcxkNF/z/nsH
 7+ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuNpl0BK2m+YVyZmIREVkCkdfJ7RbES3rYKJdbHGc1bvm4qYzlmMkb6GKh3vuTp9rYVmzSwCU=@lists.denx.de
X-Gm-Message-State: AOJu0YzBOwrsdq2IepG6zvwc9Q3RWt+igRttQCXEVH7YgGmP/pslIm02
 /Eg7phcSIe9E9Onhwd239UQDpGzijQiDc3jgEIFnnqR8h0pWv0E2BC71DP2XLgEBpek=
X-Gm-Gg: AZuq6aLCd2Vz5+Fp74ITnBEkXfPlssy7vXEscF3rVgCgrT0fs7/2dR+yK7oj1JGPowM
 3dca7Qf7zli0e1aHlK/uPrmbT0e1V9PX1mj0wOoXo0OazdDnKsKxz5769rQDAQYxHjrm9+CXeGw
 vEO68YecUpJtbRAKAGhsMXY+FTUQLkdnCjiA/mBbp8hDuix4mzo3+i3/STVBzJaRKWkd/T2PP/L
 Pb54o+3HWX/OyijIWJRvfqHLgwytwBXvv92xaTmxj834+xmKu87AZYmQH6ogfqXmA+MBdjgD09T
 m1rVEDoI/GE9nvHWVbao9GfGXiT1F03x4H1+Z+ttHN1l0O0poGqiUtuCqvNFP+pCW5xSSihAWLP
 7+SuLPlhfAwq58IaiwnNxxhQ4JBI1MjqiGLp1BzTIOGIGMF+8YDdcaQl+Wd918AvzIfhOtmoDEj
 P+tZ+fC5Nh/vknAeYQf4mq8iWu8lDjfEMGkkMcKLMxtw6+JjWN8KKLYmt0glDHr3BOrjNv7Y3kv
 B7TzpA4Oklp8+E6IEMgGGUWNR9/MxtyrGavhtaQjEsmv/53umYDCWO6L7KA0g==
X-Received: by 2002:a05:6808:398d:b0:45e:57ab:ad13 with SMTP id
 5614622812f47-463b4038622mr8749151b6e.43.1771522120042; 
 Thu, 19 Feb 2026 09:28:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4642b1c526bsm1118514b6e.8.2026.02.19.09.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:28:39 -0800 (PST)
Date: Thu, 19 Feb 2026 11:28:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <20260219172836.GN3233182@bill-the-cat>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org> <aZc_efHFk1Q-iWvP@daedalus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5X6896bmo1Vlucro"
Content-Disposition: inline
In-Reply-To: <aZc_efHFk1Q-iWvP@daedalus>
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


--5X6896bmo1Vlucro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 09:51:05AM -0700, Eddie Kovsky wrote:

> On 01/29/26, Mattijs Korpershoek wrote:
> > Hi Eddie,
> >=20
> > Thank you for the patch.
> >=20
>=20
> Hi Mattijs
>=20
> Thanks for the review.
>=20
> > On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com> wrote:
> >=20
> > > The Engine API has been deprecated since the release of OpenSSL 3.0. =
End
> > > users have been advised to migrate to the new Provider interface.
> > > Several distributions have already removed support for engines, which=
 is
> > > preventing U-Boot from being compiled in those environments.
> > >
> > > Add support for the Provider API while continuing to support the exis=
ting
> > > Engine API on distros shipping older releases of OpenSSL.
> > >
> > > This is based on similar work contributed by Jan Stancek updating Lin=
ux
> > > to use the Provider interface.
> > >
> > >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> > >     Author: Jan Stancek <jstancek@redhat.com>
> > >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > >
> > >         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR=
 >=3D 3
> > >
> > > The changes have been tested with the FIT signature verification vboot
> > > tests on Fedora 42 and Debian 13. All 30 tests pass with both the leg=
acy
> > > Engine library installed and with the Provider API.
> > >
> > > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
[snip]
> Sure, I can update the comment for v4.

Since we're talking about v4, can you please make sure that for v4 it:
- Passes CI https://docs.u-boot.org/en/latest/develop/ci_testing.html as
  that will cover some non-Linux host builds.
- See if you can get access to a FreeBSD or OpenBSD host and make sure
  the tools build still works there too? I was hoping Mark would have
  commented / tested-by v3 because I do want to make sure the libressl
  case still builds. At worst case, I have a freebie Oracle VM that's
  FreeBSD based, so you can maybe spin one of those up as well?

Thanks!

--=20
Tom

--5X6896bmo1Vlucro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZdIQQAKCRAr4qD1Cr/k
CvDwAP9e1LqcxoMD9aksSK/HZAhbXHFENxbbIpP/Njcq6jOTuAEAqWVR3FBMvt0H
Q28qDIdRiZ6UaNbFPbhMx0EdIPB+Wwc=
=PO5A
-----END PGP SIGNATURE-----

--5X6896bmo1Vlucro--
