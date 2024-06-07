Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B83FC27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 10:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A95C28822F;
	Fri,  7 Jun 2024 12:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JbgPnSJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4578824C; Fri,  7 Jun 2024 12:27:05 +0200 (CEST)
Received: from mail-m121153.qiye.163.com (mail-m121153.qiye.163.com
 [115.236.121.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F1387ABC
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 12:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JbgPnSJvyNnJBgKIOSqnxVFAXafGbsGco1l48VCLmdzLItt2fE1pjmxXuVG8FenaBRVYA/kQeYAVVWP+HW6SWF55GSVJwPi2Z9cX6sq1Dzz1B4BkEvpBJ6R7uENIcYEt2s8EmcgP5McqasCZO5o1z+rt6Rjdcdn2/a1zzW4tnwk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=NIDPsCw/jNOtNm2erBMnTCBWDMN415hMeDfRBXP3dPs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D304E9006DD;
 Fri,  7 Jun 2024 18:26:52 +0800 (CST)
Message-ID: <c8bee542-356a-4e01-92a8-4f2aabfe31c0@rock-chips.com>
Date: Fri, 7 Jun 2024 18:26:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] pinctrl: rockchip: rv1126: Fix support for
 IOMUX_L_SOURCE_PMU flag
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
 <20240512121633.1632597-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240512121633.1632597-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5LGFYeSkNOSUhOHx1PGEJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ff23caad103a9kunmd304e9006dd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6Fyo5GTNNTykpISoWETdO
 Dj0wFBFVSlVKTEpMTE5NS0pITEhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITEJPNwY+
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


On 2024/5/12 20:16, Jonas Karlman wrote:
> GPIO0_C0-C4 iomux is set using PMUGRF_GPIO0C_IOMUX_L reg on RV1126. This
> is indicated using the IOMUX_L_SOURCE_PMU flag. Fix reading current mux
> by fully adopting the IOMUX_L_SOURCE_PMU related code in Linux kernel.
>
> Based on Linux commit fd4ea48688c6 ("pinctrl: rockchip: Add RV1126
> pinctrl support").
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index b6e2ab474d0f..973e6a4f6db9 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -132,8 +132,12 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
>   	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY)
>   		return RK_FUNC_GPIO;
>   
> -	regmap = (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
> -				? priv->regmap_pmu : priv->regmap_base;
> +	if (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
> +		regmap = priv->regmap_pmu;
> +	else if (bank->iomux[iomux_num].type & IOMUX_L_SOURCE_PMU)
> +		regmap = (pin % 8 < 4) ? priv->regmap_pmu : priv->regmap_base;
> +	else
> +		regmap = priv->regmap_base;
>   
>   	/* get basic quadrupel of mux registers and the correct reg inside */
>   	mux_type = bank->iomux[iomux_num].type;
> @@ -563,12 +567,14 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
>   
>   			/* preset iomux offset value, set new start value */
>   			if (iom->offset >= 0) {
> -				if (iom->type & IOMUX_SOURCE_PMU)
> +				if ((iom->type & IOMUX_SOURCE_PMU) ||
> +				    (iom->type & IOMUX_L_SOURCE_PMU))
>   					pmu_offs = iom->offset;
>   				else
>   					grf_offs = iom->offset;
>   			} else { /* set current iomux offset */
> -				iom->offset = (iom->type & IOMUX_SOURCE_PMU) ?
> +				iom->offset = ((iom->type & IOMUX_SOURCE_PMU) ||
> +					       (iom->type & IOMUX_L_SOURCE_PMU)) ?
>   							pmu_offs : grf_offs;
>   			}
>   
