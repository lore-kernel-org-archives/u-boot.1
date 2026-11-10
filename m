Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163E606A32E
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OOAwbnqc;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=eqLZ41fb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C22F780FDE;
	Tue, 10 Nov 2026 03:24:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIm8J8u1v47e; Tue, 10 Nov 2026 03:24:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48C9F80F8C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794281063;
	b=W5XQj/cau9trVQPBHMcSNSJJubNm740mhBewYfXwEC6skSmZkIo5zKGPB3sYNqrXbFra
	 Zx8Y2CQsO0tu0weWWFiC6DfPqTM/GlUeufdCgy6T+r12Wdx3mInnSR2EJ31GIXj3wQS9W
	 mTf+I4Ke+MLCTWVzdyM013RGoLGnJlTFHZSLcZoVrrvU0G8QlZQFArVEv86rQw+Vlum3y
	 H/kxxemUvglDEKZgeh2+TbrCyijJEp4CNEIzLJcwNp9pBpi1tBZWBDu1n/62dSuwGFx/R
	 wCEITUCvWv+7S+4A3J55eRQNJML8/EKvf8aYRjuVwZ6stAXdtIFVnnbCS/hAVk4dlPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794281063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UVvn26vtISqYMd6AmpvUpixoikrDaujXnmqLNDk6m44=;
	b=oa3Ws+iVUnfPXeCybv52m0O6CTQj8VbCjMRAfHVeXm0uOlvSJiX+nmIemEAkZfpvaxfv
	 36ngJc68NEZzNfqBRb7O94XuGBoZ0aeUPj5LXvoSEZrYi9xkhE7GbAKGfkGiOIeUiei6N
	 tUFtmtKj1p4Pya3oSCvcEoQGgrgeCD4f3hr4b04wbtUrbTt+eTs4w6Pe5VjFBXMJYbMyq
	 FxfPD2FB1EWJ8Dl9kGAkuZtakX23MBAdXtfm4NP61Utwb+PWGW6Xi6PGlSxJJXdqUdw75
	 0e/VlQJGybLBwfr2ZdvBcW59OSLQLojZEkGqh+E+DY63KWlzMf01qLNpfOgy48hSVvQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794281063;
	bh=UVvn26vtISqYMd6AmpvUpixoikrDaujXnmqLNDk6m44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OOAwbnqcq+w1WxlFyeonTNv+DDAiffHJW7jDvSuIlWYMkwxgQZ9kdRsBvIT4GjlT0
	 lynzCfTmHwBQ4RL3Vym0+qifPGPuF+D3H8mMw4NfAjXz1N/Mf2B4vVqL3hCPyXLQNi
	 SgmLhxcf03hGkuPj7Ra3GJ4cilDT6tE0I00l9bf+glZvy3on2EtZZg5vWUMaqdaIqN
	 c4XbpNI/XZruwzDBCGpujn0ESpZM/oqBBLry7jdKkxq9ZxcdSNEjVXHBeyce3zNPb/
	 bYf1dl3SjPmOpyHSjPakqwXB379RUyyxC0evFDbSt5vlkSplKTJTLo3kQ8l3TtAQrQ
	 ipyYdyr1WuGgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48C9F80F8C;
	Tue, 10 Nov 2026 03:24:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8251BAF2
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 03:24:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 768924075F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 03:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxUsKMJmHT6S for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 03:24:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B87C40721
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=154.81.10.140
X-Greylist: delayed 308 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 10 Nov 2026 03:24:18 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=rock-chips.com header.i=@rock-chips.com
 header.a=rsa-sha256 header.s=default header.b=eqLZ41fb
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=154.81.10.140;
 helo=mail-m10140.netease.com; envelope-from=chenjh@rock-chips.com;
 receiver=<UNKNOWN> 
Received: from mail-m10140.netease.com (mail-m10140.netease.com
 [154.81.10.140])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B87C40721
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 03:24:17 +0000 (UTC)
Received: from [172.16.12.163] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5418498e6;
 Tue, 10 Nov 2026 11:19:03 +0800 (GMT+08:00)
Message-ID: <501ace01-874b-4c61-b412-c297920c91a5@rock-chips.com>
Date: Tue, 10 Nov 2026 11:19:02 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: ram: Fix LPDDR5X size decoding
To: Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>,
 1579567540@qq.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.u-boot-project.org
References: <20261019-lpddr5x-size-fix-v1-1-3688217baaa2@qq.com>
 <7a9ef465-4cb3-4bf3-b0be-e5403165cc31@kwiboo.se>
 <80ed7ea2-a4b1-48af-b756-4eac285f62e6@0leil.net>
From: Joseph Chen <chenjh@rock-chips.com>
In-Reply-To: <80ed7ea2-a4b1-48af-b756-4eac285f62e6@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c377617c03aakunm6705d5c72c638a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0MaVh5NTR9KTU1KGElCQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=eqLZ41fbIds30ahuQWP4bWXBuiiYUCbREX70B6cw3fGKRghOEMujb7ZdLuMTm6YQKMXHbK8asSokimnRm72Nlct120/QLLNYwG6nD83HHSt+jNH/LoisACUqPXXVwuddkKTYH6kOke8l9QKUvAVK30h7U0k+U3YEiPgWxZWjMNw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=UVvn26vtISqYMd6AmpvUpixoikrDaujXnmqLNDk6m44=;
 h=date:mime-version:subject:message-id:from;
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

