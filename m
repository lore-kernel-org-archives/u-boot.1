Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EC4CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 09:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4465880D63;
	Tue, 29 Sep 2026 09:34:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2nKVVqI_zR0c; Tue, 29 Sep 2026 09:34:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 24E9E80D4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790674451;
	b=gOFfxzmbiuEButRnDuXRhl9hLzQrb6ihKBeiMupp6clVOqF5uiF1UXW4MJn/KVLDqdTO
	 5NmbeH7tE4EG2pCm/iBYSMDhzeI3aDKgZYWuJKg0YTMHEhcYAYNTv5yWcQARFogK5WCM1
	 rDwlTtyd462FLn83D/0CMJUd+53mdCDaX1BEhlU/soFSVFQrlKQrzOyXQpjTyEFDeNmLb
	 TvvK31WHbLa/CFwy10bu0Gm7S+hSwqsb1JKef20ogz1cyuYXzL3VqZtzznuitPqU94NJ3
	 PXDrcLRJ5wssxxMBNMjX85iNxGeqZpWkQToFNm4DkK6qBxdqi4qn2BK4dMK8o2eDm2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790674451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s532xuz1CFnt8HizX1yL8DPYE6EfA8ls1kNzWjenhmk=;
	b=dkdui59XcBL65evYW8MZdz8YiLGOzAtDR2iGPTxpSkkFZjr/9P7Wk5UPXETd6QGpEso9
	 WJCo++3T4RYKE290EkQmdsxCdeiYicJjsaIKswqiyHoM9DlG88dqxleqD/nkUF6ZiXtFh
	 PmkPzNG3inTAKxDo9LOEihm36Dn2LZEtD1CKZreuzs4LRrz5HFP04xYm/61xMhpYENrIx
	 4lHsFlHw7UvQsS/50Wja4lNgyoEueXzppNjA6W9VLO9UCTQT2SYUDWdv/15Wy2F5Du7Ve
	 BFuheUne9y9hdZSteSkj0Mju2vUzt7kWegfTqdF3rWseIXmO1z9SJfGkFsxOKl6tvcQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=aJ2bpR6x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790674451;
	bh=s532xuz1CFnt8HizX1yL8DPYE6EfA8ls1kNzWjenhmk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vJg8msGkN32N/frHgy/RlK0s6pUFXN2S5nMEfJSl8iNH449ahOiC+mmJD/8gwK4yo
	 RHEXGRRX2tDfCf4z6bxEeJtbY0Pc/PfVczUjghcM2xZ03Zs2XKBnYGjHwzqhe6F13A
	 jrzDCwyaeAW0f8sCtKICtmN6F5/0HX3zlXKtxy4F1UVwU+GBMRtF871IyFEl6pHtij
	 6W/pDpFE9907VZKaC3J/o5WTnBndBxTBRLkcGQkO4Ce03yCV3difMfDPA8Ofwr5DDP
	 5L8vdakWYB32anvGhxPJY8fa2op2uW2BsQVwCSpFtuAqwCNtsLkVl5nvHeOR+YXU9/
	 tYpgS5ljS7JZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24E9E80D4A;
	Tue, 29 Sep 2026 09:34:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D896B3D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE6E180D4A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zHY7F-D8nZjJ for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 09:34:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B896A80963
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790674448;
 b=WzQVuQWmoWGW+tTxtnBH5sDtvKsf63VUL8mqVMiv7UIOAJ/ONFm/fl+BQdBCbLERQazE
 n2CZG6jQ/TBF2fUya0vD9Pj768+gEW4vuU4wDGCzfDOrTrYmRV+D1Koezrgpkgs72Rq0O
 5MnJHGOhn5KfryW7XqkHCyEa57qyCPFBY2ToUxNqpFPCwYaucwWBOqKkPr1RAUDBLiewF
 VKegfjVgmRxPz+eSG3k3ixNE4TsveYmvpec93wU97Lh6Futo4Sw8azS24G9iZhBSn5xdN
 TuEYcZkCbO42H62GlJxqnQwd8QFo/izhFfBs10+8nuyrNHj7Ta8ngYV0ciruPG/QjEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790674448;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:
 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=s532xuz1CFnt8HizX1yL8DPYE6EfA8ls1kNzWjenhmk=;
 b=OOsWmSpqQmLeWPX+KgsfufwiSGI8WH+hQPn03jNNEXboNA90Nv6oZt/3w61Cb5Ylgs72
 SfbK8HdQeHxii6nlb2UbBeK9sUMuU8LMuL8dtk3/X/rk+pzKoCpCLqo6Kos01jzTPZJME
 WrC+U3we4tVGezCQKvEqS4KPkAdi7PmNVig70WvzlUjoRSUOKxEVUEM3V2NbY+kXioVP8
 2pqpYevEiOhF2eYShk8c7BfMYzSwoJIR8wiJt6DWNNJmWT0O7lpXswDMFXJ7V2dsoFiAs
 A5jMfd4AcfrWe1Fc1wpi7sbui51AKmKjJMgJUOe/BPpaP/V5Oj2ptrLbI5Xa5+OfgIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=aJ2bpR6x; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=a985=hv=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=aJ2bpR6x
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B896A80963
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1790674445;
 bh=s532xuz1CFnt8HizX1yL8DPYE6EfA8ls1kNzWjenhmk=;
 b=aJ2bpR6xZKoMr3gXNQpvwgmLOp2Nqep/im+KXEto8NpZKqQTp5wpE6sPdW3YQwYIrDzmWrkz4
 3Gc7L3aOk9Q4eqV9UP0VIS4xYw2umPgLKWBTne5atesUvhwWEYx1aG944uw713lulwznqr4ZMA3
 M+3p1MepoJPv+e3py9JDJCAD71ch22Sj/wn0oQUFYzMIPunpIlYRXTeWYDRf9oAR2uUAgnr1OPG
 OHeeIa27V5ETuf/MG8KA0jNX2JyLbiLC9wtcBrGRfs8naC475HFna84OQ95VS5fvV4xye84sy4T
 kzOfxGnGXJaBpOoIBa18uwMRAB6xOqHPSRpUBaiAfGjQ==
