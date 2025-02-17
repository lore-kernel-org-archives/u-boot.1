Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52650C021AB
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C97D807F1;
	Mon, 17 Feb 2025 14:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LYmrfZE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3557C808B6; Mon, 17 Feb 2025 14:59:31 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B494E80104
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5deb956aa5eso6273938a12.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739800768; x=1740405568; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fbeZ6T08op911pq6BbHojqy/9qeqWTKgrRLeuy+OABo=;
 b=LYmrfZE4Pwr//juZ6RuSp2MBO4wMKJ6pVuJHWjMq92wP4P2ZlfnpIQCPJiwCieFgNo
 eGDdl+TaB3LH1Q4QDu55OkJtLYWcQDjMYGqxQQDhhP5WYk4YykeTN/6AibqKnVprreum
 4QW0H5tRRCK06OWF7QChKqa/GUxbY5r1cCkg6OyokrMXjtLATtFtklmJHbN/7totCjdT
 8i4251AUWTAHoci8iqzUc4WlpJz9/xDjDAlW15tgAwABw3W9aAwja23dByBpAGe7roLQ
 pI0siKzDoz4ECrneqJ0nV5mVEvvZ03Eccf7BmXfMGAQ/81/41GXU+aeFxl4lWVg8+bd7
 1uQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739800768; x=1740405568;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fbeZ6T08op911pq6BbHojqy/9qeqWTKgrRLeuy+OABo=;
 b=rGfmQIz1cSriwIukcTO7AY3xOK05xZQOW8E2zbjOWl+vQnbHitjN879gHo2zFnMf8K
 F8ySlwQoBuyQ2yJYOxJc94lC6BlE5p/kBeVH9dTGx4aEoUDCW+IBhdIgwQunzWqLqnUG
 ovGqdz1J6oeAQAGrgd+JIx2EnFLml9eoHrqJYoikLwPiwjD6350crdXnHWgTSsQdDJae
 aeVx9Qz1Z6Ki0uEL0ie4VPpHGACxehLHPPjVCyT54EvMLLsHyD4rbDYmReCEpUm8TJFF
 6HU7nIk2dyB9SXH7yN2sAd0BNWpVy3nUdVWIXDIQLMqR3bTxj2K5ArKPrnU2PGiSHx7E
 AEFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpydoORPtXfOYhyQo/jT2yGfUwS+VpkHtqdUN162BHxr4nQ6YJ0eqJ9gubfcqT0GQP3aDVAs0=@lists.denx.de
X-Gm-Message-State: AOJu0YyiLVeWgike6KGQPQ9nO2Dahtydt3kQYMLcZqwPNG+qQs3aiv5y
 Ml6yArqx3aKK3siZpimcGEdA2a7x69yVGeOiYp7zGr95duRHo54deWEGr6oXRg2QscGNJm1Ive0
 Npds9Bg==
X-Gm-Gg: ASbGncv6sQweyZr5HDh8IkX7mQAczQrRPhOQeJiri6Cw56eUUOdNHoqnNw6d3CwTL2X
 0AlvLvGwZLfajs28xxKMqQIGe2ewKd/KwEfpuOsRN0biy+hMuxiiKWKta6mgVpvFT919DCchQmk
 lCxH6nKtvqj9rC4f57amwxyY6KqyVu7QZg/06X0hlqjSYP3YweP+Pp6dcp0t+W8tvRMlxi7J5Xs
 W3P5810aQGrutS+KWGEI1qJ4VWPWhA++7EVpSrS4z+59QjWFMSTLuRfbWgMgwhno9iJ3MSkjXpQ
 cQEO7MZkayrAMMCfq/pReEPvf+ZXc1XiWJ4mJDfelLOCiQO8kx0e3XLlYzNwf1quDBsQytA=
