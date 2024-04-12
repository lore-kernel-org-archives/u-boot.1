Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AB8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFBA8800D;
	Fri, 12 Apr 2024 20:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dN7vA6/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F72488020; Fri, 12 Apr 2024 20:50:44 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB14387D64
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-343f62d8124so875483f8f.2
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712947841; x=1713552641; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q99eOkoMaR75qwNiNU/YsTlQUFkMKnjBgosqoMZlTUs=;
 b=dN7vA6/ZOWpMeShsrGwxfVDYRk9anILtPgniX3qRlgPGaAcvZ2Lb0kHAfrtADf3zbN
 +lRjxS1yuvGqK9ZRRfAYDmTyQU+C8m9QH1LwS1/tnLw7torloYI6oAkrD/WLnjEy8aDE
 1dLfr9o8LS4TVebf1IpRPXqOCp4pOQzV9tyVLvr/SgiU4J9AdXVtQAMJAuE6kOffWP3b
 gjUztLbYcJIgUzuoxTwOF0aQDMr/nBxilqnv0dQeqITJ1tqjaBsOwDOOqE5gBKlsQn8X
 yrdaBp4Qi5ykUg6pp9u3zHhKx+YCXGc8keJLl2rzF0rWA42FV3D1R3m555uuJSckgcq8
 Gjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947841; x=1713552641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q99eOkoMaR75qwNiNU/YsTlQUFkMKnjBgosqoMZlTUs=;
 b=GrVLfY9ypdsoItj9DdPpFKhVEZgFn8X8TRWw//iGRBvV8+lQJAjlK5JXBFHFHObXw9
 0NjNsuyGIN253ZmtkoOVhuQ7IqsCc2s/eJTOZRyvcBZzYHD3EYxuMfOreIXE6ro+j/0S
 8mOznrIu+v4+7lzk86hGJXrOIfvHvB2X32PYiNyxjiCu2RGTmhsTzuoLuY9puDk8f9ZY
 560meCWxfXirUwFYBFKZy3Vo0VNjyhNHQeHyd7htpMxfxLlUsntZtQZw/LoxCSEF7kb/
 a3pzfXDVLkBXrzs8DMBoEJgOSGIzAFXxtdEUYrX8T7KLfUiIh0cIuCNiwbCMd/dJx4J9
 YVKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdRruHYoS64TUuu1c5Qm3mrM5llwri9stPw611bJOr1C6NZ+B7IRTFBV/05bgwwk1ActtEHEo6T89dgN+zreqohUHrNQ==
X-Gm-Message-State: AOJu0YxNnyXfYlt1T01B+tBYA+X2xWOUo8Y9de4gWcQumucyD2FhQ0rM
 hQCMSSfIdHKm9p7eHhqqHdAIQ+9cBwYQRyovJXDZogN8ZSPp/Bjw4b+OQTzA9FRq4smgBrIIVcl
 B17E=
X-Google-Smtp-Source: AGHT+IHYuvq5vnZodOpKaR0LLXXnoI5cjJBxfolwpwdNlQX/GxxmvskxD5bS9CUpe4m+uvOMxk7KWA==
X-Received: by 2002:a5d:61c8:0:b0:344:3dd:5092 with SMTP id
 q8-20020a5d61c8000000b0034403dd5092mr2164730wrv.16.1712947840969; 
 Fri, 12 Apr 2024 11:50:40 -0700 (PDT)
Received: from [192.168.114.140] (92.40.204.173.threembb.co.uk.
 [92.40.204.173]) by smtp.gmail.com with ESMTPSA id
 u7-20020adfeb47000000b0033ec9ddc638sm4818474wrn.31.2024.04.12.11.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 11:50:40 -0700 (PDT)
Message-ID: <16d96fa3-4d95-4bfa-beac-6585426dc703@linaro.org>
Date: Fri, 12 Apr 2024 20:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] zfs: Fix unaligned read of uint64
To: mwleeds@mailtundra.com, u-boot@lists.denx.de
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
 <20240407014743.13872-4-mwleeds@mailtundra.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240407014743.13872-4-mwleeds@mailtundra.com>
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

Hi Phaedrus,

