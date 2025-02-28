Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C334BC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 11:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E55C80FF0;
	Fri, 28 Feb 2025 12:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LDDtO4cO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E62810EA; Fri, 28 Feb 2025 12:15:22 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C56C280FE2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394a823036so19258875e9.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 03:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740741320; x=1741346120; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=St+yIJFc3CVmYVjaJHTwo47UBTaOp3gTXd374oDGkR4=;
 b=LDDtO4cO6fpFsDHaeKrOQwacwE0lGS2RoKwflg3Q6uPXl9VJaCqpXV2Fq365/HCHr6
 +Rb3qbFA/iIt13kMTzvPuF7eJ8Ek7dpZN/Q1lGf1WitLD8JE3jobiOSDMb7Lb0P8s/3x
 TC8Tw2Nfb23uQtP5gATtYVLPHfjluc0SNzkBBYJ1Lt1fzCtEziNSPAh5Fpoq7MQ6Sar6
 lEQGuds0d3KMfkQZQfaUn6Fser8gqmG0TFULDAT/6uU/CeOwpvq7nFgjjaT+KWP52Ic5
 GJPw4AB1XmawBQYuwwYFvaSA6hN2m4GvZp/yTaVzx0kQWZAHV3WCEfGli+26l8ibhkup
 9HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740741320; x=1741346120;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=St+yIJFc3CVmYVjaJHTwo47UBTaOp3gTXd374oDGkR4=;
 b=rWJXYMpmdLpd+2WkXmSkyLk/MRuMgEvOA4/4R/KIwTMMKvSHjk2VXGXNzxAg6Knhz1
 NrxC13YiuRiuS6j7dytVF+CBjwOy/nAMYFvGDlBCfKfVF44Enbj16veguQdiEt8ypGPU
 IuirGcahz3z3hqiSRNfOr7NZpIZPe+TttvT7eH0D6AlJSKv+CGHOX42GIWokoI8z9+Qp
 7IzySqJJc9Qm1JT4I/RzaiKcYw4fOt0sXidCPAzbZaMfoBrAvA2fyKCAupZk6KBrQgR4
 DOF7/s4U+Dhuw3OIf5sOSJWPHYXV2g3NoULJVr+4+M25cKsR8pn9pfwfmE2QePOsR8l5
 kxaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkL7/SSRZsSWyXZRmrXtad648GpV6RDbNv5y7uJQOLxeD2pUzsTNhkXJ1N0ILIiuP3VRCo9YQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyCU7xdo+4mD4GDenileDJJKZ0PfpywwScrEM/VIb7yGzWjvh+j
 3bAYS3IWOJEEKJr631pTFeZ/5eigi1z/3QdcmwH/isMeQOACZx8qr0K/Zi2DqxY=
X-Gm-Gg: ASbGncsWgPfA2UALWGVGCzgk2JouWW2cODLbfydEIHJpBya7RymQR+AvS/BpvE2Rj0i
 7f8oYlIqTmWdEWia9dVJcxSXMCGWbw1SHFAtG7ypnLxe91sebVAxOVxE/Q6rZtfEzdls1B6zDGe
 aSyOUjzpMW4/xJOAI/llIny4MAKaXFY/0nQSZhs/35saOSp4DD+o2BQGLFEuFtNEP9S3eAxJRvy
 09hI4FjdCYMUCBFeOa5VkbzZxC+cfSF5ip5RhsajnBHZbhS3PYz+6TMV3QHHppE1AGtek1aYPO3
 /uEXCdNMODa8h6IV9UrOgk7VRXlkinKkig==
X-Google-Smtp-Source: AGHT+IHs78tHveZaBvjyrX324BBwLtHhL3UfKSgFQt+OdLVzJmbTr1RW+Cc+1YYIYKFi6SRTcmAJ8w==
X-Received: by 2002:a05:600c:4693:b0:439:a139:7a19 with SMTP id
 5b1f17b1804b1-43ba675a7c4mr22079255e9.23.1740741320181; 
 Fri, 28 Feb 2025 03:15:20 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5871f4sm87350765e9.39.2025.02.28.03.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 03:15:19 -0800 (PST)
Message-ID: <d75a8b80-8029-4bf0-9c7c-7c72054bbdf3@linaro.org>
Date: Fri, 28 Feb 2025 13:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
To: Sumit Garg <sumit.garg@linaro.org>, Manikandan.M@microchip.com
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
 <4e339939-0427-44a3-8ce5-356c32e7411c@linaro.org>
 <40f5911d-6967-40a7-b4f4-a29679c8d909@microchip.com>
 <CAFA6WYNw86eNNfBh6+omtuVFBDVzAPyU79B0s2eYfPY7U1exEA@mail.gmail.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFA6WYNw86eNNfBh6+omtuVFBDVzAPyU79B0s2eYfPY7U1exEA@mail.gmail.com>
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



