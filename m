Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994DEC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CD488541;
	Fri, 26 Apr 2024 17:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bwPhyclH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645068856A; Fri, 26 Apr 2024 17:18:22 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33AE788541
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9BA223F280
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714144699;
 bh=ArAIld7JW04e7MOz8a8KhtV8pPTd7ugSYPzG8BXfb+s=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=bwPhyclHFvTFnLudOVN1DF7ZHnrquD3jdVvN6muTc10YuHdbaIaqjme+QgIt0Db5K
 LcM8TBkTdU/dyFeZ/1N4DjhA8lBJKTwEwiAtMmppPYI50oZavtoZbZp/SMczH8dXu2
 2C0xxltg17HxBj+5RLqyQTlBJpgf+aam8xLHN3i44n5+rXlVSiSChcAxB2Om8RpNnA
 Lmu2lG8SREdCvSMpdQIbCtgIhp034bKvNqzcevDeIv/5dSa+tORxvu1etM+O2npfd9
 ikckJgrWYsGwVVI8YQCzF4448mvg746QjDO+tHNIQTN14JxDloMlPAu9NSGuI6yM0C
 HDZntLw+TEB9A==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-346c08df987so1516001f8f.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714144699; x=1714749499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ArAIld7JW04e7MOz8a8KhtV8pPTd7ugSYPzG8BXfb+s=;
 b=X4GwCMMMLXYA+ouoFVr1Wj0CsRbsJS57SQuL5ovTcJ5f1Gaq+yxij0n2ojgjpv4Qx0
 yN2t6SOwujiZYRCG+kbSEEkAz3T1tLBFRcsXuamcFsazWv+fsX7xbrq0uZL7EcKNYTQ4
 SjMqjq7IvzIMe1RFiOA9tQcGyAIzHK2oMJ/h73anKVPWsqfvsoMIJgKOpFKQj0bkmqMM
 vcBrBsuoc2cxgnVLqYs6/LJGzupRjYfBTnvW6Z/wVZOXg5QinIPKZJBLRF/N/NYZQKhw
 ezqOefxJ2W3DSbYwCfbZlsOOmLOfCnVO5JGAO4FI5vp73e26IVR9uBjR/RN3mzp0dsP4
 Af2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj/X6GB+nC4AHmwPRitRcDxipC0TIfQPUz5d2hcYNn/UCnVgC7fZaxN4RhS6xyPn/FDSLY6XvgDjq7OuMtMB0ZhbnTwg==
X-Gm-Message-State: AOJu0YywudXvdCK+jEG8FPlAsCZD1UFIrlEuogsflI+kfAdKBzWe6Fd5
 hZTALgAgvgcEiaAQ+l6iekKRo9REmEFSVr2y9W7b4OYLzLc1uXPQntWKVy3xY33c4TtonUsPqMY
 HkJTVfPxvFGeFuidBEByPO6vouC1smnqv8/bZ3BPXGygRNRhtrx+Txp7YaaZfgGwe9j0=
X-Received: by 2002:adf:e847:0:b0:347:e6d1:2fb8 with SMTP id
 d7-20020adfe847000000b00347e6d12fb8mr5287wrn.34.1714144699247; 
 Fri, 26 Apr 2024 08:18:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXOwHyqRM4cRsFtUfeqa2CVc6vKeDcfHbLFbTRj07Yimk2jBSWZNuJBqlRkylOd/kMcPuebQ==
X-Received: by 2002:adf:e847:0:b0:347:e6d1:2fb8 with SMTP id
 d7-20020adfe847000000b00347e6d12fb8mr5256wrn.34.1714144698750; 
 Fri, 26 Apr 2024 08:18:18 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a5d6383000000b00341b451a31asm22536369wru.36.2024.04.26.08.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 08:18:18 -0700 (PDT)
Message-ID: <b83807de-ea0a-4b45-a44c-5a3c3cd505d1@canonical.com>
Date: Fri, 26 Apr 2024 17:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 11/14] efi_loader: move distro_efi_get_fdt_name()
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-12-heinrich.schuchardt@canonical.com>
 <6440a35f-1dfd-4eac-b59d-dc49e25e1ee7@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <6440a35f-1dfd-4eac-b59d-dc49e25e1ee7@linaro.org>
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

