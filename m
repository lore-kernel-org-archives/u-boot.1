Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7D9C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 13:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD9F8070C;
	Wed,  4 Jun 2025 15:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xv+7YnNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F31F807B1; Wed,  4 Jun 2025 15:38:32 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CE980584
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 15:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so3153236f8f.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749044309; x=1749649109; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uSpYF4knH0snEr5Gi9SPtQTJRexWUFEuz01/O6mMnk0=;
 b=Xv+7YnNjOmqc2Y4f1zRPwTvYV9eGZiySLgExlAEiPSBctJyt9HWyKNO/k2q2QmxMFw
 7P+NgioaIWMBNEvWRCtgy2yvHqgjBk6FZfO7tTtdCLE0CNdMwjEkjFllERNpu9PZkb70
 Cv4+jys1ELsDf6EHq+hF7PDM8SWr9nhf0O3OU/cPnah3695QfCvj+MrqJpfiQ0gqvTqT
 b2P3zBxVS4CI67tzR4x/l6KL0Ki5gM9Lo3mMx3ur3MH4zSAN3N9J6JcTaQN8eKImDufg
 +65N/1DCro2kJrDzsAGigLdeo9IecGo16euXZ8dgCTGqG9i9Xy/ITlBvdRNaHf600tQn
 FJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749044309; x=1749649109;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uSpYF4knH0snEr5Gi9SPtQTJRexWUFEuz01/O6mMnk0=;
 b=J/LTjhR8c81jWPMlPhasodM30m489yM9HX1N5heABKBoyBCW1dNywIf8O9nT0/+4jd
 6sNNMPgJI0vN2zZRL5jtAONCh+mogW8Q8OdYZ7vnGQfyt0BooUKXveDiniyBfnNTG7CH
 kcOLv5RLyCNb4nDx3XP/6Q2IMP5a0YSKhEKrQFJwVRKcFockFNzlI8yHTB1I685izJRs
 JXcUH8RRGl7/lZJQ8iuxdNM+4kMw0M4354s9KzBZD3/KpgjKnBsgXOhaQlEsFInL9lV2
 qdbUHE5k2Dq8PlQcVp3Kghk3B+I9ED4doRX0pZhcq0RV31Nx7Hhvl5p+G91cF1YaNHak
 aDhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULvIrHE7J3jTbzrqwaU62znRTEHiYfOp/Sx5CBmKpk1HDICsGoq78Z37BnId91UyEqU4luLGs=@lists.denx.de
X-Gm-Message-State: AOJu0YyaZJ9Hbf8ONFhzuBbySH4WfGLK+iPsWyzGZjM08vTCxnNk3CX9
 qBV5d4JEroHpmtA2i2xryTYvfZNE4pFeVVPPnczEqYft7BRLQAc2CLonblwU5YZtrrQ=
X-Gm-Gg: ASbGncsU3wXGh8TNlGjvvMVp9cT6UVZ0Ww4EH4cTiipQkj9YEmP76X4GmOrgl6hg/kS
 1T3UZGWDJkFAMCn7l9jr3jLjwoh7iYV1qmFPzMy9bDkpb0yoT5cf4WtLE+tHyKRZ3eCaTy1wlQh
 zplEaTnJx3Z+LXWUqr2VxLbQdkmlm+i1ACj3NPvOi6YHPRMMVzOnfVMZCYapZXM7QeOzzYnS9pZ
 JV5USrCSC2HDLeXJ5PeBkwB+BtgHdymQFaduRRVSe+S/3t0j+wYgwrkGBBIJYsh38OPtgoRTni9
 M8CRKPqWYiF+2lsM8fJbqJBuAT6vmwqZ65O4MjGcAV02U2qccpEAgcgDL8QPE4oKGDmoK2uus+f
 GLE3i5SEnIxVr1dzHCJuwjsv5eg==
X-Google-Smtp-Source: AGHT+IHHieS2bkElfhPWmASh25JXn70+DwR87hHl5YHuKL7Pl4D7wLFdL++AxnlU23WmP+L/OJC76g==
X-Received: by 2002:a05:6000:420f:b0:3a4:db49:94aa with SMTP id
 ffacd0b85a97d-3a51d904540mr2412079f8f.21.1749044309498; 
 Wed, 04 Jun 2025 06:38:29 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:968c:2df3:c75e:5a31?
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a52203c8a7sm1482947f8f.32.2025.06.04.06.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 06:38:28 -0700 (PDT)
Message-ID: <5f3c17c5-8cd5-4bba-b9a8-13fc8eacc377@linaro.org>
Date: Wed, 4 Jun 2025 15:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/28] board: google: Add board_debug_uart_init() for
 Trogdor
To: u-boot-qcom@groups.io, Stephen Boyd <swboyd@chromium.org>,
 u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>
