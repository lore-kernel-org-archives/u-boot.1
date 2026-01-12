Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E36ED26D97
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 10:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6ED83D77;
	Mon, 12 Jan 2026 11:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xLWDkoyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1AF783D7A; Mon, 12 Jan 2026 11:13:02 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3EFE83B5E
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 11:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-431048c4068so3032798f8f.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 02:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768212780; x=1768817580; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YG4+2fpQHynyZkB/e1WerRZoRlecl/hW7ZL5dyt2nTQ=;
 b=xLWDkoytwxz1WACxEJC8zcEE2I12nw8/4fupBfKAD02uasrsOjh065tbNCWaPjbwkV
 Gx7zbIMXs7+sV+jNSbcUdYvy5p5euSM/pAsa/CO5z0hgQ7rQHzdW6y5NIaAFgNOdogU9
 e1am8EoXBBtrJ9nJv+IUeWjho+gS0PjRaPKMmJiRfMlxHW/TjVXNOB0yxVcL9Xgf4joS
 qoUSBslVkRhM3xl3xpi0X8F8okDN3B0EA4Cjrq8oc5QLFA82I+l8J3v18/NRQw6J1BqS
 CcuSi3meVoOqW6vy6XYgzcn8LDAnF5gt/5KU6ZLlYhn4UZfaPYAVj71yQV95zS6P5K09
 1SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768212780; x=1768817580;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YG4+2fpQHynyZkB/e1WerRZoRlecl/hW7ZL5dyt2nTQ=;
 b=C/LJ8ZPlvjAKLu4GDTeHvmsLM7lQnlev+V59fzYdDExIsegxj/436iD6o8j1pi5fHO
 83kQ9DSVuxDBRO0YrgSyGf36LAWNzZQfOTw21PDkYD5zj2uEeFiQouz9kIe3mBB9AbDA
 vYoTQttFLHIR1X/awETbzz5TG6RJXw4jU1Pd0yIBIyPz7isY1/BzOAVHiN8NDLHFJsMy
 xf/RPxCPUy5eo7EtZ2oHS++vR0j7yMYNJB7mUurC2932cHzxcH3M1ge12MpWH8LVAOBf
 HbX5sJVQlhHt9TcW448bjyILXw4Kh6Hh041OfodN9C2RbNJzPPGWd9Dw9G/MjM5MCwKX
 1Slg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUFkvQ8TtxN5IsZ53dWu/ca8NJLqhjc6SpqcsxyNAZliMVg3MPSAYOmZhgBPD8mRsxlVz9faM=@lists.denx.de
X-Gm-Message-State: AOJu0Yws1zjkdbK1KaV/MSh21oyQx27IPyUCQGHfwOUaqE4OOyFn1QLN
 NZ++oSHyG9TATLnI8/eOLZ8LuNNDEL/xo3ScO3U/DLTs+Q1V5Mu9rJyMkk5e615dO1o=
X-Gm-Gg: AY/fxX4XyQyXsdSwmtBWlfYD3WZQwcaSvyvbc1uU8hQ9zXbQQrn7vFKhjoHiZJSvBX3
 jWEYP+MYji24fwrltp3wIh/r1ZADesYbuuITzK8OGqdN7cskFWKcP3mFpilPjCShg6OJIBLGX+e
 zecSOFAc9HP0hnxWPPwkKnraivgAoFj9vxbm7R9Gc9m55L6GN7e390P08rnMQ6EC5BpvlVNOL0n
 5n0SRRY4QvfpQdA5xscoT9JF1M5M/GdV0xGjiBV8dlej9TpAdynoZMK4/k5z6V8NQPQfd/KxnGW
 LDQFBldOoTBGNN1lmh8lU7p7p//DeNwO3nn6FBhAQC8dGBgIvJzZ/PJj7BB/v9id4ADEBk/wCVe
 seZ7+84EddJWIalaWxZc6/nwWeEcPcOg5AnxGoColLJDSVknOMAlQZBUaPt8tr+H7NotRLOl0Gj
 AChHtMs+wVYQDbD1shHIqtZUJVkpy/mGkCKyuiLMApS2y6H4JHrFmnnbki1iiJsf+X
