Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE064E87859
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 20:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C42F83CBD;
	Tue,  3 Feb 2026 21:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XzRrLZx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCE183D2E; Tue,  3 Feb 2026 21:03:20 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB1983C39
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 21:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45f004e7d71so129629b6e.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 12:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770148996; x=1770753796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cahStZz97HeSJtT+2CR6pRZ0M9yVde9dNxKH4Z0dQOg=;
 b=XzRrLZx7DH7pLN9PuxkO7vFDNyltublYWfGEYerdBLzR0SoEVILWcVDBfGENzBGyHo
 mtm3xfLTJlYF5GZgYlrINf16vrw7C5lOXmOgLOHSYbSpgLp7cmbGyZePL73NOVSX9zch
 +JGkBUnWwbVVwaYkA9lzaPqdR9A/mGCwiIinU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770148996; x=1770753796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cahStZz97HeSJtT+2CR6pRZ0M9yVde9dNxKH4Z0dQOg=;
 b=XIUIhF+2mMai165/MnMrdPGt3tr97oFM0NqUpPRiq0/9kIAEOIu+63lvTKugUdCfRC
 1UGPB/wL4LlMp/2geYhsAYUX7rD0Y/G3ErlOdBBcYZRK3zdkCoGDEj6Eit8qN756cCDd
 vXbI5d7hk8GVEToLnpOW5zKCvetKtQeknJYCzC/UKgrgcnsEhcvXPFTbvjC/KMBXyX+C
 ttm5SGZSjGbN/x1BNm6QqvB0wJrhGaPiWd2GhQSgS0Lg4B27sIQF5ucdcmAf0U2w+BQ5
 dFLy6nStShWBrqsIUJAAfyRuJhNV8hQZqUcisCD0t/jU106ohBhC7dHCp0HXX0hB30O3
 UePw==
X-Gm-Message-State: AOJu0YwrLn8cXqPE2NqSkyyZOfLresCERl+ExwNBjtlbAvuFbh7bMkzD
 YpzhSqqyGHwdfOOvYOnkcWwb8utybStBZvfbshhbyvDaoO+rYetXXXaDwHLd06Ah/Io=
X-Gm-Gg: AZuq6aIrprgqOVPFjpJirAq5NVdhgCRZyu5eomRsipML3u8Ypdgcpv7PEtz3Rr96/hq
 ASKua1aoq7P8s/ph4oF5UJlREwgr54YVWVq30ACQtH3SpbPU65MAvxonmSrH4qFz0EfZ4HgVodJ
 lqvCln4a6GLZoEpbBdY9q/p9o4hskIPqZM+LVhXb765zcDRkaDuEw34jOsCQ6Fe+Wn7tyHaKjIi
 u+pOj4DfpASmk3e5Sl98nVcrGWjyaqj+BRJOgegKRTtSpLW0pBMmEXWbwSjUfeyo3I3+KcPjgB2
 AF22RCQXrsIEGg6Y73jMarRmNzaGedMglBXVfnEyWIWG6d9Tt22dF5tMvoF1NVgyOJAciX5hwPZ
 +SVx0gl+p7hrG92MWhb23AEAilZT2PUkVHYn7/KJ0UES4j+J6zzfGrailTrAO3rmCmybj7r/rAZ
 ka6nRS9aeLHw7aMbqKv4Awo0NIv9u/wZefhwZBDiwsGZDsI2NKMq4F/BTWn9Z2tHmAuZ0PWSgZ8
 icy+u4D5uzEYgC7ajEucf4qbQHJgxJ4CYzUmPU=
X-Received: by 2002:a05:6808:328f:b0:45a:6adf:4d44 with SMTP id
 5614622812f47-462c11f0436mr1559546b6e.12.1770148996319; 
 Tue, 03 Feb 2026 12:03:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a53c3c4dasm281553fac.0.2026.02.03.12.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:03:15 -0800 (PST)
Date: Tue, 3 Feb 2026 14:03:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] doc: develop/process: Clarify name usage in the
 Signed-off-by line
Message-ID: <20260203200313.GS2603314@bill-the-cat>
References: <20260203191620.1476575-1-trini@konsulko.com>
 <379af4c2-082e-4437-9d64-bdf9f52c326d@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4Juvt1V9+Ev7mSqk"
Content-Disposition: inline
In-Reply-To: <379af4c2-082e-4437-9d64-bdf9f52c326d@cherry.de>
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


--4Juvt1V9+Ev7mSqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 08:58:44PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 2/3/26 8:16 PM, Tom Rini wrote:
> > Long ago we took the Linux Kernel documentation about adding a
> > Signed-off-by line and adjusted it slightly for how we organized things.
> > In 2003 Linus clarified the intent and then re-worded what the name
> > portion of the Signed-off-by line can be. Mirror that change here.
> >=20
> > Link: https://git.kernel.org/torvalds/c/d4563201f33a
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >   doc/develop/process.rst | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> > index fd81d9c5ebd4..3c783ed5a0e9 100644
> > --- a/doc/develop/process.rst
> > +++ b/doc/develop/process.rst
> > @@ -139,8 +139,7 @@ document.
> >     message by which the signer certifies that they were involved in th=
e development
> >     of the patch and that they accept the `Developer Certificate of Ori=
gin
> >     <https://developercertificate.org/>`_. Following this and adding a
> > -  ``Signed-off-by:`` line that contains the developer's name and email=
 address
> > -  is required.
> > +  ``Signed-off-by:`` line using a known identity and email address is =
required.
>=20
> Just for your information, the kernel docs also have an additional note:
>=20
> (sorry, no anonymous contributions.)

Yes, true. And the linked commit dropped the "pseudonyms" part. Since we
didn't have that part at all I decided to refrain from adding it.

>=20
> Not sure if it's a necessary distinction but it's there. See https://www.=
kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-cert=
ificate-of-origin-1-1
> (a bit lower).
>=20
> Looks good to me in any case.
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

And thanks for the review!

--=20
Tom

--4Juvt1V9+Ev7mSqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYJUfgAKCRAr4qD1Cr/k
Cg7bAPYhjF+wvbk0KdyQOCbQPcscpZXOxHq2QhlqZHHKxD64AQCEepbwyqDAlVt6
961IDU9sL8Pnr4c2bpfXb61h/BaiCQ==
=l8YE
-----END PGP SIGNATURE-----

--4Juvt1V9+Ev7mSqk--
