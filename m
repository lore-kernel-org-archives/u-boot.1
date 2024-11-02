Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D53E67816
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF7488FFC;
	Sun,  3 Nov 2024 00:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mCQkl/Jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878798908D; Sun,  3 Nov 2024 00:24:49 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5666E88C86
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b15416303aso238299985a.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730589886; x=1731194686; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PTdkckodz0YT/RwDZ9ztqwRS2a5J9+PrUtAAmfZA0Nw=;
 b=mCQkl/JnVKHpw4E7vIkQg8ucLCOIyJXsd1ny/YRA+m58jwDlDDrN7YUlNIChoQfTla
 h115UYu6aeaEpbWTsRv3rq2JBFENZPYN1ZiaXgLpUfIK87afGQ2k6CYBGo46h5QdE0QF
 kGK/XsVk75g6Tvv4jJ9u3OgXb+UvQNhl7dT6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730589886; x=1731194686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTdkckodz0YT/RwDZ9ztqwRS2a5J9+PrUtAAmfZA0Nw=;
 b=L0wsNYyVzBLJKo88fFlG55Gt7YnZrEYM7m9WV43fx88bkZCn4eS/7ZCBddSnP1/VKX
 Pq+5Y/8NQpTEnS93m/yf5URuciVyGfaPbFQRT7/sqPr8cLFN0qByIK9yslOYx3D27U1U
 T2uhZBr6AQvmvbuKBURckE3Hrvw2NGjojXdZHd/oatz97AajLvdYlpjvHlbpk4MF6+Ue
 ESTK/46DRiIqHgkNLzI51NDfD7EHoyuiFb1C69eeRT/2wSy67y4lO4HtTkYgbEz1B+KC
 wu/CSY5zaU5CsTpPPsBoyY2rB9Bxp5jMlgZrZNLm82WBmZBgtOeULrINRIWKSaYa6zhR
 Sfmg==
X-Gm-Message-State: AOJu0Yy4JLEwe9WhcNK7ZtzeukaNKnmH4hw7I4VzT48yuxIYaBpnbWJX
 MDqQymAWpcDSjQyJkNFrD6NQDn6XnVBXA72sALf4EXuYZYHNwMoeklu7cftW39A=
X-Google-Smtp-Source: AGHT+IHvZWWDzYzjtGOPppiRlR8GENG3Ig12Nmw8Fcjh/63nDvoMUGAD/x8NovmraJ4PVEyw15W4Hw==
X-Received: by 2002:a05:620a:44c2:b0:7a1:c40c:b1f1 with SMTP id
 af79cd13be357-7b2fb9befb9mr1203301685a.58.1730589886173; 
 Sat, 02 Nov 2024 16:24:46 -0700 (PDT)
Received: from bill-the-cat ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fe7860sm33374956d6.60.2024.11.02.16.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 16:24:45 -0700 (PDT)
Date: Sat, 2 Nov 2024 17:24:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 00/20] test: Tidy up the test/ directory
Message-ID: <20241102232441.GW3600562@bill-the-cat>
References: <20241102193715.432529-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dZMbsXhFpIvhUucC"
Content-Disposition: inline
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
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


--dZMbsXhFpIvhUucC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2024 at 01:36:45PM -0600, Simon Glass wrote:

