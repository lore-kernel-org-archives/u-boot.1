Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05A6D2C54B
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5092288DFD;
	Tue, 22 Oct 2024 15:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=all4bambi-com.20230601.gappssmtp.com header.i=@all4bambi-com.20230601.gappssmtp.com header.b="S1NDvhIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC9088F82; Tue, 22 Oct 2024 10:48:50 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A3D88D94
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexey@all4bambi.com
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so6926624a12.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=all4bambi-com.20230601.gappssmtp.com; s=20230601; t=1729586927; x=1730191727;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bz+YK5S7RmWcLASNHlqOeR/qGe8kYaltQ24101RHxQQ=;
 b=S1NDvhINKglIgeRhYXpEn6Nu6B5hIHDRl55E28N26mv40n/qpdZW4cVg5n317UomN9
 baXmOiVtsf2wblh8O5TjcCtkweqF942uFF0mNAFOO7fvzyGTIGDtwj42VuxPmuWlCurJ
 6dv86B05p62MuMPo5+2jRuHaMWTywlVphluix2o60ZChdNd6X0wjDyi8AeiMsiwcmsJ+
 gjqfidau+X7GmicQqt8rX0sojF66Ll0X7Clq+/8vHAj79t8/UadL5rnOT7u4Aeq4Wtn1
 B8yYNIPhrRb7/FrQ8zOp9XT3vkPphZn9nidFMk2q8AZ7zSmIOzudI/NcBPrwtXeaDHgr
 t3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586927; x=1730191727;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bz+YK5S7RmWcLASNHlqOeR/qGe8kYaltQ24101RHxQQ=;
 b=EeOXbL1eHKt4y3V6Cb9ULhYAl2pHIAXFB9kRvoGhV7YaTlnXzHs0ycZvqK/QKlrsXm
 qtMUwlvUNM0Oo4EVZLKzQqXyVnuYlJZ14B4aTMm8Il6K2nYkhXz1ikjRI04O2ymDDpel
 11r+WCV9ElUSy6LQcsqEbQbarT6KMJPDETh0qQLi8+cvdxLHzeGKvSD4YtS1BHOCgXzO
 IxINiPNq896qLHrcnH8UAjX+6VMniuhgwj2h9stvxTWxqcXbZX8SYvkxlmvdZpwO3sk4
 HYl4tycUGdqUma5VnnJsbSXq4Zd3PMk56almAviKyOhGLr4SYDaisHwjKmrTpIEJfsqp
 6w3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3gsNMx9ynReBYRcBEnqyZhmfguyv5WLYyX9wgjULNiDdVjKj+sgYl6ltXGqEDzrDocaF+4N8=@lists.denx.de
X-Gm-Message-State: AOJu0YzV379i2+RMKwz6xrqxvzz75h5Td+KoAT+M3BpN04EQUFykS+61
 UcIz1Z8Wg4U7AN3vnXOTdSnOnUqP/r9IJUzshxu3W7snpeYUYHBNPICrfAiwN0227UGapnIgiwX
 w7exTr8ZQKV0tFvS0ndWflLFgDLKbCFN0a9dkjw==
X-Google-Smtp-Source: AGHT+IGB71szuGC24pF2bNlBWxn005+H6j808FzhcTwKCn1VyABD3+wZOcmX9HqthJwRId/3m7JyEkHeEju5A5lJYE0=
X-Received: by 2002:a05:6402:27c8:b0:5c9:463f:e6e7 with SMTP id
 4fb4d7f45d1cf-5cb7fce1eaamr1412776a12.11.1729586926818; Tue, 22 Oct 2024
 01:48:46 -0700 (PDT)
From: Alexey Tsirlin <alexey@all4bambi.com>
References: <20241015145307.118784-1-alexey@all4bambi.com>
 <20241015145307.118784-2-alexey@all4bambi.com>
 <60f174bc-dd15-403c-9606-5e18fd183754@microchip.com>
 <c97e8bc6-f2f5-4c62-8d92-0ccbd9caf278@linaro.org>
 <97d0a144-b7b0-4c2b-a8cc-96634011114a@microchip.com>
 <f9d626b03a969fd71fdd1194293d17c7@mail.gmail.com>
 <4a178500-39c1-402b-b7af-61daaaf3f033@microchip.com>
 <972bb7e24fdc498b252cd755e7c3488f@mail.gmail.com>
 <926847b7-d547-45a7-9303-cdf483035c61@microchip.com>
