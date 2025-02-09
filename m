Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE915C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 17:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F5380B9E;
	Sun,  9 Feb 2025 18:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="obCeUdd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A5BF80BA0; Sun,  9 Feb 2025 18:33:32 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC0C80A0A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 18:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AFBD03F1CC
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739122408;
 bh=ehZk3En/nA7c4eP5M2Wzb08BrZfIX4YFA6sBXJyGKFA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=obCeUdd5+lfg14s7TPzR4JORqlDX7M8B9h+uk6rbl+3e/r7GaJk6txE3bA1Aso92L
 Eu8CCVS9mvlxzzhI9jGyO4KWeo8JsYrzwLqfVgPoIIduFQFzBqC0tRZzPMptG5zMbY
 O6tBa6g9+S5hJKJmBc/ZAlI6DTE5uPmekRVmmIq4qeX9wpogxI/24MmdO3ztzq33du
 zAwwB0ye5TbFRe3Kqk12Ar/G+qrqV/HbDhh7RrVHvMAA4dhHudP2PM1q6bgelkYLFj
 gHt7dJqHP25k7cTtnfwqsRKp+lF4wgW2qdvqr769kzAluYk/9xBPdwFcNYn9AN3CD5
 Vr4YeoirS8XVQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so3877935e9.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 09:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739122408; x=1739727208;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ehZk3En/nA7c4eP5M2Wzb08BrZfIX4YFA6sBXJyGKFA=;
 b=GfqwO3MFjSSMrpgZDyf7eTXkqEKamBeQVSM+BFbxhVAsLB4GwqoWKN1Ap3iqe8Erm3
 NeUoiXfpiQYvA1WtDI4XhO1FWu530gXoTVKJZXEPEeqenFFYLlSJek2ZKZTFe7QIpVF2
 /Yyl+pTghm9agG+pgRI0zebWNS4x9rypgdLX7QbdDbdpF8s7fsg6GUsGCFdWci8yBTrX
 bVO328cVtKvHBLIT+V2itHwx1/GmIn8aiGGi5Tucw+eh2a1/XEeNk0oQaqocD5A7kz+p
 NNQsBKIthY0nOFdO6ZGnBOApc7w9o4uDbxBcXio8OTWbDNFjX5hjdEr1z9AXLh4qSmzF
 jHiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf/EQLONbivIM6UWFvAifGBDV1VjXglxXKiu81/kE/uM0VhYWSS+a5lJzcXWvUIe77vw1e6rE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs2lDzjDBKugeuHidC265V/WYi81qnPLD6bOZrqxdhP0XxTpGX
 ehXjqOZiyn5FiAKx+buAEaBeeSgSbwp0dpgfKXbACMGOmmf9Xj40DBtUUFw7aNk1izGzEu541kO
 iZZ5FY0ZcmqleaCsWwxPxg/vThNyH2hbo7s3lgva478TGMUL9tCJ3G0QAgxS0jSJeVHs=
X-Gm-Gg: ASbGncuywwzBvJvq8bTllXnSYxdHfLfBYZxWmy+t10YFOCet9NRt5Ns9Hm1oeNM+gDW
 JWYH9WjEpZ0iaM2dwVqxyTTtXgDyrWinQ/XmlEyXtC5bDQRwPIhIVzt5OpO3DlHsUrsEYXbZDB9
 NPBjdZbuuhtm4Vljgq1SkTzH/jG3gxlAe4cEPqZn4mLgrZJjqaDPQP6L4RGSNopif1OdO8DlTiM
 8bgT3VhNpiHv/zqaDQWoAW7fvLtid1VcDQkYFIP2yiS6aGsr4QF/ViczMJhvxCZhvZJNmw/T8kH
 eGZ1H7ZCQylEww3mvhuNO3nxS90eLvCDhzVwTYFv+uF99YAQizvsrWaAq48YIygsXEXQuYOCrii
 /5A==
