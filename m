Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B912C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 10:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871AF87E96;
	Fri,  7 Jun 2024 12:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LT2d50km";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A7987ABC; Fri,  7 Jun 2024 12:27:48 +0200 (CEST)
Received: from mail-m32103.qiye.163.com (mail-m32103.qiye.163.com
 [220.197.32.103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9854387FC8
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 12:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LT2d50kmY01WfFva8p4AyjA2cq9Uqhsq1GslMsI6WDhDU0+IDHoA/6Smc1rYYw+VjhL4ESipZXIVdds8b7c8F4AXCioELiXbFBVAJm2DFFyPslR0mhplTz3LJIALnjb2hsz+HW0N8LUDIsUCmizTnlDVxN3hOT1dTDg+DEf3RCg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=ez3QQa9mE4AfFwMSMcMS1jA/oTWspcb9F4Hloq1p+Bs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 53E77900134;
 Fri,  7 Jun 2024 18:27:37 +0800 (CST)
Message-ID: <d3c0cf93-109a-4654-8ba9-7384a5d3e2fb@rock-chips.com>
Date: Fri, 7 Jun 2024 18:27:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] pinctrl: rockchip: Use
 syscon_regmap_lookup_by_phandle()
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
 <20240512121633.1632597-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240512121633.1632597-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5CSVYZSE8ZHRoYSxgaGhpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ff23d58ed03a9kunm53e77900134
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MT46Cjo*ETNOAikDISosERxN
 NgwaCU5VSlVKTEpMTE5NS05DSU1JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPS0pPNwY+
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
> Use syscon_regmap_lookup_by_phandle() to simplify the code.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 39 ++++++-------------
>   1 file changed, 12 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index efc2070d32d9..b7c08c23311f 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -11,6 +11,7 @@
>   #include <syscon.h>
>   #include <fdtdec.h>
>   #include <linux/bitops.h>
> +#include <linux/err.h>
>   #include <linux/libfdt.h>
>   
>   #include "pinctrl-rockchip.h"
> @@ -672,37 +673,21 @@ int rockchip_pinctrl_probe(struct udevice *dev)
>   {
>   	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
>   	struct rockchip_pin_ctrl *ctrl;
> -	struct udevice *syscon;
> -	struct regmap *regmap;
> -	int ret = 0;
>   
> -	/* get rockchip grf syscon phandle */
> -	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "rockchip,grf",
> -					   &syscon);
> -	if (ret) {
> -		debug("unable to find rockchip,grf syscon device (%d)\n", ret);
> -		return ret;
> +	priv->regmap_base =
> +			syscon_regmap_lookup_by_phandle(dev, "rockchip,grf");
> +	if (IS_ERR(priv->regmap_base)) {
> +		debug("unable to find rockchip,grf regmap\n");
> +		return PTR_ERR(priv->regmap_base);
>   	}
>   
> -	/* get grf-reg base address */
> -	regmap = syscon_get_regmap(syscon);
> -	if (!regmap) {
> -		debug("unable to find rockchip grf regmap\n");
> -		return -ENODEV;
> -	}
> -	priv->regmap_base = regmap;
> -
> -	/* option: get pmu-reg base address */
> -	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "rockchip,pmu",
> -					   &syscon);
> -	if (!ret) {
> -		/* get pmugrf-reg base address */
> -		regmap = syscon_get_regmap(syscon);
> -		if (!regmap) {
> -			debug("unable to find rockchip pmu regmap\n");
> -			return -ENODEV;
> +	if (dev_read_bool(dev, "rockchip,pmu")) {
> +		priv->regmap_pmu =
> +			syscon_regmap_lookup_by_phandle(dev, "rockchip,pmu");
> +		if (IS_ERR(priv->regmap_pmu)) {
> +			debug("unable to find rockchip,pmu regmap\n");
> +			return PTR_ERR(priv->regmap_pmu);
>   		}
> -		priv->regmap_pmu = regmap;
>   	}
>   
>   	ctrl = rockchip_pinctrl_get_soc_data(dev);
