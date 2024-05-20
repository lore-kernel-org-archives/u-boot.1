Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5529CC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 11:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758648820B;
	Mon, 20 May 2024 13:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ltuPHaLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF8A88239; Mon, 20 May 2024 13:51:37 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1318387FED
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 13:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-61e0c2b5cd2so14019777b3.1
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716205893; x=1716810693; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pCN3NQ0HZogP43k1vBK3x0c6jJezheME9UHuPUPllZQ=;
 b=ltuPHaLnJo7sqPhMbD0H8k4t55fz+nd5UX2NsMRnHEULWJclHnocdSuGldnnqiSHjy
 QyXF4udAMD7JI/btzencOljpYG9W32qnSsWJgDZdOpmCYhZd3UTA/xPnpkLa8cTn1Ufa
 8V6RZNpPv1CoEbbERc335KZ34/G5eLATpYgF9M3+z404iUMMmO16jiLOyZvypwrM85bd
 1CHTRUe63TqLuf4mmNE5K6p08+dtD+yhJwNe8yXNQbmY4yLe6Ulngu4uvFaNFCM1tisZ
 bwByp3ucoju2VrYNN3Dw1rP7f3STZ5QPnUFc7NQGLyoh9KpVOHtUOZVRSePvu3nK8WUv
 9Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716205893; x=1716810693;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pCN3NQ0HZogP43k1vBK3x0c6jJezheME9UHuPUPllZQ=;
 b=SSRgIRPwKT9p+GBZZFhkicNw7J+VeIRQrJ4OrCbNcF9IB561ODIxju8c/+5qv0c7gH
 FH2Vxgebru0cTGcS7PxkJWJGriUCm66zBPuq+OkhO13y/VwdX0rDSyYMrzZsX0GxEujh
 huoYE/nw4kRIhTzo2Ucj6HNOeS0/SLbvGs7JIdFJCaSewCTHaPK7p4YWSRlLmSQop/rX
 UKLIgey69ifI7CcTpB5T6ard8BTfRrow8kvWZ5q2ZNpL4NyvcJ2eRnj96VLMAiG1shqD
 +AqTtTskI5Tp0KduUaEFj9H1RQDt3vVQrFxsVeOtLDkdKM7ATQP1JdElskPF94BrzjVB
 zC9Q==
X-Gm-Message-State: AOJu0YwC3DgqUehJI5DlTSIRijLRcIHNPmqY1SG4QIzN4G70sfC4IhTJ
 y2IdMFSPbUtp6kQrkmbV5OJICIOvVy63skmLiMdR2whWoWmNuYwhHsrUz5VrKSDZZQQh0QWfbuL
 3k71vTocn7ZtQ21SqIc9UH62Rmb1wBt1W
X-Google-Smtp-Source: AGHT+IFU/43/nsUNXcijFWm5op99Dw0u7xwJKm0wvHHiVKCOFx+MoqsSG1Qp9wQTQWNPbsaBE41q5wuYItTTA98deBk=
X-Received: by 2002:a05:690c:6084:b0:61a:db4d:cc1f with SMTP id
 00721157ae682-627971c33dbmr29469367b3.7.1716205892315; Mon, 20 May 2024
 04:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240513181757.84898-1-Maxim.Moskalets@kaspersky.com>
 <673897a4-4887-4ca0-9dbb-a6d94ebed335@gmx.de>
 <497c0a11-998a-4e55-9b2d-d88cb33bd330@gmail.com>
In-Reply-To: <497c0a11-998a-4e55-9b2d-d88cb33bd330@gmail.com>
From: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgdC60LDQu9C10YY=?=
 <maximmosk4@gmail.com>
