Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB107C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 13:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBDD287994;
	Fri,  5 Jan 2024 14:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DmqA8Gn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977168799A; Fri,  5 Jan 2024 14:55:19 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 455B287993
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 14:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d858c56cbso18182055e9.2
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704462917; x=1705067717; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mgJakPcjeU8X6sZG2rE5CsyVHiNqRhEgz0VxL8SdXu8=;
 b=DmqA8Gn16BTjzHK7auhauNiWUfulJVj3JKnE/dE8+WnmWpEb8x5bLfzpWTXe/N9XfU
 5nz3vxyBgBXBfRyVIj3fJe+8ywx8XB4msON4FvU0y5ctrryget/xFx5Oq5K52SuZAfdm
 DVETG5u6zOYRvD15KGjd7zywF/temyLTNsGtKGN2hLLW99ioZ/ONVxzCff3x1yQDbNxJ
 Ex/MlUCdvDz8HEUjN5ymuGH3cP5zaHWnYdAzdaCNVOEbhAmPB+MX4EWhPBl1mAxTYIEe
 iGsTRy91RpKA1WpPcgjnPRiEy4QsmzgiJVxajSweYaNElzoZHVha/LTd44VyMbWuutbL
 ysjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704462917; x=1705067717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mgJakPcjeU8X6sZG2rE5CsyVHiNqRhEgz0VxL8SdXu8=;
 b=wsePgoNFDXhwLhcRWXfTdc9abw17yNGeVTc2IKk75J6EpHt5NYgWtokGFdLRJqcaZC
 rxf+bYyT3zwVRhlUafZcjR3Q148NZz92VSO1zeF+v+oFwdz8nR/FZhyTV6iDGwGor317
 wZRhWOZQXME0+3mWe9QUXHzs+Fz/qdsnHmPc2n8xmIRUE5aIjcCLJFGKWBpfZ6jDWkCq
 63WLeg7dWvdW9+kV8+xjU9c7r9raiBCxKLJhXreGq9CpgRElzeeUF3RXJxZ92TGInM79
 5DUbZpCBBaDX9sZAmsQ4CCWhyN/8xGJEnMw+srQWn4CMMsZWUdTSN6TD80MQJhTILIA4
 Agqw==
X-Gm-Message-State: AOJu0Yx8uvbQMlNIjeCw5nrK3++ImatpRKjEVHuQFg050UJsmfu7WTRL
 XqhA6LZ5NvVWQf/hkKuD+mhzfm52DlNJuosxKXyokRCLvKsa7Q==
X-Google-Smtp-Source: AGHT+IGHgsLFLNHJ2aOvzfmdicy7DrQ+RsdSc0q+7f2jrrsSKgt5z83DkLmcubUo2wn4ixlvbIhOCA==
X-Received: by 2002:a05:600c:3792:b0:40d:5b1c:2714 with SMTP id
 o18-20020a05600c379200b0040d5b1c2714mr1340507wmr.111.1704462916583; 
 Fri, 05 Jan 2024 05:55:16 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 fc12-20020a05600c524c00b0040d5a9d6b68sm1673902wmb.6.2024.01.05.05.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 05:55:16 -0800 (PST)
Message-ID: <a220fa60-8560-4185-8c4d-a41dc0c455ce@linaro.org>
Date: Fri, 5 Jan 2024 13:55:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: dont fail silently
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
References: <20240104171335.342540-1-caleb.connolly@linaro.org>
 <60f78ec8b817790733b37f9ba92628b8@manjaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <60f78ec8b817790733b37f9ba92628b8@manjaro.org>
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



On 04/01/2024 17:47, Dragan Simic wrote:
> On 2024-01-04 18:12, Caleb Connolly wrote:
>> When attempting to probe a device which has an associated IOMMU, if the
>> IOMMU device can't be found (no driver, disabled driver, driver failed
>> to probe, etc) then we currently fail to probe the device with no
>> discernable error.
>>
>> If we fail to hook the device up to its IOMMU, we should make sure that
>> the user knows about it. Write some better error messages for
>> dev_iommu_enable() to facilitate this.
> 
> Quite frankly, I think those should remain as debug-only error messages,
> but of course with the additional details you added.  The reasoning
> behind it would be to use debug builds while testing, to be able to see
> any error messages, and then use production, size-optimized builds
> later.  I hope you agree.
> 
> There are many other places where using log messages instead of debug
> messages would be really useful in the field, such as in the MMC
> drivers, but we'd quickly start increasing the image sizes if we start
> converting those from debug to log messages.

The problem is that with a debug build there are SO MANY messages, it's
hard to spot actual errors in the midst of the other stuff. I would
rather see some actual numbers to justify breaking ease-of-use like this.

I can definitely foresee folks hitting this error path when using an
incompatible devicetree, having absolutely no idea where to start
debugging is pretty frustrating and I don't think it's the right
tradeoff to make in this case.

If you're really space constrained then wouldn't you disable log
messages altogether?

> 
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  drivers/iommu/iommu-uclass.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
>> index 6babc0e3a672..dff3239cccb1 100644
>> --- a/drivers/iommu/iommu-uclass.c
>> +++ b/drivers/iommu/iommu-uclass.c
>> @@ -86,16 +86,16 @@ int dev_iommu_enable(struct udevice *dev)
>>          ret = dev_read_phandle_with_args(dev, "iommus",
>>                           "#iommu-cells", 0, i, &args);
>>          if (ret) {
>> -            debug("%s: dev_read_phandle_with_args failed: %d\n",
>> -                  __func__, ret);
>> +            log_err("%s: Failed to parse 'iommus' property for '%s':
>> %d\n",
>> +                __func__, dev->name, ret);
>>              return ret;
>>          }
>>
>>          ret = uclass_get_device_by_ofnode(UCLASS_IOMMU, args.node,
>>                            &dev_iommu);
>>          if (ret) {
>> -            debug("%s: uclass_get_device_by_ofnode failed: %d\n",
>> -                  __func__, ret);
>> +            log_err("%s: Failed to find IOMMU device for '%s': %d\n",
>> +                __func__, dev->name, ret);
>>              return ret;
>>          }
>>          dev->iommu = dev_iommu;
>> @@ -106,8 +106,11 @@ int dev_iommu_enable(struct udevice *dev)
>>          ops = device_get_ops(dev->iommu);
>>          if (ops && ops->connect) {
>>              ret = ops->connect(dev);
>> -            if (ret)
>> +            if (ret) {
>> +                log_err("%s: Failed to connect '%s' to IOMMU '%s':
>> %d\n",
>> +                    __func__, dev->name, dev->iommu->name, ret);
>>                  return ret;
>> +            }
>>          }
>>      }

-- 
// Caleb (they/them)
