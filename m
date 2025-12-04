Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9063D2A536
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F4D8414B;
	Thu,  4 Dec 2025 21:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KLdxk8tv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE62E8413A; Thu,  4 Dec 2025 21:29:19 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A8368412C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 21:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3e7ead70738so930625fac.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 12:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764880156; x=1765484956; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T3Lqd+OYPjdR3kuAi9Meo2L1fKy0l5fQOmkHLmFpexk=;
 b=KLdxk8tvVkGER/NxJGV9IhNfyychrWjSzsdYbUnGSCU6nXmcqIhwFeqMxNM7x70gLl
 683KkREFO+GFyO7rhvoLstJLE+GknLpfBMa65gizhRdz8ly1kZmXnW2LVoiDoqIJcpP1
 qqzNDwOWWCxmhFGBtD2nUJtUEYbEmnUDibtbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764880156; x=1765484956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3Lqd+OYPjdR3kuAi9Meo2L1fKy0l5fQOmkHLmFpexk=;
 b=A/7F36k3tDqcO8+nDa0iYWYMk9WA25ym7sOkNOVx4/jIw8QZWupok1LR3JztkFD+7H
 bnFh7QT2n4/IpGxOD9+P5hcA3dcMdxf0XQfOK974I3jFfcag51cmENk+d86GW/x8luCy
 mDeTaLxtPUgo1Ee7xyeJQIHAT9a6GKQn3+eais/9FLW5pXrs9YEjOLfOXgr2k1SbJ4iD
 iKZohLgOjggNqDZoW7ScApsCy+9ehFIX0v/XlQle0g/WveNkEut7fziCwEzu1G9faULu
 mUboRpI+XzhYVTKE0wxItpI4tgdm6UtisJwJIaryn0Jh6a1sjjlkgJA4r3xDLhEO+RUU
 KujA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjLi0jRZAR3IM2794vTDtyxrtKMFZtJQGvwsW+NCnXeqMKfHbs6Ys2MCCV27N0fMpaO5KypFM=@lists.denx.de
X-Gm-Message-State: AOJu0YylJ6YL9/QTiZ02w6mkj76UAWGdaRKlDz66taxBoxcRSVNUsm9V
 z3x2lXzVCmH6rnA9L+EttVN5tLFPczCuQWdgeg8fGs48UDGzp05MrndC29ESS3R7asZZoLaSAh6
 kitHDlyQ=
X-Gm-Gg: ASbGncsOJRNQFRn9+aegTh9CFziioMz6tuIqNN23PaWY6zKrkEHoxbyMJqHOzFCJOXx
 mjKKmLRLKv86d79MM70ArE5MrqIlS/172CvNNT1EHGUNLVGNxbAxke6MMMYOZ4mB4NXgcikI+Ox
 SagVcYqdcCPt6+H4vhLnOueBpQ1CrYiso4SOOVNridKENdFzh8WTbp76sMcJ/yrgXn9pEHqzo6J
 o9kE1whGwtEsHjy4rac4GYotXA2OiyPaLx8IdMnBrtjvqz76s8e9KnUnuGQg6zH3TD+cU5WDy9p
 PR345EWZcFK1X/wrrLqB6gIFG/oBB+B0sGT4cgxCW10uGXeveSp7MN92tZp1YeK/NiabdPY1R4e
 RQSPCyRT6WpL5lz+CCYBVWXVGtG0gyBq2c5cwt3ZJLAJFrkklKbkS0wxMoWeMzlYSO0jmW7k6YP
 O7/fDljhAVzLdRghb9mlsxaSnOS+MwijfGnQSZDxn6gw7kJPWbDw==
X-Google-Smtp-Source: AGHT+IGhp5dlBYA0X2sZKZ9poI/z+nws8lJB23xhQA0+Ke7v+dfc3CL6Ci1WvqtvdDp0GmTgoRntEw==
X-Received: by 2002:a05:6870:b410:b0:3e8:8e57:a7a3 with SMTP id
 586e51a60fabf-3f5067e292cmr2169960fac.54.1764880156234; 
 Thu, 04 Dec 2025 12:29:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50aa34d4fsm1955374fac.5.2025.12.04.12.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 12:29:15 -0800 (PST)
Date: Thu, 4 Dec 2025 14:29:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] clk: Remove myself as a maintainer
Message-ID: <20251204202913.GD303283@bill-the-cat>
References: <20251203210335.1946142-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z96+SdGpUKkdR2LH"
Content-Disposition: inline
In-Reply-To: <20251203210335.1946142-1-seanga2@gmail.com>
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


--z96+SdGpUKkdR2LH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 04:03:35PM -0500, Sean Anderson wrote:

> Unfortunately I don't really have time to review clock patches. When I
> initially started maintaining this subsystem I had more free time than I =
do
> now. But I also found it hard to motivate myself to review patches.  Many
> clock patches add support for new SoCs and they are time consuming to
> review properly. You effectively have to spend a few hours reading the
> reference manual (if it's public!) and reviewing drivers is no small feat
> either. This is made more difficult since clocking is often very different
> between SoCs and it can be difficult to determine whether something is a
> bug in the driver or a workaround for some hardware behavior. I mostly
> don't care about any given SoC unless I'm hacking on it so I ended up with
> a ton (more than 7000) of unreviewed patches piling up in my inbox. I'd
> love to be more active, but I have a day job and I usually want to work on
> something more interesting when I get home. I still think the clock
> subsystem is a major mess but I don't care enough to fix it :l
>=20
> The subsystem itself should probably get orphaned since AFAICT all patches
> go through the mach/arch maintainer or to Tom.
>=20
> Signed-off-by: Sean Anderson <seanga2@gmail.com>

Thank you for your time and contributions over the years. Applied to
u-boot/master. And yes, we do need to as a community figure out what to
do next with the clk subsystem (and try harder to put SoC-specific parts
under the SoC maintainers).

--=20
Tom

--z96+SdGpUKkdR2LH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTHvFgAKCRAr4qD1Cr/k
CtJlAP9PrCpHknepg5semIHHLIZTW1Gy73cohJ6SH4o4/NxbwgD+MsaE60V39TVr
e3l4ieQTZndh7ZebfITvAI8VUV7EUgs=
=c+u1
-----END PGP SIGNATURE-----

--z96+SdGpUKkdR2LH--
