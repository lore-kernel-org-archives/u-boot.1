Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C35CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 21:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D359C86E37;
	Fri, 13 Oct 2023 23:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="sDWWNAIe";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="0Z94CEk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E560686936; Fri, 13 Oct 2023 23:42:01 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71DB986936
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 23:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 3c82cd8c;
 Fri, 13 Oct 2023 21:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=b6
 YnqeVugIr2fRkh5Qgbv1VD9hs=; b=sDWWNAIeHR5gA6v2cPpFWXGOWVqFcWnlwW
 7LYYpcQaDAGka8zA60Tn64g5Sj99plt0yG/4i13ZT6UeYRUqL1Ew4/KcqmcxLThC
 5AqCnKsrJbZc2hbbT7C2JKZpwRA0qnwSycIYbIkbZFwqDgwnaWgnR3EDhLrDI9wO
 VhHROGOuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 OnRNkSdB3IuILLNrNKNcwgRDbk788auIi9WNoTQPjVwWhXiGAhef2/OCEulmuQfc
 e0ysw8N60Na9BnAmKWeulBJfknNqDNr5/V6aUeklXyEYlDEPFDV7iXc1QBbyyIx9
 DaTq/HtvlZUgCOyzGJ6EU81FycGHO+NNFiM5po1gdi8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1697233278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33ZM90YELWpCmaIbvYLEPloQGp9tYijFg3k3zC/KHls=;
 b=0Z94CEk+DXnIt/9HIYizjqYVmDL1AQz5Eoaq1ywEQ2473nEMWTc0+t3KQ5C2UvsVsAv5Ns
 FZTqzpLC4BaFWMD54rMp7VEgrt+ZLJyGgmfd++O8h3mkKRMHHypOfy2KxgsswFuCkeYMCs
 ILHc8bC238nlZrhV7R18oBGoMZfWfpg=
Received: from [192.168.0.2] (host-80-116-143-4.retail.telecomitalia.it
 [80.116.143.4])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 1c1f2f6d
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 13 Oct 2023 21:41:18 +0000 (UTC)
Message-ID: <f088dc6a-e38c-4dae-7ab4-1d716b9a4d86@kernel-space.org>
Date: Fri, 13 Oct 2023 23:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 4/7] m68k: Remove common.h usage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-4-trini@konsulko.com>
 <4e4779f8-ddbc-6469-6c9c-a42751f2c9cc@kernel-space.org>
 <20231013205510.GV3119521@bill-the-cat>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20231013205510.GV3119521@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

sorry, applied all now, it works, i can boot properly.

Thanks.

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 13/10/23 10:55 PM, Tom Rini wrote:
> On Fri, Oct 13, 2023 at 10:53:04PM +0200, Angelo Dureghello wrote:
>> Hi Tom,
>>
>>
>> On 13/10/23 1:03 AM, Tom Rini wrote:
>>> We can remove common.h from most cases of the code here, and only a few
>>> places need an additional header instead.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Angelo Dureghello <angelo@kernel-space.org>
>>> ---
>>>    arch/m68k/cpu/mcf523x/cpu.c         | 1 -
>>>    arch/m68k/cpu/mcf523x/cpu_init.c    | 1 -
>>>    arch/m68k/cpu/mcf523x/interrupts.c  | 1 -
>>>    arch/m68k/cpu/mcf523x/speed.c       | 1 -
>>>    arch/m68k/cpu/mcf52x2/cpu.c         | 1 -
>>>    arch/m68k/cpu/mcf52x2/cpu_init.c    | 3 +--
>>>    arch/m68k/cpu/mcf52x2/interrupts.c  | 1 -
>>>    arch/m68k/cpu/mcf52x2/speed.c       | 1 -
>>>    arch/m68k/cpu/mcf530x/cpu.c         | 1 -
>>>    arch/m68k/cpu/mcf530x/cpu_init.c    | 1 -
>>>    arch/m68k/cpu/mcf530x/interrupts.c  | 1 -
>>>    arch/m68k/cpu/mcf530x/speed.c       | 1 -
>>>    arch/m68k/cpu/mcf532x/cpu.c         | 1 -
>>>    arch/m68k/cpu/mcf532x/cpu_init.c    | 1 -
>>>    arch/m68k/cpu/mcf532x/interrupts.c  | 1 -
>>>    arch/m68k/cpu/mcf532x/speed.c       | 1 -
>>>    arch/m68k/cpu/mcf5445x/cpu.c        | 1 -
>>>    arch/m68k/cpu/mcf5445x/cpu_init.c   | 1 -
>>>    arch/m68k/cpu/mcf5445x/dspi.c       | 1 -
>>>    arch/m68k/cpu/mcf5445x/interrupts.c | 1 -
>>>    arch/m68k/cpu/mcf5445x/speed.c      | 1 -
>>>    arch/m68k/cpu/mcf5445x/start.S      | 1 -
>>>    arch/m68k/include/asm/immap.h       | 1 +
>>>    arch/m68k/include/asm/immap_520x.h  | 1 +
>>>    arch/m68k/include/asm/immap_5235.h  | 1 +
>>>    arch/m68k/include/asm/immap_5272.h  | 1 +
>>>    arch/m68k/include/asm/immap_5275.h  | 1 +
>>>    arch/m68k/include/asm/immap_5282.h  | 1 +
>>>    arch/m68k/include/asm/immap_5301x.h | 1 +
>>>    arch/m68k/include/asm/immap_5307.h  | 2 ++
>>>    arch/m68k/include/asm/immap_5329.h  | 1 +
>>>    arch/m68k/include/asm/immap_5441x.h | 1 +
>>>    arch/m68k/lib/bdinfo.c              | 3 ++-
>>>    arch/m68k/lib/bootm.c               | 1 -
>>>    arch/m68k/lib/cache.c               | 2 +-
>>>    arch/m68k/lib/fec.c                 | 2 +-
>>>    arch/m68k/lib/interrupts.c          | 2 +-
>>>    arch/m68k/lib/time.c                | 1 -
>>>    arch/m68k/lib/traps.c               | 1 -
>>>    39 files changed, 17 insertions(+), 30 deletions(-)
>>>
>>
>> building for mcf5307 i get this error
>>
>> In file included from arch/m68k/lib/bootm.c:7:
>> include/bootstage.h:225:1: error: unknown type name 'ulong'; did you mean
>> 'long'?
>>    225 | ulong timer_get_boot_us(void);
>>        | ^~~~~
> 
> Did you apply the whole series?  The first few patches fix some global
> issues.
> 

-- 
Angelo Dureghello
w: www.kernel-space.org
e: angelo@kernel-space.org
