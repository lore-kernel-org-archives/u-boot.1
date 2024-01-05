Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A9FC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 16:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6EC87756;
	Fri,  5 Jan 2024 17:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="c+7gw7EP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B67F87756; Fri,  5 Jan 2024 17:49:01 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA28887646
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 17:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1704473338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTo2v53U7Ncc4gMW+Sbbt+kRLQ7SsKIo8NoqdG36OdA=;
 b=c+7gw7EPWO1M+/P9IjxJKAZmQqf+tzWtfI33pEpiSwlWn4XJbPjuFqRHr9HxyAI3w2FTIq
 DqlQ8SytNneFMfQstHQvStV4BPmeMWY+COaVLR756B6OBzpnQ6xd0OsNaqf+CbmfFzL9vp
 YaFRxVaJeOIXbAfgZn3CERJhJwDkHR3cYcxfuec7YCRpW5a33MM1xEWp68FJVlj2jOq0EH
 PoekA6UZRd1C7MiKbkoO/8q49PLZg0LRM2niZF2m/yeP++LUxXgqhe0F4dMu0WqXd/N1Iu
 4NriO1gRJB0EQjhqIGlUir5tbGC0Rvt3jvegGTM97Ghil2l8aH5gWjtenl8wQw==
Date: Fri, 05 Jan 2024 17:48:58 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] iommu: dont fail silently
In-Reply-To: <88e77866-aa47-4b11-a576-c27b9478c902@linaro.org>
References: <20240104171335.342540-1-caleb.connolly@linaro.org>
 <60f78ec8b817790733b37f9ba92628b8@manjaro.org>
 <a220fa60-8560-4185-8c4d-a41dc0c455ce@linaro.org>
 <48910a6211deb853ac93c42291f2283d@manjaro.org>
 <88e77866-aa47-4b11-a576-c27b9478c902@linaro.org>
Message-ID: <48e3291e9108fe2642552975191aa6a1@manjaro.org>
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

On 2024-01-05 17:09, Caleb Connolly wrote:
> On 05/01/2024 14:47, Dragan Simic wrote:
>> On 2024-01-05 14:55, Caleb Connolly wrote:
>>> On 04/01/2024 17:47, Dragan Simic wrote:
>>>> On 2024-01-04 18:12, Caleb Connolly wrote:
>>>>> When attempting to probe a device which has an associated IOMMU, if 
>>>>> the
>>>>> IOMMU device can't be found (no driver, disabled driver, driver 
>>>>> failed
>>>>> to probe, etc) then we currently fail to probe the device with no
>>>>> discernable error.
>>>>> 
>>>>> If we fail to hook the device up to its IOMMU, we should make sure 
>>>>> that
>>>>> the user knows about it. Write some better error messages for
>>>>> dev_iommu_enable() to facilitate this.
>>>> 
>>>> Quite frankly, I think those should remain as debug-only error 
>>>> messages,
>>>> but of course with the additional details you added.  The reasoning
>>>> behind it would be to use debug builds while testing, to be able to 
>>>> see
>>>> any error messages, and then use production, size-optimized builds
>>>> later.  I hope you agree.
>>>> 
>>>> There are many other places where using log messages instead of 
>>>> debug
>>>> messages would be really useful in the field, such as in the MMC
>>>> drivers, but we'd quickly start increasing the image sizes if we 
>>>> start
>>>> converting those from debug to log messages.
>>> 
>>> The problem is that with a debug build there are SO MANY messages, 
>>> it's
>>> hard to spot actual errors in the midst of the other stuff. I would
>>> rather see some actual numbers to justify breaking ease-of-use like 
>>> this.
>> 
>> As a reminder, debugging can be enabled on a per-file basis, which is
>> usually the way it's performed.  In other words, debug messages 
>> usually
>> get enabled during development only on the files you're actually 
>> working
>> on, and perhaps on a few more related files.
> 
> Yes, and this would be fine, but when I need to know to add "#define
> LOG_DEBUG" specifically to drivers/iommu/iommu-uclass.c to know that my
> driver failed to probe due to the IOMMU device not being found... Well,
> you can see how that isn't super useful in this case.

