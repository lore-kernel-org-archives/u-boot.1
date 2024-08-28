Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108D0C54E65
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 16:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3170E885D1;
	Wed, 28 Aug 2024 18:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HVPmNxj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04E8988744; Wed, 28 Aug 2024 18:15:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692228817C
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4830=P4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1724861739;
 bh=VenEX1+lw0zorfhOxcPOHbtuthAc2qkbYBSr6EfkZXE=;
 b=HVPmNxj0hs5NbPfGxe0YCYJ6h84COXsdSlwdHSVL3nky56fwjV6s60yH1uteotQrUIHGLnO8N
 b/D4HOCwhFyZ9gpX1OD6rhUz8HoLwBB+3GdxWAnvugbmOklB0iNEvk4IgjRx7L9pTc/nhUHvf+4
 QQDafsyV7WCBTFyBZ4US9yVDhPNklPBbMbSprUogBY0W+zIkNW4kdURqQ7UolZCycgjjNtaGG7x
 OkQwdNkAy1+Ja12kFp7EtvbI74GpaNg7d62HemY681E7Y7+MaY2jqrQkbKHcIwL7L8lUVanwjMW
 +mkzM/ZSHUx0vu4ydsVbUMDYYGw+4aS1aGTZ1AjpfUDw==
Message-ID: <0329ee07-3f99-4daf-8960-1e934ff753de@kwiboo.se>
Date: Wed, 28 Aug 2024 18:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] bootstage: Do not sort records
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-3-jonas@kwiboo.se>
 <CAFLszTha39GkRsZA1r91YpLdKJDiRfDmAzWsMTuByDtPC0YvGQ@mail.gmail.com>
 <CAFLszThNN-rfPtAYKSHtGTEUwuxFgz01A-yJMXRYtwX3WiA-Kg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszThNN-rfPtAYKSHtGTEUwuxFgz01A-yJMXRYtwX3WiA-Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66cf4d28012215edd67a9ed3
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

Hi Simon,

On 2024-08-28 18:01, Simon Glass wrote:
> Hi Jonas,
> 
> On Tue, 6 Aug 2024 at 15:50, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Jonas,
>>
>> On Sat, 3 Aug 2024 at 06:42, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>
>>> The timer counter on Rockchip SoCs may be reset in TF-A, this may cause
>>> the bootstage records to be printed out of order and with an incorrect
>>> elapsed time.
>>
>> Eek can we just fix TF-A? That seems like a bug.

TF-A is vendor blob, so we have no control of it.

>>
>>>
>>> Fix this by not sorting the bootstage records.
>>>
>>> Before on a Radxa ZERO 3W (RK3566) board:
>>>
>>>   => bootstage report
>>>   Timer summary in microseconds (12 records):
>>>          Mark    Elapsed  Stage
>>>             0          0  reset
>>>         7,436      7,436  board_init_f
>>>       164,826    157,390  SPL
>>>       375,392    210,566  end phase
>>>       423,909     48,517  board_init_r
>>>       472,973     49,064  eth_common_init
>>>       476,848      3,875  main_loop
>>>       477,003        155  cli_loop
>>>
>>>   Accumulated time:
>>>                    7,181  of_live
>>>                   14,739  dm_spl
>>>                   15,029  dm_r
>>>                  315,150  dm_f
>>>
>>> With this the records can be printed in chronological order when the
>>> counter is reset and SPL and board_init_r records show correct elapsed
>>> time.
>>>
>>>   => bootstage report
>>>   Timer summary in microseconds (12 records):
>>>          Mark    Elapsed  Stage
>>>             0          0  reset
>>>       164,437    164,437  SPL
>>>       375,023    210,586  end phase
>>>         7,437      7,437  board_init_f
>>>       424,390    416,953  board_init_r
>>>       473,515     49,125  eth_common_init
>>>       477,402      3,887  main_loop
>>>       477,571        169  cli_loop
>>>
>>>   Accumulated time:
>>>                   14,734  dm_spl
>>>                  315,646  dm_f
>>>                    7,339  of_live
>>>                   14,977  dm_r
>>>
>>> For the tested board external TPL and BROM take ~164 ms to initialize
>>> DRAM and load SPL, SPL take ~210ms to load images from FIT and U-Boot
>>> proper take ~477ms to reach cli prompt.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>  common/bootstage.c | 12 ++----------
>>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>>
> 
> To put this more strongly, this breaks the timing output on other boards.

Please elaborate, I cannot understand why not sorting would break output
on other boards, are other boards adding records out of order?

Do you have an example of how this change break other boards?

> 
> At the very least, this should be Kconfig option just enabled for
> boards with a broken ATF.

I can add a Kconfig option, but would like to understand why other/any
board would need to sort the records in the first place.

Regards,
Jonas

> 
> Regards,
> Simon

