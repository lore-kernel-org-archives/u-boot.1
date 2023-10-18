Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073CBCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 16:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 274F886FD2;
	Wed, 18 Oct 2023 18:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BEB386FDF; Wed, 18 Oct 2023 18:21:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6379186F2A
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 18:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A36532F4;
 Wed, 18 Oct 2023 09:21:54 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AB383F64C;
 Wed, 18 Oct 2023 09:21:12 -0700 (PDT)
Date: Wed, 18 Oct 2023 17:21:09 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Piotr
 Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] sunxi: H616: add LPDDR4 DRAM support
Message-ID: <20231018172109.085cce24@donnerap.manchester.arm.com>
In-Reply-To: <20231016053441.3197087-2-iuncuim@gmail.com>
References: <20231016053441.3197087-1-iuncuim@gmail.com>
 <20231016053441.3197087-2-iuncuim@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Mon, 16 Oct 2023 08:34:41 +0300
Mikhail Kalashnikov <iuncuim@gmail.com> wrote:

Hi Mikhail,

many thanks for resending this, and particularly for making this work on
the OrangePi Zero3!

> From: iuncuim <iuncuim@gmail.com>
>=20
> The H616 SoC family has support for several types of DRAM: DDR3,
> LPDDR3, DDR4 and LPDDR4.
> At the moment, the driver only supports DDR3 and LPDDR3 memory.
> Let's extend the driver to support the LPDDR4 memory. This type
> of memory widely used in device with T507(-H) SoC and new orangepi
> zero3 with H618.
> The compatibility with T507 is not yet complete, because there
> is difference in the phy_init array.
> The LPDDR4-2133 timings correspond to DRAM Rayson RS1G32LO4D2BDS-53BT
> found on the Orangepi Zero 3 4GB.
>=20
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
>=20
> ---
>  .../include/asm/arch-sunxi/dram_sun50i_h616.h |   2 +
>  arch/arm/mach-sunxi/Kconfig                   |  16 ++
>  arch/arm/mach-sunxi/dram_sun50i_h616.c        | 176 ++++++++++++++----
>  arch/arm/mach-sunxi/dram_timings/Makefile     |   1 +
>  .../dram_timings/h616_lpddr4_2133.c           |  97 ++++++++++
>  5 files changed, 258 insertions(+), 34 deletions(-)
>  create mode 100644 arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/ar=
m/include/asm/arch-sunxi/dram_sun50i_h616.h
> index 11774deded..a8fdda124a 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> @@ -130,6 +130,7 @@ check_member(sunxi_mctl_ctl_reg, unk_0x4240, 0x4240);
>  #define MSTR_DEVICETYPE_LPDDR2	BIT(2)
>  #define MSTR_DEVICETYPE_LPDDR3	BIT(3)
>  #define MSTR_DEVICETYPE_DDR4	BIT(4)
> +#define MSTR_DEVICETYPE_LPDDR4	BIT(5)
>  #define MSTR_DEVICETYPE_MASK	GENMASK(5, 0)
>  #define MSTR_2TMODE		BIT(10)
>  #define MSTR_BUSWIDTH_FULL	(0 << 12)
> @@ -154,6 +155,7 @@ struct dram_para {
>  	u32 odt_en;
>  	u32 tpr0;
>  	u32 tpr2;
> +	u32 tpr6;
>  	u32 tpr10;
>  	u32 tpr11;
>  	u32 tpr12;
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 9d5df2c102..71e2f40b9e 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -85,6 +85,11 @@ config DRAM_SUN50I_H616_TPR2
>  	help
>  	  TPR2 value from vendor DRAM settings.
> =20
> +config DRAM_SUN50I_H616_TPR6
> +	hex "H616 DRAM TPR6 parameter"

I think that deserves some default value, otherwise a simple "make" for
existing boards will now ask for that value.
What about 0x3300c080? Looking down, that should cover the existing cases,
since the different DDR types use different bytes in this word?

> +	help
> +	  TPR6 value from vendor DRAM settings.
> +
>  config DRAM_SUN50I_H616_TPR10
>  	hex "H616 DRAM TPR10 parameter"
>  	help
> @@ -441,6 +446,9 @@ config SUNXI_DRAM_DDR2
>  config SUNXI_DRAM_LPDDR3
>  	bool
> =20
> +config SUNXI_DRAM_LPDDR4
> +	bool
> +
>  choice
>  	prompt "DRAM Type and Timing"
>  	default SUNXI_DRAM_DDR3_1333 if !MACH_SUN8I_V3S
> @@ -484,6 +492,14 @@ config SUNXI_DRAM_H616_LPDDR3
>  	  This option is the LPDDR3 timing used by the stock boot0 by
>  	  Allwinner.
> =20
> +config SUNXI_DRAM_H616_LPDDR4
> +	bool "LPDDR4 DRAM chips on the H616 DRAM controller"
> +	select SUNXI_DRAM_LPDDR4
> +	depends on DRAM_SUN50I_H616
> +	help
> +	  This option is the LPDDR4 timing used by the stock boot0 by
> +	  Allwinner.
> +
>  config SUNXI_DRAM_H616_DDR3_1333
>  	bool "DDR3-1333 boot0 timings on the H616 DRAM controller"
>  	select SUNXI_DRAM_DDR3
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi=
/dram_sun50i_h616.c
> index ba5659d409..2c4b47bae7 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -238,6 +238,11 @@ static const u8 phy_init[] =3D {
>  	0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
>  	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
>  	0x17, 0x19, 0x1a
> +#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
> +	0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
> +	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
> +	0x18, 0x03, 0x1a
>  #endif
>  };
> =20
> @@ -246,8 +251,13 @@ static void mctl_phy_configure_odt(const struct dram=
_para *para)
>  {
>  	uint32_t val_lo, val_hi;
> =20
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x390, BIT(5), BIT(4));
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3d0, BIT(5), BIT(4));
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x410, BIT(5), BIT(4));
> +	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x450, BIT(5), BIT(4));
> +
>  	val_lo =3D para->dx_dri;
> -	val_hi =3D para->dx_dri;
> +	val_hi =3D (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4) ? 0x04040404 : pa=
ra->dx_dri;
>  	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x388);
>  	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x38c);
>  	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c8);
> @@ -265,7 +275,7 @@ static void mctl_phy_configure_odt(const struct dram_=
para *para)
>  	writel_relaxed(MASK_BYTE(val_hi, 1), SUNXI_DRAM_PHY0_BASE + 0x34c);
> =20
>  	val_lo =3D (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3) ? 0 : para->dx_od=
t;
> -	val_hi =3D para->dx_odt;
> +	val_hi =3D (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4) ? 0 : para->dx_od=
t;
>  	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x380);
>  	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x384);
>  	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c0);
> @@ -791,8 +801,9 @@ static void mctl_phy_ca_bit_delay_compensation(const =
struct dram_para *para,
>  	writel(val, SUNXI_DRAM_PHY0_BASE + 0x7e0);
>  	writel(val, SUNXI_DRAM_PHY0_BASE + 0x7f4);
> =20
> -	if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR3) {
> -		val =3D (para->tpr10 >> 7) & 0x1e;
> +	val =3D (para->tpr10 >> 7) & 0x1e;
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:

Having a switch/case is a good idea, however you need to cover all
values of the enum then:
arch/arm/mach-sunxi/dram_sun50i_h616.c: In function
=E2=80=98mctl_phy_ca_bit_delay_compensation=E2=80=99:
arch/arm/mach-sunxi/dram_sun50i_h616.c:805:2: warning: enumeration value
=E2=80=98SUNXI_DRAM_TYPE_DDR4=E2=80=99 not handled in switch [-Wswitch] 805=
 |  switch
(para->type) {

I suggest having a "default:" clause below, either doing nothing,
panicking, or reporting an supported DRAM type (as a debug message).

>  		if (para->tpr2 & 1) {
>  			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
>  			if (config->ranks =3D=3D 2) {
> @@ -818,8 +829,8 @@ static void mctl_phy_ca_bit_delay_compensation(const =
struct dram_para *para,
>  				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7b8);
>  			}
>  		}
> -	} else if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3) {
> -		val =3D (para->tpr10 >> 7) & 0x1e;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
>  		if (para->tpr2 & 1) {
>  			writel(val, SUNXI_DRAM_PHY0_BASE + 0x7a0);
>  			if (config->ranks =3D=3D 2) {
> @@ -833,7 +844,15 @@ static void mctl_phy_ca_bit_delay_compensation(const=
 struct dram_para *para,
>  				writel(val, SUNXI_DRAM_PHY0_BASE + 0x7f8);
>  			}
>  		}
> -	}
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		if (para->tpr2 & 1) {
> +			writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
> +		} else {
> +			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
> +		};
> +		break;
> +	};
>  }
> =20
>  static bool mctl_phy_init(const struct dram_para *para,
> @@ -846,30 +865,39 @@ static bool mctl_phy_init(const struct dram_para *p=
ara,
>  	u32 val, val2, *ptr, mr0, mr2;
>  	int i;
> =20
> +	if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4)
> +		clrbits_le32(SUNXI_DRAM_PHY0_BASE + 0x4,0x80);
> +
>  	if (config->bus_full_width)
>  		val =3D 0xf;
>  	else
>  		val =3D 3;
>  	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 0x3c, 0xf, val);
> =20
> -	if (para->tpr2 & 0x100) {
> -		if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR3) {
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		if (para->tpr2 & 0x100) {
>  			val =3D 9;
>  			val2 =3D 7;
> -		} else if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3) {
> -			// untested setup: use some values for now
> -			val =3D 14;
> -			val2 =3D 8;
> -		}
> -	} else {
> -		if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR3) {
> +		} else {
>  			val =3D 13;
>  			val2 =3D 9;
> -		} else if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3) {
> +		}
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		if (para->tpr2 & 0x100) {
> +			val =3D 12;
> +			val2 =3D 6;
> +		} else {
>  			val =3D 14;
>  			val2 =3D 8;
>  		}
> -	}
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		val =3D 20;
> +		val2 =3D 10;
> +		break;
> +	};
> =20
>  	writel(val, SUNXI_DRAM_PHY0_BASE + 0x14);
>  	writel(val, SUNXI_DRAM_PHY0_BASE + 0x35c);
> @@ -893,19 +921,37 @@ static bool mctl_phy_init(const struct dram_para *p=
ara,
>  	if (para->tpr10 & TPR10_CA_BIT_DELAY)
>  		mctl_phy_ca_bit_delay_compensation(para, config);
> =20
> -	if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR3)
> +	switch (para->type) {

Same comment about including all DRAM types in the enum as above - and for
more occurrences down below.

> +	case SUNXI_DRAM_TYPE_DDR3:
> +		val =3D para->tpr6 & 0xff;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		val =3D para->tpr6 >> 8 & 0xff;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		val =3D para->tpr6 >> 24 & 0xff;
> +		if (val =3D=3D 0)
> +			val =3D 0x33;

Why is this? If we control tpr6, we can surely put the right value into
Kconfig/defconfig?

> +		break;
> +	};
> +	if (val =3D=3D 0)
>  		val =3D 0x80;

