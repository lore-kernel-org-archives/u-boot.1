Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670AB606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L0k7Pc5w;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HNPmIgMR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36B9881397;
	Thu, 19 Nov 2026 16:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1km5dUWH1jxZ; Thu, 19 Nov 2026 16:15:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 70CA38135C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795104938;
	b=rZSWUfzmpddkA/WMXKqMJoQibPuWMObbWuGQwXj1RC2QgoSYkmcI0TArqfEFvUp3QUbV
	 lgVmlEKHnBKjuTQlB/m/YjALwscrNpeU1p+r5YXBYuDAYWrNWCWLY9vfmhivAYxG1SDa5
	 BZMQnDrtWXVK7ThRCMElQ36EdPn/XH/xCM0gDK+2G0gBkJ37verqua5rYjUYlWUReiVmZ
	 eY5VmklHhEm3j2rYWoltHTENai/ctHbPOG7DvPQMJ4MoOrGIeBXMC8cVUuLNAN2VpEEPv
	 4muS+fVDMxgyvjpyIYzD3A7ct3W+XdUgPPCND4YpdEmGk0zR9y4Ac3Bj0mk5YV2iLHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795104938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=59CfRi+1jg3X47AG1zrvlArA1ji3D0zUTt6R74fDcL4=;
	b=ZruJz2eO1Fif9m5hV/+CDbTMz2PO04DfuNAahGoKHagYK/6ukXnLik9IKjq7Bt59+m3X
	 t6jvZf6rJFOXp7pMMNPZtWnGjnR2q7CBgLFw61PzTiL+QZZtQYvveRzBRTG8bPlsYx3UT
	 +mJCiE+ZBU8DXZJmChR5gkoovLbfYVjvlqL0Uv3rKpzspg7+nIdKMuP6B1Ij8E+uGI49i
	 dl0HC9RF5umOlPAJwcXOEwWazWnFcjjneqfpvqt+8nxrPpvfH6c+CN9DN60bFVEC5ajOF
	 Vtn8++jF7ZeoJdDhFLm+CumuW6QsUlu5oCW+QdPqRheQL/4mGLyEX4t2Z+PAE6ceECA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HNPmIgMR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795104938;
	bh=59CfRi+1jg3X47AG1zrvlArA1ji3D0zUTt6R74fDcL4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L0k7Pc5wzdqnAAe+9b9CwZRUP3yIBAbv1GXukE9nAIRRSI/34hKc0T5ZcqSFN53hV
	 rK5o2RpyHInJt79z/tvFNeq3mtxgOOxgneSBbC1kYBfdIjP4qCOOI6CrAQ8/+J6KE0
	 LsvA2WBi/Ptl+d5A6JL1hKj5AkoobIgXcKo6cm1NhIltxLypSDaUb03A7kJDh7iUy0
	 MrZjr0CVXNgjBk4ecuPdFf9cadNLaLPDRe+2ASfc1ZDYjDQDcjcmuZnr9oB7IWVLt5
	 33vXqk60GWnJlb9PhwLPX0L/hLZB/PUJFhVt1b5wzxY21tGcQuPw3ESojgJxAU3r5K
	 uQBwSmBkqd0aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70CA38135C;
	Thu, 19 Nov 2026 16:15:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D3BF22B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52AAB81397
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-0aX-xzxtU7 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 16:15:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66CC08135C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HNPmIgMR
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66CC08135C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:15:35 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5ece3ab2e91so876496e0c.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 08:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795104935; x=1795709735;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=59CfRi+1jg3X47AG1zrvlArA1ji3D0zUTt6R74fDcL4=;
 b=HNPmIgMRR7HpGczCQStEFSYakbB/rPgcjYJb+D0oz6La3SGwpVPQEstWzm9b1bqqIs
 6YAWgSjXhlFsqnuRbDIakrjJfzZYX86NZrDW2JbCIg7UAanl9cdodgeuz10ampjZ8TWt
 P3S/e3NHfGnikGZmpkJaTmjYHRAQT1Jj3VXb1i9j6ZNZ0nBCMXzx1DDXXoEa1/iky9+K
 CXWur9lwVpbR9Nd8Z3md4Ba9wfG4wooUz64T4tO/e3nEKOqnILK+vz+dC23n+IeYh18F
 /IMy439zcjFD7DsSfnVBVjDytd6Uup9BLK/0qf1N3sklDWmAv2WhBu7BV6ZlzqouuqVz
 VQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795104935; x=1795709735;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=59CfRi+1jg3X47AG1zrvlArA1ji3D0zUTt6R74fDcL4=;
 b=KVNVxovJ6UHhdzNEotIq/vDEhxvHEUt8O3zUnaSaMXxkt4lNbwH12cPejwFJOdbAGf
 ZwYZHU1QQ8QBEI/Q5FQiIRcm/AI2z+XzS2dthiBOXbUBDcKiYcuOV8/ej0oRzb6kUOJQ
 gKGJ1ejZIEY2uwmt1Dg7IJI5yttyhBDl6TnZjJpcyqHTkvR1DBx5ggcYAXnLkloqq/M2
 72wLhw7GUaUQyhFEfqcnJGNLr4QsOid3v/AE8T2G+Eag45sSNWHUX/AN73DYl7I1M5i6
 qq7/xPCgpuMljBX3NWqv5BP75rZmWLrMSFtfrPUfOS/sKp0/YWsGhQ5IjFrRuKrJJJ9p
 nQdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHthelcWRyRmcfoMH0+usFBPSOme048LPO/GA2EwT9xRP+Sji6DFy/cXYwSnB6fMKH+06AQirs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9TmsudeQHN44aCT47IR9XDBYq5jDSyUx38T9mHJuqy9MygZP5a
 RvPHcpeyHCBxVW6dWAAD2cA3A7+qQEvOBk3lHzBKX9fjmCiO+ymIxo70jpfeRQ5xeVc=
