Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D474CC7115D
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 18:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0324782C65;
	Thu, 19 Jun 2025 20:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S8ZN949n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B772382CBB; Thu, 19 Jun 2025 20:09:56 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F72A82BA1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 20:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-40a55314d06so273395b6e.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750356593; x=1750961393; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vYv4uQr3ou6eziy35jUbYnwXwW2eVwLmii4FxPz9Yz8=;
 b=S8ZN949ncvCy55AvC1EmOPKKdf25IhuBCwCou/eFVIudhzXaI44YpSOza3CyB7oGDz
 0Mhmi5QLAprZi/v0WCa6wprBXcirndn17OsknnKCKJTv2RAZyQnzXloGKBbMZdZXrHon
 7rceRYiRr0kiUsrayZSVxgochQ2V8nJ/8r/aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750356593; x=1750961393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYv4uQr3ou6eziy35jUbYnwXwW2eVwLmii4FxPz9Yz8=;
 b=dJymzus8uyKTMoFemr+rvna2TTVkwqUzw7OAkjz5WMD+V5KY34WENOkYhy+yOdfWai
 IX35fEoiMyKU4GyQYwmUNupbavD7+0cC/6qawsr3cU6aJQcObqwRcbR3n5cnZ3XLowaX
 z306q05/Vhs91fwEQBgV+AhN6LXm/bFi6U6gQaZxBofsZlE6igQws+iA7HxVu0UZjkcx
 jJzXlzGsXBZwbFypiwxuSVXdBS+qdjCZLBGQGtU/cdhlyS4hO+d7iXPiA0ddTAZiKRPN
 FL9ozf1uOE0j+DkcAFvbW4LmUrdi7F5btWvjuvY6Tp0cwXQ2NZJEQONRFwfG8I17kLpX
 ngfQ==
X-Gm-Message-State: AOJu0Yx0b5KimbdplDLdAhceHk1tsCNpM5jRxwO9zLgSkWAri10BCt0D
 JZwqGmbH2tNIZTiFOThWY/76dy7NnAesYyjYcvvuSNN9H0+YrLOTtSjh1gGN9mAEpD4=
X-Gm-Gg: ASbGncs/Ns2lLK/c9cz//FDxRU5R3AGgynVuf+b8wu00/jAsHq8sL4ZCLF4zzzYh4nJ
 2krl4uFdkz+gHBz/y4FSUn4vhM9R4Zp3WneNHzaWgjp0ndYiZsqxVhdzdu7abY8najZ3EssT/e7
 InVZ/mKLWzRyaufBKZUSRtxldM4iPgTm+61K/H5EavPVVqzMv91U47oY5FngVDTV9VYbIR3qlUi
 K1qZ8dGvG0Mne6NyC6SclN9a1EAlVfhU5xJSbtq5oXBBmLgRBdV0+o4nQHaKBkK/rsdyT/9yV+U
 nZLgJaxinPhKnI2tauzxWvPObjGB63B7TY43amPK9uY7cyJftyge1aqSoiOMLLy+JjPdaYhvjoh
 4X2S43+9U3P+1Y90Ink6M7aw=
X-Google-Smtp-Source: AGHT+IEg9feQNMV0hSMVzveE4WRqI4tcsC8CgKs54f2oS6MaSDSS9v2fcuIbUsJEPsQ8zaKTQbL9VA==
X-Received: by 2002:a05:6808:424d:b0:40a:548d:f088 with SMTP id
 5614622812f47-40a7c243142mr13796371b6e.35.1750356592919; 
 Thu, 19 Jun 2025 11:09:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b7a1cf9sm8880eaf.24.2025.06.19.11.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 11:09:51 -0700 (PDT)
Date: Thu, 19 Jun 2025 12:09:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: u-boot@lists.denx.de, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Shiji Yang <yangshiji66@qq.com>
Subject: Re: [PATCH 0/2] rsa and fit_check_sign build fix for v2025.07-rc
Message-ID: <20250619180949.GB216500@bill-the-cat>
References: <OSBPR01MB16702ED24460D23A7ED63440BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="85rnqH19OOhHpGN6"
Content-Disposition: inline
In-Reply-To: <OSBPR01MB16702ED24460D23A7ED63440BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
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


--85rnqH19OOhHpGN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 12:38:16AM +0800, Shiji Yang wrote:

> From: Shiji Yang <yangshiji66@qq.com>
>=20
> This patchset fixes some compilation errors that I caught in version
> v2025.07-rc4 and branch next. If they are acceptable, please apply
> them to the master branch. If anyone has a better way to fix these
> issues, it's fine to ignore this patchset.
>=20
> CI test: https://github.com/u-boot/u-boot/pull/783
>=20
> Shiji Yang (2):
>   lib: rsa: fix compilation error without openssl
>   tools/fit_check_sign: make the module dependent on
>     CONFIG_FIT_SIGNATURE
>=20
>  include/image.h      | 2 +-
>  lib/rsa/rsa-verify.c | 2 +-
>  tools/Makefile       | 3 ++-
>  tools/image-host.c   | 4 ++--
>  4 files changed, 6 insertions(+), 5 deletions(-)

I think this is fine, or at least it's the right starting point. I do
wonder how functional the tooling actually is in the case of
TOOLS_IMAGE_PRE_LOAD=3Dy && TOOLS_LIBCRYPTO=3Dn but understanding that, and
then likely having to further adjust a number of symbols to capture what
is functional and not just what passes a build, can be done as a
follow-up.

>=20
> Regards,
> Shiji Yang
>=20
> --=20
> 2.50.0
>=20

--=20
Tom

--85rnqH19OOhHpGN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhUUmEACgkQFHw5/5Y0
tyxFOwv+MQTZ8CF2BLYmw94fUN3KVNyjkxBWX2N/cN2mU3pmgt7VBXcB6FQx67eZ
BySjVtXdSJ+iQdMTlmJTRUsOaQI/OLrigMDXsyqXpQ5/pBdLuTIucYN96jM1xheS
fWOWON0VlQ/4icxJqnr6D0Up/SfvpMkgmuJm/n9hf0ZJzWQHr7fVBHXFyxv9vAyg
dMcTXvrXy115HkEcSrfR9UL8OKQwn1FMP0c6oAZtLfE0xHL7ABFKsayB6oaI+TFW
ia7p8h3qxLN5m/hjp9e0K0AkZb9HbHQcCPPPfpAOJb87byMeNxxseq7EymJ053Tr
v4aWVJ3aIH3lQONF0BAYT41GxTTvhZbdbakQ241OxxE1ok3+k5Yw1HwLMImjhcBs
9RjKkcJL2rw2c+gJXgoA6Am+O47+ENMqnYHyx1V5YZF1/imJ/4HJ9gVLLtBFm4jd
CfTFoAWwn1CJKwDl2ioEUre+4stC68jtI4r81J0y6nIdl9To3KvuIZDC/XNloomR
idQTCQr4
=Yq+j
-----END PGP SIGNATURE-----

--85rnqH19OOhHpGN6--
