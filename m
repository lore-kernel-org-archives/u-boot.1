Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E42C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C9A87650;
	Sat, 16 Dec 2023 19:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aAR45m5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54EB087721; Sat, 16 Dec 2023 19:29:32 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C7B875D6
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77f50307a1fso135272085a.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702751368; x=1703356168; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hA6FY0js//mciPZ25aOMweDgTd9I0Ur/6mQ3FvE7IKY=;
 b=aAR45m5dAUq9xyelTmfgZN0veLWL0roJ/iZ+wyICH8gvSvwlJ+wFUH5qf04CjhEtf1
 2CC3dypHJiVROAkIPk34/xRGAhv80FaEv/UcR+G9MRO/Erv8f4T1keXbV4FJdxgkNhue
 kQfEd6SjdjSOzq6eAwJ5OpNXWarhxY3rXeijc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702751368; x=1703356168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hA6FY0js//mciPZ25aOMweDgTd9I0Ur/6mQ3FvE7IKY=;
 b=MMGYKea8/UwesJ3CZjSHVQ7qZYceqcw2GzVaqGq53bJ/jpsGRpbdMuLVGZ+NJJ4bOy
 RQcHKW1UfuOGcV5dkm4uOLLcJsGBxgdzlI/dmLtD48vm3lOgBtsTlKOT2OGvnbrZBOPi
 2Zw/26r8o4cPE7SijsCFFD3RGyHH+GHd+4DsyIWZo0cKQRprr+gW7TfFSFJT7s0c7mUm
 Kge6j48++4UFRKNFhd1Y4g3uLABymwbmP8LGpiJbcaj5GaamdHHZHk66bIm0ORujTjAO
 qEcuR6jBp7iV+ij3mCpIJosICj3QbZmL0uFu0GzlWsvhf6TTJ9UiUPLXqYKgP3MWI/7q
 Cp3g==
X-Gm-Message-State: AOJu0YxvgI/eue2OUFnJtRBFNB11JWiGS1bjbjLHvhfRL/N8vQYk9xHo
 0E6DCFZDHFhgS3SHXcauwDBe8UvjoHZGefDCf8g=
X-Google-Smtp-Source: AGHT+IHZk5qGcJPX3B3GGQm7LwwRAAvA/E2IQJ1FSyGjK/eAof32XUFNOlaWc93GKkhiSktTHuOZwA==
X-Received: by 2002:a05:620a:29d6:b0:77e:fba3:9d24 with SMTP id
 s22-20020a05620a29d600b0077efba39d24mr16636804qkp.136.1702751368617; 
 Sat, 16 Dec 2023 10:29:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a05620a0ce900b0077fb3fca44asm1173825qkj.95.2023.12.16.10.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 10:29:27 -0800 (PST)
Date: Sat, 16 Dec 2023 13:29:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] arm: Add OVERLAY command to BSS section
Message-ID: <20231216182925.GW2513409@bill-the-cat>
References: <20231216180842.173422-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kPj98AGEDdFRIMMD"
Content-Disposition: inline
In-Reply-To: <20231216180842.173422-1-marek.vasut+renesas@mailbox.org>
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


--kPj98AGEDdFRIMMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 07:08:22PM +0100, Marek Vasut wrote:

> Avoid allocating and loading the BSS section.
>=20
> $ aarch64-linux-gnu-objdump -Sh u-boot
>=20
> Before:
>   10 .bss_start    00000000  00000000000f21d8  00000000000f21d8  001021d8=
  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
>   11 .bss          000068f8  00000000000f2200  00000000000f2200  001021d8=
  2**6
>                    ALLOC
>   12 .bss_end      00000000  00000000000f8af8  00000000000f8af8  00108af8=
  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
>=20
> After:
>   10 .bss_start    00000000  00000000000f21d8  00000000000f21d8  001021d8=
  2**0
>                    CONTENTS
>   11 .bss          000068f8  00000000000f2200  00000000000f2200  00102200=
  2**6
>                    CONTENTS
>   12 .bss_end      00000000  00000000000f21d8  00000000000f21d8  00108af8=
  2**0
>                    CONTENTS
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/cpu/armv8/u-boot.lds | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index fb6a30c922f..25838b9892c 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -151,16 +151,16 @@ SECTIONS
> =20
>  	. =3D ALIGN(8);
> =20
> -	.bss_start : {
> +	.bss_start (OVERLAY) : {
>  		KEEP(*(.__bss_start));
>  	}
> =20
> -	.bss : {
> +	.bss (OVERLAY) : {
>  		*(.bss*)
>  		 . =3D ALIGN(8);
>  	}
> =20
> -	.bss_end : {
> +	.bss_end (OVERLAY) : {
>  		KEEP(*(.__bss_end));
>  	}

This is, I think not sufficient. Looking at arch/arm/cpu/u-boot.lds,
seeing the comment about overlay ordering (and that it needs to point to
arch/arm/lib/sections.c not bss.c now) and looking harder at
arch/arm/cpu/armv8/u-boot.lds I don't know what to think at first about
what's going on here. My guess is that what v7 has to / had to do for
relocation / etc stuff back at the time is just done differently with
the v8 infrastructure (and possibly v7m).

--=20
Tom

--kPj98AGEDdFRIMMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV97IIACgkQFHw5/5Y0
tywK5Qv/bMRJXUdqE+NSP+pgJgocB4Nm5rBSb0S4MthXWq5ZLV1pRnwaEww05u4j
rzp03bPIA05lT7Zv5Tiv4OpKfmbYzSs7yISWez7a5QNmf1WXeNoQ4T7mRVs6QG2U
AJPDyU6iZv0FphSMf+UvzbkVowHxaVK0JTu6VSjZTcI4nXLybna7cguwVM53+rNQ
8QbrTTC2F2sAcASbU4EyclkFWPpqQ0b5MbLAOFPAK96tGCXurfGhcOAxOGfXMjCm
kfPBlhLCp2Tu7aLoyer2B73mbHGHWSwyNZxjd287kvg0d3/TWsZb1qY9sv4OSg93
dxeQMTfwimU95GWJcWCybmkH+/aiq+sGkn++YBqY+kE7aueaEI84fh+6QkHf+Izr
BXje4s74K/rJLXoFH8MvOG+25/1QtxbWcrMORrOrNDnNXFLdOHu068jpUf7X2W+D
2tPratKXkYOQyH3n4tIrV1l9MwG079OwyQDKZxXQBVwmCIife6sEqwR/TDrw4wq9
vxa8Xz/V
=Rrdc
-----END PGP SIGNATURE-----

--kPj98AGEDdFRIMMD--
