Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62047C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 07:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A804C87EEE;
	Wed, 28 Feb 2024 08:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UFaWbwf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9432B8804B; Wed, 28 Feb 2024 08:01:12 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C127488023
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 08:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4726608233fso147866137.2
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 23:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709103666; x=1709708466; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ez+YKWcf3hKNewPhqmnfYD9thFTcCKWpfWv+6ITJJXY=;
 b=UFaWbwf1FgYZOoPi2jvsBwrzWETjC/AUUXDCELTuiOjbdR7KJQoFxztEoP6Bowhh7w
 Xp33/amDpIBwN5aJ/NVDoqBF9AA8GFDw8BFolyE1eW+dA69iTBZEoUrJY3FSeQf+z0fH
 qYb6AlLJtRNdw60WzqDDbMWm92/1QXaB23+uUou175+aBVBOcYhyUoYtjoweV+m7uMDj
 Bld1gIBq9Lm7TfGqu6L8AsJplq/31o5+vSHyZRxO7SL4DXuIQwBdvZmVV/+vBeyKRnko
 17Y4ssnw28mWgDQEMRbdk7kkmXThatHmJDGqd8HPI6pqbdi1vbn/YDBtc9u80pOkMQ49
 rxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709103666; x=1709708466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ez+YKWcf3hKNewPhqmnfYD9thFTcCKWpfWv+6ITJJXY=;
 b=liCRK/vt5KYPwdSIaVr2f4lEu822vnqi4Qtjkypat3+psJ8o0TjdCAkHKqLHtli/XV
 XreZaXJ9s4TpMIvrMTXF5XEJGyRzW0oRCUF3HOXl19iA0oDvNdVdAE+9/bdi48JY1atT
 27LOw+zZ9Cg/AG0MB2WABGx53f3iUO16q0igx1o64EuJV2rVRla/Jh4r6zfqPj+hStc7
 zwgOCfdphoFhhE8NAyviCYT8s2xxq+VqPDORBmXtxOkrDdcPne3jJaE2TPUsYQ0Y7UiE
 UvSOjuHJw5fusdUuVAM4nCae6mgAsofHosK4XET4LpSlk1tAnSBuCgbqidcpEZ18Z8VW
 yowQ==
X-Gm-Message-State: AOJu0YzLJsWxjhhuEWi1cX/79lLaZnXOYZv9YWw6DhfsP+nbFQ9E91dg
 Mp5Ja8JHnB10L+5cVPK8+dd8roKoaHIXRYmYl5/Z2kvF1wonGK0Z6BeRPZb0pR4FAeuNiVda4v2
 gdVxRAWmPzuJRkY3PugDLJYI6ddWj285KZDqq0w==
X-Google-Smtp-Source: AGHT+IHSQRuZ3T0TDwtBKSg9Zq8ofNV8RQyfMppiqk9m06swtqRlRemECWyJIGNkTJCPOQtQKNsPUv+hbI7Q0eDCcG4=
X-Received: by 2002:a05:6102:19c5:b0:470:42ce:8eab with SMTP id
 jn5-20020a05610219c500b0047042ce8eabmr8429533vsb.21.1709103665757; Tue, 27
 Feb 2024 23:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-7-sumit.garg@linaro.org>
 <CAHCN7xLBk4KnNMx3ofaHxb+KJOUA9Y4Sh+drpAymg3=F8gdA1w@mail.gmail.com>
In-Reply-To: <CAHCN7xLBk4KnNMx3ofaHxb+KJOUA9Y4Sh+drpAymg3=F8gdA1w@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 28 Feb 2024 12:30:54 +0530
Message-ID: <CAFA6WYNdP5aV4P50S1hNPXRwEOfCywPn39wiMYW3Ow=cyE+8gw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] pci: Add DW PCIe controller support for iMX8MP SoC
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, marex@denx.de, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 28 Feb 2024 at 04:44, Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
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
> >  drivers/pci/Kconfig       |   8 +
> >  drivers/pci/Makefile      |   1 +
> >  drivers/pci/pcie_dw_imx.c | 314 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 323 insertions(+)
> >  create mode 100644 drivers/pci/pcie_dw_imx.c
> >
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 463ec47eb92d..7edbf35004a9 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -413,4 +413,12 @@ config PCIE_STARFIVE_JH7110
> >           Say Y here if you want to enable PLDA XpressRich PCIe control=
ler
> >           support on StarFive JH7110 SoC.
> >
> > +config PCIE_DW_IMX
> > +       bool "i.MX DW PCIe controller support"
> > +       depends on ARCH_IMX8M
>
> I think this also needs to depend on REGMAP to prevent build errors.
>