Oh, I see and I know it very well first hand.  For example, I spent ages 
once debugging some MMC-related issue, just because no logs were 
produced unless debugging was enabled.  On the other hand, pinpointing 
the issue with the debugging enabled was a five-minute job.  That was 
the hard way for me to learn to enable debugging first where it's 
required during development.

> Maybe adding a single error message to device_probe() if the call to
> dev_iommu_enable() fails would be a sensible middleground here?

Please, don't get me wrong, I'm not opposing an approach like that, but 
how about maybe going one step further and introducing another debug 
level at the same time?  That new debug level would include a 
small-enough subset of highly important debug messages so that it could 
be enabled at the top level during development, without breaking the 
image size constraints.

Of course, it would take time for various parts of U-Boot to migrate to 
using that new debug level, but given enough time and taking the 
usability into account, it probably should happen eventually.  It would 
be highly useful during development, IMHO, while still keeping the 
production image sizes down.

>>> I can definitely foresee folks hitting this error path when using an
>>> incompatible devicetree, having absolutely no idea where to start
>>> debugging is pretty frustrating and I don't think it's the right
>>> tradeoff to make in this case.
>> 
>> I see.  Perhaps we should hear opinions from other people as well.
> 
> Yeah, I'm curious to know how others feel about this.

Yes, and I'd love to also hear opinions about the new debug level, 
described above.  Maybe it would simply be too convoluted;  if deemed 
so, I'm fine with the middle ground that you proposed above.

>>> If you're really space constrained then wouldn't you disable log
>>> messages altogether?
>> 
>> Of course not, but there aren't _that_ many log messages already. 
>> Actually, "oh, logging that would be nice" has crossed my mind many
>> times, while either debug messages were already in place, or there was
>> nothing logged at all.
> 
> Well, you can disable logging but still get printf() outputs I mean...

Quite frankly, I've always felt that simply using printf() is a bit out 
of place.  We should instead aim toward having granular and manageable 
log levels, if you agree.

>>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>>> ---
>>>>>  drivers/iommu/iommu-uclass.c | 13 ++++++++-----
>>>>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>>>> 
>>>>> diff --git a/drivers/iommu/iommu-uclass.c
>>>>> b/drivers/iommu/iommu-uclass.c
>>>>> index 6babc0e3a672..dff3239cccb1 100644
>>>>> --- a/drivers/iommu/iommu-uclass.c
>>>>> +++ b/drivers/iommu/iommu-uclass.c
>>>>> @@ -86,16 +86,16 @@ int dev_iommu_enable(struct udevice *dev)
>>>>>          ret = dev_read_phandle_with_args(dev, "iommus",
>>>>>                           "#iommu-cells", 0, i, &args);
>>>>>          if (ret) {
>>>>> -            debug("%s: dev_read_phandle_with_args failed: %d\n",
>>>>> -                  __func__, ret);
>>>>> +            log_err("%s: Failed to parse 'iommus' property for 
>>>>> '%s':
>>>>> %d\n",
>>>>> +                __func__, dev->name, ret);
>>>>>              return ret;
>>>>>          }
>>>>> 
>>>>>          ret = uclass_get_device_by_ofnode(UCLASS_IOMMU, args.node,
>>>>>                            &dev_iommu);
>>>>>          if (ret) {
>>>>> -            debug("%s: uclass_get_device_by_ofnode failed: %d\n",
>>>>> -                  __func__, ret);
>>>>> +            log_err("%s: Failed to find IOMMU device for '%s': 
>>>>> %d\n",
>>>>> +                __func__, dev->name, ret);
>>>>>              return ret;
>>>>>          }
>>>>>          dev->iommu = dev_iommu;
>>>>> @@ -106,8 +106,11 @@ int dev_iommu_enable(struct udevice *dev)
>>>>>          ops = device_get_ops(dev->iommu);
>>>>>          if (ops && ops->connect) {
>>>>>              ret = ops->connect(dev);
>>>>> -            if (ret)
>>>>> +            if (ret) {
>>>>> +                log_err("%s: Failed to connect '%s' to IOMMU '%s':
>>>>> %d\n",
>>>>> +                    __func__, dev->name, dev->iommu->name, ret);
>>>>>                  return ret;
>>>>> +            }
>>>>>          }
>>>>>      }