Same here, now that tpr6 comes from Kconfig we don't need to adjust it.

> -	else if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3)
> -		val =3D 0xc0;
>  	writel(val, SUNXI_DRAM_PHY0_BASE + 0x3dc);
>  	writel(val, SUNXI_DRAM_PHY0_BASE + 0x45c);
> =20
>  	mctl_phy_configure_odt(para);
> =20
> -	if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR3)
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
>  		val =3D 0x0a;
> -	else if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3)
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
>  		val =3D 0x0b;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		val =3D 0x0d;
> +		break;
> +	};
>  	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 4, 0x7, val);
> =20
>  	if (para->clk <=3D 672)
> @@ -955,8 +1001,8 @@ static bool mctl_phy_init(const struct dram_para *pa=
ra,
>  		mr0 =3D 0x1f14;
>  		mr2 =3D 0x20;
>  	}
> -
> -	if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR3) {
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
>  		writel(mr0, &mctl_ctl->mrctrl1);
>  		writel(0x80000030, &mctl_ctl->mrctrl0);
>  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> @@ -972,7 +1018,8 @@ static bool mctl_phy_init(const struct dram_para *pa=
ra,
>  		writel(0, &mctl_ctl->mrctrl1);
>  		writel(0x80003030, &mctl_ctl->mrctrl0);
>  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> -	} else if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3) {
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
>  		writel(mr0, &mctl_ctl->mrctrl1);
>  		writel(0x800000f0, &mctl_ctl->mrctrl0);
>  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> @@ -988,7 +1035,45 @@ static bool mctl_phy_init(const struct dram_para *p=
ara,
>  		writel(0x301, &mctl_ctl->mrctrl1);
>  		writel(0x800000f0, &mctl_ctl->mrctrl0);
>  		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> -	}
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		writel(0x0, &mctl_ctl->mrctrl1);
> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> +
> +		writel(0x134, &mctl_ctl->mrctrl1);
> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> +
> +		writel(0x21b, &mctl_ctl->mrctrl1);
> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> +
> +		writel(0x333, &mctl_ctl->mrctrl1);
> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> +
> +		writel(0x403, &mctl_ctl->mrctrl1);
> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> +
> +		writel(0xb04, &mctl_ctl->mrctrl1);
> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> +
> +		writel(0xc72, &mctl_ctl->mrctrl1);
> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> +
> +		writel(0xe09, &mctl_ctl->mrctrl1);
> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> +
> +		writel(0x1624, &mctl_ctl->mrctrl1);
> +		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
> +		break;
> +	};
> =20
>  	writel(0, SUNXI_DRAM_PHY0_BASE + 0x54);
> =20
> @@ -1055,6 +1140,9 @@ static bool mctl_ctrl_init(const struct dram_para *=
para,
>  	clrsetbits_le32(&mctl_com->unk_0x500, BIT(24), 0x200);
>  	writel(0x8000, &mctl_ctl->clken);
> =20
> +	if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4)
> +		writel(1, SUNXI_DRAM_COM_BASE + 0x50);
> +
>  	setbits_le32(&mctl_com->unk_0x008, 0xff00);
> =20
>  	clrsetbits_le32(&mctl_ctl->sched[0], 0xff00, 0x3000);
> @@ -1063,11 +1151,18 @@ static bool mctl_ctrl_init(const struct dram_para=
 *para,
> =20
>  	setbits_le32(&mctl_com->unk_0x008, 0xff00);
> =20
> -	reg_val =3D MSTR_BURST_LENGTH(8) | MSTR_ACTIVE_RANKS(config->ranks);
> -	if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR3)
> -		reg_val |=3D MSTR_DEVICETYPE_DDR3 | MSTR_2TMODE;
> -	else if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3)
> -		reg_val |=3D MSTR_DEVICETYPE_LPDDR3;
> +	reg_val =3D MSTR_ACTIVE_RANKS(config->ranks);
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		reg_val |=3D MSTR_BURST_LENGTH(8) | MSTR_DEVICETYPE_DDR3 | MSTR_2TMODE;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +		reg_val |=3D MSTR_BURST_LENGTH(8) | MSTR_DEVICETYPE_LPDDR3;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		reg_val |=3D MSTR_BURST_LENGTH(16) | MSTR_DEVICETYPE_LPDDR4;
> +		break;
> +	};
>  	if (config->bus_full_width)
>  		reg_val |=3D MSTR_BUSWIDTH_FULL;
>  	else
> @@ -1079,10 +1174,17 @@ static bool mctl_ctrl_init(const struct dram_para=
 *para,
>  	else
>  		writel(0x0201, &mctl_ctl->odtmap);
> =20
> -	if (para->type =3D=3D SUNXI_DRAM_TYPE_DDR3)
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_DDR3:
>  		reg_val =3D 0x06000400;
> -	else if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR3)
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR3:
>  		reg_val =3D 0x09020400;
> +		break;
> +	case SUNXI_DRAM_TYPE_LPDDR4:
> +		reg_val =3D 0x04000400;
> +		break;
> +	};
>  	writel(reg_val, &mctl_ctl->odtcfg);
>  	writel(reg_val, &mctl_ctl->unk_0x2240);
>  	writel(reg_val, &mctl_ctl->unk_0x3240);
> @@ -1102,6 +1204,9 @@ static bool mctl_ctrl_init(const struct dram_para *=
para,
>  	setbits_le32(&mctl_ctl->unk_0x3180, BIT(31) | BIT(30));
>  	setbits_le32(&mctl_ctl->unk_0x4180, BIT(31) | BIT(30));
> =20
> +	if (para->type =3D=3D SUNXI_DRAM_TYPE_LPDDR4)
> +		setbits_le32(&mctl_ctl->dbictl, 0x1);
> +
>  	setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
>  	clrbits_le32(&mctl_ctl->dfimisc, BIT(0));
> =20
> @@ -1224,6 +1329,8 @@ static const struct dram_para para =3D {
>  	.type =3D SUNXI_DRAM_TYPE_DDR3,
>  #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
>  	.type =3D SUNXI_DRAM_TYPE_LPDDR3,
> +#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
> +	.type =3D SUNXI_DRAM_TYPE_LPDDR4,
>  #endif
>  	.dx_odt =3D CONFIG_DRAM_SUN50I_H616_DX_ODT,
>  	.dx_dri =3D CONFIG_DRAM_SUN50I_H616_DX_DRI,
> @@ -1231,6 +1338,7 @@ static const struct dram_para para =3D {
>  	.odt_en =3D CONFIG_DRAM_SUN50I_H616_ODT_EN,
>  	.tpr0 =3D CONFIG_DRAM_SUN50I_H616_TPR0,
>  	.tpr2 =3D CONFIG_DRAM_SUN50I_H616_TPR2,
> +	.tpr6 =3D CONFIG_DRAM_SUN50I_H616_TPR6,
>  	.tpr10 =3D CONFIG_DRAM_SUN50I_H616_TPR10,
>  	.tpr11 =3D CONFIG_DRAM_SUN50I_H616_TPR11,
>  	.tpr12 =3D CONFIG_DRAM_SUN50I_H616_TPR12,
> diff --git a/arch/arm/mach-sunxi/dram_timings/Makefile b/arch/arm/mach-su=
nxi/dram_timings/Makefile
> index 8bfd99448a..5f20341924 100644
> --- a/arch/arm/mach-sunxi/dram_timings/Makefile
> +++ b/arch/arm/mach-sunxi/dram_timings/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_SUNXI_DRAM_H6_LPDDR3)	+=3D h6_lpddr3.o
>  obj-$(CONFIG_SUNXI_DRAM_H6_DDR3_1333)	+=3D h6_ddr3_1333.o
>  obj-$(CONFIG_SUNXI_DRAM_H616_DDR3_1333)	+=3D h616_ddr3_1333.o
>  obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR3)	+=3D h616_lpddr3.o
> +obj-$(CONFIG_SUNXI_DRAM_H616_LPDDR4)	+=3D h616_lpddr4_2133.o
> diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/a=
rm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> new file mode 100644
> index 0000000000..cfb938af12
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> @@ -0,0 +1,97 @@
> +/*
> + * sun50i H616 LPDDR4-2133 timings, as programmed by Allwinner's boot0
> + *
> + * The chips are probably able to be driven by a faster clock, but boot0
> + * uses a more conservative timing (as usual).
> + *
> + * (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
> + * Based on H6 DDR3 timings:
> + * (C) Copyright 2018,2019 Arm Ltd.
> + *
> + * SPDX-License-Identifier:	GPL-2.0+
> + */
> +
> +#include <common.h>
> +#include <asm/arch/dram.h>
> +#include <asm/arch/cpu.h>
> +
> +void mctl_set_timing_params(const struct dram_para *para)
> +{
> +	struct sunxi_mctl_ctl_reg * const mctl_ctl =3D
> +			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +
> +	u8 tccd		=3D 4;			/* JEDEC: 4nCK */
> +	u8 tfaw		=3D ns_to_t(40);		/* JEDEC: 40 ns w/ 1K pages */
> +	u8 trrd		=3D max(ns_to_t(10), 2);	/* JEDEC: max(10 ns, 2nCK) */
> +	u8 trcd		=3D max(ns_to_t(18), 2);	/* JEDEC: 13.5 ns */
> +	u8 trc		=3D ns_to_t(65);		/* JEDEC: 49.5 ns */
> +	u8 txp		=3D max(ns_to_t(8), 2);	/* JEDEC: max(6 ns, 3nCK) */
> +	u8 trtp		=3D max(ns_to_t(8), 4);	/* JEDEC: max(7.5 ns, 4nCK) */
> +	u8 trp		=3D ns_to_t(21);		/* JEDEC: >=3D 13.75 ns */
> +	u8 tras		=3D ns_to_t(42);		/* JEDEC >=3D 36 ns, <=3D 9*trefi */
> +	u16 trefi	=3D ns_to_t(3904) / 32;	/* JEDEC: 7.8us@Tcase <=3D 85C */
> +	u16 trfc	=3D ns_to_t(280);		/* JEDEC: 160 ns for 2Gb */
> +	u16 txsr	=3D ns_to_t(190);		/* ? */
> +
> +	u8 tmrw		=3D max(ns_to_t(14), 5);	/* ? */
> +	u8 tmrd		=3D tmrw;			/* JEDEC: 4nCK */
> +	u8 tmod		=3D 12;			/* JEDEC: max(15 ns, 12nCK) */
> +	u8 tcke		=3D max(ns_to_t(15), 2);	/* JEDEC: max(5.625 ns, 3nCK) */
> +	u8 tcksrx	=3D max(ns_to_t(2), 2);	/* JEDEC: max(10 ns, 5nCK) */
> +	u8 tcksre	=3D max(ns_to_t(5), 2);	/* JEDEC: max(10 ns, 5nCK) */
> +	u8 tckesr	=3D tcke;		/* JEDEC: tCKE(min) + 1nCK */
> +	u8 trasmax	=3D (trefi * 9) / 32;	/* JEDEC: tREFI * 9 */
> +	u8 txs		=3D 4;			/* JEDEC: max(5nCK,tRFC+10ns) */
> +	u8 txsdll	=3D 16;			/* JEDEC: 512 nCK */
> +	u8 txsabort	=3D 4;			/* ? */
> +	u8 txsfast	=3D 4;			/* ? */
> +	u8 tcl		=3D 10;			/* JEDEC: CL / 2 =3D> 6 */
> +	u8 tcwl		=3D 5;			/* JEDEC: 8 */
> +	u8 t_rdata_en	=3D 17;			/* ? */
> +	u8 tphy_wrlat	=3D 5;
> +
> +	u8 twtp		=3D 24;			/* (WL + BL / 2 + tWR) / 2 */
> +	u8 twr2rd	=3D max(trrd, (u8)4) + 14;/* (WL + BL / 2 + tWTR) / 2 */
> +	u8 trd2wr	=3D (ns_to_t(4) + 17) - ns_to_t(1);/* (RL + BL / 2 + 2 - WL) =
/ 2 */
> +
> +	/* set DRAM timing */
> +	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
> +	       &mctl_ctl->dramtmg[0]);
> +	writel((txp << 16) | (trtp << 8) | trc, &mctl_ctl->dramtmg[1]);
> +	writel((tcwl << 24) | (tcl << 16) | (trd2wr << 8) | twr2rd,
> +	       &mctl_ctl->dramtmg[2]);
> +	writel((tmrw << 20) | (tmrd << 12) | tmod, &mctl_ctl->dramtmg[3]);
> +	writel((trcd << 24) | (tccd << 16) | (trrd << 8) | trp,
> +	       &mctl_ctl->dramtmg[4]);
> +	writel((tcksrx << 24) | (tcksre << 16) | (tckesr << 8) | tcke,
> +	       &mctl_ctl->dramtmg[5]);
> +	/* Value suggested by ZynqMP manual and used by libdram */
> +	writel((txp + 2) | 0x02020000, &mctl_ctl->dramtmg[6]);
> +	writel((txsfast << 24) | (txsabort << 16) | (txsdll << 8) | txs,
> +	       &mctl_ctl->dramtmg[8]);
> +	writel(0x00020208, &mctl_ctl->dramtmg[9]);
> +	writel(0xE0C05, &mctl_ctl->dramtmg[10]);
> +	writel(0x440C021C, &mctl_ctl->dramtmg[11]);
> +	writel(8, &mctl_ctl->dramtmg[12]);
> +	writel(0xA100002, &mctl_ctl->dramtmg[13]);
> +	writel(txsr, &mctl_ctl->dramtmg[14]);
> +
> +	clrsetbits_le32(&mctl_ctl->init[0], 0xC0000FFF, 0x3f0);
> +	writel(0x01f20000, &mctl_ctl->init[1]);
> +	writel(0x00000d05, &mctl_ctl->init[2]);
> +	writel(0, &mctl_ctl->dfimisc);
> +	writel(0x0034001b, &mctl_ctl->init[3]);
> +	writel(0x00330000, &mctl_ctl->init[4]);
> +	writel(0x00040072, &mctl_ctl->init[6]);
> +	writel(0x00240009, &mctl_ctl->init[7]);
> +
> +	clrsetbits_le32(&mctl_ctl->rankctl, 0xff0, 0x660);
> +
> +	/* Configure DFI timing */
> +	writel(tphy_wrlat | 0x2000000 | (t_rdata_en << 16) | 0x808000,
> +	       &mctl_ctl->dfitmg0);
> +	writel(0x100202, &mctl_ctl->dfitmg1);
> +
> +	/* set refresh timing */
> +	writel((trefi << 16) | trfc, &mctl_ctl->rfshtmg);
> +}
> \ No newline at end of file

Can you please add a newline to the end of the line? git will keep
complaining otherwise.

Cheers,
Andre

