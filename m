Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E590BC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EF9B8841D;
	Tue, 28 May 2024 18:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WOlrmIXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901CA883B9; Tue, 28 May 2024 18:08:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BEA48850C
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 18:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 011D43FE64
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1716912482;
 bh=eqF4oE/mezA6LKIfrGPRuk7NrWoaBqgPQpOeCx9bRZk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=WOlrmIXzPT7oWWnhZz2SKSwKpZrjUm0B6Ut/tj1/9bHs6LAk1rLUOrlwej/4Tfn2H
 x4sooaO3go2AM88QY8UC+plJSgDwlG7qrowbZnQh26zFtyGrXF6dLNEUWXFVJudwLo
 ICMYgSd7+nZkGKmxprWLQyLLmQUYZnfda+SgKj62/AE1wc6srrjwO4ODYCyWjWo4KZ
 /l+o1q3CakhZalWln9s61NLoeP0/tRViyfNTwTS/h45A6BRCkFbm8tfhZY1U1sWkBV
 OwOiAUfDRnByt5mm/m1wEF1mIBfLV5KoVX4mDl0QM7CTF4A4jKnIn7Y3fiMXpe1Hif
 EjwSB/e8f7ZOg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35559d30617so811930f8f.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912481; x=1717517281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqF4oE/mezA6LKIfrGPRuk7NrWoaBqgPQpOeCx9bRZk=;
 b=FCYg73DZwMFYUIdSIZqASuU08xRnkfyumlFNUMuVDsg+NP73M/GZe/V+z3tvqO0bXm
 KXkzyrexmsvncub3z0rjUHweeg1jTLjgaMA47DictkQdC5R6tUlnkHY/Q1inQx8z1CDX
 Z74CG1ptr0j6OhydJuA5a4H7UCfJwmV8UQHkrf+2lZwCCc2i3/5b3XAT89zlEcKW7L3o
 paanV334SBpeRol8xkqPzHKCHxutR1Ll7CSAbXwreBAiIQTEKrsfK9tdUv3pufHd5UO3
 67qy0CvlfQCPIY3/G/kklWW8NB+Gm8xe0zdNdUW2rnnFdyXVvpaknYQ+MmoPpUuPo1m5
 1YxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEZesZO76RQAt1mUIpQf8OlzsTMdwv3/Vz628MP0s05V237f6g2+KcfMvN0uLZ2Fl1WMkI/y3CzrZnH4gPuIOLqRHIbw==
X-Gm-Message-State: AOJu0Yx9BQPg9HkY//rnYvPq8yxQBdsvJk3psBKhLFzgK3e0uoMgDqt7
 jo9FhLYvbXDZljVMXFT+C15h3onizlMtPA1t2AMIAUczYQ6GZOWC8WYufzmSitD/7kSYcsRIkUv
 DfabVLxA8F+YYl/4ao1sT3upkNtUGguGctQGAINqfvybqGvkgabXsH1Ed9fN739TnmzU=
X-Received: by 2002:adf:e64c:0:b0:354:de8e:b66b with SMTP id
 ffacd0b85a97d-3552fe02b74mr11089866f8f.52.1716912481414; 
 Tue, 28 May 2024 09:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzfajmoo9CBCw8lbSHWterCW7ii/CDfG0kKWHt+A50tnhB4NsVLEQc+/cdybXN/u3OW7N51A==
X-Received: by 2002:adf:e64c:0:b0:354:de8e:b66b with SMTP id
 ffacd0b85a97d-3552fe02b74mr11089850f8f.52.1716912480977; 
 Tue, 28 May 2024 09:08:00 -0700 (PDT)
