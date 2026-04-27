Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B74FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A36A83693;
	Mon, 27 Apr 2026 21:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FrAWHmaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 650F88407E; Mon, 27 Apr 2026 21:57:47 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD38805D7
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so4358649a34.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777319864; x=1777924664; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2ds0+OQl1WvYU3et0yjHgxSHceIEHuaUc7riBfsnCiU=;
 b=FrAWHmaXAyl8Em8yklcVvVDCimaPZUpCUY+8mclmtjO5IWdfhTa6yyfviHOday2+kr
 k2JZdLA1w/i6rDkLC4Ijl0vu5nZmBsb6WxSeMkoP2qJYTmbsucb+eY4T+xXxiuVbvf3m
 wNGetzNSPp26X52RWHWdz23N8uJdUl0brcP3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777319864; x=1777924664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ds0+OQl1WvYU3et0yjHgxSHceIEHuaUc7riBfsnCiU=;
 b=bq6s1BVqOeN+rq4A1HKtCgNJ2rU0kfIV7g5RXEHaQ+qL87aEikn15UcOmFJhUqr3CS
 d6uZnM93JzhbSrYl+OnqVvGkzB8OO7+m8XjhCljeSUgRBvXXGkoH2Jd/3kneZweMBwYz
 sVdadTfNAyGQqqe96DtXsu8BvGm54OZq/Y2YfXmguROTyFuqHPV3UVhbrWnaM2jyLrWp
 5+4eUJCmg/6Gk/QBfikY5PKx6l6GAN7dtVg6H7Y8a4SFiOdfs8mGGkjRVbY38keyhIFy
 YsVUEF7Q2PH79DNfAukqygfgvnEr2F6hZdAWVDeIJgzhwgkQXl4nEELtLbVLXTXIHLel
 tO2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Dt/K2F2zxVXlB+gpTLdF5wXhNywxu9U6ZqPGfHBiiR/qDz40lw4zmIFBp0Oh9drUgoVG2xME=@lists.denx.de
X-Gm-Message-State: AOJu0Yx++BiDxWzd8Nj4WoUvDZb4eLEZUt0+WpAFOFMH8huoG9N5U5JT
 tphzKtk8aik9pzXRpRRcKqVVm2xIK8CVglE9q5GaNK4hEREyZhz6vsRJ7SZyH01ZajY=
X-Gm-Gg: AeBDieup7GjB8w25Hf1SQIUK4cUEm9lcfOcXZhvdlJtPLmid8RO4rEeHty9XrshyFn2
 ZJ0oc+eOZp+vwizErrvrqkt39HaiNeil96BnfnFTzGKHxyQDfZ29VvZFoj4+HFDnoBxUeJTGJSl
 j+Rjgss/EFEuoeqhrgmKmI53uP7AnCMIHZmwwtNOQ5ejHWDN1BaC6KXnwdo9glEo7zwyHHjAk3H
 /GqRo8qrngXvbc3I3SpoVi4CZFSGTJLZfuorG1FABw37m48VQBEnRTcrNqniC8AiuULqnQB0+ZJ
 utCar2ypILMo8tA2T7MlpDG4VDc0XxHveJWYiA3bqXGwXc6rwB2RWvHD7bjD5SNQK5uOJxf+/j6
 N67RA6qYGOFauZq/RUpn99oW93b6UbjadFKYdn/tzstUVt1/MIFL7t4PdAZcoMiydf31/I4g+S5
 G7nRnJ4TuyH8r7WB2TxQLhZnYpf0rVEZC01pj5cj840/8gp1kspCdjF50mOWAa40L1VuJ/24bjx
 uiAZKx9CgeSMTwPJyER6yLjXUjGIbAW1oqyGr3zN/qk3TNPH8HXO8A3i7IM5Q==
X-Received: by 2002:a05:6830:6618:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7de99f808acmr105565a34.2.1777319864038; 
 Mon, 27 Apr 2026 12:57:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de9871ceeasm285030a34.27.2026.04.27.12.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:57:43 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:57:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, bb@ti.com, anshuld@ti.com, hnagalla@ti.com, jm@ti.com,
 nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 08/11] tools: binman: Add a test for boot and load
 extensions
Message-ID: <20260427195741.GO41863@bill-the-cat>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-9-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YkhZ+EMl83gSBp06"
Content-Disposition: inline
In-Reply-To: <20260425033742.1519298-9-b-padhi@ti.com>
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


--YkhZ+EMl83gSBp06
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 09:07:39AM +0530, Beleswar Padhi wrote:

> Add test coverage for the boot and load extension functionality in
> ti-secure certificates. This verifies that a certificate can be
> generated having boot and load extensions.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Oh tests are here. This should be folded in please, thanks.

--=20
Tom

--YkhZ+EMl83gSBp06
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCae+/tQAKCRAr4qD1Cr/k
CiLgAQCosEWRx9VgdUCR7EhFLXl2o97Ce7nYYFyJSTrsFgOjtwD/XbSUcIWn2C9M
51bsQd+svkbXth7l9LO53hpjEeoklwM=
=8JZV
-----END PGP SIGNATURE-----

--YkhZ+EMl83gSBp06--
