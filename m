Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15588CA6015
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A0CE6087E;
	Thu,  8 Oct 2026 22:53:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ubx7KCaKeehG; Thu,  8 Oct 2026 22:53:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 781A260832
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499988;
	b=k+n15c7etHErV8tADLcyUFEycECc2V2csivBJTClpy45eJAEiUBcqZuRwFpIrvwBkEpM
	 oTgBa5b/uNYKVA7pNMq9ZTdZikEebDhzV3CNxvAZfC2WXtL5aIaARZZXpvGj0S7Too4+G
	 JsqxjjHPZMXjjPTAZOFxO+UboDYVsChitigF/7KVWbUyodHfgR+Nz6jb8tLNuHq7xoZc9
	 NzxMnru/c9/lJVHlk3zq33CMcZkn2jLeisPa/V7ueF1IHE5PXquEAx8bwabgeAz9qlmte
	 YctAEffu6q5rR0dHYLbpptFOgBnG7y5RNjWFLcdFyxUONf0vafWS37NpWhOYc18fRIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZoLDdQjoFsL7ABi9gf+shQ9M/CTfjsggF9tOFK4cIeE=;
	b=Q9t7+WhXTtTmdyZOol8lIScbT/6db9pf+PHXKtIkU5ihbnaAHThNr25NfZ2KeMDuKkcS
	 kXffVxpRkSVOsBKVMMKQbQwcKHBxALKBncVJrr+BFQUyai9xQ19gJ6KdmPL4Tl6kLtXXf
	 PMa1fq99n2V6s42FmfxPUuO7gTn7IPACga0Adj8UrXfhwV24MxeIwBP5Q8GAibQs08ljV
	 mPysjOGX9ieAUxjT5vUoTsnjGe/XQm2u97PsWcDHIb/nFESHrca3BETWAyMobd3dJFRIl
	 DsjUSzeiTPMpgpk6GYOBiz6sEKijTUAmMnSrL3qMEBrwuLOODJI783y/AtG18YAJ4Sw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=JK0B6hSm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499988;
	bh=ZoLDdQjoFsL7ABi9gf+shQ9M/CTfjsggF9tOFK4cIeE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=htGa53aap+Cfo0pI3FCJuFstbKbb7wwRWwrbbX7kAD7IR55nCbUqNlq+qVpzSaAub
	 /rDv7ivy7dqAasyM0qruGoZDudyYgy+7llnUETEoEMIFExg86TpV2kNKRy+jsLp2L2
	 kESYKe2OBS1L+y0wk2MOBQ9Eb3+hfTd3m9wKxZ8bu3SMYDcybNv2A1ZW6SPRhSnp9G
	 /jSq7lHbFsFkhgBSLL+VzW39qqjgLngpcMU7o+rCJ05i5538jqXbzhGcwr6QbWGHnI
	 fUofWnAvWkJTx3G7qYRU/zccpAtHkQ19LgrppCCUBs7HaVpQp9e+1l9veG46/2P4Q9
	 1OevEr5hi1lTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 781A260832;
	Thu,  8 Oct 2026 22:53:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4A7E1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 960E56084F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gW2wW_1mIUTd for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:53:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11F0C60808
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::42a9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499986;
 b=h2oaaK45rIAoMjLy4ElugksDDCqpd9qD36/OM0YPcryExK8FzKOcGyjQzlwLhsJPlCns
 p0JsZjft38UjIH9h/Fs9J8TYDfdejXGEIYoJkn+98zHxB2oFjLd7ZdKwY7sGZ/vv6reyA
 IKrsSPgWY85spOL0C3U0ZaOQiSpF1AXf/clovzzqTyJsrRY3Vdpjkz/t6s+97ES7CjBkL
 v91621rlRAdgaO+36gIyBfRPwp+Imfs7aR4dhnrUNfWRnB91XcGAC7wCKc5flhziLX0S9
 qXesnpM4mwJfT0ZSJwdDHV6dDZUy6LwLzyRIQR/RE6owfZc931RVnHXFSe1f26NtadQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499986;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=ZoLDdQjoFsL7ABi9gf+shQ9M/CTfjsggF9tOFK4cIeE=;
 b=Jc7ULApd3Q7hIjjfZjl87e2tU4PQZdm3M8U9uTMpks83tFcUIJUCD9dx+j+7sSdnQipN
 HvOx5sAT60uU5vBxbXgx/iMQ1f7bp+fCxjIwCa4/yYN5AOL/XLP4qC3g5+20zv843UXZE
 RburK8g+lB8k5jqjYoGLwO2cfvI5azHjkqg2fZs5RlBnDflFA8oO4u2XT0tJjNQ0Pp9y0
 LBAOhU9BKb6AF71b9G4FiLTqG7NJY+sFjmxq03EoGXDuQvDdqqGRHdfYt5sV5hiVp0IFj
 spT3Oo4Utp48bBK8OCiklwrtmrGvXPtvja7EIRC1oJsnMcyUjBk38uXhNhZ/Kw5JH3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=JK0B6hSm; 
 arc=none smtp.remote-ip="2001:1600:19:8e30::42a9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::42a9; helo=smtp-42a9.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=JK0B6hSm
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::42a9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11F0C60808
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:53:05 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j14yk1VqhzTFf;
 Fri,  9 Oct 2026 00:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791499982;
 bh=ZoLDdQjoFsL7ABi9gf+shQ9M/CTfjsggF9tOFK4cIeE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JK0B6hSmyQzkxXYYeiRsQn8oL4Eebtjqv+bRjm3W5EpmAhoEVkNiCopMs3z9Hlwai
 wuXEJZ0RwYRJFsxdFWLW6iFaVWuaEu4OBLwM14pH2XdpT4v1n/URVWau+pqk1OmWcZ
 eC7n0t15PCINoTrxPa+IUOPRtTrVJj3s79ZViQ71lNaA04asBFBgqGAD8m1b4wviFY
 LxzbOJ0wZuNzO8y3WLWeo4tuRE9ViudEuVRN0dAXScRkZWm9irlRs+D0dMzqj825ZB
 WzvxopJeLUBgH87dPG8vhbaKTJ8lESdAnJOjwAr2uxgsAsOGP/onWLGpKfMCOyWR7V
 A0TDVmdGjBCmA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j14yh6zHtzDVt; Fri,  9 Oct 2026 00:53:00 +0200 (CEST)
