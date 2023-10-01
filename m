Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0146E78486
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EAEA87100;
	Sun,  1 Oct 2023 21:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="llrVGpAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F115887105; Sun,  1 Oct 2023 21:26:44 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D49870D1
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
Received: from mercury (unknown [185.254.75.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D60F6607262;
 Sun,  1 Oct 2023 20:26:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696188402;
 bh=FoElT/jI6owZIKtQKnysGj99mwAENP66bPdB52Rwqhk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=llrVGpAgQqoqeXs32BjJCDtdjgVHU75iJ9JVcecu8knh5f2tpahhbd3rP2AxROGym
 MXt/0arCbc4TYu4akyj9T6rpu/J9Ni6lVdBTa3QFYTPRbOqhh+D1UW0MiMpTlrhPOv
 c8YnOrm6oA9MvbBZDRNGmHWIhEbESOIbItCOdsL1JpqQ21i9HqJTQ1UqZCMwNAqmfG
 Cyz0FhSGjWIGpvGVz/0YRaF5lGNgMaiyrPWvWEtD0rqvHgtmFi0w/0VM9/dRw/ApB5
 BL7ta3oJ5bexRJX0h6zSCnJrTlYQb/PrYStcRg9VbOa8VCz51mDwQacBVSIDPp8SEN
 bPtOLwnN3a7cg==
Received: by mercury (Postfix, from userid 1000)
 id 7B5C410603F9; Sun,  1 Oct 2023 21:26:40 +0200 (CEST)
Date: Sun, 1 Oct 2023 21:26:40 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 u-boot@lists.denx.de, David Wu <david.wu@rock-chips.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH 5/7] net: dwc_eth_qos_rockchip: Add support for RK3588
Message-ID: <20231001192640.f6i55uy7u54dxb4n@mercury.elektranox.org>
References: <20230807000817.1701012-1-jonas@kwiboo.se>
 <20230807000817.1701012-6-jonas@kwiboo.se>
 <9d572c83-365b-23e7-2233-45eabfd8bf8c@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="chf7eokw5nznvuc6"
Content-Disposition: inline
In-Reply-To: <9d572c83-365b-23e7-2233-45eabfd8bf8c@rock-chips.com>
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


--chf7eokw5nznvuc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 27, 2023 at 11:01:10AM +0800, Kever Yang wrote:
> On 2023/8/7 08:08, Jonas Karlman wrote:
> > Add rk_gmac_ops and other special handling that is needed for GMAC to
> > work on RK3588.
> >=20
> > rk_gmac_ops was ported from linux commits:
> > 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac support for rk=
3588")
> > 88619e77b33d ("net: stmmac: rk3588: Allow multiple gmac controller")
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

FWIW it's also

Reviewed-by: <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> Thanks,
> - Kever
> > ---
> > Cc: David Wu <david.wu@rock-chips.com>
> > Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> >   drivers/net/dwc_eth_qos.c          |   4 +
> >   drivers/net/dwc_eth_qos_rockchip.c | 182 ++++++++++++++++++++++++++++-
> >   2 files changed, 182 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> > index 9fb98a2c3c74..dc04416865dd 100644
> > --- a/drivers/net/dwc_eth_qos.c
> > +++ b/drivers/net/dwc_eth_qos.c
> > @@ -1712,6 +1712,10 @@ static const struct udevice_id eqos_ids[] =3D {
> >   		.compatible =3D "rockchip,rk3568-gmac",
> >   		.data =3D (ulong)&eqos_rockchip_config
> >   	},
> > +	{
> > +		.compatible =3D "rockchip,rk3588-gmac",
> > +		.data =3D (ulong)&eqos_rockchip_config
> > +	},
> >   #endif
> >   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_QCOM)
> >   	{
> > diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_q=
os_rockchip.c
> > index c8abe351fc3e..34020496bde6 100644
> > --- a/drivers/net/dwc_eth_qos_rockchip.c
> > +++ b/drivers/net/dwc_eth_qos_rockchip.c
> > @@ -20,6 +20,7 @@ struct rk_gmac_ops {
> >   			    int tx_delay, int rx_delay);
> >   	int (*set_to_rmii)(struct udevice *dev);
> >   	int (*set_gmac_speed)(struct udevice *dev);
> > +	void (*set_clock_selection)(struct udevice *dev, bool enable);
> >   	u32 regs[3];
> >   };
> > @@ -27,7 +28,9 @@ struct rockchip_platform_data {
> >   	struct reset_ctl_bulk resets;
> >   	const struct rk_gmac_ops *ops;
> >   	int id;
> > +	bool clock_input;
> >   	struct regmap *grf;
> > +	struct regmap *php_grf;
> >   };
> >   #define HIWORD_UPDATE(val, mask, shift) \
> > @@ -121,6 +124,137 @@ static int rk3568_set_gmac_speed(struct udevice *=
dev)
> >   	return 0;
> >   }
> > +/* sys_grf */
> > +#define RK3588_GRF_GMAC_CON7			0x031c
> > +#define RK3588_GRF_GMAC_CON8			0x0320
> > +#define RK3588_GRF_GMAC_CON9			0x0324
> > +
> > +#define RK3588_GMAC_RXCLK_DLY_ENABLE(id)	GRF_BIT(2 * (id) + 3)
> > +#define RK3588_GMAC_RXCLK_DLY_DISABLE(id)	GRF_CLR_BIT(2 * (id) + 3)
> > +#define RK3588_GMAC_TXCLK_DLY_ENABLE(id)	GRF_BIT(2 * (id) + 2)
> > +#define RK3588_GMAC_TXCLK_DLY_DISABLE(id)	GRF_CLR_BIT(2 * (id) + 2)
> > +
> > +#define RK3588_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 8)
> > +#define RK3588_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 0)
> > +
> > +/* php_grf */
> > +#define RK3588_GRF_GMAC_CON0			0x0008
> > +#define RK3588_GRF_CLK_CON1			0x0070
> > +
> > +#define RK3588_GMAC_PHY_INTF_SEL_RGMII(id)	\
> > +	(GRF_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_CLR_BIT(5 + =
(id) * 6))
> > +#define RK3588_GMAC_PHY_INTF_SEL_RMII(id)	\
> > +	(GRF_CLR_BIT(3 + (id) * 6) | GRF_CLR_BIT(4 + (id) * 6) | GRF_BIT(5 + =
(id) * 6))
> > +
> > +#define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
> > +#define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
> > +
> > +#define RK3588_GMAC_CLK_SELET_CRU(id)		GRF_BIT(5 * (id) + 4)
> > +#define RK3588_GMAC_CLK_SELET_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
> > +
> > +#define RK3588_GMAC_CLK_RMII_DIV2(id)		GRF_BIT(5 * (id) + 2)
> > +#define RK3588_GMAC_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
> > +
> > +#define RK3588_GMAC_CLK_RGMII_DIV1(id)		\
> > +			(GRF_CLR_BIT(5 * (id) + 2) | GRF_CLR_BIT(5 * (id) + 3))
> > +#define RK3588_GMAC_CLK_RGMII_DIV5(id)		\
> > +			(GRF_BIT(5 * (id) + 2) | GRF_BIT(5 * (id) + 3))
> > +#define RK3588_GMAC_CLK_RGMII_DIV50(id)		\
> > +			(GRF_CLR_BIT(5 * (id) + 2) | GRF_BIT(5 * (id) + 3))
> > +
> > +#define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
> > +#define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
> > +
> > +static int rk3588_set_to_rgmii(struct udevice *dev,
> > +			       int tx_delay, int rx_delay)
> > +{
> > +	struct eth_pdata *pdata =3D dev_get_plat(dev);
> > +	struct rockchip_platform_data *data =3D pdata->priv_pdata;
> > +	u32 offset_con, id =3D data->id;
> > +
> > +	offset_con =3D data->id =3D=3D 1 ? RK3588_GRF_GMAC_CON9 :
> > +				     RK3588_GRF_GMAC_CON8;
> > +
> > +	regmap_write(data->php_grf, RK3588_GRF_GMAC_CON0,
> > +		     RK3588_GMAC_PHY_INTF_SEL_RGMII(id));
> > +
> > +	regmap_write(data->php_grf, RK3588_GRF_CLK_CON1,
> > +		     RK3588_GMAC_CLK_RGMII_MODE(id));
> > +
> > +	regmap_write(data->grf, RK3588_GRF_GMAC_CON7,
> > +		     RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
> > +		     RK3588_GMAC_TXCLK_DLY_ENABLE(id));
> > +
> > +	regmap_write(data->grf, offset_con,
> > +		     RK3588_GMAC_CLK_RX_DL_CFG(rx_delay) |
> > +		     RK3588_GMAC_CLK_TX_DL_CFG(tx_delay));
> > +
> > +	return 0;
> > +}
> > +
> > +static int rk3588_set_to_rmii(struct udevice *dev)
> > +{
> > +	struct eth_pdata *pdata =3D dev_get_plat(dev);
> > +	struct rockchip_platform_data *data =3D pdata->priv_pdata;
> > +
> > +	regmap_write(data->php_grf, RK3588_GRF_GMAC_CON0,
> > +		     RK3588_GMAC_PHY_INTF_SEL_RMII(data->id));
> > +
> > +	regmap_write(data->php_grf, RK3588_GRF_CLK_CON1,
> > +		     RK3588_GMAC_CLK_RMII_MODE(data->id));
> > +
> > +	return 0;
> > +}
> > +
> > +static int rk3588_set_gmac_speed(struct udevice *dev)
> > +{
> > +	struct eqos_priv *eqos =3D dev_get_priv(dev);
> > +	struct eth_pdata *pdata =3D dev_get_plat(dev);
> > +	struct rockchip_platform_data *data =3D pdata->priv_pdata;
> > +	u32 val =3D 0, id =3D data->id;
> > +
> > +	switch (eqos->phy->speed) {
> > +	case SPEED_10:
> > +		if (pdata->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII)
> > +			val =3D RK3588_GMAC_CLK_RMII_DIV20(id);
> > +		else
> > +			val =3D RK3588_GMAC_CLK_RGMII_DIV50(id);
> > +		break;
> > +	case SPEED_100:
> > +		if (pdata->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII)
> > +			val =3D RK3588_GMAC_CLK_RMII_DIV2(id);
> > +		else
> > +			val =3D RK3588_GMAC_CLK_RGMII_DIV5(id);
> > +		break;
> > +	case SPEED_1000:
> > +		if (pdata->phy_interface !=3D PHY_INTERFACE_MODE_RMII)
> > +			val =3D RK3588_GMAC_CLK_RGMII_DIV1(id);
> > +		else
> > +			return -EINVAL;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	regmap_write(data->php_grf, RK3588_GRF_CLK_CON1, val);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rk3588_set_clock_selection(struct udevice *dev, bool enabl=
e)
> > +{
> > +	struct eth_pdata *pdata =3D dev_get_plat(dev);
> > +	struct rockchip_platform_data *data =3D pdata->priv_pdata;
> > +
> > +	u32 val =3D data->clock_input ? RK3588_GMAC_CLK_SELET_IO(data->id) :
> > +				      RK3588_GMAC_CLK_SELET_CRU(data->id);
> > +
> > +	val |=3D enable ? RK3588_GMAC_CLK_RMII_NOGATE(data->id) :
> > +			RK3588_GMAC_CLK_RMII_GATE(data->id);
> > +
> > +	regmap_write(data->php_grf, RK3588_GRF_CLK_CON1, val);
> > +}
> > +
> >   static const struct rk_gmac_ops rk_gmac_ops[] =3D {
> >   	{
> >   		.compatible =3D "rockchip,rk3568-gmac",
> > @@ -133,6 +267,18 @@ static const struct rk_gmac_ops rk_gmac_ops[] =3D {
> >   			0x0, /* sentinel */
> >   		},
> >   	},
> > +	{
> > +		.compatible =3D "rockchip,rk3588-gmac",
> > +		.set_to_rgmii =3D rk3588_set_to_rgmii,
> > +		.set_to_rmii =3D rk3588_set_to_rmii,
> > +		.set_gmac_speed =3D rk3588_set_gmac_speed,
> > +		.set_clock_selection =3D rk3588_set_clock_selection,
> > +		.regs =3D {
> > +			0xfe1b0000, /* gmac0 */
> > +			0xfe1c0000, /* gmac1 */
> > +			0x0, /* sentinel */
> > +		},
> > +	},
> >   	{ }
> >   };
> > @@ -154,6 +300,7 @@ static int eqos_probe_resources_rk(struct udevice *=
dev)
> >   	struct eqos_priv *eqos =3D dev_get_priv(dev);
> >   	struct eth_pdata *pdata =3D dev_get_plat(dev);
> >   	struct rockchip_platform_data *data;
> > +	const char *clock_in_out;
> >   	int reset_flags =3D GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE;
> >   	int ret;
> > @@ -191,6 +338,16 @@ static int eqos_probe_resources_rk(struct udevice =
*dev)
> >   		goto err_free;
> >   	}
> > +	if (device_is_compatible(dev, "rockchip,rk3588-gmac")) {
> > +		data->php_grf =3D
> > +			syscon_regmap_lookup_by_phandle(dev, "rockchip,php-grf");
> > +		if (IS_ERR(data->php_grf)) {
> > +			dev_err(dev, "Missing rockchip,php-grf property\n");
> > +			ret =3D -EINVAL;
> > +			goto err_free;
> > +		}
> > +	}
> > +
> >   	ret =3D reset_get_bulk(dev, &data->resets);
> >   	if (ret < 0)
> >   		goto err_free;
> > @@ -203,12 +360,20 @@ static int eqos_probe_resources_rk(struct udevice=
 *dev)
> >   		goto err_release_resets;
> >   	}
> > -	ret =3D clk_get_by_name(dev, "clk_mac_speed", &eqos->clk_tx);
> > -	if (ret) {
> > -		dev_dbg(dev, "clk_get_by_name(clk_mac_speed) failed: %d", ret);
> > -		goto err_free_clk_master_bus;
> > +	if (device_is_compatible(dev, "rockchip,rk3568-gmac")) {
> > +		ret =3D clk_get_by_name(dev, "clk_mac_speed", &eqos->clk_tx);
> > +		if (ret) {
> > +			dev_dbg(dev, "clk_get_by_name(clk_mac_speed) failed: %d", ret);
> > +			goto err_free_clk_master_bus;
> > +		}
> >   	}
> > +	clock_in_out =3D dev_read_string(dev, "clock_in_out");
> > +	if (clock_in_out && !strcmp(clock_in_out, "input"))
> > +		data->clock_input =3D true;
> > +	else
> > +		data->clock_input =3D false;
> > +
> >   	if (dev_read_bool(dev, "snps,reset-active-low"))
> >   		reset_flags |=3D GPIOD_ACTIVE_LOW;
> > @@ -264,6 +429,12 @@ static int eqos_start_resets_rk(struct udevice *de=
v)
> >   static int eqos_stop_clks_rk(struct udevice *dev)
> >   {
> > +	struct eth_pdata *pdata =3D dev_get_plat(dev);
> > +	struct rockchip_platform_data *data =3D pdata->priv_pdata;
> > +
> > +	if (data->ops->set_clock_selection)
> > +		data->ops->set_clock_selection(dev, false);
> > +
> >   	return 0;
> >   }
> > @@ -284,6 +455,9 @@ static int eqos_start_clks_rk(struct udevice *dev)
> >   		udelay(eqos->reset_delays[2]);
> >   	}
> > +	if (data->ops->set_clock_selection)
> > +		data->ops->set_clock_selection(dev, true);
> > +
> >   	tx_delay =3D dev_read_u32_default(dev, "tx_delay", 0x30);
> >   	rx_delay =3D dev_read_u32_default(dev, "rx_delay", 0x10);

