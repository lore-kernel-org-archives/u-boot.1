Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3FDCD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 17:37:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6960B84839;
	Sat, 23 May 2026 19:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qzhCOdBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6361A84867; Sat, 23 May 2026 19:37:36 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38ADF846FD
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 19:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CD35F3F2C5
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779557851;
 bh=l0mO9VZOif3noDirNEy84c8tmMAIYg4mIaTuqdUo1iQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=qzhCOdBrgs4VHCsodYuftkAL2kkOWpYoo3zvSeHSI6AfaNJTcoIkOxVSoS3TKSKZc
 vZbQwaGQkyOEBBjFMhp/7j10lMN/QW7Ag1MDGp/ePrfSJwzJdn4W4ryfGmOGtFGF3S
 zco22Szp6erMg1clL3tcfJggEkd7EtRprH4FVz8UhY0ERGFiJlmUpSteWHvhhSO4yk
 rx5vz1rvaymcId/ItTSniIJWlSEeZAWEZNow25T707CL/tjmxAqFlyAR/Q/wd6JeIU
 jjX6kk2ucE3gB/JwyuIzOH14X3roh6ETa3edZYT6/xli5JAMvWHSQAGUIW9toi6njt
 gXjUh1nI6JMiiqYDGrutYeOIf7DdY5jTjXIzgsHszPG5Vqc8ZfoCrXTxaJXhJeA1cC
 pb/Uj62cQlWDKIA0/K9t3yhO+xa2HK4vyM7ESTscIKf5hS2HZqZOomkegLQFvyKcsM
 Ah5icgKTh+N9DIur29Jl1ew3yjQSe/DwTt9PMIsOG9lVEhdSGN8WDyVA8NE/VxWtRl
 N9vvaC/gZwRAGI6cqfvRUkfaO3P3wPyctmSnpLmpkjZFLhTpN7EI7a8M+b9jWqBCvF
 jj1wQ69suH8mwefBsD+0j9UjmNC/sMIzONNO5a3mBN9+DFNjsqSLLwl+M6ZWyBtIlj
 PMu8TMv6OFEgq2YiNR/XcZuo=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4497a0e3acaso7400270f8f.0
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779557851; x=1780162651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l0mO9VZOif3noDirNEy84c8tmMAIYg4mIaTuqdUo1iQ=;
 b=e93UmfDTpn+ND+vdE7lAnKOvYpApuPZ5XiR7WoDBxsPg7OHBOHUaOQhn34ajIRNerb
 TA0Xu08M58s2SPN+J8cATFljHN9yavteZy2pF7aYj+gJGQLDmBv2btlfYfdwoCsO2RaH
 RWvX43OVAylx02PZbVPjI1mrykFLyBC4nRvO7EStO139HV+vpnNSC70LGhWPaWMUB4u+
 R3ZXByprJyhVufmHCQ73PMm0ZkNz/1Ia7t1xmVqo4lOA5GCO2IxdA6fWN4WM9EWqwBq8
 49n3/2BXEec+MkmjFnM5ynNOWFE51EBg1oW0x1l7A+eFALtg6CSWS6MM0Qkhw0uO8Nq2
 ClhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mfFJHtUUlJfR/7pc8dMhFbnaX1oZcNAG7590MJoce94OzXGThj70BlBkK8NAZSnCc8Dqid18=@lists.denx.de
X-Gm-Message-State: AOJu0YwgffRYTwUdqvRAp/th5tLYr2j5axMCYH8pM3PsPYmtSxA+yFPR
 8bgqgvDOG11qxDfNxYF3LFloOEBXMDRv1RsdgfkOstALz4Wa5hOFw0ndvzDJYmijxp+5VYk49IF
 3t2tJOSBw8aiLpI0anVtCtX5XTLTDDqLX26FOMCwSn/2Kf3FqPav0PtHJAfPRh6Svgs1Za0I=
