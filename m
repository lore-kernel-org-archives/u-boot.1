Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8664C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 17:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ECB483AC6;
	Wed,  6 Aug 2025 19:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785D883AC6; Wed,  6 Aug 2025 19:24:58 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C86983AC5
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 19:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id A58E41F00050
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:24:51 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 727D5B01264; Wed,  6 Aug 2025 17:24:50 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id D8624B01259;
 Wed,  6 Aug 2025 17:24:48 +0000 (UTC)
Date: Wed, 6 Aug 2025 19:24:47 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi <linux-sunxi@lists.linux.dev>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v2 02/11] sunxi: Split V3 and V3s support with a common
 option
Message-ID: <aJOP3wAAw0ZqibpX@collins>
References: <20250805174827.3696191-1-paulk@sys-base.io>
 <20250805174827.3696191-3-paulk@sys-base.io>
 <20250806012146.26121400@minigeek.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VIrHDtRM/kZT4jxx"
Content-Disposition: inline
In-Reply-To: <20250806012146.26121400@minigeek.lan>
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


--VIrHDtRM/kZT4jxx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Wed 06 Aug 25, 01:21, Andre Przywara a =C3=A9crit :
> On Tue,  5 Aug 2025 19:48:18 +0200
> Paul Kocialkowski <paulk@sys-base.io> wrote:
>=20
> Hi Paul,
>=20
> > From: Paul Kocialkowski <contact@paulk.fr>
> >=20
> > There are a few notable differences that are relevant to U-Boot, includ=
ing:
> > - different DRAM configuration due to the co-packaged DRAM chip in V3s;
> > - use of an external PMIC (typically an AXP209) on V3;
> > - extra pins available on V3, e.g. for UART1.
>=20
> Mmmh, to be honest I am not really convinced this is useful. The patch
> below looks roughly like a big s/MACH_SUN8I_V3S/MACH_SUN8I_V3_V3S/,
> which I am not sure is really worth it. We had not super accurate names
> before, after all those are just marketing names that Allwinner once
> came up with. So we use MACH_SUN55I_A523, even though it's mostly
> A527 or T527 chips, really, for instance.

Yes I think this case is a bit different because there is actually a differ=
ence
not just in the packaging and pins available but also because a dram die is
co-packaged with the sun8i chip.

> For the three actually differing items you mention above: I think we
> can treat the DRAM and external PMIC like board options, and could
> describe the extra pins either unconditionally or drop them at all (see
> my comment there).
>=20
> What do you think? Is that distinction on the Kconfig level really
> necessary?

I think it is preferable because the DRAM die co-packaged with the chip is
definitely not a board-specific choice, so I would rather see the DRAM-rela=
ted
details handled by the common Kconfig rather than duplicated over each V3s
board.

For the PMIC it mostly remains a board-specific option and is not enabled by
default anyway, it's just the defaults that are updated. Apparently there a=
re
designs with V3s that use an AXP209 PMIC so the defaults could actually go
to the common option.

Another approach here could be to keep a single MACH_SUN8I_V3 option and ha=
ve
an extra one to select the co-packaged DRAM that only V3s boards would sele=
ct
in their config. If it's the rename that bothers you we could keep the
MACH_SUN8I_V3S name but I think it would be significantly more confusing.

What do you think?

Paul

