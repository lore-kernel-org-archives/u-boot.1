Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246E2C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 14:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659F182CBB;
	Thu, 19 Jun 2025 16:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dzDA+Ske";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9E582CEB; Thu, 19 Jun 2025 16:13:38 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39B6882BA1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-400fa6eafa9so544478b6e.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750342414; x=1750947214; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cfNsK2ZjLuk6pJcZR6JWMI35rFUEQEqa4dKsuzk/Vyo=;
 b=dzDA+SkeSNtclvYWgdBfKlX+A4nk6lQOlyqj8ux9EOR8Y7tOyR8kKItYld6daosU0x
 MvluA1YHwXe6sxWtCRVT2bKYb6sLh/dtAOo/wou6+6ahxFc9nfXUV9Sm2XIU1xR4Jzj5
 KeHzoe0Z2F3dqOEJzrjSqKAxXN3SdswYF6Fac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750342414; x=1750947214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfNsK2ZjLuk6pJcZR6JWMI35rFUEQEqa4dKsuzk/Vyo=;
 b=a5mSJ0ozHiWH/BBmmXpRVtje0efUyn/ivxbZPhVEXhk2WG2iVqJEldnTwjenwqJWqs
 3/t4Az9SfCGxFV4hjMtMr5q9V0/xTTH2c//pT4K85/iHkVQziySYZ2kOLKp4IMKwiCzY
 P049I5roCB6yYD3B8yhgzDisB3obbBOUp3jiUwVYoGELlh5qypEdPkcha+m/LxVtBqik
 hTfk/tahT4X8gi/CdfiNOjSHl6kr7trM4ME2OC99cIacQ7feW8C6g3jH0q5C/Caux8hF
 Eigk97GZMzyQFY/cDnHCGnE3FC6EG5PU2b1YRzBdoE10s+QkRsZocbSkEteDJ2G600FB
 lIgg==
X-Gm-Message-State: AOJu0Ywr9J0Fa4VkYaSmhyXjSoJb8sVSUylthRBA1YT+SlzOB0Fg+h7l
 TtkmX+IQLNNLaSwrxdFvjxyW7yN61reg3LlHni22Dqu65rkxflejg/5Mh6Mx8zBcsm0=
X-Gm-Gg: ASbGncv8nB1SiqzlNLUFpXzTYfiiJk0anb86DRaYQSBlMwPYRT/OVsu8cqZG6ApsBE/
 ZALR0yR6hh6MXMbC3z2W9FIR84oRm7JLuKj4GRf+dDc6jKfoGh4rUrLDNjFm9d8t6BV5r9kFsAH
 nExgxTnSiiCPIYbCPyMmh8ssGruXaWk3U49n2wzz3aSR4PrtaZOQxWGqsCPyRC5miSyHgu7ur5b
 YvRR4o2tVmr4of6KCOlxxiECF51VYI3fcQ8uvOY9KGE4UxOsYbSrQiSX//U1pFeU1NamKDFOOZO
 0toV+u5QFMEG7T0405z76XyJiAYwrwmk02UO29OvL286Kw0vA7hLNSitNUEF4LkAbIvZu7N5hPx
 tEMI/3huaTlon5kZ/+eyKVQreozJimhxqWA==
X-Google-Smtp-Source: AGHT+IEmYEUudBmmiOBW8HzsJU+H+xDtFiAVZpwYUpQh+MDs5UNNAiDG+5zm7ckSrBGDFkfPNBKsTg==
X-Received: by 2002:a05:6808:2203:b0:403:34b3:c986 with SMTP id
 5614622812f47-40a7c1e0eacmr14848299b6e.17.1750342414423; 
 Thu, 19 Jun 2025 07:13:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a740c2306sm2777551b6e.11.2025.06.19.07.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 07:13:33 -0700 (PDT)
Date: Thu, 19 Jun 2025 08:13:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH -next] test/py/test_mmc: wrap multi-argument printf-style
 strings
Message-ID: <20250619141331.GL6521@bill-the-cat>
References: <20250619-mmc-test-fixes-v1-1-1eff87dd69db@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dpkiSfvy2ALn4v1t"
Content-Disposition: inline
In-Reply-To: <20250619-mmc-test-fixes-v1-1-1eff87dd69db@ti.com>
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


--dpkiSfvy2ALn4v1t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 06:45:05AM -0500, Bryan Brattlof wrote:

> Newer versions of python will emit a TypeError about not enough
> arguments for a format string:
>=20
>     FAILED ub/test/py/tests/test_mmc.py::test_mmc_dev - TypeError: not en=
ough arguments for format string
>     FAILED ub/test/py/tests/test_mmc.py::test_mmcinfo - TypeError: not en=
ough arguments for format string
>     FAILED ub/test/py/tests/test_mmc.py::test_mmc_info - TypeError: not e=
nough arguments for format string
>     FAILED ub/test/py/tests/test_mmc.py::test_mmc_rescan - TypeError: not=
 enough arguments for format string
>     FAILED ub/test/py/tests/test_mmc.py::test_mmc_part - TypeError: not e=
nough arguments for format string
>=20
> Add parentheses around all multi argument format strings so all
> arguments will be passed to the format string
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Nice! Does this mean you're also running these on hardware somewhere?

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--dpkiSfvy2ALn4v1t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhUGwcACgkQFHw5/5Y0
tyxd0wv/ZTmkSV8b1i20LGLPHEUeOA2e+E42ekfKP+2W8cPpdow+y8p5qbDu6cdv
B+z4bHgWNSwWvV4+J4YF/qDfpFjHgBEPJm1n4HXrM28PCNKyewCJaeEOI9MDBfea
I6hjIgqk5o+Nnn9Kg6xbviEYCVYHeO27NPvyWKduIS+fWZSDxpPmc5n9qJ3CYzOO
ZG+j31AHPoxib8CVIniZofiEor2AeBweQxLp8RgaE+7wjfax2xXYGXqPhPpjweB6
qSRqr9QozYD8G1kX0fW7n8MmtxYd71h1qFPKXJX/QWQ96kNpaein52HfppDkUp0Z
4mxYUaVuysvCZBDs9/F8SPJM62K3yWabZ72XcUuM1R2ao2YtneWYDbd1v0ys/lJ/
kXeqXDJ6J1qt0iTMhJBNdGCJxlNB+2RZtu02PnOQrFWd3EAes3+GqCQv2+Zh8vLO
SVO1CLyca4QZ89hsvmaRsMgeam2P5g0MNyqwl2J3rhv/ZOxPQb9sxgxBkbYd+Tsq
G8eYOiWR
=cVdV
-----END PGP SIGNATURE-----

--dpkiSfvy2ALn4v1t--
