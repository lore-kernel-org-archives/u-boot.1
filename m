Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701D606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pKDrOXd4;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Y9jiBQ9/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF90680CEE;
	Wed, 28 Oct 2026 13:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fb7kXpdiH7OQ; Wed, 28 Oct 2026 13:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BE27E80986
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793194589;
	b=KfnL3NlOOOxzIfxn5OpHANkFAN9yHbFR5a0x94D8xCrUBK+xuLtYwvb0heRRqNujWi/x
	 M24py71O2MQuc6eZGehrkWCWGPvA6UuGk5RqmbwNFOhegyw5gjftvn9CGziX/RT9sCa9P
	 F2947HwcWoi4MtbHRnNiru/KLnLaXDeKqDxgRwJTejT91YHMXAMrA+XPwG5sAGIiF7ca5
	 erfsxSNsjEK4cd1RYTlAxi63fy6V80Ff99E3fyrBdkEDBQUBHz8Hc9XrXQ8kRsYvXYX7w
	 PfBa9JsIZbl/B9xjW48brJlxOXxxV2ODxUc011bOsZlG6BdWGZjzn2XqA+52aQkt5NQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793194589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WpUMwAyxw5Sav6gx+y60KnFpxLlGuw+NfygLW7lb4EE=;
	b=r5wsnScVMDZYLhmy8BloISzxgw4lJuvZcAmqXUvkbShZPq14H8yxqXBY+OvSh7Qx2ytm
	 nH5/co3Rl28UdHShS8VySZ4MMUVj7SQuaLuZBliEvqkMTki30C8pbTjEb9XjFUqg9dtBW
	 4bUzgixrZ+B6U2CgoE4TU1QzBcynN5mxM5V4pRlQa7X790A1D8P5XDI7UVck7W+PK3VLy
	 EgWdvrc15Sjml4nXti1wfHYemzF4j0AaXOcwEQ6gkQ759OPlge+/uJ9mOZnbnHDBfLyn0
	 ouNfPj9sUp2m1MnUhkpuXIaAnKy1MlAh166u8Hf78VoJPoZEwpg/c8TIJ0k8ezukKzQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793194589;
	bh=WpUMwAyxw5Sav6gx+y60KnFpxLlGuw+NfygLW7lb4EE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pKDrOXd41Zdus2wzj65dJTJ5wWv+YYCe6aoDVinjvCetFfG3MnFNaIWkGOvl9cyzo
	 ARz3uffGooX3MJjaI17ccaDPzIxn2VyQTCxs8an4K2hj98YAy5AgSBpZqYIfYyciSg
	 NVwXn+5gNxtvnKrj3B0O+y2touFVCge7ar1YyzFvrgIMK0gVr+fzGUaTcOy7yybrrZ
	 mB66KzEvHNFu/by4b1gF4hcPALHkX7PNqhax0I35+1AWo4cUYpvYAAfaS62EWQrvCD
	 8i8cu3+8CyQ0oYyaL7xM4Aa4DK+CAP3v70woVn0q2nHVfhsVtdVgzHtY4X6VqdId8B
	 lyRU8lU/97qwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE27E80986;
	Wed, 28 Oct 2026 13:36:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD6C2529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A27E54051D
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P24wz20bYzPt for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:47:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99F5140505
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=220.197.32.112
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793177254;
 b=PrL0rg9IGCFRA30p0VOSzLi1PxpIC5MkOgph0ZOrLAIYweOhyw0MjMoVXtQPwOSZUPZC
 N2D2SKSdrjMPzGtMSbV3PzWlHvcEe7wWzrM2OriIQVncYMciBiUJeYMrqUV0sRAIqAZqH
 SW/Fu+SGEdVZCOwSte0fm+trzdeW83LYSFtP/cA7kks88YbWzkuwfK4ErLT0ebnSQYPH3
 Ied8z2xe0YMgnVmuEKW+KBQvla2iOvm8kYe6JiPtZ2mNnhQ9v5Lb5TrnzcGWwJU4DmzjJ
 Tq3IVDOpjFKjaG+rfJjdjeEoBL2gY7M7Ic2GEBU/iwAvBopMq+mPrg5GZuTPBB21eyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177254;
 h=X-Greylist:Received-SPF:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
 X-HM-Spam-Status:DKIM-Signature;
 bh=WpUMwAyxw5Sav6gx+y60KnFpxLlGuw+NfygLW7lb4EE=;
 b=stKtMjtQg0YRwIUAUcUchpt73Iix9ET1UfMD1nTDNXLThV+FTU4NuiqQ5DhGfu8iEm8j
 5rcK62U+41fUs6Npk4ZFGb0hyYJsQUVO7/beGsmDk324ezlIJXuP9JxjIlCL8BhlKowpe
 6D7r7/tGd7Z5lE4dhK7LvEpTDpiBCpIvHNSGovJQYxoD/K/06kWsrwH2BEW8bGMDTFiIe
 4J2/PeL6madTy+CGRj2P0bNrCzfVkBpZ8HoVpFfNMC5LI3gznBkI5CL2wC6WgZLdKlXnq
 NRU4/0CsyAbjJUtTJ4iZ15npialyUyBEzlp9dw1mTXoAYzR7L0GsXaGnDRulxTGX6Wg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=rock-chips.com;
 dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256
 header.s=default header.b="Y9jiBQ9/"; 
 arc=none smtp.remote-ip=220.197.32.112
