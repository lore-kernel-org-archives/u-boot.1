Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7C4CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 16:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA2187490;
	Thu, 19 Oct 2023 18:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QcBZEWtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31E687490; Thu, 19 Oct 2023 18:07:31 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50EB886FDE
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 18:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so5532047276.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697731643; x=1698336443; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DNUB8sx+a8b5md4CSytSzQRkDiVLxeANIqGqil7UH8g=;
 b=QcBZEWtxsYlJAcUMUDERicDcUfkn6jSPqNPgF4VDrQ33Oeq7VhSc0shFy/EZsiAsGP
 29oF8026CW3httL46W3eLC3ZcWT7s5X+qVuW98AfvlQxDAuUR0cLXDVcCuRYObi4AOKD
 oyAd95Tz7OaUWpN3ZlB4XizPDN0JhcfV3ekwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697731643; x=1698336443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNUB8sx+a8b5md4CSytSzQRkDiVLxeANIqGqil7UH8g=;
 b=pnBksF04gDrFqbWKWvdGGJh5DO98pwsPpTs8vE7lFSe/DQXOTz2NpNifrquiFpTAry
 ilAUH/2FMp2LXogd1c7Jb7+5kCAuvQkllMCia451JTSTt8pV6Qrp87x4ZKr9AXvET8Kd
 kHJYS/wIWncWK6iHJNJ4qC/aTn+IavdyWWgM7VedDRWLnMJmBdo+vH0qaSQ+V9/hO2KR
 x3z6U1WmbLiB/MYtN8UaLkRHGsyZ41AYqetbyXEDruKHRUmXGxYaJ7GKDn+V+bUg+g9D
 fjAV9zqxTpkAxNn95TIwtkXG2/x2m1YVJIgKmQZcggxWOQO6YJ6m74BIPf6uZdgkDnZe
 pdOg==
X-Gm-Message-State: AOJu0YzbieCkStiJudjZeLqgjAjF2TElXVsnZqeVpcOQnLgKiQyVP9/B
 B2mHLS2o34ETCFdSrMqjSvuHyA==
X-Google-Smtp-Source: AGHT+IHPN/3tQbxHwqFnH4RKF5rpzPOeofWpPAr692g7/5U0vuLHSKLS+Y3aVTBexfId5Kp2lSt+sg==
X-Received: by 2002:a5b:c08:0:b0:d9a:b843:89af with SMTP id
 f8-20020a5b0c08000000b00d9ab84389afmr2586770ybq.38.1697731642763; 
 Thu, 19 Oct 2023 09:07:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 184-20020a2519c1000000b00d81bb7ef494sm2146880ybz.19.2023.10.19.09.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 09:07:22 -0700 (PDT)
Date: Thu, 19 Oct 2023 12:07:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>, Stefan Roese <sr@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
 Simon Glass <sjg@chromium.org>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Subject: Re: [PATCH v5 00/11] spl: Use common function for loading/parsing
 images
Message-ID: <20231019160720.GE3119521@bill-the-cat>
References: <20230731224304.111081-1-sean.anderson@seco.com>
 <20230802201109.GI3630934@bill-the-cat>
 <697d729a-f53d-220a-0fdc-a6df3ba3cafc@gmail.com>
 <20230803013125.GK3630934@bill-the-cat>
 <953b4158-e8fb-18ce-5bca-f084d178fc41@gmx.de>
 <ce58787b-786a-a4b3-d505-19cf259c1b93@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vJsPMVE2Pzb7OODt"
Content-Disposition: inline
In-Reply-To: <ce58787b-786a-a4b3-d505-19cf259c1b93@gmail.com>
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


--vJsPMVE2Pzb7OODt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 01:33:20PM -0400, Sean Anderson wrote:
> On 8/3/23 00:41, Heinrich Schuchardt wrote:
> > On 8/3/23 03:31, Tom Rini wrote:
> > > On Wed, Aug 02, 2023 at 09:13:21PM -0400, Sean Anderson wrote:
> > > > On 8/2/23 16:11, Tom Rini wrote:
> > > > > On Mon, Jul 31, 2023 at 06:42:52PM -0400, Sean Anderson wrote:
> > > > >=20
> > > > > > This series adds support for loading all image types (Legacy, F=
IT (with
> > > > > > and without LOAD_FIT_FULL), and i.MX) to the MMC, SPI, NOR, NET=
, FAT,
> > > > > > and EXT load methods. It does this by introducing a helper func=
tion
> > > > > > which handles the minutiae of invoking the proper parsing funct=
ion, and
> > > > > > reading the rest of the image.
> > > > > >=20
> > > > > > Hopefully, this will make it easier for load methods to support=
 all
> > > > > > image types that U-Boot supports, without having undocumented
> > > > > > unsupported image types. I applied this to several loaders whic=
h were
> > > > > > invoking spl_load_simple_fit and/or spl_parse_image_header, but=
 I did
