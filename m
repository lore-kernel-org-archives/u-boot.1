Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A2ECA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC010836B2;
	Sat, 30 Aug 2025 16:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AuYVzy2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F085C836CE; Sat, 30 Aug 2025 16:22:39 +0200 (CEST)
Received: from mail-m32122.qiye.163.com (mail-m32122.qiye.163.com
 [220.197.32.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B8C83542
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 212376850;
 Sat, 30 Aug 2025 22:22:31 +0800 (GMT+08:00)
Message-ID: <203dac55-43e2-4872-a653-0132714ab6d6@rock-chips.com>
Date: Sat, 30 Aug 2025 22:22:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: rockchip-inno-usb2: Fix Synchronous Abort on
 usb start
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250703060517.3909695-1-alexthreed@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250703060517.3909695-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98fb5bc17403afkunme5396daa40346d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSExDVktNSB9PQkxPHUlPSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=AuYVzy2tc4bW9IVhbHd4oBHzCeY5M2kRzbWt5fV/A0pgmC0Vp32+SAW6HxeWAwaEiRTwQQTX6rriQB1vhkiyQ1YkW3wEUkrsR6oG03rZIsPmuFDBsDJgnmwoYn2o5NxNuIS4Us9naL6dQ94uoVICQ01Zz8hikO7jAgfGp0d4Nvs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=vuBfGHfNqooYlZddG6yI+RKdFUWVYzFJ503FnMTmsx8=;
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


On 2025/7/3 14:04, Alex Shumsky wrote:
> Fix NULL pointer dereference that happen when rockchip-inno-usb2 clock
> enabled before device probe. This early clock enable call happen in process
> of parent clock activation added in ac30d90f3367.
>
> Fixes: 229218373c22 ("phy: rockchip-inno-usb2: Add support for clkout_ctl_phy").
> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
> Co-authored-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> Changes in v2:
> - rework patch (add NULL check to code instead of dts modification)
>
>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 88b33de1b2..3cc5956aed 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -167,20 +167,27 @@ static struct phy_ops rockchip_usb2phy_ops = {
>   	.of_xlate = rockchip_usb2phy_of_xlate,
>   };
>   
> -static void rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap **base,
> -					const struct usb2phy_reg **clkout_ctl)
> +static int rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap **base,
> +				       const struct usb2phy_reg **clkout_ctl)
>   {
>   	struct udevice *parent = dev_get_parent(clk->dev);
>   	struct rockchip_usb2phy *priv = dev_get_priv(parent);
>   	const struct rockchip_usb2phy_cfg *phy_cfg = priv->phy_cfg;
>   
> -	if (priv->phy_cfg->clkout_ctl_phy.enable) {
> +	// phy_cfg can be NULL if this function called before probe (when parent
> +	// clocks are enabled)
> +	if (!phy_cfg)
> +		return -EINVAL;
> +
> +	if (phy_cfg->clkout_ctl_phy.enable) {
>   		*base = priv->phy_base;
>   		*clkout_ctl = &phy_cfg->clkout_ctl_phy;
>   	} else {
>   		*base = priv->reg_base;
>   		*clkout_ctl = &phy_cfg->clkout_ctl;
>   	}
> +
> +	return 0;
>   }
>   
>   /**
> @@ -206,7 +213,8 @@ int rockchip_usb2phy_clk_enable(struct clk *clk)
>   	const struct usb2phy_reg *clkout_ctl;
>   	struct regmap *base;
>   
> -	rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
> +	if (rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl))
> +		return -ENOSYS;
>   
>   	/* turn on 480m clk output if it is off */
>   	if (!property_enabled(base, clkout_ctl)) {
> @@ -230,7 +238,8 @@ int rockchip_usb2phy_clk_disable(struct clk *clk)
>   	const struct usb2phy_reg *clkout_ctl;
>   	struct regmap *base;
>   
> -	rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
> +	if (rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl))
> +		return -ENOSYS;
>   
>   	/* turn off 480m clk output */
>   	property_enable(base, clkout_ctl, false);

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

