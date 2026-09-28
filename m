Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E07CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 21:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7920605FC;
	Mon, 28 Sep 2026 21:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xJtjoCNjMqO5; Mon, 28 Sep 2026 21:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F13F460615
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790630026;
	b=BIwMx057rMbiL536pCMfuY4UzYcOGPBhhzohkMhfBTARr8faRTt846Pjni/Hv0rAzhR5
	 6lQOChFqGPTrpBDAtToRLD/tc3k7Oe/SsbfaHRWMFqJOEc/JppeP7OFr2rHHg2V2jrfTg
	 Ar3tCJ8Kgc0oSNNDGKIXMS7jUBITfpqK0wyb1k+461NA0G4JjKnOcNYrFpEopwXn8Xwnp
	 IbsMI3xCgNTMq2Jp2Dx/JxJMZzCt2hnwyBqVW5sUufPHpWYTKfCvyD0KSpjULeq5vF3q8
	 5pBN1Q8LMxB5e8I3nr6vvXklFKegcjkFIvEbR7MKdwbb8EwKT/uCfz/fjC0QJuOnTDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790630026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5V7VIoCmTnLMIM3rC4HB8p/c7YxFbx3pTIjVHacx0N0=;
	b=GbvUIGNplcDr3L07Z8G3jb9ecrded9v3RZ+Cve52b9dSuW/Vi/Wk+xWC4s63rKPDonGm
	 ZaL8kyFa064G0hYGdwAKydfcCafdmopcqqYHgADvTK9cfxGevQa4FcfB6RsCryes7V+O2
	 m1vzREpw1UaKJcUACsmiCnDghgttenWo5fcDi4FkzAjRIVnmT7TbyfpKDbeK1eAHpOxMT
	 IKAhLs9B6KGQvETdXyKy4N0uRIYu5L9XOA9PV7o1OZadP0X7FJnbgDdXuSmqZ8y2rLpk6
	 9GnD34t46O5/DT0XagpaVQRFr3AsB5XVhdiNTkMkzsYiLmlnZEW3sMW5/EN6eyRrr/A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790630026;
	bh=5V7VIoCmTnLMIM3rC4HB8p/c7YxFbx3pTIjVHacx0N0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yhKYHTxEp5QqNV19fHdrwQz4EXfKX8mmRiYHpZxvvzUqrTg1sgWZfCixD/LDBzrmL
	 KOGYtDBl3Ev8rpj6IxRqKIn7yipfoTOrpjztwewqAEdQidj/Kirk+xIq/tmyNyKGpx
	 pISQFuSZFBu7IzXCnJm5YzXza26Y12HGkDEkF46SmQd9SAezQePCT4uM2Z0rIRWpUr
	 MSH8c7oisnndOujUd416wVBWy8w/3LAIYw7XveVdnFFDACTKFCaSDDnWhiU4cz33l8
	 ECReoz1n3PWyHN5dt34YQQ5SRyd5pzRI0+WD3qqieY6F45fbJEMiwg+5XndUeV2bXP
	 AoOYSomcwsMCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F13F460615;
	Mon, 28 Sep 2026 21:13:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC9BF61
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDD7A40521
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BIvlrqkteRrJ for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 21:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F002F4051F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790630023;
 b=MoRX+kHyInJN7JJiwYIOvt5gCwpDfgCC3sOidv1Vosl4sP4xUbsg6aIkB9ecRnrO0WgV
 WphZrvNabhROvK0KNdcbn5XDDoTNWE16jXisSdLajOUhAfjSHuuWKbo1T4eEAP440mJnU
 aUT66DwTrhJCbHbcF8Nfq2dkho4lP5s0HkWQ6NtDLfHVMeV52kMvy+w8T6pke6WrD9blR
 e4mZ7SdlOtKIXbGLNnz3WhQnF/itCEkZGOu5FQN7Cz2xrHzyb0s9Ds3U/CvmLHRyt1lcW
 YVvtlO3XIt81gn5RHpMefKS/+cm1ajjhTtHXBzya1Q9egf7+2hN4x/ihDCQAslO6Jlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790630023;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=5V7VIoCmTnLMIM3rC4HB8p/c7YxFbx3pTIjVHacx0N0=;
 b=oxHOykuzC6smSn6pNshgcczNCxRGU/7eVsvJDEdkk5YmQesKbhv3Yx5Hq45VomZ6BgjC
 1TqCB89ZqvfYj2LejuKQj5eXVIoi8Y/Xix6WBQrEsJR/hIkjOOIIsCgPGos7zLanYmc03
 yD3UZRSDCoQXAPO9C6wDu0xO58TcngTXSvpU+ozWaUAEFicKzpvhy/Hh8pLW/lLn68P8B
 DyV2fkppeAvhwD72Eg7N18RoS3bqFlYvkp2YX6uwIj9LOrV+HKwnKZkGEePkA/Gw1D+nd
 TRcyJ4mGEdIqrCAQVuKM3AeiqIS2lICUhkCeMEZkNtWuv05QwMs9HDFAoyyfLkObLvg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=PUwGnvRT; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=a985=hv=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=PUwGnvRT
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F002F4051F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1790630019;
 bh=5V7VIoCmTnLMIM3rC4HB8p/c7YxFbx3pTIjVHacx0N0=;
 b=PUwGnvRTft2+ySfe1Kr/fX7u4gwUEkC1H76+P31NDqn3PV9n4v28vdIWKXWpWlZHuMmzeVV+D
 Dmj+ycPudxTY7xRc9aVp5bhwMObUeU9NuCTjb0QiGZh+dHmmyNI90KHUwJjlKtbW7OJIqB7Oglb
 4SY21gDnRhOAYB+HSghQIwEHqyptBYYM+PVmRPcQJXTgkVPJsjG1AKoarUVahVKvAKzI70vAHc4
 butUKZV31KY/CglFIBwickfgOTpsCsZXqWhJOZNQtBnJ4oiDRVuEmfEIy7FyfzDwVlbR5g6QQS1
 mDaBxGXmNHK2TxA1w70e9MJOEU23frQQlaPfP5S0sm1g==
