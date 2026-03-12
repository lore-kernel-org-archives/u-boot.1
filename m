Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EE2FED2DD
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 07:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7BB83F9A;
	Thu, 12 Mar 2026 08:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pIPAABTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A6E983F8A; Thu, 12 Mar 2026 08:50:52 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461278410C
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB10F3F641
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 07:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1773301849;
 bh=2mFR0yYnFqi7wX/GtwdXEVlkKlwoteaLCPhUt6Jb81M=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=pIPAABTHij9KHfUx6m57MItcXfh+AEvXqD32FxtpxZN1oqT+KWj3nMfPK1qQc1lqv
 8kNRIRN9zRrY3dXFCswaelVpWQVNRe3Q8w5XBTXjT+zPBcgQ1hZTV2gwvUC2NwI5Jy
 c7+VdP0U4PXhv2+f8Ll3PFguOoqarZtJKzEwbal4UnC5o2zwluSeF4HlJPNN5Uv87Z
 KuihcnP4U1NXr6LqF3yjvXQyc/qhjYTpy3GBkrE4ikQqCLt7FAECO9r3A5V9jH+zAN
 4Z9RRzLnsYwVsx5RUbtkaPj/F9Kev5R2CyzRp7YBEt7YUPjZAxZWpMOaZSHwEn1nJS
 yiVM/t37SgQgRrGMgvGRvO16CKT2vYqYR+okxcKVzHjZDDCeJ5/8AfL1hbd7sdrhVS
 oijL/9sFiKQjy4E462lqNspiUgboFdu1BDrxtuePycTyv0KOeiU+6dwTszMm/QBrzV
 mEX7XgL9OTHR2KSMStZJXRzAhpGHPSb5wkA1DRMTO7kwifLpA7zSqYTT5Xg8zdlr39
 tcWGOu96SajF5OVAVf0OytWKvg6fB5dwGsxYGk9q6fWFZiwqO2ZMMnerthBc8zef43
 cAz1+cbhr1nNk95bqiWD2gwtlNaiX4GTZqVh4en1UVqieuvMsMm9U9MndyoE3Q+mbr
 bbNsi21Gd0FLnVxZ7b5cb7ic=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48535f4d5e1so5465895e9.0
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 00:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773301849; x=1773906649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2mFR0yYnFqi7wX/GtwdXEVlkKlwoteaLCPhUt6Jb81M=;
 b=nYoz8i5+x6HnJX7052NUL/xTKaeIG29KHqfW1AUe7xkkxN+qjKNKYhUulV86ELMyxU
 iKJQqgXEWwp7P3yra6vqdOT5gKac90NTKSptAPjblvhax5DdQ17JibbiDhmjIrKSzwbc
 fHbCJgJpMcMenrmTD9eNWsbMnsbGOX/C5OIb9h4lri/vsiIMMltk1Bktm2j9OYNJWZn2
 Wv39WSNHku7ziHoKRMaT/Sj0jxNW7eqJBbjxvMvChX4KkYnBitCuMB3wM8QTZq9tUBXx
 DTNsi11zd57gF945pNmqQMw0s3mTn+I9b/c1RD15Z5342g5rzLah3ncrr7Dt69ACJL88
 u1jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp99Crhn3i48d3rwQIIbAg4iMUh4R9mdK4BY4cAbbT6VVt8ybhX3FEFv6yclPMU6jvukjV6Oo=@lists.denx.de
X-Gm-Message-State: AOJu0YyaJ7Dam5hVAOolS/RsI0l5KqmoeJJpyH0H5+6RcV8vbjzHo/tQ
 5LP1ZTVRPFEk7VrHD6OkGVWJlgobmbBvjXcHHklkhxx9XrkvAu8DNg9YQQzBYT8sCl3xiOd8/Wb
 GVXKsUtDhUere0VYzAVb3NbN6GdviP7d2BrTfgtXB1ldzTYJsbJrcA9yM35qCaBBJ6CgOIUc=
