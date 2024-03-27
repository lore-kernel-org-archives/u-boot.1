Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72728C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD3A87E47;
	Wed, 27 Mar 2024 12:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tz5jQtMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC2718803A; Wed, 27 Mar 2024 12:24:48 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04BF98780A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 12:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab23=LB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1711538675;
 bh=FTHESGklJxoh3TU1I6ZL4yQrUta0zpYK0x6vU0dxaYI=;
 b=tz5jQtMIdCLNPFYiyDpCIItGwWvOk7G0X//pUzLbM+So4C6K9GW7oSLWuWq8Rm2Iue4wLtQ9g
 frKd/9TbXvdSznOBRkFb8JH2Duq7iWNHyQH8PtQ8hm4gJlqryK5DK40aH7HevRzCH8SLpiAM2wi
 t5KU49MoBlnIaTMXI5CMPnaqpa1alsRz5Bf4eLxXrPK1+8vpFEisjqDKL/LyWf1Yzh1ZJRHcuGf
 M4wcwQDW/zvH8vPt14rJjrZ6X7rtqz0Kb1gAHy7m1tN8mRfC/8dlXp6U8Z7BpHyRQagxnjKY9ST
 r96EtZH/b9EM+jO+9p2qRzREh4XZ+stlu0gvt5ZGGcSA==
Message-ID: <21e01d83-7f64-4b57-8ead-35a909b7216b@kwiboo.se>
Date: Wed, 27 Mar 2024 12:24:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rockchip_sdhci: Revert 4 blocks PIO mode read limit
 for RK35xx
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240326233502.2625015-1-jonas@kwiboo.se>
 <a162464f-8cf6-4229-9062-f1369769af20@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a162464f-8cf6-4229-9062-f1369769af20@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 660401f2a890af8ec6d1c76c
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

Hi Quentin,

On 2024-03-27 09:56, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/27/24 00:35, Jonas Karlman wrote:
>> The commit 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks
>> read in a single command") introduced a limit of number of blocks to
>> read to fix a Data End Bit Error on RK3568 and RK3588. This had a side
>> affect of significant slowing down reading FIT from eMMC.
>>
>> After the commit 6de9d7b2f13c ("rockchip: rk35xx: Enable eMMC HS200 mode
>> by default") the limit of number of blocks to read workaround is no
>> longer necessary and a Data End Bit Error is no longer happening using
>> PIO mode.
>>
>> Revert this limitation to allow reading more than 4 blocks with a single
>> CMD18 command in PIO mode and speed up reading FIT from eMMC.
>>
> 
> Should we instead keep this code but surround it with
> #if !IS_ENABLED(MMC_HS200_SUPPORT)
> ?
> 
> After all, HS200 is only implied for RK35xx boards, so one could disable it.

I do not think this will be necessary, for RK3568 the PIO mode is not
needed at all and SDMA is used. And not 100% sure if it was the HS200 or
bss address change, or a combo of both that fixes the Data End Bit Error.
Or could also be that it was the DDR52 mode that caused issues.

Will re-try with normal HS mode and see if any hack is still needed at
all.

> 
> Also wondering whether we should do this dynamically based on the MMC 
> mode that could be negotiated with the chip? E.g. I think it's not 
> guaranteed that with hs200 support built and enabled in DT that it'll be 
> negotiated as HS200?

Last time I checked this there was no easy way to change number of
blocks to read at time using current mmc/sdhci ops, and I do not think
there is enough need to add new ops. However, if we still need a
workaround it should be changed to use a bounce buffer instead of limit
number of blocks to not affect performance, similar to [1].

[1] https://patchwork.ozlabs.org/patch/1895377/

Regards,
Jonas

> 
> Cheers,
> Quentin

