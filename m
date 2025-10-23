Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58656CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 12:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C634483631;
	Thu, 23 Oct 2025 14:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XssGj6bH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26A4836AC; Thu, 23 Oct 2025 14:14:52 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A7283677
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 14:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0B1443F7C1
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761221689;
 bh=1yhR43KyBVhpvmQL2K17iI1W1k7frNQSSULs9hsINzA=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
 In-Reply-To:Content-Type;
 b=XssGj6bHH1utHJW9gDkAz/gLUiF98VLqyUQj8tjAvk7xSemxRDBgn/oESHnFfzT4F
 u2APS2/0lZ4BdvRUacRcyfSnZh7hHjZbvVBM5auXdT03n+iQY/p4FPkCrpOt8ce3dB
 36Irgu640rrw9HIW707kzlEbIP0iKh8R/gyWOTb5EJSUGMVIBsGmmjpyqXoTlZ4QTI
 Zo+5KT2KC0028ZkuBXlR6yGiqAmCXnryPs/JkYHBp8+MXZEDvjlPIxrP8dUV5eF1v8
 3IIgxC+9357BIjRYCXV4xRT1Sn8mw2kXKKMKKFlzJWlZbrp/Q+nRjQijdWNvhvb8Uq
 o47BHdgebaDnQ+yjwYW8HBRzK9jo9Gimekg7KLcYuLVX9remsb18lBm6OwGhOFnyQ0
 HNT6BBC5AMJ/BySn/u3IdJV4uKHWE8GXLSkoBRuCP9C1/SUwjbUIo68CyeDWeq9/jj
 hymvldXavY730u5whw5gRXZkFaWR4+AkZUjF2cgHVxyd/hThMNKUwF+byjIfNQ+ez/
 N2nJ8fy6+Kn7TTu+bdQMNHe+AYH+cDJadJ5IcBGrzlGFS+vOlj+iZmJncFT1Q1Z6Ga
 RAt1g2f7dEZSzDvGH2tMDJTX+KDLv+sjfCU87+cD6/A2yU+MGhpWXj1tWCEE0LOCIQ
 7wSr6JqCGhziEqdV6dWT/rMc=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4298955a6d9so647952f8f.0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 05:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221688; x=1761826488;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1yhR43KyBVhpvmQL2K17iI1W1k7frNQSSULs9hsINzA=;
 b=D60gTvSMVsmGhZTLHeRhovPYzxIPHAa3OUu+RLvu2kjNX77vzhHtt5EHEeT5HZ+uQJ
 CXgSPRN04V6nciRZMcw0FVxi6Xnx2Shd3t9Lv2xWCuwCqAJLP442IOapWc7nCpjXQFla
 pb27cfXY6OAay3R2NzhDyphA4KYXEzd7XhHhAJkb6oOLNIPCy7822KQKQuRzZPDTzoMr
 oVdljXIHWWNLg5Vcppuwtz+bZqDkuXiI6jC85xJmqCD61lsn89DY+VV1cwqXNKl+sekr
 GhsPu16b+tPh7xeMgjM+yoxxEGb+eWBtQAuB3K/bQVpITLbf5Nlf2Fpz0nNU1XfJYAlh
 r2RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoKhSqcmwHyClGDLaN5r0yudBPSRkmlL1/y/D27vdTG/JfKlNlxMjbpiQPrLskBn4lL5V2COo=@lists.denx.de
X-Gm-Message-State: AOJu0YwJB9/abtfyP68nZFxW99LyG+gD0btck/j1ojYG6y/ao2FP3qN+
 kT2EKfwDkXLFrgs5F3pTWAS1ofml3LApi4n5zrPv7sJSyAPTWNEjie8qWfhXbk/IuC5Z7fEmzVF
 toQ4Pt4AH51rqVV3f4buwvK6wf/vArNvjQLL9Yr7UHoBO8uioK3zmpgVOMRz5cYCdRjRNekA=
X-Gm-Gg: ASbGncugGGvsPJb1hKeCipL9SEj0SJCnjfPNgj7njPOjq8D3NsdT8iuS3YyZZseGl06
 Qci3hxgAFPFWCfe+aU1z6qhirPjbmAeWN5JWo6iaTAzMigin0xHiRu6vIW/NYPeX+VHUKdF3Ou1
 9qrIxgYZwR8xg2xqpI5Gthb3GLrGf+LTZYwXhSR+L3EXrp3VFi06YXmcExspC04G/ADKyCt0ULc
 DYU1NOD6YABtYRWCOiwJ6DscBmxcoUYNSBUQ+Y+UZ4iZao/lN9X2EvrAK5YSadmcvbxf3lAsscT
 avPqXjSLNUxwmx+QKx/kHCWE4j15f5r1ldT6GSojoDz1Cs+Uj7UrZ7Z32dnDsek8PfDI1pJrHyY
 P+4WUfnj3YHEcwv5YubKY50hR6ZiRm8tI+D4UQuTK4PNvGgUIasxvIvg2OWDglNw=
