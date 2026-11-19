Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9ED606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xf5PD5/1;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=BPa3UI88
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C93AC4067D;
	Thu, 19 Nov 2026 12:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id etgjm1GKlsBR; Thu, 19 Nov 2026 12:26:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A67D3405F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795091174;
	b=MKvSXF31HwjVWLEw3gNyJ6MnvGp+sdVoambNmCS04fJniL0gMcCWYOqWdtc2XWsMu+j6
	 eupaVayZowvXngXzWiT6MZVCq5U9iKUNdEhWhhSXTs7/N8nCmiLASNXO3v6XVGVXX0oki
	 62cxa9hZ5m+VQTPRPv9uQT3AWWu5FKK6hSmuZDCrspZDXr5VXohivqXmF1lZxTAc/Ppfd
	 5IFVfvpp8WE/7Sp3cgHSaGqIIzTt9yYoNIdM869OdiMU3zYpzrYIF/9Gnunz+klYFFOLq
	 f1QN9CDKPlOj25jcJIlRtHiDEUNlopEWjwyJS/N41M9no/CDod51KhUFi2anYw4ZLqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795091174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0V9mF/TgHMWpuaTP/FTmjeJgYasE20OcebTxUP/UU/E=;
	b=QLT7gvOPK51y0sjHJnXLx7R2ategvyRilO8ugGNoWtfGh4WwZYj6AzCkoPEYbySvgdrL
	 wUADqPBWYaJHl+q5Hlz+GouWu3W1kjEuJhIxPk0QRM9fCmyEz8mJAutOJWWR5k9WC4FVT
	 t3p1CRoGrf1WB08ZsWi7ngWwlB1HiRxBelOzbLVld00LhercOWXGCzfg3mzLRe6yFRdmQ
	 v6f2trNkhIRrzcbfsKE9P8pRWQXZxlN/J1mnpCa7QK7fC8jxNSGoDW+ksNeE/vvWSYzy6
	 RPinPaL9iK9XaRVMNIXWPYvs8yYG2D2P/GV53yzkkJYwe5CNSyUgvO3uuNylZGPJSgw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795091174;
	bh=0V9mF/TgHMWpuaTP/FTmjeJgYasE20OcebTxUP/UU/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xf5PD5/1+APuZIKwuJLcJ/qfpeVzbNZNzKwehJn3LOiF73/XCPNN7BROlApDK4HNX
	 ZrLOL7rixW3zSpUhmrNRBJFZUTyISioRfKoHgmbQQU8rdMrcDmfQyGbWXBT1ZS0WLS
	 r/MWf1IDueZPFtY5hh5w9mJ0oP/iYDgdepTGyjpnC/s8wmcbzx92fYBQvnlsvaZIMZ
	 OwJZbNX5LXWcBjZlGSJvW6WRGDtbHbnzyammU1LcdWJH8PTvjJy9plaPQIv29ZtCJa
	 9FL5ZIIKjo0s4rHwaDdnSSz1lsTeZR8V2fOA9zgsFYMoOSzoqdARw/DkT6uN+CF68T
	 9CJR8uHHdpVLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A67D3405F9;
	Thu, 19 Nov 2026 12:26:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 41316A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2800740526
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 71dMpoX5HBnP for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 12:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 450AD404FC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=45.157.188.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=BPa3UI88
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 450AD404FC
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:26:09 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jVd3z1q4czgf0;
 Thu, 19 Nov 2026 13:26:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1795091166;
 bh=0V9mF/TgHMWpuaTP/FTmjeJgYasE20OcebTxUP/UU/E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BPa3UI88nto/5DIZ9iKqQvJCrki/MyEOw2/Q1O2pQs6Sgv8sk38SrM9my6iaJP/TG
 5Bu0A4MlG2FC7sicGzBpiTEmm7v3gtJx7mgiImsxQLRkgqqb7O9QwJmc9ZgShbGELM
 ge95kiCejTj/9vN5zPXeplTAspPOT4xw3dYqvPMSb6Fx2S9WLEJXXIb+I+kOK6lmwq
 ylBdcy+APPFtRjG2EXry1dfPegmQx1Vgf6RjW0K7nJrojRdYEtheRdhlNqBTZr2khg
 4OVff6v3hSB/6vFK7b1kz/kkAuuFuMVDIkbBzQ3khXIo1zXVFpZT3WeiDkn2mLthSh
 9q52/WpuUW2Mw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jVd3x1dnBzRg2; Thu, 19 Nov 2026 13:26:05 +0100 (CET)
