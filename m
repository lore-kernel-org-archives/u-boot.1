Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07D0C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 19:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48BE88548;
	Thu, 27 Jun 2024 21:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WXmg1pBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C43E88511; Thu, 27 Jun 2024 21:40:13 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B9387C86
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 21:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-25d57957b37so1200735fac.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719517209; x=1720122009; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wazim3CywgnQD0vKGBArwIGjCzZXrWkOCDa+GgY60ic=;
 b=WXmg1pBIu0sEMWa8zHmi52of+SLbW+EjR+QLzVcsa4UjCG6QCoPcyTvOGrJDPSdiF1
 GYwWbj9KPg4v2hyh9tEE989Zz+cyGpS3oKJtJ1yCrS10EB9g5LqjMq++LOBBFfAb74vp
 KlCuYlbEA4bRmDJLsHPFDxxGa4xfx+OI/IM5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719517209; x=1720122009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wazim3CywgnQD0vKGBArwIGjCzZXrWkOCDa+GgY60ic=;
 b=ZjudKEfcofqLmn0jJ+s38n8kG6tbnly8EDS3erGqgMmachADbpUHoIt0p6mp81tWZY
 U8igxMj2cZHevjVyYs+CLUMvYTp9f8Lpp/oamSTj74k3ZKYCaC5wCl2OptVALrBy8Xfh
 KSEfbeLwEm7U2t3dX3LUoDIsxxmO5FBiJZpP9wfFQ6BaxA8s5AkBPcUcrrl3Jqw1YIEr
 ++aXoG7EhQRJzkPU3bXbaD+eTGmC4ROyrTBT52/eGsA1tXHgxmqrvx4ytcgUA6QadziB
 uxQ60PHM8ob16dXPAeAjh7Bb9jYwaPQ0aucbAdVkJ7UN5WycRss3e6KeQlcqkSagZ3Hm
 JJ7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdeMWlfrSJRpblLmJaKnB+aw2FZJ26Vg2ITNNwKKzR6eRV7VSR0Y38x1c3n3PifACfjV36C1D9+P9wJvWmGhR9XJBVVQ==
X-Gm-Message-State: AOJu0YzKC1aiUUG3iE7FXzyzGIelKlJWiMW5ezcjqiNe0A0itRMNF/YT
 YBOpXP2dwDG5ypTHGPN7apvFsI5L8T7/pDSMCIntFY9d6bvaDXhTL3Vx5Gh0Jwg=
X-Google-Smtp-Source: AGHT+IEEwxxmzUIUcxLetyL6LWS/m4RfBOLkqMKXm/Fe0QGFEsLwUJdBgxKIDPv4B147ahcs4euReQ==
X-Received: by 2002:a05:6870:c111:b0:250:831b:49b1 with SMTP id
 586e51a60fabf-25d06ef092fmr14660816fac.56.1719517208908; 
 Thu, 27 Jun 2024 12:40:08 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ab1d32sm61993a34.27.2024.06.27.12.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 12:40:08 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:40:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] zlib: Fix big performance regression
Message-ID: <20240627194006.GG38804@bill-the-cat>
References: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
 <20240627193455.GE38804@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HGNJDH3Ompq52wLt"
Content-Disposition: inline
In-Reply-To: <20240627193455.GE38804@bill-the-cat>
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


--HGNJDH3Ompq52wLt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 01:34:55PM -0600, Tom Rini wrote:
> On Thu, Jun 27, 2024 at 10:25:21AM +0200, Christophe Leroy wrote:
>=20
> > Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> > brings a big performance regression in inflate_fast(), which leads
> > to watchdog timer reset on powerpc 8xx.
> >=20
> > It looks like that commit does more than what it describe, it
> > especially removed an important optimisation that was doing copies
> > using halfwords instead of bytes. That unexpected change multiplied
> > by almost 4 the time spent in inflate_fast() and increased by 40%
> > the overall time needed to uncompress linux kernel image.
> >=20
> > So partially revert that commit but keep post incrementation as it
> > is the initial purpose of said commit.
> >=20
> > Fixes: 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  lib/zlib/inffast.c | 51 ++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 40 insertions(+), 11 deletions(-)
>=20
> Both this, and my mostly revert lead to CI failures around compression
> tests:
> https://source.denx.de/u-boot/u-boot/-/jobs/859329

A full revert however, is fine.

--=20
Tom

--HGNJDH3Ompq52wLt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ9wBYACgkQFHw5/5Y0
tyy+AAv/dzYcO1N7CJlD18TjDNLOt8I/Wn4apFUBaQG/BFN6zy9U5jPylwV+YuKA
amqBzwvDurvXNFWnYQjIpS4atwXzG3qbCfdd8uzsZ5AjsqEWrUiLSn3Q4ADlVqbO
aE3MMPBh5yl/Xv4tF+nXID5i5UpIWiTJkvdVHoWmvDD8/YP9Is77zUrnOfm+aEN5
oa/9F1aHxjMkjvls1OFsr2B2sQSXMmYGd6BvH8jOn25UxLXxebp2tKDpfaAyLl6/
gRlR3l/IPfcWrdXT+M/aaI7EfQBV9GCYaof9tEwiDPlbOl5K6Dd3L+8KEJhXbXb2
hoLZy+B7VUYE5mVXVWAhrm0gzCa41SHM+ZFPMPmGl/ADuGoKVzDBklsh2qY+Ldru
yx++Bn8l9ICob5mJVDRqlYlnlRZQE2TtT/EU7sMC1qB5uiZMPn18oaEbdYuXMTzb
DjBK9nE/3pHmszzNHbjHi/wDAk+VwUBbTIIaCaq5arVtCuoAzZD5j0evZHpRMtcv
/WrUGAAI
=sXhO
-----END PGP SIGNATURE-----

--HGNJDH3Ompq52wLt--