X-Google-Smtp-Source: AGHT+IEPTEAyg2VTDj2bTeBqOGww5qFjen3FrmzjYOm+wONVxW85uaROvhJBXAfmBZ8bwQEGBUPCOg==
X-Received: by 2002:a05:6000:61e:b0:42f:b835:e15c with SMTP id
 ffacd0b85a97d-432bcfe4b6bmr25409912f8f.29.1768212780027; 
 Mon, 12 Jan 2026 02:13:00 -0800 (PST)
Received: from ?IPV6:2a00:f2a:e0df:cca0:1161:e931:8b2e:a414?
 ([2a00:f2a:e0df:cca0:1161:e931:8b2e:a414])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm37535615f8f.33.2026.01.12.02.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:12:59 -0800 (PST)
Message-ID: <1a443069-2c90-43a6-9c9d-c00ae214386d@linaro.org>
Date: Mon, 12 Jan 2026 12:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: at91: move atmel_serial.h to
 include/dm/platform_data
To: Robert Marko <robert.marko@sartura.hr>
Cc: luka.perkov@sartura.hr, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
References: <20251230210201.496403-1-robert.marko@sartura.hr>
 <b95c93d6-7a50-4fb3-b94e-ffd72b825cfc@linaro.org>
 <CA+HBbNEStuFC0zh4TAqREWrLEqRFEwSc0YP_bwf=T-95n1Roag@mail.gmail.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <CA+HBbNEStuFC0zh4TAqREWrLEqRFEwSc0YP_bwf=T-95n1Roag@mail.gmail.com>
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



