Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A80C54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE02587F69;
	Thu, 14 Mar 2024 01:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V8IvEn60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C87B87F40; Thu, 14 Mar 2024 01:39:35 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8A587E3A
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c1e992f069so235386b6e.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376771; x=1710981571; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1/M22kfqYVgd5ChtzS9tWWFpuCJ7C02BlofAQycu0mE=;
 b=V8IvEn600itU8V57X9n7pS8t1MNRxhPa5iNuG/bkJbujZofESoAxxomJOMDYU83RmA
 xWTJF84CCNOlkbWYCAHYfwUh4DRSGEYEKjfYwKRz4PcCA8y0/Qrmxc0Sz2Cz5AJ3MRsG
 fTIib58QmQmeGFwiczAnoNMjTtp/K6O9Nv1QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376771; x=1710981571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/M22kfqYVgd5ChtzS9tWWFpuCJ7C02BlofAQycu0mE=;
 b=B0Mx0ALcLr5m0p4n1xvAZR5sDi527I/4oxFXPicxM1fYxnB3SvmRgoPaoq3y7bV35c
 qgRtRSIvIsPnOKHZwgAvDIFaWsOkZaRRQp6ZjhG+9vFQUIlwgwcN39kZpInJ/104tj1W
 1HdEsXb66vjynpy6dhs26uEkC36g2jW/gnfIJt45iu8wZlhbGZ8ABFQKF9MPVaYJVGFC
 tkG/SzB7WCLp2INkkv3B2Ly1by2rcWk3JTIHDtth6CeGKpqdY8kwkqHZApQAOwPVhx+e
 S3ijHPEpcCTCxtupZIXOWkKAkFXxVQ8iwfiWcbB9ScZap8/YGJFsoWHhpM1Nd0pgk/4L
 BozQ==
X-Gm-Message-State: AOJu0Yw+XtkykgupSr6afvPN9oc1ZcOu5/3soBG3O1P8Hye5y3cxSKJd
 7H2ntIbH6FZwzTJDKg6RZjbJuqJCaCcPoO/5Nc99guJ6/yEy4uBKFL96L+AtXuoNdiIvaFyie3I
 p
X-Google-Smtp-Source: AGHT+IGJ51/OWzCAWo4xBj4jLJj4cNU1sPO3X/M+6w0/fdauqEzR8BNV3nwOoGa1c2e90y2TNwVdBQ==
X-Received: by 2002:a05:6808:16a3:b0:3c2:3716:19a4 with SMTP id
 bb35-20020a05680816a300b003c2371619a4mr345255oib.9.1710376771690; 
 Wed, 13 Mar 2024 17:39:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 u26-20020ae9c01a000000b007883bee099fsm173816qkk.22.2024.03.13.17.39.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:39:31 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:39:29 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] boards: Remove empty BOARD_SPECIFIC_OPTIONS
Message-ID: <20240314003929.GJ3442575@bill-the-cat>
References: <20240304152617.1993764-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6kABD8KaUlbTgXJJ"
Content-Disposition: inline
In-Reply-To: <20240304152617.1993764-1-trini@konsulko.com>
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


--6kABD8KaUlbTgXJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 10:26:17AM -0500, Tom Rini wrote:

> While there are currently uses for a stanza of "config BOARD_SPECIFIC_OPT=
IONS"
> followed by "def_bool y" and a series of select/imply statements, having
> this option set followed by nothing else doesn't provide anything.
> Remove these stanzas.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--6kABD8KaUlbTgXJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyR0EACgkQFHw5/5Y0
tyx1bQwAoSf3cNOxPKc+EqU9qIgHEW+yrO/XmN/SWqlhx7Hc5kVdaQ7cb0oZrQVo
2FOpqSG4zesPMiVd5gEMMA9+xDOuJ5Rd5HDJoj7rohpMeGhMIOfPuFaPogO5JHSF
HWUTGmiRZVipMwTci9qRv1suOwKw6YjT0P2UE/EX4dvh5gk/GX17b2ybKWIxC2yc
ykL+CL++f4pzg3OWx8B9kns6tc3r9GtOw+bQN9GcGN18ULT/cCWljooob5Vg7hlD
RMmm2KxkNYdK7Fur2hTeVH8A0f1+Ly74ktCgLYycofjsz+wD3lgOensHUq6NKitO
qK1qUltTN0ZRvf8FPo7/vWjONLde+dAhkdTeJFcEnr43A8SK2H+bq6GwNaZZZaeo
7K2cOUZs4idF/y0vP21gqM+QkpiHJPf7Ud4IIPCN4/GjnZTn8BABmTeNEf63Qt09
71y/tDR3/2VcDm95Pbqx25Ii1P+QnT1Y8h18L6sUt8eMwkBZM6JTSoxkZpyua32S
YuQib12L
=Pez0
-----END PGP SIGNATURE-----

--6kABD8KaUlbTgXJJ--