> Cheers,
> Andre
>=20
> > Move the exiting V3s config to a common option and introduce specific o=
ptions
> > for V3s and V3 to set specific aspects and reflect this all round the t=
ree.
> >=20
> > Also update the pinecube config to reflect the updated defaults.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  arch/arm/dts/Makefile                       |  2 +-
> >  arch/arm/include/asm/arch-sunxi/cpu.h       |  2 +-
> >  arch/arm/include/asm/arch-sunxi/cpu_sun4i.h |  2 +-
> >  arch/arm/mach-sunxi/Kconfig                 | 41 +++++++++++++--------
> >  arch/arm/mach-sunxi/board.c                 |  2 +-
> >  arch/arm/mach-sunxi/cpu_info.c              |  2 +
> >  arch/arm/mach-sunxi/dram_sunxi_dw.c         | 18 ++++-----
> >  arch/arm/mach-sunxi/spl_spi_sunxi.c         |  2 +-
> >  board/sunxi/board.c                         |  2 +-
> >  configs/pinecube_defconfig                  |  3 +-
> >  drivers/clk/sunxi/Kconfig                   |  2 +-
> >  drivers/phy/allwinner/Kconfig               |  2 +-
> >  drivers/pinctrl/sunxi/Kconfig               |  2 +-
> >  drivers/power/Kconfig                       |  2 +-
> >  14 files changed, 47 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 0dc7e190eb93..3d93679058c8 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -646,7 +646,7 @@ dtb-$(CONFIG_MACH_SUN8I_R40) +=3D \
> >  	sun8i-r40-oka40i-c.dtb \
> >  	sun8i-t3-cqa3t-bv3.dtb \
> >  	sun8i-v40-bananapi-m2-berry.dtb
> > -dtb-$(CONFIG_MACH_SUN8I_V3S) +=3D \
> > +dtb-$(CONFIG_MACH_SUN8I_V3_V3S) +=3D \
> >  	sun8i-s3-elimo-initium.dtb \
> >  	sun8i-s3-pinecube.dtb \
> >  	sun8i-v3-sl631-imx179.dtb \
> > diff --git a/arch/arm/include/asm/arch-sunxi/cpu.h b/arch/arm/include/a=
sm/arch-sunxi/cpu.h
> > index 768c6572d6b7..bd9dd97b890b 100644
> > --- a/arch/arm/include/asm/arch-sunxi/cpu.h
> > +++ b/arch/arm/include/asm/arch-sunxi/cpu.h
> > @@ -18,7 +18,7 @@
> > =20
> >  #define SOCID_A64	0x1689
> >  #define SOCID_H3	0x1680
> > -#define SOCID_V3S	0x1681
> > +#define SOCID_V3_V3S	0x1681
> >  #define SOCID_H5	0x1718
> >  #define SOCID_R40	0x1701
> > =20
> > diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h b/arch/arm/inc=
lude/asm/arch-sunxi/cpu_sun4i.h
> > index f023a4cfd934..3212b818286c 100644
> > --- a/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
> > +++ b/arch/arm/include/asm/arch-sunxi/cpu_sun4i.h
> > @@ -13,7 +13,7 @@
> > =20
> >  #if defined(CONFIG_SUNXI_GEN_SUN6I) && \
> >      !defined(CONFIG_MACH_SUN8I_R40) && \
> > -    !defined(CONFIG_MACH_SUN8I_V3S)
> > +    !defined(CONFIG_MACH_SUN8I_V3_V3S)
> >  #define SUNXI_SRAM_A2_BASE		0x00040000
> >  #ifdef CONFIG_MACH_SUN8I_H3
> >  #define SUNXI_SRAM_A2_SIZE		(48 * 1024)	/* 16+32 kiB */
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index 5a696095586e..f0faa9f80a23 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -476,17 +476,13 @@ config MACH_SUN8I_R528
> >  	select SUPPORT_SPL
> >  	select DRAM_SUN20I_D1
> > =20
> > +config MACH_SUN8I_V3
> > +	bool "sun8i (Allwinner V3/S3/S3L)"
> > +	select MACH_SUN8I_V3_V3S
> > +
> >  config MACH_SUN8I_V3S
> > -	bool "sun8i (Allwinner V3/V3s/S3/S3L)"
> > -	select CPU_V7A
> > -	select CPU_V7_HAS_NONSEC
> > -	select CPU_V7_HAS_VIRT
> > -	select ARCH_SUPPORT_PSCI
> > -	select SUNXI_GEN_SUN6I
> > -	select SUNXI_DRAM_DW
> > -	select SUNXI_DRAM_DW_16BIT
> > -	select SUPPORT_SPL
> > -	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
> > +	bool "sun8i (Allwinner V3s)"
> > +	select MACH_SUN8I_V3_V3S
> > =20
> >  config MACH_SUN9I
> >  	bool "sun9i (Allwinner A80)"
> > @@ -562,7 +558,20 @@ config MACH_SUN8I
> >  	default y if MACH_SUN8I_A83T
> >  	default y if MACH_SUNXI_H3_H5
> >  	default y if MACH_SUN8I_R40
> > -	default y if MACH_SUN8I_V3S
> > +	default y if MACH_SUN8I_V3_V3S
> > +
> > +config MACH_SUN8I_V3_V3S
> > +	bool "sun8i (Allwinner V3/V3s/S3/S3L)"
> > +	depends on MACH_SUN8I_V3 || MACH_SUN8I_V3S
> > +	select CPU_V7A
> > +	select CPU_V7_HAS_NONSEC
> > +	select CPU_V7_HAS_VIRT
> > +	select ARCH_SUPPORT_PSCI
> > +	select SUNXI_GEN_SUN6I
> > +	select SUNXI_DRAM_DW
> > +	select SUNXI_DRAM_DW_16BIT
> > +	select SUPPORT_SPL
> > +	select ARMV7_BOOT_SEC_DEFAULT if OLD_SUNXI_KERNEL_COMPAT
> > =20
> >  config RESERVE_ALLWINNER_BOOT0_HEADER
> >  	bool "reserve space for Allwinner boot0 header"
> > @@ -719,7 +728,7 @@ config DRAM_CLK
> >  	default 792 if MACH_SUN9I
> >  	default 648 if MACH_SUN8I_R40
> >  	default 360 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || \
> > -		       MACH_SUN8I_V3S
> > +		       MACH_SUN8I_V3_V3S
> >  	default 312 if MACH_SUN6I || MACH_SUN8I
> >  	default 672 if MACH_SUN50I
> >  	default 744 if MACH_SUN50I_H6
> > @@ -747,7 +756,7 @@ config DRAM_ZQ
> >  	default 123 if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I || \
> >  		       MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_A83T
> >  	default 127 if MACH_SUN7I
> > -	default 14779 if MACH_SUN8I_V3S
> > +	default 14779 if MACH_SUN8I_V3_V3S
> >  	default 3881979 if MACH_SUNXI_H3_H5 || MACH_SUN8I_R40 || MACH_SUN50I_=
H6
> >  	default 4145117 if MACH_SUN9I
> >  	default 3881915 if MACH_SUN50I
> > @@ -877,7 +886,7 @@ config SYS_SOC
> >  config SUNXI_MINIMUM_DRAM_MB
> >  	int "minimum DRAM size"
> >  	default 32 if MACH_SUNIV
> > -	default 64 if MACH_SUN8I_V3S
> > +	default 64 if MACH_SUN8I_V3_V3S
> >  	default 256
> >  	---help---
> >  	Minimum DRAM size expected on the board. Traditionally we assumed
> > @@ -963,7 +972,7 @@ config VIDEO_SUNXI
> >  	depends on !MACH_SUN8I_A83T
> >  	depends on !MACH_SUNXI_H3_H5
> >  	depends on !MACH_SUN8I_R40
> > -	depends on !MACH_SUN8I_V3S
> > +	depends on !MACH_SUN8I_V3_V3S
> >  	depends on !MACH_SUN9I
> >  	depends on !MACH_SUN50I
> >  	depends on !SUN50I_GEN_H6
> > @@ -1186,7 +1195,7 @@ config SPL_STACK_R_ADDR
> > =20
> >  config SPL_SPI_SUNXI
> >  	bool "Support for SPI Flash on Allwinner SoCs in SPL"
> > -	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5=
 || MACH_SUN50I || MACH_SUN8I_R40 || MACH_SUN8I_V3S || SUN50I_GEN_H6 || MAC=
