Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D72D2FFFD
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C44289166;
	Fri, 18 Oct 2024 14:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=all4bambi-com.20230601.gappssmtp.com header.i=@all4bambi-com.20230601.gappssmtp.com header.b="N90RF/IB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32AE0891C7; Fri, 18 Oct 2024 09:51:39 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E15BA8910A
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 09:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=all4bambi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexey@all4bambi.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d3e8d923fso1342281f8f.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=all4bambi-com.20230601.gappssmtp.com; s=20230601; t=1729237896; x=1729842696;
 darn=lists.denx.de; 
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:from:to:cc:subject:date:message-id
 :reply-to; bh=/H8+oDwBWBa20JBJpcQagXLs095zJH4AICzc6alXUvM=;
 b=N90RF/IBJJa/Ir4KUy1UzSGU77MXcHsesUXEkaEtRerYkoDHX3nJxeQzsC5LNImE2f
 4X/us6mOUnwG4DQRYmyNlGjIz3UqucpUXO754+ZKKkmKfn+Ag9h9eXQCPpCsoJxW3SWD
 h3Mau0s4+diLWh6D9wM6qKIyeFESusDzVpsRDEojTWVUJqmKwaElNITcGARkUOj2PwBK
 q17nYgjhwXtxJ4DlGpsA8Rcp+m8omveFMjh5b3EWNxWnE8VT/igHRentZNAovTJ4QM1Q
 CZYOrLTlK7JVaRrw7N0BPo/Km7IwmWuKAuhrGZ+ie2IHyl73zHyo7WZRBGevihjwApYC
 2kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729237896; x=1729842696;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/H8+oDwBWBa20JBJpcQagXLs095zJH4AICzc6alXUvM=;
 b=nHr8iq/CHOm9U9kllYPU95bUlqw3OUM/Q2wwDk7o2A3etb7nDWjRZ+L7NE4M4DcohM
 q+dAPD86t9qii64brFm6An/H+Krkdw8cUgoQ6e9Ede1RRnyMaitzN8+xHv0H5oV7hbwW
 WLcs/jdsXkXWjt0HFbE4Fl6n7munlbFG4BzoQ6HrTw87zSopUgHMYIg76+pPmRe42VAR
 izYfF7IWQJtQiv1H3kwuc/6RzIoHd43agh/rjZqTlPpgOE+aMlvHOGjjXplhzbPXjb8f
 UwbKxwM6NzRlYA+WlLUm0/txFPtuL7E9TOIod07J/zFpaDENznFR8HyvLZs3NDu4Tg0k
 vTHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwD/aEFY2KMYKW0nVju7TfPexPz3xRBbdtSZJggnRX2loIt+M/jUSdspK6EjBlDmT5yyOC0hM=@lists.denx.de
X-Gm-Message-State: AOJu0YzmvpcgvmspXEbHLAaqEGGy5CkrS2ZV53F+ckmloBZlLZ/qVR8i
 P9/phl55Pk6nrJtGIeAgmSzbObuJ4QWMJnedU18JqJHiybotobR4BnMJ+e41CIA=
X-Google-Smtp-Source: AGHT+IHHSK0FIuGx3w0rzFS0iqBuJNNsAXaLkKfMBQX3GgK8rKFa2BOZTxwjt+4nWtr5x5yLqboYyA==
X-Received: by 2002:a05:6000:1366:b0:37d:47b7:f2f5 with SMTP id
 ffacd0b85a97d-37ea21de07dmr1069460f8f.4.1729237896122; 
 Fri, 18 Oct 2024 00:51:36 -0700 (PDT)
Received: from smtpclient.apple ([2a0d:6fc7:242:6b9f:920:89c7:19fe:f003])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf085302sm1210686f8f.55.2024.10.18.00.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 00:51:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Tsirlin Alexey <alexey@all4bambi.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] Fixed sama5d3 dts file so PIO sections are inside
 pinctrl as in kernel dts
Date: Fri, 18 Oct 2024 10:51:24 +0300
Message-Id: <95AD5B21-D033-43D4-95AA-84BA9EF9BA1B@all4bambi.com>
References: <c97e8bc6-f2f5-4c62-8d92-0ccbd9caf278@linaro.org>
Cc: Manikandan.M@microchip.com, u-boot@lists.denx.de,
 Varshini.Rajendran@microchip.com, Hari.PrasathGE@microchip.com
