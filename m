Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504C0C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 08:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4CE86406;
	Tue,  2 Jan 2024 09:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o/M8FwQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B43E807A7; Tue,  2 Jan 2024 09:33:55 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54CA28760D
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 09:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28c7e30c83fso2550279a91.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 00:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704184427; x=1704789227; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oz5W+AlepuYy6g9NMZxv7wyzZEU6AU5niIhzYK1H07I=;
 b=o/M8FwQbr4z8ps6e2r/HAxEdtSL41HX78Y6WGks7wCxOfJ6XMQvoot0YfRMlu87k96
 b8taCf3nvDco9kBypO+6FZj5/yGGmzNpnz3b2haACwRLlSyTkhg6CZJ0qr5C/PpJJtkS
 7cniptVsMD7SZpps9yinR409/UxD/S1/iHZPlMkW9e/Vj81H//QBSfoFlr7n+kRwBx3L
 w4yds4YAfrTVPU+1khkL5kxPzFHxwuQFVEOhKoPkKG6Ve6bRqymSkRaYiIywV3MQx4Xk
 wijwd2FGw4hpr9OPlxnmrYBuT4OwwnJM2ZFvltds63byvDcdKLx8XHe38l1Ew3Vh+Qye
 nEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704184427; x=1704789227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oz5W+AlepuYy6g9NMZxv7wyzZEU6AU5niIhzYK1H07I=;
 b=Nv6r8JSvknoutF0VmiPGNtOB9oc4SWt0ONoQDznVBkHA1vGRPk50ejN6xQTWPLysnx
 MRYTH5cDfV4sUazhYUmNuckaXjsEkcUD5yPyT57/QjhHusfGYFkx2a3ClqO9v4nNt7Fv
 ts1S05M//FrlgzN4GoGq7ICaSPSoFkCU40Dr/Y7ytIpPcCAU/CEmeLFDQd460Jz+4wAU
 n6q1TF8+0OwCFBKzs3vq3mFHyLwAjkTsQoyrIej8I/aL3kMm6zGqOzFNFugIh0S0+nWH
 klf/ivK6wshvyi/dFsfIV14c1Th61JwN6zzhriqUSfV3oXzbSR+4s6umLlY5tRrQYQLU
 hPsQ==
X-Gm-Message-State: AOJu0Yz2exNznkogMssm/rWOB/jNvkLFABE1E8tmGC9qtwXZO+SIhEys
 6MXc5kF9MpgAQmXkHc4IfD4bUVT3x9HrZg==
X-Google-Smtp-Source: AGHT+IHeD3tMhgrck/k/A7L/1m7Syp7RGvgtuxn8dK6m65RNjD0VJOsvuAR8ycietf+0BlvbnqpzJA==
X-Received: by 2002:a17:90a:8e85:b0:28c:b3a0:548c with SMTP id
 f5-20020a17090a8e8500b0028cb3a0548cmr1177683pjo.82.1704184427481; 
 Tue, 02 Jan 2024 00:33:47 -0800 (PST)
Received: from [172.30.140.140] (gateway.braid.business. [82.66.147.134])
 by smtp.gmail.com with ESMTPSA id
 y31-20020a17090a53a200b0028649b84907sm28368549pjh.16.2024.01.02.00.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 00:33:46 -0800 (PST)
