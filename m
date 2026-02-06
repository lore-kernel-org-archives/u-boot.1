Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E04EE20AF
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 15:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04014836D3;
	Fri,  6 Feb 2026 16:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DEwRXGo5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C50838FA; Fri,  6 Feb 2026 16:32:06 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880728352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 16:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45c733ccc32so1482879b6e.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770391923; x=1770996723; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CXrLYVs/bvUjnMjB+8KAfm2a4lo8C8pwWSj9So0EaIQ=;
 b=DEwRXGo5F6f7qCcUAcXIC+M/7orGnNF28R1/Yp/NRG8Xg3+cI9qqNTVQnXTnqNy0xI
 /PCfAg/lSArtovWO18z9Waz48m+tSYW0fn/6JUG7qWNS9euJIR/Sa+zUwqWOUugiRRVK
 G6qSJyVnZdWCmzoxR1Q2S65y0+IUNlemPtgto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770391923; x=1770996723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXrLYVs/bvUjnMjB+8KAfm2a4lo8C8pwWSj9So0EaIQ=;
 b=iN2cIDIzJjOJWserjuz1Bh2UM58J87MfAWkwl2sGHgzHmFbL32jrKNjHJyWvVapOpe
 wPEOzIK4sfDzxLkaUYBKiNrz2jBPVYCF5fGne9Dtq7+OpJ1QgH2ilKo4QDlGE4GB6TL8
 eP5bRefN8bMNrR8Un2mHf4J0rUgfrogE85UCOgfzDhKYNW5rGO1jcFTD291c3P+iDG6h
 EH6MR1uK/otBfJq2+wctE38+dmHWCnuw8mgDVbMR2GiBB24B7rt75lntpPYPEFMEoKNZ
 p6OG4uSp3djmJ8GFaKM+skUmzTJ5k6G3ivEBOM9QdVKPZNiMh3CbmDaaHElNsaBtaTZ1
 2XIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXISsMyuLhO/quAxs0iM0VQVhObiEL+QC/Mc0WNHst55Tu6vPMCrEXJhQ+58xQKwKnlBytX/G4=@lists.denx.de
X-Gm-Message-State: AOJu0Yydd2noY+b6d6v89vCIhMyDOiXqrYZVd/7XUO0gWEpFNHMrXMGA
 Sfk5F5Ng3US/MYxH4KrxsFht/Q/ixi+V5d67GtUj0yvG2hmegcrUr28ACkWtxwGU0vXEIRENM8e
 GnhJ0TGc=
X-Gm-Gg: AZuq6aJLakLe/Wok3KuIxwt3P/PVsLB1UsAWjR1W/ZPN8e7eD8sQpAbjVNhThqIYIwS
 Wds+xd4jfL0VlZlHZPP9nm/o9BOr1xTaJ9cBPn0Y7t7jsXh1BzB9WKU+ivbC6hFju5VAT7l+T2X
 ejKRLLuj50ykpdA7l0SIe9kOtb5AJrL7fGBgui7N5OQUq7q+R4AcUMzR4coUNsn0IEvp04xCUuR
 1HQ7T3YOA5IiGLhgl2YOqHw7pq3AKoJe9ZS610jFBYbKKDG2UYPeLbjnJJRs+Fh2kw9+Vxu+knV
 jijWzEYjlfSFiCewSLGJxE7tVvm32gKO46da1Dx5CLS/OnpsQgomo9401BaUGfEmBVmNhG7/oGR
 6JlET1Z0sN6QsVboCQi4aHamw0zFQrt5Nfkw71Qds73EPS9rpkT5FOzoawGsqvn8odtCuYfPSeV
 eOojYeJt6ZZIbdBSbPT+r8M+IJqRvtPHC6B1YWJo3eBwqkSbefnHZzdNU13N932GKTnchRnwuk7
 J2KSsx+BjdxoAuVb+3co2JNyHTIgqgqm31TZ5s=
X-Received: by 2002:a05:6808:4447:b0:45f:22b4:e63b with SMTP id
 5614622812f47-462fc9df071mr1738897b6e.7.1770391923196; 
 Fri, 06 Feb 2026 07:32:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a992edd71sm1933231fac.5.2026.02.06.07.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 07:32:02 -0800 (PST)
Date: Fri, 6 Feb 2026 09:32:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Re: Re: Re: [PATCH] arm: Backward compatibility to U-Boot v2020.04
Message-ID: <20260206153200.GV2603314@bill-the-cat>
References: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
 <20260203170002.GO2603314@bill-the-cat>
 <f8f1197e979b4998afb5dc952f7a8a63@rohde-schwarz.com>
 <20260206015447.GP2603314@bill-the-cat>
 <989f3c4aa5a04fd3b1c2efda1aedd459@rohde-schwarz.com>
 <20260206150345.GT2603314@bill-the-cat>
 <1000751cb4604e768e2f789c3dfda18e@rohde-schwarz.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RSyY95j8jcshplNe"
Content-Disposition: inline
In-Reply-To: <1000751cb4604e768e2f789c3dfda18e@rohde-schwarz.com>
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


--RSyY95j8jcshplNe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 03:17:15PM +0000, Dorde Stojicevic wrote:

> Nice. =F0=9F=98=8A
>=20
> From what I know, Lynx wanted the "feature" of being able to impersonate =
Linux, so once it=C2=B4s builtin between real OS and U-Boot, it is a no-bra=
iner with "nothing to be changed".
>=20
> But it seems like that detection in U-Boot was not working properly, then=
 Lynx built on top (unaware of the check that needed to be inplace), and th=
en I came with my "quick=C2=B4n=C2=B4dirty" solution. =F0=9F=98=8A
>=20
> Maybe the really-proper-solution would be that Lynx just does the complet=
e proper impersonation of Linux, if that is what they really want as a feat=
ure. But to clarify this, we would need some one from their side. I have co=
ntact with them, should I establish a trilateral talk on this topic?

Yes, it would be great if someone from Lynx could chime in and we can
all work to solve the problem here. Thanks!

--=20
Tom

--RSyY95j8jcshplNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYYJcAAKCRAr4qD1Cr/k
CrbBAQC8sBfhZZtfHnAjPy8q/U/dkV+LBSD6TaqHEqvWdFSILQEA5dhvvpvt4CMl
5D4rhA6WhPIQuJihelXxMvpnJi1RGwc=
=PUik
-----END PGP SIGNATURE-----

--RSyY95j8jcshplNe--
