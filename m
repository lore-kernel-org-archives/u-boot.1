Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97D606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DQ/pCLl5;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=mY/8yRc2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5543C80EA0;
	Sat, 21 Nov 2026 19:47:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LiKpQHJgUjKe; Sat, 21 Nov 2026 19:47:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0710A80E65
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795290420;
	b=RQ8ftGVl/Q/L7vfjZ3QBOPNmsn1KILG7AETWXyo8voqPdRXkofYKNMq5fxcu8sa2K7Ed
	 qoIXhsL39VKcd5UYKkbkpNi//ZW/+QS9wGY8GBrnf33v0E/RDowKqvgowh9yxUbllIwTk
	 SsFvWpo1O0Uikgy7P39sSuTYJJYWwZdkf5lP5QrDwT3Z8pno9pSEsHK1QmAM8xH6Oz4OT
	 PUb/hwRyRtPQqtyirvYMNEDy+as+BKD+nGmt9O7l5pX3zlKIxK5oo56fx2h7knIpsTgZe
	 kbneBt7HFja5V/1ZBd+pcg5dozCV0u+btof3fKJvuHnsRpqeNerCcODg5kRFGCvg4KA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795290420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1KBgcxXFShdGH3mZOAX17zuKRp2xoshitGyJ1oZzKik=;
	b=aAYqcPypAAl1zjLiAcOsu3Lis8+yv+P02rsbVYOO9z0H3cftHX0X+w3QPnD3HYt2dYah
	 IUaqpWc7ULk0OA49e3psYxeSHZcv/EkEVMCXfjcntv+FAEujCqUsnuJH1GRwNzMj+Lv4z
	 VCo9X4LB67zJj7ixvTQFwne2lmXzdkDYqjY0RLo4TEeHk+nZ+Bhnvjom4qOcPKilgPA82
	 Rc/JYE+kiOEzhj1onZHGDKoMolWyxHELnlVZgiq4OiCpEXbSpqaOlFd2QbKAtnIoUgwgl
	 ClRjLrC81VGW9auLq8JB1+675ZG0pRv7ojygpgfQm4zFmLYm7xIHLE7s6JSkNGDLRhw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795290420;
	bh=1KBgcxXFShdGH3mZOAX17zuKRp2xoshitGyJ1oZzKik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DQ/pCLl5/0eTx6EbzNvX+cFzNZxptPuHB1kLIJnB3XeAOWyfZylnF/tix8KRvGO2E
	 tYbQ5h6L/mfIM7RdAw6WnTu5qQg+zlfl9j9g/x0DSZejVqQ1yoywmMG1oxivaOhW/Q
	 iZd5PkjRlPVSmWMisGxWWoUs96uuXC00ZQIbIqord/nzMbNpdCP9OotEwK4wN1q3fq
	 nBAu2VL8IAaiZxF3nOVKZkprjnYpQBg+Sn27uXM0aZy0i7wrlDb7uT/3XB+AKjxzjp
	 w95akzxQ81wRp/v7thLXqKuyYkThPjoMh+z3SEEh8xsi7+v93Je9iZSDZ6IbW3/Gnj
	 KmOd6r4ZmeR8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0710A80E65;
	Sat, 21 Nov 2026 19:47:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7A7515D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 19:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4947406D8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 19:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E4E2tNucCooz for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 19:46:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 64D4E40555
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=mY/8yRc2
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64D4E40555
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 19:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795290402;
 bh=1KBgcxXFShdGH3mZOAX17zuKRp2xoshitGyJ1oZzKik=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mY/8yRc22sI7JIx/OtFbdeSVvrFQh9LXbJS1/t1+6KK/IeOaEoQ9LvHZBy+9EYpk3
 dDmzQEKrNavXI3uV95zBBaINj3Jly/ZhEvWnNWOyd4Yse6IYHuBeJ0DaWOXXaQWWg4
 AA3HsCeGKAyRYnmoxRaQslUfGJpIclmX/P0dmC544iU/v7X7Ouko/A51OnSvnjuIWp
 Hyd9ZUHobG9HtBOXqFXzf7dA2UEO+xTEpij61MF/wHszHFun3WSfbYss+rMPG7PZMT
 ndQLLkZzGvk+l6sNToD/j+2TKREaN2nKmOPJ98780A0fbmm98zww/SOBUAohDOwNpX
 P73XE/Aok6xdQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id D9F2FB2202FE;
 Sat, 21 Nov 2026 20:46:40 +0100 (CET)
