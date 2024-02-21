Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B351C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 06:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFE187E49;
	Wed, 21 Feb 2024 07:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CR8E5Tfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90AD687DD4; Wed, 21 Feb 2024 07:25:40 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E0B87F76
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4703e4d53b6so2027530137.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 22:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708496727; x=1709101527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3E+510tKm2yPnyu5FEbqzdfreQFMTWMalT1iqWH3ylI=;
 b=CR8E5TfwcPBVzd3dRHYKa8tS7U/5tgN0n4SekCSWdTIsqrGbUf0AmJjSnfeT4y3uIj
 uahrRDQJ/PK1V9wt6z8IakM6ZPrmVvUaoIzlIU/ME0QHKTU2Z9GJ3yZklUJOZRYz7+bI
 k4WjnK3cakLWCoDd+iqWz6A3glg3bt/n/bbwXOH5UM3ahKjsUBNKwg2HW5ET3kj/4Vfk
 6BqPkO0MPMuaByNHBIciDUtW2rzPtk0tkTd+ZJdOA8lj70Z/keVtFnM2WCPS064ngV3t
 OTxn+8CWDENV7f6F2Ybh1at/NdKlsTAQbNheT7ZwR9t0RUiibSbjf1i8EtNvzvhp+Tnl
 VDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708496727; x=1709101527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3E+510tKm2yPnyu5FEbqzdfreQFMTWMalT1iqWH3ylI=;
 b=OUrrPVWr/lA79q0t/igqNTNezs+8W3YrU5OSZlorwIYKN/EoeTlCdfyyRRbxc9VrCF
 LbAefYjAQQeX3w0XwAasUTFVzDVqckCvNNnIEu/enAkuxsnAop2fVSV6NyuLl4YH8ZNR
 24zawhM4Ha+7h8+SiahlvJeY5fIm8i6/DIW5elF6ePdy3HRIHypQjWwlhlMG2i2fiLt9
 4c8DCdkoUfr1jupUaaCqF+5FGcFVRWXuSpU7SC5m6uuZbDri50J8l2wJIZZ2Tm1W5nOf
 4I479ZRi8tPxkbcVm8CrEgRZdtcSaf4k0Pv2JJF95+9Y5KRWK4mpccZY7z9Okz9iY+fc
 Hfhg==
X-Gm-Message-State: AOJu0YwoQ997Mh2bvtWecrQrOQ1b8j2PXulwgtq4nYsyMX7Fngfr2aQs
 3GGwAOC3ssRCBc0ByT9csTsekdYzONIwtgKIcEJ0MpfhY9/6YsIj6PgEh6YHz7THcfKnO+eFRdl
 xml+pIcc8KlSOBiGYF84L3KA3obHLge/Lnhh3bg==
X-Google-Smtp-Source: AGHT+IG29aAdycZUFGC645ATqWMpZ6rvSmUQJUZTd6Wa+eK0YDTijF88sMk3EGfpFpk/DmugekXO29d0A3H55itFyUI=
X-Received: by 2002:a67:fa56:0:b0:470:3fe3:8189 with SMTP id
 j22-20020a67fa56000000b004703fe38189mr7726702vsq.3.1708496727057; Tue, 20 Feb
 2024 22:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-7-sumit.garg@linaro.org>
 <61361608-8b4f-4ebb-b7dd-260d08ac5e8b@denx.de>
