Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B186E94114
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9486286EAB;
	Fri,  6 Oct 2023 22:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aPHN4iGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E4D086EC9; Fri,  6 Oct 2023 22:35:28 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C6486ACF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57b6a7e0deeso1476618eaf.2
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624524; x=1697229324; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKtkrIzM0f6eHvR8nhbC7wt3fru6Ze4Vv5LeKFAYrOk=;
 b=aPHN4iGJNU3F8NVdgBkOxC09/H7BCnr5Cve8bnj04l9Rs0p/hn9XUrKQhBbwt3ehTt
 kyRdnY6eO2exeka0/iVP733QzXeX5H2kh1aAKfjzD2cqthRQwiPwzPeOHQvYJkoLx2ZU
 7/0aQvF+jrtj22TBTLk8hjsBsP+mhwvL2Wu48dRNxyzZe+uL7+jSLkUPFGpO8Xp/Ydfi
 W9DunXSS7E+fyMqeEuQ9yqr+l6WRbg/xoEgkY7thAmogMML4vd5DesyDxs13b8T2QpYk
 RfK1Bxx5SOO+G/qp2bDhvbJm+lnnOLHd2jWW4iRxppDC3LEuTMVUpnDHEXwoMvobQm4P
 irJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624524; x=1697229324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AKtkrIzM0f6eHvR8nhbC7wt3fru6Ze4Vv5LeKFAYrOk=;
 b=WaHRgGBjko6C/zhnKdCC/jVJRaG02bIjv20v443KRtdm4KeWcZe8+cPMBvtbNBgJTA
 aWtzzvqbP2jUsf0zB/bnjwBvFLKu+8SZS/x4OVc+J0Yv9V08bjFxFJzPWPZFDUTaenL+
 v1/gzheGHMNlCmqX7XS7ze3ZePxuiGar4N7khkb0KEMpMXGx88cvTNdWf4WhdYMjZL2X
 cL8cVt/76PdeyT4UCgE656mpZ6h5LNRv312cZ3jh+BPj9E1w/wML1qCIL/6HJWwbT12+
 5pJBlTbD9jRS1mm3DMQx3gxQqfbIyFgGCACZ7oxPsi80FY+TPC80JcizlDJmJRVf7DdA
 aQyg==
X-Gm-Message-State: AOJu0YyckE45F/lehPhHd/68tYLDWgjTyuvruWnT6NmRQ1sPFu8N+2W6
 GXlujQJQyuHyt63qe+JFoy5VFq0/dEWXnQGYx40=
X-Google-Smtp-Source: AGHT+IHlgykbkxkWqaDMtFHTtMZZGKYd/dQFXVgGa1qt63lw5NM62kyKMxVAS0HoLSToPrIDEMngfgvqs436PF6GlO4=
X-Received: by 2002:a4a:301e:0:b0:57b:6ca8:2668 with SMTP id
 q30-20020a4a301e000000b0057b6ca82668mr8957319oof.2.1696624524461; Fri, 06 Oct
 2023 13:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-6-jonas@kwiboo.se>