In-Reply-To: <926847b7-d547-45a7-9303-cdf483035c61@microchip.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMUF1Zp/jkjjbi2ZaZRnW201dzJ+wGd3SFcAeSqxgIDKPjcigHj40K/AqXfgvEBwtfTGgGtGJEKAmFWRRyvmFph8A==
Date: Tue, 22 Oct 2024 11:45:15 +0300
Message-ID: <a896fa0bcede96ae3ce647714989c2a0@mail.gmail.com>
Subject: RE: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
 pinctrl as in kernel dts
To: Manikandan.M@microchip.com, eugen.hristev@linaro.org, u-boot@lists.denx.de
Cc: Varshini.Rajendran@microchip.com, Hari.PrasathGE@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 22 Oct 2024 15:18:38 +0200
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

No problem!

Thanks!
Alexey.

-----Original Message-----
From: Manikandan.M@microchip.com <Manikandan.M@microchip.com>
Sent: Tuesday, 22 October 2024 11:47
To: alexey@all4bambi.com; eugen.hristev@linaro.org; u-boot@lists.denx.de
Cc: Varshini.Rajendran@microchip.com; Hari.PrasathGE@microchip.com
Subject: Re: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
pinctrl as in kernel dts

Hi Alexey,

Thank you for confirming the u-boot tree used for testing your patch.
This suggested modification is a fix-up patch for the pinctrl driver changes
present in the uboot-mcho git tree. However, because those changes are not
yet present in the mainline U-Boot, this patch will cause regression on all
sama5d3 SoC boards.

I appreciate your work in finding and resolving the issue for sama5d3.Please
hold on to this patch; you can share a version 2 that resolves the comments
once the driver changes are in.

