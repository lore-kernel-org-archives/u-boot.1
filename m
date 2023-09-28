Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88783E7F14F
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 00:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAFF786D7F;
	Thu, 28 Sep 2023 02:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HJMUdxMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31DE86D85; Thu, 28 Sep 2023 02:01:45 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D2F086BE7
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fe99a5f29so116611639f.1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695859302; x=1696464102; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CY7Fm4NB7pOvr6U+nC0tfgESroVfFORFoIi3Y6C9FhI=;
 b=HJMUdxMRCpZnYfdYgu5J8w3wN9dhGCtHvCdquTH+AtmlDaP4fKQhB70lnurheUrE5U
 duwLeDfEGpqCSG5xrRlen0YXdPCsGJ3p2n3CnJtajyBSUJLV+ACtEboZ7I/WLhLtl1bB
 EcxuJ/amyzpS49XGmSxXJ8FLAgFJq0AtySqwFxIVGzOp91lnNJ69DaIyVvUCk9k26rSY
 ImGs9Dvm0s59Rrb0pDeCUNrECNBmcoDnfs04SgWrgGIxbmpu8VTAGaKGCAQoQbbHcZ+S
 rcpBrxdh3i95s7PSBhrq/6EGSOaIVjnlIyYXiH/gQ+bas0lh32relDHgtmbM5eCp/kJC
 ti5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695859302; x=1696464102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CY7Fm4NB7pOvr6U+nC0tfgESroVfFORFoIi3Y6C9FhI=;
 b=IvI1kl7H6EEHANCVRMPrk/QmGedt4xn9S8a8oZP9VSeeAQ45SdnsFP6zUoEtXaBQmm
 tYOhUwjyvPbvLeeqWOsbb+7T3rS8FTF75i28hNxn6sARRHCgkI6n6NeNegrzOxDb73wo
 OQwKHpFTWVXVdRlsdMkiDoHdET0yohANY22LQrqmoaJx2rOzPIl0Aii42utMJvCNkjB2
 tCxfQ23rZPHAMYWn6eMiAniFRWH5nS+m/zdr+lMnQip3nw0z+EAyOfcugIFI5r7d685L
 w3PVo9okIS66iyFNYj6F1LQgNFBS+d697MtRhtkZRBcgH3YepwJkEjBPjL6iyETdLSPI
 t+RQ==
X-Gm-Message-State: AOJu0YwWUQp+LyGhdVhTxom1bvKHtjhr9y5Dr3Q463a3COGInn2m02VD
 4IEJouCLyRyeG7Zjf+eVl7E=
X-Google-Smtp-Source: AGHT+IFbevWaoeSbj/05etgOtbT93ch1O+OtOwvDgYofFLO7FmaWyWw4Nq6km56yLe+uYTFB5n3MVg==
X-Received: by 2002:a92:c561:0:b0:34f:c9b4:5f9e with SMTP id
 b1-20020a92c561000000b0034fc9b45f9emr4824459ilj.19.1695859301870; 
 Wed, 27 Sep 2023 17:01:41 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:e9f:af6b:c19f:be24?
 ([2001:470:42c4:101:e9f:af6b:c19f:be24])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a029692000000b0042b03d40279sm4214903jai.80.2023.09.27.17.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 17:01:41 -0700 (PDT)
Message-ID: <3e7c2548-9fe5-fe49-db24-c52900816fa7@gmail.com>
Date: Wed, 27 Sep 2023 18:01:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] sunxi: psci: implement PSCI on R528
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-5-CFSworks@gmail.com>
 <20230927173105.217f79cc@donnerap.manchester.arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230927173105.217f79cc@donnerap.manchester.arm.com>
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

On 9/27/23 10:31, Andre Przywara wrote:
> On Wed, 16 Aug 2023 10:34:19 -0700
> Sam Edwards <cfsworks@gmail.com> wrote:
> 
> Hi Sam,

Hi Andre,

