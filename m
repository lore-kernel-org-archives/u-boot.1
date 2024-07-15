Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F99CC3DA45
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 06:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B14886BB;
	Mon, 15 Jul 2024 08:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="W0o0mXCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C047388747; Mon, 15 Jul 2024 08:49:17 +0200 (CEST)
Received: from mail-m49194.qiye.163.com (mail-m49194.qiye.163.com
 [45.254.49.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F9D87E13
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 08:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=W0o0mXCI+IqOsq3ItD7Sv2meJQMZt+heQoQ4RgNcYPgRjSNmNW9crYf9s4TQYsGicYz/vH/ol5Gjg1UUNaLnZEKfkXDxhR7dQrpBqYFEj/QyzVkr8os2LyOmjvQPo+udhzJPg16zKf1gk756ER1AFQujgP1AKGGwCXTBXsrO5R8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=YwPWjTtV/zZIoi7aN24rh/92yjD8bPqIaHeEzNgHqNQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 72DA3900509;
 Mon, 15 Jul 2024 14:49:05 +0800 (CST)
Message-ID: <d7064e79-c193-4672-8384-e315f7598e55@rock-chips.com>
Date: Mon, 15 Jul 2024 14:49:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] phy: rockchip: snps-pcie3: Fix "rockchip" spelling
To: Sebastian Kropatsch <seb-dev@mail.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <cover.1720988760.git.seb-dev@mail.de>
 <6b71eee1acdc0069880755673a4a52194045ad9f.1720988760.git.seb-dev@mail.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <6b71eee1acdc0069880755673a4a52194045ad9f.1720988760.git.seb-dev@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1MGFYYGUxNGUJDGRkYTEhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b526edcd03a9kunm72da3900509
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nkk6CDo6CzI8OiFRTzEyIRRI
 OklPCQpVSlVKTElKS0lNSk9NSEJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT0JCNwY+
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
> Several identifiers use "rochchip" instead of "rockchip".
> Fix this by replacing every instance of "rochchip" with "rockchip".
>
> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> index 2737bd81dd..1c94875aaa 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -164,7 +164,7 @@ static const struct rockchip_p3phy_ops rk3588_ops = {
>   	.phy_init = rockchip_p3phy_rk3588_init,
>   };
>   
> -static int rochchip_p3phy_init(struct phy *phy)
> +static int rockchip_p3phy_init(struct phy *phy)
>   {
>   	struct rockchip_p3phy_ops *ops =
>   		(struct rockchip_p3phy_ops *)dev_get_driver_data(phy->dev);
> @@ -185,7 +185,7 @@ static int rochchip_p3phy_init(struct phy *phy)
>   	return ret;
>   }
>   
> -static int rochchip_p3phy_exit(struct phy *phy)
> +static int rockchip_p3phy_exit(struct phy *phy)
>   {
>   	struct rockchip_p3phy_priv *priv = dev_get_priv(phy->dev);
>   
> @@ -251,9 +251,9 @@ static int rockchip_p3phy_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -static struct phy_ops rochchip_p3phy_ops = {
> -	.init = rochchip_p3phy_init,
> -	.exit = rochchip_p3phy_exit,
> +static struct phy_ops rockchip_p3phy_ops = {
> +	.init = rockchip_p3phy_init,
> +	.exit = rockchip_p3phy_exit,
>   };
>   
>   static const struct udevice_id rockchip_p3phy_of_match[] = {
> @@ -272,7 +272,7 @@ U_BOOT_DRIVER(rockchip_pcie3phy) = {
>   	.name		= "rockchip_pcie3phy",
>   	.id		= UCLASS_PHY,
>   	.of_match	= rockchip_p3phy_of_match,
> -	.ops		= &rochchip_p3phy_ops,
> +	.ops		= &rockchip_p3phy_ops,
>   	.probe		= rockchip_p3phy_probe,
>   	.priv_auto	= sizeof(struct rockchip_p3phy_priv),
>   };
