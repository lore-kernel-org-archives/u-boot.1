Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4C4C4167D
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 09:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0BE86F18;
	Wed,  1 Nov 2023 10:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ddQck87a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CEB487CD1; Wed,  1 Nov 2023 10:33:43 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 318A686B9A
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 10:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4da3=GO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1698831203;
 bh=zZnsGjTJoXx+inCs/JGGFLmg1XRPlwZXLAjFViHX8VQ=;
 b=ddQck87aMTdJKJ4xa5BHRgIqKpc/D9wTrOIC1R8HspKFqiHbGc2IIOtSpNjtGY0iCWcdBkjMj
 Iuwk+iej+R7K/9a9cPO9DuUUWaFGW3E/3o3+U5pGn8GkYzUZlZZQHASQ4yIjV7pikl3gmY+slCw
 cOz759bdb1jz3Ph/Qal3ttPHY071I9SIWnPTZvQgNa2mRbNvQF6Vm1Ia0Gi2ob01LaWz/pKDGyV
 Zg3JsS6LX1+CAXq+WdvxC9uRTjJ6ar2gBgiRUqeFoHGVjh9bboJRJtzEZTHn5oY5GR740MmiLpc
 6XVlR/0uYCrhy0hyRf19uq/+hhLp07YaWAlq2zoQ8ZLg==
Message-ID: <9e7015ae-8a1a-41dc-a960-01525ecec913@kwiboo.se>
Date: Wed, 1 Nov 2023 10:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix an handling error about EALREADY
Content-Language: en-US
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: sjg@chromium.org, patrice.chotard@foss.st.com,
 eugen.hristev@collabora.com, trini@konsulko.com, u-boot@lists.denx.de
References: <CGME20231101072318epcas1p2dbf8d1c1bbbb521c8e6744fae8e0b01d@epcas1p2.samsung.com>
 <20231101072316.190541-1-jh80.chung@samsung.com>
 <ea09f0bc-738c-4585-bc2a-eab3cd7e59ec@kwiboo.se>
 <025e01da0c9a$573ccbf0$05b663d0$@samsung.com>
 <025f01da0c9a$e4da4e60$ae8eeb20$@samsung.com>
 <026001da0c9c$20059840$6010c8c0$@samsung.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <026001da0c9c$20059840$6010c8c0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65421b62f4420dfa529c8868
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

On 2023-11-01 09:19, Jaehoon Chung wrote:
> 
> 
>> -----Original Message-----
>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
>> Sent: Wednesday, November 1, 2023 5:11 PM
>> To: 'Jonas Karlman' <jonas@kwiboo.se>
>> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com; u-
>> boot@lists.denx.de
>> Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
>>
>>
>>
>>> -----Original Message-----
>>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
>>> Sent: Wednesday, November 1, 2023 5:07 PM
>>> To: 'Jonas Karlman' <jonas@kwiboo.se>
>>> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com;
>> u-
>>> boot@lists.denx.de
>>> Subject: RE: [PATCH] power: regulator: Fix an handling error about EALREADY
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jonas Karlman <jonas@kwiboo.se>
>>>> Sent: Wednesday, November 1, 2023 4:47 PM
>>>> To: Jaehoon Chung <jh80.chung@samsung.com>
>>>> Cc: sjg@chromium.org; patrice.chotard@foss.st.com; eugen.hristev@collabora.com; trini@konsulko.com;
>>> u-
>>>> boot@lists.denx.de
>>>> Subject: Re: [PATCH] power: regulator: Fix an handling error about EALREADY
>>>>
>>>> On 2023-11-01 08:23, Jaehoon Chung wrote:
>>>>> If reegulator is already enabled, it will be return to EALREADY.
>>>>> But driver that its function is called can notice as error, even though
>>>>> it's working fine.
>>>>>
>>>>> Fixes: 4fcba5d556b ("regulator: implement basic reference counter")
>>>>>
>>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>> ---
>>>>>  drivers/power/regulator/regulator-uclass.c | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-
>>> uclass.c
>>>>> index 3a6ba69f6d5f..fc1c3eb93c9d 100644
>>>>> --- a/drivers/power/regulator/regulator-uclass.c
>>>>> +++ b/drivers/power/regulator/regulator-uclass.c
>>>>> @@ -187,6 +187,10 @@ int regulator_set_enable(struct udevice *dev, bool enable)
>>>>>  		}
>>>>>  	}
>>>>>
>>>>> +	/* Regulator is already enabled */
>>>>> +	if (ret == -EALREADY)
>>>>> +		return 0;
>>>>> +
>>>>
>>>> Use of regulator_set_enable_if_allowed() will cover this error,
>>>> and regulator_set_enable() should continue to return this error.
> 
> regulator_set_enable_if_allowed() can be covered. But regulator_set_enable is called in some drivers.
> You means that it needs to replace to regulator_set_enable_if_allowed() from regulator_set_enable() about all driver?

I think that was the consensus when basic reference counter was
implemented for gpio/fixed regulators. It should return -EALREADY when
a regulator is already enabled, and if a caller need a more relaxed
enable/disable regulator_set_enable_if_allowed() could be used.

Tried to fix a few commons callers in following series, but did not
cover hw I could not test. Can see that I missed the meson usb driver
and was something I could have tested.

Keep fixed/gpio regulator enable count in balance
https://patchwork.ozlabs.org/cover/1810049/

Regards,
Jonas

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Well.. I will recheck about your comment.
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> When I have checked on my target, It seems that it can't cover all cases.
>>>
>>> On odroid-c4, USB doesn't work, even though its regulator is enabled.
>>>
>>> => ums 0 mmc 0
>>> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1dacc00
>>> No USB device found
>>> Couldn't init USB controller.
>>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>>  	return ret;
>>>>>  }
>>>>>
>>>
>>
> 
> 

