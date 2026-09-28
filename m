Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6593C9832F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A4CB6067D;
	Mon, 28 Sep 2026 09:45:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKklm0yUwi28; Mon, 28 Sep 2026 09:45:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3D02C60684
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790588756;
	b=jIMgTWpEbVYTL4rJ2rfME7psZh2V3lu0hRZ4Qy5Y3g7E2sXpfPlnQ7fPRiaS/fljeP02
	 4g2vJcjfxUJM2piZfP4ODW+Y4vkJpi2E1wHJm0RsXsV5+UdCL952AxuVTDIzt+if+Hk6z
	 QaWNMMq/txC72hcnzU2G4gwJFq7FxDpW+dDBG0CNYIIBvORJ4O0wQDvVKcuV21D9tPKE2
	 o84avjrDeZAcioCTnp24cZgWCqMls7qW9HH+QkOQTINCH7Y1G2fDcubF1MaT3tFwN9QWV
	 ADnI8a1qKZcThDhVRApUFXbICTzTDVGiVgzyTOBOYrbH3LdAZX0GK3zWQKeaLZPGVrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790588756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K93sondT4Tc5Y5JmK4NTf1+glz/v7M/RdYQdwnXkLQ0=;
	b=D51h6S3/fK2g/qH/PbGPhPvoNrcc5cuXKwQx4nWJMDsvcupTSCLAv/RWYtD5fTtIwumu
	 9T/8Um19ft0Giryk8aQD2vCj5lU2FPXiDsqXHoOOePM7iG0jpg2IBTCOAcZS4fFP31y1o
	 F3wpWSc6LMNPcqXNf3wbuY9WKsgQeJ508USnJYzlzfM+3LckoIOY25POY6RxeYQl2xHLB
	 cJJ2cu6sqNkzTxomfQ2CU6Y04NEjcOT48M+fVbHI1LoGrklgR+SijCnoHWFd7ClnH3gR/
	 zpwrkug/all62NujXh2u+Vm6pNQX5UlLx8nZHBeP/MA0B3daFuY6VDMmmL4KJI8W8Mw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=K4+iCTOm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790588756;
	bh=K93sondT4Tc5Y5JmK4NTf1+glz/v7M/RdYQdwnXkLQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GvLzo5hyB0bjvRe4QGA/RxoTDPJSFVjImbWekzFE7DDPAy9xQJFV5WIe9+TysgW1U
	 EJZdx+8yxFA5UYT9PgkVZ5igcEfqXpqUvO3ul1Q2Gzzzu2X/cIknnFtZvJJRc11tam
	 cSEx+1hZXNgwp1bP5zEjBdRCBhwvd11ZTZdJwmwRnMLtJk+J0u+D/xdHH277Pzy6cs
	 aZpudmREwgNkdxhx8Jh/aSlnRS6VBkm4/OeJflN/HXN1zrTR1oPGQtf8oYVo0P4I9a
	 ZMr6L9mbihOiaSR0fP1Egqxw7xk27FYKdpJeFHZZnFTaN4fg5/Sl4wF2nvThuIQg7T
	 59uKkVkvbSy8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D02C60684;
	Mon, 28 Sep 2026 09:45:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A5592B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 730D060684
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KQ-9QJhQ1mk for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 47CCA6067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790588753;
 b=NLTh3gvF1WHGIVKD8EyH7K4OeVBQF3LnC7M36NvVSoq7GX+4CkQ1jjnUFOo8OCYagWGj
 Zh6SSof+w7j7t0Kqj9a7l5/fY09KMoWp3Hme0cxKFjg07sV6yr5n203KPIsEECp7yuVnM
 srjuaTc2nYfD0BysghWg0jAWchfdiDvE+MYSvfsliQQ5bmRgP25LZc+EPUTQPjzTejNOl
 PZTMDzxjfL+x4VEK/J8eDeLl4UMWw3Fmqw0L67sxVB5RWDd7kf0lSa9tLTL+2aqswgR64
 xcdUSng1HfYkjpY5vYpe4TbGfODJLoBcsCf9O5YxHWxzwE+bQ77AcnzbGvFdDGDPSBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790588753;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=K93sondT4Tc5Y5JmK4NTf1+glz/v7M/RdYQdwnXkLQ0=;
 b=iG/+wXLr6IWwaCL00R7REclmsEaXUrzdiSBZXOy7tsufKTodrTonF2ftLl6Q9jk9JVEN
 bGO6GHaapOAM5JLJDQzmLmsMWSl25NeUxNQ7Yunp/7YaLaeHx93PRxGcL83lKQ0Zp1vtm
 Mu1/WW0Kc0yMDlobo31t7lR+OXjsLCdJe9NY6ddWrofUXeCve5B9GOH0IdcpAsCcbjBga
 KYL3xYOfW3Bd0x8ObP/YiQTaUfSHoJVYH6r30PjDKaPFEjmnE/JTbkhIp5tHtp+IlWt5m
 +Y5EA+tdv6KVCMTOW/ZdkteiPGTr7Z8VD6ZgPXAqrwimD34XWwcZVjArk5/guDna7rA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=K4+iCTOm; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c238=hu=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=K4+iCTOm
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47CCA6067D
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1790588750;
 bh=K93sondT4Tc5Y5JmK4NTf1+glz/v7M/RdYQdwnXkLQ0=;
 b=K4+iCTOmeXmFNYDmBQdcJXivHRGbc96EC36LQsur15zbsqfA9GxtGkWAQucZvlhK+a0Fyx4P6
 FDJucgN6DUG91RGzu93NxeWysjE91IEMeuvvndDWRLlL0F1hWmmc0VOnL+0S2qniD9TDYxZ1CTT
 uh1mDxUMd8GgD5iVeKNgqCIf2ZwkPpa5nkYrn4uyM3vzWBS3x6pi5d7HTI6LuKvyP8ehfNiT3oO
 2pIMEMS6Wt+E4wNvb3iIUR7oW1HSnwYam+2G3ELj3ZHauBsLCdve4aQ9N20b4KhesSfTPtBgvdz
 VeQbdCid2I8Ag9gPVMbUNUxLob2TJ0rhV8wDGAegw6yw==
