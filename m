Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B36F54AC9
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 14:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1835480212;
	Tue, 24 Mar 2026 15:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HYZkbq2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B90983981; Tue, 24 Mar 2026 15:46:52 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2489480087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 15:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fgCY437D9z9tnQ;
 Tue, 24 Mar 2026 15:46:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774363608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ac+V7tcXzbrgJB7sCE3HmR1AGXMkItT4FR9tzuoBTbc=;
 b=HYZkbq2OnjCy8iEkJqUSdJergDZqWhj2GTATPfTtLVnx3pTQLytjaUh++jVkgLhuvweboJ
 JdFpxtDD9hwEOPKVRtoYpL/QFMltEkFQlWkhC8dMG31kfte6KQuqePHTj47Aozjl0bsRnW
 Qr39UIbGOZW9PcqytWyZ+OOvyb2fek7OcrHTJwphpBYTkXrXF0+VtdUHgNtQ5Cp2RQJiu+
 +U+ZyHlqVGjf1IqWL/d3+izNUHNeI+3uRA27gtkxRwNt5iil2thWiVoSnPwZmj+fqaBdBF
 jP2IRDjDZOUu4n3UQQa+ZcYLeoKkgPN/QszPwilUcJgsMNGGeW2RNULHYJ2NKg==
Message-ID: <87725377-4b4b-4d0f-a25b-bd48e1cd3df3@mailbox.org>
Date: Tue, 24 Mar 2026 15:03:31 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
 <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
 <6f12cae7-1dd3-4367-83d0-d35624dbfa4d@linaro.org>
 <6e74bf04-c05a-4628-8f50-b6d55a2af285@mailbox.org>
 <bdc10c1d-0235-4b07-a62a-004d61643f9a@linaro.org>
Content-Language: en-US
In-Reply-To: <bdc10c1d-0235-4b07-a62a-004d61643f9a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 06aa15cbb7f5d7b3162
X-MBO-RS-META: qtoofr575zm474kqgo4ase5i55c13xxq
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

On 3/24/26 1:10 PM, Casey Connolly wrote:

Hello Casey,

>>>> Which means, before we can really start switching boards to relocate to
>>>> 64bit space, we need to find all these remaining 32bit limitation sites
>>>> and fix them first. And to do that, we would need some way to force
>>>> allocation from 32bit space for drivers which need that ... do we
>>>> already have such a thing ? I couldn't find anything.
>>>
>>> For some (non-upstream) Qualcomm drivers we have just used lmb with
>>> LMB_ALLOC_MAX and passed in 4GB as the max address, it would be nice to
>>> have a wrapper function for this.
>>>
>>> Maybe this would just cause a whole bunch of other issues but perhaps it
>>> would be easiest to have a config option to place the malloc arena in
>>> 32-bit memory rather than always directly below U-Boot? Then again I
>>> imagine this is something that has been bikeshed in the past...
>>
>> Are those qualcomm devices suffering from 32bit DMA limitation too ?
> 
> Yeah, this is how we handle allocating the framebuffer for
> not-yet-upstream display support.
> 
> Would it be possible to use SMMU TLBs to allow (most) 32-bit-only
> peripherals to access 64-bit addresses?

This could indeed be an option, with some swiotlb . How do we handle 
transfers longer than 4 GiB , e.g. if someone is reading continuous 
block of 5 GiB from eMMC into DRAM ?

>>> *casey grumbles something about making relocation optional and merging
>>> the f/r init sequences for most boards*
>>
>> Can you try CONFIG_SKIP_RELOCATE for your use case ?
> 
> That works fine, I'm mostly frustrated with the whole pre-reloc FDT
> scanning/DM init, lack of dcache, etc... So pretty unrelated issues heh.

The list of initcalls in board_f.c and board_r.c seems to be a bit more 
flexible now, I wonder if it can be turned into an actual linker list 
with the ability to register arbitrary new entries at specific levels, 
similar to what sysvinit did with Snnscriptname . The nn would define 
ordering, since the linker lists are sorted. That would let you add e.g. 
S00startcachesearly entry.
