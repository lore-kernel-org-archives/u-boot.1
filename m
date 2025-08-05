Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63894C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 06:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B4D832E6;
	Tue,  5 Aug 2025 08:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DqordP4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1F9832F0; Tue,  5 Aug 2025 08:56:49 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C988329C
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 08:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71a27d982f1so47935687b3.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 23:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754377005; x=1754981805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tkyBZhdDuQaSEiV1ePXCPlcFEn0+E1rHarSXuETcHqQ=;
 b=DqordP4qqa9mqOK0DVlPPDkuLdZtJ3pcDiIqs4Ac9SfZ0SQWwHOOmWkymC/3uT2jBG
 jt/tL4AlLfoWjFZ1jKcLQTia0BiFCiUFmjqCCbcXAGvaTRAjA3myW4FJ/hM07j4f13ZI
 mYHlXtk2rybeX/lYGusYTrzvpdVVQZjR10aSJNq6JOzAGVYXEx+sb+ONN974uNEFfkM/
 9l24E3fT0cfE2OwA1bdTEzFfrqLz/bVcbuACtB6Z1Ot0KcBm1M7NsIY7JxvrFuqCIi/c
 bt/HiEAY0/piYSpZsjt+bwgfZX6KM6wxcGDsgxoTeAyr8OcASOMUEpiSWkTOk1GRaupj
 0wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754377005; x=1754981805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tkyBZhdDuQaSEiV1ePXCPlcFEn0+E1rHarSXuETcHqQ=;
 b=Mkf9lZGemzb5LTfLFFTVxs0lQL9YGjBFMqIg0ggm+B9nbTaK8rk/fUb150VKN/gZhM
 aVLZvQS3EDQx0kPYXMeyaEBTDEupPu54UFhi47lg8usbF78EocXjgrx4wwwmlyfk6v9/
 SoWQQBEStQ0Ag40jMucL+Gd1JTWzK9Mzdwz/wYHktQyQKsJkO2XNjPqYS8X0zxgQCh6n
 xYEhtDajM3P5tVs8++eczgPpCvbufwWGyKMktgVMcbICz9uk2cBEgPdY+blZg/7EHhid
 DqSvnbfrKKz1lzCZOkIuQAgFP/6PT9O+0xB/1dy/IBQWaLPL+TpHB/1wMsRQVy2BDEj+
 G90g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB+KcsxYRcRAKBXBWLXHpkugz8hsO6t7W8J78aO+IDx1umtqG5DJs6WszCg8qr35Pzrc83oOk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywgm8sTiQsHprsjBVJjoej4BqIrXGelC2rmNH5hZQfZMnX3Ul/f
 /ybbwt4j3a+m56mAg6do1NJv9F4GNV0GDyLjaZdnlgnnVL6oI0IbgHK4V5/zvtRFl6omIaF90ok
 fWoNe4n6K9jSrdNQQtRDpr9mrqy6b49BSNqHRa60/WOLFhcwy6uJP
X-Gm-Gg: ASbGncsRSTIHLq7cgbAvDcjMpCtiiMcviC/vIPjkV7zurYTQeP1UD3uGheMDNrLGKV1
 pyGi3dUDXYoHN1uDNKjdRerBX7y1Rpz4TVgSZaGPADWO73Nfrnnx1yfrmwMOsOTwIBGCHnTEwwg
 LeFgEwKit+BKQwJjtf6HVbxHnZzpURSwH58N2plxV/HExdX/gDh/JxjVTI6U60+ZJxs9vqtR9bA
 X5MUs3DHULMGOgvbss=
X-Google-Smtp-Source: AGHT+IFIeJaRMd/mEAoj+xMtnQAg2x3JTqi9ilm520+tpw132WQNdR6aEYbS/XBGJV8/0BOWAF/WHMWpN6tbfDAqIO8=
X-Received: by 2002:a05:690c:6610:b0:71a:234c:aa86 with SMTP id
 00721157ae682-71b7f5bc0c3mr156160077b3.8.1754377004412; Mon, 04 Aug 2025
 23:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250805054614.5555-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250805054614.5555-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Aug 2025 09:56:08 +0300
X-Gm-Features: Ac12FXxj8AadZlQ3aqe0VRDuLcBds6aYLweMGHsG6sRv4PNuDQ4gTj1nsptN3dM
Message-ID: <CAC_iWj+1siVWvxnVGAEksTq2AKWtu=1KE-a+kns3iH66J4Uquw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: Support loading a ramdisk with bootefi
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Adriano Cordova <adrianox@gmail.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
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

Hi Heinrich,


On Tue, 5 Aug 2025 at 08:46, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> From: Simon Glass <sjg@chromium.org>
>
> It is sometimes useful to be able to boot via EFI using a Linux initrd.
> Add support for this.
>
>
Overall I don't mind adding this to bootefi.

