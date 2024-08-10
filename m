Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DFCC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 13:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34FF388861;
	Sat, 10 Aug 2024 15:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="g9A7SOSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41EA08826E; Sat, 10 Aug 2024 12:14:20 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C67768843A
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 12:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723284856; x=1723889656; i=fiona.klute@gmx.de;
 bh=lN2G4I9gahqzK/NGqrTQIFl7isb5i7Q4Rzj7COphlCw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=g9A7SOSXx20zjalydsNX9Pk5Qrlq8FA8rDKARpFTWcz/mGvm/vMyBnY5totfygF4
 0VHcfIjXt6Kv0RKKXKz7wryxQ5NS49XkQMRRkEjW6YO5PCP+1GmoM7vW0AHJlHnEP
 q4x/3wEaXy3kBaNNzsF6R1TI21UZQlFhCw39Gcfj4zdG62XGwH00EdfNilwCNFnAd
 iLCrPcG/bZiTp3Z1NjNjX+mI9QCcZFddMpzMmY/en+CUzXqZtjuD7/853XmHBgEfX
 SPj5bwKAphDbRCR3f/OU6kUCA00fk1m7jsKphuvYN/3bxIgGUaYroiMBJNa8FyHaS
 KxlESgjpGbB8dNSX5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.126.226]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqaxU-1rqPqy2jfU-00peUf; Sat, 10
 Aug 2024 12:14:16 +0200
Message-ID: <71004240-eca8-48f9-8fb0-153d5b3cf7c6@gmx.de>
Date: Sat, 10 Aug 2024 12:14:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Selecting serial device for console
To: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de
References: <75114aa0-2de7-4f5c-b764-0953ebf08263@gmx.de>
 <CAFLszTh2Am1AuROKKwBr6zCNF4QCZQG2Vd88R2WWYFpGkMwjzQ@mail.gmail.com>
 <87frrhcmeb.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThXn0HGj9kEhOaMxcG41tQGR8103waUOmT9ZYk3pcELHw@mail.gmail.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <CAFLszThXn0HGj9kEhOaMxcG41tQGR8103waUOmT9ZYk3pcELHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i95lqC4QOqIlS+GUMwRuqTwuMen/R/eNqeW32gvrFZRpxsEmiZO
 lcDrtjHPA09+/6+TdlrbuZWizI96VQU6J/whnOpTq+L86S7mC2xJAOgTMXQwm5oC5hgOZYy
 w9V4mEnLG53KniBMGBiJLnlMTtT8VOQSPySXZP/daln+6rWEhxN7Mmegf3fWxejEwcNyi8f
 P2Ytk+M2BR9QTqmN73NUw==
UI-OutboundReport: notjunk:1;M01:P0:Fip16Uj4Ln4=;IKO5VSctG8q1ltBMvMbUY/t/p1I
 J2vyz5frQWIRUkEyDHV8ZlF3FqPxH3eMI4LdhrF1Y4n6QYBB6W2Mme6xOyamce6lhGi8iPlr9
 zUM1DkGSXGOT6vy9ZrHZFmOUvyWvegpYt+k1/gWRSM790/ibDcO1SNaeHoCXL1NDHw2r6no24
 G9f6hoQnHI/Srju2wsDjg2k05Vylyfo37CncenAwukv/hlmodMUfsbCIJ970PGlIMOqhFLM/X
 +YN59TSOUNtbjt6tX2Lkmw0slLHoJiOHsuT7SFA6fbS9nEAMnLB6/DiIcYz3eShdzdDlc8mlX
 Y8eGSwrEkX+d9ESu8GkNIN1ZDQtY7NTRGsUPnJLu8gyN0LpwdtdM1H5PmuJEenaEImrgaR+Mz
 ANw6OQaaaFs8PuE5Otqzjp7f3DF09gHroYaupP+etg8H6W6u6raLXACE+0Ghf/KUzQUa1Xifi
 iIkzpFmZl2bhJ0jGMoHagCyhy0AIHLx4Nq+JkLX6nR5InossHntNnvY+a2mtzO8fQ4ujA6X04
 A78dhpv2MZC5N+MdwxICStxMhn3OBNVe/2NVrfWcrZ8rMx6OXUfphlkd7FxlPNluH4OS6mwgh
 XN0ITMLJZ1ppn7HbEzomJhYoxgyX3PCyb3F7R7ZRv5kV18mywc7E3V/ja5F6tWOyrabpg9mZC
 jBXcoRU/CfUXOSaQ8TDfEiDHkn96sp+jfMkibSbA9hPF79jYLFQKGxNpwMlVfJhtZfzJ6+64L
 BlTEJuvvD73IjJR2tkzp3KL+Hv2O2EnQKc93rc6655ia0lWzPZnA32zppkDdxyFstlDR5Btd5
 Azg+Lc0vni9MWj/2RvpANhXg==
X-Mailman-Approved-At: Sat, 10 Aug 2024 15:39:58 +0200
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

Hi Simon, Mark,

thanks for your replies!