> Some tests do not use the unit-test framework. Others are in a suite of
> their own, for no obvious reason.
>=20
> This series tidies this up.
>=20
> Changes in v2:
> - Leave the bootm rule alone, as the bootm test only runs on sandbox
> - Make the test dependent on sandbox
> - Add missing 'common' help in this patch instead of bloblist
> - Drop patch to move bloblist into the common suite
>=20
> Simon Glass (20):
>   bloblist: test: Move test into common
>   bloblist: test: Drop global_data declarations
>   test: Drop test-trace.sh and common.sh
>   compression: test: Move test into lib
>   compression: test: Move into the lib suite
>   command_ut: test: Move test into lib
>   command: test: Move into the cmd suite
>   test: Update command test to use unit-test functions
>   bootm: test: Move test into boot
>   test: Move print_ut test into common
>   test: Move print_ut into the common suite
>   test: Move str_ut test into lib
>   str: test: Move into the lib suite
>   test: Move unicode_ut test into lib
>   test: Move unicode tests into the lib suite
>   test: Move time_ut test into lib
>   test: Move time tests into the lib suite
>   test: Update time tests to use unit-test asserts
>   test: Correct display of failing test
>   test: Quote test names
>=20
>  include/test/compression.h           |  16 ----
>  test/Makefile                        |  10 ---
>  test/boot/Makefile                   |   3 +
>  test/{ =3D> boot}/bootm.c              |   0
>  test/cmd/Makefile                    |   1 +
>  test/cmd/command.c                   | 108 +++++++++++++++++++++++++++
>  test/cmd_ut.c                        |  25 +------
>  test/command_ut.c                    | 104 --------------------------
>  test/common.sh                       |  20 -----
>  test/common/Makefile                 |   4 +
>  test/{ =3D> common}/bloblist.c         |   3 -
>  test/{print_ut.c =3D> common/print.c}  |  27 ++-----
>  test/lib/Makefile                    |   6 ++
>  test/{ =3D> lib}/compression.c         |  39 ++++------
>  test/{str_ut.c =3D> lib/str.c}         |  31 +++-----
>  test/{time_ut.c =3D> lib/time.c}       |  60 +++++----------
>  test/{unicode_ut.c =3D> lib/unicode.c} |  70 +++++++----------
>  test/test-main.c                     |   8 +-
>  test/trace/test-trace.sh             |  64 ----------------
>  19 files changed, 205 insertions(+), 394 deletions(-)
>  delete mode 100644 include/test/compression.h
>  rename test/{ =3D> boot}/bootm.c (100%)
>  create mode 100644 test/cmd/command.c
>  delete mode 100644 test/command_ut.c
>  delete mode 100644 test/common.sh
>  rename test/{ =3D> common}/bloblist.c (99%)
>  rename test/{print_ut.c =3D> common/print.c} (94%)
>  rename test/{ =3D> lib}/compression.c (95%)
>  rename test/{str_ut.c =3D> lib/str.c} (93%)
>  rename test/{time_ut.c =3D> lib/time.c} (56%)
>  rename test/{unicode_ut.c =3D> lib/unicode.c} (92%)
>  delete mode 100755 test/trace/test-trace.sh

For the series:
Tested-by: Tom Rini <trini@konsulko.com> # rpi_3, rpi_4, rpi_arm64, am64x_e=
vm_a53, am64-sk

>=20
> --=20
> 2.43.0
>=20

--=20
Tom

--dZMbsXhFpIvhUucC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcmtK4ACgkQFHw5/5Y0
tywnMAv/cryUZubFhNbLJ0qJn1yEeoDPqP8MMTF+UfguAFCgBksfmtWW2GyUD43B
xYlkcLzVTzTvKSKY89C3QR5yQiuqBw38e/Tioa/1NRQrsrBU5xOpn03SV5hCQr2X
hbvPnvhEchxSu2P4E+Gmv0m5zVJOvDag5OxuGoO73u3Adfy3biWQIiT//znDBuEM
4VfmDbkiWUGZCXsxHiaxouV98q9nuoMThxdTZ/q04NeL3jev3zKiz20P4wSaEme+
QAzhkDWmGCu6w4Mp8aWmWq9gXU1IS18IGRPOR1+5+Mj6myxP49v582AuoZxr6U9L
Lr5zoky3LrAxVJ0RVKjYeB6fMCa2DZl03D/pUd4Qxat6xCqrbKELErbySEsPqPwf
WiJX53Y/8ej/0t+ws3w/OOy3LBs90i1nAorg/y5MwB7+RZR7QAOLQJ23u7CAG36S
BiZv6EckOwzoRjUSRZjsNsijtMnxzilimTVyDIbNer6wQan0Q5gnQg9pgB5fZIGR
LdEELOfx
=AzA1
-----END PGP SIGNATURE-----

--dZMbsXhFpIvhUucC--
