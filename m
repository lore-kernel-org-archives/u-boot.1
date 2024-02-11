Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6709AC48260
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 00:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4780F87E8C;
	Sun, 11 Feb 2024 01:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f5j+imhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E0287EA2; Sun, 11 Feb 2024 01:37:19 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E71B87AEC
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 01:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-42a029c8e76so15268201cf.2
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 16:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707611836; x=1708216636; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3BAenIj/Y8XcwD+eipgpWOtC0LOHX13OfaVE8904YO4=;
 b=f5j+imhjPRQXYjK6Hs7Tih4CCDXWieqzzD2gOy4D6YmJuvkd/723l4d9TwVCSPjQfr
 vXp3KMagIN1eXTMsbQIaAn7pXUhRjIhZH60gTKrVUpnM4rZ88GZzwAmTdDIH8UtIqnXm
 gKeh2V/grMyiuCZ5fRCq9S0TdTQGkyY9k9OEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707611836; x=1708216636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3BAenIj/Y8XcwD+eipgpWOtC0LOHX13OfaVE8904YO4=;
 b=hyPUjpaQEsLcEUtJCF3cOzzYOjckdjzjohGprcqsh2l+20cDuTxb9M84J5+ZJBiBIf
 zdDkycJG5j1RTl8Ps0l7XOrTiLjd0YlQbiGg4DPJUNw5EQxH9BuUYvqijTziASwYSNYH
 iRZC3xKBFiVyeC9q9AAk/zHvKlZYScIgv3nY9k1h8Nx7X1DV1Y1pm9tlAR0pw77Eyo8T
 neS89xOB9hvANhskx743iHal1/xSzXOGnZRNGmlgNg3M2/EefsKqS/vG0EuUhh1hA1Kg
 UR3uCe6l//t7rx1fPKZLI1/XISJKmuDzaPHw711YRDJ7yb0K8sciH+S92wBn11HLV5G/
 /tUQ==
X-Gm-Message-State: AOJu0YzQQtoPiJkK8LPie0q25d/doeHzKN2cohiky9WZfvMNqr6CimD+
 vF8FHK7U2hROPpLrF8gYxTXX2busWAQDgVRNMs9x8qP9UfasfEpTIQTYJj8k32g=
X-Google-Smtp-Source: AGHT+IG1O3TBtodgLeorvouRDyKvBZNRdZyY2Ruqq57KMzhyZID0nXx6Wxejfj1GXHK1lNvT4PYEbQ==
X-Received: by 2002:a05:622a:1987:b0:42c:43e5:2ee8 with SMTP id
 u7-20020a05622a198700b0042c43e52ee8mr4686725qtc.14.1707611835874; 
 Sat, 10 Feb 2024 16:37:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVRCMd5+AmBuKUDk2hgeQDiNXYtC3Viu6uo3Aghf866A6a/MBds+wiVpCy4pfjwrVxQBIieSlQI9236d2H4n9qtqyqgKsYYp+yDAFmmPbIIdMal7bsAUUd+TqUpzOTYOPHM37T8OF/zyYm8CcHT+3DkIi4KWhesYEe81zbh/Xqro2+eX9ThCZT6U+WOS070aZu4SUYWYAQQ4JRNlGggDlECkv2EqhdNgjHBhtPIel/wRlwc/3JKETe/T3dOmhg3SzCkoJCR1iyprWzkJA==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 l3-20020ac87243000000b0042be1092915sm1869013qtp.10.2024.02.10.16.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Feb 2024 16:37:15 -0800 (PST)
Date: Sat, 10 Feb 2024 19:37:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Ard Biesheuvel <ardb@kernel.org>,
 Loic Poulain <loic.poulain@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>, Simon Glass <sjg@chromium.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: Re: [PATCH v1] armv8: crypto: SHA-512 using ARMv8 Crypto Extensions
Message-ID: <20240211003712.GB3040305@bill-the-cat>
References: <20240210120709.938286-1-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tkPIpzTp4xoJjlZV"
Content-Disposition: inline
In-Reply-To: <20240210120709.938286-1-igor.opaniuk@foundries.io>
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


