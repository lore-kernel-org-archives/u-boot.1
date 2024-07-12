Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19936C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 13:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E3E388387;
	Fri, 12 Jul 2024 15:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720790522;
	bh=RhvAZu3XEbOnm6viqkSsu8cUCnG/VBhCgMnBIDlFd9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fvJqk2ciQXSndDuKslXcAGfr143tc/TwrGtkyq7o7ajeL6f7Hvd+zSIxECvGOb8hU
	 IkwpYSiVTNokYjB9rQ1/o4yftfVphGk4Ojq/xLDd6Ymb/du4w/eroz87rWOqGMxzRW
	 Hn6wqgyD0NgxmuSr5Z3/iWDWvHR0KufU9R2MsL/1GDO3bFvUMHfJImkzeq8N0TNbYL
	 oDo+e744lLnuyD8MAbWuaoV2OnBOx2tyuSHirIfv0KegMRDQMW63BejKFC1vV5USTK
	 k5To3WAtaBRZVWiAYo1G2DR+qZjAC1OOYQLucg+eDHx8dcOg9usBbXVbvgzqutD64V
	 I96xGgkxBCo3w==
Received: from eryximachos (lmontsouris-657-1-115-25.w82-127.abo.wanadoo.fr
 [82.127.153.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1AE2A881BA;
 Fri, 12 Jul 2024 15:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720790520;
 bh=RhvAZu3XEbOnm6viqkSsu8cUCnG/VBhCgMnBIDlFd9w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tp2AZBgND8kvC0scfrEEvCpWU88uf1AB4n9V5k4jCPQnAFHO2HbIarRi+BUxRLfBx
 eJ4voYX+Z04R7E2HzYXMrEY+u69ftLhS1FMB1nh6AE7AUoH+zr5QcbAIxmJeh+oxIW
 i1oNljhqpX70yl0LY5SkcOt1+LkYljbq/uxgwQcw8U/KdGvnhfnt+JrAaMTsrvyNhP
 Knn9BIMOtkYOspgOXGcGa0xq7R5l3uEPWRcOkEekjg8oMdBpj8FC4jtbrgWb5SPZxE
 cbIA9/WgZfRtEq5bBp9madxgxJbdETSyztd8jeBhZo+2HgbUvcL8nA6GirykivYej+
 sLBvMkic+JOMA==
Date: Fri, 12 Jul 2024 15:21:56 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de,
 eugen.hristev@collabora.com, festevam@gmail.com,
 forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com,
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com,
 sjg@chromium.org, sumit.garg@linaro.org, trini@konsulko.com,
 xypron.glpk@gmx.de
Subject: Re: [RESEND PATCH v2 5/5] net: dwc_eth_qos: Add glue driver for
 Intel MAC
Message-ID: <ZpEt9H08z9d9RNZk@eryximachos>
References: <20240624083450.90297-1-pro@denx.de>
 <20240624083450.90297-6-pro@denx.de>
 <fe77cc22-a256-49ce-b03a-55d9bad5103b@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe77cc22-a256-49ce-b03a-55d9bad5103b@denx.de>
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

Hi Marek,

On Sun, Jun 30, 2024 at 07:38:43AM +0200, Marek Vasut wrote:
> On 6/24/24 10:34 AM, Philip Oberfichtner wrote:
> 
> > +++ b/drivers/net/dwc_eth_qos_intel.c
> > @@ -0,0 +1,446 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 DENX Software Engineering GmbH
> > + * Philip Oberfichtner <pro@denx.de>
> > + *
> > + * Based on linux v6.1.38, especially drivers/net/ethernet/stmicro/stmmac
> 
> It is 2024 now , also you might want to update this to match Linux 6.6.y
> which is the current LTS .
> 

Ack for V3.

> > + */
> > +
> > +#include <asm/io.h>
> > +#include <dm.h>
> > +#include <linux/delay.h>
> > +#include <miiphy.h>
> > +#include <net.h>
> > +#include <pci.h>
> > +
> > +#include "dwc_eth_qos.h"
> > +#include "dwc_eth_qos_intel.h"
> > +
> > +static struct pci_device_id intel_pci_ids[] = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_RGMII1G) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_SGMII1) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_SGMII2G5) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE0_RGMII1G) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII1G) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII2G5) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE1_RGMII1G) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII1G) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII2G5) },
> > +	{}
> > +};
> > +
> > +static int __pci_config(struct udevice *dev)
> > +{
> > +	u32 val;
> > +
> > +	/* Try to enable I/O accesses and bus-mastering */
> > +	dm_pci_read_config32(dev, PCI_COMMAND, &val);
> > +	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
> > +	dm_pci_write_config32(dev, PCI_COMMAND, val);
> > +
> > +	/* Make sure it worked */
> > +	dm_pci_read_config32(dev, PCI_COMMAND, &val);
> > +	if (!(val & PCI_COMMAND_MEMORY)) {
> > +		pr_err("%s: Can't enable I/O memory\n", __func__);
> 
> dev_err() please
> 
> > +		return -ENOSPC;
> > +	}
> > +
> > +	if (!(val & PCI_COMMAND_MASTER)) {
> > +		pr_err("%s: Can't enable bus-mastering\n", __func__);
> 
> dev_err() , fix globally.
> 

Ack for V3.

> > +		return -EPERM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void __limit_fifo_size(struct udevice *dev)
> 
> Please drop the leading __ from function names .
> 

Ack for V3.

> > +{
> > +	/*
> > +	 * As described in Intel Erratum EHL22, Document Number: 636674-2.1,
> > +	 * the PSE GbE Controllers advertise a wrong RX and TX fifo size.
> > +	 * Software should limit this value to 64KB.
> > +	 */
> > +	struct eqos_priv *eqos = dev_get_priv(dev);
> > +
> > +	eqos->tx_fifo_sz = 0x8000;
> > +	eqos->rx_fifo_sz = 0x8000;
> > +}
> > +
> > +static int __serdes_status_poll(struct udevice *dev,
> > +				unsigned char phyaddr, unsigned char phyreg,
> > +				unsigned short mask, unsigned short val)
> > +{
> > +	struct eqos_priv *eqos = dev_get_priv(dev);
> > +	unsigned int retries = 10;
> > +	unsigned short val_rd;
> > +
> > +	do {
> > +		miiphy_read(eqos->mii->name, phyaddr, phyreg, &val_rd);
> > +		if ((val_rd & mask) == (val & mask))
> > +			return 0;
> > +		udelay(POLL_DELAY_US);
> > +	} while (--retries);
> 
> Is this some implementation of phy_read_mmd_poll_timeout() ?
> 

Well ... sort of, but see below.


> > +	return -ETIMEDOUT;
> > +}
> > +
> > + /* Returns -ve if MAC is unknown and 0 on success */
> > +static int __mac_check_pse(const struct udevice *dev, bool *is_pse)
> > +{
> > +	struct pci_child_plat *plat = dev_get_parent_plat(dev);
> > +
> > +	if (!plat || plat->vendor != PCI_VENDOR_ID_INTEL)
> > +		return -ENXIO;
> > +
> > +	switch (plat->device) {
> > +	case PCI_DEVICE_ID_INTEL_EHL_PSE0_RGMII1G:
> > +	case PCI_DEVICE_ID_INTEL_EHL_PSE1_RGMII1G:
> > +	case PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII1G:
> > +	case PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII1G:
> > +	case PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII2G5:
> > +	case PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII2G5:
> > +		*is_pse = 1;
> > +		return 0;
> > +
> > +	case PCI_DEVICE_ID_INTEL_EHL_RGMII1G:
> > +	case PCI_DEVICE_ID_INTEL_EHL_SGMII1:
> > +	case PCI_DEVICE_ID_INTEL_EHL_SGMII2G5:
> > +		*is_pse = 0;
> > +		return 0;
> > +	};
> > +
> > +	return -ENXIO;
> > +}
> > +
> > +/* Check if we're in 2G5 mode */
> > +static bool __serdes_link_mode_2500(struct udevice *dev)
> > +{
> > +	const unsigned char phyad = INTEL_MGBE_ADHOC_ADDR;
> > +	struct eqos_priv *eqos = dev_get_priv(dev);
> > +	unsigned short data;
> > +
> > +	miiphy_read(eqos->mii->name, phyad, SERDES_GCR, &data);
> > +	if (((data & SERDES_LINK_MODE_MASK) >> SERDES_LINK_MODE_SHIFT) ==
> > +	    SERDES_LINK_MODE_2G5)
> 
> Use FIELD_PREP() and FIELD_GET() to simplify this bitfield extraction.
> 

Ack for V3.

> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static int __serdes_powerup(struct udevice *dev)
> > +{
> > +	/* Based on linux/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c */
> > +
> > +	const unsigned char phyad = INTEL_MGBE_ADHOC_ADDR;
> > +	struct eqos_priv *eqos = dev_get_priv(dev);
> > +	unsigned short data;
> > +	int ret;
> > +	bool is_pse;
> > +
> > +	/* Set the serdes rate and the PCLK rate */
> > +	miiphy_read(eqos->mii->name, phyad, SERDES_GCR0, &data);
> > +
> > +	data &= ~SERDES_RATE_MASK;
> > +	data &= ~SERDES_PCLK_MASK;
> > +
> > +	if (__serdes_link_mode_2500(dev))
> > +		data |= SERDES_RATE_PCIE_GEN2 << SERDES_RATE_PCIE_SHIFT |
> > +			SERDES_PCLK_37p5MHZ << SERDES_PCLK_SHIFT;
> > +	else
> > +		data |= SERDES_RATE_PCIE_GEN1 << SERDES_RATE_PCIE_SHIFT |
> > +			SERDES_PCLK_70MHZ << SERDES_PCLK_SHIFT;
> > +
> > +	miiphy_write(eqos->mii->name, phyad, SERDES_GCR0, data);
> > +
> > +	/* assert clk_req */
> > +	miiphy_read(eqos->mii->name, phyad, SERDES_GCR0, &data);
> > +	data |= SERDES_PLL_CLK;
> > +	miiphy_write(eqos->mii->name, phyad, SERDES_GCR0, data);
> 
> Could this use phy_modify() ?
> 


I do agree using the phy_read()-API all over the place would be nice.
But I currently cannot do so, as I do not have a struct phy_device.
I am not accessing an actual PHY here, but a MAC-internal submodule.

Please also refer to my comment in the xpcs_access() function below,
which suffers from the same problem.

Any advice on how to make this integrate more smoothly with the standard
API is very welcome.

Best regards,
Philip


> [...]

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
