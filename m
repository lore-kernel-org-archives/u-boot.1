Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6180AC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE3A87E93;
	Wed, 20 Mar 2024 14:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="De0Ih/py";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D2387F8F; Wed, 20 Mar 2024 14:18:40 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E43987E47
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33ed7ba1a42so2644642f8f.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710940717; x=1711545517; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+7TrFenuV7jJVGnPNR9JtTBKPzon1DuXaq8dhr8Joq4=;
 b=De0Ih/pyvA8OWNBH5tcTWWbB7NVRcomYz7LiFdjuEwzKTNFddfu2zY9EIHZE1kjEL3
 Wr+FgE5FbHCVFmy2i1985ERUuSX1yh0TVzfsvUl8pVCDn/7DxKCMA4pxykew7xIxRHlp
 FFocRbhBF8bZifmUAwAhHpZYLOdXxlAS7c0w0fZLR0M+9wODiXI5rbW6KIfGNrjhIafT
 GEkywkpvVZ5OO3QRLMaUK3FKRxGVqoh2NkYB9qotN6fMyahXRS/XsFlB9vkES6t/CYt2
 VVdvvxSGAhHlR5MScxrDc5ufpgwJ2V/s+DUC7E/RQ7t66WzGT48vXjNLFU9ZPNol/mEk
 dPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710940717; x=1711545517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+7TrFenuV7jJVGnPNR9JtTBKPzon1DuXaq8dhr8Joq4=;
 b=vFHCR4arPUdoXDDkd013mAzaG4979Kxxvjw+J7Sx6GGX0GS2H89zAEWWpHFeFWIFJ7
 Aeftjo7lJbdurpYcCJ3y3ZH9BOKCUlAez6PA5CJ7Inbd0pltiSrqJLLXvCQzOJ4Pq5VV
 tznuMNwtoWncDv1FwFScDrsKyn5hTg2dCLRCu+XYIKqNYoO9ih2ImgunaCMaVCpUB5Sh
 a8FkRS8ETgzaxA47zETX55zchwpdJJiZPxLABvBvC6aeXPpQHm14J5U1wzqxToZXAzPA
 I3eiD4RDVqHWyH3ZH1/XEXqWs1DtrIVNRr0TGDb0trFBL7MEphpsGdydliAzeGjVxss2
 daRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBQEj0r1Uy8geqUfTYhrgWwHqfHmFyfgtP9Coa6tv+yjjD7CedYAImwsXSSmEMNA4jo9AUvZw+9eSz6ydQf2kx80bwJA==
X-Gm-Message-State: AOJu0YyNRgNJ0IOQ69pkgpixSovypBdbU8Q24TEapHZuVg7OJYYzkv0k
 i2MolbwBVCGalO8AKhxlWUtAOzzPMo5YQrVui0QZbqkTM8NAwGewjOnvdMf6aaU=
X-Google-Smtp-Source: AGHT+IFGGDtFckSMkTJJmMhu3eWstOYnBp2xjQ2K4VxIhS+Q5XtMbQsrgfoswy6sqnsIob3DBC3Uyw==
X-Received: by 2002:a05:6000:711:b0:341:6b6d:ec34 with SMTP id
 bs17-20020a056000071100b003416b6dec34mr5549858wrb.46.1710940717491; 
 Wed, 20 Mar 2024 06:18:37 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a5d6309000000b0033e0dd83be1sm14487016wru.91.2024.03.20.06.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 06:18:36 -0700 (PDT)
Message-ID: <c18deb5b-d4a2-4270-927c-627a980016ba@linaro.org>
Date: Wed, 20 Mar 2024 13:18:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] board: add support for Qualcomm SA8155P-ADP board
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-9-volodymyr_babchuk@epam.com>
 <CAFA6WYNWxHU4W0xrTC=mQJbP49hFMm56fbz1isd0xNNQ_VdVSw@mail.gmail.com>
 <87jzmf2mvi.fsf@epam.com> <e5e47988-c617-48a0-a10a-e37edb9a8267@linaro.org>
 <87y1av12bg.fsf@epam.com> <0cda2608-856f-4650-92a6-4860a0d7c8b6@linaro.org>
 <87edcg1vcp.fsf@epam.com> <b8774081-dd8f-4154-9c39-0c0b5fd48adb@linaro.org>
 <874jdc1qbg.fsf@epam.com> <87jzlxzzrb.fsf@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87jzlxzzrb.fsf@epam.com>
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



