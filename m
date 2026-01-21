Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F1CC44501
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 09:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 098828341A;
	Wed, 21 Jan 2026 10:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SR+riOLG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FE1839D5; Wed, 21 Jan 2026 10:25:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D99E82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 10:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768987543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJ1IJIe8SK6tmfyCOtWd4NMQA8CoTCvieaLiRmIJm54=;
 b=SR+riOLGXJiRHqoPABpZ0+AfP2Li7IkC4kdAudxPpll+N3qXAKpVtbHfblyHPcZJTAfhvJ
 OMsKgwvk4I06mEF0Jx0DNdFRCQkQVT3f1G2VH4Hp3mXXfD9jcBpzpY8KNrs00G7rSh1N9s
 RxHsPs73PNG5kx4cmyGvxJ0T3/lLPHA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-HH3-ukS-OdyW0sp6fBci_A-1; Wed, 21 Jan 2026 04:25:40 -0500
X-MC-Unique: HH3-ukS-OdyW0sp6fBci_A-1
X-Mimecast-MFC-AGG-ID: HH3-ukS-OdyW0sp6fBci_A_1768987540
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso45223345e9.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 01:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768987539; x=1769592339;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mJ1IJIe8SK6tmfyCOtWd4NMQA8CoTCvieaLiRmIJm54=;
 b=JB7qCZFtV2fu6pJcBeDNAzTSI7VoypC5enE20giXw2OrOt5UJhLUP6cwSs8U2TFfGx
 29KiFu16mDca2b45wXqh/LBBSJgeoDbBFn3YagOAGYlcjas86TmWp4gi1SLFGeWI99dA
 SSX8EpLE5X1vpzYaEtrvQlAlfVIJ/TWesz1NcyTblkAptwemxVEeoR7pF7kittvmvtr1
 02lCyZ/bpbAz1b+0Ju6MxxBdzQZbOFpnUMzkmAg/bKyU/EvRD+/hsuxjF0xsykwwSohF
 alH3yxM+F6aw7aywCFHISMXlqF5jrdfz++SIQgMPsfvJ7+BG2sKEyS1mVZPgQCywJOX9
 9m3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuFeg5JlEdPo87jCHeQsODFwrUUYsghLvYwmVtVhd4IpVtrrcgWw9KXLgYex2LTywV4xczLaU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx33h2ErDgCuUH4kmkSp+mcWTWOVJn/3t9iwN/hk2xhFObm3eH7
 /Oa8S1B2wvFGMlAjVkOtyoUjptR/Z7jhiEFWr+SAbdTbVGXrboAb9MmhNr+lzYkZAd+ykyn62Br
 Tn4vdz7Av+KBt9TuKRoqSHvjGb8IHfbqFG/suGKqVjaAbHD0I3C9wU9g=
X-Gm-Gg: AZuq6aJRJMSI2ioL6+N4r0SloxHuTdPkEzVDXL7lKgwIBvleJjxNl7HB8CFItbdR92l
 UHeiNOMU2fdl0t4Fa++yPeXX6JwoSbqg+TsoBAg53kcSBZ5VY/7EfqY5QkS7yyzht8Cdp1+uFWf
 HntJzDyCf95o49TNrVfEnMCImJ8LNCAVVAONKYVPzVvDpHLvQCSlJG8MJE2gRJ4q12seNaUM3vY
 Rf4CG5/FulTqjemfXBkV94FJkAcOCNPTDpdtaqTgLm5XFdY2PnxpFdYQ4r/jkGKFnEX9qh+ed4W
 /H5cwj8rbIB/ty81eqHhi+ayLFnIXNh7DIx0MjkoAciWxwz+3OzHI86XrS/ysQYtenGT338Qs+T
 BYhPBgZCm/fYuy0P7Jc8l3z0KLaVLhxAQ5oeeZiWQU71dZ6T3Q7ZpLx57FFiT5Beav04S
X-Received: by 2002:a05:600c:6085:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-4803e79b854mr69094515e9.1.1768987539516; 
 Wed, 21 Jan 2026 01:25:39 -0800 (PST)
X-Received: by 2002:a05:600c:6085:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-4803e79b854mr69094135e9.1.1768987539059; 
 Wed, 21 Jan 2026 01:25:39 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4358f12ee69sm11812109f8f.11.2026.01.21.01.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 01:25:38 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: eballetb@redhat.com, alexl@redhat.com, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Javier
 Tia <javier.tia@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>, Rasmus
 Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>, Varadarajan
 Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] efi_loader: disk: Extend
 EFI_PARTITION_INFO_PROTOCOL to support MBR
In-Reply-To: <a45fa439-535d-4bdf-8ac7-94b3150d117e@gmx.de>
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-5-javierm@redhat.com>
 <a45fa439-535d-4bdf-8ac7-94b3150d117e@gmx.de>
Date: Wed, 21 Jan 2026 10:25:36 +0100
Message-ID: <87343zfhbj.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: keajWGSZbpswvcFiGgbtIkZcU83T4GezfsY-Z3_90EU_1768987540
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

Hello Heinrich,

Thanks for your feedback.

> On 1/20/26 14:36, Javier Martinez Canillas wrote:
>> The EFI_PARTITION_INFO_PROTOCOL provides detailed information about
>> partitions. The UEFI specification mentions that both GPT and MBR
>> partition schemes are supported, but the U-Boot implementation only
>> supports the former.
>> 
>> This can cause compatibility issues for platforms whose boot ROM only
>> supports MBR. This change adds support for MBR partition tables to
>> the protocol, making U-Boot compatible with systems that require a
>> legacy MBR table.
>> 
>> To implement this, the existing part_get_info_extended() function,
>> which already traverses DOS partitions, is refactored to optionally
>> retrieve the raw MBR partition record. This provides the necessary
>> data for the EFI subsystem.
>> 
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>>   disk/part_dos.c           | 63 ++++++++++++++++++++++++---------------
>>   include/part.h            | 14 +++++++++
>>   lib/efi_loader/efi_disk.c |  9 ++++--
>>   3 files changed, 59 insertions(+), 27 deletions(-)
>> 
>> diff --git a/disk/part_dos.c b/disk/part_dos.c
>> index 60c3d6773696..5b508483bae7 100644
>> --- a/disk/part_dos.c
>> +++ b/disk/part_dos.c
>> @@ -201,7 +201,9 @@ static void print_partition_extended(struct blk_desc *desc,
>
> Please add a Sphinx style function description describing the usage of 
> the parameters.
>

Sure, I didn't add for the new parameter since the function didn't have
a description, but I'll add a preparatory patch in v2 to add that.

[...]
   
>> +/**
>> + * part_get_mbr() - Get the MBR partition record of a partition
>> + *
>> + * This function reads the MBR partition record for a given block
>> + * device and partition number.
>> + *
>> + * @desc:	block device descriptor
>> + * @part:	partition number for which to return the partition record
>> + * @mbr:	MBR partition record
>> + *
>> + * Return:	0 on success, otherwise error
>> + */
>> +int part_get_mbr(struct blk_desc *desc, int part, dos_partition_t *mbr);
>> +
>>   #endif
>>   
>
> Please, put the partition library changes into one patch and the EFI 
> changes into another.
>

Ok, I'll split these in v2.

> Best regards
>
> Heinrich
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

