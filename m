Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6971ECA0EFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 16:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0510C838EE;
	Sat, 30 Aug 2025 18:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ey4aSI4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 910CE838EE; Sat, 30 Aug 2025 18:46:32 +0200 (CEST)
Received: from mail-m2437.xmail.ntesmail.com (mail-m2437.xmail.ntesmail.com
 [45.195.24.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB424838E0
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 18:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2124a625b;
 Sun, 31 Aug 2025 00:46:25 +0800 (GMT+08:00)
Message-ID: <8a30ee7a-ec6f-4df7-81ff-edaa6601572c@rock-chips.com>
Date: Sun, 31 Aug 2025 00:46:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] phy: rockchip: naneng-combphy: Use
 syscon_regmap_lookup_by_phandle
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250721220734.1617117-1-jonas@kwiboo.se>
 <20250721220734.1617117-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250721220734.1617117-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fbdf81b703afkunmc49eda2d42cf17
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUJCVklJGUtISksYSU8aTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Ey4aSI4wZsyipVNXgUpQzwBoF1kzTZW2FqmP0XkgEN8KLcxjnMGUb2kv+MnkAcEEOLqEZKGdE/iexTwNxn/vPVT/9TNnvJQ1Wj2dC34y3v6vRy2qd8tmroOA8PXEiONUth4qWIfdXOKExx5u76ZQuqxIbLNSoIBMKQquI8Nk2Qc=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=1dwvk/xv9G3LGyKy2UAAWuPcauI6nMquhoKVcLY62a0=;
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


On 2025/7/22 06:07, Jonas Karlman wrote:
> Change to use syscon_regmap_lookup_by_phandle() helper instead of
> finding the syscon udevice and making a call to syscon_get_regmap().
>
> No runtime change is expected with this simplication.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../phy/rockchip/phy-rockchip-naneng-combphy.c  | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index f246c8db2d6c..7f107a11606b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -175,22 +175,19 @@ static const struct phy_ops rockchip_combphy_ops = {
>   static int rockchip_combphy_parse_dt(struct udevice *dev,
>   				     struct rockchip_combphy_priv *priv)
>   {
> -	struct udevice *syscon;
>   	int ret;
>   
> -	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "rockchip,pipe-grf", &syscon);
> -	if (ret) {
> -		dev_err(dev, "failed to find peri_ctrl pipe-grf regmap");
> -		return ret;
> +	priv->pipe_grf = syscon_regmap_lookup_by_phandle(dev, "rockchip,pipe-grf");
> +	if (IS_ERR(priv->pipe_grf)) {
> +		dev_err(dev, "failed to find peri_ctrl pipe-grf regmap\n");
> +		return PTR_ERR(priv->pipe_grf);
>   	}
> -	priv->pipe_grf = syscon_get_regmap(syscon);
>   
> -	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "rockchip,pipe-phy-grf", &syscon);
> -	if (ret) {
> +	priv->phy_grf = syscon_regmap_lookup_by_phandle(dev, "rockchip,pipe-phy-grf");
> +	if (IS_ERR(priv->phy_grf)) {
>   		dev_err(dev, "failed to find peri_ctrl pipe-phy-grf regmap\n");
> -		return ret;
> +		return PTR_ERR(priv->phy_grf);
>   	}
> -	priv->phy_grf = syscon_get_regmap(syscon);
>   
>   	ret = clk_get_by_index(dev, 0, &priv->ref_clk);
>   	if (ret) {
