Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346D3C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7729B871C9;
	Tue, 23 Jul 2024 16:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WzSgR1bV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444DB8708B; Tue, 23 Jul 2024 16:38:37 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6027287876
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 866A93F370
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721745512;
 bh=1A3iMtQ3VGtUPbuQV5pKIyv1rbIZfwtb2X8v+O030aY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=WzSgR1bVGIKi85WHQsqqPlzCcCakgIRoNxu8lvh0UC+8FCsAZTd1N5iUCcxrFui58
 zrwa6uU5dhkZPV0AJLrafAyqSXe+R/u0PEWxZ2FpuGBuER0MlAwezelEzXKbvrBCYB
 OhlTr9ZN8Hyz2uqNp9EdjUP3Pai3Lm9Bw4ZSDUP7jIe0qBRte9wLc3bi9jznl17Nqu
 Mt+tNptspvViCOK/aDw8KtE65RQUw++RkbIPk4uLI6tq6cci8GhoDNPeofPFPdLbJM
 VLGdNSSNMuwAhlVhTfjdI7b+WT18vXO6aiAqxDoDaEOHoIOktvqbsGv8wn4UgrMp/P
 djTIFwOie3nmQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-368442fef36so4478996f8f.0
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721745512; x=1722350312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1A3iMtQ3VGtUPbuQV5pKIyv1rbIZfwtb2X8v+O030aY=;
 b=tTkz6sODI8DlvZwYEdSXzELtKpqEto5MHCJRb5ifky5gteLpbYmTe+pQ5ZOg0YDM2C
 JosssWkSWthDveg50RGBERKmvzZn/WqhxqWsPjx60tcK8KNlgIqMxU+NCWukXVH87V7r
 v/S72P559aDVLIPsUjeImFOJW8kz7ZJF4lflNbYOic3eDUz3qQ9IIbclyr3jYO6o9Cp/
 E4ud0SLE6XQcCZkAuglfU065V6Zf0i4qOJe92twya/WYBr+86t6pfV8j7XRqtRhRlJ69
 WT7U+3LkBeGzAV0ktVCNSFn8/O7BDk1Pqudc8n0psLrW0ixjmMxH5Xp8eku2pUQX4HHQ
 NueQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd1q7ME4fUHMaeNAFIQ0kIqccmJz7x6Ko9AhQtmUifSk9M56/FR12/JvWZrm3OakRLeblj8VkGymHD4KJloPkNNCm3Ng==
X-Gm-Message-State: AOJu0YwHubXCDchv0y8MBsGMdtdIjrQ17VuzBJXP8CLTkE+4ixVJmhAH
 o2jGK71IRZUmHAVNcCTQRKTopfrNwl+SOZUIbdmHVxGJNLpxwal2aw2RGqJZVDZgHMYIFRJOnm4
 /pzp8XD9NUy3J3vu+MuUPpDkqp1Hoshrs6z7qERzvBBbRAt3VfPt4gXRNiFql6sQmbf4=
X-Received: by 2002:adf:a357:0:b0:368:7f53:6b57 with SMTP id
 ffacd0b85a97d-369bae4ce29mr7778422f8f.18.1721745512172; 
 Tue, 23 Jul 2024 07:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAefzSrBhj0txIontny/19kHTNbnZoMvlsI6t6JfGObfNn41BlUd9egqCbKYFTjdowDJayaw==
X-Received: by 2002:adf:a357:0:b0:368:7f53:6b57 with SMTP id
 ffacd0b85a97d-369bae4ce29mr7778398f8f.18.1721745511795; 
 Tue, 23 Jul 2024 07:38:31 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868ba9asm11759088f8f.41.2024.07.23.07.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 07:38:31 -0700 (PDT)
Message-ID: <4aa1aa09-8b85-4470-a837-df62b89ec49e@canonical.com>
Date: Tue, 23 Jul 2024 16:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] smbios: add extended Extended BIOS ROM Size
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
References: <20240723104634.116082-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKUpjQP_4kCPMAaotuQ4uRKb3bG=zVhdaU-Eb=85hbt2w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjKUpjQP_4kCPMAaotuQ4uRKb3bG=zVhdaU-Eb=85hbt2w@mail.gmail.com>
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

On 23.07.24 16:12, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Tue, 23 Jul 2024 at 13:46, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> U-Boot claims to create SMBIOS 3.7 tables. The type 0 table has
>> a field Extended BIOS ROM Size since version 3.1.
>>
>> BIOS ROM sizes of 16 MiB or above must be written to this field.
>>
>> Add and fill the missing field.
>>
>> This patch does not cover the case of a ROM >= 8 GiB which cannot
>> be configured in U-Boot.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   include/smbios.h | 1 +
>>   lib/smbios.c     | 9 ++++++++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/smbios.h b/include/smbios.h
>> index a4fda9df7bd..00119d7a60c 100644
>> --- a/include/smbios.h
>> +++ b/include/smbios.h
>> @@ -105,6 +105,7 @@ struct __packed smbios_type0 {
>>          u8 bios_minor_release;
>>          u8 ec_major_release;
>>          u8 ec_minor_release;
>> +       u16 extended_bios_rom_size;
>>          char eos[SMBIOS_STRUCT_EOS_BYTES];
>>   };
>>
>> diff --git a/lib/smbios.c b/lib/smbios.c
>> index 4126466e34a..e2a2f873a94 100644
>> --- a/lib/smbios.c
>> +++ b/lib/smbios.c
>> @@ -348,7 +348,14 @@ static int smbios_write_type0(ulong *current, int handle,
>>   #endif
>>          t->bios_release_date = smbios_add_prop(ctx, NULL, U_BOOT_DMI_DATE);
>>   #ifdef CONFIG_ROM_SIZE
>> -       t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
>> +       if (CONFIG_ROM_SIZE < 0x1000000) {
> 
> nit, but can we use SZ_16M instead? Then the comment below goes away

Sure.

> 
>> +               /* CONFIG_ROM_SIZE < 16 MiB */
>> +               t->bios_rom_size = (CONFIG_ROM_SIZE / 65536) - 1;
>> +       } else {
>> +               /* CONFIG_ROM_SIZE < 8 GiB */
>> +               t->bios_rom_size = 0xff;
> 
> If the size is above 1gb we should also change bits 15:14. I guess
> being above 1GB will never happen, but can we add a comment?

There is a comment mentioning the 8 GiB limit.

As there are 13 bits for the number, we can encode sizes up to 8091 MiB 
in MiB. We should not try to encode a 1536 MiB flash as 1 GiB.

Best regards

Heinrich

> 
> Thanks
> /IIlias
>> +               t->extended_bios_rom_size = CONFIG_ROM_SIZE >> 20;
>> +       }
>>   #endif
>>          t->bios_characteristics = BIOS_CHARACTERISTICS_PCI_SUPPORTED |
>>                                    BIOS_CHARACTERISTICS_SELECTABLE_BOOT |
>> --
>> 2.45.2
>>