Message-ID: <192bfe30-329a-4e2e-803d-5d41c5483b1f@freeshell.de>
Date: Sat, 21 Nov 2026 11:46:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: spacemit: k3: reduce clock tree for SPL build
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261103-01-k3-clock-spl-support-v2-1-09a0b28e902f@kernel.org>
 <20261121030534-GKB156439@kernel.org>
 <530bc058-178e-4181-920c-b5319e48ada2@freeshell.de>
 <20261121095817-GKA203137@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261121095817-GKA203137@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/21/26 01:58, Yixun Lan wrote:
> Hi E Shattow, 
> 
> On 00:03 Sat 21 Nov     , E Shattow wrote:
>> On 11/20/26 19:05, Yixun Lan wrote:
>>> Hi All,
>>>
>>>
>>> On 11:07 Tue 03 Nov     , Yixun Lan wrote:
>>>> Due to SPL image running in a memory space constraint SRAM environment,
>>>> so reduce the whole clock tree a bit to make it fit for final runtime
>>>> requirement, only a subset clock tree is registered, which includes UART,
>>>> SDHCI, I2C (TWSI), and their PLL/MPMU/APMU/APBC ancestors; while the
>>>> full clock tree is retained in non-SPL build.
>>>>
>>> I'd like to drop or postpone this patch for now, the goal was trying
>>> to reduce the code size of clock driver especially for SPL phase which
>>> both target for persistent NOR flash storage and run-time memory consumption
>>>  space.. but tested on actual board found, there is enough space.. so
>>> leave it as is for now
>>>
>>
>> For persistent NOR flash storage support the FSL SPI driver needs
>> updated in u-boot from mainline Linux. There's some lesser improvements
>> to it in u-boot now that probably need discussed and sent to Linux as well.
>>
> I'm not aware there is specific SPI changes needed for SPI NOR flash..
> 

There is a driver wrapper in Linux drivers/spi/spi-spacemit-k1.c
matching on compatible "spacemit,k1-spi" specified in spacemit/k3.dtsi

>>>
>>>> Where surviving SPL CCU definitions reference parent clocks outside
>>>> that subset tree, it will use "clock-dummy" as name of clock parent to
>>>> ensure the framework still successfully resolves the parent clock lookup.
>>>>
>>> For above using "clock-dummy" clock, will send a separate patch for it,
>>> so will fix the unresolved clock tree warning..
>>>
>>>> Signed-off-by: Yixun Lan <dlan@kernel.org>
>>>> ---
>>>> Changes in v2:
>>>> - add gpio clock
>>>> - fix tswi8 clock
>>>> - enable sdh0 clock
>>>> - Link to v1: https://patch.msgid.link/20260825-01-k3-clock-reset-support-v1-6-c430253e759c@kernel.org
>>>> ---
>>>>  drivers/clk/spacemit/clk-k3.c | 209 ++++++++++++++++++++++++++++++++++++++----
>>>>  1 file changed, 190 insertions(+), 19 deletions(-)
>>>>
>>>
>>> ...
>>>
>>
>> FYI not including clock tree reduction or parent dummy clock
> No need above patches, so that's fine
> 
>> substitution, for what I understand the "bsp-spi" reduced vendor SPL
>> build I document at:
>>
>> https://lore.kernel.org/u-boot/20261029003327.1890979-1-e@freeshell.de/
>>
>> ...fails to detect SPI NOR flash when K3 SoC has ran in BootROM SPL
>> Loader "UART" mode;   It is successful when ran in BootROM SPL Loader
>> "USB" (fastboot compatible) mode. There is some peripheral setup done by
>> the BootROM code in one or the other that persists through and should be
>> considered when testing. I would guess that re-sync of the source code
>> in u-boot for FSL SPI driver from mainline Linux, and port of the
>> SpacemiT K1/K3 specific FSL SPI glue code, would be a next step to
>> getting working SPI flash from within u-boot main app u-boot.itb
>>
> Could you check if below patch will fix your problem? which I've just
> sent out
> https://patch.msgid.link/20261120-05-fsl-qspi-clock-v1-1-bacea4ebd54b@kernel.org
> 

I will reply your patch to follow up after some testing. Thanks!

>> What SPL build are you using for testing?
>>
> I have some local patches those not have significant changes, and about
> to send them out soon..
> 

-E
