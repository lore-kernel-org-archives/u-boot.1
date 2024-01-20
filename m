Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6005C4725D
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 00:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D40EE87CAA;
	Sat, 20 Jan 2024 01:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ogoOPKKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B0787CB7; Sat, 20 Jan 2024 01:20:56 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F161287BC5
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 01:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dc202317415so1086916276.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705710052; x=1706314852; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qRGgXgbJb6dngl7MxaqZElGgfEkIBf+eZxezKCqoPE4=;
 b=ogoOPKKV1TRQtWJB9DKuvFtj0ODSLDvBsJuk2x787leYidlEQUhuri80hDaVyOtDq8
 pVMrpC/uBc6Oi2B5yud3L3kYx9sskzHb9uwtlr4f1sCEY9t4cA5+GQN4oKGlvfmftKbb
 R4AVp0muHwgCgDYr3j/8E+oe9lgfWZESlfZm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705710052; x=1706314852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRGgXgbJb6dngl7MxaqZElGgfEkIBf+eZxezKCqoPE4=;
 b=WOjdzp6u7600xFKFVi9do6mBotd2wWS6JcsHIYlnoASB5TkjMNCPsOynm+t5usScN/
 8dXYVdPh/LQBx1qm5nxHwRfe1O1WgL/ZMTvdZR5PQYCA1HaM86N0KdzA9ZcoT+QZRGUs
 u3NIadJCvDnP5Z7/JLPnONVtzcA2M57iPxNciTl3rjlM7mXFFZhXjja9RLJqQTAJSBI7
 KlGB9AnZSN5loQHb9okNJdV3d6/G9twKdGgDZQPga6p8iv06/J7Pqp72f+fDsgiC6d23
 SuptXxYdy570eu/NehBOCtppQ1Cz91X1LCLb9FF2e12Rmgs35roTvdp8h44EYgws7WTI
 vVHg==
X-Gm-Message-State: AOJu0Yx9mTINIl2eg71th8hd5pGxLu0KjfpGJccA6ncVkCNByyXbk5m3
 RHXALCEHduj5mQ8EbRRjS15Ejl2oP5UQsFuAqRa4bb3GqhUu+t3Y4LJZpGbwAwY=
X-Google-Smtp-Source: AGHT+IGbIS1Ggy1miahMW7uPmXEYyPIH+JWpndWA/mviNb2Hw0Xg+J193Ikeen1MAteYV1hFtQ4JqQ==
X-Received: by 2002:a25:8e06:0:b0:dc2:66ad:74c4 with SMTP id
 p6-20020a258e06000000b00dc266ad74c4mr595178ybl.100.1705710052537; 
 Fri, 19 Jan 2024 16:20:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:3119::1004]) by smtp.gmail.com with ESMTPSA id
 u11-20020a25840b000000b00dc218e084fbsm110254ybk.28.2024.01.19.16.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 16:20:51 -0800 (PST)
Date: Fri, 19 Jan 2024 19:20:49 -0500
From: Tom Rini <trini@konsulko.com>
To: kleines =?iso-8859-1?Q?Filmr=F6llchen?= <malu.bertsch@gmail.com>
Cc: u-boot@lists.denx.de,
 kleines =?iso-8859-1?Q?Filmr=F6llchen?= <filmroellchen@serenityos.org>,
 Bin Meng <bmeng@tinylab.org>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/1] riscv: Support building with Clang
Message-ID: <20240120002049.GO12635@bill-the-cat>
References: <20240120001405.29294-1-filmroellchen@serenityos.org>
 <20240120001405.29294-2-filmroellchen@serenityos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f3BO4y9cCnmZvhc5"
Content-Disposition: inline
In-Reply-To: <20240120001405.29294-2-filmroellchen@serenityos.org>
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


--f3BO4y9cCnmZvhc5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 01:14:04AM +0100, kleines Filmr=F6llchen wrote:

> The -ffixed-gp option of GCC has an exact equivalent of -ffixed-x3 in
> Clang.
>=20
> Signed-off-by: kleines Filmr=F6llchen <filmroellchen@serenityos.org>
> ---
>=20
>  arch/riscv/config.mk | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/config.mk b/arch/riscv/config.mk
> index 9cf2aef0a4..dc4f30d673 100644
> --- a/arch/riscv/config.mk
> +++ b/arch/riscv/config.mk
> @@ -9,6 +9,9 @@
>  # Copyright (C) 2017 Andes Technology Corporation
>  # Rick Chen, Andes Technology Corporation <rick@andestech.com>
>  #
> +# Copyright (C) 2024 the SerenityOS project
> +# kleines Filmr=F6llchen <filmroellchen@serenityos.org>
> +#
> =20
>  32bit-emul		:=3D elf32lriscv
>  64bit-emul		:=3D elf64lriscv

We don't have hard and fast rules about adding copyright lines, but this
seems a bit excessive.

> @@ -25,7 +28,12 @@ EFI_LDS			:=3D elf_riscv64_efi.lds
>  PLATFORM_ELFFLAGS	+=3D -B riscv -O elf64-littleriscv
>  endif
> =20
> -PLATFORM_CPPFLAGS	+=3D -ffixed-gp -fpic
> +PLATFORM_CPPFLAGS	+=3D -fpic
> +ifeq ($(cc-name),clang)
> +PLATFORM_CPPFLAGS   +=3D -ffixed-x3
> +else
> +PLATFORM_CPPFLAGS   +=3D -ffixed-gp
> +endif
>  PLATFORM_RELFLAGS	+=3D -fno-common -ffunction-sections -fdata-sections
>  LDFLAGS_u-boot		+=3D --gc-sections -static -pie

A quick check shows that GCC support -ffixed-x3 as well, so we should
just use that in all cases.

--=20
Tom

--f3BO4y9cCnmZvhc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWrEd4ACgkQFHw5/5Y0
tywWRgv+JzsxXebD36xUiAYs7leKNN71usfXgD6ZOJ8cI670Se7l4mxNwwOeNRou
//N8sjCaR/m6STW+xjO66+UuQOrCog4w274YEsI0o5g0/RqdAyeW7T5m+TVZnfsJ
7PDR3elJH9OZiZUZbwy9BbFFtsKn2JVWVaaW+QIuGQi4K4I6TrqpuBXut7Y1p9sA
IUtruqrQnbWTS4MSOfLmeocqpnsR0jLxslcraomlL5/OVVWf9hHWC3CS6tXjwD8A
zb9DZ8QbgfwWhQ1iW5m7ADkHXqYVQjF/jwE+CSL/gbJ2kMcTiwZXUgnP/2J4bOa0
ynk+W64DPl5hibTncMuSa/zczgOL4x593moprb3bG01A3lJiuW+0KgJeNU5P83bI
qkYknwfTgAv7HJbQjaxvpbsBdtBfGtJ0sYc1F2Xi1ubSbzk45kNAGkeQW9ywzuHB
/PuyxJcrGWtUlygbHanllj2TNP2A9XeIMCzEJ4D2jCOXeRkljO2AYtODHdPfgw3S
4P6Itv/7
=nA3B
-----END PGP SIGNATURE-----

--f3BO4y9cCnmZvhc5--
