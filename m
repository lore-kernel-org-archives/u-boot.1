Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B591EC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 12:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA8F8764D;
	Tue,  2 Jan 2024 13:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iM91Kr5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156B58701C; Tue,  2 Jan 2024 13:21:20 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D8E876BF
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 13:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d89105365so12150305e9.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 04:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704198075; x=1704802875; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dgIEB0LJBu6UyeA7zttHAJOwgE8dt73+rjFjkysuSzU=;
 b=iM91Kr5rO69t4yZcPHSaJsTZJI3jMESkLMjM2G63Pqnp1JHn3k5DWeEGnsw6dawiE+
 EK7/XDnnuUyujNloa6CSay0UVll1ACkpUQmKoOK2joxABK0ofsgayshlLgbnhdkm/wi5
 DKB3lnqpC4AoroRSebID7tyquhgpU++ICYm8VWHOPP5NFFSRPmkjLY8ybdZWtsfEETME
 EW3crsr0kUyer5o8zLZp8x1GOCAbZEKLxDllpIeBcicdjSnSx/jaPZrOiXHnEW7uS/Gc
 Z9HV8NnDw8HPWClpM663lK2RPaj8f4JL0nJs6L/bwoix7mPPIw5Q5v7Afxu5+aHUxamR
 QOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704198075; x=1704802875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dgIEB0LJBu6UyeA7zttHAJOwgE8dt73+rjFjkysuSzU=;
 b=CWYYQy82SyCh+if937nLAngoSi+qgbBDlWe4YReb4+qRQoD+hOVur1h5peYvjoI5LM
 CulxIgI8z1tDZmGlPtfxJh3n0ST084c0cq4It7L4VD8JfzlZeVij8kz3NfcxX2UvzTKL
 A3tbEUSyAkhaiqIcj7UcbgmKVJQm9FVG3GCaBs/jS0oZYoUNW4SX9uRC5DusKQT7NjEC
 no6aeG5hGGNtP2lfYU9W0X11ccCm+ce3/ZmNz22oHZqctGAXN2VWBa4j92mogZzmq28/
 2gPauqWUrFaDDV7vafQUexsUt1JHq/Me/xB0trdThQTwUXhZ7n4/i1ycRzBqnAxQochm
 OebA==
X-Gm-Message-State: AOJu0Yxay2UDMayi42KjKQweAQp14sUDDwhxktJT+mTgmg26Q3n8+bVE
 ALgXWKm8vQ5bzKEiTLoWkpMbXAJNjY1MaQ==
X-Google-Smtp-Source: AGHT+IElpQvYdrgvA03xL6CKXUJg2fpWSrTMBrIdDcS66hWYBr8RWR4ogZYm1RH/1BWNnXlg1ZqfGA==
X-Received: by 2002:a05:600c:4444:b0:40d:77d4:395b with SMTP id
 v4-20020a05600c444400b0040d77d4395bmr3164471wmn.59.1704198074922; 
 Tue, 02 Jan 2024 04:21:14 -0800 (PST)
Received: from [172.30.140.140] (gateway.braid.business. [82.66.147.134])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a05600c198700b0040d579817b0sm28588571wmq.15.2024.01.02.04.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 04:21:14 -0800 (PST)
Message-ID: <824be245-60c9-4a1a-a386-be765e8eba91@linaro.org>
Date: Tue, 2 Jan 2024 13:21:13 +0100
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
 <5b833208-49b9-4cff-8160-930bf26172b0@linaro.org>
 <CAFA6WYPN+oEXCB3dS4EcBrOy6hKNhPawXhhx3x+FvTZ6Nb-b1g@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYPN+oEXCB3dS4EcBrOy6hKNhPawXhhx3x+FvTZ6Nb-b1g@mail.gmail.com>
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