X-Greylist: delayed 305 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 28 Oct 2026 08:47:32 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=rock-chips.com header.i=@rock-chips.com
 header.a=rsa-sha256 header.s=default header.b=Y9jiBQ9/
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.32.112;
 helo=mail-m32112.qiye.163.com; envelope-from=chaoyi.chen@rock-chips.com;
 receiver=<UNKNOWN> 
Received: from mail-m32112.qiye.163.com (mail-m32112.qiye.163.com
 [220.197.32.112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99F5140505
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:47:31 +0000 (UTC)
Received: from [172.16.12.90] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 52a439bf2;
 Wed, 28 Oct 2026 16:42:15 +0800 (GMT+08:00)
Message-ID: <814b5780-35b7-42eb-b240-134ea9115104@rock-chips.com>
Date: Wed, 28 Oct 2026 16:41:48 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: mkimage: Update init code size limit for
 RK3328
To: Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>
Cc: fen.chen@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261004195853.59863-1-jonas@kwiboo.se>
 <20261004195853.59863-3-jonas@kwiboo.se>
 <dc849a75-9166-41af-9ba5-abe8a63be884@0leil.net>
 <c59af0e7-a265-4521-8258-01296de5fcf1@kwiboo.se>
 <d3ec0007-47bc-4e0b-b652-1bc1ba160003@0leil.net>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <d3ec0007-47bc-4e0b-b652-1bc1ba160003@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa181ac9d4503a7kunm0b08eced98a844
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGkIeHlYfHkpPQkpOQ0
 hKHktWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=Y9jiBQ9/CA0WYf7OvvI6F/uRm+49Du/W8p+zp6e+zo43y3F1xqLEdi3Ihb4fcBAlT7u/N5k65muhali+bVv4nwu+ZBhtuuXDLMmhW46CIllyJIB0eOe0u4/UAi5FSsUM2M3xYx86PWQKN0cgFW5wOeZVzqVZ9HzaHxr8Mp+VU4Q=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=WpUMwAyxw5Sav6gx+y60KnFpxLlGuw+NfygLW7lb4EE=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 28 Oct 2026 13:36:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 10/28/2026 1:42 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/16/26 11:25 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 10/16/2026 12:31 PM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 10/4/26 9:58 PM, Jonas Karlman wrote:
>>>> The RK3328 has 36 KiB SRAM at [0xff090000, 0xff099000). With 4 KiB of
>>>> the initial SRAM typically reserved for BootROM during early boot.
>>>>
>>>> BootROM will load init code of up to 32 KiB (0x8000 bytes) to address
>>>> 0xff091000 in SRAM, before jumping to it.
>>>>
>>>> BootROM typically jumps to init code with following registers:
>>>>
>>>>     x0: 00000000 ff091004
>>>>     x1: 00000000 32334b52
>>>>     x2: 00000000 ff520000
>>>>     x3: 00000000 ff500000
>>>>
>>>>     sp: 00000000 ff090f50
>>>>
>>>> mkimage is enforcing a 30 KiB init code size limit for RK3328.
>>>> However, the BootRAM can load up to 32 KiB of init code.
>>
>> s/BootRAM/BootROM/
>>
>>>>
>>>> Change the init code size limit to 32 KiB using the <size> - <reserved>
>>>> pattern to closer match the actual limit of BootROM on RK3328.
>>>>
>>>
>>> Downstream still uses 0x8000 - 0x800 so unless someone from Rockchip
>>> confirms this is safe, I would rather not modify what we have today.
>>
>> Maybe my commit message was unclear, but I have runtime confirmed that
>> BootROM is capable of loading binary code up to 32 KiB from SD-card and
>> eMMC and the code was fully functional even when padded so _reset was
>> placed at the very end of binary, in the last and lost 2 KiB.
>>
>> Most likely the mkimage size limit was used to impose limitations for
>> stack and malloc area, very similar to the issue with PX30/RK3326.
>>
>> Runtime test consisted of running a minimal <2 KiB TPL binary that only
>> initialized DEBUG UART and dumped passed x0-x6/r0-r6 and stack pointer.
>> The binary used no malloc area, its stack was pointed to PMU SRAM or at
>> half of BootROM reserved stack area, and the binary was .space padded to
>> push code to very end of the loaded binary.
>>
> 
> How can you be sure that we aren't corrupting the BootROM stack? Between TPL and SPL we actually go back to BootROM so code from there run for sure after TPL has run.
> 
>> I did similar runtime tests on all rk3288/rk33xx/rk35xx/rv11xx SoCs I
>> have access to and all current limits in rkcommon.c beside PX30 and
>> RK3328 matches the runtime limitations.
>>
>> On RK3288 (96 KiB SRAM) we can even load a binary up to full 96 KiB,
>> however from SD-card, only current limit of 32 KiB worked.
>>
>> Please reconsider and/or hopefully Kever is able to confirm my findings.
>>
> 
> I'm not sure we'll get to see Kever much anymore and I don't know who exactly we should be asking. I've been told Chaoyi Chen might be a good point of contact now, so trying this here.
> 
> @Chaoyi, can you confirm we can use 32KiB of SRAM on RK3328? See https://lore.kernel.org/u-boot/20261004195853.59863-3-jonas@kwiboo.se/t/#u for the whole context.
> 

I'm not quite sure whether I caught what you meant. And I guess you
want to know the stack and data ranges used by the RK3288 Bootrom?

If that is the case, then the RK3288 BootROM will use the 0–4KB space
for the stack and data, while the remaining SRAM stores the init code.

-- 
Best, 
Chaoyi
