Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0A0D3176A
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 01:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C3D89076;
	Wed,  6 Nov 2024 02:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730856340;
	bh=UK4t4D/LDFSKdEz2ulBRT+IeHdBKXdg221vA/yZn6X0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OSRYnbcVV3XTw74c/XDVKs1SuSn6fIStB8UqAJL7UCCx2hLC1xHYWaE+pUoOkAP6U
	 rwzlZRyTvw9H4r+SiaGu0oYyYsGJ8dH/sU2V53nBLjtcKq5TxLPRuE5FxgkPk/Ydvw
	 6dW5knlubB9DXgdC9qe8Ofywk10tgFZH7vFsHFHO+lYLY5E5vAjqW6p7empFtdD6DU
	 9iTp0D2jaswaGqdH3dEHz+n5hPKOqIzgoEEozDac31sb5BHvrGEhKUlUxBUxYhI+h0
	 yIkqwsyO7uwmcY1cNDV4IaBxhTyjuODE+LhDkRjFI9eNJjv17mspw3qWlLZ/P41MTE
	 E8Q8tLubY64OQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 700AA88D9B;
 Wed,  6 Nov 2024 02:25:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730856339;
 bh=UK4t4D/LDFSKdEz2ulBRT+IeHdBKXdg221vA/yZn6X0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=xqNk+i8VLRO5yqu2tA0I6NKSN8F9IuN6+sBE9gvGnu4UYzgsttacQjfZf4kHuI541
 NWVqEmbWQYctZiFFF13ZeuAMZT3dQGyBr6nkYA+nKpGo8do3wiTwiKpCMKyW6CEa3l
 V0pCOMN0JtBiKYjbNnGMU4MR28s+Ab3fsUbataWn/9oA7d8ZYB27wmtt2TTEc0enao
 m3N7X+znIenswQnfjARe3Z7SOzx3A7NobS/QT1RJu0+QNx6Ti2vqFUqjq5TCNcWSPV
 9/HuXBZhcRB+YHmoynmyEuOij592uEQ7TcSPu0R9xfPcwZk9ef1r8mHGCGu7iFvBG1
 4V2WW7UjJmoDQ==
Message-ID: <1ab82f5b-6e89-4c1d-990e-3936c8ffa489@denx.de>
Date: Wed, 6 Nov 2024 01:34:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] usb: onboard-hub: Add reset-gpio support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
 <20241030064314.28604-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241030064314.28604-2-venkatesh.abbarapu@amd.com>
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

On 10/30/24 7:43 AM, Venkatesh Yadav Abbarapu wrote:
> As part of the reset, sets the direction of the pin to output before
> toggling the pin. Delay of millisecond is added in between low and
> high to meet the setup and hold time requirement of the reset.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
>   common/usb_onboard_hub.c | 42 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 68a04ac041..4174575893 100644
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
Is the reset GPIO always active low or should this respect the GPIO 
flags in DT instead ?
