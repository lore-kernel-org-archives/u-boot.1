Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893E1C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 12:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A5A82935;
	Tue,  6 May 2025 14:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yjzDAyCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E0E8210D; Tue,  6 May 2025 13:33:39 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2FF80C83
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 13:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso48268165e9.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746531216; x=1747136016; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0surjRbBUt2OO9wgLRSf84gwdcyb2hWw0GTIKJ/yeIA=;
 b=yjzDAyCmmOOGpdE9eRS6lkvSWVRAC5dSsMGgNqNXMItf8rAjdxnREp6ljHY75EmJEm
 aA2M+SbeaF2kimVaEQxZuEa+sIxg1Ob5TUQA2kpZUECvdsBEN3HSeJEHiSr+XpCEQQVa
 K+bm311NQwQcamrEpnZyqcQfnQUIOwFPf9VoDXcbL73Ke+6rp+xvcF9dotrJ6xNek0S0
 YTx6K+6qH1YPxIh4gavSg987ABR0tUmsLPOAa6G4BKyvQiDkxfrRfV/iMqSAXvL+xyAZ
 XUEXpKgj6Zf4tuE/aNwp6wx62Yfp9+UcgGPUmkPwLUQqsk1jrVt6GzX1djZz4vyfNT2Z
 FlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746531216; x=1747136016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0surjRbBUt2OO9wgLRSf84gwdcyb2hWw0GTIKJ/yeIA=;
 b=GFaqAWX19Z53+oxXGfE12OghyxvOV5XG99isDwBhEqVB21mwUs9Jcj7KW58sk+AeNi
 Z+Vzvgg2GuJ2qIPhLwL3mE79aX7iC/sdQAo+04MZat5Yl1WCd60kAKOQIfw6PZ8EjV6F
 KPV0r1jY1w86u92WgKuhmjztfzUlTU7e0iyVStCyVThXwlPPEnfbS1tC2Xncftb2TYnM
 QG3NT1XrO7ir6fJoa/tSk879btiJ7Q5B+oh+aboq8iHFIXFd6BBZXy62bsKi6qkH07iA
 oCVicm9cSkQBK/X5+5xTnVEVh/AIEjsgfWYP0X2eUwfYlPzgLmg4vE85nS9pCX5G8sMx
 QtCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvRfoaFGObC8LjgS8TZYzzbEwM9Yf2jh0XL2NtNHN8bO19G66zNajDtnkLuwZ6rS+Mta8QDAs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyxas+foPvlQYJfUNCKC3fi8q9a+N2zljXhq1RsQzi4S+Q1oWga
 PlFNJA2KD/kg1Vq8PWwPk+0dLJR4MVti3RdOjecMmb4qtvvdUmB6aaOqupPwmz4=
X-Gm-Gg: ASbGncvtJLmDumy7BO9joLOkXJOICW16d3PtX/mhFzFGfBZptYgvyNWZI0iGsJQb4lh
 epaK/ILHcWTKDy3wK89OKLo3Ss9ghlyNLbi0+prOAfhTLmad+YcEnynOq6UVxj/Uafv77l5M60o
 NXT1jaNhxuRDc26ksnbQ1Ecsv/itEQ1BjAzizRi2N10NF+7dVYbVQ6mpxfFXZSarF/zEP0r1HLb
 sRDaiq9PC+iWQTybOzU6kLu956vDuWRISv/4Vv2ZDdGKhg6cT9UzbKqQptgpsTqTfti9i50QZJN
 yVNoAs3CFnUxYdikA7HbCxLFzkfA/sEF+ZH9EBrRrSrDr9DmO1KMZnxIsbCU3mjOwrKPv81Kzze
 Mqtvwt3n5CwaIvSo=
X-Google-Smtp-Source: AGHT+IE65bF7P0kFzhPxcM+YnyEAj+yIOz2PfPZ8aFpP80K7ulXJPkmmtheRSPUBb1sTIsMKXJ/8XQ==
X-Received: by 2002:a05:600c:5290:b0:43d:fa59:bcee with SMTP id
 5b1f17b1804b1-441c49340e5mr86564885e9.33.1746531216095; 
 Tue, 06 May 2025 04:33:36 -0700 (PDT)
Received: from [192.168.1.47] (37-60-142-46.pool.kielnet.net. [46.142.60.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89d1548sm166348525e9.11.2025.05.06.04.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 04:33:35 -0700 (PDT)
Message-ID: <7939ced4-c3e5-44cf-8888-6e03d8ec37b4@linaro.org>
Date: Tue, 6 May 2025 13:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
 <aBm2gwHIbcRwTd_F@sumit-X1>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aBm2gwHIbcRwTd_F@sumit-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 06 May 2025 14:32:15 +0200
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



On 5/6/25 09:13, Sumit Garg wrote:
> Hi Casey,
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
> I gave this patch-set a try on RB1, but somehow the firmware capsule
> update didn't worked for me. I was able to install the firmware capsule
> update using the "fwupdtool" from the OS but U-Boot can't consume it
> from disk upon a reboot as follows:
> 
> Update capsule is present in EFI system partition as:
> 
> => ls mmc 0:47 EFI/UpdateCapsule/
>              ./
>              ../
>    1794156   fwupd-77f90b51-588c-5ef0-aab9-046aeb2ac8c5.cap
> 
> 1 file(s), 2 dir(s)
> 
> However, it can't be picked via a manual/automatic capsule update
> process in U-Boot:
> 
> => efidebug capsule disk-update
> =>
> 
> Is there a known issue? After enabling debug logs, I see the capsule
> update invocation bails out from here [1].

Yes, this is a known issue. I was able to work around it by running 
`eficonfig` and creating an entry pointing to the same partition, then 
the EFI framework knows what you "boot device" is, since there is no 
default.

I spoke with Ilias about this and we think it's appropriate to bypass 
this check if the option is enabled to ignore OS indications, but didn't 
get aroudn to implementing it yet.

Kind regards,

> 
> [1] https://source.denx.de/u-boot/u-boot/-/blob/master/lib/efi_loader/efi_capsule.c?ref_type=heads#L1037
> 
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

