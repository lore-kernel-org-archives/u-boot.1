Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82FAD1CDA1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 05:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F324988E02;
	Tue, 22 Oct 2024 07:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=all4bambi-com.20230601.gappssmtp.com header.i=@all4bambi-com.20230601.gappssmtp.com header.b="e7q1hzh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F94588EFB; Tue, 22 Oct 2024 07:47:51 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94D988C4D
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 07:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexey@all4bambi.com
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso638019266b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=all4bambi-com.20230601.gappssmtp.com; s=20230601; t=1729576068; x=1730180868;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rx363p22b6H80ZB2gI7f7edgc83GGuQp4Id82/ewnK4=;
 b=e7q1hzh/Qf99+H+6hyl8wZ0R99ioM5Qw13MVf3vibJxXW3XGIcw3Sneh9DSq0hjM4l
 dA3NrC8IvwZin64bS6AciTFBv7AYclBFRe1jzKzwN0VSzF3Gd9mSPK3nGQRqt67RVJvl
 5FXTytIedbrPf22Sx+uf+oRj8rf6+lTojJaK/QxTI0G2Ji4vjaLYf//GeSXDsJ9A6TUq
 Atv3OtprP50rHPIZCmrhlJyOi+Y4QG4nhRny6u7l36eWCXKCV7FW1GfE1vzYADltdbtW
 OiIsNBr/397HzNG4uZCQzz26FO1oHyiOMh8DfJISTSkMNfTYZRZCgFxWgL74aLqDQkgs
 QQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729576068; x=1730180868;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rx363p22b6H80ZB2gI7f7edgc83GGuQp4Id82/ewnK4=;
 b=XxV7ATKJ3pgtlN/168huTgCljJ4o4s8hwDj4OePgBZ95+ZX0aQ2Qpb/amDuPO4PE5t
 O/72pgjEeXoDZ7vN2Aee8cPJ7SsZ/kq0bLLDyUhzMiM1RgTlja2IOl1gwPuLzhOkmCdK
 oerueCPvyZhaN8IZlsErpLWwSDZFN1xTvnn2g94LcRUraUCCpVWtgoOy4y4YzLxtcrYx
 /ptXAA99bm7hxUmTCNu+P4Re5jTGuxQECU1Jirs07ui9PKt2qaR+wxxCL4bmpCOOZ7uY
 tW4izCdwkA6Sp8cdJbtBPbctPX8F/+AK+5PGf5QL86hDexHh3UgXjaEQPDo9G97rnCsg
 xF8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk3z6TcY3LT7AHnzvP8nNWzLBjG0KmET+NwDJgw3ms28oJXpD1qTLZdOVTsL5/KmI5auIKcKo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2X7eME65wSRmySM558Q06zx2MA76X7/Iam0+g5X4pt7lAWHyd
 JDzRVVn2M6Zfa2KU6+nO9agbMmCO8TaWu3I9H7A6UfYdfbtylhY332vOxdq+lv2WzdTxSFeKW8N
 qU21HJJ71rnMDCiXOXdoCQZ674I76pDrqNuVAYg==
X-Google-Smtp-Source: AGHT+IHWzkPBY479Cb6dE4tTZMD6isteFfXml4H9XjwjOx5CIJgrT2lOryAoGG0FnoWU+HKFSAQbp6LT5EGfp7/2+cQ=
X-Received: by 2002:a17:907:728b:b0:a8d:4631:83b0 with SMTP id
 a640c23a62f3a-a9a69969af5mr1542046666b.5.1729576067970; Mon, 21 Oct 2024
 22:47:47 -0700 (PDT)
From: Alexey Tsirlin <alexey@all4bambi.com>
References: <20241015145307.118784-1-alexey@all4bambi.com>
 <20241015145307.118784-2-alexey@all4bambi.com>
 <60f174bc-dd15-403c-9606-5e18fd183754@microchip.com>
 <c97e8bc6-f2f5-4c62-8d92-0ccbd9caf278@linaro.org>
 <97d0a144-b7b0-4c2b-a8cc-96634011114a@microchip.com>
 <f9d626b03a969fd71fdd1194293d17c7@mail.gmail.com>
 <4a178500-39c1-402b-b7af-61daaaf3f033@microchip.com>
