Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FBFC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 06:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC8A88677;
	Mon, 15 Jul 2024 08:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="X6B+inpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5764A8867C; Mon, 15 Jul 2024 08:49:11 +0200 (CEST)
Received: from mail-m12744.qiye.163.com (mail-m12744.qiye.163.com
 [115.236.127.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA37A88675
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 08:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=X6B+inpRF0mDnPX9vEg2eLXdgJDObmS+u9+IsI2lmwuJVab9kYN4bgiB+kNpD9QzxyprjOctvUCVTJpmGg5njODOuWz3CM9qa+CnYbuyw5S/Uzm1uuxYvroNNvQZpBshO6puA+uVoaeUEP6Kl/g9lPKco7JJR14lWPTGsg+NJiE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=KLmbDtA66wC1d4u9kkD/zFR094HeBqhfyBor/D+rOUY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A797C90052B;
 Mon, 15 Jul 2024 14:48:54 +0800 (CST)
Message-ID: <44d1ef8a-df02-438b-a137-6fc7df90e1f2@rock-chips.com>
Date: Mon, 15 Jul 2024 14:48:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] phy: rockchip: naneng-combphy: Fix "rockchip" spelling
To: Sebastian Kropatsch <seb-dev@mail.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <cover.1720988760.git.seb-dev@mail.de>
 <eb291d082df409153be526b7f755ac0096a4d29e.1720988760.git.seb-dev@mail.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <eb291d082df409153be526b7f755ac0096a4d29e.1720988760.git.seb-dev@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NDSFZDGExCSE1PQ0tCH0NWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b526c39203a9kunma797c90052b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6NBw5FDIyDCEKGjcBISow
 KA4aCg5VSlVKTElKS0lNSkhOSExCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTE5NNwY+
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
> Replace "rochchip" by "rockchip" in two instances.
>
> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 3ad339bccc..1b85cbcce8 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -225,7 +225,7 @@ static int rockchip_combphy_xlate(struct phy *phy, struct ofnode_phandle_args *a
>   	return 0;
>   }
>   
> -static const struct phy_ops rochchip_combphy_ops = {
> +static const struct phy_ops rockchip_combphy_ops = {
>   	.init = rockchip_combphy_init,
>   	.exit = rockchip_combphy_exit,
>   	.of_xlate = rockchip_combphy_xlate,
> @@ -535,7 +535,7 @@ U_BOOT_DRIVER(rockchip_naneng_combphy) = {
>   	.name		= "naneng-combphy",
>   	.id		= UCLASS_PHY,
>   	.of_match	= rockchip_combphy_ids,
> -	.ops		= &rochchip_combphy_ops,
> +	.ops		= &rockchip_combphy_ops,
>   	.probe		= rockchip_combphy_probe,
>   	.priv_auto	= sizeof(struct rockchip_combphy_priv),
>   };
