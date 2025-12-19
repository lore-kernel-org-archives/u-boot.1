Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07913D78786
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 15:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E185A80077;
	Fri, 19 Dec 2025 16:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qa5dhgaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65167803F5; Fri, 19 Dec 2025 16:12:08 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F097D80050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 16:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c76d855ddbso553063a34.3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 07:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766157125; x=1766761925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zsGwmUaO4AWFM4oLl4mFaTfyYQqcn4KbJigNrSWWPCM=;
 b=Qa5dhgaU1ccwbE5i3+LYQES/6Epa4xbAWjcrsBMnqb68xnZgVC/MSFTU/n5thYuJ58
 93BbCOTvtP7TOwpzyJQzCGeEflPUTg2ssZMEa1I9pp5Sfjn01eoyPJoaZy4rQDYUl6s4
 S7K/qQ0uOkHjhEmuxEY4Jc0LRTXFNfiqLTRi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766157125; x=1766761925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsGwmUaO4AWFM4oLl4mFaTfyYQqcn4KbJigNrSWWPCM=;
 b=une8chjCwRKsMmfGdHtVIIwwalSlVYS1GccqEyIJdTFFgDDegPQhFXpEKFvQWotq4V
 AgUe4a2cX//tprTk3u2S3ZVhb39G9xaMqY3tqLS2INR1WTxnAlBbLaw1l9oEY4zQjRAx
 SBndeBOPZkN7K3IEqGhk8ht6ZkKhbnct0nCStJkx+Y9pYdGCN4nmA/X++Uc8mTnblN4X
 yYh44k4T07b1KPrl4jb1opX9cUak0n4dKlntqKD781uHo6HSg69X1BEGCyqD7oAQWMvT
 eFl4Bnsln1qI7jC4MLn9H6GjYZYptVJ73VGn9gCcUxKPBlc6ddSJ2drydGlDPivZ4Zwv
 6y1A==
X-Gm-Message-State: AOJu0YxJ5QyP0MlKniXaWS5knvlKq2MW6F/heTLOn5wFEcS03Tib48q+
 3aDyGhWGHx8gETp6l9rOKvq8AQoFKEkxMKSC8y80dC49TTxezOqcNqRWA+pgGRWWkSM=
X-Gm-Gg: AY/fxX5MHH9c8e9+o94CYNua7wBw/ULRqaVsiNxyudgRoLGTza0c0PQD44CvdsKMaO2
 12V/KhDM5bHztzJkZLCWNiF2TP07mVDf3FJ203H+csqILEvr2BK/awoJAFQle1bksyQMmEeUM64
 11L1Me+vca1qZrDkKsgC9G1/UDzDV8BDTVE1MyXsAd498+fERErNJ3EiLnZuSbk9V2GzR8qPuAl
 ZQFtIGDjS6yXCJs1GVK4bQOLgtnL28JXG6uZjylIqY+wJGgqt28+hAkGwOt8TYDiM2Uocdh/0ha
 CRalrdNxQO+FJbXlXrT8qzs1crArhjMjrlhyrHFOX+7OHYv9eWQ6iDvHUZSUnOok6/Nrw4oHpwm
 r3SUTPa9hMym7/aaS7Smyh65EUiFGpAwnqSkBSSCmIoQz3n90LQk6JzjZHivl3CdLwJaez1H2rk
 tjHyURvCHcDiyQyAgG2xT5J7BIyOLxFMGQX2ohkYkYYFZ6fU0vUw==
X-Google-Smtp-Source: AGHT+IFWBFXRgB84wZK/A0zDIme3kawKQxzuDKJ+r8r7SgDGXIB/zvIQJlRgc+Ud1zy43/l2giPhRA==
X-Received: by 2002:a05:6808:c28a:b0:450:7a38:cabd with SMTP id
 5614622812f47-457b20b7725mr1724058b6e.25.1766157124601; 
 Fri, 19 Dec 2025 07:12:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3ba4221sm1210383b6e.3.2025.12.19.07.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 07:12:04 -0800 (PST)
Date: Fri, 19 Dec 2025 09:12:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Darek <x64x6a@gmail.com>
Subject: Re: [RFC PATCH 0/9] Update lzma to current version of LZMA SDK
Message-ID: <20251219151201.GR303283@bill-the-cat>
References: <20251218232255.3934258-1-trini@konsulko.com>
 <CALeDE9OaXG5FYCBDmDCP6EDw9CSHsic+EDfiSjsAu_BOryk_+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f7RN0QHTGCUHs09B"
Content-Disposition: inline
In-Reply-To: <CALeDE9OaXG5FYCBDmDCP6EDw9CSHsic+EDfiSjsAu_BOryk_+Q@mail.gmail.com>
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


--f7RN0QHTGCUHs09B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 01:51:11AM +0000, Peter Robinson wrote:
> On Thu, 18 Dec 2025 at 23:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > Hey all,
> >
> > A long while ago, Darek reported that our copy of the LZMA SDK library
> > is quite old and so vulnerable to at least one possible security issue
> > he found that was fixed upstream.
> >
> > This RFC series does a few things. First, we introduce a Kconfig option
> > to enable LZMA's size reduction option, and enable it on
> > gardena-smart-gateway-mt7688. This is not critical at the start, but is
> > as we move forward. Next, we remove some files from our initial import
> > of the library that do not make sense to keep in-tree. After that, the
> > next 5 patches update us from the imported version to the current
> > release of 25.01. This is split up such that few have the very few
> > places where the update requires some slight changes to our code be more
> > visible. This in turn is mainly that the file that says the license has
> > changed, and that we need to guard around some unused upstream code that
> > also conflicts with our own code. Finally, we restore the spacing
> > changes that our copy of the code had, and then improve things by adding
> > SPDX tags to the LZMA code so the license is more visible overall.
>=20
> Does it make sense to try and get the SPDX bits back upstream so we
> have less delta the next time we rebase?

Upstream seems to be done very much as a one person as they like it
project. There is an issue tracker. I'll sign up and file a request at
least.

--=20
Tom

--f7RN0QHTGCUHs09B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUVrPgAKCRAr4qD1Cr/k
CmvjAP9KPxye6B5XJu6eocadOLVOPqe5SO9qae+GBiWhOvyn8gD/X+pml8FtyTmQ
d5mCpXPgoVc0uiy1Bp0qPgc6itEQsAY=
=2nL9
-----END PGP SIGNATURE-----

--f7RN0QHTGCUHs09B--
