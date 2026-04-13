Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BBEF34C62
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 15:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8959A839D5;
	Mon, 13 Apr 2026 17:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tEICVqR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67319836AC; Mon, 13 Apr 2026 17:30:01 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5742836AC
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 17:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbce74e537so3544394a34.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776094197; x=1776698997; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+BeenR5TzBs/pG3bH9LsLqRy7CapMpUwJBMln5DyK/w=;
 b=tEICVqR9qGCmoycJtYt1woWEPR2pWP35OzxgkovFuYzbW4BM+c4yr6xjyRSNlYV2sv
 lYTmASExDaJ0G3vOEwZfbmCpx6Wrh3PGSsX325+ISVtehuTBnovPieCu7B7rSIdJwbyx
 zygZNh6mc7JbcKeC9sBJOsMrS7x2YllG9sk4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776094197; x=1776698997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BeenR5TzBs/pG3bH9LsLqRy7CapMpUwJBMln5DyK/w=;
 b=DMGcess+/d6EDdCnUIKS7fOVTXSjZppw4XifzYE35uiELRopSFPH20Uh6A0w8HtJLz
 i3GRPlzm2C6BkUv/sPwf9qKVo43u2wD0iZrOJFOGwD5RyOQEyEYgkXN2U8EMAapCojhb
 f/sct7FqEpeg9morZMldnaCfviE9uXB62+ChhIqDUrgVO3rj64gzcJsM7BDktrlCwoof
 hazLXEMRSvBV4d3xuVzILJFMpIt5jTtSog6vbSYFejOnt+cOATgSnVo+7EiafR/9I/XK
 hE5H9vEggPlk0I+ra11RB2dj4HLVS3ba1WIL13whRQPPbrBEtNrEnDDbCp5Yyb69PFWx
 d/Tw==
X-Gm-Message-State: AOJu0YyUkcYa0JMoe/RuVHuUFaeKeccZumfKgO21lKwdUkp+bZ5U2RNB
 hFfdCnVx93p5tPQYqbm/bHOvKlvy4NfYR2ATSXYalBBfnaDZYmCH7Pp/5MNBhi+i7j8=
X-Gm-Gg: AeBDies54R+tJNVwIvuQ0HK5MljLg0/9Ffk+4B6vVlfOvMY+m3ikrpkZyCjOp3vz+OH
 qlRnS472CqXE2Rmz+DovCGUdjt4NjY2RbkeeZd2lole+WBVHLrCbeu2PBTI5gws/sPWCcaUsBRy
 6DhQ8Mjngk+Z2XxeV+cau/4qIpuYLvKYnya9KpEjnDLBVLQWGSBRsvedhCtzYFFrh/Far5FS3IX
 y5QlFczRMEjfviJRRYt7A5tdTZkCcoAORxASyzTMnpFrOiOx0gpK8snBEW4kj+tvzgl6qOGW58L
 cRVW3YNhGRoCmz830KjIQrQFG0/n54lBzWyTNqpZGHtErnnabX5T1ZzpCPLqOynoeBvNauYCT4H
 5tTNG+rNTbnqCg9j81MurkwuhtW4dy5KswZooDdey1pa//ooYPy/UCwiCJfD0kUo2jfdIV62FQb
 RwxnkL+toIXXGUe2csiT8/FCTCR4Ij5ccF/qnyOROJSJhaVA/b/VuCG7BaQI98/QJOMYzfxRSCC
 dG+ddnvK+Y2Id5iSXa+pa9cmcjNdZwEMd21jkkHFp5GZdYLVeY=
X-Received: by 2002:a05:6820:3397:10b0:67d:ccf6:13f1 with SMTP id
 006d021491bc7-68be7ee39f3mr4494344eaf.37.1776094197334; 
 Mon, 13 Apr 2026 08:29:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc7dfa174sm5828927eaf.3.2026.04.13.08.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 08:29:56 -0700 (PDT)
Date: Mon, 13 Apr 2026 09:29:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 00/12] test: Add support for passing arguments to C
 unit tests
Message-ID: <20260413152954.GW41863@bill-the-cat>
References: <20260412111958.943933-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rZtAOxUt+nr/UNtV"
Content-Disposition: inline
In-Reply-To: <20260412111958.943933-1-sjg@chromium.org>
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


--rZtAOxUt+nr/UNtV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 05:19:37AM -0600, Simon Glass wrote:

> Some tests have two parts: a Python test which handles setup, such as
> creating filesystem images or configuring the environment, and a C
> test which does the bulk of the work including assertions. At present
> there is no way to pass information between these two parts, so
> things like paths and device names must be hard-coded in the C test.
>=20
> This tends to make people write tests in Python, but this is not ideal
> for several reasons:
>=20
> - Python lacks access to things like return codes and has to scan the
>   console output to figure out what happened
> - Python lacks access to internal state, so it cannot directly check
>   the result of an operation
> - Python is ~100x slower due to console interaction, etc.
> - C tests can be stepped through in gdb, which is much harder with
>   Python driving the console
> - C tests can exercise internal APIs directly (e.g. fs_read(),
>   fs_size()) rather than going through the command layer, so they
>   test more precisely what they intend to
>=20
> This series adds infrastructure for passing typed, runtime arguments
> from Python to C unit tests, using a name=3Dvalue format on the ut
> command line.
>=20
> The series includes:
>=20
> - Regex assertion helpers for matching variable output in tests
>=20
> - A private buffer in unit_test_state for test-local temporary data
>=20
> - Argument-type definitions (string, integer, boolean) with optional
>   flags and default values
>=20
> - A new UNIT_TEST_ARGS() macro for declaring tests with typed
>   arguments
>=20
> - Argument parsing in the test framework, accepting name=3Dvalue format
>=20
> - Updates to the ut command to pass arguments through to tests
>=20
> - Type-checked accessor macros ut_str(), ut_int(), and ut_bool()
>   with bounds validation
>=20
> - Tests for the argument feature covering type checking, optional
>   arguments, and argument-parsing failures
>=20
> - Documentation for the test-parameter feature
>=20
> - C-based filesystem tests as an example of the hybrid approach,
>   with Python wrappers that pass filesystem type, image path, and
>   expected MD5 values to the C tests
>=20
> Note: This series depends on:
>=20
>    https://patchwork.ozlabs.org/project/uboot/list/?series=3D496972
>=20
> Changes in v2:
> - Correct double signoff

Reposting a series this large, on the weekend, the day after v1, because
you made a trivial mistake is bad form. You should just acknowledge that
in the cover letter and wait for feedback.

And since I'm seeing over 100 emails from you this weekend, this
matters.

--=20
Tom

--rZtAOxUt+nr/UNtV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad0L7QAKCRAr4qD1Cr/k
Cg1dAPsG3A4AldYPE2s4BwusqROIPWaXns73usX5kbUJ3oCd5AD/b6UbPEZoPm9Z
TZL/o1ldwVHcVz4uHp1Bh7j03+XZXgI=
=y4hK
-----END PGP SIGNATURE-----

--rZtAOxUt+nr/UNtV--
