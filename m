Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76688C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C54082D08;
	Fri,  2 May 2025 17:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OjBYgKGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BF8820EB; Fri,  2 May 2025 14:17:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 352C5801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 14:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso13070825e9.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746188216; x=1746793016; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dnrY6HxWzDaIaCY9wMM1o1QcvFskxsSEuSEs2BfcYQs=;
 b=OjBYgKGDph9/ISKrd/bQHl83/DzRqZFXKqRkhCglLIVU6g0GaTIONNtvLQEo92bajH
 suSsSisbYo0zFexbdblSLgJG02cgV7z/D1fZjNaRgeGkn22u5R5PSRXDhROgVHo9sc2Q
 kV7UMSOfSjhXfRZDllGzp2Qs9uQ/Ab+rutajA2bC1a232La/dASdHJ0Y3SAHROXOPErw
 ZiGXCcygWCCdvfMfWPtkqz3pQ9ZumYvynwHBNSfqhnJ3Ismp1169ed7UIJWSNbU9hxgB
 Yi8n4CrHqJJQRDEQ+oJSoiPxPTiwkJn71tWz23wDeA4aDAF8aS7NHnTAprJo+C61bG5x
 zSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746188216; x=1746793016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnrY6HxWzDaIaCY9wMM1o1QcvFskxsSEuSEs2BfcYQs=;
 b=SGfaFirYNa3Ew2ptdv/Mtvr9GBomyMoMQHq1DuhhFMnqlEeBfJOrGvMo2G36wvtawS
 TXV5+JdcUeIrOc/Rm1BecOEZNWbkkdGnLazBBAXuOvDcaFJWePd7nar2add55EVzGH9l
 7uH7p3wYzfscYrf+Dt2WDeTyLn6dT9YoI65sSknISy6iSe7GQMqTQ6AZdDJ01qnECu/8
 ACYbTwhzUI2Bu+Ec5crl+5MTdhR1/1Q11CreCsZrmiyAwRP0Z4/tXy2MKSbL5LyC0Gnn
 bGZW+ZCWIhogFt9M0Kpqf0cLowYzIS8jMMZqd6aYpHftyPmuopanNTOGKcWxI2BLpg92
 fn/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4/r4QDjNvn/SQ5sgn/lxG4Nk7aYyRQ/iYcWsBnvh5MVgVSStM63hY7Qyq5QoXeXVFqGb/c/k=@lists.denx.de
X-Gm-Message-State: AOJu0YyozaVyrwD5QWY0cL+6M/zN7JGoCuIUvDpzdieRHfQlmuL2QxMp
 VO4CJtqfMo630xNz5yA1dtHkF6dTeubXLUX7S23m7Sf+Vf9w7HBXwwXGXWhX1qs=
X-Gm-Gg: ASbGncun3a3vJ4P3WGsbsjxb8T2qEInY1Td3C5a/W2RclY3YeDLYGddHLMgAA0pWyWH
 xKynfySWJZWkmdntxUco1OFN83N6s6MjjXEXhyqA9WIUyESyLKm6KE1xMR5uoepthqtykgTVueW
 Qo29EKBn7csHifxr/5IeginNMpQc8dEbrfKH7CoSYpQJU5zc+GMCQm13JJjOFWf/B/XEAzO69h2
 NndSCf9txETnMtCq8hFWROJUqIFH3p44sVc4xVuU7ZWfJHej9gDF6opfQff1qUUIFmEIIB+K0zC
 unrsYBgO9Yo+oqxsrS9ijRdlFRf/6ZhM5x1HA8M2TgFb7W+SWN6C1A1kxNKPjwkkPOsLWqjTsN7
 KjfV73g==
X-Google-Smtp-Source: AGHT+IEG4wGPCuURc+E5XeDM+0mhbA+CoU07RAsSEG+aVZPBsSxCFFToFgBQZqkxhWp6jmorbGJPpA==
X-Received: by 2002:a05:600c:1914:b0:43c:f332:7038 with SMTP id
 5b1f17b1804b1-441bbf355ffmr18525645e9.21.1746188216633; 
 Fri, 02 May 2025 05:16:56 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B79.versanet.de. [94.134.59.121])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b287desm89206205e9.38.2025.05.02.05.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 05:16:55 -0700 (PDT)