Date: Mon, 20 May 2024 14:51:20 +0300
Message-ID: <CALUeBeA6+=WDGE4L22Njdokqa9HDkBzqOyG3RVCv510igaHmoQ@mail.gmail.com>
Subject: Fwd: [PATCH v2] cmd: move ELF load and boot to lib/elf.c
To: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 18.05.2024 12:40, Heinrich Schuchardt wrote:
> On 5/13/24 20:17, Maxim Moskalets wrote:
>> From: Maxim Moskalets <maximmosk4@gmail.com>
>>
>> Loading and running the ELF image is the responsibility of the
>> library and should not be associated with the command line interface.
>>
>> It is also required to run ELF images from FIT with the bootm command
>> so as not to depend on the command line interface.
>>
>> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
>> ---
>>   cmd/elf.c     | 49 +++++++++++++++++--------------------------------
>>   include/elf.h | 10 ++++++++++
>>   lib/elf.c     | 38 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 65 insertions(+), 32 deletions(-)
>>
>> diff --git a/cmd/elf.c b/cmd/elf.c
>> index a02361f9f5..1fb955ae41 100644
>> --- a/cmd/elf.c
>> +++ b/cmd/elf.c
>> @@ -19,21 +19,6 @@
>>   #include <linux/linkage.h>
>>   #endif
>>
>> -/* Allow ports to override the default behavior */
>> -static unsigned long do_bootelf_exec(ulong (*entry)(int, char *
>> const[]),
>> -                     int argc, char *const argv[])
>> -{
>> -    unsigned long ret;
>> -
>> -    /*
>> -     * pass address parameter as argv[0] (aka command name),
>> -     * and all remaining args
>
> Carving out the library function is a good idea.
>
> Nits
>
> %s/args/arguments/
>
>> -     */
>> -    ret = entry(argc, argv);
>> -
>> -    return ret;
>> -}
>> -
>>   /* Interpreter command to boot an arbitrary ELF image from memory */
>
> Please, document functions fully:
>
>
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation
>
>
> The preferred place for documenting exported functions is in the header
> file.
>

Not my code, but okay.

>>   int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char
>> *const argv[])
>>   {
>> @@ -43,8 +28,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int
>> argc, char *const argv[])
>>   #endif
>>       unsigned long addr; /* Address of the ELF image */
>>       unsigned long rc; /* Return value from user code */
>> -    char *sload = NULL;
>>       int rcode = 0;
>
> Maybe
>
> %s/0/CMD_RET_SUCCESS/
>
>> +    Bootelf_flags flags = {0};
>>
>>       /* Consume 'bootelf' */
>>       argc--; argv++;
>> @@ -52,7 +37,10 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag,
>> int argc, char *const argv[])
>>       /* Check for [-p|-s] flag. */
>>       if (argc >= 1 && (argv[0][0] == '-' && \
>>                   (argv[0][1] == 'p' || argv[0][1] == 's'))) {
>> -        sload = argv[0];
>> +        if (argv[0][1] == 'p')
>> +            flags.phdr = 1;
>> +        printf("## Try to elf hdr format %s\n",
>> +                flags.phdr ? "phdr" : "shdr");
>
> Please, use log_debug() for debug messages and avoid the '## ' noise.
>
> Do you mean:
>
> log_debug("Using ELF header format %s\n",
>

It was in original implementation, but i can fix.

>>           /* Consume flag. */
>>           argc--; argv++;
>>       }
>> @@ -75,14 +63,6 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag,
>> int argc, char *const argv[])
>>       } else
>>           addr = image_load_addr;
>>
>> -    if (!valid_elf_image(addr))
>> -        return 1;
>> -
>> -    if (sload && sload[1] == 'p')
>> -        addr = load_elf_image_phdr(addr);
>> -    else
>> -        addr = load_elf_image_shdr(addr);
>> -
>>   #if CONFIG_IS_ENABLED(CMD_ELF_FDT_SETUP)
>>       if (fdt_addr) {
>>           printf("## Setting up FDT at 0x%08lx ...\n", fdt_addr);
>
> This looks like a debug message too.
>
>> @@ -93,21 +73,26 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag,
>> int argc, char *const argv[])
>>       }
>>   #endif
>>
>> -    if (!env_get_autostart())
>> -        return rcode;
>> -
>> -    printf("## Starting application at 0x%08lx ...\n", addr);
>> -    flush();
>> +    if (env_get_autostart()) {
>> +        flags.autostart = 1;
>> +        printf("## Starting application at 0x%08lx ...\n", addr);
>
> log_debug("Starting application at 0x%08lx ...\n", addr);
>
>> +        flush();
>> +    }
>>
>>       /*
>>        * pass address parameter as argv[0] (aka command name),
>>        * and all remaining args
>>        */
>> -    rc = do_bootelf_exec((void *)addr, argc, argv);
>> +    rc = bootelf(addr, flags, argc, argv);
>>       if (rc != 0)
>>           rcode = 1;
>
> %s/1/CMD_RET_FAILURE/
>
>>
>> -    printf("## Application terminated, rc = 0x%lx\n", rc);
>> +    if (flags.autostart) {
>> +        if (ENOEXEC == errno)
>
> if (rc && ENOEXEC == errno)
>
>> +            printf("## Invalid ELF image\n");
>
> log_err("Invalid ELF image\n");
>
>> +        else
>> +            printf("## Application terminated, rc = 0x%lx\n", rc);
>
> This message is only relevant if the application failed:
>
> else if (rc)
>     log_err("Application failed, rc = 0x%lx\n", rc);
>
>> +    }
>>
>>       return rcode;
>>   }
>> diff --git a/include/elf.h b/include/elf.h
>> index a4ba74d8ab..b88e6cf403 100644
>> --- a/include/elf.h
>> +++ b/include/elf.h
>> @@ -12,6 +12,12 @@
>>   #ifndef __ASSEMBLY__
>>   #include "compiler.h"
>>
>> +/* Flag param bits for bootelf() function */
>> +typedef struct {
>> +    unsigned phdr      : 1; /* load via program (not section)
>> headers */
>> +    unsigned autostart : 1; /* Start ELF after loading */
>> +} Bootelf_flags;
>> +
>>   /* This version doesn't work for 64-bit ABIs - Erik */
>
> If the elf command does not work in certain ABIs we need to ensure via
> Kconfig that it is not build for these.
>