Message-ID: <7fe28def-9db2-48bb-ad02-ff9c3aa593d3@0leil.net>
Date: Thu, 19 Nov 2026 13:26:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] rockchip: sdram: expand types of DDR that can be
 supported
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Cunhao Lu <1579567540@qq.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20261117-rk-ddr-types-v1-1-0d00e87a0fc3@cherry.de>
 <CAC928Hb00=uq3-6=F6j=KBHWHkmhot0ia0iVd4PrGLLdj-7Reg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAC928Hb00=uq3-6=F6j=KBHWHkmhot0ia0iVd4PrGLLdj-7Reg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 11/17/26 7:07 PM, Massimo Pegorer wrote:
> Hi Quentin,
> 
> Il giorno mar 17 nov 2026 alle ore 14:09 Quentin Schulz
> <foss+uboot@0leil.net> ha scritto:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Joseph from Rockchip confirmed[1] the values we can get from Rockchip's
>> blob from the OS register for specific DRAM types.
>>
>> Add DDR2 and DDR5 to complete the list.
>>
>> Add comment on where the values originate from for future reference (and
>> to hopefully hint that those really shouldn't be changed).
>>
>> [1] https://lore.kernel.org/u-boot/501ace01-874b-4c61-b412-c297920c91a5@rock-chips.com/
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   arch/arm/include/asm/arch-rockchip/sdram.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
>> index 1c28d4aefb90..2e88febbcf28 100644
>> --- a/arch/arm/include/asm/arch-rockchip/sdram.h
>> +++ b/arch/arm/include/asm/arch-rockchip/sdram.h
>> @@ -6,8 +6,10 @@
>>   #ifndef _ASM_ARCH_SDRAM_H
>>   #define _ASM_ARCH_SDRAM_H
>>
>> +/* Written by Rockchip blob's/U-Boot's DDR init in [15:13] of some "OS" reg */
>>   enum {
>>          DDR4 = 0,
>> +       DDR2 = 2,
>>          DDR3 = 3,
>>          LPDDR2 = 5,
>>          LPDDR3 = 6,
>> @@ -15,6 +17,7 @@ enum {
>>          LPDDR4X = 8,
>>          LPDDR5 = 9,
>>          LPDDR5X = 10,
>> +       DDR5 = 11,
> 
> Does it really make sense to add DDR5, now?
> 
> DDR5 is not supported by any of the Rockchip SoCs, as far as I know and based on
> information available in the public domain. There was already a DDR5 = 10 (as a
> placeholder?), and it was wrong because LPDDR5X = 10 instead. At the moment,
> DDR5 = 11 seems to me like another placeholder with the risk of changing again
> in the future and leading to confusion. I would define it only when it will be
> really useful, i.e. when there will be a Rockchip SoC supporting DDR5.
> 

I checked RK3562, RK356x, RK3572, RK3576 and RK3588, they all don't 
mention DDR5 so I agree it may be premature. The upcoming RK3668 seems 
to only support LPDDR5/5X/6, so we probably should wait for that to 
happen, maybe they'll change the meaning of 11 in the register :)

Looking into currently supported SoCs, none also advertise DDR2 support, 
so maybe that's also not very useful.

What prompted this patch was the answer from Joseph[1] confirming the 
bitfield values mapping to DDR types, and my desire to document that 
this is not a simple enum, so it should be kept like that (and not 
reorder/fix contiguity).

I'll just reject this patch, we can always add the comment once we have 
an RK3668 board with LPDDR6 and we need to update the enum to reflect that.

Cheers,
Quentin

[1] 
https://lore.kernel.org/u-boot/501ace01-874b-4c61-b412-c297920c91a5@rock-chips.com/
