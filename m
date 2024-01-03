Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BA2C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 12:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6A6C86A81;
	Wed,  3 Jan 2024 13:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 933D986758; Wed,  3 Jan 2024 13:51:39 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18DBF86758
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 13:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1rL0ia-0001b2-7f; Wed, 03 Jan 2024 13:51:32 +0100
Message-ID: <858bd861-5bbb-4956-8af2-c4d4033a92a3@pengutronix.de>
Date: Wed, 3 Jan 2024 13:51:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Passing boot logs to Linux?
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Daniel Golle <daniel@makrotopia.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <ZYH-K_UGat0yWMVH@makrotopia.org>
 <CAPnjgZ3sNBuaNkbTF2d=E2JD4sQOaA5QRfzDfz1KSV==nOWbTw@mail.gmail.com>
 <514fe736-5122-41f2-bb1b-ee1a42ec2cb2@gmx.de>
 <f78b464a-5d9f-4552-bd2f-700a0cbe3ddf@prolan.hu>
 <5e0b7365-0c81-4f5c-b2fe-96e3cc2a576a@gmx.de>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <5e0b7365-0c81-4f5c-b2fe-96e3cc2a576a@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hi,

On 03.01.24 13:44, Heinrich Schuchardt wrote:
> On 03.01.24 11:11, Csókás Bence wrote:
>> Hi,
>>
>> 2023. 12. 31. 0:54 keltezéssel, Heinrich Schuchardt írta:
>>> On 12/20/23 05:11, Simon Glass wrote:
>>>> +Heinrich Schuchardt
>>>>
>>>> On Tue, 19 Dec 2023 at 13:33, Daniel Golle <daniel@makrotopia.org>
>>>> wrote:
>>>>>
>>>>> Hi Bence,
>>>>>
>>>>> On Tue, Dec 19, 2023 at 08:08:48PM +0000, Csókás Bence wrote:
>>>>>> Hi!
>>>>>>
>>>>>> Is passing the U-Boot boot log to Linux supported yet? We are working
>>>>>> with a third-party solution, which works, but is a bit hacky, so I was
>>>>>> wondering if an official solution has been merged yet.
>>>
>>> U-Boot supports writing log messages to an rsyslog server via broadcast
>>> to UDP port 514 (CONFIG_LOG_SYSLOG=y).
>>>
>>> The device name can be set via environment variable log_hostname.
>>>
>>> If you have a log server for your devices in the same network segment,
>>> you can consolidate all your logs there.
>>>
>>> A driver writing log messages to a file could be created in U-Boot.
>>
>> I am aware, however, this is not what we want to do right now. We want
>> to pass the logs to the booted up OS on the *same* machine.
>>
>>>>>> I saw that there was an option CONFIG_CONSOLE_RECORD that saves
>>>>>> everything to a membuff, but I don't know if that can be exported to
>>>>>> Linux yet. And if not in the tree yet, would such a patch be welcome?
>>>
>>> It is not enough to export a memory buffer. There must be support in the
>>> operating system to read it.
>>
>> Of course. But it should be trivial to add a driver to Linux and other
>> FOSS OSes to support reading these records from memory.
> 
> Please, have a look at Linux'
> 
> Documentation/admin-guide/ramoops.rst
> Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> 
> If U-Boot had a log driver writing to the ramoops buffer we would not
> need any change in Linux.
> 
> The current U-Boot drivers are
> 
> common/log_syslog.c
> common/log_console.c

Yes, that's what I would suggest as well. For reference, barebox supports
pstore with ramoops backend to share its dmesg buffer with Linux.
You can take a look there for pointers. The code may not directly
portable to U-Boot though barebox implements pstore as a file system.

The problem of interactive console I/O filling up the log is resolved by having
only logged output (pr_info, dev_info and friends) output to pstore and
plain printf only prints to enabled serial consoles.

Cheers,
Ahmad

> 
> Best regards
> 
> Heinrich
> 
>>
>>> Linux supports the common platform error record (CPER) format defined in
>>> the UEFI specification. See
>>>
>>> * https://www.dmtf.org/sites/default/files/PMCI_CPEREvent_Proposal_v3.pdf
>>
>> According to page 16, records can be of the following types:
>> * error, recovered
>> * previous error
>> * simulated error
>>
>> There is no type that is an operational condition (even though you can
>> append informational sections to an error record). So what we could do
>> is mark everything as "recovered", but that is misleading, booting is
>> not an "error condition".
>>
>>  > *
>> https://uefi.org/sites/default/files/resources/Spike%20Yuan-%20Server%20RAS%20and%20UEFI%20CPER_final.pdf
>>
>> This looks like some promo material, not very useful from an
>> implementation standpoint. Plus, this talks about Intel-based cloud
>> computing/HPC, not exactly the embedded systems we are targeting.
>>
>>> Boot errors can be reported via the ACPI BERT table. But that won't help
>>> you in OpenWRT which uses device-trees.
>>
>> Exactly. I would avoid depending on ACPI/UEFI. Having a simple in-memory
>> struct can be supported on all platforms, even without ACPI, UEFI,
>> writable filesystem, even DT is not needed if you can pass the base
>> pointer to the OS via other means (ie. command line).
>>
>>> Best regards
>>>
>>> Heinrich
>>
>> Bence
>>
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