In-Reply-To: <c97e8bc6-f2f5-4c62-8d92-0ccbd9caf278@linaro.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
X-Mailer: iPhone Mail (22A3370)
X-Mailman-Approved-At: Fri, 18 Oct 2024 14:32:49 +0200
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

Hi Eugen,
I will fix the subject as required. Just wanted to tell that I didn=E2=80=99=
t test the gpio commands in uboot. The part that interested me was the pinct=
l and that it is unable to set the correct peripheral function from DTS. The=
 function that interested me was Ethernet. I will also check the gpio functi=
onality than I am back to office on Sunday.=20

Thanks!
Alexey.=20

> On 18 Oct 2024, at 10:15, Eugen Hristev <eugen.hristev@linaro.org> wrote:
>=20
> =EF=BB=BFHello Alexey,
>=20
> Please fix the subject to adhere to the rules ARM: dts: .... etc,
> if you are unsure, please follow previous commits that touched this file.
>=20
>> On 10/17/24 11:51, Manikandan.M@microchip.com wrote:
>> Hi Alexey,
>>> On 15/10/24 8:23 pm, Alexey Tsirlin wrote:
>>> This allows setting the GPIO parameters from device tree, otherwise the
>>> at91_pin_check_config will fail because the priv->nbanks equal to zero
>=20
> I remember these pin banks are outside of the pinctrl because the driver f=
ails to probe them if they are inside.
> Is this no longer true ?
>=20
> Manikandan, is it possible to test this on the board? and use the gpio com=
mand in U-boot to toggle the pins , like e.g. for the LEDs and see if there i=
s no regression ?
>=20
> Thanks,
> Eugen
>>>=20
>>> Signed-off-by: Alexey Tsirlin <alexey@all4bambi.com>
>>> ---
>>>=20
>>>   arch/arm/dts/sama5d3.dtsi | 111 +++++++++++++++++++-------------------=

