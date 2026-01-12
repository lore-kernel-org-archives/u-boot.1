Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3143DC9EC91
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88990838A5;
	Mon, 12 Jan 2026 14:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NVKPTwOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4468383923; Mon, 12 Jan 2026 14:48:26 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25EB836A3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so1063554866b.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768225703; x=1768830503; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XNF9Seq5+cOSeMjmv5eQ69czlaBi1AlKz2wo8EPljkg=;
 b=NVKPTwOD3mwaTv4X6ZKxqF9Nv3KGPhcIsEGErV50GJ34a4rKSJw0nJYEAEchBeDuA6
 A+je/UwQs7VJKx7OgFvXymTRw8cduJQclglIjIz2elGEu4rnbmcQg/tlt93P3vf1GggB
 7Ts4G0ypTkYpfzYnDIb95nHzRc16lL19tkVZeeZTa8O5nvIEBrHe2T3WmueMKEdFpULQ
 PK4xI+oV5BgL9ughGNZO9NGD5mDlDIWoAHGNrmJbJaVDDXOEb6569MOI+hZt5URKPH4T
 QGkg8dVqLZC61uuT7E7tvj3kagEwXMC+d5Y4nskNtbhZ8Z1ybkbKv9peb+VcbJqSofWE
 cpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768225703; x=1768830503;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XNF9Seq5+cOSeMjmv5eQ69czlaBi1AlKz2wo8EPljkg=;
 b=bVZtTSzQxbqSb6RjqX+Q1ZD249hTGmkRdUc9IN9zX7XMV1shotz60sFFfcwDII1Axb
 UpZbybdmWe63nknK0IPg5JUDRT5F2xIX6lowqKJHeEVtGxgs+pSfW4NKgLeOmQlZJ2AO
 449ER7AdsSBrFT2ziMTu6SOeqI0AISK3GHEgg3k4Azv0yavWGgnsZr6BsNF9BOMrG3Ed
 Zwy2OdDEwJ4uQzdOPZBJSPY71C31EiY+TBSEP0F8QyzNqhLhN8IyKE2r8H4k7BkCC2fD
 CoCtilM0y3PZKQtoMe6x20Oj9HpsS+iAijdkWCwipERLqbhTQDt82rxr8VRbXSqovAho
 XBYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ptDQJvMlwnVjNv1hihB532PZBaokV/5SmfI/M21O3+foR6vRpx+w9IaELbPfQC2jks4wUoQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyGWdCgtigJ61QZ9oku19NAhq4SVVxJcAJYShrNPhN8Jmx0Pm4x
 s7XxrQTIPkHLbu+KFv2/D5EDKC94s82C+VhjS1/L6mh1KMBTncIgLw5D4JFDgzNWp1M=
X-Gm-Gg: AY/fxX42zjgJqCnalXevSHx0Uj0OGIDO7zlPZF1eK6l5buKGCKMczTp3sbP2bOLYJRP
 UyBwkS4rlgqaNr9cAxhITYDE9z9rQ5Y40IWyqyCc4kIFoMvyrw13Uh29iUKePpXWAURwXG0R5Km
 EWQ83+27IEuJj/mmsjkiTQ0Y/CgmO9rjTx1R1LlBmyqANC+gr3ER3BWnF3099NodgS2YFvEAe85
 1Z7qDqQBQwW6DSxS2ITYd/p2LPzYGnshiYxyqDRze01/skdFTNp/8Rgvarb5eXKd9dyyyUofHmY
 5xmxRFNbsMjgOBCHaXorgzH1vNLJu57UXxv3qhjYn6ILN/MEQLQFLqH+Q/gbeL5fM+6T30amWjV
 Xe0Zi11sVCSPnyEC/N5h5hKhn43U8xuD4J0kF4eZMlYWXVI2dxMpSbZVqW2H7TuNqQ09ks8tLga
 /JLZRFaydYa4t7ekaW5mi3u4+H6aS7aRmq7wH0LcfpBtsATczCDKU=
X-Google-Smtp-Source: AGHT+IFnrBAu0HBIfaQCYfhpzzpWnrxebXUmPkJbbDZKdBABlRJPN++ozgef8ywwJRLhS5EfVbBzXA==
X-Received: by 2002:a17:907:94c4:b0:b87:1ffc:bf9b with SMTP id
 a640c23a62f3a-b871ffcc30dmr255817166b.3.1768225702947; 
 Mon, 12 Jan 2026 05:48:22 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86ee5287e4sm720371566b.52.2026.01.12.05.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:48:22 -0800 (PST)
Message-ID: <019a78cc-40fa-4404-97a3-b9145107a7ba@linaro.org>
Date: Mon, 12 Jan 2026 14:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/3] efi_loader: Introduce platform hook for FDT
 selection
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 adrianox@gmail.com, paul.liu@linaro.org, sjg@chromium.org,
 wolfgang.wallner@at.abb.com, javier.tia@linaro.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
 <597c246c-113c-4b88-93bb-22ec5b525b55@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <597c246c-113c-4b88-93bb-22ec5b525b55@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Aswin,

