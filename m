Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0573C021B6
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 11:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A06780F56;
	Tue, 25 Feb 2025 12:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740482940;
	bh=czCojixwa7og2RffGdwfeyAOnMWB38+1VlO6EmuCrPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=SzCeLXIgIZMCKWokUwQaS5Fb7L0bum8th6mgic6CDV1E6YcTJP2dndfaQkCWcH2dw
	 JcuJDET1SSQTGNDrY9ZxfEf64mErjrbQ31QIJVb807GuHFNfwDlGtL2XGv2a7WxuNg
	 rFmtAyNk20J6fZ7iyg+n4uBu6OKT5PVfgiTutPIihCcfbzGRrdpQiLUZjtgC1tuC5c
	 bPyNOkUkL+Ja4i4UyelWHF4GmpvpspFd22oPrQ3n4HBbSR+qANG/TYiwSKxGehfcyr
	 gT0i4UUSbMUcN6McfkfPCuvWf5d0D7KJ9zpNBiLqcGlZw0kDAVxJ6ZmCYLulF4jIMv
	 gPK+gcylutTlg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C6280F92; Tue, 25 Feb 2025 12:28:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F8FF80805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CJTiKcia"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8102810382D2E; Tue, 25 Feb 2025 12:28:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740482935; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czCojixwa7og2RffGdwfeyAOnMWB38+1VlO6EmuCrPo=;
 b=CJTiKciaFCZPDvEs5WdLy/+428Vph5sqp2aiCqFqhkEsAaz9e3csDm9pYTZU5teTC8UnWO
 Z9xBUSWy/IZNPJ603rrAH/zR4qCZRgNbwPrzVrh+MNYbvQWJnp5HT+GZuQzXKQWVe3KNet
 a2CP39khSugAAz5qLrBBbjL/ZcDD1osYVz9mMJlZiaPCuoXFIQH4sWVl7jAaG+8Ft+8lC8
 2CODYQtYN52aUz6BOkoW9uD2nvATnt5FRNKNbg5FDaRpEaL7qcrM5zUEEEUJBxc5YuNrQR
 laUPTHEtkObyFifbMvGIKaJ/6jXsv2NfevnPPOiFr/TKEQYMBmH42maDR2GTbQ==
Message-ID: <ace167e3-1535-7184-6583-0e9654a8c7d2@denx.de>
Date: Tue, 25 Feb 2025 12:29:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] led: fix next coverity scan error
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250225094923.71364-1-hs@denx.de>
 <308422ff-3036-48ed-9d78-305b6904fc87@cherry.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <308422ff-3036-48ed-9d78-305b6904fc87@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Quentin,

On 25.02.25 12:13, Quentin Schulz wrote:
> Hi Heiko,
> 
> On 2/25/25 10:49 AM, Heiko Schocher wrote:
>> Tom reported the following covervity scan error:
>>
>> *** CID 542488:  Control flow issues  (NO_EFFECT)
>> /drivers/led/led-uclass.c: 277 in led_get_function_name()
>> 271                     return uc_plat->label;
>> 272
>> 273             /* Now try to detect function label name */
>> 274             func = dev_read_string(dev, "function");
>> 275             cp = dev_read_u32(dev, "color", &color);
>> 276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>>>      CID 542488:  Control flow issues  (NO_EFFECT)
>>>>>      This less-than-zero comparison of an unsigned value is never true.
>> "color < 0U".
>> 277             if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
>> 278                     cp = -EINVAL;
>> 279
>>
>> see:
>> https://lists.denx.de/pipermail/u-boot/2025-February/581567.html
>>
>> Fix it.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>
>> ---
>> Azure build:
>> https://dev.azure.com/hs0298/hs/_build/results?buildId=171&view=results
>>
>>   drivers/led/led-uclass.c                       | 2 +-
>>   dts/upstream/include/dt-bindings/leds/common.h | 5 ++++-
> 
> NACK. We don't modify files in dts/upstream as they are directly imported from devicetree-rebasing 
> tree and would either be replaced during next update or induce a merge conflict.

Ah, yes, indeed!

