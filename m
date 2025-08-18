Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C35ACA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 15:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB8D801DD;
	Mon, 18 Aug 2025 17:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SjbfBRYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE9580548; Mon, 18 Aug 2025 17:43:46 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C938C80107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 17:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-435de818a74so2364020b6e.2
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755531822; x=1756136622; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KJMexpDzgdOuSfiodXflyqp10fxyzFXxbbdqMurAQls=;
 b=SjbfBRYZ0j7BrRgkkkJLLwRqAKyOoNpK6e22L+N8gOy5EX6tjrxCLrUFttJ9r1CLPr
 TEADDdG6369EjXdlZ58tQSMN3DvVHlm3glT4BJkHhcd5d/83JUxueOm8agLGplC6Tyod
 plKGMBbAJd7lyvZSSjxvPMUO3WY8UbDqVukKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755531822; x=1756136622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJMexpDzgdOuSfiodXflyqp10fxyzFXxbbdqMurAQls=;
 b=mE4EK9jeXTsLSDu4KqOKcSzg3p6RV0SxyMWDS941LOt/3UqS8NVlU2+B4gmSeOPK+l
 xU8hbAtT5/LH5jqdQ5WpTYB6vS4fF2V02/hd46GHghdOzeodrolptXMxNWHU0QTVz6Pg
 AyPRfqbO4w1C72oKnVxG/TKrCSNue4QYSWpnrS7qUWkLrQwNyU4ew06AY5Y2kgFQfBDh
 gjCPElOq/rnXqeeivqKU6sAWDM/t6a+JdGvg8cRCCEjGabJImPRQPE+gsemi0chkQA83
 zYtxCjZyaWrGBf0aDBzYI5tZ3DeRq29SL5PyLuy27RhVgsapdeo8xEGLDq7ESxj0eUa6
 h6iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8mf6V76RkZhm0yudP17h8YDnuDUfwEwK69k6KfkuSmQbHW2R6NLFH0bnNgwfoS1eNosN4jCk=@lists.denx.de
X-Gm-Message-State: AOJu0YwkK1WTo2xG95mb7TgLWobiV41u7ZMCc34HKRVS80zzo1dYR/91
 O57pOpFcPqqxGGumn5PwQp2WeZxKxuC3ElTZMaWQo4KAdhtN5WM9Gij1oonfceDeg70=
X-Gm-Gg: ASbGnctnI6LWyarf+caHqZaOrTHTideFI4LW6+l5VMvy1WkAwi38yPikIkgjHEJ1SD5
 pBwu6IMBCfG+Yamvs1PGzziWDluqiQLlMK4w91Em+eb2teTD6Zljmi3Yl/yyLh7mPmcypZfaTqt
 ZvSM2w9X3Wi01K6RApfZ6HIC2XF1DCMDhlSI30LGeZhmDwWr/ZzR3YvJbcEvbsLro7qNQak37xc
 n/vZnGCyYwajt0+OGlmOhFB/I97slQnPj4omrkeZ5GAJwZNysApY19BZWeMvuXGkjcsKb+EuT2Q
 iQIe1ZekbMdHqQXuC5knG3Vealtepc3snu5sVI8IjJRmJ8WqWdPTIQ8IyMPcyQcNBpC1P5xOcpd
 o+RfRftvHZMuIZS8d6phfFD343gYNbyJEy8yyh64r0eRXr0AMCjy6n9MumsftbU2r2KE=
X-Google-Smtp-Source: AGHT+IG50puyV/IvwrZcLhc2slmp89T3kC79mRly9MR56Qg+k6QA7BJqctjpqqxFJvth1Be1hCtBzg==
X-Received: by 2002:a05:6808:1828:b0:40a:fb27:9e8d with SMTP id
 5614622812f47-435ec3b4229mr6911005b6e.15.1755531822535; 
 Mon, 18 Aug 2025 08:43:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ed1e7721sm1821026b6e.25.2025.08.18.08.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 08:43:41 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:43:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 David Wronek <david@mainlining.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] ARM: dts: pxa1908: convert to OF_UPSTREAM
Message-ID: <20250818154339.GY124814@bill-the-cat>
References: <20250816-pxa1908-upstream-v1-1-6bd5ad032021@dujemihanovic.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I7AHjCSRacny6kLt"
Content-Disposition: inline
In-Reply-To: <20250816-pxa1908-upstream-v1-1-6bd5ad032021@dujemihanovic.xyz>
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


--I7AHjCSRacny6kLt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 09:35:19PM +0200, Duje Mihanovi=C4=87 wrote:

> Convert the PXA1908 platform and its coreprimevelte board to OF_UPSTREAM
> and enable the few drivers found in the upstream DTS.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> ---
> Important note: The PXA1908 DTs were merged into Linux during the v6.17
> merge window. Thus, it depends on the v6.17-rc1-dts subtree tag being
> merged. I'm sending this now just so that any eventual feedback can be
> addressed in time for the v6.17 release.
> ---
>  arch/arm/Kconfig                                   |   1 +
>  .../dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi |  20 ++++
>  arch/arm/dts/pxa1908-samsung-coreprimevelte.dts    |  74 --------------
>  arch/arm/dts/pxa1908.dtsi                          | 106 ---------------=
------
>  configs/coreprimevelte_defconfig                   |   7 +-
>  5 files changed, 27 insertions(+), 181 deletions(-)

Given how far off that is, I would recommend that once v6.17-rc1-dts is
tagged you use tools/update-subtree.sh and "pick" the required commits,
then say this patch requires those patches applied.

--=20
Tom

--I7AHjCSRacny6kLt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKNKJAAKCRAr4qD1Cr/k
ClDwAPwISeUbwlANsVLm6WZRR6RsqCaFEAFHvyD77aT42CIecgD/RI0lPDz21eD8
H51AeFboRQL5szhGZsZ7QCpgCnUW6g0=
=Q8U5
-----END PGP SIGNATURE-----

--I7AHjCSRacny6kLt--
