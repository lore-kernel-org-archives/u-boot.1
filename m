Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD35CD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 18:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E469836AC;
	Tue, 12 May 2026 20:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="thGtEk+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5959F838BB; Tue, 12 May 2026 20:36:18 +0200 (CEST)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E058341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 20:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-48270f099d5so1919191b6e.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778610974; x=1779215774; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fZCgzixvYSjVQcR3GIWfNIfLndkS7iy4iA06rHu5ezk=;
 b=thGtEk+Yx6kzOK+5HiiIhILMtXO1aFE0eYzN0lIzsN84Sw5mBXNRbtI2Otk2sFoARf
 62YH7Zt/8l2D3S3olnIyqwop1ROjnJ+aCewc0U3Z/r7QVNUe/ws+xIA4AEhHV8eqnpFm
 06eCv7ifPiTwpyE0vsOrWEtio7zCHlQtTt+kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778610974; x=1779215774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZCgzixvYSjVQcR3GIWfNIfLndkS7iy4iA06rHu5ezk=;
 b=mRIAqUDW0t2q2FKNMOh8VG6XfL+fiLmUip+b0KVQkIX1MU/W6GGAxKZCiW2fi610xT
 lDqqlnUilZq1M36KMtsjp3NVK0U9euO7f7JFlatcYhGAS0U8U5RygbHXXZShiYhzVapD
 G26ZVfk59Xc0vSGHRIVxxYUohgq+jDUgTOxdBwY+MI/XnP6Mv0q4JEHSnah2p5E0it2S
 3qizZF9/rVlNalx+m5/J3C4P0DheNgV/Ikd5pEOUe83KjFJpiBG9YdNalQB+JJC0Uinx
 gKnS/FVA3w46s/V2d3BiFNGp8rRbBkef5bTS0m5j9FZjdI9ZotV6u54XpKwXmVFzoTID
 k+Uw==
X-Gm-Message-State: AOJu0Yz6HBi2xZbfa+rPCw+uBDayShzIlLwWaXUu83hHfl/kK+mUpmgi
 4edZgqu+1p3E1sXmP6ZPN7eFOKdaTcJwnD2ToWLa5iazmhGJjwiLrsT6VvByLi8PxMWsLovPBnM
 O/3rGPXGp2V/7Waw=
X-Gm-Gg: Acq92OFc9amO6w/rESvcFFkMA8my4NAMxGO9tgDwwW8JNIv6ZX3SHX0XSecm8Af5/0G
 +PFdhRAMaf5MhIw+HZLU0YRpNWM4WwQJFkobQ0JvMkvoOFXIjeQELgddK596oEqANu2rG6hZwPM
 hrsA4Sq3874WTUOVxW70Q8eMS5kqV6cr4vdseBD5t5NB1IP0kbI41X79NHP0LBg1eKiVbC3HBql
 62aCXr38jEshc1V5vsFmI99Hen4IKpeoUfBaK2GF8TxWNC3RdwQwIWRIofOCJPAyrCKZIMa7xe/
 LFxdDa2KSJAcq31qZkynmvxOrssM5QoIWYnUn40uC/LiaeMhikGQMdOGirMcDa9SP4SxKui70SV
 /yP4dSb+kyHdkwRtYfhwOnevyBTLzgGIuBZtk1XpzTZ9g74DJuN3UXAA0Oj0VKN+a5/U757bEok
 VyMEgXaf/Cm0ryzP7Pw2KGwEasaupFldCUl3nX6roJuGpeglG3RnbLAXNtVbWD1XrdCL7zW4YsH
 Lc02Lnv6ovJbEtaoHySjKmKmpxOFgBrapypvQzspn46F6yg0EE=
X-Received: by 2002:a05:6808:1512:b0:46a:746c:2d53 with SMTP id
 5614622812f47-482b2834e24mr170056b6e.2.1778610974105; 
 Tue, 12 May 2026 11:36:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935904sm22639299b6e.11.2026.05.12.11.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:36:13 -0700 (PDT)
Date: Tue, 12 May 2026 12:36:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul Barker <paul@pbarker.dev>
Cc: u-boot@lists.denx.de, yoann.congal@smile.fr,
 Hongxu Jia <hongxu.jia@windriver.com>
Subject: Re: Status of CVE-2025-24857 in U-Boot
Message-ID: <20260512183611.GQ1858239@bill-the-cat>
References: <cb01c903e27bd1aa6198a51b138409c08abd3373.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QjvUCiwNTFYKoB2D"
Content-Disposition: inline
In-Reply-To: <cb01c903e27bd1aa6198a51b138409c08abd3373.camel@pbarker.dev>
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


--QjvUCiwNTFYKoB2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:39:32AM +0100, Paul Barker wrote:
> Hi folks,
>=20
> We recently had a patch sent to Yocto Project to backport a fix for
> CVE-2025-24857 to our Scarthgap branch which uses U-Boot 2024.01.
> Looking at the CVE info, this has confused me a lot. It says [1]:
>=20
>   Improper access control for volatile memory containing boot code in
>   Universal Boot Loader (U-Boot) before 2017.11 and Qualcomm chips
>   IPQ4019, IPQ5018, IPQ5322, IPQ6018, IPQ8064, IPQ8074, and IPQ9574
>   could allow an attacker to execute arbitrary code.
>=20
> The NVD page says it affects U-Boot "Up to (excluding) 2017.11".
>=20
> But, the patch that says it addresses CVE-2025-24867 was committed to
> U-Boot in December 2025 [2]. The first release containing this patch was
> v2026.01.
>=20
> Is this commit actually needed to resolve that CVE? Or is it some other
> change back in 2017 that fixed the issue? (A yes/no is fine, I don't
> need a link to the exact commit)
>=20
> [1]: https://nvd.nist.gov/vuln/detail/CVE-2025-24857
> [2]: https://source.denx.de/u-boot/u-boot/-/commit/87d85139a96a39429120cc=
a838e739408ef971a2

This is a "funny" one. The reference to v2017.11 is due to when we had a
large rework of the FAT code and so the most obvious way to trigger the
problem was removed. The changes in commit 87d85139a96a ("fs: fat:
Perform sanity checks on getsize in get_fatent()") may, or may not, be
only a sanity check against performing similar attacks. So yes, it would
make sense for Scarthgap to have this change.

--=20
Tom

--QjvUCiwNTFYKoB2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagNzFwAKCRAr4qD1Cr/k
CpiaAQCOIzvgV36WxN5ncmzy5mffeVaOyrpmcBzf7hB374InAgEAvXpMJ1Vxvlhs
Fykd7FsSCbb9lXp7q7I2mvawH5IVgwU=
=0DDt
-----END PGP SIGNATURE-----

--QjvUCiwNTFYKoB2D--
