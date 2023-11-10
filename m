Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DF6C05021
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 17:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D970D87750;
	Fri, 10 Nov 2023 18:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DLuqcGsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69AE68778F; Fri, 10 Nov 2023 18:48:55 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA0468725C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 18:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-da2b9234a9fso2422207276.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699638531; x=1700243331; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rMcVyvOtXOCKNMo3g02kW1LS8dXmR2jQVNBqEvljDnE=;
 b=DLuqcGsz18k252dY/HtADUZBgAsPhCeV5Dj2bUHdQ6pqWrxdIrJ0knCxIK+lnloqf/
 bJp2myGY/HQv8EKk9AjxWbPys74NRWiIZYNFUZgI0BHiUquZr56pk237qpkxFEj+7Mjk
 z0vKQ18BDcg9XEzt8ACByh6bmXXyRNwcb9uTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699638531; x=1700243331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMcVyvOtXOCKNMo3g02kW1LS8dXmR2jQVNBqEvljDnE=;
 b=W6/Wt7uFBBNURG6XcyKUW1kcaxD4lqcNyUjPFc43zs9LSrCmbT3CVdWJtLrYr2yQbP
 mpkR7Y3MffK1VpzVTLYa0q7gwCkmDNDD2vNngyoiNugUeZOmP/KeYYZtakdbdwvGBB9c
 2EMQMxz2fA7QF7pEfjyhnarWOtqz0mqQuMabP9FQpJZNOlEZxedJoLNRC9r8jehyhQUy
 XVkfd5q4Suru0UO40j1lJltV8POM7GKJ8P5Qa7MsDThCU2AOI3r2WehoHGCHafe27sWs
 taAVZCilQPRXzEmEJlWjO3O4mV8GBAIFVyBOKqkal24T3Zc6pR4Xy8lwaozaPQA3+WPM
 GqKg==
X-Gm-Message-State: AOJu0YxkbatjwAgVmBLD/z4kHszpLgRch/pChdI+DVnBOh1u1fTaIzgX
 CY9rWnRi3GzpOYeeHFqZJDealw==
X-Google-Smtp-Source: AGHT+IHXa5xs0ASkPTE1Vjd1FA4zgVUALNueOVQS54Oloa6umQh7h/RmoJB6hj30YLO1FyPdhUbYPA==
X-Received: by 2002:a05:6902:1503:b0:da1:5a1a:e79c with SMTP id
 q3-20020a056902150300b00da15a1ae79cmr9631961ybu.50.1699638531581; 
 Fri, 10 Nov 2023 09:48:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 s5-20020ad44385000000b0066cf06339bcsm11854qvr.0.2023.11.10.09.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 09:48:51 -0800 (PST)
Date: Fri, 10 Nov 2023 12:48:49 -0500
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, dphadke@linux.microsoft.com,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v4 0/5] Populate kaslr seed with RNG
Message-ID: <20231110174849.GA3794716@bill-the-cat>
References: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fTg+aMe8L2hXY8k+"
Content-Disposition: inline
In-Reply-To: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
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


--fTg+aMe8L2hXY8k+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 11:38:39AM -0700, seanedmond@linux.microsoft.com wr=
ote:

> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> This patch series creates a common API (fdt_fixup_kaslr_seed()) for=20
> populating the kaslr seed in the DTB.  Existing users (kaslrseed,
> and ARMv8 sec firmware) have been updated to use this common API.
>=20
> New functionality has been introduced to populate the kaslr using
> the RNG.  This can be enabled with CONFIG_RNG_TPM_SEED. =20

Please run this series through CI:
https://docs.u-boot.org/en/latest/develop/ci_testing.html
With the whole series applied I get:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
_______________________________ test_ut[ut_bootstd_cedit_base] ____________=
____________________
test/py/tests/test_ut.py:503: in test_ut
    assert output.endswith('Failures: 0')
E   assert False
E    +  where False =3D <built-in method endswith of str object at 0x7f8536=
092ef0>('Failures: 0')
E    +    where <built-in method endswith of str object at 0x7f8536092ef0> =
=3D 'Test: cedit_base: cedit.c\r\r\nCannot create oftree\r\r\ntest/boot/ced=
it.c:27, cedit_base(): 0 =3D=3D run_command("cedit load hostfs - cedit.dtb"=
, 0): Expected 0x0 (0), got 0x1 (1)\r\r\nTest cedit_base failed 1 times\r\r=
\nFailures: 1'.endswith
------------------------------------ Captured stdout call -----------------=
--------------------
=3D> ut bootstd cedit_base
Test: cedit_base: cedit.c
Cannot create oftree
test/boot/cedit.c:27, cedit_base(): 0 =3D=3D run_command("cedit load hostfs=
 - cedit.dtb", 0): Expected 0x0 (0), got 0x1 (1)
Test cedit_base failed 1 times
Failures: 1
=3D>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
FAILED test/py/tests/test_ut.py::test_ut[ut_bootstd_cedit_base] - assert Fa=
lse

And the problem is in one of these two commits (one does not build by
itself leading to this bisect outcome):
dm: core: Modify default for OFNODE_MULTI_TREE
fdt: Fix compile error for !OFNODE_MULTI_TREE

--=20
Tom

--fTg+aMe8L2hXY8k+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVObP4ACgkQFHw5/5Y0
tywlhwv/cRRu5XWydWChx5+Sem0SfjqaK6RY/jXJOdZP3p93xbOE6NRpjD5NLZn6
cGrvvk3UoEjZRbiU3X7vwWGgLcJgknzFPOubO27Ccj4s7dg5W5ezkkpPycSU8Oyg
H0v1h81hBWiyUx8kAoHgunGaEAZqfwUPaow6qe2yXZuQscfG98pJoiSFosXwJOjB
NmaxeQ/ZTC/LifjU26gF7BXAVcXJnoq7sHhnjMi8epA78B4S0P8BO8SI/aM+G8bm
g5HL+qYQ1UClMmY5Pkd2g+B5oT3vDEv0c6DNICW4k63qO4WWvolL4YHKkdPsM54K
J56Y4BOIyDBffLJzav37aP7wv6TEz0BmIQYeqt1Qgic7F8tBPmUCRzlNM404zfsv
Dga1ifGWL4VrECXoe8jLxH+6AhXRA66/8PRFuTwrVg504/+TFbbKiho6s0oxps/x
bRbCO5/RecLg2DQXfb9j3EbiUzBWQRcTKcivTBzNirhwxgndLyogVYbVaf1qBAEq
5R//FGqq
=uTX0
-----END PGP SIGNATURE-----

--fTg+aMe8L2hXY8k+--
