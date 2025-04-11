Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12207C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C37F83FBC;
	Fri, 11 Apr 2025 14:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rLwpi+xq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14E3B83FC0; Fri, 11 Apr 2025 14:17:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0158183F15
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 41B864A4DD;
 Fri, 11 Apr 2025 12:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88700C4CEE2;
 Fri, 11 Apr 2025 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744373834;
 bh=DX4eYAiOorvVkUl9VLGRybBMvtTYNW7dRsxlRsZPf2A=;
 h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
 b=rLwpi+xqq2elGKrI6vF0nI7jA5mWWPwiSG6I/rwD5zv/TeuyYwjNWXHG81GawacNg
 esefBlxzUGUU8VayfLcAZr+jaJnAPIQYINNGv6gV0mES15P1PRmassojo0V80iPpsM
 6aykJyzU4PYQU4qCdOIRU+KZ4Pr4YX4eo5Kw9EeXwqq7WebSbra/ebZb2/RiYeEEE0
 qUVF4CJsvBAXvt/YImPjTNIPUYeQ2Fnc+p3t7FKWXJYBXXQvbx8U3rNSG7u+hSAGh2
 j3j7CjTnboMHMaB/gRxrJusFbZPQRBNt/QiKcNJA1gOlxiQTuCOu4kezsWrtxsjR+G
 BMwuN8R/iEQag==
Content-Type: multipart/signed;
 boundary=e5685b43c3e0b110f4f4ae6cbdee6356a124ab05bc56fa5c6133b69c6e18;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 11 Apr 2025 14:17:08 +0200
Message-Id: <D93SWXVH3Q9B.32OUNLRBRTKQW@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Udit Kumar" <u-kumar1@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] doc: board: ti: Add optee rng support
Cc: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <j-choudhary@ti.com>
X-Mailer: aerc 0.16.0
References: <20250410132746.8168-1-u-kumar1@ti.com>
In-Reply-To: <20250410132746.8168-1-u-kumar1@ti.com>
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

--e5685b43c3e0b110f4f4ae6cbdee6356a124ab05bc56fa5c6133b69c6e18
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> J722S has hw rng, which can be used by OPTEE.
> So remove option to use SW TRNG by OPTEE.
>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> reference discussion=20
> https://lore.kernel.org/all/20250313144155.2382316-1-mwalle@kernel.org/
>
> Bootlogs with optee trng=20
> https://gist.github.com/uditkumarti/5f90210b23e67cd4eb6d06a024031ee8#file=
-gistfile1-txt-L1970


I can confirm the TRNG will work on u-boot as well as linux.
Thanks!

-michael

--e5685b43c3e0b110f4f4ae6cbdee6356a124ab05bc56fa5c6133b69c6e18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ/kIRBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gnogF/XCLjK9wdAidmAUQzMOcgcCAT7pChZFg/
9Pe2TLJG96MsO4EQGuQWDuCRSVMQP2fdAYCZKBMV/FpTIWy9IZazH1aIRqJlEc7j
qLgrz36aVQ/g/IeffL0M1PNCYrg71+KJje0=
=0m5Z
-----END PGP SIGNATURE-----

--e5685b43c3e0b110f4f4ae6cbdee6356a124ab05bc56fa5c6133b69c6e18--
