Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D99D3A672
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 16:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BBCD8919B;
	Tue, 29 Oct 2024 17:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XnnpKycl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78CDF8857C; Tue, 29 Oct 2024 17:37:36 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57FBF88E81
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5ebbed44918so3761673eaf.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730219853; x=1730824653; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OUoT6GaYz5UtphrE1ldDvmkAH7/jhsC8fmAqdLYtm1M=;
 b=XnnpKycl6EOjOFwhxpR5Jaxe7+2hL7u+1unkk3UJe3MeiSyLpygbFtmcdEt46sCW3K
 uMMOyKsMg9aaP+l9PphjCkqSOKEUdlIXDfIe2R90CJ4gzOi4gzsTFaqoZIEEfqeU34Jx
 t1cJ7ltD02ZaIMSFLbMP+PXMyD+BymZJmXzgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730219853; x=1730824653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUoT6GaYz5UtphrE1ldDvmkAH7/jhsC8fmAqdLYtm1M=;
 b=PrZOZam4nZLbPK76U/xMj4/Gx5g6NBQdjg8qydyvfatZFH6ljZ32N6jTT3ca+McJWC
 iSohnSCpfNr85q2qKKZNNXXjdeEQXvUhCbHe6l1W7Y3IabmbZFsVLAxWpWaaW+TWttme
 aSCWhtatpmz7BdNZO2Z9CJTSq+JsA0uRxLpcJ3glMET4YglSE95U9AC17KzJebLC+Nl9
 QB2kfcuwbaKqT8rF0TXMKBqPn6T9cnm4WmcxMsBkqrsFQj/dj01tibjvs3LnKdczJV3f
 IAUWlbWOeQUTjb7db0e60/hgQwQKcZM+7pRvxXbTEh5fGdnqOS2UBUIYJXD/oxhVDvD/
 YoLQ==
X-Gm-Message-State: AOJu0YyMvYPr4JFwYotcaCzCVxQxZ2mXGQeH60h/XnFeicTZpu+onO/E
 WrHPJtx2DJaz7LCGlm0bTDCU1+Hnnfsjoh39lnNRyj7lT7qkTiLtRxElOM/HPhweJd8R/vGrKda
 wNUw=
X-Google-Smtp-Source: AGHT+IH+AksnQ9osWrZV6lWK38DhYv2femnZw7KJWdUdyQq9i7/VDqmPJLSPb48ob2740UaC4U9fMg==
X-Received: by 2002:a05:6358:718e:b0:1c3:82f3:883e with SMTP id
 e5c5f4694b2df-1c5e344c168mr47182455d.21.1730219851579; 
 Tue, 29 Oct 2024 09:37:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4613213a5fdsm46045081cf.31.2024.10.29.09.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:37:30 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:37:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
Cc: u-boot@lists.denx.de, Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH 2/4] board/BuR/common: add parameter for reset controller
 I2C bus selection
Message-ID: <20241029163728.GD4959@bill-the-cat>
References: <20241029085258.1740289-1-bernhard.messerklinger@br-automation.com>
 <20241029085258.1740289-3-bernhard.messerklinger@br-automation.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wN2m0uOfbdT3L/QP"
Content-Disposition: inline
In-Reply-To: <20241029085258.1740289-3-bernhard.messerklinger@br-automation.com>
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


--wN2m0uOfbdT3L/QP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 09:52:10AM +0100, Bernhard Messerklinger wrote:

> Normally B&R reset controllers are located at I2C bus 0. This patch adds
> the possibility to change this bus number with BR_RESETC_I2CBUS.
>=20
> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automati=
on.com>
> ---
>=20
>  board/BuR/common/br_resetc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/board/BuR/common/br_resetc.c b/board/BuR/common/br_resetc.c
> index f5d09fef3d..827ea6ba35 100644
> --- a/board/BuR/common/br_resetc.c
> +++ b/board/BuR/common/br_resetc.c
> @@ -52,10 +52,15 @@ static int resetc_init(void)
>  {
>  	struct udevice *i2cbus;
>  	int rc;
> +#if !defined(BR_RESETC_I2CBUS)
> +	int busno =3D 0;
> +#else
> +	int busno =3D CONFIG_BR_RESETC_I2CBUS;
> +#endif

You need to introduce board/BuR/common/Kconfig and add the symbol
BR_RESETC_I2CBUS there.

--=20
Tom

--wN2m0uOfbdT3L/QP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchD0gACgkQFHw5/5Y0
tyzm2Av/TDGKBGpc8GrOp/50vjT95rOQy+TLonjRMfhIhG5WZRQaKtPD1lU3Wb8G
DaMVbustWltRo3D20vORhEHqkTGLf2/e2+80MSdxo0DWnxlGyiKQMee7s/ETgiEe
aTpA+4BwOk+IznQH13PW0nFqxMchN9BfmyuZBtxTLnKkR4KRZ9W3GFM1le4pW4Ki
L0A9IgcMMTNr1O+5c79oZbK3C2BqSkVnOnEQXtpOU7xQUWkK7fdLpYICerl8zGYp
IgXBASsrgnrk5dnpoYJxsg7QyxtKj2soiDWLidoFTqCjN34CJeFQhvYybENvBI3E
thWUA0yiJ640YwA4f15zEsP0JK4LF/+vXToGCDatPmrfxVDRjHwqLdiALlfEHVX3
5pz6YZqciZqwZiwp1r6gsOZw2LSD7uWJQhsRZ7tzMRcUCdDI4p2HKo5GEk3Ufazw
A0BEOQ4PR57AJDtQ1P5MwdY6bLh+pqWASYvB9siHwFyqOWhUHhx3o99ysXhuIj8z
WEBg0rYD
=jsEt
-----END PGP SIGNATURE-----

--wN2m0uOfbdT3L/QP--