>> @@ -103,10 +116,13 @@ static void __secure clamp_set(u32 *clamp)
>>   
>>   static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
>>   {
>> -	/* secondary core entry address is programmed differently on R40 */
>> +	/* secondary core entry address is programmed differently on R40/528 */
> 
> I think that's somewhat obvious now from the code, so you can remove this
> comment.

Done, change will be included in v3.

>>   	if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
>>   		writel((u32)entry,
>>   		       SUNXI_SRAMC_BASE + SUN8I_R40_SRAMC_SOFT_ENTRY_REG0);
>> +	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
>> +		writel((u32)entry,
>> +		       SUNXI_R_CPUCFG_BASE + SUN8I_R528_SOFT_ENTRY);
>>   	} else {
>>   		writel((u32)entry, SUNXI_CPUCFG_BASE + SUNXI_PRIV0);
>>   	}
>> @@ -124,6 +140,9 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
>>   	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {
>>   		clamp = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWR_CLAMP(cpu);
>>   		pwroff = (void *)SUNXI_CPUCFG_BASE + SUN8I_R40_PWROFF;
>> +	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
>> +		/* R528 leaves both cores powered up, manages them via reset */
>> +		return;
>>   	} else {
>>   		if (IS_ENABLED(CONFIG_MACH_SUN6I) ||
>>   		    IS_ENABLED(CONFIG_MACH_SUN8I_H3))
>> @@ -151,11 +170,27 @@ static void __secure sunxi_cpu_set_power(int cpu, bool on)
>>   
>>   static void __secure sunxi_cpu_set_reset(int cpu, bool reset)
>>   {
>> +	if (IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
>> +		if (reset) {
> 
> I think you can lose the brackets here, since it's a single statement
> branch, even if it spans multiple lines. The indentation should make this
> clear.

FWIW a lot of reviewers insist on braces surrounding *any* multiline 
blocks, even if said block is only a single statement. This is to 
prevent mishaps where another developer comes along later to add another 
statement to the same block (at the same indentation level), but doesn't 
think to look for missing brackets because the block is already bigger 
than one line.

I could go either way on it, but would like to be sure that your 
feedback stands in light of that counterpoint.

>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>> index 0a3454a51a..d46fd8c0bc 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -355,6 +355,8 @@ config MACH_SUN8I_R40
>>   config MACH_SUN8I_R528
>>   	bool "sun8i (Allwinner R528)"
>>   	select CPU_V7A
>> +	select CPU_V7_HAS_NONSEC
>> +	select ARCH_SUPPORT_PSCI
> 
> Please add
> 	select CPU_V7_HAS_VIRT
> here, as the cores are perfectly capable of virtualisation. Granted,
> support for KVM is long gone from Linux, but at least Xen still supports it.

Good catch; will be done in v3.

> And I believe you also need:
> 	select SPL_ARMV7_SET_CORTEX_SMPEN
> At least this is what the other cores do. The PSCI code sets this bit for
> the secondaries, but for the primary core we need to set it as early as
> possible. Probably not a biggie on an A7, in reality, but good to have,
> and be it for correctness and consistency's sake.

That's already enabled down below:
# The sun8i SoCs share a lot, this helps to avoid a lot of "if A23 || A33"
config MACH_SUN8I
         bool
         select SPL_ARMV7_SET_CORTEX_SMPEN if !ARM64

>> diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
>> index b8ca77d031..67eb0d25db 100644
>> --- a/include/configs/sunxi-common.h
>> +++ b/include/configs/sunxi-common.h
>> @@ -33,6 +33,14 @@
>>   
>>   /* CPU */
>>   
>> +/*
>> + * Newer ARM SoCs have moved the GIC, but have not updated their ARM cores to
>> + * reflect the correct address in CBAR/PERIPHBASE.
>> + */
>> +#if defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
>> +#define CFG_ARM_GIC_BASE_ADDRESS	0x03020000
>> +#endif
> 
> I feel this should go into Kconfig. I can make a patch, unless you want to
> beat me to it.

Note that you had previously [1] suggested placing this here, though 
even then speculated that it belonged in Kconfig. I'm probably holding 
off on sending a PSCI v3 until you send your R528 v2, so that might be a 
good place to patch it. I'll remove this hunk if it's unnecessary by then.

[1]: 
https://lore.kernel.org/u-boot/20230531161937.20d37f54@donnerap.cambridge.arm.com/

> Cheers,
> Andre

Likewise,
Sam
