Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC34C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 06:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8158788675;
	Mon, 15 Jul 2024 08:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dSpN//Ok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A7FA88669; Mon, 15 Jul 2024 08:49:28 +0200 (CEST)
Received: from mail-m3298.qiye.163.com (mail-m3298.qiye.163.com
 [220.197.32.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E21288675
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 08:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dSpN//Ok71m0GOUxtldCn/rL1XbR0uHGdmu+NT+ISkZ7A2t/Ww1NaY2PR2b71X++9nrhRD6g6rrq3EWiSYqmFcYan4Crngxg1NWWmTwJYMg/119eXrRZ0nDO9pbnTiZDVCjDDxlNXJke8aDx6MsywEqrX/z+ujf6qGumji6WYIs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Wtqlx0WpTziGQeVan878TSYF8QNonyCSvpJ1dy7iETw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 949269004EA;
 Mon, 15 Jul 2024 14:49:14 +0800 (CST)
Message-ID: <37be1409-e4ab-4c15-8671-eb3ca2163d27@rock-chips.com>
Date: Mon, 15 Jul 2024 14:49:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] phy: rockchip: snps-pcie3: Fix bifurcation for RK3588
To: Sebastian Kropatsch <seb-dev@mail.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <cover.1720988760.git.seb-dev@mail.de>
 <202cee2c0425e64a4d0e8d0f02d16584b75a1016.1720988760.git.seb-dev@mail.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <202cee2c0425e64a4d0e8d0f02d16584b75a1016.1720988760.git.seb-dev@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgdQ1ZNGEMZHR4dGhpMQ09WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b527116c03a9kunm949269004ea
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBQ6Lio5KjI0LiEzMDEeIVYc
 HxUKCxhVSlVKTElKS0lNSk5OT0NMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPS0NLNwY+
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


On 2024/7/15 05:23, Sebastian Kropatsch wrote:
> Misconfigured `PHP_GRF_PCIESEL` values are causing bifurcation issues,
> for example on the FriendlyElec CM3588 NAS board which uses bifurcation
> on both PCIe PCIe ports (all four lanes) to enable four M.2 NVMe
> sockets. Without this fix, NVMe devices do not get recognized.
>
> Correct the `PHP_GRF_PCIESEL` register configuration and simplify the
> bifurcation logic, enabling proper PCIe bifurcation based on the
> data-lanes property.
>
> This fix is adapted from the upstream Linux commit by Michal Tomek:
> f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588")
>
> Fixes: 50e54e80679b ("phy: rockchip: snps-pcie3: Add support for RK3588")
> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 24 +++++++------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> index 1c94875aaa..fadb77c25c 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -108,7 +108,7 @@ static int rockchip_p3phy_rk3588_init(struct phy *phy)
>   {
>   	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
>   	u32 reg = 0;
> -	u8 mode = 0;
> +	u8 mode = RK3588_LANE_AGGREGATION; /* Lane aggregation by default */
>   	int ret;
>   
>   	/* Deassert PCIe PMA output clamp mode */
> @@ -117,28 +117,20 @@ static int rockchip_p3phy_rk3588_init(struct phy *phy)
>   
>   	/* Set bifurcation if needed */
>   	for (int i = 0; i < priv->num_lanes; i++) {
> -		if (!priv->lanes[i])
> -			mode |= (BIT(i) << 3);
> -
>   		if (priv->lanes[i] > 1)
> -			mode |= (BIT(i) >> 1);
> -	}
> -
> -	if (!mode) {
> -		reg = RK3588_LANE_AGGREGATION;
> -	} else {
> -		if (mode & (BIT(0) | BIT(1)))
> -			reg |= RK3588_BIFURCATION_LANE_0_1;
> -
> -		if (mode & (BIT(2) | BIT(3)))
> -			reg |= RK3588_BIFURCATION_LANE_2_3;
> +			mode &= ~RK3588_LANE_AGGREGATION;
> +		if (priv->lanes[i] == 3)
> +			mode |= RK3588_BIFURCATION_LANE_0_1;
> +		if (priv->lanes[i] == 4)
> +			mode |= RK3588_BIFURCATION_LANE_2_3;
>   	}
>   
> +	reg = mode;
>   	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
>   		     (0x7 << 16) | reg);
>   
>   	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
> -	reg = (mode & (BIT(6) | BIT(7))) >> 6;
> +	reg = mode & 3;
>   	if (reg)
>   		regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
>   			     (reg << 16) | reg);
