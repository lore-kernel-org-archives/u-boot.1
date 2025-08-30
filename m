Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F13CCA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CA9838B7;
	Sat, 30 Aug 2025 16:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="E0ISerRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326CE838DD; Sat, 30 Aug 2025 16:57:33 +0200 (CEST)
Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com
 [45.254.49.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E81838D5
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2123c4c79;
 Sat, 30 Aug 2025 22:57:26 +0800 (GMT+08:00)
Message-ID: <426ef869-2e86-47c9-86c1-94e25dee65a0@rock-chips.com>
Date: Sat, 30 Aug 2025 22:57:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] phy: rockchip: naneng-combphy: Add support for
 RK3576
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 u-boot@lists.denx.de, Jon Lin <jon.lin@rock-chips.com>
References: <20250801204345.2603723-1-jonas@kwiboo.se>
 <20250801204345.2603723-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250801204345.2603723-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb7bbb3b03afkunm06da06bc40d81a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHklMVkhCGh9PSkwZTh4aH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=E0ISerRQKAdK+Td59/yrOXqYW81vzbXXhepIhXd+PcTeIGoPojI2KnCh5fIExf2thi2hD1fDDK/19RRZiFIZV7vL+/XRI6T0CovkB3qRP78V3G6+g62mEXSBsDBIXV3XtuNmntuv5jIFgpKx13mit1b2leX84g78fhSV2XRDErY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=veZoTHjZseSNizg1hqe3gJVG9ecJK5BeOxEN2JHUDFY=;
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


