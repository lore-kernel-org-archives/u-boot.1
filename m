Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ED7C282CD
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAA9810ED;
	Fri, 28 Feb 2025 13:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i1JeYYp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7A8810F6; Fri, 28 Feb 2025 13:57:34 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD66810EA
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-abec8c122e4so307764566b.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740747451; x=1741352251; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+7WcUfI1BFBvvgSD2hZn3B9bOhpONp8nFpgH1i+ITcw=;
 b=i1JeYYp0nKcJA3O7RAFbJ4Ec3DwWOLImLMU1h9RoP9ccFngJ537iU2ULJ6Wr6SJqZD
 dQR3I4lWFGR1e/yvHiUB8ZG7czU3jR/8yYwvqTfPZJR7VYP0wvmI+EWCX9YyjQQJapjj
 LVhgvFcb37lNx/wcvjODkDOrQiBbkGdwbMK8kkRxOBk/voYXR7lLaZdeFcudk7Y2mX5v
 bnp7oOORhGm9TUL8lwGx5/8C/e3y3r6XFyXd8W5vulEDUz1cOene9Fi50x9H/DyVYobq
 YLHcpEIvuspvS302p4tTtjDCeggN6yuQuSytr6cS+Yw1GGIN/u7itX3/ynX2d10pfeKh
 1+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740747451; x=1741352251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+7WcUfI1BFBvvgSD2hZn3B9bOhpONp8nFpgH1i+ITcw=;
 b=sQwVn5PUUevV8uq9myMYaW0cV4XjyA/C5ethSQBkjYujt5gnKIyZ2jSD1GDZ65q5AZ
 hSHyBWRgwoG0SUDXdfh6qrGvHGUoEalyfJNtwnWcyzr0BawnvjGtbLliYnjXfwucwLE8
 vJoczbs5NzcV7V9S9Vwm6WVNUItgLA3zTp1vygztyqxNofcSuHrFuEz6sagbzbqSk728
 PHYUpl2YSb9yBPpSrmucSx6MgwSn8Gja3Z34ixqpGx8qHa0VufdypaRLOKtxaYXQjfT6
 UrWy1CjT6rsVT+KqEEO/K0ErMN0XjmGMAoWkBzU4Na0gPWaffMnk4jA38C750AgW4zdF
 lotw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ierD4xA/PjLyZTuUFN28++qhocfgufoXJNdGVySFS7qJjvNhsXCHry9rvCAI5iDJ8X+qWX4=@lists.denx.de
X-Gm-Message-State: AOJu0YwLf9X0iyyCfGIBcUACcel5q6FvAZKK5Mjp/1Lrr5nN2AwXaUHf
 1Yy9Ssd2ZZISmH8s2Gt4GmsaXftJ7kIPjdkG6/aOegXWUBzT1J9YSmabxSc0hSM=
X-Gm-Gg: ASbGncuP7aMOUgMjvM0TZZklk6s9vPAlX4vkLLll2SxCH3rFcivSR2ianFmQEA5wbmc
 BvOL/Uv6wE5QW92RF6eldOFd5TRiNIPavVR7hgcUolr9J+ZedCfvYvinu+t/9LLo8qfb0d6cH9E
 WrKfRWLbTemPBZJBrhaVixjQSiwexthLOfzAiyKPbBGZP+1V95SfyWyu11RoEtwBamZEdl6ykuf
 VjcwZe6dtSHVKrM6mHbEfXKySoYFiot40hhlXLAc8RerTowl8MOJwiAAt7zH44NU89LzBOPY5zV
 zYB7vo/x0Pn9xl1lU0QXwBUbI/1hTosTogB+i0Pdwn6G0f3BhV82kvRIY3iJn9S3bFWzNGl5dSy
 IoBEV+g==
X-Google-Smtp-Source: AGHT+IGNHIL45Px3QVCUqjIbHS9z4nJfQ4PMZfiOjUYPvX7dzxqfz9qm8VfwTK5LbRBACXgi/G5qGQ==
X-Received: by 2002:a17:907:1b26:b0:abe:fdfc:47d6 with SMTP id
 a640c23a62f3a-abf25fab3e9mr329651166b.23.1740747451308; 
 Fri, 28 Feb 2025 04:57:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c?
 ([2a01:e0a:3cb:7bb0:c779:ac28:4c86:118c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c43a55d5sm2440180a12.69.2025.02.28.04.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 04:57:30 -0800 (PST)
Message-ID: <3a8aa8e8-5669-4717-9a6e-226250bcd877@linaro.org>
Date: Fri, 28 Feb 2025 13:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] arch: introduce symbol HAVE_INITJMP
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de,
 Yu-Chien Peter Lin <peter.lin@sifive.com>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <2589612a53a9e9feb67b8e8286e87893359676d1.1740499185.git.jerome.forissier@linaro.org>
 <df59292e-0681-4cc3-bd2b-c75181091bd8@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <df59292e-0681-4cc3-bd2b-c75181091bd8@gmx.de>
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

On 2/28/25 13:38, Heinrich Schuchardt wrote:
> On 25.02.25 17:34, Jerome Forissier wrote:
>> HAVE_INIJMP will be set by architectures that support initjmp(), a
>> non-standard extension to setjmp()/longjmp() allowing to initialize a
>> jump buffer with a function pointer and a stack pointer. This will be
>> useful to later introduce threads. With this new function it becomes
>> possible to longjmp() to a particular function pointer (rather than
>> to a point previously reached during program execution as is the case
>> with setjmp()), and with a custom stack. Both things are needed to
>> spin off a new thread. Then the usual setjmp()/ longjmp() pair is
>> enough to save and restore a context, i.e., switch thread.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   arch/Kconfig | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 35b19f9bfdc..8d5b54031b3 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -13,6 +13,12 @@ config HAVE_SETJMP
>>       help
>>        The architecture supports setjmp() and longjmp().
>>
>> +config HAVE_INITJMP
>> +    bool
> 
> HAVE_SETJMP controls if /arch/<arch>/lib/setjmp.S is compiled.
> 
> Please, add the missing dependency.
> 
>     depends HAVE_SETJMP

Ack.

Thanks,
-- 
Jerome

> Best regards
> 
> Heinrich
> 
>> +    help
>> +     The architecture supports initjmp(), a non-standard companion to
>> +     setjmp() and longjmp().
>> +
>>   config SUPPORT_BIG_ENDIAN
>>       bool
>>
> 
