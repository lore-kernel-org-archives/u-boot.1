Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4532C7115E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 03:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD26388A76;
	Thu, 29 Aug 2024 05:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3979588A7F; Thu, 29 Aug 2024 05:44:09 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D1688A75
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 05:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpsz9t1724903025tixkfa2
X-QQ-Originating-IP: yXU8ZEv4CM4/0/AKZ4cJntdV8X7nOYZr5OrkSk6pwIs=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 29 Aug 2024 11:43:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1108091534434705893
Message-ID: <4E1AAA1D0BD543EF+d4413c57-9600-4b81-89bc-2d089f343bae@radxa.com>
Date: Thu, 29 Aug 2024 12:43:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] led: gpio: handle GPIO_ACTIVE_LOW flag properly
To: u-boot@lists.denx.de
Cc: trini@konsulko.com
References: <20240828121516.19696-1-naoki@radxa.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240828121516.19696-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
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

sorry, this patch seems to be wrong.
I'll check it again.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 8/28/24 21:15, FUKAUMI Naoki wrote:
> invert gpio state if GPIO_ACTIVE_LOW is specified in dts.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>   drivers/led/led_gpio.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/led/led_gpio.c b/drivers/led/led_gpio.c
> index ce22fb49f2a..54aa84e0726 100644
> --- a/drivers/led/led_gpio.c
> +++ b/drivers/led/led_gpio.c
> @@ -25,6 +25,8 @@ static int gpio_led_set_state(struct udevice *dev, enum led_state_t state)
>   	switch (state) {
>   	case LEDST_OFF:
>   	case LEDST_ON:
> +		if (priv->gpio.flags & GPIOD_ACTIVE_LOW)
> +			state = !state;
>   		break;
>   	case LEDST_TOGGLE:
>   		ret = dm_gpio_get_value(&priv->gpio);
> @@ -50,6 +52,9 @@ static enum led_state_t gpio_led_get_state(struct udevice *dev)
>   	if (ret < 0)
>   		return ret;
>   
> +	if (priv->gpio.flags & GPIOD_ACTIVE_LOW)
> +		ret = !ret;
> +
>   	return ret ? LEDST_ON : LEDST_OFF;
>   }
>   
