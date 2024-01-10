Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85423C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 16:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C40986EF1;
	Wed, 10 Jan 2024 17:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y42HvvXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156ED878B1; Wed, 10 Jan 2024 17:30:28 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A390786EF1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 17:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-680fdf7d52fso25945896d6.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704904222; x=1705509022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F+qspIHHBAqJrd6F+KpqVsXD9cBfXa0v1dikBejCpeQ=;
 b=Y42HvvXht/MGtLeL3dQNHMcx4EzMPi55waXbhDnz7chIKM4TsK5CmruUn6T4kMGNJ5
 f3KEVkMF4eiiLsV+KqjBjg+iM2ezUoaN4FerIKIww9dvz1SgZ51qBRXjsDLNhOjb986W
 c8ZybNl4i7Ak2dfxIJXjvG0lqG6kOZ4AwMZ5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704904222; x=1705509022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+qspIHHBAqJrd6F+KpqVsXD9cBfXa0v1dikBejCpeQ=;
 b=hb7/SVKUiz4i2U4X4zDPM2YAJkLhfbPDxbWXeua0gUzd3X/sAtGeP1sIdlm52d0zf6
 y+cGgloHTcHI03iEOIDtZNCrLYoe2Z731cgP47FK8zVGzSgukmkq28+80rzGsJtZBIE6
 u5Rhzt8YRfrej/YbXvLWBqYtoYoRMxplXIezExwy5piuRnIIvQO0ykmE9dYO/c+iEasC
 EdOD/mJUCEqb/HZRVCf0GtoNt4/wwtBb76PWKAkcnlC6FTyU9oiQF/wnqy4gzUlSlgLg
 wMCnDbf33mrPLMu8doZc9YlOXTI08/bdO91lTC0RfIMU83fD4NpPFZmMSYKAgNKvIwex
 BpKw==
X-Gm-Message-State: AOJu0YwR+Kv42JgvYkfcXIqeZFYj6+53C30dwnAnOENbdvRiRow2DhSS
 B+Ns3QTb5fTLGjd9v4jV85HEgHiQb8D/0Qs6qJTydGds/zk=
X-Google-Smtp-Source: AGHT+IGCv0+xWKTOX3qNr9gpk6hFI4L/KNOBC0NSc1+U0nVKMCZF08dxThfGoL6RAOmM3E3Ghypkxg==
X-Received: by 2002:ad4:5cce:0:b0:681:7da:4a6a with SMTP id
 iu14-20020ad45cce000000b0068107da4a6amr1521000qvb.7.1704904222378; 
 Wed, 10 Jan 2024 08:30:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 ev16-20020a0562140a9000b0067f6174c766sm1826128qvb.0.2024.01.10.08.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 08:30:21 -0800 (PST)
Date: Wed, 10 Jan 2024 11:30:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, afd@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, r-gunasekaran@ti.com, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Message-ID: <20240110163019.GG1610741@bill-the-cat>
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109122605.51951-5-rogerq@kernel.org>
 <20240109191859.ljtnotdn4voabwko@animate>
 <20240109195400.GY1610741@bill-the-cat>
 <20240109200053.GA94696@francesco-nb>
 <f6b3cf36-8e33-4e0d-9794-35ea32410c88@kernel.org>
 <179ded75-e874-41c1-a76d-1fadce65881f@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IuaZ3JTbOausZ2aU"
Content-Disposition: inline
In-Reply-To: <179ded75-e874-41c1-a76d-1fadce65881f@kernel.org>
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


