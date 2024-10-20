Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B145D3C934
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 06:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E4F890D1;
	Sun, 20 Oct 2024 08:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=all4bambi-com.20230601.gappssmtp.com header.i=@all4bambi-com.20230601.gappssmtp.com header.b="J/gfz0kt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 801A688E6B; Sun, 20 Oct 2024 07:17:22 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC2788E33
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 07:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexey@all4bambi.com
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so600375a12.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 22:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=all4bambi-com.20230601.gappssmtp.com; s=20230601; t=1729401439; x=1730006239;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=giya2h6DOyTf2/9uF6wFYA3HminALeiTJlhACjNxw2Q=;
 b=J/gfz0ktFFmA86SpdInHiui7pt8viL1csceLdV7VcKRlzJvKmNVYEB8S0X2vy98Z5z
 0Bd7ntrM4XNNl73A7wYZEOtuxlNDub4RK5rbb20XMZHxwGMxH2zv35464tgSsCjzVmyP
 GOtvMQd1gA13VhxFDfqKHLECV8INNbA0DcGqhqyQALGCxugeKk+l5nCGMRFFt4hxbkjI
 3uZO7fSuX9LvTAJGi4HZXo4DFFd7YeF2p8Z/JUZIsCJ93WdPPTIfUm8BsLvRFjr0XLce
 KN9ghjFZpIiG0n2FsOna6k7bSN1pxQiKciEZXbLkk5wnUQ0vCJxcy0p+/ZKamAdTrYRq
 bqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729401439; x=1730006239;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giya2h6DOyTf2/9uF6wFYA3HminALeiTJlhACjNxw2Q=;
 b=XqSViwpHJKBQE9aUGlqn49StTZv75ijLR2seQ8UP0JTBgZTA5for1d8Mems7YJK38O
 JGZgMWBZDA8EzgHQmTF84z3XWdbNHiesZA5wxMzDRFXCu49E4ofS4UgCWceYm1NipXGN
 6iSvfZ9Ko3PjSSC0zNTV+Z5p3lYGbeOcHyAXGCLprxAE9DOAuOvLF8TT9GnZ1lowzhNx
 ywqHtq2Zs+JO030EVqIyeLodsgSloHstHvIKr+wSbWC++TFQzQEtCSuQuWjjAjCesP1x
 egmG6AaI1MHakjdN+SaThasSXZ+RmD57j93XT146rkQ5k/xddF2u2HKPYidIoCqJTPmt
 5BWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHrXFhvZzpVaqhUjWzUABlFT0k0raZP8j3SqQlF0AQCI9HuYWxeaPgZTAa3PQOHfVYTZ5HiaU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7bJ9vOvPD+UPWt2FoSGEGMm9Gu3qpjqH2V1XR3+sZvCcVo/1j
 Dsg/VpJcaMd8hQmRUc6862S5XxV2zn43Le/1EuDgHQDBPS+JA/GGdfAexUYpuirtux7sfiXb3e4
 p4QnidiBRAOVeMfv5nk9RwLELnc0Qj6TFYlMZOp4JNIX3ZTuf5WTNyQ==
X-Google-Smtp-Source: AGHT+IEZjRnsXHMJmsymS9MyO7z7tW4Vnp2N+Ljug0JwIAy0nidsuyCHa8z5Bor+22uNow7cVEQVeBHagR9Y7gT+mik=
X-Received: by 2002:a05:6402:84d:b0:5c9:4022:872d with SMTP id
 4fb4d7f45d1cf-5ca0af8302fmr6764579a12.32.1729401439240; Sat, 19 Oct 2024
 22:17:19 -0700 (PDT)
From: Alexey Tsirlin <alexey@all4bambi.com>
References: <20241015145307.118784-1-alexey@all4bambi.com>
 <20241015145307.118784-2-alexey@all4bambi.com>
 <60f174bc-dd15-403c-9606-5e18fd183754@microchip.com>
 <c97e8bc6-f2f5-4c62-8d92-0ccbd9caf278@linaro.org>
 <97d0a144-b7b0-4c2b-a8cc-96634011114a@microchip.com>
In-Reply-To: <97d0a144-b7b0-4c2b-a8cc-96634011114a@microchip.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMUF1Zp/jkjjbi2ZaZRnW201dzJ+wGd3SFcAeSqxgIDKPjcigHj40K/r9ixj4A=
Date: Sun, 20 Oct 2024 08:14:45 +0300
Message-ID: <f9d626b03a969fd71fdd1194293d17c7@mail.gmail.com>
Subject: RE: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
 pinctrl as in kernel dts
