Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E309EEE49A8
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 08:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6328700F;
	Mon, 21 Aug 2023 10:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="uU4YtCOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4E68700F; Mon, 21 Aug 2023 10:28:42 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B7B86C35
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 10:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpanis@baylibre.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-991c786369cso403699466b.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692606516; x=1693211316; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ugf9iwbVsZ+0LJnlG0/aioqKJ2i/89gBX+SImrML7iA=;
 b=uU4YtCODOPH35iaNLq60l7mMitUcTs2n8foCIKD8wixJEOi8Oo8Gpg8ouVqMfgRwJ4
 9bA8dwHPDyG7Z0yua8xL01Bo0EsvBy45EQROZ7p70PQ2p+wmQVvnCpKqFMNbeTZHBk5u
 b9i2YdRVSswur9Csy45xsIWwJSeGbQPHGen7fg3ZrqBcLtUsDMpkVEeWNDr1UweHKwpI
 EjT9ES8agco4YE6VSlWlCaRpCczByiF/9WQ8FoSUapRIyyI02QNhcauLR+yveTAxiZo+
 H5pjhxq6zrwK44Va06WtsA35pECTniT8dFTX9PGDzkDYdKkqhuaSU7ZMq37J7IEQs15Y
 XxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692606516; x=1693211316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ugf9iwbVsZ+0LJnlG0/aioqKJ2i/89gBX+SImrML7iA=;
 b=dSht9nOq3MCPLK23ZtspEOuXjmEHyG9G7d5AZzuF0YqopFmK16B+22KbSIml9tTrTX
 EJIYo8a/IAEsSK0025uAo4389lfgY7dYLDwNAZv6nVYhcwg3CGs4jxbPgVGs/KwE9NGo
 s+oCg58GbI1UHH9U3EouYdnMK3GgWvFwlXzjTr598dl82LbjX3RcnHkyzHW8TX4F8FnQ
 +wIDJOIPu7FLgbUA7feoQzp4SS2RWcKUZmu1MBVDckMn87rWgga2AdHPMRS6ANJUbe3L
 6tD70cm+Uotmp81jTyz7YOcvJHkOb12NoHES57nDaRgB5GD3kbxf2XYDmI3tP5icNfsy
 J/Tg==
X-Gm-Message-State: AOJu0YxdsjedxG3kZXG/p1DtfLvivcxtdE+IJYbz08XVDRK/gDQ6oJdQ
 viKI+JNGqaGierKjlaGJxLOkXg==
X-Google-Smtp-Source: AGHT+IELFd/sgNuy9Vg7aYOUe527GrI8Zmt/apiWIGqNv27vZLWUFRQg3DifJi7pKu3dDZd+r0jH9Q==
X-Received: by 2002:a17:906:8477:b0:993:dcca:9607 with SMTP id
 hx23-20020a170906847700b00993dcca9607mr4714504ejc.2.1692606515678; 
 Mon, 21 Aug 2023 01:28:35 -0700 (PDT)
Received: from [192.168.1.70] ([86.71.62.228])
 by smtp.gmail.com with ESMTPSA id
 e22-20020a170906249600b0099cc1ffd8f5sm6095752ejb.53.2023.08.21.01.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 01:28:34 -0700 (PDT)
Message-ID: <500449e0-0d65-44b4-aa0b-3596292f79e3@baylibre.com>
Date: Mon, 21 Aug 2023 10:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] musb-new: ti-musb: Handle usb dual-role feature as
 peripheral
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, tony@atomide.com,
 rogerq@kernel.org, vigneshr@ti.com, nm@ti.com
References: <20230621-fix_usb_ether_init-v4-0-5f4977bb7678@baylibre.com>
 <20230621-fix_usb_ether_init-v4-1-5f4977bb7678@baylibre.com>
 <20230814171801.GC3630934@bill-the-cat>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20230814171801.GC3630934@bill-the-cat>
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

On 8/14/23 19:18, Tom Rini wrote:
> On Thu, Jul 06, 2023 at 12:40:22PM +0200, Julien Panis wrote:
>
>> This prevents from getting some 'No USB device found' error,
>> in usb_ether_init() function for instance.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> Reviewed-by: Tony Lindgren <tony@atomide.com>
>> Reviewed-by: Nishanth Menon <nm@ti.com>
>> ---
>>   drivers/usb/musb-new/ti-musb.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
>> index 3be3f93dd85d..44697dc31387 100644
>> --- a/drivers/usb/musb-new/ti-musb.c
>> +++ b/drivers/usb/musb-new/ti-musb.c
>> @@ -302,6 +302,7 @@ static int ti_musb_wrapper_bind(struct udevice *parent)
>>   		dr_mode = usb_get_dr_mode(node);
>>   		switch (dr_mode) {
>>   		case USB_DR_MODE_PERIPHERAL:
>> +		case USB_DR_MODE_OTG:
>>   			/* Bind MUSB device */
>>   			ret = device_bind_driver_to_node(parent,
>>   							 "ti-musb-peripheral",
> Julien, why don't we support OTG mode here instead?
>

Roger, can this be achieved with this controller ?
