Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E06C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7D386E81;
	Fri, 17 Nov 2023 20:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZU81TmE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3E1786E42; Fri, 17 Nov 2023 20:08:00 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 742CE86ECA
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-677fb277b7cso3308216d6.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700248072; x=1700852872; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sbjiLJ8saEj1f2S/GTW/HYpa5IpgI0wqGk2nKXVRPJg=;
 b=ZU81TmE7NSILDYBXsDIuZ+VQcofgcpk666Ch8kcQdW1wW4UvR5e31hUbNzhJuSxN34
 m5CIvAALyEVIlroPIYhgU8TdAmLkkIEC6JjT30PCMeaeP9Wh0fBwaFoJK7Ev0xg9kC2p
 hgHn+nTg6W8Av7E7ffSJ9B14/pyWa1SjkV6Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700248072; x=1700852872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbjiLJ8saEj1f2S/GTW/HYpa5IpgI0wqGk2nKXVRPJg=;
 b=BiThU7tUuFZL5gwCMlI62wu0EvcYUUo1oxDy1i04/c9B7Twuay8j/tpMSN6cfQMKTf
 x6LMu1NTE6osQ1JGbQo8wbMTAD9cEgho2qbFf9ny+LscaTdb4QP4mzTMIve+ETMu3zAO
 qrL+puSbVQlxVadTrOzK2zuPusLrqKYqfhgv1Avs0ArG0/IKA8BYsD72Ysn6v2ZTkiL8
 hkCidARy11w172jJoPmKqYdPO3ZG2VWCOh7W57FJBmf2GqFM+vvAgBgr6Lpb3+WELPSy
 5rrohzuvp8bTCAV48lp54FR2EDxciFbgYCka81VxJtXvekpaWzhZDyMMsK3USEBweXxN
 eQuA==
X-Gm-Message-State: AOJu0YwwtwmPqAa12CJG2YS6/Qx3nxP6/ZPvtzqTwdm17wlkY8CX5aDe
 XVyZXdBnKtLtir0DK8hhbzZMD2TZ3hGZPtXf+f/sWQ==
X-Google-Smtp-Source: AGHT+IHwBND5yR3IOvvDa7ptSqPZtQuUxYOjbc6hyWoUPgwSUppwo+psIoD23HDTNSCBM0fI5H4EeA==
X-Received: by 2002:a05:6214:501d:b0:671:9c02:cba9 with SMTP id
 jo29-20020a056214501d00b006719c02cba9mr17236441qvb.51.1700248072568; 
 Fri, 17 Nov 2023 11:07:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 do18-20020a056214097200b0065b12c7a48dsm832164qvb.133.2023.11.17.11.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:07:52 -0800 (PST)
Date: Fri, 17 Nov 2023 14:07:50 -0500
From: Tom Rini <trini@konsulko.com>
To: John Clark <inindev@gmail.com>
Cc: Slawomir Stepien <sst@poczta.fm>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] rockchip: rk3588: Fix boot from SPI flash
Message-ID: <20231117190750.GQ170968@bill-the-cat>
References: <20231112102705.1180714-1-jonas@kwiboo.se>
 <20231112102705.1180714-2-jonas@kwiboo.se>
 <561f7d8a-bf46-4ba7-a353-b5d3dfab95b0@theobroma-systems.com>
 <ZVdyu2vjW0LrW6Jf@nr200> <20231117175020.GP170968@bill-the-cat>
 <31e783f3-a73b-e6fc-bf25-84a8b2c4cd1d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ag/abH1nMKZrJw+a"
Content-Disposition: inline
In-Reply-To: <31e783f3-a73b-e6fc-bf25-84a8b2c4cd1d@gmail.com>
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