>>>   1 file changed, 56 insertions(+), 55 deletions(-)
>>>=20
>>> diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
>>> index 4c03a302ec..c671ea42f2 100644
>>> --- a/arch/arm/dts/sama5d3.dtsi
>>> +++ b/arch/arm/dts/sama5d3.dtsi
>>> @@ -873,66 +873,67 @@
>>>                                AT91_PIOE 17 AT91_PERIPH_B AT91_PINCTRL_N=
ONE>;    /* PE17 periph B, conflicts with A17 */
>>>                       };
>>>                   };
>>> -            };
>>>   -            pioA: gpio@fffff200 {
>>> -                compatible =3D "atmel,at91sam9x5-gpio", "atmel,at91rm92=
00-gpio";
>>> -                reg =3D <0xfffff200 0x100>;
>>> -                interrupts =3D <6 IRQ_TYPE_LEVEL_HIGH 1>;
>>> -                #gpio-cells =3D <2>;
>>> -                gpio-controller;
>>> -                interrupt-controller;har
>>> -                #interrupt-cells =3D <2>;
>>> -                clocks =3D <&pioA_clk>;
>>> -                bootph-all;
>>> -            };
>>> +                pioA: gpio@fffff200 {
>>> +                      compatible =3D "atmel,at91sam9x5-gpio", "atmel,at=
91rm9200-gpio";
>> Spaces instead of tab before 'compatible', should be consistent with the
>> remaining properties of pioA node.
>>> +                    reg =3D <0xfffff200 0x100>;
>>> +                    interrupts =3D <6 IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                    #gpio-cells =3D <2>;
>>> +                    gpio-controller;
>>> +                    interrupt-controller;
>>> +                    #interrupt-cells =3D <2>;
>>> +                    clocks =3D <&pioA_clk>;
>>> +                    bootph-all;
>>> +                };
>>>   -            pioB: gpio@fffff400 {
>>> -                compatible =3D "atmel,at91sam9x5-gpio", "atmel,at91rm92=
00-gpio";
>>> -                reg =3D <0xfffff400 0x100>;
>>> -                interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH 1>;
>>> -                #gpio-cells =3D <2>;
>>> -                gpio-controller;
>>> -                interrupt-controller;
>>> -                #interrupt-cells =3D <2>;
>>> -                clocks =3D <&pioB_clk>;
>>> -                bootph-all;
>>> -            };
>>> +                pioB: gpio@fffff400 {
>>> +                      compatible =3D "atmel,at91sam9x5-gpio", "atmel,at=
91rm9200-gpio";
>> Ditto
>>> +                    reg =3D <0xfffff400 0x100>;
>>> +                    interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                    #gpio-cells =3D <2>;
>>> +                    gpio-controller;
>>> +                    interrupt-controller;
>>> +                    #interrupt-cells =3D <2>;
>>> +                    clocks =3D <&pioB_clk>;
>>> +                    bootph-all;
>>> +                };
>>>   -            pioC: gpio@fffff600 {
>>> -                compatible =3D "atmel,at91sam9x5-gpio", "atmel,at91rm92=
00-gpio";
>>> -                reg =3D <0xfffff600 0x100>;
>>> -                interrupts =3D <8 IRQ_TYPE_LEVEL_HIGH 1>;
>>> -                #gpio-cells =3D <2>;
>>> -                gpio-controller;
>>> -                interrupt-controller;
>>> -                #interrupt-cells =3D <2>;
>>> -                clocks =3D <&pioC_clk>;
>>> -                bootph-all;
>>> -            };
>>> +                pioC: gpio@fffff600 {
>>> +                      compatible =3D "atmel,at91sam9x5-gpio", "atmel,at=
91rm9200-gpio";
>> Ditto
>>> +                    reg =3D <0xfffff600 0x100>;
>>> +                    interrupts =3D <8 IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                    #gpio-cells =3D <2>;
>>> +                    gpio-controller;
>>> +                    interrupt-controller;
>>> +                    #interrupt-cells =3D <2>;
>>> +                    clocks =3D <&pioC_clk>;
>>> +                    bootph-all;
>>> +                };
>>>   -            pioD: gpio@fffff800 {
>>> -                compatible =3D "atmel,at91sam9x5-gpio", "atmel,at91rm92=
00-gpio";
>>> -                reg =3D <0xfffff800 0x100>;
>>> -                interrupts =3D <9 IRQ_TYPE_LEVEL_HIGH 1>;
>>> -                #gpio-cells =3D <2>;
>>> -                gpio-controller;
>>> -                interrupt-controller;
>>> -                #interrupt-cells =3D <2>;
>>> -                clocks =3D <&pioD_clk>;
>>> -                bootph-all;
>>> -            };
>>> +                pioD: gpio@fffff800 {
>>> +                      compatible =3D "atmel,at91sam9x5-gpio", "atmel,at=
91rm9200-gpio";
>> Ditto
>>> +                    reg =3D <0xfffff800 0x100>;
>>> +                    interrupts =3D <9 IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                    #gpio-cells =3D <2>;
>>> +                    gpio-controller;
>>> +                    interrupt-controller;
>>> +                    #interrupt-cells =3D <2>;
>>> +                    clocks =3D <&pioD_clk>;
>>> +                    bootph-all;
>>> +                };
>>> +
>>> +                pioE: gpio@fffffa00 {
>>> +                      compatible =3D "atmel,at91sam9x5-gpio", "atmel,at=
91rm9200-gpio";
>> Ditto
>>> +                    reg =3D <0xfffffa00 0x100>;
>>> +                    interrupts =3D <10 IRQ_TYPE_LEVEL_HIGH 1>;
>>> +                    #gpio-cells =3D <2>;
>>> +                    gpio-controller;
>>> +                    interrupt-controller;
>>> +                    #interrupt-cells =3D <2>;
>>> +                    clocks =3D <&pioE_clk>;
>>> +                    bootph-all;
>>> +                };
>>>  =20
>> Extra line
>>> -            pioE: gpio@fffffa00 {
>>> -                compatible =3D "atmel,at91sam9x5-gpio", "atmel,at91rm92=
00-gpio";
>>> -                reg =3D <0xfffffa00 0x100>;
>>> -                interrupts =3D <10 IRQ_TYPE_LEVEL_HIGH 1>;
>>> -                #gpio-cells =3D <2>;
>>> -                gpio-controller;
>>> -                interrupt-controller;
>>> -                #interrupt-cells =3D <2>;
>>> -                clocks =3D <&pioE_clk>;
>>> -                bootph-all;
>>>               };
>>>                  pmc: pmc@fffffc00 {
>=20
