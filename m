Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37D3C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 14:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AAE48806B;
	Tue,  5 Mar 2024 15:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="P+aXFPrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FE288073; Tue,  5 Mar 2024 15:32:36 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 070C188065
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 15:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d1bf=KM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709649142;
 bh=pK5nQZ6Ajl8DrgoIk2NE+L+Goqk2NmKCvbFS3BjBves=;
 b=P+aXFPrWFUuoxk64nqjDc3HXnI2I7yFmBphTxKL2sE4sZ77IzrG5sEMAUK98E81w4uhUkfmpw
 9Y4f5jPRnirj8uU5EopBr21ei6v8COxlFVBOEf//YmsbLIttliFKvNTRxUfpvMn40kz1eYoODiO
 8SKqu/jVq1ZewyDbgFTJY7nikuaUuauWz1cwnAgXVD/+mqnoJe8P1fl7gvdny7Ov9bkweNFTZcs
 7lpiyDe+T9n3dx7fSbKAugHCdUixYv2xryUOlTMxoBYNYyMvWibHlbZms1PJ0Ihdp4msQZEiA91
 U2LZDnGfZjs9RSeTH6oEVwwBeyGzilGiC/UrFiSQhS4g==
Message-ID: <2b204040-24b5-4631-9168-42744d5af55e@kwiboo.se>
Date: Tue, 5 Mar 2024 15:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock5b: enable environment
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Christopher
 Obbard <chris.obbard@collabora.com>, Trevor Woerner <twoerner@gmail.com>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-4-twoerner@gmail.com>
 <48a3680a-2e33-4c2f-b564-68fd13a4e064@kwiboo.se>
 <c0785fe90bc1128140480f7812cf6facbf6e637c.camel@collabora.com>
 <3bfd0ec1-6fc0-4792-b71a-700684e6695c@theobroma-systems.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3bfd0ec1-6fc0-4792-b71a-700684e6695c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e72cf3aeda56157aab030e
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

On 2024-03-05 11:11, Quentin Schulz wrote:
> Hi all,
> 
> On 3/5/24 10:36, Christopher Obbard wrote:
>> [You don't often get email from chris.obbard@collabora.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hi Jonas & Trevor,
>>
>> On Tue, 2024-03-05 at 10:31 +0100, Jonas Karlman wrote:
>>> Hi Trevor,
>>>
>>> On 2024-03-05 03:10, Trevor Woerner wrote:
>>>> Following the pattern of other Rockchip devices, enable the U-Boot
>>>> environment to be stored in MMC. This patch specifically assumes the
>>>> environment will be stored on the SDcard.
>>>
>>> This board has SPI flash, so storing env in SPI flash is probably a
>>> better default.
>>
>> I agree with that.
>>
>>> However, preferably the env should be stored/loaded from
>>> the same device that TPL/SPL was loaded from.
>>
>> Do you know if there is some mechanism in U-Boot to do this already ?
>>
> 
> We do this for our Theobroma boards, though we use the same device that 
> U-Boot proper was loaded from, and not the one that TPL+SPL was loaded 
> from but the logic could be more or less the same.

Good catch, same as U-Boot proper may be more accurate and what I was
expecting, I typically expect TPL+SPL and FIT to be loaded from same
media so may see them as interchangeably.

My normal expectation will be that if FIT cannot be loaded from
same-as-spl we are in some kind of fallback and/or recovery mode.

Maybe a u-boot,env-load-order prop, similar to u-boot,spl-boot-order,
could be an option? with support for similar options, same-as-spl and
same-as-fit/proper/boot or node refs.

> 
> https://source.denx.de/u-boot/u-boot/-/blob/master/board/theobroma-systems/common/common.c?ref_type=heads#L92-L152
> 
> is what you need. The first function is to differentiate between SD card 
> and eMMC, the second actually returns the **kind** of medium the 
> environment is stored on (so MMC or SPI-flash for Theobroma boards).
> 
> Instead of 
> https://source.denx.de/u-boot/u-boot/-/blob/master/board/theobroma-systems/common/common.c?ref_type=heads#L94-L95 
> you probably want to use board_spl_was_booted_from().
> 
> Note that to you need the MMC and SPI controllers to be bound in U-Boot 
> proper **before relocation** for this to work. c.f. 
> https://lore.kernel.org/u-boot/20240221-jaguar-v3-15-1f256a82201b@theobroma-systems.com/
> 
>> It could be useful to enable autodetection on many boards which can boot U-
>> Boot from either SPI flash / eMMC / SD card.
>>
> 
> There's been an attempt recently:
> 
> https://lore.kernel.org/u-boot/20240226011413.435713-2-benwolsieffer@gmail.com/
> 
> though only for the MMC part of the equation.

I thought I noticed something related last few days/weeks, did not
manage to find anything when I went looking for it :-)

Regards,
Jonas

> 
> Cheers,
> Quentin