On 2/28/25 12:58, Sumit Garg wrote:
> On Fri, 28 Feb 2025 at 15:20, <Manikandan.M@microchip.com> wrote:
>>
>> Hi Eugen,
>>
>> On 27/02/25 7:48 pm, Eugen Hristev wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On 2/27/25 12:37, Manikandan.M@microchip.com wrote:
>>>> Hi Sumit,
>>>>
>>>> On 27/02/25 3:14 pm, Sumit Garg wrote:
>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>>
>>>>> On Thu, 27 Feb 2025 at 15:06, Manikandan Muralidharan
>>>>> <manikandan.m@microchip.com> wrote:
>>>>>>
>>>>>> Add PMC clock definitions for MCK and UTMI which will be required
>>>>>> for the sam9x7 OF_upstream DT since the clock framework is not in
>>>>>> sync with Linux and also include this header in 'clock/at91.h' file
>>>>>
>>>>> You should rather drop these local DT bindings headers which will
>>>>> allow dts/upstream/include/dt-bindings/clock/at91.h to be included
>>>>> automatically.
>>>> Other SoC DTs where OF_UPSTREAM migration is not added yet, depends on
>>>> the local DT bindings header, dropping this will lead to issues with
>>>> compilation.
>>>> We can drop this altogether when we sync the u-boot clock framework with
>>>> Linux.
>>>>>
>>>>> -Sumit
>>>>>
>>>>>>
>>>>>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>>>>>> ---
>>>>>>    include/dt-bindings/clk/at91.h   | 3 +++
>>>>>>    include/dt-bindings/clock/at91.h | 2 ++
>>>>>>    2 files changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
>>>>>> index a178b94157b..016c6e0c620 100644
>>>>>> --- a/include/dt-bindings/clk/at91.h
>>>>>> +++ b/include/dt-bindings/clk/at91.h
>>>>>> @@ -24,4 +24,7 @@
>>>>>>    #define USB_UTMI2              1
>>>>>>    #define USB_UTMI3              2
>>>>>>
>>>>>> +#define PMC_MCK                        1
>>>>>> +#define PMC_UTMI               2
>>>
>>> Where in the patch series do you need these defines ?
>>>
>>>>>> +
>>>>>>    #endif
>>>>>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
>>>>>> index ab3ee241d10..7235b3ba01e 100644
>>>>>> --- a/include/dt-bindings/clock/at91.h
>>>>>> +++ b/include/dt-bindings/clock/at91.h
>>>>>> @@ -6,6 +6,8 @@
>>>>>>     * Licensed under GPLv2 or later.
>>>>>>     */
>>>>>>
>>>>>> +#include <dt-bindings/clk/at91.h>
>>>>>> +
>>>
>>> I find this odd to include one at91.h in another at91.h
>>>
>>> Let's consider to remove one of these files in the future, and have just
>>> one that is identical with the bindings one from Linux
>>>
>>> Meanwhile, let's see where do you need the PMC_*
>> The PMC_MCK and PMC_UTMI are defined in the dts/upstream sam9x7 SoC DT.
>> since during compilation the clock/at91.h from u-boot is used and to
>> resolve the syntax issues I had to declare them in clk/at91.h and
>> include the header in clock/at91.h

I don't understand this. So , compiling sam9x7 upstream DT with upstream
at91.h should work.
Do you have issues with sam9x7-u-boot.dtsi that fails build ?

>>
>> if we drop the clock/at91.h from u-boot, the sam9x75 will pass using the
>> includes from upstream Linux but will break other SoC that has not
>> migrated to OF_UPSTREAM yet.

So you need to include clock/at91.h from upstream for sam9x75 and the
other at91.h for older SoC.
Does that work ?

>>
>> Or we can align u-boot's clock/at91.h with Linux and drop clk/at91.h,
>> replace it with clock/at91.h in drivers and DT.
>> Please let me know if that works.
> 
> I would rather favor the U-Boot drivers and DT to directly use
> dts/upstream/include/dt-bindings/clock/at91.h instead and drop local
> DT bindings import. It then becomes easier for other SoCs to migrate
> to OF_UPSTREAM too.

Sumit,

The problem is that there are two at91.h with different definitions for
the same macros. (I know... legacy reasons..)
The drivers have to be reworked to cope with the new values. Meanwhile I
would say that at least the new SoCs should use the right macros/bindings

> 
> -Sumit
> 
>>>
>>>>>>    #ifndef _DT_BINDINGS_CLK_AT91_H
>>>>>>    #define _DT_BINDINGS_CLK_AT91_H
>>>>>>
>>>>>> --
>>>>>> 2.25.1
>>>>>>
>>>>
>>>
>>
>> --
>> Thanks and Regards,
>> Manikandan M.
>>

