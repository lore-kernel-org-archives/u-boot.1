Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E16C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E183484009;
	Fri, 11 Apr 2025 14:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G0cM0sbC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F3E83FEC; Fri, 11 Apr 2025 14:47:58 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECFE82B72
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D47CC6845C;
 Fri, 11 Apr 2025 12:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AD0C4CEE2;
 Fri, 11 Apr 2025 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744375674;
 bh=HqxJF4ReUYdkR7t7o12yu0VWuVJ1uITLSg4394WFm8I=;
 h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
 b=G0cM0sbCE8Pe9q6WnFWAMaHgHEmnZm3X+nrPWjWcqavrVGkAtDKWDATzHujwThlz6
 A2vg7xh8UIc5g0uhD3eTzGvxjnR6g2J/8P8Bx4psn2FMC4T5Q7TDZKR5vLZHm0eWji
 YP9en/0hCVypF9u9Ztz4UdSDY3euisirAMRAmawVbkstttZyDVnjQ8NL6ROliBxwTC
 IIWxnMVxLShtkuZxvvkUqVUET5WxZpMGiwtXB3L2zMzSiB9eImYVCMpfOCZE5jSN+a
 VYeBND8d2ihHX9ApJAzAjhukCQc1QfRxU4kk4sjAPgErQkHt+0eC0RkUi6+IQkkNHk
 r7GEHm0fjQiKQ==
Content-Type: multipart/signed;
 boundary=6771cf4be3169a0f319f86493834889ac54d346c72bda068988e6a04c8a0;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 11 Apr 2025 14:47:50 +0200
Message-Id: <D93TKGBEXZD4.284M59TUI3SHQ@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Nishanth Menon" <nm@ti.com>
Subject: Re: [PATCH] doc: board: ti: Add optee rng support
Cc: "Udit Kumar" <u-kumar1@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <d-gole@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>,
 <j-choudhary@ti.com>
X-Mailer: aerc 0.16.0
References: <20250410132746.8168-1-u-kumar1@ti.com>
 <D93SWXVH3Q9B.32OUNLRBRTKQW@kernel.org>
 <20250411124308.ujiyfbtwyrlrx5hf@devalue>
In-Reply-To: <20250411124308.ujiyfbtwyrlrx5hf@devalue>
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

--6771cf4be3169a0f319f86493834889ac54d346c72bda068988e6a04c8a0
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > J722S has hw rng, which can be used by OPTEE.
> > > So remove option to use SW TRNG by OPTEE.
> > >
> > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > > ---
> > > reference discussion=20
> > > https://lore.kernel.org/all/20250313144155.2382316-1-mwalle@kernel.or=
g/
> > >
> > > Bootlogs with optee trng=20
> > > https://gist.github.com/uditkumarti/5f90210b23e67cd4eb6d06a024031ee8#=
file-gistfile1-txt-L1970
> >=20
> >=20
> > I can confirm the TRNG will work on u-boot as well as linux.
> > Thanks!
>
> just curious: Did you have to change .configs for either?

We are using the (arm64) defconfig in linux, so no.

Regarding u-boot, I don't know because we are using our own config
and I had to enable CONFIG_OPTEE there (as well as
CONFIG_OPTEE_SERVICE_DISCOVERY, but that one is default y).

-michael

--6771cf4be3169a0f319f86493834889ac54d346c72bda068988e6a04c8a0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ/kPdxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jqMQF7BqY+rPs5Z03SgGFnXLEOy1PbJlWfrnnc
ZZ8chOjZqND88RRwIxQ2nSBQzvWO/bpLAX9Ec9YADEEOelnwwCs3ZZweDux0CfJl
Ibk4N8O0/WthZgizqJx79cOtOBFahIVdryo=
=Rdxq
-----END PGP SIGNATURE-----

--6771cf4be3169a0f319f86493834889ac54d346c72bda068988e6a04c8a0--
