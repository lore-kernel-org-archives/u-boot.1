Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB681C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC7288080;
	Fri, 12 Apr 2024 20:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PbdtuKMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83D0881FA; Fri, 12 Apr 2024 20:57:45 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DBCA88020
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d87660d5dbso11418551fa.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712948262; x=1713553062; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xomxgqf/FBpGVvSEdeZMxCFACsbVXX9hSEObY+NCTCM=;
 b=PbdtuKMFn495BXGqfoUJVGStvk67610EXmJC9ejCsmZ2zZYk9bkUH/aI0l+Nu279/3
 Tp+0TeU7cjI4Y1yQW7xoaLZ5Mza/o+GoPCY2GAqzlJejVUiKpo2P6PD023idlveSNoZJ
 4eb5i426W1kNGz8625G91Q3j9iPdGU522/kR4ByyRfyQtnpndmpeWeCCjVHUUvT7rok/
 H+C1Iu5rOVEXYOpCO8Ij6CzEfs/7Rag1d4s1BDESQ1eUv/d+rBbTmqKlkw9M+THVg34b
 jYtQbO9TRqetYClhFWdTch6hDcnk4GupFCATnPa0wKZCrSQNYmW4VMY20a7T42QHo/ke
 G8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712948262; x=1713553062;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xomxgqf/FBpGVvSEdeZMxCFACsbVXX9hSEObY+NCTCM=;
 b=tUps80Jvhrozf2BK5zcdqNQOAoHY8GS5mRPUFqvUeixMX1f0V9EU5CqnySaRxSXRcB
 TpHaEsLaj9W13JrTgZdjLTBiDSCjAC58GZOyec+dQ9WXq91BzD+VhODYQm6MPTM4juR6
 d7IlyT7ZDEcB5myPTF0SghQ/nzlrMJxuE7ElxW9+c7sVIO4w3tsQhoVV5mGsixbT+B2s
 i05fhvmNXyz9zuNTdi6LYRT1injWl0wpjPb4IJGVnU952l9o2NKE2Bqpqj5rMDASrf41
 Z1q9j5DEL8wua3pGN5H+r0CL7ft3k+FHxpKaPCmhjtIjxdszgQxTJhzTdn6ZW/xZq1bU
 Q6lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwkQxJ4IA7ibZ/pv+Wr7Zakce9bKoyy5DNRcHXIwGLFHGjBLp4MNr3V4pLf9NsfEINm2L9ZKplJnNlIq2vn8/RS4iTOA==
X-Gm-Message-State: AOJu0YxmgnQXKhskH+K8BzHns0XQoHOdOp0ZsZ81GV8UpzR4uJ9UhjV2
 OsKt8ev2PLH+ZmIh/Pluk0yGl8NFLx3yA5PSj8pidGEN3PnUuo0hUhZAPG3VDnzVON5seQ7SAFM
 K6aI=
X-Google-Smtp-Source: AGHT+IGh7N+bRqWsCtlB6DQxV3O38vS9t3sXLZWd+4Es24zZuhILNSIXYahGzVp9znbI9W6GzBLIFg==
X-Received: by 2002:a2e:3c05:0:b0:2d8:abb2:6f6e with SMTP id
 j5-20020a2e3c05000000b002d8abb26f6emr2091055lja.21.1712948262211; 
 Fri, 12 Apr 2024 11:57:42 -0700 (PDT)
Received: from [192.168.114.140] (92.40.204.173.threembb.co.uk.
 [92.40.204.173]) by smtp.gmail.com with ESMTPSA id
 z20-20020a05600c0a1400b004180e7b5141sm1581081wmp.36.2024.04.12.11.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 11:57:41 -0700 (PDT)
Message-ID: <fd804a81-c8d4-466b-bc48-f9a21a242c03@linaro.org>
Date: Fri, 12 Apr 2024 20:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] zfs: Fix unaligned read of uint64
From: Caleb Connolly <caleb.connolly@linaro.org>
To: mwleeds@mailtundra.com, u-boot@lists.denx.de
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
 <20240407014743.13872-4-mwleeds@mailtundra.com>
 <16d96fa3-4d95-4bfa-beac-6585426dc703@linaro.org>