> > > > > > not use it with others (e.g. DFU/RAM) which had complications i=
n the
> > > > > > mix.
> > > > > >=20
> > > > > > In order to meet size requirements for some boards, the first t=
wo
> > > > > > patches of this series are general size-reduction changes. The =
ffs/fls
> > > > > > change in particular should reduce code size across the board. =
The
> > > > > > malloc change also has the potential to reduce code size. I've =
left it
> > > > > > disabled by default, but maybe we can reverse that in the futur=
e.
> > > > > >=20
> > > > > > Here's some bloat-o-meter for j7200_evm_a72_defconfig with ext4=
 support
> > > > > > enabed:
> > > > > >=20
> > > > > add/remove: 2/1 grow/shrink: 1/5 up/down: 444/-584 (-140)
> > > > > > Function=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 old=A0=A0=A0=A0 new=
=A0=A0 delta
> > > > > > spl_load=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0 =
216=A0=A0=A0 +216
> > > > > spl_simple_read=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0 184=A0=A0=A0 +1=
84
> > > > > > spl_fit_read=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 60=A0=A0=A0=A0 104=A0=A0=
=A0=A0 +44
> > > > > > file_fat_read=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 40=A0=A0=A0=A0=A0=A0 -=A0=
=A0=A0=A0 -40
> > > > > > spl_nor_load_image=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 120=A0=A0=A0=A0=A0 76=A0=A0=A0=A0 -44
> > > > > > spl_load_image_ext=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 364=A0=A0=A0=A0 296=A0=A0=A0=A0 -68
> > > > > spl_load_image_fat=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 320=A0=A0=A0=A0 200=A0=A0=A0 -120
> > > > > > spl_spi_load_image=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 304=A0=A0=A0=A0 176=A0=A0=A0 -128
> > > > > > spl_mmc_load=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 716=A0=A0=A0=A0 532=A0=A0=A0 =
-184
> > > > > > Total: Before=3D233618, After=3D233478, chg -0.06%
> > > > > >=20
> > > > > > For most boards with a few load methods, this series should bre=
ak even.
> > > > > > However, in the worst case this series will add around 100 byte=
s.
> > > > > >=20
> > > > > > I have only tested a few loaders. Please try booting your favor=
ite board
> > > > > > with NOR/SPI flash or SPI falcon mode.
> > > > >=20
> > > > > > On sama5d27_wlsom1_ek_mmc_defconfig, 100 bytes is too much, so =
this
> > > > > > series depends on [1] to fit everything in. CI run at [2].
> > > > > >=20
> > > > > > [1] https://lore.kernel.org/u-boot/20230731223327.109865-1-sean=
=2Eanderson@seco.com/
> > > > > > [2] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipel=
ines/17116
> > > > >=20
> > > > > I've boot-tested this on my lab and a handful of SD+FAT or SD+raw=
 boot
> > > > > devices, and it's all worked.=A0 I also did my usual world build
> > > > > before/after to check out the size changes and well, I don't know=
=2E=A0 The
> > > > > size wins come on platforms where there's both FAT+EXT support.=
=A0 And
> > > > > then on mips with say mt7620_rfb I wonder if we're loosing
> > > > > functionality.
> > > >=20
> > > > Yes we are. I'll address this in v6.
> > > >=20
> > > > > But most platforms grow a bit, especially if they're just
> > > > > a single load type (which is the most common case). Maybe this pr=
oblem
> > > > > needs to be approached another way? I've put the whole log over at
> > > > > https://gist.github.com/trini/e6772b2134e0eb44393364ea98729e06 an=
d maybe
> > > > > something will jump out to you.
> > > >=20
> > > > The fls/ffs patch [1] reduces the growth by around 80 bytes on ARM
> > > > platforms. I sent it separately for ease of review, but it really s=
hould
> > > > be applied before this series, since a good portion of the growth i=
s due
> > > > to that one function call. It seems like MIPS also has this instruc=
tion
> > > > (and Linux uses it), so I can try putting together a patch for it as
> > > > well.
> > > >=20
> > > > In the future, I would like to convert bl_len to bl_shift or someth=
ing,
> > > > which would remove the need for fls (and going from bl_shift to bl_=
len
> > > > is just a shift). spl_load_info is used in a lot of places, so I wa=
nted
> > > > to do that in a follow-up. On arches with efficient fls implementat=
ions
> > > > the difference is only around 3 instructions or so.
> > > >=20
> > > > But fundamentally some of the problem is that the logic is being mo=
ved
> > > > into multiple translation units, so the compiler can't see enough to
> > > > make optimizations. For example, all filesystems use a bl_len of 1,=
 so
