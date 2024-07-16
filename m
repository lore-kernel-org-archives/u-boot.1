Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16337C3DA60
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 10:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1EC889D3;
	Tue, 16 Jul 2024 12:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="fzzYH+Ne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2C6889E0; Tue, 16 Jul 2024 12:20:10 +0200 (CEST)
Received: from mail-m49214.qiye.163.com (mail-m49214.qiye.163.com
 [45.254.49.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79418889D0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=fzzYH+NeTmkwotim4FpGmc+y/QzdZqXsN2lrXJ8mMC1EGp3XaRUjNBTL5pC1ZTPsvJpFdFsUtejrX7+pnWZHVsXZ70KIJUuQ2melA3/YXqLrUGZLAL9EiT4KLQl0TqJ1zJU0Ui5P5Fc1tysChBQ1i5lOKWe9F0hvnDkyDqejE4A=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=RBtr79aQodlyjtTSqP96sguWPz2sWImJv4ciSRS6yJc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6DE0F9000F5;
 Tue, 16 Jul 2024 18:19:59 +0800 (CST)
Message-ID: <1da543ca-cf58-4939-bdc7-c196b23b39dc@rock-chips.com>
Date: Tue, 16 Jul 2024 18:19:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] gpio: rockchip: Get pinctrl device from gpio-ranges
 prop
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
 <20240512121633.1632597-7-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240512121633.1632597-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4aQ1ZDSkJDHxhMGkgaGk5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90bb0e603b03a9kunm6de0f9000f5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhg6Aww5PTI0Lh0UKTohNVYX
 KxxPCQpVSlVKTElKSklOSUtLSExJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITUhINwY+
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
> Get pinctrl device from gpio-ranges phandle when the property exists,
> fallback to get the first pinctrl device.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/gpio/rk_gpio.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
> index 956894501633..8f8f21acc2f5 100644
> --- a/drivers/gpio/rk_gpio.c
> +++ b/drivers/gpio/rk_gpio.c
> @@ -191,12 +191,6 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   
>   	priv->regs = dev_read_addr_ptr(dev);
>   
> -	if (CONFIG_IS_ENABLED(PINCTRL)) {
> -		ret = uclass_first_device_err(UCLASS_PINCTRL, &priv->pinctrl);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	/*
>   	 * If "gpio-ranges" is present in the devicetree use it to parse
>   	 * the GPIO bank ID, otherwise use the legacy method.
> @@ -204,16 +198,33 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev),
>   					     "gpio-ranges", NULL, 3,
>   					     0, &args);
> -	if (!ret || ret != -ENOENT) {
> +	if (!ret) {
>   		uc_priv->gpio_count = args.args[2];
>   		priv->bank = args.args[1] / ROCKCHIP_GPIOS_PER_BANK;
> -	} else {
> +
> +		if (CONFIG_IS_ENABLED(PINCTRL)) {
> +			ret = uclass_get_device_by_ofnode(UCLASS_PINCTRL,
> +							  args.node,
> +							  &priv->pinctrl);
> +			if (ret)
> +				return ret;
> +		}
> +	} else if (ret == -ENOENT || !CONFIG_IS_ENABLED(PINCTRL)) {
>   		uc_priv->gpio_count = ROCKCHIP_GPIOS_PER_BANK;
>   		ret = dev_read_alias_seq(dev, &priv->bank);
>   		if (ret) {
>   			end = strrchr(dev->name, '@');
>   			priv->bank = trailing_strtoln(dev->name, end);
>   		}
> +
> +		if (CONFIG_IS_ENABLED(PINCTRL)) {
> +			ret = uclass_first_device_err(UCLASS_PINCTRL,
> +						      &priv->pinctrl);
> +			if (ret)
> +				return ret;
> +		}
> +	} else {
> +		return ret;
>   	}
>   
>   	priv->name[0] = 'A' + priv->bank;
