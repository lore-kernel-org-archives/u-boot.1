Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCA9C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 18:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F7B687D87;
	Sun, 21 Jul 2024 20:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="J20rBY94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C394586DBD; Sun, 21 Jul 2024 20:40:35 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80ADC87E96
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 20:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7206=OW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1721587219;
 bh=uequ2ZHkdDFUB+Lzq9fGGq7ci5flSvtZjgw2B0yLNF4=;
 b=J20rBY94ORyzIbK3BJwEGBHnuSfGYkK04lKRpKIA0OfOhma1telxfiuf0JtapEvaa4iA+1Xt5
 okYgTq1J7JejrugL0aBnlGNyr4hQAOmYLRriGAd3iB4TAJXF5jZLvlpLBO80aMn4qNjchQJErwE
 HhbgdOCzuz4C2OjsxnH4/qU08gdL6G04MRhg6nb+M4dgc/N7Z7xtxotFY/so2YH7z/Oz+lrF370
 0rx5RIaOLjuq9pxwbUZkZgSg1DtnRp1n2eOjUmPxWl7LhA7frdYFc4iPUEnWUctc7SX/+1R6mnJ
 L669OOccRRTuIZNRWnwG2KVa/ylmCTOkMzwBDGjJDgEA==
Message-ID: <7fd8f4e2-1661-43d5-b753-94549351dbf8@kwiboo.se>
Date: Sun, 21 Jul 2024 20:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] phy: rockchip: naneng-combphy: Introduce PHY-IDs
 to fix RK3588 muxing
To: Sebastian Kropatsch <seb-dev@mail.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <cover.1721161722.git.seb-dev@mail.de>
 <ed6198ccb2635f0e950e3c21fa8898216bf949fa.1721161722.git.seb-dev@mail.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ed6198ccb2635f0e950e3c21fa8898216bf949fa.1721161722.git.seb-dev@mail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 669d56107025df85504af01f
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

Hi Sebastian,

On 2024-07-16 22:42, Sebastian Kropatsch wrote:
> Fix multiplex configuration for PCIe1L0 and PCIe1L1 in PCIESEL_CON for
> RK3588 to correctly select between Combo PHYs and PCIe3 PHY.
> Currently, the code incorrectly muxes both ports to Combo PHYs,
> interfering with PCIe3 PHY settings.
> Introduce PHY identifiers to identify the correct Combo PHY and set
> the necessary bits accordingly.
> 
> This fix is adapted from the upstream Linux commit by Sebastian Reichel:
> d16d4002fea6 ("phy: rockchip: naneng-combphy: Fix mux on rk3588")
> 
> Fixes: b37260bca1aa ("phy: rockchip: naneng-combphy: Use signal from comb PHY on RK3588")
> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
> ---
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 49 ++++++++++++++++++-
>  1 file changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 1b85cbcce8..7d61913af1 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -67,12 +67,15 @@ struct rockchip_combphy_grfcfg {
>  };
>  
>  struct rockchip_combphy_cfg {
> +	unsigned int num_phys;
> +	unsigned int phy_ids[3];
>  	const struct rockchip_combphy_grfcfg *grfcfg;
>  	int (*combphy_cfg)(struct rockchip_combphy_priv *priv);
>  };
>  
>  struct rockchip_combphy_priv {
>  	u32 mode;
> +	int id;
>  	void __iomem *mmio;
>  	struct udevice *dev;
>  	struct regmap *pipe_grf;
> @@ -270,6 +273,8 @@ static int rockchip_combphy_probe(struct udevice *udev)
>  {
>  	struct rockchip_combphy_priv *priv = dev_get_priv(udev);
>  	const struct rockchip_combphy_cfg *phy_cfg;
> +	fdt_addr_t addr;
> +	int id;
>  
>  	priv->mmio = (void __iomem *)dev_read_addr(udev);
>  	if (IS_ERR(priv->mmio))
> @@ -281,6 +286,26 @@ static int rockchip_combphy_probe(struct udevice *udev)
>  		return -EINVAL;
>  	}
>  
> +	addr = dev_read_addr(udev);

dev_read_addr(udev) is already called above, maybe we can use the
returned value from that call?

Or this could be changes to match other reg value matching done in other
rockchip phy drivers, e.g. something like:

	ret = ofnode_read_u32_index(dev_ofnode(udev), "reg", 0, &reg);
	if (ret) {
		dev_err(udev, "failed to read reg[0] property\n");
		return ret;
	}
	if (reg == 0 && dev_read_addr_cells(udev) == 2) {
		ret = ofnode_read_u32_index(dev_ofnode(udev), "reg", 1, &reg);
		if (ret) {
			dev_err(udev, "failed to read reg[1] property\n");
			return ret;
		}
	}

> +	if (addr == FDT_ADDR_T_NONE) {
> +		dev_err(udev, "No valid device address found\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Find the phy-id based on the device's I/O-address */
> +	priv->id = -ENODEV;
> +	for (id = 0; id < phy_cfg->num_phys; id++) {
> +		if (addr == phy_cfg->phy_ids[id]) {
> +			priv->id = id;
> +			break;
> +		}
> +	}
> +
> +	if (priv->id == -ENODEV) {
> +		dev_err(udev, "Failed to find PHY ID\n");
> +		return -ENODEV;
> +	}
> +
>  	priv->dev = udev;
>  	priv->mode = PHY_TYPE_SATA;
>  	priv->cfg = phy_cfg;
> @@ -421,6 +446,12 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
>  };
>  
>  static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
> +	.num_phys = 3,
> +	.phy_ids = {
> +		0xfe820000,
> +		0xfe830000,
> +		0xfe840000,
> +	},
>  	.grfcfg		= &rk3568_combphy_grfcfgs,
>  	.combphy_cfg	= rk3568_combphy_cfg,
>  };
> @@ -436,8 +467,16 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
>  		param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
>  		param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
>  		param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> -		param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
> -		param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
> +		switch (priv->id) {
> +		case 1:
> +			printf("rk3588_combphy_cfg: priv->id was configured to 1");

Please drop printf calls.

> +			param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
> +			break;
> +		case 2:
> +			printf("rk3588_combphy_cfg: priv->id was configured to 2");

Please drop printf calls.

Regards,
Jonas

> +			param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
> +			break;
> +		}
>  		break;
>  	case PHY_TYPE_USB3:
>  		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> @@ -515,6 +554,12 @@ static const struct rockchip_combphy_grfcfg rk3588_combphy_grfcfgs = {
>  };
>  
>  static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
> +	.num_phys = 3,
> +	.phy_ids = {
> +		0xfee00000,
> +		0xfee10000,
> +		0xfee20000,
> +	},
>  	.grfcfg		= &rk3588_combphy_grfcfgs,
>  	.combphy_cfg	= rk3588_combphy_cfg,
>  };

