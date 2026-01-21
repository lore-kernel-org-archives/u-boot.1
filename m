Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44BEC44502
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 09:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE878341A;
	Wed, 21 Jan 2026 10:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HArhdxml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4CE83A3B; Wed, 21 Jan 2026 10:29:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE5F82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 10:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768987740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9xE1qODWypvNyUXUPoxGYB+A3O9VoMV42lnBZ67XyE=;
 b=HArhdxmls1wU5OpFyzPBh6joXBWxZkCYtCiK96wLTTXV0woAwXwgMKvtToNBer1ukftiXa
 pSQWpWb7V2VRPAExMcWW+GZqMwd4KNy81cKPhD/3fiYGbY4KVBhgSJp+PdTrFMgUSiOV3H
 w1cOAN8GfQwYQoaP2M3iqEfNkCsQI9U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-gL2AfKCBPfiXUi5l5jLA1w-1; Wed, 21 Jan 2026 04:28:59 -0500
X-MC-Unique: gL2AfKCBPfiXUi5l5jLA1w-1
X-Mimecast-MFC-AGG-ID: gL2AfKCBPfiXUi5l5jLA1w_1768987738
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so46176435e9.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 01:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768987738; x=1769592538;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X9xE1qODWypvNyUXUPoxGYB+A3O9VoMV42lnBZ67XyE=;
 b=V3c5r4O/0B+jWA9ncItwoY4yATRas23f2ewM5IIAl0qb7+caeIlmaOwmDAlrL6lgJV
 QX67o8wkHsJuIuN01yFCvYgsQ9nWmMHXnBrf59btQllQGHd1YqhtmS9TPSczvNlOPXAV
 WXzoOrE/iCLN7L5Fk1gJRXj0s3a31fNrXbInk2pfpWb/tUWP9fDNUv6+z8VF+HG2H49s
 IzA/7UOugUpKCulebs4T+uV8g5WGo+c7P6UvExrpbBylK/0sq8iGHpN4LAT3odXQ2eGk
 b/XD6gF04GnJogPV5NiUOMdFg5f0fyffVE6PsWRWQi7suHyWPyrHs42OsKATejVmNOg+
 21XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUanV5nsUh/27kdiT8Ut2KguB1BUtXj/DaNNECuKCPTY8bwKnzkucgR+EwtQwdzCA6bcka3MxE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxa6cYPjc/Dih/bTG+DI2B4umzPcdF2243n3oN1T+ROTKrU7xUC
 K1fOutBxOZA45vJ3HZvLTJzuziDpxWhJJKX9XXC9eK49850A1n8xcptTP6ta3GbU3ORe1g6n+Gn
 JLyiirRsJMpuLr48bQZmHTA4PkKroKBQfwCeRAFkHYqCmhJ7kyrhspak=
X-Gm-Gg: AZuq6aKuSQHEVdI9k35nhciD9T97hZ1VuENbllnIhWtqTU7ECiYuXQu37P6EZxcU3q0
 nfHnmNkI95kRK/1PI6M8u3cPN1bWIhErOKeaRsKxoHK94jOgZqmA+q07ClHrScPFoP/T25TutCT
 r7J9wr9uxcbq3hmLv6tEPw/YxGcESG7LN0HcY8wFnkHjcWGAF2z/Km6huqY6j4glmKUT6R2x1xm
 m69zYwCOIKdYXbgMlzHOfhFAaHzdUzGx6+FijQ1A+Kz65IZS0+/3n4y51kG2GgWGWMIjM2Jke46
 Ymsc3lxK86zk88H1jFoMQVT1b/AMrIV2D7FVKuCIQ03aPv+HqU8q2YCUGwQBXg2Lt0r3Xm1am7k
 SdWgbb+htbkWCvyizDnyQ4M7sBKwoyNHgoZZdqsw7acHz4SLU2RjKISTFc+2NTtpOH9Mw
X-Received: by 2002:a05:600c:474a:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-4803e7a2c6dmr73971975e9.10.1768987738329; 
 Wed, 21 Jan 2026 01:28:58 -0800 (PST)
X-Received: by 2002:a05:600c:474a:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-4803e7a2c6dmr73971565e9.10.1768987737888; 
 Wed, 21 Jan 2026 01:28:57 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8d90b3sm304521395e9.15.2026.01.21.01.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 01:28:57 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: eballetb@redhat.com, alexl@redhat.com, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] efi_selftest: Enhance MBR test for
 PARTITION_INFO_PROTOCOL
In-Reply-To: <b0c0049b-e15f-4730-955c-55429720adfc@gmx.de>
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-6-javierm@redhat.com>
 <b0c0049b-e15f-4730-955c-55429720adfc@gmx.de>
Date: Wed, 21 Jan 2026 10:28:56 +0100
Message-ID: <87wm1be2lj.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z6-2Lbb3y69ahQxR-N5ESObqRbSLWGr4mElES5adhek_1768987738
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Heinrich Schuchardt <xypron.glpk@gmx.de> writes:

> On 1/20/26 14:36, Javier Martinez Canillas wrote:
>> The EFI_PARTITION_INFO_PROTOCOL test was added before the protocol fully
>> supported MBR partitions. As a result, it lacked specific checks for the
>> content of the raw MBR partition record.
>> 
>> Now that MBR support has been implemented, enhance the selftest to provide
>> coverage for the MBR entries too.
>> 
>> This verifies that the protocol correctly reads and exposes MBR partition
>> records and prevents this functionality to regress due future changes.
>> 
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>>   lib/efi_selftest/efi_selftest_block_device.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>> 
>> diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
>> index f145e58a267a..50d1fb29e1ef 100644
>> --- a/lib/efi_selftest/efi_selftest_block_device.c
>> +++ b/lib/efi_selftest/efi_selftest_block_device.c
>> @@ -404,6 +404,18 @@ static int execute(void)
>>   			     part_info->system);
>>   		return EFI_ST_FAILURE;
>>   	}
>> +	/* The first partition starts at LBA 1 on the test image */
>> +	if (part_info->info.mbr.start_sect != 1) {
>> +		efi_st_error("MBR start sector %d, expected 1\n",
>> +			     part_info->info.mbr.start_sect);
>> +		return EFI_ST_FAILURE;
>> +	}
>> +	/* The partition type is FAT12 (0x01) in the test image */
>> +	if (part_info->info.mbr.sys_ind != 0x01) {
>> +		efi_st_error("MBR system indicator %d, expected 1\n",
>> +			     part_info->info.mbr.sys_ind);
>> +		return EFI_ST_FAILURE;
>> +	}
>
> How about defining a static variable with all fields and using memcmp() 
> to check them all?
>

Makes sense. I'll do that in v2 as well. Thanks!

> Best regards
>
> Heinrich
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

