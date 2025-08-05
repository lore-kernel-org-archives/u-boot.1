Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD0BC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 07:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BF5832DA;
	Tue,  5 Aug 2025 09:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="klYTAdvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1811A832DD; Tue,  5 Aug 2025 09:33:49 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C51F183211
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 09:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6F4B83F5D1
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 07:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754379226;
 bh=YLuSMoIHe8yt+X7zF3wEYI41hrPoON1UTsSaTw1ZU8o=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=klYTAdvU8GC+GlWQLcKwoYiEhINfC5/t9mCt3iU5RnmAYhmXy9dAAwydS9OB6DgkC
 w9ZpvwiXcPOwjfNtzUgIPLb22TlorJ/3Y9IAwMlcy4lA9k5TbIcNy4k0HN+iXyHOBH
 etEdauzxydv5uGrX1+NRWBpsKUEERmuU6AnDUmCDqAyIArT8nrKBFmEawE8DkYu14f
 6VRo26R8eisPMV8/nIV/aKSxQSizKbXyb8ToYz9k8OFCWSkFKfmmohifEYuVFR/0Zv
 59SxlwLPlFHELXq4vFcox7Bje/tKNQNxSlW5eh73LwqK9zd2WWQiQOGIhZLlNxUBVR
 CgFrUeO1QEOYg==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b7882c0992so1774561f8f.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 00:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754379226; x=1754984026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YLuSMoIHe8yt+X7zF3wEYI41hrPoON1UTsSaTw1ZU8o=;
 b=ELbEgQbj/HGzozecuDFNxb2Z6OB5uFodKjAfKeXt7nhnfDgDrrdDAZAlG2MCq+Mazv
 Xt6BRNopQXn1BMCapCwWztdMnkSMXijgRQYFZDuIg9eLK0pgZTIOEjSAJ1EnMjmosC9F
 7k4M15yWlqU/c3jS/DAmstp0OVn88AgjAaLO14VhJij+LM6ld/hrgarpARW+FAsxOARi
 E3AwxSEjeMuEP6OIS3Gg2DXfGWPA0EqZauMrmrE3RQ/dgqEKk3YAK9VryoRrnLXOuaj0
 6hEr2Z+T15scIH/24VbupD7zC+mWMv7djDYy3r1sTaDLZSgJGtZi5rkHztQeTQKHnz8E
 5sqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5MEfe/4FzqBu3XTbERdtG6ODMO180G/NW2ej31kRYgHSVzy7v5OBeW4Q9hTl6e0QOR+cAeJs=@lists.denx.de
X-Gm-Message-State: AOJu0YxwEu2IigzHKw9IFjOcA3oQHSwbzdhrFiPHZtCuW3gjhjjaJETQ
 12HKYnYcSdlLLkMVTNvZBNBNf9n3M04qIlTSXU00ESNqHjz4vGItcbDgmateC/9zapGwzg5xmfK
 stSPOznvjo4rR1+P5Vvj+y/PgqSJnOY3TEuA1gXLqM6o4dL0cuCtumvX27j+r1U7kbU2fo20=
X-Gm-Gg: ASbGncuPK8RptafMWhKz+pHxVglq72LWGKrKHD7jzSnTR8Pf6BbBqAXlwxACEMwgmDH
 WbjkmI8tpgFqNJed9KpaHw32EB3YZtQonIEMKJqzMANcPIfbZcJRGyBuyEFtR9ZTGzRiLnIGts5
 /JvfuO8mCZMWcZSOuSssD4Ar/DW+AoXClKU7u+0cEsf0QwilZMHzmvNGEN7VsF6fnbnPVYYbNCS
 hP+dMkIGGqRHPA6YWrSVK3GSlg8aS2O22RGlvPvrMmPEE4LEXwPuQEobAih4b0ooPYKMftrWpMR
 jR+FqVJrRrYD+rmRrP3dLrAoToqYIzbZh0gBQ4FZ71T5TblYloZ+2BUXtzWl/tKWpUMueNeZ7G0
 uBZKNj1K4L3iptheZ2nNVGXi+rqve
X-Received: by 2002:a05:6000:146:b0:3b7:9c28:f84b with SMTP id
 ffacd0b85a97d-3b8d94aadb2mr7492294f8f.36.1754379225919; 
 Tue, 05 Aug 2025 00:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA39ud59vaEzO7qiXMjk1ygxYw8LuuiB4ZL+odjLIjReTDvxnaWzyODTROXYsQkUtF81oaCw==
