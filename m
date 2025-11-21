Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02316CFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A08839DF;
	Fri, 21 Nov 2025 18:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RLjSDQgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465F083A1B; Fri, 21 Nov 2025 18:18:31 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250D380433
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:18:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-657244ed2c2so477331eaf.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763745508; x=1764350308; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QdhHKG2mArjOOfBB8J+0l1U/fCI9C5TS2jwW2HAPrLM=;
 b=RLjSDQgHNzlvVytpE2kwoUJQ2oOjm7ObVydSxsSBdrPt3D0nZSQ/376TEJ7YAvfSL1
 Paq9WquD2/emwnAzTOW7bgSSj8mEQ0JMFXpRwRp0mgCfEKg+5SuklKXUcV93RXflCQLQ
 m2Dx9Vh4i5ASF/gOjW2psLCgJM/34isfqS1eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763745508; x=1764350308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdhHKG2mArjOOfBB8J+0l1U/fCI9C5TS2jwW2HAPrLM=;
 b=Agf0aTbQCuPJx7WCBArb3mcunpbnLsYTGAWiV6ts43aBbiDKAR2b78OsRG88KxAJ7P
 3skyCwMjt7fsmDGN/CrSHOwOUP4fDxgba8gDICwuYzT0o3nnfBt/lHBlZGiT2e7g6wcq
 HFovAROffi+eWdzLvvnF3vNDit3FlxWw5QidQDXyTVS6Jj/3h9b1o3fZBm8fVYjcnQ6T
 7IkjbvMNXJbMQJx7OzWV65Wu2pPUmTr3kgK4VTzpclYDNDInjrH4qsKJNpwhgB9NzpV3
 X+V0yufxtekX6BbqVW+M9LiuZBjI9AyuXg+qCjkHh2BpEBb1l5HWv0QomzizfrKdtm3+
 7e5w==
X-Gm-Message-State: AOJu0YwKLY3VhArEPLG/9T24/irFFS/3C9nvCXMjBdHJDlVXfh3uioc1
 QsCdaqNJG5BqZSkKxF2HVLwkGEqvA4lqhWVz7g+yiGFypJbWD3iz1ZRN3H5/Uqs5S3YMoW6QVDP
 6PI1CcME=
X-Gm-Gg: ASbGncs06MbGn4ybVxOrSuZMvAfoBPN9gj6EW+a0pBgdx/df/namt5vZGZrj42KCQBp
 PGARATO6ZI6Hgp0gmGBzWWHBw9BY17g1s71nioCpGQLcIKOGRN9ZVB4xK3TkBnw/SdUIiqgObf8
 0hsFjQtsHjq64FUxHXASLpUm4/E94mZpmDwyL+mEXawKsId+mdc4RTABGtJJiGRFwsQpC1UR9xx
 iffiIW1w860y895+sDcxVm6AXS3H7zsXxygYmqTmGDoFjHumZ0Uj7fkPmpsuY/tZ950zO6wg57v
 GFoQzzhcaf2TrH+z3LotYOcFoMtXdEI1l876NJ+zAXxoBwzcP2tBsNLx897is33uIY0V+wr7IZY
 CEpHVnpBOsA5UY9Z4G43G7P0GEefixfYTdfxk0YIObVQF4gZI2Li7YP/eV/3NQHsQ2qkF27gj5c
 sTmEVlv7VXbpRCEgx+73c572VhfLGc74P27p/d1bJdKSX0KyNaDg==
X-Google-Smtp-Source: AGHT+IGXp3p0v7JAjI3y/M4v9OmngCC0BK2fwqO0QZK1dzsLstGhOQcpKpr0LIRNQPjCMPjIYm7CzQ==
X-Received: by 2002:a05:6820:1c85:b0:657:633d:7361 with SMTP id
 006d021491bc7-65792570d26mr1026878eaf.4.1763745507835; 
 Fri, 21 Nov 2025 09:18:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782a6de78sm1816207eaf.8.2025.11.21.09.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:18:27 -0800 (PST)
Date: Fri, 21 Nov 2025 11:18:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] CI: add libengine-pkcs11-openssl package for pkcs11
Message-ID: <20251121171825.GA2125796@bill-the-cat>
References: <20251121-pkcs11-ci-v1-1-8ba6da56c2f5@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BG0BGS5nSbeOTfM3"
Content-Disposition: inline
In-Reply-To: <20251121-pkcs11-ci-v1-1-8ba6da56c2f5@cherry.de>
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


--BG0BGS5nSbeOTfM3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 06:10:54PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> In the future, we'll need proper pkcs11 support so that we can validate
> mkimage/binman works well with pkcs11 OpenSSL engine/provider via
> softhsm2-util (already installed).
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

> ---
> @Tom, once this is merged can you please tag and push a new image to
> DockerHub?

Yes, I'll make sure to take these in the right order and do an updated
container build + push with this before the new functionality.

--=20
Tom

--BG0BGS5nSbeOTfM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSCe1QAKCRAr4qD1Cr/k
Cp8FAQD3M+QbvRRi6i9irQ4GXktm1rHKaycTJge1DWgol+UkzQD8DBcTmPepSwQE
pKCx0p4ngnbGY3MH1tcJsvKuvaPGvgQ=
=OeHV
-----END PGP SIGNATURE-----

--BG0BGS5nSbeOTfM3--
