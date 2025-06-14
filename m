Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901ECC71150
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 14:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB0382C79;
	Sat, 14 Jun 2025 16:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="umkGrZgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4776A82C44; Sat, 14 Jun 2025 16:05:09 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE2482C44
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 16:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2da73155e91so1179592fac.0
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749909905; x=1750514705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q14COOWYqwpZzEt7HPJQy5FE8sKZZpVwJaEBRDkhNqY=;
 b=umkGrZgMceELnY12NR/ha/Zf2mIGtLwwl4MrSsY3cdXJAH20yF0aUsRCCUkADXXpEW
 bU5tCwk1qwZHTXToFcRG+WGE2col0mX9WCtdOD/mGjhpGXsEJi5ANIicOjvJa0+XDhbL
 GKn2YNAu0ftiogAETO7SSGIHvwlVzLH1i6mr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749909905; x=1750514705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q14COOWYqwpZzEt7HPJQy5FE8sKZZpVwJaEBRDkhNqY=;
 b=YOm3XVYiiVxoTW2Vbpxv18qH945dOFoVeETrJ/tBZCRiEcea7jo4U640Vf9O/RvmOu
 Y5P7te6KQJLg2WdqsrVSV9Ve3Kv5PrXxccsOV1fZOXpfLdJtq3eicJVVR44ELDA3d4fD
 ekWth0VVqDVylu9XJl1gb+sE0QQC81zpwjVgrexQ5cl6YO9dU0d4oco8vweqMaY3VBk5
 SpMYD7jgDXYjKI8dIU+p596vlfdixp1V++lz7eDR67bmmMYOI5I7cRBnGqIYA1KVsrx3
 QzacPIERWFzliIDTY28AQdUCtzXHSysCzRByyPkO4komiy4E/HQ/WIUyl5NqbPZRa7O1
 skGQ==
X-Gm-Message-State: AOJu0YwgTpsG+b8kBxJ0tpDrW+AwBmuTCq2U2Hnpe5mxIV+4MD5OKhJt
 LBHtt0+BrIulMvx6Yjv2eWjIFOnTpguqwqhA1sQiaKDZrJNOh3c0SB5X0au0YvH/O+JM6hhsKz2
 5NfVbZY2MEw==
X-Gm-Gg: ASbGncsz8JgoXwmAM09KZXPRYTFWGYhD2kNJLevy9AUi9Tc0NyMQef5YlJdc1TVJ/v6
 OeCSKMlwnW0jemmXGnJ0+GgRLAIXl73bCEVcpv7ECqwABOvWkzfA7eAbfMOz023vIMNFdMSHW8h
 28dihyjT1BZIl5hFQ0yvNETbfbWlGWhokoUUIq6fmIa8g5amNaMoMYEEqJOMu/Wi8J17iy84REI
 X5RFSG50CqEror6fD5T/yZ8ud/YsTlS6givByV4oQ4Be2WJ/JlthCiVgV3KsLNf2BIGarXW0YaV
 lfFkI0tKT+gFi9gj7YmIN+/cjusbUtiSnkvj0F1dh0MfYSCvRyf6yv4blTO2WmTLCJZoFYsJ5ng
 ediAwYB6nbGdt0yEDWodGM2M=
X-Google-Smtp-Source: AGHT+IGSg3Yg0gwpTySsjXyTaknC5ZxHITzgusKELpLKtQvyxc4ZB3GLCeKvjAeUv7v7Cv77jPiTBQ==
X-Received: by 2002:a05:6871:4318:b0:2e9:6a0:80d1 with SMTP id
 586e51a60fabf-2eaf0aaabbdmr2062283fac.19.1749909905587; 
 Sat, 14 Jun 2025 07:05:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a28554581sm571184a34.61.2025.06.14.07.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Jun 2025 07:05:04 -0700 (PDT)
Date: Sat, 14 Jun 2025 08:05:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, nm@ti.com,
 robertcnelson@gmail.com, ggiordano@phytec.com, wegorov@phytec.de,
 francesco.dolcini@toradex.com, jm@ti.com, n-francis@ti.com,
 bb@ti.com, vitor.soares@toradex.com, contact@paulk.fr,
 Oliver.Gaskell@analog.com, marex@denx.de, jerome.forissier@linaro.org
Subject: Re: [PATCH 2/2] configs: j7*/*am62*: Remove malloc size overwrite at
 config level.
Message-ID: <20250614140501.GF1382132@bill-the-cat>
References: <20250614093717.2479920-1-u-kumar1@ti.com>
 <20250614093717.2479920-3-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BaEVJCijwldb4XVb"
Content-Disposition: inline
In-Reply-To: <20250614093717.2479920-3-u-kumar1@ti.com>
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


--BaEVJCijwldb4XVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 03:07:17PM +0530, Udit Kumar wrote:

> Use default value of malloc size coming from Kconfig, instead of
> board specific override.
>=20
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--BaEVJCijwldb4XVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhNgY0ACgkQFHw5/5Y0
tyxhkgwAqPQtRH2nUx9U7Vf87NP/B5nxWfWR8+w12FploKo57lHMHBgBK7T5/eGP
JgB2rVNpz3m37z6hxOr8FDfAM6G5N2jyW1iTYqQ4Mas3gK+Ed3lMor+9rfdTrrAB
4BtNbFn1LCaraBPcarQvRXnERCQ3O1nFxn9BT4MnUkklq+ycixxhk//jo0slEaZN
4Za51VBIZxsN7qTy0tdGoZPNOFjue8zFvbAM1RoVYhHzQYrNGdQWTmLUvjjqp9j0
XkJ4v49pB0rOXdXPXUBm7yBGCmfpteyKBz8veBFjqzrwRpDG5BMFxyV1gz/VJnPS
V6q2fgy+2dRw6Em9ae4V8u+AhX12+El2clXZOoziZAfzZZqzQEricvuzT519EnSi
dEl1SIFBbFN96gWxEZs0l9xSIyVVDjVZISMEJG3WvcxEIr09gt9YNBk5eSz4eyIA
7mno+oPBG4XgGnCRPjAzgv98Vur42F1JxbYuqoPclHP0qgnTVgwFGlECvvkRxC2f
skbt6zh/
=EbfK
-----END PGP SIGNATURE-----

--BaEVJCijwldb4XVb--
