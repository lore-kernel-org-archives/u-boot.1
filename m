Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A82CC3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A3388763;
	Mon,  8 Jul 2024 16:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720448145;
	bh=hQ4bYX6cjK/zNJe3A8TwfcFx6I9mBFpd9U/Xp4EXN0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wjxTj3kZmQDmti3uFRgtZs4wTrAxWO/E2x+8DiX0q0j9gZWM2gTd/4TNGRd4gV5Hy
	 yx4rqpKEwbX2SudAZCagIwnjQERiMX29Nvq6kdnnN6KPiIPO3IwrmPfqKtcfgz/e+K
	 sFVbcesnYxFIdKm7umUTtJm5f13CWvx6HWrnTFohIafX98HvmH+u7PBRzNqs/mYMP2
	 kgpqD0KvLdkNH1s0HE7PM7xdcrk614FpkYerXjlMNpasjOkkvEoRAI6UrqTdNdi3YX
	 Nct6E74LErWUonFxC0qMrFvevLrcYGhKgCIFVbYEe5ScAolTfuGfVY3PiR3AGiul8v
	 kAIZ+GsqjSvRg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74DE8877E; Mon,  8 Jul 2024 16:15:44 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575D588756
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4WHmP76GCkz9tT0;
 Mon,  8 Jul 2024 16:15:39 +0200 (CEST)
Message-ID: <964a1d18-0ab6-4605-a8b7-96fdca8c9fe3@denx.de>
Date: Mon, 8 Jul 2024 16:15:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: dts: mvebu: Update DTS for Thecus N2350 board
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20240610003431.14148-1-mibodhi@gmail.com>
 <2f5754a5c9f50ed735d80153f1e72082@manjaro.org>
 <CAJaLiFwLYFoRsewPi=ZEUQ8eRCH3aC1ubqcO0FTjHs9A85sKTA@mail.gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <CAJaLiFwLYFoRsewPi=ZEUQ8eRCH3aC1ubqcO0FTjHs9A85sKTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/11/24 23:42, Tony Dinh wrote:
> Hi Dragan,
> 
> On Sun, Jun 9, 2024 at 6:07 PM Dragan Simic <dsimic@manjaro.org> wrote:
>>
>> Hello Tony,
>>
>> Please see a few comments below.
>>
>> On 2024-06-10 02:34, Tony Dinh wrote:
>>> - Change the spi-max-frequency to 50000000 (50 Mhz). According to the
>>> data sheet[1], the MX25L3205D max frequency is 86 Mhz. Using 50 Mhz in
>>> the DTS to ensure u-boot is consistent with what Linux kernel expected.
>>> - Update GPIO fan to conform to the latest DT binding.
>>
>> There's no need for the bullet points, plain prose will do fine instead.
> 
> I like bullet points :) All my patch descriptions have bullet points
> when there are 2 or more different items.
> 
>>
>>> [1]
>>> MX25L3205D-MX25L1605D-MX25L6405D-Macronix-MX25L3205DM2I-12G-datasheet.pdf
>>
>> Unless you can provide a real, working URL for the datasheet, this
>> reference
>> should actually be deleted.
> 
> It was my oversight. That should have been this URL:
> 
> https://www.macronix.com/Lists/Datasheet/Attachments/8575/MX25L3205D,%203V,%2032Mb,%20v1.5.pdf
> 
> I'll wait for Stefan to review the patch and let him decide whether I
> should send in a V2 patch or he will modify the commit description.

I've changed the commit message accordingly.

Applied to u-boot-marvell/master

Thanks,
Stefan


> Thanks for the comments!
> 
> All the best,
> Tony
> 
>>
>>> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>>> ---
>>>
>>>   arch/arm/dts/armada-385-thecus-n2350.dts | 10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/armada-385-thecus-n2350.dts
>>> b/arch/arm/dts/armada-385-thecus-n2350.dts
>>> index 253cf01130..fdaa444e51 100644
>>> --- a/arch/arm/dts/armada-385-thecus-n2350.dts
>>> +++ b/arch/arm/dts/armada-385-thecus-n2350.dts
>>> @@ -2,7 +2,7 @@
>>>   /*
>>>    * Device Tree file for Thecus N2350 board
>>>    *
>>> - * Copyright (C) 2018-2023 Tony Dinh <mibodhi@gmail.com>
>>> + * Copyright (C) 2018-2024 Tony Dinh <mibodhi@gmail.com>
>>>    * Copyright (C) 2018 Manuel Jung <manuel.jung@hotmail.com>
>>>    */
>>>
>>> @@ -143,9 +143,9 @@
>>>        fan {
>>>                compatible = "gpio-fan";
>>>                gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
>>> -             gpio-fan,speed-map = <    0  0
>>> -                                     600  1
>>> -                                     3000 2 >;
>>> +             gpio-fan,speed-map = <    0  0>,
>>> +                                     <600  1>,
>>> +                                     <3000 2 >;
>>>                pinctrl-0 = <&pmx_fan>;
>>>                pinctrl-names = "default";
>>>        };
>>> @@ -415,7 +415,7 @@
>>>                compatible = "jedec,spi-nor";
>>>                reg = <0>;
>>>
>>> -             spi-max-frequency = <108000000>;
>>> +             spi-max-frequency = <50000000>;
>>>                spi-cpha;
>>>
>>>                partition@0 {

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
