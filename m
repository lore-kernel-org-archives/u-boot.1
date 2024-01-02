Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30219C47073
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 09:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F12E869F6;
	Tue,  2 Jan 2024 10:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dOOOE1dU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4DD38657F; Tue,  2 Jan 2024 10:13:41 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09E5C86FF7
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 10:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d2e6e14865so41892015ad.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 01:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704186815; x=1704791615; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FkDneMYHFuP0YyyXCWYw7ljNe5nwzrgeqrAYOBVvPbs=;
 b=dOOOE1dUmDYsM+nhCyAZ2sw2LngpqoAb5aJV4K0aB1gzZoGOXkujAVxXxZzzs3VL1F
 7sA17fOyK/rZStIy8m2d19rkznwaAh4+XEHgVN1vtq5fKz8MScR1PKQQ5Mby+HzM7+s8
 626zDjzGPpDzP8hpjBeUjafqBZePUXBv/b6k207LV1f8o3nm/erWj+GDVkpJTF3yIAoK
 MSMju+TXchgZd939/je5whaWzgC6jS/OIzsm71+bNDPGpRdHHswm1caK0a4zzAfnUR3i
 1EDhLQ0D7zJfsPnag5j80T3oembVfn8Cee25+p5y1B3acjTm10V/LlBrQT0gXoxcWlTM
 ziOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704186815; x=1704791615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FkDneMYHFuP0YyyXCWYw7ljNe5nwzrgeqrAYOBVvPbs=;
 b=g7QmfPu+lqGjPfg2Jet7ykS8cbt1kNVubV6Nr/aYVgkBXDeWC0jqJ3pPlekcnwqSOP
 5Nvj1vTmerSTkqMoyz2cXsfI7b642Nvhfr5yTaZ6V8vCGmUcEjcQXq2UOT0evXGegXmY
 Rl01Mr7C/qSSocU6Z/oadeoRP2GwFgZYmS5wTCF+xAuXaps4pbVmgbQDC+6DwHJQa3Cg
 /fjcXvwLNCemedsROfBPpwzyz0PbqOe+SzJnPKxAKWNO5Ay31lDX5DNEnx9V2qRXJR6d
 tA+ETqpV3yUuczn7PhLMJ5Ad1Ek1/R2KPiyrqFNS1RHanH+wjlQadrPzQh02WrMsgQ2z
 bSVQ==
X-Gm-Message-State: AOJu0Ywn2DBl0MaN9T2f1k54s0Yup6jTQxIAJ/9vFzi7V+5piZ9kBvWT
 PuC0iRBQkOJDJj4HDBGANWkwor1vnziTYw==
X-Google-Smtp-Source: AGHT+IEVopoU/REq3GmZsxNbGWbGnJg1szfr5Y3vrF7tv6wX26QJcLRo3yv0Ld1XiohrkDNcDqmvbg==
X-Received: by 2002:a17:902:8d86:b0:1d4:6a34:b444 with SMTP id
 v6-20020a1709028d8600b001d46a34b444mr4114253plo.124.1704186815338; 
 Tue, 02 Jan 2024 01:13:35 -0800 (PST)
Received: from [172.30.140.140] (gateway.braid.business. [82.66.147.134])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a170902860200b001d33c85ce1bsm21505647plo.2.2024.01.02.01.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 01:13:34 -0800 (PST)
Message-ID: <5b833208-49b9-4cff-8160-930bf26172b0@linaro.org>
Date: Tue, 2 Jan 2024 10:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/32] board: dragonboard410c: upstream DT compat
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-12-b6dd9704219e@linaro.org>
 <CAFA6WYMvb230qm95QLPW4iNOXPk0fhxDCP-OFN1FWLCsx9P2yA@mail.gmail.com>
 <e45ca070-82fc-4e5b-a7e9-eb44e956b98f@linaro.org>
 <CAFA6WYNn0PDxikfVNnACiT2HZ=zge=O7XnpynPVfe61rKiedDA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYNn0PDxikfVNnACiT2HZ=zge=O7XnpynPVfe61rKiedDA@mail.gmail.com>
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



On 26/12/2023 10:30, Sumit Garg wrote:
> On Fri, 22 Dec 2023 at 21:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Sumit,
>>
>> [...]
>>>> -       if (init == USB_INIT_HOST) {
>>>> -               /* Start USB Hub */
>>>> -               dm_gpio_set_dir_flags(&hub_reset,
>>>> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>>>> -               mdelay(100);
>>>> -               /* Switch usb to host connectors */
>>>> -               dm_gpio_set_dir_flags(&usb_sel,
>>>> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>>>> -               mdelay(100);
>>>> -       } else { /* Device */
>>>> -               /* Disable hub */
>>>> -               dm_gpio_set_dir_flags(&hub_reset, GPIOD_IS_OUT);
>>>> -               /* Switch back to device connector */
>>>> -               dm_gpio_set_dir_flags(&usb_sel, GPIOD_IS_OUT);
>>>> +       /* Select "default" or "device" pinctrl */
>>>> +       switch (init) {
>>>> +       case USB_INIT_HOST:
>>>> +               pinctrl_select_state(usb, "default");
>>>> +               break;
>>>> +       case USB_INIT_DEVICE:
>>>> +               pinctrl_select_state(usb, "device");
>>>> +               break;
>>>> +       default:
>>>> +               debug("Unknown usb_init_type %d\n", init);
>>>> +               break;
>>>
>>> Can this pinctrl configuration move to the corresponding USB driver instead?
>>
>> Possibly, this is definitely something where DT is currently lacking,
>> similar discussions in Linux resulted in the USB onboard_hub driver, it
>> would be nice to add support for that U-Boot at some point.
>>
>> I don't think putting the pinctrl code directly into the USB driver is
>> the right way to go, as it definitely wouldn't be accepted in upstream
>> DT bindings.
> 
> As discussed in the other thread,
> arch/arm/mach-snapdragon/board_apq8016.c would be a better place for
> the time being.

I would instead prefer this go in mach-snapdragon/board.c and include a 
conditional to check for a named pinctrl on the USB device, using 
"uclass_find_device_by_seq()" to fetch the device would then make this 
properly generic.

This is really not relevant to this patch series, but is a change that 
makes sense when introducing support for new boards, let's limit 
discussion to the other thread [1].

[1]: 
https://lore.kernel.org/u-boot/f805111d-106e-4904-ae9d-e63596f7db4e@linaro.org/
> 
> -Sumit
> 
>>>
>>> -Sumit
>>>
>> --
>> // Caleb (they/them)

-- 
// Caleb (they/them)
