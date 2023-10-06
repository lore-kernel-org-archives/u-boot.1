Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCDBE94115
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C028B86E45;
	Fri,  6 Oct 2023 22:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CP2txpe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E457386EAB; Fri,  6 Oct 2023 22:34:02 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC7BA86ACF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3af6cd01323so1597548b6e.3
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624438; x=1697229238; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHTQp3ucx7klkxrhR8F+iKKMQY0avPXjmzwBdSZj/dk=;
 b=CP2txpe3FStlJu8IdFpfKL6BLQXCmAU0O1myfsLKe7PSMyHukRHCeMeMYM5YwNGoIb
 En5NPgeFo376JxIJzn7WT8nko95IGANWrsco6i2JNHpZNBvEQOO/9kBt106UvIo+Vdj2
 yfzyBTpUNCIjBCtORoCo4P/516nuZwbyPRqXnz3Xaw5VfF33F2xnHETmzs+HkmBLOK9L
 Lg5NiMd1XB0lUALc4ltJw+lQGrVTp9WLYTz4zhH2tdepbV62ncqE3X6XNXj+aldezuE4
 z8BXJca89U3dawAwc/R+FK8eFrVpSEDZRejFm4P9cxSg6Ux1O9QAZlzFDr5ODhYZxi2F
 DYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624438; x=1697229238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHTQp3ucx7klkxrhR8F+iKKMQY0avPXjmzwBdSZj/dk=;
 b=uo3cBdGz+ZfLoXB5huwNMTVO1usVePFF64fXEem9a54BF+1Rj3kdNIgIe/7P2oTtUn
 DgLd/EmpjKGepKPjvJAUZF1sCRl7w43Ur9lH25gUlIQkAqw/6WnF31toHmRbCHulkfpn
 Q3ABZNrNxmDB5i/pjr3HLHoFxZgkdWIBUinM8sCmCrj/NcAk0OQArU34X0gHAtZzX/aB
 WUjuemI5K19/4HeUtXBnVcBUsiEnmvAswA6eOoGQa3l5oOhaEazSmnD38iDSs+ITvoUA
 Ur8WhkZtbd7N3CkzVJ2gDKSXXqCD4VXhE8tYQmxwXCtJB+uZSpma39DVnP2OK4xyiQ4r
 7TEA==
X-Gm-Message-State: AOJu0YxSE0MPalbGvjrC8VJAo6AElwZ/dbTrK2iGaomaF7Tq2glyMq7K
 Y2PrALHsYGBJQGmgMYqwGn0sD4ohz0VXLKywPqY=
X-Google-Smtp-Source: AGHT+IHt5MyYuePev65963r6j8CgZwYLBeBdiWoOQgptrLmStQjSoyopeCJlzcdpcJlacnSce4O4P7sra9TbB8AumAU=
X-Received: by 2002:a05:6808:18a3:b0:3a7:7bd3:7ab7 with SMTP id
 bi35-20020a05680818a300b003a77bd37ab7mr11521702oib.51.1696624438539; Fri, 06
 Oct 2023 13:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-5-jonas@kwiboo.se>
In-Reply-To: <20231001191730.4167035-5-jonas@kwiboo.se>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:33:47 +0300
Message-ID: <CAGi-RULBZjdKJU1B5K5OReuEkJ6Wmek0=Y6UByX3nOURCorOvg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] net: dwc_eth_qos: Add glue driver for GMAC on
 Rockchip RK3568
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 David Wu <david.wu@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 u-boot@lists.denx.de, Ezequiel Garcia <ezequiel@collabora.com>
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

