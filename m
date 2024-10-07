Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50458CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90BD88D1C;
	Mon,  7 Oct 2024 14:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728303349;
	bh=T2bJXd7OPJSW9tx8esSiL2+3BF+QpGWg4DU0ai6OW/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jup21cJ7KG7I71u44wT3ieYcwfTTCB4JYSYnSkeAMow7W7e84bnoI4kyuPEwgitF+
	 Ued2YjWy3AiqoWGAX54d2kneMVe9v6JTogY8bHfV2fdaP452oNdE4QBTQLozTSGCb9
	 7kkr2bexcVak5cNGg19ixf4P32UP65o+VvHFkV9LNz61BDwCEamBDt7H5n/rmzA9bJ
	 5xsb0NRM3sc6qfM6eG2r8St3CzhKln494bHpZreeG4zyf+menb/9WP5SxvIfY4Pgi1
	 jsE8JiwLyHIyxSWNVh8nbZNpvaukd+z4Q6XFkuAtX52znoY0y5Y7O9YRgPMFlMaVjB
	 RQZH4ckeFxW1A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F206088D15;
 Mon,  7 Oct 2024 14:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728303348;
 bh=T2bJXd7OPJSW9tx8esSiL2+3BF+QpGWg4DU0ai6OW/E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VLW2vfDVSl1RzuPxF4iaRaoYxrfBNoq3+pr/ndDqiE1253wAP3RCDHBcCyOg0IUIf
 HfVMnXofiZYuq3NAq+9kyPfXUK0tyxLXPP89Mx4YMSn841wVLukABl5tKZBCO2aaNC
 xLeEh9JkJ4o6xM3O6sviQ9s6m7EwG7uwjlZVmpVjKRCbFIxLgC3Q2NiNm3elpLdLlL
 hVjVIF40cleSX/YOETFAMpOf5fa5502r2+fYDe6xyxCcP7fYWj+DxYAzHQ0o7zyEQM
 tjEpzUJE5T/D68JG4om4bTVvTGjVwpaefwGv8UbAARwnetcL0nJGkTPn7X5FEkr+uG
 nKVr1Q+FZ5bGQ==
Message-ID: <eb74b41b-9546-4c68-a724-00c2e33c9deb@denx.de>
Date: Mon, 7 Oct 2024 14:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] usb: onboard-hub: Add reset-gpio support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
 <20241007044547.23896-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241007044547.23896-2-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/7/24 6:45 AM, Venkatesh Yadav Abbarapu wrote:
> As part of the reset, sets the direction of the pin to output before
> toggling the pin. Delay of millisecond is added in between low and
> high to meet the setup and hold time requirement of the reset.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/usb_onboard_hub.c | 49 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 68a04ac041..4317e81ed8 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -7,14 +7,51 @@
>    * Mostly inspired by Linux kernel v6.1 onboard_usb_hub driver
>    */
>   
> +#include <asm/gpio.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> +#include <linux/delay.h>
>   #include <power/regulator.h>
>   
>   struct onboard_hub {
>   	struct udevice *vdd;
> +	struct gpio_desc *reset_gpio;
>   };
>   
> +struct onboard_hub_data {
> +	unsigned long reset_us;
> +	unsigned long power_on_delay_us;
> +};
> +
> +int usb_onboard_hub_reset(struct udevice *dev)
> +{
> +	struct onboard_hub_data *data =
> +		(struct onboard_hub_data *)dev_get_driver_data(dev);
> +	struct onboard_hub *hub = dev_get_priv(dev);
> +	int ret;
> +
> +	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> +
> +	/* property is optional, don't return error! */
> +	if (!hub->reset_gpio)
> +		return 0;
> +
> +	ret = dm_gpio_set_value(hub->reset_gpio, 1);
> +	if (ret)
> +		return ret;
> +
> +	udelay(data->reset_us);
> +
> +	ret = dm_gpio_set_value(hub->reset_gpio, 0);
> +	if (ret)
> +		return ret;
> +
> +	udelay(data->power_on_delay_us);
> +
> +	return 0;
> +}
> +
>   static int usb_onboard_hub_probe(struct udevice *dev)
>   {
>   	struct onboard_hub *hub = dev_get_priv(dev);
> @@ -30,7 +67,11 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   	if (ret)
>   		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
>   
> -	return ret;
> +	ret = usb_onboard_hub_reset(dev);

return usb_onboard_hub_reset(dev);
