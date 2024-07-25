Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CD4C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D2687C38;
	Fri, 26 Jul 2024 01:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tE8o0FZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C71488453; Fri, 26 Jul 2024 01:46:24 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 320A187C38
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db15b4243dso276853b6e.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721951179; x=1722555979; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GbBTPGA+aq16fkgqXKgbAEYxQRTdHndj00jijDQIqd4=;
 b=tE8o0FZH71QS+h16ZDSf1EVl9FltaOiosLdZnokA3BdfcdHxPlBgarPnf4GXTSslVV
 /lJ29qjSiGf26dIVxmcIC6Yjj8myIOOynR3RC2B0yq9W82eDFsihkN3rkJifLuhDohlL
 7WcoxZOpTGIX95CoeF3ILsof86fQ/spu/O0T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951179; x=1722555979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbBTPGA+aq16fkgqXKgbAEYxQRTdHndj00jijDQIqd4=;
 b=h5rHBx7NNu6fNFS0228aszNv3X46ew5fhlQv0RfLFiKJCKdZ3Yz1/fO44M8rWB4a8V
 chYlODAEUhrqBwzjo8PEVvJt/jJuWnAyzgrv1mxrbG637xqS0sBWPfRpwZ28IqXtb7XI
 bk/WuB94qoIaUAZN9F0tkTe5qc46IDiHd2crgefZqTyqXfTF9TtMuMtJQWFcClXAvHK5
 oq9yRImn0KqYfVmdln9Q3l+IS8IcP3ukRM7ci54KHarGf6M/RQRdnhc5pgWfh/pPdaiw
 svfYLglcdnhssD2DiZLrG0Pja86uThTBvAD6ZZDqJBDfvmyMI7Xbizi5ioy2PbsvQTay
 TUGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtqMhjILoJ4SeVAWGG2NQx2PfgnBcMqZfnTAgJX1pg2aUNXGCpVSuL9DLNxcSYiIF+8dRkCYuVxUKIIvcQMQmEpqAnXg==
X-Gm-Message-State: AOJu0Yx1tu6l18pY1L4xsDODWyPxnqnl0CrJaAuyPo4P00TaKdEIUgUW
 FM2xTD/dVDrxAAL551JK7bAPwyv8PGvP2IM28+rjWEKM5FX0PkfLrAbTdyq/wPI=
X-Google-Smtp-Source: AGHT+IGnF7B8soOhXAkYbY5uhzFQi92t3Ysf7t3XcBAbZt+PHsw1agQCrFVTbWITwp9V82ILpKmTDQ==
X-Received: by 2002:a05:6808:1301:b0:3d9:29c1:be5c with SMTP id
 5614622812f47-3db140e36a8mr4865629b6e.12.1721951178560; 
 Thu, 25 Jul 2024 16:46:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1343a6e0sm493676b6e.22.2024.07.25.16.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:46:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: joe.hershberger@ni.com, Robert Marko <robert.marko@sartura.hr>,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, rfried.dev@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, j.beck@linefinity.com, Gabor Juhos <j4g8y7@gmail.com>
Subject: Re: [PATCH v3 4/5] net: add Qualcomm ESS EDMA adapter
Message-ID: <20240725234615.GF989285@bill-the-cat>
References: <20240603120651.154670-1-robert.marko@sartura.hr>
 <20240603120651.154670-4-robert.marko@sartura.hr>
 <816e02b8-3ad3-4582-86a0-a07d3db06b64@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hmkn9kOX0KZYMQdf"
Content-Disposition: inline
In-Reply-To: <816e02b8-3ad3-4582-86a0-a07d3db06b64@linaro.org>
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


--Hmkn9kOX0KZYMQdf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 01:33:09AM +0200, Caleb Connolly wrote:

> Hi all,
>=20
> Should this go through a different tree? Otherwise I'll take it through
> qcom.

I think the qcom tree is best currently, thanks.

