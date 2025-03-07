Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C08C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 13:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B77DF803CC;
	Fri,  7 Mar 2025 14:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GuVsznxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6192980F4C; Fri,  7 Mar 2025 14:19:46 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D87C800B6
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 14:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5491eb379so2925164a12.3
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 05:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741353582; x=1741958382; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=88yDvXpvg4FZ2QUahiUPHhtN2GJDC6QYYkRO3xfVqKk=;
 b=GuVsznxtOUiJx4eBSrrePbddbQI6eKmNk550p3r/nhfi2T0TuB4jXHSOzDXU2Z4baI
 GOhXjAtqjMj5uLZK3X/PFnNilRsK4+g/yw7twh+SV/5jvWxuoM0CS0f5z3KQopbZxfTP
 UycmJr0Ei8X5YFyIZsn5Pzu0JgqC0n+gNi3sCiG8ytKCxIfYTj3+dSsuXmpNJzvCKncu
 C3hFHvnKnaQIjjLS77bt2MGOPShcwAJdIhDZ4WpBJm56SFOi/Z3ombMIAaJStP0ZQkmd
 HtWUzOwUuPmXVoX+7EnxIZGumLZL+4OpfWEe1k7ANbiIeb3dfePNcGAgFqNHJiyrO5WF
 +YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741353582; x=1741958382;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=88yDvXpvg4FZ2QUahiUPHhtN2GJDC6QYYkRO3xfVqKk=;
 b=ZYQucDGC7yJESy73rCeMEm2tLEZC6ekHLreUF+pcoTXUgF1cKyGlaAi0G6MBQhR4KQ
 Rt8Fxpk1N6z+XEYtr+0rP74ZoQTutD/1k8byFJCGzuPeRGRK5vWt7MvxVGyDB3DHzJ+x
 g9lvLrLMwID3uFVD1BibX9GpEUjuAinZjfnkmnuPKirrR6p496cS6izfBJErrOPquIMv
 n6KIrXjN4TDVuDqCqNAQ0MABsG3HrIvkswS+zBoDq7ARtoPCJ5t90EGHi1ib3wxcn3Wf
 4IYQGzkJ5QQNNoZV4ylmxi4trRSJsAhfF1tL0d6WZn+UWzo+6ecV4dSlKsTbM5AAkw7j
 Aouw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzcFKNzt/kDaXH31Ptkk3l9ZzQdXx3+EGDeM36wivEUWmkGBy7jPgFYh36NDBWZt9+RnFrwK8=@lists.denx.de
X-Gm-Message-State: AOJu0YwfOS7mP2Ph0Jm9hdL4CwISEP5pCRuLtGhy0BRVkoKIjPXwT6L0
 y5B9hLiS+wWbOTod9zxnZ3KVB1qDMg4ujz3tQykYAzdKFiNaa7az7pkgxHJndvo=
X-Gm-Gg: ASbGncsWMoGtcrv0E5/RYm6Fvauc5jk5GZqMuBagwxdQ5Xf0JkpqGmbCkXpDGzkb6ta
 uKoCUsJLuB4x2rhEF1AldzFE2QawCbKH1gfraRXS8TCWvjJBPEVJErga6599g9lPGNlFqwnPXz+
 7eJYVQy3zQAmz5ROoWlY/yLM7tyBWkLCVozUKmQQWek0FGD7KzFoRqItTvun6uCZP3FSSW6aYFJ
 G683ZJLcid/aRVyviv8UmUZA+50rheWkH0O+uAFEofENQ+QDHzAUoU6msnx+5a6vkieeVkmRCwM
 Fb4l9NISEx+lkTZtQgdLXLbWvJayqb6qnCCtBtRp/4joy5Dinc85
