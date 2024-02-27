Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADBBC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 23:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F528804E;
	Wed, 28 Feb 2024 00:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FxhSo1Vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1BA88031; Wed, 28 Feb 2024 00:19:45 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0AD287E8E
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 00:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so3323986b3a.2
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 15:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709075979; x=1709680779; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fiZizzmdUUXvFPKFChNiq3dql2SK1EXJEsIfHvgjSE=;
 b=FxhSo1VtgaqOjdTCM34x12enN17+HDbDzo4shos6eVUOhMZAenheltAElq20T1xNr5
 siunPcS9rnIs63dN5XhxMJHz2SVhsFQHZvSkoTsWHqIHQ8x6Hd8Rx+hvatumtYRZZzvd
 5EfOiLfN+me1QAteP9NSXbURD5q6O/el4izvt+SK38j5LmoYXQVmdBtxmdaLDT5lNy27
 83Zqekc3mwBdF1l8BpSX5MBOplLyjA1VoxkZuG4QOZ3R+eNS1y02TuhhhppKrVkA1d6T
 aIO3zdgkUsvGYuG2LblV5s0CzBXD6IjuRwMZvP3YtDId0DGCYXrrYpMRqef6N/5LavBj
 mRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709075979; x=1709680779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fiZizzmdUUXvFPKFChNiq3dql2SK1EXJEsIfHvgjSE=;
 b=v2IQkS1Hcq/Ykwb1yMfp3oP95553TbvKVl00AIOemgFWK6UBzz19BIp4iuOmPteNdB
 6gSYc0TFN1Fh4ugAy7zylpTkrGdEpoCQO518Jv6cFh73vVlgoz3C2rWewtOm6xyqacLR
 /CtAYkNxrIVheD7oeKlYjiHmTQlpHK4u/Z0Bwax2vzcMNss4AjUlF2f4FhtpkbBoNttl
 GH0YYUqEZDHpdsK81bWI8OUiWtOE0cYBIC1q6xMLgNEaBUA5TK/ye6I4qfQVphAwJOkR
 bvvQR2DK6WRoHhng3K5I8MJ+tGeWnNRHw/RPby7F7C10RPUvW45BaQEBfwrlJwlLEIbd
 YSFw==
X-Gm-Message-State: AOJu0YxAPRxaJ+DWLgFqf0z/OIX7bnsPsRHWiFXzyB2/xV3F9w5JuIDa
 j0Ib3k2zitnvtmh27YqDB9R0tPttOaI8bVKpTw7X1vtb6l97/lMsvKbaurjqL2f0f1o5bWo50FZ
 0h6ORyZrOCkCRMJvFrZGb/a/m9wbS0zeVRlbx3g==
X-Google-Smtp-Source: AGHT+IEDVGdmvO9Mm+v5BKExNk5WzLe4rLgN4/0Gnb7rVko77aLEO1sIWTCcBwyZac7psJWhw6eKle/uW4seqMwrGow=
X-Received: by 2002:a5b:84f:0:b0:dcd:3338:a3c5 with SMTP id
 v15-20020a5b084f000000b00dcd3338a3c5mr897835ybq.33.1709075647579; Tue, 27 Feb
 2024 15:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-7-sumit.garg@linaro.org>
In-Reply-To: <20240226080433.3307154-7-sumit.garg@linaro.org>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 27 Feb 2024 17:13:56 -0600
Message-ID: <CAHCN7xLBk4KnNMx3ofaHxb+KJOUA9Y4Sh+drpAymg3=F8gdA1w@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] pci: Add DW PCIe controller support for iMX8MP SoC
To: Sumit Garg <sumit.garg@linaro.org>
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

On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
> tied to quite old port of pcie_designware driver from Linux which
> suffices only iMX6 specific needs.
>
> But currently we have the common DWC specific bits which alligns pretty
> well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> add support for other iMX8 variants to this driver.
>
> iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> can reuse the generic PHY infrastructure to power on PCIe PHY.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/pci/Kconfig       |   8 +
>  drivers/pci/Makefile      |   1 +
>  drivers/pci/pcie_dw_imx.c | 314 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 323 insertions(+)
>  create mode 100644 drivers/pci/pcie_dw_imx.c
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 463ec47eb92d..7edbf35004a9 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -413,4 +413,12 @@ config PCIE_STARFIVE_JH7110
>           Say Y here if you want to enable PLDA XpressRich PCIe controlle=
r
>           support on StarFive JH7110 SoC.
>
> +config PCIE_DW_IMX
> +       bool "i.MX DW PCIe controller support"
> +       depends on ARCH_IMX8M

