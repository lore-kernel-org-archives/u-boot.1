Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57531C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 11:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B1388EF0;
	Thu, 25 Apr 2024 13:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yGyuLrDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0981D88F14; Thu, 25 Apr 2024 13:57:33 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CC788F04
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 13:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a55b93f5540so118153666b.1
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714046248; x=1714651048; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CkyvEotfAOEBHgCn92o1G3XQniYF8WIzPwCkcWdlhIw=;
 b=yGyuLrDQ5b+R3ND3EZHsXxmpJ/KR2YO68ISm6ivqlLGQy7A7hLUNmTy5la83UrU3Kp
 sryqZjhOD9xN12GAmIGAoMEyUOZPDSBU1d5aWElk5HoNj9EzHpbQuo6L14bRCQxfzGOd
 ntw0t4y69blT2yoHXKrreCl96BtTi0Y3PLkbr7YTAS59oU9njuGlalNBPS92qj5PlN7P
 3KMbvG015dZY54caOGUEJNvevxbTvCwj5RDz6CCr8m0NIE3P3JAWfuMOwTsg/tRuHqxv
 Ts8HbzpZzAJ8tTvKcZ5uo2pYTZqq/aQ1TftGBnZCFgpplrmh+0u/mw5dHSlUVdB9AN5m
 ZDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714046248; x=1714651048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CkyvEotfAOEBHgCn92o1G3XQniYF8WIzPwCkcWdlhIw=;
 b=V1jcaZQPdWqU7VbU4Ffz2oqLajzbifvOg8nD4Dmx8fC0E5vCjFvsgX9sltXp6M4Urk
 ivRB0yO9QokCA0w8307oz+5KAtSl0HlZ9pL6lleXsDgIea0iFbi5WCcVAZMGT2deGhGS
 1OHdTJuyVm23v4dS1s8wprMyF8rEz3gJyRvmfP6cirzV0uJ6AObt0/MVtJaWxtWB7XTp
 YYXjca/ajGrVdigRlFrbGIOb+T1W9qF0/e2cTNGafnDba41RiXZ9rJcn+J+EpoOQieBn
 zNFrby4mRaa6BuGbtHwUT8n/cZb34bgyTbTCrxKQ4p2OIPpi7s53o8Sd7oyi+DycgG+x
 kDLw==
X-Gm-Message-State: AOJu0YxXOSVyZKJDvfuJ1lbCU55bLzNOLW10EbHJrdRniIrzxhvBRuUT
 mErS7k4vcYPe8StuyTMzNZH6+YaunypD09+RIwLTvoduBNQMcQUNN8miq+XiT7ysPnlIc2nZWUZ
 fg8hesQ==
X-Google-Smtp-Source: AGHT+IGfDaeoh9SyoKulhiSIObotTrMyHDdlCE05gNrMVqc6E2WBj14zLlcrUbBbMjVskMSnmPfrjQ==
X-Received: by 2002:a17:907:6ea8:b0:a51:ddc6:e00d with SMTP id
 sh40-20020a1709076ea800b00a51ddc6e00dmr4873561ejc.26.1714046248125; 
 Thu, 25 Apr 2024 04:57:28 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::dcdd? ([2a02:8109:aa0d:be00::dcdd])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a170906614200b00a588e0e0d9bsm2164845ejl.93.2024.04.25.04.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 04:57:27 -0700 (PDT)
Message-ID: <53b87b44-e87a-4baf-b104-64e62c47263e@linaro.org>
Date: Thu, 25 Apr 2024 13:57:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] zfs: Fix unaligned read of uint64
To: mwleeds@mailtundra.com
Cc: u-boot@lists.denx.de
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
 <20240407014743.13872-4-mwleeds@mailtundra.com>
 <16d96fa3-4d95-4bfa-beac-6585426dc703@linaro.org>
 <yMP4wWXZMjDL0Xi9eeSdNuUBW7pE82Ie-UoUMbNBa7K1Vckv8A4da_KjBUlGkpeQfQsADCJ8z73FxL9AlyQjSJ41TJM1ohjNHzAStZpdhUk=@mailtundra.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <yMP4wWXZMjDL0Xi9eeSdNuUBW7pE82Ie-UoUMbNBa7K1Vckv8A4da_KjBUlGkpeQfQsADCJ8z73FxL9AlyQjSJ41TJM1ohjNHzAStZpdhUk=@mailtundra.com>
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



