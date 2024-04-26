Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385CEC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B954088682;
	Fri, 26 Apr 2024 17:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QJ3cyMlh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C98088698; Fri, 26 Apr 2024 17:31:37 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF5B81EEF
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51acb95b892so2931904e87.2
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714145495; x=1714750295; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=op6pjnAZGP2vQukJ59KT5Xlpxx7RMzmDyDcXUMhJ4JI=;
 b=QJ3cyMlha1RMb+5aUklgZz1zhZ3XOopynfQjFcIGTUUKjeCCUjsiLb9VjrEt6+0BhT
 XiH8g+MFAvOxv2QEPlwzOEdBSyX0gRNLvZC/VLYmvjN+Li0hr9I/Jsa1UvCJOujoDY4Q
 wLaRmBmQCi118iqDXAcJcIH5zw9+HOoTwdrUXmSIq4LR8XImwhrE0bY1fJKFexKPtxmx
 qlcqa1XfRJGKFfyh9HmAW8lzdRWVITo69qhhDpOiFWbLPzbVY2i17dFSolsSV6cT3oyJ
 qrbt7RfQkuBae+jZzezdvjvuwDzrf51kZ1AVpZMEkFxRTbv28LmcQpkdSMcwlPuLbxUs
 zAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714145495; x=1714750295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=op6pjnAZGP2vQukJ59KT5Xlpxx7RMzmDyDcXUMhJ4JI=;
 b=djEKyqzpJAtTLA+dVBS02SOPJZfwrAdaGKMw9FRKhhVmWIairltQsOJzJtSAiPFXPM
 g7jEstDAEy/Hc5OMl1Dje7EK22LMDRVmvHIVeGGJbhV6jJv1H9W75zucLhv42DbgRtpH
 O/32KA8miezmTGf2FA0sYmeTFe6IkQREhSxSbw4m79mEfVbddrvkwYd3Dgmj7Q3lzAsE
 G+JhG8l+jhKNumcSdB3dshFbTPMNNTofKO/iFe/VMMSJD/B60cz3Auu3dsLq0GVoBi7o
 RcL03J2iYPRx8B692qN3efsMtmiYc56a7MJ0quqDDAOlSt5APCuBqTjwmfLdUfTUkhXB
 Ce3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJZJAw5U+TNPIh/+dejLuDQMKfwnWgdZVFGphgusGvGyy73oTUl8ea6qbiPUoEBtFvkT+SRtO9i2e4G0dOmqOGXqO6EQ==
X-Gm-Message-State: AOJu0YyLPuVEHu57TGNLL8lyzEiWPr3itg80Zet5ZLv6CeXDL3DJYCpa
 lnqPmnb+pkYfd9N35/UcmJQx+5+k8pamTRg9I491WCXvCzwi2HOe
X-Google-Smtp-Source: AGHT+IFsugeWuRiby0w4fIYExn/mYVStncec6EfCtOlz2WZViP76Rc5eRCvMrMK8idygrbnRz0CGAQ==
X-Received: by 2002:ac2:5607:0:b0:513:9e44:c68c with SMTP id
 v7-20020ac25607000000b005139e44c68cmr2260265lfd.6.1714145494301; 
 Fri, 26 Apr 2024 08:31:34 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:28a:c024:f9e9:89d9:4998:675d?
 ([2a00:1fa0:28a:c024:f9e9:89d9:4998:675d])
 by smtp.gmail.com with ESMTPSA id
 o16-20020ac24e90000000b00518df09f2d5sm3167354lfr.296.2024.04.26.08.31.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 08:31:33 -0700 (PDT)
Message-ID: <c4bd1827-8a10-4fc2-bc53-0ba0988b93d1@gmail.com>
Date: Fri, 26 Apr 2024 18:31:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: move ELF load and boot to lib/elf.c
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Maxim.Moskalets@kaspersky.com, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, quentin.schulz@theobroma-systems.com
References: <20240426091102.50350-1-Maxim.Moskalets@kaspersky.com>
 <98a5dfe3-f388-4cf0-89ae-5fc56c3dc729@gmx.de>