X-Google-Smtp-Source: AGHT+IGkpJBWuGCkI7EDb+NH09+WqNcvTfoOFbgU1onIT6VFQP7ssFnvueTYv8BTZ5JZz7L63NlYuw==
X-Received: by 2002:a17:907:6e9e:b0:ab7:d454:11c9 with SMTP id
 a640c23a62f3a-ac25259859amr366429066b.8.1741353581628; 
 Fri, 07 Mar 2025 05:19:41 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23943a2d4sm274633266b.36.2025.03.07.05.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 05:19:41 -0800 (PST)
Message-ID: <a0c19054-30e4-44ed-9952-f232d26fd950@linaro.org>
Date: Fri, 7 Mar 2025 15:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: rename at91.h to
 at91-pmc-status.h
To: Manikandan.M@microchip.com, sumit.garg@kernel.org
Cc: lukma@denx.de, seanga2@gmail.com, sumit.garg@linaro.org,
 kever.yang@rock-chips.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se,
 festevam@denx.de, Oliver.Gaskell@analog.com, aford173@gmail.com,
 prasad.kummari@amd.com, caleb.connolly@linaro.org, andre.przywara@arm.com,
 neil.armstrong@linaro.org, mibodhi@gmail.com, Nicolas.Ferre@microchip.com,
 Mihai.Sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20250305060711.1127301-1-manikandan.m@microchip.com>
 <20250305060711.1127301-2-manikandan.m@microchip.com>
 <Z8lH93V9DUfdoiLd@sumit-X1>
 <02132f8e-79b2-4b47-b4d4-60bb9c9a793f@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <02132f8e-79b2-4b47-b4d4-60bb9c9a793f@microchip.com>
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



