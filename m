Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298AAFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538188437C;
	Tue, 28 Apr 2026 05:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gmTZWbAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA78084355; Tue, 28 Apr 2026 05:49:05 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9350284378
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ehristev@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1183941698;
 Mon, 27 Apr 2026 20:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01381C19425;
 Mon, 27 Apr 2026 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777322560;
 bh=ULU7/020lYNV8r2EGNMj/eYO2bZw/vEX80gDQzdNxAk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gmTZWbAHlwOx5A3Tj2mLJ9O8fHMJ3Gbe0r3nqxRDN+o2Pv6jpUmjdXEEkQKbOvxiZ
 rAds/T10yxXWsBNsY6lkDNR7MY7SIDzMsqDEshutSRhw1fhMdxydU6UF8/4ytUPuxs
 1c+yNjd4UvWZAXQoLMX8yh2GqFzWiqv4VOOiKrGmyZpl4YHUu15Sfme02lS8iPfprP
 /4yqeM7asUj5PxQ/ajpTVNl6osM5Ylh9GLx7igursh6lff+CdKR6y1tsFAjCW4rVph
 t8E8r0Wx+yv5pB9WQV+tAub+wFpZgCAW3B3j/5Pf1006txxB7rXLt9/Q2m/wH7PLnn
 JrGdc2OXtTK+Q==
Message-ID: <f406c931-a28a-4015-95d5-36fbed54154d@kernel.org>
Date: Mon, 27 Apr 2026 23:42:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] serial: atmel-usart: allow selecting from
 ARCH_MICROCHIPSW
To: Robert Marko <robert.marko@sartura.hr>
Cc: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com, 
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com,
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com,
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com,
 luka.perkov@sartura.hr
References: <20260326112830.313874-1-robert.marko@sartura.hr>
 <3d5c0942-93a4-4a0d-a272-932ff86d2da2@kernel.org>
 <CA+HBbNErDg5-_xX8qg0JES1bxVmgxOA81JDqRwQwAN-M+odAdA@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <CA+HBbNErDg5-_xX8qg0JES1bxVmgxOA81JDqRwQwAN-M+odAdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/27/26 12:56, Robert Marko wrote:
> On Sat, Apr 25, 2026 at 3:35 PM Eugen Hristev <ehristev@kernel.org> wrote:
>>
>> On 3/26/26 13:26, Robert Marko wrote:
>>> USART driver is reused by a lot of Microchip platforms, in this case we
>>> need it for LAN969x so allow selecting it when ARCH_MICROCHIPSW is used.
>>
>> Hello Robert,
>>
>> I apologize for not replying to this sooner, but my old email address
>> was bouncing.
>>
>> I did not find any information(or cover letter), about this series,
>> because it looks like you are sending this on top of something else,
>> which is not merged yet.
>> I am not familiar with ARCH_MICROCHIPSW which is not in Uboot.
>> Can you please clarify ?
> 
> Hi Eugen,
> ARCH_MICROCHIPSW is not yet in U-Boot, but its being added via the
> same series patch series.

This is the first patch in the series, adding a dependency to a knob not
yet added.
I would expect a first patch that would introduce this ARCH.

Please add changes in a logical manner to make some sense

Thanks

Eugen

> 
> Its the new arch that will hold LAN969x for start, but other Microchip
> switch SoC-s in future as well.
> 
> Regards,
> Robert
>>
>> Sorry again,
>> Eugen
>>
>>>
>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>> ---
>>>  drivers/serial/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>>> index b84cb9ec781..3848c3ca20e 100644
>>> --- a/drivers/serial/Kconfig
>>> +++ b/drivers/serial/Kconfig
>>> @@ -665,7 +665,7 @@ config ARM_DCC
>>>
>>>  config ATMEL_USART
>>>       bool "Atmel USART support"
>>> -     depends on ARCH_AT91
>>> +     depends on ARCH_AT91 || ARCH_MICROCHIPSW
>>>       help
>>>         Select this to enable USART support for Atmel SoCs. It can be
>>>         configured in the device tree, and input clock frequency can
>>
> 
> 

