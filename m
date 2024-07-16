Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32995C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 10:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B80C8891B;
	Tue, 16 Jul 2024 12:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Zbf9UiNH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2555688939; Tue, 16 Jul 2024 12:20:03 +0200 (CEST)
Received: from mail-m127222.xmail.ntesmail.com
 (mail-m127222.xmail.ntesmail.com [115.236.127.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9A9388821
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Zbf9UiNHJQbkpOonMz+dozRXMS1aCiXfRtOnvvvrIebT7F1V3oJamqRSFPr2ZNjq9/hv5I5JsaNIp/hJh/cm4lRPYjUiXaM0DNoUFvCZs0+U5nYitHsVgYA4FhoV1h/0EnIFg0VWawZd6L8CSdDH9kxJvDobYMsxFGOdJUU1Ays=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=2i8jg47EIbrMi1IzoijTFsmmTWrKymFfnIsu1hHEuvc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 39E5E9006A3;
 Tue, 16 Jul 2024 18:19:42 +0800 (CST)
Message-ID: <5ed39e87-41e8-4a19-94e5-ed959596f6d9@rock-chips.com>
Date: Tue, 16 Jul 2024 18:19:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] pinctrl: rockchip: Update get_gpio_mux() ops
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de
References: <20240512121633.1632597-1-jonas@kwiboo.se>
 <20240512121633.1632597-6-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240512121633.1632597-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwdTlZCSx4YH0tOTEwZSkhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90bb0e1cad03a9kunm39e5e9006a3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46Qio5QzI3GB0yEzpJNQ4R
 IkMKCzpVSlVKTElKSklOSkNJQkJCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkNPNwY+
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
> Add a way to get_gpio_mux() based on the pinctrl pin offset, use -1 as
> banknum to use the pinctrl pin offset mode instead of bank pin offset.
>
> This mode will be used by the gpio driver to ensure a pin used by gpio
> request() and get_function() ops always refer to the same pinctrl pin.
>
> Also add verify_config() of banknum and index to avoid an out of range
> access of the pin_banks array, i.e. with gpio6 on rk3066a.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> The pin_to_mux() helper will be used in the get_pin_muxing() ops added
> in a later patch to support the pinmux status cmd.
> ---
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 22 ++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index b7c08c23311f..1a8eec19d268 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -194,10 +194,30 @@ static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
>   	return NULL;
>   }
>   
> +static int rockchip_pin_to_mux(struct udevice *dev, unsigned int pin)
> +{
> +	struct rockchip_pin_bank *bank;
> +
> +	bank = rockchip_pin_to_bank(dev, pin);
> +	if (!bank)
> +		return -EINVAL;
> +
> +	return rockchip_get_mux(bank, pin - bank->pin_base);
> +}
> +
>   static int rockchip_pinctrl_get_gpio_mux(struct udevice *dev, int banknum,
>   					 int index)
> -{	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
> +{
> +	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
>   	struct rockchip_pin_ctrl *ctrl = priv->ctrl;
> +	int ret;
> +
> +	if (banknum == -1)
> +		return rockchip_pin_to_mux(dev, index);
> +
> +	ret = rockchip_verify_config(dev, banknum, index);
> +	if (ret)
> +		return ret;
>   
>   	return rockchip_get_mux(&ctrl->pin_banks[banknum], index);
>   }
