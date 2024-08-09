Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9BCC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4FC888702;
	Fri,  9 Aug 2024 11:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Xe67Nr48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB0988755; Fri,  9 Aug 2024 11:38:14 +0200 (CEST)
Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com
 [220.197.32.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 701E788581
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Xe67Nr48dd5VFSoneQKELjhleRFFBPitE9NOJXydZHnNQBti5Fpy64KC+I8DdGU8dqaxfJKZqy/AyJDKdOlPm+y76sKc7nHLTO4nLZnALjwBBwW1HHrHdE7h2dip8bCe2P1GxLbjdR9rx2ZbIuSzprtMg+FAINDdUCwi+m5LxXI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=AB9t2DLjp8E1SeNaQdJQ/ebCNF5gFOCcg5vQCUm+ohE=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id A56D3900465;
 Fri,  9 Aug 2024 17:38:00 +0800 (CST)
Message-ID: <7734a911-2f8e-40c8-8fec-942c27f92d35@rock-chips.com>
Date: Fri, 9 Aug 2024 17:38:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] gpio: rockchip: Add request() ops
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-9-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802225705.2640999-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTENCVh4YHk9PThoZSUpJH1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a913680916303a9kunma56d3900465
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAw6SQw6HTIxPQ4UPTpDOTA8
 C0IwCk9VSlVKTElISkJNSUNKTE5IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlMTUM3Bg++
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
> Add a request() ops that call pinctrl_gpio_request() when the required
> gpio-ranges prop has been defined to signal pinctrl driver to use gpio
> pinmux.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch from "rockchip: Add gpio request() ops" series
> ---
>   drivers/gpio/rk_gpio.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
> index 5972f7f8612d..65811dbc78d6 100644
> --- a/drivers/gpio/rk_gpio.c
> +++ b/drivers/gpio/rk_gpio.c
> @@ -126,6 +126,15 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
>   	return (data & mask) ? GPIOF_OUTPUT : GPIOF_INPUT;
>   }
>   
> +static int rockchip_gpio_request(struct udevice *dev, unsigned offset,
> +				 const char *label)
> +{
> +	if (CONFIG_IS_ENABLED(PINCTRL) && dev_read_bool(dev, "gpio-ranges"))
> +		return pinctrl_gpio_request(dev, offset, label);
> +
> +	return 0;
> +}
> +
>   /* Simple SPL interface to GPIOs */
>   #ifdef CONFIG_SPL_BUILD
>   
> @@ -229,6 +238,7 @@ static int rockchip_gpio_probe(struct udevice *dev)
>   }
>   
>   static const struct dm_gpio_ops gpio_rockchip_ops = {
> +	.request		= rockchip_gpio_request,
>   	.direction_input	= rockchip_gpio_direction_input,
>   	.direction_output	= rockchip_gpio_direction_output,
>   	.get_value		= rockchip_gpio_get_value,
