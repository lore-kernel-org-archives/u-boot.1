Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F83C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 13:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB5487C5A;
	Wed, 24 Jan 2024 14:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ANTFzOUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D5787C77; Wed, 24 Jan 2024 14:15:07 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7071687C54
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 14:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so4928975276.1
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 05:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706102103; x=1706706903; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D6PFPY+THAYc4qfTMUvwxPwn7WXDccJ5Ij9ke2LBl2Q=;
 b=ANTFzOUh0gpUYTtLMliNFKmWG7Tj6q1gFld0bHxYoz9XeAolQE1+zWZn/YPz+uvEWz
 aW3FWoUzhUM/HKosBrSIm+3SSlXvwB7tVaHbGJfJZWrs8Axu/bia33H5lBrRP5kwhHxf
 wJytrKVXVT/s7L1ulefoWD5DzNJe4IqLsChwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706102103; x=1706706903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6PFPY+THAYc4qfTMUvwxPwn7WXDccJ5Ij9ke2LBl2Q=;
 b=vZXaOnq3xPQvEnSxjKLJd0qfcVZxr0RxBlGJx0U5HAgh6iwsYFO71bps1Q8EBVrXk6
 uf40HYVusxz+gTcc+izIYk8FBe6NuCuvQCNEyVPlrZgtjBoTo2ZXVruHGYNhwz7UipoR
 dugvPUsXjT8MaESWW/m3fpKHfZKc4BiuS8y1CWvDOdh45Tw8TIEM2MJJ27/uht/q6yzs
 Fe3rZrTK1yNhEhWtvu5DjDYtKWHA10POjdgv/d9CMNQkNCT5pHighUSd7M7t8Ffr19cD
 VJsXraxXeBxh5jmQYewqN/D1Wd3j1lxQ6T1EhcRHtVWO4l0WjSSreNwEi1wbx3v/nb2S
 vqPA==
X-Gm-Message-State: AOJu0Yz5JctKk112gZyD3HhPsV6/4gKhgMzO0tv+/pEDU8p76mnZ4tt+
 K/dd/s5wxUkNPopVjgYCEppYTyjlTOTfN8lDGJIYOkTggUmt2YM6gI5ASNTOuhoHYo3pfI/0syT
 J
X-Google-Smtp-Source: AGHT+IEESXDG+PiwaSJD6lr1MVkQmZehY556kuGgvT+T+UXQv+GXRXrSIYOOJMdvhQVkWMCSWWC5jQ==
X-Received: by 2002:a25:7911:0:b0:dc2:490e:d2c0 with SMTP id
 u17-20020a257911000000b00dc2490ed2c0mr676614ybc.46.1706102103035; 
 Wed, 24 Jan 2024 05:15:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 v14-20020a2583ce000000b00dc25400eda4sm2728516ybm.22.2024.01.24.05.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 05:15:02 -0800 (PST)
Date: Wed, 24 Jan 2024 08:15:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 02/16] xilinx_mbv: Remove empty config header
Message-ID: <20240124131500.GB3652023@bill-the-cat>
References: <20240122223920.3630168-1-trini@konsulko.com>
 <20240122223920.3630168-2-trini@konsulko.com>
 <d6f63f01-5b53-48da-ab50-75bf8f0d83c3@amd.com>
 <20240123175851.GU3652023@bill-the-cat>
 <3b14e176-3e05-4cc1-9099-507080d12aee@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ICYH0CsQJl80Hnws"
Content-Disposition: inline
In-Reply-To: <3b14e176-3e05-4cc1-9099-507080d12aee@amd.com>
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


