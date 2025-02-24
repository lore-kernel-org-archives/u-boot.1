Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D71CC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 18:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8304C80F56;
	Mon, 24 Feb 2025 19:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740420526;
	bh=wZDjVI4SqEFJiq9eUGVvo9atE2tgnRSGUVr9JKDZLMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PmQq4QEgV1lZrWVEranR6zqn0hVoIXdCrp/AI66928vxNB1275sfEXDXkO1wRxFKE
	 rcbziI2FNAeeC8sthU/JYo47CUVvrRMqZNTvsROvRBPvIB7mnTaqkOkgDE7kqINcjh
	 FBpLwW1q/zANkMWTUIYwYnn+mDQfx9ae7V2QZ5lT9tHff2uaqEj7GaxIhNXmB8Wdww
	 6H13guvxDAf9sv65s0gXh8bvjjspudfDFhzvY4Bm8RlWmEhkcdqUcNS3PpA6or4MKd
	 mFKZhnuAzb380Y8gzZ9TFz3gZkyxiHx8S3lYyfGkSEJidmNS1kMAhFPFC+3eylVhEd
	 ce9s+gttcqCdg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9A180079; Mon, 24 Feb 2025 19:08:44 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA1980977
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 19:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hSEGhFXB"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A48F510382F23; Mon, 24 Feb 2025 19:08:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740420521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZDjVI4SqEFJiq9eUGVvo9atE2tgnRSGUVr9JKDZLMk=;
 b=hSEGhFXBVjYrn2Tld/13XbjQAWKHxZaarHgXbKQnzV3oxhx9lOeEuxhrfoFCnf7rHBr77T
 vqN1mnHTKWf4LKf87E1lj5jt3PBcM25AAlAcnJYNed7+Ei6D+iDWvpR0A3BS21Hi4w8tHN
 XIMqkXw2T5F72nQHqatoJ8dBaGamacN3lwybLTofJThNIHoTXDkbmzXrHumHMYy+Xh2bbq
 22A0p7atFgaL3nXtd0p1PAt7S/OEeF69QiQ9aQFcHl1vdIso3DDXyatoNlqP29KcvQQUwM
 RmtCRuRzcldzF4jGfhgnV5h8yFPtpjtcuRf3cI+cLm7wQMRxHYoZQv+B5a1gEg==
Message-ID: <4f3debd4-6bba-4cfe-8d83-03687341591f@denx.de>
Date: Mon, 24 Feb 2025 18:50:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] env: mmc: Clean up env_mmc_load() ifdeffery
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250221184732.202336-1-marex@denx.de>
 <20250221184732.202336-2-marex@denx.de>
 <5d777137-7d45-456c-8098-be65c1e8f62e@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <5d777137-7d45-456c-8098-be65c1e8f62e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 2/24/25 10:48 AM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 2/21/25 7:47 PM, Marek Vasut wrote:
>> Rename the variants of env_mmc_load() for redundant and non-redundant
>> environment to env_mmc_load_redundant() and env_mmc_load_singular()
>> respectively and convert the env_mmc_load() implementation to use of
>> if (IS_ENABLED(...)). As a result, drop __maybe_unused from
>> mmc_env_is_redundant_in_both_boot_hwparts().
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Dragan Simic <dsimic@manjaro.org>
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> V3: New patch
>> ---
>>   env/mmc.c | 25 ++++++++++++++-----------
>>   1 file changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/env/mmc.c b/env/mmc.c
>> index 353a7ce72fb..2ef15fb72e7 100644
>> --- a/env/mmc.c
>> +++ b/env/mmc.c
>> @@ -205,7 +205,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int 
>> copy)
>>   }
>>   #endif
>> -static bool __maybe_unused 
>> mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
>> +static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
>>   {
>>       /*
>>        * In case the environment is redundant, stored in eMMC hardware 
>> boot
>> @@ -448,13 +448,7 @@ static inline int read_env(struct mmc *mmc, 
>> unsigned long size,
>>       return (n == blk_cnt) ? 0 : -1;
>>   }
>> -#if defined(ENV_IS_EMBEDDED)
>> -static int env_mmc_load(void)
>> -{
>> -    return 0;
>> -}
>> -#elif defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT)
>> -static int env_mmc_load(void)
>> +static int env_mmc_load_redundant(void)
>>   {
>>       struct mmc *mmc;
>>       u32 offset1, offset2;
>> @@ -510,8 +504,8 @@ err:
>>       return ret;
>>   }
>> -#else /* ! CONFIG_SYS_REDUNDAND_ENVIRONMENT */
>> -static int env_mmc_load(void)
>> +
>> +static int env_mmc_load_singular(void)
>>   {
>>       ALLOC_CACHE_ALIGN_BUFFER(char, buf, CONFIG_ENV_SIZE);
>>       struct mmc *mmc;
>> @@ -556,7 +550,16 @@ err:
>>       return ret;
>>   }
>> -#endif /* CONFIG_SYS_REDUNDAND_ENVIRONMENT */
>> +
>> +static int env_mmc_load(void)
>> +{
>> +    if (IS_ENABLED(CONFIG_ENV_IS_EMBEDDED))
>> +        return 0;
>> +    else if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
>> +        return env_mmc_load_redundant();
>> +    else
>> +        return env_mmc_load_singular();
> 
> The else (not its content!) could be removed since all conditions above 
> return.
> 
> Isn't this going to be increasing the size of the binary with code that 
> won't be run or is the compiler smart enough to remove that based on the 
> IS_ENABLED() that are constant false at build time?
If that was to be the case, then IS_ENABLED() would be entirely 
pointless in the first place, right ?
