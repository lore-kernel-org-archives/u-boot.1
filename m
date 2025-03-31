Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6199C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 09:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7FFE812BC;
	Mon, 31 Mar 2025 11:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IgnLF5QW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDEFC8129B; Mon, 31 Mar 2025 11:26:50 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95AE98129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 11:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso32139585e9.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 02:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743413208; x=1744018008; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2SF2jCRUOj3PHoEiZ5usXAZOSNmyKoGjjsIgBktQOFg=;
 b=IgnLF5QWwz9hSH4qDbqmy2X1m9HQbdzbbyu227GItCKy0DGTopjE0nAoPvn6UtSqeR
 uooiN2TrLQXrbs4RXzuAcYI6uEp+Zx9ec64Mp0YBvCkMrc22s+83xt22W93XiA2meY96
 baX5G2p4/R8S2Y/nVoera42qdsrOYtFIpOlYJQWzJs6E3X19/FXfw++sA7da8O5liyap
 QFzrRfI8kf3R4puxeiBntR1pNDaCDxseZhF8KDj+s5uZV2NyuRt6yJzNL2h1sYGehIOF
 U2eS6PBbMOcQsiGD25vh2INofwJqxvM7oEIHaXkGevNVZfZpwqnZwu/09KIjXI0vK3Pw
 5j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743413208; x=1744018008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2SF2jCRUOj3PHoEiZ5usXAZOSNmyKoGjjsIgBktQOFg=;
 b=ki8P0RSwSVASd+ZgSEsof4JL6PxYpuQl7EjpqNjhtb0v8Z11Ra6iwhlPXlvB2WNd4w
 C0E8HET3zxJkU9ztPd+aNGW80MtxJDTleuGBlnAs/P4a2qJy79WyrTuKtBz9D0EJ+8BR
 T7BXOm6tIRiKFnk71g6YyHKzeTQXBLDR5aA8jGotE4vff5D36usiXXgZphDFBQBuVCAH
 KobOWZ5JN/4RHRInUcnK2nJiRDzntZTZzIvEGTY1DQ3Dee6ItOKgnRGkXYj38sQBbL+8
 c+Tqo09YIVjv8SOqu+y95C9piHQV40YHRUpBr2PIFZrEsGeDYlq10nbXpJgP3/VwSorp
 1VIg==
X-Gm-Message-State: AOJu0YykZXaNQVlCcTOoZ1/juy3DA5hAYXG6SFlUjsSQm76fgHSaSemu
 A2vIPkR7NVBmh1RxGto5wHKHobg3O99gNRcT1rfyiuXutmJlx6fzz63WwsUgrwc=
X-Gm-Gg: ASbGncsS4J8h+tMJUXSZH4FKklCV1+uOSLlP70u5OUQ4ZPyEln1NHj47LM4vYZxqjy+
 eCVtgDc29MIEr2XHagsDAe54AmIpxlmT77/Ovy04DbijTeQkPFmpbiNMdpQUmsm6ScJKpnzLE3K
 EH1UBF7soh4lFlF1woTK27+JGMY5akIpZGlDE2eLvV15c1E1HVw2sRNBawIg6v1bby9YRix+I/a
 +MOxm0RQ+m4U+/NcBOMy2LidWni7fIuWGEN0TbIORWMm8RouU+TuVQVQHSWnQVUGKH3OqpJQro0
 TVQjkOroXCQbZqnx/bLX9OEXOEbPjFCOkRes5EBfICgm601ZhyiI
X-Google-Smtp-Source: AGHT+IEUXvJnPVD9EPskXkqTF6EZclCkcISGaYZe7tiatcUyaPbs1LbutF5wq7QHiCageREMk7TerA==
X-Received: by 2002:a7b:ca50:0:b0:43d:fa58:8378 with SMTP id
 5b1f17b1804b1-43dfa588433mr47416145e9.33.1743413207831; 
 Mon, 31 Mar 2025 02:26:47 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d91439d11sm75771195e9.0.2025.03.31.02.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 02:26:47 -0700 (PDT)
Message-ID: <777fde90-8f9d-485f-ae92-6add019bb47a@linaro.org>
Date: Mon, 31 Mar 2025 12:26:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: atmel: Add SAM9X60 support
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
References: <20250322205625.1330306-1-admin@hifiphile.com>
 <68c868ea-33eb-4239-9598-f3d80943a959@linaro.org>
 <875xjppo2c.fsf@baylibre.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <875xjppo2c.fsf@baylibre.com>
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