--chf7eokw5nznvuc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUZx+0ACgkQ2O7X88g7
+ppeYg//eG4BcvOLZ/g7pCSR5ObpCi7WXY3/cE8yJRAu8GU0NCyjXOk18GiumMOh
xJ+wPJnx2qQFg/JbMsY38o4i4wr/uPtNHSiXnnk8xfVKTPDOOR08xF6hMu/SS9Zg
64OsI2ISg5yK3SA7+rF8EghTExt7kQHIWuHCyb797BP1NQO9u0rRWWMIxDc4eQ2v
ERxdIeC3A7kKRuwdss/5WwCt5jnJLgk7TqQyBIPs6GB/50em65WYPgec+IaOTckb
YVRt6S7S1GJhT7TjkARVHYSe8pL7eyeXgUpat6Ot50c7tqdKMzlR7rztRlmqPjaD
LW00jjm99nyu7IA7WbMYAAZ/Nb0urnNAzmgFP46c5Hf5q0RUuv5wgH3g6CfaVcJc
tMbT6uHHXWvyvvz+lRAblRovQrm9MeXTSkutl4P3cEVJC4UlRaF9UX6cjWBOWzYx
0fNMqyLloKT+ABfPksekVt94yVALUJKFfsAjPu4cBhLTOS2wRLRQsQkufZa4gY6Z
ceoeOmcSbMYhUy7lQtI6gKRWiSi8qKJz5/+RpA9dE72EEHoYH6ruG4a7fCu6p+V8
rWU5BUs/JvOH4SYg3t3ChE/oArx2+XiCbJHNQ4w9SJm6PWRriKtORJ4IPRUxCeTl
inwqRDYY338OGvwa1vLhFaKjqf7AnXA6mlmWOUHO32gmvd1QdiQ=
=Oe2c
-----END PGP SIGNATURE-----

--chf7eokw5nznvuc6--
