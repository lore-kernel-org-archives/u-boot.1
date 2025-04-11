Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA808C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F752840E6;
	Fri, 11 Apr 2025 16:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D3TsJ+D7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A850840F8; Fri, 11 Apr 2025 16:49:39 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3496840D8
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3fbaa18b810so604887b6e.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744382974; x=1744987774; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sYH/Nf8+r0PPt9IeTdWBAAjIeizISv3Ae+srHmJQfSQ=;
 b=D3TsJ+D7ewJGdbtty2QeZpZNLcoWvGWTS7EMe2Qjy40VzDA5G0AHydcUeJ1rDeiIZB
 KQxVqP6DiglfIJsVzomTPhzXXY2GpJy++SjkArgFWazNDfP5hqXwgJZC3H2sJ7bhVpnT
 kgVenHt9s0R3jwvGJaoiTHAjE4KsXVlApTkXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382974; x=1744987774;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYH/Nf8+r0PPt9IeTdWBAAjIeizISv3Ae+srHmJQfSQ=;
 b=KvXDgHi4cELW3LKttuEowAFK2EtVaa4Kxpj1Jo52eCyXGh2QaMjessyKymW1GR6Poa
 Psmh//4zHLqf7cEvrKAtx6SdURTOV1SfV08f+LGvkPO8R+pwUiJNLyVFyIgETV8i0nmn
 PubT53tsNa0SjRbBCWQKBMj+iJBTGpaoYmFVb5xot0aC1yvXjELwSzG3O5Ap208RoRBQ
 nbaVGCbkSsG6+6WOEcOHkuCKq+qfMvoFdnFUtbUap/7/YXdi0JI63srnBsl3/clzu6Yr
 CxvJR2BWF7+ANAF1nRCU/FZbtJlSxRMNTgnELapcQHFQHkICxhsG4DnjZAUBcYcXIvBb
 rmbw==
X-Gm-Message-State: AOJu0YyQGuUt76oBG55QCqNdYQHX6iDQwynmrhuYRqk1REJrHf2bySxI
 FvZ/NgpvdHO1ZQOu7TDItOX6YicYrPMVwQJeJtwONANtL4woUggfbQv1pOv3boHJcDiTTSBxRj+
 eMic=
X-Gm-Gg: ASbGncv0UyeZ5PPe737es+W1oGNF229xF3bbCcVfn1uQAO5rpvnMsmRdT/z4RUwOY21
 Z6ngcZAwV3K3JZYNunDDH71L8RU/aGVGHfB7jP0Tlq0Eb9PW+IxNVmgWN8Sp0VtqccqkCSOvrMh
 VzTjn3L+K/8iX26gnlANlzEH+NUYanuvMnu7Q2Z666VnDSVa9C3dz6a7m95uhDaEwYubsfA82UG
 rMSNvzw0Qn4E+4E3pa1vp+O/HvpEdgbajCpxZbE5SAi1X9uEHgfSAPauTHd217AwzFx5Q3NpYJ/
 3guulQQaZkW1pwU2wCULW8DVsDs57FVjcMa3OF4yCN+CnrvHGYDGf5kXr2DYDxT+09lLQdVj3sv
 7wg==
X-Google-Smtp-Source: AGHT+IH0irLLW5XrbV7ze6GcA0zR6zPbu5VH0q+tQqNOxvSwEe4JqKkBLqWd7ZF6vq/gzPQlpt+vRQ==
X-Received: by 2002:a05:6808:2188:b0:3fa:d6c:cdbe with SMTP id
 5614622812f47-4008510b686mr1764954b6e.32.1744382974684; 
 Fri, 11 Apr 2025 07:49:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4007639dfd1sm955480b6e.31.2025.04.11.07.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:49:34 -0700 (PDT)
Date: Fri, 11 Apr 2025 08:49:32 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?xaMg1r7vv73vv70=?= <Zone.Niuzh@hotmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] bootm: Support load images when os is elf
Message-ID: <20250411144932.GN5495@bill-the-cat>
References: <ME0P300MB130922F2666257BD3431535C9FAC2@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1oxMCf/Hq3m3VDm+"
Content-Disposition: inline
In-Reply-To: <ME0P300MB130922F2666257BD3431535C9FAC2@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
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


--1oxMCf/Hq3m3VDm+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 07:44:34AM +0000, =C5=A3 =D6=BE=EF=BF=BD=EF=BF=BD w=
rote:

> This extends the bootm command to allow find images when os type is elf.
>=20
> Signed-off-by: Niu Zhihong <zone.niuzh@hotmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--1oxMCf/Hq3m3VDm+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5K/wACgkQFHw5/5Y0
tywk+AwApgh0tLvHlF6Zr4v3LPv5ENY6rCR1+IjSMb6i7Kr8FmkAw+BoZHcaP3Jd
vumZpwPrAJTKppjBGus7u1q1WPsIJtWTDMasp2gNPmi1gSoSmHbOzIsncm2yGBg1
QHfM73/Kd1zdnhoIk+HXzrvAZyVXnSrEIVhBlZk3EQ1L03drLcystB8GhPJytoNP
mYkPFFlPUpSYl17yeaea6oYIDMc7iX2m3nzjrbbTnyuvuaKLMF84JvDveqjRQVuC
aMrN/ftO5wjzsw3nL4TJHv1gw3q4ikrLdON5WF9vzi/lstdN6+PgbqkUVUwgyyc7
myGlZPGEWpAFU1VUkz5QpZiX1UXo10rLd+G4jWpijB+QU+juG6juEvO24DGrwq/U
nouwVz6uISG4s2hySjXAszdnZkz1GdCdf9Iq+WUHv5VTVAaZZe61Uev84eO5CiEF
PVkSxEbGvi6Oxv4R6Qd6Epr1Thl/NjmvJSe1zeUFe8O0LEgi6jESZtn+/r//rcCl
HfsKx4hb
=6si1
-----END PGP SIGNATURE-----

--1oxMCf/Hq3m3VDm+--