>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>> index 22f61d12d38..e2edcc43f30 100644
>> --- a/drivers/led/led-uclass.c
>> +++ b/drivers/led/led-uclass.c
>> @@ -274,7 +274,7 @@ static const char *led_get_function_name(struct udevice *dev)
>>       func = dev_read_string(dev, "function");
>>       cp = dev_read_u32(dev, "color", &color);
>>       // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>> -    if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
>> +    if (color >= LED_COLOR_ID_MAX)
>>           cp = -EINVAL;
>>       if (cp == 0 || func) {
>> diff --git a/dts/upstream/include/dt-bindings/leds/common.h 
>> b/dts/upstream/include/dt-bindings/leds/common.h
>> index 4f017bea012..9e5ac5196e2 100644
>> --- a/dts/upstream/include/dt-bindings/leds/common.h
>> +++ b/dts/upstream/include/dt-bindings/leds/common.h
>> @@ -21,7 +21,10 @@
>>   #define LEDS_BOOST_ADAPTIVE    1
>>   #define LEDS_BOOST_FIXED    2
>> -/* Standard LED colors */
>> +/*
>> + * Standard LED colors, LED_COLOR_ID_WHITE must be the
>> + * first one and start with value 0
>> + */
> 
> Can you explain why white needs to be the first AND be 0?
> 
> I don't know enough about the C standard or compilers in general to know what happens if the indices 
> in led_colors aren't in order but I guess that's where your limitation comes from?
> 
> e.g.
> 
>    static const char * const led_colors[LED_COLOR_ID_MAX] = {
>            [LED_COLOR_ID_WHITE] = "white",
>            [LED_COLOR_ID_RED] = "red",
>            [LED_COLOR_ID_GREEN] = "green",
>            [LED_COLOR_ID_BLUE] = "blue",
>            [LED_COLOR_ID_AMBER] = "amber",
>            [LED_COLOR_ID_VIOLET] = "violet",
>            [LED_COLOR_ID_YELLOW] = "yellow",
>            [LED_COLOR_ID_IR] = "ir",
>            [LED_COLOR_ID_MULTI] = "multicolor",
>            [LED_COLOR_ID_RGB] = "rgb",
>            [LED_COLOR_ID_PURPLE] = "purple",
>            [LED_COLOR_ID_ORANGE] = "orange",
>            [LED_COLOR_ID_PINK] = "pink",
>            [LED_COLOR_ID_CYAN] = "cyan",
>            [LED_COLOR_ID_LIME] = "lime",
>    };
> 
> is ordered, but what happens if you have e.g.:
> 
>    static const char * const led_colors[LED_COLOR_ID_MAX] = {
>            [LED_COLOR_ID_RED] = "red",
>            [LED_COLOR_ID_WHITE] = "white",
>            [LED_COLOR_ID_GREEN] = "green",
>            [LED_COLOR_ID_BLUE] = "blue",
>            [LED_COLOR_ID_AMBER] = "amber",
>            [LED_COLOR_ID_VIOLET] = "violet",
>            [LED_COLOR_ID_YELLOW] = "yellow",
>            [LED_COLOR_ID_IR] = "ir",
>            [LED_COLOR_ID_MULTI] = "multicolor",
>            [LED_COLOR_ID_RGB] = "rgb",
>            [LED_COLOR_ID_PURPLE] = "purple",
>            [LED_COLOR_ID_ORANGE] = "orange",
>            [LED_COLOR_ID_PINK] = "pink",
>            [LED_COLOR_ID_CYAN] = "cyan",
>            [LED_COLOR_ID_LIME] = "lime",
>    };
> 
> ? I think it should be just fine?

Yep, fully fine, so I drop simply this comment.

> Reading the code, it seems there's an assumption that led_colors has a contiguous and full list of 
> indices from LED_COLOR_ID "enum". What happens when the dt-binding gets extended with new colors and 
> the DT makes use of it without updating led_colors in led-uclass.c? Aren't we going to try to print 
> a NULL string?
> 
> If that's the case, I see two solutions:
> - ignore LED colors when they aren't in led_colors,
> - decouple LED_COLOR_ID_MAX from the binding with UBOOT_LED_COLOR_ID_MAX which is the currently 
> supported max based on led_colors last index (+1). We could even do a #warn or #error so that 
> UBOOT_LED_COLOR_ID_MAX and LED_COLOR_ID_MAX are the same value so that we're forced to keep them in 
> sync, but that'll make Tom's life harder when merging newer releases of devicetree-rebasing tree.

Yep... may Tom can comment here, what he prefers, thanks for the review!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
