Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA838606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KIJ6Cowr;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=LYeMNjgr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A10CA40589;
	Wed, 28 Oct 2026 13:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhKMCbbMDGgb; Wed, 28 Oct 2026 13:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40576406A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793194591;
	b=FJg73TOXTuJOfhwH96LVTgOJZZT7eDqU+w6KZEyE9XSMpjrFBENwVthjtyjhiKBSk9Mv
	 WESiPRaQbVGtLzVd/nH7m5MdNlZIynKGwQNkSsa9/PEnCL5n+6ZB3ZzsONhlw/K/MYu43
	 45c5G8OStA82PRUVgIzYUb3JunIWG9OHIqtgsu5bYfpuBqDDr/0QlAGPT9/7bVdSatf9A
	 3pKdPWtFPAyzv+RoSBd+a86W9RyfEwkgjrjbm50l68de4OCWGl3cxiIYRAEqxaWhv72Us
	 tOgl16baDkpUVmjqICFdrF45WzZl/wRH/LJQG5tDBtPaU3c/NjLe/LIs2WVY015MyCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793194591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=my/+xCZdqI4FSUUDOEhP4c8PEtBoQxxduka88/hWc8E=;
	b=GUQfESxOlal8ClpfBMXzSyXcJh5lSuTFGJpb7JfcHjs43lRm9O1943WS/f0Mv9uNE7+P
	 HkysrjK35tFz4GaKDoa6RPTSFs8AMX/K0E1Zk9yHMiGd9DUfOiQfxSHecQSwpsiBebQpA
	 ZIyCMJB98SGq1DhbUj9hAksHRRhEUN9/SZywxeQNRhfiu9uSDzNvOcZ3nq9sLvlyZsNsX
	 Zq4ZyQMYPfFfaNMIEPuC/wtZSELJRzLtTyAK22ymk8CjujPVeOKfUh4l37SfbMoIA1blY
	 tbfes8IhHSkTn6+bQ/iZZ1XQ3WxPvi7dVK1JUU354K6Qmb4blollbAYbALJz06+gZHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793194591;
	bh=my/+xCZdqI4FSUUDOEhP4c8PEtBoQxxduka88/hWc8E=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KIJ6CowrXhTa0uE/53L2Cakbu7VIxcj0gkboM15TQXjltrk4aARumUVSSjUxrgZzE
	 wynvjXnapTBeK5jJXmCCaBF9cKz0SIzWaU47WqGHii8TuP0SxhwLbnIl99MIT+EMtS
	 pb2Agtsxca1nGOUNJyyFHXHbpJhYTGuNvaDFhhaoKx+lAhhRHD/7bRBCWwO3SKwsQA
	 CIU6l/6uSn9gg7iq+RBj8i2zwPd7WLkd8eRbJIO6G5GNsTEu3lG5chE0ts5qohda3H
	 Svwx4ShzHdZ8lGycF1mgdKa6PmzeEmZdEoxuQKLiY6T07nmNkRrjGEQ6Qxl3ClSwtw
	 sEMumANQBFW+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40576406A3;
	Wed, 28 Oct 2026 13:36:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E1C80529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C723B4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 05Wi9hntdN3I for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:55:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 76B614004A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=154.81.10.79
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793177751;
 b=VoetOZRTz94UUrMNDGtjnu2v3CLsPCMxaDYwsXIKnJ7HDWLCd/lt8i94W1G5ynnyQ1Cw
 eW19CTlwJ6ZTjrU6UNHG06M5SaR7hLhJEazGQY56F+ZRIY5Fvyr3RSImFYhdSOFA0ZRoQ
 MBXK420o1nAFE9BwPuEo6FEk9YqM8+YRHWi3ESSyKcVOt2KgIFivcjgwRhJ65GQ5Gakhy
 rGFTaOdyGcq3f6gBeVUxHZqyHhvUyVnyXFiD6+nBuA0qe/W3V/KMWLz5SIebF759GOLW0
 uaETYa6YS1q2RLIfLEUno/eIzw1T9IUHA/mcej50nH8j4pT41ZFhf+Bnr/bhVs52P6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177751;
 h=X-Greylist:Received-SPF:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
 X-HM-Spam-Status:DKIM-Signature;
 bh=my/+xCZdqI4FSUUDOEhP4c8PEtBoQxxduka88/hWc8E=;
 b=bMMFxJCuDHwAIKFUGMtpJdHBod6qurp5AUY6LtWDA8hxuJ7ftUkOPH926drcAAVbNL2O
 Ck1SX8BeOWBfBbPmELfaLg96SOrJ3RLM2xkQc9Px3QGYzk35Bg65uron75Q9rklkXou6B
 0LlX8R0S3npUByrn3jW5cSMyeOYIwWcdtL7dtBZ/oBBgdknu+pKGM7ZCnHsC8yy5JkBYo
 961bLQ7tkVr/z8S/e93eEjEy3bPBCs2WdZiiiSH4tCHDI1usrAiRvg6nK0YVKoj0iMOe5
 XT8GPtleB6o2vSbNZok2ZIHmADbewoDE6ikdy39e7p97s/tEJNhrr/dNjBqZqMZ7F0A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=rock-chips.com;
 dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256
 header.s=default header.b=LYeMNjgr; 
 arc=none smtp.remote-ip=154.81.10.79
X-Greylist: delayed 304 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 28 Oct 2026 08:55:50 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=rock-chips.com header.i=@rock-chips.com
 header.a=rsa-sha256 header.s=default header.b=LYeMNjgr
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=154.81.10.79;
 helo=mail-m1079.netease.com; envelope-from=chaoyi.chen@rock-chips.com;
 receiver=<UNKNOWN> 
