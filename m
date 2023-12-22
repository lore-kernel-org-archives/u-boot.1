Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB82FC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 17:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB4D5870FF;
	Fri, 22 Dec 2023 18:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CMVvue81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163A986FF7; Fri, 22 Dec 2023 18:34:51 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB59B871AA
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 18:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3368ae75082so1041837f8f.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 09:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703266485; x=1703871285; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v5QJbkuM7Tl9N179JXKjyDK/+sZ7trnvqdpJdLqs2nY=;
 b=CMVvue811rQjtyzwaJhQmsSZlmch2vhtwAR2qJwr+eKBYgFzluvdwPhE7DOJBgoJA7
 yVQJkOZqpvZKv+bd4/sB+wtwBRB5eO/dViq6ZUb7ipi/iKw+qtLMTHaVU4V7ZBWvNPUB
 JJsq0It/hEI4xxaCglt1kOxXu7qivGFURBaaBmUg+wzymQhLTYZiAxGOtIUiJg/OWSjo
 AW5CwcjSk7XYrqPQX5KAWDz4+/fmcTEljvkyse4ZsmF1Jwqe/Q0cVbDbPMODdphWljaZ
 DqAyNBjDo7T+ewE5SD60ksP0hSBjD3N1sgVzP+Q4T23D2zlaxUq85h2V+QPDi0JiTsV/
 Oyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703266485; x=1703871285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v5QJbkuM7Tl9N179JXKjyDK/+sZ7trnvqdpJdLqs2nY=;
 b=RlSssVEC7EP2dz/XkqzIfvqXctww75MWmEDwLFJKAjfCNGwQzUFBQtkzPjMW+Es7cP
 S77nxNnXF7dbxgLPHr5EtVlqZ1lnWUZFKebf98hEJUatvCscuKVhioue+lCds/wF9kWF
 1DDyfEkw5P4U4KsFrSh3DWd2OD1v2SFy0yhbTlGcLpijqH7GKXx07bQDiGNBbmEtuVUS
 gFMHjMXTd0UloNjfsNRbT4RTBekslzRs+06cTN6Or3sqs9d5Bg3k+c+DbfLgiwiRjm5X
 5bhz6iIsTwDygecjGp+xlQ7WxupeyS/eoPUK0IqGr53RLRCYlDgyP5jw6JQ2PYcWo4MV
 gGKA==
X-Gm-Message-State: AOJu0YzMq6cQpU6i2EDHAxsq09EhkU26wEkIMKLTw9eYTXkCAb9YeCnS
 0f80KE9unvkAbjS21je+igfG0GMV9elF/g==
X-Google-Smtp-Source: AGHT+IGS0msBnz9kwDfomo3PaHl+24ACK2gIbKTmHKgp88wH0HB/bZjRnDeucAH7vuq9xTIayPWJ4w==
X-Received: by 2002:a05:600c:1c24:b0:40d:388b:441b with SMTP id
 j36-20020a05600c1c2400b0040d388b441bmr959600wms.105.1703266484992; 
 Fri, 22 Dec 2023 09:34:44 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 bd7-20020a05600c1f0700b0040c420eda48sm16020705wmb.22.2023.12.22.09.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Dec 2023 09:34:44 -0800 (PST)
Message-ID: <81cffa0a-5f91-40ee-bd43-b6ea009a3f1b@linaro.org>
Date: Fri, 22 Dec 2023 17:34:43 +0000
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
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYP918rsAp+FQ-Dyb8f_V1jBSN72CGMEfr4o+VYRtTRF1w@mail.gmail.com>
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

[snip]

