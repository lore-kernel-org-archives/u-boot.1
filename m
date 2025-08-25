Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F06CA0FE1
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 09:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E28A81E13;
	Mon, 25 Aug 2025 11:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="k2PUvyKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF1D82DA1; Mon, 25 Aug 2025 11:06:11 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E4E808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 11:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: b65315f8819211f0b33aeb1e7f16c2b6-20250825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=1Pe+YNy8speKV6YBLIzlc88cHSB8muHUC2CeS5xcyFo=; 
 b=k2PUvyKJ3GFExlW0bFI8rG+Yvik7tlIsJp18E3FU+PdAJvJzjyvZmgTMsLDfBsqG8RIMjuLRetlKAio/419QmL00PTNjT5bULRwTdG+G98anCJdFYBgGuNQ8DIinEuzTiAd4KPQvqbgVHHE0ulXfvKxV262vVtyY9JwIfcBi5Tg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:c5de5c64-d0a8-4803-bfd8-45880f5ab698, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:f1326cf, CLOUDID:8def4af4-66cd-4ff9-9728-6a6f64661009,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:-5,Content:0|15|5
 0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
 OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b65315f8819211f0b33aeb1e7f16c2b6-20250825
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 974375153; Mon, 25 Aug 2025 17:05:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 25 Aug 2025 17:05:55 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 25 Aug 2025 17:05:55 +0800
Message-ID: <6b4ef7d79ca45a672c615c77dce536959585f566.camel@mediatek.com>
Subject: Re: [RFC PATCH 1/5] net: mediatek: move MT7531 mdio to dedicated
 driver
From: Weijie Gao <weijie.gao@mediatek.com>
To: Christian Marangi <ansuelsmth@gmail.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>
Date: Mon, 25 Aug 2025 17:05:55 +0800
In-Reply-To: <68ac1ffa.5d0a0220.17158b.0bb1@mx.google.com>
References: <20250822232921.30076-1-ansuelsmth@gmail.com>
 <20250822232921.30076-2-ansuelsmth@gmail.com>
 <68a8fe48.050a0220.21a6f3.6783@mx.google.com>
 <b5d3f9ce91eefe2f039b63fd5f9ab557383f74dd.camel@mediatek.com>
 <68ac1ffa.5d0a0220.17158b.0bb1@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK: N
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