On 02/01/2024 12:54, Sumit Garg wrote:
> On Tue, 2 Jan 2024 at 14:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>
>> On 26/12/2023 10:30, Sumit Garg wrote:
>>> On Fri, 22 Dec 2023 at 21:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> Hi Sumit,
>>>>
>>>> [...]
>>>>>> -       if (init == USB_INIT_HOST) {
>>>>>> -               /* Start USB Hub */
>>>>>> -               dm_gpio_set_dir_flags(&hub_reset,
>>>>>> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>>>>>> -               mdelay(100);
>>>>>> -               /* Switch usb to host connectors */
>>>>>> -               dm_gpio_set_dir_flags(&usb_sel,
>>>>>> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>>>>>> -               mdelay(100);
>>>>>> -       } else { /* Device */
>>>>>> -               /* Disable hub */
>>>>>> -               dm_gpio_set_dir_flags(&hub_reset, GPIOD_IS_OUT);
>>>>>> -               /* Switch back to device connector */
>>>>>> -               dm_gpio_set_dir_flags(&usb_sel, GPIOD_IS_OUT);
>>>>>> +       /* Select "default" or "device" pinctrl */
>>>>>> +       switch (init) {
>>>>>> +       case USB_INIT_HOST:
>>>>>> +               pinctrl_select_state(usb, "default");
>>>>>> +               break;
>>>>>> +       case USB_INIT_DEVICE:
>>>>>> +               pinctrl_select_state(usb, "device");
>>>>>> +               break;
>>>>>> +       default:
>>>>>> +               debug("Unknown usb_init_type %d\n", init);
>>>>>> +               break;
>>>>>
>>>>> Can this pinctrl configuration move to the corresponding USB driver instead?
>>>>
>>>> Possibly, this is definitely something where DT is currently lacking,
>>>> similar discussions in Linux resulted in the USB onboard_hub driver, it
>>>> would be nice to add support for that U-Boot at some point.
>>>>
>>>> I don't think putting the pinctrl code directly into the USB driver is
>>>> the right way to go, as it definitely wouldn't be accepted in upstream
>>>> DT bindings.
>>>
>>> As discussed in the other thread,
>>> arch/arm/mach-snapdragon/board_apq8016.c would be a better place for
>>> the time being.
>>
>> I would instead prefer this go in mach-snapdragon/board.c and include a
>> conditional to check for a named pinctrl on the USB device, using
>> "uclass_find_device_by_seq()" to fetch the device would then make this
>> properly generic.
> 
> Yes, that can be a further step and I don't expect that to be part of
> this series. But since this patch is moving stuff, we should move SoC
> specific bits to mach-snapdragon/board_apq8016.c rather than its
> opposite to the db410c specific file.

The reason I moved this board code to the board directory is because 
with this series I'm enforcing that all mach-snapdragon code be generic 
and built for all Qualcomm platforms. I also did it because while I 
don't want to break support for db410c, I don't plan to fix it, so this 
works as a temporary solution until someone who does care about the 
board (like you) wants to fix it up.
> 
>>
>> This is really not relevant to this patch series, but is a change that
>> makes sense when introducing support for new boards, let's limit
>> discussion to the other thread [1].
> 
> But why? The USB stuff we are discussing here is relevant to existing
> board support, right?

Right, and the existing board is supported with this series. You're 
suggesting that I spend significantly more time on this series to make 
supporting your board (which is NOT yet upstream) easier.

My cover letter is very explicit that this series lays the groundwork 
such that all future Qualcomm boards can be supported in a fully generic 
way, with no additional board code. I have support for 3 new Qualcomm 
SoCs and ~6 devices based on this series, and none of that requires 
adding new board code because I took the time to come up with proper 
solutions by fixing drivers or DT.

I carved out exceptions for the db410c and db820c because I cannot test 
all the usecases they support, and finding proper solutions to allow for 
dropping their board code is a whole lot of work for boards that - 
unfortunately - I'm not able to prioritize.

The fact that you are working on a board based on db410c is great, it 
means that you can put the effort in to find a proper generic solution, 
and ideally we can drop board/qualcomm/dragonboard410c entirely!

I'm *more than* happy to discuss ideas and figure out the right 
solutions to the remaining board code with you. There are absolutely 
areas where U-Boot is missing flexibility, and I see this as a good 
opportunity for us to fix some of that.

It's clear from other threads that restricting the amount of mach/board 
code in U-Boot is a good way forward, and I would very much like for 
Qualcomm to lead the way here. There is no good reason why we shouldn't 
be able to have a single U-Boot binary for all of our supported boards, 
and it makes testing *so* much easier.

> 
> -Sumit
> 
>>
>> [1]:
>> https://lore.kernel.org/u-boot/f805111d-106e-4904-ae9d-e63596f7db4e@linaro.org/
>>>
>>> -Sumit
>>>
>>>>>
>>>>> -Sumit
>>>>>
>>>> --
>>>> // Caleb (they/them)
>>
>> --
>> // Caleb (they/them)

-- 
// Caleb (they/them)