>>>> Sumit, could you rebase this series on my generic board support? [1] in
>>>> it's current form this series conflicts, and includes some of the major
>>>> anti-patterns I'm trying to move away from in mach-snapdragon.
>>>
>>> Although, I haven't gone through your series but I was expecting those
>>> conflicts. Let's work together to make this series compatible on top
>>> of yours.
>>>
>>>>
>>>> You should not have to introduce a new CONFIG_TARGET_XYZ variable, and
>>>> from what I can tell you shouldn't even need to add the board/schneider
>>>> directory at all, you can just set the following in your defconfig:
>>>>
>>>> CONFIG_SYS_BOARD="dragonboard410c"
>>>
>>> This is simply a misnomer, its HMIBSC board. I suppose we should
>>> rather separate the SoC specific bits into mach-snapdragon and let
>>> different boards use them.
>>
>> Is there any reason why you can't just use the existing db410c board
>> code as-is? I don't see why you want to duplicate it.
> 
> I don't want to duplicate it but rather we should make the common
> parts as part of arch/arm/mach-snapdragon/ and let derivative boards
> use them. The HMIBSC board is an industrial board which doesn't need
> any generic distro boot but rather FIT booting with OTA updates via
> RAUC [1] along with U-boot environment protection. Doesn't that make
> it different from db410c?

Right, your series does this board specific configuration in the board
header file (include/configs/hmibsc.h) and in the defconfig.

The actual board code in board/schneider/hmibsc/hmibsc.c is directly
copied from board/qualcomm/dragonboard410c/dragonboard410c.c with just
the copyright changed, the serial number code removed, and a style fix
to a comment. Ignoring for a moment the copyright issue which would
definitely need to be fixed, what I'm suggesting that you do is just use
the board code from db410c.

The way I have designed the generic board support is so that two similar
boards can share the same board code but with different config headers,
from what I can tell this would work just fine for you.

--- board/qualcomm/dragonboard410c/dragonboard410c.c
+++ board/schneider/hmibsc/hmibsc.c
@@ -2,5 +2,5 @@
 /*
- * Board init file for Dragonboard 410C
+ * Board init file for SE HMIBSC
  *
- * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ * (C) Copyright 2023 Sumit Garg <sumit.garg@linaro.org>
  */
@@ -8,3 +8,2 @@
 #include <button.h>
-#include <common.h>
 #include <cpu_func.h>
@@ -137,7 +136,2 @@
 {
-       char serial[16];
-
-       memset(serial, 0, 16);
-       snprintf(serial, 13, "%x", msm_board_serial());
-       env_set("serial#", serial);
        return 0;
@@ -145,3 +139,4 @@

-/* Fixup of DTB for Linux Kernel
+/*
+ * Fixup of DTB for Linux Kernel
  * 1. Fixup installed DRAM.
@@ -165,3 +160,2 @@

-
        if (!eth_env_get_enetaddr("btaddr", mac)) {
@@ -169,5 +163,6 @@

-/* The BD address is same as WLAN MAC address but with
- * least significant bit flipped.
- */
+               /*
+                * The BD address is same as WLAN MAC address but with
+                * least significant bit flipped.
+                */
                mac[0] ^= 0x01;

> 
> [1] https://rauc.io/
> 
>>
>> The only reason the db410c and db820c have their board code is because
>> they're old platforms and already supported. For adding new support
>> there needs to be some very strong justification to have board-specific
>> C code.
>>
>> I think it would be nice to make the db410c code go away, or be toggled
>> at runtime, probably most of it will just work and not break any other
>> boards anyway. The db820c code is just part of what should be in the
>> pinctrl driver...
>>
>> Let's move away from this old model and towards having more generic
>> U-Boot images. This will snowball towards making future bringup even easier.
> 
> As I have mentioned in the other thread, we should give alternatives
> to the board code as well. How would you handle the following?
> 
> - Fastboot mode entry on a button press.

This can be nicely handled through CONFIG_AUTOBOOT. I currently use
AUTOBOOT_STOP_STR but that's quite limited (only works for the power
button with "\r"). Probably the right solution here is to use
CONFIG_AUTOBOOT_USE_MENUKEY and introduce support for
CONFIG_AUTOBOOT_MENUBUTTON to allow specifying a named button instead of
an ASCII code. One would then configure "menucmd" in the U-Boot
environment to launch fastboot.

