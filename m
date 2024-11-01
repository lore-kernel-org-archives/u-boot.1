Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CADE6F091
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 21:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF9688E14;
	Fri,  1 Nov 2024 22:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CE+u3s6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D2C588E24; Fri,  1 Nov 2024 22:46:13 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF748880B
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 22:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b153047b29so170012585a.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730497570; x=1731102370; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WaffSH/mhHVE+k2BdxDp//B4XQ4kzipqwyIhT58GIOM=;
 b=CE+u3s6VFoBB/JJ4qp+iV+00akBB3keHjQprJzhChgpi1fSoeNTiozja9TSVfmr+eL
 0/DAbS0bdXBKgFpdbRklsBBS5GGNw9h/cyG6D16Lx/n6oRgwiAfDxK3whxwPR7FbVUc/
 7JBqM8VDz3U9XJO1MaoRubc2TdrS4DcFfDPLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730497570; x=1731102370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaffSH/mhHVE+k2BdxDp//B4XQ4kzipqwyIhT58GIOM=;
 b=KXaDC50qWRzV7z/mTTKsIsz/RbroWe1I0TvM7Ee7gicqasZ1/HtfHnCT7C+jw7ySrV
 lF4y6q18oH2NO99TEXj9GJH7VAUR4POdEu4zFDnFP8bJYTFPcei4ofgvahdhp9h9sb5j
 BxVH3IF2OExSqDGjD3Ahfi3UTIASnUw2njkwHiZVL/4HrSXSk76pRZyisEp0mm1uVIVX
 rOHNiP2VSKPG3hPWguKAyVE5ASFXGViocrYevPKGC5/rdCGuQdKurbmFnDqxlbA/nhWb
 fMQIRQHflIewHU99BYaGspOmwIsw/aobn+TAy+BAFXvV2r9UHAUeZFL17FkfyBK2MRFY
 Sa8A==
X-Gm-Message-State: AOJu0YxiODycnkG0EqIk7YAktd0JbhPGJFBPG5ZNzbIL5MS0JuylsCEa
 5iIsEcLPcUNfYQrZHF3eBfLoBe8YMASZkjwJyI1tdl09Hl86yhOoPbuHP3ytGpQ=
X-Google-Smtp-Source: AGHT+IEAxY0EbYiNsB3aFt8PNOPLZSOij6FOHUe3xzK2Ziz68eUcfbV637pq/GkJjv3FbuvNByj7Cw==
X-Received: by 2002:a05:620a:44c6:b0:7b1:5f49:6c10 with SMTP id
 af79cd13be357-7b193f5d452mr3456147485a.63.1730497570154; 
 Fri, 01 Nov 2024 14:46:10 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a81ab4sm207203085a.112.2024.11.01.14.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 14:46:08 -0700 (PDT)
Date: Fri, 1 Nov 2024 15:46:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 01/21] bloblist: test: Move test into common
Message-ID: <20241101214605.GA3767858@bill-the-cat>
References: <20241028124130.32072-1-sjg@chromium.org>
 <20241028124130.32072-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WNM4pF7M6/ScjSUJ"
Content-Disposition: inline
In-Reply-To: <20241028124130.32072-2-sjg@chromium.org>
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


--WNM4pF7M6/ScjSUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 01:41:06PM +0100, Simon Glass wrote:

> This test doesn't belong at the top level. Move it into the common/
> directory, to match its implementation.
>=20
> This also fixes the build rule for the bootm test, which was depending
> on bloblist by mistake.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  test/Makefile                | 3 ---
>  test/common/Makefile         | 3 +++
>  test/{ =3D> common}/bloblist.c | 0
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename test/{ =3D> common}/bloblist.c (100%)

On rpi_3_32b (and presumably others):
test/py/tests/test_ut.py ss....F

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
_______________________ test_ut[ut_bootm_bootm_test_nop] __________________=
_____
test/py/tests/test_ut.py:592: in test_ut
    assert output.endswith('Failures: 0')
E   AssertionError: assert False
E    +  where False =3D <built-in method endswith of str object at 0x2bfcb0=
0>('Failures: 0')
E    +    where <built-in method endswith of str object at 0x2bfcb00> =3D '=
ut - unit tests\r\n\r\nUsage:\r\nut [-r] [-f] [<suite>] - run unit tests\r\=
n   -r<runs>   Number of times to run each...elated commands\r\nprint  - pr=
inting things to the console\r\nsetexpr - setexpr command\r\nunicode - Unic=
ode functions'.endswith
----------------------------- Captured stdout call ------------------------=
-----
U-Boot> ut bootm bootm_test_nop
ut - unit tests

Usage:
ut [-r] [-f] [<suite>] - run unit tests
   -r<runs>   Number of times to run each test
   -f         Force 'manual' tests to run as well
   <suite>    Test suite to run, or all


Options for <suite>:
all - execute all enabled tests
info - show info about tests
bdinfo - bdinfo command
bootstd - standard boot implementation
cmd - test various commands
env - environment
fdt - fdt command
hush - Test hush behavior
lib - library functions
log - logging functions
mem - memory-related commands
print  - printing things to the console
setexpr - setexpr command
unicode - Unicode functions
U-Boot>=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
Tom

--WNM4pF7M6/ScjSUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmclTBkACgkQFHw5/5Y0
tywhOQv/ZIdbEr5mEKnptXTfTJJRnOHHSv909R4mzz8Ly1c47tCzauazH/JmrWgT
Z/sNP3KnU8uolSBy2nldJhMPNsEDs2YcJsyLJ4XO8XrcCWcqdi03ymV94L+YiEWv
x3Tz3Gj4a5aZoi01OB/ZUvLmoIu5ifzrmXc3XbcYC7Ooj6U1Pxz7eFasIUIWCPfZ
e3m2eMb2Ge/r0liYoUpk6h9f/pnTozkhW00tCeQ0pQWyntHm3n9+34oUW4phmsDu
3kGf6v02b7YHUzN2E4lVCrHF+YiVn7IMnTHcB7UDnzs8OAmOF8oN/rctvJ7VEoNa
124u704dyOxgl5z8w43BmaTQccLBoWQ8P+7NUfAfNuUYhfFlsxxvaYyWZNEil6gt
rqO0+5dbx03L/drMS/GDI1h+pCqpvvQnAIlq3rfAeUgX/FBuAJJWgOMjhc3HaRrq
y67H0Jgg/7nBHJQwUodjNwOfEJF9nUOD3o4tQ14UwB01HYzEuK2yGTiAtUfNwFAB
h2peJ78f
=DQo2
-----END PGP SIGNATURE-----

--WNM4pF7M6/ScjSUJ--
