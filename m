Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3A1CD98C5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 573DF849E0;
	Thu, 11 Jun 2026 04:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZhsfRdQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17BF6848A1; Wed, 10 Jun 2026 20:03:34 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5625B8486B
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 20:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-486304fa184so6199836b6e.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781114610; x=1781719410; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k0KOZIF/2otRM0RR9bDVpgAHrW1ZGRZGk+i/hIdl23w=;
 b=ZhsfRdQIyXmNRxHHNcMmyBmRISV0bf7geYv/p2M/YF0mMstSZ82KSfYGivSnK5mBsh
 cSpSNOQ1D8xkS4cPmuewWKk971GuCH2DOIinsyVV/SptQAZPYlcmrCkwvIETItvOLvc1
 uKuWojuXp15GPbcLOMo4cIgg0QmvSD7MtxM84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781114610; x=1781719410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0KOZIF/2otRM0RR9bDVpgAHrW1ZGRZGk+i/hIdl23w=;
 b=FBK/eJvd7eGKmhFqgvP2p7zWBkDMRzrgmfm5nv2k2pebOzVbeZUME0uU11R5Y27Jqh
 /1AJk6LBUo/vhBgpHM4l3DpAD6bl3EvcZO+BtxRxnF9ZbGcGB9nUP/V2g8K4qsSWvBsP
 /wiYvYdGgaixpsbxDS6ANdsJou28gopGnJbRlAsY6cUVZabWOKiaxMUlGvOM1FRJw5NH
 5u6ydqr+0ojbQGuqGZMmxdQbPo+QxVMLc9ZoVD6xduBetO5gO/yzku2WsoBp6SiYAlxQ
 cSHDBwghkU/YU8nZUxQFVL8o1MpnokMC0kuTVntyOsNGc+QODVz7CrsvfyURbBfICbaX
 wjiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+F4E41BdqvkJVujYdbssU9C5jXsVgcxgkgporRujcOnhkT/JiN3GhrPzjsQhQg5iFBfIUfamA=@lists.denx.de
X-Gm-Message-State: AOJu0YxOQY+JpkmZb/6jyQVtrce/ljK76FV0Hba3JeZ+Yiqyrh1reQDT
 TQ1Sr6l4noeaQDwmYR/7k5zPCfUpumNU7cTCmHagmkKTXR5+yeKqs6qJTFe0DKxbvpM=
X-Gm-Gg: Acq92OHSprkmCFL7rKu/hCyDwh7HggqQl6DLDlYRx1zXWeUzPgMaN559jYjzaFZZqT5
 eRlGzcDJXmMYztrpE9YfGo9bouDAbgkj5Imu68tAQ835B952rJUmM7DlfNQ6F0KA71guzRUgnyi
 sAAfkF4+qL0eVKiKHgHO7GrcV9wae0oEAWHV96YYZ8EnNvBTe+ubGqBizYXu+vcPwyIsXB8+dI9
 DRVSfPzXvBLmCM55PokfcwOVmuzrpWvlBXVX2cPdQ7a/B6J4siQIBg+oAyimx4TxxAROFtLmaPo
 IbaufH9R6OluiwBkOOer5zawbFQ0PsCqb6vUcWaJ39n7pzrfaDzAi0oE5BwickF9FvFJQL9fNnV
 +4Lll6bLehchRTS8dIVekLMwxHLrIAzkDK1c1SUSnogp6ucX1LvRETiAyHZ1BbJbWZByWXP6PvQ
 sLeZE9NbTiVuHwNvfWqx6E1qxluIgrkl+cNWZFLsf43ZSrwHPQlN1YdQK5pCI0tWdrtbCy7orHT
 QcaCZN8+JSDhaL1/w1aYVg7i3gjO1JdQecPQOCvvlFOkZQAupLtRnP1fvMdKQ==
X-Received: by 2002:a05:6808:180c:b0:479:db65:8dbc with SMTP id
 5614622812f47-486f01d5030mr6078390b6e.30.1781114609869; 
 Wed, 10 Jun 2026 11:03:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48713092854sm648857b6e.6.2026.06.10.11.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 11:03:28 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:03:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: BMC-SW <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Lukasz Majewski <lukma@denx.de>,
 ChiaWei Wang <chiawei_wang@aspeedtech.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>,
 Paul Kocialkowski <contact@paulk.fr>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>
Subject: Re: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
Message-ID: <20260610180324.GC382693@bill-the-cat>
References: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
 <TY2PPF5CB9A1BE61846EEBD7BD6648BE188F21A2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rd9QHcapXAAePXIu"
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE61846EEBD7BD6648BE188F21A2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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


--Rd9QHcapXAAePXIu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 02:17:53AM +0000, Ryan Chen wrote:
> Hello Tom,
> 	Will this AST2700 SoC patch series can been merged?

I expect to take v3 in to the next branch somewhat soon, thanks for your
patience.

