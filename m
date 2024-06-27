Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF1C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 23:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4773F88578;
	Fri, 28 Jun 2024 01:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b0vC7m1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5678857D; Fri, 28 Jun 2024 01:26:03 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F5A884A9
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 01:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7f3c5af0a04so180504639f.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719530759; x=1720135559; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oiCSBcclVveDbdqTD54Eha5tojNYdncT+zlabvqMC04=;
 b=b0vC7m1okRyw5QgWlPfAM6ZBCxDC8hmHU0PLWoa5gvTvhEtzDsdnH7z2QL8v7GMt3T
 DWfAkw3tvRAl1A9JOvmgofxGRSMtBhmR1h8Qnp6vlE9vfxv2ZBDRbWNg/VjH5HoVvqgK
 IEPuAdEVxgGM7IgSlb/n9b3Y3xPGr+GOdX1u6fZdo+YrCZqJKlJfdsTc9KEa6lV+rDMc
 hakoE774sIgf6vGcdxVIPc+mhPdFGpppNNZXlTAJgP6WXVe/qEQYy0eMocl1R2Dki3N1
 RvhiwvVz7mzx5R2NHCgBDBo+snvz2FTtRk8XiMd3NKMTdyHSrsRcYMNfOhsFP1goFT8i
 2jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719530759; x=1720135559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oiCSBcclVveDbdqTD54Eha5tojNYdncT+zlabvqMC04=;
 b=Ci/Hx/JfcYo91Lo/lpB5lqXf+WhXHLUgwlNGz3H/SBFWmE//C62LNy1OIeDb5vPxWZ
 NvSZInCXKwQ13JNAit4YFvaTwu9U+AX0CToPzEqK/XRfb3Nw5W57NA00eCPHbE+E7/a4
 1Thu8Qeb3FJcXEwsz0oMEwtj8SaR6yBgiyOP9kAhdcNroLOfa/WG056VBEjuOVkrWovt
 2M0PK0/Qw3gSbkq3F9b1EGjr3F4DlZFk1MWzFwm/wWkzCxoklB8hWyTe4L5Pi6Zbhxdn
 GXJmLlwhNb7y2dnCwvGG+2wfGO2BSziK70w6NsoXbBMKmPSJgobIX5uDwDMWe1BBRMOo
 vnlQ==
X-Gm-Message-State: AOJu0YxCV8DRoKBnaqqYX8T64Dv9pSkDF7caH0vN/3NQ8QNKSSZ4fwku
 00TkBHZTEFsrgU+j9hDVmtRk0TjYfMIkgyp+i0ey7XKMM20XGctU
X-Google-Smtp-Source: AGHT+IHGLpizPgJET9zPqYZ4lXyddNpUlIHPVr42p4/A8inntWAP7kTmXhlAzDO0H/lwEp8ON/vxiQ==
X-Received: by 2002:a05:6602:1685:b0:7eb:898f:1c76 with SMTP id
 ca18e2360f4ac-7f3a74e4466mr1851374739f.6.1719530758959; 
 Thu, 27 Jun 2024 16:25:58 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:8fad:bda4:c25d:403e?
 ([2001:470:42c4:101:8fad:bda4:c25d:403e])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4bb73277ab0sm200628173.0.2024.06.27.16.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 16:25:58 -0700 (PDT)
Message-ID: <9716fa71-d010-4444-979f-d120c558426c@gmail.com>
Date: Thu, 27 Jun 2024 17:25:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: musb-new: sunxi: make compatible with UDC/DM
 gadget model
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, John Watts <contact@jookia.org>
References: <20230608195631.55364-1-CFSworks@gmail.com>
 <20230608195631.55364-3-CFSworks@gmail.com>
 <20240627160639.2353fd1e@donnerap.manchester.arm.com>
Content-Language: en-US
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20240627160639.2353fd1e@donnerap.manchester.arm.com>
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

On 6/27/24 09:06, Andre Przywara wrote:
> On Thu,  8 Jun 2023 13:56:31 -0600
> Sam Edwards <cfsworks@gmail.com> wrote:
> 
> Hi,
> 
> John asked me have a look at this.

Hi Andre, it's good to hear from you again,

I'd first like to make sure you're aware that the date on this patch is 
June *2023,* not June 2024. It's possible things have changed 
substantially in the past year. I do not know if this patch is still a 
necessity; though if John is nudging about it, it probably is.

> 
>> Since many sunxi boards do not implement a `board_usb_init`, it's
> 
> I am confused, what has this have to do with gadget support? *No* sunxi
> board build provides board_usb_init(), but apparently this works fine for
> now.
> I am all for this converting to DM part, but the rationale seems a bit
> off.

For context, board_usb_init() is (was?) the non-DM entry point for USB 
functionality; it is (was?) *the* implementation of 
usb_gadget_initialize() when !DM_USB_GADGET.

> 
> Also can you give some reason for this patch? What does this fix or
> improve? "it's better" is a bit thin, "complying with DM" would already be
> sufficient, but maybe there is more?

Eh, yeah, "better" is something of a question-begging word isn't it? :)

