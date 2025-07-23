Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463BBC83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 23:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB41D835B6;
	Thu, 24 Jul 2025 01:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hAdc8BvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B9D835C1; Thu, 24 Jul 2025 01:20:32 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8978A835B0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ffa8e58654so267238fac.3
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753312829; x=1753917629; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oQAmZR4ZHuhprmH+QZQ2mxOHbHHmgvOxJPEm3EIf1Kk=;
 b=hAdc8BvNa+jAz5BgwNGwn3Y1xmCugZkmV7Om/ckF4Y+obmWv3xge8ClURvUgNoxdO7
 kAYdu0IuzjLrbKWpI6qaTdPJu9Smue1H+wFvyP2N9VzoYh0T/Q08cmvN2IpfouJLg3Nl
 l/Wp5Wr4LgKR3A3hkYRLzd2utuCltKgATVqoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753312829; x=1753917629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQAmZR4ZHuhprmH+QZQ2mxOHbHHmgvOxJPEm3EIf1Kk=;
 b=WYX3HHneggnOH8K4BNkfbsT0+RbqrY9lNq90g07+DJgp1ydOm8GNfU5hNn9ZEoFebH
 vmrUlM1T27RtyywVm8mIbE8Cen5JMnTZs4QPD0Zk7ESA8IQ0gnqKgycD9u5LpbcFd11M
 cbX+sketwwNnTy5LYk6r1fatmeBnUyvfeYhsVW1b6QHPuYX0V/WrB7wvTHuVXKEvpGo5
 P7eZUhiLx/+Y5+JDy32aOnP0AS1GCX65lGPphZxMtbyBJ92R7RLINE1udHiuRlQuYqyy
 1lXNQ0/jIO5jdN6mLcx1qzHpouRnKlzTeZbLOwQ/h84U3bpNNbf1+bQtZsHGziEAUK7s
 qQAA==
X-Gm-Message-State: AOJu0YzuDqj5dkbWDzR93yFl/e/yF0fJV1Pm6Ha3NNnaeZy6eEC2WrEN
 N8xjQdcgfIXMNtsHrnsJooed1/GSY1C/t7+OrLla2Rl6SSCZvXZJ+i3jP0ba7XeCz3O6dnn81+g
 GXe7dGlQ=
X-Gm-Gg: ASbGncuIUwHjPK/V5pccs9eAX/umQNo4lQZMtV6Z1r/oEpvHpG5bLECckteacekqcXA
 YAS04SLanDAHl4U0xM02hjFqGBesWHtU4Q83K91p1ePklz8M3G0Gr2ZBe3BOFgRoiHNwaQedxKe
 MuCg2zDa8LXu9tPugt/yUiVcGxNgJmpflGgIEDXcrbpHYSazQ76XSKC7Hr6GNoVtlQn2wM4qRbd
 +UW13W+R38eC1I/2Be5Gq0OszMXuC54atAwem2fdV7dpR0kyavZ7yPsi+kkEa4cSeD5Bv8y0P/M
 sj/RAQfb+gCjGwvIrG2CVhh7rFap5dW7xnAFSVH724htKagEjoYzwzTORDcKIhqXIkPjRFle9tw
 b0mTOdSOyOo8Sp4mGIVvAJS8MQF67IIst+c0Z1bpjMXAeGJ7yVKlRwp0g
X-Google-Smtp-Source: AGHT+IFacuJ23laE26T+p2wlC1YEB5520MNVMveb4jZabsEYhOh9c3jg0hyvzprYJDaHfZbJjm98qg==
X-Received: by 2002:a05:6871:c703:b0:297:24ad:402f with SMTP id
 586e51a60fabf-306c6f980b5mr3371817fac.12.1753312829093; 
 Wed, 23 Jul 2025 16:20:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1ec01bfsm122163fac.29.2025.07.23.16.20.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 16:20:28 -0700 (PDT)
Date: Wed, 23 Jul 2025 17:20:25 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] Azure: Temporarily switch to GitHub mirror of
 u-boot-test-hooks
Message-ID: <20250723232025.GM2847763@bill-the-cat>
References: <20250723202724.228868-1-trini@konsulko.com>
 <175331216444.248145.5744635768526280815.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5POcWQF79Yhpehi1"
Content-Disposition: inline
In-Reply-To: <175331216444.248145.5744635768526280815.b4-ty@konsulko.com>
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


--5POcWQF79Yhpehi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 05:09:24PM -0600, Tom Rini wrote:

> On Wed, 23 Jul 2025 14:27:24 -0600, Tom Rini wrote:
>=20
> > In order to unblock this CI workflow for the moment, switch to using a
> > mirror of u-boot-test-hooks on GitHub rather than source.denx.de.
> >=20
> >=20
>=20
> Applied to u-boot/master, thanks!
>=20
> [1/1] Azure: Temporarily switch to GitHub mirror of u-boot-test-hooks
>       commit: 71c96a8b2ab0fbaf49e7e3fe0623e5065bb3400a

And wouldn't you know it, pushing this is when I see source.denx.de is
back up. I'll just revert this shortly.

--=20
Tom

--5POcWQF79Yhpehi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIFuNgAKCRAr4qD1Cr/k
CvZyAP9Jias9Yq77GMgztr9E8VyqDZtpJC8bB7JkrjaMNgF0qgD+McIvJCs0nmyG
sMvu0qB2/g2LNOE6wEUGCDS/uB9JFgU=
=s702
-----END PGP SIGNATURE-----

--5POcWQF79Yhpehi1--