X-Gm-Gg: ATEYQzy79rM/Y2U0bnrT7Bo3tXAJSg8pFRk+gaRot9ZQEQKZEAzsWy5JJVKM78QKwcO
 gyoLDtfIxLKILYtJ1XYZUT6nQnE4MivRD0zI20t6Isy8YEjGl8bUGtfviF+nHwLvNVBrfadSOaE
 RlRbH13Kw0e9Q5RJYOCF3E6nt5Eh9LBbh4uCaH53oaF2gPOjshMQ7YgZLDMpjCTStha72NVD0wk
 zj5zMbgSaLdI8m3ZMtTqTcKW23RelOvG+TWxtl/lat0J9z29wrWZ9Nv6sFOHVZKeQ6Zwyu7d4i7
 076TXhtpEb10J6csM06RMkQYwseUbUvyne14vdOlEpjIRUrEP0LJ1oDrjAj8J1IIVZYhMlZG6Uc
 +krmEUOac6oRMWnFsgwyOLzvY+K1gRC4ykkJWQYF4GWna1/PkiCxlcJSPUCZtSjmfqTtQaXGLR7
 2w165313tn5GWu+J2iNaW71Xhm3CGc9IRsUrs0jq4mwnBy3zXL4iw=
X-Received: by 2002:a05:600c:6990:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-4854b0bb7a3mr88699895e9.12.1773301849347; 
 Thu, 12 Mar 2026 00:50:49 -0700 (PDT)
X-Received: by 2002:a05:600c:6990:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-4854b0bb7a3mr88699315e9.12.1773301848724; 
 Thu, 12 Mar 2026 00:50:48 -0700 (PDT)
Received: from [192.168.103.130]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541ab9f9esm218272575e9.4.2026.03.12.00.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 00:50:48 -0700 (PDT)
Message-ID: <92e98f1d-8a47-4889-a379-a0a670e102bc@canonical.com>
Date: Thu, 12 Mar 2026 08:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>
Cc: Shantur Rathore <i@shantur.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
References: <f49e4ac8da5bae9252c79031f1661f386d17895f.1771247847.git.michal.simek@amd.com>
 <82aa8024-e80f-4db8-b0be-c8558c953c1b@gmx.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <82aa8024-e80f-4db8-b0be-c8558c953c1b@gmx.de>
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