H_SUNIV || SUNXI_GEN_NCAT2
> > +	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5=
 || MACH_SUN50I || MACH_SUN8I_R40 || MACH_SUN8I_V3_V3S || SUN50I_GEN_H6 || =
MACH_SUNIV || SUNXI_GEN_NCAT2
> >  	help
> >  	  Enable support for SPI Flash. This option allows SPL to read from
> >  	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
> > diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> > index fb4837c2082d..a1a02b0fae50 100644
> > --- a/arch/arm/mach-sunxi/board.c
> > +++ b/arch/arm/mach-sunxi/board.c
> > @@ -149,7 +149,7 @@ static int gpio_init(void)
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_A83T_GPB_UART0);
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN8I_A83T_GPB_UART0);
> >  	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
> > -#elif CONFIG_CONS_INDEX =3D=3D 1 && defined(CONFIG_MACH_SUN8I_V3S)
> > +#elif CONFIG_CONS_INDEX =3D=3D 1 && defined(CONFIG_MACH_SUN8I_V3_V3S)
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPB(8), SUN8I_V3S_GPB_UART0);
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_V3S_GPB_UART0);
> >  	sunxi_gpio_set_pull(SUNXI_GPB(9), SUNXI_GPIO_PULL_UP);
> > diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_i=
nfo.c
> > index c3a51d9956ec..5b03dcdc354d 100644
> > --- a/arch/arm/mach-sunxi/cpu_info.c
> > +++ b/arch/arm/mach-sunxi/cpu_info.c
> > @@ -90,6 +90,8 @@ int print_cpuinfo(void)
> >  	printf("CPU:   Allwinner H3 (SUN8I %04x)\n", sunxi_get_sram_id());
> >  #elif defined CONFIG_MACH_SUN8I_R40
> >  	printf("CPU:   Allwinner R40 (SUN8I %04x)\n", sunxi_get_sram_id());
> > +#elif defined CONFIG_MACH_SUN8I_V3
> > +	printf("CPU:   Allwinner V3/S3/S3L (SUN8I %04x)\n", sunxi_get_sram_id=
());
> >  #elif defined CONFIG_MACH_SUN8I_V3S
> >  	printf("CPU:   Allwinner V3s (SUN8I %04x)\n", sunxi_get_sram_id());
> >  #elif defined CONFIG_MACH_SUN8I_R528
> > diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/=
dram_sunxi_dw.c
> > index 4ed295909ceb..56d03027b933 100644
> > --- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
> > +++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
> > @@ -254,7 +254,7 @@ static void mctl_set_master_priority(uint16_t socid)
> >  	case SOCID_H3:
> >  		mctl_set_master_priority_h3();
> >  		return;
> > -	case SOCID_V3S:
> > +	case SOCID_V3_V3S:
> >  		mctl_set_master_priority_v3s();
> >  		return;
> >  	case SOCID_A64:
> > @@ -445,7 +445,7 @@ static void mctl_sys_init(uint16_t socid, struct dr=
am_para *para)
> >  				CCM_DRAMCLK_CFG_DIV(1) |
> >  				CCM_DRAMCLK_CFG_SRC_PLL11 |
> >  				CCM_DRAMCLK_CFG_UPD);
> > -	} else if (socid =3D=3D SOCID_H3 || socid =3D=3D SOCID_H5 || socid =
=3D=3D SOCID_V3S) {
> > +	} else if (socid =3D=3D SOCID_H3 || socid =3D=3D SOCID_H5 || socid =
=3D=3D SOCID_V3_V3S) {
> >  		clock_set_pll5(CONFIG_DRAM_CLK * 2 * 1000000, false);
> >  		clrsetbits_le32(&ccm->dram_clk_cfg,
> >  				CCM_DRAMCLK_CFG_DIV_MASK |
> > @@ -528,7 +528,7 @@ static int mctl_channel_init(uint16_t socid, struct=
 dram_para *para)
> >  		/* dphy & aphy phase select 270 degree */
> >  		clrsetbits_le32(&mctl_ctl->pgcr[2], (0x3 << 10) | (0x3 << 8),
> >  				(0x1 << 10) | (0x2 << 8));
> > -	} else if (socid =3D=3D SOCID_V3S) {
> > +	} else if (socid =3D=3D SOCID_V3_V3S) {
> >  		/* dx ddr_clk & hdr_clk dynamic mode */
> >  		clrbits_le32(&mctl_ctl->pgcr[0], (0x3 << 14) | (0x3 << 12));
> > =20
> > @@ -567,7 +567,7 @@ static int mctl_channel_init(uint16_t socid, struct=
 dram_para *para)
> >  	mctl_set_bit_delays(para);
> >  	udelay(50);
> > =20
> > -	if (socid =3D=3D SOCID_V3S) {
> > +	if (socid =3D=3D SOCID_V3_V3S) {
> >  		mctl_v3s_zq_calibration_quirk(para);
> > =20
> >  		mctl_phy_init(PIR_PLLINIT | PIR_DCAL | PIR_PHYRST |
> > @@ -636,7 +636,7 @@ static int mctl_channel_init(uint16_t socid, struct=
 dram_para *para)
> >  	udelay(10);
> > =20
> >  	/* set PGCR3, CKE polarity */
> > -	if (socid =3D=3D SOCID_H3 || socid =3D=3D SOCID_V3S)
> > +	if (socid =3D=3D SOCID_H3 || socid =3D=3D SOCID_V3_V3S)
> >  		writel(0x00aa0060, &mctl_ctl->pgcr[3]);
> >  	else if (socid =3D=3D SOCID_A64 || socid =3D=3D SOCID_H5 || socid =3D=
=3D SOCID_R40)
> >  		writel(0xc0aa0060, &mctl_ctl->pgcr[3]);
> > @@ -758,7 +758,7 @@ static void mctl_auto_detect_dram_size(uint16_t soc=
id, struct dram_para *para)
> >  	   0,  0,  0,  0,  0,  0,  0,  0,			\
> >  	   0,  0,  0,  0,  0,  0,  0      }
> > =20
> > -#define SUN8I_V3S_DX_READ_DELAYS					\
> > +#define SUN8I_V3S_DX_READ_DELAYS				\
> >  	{{  8,  8,  8,  8,  8,  8,  8,  8,  8,  0,  0 },	\
> >  	 {  7,  7,  7,  7,  7,  7,  7,  7,  7,  0,  0 },	\
> >  	 {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 },	\
> > @@ -851,7 +851,7 @@ unsigned long sunxi_dram_init(void)
> >  		.dx_read_delays  =3D SUN8I_H3_DX_READ_DELAYS,
> >  		.dx_write_delays =3D SUN8I_H3_DX_WRITE_DELAYS,
> >  		.ac_delays	 =3D SUN8I_H3_AC_DELAYS,
> > -#elif defined(CONFIG_MACH_SUN8I_V3S)
> > +#elif defined(CONFIG_MACH_SUN8I_V3_V3S)
> >  		.dx_read_delays  =3D SUN8I_V3S_DX_READ_DELAYS,
> >  		.dx_write_delays =3D SUN8I_V3S_DX_WRITE_DELAYS,
> >  		.ac_delays	 =3D SUN8I_V3S_AC_DELAYS,
> > @@ -878,8 +878,8 @@ unsigned long sunxi_dram_init(void)
> >  	uint16_t socid =3D SOCID_H3;
> >  #elif defined(CONFIG_MACH_SUN8I_R40)
> >  	uint16_t socid =3D SOCID_R40;
> > -#elif defined(CONFIG_MACH_SUN8I_V3S)
> > -	uint16_t socid =3D SOCID_V3S;
> > +#elif defined(CONFIG_MACH_SUN8I_V3_V3S)
> > +	uint16_t socid =3D SOCID_V3_V3S;
> >  #elif defined(CONFIG_MACH_SUN50I)
> >  	uint16_t socid =3D SOCID_A64;
> >  #elif defined(CONFIG_MACH_SUN50I_H5)
> > diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/=
spl_spi_sunxi.c
> > index 5f72e809952b..f6650652b42a 100644
> > --- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
> > +++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> > @@ -141,7 +141,7 @@ static bool is_sun6i_gen_spi(void)
> >  	return IS_ENABLED(CONFIG_SUNXI_GEN_SUN6I) ||
> >  	       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
> >  	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2) ||
> > -	       IS_ENABLED(CONFIG_MACH_SUN8I_V3S);
> > +	       IS_ENABLED(CONFIG_MACH_SUN8I_V3_V3S);
> >  }
> > =20
> >  static uintptr_t spi0_base_address(void)
> > diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> > index 2929bc17f084..6520636ffab5 100644
> > --- a/board/sunxi/board.c
> > +++ b/board/sunxi/board.c
> > @@ -68,7 +68,7 @@ void i2c_init_board(void)
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPH(14), SUN6I_GPH_TWI0);
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPH(15), SUN6I_GPH_TWI0);
> >  	clock_twi_onoff(0, 1);
> > -#elif defined(CONFIG_MACH_SUN8I_V3S)
> > +#elif defined(CONFIG_MACH_SUN8I_V3_V3S)
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPB(6), SUN8I_V3S_GPB_TWI0);
> >  	sunxi_gpio_set_cfgpin(SUNXI_GPB(7), SUN8I_V3S_GPB_TWI0);
> >  	clock_twi_onoff(0, 1);
> > diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
> > index 7567a6aa7394..088dd6f8630a 100644
> > --- a/configs/pinecube_defconfig
> > +++ b/configs/pinecube_defconfig
> > @@ -2,8 +2,7 @@ CONFIG_ARM=3Dy
> >  CONFIG_ARCH_SUNXI=3Dy
> >  CONFIG_DEFAULT_DEVICE_TREE=3D"sun8i-s3-pinecube"
> >  CONFIG_SPL=3Dy
> > -CONFIG_MACH_SUN8I_V3S=3Dy
> > -CONFIG_SUNXI_DRAM_DDR3_1333=3Dy
> > +CONFIG_MACH_SUN8I_V3=3Dy
> >  CONFIG_DRAM_CLK=3D504
> >  CONFIG_DRAM_ODT_EN=3Dy
> >  CONFIG_I2C0_ENABLE=3Dy
> > diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
> > index 1c1cc82719cd..207d3bed7922 100644
> > --- a/drivers/clk/sunxi/Kconfig
> > +++ b/drivers/clk/sunxi/Kconfig
> > @@ -68,7 +68,7 @@ config CLK_SUN8I_R40
> > =20
> >  config CLK_SUN8I_V3S
> >  	bool "Clock driver for Allwinner V3S"
> > -	default MACH_SUN8I_V3S
> > +	default MACH_SUN8I_V3_V3S
> >  	help
> >  	  This enables common clock driver support for platforms based
> >  	  on Allwinner V3S SoC.
> > diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kcon=
fig
> > index bb0bd8d5f812..335eff0a8bac 100644
> > --- a/drivers/phy/allwinner/Kconfig
> > +++ b/drivers/phy/allwinner/Kconfig
> > @@ -5,7 +5,7 @@ config PHY_SUN4I_USB
> >  	bool "Allwinner Sun4I USB PHY driver"
> >  	depends on ARCH_SUNXI
> >  	depends on !MACH_SUN9I
> > -	default n if MACH_SUN8I_V3S
> > +	default n if MACH_SUN8I_V3_V3S
> >  	default y
> >  	select DM_REGULATOR
> >  	select PHY
> > diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kcon=
fig
> > index 543149922998..59039917158e 100644
> > --- a/drivers/pinctrl/sunxi/Kconfig
> > +++ b/drivers/pinctrl/sunxi/Kconfig
> > @@ -76,7 +76,7 @@ config PINCTRL_SUN8I_H3_R
> > =20
> >  config PINCTRL_SUN8I_V3S
> >  	bool "Support for the Allwinner V3s PIO"
> > -	default MACH_SUN8I_V3S
> > +	default MACH_SUN8I_V3_V3S
> >  	select PINCTRL_SUNXI
> > =20
> >  config PINCTRL_SUN9I_A80
> > diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> > index eed65058e667..cdb3d712389c 100644
> > --- a/drivers/power/Kconfig
> > +++ b/drivers/power/Kconfig
> > @@ -75,7 +75,7 @@ config AXP152_POWER
> > =20
> >  config AXP209_POWER
> >  	bool "axp209 pmic support"
> > -	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_V3S
> > +	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_V3
> >  	select AXP_PMIC_BUS
> >  	select CMD_POWEROFF
> >  	---help---
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--VIrHDtRM/kZT4jxx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmiTj98ACgkQhP3B6o/u
lQw2xA//UmpDALizcXQ6cgAnlTC48jdewCLjzzfZ301hz4K3qqjAu9Lor7VxFhWS
u2DWCNIxtGv2D49gMtHJdTRNYFMnBBVW4wP0GwHPcEocsJGIacXFftA08W0IPU0Y
ndCAbNEqUZ0xxRD+TcR5+ZzpfxkUw9YDzswMsJ3diF9ks2RP2lC2LXxPbnwbAx5n
LHjbbzeH4KgC+Sr1oL1T3IcBBeSydkv5b2N3pDLGLnW5LwXZyfygTuodbFIuifCM
B3pWXXsXnNT+8gikkSodhmn3O9V0fuicyIsKaBLF/WpVl1Not4HiEOSXeEPCtS6N
TMImmHVm/UzqOfB3gryAStyyFvTNYb/8A77nLppIT8QqFNgfzdD0DYDFCwRx7b/o
9ExhUMlJWNR9Y5oUisRm4GCtmrqSugZDo2ujquQkwm4vPKNMjaebl1xcPrsjW1zh
uxX5osuNs1sN+PWEhNIHXS21ns7OF+VubHY6DPKNdgCeHD2ovDIRnGqSek1uFVES
58bhzQ5MXg3+LvF7lScLuiaz++mHkw/QKN4amAOWNvg45hSsqmfpRPcDqYlJ45/t
e4yqs3VEkdVFS49jxZ6abFmSi4yVj0BgiIh13buyvW96TyNPqfs2pdhZtxo/9TiA
wg2hFyDxIKGZJNVBZ9tBe1XY5Ni8MGw9FarI7or+V3SK1jg2gUM=
=g1X+
-----END PGP SIGNATURE-----

--VIrHDtRM/kZT4jxx--
