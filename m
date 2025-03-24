Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7A2C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 09:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2410D81EDD;
	Mon, 24 Mar 2025 10:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sVvTp2Wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D075D81F45; Mon, 24 Mar 2025 10:23:20 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49FE81EA2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so30657575e9.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742808198; x=1743412998; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uhtQTQ/ILQlchTbkDkLcCo0qbkgY00aSh8UwJMQtnOQ=;
 b=sVvTp2Wj5v1ds3YtSK6KlWG/Ziara07gExpItEilB5vaQoc1VNaNGWA9kKpLNnOWU/
 PxgsdQUp/0NerTT51biyNA4KKGpY1erWBn5+yk7txoAoNl9Qo+eu4ssR5Wblgnw/yP9s
 sGjdQTvgcG05peHZS9xoSmWiI1HV5Y/katSXGo5CyZfQHNGXlVwD8fAe3t0BBeH40dA5
 LYU6dSbhE+TOFs3yczz1MO9gKwnSRWibYBLcIYQBPLS/WvvS+GfY1TDTeV0cFc2avr2Y
 4B/CQnm/kjt9Yb1+OgLcREzEwJodCbU2qJRcHsm+XMSEibRq2O9vBmiIKDUrmnTid3Ro
 9djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742808198; x=1743412998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uhtQTQ/ILQlchTbkDkLcCo0qbkgY00aSh8UwJMQtnOQ=;
 b=i7Y94ccRv/xMgTz3C0Hc8Etks7AL3pS31Y/YzlwQlrTNiDrZL7DmCUUBHlfo/CJRQH
 tlKHLx/b8IK9ZtgDaMUde8Eu/JexANCo9mJ0bNr+/2zopo8aTXrlwRR1d6YUAm3ytxfb
 kbp7v0muFbZYgh6/nKbrRwWyGfoIaGRL0E9MniLXUUXtKLEKdS0WEw1LoWOfmr0u6xpX
 YAPZ5uESe9mCaTSiyWZp4VQgfOI3XqSS2QRYoHE7Bxgw+IvEzi3tOL3WlaS/3FA7wx+x
 W8z9wAPtzhMbTzaxwlGa/vgdD90l2Z6X8F7lXK8wnXPkKaYhR3VbTJ4z1dVpKDKFRX5U
 LgKw==
X-Gm-Message-State: AOJu0YzLQ5XQN+8qwdkLmsuOeRqRqCpZPLw0/Zd067MRLym/22HP29P0
 U1Jocnxts+qYbbvqFYfZDLeNjwzOrMddRZdjZ8l8Zr/QoA9EwjMIKJ1VVDON0Ns=
X-Gm-Gg: ASbGncuZUnCBjb/Mxedrz5mqcER7jcLMNCBV/WVoorJ6hzyiJHW+qQ9qqZ5QvOaIcf0
 kpaKUcHbL4q1D+2GRR3kBpYv8E6ZZ6q7j0YtNamyHbz6jfRIVblvn6qEUohQkzeAgtxi/U2HzpV
 U251MqPRrpzF+Fb+YUXBOkBDDfRzkHtw3/hJz7i/LxXeTBZ5I3raflbKETwLRfjcDyHTpSx073B
 xjURLtWAww4FInS91d1cNT+4E8vPbh9XfB6NcuKSYKmQA1ySXV4bXm835NvEiGEcRZVDkXFh/Q7
 wNvqIPtu32LGoN4lJ9TcctRnICXJ+gCYrxbCHwIx50NPcFo5zXij
X-Google-Smtp-Source: AGHT+IFKQtcvt4CPV7wbLNhw13FlrSsoNRJL5dwg0oKNAeZ32UPRYC7qieVjgHEK2C5f1+IVYILgag==
X-Received: by 2002:a05:600c:4d1f:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-43d5100ba49mr81032465e9.17.1742808198030; 
 Mon, 24 Mar 2025 02:23:18 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fcea6ecsm115185735e9.5.2025.03.24.02.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 02:23:17 -0700 (PDT)
Message-ID: <68c868ea-33eb-4239-9598-f3d80943a959@linaro.org>
Date: Mon, 24 Mar 2025 11:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: atmel: Add SAM9X60 support
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
References: <20250322205625.1330306-1-admin@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250322205625.1330306-1-admin@hifiphile.com>
Content-Type: text/plain; charset=UTF-8
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



On 3/22/25 22:56, Zixun LI wrote:
> Add compatible "microchip,sam9x60-udc" and device tree binding.
> Compared to SAM9X5 the only difference is the DPRAM memory from the
> USB High Speed Device Port (UDPHS) hardware block was increased,
> so we can reuse the same endpoint data.
> 
> Tested on SAM9X60-Curiosity board with nfs and ums commands.

Why no patch to enable it on the board as well then ?

> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  arch/arm/dts/sam9x60.dtsi                        | 14 ++++++++++++++
>  arch/arm/mach-at91/include/mach/atmel_usba_udc.h |  2 +-
>  drivers/usb/gadget/atmel_usba_udc.c              |  1 +

Device tree and driver changes should be separate commits.


>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> index 3b684fc63d5..96a8faf09b3 100644
> --- a/arch/arm/dts/sam9x60.dtsi
> +++ b/arch/arm/dts/sam9x60.dtsi
> @@ -69,6 +69,20 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		usb0: gadget@500000 {
> +			compatible = "microchip,sam9x60-udc";
> +			reg = <0x500000 0x100000>,
> +				<0xf803c000 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
Can you please reorder these to have them in the same order as in Linux
DTS ? (easier to diff...)

> +			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_CORE 8>;
> +			clock-names = "pclk", "hclk";
> +			assigned-clocks = <&pmc PMC_TYPE_CORE 8>;
> +			assigned-clock-rates = <480000000>;
> +			status = "disabled";
> +		};
> +
>  		usb1: usb@600000 {
>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>  			reg = <0x00600000 0x100000>;
> diff --git a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
> index 835b47d91ba..23c71985c90 100644
> --- a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
> +++ b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
> @@ -20,7 +20,7 @@
>  	}
>  
>  #if defined(CONFIG_AT91SAM9G45) || defined(CONFIG_AT91SAM9M10G45) || \
> -	defined(CONFIG_AT91SAM9X5)
> +	defined(CONFIG_AT91SAM9X5) || defined(CONFIG_SAM9X60)
>  static struct usba_ep_data usba_udc_ep[] = {
>  	EP("ep0", 0, 64, 1, 0, 0),
>  	EP("ep1", 1, 1024, 2, 1, 1),
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index a77037a7094..f9326f0a7e7 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1443,6 +1443,7 @@ static const struct udevice_id usba_udc_ids[] = {
>  	{ .compatible = "atmel,at91sam9rl-udc" },
>  	{ .compatible = "atmel,at91sam9g45-udc" },
>  	{ .compatible = "atmel,sama5d3-udc" },
> +	{ .compatible = "microchip,sam9x60-udc" },
>  	{}
>  };
>  

