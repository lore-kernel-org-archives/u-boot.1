Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3B4C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3973F810F1;
	Thu, 27 Feb 2025 15:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fij/qoj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962C581026; Thu, 27 Feb 2025 15:18:32 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C76E80F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:18:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43994ef3872so6999695e9.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740665910; x=1741270710; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hm0pDnYIxOr2Ag4G9FPBEPqvv5XmToRPitxgrQohaGk=;
 b=fij/qoj8Kj17NDRlrws1R/zrIqwjL5VGwaN6aNFICYWhUzcoui3skMMISro2gxLqZx
 yGXYNpdTeOtZzAB5d4PKIM1HRxoyrB9bJjNimaItRZ/R9C1LMFwyXq09rnRtBW6FLz8L
 nV6+zkgIBmNjxgzfm+voG3MDjbXz9jEcZzgjJwqNW1T5FaXAeWmRWXpJG77QoVBV6R+e
 Btp2DNZtLuQx/EnRvd7/ApH9KRIsiQ3zLFXlpKpIBMAU2FrFHLsoXeE52BB+uHsleK39
 5Lr6d2WoN9iKdShJSC0MGMRpFY/nb2fB/JVjRscOBYDhk2wr35HlY5Jd3Gh7hpqjbBrM
 CeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665910; x=1741270710;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hm0pDnYIxOr2Ag4G9FPBEPqvv5XmToRPitxgrQohaGk=;
 b=GGkPmpB9DPtZU3XXx5/tcGHUI9wKEh4gkFoh6yKA3UTqixN/myhGO4JWNaPig1Xt/b
 oVJ0NAKEpMKI/W/oKkLcYS5+myox7IILB16Y+7xpDVnDelpMaHftCzHzOVnrTOoPUovw
 l72J1wgXVg6LshQ8gAM4ZQhicoRUf/gwmJnooeYMuNxP4/7sviDITl5OHJu9ldJh1Rql
 yj8eBQ4tBhjOjKFnM7GqzqEdbNIPMusrgNXlNYMDrH8xN/NvEgxoOu2EK5TsjDAP7asb
 505kHoKQ7WRSN5kucUahltvu6qsjwA7CzJVFd+sh+1kd4Fwb4uDasE3yR+3W+jzCJj6n
 /dXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZmmTJB7zziOtCMNRq8dMhqZfHb8DS9j43Cw0/ppfSyMqGB1uhEdpUjd3JQdygXai1yr/FX+k=@lists.denx.de
X-Gm-Message-State: AOJu0YwvXAQLKsm/5FZr1DwiHaEDjMG42qpMC8xfBTtuviE5FQuxMt2S
 SsPtconnPnITqNAMywx9qlHjgUyfKJwwaQXZw6aDC5fd4hqVgMYp+tvnnyWyGLU=
X-Gm-Gg: ASbGncuwR4bgvRSSLcN05mC0D+tlRzY+OhyjDktkDRqrRvriRbZ1k8grTr0xepukvc6
 DiE+9UFgT2HUVCkX+LMNyjDgckEtq4IX2/Y/GlildXsFXcbdcETjYz3hS2bgXi+CV6xoK0gFoqr
 9HYHsBco5dSoBywlIEvVzxhlK5AAn2NTUKU9fxbmHzYMmJgT8BQ1vdJ1V2vFzbwKK7/Cl/53GAQ
 h+4R7p/u41I+xOtmRvUTDHArfCQXVDkTIle2kv3bfxy/ZooqnC9ZCVaBedhmUKZ2TJ5n0geGRBI
 okdDp9ZnWHlJ7YM3SOMoTG92StBIAQv/fQ==
X-Google-Smtp-Source: AGHT+IGkFMgeCrpkgMOSKCA5JHwva69cWCGtCCdm7N3EQNmmJhBRo06opJcq56D4gbGLH3NOCMIAxQ==
X-Received: by 2002:a05:600c:b97:b0:43b:8198:f6fc with SMTP id
 5b1f17b1804b1-43b8198f8efmr27732135e9.11.1740665909883; 
 Thu, 27 Feb 2025 06:18:29 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7c4fsm2209862f8f.52.2025.02.27.06.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 06:18:29 -0800 (PST)
Message-ID: <4e339939-0427-44a3-8ce5-356c32e7411c@linaro.org>
Date: Thu, 27 Feb 2025 16:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
To: Manikandan.M@microchip.com, sumit.garg@linaro.org
Cc: lukma@denx.de, seanga2@gmail.com, kever.yang@rock-chips.com,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, festevam@denx.de,
 Oliver.Gaskell@analog.com, aford173@gmail.com, prasad.kummari@amd.com,
 caleb.connolly@linaro.org, andre.przywara@arm.com,
 neil.armstrong@linaro.org, mibodhi@gmail.com, Nicolas.Ferre@microchip.com,
 Mihai.Sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
 <CAFA6WYPEDujKz5jVW7ySynXi2T9kQWdJ+1MVBA1mGzMpBUMJmA@mail.gmail.com>
 <c2a277d8-b1bb-4b32-9245-81aba4ba13be@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <c2a277d8-b1bb-4b32-9245-81aba4ba13be@microchip.com>
Content-Type: text/plain; charset=UTF-8
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



On 2/27/25 12:37, Manikandan.M@microchip.com wrote:
> Hi Sumit,
> 
> On 27/02/25 3:14 pm, Sumit Garg wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Thu, 27 Feb 2025 at 15:06, Manikandan Muralidharan
>> <manikandan.m@microchip.com> wrote:
>>>
>>> Add PMC clock definitions for MCK and UTMI which will be required
>>> for the sam9x7 OF_upstream DT since the clock framework is not in
>>> sync with Linux and also include this header in 'clock/at91.h' file
>>
>> You should rather drop these local DT bindings headers which will
>> allow dts/upstream/include/dt-bindings/clock/at91.h to be included
>> automatically.
> Other SoC DTs where OF_UPSTREAM migration is not added yet, depends on 
> the local DT bindings header, dropping this will lead to issues with 
> compilation.
> We can drop this altogether when we sync the u-boot clock framework with 
> Linux.
>>
>> -Sumit
>>
>>>
>>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>>> ---
>>>   include/dt-bindings/clk/at91.h   | 3 +++
>>>   include/dt-bindings/clock/at91.h | 2 ++
>>>   2 files changed, 5 insertions(+)
>>>
>>> diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
>>> index a178b94157b..016c6e0c620 100644
>>> --- a/include/dt-bindings/clk/at91.h
>>> +++ b/include/dt-bindings/clk/at91.h
>>> @@ -24,4 +24,7 @@
>>>   #define USB_UTMI2              1
>>>   #define USB_UTMI3              2
>>>
>>> +#define PMC_MCK                        1
>>> +#define PMC_UTMI               2

Where in the patch series do you need these defines ?

>>> +
>>>   #endif
>>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
>>> index ab3ee241d10..7235b3ba01e 100644
>>> --- a/include/dt-bindings/clock/at91.h
>>> +++ b/include/dt-bindings/clock/at91.h
>>> @@ -6,6 +6,8 @@
>>>    * Licensed under GPLv2 or later.
>>>    */
>>>
>>> +#include <dt-bindings/clk/at91.h>
>>> +

I find this odd to include one at91.h in another at91.h

Let's consider to remove one of these files in the future, and have just
one that is identical with the bindings one from Linux

Meanwhile, let's see where do you need the PMC_*

>>>   #ifndef _DT_BINDINGS_CLK_AT91_H
>>>   #define _DT_BINDINGS_CLK_AT91_H
>>>
>>> --
>>> 2.25.1
>>>
> 

