Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C9E95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05AB286DC5;
	Sat,  7 Oct 2023 23:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n98EVjYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0463386DE3; Sat,  7 Oct 2023 23:35:54 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 397FC86DB8
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S2z9s01Hxz9scY;
 Sat,  7 Oct 2023 23:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvRIQINfs9ubQM2f7pRx60SPrzC/0ATM3AV88NQL/Po=;
 b=n98EVjYSb5KANTLmh6LUeXjBIgHBMOb3gl1P5n+Tjpah7KzcuJ9La+l7QbjOkGxJ70df+P
 kcyzYvKAErqAvRnb18LcV5MnKNPA8GncI//mr5crXC6uYpr4TG56p6grzk5mPYe71gXFeg
 vhmcyaBdyeg/stgRKUXDUD/k+M1bn8RNQ069pQARdFCtied1MIo3u9u37w8vwEd8rWxM/Y
 BKgKIZS2iQJPQIfSGUGkR8iZ4Ver522g3Ei+bsC8NWm4zs7xAhcGcqORMbAszetbFJ4VDv
 iAIiPoRzXBDBITGoQkX81+W7KHoG9Few5NXMc7ZbI4zm/9OO/eGV8RqgnkMs8w==
Message-ID: <8e04236c-a262-41e3-b891-5b22afcbd86f@mailbox.org>
Date: Sat, 7 Oct 2023 23:14:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
 <94bd4c16-67c4-828d-7eb2-fe6a68df4800@mailbox.org>
 <68462bfa-c11a-8e21-7fc5-21bb9af9ccd9@bp.renesas.com>
 <8cd7a684-3e5e-4bd4-bab4-796502935d83@mailbox.org>
 <20231004134308.oaeqeolblr4ex2l5@GBR-5CG2373LKG.adwin.renesas.com>
 <9893a1f5-b085-46f7-a694-f186ab764cd2@mailbox.org>
 <20231004163858.zeuxy64olun5iini@GBR-5CG2373LKG.adwin.renesas.com>
 <1bdc45f0-8c32-4347-b238-c6ee8037f620@mailbox.org>
 <6514beaa-6584-84de-883a-69933e0f54db@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6514beaa-6584-84de-883a-69933e0f54db@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 94251a03a33a95a245c
X-MBO-RS-META: zb7kx7zrkman3ecqaqws696mn14d9n97
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

