Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14864C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 12:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D255869F7;
	Wed,  3 Jan 2024 13:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nTBf7dDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE42874AC; Wed,  3 Jan 2024 13:44:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 166D486758
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 13:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704285875; x=1704890675; i=xypron.glpk@gmx.de;
 bh=zx0c+x7z/647To9ROoPcuQ7bfpL1cBiiElj+R4cZf7o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=nTBf7dDiqeoKbpF0pntpbOM4edoaKse0D+gqbfOt3b7vmK1lm/d7XLP+LJTggpQk
 j5tAkiCUDrit/Adv7cG/SrWVTAj0mWXvszNrfuwZVdjuTA9inXDens5fWRe0+spTC
 3Xmi2Mrva1/W77Onhnr8cYq4W09QTIK/j9Bu8HqcB3BrckT199pvwyX9x3IfxtaC0
 ScIg7V3P50lardthM0XYtpls3QN9rqaVSrNqheHcZ1LshAi1bvuKBkSIdEegP8m5K
 49PNqgM+0VjppzFP+5jOc4QEm9PeMjj0fnzMLUHpFNaJ8SMU8MR+YG1m5DlYoC++Q
 HB+R2giYeO4MyobvzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1qq5h432FV-00muLn; Wed, 03
 Jan 2024 13:44:35 +0100
Message-ID: <5e0b7365-0c81-4f5c-b2fe-96e3cc2a576a@gmx.de>
Date: Wed, 3 Jan 2024 13:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Passing boot logs to Linux?
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Daniel Golle <daniel@makrotopia.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <ZYH-K_UGat0yWMVH@makrotopia.org>
 <CAPnjgZ3sNBuaNkbTF2d=E2JD4sQOaA5QRfzDfz1KSV==nOWbTw@mail.gmail.com>
 <514fe736-5122-41f2-bb1b-ee1a42ec2cb2@gmx.de>
 <f78b464a-5d9f-4552-bd2f-700a0cbe3ddf@prolan.hu>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <f78b464a-5d9f-4552-bd2f-700a0cbe3ddf@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3efGw059554E7prZU6dn/gEHaD/VDzxbUEdQJW4Lbrf4vExqlE+
 6acjg5m2gU9r5BGBvdikP4gMQFkvDX9tZpYtzEm3/izz8bss6BqWRpu/h8ymugpUiQ9Oibg
 992ur5jZT2yqLsCpXj4tt13hzpcneRmPblpuo+WHg19xCzwVng8lHx+WpNXwkqD1HdU0CRh
 CmfQh5RgNpZu4It9rqhtw==
UI-OutboundReport: notjunk:1;M01:P0:kUV0CTHnbGE=;EdmmbD920mzkfCV4sEmbcXYe9vj
 TmtAE6xJ8Cb1N5J0VJXgvUYUIKJ8ToSyP+DuBNEo0BH4TFFtwrudeeyuS0ctrYzdv4viY0KlW
 YrBu/jAbQ61ysJvaj6lIYiIJnPKlu9zEMpmPrNi+f7vUSg21oVB1r9qiqOQ2hB7qalnpaSSR+
 bWiCHghcun8rPPJcef0WaT6jIay7k8v75RwUyHn/EXR7rTODCq/s+ro7ocuaBU5qb8sVAa8Ia
 Z9ZiXg3VQD8XvYirZvTLhYuuTIG3ggLOUADT52n/IQmW9IQG8V9kVNUfGrNq3jWpowjYLw90y
 Jvrf4qKKlDaRkaUJAa2CSrCU7LMiIM5Trwi8n0a+XdXTvp5WfTqr3ZBa2NBlN4j+gwbLp6GdZ
 lzTvY9ZCxbCV8pgeLGugPB3iXJM3Qnw4ZYJph3Gj6HaT8HJVVLjo6Rlj48vbZOtEiLYb8SxwZ
 WI5pI9JqfObghDj7TY8gmfrZbQdxJsdJfRYhytkJ84vwQbiO8gZzRI4sfl13r81DkSNAkWUyL
 szQZWi1LzavvNPIBA2ax8S4jrfIxZiOdPtsBTEpsfOmONdcyJwXlJJH0t2gfO5dP/romjfU6d
 RSR8U/pUejRgWMStYvijPbwZG03mAQhK9iT4megHcH3GPh1oiEqxAax0jPJWF4e456wPBpTss
 M4GHNMM7CyJS4T033Tt/xVFHR0gR370ivq3sBN5jc6NSG9F/kG3PnIIgPCq37VhuUMbWMJjNG
 SdF5RlhBknIAjhJ5wQf0jzFXF8kppkidwkHP84Ji7NrHNKj+Snbl5ArMm/6QY1jjB20TQ5cgm
 dMpi8pIE9HsY22lDbkl+Nw3rWMUYlXrF+xu5SU7WQE4/Mifrhp4tq2mfXWeQfv1EnaeaO5+dX
 27CBGr9FT30MTnFkWYjggwm/djmtp5ShXoTw3xCdacfVSNbSGM5AB9AoGAqBWaZLYP8gHqZws
 xxzBZK9+K83sxwLeuKmXtp70k+o=
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

