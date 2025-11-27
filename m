Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61760D116E2
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 14:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE30D843F9;
	Thu, 27 Nov 2025 15:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZZ3Sb5O/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C307843F9; Thu, 27 Nov 2025 15:23:04 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B19843EA
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 15:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-450154aa53fso345513b6e.2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 06:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764253380; x=1764858180; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yC0rZGyLTfkrRBcukpq495siWtsDntZooCypY9fODkg=;
 b=ZZ3Sb5O/wx2HeK3gy1JXi4nSEvxnN3KkAZKtHE1JCeFNnGmw24RHT78S5Ehw8TaJqa
 FdRBjPFFmyONwDy+7Z9bqrxJWpdFLUxzUmgGDRTWr4pUlfiN8FrdSOVHLkjkIeWY/+VD
 P+jb+B577AxWaiUa+ChoQzA5h4rohDBARVjLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764253380; x=1764858180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yC0rZGyLTfkrRBcukpq495siWtsDntZooCypY9fODkg=;
 b=pz+Y+R5MOOEZHNzkvfQ1cxLtxR0GhOKsiCqU/toH4M7YbcORMaiu5NzzjgUCfI+zm4
 Moipma2gPoe7N2K71PxBMa6UElmxr8dZ5cUCLTk23a8Y4L2yPdiYdE6XuGI11UqgeuCT
 kx//vJ97Q4k025J69hQlQN7ZpGcQuUoTFj5O2qmEvWgwL4NnIywogw8c2vMlHyfo+YYs
 /IgKdrZqcwFTW8VhTOPJQezrR3eXZ86j4d9NBM7NYN1WhZXh/1CfRYtkqHh0LOWgNMom
 FEiw+/WpVSJlMvtlWrdg2HqfQH/Vp4lE/B23kSl+xFjJJNu0nZdGuuKGWgmBxn9oyQEW
 C00g==
X-Gm-Message-State: AOJu0YxwJK9q/nXnsRy3wxM0t5oMYbGkIJUf1CFb2Xj1qx6pxKE//alR
 VY5CWm8a5qm9rNuCr95zuP7IRsGkbGrLJ0l9iYbpjMvKzDChSLMAqL3horG8LXhtFd8=
X-Gm-Gg: ASbGncu4lLcuQ9ZshJMAjqRyhsXX8lkGOSCF9ltntpSEtzbDmgQKFXAg+tmQNsRT+0j
 5luHjVa+Lky+kgpOMZpG99pxBonc4jGzxtRhZS+fl28DXLWL7iupYSQBsuOUp6wBE1d0pkfYxZ6
 IX8uvSojpjDOJKCRg07svwVUP2b6vUA1/M5r6IEc84XU96J4bZ7pGKmdqFBF5vuTX1eeDTKYz8h
 Qyr6VLNmzDC2yqUT2dgkAcD6vCDmI3xq/KtdP+652HSSVn+LFC66pgeFYNfULltNYT7qgNF3mtj
 24UNC144+PXOUCBU+nLH2VUx8VZ/tup5Uk8BeQCBwJeUUo2vlq45+FKMsk9iJfehjsXjz4N6k8B
 1TBEF406oHx2OBlJbtzmiPL/t67lCRGGxeeX+gDZIO+9lmWRfJKa70LWBkW1iGNgeHPzEZCNfM6
 qOSjBZvIOME7Ig9PDcHtkExHJ+GCP6MwzhbCF9UUI6f6+w4SsJtA==
X-Google-Smtp-Source: AGHT+IFwDK6uEidCP5x22H9UtJ2+jS18JFx2/CGwZ33kiD4wbTyop02bZxT+hhVSasUFeVyfq9A6AA==
X-Received: by 2002:a05:6808:1a03:b0:450:4b0e:becb with SMTP id
 5614622812f47-4514e65d6dbmr3995597b6e.23.1764253380168; 
 Thu, 27 Nov 2025 06:23:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453170cc9desm400410b6e.15.2025.11.27.06.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 06:22:59 -0800 (PST)
Date: Thu, 27 Nov 2025 08:22:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH v2] test/py: nand: Add tests for NAND flash device
Message-ID: <20251127142257.GW2125796@bill-the-cat>
References: <31a29623e90b44d0a80886f8d17540a2912e7d24.1764239161.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q5AEsjmgwyJQzfxB"
Content-Disposition: inline
In-Reply-To: <31a29623e90b44d0a80886f8d17540a2912e7d24.1764239161.git.love.kumar@amd.com>
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


--Q5AEsjmgwyJQzfxB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 04:06:04PM +0530, Love Kumar wrote:

> Add tests for nand commands to test various NAND flash operations such
> as erase, write and read.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
> Changes in v2:
> - Fix the deprecation warning issue for invalid escape sequence
> ---
>  test/py/tests/test_nand.py | 201 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
>  create mode 100644 test/py/tests/test_nand.py

Since we're adding a new test that requires configuration, I'd like to
try and add the docs for it at the same time. Please see commit
8f8f0f0ed9d0 ("doc: pytest: Document the test_net_boot test") for the
kinds of changes required in the comments for the examples to be
rendered correctly in docs (and when doing that commit I build and read
the docs locally a few times until it looked right). Thanks!

--=20
Tom

--Q5AEsjmgwyJQzfxB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaShewQAKCRAr4qD1Cr/k
Cmb7AQCN9Eolor0zJg4ux6wWVOZ0oDZeEWiXv0gARkeFuW0NwgEAlQYAlUKgg/v3
TmVPhqF9pDMgH9cFzTQXgYEJO4eQ9AU=
=vZmg
-----END PGP SIGNATURE-----

--Q5AEsjmgwyJQzfxB--