>=20
> Kind regards,
>=20
> On 03/06/2024 14:06, Robert Marko wrote:
> > This adds the driver for the ESS EDMA ethernet adapter
> > found inside of Qualcomm IPQ40xx SoC series.
> >=20
> > This driver also integrates the built in modified QCA8337N
> > switch support as they are tightly integrated.
> >=20
> > Co-Developed-by: Gabor Juhos <j4g8y7@gmail.com>
> > Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> > Changes in v3:
> > * Use dev_dbg for printing
> > * Switch to ofnode_read_u32() instead of ofnode_read_u32_default()
> >=20
> > Changes in v2:
> > * Adapt to the Linux pending DT node instead
> > * Check if port node is enabled
> >=20
> >   drivers/net/Kconfig   |    8 +
> >   drivers/net/Makefile  |    1 +
> >   drivers/net/essedma.c | 1192 +++++++++++++++++++++++++++++++++++++++++
> >   drivers/net/essedma.h |  198 +++++++
> >   4 files changed, 1399 insertions(+)
> >   create mode 100644 drivers/net/essedma.c
> >   create mode 100644 drivers/net/essedma.h
> >=20
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index b2d7b49976..9b7626e1c5 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -307,6 +307,14 @@ config EEPRO100
> >   	  This driver supports Intel(R) PRO/100 82557/82559/82559ER fast
> >   	  ethernet family of adapters.
> > +config ESSEDMA
> > +	bool "Qualcomm ESS Edma support"
> > +	depends on DM_ETH && ARCH_IPQ40XX
> > +	select PHYLIB
> > +	help
> > +	  This driver supports ethernet DMA adapter found in
> > +	  Qualcomm IPQ40xx series SoC-s.
> > +
> >   config ETH_SANDBOX
> >   	depends on SANDBOX
> >   	default y
> > diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> > index dc3404519d..8533793de5 100644
> > --- a/drivers/net/Makefile
> > +++ b/drivers/net/Makefile
> > @@ -27,6 +27,7 @@ obj-$(CONFIG_DWC_ETH_QOS_STM32) +=3D dwc_eth_qos_stm3=
2.o
> >   obj-$(CONFIG_E1000) +=3D e1000.o
> >   obj-$(CONFIG_E1000_SPI) +=3D e1000_spi.o
> >   obj-$(CONFIG_EEPRO100) +=3D eepro100.o
> > +obj-$(CONFIG_ESSEDMA) +=3D essedma.o
> >   obj-$(CONFIG_ETHOC) +=3D ethoc.o
> >   obj-$(CONFIG_ETH_DESIGNWARE) +=3D designware.o
> >   obj-$(CONFIG_ETH_DESIGNWARE_MESON8B) +=3D dwmac_meson8b.o
> > diff --git a/drivers/net/essedma.c b/drivers/net/essedma.c
> > new file mode 100644
> > index 0000000000..0de363806f
> > --- /dev/null
> > +++ b/drivers/net/essedma.c
> > @@ -0,0 +1,1192 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2020 Sartura Ltd.
> > + *
> > + * Author: Robert Marko <robert.marko@sartura.hr>
> > + *
> > + * Copyright (c) 2021 Toco Technologies FZE <contact@toco.ae>
> > + * Copyright (c) 2021 Gabor Juhos <j4g8y7@gmail.com>
> > + *
> > + * Qualcomm ESS EDMA ethernet driver
> > + */
> > +
> > +#include <asm/io.h>
> > +#include <clk.h>
> > +#include <cpu_func.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <errno.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <log.h>
> > +#include <miiphy.h>
> > +#include <net.h>
> > +#include <reset.h>
> > +
> > +#include "essedma.h"
> > +
> > +#define EDMA_MAX_PKT_SIZE	(PKTSIZE_ALIGN + PKTALIGN)
> > +
> > +#define EDMA_RXQ_ID	0
> > +#define EDMA_TXQ_ID	0
> > +
> > +/* descriptor ring */
> > +struct edma_ring {
> > +	u16 count; /* number of descriptors in the ring */
> > +	void *hw_desc; /* descriptor ring virtual address */
> > +	unsigned int hw_size; /* hw descriptor ring length in bytes */
> > +	dma_addr_t dma; /* descriptor ring physical address */
> > +	u16 head; /* next Tx descriptor to fill */
> > +	u16 tail; /* next Tx descriptor to clean */
> > +};
> > +
> > +struct ess_switch {
> > +	phys_addr_t base;
> > +	struct phy_device *phydev[ESS_PORTS_NUM];
> > +	u32 phy_mask;
> > +	ofnode ports_node;
> > +	phy_interface_t port_wrapper_mode;
> > +	int num_phy;
> > +};
> > +
> > +struct essedma_priv {
> > +	phys_addr_t base;
> > +	struct udevice *dev;
> > +	struct clk ess_clk;
> > +	struct reset_ctl ess_rst;
> > +	struct udevice *mdio_dev;
> > +	struct ess_switch esw;
> > +	phys_addr_t psgmii_base;
> > +	struct edma_ring tpd_ring;
> > +	struct edma_ring rfd_ring;
> > +};
> > +
> > +static void esw_port_loopback_set(struct ess_switch *esw, int port,
> > +				  bool enable)
> > +{
> > +	u32 t;
> > +
> > +	t =3D readl(esw->base + ESS_PORT_LOOKUP_CTRL(port));
> > +	if (enable)
> > +		t |=3D ESS_PORT_LOOP_BACK_EN;
> > +	else
> > +		t &=3D ~ESS_PORT_LOOP_BACK_EN;
> > +	writel(t, esw->base + ESS_PORT_LOOKUP_CTRL(port));
> > +}
> > +
> > +static void esw_port_loopback_set_all(struct ess_switch *esw, bool ena=
ble)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 1; i < ESS_PORTS_NUM; i++)
> > +		esw_port_loopback_set(esw, i, enable);
> > +}
> > +
> > +static void ess_reset(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +
> > +	reset_assert(&priv->ess_rst);
> > +	mdelay(10);
> > +
> > +	reset_deassert(&priv->ess_rst);
> > +	mdelay(10);
> > +}
> > +
> > +void qca8075_ess_reset(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	struct phy_device *psgmii_phy;
> > +	int i, val;
> > +
> > +	/* Find the PSGMII PHY */
> > +	psgmii_phy =3D priv->esw.phydev[priv->esw.num_phy - 1];
> > +
> > +	/* Fix phy psgmii RX 20bit */
> > +	phy_write(psgmii_phy, MDIO_DEVAD_NONE, MII_BMCR, 0x005b);
> > +
> > +	/* Reset phy psgmii */
> > +	phy_write(psgmii_phy, MDIO_DEVAD_NONE, MII_BMCR, 0x001b);
> > +
> > +	/* Release reset phy psgmii */
> > +	phy_write(psgmii_phy, MDIO_DEVAD_NONE, MII_BMCR, 0x005b);
> > +	for (i =3D 0; i < 100; i++) {
> > +		val =3D phy_read_mmd(psgmii_phy, MDIO_MMD_PMAPMD, 0x28);
> > +		if (val & 0x1)
> > +			break;
> > +		mdelay(1);
> > +	}
> > +	if (i >=3D 100)
> > +		printf("QCA807x PSGMII PLL_VCO_CALIB Not Ready\n");
> > +
> > +	/*
> > +	 * Check qca8075 psgmii calibration done end.
> > +	 * Freeze phy psgmii RX CDR
> > +	 */
> > +	phy_write(psgmii_phy, MDIO_DEVAD_NONE, 0x1a, 0x2230);
> > +
> > +	ess_reset(dev);
> > +
> > +	/* Check ipq psgmii calibration done start */
> > +	for (i =3D 0; i < 100; i++) {
> > +		val =3D readl(priv->psgmii_base + PSGMIIPHY_VCO_CALIBRATION_CTRL_REG=
ISTER_2);
> > +		if (val & 0x1)
> > +			break;
> > +		mdelay(1);
> > +	}
> > +	if (i >=3D 100)
> > +		printf("PSGMII PLL_VCO_CALIB Not Ready\n");
> > +
> > +	/*
> > +	 * Check ipq psgmii calibration done end.
> > +	 * Relesae phy psgmii RX CDR
> > +	 */
> > +	phy_write(psgmii_phy, MDIO_DEVAD_NONE, 0x1a, 0x3230);
> > +
> > +	/* Release phy psgmii RX 20bit */
> > +	phy_write(psgmii_phy, MDIO_DEVAD_NONE, MII_BMCR, 0x005f);
> > +}
> > +
> > +#define PSGMII_ST_NUM_RETRIES		20
> > +#define PSGMII_ST_PKT_COUNT		(4 * 1024)
> > +#define PSGMII_ST_PKT_SIZE		1504
> > +
> > +/*
> > + * Transmitting one byte over a 1000Mbps link requires 8 ns.
> > + * Additionally, use + 1 ns for safety to compensate latencies
> > + * and such.
> > + */
> > +#define PSGMII_ST_TRAFFIC_TIMEOUT_NS	\
> > +	(PSGMII_ST_PKT_COUNT * PSGMII_ST_PKT_SIZE * (8 + 1))
> > +
> > +#define PSGMII_ST_TRAFFIC_TIMEOUT	\
> > +	DIV_ROUND_UP(PSGMII_ST_TRAFFIC_TIMEOUT_NS, 1000000)
> > +
> > +static bool psgmii_self_test_repeat =3D false;
> > +
> > +static void psgmii_st_phy_power_down(struct phy_device *phydev)
> > +{
> > +	int val;
> > +
> > +	val =3D phy_read(phydev, MDIO_DEVAD_NONE, MII_BMCR);
> > +	val |=3D QCA807X_POWER_DOWN;
> > +	phy_write(phydev, MDIO_DEVAD_NONE, MII_BMCR, val);
> > +}
> > +
> > +static void psgmii_st_phy_prepare(struct phy_device *phydev)
> > +{
> > +	int val;
> > +
> > +	/* check phydev combo port */
> > +	val =3D phy_read(phydev, MDIO_DEVAD_NONE,
> > +		       QCA807X_CHIP_CONFIGURATION);
> > +	if (val) {
> > +		/* Select copper page */
> > +		val |=3D QCA807X_MEDIA_PAGE_SELECT;
> > +		phy_write(phydev, MDIO_DEVAD_NONE,
> > +			  QCA807X_CHIP_CONFIGURATION, val);
> > +	}
> > +
> > +	/* Force no link by power down */
> > +	psgmii_st_phy_power_down(phydev);
> > +
> > +	/* Packet number (Non documented) */
> > +	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8021, PSGMII_ST_PKT_COUNT);
> > +	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8062, PSGMII_ST_PKT_SIZE);
> > +
> > +	/* Fix MDI status */
> > +	val =3D phy_read(phydev, MDIO_DEVAD_NONE, QCA807X_FUNCTION_CONTROL);
> > +	val &=3D ~QCA807X_MDI_CROSSOVER_MODE_MASK;
> > +	val |=3D FIELD_PREP(QCA807X_MDI_CROSSOVER_MODE_MASK,
> > +			  QCA807X_MDI_CROSSOVER_MODE_MANUAL_MDI);
> > +	val &=3D ~QCA807X_POLARITY_REVERSAL;
> > +	phy_write(phydev, MDIO_DEVAD_NONE, QCA807X_FUNCTION_CONTROL, val);
> > +}
> > +
> > +static void psgmii_st_phy_recover(struct phy_device *phydev)
> > +{
> > +	int val;
> > +
> > +	/* Packet number (Non documented) */
> > +	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8021, 0x0);
> > +
> > +	/* Disable CRC checker and packet counter */
> > +	val =3D phy_read_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_CRC_PACKET_COU=
NTER);
> > +	val &=3D ~QCA807X_MMD7_PACKET_COUNTER_SELFCLR;
> > +	val &=3D ~QCA807X_MMD7_CRC_PACKET_COUNTER_EN;
> > +	phy_write_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_CRC_PACKET_COUNTER, v=
al);
> > +
> > +	/* Disable traffic (Undocumented) */
> > +	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8020, 0x0);
> > +}
> > +
> > +static void psgmii_st_phy_start_traffic(struct phy_device *phydev)
> > +{
> > +	int val;
> > +
> > +	/* Enable CRC checker and packet counter */
> > +	val =3D phy_read_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_CRC_PACKET_COU=
NTER);
> > +	val |=3D QCA807X_MMD7_CRC_PACKET_COUNTER_EN;
> > +	phy_write_mmd(phydev, MDIO_MMD_AN, QCA807X_MMD7_CRC_PACKET_COUNTER, v=
al);
> > +
> > +	/* Start traffic (Undocumented) */
> > +	phy_write_mmd(phydev, MDIO_MMD_AN, 0x8020, 0xa000);
> > +}
> > +
> > +static bool psgmii_st_phy_check_counters(struct phy_device *phydev)
> > +{
> > +	u32 tx_ok;
> > +
> > +	/*
> > +	 * The number of test packets is limited to 65535 so
> > +	 * only read the lower 16 bits of the counter.
> > +	 */
> > +	tx_ok =3D phy_read_mmd(phydev, MDIO_MMD_AN,
> > +			     QCA807X_MMD7_VALID_EGRESS_COUNTER_2);
> > +
> > +	return (tx_ok =3D=3D PSGMII_ST_PKT_COUNT);
> > +}
> > +
> > +static void psgmii_st_phy_reset_loopback(struct phy_device *phydev)
> > +{
> > +	/* reset the PHY */
> > +	phy_write(phydev, MDIO_DEVAD_NONE, MII_BMCR, 0x9000);
> > +
> > +	/* enable loopback mode */
> > +	phy_write(phydev, MDIO_DEVAD_NONE, MII_BMCR, 0x4140);
> > +}
> > +
> > +static inline bool psgmii_st_phy_link_is_up(struct phy_device *phydev)
> > +{
> > +	int val;
> > +
> > +	val =3D phy_read(phydev, MDIO_DEVAD_NONE, QCA807X_PHY_SPECIFIC);
> > +	return !!(val & QCA807X_PHY_SPECIFIC_LINK);
> > +}
> > +
> > +static bool psgmii_st_phy_wait(struct ess_switch *esw, u32 mask,
> > +			       int retries, int delay,
> > +			       bool (*check)(struct phy_device*))
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < retries; i++) {
> > +		int phy;
> > +
> > +		for (phy =3D 0; phy < esw->num_phy - 1; phy++) {
> > +			u32 phybit =3D BIT(phy);
> > +
> > +			if (!(mask & phybit))
> > +				continue;
> > +
> > +			if (check(esw->phydev[phy]))
> > +				mask &=3D ~phybit;
> > +		}
> > +
> > +		if (!mask)
> > +			break;
> > +
> > +		mdelay(delay);
> > +	}
> > +
> > +	return (!mask);
> > +}
> > +
> > +static bool psgmii_st_phy_wait_link(struct ess_switch *esw, u32 mask)
> > +{
> > +	return psgmii_st_phy_wait(esw, mask, 100, 10,
> > +				  psgmii_st_phy_link_is_up);
> > +}
> > +
> > +static bool psgmii_st_phy_wait_tx_complete(struct ess_switch *esw, u32=
 mask)
