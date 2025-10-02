Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0F0CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 14:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7827828A2;
	Thu,  2 Oct 2025 16:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NRlIf8HK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A97835A2; Thu,  2 Oct 2025 16:09:56 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C63680107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 16:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-62fa062a1abso1898755a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759414193; x=1760018993; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TdD6/JZxmauQE1sek/sfC9nnwfm3RSr/rSyCr4VTT6o=;
 b=NRlIf8HKSLBU0pUhnsFtepsT5feDGfxcIjoc0GvnjtlPOYXS1CydT4uxhVOWanS5u0
 TYgU+EOFDqUznAIQVQezHTyeUDhfsnBTjmk5KNjaG8V+o3iv0jq8EAyjc5KIFvuE6ed0
 KW/tEzA+zTlerpooF1wbOW11j+84YzZS3TkSY+3nYgWIdYN3bnJmiu0cdUHZHDCynA1p
 fp/Od9r9fEWQyHsB31YDNI2UAHfGMkU1NPFJSzVOQnA/yiW8d2s6xIcFCBBCSJ6hKdCG
 B6ID0sig8psk6hDNlR+3pPwqZMqOsYNQB0RohiTggPA+jQhtKprChdVN+liuvvVr3XGg
 xHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759414193; x=1760018993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TdD6/JZxmauQE1sek/sfC9nnwfm3RSr/rSyCr4VTT6o=;
 b=TPtVMHJkHz363a6IOfiLdLQjNbZcf4Vy592aCXiv5axpiPDvAcEmS3KzxiUEIew2Zv
 w6QTOhspewVCWIASUhxUSYruoDMlb+gHrMq20gsP1Z88OqKl9Va/zkGDEfMZRPDJ4ZyA
 galmGWPudz8OvrqIvxBIgYQ10FVKF4QOyJEQa3k60m/0qZ3cd7z0BCHWZ313D2xoyAd9
 8wQPQxBQElFNVuwzRuz//RRdux77LQ7q9IQOOvJnHG5SLsKSJuzR45ZBnmp9lmUdTMF5
 8JN77cOpAXYIhr+ud3IGy8VKjmlyOc4gel/FldvCgw2HMYInPWSWcTtQIjUdyuVNPgfr
 lpcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2tdtBNQG+youoawHht0mJdgOfb2X7XD9PIOsxtYt7XJ/DM2lGRCwiyfP2HsmsdUJ0J10Zp+g=@lists.denx.de
X-Gm-Message-State: AOJu0YzOOrbY2aPAyx99EvfwPABEiXOYDhh06JrCksniQ2LWsEWt8iUr
 DfjEpzeIljWtdu8uZlirCR9lz1J0luX9wVizwO5BOqHadHLM0FtzTVM4P7e8f4zQOxc=
X-Gm-Gg: ASbGnctdBTcc8sa9tOhY2gHRJulzc+RnIPghXWxh2ddGxH8llwow7Umdnl6IkrNuKE9
 qlDfiD36JIOfJ9g6sHxf6PELVGtxDttLCckRyBIpZWovRLTzEXZYHoeRv5uCK9OF8j9jHzqco+5
 KmVVRZZKQPnvA4f8IiBH4ap7/ymEl/oZJj1tw8+9Bg1wwGEotNudGVelKGsNzq8/ItzOAeDXVSi
 06sjO/dAsRCOoJ9UT5ZjgdnVjaIvZZCOROO9SYU7NxYTi7VcUGK+YV4GxjK6JewDbUDmwsfnacn
 6irlsWagg65TgzUQq3VKXgGcSKTepTAWhQJbBhs+T72tI37tN8KJyeFkfrFMl0tf3Gnn7ExuxiK
 8hIx5Kev0A78KCbD8pY9e1YB6IxQFii8FYcdefWVPGxGNF5rzVL8f7k2DyVFKaBRVWm6x2jfLJv
 H/LIzi+rjvFRd0nRXykEfNjIvPvqion77XMW93vJlL
X-Google-Smtp-Source: AGHT+IEsW4MyXrgkC8+l38BVd5MqRpkwRQYC5BAgGHa//AnZBc4sM8vtmmX5hox/euZovtbIXqZejQ==
X-Received: by 2002:a05:6402:50cf:b0:634:4d49:6b6f with SMTP id
 4fb4d7f45d1cf-63678ccd691mr9325899a12.26.1759414192769; 
 Thu, 02 Oct 2025 07:09:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ebd:e301:a21d:c610:1e27:3706?
 ([2a0a:ef40:ebd:e301:a21d:c610:1e27:3706])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6376b3ab692sm1947253a12.6.2025.10.02.07.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 07:09:52 -0700 (PDT)
Message-ID: <ec159c7b-1263-4c1a-80d9-4214f6360e5f@linaro.org>
Date: Thu, 2 Oct 2025 15:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <6de97f77-c998-4cf5-8ff4-89a8d4813201@linaro.org>
 <d8fe4794-118c-4b6e-84ba-c4872221e9c2@canonical.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <d8fe4794-118c-4b6e-84ba-c4872221e9c2@canonical.com>
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

On 02/10/2025 12:03, Heinrich Schuchardt wrote:
> On 10/2/25 13:00, Andrew Goodbody wrote:
>> On 02/10/2025 10:52, Heinrich Schuchardt wrote:
>>> On 10/2/25 11:39, Andrew Goodbody wrote:
>>>> After calling a function that can return an error, the test to detect
>>>> that error should use the return value not a different variable. Fix 
>>>> it.
>>>>
>>>> This issue was found by Smatch.
>>>>
>>>
>>> Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
>>>
>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>> ---
>>>>   fs/semihostingfs.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>>> index 
>>>> 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>>>> --- a/fs/semihostingfs.c
>>>> +++ b/fs/semihostingfs.c
>>>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, 
>>>> loff_t pos, void *buffer,
>>>>       }
>>>>       if (!maxsize) {
>>>>           size = smh_flen(fd);
>>>> -        if (ret < 0) {
>>>> +        if (size < 0) {
>>>
>>> The ARM specification (https://developer.arm.com/documentation/ 
>>> dui0203/ j/semihosting/semihosting-operations/sys-flen--0x0c-) has:
>>>
>>> SYS_FLEN (0x0C)
>>>
>>> Returns the length of a specified file.
>>> On exit, R0 contains:
>>>      the current length of the file object, if the call is successful
>>>      -1 if an error occurs.
>>>
>>> Please, consider that the file length on 32bit systems may exceed 
>>> 2^31 You must not consider this as an error.
> 
> How about changing the smh_flen() interface to:
> 
> int smh_flen(int fd, size_t *size)

V2 coming.

Andrew

> Best regards
> 
> Heinrich
> 
>>>
>>> %s/if (size < 0)/if (size == -1L)/
>>
>> Unfortunately that is not sufficient with the current code. smh_flen() 
>> and others will call smh_errno() if the sys call returns -1 so other 
>> error codes may possibly be returned. [1]
>> This seems to be going well beyond the scope of my patch.
>>
>> Andrew
>>
>> 1. 80e62ccfa63 arm: smh: Return errno on error
>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>               smh_close(fd);
>>>>               return size;
>>>>           }
>>>>
>>>> ---
>>>> base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
>>>> change-id: 20251002-fs_semihosting-85d697fbfcad
>>>>
>>>> Best regards,
>>>
>>
> 

