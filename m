Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E38AC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A40889A1;
	Wed, 14 Aug 2024 14:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="a7Bbjl8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9CAF889AA; Wed, 14 Aug 2024 14:59:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C14FF87C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 675A93F670
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723640361;
 bh=CyDffGzZeMMTfzrHcQNAhsaGtJXBOWi5WflfGdvssb8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=a7Bbjl8wrbN9bqrBQnTcKo0WmYbPlwYE3bNYuawIbIesHcjO0mr2aqRYdUC6nvmbO
 idvAmf+YzQYQHPMLVtyn2Db08xF3F5j5WPQOvog60YrWBw6qplpE1K6oOigbvo68O9
 oByTdyC4d9IeFRqKwBgho2HJk3fTuyZe6KkR1scTh2b83kFwqoBk9Dk7i94qkW4BAm
 0U9IDLK3cDoTs+vYCJPimllvFj90fRDEWSQzjongFOqfmhCFR+ib+WcZIqhxwdxyUG
 rLLxGTz6KKk7D5TmQ6fyoq+RoBN3d8PjKIv9DtM23Z2CHNyfyI973/X1xLqTlsk6g6
 Z3qVNnF2qOxOg==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3717c75b265so168572f8f.1
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723640361; x=1724245161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CyDffGzZeMMTfzrHcQNAhsaGtJXBOWi5WflfGdvssb8=;
 b=GEYxN5FQtDvqZmXvOADgPkksTA/qqUEIbe4ckKEFLEdbMQFIwISGShVO6vcvUc5t2d
 uudgZytEYsob3ZPcgC3zpnn+aBNkkNfHOh6oG7gilF4EswMkj2yaxjcnsmIKjzoVPaTR
 fn9Y3+98K13mrEwNCabpDGGtikmu9nzpRgM9BkLUokpDnfnA88dqoewQGvfJxR6tvGl/
 Bv1KbPADSMbHU4F2041UP/WBKcXEWxFI1y9s59qf/zwFspDJuB5kjEiaElBLnNKVyrOY
 6MZOCQqegOTxAFS0AuM4PB+2Nfk1PxQ7C+miyVMBdrQA4t3N8WH0/P5qaY266CeyOpno
 qG0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWPDpObsJr5oZJ+dyA4GoklJ9UXkydu3BtN/scfVVuAizL9WKK5KD9I18bblVO5+y0EUmYa22Es42is6DeBZ8xywOuWA==
X-Gm-Message-State: AOJu0YwsY+79PPElELWZuLvUyoMc9hoCZqlsIGNjYpmSp98M4WHQPHuy
 CogXCnPyq65LmjV+EXn3+B6TbCqn+jJjscj0FhbYe9r2fB40fMvKt6psy6fIdTy3nkq0ansNqIk
 35aEVj7aePO4pc/57wc3m72SweTZYMlm1T1MD5dxGODnpfgou43YDEMMVwcV7gf5Rjgw=
X-Received: by 2002:adf:cd87:0:b0:36b:b2a1:ef8f with SMTP id
 ffacd0b85a97d-37177750384mr1860509f8f.12.1723640360789; 
 Wed, 14 Aug 2024 05:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5jfiYc9pqVjZM6qyyFwcPB//9BoOT4zLle4LFrjZCWlbU9oFChpgMTTSWNAMi5oFSqeGsiQ==
X-Received: by 2002:adf:cd87:0:b0:36b:b2a1:ef8f with SMTP id
 ffacd0b85a97d-37177750384mr1860483f8f.12.1723640360181; 
 Wed, 14 Aug 2024 05:59:20 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4ecc7a52sm12733801f8f.103.2024.08.14.05.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 05:59:19 -0700 (PDT)
Message-ID: <6bf3ab31-7fca-4cd8-bb74-16264a931ed2@canonical.com>
Date: Wed, 14 Aug 2024 14:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools/mkeficapsule: correct printf codes
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
References: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgd7S8RQFJnpVfH-wRirrZ0VQ=kN=mK2TOqmHkr85OBcQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgd7S8RQFJnpVfH-wRirrZ0VQ=kN=mK2TOqmHkr85OBcQ@mail.gmail.com>
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

On 14.08.24 14:40, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 14 Aug 2024 at 01:14, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> uint64_t is defined as unsigned long long on 32bit ARM.
>> Convert uint64_t values to unsigned long long and use %llX for printing.
>>
>>      tools/mkeficapsule.c: In function ‘dump_capsule_auth_header’:
>>      tools/mkeficapsule.c:694:66: warning: format ‘%lX’ expects argument of
>>      type ‘long unsigned int’, but argument 2 has type ‘uint64_t’
>>      {aka ‘long long unsigned int’} [-Wformat=]
>>      694 | printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
>>          |                                                      ~~~~^
>>          |                                                          |
>>          |                                                          long unsigned int
>>          |                                                      %08llX
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   tools/mkeficapsule.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
>> index f28008a0829..d346c217f09 100644
>> --- a/tools/mkeficapsule.c
>> +++ b/tools/mkeficapsule.c
>> @@ -691,8 +691,8 @@ static uint32_t dump_fmp_payload_header(
>>   static void dump_capsule_auth_header(
>>          struct efi_firmware_image_authentication *capsule_auth_hdr)
>>   {
>> -       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
>> -              capsule_auth_hdr->monotonic_count);
>> +       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08llX\n",
>> +              (unsigned long long)capsule_auth_hdr->monotonic_count);
>>          printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08X\n",
>>                 capsule_auth_hdr->auth_info.hdr.dwLength);
>>          printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wREVISION\t: %08X\n",
>> @@ -724,10 +724,10 @@ static void dump_fmp_capsule_image_header(
>>                 image_hdr->update_image_size);
>>          printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X\n",
>>                 image_hdr->update_vendor_code_size);
>> -       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08lX\n",
>> -              image_hdr->update_hardware_instance);
>> -       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n",
>> -              image_hdr->image_capsule_support);
>> +       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08llX\n",
>> +              (unsigned long long)image_hdr->update_hardware_instance);
>> +       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08llX\n",
>> +              (unsigned long long)image_hdr->image_capsule_support);
> 
> These should be in lower-case hex, by the way. Also see inttypes.h

Why would you print some lines in lower case while the rest is upper case?

I have sent a second version using PRIX64 and avoiding the conversion.

Best regards

Heinrich


> 
>>
>>          printf("--------\n");
>>          if (image_hdr->image_capsule_support & CAPSULE_SUPPORT_AUTHENTICATION) {
>> --
>> 2.45.2
>>
> 
> Regards,
> SImon