On 10/01/2026 09:30, Aswin Murugan wrote:
> Thanks everyone for all the valuable feedback. I appreciate the detailed
> reviews and want to address the concerns raised.
> 
> I should have been clearer upfront about what makes Qualcomm platforms
> different here. Qualcomm has its own combined-dtb format that's been
> used across Linux products. The format is documented in [1] and the
> combined dtb file is placed in a separate dtb partition
> 
> The combined-dtb file contains multiple DTBs concatenated together as a
> single dtb file, each with Qualcomm-specific properties:
> - qcom,msm-id (platform ID and SoC revision)
> - qcom,board-id (board variant and subtype)
> - qcom,pmic-id (PMIC models - up to 4)
> 
> At runtime, we read hardware info from SMEM (shared memory interface
> with the firmware) and match it against these properties to pick the
> right DTB.
> 
> *Why Existing Approaches Don't Quite Fit*
> 
> After reviewing the feedback from Heinrich, Ilias, Simon & Sumith, I
> realize the core issue is that all the existing U-Boot mechanisms assume
> separate DTB files on the ESP:
> 
> VisionFive2 approach: Uses EEPROM detection in SPL and sets `$fdtfile`
> to point to individual files like `dtb/starfive/jh7110-milkv-mars.dtb`,
> `dtb/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb`
> 
> eficonfig and distro boot: These mechanisms work great for selecting
> between multiple DTB files.
> 
> The common thread is they all expect individual DTB files, while
> Qualcomm's deployment model uses a single combined-dtb.dtb file that
> requires parsing and extraction. This is the fundamental gap we're
> trying to bridge.
> 
>  I agree with Simon that using the weak function approach is not an
> ideal solution. we should be avoiding adding hooks in the EFI loader.
> Instead, we need to handle this at the board level and work with the
> existing `$fdtfile` mechanism.
> 
> *Proposed Approach*
> 
> Based on all the feedback, here's the revised plan:
> For v2:
> 1. In board code: Parse combined-dtb.dtb, extract the matching DTB,
> write to ESP as `dtb/qcom-<board>.dtb`

In board code - this should be a new file in mach-snapdragon with a new
config option.

I don't think it's correct to write to the ESP, that's a very good way
to frustrate users and developers imo. Once the proper FDT has been
found it can be installed as the default for EFI booting by setting
$fdt_addr to point to it (see efi_install_fdt() in
lib/efi_loader/efi_helper.c), as well as setting $fdtfile

This way fdt_addr can be overwritten during boot by the user, and if
there is an FDT found on the ESP then we can be sure it was put there by
the distro or user and it should be used instead.

So in the end the priority of where the FDT is sourced from will look
like this:

1. OS loader (GRUB/sd-boot)
2. FDT loaded/configured by user (e.g. in eficonfig)
3. DTB found on the ESP by U-Boot (based on $fdtfile)
4. FDT from qcom-specific dtb partition
5. U-Boot's own FDT

I think this strikes a good balance without imposing confusing logic on
the user, particularly if there is a nice log message when the FDT is
installed from the qcom combined DTB.

Kind regards,

> 3. Set `$fdtfile` to point to the extracted file
> 4. Let standard EFI mechanisms handle the rest
> 5. Drop the weak function approach entirely
> 
> Does this approach address the concerns raised, or suggest a different
> direction? I'm particularly interested in feedback on runtime DTB
> extraction to ESP is acceptable, or if there's a better way to bridge
> between our combined-dtb format and U-Boot's expectations.
> 
> [1] https://docs.qualcomm.com/doc/80-70023-27/topic/
> configure_and_secure_boot_with_systemd_boot_and_uki.html#multi-dtb-support
> 
> Thanks,
> Aswin
> 
> On 1/6/2026 5:51 PM, Aswin Murugan wrote:
>> This RFC patch series introduces a weak function hook to allow
>> platforms to
>> provide custom device tree selection logic while keeping common EFI
>> loader code generic.
>>
>> Background:
>> Currently, EFI loader supports loading a single DTB file.
>> Qualcomm platforms require special multi-DTB selection logic that:
>> - Reads hardware information from SMEM (Shared Memory)
>> - Selects the appropriate device tree from a combined DTB file based on:
>>    * Platform ID (SoC variant)
>>    * Board variant and subtype
>>    * PMIC configuration
>>    * SoC revision.
>>
>> Solution:
>> Introduce `efi_load_platform_fdt()` as a weak function:
>> - Weak implementation in lib/efi_loader/efi_fdt.c (defaults to no-op)
>> - Called from efi_bootmgr_run() after efi_load_distro_fdt()
>> - Qualcomm override in arch/arm/mach-snapdragon/efi_fdt_qcom.c
>>
>> Aswin Murugan (3):
>>    efi_loader: Add platform hook for FDT loading
>>    soc: qcom: smem: Added socinfo header file
>>    mach-snapdragon: Implement Qualcomm multi-DTB selection
>>
>>   arch/arm/mach-snapdragon/Makefile       |   1 +
>>   arch/arm/mach-snapdragon/efi_fdt_qcom.c | 339 ++++++++++++++++++++++++
>>   include/soc/qcom/socinfo.h              | 114 ++++++++
>>   lib/efi_loader/efi_fdt.c                |  34 +++
>>   4 files changed, 488 insertions(+)
>>   create mode 100644 arch/arm/mach-snapdragon/efi_fdt_qcom.c
>>   create mode 100644 include/soc/qcom/socinfo.h
>>

-- 
// Casey (she/her)