Message-ID: <f805111d-106e-4904-ae9d-e63596f7db4e@linaro.org>
Date: Tue, 2 Jan 2024 09:33:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add SE HMBSC board support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 neil.armstrong@linaro.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
 <CAPnjgZ2rYujD-yb=Zgz=bxe8iS3MGSdrL9KfVsDqz8R_H+FVfA@mail.gmail.com>
 <CAFA6WYOkQ6-jq2LkF=x36mdX+v3CX71zwn7VpUeczF885RBDaA@mail.gmail.com>
 <65d0c4d7-ba69-4cf8-ae8e-89787f2aa009@linaro.org>
 <CAFA6WYMR6tSvxDZ7Gym=YAhVxpP1dFP1Mie+DmBRYJxMi5yXwA@mail.gmail.com>
 <7f92f220-7d65-48f4-b200-f8b5372d4216@linaro.org>
 <CAFA6WYP918rsAp+FQ-Dyb8f_V1jBSN72CGMEfr4o+VYRtTRF1w@mail.gmail.com>
 <81cffa0a-5f91-40ee-bd43-b6ea009a3f1b@linaro.org>
 <CAFA6WYNbheogFQJVGkAKNTb1XfPGRAscrsgqfpRq4NR3JEDZ2A@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYNbheogFQJVGkAKNTb1XfPGRAscrsgqfpRq4NR3JEDZ2A@mail.gmail.com>
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



On 26/12/2023 10:27, Sumit Garg wrote:
> On Fri, 22 Dec 2023 at 23:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> [snip]
>>
>>>>>> Sumit, could you rebase this series on my generic board support? [1] in
>>>>>> it's current form this series conflicts, and includes some of the major
>>>>>> anti-patterns I'm trying to move away from in mach-snapdragon.
>>>>>
>>>>> Although, I haven't gone through your series but I was expecting those
>>>>> conflicts. Let's work together to make this series compatible on top
>>>>> of yours.
>>>>>
>>>>>>
>>>>>> You should not have to introduce a new CONFIG_TARGET_XYZ variable, and
>>>>>> from what I can tell you shouldn't even need to add the board/schneider
>>>>>> directory at all, you can just set the following in your defconfig:
>>>>>>
>>>>>> CONFIG_SYS_BOARD="dragonboard410c"
>>>>>
>>>>> This is simply a misnomer, its HMIBSC board. I suppose we should
>>>>> rather separate the SoC specific bits into mach-snapdragon and let
>>>>> different boards use them.
>>>>
>>>> Is there any reason why you can't just use the existing db410c board
>>>> code as-is? I don't see why you want to duplicate it.
>>>
>>> I don't want to duplicate it but rather we should make the common
>>> parts as part of arch/arm/mach-snapdragon/ and let derivative boards
>>> use them. The HMIBSC board is an industrial board which doesn't need
>>> any generic distro boot but rather FIT booting with OTA updates via
>>> RAUC [1] along with U-boot environment protection. Doesn't that make
>>> it different from db410c?
>>
>> Right, your series does this board specific configuration in the board
>> header file (include/configs/hmibsc.h) and in the defconfig.
>>
>> The actual board code in board/schneider/hmibsc/hmibsc.c is directly
>> copied from board/qualcomm/dragonboard410c/dragonboard410c.c with just
>> the copyright changed, the serial number code removed, and a style fix
>> to a comment. Ignoring for a moment the copyright issue which would
>> definitely need to be fixed,
> 
> Ah, I should have retained the copyright.
> 
>> what I'm suggesting that you do is just use
>> the board code from db410c.
> 
> This is just initial board support, a direct copy would just limit any
> further board support extensions.

Could you elaborate a little? If there are technical reasons to 
duplicate the board code then they should be explained in the commit 
message - and we can avoid this whole back and forth.
> 
>>
>> The way I have designed the generic board support is so that two similar
>> boards can share the same board code but with different config headers,
>> from what I can tell this would work just fine for you.
> 
> As I have mentioned earlier, the proper way to share code among boards
> is to have something like following:
> 
> arch/arm/mach-snapdragon/board_apq8016.c
> 
> You can take examples from arch/arm/mach-meson/board-*.c. If you don't
> want to do it as part of your series then let me know I will include
> it in this series.

I'm open to moving some of the code from board/qualcomm/dragonboard410c/ 
back to mach-snapdragon, I think my requirements for moving some feature 
code back are as follows:

  * Multiple unrelated Qualcomm boards use it
  * There is no clear path forward for upstream DT bindings
  * (and/therefore) Duplicating the function across boards is silly

Then we should definitely move it to mach-snapdragon.