X-Gm-Gg: Acq92OFl14eJHJIvolL1q3yiqOJ5kBX/4k/vKADlhLKRrigKxRWfFI6vUjP3dgTQYXv
 1O/+On77yjo5y343RGkj1Nm4A8Q8IfVKnJnDOicy5KUHzeyK36Sc0/yonaXNUHJGkcH6iNisw14
 sM8CuEgso+vIPK18zC4WhwjeclucTT9HAkepFbDkMF6KEe7cY22yyvUH4VRy+pD3yCD1JDfnNSI
 pRdtkKfU9G1zBCmtVq86N5xobb+rh8giIJdYHXUSDD2Nzzc0pExa3R4X7LOPji5qKm6piFzKbIw
 m/FRSm56SjZ3R/i5VwJtHbWq99msUDWe3zchCFim8uMXRQoH5r91ocxDzFO7/JoMF42z3A0xj7p
 wxCe9+vRfqYUT4Sq9/DwsTvzALnawjmnvqSpj3d7+APacgcR93sTLQ2BSEvrmjS250RdocVVuJs
 3sbwQ6GRWqyCtEdgMvwgQXDL5Vxq8tcOEZ+a4INRSRZh8REg==
X-Received: by 2002:a05:6000:1888:b0:45e:b21e:f840 with SMTP id
 ffacd0b85a97d-45eb36924d2mr12876751f8f.8.1779557850563; 
 Sat, 23 May 2026 10:37:30 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:45e:b21e:f840 with SMTP id
 ffacd0b85a97d-45eb36924d2mr12876722f8f.8.1779557850181; 
 Sat, 23 May 2026 10:37:30 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6d7:36c0:5387:dd3f:5758:1303?
 ([2a02:3035:6d7:36c0:5387:dd3f:5758:1303])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd351csm14174299f8f.14.2026.05.23.10.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2026 10:37:29 -0700 (PDT)
Message-ID: <73a65efc-2ae0-4ab4-b801-3598520918b0@canonical.com>
Date: Sat, 23 May 2026 19:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi_loader: use pointers in efi_acpi_register()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-2-heinrich.schuchardt@canonical.com>
 <CAFLszTibYbHunqBHaVNZUkx3mo2nQfWq_S5sqPBog03bp90s2A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTibYbHunqBHaVNZUkx3mo2nQfWq_S5sqPBog03bp90s2A@mail.gmail.com>
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

On 5/23/26 11:38, Simon Glass wrote:
> Hi Heinrich,
> 
> On 2026-05-21T18:50:22, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>> efi_loader: use pointers in efi_acpi_register()
>>
>> Both efi_add_memory_map() and efi_install_configuration_table() expect
>> pointers and not virtual sandbox addresses.
>>
>> We need to convert the virtual sandbox addresses in efi_acpi_register() to
>> pointers in memory before using them.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> lib/efi_loader/efi_acpi.c | 42 ++++++++++++++++++++++++++----------------
>>   1 file changed, 26 insertions(+), 16 deletions(-)
> 
>> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
>> @@ -25,7 +25,7 @@ static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
>>    */
>>   efi_status_t efi_acpi_register(void)
>>   {
>> -     ulong addr, start, end;
>> +     void *addr, *start, *end;
> 
> Making start/end pointers doesn't buy anything - they only feed a
> length calculation and efi_add_memory_map(), which takes a u64 - every
> later use then needs a (uintptr_t) cast, plus (void *) casts on the
> ALIGN_DOWN()/ALIGN() results. Please leave start/end as ulong and only
> convert addr, which is the one that genuinely wants pointer type for
> efi_install_configuration_table()

Yes, using uintptr_t for start and end would eliminate conversions.

> 
>> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
>> @@ -37,39 +37,49 @@ efi_status_t efi_acpi_register(void)
>> +             start = (void *)ALIGN_DOWN(
>> +                     (uintptr_t)map_sysmem(gd->arch.table_start, 0),
>> +                     (uintptr_t)EFI_PAGE_MASK);
>> +             end = (void *)ALIGN((uintptr_t)map_sysmem(gd->arch.table_end,
>> +                                                       0),
>> +                                 (uintptr_t)EFI_PAGE_MASK);
> 
> Do you need the (uintptr_t) cast on EFI_PAGE_MASK ?

EFI_PAGE_MASK and EFI_PAGE_SIZE are 64bit wide. uintptr_t and void * are 
only 32bit on 32bit systems. Removing the conversion leads to an error.

> 
> BTW the use of EFI_PAGE_MASK as the alignment argument is
> pre-existing, but looks wrong: ALIGN(x, a) treats a as the alignment
> and internally computes a-1 as the mask, so this becomes ALIGN(x,
> EFI_PAGE_SIZE-1). Worth a separate fix?

You are right, we must use EFI_PAGE_SIZE here.

Best regards

Heinrich

> 
> Regards,
> Simon