> > +{
> > +	return psgmii_st_phy_wait(esw, mask, PSGMII_ST_TRAFFIC_TIMEOUT, 1,
> > +				  psgmii_st_phy_check_counters);
> > +}
> > +
> > +static bool psgmii_st_run_test_serial(struct ess_switch *esw)
> > +{
> > +	bool result =3D true;
> > +	int i;
> > +
> > +	for (i =3D 0; i < esw->num_phy - 1; i++) {
> > +		struct phy_device *phydev =3D esw->phydev[i];
> > +
> > +		psgmii_st_phy_reset_loopback(phydev);
> > +
> > +		psgmii_st_phy_wait_link(esw, BIT(i));
> > +
> > +		psgmii_st_phy_start_traffic(phydev);
> > +
> > +		/* wait for the traffic to complete */
> > +		result &=3D psgmii_st_phy_wait_tx_complete(esw, BIT(i));
> > +
> > +		/* Power down */
> > +		psgmii_st_phy_power_down(phydev);
> > +
> > +		if (!result)
> > +			break;
> > +	}
> > +
> > +	return result;
> > +}
> > +
> > +static bool psgmii_st_run_test_parallel(struct ess_switch *esw)
> > +{
> > +	bool result;
> > +	int i;
> > +
> > +	/* enable loopback mode on all PHYs */
> > +	for (i =3D 0; i < esw->num_phy - 1; i++)
> > +		psgmii_st_phy_reset_loopback(esw->phydev[i]);
> > +
> > +	psgmii_st_phy_wait_link(esw, esw->phy_mask);
> > +
> > +	/* start traffic on all PHYs parallely */
> > +	for (i =3D 0; i < esw->num_phy - 1; i++)
> > +		psgmii_st_phy_start_traffic(esw->phydev[i]);
> > +
> > +	/* wait for the traffic to complete on all PHYs */
> > +	result =3D psgmii_st_phy_wait_tx_complete(esw, esw->phy_mask);
> > +
> > +	/* Power down all PHYs */
> > +	for (i =3D 0; i < esw->num_phy - 1; i++)
> > +		psgmii_st_phy_power_down(esw->phydev[i]);
> > +
> > +	return result;
> > +}
> > +
> > +struct psgmii_st_stats {
> > +	int succeed;
> > +	int failed;
> > +	int failed_max;
> > +	int failed_cont;
> > +};
> > +
> > +static void psgmii_st_update_stats(struct psgmii_st_stats *stats,
> > +				   bool success)
> > +{
> > +	if (success) {
> > +		stats->succeed++;
> > +		stats->failed_cont =3D 0;
> > +		return;
> > +	}
> > +
> > +	stats->failed++;
> > +	stats->failed_cont++;
> > +	if (stats->failed_max < stats->failed_cont)
> > +		stats->failed_max =3D stats->failed_cont;
> > +}
> > +
> > +static void psgmii_self_test(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	struct ess_switch *esw =3D &priv->esw;
> > +	struct psgmii_st_stats stats;
> > +	bool result =3D false;
> > +	unsigned long tm;
> > +	int i;
> > +
> > +	memset(&stats, 0, sizeof(stats));
> > +
> > +	tm =3D get_timer(0);
> > +
> > +	for (i =3D 0; i < esw->num_phy - 1; i++)
> > +		psgmii_st_phy_prepare(esw->phydev[i]);
> > +
> > +	for (i =3D 0; i < PSGMII_ST_NUM_RETRIES; i++) {
> > +		qca8075_ess_reset(dev);
> > +
> > +		/* enable loopback mode on the switch's ports */
> > +		esw_port_loopback_set_all(esw, true);
> > +
> > +		/* run test on each PHYs individually after each other */
> > +		result =3D psgmii_st_run_test_serial(esw);
> > +
> > +		if (result) {
> > +			/* run test on each PHYs parallely */
> > +			result =3D psgmii_st_run_test_parallel(esw);
> > +		}
> > +
> > +		psgmii_st_update_stats(&stats, result);
> > +
> > +		if (psgmii_self_test_repeat)
> > +			continue;
> > +
> > +		if (result)
> > +			break;
> > +	}
> > +
> > +	for (i =3D 0; i < esw->num_phy - 1; i++) {
> > +		/* Configuration recover */
> > +		psgmii_st_phy_recover(esw->phydev[i]);
> > +
> > +		/* Disable loopback */
> > +		phy_write(esw->phydev[i], MDIO_DEVAD_NONE,
> > +			  QCA807X_FUNCTION_CONTROL, 0x6860);
> > +		phy_write(esw->phydev[i], MDIO_DEVAD_NONE, MII_BMCR, 0x9040);
> > +	}
> > +
> > +	/* disable loopback mode on the switch's ports */
> > +	esw_port_loopback_set_all(esw, false);
> > +
> > +	tm =3D get_timer(tm);
> > +	dev_dbg(priv->dev, "\nPSGMII self-test: succeed %d, failed %d (max %d=
), duration %lu.%03lu secs\n",
> > +	      stats.succeed, stats.failed, stats.failed_max,
> > +	      tm / 1000, tm % 1000);
> > +}
> > +
> > +static int ess_switch_disable_lookup(struct ess_switch *esw)
> > +{
> > +	int val;
> > +	int i;
> > +
> > +	/* Disable port lookup for all ports*/
> > +	for (i =3D 0; i < ESS_PORTS_NUM; i++) {
> > +		int ess_port_vid;
> > +
> > +		val =3D readl(esw->base + ESS_PORT_LOOKUP_CTRL(i));
> > +		val &=3D ~ESS_PORT_VID_MEM_MASK;
> > +
> > +		switch (i) {
> > +		case 0:
> > +			fallthrough;
> > +		case 5:
> > +			/* CPU,WAN port -> nothing */
> > +			ess_port_vid =3D 0;
> > +			break;
> > +		case 1 ... 4:
> > +			/* LAN ports -> all other LAN ports */
> > +			ess_port_vid =3D GENMASK(4, 1);
> > +			ess_port_vid &=3D ~BIT(i);
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		val |=3D FIELD_PREP(ESS_PORT_VID_MEM_MASK, ess_port_vid);
> > +
> > +		writel(val, esw->base + ESS_PORT_LOOKUP_CTRL(i));
> > +	}
> > +
> > +	/* Set magic value for the global forwarding register 1 */
> > +	writel(0x3e3e3e, esw->base + ESS_GLOBAL_FW_CTRL1);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ess_switch_enable_lookup(struct ess_switch *esw)
> > +{
> > +	int val;
> > +	int i;
> > +
> > +	/* Enable port lookup for all ports*/
> > +	for (i =3D 0; i < ESS_PORTS_NUM; i++) {
> > +		int ess_port_vid;
> > +
> > +		val =3D readl(esw->base + ESS_PORT_LOOKUP_CTRL(i));
> > +		val &=3D ~ESS_PORT_VID_MEM_MASK;
> > +
> > +		switch (i) {
> > +		case 0:
> > +			/* CPU port -> all other ports */
> > +			ess_port_vid =3D GENMASK(5, 1);
> > +			break;
> > +		case 1 ... 4:
> > +			/* LAN ports -> CPU and all other LAN ports */
> > +			ess_port_vid =3D GENMASK(4, 0);
> > +			ess_port_vid &=3D ~BIT(i);
> > +			break;
> > +		case 5:
> > +			/* WAN port -> CPU port only */
> > +			ess_port_vid =3D BIT(0);
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		val |=3D FIELD_PREP(ESS_PORT_VID_MEM_MASK, ess_port_vid);
> > +
> > +		writel(val, esw->base + ESS_PORT_LOOKUP_CTRL(i));
> > +	}
> > +
> > +	/* Set magic value for the global forwarding register 1 */
> > +	writel(0x3f3f3f, esw->base + ESS_GLOBAL_FW_CTRL1);
> > +
> > +	return 0;
> > +}
> > +
> > +static void ess_switch_init(struct ess_switch *esw)
> > +{
> > +	int val =3D 0;
> > +	int i;
> > +
> > +	/* Set magic value for the global forwarding register 1 */
> > +	writel(0x3e3e3e, esw->base + ESS_GLOBAL_FW_CTRL1);
> > +
> > +	/* Set 1000M speed, full duplex and RX/TX flow control for the CPU po=
rt*/
> > +	val &=3D ~ESS_PORT_SPEED_MASK;
> > +	val |=3D FIELD_PREP(ESS_PORT_SPEED_MASK, ESS_PORT_SPEED_1000);
> > +	val |=3D ESS_PORT_DUPLEX_MODE;
> > +	val |=3D ESS_PORT_TX_FLOW_EN;
> > +	val |=3D ESS_PORT_RX_FLOW_EN;
> > +
> > +	writel(val, esw->base + ESS_PORT0_STATUS);
> > +
> > +	/* Disable port lookup for all ports*/
> > +	for (i =3D 0; i < ESS_PORTS_NUM; i++) {
> > +		val =3D readl(esw->base + ESS_PORT_LOOKUP_CTRL(i));
> > +		val &=3D ~ESS_PORT_VID_MEM_MASK;
> > +
> > +		writel(val, esw->base + ESS_PORT_LOOKUP_CTRL(i));
> > +	}
> > +
> > +	/* Set HOL settings for all ports*/
> > +	for (i =3D 0; i < ESS_PORTS_NUM; i++) {
> > +		val =3D 0;
> > +
> > +		val |=3D FIELD_PREP(EG_PORT_QUEUE_NUM_MASK, 30);
> > +		if (i =3D=3D 0 || i =3D=3D 5) {
> > +			val |=3D FIELD_PREP(EG_PRI5_QUEUE_NUM_MASK, 4);
> > +			val |=3D FIELD_PREP(EG_PRI4_QUEUE_NUM_MASK, 4);
> > +		}
> > +		val |=3D FIELD_PREP(EG_PRI3_QUEUE_NUM_MASK, 4);
> > +		val |=3D FIELD_PREP(EG_PRI2_QUEUE_NUM_MASK, 4);
> > +		val |=3D FIELD_PREP(EG_PRI1_QUEUE_NUM_MASK, 4);
> > +		val |=3D FIELD_PREP(EG_PRI0_QUEUE_NUM_MASK, 4);
> > +
> > +		writel(val, esw->base + ESS_PORT_HOL_CTRL0(i));
> > +
> > +		val =3D readl(esw->base + ESS_PORT_HOL_CTRL1(i));
> > +		val &=3D ~ESS_ING_BUF_NUM_0_MASK;
> > +		val |=3D FIELD_PREP(ESS_ING_BUF_NUM_0_MASK, 6);
> > +
> > +		writel(val, esw->base + ESS_PORT_HOL_CTRL1(i));
> > +	}
> > +
> > +	/* Give switch some time */
> > +	mdelay(1);
> > +
> > +	/* Enable RX and TX MAC-s */
> > +	val =3D readl(esw->base + ESS_PORT0_STATUS);
> > +	val |=3D ESS_PORT_TXMAC_EN;
> > +	val |=3D ESS_PORT_RXMAC_EN;
> > +
> > +	writel(val, esw->base + ESS_PORT0_STATUS);
> > +
> > +	/* Set magic value for the global forwarding register 1 */
> > +	writel(0x7f7f7f, esw->base + ESS_GLOBAL_FW_CTRL1);
> > +}
> > +
> > +static int essedma_of_phy(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	struct ess_switch *esw =3D &priv->esw;
> > +	int num_phy =3D 0, ret =3D 0;
> > +	ofnode node;
> > +	int i;
> > +
> > +	ofnode_for_each_subnode(node, esw->ports_node) {
> > +		struct ofnode_phandle_args phandle_args;
> > +		struct phy_device *phydev;
> > +		u32 phy_addr;
> > +
> > +		if (ofnode_is_enabled(node)) {
> > +			if (ofnode_parse_phandle_with_args(node, "phy-handle", NULL, 0, 0,
> > +					       &phandle_args)) {
> > +				dev_dbg(priv->dev, "Failed to find phy-handle\n");
> > +				return -ENODEV;
> > +			}
> > +
> > +			ret =3D ofnode_read_u32(phandle_args.node, "reg", &phy_addr);
> > +			if (ret) {
> > +				dev_dbg(priv->dev, "Missing reg property in PHY node %s\n",
> > +				      ofnode_get_name(phandle_args.node));
> > +				return ret;
> > +			}
> > +
> > +			phydev =3D dm_mdio_phy_connect(priv->mdio_dev, phy_addr,
> > +						     dev, priv->esw.port_wrapper_mode);
> > +			if (!phydev) {
> > +				dev_dbg(priv->dev, "Failed to find phy on addr %d\n", phy_addr);
> > +				return -ENODEV;
> > +			}
> > +
> > +			phydev->node =3D phandle_args.node;
> > +			ret =3D phy_config(phydev);
> > +
> > +			esw->phydev[num_phy] =3D phydev;
> > +
> > +			num_phy++;
> > +		}
> > +	}
> > +
> > +	esw->num_phy =3D num_phy;
> > +
> > +	for (i =3D 0; i < esw->num_phy - 1; i++)
> > +		esw->phy_mask |=3D BIT(i);
> > +
> > +	return ret;
> > +}
> > +
> > +static int essedma_of_switch(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	int port_wrapper_mode =3D -1;
> > +
> > +	priv->esw.ports_node =3D ofnode_find_subnode(dev_ofnode(dev), "ports"=
);
> > +	if (!ofnode_valid(priv->esw.ports_node)) {
> > +		printf("Failed to find ports node\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	port_wrapper_mode =3D ofnode_read_phy_mode(priv->esw.ports_node);
> > +	if (port_wrapper_mode =3D=3D -1)
> > +		return -EINVAL;
> > +
> > +	priv->esw.port_wrapper_mode =3D port_wrapper_mode;
> > +
> > +	return essedma_of_phy(dev);
> > +}
> > +
> > +static void ipq40xx_edma_start_rx_tx(struct essedma_priv *priv)
> > +{
> > +	volatile u32 data;
> > +
> > +	/* enable RX queues */
> > +	data =3D readl(priv->base + EDMA_REG_RXQ_CTRL);
> > +	data |=3D EDMA_RXQ_CTRL_EN;
> > +	writel(data, priv->base + EDMA_REG_RXQ_CTRL);
> > +
> > +	/* enable TX queues */
> > +	data =3D readl(priv->base + EDMA_REG_TXQ_CTRL);
> > +	data |=3D EDMA_TXQ_CTRL_TXQ_EN;
> > +	writel(data, priv->base + EDMA_REG_TXQ_CTRL);
> > +}
> > +
> > +/*
> > + * ipq40xx_edma_init_desc()
> > + * Update descriptor ring size,
> > + * Update buffer and producer/consumer index
> > + */
> > +static void ipq40xx_edma_init_desc(struct essedma_priv *priv)
> > +{
> > +	struct edma_ring *rfd_ring;
> > +	struct edma_ring *etdr;
> > +	volatile u32 data =3D 0;
> > +	u16 hw_cons_idx =3D 0;
> > +
> > +	/* Set the base address of every TPD ring. */
> > +	etdr =3D &priv->tpd_ring;
> > +
> > +	/* Update TX descriptor ring base address. */
> > +	writel((u32)(etdr->dma & 0xffffffff),
> > +	       priv->base + EDMA_REG_TPD_BASE_ADDR_Q(EDMA_TXQ_ID));
> > +	data =3D readl(priv->base + EDMA_REG_TPD_IDX_Q(EDMA_TXQ_ID));
> > +
> > +	/* Calculate hardware consumer index for Tx. */
> > +	hw_cons_idx =3D FIELD_GET(EDMA_TPD_CONS_IDX_MASK, data);
> > +	etdr->head =3D hw_cons_idx;
> > +	etdr->tail =3D hw_cons_idx;
> > +	data &=3D ~EDMA_TPD_PROD_IDX_MASK;
> > +	data |=3D hw_cons_idx;
> > +
> > +	/* Update producer index for Tx. */
> > +	writel(data, priv->base + EDMA_REG_TPD_IDX_Q(EDMA_TXQ_ID));
> > +
> > +	/* Update SW consumer index register for Tx. */
> > +	writel(hw_cons_idx,
> > +	       priv->base + EDMA_REG_TX_SW_CONS_IDX_Q(EDMA_TXQ_ID));
> > +
> > +	/* Set TPD ring size. */
> > +	writel((u32)(etdr->count & EDMA_TPD_RING_SIZE_MASK),
> > +	       priv->base + EDMA_REG_TPD_RING_SIZE);
> > +
> > +	/* Configure Rx ring. */
> > +	rfd_ring =3D &priv->rfd_ring;
> > +
> > +	/* Update Receive Free descriptor ring base address. */
> > +	writel((u32)(rfd_ring->dma & 0xffffffff),
> > +	       priv->base + EDMA_REG_RFD_BASE_ADDR_Q(EDMA_RXQ_ID));
> > +	data =3D readl(priv->base + EDMA_REG_RFD_BASE_ADDR_Q(EDMA_RXQ_ID));
> > +
> > +	/* Update RFD ring size and RX buffer size. */
> > +	data =3D (rfd_ring->count & EDMA_RFD_RING_SIZE_MASK)
> > +				<< EDMA_RFD_RING_SIZE_SHIFT;
> > +	data |=3D (EDMA_MAX_PKT_SIZE & EDMA_RX_BUF_SIZE_MASK)
> > +				<< EDMA_RX_BUF_SIZE_SHIFT;
> > +	writel(data, priv->base + EDMA_REG_RX_DESC0);
> > +
> > +	/* Disable TX FIFO low watermark and high watermark */
> > +	writel(0, priv->base + EDMA_REG_TXF_WATER_MARK);
> > +
> > +	/* Load all of base address above */
> > +	data =3D readl(priv->base + EDMA_REG_TX_SRAM_PART);
> > +	data |=3D 1 << EDMA_LOAD_PTR_SHIFT;
> > +	writel(data, priv->base + EDMA_REG_TX_SRAM_PART);
> > +}
> > +
> > +static void ipq40xx_edma_init_rfd_ring(struct essedma_priv *priv)
> > +{
> > +	struct edma_ring *erdr =3D &priv->rfd_ring;
> > +	struct edma_rfd *rfds =3D erdr->hw_desc;
> > +	int i;
> > +
> > +	for (i =3D 0; i < erdr->count; i++)
> > +		rfds[i].buffer_addr =3D virt_to_phys(net_rx_packets[i]);
> > +
> > +	flush_dcache_range(erdr->dma, erdr->dma + erdr->hw_size);
> > +
> > +	/* setup producer index */
> > +	erdr->head =3D erdr->count - 1;
> > +	writel(erdr->head, priv->base + EDMA_REG_RFD_IDX_Q(EDMA_RXQ_ID));
> > +}
> > +
> > +static void ipq40xx_edma_configure(struct essedma_priv *priv)
> > +{
> > +	u32 tmp;
> > +	int i;
> > +
> > +	/* Set RSS type */
> > +	writel(IPQ40XX_EDMA_RSS_TYPE_NONE, priv->base + EDMA_REG_RSS_TYPE);
> > +
> > +	/* Configure RSS indirection table.
> > +	 * 128 hash will be configured in the following
> > +	 * pattern: hash{0,1,2,3} =3D {Q0,Q2,Q4,Q6} respectively
> > +	 * and so on
> > +	 */
> > +	for (i =3D 0; i < EDMA_NUM_IDT; i++)
> > +		writel(EDMA_RSS_IDT_VALUE, priv->base + EDMA_REG_RSS_IDT(i));
> > +
> > +	/* Set RFD burst number */
> > +	tmp =3D (EDMA_RFD_BURST << EDMA_RXQ_RFD_BURST_NUM_SHIFT);
> > +
> > +	/* Set RFD prefetch threshold */
> > +	tmp |=3D (EDMA_RFD_THR << EDMA_RXQ_RFD_PF_THRESH_SHIFT);
> > +
> > +	/* Set RFD in host ring low threshold to generte interrupt */
> > +	tmp |=3D (EDMA_RFD_LTHR << EDMA_RXQ_RFD_LOW_THRESH_SHIFT);
> > +	writel(tmp, priv->base + EDMA_REG_RX_DESC1);
> > +
> > +	/* configure reception control data. */
> > +
> > +	/* Set Rx FIFO threshold to start to DMA data to host */
> > +	tmp =3D EDMA_FIFO_THRESH_128_BYTE;
> > +
> > +	/* Set RX remove vlan bit */
> > +	tmp |=3D EDMA_RXQ_CTRL_RMV_VLAN;
> > +	writel(tmp, priv->base + EDMA_REG_RXQ_CTRL);
> > +
> > +	/* Configure transmission control data */
> > +	tmp =3D (EDMA_TPD_BURST << EDMA_TXQ_NUM_TPD_BURST_SHIFT);
> > +	tmp |=3D EDMA_TXQ_CTRL_TPD_BURST_EN;
> > +	tmp |=3D (EDMA_TXF_BURST << EDMA_TXQ_TXF_BURST_NUM_SHIFT);
> > +	writel(tmp, priv->base + EDMA_REG_TXQ_CTRL);
> > +}
> > +
> > +static void ipq40xx_edma_stop_rx_tx(struct essedma_priv *priv)
> > +{
> > +	volatile u32 data;
> > +
> > +	data =3D readl(priv->base + EDMA_REG_RXQ_CTRL);
> > +	data &=3D ~EDMA_RXQ_CTRL_EN;
> > +	writel(data, priv->base + EDMA_REG_RXQ_CTRL);
> > +	data =3D readl(priv->base + EDMA_REG_TXQ_CTRL);
> > +	data &=3D ~EDMA_TXQ_CTRL_TXQ_EN;
> > +	writel(data, priv->base + EDMA_REG_TXQ_CTRL);
> > +}
> > +
> > +static int ipq40xx_eth_recv(struct udevice *dev, int flags, uchar **pa=
cketp)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	struct edma_ring *erdr =3D &priv->rfd_ring;
> > +	struct edma_rrd *rrd;
> > +	u32 hw_tail;
> > +	u8 *rx_pkt;
> > +
> > +	hw_tail =3D readl(priv->base + EDMA_REG_RFD_IDX_Q(EDMA_RXQ_ID));
> > +	hw_tail =3D FIELD_GET(EDMA_RFD_CONS_IDX_MASK, hw_tail);
> > +
> > +	if (hw_tail =3D=3D erdr->tail)
> > +		return -EAGAIN;
> > +
> > +	rx_pkt =3D net_rx_packets[erdr->tail];
> > +	invalidate_dcache_range((unsigned long)rx_pkt,
> > +				(unsigned long)(rx_pkt + EDMA_MAX_PKT_SIZE));
> > +
> > +	rrd =3D (struct edma_rrd *)rx_pkt;
> > +
> > +	/* Check if RRD is valid */
> > +	if (!(rrd->rrd7 & EDMA_RRD7_DESC_VALID))
> > +		return 0;
> > +
> > +	*packetp =3D rx_pkt + EDMA_RRD_SIZE;
> > +
> > +	/* get the packet size */
> > +	return rrd->rrd6;
> > +}
> > +
> > +static int ipq40xx_eth_free_pkt(struct udevice *dev, uchar *packet,
> > +				int length)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	struct edma_ring *erdr;
> > +
> > +	erdr =3D &priv->rfd_ring;
> > +
> > +	/* Update the producer index */
> > +	writel(erdr->head, priv->base + EDMA_REG_RFD_IDX_Q(EDMA_RXQ_ID));
> > +
> > +	erdr->head++;
> > +	if (erdr->head =3D=3D erdr->count)
> > +		erdr->head =3D 0;
> > +
> > +	/* Update the consumer index */
> > +	erdr->tail++;
> > +	if (erdr->tail =3D=3D erdr->count)
> > +		erdr->tail =3D 0;
> > +
> > +	writel(erdr->tail,
> > +	       priv->base + EDMA_REG_RX_SW_CONS_IDX_Q(EDMA_RXQ_ID));
> > +
> > +	return 0;
> > +}
> > +
> > +static int ipq40xx_eth_start(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +
> > +	ipq40xx_edma_init_rfd_ring(priv);
> > +
> > +	ipq40xx_edma_start_rx_tx(priv);
> > +	ess_switch_enable_lookup(&priv->esw);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * One TPD would be enough for sending a packet, however because the
> > + * minimal cache line size is larger than the size of a TPD it is not
> > + * possible to flush only one at once. To overcome this limitation
> > + * multiple TPDs are used for sending a single packet.
> > + */
> > +#define EDMA_TPDS_PER_PACKET	4
> > +#define EDMA_TPD_MIN_BYTES	4
> > +#define EDMA_MIN_PKT_SIZE	(EDMA_TPDS_PER_PACKET * EDMA_TPD_MIN_BYTES)
> > +
> > +#define EDMA_TX_COMPLETE_TIMEOUT	1000000
> > +
> > +static int ipq40xx_eth_send(struct udevice *dev, void *packet, int len=
gth)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	struct edma_tpd *first_tpd;
> > +	struct edma_tpd *tpds;
> > +	int i;
> > +
> > +	if (length < EDMA_MIN_PKT_SIZE)
> > +		return 0;
> > +
> > +	flush_dcache_range((unsigned long)(packet),
> > +			   (unsigned long)(packet) +
> > +			   roundup(length, ARCH_DMA_MINALIGN));
> > +
> > +	tpds =3D priv->tpd_ring.hw_desc;
> > +	for (i =3D 0; i < EDMA_TPDS_PER_PACKET; i++) {
> > +		struct edma_tpd *tpd;
> > +		void *frag;
> > +
> > +		frag =3D packet + (i * EDMA_TPD_MIN_BYTES);
> > +
> > +		/* get the next TPD */
> > +		tpd =3D &tpds[priv->tpd_ring.head];
> > +		if (i =3D=3D 0)
> > +			first_tpd =3D tpd;
> > +
> > +		/* update the software index */
> > +		priv->tpd_ring.head++;
> > +		if (priv->tpd_ring.head =3D=3D priv->tpd_ring.count)
> > +			priv->tpd_ring.head =3D 0;
> > +
> > +		tpd->svlan_tag =3D 0;
> > +		tpd->addr =3D virt_to_phys(frag);
> > +		tpd->word3 =3D EDMA_PORT_ENABLE_ALL << EDMA_TPD_PORT_BITMAP_SHIFT;
> > +
> > +		if (i < (EDMA_TPDS_PER_PACKET - 1)) {
> > +			tpd->len =3D EDMA_TPD_MIN_BYTES;
> > +			tpd->word1 =3D 0;
> > +		} else {
> > +			tpd->len =3D length;
> > +			tpd->word1 =3D 1 << EDMA_TPD_EOP_SHIFT;
> > +		}
> > +
> > +		length -=3D EDMA_TPD_MIN_BYTES;
> > +	}
> > +
> > +	/* make sure that memory writing completes */
> > +	wmb();
> > +
> > +	flush_dcache_range((unsigned long)first_tpd,
> > +			   (unsigned long)first_tpd +
> > +			   EDMA_TPDS_PER_PACKET * sizeof(struct edma_tpd));
> > +
> > +	/* update the TX producer index */
> > +	writel(priv->tpd_ring.head,
> > +	       priv->base + EDMA_REG_TPD_IDX_Q(EDMA_TXQ_ID));
> > +
> > +	/* Wait for TX DMA completion */
> > +	for (i =3D 0; i < EDMA_TX_COMPLETE_TIMEOUT; i++) {
> > +		u32 r, prod, cons;
> > +
> > +		r =3D readl(priv->base + EDMA_REG_TPD_IDX_Q(EDMA_TXQ_ID));
> > +		prod =3D FIELD_GET(EDMA_TPD_PROD_IDX_MASK, r);
> > +		cons =3D FIELD_GET(EDMA_TPD_CONS_IDX_MASK, r);
> > +
> > +		if (cons =3D=3D prod)
> > +			break;
> > +
> > +		udelay(1);
> > +	}
> > +
> > +	if (i =3D=3D EDMA_TX_COMPLETE_TIMEOUT)
> > +		printf("TX timeout: packet not sent!\n");
> > +
> > +	/* update the software TX consumer index register */
> > +	writel(priv->tpd_ring.head,
> > +	       priv->base + EDMA_REG_TX_SW_CONS_IDX_Q(EDMA_TXQ_ID));
> > +
> > +	return 0;
> > +}
> > +
> > +static void ipq40xx_eth_stop(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +
> > +	ess_switch_disable_lookup(&priv->esw);
> > +	ipq40xx_edma_stop_rx_tx(priv);
> > +}
> > +
> > +static void ipq40xx_edma_free_ring(struct edma_ring *ring)
> > +{
> > +	free(ring->hw_desc);
> > +}
> > +
> > +/*
> > + * Free Tx and Rx rings
> > + */
> > +static void ipq40xx_edma_free_rings(struct essedma_priv *priv)
> > +{
> > +	ipq40xx_edma_free_ring(&priv->tpd_ring);
> > +	ipq40xx_edma_free_ring(&priv->rfd_ring);
> > +}
> > +
> > +/*
> > + * ipq40xx_edma_alloc_ring()
> > + * allocate edma ring descriptor.
> > + */
> > +static int ipq40xx_edma_alloc_ring(struct edma_ring *erd,
> > +				   unsigned int desc_size)
> > +{
> > +	erd->head =3D 0;
> > +	erd->tail =3D 0;
> > +
> > +	 /* Alloc HW descriptors */
> > +	erd->hw_size =3D roundup(desc_size * erd->count,
> > +			       ARCH_DMA_MINALIGN);
> > +
> > +	erd->hw_desc =3D memalign(CONFIG_SYS_CACHELINE_SIZE, erd->hw_size);
> > +	if (!erd->hw_desc)
> > +		 return -ENOMEM;
> > +
> > +	memset(erd->hw_desc, 0, erd->hw_size);
> > +	erd->dma =3D virt_to_phys(erd->hw_desc);
> > +
> > +	return 0;
> > +
> > +}
> > +
> > +/*
> > + * ipq40xx_allocate_tx_rx_rings()
> > + */
> > +static int ipq40xx_edma_alloc_tx_rx_rings(struct essedma_priv *priv)
> > +{
> > +	int ret;
> > +
> > +	ret =3D ipq40xx_edma_alloc_ring(&priv->tpd_ring,
> > +				      sizeof(struct edma_tpd));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ipq40xx_edma_alloc_ring(&priv->rfd_ring,
> > +				      sizeof(struct edma_rfd));
> > +	if (ret)
> > +		goto err_free_tpd;
> > +
> > +	return 0;
> > +
> > +err_free_tpd:
> > +	ipq40xx_edma_free_ring(&priv->tpd_ring);
> > +	return ret;
> > +}
> > +
> > +static int ipq40xx_eth_write_hwaddr(struct udevice *dev)
> > +{
> > +	struct eth_pdata *pdata =3D dev_get_plat(dev);
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	unsigned char *mac =3D pdata->enetaddr;
> > +	u32 mac_lo, mac_hi;
> > +
> > +	mac_hi =3D ((u32)mac[0]) << 8 | (u32)mac[1];
> > +	mac_lo =3D ((u32)mac[2]) << 24 | ((u32)mac[3]) << 16 |
> > +		 ((u32)mac[4]) << 8 | (u32)mac[5];
> > +
> > +	writel(mac_lo, priv->base + REG_MAC_CTRL0);
> > +	writel(mac_hi, priv->base + REG_MAC_CTRL1);
> > +
> > +	return 0;
> > +}
> > +
> > +static int edma_init(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	int ret;
> > +
> > +	priv->tpd_ring.count =3D IPQ40XX_EDMA_TX_RING_SIZE;
> > +	priv->rfd_ring.count =3D PKTBUFSRX;
> > +
> > +	ret =3D ipq40xx_edma_alloc_tx_rx_rings(priv);
> > +	if (ret)
> > +		return -ENOMEM;
> > +
> > +	ipq40xx_edma_stop_rx_tx(priv);
> > +
> > +	/* Configure EDMA. */
> > +	ipq40xx_edma_configure(priv);
> > +
> > +	/* Configure descriptor Ring */
> > +	ipq40xx_edma_init_desc(priv);
> > +
> > +	ess_switch_disable_lookup(&priv->esw);
> > +
> > +	return 0;
> > +}
> > +
> > +static int essedma_probe(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +	int ret;
> > +
> > +	priv->dev =3D dev;
> > +
> > +	priv->base =3D dev_read_addr_name(dev, "edma");
> > +	if (priv->base =3D=3D FDT_ADDR_T_NONE)
> > +		return -EINVAL;
> > +
> > +	priv->psgmii_base =3D dev_read_addr_name(dev, "psgmii_phy");
> > +	if (priv->psgmii_base =3D=3D FDT_ADDR_T_NONE)
> > +		return -EINVAL;
> > +
> > +	priv->esw.base =3D dev_read_addr_name(dev, "base");
> > +	if (priv->esw.base =3D=3D FDT_ADDR_T_NONE)
> > +		return -EINVAL;
> > +
> > +	ret =3D clk_get_by_name(dev, "ess", &priv->ess_clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D reset_get_by_name(dev, "ess", &priv->ess_rst);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D clk_enable(&priv->ess_clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ess_reset(dev);
> > +
> > +	ret =3D uclass_get_device_by_driver(UCLASS_MDIO,
> > +					  DM_DRIVER_GET(ipq4019_mdio),
> > +					  &priv->mdio_dev);
> > +	if (ret) {
> > +		dev_dbg(dev, "Cant find IPQ4019 MDIO: %d\n", ret);
> > +		goto err;
> > +	}
> > +
> > +	/* OF switch and PHY parsing and configuration */
> > +	ret =3D essedma_of_switch(dev);
> > +	if (ret)
> > +		goto err;
> > +
> > +	switch (priv->esw.port_wrapper_mode) {
> > +	case PHY_INTERFACE_MODE_PSGMII:
> > +		writel(PSGMIIPHY_PLL_VCO_VAL,
> > +		       priv->psgmii_base + PSGMIIPHY_PLL_VCO_RELATED_CTRL);
> > +		writel(PSGMIIPHY_VCO_VAL, priv->psgmii_base +
> > +		       PSGMIIPHY_VCO_CALIBRATION_CTRL_REGISTER_1);
> > +		/* wait for 10ms */
> > +		mdelay(10);
> > +		writel(PSGMIIPHY_VCO_RST_VAL, priv->psgmii_base +
> > +		       PSGMIIPHY_VCO_CALIBRATION_CTRL_REGISTER_1);
> > +		break;
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +		writel(0x1, RGMII_TCSR_ESS_CFG);
> > +		writel(0x400, priv->esw.base + ESS_RGMII_CTRL);
> > +		break;
> > +	default:
> > +		printf("Unknown MII interface\n");
> > +	}
> > +
> > +	if (priv->esw.port_wrapper_mode =3D=3D PHY_INTERFACE_MODE_PSGMII)
> > +		psgmii_self_test(dev);
> > +
> > +	ess_switch_init(&priv->esw);
> > +
> > +	ret =3D edma_init(dev);
> > +	if (ret)
> > +		goto err;
> > +
> > +	return 0;
> > +
> > +err:
> > +	reset_assert(&priv->ess_rst);
> > +	clk_disable(&priv->ess_clk);
> > +	return ret;
> > +}
> > +
> > +static int essedma_remove(struct udevice *dev)
> > +{
> > +	struct essedma_priv *priv =3D dev_get_priv(dev);
> > +
> > +	ipq40xx_edma_free_rings(priv);
> > +
> > +	clk_disable(&priv->ess_clk);
> > +	reset_assert(&priv->ess_rst);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct eth_ops essedma_eth_ops =3D {
> > +	.start		=3D ipq40xx_eth_start,
> > +	.send		=3D ipq40xx_eth_send,
> > +	.recv		=3D ipq40xx_eth_recv,
> > +	.free_pkt	=3D ipq40xx_eth_free_pkt,
> > +	.stop		=3D ipq40xx_eth_stop,
> > +	.write_hwaddr	=3D ipq40xx_eth_write_hwaddr,
> > +};
> > +
> > +static const struct udevice_id essedma_ids[] =3D {
> > +	{ .compatible =3D "qcom,ipq4019-ess", },
> > +	{ }
> > +};
> > +
> > +U_BOOT_DRIVER(essedma) =3D {
> > +	.name		=3D "essedma",
> > +	.id		=3D UCLASS_ETH,
> > +	.of_match	=3D essedma_ids,
> > +	.probe		=3D essedma_probe,
> > +	.remove		=3D essedma_remove,
> > +	.priv_auto	=3D sizeof(struct essedma_priv),
> > +	.plat_auto 	=3D sizeof(struct eth_pdata),
> > +	.ops		=3D &essedma_eth_ops,
> > +	.flags		=3D DM_FLAG_ALLOC_PRIV_DMA,
> > +};
> > diff --git a/drivers/net/essedma.h b/drivers/net/essedma.h
> > new file mode 100644
> > index 0000000000..e0b5c968ca
> > --- /dev/null
> > +++ b/drivers/net/essedma.h
> > @@ -0,0 +1,198 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2020 Sartura Ltd.
> > + *
> > + * Author: Robert Marko <robert.marko@sartura.hr>
> > + *
> > + * Copyright (c) 2021 Toco Technologies FZE <contact@toco.ae>
> > + * Copyright (c) 2021 Gabor Juhos <j4g8y7@gmail.com>
> > + *
> > + * Qualcomm ESS EDMA ethernet driver
> > + */
> > +
> > +#ifndef _ESSEDMA_ETH_H
> > +#define _ESSEDMA_ETH_H
> > +
> > +#define ESS_PORTS_NUM				6
> > +
> > +#define ESS_RGMII_CTRL 				0x4
> > +
> > +#define ESS_GLOBAL_FW_CTRL1			0x624
> > +
> > +#define ESS_PORT0_STATUS			0x7c
> > +#define ESS_PORT_SPEED_MASK			GENMASK(1, 0)
> > +#define ESS_PORT_SPEED_1000			3
> > +#define ESS_PORT_SPEED_100			2
> > +#define ESS_PORT_SPEED_10			1
> > +#define ESS_PORT_TXMAC_EN			BIT(2)
> > +#define ESS_PORT_RXMAC_EN			BIT(3)
> > +#define ESS_PORT_TX_FLOW_EN			BIT(4)
> > +#define ESS_PORT_RX_FLOW_EN			BIT(5)
> > +#define ESS_PORT_DUPLEX_MODE		BIT(6)
> > +
> > +#define ESS_PORT_LOOKUP_CTRL(_p)	(0x660 + (_p) * 12)
> > +#define ESS_PORT_LOOP_BACK_EN		BIT(21)
> > +#define ESS_PORT_VID_MEM_MASK		GENMASK(6, 0)
> > +
> > +#define ESS_PORT_HOL_CTRL0(_p)		(0x970 + (_p) * 8)
> > +#define EG_PORT_QUEUE_NUM_MASK		GENMASK(29, 24)
> > +
> > +/* Ports 0 and 5 have queues 0-5
> > + * Ports 1 to 4 have queues 0-3
> > + */
> > +#define EG_PRI5_QUEUE_NUM_MASK		GENMASK(23, 20)
> > +#define EG_PRI4_QUEUE_NUM_MASK		GENMASK(19, 16)
> > +#define EG_PRI3_QUEUE_NUM_MASK		GENMASK(15, 12)
> > +#define EG_PRI2_QUEUE_NUM_MASK		GENMASK(11, 8)
> > +#define EG_PRI1_QUEUE_NUM_MASK		GENMASK(7, 4)
> > +#define EG_PRI0_QUEUE_NUM_MASK		GENMASK(3, 0)
> > +
> > +#define ESS_PORT_HOL_CTRL1(_p)		(0x974 + (_p) * 8)
> > +#define ESS_ING_BUF_NUM_0_MASK		GENMASK(3, 0)
> > +
> > +/* QCA807x PHY registers */
> > +#define QCA807X_CHIP_CONFIGURATION 	0x1f
> > +#define QCA807X_MEDIA_PAGE_SELECT 	BIT(15)
> > +
> > +#define QCA807X_POWER_DOWN 			BIT(11)
> > +
> > +#define QCA807X_FUNCTION_CONTROL				0x10
> > +#define QCA807X_MDI_CROSSOVER_MODE_MASK			GENMASK(6, 5)
> > +#define QCA807X_MDI_CROSSOVER_MODE_MANUAL_MDI	0
> > +#define QCA807X_POLARITY_REVERSAL				BIT(1)
> > +
> > +#define QCA807X_PHY_SPECIFIC					0x11
> > +#define QCA807X_PHY_SPECIFIC_LINK				BIT(10)
> > +
> > +#define QCA807X_MMD7_CRC_PACKET_COUNTER			0x8029
> > +#define QCA807X_MMD7_PACKET_COUNTER_SELFCLR		BIT(1)
> > +#define QCA807X_MMD7_CRC_PACKET_COUNTER_EN		BIT(0)
> > +#define QCA807X_MMD7_VALID_EGRESS_COUNTER_2		0x802e
> > +
> > +/* PSGMII specific registers */
> > +#define PSGMIIPHY_VCO_CALIBRATION_CTRL_REGISTER_1		0x9c
> > +#define PSGMIIPHY_VCO_VAL								0x4ada
> > +#define PSGMIIPHY_VCO_RST_VAL							0xada
> > +#define PSGMIIPHY_VCO_CALIBRATION_CTRL_REGISTER_2		0xa0
> > +
> > +#define PSGMIIPHY_PLL_VCO_RELATED_CTRL 					0x78c
> > +#define PSGMIIPHY_PLL_VCO_VAL							0x2803
> > +
> > +#define RGMII_TCSR_ESS_CFG	0x01953000
> > +
> > +/* EDMA registers */
> > +#define IPQ40XX_EDMA_TX_RING_SIZE	8
> > +#define IPQ40XX_EDMA_RSS_TYPE_NONE	0x1
> > +
> > +#define EDMA_RSS_TYPE		0
> > +#define EDMA_TPD_EOP_SHIFT	31
> > +
> > +/* tpd word 3 bit 18-28 */
> > +#define EDMA_TPD_PORT_BITMAP_SHIFT	18
> > +
> > +/* Enable Tx for all ports */
> > +#define EDMA_PORT_ENABLE_ALL	0x3E
> > +
> > +/* Edma receive consumer index */
> > +/* x =3D queue id */
> > +#define EDMA_REG_RX_SW_CONS_IDX_Q(x)	(0x220 + ((x) << 2))
> > +/* Edma transmit consumer index */
> > +#define EDMA_REG_TX_SW_CONS_IDX_Q(x)	(0x240 + ((x) << 2))
> > +/* TPD Index Register */
> > +#define EDMA_REG_TPD_IDX_Q(x)		(0x460 + ((x) << 2))
> > +/* Tx Descriptor Control Register */
> > +#define EDMA_REG_TPD_RING_SIZE		0x41C
> > +#define EDMA_TPD_RING_SIZE_MASK		0xFFFF
> > +
> > +/* Transmit descriptor base address */
> > + /* x =3D queue id */
> > +#define EDMA_REG_TPD_BASE_ADDR_Q(x)	(0x420 + ((x) << 2))
> > +#define EDMA_TPD_PROD_IDX_MASK		GENMASK(15, 0)
> > +#define EDMA_TPD_CONS_IDX_MASK		GENMASK(31, 16)
> > +
> > +#define EDMA_REG_TX_SRAM_PART		0x400
> > +#define EDMA_LOAD_PTR_SHIFT		16
> > +
> > +/* TXQ Control Register */
> > +#define EDMA_REG_TXQ_CTRL		0x404
> > +#define EDMA_TXQ_CTRL_TXQ_EN		0x20
> > +#define EDMA_TXQ_CTRL_TPD_BURST_EN	0x100
> > +#define EDMA_TXQ_NUM_TPD_BURST_SHIFT	0
> > +#define EDMA_TXQ_TXF_BURST_NUM_SHIFT	16
> > +#define EDMA_TXF_BURST			0x100
> > +#define EDMA_TPD_BURST			5
> > +
> > +#define EDMA_REG_TXF_WATER_MARK		0x408
> > +
> > +/* RSS Indirection Register */
> > +/* x =3D No. of indirection table */
> > +#define EDMA_REG_RSS_IDT(x)		(0x840 + ((x) << 2))
> > +#define EDMA_NUM_IDT			16
> > +#define EDMA_RSS_IDT_VALUE		0x64206420
> > +
> > +/* RSS Hash Function Type Register */
> > +#define EDMA_REG_RSS_TYPE	0x894
> > +
> > +/* x =3D queue id */
> > +#define EDMA_REG_RFD_BASE_ADDR_Q(x)	(0x950 + ((x) << 2))
> > +/* RFD Index Register */
> > +#define EDMA_RFD_BURST		8
> > +#define EDMA_RFD_THR		16
> > +#define EDMA_RFD_LTHR		0
> > +#define EDMA_REG_RFD_IDX_Q(x)	(0x9B0 + ((x) << 2))
> > +
> > +#define EDMA_RFD_CONS_IDX_MASK	GENMASK(27, 16)
> > +
> > +/* Rx Descriptor Control Register */
> > +#define EDMA_REG_RX_DESC0		0xA10
> > +#define EDMA_RFD_RING_SIZE_MASK		0xFFF
> > +#define EDMA_RX_BUF_SIZE_MASK		0xFFFF
> > +#define EDMA_RFD_RING_SIZE_SHIFT	0
> > +#define EDMA_RX_BUF_SIZE_SHIFT		16
> > +
> > +#define EDMA_REG_RX_DESC1		0xA14
> > +#define EDMA_RXQ_RFD_BURST_NUM_SHIFT	0
> > +#define EDMA_RXQ_RFD_PF_THRESH_SHIFT	8
> > +#define EDMA_RXQ_RFD_LOW_THRESH_SHIFT	16
> > +
> > +/* RXQ Control Register */
> > +#define EDMA_REG_RXQ_CTRL		0xA18
> > +#define EDMA_FIFO_THRESH_128_BYTE	0x0
> > +#define EDMA_RXQ_CTRL_RMV_VLAN		0x00000002
> > +#define EDMA_RXQ_CTRL_EN		0x0000FF00
> > +
> > +/* MAC Control Register */
> > +#define REG_MAC_CTRL0		0xC20
> > +#define REG_MAC_CTRL1		0xC24
> > +
> > +/* Transmit Packet Descriptor */
> > +struct edma_tpd {
> > +	u16 len; /* full packet including CRC */
> > +	u16 svlan_tag; /* vlan tag */
> > +	u32 word1; /* byte 4-7 */
> > +	u32 addr; /* address of buffer */
> > +	u32 word3; /* byte 12 */
> > +};
> > +
> > +/* Receive Return Descriptor */
> > +struct edma_rrd {
> > +	u16 rrd0;
> > +	u16 rrd1;
> > +	u16 rrd2;
> > +	u16 rrd3;
> > +	u16 rrd4;
> > +	u16 rrd5;
> > +	u16 rrd6;
> > +	u16 rrd7;
> > +} __packed;
> > +
> > +#define EDMA_RRD_SIZE			sizeof(struct edma_rrd)
> > +
> > +#define EDMA_RRD7_DESC_VALID		BIT(15)
> > +
> > +/* Receive Free Descriptor */
> > +struct edma_rfd {
> > +        u32 buffer_addr; /* buffer address */
> > +};
> > +
> > +#endif	/* _ESSEDMA_ETH_H */
>=20
> --=20
> // Caleb (they/them)

--=20
Tom

--Hmkn9kOX0KZYMQdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmai48QACgkQFHw5/5Y0
tyxXRwwAnZs5zq85afLosctggLVkR7RX1gsjg6tI7STcb6z1Jj+UXmaKvbD3Ftd4
RrXPfvb87F/S/1yfIQQ2hpUtWISSjfzhiH+T2alYGoezgZoiL5n2NY5gKrpfarr5
tIUcMPsiib/pfX/jWTbgtrD7pyYgP//hFo6lHMKJL5YyZpMHaIivd/MyUOilCMPS
+lfIj5mjIWPWtAzJ374b/IIvGH4zR6TVvJF5+/+DnHGSsgYL7c9ZfaUVun7lw6gc
jd7J+kBLEKQSl55GslPkHJbu46HT4/0fj3uPWONTWnooZ3VoXKNvCX7z4U41iq7m
w/2JkVJpQMPu2Hn93Nb+2rAkclDDKvW5M97hqa3T2FuiF3YAW58EY+dkzoyOvWEV
2RQWCrU4bQKhAE6QcQYulqk30W/SOYbJibEyVd1R6Ibu16SUkty4nBQcwuCUTYWt
ORbGd7mYNolf3ucY7J7fCDZVRfqBeKYkjK9dAM1kiEygnvPq3dNhQNkF+KF5E7UN
C3ibV6Vp
=ocju
-----END PGP SIGNATURE-----

--Hmkn9kOX0KZYMQdf--
