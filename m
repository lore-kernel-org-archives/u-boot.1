Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E36CA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 15:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F58A838AE;
	Sat, 30 Aug 2025 17:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FX+xvRMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B64B836B2; Sat, 30 Aug 2025 17:25:14 +0200 (CEST)
Received: from mail-m49246.qiye.163.com (mail-m49246.qiye.163.com
 [45.254.49.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A07A838A5
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 17:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123f98a2;
 Sat, 30 Aug 2025 23:25:08 +0800 (GMT+08:00)
Message-ID: <9fa8a617-cd61-4ca4-89ef-1425ff32fad4@rock-chips.com>
Date: Sat, 30 Aug 2025 23:25:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] phy: rockchip: naneng-combphy: Add support for RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jianwei Zheng <jianwei.zheng@rock-chips.com>
References: <20250730235301.1774089-1-jonas@kwiboo.se>
 <20250730235301.1774089-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250730235301.1774089-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb9516fb03afkunmfa59d8a241579b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTUxKVkxPQ0JNGEpMGElCTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=FX+xvRMHRedW0Sa2n87K+KMYjB9vXyWcVYGJw1LhywQHTQPscGolwjx35qSng7BU2ay/wyis52iToE9kNZpK3gUL5yk4iq8LzYnDS5rbJwP6ufte1w+kNEWsqXnSJwCPfyEkUJGgorM40XZ6Igk8wh0ICYMyWoUxbR//45acQyQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=TrE0fh8yL7YX6g5LqL5ysPO2r/5XuCV3za6XbS85nbs=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/7/31 07:52, Jonas Karlman wrote:
> From: Jianwei Zheng <jianwei.zheng@rock-chips.com>
>
> Add support for the PCIe/USB3 combo PHY used in the RK3528 SoC.
>
> Config values are taken from vendor U-Boot linux-6.1-stan-rkr5 tag.
>
> Signed-off-by: Jianwei Zheng <jianwei.zheng@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../rockchip/phy-rockchip-naneng-combphy.c    | 102 ++++++++++++++++++
>   1 file changed, 102 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 81195de60bc6..432a8f8e03a0 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -37,6 +37,7 @@ struct rockchip_combphy_grfcfg {
>   	struct combphy_reg pipe_rxterm_set;
>   	struct combphy_reg pipe_txelec_set;
>   	struct combphy_reg pipe_txcomp_set;
> +	struct combphy_reg pipe_clk_24m;
>   	struct combphy_reg pipe_clk_25m;
>   	struct combphy_reg pipe_clk_100m;
>   	struct combphy_reg pipe_phymode_sel;
> @@ -245,6 +246,103 @@ static int rockchip_combphy_probe(struct udevice *udev)
>   	return rockchip_combphy_parse_dt(udev, priv);
>   }
>   
> +static int rk3528_combphy_cfg(struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	u32 val;
> +
> +	switch (priv->mode) {
> +	case PHY_TYPE_PCIE:
> +		/* Set SSC downward spread spectrum */
> +		val = readl(priv->mmio + 0x18);
> +		val &= ~GENMASK(5, 4);
> +		val |= 0x01 << 4;
> +		writel(val, priv->mmio + 0x18);
> +
> +		param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
> +		param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
> +		param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
> +		param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;
> +	case PHY_TYPE_USB3:
> +		/* Set SSC downward spread spectrum */
> +		val = readl(priv->mmio + 0x18);
> +		val &= ~GENMASK(5, 4);
> +		val |= 0x01 << 4;
> +		writel(val, priv->mmio + 0x18);
> +
> +		/* Enable adaptive CTLE for USB3.0 Rx */
> +		val = readl(priv->mmio + 0x200);
> +		val &= ~GENMASK(17, 17);
> +		val |= 0x01 << 17;
> +		writel(val, priv->mmio + 0x200);
> +
> +		/* Set Rx squelch input filler bandwidth */
> +		val = readl(priv->mmio + 0x20c);
> +		val &= ~GENMASK(2, 0);
> +		val |= 0x06;
> +		writel(val, priv->mmio + 0x20c);
> +
> +		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> +		param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
> +		param_write(priv->phy_grf, &cfg->usb_mode_set, true);
> +		param_write(priv->pipe_grf, &cfg->u3otg0_port_en, true);
> +		break;
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
> +
> +	if (priv->mode == PHY_TYPE_PCIE) {
> +		/* PLL KVCO tuning fine */
> +		val = readl(priv->mmio + 0x18);
> +		val &= ~(0x7 << 10);
> +		val |= 0x2 << 10;
> +		writel(val, priv->mmio + 0x18);
> +
> +		/* su_trim[6:4]=111, [10:7]=1001, [2:0]=000 */
> +		val = readl(priv->mmio + 0x108);
> +		val &= ~(0x7f7);
> +		val |= 0x4f0;
> +		writel(val, priv->mmio + 0x108);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rockchip_combphy_grfcfg rk3528_combphy_grfcfgs = {
> +	/* pipe-phy-grf */
> +	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
> +	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
> +	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
> +	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
> +	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
> +	.pipe_clk_24m		= { 0x0004, 14, 13, 0x00, 0x00 },
> +	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
> +	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
> +	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
> +	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
> +	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
> +	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
> +	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x110 },
> +	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x00 },
> +	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x101 },
> +	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
> +	/* pipe-grf */
> +	.u3otg0_port_en		= { 0x0044, 15, 0, 0x0181, 0x1100 },
> +};
> +
> +static const struct rockchip_combphy_cfg rk3528_combphy_cfgs = {
> +	.num_phys = 1,
> +	.phy_ids = {
> +		0xffdc0000,
> +	},
> +	.grfcfg		= &rk3528_combphy_grfcfgs,
> +	.combphy_cfg	= rk3528_combphy_cfg,
> +};
> +
>   static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
>   {
>   	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> @@ -503,6 +601,10 @@ static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
>   };
>   
>   static const struct udevice_id rockchip_combphy_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3528-naneng-combphy",
> +		.data = (ulong)&rk3528_combphy_cfgs
> +	},
>   	{
>   		.compatible = "rockchip,rk3568-naneng-combphy",
>   		.data = (ulong)&rk3568_combphy_cfgs