X-Forward-Email-ID: 6aba374c7c3fbae63f6c714b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.16.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8cedbdae-157c-47ec-b890-821d14c25c5d@kwiboo.se>
Date: Mon, 28 Sep 2026 11:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
 <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
 <CAC928Ha1qR66Cryg9VXwuTTBSgmPPDnbpiahUB8toRt=scfd=g@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAC928Ha1qR66Cryg9VXwuTTBSgmPPDnbpiahUB8toRt=scfd=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

On 9/26/2026 8:17 PM, Massimo Pegorer wrote:
> Hi Jonas,
> 
> On 8/4/2026 9:57 PM, Jonas Karlman wrote:
>> Hi Simon,
>>
>> On 8/4/2026 9:19 PM, Simon Glass wrote:
>>> Hi Jonas,
>>>
>>> On Tue, 4 Aug 2026 at 04:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> This series takes the initial steps required to try and remove use of
>>>> syscon_get_first_range() or syscon_get_regmap_by_driver_data() to get
>>>> GRF base addresses at runtime for the Rockchip platform.
>>>>
>>>> The GRF base addresses are fixed and known at compile time, yet drivers
>>>> keep trying to resolve them at runtime delaying some operations by
>>>> several ms.
>>>
>>> I suppose all addresses are known at compile-time, if you have a
>>> single device tree. I have always hoped that we might end up with a
>>> generic U-Boot for rockchip.
>>
>> I do not understand how removing these unneeded syscon drivers and
>> helpers would stop such goals or make that any harder. From my point of
>> view, they are currently making such things harder and only adds extra
>> code, runtime and energy waste. E.g. around 227 ms was wasted resolving
>> fixed known base addresses for RK3399 last time I measured it, see [1].
>>
>> Most drivers or any SoC specific code is already identified using a
>> compatible that is SoC specific, i.e. the RAM or CLK drivers are matched
>> using a SoC specific compatible and seeing how all GRF variants are
>> unique there will always need to be SoC specific code to handle the GRFs
>> base address and reg offsets.
>>
>> And for drivers that are more dynamic in nature the DT typically have a
>> phandle to the GRF syscon node anyway, so getting it from the phandle
>> will be a better option and closer matches how Linux handles similar
>> references.
>>
>> The biggest current blocker for a more generic U-Boot proper on Rockchip
>> platform is rockchip_get_cru() and how it currently makes it impossible
>> to support multiple SoCs in one build due to how it is used in the
>> sysreset driver. Fortunately, I have a pending series that also cleans
>> up the unneeded rockchip_get_cru/clk() related helpers.
>>
>>>
>>> I wonder if there is another way to do this, perhaps reading the
>>> address once and caching it?
>>
>> I really do not see the need for that; it would only make things more
>> complex than it really needs to be. We should use constants where
>> appropriate, e.g. soc specific drivers/code and use generic phandle
>> lookups elsewhere.
> 
> I agree on using SoC-specific constants in SoC-specific drivers and in SoC
> specific code in general. I also agree on removing unused or unneeded drivers:
> if anything requires them in the future, they will be added as needed.
> 
> Anyway, I would prefer constants not to be spread around in the source files
> that need them, but a single definition in a SoC-specific header. Therefore,
> no PMUGRF_BASE define in sdram_rk35xx.c; instead, a definition in grf_rk35xx.h
> that is more SoC-specific, something like RK35XX_PMUGRF_BASE.

