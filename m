Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA6EE7C4F0
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 19:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EF1875C5;
	Wed,  4 Oct 2023 21:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA23F875C5; Wed,  4 Oct 2023 21:44:07 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 5E673875C6
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 21:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,201,1694703600"; 
 d="asc'?scan'208";a="181932521"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 05 Oct 2023 04:44:01 +0900
Received: from unknown (unknown [10.226.92.69])
 by relmlir5.idc.renesas.com (Postfix) with SMTP id 11CD54005156;
 Thu,  5 Oct 2023 04:43:58 +0900 (JST)
Date: Wed, 4 Oct 2023 20:43:57 +0100
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 09/16] pinctrl: renesas: Add RZ/G2L PFC driver
Message-ID: <20231004194357.frlx2ojavgj6xye3@GBR-5CG2373LKG.adwin.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-10-paul.barker.ct@bp.renesas.com>
 <b0df977c-75ef-1579-506e-42e48ef2a06b@mailbox.org>
 <8d2eb729-977f-9fd8-669c-25520218880d@bp.renesas.com>
 <ebcddc10-e450-45e0-8f93-585ff440da4a@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ff7nymkwptuhuzql"
Content-Disposition: inline
In-Reply-To: <ebcddc10-e450-45e0-8f93-585ff440da4a@mailbox.org>
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


--ff7nymkwptuhuzql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:24:38PM +0200, Marek Vasut wrote:
> On 10/4/23 10:40, Paul Barker wrote:
> > On 03/10/2023 14:20, Marek Vasut wrote:
> > > On 9/20/23 14:42, Paul Barker wrote:
> > > > This driver provides pinctrl and gpio control for the Renesas RZ/G2L
> > > > (R9A07G044) SoC.
> > > >=20
> > > > This patch is based on the corresponding Linux v6.5 driver.
> > > >=20
> > > > Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> > > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >    arch/arm/mach-rmobile/Kconfig       |   1 +
> > > >    drivers/pinctrl/renesas/Kconfig     |   9 +
> > > >    drivers/pinctrl/renesas/Makefile    |   1 +
> > > >    drivers/pinctrl/renesas/rzg2l-pfc.c | 906 ++++++++++++++++++++++=
++++++
> > > >    4 files changed, 917 insertions(+)
> > > >    create mode 100644 drivers/pinctrl/renesas/rzg2l-pfc.c
> > > >=20
> > > > diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/=
Kconfig
> > > > index 91f544c78337..973e84fcf7ba 100644
> > > > --- a/arch/arm/mach-rmobile/Kconfig
> > > > +++ b/arch/arm/mach-rmobile/Kconfig
> > > > @@ -76,6 +76,7 @@ config RZG2L
> > > >    	imply SYS_MALLOC_F
> > > >    	imply RENESAS_SDHI
> > > >    	imply CLK_RZG2L
> > > > +	imply PINCTRL_RZG2L
> > >=20
> > > Keep the list sorted
> > >=20
> > > [...]
> > >=20
> > > Drop the parenthesis around values please, fix globally and in other
> > > patches too.
> > >=20
> > > > +#define PWPR			(0x3014)
> > > > +#define SD_CH(n)		(0x3000 + (n) * 4)
> > > > +#define QSPI			(0x3008)
> > > > +
> > > > +#define PVDD_1800		1	/* I/O domain voltage <=3D 1.8V */
> > > > +#define PVDD_3300		0	/* I/O domain voltage >=3D 3.3V */
> > > > +
> > > > +#define PWPR_B0WI		BIT(7)	/* Bit Write Disable */
> > > > +#define PWPR_PFCWE		BIT(6)	/* PFC Register Write Enable */
> > > > +
> > > > +#define PM_MASK			0x03
> > > > +#define PVDD_MASK		0x01
> > > > +#define PFC_MASK		0x07
> > > > +#define IEN_MASK		0x01
> > > > +#define IOLH_MASK		0x03
> > > > +
> > > > +#define PM_HIGH_Z		0x0
> > > > +#define PM_INPUT		0x1
> > > > +#define PM_OUTPUT		0x2
> > > > +#define PM_OUTPUT_IEN		0x3
> > > > +
> > > > +struct rzg2l_pfc_driver_data {
> > > > +	uint num_dedicated_pins;
> > > > +	uint num_ports;
> > > > +	const u32 *gpio_configs;
> > > > +};
> > > > +
> > > > +struct rzg2l_pfc_data {
> > > > +	void __iomem *base;
> > > > +	uint num_dedicated_pins;
> > > > +	uint num_ports;
> > > > +	uint num_pins;
> > > > +	const u32 *gpio_configs;
> > > > +	bool pfc_enabled;
> > > > +};
> > > > +
> > > > +struct rzg2l_dedicated_configs {
> > > > +	const char *name;
> > > > +	u32 config;
> > > > +};
> > > > +
> > > > +/*
> > > > + * We need to ensure that the module clock is enabled and all rese=
ts are
> > > > + * de-asserted before using either the gpio or pinctrl functionali=
ty. Error
> > > > + * handling can be quite simple here as if the PFC cannot be enabl=
ed then we
> > > > + * will not be able to progress with the boot anyway.
> > > > + */
> > > > +static int rzg2l_pfc_enable(struct udevice *dev)
> > > > +{
> > > > +	struct rzg2l_pfc_data *data =3D
> > > > +		(struct rzg2l_pfc_data *)dev_get_driver_data(dev);
> > > > +	struct reset_ctl_bulk rsts;
> > > > +	struct clk clk;
> > > > +	int ret;
> > > > +
> > > > +	if (data->pfc_enabled)
> > >=20
> > > When does this get triggered ?
> >=20
> > This is initialised to false in rzg2l_pfc_bind(), then this function
> > rzg2l_pfc_enable() sets it to true before a successful return. The
> > effect is that the PFC is enabled just once, regardless of whether the
> > pinctrl or gpio driver is probed first.
>=20
> Why would be call to rzg2l_pfc_enable() a problem in the first place ?
> It just grabs and enables clock and ungates reset, the second time this is
> called the impact on harware should be no-op , right ?

The hw impact is a no-op, but it wastes time unnecessarily re-reading
data from the fdt and repeating the setup, e.g. in rzg2l_cpg_clk_set()
we have to search the array of clocks each time to find the requested
entry.

I think it's worth keeping the conditional here but can drop it if
you're really against it.

Thanks,
Paul

--ff7nymkwptuhuzql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR3AbgAKCRDbaV4Vf/JG
vQoJAP9YV3VWdpDG4+TyCAd52IKlihBTmHCG2+yK9MDzTj1fJQD+OtQhaLOBXAsd
D9/cq6Y1/o7c9l7l/8lKoixuYzARDQc=
=OEr3
-----END PGP SIGNATURE-----

--ff7nymkwptuhuzql--