--IuaZ3JTbOausZ2aU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 06:06:45PM +0200, Roger Quadros wrote:
> +Lukasz & Mattijs
>=20
> On 10/01/2024 11:34, Roger Quadros wrote:
> >=20
> >=20
> > On 09/01/2024 22:00, Francesco Dolcini wrote:
> >> On Tue, Jan 09, 2024 at 02:54:00PM -0500, Tom Rini wrote:
> >>> On Tue, Jan 09, 2024 at 01:18:59PM -0600, Nishanth Menon wrote:
> >>>> On 14:26-20240109, Roger Quadros wrote:
> >>>>>  CONFIG_CMD_PMIC=3Dy
> >>>>>  CONFIG_CMD_REGULATOR=3Dy
> >>>>> +CONFIG_CMD_MTDPARTS=3Dy
> >>>>> +CONFIG_MTDIDS_DEFAULT=3D"nand0=3Domap2-nand.0"
> >>>>> +CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Domap2-nand.0:2m(NAND.tiboot3=
),2m(NAND.tispl),2m(NAND.tiboot3.backup),4m(NAND.u-boot),256k(NAND.u-boot-e=
nv),256k(NAND.u-boot-env.backup),-(NAND.file-system)"
> >>>>
> >>>> Why not handle this as device tree partitions?
> >>>
> >>> I honestly forget what the preferred way of defining and passing NAND
> >>> partition information is these days. It might even be the funny case
> >>> that passing as cmdline args is "best" rather than fixed-partitions
> >>> binding?
> >>
> >> According to past discussions [1] doing the fixup in U-Boot is not adv=
ised.
> >>
> >> Using the command line or having the partition fixed in the DT are both
> >> valid options.
> >>
> >> [1] https://lore.kernel.org/all/20230206224838.75963-1-francesco@dolci=
ni.it/
> >>
> >> Francesco
> >>
> >=20
> > This was not about passing mtdparts to kernel but about getting 'mtdpar=
ts' command
> > to work at u-boot. I need to figure out why OF partition parser didn't =
work here.
> >=20
> > For a start I didn't have CONFIG_MTD_PARTITIONS set. Maybe I'm missing =
something more.
> >=20
>=20
> The issue was the NAND driver was not setting chip->dev and chip->ofnode =
correctly.
> Now 'mtd list' shows partitions from the DT.
> But, 'dfu 0 nand list' still fails like so.
> 	"mtdparts variable not set, see 'help mtdparts'"
>=20
> Looks like dfu_nand driver doesn't fall back to OF partitions if mtdparts=
 environment
> is not defined.
>=20
> Should we add OF partitions support to dfu_nand driver or is it deprecated
> in favor of dfu_mtd driver?

I would rather not have to populate the env variable as that will lead
to confusion later on I fear (make a change and it's not populated
onward).

--=20
Tom

--IuaZ3JTbOausZ2aU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWexhcACgkQFHw5/5Y0
tyxFMwv+MvdKDzehPizo/gpQwIsp72k6UYtG7fsYPzeEMq3UOynSRi66R6JghdPN
9mO43vdop07W5wRfD9hkWuN75G2T+wmJlcTgWcItfabKu87VGjSmqRgwioDUFZQf
W9aXkDkFTOIgLAabpwdO2DojtaRnFF64kn4Xm6xn4tHc8q58ouNu0HNCsPjOsWEs
VQ2z7wEcvDhECWWO7hluyyaxN8r94c5zdIevShHdILqzwWtVDcwSlZJHrIZ85GHT
WoI4UCHEhw8LGKUeSC2vObIqqHsS9cTjG89rRiWWl2+PXHyLbdajBXPhNd7rLPji
KyJPuB7rXLHT6o4GJg4qjtLlbleYG4I8EoJ96rE3aw5/xIvl5x1X0OvSYZr6DSGC
Z0gX543C2nvAqsRFnTuyeuqMl0iFa/vZ26gCcOerqb98RkxKYhasahfpWubZn/yt
jk1mbRfmoMSfl2/dNuZCJqf9utVThi7aOXgo1pY+Peg/DLQQ2KMXfRLGXTD3EUC5
hzitsunp
=Uqug
-----END PGP SIGNATURE-----

--IuaZ3JTbOausZ2aU--