I think this also needs to depend on REGMAP to prevent build errors.


adam

> +       select PCIE_DW_COMMON
> +       help
> +         Say Y here if you want to enable DW PCIe controller support on
> +         iMX SoCs.
> +
>  endif
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 72ef8b4bc772..2927c519129b 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -53,3 +53,4 @@ obj-$(CONFIG_PCIE_UNIPHIER) +=3D pcie_uniphier.o
>  obj-$(CONFIG_PCIE_XILINX_NWL) +=3D pcie-xilinx-nwl.o
>  obj-$(CONFIG_PCIE_PLDA_COMMON) +=3D pcie_plda_common.o
>  obj-$(CONFIG_PCIE_STARFIVE_JH7110) +=3D pcie_starfive_jh7110.o
> +obj-$(CONFIG_PCIE_DW_IMX) +=3D pcie_dw_imx.o
> diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
> new file mode 100644
> index 000000000000..7856823c9188
> --- /dev/null
> +++ b/drivers/pci/pcie_dw_imx.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Linaro Ltd.
> + *
> + * Author: Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +#include <asm/io.h>
> +#include <asm-generic/gpio.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <generic-phy.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iopoll.h>
> +#include <log.h>
> +#include <pci.h>
> +#include <regmap.h>
> +#include <reset.h>
> +#include <syscon.h>
> +#include <time.h>
> +
> +#include "pcie_dw_common.h"
> +
> +#define PCIE_LINK_CAPABILITY           0x7c
> +#define TARGET_LINK_SPEED_MASK         0xf
> +#define LINK_SPEED_GEN_1               0x1
> +#define LINK_SPEED_GEN_2               0x2
> +#define LINK_SPEED_GEN_3               0x3
> +
> +#define PCIE_MISC_CONTROL_1_OFF                0x8bc
> +#define PCIE_DBI_RO_WR_EN              BIT(0)
> +
> +#define PCIE_PORT_DEBUG0                       0x728
> +#define PCIE_PORT_DEBUG1                       0x72c
> +#define PCIE_PORT_DEBUG1_LINK_UP               BIT(4)
> +#define PCIE_PORT_DEBUG1_LINK_IN_TRAINING      BIT(29)
> +
> +#define PCIE_LINK_UP_TIMEOUT_MS                100
> +
> +#define IOMUXC_GPR14_OFFSET                    0x38
> +#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN     BIT(10)
> +#define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE                BIT(11)
> +
> +struct pcie_dw_imx {
> +       /* Must be first member of the struct */
> +       struct pcie_dw                  dw;
> +       struct regmap                   *iomuxc_gpr;
> +       struct clk_bulk                 clks;
> +       struct gpio_desc                reset_gpio;
> +       struct reset_ctl                apps_reset;
> +       struct phy                      phy;
> +};
> +
> +static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed)
> +{
> +       dw_pcie_dbi_write_enable(&priv->dw, true);
> +
> +       clrsetbits_le32(priv->dw.dbi_base + PCIE_LINK_CAPABILITY,
> +                       TARGET_LINK_SPEED_MASK, cap_speed);
> +
> +       dw_pcie_dbi_write_enable(&priv->dw, false);
> +}
> +
> +static void imx_pcie_ltssm_enable(struct pcie_dw_imx *priv)
> +{
> +       reset_deassert(&priv->apps_reset);
> +}
> +
> +static void imx_pcie_ltssm_disable(struct pcie_dw_imx *priv)
> +{
> +       reset_assert(&priv->apps_reset);
> +}
> +
> +static bool is_link_up(u32 val)
> +{
> +       return ((val & PCIE_PORT_DEBUG1_LINK_UP) &&
> +               (!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
> +}
> +
> +static int wait_link_up(struct pcie_dw_imx *priv)
> +{
> +       u32 val;
> +
> +       return readl_poll_sleep_timeout(priv->dw.dbi_base + PCIE_PORT_DEB=
UG1,
> +                                       val, is_link_up(val), 10000, 1000=
00);
> +}
> +
> +static int pcie_link_up(struct pcie_dw_imx *priv, u32 cap_speed)
> +{
> +       int ret;
> +
> +       /* DW pre link configurations */
> +       pcie_dw_configure(priv, cap_speed);
> +
> +       /* Initiate link training */
> +       imx_pcie_ltssm_enable(priv);
> +
> +       /* Check that link was established */
> +       ret =3D wait_link_up(priv);
> +       if (ret)
> +               imx_pcie_ltssm_disable(priv);
> +
> +       return ret;
> +}
> +
> +static int imx_pcie_assert_core_reset(struct pcie_dw_imx *priv)
> +{
> +       if (dm_gpio_is_valid(&priv->reset_gpio)) {
> +               dm_gpio_set_value(&priv->reset_gpio, 1);
> +               mdelay(20);
> +       }
> +
> +       return reset_assert(&priv->apps_reset);
> +}
> +
> +static int imx_pcie_clk_enable(struct pcie_dw_imx *priv)
> +{
> +       int ret;
> +
> +       ret =3D clk_enable_bulk(&priv->clks);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Set the over ride low and enabled make sure that
> +        * REF_CLK is turned on.
> +        */
> +       regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> +                          IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE, 0);
> +       regmap_update_bits(priv->iomuxc_gpr, IOMUXC_GPR14_OFFSET,
> +                          IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> +                          IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> +
> +       /* allow the clocks to stabilize */
> +       udelay(500);
> +
> +       return 0;
> +}
> +
> +static void imx_pcie_deassert_core_reset(struct pcie_dw_imx *priv)
> +{
> +       if (!dm_gpio_is_valid(&priv->reset_gpio))
> +               return;
> +
> +       mdelay(100);
> +       dm_gpio_set_value(&priv->reset_gpio, 0);
> +       /* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> +       mdelay(100);
> +}
> +
> +static int pcie_dw_imx_probe(struct udevice *dev)
> +{
> +       struct pcie_dw_imx *priv =3D dev_get_priv(dev);
> +       struct udevice *ctlr =3D pci_get_controller(dev);
> +       struct pci_controller *hose =3D dev_get_uclass_priv(ctlr);
> +       int ret;
> +
> +       ret =3D imx_pcie_assert_core_reset(priv);
> +       if (ret) {
> +               dev_err(dev, "failed to assert core reset\n");
> +               return ret;
> +       }
> +
> +       ret =3D imx_pcie_clk_enable(priv);
> +       if (ret) {
> +               dev_err(dev, "failed to enable clocks\n");
> +               goto err_clk;
> +       }
> +
> +       ret =3D generic_phy_init(&priv->phy);
> +       if (ret) {
> +               dev_err(dev, "failed to initialize PHY\n");
> +               goto err_phy_init;
> +       }
> +
> +       ret =3D generic_phy_power_on(&priv->phy);
> +       if (ret) {
> +               dev_err(dev, "failed to power on PHY\n");
> +               goto err_phy_power;
> +       }
> +
> +       imx_pcie_deassert_core_reset(priv);
> +
> +       priv->dw.first_busno =3D dev_seq(dev);
> +       priv->dw.dev =3D dev;
> +       pcie_dw_setup_host(&priv->dw);
> +
> +       if (pcie_link_up(priv, LINK_SPEED_GEN_1)) {
> +               printf("PCIE-%d: Link down\n", dev_seq(dev));
> +               ret =3D -ENODEV;
> +               goto err_link;
> +       }
> +
> +       printf("PCIE-%d: Link up (Gen%d-x%d, Bus%d)\n", dev_seq(dev),
> +              pcie_dw_get_link_speed(&priv->dw),
> +              pcie_dw_get_link_width(&priv->dw),
> +              hose->first_busno);
> +
> +       pcie_dw_prog_outbound_atu_unroll(&priv->dw, PCIE_ATU_REGION_INDEX=
0,
> +                                        PCIE_ATU_TYPE_MEM,
> +                                        priv->dw.mem.phys_start,
> +                                        priv->dw.mem.bus_start, priv->dw=
.mem.size);
> +
> +       return 0;
> +
> +err_link:
> +       generic_shutdown_phy(&priv->phy);
> +err_phy_power:
> +       generic_phy_exit(&priv->phy);
> +err_phy_init:
> +       clk_disable_bulk(&priv->clks);
> +err_clk:
> +       imx_pcie_deassert_core_reset(priv);
> +
> +       return ret;
> +}
> +
> +static int pcie_dw_imx_remove(struct udevice *dev)
> +{
> +       struct pcie_dw_imx *priv =3D dev_get_priv(dev);
> +
> +       generic_shutdown_phy(&priv->phy);
> +       dm_gpio_free(dev, &priv->reset_gpio);
> +       reset_release_all(&priv->apps_reset, 1);
> +       clk_release_bulk(&priv->clks);
> +
> +       return 0;
> +}
> +
> +static int pcie_dw_imx_of_to_plat(struct udevice *dev)
> +{
> +       struct pcie_dw_imx *priv =3D dev_get_priv(dev);
> +       ofnode gpr;
> +       int ret;
> +
> +       /* Get the controller base address */
> +       priv->dw.dbi_base =3D (void *)dev_read_addr_name(dev, "dbi");
> +       if ((fdt_addr_t)priv->dw.dbi_base =3D=3D FDT_ADDR_T_NONE) {
> +               dev_err(dev, "failed to get dbi_base address\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Get the config space base address and size */
> +       priv->dw.cfg_base =3D (void *)dev_read_addr_size_name(dev, "confi=
g",
> +                                                           &priv->dw.cfg=
_size);
> +       if ((fdt_addr_t)priv->dw.cfg_base =3D=3D FDT_ADDR_T_NONE) {
> +               dev_err(dev, "failed to get cfg_base address\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D clk_get_bulk(dev, &priv->clks);
> +       if (ret) {
> +               dev_err(dev, "failed to get PCIe clks\n");
> +               return ret;
> +       }
> +
> +       ret =3D reset_get_by_name(dev, "apps", &priv->apps_reset);
> +       if (ret) {
> +               dev_err(dev,
> +                       "Failed to get PCIe apps reset control\n");
> +               return ret;
> +       }
> +
> +       ret =3D gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_g=
pio,
> +                                  (GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE));
> +       if (ret) {
> +               dev_err(dev, "unable to get reset-gpio\n");
> +               return ret;
> +       }
> +
> +       ret =3D generic_phy_get_by_name(dev, "pcie-phy", &priv->phy);
> +       if (ret) {
> +               dev_err(dev, "failed to get pcie phy\n");
> +               return ret;
> +       }
> +
> +       gpr =3D ofnode_by_compatible(ofnode_null(), "fsl,imx8mp-iomuxc-gp=
r");
> +       if (ofnode_equal(gpr, ofnode_null())) {
> +               dev_err(dev, "unable to find GPR node\n");
> +               return -ENODEV;
> +       }
> +
> +       priv->iomuxc_gpr =3D syscon_node_to_regmap(gpr);
> +       if (IS_ERR(priv->iomuxc_gpr)) {
> +               dev_err(dev, "unable to find iomuxc registers\n");
> +               return PTR_ERR(priv->iomuxc_gpr);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct dm_pci_ops pcie_dw_imx_ops =3D {
> +       .read_config    =3D pcie_dw_read_config,
> +       .write_config   =3D pcie_dw_write_config,
> +};
> +
> +static const struct udevice_id pcie_dw_imx_ids[] =3D {
> +       { .compatible =3D "fsl,imx8mp-pcie" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(pcie_dw_imx) =3D {
> +       .name           =3D "pcie_dw_imx",
> +       .id             =3D UCLASS_PCI,
> +       .of_match       =3D pcie_dw_imx_ids,
> +       .ops            =3D &pcie_dw_imx_ops,
> +       .of_to_plat     =3D pcie_dw_imx_of_to_plat,
> +       .probe          =3D pcie_dw_imx_probe,
> +       .remove         =3D pcie_dw_imx_remove,
> +       .priv_auto      =3D sizeof(struct pcie_dw_imx),
> +};
> --
> 2.34.1
>
