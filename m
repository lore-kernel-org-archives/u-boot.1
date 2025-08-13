Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC592CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 16:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4988583564;
	Wed, 13 Aug 2025 18:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yWVqNino";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6770C83689; Wed, 13 Aug 2025 18:34:05 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61514829F5
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 18:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459e794b331so40491055e9.3
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755102843; x=1755707643; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQEAW5hU6zq0jOkKNHfHN1tfaUDPNjzw9o06IVQLOJU=;
 b=yWVqNinoFd0ZkZz23tH6L7YKg2LgFePC3YfThVZ6KjOC6vrjz3XRzdr69IYwGofNvg
 exVAbKdczgowdrdXoXR0UOfClL91LwUsauctoW/3fLF5pnIdoyvqi20yGz1binwWhe5I
 wQC/j8cOPN/Y7uy7ZKhEkBofWf0rkXWPSFgg1PVb0VGBENjnxSHk/9v39NS6GAQZvp3r
 BSxEQIsXOFgAyXsvELJaKQWNu/nDxg2dryn9EzKeVarcGrS0aNfuPJYDetl2ODbwQqvs
 o4xM+AOwaxZLojm1K5kgHuj+Bh17RqPRzZME8D2HWjAHTXS+Cp6Jhon15go3HbGlwkKr
 QjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755102843; x=1755707643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQEAW5hU6zq0jOkKNHfHN1tfaUDPNjzw9o06IVQLOJU=;
 b=fwcAiB4wQAAE6YiPa1YdB9dcWn8Au7opDWUBAZY95H/G5E2RGGDgwFjLA1XYBLxwnE
 NUZwnZ1nVgdSCCwaJqq4ZzjUclOfpzCI2VYimNW5ooO7g3YI3ODkdUlP//I8HD+D7OM1
 WAWOO/lvDkz1Ncl7ioYtkE7A0MKxd8iKMpA1SVvENuLAFIim5xiZWa8QCDAL6GsHuKAq
 IhDxpRwi1LRJtSXIDRppRJZqUIu/ALymCwcYNrINTlXoyPFqVbzpCbvbl499dKTTwcWy
 YBtZS7OTN0OWMZL3Bg4Wkc5/ZMLsZUf8N6vQB+7J913LWeLXfH6tGmsOUcxRIyvHuM7o
 ZdZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeYyQ1TrLYS7E7MKN2FUXnvatoTUIuP+mpJgSMaYSRRji1JefzrCVlrTsNPTqrFz2IUHUaMQ8=@lists.denx.de
X-Gm-Message-State: AOJu0Yww7OteThpZlhWxyKMuJ/y3HKkgRTd/B1mZfJ2vytR/mxUYoWsU
 i9Jt/7Xl6muMW75OcMnE+dMC3QPw0VHnGMeW8kYpdg2DTwhUDqtNo08ojHj4Ln7ztp0=
X-Gm-Gg: ASbGncvK6X6ikkLtKxpsOuwDkCp4YbAiE+LNrpUu3eyGqmDXaIT5Hn28QLpDd2wiM1d
 phXvA/Gv8grQzdapx6ArQlfBaB6/YCMbJ0Ex22nVKni6KcF6Kk82HQkEzVm+mCBbyRPv1mnCA/X
 rjKxqesL0yL106JQe0epsAErCYVD1M+yBCIxYMDuDNI7qoBseflKQBWWB+qDiewMpMUkSm69Rr9
 Ye/RMt4KnGBZ3Ve88pMUlABVeUQkYSOJ7RswhTTAvMFgHtTPs5z25eSpYd+c3vVEggb+gUiBREf
 bcdaKGo9y9xZRFB+jfbQrACB4AE6M7w193/j86p99/vORhdz7CWlSwNATJy6kqwpjJhCdIftgnp
 EEp2V0mNlB0lARw783pKCY8M33HHxksO/Cs24MoypPEZhd94E7AFz6i3g9KGHU9qI2eZrliaN
X-Google-Smtp-Source: AGHT+IECERpVHCEeZbviX3V0W7YSK5EBh5vYmrFC8O9ASSEyYJjmfJWa6EYBirCBfsNvGHqsWj3hFA==
X-Received: by 2002:a05:6000:250f:b0:3a5:3a03:79c1 with SMTP id
 ffacd0b85a97d-3b917ebf766mr2722969f8f.48.1755102842714; 
 Wed, 13 Aug 2025 09:34:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:f76:d65c:a81:fe01?
 ([2a0a:ef40:f9e:3c01:f76:d65c:a81:fe01])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abed3sm48019111f8f.10.2025.08.13.09.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 09:34:02 -0700 (PDT)
Message-ID: <49671056-4880-418c-b97a-b16b795af994@linaro.org>
Date: Wed, 13 Aug 2025 17:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking advice on API return type inconsistency
To: Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Michal_Such=C3=A1nek?=
 <msuchanek@suse.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
 <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
 <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
 <20250812143349.GQ124814@bill-the-cat>
 <cc82add8-5f9c-4ee1-87ea-a458e840e621@linaro.org>
 <20250812150359.GS124814@bill-the-cat>
 <56d03251-1185-44ca-98e6-f45ac0e0af53@linaro.org>
 <aJx54frzXkLRFcGO@kitsune.suse.cz> <20250813154033.GB124814@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250813154033.GB124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 13/08/2025 16:40, Tom Rini wrote:
