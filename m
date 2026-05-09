Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3755CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 08:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490D884CD2;
	Sat,  9 May 2026 10:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S0YoO6AU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B8084CD5; Sat,  9 May 2026 10:54:00 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 341BF84CC7
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 10:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488d2079582so29772575e9.2
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778316837; x=1778921637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kK+JNBd+ciRWHMgNFEj1O2qcyScEUhoCQ/eR2dMLe+A=;
 b=S0YoO6AUZQqiZ0Wf/nPSXUDJnGmUJ5mzpwoAaJOxVfJmz1G0MmeMvqX8tOKfvk3YNo
 mRnzJow09vWYc3Cg3BMgkl2g21NouW1/su2KPlcGztoxQ/ZQVyulgnaOeXcWBmkTXEQa
 5sEiXm528BJ5YhCPMZEANhSULdMOgWsZW4wEnwQuqfIxeSZIu3GLe5HfjIwmtsXGE2sE
 AI8aGVgs96hDG6C7cttFdOorF22lQq72nTyPNT7LLuBBn7gh/OFwpaQoeavq1lxW8kCA
 Oi1IEFOYBJZ7tpHqZ8f/4+Nore66iTZN9ovr2EdjIErQJ4YeDf3rvSQILIJxKfqGtg3X
 pHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778316837; x=1778921637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kK+JNBd+ciRWHMgNFEj1O2qcyScEUhoCQ/eR2dMLe+A=;
 b=WS/8UDEtwsbbcEcLfZ/o+Ibzwy506jpY5pgNV36s6BfwHyT3F0Smpdjgie6JQjwcN0
 LbG7QT/O4dt409dMx2y6k9baluHym9ni/2qQSQXiNIHZKWO5n16STF2eogC4sfztP3pD
 5oLxJbeQu6Io+NRwUaC0xUsdnBW2dW1jTq0vySGfJ4pGAg7C71jCpnetKY88OfCTl/IM
 l2kE3eYmB7fWfJaUl9ZkIJz1fChFPJz+ig2xG9tIkgEFFLscgPJVFG556RbrCpNrzeKa
 1l0PPsd0rHBkH3LsTSit5v527660RT+fTAAyJtZGWFIoZQidZgCb94Q1jC563wdmEv70
 dUgQ==
X-Gm-Message-State: AOJu0Yy3k2yrAufHA/Vgt2WHuQj2yuPnPHoOZ1Y0YNUmZfnV4dQSqSLr
 EpigzVANs0SomWzXM57opLOMMGfLBR7wVNLbfkRfdzrMQTLoHZ1SjHds
X-Gm-Gg: Acq92OHRytG5nObZIxLLQVv8B4zGQQ1BK4hiLRkTCwkoE6xm1QKb5QQeHBUCjAnoOxG
 Oxz1qc2qKrIDLha70Kx+wN+SXkg3KyZhmyDm8hYBKrjJZNJp3I3nsimwca8DXVpU15GXSubZLic
 YwTcNGJB44nHisJydok/JGSrBexrCSHs/GrFdB/J++ciziVhcNB2bS0mJjEb18GKW/pwIe3vGkA
 /yrno/lCDhdafK4PlDSIM6QvsGQnWly+a73I/i5YN1ELvHbJuUMrY5B9xD59xKEdxIzogHf7dUA
 MhkVCBDAmQvycytASISdUC6qMe/F+go6c8w43utoXnXBJkTJJigfbJGhERNl+rtrY89WenVuDib
 vOglFG2W5qKXSNXyr4M31NIEcvZRUF69D1bhl0DmR6i6VRJon2Kljz0AdnKu3Ha8UUH83QBRiQv
 xQ0tIZv2bEQz3+njexKT3I1MLXmSAx9/AYoYGpr3u0FtMwrgFY5qEQrPbYT5gYFWwUEy7QqfFhm
 HZBAa1V
X-Received: by 2002:a05:600c:c0c1:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-48e51e1ddb2mr188721435e9.11.1778316837362; 
 Sat, 09 May 2026 01:53:57 -0700 (PDT)
Received: from jernej-laptop.localnet (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e7041defesm35384865e9.15.2026.05.09.01.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 01:53:56 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Chen-Yu Tsai <wens@kernel.org>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/2] sunxi: A523: Move NSI init routine into generic
 function