This lets us drop all the weird non-standard keycode handling in board
code and just configure it in the defconfig instead. I plan to implement
this eventually but would for sure appreciate it if someone beat me to it.
> - Configure MAC address for network support.

I believe you mentioned elsewhere some board with the MAC address on an
i2c EEPROM? The NVMEM framework solves exactly this issue, and U-Boot
already supports it, just add support to your ethernet driver to
retrieve its MAC address via NVMEM.
> - Setup board serial number.

Same as above, the quick and dirty way to go would be to have
mach-snapdragon check for an alias defined in DT and expect that alias
to be an NVMEM cell which contains the serial number. On the Android
phones this is set in the kernel cmdline from ABL so I would probably
add some code to mach-snapdragon to check the bootargs for one.

> 
> I suppose we don't need #ifdefry in the
> arch/arm/mach-snapdragon/board.c file, right?

Nope, we aren't that limited on code size, and the runtime overhead of a
few extra branches is really not significant. If we do need to start
caring about either of those things then I would rather do this on a
per-feature basis than per-board.
> 
>>>
>>>> CONFIG_SYS_CONFIG_NAME="hmibsc"
>>>>
>>>> This will use the db410c board code (which yours is just a copy/paste of
>>>> from what I can tell) and your custom include/configs/hmibsc.h header.
>>>>
>>>> The addresses set in your environment file should be allocated
>>>> automatically at runtime too (see the ("mach-snapdragon: dynamic load
>>>> addresses") patch).
>>>>
>>>> You should also switch to an upstream board DTS based on my series, and
>>>> drop the "-uboot.dtsi" file.
>>>
>>> Unfortunately, currently there isn't any upstream DTS for this board
>>> but I will check with the SE team regarding their plans. Until then we
>>> have to use a U-Boot specific DTS file.
>>
>> In that case, perhaps we can take whatever DTS they're using in
>> production, or a version of it, and at least split the U-Boot changes
>> (if any) out into a separate file as I've done with the other platforms.
>> This way we stay consistent and can keep track of what U-Boot specific
>> DTS changes we need.
> 
> The first step for that is to land that DTS file upstream in the Linux
> kernel and then we should make a switch. The middle ground here won't
> be maintainable.
> 
>>
>> I guess this is all new territory for us, but imho if we're adding
>> support for a board that doesn't have an upstream DTS, we should still
>> follow the same model, open to input here.
> 
> With the DT rebasing tree, we actually want to make these bits clear.
> Either the board support is fully upstream and then we make a switch
> to upstream or you can have a u-boot specific DTS subset compliant
> with upstream bindings while upstreaming is in progress. There is
> always ABI risk involved for using half baked board DTS files.

The DTS file submitted in your series is a copy paste of
dragonboard410c.dts with the serial port adjusted, the LEDs removed, and
the copyright changed...

This will make it the only board still using the totally made up DTS
style that all the Qualcomm boards used to use, while everything else is
standardised on upstream (meaning they #include the SoC and PMIC dtsi
files).

It doesn't make a difference whether you put the board DT in dt-rebasing
or if it just goes in U-Boot, it should be a DT derived from upstream
not some hand-crafted thing which will never be supported. Just copy
apq8016-sbc.dts when rebasing on my series and it will be fine.

That said, as I'm writing this I've realised that the pinctrl-apq8016
driver is missing a patch to use the upstream GPIO naming. I'll fix this
in the next revision of the qualcomm generic support series, but just a
heads up if you run into that.
> 
> -Sumit
> 
>>>
>>> -Sumit
>>>
>>>>
>>>> [1]:
>>>> https://lore.kernel.org/u-boot/20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org/
>>>>
>>>> Kind regards,
>>>>
>>>>>
>>>>> -Sumit
>>>>>
>>>>>>
>>>>>>> difference from db410c is serial port where HMIBSC board uses UART1 as
>>>>>>> the debug console with an RS232 port, patch #1 - #3 adds corresponding
>>>>>>> driver support.
>>>>>>>
>>>>>>> Patch #4 adds main HMIBSC board specific bits, features:
>>>>>>> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
>>>>>>> - 2GiB RAM
>>>>>>> - 64GiB eMMC, SD slot
>>>>>>> - WiFi and Bluetooth
>>>>>>> - 2x Host, 1x Device USB port
>>>>>>> - HDMI
>>>>>>> - Discrete TPM2 chip over SPI
>>>>>>>
>>>>>>> Patch #5 - #7 enables specific board features like RAUC support,
>>>>>>> environment protection and USB networking support.
>>>>>>>
>>>>>>> This patch series is based on top of Qcom maintainer tree [1] + the latest
>>>>>>> PMIC patch-set [2]. Feedback is very much welcome.
>>>>>>>
>>>>>>> [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/u-boot-qcom-next?ref_type=heads
>>>>>>> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=385322
>>>>>>>
>>>>>>> Sumit Garg (7):
>>>>>>>   clk: apq8016: Add support for UART1 clocks
>>>>>>>   serial_msm: Add support for RS232 GPIOs
>>>>>>>   serial_msm: Enable RS232 flow control
>>>>>>>   board: Add SE HMIBSC board support
>>>>>>>   hmibsc: Enable RAUC support
>>>>>>>   hmibsc: enable U-Boot Environment variables protection
>>>>>>>   hmibsc: Enable LAN75XX USB ethernet driver
>>>>>>>
>>>>>>>  arch/arm/dts/Makefile              |   1 +
>>>>>>>  arch/arm/dts/hmibsc-uboot.dtsi     |  43 +++++++
>>>>>>>  arch/arm/dts/hmibsc.dts            | 188 +++++++++++++++++++++++++++++
>>>>>>>  arch/arm/mach-snapdragon/Kconfig   |  18 +++
>>>>>>>  arch/arm/mach-snapdragon/Makefile  |   1 +
>>>>>>>  board/schneider/hmibsc/Kconfig     |  15 +++
>>>>>>>  board/schneider/hmibsc/MAINTAINERS |   6 +
>>>>>>>  board/schneider/hmibsc/Makefile    |   5 +
>>>>>>>  board/schneider/hmibsc/hmibsc.c    | 179 +++++++++++++++++++++++++++
>>>>>>>  board/schneider/hmibsc/hmibsc.env  |  11 ++
>>>>>>>  configs/hmibsc_defconfig           |  79 ++++++++++++
>>>>>>>  drivers/clk/qcom/clock-apq8016.c   |  44 ++++++-
>>>>>>>  drivers/serial/serial_msm.c        |  23 +++-
>>>>>>>  drivers/usb/host/Kconfig           |   1 +
>>>>>>>  include/configs/hmibsc.h           |  59 +++++++++
>>>>>>>  15 files changed, 665 insertions(+), 8 deletions(-)
>>>>>>>  create mode 100644 arch/arm/dts/hmibsc-uboot.dtsi
>>>>>>>  create mode 100644 arch/arm/dts/hmibsc.dts
>>>>>>>  create mode 100644 board/schneider/hmibsc/Kconfig
>>>>>>>  create mode 100644 board/schneider/hmibsc/MAINTAINERS
>>>>>>>  create mode 100644 board/schneider/hmibsc/Makefile
>>>>>>>  create mode 100644 board/schneider/hmibsc/hmibsc.c
>>>>>>>  create mode 100644 board/schneider/hmibsc/hmibsc.env
>>>>>>>  create mode 100644 configs/hmibsc_defconfig
>>>>>>>  create mode 100644 include/configs/hmibsc.h
>>>>>>>
>>>>>>> --
>>>>>>> 2.34.1
>>>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Simon
>>>>
>>>> --
>>>> // Caleb (they/them)
>>
>> --
>> // Caleb (they/them)

-- 
// Caleb (they/them)
