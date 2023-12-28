Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9DFC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 12:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E650F87A0B;
	Thu, 28 Dec 2023 13:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SelAGr0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5AD86FFD; Thu, 28 Dec 2023 13:58:09 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 690BB87995
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 13:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e74b4d5445so48590627b3.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 04:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703768285; x=1704373085; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=amGZzSpLKwTB1scP384G40wOwvm2zayj6NHN4DcVBeM=;
 b=SelAGr0G/+Nr/96dlTsNJY9jGqlpC8xped47B7Mgu/U3GCEU0CyfWscBVc/VEJM5WM
 dZBJ9N6ys4SZFW/8cBu3Ni4vJ7Xdh5C/VgcSpesLn+Raktf6YT+bEnX0K+y3qCMBcyI3
 i0FLd6RPoIZVO+l9E7gC6gIYYybCYmW0xTZik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703768285; x=1704373085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amGZzSpLKwTB1scP384G40wOwvm2zayj6NHN4DcVBeM=;
 b=jmvyxU2KsbIKMHNHem7z2+HbhNPGv/2xrI1vKsVmjK6a+D30tgWmY+KOx5z6mvuVgW
 dLrJevmHuplcgp5dZO8n4cZj8KgY9a46Bv1uhiBgwjo4KtqOrxKw1ssNAPE9pdRjfLcO
 XAk6KjpP7OnCQ6HcqZFl8j3K1hl8yQt0u028x1VUuBgpVjGIea4RXdo+VqmffsfdCZRk
 dVZdDpw4v8gSWH/20hiPHyNO+3EX0Re7VzewzTMLEQ5HTtk1AzTo/i6ea1OlLzGzlLsH
 ++5zhGXcMW78VK9P/jK+4gFpi8Z+fnne3NKbnbTdoHanSdYIMSJzZ3xPIePhqz5DKdbe
 67JA==
X-Gm-Message-State: AOJu0YynJw7y4RpQp2k/qV4+05mxlExVOq3Hgsvfgtzt1679W0qB1t7e
 1ZwQxEPJBdDK1L6Zx18YlRLPQMOmwdmzvw==
X-Google-Smtp-Source: AGHT+IGivtlp0J6uDiVS/Gf3hInJCMufR2yO20/iIEwDO3PD3U7VhdvZIpbe2s9+gAPkZZCgLiccTA==
X-Received: by 2002:a81:b503:0:b0:5ee:6ad3:b0b1 with SMTP id
 t3-20020a81b503000000b005ee6ad3b0b1mr1837524ywh.4.1703768285190; 
 Thu, 28 Dec 2023 04:58:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 u124-20020a0deb82000000b005de8c10f283sm7348864ywe.102.2023.12.28.04.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 04:58:04 -0800 (PST)
Date: Thu, 28 Dec 2023 07:58:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de, mibodhi@gmail.com
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Message-ID: <20231228125800.GY2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aqwKPGuxDCKaGK1S"
Content-Disposition: inline
In-Reply-To: <20231228115804.3626579-6-sumit.garg@linaro.org>
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


--aqwKPGuxDCKaGK1S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 05:28:01PM +0530, Sumit Garg wrote:

> Encourage SoC/board maintainers to migrate to using devicetree-rebasing
> subtree and maintain a regular sync with Linux kernel devicetree files
> and bindings.
>=20
> Along with that add documentation regarding how to run DT bindings
> schema checks.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Thanks for the related cleanups in there.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--aqwKPGuxDCKaGK1S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNcNUACgkQFHw5/5Y0
tyxeEQv+JFUxK6fePvqRO08hexX80jvOaBwfjxYnsT4M5kTQy1zmldJeqm5ybhuS
SaKtxdU2UPK7cOmry77gHOaEHN5tEZ4GU1vl8G0FumPrpe95xY/vtNkgEStpudHS
eLUV4mTfhS8MAe9QvEOIiDygaZLm8pMEdHtM/liW2t0N9QbD+WZeyNrxyguy++N5
1+XIg/7kW/m2XB9i40u+YdOeA9Le+8y1qPoWj647t/Mk0SPDd03lp2vF8zNnb9sb
jv7fD1GsD20n6qVp6pBulFGPzbmAtbMWqB2qVIsiN6RiKn+8yFSGdaLSNO2JdtPV
kqS3XCD6N35/kszkmMF6GZO674spcoj/bYPhnDSUGM2pt5FidBNC4fPGOfDo4fnY
8aQxK4XMioVZ6WV8dI+GJiuzGbNo+xH87CApDqpNuXvY9p9RrxRWxEmmfoliFMFv
Wz3WXm5b1swfYE18MoFRJOJeJ4v55YKgnL3tcf+rAPyJDnh8COtn08aIgQh92Vnx
ouf2mUGj
=+12a
-----END PGP SIGNATURE-----

--aqwKPGuxDCKaGK1S--