> On Wed, Aug 13, 2025 at 01:41:21PM +0200, Michal Suchánek wrote:
>> Hello,
>>
>> On Wed, Aug 13, 2025 at 11:58:19AM +0100, Andrew Goodbody wrote:
>>> On 12/08/2025 16:03, Tom Rini wrote:
>>>> On Tue, Aug 12, 2025 at 03:46:56PM +0100, Andrew Goodbody wrote:
>>>>> On 12/08/2025 15:33, Tom Rini wrote:
>>>>>> On Tue, Aug 12, 2025 at 10:17:47AM +0100, Andrew Goodbody wrote:
>>>>>>> On 11/08/2025 17:36, Quentin Schulz wrote:
>>>>>>>> Hi Andrew,
>>>>>>>>
>>>>>>>> On 8/11/25 5:24 PM, Andrew Goodbody wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I was wondering what people's thoughts were on API return types. In
>>>>>>>>> particular there is this and other examples in include/clk-uclass.h
>>>>>>>>>
>>>>>>>>> /**
>>>>>>>>>      * get_rate() - Get current clock rate.
>>>>>>>>>      * @clk:    The clock to query.
>>>>>>>>>      *
>>>>>>>>>      * This returns the current rate of a clock. If the clock is
>>>>>>>>> disabled, it
>>>>>>>>>      * returns the rate at which the clock would run if it was enabled. The
>>>>>>>>>      * following pseudo-code should hold::
>>>>>>>>>      *
>>>>>>>>>      *   disable(clk)
>>>>>>>>>      *   rate = get_rate(clk)
>>>>>>>>>      *   enable(clk)
>>>>>>>>>      *   assert(get_rate(clk) == rate)
>>>>>>>>>      *
>>>>>>>>>      * Return:
>>>>>>>>>      * * The rate of @clk
>>>>>>>>>      * * -%ENOSYS if this function is not implemented for @clk
>>>>>>>>>      * * -%ENOENT if @clk->id is invalid. Prefer using an assert
>>>>>>>>> instead, and doing
>>>>>>>>>      *   this check in request().
>>>>>>>>>      * * Another negative error value (such as %EIO or %ECOMM) if the
>>>>>>>>> rate could
>>>>>>>>>      *   not be determined due to a bus error.
>>>>>>>>>      */
>>>>>>>>> ulong get_rate(struct clk *clk);
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> get_rate is declared as returning a ulong but the description says
>>>>>>>>> that it can return negative errors. A simple test of the return
>>>>>>>>> value for being less than 0 will always fail so errors can go
>>>>>>>>> undetected. Casting to a signed type seems less than ideal.
>>>>>>>>>
>>>>>>>>> What is the best way to deal with this? Cast to a signed or update
>>>>>>>>> the API to be signed or...?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Note that clk_get_rate() in the kernel has the same function signature
>>>>>>>> so I would refrain from changing the type otherwise we'll have some
>>>>>>>> "funny" bugs to handle considering it isn't that uncommon to import
>>>>>>>> drivers almost as-is from the Linux kernel.
>>>>>>>
>>>>>>> Ah yes. The difference being that the kernel does not seem to attempt to
>>>>>>> push an error code through this API, you get a rate or you get 0.
>>>>>>
>>>>>> How is the error code pushed? Or is it up to the caller to decide that 0
>>>>>> means on a case by case basis?
>>
>> Presumably it returns -EBUSY which is then implicitly converted to a large
>> positive value. For pointers there is IS_ERR macro to decode that, and
>> for integers there is another corresponding macro (I don't recall the
>> name).
>>
>> For memory this assumes that the last page that holds the 'error'
>> pointers cannot be mapped, and there was already a bug in the kernel
>> that this was not true.
>>
>> For clock rates this assumes that rates close to the maximum value are
>> invalid which is not guaranteed in any way whatsoever.
>>
>> Consequently, this should not be used.
>>
>> 0 is the only clock rate guaranteed to be invalid.
>>
>> As far as I have seen in the u-boot code almost no caller checks the
>> result, and those that do cannot do anything meaningful with it anyway,
>> at most a message is printed. That can be done by the driver without
>> passing around the error.
>>
>>>>> In the Linux kernel almost no code checks the return of clk_get_rate at all.
>>>>> Some code will check the value is sensible and 0 is obviously not sensible.
>>>>> But pretty much the call to clk_get_rate is not expected to fail.
>>>>
>>>> Perhaps getting lost in the specifics then, but perhaps for this case we
>>>> should just do the same? But your question was more general, so another
>>>> example might help.
>>>
>>> I suspect that the answer is always going to that it depends on the
>>> specifics of each case. The U-Boot implementation of clk_get_rate seems to
>>> have become more complicated leading to the addition of returning error
>>> codes. This leads to the question about what level of compatibility should
>>> there be maintained with the kernel? That addition of returning error codes
>>> in U-Boot already means that the API is no longer compatible with that of
>>> the kernel.
>>
>> I would suggest to abolish returning 'errors' as clock rates.
> 
> Yes, I think this is a case where we should change our internal API,
> both for easier driver migrations from the linux kernel and also because
> it seems our design here can't quite work as intended.

OK, I will see if I can put a patch series together.

Andrew
