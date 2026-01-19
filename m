Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A694EC9830C
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 00:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20DDB8397A;
	Mon, 19 Jan 2026 01:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4CC8397A; Mon, 19 Jan 2026 01:04:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A7B3F8313B
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 01:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59A1A1517;
 Sun, 18 Jan 2026 16:04:31 -0800 (PST)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C38133F740;
 Sun, 18 Jan 2026 16:04:36 -0800 (PST)
Date: Mon, 19 Jan 2026 01:03:27 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng
 <icenowy@aosc.xyz>
Subject: Re: [PATCH] sunxi: a133: Add NSI arbiter support to DRAM init
Message-ID: <20260119010327.4b60ed97@ryzen.lan>
In-Reply-To: <aOjd5xKdRD7g3SAi@collins>
References: <20251009171459.564592-1-paulk@sys-base.io>
 <20251009232127.7cff2e40@minigeek.lan> <aOjd5xKdRD7g3SAi@collins>
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

On Fri, 10 Oct 2025 12:20:23 +0200
Paul Kocialkowski <paulk@sys-base.io> wrote:

Hi Paul,

is there any update on this? Would you be able to send a v2 this week?
If not, I can try to fix the things up I mentioned.

Cheers,
Andre


> Le Thu 09 Oct 25, 23:21, Andre Przywara a =C3=A9crit :
> > On Thu,  9 Oct 2025 19:14:59 +0200
> > Paul Kocialkowski <paulk@sys-base.io> wrote:
> >=20
> > Hi Paul,
> >=20
> > many thanks for sending this, it totally escaped me that we didn't
> > setup the bus priorities on the A133! =20
>=20
> And for the record this solves a display glitch issue that happens whenev=
er the
> GPU is rendering. It would probably also happen with big CPU loads.
>=20
> > > In previous generations of Allwinner SoCs, the memory bus (MBUS) acce=
ss
> > > arbitration was configured as part of the DRAM top registers. This is=
 no