Also, fyi, this change is already present in the u-boot-mchp tree
linux4microchip-2024.10-rc2 version,
https://github.com/linux4microchip/u-boot-mchp/commit/a25b31c2558f9fe303a3b97dd660b87476446301
On 22/10/24 11:14 am, Alexey Tsirlin wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>
> Hi Manikandan,
>
> I am using buildroot 2024.04 sama5d3_eds_headless_defconfig config
> setup which leads to the following:
> 1. uboot from https://github.com/linux4microchip/u-boot-mchp.git
> 2. uboot version linux4microchip-2024.10-rc2 3. uboot config
> sama5d3_xplained_mmc
>
> My board is sama5d3 EDS with DP83630 PHY connected to EMAC.
>
> I confirm that using configuration above, I was not able to make
> Ethernet
> (EMAC) in uboot work because it was failing to configure EMAC pins to
> the required peripheral mode. The at91_pin_check_config function in
> pinctrl-at91 returned -EINVAL because of nbanks=0. After applying the
> patch, the Ethernet is working fine.
>
> I also confirm that after applying the patch, I was able to toggle IO
> pin with gpio command (tried PIOC18 which is accessible through IO
> Connector #1), although I cannot tell you if this functionality also
> worked before applying the patch.
>
> Regards,
> Alexey.
>
> -----Original Message-----
> From: Manikandan.M@microchip.com <Manikandan.M@microchip.com>
> Sent: Monday, 21 October 2024 13:19
> To: alexey@all4bambi.com; eugen.hristev@linaro.org;
> u-boot@lists.denx.de
> Cc: Varshini.Rajendran@microchip.com; Hari.PrasathGE@microchip.com
> Subject: Re: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are
> inside pinctrl as in kernel dts
>
> Hi Alexey,
>
> Can you confirm if you are using the u-boot-mchp repo from GitHub [1]
> to test the sama5d3_eds board where the driver changes to align U-Boot
> and Kernel DT are already present.
> The pinctrl driver probe fails with the proposed change and will cause
> regression on other boards that uses the same pinctrl PIO3 driver in
> the mainline repo.
>
> [1] --> https://github.com/linux4microchip/u-boot-mchp
>
> On 20/10/24 10:44 am, Alexey Tsirlin wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> Hi Manikandan,
>>
>> I have tested gpio cmd option on SAMA5D3 EDS board (BTW it wasn't
>> enabled by default in sama5d3_xplained_mmc_defconfig which is used by
>> this board) in u-boot with the DT change as I proposed and it seems
>> to work fine, at least it detects all the 5 GPIO ports (A-E). pinmux
>> cmd does not work too much, but this is because pinctrl-at91 does not
>> implement get_pins_count function.
>> Without the proposed change I was not able to make the Ethernet
>> (EMAC) detect the PHY because MDIO interface was not working - the
>> correct peripheral mode for the EMAC pins was not set as defined in DT.
>>
>> Regards,
>> Alexey.
>>
>> -----Original Message-----
>> From: Manikandan.M@microchip.com <Manikandan.M@microchip.com>
>> Sent: Friday, 18 October 2024 12:30
>> To: eugen.hristev@linaro.org; alexey@all4bambi.com;
>> u-boot@lists.denx.de
>> Cc: Varshini.Rajendran@microchip.com; Hari.PrasathGE@microchip.com
>> Subject: Re: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are
>> inside pinctrl as in kernel dts
>>
>> Hi Eugen,
>>
>> On 18/10/24 12:45 pm, Eugen Hristev wrote:
>>> [You don't often get email from eugen.hristev@linaro.org. Learn why
>>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>> know the content is safe
>>>
>>> Hello Alexey,
>>>
>>> Please fix the subject to adhere to the rules ARM: dts: .... etc, if
>>> you are unsure, please follow previous commits that touched this file.
>>>
>>> On 10/17/24 11:51, Manikandan.M@microchip.com wrote:
>>>> Hi Alexey,
>>>>
>>>> On 15/10/24 8:23 pm, Alexey Tsirlin wrote:
>>>>> This allows setting the GPIO parameters from device tree,
>>>>> otherwise the at91_pin_check_config will fail because the
>>>>> priv->nbanks equal to zero
>>>
>>> I remember these pin banks are outside of the pinctrl because the
>>> driver fails to probe them if they are inside.
>>> Is this no longer true ?
>> Indeed, you are correct.With the current code base the pinctrl fails
>> to probe if they are defined inside.
>> I started to review this code with an intention that my changes for
>> pinctrl driver and DT to align U-Boot pinctrl DT node with the kernel
>> had already been made upstream, however that is not the case.
>> This patch is valid and necessary only after when my changes are
>> up-streamed otherwise driver probe will fail
>>
>> Since I don't own a board with this SoC, Alexey, could you kindly
>> check the GPIO functions and determine whether this patch is actually
>> necessary for the problem you're experiencing?If not, after
>> incorporating the driver changes, you can send this as part of the DT
>> alignment
>>>
>>> Manikandan, is it possible to test this on the board? and use the
>>> gpio command in U-boot to toggle the pins , like e.g. for the LEDs
>>> and see if there is no regression ?
>>>
>>> Thanks,
>>> Eugen
>>>>>
>>>>> Signed-off-by: Alexey Tsirlin <alexey@all4bambi.com>
>>>>> ---
>>>>>
>>>>>      arch/arm/dts/sama5d3.dtsi | 111
>>>>> +++++++++++++++++++-------------------
>>>>>      1 file changed, 56 insertions(+), 55 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
>>>>> index 4c03a302ec..c671ea42f2 100644
>>>>> --- a/arch/arm/dts/sama5d3.dtsi
>>>>> +++ b/arch/arm/dts/sama5d3.dtsi
>>>>> @@ -873,66 +873,67 @@
>>>>>                                                         AT91_PIOE
>>>>> 17 AT91_PERIPH_B AT91_PINCTRL_NONE>; /* PE17 periph B, conflicts
>>>>> with
>>>>> A17 */
>>>>>                                        };
>>>>>                                };
>>>>> -                    };
>>>>>
>>>>> -                    pioA: gpio@fffff200 {
>>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>>> "atmel,at91rm9200-gpio";
>>>>> -                            reg = <0xfffff200 0x100>;
>>>>> -                            interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
>>>>> -                            #gpio-cells = <2>;
>>>>> -                            gpio-controller;
>>>>> -                            interrupt-controller;har
>>>>> -                            #interrupt-cells = <2>;
>>>>> -                            clocks = <&pioA_clk>;
>>>>> -                            bootph-all;
>>>>> -                    };
>>>>> +                            pioA: gpio@fffff200 {
>>>>> +                                  compatible =
>>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>>> Spaces instead of tab before 'compatible', should be consistent
>>>> with the remaining properties of pioA node.
>>>>> +                                    reg = <0xfffff200 0x100>;
>>>>> +                                    interrupts = <6
>>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>>> +                                    #gpio-cells = <2>;
>>>>> +                                    gpio-controller;
>>>>> +                                    interrupt-controller;
>>>>> +                                    #interrupt-cells = <2>;
>>>>> +                                    clocks = <&pioA_clk>;
>>>>> +                                    bootph-all;
>>>>> +                            };
>>>>>
>>>>> -                    pioB: gpio@fffff400 {
>>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>>> "atmel,at91rm9200-gpio";
>>>>> -                            reg = <0xfffff400 0x100>;
>>>>> -                            interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
>>>>> -                            #gpio-cells = <2>;
>>>>> -                            gpio-controller;
>>>>> -                            interrupt-controller;
>>>>> -                            #interrupt-cells = <2>;
>>>>> -                            clocks = <&pioB_clk>;
>>>>> -                            bootph-all;
>>>>> -                    };
>>>>> +                            pioB: gpio@fffff400 {
>>>>> +                                  compatible =
>>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>>> Ditto
>>>>> +                                    reg = <0xfffff400 0x100>;
>>>>> +                                    interrupts = <7
>>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>>> +                                    #gpio-cells = <2>;
>>>>> +                                    gpio-controller;
>>>>> +                                    interrupt-controller;
>>>>> +                                    #interrupt-cells = <2>;
>>>>> +                                    clocks = <&pioB_clk>;
>>>>> +                                    bootph-all;
>>>>> +                            };
>>>>>
>>>>> -                    pioC: gpio@fffff600 {
>>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>>> "atmel,at91rm9200-gpio";
>>>>> -                            reg = <0xfffff600 0x100>;
>>>>> -                            interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
>>>>> -                            #gpio-cells = <2>;
>>>>> -                            gpio-controller;
>>>>> -                            interrupt-controller;
>>>>> -                            #interrupt-cells = <2>;
>>>>> -                            clocks = <&pioC_clk>;
>>>>> -                            bootph-all;
>>>>> -                    };
>>>>> +                            pioC: gpio@fffff600 {
>>>>> +                                  compatible =
>>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>>> Ditto
>>>>> +                                    reg = <0xfffff600 0x100>;
>>>>> +                                    interrupts = <8
>>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>>> +                                    #gpio-cells = <2>;
>>>>> +                                    gpio-controller;
>>>>> +                                    interrupt-controller;
>>>>> +                                    #interrupt-cells = <2>;
>>>>> +                                    clocks = <&pioC_clk>;
>>>>> +                                    bootph-all;
>>>>> +                            };
>>>>>
>>>>> -                    pioD: gpio@fffff800 {
>>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>>> "atmel,at91rm9200-gpio";
>>>>> -                            reg = <0xfffff800 0x100>;
>>>>> -                            interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
>>>>> -                            #gpio-cells = <2>;
>>>>> -                            gpio-controller;
>>>>> -                            interrupt-controller;
>>>>> -                            #interrupt-cells = <2>;
>>>>> -                            clocks = <&pioD_clk>;
>>>>> -                            bootph-all;
>>>>> -                    };
>>>>> +                            pioD: gpio@fffff800 {
>>>>> +                                  compatible =
>>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>>> Ditto
>>>>> +                                    reg = <0xfffff800 0x100>;
>>>>> +                                    interrupts = <9
>>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>>> +                                    #gpio-cells = <2>;
>>>>> +                                    gpio-controller;
>>>>> +                                    interrupt-controller;
>>>>> +                                    #interrupt-cells = <2>;
>>>>> +                                    clocks = <&pioD_clk>;
>>>>> +                                    bootph-all;
>>>>> +                            };
>>>>> +
>>>>> +                            pioE: gpio@fffffa00 {
>>>>> +                                  compatible =
>>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>>> Ditto
>>>>> +                                    reg = <0xfffffa00 0x100>;
>>>>> +                                    interrupts = <10
>>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>>> +                                    #gpio-cells = <2>;
>>>>> +                                    gpio-controller;
>>>>> +                                    interrupt-controller;
>>>>> +                                    #interrupt-cells = <2>;
>>>>> +                                    clocks = <&pioE_clk>;
>>>>> +                                    bootph-all;
>>>>> +                            };
>>>>>
>>>> Extra line
>>>>> -                    pioE: gpio@fffffa00 {
>>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>>> "atmel,at91rm9200-gpio";
>>>>> -                            reg = <0xfffffa00 0x100>;
>>>>> -                            interrupts = <10 IRQ_TYPE_LEVEL_HIGH
>>>>> 1>;
>>>>> -                            #gpio-cells = <2>;
>>>>> -                            gpio-controller;
>>>>> -                            interrupt-controller;
>>>>> -                            #interrupt-cells = <2>;
>>>>> -                            clocks = <&pioE_clk>;
>>>>> -                            bootph-all;
>>>>>                        };
>>>>>
>>>>>                        pmc: pmc@fffffc00 {
>>>>
>>>
>>
>> --
>> Thanks and Regards,
>> Manikandan M.
>
> --
> Thanks and Regards,
> Manikandan M.

--
Thanks and Regards,
Manikandan M.
