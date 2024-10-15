Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437CDCFC267
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 05:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760DC88703;
	Tue, 15 Oct 2024 07:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oJKJ6irz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5745888FF6; Tue, 15 Oct 2024 06:30:20 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D147489259
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-84fe06fbdc6so1123040241.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728966616; x=1729571416; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E1MilFy8TDFJQsBqy2BuaQhYOnG0+qyrTsjAgk6NZlA=;
 b=oJKJ6irzGezdOxrcEbdOdyofJxCWYj4Wgx0aPQVjl+e1tVoeIaQp9+OGMMq8U/ONxR
 /Qi19inJwFYcb2N34n0t8IcRSMAK0mpb8ChTkC8w9vlOAnpcpT5MWkcCZS2Cv0dobE8z
 BWOjEM7rJi6uPpwX1i9ns5KBQYY+itJ1s53xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728966616; x=1729571416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1MilFy8TDFJQsBqy2BuaQhYOnG0+qyrTsjAgk6NZlA=;
 b=DEpPPqGmG4fgtt4Jhw2gMalZ8gTkEoSlwusXqjjg+80jEPeUPwD56HdfsWAZ0vAilG
 fATut9QHb4PIMTeNhXxuaZzi3+SNb09iVM7NCbSSnh5hUoeNqILil3K7VXlyYet6g+li
 hoQ4CyLgiVEfjsUz0uC1pqIEBYF8pQjf+8+oSNMVVPr/4G4aX7LK0tZ14b3YLaAju25x
 pvF7H5imKUJCXSD7bvjZNVBYPKX+qxESbWWXDoGwIqfautMU/Q8LxsTzN5UlkbjQstEb
 rISEdvAVue9uu9vwSK0gEA6zEY5nxqPf3kjtK4sew314ySobK6hNQUrn9gAQ5MSy6gf3
 0FcA==
X-Gm-Message-State: AOJu0Yy4HrzNH8Su+mdiSNEvqF2SIZx8cULRHszxYYGVanmwxiq1+HzB
 ugzziDwkxwfeRt9zafnNkTYboy/ZAPIBy1wglFQtAnoWKKIw58QQN78ji4r7e5s=
X-Google-Smtp-Source: AGHT+IEpfcMDsMoZ18XUnbxBeXKDVkQ18DLOtPetCkYQ+EBZw3rxRaCmqkmuFE0lMmrBaonfdvqp4A==
X-Received: by 2002:a05:6102:c4d:b0:4a4:9194:d2c1 with SMTP id
 ada2fe7eead31-4a49194d4b3mr4215922137.27.1728966615584; 
 Mon, 14 Oct 2024 21:30:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1363951ecsm22723785a.78.2024.10.14.21.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 21:30:14 -0700 (PDT)
Date: Mon, 14 Oct 2024 22:30:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v8 00/27] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20241015043008.GJ53053@bill-the-cat>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gS4T0U5yQSBCjb6C"
Content-Disposition: inline
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 15 Oct 2024 07:43:12 +0200
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


--gS4T0U5yQSBCjb6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 02:50:13PM -0700, Raymond Mao wrote:

> Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
>=20
> Motivations:
> ------------
>=20
> 1. MbedTLS is well maintained with LTS versions.
> 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
> 3. MbedTLS recently switched license back to GPLv2.
>=20
> Prerequisite:
> -------------
>=20
> This patch series requires mbedtls git repo to be added as a
> subtree to the main U-Boot repo via:
>     $ git subtree add --prefix lib/mbedtls/external/mbedtls \
>           https://github.com/Mbed-TLS/mbedtls.git \
>           v3.6.0 --squash
> Moreover, due to the Windows-style files from mbedtls git repo,
> we need to convert the CRLF endings to LF and do a commit manually:
>     $ git add --renormalize .
>     $ git commit
>=20
> New Kconfig options:
> --------------------
>=20
> `MBEDTLS_LIB` is for MbedTLS general switch.
> `MBEDTLS_LIB_CRYPTO` is for replacing original digest and crypto libs with
> MbedTLS.
> `MBEDTLS_LIB_CRYPTO_ALT` is for using original U-Boot crypto libs as
> MbedTLS crypto alternatives.
> `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
> and Pubkey parser with MbedTLS.
> By default `MBEDTLS_LIB_CRYPTO_ALT` and `MBEDTLS_LIB_X509` are selected
> when `MBEDTLS_LIB` is enabled.
> `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
> `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
> Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> introduced.
>=20
> In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
> are by default enabled in qemu_arm64_defconfig and sandbox_defconfig
> for testing purpose.
>=20
> Patches for external MbedTLS project:
> -------------------------------------
>=20
> Since U-Boot uses Microsoft Authentication Code to verify PE/COFFs
> executables which is not supported by MbedTLS at the moment,
> addtional patches for MbedTLS are created to adapt with the EFI loader:=
=20
> 1. Decoding of Microsoft Authentication Code.
> 2. Decoding of PKCS#9 Authenticate Attributes.
> 3. Extending MbedTLS PKCS#7 lib to support multiple signer's certificates.
> 4. MbedTLS native test suites for PKCS#7 signer's info.
>=20
> All above 4 patches (tagged with `mbedtls/external`) are submitted to
> MbedTLS project and being reviewed, eventually they should be part of
> MbedTLS LTS release.
> But before that, please merge them into U-Boot, otherwise the building
> will be broken when MBEDTLS_LIB_X509 is enabled.=20
>=20
> See below PR link for the reference:
> https://github.com/Mbed-TLS/mbedtls/pull/9001
>=20
> Miscellaneous:
> --------------
>=20
> Optimized MbedTLS library size by tailoring the config file
> and disabling all unnecessary features for EFI loader.
> From v2, original libs (rsa, asn1_decoder, rsa_helper, md5, sha1, sha256,
> sha512) are completely replaced when MbedTLS is enabled.
> From v3, the size-growth is slightly reduced by refactoring Hash function=
s.
> From v6, smaller implementations for SHA256 and SHA512 are enabled and
> target size reduce significantly.
> Target(QEMU arm64) size-growth when enabling MbedTLS:
> v1: 6.03%
> v2: 4.66%
> v3 - v5: 4.55%
> v6: 2.90%=20
>=20
> Please see the latest output from buildman for size-growth on QEMU arm64,
> Sandbox and Nanopi A64. [1]
>=20
> Tests done:
> -----------
>=20
> EFI Secure Boot test (EFI variables loading and verifying, EFI signed ima=
ge
> verifying and booting) via U-Boot console.
> EFI Secure Boot and Capsule sandbox test passed.
>=20
> Known issues:
> -------------
>=20
> None.

For the whole series, applied to u-boot/master. Thanks again for all the
hard work here.

--=20
Tom

--gS4T0U5yQSBCjb6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcN78wACgkQFHw5/5Y0
tyzB5QwArhJOUm69/AK4UxcLN5HvV8w6ZllcKu05hHCi+bbh+4sT8GcFsH3PE8CX
MRMqejVPu29zf/76eto+mDj4flgIrDHNy/VyZ5tmV1z8e/XF+lPo+jBwbOoBkGcF
k5JND89QbvHgTqTJeDKfCyYlV8AsuT33P8QWsjxiK/NAULpAcnPUn6ET7WQ/0QZR
twEVix2AePalKhifP0LUgOXn3OO8CpoDtkTMzQbLKoDqDuuSsemAZui1UBarw4Nu
Jdw8cXGgJ6AZdADN5i8peq923rVUfZCNTXvLR3V/w3cZCUmkp5nuB9erK2m0aNGI
mq14g0q44+OowdThXzMPmyUHj4V7Rp98+JNtQHtINXYRhX6q0z5HHdL3Ex+f3Oky
c3+jaKXPjwPdiWJWarbiLlBoxchVsOsaYncml1BB3AE5bn8lhTMqPJKt5Y/AI/5o
lURYZ2PO60wSBDjl/asxt3syd0MdatEJwJ5Tp81ArFdQtCGMZjisInxZSXbXFa/7
a8rGp0x3
=xlPv
-----END PGP SIGNATURE-----

--gS4T0U5yQSBCjb6C--