To: Manikandan.M@microchip.com, eugen.hristev@linaro.org, u-boot@lists.denx.de
Cc: Varshini.Rajendran@microchip.com, Hari.PrasathGE@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 20 Oct 2024 08:05:41 +0200
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

I have tested gpio cmd option on SAMA5D3 EDS board (BTW it wasn't enabled by
default in sama5d3_xplained_mmc_defconfig which is used by this board) in
u-boot with the DT change as I proposed and it seems to work fine, at least
it detects all the 5 GPIO ports (A-E). pinmux cmd does not work too much,
but this is because pinctrl-at91 does not implement get_pins_count function.
Without the proposed change I was not able to make the Ethernet (EMAC)
detect the PHY because MDIO interface was not working - the correct
peripheral mode for the EMAC pins was not set as defined in DT.

Regards,
Alexey.

-----Original Message-----
From: Manikandan.M@microchip.com <Manikandan.M@microchip.com>
Sent: Friday, 18 October 2024 12:30
To: eugen.hristev@linaro.org; alexey@all4bambi.com; u-boot@lists.denx.de
Cc: Varshini.Rajendran@microchip.com; Hari.PrasathGE@microchip.com
Subject: Re: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
pinctrl as in kernel dts

Hi Eugen,

On 18/10/24 12:45 pm, Eugen Hristev wrote:
> [You don't often get email from eugen.hristev@linaro.org. Learn why
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>
> Hello Alexey,
>
> Please fix the subject to adhere to the rules ARM: dts: .... etc, if
> you are unsure, please follow previous commits that touched this file.
>
> On 10/17/24 11:51, Manikandan.M@microchip.com wrote:
>> Hi Alexey,
>>
>> On 15/10/24 8:23 pm, Alexey Tsirlin wrote:
>>> This allows setting the GPIO parameters from device tree, otherwise
>>> the at91_pin_check_config will fail because the priv->nbanks equal
>>> to zero
>
> I remember these pin banks are outside of the pinctrl because the
> driver fails to probe them if they are inside.
> Is this no longer true ?
Indeed, you are correct.With the current code base the pinctrl fails to
probe if they are defined inside.
I started to review this code with an intention that my changes for pinctrl
driver and DT to align U-Boot pinctrl DT node with the kernel had already
been made upstream, however that is not the case.
This patch is valid and necessary only after when my changes are up-streamed
otherwise driver probe will fail

Since I don't own a board with this SoC, Alexey, could you kindly check the
GPIO functions and determine whether this patch is actually necessary for
the problem you're experiencing?If not, after incorporating the driver
changes, you can send this as part of the DT alignment
>
> Manikandan, is it possible to test this on the board? and use the gpio
> command in U-boot to toggle the pins , like e.g. for the LEDs and see
> if there is no regression ?
>
> Thanks,
> Eugen
>>>
>>> Signed-off-by: Alexey Tsirlin <alexey@all4bambi.com>
>>> ---
>>>
>>>    arch/arm/dts/sama5d3.dtsi | 111
>>> +++++++++++++++++++-------------------
>>>    1 file changed, 56 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
>>> index 4c03a302ec..c671ea42f2 100644
>>> --- a/arch/arm/dts/sama5d3.dtsi
>>> +++ b/arch/arm/dts/sama5d3.dtsi
>>> @@ -873,66 +873,67 @@
>>>                                                       AT91_PIOE 17
>>> AT91_PERIPH_B AT91_PINCTRL_NONE>; /* PE17 periph B, conflicts with
>>> A17 */
>>>                                      };
>>>                              };
>>> -                    };
>>>
>>> -                    pioA: gpio@fffff200 {
>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>> "atmel,at91rm9200-gpio";
>>> -                            reg = <0xfffff200 0x100>;
>>> -                            interrupts = <6 IRQ_TYPE_LEVEL_HIGH 1>;
>>> -                            #gpio-cells = <2>;
>>> -                            gpio-controller;
>>> -                            interrupt-controller;har
>>> -                            #interrupt-cells = <2>;
>>> -                            clocks = <&pioA_clk>;
>>> -                            bootph-all;
>>> -                    };
>>> +                            pioA: gpio@fffff200 {
>>> +                                  compatible =
>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> Spaces instead of tab before 'compatible', should be consistent with
>> the remaining properties of pioA node.
>>> +                                    reg = <0xfffff200 0x100>;
>>> +                                    interrupts = <6
>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                                    #gpio-cells = <2>;
>>> +                                    gpio-controller;
>>> +                                    interrupt-controller;
>>> +                                    #interrupt-cells = <2>;
>>> +                                    clocks = <&pioA_clk>;
>>> +                                    bootph-all;
>>> +                            };
>>>
>>> -                    pioB: gpio@fffff400 {
>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>> "atmel,at91rm9200-gpio";
>>> -                            reg = <0xfffff400 0x100>;
>>> -                            interrupts = <7 IRQ_TYPE_LEVEL_HIGH 1>;
>>> -                            #gpio-cells = <2>;
>>> -                            gpio-controller;
>>> -                            interrupt-controller;
>>> -                            #interrupt-cells = <2>;
>>> -                            clocks = <&pioB_clk>;
>>> -                            bootph-all;
>>> -                    };
>>> +                            pioB: gpio@fffff400 {
>>> +                                  compatible =
>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> Ditto
>>> +                                    reg = <0xfffff400 0x100>;
>>> +                                    interrupts = <7
>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                                    #gpio-cells = <2>;
>>> +                                    gpio-controller;
>>> +                                    interrupt-controller;
>>> +                                    #interrupt-cells = <2>;
>>> +                                    clocks = <&pioB_clk>;
>>> +                                    bootph-all;
>>> +                            };
>>>
>>> -                    pioC: gpio@fffff600 {
>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>> "atmel,at91rm9200-gpio";
>>> -                            reg = <0xfffff600 0x100>;
>>> -                            interrupts = <8 IRQ_TYPE_LEVEL_HIGH 1>;
>>> -                            #gpio-cells = <2>;
>>> -                            gpio-controller;
>>> -                            interrupt-controller;
>>> -                            #interrupt-cells = <2>;
>>> -                            clocks = <&pioC_clk>;
>>> -                            bootph-all;
>>> -                    };
>>> +                            pioC: gpio@fffff600 {
>>> +                                  compatible =
>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> Ditto
>>> +                                    reg = <0xfffff600 0x100>;
>>> +                                    interrupts = <8
>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                                    #gpio-cells = <2>;
>>> +                                    gpio-controller;
>>> +                                    interrupt-controller;
>>> +                                    #interrupt-cells = <2>;
>>> +                                    clocks = <&pioC_clk>;
>>> +                                    bootph-all;
>>> +                            };
>>>
>>> -                    pioD: gpio@fffff800 {
>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>> "atmel,at91rm9200-gpio";
>>> -                            reg = <0xfffff800 0x100>;
>>> -                            interrupts = <9 IRQ_TYPE_LEVEL_HIGH 1>;
>>> -                            #gpio-cells = <2>;
>>> -                            gpio-controller;
>>> -                            interrupt-controller;
>>> -                            #interrupt-cells = <2>;
>>> -                            clocks = <&pioD_clk>;
>>> -                            bootph-all;
>>> -                    };
>>> +                            pioD: gpio@fffff800 {
>>> +                                  compatible =
>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> Ditto
>>> +                                    reg = <0xfffff800 0x100>;
>>> +                                    interrupts = <9
>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                                    #gpio-cells = <2>;
>>> +                                    gpio-controller;
>>> +                                    interrupt-controller;
>>> +                                    #interrupt-cells = <2>;
>>> +                                    clocks = <&pioD_clk>;
>>> +                                    bootph-all;
>>> +                            };
>>> +
>>> +                            pioE: gpio@fffffa00 {
>>> +                                  compatible =
>>> "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>> Ditto
>>> +                                    reg = <0xfffffa00 0x100>;
>>> +                                    interrupts = <10
>>> IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                                    #gpio-cells = <2>;
>>> +                                    gpio-controller;
>>> +                                    interrupt-controller;
>>> +                                    #interrupt-cells = <2>;
>>> +                                    clocks = <&pioE_clk>;
>>> +                                    bootph-all;
>>> +                            };
>>>
>> Extra line
>>> -                    pioE: gpio@fffffa00 {
>>> -                            compatible = "atmel,at91sam9x5-gpio",
>>> "atmel,at91rm9200-gpio";
>>> -                            reg = <0xfffffa00 0x100>;
>>> -                            interrupts = <10 IRQ_TYPE_LEVEL_HIGH
>>> 1>;
>>> -                            #gpio-cells = <2>;
>>> -                            gpio-controller;
>>> -                            interrupt-controller;
>>> -                            #interrupt-cells = <2>;
>>> -                            clocks = <&pioE_clk>;
>>> -                            bootph-all;
>>>                      };
>>>
>>>                      pmc: pmc@fffffc00 {
>>
>

--
Thanks and Regards,
Manikandan M.
