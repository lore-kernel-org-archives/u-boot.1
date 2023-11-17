Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D49C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 17:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F118386FE8;
	Fri, 17 Nov 2023 18:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HDuSjlN0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A23D86EA3; Fri, 17 Nov 2023 18:50:29 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF0E86E64
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 18:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7789a4c01ddso138770385a.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 09:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700243424; x=1700848224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3WS5DnKqdiNt4Ag5ns+16EAmkC0hs5MKz2YzUafAHs=;
 b=HDuSjlN0UHaQYjqcmyoeD0BLYr3N5265dBHfb6qKyPUtud3LOWkNWM49PkZG9zM9kP
 WaAmdKwZGb+fGibF9vw3iECFPjPx9O2KTn1/cUVayYlprW3xSOEcGzRL07SoV6zl6k7h
 KhCyRqIArEUWZ9R0JRzobH2FM4qxEMY5e2qxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700243424; x=1700848224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3WS5DnKqdiNt4Ag5ns+16EAmkC0hs5MKz2YzUafAHs=;
 b=dHy5q6iUR21z5nqcAwAQwucQIRNEb4nJpUcNovme1oxS3NEk/I25ECzYWQfYolWiE+
 hDXSkSQ3U4oxH8cIErk7s9nXP3whkwhHBVoak96AJBSgHiNJvWFHXqdiWCYyp7UMs8FE
 a/nLSI9UXYWWv11JgrG+5NvxsfHeAtC6ig8EeZZyGCfcWSh3J9aVqswJ4BtiDJupOr54
 o/Yis+van7WmwkqRsoKOgCnYfj1+FEX/ZPXN+XrTPIQ9xBlcd1L/r12U1P9sg2g/8v/m
 S5NnNorJrw63YbqKS/sqaNA8novTtHLBWPJiMko01weGK/LkTpEx4Udg5iO05PkUy8zc
 uOLA==
X-Gm-Message-State: AOJu0YwQOyk0SSfCzGecp9W58Dl3pOES6HOjyuOtaA09SUFnRO5YEs8m
 A7cA3B1gICa2TjSbgY1AQW10oA==
X-Google-Smtp-Source: AGHT+IHtG7jp6gvI1UhG3EHeqvyeYGbFIwGtkBXzx64P0UPHfSf7hzsJME1g3IiuUZIbZKW2wmDuKQ==
X-Received: by 2002:a05:620a:6791:b0:779:cf30:600b with SMTP id
 rr17-20020a05620a679100b00779cf30600bmr166478qkn.4.1700243424139; 
 Fri, 17 Nov 2023 09:50:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 qf9-20020a05620a660900b007676f3859fasm765964qkn.30.2023.11.17.09.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 09:50:22 -0800 (PST)
Date: Fri, 17 Nov 2023 12:50:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] rockchip: rk3588: Fix boot from SPI flash
Message-ID: <20231117175020.GP170968@bill-the-cat>
References: <20231112102705.1180714-1-jonas@kwiboo.se>
 <20231112102705.1180714-2-jonas@kwiboo.se>
 <561f7d8a-bf46-4ba7-a353-b5d3dfab95b0@theobroma-systems.com>
 <ZVdyu2vjW0LrW6Jf@nr200>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="POdIdO2rvLMGmnp3"
Content-Disposition: inline
In-Reply-To: <ZVdyu2vjW0LrW6Jf@nr200>
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