On 25/04/2024 06:02, mwleeds@mailtundra.com wrote:
> Hi Caleb,
> 
> Thanks for this interesting feedback. I saw these patches were already merged
> since you sent this but I added a few thoughts below anyway.

Ah, a shame.. It would be good to find a scalable solution to this!
> 
> On Friday, April 12th, 2024 at 11:50 AM, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> Hi Phaedrus,
>>
>> On 07/04/2024 03:47, mwleeds@mailtundra.com wrote:
>>
>>> Without this patch, when trying to boot zfs using U-Boot on a Jetson TX2
>>> NX (which is aarch64), I get a CPU reset error like so:
>>>
>>> "Synchronous Abort" handler, esr 0x96000021
>>> elr: 00000000800c9000 lr : 00000000800c8ffc (reloc)
>>> elr: 00000000fff77000 lr : 00000000fff76ffc
>>> x0 : 00000000ffb40f04 x1 : 0000000000000000
>>> x2 : 000000000000000a x3 : 0000000003100000
>>> x4 : 0000000003100000 x5 : 0000000000000034
>>> x6 : 00000000fff9cc6e x7 : 000000000000000f
>>> x8 : 00000000ff7f84a0 x9 : 0000000000000008
>>> x10: 00000000ffb40f04 x11: 0000000000000006
>>> x12: 000000000001869f x13: 0000000000000001
>>> x14: 00000000ff7f84bc x15: 0000000000000010
>>> x16: 0000000000002080 x17: 00000000001fffff
>>> x18: 00000000ff7fbdd8 x19: 00000000ffb405f8
>>> x20: 00000000ffb40dd0 x21: 00000000fffabe5e
>>> x22: 000000ea77940000 x23: 00000000ffb42090
>>> x24: 0000000000000000 x25: 0000000000000000
>>> x26: 0000000000000000 x27: 0000000000000000
>>> x28: 0000000000bab10c x29: 00000000ff7f85f0
>>>
>>> Code: d00001a0 9103a000 94006ac6 f9401ba0 (f9400000)
>>> Resetting CPU ...
>>>
>>> This happens when be64_to_cpu() is called on a value that exists at a
>>> memory address that's 4 byte aligned but not 8 byte aligned (e.g. an
>>> address ending in 04). The call stack where that happens is:
>>> check_pool_label() ->
>>> zfs_nvlist_lookup_uint64(vdevnvlist, ZPOOL_CONFIG_ASHIFT,...) ->
>>> be64_to_cpu()
>>
>>
>> This is very odd, aarch64 doesn't generally have these restrictions. I
>> got a bit nerdsniped when I saw this so I did some digging and figured this:
>>
>> 1. Your abort exception doesn't include the FAR_ELx register (which
>> should contain the address that was being accessed when the abort
>> occured). This means your board is running in EL3.
>> 2. It turns out there is an "A" flag in the SCTLR_ELx register, when set
>> this flag causes a fault when trying to load from an address that isn't
>> aligned to the size of the data element (see "A, bit" on
>> https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/SCTLR-EL3--System-Control-Register--EL3-
>>
>> I'm not sure who's in the "wrong" here, maybe the driver should avoid
>> unaligned accesses? But then again, I don't think you should be running
>> a ZFS driver in EL3.
>>
>> I'm not familiar with the Jetson Nano, but maybe there's a documented
>> way to run U-Boot so that it isn't executing in EL3? Or if not you could
>> also try unsetting the A flag.
> 
> I may look into this if I get a chance. However if I write some assembly code
> to change the execution level or unset the A flag, I worry that the code would
> work fine on the hardware I have (Jetson TX2 NX) but behave differently on

Well, unsetting the A flag might arguably have some niche negative 
outcomes, but I really struggle to see how this is a driver bug to be 
honest...
> another platform. And I don't think I can easily set up testing environments
> with u-boot + zfs on different platforms to find out.

fwiw, if you do intend to investigate this further, I'd be happy to 
validate your assumptions on a Qualcomm board (where we are rather 
boring and running in EL1 or EL2).
> 
>>
>> If this really is something to fix in the driver, I don't think
>> hotpatching every unaligned access with a malloc() is the right solution.
>>
> 
> I'm certainly open to other ideas. The difficulty is the data structure we're
> parsing in this file is read from disk and it's only 4-byte aligned.

According to the ARM docs, the issue is that you're loading an 8-byte 
value from a 4-byte aligned address. If you split it into two 4-byte 
reads (for the upper and lower words) then it should work fine. This 
would avoid the malloc at any rate.

Thanks and regards,
> 
>>> Signed-off-by: Phaedrus Leeds mwleeds@mailtundra.com
>>> Tested-by: Phaedrus Leeds mwleeds@mailtundra.com
>>
>>
>> regarding your question about re-sending to remove these tags, I'd say
>> probably yes, and especially if you're going to send a new revision anyway.
>>
>> fwiw you seem to have gotten pretty much everything else about the patch
>> submission process spot on :)
>>
>> Kind regards,
>>
>>> ---
>>> fs/zfs/zfs.c | 18 ++++++++++++++++++
>>> 1 file changed, 18 insertions(+)
>>>
>>> diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
>>> index 61d58fce68..9a50deac18 100644
>>> --- a/fs/zfs/zfs.c
>>> +++ b/fs/zfs/zfs.c
>>> @@ -1552,35 +1552,53 @@ nvlist_find_value(char *nvlist, char *name, int valtype, char **val,
>>> if (nelm_out)
>>> *nelm_out = nelm;
>>> return 1;
>>> }
>>>
>>> nvlist += encode_size; /* goto the next nvpair */
>>> }
>>> return 0;
>>> }
>>>
>>> +int is_word_aligned_ptr(void *ptr) {
>>> + return ((uintptr_t)ptr & (sizeof(void *) - 1)) == 0;
>>> +}
>>> +
>>> int
>>> zfs_nvlist_lookup_uint64(char *nvlist, char *name, uint64_t *out)
>>> {
>>> char *nvpair;
>>> size_t size;
>>> int found;
>>>
>>> found = nvlist_find_value(nvlist, name, DATA_TYPE_UINT64, &nvpair, &size, 0);
>>> if (!found)
>>> return 0;
>>> if (size < sizeof(uint64_t)) {
>>> printf("invalid uint64\n");
>>> return ZFS_ERR_BAD_FS;
>>> }
>>>
>>> + /* On arm64, calling be64_to_cpu() on a value stored at a memory address
>>> + * that's not 8-byte aligned causes the CPU to reset. Avoid that by copying the
>>> + * value somewhere else if needed.
>>> + */
>>> + if (!is_word_aligned_ptr((void *)nvpair)) {
>>> + uint64_t *alignedptr = malloc(sizeof(uint64_t));
>>> + if (!alignedptr)
>>> + return 0;
>>> + memcpy(alignedptr, nvpair, sizeof(uint64_t));
>>> + *out = be64_to_cpu(*alignedptr);
>>> + free(alignedptr);
>>> + return 1;
>>> + }
>>> +
>>> out = be64_to_cpu((uint64_t *) nvpair);
>>> return 1;
>>> }
>>>
>>> char *
>>> zfs_nvlist_lookup_string(char *nvlist, char *name)
>>> {
>>> char *nvpair;
>>> char *ret;
>>> size_t slen;
>>
>>
>> --
>> // Caleb (they/them)

-- 
// Caleb (they/them)
