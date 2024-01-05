Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9D4C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 14:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 717F787952;
	Fri,  5 Jan 2024 15:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="lyz4z7zH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231298797C; Fri,  5 Jan 2024 15:47:06 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A1087282
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 15:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1704466023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mdJKEVun5neBMDaGgQ2kIrpBVpE8YlYjqPbNGfumA0=;
 b=lyz4z7zHH1EQkx/Vb6uLqG3bcHgWOQu/bENbJnj4v6Lvag+bY4elrPsJ9XiM4fIKmzL9wc
 sxp2qpYec7MvN4bfPbJNobdQXh7TJ27V2goFokjQd3X6w8cy0uFHF3kSE9xRErMJ4+7SiW
 rgm+gGm8wnoD7VKdJfA65rrXqLXpakf/C11FTJHK9pIIuIKAMHaPP7mVG2HGaniGbcRqF8
 kkOzC3tZOWzlto0TV7xMEdoji8pMtzWTRDlrk7o15a57AukPW/b0rXIMKbMkoVZemxEjg4
 g2Ua2xtHxg3woaOQaW0znXNUbuyHCaW0tmmRPco2+qF0BT7uQXVEmX6FO35hzA==
Date: Fri, 05 Jan 2024 15:47:02 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] iommu: dont fail silently
In-Reply-To: <a220fa60-8560-4185-8c4d-a41dc0c455ce@linaro.org>
References: <20240104171335.342540-1-caleb.connolly@linaro.org>
 <60f78ec8b817790733b37f9ba92628b8@manjaro.org>
 <a220fa60-8560-4185-8c4d-a41dc0c455ce@linaro.org>
Message-ID: <48910a6211deb853ac93c42291f2283d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-01-05 14:55, Caleb Connolly wrote:
> On 04/01/2024 17:47, Dragan Simic wrote:
>> On 2024-01-04 18:12, Caleb Connolly wrote:
>>> When attempting to probe a device which has an associated IOMMU, if 
>>> the
>>> IOMMU device can't be found (no driver, disabled driver, driver 
>>> failed
>>> to probe, etc) then we currently fail to probe the device with no
>>> discernable error.
>>> 
>>> If we fail to hook the device up to its IOMMU, we should make sure 
>>> that
>>> the user knows about it. Write some better error messages for
>>> dev_iommu_enable() to facilitate this.
>> 
>> Quite frankly, I think those should remain as debug-only error 
>> messages,
>> but of course with the additional details you added.  The reasoning
>> behind it would be to use debug builds while testing, to be able to 
>> see
>> any error messages, and then use production, size-optimized builds
>> later.  I hope you agree.
>> 
>> There are many other places where using log messages instead of debug
>> messages would be really useful in the field, such as in the MMC
>> drivers, but we'd quickly start increasing the image sizes if we start
>> converting those from debug to log messages.
> 
> The problem is that with a debug build there are SO MANY messages, it's
> hard to spot actual errors in the midst of the other stuff. I would
> rather see some actual numbers to justify breaking ease-of-use like 
> this.

As a reminder, debugging can be enabled on a per-file basis, which is 
usually the way it's performed.  In other words, debug messages usually 
get enabled during development only on the files you're actually working 
on, and perhaps on a few more related files.

> I can definitely foresee folks hitting this error path when using an
> incompatible devicetree, having absolutely no idea where to start
> debugging is pretty frustrating and I don't think it's the right
> tradeoff to make in this case.

I see.  Perhaps we should hear opinions from other people as well.

> If you're really space constrained then wouldn't you disable log
> messages altogether?

Of course not, but there aren't _that_ many log messages already.  
Actually, "oh, logging that would be nice" has crossed my mind many 
times, while either debug messages were already in place, or there was 
nothing logged at all.

>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>  drivers/iommu/iommu-uclass.c | 13 ++++++++-----
>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/drivers/iommu/iommu-uclass.c 
>>> b/drivers/iommu/iommu-uclass.c
>>> index 6babc0e3a672..dff3239cccb1 100644
>>> --- a/drivers/iommu/iommu-uclass.c
>>> +++ b/drivers/iommu/iommu-uclass.c
>>> @@ -86,16 +86,16 @@ int dev_iommu_enable(struct udevice *dev)
>>>          ret = dev_read_phandle_with_args(dev, "iommus",
>>>                           "#iommu-cells", 0, i, &args);
>>>          if (ret) {
>>> -            debug("%s: dev_read_phandle_with_args failed: %d\n",
>>> -                  __func__, ret);
>>> +            log_err("%s: Failed to parse 'iommus' property for '%s':
>>> %d\n",
>>> +                __func__, dev->name, ret);
>>>              return ret;
>>>          }
>>> 
>>>          ret = uclass_get_device_by_ofnode(UCLASS_IOMMU, args.node,
>>>                            &dev_iommu);
>>>          if (ret) {
>>> -            debug("%s: uclass_get_device_by_ofnode failed: %d\n",
>>> -                  __func__, ret);
>>> +            log_err("%s: Failed to find IOMMU device for '%s': 
>>> %d\n",
>>> +                __func__, dev->name, ret);
>>>              return ret;
>>>          }
>>>          dev->iommu = dev_iommu;
>>> @@ -106,8 +106,11 @@ int dev_iommu_enable(struct udevice *dev)
>>>          ops = device_get_ops(dev->iommu);
>>>          if (ops && ops->connect) {
>>>              ret = ops->connect(dev);
>>> -            if (ret)
>>> +            if (ret) {
>>> +                log_err("%s: Failed to connect '%s' to IOMMU '%s':
>>> %d\n",
>>> +                    __func__, dev->name, dev->iommu->name, ret);
>>>                  return ret;
>>> +            }
>>>          }
>>>      }