In-Reply-To: <20231001191730.4167035-6-jonas@kwiboo.se>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:35:13 +0300
Message-ID: <CAGi-RU+qVapr3r9efRTPEewcAp6bA=JT+0=QZ5Z_J_nC7YesOw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] net: dwc_eth_qos_rockchip: Add support for RK3588
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 David Wu <david.wu@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 u-boot@lists.denx.de, Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
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
> Add rk_gmac_ops and other special handling that is needed for GMAC to
> work on RK3588.
>
> rk_gmac_ops was ported from linux commits:
> 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac support for rk35=
88")
> 88619e77b33d ("net: stmmac: rk3588: Allow multiple gmac controller")
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> Cc: David Wu <david.wu@rock-chips.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> v2:
> - Collect r-b tag
>
>  drivers/net/dwc_eth_qos.c          |   4 +
>  drivers/net/dwc_eth_qos_rockchip.c | 182 ++++++++++++++++++++++++++++-
>  2 files changed, 182 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 9fb98a2c3c74..dc04416865dd 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1712,6 +1712,10 @@ static const struct udevice_id eqos_ids[] =3D {
>                 .compatible =3D "rockchip,rk3568-gmac",
>                 .data =3D (ulong)&eqos_rockchip_config
>         },
> +       {
> +               .compatible =3D "rockchip,rk3588-gmac",
> +               .data =3D (ulong)&eqos_rockchip_config
> +       },
>  #endif
>  #if IS_ENABLED(CONFIG_DWC_ETH_QOS_QCOM)
>         {
> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos=
_rockchip.c
> index 05edc098f50d..20fd3a25c3dd 100644
> --- a/drivers/net/dwc_eth_qos_rockchip.c
> +++ b/drivers/net/dwc_eth_qos_rockchip.c
> @@ -28,6 +28,7 @@ struct rk_gmac_ops {
>                             int tx_delay, int rx_delay);
>         int (*set_to_rmii)(struct udevice *dev);
>         int (*set_gmac_speed)(struct udevice *dev);
> +       void (*set_clock_selection)(struct udevice *dev, bool enable);
>         u32 regs[3];
>  };
>
> @@ -35,7 +36,9 @@ struct rockchip_platform_data {
>         struct reset_ctl_bulk resets;
>         const struct rk_gmac_ops *ops;
>         int id;
> +       bool clock_input;
>         struct regmap *grf;
> +       struct regmap *php_grf;
>  };
>
>  #define HIWORD_UPDATE(val, mask, shift) \
> @@ -129,6 +132,137 @@ static int rk3568_set_gmac_speed(struct udevice *de=
v)
>         return 0;
>  }
>
> +/* sys_grf */
> +#define RK3588_GRF_GMAC_CON7                   0x031c
> +#define RK3588_GRF_GMAC_CON8                   0x0320
> +#define RK3588_GRF_GMAC_CON9                   0x0324
> +
> +#define RK3588_GMAC_RXCLK_DLY_ENABLE(id)       GRF_BIT(2 * (id) + 3)
> +#define RK3588_GMAC_RXCLK_DLY_DISABLE(id)      GRF_CLR_BIT(2 * (id) + 3)
> +#define RK3588_GMAC_TXCLK_DLY_ENABLE(id)       GRF_BIT(2 * (id) + 2)
> +#define RK3588_GMAC_TXCLK_DLY_DISABLE(id)      GRF_CLR_BIT(2 * (id) + 2)
> +
> +#define RK3588_GMAC_CLK_RX_DL_CFG(val)         HIWORD_UPDATE(val, 0xFF, =
8)
> +#define RK3588_GMAC_CLK_TX_DL_CFG(val)         HIWORD_UPDATE(val, 0xFF, =
0)
> +
> +/* php_grf */
> +#define RK3588_GRF_GMAC_CON0                   0x0008
> +#define RK3588_GRF_CLK_CON1                    0x0070
> +
> +#define RK3588_GMAC_PHY_INTF_SEL_RGMII(id)     \
> +       (GRF_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_CLR_BIT(=
5 + (id) * 6))
> +#define RK3588_GMAC_PHY_INTF_SEL_RMII(id)      \
> +       (GRF_CLR_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_BIT(=
5 + (id) * 6))
> +
> +#define RK3588_GMAC_CLK_RMII_MODE(id)          GRF_BIT(5 * (id))
> +#define RK3588_GMAC_CLK_RGMII_MODE(id)         GRF_CLR_BIT(5 * (id))
> +
> +#define RK3588_GMAC_CLK_SELET_CRU(id)          GRF_BIT(5 * (id) + 4)
> +#define RK3588_GMAC_CLK_SELET_IO(id)           GRF_CLR_BIT(5 * (id) + 4)
> +
> +#define RK3588_GMAC_CLK_RMII_DIV2(id)          GRF_BIT(5 * (id) + 2)
> +#define RK3588_GMAC_CLK_RMII_DIV20(id)         GRF_CLR_BIT(5 * (id) + 2)
> +
> +#define RK3588_GMAC_CLK_RGMII_DIV1(id)         \
> +                       (GRF_CLR_BIT(5 * (id) + 2) | GRF_CLR_BIT(5 * (id)=
 + 3))
