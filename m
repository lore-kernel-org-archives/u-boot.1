Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB0ECD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 05:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D59881DB;
	Wed,  3 Apr 2024 07:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aKz3VcCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84889881DC; Wed,  3 Apr 2024 07:54:37 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ACED880D6
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 07:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4335sQOl114825;
 Wed, 3 Apr 2024 00:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712123666;
 bh=zL9tIgwVJY9qdg54OOfXlys6cTfnbZoRrV0mxgcYea4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=aKz3VcCDCpYB4bijLqgb0xAErhDmfURi94TdoDgU6qU2At6VfnsiQSA3s+d2QPmQX
 v0D5YBiBVkdiTTEPvqfLMP/LXHDwuz5k1wMG0GgyFMxJ57cOUrOac2j/UrHL/8olGX
 GdOfXyQY/2nmmYC+p76Dp90SGtKZw1TpBFWfRtiA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4335sQn8007810
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 00:54:26 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 00:54:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 00:54:26 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4335sKoj092864;
 Wed, 3 Apr 2024 00:54:20 -0500
Message-ID: <b5d48214-95c5-e11a-dd6a-95004158e014@ti.com>
Date: Wed, 3 Apr 2024 11:24:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/5] net: ti: icssg: Add Firmware config and
 classification APIs.
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Maxime Ripard <mripard@kernel.org>, Nishanth Menon
 <nm@ti.com>, Roger Quadros <rogerq@kernel.org>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Devarsh Thakkar <devarsht@ti.com>, Aradhya
 Bhatia <a-bhatia1@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240327052841.1692469-1-danishanwar@ti.com>
 <20240327052841.1692469-3-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240327052841.1692469-3-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 3/27/24 10:58 AM, MD Danish Anwar wrote:
> Add icssg_config.h / .c and icssg_classifier.c files. These are firmware
> configuration and classification related files. Add MII helper APIs and
> MACROs. These APIs and MACROs will be later used by ICSSG Ethernet driver.
> Also introduce icssg_prueth.h which has definition of prueth related
> structures.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ti/icss_mii_rt.h      | 192 ++++++++++++++
>  drivers/net/ti/icssg_classifier.c | 376 +++++++++++++++++++++++++++
>  drivers/net/ti/icssg_config.c     | 406 ++++++++++++++++++++++++++++++
>  drivers/net/ti/icssg_config.h     | 177 +++++++++++++
>  drivers/net/ti/icssg_prueth.h     |  83 ++++++
>  5 files changed, 1234 insertions(+)
>  create mode 100644 drivers/net/ti/icss_mii_rt.h
>  create mode 100644 drivers/net/ti/icssg_classifier.c
>  create mode 100644 drivers/net/ti/icssg_config.c
>  create mode 100644 drivers/net/ti/icssg_config.h
>  create mode 100644 drivers/net/ti/icssg_prueth.h
> 
> diff --git a/drivers/net/ti/icss_mii_rt.h b/drivers/net/ti/icss_mii_rt.h
> new file mode 100644
> index 0000000000..4a78394701
> --- /dev/null
> +++ b/drivers/net/ti/icss_mii_rt.h
> @@ -0,0 +1,192 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/* PRU-ICSS MII_RT register definitions
> + *
> + * Copyright (C) 2015-2024 Texas Instruments Incorporated - http://www.ti.com

In this and other patches, please fix the URL
s/http/https


> + */
> +
> +#ifndef __NET_PRUSS_MII_RT_H__
> +#define __NET_PRUSS_MII_RT_H__
> +
> +#include <regmap.h>
> +
> +/* PRUSS_MII_RT Registers */
> +#define PRUSS_MII_RT_RXCFG0		0x0
> +#define PRUSS_MII_RT_RXCFG1		0x4
> +#define PRUSS_MII_RT_TXCFG0		0x10
> +#define PRUSS_MII_RT_TXCFG1		0x14
> +#define PRUSS_MII_RT_TX_CRC0		0x20
> +#define PRUSS_MII_RT_TX_CRC1		0x24
> +#define PRUSS_MII_RT_TX_IPG0		0x30
> +#define PRUSS_MII_RT_TX_IPG1		0x34
> +#define PRUSS_MII_RT_PRS0		0x38
> +#define PRUSS_MII_RT_PRS1		0x3c
> +#define PRUSS_MII_RT_RX_FRMS0		0x40
> +#define PRUSS_MII_RT_RX_FRMS1		0x44
> +#define PRUSS_MII_RT_RX_PCNT0		0x48
> +#define PRUSS_MII_RT_RX_PCNT1		0x4c
> +#define PRUSS_MII_RT_RX_ERR0		0x50
> +#define PRUSS_MII_RT_RX_ERR1		0x54
> +
> +/* PRUSS_MII_RT_RXCFG0/1 bits */
> +#define PRUSS_MII_RT_RXCFG_RX_ENABLE		BIT(0)
> +#define PRUSS_MII_RT_RXCFG_RX_DATA_RDY_MODE_DIS	BIT(1)
> +#define PRUSS_MII_RT_RXCFG_RX_CUT_PREAMBLE	BIT(2)
> +#define PRUSS_MII_RT_RXCFG_RX_MUX_SEL		BIT(3)
> +#define PRUSS_MII_RT_RXCFG_RX_L2_EN		BIT(4)
> +#define PRUSS_MII_RT_RXCFG_RX_BYTE_SWAP		BIT(5)
> +#define PRUSS_MII_RT_RXCFG_RX_AUTO_FWD_PRE	BIT(6)
> +#define PRUSS_MII_RT_RXCFG_RX_L2_EOF_SCLR_DIS	BIT(9)
> +
> +/* PRUSS_MII_RT_TXCFG0/1 bits */
> +#define PRUSS_MII_RT_TXCFG_TX_ENABLE		BIT(0)
> +#define PRUSS_MII_RT_TXCFG_TX_AUTO_PREAMBLE	BIT(1)
> +#define PRUSS_MII_RT_TXCFG_TX_EN_MODE		BIT(2)
> +#define PRUSS_MII_RT_TXCFG_TX_BYTE_SWAP		BIT(3)
> +#define PRUSS_MII_RT_TXCFG_TX_MUX_SEL		BIT(8)
> +#define PRUSS_MII_RT_TXCFG_PRE_TX_AUTO_SEQUENCE	BIT(9)
> +#define PRUSS_MII_RT_TXCFG_PRE_TX_AUTO_ESC_ERR	BIT(10)
> +#define PRUSS_MII_RT_TXCFG_TX_32_MODE_EN	BIT(11)
> +#define PRUSS_MII_RT_TXCFG_TX_IPG_WIRE_CLK_EN	BIT(12)	/* SR2.0 onwards */
> +
> +#define PRUSS_MII_RT_TXCFG_TX_START_DELAY_SHIFT	16
> +#define PRUSS_MII_RT_TXCFG_TX_START_DELAY_MASK	GENMASK(25, 16)
> +
> +#define PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_SHIFT	28
> +#define PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_MASK	GENMASK(30, 28)
> +
> +/* PRUSS_MII_RT_TX_IPG0/1 bits */
> +#define PRUSS_MII_RT_TX_IPG_IPG_SHIFT	0
> +#define PRUSS_MII_RT_TX_IPG_IPG_MASK	GENMASK(9, 0)
> +
> +/* PRUSS_MII_RT_PRS0/1 bits */
> +#define PRUSS_MII_RT_PRS_COL	BIT(0)
> +#define PRUSS_MII_RT_PRS_CRS	BIT(1)
> +
> +/* PRUSS_MII_RT_RX_FRMS0/1 bits */
> +#define PRUSS_MII_RT_RX_FRMS_MIN_FRM_SHIFT	0
> +#define PRUSS_MII_RT_RX_FRMS_MIN_FRM_MASK	GENMASK(15, 0)
> +
> +#define PRUSS_MII_RT_RX_FRMS_MAX_FRM_SHIFT	16
> +#define PRUSS_MII_RT_RX_FRMS_MAX_FRM_MASK	GENMASK(31, 16)
> +
> +/* Min/Max in MII_RT_RX_FRMS */
> +/* For EMAC and Switch */
> +#define PRUSS_MII_RT_RX_FRMS_MAX	(VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
> +#define PRUSS_MII_RT_RX_FRMS_MIN_FRM	(64)
> +
> +/* for HSR and PRP */
> +#define PRUSS_MII_RT_RX_FRMS_MAX_FRM_LRE	(PRUSS_MII_RT_RX_FRMS_MAX + \
> +						 ICSS_LRE_TAG_RCT_SIZE)
> +/* PRUSS_MII_RT_RX_PCNT0/1 bits */
> +#define PRUSS_MII_RT_RX_PCNT_MIN_PCNT_SHIFT	0
> +#define PRUSS_MII_RT_RX_PCNT_MIN_PCNT_MASK	GENMASK(3, 0)
> +
> +#define PRUSS_MII_RT_RX_PCNT_MAX_PCNT_SHIFT	4
> +#define PRUSS_MII_RT_RX_PCNT_MAX_PCNT_MASK	GENMASK(7, 4)
> +
> +/* PRUSS_MII_RT_RX_ERR0/1 bits */
> +#define PRUSS_MII_RT_RX_ERR_MIN_PCNT_ERR	BIT(0)
> +#define PRUSS_MII_RT_RX_ERR_MAX_PCNT_ERR	BIT(1)
> +#define PRUSS_MII_RT_RX_ERR_MIN_FRM_ERR		BIT(2)
> +#define PRUSS_MII_RT_RX_ERR_MAX_FRM_ERR		BIT(3)
> +
> +#define ICSSG_CFG_OFFSET	0
> +#define RGMII_CFG_OFFSET	4
> +
> +/* Constant to choose between MII0 and MII1 */
> +#define ICSS_MII0	0
> +#define ICSS_MII1	1
> +
> +/* ICSSG_CFG Register bits */
> +#define ICSSG_CFG_SGMII_MODE	BIT(16)
> +#define ICSSG_CFG_TX_PRU_EN	BIT(11)
> +#define ICSSG_CFG_RX_SFD_TX_SOF_EN	BIT(10)
> +#define ICSSG_CFG_RTU_PRU_PSI_SHARE_EN	BIT(9)
> +#define ICSSG_CFG_IEP1_TX_EN	BIT(8)
> +#define ICSSG_CFG_MII1_MODE	GENMASK(6, 5)
> +#define ICSSG_CFG_MII1_MODE_SHIFT	5
> +#define ICSSG_CFG_MII0_MODE	GENMASK(4, 3)
> +#define ICSSG_CFG_MII0_MODE_SHIFT	3
> +#define ICSSG_CFG_RX_L2_G_EN	BIT(2)
> +#define ICSSG_CFG_TX_L2_EN	BIT(1)
> +#define ICSSG_CFG_TX_L1_EN	BIT(0)
> +
> +enum mii_mode { MII_MODE_MII = 0, MII_MODE_RGMII, MII_MODE_SGMII };
> +
> +/* RGMII CFG Register bits */
> +#define RGMII_CFG_INBAND_EN_MII0	BIT(16)
> +#define RGMII_CFG_GIG_EN_MII0	BIT(17)
> +#define RGMII_CFG_INBAND_EN_MII1	BIT(20)
> +#define RGMII_CFG_GIG_EN_MII1	BIT(21)
> +#define RGMII_CFG_FULL_DUPLEX_MII0	BIT(18)
> +#define RGMII_CFG_FULL_DUPLEX_MII1	BIT(22)
> +#define RGMII_CFG_SPEED_MII0	GENMASK(2, 1)
> +#define RGMII_CFG_SPEED_MII1	GENMASK(6, 5)
> +#define RGMII_CFG_SPEED_MII0_SHIFT	1
> +#define RGMII_CFG_SPEED_MII1_SHIFT	5
> +#define RGMII_CFG_FULLDUPLEX_MII0	BIT(3)
> +#define RGMII_CFG_FULLDUPLEX_MII1	BIT(7)
> +#define RGMII_CFG_FULLDUPLEX_MII0_SHIFT	3
> +#define RGMII_CFG_FULLDUPLEX_MII1_SHIFT	7
> +#define RGMII_CFG_SPEED_10M	0
> +#define RGMII_CFG_SPEED_100M	1
> +#define RGMII_CFG_SPEED_1G	2
> +
> +static inline void icssg_mii_update_ipg(struct regmap *mii_rt, int mii, u32 ipg)
> +{
> +	u32 val;
> +
> +	if (mii == ICSS_MII0) {
> +		regmap_write(mii_rt, PRUSS_MII_RT_TX_IPG0, ipg);
> +	} else {
> +		/* Errata workaround: IEP1 is not read by h/w unless IEP0 is written */
> +		regmap_read(mii_rt, PRUSS_MII_RT_TX_IPG0, &val);
> +		regmap_write(mii_rt, PRUSS_MII_RT_TX_IPG1, ipg);
> +		regmap_write(mii_rt, PRUSS_MII_RT_TX_IPG0, val);
> +	}
> +}
> +
> +static inline void icssg_update_rgmii_cfg(struct regmap *miig_rt, int speed,
> +					  bool full_duplex, int slice, struct prueth_priv *priv)
> +{
> +	u32 gig_en_mask, gig_val = 0, full_duplex_mask, full_duplex_val = 0;
> +	u32 inband_en_mask, inband_val = 0;
> +
> +	gig_en_mask = (slice == ICSS_MII0) ? RGMII_CFG_GIG_EN_MII0 :
> +					RGMII_CFG_GIG_EN_MII1;
> +	if (speed == SPEED_1000)
> +		gig_val = gig_en_mask;
> +	regmap_update_bits(miig_rt, RGMII_CFG_OFFSET, gig_en_mask, gig_val);
> +
> +	inband_en_mask = (slice == ICSS_MII0) ? RGMII_CFG_INBAND_EN_MII0 :
> +					RGMII_CFG_INBAND_EN_MII1;
> +	if (speed == SPEED_10 && phy_interface_is_rgmii(priv->phydev))
> +		inband_val = inband_en_mask;
> +	regmap_update_bits(miig_rt, RGMII_CFG_OFFSET, inband_en_mask, inband_val);
> +
> +	full_duplex_mask = (slice == ICSS_MII0) ? RGMII_CFG_FULL_DUPLEX_MII0 :
> +					   RGMII_CFG_FULL_DUPLEX_MII1;
> +	if (full_duplex)
> +		full_duplex_val = full_duplex_mask;
> +	regmap_update_bits(miig_rt, RGMII_CFG_OFFSET, full_duplex_mask,
> +			   full_duplex_val);
> +}
> +
> +static inline void icssg_miig_set_interface_mode(struct regmap *miig_rt, int mii, int phy_if)
> +{
> +	u32 val, mask, shift;
> +
> +	mask = mii == ICSS_MII0 ? ICSSG_CFG_MII0_MODE : ICSSG_CFG_MII1_MODE;
> +	shift =  mii == ICSS_MII0 ? ICSSG_CFG_MII0_MODE_SHIFT : ICSSG_CFG_MII1_MODE_SHIFT;
> +
> +	val = MII_MODE_RGMII;
> +	if (phy_if == PHY_INTERFACE_MODE_MII)
> +		val = MII_MODE_MII;
> +
> +	val <<= shift;
> +	regmap_update_bits(miig_rt, ICSSG_CFG_OFFSET, mask, val);
> +	regmap_read(miig_rt, ICSSG_CFG_OFFSET, &val);
> +}
> +
> +#endif /* __NET_PRUSS_MII_RT_H__ */
> diff --git a/drivers/net/ti/icssg_classifier.c b/drivers/net/ti/icssg_classifier.c
> new file mode 100644
> index 0000000000..df7383f1fa
> --- /dev/null
> +++ b/drivers/net/ti/icssg_classifier.c
> @@ -0,0 +1,376 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Texas Instruments ICSSG Ethernet Driver
> + *
> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + */
> +
> +#include <dm/ofnode.h>
> +#include <regmap.h>
> +
> +#define ICSSG_NUM_CLASSIFIERS	16
> +#define ICSSG_NUM_FT1_SLOTS	8
> +#define ICSSG_NUM_FT3_SLOTS	16
> +
> +#define ICSSG_NUM_CLASSIFIERS_IN_USE	1
> +
> +/* Filter 1 - FT1 */
> +#define FT1_NUM_SLOTS	8
> +#define FT1_SLOT_SIZE	0x10	/* bytes */
> +
> +/* offsets from FT1 slot base i.e. slot 1 start */
> +#define FT1_DA0		0x0
> +#define FT1_DA1		0x4
> +#define FT1_DA0_MASK	0x8
> +#define FT1_DA1_MASK	0xc
> +
> +#define FT1_N_REG(slize, n, reg)	(offs[slice].ft1_slot_base + FT1_SLOT_SIZE * (n) + (reg))
> +
> +#define FT1_LEN_MASK	GENMASK(19, 16)
> +#define FT1_LEN_SHIFT	16
> +#define FT1_LEN(len)	(((len) << FT1_LEN_SHIFT) & FT1_LEN_MASK)
> +
> +#define FT1_START_MASK	GENMASK(14, 0)
> +#define FT1_START(start)	((start) & FT1_START_MASK)
> +
> +#define FT1_MATCH_SLOT(n)	(GENMASK(23, 16) & (BIT(n) << 16))
> +
> +enum ft1_cfg_type {
> +	FT1_CFG_TYPE_DISABLED = 0,
> +	FT1_CFG_TYPE_EQ,
> +	FT1_CFG_TYPE_GT,
> +	FT1_CFG_TYPE_LT,
> +};
> +
> +#define FT1_CFG_SHIFT(n)	(2 * (n))
> +#define FT1_CFG_MASK(n)	(0x3 << FT1_CFG_SHIFT((n)))
> +
> +/* Filter 3 -  FT3 */
> +#define FT3_NUM_SLOTS	16
> +#define FT3_SLOT_SIZE	0x20	/* bytes */
> +
> +/* offsets from FT3 slot n's base */
> +#define FT3_START	0
> +#define FT3_START_AUTO	0x4
> +#define FT3_START_OFFSET	0x8
> +#define FT3_JUMP_OFFSET	0xc
> +#define FT3_LEN		0x10
> +#define FT3_CFG		0x14
> +#define FT3_T		0x18
> +#define FT3_T_MASK	0x1c
> +
> +#define FT3_N_REG(slize, n, reg)	\
> +	(offs[slice].ft3_slot_base + FT3_SLOT_SIZE * (n) + (reg))
> +
> +/* offsets from rx_class n's base */
> +#define RX_CLASS_AND_EN	0
> +#define RX_CLASS_OR_EN	0x4
> +
> +#define RX_CLASS_NUM_SLOTS	16
> +#define RX_CLASS_EN_SIZE	0x8	/* bytes */
> +
> +#define RX_CLASS_N_REG(slice, n, reg)	\
> +	(offs[slice].rx_class_base + RX_CLASS_EN_SIZE * (n) + (reg))
> +
> +/* RX Class Gates */
> +#define RX_CLASS_GATES_SIZE	0x4	/* bytes */
> +
> +#define RX_CLASS_GATES_N_REG(slice, n)	\
> +	(offs[slice].rx_class_gates_base + RX_CLASS_GATES_SIZE * (n))
> +
> +#define RX_CLASS_GATES_ALLOW_MASK	BIT(6)
> +#define RX_CLASS_GATES_RAW_MASK		BIT(5)
> +#define RX_CLASS_GATES_PHASE_MASK	BIT(4)
> +
> +/* RX Class traffic data matching bits */
> +#define RX_CLASS_FT_UC		BIT(31)
> +#define RX_CLASS_FT_MC		BIT(30)
> +#define RX_CLASS_FT_BC		BIT(29)
> +#define RX_CLASS_FT_FW		BIT(28)
> +#define RX_CLASS_FT_RCV		BIT(27)
> +#define RX_CLASS_FT_VLAN	BIT(26)
> +#define RX_CLASS_FT_DA_P	BIT(25)
> +#define RX_CLASS_FT_DA_I	BIT(24)
> +#define RX_CLASS_FT_FT1_MATCH_MASK	GENMASK(23, 16)
> +#define RX_CLASS_FT_FT1_MATCH_SHIFT	16
> +#define RX_CLASS_FT_FT3_MATCH_MASK	GENMASK(15, 0)
> +#define RX_CLASS_FT_FT3_MATCH_SHIFT	0
> +
> +#define RX_CLASS_FT_FT1_MATCH(slot)	\
> +	((BIT(slot) << RX_CLASS_FT_FT1_MATCH_SHIFT) & \
> +	RX_CLASS_FT_FT1_MATCH_MASK)
> +
> +enum rx_class_sel_type {
> +	RX_CLASS_SEL_TYPE_OR = 0,
> +	RX_CLASS_SEL_TYPE_AND = 1,
> +	RX_CLASS_SEL_TYPE_OR_AND_AND = 2,
> +	RX_CLASS_SEL_TYPE_OR_OR_AND = 3,
> +};
> +
> +#define FT1_CFG_SHIFT(n)	(2 * (n))
> +#define FT1_CFG_MASK(n)		(0x3 << FT1_CFG_SHIFT((n)))
> +
> +#define RX_CLASS_SEL_SHIFT(n)	(2 * (n))
> +#define RX_CLASS_SEL_MASK(n)	(0x3 << RX_CLASS_SEL_SHIFT((n)))
> +
> +#define ICSSG_CFG_OFFSET	0
> +#define MAC_INTERFACE_0		0x18
> +#define MAC_INTERFACE_1		0x1c
> +
> +#define ICSSG_CFG_RX_L2_G_EN	BIT(2)
> +
> +/* these are register offsets per PRU */
> +struct miig_rt_offsets {
> +	u32 mac0;
> +	u32 mac1;
> +	u32 ft1_start_len;
> +	u32 ft1_cfg;
> +	u32 ft1_slot_base;
> +	u32 ft3_slot_base;
> +	u32 ft3_p_base;
> +	u32 ft_rx_ptr;
> +	u32 rx_class_base;
> +	u32 rx_class_cfg1;
> +	u32 rx_class_cfg2;
> +	u32 rx_class_gates_base;
> +	u32 rx_green;
> +	u32 rx_rate_cfg_base;
> +	u32 rx_rate_src_sel0;
> +	u32 rx_rate_src_sel1;
> +	u32 tx_rate_cfg_base;
> +	u32 stat_base;
> +	u32 tx_hsr_tag;
> +	u32 tx_hsr_seq;
> +	u32 tx_vlan_type;
> +	u32 tx_vlan_ins;
> +};
> +
> +static struct miig_rt_offsets offs[] = {
> +	/* PRU0 */
> +	{
> +		0x8,
> +		0xc,
> +		0x80,
> +		0x84,
> +		0x88,
> +		0x108,
> +		0x308,
> +		0x408,
> +		0x40c,
> +		0x48c,
> +		0x490,
> +		0x494,
> +		0x4d4,
> +		0x4e4,
> +		0x504,
> +		0x508,
> +		0x50c,
> +		0x54c,
> +		0x63c,
> +		0x640,
> +		0x644,
> +		0x648,
> +	},
> +	/* PRU1 */
> +	{
> +		0x10,
> +		0x14,
> +		0x64c,
> +		0x650,
> +		0x654,
> +		0x6d4,
> +		0x8d4,
> +		0x9d4,
> +		0x9d8,
> +		0xa58,
> +		0xa5c,
> +		0xa60,
> +		0xaa0,
> +		0xab0,
> +		0xad0,
> +		0xad4,
> +		0xad8,
> +		0xb18,
> +		0xc08,
> +		0xc0c,
> +		0xc10,
> +		0xc14,
> +	},
> +};
> +
> +static inline u32 addr_to_da0(const u8 *addr)
> +{
> +	return (u32)(addr[0] | addr[1] << 8 |
> +		addr[2] << 16 | addr[3] << 24);
> +};
> +
> +static inline u32 addr_to_da1(const u8 *addr)
> +{
> +	return (u32)(addr[4] | addr[5] << 8);
> +};
> +
> +static void rx_class_ft1_set_start_len(struct regmap *miig_rt, int slice,
> +				       u16 start, u8 len)
> +{
> +	u32 offset, val;
> +
> +	offset = offs[slice].ft1_start_len;
> +	val = FT1_LEN(len) | FT1_START(start);
> +	regmap_write(miig_rt, offset, val);
> +}
> +
> +static void rx_class_ft1_set_da(struct regmap *miig_rt, int slice,
> +				int n, const u8 *addr)
> +{
> +	u32 offset;
> +
> +	offset = FT1_N_REG(slice, n, FT1_DA0);
> +	regmap_write(miig_rt, offset, addr_to_da0(addr));
> +	offset = FT1_N_REG(slice, n, FT1_DA1);
> +	regmap_write(miig_rt, offset, addr_to_da1(addr));
> +}
> +
> +static void rx_class_ft1_set_da_mask(struct regmap *miig_rt, int slice,
> +				     int n, const u8 *addr)
> +{
> +	u32 offset;
> +
> +	offset = FT1_N_REG(slice, n, FT1_DA0_MASK);
> +	regmap_write(miig_rt, offset, addr_to_da0(addr));
> +	offset = FT1_N_REG(slice, n, FT1_DA1_MASK);
> +	regmap_write(miig_rt, offset, addr_to_da1(addr));
> +}
> +
> +static void rx_class_ft1_cfg_set_type(struct regmap *miig_rt, int slice, int n,
> +				      enum ft1_cfg_type type)
> +{
> +	u32 offset;
> +
> +	offset = offs[slice].ft1_cfg;
> +	regmap_update_bits(miig_rt, offset, FT1_CFG_MASK(n),
> +			   type << FT1_CFG_SHIFT(n));
> +}
> +
> +static void rx_class_sel_set_type(struct regmap *miig_rt, int slice, int n,
> +				  enum rx_class_sel_type type)
> +{
> +	u32 offset;
> +
> +	offset = offs[slice].rx_class_cfg1;
> +	regmap_update_bits(miig_rt, offset, RX_CLASS_SEL_MASK(n),
> +			   type << RX_CLASS_SEL_SHIFT(n));
> +}
> +
> +static void rx_class_set_and(struct regmap *miig_rt, int slice, int n,
> +			     u32 data)
> +{
> +	u32 offset;
> +
> +	offset = RX_CLASS_N_REG(slice, n, RX_CLASS_AND_EN);
> +	regmap_write(miig_rt, offset, data);
> +}
> +
> +static void rx_class_set_or(struct regmap *miig_rt, int slice, int n,
> +			    u32 data)
> +{
> +	u32 offset;
> +
> +	offset = RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN);
> +	regmap_write(miig_rt, offset, data);
> +}
> +
> +void icssg_class_set_host_mac_addr(struct regmap *miig_rt, u8 *mac)
> +{
> +	regmap_write(miig_rt, MAC_INTERFACE_0, addr_to_da0(mac));
> +	regmap_write(miig_rt, MAC_INTERFACE_1, addr_to_da1(mac));
> +}
> +
> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
> +{
> +	regmap_write(miig_rt, offs[slice].mac0, addr_to_da0(mac));
> +	regmap_write(miig_rt, offs[slice].mac1, addr_to_da1(mac));
> +}
> +
> +void icssg_class_disable_n(struct regmap *miig_rt, int slice, int n)
> +{
> +	u32 data, offset;
> +
> +	/* AND_EN = 0 */
> +	rx_class_set_and(miig_rt, slice, n, 0);
> +	/* OR_EN = 0 */
> +	rx_class_set_or(miig_rt, slice, n, 0);
> +
> +	/* set CFG1 to OR */
> +	rx_class_sel_set_type(miig_rt, slice, n, RX_CLASS_SEL_TYPE_OR);
> +
> +	/* configure gate */
> +	offset = RX_CLASS_GATES_N_REG(slice, n);
> +	regmap_read(miig_rt, offset, &data);
> +	/* clear class_raw so we go through filters */
> +	data &= ~RX_CLASS_GATES_RAW_MASK;
> +	/* set allow and phase mask */
> +	data |= RX_CLASS_GATES_ALLOW_MASK | RX_CLASS_GATES_PHASE_MASK;
> +	regmap_write(miig_rt, offset, data);
> +}
> +
> +/* disable all RX traffic */
> +void icssg_class_disable(struct regmap *miig_rt, int slice)
> +{
> +	int n;
> +
> +	/* Enable RX_L2_G */
> +	regmap_update_bits(miig_rt, ICSSG_CFG_OFFSET, ICSSG_CFG_RX_L2_G_EN,
> +			   ICSSG_CFG_RX_L2_G_EN);
> +
> +	for (n = 0; n < ICSSG_NUM_CLASSIFIERS; n++)
> +		icssg_class_disable_n(miig_rt, slice, n);
> +
> +	/* FT1 Disabled */
> +	for (n = 0; n < ICSSG_NUM_FT1_SLOTS; n++) {
> +		u8 addr[] = { 0, 0, 0, 0, 0, 0, };
> +
> +		rx_class_ft1_cfg_set_type(miig_rt, slice, n,
> +					  FT1_CFG_TYPE_DISABLED);
> +		rx_class_ft1_set_da(miig_rt, slice, n, addr);
> +		rx_class_ft1_set_da_mask(miig_rt, slice, n, addr);
> +	}
> +
> +	/* clear CFG2 */
> +	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
> +}
> +
> +void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti)
> +{
> +	u32 data;
> +
> +	/* defaults */
> +	icssg_class_disable(miig_rt, slice);
> +
> +	/* Setup Classifier */
> +	/* match on Broadcast or MAC_PRU address */
> +	data = RX_CLASS_FT_BC | RX_CLASS_FT_DA_P;
> +
> +	/* multicast? */
> +	if (allmulti)
> +		data |= RX_CLASS_FT_MC;
> +
> +	rx_class_set_or(miig_rt, slice, 0, data);
> +
> +	/* set CFG1 for OR_OR_AND for classifier */
> +	rx_class_sel_set_type(miig_rt, slice, 0,
> +			      RX_CLASS_SEL_TYPE_OR_OR_AND);
> +
> +	/* clear CFG2 */
> +	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
> +}
> +
> +/* required for SR2 for SAV check */
> +void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
> +{
> +	u8 mask_addr[] = { 0, 0, 0, 0, 0, 0, };
> +
> +	rx_class_ft1_set_start_len(miig_rt, slice, 6, 6);
> +	rx_class_ft1_set_da(miig_rt, slice, 0, mac_addr);
> +	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
> +	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);
> +}
> diff --git a/drivers/net/ti/icssg_config.c b/drivers/net/ti/icssg_config.c
> new file mode 100644
> index 0000000000..b0ba870189
> --- /dev/null
> +++ b/drivers/net/ti/icssg_config.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* ICSSG Ethernet driver
> + *
> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#include <phy.h>
> +#include "icssg_prueth.h"
> +#include "icssg_switch_map.h"
> +#include "icss_mii_rt.h"
> +#include <dm/device_compat.h>
> +
> +/* TX IPG Values to be set for 100M and 1G link speeds.  These values are
> + * in ocp_clk cycles. So need change if ocp_clk is changed for a specific
> + * h/w design.
> + */
> +
> +/* SR2.0 IPG is in rgmii_clk (125MHz) clock cycles + 1 */
> +#define MII_RT_TX_IPG_100M      0x17
> +#define MII_RT_TX_IPG_1G        0xb
> +
> +#define	ICSSG_QUEUES_MAX		64
> +#define	ICSSG_QUEUE_OFFSET		0xd00
> +#define	ICSSG_QUEUE_PEEK_OFFSET		0xe00
> +#define	ICSSG_QUEUE_CNT_OFFSET		0xe40
> +#define	ICSSG_QUEUE_RESET_OFFSET	0xf40
> +
> +#define	ICSSG_NUM_TX_QUEUES	8
> +
> +#define	RECYCLE_Q_SLICE0	16
> +#define	RECYCLE_Q_SLICE1	17
> +
> +#define	ICSSG_NUM_OTHER_QUEUES	5	/* port, host and special queues */
> +
> +#define	PORT_HI_Q_SLICE0	32
> +#define	PORT_LO_Q_SLICE0	33
> +#define	HOST_HI_Q_SLICE0	34
> +#define	HOST_LO_Q_SLICE0	35
> +#define	HOST_SPL_Q_SLICE0	40	/* Special Queue */
> +
> +#define	PORT_HI_Q_SLICE1	36
> +#define	PORT_LO_Q_SLICE1	37
> +#define	HOST_HI_Q_SLICE1	38
> +#define	HOST_LO_Q_SLICE1	39
> +#define	HOST_SPL_Q_SLICE1	41	/* Special Queue */
> +
> +#define MII_RXCFG_DEFAULT	(PRUSS_MII_RT_RXCFG_RX_ENABLE | \
> +				 PRUSS_MII_RT_RXCFG_RX_DATA_RDY_MODE_DIS | \
> +				 PRUSS_MII_RT_RXCFG_RX_L2_EN | \
> +				 PRUSS_MII_RT_RXCFG_RX_L2_EOF_SCLR_DIS)
> +
> +#define MII_TXCFG_DEFAULT	(PRUSS_MII_RT_TXCFG_TX_ENABLE | \
> +				 PRUSS_MII_RT_TXCFG_TX_AUTO_PREAMBLE | \
> +				 PRUSS_MII_RT_TXCFG_TX_32_MODE_EN | \
> +				 PRUSS_MII_RT_TXCFG_TX_IPG_WIRE_CLK_EN)
> +
> +#define ICSSG_CFG_DEFAULT	(ICSSG_CFG_TX_L1_EN | \
> +				 ICSSG_CFG_TX_L2_EN | ICSSG_CFG_RX_L2_G_EN | \
> +				 ICSSG_CFG_TX_PRU_EN | /* SR2.0 only */ \
> +				 ICSSG_CFG_SGMII_MODE)
> +
> +#define FDB_GEN_CFG1		0x60
> +#define SMEM_VLAN_OFFSET	8
> +#define SMEM_VLAN_OFFSET_MASK	GENMASK(25, 8)
> +
> +#define FDB_GEN_CFG2		0x64
> +#define FDB_VLAN_EN		BIT(6)
> +#define FDB_HOST_EN		BIT(2)
> +#define FDB_PRU1_EN		BIT(1)
> +#define FDB_PRU0_EN		BIT(0)
> +#define FDB_EN_ALL		(FDB_PRU0_EN | FDB_PRU1_EN | \
> +				 FDB_HOST_EN | FDB_VLAN_EN)
> +
> +struct map {
> +	int queue;
> +	u32 pd_addr_start;
> +	u32 flags;
> +	bool special;
> +};
> +
> +struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
> +	{
> +		{ PORT_HI_Q_SLICE0, PORT_DESC0_HI, 0x200000, 0 },
> +		{ PORT_LO_Q_SLICE0, PORT_DESC0_LO, 0, 0 },
> +		{ HOST_HI_Q_SLICE0, HOST_DESC0_HI, 0x200000, 0 },
> +		{ HOST_LO_Q_SLICE0, HOST_DESC0_LO, 0, 0 },
> +		{ HOST_SPL_Q_SLICE0, HOST_SPPD0, 0x400000, 1 },
> +	},
> +	{
> +		{ PORT_HI_Q_SLICE1, PORT_DESC1_HI, 0xa00000, 0 },
> +		{ PORT_LO_Q_SLICE1, PORT_DESC1_LO, 0x800000, 0 },
> +		{ HOST_HI_Q_SLICE1, HOST_DESC1_HI, 0xa00000, 0 },
> +		{ HOST_LO_Q_SLICE1, HOST_DESC1_LO, 0x800000, 0 },
> +		{ HOST_SPL_Q_SLICE1, HOST_SPPD1, 0xc00000, 1 },
> +	},
> +};
> +
> +static void icssg_config_mii_init(struct prueth_priv *priv, int slice)
> +{
> +	struct prueth *prueth = priv->prueth;
> +	struct regmap *mii_rt = prueth->mii_rt;
> +	u32 txcfg_reg, pcnt_reg;
> +	u32 txcfg;
> +
> +	txcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
> +				       PRUSS_MII_RT_TXCFG1;
> +	pcnt_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
> +				       PRUSS_MII_RT_RX_PCNT1;
> +
> +	txcfg = MII_TXCFG_DEFAULT;
> +
> +	if (prueth->phy_interface == PHY_INTERFACE_MODE_MII && slice == ICSS_MII0)
> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
> +	else if (prueth->phy_interface != PHY_INTERFACE_MODE_MII && slice == ICSS_MII1)
> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
> +
> +	regmap_write(mii_rt, txcfg_reg, txcfg);
> +	regmap_write(mii_rt, pcnt_reg, 0x1);
> +}
> +
> +static void icssg_miig_queues_init(struct prueth_priv *priv, int slice)
> +{
> +	struct prueth *prueth = priv->prueth;
> +	void __iomem *smem = (void __iomem *)prueth->shram.pa;
> +	struct regmap *miig_rt = prueth->miig_rt;
> +	int queue = 0, i, j;
> +	u8 pd[ICSSG_SPECIAL_PD_SIZE];
> +	u32 *pdword;
> +
> +	/* reset hwqueues */
> +	if (slice)
> +		queue = ICSSG_NUM_TX_QUEUES;
> +
> +	for (i = 0; i < ICSSG_NUM_TX_QUEUES; i++) {
> +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
> +		queue++;
> +	}
> +
> +	queue = slice ? RECYCLE_Q_SLICE1 : RECYCLE_Q_SLICE0;
> +	regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
> +
> +	for (i = 0; i < ICSSG_NUM_OTHER_QUEUES; i++) {
> +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET,
> +			     hwq_map[slice][i].queue);
> +	}
> +
> +	/* initialize packet descriptors in SMEM */
> +	/* push pakcet descriptors to hwqueues */
> +
> +	pdword = (u32 *)pd;
> +	for (j = 0; j < ICSSG_NUM_OTHER_QUEUES; j++) {
> +		struct map *mp;
> +		int pd_size, num_pds;
> +		u32 pdaddr;
> +
> +		mp = &hwq_map[slice][j];
> +		if (mp->special) {
> +			pd_size = ICSSG_SPECIAL_PD_SIZE;
> +			num_pds = ICSSG_NUM_SPECIAL_PDS;
> +		} else	{
> +			pd_size = ICSSG_NORMAL_PD_SIZE;
> +			num_pds = ICSSG_NUM_NORMAL_PDS;
> +		}
> +
> +		for (i = 0; i < num_pds; i++) {
> +			memset(pd, 0, pd_size);
> +
> +			pdword[0] &= cpu_to_le32(ICSSG_FLAG_MASK);
> +			pdword[0] |= cpu_to_le32(mp->flags);
> +			pdaddr = mp->pd_addr_start + i * pd_size;
> +
> +			memcpy_toio(smem + pdaddr, pd, pd_size);
> +			queue = mp->queue;
> +			regmap_write(miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue,
> +				     pdaddr);
> +		}
> +	}
> +}
> +
> +void icssg_config_ipg(struct prueth_priv *priv, int speed, int mii)
> +{
> +	struct prueth *prueth = priv->prueth;
> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		icssg_mii_update_ipg(prueth->mii_rt, mii, MII_RT_TX_IPG_1G);
> +		break;
> +	case SPEED_100:
> +		icssg_mii_update_ipg(prueth->mii_rt, mii, MII_RT_TX_IPG_100M);
> +		break;
> +	default:
> +		/* Other links speeds not supported */
> +		pr_err("Unsupported link speed\n");
> +		return;
> +	}
> +}
> +
> +static void emac_r30_cmd_init(struct prueth_priv *priv)
> +{
> +	struct prueth *prueth = priv->prueth;
> +	struct icssg_r30_cmd *p;
> +	int i;
> +
> +	p = (struct icssg_r30_cmd *)(prueth->dram[priv->port_id].pa + MGR_R30_CMD_OFFSET);
> +
> +	for (i = 0; i < 4; i++)
> +		writel(EMAC_NONE, &p->cmd[i]);
> +}
> +
> +static int emac_r30_is_done(struct prueth_priv *priv)
> +{
> +	struct prueth *prueth = priv->prueth;
> +	const struct icssg_r30_cmd *p;
> +	int i;
> +	u32 cmd;
> +
> +	p = (const struct icssg_r30_cmd *)(prueth->dram[priv->port_id].pa + MGR_R30_CMD_OFFSET);
> +
> +	for (i = 0; i < 4; i++) {
> +		cmd = readl(&p->cmd[i]);
> +		if (cmd != EMAC_NONE)
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int prueth_emac_buffer_setup(struct prueth_priv *priv)
> +{
> +	struct prueth *prueth = priv->prueth;
> +	struct icssg_buffer_pool_cfg *bpool_cfg;
> +	struct icssg_rxq_ctx *rxq_ctx;
> +	int slice = priv->port_id;
> +	u32 addr;
> +	int i;
> +
> +	/* Layout to have 64KB aligned buffer pool
> +	 * |BPOOL0|BPOOL1|RX_CTX0|RX_CTX1|
> +	 */
> +
> +	addr = lower_32_bits(prueth->sram_pa);
> +	if (slice)
> +		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
> +
> +	if (addr % SZ_64K) {
> +		dev_warn(prueth->dev, "buffer pool needs to be 64KB aligned\n");
> +		return -EINVAL;
> +	}
> +
> +	bpool_cfg = (struct icssg_buffer_pool_cfg *)(prueth->dram[priv->port_id].pa + BUFFER_POOL_0_ADDR_OFFSET);
> +	/* workaround for f/w bug. bpool 0 needs to be initilalized */
> +	bpool_cfg[0].addr = cpu_to_le32(addr);
> +	bpool_cfg[0].len = 0;
> +
> +	for (i = PRUETH_EMAC_BUF_POOL_START;
> +	     i < (PRUETH_EMAC_BUF_POOL_START + PRUETH_NUM_BUF_POOLS);
> +	     i++) {
> +		bpool_cfg[i].addr = cpu_to_le32(addr);
> +		bpool_cfg[i].len = cpu_to_le32(PRUETH_EMAC_BUF_POOL_SIZE);
> +		addr += PRUETH_EMAC_BUF_POOL_SIZE;
> +	}
> +
> +	if (!slice)
> +		addr += PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
> +	else
> +		addr += PRUETH_EMAC_RX_CTX_BUF_SIZE * 2;
> +
> +	rxq_ctx = (struct icssg_rxq_ctx *)(prueth->dram[priv->port_id].pa + HOST_RX_Q_PRE_CONTEXT_OFFSET);
> +
> +	for (i = 0; i < 3; i++)
> +		rxq_ctx->start[i] = cpu_to_le32(addr);
> +
> +	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
> +	rxq_ctx->end = cpu_to_le32(addr);
> +
> +	/* Express RX buffer queue */
> +	rxq_ctx = (struct icssg_rxq_ctx *)(prueth->dram[priv->port_id].pa + HOST_RX_Q_EXP_CONTEXT_OFFSET);
> +	for (i = 0; i < 3; i++)
> +		rxq_ctx->start[i] = cpu_to_le32(addr);
> +
> +	addr += PRUETH_EMAC_RX_CTX_BUF_SIZE;
> +	rxq_ctx->end = cpu_to_le32(addr);
> +
> +	return 0;
> +}
> +
> +static void icssg_init_emac_mode(struct prueth *prueth)
> +{
> +	u8 mac[6] = { 0 };
> +
> +	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK, 0);
> +	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, 0);
> +	/* Clear host MAC address */
> +	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
> +}
> +
> +int icssg_config(struct prueth_priv *priv)
> +{
> +	struct prueth *prueth = priv->prueth;
> +	void *config = (void *)(prueth->dram[priv->port_id].pa + ICSSG_CONFIG_OFFSET);
> +	u8 *cfg_byte_ptr = config;
> +	struct icssg_flow_cfg *flow_cfg;
> +	u32 mask;
> +	int ret;
> +
> +	int slice = priv->port_id;
> +
> +	icssg_init_emac_mode(prueth);
> +
> +	memset_io(config, 0, TAS_GATE_MASK_LIST0);
> +	icssg_miig_queues_init(priv, slice);
> +
> +	prueth->speed = SPEED_1000;
> +	prueth->duplex = DUPLEX_FULL;
> +	if (!phy_interface_is_rgmii(priv->phydev)) {
> +		prueth->speed = SPEED_100;
> +		prueth->duplex = DUPLEX_FULL;
> +	}
> +
> +	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
> +			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
> +	icssg_miig_set_interface_mode(prueth->miig_rt, ICSS_MII0, prueth->phy_interface);
> +	icssg_miig_set_interface_mode(prueth->miig_rt, ICSS_MII1, prueth->phy_interface);
> +	icssg_config_mii_init(priv, slice);
> +
> +	icssg_config_ipg(priv, SPEED_1000, slice);
> +	icssg_update_rgmii_cfg(prueth->miig_rt, SPEED_1000, true, slice, priv);
> +
> +	/* set GPI mode */
> +	pruss_cfg_gpimode(prueth->pruss, slice, PRUSS_GPI_MODE_MII);
> +
> +	/* enable XFR shift for PRU and RTU */
> +	mask = PRUSS_SPP_XFER_SHIFT_EN | PRUSS_SPP_RTU_XFR_SHIFT_EN;
> +	pruss_cfg_update(prueth->pruss, PRUSS_CFG_SPP, mask, mask);
> +
> +	flow_cfg = config + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
> +	flow_cfg->rx_base_flow = prueth->dma_rx.id;
> +	flow_cfg->mgm_base_flow = 0;
> +	*(cfg_byte_ptr + SPL_PKT_DEFAULT_PRIORITY) = 0;
> +	*(cfg_byte_ptr + QUEUE_NUM_UNTAGGED) = 0x0;
> +
> +	ret = prueth_emac_buffer_setup(priv);
> +
> +	if (ret)
> +		return ret;
> +
> +	emac_r30_cmd_init(priv);
> +	return 0;
> +}
> +
> +/* commands to program ICSSG R30 registers */
> +static struct icssg_r30_cmd emac_r32_bitmask[] = {
> +	{{0xffff0004, 0xffff0100, 0xffff0004, EMAC_NONE}},	/* EMAC_PORT_DISABLE */
> +	{{0xfffb0040, 0xfeff0200, 0xfeff0200, EMAC_NONE}},	/* EMAC_PORT_BLOCK */
> +	{{0xffbb0000, 0xfcff0000, 0xdcfb0000, EMAC_NONE}},	/* EMAC_PORT_FORWARD */
> +	{{0xffbb0000, 0xfcff0000, 0xfcff2000, EMAC_NONE}},	/* EMAC_PORT_FORWARD_WO_LEARNING */
> +	{{0xffff0001, EMAC_NONE,  EMAC_NONE, EMAC_NONE}},	/* ACCEPT ALL */
> +	{{0xfffe0002, EMAC_NONE,  EMAC_NONE, EMAC_NONE}},	/* ACCEPT TAGGED */
> +	{{0xfffc0000, EMAC_NONE,  EMAC_NONE, EMAC_NONE}},	/* ACCEPT UNTAGGED and PRIO */
> +	{{EMAC_NONE,  0xffff0020, EMAC_NONE, EMAC_NONE}},	/* TAS Trigger List change */
> +	{{EMAC_NONE,  0xdfff1000, EMAC_NONE, EMAC_NONE}},	/* TAS set state ENABLE*/
> +	{{EMAC_NONE,  0xefff2000, EMAC_NONE, EMAC_NONE}},	/* TAS set state RESET*/
> +	{{EMAC_NONE,  0xcfff0000, EMAC_NONE, EMAC_NONE}},	/* TAS set state DISABLE*/
> +	{{EMAC_NONE,  EMAC_NONE,  0xffff0400, EMAC_NONE}},	/* UC flooding ENABLE*/
> +	{{EMAC_NONE,  EMAC_NONE,  0xfbff0000, EMAC_NONE}},	/* UC flooding DISABLE*/
> +	{{EMAC_NONE,  EMAC_NONE,  0xffff0800, EMAC_NONE}},	/* MC flooding ENABLE*/
> +	{{EMAC_NONE,  EMAC_NONE,  0xf7ff0000, EMAC_NONE}},	/* MC flooding DISABLE*/
> +	{{EMAC_NONE,  0xffff4000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx ENABLE*/
> +	{{EMAC_NONE,  0xbfff0000, EMAC_NONE, EMAC_NONE}}	/* Preemption on Tx DISABLE*/
> +};
> +
> +int emac_set_port_state(struct prueth_priv *priv,
> +			enum icssg_port_state_cmd cmd)
> +{
> +	struct prueth *prueth = priv->prueth;
> +	struct icssg_r30_cmd *p;
> +	int ret = -ETIMEDOUT;
> +	int timeout = 10;
> +	int i;
> +
> +	p = (struct icssg_r30_cmd *)(prueth->dram[priv->port_id].pa + MGR_R30_CMD_OFFSET);
> +
> +	if (cmd >= ICSSG_EMAC_PORT_MAX_COMMANDS) {
> +		dev_err(prueth->dev, "invalid port command\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < 4; i++)
> +		writel(emac_r32_bitmask[cmd].cmd[i], &p->cmd[i]);
> +
> +	/* wait for done */
> +	while (timeout) {
> +		if (emac_r30_is_done(priv)) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		udelay(2000);
> +		timeout--;
> +	}
> +
> +	if (ret == -ETIMEDOUT)
> +		dev_err(prueth->dev, "timeout waiting for command done\n");
> +
> +	return ret;
> +}
> diff --git a/drivers/net/ti/icssg_config.h b/drivers/net/ti/icssg_config.h
> new file mode 100644
> index 0000000000..412dbf51c7
> --- /dev/null
> +++ b/drivers/net/ti/icssg_config.h
> @@ -0,0 +1,177 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Texas Instruments ICSSG Ethernet driver
> + *
> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + */
> +
> +#ifndef __NET_TI_ICSSG_CONFIG_H
> +#define __NET_TI_ICSSG_CONFIG_H
> +
> +struct icssg_buffer_pool_cfg {
> +	__le32  addr;
> +	__le32  len;
> +} __packed;
> +
> +struct icssg_flow_cfg {
> +	__le16 rx_base_flow;
> +	__le16 mgm_base_flow;
> +} __packed;
> +
> +/* Config area lies in shared RAM */
> +#define ICSSG_CONFIG_OFFSET_SLICE0   0
> +#define ICSSG_CONFIG_OFFSET_SLICE1   0x8000
> +
> +/* pstate speed/duplex command to set speed and duplex settings
> + * in firmware.
> + * Command format : 0x8102ssPN. ss - sequence number: currently not
> + * used by driver, P - port number: For switch, N - Speed/Duplex state
> + * - Possible values of N:
> + * 0x0 - 10Mbps/Half duplex ;
> + * 0x8 - 10Mbps/Full duplex ;
> + * 0x2 - 100Mbps/Half duplex;
> + * 0xa - 100Mbps/Full duplex;
> + * 0xc - 1Gbps/Full duplex;
> + * NOTE: The above are same as bits [3..1](slice 0) or bits [8..6](slice 1) of
> + * RGMII CFG register. So suggested to read the register to populate the command
> + * bits.
> + */
> +#define ICSSG_PSTATE_SPEED_DUPLEX_CMD	0x81020000
> +#define ICSSG_PSTATE_FULL_DUPLEX	BIT(3)
> +#define ICSSG_PSTATE_SPEED_100		BIT(1)
> +#define ICSSG_PSTATE_SPEED_1000		BIT(2)
> +
> +/* Flow IDs used in config structure to firmware. Should match with
> + * flow_id in struct dma for rx channels.
> + */
> +#define ICSSG_RX_CHAN_FLOW_ID		0 /* flow id for host port */
> +#define ICSSG_RX_MGM_CHAN_FLOW_ID	1 /* flow id for command response */
> +
> +/* Used to notify the FW of the current link speed */
> +#define PORT_LINK_SPEED_OFFSET			   0x00A8
> +
> +#define FW_LINK_SPEED_1G                           (0x00)
> +#define FW_LINK_SPEED_100M                         (0x01)
> +#define FW_LINK_SPEED_10M                          (0x02)
> +#define FW_LINK_SPEED_HD                           (0x80)
> +
> +#define PRUETH_PKT_TYPE_CMD	0x10
> +#define PRUETH_NAV_PS_DATA_SIZE	16	/* Protocol specific data size */
> +#define PRUETH_NAV_SW_DATA_SIZE	16	/* SW related data size */
> +#define PRUETH_MAX_RX_FLOWS	1	/* excluding default flow */
> +#define PRUETH_RX_FLOW_DATA	0	/* FIXME: f/w bug to change to highest priority flow */
> +
> +#define PRUETH_EMAC_BUF_POOL_SIZE	SZ_8K
> +#define PRUETH_EMAC_POOLS_PER_SLICE	24
> +#define PRUETH_EMAC_BUF_POOL_START	8
> +#define PRUETH_NUM_BUF_POOLS	8
> +#define PRUETH_EMAC_RX_CTX_BUF_SIZE	SZ_16K	/* per slice */
> +#define MSMC_RAM_SIZE	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
> +			      PRUETH_EMAC_RX_CTX_BUF_SIZE))
> +
> +struct icssg_rxq_ctx {
> +	__le32 start[3];
> +	__le32 end;
> +} __packed;
> +
> +/* Load time Fiwmware Configuration */
> +
> +#define ICSSG_FW_MGMT_CMD_HEADER	0x81
> +#define ICSSG_FW_MGMT_FDB_CMD_TYPE	0x03
> +#define ICSSG_FW_MGMT_CMD_TYPE		0x04
> +#define ICSSG_FW_MGMT_PKT		0x80000000
> +
> +struct icssg_r30_cmd {
> +	u32 cmd[4];
> +} __packed;
> +
> +enum icssg_port_state_cmd {
> +	ICSSG_EMAC_PORT_DISABLE = 0,
> +	ICSSG_EMAC_PORT_BLOCK,
> +	ICSSG_EMAC_PORT_FORWARD,
> +	ICSSG_EMAC_PORT_FORWARD_WO_LEARNING,
> +	ICSSG_EMAC_PORT_ACCEPT_ALL,
> +	ICSSG_EMAC_PORT_ACCEPT_TAGGED,
> +	ICSSG_EMAC_PORT_ACCEPT_UNTAGGED_N_PRIO,
> +	ICSSG_EMAC_PORT_TAS_TRIGGER,
> +	ICSSG_EMAC_PORT_TAS_ENABLE,
> +	ICSSG_EMAC_PORT_TAS_RESET,
> +	ICSSG_EMAC_PORT_TAS_DISABLE,
> +	ICSSG_EMAC_PORT_UC_FLOODING_ENABLE,
> +	ICSSG_EMAC_PORT_UC_FLOODING_DISABLE,
> +	ICSSG_EMAC_PORT_MC_FLOODING_ENABLE,
> +	ICSSG_EMAC_PORT_MC_FLOODING_DISABLE,
> +	ICSSG_EMAC_PORT_PREMPT_TX_ENABLE,
> +	ICSSG_EMAC_PORT_PREMPT_TX_DISABLE,
> +	ICSSG_EMAC_PORT_MAX_COMMANDS
> +};
> +
> +#define EMAC_NONE           0xffff0000
> +#define EMAC_PRU0_P_DI      0xffff0004
> +#define EMAC_PRU1_P_DI      0xffff0040
> +#define EMAC_TX_P_DI        0xffff0100
> +
> +#define EMAC_PRU0_P_EN      0xfffb0000
> +#define EMAC_PRU1_P_EN      0xffbf0000
> +#define EMAC_TX_P_EN        0xfeff0000
> +
> +#define EMAC_P_BLOCK        0xffff0040
> +#define EMAC_TX_P_BLOCK     0xffff0200
> +#define EMAC_P_UNBLOCK      0xffbf0000
> +#define EMAC_TX_P_UNBLOCK   0xfdff0000
> +#define EMAC_LEAN_EN        0xfff70000
> +#define EMAC_LEAN_DI        0xffff0008
> +
> +#define EMAC_ACCEPT_ALL     0xffff0001
> +#define EMAC_ACCEPT_TAG     0xfffe0002
> +#define EMAC_ACCEPT_PRIOR   0xfffc0000
> +
> +/* Config area lies in DRAM */
> +#define ICSSG_CONFIG_OFFSET			0x0
> +
> +#define ICSSG_NUM_NORMAL_PDS	64
> +#define ICSSG_NUM_SPECIAL_PDS	16
> +
> +#define ICSSG_NORMAL_PD_SIZE	8
> +#define ICSSG_SPECIAL_PD_SIZE	20
> +
> +#define ICSSG_FLAG_MASK		0xff00ffff
> +
> +struct icssg_setclock_desc {
> +	u8 request;
> +	u8 restore;
> +	u8 acknowledgment;
> +	u8 cmp_status;
> +	u32 margin;
> +	u32 cyclecounter0_set;
> +	u32 cyclecounter1_set;
> +	u32 iepcount_set;
> +	u32 rsvd1;
> +	u32 rsvd2;
> +	u32 CMP0_current;
> +	u32 iepcount_current;
> +	u32 difference;
> +	u32 cyclecounter0_new;
> +	u32 cyclecounter1_new;
> +	u32 CMP0_new;
> +} __packed;
> +
> +#define ICSSG_CMD_POP_SLICE0	56
> +#define ICSSG_CMD_POP_SLICE1	60
> +
> +#define ICSSG_CMD_PUSH_SLICE0	57
> +#define ICSSG_CMD_PUSH_SLICE1	61
> +
> +#define ICSSG_RSP_POP_SLICE0	58
> +#define ICSSG_RSP_POP_SLICE1	62
> +
> +#define ICSSG_RSP_PUSH_SLICE0	56
> +#define ICSSG_RSP_PUSH_SLICE1	60
> +
> +#define ICSSG_TS_POP_SLICE0	59
> +#define ICSSG_TS_POP_SLICE1	63
> +
> +#define ICSSG_TS_PUSH_SLICE0	40
> +#define ICSSG_TS_PUSH_SLICE1	41
> +
> +#endif /* __NET_TI_ICSSG_CONFIG_H */
> diff --git a/drivers/net/ti/icssg_prueth.h b/drivers/net/ti/icssg_prueth.h
> new file mode 100644
> index 0000000000..a7627a77d8
> --- /dev/null
> +++ b/drivers/net/ti/icssg_prueth.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Texas Instruments K3 AM65 Ethernet Switch SubSystem Driver
> + *
> + * Copyright (C) 2018-2024 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + */
> +
> +#ifndef __NET_TI_ICSSG_PRUETH_H
> +#define __NET_TI_ICSSG_PRUETH_H
> +
> +#include <asm/io.h>
> +#include <clk.h>
> +#include <dm/lists.h>
> +#include <dm/ofnode.h>
> +#include <dm/device.h>
> +#include <dma-uclass.h>
> +#include <regmap.h>
> +#include <linux/sizes.h>
> +#include <linux/pruss_driver.h>
> +#include "icssg_config.h"
> +#include "icssg_switch_map.h"
> +
> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
> +void icssg_class_set_host_mac_addr(struct regmap *miig_rt, u8 *mac);
> +void icssg_class_disable(struct regmap *miig_rt, int slice);
> +void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti);
> +void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr);
> +
> +enum prueth_mac {
> +	PRUETH_MAC0 = 0,
> +	PRUETH_MAC1,
> +	PRUETH_NUM_MACS,
> +};
> +
> +enum prueth_port {
> +	PRUETH_PORT_HOST = 0,	/* host side port */
> +	PRUETH_PORT_MII0,	/* physical port MII 0 */
> +	PRUETH_PORT_MII1,	/* physical port MII 1 */
> +};
> +
> +struct prueth {
> +	struct udevice		*dev;
> +	struct udevice		*pruss;
> +	struct regmap		*miig_rt;
> +	struct regmap		*mii_rt;
> +	fdt_addr_t		mdio_base;
> +	struct pruss_mem_region shram;
> +	struct pruss_mem_region dram[PRUETH_NUM_MACS];
> +	phys_addr_t		tmaddr;
> +	struct mii_dev		*bus;
> +	u32			sram_pa;
> +	ofnode			eth_node[PRUETH_NUM_MACS];
> +	u32			mdio_freq;
> +	int			phy_interface;
> +	struct			clk mdiofck;
> +	struct dma		dma_tx;
> +	struct dma		dma_rx;
> +	struct dma		dma_rx_mgm;
> +	u32			rx_next;
> +	u32			rx_pend;
> +	int			slice;
> +	bool			mdio_manual_mode;
> +	int			speed;
> +	int			duplex;
> +};
> +
> +struct prueth_priv {
> +	struct udevice		*dev;
> +	struct prueth		*prueth;
> +	u32			port_id;
> +	struct phy_device	*phydev;
> +	bool			has_phy;
> +	ofnode			phy_node;
> +	u32			phy_addr;
> +	int			phy_interface;
> +};
> +
> +/* config helpers */
> +void icssg_config_ipg(struct prueth_priv *priv, int speed, int mii);
> +int icssg_config(struct prueth_priv *priv);
> +int emac_set_port_state(struct prueth_priv *priv, enum icssg_port_state_cmd cmd);
> +
> +#endif /* __NET_TI_ICSSG_PRUETH_H */

-- 
Regards,
Ravi
