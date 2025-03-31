Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B323C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 09:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF48A8129B;
	Mon, 31 Mar 2025 11:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xc/ZXP4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9387812BC; Mon, 31 Mar 2025 11:05:51 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53598006D
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 11:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-399749152b4so1645608f8f.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 02:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743411949; x=1744016749;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ownbc2w7mhGBbnc0pYCcnkUY3cf7qBA27bNUTBkjog=;
 b=Xc/ZXP4ESf+d9SkbChluTT079g7w3tNvvrz4YJiv8epWfBLhiYOQEJxuAP1UiVreJK
 LCEiYdA2qYxspoanU3zr/u4JIU9S/x/QTqm7X5u/dnW2nhTofB5ahZ8QXUofWhJBMYdc
 fODUNfGqvgZPjMlXC0SkmHetfYz4M52VvuCk6pdvqlURY3aDibydg4YTa4bn6kVeJN3P
 L9UsRZR7rHfhJYgDYhROQvbAikBtPT/vfb+bQBuuGZRptnv50rmr7taso3fJBjQFgufV
 nL+oOj7/rVfb67qGho9t+ACIMF9pnKNOWxcJ1GcV2dcykVNbSyANnrQaqAhx/jFkiOIJ
 KcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743411949; x=1744016749;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ownbc2w7mhGBbnc0pYCcnkUY3cf7qBA27bNUTBkjog=;
 b=RUG5c36u1CB0iCh+r+xU8znVWU7j5jDri6nmfZksgbip3K2t5VFMWGJ4PTZvW1Un3D
 fnm5T/RtCFFOJ+QQrCc0rDGhrGMR4l4DsBsnLj+gfHNbqJDCr0kCKluNrdW6Tlz9vYmA
 0RIBtbFvgvjzx4mSDjBfJReLTzC8M3CuHbGzYlAlXYVyvKkS6ogFp0Y8eiw+SN8nKf6Y
 kVoSlXNNUySa9xm33NdTkt9qySwiGEyxF3zaTLGFwIStrPZDHUCeXwKmYo8L/MrWtrQ6
 IvkFtEQSJ+twyvjhNVESo90YWxi4hOOMXD73DAtvK1FL/lg/D1x3cOi3NFOrig7Qr6hp
 KK1w==
X-Gm-Message-State: AOJu0YwF8r3Me6ZcfxszWMbcF5/roW/wfIFHGayOB2tb/qCG95jiKcYH
 Mps+qtkQbX4u34eOVeQM37oohkAoCkpbH667ImZZxJIDKxDxOO/l5SeBpVLTXXhzU4Y+Uj1vZCd
 R
X-Gm-Gg: ASbGncuKPG62b3/Ahh2ODzIzPuhgz9+JQu+EISRqo1zo+D8CFDEztnsu9W6l3VrzFu7
 rY6v55w7bQypA5VCtpYtgOBXZ7ZtLXO/cjQcTkxdu7bi1AWhkUabsmwhjbug2aJbO9SCm9mypol
 fVVIhGFa7cB4cwaEIIuG/4lQm1jurENikD6wuoR7+ZNREHRZPHqDzbmW6128lZrmcNezTaTI2vI
 pZuHMCDvkR2ROR4ViHLRBz8PePPEFgC1+1isp6RAoj4TtMJIPI63kYTbRF/geH1uia9g2NL5fFW
 L/NeRY1AdCv5rHc/iql3ZOx8cIVVIH46XaJ3CkYk45Fpc5R4EbOt9Jyo0ICNC4pbZ2ARlkPLrHV
 bhWEg0uAXpxhFHjhh3Q==
X-Google-Smtp-Source: AGHT+IFbIW70KMxO/Fpg+7YdfZx/Y5s0abPHdf37oiBvGi454GU+jDIpakiimp/FsVMZGYLJcH6r3Q==
X-Received: by 2002:a05:6000:2a5:b0:390:f400:2083 with SMTP id
 ffacd0b85a97d-39c1208eb5amr6449335f8f.0.1743411949070; 
 Mon, 31 Mar 2025 02:05:49 -0700 (PDT)