> +#define RK3588_GMAC_CLK_RGMII_DIV5(id)         \
> +                       (GRF_BIT(5 * (id) + 2) | GRF_BIT(5 * (id) + 3))
> +#define RK3588_GMAC_CLK_RGMII_DIV50(id)                \
> +                       (GRF_CLR_BIT(5 * (id) + 2) | GRF_BIT(5 * (id) + 3=
))
> +
> +#define RK3588_GMAC_CLK_RMII_GATE(id)          GRF_BIT(5 * (id) + 1)
> +#define RK3588_GMAC_CLK_RMII_NOGATE(id)                GRF_CLR_BIT(5 * (=
id) + 1)
> +
> +static int rk3588_set_to_rgmii(struct udevice *dev,
> +                              int tx_delay, int rx_delay)
> +{
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +       u32 offset_con, id =3D data->id;
> +
> +       offset_con =3D data->id =3D=3D 1 ? RK3588_GRF_GMAC_CON9 :
> +                                    RK3588_GRF_GMAC_CON8;
> +
> +       regmap_write(data->php_grf, RK3588_GRF_GMAC_CON0,
> +                    RK3588_GMAC_PHY_INTF_SEL_RGMII(id));
> +
> +       regmap_write(data->php_grf, RK3588_GRF_CLK_CON1,
> +                    RK3588_GMAC_CLK_RGMII_MODE(id));
> +
> +       regmap_write(data->grf, RK3588_GRF_GMAC_CON7,
> +                    RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
> +                    RK3588_GMAC_TXCLK_DLY_ENABLE(id));
> +
> +       regmap_write(data->grf, offset_con,
> +                    RK3588_GMAC_CLK_RX_DL_CFG(rx_delay) |
> +                    RK3588_GMAC_CLK_TX_DL_CFG(tx_delay));
> +
> +       return 0;
> +}
> +
> +static int rk3588_set_to_rmii(struct udevice *dev)
> +{
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +
> +       regmap_write(data->php_grf, RK3588_GRF_GMAC_CON0,
> +                    RK3588_GMAC_PHY_INTF_SEL_RMII(data->id));
> +
> +       regmap_write(data->php_grf, RK3588_GRF_CLK_CON1,
> +                    RK3588_GMAC_CLK_RMII_MODE(data->id));
> +
> +       return 0;
> +}
> +
> +static int rk3588_set_gmac_speed(struct udevice *dev)
> +{
> +       struct eqos_priv *eqos =3D dev_get_priv(dev);
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +       u32 val =3D 0, id =3D data->id;
> +
> +       switch (eqos->phy->speed) {
> +       case SPEED_10:
> +               if (pdata->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII)
> +                       val =3D RK3588_GMAC_CLK_RMII_DIV20(id);
> +               else
> +                       val =3D RK3588_GMAC_CLK_RGMII_DIV50(id);
> +               break;
> +       case SPEED_100:
> +               if (pdata->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII)
> +                       val =3D RK3588_GMAC_CLK_RMII_DIV2(id);
> +               else
> +                       val =3D RK3588_GMAC_CLK_RGMII_DIV5(id);
> +               break;
> +       case SPEED_1000:
> +               if (pdata->phy_interface !=3D PHY_INTERFACE_MODE_RMII)
> +                       val =3D RK3588_GMAC_CLK_RGMII_DIV1(id);
> +               else
> +                       return -EINVAL;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       regmap_write(data->php_grf, RK3588_GRF_CLK_CON1, val);
> +
> +       return 0;
> +}
> +
> +static void rk3588_set_clock_selection(struct udevice *dev, bool enable)
> +{
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +
> +       u32 val =3D data->clock_input ? RK3588_GMAC_CLK_SELET_IO(data->id=
) :
> +                                     RK3588_GMAC_CLK_SELET_CRU(data->id)=
;
> +
> +       val |=3D enable ? RK3588_GMAC_CLK_RMII_NOGATE(data->id) :
> +                       RK3588_GMAC_CLK_RMII_GATE(data->id);
> +
> +       regmap_write(data->php_grf, RK3588_GRF_CLK_CON1, val);
> +}
> +
>  static const struct rk_gmac_ops rk_gmac_ops[] =3D {
>         {
>                 .compatible =3D "rockchip,rk3568-gmac",
> @@ -141,6 +275,18 @@ static const struct rk_gmac_ops rk_gmac_ops[] =3D {
>                         0x0, /* sentinel */
>                 },
>         },
> +       {
> +               .compatible =3D "rockchip,rk3588-gmac",
> +               .set_to_rgmii =3D rk3588_set_to_rgmii,
> +               .set_to_rmii =3D rk3588_set_to_rmii,
> +               .set_gmac_speed =3D rk3588_set_gmac_speed,
> +               .set_clock_selection =3D rk3588_set_clock_selection,
> +               .regs =3D {
> +                       0xfe1b0000, /* gmac0 */
> +                       0xfe1c0000, /* gmac1 */
> +                       0x0, /* sentinel */
> +               },
> +       },
>         { }
>  };
>
> @@ -162,6 +308,7 @@ static int eqos_probe_resources_rk(struct udevice *de=
v)
>         struct eqos_priv *eqos =3D dev_get_priv(dev);
>         struct eth_pdata *pdata =3D dev_get_plat(dev);
>         struct rockchip_platform_data *data;
> +       const char *clock_in_out;
>         int reset_flags =3D GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE;
>         int ret;
>
> @@ -199,6 +346,16 @@ static int eqos_probe_resources_rk(struct udevice *d=
ev)
>                 goto err_free;
>         }
>
> +       if (device_is_compatible(dev, "rockchip,rk3588-gmac")) {
> +               data->php_grf =3D
> +                       syscon_regmap_lookup_by_phandle(dev, "rockchip,ph=
p-grf");
> +               if (IS_ERR(data->php_grf)) {
> +                       dev_err(dev, "Missing rockchip,php-grf property\n=
");
> +                       ret =3D -EINVAL;
> +                       goto err_free;
> +               }
> +       }
> +
>         ret =3D reset_get_bulk(dev, &data->resets);
>         if (ret < 0)
>                 goto err_free;
> @@ -211,12 +368,20 @@ static int eqos_probe_resources_rk(struct udevice *=
dev)
>                 goto err_release_resets;
>         }
>
> -       ret =3D clk_get_by_name(dev, "clk_mac_speed", &eqos->clk_tx);
> -       if (ret) {
> -               dev_dbg(dev, "clk_get_by_name(clk_mac_speed) failed: %d",=
 ret);
> -               goto err_free_clk_master_bus;
> +       if (device_is_compatible(dev, "rockchip,rk3568-gmac")) {
> +               ret =3D clk_get_by_name(dev, "clk_mac_speed", &eqos->clk_=
tx);
> +               if (ret) {
> +                       dev_dbg(dev, "clk_get_by_name(clk_mac_speed) fail=
ed: %d", ret);
> +                       goto err_free_clk_master_bus;
> +               }
>         }
>
> +       clock_in_out =3D dev_read_string(dev, "clock_in_out");
> +       if (clock_in_out && !strcmp(clock_in_out, "input"))
> +               data->clock_input =3D true;
> +       else
> +               data->clock_input =3D false;
> +
>         /* snps,reset props are deprecated, do bare minimum to support th=
em */
>         if (dev_read_bool(dev, "snps,reset-active-low"))
>                 reset_flags |=3D GPIOD_ACTIVE_LOW;
> @@ -273,6 +438,12 @@ static int eqos_start_resets_rk(struct udevice *dev)
>
>  static int eqos_stop_clks_rk(struct udevice *dev)
>  {
> +       struct eth_pdata *pdata =3D dev_get_plat(dev);
> +       struct rockchip_platform_data *data =3D pdata->priv_pdata;
> +
> +       if (data->ops->set_clock_selection)
> +               data->ops->set_clock_selection(dev, false);
> +
>         return 0;
>  }
>
> @@ -293,6 +464,9 @@ static int eqos_start_clks_rk(struct udevice *dev)
>                 udelay(eqos->reset_delays[2]);
>         }
>
> +       if (data->ops->set_clock_selection)
> +               data->ops->set_clock_selection(dev, true);
> +
>         tx_delay =3D dev_read_u32_default(dev, "tx_delay", 0x30);
>         rx_delay =3D dev_read_u32_default(dev, "rx_delay", 0x10);
>
> --
> 2.42.0
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
