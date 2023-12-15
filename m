Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F6BC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5982A87BB1;
	Fri, 15 Dec 2023 14:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JvYEVAX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13EB187BB9; Fri, 15 Dec 2023 14:32:18 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55DB87BA2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67a9febb2bfso5065636d6.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702647134; x=1703251934; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I4noflrnYFEA+IEs4LK2Bni9Qn0ioB0CZs4WU/BoleY=;
 b=JvYEVAX64u7qu0XDz2OxUsQ5M1ngIbUOGBUGodYvM4itRHfhRhhcsZEPZqMZhGl5sF
 ia/VyXoKb/FZpTSlYQmYKa5usqkM4My8gRUffB4Mv2cCEmuf1GH2LZjEW4crieMIQcbg
 k5iKuBn0tlpyYqLFPfse0AfJg8Wsj9AuaJkiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702647134; x=1703251934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4noflrnYFEA+IEs4LK2Bni9Qn0ioB0CZs4WU/BoleY=;
 b=r/t9dcX/FVonG/wSNUQ1ALG+gm/iPF52oSO631hsNvel5l8zcYFVHtZY72oa+VcdXR
 Pxy+h9KkhYYBo0wZ+y2n6I6AQKVpj6w/wYe5cAIy8jXBvm0383rBnrIM0rKrBs1dppxc
 gJS+25+Jufrlq/FJ/Tbkm+uGvkxH5D5daVAczS8iNPhWtU+LGSXN3I0xj7WP0Sfj0RjL
 RqSLBystxGrop4nY7NpbYs7g3E4eCLxPbytKyAp+2MVk9x9pLeCBUVEgNbCuMcKILhiK
 5Ue7FrL49HuNuGIOMOEOVJFzI1EwYOXXmCCfVQC8CupnPUL/CflsblL/jOQGnLYybfJM
 gJEg==
X-Gm-Message-State: AOJu0Yye+LHD2u0IWVgZxPYx5P3YU48mYvbQNDVmgQoNX4uqtq8YQgaQ
 LzP3zxVKqfViHn+uuK2jUpLdIw==
X-Google-Smtp-Source: AGHT+IH7cnMz4IeZEoLFJG+Truk2GDXe0BQnDQ6/e4BxJ2paRuY20hjBQazJ6+3cuW0ZAidGOGJigg==
X-Received: by 2002:a05:6214:2508:b0:67f:3ee:4f65 with SMTP id
 gf8-20020a056214250800b0067f03ee4f65mr5516363qvb.11.1702647134561; 
 Fri, 15 Dec 2023 05:32:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 v10-20020ad4528a000000b0067ef3341c77sm2589311qvr.39.2023.12.15.05.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:32:13 -0800 (PST)
Date: Fri, 15 Dec 2023 08:32:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Prasanth Mantena <p-mantena@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, sjg@chromium.org,
 alpernebiyasak@gmail.com, matwey.kornilov@gmail.com,
 jkridner@beagleboard.org, robertcnelson@gmail.com,
 u-boot@lists.denx.de, nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com,
 a-nandan@ti.com
Subject: Re: [PATCH v3] board: ti: common: board_detect: Fix EEPROM offset
 read for 1-byte
Message-ID: <20231215133211.GU2513409@bill-the-cat>
References: <20231030170458.21668-1-p-mantena@ti.com>
 <9f562302-3fb5-4b79-acec-5bf6f201f29f@ti.com>
 <20231215062519.5yb2x7ecek2imrbu@uda0496754>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j7iivRrMH0ocPAzp"
Content-Disposition: inline
In-Reply-To: <20231215062519.5yb2x7ecek2imrbu@uda0496754>
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


--j7iivRrMH0ocPAzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 11:55:20AM +0530, Prasanth Mantena wrote:
> On 15:15-20231107, Neha Malcom Francis wrote:
> > Hi Prasanth,
> >=20
> > On 30/10/23 22:34, Prasanth Babu Mantena wrote:
> > > EEPROM detection logic in ti_i2c_eeprom_get() involves reading
> > > the total size and the 1-byte size with an offset 1. The commit
> > > 9f393a2d7af8 ("board: ti: common: board_detect: Fix EEPROM read
> > > quirk for 2-byte") that attempts to fix this uses a wrong pointer to
> > > compare.
> > >=20
> > > The value with one offset is read into offset_test, but the pointer
> > > used to match was still ep, resulting in an invalid comparison of the
> > > values. The intent is to identify bad 2-byte addressing eeproms that
> > > get stuck on the successive reads.
> > >=20
> > > Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read=
 quirk for 2-byte)
> > > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > > Tested-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
> > > ---
> > > v3 <--> v2:
> > > Improved and concise commit description.
> > >=20
> > > v2 <--> v1:
> > > Fix inplace for the else condition of CONFIG_IS_ENABLED(DM_I2C).
> > > Improved commit message.
> > >=20
> > >   board/ti/common/board_detect.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_d=
etect.c
> > > index 9a53884c98..869f7a47f8 100644
> > > --- a/board/ti/common/board_detect.c
> > > +++ b/board/ti/common/board_detect.c
> > > @@ -128,7 +128,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int b=
us_addr, int dev_addr,
> > >   	rc =3D dm_i2c_read(dev, 0x1, &offset_test, sizeof(offset_test));
> > > -	if (*((u32 *)ep) !=3D (header & 0xFF))
> > > +	if (offset_test !=3D ((header >> 8) & 0xFF))
> > >   		one_byte_addressing =3D false;
> > >   	/* Corrupted data??? */
> > > @@ -180,7 +180,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int b=
us_addr, int dev_addr,
> > >   	rc =3D i2c_read(dev_addr, 0x1, byte, &offset_test, sizeof(offset_t=
est));
> > > -	if (*((u32 *)ep) !=3D (header & 0xFF))
> > > +	if (offset_test !=3D ((header >> 8) & 0xFF))
> > >   		one_byte_addressing =3D false;
> > >   	/* Corrupted data??? */
> >=20
> > Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> >=20
>=20
> Can this patch be considered for merge considering no further comments.

Given the "fun" of the various beagle families I think I was still
hoping for a tested-by on some of the corner cases they have.

--=20
Tom

--j7iivRrMH0ocPAzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8VVUACgkQFHw5/5Y0
tywmmgv/YOW4YpvvTRlOQhVrhDKoxLpZYvkysO5CnDjEzE4M3WjXRatklk6ke7zK
qZM880i0TzoHwxn/Iu1kxqbSPOrZ/6WZsIfJRA7jx/4sK5rQBYAg6oUyaJf70NMb
CuyczTVYfI6RFhCoak9VnnHZJAMbar8MnYZbzJhULj61fvis58x6UP6bQZBspzSl
geLzep8hq0S7+6RQ+aVrFmJQ8leBUxemhZdm4fmyALbDU35UHkVcRqZ4LsiyXLej
mat1s5Z5OmijMLQbFs8YJepkobwdIvd3Y13Y2S/wNI2XvNbh/BbbyUeSOHELYXVC
FwySUjmnbQWoCh8N9MaO7UUtzvs87UnZ436SEkBY+A0lmj349a8NsRCpGObV8/Rr
+qcd1q2Nx9qNnAoW9MWne38X9hnpctNDHGNb/Oa6803SFuMYw33jti6dvEJeqnTf
jQmttt4Gi874VK/uwgBrvOfO9oDmE8/GQm+c57pj4yq5v///SaN7kQHUd2CRl5Dh
gZmKjD4+
=yRvn
-----END PGP SIGNATURE-----

--j7iivRrMH0ocPAzp--
