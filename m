Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF114E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 424EA80303;
	Tue, 17 Dec 2024 20:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="isr9+7DQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCB180315; Tue, 17 Dec 2024 20:53:56 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CAB80214
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6f1b54dc3so846227685a.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734465232; x=1735070032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5LjSdX0VWCLUk3iGeTCfi8+giGZprqI3veONlzPjIYg=;
 b=isr9+7DQXxXjVarHCUJHxYJ2gn/S6EL00DiH/Af6vSmUWzsK/ScPf0qtHpAOYi6Of3
 XTIpdo87lT2uODEzHu5hBPNxVeLphPULIznl/DL1NVfwm2PuOcZacutFYelTFOKtv0uc
 LBDTumGHK4UzjgrmYLjrtBSe9iaPrZVyb9jnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734465232; x=1735070032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LjSdX0VWCLUk3iGeTCfi8+giGZprqI3veONlzPjIYg=;
 b=gyEkl4Cn8MvR8I7b09MVODjq2/VQfswkJ5WizQWG+49SAhJ9v0ClQbz/ORMk8RYtOw
 yDO7ZoRVELkhPbKsE1gL2trWTq/fjTvIq15u2fdtyXwSlxwhyzkIQa4SqaIsnmcV8s8o
 y/Kbmr6NsonO55j99vc+CYZunp1dQ7th030BEP02rs8wUkuMwdWgawnlh9fl0l/PZ5lO
 1biXPh4MqWZnZYeFMl5+J57HxCtkHySP5/DbFW0bPW3Vo3xZReOXbZFzd1aW7G4uYmwO
 +F7/8qbhfYtNikrz3MpxPwmBrKl+IHNC2/wkuFzM1Py6DgMpPiJy55LkoDmTazb0zKLX
 9Lkw==
X-Gm-Message-State: AOJu0YwnLapqYRJ7f07BPdu4AKFyqcu+Hulj+aaJi11NxS3CLGSFEbUc
 oWeXyxh4yqJdVPGpQQ86kR6yJ/DMdFmyWWqurTt58gJnzNojT9uPa5JkQv5zjZ1XqPdHRQ1B5rf
 UOpM=
X-Gm-Gg: ASbGncs1UdAkQB+crkg/Vr1S6OGpf+ZB22a5DhJqsDM6C/QsRWtPrZMBPg43RFfD8aR
 w8Bc8bNiRFbZ6CVrYPH5R0KIK0N50O9Am2JL33WSOwrz78FtHI4Vbt4KTAeImsDClH7gYbacuB3
 djx11ZkOnytHxlETuJ1oQoNh2ng140dq+1yYDCO9q0LPWDUtrkt/p6Dih2BhriYhAgPtQcMvVXK
 b3nB/4aIVjm2xhTo/eAzcn1kY44OcH+AppyK7mVpe/Z1IYYJzQs5VYG
X-Google-Smtp-Source: AGHT+IEb4wAVrdHK4BmvJ2o1I6whn32aiaJweBBT8YrPsSvOWF3o7BjYtkpyV8kpl0R7mLFKIFqrCw==
X-Received: by 2002:a05:620a:454b:b0:79f:67b:4fdc with SMTP id
 af79cd13be357-7b8636ebb10mr7519385a.2.1734465232516; 
 Tue, 17 Dec 2024 11:53:52 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047ea148sm348476685a.53.2024.12.17.11.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 11:53:51 -0800 (PST)
Date: Tue, 17 Dec 2024 13:53:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>
Subject: Re: [PATCH] buildman: Add a way to build a particular target
Message-ID: <20241217195348.GQ1505244@bill-the-cat>
References: <20241217132616.3708573-1-sjg@chromium.org>
 <20241217142016.GK1505244@bill-the-cat>
 <CAFLszTjfxxseCJUvUXPgZQWQYNrL+yT3u8qZ9OieJHxaC=dfDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yEy7ZC7iAeul62Vz"
Content-Disposition: inline
In-Reply-To: <CAFLszTjfxxseCJUvUXPgZQWQYNrL+yT3u8qZ9OieJHxaC=dfDg@mail.gmail.com>
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


--yEy7ZC7iAeul62Vz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:45:29PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 17 Dec 2024 at 07:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 17, 2024 at 06:26:16AM -0700, Simon Glass wrote:
> >
> > > At present buildman only supports building the default target. Genera=
lly
> > > this is what is wanted, but in some cases boards erroneously have a
> > > different target for product extra files.
> > >
> > > Add a --target option to help. Also add a comment indicating which
> > > letters are free for new options.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > How do you use this? It would be nice to be able to do "--target
> > u-boot-initial-env" for example for converting and verifying the
> > conversion of boards to plain text environment. Except the list of
> > artifacts that are kept isn't updated with that string as well. And
> > FWIW, is this for a case not solved by CONFIG_BUILD_TARGET?
>=20
> It's related to the problem where colibri-imx8 doesn't actually build
> an image with the default boot target.

I don't recall if there's a good reason for imx8 not setting
CONFIG_BUILD_TARGET to something, but that sounds like how to solve this
problem. "make all" should work, normally.

> But yes, we could add more things to buildman, e.g. it could output
> the initial env as a file for later parsing.

Well, your patch supports that, if I read it right. It just doesn't save it.

--=20
Tom

--yEy7ZC7iAeul62Vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdh1skACgkQFHw5/5Y0
tyynPgwArHdLGVV0OxnETojK7G8kgXPXns5rkpWE+AycYIZqBixeMPups93ANio9
TjxE394IoL5tEvi7VrSEymbpoeUfV1LnEOjRb6aWT37PB7urzyA0Nb8F6QhFt9/B
0zVCJkVxNjA9jJigA1DIHGdAOrlXivgVHgQrIpqDPGB55XMNhi70AiTn0mX+XRsy
fH5CE8FEoHJkZjr5HCZEi50ZlQ5KKZ2Vde1EHgENyLw1th/jf0T+QVkLQeyGTX48
qGGrz9/dQmlFxWN1TJ1h6xt69TyggKg9jWObzlxjECZ4o0qkk7sN8wZNjHU6Crsf
wGDmFr34PG+cBr7eMGHgXHsd8LAIX4GvKQ3xj6Qqhm/Dezcf7Fy/qxRsaDAWMH1z
HzdyaHvdzUHkzabxNSwGNwhxDKt15l6bxCFMkdUPC6Qf2iNwYtWRQFual8g6vHuI
zXzPPR6OYHkj21KkB+AZlkNw/9b/R7BnCmrF7rueXOcqWvZZRRosLLZCG7TpI9+C
I/gpKZKa
=o9ur
-----END PGP SIGNATURE-----

--yEy7ZC7iAeul62Vz--