On 3/6/25 12:39, Manikandan.M@microchip.com wrote:
> Hi Sumit,
> 
> On 06/03/25 12:30 pm, Sumit Garg wrote:
>> [Some people who received this message don't often get email from sumit.garg@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi Manikandan,
>>
>> On Wed, Mar 05, 2025 at 11:37:04AM +0530, Manikandan Muralidharan wrote:
>>> Rename the include at91.h to at91-pmc-status.h to avoid conflicts with
>>> the upstream bindings that has the same file and update the
>>> relevant legacy SoC Device Trees to reflect this change.
>>> This is useful while compiling the DT and driver of the new SoC files with
>>> OF_UPSTREAM enabled.
>>>
>>> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>>> ---
>>>   MAINTAINERS                                             | 2 +-
>>>   arch/arm/dts/at91-sama7g5ek-u-boot.dtsi                 | 2 +-
>>>   arch/arm/dts/at91sam9260.dtsi                           | 2 +-
>>>   arch/arm/dts/at91sam9261.dtsi                           | 2 +-
>>>   arch/arm/dts/at91sam9263.dtsi                           | 2 +-
>>>   arch/arm/dts/at91sam9g45.dtsi                           | 2 +-
>>>   arch/arm/dts/at91sam9n12.dtsi                           | 2 +-
>>>   arch/arm/dts/at91sam9rl.dtsi                            | 2 +-
>>>   arch/arm/dts/at91sam9x5.dtsi                            | 2 +-
>>>   arch/arm/dts/sama5d3.dtsi                               | 2 +-
>>>   arch/arm/dts/sama5d3_mci2.dtsi                          | 2 +-
>>>   arch/arm/dts/sama5d3_tcb1.dtsi                          | 2 +-
>>>   arch/arm/dts/sama5d3_uart.dtsi                          | 2 +-
>>>   arch/arm/dts/sama5d4.dtsi                               | 2 +-
>>>   include/dt-bindings/clock/{at91.h => at91-pmc-status.h} | 0
>>>   15 files changed, 14 insertions(+), 14 deletions(-)
>>>   rename include/dt-bindings/clock/{at91.h => at91-pmc-status.h} (100%)
>>>
>>
>> AFAICS, include/dt-bindings/clock/at91.h is just a subset of
>> dts/upstream/include/dt-bindings/clock/at91.h. If that's true then we
>> should just be able to drop local include/dt-bindings/clock/at91.h from
>> U-Boot tree. Won't that just work fine?
> 
> 
> Yes, you're right. It's a subset of the upstream at91.h. However, we 
> must retain it due to dependencies with legacy SoC files that haven't 
> yet been migrated to OF_UPSTREAM. I believe migrating those files now 
> would introduce a significant number of changes w.r.t Device Tree files."
> 

What kind of dependencies ? If current at91.h is a subset of upstream
at91.h, then you could include the upstream at91.h, which would only
bring extra defines which would be unused.
Are there more problems other than just being a subset ? From what I
remember, some defines were different versus upstream, and this could
cause problems.

Eugen
>>
>> -Sumit
>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 10f7f1fd180..d50841a4a41 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -464,7 +464,7 @@ F:        drivers/memory/atmel-ebi.c
>>>   F:   drivers/misc/microchip_flexcom.c
>>>   F:   drivers/timer/atmel_tcb_timer.c
>>>   F:   include/dt-bindings/clk/at91.h
>>> -F:   include/dt-bindings/clock/at91.h
>>> +F:   include/dt-bindings/clock/at91-pmc-status.h
>>>   F:   include/dt-bindings/dma/at91.h
>>>   F:   include/dt-bindings/mfd/at91-usart.h
>>>   F:   include/dt-bindings/mfd/atmel-flexcom.h
>>> diff --git a/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi b/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi
>>> index 8b2e990de72..6e5ca0fb4ce 100644
>>> --- a/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi
>>> +++ b/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi
>>> @@ -12,7 +12,7 @@
>>>
>>>   #include "sama7g5-pinfunc.h"
>>>   #include <dt-bindings/reset/sama7g5-reset.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        chosen {
>>> diff --git a/arch/arm/dts/at91sam9260.dtsi b/arch/arm/dts/at91sam9260.dtsi
>>> index 8d496205523..4ccfe2b9e4b 100644
>>> --- a/arch/arm/dts/at91sam9260.dtsi
>>> +++ b/arch/arm/dts/at91sam9260.dtsi
>>> @@ -12,7 +12,7 @@
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/gpio/gpio.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        model = "Atmel AT91SAM9260 family SoC";
>>> diff --git a/arch/arm/dts/at91sam9261.dtsi b/arch/arm/dts/at91sam9261.dtsi
>>> index 65e0e4f0de0..0c7485bff98 100644
>>> --- a/arch/arm/dts/at91sam9261.dtsi
>>> +++ b/arch/arm/dts/at91sam9261.dtsi
>>> @@ -10,7 +10,7 @@
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/gpio/gpio.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        model = "Atmel AT91SAM9261 family SoC";
>>> diff --git a/arch/arm/dts/at91sam9263.dtsi b/arch/arm/dts/at91sam9263.dtsi
>>> index 55b79667564..e5d1cc04f5c 100644
>>> --- a/arch/arm/dts/at91sam9263.dtsi
>>> +++ b/arch/arm/dts/at91sam9263.dtsi
>>> @@ -10,7 +10,7 @@
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/gpio/gpio.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        model = "Atmel AT91SAM9263 family SoC";
>>> diff --git a/arch/arm/dts/at91sam9g45.dtsi b/arch/arm/dts/at91sam9g45.dtsi
>>> index 63a061354e4..5c79f33f48d 100644
>>> --- a/arch/arm/dts/at91sam9g45.dtsi
>>> +++ b/arch/arm/dts/at91sam9g45.dtsi
>>> @@ -14,7 +14,7 @@
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/gpio/gpio.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        model = "Atmel AT91SAM9G45 family SoC";
>>> diff --git a/arch/arm/dts/at91sam9n12.dtsi b/arch/arm/dts/at91sam9n12.dtsi
>>> index 84089837013..5034db0b617 100644
>>> --- a/arch/arm/dts/at91sam9n12.dtsi
>>> +++ b/arch/arm/dts/at91sam9n12.dtsi
>>> @@ -12,7 +12,7 @@
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/gpio/gpio.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        model = "Atmel AT91SAM9N12 SoC";
>>> diff --git a/arch/arm/dts/at91sam9rl.dtsi b/arch/arm/dts/at91sam9rl.dtsi
>>> index 3b99de21058..8fa8067709c 100644
>>> --- a/arch/arm/dts/at91sam9rl.dtsi
>>> +++ b/arch/arm/dts/at91sam9rl.dtsi
>>> @@ -8,7 +8,7 @@
>>>
>>>   #include "skeleton.dtsi"
>>>   #include <dt-bindings/pinctrl/at91.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/gpio/gpio.h>
>>>   #include <dt-bindings/pwm/pwm.h>
>>> diff --git a/arch/arm/dts/at91sam9x5.dtsi b/arch/arm/dts/at91sam9x5.dtsi
>>> index 4c6d8b9bb65..1922c5f03e0 100644
>>> --- a/arch/arm/dts/at91sam9x5.dtsi
>>> +++ b/arch/arm/dts/at91sam9x5.dtsi
>>> @@ -14,7 +14,7 @@
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/gpio/gpio.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        model = "Atmel AT91SAM9x5 family SoC";
>>> diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
>>> index 10d6e74586d..bb9290fba57 100644
>>> --- a/arch/arm/dts/sama5d3.dtsi
>>> +++ b/arch/arm/dts/sama5d3.dtsi
>>> @@ -13,7 +13,7 @@
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/gpio/gpio.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        model = "Atmel SAMA5D3 family SoC";
>>> diff --git a/arch/arm/dts/sama5d3_mci2.dtsi b/arch/arm/dts/sama5d3_mci2.dtsi
>>> index 2d289ed7be8..05753edeb0f 100644
>>> --- a/arch/arm/dts/sama5d3_mci2.dtsi
>>> +++ b/arch/arm/dts/sama5d3_mci2.dtsi
>>> @@ -9,7 +9,7 @@
>>>
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        ahb {
>>> diff --git a/arch/arm/dts/sama5d3_tcb1.dtsi b/arch/arm/dts/sama5d3_tcb1.dtsi
>>> index 5be60b4f8b1..0d96fe77723 100644
>>> --- a/arch/arm/dts/sama5d3_tcb1.dtsi
>>> +++ b/arch/arm/dts/sama5d3_tcb1.dtsi
>>> @@ -9,7 +9,7 @@
>>>
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        aliases {
>>> diff --git a/arch/arm/dts/sama5d3_uart.dtsi b/arch/arm/dts/sama5d3_uart.dtsi
>>> index 6a547fdadcc..10f36eb3ac2 100644
>>> --- a/arch/arm/dts/sama5d3_uart.dtsi
>>> +++ b/arch/arm/dts/sama5d3_uart.dtsi
>>> @@ -9,7 +9,7 @@
>>>
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>
>>>   / {
>>>        aliases {
>>> diff --git a/arch/arm/dts/sama5d4.dtsi b/arch/arm/dts/sama5d4.dtsi
>>> index 482cf03e61b..af5e9bd6dba 100644
>>> --- a/arch/arm/dts/sama5d4.dtsi
>>> +++ b/arch/arm/dts/sama5d4.dtsi
>>> @@ -44,7 +44,7 @@
>>>    */
>>>
>>>   #include "skeleton.dtsi"
>>> -#include <dt-bindings/clock/at91.h>
>>> +#include <dt-bindings/clock/at91-pmc-status.h>
>>>   #include <dt-bindings/dma/at91.h>
>>>   #include <dt-bindings/pinctrl/at91.h>
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91-pmc-status.h
>>> similarity index 100%
>>> rename from include/dt-bindings/clock/at91.h
>>> rename to include/dt-bindings/clock/at91-pmc-status.h
>>> --
>>> 2.25.1
>>>
> 

