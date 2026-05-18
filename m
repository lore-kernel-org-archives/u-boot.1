Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAC8CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 18:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39EA284119;
	Mon, 18 May 2026 20:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jz6CHqWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023BF84659; Mon, 18 May 2026 20:22:48 +0200 (CEST)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6374E80433
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 20:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso2262797a34.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779128564; x=1779733364; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Dy2U7aA4jNAimhgZgUFjy9/saipc8DRgJafHCqW9Eo=;
 b=Jz6CHqWNrzXva+4tAUUKDLP3CBphC4iRPpVBpDtd7BLGcmtDcbl3LOXTaVWCL34kgA
 ACi+I34ND9u00ZI9c+lGxOJJSdxdoVRXNV7gnA2XgKQsCPz7yGyUPEB9KMuUrRhi70vJ
 Sgfxz9HYbVF2MVwL/2fueyohwGrFn+ZED6EzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779128564; x=1779733364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Dy2U7aA4jNAimhgZgUFjy9/saipc8DRgJafHCqW9Eo=;
 b=TrRhIjoHnYovFTscQAZP3tZT3mMzVV5zUcbCkBkscC4uK9O2yEltwBli+m58tRFm1R
 y7tMw7p1CwNe4kub6PkPnrqOpJObUBTMZsCqUGBOpQyuOi9UHxYdpgEha1Vw7BT85QZ7
 y2s8AA57L8Fvks3YYWp9edqhiRCSlHeSk20Kbe3sKOzAj+MhP7kg81wt8sgCoW4Bxusq
 wU5/jPLP9/4mmJ5VDYZKgMt5eqzgT1Jg05XKR22dsr3ZlewrBa1JGFErQHDLSJdnViwJ
 YMd53PRDi8igYIq/jEpWu9PKzlj/Bb2/vFIcZVlFrJCL0Go3UZwRaZ6nce6EqVWFde9c
 b0aw==
X-Gm-Message-State: AOJu0YwCMKPpR7wpHXIQauwOxgNLP8w+P29eZ7PXLUWYwOss5QyJmr8R
 DJyVDvjnFK0zyedLob9+AbzoCgAWEPtWFWP/9ZC/hplgjSaSJggRzNhwI/qtnSJ0SAw=
X-Gm-Gg: Acq92OF4N9rt53zdiVlzo+Vu1l+sLbmfhJo14bK7yWvoTByswciNcnkvDh6nYIuv9dT
 n8Unuuc5IwNt7jtyKx1P19vIrmKSrGYRDBp3Sptq+aWTImJKJGkJnhAk58UJF76E6pkrlIkuOzz
 3YNZU5OOVomV9oOe1+ysMgDWIeKnFSEpxb7KfRSyGbCKtdh4s5CxYs+IIwDcdp+wnQFNLeDTyxs
 41BucItviIXnj5+aGnGOWNUVEtvP/EyuW2LP+3eF02GVk3wYEMu93k4zVymR29EIHvjnoqeRz/Q
 DXuhSW2vkpP+KlgO09zQzt4/w9vIEW+cTaDyEv2snmQZibQfL4VjqyPk2T3My3GBZRzMpe7M6if
 y5jk/DMncEYJi+BZ1tOPcn4vXfFgRB7CQpWdhLp/sjki97VdqkNfKqy5+aod3TfHyFw2VMeXqqU
 7z7BjK3ogwWNWvOE1gM/HcpHefL1jrzsJqJmm6Se5mp2IzG5Jntj7pBuT914geZydcslR9Eh3/8
 K0iNim17yLjGaW+aAUhd6DNBUJvmMB9oaWgZDs0jk18vFqX+p4=
X-Received: by 2002:a05:6820:811a:b0:69b:8ded:f92d with SMTP id
 006d021491bc7-69c9430101bmr10642964eaf.21.1779128563858; 
 Mon, 18 May 2026 11:22:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d048b095dsm5954249eaf.9.2026.05.18.11.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 11:22:43 -0700 (PDT)
Date: Mon, 18 May 2026 12:22:39 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>,
 "Andrew F. Davis" <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Andre Przywara <andre.przywara@arm.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Ion Agorria <ion@agorria.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 00/14] arm: am335x: Switch to upstream devicetree
Message-ID: <20260518182239.GA423423@bill-the-cat>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pGkMrxFKYt/cUQPJ"
Content-Disposition: inline
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
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


--pGkMrxFKYt/cUQPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 11:01:16AM +0200, Markus Schneider-Pargmann (TI) wr=
ote:

