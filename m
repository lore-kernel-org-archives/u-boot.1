Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9B1C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 05:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A07809D4;
	Fri, 25 Apr 2025 07:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570FA810EB; Fri, 25 Apr 2025 07:39:29 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FD08059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 07:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1u8BmV-0004c1-TN; Fri, 25 Apr 2025 07:39:23 +0200
Message-ID: <5f87ac88-5552-4c5c-ae56-01c7ef9165dd@pengutronix.de>
Date: Fri, 25 Apr 2025 07:39:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Expected behavior of the go command
To: "Kumar, Udit" <u-kumar1@ti.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, rick@andestech.com,
 mporter@konsulko.com
References: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
 <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
 <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
 <5934ae86-16e8-4c97-afd6-d812fc0c5f7f@ti.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <5934ae86-16e8-4c97-afd6-d812fc0c5f7f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Udit,

On 25.04.25 06:35, Kumar, Udit wrote:
> 
> On 4/23/2025 7:52 PM, Ahmad Fatoum wrote:
>> I went with the FIT route for barebox, because we can now ship device
>> trees for all enabled boards in the same FIT image alongside one generic
>> second stage barebox with DT support. If you want to support different
>> boards with your OS image that might be of interest to you as well.
> 
> Sorry for novice question.
> 
> But trying to understand how FIT fixes problem for you .
> 
> at the end, its a jump command to OS/other code be it through u-boot go or fit way.

The difference is whether, prior to the jump, the caches are flushed and the MMU
is disabled and U-Boot's go does neither.

Thinking about it, I am wondering whether U-Boot go is inherently broken,
even for the jump-table use case, if caches are enabled:
Because go doesn't do any cache maintenance, what guarantee do we have
that the I-Cache actually reflects the data that was freshly loaded?

It might only work because the region you go to happens to not be resident
in the I-Cache yet...

FWIW, barebox go does cache maintenance and disables the MMU, which
is why I mistakenly thought U-Boot's go would behave similarly.
barebox didn't inherit the jump table mechanism.

> In case OS/other code handles caches, then should not be an issue.
> But this put requirement on next stage to take care of caches [0]

In the fit case, MMU is disabled and so the next stage is free to
not do any cache maintenance if it doesn't need to enable the MMU.
Linux and barebox want to use the MMU/caches by default, so that's
why they have to do cache maintenance.

If they assume MMU is disabled on startup, it follows the lines in
the cache are stale and unimportant and then memory corruption
occurs once they are discarded.

Cheers,
Ahmad

> 
> 
> [0] : https://github.com/torvalds/linux/blob/master/arch/arm64/kernel/head.S#L105
> 
> 
>>
>> Cheers,
>> Ahmad
>>
>>> Regards,
>>> Simon
>>>
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