Received: from mail-m1079.netease.com (mail-m1079.netease.com [154.81.10.79])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76B614004A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:55:49 +0000 (UTC)
Received: from [172.16.12.90] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 52a491f93;
 Wed, 28 Oct 2026 16:50:40 +0800 (GMT+08:00)
Message-ID: <3e639713-abb4-4416-8a5d-d78ea836125b@rock-chips.com>
Date: Wed, 28 Oct 2026 16:50:13 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: mkimage: Update init code size limit for
 RK3328
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
To: Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>
Cc: fen.chen@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261004195853.59863-1-jonas@kwiboo.se>
 <20261004195853.59863-3-jonas@kwiboo.se>
 <dc849a75-9166-41af-9ba5-abe8a63be884@0leil.net>
 <c59af0e7-a265-4521-8258-01296de5fcf1@kwiboo.se>
 <d3ec0007-47bc-4e0b-b652-1bc1ba160003@0leil.net>
 <814b5780-35b7-42eb-b240-134ea9115104@rock-chips.com>
Content-Language: en-US
In-Reply-To: <814b5780-35b7-42eb-b240-134ea9115104@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa181b4523703a7kunm5388095798d938
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUlOSVZPSkkZQx0aHU
 pMT0hWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=LYeMNjgrB6oHfjAXSvM/7m3AXqv6jN1qr1PTNLM/iCROQR7NTbEcLBgH7GoUQXWwEa9dKfWkwyJ6UqH04tABbSxTcTrShrBkmwIbPdYqy9uJHgVKa5KcsIcw68hCOePDwRgAW6pLUxbkDx+iRCWLJoqVXcj86woDRuROIIlhAGs=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=my/+xCZdqI4FSUUDOEhP4c8PEtBoQxxduka88/hWc8E=;
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

On 10/28/2026 4:41 PM, Chaoyi Chen wrote:
> Hi Quentin,
> 
> On 10/28/2026 1:42 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 10/16/26 11:25 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 10/16/2026 12:31 PM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 10/4/26 9:58 PM, Jonas Karlman wrote:
>>>>> The RK3328 has 36 KiB SRAM at [0xff090000, 0xff099000). With 4 KiB of
>>>>> the initial SRAM typically reserved for BootROM during early boot.
>>>>>
>>>>> BootROM will load init code of up to 32 KiB (0x8000 bytes) to address
>>>>> 0xff091000 in SRAM, before jumping to it.
>>>>>
>>>>> BootROM typically jumps to init code with following registers:
>>>>>
>>>>>     x0: 00000000 ff091004
>>>>>     x1: 00000000 32334b52
>>>>>     x2: 00000000 ff520000
>>>>>     x3: 00000000 ff500000
>>>>>
>>>>>     sp: 00000000 ff090f50
>>>>>
>>>>> mkimage is enforcing a 30 KiB init code size limit for RK3328.
>>>>> However, the BootRAM can load up to 32 KiB of init code.
>>>
>>> s/BootRAM/BootROM/
>>>
>>>>>
>>>>> Change the init code size limit to 32 KiB using the <size> - <reserved>
>>>>> pattern to closer match the actual limit of BootROM on RK3328.
>>>>>
>>>>
>>>> Downstream still uses 0x8000 - 0x800 so unless someone from Rockchip
>>>> confirms this is safe, I would rather not modify what we have today.
>>>
>>> Maybe my commit message was unclear, but I have runtime confirmed that
>>> BootROM is capable of loading binary code up to 32 KiB from SD-card and
>>> eMMC and the code was fully functional even when padded so _reset was
>>> placed at the very end of binary, in the last and lost 2 KiB.
>>>
>>> Most likely the mkimage size limit was used to impose limitations for
>>> stack and malloc area, very similar to the issue with PX30/RK3326.
>>>
>>> Runtime test consisted of running a minimal <2 KiB TPL binary that only
>>> initialized DEBUG UART and dumped passed x0-x6/r0-r6 and stack pointer.
>>> The binary used no malloc area, its stack was pointed to PMU SRAM or at
>>> half of BootROM reserved stack area, and the binary was .space padded to
>>> push code to very end of the loaded binary.
>>>
>>
>> How can you be sure that we aren't corrupting the BootROM stack? Between TPL and SPL we actually go back to BootROM so code from there run for sure after TPL has run.
>>
>>> I did similar runtime tests on all rk3288/rk33xx/rk35xx/rv11xx SoCs I
>>> have access to and all current limits in rkcommon.c beside PX30 and
>>> RK3328 matches the runtime limitations.
>>>
>>> On RK3288 (96 KiB SRAM) we can even load a binary up to full 96 KiB,
>>> however from SD-card, only current limit of 32 KiB worked.
>>>
>>> Please reconsider and/or hopefully Kever is able to confirm my findings.
>>>
>>
>> I'm not sure we'll get to see Kever much anymore and I don't know who exactly we should be asking. I've been told Chaoyi Chen might be a good point of contact now, so trying this here.
>>
>> @Chaoyi, can you confirm we can use 32KiB of SRAM on RK3328? See https://lore.kernel.org/u-boot/20261004195853.59863-3-jonas@kwiboo.se/t/#u for the whole context.
>>
> 
> I'm not quite sure whether I caught what you meant. And I guess you
> want to know the stack and data ranges used by the RK3288 Bootrom?
> 
> If that is the case, then the RK3288 BootROM will use the 0–4KB space
> for the stack and data, while the remaining SRAM stores the init code.
> 


Typo.. It is RK3328.

-- 
Best, 
Chaoyi

