Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB88C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 11:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56EE81F0D;
	Tue,  3 Jun 2025 13:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZhqR3817";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 208ED81FFC; Tue,  3 Jun 2025 13:09:55 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B6FC81E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 13:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so59888595e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 04:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948991; x=1749553791; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BFLu7C3xASYZ3qXVEJFYF+RqWkskaTlGP1Z50+hE5C8=;
 b=ZhqR3817Xx/0KaHpRl8YoaiNsUlsdgrO+bnxmS0oyWp1vCyn4yXEm+hz2Im+Tp3h3q
 OG6uBqJUQIEIbpUnm6XPDlzXw4NquL/ZTlbx9aTXkwoDCQmp3fau6+54zSBlsCyAx9Eo
 cl/PzQox7+Kqdvb8O8Qpspgf5BBy1OLxU+7Rx2RBzxE8koSthOvvRm63FZsTHRKEfcx2
 IH8tJsaukL9sskMkhQl+F4jKLcxBJdTA3vxoe3f5792dDDFI8E3/KfdupAxn+qeBqmXA
 mRMivVNkcJFnV5BGwYPxGtNtKbS2l2L8WswKu0QtqKbZcvo3Szguv8rcG4OH+sGxZB55
 hA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948991; x=1749553791;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BFLu7C3xASYZ3qXVEJFYF+RqWkskaTlGP1Z50+hE5C8=;
 b=LsxqOIAhud9f0RaXTfjqiBPa4yKwrAdCousiXxx87Etcz4yNkG6lhsZGfCZwSIwEew
 x5M+3lQ7dGhTLcWXuXoh+0HPngQAXhGmDQD1RfO2IbLoqQAxSuB0ioEaUVyAKhtWVZIy
 U6Y0IfWKqjf/9IGNOgK8kTcvWDPL6mPWeYMcTwzqa23TmdvU4WhI+bb052+SV4bKjq2r
 ZZhtb99tQ2G3JQYWnEv9JYnDjWxuF7t07RfgWGRtbWsINsf7t8oK+JDbCCWNbZtqhQae
 6sedcYNeSlwc+9ghU/HRP5YpY2lTBlowQxgOBtt+W4qdUVYYfhyyHBKGAxtBVijtPENH
 hEXA==
X-Gm-Message-State: AOJu0Yy6fume3DSOioezisqselmi+0r+zgfMdxKJihJ8UeTj8HHiff1Y
 TT0LMMnakvlhD15tsGTalvaiXWAgj16eXJp1wsbViXsSwADjU080d2ejzs9FOsXNHFQ=
X-Gm-Gg: ASbGncsy6RaF5DmaARTXuvV94ViepAWf3j/4AQaynZx1bmfD11DR6TtmrrM5IElaboO
 X0rtXDlSF3WGmHtJG30Fk0Mvp79796w7+UAQYPm6/aYXl2klhiwu0hpCLArlxQWsCZPfmrau84N
 ulMgRPCgwHUUxA1LcyD7KTIG5D2m/HI4SUBTdX6ICdGoDAurQV/GKAS+X8KEaA973CtjDlMLZS6
 eokuZ5dOCix0w4yiDV0H7dMEKWy2ExeLX8+QmWy9mMkd49oigIGIk4Z6G1Bxz9XmqMv4mA9lIIb
 yOTH3FNRN8dsK5cIm/8/lWKixhsRA0B8o/+2f0tu9y7dUrajkAlekenHb3gOx7SEeQrPsQ==
X-Google-Smtp-Source: AGHT+IF7gOlEG5uzo54aWyAA8ykemVkD+pZCO+WEuUyt1dHq7iCiAdlmitYSMN+M6GF0Jtboh8oLow==
X-Received: by 2002:a05:600c:4ed1:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-450d657fcd0mr137466945e9.25.1748948990610; 
 Tue, 03 Jun 2025 04:09:50 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009752esm17896992f8f.74.2025.06.03.04.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:09:50 -0700 (PDT)
