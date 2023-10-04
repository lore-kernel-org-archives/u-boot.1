Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78724E7B611
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE524874CC;
	Wed,  4 Oct 2023 15:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9B0874CC; Wed,  4 Oct 2023 15:35:32 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 9871787460
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,200,1694703600"; 
 d="asc'?scan'208";a="181911653"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 04 Oct 2023 22:35:26 +0900
Received: from unknown (unknown [10.226.92.199])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id 254ED400C9ED;
 Wed,  4 Oct 2023 22:35:23 +0900 (JST)
Date: Wed, 4 Oct 2023 14:35:22 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Message-ID: <20231004133522.3kolus6tueundhci@GBR-5CG2373LKG.adwin.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-10-paul.barker.ct@bp.renesas.com>
 <b0df977c-75ef-1579-506e-42e48ef2a06b@mailbox.org>
 <8d2eb729-977f-9fd8-669c-25520218880d@bp.renesas.com>
 <ebcddc10-e450-45e0-8f93-585ff440da4a@mailbox.org>
 <OS0PR01MB59226E628EF9E3D0159AB0BB86CBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="az36ynpmfi7pqosa"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59226E628EF9E3D0159AB0BB86CBA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--az36ynpmfi7pqosa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 12:56:14PM +0000, Biju Das wrote:
> Hi Marek and Paul,
>=20
> > Subject: Re: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
> >=20
> > On 10/4/23 10:40, Paul Barker wrote:
> > > On 03/10/2023 14:20, Marek Vasut wrote:
> > >> On 9/20/23 14:42, Paul Barker wrote:
> > >>> This driver provides pinctrl and gpio control for the Renesas RZ/G2L
> > >>> (R9A07G044) SoC.
> > >>>
> > >>> This patch is based on the corresponding Linux v6.5 driver.
> > >>>
> > >>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > >>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >>> ---
> > >>>    arch/arm/mach-rmobile/Kconfig       |   1 +
> > >>>    drivers/pinctrl/renesas/Kconfig     |   9 +
> > >>>    drivers/pinctrl/renesas/Makefile    |   1 +
> > >>>    drivers/pinctrl/renesas/rzg2l-pfc.c | 906
> > ++++++++++++++++++++++++++++
> > >>>    4 files changed, 917 insertions(+)
> > >>>    create mode 100644 drivers/pinctrl/renesas/rzg2l-pfc.c
> > >>>
> > >>> diff --git a/arch/arm/mach-rmobile/Kconfig
> > >>> b/arch/arm/mach-rmobile/Kconfig index 91f544c78337..973e84fcf7ba
> > >>> 100644
> > >>> --- a/arch/arm/mach-rmobile/Kconfig
> > >>> +++ b/arch/arm/mach-rmobile/Kconfig
> > >>> @@ -76,6 +76,7 @@ config RZG2L
> > >>>    	imply SYS_MALLOC_F
> > >>>    	imply RENESAS_SDHI
> > >>>    	imply CLK_RZG2L
> > >>> +	imply PINCTRL_RZG2L
> > >>
> > >> Keep the list sorted
> > >>
> > >> [...]
> > >>
> > >> Drop the parenthesis around values please, fix globally and in other
> > >> patches too.
> > >>
> > >>> +#define PWPR			(0x3014)
> > >>> +#define SD_CH(n)		(0x3000 + (n) * 4)
> > >>> +#define QSPI			(0x3008)
> > >>> +
> > >>> +#define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
> > >>> +#define PVDD_3300		0	/* I/O domain voltage >=3D 3.3V */
> > >>> +
> > >>> +#define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
> > >>> +#define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
> > >>> +
> > >>> +#define PM_MASK			0x03
> > >>> +#define PVDD_MASK		0x01
> > >>> +#define PFC_MASK		0x07
> > >>> +#define IEN_MASK		0x01
> > >>> +#define IOLH_MASK		0x03
> > >>> +
> > >>> +#define PM_HIGH_Z		0x0
> > >>> +#define PM_INPUT		0x1
> > >>> +#define PM_OUTPUT		0x2
> > >>> +#define PM_OUTPUT_IEN		0x3
> > >>> +
> > >>> +struct rzg2l_pfc_driver_data {
> > >>> +	uint num_dedicated_pins;
> > >>> +	uint num_ports;
> > >>> +	const u32 *gpio_configs;
> > >>> +};
> > >>> +
> > >>> +struct rzg2l_pfc_data {
> > >>> +	void __iomem *base;
> > >>> +	uint num_dedicated_pins;
> > >>> +	uint num_ports;
> > >>> +	uint num_pins;
> > >>> +	const u32 *gpio_configs;
> > >>> +	bool pfc_enabled;
> > >>> +};
> > >>> +
> > >>> +struct rzg2l_dedicated_configs {
> > >>> +	const char *name;
> > >>> +	u32 config;
> > >>> +};
> > >>> +
> > >>> +/*
> > >>> + * We need to ensure that the module clock is enabled and all
> > >>> +resets are
> > >>> + * de-asserted before using either the gpio or pinctrl
> > >>> +functionality. Error
> > >>> + * handling can be quite simple here as if the PFC cannot be
> > >>> +enabled then we
> > >>> + * will not be able to progress with the boot anyway.
> > >>> + */
> > >>> +static int rzg2l_pfc_enable(struct udevice *dev) {
> > >>> +	struct rzg2l_pfc_data *data =3D
> > >>> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> > >>> +	struct reset_ctl_bulk rsts;
> > >>> +	struct clk clk;
> > >>> +	int ret;
> > >>> +
> > >>> +	if (data->pfc_enabled)
> > >>
> > >> When does this get triggered ?
> > >
> > > This is initialised to false in rzg2l_pfc_bind(), then this function
> > > rzg2l_pfc_enable() sets it to true before a successful return. The
> > > effect is that the PFC is enabled just once, regardless of whether the
> > > pinctrl or gpio driver is probed first.
> >=20
> > Why would be call to rzg2l_pfc_enable() a problem in the first place ?
> > It just grabs and enables clock and ungates reset, the second time this=
 is
> > called the impact on harware should be no-op , right ?
> >=20
> > >>> +		return 0;
> > >>
> > >> [...]
> > >>
> > >>> +static int rzg2l_gpio_set_value(struct udevice *dev, unsigned int
> > offset,
> > >>> +				int value)
> > >>> +{
> > >>> +	struct rzg2l_pfc_data *data =3D
> > >>> +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> > >>> +	u32 port =3D RZG2L_PINMUX_TO_PORT(offset);
> > >>> +	u8 pin =3D RZG2L_PINMUX_TO_PIN(offset);
> > >>
> > >> A lot of this can also be const
> > >
> > > This is aligned with the Linux driver to make it easier to port any
> > > future fixes across.
> >=20
> > Maybe send patches to Geert and see what happens ?
> >=20
> > [...]
> >=20
> > >>> +		return -EINVAL;
> > >>> +	}
> > >>> +
> > >>> +	uc_priv->gpio_count =3D args.args[2];
> > >>> +	return rzg2l_pfc_enable(dev);
> > >>> +}
> > >>> +
> > >>> +U_BOOT_DRIVER(rzg2l_pfc_gpio) =3D {
> > >>> +	.name		=3D "rzg2l-pfc-gpio",
> > >>> +	.id		=3D UCLASS_GPIO,
> > >>> +	.ops		=3D &rzg2l_gpio_ops,
> > >>> +	.probe		=3D rzg2l_gpio_probe,
> > >>> +};
> > >>
> > >> Can you please split the GPIO and PFC drivers into separate files ?
> > >
> > > I assume you mean gpio and pinctrl here - the PFC handles both. I can
> > > move the gpio driver out to drivers/gpio.
> >=20
> > Thanks. R-Car already does it that way.
>=20
> RCar has separate GPIO block and Pin control block
> So we have separate drivers.
>=20
> On RZ/G2L we have only pinctrl block, ie, the reason it is
> integrated driver in linux.
>=20
> If you make separate driver, how do you plan to share resources in u-boot=
=2E For eg: register/clock/reset??=20

We already have this broken down into two drivers within the u-boot
driver module - rzg2l_pfc_bind() calls device_bind_with_driver_data() to
bind the "rzg2l-pfc-gpio" and "rzg2l-pfc-pinctrl" drivers to the device.
It should be no trouble to separate the code into two .c files in the
right places.

Thanks,
Paul

--az36ynpmfi7pqosa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR1qGgAKCRDbaV4Vf/JG
vY+qAQCjaO87fiZc9xj+O8DlOmRIjnHbP84WllfpY6yepV+utgD/f6b3ea0I86Xu
AVeRx+u5DkOpDQbAozpJqfRWF+JWuQ4=
=FfFB
-----END PGP SIGNATURE-----

--az36ynpmfi7pqosa--
