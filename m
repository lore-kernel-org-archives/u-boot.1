Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3619ECA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 18:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B4488ABA;
	Mon,  2 Sep 2024 20:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725303551;
	bh=qzTPkQ7G2BRte4bOp9EFyGtQXOOkRNFIx36xXJZRpaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=htIHY8py7rjTmK5MWShUsbTNnuC/F62hCbYPK3WT531lkkdSg5ej/n0p4hp6njPa4
	 woOJrAQB2ITlZTNPEcRgXTkD/M3IGLLzgy7uDVcFtCMQEZp2ZyymKIsfPUUAUJxj4L
	 9/PTpBpZ+ZJO4IwEhrIjaR0kTOYTNPL6BH+d6gx5Y37TxApyWUzlsCHza7b3AD/m0U
	 kYW4GOxJAYLA1M+gFXwQNtUKwdU4sbmqNRYHENq4mITPRIwF71Axx/UvZjtDiY6PoZ
	 QfDFPUUZsHwz584YMwe8ywoG27AIaDA4T/RcACHX9udTGIhgffkEWOR3hCDzw5Qhif
	 6+INunuLLENuA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 16AED88BEF;
 Mon,  2 Sep 2024 20:59:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725303550;
 bh=qzTPkQ7G2BRte4bOp9EFyGtQXOOkRNFIx36xXJZRpaY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ebTLmlQ41jdWcelcC1H4X45XNKhzhHWG7sMuqRmUG3whsw9FX5BQTYZfHJwYJVjVF
 9OW82z3lsDyrqK+Uy3OacBC6YBtq3F370RFj+HHYLakV+rvkEzKQMvldUjPXjZx4Jx
 v2rgZKbbHX8AGt8XPP2IGzb2bwCqQ8P8HHQTnRYq+RWZZjUn1W4a1VNu4WdTWQQaEZ
 24s2l3639xD9QpunfBgDJLJO0XOtjjxhVv2pWt76ui/1s3TKK2qR+lJnt76ZmRy5+q
 TAgvCQitlC7eLFpeDaKNvryBaSkVpd6ONxaYxffezsekiVvoFrQAX+sDuzDpuew35G
 n9zwp0iAXHxmA==
Message-ID: <283930cd-61dd-4feb-ae49-5977a8698350@denx.de>
Date: Mon, 2 Sep 2024 20:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] usb: onboard-hub: Add reset-gpio support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
 <20240605100221.3571-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240605100221.3571-2-venkatesh.abbarapu@amd.com>
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

On 6/5/24 12:02 PM, Venkatesh Yadav Abbarapu wrote:
> As part of the reset, sets the direction of the pin to output before
> toggling the pin. Delay of millisecond is added in between low and
> high to meet the setup and hold time requirement of the reset.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/usb_onboard_hub.c | 44 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 89e18a2ddad..2f6fb71935d 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -7,17 +7,26 @@
>    * Mostly inspired by Linux kernel v6.1 onboard_usb_hub driver
>    */
>   
> +#include <asm/gpio.h>
>   #include <common.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> +#include <linux/delay.h>
>   #include <power/regulator.h>
>   
>   struct onboard_hub {
>   	struct udevice *vdd;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +struct onboard_hub_data {
> +	unsigned long reset_us;
>   };
>   
>   static int usb_onboard_hub_probe(struct udevice *dev)
>   {
> +	struct onboard_hub_data *data =
> +		(struct onboard_hub_data *)dev_get_driver_data(dev);
>   	struct onboard_hub *hub = dev_get_priv(dev);
>   	int ret;
>   
> @@ -31,7 +40,24 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   	if (ret)
>   		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
>   
> -	return ret;
> +	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> +	/* property is optional, don't return error! */
> +	if (hub->reset_gpio) {
> +		ret = dm_gpio_set_value(hub->reset_gpio, 1);
> +		if (ret)
> +			return ret;
> +
> +		udelay(data->reset_us);

Where is this assigned ?

> +		ret = dm_gpio_set_value(hub->reset_gpio, 0);
> +		if (ret)
> +			return ret;
> +
> +		udelay(data->reset_us);
> +	}

Is the reset asserted time and post-reset time identical for all USB 
HUBs ? I don't think it is.

> +	return 0;
>   }
>   
>   static int usb_onboard_hub_remove(struct udevice *dev)
> @@ -39,6 +65,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   	struct onboard_hub *hub = dev_get_priv(dev);
>   	int ret;
>   
> +	if (hub->reset_gpio) {
> +		struct gpio_desc *hub_reset_gpio = hub->reset_gpio;
> +
> +		dm_gpio_free(hub_reset_gpio->dev, hub_reset_gpio);
> +	}
> +
>   	ret = regulator_set_enable_if_allowed(hub->vdd, false);
>   	if (ret)
>   		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
> @@ -46,10 +78,16 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   	return ret;
>   }
>   
> +static const struct onboard_hub_data usb2514_data = {
> +	/* TBD */

Do not add this if not used.