In-Reply-To: <4a178500-39c1-402b-b7af-61daaaf3f033@microchip.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMUF1Zp/jkjjbi2ZaZRnW201dzJ+wGd3SFcAeSqxgIDKPjcigHj40K/AqXfgvEBwtfTGq+4lseA
Date: Tue, 22 Oct 2024 08:44:16 +0300
Message-ID: <972bb7e24fdc498b252cd755e7c3488f@mail.gmail.com>
Subject: RE: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
 pinctrl as in kernel dts
To: Manikandan.M@microchip.com, eugen.hristev@linaro.org, u-boot@lists.denx.de
Cc: Varshini.Rajendran@microchip.com, Hari.PrasathGE@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 22 Oct 2024 07:49:12 +0200
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

Hi Manikandan,

I am using buildroot 2024.04 sama5d3_eds_headless_defconfig config setup
which leads to the following:
1. uboot from https://github.com/linux4microchip/u-boot-mchp.git
2. uboot version linux4microchip-2024.10-rc2
3. uboot config sama5d3_xplained_mmc

My board is sama5d3 EDS with DP83630 PHY connected to EMAC.

I confirm that using configuration above, I was not able to make Ethernet
(EMAC) in uboot work because it was failing to configure EMAC pins to the
required peripheral mode. The at91_pin_check_config function in pinctrl-at91
returned -EINVAL because of nbanks=0. After applying the patch, the Ethernet
is working fine.