X-Forward-Email-ID: 6abb86099b8e3789c4f3dda0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.16.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2905effa-8c4b-4112-ad53-528f2c8c2aff@kwiboo.se>
Date: Tue, 29 Sep 2026 11:33:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
From: Jonas Karlman <jonas@kwiboo.se>
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
 <5da7edab-045b-4a73-8c67-864506b164f2@kwiboo.se>
Content-Language: en-US
In-Reply-To: <5da7edab-045b-4a73-8c67-864506b164f2@kwiboo.se>
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

Hi again,

On 9/28/2026 11:13 PM, Jonas Karlman wrote:
> Hi Quentin and Massimo,
> 
> On 9/28/2026 11:10 AM, Quentin Schulz wrote:
>> Hi Massimo,
>>
>> On 9/28/26 8:42 AM, Massimo Pegorer wrote:
>>> Hi Quentin,
>>>
>>> On 9/24/26 12:03 PM, Quentin Schulz wrote:
>>>> Hi Massimo,
>>>>
>>>> On 9/23/26 7:52 PM, Massimo Pegorer wrote:
>>>>> Hi Jonas,
>>>>>
>>>>> Il giorno mar 22 set 2026 alle ore 15:28 Jonas Karlman ha scritto:
>>>>>>
>>>>>> Hi Massimo,
>>>>>>
>>>>>> On 9/22/2026 1:35 PM, Massimo Pegorer wrote:
>>>>>>> Hi Jonas,
>>>>>>>
>>>>>>> Il giorno dom 20 set 2026 alle ore 18:19 Jonas Karlman
>>>>>>> <jonas@kwiboo.se> ha scritto:
>>>>>>>>
>>>>>>>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
>>>>>>>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>>>>>>>>
>>>>>>>> SRAM addressing only seems to use 14 bits, meaning that reading from
>>>>>>>> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
>>>>>>>>
>>>>>>>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
>>>>>>>> reserved region for its global data, malloc area and runtime stack.
>>>>>>>>
>>>>>>>> TPL on PX30/RK3326 does not have any use for the malloc area, the
>>>>>>>> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
>>>>>>>>
>>>>>>>> Current memory layout possibly looks something like:
>>>>>>>>
>>>>>>>>     [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>>>>>>>       [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>>>>>>>         [..., 0xff0e08c0)                       stack area
>>>>>>>>           [0xff0e08c0]                           stack pointer
>>>>>>>>         [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
>>>>>>>>         [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
>>>>>>>>       [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>>>>>>>         [0xff0e1000, 0xff0e3800)      10 KiB    code
>>>>>>>>         [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>>>>>>>
>>>>>>>> TPL currently does not touch the malloc area, instead the reserved
>>>>>>>> TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
>>>>>>>> the TPL stack addresses deeper into the BootROM reserved area.
>>>>>>>>
>>>>>>>> Using current offsets for global data and stack does not seem to cause
>>>>>>>> any known issue for BootROM after TPL returns to BootROM to load SPL
>>>>>>>> into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
>>>>>>>> could theoretically change this and cause issues for BootROM.
>>>>>>>
>>>>>>> Here with "any change to [...] code" I suppose you mean any change of global
>>>>>>> data and/or BSS sizes, correct?
>>>>>>
>>>>>> Not only, the change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or 'struct
>>>>>> global_data' would affect where the TPL stack ends up. However, and any
>>>>>> change to the code may change how the stack is used and thus possible
>>>>>> write to more/less/other data inside the BootROM area.
>>>>>>
>>>>>>> As code size itself is checked against
>>>>>>> TPL_MAX_SIZE at build time. Regarding build time checks, I have a couple
>>>>>>> of doubts about [1]:
>>>>>>> - shouldn't we check for less than or equal against TPL_MAX_SIZE, instead of
>>>>>>>     strictly less than?
>>>>>>> - shouldn't be more correct to check the TPL "footprint" size against the 10
>>>>>>>     (or 11 or 12) KiB limit, instead only the code size?
>>>>>>
>>>>>> Correct, this was also briefly discussed/mentioned in the v2 thread. However,
>>>>>> this patch only tries to address the issue with TPL stack being placed inside
>>>>>> BootROM reserved area.
>>>>>
>>>>> Indeed. I was just wondering if in a future patch we should avoid TPL_MAX_SIZE
>>>>> configuration, and instead have just TPL_MAX_FOOTPRINT configured to 0x3000
>>>>> adding GD_SIZE and TPL_SYS_MALLOC_F_LEN in the linker check.
>>>>>
>>>>
>>>> I had never heard of that symbol before and went checking. It has never
>>>> been used (there isn't even a Kconfig symbol for it!) so we would need a
>>>> bit of work to make this work (probably not a crazy amount though :) ).
>>>>
>>>> I'm not sure we still need arch/arm/mach-rockchip/u-boot-tpl-v8.lds
>>>> though. It's only used for evb-px5_defconfig, all PX30, all RK3328, all
>>>> RK3399 and RV1126.
>>>> I think it was necessary when added back in 2019 because
>>>> arch/arm/cpu/armv8/u-boot-spl.lds didn't allow yet to remove the SDRAM
>>>> part in it (c.f. 3cbec0ad090f ("rockchip: add u-boot-tpl-v8.lds") which
>>>> claims "we don't have both SRAM and SDRAM in TPL" but we have SRAM
>>>> access in TPL, don't we?), but that has changed since 2024. They are a
>>>> bit different though and I have no experience with linker scripts so no
>>>> clue if it makes sense to merge them (if at all possible). I'm guessing
>>>> the additional asserts would make sense for everybody anyway.
>>>
>>> Me too, almost no experience with linker scripts. Anyway, I had a quick look
>>> at arch/arm/cpu/armv8/u-boot-spl.lds for TPL building purpose, and IMO it's
>>> broken by design because of SPL specific configuration options dependencies:
>>> SPL_SEPARATE_BSS and SPL_RECOVER_DATA_SECTION. I will check more in depth.
>>>
>>
>> We can always migrate those to CONFIG_IS_ENABLED(SEPARATE_BSS), 
>> CONFIG_IS_ENABLED(RECOVER_DATA_SECTION), CONFIG_VAL(BSS_START_ADDR), 
>> CONFIG_VAL(BSS_MAX_SIZE), etc., if needed.
> 
> I did a quick test with my TPL stubs on RK3568 and RK3528 and we can
> likely use arch/arm/cpu/armv8/u-boot-spl.lds after your suggested
> changes.
> 
> However, we must also ensure to disable TPL_SEPARATE_BSS and not let it
> use the default TPL_SEPARATE_BSS=SPL_SEPARATE_BSS, and also ensure that
> TPL_MAX_SIZE is defined, as it will define the LENGTH of the MEMORY,
> i.e. work as a built in size check that image+bss fit inside .sram.
> 
> And then we possible could to add a new size check, or possible manually
> just ensure that TPL_MAX_SIZE is reduced by GD_SIZE, TPL_SYS_MALLOC_F_LEN
> and a guestimated usage need for the runtime stack.
> 
>>
>>> BTW, the .sram MEMORY segment definition in the script would do the game: here
>>> the size that linker would check against TPL_MAX_SIZE includes BSS (consider
>>> the case SPL_SEPARATE_BSS not defined, of course), while u-boot-tpl-v8.lds
>>> checks size without BSS against TPL_MAX_SIZE.
>>>
>>
>> We would have the same behavior of size checking if we had 
>> TPL_SEPARATE_BSS enabled I believe. But if we had TPL_SEPARATE_BSS 
>> enabled, then we would have an .sdram section too, which is the reason 
>> for having a separate linker script in the first place.
> 
> Correct, we should use TPL_SEPARATE_BSS=n if we want to replace the
> custom rockchip tpl armv8 linker script and keep current behavior.
> 
>>
>> I'm also not sure about IMAGE_TEXT_BASE (set by CONFIG_TEXT_BASE) only 
>> used in the armv8 linker script and the first
>>
>> . = 0x00000000;
>>
>> in Rockchip's TPL linker script.
> 
> It does not seem like this line is needed in the linker script.
> 
>>
>> But maybe we should really have BSS part of the size check.
> 
> As mentioned above, with a TPL_MAX_SIZE the .sram LENGTH is assigned and
> we get a built in size check, e.g. using TPL_MAX_SIZE=0x100 stop build:
> 
>     LD      tpl/u-boot-tpl
>   /usr/bin/aarch64-linux-gnu-ld.bfd: address 0xfe481570 of u-boot-tpl section `.text' is not within region `.sram'
>   /usr/bin/aarch64-linux-gnu-ld.bfd: u-boot-tpl section `.rodata' will not fit in region `.sram'
>   /usr/bin/aarch64-linux-gnu-ld.bfd: address 0xfe481570 of u-boot-tpl section `.text' is not within region `.sram'
>   /usr/bin/aarch64-linux-gnu-ld.bfd: address 0xfe481570 of u-boot-tpl section `.text' is not within region `.sram'
>   /usr/bin/aarch64-linux-gnu-ld.bfd: region `.sram' overflowed by 1464 bytes
>   make[2]: *** [scripts/Makefile.xpl:546: tpl/u-boot-tpl] Error 1
> 
>>
>> I'm out of my depth here though, no clue what would be proper.
> 
> For my forth coming TPL refactor series I tried to sync a few changes
> into the Rockchip custom linker script, probably better to try and drop
> it instead.
> 
> On a side note, the TPL stub runtime tests on RK3568 and RK3528 revealed
> that in special cases we possible could use the BootROM stack, but I
> still think that can be risky and that it is safer that we keep U-Boot
> TPL stack and malloc area separate from the BootROM stack.
> 
> Test run of TPL stub on RK3528:
> 
>   U-Boot TPL 2026.10-rc5 (Sep 28 2026 - 20:23:41)
>   x0: fe480458
>   x1: 00000008
>   x2: fe481000
>   sp: fe480ef0
>   DRAM init failed
> 
> Test run of TPL stub on RK3568:
> 
>   U-Boot TPL 2026.10-rc5 (Sep 28 2026 - 20:22:26)
>   x0: fdcc0098
>   x1: 00000008
>   x2: fdcc1000
>   sp: fdcc0f30
>   DRAM init failed
> 
> Above is the values x0, x1, x2 and sp register had when BootROM called
> the TPL code.
> 
> The stack pointer seem to be near the end of the BootROM reserved area.
> Not sure what x0 or x1 values could be, but x2 seem to match
> TPL_TEXT_BASE, so possible the address BootROM called/jumped to.

I did similar testing on a RK3288 TinkerBoard-S, it seem to reveal that
we are currently limiting TPL size to 32 KiB, however using the entire
96 KiB SRAM on RK3288 seems to be working.

With u-boot-tpl.bin that is 0x878 bytes:

  U-Boot TPL 2026.10-rc5 (Sep 29 2026 - 07:32:40)
  0: 32334b52 ("RK32")
  1: eaffffff
  2: ffffffff
  3: ff704882 (payload size?, 0x878 vs 0x882)
  4: ff702964
  5: 00000002
  6: 00000000
  7: ff703790 (sp)
  DRAM init failed

and with u-boot-tpl.bin that is 0x13878 bytes (.space 0x13000 padding
before reset symbol):

  U-Boot TPL 2026.10-rc5 (Sep 29 2026 - 07:38:06)
  0: 32334b52 ("RK32")
  1: eaffffff
  2: ffffffff
  3: ff717882 (payload size?, 0x13878 vs 0x17882)
  4: ff702964
  5: 00000002
  6: 00000000
  7: ff703790 (sp)
  DRAM init failed

I will try to run similar tests on my other RK SoCs to see how they
behave and to verify rkcommon.c limit matches actual limits.

Regards,
Jonas

> 
> Also x3-x7 did not seem to have any useful values or they changed each
> board reset.
> 
> What I take away from all above is that I will shortly update my rk3562
> work-in-progress branch to also define TPL_MAX_SIZE to be the result of
> TPL_STACK-TPL_TEXT_BASE for all added TPL stubs.
> 
> Regards,
> Jonas
> 
>>
>> Cheers,
>> Quentin
> 