References: <20250523225845.2311989-1-swboyd@chromium.org>
 <20250523225845.2311989-25-swboyd@chromium.org>
 <1843AD3474836FFE.10936@groups.io>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <1843AD3474836FFE.10936@groups.io>
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



On 5/28/25 13:25, Caleb Connolly via groups.io wrote:
> 
> 
> On 5/24/25 00:58, Stephen Boyd wrote:
>> Implement board_debug_uart_init() for Trogdor boards so that the debug
>> UART can be used. Initialize the clk to XO speed (19.2MHz) and change
>> the pin configuration to mux out the uart hardware on the pins that are
>> connected to the closed case debug (CCD) port for the AP. This is enough
>> to get the early debug console working on boards like Lazor, but it
>> should work for all Google Trogdor boards.
>>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> 
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> 
> Would you be willing to add a MAINTAINERS file here for the trogdor 
> specific bits?

Oh right, CI fails since the trogdor defconfig doesn't have a 
maintainer, I'm happy to put it under ARM SNAPDRAGON but it would be 
great if you're willing to take it up. Please let me know ASAP (feel 
free to send a patch adding board/google/trogdor/MAINTAINERS on top of 
this series) so I can pick this up :)

Kind regards,>
> Kind regards,> ---
>>   board/google/trogdor/Makefile     |  3 +++
>>   board/google/trogdor/debug.config |  6 +++++
>>   board/google/trogdor/debug_uart.c | 41 +++++++++++++++++++++++++++++++
>>   3 files changed, 50 insertions(+)
>>   create mode 100644 board/google/trogdor/Makefile
>>   create mode 100644 board/google/trogdor/debug.config
>>   create mode 100644 board/google/trogdor/debug_uart.c
>>
>> diff --git a/board/google/trogdor/Makefile b/board/google/trogdor/ 
>> Makefile
>> new file mode 100644
>> index 000000000000..fd2933cf1e6f
>> --- /dev/null
>> +++ b/board/google/trogdor/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_DEBUG_UART_BOARD_INIT) += debug_uart.o
>> diff --git a/board/google/trogdor/debug.config b/board/google/trogdor/ 
>> debug.config
>> new file mode 100644
>> index 000000000000..7d8a6706a92e
>> --- /dev/null
>> +++ b/board/google/trogdor/debug.config
>> @@ -0,0 +1,6 @@
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_DEBUG_UART_ANNOUNCE=y
>> +CONFIG_DEBUG_UART_BASE=0xa88000
>> +CONFIG_DEBUG_UART_MSM_GENI=y
>> +CONFIG_DEBUG_UART_CLOCK=36864000
>> +CONFIG_DEBUG_UART_BOARD_INIT=y
>> diff --git a/board/google/trogdor/debug_uart.c b/board/google/trogdor/ 
>> debug_uart.c
>> new file mode 100644
>> index 000000000000..3d15d0d77728
>> --- /dev/null
>> +++ b/board/google/trogdor/debug_uart.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <asm/io.h>
>> +#include <debug_uart.h>
>> +#include <linux/delay.h>
>> +
>> +/*
>> + * Enable the UART8 clks and pinctrl settings for SC7180.
>> + *
>> + * The debug UART goes out over CCD. The debug uart clk setting is 
>> 36864000 to
>> + * make the buad rate calculation come out properly for the qcom geni 
>> serial
>> + * driver.
>> + */
>> +void board_debug_uart_init(void)
>> +{
>> +    u32 val, mask;
>> +    unsigned int timeout = 100;
>> +
>> +    /* Enable wrap1_s2 clk */
>> +    val = readl(0x100000 + 0x52008);
>> +    val |= BIT(24);
>> +    writel(val, 0x100000 + 0x52008);
>> +    /* Wait for enable */
>> +    do {
>> +        val = readl(0x100000 + 0x18274);
>> +        mask = GENMASK(30, 28) | BIT(31);
>> +        val &= mask;
>> +        if ((val & BIT(31)) == 0 || ((val >> 28) & 7) == 1)
>> +            break;
>> +        udelay(10);
>> +    } while (timeout--);
>> +
>> +    /*
>> +     * Configure GPIOs
>> +     * Bits: 0-1 = pull
>> +     * Bits: 2-4 = func
>> +     * Bits: 6-8 = drive strength
>> +     */
>> +    writel(0x3 | (1 << 2), 0x3900000 + (0x1000 * 44)); // Pin 44 - 
>> PULL_UP, func1 (qup12), 2ma
>> +    writel(0x3 | (1 << 2), 0x3900000 + (0x1000 * 45)); // Pin 45 - 
>> PULL_UP, func1 (qup12), 2ma
>> +}
> 

-- 
Casey (she/they)