> > > longer the case starting with the A133, which has a dedicated base
> > > address for the bus arbiter that is now called NSI instead of MBUS.
> > >=20
> > > NSI appears to be a later iteration of MBUS design, with new dedicated
> > > registers that resemble the previous MBUS ones. Despite NSI not being
> > > documented in the manual, the A133 BSP includes a nsi driver with some
> > > description of the registers. Like previous generations, it implements
> > > port arbitration priority for DRAM access and also supports an option=
al
> > > QoS mode based on bandwidth limits.
> > >=20
> > > Configuring port arbitration priority is especially important to make
> > > sure that critical masters are not starved by other less important
> > > ones. This is especially the case with the display engine that needs
> > > to be able to fetch pixels in time for scanout and can easily be
> > > starved by CPU or GPU access.
> > >=20
> > > This introduces support for the NSI arbiter in the A133 DRAM init
> > > code. The list and order of available ports are highly SoC-specific
> > > and the default config values are set to match the BSP's defaults.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> > > ---
> > >  .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |  4 ++
> > >  .../include/asm/arch-sunxi/dram_sun50i_a133.h | 50 ++++++++++++++
> > >  arch/arm/mach-sunxi/dram_sun50i_a133.c        | 65 +++++++++++++++++=
+-
> > >  3 files changed, 118 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/a=
rm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> > > index 2a9b086991c3..8e80c520706b 100644
> > > --- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> > > +++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
> > > @@ -16,6 +16,10 @@
> > > =20
> > >  #define SUNXI_GIC400_BASE		0x03020000
> > > =20
> > > +#ifdef CONFIG_MACH_SUN50I_A133
> > > +#define SUNXI_NSI_BASE			0x03100000
> > > +#endif
> > > +
> > >  #ifdef CONFIG_MACH_SUN50I_H6
> > >  #define SUNXI_DRAM_COM_BASE		0x04002000
> > >  #define SUNXI_DRAM_CTL0_BASE		0x04003000
> > > diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h b/arc=
h/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
> > > index a5fc6ad36560..a526e55e7bb9 100644
> > > --- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
> > > +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
> > > @@ -24,6 +24,56 @@ static inline int ns_to_t(int nanoseconds)
> > >  	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
> > >  }
> > > =20
> > > +#define SUNXI_NSI_PORT_PRI_CFG_RD(v)	(((v) & 0x3) << 2)
> > > +#define SUNXI_NSI_PORT_PRI_CFG_WR(v)	((v) & 0x3)
> > > +#define SUNXI_NSI_PRI_LOWEST		0
> > > +#define SUNXI_NSI_PRI_LOW		1
> > > +#define SUNXI_NSI_PRI_HIGH		2
> > > +#define SUNXI_NSI_PRI_HIGHEST		3
> > > +#define SUNXI_NSI_QOS_SEL_OUTPUT	0
> > > +#define SUNXI_NSI_QOS_SEL_INPUT		1
> > > +
> > > +struct sunxi_nsi_port_reg { =20
> >=20
> > Do we really need a struct to describe an MMIO register frame? =20
>=20
> Well I did that because other code around DRAM does it, and IIRC it's sai=
d to
> be the preferred way to do things in u-boot. Personally I've always felt =
like
> this approach is a bit fragile, but when in Rome, do as the Romans do.
> It doesn't really cause problems in practice.
>=20
> > I started to get away from them, for the reasons please check the commit
> > messages from one of those patches:
> > https://source.denx.de/u-boot/u-boot/-/commit/0453a1d9bb15ee30e8b4b89b4=
936982dbb44d71d =20
>=20
> I pretty much agree with all the points raised in the message.
>=20
> > So can we replace this with something like
> > #define SUNXI_NSI_MODE_REG	0x10 =20
>=20
> Sure thing.
>=20
> > And, squinting from a distance, the A523 code looks like using the same
> > per-device MMIO frame, with registers at 0x14 and 0x18 being written,
> > with a distance of 0x200 between the devices. So maybe put this
> > somewhere where the offsets can be shared between the SoCs? =20
>=20
> Ah that's what I suspected, without actually looking at the hardware.
> So the port registers are likely the same, but I guess the list of ports
> is different, so that would need to stay a133-specific.
>=20
> > > +	u32 reserved0[4];
> > > +	u32 mode;
> > > +	u32 pri_cfg;
> > > +	u32 io_cfg;
> > > +	u32 reserved1[41];
> > > +	u32 enable;
> > > +	u32 clr;
> > > +	u32 cycle;
> > > +	u32 rq_rd;
> > > +	u32 rq_wr;
> > > +	u32 dt_rd;
> > > +	u32 dt_wr;
> > > +	u32 la_rd;
> > > +	u32 la_wr;
> > > +	u32 reserved2[71];
> > > +};
> > > +
> > > +struct sunxi_nsi_reg { =20
> >=20
> > Same here, can you please similarly replace this with defines, and
> > multiply this index with the frame size (0x200)? =20
>=20
> Yes sure and I'll rework things to have an explicit list of port indexes.
>=20
> > Otherwise this looks nice!
> >=20
> > Cheers,
> > Andre
> >  =20
> > > +	struct sunxi_nsi_port_reg cpu;
> > > +	struct sunxi_nsi_port_reg gpu;
> > > +	struct sunxi_nsi_port_reg sd1;
> > > +	struct sunxi_nsi_port_reg mstg;
> > > +	struct sunxi_nsi_port_reg gmac0;
> > > +	struct sunxi_nsi_port_reg gmac1;
> > > +	struct sunxi_nsi_port_reg usb0;
> > > +	struct sunxi_nsi_port_reg usb1;
> > > +	struct sunxi_nsi_port_reg ndfc;
> > > +	struct sunxi_nsi_port_reg dmac;
> > > +	struct sunxi_nsi_port_reg ce;
> > > +	struct sunxi_nsi_port_reg de0;
> > > +	struct sunxi_nsi_port_reg de1;
> > > +	struct sunxi_nsi_port_reg ve;
> > > +	struct sunxi_nsi_port_reg csi;
> > > +	struct sunxi_nsi_port_reg isp;
> > > +	struct sunxi_nsi_port_reg g2d;
> > > +	struct sunxi_nsi_port_reg eink;
> > > +	struct sunxi_nsi_port_reg iommu;
> > > +	struct sunxi_nsi_port_reg cpus;
> > > +};
> > > +
> > >  /* MBUS part is largely the same as in H6, except for one special re=
gister */
> > >  #define MCTL_COM_UNK_008	0x008
> > >  /* NOTE: This register has the same importance as mctl_ctl->clken in=
 H616 */
> > > diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-s=
unxi/dram_sun50i_a133.c
> > > index 1496f99624dd..6327f00ff5ea 100644
> > > --- a/arch/arm/mach-sunxi/dram_sun50i_a133.c
> > > +++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
> > > @@ -69,6 +69,64 @@ static const u8 phy_init[] =3D {
> > >  };
> > >  #endif
> > > =20
> > > +static void nsi_configure_port(struct sunxi_nsi_port_reg *port, u8 p=
ri,
> > > +			       u8 qos_sel)
> > > +{
> > > +	u32 pri_cfg;
> > > +
> > > +	/* QoS with bandwidth limits is not supported, disable it. */
> > > +	writel(0, &port->mode);
> > > +	writel(0, &port->enable);
> > > +
> > > +	/*
> > > +	 * QoS direction selection should not be in use, but set it neverth=
eless
> > > +	 * to match the BSP behavior (in case it has some other meaning).
> > > +	 */
> > > +	writel(qos_sel, &port->io_cfg);
> > > +
> > > +	/* Port priority is always active. */
> > > +	pri_cfg =3D SUNXI_NSI_PORT_PRI_CFG_RD(pri) |
> > > +		  SUNXI_NSI_PORT_PRI_CFG_WR(pri);
> > > +
> > > +	writel(pri_cfg, &port->pri_cfg);
> > > +}
> > > +
> > > +static void nsi_set_master_priority(void)
> > > +{
> > > +	struct sunxi_nsi_reg *nsi =3D (struct sunxi_nsi_reg *)SUNXI_NSI_BAS=
E;
> > > +	struct {
> > > +		struct sunxi_nsi_port_reg *port;
> > > +		u8 pri;
> > > +		u8 qos_sel;
> > > +	} ports[] =3D {
> > > +		{ &nsi->cpu,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_INPUT },
> > > +		{ &nsi->gpu,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_INPUT },
> > > +		{ &nsi->sd1,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->mstg,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->gmac0,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->gmac1,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->usb0,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->usb1,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->ndfc,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->dmac,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->ce,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->de0,	SUNXI_NSI_PRI_HIGH,	SUNXI_NSI_QOS_SEL_INPUT },
> > > +		{ &nsi->de1,	SUNXI_NSI_PRI_HIGH,	SUNXI_NSI_QOS_SEL_INPUT },
> > > +		{ &nsi->ve,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_INPUT },
> > > +		{ &nsi->csi,	SUNXI_NSI_PRI_HIGH,	SUNXI_NSI_QOS_SEL_INPUT },
> > > +		{ &nsi->isp,	SUNXI_NSI_PRI_HIGH,	SUNXI_NSI_QOS_SEL_INPUT },
> > > +		{ &nsi->g2d,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_INPUT },
> > > +		{ &nsi->eink,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +		{ &nsi->iommu,	SUNXI_NSI_PRI_HIGHEST,	SUNXI_NSI_QOS_SEL_INPUT },
> > > +		{ &nsi->cpus,	SUNXI_NSI_PRI_LOWEST,	SUNXI_NSI_QOS_SEL_OUTPUT },
> > > +	};
> > > +	unsigned int i;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(ports); i++)
> > > +		nsi_configure_port(ports[i].port, ports[i].pri,
> > > +				   ports[i].qos_sel);
> > > +}
> > > +
> > >  static void mctl_clk_init(u32 clk)
> > >  {
> > >  	void * const ccm =3D (void *)SUNXI_CCM_BASE;
> > > @@ -1184,6 +1242,7 @@ static const struct dram_para para =3D {
> > >  unsigned long sunxi_dram_init(void)
> > >  {
> > >  	struct dram_config config;
> > > +	unsigned long size;
> > > =20
> > >  	/* Writing to undocumented SYS_CFG area, according to user manual. =
*/
> > >  	setbits_le32(0x03000160, BIT(8));
> > > @@ -1200,5 +1259,9 @@ unsigned long sunxi_dram_init(void)
> > >  	      1U << config.bankgrps, 1U << config.ranks,
> > >  	      16U << config.bus_full_width);
> > > =20
> > > -	return calculate_dram_size(&config);
> > > +	size =3D calculate_dram_size(&config);
> > > +
> > > +	nsi_set_master_priority();
> > > +
> > > +	return size;
> > >  } =20
> >  =20
>=20

