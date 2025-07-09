Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D02C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 08:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4AA83390;
	Wed,  9 Jul 2025 10:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nSbn9alA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FED83394; Wed,  9 Jul 2025 10:31:45 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E6F483371
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 10:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so46596145e9.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752049902; x=1752654702; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S53visWSNfOrkLSBpl+o99k8kZT+5o70n+zlhHcIZ6k=;
 b=nSbn9alA2Vm4Uc9HktHRP2GoyuQ+/uonZVquP4ecbNSEUZp7yIG7KiYjHnxRimhWwe
 uUl5JQBoNxCTUVCaAEFlN3ifrlGhRw8w/oeX5uFMZn2gTCtDqieXDfsvCO0q9JQ1NwKo
 gGYf3iDWKqPwavnR6cI72Lf7oRfKpGsXSXcXXyh5flRUBTP2/4rTlkuBzpFQYMlhCTpi
 xYWZ/PsZV9dJNug7VGwUG0HQdTTDvSRtCl0Vb+52Qmh4sNoWeY3ng41pmmvWenMowzXo
 4zzeq2poCaxmq1C1jwEai35KqV9aAlErvzUnNr7+cdDyF1T4ijJHHXqloAtbkufhTOzl
 u3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752049902; x=1752654702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S53visWSNfOrkLSBpl+o99k8kZT+5o70n+zlhHcIZ6k=;
 b=Y+OfI1bPLnwsmF8a//LI+IjkQXHJH88JyF9+X/XPkmPvLLh1M8qpu2tGyIn6hQzRMD
 C7epaPiNiKOMnmoUbCCjTdJqI47gXp4rcmLpLjqSQOm95Rwfvx/I8nWMhVZdCQJhA7XG
 1LYofum6hxZrabq+4KXFAqYcPXX1Gp1of+x+/VH+qWNSZcBS458d8exhZeuDBa/cMzzr
 0pM7bc06diVwfC6Gc433fZcl8BnmYoabggn/xhfFWUaLcglFhdGPUWTywuMS1SAfhmI1
 4t+/SUqyiKjI7dZE0uavZk1lepVM1CfJsv6WLgQlHr8Zy7Jljkb4ATe1TgRfsmiOTQax
 FbxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWvbfzg/1xxNYVmYuFPwo2SQ/5Ne40Vbq97ofCQ0i4fCc8Z/CTIlry13KJ5t1aTphtzdGE194=@lists.denx.de
X-Gm-Message-State: AOJu0YxLMJdyNgK80zH5ReSgM376nYUCDu+q6yoikxWRuiREduPn63bq
 KEfqWaK0k5ROSnwvzayDTo08pCE99vftKAY0+lsO8tORdhyD3K67MQ/iEP9p7//RfIo=
X-Gm-Gg: ASbGncsc32PJ7cgqqwcATGc25k6I3dbmiSc6hOQs6WTGJ2iukIpPhzQ5GQxZME0HYQ9
 6OvFNCHR6hKP8sTYjOBrNRJeDgBzfeW7SASPuZtNUEOOWnSFB7uDyLEqlphK0ADoAUJ4R+b8VNT
 D9mw5DRuTJOg8YhP9sM8L0hIFKw1k5QyWycoCBxciApmBdmgcvYD5mKGAU9cvhEMkrCGl3XJA9T
 T8ocHHnUQLIkyhmJJ0JRSBRwR56+tVnlx6EhTLV0rgETc21rL9UudyL+KyuSqIgtmXKtV29Bbvo
 we3alNbCO0lkfByQ35iRVkvbwSXXrXiR6Wq3r0jwoRnNgivl1IoZIbRvd14mCTEAen+Cc3m1eCe
 W+s65s7ivxnyDoHslhVjmIHHf9GbChi49FVRMVxg=
X-Google-Smtp-Source: AGHT+IGeuWkCLqdVmvFo+BRWmMWuGet0/b4rhWRe0+rsMFrKdDz5TSc5OklbhTgnlRKQtxALqSEulw==
X-Received: by 2002:a05:600c:3145:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-454d54046fcmr13012695e9.25.1752049902418; 
 Wed, 09 Jul 2025 01:31:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:7978:74ac:133f:8950?
 ([2a0a:ef40:e07:801:7978:74ac:133f:8950])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d508cc8asm16009025e9.35.2025.07.09.01.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 01:31:41 -0700 (PDT)
Message-ID: <2315cba0-2441-4796-a346-a6521abd54c1@linaro.org>
Date: Wed, 9 Jul 2025 09:31:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: Ensure method_flags is initialised before use
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250627-bootflow_fix-v1-1-f1039b2962d6@linaro.org>
 <20250709001445.GA1724532@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250709001445.GA1724532@bill-the-cat>
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

On 09/07/2025 01:14, Tom Rini wrote:
> On Fri, Jun 27, 2025 at 11:09:36AM +0100, Andrew Goodbody wrote:
> 
>> The local variable method_flags is only assigned to in some of the
>> code paths leaving it possibly uninitialised at first use.
>> Initialise method_flags at declaration to ensure that it cannot be
>> used uninitialised. Also remove now redundant assignments.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   boot/bootflow.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/boot/bootflow.c b/boot/bootflow.c
>> index 4054a966af8..d60e9df6a9d 100644
>> --- a/boot/bootflow.c
>> +++ b/boot/bootflow.c
>> @@ -245,7 +245,7 @@ static int iter_incr(struct bootflow_iter *iter)
>>   	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
>>   		ret = -ENOENT;
>>   	} else {
>> -		int method_flags;
>> +		int method_flags = 0;
>>   
>>   		ret = 0;
>>   		dev = iter->dev;
>> @@ -264,7 +264,6 @@ static int iter_incr(struct bootflow_iter *iter)
>>   		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
>>   			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
>>   			log_debug("next in single\n");
>> -			method_flags = 0;
>>   			do {
>>   				/*
>>   				 * Move to the next bootdev child of this media
>> @@ -306,7 +305,6 @@ static int iter_incr(struct bootflow_iter *iter)
>>   				}
>>   			} else {
>>   				ret = bootdev_next_prio(iter, &dev);
>> -				method_flags = 0;
>>   			}
>>   		}
>>   		log_debug("ret=%d, dev=%p %s\n", ret, dev,
> 
> This leads to failures in CI:
> https://source.denx.de/u-boot/u-boot/-/jobs/1195854

OK, thanks Tom. I will take a look to see what is going on there.

Andrew