Message-ID: <d34079e4-138b-4bec-95fa-c881ad0b2a22@linaro.org>
Date: Tue, 3 Jun 2025 14:09:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atmel: Remove local <dt-bindings/pinctrl/at91.h>
To: Mihai.Sain@microchip.com
Cc: u-boot@lists.denx.de, trini@konsulko.com
References: <20250528000118.3002916-1-trini@konsulko.com>
 <72a265ca-d5e7-40ca-b05f-5a3cf8f0f0c8@linaro.org>
 <20250602145716.GX100073@bill-the-cat>
 <3ccfcf04-f6e7-4510-ba18-637275384cb7@linaro.org>
 <PH3PPF37F43E35D1A1812BFA8DF0D982EDC826DA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <PH3PPF37F43E35D1A1812BFA8DF0D982EDC826DA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
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



On 6/3/25 09:18, Mihai.Sain@microchip.com wrote:
>>>>> We have this binding file in both include/dt-bindings/ and
>>>>> dts/upstream/include/dt-bindings. These files are identical save for the
>>>>> fact that we do not have commit adb2424d0d05 ("dt-bindings: clock: add
>>>>> clock definitions for Ralink SoCs") from the kernel applied. However,
>>>>> this change is rather important and should not have been omitted here
>>>>> most likely. Remove our local copy to get in sync with upstream now.
>>>>>
>>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>>>> ---
>>>>> Cc: Eugen Hristev <eugen.hristev@linaro.org>
>>>>> Cc: Mihai Sain <mihai.sain@microchip.com>
>>>>>
>>>>> The full kernel commit log is at
>>>>>
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?
>> id=0b3292852863215825f88905b9dbafc3101e1d7e
>>>>> and so this sounds very important. Please let me know if this should go
>>>>> in master for v2025.07 (or Eugen, please pick it and send a PR). Thanks!
>>>>
>>>> Hi Tom,
>>>>
>>>> I do not see the connection with the Ralink SoCs. Maybe wrong commit
>>>> referenced ?
>>>
>>> Erm, the kernel link for me is "pinctrl: at91: Enable slewrate by
>>> default on SAM9X60".
>>
>> The link is good, I ment the commit message above.
>>>
>>>> Anyway, on the slewrate bits, as of today we have DIS==0 and ENA==1 and
>>>> the driver treats them the same way. Hence DTs with DIS flag will have
>>>> the bit erased in the register
>>>>
>>>> With the kernel bindings file, DIS==1 and ENA==0, but the driver still
>>>> considers DIS==0 and ENA==1 , so the DTs that have DIS as flags will get
>>>> the bit written in the register.
>>>>
>>>> If we also port the driver patch then the driver will also consider
>>>> DIS==1 and ENA==0 , so the DTs with DIS flag will get the bit written in
>>>> the register.
>>>>
>>>> So there is an important change by changing the bits values, as the
>>>> register eventually ends up with a different value.
>>>> The driver patch apparently just interprets the DIS/ENA bits
>>>> differently, but the end result is the same
>>>>
>>>> Please correct me if my logic is wrong.
>>>>
>>>> I would also believe testing on the sam9x60 would be required for the
>>>> slew rate change. From what I remember back then, slew rate change was
>>>> not needed in Uboot, but I might be wrong.
>>>
>>> So, there's I guess two parts to all of this. First, yes it would be
>>> good to test this change on real hardware and make sure things work as
>>> expected. Second, yes, it looks like we need to make the parallel change
>>> in drivers/pinctrl/pinctrl-at91.c (to match what the kernel did at the
>>> time too) and we can't just remove the old binding file we need to
>>> update them at the same time (since long term we need to remove all of
>>> the old kernel dts stuff).  The final thing is that it really is
>>> important to get them in sync as it's valid to pass our device tree to
>>> the kernel to use. Can you take care of the changes here?  I don't have
>>> hardware to test on, thanks.
>>
>> I do not have any sam9x60 based board . This would have to be tested by
>> Mihai or someone from Microchip team.
>>
>> So your patch would be good, then another patch for the pinctrl driver
>> to port the changes from Linux . This can be done by Mihai or the team,
>> if they want, otherwise I will do it, but it has to be tested anyway by
>> someone . Especially the hardware with slew rates, like the SD card.
> 
> Yes.
> I can test the modifications on sam9x60 and sam9x7 boards, since they use the same pin controller.
> This patch should be ported ?
> https://github.com/torvalds/linux/commit/0b3292852863215825f88905b9dbafc3101e1d7e

Yes this looks right.
Also this patch (in the mail), the removal of the old header, makes
Uboot use the kernel header that already includes the change for the macros.

> 
> Regards,
> Mihai
> 
>>
>> Eugen
>>
>>>
> 

