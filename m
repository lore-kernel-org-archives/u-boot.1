Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED8EC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 16:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9386387756;
	Fri,  5 Jan 2024 17:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GtExa8Vh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24659877D5; Fri,  5 Jan 2024 17:09:50 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989928745E
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 17:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d87df95ddso15137235e9.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704470987; x=1705075787; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r3PDwOqCCsGO1He4aseZCHhOubgDYqReWnCun570430=;
 b=GtExa8Vh7ow0AKxsRQD6fSovp/bu8F3kIYXmkGst/gijAr4bcA60fHZclgENV+9h2q
 Q8WFbhkg6zcYpnjyMW8f4HYntwiWm6h5+0JI8bIzsjHVi2eepLCFX3uzV+KljhCwdoUa
 1u3Ds0EkLJC7l8LaLKZW2tu1VmoVqu9v2roy7urqqFjMLvwg409r8Dr1ZLOwHf2MyJqh
 g1LcgvPPUJg4E+O1f2J9sVA22q6teeyZHEj+V54FAqdS+ItnJIWZZZpCKdl5X8yne/qh
 mXtFk4O+9WWwIyQ2mIogYLPaHR7X+7nXquGO16OO/ligu0l+2WQvnYx6uyXhnFIDku1t
 Of7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704470987; x=1705075787;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r3PDwOqCCsGO1He4aseZCHhOubgDYqReWnCun570430=;
 b=kbzoSBUX+2GK9fCWI4l20p6i5Qk0GUppkUGdoqauJIz28KFfdmEHo7umEfn+d8p3Ko
 Zz+Urv/N2fNB3kSR0S7z4AtDSr+laRwnKp3ekFXPbNwSDxB2vuf1t67j6OUnvmZ8NRCN
 GyW3VPXLgTJf9zMqd9RJR5mwFFzjag5489f3+ZRyL/cvmoG3nwx2xLgQBzfzy5cq+qw6
 D4FTDmTDvxoRH4QfoLiUdOdokwPn9SZ3o5HRYtlmkmHkCkmIB10a7aAd3athXR8LPgim
 RRdaGCRKJ8vNXvpl5/0KttOSTaHzfojK76D3pI9rOY+4UYyG1yVKRo0z86LPJ/LnTNti
 cUqg==
X-Gm-Message-State: AOJu0Yz/twVyRB7TSkSjyJAaEwD3DpW6j0PNS09/HTXYdu0AT8u947GY
 LUTvLqIAZ+wXoWUUUS1zoI9k/AsYsNIdtA==
X-Google-Smtp-Source: AGHT+IEBq788eHQBW/RSd+n6/+gFiGnBRP21QpmL+8Zdi3Kx7Q0R6AP5ggDh3gTch7PI4QCvSC2QjA==
X-Received: by 2002:a05:600c:6a89:b0:40d:9205:791b with SMTP id
 jl9-20020a05600c6a8900b0040d9205791bmr688178wmb.197.1704470986997; 
 Fri, 05 Jan 2024 08:09:46 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a5d4f03000000b00336344c3c3fsm1638769wru.90.2024.01.05.08.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 08:09:46 -0800 (PST)
Message-ID: <88e77866-aa47-4b11-a576-c27b9478c902@linaro.org>
Date: Fri, 5 Jan 2024 16:09:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: dont fail silently
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
References: <20240104171335.342540-1-caleb.connolly@linaro.org>
 <60f78ec8b817790733b37f9ba92628b8@manjaro.org>
 <a220fa60-8560-4185-8c4d-a41dc0c455ce@linaro.org>
 <48910a6211deb853ac93c42291f2283d@manjaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <48910a6211deb853ac93c42291f2283d@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 05/01/2024 14:47, Dragan Simic wrote:
> On 2024-01-05 14:55, Caleb Connolly wrote:
>> On 04/01/2024 17:47, Dragan Simic wrote:
>>> On 2024-01-04 18:12, Caleb Connolly wrote:
>>>> When attempting to probe a device which has an associated IOMMU, if the
>>>> IOMMU device can't be found (no driver, disabled driver, driver failed
>>>> to probe, etc) then we currently fail to probe the device with no
>>>> discernable error.
>>>>
>>>> If we fail to hook the device up to its IOMMU, we should make sure that
>>>> the user knows about it. Write some better error messages for
>>>> dev_iommu_enable() to facilitate this.
>>>
>>> Quite frankly, I think those should remain as debug-only error messages,
>>> but of course with the additional details you added.  The reasoning
>>> behind it would be to use debug builds while testing, to be able to see
>>> any error messages, and then use production, size-optimized builds
>>> later.  I hope you agree.
>>>
>>> There are many other places where using log messages instead of debug
>>> messages would be really useful in the field, such as in the MMC
>>> drivers, but we'd quickly start increasing the image sizes if we start
>>> converting those from debug to log messages.
>>
>> The problem is that with a debug build there are SO MANY messages, it's
>> hard to spot actual errors in the midst of the other stuff. I would
>> rather see some actual numbers to justify breaking ease-of-use like this.
> 
> As a reminder, debugging can be enabled on a per-file basis, which is
> usually the way it's performed.  In other words, debug messages usually
> get enabled during development only on the files you're actually working
> on, and perhaps on a few more related files.

Yes, and this would be fine, but when I need to know to add "#define
LOG_DEBUG" specifically to drivers/iommu/iommu-uclass.c to know that my
driver failed to probe due to the IOMMU device not being found... Well,
you can see how that isn't super useful in this case.

Maybe adding a single error message to device_probe() if the call to
dev_iommu_enable() fails would be a sensible middleground here?
> 
>> I can definitely foresee folks hitting this error path when using an
>> incompatible devicetree, having absolutely no idea where to start
>> debugging is pretty frustrating and I don't think it's the right
>> tradeoff to make in this case.
> 
> I see.  Perhaps we should hear opinions from other people as well.

Yeah, I'm curious to know how others feel about this.
> 
>> If you're really space constrained then wouldn't you disable log
>> messages altogether?
> 
> Of course not, but there aren't _that_ many log messages already. 
> Actually, "oh, logging that would be nice" has crossed my mind many
> times, while either debug messages were already in place, or there was
> nothing logged at all.

Well, you can disable logging but still get printf() outputs I mean...
> 
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>  drivers/iommu/iommu-uclass.c | 13 ++++++++-----
>>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu-uclass.c
>>>> b/drivers/iommu/iommu-uclass.c
>>>> index 6babc0e3a672..dff3239cccb1 100644
>>>> --- a/drivers/iommu/iommu-uclass.c
>>>> +++ b/drivers/iommu/iommu-uclass.c
>>>> @@ -86,16 +86,16 @@ int dev_iommu_enable(struct udevice *dev)
>>>>          ret = dev_read_phandle_with_args(dev, "iommus",
>>>>                           "#iommu-cells", 0, i, &args);
>>>>          if (ret) {
>>>> -            debug("%s: dev_read_phandle_with_args failed: %d\n",
>>>> -                  __func__, ret);
>>>> +            log_err("%s: Failed to parse 'iommus' property for '%s':
>>>> %d\n",
>>>> +                __func__, dev->name, ret);
>>>>              return ret;
>>>>          }
>>>>
>>>>          ret = uclass_get_device_by_ofnode(UCLASS_IOMMU, args.node,
>>>>                            &dev_iommu);
>>>>          if (ret) {
>>>> -            debug("%s: uclass_get_device_by_ofnode failed: %d\n",
>>>> -                  __func__, ret);
>>>> +            log_err("%s: Failed to find IOMMU device for '%s': %d\n",
>>>> +                __func__, dev->name, ret);
>>>>              return ret;
>>>>          }
>>>>          dev->iommu = dev_iommu;
>>>> @@ -106,8 +106,11 @@ int dev_iommu_enable(struct udevice *dev)
>>>>          ops = device_get_ops(dev->iommu);
>>>>          if (ops && ops->connect) {
>>>>              ret = ops->connect(dev);
>>>> -            if (ret)
>>>> +            if (ret) {
>>>> +                log_err("%s: Failed to connect '%s' to IOMMU '%s':
>>>> %d\n",
>>>> +                    __func__, dev->name, dev->iommu->name, ret);
>>>>                  return ret;
>>>> +            }
>>>>          }
>>>>      }

-- 
// Caleb (they/them)
