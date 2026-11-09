Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C6606A326
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FPVeNdux;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=jbS4dq4U
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05A29810A2;
	Mon,  9 Nov 2026 17:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1M8dJp5vQvP; Mon,  9 Nov 2026 17:22:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A4D780F76
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244972;
	b=m7k+zzsG0Fm5gzf/75IJVwRtsOx6596QV8x0Oy4ZiYQXtCC6RmbgUs34Lu6ncAKfw4Uo
	 Kwdm2CiFfeWrqQD1xtjf0AyGYEK7N6EUOsOKmLZfsVsQTP2toa0LW4nv1rG+HD9GrVwt/
	 6A4pD0GwwJ+MxdDHWYwliwqktMeBSFMf4BadK1QRR8CsdCKI5ktK2fP8cWbilC52VXnhm
	 8DoOCcjG/ADWzKd8NLEmuqWeJe/VFX/k4jIfFW7PTiPeyvRyl54xhi99pP5mYYewE/g5Z
	 b9z6jGNh5LrOG5yvW9gRjG1FWZ/+LcuA9HIX/MZ7EV72SU6o9JaPGgYaDsM1PO2GNWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N5K6x8S2onLT+TBii/8pR8AQ9+FoSMIlWUTcN2vMu8s=;
	b=jYcbRoMLWwZRPqh1mEZvKpmLP4kiprDjVfY1735lC7GvsqMlg2BC3nW8sJkx4pbGuwrO
	 SFVqZkUUMdaog07esI0mFdG5MZ8cdYHw0akuqcvjlto2BdZ81R6pUxkrQAaEmoDRf2kxW
	 dKKeWrvNrPamkLSG0DsglOmOoRjlgW7pPzKcEVfAyqYHESo9mO+igtj2EwM6KYOWqHUi/
	 iPhUL0PGd8cB5+oxg1kuze7b4+JE/yU/WZD7XJrqsthhHRpoF1Doiaihqoq2apW5dtlW1
	 vQxOOJ+bD6cbUzLrl9+vwPlSQm5EnPwI9h4tBGc98VlNlONg0+D7EUxYhoMqrTOIpRw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=jbS4dq4U;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794244972;
	bh=N5K6x8S2onLT+TBii/8pR8AQ9+FoSMIlWUTcN2vMu8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FPVeNduxu6nEV0e92gfE7IKv1TAeYGZuGnbb5NeEaW5HypHnVRO/G7oNNdQCGzL0D
	 8eAnIfDnQjYQEgX3gCSqMfxnFnR08+gYQXxJVnAmfYYOsxcoEeT4oizfB3rDuc2Oix
	 +FYTD6HNbjFHltPRYUr1pLaAJHNsN4IBv8Grek+yxDf9NeVUsvp63cteU2cQqndU8e
	 xE/UT35LpYKPa+FGe/IvLj7js+XZWsYCkB16LvXAregxzujrLhDNrcCe6fmc81We2x
	 me8MgH0YS/2740ftzAbD0ZFAJhDfebF5gomGNmwagb8aUcObg8snI3+9twaeJ8kDzJ
	 gidVS6ppToiEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A4D780F76;
	Mon,  9 Nov 2026 17:22:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D5C95251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C758B80F76
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:22:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VblTdUqi0mxq for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:22:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 389EB80F71
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::190e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::190e; helo=smtp-190e.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=jbS4dq4U
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::190e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 389EB80F71
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:22:47 +0000 (UTC)
Received: from smtp-4-0001 (unknown [IPv6:2001:1600:7:10::a6c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNc6r3C0nzD00;
 Mon,  9 Nov 2026 18:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794244964;
 bh=N5K6x8S2onLT+TBii/8pR8AQ9+FoSMIlWUTcN2vMu8s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jbS4dq4UJQjK6nVr0EK8zrejjIC1RAtss9Em4MrnbSC+v1Ed4YM8/rZxLAIOeK/5d
 6uUTOGIavioa+79VafyCi41dADcooeRAMf4q+QcgCnZ2AH6bu0t+sAgDTgwPIigiuv
 Uq9TawuG7lbHYqmNinII6do2oEk1562SuykKMsMDvSf99+7QPPOCHZJoJZrh7Pdrnn
 Z2ju00h8WYKIGTjiFI1cJZHkA66Z5vwU2L7Q4CJ6KlnSLlQvO6ANSPzaB2JXdfd06F
 S24T+wAVl7HMIQ81hUpSxrdZGYCH4JD0srdXtFCySKN/6xBZwkxQEhdyAoQTX3omOq
 +cjtZCPc89m0Q==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jNc6p6S6fzP0D; 
 Mon,  9 Nov 2026 18:22:42 +0100 (CET)
Message-ID: <80ed7ea2-a4b1-48af-b756-4eac285f62e6@0leil.net>
Date: Mon, 9 Nov 2026 18:22:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: ram: Fix LPDDR5X size decoding
To: Jonas Karlman <jonas@kwiboo.se>, 1579567540@qq.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.u-boot-project.org, Joseph Chen <chenjh@rock-chips.com>
References: <20261019-lpddr5x-size-fix-v1-1-3688217baaa2@qq.com>
 <7a9ef465-4cb3-4bf3-b0be-e5403165cc31@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <7a9ef465-4cb3-4bf3-b0be-e5403165cc31@kwiboo.se>
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas, Joseph,

On 10/22/26 8:52 PM, Jonas Karlman wrote:
> Hi Cunhao,
> 
> On 10/19/2026 9:31 AM, Cunhao Lu via B4 Relay wrote:
>> From: Cunhao Lu <1579567540@qq.com>
>>
>> The shared SDRAM decoder treats type 10 as DDR5 and uses the wrong
>> bank count for LPDDR5X. On the 4 GiB OK3572-C, register values
>> 0x100043c1 and 0x30001001 therefore produce a size of 1 GiB.
>>
>> Define LPDDR5X as type 10 and DDR5 as type 11. Apply the existing
>> LPDDR5 bank decoding to LPDDR5X so the same register values yield
>> 4 GiB. The type values match include/soc/rockchip/rockchip_grf.h in
>> the kernel-6.12 sources of Forlinx OK3572-C BSP Alpha1.
>>
>> Signed-off-by: Cunhao Lu <1579567540@qq.com>
>> ---
>> This patch fixes LPDDR5X capacity decoding in Rockchip's shared SDRAM
>> decoder.
>>
>> The geometry registers captured on a Forlinx OK3572-C with 4 GiB of
>> LPDDR5X are 0x100043c1 and 0x30001001. The current decoder labels type
>> 10 as DDR5 and uses the generic bank calculation. With the bank bit
>> set, it assumes four banks instead of 16 and reports only 1 GiB.
>>
>> Define LPDDR5X as type 10 and DDR5 as type 11, following the Rockchip
>> type definitions in Forlinx OK3572-C BSP Alpha1. Use the existing
>> LPDDR5 bank calculation for LPDDR5X so the captured register values
>> decode to the correct 4 GiB capacity.
>>
>> The fix applies to mainline independently of the RK3572 SoC and board
>> support.
>>
>> Host-side validation of the decoder with the captured register values
>> reproduced 1 GiB before the fix and returned 4 GiB after it. Regression
>> checks for eight other memory type codes produced the same results
>> before and after the fix, with no UBSan errors.
>> ---
>>   arch/arm/include/asm/arch-rockchip/sdram.h | 3 ++-
>>   arch/arm/mach-rockchip/sdram.c             | 4 ++--
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
>> index 476fc1c4e..f5a213fde 100644
>> --- a/arch/arm/include/asm/arch-rockchip/sdram.h
>> +++ b/arch/arm/include/asm/arch-rockchip/sdram.h
>> @@ -14,7 +14,8 @@ enum {
>>   	LPDDR4 = 7,
>>   	LPDDR4X = 8,
>>   	LPDDR5 = 9,
>> -	DDR5 = 10,
>> +	LPDDR5X = 10,
>> +	DDR5 = 11,
> 
> We should probably just drop the DDR5 symbol, and could possible also
> add a DDR2 symbol. DRAM init blobs likely use something like following:
> 
> 	switch (dram_type) {
> 	case 0:
> 		return "DDR4";
> 	case 2:
> 		return "DDR2";
> 	case 3:
> 		return "DDR3";
> 	case 5:
> 		return "LPDDR2";
> 	case 6:
> 		return "LPDDR3";
> 	case 7:
> 		return "LPDDR4";
> 	case 8:
> 		return "LPDDR4X";
> 	case 9:
> 		return "LPDDR5";
> 	case 10:
> 		return "LPDDR5X";
> 	default:
> 		return "Unknown Device";
> 	}
> 

@Joseph: What is written in bits [15:13] of register OS_REG2 by the DDR 
init blob (*_ddr_*.bin files from 
https://github.com/rockchip-linux/rkbin.git) for all supported DRAM 
types? Can you confirm what Jonas said above is correct?

Cheers,
Quentin
