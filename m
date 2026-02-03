Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62633E8B363
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 20:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB5783CBD;
	Tue,  3 Feb 2026 21:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gmFFo0Yw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E6583CBD; Tue,  3 Feb 2026 21:42:54 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C0883C39
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 21:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45c70afbeebso4018014b6e.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 12:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770151371; x=1770756171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nuix2CMsPwl4IXzcQ0QSpL5nzLaOGcpWWvRWaZar5GM=;
 b=gmFFo0YwF2vzyXGxzgn5+RdfqnO3KVcrBPv6poMvNZT19P0MGj3GAv62L5/cIM3LIg
 YyGWvlZ/Wb26T7/2iiBds6Htu0XQYvr/VTp2TSt9XocQA+/0IF0whUzIq8r+TWIPPDIO
 Ki23gs7VBOpJcM1/gUCCGna2fDRhfZuU3PAK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770151371; x=1770756171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nuix2CMsPwl4IXzcQ0QSpL5nzLaOGcpWWvRWaZar5GM=;
 b=vmBbNpgHIYEW0BUpb1iazWosSf2qbWK8zWW7i3tLYrSQklkd8bAHARMdGRL1CrpRxb
 XmhIptg1C7ZsgEMQwRQvgzGztC5theJrM02eNxNUDXpcJQQlOe6HLtnQG4q0yrSnn5K4
 tvKEwx2AxqbiVBnX3mYf3anhO4k6ks3VqjmG9WevrPJoleWwUHpaXCrGQQ+tsSMG5bbD
 YEy2aZ4A/KpiRfvgfOy4I6YwGjeJVrDHAxSl6+uPiiwwba+r32YDxWveLhqXBncp3deO
 zen8rHna8UY/U4O4THN24+yb3MQy8GuXUyeYb8nKysHAsWvLDJH0VDU5hAlpXmdnP7aq
 sJ4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeWkTDjFeLHjlbaZSU5VSZ7nPJ08VUeG4pg7q7L/TiLbzS8y+etH5o5RhBNs4qi7Oss7uOyro=@lists.denx.de
X-Gm-Message-State: AOJu0YzmRnWPr9lDtCNq3mwcSSXNnQy4GvSYU872eaqr6fVMNEFxMIvb
 qTi0ZkkmETAM9+JMppuiiu0H/kicC8rW5hQDBAciNjGIk0CvYBYCeC6MQ/uX2eARr/s=
X-Gm-Gg: AZuq6aLbG1yzsfbtCoYGOekFb+cfA704zgSMMEH3b3Vz7fJEz2PGzrnvJIG1U/mdsJE
 bMo4upiJhgDtnf/81xwc5eGCF0hKKDgGUmCKeXwE0OfQ20bHNXuZOaQ2qMGtgSo88BLWYmkdoHP
 XG/pnng/DAaeeGyK4a9pt371DOz306IA8x1d7OMAhPvAkbTRtxZTYnY3LQpzrQKl29Uq/ZupZVX
 RDOZ9rZGsvaFcNcX7IgLPJtbCj+LpOZ4jQp2epTsDZ+gcBrHYm7U6tBvRRfL0MnOBEwTqpDS55R
 +Cfdu/ODUvRXWXw9kIaz9CliubetNDqGWD3erIDGd1KNZ/yL2YdpFFQV7wDkbfl08XFLtdibfx0
 CFHnxFLG7huroiy3czS9qlCJ125NFiv33FnsonTb+N8rq0oFm+TH+rTEIciJI4XN6QOsz2z+kbV
 dtIxFIZejaqMU3bbTJhzoGSq11+ryvPVy65wxRVJUWtOyVzALrz9uNnCzCyA5hT8wWZg28D1gNF
 4CQ4UtQT5bdvugZRchmPmblSTmuqzexNkBNqmw=
X-Received: by 2002:a05:6808:222a:b0:45c:8724:3608 with SMTP id
 5614622812f47-462d59c53e6mr360608b6e.35.1770151370683; 
 Tue, 03 Feb 2026 12:42:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462d6801c3esm209715b6e.21.2026.02.03.12.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:42:49 -0800 (PST)
Date: Tue, 3 Feb 2026 14:42:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] Add missing =?utf-8?B?4oCcbmV0?= =?utf-8?B?4oCd?= prefix
 in help net
Message-ID: <20260203204247.GT2603314@bill-the-cat>
References: <20251227181852.4404-1-linkmauve@linkmauve.fr>
 <e2529768-467d-4bf5-a27f-9e50b8defdb1@forissier.org>
 <20260102154336.GF6124@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IoxMFy1fs3GFCrCH"
Content-Disposition: inline
In-Reply-To: <20260102154336.GF6124@bill-the-cat>
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


--IoxMFy1fs3GFCrCH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2026 at 09:43:36AM -0600, Tom Rini wrote:
> On Fri, Jan 02, 2026 at 04:19:03PM +0100, Jerome Forissier wrote:
>=20
> > On 12/27/25 19:18, Emmanuel Gil Peyrot wrote:
> > > From: Link Mauve <linkmauve@linkmauve.fr>
> > >=20
> > > The usage of the net sub-system was missing the complete command for =
=E2=80=9Cnet
> > > stats=E2=80=9D.
> > >=20
> > > Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> >=20
> > Not sure this is a valid S-o-b as per the U-Boot guidelines (real name
> > required?). Tom?
>=20
> As that is presumably Emmanuel's pseudonym, I would prefer their real
> name, yes. It's also a trivial enough change that I don't think we need
> to be overly concerned.

Coming back to this thread, I've posted:
https://lore.kernel.org/u-boot/20260203191620.1476575-1-trini@konsulko.com/
and apologize for getting this wrong here.

--=20
Tom

--IoxMFy1fs3GFCrCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYJdxAAKCRAr4qD1Cr/k
CqisAQCNbBEI8KT5DduZqzfnB9nfard/Y+Q1TnMrl5jKPknOMAD/fzvdvAqNBOx8
S2m5EG7YWGbTeT4Lqi2TO5pfrE0BUgc=
=dg1t
-----END PGP SIGNATURE-----

--IoxMFy1fs3GFCrCH--