X-Received: by 2002:a05:6000:3111:b0:3ea:a694:ae0a with SMTP id
 ffacd0b85a97d-42704db9f9dmr15524966f8f.48.1761221688579; 
 Thu, 23 Oct 2025 05:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvDU1IYWsnh7nbgDvdPZsMVxQkbkZ5GczZxVHYmWMcNgXFtO6IPmrzcM1YC43/wg2IVjmEXA==
X-Received: by 2002:a05:6000:3111:b0:3ea:a694:ae0a with SMTP id
 ffacd0b85a97d-42704db9f9dmr15524952f8f.48.1761221688184; 
 Thu, 23 Oct 2025 05:14:48 -0700 (PDT)
Received: from ?IPV6:2a00:2381:43b9:32:f5b4:9544:a6ae:e055?
 ([2a00:2381:43b9:32:f5b4:9544:a6ae:e055])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897e74cdsm3748059f8f.9.2025.10.23.05.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 05:14:47 -0700 (PDT)
Message-ID: <74a41f8e-e09f-4a62-a373-6a47c4f61834@canonical.com>
Date: Thu, 23 Oct 2025 13:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH v4] disk: dos: Add all options for EFI System
 Partitions
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
References: <20251008150832.627727-1-pbrobinson@gmail.com>
 <8f4a01c1-dd8b-493a-b0b5-01b7a82f23c6@canonical.com>
Content-Language: en-US
In-Reply-To: <8f4a01c1-dd8b-493a-b0b5-01b7a82f23c6@canonical.com>
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

On 10/23/25 13:00, Heinrich Schuchardt wrote:
> On 10/8/25 16:08, Peter Robinson wrote:
>> The EFI spec states that the ESP can be any of FAT12/16/32 but for
>> compatibility doesn't necssarily require the partition to be the
>> EFI partition table ID of 0xef. A number of arm devices will not
>> find their firmware on a FAT partition with an ID of 0xef so also
>> allow the original FAT12/16/32 partition IDs as they are also
>> permissable for an ESP.

Hello Peter,

It is U-Boot that reads the ESP. The EFI boot loader is the only thing 
that needs to be there.

You provide no clue why you want to place any firmware on the same 
partition as the EFI binary.

Best regards

Heinrich

>>
>> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Hello Peter,
> 
> Please, read the Microsoft documentation:
> 
> "The Extensible Firmware Interface System Partitions on an MBR disk is 
> identified by partition type 0xEF." [1]
> 
> The other partition types like 0x06 have non-ESP use and should never be 
> taken for an ESP.
> 
> Updating partition tables is trivial. Just fix the buggy partition table 
> entry on your ARM devices instead of this cumbersome patch.
> 
> Best regards
> 
> Heinrich
> 
> [1]
> https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup- 
> and-storage/guid-partitioning-table-disk-faq
> 
> 
>> ---
>>
>>
>> v2:
>> - Add 0x0c option
>> - Make hex constants consistent
>> - Move from if to switch statement
>> v3:
>> - Fix switch brain fart
>> v4:
>> - Drop boot_ind out of switch
>>
>> This is just a resend, it fell off my radar, and there was a CI failure.
>>
>>   disk/part_dos.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/disk/part_dos.c b/disk/part_dos.c
>> index 18dd35c9b98..92d6fa6e028 100644
>> --- a/disk/part_dos.c
>> +++ b/disk/part_dos.c
>> @@ -39,10 +39,21 @@ static int get_bootable(dos_partition_t *p)
>>   {
>>       int ret = 0;
>> -    if (p->sys_ind == 0xef)
>> +    switch (p->sys_ind) {
>> +    case 0x01:
>> +    case 0x06:
>> +    case 0x0b:
>> +    case 0x0c:
>> +    case 0xef:
>>           ret |= PART_EFI_SYSTEM_PARTITION;
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>>       if (p->boot_ind == 0x80)
>>           ret |= PART_BOOTABLE;
>> +
>>       return ret;
>>   }
> 