X-Received: by 2002:a05:6000:146:b0:3b7:9c28:f84b with SMTP id
 ffacd0b85a97d-3b8d94aadb2mr7492270f8f.36.1754379225408; 
 Tue, 05 Aug 2025 00:33:45 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:32ac:980:4ddc:c784:159f?
 ([2a02:3035:6e0:32ac:980:4ddc:c784:159f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac036sm17981820f8f.15.2025.08.05.00.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 00:33:44 -0700 (PDT)
Message-ID: <60613f0f-d696-4f63-9dcf-afb709618a2e@canonical.com>
Date: Tue, 5 Aug 2025 09:33:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] efi_loader: Support loading a ramdisk with bootefi
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
References: <20250805054614.5555-1-heinrich.schuchardt@canonical.com>
 <CAC_iWj+1siVWvxnVGAEksTq2AKWtu=1KE-a+kns3iH66J4Uquw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+1siVWvxnVGAEksTq2AKWtu=1KE-a+kns3iH66J4Uquw@mail.gmail.com>
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

On 05.08.25 08:56, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> 
> On Tue, 5 Aug 2025 at 08:46, Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     From: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.org>>
> 
>     It is sometimes useful to be able to boot via EFI using a Linux initrd.
>     Add support for this.
> 
> 
> Overall I don't mind adding this to bootefi.
> 
>     Fix a 'specifiy' typo while here.
> 
>     Signed-off-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.org>>
>     Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>
>     ---
>     v2:
>              consistently refer to Linux initrd instead of RAM disk
>     ---
>       cmd/bootefi.c             | 33 +++++++++++++++++++++++++--------
>       doc/usage/cmd/bootefi.rst | 37 ++++++++++++++++++++++++++++++-------
>       2 files changed, 55 insertions(+), 15 deletions(-)
> 
>     diff --git a/cmd/bootefi.c b/cmd/bootefi.c
>     index 8e8752127ed..b8f5bb35950 100644
>     --- a/cmd/bootefi.c
>     +++ b/cmd/bootefi.c
>     @@ -136,22 +136,39 @@ static int do_bootefi(struct cmd_tbl *cmdtp,
>     int flag, int argc,
>       {
>              efi_status_t ret;
>              char *p;
>     -       void *fdt, *image_buf;
>     -       unsigned long addr, size;
>     +       void *fdt, *initrd = NULL, *image_buf;
>     +       unsigned long addr, size, rd_len = 0, fdt_addr = 0;
>              void *image_addr;
>              size_t image_size;
>     +       int fdt_arg = 2;
> 
>              if (argc < 2)
>                      return CMD_RET_USAGE;
> 
>              if (argc > 2) {
>     -               uintptr_t fdt_addr;
>     +               ulong rd_addr = 0;
>     +               char *end = strchr(argv[2], ':');
> 
>     -               fdt_addr = hextoul(argv[2], NULL);
>     +               if (end) {
>     +                       rd_addr = hextoul(argv[2], NULL);
>     +                       if (!rd_addr)
>     +                               return CMD_RET_USAGE;
>     +
>     +                       rd_len = hextoul(++end, NULL);
>     +                       initrd = map_sysmem(rd_addr, rd_len);
>     +                       ++fdt_arg;
>     +               }
>     +       }
> 
> 
> Shouldn't we keep the order unchanged? I dont know if scripts are using 
> bootefi in the wild and although they shouldn't changing the order is an 
> ABI breakage

You can still use the existing forms:

bootefi <image_addr>
bootefi <image_addr> <fdt_addr>

The patch adds two new forms:

bootefi <image_addr> <initrd_addr:size>
bootefi <image_addr> <initrd_addr:size> <fdt_addr>

Existing scripts should not be impacted.

> 
>     +
>     +       if (argc > fdt_arg + 1)
>     +               return CMD_RET_USAGE;
>     +       if (argc == fdt_arg + 1)
>     +               fdt_addr = hextoul(argv[fdt_arg], NULL);
>     +
>     +       if (fdt_addr)
>                      fdt = map_sysmem(fdt_addr, 0);
>     -       } else {
>     +       else
>                      fdt = EFI_FDT_USE_INTERNAL;
>     -       }
> 
>              if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
>                  !strcmp(argv[1], "bootmgr")) {
>     @@ -215,7 +232,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int
>     flag, int argc,
>                      }
>              }
> 
>     -       ret = efi_binary_run(image_buf, size, fdt, NULL, 0);
>     +       ret = efi_binary_run(image_buf, size, fdt, initrd, rd_len);
> 
> 
> The loadfile2 protocol that gets installed is later removed by a bootmgr 
> event in case of a failure. Is the event still called for bootefi ?