On 2025/8/2 04:43, Jonas Karlman wrote:
> From: Jon Lin <jon.lin@rock-chips.com>
>
> Add support for the PCIe/USB3/SATA combo PHYs used in the RK3576 SoC.
>
> Config values are taken from vendor U-Boot linux-6.1-stan-rkr5 tag.
>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: Ensure USB3OTG U3 port is enabled when USB3 PHY is used
> v2: New patch
>
> I have only verified that the PCIe and USB3 mode config works.
> ---
>   .../rockchip/phy-rockchip-naneng-combphy.c    | 147 ++++++++++++++++++
>   1 file changed, 147 insertions(+)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 7f107a11606b..8c116882ecfb 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -388,6 +388,149 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
>   	.combphy_cfg	= rk3568_combphy_cfg,
>   };
>   
> +static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	u32 val;
> +
> +	switch (priv->mode) {
> +	case PHY_TYPE_PCIE:
> +		param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
> +		param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
> +		param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
> +		param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;
> +	case PHY_TYPE_USB3:
> +		/* Set SSC downward spread spectrum */
> +		val = readl(priv->mmio + (0x1f << 2));
> +		val &= ~GENMASK(5, 4);
> +		val |= 0x01 << 4;
> +		writel(val, priv->mmio + 0x7c);
> +
> +		/* Enable adaptive CTLE for USB3.0 Rx */
> +		val = readl(priv->mmio + (0x0e << 2));
> +		val &= ~GENMASK(0, 0);
> +		val |= 0x01;
> +		writel(val, priv->mmio + (0x0e << 2));
> +
> +		/* Set PLL KVCO fine tuning signals */
> +		val = readl(priv->mmio + (0x20 << 2));
> +		val &= ~(0x7 << 2);
> +		val |= 0x2 << 2;
> +		writel(val, priv->mmio + (0x20 << 2));
> +
> +		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
> +		writel(0x4, priv->mmio + (0xb << 2));
> +
> +		/* Set PLL input clock divider 1/2 */
> +		val = readl(priv->mmio + (0x5 << 2));
> +		val &= ~(0x3 << 6);
> +		val |= 0x1 << 6;
> +		writel(val, priv->mmio + (0x5 << 2));
> +
> +		/* Set PLL loop divider */
> +		writel(0x32, priv->mmio + (0x11 << 2));
> +
> +		/* Set PLL KVCO to min and set PLL charge pump current to max */
> +		writel(0xf0, priv->mmio + (0xa << 2));
> +
> +		/* Set Rx squelch input filler bandwidth */
> +		writel(0x0d, priv->mmio + (0x14 << 2));
> +
> +		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> +		param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
> +		param_write(priv->phy_grf, &cfg->usb_mode_set, true);
> +		param_write(priv->pipe_grf, &cfg->u3otg1_port_en, true);
> +		break;
> +	case PHY_TYPE_SATA:
> +		/* Enable adaptive CTLE for SATA Rx */
> +		val = readl(priv->mmio + (0x0e << 2));
> +		val &= ~GENMASK(0, 0);
> +		val |= 0x01;
> +		writel(val, priv->mmio + (0x0e << 2));
> +		/* Set tx_rterm = 50 ohm and rx_rterm = 43.5 ohm */
> +		writel(0x8F, priv->mmio + (0x06 << 2));
> +
> +		param_write(priv->phy_grf, &cfg->con0_for_sata, true);
> +		param_write(priv->phy_grf, &cfg->con1_for_sata, true);
> +		param_write(priv->phy_grf, &cfg->con2_for_sata, true);
> +		param_write(priv->phy_grf, &cfg->con3_for_sata, true);
> +		param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
> +		param_write(priv->pipe_grf, &cfg->pipe_con1_for_sata, true);
> +		break;
> +	case PHY_TYPE_SGMII:
> +	case PHY_TYPE_QSGMII:
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	/* 100MHz refclock signal is good */
> +	clk_set_rate(&priv->ref_clk, 100000000);
> +	param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
> +	if (priv->mode == PHY_TYPE_PCIE) {
> +		/* gate_tx_pck_sel length select work for L1SS */
> +		writel(0xc0, priv->mmio + 0x74);
> +
> +		/* PLL KVCO tuning fine */
> +		val = readl(priv->mmio + (0x20 << 2));
> +		val &= ~(0x7 << 2);
> +		val |= 0x2 << 2;
> +		writel(val, priv->mmio + (0x20 << 2));
> +
> +		/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
> +		writel(0x4c, priv->mmio + (0x1b << 2));
> +
> +		/* Set up su_trim: T3_P1 650mv */
> +		writel(0x90, priv->mmio + (0xa << 2));
> +		writel(0x43, priv->mmio + (0xb << 2));
> +		writel(0x88, priv->mmio + (0xc << 2));
> +		writel(0x56, priv->mmio + (0xd << 2));
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rockchip_combphy_grfcfg rk3576_combphy_grfcfgs = {
> +	/* pipe-phy-grf */
> +	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
> +	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
> +	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
> +	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
> +	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
> +	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
> +	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
> +	.pipe_phymode_sel	= { 0x0008, 1, 1, 0x00, 0x01 },
> +	.pipe_rate_sel		= { 0x0008, 2, 2, 0x00, 0x01 },
> +	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
> +	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
> +	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
> +	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
> +	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
> +	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
> +	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
> +	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
> +	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
> +	.con0_for_sata		= { 0x0000, 15, 0, 0x00, 0x0129 },
> +	.con1_for_sata		= { 0x0004, 15, 0, 0x00, 0x0000 },
> +	.con2_for_sata		= { 0x0008, 15, 0, 0x00, 0x80c1 },
> +	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x0407 },
> +	/* php-grf */
> +	.pipe_con0_for_sata	= { 0x001C, 2, 0, 0x00, 0x2 },
> +	.pipe_con1_for_sata	= { 0x0020, 2, 0, 0x00, 0x2 },
> +	.u3otg1_port_en		= { 0x0038, 15, 0, 0x0181, 0x1100 },
> +};
> +
> +static const struct rockchip_combphy_cfg rk3576_combphy_cfgs = {
> +	.num_phys = 2,
> +	.phy_ids = {
> +		0x2b050000,
> +		0x2b060000,
> +	},
> +	.grfcfg		= &rk3576_combphy_grfcfgs,
> +	.combphy_cfg	= rk3576_combphy_cfg,
> +};
> +
>   static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
>   {
>   	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> @@ -499,6 +642,10 @@ static const struct udevice_id rockchip_combphy_ids[] = {
>   		.compatible = "rockchip,rk3568-naneng-combphy",
>   		.data = (ulong)&rk3568_combphy_cfgs
>   	},
> +	{
> +		.compatible = "rockchip,rk3576-naneng-combphy",
> +		.data = (ulong)&rk3576_combphy_cfgs
> +	},
>   	{
>   		.compatible = "rockchip,rk3588-naneng-combphy",
>   		.data = (ulong)&rk3588_combphy_cfgs
