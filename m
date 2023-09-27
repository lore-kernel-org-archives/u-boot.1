Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE3DE7F150
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C28C686CC9;
	Wed, 27 Sep 2023 04:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eOcgMsAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B31086D56; Wed, 27 Sep 2023 04:46:38 +0200 (CEST)
Received: from mail-m121146.qiye.163.com (mail-m121146.qiye.163.com
 [115.236.121.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD69805CA
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=eOcgMsAJxpe6c0x6TWWg+tJahHnUb0IIVdt0H8ORlx8Srd1LCYWk8h56Q/BdLVFdaZGYlbf95nzvOO/tqaBKnOVCPJ7N1RrP46UkkQvdM4gf5KUfJ2DAr11/v9ul124kUjgEbTQVrT+M33lLvxHeekf52MXNZNhUi+W+ILboft0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=U/7zVkqaObjEh3O7YBEVqRzkXxnjFR71jA9+S9+yDo4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 1F6DA40020B;
 Wed, 27 Sep 2023 10:46:27 +0800 (CST)
Message-ID: <2039dff9-ec4f-5afb-93f9-bd5dc67bf1da@rock-chips.com>
Date: Wed, 27 Sep 2023 10:46:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/7] phy: rockchip: snps-pcie3: Refactor to use a
 phy_init ops
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jon Lin <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <20230802190424.2963185-4-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230802190424.2963185-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9OSFZPH0tLHxlIGkIZHkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad487d9322eb3kusn1f6da40020b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NFE6Kjo*NTw4PjY#PFEKCR4O
 MCEKFE5VSlVKTUJOTENJTENMQktKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPS0xONwY+
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
> Add a phy_init ops in preparation for upcoming support of a RK3588
> variant in the driver.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
>
>   .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 40 +++++++++++++++----
>   1 file changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> index 3053543a3329..b76b5386bef0 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -35,8 +35,32 @@ struct rockchip_p3phy_priv {
>   	struct clk_bulk clks;
>   };
>   
> +struct rockchip_p3phy_ops {
> +	int (*phy_init)(struct phy *phy);
> +};
> +
> +static int rockchip_p3phy_rk3568_init(struct phy *phy)
> +{
> +	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
> +
> +	/* Deassert PCIe PMA output clamp mode */
> +	regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON9,
> +		     (0x1 << 15) | (0x1 << 31));
> +
> +	reset_deassert(&priv->p30phy);
> +	udelay(1);
> +
> +	return 0;
> +}
> +
> +static const struct rockchip_p3phy_ops rk3568_ops = {
> +	.phy_init = rockchip_p3phy_rk3568_init,
> +};
> +
>   static int rochchip_p3phy_init(struct phy *phy)
>   {
> +	struct rockchip_p3phy_ops *ops =
> +		(struct rockchip_p3phy_ops *)dev_get_driver_data(phy->dev);
>   	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
>   	int ret;
>   
> @@ -47,14 +71,11 @@ static int rochchip_p3phy_init(struct phy *phy)
>   	reset_assert(&priv->p30phy);
>   	udelay(1);
>   
> -	/* Deassert PCIe PMA output clamp mode */
> -	regmap_write(priv->phy_grf, GRF_PCIE30PHY_CON9,
> -		     (0x1 << 15) | (0x1 << 31));
> -
> -	reset_deassert(&priv->p30phy);
> -	udelay(1);
> +	ret = ops->phy_init(phy);
> +	if (ret)
> +		clk_disable_bulk(&priv->clks);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int rochchip_p3phy_exit(struct phy *phy)
> @@ -103,7 +124,10 @@ static struct phy_ops rochchip_p3phy_ops = {
>   };
>   
>   static const struct udevice_id rockchip_p3phy_of_match[] = {
> -	{ .compatible = "rockchip,rk3568-pcie3-phy" },
> +	{
> +		.compatible = "rockchip,rk3568-pcie3-phy",
> +		.data = (ulong)&rk3568_ops,
> +	},
>   	{ },
>   };
>   
