Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035C3C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 15:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE1382B07;
	Tue, 10 Jun 2025 17:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e87gEiA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F33982B0E; Tue, 10 Jun 2025 17:34:00 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6418A8004F
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 17:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-735a53ef4feso3568007a34.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749569637; x=1750174437; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W3ykbZw3ITnzdiDMshIs3yUE1SJqwbBHRf6YJfTOqWA=;
 b=e87gEiA7GGJw/75QqoHAvUXDvL3gibE3QGcki0a6l4YlJfgddJyCqLLHTFhsSGTVr/
 anTYb/G1EpISXvuEXLbFaO9vsLJuW/0zim1ESeGFIkTLqua8szyLX+V9VVvsBfOdKs95
 16OpXZMv0nsgegq+sdcNCuQRKshquF6shYUWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749569637; x=1750174437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3ykbZw3ITnzdiDMshIs3yUE1SJqwbBHRf6YJfTOqWA=;
 b=qyLffFo7vsmZYOYN8LjqPoC7Bt3XKeCs4BdJu9ApgEjddlmbz9S1jVKCtIi9nYDP9U
 2NZTd5dHj6ZkJuXVcCq+GgtvVKol77SeuzFe8pGSHB6qjlnNf+wpyYO4mPyenyJ+6WiV
 KHeAFseii/4nlzZPV3PZVS8ucBB9ISF9T6hxfCMD8lFiGbPa9zg0R4uKPZShItWMZErx
 9H8yS36ig+cl7ja6z3HdQ3OYuOB8C8T1aPq5OgYYKfhKZsb5C0AakB10d9ZtL/xiKCUD
 jQP64U8Wpj2InDDwOWfGSQLPSLrk7lDXBFBlbRyGvW8iS5+/HXMuX6nqlzSMAy2c2tQc
 TSNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/UPMKNqY+cz3XhsOi1QIlHCdwlW7f5SBP4uEHCKCf7coiFCnGYBk5UTwYIr85iwZWfnL3y2E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9yU/VAi23QxTBL3PQtOsD/FJYpUIE8ibzvhQuDrbFs68KGXaq
 xv7DHkC+aO9nZdLpMrkNNrXfu2bRoMkmtdMDtNToIpT9gWJy6dBKTHTLOy2DgkHthTkRcSoMVgf
 JkFqrgOA=
X-Gm-Gg: ASbGnctU6BI7mLkZZoYFCRnzswY4vlP2TnaGtfWQwVf6ZnzSc5+kw42ICRwYFenQ/mH
 faVz8ZxfMdZS+QgY8Yd61Bn7rpKOMbPQ9GAXtMUstWmCQgVghdjvywdslXDzn/3NnaFkw2K5Yqn
 7KWqdVuekrC03cz0ojLUJGDFvefz9sU8xH6jdGbXA5T3hdg4EgIY1F31+7O5RkLVNhidKgvwtjs
 nPByoIgwEwRdXvkvbzbVrINK5/Bm2qNyv041lFhiAN82qF0D4Ssaf1vyjQgztqQMUX/BD3DOsg5
 7BTqd3dkqZfIH5vblL43LL2PUYEY+q26IG/0L3guydeiipH1RPdkCiypomdNhnrrS42WxZ9uXEY
 I78K23a+XTQ7HTJV+kOunA9I=
X-Google-Smtp-Source: AGHT+IElQuE7kNxodnajJ4MLsVtzu6QTFBJveiTcGeGNUHU4BKJzyHvEZU7eGoRZrNOZQrrQi24Zcw==
X-Received: by 2002:a9d:70ce:0:b0:72a:1626:21e9 with SMTP id
 46e09a7af769-73a05a2bba0mr28098a34.10.1749569636835; 
 Tue, 10 Jun 2025 08:33:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-739f85d9b44sm373049a34.64.2025.06.10.08.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 08:33:56 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:33:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: rick@andestech.com, ycliang@pr-suspensions-neuweb-biz.expedrion.biz,
 u-boot@lists.denx.de, nazar.kazakov@codethink.co.uk,
 joseph.baker@codethink.co.uk, fran.redondo@codethink.co.uk,
 lawrence.hunter@codethink.co.uk
Subject: Re: [PATCH 2/2] riscv: byteorder: add test for big-endian
Message-ID: <20250610153354.GC1382132@bill-the-cat>
References: <20250610151850.1673111-1-ben.dooks@codethink.co.uk>
 <20250610151850.1673111-3-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="In7PDtzsu6ji0hAf"
Content-Disposition: inline
In-Reply-To: <20250610151850.1673111-3-ben.dooks@codethink.co.uk>
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


--In7PDtzsu6ji0hAf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 04:18:50PM +0100, Ben Dooks wrote:

> Test for big-endian either via __RISCVEB__ which migth be
> rather old, or check the BYTE_ORDER if the compiler defines
> it (which should be any modern gcc like v12)
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/riscv/include/asm/byteorder.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/byteorder.h b/arch/riscv/include/asm/=
byteorder.h
> index d26ac5688fa..3140c1f585e 100644
> --- a/arch/riscv/include/asm/byteorder.h
> +++ b/arch/riscv/include/asm/byteorder.h
> @@ -26,7 +26,7 @@
>  #  define __SWAB_64_THRU_32__
>  #endif
> =20
> -#ifdef __RISCVEB__
> +#if  defined(__RISCVEB__) || (defined(__BYTE_ORDER__) && __BYTE_ORDER__ =
=3D=3D __ORDER_BIG_ENDIAN__)
>  #include <linux/byteorder/big_endian.h>
>  #else
>  #include <linux/byteorder/little_endian.h>

What's this look like in the linux kernel? We should likely just mirror
that.

--=20
Tom

--In7PDtzsu6ji0hAf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhIUGIACgkQFHw5/5Y0
tywKPwv/cmjRh99yD45o7echPYH+qx9EvpQcBeFUBowSOqfm8saufuBJejUmXauQ
j2CmJzbLKJcDaVRIL7BXea9AwdnD3uitsA0HsCta6tzV8XRPehnwRrQfsNi3rZI3
ANSxiuniCi4HXhLfN5dURH+NgAKC3d0v7mzYVAVMRr5HIsQtTF2jnP9CXZn5o6US
Q+QqB50zfXBZaTDulZ95AwRlBHktWUNQlpgUOUKgmxzG0OwzMZeklFXgw7GgVBBB
NOQ8CrhxV6CHI0i9ZVs9X0moCPytCh/ZadR+karOhM412cQT4nZWqhthmdBjP8p3
xetemhx99Z3iP/PuAnL6V9xRpXK8UVm7wmMHaF/Uh9y2EjpW/EMS+skEktOaJDnH
3ajc66AhPV9wKqU5Zelf2PhQQKRsws4gSgFH4cseOg7rrtcFhDoCGySRTJBwlOd5
XWuMTryYxe788OvEHpSffQnVrv1VQJuN9gzH6BBqITBbWKJgepGls2KzyB7Ws0/a
sY+BVRwP
=OHcx
-----END PGP SIGNATURE-----

--In7PDtzsu6ji0hAf--
