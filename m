Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74419C54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99DE087F50;
	Thu, 14 Mar 2024 01:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V8AKORke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3801D87F50; Thu, 14 Mar 2024 01:40:33 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D22D87F43
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-783045e88a6so29720585a.0
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376829; x=1710981629; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QNBFNLB6zTaD16kjswU06M1lbLRjm0axAZ5hSf2e36Q=;
 b=V8AKORkec4mUthDrr70S2cTHN9iwc97fFlNteNq4BvG26yKm+NSQzVoinCvouq1Q9X
 ly5VVJCq/b7yjTMexUMmzqrvABo3P8HqIo0b7VLKeGstLWMcxzThpkHLL2AmjxWvTLAh
 eNfcF3XAd3ty9wtxiVpghofJhweGtogjhVW7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376829; x=1710981629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNBFNLB6zTaD16kjswU06M1lbLRjm0axAZ5hSf2e36Q=;
 b=LgY1TPCzJPFkeF5q+HBooz4MiWkxbPtT/ojcmySJ7jQ24PfYx3RBU3JTK+5b0QMMmm
 EJkhpPNfIyFfHIeRrrcHD6Cc/MXABQrwrqeZ34WNds8db3tNl2kdiugeMqE/fhW9lnnm
 FYC9av3cS8N+ZxDFBx/Q30cgWU76HDthmbKyrMN2obAZ/DX7aK8PKbEvWR0040/+19bo
 Hcjul4Joru4fN8WA3nxr8MNVYKqsYVfBdHgHlw6vMSWBdJeziegh1PgCVPop33+zQ3xV
 vpwTbzZLsVxoQtFw2xx3jbHxwqmtwchA8+LxxHrQCFAgMJLyUvCNvrKcGV+4VfXq6wHE
 QViw==
X-Gm-Message-State: AOJu0YwBGLS52b9i7TplLX3OuWAb3xe/kiKMp1q1WdU6LYmRJVhcASwi
 LpgcV9gbCNASoDRI7FfLUTOI9mgRpNUg2r9Xo/jimwiOLRVCmshO0spnPfm1J20dUqvSeISkQqF
 q
X-Google-Smtp-Source: AGHT+IE/psPCKwsfHidYT4ERE4CnHC7v6OoJ7XGVFacHfIF+FeZMx+a4/RH5DMaqsH93ZbWUMQtFdQ==
X-Received: by 2002:a05:620a:24c7:b0:789:cf1f:126 with SMTP id
 m7-20020a05620a24c700b00789cf1f0126mr555126qkn.8.1710376829546; 
 Wed, 13 Mar 2024 17:40:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 dy4-20020a05620a60c400b00787fd080d28sm164548qkb.74.2024.03.13.17.40.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:40:29 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:40:27 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] stv0991: Remove stv0991 board and architecture code
Message-ID: <20240314004027.GP3442575@bill-the-cat>
References: <20240308193813.359949-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+0FZnHX3XA9jmCI1"
Content-Disposition: inline
In-Reply-To: <20240308193813.359949-1-trini@konsulko.com>
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


--+0FZnHX3XA9jmCI1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 02:38:13PM -0500, Tom Rini wrote:

> This architecture and related board are unmaintained currently and have
> been for a long time. Remove them.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--+0FZnHX3XA9jmCI1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR3sACgkQFHw5/5Y0
tywrXgv/dk1V9yHfDp/MKERaCIcoxt/c7jiTE0yfomnvalRZoUciD1xy3V6xbRjU
Qb+oUSKzKMNLXrQvSDaCwqGOHVUp06UApyIJw98Tne8n5CnGsNAfFNHK4h7lhegy
biua1pVtw7qYIOaU+swZoDOhOO63iQ+1lhc5cQWwk91LlEZoKOcW812DQ5nhciNB
2LM1DDKVDAbL8xOVNb4dEsHoddZgZBiW6x2GSbcicp5dbbj2XzR6Vem1IeT4NuBG
dKnhZuR4Jz4WxrZzXg48pUO1EgQLvh1nKzUlmdtXhEwSj08snjM4/Te1inDV4byb
sDdbUiRIeEiA7u7fRjKTph+xPnBkHxs1b+uQxv9GU/ocJWuwOJcLs+cdzZLoZ7UN
WFYeZ4dcbr3Sd8G8pkRhNGK4dOqpEAvJjk/lDZb+0VsBmtsT6dHDJ2pHn5o8nzlz
glKw7bSLkuCtGQr2AuwAJ8wlEOE/Ivtgb6rUpHLjY8PxXHwRHkEwyjbagY4A2cBG
8p0Aooua
=HsZS
-----END PGP SIGNATURE-----

--+0FZnHX3XA9jmCI1--
