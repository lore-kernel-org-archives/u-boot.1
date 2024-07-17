Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A19EC3DA59
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 00:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D068874A;
	Wed, 17 Jul 2024 02:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AorY0LKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D70C88722; Wed, 17 Jul 2024 02:48:44 +0200 (CEST)
Received: from mail-m254103.xmail.ntesmail.com
 (mail-m254103.xmail.ntesmail.com [103.129.254.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6463A88665
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 02:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=AorY0LKCjoCvHnefJWc3W1yOqFp2bPBL3bLCrsDwllIL8C9ynq1AbqKVLjAkETXs9lvGwR1jGEcEeqv1C4lpjoPFJfILVIykMYiVohctLK0DFzYmVpVkDJFfw2/LuPpK3NkCDrFikW/bsyrh+shbQmwIxnRQCZuwxus8YfkI7nw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=xMLN5OBo6OUnwMhjSOcsdiGKELuAx/BTVOeT7h1473o=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 3AC46900300;
 Wed, 17 Jul 2024 08:48:25 +0800 (CST)
Message-ID: <a2a316be-2fad-4b5b-8ae6-1368479ece80@rock-chips.com>
Date: Wed, 17 Jul 2024 08:48:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] phy: rockchip: naneng-combphy: Introduce PHY-IDs
 to fix RK3588 muxing
To: Sebastian Kropatsch <seb-dev@mail.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <cover.1721161722.git.seb-dev@mail.de>
 <ed6198ccb2635f0e950e3c21fa8898216bf949fa.1721161722.git.seb-dev@mail.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <ed6198ccb2635f0e950e3c21fa8898216bf949fa.1721161722.git.seb-dev@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkweGlZOTUMdGE1DTBhMGExWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90be29718f03a9kunm3ac46900300
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6Lhw5ATI#URw#Sj8YNzg0
 MkoKCQ5VSlVKTElKSkxMSEtOQklNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTElLNwY+
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


On 2024/7/17 04:42, Sebastian Kropatsch wrote:
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../rockchip/phy-rockchip-naneng-combphy.c    | 49 ++++++++++++++++++-
>   1 file changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 1b85cbcce8..7d61913af1 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -67,12 +67,15 @@ struct rockchip_combphy_grfcfg {
>   };
>   
>   struct rockchip_combphy_cfg {
> +	unsigned int num_phys;
> +	unsigned int phy_ids[3];
>   	const struct rockchip_combphy_grfcfg *grfcfg;
>   	int (*combphy_cfg)(struct rockchip_combphy_priv *priv);
>   };
>   
>   struct rockchip_combphy_priv {
>   	u32 mode;
> +	int id;
>   	void __iomem *mmio;
>   	struct udevice *dev;
>   	struct regmap *pipe_grf;
> @@ -270,6 +273,8 @@ static int rockchip_combphy_probe(struct udevice *udev)
>   {
>   	struct rockchip_combphy_priv *priv = dev_get_priv(udev);
>   	const struct rockchip_combphy_cfg *phy_cfg;
> +	fdt_addr_t addr;
> +	int id;
>   
>   	priv->mmio = (void __iomem *)dev_read_addr(udev);
>   	if (IS_ERR(priv->mmio))
> @@ -281,6 +286,26 @@ static int rockchip_combphy_probe(struct udevice *udev)
>   		return -EINVAL;
>   	}
>   
> +	addr = dev_read_addr(udev);
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
>   	priv->dev = udev;
>   	priv->mode = PHY_TYPE_SATA;
>   	priv->cfg = phy_cfg;
> @@ -421,6 +446,12 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
>   };
>   
>   static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
> +	.num_phys = 3,
> +	.phy_ids = {
> +		0xfe820000,
> +		0xfe830000,
> +		0xfe840000,
> +	},
>   	.grfcfg		= &rk3568_combphy_grfcfgs,
>   	.combphy_cfg	= rk3568_combphy_cfg,
>   };
> @@ -436,8 +467,16 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
>   		param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
>   		param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
>   		param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> -		param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
> -		param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
> +		switch (priv->id) {
> +		case 1:
> +			printf("rk3588_combphy_cfg: priv->id was configured to 1");
> +			param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
> +			break;
> +		case 2:
> +			printf("rk3588_combphy_cfg: priv->id was configured to 2");
> +			param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
> +			break;
> +		}
>   		break;
>   	case PHY_TYPE_USB3:
>   		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> @@ -515,6 +554,12 @@ static const struct rockchip_combphy_grfcfg rk3588_combphy_grfcfgs = {
>   };
>   
>   static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
> +	.num_phys = 3,
> +	.phy_ids = {
> +		0xfee00000,
> +		0xfee10000,
> +		0xfee20000,
> +	},
>   	.grfcfg		= &rk3588_combphy_grfcfgs,
>   	.combphy_cfg	= rk3588_combphy_cfg,
>   };