Content-Language: en-US
In-Reply-To: <16d96fa3-4d95-4bfa-beac-6585426dc703@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 12/04/2024 20:50, Caleb Connolly wrote:
> Hi Phaedrus,
> 
> On 07/04/2024 03:47, mwleeds@mailtundra.com wrote:
>> Without this patch, when trying to boot zfs using U-Boot on a Jetson TX2
>> NX (which is aarch64), I get a CPU reset error like so:
>>
>> "Synchronous Abort" handler, esr 0x96000021
>> elr: 00000000800c9000 lr : 00000000800c8ffc (reloc)
>> elr: 00000000fff77000 lr : 00000000fff76ffc
>> x0 : 00000000ffb40f04 x1 : 0000000000000000
>> x2 : 000000000000000a x3 : 0000000003100000
>> x4 : 0000000003100000 x5 : 0000000000000034
>> x6 : 00000000fff9cc6e x7 : 000000000000000f
>> x8 : 00000000ff7f84a0 x9 : 0000000000000008
>> x10: 00000000ffb40f04 x11: 0000000000000006
>> x12: 000000000001869f x13: 0000000000000001
>> x14: 00000000ff7f84bc x15: 0000000000000010
>> x16: 0000000000002080 x17: 00000000001fffff
>> x18: 00000000ff7fbdd8 x19: 00000000ffb405f8
>> x20: 00000000ffb40dd0 x21: 00000000fffabe5e
>> x22: 000000ea77940000 x23: 00000000ffb42090
>> x24: 0000000000000000 x25: 0000000000000000
>> x26: 0000000000000000 x27: 0000000000000000
>> x28: 0000000000bab10c x29: 00000000ff7f85f0
>>
>> Code: d00001a0 9103a000 94006ac6 f9401ba0 (f9400000)
>> Resetting CPU ...
>>
>> This happens when be64_to_cpu() is called on a value that exists at a
>> memory address that's 4 byte aligned but not 8 byte aligned (e.g. an
>> address ending in 04). The call stack where that happens is:
>> check_pool_label() ->
>> zfs_nvlist_lookup_uint64(vdevnvlist, ZPOOL_CONFIG_ASHIFT,...) ->
>> be64_to_cpu()
> 
> This is very odd, aarch64 doesn't generally have these restrictions. I 
> got a bit nerdsniped when I saw this so I did some digging and figured 
> this:
> 
> 1. Your abort exception doesn't include the FAR_ELx register (which 
> should contain the address that was being accessed when the abort 
> occured). This means your board is running in EL3.
> 2. It turns out there is an "A" flag in the SCTLR_ELx register, when set 
> this flag causes a fault when trying to load from an address that isn't 
> aligned to the size of the data element (see "A, bit" on 
> https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/SCTLR-EL3--System-Control-Register--EL3-
> 
> I'm not sure who's in the "wrong" here, maybe the driver should avoid 
> unaligned accesses? But then again, I don't think you should be running 
> a ZFS driver in EL3.
> 
> I'm not familiar with the Jetson Nano, but maybe there's a documented 
> way to run U-Boot so that it isn't executing in EL3? Or if not you could 
> also try unsetting the A flag.
> 
> If this really is something to fix in the driver, I don't think 
> hotpatching every unaligned access with a malloc() is the right solution.
> 
>>
>> Signed-off-by: Phaedrus Leeds <mwleeds@mailtundra.com>
>> Tested-by: Phaedrus Leeds <mwleeds@mailtundra.com>
> 
> regarding your question about re-sending to remove these tags, I'd say 
> probably yes, and especially if you're going to send a new revision anyway.
> 
> fwiw you seem to have gotten pretty much everything else about the patch 
> submission process spot on :)

Oh, by the way, instead of Tested-by tags, can you add Fixes tags on the 
patches that contain bug fixes?

In case you're unfamiliar, you can generate them like this:

$ git config --global pretty.fixes = "Fixes: %h (\"%s\")"
$ git log --oneline --pretty=fixes <SHA>

Probably for all of yours that will be:

Fixes: 4d3c95f5ea7c ("zfs: Add ZFS filesystem support")
> 
> Kind regards,
>> ---
>>   fs/zfs/zfs.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
>> index 61d58fce68..9a50deac18 100644
>> --- a/fs/zfs/zfs.c
>> +++ b/fs/zfs/zfs.c
>> @@ -1552,35 +1552,53 @@ nvlist_find_value(char *nvlist, char *name, 
>> int valtype, char **val,
>>               if (nelm_out)
>>                   *nelm_out = nelm;
>>               return 1;
>>           }
>>           nvlist += encode_size;    /* goto the next nvpair */
>>       }
>>       return 0;
>>   }
>> +int is_word_aligned_ptr(void *ptr) {
>> +    return ((uintptr_t)ptr & (sizeof(void *) - 1)) == 0;
>> +}
>> +
>>   int
>>   zfs_nvlist_lookup_uint64(char *nvlist, char *name, uint64_t *out)
>>   {
>>       char *nvpair;
>>       size_t size;
>>       int found;
>>       found = nvlist_find_value(nvlist, name, DATA_TYPE_UINT64, 
>> &nvpair, &size, 0);
>>       if (!found)
>>           return 0;
>>       if (size < sizeof(uint64_t)) {
>>           printf("invalid uint64\n");
>>           return ZFS_ERR_BAD_FS;
>>       }
>> +    /* On arm64, calling be64_to_cpu() on a value stored at a memory 
>> address
>> +     * that's not 8-byte aligned causes the CPU to reset. Avoid that 
>> by copying the
>> +     * value somewhere else if needed.
>> +     */
>> +    if (!is_word_aligned_ptr((void *)nvpair)) {
>> +        uint64_t *alignedptr = malloc(sizeof(uint64_t));
>> +        if (!alignedptr)
>> +            return 0;
>> +        memcpy(alignedptr, nvpair, sizeof(uint64_t));
>> +        *out = be64_to_cpu(*alignedptr);
>> +        free(alignedptr);
>> +        return 1;
>> +    }
>> +
>>       *out = be64_to_cpu(*(uint64_t *) nvpair);
>>       return 1;
>>   }
>>   char *
>>   zfs_nvlist_lookup_string(char *nvlist, char *name)
>>   {
>>       char *nvpair;
>>       char *ret;
>>       size_t slen;
> 

-- 
// Caleb (they/them)