The main point is to be compatible with DM's view of UDC, which as you 
said is a worthy goal in itself. It's "better" because this allows using 
DM's all-purpose implementation of usb_gadget_initialize(), which is 
(was?) necessary for those targets lacking board_usb_init().

> 
>> better if we just make the sunxi USB driver compatible with the
>> DM gadget model, as many other musb-new variants already are.
>>
>> This change has been verified working on a T113s.
>>
>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
>> ---
>>   drivers/usb/musb-new/sunxi.c | 50 +++++++++++++++++++++++-------------
>>   1 file changed, 32 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
>> index 510b254f7d..6658cd995d 100644
>> --- a/drivers/usb/musb-new/sunxi.c
>> +++ b/drivers/usb/musb-new/sunxi.c
>> @@ -444,6 +444,16 @@ static struct musb_hdrc_config musb_config_h3 = {
>>   	.ram_bits	= SUNXI_MUSB_RAM_BITS,
>>   };
>>   
>> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> 
> Please no more #ifdef's. Is there any reason to *not* force
> DM_USB_GADGET now, for all sunxi boards, in Kconfig?
> Either by "select"ing it in the USB Kconfig, or in arch/arm/Kconfig, like
> other platforms do.
> Then you don't need to care about the !DM_USB_GADGET definition of this
> function and can drop the #ifdef.

I wouldn't be the one to ask. I can't think of any such reason myself. 
But to me it sounds like since *no sunxi board provides 
board_usb_init()* the only way USB gadgets *could* work is with 
DM_USB_GADGET? That'd be reason enough to force it.

> 
>> +int dm_usb_gadget_handle_interrupts(struct udevice *dev) {
> 
> coding style

Sentence fragments are harder to understand. I am assuming you are 
saying, "Please put the opening '{' on its own line."

> 
>> +	struct sunxi_glue *glue = dev_get_priv(dev);
>> +	struct musb_host_data *host = &glue->mdata;
>> +
>> +	host->host->isr(0, host->host);
>> +	return 0;
>> +}
>> +#endif
>> +
>>   static int musb_usb_probe(struct udevice *dev)
>>   {
>>   	struct sunxi_glue *glue = dev_get_priv(dev);
>> @@ -452,10 +462,6 @@ static int musb_usb_probe(struct udevice *dev)
>>   	void *base = dev_read_addr_ptr(dev);
>>   	int ret;
>>   
>> -#ifdef CONFIG_USB_MUSB_HOST
>> -	struct usb_bus_priv *priv = dev_get_uclass_priv(dev);
>> -#endif
>> -
>>   	if (!base)
>>   		return -EINVAL;
>>   
>> @@ -486,23 +492,31 @@ static int musb_usb_probe(struct udevice *dev)
>>   	pdata.platform_ops = &sunxi_musb_ops;
>>   	pdata.config = glue->cfg->config;
>>   
>> -#ifdef CONFIG_USB_MUSB_HOST
>> -	priv->desc_before_addr = true;
>> +	if (IS_ENABLED(CONFIG_USB_MUSB_HOST)) {
>> +		struct usb_bus_priv *priv = dev_get_uclass_priv(dev);
>> +		priv->desc_before_addr = true;
>>   
>> -	pdata.mode = MUSB_HOST;
>> -	host->host = musb_init_controller(&pdata, &glue->dev, base);
>> -	if (!host->host)
>> -		return -EIO;
>> +		pdata.mode = MUSB_HOST;
>> +		host->host = musb_init_controller(&pdata, &glue->dev, base);
>> +		if (!host->host)
>> +			return -EIO;
>>   
>> -	return musb_lowlevel_init(host);
>> -#else
>> -	pdata.mode = MUSB_PERIPHERAL;
>> -	host->host = musb_register(&pdata, &glue->dev, base);
>> -	if (IS_ERR_OR_NULL(host->host))
>> -		return -EIO;
>> +		return musb_lowlevel_init(host);
>> +	} else if (CONFIG_IS_ENABLED(DM_USB_GADGET)) {
>> +		pdata.mode = MUSB_PERIPHERAL;
>> +		host->host = musb_init_controller(&pdata, &glue->dev, base);
>> +		if (!host->host)
>> +			return -EIO;
>>   
>> -	return 0;
>> -#endif
>> +		return usb_add_gadget_udc(&glue->dev, &host->host->g);
>> +	} else {
>> +		pdata.mode = MUSB_PERIPHERAL;
>> +		host->host = musb_register(&pdata, &glue->dev, base);
>> +		if (IS_ERR_OR_NULL(host->host))
>> +			return -EIO;
>> +
>> +		return 0;
>> +	}
> 
> That looks like a good cleanup! Just need to test it briefly, but it seems
> like the gist of this patch is fine.

I think it would be wise to test it a little better than "briefly" given 
the age of the patch. I'm not well-equipped to do any testing myself 
right now or I'd volunteer.

> 
> Cheers,
> Andre

Likewise,
Sam

> 
> 
>>   }
>>   
>>   static int musb_usb_remove(struct udevice *dev)
> 