On 26.04.24 16:52, Caleb Connolly wrote:
> Hi Heinrich,
> 
> On 26/04/2024 16:13, Heinrich Schuchardt wrote:
>> Move distro_efi_get_fdt_name() to a separate C module
>> and rename it to efi_get_distro_fdt_name().
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/bootmeth_efi.c      | 60 ++-------------------------------
>>   include/efi_loader.h     |  2 ++
>>   lib/efi_loader/Makefile  |  1 +
>>   lib/efi_loader/efi_fdt.c | 73 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 78 insertions(+), 58 deletions(-)
>>   create mode 100644 lib/efi_loader/efi_fdt.c
>>
>> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
>> index aebc5207fc0..40da77c497b 100644
>> --- a/boot/bootmeth_efi.c
>> +++ b/boot/bootmeth_efi.c
>> @@ -144,62 +144,6 @@ static int distro_efi_check(struct udevice *dev, 
>> struct bootflow_iter *iter)
>>       return 0;
>>   }
>> -/**
>> - * distro_efi_get_fdt_name() - Get the filename for reading the .dtb 
>> file
>> - *
>> - * @fname: Place to put filename
>> - * @size: Max size of filename
>> - * @seq: Sequence number, to cycle through options (0=first)
>> - * Returns: 0 on success, -ENOENT if the "fdtfile" env var does not 
>> exist,
>> - * -EINVAL if there are no more options, -EALREADY if the control FDT 
>> should be
>> - * used
>> - */
>> -static int distro_efi_get_fdt_name(char *fname, int size, int seq)
>> -{
>> -    const char *fdt_fname;
>> -    const char *prefix;
>> -
>> -    /* select the prefix */
>> -    switch (seq) {
>> -    case 0:
>> -        /* this is the default */
>> -        prefix = "/dtb";
>> -        break;
>> -    case 1:
>> -        prefix = "";
>> -        break;
>> -    case 2:
>> -        prefix = "/dtb/current";
>> -        break;
> 
> This is a bit of a tangential point (and shouldn't block this series at 
> all). But where do we find a balance with this search algorithm? The 
> distro I work on (postmarketOS) actually installs DTB files to "/dtbs" 
> (not "/dtb").
> 
> No doubt we can come up with a bunch of clever ideas for optimising this 
> with wildcards or whatever, but is that something we want to implement?
> 
> What about distros that support falling back to previous kernel versions 
> (and consequently have the DTB dir named after the kernel version).
> 
> Presumably in these situations the distro would have systemd-boot, GRUB, 
> etc. Would it make sense to just inform the bootloader what the .dtb 
> file name is so that they can handle the path building?
> 
> (I understand there

We have been carrying the logic for scanning for DTBs in U-Boot since 
commit Fixes: 74522c898b35 ("efi_loader: Add distro boot script for 
removable media") merged in 2016.

The script based version allowed to modify variable efi_dtb_prefixes to 
scan other directories.

Now Simon has started with the 2024.01 release to move the logic from 
scripts in header files with script fragments to C files in /boot/.

This series is cleaning up the changes for bootmethod_efi_mgr.c.

Debian's flash-kernel package installs device-trees in dtb. I do not 
know if there are users for '/dtb/current/' or '/'. The more directories 
we scan the slower booting.

This specific patch does not change the current logic. If we need the 
flexibility back, that was provided by environment variable 
efi_dtb_prefixes we should look at it in a future change.

Best regards

Heinrich

  are other usecases and reasons to load the DTB ahead
> of time in U-Boot).
>> -    default:
>> -        return log_msg_ret("pref", -EINVAL);
>> -    }
>> -
>> -    fdt_fname = env_get("fdtfile");
>> -    if (fdt_fname) {
>> -        snprintf(fname, size, "%s/%s", prefix, fdt_fname);
>> -        log_debug("Using device tree: %s\n", fname);
>> -    } else if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE)) {
>> -        strcpy(fname, "<prior>");
>> -        return log_msg_ret("pref", -EALREADY);
>> -    /* Use this fallback only for 32-bit ARM */
>> -    } else if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)) {
>> -        const char *soc = env_get("soc");
>> -        const char *board = env_get("board");
>> -        const char *boardver = env_get("boardver");
>> -
>> -        /* cf the code in label_boot() which seems very complex */
>> -        snprintf(fname, size, "%s/%s%s%s%s.dtb", prefix,
>> -             soc ? soc : "", soc ? "-" : "", board ? board : "",
>> -             boardver ? boardver : "");
>> -        log_debug("Using default device tree: %s\n", fname);
>> -    } else {
>> -        return log_msg_ret("env", -ENOENT);
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   /*
>>    * distro_efi_try_bootflow_files() - Check that files are present
>>    *
>> @@ -241,7 +185,7 @@ static int distro_efi_try_bootflow_files(struct 
>> udevice *dev,
>>       ret = -ENOENT;
>>       *fname = '\0';
>>       for (seq = 0; ret == -ENOENT; seq++) {
>> -        ret = distro_efi_get_fdt_name(fname, sizeof(fname), seq);
>> +        ret = efi_get_distro_fdt_name(fname, sizeof(fname), seq);
>>           if (ret == -EALREADY)
>>               bflow->flags = BOOTFLOWF_USE_PRIOR_FDT;
>>           if (!ret) {
>> @@ -340,7 +284,7 @@ static int distro_efi_read_bootflow_net(struct 
>> bootflow *bflow)
>>       sprintf(file_addr, "%lx", fdt_addr);
>>       /* We only allow the first prefix with PXE */
>> -    ret = distro_efi_get_fdt_name(fname, sizeof(fname), 0);
>> +    ret = efi_get_distro_fdt_name(fname, sizeof(fname), 0);
>>       if (ret)
>>           return log_msg_ret("nam", ret);
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index 0ac04990b8e..ed2b517b130 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -1187,4 +1187,6 @@ efi_status_t efi_disk_get_device_name(const 
>> efi_handle_t handle, char *buf, int
>>    */
>>   void efi_add_known_memory(void);
>> +int efi_get_distro_fdt_name(char *fname, int size, int seq);
>> +
>>   #endif /* _EFI_LOADER_H */
>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> index 034e366967f..2af6f2066b5 100644
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -59,6 +59,7 @@ obj-y += efi_device_path.o
>>   obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
>>   obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
>>   obj-y += efi_dt_fixup.o
>> +obj-y += efi_fdt.o
>>   obj-y += efi_file.o
>>   obj-$(CONFIG_EFI_LOADER_HII) += efi_hii.o
>>   obj-y += efi_image_loader.o
>> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
>> new file mode 100644
>> index 00000000000..0edf0c1e2fc
>> --- /dev/null
>> +++ b/lib/efi_loader/efi_fdt.c
>> @@ -0,0 +1,73 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Bootmethod for distro boot via EFI
>> + *
>> + * Copyright 2021 Google LLC
>> + * Written by Simon Glass <sjg@chromium.org>
>> + */
>> +
>> +#include <efi_loader.h>
>> +#include <env.h>
>> +#include <errno.h>
>> +#include <log.h>
>> +#include <string.h>
>> +#include <vsprintf.h>
>> +
>> +/**
>> + * distro_efi_get_fdt_name() - get the filename for reading the .dtb 
>> file
>> + *
>> + * @fname:    buffer for filename
>> + * @size:    buffer size
>> + * @seq:    sequence number, to cycle through options (0=first)
>> + *
>> + * Returns:
>> + * 0 on success,
>> + * -ENOENT if the "fdtfile" env var does not exist,
>> + * -EINVAL if there are no more options,
>> + * -EALREADY if the control FDT should be used
>> + */
>> +int efi_get_distro_fdt_name(char *fname, int size, int seq)
>> +{
>> +    const char *fdt_fname;
>> +    const char *prefix;
>> +
>> +    /* select the prefix */
>> +    switch (seq) {
>> +    case 0:
>> +        /* this is the default */
>> +        prefix = "/dtb";
>> +        break;
>> +    case 1:
>> +        prefix = "";
>> +        break;
>> +    case 2:
>> +        prefix = "/dtb/current";
>> +        break;
>> +    default:
>> +        return log_msg_ret("pref", -EINVAL);
>> +    }
>> +
>> +    fdt_fname = env_get("fdtfile");
>> +    if (fdt_fname) {
>> +        snprintf(fname, size, "%s/%s", prefix, fdt_fname);
>> +        log_debug("Using device tree: %s\n", fname);
>> +    } else if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE)) {
>> +        strcpy(fname, "<prior>");
>> +        return log_msg_ret("pref", -EALREADY);
>> +    /* Use this fallback only for 32-bit ARM */
>> +    } else if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_ARM64)) {
>> +        const char *soc = env_get("soc");
>> +        const char *board = env_get("board");
>> +        const char *boardver = env_get("boardver");
>> +
>> +        /* cf the code in label_boot() which seems very complex */
>> +        snprintf(fname, size, "%s/%s%s%s%s.dtb", prefix,
>> +             soc ? soc : "", soc ? "-" : "", board ? board : "",
>> +             boardver ? boardver : "");
>> +        log_debug("Using default device tree: %s\n", fname);
>> +    } else {
>> +        return log_msg_ret("env", -ENOENT);
>> +    }
>> +
>> +    return 0;
>> +}
> 