Am 08.08.24 um 16:28 schrieb Simon Glass:
> Hi Mark,
>
> On Tue, 6 Aug 2024 at 16:33, Mark Kettenis <mark.kettenis@xs4all.nl> wro=
te:
>>
>>> From: Simon Glass <sjg@chromium.org>
>>> Date: Tue, 6 Aug 2024 15:50:44 -0600
>>
>> Hi Simon,
>>
>>> Hi Fiona,
>>>
>>> On Thu, 1 Aug 2024 at 08:07, Fiona Klute <fiona.klute@gmx.de> wrote:
>>>>
>>>> Hi everyone,
>>>>
>>>> how can I configure which of the available serial devices U-Boot will
>>>> use for its serial console?
>>>>
>>>> Background: I have a device based on a Raspberry Pi CM4, which has 6
>>>> UARTs (UART1 is a mini UART, the others PL011) [1]. In the default
>>>> configuration (including the mainline Linux broadcom/bcm2711-rpi-cm4-=
io
>>>> device tree) the Bluetooth module is attached to UART0. Unless I eith=
er
>>>> completely disable UART0 (status =3D "disabled" in the device tree) o=
r
>>>> reconfigure it to be a serial console (e.g. using the RPi disable-bt
>>>> DTBO) U-Boot fails to boot, I assume (it doesn't get far enough to sh=
ow
>>>> messages over netconsole) because it tries and fails to set up a seri=
al
>>>> console where there's a BT chip listening.
>>>>
>>>> That happens even if another serial console is available: With the RP=
i
>>>> bcm2711-rpi-cm4 DTB plus "disable-bt" (disable the Bluetooth module,
>>>> reconfigure UART0 as a serial console) and "uart1" (set up a serial
>>>> console on UART1) DTBOs I can see that U-Boot discovers the serial
>>>> device on UART1 (serial@7e215040):
>>>>
>>>> U-Boot> dm uclass serial
>>>> uclass 108: serial
>>>> 0   * serial@7e201000 @ 3af3b200, seq 0
>>>> 1     serial@7e215040 @ 3af3b2d0, seq 1
>>>>
>>>> However, I can't find a way to make it *use* it instead of UART0
>>>> (serial@7e201000). I tried to set CONFIG_CONS_INDEX=3D1 but didn't se=
e any
>>>> change (unfortunately the help does not describe exactly how the numb=
er
>>>> is mapped to DT UART definitions). If I completely disable UART0 in t=
he
>>>> DT as mentioned above U-Boot uses UART1 just fine, so it's not an iss=
ue
>>>> with UART1 as such.
>>>>
>>>> To make matters slightly more complicated, the specific device I have=
 is
>>>> a RevPi Connect 4, where a vendor overlay [2] describes how to set up=
 an
>>>> RS485 serial console using UART5. The pins defined there are wired to
>>>> the outside of the box [3], so eventually I'll actually want to use
>>>> UART5 for the serial console. Which means I really need a (build-time=
 or
>>>> preferably DT-based) way to configure which serial device to use.
>>>>
>>>> My goal is to create a single DTS which both U-Boot and Linux can use=
,
>>>> and get it upstreamed if possible. If there are configuration options
>>>> and they're just missing from the documentation, I'd be happy to send=
 a
>>>> patch to add them once I have a solution.
>>>
>>> You should be able to update /chosen/stdout-path (in the devicetree)
>>> to specify the UART you want, using its alias. So if you have a
>>> 'serial1' alias, you can set stdout-path to 'serial1'. This should
>>> work in Linux too.
>>>
>>> The code in question is serial_find_console_or_panic().

I can see there that it *should* be using the serial device from
/chosen/stdout-path with CONFIG_OF_CONTROL=3Dy (which I have set), but if
I set it in the described form (alias to UART5:baudrate, I can share my
DTS if that helps) U-Boot doesn't start. Unfortunately without the
console it's hard to see *why*, I'll have to see if anything appears if
I connect an HDMI display.

In general, should U-Boot be able to use an RS485 output via UART
configured via DT (like [1]), or would I need to do board-specific
config for that? With the RevPi Connect 4 device I have it's the only
serial console that's accessible without opening the box. I have also
noticed that both drivers/serial/serial_bcm283x_mu.c and
drivers/serial/serial_bcm283x_pl011.c contain some odd checks on whether
a serial UART is usable as a console, but I'm not sure if they'd
interfere here (because GPIO 15 is part of the RS485 setup).

>> While this may reflect how modern Linux handles things, this doesn't
>> actually make a lot of sense to me.  And the clue is really in the
>> name of the node under which the stdout-path resides.  That property
>> is supposed to communicate to the OS what the firmware/bootloader
>> picked as the console device rather than indicate to the
>> firmware/bootloader what the console device should be.  This was how
>> things worked back in the days of OpenFirmware where the firmware
>> would pick an input and an output device based on firmware variables
>> and whether a keyboard was plugged in or not and would set "stdin" and
>> "stdout" properties under /chosen to reflect the choice made by the
>> firmware.
>>
>> With this in mind it would make total sense to have U-Boot set
>> /chosen/stdout-path based on some environment variable or other
>> information.  Of course it might still make sense that the device tree
>> used by U-Boot sets /chosen/stdout-path to indicate the default choice
>> for the console device.  But it doesn't make senso to me to tell users
>> that if they want to use a different console device they should go and
>> edit the device tree...

In general I agree, on RPi-based devices having the bootloader apply DT
overlays is pretty normal though (whether that's a good idea may be up
for debate). That said, another issue I see is that U-Boot seems to fail
to boot without a valid serial console even though
CONFIG_REQUIRE_SERIAL_CONSOLE is not set. If I had a way around that
it'd be enough for my immediate issue, even though a working serial
console would be very much preferable. ;-)

Best regards,
Fiona

[1]
https://gitlab.com/revolutionpi/linux/-/blob/4ae9a35871799004300f83694a243=
59a7b4ef8fa/arch/arm/boot/dts/overlays/revpi-connect4-overlay.dts#L281-292

