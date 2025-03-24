Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED858C28B30
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 00:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2362F81B5B;
	Mon, 24 Mar 2025 01:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9432D81BC0; Mon, 24 Mar 2025 01:37:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 637248198B
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 01:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95C3E106F;
 Sun, 23 Mar 2025 17:37:56 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF66D3F58B;
 Sun, 23 Mar 2025 17:37:48 -0700 (PDT)
Date: Mon, 24 Mar 2025 00:37:25 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Mikhail
 Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>
Subject: Re: [PATCH 16/34] clk: sunxi: Add support for the A523 -R CCU
Message-ID: <20250324003725.5963c8bb@minigeek.lan>
In-Reply-To: <3340159.aeNJFYEL58@jernej-laptop>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-17-andre.przywara@arm.com>
 <3340159.aeNJFYEL58@jernej-laptop>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 23 Mar 2025 13:18:17 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi,

> Dne nedelja, 23. marec 2025 ob 12:35:26 Srednjeevropski standardni =C4=8D=
as je Andre Przywara napisal(a):
> > Add a clock driver for the PRCM clock controller on the Allwinner A523
> > family of SoCs, often also used with an "r" prefix or suffix.
> > This just describes the clock gates and reset lines for the few devices
> > that we would need, most prominently the R_I2C device for the PMIC.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/clk/sunxi/Kconfig      |  7 ++++++
> >  drivers/clk/sunxi/Makefile     |  1 +
> >  drivers/clk/sunxi/clk_a523_r.c | 44 ++++++++++++++++++++++++++++++++++
> >  drivers/clk/sunxi/clk_sunxi.c  |  5 ++++
> >  4 files changed, 57 insertions(+)
> >  create mode 100644 drivers/clk/sunxi/clk_a523_r.c
> >=20
> > diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
> > index 74e89b86301..1c1cc82719c 100644
> > --- a/drivers/clk/sunxi/Kconfig
> > +++ b/drivers/clk/sunxi/Kconfig
> > @@ -136,4 +136,11 @@ config CLK_SUN55I_A523
> >  	  This enables common clock driver support for platforms based
> >  	  on Allwinner A523/T527 SoC.
> > =20
> > +config CLK_SUN55I_A523_R
> > +	bool "Clock driver for Allwinner A523 generation PRCM"
> > +	default MACH_SUN55I_A523
> > +	help
> > +	  This enables common clock driver support for the PRCM
> > +	  in Allwinner A523/T527 SoCs.
> > +
> >  endif # CLK_SUNXI
> > diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> > index dd33eabe2ed..93b542cebcd 100644
> > --- a/drivers/clk/sunxi/Makefile
> > +++ b/drivers/clk/sunxi/Makefile
> > @@ -26,3 +26,4 @@ obj-$(CONFIG_CLK_SUN50I_H616) +=3D clk_h616.o
> >  obj-$(CONFIG_CLK_SUN50I_A64) +=3D clk_a64.o
> >  obj-$(CONFIG_CLK_SUN50I_A100) +=3D clk_a100.o
> >  obj-$(CONFIG_CLK_SUN55I_A523) +=3D clk_a523.o
> > +obj-$(CONFIG_CLK_SUN55I_A523_R) +=3D clk_a523_r.o
> > diff --git a/drivers/clk/sunxi/clk_a523_r.c b/drivers/clk/sunxi/clk_a52=
3_r.c
> > new file mode 100644
> > index 00000000000..e864ce16199
> > --- /dev/null
> > +++ b/drivers/clk/sunxi/clk_a523_r.c
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2024 Arm Ltd.
> > + */
> > +
> > +#include <clk-uclass.h>
> > +#include <dm.h>
> > +#include <clk/sunxi.h>
> > +#include <dt-bindings/clock/sun55i-a523-r-ccu.h>
> > +#include <dt-bindings/reset/sun55i-a523-r-ccu.h>
> > +#include <linux/bitops.h>
> > +
> > +static struct ccu_clk_gate a523_r_gates[] =3D {
> > +	[CLK_R_AHB]             =3D GATE_DUMMY,
> > +	[CLK_R_APB0]            =3D GATE_DUMMY,
> > +	[CLK_R_APB1]            =3D GATE_DUMMY,
> > +	[CLK_BUS_R_TWD]         =3D GATE(0x12c, BIT(0)),
> > +	[CLK_BUS_R_I2C0]        =3D GATE(0x19c, BIT(0)),
> > +	[CLK_BUS_R_I2C1]        =3D GATE(0x19c, BIT(1)),
> > +	[CLK_BUS_R_I2C2]        =3D GATE(0x19c, BIT(2)),
> > +	[CLK_BUS_R_RTC]         =3D GATE(0x20c, BIT(0)),
> > +};
> > +
> > +static struct ccu_reset a523_r_resets[] =3D {
> > +//	[RST_BUS_R_TIMER]       =3D RESET(0x11c, BIT(16)),
> > +	[RST_BUS_R_TWD]         =3D RESET(0x12c, BIT(16)),
> > +//	[RST_BUS_R_PWMCTRL]     =3D RESET(0x13c, BIT(16)),
> > +//	[RST_BUS_R_SPI]         =3D RESET(0x15c, BIT(16)),
> > +//	[RST_BUS_R_UART0]       =3D RESET(0x18c, BIT(16)),
> > +//	[RST_BUS_R_UART1]       =3D RESET(0x18c, BIT(17)),
> > +	[RST_BUS_R_I2C0]        =3D RESET(0x19c, BIT(16)),
> > +	[RST_BUS_R_I2C1]        =3D RESET(0x19c, BIT(17)),
> > +	[RST_BUS_R_I2C2]        =3D RESET(0x19c, BIT(18)),
> > +//	[RST_BUS_R_PPU1]        =3D RESET(0x1ac, BIT(17)),
> > +	[RST_BUS_R_RTC]         =3D RESET(0x20c, BIT(16)),
> > +//	[RST_BUS_R_CPUCFG]      =3D RESET(0x22c, BIT(16)), =20
>=20
> Any specific reason that you commented out some reset lines?

Ah yeah, looks like a leftover from development, more for documentation
purposes. In general we just mention lines that we actually need, and
that's not much from the PRCM CCU. I will just remove those lines,
shall we need, it's easy to bring them back.

Cheers,
Andre

>=20
> Best regards,
> Jernej
>=20
> > +};
> > +
> > +const struct ccu_desc a523_r_ccu_desc =3D {
> > +	.gates =3D a523_r_gates,
> > +	.resets =3D a523_r_resets,
> > +	.num_gates =3D ARRAY_SIZE(a523_r_gates),
> > +	.num_resets =3D ARRAY_SIZE(a523_r_resets),
> > +};
> > diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunx=
i.c
> > index 30baabaafcd..842a0541bd6 100644
> > --- a/drivers/clk/sunxi/clk_sunxi.c
> > +++ b/drivers/clk/sunxi/clk_sunxi.c
> > @@ -127,6 +127,7 @@ extern const struct ccu_desc h6_r_ccu_desc;
> >  extern const struct ccu_desc r40_ccu_desc;
> >  extern const struct ccu_desc v3s_ccu_desc;
> >  extern const struct ccu_desc a523_ccu_desc;
> > +extern const struct ccu_desc a523_r_ccu_desc;
> > =20
> >  static const struct udevice_id sunxi_clk_ids[] =3D {
> >  #ifdef CONFIG_CLK_SUN4I_A10
> > @@ -228,6 +229,10 @@ static const struct udevice_id sunxi_clk_ids[] =3D=
 {
> >  #ifdef CONFIG_CLK_SUN55I_A523
> >  	{ .compatible =3D "allwinner,sun55i-a523-ccu",
> >  	  .data =3D (ulong)&a523_ccu_desc },
> > +#endif
> > +#ifdef CONFIG_CLK_SUN55I_A523_R
> > +	{ .compatible =3D "allwinner,sun55i-a523-r-ccu",
> > +	  .data =3D (ulong)&a523_r_ccu_desc },
> >  #endif
> >  	{ }
> >  };
> >  =20
>=20
>=20
>=20
>=20