--ag/abH1nMKZrJw+a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 01:50:58PM -0500, John Clark wrote:
>=20
> On 11/17/23 12:50 PM, Tom Rini wrote:
> > On Fri, Nov 17, 2023 at 03:03:39PM +0100, Slawomir Stepien wrote:
> > > On lis 14, 2023 15:06, Quentin Schulz wrote:
> > > > Hi Jonas,
> > > Hi Quentin
> > >=20
> > > > On 11/12/23 11:26, Jonas Karlman wrote:
> > > > > The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot f=
rom SPI
> > > > > NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value =
6.
> > > > >=20
> > > > > At the time the reason for this new bootsource id value 6 was unk=
nown.
> > > > >=20
> > > > > We now know that the BootRom on RK3588 use different bootsource id
> > > > > values depending on the iomux used by the flash spi controller, a=
nd not
> > > > > by the type of spi nor or spi nand flash used.
> > > > >=20
> > > > > Add the following defines and use them for RK3588 boot_devices.
> > > > >=20
> > > > > - BROM_BOOTSOURCE_FSPI_M0 =3D 3
> > > > > - BROM_BOOTSOURCE_FSPI_M1 =3D 4
> > > > > - BROM_BOOTSOURCE_FSPI_M2 =3D 6
> > > > >=20
> > > > > Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from =
SPI NOR flash")
> > > > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > > > ---
> > > > >    arch/arm/include/asm/arch-rockchip/bootrom.h | 4 +++-
> > > > >    arch/arm/mach-rockchip/rk3588/rk3588.c       | 5 +++--
> > > > >    2 files changed, 6 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/=
arm/include/asm/arch-rockchip/bootrom.h
> > > > > index 7dab18fbc3fb..f78337397d63 100644
> > > > > --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> > > > > +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> > > > > @@ -47,8 +47,10 @@ enum {
> > > > >    	BROM_BOOTSOURCE_EMMC =3D 2,
> > > > >    	BROM_BOOTSOURCE_SPINOR =3D 3,
> > > > >    	BROM_BOOTSOURCE_SPINAND =3D 4,
> > > > > +	BROM_BOOTSOURCE_FSPI_M0 =3D 3,
> > > > > +	BROM_BOOTSOURCE_FSPI_M1 =3D 4,
> > > > I'm a bit wary of two pairs of enums sharing the same value, especi=
ally when
> > > > we want to use them as offset in a static definition of an array.
> > > >=20
> > > > Should we #ifdef it (meh) for RK3588?
> > > > Should we add a suffix like before for identifying RK3588-specific =
options?
> > > >=20
> > > > At the very least explicit that those are RK3588-specific in a comm=
ent for
> > > > both conflicts (the ones that apply to everything except RK3588 to =
say to
> > > > use only for !RK3588, and the ones that apply to RK3588 only)?
> > > Can you say why it is so important to know that given enum is specifi=
c to given CPU here in the
> > > header file? I think that the enums in the bootrom.h should be as gen=
eric as possible.
> > >=20
> > > By using the possible enums in a static array, "solves" the problem o=
f assigning the boot source to
> > > specific CPU. There is not need to make such grouping in the bootrom.=
h.
> > Do we have any insight as to why Rockchip re-used those values? Looking
> > at the header I see RK3588 has a different SPINOR value than others.
> > Does RK3588 share the same value for other sources? How much of
> > bootrom.h is still correct for RK3588? I'd rather not have to move to
> > having bootrom_${soc}.h like so many other headers are, and if it's just
> > these values, it might be cleaner to #if .. #else .. #endif the whole
> > enum, and then re-evaluate things abased on whatever the next new SoC
> > does here.
> >=20
> Which c specification does u-boot follow?=A0 Duplicate values in enumerat=
ions
> are explicitly allowed in c as far as I ever have known.
>=20
> "The use of enumerators with =3D may produce enumeration constants with v=
alues
> that duplicate other values in the same enumeration."
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf

Sorry I wasn't clear. It's less about C specification and more about
readability. We could do, but I feel is odd readability-wise is:
enum {
        BROM_BOOTSOURCE_NAND =3D 1,
        BROM_BOOTSOURCE_EMMC =3D 2,
        BROM_BOOTSOURCE_SPINOR =3D 3,
        BROM_BOOTSOURCE_SPINAND =3D 4,
        BROM_BOOTSOURCE_SD =3D 5,
        BROM_BOOTSOURCE_FSPI_M0_RK3588 =3D 3,
	BROM_BOOTSOURCE_FSPI_M1_RK3588 =3D 4,
        BROM_BOOTSOURCE_FSPI_M2_RK3588 =3D 5,
        BROM_BOOTSOURCE_SPINOR_RK3588 =3D 6,
        BROM_BOOTSOURCE_USB =3D 10,
        BROM_LAST_BOOTSOURCE =3D BROM_BOOTSOURCE_USB
};

But how many of the other values are still correct for RK3588? The TRM I
found quickly does say that NAND and SD/eMMC are valid options, and USB,
but I didn't see a table that mapped back to the values here.

--=20
Tom

--ag/abH1nMKZrJw+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXugIACgkQFHw5/5Y0
tyxlhwv/eanvU35z9rVSXfVKomaIKP66Ah2o1fBNEvQ4pAmkryqamqlZDjc8WScq
+3ztaSbYuwFCiSoB8q5IiL7xCJoznaxt9pLBz4cvebpoJTSSEUq/nx74WGtu1Iwl
o8MjBQaEUc51LZh5gj7h5M/MeQWBy1f+6nOFYzCbchyAV74uPQUpZNfLZQ7i9d9h
Sx4wks4PT8CRIcCYVrSCxqTsHbyKF29fW/z1BuAZI8yJcd71wV8yaiXVKpUQL+Ju
dYU2zMdNsZsBiTN3XRUxS62vZH5M3q1wxymCeXvLrlkmugaSuMx/4S7GUlFCsF6a
irztnlXG10iruKKFLNr0y6GhOuvfURqXDmK0GMBq+rXvvJq79Y4t/6jEEfM7uTSp
+4lH0iwpkwi96NEiLG8465j/sqJbULDTIDXM3/NiI2x5mju5emfIFAUalw/iOkT4
JS1DXeWsArAFhTUI2RUO0209i/AX6BEL+OWT4I+kGAqsOcFFZPj9xKE7HEqJOh8h
5zRcBUOV
=iVH0
-----END PGP SIGNATURE-----

--ag/abH1nMKZrJw+a--
