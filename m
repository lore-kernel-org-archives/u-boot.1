Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CB4C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 12:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE518785E;
	Fri, 24 May 2024 14:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vqpJWvv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EF0D87A09; Fri, 24 May 2024 14:17:51 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4140E87527
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 14:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57851af0239so920082a12.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716553068; x=1717157868; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DcB8iBkGf/1rXUbRrnZO5wFiXNwVddr/7auyoVyZa1g=;
 b=vqpJWvv5qDl9fjc3WA7IiLnvBy9emEp+fej7Q0nA0H0xfPN0cwcHnJqLfaq1cuzOCB
 ZTK/kzISojs6VrtUcS3A+ud+FrzDzdJEbh12r19wCRADtKwl8Pt4LIYjB7kgiU+4aQqJ
 OIAFNAd4LqvkLdO3THOtAVzYn3CmyJvaXBP1e5xWgAAi7ApcgPCt6+ao1D39VABOMXsj
 DPUcYkio2wTXjofgWWXW2ETDrS8YDAVHyXVPfyi1wHDY6jAgwVTkJN49Gr95LKpOiNxD
 3K+cqTiLua2H8ZxsO6GHuMOtmU/L0O+47VfK1/LmaKq7LRbXdUH6eH1ybEgCmloAWmrr
 WDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716553068; x=1717157868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DcB8iBkGf/1rXUbRrnZO5wFiXNwVddr/7auyoVyZa1g=;
 b=tyQkI/lvPpPpQ20eq5bjGUtjdmw+kuTm50PtqcbcP3K+0bvkGSwUEZiozhp/TIEO0l
 3EON9SMSmtksJqPJ1llQ9cfzLZqFUOV9OgG7g7rp8dSLmdn6EQeQu+nqqiRM4VnlQHeD
 0etPaFSeN2Tdb2+KiSdNvkWE6DPiTLJtTy9lgDVo5gxUtDc5VXuA6T4Qso/h8H1FZz+x
 Yi96JAAUyzeiX59ymDhwJOt3wgF35tVGJv32ssSQ7F4+NwpxMkBorP4uib0pLaxk9EAA
 OyTH1yDbSYsN1bIwwYdlajQh3YJ54fcfAjms0SVlERVpLyJm1P103Obf83H0z6VZyON/
 bERg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJTBlLmxF/lb77GziS3T41TcSu4X8Ybcaz9kmvv0LsrPBLOyYgG1vb1lmhZowQ+cFItOKinrxO9D8YUj+H2mbD0xcRhA==
X-Gm-Message-State: AOJu0YzpPFYeNWxAamVSLN/iei0E5kCUX/+mRlrn6raoHNwQ3Rgpuax0
 tK2vtF5WZf/P4NFj4Q4s3ZLemqQFkIUmmKWSeRavqe8pcDS1ZNOYIirOAxjTLUo=
X-Google-Smtp-Source: AGHT+IEewNqxip/m2Iipy24WkZbcbPyaJh8dmznnl67f6HgqIO7Nh5Sx0wM6/Mig6K29y0/cXU6CYg==
X-Received: by 2002:a50:ccd3:0:b0:573:4f61:ca9c with SMTP id
 4fb4d7f45d1cf-57862e12a13mr217903a12.4.1716553068619; 
 Fri, 24 May 2024 05:17:48 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524bb86bsm1554000a12.97.2024.05.24.05.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 05:17:48 -0700 (PDT)
Message-ID: <c5c79a74-19ad-459e-8c42-c7a9fc31614a@linaro.org>
Date: Fri, 24 May 2024 14:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/4] efi: add a helper to generate dynamic UUIDs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
 <20240426-b4-dynamic-uuid-v1-2-e8154e00ec44@linaro.org>
 <CAC_iWjKZe+0EMC76TxdtBZju99QAApodqEZHdaKJt1E-mMw6ow@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAC_iWjKZe+0EMC76TxdtBZju99QAApodqEZHdaKJt1E-mMw6ow@mail.gmail.com>
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



On 24/05/2024 08:37, Ilias Apalodimas wrote:
> [...]
> 
> 
>>   config EFI_CAPSULE_FIRMWARE_MANAGEMENT
>> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
>> index de0d49ebebda..9ef67d1b4405 100644
>> --- a/lib/efi_loader/efi_capsule.c
>> +++ b/lib/efi_loader/efi_capsule.c
>> @@ -19,8 +19,9 @@
>>   #include <mapmem.h>
>>   #include <sort.h>
>>   #include <sysreset.h>
>>   #include <asm/global_data.h>
>> +#include <uuid.h>
>>
>>   #include <crypto/pkcs7.h>
>>   #include <crypto/pkcs7_parser.h>
>>   #include <linux/err.h>
>> @@ -403,8 +404,40 @@ out:
>>          return status;
>>   }
>>   #endif /* CONFIG_EFI_CAPSULE_AUTHENTICATE */
>>
>> +#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
>> +int efi_capsule_update_info_gen_ids(efi_guid_t *namespace, const char *soc, const char *model, const char *compatible)
>> +{
>> +       int i;
> 
> Perhaps irrelevant to this patch, but do we need to define the name
> space in platform code?
> Can't we just put it on a Kconfig and do the dynamic UUIID generation
> in efi_capsule.c?

Having the namespace be a kconfig option probably makes sense, then it 
could be the thing vendors have to populate for their production boards 
(and they could just have one for all of their products across many 
architectures). So by setting one option they'd have totally unique 
GUIDs for everything.

> 
> Thanks
> /Ilias
>> +
>> +       if (!soc || !model || !compatible) {
>> +               log_err("%s: soc, model, or compatible not defined\n", __func__);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!update_info.num_images) {
>> +               log_err("%s: no fw_images, make sure update_info.num_images is set\n", __func__);
>> +               return -ENODATA;
>> +       }
>> +
>> +       for (i = 0; i < update_info.num_images; i++) {
>> +               gen_uuid_v5((struct uuid*)namespace,
>> +                           (struct uuid *)&update_info.images[i].image_type_id,
>> +                           soc, strlen(soc),
>> +                           model, strlen(model),
>> +                           compatible, strlen(compatible),
>> +                           update_info.images[i].fw_name, u16_strlen(update_info.images[i].fw_name),
>> +                           NULL);
>> +
>> +               log_debug("Image %ls generated UUID %pUs\n", update_info.images[i].fw_name,
>> +                         &update_info.images[i].image_type_id);
>> +       }
>> +
>> +       return 0;
>> +}
>> +#endif
>> +
>>   static __maybe_unused bool fwu_empty_capsule(struct efi_capsule_header *capsule)
>>   {
>>          return !guidcmp(&capsule->capsule_guid,
>>                          &fwu_guid_os_request_fw_revert) ||
>>
>> --
>> 2.44.0
>>

-- 
// Caleb (they/them)
