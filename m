Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542E3C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD128022B;
	Thu, 16 Jan 2025 14:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="u1qafLcJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0B88033D; Thu, 16 Jan 2025 14:34:22 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C337080214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B2A53F683
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737034458;
 bh=WhHwRfx3fwinWLlRFAjhOjhT41Zezy3hJ14zMtGLbeE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=u1qafLcJEDkwc/qikJgT/cYppUbfN4bzvsu+Dr/epyHbXnxXgkLbYiXPMOlNOhze+
 yrkbkiNyxMmMEO+pUIMZf1dutkJK61zJl/XijpOeg+qYECPxvvVf9qy2o2u7dCtNvx
 DuWUJE5ezcpUtkfmGL6yeTk4DziJqFsOoJK0zRjLMwnzqaPOU6KdeAdptxM3CY7MmW
 H6cR35xvF/OzlKlenTOLUuZCLH/xfOgQKsa+zkcSfBQLJPnUttvDN/GGaQW2+PtQPS
 Gz6MZOHjQ//H6S4Cz1r5yb9MVmInOPGVJrb4UdUDdFgb7YmgtZSOu8Dkw0PUuNhljr
 b071i0PZIdh3A==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab2e529dc35so111154466b.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737034457; x=1737639257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WhHwRfx3fwinWLlRFAjhOjhT41Zezy3hJ14zMtGLbeE=;
 b=D5a6HA+7XmKsoXgUuhAneYuykBC9Vu/tOOvl9fqGPiKgmA7UFJ5SKb7h11K+1elftJ
 khmGTPOD3LI6Kp30P+PnveoaOUZ4ZLCF/aZK3AS32cGy/OoyOuLe0yaCN1u49hpNci+g
 CPRwoaGTIOgodtT1idOnQzhvzuUzI8e9vTM6bYiUyUfLqjJQyaY7elEwX6uWwc7BToNU
 p7nUK//OZKxLHJkkgRRTIgiVJIDhoPP6UIfOcmBsI/MeBcMWCzaxgAmHOwZW51CJmhD6
 1DlsRcTF3lvZe2T4R+063+x5XkxKt4AG3FPU98+hNeHgZRWh68bAYe9WiPldoqp/RJxf
 MN5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXinJ5gIdTlrSERgWDthW5GqxYp8n4NmCkFCNiysa/mOCXmZ232iVgUl61A+lvu6j3GjOpZFg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0EtAD39JpxxXsqHfveazNuGckMdENlG6TBZNerLC0qrqnmciP
 XAZmwtkycaRuoT4s5NTy7mNQQZsI93mX0PqGjDryXzYynk7A/qENJ5ZTnBUHQpEZkjCcH4rGz7a
 VIzvh5j2EwHQYhlNVbeX+LB5/1I4MWsy6Ie5A0e1KVGZsnAQFqvQF6Z3uaQ26XTXGqKU=
X-Gm-Gg: ASbGncvITAU2o4CPAf4F246sTFkKqr3xkE6CByl8+v1HwwrUeVTEzw2AxgsmR12DSvn
 lD9MvaBHd96CKDEIDmA6CRhNHPFtipmRco/fwZylPWQGGWJUQeYvT7/U1Ciz187+rO0su8vSQt7
 S91h9KHU5+NvyLnKZbDG4UVtIHp8vYQPN8Pto/GK8MgK6KzSkygoUN4zDGcdoisdy7ewxNe3VQS
 4i+IMbGTtJLL7A26sCCvM6GYKtfyq/pPYscW3YJIWcj1VOH9qOuj4TNY5zN2G5MTtOpprOhdpdo
 qGboxE+YQfnb8w0oUZYDoGgwnucwATShjeh19RdfHJTr
X-Received: by 2002:a17:907:7f08:b0:aaf:c27e:12e9 with SMTP id
 a640c23a62f3a-ab2ab709a68mr2676860966b.14.1737034456825; 
 Thu, 16 Jan 2025 05:34:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjbqkV+sfiEujiXa3nnFVOxwISXYGUAlTZr9idHd/HWk+EiAUIYUZ9su/Dr4edAQ9s7R4m3w==
X-Received: by 2002:a17:907:7f08:b0:aaf:c27e:12e9 with SMTP id
 a640c23a62f3a-ab2ab709a68mr2676859066b.14.1737034456413; 
 Thu, 16 Jan 2025 05:34:16 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79?
 ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b1207sm912606566b.153.2025.01.16.05.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 05:34:15 -0800 (PST)
Message-ID: <8251256c-d1d6-478c-aa2c-6dcb8f5e4c12@canonical.com>
Date: Thu, 16 Jan 2025 14:34:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] acpi: don't fill FADT, MADT if CONFIG_QFW_ACPI=y
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
References: <20241220003759.89252-1-heinrich.schuchardt@canonical.com>
 <CALNFmy3ca5Z_Dr=1dzK8F4_+YWK4LtzK8Pq9VdNKMKS2kjWStg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CALNFmy3ca5Z_Dr=1dzK8F4_+YWK4LtzK8Pq9VdNKMKS2kjWStg@mail.gmail.com>
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

On 20.12.24 07:30, Patrick Rudolph wrote:
> On Fri, Dec 20, 2024 at 1:38 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> When using the ACPI tables supplied by QEMU, we don't need to build the
>> FADT and MADT tables in U-Boot.
>>
>> This patch avoids a build failure
>>
>>      make qemu-riscv64_smode_defconfig acpi.config
>>
>>      riscv64-linux-gnu-ld.bfd: lib/acpi/acpi_table.o:
>>      in function `acpi_write_fadt':
>>      lib/acpi/acpi_table.c:265:(.text.acpi_write_fadt+0x15c):
>>      undefined reference to `acpi_fill_fadt'
>>
>>      riscv64-linux-gnu-ld.bfd: lib/acpi/acpi_table.o:
>>      in function `acpi_write_madt':
>>      lib/acpi/acpi_table.c:294:(.text.acpi_write_madt+0x52):
>>      undefined reference to `acpi_fill_madt'
>>
>> Fixes: f5f7962091e4 ("acpi: x86: Write FADT in common code")
>> Fixes: 4a3fc0f525da ("acpi: x86: Move MADT to common code")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/acpi/acpi_table.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
>> index 150f75027a5..c0ed24984af 100644
>> --- a/lib/acpi/acpi_table.c
>> +++ b/lib/acpi/acpi_table.c
>> @@ -273,7 +273,9 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>>          return acpi_add_fadt(ctx, fadt);
>>   }
>>
>> +#ifndef CONFIG_QFW_ACPI
>>   ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
>> +#endif
>>
>>   int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>>   {
>> @@ -308,7 +310,9 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>>          return 0;
>>   }
>>
>> +#ifndef CONFIG_QFW_ACPI
>>   ACPI_WRITER(5madt, "MADT", acpi_write_madt, 0);
>> +#endif
>>
>>   void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
>>                        int port_type, int port_subtype,
>> --
>> 2.47.1
>>
> 
> Anything wrong with the patch series send Nov 14 2024 that addressed
> this issue as well?
> 
> Reviewed-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Could you, please, provide a link?

Best regards

Heinrich