> Ryan Chen
>=20
> > Subject: [PATCH v3 0/5] arm: aspeed: add initial AST2700 SoC support
> >=20
> > AST2700 is the 8th generation of Integrated Remote Management Processor
> > introduced by ASPEED Technology Inc. It is a Board Management Controller
> > (BMC) SoC family with a dual-die architecture:
> > SoC0 ("CPU" die with four ARM Cortex-A35 application cores) and
> > SoC1 ("IO" die with peripherals) each SoC have its own SCU PLLs, clock =
dividers
> > and reset domains.
> >=20
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> > Changes in v3:
> >   - mach: add "N: ast2700" to the ARM ASPEED MAINTAINERS entry.
> >   - Link to v2:
> > https://lore.kernel.org/r/20260520-ast2700_clk-v2-0-c778b2908e5e@aspeed=
te
> > ch.com
> > Changes in v2:
> >   - v1 only have clk driver, v2 apply full AST2700 platform and
> >     reset, clk, ram driver.
> >   - Move scu_ast2700.h from the clk patch into the mach-aspeed
> >   - patch so the SoC header is provided alongside the SoC code
> >     that consumes it.
> >   Link to v1:
> > https://lore.kernel.org/r/20260508-ast2700_clk-v1-1-2797a626a238@aspeedt
> > ech.com
> >=20
> > ---
> > Ryan Chen (5):
> >       arm: aspeed: add ASPEED AST2700 SoC family support
> >       arm: dts: aspeed: Add initial AST27xx SoC device tree
> >       clk: ast2700: add clock driver support
> >       reset: ast2700: add reset driver support
> >       ram: aspeed: add SDRAM controller driver for AST2700
> >=20
> >  MAINTAINERS                                    |   1 +
> >  arch/arm/dts/Makefile                          |   2 +
> >  arch/arm/dts/ast2700-evb.dts                   |  88 +++
> >  arch/arm/dts/ast2700-u-boot.dtsi               |  25 +
> >  arch/arm/dts/ast2700.dtsi                      | 693
> > ++++++++++++++++++
> >  arch/arm/include/asm/arch-aspeed/fmc_hdr.h     |  52 ++
> >  arch/arm/include/asm/arch-aspeed/platform.h    |  30 +-
> >  arch/arm/include/asm/arch-aspeed/scu.h         | 145 ++++
> >  arch/arm/include/asm/arch-aspeed/scu_ast2700.h | 514 +++++++++++++
> >  arch/arm/include/asm/arch-aspeed/sdram.h       | 137 ++++
> >  arch/arm/mach-aspeed/Kconfig                   |  11 +
> >  arch/arm/mach-aspeed/Makefile                  |   1 +
> >  arch/arm/mach-aspeed/ast2700/Kconfig           |  36 +
> >  arch/arm/mach-aspeed/ast2700/Makefile          |   2 +
> >  arch/arm/mach-aspeed/ast2700/arm64-mmu.c       |  43 ++
> >  arch/arm/mach-aspeed/ast2700/board_common.c    |  90 +++
> >  arch/arm/mach-aspeed/ast2700/cpu-info.c        | 114 +++
> >  arch/arm/mach-aspeed/ast2700/lowlevel_init.S   | 132 ++++
> >  arch/arm/mach-aspeed/ast2700/platform.c        |  64 ++
> >  board/aspeed/evb_ast2700/Kconfig               |  13 +
> >  board/aspeed/evb_ast2700/Makefile              |   1 +
> >  board/aspeed/evb_ast2700/evb_ast2700.c         |   5 +
> >  configs/evb-ast2700_defconfig                  | 149 ++++
> >  drivers/clk/aspeed/Makefile                    |   1 +
> >  drivers/clk/aspeed/clk_ast2700.c               | 952
> > +++++++++++++++++++++++++
> >  drivers/ram/aspeed/Kconfig                     |   4 +-
> >  drivers/ram/aspeed/Makefile                    |   2 +-
> >  drivers/ram/aspeed/sdram_ast2700.c             |  15 +-
> >  drivers/reset/Kconfig                          |   9 +
> >  drivers/reset/Makefile                         |   1 +
> >  drivers/reset/reset-ast2700.c                  |  82 +++
> >  include/configs/evb_ast2700.h                  |  58 ++
> >  32 files changed, 3463 insertions(+), 9 deletions(-)
> > ---
> > base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
> > change-id: 20260327-ast2700_clk-258eacb9d703
> >=20
> > Best regards,
> > --
> > Ryan Chen <ryan_chen@aspeedtech.com>
>=20

--=20
Tom

--Rd9QHcapXAAePXIu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaimm5QAKCRAr4qD1Cr/k
CpJlAQDYOVXIiv0J9cIZprUA1Wh16v0oEHrNfeN8ZC6q6M2+8wD7BNhmGTUW0NxH
HX8QEBiVpvgjWZwPL5juHOsmp4N7iAs=
=/PVL
-----END PGP SIGNATURE-----

--Rd9QHcapXAAePXIu--