> The series is split into two logical groups:
>=20
> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>   with the current u-boot devicetree.
> - Patches 4-14: Make upstream devicetree working with uboot. This
>   adds tick-timer, adds compatibility of the board code for different
>   USB probing, makes SPL smaller and updates the defconfig.
>=20
> The series has been tested on am335x-evm. Note that I don't have all
> other boards built with the am335x_*evm_*defconfig, so tests are
> appreciated. buildman reports builds are working.
>=20
> Dependencies:
>   - net: cpsw: Add cpsw-switch DT binding support
>       https://lore.kernel.org/r/20260410-topic-cpsw-switch-v2026-07-next-=
v1-0-c914724b13e4@baylibre.com

After rebasing this on top of current next, I ran in to the problem of
am335x_hs_evm* doesn't build. This is because looking at
arch/arm/mach-omap2/config_secure.mk I see:
OF_LIST_TARGETS =3D $(patsubst %,arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG=
_OF_LIST)))
And that won't work with OF_UPSTREAM. Can you please respin and make
sure all of am335x builds? CI can help with this too:
https://docs.u-boot.org/en/latest/develop/ci_testing.html
Thanks.

>=20
> Best,
> Markus
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---
> Changes in v7:
> - Squash tick-timer patch for am335x-bonegreen-eco-u-boot into the patch
>   that adds tick-timer for all other boards.
> - Remove dependency on (SPL_)CLK for (SPL_)SIMPLE_PM_BUS as clocks are
>   optional now. Note I kept your reviewed-bys @Simon @Kory as I felt
>   like this is a small change of the patch
> - Fixup USB probing for OF_UPSTREAM. Initial version of the patch probed
>   USB host and USB gadget devices unconditionally. This is not necessary
>   and also not what the old code did. The old code probed the
>   ti-musb-wrapper driver which bound the usb host and usb gadget
>   drivers, but it did not probe them.
> - Add CONFIG_PHANDLE_CHECK_SEQ to defconfig as many of the devices in
>   the upstream devicetree have names like mmc@0 because they are within
>   ti-sysc device nodes. The config symbol should help sorting them
>   consistently anyways.
> - Link to v6: https://lore.kernel.org/r/20260415-topic-am33-evm-oftree-v2=
026-01-v6-0-94cde349bb01@baylibre.com
>=20
> Changes in v6:
> - Add patch to add am335x-bonegreen-eco-u-boot.dtsi which sets
>   tick-timer
> - Add patch to remove all devicetrees that were moved to OF_UPSTREAM
> - Link to v5: https://lore.kernel.org/r/20260410-topic-am33-evm-oftree-v2=
026-01-v5-0-4b9c7aca0e3e@baylibre.com
>=20
> Changes in v5:
> - Add patch to add lcdc on beagle bone black to all boot phases. Without
>   this patch booting uboot on bbb fails.
> - Add patch to split SIMPLE_PM_BUS into two, one for SPL and one for
>   normal u-boot. This was done to reduce the size of SPL.
> - Link to v4: https://lore.kernel.org/r/20260127-topic-am33-evm-oftree-v2=
026-01-v4-0-0dadb0710ce7@baylibre.com
>=20
> Changes in v4:
> - Add patch to enable SPL_OPTIMIZE_INLINING to reduce size and fix the
>   build
> - Link to v3: https://lore.kernel.org/r/20251204-topic-am33-evm-oftree-v2=
026-01-v3-0-3d1566ce4dc7@baylibre.com
>=20
> Changes in v3:
> - Add patch to unify all config variants for the am335x-evm and similar
>   boards. This also updates the upstream defconfig enablement patch to
>   effectively switch all config variants to OF_UPSTREAM.
> - Link to v2: https://lore.kernel.org/r/20251128-topic-am33-evm-oftree-v2=
026-01-v2-0-42a863304498@baylibre.com
>=20
> Changes in v2:
> - Most of the independent patches were extracted in smaller series
> - Added patch to add vidconsole for am335x-evm
> - Add chosen tick-timer to all devicetrees that are used with the
>   am335x_evm_defconfig
> - Link to v1: https://lore.kernel.org/r/20251118-topic-am33-evm-oftree-v2=
026-01-v1-0-91ce13c661e2@baylibre.com
>=20
> ---
> Markus Schneider-Pargmann (TI) (14):
>       arm: dts: am335x-evm: Add backlight to the panel
>       configs: am335x_evm_defconfig: Enable panel
>       include: configs: am335x_evm: Enable vidconsole
>       configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
>       configs: am335x_evm: Unify evm board defconfigs
>       am33xx: Avoid hard failure on USB probe issue
>       arm: dts: am335x-*-u-boot: Add chosen tick-timer
>       arm: dts: am335x-boneblack-u-boot: Add lcdc to all boot phases
>       am33xx: Fix comment about config symbols
>       am33xx: Support upstream devicetree USB device
>       dm: core: Split SIMPLE_PM_BUS into phases
>       configs: am335x_evm_defconfig: Switch to upstream devicetree
>       arm: dts: am335x: Remove unused uboot devicetrees
>       dm: core: Remove dependency on CLK
>=20
>  arch/arm/dts/Makefile                              |  11 -
>  arch/arm/dts/am335x-bone-common-u-boot.dtsi        |  14 +
>  arch/arm/dts/am335x-bone-u-boot.dtsi               |   6 +
>  arch/arm/dts/am335x-bone.dts                       |  23 -
>  arch/arm/dts/am335x-boneblack-u-boot.dtsi          |  17 +
>  arch/arm/dts/am335x-boneblack.dts                  | 174 -----
>  arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi      |   6 +
>  arch/arm/dts/am335x-bonegreen-eco.dts              |  53 --
>  arch/arm/dts/am335x-bonegreen-u-boot.dtsi          |   6 +
>  arch/arm/dts/am335x-bonegreen.dts                  |  14 -
>  arch/arm/dts/am335x-evm-u-boot.dtsi                |   6 +
>  arch/arm/dts/am335x-evm.dts                        | 766 ---------------=
------
>  arch/arm/dts/am335x-evmsk-u-boot.dtsi              |   6 +
>  arch/arm/dts/am335x-evmsk.dts                      | 730 ---------------=
-----
>  arch/arm/dts/am335x-icev2-u-boot.dtsi              |   4 +
>  arch/arm/dts/am335x-icev2.dts                      | 486 -------------
>  arch/arm/dts/am335x-pocketbeagle-u-boot.dtsi       |   6 +
>  arch/arm/dts/am335x-pocketbeagle.dts               | 237 -------
>  arch/arm/dts/am335x-sancloud-bbe-common.dtsi       |  67 --
>  .../am335x-sancloud-bbe-extended-wifi-u-boot.dtsi  |   6 +
>  arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts | 113 ---
>  arch/arm/dts/am335x-sancloud-bbe-lite.dts          |  50 --
>  arch/arm/dts/am335x-sancloud-bbe.dts               |  53 --
>  arch/arm/mach-omap2/am33xx/board.c                 |  23 +-
>  configs/am335x_evm.config                          |  87 +++
>  configs/am335x_evm_defconfig                       |  96 +--
>  configs/am335x_evm_spiboot_defconfig               |  85 +--
>  configs/am335x_hs_evm.config                       |  14 +
>  configs/am335x_hs_evm_defconfig                    |  95 +--
>  configs/am335x_hs_evm_uart_defconfig               |  94 +--
>  drivers/core/Kconfig                               |  10 +-
>  drivers/core/Makefile                              |   2 +-
>  include/configs/am335x_evm.h                       |   2 +
>  33 files changed, 227 insertions(+), 3135 deletions(-)
> ---
> base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
> change-id: 20251118-topic-am33-evm-oftree-v2026-01-ea701e03f8cf
> prerequisite-change-id: 20260410-topic-cpsw-switch-v2026-07-next-89e21f2d=
2446:v1
> prerequisite-patch-id: 896e00f13956d28e056dd63764ad8906a0b626ef
> prerequisite-patch-id: f612a9425d5a466c7585decbd8990d497a02cdfb
> prerequisite-patch-id: 9b18f917297f98b76a75f3d16536283b4c1bc76b
> prerequisite-patch-id: 2baa422fb10baa29bf4274a658eb7afba8c7b489
>=20
> Best regards,
> --=20
> Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>=20

--=20
Tom

--pGkMrxFKYt/cUQPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagtY7gAKCRAr4qD1Cr/k
CjucAP0e2xwxCbBqk39Bb36Jvrkga0WWJc/52JzLO9nJCgcCBAD/Vd2hOcblSHX9
Fj0OBPS4PjafhIlbujruvfBKMzrW0wc=
=1XJc
-----END PGP SIGNATURE-----

--pGkMrxFKYt/cUQPJ--
