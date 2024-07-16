Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49070C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 10:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA96D889D4;
	Tue, 16 Jul 2024 12:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IPP+ITg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B4488821; Tue, 16 Jul 2024 12:20:19 +0200 (CEST)
Received: from mail-m3292.qiye.163.com (mail-m3292.qiye.163.com
 [220.197.32.92])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CA76889CD
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IPP+ITg0Zh7HvsK6KWvnKpIDYaei8UimTMPp2HpAbpiYU48DlPDQntDt05/pQdjd2BUTIyUBlB1pG3ax2gf4qYCT1lEqVcker+XZHdPpd+seYeqJ2wYnwDHw7jPLY+6w46jnSapn+7kDEO9id60WX5DMrS9n88oX93SqeZLxg6o=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=UnWIAMzsfWLJmEx3/zck/N8qvfpc/WsVv9nOAMXGvEM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 91D409006DF;
 Tue, 16 Jul 2024 18:20:07 +0800 (CST)
Message-ID: <795b329c-27f7-4940-a885-f31f614b38fe@rock-chips.com>
Date: Tue, 16 Jul 2024 18:20:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] gpio: rockchip: Use pinctrl pin offset to
 get_gpio_mux()
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
 <20240512121633.1632597-8-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240512121633.1632597-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5OHVZMQ0kZS0xDSkoZQktWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90bb0e80ce03a9kunm91d409006df
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46ASo5KTIxLh0SEzhCNVYS
 I0gwFAlVSlVKTElKSklOSUtDTEhKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTUpPNwY+
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
> Use the pinctrl pin offset to get_gpio_mux() to remove the bank num
> dependency and instead only use the bank num to assign a bank name.
>
> Most Rockchip SoCs use all 32 pins of each gpio controller, meaning the
> pinctrl pin offset typically is aligned to 32.
>
> However, for gpio0 on RK3288 only 24 pins are used meaning the pinctrl
> pin offset start at pin 24 for gpio1. Use DIV_ROUND_UP to get the 32 pin
> aligned bank num.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/gpio/rk_gpio.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
> index 8f8f21acc2f5..a3691ad25b78 100644
> --- a/drivers/gpio/rk_gpio.c
> +++ b/drivers/gpio/rk_gpio.c
> @@ -35,7 +35,7 @@ enum {
>   struct rockchip_gpio_priv {
>   	void __iomem *regs;
>   	struct udevice *pinctrl;
> -	int bank;
> +	int pfc_offset;
>   	char name[2];
>   	u32 version;
>   };
> @@ -109,7 +109,8 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
>   	int ret;
>   
>   	if (CONFIG_IS_ENABLED(PINCTRL)) {
> -		ret = pinctrl_get_gpio_mux(priv->pinctrl, priv->bank, offset);
> +		ret = pinctrl_get_gpio_mux(priv->pinctrl, -1,
> +					   priv->pfc_offset + offset);
>   		if (ret < 0)
>   			return ret;
>   		else if (ret != RK_FUNC_GPIO)
> @@ -187,7 +188,7 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   	struct rockchip_gpio_priv *priv = dev_get_priv(dev);
>   	struct ofnode_phandle_args args;
>   	char *end;
> -	int ret;
> +	int bank, ret;
>   
>   	priv->regs = dev_read_addr_ptr(dev);
>   
> @@ -200,7 +201,8 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   					     0, &args);
>   	if (!ret) {
>   		uc_priv->gpio_count = args.args[2];
> -		priv->bank = args.args[1] / ROCKCHIP_GPIOS_PER_BANK;
> +		bank = DIV_ROUND_UP(args.args[1], ROCKCHIP_GPIOS_PER_BANK);
> +		priv->pfc_offset = args.args[1];
>   
>   		if (CONFIG_IS_ENABLED(PINCTRL)) {
>   			ret = uclass_get_device_by_ofnode(UCLASS_PINCTRL,
> @@ -211,11 +213,12 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   		}
>   	} else if (ret == -ENOENT || !CONFIG_IS_ENABLED(PINCTRL)) {
>   		uc_priv->gpio_count = ROCKCHIP_GPIOS_PER_BANK;
> -		ret = dev_read_alias_seq(dev, &priv->bank);
> +		ret = dev_read_alias_seq(dev, &bank);
>   		if (ret) {
>   			end = strrchr(dev->name, '@');
> -			priv->bank = trailing_strtoln(dev->name, end);
> +			bank = trailing_strtoln(dev->name, end);
>   		}
> +		priv->pfc_offset = bank * ROCKCHIP_GPIOS_PER_BANK;
>   
>   		if (CONFIG_IS_ENABLED(PINCTRL)) {
>   			ret = uclass_first_device_err(UCLASS_PINCTRL,
> @@ -227,7 +230,7 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   		return ret;
>   	}
>   
> -	priv->name[0] = 'A' + priv->bank;
> +	priv->name[0] = 'A' + bank;
>   	uc_priv->bank_name = priv->name;
>   
>   	priv->version = readl(priv->regs + VER_ID_V2);