Ack, I will add that.

-Sumit

>
> adam
>
> > +       select PCIE_DW_COMMON
> > +       help
> > +         Say Y here if you want to enable DW PCIe controller support o=
n
> > +         iMX SoCs.
> > +
> >  endif
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index 72ef8b4bc772..2927c519129b 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -53,3 +53,4 @@ obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie_uniphier.o
> >  obj-$(CONFIG_PCIE_XILINX_NWL) +=3D pcie-xilinx-nwl.o
> >  obj-$(CONFIG_PCIE_PLDA_COMMON) +=3D pcie_plda_common.o
> >  obj-$(CONFIG_PCIE_STARFIVE_JH7110) +=3D pcie_starfive_jh7110.o
> > +obj-$(CONFIG_PCIE_DW_IMX) +=3D pcie_dw_imx.o
> > diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
> > new file mode 100644
> > index 000000000000..7856823c9188
> > --- /dev/null
> > +++ b/drivers/pci/pcie_dw_imx.c
> > @@ -0,0 +1,314 @@
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
> > +#include <linux/iopoll.h>
> > +#include <log.h>
> > +#include <pci.h>
> > +#include <regmap.h>
> > +#include <reset.h>
> > +#include <syscon.h>
> > +#include <time.h>
> > +
> > +#include "pcie_dw_common.h"
> > +
> > +#define PCIE_LINK_CAPABILITY           0x7c
> > +#define TARGET_LINK_SPEED_MASK         0xf
> > +#define LINK_SPEED_GEN_1               0x1
> > +#define LINK_SPEED_GEN_2               0x2
> > +#define LINK_SPEED_GEN_3               0x3
> > +
> > +#define PCIE_MISC_CONTROL_1_OFF                0x8bc
> > +#define PCIE_DBI_RO_WR_EN              BIT(0)
> > +
> > +#define PCIE_PORT_DEBUG0                       0x728
> > +#define PCIE_PORT_DEBUG1                       0x72c
> > +#define PCIE_PORT_DEBUG1_LINK_UP               BIT(4)
> > +#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING      BIT(29)
> > +
> > +#define PCIE_LINK_UP_TIMEOUT_MS                100
> > +
> > +#define IOMUXC_GPR14_OFFSET                    0x38
> > +#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN     BIT(10)
> > +#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE                BIT(11)
> > +
> > +struct pcie_dw_imx {
> > +       /* Must be first member of the struct */
> > +       struct pcie_dw                  dw;
> > +       struct regmap                   *iomuxc_gpr;
> > +       struct clk_bulk                 clks;
> > +       struct gpio_desc                reset_gpio;
> > +       struct reset_ctl                apps_reset;
> > +       struct phy                      phy;
> > +};
> > +
> > +static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed)
> > +{
> > +       dw_pcie_dbi_write_enable(&priv->dw, true);
> > +
> > +       clrsetbits_le32(priv->dw.dbi_base + PCIE_LINK_CAPABILITY,
> > +                       TARGET_LINK_SPEED_MASK, cap_speed);
> > +
> > +       dw_pcie_dbi_write_enable(&priv->dw, false);
> > +}
> > +
> > +static void imx_pcie_ltssm_enable(struct pcie_dw_imx *priv)
> > +{
> > +       reset_deassert(&priv->apps_reset);
> > +}
> > +
> > +static void imx_pcie_ltssm_disable(struct pcie_dw_imx *priv)
> > +{
> > +       reset_assert(&priv->apps_reset);
> > +}
> > +
> > +static bool is_link_up(u32 val)
> > +{
> > +       return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
> > +               (!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
> > +}
> > +
> > +static int wait_link_up(struct pcie_dw_imx *priv)
> > +{
> > +       u32 val;
> > +
> > +       return readl_poll_sleep_timeout(priv->dw.dbi_base + PCIE_PORT_D=
EBUG1,
> > +                                       val, is_link_up(val), 10000, 10=
0000);
> > +}
> > +
> > +static int pcie_link_up(struct pcie_dw_imx *priv, u32 cap_speed)
> > +{
> > +       int ret;
> > +
> > +       /* DW pre link configurations */
> > +       pcie_dw_configure(priv, cap_speed);
> > +
> > +       /* Initiate link training */
> > +       imx_pcie_ltssm_enable(priv);
> > +
> > +       /* Check that link was established */
> > +       ret =3D wait_link_up(priv);
> > +       if (ret)
> > +               imx_pcie_ltssm_disable(priv);
> > +
> > +       return ret;
> > +}
> > +
> > +static int imx_pcie_assert_core_reset(struct pcie_dw_imx *priv)
> > +{
> > +       if (dm_gpio_is_valid(&priv->reset_gpio)) {
> > +               dm_gpio_set_value(&priv->reset_gpio, 1);
> > +               mdelay(20);
> > +       }
> > +
> > +       return reset_assert(&priv->apps_reset);
> > +}
> > +
> > +static int imx_pcie_clk_enable(struct pcie_dw_imx *priv)
> > +{
> > +       int ret;
> > +
> > +       ret =3D clk_enable_bulk(&priv->clks);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /*
> > +        * Set the over ride low and enabled make sure that
> > +        * REF_CLK is turned on.
> > +        */
> > +       regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> > +                          IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE, 0);
> > +       regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> > +                          IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> > +                          IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> > +
> > +       /* allow the clocks to stabilize */
> > +       udelay(500);
> > +
> > +       return 0;
> > +}
> > +
> > +static void imx_pcie_deassert_core_reset(struct pcie_dw_imx *priv)
> > +{
> > +       if (!dm_gpio_is_valid(&priv->reset_gpio))
> > +               return;
> > +
> > +       mdelay(100);
> > +       dm_gpio_set_value(&priv->reset_gpio, 0);
> > +       /* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) *=
/
> > +       mdelay(100);
> > +}
> > +
> > +static int pcie_dw_imx_probe(struct udevice *dev)
> > +{
> > +       struct pcie_dw_imx *priv =3D dev_get_priv(dev);
> > +       struct udevice *ctlr =3D pci_get_controller(dev);
> > +       struct pci_controller *hose =3D dev_get_uclass_priv(ctlr);
> > +       int ret;
> > +
> > +       ret =3D imx_pcie_assert_core_reset(priv);
> > +       if (ret) {
> > +               dev_err(dev, "failed to assert core reset\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D imx_pcie_clk_enable(priv);
> > +       if (ret) {
> > +               dev_err(dev, "failed to enable clocks\n");
> > +               goto err_clk;
> > +       }
> > +
> > +       ret =3D generic_phy_init(&priv->phy);
> > +       if (ret) {
> > +               dev_err(dev, "failed to initialize PHY\n");
> > +               goto err_phy_init;
> > +       }
> > +
> > +       ret =3D generic_phy_power_on(&priv->phy);
> > +       if (ret) {
> > +               dev_err(dev, "failed to power on PHY\n");
> > +               goto err_phy_power;
> > +       }
> > +
> > +       imx_pcie_deassert_core_reset(priv);
> > +
> > +       priv->dw.first_busno =3D dev_seq(dev);
> > +       priv->dw.dev =3D dev;
> > +       pcie_dw_setup_host(&priv->dw);
> > +
> > +       if (pcie_link_up(priv, LINK_SPEED_GEN_1)) {
> > +               printf("PCIE-%d: Link down\n", dev_seq(dev));
> > +               ret =3D -ENODEV;
> > +               goto err_link;
> > +       }
> > +
> > +       printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
> > +              pcie_dw_get_link_speed(&priv->dw),
> > +              pcie_dw_get_link_width(&priv->dw),
> > +              hose->first_busno);
> > +
> > +       pcie_dw_prog_outbound_atu_unroll(&priv->dw, PCIE_ATU_REGION_IND=
EX0,
> > +                                        PCIE_ATU_TYPE_MEM,
> > +                                        priv->dw.mem.phys_start,
> > +                                        priv->dw.mem.bus_start, priv->=
dw.mem.size);
> > +
> > +       return 0;
> > +
> > +err_link:
> > +       generic_shutdown_phy(&priv->phy);
> > +err_phy_power:
> > +       generic_phy_exit(&priv->phy);
> > +err_phy_init:
> > +       clk_disable_bulk(&priv->clks);
> > +err_clk:
> > +       imx_pcie_deassert_core_reset(priv);
> > +
> > +       return ret;
> > +}
> > +
> > +static int pcie_dw_imx_remove(struct udevice *dev)
> > +{
> > +       struct pcie_dw_imx *priv =3D dev_get_priv(dev);
> > +
> > +       generic_shutdown_phy(&priv->phy);
> > +       dm_gpio_free(dev, &priv->reset_gpio);
> > +       reset_release_all(&priv->apps_reset, 1);
> > +       clk_release_bulk(&priv->clks);
> > +
> > +       return 0;
> > +}
> > +
> > +static int pcie_dw_imx_of_to_plat(struct udevice *dev)
> > +{
> > +       struct pcie_dw_imx *priv =3D dev_get_priv(dev);
> > +       ofnode gpr;
> > +       int ret;
> > +
> > +       /* Get the controller base address */
> > +       priv->dw.dbi_base =3D (void *)dev_read_addr_name(dev, "dbi");
> > +       if ((fdt_addr_t)priv->dw.dbi_base =3D=3D FDT_ADDR_T_NONE) {
> > +               dev_err(dev, "failed to get dbi_base address\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Get the config space base address and size */
> > +       priv->dw.cfg_base =3D (void *)dev_read_addr_size_name(dev, "con=
fig",
> > +                                                           &priv->dw.c=
fg_size);
> > +       if ((fdt_addr_t)priv->dw.cfg_base =3D=3D FDT_ADDR_T_NONE) {
> > +               dev_err(dev, "failed to get cfg_base address\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret =3D clk_get_bulk(dev, &priv->clks);
> > +       if (ret) {
> > +               dev_err(dev, "failed to get PCIe clks\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D reset_get_by_name(dev, "apps", &priv->apps_reset);
> > +       if (ret) {
> > +               dev_err(dev,
> > +                       "Failed to get PCIe apps reset control\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset=
_gpio,
> > +                                  (GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE)=
);
> > +       if (ret) {
> > +               dev_err(dev, "unable to get reset-gpio\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
> > +       if (ret) {
> > +               dev_err(dev, "failed to get pcie phy\n");
> > +               return ret;
> > +       }
> > +
> > +       gpr =3D ofnode_by_compatible(ofnode_null(), "fsl,imx8mp-iomuxc-=
gpr");
> > +       if (ofnode_equal(gpr, ofnode_null())) {
> > +               dev_err(dev, "unable to find GPR node\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       priv->iomuxc_gpr =3D syscon_node_to_regmap(gpr);
> > +       if (IS_ERR(priv->iomuxc_gpr)) {
> > +               dev_err(dev, "unable to find iomuxc registers\n");
> > +               return PTR_ERR(priv->iomuxc_gpr);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct dm_pci_ops pcie_dw_imx_ops =3D {
> > +       .read_config    =3D pcie_dw_read_config,
> > +       .write_config   =3D pcie_dw_write_config,
> > +};
> > +
> > +static const struct udevice_id pcie_dw_imx_ids[] =3D {
> > +       { .compatible =3D "fsl,imx8mp-pcie" },
> > +       { }
> > +};
> > +
> > +U_BOOT_DRIVER(pcie_dw_imx) =3D {
> > +       .name           =3D "pcie_dw_imx",
> > +       .id             =3D UCLASS_PCI,
> > +       .of_match       =3D pcie_dw_imx_ids,
> > +       .ops            =3D &pcie_dw_imx_ops,
> > +       .of_to_plat     =3D pcie_dw_imx_of_to_plat,
> > +       .probe          =3D pcie_dw_imx_probe,
> > +       .remove         =3D pcie_dw_imx_remove,
> > +       .priv_auto      =3D sizeof(struct pcie_dw_imx),
> > +};
> > --
> > 2.34.1
> >
