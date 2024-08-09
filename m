Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D75C52D7F
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4097688B80;
	Fri,  9 Aug 2024 11:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="B8J9S3uU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5CDA88B9F; Fri,  9 Aug 2024 11:35:50 +0200 (CEST)
Received: from mail-m92232.xmail.ntesmail.com (mail-m92232.xmail.ntesmail.com
 [103.126.92.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBE4881C3
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=B8J9S3uUze4qewRxeVZJZLkZA+PK7IGtzsKgyllU527se79tL+lgxIi26iT26xUTSda0q5ZsPRC4dVL3NoKoZK5Gf3/2JyHXgFvQzyrC6I++0eskg1tyrQzkhrf+yMEIh2iVNtOZGQIYOlXtfLd9Ko4pbQXJBWT6UhZsnbxxD3I=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=dgZ7858GzH400eIJibkynTL3VJoKIQTEqmEJG1BiwHE=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id BF577900620;
 Fri,  9 Aug 2024 17:35:36 +0800 (CST)
Message-ID: <b8b5d3aa-a10a-4cb9-96a3-298d0a9a980e@rock-chips.com>
Date: Fri, 9 Aug 2024 17:35:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] pinctrl: rockchip: Add a pin_to_bank() helper
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802225705.2640999-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTU1CVkMdT0NJHUgaTB9MTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a91367e5f0203a9kunmbf577900620
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46Szo*UTI9PQ4TLklKIzUX
 TikaCQhVSlVKTElISkJNSkhMTUJCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhITEs3Bg++
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


On 2024/8/3 06:56, Jonas Karlman wrote:
> Add a pin_to_bank() helper that can locate a pin bank based on the pin
> offset, to be used in get_gpio_mux() and gpio_request_enable() ops.
>
> Reset ctrl->nr_pins to 0 so that pin_to_bank() can locate a bank after
> the second probe in U-Boot proper.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch split from "pinctrl: rockchip: Add gpio_request_enable()
>      ops" of "rockchip: Add gpio request() ops" series
> ---
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c   | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index f6af22501c36..894ff74aee98 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -176,6 +176,23 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
>   	return ((val >> bit) & mask);
>   }
>   
> +static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
> +						      unsigned int pin)
> +{
> +	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
> +	struct rockchip_pin_ctrl *ctrl = priv->ctrl;
> +	struct rockchip_pin_bank *bank = ctrl->pin_banks;
> +	int i;
> +
> +	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
> +		if (pin >= bank->pin_base &&
> +		    pin < bank->pin_base + bank->nr_pins)
> +			return bank;
> +	}
> +
> +	return NULL;
> +}
> +
>   static int rockchip_pinctrl_get_gpio_mux(struct udevice *dev, int banknum,
>   					 int index)
>   {	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
> @@ -539,6 +556,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
>   	drv_pmu_offs = ctrl->pmu_drv_offset;
>   	drv_grf_offs = ctrl->grf_drv_offset;
>   	bank = ctrl->pin_banks;
> +	ctrl->nr_pins = 0;
>   
>   	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
>   		int bank_pins = 0;