> > > > all the multiplications/roundings/etc. can be eliminated if the com=
piler
> > > > can see that. For example, on arm64 copying spl_load into spl_fat.c=
 (as
> > > > fat_load) and making it static saves us 100 bytes:
> > > >=20
> > > > add/remove: 3/1 grow/shrink: 0/1 up/down: 324/-92 (232)
> > > > Function=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 old=A0=A0=A0=A0 new=A0=
=A0 delta
> > > > spl_load=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0 160=
=A0=A0=A0 +160
> > > > spl_simple_read=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0 104=A0=A0=A0 +104
> > > > spl_fit_read=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0 60=A0=A0=
=A0=A0 +60
> > > > file_fat_read=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 40=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=
=A0 -40
> > > > spl_load_image_fat=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 252=A0=A0=A0=A0 200=A0=A0=A0=A0 -52
> > > > Total: Before=3D66833, After=3D67065, chg +0.35%
> > > >=20
> > > > add/remove: 2/1 grow/shrink: 1/0 up/down: 172/-40 (132)
> > > > Function=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 old=A0=A0=A0=A0 new=A0=
=A0 delta
> > > > spl_simple_read=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0 104=A0=A0=A0 +104
> > > > spl_fit_read=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0 60=A0=A0=
=A0=A0 +60
> > > > spl_load_image_fat=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 252=A0=A0=A0=A0 260=A0=A0=A0=A0=A0 +8
> > > > file_fat_read=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 40=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=
=A0 -40
> > > > Total: Before=3D66833, After=3D66965, chg +0.20%
> > > >=20
> > > > and even then, by inspection spl_simple_read isn't really taking
> > > > advantage of bl_len=3D1. Surprisingly, after enabling LTO this boar=
d is
> > > > +400 bytes (compared to without this series). It's just hard to beat
> > > > handwritten routines with a generic solution.
> > > >=20
> > > > I would really like to consolidate this stuff, since every load met=
hod
> > > > ends up only supporting a few image types and having almost identic=
al
> > > > implementations for what they do support.
> > > >=20
> > > > --Sean
> > > >=20
> > > > [1] https://lore.kernel.org/u-boot/20230731212734.7256-1-sean.ander=
son@seco.com/
> > >=20
> > > Thanks for digging more, lets keep going in this direction then.
> > >=20
> >=20
> > Do we need to pass sectors to the info->load() functions?
> >=20
> > Only nand and mmc use bl_len !=3D 1. Can we move the conversion to sect=
ors
> > and the alignment checks to functions called by info->load()?
> >=20
> > I would assume that this can avoid part of the code size increase.
>=20
> Unfortunately, while the conversion to sectors and alignment can be put i=
nto ->load,
> MMC (and ROMAPI) can only read in block-sized chunks. This means that the=
 buffer must
> be a multiple of the block size (otherwise we will go over the end), and =
there must be
> a block's worth of space in front of the buffer as well (which we use whe=
n we have a
> non-block-aligned offset).
>=20
> These situations generally only matter when reading into a malloc'd buffe=
r, since there
> is data to overwrite on either end of the buffer. With things like SYS_TE=
XT_BASE, there
> is nothing to overwrite on either end. From examining the various loaders=
, malloc'd buffers
> are only used when loading the image header (which may include the full i=
mage for FITs).
> In that situation, under the beginning of the buffer is not an issue, sin=
ce the load method
> should have supplied an offset which is a multiple of the block size. Thu=
s, we only need
> to solve the problem of writing past the end of the buffer.
>=20
> From my perspective, there are three approaches we could take:
>=20
> - Keep bl_len so that callers of ->read can allocate a sufficiently-large=
 buffer.
> - Use a bounce-buffer. This uses around double the memory and will also i=
ncrease code size.
> - Complete most of the read as normal, but read the final block into a se=
parate buffer which
>   is then copied into the passed-in buffer. This requires two reads, whic=
h is likely slower
>   than one. It will also increase code size.
>=20
> I think the first approach could be improved by optionally removing bl_le=
n when there are
> no load methods which need it. This will let the compiler optimize out an=
y alignment if it
> is unnecessary, which it cannot currently do (unless LTO is enabled). I a=
m going to try using
> this approach for v6.

This sounds good, and LTO is / can be an option for SPL for platforms
that need to regain space.

--=20
Tom

--vJsPMVE2Pzb7OODt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUxVDUACgkQFHw5/5Y0
tyweKQwApi8hBr6tK9noDKtovBThTP6zhmClvpZLQaHg3oFOlVwl64MCAIuS1jox
sFrs/uuyg2hPb55iUasxNOzYGamwfFVZwhdZZzzGfuuElFTI4OSYPMGlPIBwxQ78
srl3c6JJS14MHOf++LF7UpMRdwrbBbHPuqBQsAhKPi2jcTTQoDY+OuSWk55RaXcy
4dlcmFZbsVADmSE+CmLG21Kubx/rtEB5PBE0fVRuJxP6LfMnA6JeS5xHUbfuqadh
AK1tcqlBlOgcGUkgUmcGhBjMJ2ro6ucywOSuhQAlRLcIx41s6maqUG3d/iLzvg5C
yw4tCvk4mJ3Q6KRDWV88yW+SaClTnEL33Ji8OQ/5uYR14hpbr/CIJjjzS9d5+lqp
AZF7GW2XLiJ2nJEmtwHsSF08Pw3I5i3RwmfSdE6thcuGK4K/ApuPEgHWROq6GRqo
Ajb6KwWsH3yNPEcVgSNTtj6Jl1tnALQ6T78MPqAy2QtjL+8v8sQhytmxfxJnRFfG
Iws6rmXF
=xyQQ
-----END PGP SIGNATURE-----

--vJsPMVE2Pzb7OODt--