I also confirm that after applying the patch, I was able to toggle IO pin
with gpio command (tried PIOC18 which is accessible through IO Connector
#1), although I cannot tell you if this functionality also worked before
applying the patch.

Regards,
Alexey.

-----Original Message-----
From: Manikandan.M@microchip.com <Manikandan.M@microchip.com>
Sent: Monday, 21 October 2024 13:19
To: alexey@all4bambi.com; eugen.hristev@linaro.org; u-boot@lists.denx.de
Cc: Varshini.Rajendran@microchip.com; Hari.PrasathGE@microchip.com
Subject: Re: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
pinctrl as in kernel dts

Hi Alexey,

Can you confirm if you are using the u-boot-mchp repo from GitHub [1] to
test the sama5d3_eds board where the driver changes to align U-Boot and
Kernel DT are already present.
The pinctrl driver probe fails with the proposed change and will cause
regression on other boards that uses the same pinctrl PIO3 driver in the
mainline repo.

[1] --> https://github.com/linux4microchip/u-boot-mchp

On 20/10/24 10:44 am, Alexey Tsirlin wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>
> Hi Manikandan,
>
> I have tested gpio cmd option on SAMA5D3 EDS board (BTW it wasn't
> enabled by default in sama5d3_xplained_mmc_defconfig which is used by
> this board) in u-boot with the DT change as I proposed and it seems to
> work fine, at least it detects all the 5 GPIO ports (A-E). pinmux cmd
> does not work too much, but this is because pinctrl-at91 does not
> implement get_pins_count function.
> Without the proposed change I was not able to make the Ethernet (EMAC)
> detect the PHY because MDIO interface was not working - the correct
> peripheral mode for the EMAC pins was not set as defined in DT.
>
> Regards,
> Alexey.
>
> -----Original Message-----
> From: Manikandan.M@microchip.com <Manikandan.M@microchip.com>
> Sent: Friday, 18 October 2024 12:30
> To: eugen.hristev@linaro.org; alexey@all4bambi.com;
> u-boot@lists.denx.de
> Cc: Varshini.Rajendran@microchip.com; Hari.PrasathGE@microchip.com
> Subject: Re: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are
> inside pinctrl as in kernel dts
>
> Hi Eugen,
>
> On 18/10/24 12:45 pm, Eugen Hristev wrote:
>> [You don't often get email from eugen.hristev@linaro.org. Learn why
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> Hello Alexey,
>>
>> Please fix the subject to adhere to the rules ARM: dts: .... etc, if
>> you are unsure, please follow previous commits that touched this file.
>>
>> On 10/17/24 11:51, Manikandan.M@microchip.com wrote:
>>> Hi Alexey,
>>>
>>> On 15/10/24 8:23 pm, Alexey Tsirlin wrote:
>>>> This allows setting the GPIO parameters from device tree, otherwise
>>>> the at91_pin_check_config will fail because the priv->nbanks equal
>>>> to zero
>>
>> I remember these pin banks are outside of the pinctrl because the
>> driver fails to probe them if they are inside.
>> Is this no longer true ?
> Indeed, you are correct.With the current code base the pinctrl fails
> to probe if they are defined inside.
> I started to review this code with an intention that my changes for
> pinctrl driver and DT to align U-Boot pinctrl DT node with the kernel
> had already been made upstream, however that is not the case.
> This patch is valid and necessary only after when my changes are
> up-streamed otherwise driver probe will fail
>
> Since I don't own a board with this SoC, Alexey, could you kindly
> check the GPIO functions and determine whether this patch is actually
> necessary for the problem you're experiencing?If not, after
> incorporating the driver changes, you can send this as part of the DT
> alignment
>>
>> Manikandan, is it possible to test this on the board? and use the
>> gpio command in U-boot to toggle the pins , like e.g. for the LEDs
>> and see if there is no regression ?
>>
>> Thanks,
>> Eugen
>>>>
>>>> Signed-off-by: Alexey Tsirlin <alexey@all4bambi.com>
>>>> ---
>>>>
>>>>     arch/arm/dts/sama5d3.dtsi | 111
>>>> +++++++++++++++++++-------------------
>>>>     1 file changed, 56 insertions(+), 55 deletions(-)
>>>>
>>>> diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
>>>> index 4c03a302ec..c671ea42f2 100644
>>>> --- a/arch/arm/dts/sama5d3.dtsi
>>>> +++ b/arch/arm/dts/sama5d3.dtsi
>>>> @@ -873,66 +873,67 @@
>>>>                                                        AT91_PIOE 17
>>>> AT91_PERIPH_B AT91_PINCTRL_NONE>; /* PE17 periph B, conflicts with
>>>> A17 */
>>>>                                       };
>>>>                               };
>>>> -                    };
>>>>
>>>> -                    pioA: gpio@fffff200 {
>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>> "atmel,at91rm9200-gpio";
>>>> -                            reg = <0xfffff200 0x100>;
>>>> -                            interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
>>>> -                            #gpio-cells = <2>;
>>>> -                            gpio-controller;
>>>> -                            interrupt-controller;har
>>>> -                            #interrupt-cells = <2>;
>>>> -                            clocks = <&pioA_clk>;
>>>> -                            bootph-all;
>>>> -                    };
>>>> +                            pioA: gpio@fffff200 {
>>>> +                                  compatible =
>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>> Spaces instead of tab before 'compatible', should be consistent with
>>> the remaining properties of pioA node.
>>>> +                                    reg = <0xfffff200 0x100>;
>>>> +                                    interrupts = <6
>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>> +                                    #gpio-cells = <2>;
>>>> +                                    gpio-controller;
>>>> +                                    interrupt-controller;
>>>> +                                    #interrupt-cells = <2>;
>>>> +                                    clocks = <&pioA_clk>;
>>>> +                                    bootph-all;
>>>> +                            };
>>>>
>>>> -                    pioB: gpio@fffff400 {
>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>> "atmel,at91rm9200-gpio";
>>>> -                            reg = <0xfffff400 0x100>;
>>>> -                            interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
>>>> -                            #gpio-cells = <2>;
>>>> -                            gpio-controller;
>>>> -                            interrupt-controller;
>>>> -                            #interrupt-cells = <2>;
>>>> -                            clocks = <&pioB_clk>;
>>>> -                            bootph-all;
>>>> -                    };
>>>> +                            pioB: gpio@fffff400 {
>>>> +                                  compatible =
>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>> Ditto
>>>> +                                    reg = <0xfffff400 0x100>;
>>>> +                                    interrupts = <7
>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>> +                                    #gpio-cells = <2>;
>>>> +                                    gpio-controller;
>>>> +                                    interrupt-controller;
>>>> +                                    #interrupt-cells = <2>;
>>>> +                                    clocks = <&pioB_clk>;
>>>> +                                    bootph-all;
>>>> +                            };
>>>>
>>>> -                    pioC: gpio@fffff600 {
>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>> "atmel,at91rm9200-gpio";
>>>> -                            reg = <0xfffff600 0x100>;
>>>> -                            interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
>>>> -                            #gpio-cells = <2>;
>>>> -                            gpio-controller;
>>>> -                            interrupt-controller;
>>>> -                            #interrupt-cells = <2>;
>>>> -                            clocks = <&pioC_clk>;
>>>> -                            bootph-all;
>>>> -                    };
>>>> +                            pioC: gpio@fffff600 {
>>>> +                                  compatible =
>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>> Ditto
>>>> +                                    reg = <0xfffff600 0x100>;
>>>> +                                    interrupts = <8
>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>> +                                    #gpio-cells = <2>;
>>>> +                                    gpio-controller;
>>>> +                                    interrupt-controller;
>>>> +                                    #interrupt-cells = <2>;
>>>> +                                    clocks = <&pioC_clk>;
>>>> +                                    bootph-all;
>>>> +                            };
>>>>
>>>> -                    pioD: gpio@fffff800 {
>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>> "atmel,at91rm9200-gpio";
>>>> -                            reg = <0xfffff800 0x100>;
>>>> -                            interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
>>>> -                            #gpio-cells = <2>;
>>>> -                            gpio-controller;
>>>> -                            interrupt-controller;
>>>> -                            #interrupt-cells = <2>;
>>>> -                            clocks = <&pioD_clk>;
>>>> -                            bootph-all;
>>>> -                    };
>>>> +                            pioD: gpio@fffff800 {
>>>> +                                  compatible =
>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>> Ditto
>>>> +                                    reg = <0xfffff800 0x100>;
>>>> +                                    interrupts = <9
>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>> +                                    #gpio-cells = <2>;
>>>> +                                    gpio-controller;
>>>> +                                    interrupt-controller;
>>>> +                                    #interrupt-cells = <2>;
>>>> +                                    clocks = <&pioD_clk>;
>>>> +                                    bootph-all;
>>>> +                            };
>>>> +
>>>> +                            pioE: gpio@fffffa00 {
>>>> +                                  compatible =
>>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>>> Ditto
>>>> +                                    reg = <0xfffffa00 0x100>;
>>>> +                                    interrupts = <10
>>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>>> +                                    #gpio-cells = <2>;
>>>> +                                    gpio-controller;
>>>> +                                    interrupt-controller;
>>>> +                                    #interrupt-cells = <2>;
>>>> +                                    clocks = <&pioE_clk>;
>>>> +                                    bootph-all;
>>>> +                            };
>>>>
>>> Extra line
>>>> -                    pioE: gpio@fffffa00 {
>>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>>> "atmel,at91rm9200-gpio";
>>>> -                            reg = <0xfffffa00 0x100>;
>>>> -                            interrupts = <10 IRQ_TYPE_LEVEL_HIGH
>>>> 1>;
>>>> -                            #gpio-cells = <2>;
>>>> -                            gpio-controller;
>>>> -                            interrupt-controller;
>>>> -                            #interrupt-cells = <2>;
>>>> -                            clocks = <&pioE_clk>;
>>>> -                            bootph-all;
>>>>                       };
>>>>
>>>>                       pmc: pmc@fffffc00 {
>>>
>>
>
> --
> Thanks and Regards,
> Manikandan M.

--
Thanks and Regards,
Manikandan M.