On Mon, 2025-08-25 at 10:33 +0200, Christian Marangi wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> On Mon, Aug 25, 2025 at 01:15:40AM +0000, Weijie Gao (高惟杰) wrote:
> > On Sat, 2025-08-23 at 01:33 +0200, Christian Marangi wrote:
> > > External email : Please do not click links or open attachments
> > > until
> > > you have verified the sender or the content.
> > > 
> > > 
> > > On Sat, Aug 23, 2025 at 01:29:15AM +0200, Christian Marangi
> > > wrote:
> > > > In preparation for support of MDIO on AN7581, move the MT7531
> > > > logic
> > > > to a
> > > > dedicated driver and permit usage of the mdio read/write
> > > > function
> > > > to the
> > > > mtk_eth driver.
> > > > 
> > > > Minor changes are required to mtk_eth for this change as the
> > > > dedicated
> > > > MDIO driver only needs info of the GSW register and nothing
> > > > else.
> > > > 
> > > > This permits Airoha driver to make use of DM_MDIO to bind for
> > > > the
> > > > MT7531
> > > > driver that have the same exact register.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  drivers/net/Kconfig          |   3 +
> > > >  drivers/net/Makefile         |   4 +
> > > >  drivers/net/mdio-mt7531.c    | 140
> > > > +++++++++++++++++++++++++++++++++++
> > > >  drivers/net/mdio-mt7531.h    |   9 +++
> > > >  drivers/net/mtk_eth/Kconfig  |   1 +
> > > >  drivers/net/mtk_eth/mt753x.c |  29 +++-----
> > > >  drivers/net/mtk_eth/mt753x.h |   3 +
> > > >  7 files changed, 169 insertions(+), 20 deletions(-)
> > > >  create mode 100644 drivers/net/mdio-mt7531.c
> > > >  create mode 100644 drivers/net/mdio-mt7531.h
> > > > 
> > > > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > > > index d1cb69f85ad..9ac9bee46c9 100644
> > > > --- a/drivers/net/Kconfig
> > > > +++ b/drivers/net/Kconfig
> > > > @@ -966,6 +966,9 @@ config TSEC_ENET
> > > >         This driver implements support for the (Enhanced)
> > > > Three-
> > > > Speed
> > > >         Ethernet Controller found on Freescale SoCs.
> > > > 
> > > > +config MDIO_MT7531
> > > > +     bool
> > > > +
> > > >  source "drivers/net/mtk_eth/Kconfig"
> > > > 
> > > >  config HIFEMAC_ETH
> > > > diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> > > > index f8f9a71f815..beb7864adc2 100644
> > > > --- a/drivers/net/Makefile
> > > > +++ b/drivers/net/Makefile
> > > > @@ -62,7 +62,11 @@ obj-$(CONFIG_LITEETH) += liteeth.o
> > > >  obj-$(CONFIG_MACB) += macb.o
> > > >  obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
> > > >  obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
> > > > +<<<<<<< HEAD
> > > >  obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
> > > > +=======
> > > > +obj-$(CONFIG_MDIO_MT7531) += mdio-mt7531.o
> > > > +>>>>>>> net: mediatek: move MT7531 mdio to dedicated driver
> > > 
> > > This merge conflict slipped in and will be fixed in the next
> > > revision.
> > > These changes were tested locally on an AN7581 RFB board.
> > > 
> > > >  obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
> > > >  obj-$(CONFIG_MDIO_MUX_MESON_G12A) += mdio_mux_meson_g12a.o
> > > >  obj-$(CONFIG_MDIO_MUX_MESON_GXL) += mdio_mux_meson_gxl.o
> > > > diff --git a/drivers/net/mdio-mt7531.c b/drivers/net/mdio-
> > > > mt7531.c
> > > > new file mode 100644
> > > > index 00000000000..4772c9b5407
> > > > --- /dev/null
> > > > +++ b/drivers/net/mdio-mt7531.c
> > > > @@ -0,0 +1,140 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +
> > > > +#include <asm/io.h>
> > > > +#include <dm.h>
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/iopoll.h>
> > > > +#include <miiphy.h>
> > > > +
> > > > +#define MT7531_PHY_IAC                       0x701c
> > > > +#define   MT7531_PHY_ACS_ST          BIT(31)
> > > > +#define   MT7531_MDIO_REG_ADDR_CL22  GENMASK(29, 25)
> > > > +#define   MT7531_MDIO_DEV_ADDR               MT7531_MDIO_REG_A
> > > > DDR_
> > > > CL22
> > > > +#define   MT7531_MDIO_PHY_ADDR               GENMASK(24, 20)
> > > > +#define   MT7531_MDIO_CMD            GENMASK(19, 18)
> > > > +#define   MT7531_MDIO_CMD_READ_CL45  FIELD_PREP_CONST(MT7531_M
> > > > DIO_
> > > > CMD, 0x3)
> > > > +#define   MT7531_MDIO_CMD_READ_CL22  FIELD_PREP_CONST(MT7531_M
> > > > DIO_
> > > > CMD, 0x2)
> > > > +#define   MT7531_MDIO_CMD_WRITE              FIELD_PREP_CONST(
> > > > MT75
> > > > 31_MDIO_CMD, 0x1)
> > > > +#define   MT7531_MDIO_CMD_ADDR               FIELD_PREP_CONST(
> > > > MT75
> > > > 31_MDIO_CMD, 0x0)
> > > > +#define   MT7531_MDIO_ST             GENMASK(17, 16)
> > > > +#define   MT7531_MDIO_ST_CL22                FIELD_PREP_CONST(
> > > > MT75
> > > > 31_MDIO_ST, 0x1)
> > > > +#define   MT7531_MDIO_ST_CL45                FIELD_PREP_CONST(
> > > > MT75
> > > > 31_MDIO_ST, 0x0)
> > > > +#define   MT7531_MDIO_RW_DATA                GENMASK(15, 0)
> > > > +#define   MT7531_MDIO_REG_ADDR_CL45  MT7531_MDIO_RW_DATA
> > > > +
> > > > +#define MT7531_MDIO_TIMEOUT          100000
> > > > +#define MT7531_MDIO_SLEEP            20
> > > > +
> > > > +struct mt7531_mdio_priv {
> > > > +     phys_addr_t switch_regs;
> > > > +};
> > > > +
> > > > +static int mt7531_mdio_wait_busy(struct mt7531_mdio_priv
> > > > *priv)
> > > > +{
> > > > +     unsigned int busy;
> > > > +
> > > > +     return readl_poll_sleep_timeout(priv->switch_regs +
> > > > MT7531_PHY_IAC,
> > > > +                                     busy, (busy &
> > > > MT7531_PHY_ACS_ST) == 0,
> > > > +                                     MT7531_MDIO_SLEEP,
> > > > MT7531_MDIO_TIMEOUT);
> > > > +}
> > > > +
> > > > +int mt7531_mdio_read(struct udevice *dev, int addr, int devad,
> > > > int
> > > > reg)
> > > > +{
> > > > +     struct mt7531_mdio_priv *priv = dev_get_priv(dev);
> > > > +     u32 val;
> > > > +
> > > > +     if (devad != MDIO_DEVAD_NONE) {
> > > > +             if (mt7531_mdio_wait_busy(priv))
> > > > +                     return -ETIMEDOUT;
> > > > +
> > > > +             val = MT7531_PHY_ACS_ST |
> > > > +                   MT7531_MDIO_ST_CL45 | MT7531_MDIO_CMD_ADDR
> > > > |
> > > > +                   FIELD_PREP(MT7531_MDIO_PHY_ADDR, addr) |
> > > > +                   FIELD_PREP(MT7531_MDIO_DEV_ADDR, devad) |
> > > > +                   FIELD_PREP(MT7531_MDIO_REG_ADDR_CL45, reg);
> > > > +
> > > > +             writel(val, priv->switch_regs + MT7531_PHY_IAC);
> > > > +     }
> > > > +
> > > > +     if (mt7531_mdio_wait_busy(priv))
> > > > +             return -ETIMEDOUT;
> > > > +
> > > > +     val = MT7531_PHY_ACS_ST |
> > > > FIELD_PREP(MT7531_MDIO_PHY_ADDR,
> > > > addr);
> > > > +     if (devad != MDIO_DEVAD_NONE)
> > > > +             val |= MT7531_MDIO_ST_CL45 |
> > > > MT7531_MDIO_CMD_READ_CL45 |
> > > > +                    FIELD_PREP(MT7531_MDIO_DEV_ADDR, devad);
> > > > +     else
> > > > +             val |= MT7531_MDIO_ST_CL22 |
> > > > MT7531_MDIO_CMD_READ_CL22 |
> > > > +                    FIELD_PREP(MT7531_MDIO_REG_ADDR_CL22,
> > > > reg);
> > > > +
> > > > +     writel(val, priv->switch_regs + MT7531_PHY_IAC);
> > > > +
> > > > +     if (mt7531_mdio_wait_busy(priv))
> > > > +             return -ETIMEDOUT;
> > > > +
> > > > +     val = readl(priv->switch_regs + MT7531_PHY_IAC);
> > > > +     return val & MT7531_MDIO_RW_DATA;
> > > > +}
> > > > +
> > > > +int mt7531_mdio_write(struct udevice *dev, int addr, int
> > > > devad,
> > > > +                   int reg, u16 value)
> > > > +{
> > > > +     struct mt7531_mdio_priv *priv = dev_get_priv(dev);
> > > > +     u32 val;
> > > > +
> > > > +     if (devad != MDIO_DEVAD_NONE) {
> > > > +             if (mt7531_mdio_wait_busy(priv))
> > > > +                     return -ETIMEDOUT;
> > > > +
> > > > +             val = MT7531_PHY_ACS_ST |
> > > > +                   MT7531_MDIO_ST_CL45 | MT7531_MDIO_CMD_ADDR
> > > > |
> > > > +                   FIELD_PREP(MT7531_MDIO_PHY_ADDR, addr) |
> > > > +                   FIELD_PREP(MT7531_MDIO_DEV_ADDR, devad) |
> > > > +                   FIELD_PREP(MT7531_MDIO_REG_ADDR_CL45, reg);
> > > > +
> > > > +             writel(val, priv->switch_regs + MT7531_PHY_IAC);
> > > > +     }
> > > > +
> > > > +     if (mt7531_mdio_wait_busy(priv))
> > > > +             return -ETIMEDOUT;
> > > > +
> > > > +     val = MT7531_PHY_ACS_ST |
> > > > FIELD_PREP(MT7531_MDIO_PHY_ADDR,
> > > > addr) |
> > > > +           MT7531_MDIO_CMD_WRITE |
> > > > FIELD_PREP(MT7531_MDIO_RW_DATA,
> > > > value);
> > > > +     if (devad != MDIO_DEVAD_NONE)
> > > > +             val |= MT7531_MDIO_ST_CL45 |
> > > > +                    FIELD_PREP(MT7531_MDIO_DEV_ADDR, devad);
> > > > +     else
> > > > +             val |= MT7531_MDIO_ST_CL22 |
> > > > +                    FIELD_PREP(MT7531_MDIO_REG_ADDR_CL22,
> > > > reg);
> > > > +
> > > > +     writel(val, priv->switch_regs + MT7531_PHY_IAC);
> > > > +
> > > > +     if (mt7531_mdio_wait_busy(priv))
> > > > +             return -ETIMEDOUT;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct mdio_ops mt7531_mdio_ops = {
> > > > +     .read = mt7531_mdio_read,
> > > > +     .write = mt7531_mdio_write,
> > > > +};
> > > > +
> > > > +static int mt7531_mdio_probe(struct udevice *dev)
> > > > +{
> > > > +     struct mt7531_mdio_priv *priv = dev_get_priv(dev);
> > > > +
> > > > +     priv->switch_regs = dev_read_addr(dev);
> > > > +     if (priv->switch_regs == FDT_ADDR_T_NONE)
> > > > +             return -EINVAL;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +U_BOOT_DRIVER(mt7531_mdio) = {
> > > > +     .name           = "mt7531-mdio",
> > > > +     .id             = UCLASS_MDIO,
> > > > +     .probe          = mt7531_mdio_probe,
> > > > +     .ops            = &mt7531_mdio_ops,
> > > > +     .priv_auto        = sizeof(struct mt7531_mdio_priv),
> > > > +};
> > > > diff --git a/drivers/net/mdio-mt7531.h b/drivers/net/mdio-
> > > > mt7531.h
> > > > new file mode 100644
> > > > index 00000000000..ee096112f92
> > > > --- /dev/null
> > > > +++ b/drivers/net/mdio-mt7531.h
> > > > @@ -0,0 +1,9 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +
> > > > +struct mt7531_mdio_priv {
> > > > +     phys_addr_t switch_regs;
> > > > +};
> > > > +
> > > > +int mt7531_mdio_read(struct udevice *dev, int addr, int devad,
> > > > int
> > > > reg);
> > > > +int mt7531_mdio_write(struct udevice *dev, int addr, int
> > > > devad,
> > > > +                   int reg, u16 value);
> > > > diff --git a/drivers/net/mtk_eth/Kconfig
> > > > b/drivers/net/mtk_eth/Kconfig
> > > > index e8cdf408237..67b2b612b1a 100644
> > > > --- a/drivers/net/mtk_eth/Kconfig
> > > > +++ b/drivers/net/mtk_eth/Kconfig
> > > > @@ -4,6 +4,7 @@ config MEDIATEK_ETH
> > > >       select PHYLIB
> > > >       select DM_GPIO
> > > >       select DM_RESET
> > > > +     select MDIO_MT7531
> > > >       help
> > > >         This Driver support MediaTek Ethernet GMAC
> > > >         Say Y to enable support for the MediaTek Ethernet GMAC.
> > > > diff --git a/drivers/net/mtk_eth/mt753x.c
> > > > b/drivers/net/mtk_eth/mt753x.c
> > > > index cdd52f3ff1b..cf643f336d6 100644
> > > > --- a/drivers/net/mtk_eth/mt753x.c
> > > > +++ b/drivers/net/mtk_eth/mt753x.c
> > > > @@ -138,8 +138,8 @@ int mt7531_mii_read(struct
> > > > mt753x_switch_priv
> > > > *priv, u8 phy, u8 reg)
> > > > 
> > > >       phy_addr = MT753X_PHY_ADDR(priv->phy_base, phy);
> > > > 
> > > > -     return mt7531_mii_rw(priv, phy_addr, reg, 0,
> > > > MDIO_CMD_READ,
> > > > -                          MDIO_ST_C22);
> > > > +     return mt7531_mdio_read(&priv->mdio_priv, phy_addr,
> > > > MDIO_DEVAD_NONE,
> > > > +                             reg);
> > > >  }
> > > > 
> > > >  int mt7531_mii_write(struct mt753x_switch_priv *priv, u8 phy,
> > > > u8
> > > > reg, u16 val)
> > > > @@ -151,48 +151,36 @@ int mt7531_mii_write(struct
> > > > mt753x_switch_priv *priv, u8 phy, u8 reg, u16 val)
> > > > 
> > > >       phy_addr = MT753X_PHY_ADDR(priv->phy_base, phy);
> > > > 
> > > > -     return mt7531_mii_rw(priv, phy_addr, reg, val,
> > > > MDIO_CMD_WRITE,
> > > > -                          MDIO_ST_C22);
> > > > +     return mt7531_mdio_write(&priv->mdio_priv, phy_addr,
> > > > MDIO_DEVAD_NONE,
> > > > +                              reg, val);
> > > >  }
> > > > 
> > > >  int mt7531_mmd_read(struct mt753x_switch_priv *priv, u8 addr,
> > > > u8
> > > > devad,
> > > >                   u16 reg)
> > > >  {
> > > >       u8 phy_addr;
> > > > -     int ret;
> > > > 
> > > >       if (addr >= MT753X_NUM_PHYS)
> > > >               return -EINVAL;
> > > > 
> > > >       phy_addr = MT753X_PHY_ADDR(priv->phy_base, addr);
> > > > 
> > > > -     ret = mt7531_mii_rw(priv, phy_addr, devad, reg,
> > > > MDIO_CMD_ADDR,
> > > > -                         MDIO_ST_C45);
> > > > -     if (ret)
> > > > -             return ret;
> > > > -
> > > > -     return mt7531_mii_rw(priv, phy_addr, devad, 0,
> > > > MDIO_CMD_READ_C45,
> > > > -                          MDIO_ST_C45);
> > > > +     return mt7531_mdio_read(&priv->mdio_priv, phy_addr,
> > > > devad,
> > > > +                             reg);
> > > >  }
> > > > 
> > > >  int mt7531_mmd_write(struct mt753x_switch_priv *priv, u8 addr,
> > > > u8
> > > > devad,
> > > >                    u16 reg, u16 val)
> > > >  {
> > > >       u8 phy_addr;
> > > > -     int ret;
> > > > 
> > > >       if (addr >= MT753X_NUM_PHYS)
> > > >               return 0;
> > > > 
> > > >       phy_addr = MT753X_PHY_ADDR(priv->phy_base, addr);
> > > > 
> > > > -     ret = mt7531_mii_rw(priv, phy_addr, devad, reg,
> > > > MDIO_CMD_ADDR,
> > > > -                         MDIO_ST_C45);
> > > > -     if (ret)
> > > > -             return ret;
> > > > -
> > > > -     return mt7531_mii_rw(priv, phy_addr, devad, val,
> > > > MDIO_CMD_WRITE,
> > > > -                          MDIO_ST_C45);
> > > > +     return mt7531_mdio_write(&priv->mdio_priv, phy_addr,
> > > > devad,
> > > > +                              reg, val);
> > > >  }
> > > > 
> > > >  static int mt7531_mdio_read(struct mii_dev *bus, int addr, int
> > > > devad, int reg)
> > > > @@ -224,6 +212,7 @@ int mt7531_mdio_register(struct
> > > > mt753x_switch_priv *priv)
> > > >       if (!mdio_bus)
> > > >               return -ENOMEM;
> > > > 
> > > > +     priv->mdio_priv.switch_regs = priv->epriv.ethsys_base +
> > > > GSW_BASE;
> > 
> > This will break all other platforms using dedicated MT7531 IC.
> > 
> > Only mt7988 uses built-in mt7531 which allows memory-mapped
> > register
> > access. Other platforms connects mt7531 through MDIO bus and only
> > supports accessing registers with MDIO.
> > 
> > You should either change only mt7988 to use this logic, or modify
> > the
> > mdio-mt7531 to accept MDIO-based access.
> > 
> 
> Thanks for the feedback.
> 
> I can rework the MDIO driver to regmap and use that or limit it only
> to
> mt7988. What do you prefer?
> 
> I think limiting to mt7988 is easier?
> 