X-Received: by 2002:a05:600c:354a:b0:434:a1d3:a30f with SMTP id
 5b1f17b1804b1-4392497d1cdmr79513715e9.6.1739122407690; 
 Sun, 09 Feb 2025 09:33:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWErkWjQq8I2IAcyP4kZW3YECeUkSebaqBfqNp8Y2vOj2+NsuLXF+SPFJrWnuCBr4SEy7vNg==
X-Received: by 2002:a05:600c:354a:b0:434:a1d3:a30f with SMTP id
 5b1f17b1804b1-4392497d1cdmr79513515e9.6.1739122407317; 
 Sun, 09 Feb 2025 09:33:27 -0800 (PST)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db11264sm153249155e9.35.2025.02.09.09.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 09:33:26 -0800 (PST)
Message-ID: <d4b90028-a68d-4606-98d3-7f6a34272c8b@canonical.com>
Date: Sun, 9 Feb 2025 18:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] boot: continue in fit_find_config_node()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de
References: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
 <20250209115217.85250-2-heinrich.schuchardt@canonical.com>
 <CAFLszTirNaX-6KfMPJ1LNHe3iU_QzATy0s1dHnfKbUw22NCP-A@mail.gmail.com>
 <83c2dc33-83a3-45eb-96e7-8c3b7ae38b88@canonical.com>
 <CAFLszThBmOvnkGLZEv+rQkS1F+4gB=yJMQ-+UShDrUbGyGP36w@mail.gmail.com>
 <55245b3e-22b0-464e-8ec5-4e3a95b88de1@canonical.com>
 <CAFLszTiwMeT6RS1iOF=mHbWz2brY7NKoB2AJEULcr1EqGCq+MA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiwMeT6RS1iOF=mHbWz2brY7NKoB2AJEULcr1EqGCq+MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 09.02.25 17:24, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sun, 9 Feb 2025 at 09:10, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 09.02.25 17:02, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Sun, 9 Feb 2025 at 08:53, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 09.02.25 15:29, Simon Glass wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On Sun, 9 Feb 2025 at 04:52, Heinrich Schuchardt
>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>
>>>>>> If a single configuration node lacks a description, this does not rule out
>>>>>> that another node with a description matches. Anyway we have the default
>>>>>> configuration as a fallback.
>>>>>>
>>>>>> So continue if a description is missing.
>>>>>>
>>>>>
>>>>> That field is mandatory, so we should really fail if it is missing.
>>>>>
>>>>> What problem are you trying to solve here?
>>>>
>>>> Sure the field is needed to make a configuration selectable.
>>>
>>> It's actually normally informational. Have you looked a
>>
>> If the field is informational, we should not worry if it is missing.
>>
>>> CONFIG_FIT_BEST_MATCH? That is how this is supposed to be done. But
>>> with starfive_visionfive2 I see:
>>>
>>> # CONFIG_FIT_BEST_MATCH is not set
>>
>> How would CONFIG_FIT_BEST_MATCH match strings in the EEPROM to a FIT
>> configuration?
> 
> It uses the compatible strings from the running devicetree. If you
> know that it is wrong, or too generic, you could enhance
> fit_conf_find_compat() to take a compatible string-list instead of an
> FDT blob, then add a SYSID for reading that from your board's sysinfo
> driver.
> 
> How does it work at present?

board_fit_config_name_match() in board/starfive/visionfive2/spl.c checks 
the configuration name against the EEPROM strings. This is invoked via 
fit_conf_get_node(). Several other boards override the same weak function.

Best regards

Heinrich

> 
>>
>>>
>>>>
>>>> But as long as we can find a good configuration we should boot instead
>>>> of leaving the user with a bricked device.
>>>
>>> The more likely impact is that people won't bother adding the field on RISC-V.
>>
>> The current runtime check is inconsistent: You will get an error if the
>> first config lacks a description but may not get an error if the last
>> one lacks it. And you are potentially bricking bootable devices.
>>
>> The right place to check is mkimage. Here you can bail out if a string
>> is missing without bricking devices.
> 
> OK, I can see that the current thing is inconsistent, so I don't mind.
> 
> Regards,
> Simon