X-Google-Smtp-Source: AGHT+IFUIrKC5YpQBL4b8cYYdNYyuJ+B4ZGBXM0C/V2SDwjU5ngxkp9T14yhRj4HjBeg6h/LEnzFyg==
X-Received: by 2002:a05:6402:5201:b0:5dc:d8d2:e38f with SMTP id
 4fb4d7f45d1cf-5e03618307amr23395251a12.31.1739800768054; 
 Mon, 17 Feb 2025 05:59:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3e73:9504:55df:dc9e?
 ([2a01:e0a:3cb:7bb0:3e73:9504:55df:dc9e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb989d89edsm231496266b.81.2025.02.17.05.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:59:27 -0800 (PST)
Message-ID: <7e400367-6702-40bc-9250-2937508fa52a@linaro.org>
Date: Mon, 17 Feb 2025 14:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] common: board: make initcalls static
From: Jerome Forissier <jerome.forissier@linaro.org>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <cover.1737709089.git.jerome.forissier@linaro.org>
 <564c3f3b7f70c893b2c6b6dfc89a226b90d411de.1737709089.git.jerome.forissier@linaro.org>
 <f9bfd3d8-dd30-4f4e-a73d-ab9082f832a8@denx.de>
 <38bb1c47-8001-4415-a421-ff1b501f0105@linaro.org>
 <77906c5f-3d67-4c43-9e22-c8ea74695146@denx.de>
 <bebd3427-2d20-43ad-b682-ed02858db546@linaro.org>
 <4c2a3f99-4af2-4c5c-ba63-9a90018b51bd@denx.de>
 <0ded07f8-3afd-4d26-b3de-cd94c9a57ff9@linaro.org>
Content-Language: en-US
In-Reply-To: <0ded07f8-3afd-4d26-b3de-cd94c9a57ff9@linaro.org>
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

Gentle ping. Can we keep the macro?

Thanks,
-- 
Jerome

On 1/27/25 11:32, Jerome Forissier wrote:
> 
> 
> On 1/25/25 00:58, Marek Vasut wrote:
>> On 1/24/25 6:23 PM, Jerome Forissier wrote:
>>>
>>>
>>> On 1/24/25 17:23, Marek Vasut wrote:
>>>> On 1/24/25 4:57 PM, Jerome Forissier wrote:
>>>>>
>>>>>
>>>>> On 1/24/25 11:35, Marek Vasut wrote:
>>>>>> On 1/24/25 10:10 AM, Jerome Forissier wrote:
>>>>>>> +#define INITCALL(_call) \
>>>>>>> +    do { \
>>>>>>> +        if (_call()) { \
>>>>>>> +            printf("%s(): initcall %s() failed\n", __func__, \
>>>>>>> +                   #_call); \
>>>>>>> +            hang(); \
>>>>>>> +        } \
>>>>>>> +    } while (0)
>>>>>>
>>>>>> Can this be turned into some static inline function too , so typechecking would be retained ? Maybe the function can be passed in a function pointer to call ?
>>>>>
>>>>>
>>>>> Doing the below totally kills the space gain (-160 bytes instead of -2281
>>>>> on zynqmp_kria_defconfig, with LTO).
>>>>
>>>> Does the compiler not inline the functions perhaps ?
>>>
>>> It does. inline vs __always_inline makes no difference. The assembly
>>> code is pretty difficult to understand in any case (macro or static
>>> inline function). There are pieces of called functions all over the
>>> place inside initcall_run_f() which is to be expected with LTO I
>>> suppose.
>>>
>>>>
>>>>> And it prevents from printing the
>>>>> function name in case of error, which is nicer than an address
>>>>> (especially with relocation at play).
>>>> That function name can be passed in using __func__ as a parameter.
>>>
>>> True. That being said, the type-checking argument does not seem
>>> decisive here, and although I too prefer to use static inline
>>> functions over macros when possible, it looks like we have no choice
>>> in this case.
>> Can you try this kind of thing (might need some tweaking):
>>
>> "
>> static void check_and_fail(int *ret) {
>>   if (*ret) {
>>     printf("failed\n");
>>     hang();
>>   }
>> }
>>
>> static inline void INITCALL(int (*_call)(void))
>> {
>>   int ret __attribute__((__cleanup__(check_and_fail))) = _call();
>> }
>> "
>>
>> (maybe it really is the passing of pointer to _call() function into the INITCALL() function which confuses gcc into not inlining this right, but let's find out)
> 
> It seems to be working as expected (size-wise). Comparing the macro
> version with yours, without LTO then with LTO:
> 
> $ ../linux/scripts/bloat-o-meter /tmp/u-boot.macro /tmp/u-boot.inlinefn
> add/remove: 2/0 grow/shrink: 1/2 up/down: 1386/-1700 (-314)
> Function                                     old     new   delta
> initcall_run_f                                 -    1316   +1316
> check_and_fail.isra                            -      64     +64
> version_string                                70      76      +6
> board_init_r                                 836     664    -172
> board_init_f                                1572      44   -1528
> Total: Before=1121213, After=1120899, chg -0.03%
> 
> $ ../linux/scripts/bloat-o-meter /tmp/u-boot.macro.lto /tmp/u-boot.inlinefn.lto
> add/remove: 5/3 grow/shrink: 2/3 up/down: 11418/-11072 (346)
> Function                                     old     new   delta
> initcall_run_r                                 -    7532   +7532
> initcall_run_f                                 -    3540   +3540
> add_to_list.lto_priv                           -     248    +248
> zynqmp_power                                   -      48     +48
> check_and_fail.isra                            -      32     +32
> __func__                                     975     987     +12
> version_string                                70      76      +6
> __func__.lto_priv                           3700    3688     -12
> zynqmp_power.lto_priv                         48       -     -48
> add_to_list                                  248       -    -248
> get_mem_top                                  568       -    -568
> board_init_f                                2880      56   -2824
> board_init_r                                7424      52   -7372
> Total: Before=1068190, After=1068536, chg +0.03%
> 
> But note that the two are not equivalent since yours doesn't print
> the initcall name in case of failure.
> 
> Regards,