Message-ID: <3a56b0bb-9446-42f2-9b85-ae65de295499@linaro.org>
Date: Fri, 2 May 2025 14:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
 <aBSjZ7ospvGxJrbD@sumit-X1>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aBSjZ7ospvGxJrbD@sumit-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 02 May 2025 17:01:15 +0200
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

Hi Sumit,

On 5/2/25 12:50, Sumit Garg wrote:
> Hi Casey
> 
> On Fri, Apr 11, 2025 at 05:03:33PM +0200, Caleb Connolly wrote:
>> The initial capsule update support only worked on the RB3 Gen 2 and made
>> a lot of assumptions specific to that board.
>>
>> Implement the logic necessary to update U-Boot no matter where it was
>> flashed to, independent of any particular board.
>>
>> First, we keep track of how U-Boot was loaded, specifically if we had a
>> valid external FDT (even if we didn't use it) this indicates that we
>> were booted via the Android bootloader, in this case the target for
>> capsule updates is the boot partition. Otherwise, we target the uefi
>> partition (if it exists) or the xbl partition. We handle A/B support for
>> all 3 (currently we always flash to the currently active partition with
>> a minor exception for the uefi partition).
> 
> Does this means say if we are booting from "A" partition then the update
> gets applied to "A" partition only? IOW, we don't support dual bank
> updates as of now?

Yes exactly, to have A/B working we would need the following:

* Implement all the fiddly GPT stuff (the vendor bits but also swapping 
the partition type GUIDs between A/B partitions)
* Change MMC/UFS boot block/LUN
* Support flashing all other bootloader partitions via capsule update

And really some tooling to produce said capsule update files containing 
all the bootloader related images.

> 
>>
>> We introduce two new fw_name strings to differentiate the GUIDs based on
>> the target partition, this means one board can support multiple boot
>> methods with capsule update support for all of them (typically this
>> would be chainloading OR flashing U-Boot to XBL).
>>
>> Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
>> scsi_scan() unbinds all scsi devices it breaks device handles maintained
>> in the EFI layer for the duration of the capsule update process and
>> causes the EFI filesystem access to delete the capsule file after the
>> update to fail.
>>
>> Boards should instead be responsible for calling scsi_scan() before
>> initiating DFU.
> 
> Thanks for working on EFI firmware capsule updates feature. I think
> currently we are missing any documentation from this patch-set. IOW, how
> one can test updating U-Boot via EFI firmware capsules? I suppose we are
> using here dynamic GUID generation while creating update capsules,
> right?

Yes, we're using dynamic GUIDs. I have written a small tool and brief 
docs here for creating an LVFS cabinet which can be used with FWUPD

https://github.com/kcxt/mkcab

I'll write something in doc/board/qualcomm to explain things too 
(excluding the LVFS bits).

Kind regards,
Casey (she/they)>
> -Sumit
> 
>>
>> ---
>> Changes in v2:
>> - Restrict the partition hunt to either UFS storage or the first MMC
>>    device so that we never accidentally write to some external storage
>>    (like an sdcard) during a capsule update.
>> - Fix typo
>> - Link to v1: https://lore.kernel.org/r/20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org
>>
>> ---
>> Caleb Connolly (4):
>>        mach-snapdragon: track boot source
>>        mach-snapdragon: CapsuleUpdate: support all boot methods
>>        dfu: scsi: don't call scsi_scan()
>>        qcom_defconfig: enable capsule update support
>>
>>   arch/arm/mach-snapdragon/board.c          |  26 +++
>>   arch/arm/mach-snapdragon/capsule_update.c | 274 ++++++++++++++++++++++++------
>>   arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
>>   configs/qcm6490_defconfig                 |   6 -
>>   configs/qcom_defconfig                    |   3 +
>>   drivers/dfu/dfu_scsi.c                    |   5 -
>>   6 files changed, 266 insertions(+), 62 deletions(-)
>> ---
>> base-commit: 885d68280c29b8011731b6a7cdac32b8d9a4e6fd
>> change-id: 20250326-b4-qcom-capsule-update-improvements-16ff7bc2d1d2
>>
>> Caleb Connolly <caleb.connolly@linaro.org>
>>

-- 
Casey (she/they)