In-Reply-To: <61361608-8b4f-4ebb-b7dd-260d08ac5e8b@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 11:55:16 +0530
Message-ID: <CAFA6WYMoNRKVvzS+6gwXp4gwQXHKZoWA73fcPEy16Qy=qzgy2w@mail.gmail.com>
Subject: Re: [PATCH 6/7] pci: Add DW PCIe controller support for iMX8MP SoC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com, 
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>
> On 2/20/24 14:10, Sumit Garg wrote:
> > pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
> > tied to quite old port of pcie_designware driver from Linux which
> > suffices only iMX6 specific needs.
> >
> > But currently we have the common DWC specific bits which alligns pretty
> > well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> > bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> > add support for other iMX8 variants to this driver.
> >
> > iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> > can reuse the generic PHY infrastructure to power on PCIe PHY.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   drivers/pci/Kconfig        |   8 +
> >   drivers/pci/Makefile       |   1 +
> >   drivers/pci/pcie_dw_imx8.c | 348 +++++++++++++++++++++++++++++++++++++
> >   3 files changed, 357 insertions(+)
> >   create mode 100644 drivers/pci/pcie_dw_imx8.c
> >
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 463ec47eb92..b7c7922b091 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -413,4 +413,12 @@ config PCIE_STARFIVE_JH7110
> >         Say Y here if you want to enable PLDA XpressRich PCIe controller
> >         support on StarFive JH7110 SoC.
> >
> > +config PCIE_DW_IMX8
> > +     bool "i.MX8 PCIe support"
> > +     depends on ARCH_IMX8M
> > +     select PCIE_DW_COMMON
> > +     help
> > +       Say Y here if you want to enable DW PCIe controller support on
> > +       iMX8 SoCs.
> > +
> >   endif
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index 72ef8b4bc77..cddbb902095 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -53,3 +53,4 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie_uniphier.o
> >   obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
> >   obj-$(CONFIG_PCIE_PLDA_COMMON) += pcie_plda_common.o
> >   obj-$(CONFIG_PCIE_STARFIVE_JH7110) += pcie_starfive_jh7110.o
> > +obj-$(CONFIG_PCIE_DW_IMX8) += pcie_dw_imx8.o
> > diff --git a/drivers/pci/pcie_dw_imx8.c b/drivers/pci/pcie_dw_imx8.c
> > new file mode 100644
> > index 00000000000..b9921644765
> > --- /dev/null
> > +++ b/drivers/pci/pcie_dw_imx8.c
> > @@ -0,0 +1,348 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2024 Linaro Ltd.
> > + *
> > + * Author: Sumit Garg <sumit.garg@linaro.org>
> > + */
> > +
> > +#include <asm/io.h>
> > +#include <asm-generic/gpio.h>
> > +#include <clk.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <generic-phy.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <log.h>
> > +#include <pci.h>
> > +#include <regmap.h>
> > +#include <reset.h>
> > +#include <syscon.h>
> > +#include <time.h>
> > +
> > +#include "pcie_dw_common.h"
> > +
> > +#define PCIE_LINK_CAPABILITY         0x7c
> > +#define TARGET_LINK_SPEED_MASK               0xf
> > +#define LINK_SPEED_GEN_1             0x1
> > +#define LINK_SPEED_GEN_2             0x2
> > +#define LINK_SPEED_GEN_3             0x3
> > +
> > +#define PCIE_MISC_CONTROL_1_OFF              0x8bc
> > +#define PCIE_DBI_RO_WR_EN            BIT(0)
> > +
> > +#define PCIE_PORT_DEBUG0                     0x728
> > +#define PCIE_PORT_DEBUG1                     0x72c
> > +#define PCIE_PORT_DEBUG1_LINK_UP             BIT(4)
> > +#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING    BIT(29)
> > +
> > +#define PCIE_LINK_UP_TIMEOUT_MS              100
> > +
> > +#define IOMUXC_GPR14_OFFSET                  0x38
> > +#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN   BIT(10)
> > +#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE              BIT(11)
> > +
> > +struct pcie_dw_imx8 {
> > +     /* Must be first member of the struct */
> > +     struct pcie_dw                  dw;
> > +     struct regmap                   *iomuxc_gpr;
> > +     struct clk                      pcie;
> > +     struct clk                      pcie_bus;
> > +     struct clk                      pcie_aux;
> > +     struct gpio_desc                reset_gpio;
> > +     struct reset_ctl                apps_reset;
> > +     struct phy                      phy;
> > +};
> > +
> > +static void pcie_dw_configure(struct pcie_dw_imx8 *priv, u32 cap_speed)
> > +{
> > +     u32 val;
> > +
> > +     dw_pcie_dbi_write_enable(&priv->dw, true);
> > +
> > +     val = readl(priv->dw.dbi_base + PCIE_LINK_CAPABILITY);
> > +     val &= ~TARGET_LINK_SPEED_MASK;
> > +     val |= cap_speed;
> > +     writel(val, priv->dw.dbi_base + PCIE_LINK_CAPABILITY);
>
> clrsetbits_le32()

Ack.

>
> > +
> > +     dw_pcie_dbi_write_enable(&priv->dw, false);
> > +}
> > +
> > +static void imx8_pcie_ltssm_enable(struct pcie_dw_imx8 *priv)
> > +{
> > +     reset_deassert(&priv->apps_reset);
> > +}
> > +
> > +static void imx8_pcie_ltssm_disable(struct pcie_dw_imx8 *priv)
> > +{
> > +     reset_assert(&priv->apps_reset);
> > +}
> > +
> > +static int is_link_up(struct pcie_dw_imx8 *priv)
> > +{
> > +     u32 val;
> > +
> > +     val = readl(priv->dw.dbi_base + PCIE_PORT_DEBUG1);
> > +
> > +     return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
> > +             (!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
> > +}
> > +
> > +static int wait_link_up(struct pcie_dw_imx8 *priv)
> > +{
> > +     unsigned long timeout;
> > +
> > +     timeout = get_timer(0) + PCIE_LINK_UP_TIMEOUT_MS;
>
> wait_for_bit() or read_poll_timeout()

They won't appropriately fit here as I would like to add delay in
between consecutive polls too...

>
> > +     while (!is_link_up(priv)) {
> > +             if (get_timer(0) > timeout)
> > +                     return 0;
> > +             mdelay(10);

...here.

> > +     };
> > +
> > +     return 1;
>
> return -ETIMEDOUT ?

Here 0 represents timeout and 1 represents success condition.

>
> > +}
> > +
> > +static int pcie_link_up(struct pcie_dw_imx8 *priv, u32 cap_speed)
> > +{
> > +     if (is_link_up(priv)) {
> > +             printf("PCI Link already up before configuration!\n");
> > +             return 1;
> > +     }
> > +
> > +     /* DW pre link configurations */
> > +     pcie_dw_configure(priv, cap_speed);
> > +
> > +     /* Initiate link training */
> > +     imx8_pcie_ltssm_enable(priv);
> > +
> > +     /* Check that link was established */
> > +     if (!wait_link_up(priv)) {
> > +             imx8_pcie_ltssm_disable(priv);
> > +             return 0;
> > +     }
> > +
> > +     return 1;
> > +}
> > +
> > +static int imx8_pcie_assert_core_reset(struct pcie_dw_imx8 *priv)
> > +{
> > +     if (dm_gpio_is_valid(&priv->reset_gpio)) {
> > +             dm_gpio_set_value(&priv->reset_gpio, 1);
> > +             mdelay(20);
> > +     }
> > +
> > +     return reset_assert(&priv->apps_reset);
> > +}
> > +
> > +static int imx8_pcie_clk_enable(struct pcie_dw_imx8 *priv)
> > +{
> > +     int ret;
> > +
> > +     ret = clk_enable(&priv->pcie);
>
> Can you use clk_bulk functions here ?
>

Sure, I can try to use them.

> [...]
>
> > +static int imx8_pcie_deassert_core_reset(struct pcie_dw_imx8 *priv)
> > +{
> > +     if (dm_gpio_is_valid(&priv->reset_gpio)) {
>
> Invert the match here and return early to reduce indent.

Ack.

>
> > +             mdelay(100);
> > +             dm_gpio_set_value(&priv->reset_gpio, 0);
> > +             /* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> > +             mdelay(100);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int pcie_dw_imx8_probe(struct udevice *dev)
> > +{
> > +     struct pcie_dw_imx8 *priv = dev_get_priv(dev);
> > +     struct udevice *ctlr = pci_get_controller(dev);
> > +     struct pci_controller *hose = dev_get_uclass_priv(ctlr);
> > +     int ret;
> > +
> > +     ret = imx8_pcie_assert_core_reset(priv);
> > +     if (ret) {
> > +             dev_err(dev, "failed to assert core reset\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = imx8_pcie_clk_enable(priv);
> > +     if (ret) {
> > +             dev_err(dev, "failed to enable clocks\n");
>
> This needs a fail path, else reset remains released on failure here .
>

Ack, I will add that.

-Sumit

> > +             return ret;
> > +     }
> > +
> > +     generic_phy_init(&priv->phy);
> > +     generic_phy_power_on(&priv->phy);
> > +
> > +     ret = imx8_pcie_deassert_core_reset(priv);
> > +     if (ret) {
> > +             dev_err(dev, "failed to assert core reset\n");
> > +             return ret;
> > +     }
> > +
> > +     priv->dw.first_busno = dev_seq(dev);
> > +     priv->dw.dev = dev;
> > +
> > +     pcie_dw_setup_host(&priv->dw);
> > +
> > +     if (!pcie_link_up(priv, LINK_SPEED_GEN_1)) {
> > +             printf("PCIE-%d: Link down\n", dev_seq(dev));
> > +             return -ENODEV;
> > +     }
> > +
> > +     printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
> > +            pcie_dw_get_link_speed(&priv->dw),
> > +            pcie_dw_get_link_width(&priv->dw),
> > +            hose->first_busno);
> > +
> > +     pcie_dw_prog_outbound_atu_unroll(&priv->dw, PCIE_ATU_REGION_INDEX0,
> > +                                      PCIE_ATU_TYPE_MEM,
> > +                                      priv->dw.mem.phys_start,
> > +                                      priv->dw.mem.bus_start, priv->dw.mem.size);
> > +
> > +     return 0;
> > +}
> > +
> > +static int pcie_dw_imx8_remove(struct udevice *dev)
> > +{
> > +     struct pcie_dw_imx8 *priv = dev_get_priv(dev);
> > +
> > +     imx8_pcie_assert_core_reset(priv);
> > +
> > +     return 0;
> > +}
>
> [...]