On 3/11/26 16:08, Heinrich Schuchardt wrote:
> On 2/16/26 14:17, Michal Simek wrote:
>> From: Shantur Rathore <i@shantur.com>
>>
>> Currently U-Boot uses ESP as storage for EFI variables.
>> Devices with SPI Flash are used for storing environment with this
>> commit we allow EFI variables to be stored on SPI Flash.
>>
>> Signed-off-by: Shantur Rathore <i@shantur.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> ---
>>
>> Changes in v9:
>> - Remove EFI_RT_VOLATILE_STORE enabling
>> - Cleanup commit message
>>
>> Changes in v8:
>> - Add missing EFI_VARIABLE_SF_STORE dependency to 
>> EFI_VARIABLE_SF_DEVICE_INDEX
>>
>> Changes in v7:
>> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>>
>> Changes in v6:
>> - sed -i 's/efi_var_read/efi_var_from/g'
>> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>>
>> Changes in v4:
>> - Extend Kconfig description
>> - Extend commit message and describe efivar missing part
>> - use unify methods for reading/writing variable
>>
>> Changes in v3:
>> - Fixed compiler warnings.
>>
>> Changes in v2:
>> - Refactored efi_var_file to move common parts out as requested
>> - Changed ifdefs to use CONFIG_IS_DEFINED
>> - Fixed typos
>>
>>   lib/efi_loader/Kconfig      | 33 +++++++++++++
>>   lib/efi_loader/Makefile     |  1 +
>>   lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 126 insertions(+)
>>   create mode 100644 lib/efi_loader/efi_var_sf.c
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 579eed658801..315dd4f3e794 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
>>         Select this option if you want non-volatile UEFI variables to be
>>         stored as file /ubootefi.var on the EFI system partition.
>> +config EFI_VARIABLE_SF_STORE
>> +    bool "Store non-volatile UEFI variables in SPI Flash"
>> +    depends on SPI_FLASH
>> +    help
>> +      Select this option if you want non-volatile UEFI variables to be
>> +      stored in SPI Flash.
>> +
>> +      Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to 
>> use as
>> +      the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the 
>> space
>> +      needed.
>> +
>> +      Note that SPI Flash devices have a limited number of program/erase
>> +      cycles. Frequent updates to UEFI variables may cause excessive 
>> wear
>> +      and can permanently damage the flash device, particularly on 
>> SPI NAND
>> +      or low-end SPI NOR parts without wear leveling. This option 
>> should be
>> +      used with care on such systems, and is not recommended for 
>> platforms
>> +      where UEFI variables are updated frequently.
>> +
>>   config EFI_MM_COMM_TEE
>>       bool "UEFI variables storage service via the trusted world"
>>       depends on OPTEE
>> @@ -194,6 +212,21 @@ config FFA_SHARED_MM_BUF_ADDR
>>         the MM SP in secure world.
>>         It is assumed that the MM SP knows the address of the shared 
>> MM communication buffer.
>> +config EFI_VARIABLE_SF_OFFSET
>> +    hex "EFI variables in SPI flash offset"
>> +    depends on EFI_VARIABLE_SF_STORE
>> +    help
>> +      Offset from the start of the SPI Flash where EFI variables will 
>> be stored.
>> +      This should be aligned to the sector size of SPI Flash.
>> +
>> +config EFI_VARIABLE_SF_DEVICE_INDEX
>> +    int "Device Index for target SPI Flash"
>> +    depends on EFI_VARIABLE_SF_STORE
>> +    default 0
>> +    help
>> +      The index of SPI Flash device used for storing EFI variables. 
>> This would be
>> +      needed if there are more than 1 SPI Flash devices available to 
>> use.
>> +
>>   config EFI_VARIABLES_PRESEED
>>       bool "Initial values for UEFI variables"
>>       depends on !COMPILE_TEST
>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> index ca1775eb03be..d73ad43951b1 100644
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -54,6 +54,7 @@ obj-y += efi_variable_tee.o
>>   else
>>   obj-y += efi_variable.o
>>   obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
>> +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
>>   obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
>>   endif
>>   obj-y += efi_watchdog.o
>> diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
>> new file mode 100644
>> index 000000000000..61d68f7c5c94
>> --- /dev/null
>> +++ b/lib/efi_loader/efi_var_sf.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * SPI Flash interface for UEFI variables
>> + *
>> + * Copyright (c) 2023, Shantur Rathore
>> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#define LOG_CATEGORY LOGC_EFI
>> +
>> +#include <efi_loader.h>
>> +#include <efi_variable.h>
>> +#include <spi_flash.h>
>> +#include <dm.h>
>> +
>> +efi_status_t efi_var_to_storage(void)
>> +{
>> +    efi_status_t ret;
>> +    struct efi_var_file *buf;
>> +    loff_t len;
>> +    struct udevice *sfdev;
>> +
>> +    ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
>> +    if (len > EFI_VAR_BUF_SIZE) {
>> +        log_err("EFI var buffer length more than target SPI Flash 
>> size");
>> +        ret = EFI_OUT_OF_RESOURCES;
>> +        goto error;
>> +    }
>> +
>> +    log_debug("%s - Got buffer to write buf->len : %d\n", __func__, 
>> buf->length);
> 
> Hello Michal,
> 
> Thank you for driving this.
> 
> The log system is configurable to print file, line, function name if 
> wanted. We should not duplicate this here. Please, remove __func__ 
> throughout the patch.
> 
>> +
>> +    if (ret != EFI_SUCCESS)
>> +        goto error;
>> +
>> +    ret = uclass_get_device(UCLASS_SPI_FLASH, 
>> CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
>> +    if (ret)
> 
> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
> 
>> +        goto error;
>> +
>> +    ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, 
>> EFI_VAR_BUF_SIZE);
>> +    log_debug("%s - Erased SPI Flash offset %x\n", __func__, 
>> CONFIG_EFI_VARIABLE_SF_OFFSET);
> 
> A debug output if erasing failed would be more interesting.
> 
>> +    if (ret)
> 
> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
> 
>> +        goto error;
>> +
>> +    ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, 
>> len, buf);
>> +    log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
> 
> The uclass_get_device() return code should be saved in an int variable 
> to avoid confusion.
> 
>> +
>> +    if (ret)
> 
> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
> 
>> +        goto error;
>> +
>> +    ret = EFI_SUCCESS;
>> +error:
>> +    if (ret)
>> +        log_err("Failed to persist EFI variables in SF\n");
>> +    free(buf);
>> +    return ret;
>> +}
>> +
>> +efi_status_t efi_var_from_storage(void)
>> +{
>> +    struct efi_var_file *buf;
>> +    efi_status_t ret;
>> +    struct udevice *sfdev;
>> +
>> +    buf = calloc(1, EFI_VAR_BUF_SIZE);
>> +    if (!buf) {
>> +        log_err("%s - Unable to allocate buffer\n", __func__);
> 
> This function may be called from an EFI GUI application. We should not 
> output any strings to the console from API functions. It is task of the 
> caller to take appropriate actions. E.g. show a pop-up if a failure 
> occurs. log_debug() is ok.

I got this wrong. This function is called when initializing the EFI 
sub-system. So writing errors to the console is ok. It is 
efi_var_to_storage() which is invoked by EFI applications and where we 
should avoid console output.

Best regards

Heinrich

> 
>> +        return EFI_OUT_OF_RESOURCES;
>> +    }
>> +
>> +    ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
> 
> efi_var_restore() returns a signed int and not an unsigned efi_status_t. 
> Please, define a separate variable.
> 
>> +    if (ret)
> 
> Please, return EFI_DEVICE_ERROR.
> 
>> +        goto error;
>> +
>> +    ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
>> +                EFI_VAR_BUF_SIZE, buf);
>> +
>> +    log_debug("%s - read buffer buf->length: %x\n", __func__, buf- 
>> >length);
> 
> If spi_flash_read_dm() failed, you will just print some random value for 
> buf->length. Please, print the return value instead.
> 
>> +
>> +    if (ret || buf->length < sizeof(struct efi_var_file)) {
>> +        log_err("%s - buffer read from SPI Flash isn't valid\n", 
>> __func__);
> 
> If spi_flash_read_dm() fails we should return EFI_DEVICE_ERROR.
> 
>> +        goto error;
> 
> After erasing the SPI flash buf->length will be zero here. This should 
> not stop us from setting EFI variables.
> 
> It is the task of efi_var_restore to check the validity of the buffer. 
> So the length check here should be removed.
> 
> The missing check in efi_var_restore() is
> 
> buf->length <= EFI_VAR_BUF_SIZE
> 
> to avoid a buffer overrun when calculating the CRC32.
> 
>> +    }
>> +
>> +    ret = efi_var_restore(buf, false);
>> +    if (ret != EFI_SUCCESS)
>> +        log_err("%s - Unable to restore EFI variables from buffer\n", 
>> __func__);
>> +
>> +    ret = EFI_SUCCESS;
>> +error:
>> +    free(buf);
>> +    return ret;
> 
> We should not return a non-EFI return code here if uclass_get_device() 
> or spi_flash_read_dm() failed.
> 
>> +}
> 
> I configured starfive_visionfive2_defconfig with
> 
> CONFIG_EFI_VARIABLE_SF_STORE=y
> CONFIG_EFI_VARIABLE_SF_OFFSET=0xc0000
> CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX=0
> CONFIG_EFI_VAR_BUF_SIZE=131072
> 
> and it works.
> 
> Best regards
> 
> Heinrich

