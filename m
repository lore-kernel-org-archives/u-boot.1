Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D8FC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3281887860;
	Thu, 21 Dec 2023 15:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ELsWSWTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3549587707; Thu, 21 Dec 2023 15:55:44 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4326B876F3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1891E3F2CE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703170539;
 bh=BYeVJfM17b6iVW4aefP6O15AochHJJGwGb+AF1Xpni8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ELsWSWTVIm+SaIPdU/+Ti/O26lG0AdRxZyBOxkSDJzzFt+5q4Ytki04Ab0aOVUz0w
 +Kdd5/3S22YlTcRNRmi+oVSm0UfADHhA66xA7SQ/2cPJiu0vJo+sMft0ROYz+4Pjbh
 5Jej8hzprAF1SpcsKwzur/j8Ea9S45bs8MUfC9fFD4GK/4WD0l2fxMG3aiUGYfhVKo
 AfmdsHU8VovLBIWfDliib4rUI6stQxnNdEYsWIf0jTXHZcti01NgeQJ/c2JOXApNSs
 8Zy5NDoDmsS6Wc9KlNcUG1oySakHgCu6if2vAD/pQVCuL/aYNtOqLZxypa+hGwz2QE
 +mQuJrGA5D/1A==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d3eabab1eso4852195e9.2
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703170538; x=1703775338;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYeVJfM17b6iVW4aefP6O15AochHJJGwGb+AF1Xpni8=;
 b=jyjtCGhB+K0ZpGsVeShq0yxkhqk3CTNQC51OTgjKxAVAzYhuJO08DKBE7sIUr+CkEi
 ga85JeS3enQe4fVaJW3q+485NNKhX4RDKIQgJTdxiXQ52uvnzp6gr5S2Zkv49NjRz8+Q
 uwhj07fxUvVE2YiQCF9hk4+qycAigpAwZJUe+Z5UXMWLeYlqDaNglK+kYqCM9SOt/fcb
 1wX1mNukqnadgNhlvU1a9MGhMS65XXZ7xEl5V0HlRYClEh9fF9tPASPm0CkgynR0b68o
 935VWrMBDly8dleT60wMdeZqjRHMiyVcgyFTlhAYe+B5r7lOk2MMf/6HgEXPqJYBVllx
 mUsw==
X-Gm-Message-State: AOJu0YzrgNs5/2tRW30pByghBFepxukrcUphO2IF+pOj9CqXReLYJwBt
 b0fOQBffne5LCtr9SADm7b46NUgddVQpwvAATyz93ZPgKOIVfQpOk3LwlFF4XgujGhOiTK8ZI9h
 J7938E4LyMlDsrsgvMh/flwJPRTODhD8=
X-Received: by 2002:a05:600c:5185:b0:40c:361e:a28c with SMTP id
 fa5-20020a05600c518500b0040c361ea28cmr816399wmb.143.1703170538702; 
 Thu, 21 Dec 2023 06:55:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjjVdPJmAGtslmmeS5bHdnen8Gh03srJKiV10yC+EZ1nT4NKpXDRLIkOvH4djLqE2tTkgB8Q==
X-Received: by 2002:a05:600c:5185:b0:40c:361e:a28c with SMTP id
 fa5-20020a05600c518500b0040c361ea28cmr816393wmb.143.1703170538361; 
 Thu, 21 Dec 2023 06:55:38 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 n14-20020a5d51ce000000b00336765e9babsm2189255wrv.83.2023.12.21.06.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 06:55:37 -0800 (PST)
Message-ID: <919e6208-2a31-4f8e-9e5f-88bde32f5266@canonical.com>
Date: Thu, 21 Dec 2023 15:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] smbios: copy QEMU tables
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231221105017.6895-1-heinrich.schuchardt@canonical.com>
 <20231221105017.6895-3-heinrich.schuchardt@canonical.com>
 <CAEUhbmX0Ea=p1pz4bf3Mz4vXxqg_W0P_c0bDUHPgvRKPdYqeUw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAEUhbmX0Ea=p1pz4bf3Mz4vXxqg_W0P_c0bDUHPgvRKPdYqeUw@mail.gmail.com>
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

On 21.12.23 14:01, Bin Meng wrote:
> Hi Heinrich,
> 
> On Thu, Dec 21, 2023 at 6:50 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> QEMU provides SMBIOS tables with detailed information. We should not try to
>> replicate them in U-Boot.
>>
>> If we want to inform about U-Boot, we can add a Firmware Inventory
>> Information (type 45) table in future.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   drivers/misc/Kconfig        |   8 ++
>>   drivers/misc/Makefile       |   1 +
>>   drivers/misc/qfw_smbios.c   | 195 ++++++++++++++++++++++++++++++++++++
>>   lib/efi_loader/efi_smbios.c |   4 +-
>>   4 files changed, 207 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/misc/qfw_smbios.c
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index e8e4400516..3d885f12c8 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -561,6 +561,14 @@ config QFW_MMIO
>>            Hidden option to enable MMIO QEMU fw_cfg interface. This will be
>>            selected by the appropriate QEMU board.
>>
>> +config QFW_SMBIOS
>> +       bool
>> +       default y if ARM64
>> +       default y if RISCV && 64BIT
> 
> Would you add QEMU x86 support as well?

On x86_64 reading the QEMU SMBIOS firmware tables does not work for me. 
x86 uses the qfw_pio driver instead of qfw_mmio.

x86 overwrites gd->arch.smbios_start in write_tables(). Copying SMBIOS 
tables from QEMU would only make sense after some refactoring by the x86 
maintainers.

Best regards

Heinrich

> 
>> +       depends on QFW && SMBIOS
>> +       help
>> +         Hidden option to read SMBIOS tables from QEMU.
>> +
>>   config I2C_EEPROM
>>          bool "Enable driver for generic I2C-attached EEPROMs"
>>          depends on MISC
> 
> [snip]
> 
> Regards,
> Bin