On 07/04/2024 03:47, mwleeds@mailtundra.com wrote:
> Without this patch, when trying to boot zfs using U-Boot on a Jetson TX2
> NX (which is aarch64), I get a CPU reset error like so:
> 
> "Synchronous Abort" handler, esr 0x96000021
> elr: 00000000800c9000 lr : 00000000800c8ffc (reloc)
> elr: 00000000fff77000 lr : 00000000fff76ffc
> x0 : 00000000ffb40f04 x1 : 0000000000000000
> x2 : 000000000000000a x3 : 0000000003100000
> x4 : 0000000003100000 x5 : 0000000000000034
> x6 : 00000000fff9cc6e x7 : 000000000000000f
> x8 : 00000000ff7f84a0 x9 : 0000000000000008
> x10: 00000000ffb40f04 x11: 0000000000000006
> x12: 000000000001869f x13: 0000000000000001
> x14: 00000000ff7f84bc x15: 0000000000000010
> x16: 0000000000002080 x17: 00000000001fffff
> x18: 00000000ff7fbdd8 x19: 00000000ffb405f8
> x20: 00000000ffb40dd0 x21: 00000000fffabe5e
> x22: 000000ea77940000 x23: 00000000ffb42090
> x24: 0000000000000000 x25: 0000000000000000
> x26: 0000000000000000 x27: 0000000000000000
> x28: 0000000000bab10c x29: 00000000ff7f85f0
> 
> Code: d00001a0 9103a000 94006ac6 f9401ba0 (f9400000)
> Resetting CPU ...
> 
> This happens when be64_to_cpu() is called on a value that exists at a
> memory address that's 4 byte aligned but not 8 byte aligned (e.g. an
> address ending in 04). The call stack where that happens is:
> check_pool_label() ->
> zfs_nvlist_lookup_uint64(vdevnvlist, ZPOOL_CONFIG_ASHIFT,...) ->
> be64_to_cpu()

This is very odd, aarch64 doesn't generally have these restrictions. I 
got a bit nerdsniped when I saw this so I did some digging and figured this:

1. Your abort exception doesn't include the FAR_ELx register (which 
should contain the address that was being accessed when the abort 
occured). This means your board is running in EL3.
2. It turns out there is an "A" flag in the SCTLR_ELx register, when set 
this flag causes a fault when trying to load from an address that isn't 
aligned to the size of the data element (see "A, bit" on 
https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/SCTLR-EL3--System-Control-Register--EL3-

I'm not sure who's in the "wrong" here, maybe the driver should avoid 
unaligned accesses? But then again, I don't think you should be running 
a ZFS driver in EL3.

I'm not familiar with the Jetson Nano, but maybe there's a documented 
way to run U-Boot so that it isn't executing in EL3? Or if not you could 
also try unsetting the A flag.

If this really is something to fix in the driver, I don't think 
hotpatching every unaligned access with a malloc() is the right solution.

> 
> Signed-off-by: Phaedrus Leeds <mwleeds@mailtundra.com>
> Tested-by: Phaedrus Leeds <mwleeds@mailtundra.com>

regarding your question about re-sending to remove these tags, I'd say 
probably yes, and especially if you're going to send a new revision anyway.

fwiw you seem to have gotten pretty much everything else about the patch 
submission process spot on :)

Kind regards,
> ---
>   fs/zfs/zfs.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
> index 61d58fce68..9a50deac18 100644
> --- a/fs/zfs/zfs.c
> +++ b/fs/zfs/zfs.c
> @@ -1552,35 +1552,53 @@ nvlist_find_value(char *nvlist, char *name, int valtype, char **val,
>   			if (nelm_out)
>   				*nelm_out = nelm;
>   			return 1;
>   		}
>   
>   		nvlist += encode_size;	/* goto the next nvpair */
>   	}
>   	return 0;
>   }
>   
> +int is_word_aligned_ptr(void *ptr) {
> +	return ((uintptr_t)ptr & (sizeof(void *) - 1)) == 0;
> +}
> +
>   int
>   zfs_nvlist_lookup_uint64(char *nvlist, char *name, uint64_t *out)
>   {
>   	char *nvpair;
>   	size_t size;
>   	int found;
>   
>   	found = nvlist_find_value(nvlist, name, DATA_TYPE_UINT64, &nvpair, &size, 0);
>   	if (!found)
>   		return 0;
>   	if (size < sizeof(uint64_t)) {
>   		printf("invalid uint64\n");
>   		return ZFS_ERR_BAD_FS;
>   	}
>   
> +	/* On arm64, calling be64_to_cpu() on a value stored at a memory address
> +	 * that's not 8-byte aligned causes the CPU to reset. Avoid that by copying the
> +	 * value somewhere else if needed.
> +	 */
> +	if (!is_word_aligned_ptr((void *)nvpair)) {
> +		uint64_t *alignedptr = malloc(sizeof(uint64_t));
> +		if (!alignedptr)
> +			return 0;
> +		memcpy(alignedptr, nvpair, sizeof(uint64_t));
> +		*out = be64_to_cpu(*alignedptr);
> +		free(alignedptr);
> +		return 1;
> +	}
> +
>   	*out = be64_to_cpu(*(uint64_t *) nvpair);
>   	return 1;
>   }
>   
>   char *
>   zfs_nvlist_lookup_string(char *nvlist, char *name)
>   {
>   	char *nvpair;
>   	char *ret;
>   	size_t slen;

-- 
// Caleb (they/them)