X-Forward-Email-ID: 6abad87df3efd723eb6defcd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.16.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5da7edab-045b-4a73-8c67-864506b164f2@kwiboo.se>
Date: Mon, 28 Sep 2026 23:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20260920161930.1880133-1-jonas@kwiboo.se>
 <CAC928Hb3HdGURxLFhxocpQAWGVB2morvpLP=GEsRs_w1iE0oig@mail.gmail.com>
 <ca280adf-19dd-437b-946e-8e5e7f700464@kwiboo.se>
 <CAC928Hb4GK3y4NXt0tEo8U=QF57WeuhCZ=77mvc0t2=6iSpZZg@mail.gmail.com>
 <d96f1848-bc26-454b-8bc1-4cd5f8994e57@cherry.de>
 <CAC928HYf7zobjKPt+qQA3=fQSzuvfKqM7LvD-kG5tPBM=+Y1Gw@mail.gmail.com>
 <269fbd75-55ed-4051-b4ae-ed136dc36af1@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <269fbd75-55ed-4051-b4ae-ed136dc36af1@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin and Massimo,

On 9/28/2026 11:10 AM, Quentin Schulz wrote:
> Hi Massimo,
> 
> On 9/28/26 8:42 AM, Massimo Pegorer wrote:
>> Hi Quentin,
>>
>> On 9/24/26 12:03 PM, Quentin Schulz wrote:
>>> Hi Massimo,
>>>
>>> On 9/23/26 7:52 PM, Massimo Pegorer wrote:
>>>> Hi Jonas,
>>>>
>>>> Il giorno mar 22 set 2026 alle ore 15:28 Jonas Karlman ha scritto:
>>>>>
>>>>> Hi Massimo,
>>>>>
>>>>> On 9/22/2026 1:35 PM, Massimo Pegorer wrote:
>>>>>> Hi Jonas,
>>>>>>
>>>>>> Il giorno dom 20 set 2026 alle ore 18:19 Jonas Karlman
>>>>>> <jonas@kwiboo.se> ha scritto:
>>>>>>>
>>>>>>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
>>>>>>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>>>>>>>
>>>>>>> SRAM addressing only seems to use 14 bits, meaning that reading from
>>>>>>> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
>>>>>>>
>>>>>>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
>>>>>>> reserved region for its global data, malloc area and runtime stack.
>>>>>>>
>>>>>>> TPL on PX30/RK3326 does not have any use for the malloc area, the
>>>>>>> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
>>>>>>>
>>>>>>> Current memory layout possibly looks something like:
>>>>>>>
>>>>>>>     [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>>>>>>       [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>>>>>>         [..., 0xff0e08c0)                       stack area
>>>>>>>           [0xff0e08c0]                           stack pointer
>>>>>>>         [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
>>>>>>>         [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
>>>>>>>       [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>>>>>>         [0xff0e1000, 0xff0e3800)      10 KiB    code
>>>>>>>         [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>>>>>>
>>>>>>> TPL currently does not touch the malloc area, instead the reserved
>>>>>>> TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
>>>>>>> the TPL stack addresses deeper into the BootROM reserved area.
>>>>>>>
>>>>>>> Using current offsets for global data and stack does not seem to cause
>>>>>>> any known issue for BootROM after TPL returns to BootROM to load SPL
>>>>>>> into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
>>>>>>> could theoretically change this and cause issues for BootROM.
>>>>>>
>>>>>> Here with "any change to [...] code" I suppose you mean any change of global
>>>>>> data and/or BSS sizes, correct?
>>>>>
>>>>> Not only, the change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or 'struct
>>>>> global_data' would affect where the TPL stack ends up. However, and any
>>>>> change to the code may change how the stack is used and thus possible
>>>>> write to more/less/other data inside the BootROM area.
>>>>>
>>>>>> As code size itself is checked against
>>>>>> TPL_MAX_SIZE at build time. Regarding build time checks, I have a couple
>>>>>> of doubts about [1]:
>>>>>> - shouldn't we check for less than or equal against TPL_MAX_SIZE, instead of
>>>>>>     strictly less than?
>>>>>> - shouldn't be more correct to check the TPL "footprint" size against the 10
>>>>>>     (or 11 or 12) KiB limit, instead only the code size?
>>>>>
>>>>> Correct, this was also briefly discussed/mentioned in the v2 thread. However,
>>>>> this patch only tries to address the issue with TPL stack being placed inside
>>>>> BootROM reserved area.
>>>>
>>>> Indeed. I was just wondering if in a future patch we should avoid TPL_MAX_SIZE
>>>> configuration, and instead have just TPL_MAX_FOOTPRINT configured to 0x3000
>>>> adding GD_SIZE and TPL_SYS_MALLOC_F_LEN in the linker check.
>>>>
>>>
>>> I had never heard of that symbol before and went checking. It has never
>>> been used (there isn't even a Kconfig symbol for it!) so we would need a
>>> bit of work to make this work (probably not a crazy amount though :) ).
>>>
>>> I'm not sure we still need arch/arm/mach-rockchip/u-boot-tpl-v8.lds
>>> though. It's only used for evb-px5_defconfig, all PX30, all RK3328, all
>>> RK3399 and RV1126.
>>> I think it was necessary when added back in 2019 because
>>> arch/arm/cpu/armv8/u-boot-spl.lds didn't allow yet to remove the SDRAM
>>> part in it (c.f. 3cbec0ad090f ("rockchip: add u-boot-tpl-v8.lds") which
>>> claims "we don't have both SRAM and SDRAM in TPL" but we have SRAM
>>> access in TPL, don't we?), but that has changed since 2024. They are a
>>> bit different though and I have no experience with linker scripts so no
>>> clue if it makes sense to merge them (if at all possible). I'm guessing
>>> the additional asserts would make sense for everybody anyway.
>>
>> Me too, almost no experience with linker scripts. Anyway, I had a quick look
>> at arch/arm/cpu/armv8/u-boot-spl.lds for TPL building purpose, and IMO it's
>> broken by design because of SPL specific configuration options dependencies:
>> SPL_SEPARATE_BSS and SPL_RECOVER_DATA_SECTION. I will check more in depth.
>>
> 
> We can always migrate those to CONFIG_IS_ENABLED(SEPARATE_BSS), 
> CONFIG_IS_ENABLED(RECOVER_DATA_SECTION), CONFIG_VAL(BSS_START_ADDR), 
> CONFIG_VAL(BSS_MAX_SIZE), etc., if needed.

I did a quick test with my TPL stubs on RK3568 and RK3528 and we can
likely use arch/arm/cpu/armv8/u-boot-spl.lds after your suggested
changes.

However, we must also ensure to disable TPL_SEPARATE_BSS and not let it
use the default TPL_SEPARATE_BSS=SPL_SEPARATE_BSS, and also ensure that
TPL_MAX_SIZE is defined, as it will define the LENGTH of the MEMORY,
i.e. work as a built in size check that image+bss fit inside .sram.

And then we possible could to add a new size check, or possible manually
just ensure that TPL_MAX_SIZE is reduced by GD_SIZE, TPL_SYS_MALLOC_F_LEN
and a guestimated usage need for the runtime stack.

> 
>> BTW, the .sram MEMORY segment definition in the script would do the game: here
>> the size that linker would check against TPL_MAX_SIZE includes BSS (consider
>> the case SPL_SEPARATE_BSS not defined, of course), while u-boot-tpl-v8.lds
>> checks size without BSS against TPL_MAX_SIZE.
>>
> 
> We would have the same behavior of size checking if we had 
> TPL_SEPARATE_BSS enabled I believe. But if we had TPL_SEPARATE_BSS 
> enabled, then we would have an .sdram section too, which is the reason 
> for having a separate linker script in the first place.

Correct, we should use TPL_SEPARATE_BSS=n if we want to replace the
custom rockchip tpl armv8 linker script and keep current behavior.

> 
> I'm also not sure about IMAGE_TEXT_BASE (set by CONFIG_TEXT_BASE) only 
> used in the armv8 linker script and the first
> 
> . = 0x00000000;
> 
> in Rockchip's TPL linker script.

It does not seem like this line is needed in the linker script.

> 
> But maybe we should really have BSS part of the size check.

As mentioned above, with a TPL_MAX_SIZE the .sram LENGTH is assigned and
we get a built in size check, e.g. using TPL_MAX_SIZE=0x100 stop build:

    LD      tpl/u-boot-tpl
  /usr/bin/aarch64-linux-gnu-ld.bfd: address 0xfe481570 of u-boot-tpl section `.text' is not within region `.sram'
  /usr/bin/aarch64-linux-gnu-ld.bfd: u-boot-tpl section `.rodata' will not fit in region `.sram'
  /usr/bin/aarch64-linux-gnu-ld.bfd: address 0xfe481570 of u-boot-tpl section `.text' is not within region `.sram'
  /usr/bin/aarch64-linux-gnu-ld.bfd: address 0xfe481570 of u-boot-tpl section `.text' is not within region `.sram'
  /usr/bin/aarch64-linux-gnu-ld.bfd: region `.sram' overflowed by 1464 bytes
  make[2]: *** [scripts/Makefile.xpl:546: tpl/u-boot-tpl] Error 1

> 
> I'm out of my depth here though, no clue what would be proper.

For my forth coming TPL refactor series I tried to sync a few changes
into the Rockchip custom linker script, probably better to try and drop
it instead.

On a side note, the TPL stub runtime tests on RK3568 and RK3528 revealed
that in special cases we possible could use the BootROM stack, but I
still think that can be risky and that it is safer that we keep U-Boot
TPL stack and malloc area separate from the BootROM stack.

Test run of TPL stub on RK3528:

  U-Boot TPL 2026.10-rc5 (Sep 28 2026 - 20:23:41)
  x0: fe480458
  x1: 00000008
  x2: fe481000
  sp: fe480ef0
  DRAM init failed

Test run of TPL stub on RK3568:

  U-Boot TPL 2026.10-rc5 (Sep 28 2026 - 20:22:26)
  x0: fdcc0098
  x1: 00000008
  x2: fdcc1000
  sp: fdcc0f30
  DRAM init failed

Above is the values x0, x1, x2 and sp register had when BootROM called
the TPL code.

The stack pointer seem to be near the end of the BootROM reserved area.
Not sure what x0 or x1 values could be, but x2 seem to match
TPL_TEXT_BASE, so possible the address BootROM called/jumped to.

Also x3-x7 did not seem to have any useful values or they changed each
board reset.

What I take away from all above is that I will shortly update my rk3562
work-in-progress branch to also define TPL_MAX_SIZE to be the result of
TPL_STACK-TPL_TEXT_BASE for all added TPL stubs.

Regards,
Jonas

> 
> Cheers,
> Quentin