do_bootefi_exec() signals the event group 
efi_guid_event_group_return_to_efibootmgr after returning from the payload.

Best regards

Heinrich


> 
> Thanks
> /Ilias
> 
> 
>              if (ret != EFI_SUCCESS)
>                      return CMD_RET_FAILURE;
>     @@ -224,7 +241,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int
>     flag, int argc,
>       }
> 
>       U_BOOT_LONGHELP(bootefi,
>     -       "<image address>[:<image size>] [<fdt address>]\n"
>     +       "<image address>[:<size>] [<initrd address>:<size>] [<fdt
>     address>]\n"
>              "  - boot EFI payload\n"
>       #ifdef CONFIG_CMD_BOOTEFI_HELLO
>              "bootefi hello\n"
>     diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
>     index d6e4e62e383..7c5448586b7 100644
>     --- a/doc/usage/cmd/bootefi.rst
>     +++ b/doc/usage/cmd/bootefi.rst
>     @@ -12,7 +12,7 @@ Synopsis
> 
>       ::
> 
>     -    bootefi <image_addr>[:<image_size>] [<fdt_addr>]
>     +    bootefi <image_addr>[:<image_size>]
>     [<initrd_addr>:<initrd_size>] [<fdt_address>]
>           bootefi bootmgr [<fdt_addr>]
>           bootefi hello [<fdt_addr>]
>           bootefi selftest [<fdt_addr>]
>     @@ -44,6 +44,16 @@ command sequence to run a UEFI application might
>     look like
>           load mmc 0:1 $kernel_addr_r /EFI/grub/grubaa64.efi
>           bootefi $kernel_addr_r $fdt_addr_r
> 
>     +or
>     +
>     +::
>     +
>     +    setenv bootargs root=/dev/vda1
>     +    load mmc 0:1 $fdt_addr_r dtb
>     +    load mmc 0:1 $kernel_addr_r vmlinux
>     +    load mmc 0:1 $initrd_addr_r intird
>     +    bootefi $kernel_addr_r $initrd_addr_r:$filesize $fdt_addr_r
>     +
>       The last UEFI binary loaded defines the image file path in the
>     loaded image
>       protocol.
> 
>     @@ -51,21 +61,34 @@ The value of the environment variable *bootargs*
>     is converted from UTF-8 to
>       UTF-16 and passed as load options in the loaded image protocol to
>     the UEFI
>       binary.
> 
>     +.. note::
>     +
>     +    The bootefi command accepts one to three arguments.
>     +    If the second argument contains a colon ':', it is assumed to
>     specify the
>     +    initial RAM disk.
>     +
>       image_addr
>           Address of the UEFI binary.
> 
>     -fdt_addr
>     -    Address of the device-tree or '-'. If no address is specifiy, the
>     -    environment variable $fdt_addr is used as first fallback, the
>     address of
>     -    U-Boot's internal device-tree $fdtcontroladdr as second fallback.
>     -    When using ACPI no device-tree shall be specified.
>     -
>       image_size
>           Size of the UEFI binary file. This argument is only needed if
>     *image_addr*
>           does not match the address of the last loaded UEFI binary. In
>     this case
>           a memory device path will be used as image file path in the
>     loaded image
>           protocol.
> 
>     +initrd_addr
>     +    Address of the Linux initial RAM disk or '-'. If no address is
>     specified,
>     +    no RAM disk is used when booting.
>     +
>     +initrd_size
>     +    Size of the Linux initial RAM disk.
>     +
>     +fdt_addr
>     +    Address of the device-tree or '-'. If no address is specified, the
>     +    environment variable $fdt_addr is used as first fallback, the
>     address of
>     +    U-Boot's internal device-tree $fdtcontroladdr as second fallback.
>     +    When using ACPI no device-tree shall be specified.
>     +
>       Note
>           UEFI binaries that are contained in FIT images are launched
>     via the
>           *bootm* command.
>     -- 
>     2.50.0
> 