--tkPIpzTp4xoJjlZV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 01:07:09PM +0100, Igor Opaniuk wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>=20
> Add support for the SHA-512 Secure Hash Algorithm which uses ARMv8 Crypto
> Extensions. The CPU should support ARMv8.2 instruction set and implement
> SHA512H, SHA512H2, SHA512SU0, and SHA512SU1 instructions.
>=20
> This information can be obtained from ID_AA64ISAR0_EL1 (AArch64 Instructi=
on
> Set Attribute Register 0), bits [15:12] should be 0b0010 [1], that
> indicates support for SHA512* instructions in AArch64 state. As not all
> ARMv8-base SoCs support that, ARMV8_CE_SHA512 is left disabled by
> default for now.
>=20
> Tested in QEMU for ARMv8 with compiled-in SHA-2 support.
> Even on emulated cpu the hashing speed increase was visible:
>=20
> With CE usage:
> =3D> time hash sha512 0x40200000 0x2000000
> Calculate hash
> Calculate hash
> sha512 for 40200000 ... 421fffff =3D=3D> 1aeae269f4eb7c37...
>=20
> time: 0.215 seconds
>=20
> Without CE usage:
> =3D> time hash sha512 0x40200000 0x2000000
> sha512 for 40200000 ... 421fffff =3D=3D> 1aeae269f4eb7c37...
>=20
> time: 0.356 seconds
>=20
> Real HW tests should provide much more improvement and objective results
> with 10x speed increase at least.
>=20
> The implementation is based on original implementation from Ard Biesheuve=
l in
> Linux kernel [2]
>=20
> [1] https://developer.arm.com/documentation/ddi0601/2023-12/AArch64-Regis=
ters/ID-AA64ISAR0-EL1--AArch64-Instruction-Set-Attribute-Register-0
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm/crypto/sha2-ce-core.S
>=20
> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> CC: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
[snip]
> diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
> index 9f0fb369f7..fd5c26421b 100644
> --- a/arch/arm/cpu/armv8/Kconfig
> +++ b/arch/arm/cpu/armv8/Kconfig
> @@ -204,6 +204,11 @@ config ARMV8_CE_SHA256
>  	bool "SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
>  	default y if SHA256
> =20
> +config ARMV8_CE_SHA512
> +	bool "SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
> +	depends on SHA512
> +	default n

Like the sha256 one, this should be default y I think, the performance
improvement is likely worth the size increase.

--=20
Tom

--tkPIpzTp4xoJjlZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXIFrQACgkQFHw5/5Y0
tyxHcQwApWulu2xa6TIEw1Cn0hIKxx6gRhw7ZKGbjkLyalzojw98AubZiocGl6YV
tfyd0Mzs+B686HSLvBa/QTVwwpQr/aa9Lpuy8NXWnJCbCqo+3FExYClnlYsGTdHO
cGgx3MhjJyzPQkoFlaOzNX0aWxEXADtKxPi3zBYFsNtfTfHldwEb+7xMZEclhbE8
AuvV/StulRWNnfxgT/dniZlAaKet0a1TgFlEZZ4b0weeBJ9+/hVn1gpuNxPMkiqW
lIHkuFOv2Z3kN2PLDvg7yvJXGN++zGS3X3EZyweD3DJySESIw51meVjlF6D2p1JF
woHEyTRxAz1S5IL05gItLGeACXOz2sxLD71A6j3VcwW3q50Qo09ZycPmhrEt3o7S
vMvdPLfHiBXIWZ7hQpOYdMFMssU8NdISjefp/5HIq3uZOkRSqU0T5v1aycZ15fc4
pDORlOY8uMjhVTazQQFANThf5JsZiLDS1HisNrnC2q5iKmx8QahKtru+zirPYw6Z
qdovyf+q
=BnpE
-----END PGP SIGNATURE-----

--tkPIpzTp4xoJjlZV--
