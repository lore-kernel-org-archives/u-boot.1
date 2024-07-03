Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D40C3065C
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 01:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFDB8855B;
	Wed,  3 Jul 2024 03:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nIdw5s9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D92798855B; Wed,  3 Jul 2024 03:26:04 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D692E8852A
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 03:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-701eea2095eso2861838a34.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 18:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719969959; x=1720574759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bqYx0MYelc0PtihtWwEc+gVfRSqXKInGdDVmgo3EWAA=;
 b=nIdw5s9iDDCwOTObuq/dns5rSLIJqGxK0PaJ7XFEg5XFvvrkLHnhFG+ubBSuHWvaGS
 iQToTReCXiG2IRxXHKjevNhWhEI15xhjPkZNH4cPIvDw7LCNr9+GbNMv8NPwqJsRlj1B
 Dia84bArdBVwbfRvp6pKwTkt28d0GFQ8kRpIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719969959; x=1720574759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqYx0MYelc0PtihtWwEc+gVfRSqXKInGdDVmgo3EWAA=;
 b=WE35tAkuqQdwgnVPW8H0vpjFg1M2yeolmprVnajzQ+cKEIiLCxMfNOACchk0f2pnwV
 elDdKr1Hitev48vvMv6LfukoT5/kpuCZTJb0amgzWzXaLGlg560HT234SG5ZQdQCskiG
 FTcWOiShIOJanUPNefLqWhE5V/0PHyIbb7J9DTLzoZ3oxvHfSqUOP6h8dNiIc8irz28b
 rYg5ZIcPB4F5xPjxKZ7Qk0qllV8iRczqOQkkI0gXZfveK9xVADJaM2djT8Od5qBrVWSS
 qTAwVDPeSAMmeNlpliHPQ7WSGXWTciD9XxmEmpHwIiOVb/I+0w6VNmkL7/+z0LqGHjBM
 VDiw==
X-Gm-Message-State: AOJu0YwTz4MVUzTLXQnr3VUdKpI+Qrjh0h3X7HR1XJ7eJ3YjnLzP2ZB6
 tFN1rUUFHRFV5vORVNQ776Bnbl8PQsyN/DUjjOc1ms/1XqNL+HTVQcunf9iaW7I=
X-Google-Smtp-Source: AGHT+IFjCSf5f69aUqyvGnmLRkB/2zkcK7Yg/gsXxDnUEIQ1rzHAIsLufhYnTnAaq6U/sCB0gJKGCw==
X-Received: by 2002:a05:6808:221a:b0:3d6:2c22:4b20 with SMTP id
 5614622812f47-3d6b30f58cbmr12267606b6e.23.1719969959433; 
 Tue, 02 Jul 2024 18:25:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-45.totalplay.net.
 [189.203.106.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62fa39442sm1904193b6e.38.2024.07.02.18.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 18:25:58 -0700 (PDT)
Date: Tue, 2 Jul 2024 19:25:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v4 00/29] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240703012555.GX38804@bill-the-cat>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aEb+6Snorws5qTZA"
Content-Disposition: inline
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
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


--aEb+6Snorws5qTZA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 11:22:36AM -0700, Raymond Mao wrote:

> Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
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
> `MBEDTLS_LIB_X509` is for replacing original X509, PKCS7, MSCode, ASN1,
> and Pubkey parser with MbedTLS.
> `MBEDTLS_LIB_TLS` is for SSL/TLS (Disabled until LWIP port for MbedTLS is
> ready).
> `LEGACY_CRYPTO` is introduced as a main switch for legacy crypto library.
> `LEGACY_CRYPTO_BASIC` is for the basic crypto functionalities and
> `LEGACY_CRYPTO_CERT` is for the certificate related functionalities.
> For each of the algorithm, a pair of `<alg>_LEGACY` and `<alg>_MBEDTLS`
> Kconfig options are introduced. Meanwhile, `SPL_` Kconfig options are
> introduced.
>=20
> In this patch set, MBEDTLS_LIB, MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509
> are by default enabled in qemu_arm64_defconfig for testing purpose.
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
>=20
> Target(QEMU arm64) size-growth when enabling MbedTLS:
> v1: 6.03%
> v2: 4.66%
> v3 & v4: 4.55%
>=20
> Please see the latest output of bloat-o-meter for the reference of the
> size-growth on QEMU arm64 target [1].
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
>=20
> [1]: bloat-o-meter output between disabling/enabling MbedTLS (QEMU arm64)
> ```
> add/remove: 206/81 grow/shrink: 19/17 up/down: 55548/-17495 (38053)

bloat-o-meter is a bit off then, since buildman shows:
u-boot: add: 243/-17, grow: 18/-17 bytes: 65723/-8480 (57243)

(Please use buildman for the size comparisons in the future).

And in both cases, there's a pretty big non-removal of code I was
expecting since overall we're replacing a lot of functionality, not just
enabling new functionality? If I'm wrong about that and we're doing
both, please separate out "enables new features" from "feature parity
with legacy" in commit updates to qemu_arm64 since buildman's handy
"show the delta for each commit in a series" is quite helpful in
spotting when we changed more/less than expected. And in this case
perhaps qemu_army64 wasn't fully enabling stuff before? sandbox changes
by only ~16Kib which is much better and I see pkcs7 and x509 related
removals in the size comparison.

Another note is that qemu-x86_64, which should be similar in EFI feature
function only grows by 129 bytes. Which isn't zero, but isn't bad. I
haven't done a for-each-commit build, but if we have generic bugfixes
here, we should split those out.

For example, I do see we're dropping some legacy hash related code, but
I'd want to dig a bit to make sure it's all of it.

And for v4 I'm not doing a world build comparison with mbedTLS being
default rather than legacy since I think the logic there is where some
of the Kconfig issues I mentioned are from and so I'm not confident the
results would look good. But for v5, please pick some arbitrary
platforms and switch them over and check the size change there as well.

Thanks!

--=20
Tom

--aEb+6Snorws5qTZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaEqKAACgkQFHw5/5Y0
tyy+aQwAgb7U6qOGJ6LIAHHfPEPXDt0COuIXIKa28CsTR0W6D+QtVQtg1nnTY3lf
zUKe/WNjvO2VnqIRPKhGhiIMStf00a+VzYHXeBi/DqhGRXY0NT64HvEt8GkRXL89
qLR07z3yhhia5d9/ZocEJD7JkpHnAZPes0M9RpYoSpQGvCRq/pWE0B6jR1ABV1I5
W+S2Ayd4CKFnsv9/JlcB22s0DsEEooQxU6WW3niIISSdJI1ym5jR+RP0WTV0cy9c
FYOLd4XB+D1piZ0ytZ9qkrRVlJRormqipKxDa42yKbKVKcFOhiicxXpgiZk7Jtwf
6UGWIQ25KTJYkG0rEYfQMVkhpo5zdyjL0vFaIKes13fTgX36hYgaGpQLpmoO/1xg
ruSCLIZ+i1wa/mQm+BbcEL//igzNkZzdXjBHXbJ/QN+MBXHpHPXrcqjPt7jQl/vE
Ut6AVW0HMEPkyQ+z0tzKDa5tWHxvYZ5SvTXdWlLtplqke239Ke0FwoZFdQKfDXpx
RGOauH+9
=EpSL
-----END PGP SIGNATURE-----

--aEb+6Snorws5qTZA--