I partially agree, however I also want to avoid easy use of these
constants, also the grf_<soc>.h files is no more for newer RK SoCs.

Current practice for RK is to define _BASE constants along CON/REG being
used, and are/should typically only be used/allowed in core SoC specific
parts, e.g. <soc>.c and sdram_<soc>.c.

These constants are used once, possible twice for a SoC, and current
practice for other rk35xx SoCs is to have the constant here, so I do not
see any reason to change this.

Main purpose of this series is to start the removal of the unneeded
syscon driver abstraction. To achieve this sdram_<soc>.c for rk3568 and
rk3588 is aligned to be consistent with RK SoCs more recently added,
i.e., rk3576, rk3528 and rk3506.

I do not interpret any of current made comments as a request for changes
or objection to the direction these changes are taking. Please be
explicit if there is any objection or a change that would warrant a v2.

Regards,
Jonas

> 
> From a theoretical standpoint I would prefer a single source for each piece of
> information, therefore having registers addresses in the Device Tree or in the
> sources, and not the same information repeated in both. However, this is not
> always possible (code not relying on DT such as TPL one) or convenient (for
> complexity and/or performance trade-offs).
> 
> Regards,
> Massimo
> 
>>
>> At least that is my end goal with this and pending follow-up series.
>>
>> [1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/cfb736dea37f834e849e54d39fb086c91697fc24
>>
>> Regards,
>> Jonas
>>
>>>
>>>>
>>>> In this initial part the three current uses of ROCKCHIP_SYSCON_x lookup
>>>> used on RK35xx SoCs is converted to use a constant value or using
>>>> phandle lookup, followed by removing the SoC specific syscon driver and
>>>> finally removing the RK35xx special ROCKCHIP_SYSCON_x enum values.
>>>>
>>>> The changes included in this series have no intended behavior change for
>>>> the affected RK35xx SoCs.
>>>>
>>>> Future series will continue to convert uses of ROCKCHIP_SYSCON_x for
>>>> remaining older RK SoCs if this initial part is accepted.
>>>>
>>>> Jonas Karlman (9):
>>>>   ram: rockchip: rk3568: Simplify get_info() ops
>>>>   ram: rockchip: rk3588: Simplify get_info() ops
>>>>   video: rockchip: dw_mipi_dsi: Get GRF base address from phandle
>>>>   rockchip: rk3568: Remove unneeded syscon driver
>>>>   rockchip: rk3588: Remove unneeded syscon driver
>>>>   rockchip: rk3576: Remove unneeded syscon driver
>>>>   rockchip: rk3528: Remove unneeded syscon driver
>>>>   rockchip: rk3506: Remove unneeded syscon driver
>>>>   rockchip: include: Remove unused ROCKCHIP_SYSCON_x enum values
>>>>
>>>>  arch/arm/include/asm/arch-rockchip/clock.h    |  8 -----
>>>>  arch/arm/mach-rockchip/rk3506/Makefile        |  1 -
>>>>  arch/arm/mach-rockchip/rk3506/syscon_rk3506.c | 19 ------------
>>>>  arch/arm/mach-rockchip/rk3528/Makefile        |  1 -
>>>>  arch/arm/mach-rockchip/rk3528/syscon_rk3528.c | 19 ------------
>>>>  arch/arm/mach-rockchip/rk3568/Makefile        |  1 -
>>>>  arch/arm/mach-rockchip/rk3568/syscon_rk3568.c | 23 --------------
>>>>  arch/arm/mach-rockchip/rk3576/Makefile        |  1 -
>>>>  arch/arm/mach-rockchip/rk3576/syscon_rk3576.c | 22 -------------
>>>>  arch/arm/mach-rockchip/rk3588/Makefile        |  1 -
>>>>  arch/arm/mach-rockchip/rk3588/syscon_rk3588.c | 31 -------------------
>>>>  drivers/ram/rockchip/sdram_rk3568.c           | 29 +++--------------
>>>>  drivers/ram/rockchip/sdram_rk3588.c           | 31 ++++---------------
>>>>  drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 16 ++++++----
>>>>  14 files changed, 21 insertions(+), 182 deletions(-)
>>>>  delete mode 100644 arch/arm/mach-rockchip/rk3506/syscon_rk3506.c
>>>>  delete mode 100644 arch/arm/mach-rockchip/rk3528/syscon_rk3528.c
>>>>  delete mode 100644 arch/arm/mach-rockchip/rk3568/syscon_rk3568.c
>>>>  delete mode 100644 arch/arm/mach-rockchip/rk3576/syscon_rk3576.c
>>>>  delete mode 100644 arch/arm/mach-rockchip/rk3588/syscon_rk3588.c
>>>>
>>>> --
>>>> 2.54.0
>>>>
>>>
>>> Regards,
>>> Simon