Agree. Better only for mt7988.

> > > >       mdio_bus->read = mt7531_mdio_read;
> > > >       mdio_bus->write = mt7531_mdio_write;
> > > >       snprintf(mdio_bus->name, sizeof(mdio_bus->name), priv-
> > > > > epriv.sw->name);
> > > > 
> > > > diff --git a/drivers/net/mtk_eth/mt753x.h
> > > > b/drivers/net/mtk_eth/mt753x.h
> > > > index 65046a1421c..cd128ad39fe 100644
> > > > --- a/drivers/net/mtk_eth/mt753x.h
> > > > +++ b/drivers/net/mtk_eth/mt753x.h
> > > > @@ -14,6 +14,8 @@
> > > >  #include <linux/bitops.h>
> > > >  #include <linux/bitfield.h>
> > > > 
> > > > +#include "../mdio-mt7531.h"
> > > > +
> > > >  struct mtk_eth_priv;
> > > > 
> > > >  #define MT753X_NUM_PHYS              5
> > > > @@ -254,6 +256,7 @@ struct mtk_eth_priv;
> > > > 
> > > >  struct mt753x_switch_priv {
> > > >       struct mtk_eth_switch_priv epriv;
> > > > +     struct mt7531_mdio_priv mdio_priv;
> > > >       struct mii_dev *mdio_bus;
> > > >       u32 smi_addr;
> > > >       u32 phy_base;
> > > > --
> > > > 2.50.0
> > > > 
> > > 
> > > --
> > >         Ansuel
> 
> --
>         Ansuel

