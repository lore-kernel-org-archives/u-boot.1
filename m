Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949C3C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 23:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDAA782B0F;
	Wed, 18 Jun 2025 01:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PoQUBC4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F01782B18; Wed, 18 Jun 2025 01:10:53 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7846A82977
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 01:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2da73158006so5009202fac.0
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 16:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750201850; x=1750806650; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3IgBJev3q12BF5nj0NSHHJ1oMp6fdT8brBCaQz3c0Fk=;
 b=PoQUBC4iVk3jjNighpNvq88mVxx7mv87H67hAJyx+uclf3+FTlwHwKwQar7d9JUp0O
 odSRED04zbWg8I5RMLGb76L7zoJBrAKcsOjiKnGFm+WjxfCbfdKeCnYMLl3rPyP8M7+s
 1mK7dOsF10DgwCvds8WVkgbnzV0BqxPg04onM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750201850; x=1750806650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IgBJev3q12BF5nj0NSHHJ1oMp6fdT8brBCaQz3c0Fk=;
 b=DNG9PRn6zZ7a1Y7NMGpZL74EEIEKoGrAO4zYIhsFEBd9rMtBWhxfLCS3k5Nd+TmhZM
 kfzpAnWht9N+aZu8mQIaacmIjyHK87IcuKisWTWE5yYwNC28XIU4UdGPvEvaUKajky/X
 W8zkoA2Zp+2DYrzAcAlLE5mo8ZBMGzE73yRbpSzJDNnFD5CvqIXbyyHZTU7DEL4FDj3x
 kp9IMoiYzWt/GhmHG0PvdIB53HsHiVK32OGfLxRpJQMbQqcp84FrbGmzvGk94J0NPvPj
 RM36mA8Jtr1WnSQnfDHm2SR7Q2b+BlfrlfirAzZfoh7iBd7epyuppJyT1csc88auZz/S
 70ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtnReqMptMOiIExqoI997I6qWVBv0OIfPIozO9jWtGTm/0Q7ZH4GdO7yNSPiPRIbPKdbhvuuo=@lists.denx.de
X-Gm-Message-State: AOJu0YxgfbTZH6KId4SOs3MyAAdUeGEhGiWPg8Mem1PHUsVjcgWuY0vn
 jisojNoRSF4cn+yr1gJtAt1iw3KXVVX0sdMR3xil8qXqA+LfwnBU2w9dD/49F+YD5qA=
X-Gm-Gg: ASbGncsc1OsYXtyC+dv64FrbeFMr9acKk51wIa1X9IUXppCwi/okGhPrQtx2my+Z+FX
 O6hDDhi4RFVCvHIEIWbCR87p0hau7LVaVqA7JOgHxosE+/31qzJnJ5Cy3fU1D88TSX4FZwuMsG5
 g7A9BnixhPyNq2DjXj05fvUNoM/aEjz8drlKLkkM4/UxuXwemwleZU4Vk4kvsrcySkwBH2nv8+g
 GWV22R0SMAqJakqmCEu/B+swgE1GYrMmtHYZNW28RFlcjqXXOuVFONZOt2+9lSPqg41HilEdp7A
 iSCjfySz9MohoI4bBTd+KPtMgxjDoQfWatnCObm3D4ExDM/nmyl0cat+sRsuLsUVkbQQsexFr+7
 516NzS1/qqOPPL2FD4qtJVCo=
X-Google-Smtp-Source: AGHT+IE8cwtTmTuMgCwQfB8PRgN2y5i9HzyAyFQV2dYysL/QI/ePmRbSj65ZRXP0EBoTYBxtKOfBig==
X-Received: by 2002:a05:6870:e8c7:b0:2cc:3523:9cd5 with SMTP id
 586e51a60fabf-2eaf06d6b57mr8182820fac.17.1750201850085; 
 Tue, 17 Jun 2025 16:10:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab88aeb5asm2523627fac.8.2025.06.17.16.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 16:10:48 -0700 (PDT)
Date: Tue, 17 Jun 2025 17:10:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] disable VBE by default
Message-ID: <20250617231046.GQ1382132@bill-the-cat>
References: <20250615093344.159920-1-pbrobinson@gmail.com>
 <DAOLOVHXW7MX.LAIVDE0UN7GN@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kjs0oN0h/w9oVl8t"
Content-Disposition: inline
In-Reply-To: <DAOLOVHXW7MX.LAIVDE0UN7GN@linaro.org>
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


--Kjs0oN0h/w9oVl8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 09:39:25AM +0300, Ilias Apalodimas wrote:

> On Sun Jun 15, 2025 at 12:33 PM EEST, Peter Robinson wrote:
> > The VBE protocol needs explicit device support and as
> > such isn't particularly useful by itself without that,
> > it also adds size and the potential of an attack vector
> > so devices that wish to use this protocol should
> > explicitly opt in to it like all other large features
> > in U-Boot.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>=20
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

This is I think a tad premature. I believe Fedora has been carrying this
patch for some time, and that's the prerogative of that project and so
fine. There is a chicken-and-egg type problem with this feature and if
we aren't going to enable it by default, we then ought not bother
including it and that's not a collection of issues I wish to open at
this time.

--=20
Tom

--Kjs0oN0h/w9oVl8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhR9eoACgkQFHw5/5Y0
tywPIgv/ecRY/kucdwwDwWQkOdsn3GTt8zUjTkHAJZ7WJwO1KSYlGK4MY2yatKcM
Gsn85EjoyMHwme1Ro3e9i69HzwL8d7yTX5VfuAlh1quvMOKE9xPuG3tcabskzGLH
c4cFYtwNywPYL7y0L6HzA54EuCJ0FzSu0vsrTAuGhL1JWAIFIP6/uwY/0NpYs6GQ
wRFjx1ps/r84z0YqXgFHvXGhJn5sth/7AgWKKrli9l74LL9+kOmKC69S9bLDB2eX
M+uXOkNhEv8PwePiXBxx7xaUii/5STUzeiDnkMm+LaE/Mihe8jqlnfBXOrQOzFqH
k9kyBVLDnDJyQLngskcjAjisXzMWkTZEIDqYcOzlmMt9FvsB4ISyDTjGX6vacE5N
Lho4gtAfiOVzxQODN7I2pZG1VM448KPWcH5K5DiPu4HRIdorE7tMjqeTFuYnCdnM
UdIAUrFVYsSSLdin1b0vBQ6oTCzeNG0OTkrYGMGTP3kggULKDsK8ZGzMG4ZrCnUT
lWrNBCkB
=OaOS
-----END PGP SIGNATURE-----

--Kjs0oN0h/w9oVl8t--