On 10/5/23 14:08, Paul Barker wrote:
> On 04/10/2023 20:41, Marek Vasut wrote:
>> On 10/4/23 18:38, Paul Barker wrote:
>>> On Wed, Oct 04, 2023 at 05:17:55PM +0200, Marek Vasut wrote:
>>>> On 10/4/23 15:43, Paul Barker wrote:
>>>>> On Wed, Oct 04, 2023 at 02:26:49PM +0200, Marek Vasut wrote:
>>>>>> On 10/4/23 10:48, Paul Barker wrote:
>>>>>>> On 03/10/2023 14:23, Marek Vasut wrote:
>>>>>>>> On 9/20/23 14:42, Paul Barker wrote:
>>>>>>>>> Extend the existing driver to support the SCIF serial ports on the
>>>>>>>>> Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that the
>>>>>>>>> relevant reset signal is de-asserted before we try to talk to the SCIF
>>>>>>>>> module.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>>>>>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>>>>>>>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>>>>>>> ---
>>>>>>>>>       arch/arm/mach-rmobile/Kconfig |  1 +
>>>>>>>>>       drivers/serial/serial_sh.c    | 32 ++++++++++++++++++++++++++++++--
>>>>>>>>>       drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
>>>>>>>>>       3 files changed, 49 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
>>>>>>>>> index 973e84fcf7ba..0ab22356aee5 100644
>>>>>>>>> --- a/arch/arm/mach-rmobile/Kconfig
>>>>>>>>> +++ b/arch/arm/mach-rmobile/Kconfig
>>>>>>>>> @@ -77,6 +77,7 @@ config RZG2L
>>>>>>>>>       	imply RENESAS_SDHI
>>>>>>>>>       	imply CLK_RZG2L
>>>>>>>>>       	imply PINCTRL_RZG2L
>>>>>>>>> +	imply SCIF_CONSOLE
>>>>>>>>>       	help
>>>>>>>>>       	  Enable support for the Renesas RZ/G2L family of SoCs, including the
>>>>>>>>>       	  the RZ/G2L itself (based on the R9A07G044 SoC).
>>>>>>>>> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
>>>>>>>>> index 5e543dbf3d58..a2e9a57137a6 100644
>>>>>>>>> --- a/drivers/serial/serial_sh.c
>>>>>>>>> +++ b/drivers/serial/serial_sh.c
>>>>>>>>> @@ -17,6 +17,8 @@
>>>>>>>>>       #include <linux/compiler.h>
>>>>>>>>>       #include <dm/platform_data/serial_sh.h>
>>>>>>>>>       #include <linux/delay.h>
>>>>>>>>> +#include <dm/device_compat.h>
>>>>>>>>> +#include <reset.h>
>>>>>>>>>       #include "serial_sh.h"
>>>>>>>>>       DECLARE_GLOBAL_DATA_PTR;
>>>>>>>>> @@ -79,8 +81,16 @@ sh_serial_setbrg_generic(struct uart_port *port, int clk, int baudrate)
>>>>>>>>>       static void handle_error(struct uart_port *port)
>>>>>>>>>       {
>>>>>>>>> -	sci_in(port, SCxSR);
>>>>>>>>> -	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
>>>>>>>>> +	/* The RZ/G2L datasheet says that error conditions are cleared by
>>>>>>>>> +	 * resetting the error bits in the FSR register to zero.
>>>>>>>>
>>>>>>>> Can you be more specific here ?
>>>>>>>>
>>>>>>>> It doesn't seem Linux sh-sci.c driver does anything special for G2L, so
>>>>>>>> is this special case really needed ?
>>>>>>>
>>>>>>> On page 1268 of the datasheet (R01UH0914EJ0130 Rev.1.30):
>>>>>>>
>>>>>>> "DR is cleared to 0 when DR = 1 is read and then 0 is written to the DR
>>>>>>> flag."
>>>>>>>
>>>>>>> On page 1270:
>>>>>>>
>>>>>>> "[Clearing condition]
>>>>>>> ● When 0 is written to ER after it has been read as 1"
>>>>>>>
>>>>>>> So zeros must be written to clear these errors, not ones.
>>>>>>>
>>>>>>> We have an open task to investigate the issue in the Linux driver and
>>>>>>> fix it.
>>>>>>
>>>>>> Is the G2L UART broken in Linux ?
>>>>>
>>>>> Likely yes, but we need to reproduce the issue.
>>>>>
>>>>>> Does it misbehave in U-Boot ?
>>>>>
>>>>> Yes, before I changed this, if a framing error occurred it could never
>>>>> be cleared and the serial port stopped sending/receiving data.
>>>>>
>>>>> The framing error was triggered by accident by unnecessarily re-doing
>>>>> pinmuxing for the serial port after TrustedFirmware had already set it
>>>>> up correctly. Since SCIF0 is wired to an FTDI USB/serial adaptor chip on
>>>>> the SMARC carrier board, it seems very difficult to trigger a framing
>>>>> error in any other way, the FTDI chip is too well behaved.
>>>>
>>>> Is it possible to trigger this on RZ/G2<non-L> with SCIF on those platforms
>>>> as well ?
>>>
>>> It's not been seen or reported to my knowledge, but it's on our list to
>>> look into further.
>>
>> Can you give it a quick try ? I'd really like to avoid G2L specific
>> behavior here if it can be avoided.
>>
>> Is there a testcase ?
> 
> 
> The case we're interested in here is the Receive Error (ER) & Break
> Detect (BRK) conditions. I've done some further datasheet digging...
> 
> RZ/G2L datasheet says these are cleared by writing zero to the
> appropriate bits of the FSR register.
> 
> RZ/G2{H,M,N,E} datasheet says the same (pages 50-18 & 50-19 of
> R01UH0808EJ0111 Rev.1.11).
> 
> The R-Car Gen3 Hardware Manual says the same (pages 55-18 & 55-19 of
> R19UH0105EJ0230 Rev.2.30).
> 
> For R-Car S4, there is an Excel spreadsheet attached to page 105-5 of
> the datasheet (R19UH0161EJ0100 Rev.1.00) which again says the same.
> 
> For R-Car V4H, the relevant info is on pages 105-16 & 105-18 of the
> datasheet (R19UH0172EJ0081 Rev.0.81) and says the same.
> 
> On the RZ/G2L I was able to reproduce a break condition by changing
> pinmux settings after the SCIF interface has been configured. You could
> try this out on an R-Car system, but I don't think it's guaranteed to
> cause a break condition, it may depend on how the port input is
> implemented in those SoCs. From my reading, the only guaranteed way to
> cause a break condition is to hold the Rx signal low, and you might need
> to solder on some extra wires on to a board to be able to do that.

Can't you simply send a BREAK from terminal program ?
In minicom, I think that's meta-F B .

> We should still fix the error handling here, even if the boards we have
> don't easily cause Receive Errors or Break conditions, other folks may
> have their own boards based on these SoCs.
> 
> If you're happy I'll go ahead and check IS_ENABLED(CONFIG_RCAR_64) here
> instead of IS_ENABLED(CONFIG_RZG2L).

Based on the input I am getting from you here, it seems to me we should 
just use the G2L case as the common case for all systems, without any 
special casing, right ?
