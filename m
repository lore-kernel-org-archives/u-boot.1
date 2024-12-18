Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB97E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B45080269;
	Wed, 18 Dec 2024 18:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BhMw+6/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A8FD80274; Wed, 18 Dec 2024 18:30:25 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5D780241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8adbda583so78456246d6.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 09:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734543022; x=1735147822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gO4/k+B22Ar+D/VRA2t3k0vEpp0HuQFXbtfcBH/mXio=;
 b=BhMw+6/ZsYtK6sENJDRsz/QL1kyZ+FH2wqDEm/fpelNoREuI/YT4Ptn1u7ceVYeypl
 Bl6+xTSB07SX0nJjX+TZ3jZgI8joyHQ00Dyh8He3/QOynzYhcxULWJC6BuW/cRHIH5Ko
 EFD4r3LpdCkaYq+zb0RCKLnO+XHeFhFVQ2jd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734543022; x=1735147822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gO4/k+B22Ar+D/VRA2t3k0vEpp0HuQFXbtfcBH/mXio=;
 b=iSJr93VwHdpcF88svC3tMoE/ixkm/jgSZFFuiFcxNLn4w8GHankoson/0nkjnMhQxj
 NAt+97kgF6AEGiCp2OJHzi3Vf0IICMQmbFdeVtYLG9pC0+zuAuKWBiiCXR+qljWAwc9q
 sAMfaYsDMiAAUEAKPo1LKxfZSUYcNK/vI83hZ8LpS2oxVoA72EGRnFF/7s3NdYAjePrx
 P8akY5hlJNtcRVx6YAgkv+1wmmJeI7GRlngkAOKy7UwlVF31KRLNPZ6od6nRB5Az/SUz
 LaQe+th92m3nj4MCRIgRlWhOgI/B/JREX+rdcqUyOYaRGSDvpBTC1pm1vdDMQCpScLdk
 cGRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhMBZBwWvn0pAEkE1z+qRxRoXawSn0ZXysE//z5C/roJ2YFZIjtkrsAy8/mvlYVtv50sXiGeY=@lists.denx.de
X-Gm-Message-State: AOJu0YwbFTnVpPJIBXVsfMIqxAY5oNjFyH3T/WKUmBAh2nEhIkji6AeH
 0U6yMOFdBEWNaZhaV+2D1s+glhkLBEMar7zou9sYhicgyTbu90NXS8X8VtEmx1o=
X-Gm-Gg: ASbGncuzUQOHqIf5LL10M3KS8APTbkyIVqwAcLv0S45bDHrCkPIw7siGQtU7P+GybNy
 oITGAXnG9X/9VbfRTBjfJHyhtO+AE0ZXns8zyU1ItJJw9CY3+GzX2yW/MFn8xOnu+CY2cofC4py
 F8v3wM0MTGePQTeVDF4/H+OY/tH1LDmzx/6iXWPKjl3x7GzhDg7dg5c3v6so6NhsWU21luRjJVZ
 pNVR8s6JZrYlBQ7FWeAp5y2fB90ceWucdRIDDDSTDmFc0AumWQxhn8y
X-Google-Smtp-Source: AGHT+IFIM+HcO+LSvIxzByzmOgUGYmDZV4wgkzJfPEIhI/sV2sPKuy7h6L85qpNRGjanh6m5LkF8EQ==
X-Received: by 2002:a05:6214:2a4c:b0:6d9:3016:d10d with SMTP id
 6a1803df08f44-6dd14c9bba0mr6347256d6.42.1734543021787; 
 Wed, 18 Dec 2024 09:30:21 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2ec33f5sm53157851cf.74.2024.12.18.09.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:30:21 -0800 (PST)
Date: Wed, 18 Dec 2024 11:30:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] bloblist: fix typo in code comments
Message-ID: <20241218173017.GI1505244@bill-the-cat>
References: <20241218153933.37649-1-harrison.mutai@arm.com>
 <20241218153933.37649-2-harrison.mutai@arm.com>
 <20241218154803.GE1505244@bill-the-cat>
 <a41a8559-689f-49fa-a19a-2b1f8c4c62ba@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VfwZg9ZDRWP7dEPK"
Content-Disposition: inline
In-Reply-To: <a41a8559-689f-49fa-a19a-2b1f8c4c62ba@arm.com>
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


--VfwZg9ZDRWP7dEPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 05:23:48PM +0000, Harrison Mutai wrote:
> Hi Tom,
>=20
> Thanks for reviewing.
>=20
> On 18/12/2024 15:48, Tom Rini wrote:
> > On Wed, Dec 18, 2024 at 03:39:28PM +0000, Harrison Mutai wrote:
> >=20
> > > Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> > > ---
> > >   common/Kconfig     | 2 +-
> > >   include/bloblist.h | 2 +-
> > >   2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > Please add a short commit message body "Fix the two typos in ...",
> > thanks. With that:
> >=20
> Ack - will add in next revision.
>=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
>=20
> I realized I made an error when posting the series and accidentally left =
out
> the cover letter. Would it be best to send an updated version (v2) to the
> mailing list to include the missing cover letter?

Please wait a bit before re-posting, the cover letter is easy enough to
find, thanks.

--=20
Tom

--VfwZg9ZDRWP7dEPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjBqMACgkQFHw5/5Y0
tyxIXQv/YjQtCG+tgUZ6vkYlLTgUjgBxwUxohr8mfPH9P8O1HqB3fEkMofkrJKez
Hl+pIxx8SNh+9g/0KR4XJPsx4FCoz+wKGPaA1UfOvDylhu9HCkbAcvRRa/EvSqvI
B/unme3VseJ3e1KYY2t8ie7LPyBHQCmUSPor2T/0RY1acsG5750HJLKCi2qMyQzl
U5kR1nYj3iTUYmsQ7hqS+42flXrX9Kq84mYuHdQC6e4vA4s81DTW1W/+JxDeFray
9pdDN3KBy9dgykFNjk+ztXYPfgP03SpUermJ0svbqRO9ajvSZ568EPW/UQyoH3z5
dpr1s8Mo5wxkuWEkNg07MkMKNrPlg1cQ1MAUYIciFe/MtSeQ1i6nDJabcHw9lvFv
o697icOC5FOUrzbiVrjFG3OS7XxwaDQJd0iOfT8yuk/63qDinyft4rdUypFCOYsp
HQCOWKu5Ieebt1WOz/hZQD7+WglM2/+97S9rnQfsBL7Eds32ZeAP29nd0fFvkqqU
MOAwDXV+
=PnQX
-----END PGP SIGNATURE-----

--VfwZg9ZDRWP7dEPK--