Received: from ?IPV6:2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b?
 ([2a00:20:d00b:f75d:fdbe:9c2a:66b:5f2b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c9570sm12027219f8f.68.2024.05.28.09.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 09:08:00 -0700 (PDT)
Message-ID: <1639e3fa-4515-49c1-9364-f06acad03fd2@canonical.com>
Date: Tue, 28 May 2024 18:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] cmd: eficonfig: add support for setting fdt
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Bin Meng
 <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-3-heinrich.schuchardt@canonical.com>
 <CAC_iWjKGNRiJcJtoYM81XO2kYxpFyekZN6VE3K64-Ba3pz7xQw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjKGNRiJcJtoYM81XO2kYxpFyekZN6VE3K64-Ba3pz7xQw@mail.gmail.com>
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

On 28.05.24 17:16, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> [...]
> 
>>
>> -       const struct efi_initrd_dp id_dp = {
>> +       const struct efi_initrd_dp initrd_prefix = {
>>                  .vendor = {
>>                          {
>>                          DEVICE_PATH_TYPE_MEDIA_DEVICE,
>>                          DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
>> -                       sizeof(id_dp.vendor),
>> +                       sizeof(initrd_prefix.vendor),
>>                          },
>>                          EFI_INITRD_MEDIA_GUID,
>>                  },
>>                  .end = {
>>                          DEVICE_PATH_TYPE_END,
>>                          DEVICE_PATH_SUB_TYPE_END,
>> -                       sizeof(id_dp.end),
>> +                       sizeof(initrd_prefix.end),
>> +               }
>> +       };
>> +
>> +       const struct efi_initrd_dp fdt_prefix = {
> 
> We need to rename efi_initrd_dp to something more generic in the future
> 
>> +               .vendor = {
>> +                       {
>> +                       DEVICE_PATH_TYPE_MEDIA_DEVICE,
>> +                       DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
>> +                       sizeof(fdt_prefix.vendor),
>> +                       },
>> +                       EFI_FDT_GUID,
>> +               },
>> +               .end = {
>> +                       DEVICE_PATH_TYPE_END,
>> +                       DEVICE_PATH_SUB_TYPE_END,
>> +                       sizeof(initrd_prefix.end),
>>                  }
>>          };
>>
> 
> [...]
> 
>> +/**
>> + * efi_load_option_dp_join() - join device-paths for load option
>> + *
>> + * @dp:                in: binary device-path, out: joined device-path
>> + * @dp_size:   size of joined device-path
>> + * @initrd_dp: initrd device-path or NULL
>> + * @fdt_dp:    device-tree device-path or NULL
>> + * Return:     status_code
>> + */
>> +efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
>> +                                    size_t *dp_size,
>> +                                    struct efi_device_path *initrd_dp,
>> +                                    struct efi_device_path *fdt_dp)
>> +{
>> +       if (!dp)
> 
> Should we add && !*dp here?

efi_dp_concat() handles the case of one or both device-paths being NULL.

> 
>> +               return EFI_INVALID_PARAMETER;
>> +
>> +       *dp_size = efi_dp_size(*dp);
>> +
>> +       if (initrd_dp) {
>> +               struct efi_device_path *tmp_dp = *dp;
>> +
>> +               *dp = efi_dp_concat(tmp_dp, initrd_dp, *dp_size);
>> +               efi_free_pool(tmp_dp);
>> +               if (!*dp)
>> +                       return EFI_OUT_OF_RESOURCES;
>> +               *dp_size += efi_dp_size(initrd_dp) + sizeof(END);
>> +       }
>> +
>> +       if (fdt_dp) {
>> +               struct efi_device_path *tmp_dp = *dp;
>> +
>> +               *dp = efi_dp_concat(tmp_dp, fdt_dp, *dp_size);
>> +               efi_free_pool(tmp_dp);
>> +               if (!dp)
>> +                       return EFI_OUT_OF_RESOURCES;
>> +               *dp_size += efi_dp_size(fdt_dp) + sizeof(END);
>> +       }
>> +
>> +       *dp_size += sizeof(END);
> 
> Why do we have to account for the end node twice if either fdt_dp or
> initrd_dp are found?

This is the length of the END node of the binary.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>> +
>> +       return EFI_SUCCESS;
>> +}
>> +
>>   const struct guid_to_hash_map {
>>          efi_guid_t guid;
>>          const char algo[32];
>> --
>> 2.43.0
>>

