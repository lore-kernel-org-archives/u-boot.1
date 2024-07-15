Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EDBC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 06:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2711886CC;
	Mon, 15 Jul 2024 08:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Leg29IHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E9A88669; Mon, 15 Jul 2024 08:49:37 +0200 (CEST)
Received: from mail-m12779.qiye.163.com (mail-m12779.qiye.163.com
 [115.236.127.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB579886FF
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 08:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Leg29IHps7FSFKyT8CIeAilnlYISrFjbRgN63wn5/RHpAZ4JAK/2BADRy75Lnar0NB0njzCt/L2t8pCNJx6pZ1RvBc0/C9dQC5Fd7ayN5A9Z5N9NauE5Wyhcox0JnsPQEfZrU1D5yxGZCZDhMqTGmB4K95nGgYuFh8BMNdepWYE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=ksrl70WCcFU6ROgH+etWapvHQ40pUvZNhKTBm4ar5rw=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id AD28C9004F3;
 Mon, 15 Jul 2024 14:49:23 +0800 (CST)
Message-ID: <a1d18da3-1859-456a-b949-b1474e122236@rock-chips.com>
Date: Mon, 15 Jul 2024 14:49:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] phy: rockchip: snps-pcie3: Fix clearing
 PHP_GRF_PCIESEL_CON bits
To: Sebastian Kropatsch <seb-dev@mail.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <cover.1720988760.git.seb-dev@mail.de>
 <95f198afc2de1fd09940bdea1b55be3573993f12.1720988760.git.seb-dev@mail.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <95f198afc2de1fd09940bdea1b55be3573993f12.1720988760.git.seb-dev@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpDGFZCS0xOQk9DQkwZQx5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b52734f603a9kunmad28c9004f3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46Gjo4GjI4DCExCjIYIQE1
 DhYaChlVSlVKTElKS0lNSk1PTkpLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIT09INwY+
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
> The pcie1ln_sel bits for the RK3588 are getting set but not cleared due
> to an incorrect write mask.
> Use a newly introduced constant for the write mask to fix this.
> Also introduce a GENMASK-based constant for PCIE30_PHY_MODE.
>
> This fix is adapted from the upstream Linux commit by Sebastian Reichel:
> 55491a5fa163 ("phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits")
>
> Fixes: 50e54e80679b ("phy: rockchip: snps-pcie3: Add support for RK3588")
> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/phy/rockchip/phy-rockchip-snps-pcie3.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> index fadb77c25c..62b42d1805 100644
> --- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> +++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
> @@ -36,6 +36,8 @@
>   #define RK3588_BIFURCATION_LANE_0_1		BIT(0)
>   #define RK3588_BIFURCATION_LANE_2_3		BIT(1)
>   #define RK3588_LANE_AGGREGATION			BIT(2)
> +#define RK3588_PCIE1LN_SEL_EN			(GENMASK(1, 0) << 16)
> +#define RK3588_PCIE30_PHY_MODE_EN		(GENMASK(2, 0) << 16)
>   
>   /**
>    * struct rockchip_p3phy_priv - RK DW PCIe PHY state
> @@ -127,13 +129,13 @@ static int rockchip_p3phy_rk3588_init(struct phy *phy)
>   
>   	reg = mode;
>   	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
> -		     (0x7 << 16) | reg);
> +		     RK3588_PCIE30_PHY_MODE_EN | reg);
>   
>   	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
> -	reg = mode & 3;
> +	reg = mode & (RK3588_BIFURCATION_LANE_0_1 | RK3588_BIFURCATION_LANE_2_3);
>   	if (reg)
>   		regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
> -			     (reg << 16) | reg);
> +			     RK3588_PCIE1LN_SEL_EN | reg);
>   
>   	reset_deassert(&priv->p30phy);
>   	udelay(1);
