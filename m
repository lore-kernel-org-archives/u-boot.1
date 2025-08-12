Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0955C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 14:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3567E8344E;
	Tue, 12 Aug 2025 16:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dqGeuycU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97CE6830B3; Tue, 12 Aug 2025 16:40:23 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F44D830B3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 16:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8DCA23F4BE
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755009620;
 bh=sSmAXmrnVlNwCT4Y7MmwxF4fmOcyIGOu3DsCAfbzPSs=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=dqGeuycUsQCjmN9AAmYSEEqdPzRo6zfhTRHf+XwgJFt8e58jOs6ISGnxuYuA4bSZx
 tH0QPv85UxHn6JZzwjsWKBnM7dnRnhB4brwDNL1SL9cDQKXTOtPPVdImIDAtxxzz0v
 FSYSqkx5ssn1bq8MyUdpCjmJKcA+sBAVVVdUt4AGzuOHYWPklgKD+Tv39/mvNyQQZy
 fOkF/Zi0Z5Ev5k3hBq/jK5t2wQpXD/nqxnubCybVSa3OL1JasTmxpEjrZTD3HTcWFe
 cC1H5mKfSKa1tVq81V0awf7FTGNfWDvWFebBHsVGmVv6xs0OtDLKCQT/+xeaD4YdcN
 rPphnGg/PfMrg==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-af95125cf52so427016266b.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 07:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755009619; x=1755614419;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sSmAXmrnVlNwCT4Y7MmwxF4fmOcyIGOu3DsCAfbzPSs=;
 b=V0V4GgsPvdvLFwGFRu8X1v+2Y4fS9YNBlaB+iRUxJv9REMnvFwkwhpXMRpoKrJmTjq
 mvOu9UxkTCMVcHmcHs3FythxhRGVxWly3IkyOSSNm1fsvFCjIUHm9wcINVwyCNNskN1I
 Nfl2hJ6eIvWBF83n66+ApWeIcAUCMZssqCrhu0u0dxRqmx3LbELdLsQAl3F6gmGjclyx
 l3AKsstclkVd9LZ/sZf4e4k92GTXwaK1laM8Z5qhvd2I7+kXVRA1wh3aPR631rUNtV46
 CXNNhjqfyDyHIokzzw4QXAJmXAvvVFxmzC0kZFvB5qwd7SC5gP699eK/772CW901zhMC
 eBMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo1oOnn8q8NUmSqhxSgK7eY9JPum/XphpJD1MEUX6G5pejOoDQMS5CY7I7ir/9Jct82FgH/rE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzi4apSjxR2mi+FyV4HE4EevCmwORtdWNF7xyxDlHXUc4OXFkI0
 T/TPuK1AGjtB7L77DDhwQpTNX92+hmWM15zMBa0ahe1YfboF3OjEnDOX8ta9Z9K+FsM7m1NDacs
 DfqCYiq4UmOCZnS9K/a3EB2GWQ2PxU1L0R0Xkpzbyu43CFsHj4agtb3bwGu8VF5ST5HzBhHM=
X-Gm-Gg: ASbGncvYY8KCX6k4/qHvhGXHs/L/5U4pur8m4W+2ZUH6MvXGsED3ApVFmoqCvbYJk4d
 +ulEJQZ3V8QNUalUQW5CR6tss1HshUrKe2dm/qWXyP531a7j4hiRv/8+75ZMZ5LlQV+FtFRR1rg
 E5LYMT/cGzBJ7V2yF+Z179/hLeuZ5wWYyx6WsWr2rdr0uEAgO/oAeayc8t9b1wf31sIPR7pGtZq
 xg9IAbtjfanjVizpknd0XpvVkoNfSf+nRccYHO300Hr3BpsWLdopbP9EilqgILRWUFJbIbyqQDd
 KosB72Q0RvuERyZ8hEq5DD8xw38mXzJ7SNGOM0SFC8ChXdxpznC7dRXJcHddd7LE/4dthrDlNzE
 SzK8P49Hog+dD4gGvjkM=
X-Received: by 2002:a17:907:97d2:b0:af9:237c:bb35 with SMTP id
 a640c23a62f3a-afa1dfef21amr310431666b.22.1755009619597; 
 Tue, 12 Aug 2025 07:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS0vHHica7IXfWri4vUZ1sLgcFUx+JWu8AU7faNNcRbo3QwPy9poMgn7s8uq2wapXnHOLaqQ==
X-Received: by 2002:a17:907:97d2:b0:af9:237c:bb35 with SMTP id
 a640c23a62f3a-afa1dfef21amr310429666b.22.1755009619201; 
 Tue, 12 Aug 2025 07:40:19 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a0a3b58sm2217435766b.58.2025.08.12.07.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 07:40:18 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <05f7c566-e833-4561-bb49-8769e533c16c@gmx.de>
Date: Tue, 12 Aug 2025 16:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking advice on API return type inconsistency
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
 <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
 <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
 <20250812143349.GQ124814@bill-the-cat>
Content-Language: en-US
In-Reply-To: <20250812143349.GQ124814@bill-the-cat>
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

On 12.08.25 16:33, Tom Rini wrote:
> On Tue, Aug 12, 2025 at 10:17:47AM +0100, Andrew Goodbody wrote:
>> On 11/08/2025 17:36, Quentin Schulz wrote:
>>> Hi Andrew,
>>>
>>> On 8/11/25 5:24 PM, Andrew Goodbody wrote:
>>>> Hi,
>>>>
>>>> I was wondering what people's thoughts were on API return types. In
>>>> particular there is this and other examples in include/clk-uclass.h
>>>>
>>>> /**
>>>>    * get_rate() - Get current clock rate.
>>>>    * @clk:    The clock to query.
>>>>    *
>>>>    * This returns the current rate of a clock. If the clock is
>>>> disabled, it
>>>>    * returns the rate at which the clock would run if it was enabled. The
>>>>    * following pseudo-code should hold::
>>>>    *
>>>>    *   disable(clk)
>>>>    *   rate = get_rate(clk)
>>>>    *   enable(clk)
>>>>    *   assert(get_rate(clk) == rate)
>>>>    *
>>>>    * Return:
>>>>    * * The rate of @clk
>>>>    * * -%ENOSYS if this function is not implemented for @clk
>>>>    * * -%ENOENT if @clk->id is invalid. Prefer using an assert
>>>> instead, and doing
>>>>    *   this check in request().
>>>>    * * Another negative error value (such as %EIO or %ECOMM) if the
>>>> rate could
>>>>    *   not be determined due to a bus error.
>>>>    */
>>>> ulong get_rate(struct clk *clk);
>>>>
>>>>
>>>> get_rate is declared as returning a ulong but the description says
>>>> that it can return negative errors. A simple test of the return
>>>> value for being less than 0 will always fail so errors can go
>>>> undetected. Casting to a signed type seems less than ideal.
>>>>
>>>> What is the best way to deal with this? Cast to a signed or update
>>>> the API to be signed or...?
>>>>
>>>
>>> Note that clk_get_rate() in the kernel has the same function signature
>>> so I would refrain from changing the type otherwise we'll have some
>>> "funny" bugs to handle considering it isn't that uncommon to import
>>> drivers almost as-is from the Linux kernel.
>>
>> Ah yes. The difference being that the kernel does not seem to attempt to
>> push an error code through this API, you get a rate or you get 0.
> 
> How is the error code pushed? Or is it up to the caller to decide that 0
> means on a case by case basis?
> 

Using macro IS_ERR_VALUE() in the caller should do the needed.

See include/linux/err.h:21:
#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)

Best regards

Heinrich