X-Gm-Gg: AYBFou2PX7i8ZXzV94UM615Caip7BSm8bS+HUCx5M1nUBsZT2+SNG68u1hJjUgWuLRo
 6vhWpQtbczpHEOdI+m4KwkX5Yy2xVYrwXiSfy4foN082qtsHhUyns9+Ilxmqy53niAcaPymF6xD
 lUMaECvCcYjW+CNps6XmT6Nc3AcnmI7dcCKPBTPqrsUfZS1Eb2QGftHyFqu2wA7dWBV3NEoe/ux
 qXALcg7wi7ACGRKQc48Md0urnJbVcXni5sJsrS6dGlFpNBblclUrtMXyw8wuNi+1N6paiF2NUtj
 nQ+tdW2TpMgEI56nriajCHIKOCNsxNLN5umQ9/4gXYT6p1qRhxoaSlZ/GMjQ4CVu2rlYZTxn99C
 H3a4hda8lJkF/r/AaDuYiiiwNrvdxh2FIKpN+vdcKtEYPNbCvxfSDS6uUYqYS/mjFXCxRmw/saO
 3pr8tRu1m3NHHpnveihQJBXV8Fc1Ug1ukmpbPkHYeXb6Ai1jSwl9VxruDhMVvUKgKCwijXSrn7Z
 eCguOtflkrYYh9X4yY5X7K9Gx5EPWEfmQ1yNv6o6XHvenX2iQ5JL1cRftaRG1hx48QNbCrTx3v0
 PYGn+qV3I9J94EMDszOO+kQgH4Od2hoxYMOJvomg0YPahp3tHs/mVLnyULt39o8LQ5ahYAu4Bjm
 NGDh8JPgesZd3fMvLUPMu1uRT
X-Received: by 2002:a05:6122:7ca:b0:5ea:fae8:e69e with SMTP id
 71dfb90a1353d-5ee8aefbc08mr114343e0c.11.1795104934795; 
 Thu, 19 Nov 2026 08:15:34 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:43e1:bc37:7497:58db?
 ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee64e4d85csm4736956e0c.4.2026.11.19.08.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 08:15:34 -0800 (PST)