On 03.01.24 11:11, Cs=C3=B3k=C3=A1s Bence wrote:
> Hi,
>
> 2023. 12. 31. 0:54 keltez=C3=A9ssel, Heinrich Schuchardt =C3=ADrta:
>> On 12/20/23 05:11, Simon Glass wrote:
>>> +Heinrich Schuchardt
>>>
>>> On Tue, 19 Dec 2023 at 13:33, Daniel Golle <daniel@makrotopia.org>
>>> wrote:
>>>>
>>>> Hi Bence,
>>>>
>>>> On Tue, Dec 19, 2023 at 08:08:48PM +0000, Cs=C3=B3k=C3=A1s Bence wrot=
e:
>>>>> Hi!
>>>>>
>>>>> Is passing the U-Boot boot log to Linux supported yet? We are workin=
g
>>>>> with a third-party solution, which works, but is a bit hacky, so I w=
as
>>>>> wondering if an official solution has been merged yet.
>>
>> U-Boot supports writing log messages to an rsyslog server via broadcast
>> to UDP port 514 (CONFIG_LOG_SYSLOG=3Dy).
>>
>> The device name can be set via environment variable log_hostname.
>>
>> If you have a log server for your devices in the same network segment,
>> you can consolidate all your logs there.
>>
>> A driver writing log messages to a file could be created in U-Boot.
>
> I am aware, however, this is not what we want to do right now. We want
> to pass the logs to the booted up OS on the *same* machine.
>
>>>>> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>>>>> everything to a membuff, but I don't know if that can be exported to
>>>>> Linux yet. And if not in the tree yet, would such a patch be welcome=
?
>>
>> It is not enough to export a memory buffer. There must be support in th=
e
>> operating system to read it.
>
> Of course. But it should be trivial to add a driver to Linux and other
> FOSS OSes to support reading these records from memory.

Please, have a look at Linux'

Documentation/admin-guide/ramoops.rst
Documentation/devicetree/bindings/reserved-memory/ramoops.yaml

If U-Boot had a log driver writing to the ramoops buffer we would not
need any change in Linux.

The current U-Boot drivers are

common/log_syslog.c
common/log_console.c

Best regards

Heinrich

>
>> Linux supports the common platform error record (CPER) format defined i=
n
>> the UEFI specification. See
>>
>> * https://www.dmtf.org/sites/default/files/PMCI_CPEREvent_Proposal_v3.p=
df
>
> According to page 16, records can be of the following types:
> * error, recovered
> * previous error
> * simulated error
>
> There is no type that is an operational condition (even though you can
> append informational sections to an error record). So what we could do
> is mark everything as "recovered", but that is misleading, booting is
> not an "error condition".
>
>  > *
> https://uefi.org/sites/default/files/resources/Spike%20Yuan-%20Server%20=
RAS%20and%20UEFI%20CPER_final.pdf
>
> This looks like some promo material, not very useful from an
> implementation standpoint. Plus, this talks about Intel-based cloud
> computing/HPC, not exactly the embedded systems we are targeting.
>
>> Boot errors can be reported via the ACPI BERT table. But that won't hel=
p
>> you in OpenWRT which uses device-trees.
>
> Exactly. I would avoid depending on ACPI/UEFI. Having a simple in-memory
> struct can be supported on all platforms, even without ACPI, UEFI,
> writable filesystem, even DT is not needed if you can pass the base
> pointer to the OS via other means (ie. command line).
>
>> Best regards
>>
>> Heinrich
>
> Bence
>