Fix a 'specifiy' typo while here.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         consistently refer to Linux initrd instead of RAM disk
> ---
>  cmd/bootefi.c             | 33 +++++++++++++++++++++++++--------
>  doc/usage/cmd/bootefi.rst | 37 ++++++++++++++++++++++++++++++-------
>  2 files changed, 55 insertions(+), 15 deletions(-)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 8e8752127ed..b8f5bb35950 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -136,22 +136,39 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int
> flag, int argc,
>  {
>         efi_status_t ret;
>         char *p;
> -       void *fdt, *image_buf;
> -       unsigned long addr, size;
> +       void *fdt, *initrd = NULL, *image_buf;
> +       unsigned long addr, size, rd_len = 0, fdt_addr = 0;
>         void *image_addr;
>         size_t image_size;
> +       int fdt_arg = 2;
>
>         if (argc < 2)
>                 return CMD_RET_USAGE;
>
>         if (argc > 2) {
> -               uintptr_t fdt_addr;
> +               ulong rd_addr = 0;
> +               char *end = strchr(argv[2], ':');
>
> -               fdt_addr = hextoul(argv[2], NULL);
> +               if (end) {
> +                       rd_addr = hextoul(argv[2], NULL);
> +                       if (!rd_addr)
> +                               return CMD_RET_USAGE;
> +
> +                       rd_len = hextoul(++end, NULL);
> +                       initrd = map_sysmem(rd_addr, rd_len);
> +                       ++fdt_arg;
> +               }
> +       }
>

Shouldn't we keep the order unchanged? I dont know if scripts are using
bootefi in the wild and although they shouldn't changing the order is an
ABI breakage

+
> +       if (argc > fdt_arg + 1)
> +               return CMD_RET_USAGE;
> +       if (argc == fdt_arg + 1)
> +               fdt_addr = hextoul(argv[fdt_arg], NULL);
> +
> +       if (fdt_addr)
>                 fdt = map_sysmem(fdt_addr, 0);
> -       } else {
> +       else
>                 fdt = EFI_FDT_USE_INTERNAL;
> -       }
>
>         if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) &&
>             !strcmp(argv[1], "bootmgr")) {
> @@ -215,7 +232,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag,
> int argc,
>                 }
>         }
>
> -       ret = efi_binary_run(image_buf, size, fdt, NULL, 0);
> +       ret = efi_binary_run(image_buf, size, fdt, initrd, rd_len);
>

The loadfile2 protocol that gets installed is later removed by a bootmgr
event in case of a failure. Is the event still called for bootefi ?

Thanks
/Ilias

>
>         if (ret != EFI_SUCCESS)
>                 return CMD_RET_FAILURE;
> @@ -224,7 +241,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag,
> int argc,
>  }
>
>  U_BOOT_LONGHELP(bootefi,
> -       "<image address>[:<image size>] [<fdt address>]\n"
> +       "<image address>[:<size>] [<initrd address>:<size>] [<fdt
> address>]\n"
>         "  - boot EFI payload\n"
>  #ifdef CONFIG_CMD_BOOTEFI_HELLO
>         "bootefi hello\n"
> diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
> index d6e4e62e383..7c5448586b7 100644
> --- a/doc/usage/cmd/bootefi.rst
> +++ b/doc/usage/cmd/bootefi.rst
> @@ -12,7 +12,7 @@ Synopsis
>
>  ::
>
> -    bootefi <image_addr>[:<image_size>] [<fdt_addr>]
> +    bootefi <image_addr>[:<image_size>] [<initrd_addr>:<initrd_size>]
> [<fdt_address>]
>      bootefi bootmgr [<fdt_addr>]
>      bootefi hello [<fdt_addr>]
>      bootefi selftest [<fdt_addr>]
> @@ -44,6 +44,16 @@ command sequence to run a UEFI application might look
> like
>      load mmc 0:1 $kernel_addr_r /EFI/grub/grubaa64.efi
>      bootefi $kernel_addr_r $fdt_addr_r
>
> +or
> +
> +::
> +
> +    setenv bootargs root=/dev/vda1
> +    load mmc 0:1 $fdt_addr_r dtb
> +    load mmc 0:1 $kernel_addr_r vmlinux
> +    load mmc 0:1 $initrd_addr_r intird
> +    bootefi $kernel_addr_r $initrd_addr_r:$filesize $fdt_addr_r
> +
>  The last UEFI binary loaded defines the image file path in the loaded
> image
>  protocol.
>
> @@ -51,21 +61,34 @@ The value of the environment variable *bootargs* is
> converted from UTF-8 to
>  UTF-16 and passed as load options in the loaded image protocol to the UEFI
>  binary.
>
> +.. note::
> +
> +    The bootefi command accepts one to three arguments.
> +    If the second argument contains a colon ':', it is assumed to specify
> the
> +    initial RAM disk.
> +
>  image_addr
>      Address of the UEFI binary.
>
> -fdt_addr
> -    Address of the device-tree or '-'. If no address is specifiy, the
> -    environment variable $fdt_addr is used as first fallback, the address
> of
> -    U-Boot's internal device-tree $fdtcontroladdr as second fallback.
> -    When using ACPI no device-tree shall be specified.
> -
>  image_size
>      Size of the UEFI binary file. This argument is only needed if
> *image_addr*
>      does not match the address of the last loaded UEFI binary. In this
> case
>      a memory device path will be used as image file path in the loaded
> image
>      protocol.
>
> +initrd_addr
> +    Address of the Linux initial RAM disk or '-'. If no address is
> specified,
> +    no RAM disk is used when booting.
> +
> +initrd_size
> +    Size of the Linux initial RAM disk.
> +
> +fdt_addr
> +    Address of the device-tree or '-'. If no address is specified, the
> +    environment variable $fdt_addr is used as first fallback, the address
> of
> +    U-Boot's internal device-tree $fdtcontroladdr as second fallback.
> +    When using ACPI no device-tree shall be specified.
> +
>  Note
>      UEFI binaries that are contained in FIT images are launched via the
>      *bootm* command.
> --
> 2.50.0
>
>