--ICYH0CsQJl80Hnws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 08:19:00AM +0100, Michal Simek wrote:
>=20
>=20
> On 1/23/24 18:58, Tom Rini wrote:
> > On Tue, Jan 23, 2024 at 08:53:21AM +0100, Michal Simek wrote:
> > >=20
> > >=20
> > > On 1/22/24 23:39, Tom Rini wrote:
> > > > Now that we support having CONFIG_SYS_CONFIG_NAME be unset to indic=
ate a
> > > > lack of board.h file, unset this on the xilinx_mbv platforms and re=
move
> > > > the otherwise empty file.
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Cc: Michal Simek <michal.simek@amd.com>
> > > > ---
> > > >    board/xilinx/mbv/Kconfig     | 3 ---
> > > >    board/xilinx/mbv/MAINTAINERS | 1 -
> > > >    include/configs/xilinx_mbv.h | 6 ------
> > > >    3 files changed, 10 deletions(-)
> > > >    delete mode 100644 include/configs/xilinx_mbv.h
> > > >=20
> > > > diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
> > > > index 4bc9f72c541b..d2dec397ed6f 100644
> > > > --- a/board/xilinx/mbv/Kconfig
> > > > +++ b/board/xilinx/mbv/Kconfig
> > > > @@ -9,9 +9,6 @@ config SYS_VENDOR
> > > >    config SYS_CPU
> > > >    	default "generic"
> > > > -config SYS_CONFIG_NAME
> > > > -	default "xilinx_mbv"
> > > > -
> > > >    config TEXT_BASE
> > > >    	default 0x80000000 if !RISCV_SMODE
> > > >    	default 0x80400000 if RISCV_SMODE && ARCH_RV32I
> > > > diff --git a/board/xilinx/mbv/MAINTAINERS b/board/xilinx/mbv/MAINTA=
INERS
> > > > index 445654fe740e..db9f03388df9 100644
> > > > --- a/board/xilinx/mbv/MAINTAINERS
> > > > +++ b/board/xilinx/mbv/MAINTAINERS
> > > > @@ -4,4 +4,3 @@ S:	Maintained
> > > >    F:	arch/riscv/dts/xilinx-mbv*
> > > >    F:	board/xilinx/mbv/
> > > >    F:	configs/xilinx_mbv*
> > > > -F:	include/configs/xilinx_mbv.h
> > > > diff --git a/include/configs/xilinx_mbv.h b/include/configs/xilinx_=
mbv.h
> > > > deleted file mode 100644
> > > > index dba398aeec49..000000000000
> > > > --- a/include/configs/xilinx_mbv.h
> > > > +++ /dev/null
> > > > @@ -1,6 +0,0 @@
> > > > -/* SPDX-License-Identifier: GPL-2.0 */
> > > > -/*
> > > > - * (C) Copyright 2023, Advanced Micro Devices, Inc.
> > > > - *
> > > > - * Michal Simek <michal.simek@amd.com>
> > > > - */
> > >=20
> > > Acked-by: Michal Simek <michal.simek@amd.com>
> > >=20
> > > But maybe in future we need to revert this patch to add more options =
there.
> > > Or do you plan to remove all of these configs?
> > > I can imagine distro boot wiring but that can be done via vars file o=
nly but
> > > it is not practical.
> >=20
> > Do you mean that plain text environment feels impractical for standard
> > boot (which should be used instead of the pure scripts of distro_boot) ?
>=20
> I didn't play with standard boot yet to find out how to prioritize certain
> devices at run time. But normally we are trying to keep all amd platforms=
 in
> sync to make sure that from user perspective doesn't really matter if you
> are on microblaze, arm32, arm64 or risc-v based platform.
>=20
> There are still a lot of configs like GUIDs, dfu and others that I don't
> think we will end up without these config files anytime soon. But it does=
n't
> mean we shouldn't aim for it.

OK. Yeah, after a quick look at include/configs/xilinx* today, a lot of
that could just be in standard boot and plain text environment and just
like there's include/env/ti/ today to share common logic, we should get
include/env/amd/ to share some common logic too. Or you and your team
can suggest a better sharing alternative too.

--=20
Tom

--ICYH0CsQJl80Hnws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWxDU0ACgkQFHw5/5Y0
tyyFNAv/W7PcA56h9QMzUhLpgeeW8QfXYB+Dk+hxQFl+Y9zCcRo2WktkVvWX5Jiw
qEU/9D29HoKMj6igd+oBtLzwhrbqeDcP8UwxjojQffisJ2VN2k18LULJLBagOfzI
vfw5746I3MX8DHAlYlSgLA9FmANqXfo4Jg2xZAqQvCxvwYb0sIWzQonH/2xoHIr5
g2fLBVDOEfonA8A4G2iS4Zy1/CLbZqf0GcNlXwsQkQyn5UzOTnb9prcEc6A99J8U
56vloRr4C5npcqnHrSQ71EKr2/qIrGhy0OaRKDHNQuDy1EJt/MmeIs9e1bkeL8iz
DPxpE5rcbmEGArveLCEwH+qkCafiOSQO5NILIH9Io3hSxbJHJYyVF4W93AehvLtO
M6S1pbzOZ2q/CRb2Rpkt2bs0xyCHrHdV4KOXfx9FjTcWrRyFcew01Fm1/wPAXpgT
Zi26/xk3uBMHOmxMKT5Qafn4XDYsjmnc3brlD5cetaRVH300da7LOSzp5hreVpvk
HKWKkEys
=so7j
-----END PGP SIGNATURE-----

--ICYH0CsQJl80Hnws--