Content-Language: en-US
From: "Maxim M. Moskalets" <maximmosk4@gmail.com>
In-Reply-To: <98a5dfe3-f388-4cf0-89ae-5fc56c3dc729@gmx.de>
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

On 26.04.2024 17:32, Heinrich Schuchardt wrote:
> On 26.04.24 11:11, Maxim Moskalets wrote:
>> Loading and running the ELF image is the responsibility of the
>> library and should not be associated with the command line interface.
>>
>> It is also required to run ELF images from FIT with the bootm command
>> so as not to depend on the command line interface.
>>
>> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
>> ---
>>   cmd/elf.c     | 49 +++++++++++++++++--------------------------------
>>   include/elf.h | 10 ++++++++++
>>   lib/elf.c     | 36 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 63 insertions(+), 32 deletions(-)
>>
>> diff --git a/cmd/elf.c b/cmd/elf.c
>> index df4354d374..8bbdc67db7 100644
>> --- a/cmd/elf.c
>> +++ b/cmd/elf.c
>> @@ -20,21 +20,6 @@
>>   #include <linux/linkage.h>
>>   #endif
>>
>> -/* Allow ports to override the default behavior */
>> -static unsigned long do_bootelf_exec(ulong (*entry)(int, char * 
>> const[]),
>> -                     int argc, char *const argv[])
>> -{
>> -    unsigned long ret;
>> -
>> -    /*
>> -     * pass address parameter as argv[0] (aka command name),
>> -     * and all remaining args
>> -     */
>> -    ret = entry(argc, argv);
>> -
>> -    return ret;
>> -}
>> -
>>   /* Interpreter command to boot an arbitrary ELF image from memory */
>>   int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char 
>> *const argv[])
>>   {
>> @@ -44,8 +29,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int 
>> argc, char *const argv[])
>>   #endif
>>       unsigned long addr; /* Address of the ELF image */
>>       unsigned long rc; /* Return value from user code */
>> -    char *sload = NULL;
>>       int rcode = 0;
>> +    Bootelf_flags flags = {0};
>>
>>       /* Consume 'bootelf' */
>>       argc--; argv++;
>> @@ -53,7 +38,10 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, 
>> int argc, char *const argv[])
>>       /* Check for [-p|-s] flag. */
>>       if (argc >= 1 && (argv[0][0] == '-' && \
>>                   (argv[0][1] == 'p' || argv[0][1] == 's'))) {
>> -        sload = argv[0];
>> +        if (argv[0][1] == 'p')
>> +            flags.phdr = 1;
>> +        printf("## Try to elf hdr format %s\n",
>> +                flags.phdr ? "phdr" : "shdr");
>>           /* Consume flag. */
>>           argc--; argv++;
>>       }
>> @@ -76,14 +64,6 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, 
>> int argc, char *const argv[])
>>       } else
>>           addr = image_load_addr;
>>
>> -    if (!valid_elf_image(addr))
>> -        return 1;
>> -
>> -    if (sload && sload[1] == 'p')
>> -        addr = load_elf_image_phdr(addr);
>> -    else
>> -        addr = load_elf_image_shdr(addr);
>> -
>>   #if CONFIG_IS_ENABLED(CMD_ELF_FDT_SETUP)
>>       if (fdt_addr) {
>>           printf("## Setting up FDT at 0x%08lx ...\n", fdt_addr);
>> @@ -94,21 +74,26 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, 
>> int argc, char *const argv[])
>>       }
>>   #endif
>>
>> -    if (!env_get_autostart())
>> -        return rcode;
>> -
>> -    printf("## Starting application at 0x%08lx ...\n", addr);
>> -    flush();
>> +    if (env_get_autostart()) {
>> +        flags.autostart = 1;
>> +        printf("## Starting application at 0x%08lx ...\n", addr);
>> +        flush();
>> +    }
>>
>>       /*
>>        * pass address parameter as argv[0] (aka command name),
>>        * and all remaining args
>>        */
>> -    rc = do_bootelf_exec((void *)addr, argc, argv);
>> +    rc = bootelf(addr, flags, argc, argv);
>>       if (rc != 0)
>>           rcode = 1;
>>
>> -    printf("## Application terminated, rc = 0x%lx\n", rc);
>> +    if (flags.autostart) {
>> +        if (ENOEXEC == errno)
>> +            printf("## Invalid ELF image\n");
>> +        else
>> +            printf("## Application terminated, rc = 0x%lx\n", rc);
>> +    }
>>
>>       return rcode;
>>   }
>> diff --git a/include/elf.h b/include/elf.h
>> index a4ba74d8ab..b88e6cf403 100644
>> --- a/include/elf.h
>> +++ b/include/elf.h
>> @@ -12,6 +12,12 @@
>>   #ifndef __ASSEMBLY__
>>   #include "compiler.h"
>>
>> +/* Flag param bits for bootelf() function */
>> +typedef struct {
>> +    unsigned phdr      : 1; /* load via program (not section) 
>> headers */
>> +    unsigned autostart : 1; /* Start ELF after loading */
>> +} Bootelf_flags;
>> +
>>   /* This version doesn't work for 64-bit ABIs - Erik */
>>
>>   /* These typedefs need to be handled better */
>> @@ -700,6 +706,10 @@ unsigned long elf_hash(const unsigned char *name);
>>   #define R_RISCV_RELATIVE    3
>>
>>   #ifndef __ASSEMBLY__
>> +unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
>> +               int argc, char *const argv[]);
>> +unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
>> +              int argc, char *const argv[]);
>>   int valid_elf_image(unsigned long addr);
>>   unsigned long load_elf64_image_phdr(unsigned long addr);
>>   unsigned long load_elf64_image_shdr(unsigned long addr);
>> diff --git a/lib/elf.c b/lib/elf.c
>> index 9a794f9cba..0f3d752758 100644
>> --- a/lib/elf.c
>> +++ b/lib/elf.c
>> @@ -7,6 +7,7 @@
>>   #include <cpu_func.h>
>>   #include <elf.h>
>>   #include <env.h>
>> +#include <errno.h>
>>   #include <net.h>
>>   #include <vxworks.h>
>>   #ifdef CONFIG_X86
>> @@ -15,6 +16,41 @@
>>   #include <linux/linkage.h>
>>   #endif
>>
>> +/* Allow ports to override the default behavior */
>> +unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
>> +               int argc, char *const argv[])
>> +{
>> +    return entry(argc, argv);
>> +}
>> +
>> +/*
>> + * Boot ELF from memory
>> + *
>> + * addr       - loading address of ELF in memory
>> + * flags      - bits like ELF_PHDR to control boot details
>> + * argc, argv - may be used to pass command line arguments (maybe 
>> unused)
>> + *
>> + * Sets errno = ENOEXEC if ELF image is not valid
>> + */
>> +unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
>> +              int argc, char *const argv[])
>
> Moving bootelf functionality is a good idea as we want to be able to
> build without command line interface.
>
> We should define the library functions without usage of argc and argv.
> The translation from argv[], argc to the library function parameters
> should happen in cmd/elf.c.
>
> Best regards
>
> Heinrich
>

In the library ported part, command line arguments are not analyzed, 
only passed
to the running image.

This is necessary to pass the command line arguments to the running 
applications,
which is required for backward compatibility. In other cases, you can 
replace argc
and argv with null values.

Perhaps there is a better engineering solution for putting this in the 
library and
maintaining compatibility?

Translated with DeepL.com (free version)

Best regards

Maxim
>> +{
>> +    unsigned long entry_addr;
>> +
>> +    if (!valid_elf_image(addr)) {
>> +        errno = ENOEXEC;
>> +        return 1;
>> +    }
>> +
>> +    entry_addr = flags.phdr ? load_elf_image_phdr(addr)
>> +                        : load_elf_image_shdr(addr);
>> +
>> +    if (!flags.autostart)
>> +        return 0;
>> +
>> +    return bootelf_exec((void *)entry_addr, argc, argv);;
>> +}
>> +
>>   /*
>>    * A very simple ELF64 loader, assumes the image is valid, returns the
>>    * entry point address.
>