Message-ID: <582f30f6-7d5f-4dd5-a8c6-60d027806786@0leil.net>
Date: Fri, 9 Oct 2026 00:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
 <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
 <CAFLszTjKMRjF7hmEt6_bbnsRpi9Q=NHidRQC8zv4ToUEpqBarA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAFLszTjKMRjF7hmEt6_bbnsRpi9Q=NHidRQC8zv4ToUEpqBarA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Simon,

On 8/7/26 9:46 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On Tue, 4 Aug 2026 at 13:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
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
>>
>> At least that is my end goal with this and pending follow-up series.
> 
> Long delay while I took some time to look at this area in detail.
> 
> Pre-relocation is an area which I sort-of glossed over with the driver
> model implementation. There was talk about keeping the pre-relocation
> devices around rather than recreating them. We also looked at
> providing post-relocation devices access to the pre-relocation info.
> Over the years we have had discussions about having 'simple' versions
> of drivers (that don't go through driver model and perhaps don't use
> device tree) but no one has made the effort to implement this.
> 
> Anyway, after a few days of hacking I've come up with some
> improvements to the existing code, at the cost of about 500 bytes of
> size increase. It works by using slightly better algorithms for four
> key functions - fdt_parent_offset(), __of_translate_address(),
> ofnode_pre_reloc() and lists_bind_fdt(). The result is saving on
> firefly-rk3399 of 230ms, about what you are getting. Note that I have
> made no attempt to enable the relevant options in TPL/SPL (it only
> saves another 13ms), so your work is mostly complimentary.
> 
> The key difference is that this should help all boards, not just
> Rockchip, plus it still uses DT for everything. Tom doesn't want me to
> send patches at present but I did write up a post about it as a way of
> providing the comparison. [2]
> 

Please refrain from pointing contributors to patches that are 
written/assisted by AI/LLMs as those aren't currently welcome in the 
project.

Cheers,
Quentin

> Regards,
> Simon
> 
>>
>> [1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commit/cfb736dea37f834e849e54d39fb086c91697fc24
> [2] https://www-concept.deinde.dev/blog/speeding-up-devicetree-access-before-relocation