Hi Quentin,

在 2026-11-10 1:22, Quentin Schulz 写道:
> Hi Jonas, Joseph,
>
> On 10/22/26 8:52 PM, Jonas Karlman wrote:
>> Hi Cunhao,
>>
>> On 10/19/2026 9:31 AM, Cunhao Lu via B4 Relay wrote:
>>> From: Cunhao Lu <1579567540@qq.com>
>>>
>>> The shared SDRAM decoder treats type 10 as DDR5 and uses the wrong
>>> bank count for LPDDR5X. On the 4 GiB OK3572-C, register values
>>> 0x100043c1 and 0x30001001 therefore produce a size of 1 GiB.
>>>
>>> Define LPDDR5X as type 10 and DDR5 as type 11. Apply the existing
>>> LPDDR5 bank decoding to LPDDR5X so the same register values yield
>>> 4 GiB. The type values match include/soc/rockchip/rockchip_grf.h in
>>> the kernel-6.12 sources of Forlinx OK3572-C BSP Alpha1.
>>>
>>> Signed-off-by: Cunhao Lu <1579567540@qq.com>
>>> ---
>>> This patch fixes LPDDR5X capacity decoding in Rockchip's shared SDRAM
>>> decoder.
>>>
>>> The geometry registers captured on a Forlinx OK3572-C with 4 GiB of
>>> LPDDR5X are 0x100043c1 and 0x30001001. The current decoder labels type
>>> 10 as DDR5 and uses the generic bank calculation. With the bank bit
>>> set, it assumes four banks instead of 16 and reports only 1 GiB.
>>>
>>> Define LPDDR5X as type 10 and DDR5 as type 11, following the Rockchip
>>> type definitions in Forlinx OK3572-C BSP Alpha1. Use the existing
>>> LPDDR5 bank calculation for LPDDR5X so the captured register values
>>> decode to the correct 4 GiB capacity.
>>>
>>> The fix applies to mainline independently of the RK3572 SoC and board
>>> support.
>>>
>>> Host-side validation of the decoder with the captured register values
>>> reproduced 1 GiB before the fix and returned 4 GiB after it. Regression
>>> checks for eight other memory type codes produced the same results
>>> before and after the fix, with no UBSan errors.
>>> ---
>>>   arch/arm/include/asm/arch-rockchip/sdram.h | 3 ++-
>>>   arch/arm/mach-rockchip/sdram.c             | 4 ++--
>>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h 
>>> b/arch/arm/include/asm/arch-rockchip/sdram.h
>>> index 476fc1c4e..f5a213fde 100644
>>> --- a/arch/arm/include/asm/arch-rockchip/sdram.h
>>> +++ b/arch/arm/include/asm/arch-rockchip/sdram.h
>>> @@ -14,7 +14,8 @@ enum {
>>>       LPDDR4 = 7,
>>>       LPDDR4X = 8,
>>>       LPDDR5 = 9,
>>> -    DDR5 = 10,
>>> +    LPDDR5X = 10,
>>> +    DDR5 = 11,
>>
>> We should probably just drop the DDR5 symbol, and could possible also
>> add a DDR2 symbol. DRAM init blobs likely use something like following:
>>
>>     switch (dram_type) {
>>     case 0:
>>         return "DDR4";
>>     case 2:
>>         return "DDR2";
>>     case 3:
>>         return "DDR3";
>>     case 5:
>>         return "LPDDR2";
>>     case 6:
>>         return "LPDDR3";
>>     case 7:
>>         return "LPDDR4";
>>     case 8:
>>         return "LPDDR4X";
>>     case 9:
>>         return "LPDDR5";
>>     case 10:
>>         return "LPDDR5X";
>>     default:
>>         return "Unknown Device";
>>     }
>>
>
> @Joseph: What is written in bits [15:13] of register OS_REG2 by the 
> DDR init blob (*_ddr_*.bin files from 
> https://github.com/rockchip-linux/rkbin.git) for all supported DRAM 
> types? Can you confirm what Jonas said above is correct?
>
Jonas is correct. The following is the type definition, but DDR5 is not 
supported yet.

enum {
     DDR4 = 0,
     DDR2 = 2,
     DDR3 = 3,
     LPDDR2 = 5,
     LPDDR3 = 6,
     LPDDR4 = 7,
     LPDDR4X = 8,
     LPDDR5 = 9,
     LPDDR5X = 10,
     DDR5 = 11,
     UNUSED = 0xff
};


> Cheers,
> Quentin

-- 
Best regards,

陈健洪 (Joseph Chen)
chenjh@rock-chips.com
福州瑞芯微电子股份有限公司
Fuzhou Rockchip Electronics Co.Ltd
福建省福州市铜盘路软件大道89号软件园A区17号楼 (350003)
No. 17 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
TEL：0591-83991906/07-8573

