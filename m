Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAF8C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 10:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7070D8891B;
	Tue, 16 Jul 2024 12:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FmtqrQ2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 935E5889CC; Tue, 16 Jul 2024 12:21:34 +0200 (CEST)
Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com
 [220.197.32.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B9088821
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=FmtqrQ2ZbdFIgvnqxHwP37YYhYAV/YWCERxjQcxSJtXFUPVlClQlFi8LjLCBH8P/JLW/ZFihFh89KvHfYolNjSUKMC7f3SVAk8Na6dxzLXS0lmDr53/l3tvqURZ564/92aQh5dmbTT7LrYegOJOad2HSzduBbPs2f+YAEzIBjvk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=SRn6Yb0Vlk4KFHscrNtZCyjmdQhwTGK1Lp+Bxt0sQUE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9722C9005A1;
 Tue, 16 Jul 2024 18:21:23 +0800 (CST)
Message-ID: <34d527ce-52b1-4455-a04a-dae713462ece@rock-chips.com>
Date: Tue, 16 Jul 2024 18:21:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] pinctrl: rockchip: Add pinmux status related ops
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
 <20240512121633.1632597-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240512121633.1632597-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MeSFZKHUkZS0sZHkIZQk5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90bb0fa8aa03a9kunm9722c9005a1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6Mgw*SDIyIh05KTg9NC08
 GEkaChZVSlVKTElKSklOSUNPT0lNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSkJONwY+
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
> Add get_pins_count(), get_pin_name() and get_pin_muxing() ops to support
> the pinmux status cmd.
>
>    => pinmux dev pinctrl
>    dev: pinctrl
>    => pinmux status
>    GPIO0_A0  : gpio
>    GPIO0_A1  : func-1
>    GPIO0_A2  : gpio
>    GPIO0_A3  : gpio
>    GPIO0_A4  : func-1
>    GPIO0_A5  : gpio
>    GPIO0_A6  : gpio
>    GPIO0_A7  : func-1
>    GPIO0_B0  : gpio
>    GPIO0_B1  : func-1
>    GPIO0_B2  : func-1
>    GPIO0_B3  : gpio
>    [...]
>
> The change to use ENOENT for unrouted pins also help hide a "Error -22"
> message for unrouted pins using the gpio status -a cmd.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 50 ++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index 1a8eec19d268..fa24de37b443 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -127,7 +127,7 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
>   
>   	if (bank->iomux[iomux_num].type & IOMUX_UNROUTED) {
>   		debug("pin %d is unrouted\n", pin);
> -		return -EINVAL;
> +		return -ENOENT;
>   	}
>   
>   	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY)
> @@ -194,6 +194,32 @@ static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
>   	return NULL;
>   }
>   
> +static int rockchip_pinctrl_get_pins_count(struct udevice *dev)
> +{
> +	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
> +	struct rockchip_pin_ctrl *ctrl = priv->ctrl;
> +
> +	return ctrl->nr_pins;
> +}
> +
> +static const char *rockchip_pinctrl_get_pin_name(struct udevice *dev,
> +						 unsigned int selector)
> +{
> +	static char name[PINNAME_SIZE];
> +	struct rockchip_pin_bank *bank;
> +	unsigned int index;
> +
> +	bank = rockchip_pin_to_bank(dev, selector);
> +	if (!bank)
> +		return NULL;
> +
> +	index = selector - bank->pin_base;
> +	snprintf(name, sizeof(name), "GPIO%u_%c%u",
> +		 bank->bank_num, 'A' + (index / 8), index % 8);
> +
> +	return name;
> +}
> +
>   static int rockchip_pin_to_mux(struct udevice *dev, unsigned int pin)
>   {
>   	struct rockchip_pin_bank *bank;
> @@ -222,6 +248,25 @@ static int rockchip_pinctrl_get_gpio_mux(struct udevice *dev, int banknum,
>   	return rockchip_get_mux(&ctrl->pin_banks[banknum], index);
>   }
>   
> +static int rockchip_pinctrl_get_pin_muxing(struct udevice *dev,
> +					   unsigned int selector,
> +					   char *buf, int size)
> +{
> +	int mux;
> +
> +	mux = rockchip_pin_to_mux(dev, selector);
> +	if (mux == -ENOENT)
> +		strlcpy(buf, "unrouted", size);
> +	else if (mux < 0)
> +		return mux;
> +	else if (mux)
> +		snprintf(buf, size, "func-%d", mux);
> +	else
> +		strlcpy(buf, "gpio", size);
> +
> +	return 0;
> +}
> +
>   static int rockchip_verify_mux(struct rockchip_pin_bank *bank,
>   			       int pin, int mux)
>   {
> @@ -571,8 +616,11 @@ static int rockchip_pinctrl_set_state(struct udevice *dev,
>   }
>   
>   const struct pinctrl_ops rockchip_pinctrl_ops = {
> +	.get_pins_count			= rockchip_pinctrl_get_pins_count,
> +	.get_pin_name			= rockchip_pinctrl_get_pin_name,
>   	.set_state			= rockchip_pinctrl_set_state,
>   	.get_gpio_mux			= rockchip_pinctrl_get_gpio_mux,
> +	.get_pin_muxing			= rockchip_pinctrl_get_pin_muxing,
>   	.gpio_request_enable		= rockchip_pinctrl_gpio_request_enable,
>   };
>   