On Sun, Oct 1, 2023 at 10:17=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Add a new glue driver for Rockchip SoCs, i.e RK3568, with a GMAC based
> on Synopsys DWC Ethernet QoS IP.
>
> rk_gmac_ops was ported from linux commit:
> 3bb3d6b1c195 ("net: stmmac: Add RK3566/RK3568 SoC support")
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> Cc: David Wu <david.wu@rock-chips.com>
> Cc: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> v2:
> - Add comment about ported code intentionally left close to 1:1 with linu=
x
> - Collect r-b tag
>
>  drivers/net/Kconfig                |   8 +
>  drivers/net/Makefile               |   1 +
>  drivers/net/dwc_eth_qos.c          |   8 +-
>  drivers/net/dwc_eth_qos.h          |   2 +
>  drivers/net/dwc_eth_qos_rockchip.c | 357 +++++++++++++++++++++++++++++
>  5 files changed, 374 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/dwc_eth_qos_rockchip.c
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 0ed39a61e4de..29304fd77759 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -225,6 +225,14 @@ config DWC_ETH_QOS_IMX
>           The Synopsys Designware Ethernet QOS IP block with the specific
>           configuration used in IMX soc.
>
> +config DWC_ETH_QOS_ROCKCHIP
> +       bool "Synopsys DWC Ethernet QOS device support for Rockchip SoCs"
> +       depends on DWC_ETH_QOS
> +       select DM_ETH_PHY
> +       help
> +         The Synopsys Designware Ethernet QOS IP block with specific
> +         configuration used in Rockchip SoCs.
> +
>  config DWC_ETH_QOS_STM32
>         bool "Synopsys DWC Ethernet QOS device support for STM32"
>         depends on DWC_ETH_QOS
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index d4af253b6f28..1d444f5b4a69 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_DRIVER_DM9000) +=3D dm9000x.o
>  obj-$(CONFIG_DSA_SANDBOX) +=3D dsa_sandbox.o
>  obj-$(CONFIG_DWC_ETH_QOS) +=3D dwc_eth_qos.o
>  obj-$(CONFIG_DWC_ETH_QOS_IMX) +=3D dwc_eth_qos_imx.o
> +obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) +=3D dwc_eth_qos_rockchip.o
>  obj-$(CONFIG_DWC_ETH_QOS_QCOM) +=3D dwc_eth_qos_qcom.o
>  obj-$(CONFIG_DWC_ETH_QOS_STARFIVE) +=3D dwc_eth_qos_starfive.o
>  obj-$(CONFIG_E1000) +=3D e1000.o
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 24fb3fac1f12..9fb98a2c3c74 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1707,7 +1707,12 @@ static const struct udevice_id eqos_ids[] =3D {
>                 .data =3D (ulong)&eqos_imx_config
>         },
>  #endif
> -
> +#if IS_ENABLED(CONFIG_DWC_ETH_QOS_ROCKCHIP)
> +       {
> +               .compatible =3D "rockchip,rk3568-gmac",
> +               .data =3D (ulong)&eqos_rockchip_config
> +       },
> +#endif
>  #if IS_ENABLED(CONFIG_DWC_ETH_QOS_QCOM)
>         {
>                 .compatible =3D "qcom,qcs404-ethqos",
> @@ -1720,7 +1725,6 @@ static const struct udevice_id eqos_ids[] =3D {
>                 .data =3D (ulong)&eqos_jh7110_config
>         },
>  #endif
> -
>         { }
>  };
>
> diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
> index 06a082da72ef..e3222e1e17e5 100644
> --- a/drivers/net/dwc_eth_qos.h
> +++ b/drivers/net/dwc_eth_qos.h
> @@ -82,6 +82,7 @@ struct eqos_mac_regs {
>  #define EQOS_MAC_MDIO_ADDRESS_PA_SHIFT                 21
>  #define EQOS_MAC_MDIO_ADDRESS_RDA_SHIFT                        16
>  #define EQOS_MAC_MDIO_ADDRESS_CR_SHIFT                 8
> +#define EQOS_MAC_MDIO_ADDRESS_CR_100_150               1
>  #define EQOS_MAC_MDIO_ADDRESS_CR_20_35                 2
>  #define EQOS_MAC_MDIO_ADDRESS_CR_250_300               5
>  #define EQOS_MAC_MDIO_ADDRESS_SKAP                     BIT(4)
> @@ -287,5 +288,6 @@ void eqos_flush_buffer_generic(void *buf, size_t size=
);
>  int eqos_null_ops(struct udevice *dev);
>
>  extern struct eqos_config eqos_imx_config;
> +extern struct eqos_config eqos_rockchip_config;
>  extern struct eqos_config eqos_qcom_config;
>  extern struct eqos_config eqos_jh7110_config;
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos=
_rockchip.c
> new file mode 100644
> index 000000000000..05edc098f50d
> --- /dev/null
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright Contributors to the U-Boot project.
> + *
> + * rk_gmac_ops ported from linux drivers/net/ethernet/stmicro/stmmac/dwm=
ac-rk.c
> + *
> + * Ported code is intentionally left as close as possible with linux cou=
nter
> + * part in order to simplify future porting of fixes and support for oth=
er SoCs.
> + */
> +
> +#include <common.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <net.h>
> +#include <phy.h>
> +#include <regmap.h>
> +#include <reset.h>
> +#include <syscon.h>
> +#include <asm/gpio.h>
> +#include <linux/delay.h>
> +
> +#include "dwc_eth_qos.h"
> +
> +struct rk_gmac_ops {
> +       const char *compatible;
> +       int (*set_to_rgmii)(struct udevice *dev,
> +                           int tx_delay, int rx_delay);
> +       int (*set_to_rmii)(struct udevice *dev);
> +       int (*set_gmac_speed)(struct udevice *dev);
> +       u32 regs[3];
> +};
> +
> +struct rockchip_platform_data {
> +       struct reset_ctl_bulk resets;
> +       const struct rk_gmac_ops *ops;
> +       int id;
> +       struct regmap *grf;
> +};
> +
> +#define HIWORD_UPDATE(val, mask, shift) \
> +               ((val) << (shift) | (mask) << ((shift) + 16))
> +
> +#define GRF_BIT(nr)    (BIT(nr) | BIT((nr) + 16))
> +#define GRF_CLR_BIT(nr)        (BIT((nr) + 16))
> +
> +#define RK3568_GRF_GMAC0_CON0          0x0380
> +#define RK3568_GRF_GMAC0_CON1          0x0384
> +#define RK3568_GRF_GMAC1_CON0          0x0388
> +#define RK3568_GRF_GMAC1_CON1          0x038c
> +
> +/* RK3568_GRF_GMAC0_CON1 && RK3568_GRF_GMAC1_CON1 */
> +#define RK3568_GMAC_PHY_INTF_SEL_RGMII \
> +               (GRF_BIT(4) | GRF_CLR_BIT(5) | GRF_CLR_BIT(6))
> +#define RK3568_GMAC_PHY_INTF_SEL_RMII  \
> +               (GRF_CLR_BIT(4) | GRF_CLR_BIT(5) | GRF_BIT(6))
> +#define RK3568_GMAC_FLOW_CTRL                  GRF_BIT(3)
> +#define RK3568_GMAC_FLOW_CTRL_CLR              GRF_CLR_BIT(3)
> +#define RK3568_GMAC_RXCLK_DLY_ENABLE           GRF_BIT(1)
> +#define RK3568_GMAC_RXCLK_DLY_DISABLE          GRF_CLR_BIT(1)
> +#define RK3568_GMAC_TXCLK_DLY_ENABLE           GRF_BIT(0)
> +#define RK3568_GMAC_TXCLK_DLY_DISABLE          GRF_CLR_BIT(0)
> +
> +/* RK3568_GRF_GMAC0_CON0 && RK3568_GRF_GMAC1_CON0 */
> +#define RK3568_GMAC_CLK_RX_DL_CFG(val) HIWORD_UPDATE(val, 0x7F, 8)
> +#define RK3568_GMAC_CLK_TX_DL_CFG(val) HIWORD_UPDATE(val, 0x7F, 0)
> +
> +static int rk3568_set_to_rgmii(struct udevice *dev,
> +                              int tx_delay, int rx_delay)
> +{
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +       u32 con0, con1;
> +
> +       con0 =3D (data->id =3D=3D 1) ? RK3568_GRF_GMAC1_CON0 :
> +                                RK3568_GRF_GMAC0_CON0;
> +       con1 =3D (data->id =3D=3D 1) ? RK3568_GRF_GMAC1_CON1 :
> +                                RK3568_GRF_GMAC0_CON1;
> +
> +       regmap_write(data->grf, con0,
> +                    RK3568_GMAC_CLK_RX_DL_CFG(rx_delay) |
> +                    RK3568_GMAC_CLK_TX_DL_CFG(tx_delay));
> +
> +       regmap_write(data->grf, con1,
> +                    RK3568_GMAC_PHY_INTF_SEL_RGMII |
> +                    RK3568_GMAC_RXCLK_DLY_ENABLE |
> +                    RK3568_GMAC_TXCLK_DLY_ENABLE);
> +
> +       return 0;
> +}
> +
> +static int rk3568_set_to_rmii(struct udevice *dev)
> +{
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +       u32 con1;
> +
> +       con1 =3D (data->id =3D=3D 1) ? RK3568_GRF_GMAC1_CON1 :
> +                                RK3568_GRF_GMAC0_CON1;
> +       regmap_write(data->grf, con1, RK3568_GMAC_PHY_INTF_SEL_RMII);
> +
> +       return 0;
> +}
> +
> +static int rk3568_set_gmac_speed(struct udevice *dev)
> +{
> +       struct eqos_priv *eqos =3D dev_get_priv(dev);
> +       ulong rate;
> +       int ret;
> +
> +       switch (eqos->phy->speed) {
> +       case SPEED_10:
> +               rate =3D 2500000;
> +               break;
> +       case SPEED_100:
> +               rate =3D 25000000;
> +               break;
> +       case SPEED_1000:
> +               rate =3D 125000000;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret =3D clk_set_rate(&eqos->clk_tx, rate);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static const struct rk_gmac_ops rk_gmac_ops[] =3D {
> +       {
> +               .compatible =3D "rockchip,rk3568-gmac",
> +               .set_to_rgmii =3D rk3568_set_to_rgmii,
> +               .set_to_rmii =3D rk3568_set_to_rmii,
> +               .set_gmac_speed =3D rk3568_set_gmac_speed,
> +               .regs =3D {
> +                       0xfe2a0000, /* gmac0 */
> +                       0xfe010000, /* gmac1 */
> +                       0x0, /* sentinel */
> +               },
> +       },
> +       { }
> +};
> +
> +static const struct rk_gmac_ops *get_rk_gmac_ops(struct udevice *dev)
> +{
> +       const struct rk_gmac_ops *ops =3D rk_gmac_ops;
> +
> +       while (ops->compatible) {
> +               if (device_is_compatible(dev, ops->compatible))
> +                       return ops;
> +               ops++;
> +       }
> +
> +       return NULL;
> +}
> +
> +static int eqos_probe_resources_rk(struct udevice *dev)
> +{
> +       struct eqos_priv *eqos =3D dev_get_priv(dev);
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data;
> +       int reset_flags =3D GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE;
> +       int ret;
> +
> +       data =3D calloc(1, sizeof(struct rockchip_platform_data));
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->ops =3D get_rk_gmac_ops(dev);
> +       if (!data->ops) {
> +               ret =3D -EINVAL;
> +               goto err_free;
> +       }
> +
> +       for (int i =3D 0; data->ops->regs[i]; i++) {
> +               if (data->ops->regs[i] =3D=3D (u32)eqos->regs) {
> +                       data->id =3D i;
> +                       break;
> +               }
> +       }
> +
> +       pdata->priv_pdata =3D data;
> +       pdata->phy_interface =3D eqos->config->interface(dev);
> +       pdata->max_speed =3D eqos->max_speed;
> +
> +       if (pdata->phy_interface =3D=3D PHY_INTERFACE_MODE_NA) {
> +               pr_err("Invalid PHY interface\n");
> +               ret =3D -EINVAL;
> +               goto err_free;
> +       }
> +
> +       data->grf =3D syscon_regmap_lookup_by_phandle(dev, "rockchip,grf"=
);
> +       if (IS_ERR(data->grf)) {
> +               dev_err(dev, "Missing rockchip,grf property\n");
> +               ret =3D -EINVAL;
> +               goto err_free;
> +       }
> +
> +       ret =3D reset_get_bulk(dev, &data->resets);
> +       if (ret < 0)
> +               goto err_free;
> +
> +       reset_assert_bulk(&data->resets);
> +
> +       ret =3D clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
> +       if (ret) {
> +               dev_dbg(dev, "clk_get_by_name(stmmaceth) failed: %d", ret=
);
> +               goto err_release_resets;
> +       }
> +
> +       ret =3D clk_get_by_name(dev, "clk_mac_speed", &eqos->clk_tx);
> +       if (ret) {
> +               dev_dbg(dev, "clk_get_by_name(clk_mac_speed) failed: %d",=
 ret);
> +               goto err_free_clk_master_bus;
> +       }
> +
> +       /* snps,reset props are deprecated, do bare minimum to support th=
em */
> +       if (dev_read_bool(dev, "snps,reset-active-low"))
> +               reset_flags |=3D GPIOD_ACTIVE_LOW;
> +
> +       dev_read_u32_array(dev, "snps,reset-delays-us", eqos->reset_delay=
s, 3);
> +
> +       gpio_request_by_name(dev, "snps,reset-gpio", 0,
> +                            &eqos->phy_reset_gpio, reset_flags);
> +
> +       return 0;
> +
> +err_free_clk_master_bus:
> +       clk_free(&eqos->clk_master_bus);
> +err_release_resets:
> +       reset_release_bulk(&data->resets);
> +err_free:
> +       free(data);
> +
> +       return ret;
> +}
> +
> +static int eqos_remove_resources_rk(struct udevice *dev)
> +{
> +       struct eqos_priv *eqos =3D dev_get_priv(dev);
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +
> +       if (dm_gpio_is_valid(&eqos->phy_reset_gpio))
> +               dm_gpio_free(dev, &eqos->phy_reset_gpio);
> +
> +       clk_free(&eqos->clk_tx);
> +       clk_free(&eqos->clk_master_bus);
> +       reset_release_bulk(&data->resets);
> +       free(data);
> +
> +       return 0;
> +}
> +
> +static int eqos_stop_resets_rk(struct udevice *dev)
> +{
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +
> +       return reset_assert_bulk(&data->resets);
> +}
> +
> +static int eqos_start_resets_rk(struct udevice *dev)
> +{
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +
> +       return reset_deassert_bulk(&data->resets);
> +}
> +
> +static int eqos_stop_clks_rk(struct udevice *dev)
> +{
> +       return 0;
> +}
> +
> +static int eqos_start_clks_rk(struct udevice *dev)
> +{
> +       struct eqos_priv *eqos =3D dev_get_priv(dev);
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +       int tx_delay, rx_delay, ret;
> +
> +       if (dm_gpio_is_valid(&eqos->phy_reset_gpio)) {
> +               udelay(eqos->reset_delays[1]);
> +
> +               ret =3D dm_gpio_set_value(&eqos->phy_reset_gpio, 0);
> +               if (ret < 0)
> +                       return ret;
> +
> +               udelay(eqos->reset_delays[2]);
> +       }
> +
> +       tx_delay =3D dev_read_u32_default(dev, "tx_delay", 0x30);
> +       rx_delay =3D dev_read_u32_default(dev, "rx_delay", 0x10);
> +
> +       switch (pdata->phy_interface) {
> +       case PHY_INTERFACE_MODE_RGMII:
> +               return data->ops->set_to_rgmii(dev, tx_delay, rx_delay);
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +               return data->ops->set_to_rgmii(dev, 0, 0);
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +               return data->ops->set_to_rgmii(dev, tx_delay, 0);
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +               return data->ops->set_to_rgmii(dev, 0, rx_delay);
> +       case PHY_INTERFACE_MODE_RMII:
> +               return data->ops->set_to_rmii(dev);
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int eqos_set_tx_clk_speed_rk(struct udevice *dev)
> +{
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +
> +       return data->ops->set_gmac_speed(dev);
> +}
> +
> +static ulong eqos_get_tick_clk_rate_rk(struct udevice *dev)
> +{
> +       struct eqos_priv *eqos =3D dev_get_priv(dev);
> +
> +       return clk_get_rate(&eqos->clk_master_bus);
> +}
> +
> +static struct eqos_ops eqos_rockchip_ops =3D {
> +       .eqos_inval_desc =3D eqos_inval_desc_generic,
> +       .eqos_flush_desc =3D eqos_flush_desc_generic,
> +       .eqos_inval_buffer =3D eqos_inval_buffer_generic,
> +       .eqos_flush_buffer =3D eqos_flush_buffer_generic,
> +       .eqos_probe_resources =3D eqos_probe_resources_rk,
> +       .eqos_remove_resources =3D eqos_remove_resources_rk,
> +       .eqos_stop_resets =3D eqos_stop_resets_rk,
> +       .eqos_start_resets =3D eqos_start_resets_rk,
> +       .eqos_stop_clks =3D eqos_stop_clks_rk,
> +       .eqos_start_clks =3D eqos_start_clks_rk,
> +       .eqos_calibrate_pads =3D eqos_null_ops,
> +       .eqos_disable_calibration =3D eqos_null_ops,
> +       .eqos_set_tx_clk_speed =3D eqos_set_tx_clk_speed_rk,
> +       .eqos_get_enetaddr =3D eqos_null_ops,
> +       .eqos_get_tick_clk_rate =3D eqos_get_tick_clk_rate_rk,
> +};
> +
> +struct eqos_config eqos_rockchip_config =3D {
> +       .reg_access_always_ok =3D false,
> +       .mdio_wait =3D 10,
> +       .swr_wait =3D 50,
> +       .config_mac =3D EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
> +       .config_mac_mdio =3D EQOS_MAC_MDIO_ADDRESS_CR_100_150,
> +       .axi_bus_width =3D EQOS_AXI_WIDTH_64,
> +       .interface =3D dev_read_phy_mode,
> +       .ops =3D &eqos_rockchip_ops,
> +};
> --
> 2.42.0
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