Date: Sat, 09 May 2026 10:53:55 +0200
Message-ID: <Bl4zQkuXTByJdq97nqmfwg@gmail.com>
In-Reply-To: <af3Xpkw8_Ux2czAh@shepard>
References: <20260430135838.3438728-1-andre.przywara@arm.com>
 <7xyPQaBFQqidCfnVRGakAQ@gmail.com> <af3Xpkw8_Ux2czAh@shepard>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne petek, 8. maj 2026 ob 14:31:34 Srednjeevropski poletni =C4=8Das je Paul=
 Kocialkowski napisal(a):
> Hi,
>=20
> Thanks again for picking this up!
>=20
> On Sun 03 May 26, 10:07, Jernej =C5=A0krabec wrote:
> > Dne =C4=8Detrtek, 30. april 2026 ob 15:58:37 Srednjeevropski poletni =
=C4=8Das je Andre Przywara napisal(a):
> > > In previous generations of Allwinner SoCs, the memory bus (MBUS) acce=
ss
> > > arbitration was configured as part of the DRAM top registers. This is=
 no
> > > longer the case with for instance the A133 or A523, which have a dedi=
cated
> > > base address for the bus arbiter that is now called NSI instead of MB=
US.
> > >=20
> > > NSI appears to be a later iteration of MBUS design, with new dedicated
> > > registers that resemble the previous MBUS ones. Despite NSI not being
> > > documented in the manual, the A133 BSP includes a nsi driver with some
> > > description of the registers. Like previous generations, it implements
> > > port arbitration priority for DRAM access and also supports an option=
al
> > > QoS mode based on bandwidth limits.
> > >=20
> > > In preparation for re-using code for other SoCs, factor out the exist=
ing
> > > NSI init routine from the A523 DRAM code, which was a bit ad-hoc and =
A523
> > > specific, into a separate function, and abstract the settings a bit.
> > > No functional change.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > Co-develeoped-by: Paul Kocialkowski <paulk@sys-base.io>
> > > Suggested-by: Jernej =C5=A0krabec <jernej.skrabec@gmail.com>
> > > Sponsored-by: MEC Electronics GmbH <https://www.mec.at/>
> > > ---
> > >  .../include/asm/arch-sunxi/cpu_sunxi_ncat2.h  |  1 +
> > >  .../include/asm/arch-sunxi/dram_sun55i_a523.h | 29 +++++++++++
> > >  arch/arm/include/asm/arch-sunxi/sunxi_nsi.h   | 25 ++++++++++
> > >  arch/arm/mach-sunxi/Makefile                  |  2 +-
> > >  arch/arm/mach-sunxi/dram_sun55i_a523.c        | 49 +++++++++--------=
=2D-
> > >  arch/arm/mach-sunxi/sunxi_nsi.c               | 31 ++++++++++++
> > >  6 files changed, 110 insertions(+), 27 deletions(-)
> > >  create mode 100644 arch/arm/include/asm/arch-sunxi/sunxi_nsi.h
> > >  create mode 100644 arch/arm/mach-sunxi/sunxi_nsi.c
> > >=20
> > > diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h b/arch=
/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
> > > index 7cee7efe8b4..fd7d9b22058 100644
> > > --- a/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
> > > +++ b/arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h
> > > @@ -9,6 +9,7 @@
> > > =20
> > >  #define SUNXI_TZPC_BASE			0x02000800
> > >  #define SUNXI_CCM_BASE			0x02001000
> > > +#define SUNXI_NSI_BASE			0x02020000
> > >  #define SUNXI_TIMER_BASE		0x02050000
> > > =20
> > >  #define SUNXI_TWI0_BASE			0x02502000
> > > diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h b/arc=
h/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
> > > index 08bfe462856..462d4726a21 100644
> > > --- a/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
> > > +++ b/arch/arm/include/asm/arch-sunxi/dram_sun55i_a523.h
> > > @@ -20,6 +20,35 @@ enum sunxi_dram_type {
> > >  #define MCTL_COM_UNK_008        0x008
> > >  #define MCTL_COM_MAER0          0x020
> > > =20
> > > +enum sunxi_nsi_port {
> > > +	SUNXI_NSI_PORT_GPU      =3D 0,
> > > +	SUNXI_NSI_PORT_GIC,	=3D 1,
> > > +	SUNXI_NSI_PORT_USB3,	=3D 2,
> > > +	SUNXI_NSI_PORT_PCIE,	=3D 3,
> > > +	SUNXI_NSI_PORT_CE,	=3D 4,
> > > +	SUNXI_NSI_PORT_NPU,	=3D 5,
> > > +	SUNXI_NSI_PORT_ISP,	=3D 6,
> > > +	SUNXI_NSI_PORT_DSP,	=3D 7,
> > > +	SUNXI_NSI_PORT_G2D,	=3D 8,
> > > +	SUNXI_NSI_PORT_DI,	=3D 9,
> > > +	SUNXI_NSI_PORT_IOMMU,	=3D 10,
> > > +	SUNXI_NSI_PORT_VE_R,	=3D 11,
> > > +	SUNXI_NSI_PORT_VE_RW,	=3D 12,
> > > +	SUNXI_NSI_PORT_DE,	=3D 13,
> > > +	SUNXI_NSI_PORT_CSI,	=3D 14,
> > > +	SUNXI_NSI_PORT_GMAC0,	=3D 18,
> > > +	SUNXI_NSI_PORT_GMAC1,	=3D 19,
> > > +	SUNXI_NSI_PORT_MMC0,	=3D 20,
> > > +	SUNXI_NSI_PORT_MMC1,	=3D 21,
> > > +	SUNXI_NSI_PORT_MMC2,	=3D 22,
> > > +	SUNXI_NSI_PORT_USB0,	=3D 23,
> > > +	SUNXI_NSI_PORT_USB1,	=3D 24,
> > > +	SUNXI_NSI_PORT_USB2,	=3D 25,
> > > +	SUNXI_NSI_PORT_NPD,	=3D 26,
> > > +	SUNXI_NSI_PORT_DMAC,	=3D 27,
> > > +	SUNXI_NSI_PORT_DMA,	=3D 28,
> > > +};
> > > +
> > >  /*
> > >   * Controller registers seems to be the same or at least very similar
> > >   * to those in H6.
> > > diff --git a/arch/arm/include/asm/arch-sunxi/sunxi_nsi.h b/arch/arm/i=
nclude/asm/arch-sunxi/sunxi_nsi.h
> > > new file mode 100644
> > > index 00000000000..7d41f9318b5
> > > --- /dev/null
> > > +++ b/arch/arm/include/asm/arch-sunxi/sunxi_nsi.h
> > > @@ -0,0 +1,25 @@
> > > +// SPDX-License-Identifier:	GPL-2.0+
> > > +/*
> > > + * A133/A523 NSI interconnect register and constant defines
> > > + *
> > > + * (C) Copyright 2026 Arm Ltd.
> > > + */
> > > +
> > > +#ifndef SUNXI_NSI_H__
> > > +#define SUNXI_NSI_H__
> > > +
> > > +#define SUNXI_NSI_PRI_CFG_LOWEST	0
> > > +#define SUNXI_NSI_PRI_CFG_LOW		1
> > > +#define SUNXI_NSI_PRI_CFG_HIGH		2
> > > +#define SUNXI_NSI_PRI_CFG_HIGHEST	3
> > > +
> > > +#define SUNXI_NSI_IO_CFG_QOS_SEL_OUTPUT	0
> > > +#define SUNXI_NSI_IO_CFG_QOS_SEL_INPUT	1
> > > +
> > > +#define NSI_CONF(port, pri, qos_sel) \
> > > +	{ SUNXI_NSI_PORT_ ## port, SUNXI_NSI_PRI_CFG_ ## pri, \
> > > +	  SUNXI_NSI_IO_CFG_QOS_SEL_ ## qos_sel }
> > > +
> > > +void nsi_configure_port(unsigned int port, u8 pri, u8 qos_sel);
> > > +
> > > +#endif /* SUNXI_NSI_H__ */
> > > diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makef=
ile
> > > index 0bee04d660f..3ef0113ea43 100644
> > > --- a/arch/arm/mach-sunxi/Makefile
> > > +++ b/arch/arm/mach-sunxi/Makefile
> > > @@ -50,6 +50,6 @@ obj-$(CONFIG_DRAM_SUN50I_H616)	+=3D dram_sun50i_h61=
6.o dram_dw_helpers.o
> > >  obj-$(CONFIG_DRAM_SUN50I_H616)	+=3D dram_timings/
> > >  obj-$(CONFIG_DRAM_SUN50I_A133)	+=3D dram_sun50i_a133.o
> > >  obj-$(CONFIG_DRAM_SUN50I_A133)	+=3D dram_timings/
> > > -obj-$(CONFIG_MACH_SUN55I_A523)	+=3D dram_sun55i_a523.o dram_dw_helpe=
rs.o
> > > +obj-$(CONFIG_MACH_SUN55I_A523)	+=3D dram_sun55i_a523.o dram_dw_helpe=
rs.o sunxi_nsi.o
> > >  obj-$(CONFIG_DRAM_SUN55I_A523)	+=3D dram_timings/
> > >  endif
> > > diff --git a/arch/arm/mach-sunxi/dram_sun55i_a523.c b/arch/arm/mach-s=
unxi/dram_sun55i_a523.c
> > > index 1ffb62863e2..9fb054cea84 100644
> > > --- a/arch/arm/mach-sunxi/dram_sun55i_a523.c
> > > +++ b/arch/arm/mach-sunxi/dram_sun55i_a523.c
> > > @@ -15,6 +15,7 @@
> > >  #include <asm/arch/dram_dw_helpers.h>
> > >  #include <asm/arch/cpu.h>
> > >  #include <asm/arch/prcm.h>
> > > +#include <asm/arch/sunxi_nsi.h>
> > >  #include <linux/bitops.h>
> > >  #include <linux/delay.h>
> > > =20
> > > @@ -1412,40 +1413,36 @@ static const struct dram_para para =3D {
> > >  	.tpr10 =3D CONFIG_DRAM_SUNXI_TPR10,
> > >  };
> > > =20
> > > -static void sunxi_nsi_init(void)
> > > +static void nsi_set_master_priority(void)
> > >  {
> > > -	/* IOMMU prio 3 */
> > > -	writel(0x1, 0x02021418);
> > > -	writel(0xf, 0x02021414);
> > > -	/* DE prio 2 */
> > > -	writel(0x1, 0x02021a18);
> > > -	writel(0xa, 0x02021a14);
> > > -	/* VE R prio 2 */
> > > -	writel(0x1, 0x02021618);
> > > -	writel(0xa, 0x02021614);
> > > -	/* VE RW prio 2 */
> > > -	writel(0x1, 0x02021818);
> > > -	writel(0xa, 0x02021814);
> > > -	/* ISP prio 2 */
> > > -	writel(0x1, 0x02020c18);
> > > -	writel(0xa, 0x02020c14);
> > > -	/* CSI prio 2 */
> > > -	writel(0x1, 0x02021c18);
> > > -	writel(0xa, 0x02021c14);
> > > -	/* NPU prio 2 */
> > > -	writel(0x1, 0x02020a18);
> > > -	writel(0xa, 0x02020a14);
> > > +	struct {
> > > +		unsigned int port;
> > > +		u8 pri;
> > > +		u8 qos_sel;
> >=20
> > What about introducing above struct in sunxi_nsi.h? I imagine same patt=
ern
> > will be used in future code.
>=20
> Sounds like a good idea!
>=20
> > > +	} ports[] =3D {
> > > +		NSI_CONF(NPU,	HIGH,		INPUT),
> > > +		NSI_CONF(ISP,	HIGH,		INPUT),
> > > +		NSI_CONF(IOMMU,	HIGHEST,	INPUT),
> > > +		NSI_CONF(VE_R,	HIGH,		INPUT),
> > > +		NSI_CONF(VE_RW,	HIGH,		INPUT),
> > > +		NSI_CONF(DE,	HIGH,		INPUT),
> > > +		NSI_CONF(CSI,	HIGH,		INPUT),
> > > +	};
> > > +	unsigned int i;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(ports); i++)
> > > +		nsi_configure_port(ports[i].port, ports[i].pri,
> > > +				   ports[i].qos_sel);
> > > =20
> > >  	/* close ra0 autogating */
> > > -	writel(0x0, 0x02023c00);
> > > +	writel(0x0, 0x02023c00);	/* port 30 */
> > >  	/* close ta autogating */
> > > -	writel(0x0, 0x02023e00);
> > > +	writel(0x0, 0x02023e00);	/* port 31 */
> > >  	/* close pcie autogating */
> > >  	writel(0x0, 0x02020600);
> >=20
> > Use SUNXI_NSI_BASE + ... above
>=20
> We should probably introduce proper defines for this. From what I underst=
and
> the RA and TA are special ports but they share the same layout for the
> autogating register. So something like:
>=20
> 	SUNXI_NSI_PORT_RA,	=3D 30,
> 	SUNXI_NSI_PORT_TA,	=3D 31,
>=20
> Then a definition for:
>=20
> #define SUNXI_NSI_AUTOGATING_REG(i)		((i) * 0x200)
>=20
> And a helper like:
> void nsi_configure_port_autogating(unsigned int port)
>=20
> To set the reg to zero and "close" autogating.
>=20
> What do you think?

Yep, that looks the cleanest.

Best regards,
Jernej

> > >  }
> > > =20
> > >  static void init_something(void)
> > > -
> > >  {
> > >  	u32 *ptr =3D (u32 *)0x02000804;
> > > =20
> > > @@ -1507,7 +1504,7 @@ unsigned long sunxi_dram_init(void)
> > > =20
> > >  	size =3D mctl_calc_size(&config);
> > > =20
> > > -	sunxi_nsi_init();
> > > +	nsi_set_master_priority();
> > >  	init_something();
> > > =20
> > >  	return size;
> > > diff --git a/arch/arm/mach-sunxi/sunxi_nsi.c b/arch/arm/mach-sunxi/su=
nxi_nsi.c
> > > new file mode 100644
> > > index 00000000000..3d7eb43df46
> > > --- /dev/null
> > > +++ b/arch/arm/mach-sunxi/sunxi_nsi.c
> > > @@ -0,0 +1,31 @@
> > > +#include <asm/io.h>
> > > +#include <asm/arch/cpu.h>
> > > +#include <asm/arch/sunxi_nsi.h>
> > > +
> > > +#define SUNXI_NSI_MODE_REG(i)		((i) * 0x200 + 0x10)
> > > +#define SUNXI_NSI_PRI_CFG_REG(i)	((i) * 0x200 + 0x14)
> > > +#define SUNXI_NSI_PRI_CFG_RD(v)		(((v) & 0x3) << 2)
> > > +#define SUNXI_NSI_PRI_CFG_WR(v)		((v) & 0x3)
> > > +#define SUNXI_NSI_IO_CFG_REG(i)		((i) * 0x200 + 0x18)
> > > +#define SUNXI_NSI_ENABLE_REG(i)		((i) * 0x200 + 0xc0)
>=20
> I'd move this to the header unless there's a particular reason to not
> include it there.
>=20
> All the best,
>=20
> Paul
>=20
> > > +
> > > +void nsi_configure_port(unsigned int port, u8 pri, u8 qos_sel)
> > > +{
> > > +	void *base =3D (void *)SUNXI_NSI_BASE;
> > > +	u32 pri_cfg;
> > > +
> > > +	/* QoS with bandwidth limits is not supported, disable it. */
> > > +	writel(0, base + SUNXI_NSI_MODE_REG(port));
> > > +	writel(0, base + SUNXI_NSI_ENABLE_REG(port));
> > > +
> > > +	/*
> > > +	 * QoS direction selection should not be in use, but set it neverth=
eless
> > > +	 * to match the BSP behavior (in case it has some other meaning).
> > > +	 */
> > > +	writel(qos_sel, base + SUNXI_NSI_IO_CFG_REG(port));
> > > +
> > > +	/* Port priority is always active. */
> > > +	pri_cfg =3D SUNXI_NSI_PRI_CFG_RD(pri) | SUNXI_NSI_PRI_CFG_WR(pri);
> > > +
> > > +	writel(pri_cfg, base + SUNXI_NSI_PRI_CFG_REG(port));
> > > +}
> > >=20
> >=20
> >=20
> >=20
> >=20
>=20
>=20




