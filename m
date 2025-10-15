Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5112ACCD192
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87238313B;
	Wed, 15 Oct 2025 16:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TF24GUDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CBF833F6; Wed, 15 Oct 2025 16:22:40 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F288800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso48912555e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538158; x=1761142958; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fXTsVCnXECIO5Mss+aiZLnsZdxjqvbAOT6A4f4H1lLY=;
 b=TF24GUDuK7IfLoU5+G78nb+zLVb4GyvPz1KHlenBm9+7WrmFNGwCQQW9WGTxaJk3i2
 6gWxU6yj8RCpLbJJlUoPXJLQOTxfrOVV/MK3zfUb/We+iY4WiuBPMuq1r6c8+Njl0LAZ
 I/5LVNcveXfdJo5ag20EPCmGiL8ajEdVp/IEUI7XMPUg+hs7d/JYxmB15fa2g5ujj2Df
 6yCs9x+ZRJ6ddxEdq0NscAXwiOyZFvjTp1va3/nMQHzPvJ9tH7JQplT2drMdLgJtpeod
 hHJuRS1syhVFQ/hODlDbpEKxM8Q+JBX4AT3/s4v5YAdY63HIG5idsb7jLZ0PjQ/II8Cr
 FZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538158; x=1761142958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fXTsVCnXECIO5Mss+aiZLnsZdxjqvbAOT6A4f4H1lLY=;
 b=LzJ2Zhbx8iwQVyS5+6cDKuii7/H0g6Sr9Ar9OVZVBRMwU+BnU+rxCnn/pSszm7+0qD
 ACGcX/ExPVQD3Uzg8t8vfbIM/lXv/qmu06b6Cg1MEmI4kEMbtH15bbcvcum2aDBHpJ3B
 Ed7kGlBhgGt4O8KRCDLECvmaBOxPsE4ksEAgZFnoEJoVfveBYxgf8ufC0VPlURE4qUmW
 +PuEYtcN4xhQfmQUqb0byp+A6amD/77lKqbVlGMiM7XCciqVvSBsDOZmlj1v/NPNegLv
 jkQTJL4SL+VawuX7Zz1KbrgZurXjaNymH0GqpGvQPliY7l7vovxTrW1t3zhO6UVabAUA
 uQuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPO5yN9EgvYT7J4TWSjGEOdWSgO0FHdkM+A7fUX4w0+WheDzAn1d5h+kfZOdMIz1xEIW9v6bY=@lists.denx.de
X-Gm-Message-State: AOJu0YxG48kKgH2EMH2fJyxSkYPGgTjxs/f4jite9+6n99j9IgtIWgCR
 oshGX+EgRybgvelqHPTJtWwrEFVAooK6fXkaOfZ8GFB6lTKNpkpe4vX10jA2asLFNq8=
X-Gm-Gg: ASbGncvuJR/BFdE96O8bMSORcMaDZ3pW0vvr81tqqBR/Yf7Rg75C4KPI9kPK/p4BLuR
 ksKCOOMPvgNrq4k8qpAmGAtNcjqCYBP/EpEmVvGTtYcr19GZx/ottAhYBSHFlS5IXrZtqEvNAv4
 QZ7AHQrgnrPTZmLbd1A7n13Gc2lpg5lx+pbxR0nfExvULRpiYNlfr0B3LXX+WfdHCaRkEilOWJx
 X/Tkptjn0ijNQBokM81vS13BpatcAaNZjOFwsN3Lyvk2Qz7bwEWS9gByof7zGQvi2BUQX/4N+zR
 wmcSp5DpTTOEUXOYig5v0O4WpNcnpZru/H39LEyAOXxsaL65axSWUosze6LA3Lacl704zzPD7Ce
 T+sU9Po2kFYy3xvoXNZEFA/6lFR+TbV2kw2foIyFxwAcxrUHu9ir42hCJEwqckgXLbILZNHo9NJ
 izgkuBAQiyFj7VKP2npHh0WBE+qvRLmTJYEn4=
X-Google-Smtp-Source: AGHT+IES7nFguLqGJYdpSiKsKdATy7c9LBOnxI+J8q6ovE0BZayBxbVvr/COKRFbFbqh9PZSiiVMfw==
X-Received: by 2002:a05:600c:3b99:b0:471:786:94d3 with SMTP id
 5b1f17b1804b1-47107869ebbmr13856475e9.22.1760538157569; 
 Wed, 15 Oct 2025 07:22:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5?
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582abcsm29568557f8f.17.2025.10.15.07.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 07:22:37 -0700 (PDT)
Message-ID: <50055473-7684-4a61-bce2-c61f19d754cb@linaro.org>
Date: Wed, 15 Oct 2025 15:22:36 +0100
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

I have prepared two series of patches to address this. The first series 
will remove all attempts to return negative error codes through the 
.get_rate element of struct clk_ops. This is called from clk_get_rate in 
clk-uclass.c.
The second series updates clk_get_rate itself to remove negative error 
returns and also all the calling sites to correct error detection.

Unfortunately both series affect a moderate number of files although 
each individual changes is minor.  This also leads to a larger than 
normal Cc: list. I hope it will not cause issues with sending the email.

I will send the first series soon.

Andrew

