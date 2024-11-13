Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C57DD637A3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E39789021;
	Wed, 13 Nov 2024 19:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZBGs/gpP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175C0891E3; Wed, 13 Nov 2024 19:01:08 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC7689001
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71811707775so3976205a34.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731520864; x=1732125664; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QLl4G2ZBbzIg8owBSrAK3lBrkyK8B+YtVBTt9U7IBjg=;
 b=ZBGs/gpPsPfC4m2f2ggy5M/FkEyq2n5pwSK4hQAxeX4+8fgS16R3Yi3y/cnNGhur2L
 QMat9LOxpaoqs9JYQjSWgSjdhtPAL0ipnCH/FeVV1jdVvY9e8AvpUleWvEIVsTdb6mrP
 z9Jzfv8Cv00PMQQIHUr2v3TRCDvziEIke3Hlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731520864; x=1732125664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLl4G2ZBbzIg8owBSrAK3lBrkyK8B+YtVBTt9U7IBjg=;
 b=MGTYalKvg4XYJMOA5u8sd8yVJgsmFJXRTL3aPoykgzPlyAPnx//F2PJFBvW75AsyiQ
 nPT6Acp31sVTlV8qastZ8F7mLN2Sr9KpPc/oWsPgvumEqRL9MZ6jGCaSbm3cNwvfMFjz
 Wis8NJcb9WbmM2KiXx+NC4bn4hHekCmFqACQuAYWH86hMFrttKQwptxmoibmdq6SLzTU
 Uw2iZ/BHOcpBPSVHwbpteFmVIo5XVj9cjPSypMfV5t1ETJcCa10NIplo1HvoWvCzQWqS
 pk12iscidhbVTsW4S8w2Q1LwRfx9QgJQbQU3cGcum6fEzLbCFd4Qij4jvArQimQwD1OW
 nSQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY1971N8h06l+y2wmFPrF1JWKFJIJsW0+07hiI2WqQMOwxubiWYRvWS0FIo7APgFD8maGN514=@lists.denx.de
X-Gm-Message-State: AOJu0YzLRuRkJKR+ZIvqwUUlnFRh6iOqRKyxYztQoRsYw+A0HmJaql7b
 v5OJsaFCxJGylkdtWzp9o6eo8/GX95a3p8UBl1H+dgtv/pWLES8C+NEK6+5Upyg=
X-Google-Smtp-Source: AGHT+IHtt8jF0ZXshe+rvH229rQkGsmhZd9v8zkc1WU8iUMaWKIueFZwMU+FQnbynO3lrYF8O9rPyg==
X-Received: by 2002:a05:6870:7193:b0:25e:bd9d:b1cb with SMTP id
 586e51a60fabf-29560327086mr16246489fac.40.1731520863529; 
 Wed, 13 Nov 2024 10:01:03 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-295e9350878sm948295fac.53.2024.11.13.10.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:01:02 -0800 (PST)
Date: Wed, 13 Nov 2024 12:00:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/8] led: update LED boot/activity to new property
 implementation
Message-ID: <20241113180059.GV3600562@bill-the-cat>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eq8ubVNQqZtXyCWs"
Content-Disposition: inline
In-Reply-To: <20241110115054.2555-1-ansuelsmth@gmail.com>
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


--eq8ubVNQqZtXyCWs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 12:50:19PM +0100, Christian Marangi wrote:

> This series is split in 2 part.
>=20
> While adapting the LED boot and activity code to the new property
> accepted by Rob in dt-schema repository, a big BUG was discovered.
>=20
> The reason wasn't clear at start and took me some days to figure it
> out.
>=20
> This was triggered by adding a new phandle in the test.dts to
> introduce test for the new OPs.
>=20
> This single addition caused the sandbox CI test to fail in the
> dm_test_ofnode_phandle_ot test.
>=20
> This doesn't make sense as reverting the change made the CI test
> to correctly finish. Also moving the uboot node down
> after the first phandle (in test.dts the gpio one) also made
> the CI test to correctly finish.
>=20
> A little bit of searching and debugging made me realize the
> parse phandle OPs didn't support other.dts at all and they
> were still referencing phandle index from test.dts.
> (more info in the related commit)
>=20
> In short the test was broken all along and was working by
> pure luck. The first 4 patch address and fix the problem for good.
>=20
> The other 4 patch expand and address the property change for
> LED boot/activity.
>=20
> Posting in a single series as changes are trivial and just
> to speedup review process. (and also because the second
> part depends on the first)
>=20
> All CI tested with azure pipeline.
>=20
> Changes v2:
> - Fix handling of flat tree for phandle
> - Fix test and other.dts changes
>=20
> Christian Marangi (8):
>   dm: core: implement oftree variant of parse_phandle OPs
>   test: dm: fix broken dm_test_ofnode_phandle_ot and get_by_phandle_ot
>   dm: core: implement ofnode/tree_parse_phandle() helper
>   test: dm: Expand dm_test_ofnode_phandle(_ot) with new
>     ofnode/tree_parse_phandle
>   dm: core: implement phandle ofnode_options helper
>   test: dm: Add test for ofnode options phandle helper
>   led: update LED boot/activity to new property implementation
>   test: dm: Update test for LED activity and boot
>=20
>  arch/sandbox/dts/other.dts |  31 ++++++++-
>  arch/sandbox/dts/test.dts  |  16 +++--
>  drivers/core/of_access.c   |  61 ++++++++++++-----
>  drivers/core/ofnode.c      | 124 ++++++++++++++++++++++++++++++++-
>  drivers/led/led-uclass.c   |  30 +++++---
>  include/dm/of_access.h     |  86 +++++++++++++++++++++++
>  include/dm/ofnode.h        | 107 +++++++++++++++++++++++++++++
>  test/dm/led.c              |  18 +++--
>  test/dm/ofnode.c           | 136 ++++++++++++++++++++++++++++++++-----
>  9 files changed, 551 insertions(+), 58 deletions(-)

My main issue with the series is a lack of documentation updates, as the
biggest challenge thus far has been that for example Peter couldn't
figure out how to make use of this on PinePhone. We generate
documentation today based on include/led.h for this API, yes? Thanks.

--=20
Tom

--eq8ubVNQqZtXyCWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc06VsACgkQFHw5/5Y0
tyzmwwv/UFRl22GeMgh3PpoZoWuBXk7Loe2Y59/HIc7ojq0cCiQKXJsGlhBiJua5
n4Bc4tzzjPxhjPKYO/hrE9dtXu2+CJqAM7epA4iBv/WxFloiI+/XinFK/jOoKsGQ
Jsp5cheF+1KozhuiKn4ua17U0CByItOeMMP3mXX+Ug3aPN5HS51yFq3y8mYpxAzy
nR9lsR1hLadbHv7QjhStQqb5wRIfAutc4YyBVWhts5C/WdQ3YKjoCLXCQx+pRZMo
gjrliaxJVd27H7cNRO+7+VymemCD9N7kNtCmeiJ0CivubX15rDoD6Ctg1wQyg2pJ
LCe4Z00+NjSR7OsSbk28T+NMZFp28XB7pD4RQKRB9DbHGclWY0b13w49fhJDXNk2
kIINhu5VWkm9xiHPltjZUEzk2DHQNpyRULxepAj/+oj6FcdZQOrIx6I3kB7PNZEE
LgcoBLLPVoPp1LHpqTvGuxEALwGDUvmVswn2RluwP2F6Zk4nuHOh6JdzwRO6RYHD
mKuXC2dm
=EVAg
-----END PGP SIGNATURE-----

--eq8ubVNQqZtXyCWs--
