Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CBFCDD54F
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 17:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 325878884F;
	Wed, 18 Sep 2024 19:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jz2pCsxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F139D88F64; Wed, 18 Sep 2024 19:25:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E1338876E
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 19:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=11d5=QR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726680298;
 bh=bC4p/AUlbE+lBDbE9lyk1xTUxmzt2fORK/SIXpttTSU=;
 b=jz2pCsxaWMQppIm7TtbrfV7RSP6h3MmTRf58vs/GXEQqXHddBSMC556d6+/6IV1NihaMRHXR7
 EqEuM/EwsPNCcSw4Vg3A5t52m6hMTvZ0Znz30rBPCYLfYGmm4NMUhwJBWhYR+AF099AsowgRZYq
 KY/6XGp4HeTQHphw5HbEQFmS9czEDQtNt/k2Q7dBkOmCGd+Wd5AmUsUWSoNupf4NKPs96h/zBlU
 MzAxFAgfvZGAdHxqfxVh+2oDI7QDvdCT3doXW9ST/q/LOmYLuLTKYteIfxPcZN6m8c3fzTfGSyq
 RJY0f8t64PKY70PsWPZu6lQwKH11e0/4xHIDIE7vdTJQ==
Message-ID: <085e72b7-840f-4db5-b93a-81df98bb1c20@kwiboo.se>
Date: Wed, 18 Sep 2024 19:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Soeren Moch <smoch@web.de>, Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240905151707.59101-1-sebastian.reichel@collabora.com>
 <c208f28d-86e0-41b2-9d37-45de423e30b3@kwiboo.se>
 <3kyh6fd4edev55q3e63ixaa4f6vgf4moqfxqdpvyrxt26x6xvy@yvk4boehfing>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3kyh6fd4edev55q3e63ixaa4f6vgf4moqfxqdpvyrxt26x6xvy@yvk4boehfing>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66eb0cea4b792c206cbd00ea
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

Hi Sebastian,

On 2024-09-18 11:41, Sebastian Reichel wrote:
> Hi Jonas,
> 
> On Wed, Sep 18, 2024 at 09:56:35AM GMT, Jonas Karlman wrote:
>> On 2024-09-05 17:08, Sebastian Reichel wrote:
>>> On ROCK 5B power is usually supplied via it's USB-C port. This port has the
>>> data lines connected to RK3588, VBUS connected to the input regulator and
>>> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
>>> accessed via I2C from RK3588. The USB-C controller is needed to figure out
>>> the USB-C cable orientation, but also to do USB PD communication. Thus it
>>> would be great to enable support for it in the operating system.
>>>
>>> But the USB-PD specification requires, that a device reacts to USB-PD messages
>>> send by the power-supply within around 5 seconds. If that does not happen the
>>> power-supply assumes, that the device does not support USB-PD. If a device
>>> later starts sending USB-PD messages it is considered an error, which is solved
>>> by doing a hard reset. A USB-PD hard reset means, that all supply voltages are
>>> removed for a short period of time. For boards, which are solely powered
>>> through their USB-C port, like the Radxa Rock 5B, this results in an machine
>>> reset. This is currently worked around by not describing the FUSB302 in the
>>> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
>>>
>>> 1. the USB-C port cannot be used at all
>>> 2. the board will be running via fallback supply, which provides limited
>>>    power capabilities
>>>
>>> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, so
>>> that we react to the power-supply's queries in time. The code, which is
>>> originally from the Linux kernel, consists of two parts:
>>>
>>> 1. the tcpm state machine, which implements the Type C port manager state
>>>    machine as described in the USB PD specification
>>> 2. the fusb302 driver, which knows about specific registers
>>>
>>> Especially the first part has been heavily modified compared to the
>>> kernel, which makes use of multiple delayed works and threads. For this
>>> I used a priorly ported version from Rockchip, removed their hacks and
>>> any states not necessary in U-Boot (e.g. audio accessory support).
>>>
>>> This version has been tested on Radxa Rock 5B using the open source TF-A
>>> (patches recently got merged into master branch) using the following power
>>> supplies:
>>>
>>>  * non PD capable (reports 5V 0A)
>>>  * RavPower 90W
>>>  * UGREEN 100W
>>>  * Anker 45W
>>>  * RavPower PB
>>>
>>
>> [snip]
>>
>> This series look good and works great on my ROCK 5B, tested using two
>> different PD capable power supplies, so this entire series is:
>>
>> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Thanks.
> 
>> I did notice that trying to hook up the ROCK 5B from my computer to use
>> UMS in U-Boot there is a slight delay at boot and following is shown:
>>
>>   fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
>>
>> I suspect this work as intended, so nothing blocking.
> 
> Yes. These potential delays are the reason why I only wanted to
> enable this for affected boards.
> 
> I suppose we can try to get rid of the error message for the case
> of not having PD at all.

Not sure we need to do this, was just something I noticed for one of the
tests I typically perform when a board has an usb gadget port in U-Boot.

> Note, that a standard compliant USB port
> (limited to 500mA [USB2] or 900mA [USB3]) is not good enough to
> power the Rock 5B since cpufreq got enabled. the Rock 5Bs in
> Collabora's KernelCI farm were originally powered through a USB
> hub and the hub powered the port off during boot after applying
> the cpufreq patches. So the error might be useful to understand
> why there are boot issues.

My test/use-case only involve U-Boot and using one of the UMS or RockUSB
features to read/write from/to storage from a host computer, e.g. write
u-boot-rockchip.bin or a rootfs to eMMC or NVMe storage.

The ROCK 5B only seem to use/peek around 400mA until U-Boot cli and
around 750-900mA after "pci enum", so using the USB3 port on my host
computer for this test/use-case is fine.

When booting into and running Linux I always ensure to use a proper
power supply for the board :-)

Regards,
Jonas

> 
> Greetings,
> 
> -- Sebastian

