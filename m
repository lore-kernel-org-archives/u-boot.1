Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9349E7F150
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5661D86AF7;
	Wed, 27 Sep 2023 04:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DTLMJsDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB94D86D4A; Wed, 27 Sep 2023 04:45:53 +0200 (CEST)
Received: from mail-m12785.qiye.163.com (mail-m12785.qiye.163.com
 [115.236.127.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F8E786AF7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=DTLMJsDZLA2eKiOPBlpvxYdUJH9bC9F35aYKhKEarnMAI8JYEbvf0hEiYpPckqAh7hFEtKahL0Jwia9lojshSTbBJBpkNWyAODslPNv7jI8hFPl6r24Hiz2GONnpdYf4eOURU5xGrfaeNDidXibnLiRNGNHeOh9d8vXN+CyPkyM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=X2S8mmYn83mUlW8sYbybEilm8YwFNVK/mv/uTZnP7Vc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 181944002A5;
 Wed, 27 Sep 2023 10:45:47 +0800 (CST)
Message-ID: <090ac839-fb28-a5b9-09c6-406bc8d4ae9f@rock-chips.com>
Date: Wed, 27 Sep 2023 10:45:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/7] phy: rockchip: snps-pcie3: Refactor to use
 clk_bulk API
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jon Lin <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <20230802190424.2963185-3-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230802190424.2963185-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxNTFZKT05NQ0lJSEpCGk5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad4873d292eb3kusn181944002a5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjI6TBw*Qjw8GDYoLEseCktP
 DiswCSJVSlVKTUJOTENJTE9DS0lOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTExINwY+
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
> Change to use clk_bulk API and syscon_regmap_lookup_by_phandle to
> simplify in preparation for upcoming support of a RK3588 variant.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - No change
>
>   .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 58 +++----------------
>   1 file changed, 9 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> index 66c75f98e6d1..3053543a3329 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -26,17 +26,13 @@
>    * @mmio: The base address of PHY internal registers
>    * @phy_grf: The regmap for controlling pipe signal
>    * @p30phy: The reset signal for PHY
> - * @ref_clk_m: The reference clock of M for PHY
> - * @ref_clk_n: The reference clock of N for PHY
> - * @pclk: The clock for accessing PHY blocks
> + * @clks: The clocks for PHY
>    */
>   struct rockchip_p3phy_priv {
>   	void __iomem *mmio;
>   	struct regmap *phy_grf;
>   	struct reset_ctl p30phy;
> -	struct clk ref_clk_m;
> -	struct clk ref_clk_n;
> -	struct clk pclk;
> +	struct clk_bulk clks;
>   };
>   
>   static int rochchip_p3phy_init(struct phy *phy)
> @@ -44,18 +40,10 @@ static int rochchip_p3phy_init(struct phy *phy)
>   	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
>   	int ret;
>   
> -	ret = clk_enable(&priv->ref_clk_m);
> -	if (ret < 0 && ret != -ENOSYS)
> +	ret = clk_enable_bulk(&priv->clks);
> +	if (ret)
>   		return ret;
>   
> -	ret = clk_enable(&priv->ref_clk_n);
> -	if (ret < 0 && ret != -ENOSYS)
> -		goto err_ref;
> -
> -	ret = clk_enable(&priv->pclk);
> -	if (ret < 0 && ret != -ENOSYS)
> -		goto err_pclk;
> -
>   	reset_assert(&priv->p30phy);
>   	udelay(1);
>   
> @@ -67,21 +55,13 @@ static int rochchip_p3phy_init(struct phy *phy)
>   	udelay(1);
>   
>   	return 0;
> -err_pclk:
> -	clk_disable(&priv->ref_clk_n);
> -err_ref:
> -	clk_disable(&priv->ref_clk_m);
> -
> -	return ret;
>   }
>   
>   static int rochchip_p3phy_exit(struct phy *phy)
>   {
>   	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
>   
> -	clk_disable(&priv->ref_clk_m);
> -	clk_disable(&priv->ref_clk_n);
> -	clk_disable(&priv->pclk);
> +	clk_disable_bulk(&priv->clks);
>   	reset_assert(&priv->p30phy);
>   
>   	return 0;
> @@ -90,21 +70,13 @@ static int rochchip_p3phy_exit(struct phy *phy)
>   static int rockchip_p3phy_probe(struct udevice *dev)
>   {
>   	struct rockchip_p3phy_priv *priv = dev_get_priv(dev);
> -	struct udevice *syscon;
>   	int ret;
>   
>   	priv->mmio = dev_read_addr_ptr(dev);
>   	if (!priv->mmio)
>   		return -EINVAL;
>   
> -	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
> -					   "rockchip,phy-grf",  &syscon);
> -	if (ret) {
> -		pr_err("unable to find syscon device for rockchip,phy-grf\n");
> -		return ret;
> -	}
> -
> -	priv->phy_grf = syscon_get_regmap(syscon);
> +	priv->phy_grf = syscon_regmap_lookup_by_phandle(dev, "rockchip,phy-grf");
>   	if (IS_ERR(priv->phy_grf)) {
>   		dev_err(dev, "failed to find rockchip,phy_grf regmap\n");
>   		return PTR_ERR(priv->phy_grf);
> @@ -116,22 +88,10 @@ static int rockchip_p3phy_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> -	ret = clk_get_by_name(dev, "refclk_m", &priv->ref_clk_m);
> +	ret = clk_get_bulk(dev, &priv->clks);
>   	if (ret) {
> -		dev_err(dev, "failed to find ref clock M\n");
> -		return PTR_ERR(&priv->ref_clk_m);
> -	}
> -
> -	ret = clk_get_by_name(dev, "refclk_n", &priv->ref_clk_n);
> -	if (ret) {
> -		dev_err(dev, "failed to find ref clock N\n");
> -		return PTR_ERR(&priv->ref_clk_n);
> -	}
> -
> -	ret = clk_get_by_name(dev, "pclk", &priv->pclk);
> -	if (ret) {
> -		dev_err(dev, "failed to find pclk\n");
> -		return PTR_ERR(&priv->pclk);
> +		dev_err(dev, "failed to get clocks\n");
> +		return ret;
>   	}
>   
>   	return 0;
