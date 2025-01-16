Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C7BC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 15:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043A480214;
	Thu, 16 Jan 2025 16:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KMct4UH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B47438033D; Thu, 16 Jan 2025 16:47:30 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE40801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 16:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E8FC43F677
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737042447;
 bh=tglB0fkv1KpNqRQiVFR5GvWOYddsmDUrcJG//zrOXBo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=KMct4UH01ewLd4jBar9G4/MX0Bxjm4iSoqTSmhMiFh743LzhUcWFBF09ndfDPpKbs
 4wDPM8D882G4sILTQlbsXqQ0nqz43DwA3QG4Qm7O64sSq7/LV6qW4V/8uB1alnfTP2
 vLsFL+UBr7zWma0IuvVx1aGlviQacVVJTOzaaTJY1IY4HPIYuh2R6XTMFz+vQOQFCk
 +IQbKUzyKhk1YASFDTYZJR+aHa1tH1hbbx7Z9G/stXkoaZZhKAgQe6roc5T6jy+MJC
 p+Co76C3m6wIA7QerJz4xndwZnqN+UfL8zba3oJfyZmz0pWokIAedDkvEJuJ0h1ZsN
 KaWNbEhVJIDiQ==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d3f01eeef8so1063893a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 07:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737042447; x=1737647247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tglB0fkv1KpNqRQiVFR5GvWOYddsmDUrcJG//zrOXBo=;
 b=c/bdiClt9pTf4wgHhr47ucp5hhNPl+HpL9ZNv8QJuQQG+1/fdxF1eU3OT4vtjRIeH/
 R0iYaOEpDB5KCH8JZwcglf48txNNGjInpu8NXfyEQov/yVTg3NbvQdw1Cqne/I0NwurV
 vZHk9WIPwrCxsLvn7iOhc09RIwFHbJlE3/5L7xhNz5s/GBK6horm4KTTVprJ3+zWdXj9
 gbv6j9UjqGhzcrEbcS2jGEk96gxOp8JIiljr5LYF8apEkGBxTmbQ4AgD20+05pH4eFTX
 8adwmiYFvVir1dxBtegTKu9g5SzgWLbnloUHJyJDskELDGshi+TZdeBQYtu2C+lqe775
 ARlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYQ3q4yJSqP/U7QyKJ4oPTr+4DTPveLhrC/sGb3W1Ay7qMTI0lyDwF5dKcYcbghkTUv4dt45E=@lists.denx.de
X-Gm-Message-State: AOJu0YxH3zaUU1AqMMNIIhb++K03aBnrZfKsfafwcZDn3mLIyNQVL7Wp
 HVNwc1Dsu1JWpSIDMdlDdLMN2JweSgQutLf1f4WMj98qZ+gFoU3093aX7OW1HSD8q4LepuLfDFP
 3vej5azZbJzKw1LoG5YwYQdb80z/lYGedRN1/AoXvjXJI6YfPddfiZcIXJFBMjKPQioI=
X-Gm-Gg: ASbGncvpEV3vVX2lih1KUA29J2GkYVZYFas4tSYBghzFp9GG1ZkDMuE4EEt5WCLFoeh
 uL5oA0yX/gxVUgnRVoHUJDSous/elW+ETft8W4jjEXzFL3N0NKOeJnwRFoq8Y+1XMlsea1a7IZ/
 alUVt1oT5lCmhWNnBBtJmeBzbk1gFH1JPXWB5ztOiiQy9e0HlyzBCHm1fNea1/7ETaJdN932aoV
 Fod4ILK0AMNQcoKrKIU1IcszLJBVF9sdKOK+hHDlJ8D9LM7r4txn6O21RAPviNv6hjvBBt3Iq+L
 Re1TfrsJTfS3RIDjrcXTrPBs5ixiMN4eixBweynTZ0bz
X-Received: by 2002:a05:6402:2342:b0:5d9:f362:1693 with SMTP id
 4fb4d7f45d1cf-5d9f36217d1mr30679095a12.30.1737042446999; 
 Thu, 16 Jan 2025 07:47:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNE+prrjR3cRSyV12OjV3+asvR7tMktdgxOqEHFtxl8afFWZz3CTOTppAPSaTaFlsdQCAl+g==
X-Received: by 2002:a05:6402:2342:b0:5d9:f362:1693 with SMTP id
 4fb4d7f45d1cf-5d9f36217d1mr30679042a12.30.1737042446619; 
 Thu, 16 Jan 2025 07:47:26 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79?
 ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edccd4sm89179a12.77.2025.01.16.07.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 07:47:25 -0800 (PST)
Message-ID: <dede82a9-f8ad-40e9-a2b7-8c0193974af2@canonical.com>
Date: Thu, 16 Jan 2025 16:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] efi_loader: print image load address in StartImage
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 u-boot@lists.denx.de
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
 <20250102181133.378867-5-heinrich.schuchardt@canonical.com>
 <CAC_iWjLykW-kgo65mCGfnwBEmYGbGa6mq52yxfCZHC1Rep1FQg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjLykW-kgo65mCGfnwBEmYGbGa6mq52yxfCZHC1Rep1FQg@mail.gmail.com>
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

On 07.01.25 14:32, Ilias Apalodimas wrote:
> On Thu, 2 Jan 2025 at 20:11, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> When starting image add the image load address to the debug output.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/efi_loader/efi_boottime.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
>> index 080e7f78ae3..bc0cbd96e74 100644
>> --- a/lib/efi_loader/efi_boottime.c
>> +++ b/lib/efi_loader/efi_boottime.c
>> @@ -3194,7 +3194,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>>          struct efi_loaded_image_obj *image_obj =
>>                  (struct efi_loaded_image_obj *)image_handle;
>>          efi_status_t ret;
>> -       void *info;
>> +       struct efi_loaded_image *info;
>>          efi_handle_t parent_image = current_image;
>>          efi_status_t exit_status;
>>          struct jmp_buf_data exit_jmp;
>> @@ -3212,7 +3212,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>>                  return EFI_EXIT(EFI_SECURITY_VIOLATION);
>>
>>          ret = EFI_CALL(efi_open_protocol(image_handle, &efi_guid_loaded_image,
>> -                                        &info, NULL, NULL,
>> +                                        (void **)&info, NULL, NULL,
> 
> We don't really need the cast here

Without the cast building fails.

Best regards

Heinrich

> 
>>                                           EFI_OPEN_PROTOCOL_GET_PROTOCOL));
>>          if (ret != EFI_SUCCESS)
>>                  return EFI_EXIT(EFI_INVALID_PARAMETER);
>> @@ -3266,7 +3266,8 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>>
>>          current_image = image_handle;
>>          image_obj->header.type = EFI_OBJECT_TYPE_STARTED_IMAGE;
>> -       EFI_PRINT("Jumping into 0x%p\n", image_obj->entry);
>> +       EFI_PRINT("Starting image loaded at 0x%p, entry point 0x%p\n",
>> +                 info->image_base, image_obj->entry);
>>          ret = EFI_CALL(image_obj->entry(image_handle, &systab));
>>
>>          /*
>> --
>> 2.47.1
>>
> 
> With or without the cast removed
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