On 19/03/2024 21:18, Volodymyr Babchuk wrote:
> 
> Hi,
> 
> Volodymyr Babchuk <volodymyr_babchuk@epam.com> writes:
> 
>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>
>>> On 11/03/2024 18:23, Volodymyr Babchuk wrote:
>>>> Hi Caleb,
>>>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>>>
>>>>> On 06/03/2024 21:24, Volodymyr Babchuk wrote:
>>>>>>
>>>>>> Hi Caleb,
>>>>>>
>>>>>> Caleb Connolly <caleb.connolly@linaro.org> writes:
>>>>>>
>>>>>> [...]
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +&tlmm {
>>>>>>>>>> +       /* U-Boot pinctrl driver does not understand multiple tiles */
>>>>>>>>>> +       reg = <0x0 0x03000000 0x0 0x1000000>;
>>>>>>>>>> +       /delete-property/ reg-names;
>>>>>>>>>
>>>>>>>>> This won't be needed if we can make the tiles offset in the pinctrl
>>>>>>>>> driver compatible:
>>>>>>>>>
>>>>>>>>> #define WEST   0x00000000
>>>>>>>>> #define EAST   0x00400000
>>>>>>>>> #define NORTH  0x00800000
>>>>>>>>> #define SOUTH  0x00C00000
>>>>>>>>
>>>>>>>> Hmm, I assume that in this case pinctrl driver should map all the four
>>>>>>>> tiles independently? Are there guarantees in U-Boot that four separate
>>>>>>>> memory regions will be mapped into virtual memory with the same relative
>>>>>>>> positions? Linux clearly don't make such guarantees.
>>>>>>>
>>>>>>> U-Boot doesn't use virtual addresses on arm platforms, it only goes as
>>>>>>> far as reading the address from DT, nothing else, so this is totally
>>>>>>> fine and is how the other SoCs do it.
>>>>>>
>>>>>> For me it looks like we are depending on implementation details
>>>>>> knowledge. I.e MMU API does not provide such guarantees, but drivers
>>>>>> know how ARM MMU code is working internally and drivers depend on
>>>>>> exactly this behavior. But if you are saying that it is totally fine,
>>>>>> I'll rework the patch. No big deal. Actually, I already tried this and
>>>>>> it is working fine.
>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +       /* U-Boot ethernet driver wants to drive reset as GPIO */
>>>>>>>>>> +       /delete-node/ phy-reset-pins;
>>>>>>>>>
>>>>>>>>> I suppose this is not needed as phy-reset-pins also configures the pin
>>>>>>>>> as GPIO only.
>>>>>>>>>
>>>>>>>> Well, yes. This also puzzles me up, but for some reason it stops working
>>>>>>>> if I leave this node intact. Looks like I need to look at this deeper
>>>>>>>> before posting the next version.
>>>>>>>
>>>>>>> Possibly the pinconf defined in the phy-reset-pins node causes U-Boot to
>>>>>>> misbehave, can you check if this patch fixes it (there is a bug in the
>>>>>>> line "return msm_gpio_direction_input(dev, gpio);", it should become
>>>>>>> just "msm_gpio_direction_input(dev, gpio);").
>>>>>>>
>>>>>>> I had the exact same issue with the gpio-regulator driver and this was
>>>>>>> the solution I ended up going with.
>>>>>>>
>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/u-boot/20240131-b4-qcom-livetree-v1-7-4071c0787db0@linaro.org/__;!!GF_29dbcQIUBPA!xFhZe7DKgRbr63sirEJLuH-B0AnGs7jvx8tdJPKLTgFuZ3I3_zpVml7l23G-_vJO_JiUR-wUO4GMPJFcE-8p50H3pf7nbxit$
>>>>>>> [lore[.]kernel[.]org]
>>>>>>
>>>>>> It is exactly this. With your patch I don't need to /delete-node/
>>>>>> anymore. I'll add a comment in the cover message that this series are
>>>>>> depended on your patch.
>>>>>
>>>>> Please can you split the power domain and clock patches into a separate
>>>>> series? As I'd like to depend on them for the next revision of my
>>>>> series, and we'd otherwise have a cyclical dependency.
>>>> Of course.
>>>> As I understood, you are interested in "clk: qcom: clear div mask
>>>> before
>>>> assigning a new divider" and "clk: qcom: add support for power domains
>>>> uclass", correct?
>>>
>>> Yes.
>>
>> Okay, I'll send it today.
>>
>>> I tried the power domain stuff out on SMD845 today and ran into
>>> quite a few issues. Specifically as a lot of the devices reference the
>>> rpmhpd power domain which we don't support (and don't *need* to
>>> support) in U-Boot. I'm not sure what the best way forward will be for
>>> this. Maybe a "nop" power domain driver?
>>
>> Are you sure that they are not required?
>>
>> "nop" power domain always is the option. Especially if it prints some
>> warning about an unknown device. I had quite a lot of issues with clock and
>> pin drivers that silently ignore unknown devices...
>>
>>> Do you have the same issues on sm8150?
>>
>> Yes and no. No, because I was lucky so far and devices I tried to use in
>> U-Boot does not require rpmhpd. Looking at DTS, I may only encounter
>> issues with sdhc_2, which requires rpmhpd for some reason. Also UFS
>> requires clock from rpmhcc.
>>
>> And "yes", because I have found root cause for my troubles with UFS in
>> Linux kernel, when I am skipping hyp.mbn. This is not strictly related
>> to U-Boot, but you may be interested in this: apparently Qualcomm's
>> hypervisor enables access to RPM (maybe brings it out of reset?). cmd-db
>> shared memory region can't be accessed if I skip the hypervisor and try
>> to boot directly into Linux. So now I am looking for ways to enable it.
> 
> I want to share the solution, in case if someone got the same
> problem. It all boiled down to correct memory attributes. Qualcomm's
> hypervisor mapped cmd-db shared memory as non-cached in Stage 2
> translation table, while Linux maps it as cacheable in Stage 1. Thus,
> the final memory attribute was "non-cacheable".
> 
> Xen, on other hand, used default mapping which is normal cacheable
> memory. And of course this lead to cacheable accesses to cmd-db. For
> some reason this caused the hardware error, which manifested as a secure
> interrupt (while I expected SError at most), which in turn led to
> endless loop somewhere in TZ.

ohh, nice find! I guess if Linux started sending bogus data to the rpmh
this could definitely lead to some XPU violation or another excuse for a
secure interrupt...
> 
> I am going to fix this by applying the correct mappings in the Linux
> cmd-db driver. Plan B is to have workaround in Xen, but I really want to
> avoid this.

I agree this is definitely a Linux bug, it should make sense to fix it
there.
> 
> Right now I have a working Xen that is able to boot Dom0 straight to
> console, if anyone interested.

Awesome! Yeah I'd love to take a look :D
> 

-- 
// Caleb (they/them)
