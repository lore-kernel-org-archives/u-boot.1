Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE85C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 19:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B67EE83496;
	Thu, 17 Jul 2025 21:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RUCMMvBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD53483510; Thu, 17 Jul 2025 21:04:16 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5F683390
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 21:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73e65c09828so699622a34.3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752779053; x=1753383853; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PX5sf+Dnh3wUlivCIEu6IyJ8JoJPs1wDC4pjch52uno=;
 b=RUCMMvBbeivS/IH3Z8TAHgVTo7ihIhps4jonpC6mNwNPXA2VbsLGPkRaUufTfLvKlI
 qNhPUAUv+thRGBx1VDZhsS6Y9ijN9YMnam1kaVQWYQ0aEXXxU4qgFhSGVaGEIBhAU6Hq
 I9ZN95IvInVPe8B/G4xwgqmSVqM0/RG8PDSH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752779053; x=1753383853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PX5sf+Dnh3wUlivCIEu6IyJ8JoJPs1wDC4pjch52uno=;
 b=MtkjwvRC+1oMmSqIPKuM+7lpdHswf4f9ukg0zfcuX+qWtao51MLbbA9f//1wZwho3Z
 cce90aGHBKdQNn8+lhvYOBX7MDfn/ERgT3aNx6R+ENTi6eSd/NI6XoMqEJWZAUTtl5pN
 AYz7Wf6VrLlJq4EVH7FM2qRxdY6TgnF5QB1b7HA1CEI0DqvlegLVHJ6khagSLoNzVZ55
 /eSbmRkVkcfBFJZv8CKsqaJmLCWp6Kge2YP2ZPvsHLP7CtyBjF5QxTIKcgOj0BHro4cm
 ESo9zjcB+Ss8zSY/mdjNBpnUzOHBev6+hqy57erBAeXCdvfUv7XFiubqFG2xtiD77vzH
 y2cg==
X-Gm-Message-State: AOJu0Yx29E9G+lA13uOcYQN8MeqtS9x5bUDOzYNZdN97vWoCVcD81quu
 EFgqbvw/5KghJ0o+L1Gq81/n+RP9V9tfhwbVsydXWHexNGQ1+n/v980IxEP3ZFB4OOw=
X-Gm-Gg: ASbGncsZcEc4416FhmpoC5zPwXg65FfsFYspw4LP8d8CALb44tEkW1+SrC46Mvow4Lc
 IpWEyYz0P0vQRG8kyh6PTkOniTvIvd5Ibxr2CgiFR0IXCauPHTGZu9EErQqe9LmMUHOm1w+hdYl
 WqZnePM0nrDVdQQ3L196YvH/a6wcx2YvvTzvYkPgneZCQqseR7/tpWkaD9GnxdxiQxMNRx0s7eO
 lNbieaof0UzitWqicINkuCRVSgsNSfosgmb2rEc1qeSdJwvhijWpA12QXmAeL+GwuGWfgGTrD+V
 2TVHHYFUMPqAXdBCo1pLbk4jqG3eEFbftSrWF4J8LnRuUxzZpzmHHKcNipWFjmdIS6MUNVJiw9d
 JtHJdjQBZZZwz5Wl8qZKLI8PFenU/jU6piyNpbOtEQ89reILUdQEcikZz5NbetEbd/uU=
X-Google-Smtp-Source: AGHT+IEiorMhJ73y2hdzpjx7xEjeQlUDLKt9OUmuywxcajF+/7KGuE06THbtxnpvVG4PTHdE/dG9gA==
X-Received: by 2002:a05:6830:8104:b0:73d:baa3:8326 with SMTP id
 46e09a7af769-73e753435d7mr2347764a34.15.1752779053347; 
 Thu, 17 Jul 2025 12:04:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e5ea71943sm2164677a34.50.2025.07.17.12.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 12:04:12 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:04:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] please pull mmc-2025-07-16
Message-ID: <20250717190410.GR193579@bill-the-cat>
References: <20250717041933.GA26574@nxa18884-linux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+OnLaMRkZFUApfq5"
Content-Disposition: inline
In-Reply-To: <20250717041933.GA26574@nxa18884-linux>
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


--+OnLaMRkZFUApfq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:35:47PM +0800, Peng Fan wrote:

> Hi Tom,
>=20
> Please pull mmc-2025-07-16
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--+OnLaMRkZFUApfq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh5SSoACgkQFHw5/5Y0
tyxpzgv8CmSrCOFMuHs+4fS+TVQQpxw42E1yEna9dcp/Ow5t95KZdsW4p3dHZF9G
LG2ucm7UzW0eAMjTqw5jzQNkjjarYYOZBHLuh1gH72XiK7H8Q57PEwiEiaozbKDn
mRBZ/FJxx4R/BnfKInZKp+eV2qvkWB2TBWYx5bgS4jTBJjoOzzV4CICJuSXOWHQ6
58AhAHU2nOScsmD5dzKsSvc0HMm6UkwiqyBhxawDPE04jnHiYRpTZTbyPOEymx4K
VnGMBQMbfC42rnN94i3zdgzv0tOH8TsJEvrYAxwCr+1qHuwYoci9N+0KIcl6H4nj
6CRsua8n57ajyCXwFEmdTf4pN479HC7kQimltD/iYLBuYwbGkJeA/Q4USCtxRHK8
YDt42TAfFAm8QnZnvkeDeM3Kn9vmY/nCPqGbigWpRksyoHiBVkJbEQOE1ksxcDpr
tRpG2kKrZORZD4WXONPeDeFjMcu+tQ6h/RfKTTEFBc5bde4UHbbTocnTPwsxMSd4
ouP4jqot
=CZ57
-----END PGP SIGNATURE-----

--+OnLaMRkZFUApfq5--