On 1/12/26 11:52, Robert Marko wrote:
> On Mon, Jan 12, 2026 at 9:46 AM Eugen Hristev <eugen.hristev@linaro.org> wrote:
>>
>>
>>
>> On 12/30/25 23:01, Robert Marko wrote:
>>> Move the arch specific atmel_serial.h header from AT91 to the generic
>>> include/dm/platform_data.
>>>
>>> This will be used for support on Microchip LAN969x.
>>>
>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>> ---
>>>  board/bluewater/gurnard/gurnard.c                               | 2 +-
>>>  board/siemens/corvus/board.c                                    | 2 +-
>>>  board/siemens/smartweb/smartweb.c                               | 2 +-
>>>  board/siemens/taurus/taurus.c                                   | 2 +-
>>>  drivers/serial/atmel_usart.c                                    | 2 +-
>>>  .../include/mach => include/dm/platform_data}/atmel_serial.h    | 0
>>>  6 files changed, 5 insertions(+), 5 deletions(-)
>>>  rename {arch/arm/mach-at91/include/mach => include/dm/platform_data}/atmel_serial.h (100%)
>>>
>>> diff --git a/board/bluewater/gurnard/gurnard.c b/board/bluewater/gurnard/gurnard.c
>>> index 3275803226a..71db6409721 100644
>>> --- a/board/bluewater/gurnard/gurnard.c
>>> +++ b/board/bluewater/gurnard/gurnard.c
>>> @@ -29,7 +29,7 @@
>>>  #include <asm/arch/at91_rstc.h>
>>>  #include <asm/arch/at91_rtc.h>
>>>  #include <asm/arch/at91_sck.h>
>>> -#include <asm/arch/atmel_serial.h>
>>> +#include <dm/platform_data/atmel_serial.h>
>>>  #include <asm/arch/clk.h>
>>>  #include <asm/arch/gpio.h>
>>>  #include <dm/uclass-internal.h>
>>> diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
>>> index a8714e055d7..7a70a7dfc8b 100644
>>> --- a/board/siemens/corvus/board.c
>>> +++ b/board/siemens/corvus/board.c
>>> @@ -20,7 +20,7 @@
>>>  #include <asm/arch/at91sam9_smc.h>
>>>  #include <asm/arch/at91_common.h>
>>>  #include <asm/arch/at91_rstc.h>
>>> -#include <asm/arch/atmel_serial.h>
>>> +#include <dm/platform_data/atmel_serial.h>
>>>  #include <asm/arch/gpio.h>
>>>  #include <asm/gpio.h>
>>>  #include <asm/arch/clk.h>
>>> diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
>>> index 6fa3ca573ae..ce16aad3b98 100644
>>> --- a/board/siemens/smartweb/smartweb.c
>>> +++ b/board/siemens/smartweb/smartweb.c
>>> @@ -25,7 +25,7 @@
>>>  #include <asm/arch/at91sam9260_matrix.h>
>>>  #include <asm/arch/at91sam9_smc.h>
>>>  #include <asm/arch/at91_common.h>
>>> -#include <asm/arch/atmel_serial.h>
>>> +#include <dm/platform_data/atmel_serial.h>
>>>  #include <asm/arch/at91_spi.h>
>>>  #include <spi.h>
>>>  #include <asm/arch/clk.h>
>>> diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
>>> index 252b0787124..690c00046fa 100644
>>> --- a/board/siemens/taurus/taurus.c
>>> +++ b/board/siemens/taurus/taurus.c
>>> @@ -24,7 +24,7 @@
>>>  #include <asm/arch/at91_rstc.h>
>>>  #include <asm/arch/gpio.h>
>>>  #include <asm/arch/at91sam9_sdramc.h>
>>> -#include <asm/arch/atmel_serial.h>
>>> +#include <dm/platform_data/atmel_serial.h>
>>>  #include <asm/arch/clk.h>
>>>  #include <asm/gpio.h>
>>>  #include <linux/mtd/rawnand.h>
>>> diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
>>> index 0b35582aaa4..d6c3d4cbcc8 100644
>>> --- a/drivers/serial/atmel_usart.c
>>> +++ b/drivers/serial/atmel_usart.c
>>> @@ -18,7 +18,7 @@
>>>
>>>  #include <asm/io.h>
>>>  #if CONFIG_IS_ENABLED(DM_SERIAL)
>>> -#include <asm/arch/atmel_serial.h>
>>> +#include <dm/platform_data/atmel_serial.h>
>>>  #endif
>>>  #include <asm/arch/clk.h>
>>>  #include <asm/arch/hardware.h>
>>> diff --git a/arch/arm/mach-at91/include/mach/atmel_serial.h b/include/dm/platform_data/atmel_serial.h
>>> similarity index 100%
>>> rename from arch/arm/mach-at91/include/mach/atmel_serial.h
>>> rename to include/dm/platform_data/atmel_serial.h
>>
>> Hello Robert,
>>
>> These patches break the build for some boards. e.g. corvus_defconfig
>>
>>
>> drivers/serial/atmel_usart.c: In function ‘atmel_serial_setbrg_internal’:
>> drivers/serial/atmel_usart.c:44:20: error: implicit declaration of
>> function ‘get_usart_clk_rate’ [-Werror=implicit-function-declaration]
>>    44 |         usart_hz = get_usart_clk_rate(id);
>>       |                    ^~~~~~~~~~~~~~~~~~
>>   AR      spl/disk/built-in.a
>>   CC      spl/fs/fs_internal.o
>> cc1: some warnings being treated as errors
> 
> So, somehow during the SPL build, the following is not evaluated as true:
> #if CONFIG_IS_ENABLED(ARCH_AT91)
> 
> Which is rather weird as u-boot.cfg in the spl dir has:
> #define CONFIG_ARCH_AT91 1
> 
> So, this is some CONFIG_IS_ENABLED interaction with SPL that I am not
> really familiar with as
> #if IS_ENABLED(CONFIG_ARCH_AT91) works just fine and gets the header included.

IIRC when the spl is being built, a dedicated config is being created
from the proper defconfig by selecting CONFIG_SPL_***

You will have to check why the ARCH_AT91 is not selected for spl, which
is strange indeed

> 
> Regards,
> Robert
> 
>>
>>
>> Please have a look,
>> thanks,
>> Eugen
>>
> 
> 