I again want to be clear that this kind of board specific code IS a 
hack, it gets things working where we don't have a proper DT-based 
solution yet.

I know doing things properly is more effort, but I think with just a bit 
of effort we can find much better solutions that let us get rid of this 
board specific code all-together.
> 
>>
>> --- board/qualcomm/dragonboard410c/dragonboard410c.c
>> +++ board/schneider/hmibsc/hmibsc.c
>> @@ -2,5 +2,5 @@
>>   /*
>> - * Board init file for Dragonboard 410C
>> + * Board init file for SE HMIBSC
>>    *
>> - * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>> + * (C) Copyright 2023 Sumit Garg <sumit.garg@linaro.org>
>>    */
>> @@ -8,3 +8,2 @@
>>   #include <button.h>
>> -#include <common.h>
>>   #include <cpu_func.h>
>> @@ -137,7 +136,2 @@
>>   {
>> -       char serial[16];
>> -
>> -       memset(serial, 0, 16);
>> -       snprintf(serial, 13, "%x", msm_board_serial());
>> -       env_set("serial#", serial);
>>          return 0;
>> @@ -145,3 +139,4 @@
>>
>> -/* Fixup of DTB for Linux Kernel
>> +/*
>> + * Fixup of DTB for Linux Kernel
>>    * 1. Fixup installed DRAM.
>> @@ -165,3 +160,2 @@
>>
>> -
>>          if (!eth_env_get_enetaddr("btaddr", mac)) {
>> @@ -169,5 +163,6 @@
>>
>> -/* The BD address is same as WLAN MAC address but with
>> - * least significant bit flipped.
>> - */
>> +               /*
>> +                * The BD address is same as WLAN MAC address but with
>> +                * least significant bit flipped.
>> +                */
>>                  mac[0] ^= 0x01;
>>
>>>
>>> [1] https://rauc.io/
>>>
>>>>
>>>> The only reason the db410c and db820c have their board code is because
>>>> they're old platforms and already supported. For adding new support
>>>> there needs to be some very strong justification to have board-specific
>>>> C code.
>>>>
>>>> I think it would be nice to make the db410c code go away, or be toggled
>>>> at runtime, probably most of it will just work and not break any other
>>>> boards anyway. The db820c code is just part of what should be in the
>>>> pinctrl driver...
>>>>
>>>> Let's move away from this old model and towards having more generic
>>>> U-Boot images. This will snowball towards making future bringup even easier.
>>>
>>> As I have mentioned in the other thread, we should give alternatives
>>> to the board code as well. How would you handle the following?
>>>
>>> - Fastboot mode entry on a button press.
>>
>> This can be nicely handled through CONFIG_AUTOBOOT. I currently use
>> AUTOBOOT_STOP_STR but that's quite limited (only works for the power
>> button with "\r"). Probably the right solution here is to use
>> CONFIG_AUTOBOOT_USE_MENUKEY and introduce support for
>> CONFIG_AUTOBOOT_MENUBUTTON to allow specifying a named button instead of
>> an ASCII code. One would then configure "menucmd" in the U-Boot
>> environment to launch fastboot.
> 
> Won't this break existing users who relied on volume buttons to flash
> their board and rather have to purchase a debug uart?

I don't think so(???). This would highly depend on the device and 
configuration. As a developer you should have ways to recover from a 
borked U-Boot build, and you should make sure that any binary releases 
you make don't result in bricked boards.
> 
>>
>> This lets us drop all the weird non-standard keycode handling in board
>> code and just configure it in the defconfig instead. I plan to implement
>> this eventually but would for sure appreciate it if someone beat me to it.
>>> - Configure MAC address for network support.
>>
>> I believe you mentioned elsewhere some board with the MAC address on an
>> i2c EEPROM? The NVMEM framework solves exactly this issue, and U-Boot
>> already supports it, just add support to your ethernet driver to
>> retrieve its MAC address via NVMEM.
> 
> Good to know that.
> 
>>> - Setup board serial number.
>>
>> Same as above, the quick and dirty way to go would be to have
>> mach-snapdragon check for an alias defined in DT and expect that alias
>> to be an NVMEM cell which contains the serial number. On the Android
>> phones this is set in the kernel cmdline from ABL so I would probably
>> add some code to mach-snapdragon to check the bootargs for one.
> 
> And what about boards where U-Boot starts as the first stage
> boot-loader? Is there corresponding DT binding?

