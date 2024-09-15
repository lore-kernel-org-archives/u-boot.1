Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9662AC3ABA0
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 18:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00A9788E0A;
	Sun, 15 Sep 2024 20:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jPPqvlO0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2BEC88E26; Sun, 15 Sep 2024 20:19:36 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C493388E04
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 20:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7a99fd4ea26so344637785a.1
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726424373; x=1727029173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8dWc8f5kUkSFN6a43x8gxB8qjCWOiGubLmMuCj6VltE=;
 b=jPPqvlO0PEkrjICWt1JzaY1Vr+eQ+VAfdIYBK4YZtk0x8YsPzFq4d6irbUqCeZtlo1
 LR8e2LGqNcP9oRBobv4C9C1ixFL5FjZSy5gf51MA8xmKqC9wLcBJA4BtgOMelZA7F/u3
 EExgnpbb3pCSuByrSQIsc7tN596HTupKlC4UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726424373; x=1727029173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dWc8f5kUkSFN6a43x8gxB8qjCWOiGubLmMuCj6VltE=;
 b=JF9SlnKO5k4sm2W9GVQJbONZI6ptvRUeO6lW/7pWJ5bhLocicoiCwRSGG9C1kgeUUW
 mhr7T4KaGECYWAPR2kc5gZy3warQjANw+9XSs8rLHADbfW+gctaMpeJjeH3b0zo6L2Id
 TdoKywPGNXLUGh0IZWGupiA00vhUmc9vb7TabTRhCzQCAuqpS/91kkEgB1iZ/pSevsCK
 XU+2/GhocNBBVa00mnULxWPJMctF4QVIXgK4KJM9i9+8EvtFraNau+cM+Gzm23RwsXq+
 8THufm/enjxGiJAAbBwjIz3NPjBdZpO4NIe4CrfWorQNG7zgJ8JEOyTaCm3FEXLo4/6O
 pTAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX007TthxjDfYusNMXFM8/W6V4y6A1/F3qLz4tNmfm6n1ZAHy8l+jr4diwE4TOJnaIvu8Ms514=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb8AY7LugFH/y/r9sCevq/nVvqQ9ndvS041zxJlTCACgxljyw9
 QblC+doRkElJg93gX8wCGFqI1/iJ6IJeouZd1xgEIDyC7A4QCQK8wtKVgnZuGII=
X-Google-Smtp-Source: AGHT+IFohJQDWH2kSHVDDhNR5squ1lzbXBUzN9C8kZvyswX1QiCAYnMy/4ZV3oE57eEiY8H1tXG1zA==
X-Received: by 2002:a05:620a:1a23:b0:7a3:7889:4af0 with SMTP id
 af79cd13be357-7a9e5f1d8c3mr2114607085a.28.1726424373377; 
 Sun, 15 Sep 2024 11:19:33 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3eb62d72sm178022385a.107.2024.09.15.11.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 11:19:32 -0700 (PDT)
Date: Sun, 15 Sep 2024 12:19:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc/develop/sending_patches.rst: Clarify when to use
 which branch
Message-ID: <20240915181929.GA4252@bill-the-cat>
References: <20240826163917.2786791-1-trini@konsulko.com>
 <4b1be536-86d8-4a43-9060-35e8c989e258@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="do2vHd8xhnxsG7la"
Content-Disposition: inline
In-Reply-To: <4b1be536-86d8-4a43-9060-35e8c989e258@gmx.de>
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


--do2vHd8xhnxsG7la
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 07:00:08PM +0200, Heinrich Schuchardt wrote:
> On 8/26/24 18:39, Tom Rini wrote:
> > The previous wording on the paragraph about what branch to use when
> > submitting patches did not reflect how / when the next branch is
> > currently used. Reword this to note that master should be used for bug
> > and regression fixes, always, and that next should be used once it
> > opens, with -rc2.
> >=20
> > Reported-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Hello Tom,
>=20
> I missed that patch in my recent documentation pull-request.
>=20
> Maybe you just want to add it to master with whatever comes next.
>=20
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Will do, thanks.

--=20
Tom

--do2vHd8xhnxsG7la
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbnJS4ACgkQFHw5/5Y0
tyzvfQwAggizDyH+GZ3LKeVVGdkUWeJG5OXYPg2P4lLwTCdAIcquZN+uTNnaGP44
Tsms1oa4MIHVUp5YZsLwUs+oNZ697sWI04J97hftSZ42LTBRCfcpmgazQcWghHEk
g0aHF+okPCA1BJvJs38FnGgZIFVX1+Mp/Aq4E84t7W6RiutGIuRGCRy67EYfF3Gc
1bajEkYPL8Pmq/xkiapUNpEQqquyEea+9DekXA2JWm/9aoPvgJDt6RFNs3SXu5hd
HxeHBQwuDkr5mNkFESwJ/jX9NT1PMsBxEa/tNxTSbHegllAvR2WDa8+tDzNb1oOr
0cj44aeuJOeuSJNQPwpqmSFDy5KuYs1D9uLuu03aIbaIFVIxa3FszcEZilrlfbat
uW9x1meOMZ5YAI2vOST1of6rbekqNuEFwTlPlRv9NFdNf7wxNCScZvZqZx/piZsY
SR0QxM1f+YPi2a7GkEa1nLD/hC3uxCqAwYJVNuTKTfPyBC6AyRCDcqjJxFa91oUE
FyQq6EXG
=SXtI
-----END PGP SIGNATURE-----

--do2vHd8xhnxsG7la--
