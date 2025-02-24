Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E6DC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 18:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41EF080079;
	Mon, 24 Feb 2025 19:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740420524;
	bh=tuZKSx4Nsn4IWpmXxO1S//2rRzImqBs+cPrjWkauzV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k+XL5yfq3OD679+0NNQdbQd0TL7ELRNZUXmtEiDHhYMUt5hOu7LtHvhoNgVl+2FIe
	 P7e+mLn9O4Voa7OrS5TymA5tmZDTLucJzGbXAEyOJj2OQMdBFVhuF70ce4FNLgv8R4
	 JY1EKvBG3LW28SbaeHSrEILL6035eNRwlpon2vBMhY3Z4RhIBe3dT7gf+mMIetep1o
	 md5Slgjfo5I77vye9NFO66hHiYgs4KZpIB8m0LHlCiU0ibGD9UTSNMqoQcq/LjeB8H
	 7o7guObfACv5hSXporY4yO0ADezmQxs0Vq7KG4AMtTucdpWxPXr54LqXgudpUPgFGn
	 PUulI8dvnbRbA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA5180F53; Mon, 24 Feb 2025 19:08:43 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3439780079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 19:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YP7a9Lz3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D57B810382F1F; Mon, 24 Feb 2025 19:08:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740420520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuZKSx4Nsn4IWpmXxO1S//2rRzImqBs+cPrjWkauzV4=;
 b=YP7a9Lz3gXadMeEagCnTFliZC0JEEqWZg2dyy+iZbsNDXVsRKx9EiMl0LWtyFo1SzkKcKd
 VJrUEzVGXASlZtN69fcbIFxov0Ld72gAschgFhpVQjclL8c212cjTCYiG3K0ZtzoUfGnSK
 rAsnWwtsGaVNMhL28QEkioG2YmGW5xBwr5uIOQrw3JlcWUnpoGm9xyTE2T0+AqwfOiaH2J
 7FVAPjEQ1ATmQSjGx9wZlASTNu7xFVdZibXcAiqKTBxj2jrjbZFJZ43A5B06OrTSykXFE4
 wZWKWEDfGucwFhzwmnimabNCE3b3utoHz9j5hGlWjqHRkhasX2kHwYxKKXhSMQ==
Message-ID: <06a60d0e-bf29-4acd-8728-4abf40248347@denx.de>
Date: Mon, 24 Feb 2025 18:49:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250221184732.202336-1-marex@denx.de>
 <94cf226a-c217-4e5d-bc63-60f5b7c4cb3b@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <94cf226a-c217-4e5d-bc63-60f5b7c4cb3b@cherry.de>
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

On 2/24/25 11:01 AM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 2/21/25 7:47 PM, Marek Vasut wrote:
>> Introduce a new function mmc_env_is_redundant_in_both_boot_hwparts()
>> which replaces IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does
>> almost the same check as the macro which assigned ENV_MMC_HWPART_REDUND
>> did, and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).
>>
>> The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
>> in the last conditional, which does not do plain macro compare
>> (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND), but instead does
>> mmc_offset(mmc, 0) == mmc_offset(mmc, 1). If OF_CONTROL is not
>> in use, this gets optimized back to original macro compare, but
>> if OF_CONTROL is in use, this also takes into account the DT
>> properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.
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
>> V2: - Rename mmc_env_hwpart_redund() to 
>> mmc_env_is_redundant_in_both_boot_hwparts()
>>      - Return bool
>> V3: - Hide the mmc_env_is_redundant_in_both_boot_hwparts symbol behind 
>> __maybe_unused
>>        as this symbol is called from code gated behind ifdef 
>> CONFIG_SYS_REDUNDAND_ENVIRONMENT
>>        in env_mmc_load()
>> ---
>>   env/mmc.c | 37 +++++++++++++++++++++----------------
>>   1 file changed, 21 insertions(+), 16 deletions(-)
>>
>> diff --git a/env/mmc.c b/env/mmc.c
>> index 379f5ec9be7..353a7ce72fb 100644
>> --- a/env/mmc.c
>> +++ b/env/mmc.c
>> @@ -40,18 +40,6 @@
>>   DECLARE_GLOBAL_DATA_PTR;
>> -/*
>> - * In case the environment is redundant, stored in eMMC hardware boot
>> - * partition and the environment and redundant environment offsets are
>> - * identical, store the environment and redundant environment in both
>> - * eMMC boot partitions, one copy in each.
>> - * */
>> -#if (defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && \
>> -     (CONFIG_SYS_MMC_ENV_PART == 1) && \
>> -     (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND))
>> -#define ENV_MMC_HWPART_REDUND    1
>> -#endif
>> -
>>   #if CONFIG_IS_ENABLED(OF_CONTROL)
>>   static int mmc_env_partition_by_name(struct blk_desc *desc, const 
>> char *str,
>> @@ -217,6 +205,23 @@ static inline s64 mmc_offset(struct mmc *mmc, int 
>> copy)
>>   }
>>   #endif
>> +static bool __maybe_unused 
>> mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
>> +{
>> +    /*
>> +     * In case the environment is redundant, stored in eMMC hardware 
>> boot
>> +     * partition and the environment and redundant environment 
>> offsets are
>> +     * identical, store the environment and redundant environment in 
>> both
>> +     * eMMC boot partitions, one copy in each.
>> +     */
>> +    if (!IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
>> +        return false;
>> +
>> +    if (CONFIG_SYS_MMC_ENV_PART != 1)
>> +        return false;
>> +
>> +    return mmc_offset(mmc, 0) == mmc_offset(mmc, 1);
> 
> This is not always equivalent to the current test of
> 
> CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND
> 
> Indeed, it only is for when OF_CONTROL isn't set.

This is what the patch fixes and this is what the commit message states.

> I would recommend to keep this check in patch 1, then add another patch 
> that swaps CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND for 
> mmc_offset(mmc, 0) == mmc_offset(mmc, 1)

What benefit would that bring ?

> This will allow to use DT properties like u-boot,mmc-env-offset- 
> redundant and u-boot,mmc-env-offset, which isn't supported today.

This is what the patch fixes and this is what the commit message states.

[...]