I really don't know. Having some code to read the MMC serial number and 
use it as the fallback board serial sounds reasonable to me.
> 
>>
>>>
>>> I suppose we don't need #ifdefry in the
>>> arch/arm/mach-snapdragon/board.c file, right?
>>
>> Nope, we aren't that limited on code size, and the runtime overhead of a
>> few extra branches is really not significant. If we do need to start
>> caring about either of those things then I would rather do this on a
>> per-feature basis than per-board.
> 
> The examples I gave were only limited to what are currently used by
> Qcom boards. But we should be open to future board support extensions
> too.

Absolutely!
> 
>>>
>>>>>
>>>>>> CONFIG_SYS_CONFIG_NAME="hmibsc"
>>>>>>
>>>>>> This will use the db410c board code (which yours is just a copy/paste of
>>>>>> from what I can tell) and your custom include/configs/hmibsc.h header.
>>>>>>
>>>>>> The addresses set in your environment file should be allocated
>>>>>> automatically at runtime too (see the ("mach-snapdragon: dynamic load
>>>>>> addresses") patch).
>>>>>>
>>>>>> You should also switch to an upstream board DTS based on my series, and
>>>>>> drop the "-uboot.dtsi" file.
>>>>>
>>>>> Unfortunately, currently there isn't any upstream DTS for this board
>>>>> but I will check with the SE team regarding their plans. Until then we
>>>>> have to use a U-Boot specific DTS file.
>>>>
>>>> In that case, perhaps we can take whatever DTS they're using in
>>>> production, or a version of it, and at least split the U-Boot changes
>>>> (if any) out into a separate file as I've done with the other platforms.
>>>> This way we stay consistent and can keep track of what U-Boot specific
>>>> DTS changes we need.
>>>
>>> The first step for that is to land that DTS file upstream in the Linux
>>> kernel and then we should make a switch. The middle ground here won't
>>> be maintainable.
>>>
>>>>
>>>> I guess this is all new territory for us, but imho if we're adding
>>>> support for a board that doesn't have an upstream DTS, we should still
>>>> follow the same model, open to input here.
>>>
>>> With the DT rebasing tree, we actually want to make these bits clear.
>>> Either the board support is fully upstream and then we make a switch
>>> to upstream or you can have a u-boot specific DTS subset compliant
>>> with upstream bindings while upstreaming is in progress. There is
>>> always ABI risk involved for using half baked board DTS files.
>>
>> The DTS file submitted in your series is a copy paste of
>> dragonboard410c.dts with the serial port adjusted, the LEDs removed, and
>> the copyright changed...
>>
>> This will make it the only board still using the totally made up DTS
>> style that all the Qualcomm boards used to use, while everything else is
>> standardised on upstream (meaning they #include the SoC and PMIC dtsi
>> files).
>>
>> It doesn't make a difference whether you put the board DT in dt-rebasing
>> or if it just goes in U-Boot, it should be a DT derived from upstream
>> not some hand-crafted thing which will never be supported. Just copy
>> apq8016-sbc.dts when rebasing on my series and it will be fine.
> 
> The major bit that I was concerned about previously is if people start
> to pass that u-boot specific DT to the kernel directly. But with
> dt-rebasing at least we can distinguish among them. So I am fine to
> use the format that you have described.

Ok, great!
> 
>>
>> That said, as I'm writing this I've realised that the pinctrl-apq8016
>> driver is missing a patch to use the upstream GPIO naming. I'll fix this
>> in the next revision of the qualcomm generic support series, but just a
>> heads up if you run into that.
> 
> Good to know.
> 
> -Sumit

-- 
// Caleb (they/them)