Received: from localhost (lfbn-tou-1-752-68.w86-250.abo.wanadoo.fr.
 [86.250.199.68]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66d56csm10848150f8f.59.2025.03.31.02.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 02:05:48 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Zixun LI
 <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: atmel: Add SAM9X60 support
In-Reply-To: <68c868ea-33eb-4239-9598-f3d80943a959@linaro.org>
References: <20250322205625.1330306-1-admin@hifiphile.com>
 <68c868ea-33eb-4239-9598-f3d80943a959@linaro.org>
Date: Mon, 31 Mar 2025 11:05:47 +0200
Message-ID: <875xjppo2c.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Eugen, Zixun,

On lun., mars 24, 2025 at 11:23, Eugen Hristev <eugen.hristev@linaro.org> wrote:

> On 3/22/25 22:56, Zixun LI wrote:
>> Add compatible "microchip,sam9x60-udc" and device tree binding.
>> Compared to SAM9X5 the only difference is the DPRAM memory from the
>> USB High Speed Device Port (UDPHS) hardware block was increased,
>> so we can reuse the same endpoint data.
>> 
>> Tested on SAM9X60-Curiosity board with nfs and ums commands.
>
> Why no patch to enable it on the board as well then ?

Looking at configs/at91sam9x5ek_mmc_defconfig, I don't see
CMD_USB_MASS_STORAGE=y in there as well.

Could you elaborate on why you'd want this to be enabled as part of the
driver series?

On one hand, users has more built-in commands available and it eases the
testing. On the other hand, some users might not be interested in having
this by default. Enabling it via menuconfig is quite easy.

>
>> 
>> Signed-off-by: Zixun LI <admin@hifiphile.com>
>> ---
>>  arch/arm/dts/sam9x60.dtsi                        | 14 ++++++++++++++
>>  arch/arm/mach-at91/include/mach/atmel_usba_udc.h |  2 +-
>>  drivers/usb/gadget/atmel_usba_udc.c              |  1 +
>
> Device tree and driver changes should be separate commits.

I agree with Eugen. Could you please split this out, Zixun?

>
>
>>  3 files changed, 16 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
>> index 3b684fc63d5..96a8faf09b3 100644
>> --- a/arch/arm/dts/sam9x60.dtsi
>> +++ b/arch/arm/dts/sam9x60.dtsi
>> @@ -69,6 +69,20 @@
>>  		#size-cells = <1>;
>>  		ranges;
>>  
>> +		usb0: gadget@500000 {
>> +			compatible = "microchip,sam9x60-udc";
>> +			reg = <0x500000 0x100000>,
>> +				<0xf803c000 0x400>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
> Can you please reorder these to have them in the same order as in Linux
> DTS ? (easier to diff...)

Agreed with Eugen.

>
>> +			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 2>;
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_CORE 8>;
>> +			clock-names = "pclk", "hclk";
>> +			assigned-clocks = <&pmc PMC_TYPE_CORE 8>;
>> +			assigned-clock-rates = <480000000>;
>> +			status = "disabled";
>> +		};
>> +
>>  		usb1: usb@600000 {
>>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>>  			reg = <0x00600000 0x100000>;
>> diff --git a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
>> index 835b47d91ba..23c71985c90 100644
>> --- a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
>> +++ b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
>> @@ -20,7 +20,7 @@
>>  	}
>>  
>>  #if defined(CONFIG_AT91SAM9G45) || defined(CONFIG_AT91SAM9M10G45) || \
>> -	defined(CONFIG_AT91SAM9X5)
>> +	defined(CONFIG_AT91SAM9X5) || defined(CONFIG_SAM9X60)
>>  static struct usba_ep_data usba_udc_ep[] = {
>>  	EP("ep0", 0, 64, 1, 0, 0),
>>  	EP("ep1", 1, 1024, 2, 1, 1),
>> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
>> index a77037a7094..f9326f0a7e7 100644
>> --- a/drivers/usb/gadget/atmel_usba_udc.c
>> +++ b/drivers/usb/gadget/atmel_usba_udc.c
>> @@ -1443,6 +1443,7 @@ static const struct udevice_id usba_udc_ids[] = {
>>  	{ .compatible = "atmel,at91sam9rl-udc" },
>>  	{ .compatible = "atmel,at91sam9g45-udc" },
>>  	{ .compatible = "atmel,sama5d3-udc" },
>> +	{ .compatible = "microchip,sam9x60-udc" },
>>  	{}
>>  };
>>  