--POdIdO2rvLMGmnp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 03:03:39PM +0100, Slawomir Stepien wrote:
> On lis 14, 2023 15:06, Quentin Schulz wrote:
> > Hi Jonas,
>=20
> Hi Quentin
>=20
> > On 11/12/23 11:26, Jonas Karlman wrote:
> > > The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from =
SPI
> > > NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.
> > >=20
> > > At the time the reason for this new bootsource id value 6 was unknown.
> > >=20
> > > We now know that the BootRom on RK3588 use different bootsource id
> > > values depending on the iomux used by the flash spi controller, and n=
ot
> > > by the type of spi nor or spi nand flash used.
> > >=20
> > > Add the following defines and use them for RK3588 boot_devices.
> > >=20
> > > - BROM_BOOTSOURCE_FSPI_M0 =3D 3
> > > - BROM_BOOTSOURCE_FSPI_M1 =3D 4
> > > - BROM_BOOTSOURCE_FSPI_M2 =3D 6
> > >=20
> > > Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI =
NOR flash")
> > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > ---
> > >   arch/arm/include/asm/arch-rockchip/bootrom.h | 4 +++-
> > >   arch/arm/mach-rockchip/rk3588/rk3588.c       | 5 +++--
> > >   2 files changed, 6 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/=
include/asm/arch-rockchip/bootrom.h
> > > index 7dab18fbc3fb..f78337397d63 100644
> > > --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> > > +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> > > @@ -47,8 +47,10 @@ enum {
> > >   	BROM_BOOTSOURCE_EMMC =3D 2,
> > >   	BROM_BOOTSOURCE_SPINOR =3D 3,
> > >   	BROM_BOOTSOURCE_SPINAND =3D 4,
> > > +	BROM_BOOTSOURCE_FSPI_M0 =3D 3,
> > > +	BROM_BOOTSOURCE_FSPI_M1 =3D 4,
> >=20
> > I'm a bit wary of two pairs of enums sharing the same value, especially=
 when
> > we want to use them as offset in a static definition of an array.
> >=20
> > Should we #ifdef it (meh) for RK3588?
> > Should we add a suffix like before for identifying RK3588-specific opti=
ons?
> >=20
> > At the very least explicit that those are RK3588-specific in a comment =
for
> > both conflicts (the ones that apply to everything except RK3588 to say =
to
> > use only for !RK3588, and the ones that apply to RK3588 only)?
>=20
> Can you say why it is so important to know that given enum is specific to=
 given CPU here in the
> header file? I think that the enums in the bootrom.h should be as generic=
 as possible.
>=20
> By using the possible enums in a static array, "solves" the problem of as=
signing the boot source to
> specific CPU. There is not need to make such grouping in the bootrom.h.

Do we have any insight as to why Rockchip re-used those values? Looking
at the header I see RK3588 has a different SPINOR value than others.
Does RK3588 share the same value for other sources? How much of
bootrom.h is still correct for RK3588? I'd rather not have to move to
having bootrom_${soc}.h like so many other headers are, and if it's just
these values, it might be cleaner to #if .. #else .. #endif the whole
enum, and then re-evaluate things abased on whatever the next new SoC
does here.

--=20
Tom

--POdIdO2rvLMGmnp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXp9MACgkQFHw5/5Y0
tyxOVQv+P1KolL+iXeEb9QrcCB5rPvNTR3Ij7N/MPo2m/VNOm1HLCtd5joEAuNsz
wraCgHvkf4uOx7gkT8g4sYFHZmsUSuzy/FoKrsP+qzlQMtIF5lUquEVGINfSIHP+
szDnA1Z7Vzathze/JdxoyJXXtOXp5I04NuPjFR18nIb2OApqb0Rh5mUyEWUIyOoy
9nCqyl7Kb51ZmTqcA7Tj0pq4n40TMc8co7Rpw49d4duAOTle3A7mFnnCTnnH1xsV
gHoejV80bQW94FFqTj0X7iTjuZUvQDfpm5BLViBLUqcD23UslGgTsA0h6yeTKc78
3MG9JAE9LiWqjhn8I00WHJRE60TNS5nFEDu1omMxarf5psvcBS7r+dZBD/Sj4yzY
mY7904GIo+09WHOgx+NiIMXZJJpPJXyjX4i30i68i0t/9wUQULiTxqZeCvbbJhrW
6rh0gFauSTIp8P6QlQpDbiLMWf65VKSPQHK0WGfTDzM7KqHV+fUqe6syVZAZr+4j
FSdPJK8C
=SrE2
-----END PGP SIGNATURE-----

--POdIdO2rvLMGmnp3--
