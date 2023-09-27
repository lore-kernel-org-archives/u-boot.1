Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AECE7F150
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344F886D62;
	Wed, 27 Sep 2023 04:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gI94rQUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1497F86D73; Wed, 27 Sep 2023 04:46:51 +0200 (CEST)
Received: from mail-m12779.qiye.163.com (mail-m12779.qiye.163.com
 [115.236.127.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BACA2805CA
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=gI94rQUuuWemnBY4HPjlxUyGt3QsOLiix2Hr2Y4GJECCmQiWeMAiEIXlTBUZBDMO+MT/tjx4JNzpYauAI6xLjkXt6TwRHXj19885t/ls2EFqYjuxhKVhZ8WEKxtzalXqhk3XPcIkIeJcoCTRLXFeM3q/rRK7P+yFFJcwHNn6AHk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=UCB4rqmapQCUkT6yun6mq5Kdw+dYNvYtpdN1ZzxRZTo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 6FD2A4002EA;
 Wed, 27 Sep 2023 10:46:41 +0800 (CST)
Message-ID: <7b0a1602-3a11-8c08-4325-978d22b20d14@rock-chips.com>
Date: Wed, 27 Sep 2023 10:46:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/7] phy: rockchip: snps-pcie3: Add bifurcation support
 for RK3568
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jon Lin <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <20230802190424.2963185-5-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230802190424.2963185-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1NS1YdSx9CSENKSUxJTkJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8ad48811392eb3kusn6fd2a4002ea
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OUk6MCo4GjwzSTYZFlFWCQ0T
 AQIKCg1VSlVKTUJOTENJQ0tJSENDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOQkpONwY+
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
> Configure aggregation or bifurcation mode on RK3568 based on the value
> of data-lanes property.
>
> Code imported almost 1:1 from mainline linux driver.
>
> Fixes: 6ec62b6ca698 ("phy: rockchip: Add Rockchip Synopsys PCIe 3.0 PHY")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Add fixes tag
>
>   .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 65 +++++++++++++++++--
>   1 file changed, 59 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> index b76b5386bef0..642819b1f672 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -16,9 +16,16 @@
>   #include <dm/device_compat.h>
>   #include <dm/lists.h>
>   
> -#define GRF_PCIE30PHY_CON1 0x4
> -#define GRF_PCIE30PHY_CON6 0x18
> -#define GRF_PCIE30PHY_CON9 0x24
> +/* Register for RK3568 */
> +#define GRF_PCIE30PHY_CON1			0x4
> +#define GRF_PCIE30PHY_CON6			0x18
> +#define GRF_PCIE30PHY_CON9			0x24
> +#define GRF_PCIE30PHY_DA_OCM			(BIT(15) | BIT(31))
> +#define GRF_PCIE30PHY_STATUS0			0x80
> +#define GRF_PCIE30PHY_WR_EN			(0xf << 16)
> +#define SRAM_INIT_DONE(reg)			(reg & BIT(14))
> +
> +#define RK3568_BIFURCATION_LANE_0_1		BIT(0)
>   
>   /**
>    * struct rockchip_p3phy_priv - RK DW PCIe PHY state
> @@ -27,12 +34,16 @@
>    * @phy_grf: The regmap for controlling pipe signal
>    * @p30phy: The reset signal for PHY
>    * @clks: The clocks for PHY
> + * @num_lanes: The number of lane to controller mappings
> + * @lanes: The lane to controller mapping
>    */
>   struct rockchip_p3phy_priv {
>   	void __iomem *mmio;
>   	struct regmap *phy_grf;
>   	struct reset_ctl p30phy;
>   	struct clk_bulk clks;
> +	int num_lanes;
> +	u32 lanes[4];
>   };
>   
>   struct rockchip_p3phy_ops {
> @@ -42,15 +53,40 @@ struct rockchip_p3phy_ops {
>   static int rockchip_p3phy_rk3568_init(struct phy *phy)
>   {
>   	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
> +	bool bifurcation = false;
> +	int ret;
> +	u32 reg;
>   
>   	/* Deassert PCIe PMA output clamp mode */
> -	regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON9,
> -		     (0x1 << 15) | (0x1 << 31));
> +	regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON9, GRF_PCIE30PHY_DA_OCM);
> +
> +	for (int i = 0; i < priv->num_lanes; i++) {
> +		if (priv->lanes[i] > 1)
> +			bifurcation = true;
> +	}
> +
> +	/* Set bifurcation if needed, and it doesn't care RC/EP */
> +	if (bifurcation) {
> +		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON6,
> +			     GRF_PCIE30PHY_WR_EN | RK3568_BIFURCATION_LANE_0_1);
> +		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON1,
> +			     GRF_PCIE30PHY_DA_OCM);
> +	} else {
> +		regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON6,
> +			     GRF_PCIE30PHY_WR_EN & ~RK3568_BIFURCATION_LANE_0_1);
> +	}
>   
>   	reset_deassert(&priv->p30phy);
>   	udelay(1);
>   
> -	return 0;
> +	ret = regmap_read_poll_timeout(priv->phy_grf,
> +				       GRF_PCIE30PHY_STATUS0,
> +				       reg, SRAM_INIT_DONE(reg),
> +				       0, 500);
> +	if (ret)
> +		dev_err(phy->dev, "lock failed 0x%x\n", reg);
> +
> +	return ret;
>   }
>   
>   static const struct rockchip_p3phy_ops rk3568_ops = {
> @@ -103,6 +139,23 @@ static int rockchip_p3phy_probe(struct udevice *dev)
>   		return PTR_ERR(priv->phy_grf);
>   	}
>   
> +	ret = dev_read_size(dev, "data-lanes");
> +	if (ret > 0) {
> +		priv->num_lanes = ret / sizeof(u32);
> +		if (priv->num_lanes < 2 ||
> +		    priv->num_lanes > ARRAY_SIZE(priv->lanes)) {
> +			dev_err(dev, "unsupported data-lanes property size\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = dev_read_u32_array(dev, "data-lanes", priv->lanes,
> +					 priv->num_lanes);
> +		if (ret) {
> +			dev_err(dev, "failed to read data-lanes property\n");
> +			return ret;
> +		}
> +	}
> +
>   	ret = reset_get_by_name(dev, "phy", &priv->p30phy);
>   	if (ret) {
>   		dev_err(dev, "no phy reset control specified\n");