Message-ID: <ed0e9f3e-b865-4b89-8c36-0a6abac784de@baylibre.com>
Date: Thu, 19 Nov 2026 10:15:33 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: mediatek: enable the caches in SPL
From: David Lechner <dlechner@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 Chris Chen <chris-qj.chen@mediatek.com>
References: <20261109-std-upstream-mt8188-spl-caches-v2-0-78cfb3e90c55@beckhoff.com>
 <20261109-std-upstream-mt8188-spl-caches-v2-1-78cfb3e90c55@beckhoff.com>
 <26e0a77c-5188-47c1-a1e5-4caca8fd082d@baylibre.com>
 <a8d398c2-dc1e-470c-b194-b2fc606fd8dd@baylibre.com>
 <64e14026167e62b077a4999dd6283f96869f8a5a.camel@dirkwinkel.cc>
 <c84de235-1480-4747-9509-65af404cc9d4@baylibre.com>
Content-Language: en-US
In-Reply-To: <c84de235-1480-4747-9509-65af404cc9d4@baylibre.com>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 10:07 AM, David Lechner wrote:
> On 11/18/26 6:23 AM, Steffen Dirkwinkel wrote:
>> On Mon, 2026-11-16 at 10:43 -0600, David Lechner wrote:
>>> On 11/9/26 3:46 PM, David Lechner wrote:
>>>> On 11/9/26 9:13 AM, Steffen Dirkwinkel wrote:
>>>>> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>>>>
>>>
>>> ...
>>>
>>>>> +/*
>>>>> + * MMU and caches before U-Boot sets up its final page tables
>>>>> + */
>>>>> +
>>>>> +#include <cpu_func.h>
>>>>> +#include <asm/global_data.h>
>>>>> +#include <asm/system.h>
>>>>> +#include <asm/arch/misc.h>
>>>>> +#include <linux/sizes.h>
>>>>> +
>>>>> +DECLARE_GLOBAL_DATA_PTR;
>>>>> +
>>>>> +#define EARLY_TLB_SIZE	SZ_32K
>>>>
>>>> Can we get a comment that explains why this size was chosen?
>>>>
>>>>> +
>>>>> +static u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(SZ_4K);
>>>>> +
>>> I was doing some testing with this and adding this to the .data section
>>> makes the image too big for the SPL download agent that Carlo has added
>>> recently. So we might need to use a different way to allocate this memory
>>> in SPL vs. U-Boot proper.
>>
>> Yes, I also ran into it with the SPL of the U-Boot download agent and have
>> explored some options last week, but didn't really get to a conclusion:
>>
>> 1. A patch adding "CONFIG_SPL_MTK_EARLY_CACHES is not set" in mt8370-genio-da-
>> uboot-fastboot.config. This works and only makes the fastboot usecase slightly
>> slower
> 
> This sounds fine to me. We could end up running into problems still though
> with Genio 720 SPL download agent since it has to enable much more features
> though.
> 
> 
> Getting off topic:
> 
> Carlo, For Genio 720, I was not able to make a U-Boot proper download agent
> that fit so I'm wondering if we just just drop it on 700 so that there is
> just SPL download agent on all targets to keep things simple and consistent.
> 
> 
> Back on topic:
> 
>>
>> 2. Using malloc_f: This works, but seemed quite complex to me. We'd have to
>> manage the sizes for all boards and might want to handle it differently in SPL
>> and U-Boot proper.  Increasing SYS_MALLOC_F_LEN breaks the stack offset check on
>> Genio 700 and the fastboot configs.
>> I also looked into moving the cache setup earlier as with your DRAM handoff
>> series fdtdec_setup takes around 400ms without caches (would use something like
>> "ARCH_VERY_EARLY_INIT"), requiring malloc_f would limit how early it could be. 
>>
>> 3. Going back to v1 (fixed address used): This has the smallest image and no
>> allocations but we'd have to avoid reusing the address range for something else
>> in early boot
> 
> I would be OK with this option too. I think Carlo's objection was more about
> hard-coding the address than the concept in general, is that right?
> 
> So a config option for it like MTK_EARLY_TLB_ADDR that is chosen to be an
> address that works for both SPL and U-Boot proper (or make it per phase if
> there isn't a good address that works for both, but simpler is usually
> better).
> 
> My best guess for a safe address here is 0x401f8000. 
> 
> = DDR base (0x4000000) + 2MiB - EARLY_TLB_SIZE (32KiB)
> 
> This is well after SPL stack and just before where other things start
> putting images, e.g. if we ever enable falcon mode in SPL.


And since we didn't have enough options already... :-p


Another possibility could be to implement SPL_EARLY_BSS on ARM64 and use
that in SPL and keep the .data section for U-Boot proper.

