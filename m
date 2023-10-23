Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE6BCDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 13:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B37D8790E;
	Mon, 23 Oct 2023 15:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LykVkA9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6908987914; Mon, 23 Oct 2023 15:40:19 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0264D87853
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a82f176860so32762367b3.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698068414; x=1698673214; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JR4r5S8QNNaKf5pBlj9OglMgoFuLH8mTgeVd4QYVrR4=;
 b=LykVkA9OGzrsH5+NT9JNvFRlQFdIZ6JlruGsE+zvjB4doplPrT51oigTXMps1F7sHR
 DlxKmC3LikY7ermjtkLhBU4hmkWqO32Wr6CmlcfFFMqxVbIk6XAzABGIwvleNgoFrnYU
 pGgzwNEDqbXK+4C+mDew8zsO2rhljufpdrGHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698068414; x=1698673214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JR4r5S8QNNaKf5pBlj9OglMgoFuLH8mTgeVd4QYVrR4=;
 b=ZkyOUvM92DPwh/EvN2H9uGfs9yAZefUP2nEyRPrPTf+YUwoXONLAuo1aD400/CUcvp
 g+u1z+XYpqJ7XKLVkkJMrZ/Helfd6y6I3vsscREM4aRU6ND4QPqY6kaAmBSKF1BlGmN7
 wd36IJMdCwAZXTjvXAg3OU3dpNiQ0SURaoy/pTkZBOrzBACgykb+fzqcYTbehO4L7gwh
 TKelEj4cefkAnVEwEbwwI7z1Uiuy/IkvapnTBFS7Qprs/U06M9gX4E9/VQuXjke7x7ia
 vnQkVGPWSjksxvZdpqSqaGB2NfBgbMoFHIkvnLZ8272RMqAPvFpFcjq2Zooyq4ehKA/p
 E21g==
X-Gm-Message-State: AOJu0YwQ+eHK4zqPDapk0FY6+VpZ5zJMUJOtUKKWoZJtlBQtRe375+um
 KELlG/DLAx9CiXmY8r5yekOFKQ==
X-Google-Smtp-Source: AGHT+IG8e3Rf5HtuFowA8+mLA7Ts1sk1qh/+kgl0Tm0+8NCS9k9i11cpNaBdZFZNDNTTme6lC8634Q==
X-Received: by 2002:a81:4814:0:b0:5a8:e303:1db2 with SMTP id
 v20-20020a814814000000b005a8e3031db2mr9736153ywa.23.1698068414658; 
 Mon, 23 Oct 2023 06:40:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 u131-20020a0deb89000000b005a7d46770f2sm3147028ywe.83.2023.10.23.06.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 06:40:14 -0700 (PDT)
Date: Mon, 23 Oct 2023 09:40:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] buildman: Include symbols in the read-only data section
Message-ID: <20231023134012.GI496310@bill-the-cat>
References: <20231023005242.1.I573d6fb6587a8fbba2ae3783a42c4587ed6572d4@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JwOi5EUUMCkkEnre"
Content-Disposition: inline
In-Reply-To: <20231023005242.1.I573d6fb6587a8fbba2ae3783a42c4587ed6572d4@changeid>
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


--JwOi5EUUMCkkEnre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:52:43AM -0700, Simon Glass wrote:

> When symbols switch between the inited data section and the read-only
> data section their visbility changes, at present, with the -B option.
>=20
> This is confusing, since adding 'const' to a variable declaration can
> make it look like a significant improvement in bloat. But in fact
> nothing has changed.
>=20
> Add 'r' to the list of symbols types that are recorded, to correct this
> problem. Add a constant to make it easier to find this code next time.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Thanks for fixing this.

Reported-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Link: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/6

--=20
Tom

--JwOi5EUUMCkkEnre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2d7wACgkQFHw5/5Y0
tyyUfAv/Z/sj9LV5GPKJ4vO/9P0KATwdgfvIGX/e96LeC8WpV8qaxwyydW3emfkG
4um8v4XOmU7LUbDzBfLvEOq4ZxTRmLqHz/8Fn/WvvpgVjZB2aNxh3kPzA08NL52P
neG2E8mOZMY3HCOWHiJjtj4QzOIWFQ7R5BRIX+5gXPpR++GFPXPwXDCQO9MbVQ6V
UlwCq6W80sm2mke76h++crNex+Po7Ksi8IWXSpWqq5bm5EHPR3G2lTZFtEX9ZRO8
oI+19qIoBIXZGEcrCLadASxzAeYW6bq8x5lksmndvfAdW2kUrhSNmyNCC5XHWiuO
4cRc9xlyYeppC/qbZnHmksDDORHAc1LiqfN3o5DMnbfXsRu4CLYW2OLxE1HVKq3L
4a7MU+pMObT2dFTm3weVvNlwLXYdg6opYA+2SRJkqLwXkn9ddF7LL+O8I3Q/uhyg
RhMNhdWZlNSKuN/2DYD398BiK4T1/HxphEsXtHUi3PT5wjigYLFDoEpnEXs1VSzS
yp13wDbQ
=vsTN
-----END PGP SIGNATURE-----

--JwOi5EUUMCkkEnre--