On 3/31/25 12:05, Mattijs Korpershoek wrote:
> Hi Eugen, Zixun,
> 
> On lun., mars 24, 2025 at 11:23, Eugen Hristev <eugen.hristev@linaro.org> wrote:
> 
>> On 3/22/25 22:56, Zixun LI wrote:
>>> Add compatible "microchip,sam9x60-udc" and device tree binding.
>>> Compared to SAM9X5 the only difference is the DPRAM memory from the
>>> USB High Speed Device Port (UDPHS) hardware block was increased,
>>> so we can reuse the same endpoint data.
>>>
>>> Tested on SAM9X60-Curiosity board with nfs and ums commands.
>>
>> Why no patch to enable it on the board as well then ?
> 
> Looking at configs/at91sam9x5ek_mmc_defconfig, I don't see
> CMD_USB_MASS_STORAGE=y in there as well.
> 
> Could you elaborate on why you'd want this to be enabled as part of the
> driver series?
> 
> On one hand, users has more built-in commands available and it eases the
> testing. On the other hand, some users might not be interested in having
> this by default. Enabling it via menuconfig is quite easy.

What I meant is have the node in the board DT (gadget@500000).
That cannot be enabled in the menuconfig.
The Gadget or the Host should be described in the DT as it's a
description of the board, if the board supports both Gadget and Host ,
both should be in the DT.

If there is a hardware limitation, or something that allows only one of
these to work at the same time, this should be detailed, and have both
nodes anyway, with one of them Disabled, possibly two different DTs with
either of the nodes enabled/disabled.

> 
>>
>>>
>>> Signed-off-by: Zixun LI <admin@hifiphile.com>
>>> ---
>>>  arch/arm/dts/sam9x60.dtsi                        | 14 ++++++++++++++
>>>  arch/arm/mach-at91/include/mach/atmel_usba_udc.h |  2 +-
>>>  drivers/usb/gadget/atmel_usba_udc.c              |  1 +
>>
>> Device tree and driver changes should be separate commits.
> 
> I agree with Eugen. Could you please split this out, Zixun?
> 
>>
>>
>>>  3 files changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
>>> index 3b684fc63d5..96a8faf09b3 100644
>>> --- a/arch/arm/dts/sam9x60.dtsi
>>> +++ b/arch/arm/dts/sam9x60.dtsi
>>> @@ -69,6 +69,20 @@
>>>  		#size-cells = <1>;
>>>  		ranges;
>>>  
>>> +		usb0: gadget@500000 {
>>> +			compatible = "microchip,sam9x60-udc";
>>> +			reg = <0x500000 0x100000>,
>>> +				<0xf803c000 0x400>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>> Can you please reorder these to have them in the same order as in Linux
>> DTS ? (easier to diff...)
> 
> Agreed with Eugen.
> 
>>
>>> +			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
>>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_CORE 8>;
>>> +			clock-names = "pclk", "hclk";
>>> +			assigned-clocks = <&pmc PMC_TYPE_CORE 8>;
>>> +			assigned-clock-rates = <480000000>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>>  		usb1: usb@600000 {
>>>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>>>  			reg = <0x00600000 0x100000>;
>>> diff --git a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
>>> index 835b47d91ba..23c71985c90 100644
>>> --- a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
>>> +++ b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
>>> @@ -20,7 +20,7 @@
>>>  	}
>>>  
>>>  #if defined(CONFIG_AT91SAM9G45) || defined(CONFIG_AT91SAM9M10G45) || \
>>> -	defined(CONFIG_AT91SAM9X5)
>>> +	defined(CONFIG_AT91SAM9X5) || defined(CONFIG_SAM9X60)
>>>  static struct usba_ep_data usba_udc_ep[] = {
>>>  	EP("ep0", 0, 64, 1, 0, 0),
>>>  	EP("ep1", 1, 1024, 2, 1, 1),
>>> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
>>> index a77037a7094..f9326f0a7e7 100644
>>> --- a/drivers/usb/gadget/atmel_usba_udc.c
>>> +++ b/drivers/usb/gadget/atmel_usba_udc.c
>>> @@ -1443,6 +1443,7 @@ static const struct udevice_id usba_udc_ids[] = {
>>>  	{ .compatible = "atmel,at91sam9rl-udc" },
>>>  	{ .compatible = "atmel,at91sam9g45-udc" },
>>>  	{ .compatible = "atmel,sama5d3-udc" },
>>> +	{ .compatible = "microchip,sam9x60-udc" },
>>>  	{}
>>>  };
>>>  

