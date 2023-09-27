Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC1FE7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D2A286D82;
	Wed, 27 Sep 2023 04:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="UyCAv/6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F966805CA; Wed, 27 Sep 2023 04:47:04 +0200 (CEST)
Received: from mail-m12774.qiye.163.com (mail-m12774.qiye.163.com
 [115.236.127.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D692F86D82
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=UyCAv/6vDTUep91aYcGm8RbHCQETfxcxmnGaNV73cNIsp48eJEPth2sD06uIP+p9Ir3JVEZF+QMCCCBWu9ykD9rsi5nFNT2Xeal31WqJLPbw9jS4eiBESaTMzgMnckHzhNGep1Jkar3qJ7YWm5jT1k0aMBdaw3KCaCPXpTUGTWA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=8RsxFZFD8VDO3QyeUMMUbEJmpXwMOLT96QaXyezZ+rI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id D3F704002CB;
 Wed, 27 Sep 2023 10:46:50 +0800 (CST)
Message-ID: <a31379ce-4c1d-b7c6-1d77-0693013be755@rock-chips.com>
Date: Wed, 27 Sep 2023 10:46:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/7] phy: rockchip: snps-pcie3: Add support for RK3588
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jon Lin <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <20230802190424.2963185-6-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230802190424.2963185-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhOGlZMTRpIHR9KTEtCSE5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad48835e02eb3kusnd3f704002cb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ni46Tww6PDw2KjY#LEoxCQ4j
 OiIKFANVSlVKTUJOTENJQ0pKTU9MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOQktCNwY+
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


On 2023/8/3 03:04, Jonas Karlman wrote:
> Add support for the RK3588 variant to the driver.
>
> Code imported almost 1:1 from mainline linux driver.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
>
>   .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 85 +++++++++++++++++++
>   1 file changed, 85 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> index 642819b1f672..a4392daf4c92 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -27,6 +27,17 @@
>   
>   #define RK3568_BIFURCATION_LANE_0_1		BIT(0)
>   
> +/* Register for RK3588 */
> +#define PHP_GRF_PCIESEL_CON			0x100
> +#define RK3588_PCIE3PHY_GRF_CMN_CON0		0x0
> +#define RK3588_PCIE3PHY_GRF_PHY0_STATUS1	0x904
> +#define RK3588_PCIE3PHY_GRF_PHY1_STATUS1	0xa04
> +#define RK3588_SRAM_INIT_DONE(reg)		(reg & BIT(0))
> +
> +#define RK3588_BIFURCATION_LANE_0_1		BIT(0)
> +#define RK3588_BIFURCATION_LANE_2_3		BIT(1)
> +#define RK3588_LANE_AGGREGATION			BIT(2)
> +
>   /**
>    * struct rockchip_p3phy_priv - RK DW PCIe PHY state
>    *
> @@ -40,6 +51,7 @@
>   struct rockchip_p3phy_priv {
>   	void __iomem *mmio;
>   	struct regmap *phy_grf;
> +	struct regmap *pipe_grf;
>   	struct reset_ctl p30phy;
>   	struct clk_bulk clks;
>   	int num_lanes;
> @@ -93,6 +105,66 @@ static const struct rockchip_p3phy_ops rk3568_ops = {
>   	.phy_init = rockchip_p3phy_rk3568_init,
>   };
>   
> +static int rockchip_p3phy_rk3588_init(struct phy *phy)
> +{
> +	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
> +	u32 reg = 0;
> +	u8 mode = 0;
> +	int ret;
> +
> +	/* Deassert PCIe PMA output clamp mode */
> +	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
> +		     BIT(8) | BIT(24));
> +
> +	/* Set bifurcation if needed */
> +	for (int i = 0; i < priv->num_lanes; i++) {
> +		if (!priv->lanes[i])
> +			mode |= (BIT(i) << 3);
> +
> +		if (priv->lanes[i] > 1)
> +			mode |= (BIT(i) >> 1);
> +	}
> +
> +	if (!mode) {
> +		reg = RK3588_LANE_AGGREGATION;
> +	} else {
> +		if (mode & (BIT(0) | BIT(1)))
> +			reg |= RK3588_BIFURCATION_LANE_0_1;
> +
> +		if (mode & (BIT(2) | BIT(3)))
> +			reg |= RK3588_BIFURCATION_LANE_2_3;
> +	}
> +
> +	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
> +		     (0x7 << 16) | reg);
> +
> +	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
> +	reg = (mode & (BIT(6) | BIT(7))) >> 6;
> +	if (reg)
> +		regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
> +			     (reg << 16) | reg);
> +
> +	reset_deassert(&priv->p30phy);
> +	udelay(1);
> +
> +	ret = regmap_read_poll_timeout(priv->phy_grf,
> +				       RK3588_PCIE3PHY_GRF_PHY0_STATUS1,
> +				       reg, RK3588_SRAM_INIT_DONE(reg),
> +				       0, 500);
> +	ret |= regmap_read_poll_timeout(priv->phy_grf,
> +					RK3588_PCIE3PHY_GRF_PHY1_STATUS1,
> +					reg, RK3588_SRAM_INIT_DONE(reg),
> +					0, 500);
> +	if (ret)
> +		dev_err(phy->dev, "lock failed 0x%x\n", reg);
> +
> +	return ret;
> +}
> +
> +static const struct rockchip_p3phy_ops rk3588_ops = {
> +	.phy_init = rockchip_p3phy_rk3588_init,
> +};
> +
>   static int rochchip_p3phy_init(struct phy *phy)
>   {
>   	struct rockchip_p3phy_ops *ops =
> @@ -139,6 +211,15 @@ static int rockchip_p3phy_probe(struct udevice *dev)
>   		return PTR_ERR(priv->phy_grf);
>   	}
>   
> +	if (device_is_compatible(dev, "rockchip,rk3588-pcie3-phy")) {
> +		priv->pipe_grf =
> +			syscon_regmap_lookup_by_phandle(dev, "rockchip,pipe-grf");
> +		if (IS_ERR(priv->pipe_grf)) {
> +			dev_err(dev, "failed to find rockchip,pipe_grf regmap\n");
> +			return PTR_ERR(priv->pipe_grf);
> +		}
> +	}
> +
>   	ret = dev_read_size(dev, "data-lanes");
>   	if (ret > 0) {
>   		priv->num_lanes = ret / sizeof(u32);
> @@ -181,6 +262,10 @@ static const struct udevice_id rockchip_p3phy_of_match[] = {
>   		.compatible = "rockchip,rk3568-pcie3-phy",
>   		.data = (ulong)&rk3568_ops,
>   	},
> +	{
> +		.compatible = "rockchip,rk3588-pcie3-phy",
> +		.data = (ulong)&rk3588_ops,
> +	},
>   	{ },
>   };
>   