Not my comment, i don't know.

>>
>>   /* These typedefs need to be handled better */
>> @@ -700,6 +706,10 @@ unsigned long elf_hash(const unsigned char *name);
>>   #define R_RISCV_RELATIVE    3
>>
>>   #ifndef __ASSEMBLY__
>> +unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
>> +               int argc, char *const argv[]);
>> +unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
>> +              int argc, char *const argv[]);
>>   int valid_elf_image(unsigned long addr);
>>   unsigned long load_elf64_image_phdr(unsigned long addr);
>>   unsigned long load_elf64_image_shdr(unsigned long addr);
>> diff --git a/lib/elf.c b/lib/elf.c
>> index 9a794f9cba..f8eeceef3d 100644
>> --- a/lib/elf.c
>> +++ b/lib/elf.c
>> @@ -7,6 +7,7 @@
>>   #include <cpu_func.h>
>>   #include <elf.h>
>>   #include <env.h>
>> +#include <errno.h>
>>   #include <net.h>
>>   #include <vxworks.h>
>>   #ifdef CONFIG_X86
>> @@ -15,6 +16,43 @@
>>   #include <linux/linkage.h>
>>   #endif
>>
>> +/* Allow ports to override the default behavior */
>
> Please, fully document the function.
>
>> +unsigned long bootelf_exec(ulong (*entry)(int, char * const[]),
>> +               int argc, char *const argv[])
>> +{
>> +    return entry(argc, argv);
>> +}
>> +
>> +/*
>> + * @brief Boot ELF from memory
>> + *
>> + * @param addr       Loading address of ELF in memory
>> + * @param flags      Bits like ELF_PHDR to control boot details
>> + * @param argc, argv May be used to pass command line arguments
>> (maybe unused)
>> + *             Necessary for backward compatibility with the CLI
>> command
>> + * @retuen Number returned by ELF application
>
> This does not match our documentation style, see
>
>
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation
>
>
>> + *
>> + * Sets errno = ENOEXEC if ELF image is not valid
>
> %s/if ELF/if the ELF/
>
>> + */
>> +unsigned long bootelf(unsigned long addr, Bootelf_flags flags,
>> +              int argc, char *const argv[])
>> +{
>> +    unsigned long entry_addr;
>> +
>> +    if (!valid_elf_image(addr)) {
>> +        errno = ENOEXEC;
>> +        return 1;
>> +    }
>> +
>> +    entry_addr = flags.phdr ? load_elf_image_phdr(addr)
>> +                        : load_elf_image_shdr(addr);
>> +
>> +    if (!flags.autostart)
>> +        return 0;
>
> Please, return early. We don't need entry_addr here.
>
>> +
>> +    return bootelf_exec((void *)entry_addr, argc, argv);;
>
> Duplicate ';'.
>
> An ELF binary may expect that argc >= 1 and argv[0] being the binary
> name. How do we ensure this?
>

Can i use dummy argc = 1 and argv =  {"", NULL}; if (!argc && !argv)?

> We should describe in a man-page doc/usage/cmd/elf.rst that the first
> extraneous argument passed to the elf command is argv[0]?
>
It is impossible for bootelf CLI command. In FIT we can describe behavior
(in next patch with ELFs in FIT).

> On some paths we have not set errno which means it has a random value
> set in unrelated functions. How would we able to evaluate errno in the
> caller if the return value is non-zero?
>
> Please, initialize errno to 0 at the start of the function.
>
> We need a test case. E.g. we could build an ELF binary returning the
> CRC32 of the concatenated arguments.
>
Not in this patch, but okay. What about example in sandbox tests
or/and example app?

Best regards

Maxim

> Best regards
>
> Heinrich
>
>> +}
>> +
>>   /*
>>    * A very simple ELF64 loader, assumes the image is valid, returns the
>>    * entry point address.
>
