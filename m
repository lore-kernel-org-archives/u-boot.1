Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18986CDB46B
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 08:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D2E849BA;
	Mon, 22 Jun 2026 10:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C2z2vFlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC6F849C5; Mon, 22 Jun 2026 10:09:39 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90DC284866
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 10:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66077e90382so3969868d50.3
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 01:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782115775; cv=none;
 d=google.com; s=arc-20240605;
 b=jFGqZUOj62scQug5Aam/KkLcTkZkMs4WwUfVy0+DO9U9O3F/eo4nVBCIUxGwQRZCXq
 CE9+RnrkRg3PBqCkXLkfi4yBfIt/DrVEYo5+Pk8DVoZaCZTgFBCqnUg3KkK0wvSoK3Nf
 6B23hfKNIBp1rFNmYgCyn1wd+5l+Dh37mBrjr/KNYq6/Q2pXmXWurcOY0e3RqVCPr5S4
 q2gB5u3TuzbkGuW1nwkJ92DjFYmSaMz/9GYrgxrz7w8qv6j2OFzbXmXpKoHP7q8/wrYO
 zlfi8rIICEzMa2wiN+TAL4BKfUlOk2VmcCDfvPQ/j3vrIUhJ2silLZ3lTzN3VmBbQ06C
 khYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5qXKVBIk9FcLaz8WNXg9uJojMoAFuHN+AB2BymoeCFw=;
 fh=jpXojIVB5jpAf1gT5X8czT3TCERVFpoXlilmx21mANc=;
 b=aAiGxvHHYzZ8vH/A+MWQZM2FKV2k4rLBd1LT1km2pqADiSEpr86pX2hLYuyOH35zkr
 LC+2gRUbqafhgHwMPbebpcmMQLhGS42DPYmrGNKynegFeQS5DAPE9vw9grsfCkv5/RCo
 z2azBIPX8x12vy/ebLX/4bKFaha//b36j9g8ZcZjMq83ZghbM4Zh0lZYGR/W2lIhikgb
 YOp6Hn9N9ttGOT1iZpe3i3ZAzYk5p21I6dh4g/bUhIillG5zUksBPodfmyUSYm1lvi45
 1K3gV7XJjJYjGhXp6ozYQUYGl2lqj8biSqRaaZXVwUCAcCE4P4VXCNWuYjmAj1Mq2097
 fI0w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782115775; x=1782720575; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5qXKVBIk9FcLaz8WNXg9uJojMoAFuHN+AB2BymoeCFw=;
 b=C2z2vFlNu27pgm4UH+RfZlFUV3iohdwr3jT7TA3XGwr7AOXT+f1XcuJhyL/WIvlW6g
 R22CmRhIK4ewgZ10b2KF7FkbxGs5WYwFCaUH5A8EfQRqL8l8b7r11LU+wukp3SA+RxU0
 xxu7+c3y4DWKi/GeqK4ABzaL/8fMU+O6IrarGRNxYPLi+YwHv8wvto7xCupiW2xqQ9bl
 ISie8J37cN5Ti7Hog/6Z5Rfpsc38B9yRvQri5EUk8WVy2lrlgYNt96NWwAbPALI4XXh/
 DwjHkt7NLXenwljnUYMas0mT9ZpLWCP0UVf+w7enqNMOHEzZ6ll9GHPMqOG2H/Htx7iH
 jx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115775; x=1782720575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qXKVBIk9FcLaz8WNXg9uJojMoAFuHN+AB2BymoeCFw=;
 b=rBRqfNFd1G+OarMzsDS8C5tDxuphxjlcLywSIswb5hMvDfNP6wpvNaa6kG0yoJwRWm
 D/nlzszoHRQpUbqD3CbU8eH/CF+M0HB97x8BDyHClf3sFe9Z7D5TC8lWhllq6jTB20ry
 z9kNl0vlfBjOxiCKTUo6Rqzf4UYB9h3YLAMxb5Po9718qz4nwfkNEncRMFBTX4QlaNdd
 B+EqYVdYyCPaRF8l8pigTo2bR55zIQ7mqMXoVyMaY6odGbAIqgMWMAtf/MRoVTfss2gU
 WnsJ5tKW/Aq1GNicc/LD4v9vUDuMBtcmWNKsBaD9oBDoLM19LXYO2J5quH1aGIVFisVp
 zsFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMOxByCzJLzcT5FQCNK1qD60sMZ/lMCs4/fgx6CtStnf0mBHs6JjsaIB/we9wNBfJ+eG/lCxY=@lists.denx.de
X-Gm-Message-State: AOJu0YyeJ792hnNFP0dJm4cR/Kkuhph8V9OYZFRMMEHTOIKOSAIo7zYj
 461wyCjE53Doy/+czbrDidx9qeecPqFnj4tqv7k8ImOsyLpEl0KsYqY7Dk2e4MzoT/yabk4nPmx
 xY6hr6NOLfA0zVNKrDA8tm6GWmrPp68Jq7IZiti9G+Q==
X-Gm-Gg: AfdE7cmiuBRtv6lTPiGR/EYdIFmiI6Xw+Ic8liEqGjnBSnmgMS9sKbvDHM+LY3qINx8
 Ad2cRDg8veCh7IuZlNmCf+SAlozeGNgh/fvkgPYFV6tx19cDYZZJDWaatFaApZ2VG7f2d3Zmyx3
 bQzUfTldsaVDpPO6WDJilQ3FDj/fd6aH6064R0rDh+mgRTj5EhOMn0R8xQZyCjwDhjppMnfvAaM
 sZDAlEpqAKUd5UaG6LQ37zk/jcu6O6lRRQvHK66yQjDoHPvoodvEpLW/D6Qh5Uc1ClDMWp19UWI
 3SPe9YU4f0A6rVGfqN1zpm06dOICxXhAgleJnN6mFmlqyokx19HYTf1BvecCLLjbbh/KsDKrKq3
 QxKsa86TL7kiHnGHnIFzlyWS/I23pW09KcAnqZojOXuNqg+oR1pxqt9lWiVkmhjC+dS9QI7qSfh
 cpPX36Db3R3irf9ntSI2vBCnwnqXhIWh9kXi2B9gyO+eA9RwKZ447KuqSYsBJmbHIIJISOITm6e
 GYKmC11OkC/WOpOmKIFraE7wzzwSNjw7Xf+HdL9dRd9ZptlrSjYkauEBAkyrv4a8TyV0SqX8kRG
 Quqq20xUlRZfGh2FBIDIc4+glTUeYhpgbsph6F43c68hvE0/MJhTT/RcFnPTctVMM7SPB3k=
X-Received: by 2002:a05:690e:1241:b0:663:10a6:9a67 with SMTP id
 956f58d0204a3-66312d69a72mr8032323d50.3.1782115775162; Mon, 22 Jun 2026
 01:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-9-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Jun 2026 11:08:58 +0300
X-Gm-Features: AVVi8CcARz7vieZ5tjWiIe-jy_HuGx5Cq4WNXEgEtDNMO-vq_yGerQABLwxGMTI
Message-ID: <CAC_iWjK_OLhXc7Z93_EW2ECWTEqSUnoqLE60=aa7FEv5vrqTVQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] efi_loader: move file-system helpers to
 efi_app_common
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich

On Sun, 21 Jun 2026 at 11:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Move the shared file-system utilities to efi_app_common:
>
> * open_file_system() - open the simple file system protocol, first
>   trying the partition the image was loaded from, then the UEFI system
>   partition.
> * get_config_table()  - look up an EFI configuration table by GUID.
> * save_file()         - write a buffer to a named file, prompting for
>   confirmation if the file already exists.
>
> get_config_table() supersedes the private get_dtb() in dtbdump and
> get_dbg_info() in dbginfodump; both call-sites are updated to use it.
>
> dtbdump's do_save() and initrddump's do_save() are simplified to use
> the common save_file(), eliminating duplicate file-open/write/close
> sequences.
>
> smbiosdump's private get_config_table(), open_file_system() and
> save_file() are removed; the common versions take their place.
>
> GUID declarations that are no longer referenced after these removals
> are dropped from each app's file-scope variables.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Don't we need the function description for the documentation now that
it's in a common file?

In any case
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> v2:
>         new patch
> ---
>  lib/efi_loader/dbginfodump.c    |  22 +-----
>  lib/efi_loader/dtbdump.c        | 120 +-----------------------------
>  lib/efi_loader/efi_app_common.c | 105 +++++++++++++++++++++++++++
>  lib/efi_loader/efi_app_common.h |  27 +++++++
>  lib/efi_loader/initrddump.c     |  69 +-----------------
>  lib/efi_loader/smbiosdump.c     | 125 --------------------------------
>  6 files changed, 141 insertions(+), 327 deletions(-)
>
> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> index 4808fe254fe..b54c3830a66 100644
> --- a/lib/efi_loader/dbginfodump.c
> +++ b/lib/efi_loader/dbginfodump.c
> @@ -91,26 +91,6 @@ static void do_help(void)
>         error(u"exit       - exit the shell\r\n");
>  }
>
> -/**
> - * get_dbg_info_table() - get debug info table
> - *
> - * Return:     debug info table or NULL
> - */
> -static void *get_dbg_info(void)
> -{
> -       void *dbg = NULL;
> -       efi_uintn_t i;
> -
> -       for (i = 0; i < systable->nr_tables; ++i) {
> -               if (!memcmp(&systable->tables[i].guid, &dbg_info_guid,
> -                           sizeof(efi_guid_t))) {
> -                       dbg = systable->tables[i].table;
> -                       break;
> -               }
> -       }
> -       return dbg;
> -}
> -
>  /**
>   * print_info() - print loaded image protocol
>   */
> @@ -144,7 +124,7 @@ static efi_status_t do_dump(void)
>         struct dbg_info_header *dbg;
>         u32 count;
>
> -       dbg = get_dbg_info();
> +       dbg = get_config_table(&dbg_info_guid);
>         if (!dbg) {
>                 error(u"Debug info table not found\r\n");
>                 return EFI_NOT_FOUND;
> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
> index 559c64be7f7..0d56a41ecf6 100644
> --- a/lib/efi_loader/dtbdump.c
> +++ b/lib/efi_loader/dtbdump.c
> @@ -7,7 +7,6 @@
>   */
>
>  #include <efi_dt_fixup.h>
> -#include <part.h>
>  #include <linux/libfdt.h>
>  #include "efi_app_common.h"
>
> @@ -18,14 +17,10 @@
>
>  static struct efi_boot_services *bs;
>  static const efi_guid_t fdt_guid = EFI_FDT_GUID;
> -static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
> -static const efi_guid_t guid_simple_file_system_protocol =
> -                                       EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
>  static efi_handle_t handle;
>  static struct efi_system_table *systable;
>  static const efi_guid_t efi_dt_fixup_protocol_guid = EFI_DT_FIXUP_PROTOCOL_GUID;
>  static const efi_guid_t efi_file_info_guid = EFI_FILE_INFO_GUID;
> -static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
>
>  /**
>   * print_char() - print character
> @@ -66,27 +61,6 @@ static u32 f2h(fdt32_t val)
>         return *(u32 *)buf;
>  }
>
> -/**
> - * get_dtb() - get device tree
> - *
> - * @systable:  system table
> - * Return:     device tree or NULL
> - */
> -static void *get_dtb(struct efi_system_table *systable)
> -{
> -       void *dtb = NULL;
> -       efi_uintn_t i;
> -
> -       for (i = 0; i < systable->nr_tables; ++i) {
> -               if (!memcmp(&systable->tables[i].guid, &fdt_guid,
> -                           sizeof(efi_guid_t))) {
> -                       dtb = systable->tables[i].table;
> -                       break;
> -               }
> -       }
> -       return dtb;
> -}
> -
>  /**
>   * do_help() - print help
>   */
> @@ -98,52 +72,6 @@ static void do_help(void)
>         error(u"exit       - exit the shell\r\n");
>  }
>
> -/**
> - * open_file_system() - open simple file system protocol
> - *
> - * file_system:        interface of the simple file system protocol
> - * Return:     status code
> - */
> -static efi_status_t
> -open_file_system(struct efi_simple_file_system_protocol **file_system)
> -{
> -       struct efi_loaded_image *loaded_image;
> -       efi_status_t ret;
> -       efi_handle_t *handle_buffer = NULL;
> -       efi_uintn_t count;
> -
> -       ret = bs->open_protocol(handle, &loaded_image_guid,
> -                               (void **)&loaded_image, NULL, NULL,
> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -       if (ret != EFI_SUCCESS) {
> -               error(u"Loaded image protocol not found\r\n");
> -               return ret;
> -       }
> -
> -       /* Open the simple file system protocol on the same partition */
> -       ret = bs->open_protocol(loaded_image->device_handle,
> -                               &guid_simple_file_system_protocol,
> -                               (void **)file_system, NULL, NULL,
> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -       if (ret == EFI_SUCCESS)
> -               return ret;
> -
> -       /* Open the simple file system protocol on the UEFI system partition */
> -       ret = bs->locate_handle_buffer(BY_PROTOCOL, &efi_system_partition_guid,
> -                                      NULL, &count, &handle_buffer);
> -       if (ret == EFI_SUCCESS && handle_buffer)
> -               ret = bs->open_protocol(handle_buffer[0],
> -                                       &guid_simple_file_system_protocol,
> -                                       (void **)file_system, NULL, NULL,
> -                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -       if (ret != EFI_SUCCESS)
> -               error(u"Failed to open simple file system protocol\r\n");
> -       if (handle_buffer)
> -               bs->free_pool(handle_buffer);
> -
> -       return ret;
> -}
> -
>  /**
>   * do_load() - load and install device-tree
>   *
> @@ -289,13 +217,11 @@ out:
>   */
>  static efi_status_t do_save(u16 *filename)
>  {
> -       struct efi_simple_file_system_protocol *file_system;
> -       efi_uintn_t dtb_size;
> -       struct efi_file_handle *root, *file;
>         struct fdt_header *dtb;
> +       efi_uintn_t dtb_size;
>         efi_uintn_t ret;
>
> -       dtb = get_dtb(systable);
> +       dtb = get_config_table(&fdt_guid);
>         if (!dtb) {
>                 error(u"DTB not found\r\n");
>                 return EFI_NOT_FOUND;
> @@ -308,45 +234,7 @@ static efi_status_t do_save(u16 *filename)
>
>         filename = skip_whitespace(filename);
>
> -       ret = open_file_system(&file_system);
> -       if (ret != EFI_SUCCESS)
> -               return ret;
> -
> -       /* Open volume */
> -       ret = file_system->open_volume(file_system, &root);
> -       if (ret != EFI_SUCCESS) {
> -               error(u"Failed to open volume\r\n");
> -               return ret;
> -       }
> -       /* Check if file already exists */
> -       ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
> -       if (ret == EFI_SUCCESS) {
> -               file->close(file);
> -               print(u"Overwrite existing file (y/n)? ");
> -               ret = efi_input_yn();
> -               print(u"\r\n");
> -               if (ret != EFI_SUCCESS) {
> -                       root->close(root);
> -                       error(u"Aborted by user\r\n");
> -                       return ret;
> -               }
> -       }
> -
> -       /* Create file */
> -       ret = root->open(root, &file, filename,
> -                        EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
> -                        EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
> -       if (ret == EFI_SUCCESS) {
> -               /* Write file */
> -               ret = file->write(file, &dtb_size, dtb);
> -               if (ret != EFI_SUCCESS)
> -                       error(u"Failed to write file\r\n");
> -               file->close(file);
> -       } else {
> -               error(u"Failed to open file\r\n");
> -       }
> -       root->close(root);
> -
> +       ret = save_file(filename, dtb, dtb_size);
>         if (ret == EFI_SUCCESS) {
>                 print(filename);
>                 print(u" written\r\n");
> @@ -479,7 +367,7 @@ static efi_status_t do_dump(void)
>         const char *strings;
>         u32 level = 0;
>
> -       fdt = get_dtb(systable);
> +       fdt = get_config_table(&fdt_guid);
>         if (!fdt) {
>                 error(u"DTB not found\r\n");
>                 return EFI_NOT_FOUND;
> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
> index 6bd52e08d28..af9799557fc 100644
> --- a/lib/efi_loader/efi_app_common.c
> +++ b/lib/efi_loader/efi_app_common.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <efi_api.h>
> +#include <part.h>
>  #include "efi_app_common.h"
>
>  static efi_handle_t app_handle;
> @@ -15,6 +16,9 @@ struct efi_boot_services *bs;
>  static bool nocolor;
>  static struct efi_system_table *systable;
>  static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
> +static const efi_guid_t guid_simple_file_system_protocol =
> +       EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
> +static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
>
>  static u16 *get_load_options(void)
>  {
> @@ -199,3 +203,104 @@ efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
>                 }
>         }
>  }
> +
> +void *get_config_table(const efi_guid_t *guid)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < systable->nr_tables; ++i) {
> +               if (!memcmp(guid, &systable->tables[i].guid, 16))
> +                       return systable->tables[i].table;
> +       }
> +
> +       return NULL;
> +}
> +
> +efi_status_t
> +open_file_system(struct efi_simple_file_system_protocol **file_system)
> +{
> +       struct efi_loaded_image *loaded_image;
> +       efi_status_t ret;
> +       efi_handle_t *handle_buffer = NULL;
> +       efi_uintn_t count;
> +
> +       ret = bs->open_protocol(app_handle, &loaded_image_guid,
> +                               (void **)&loaded_image, NULL, NULL,
> +                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +       if (ret != EFI_SUCCESS) {
> +               error(u"Loaded image protocol not found\r\n");
> +               return ret;
> +       }
> +
> +       /* Open the simple file system protocol on the same partition */
> +       ret = bs->open_protocol(loaded_image->device_handle,
> +                               &guid_simple_file_system_protocol,
> +                               (void **)file_system, NULL, NULL,
> +                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +       if (ret == EFI_SUCCESS)
> +               return ret;
> +
> +       /* Open the simple file system protocol on the UEFI system partition */
> +       ret = bs->locate_handle_buffer(BY_PROTOCOL, &efi_system_partition_guid,
> +                                      NULL, &count, &handle_buffer);
> +       if (ret == EFI_SUCCESS && handle_buffer)
> +               ret = bs->open_protocol(handle_buffer[0],
> +                                       &guid_simple_file_system_protocol,
> +                                       (void **)file_system, NULL, NULL,
> +                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +       if (ret != EFI_SUCCESS)
> +               error(u"Failed to open simple file system protocol\r\n");
> +       if (handle_buffer)
> +               bs->free_pool(handle_buffer);
> +
> +       return ret;
> +}
> +
> +efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
> +{
> +       efi_uintn_t ret;
> +       struct efi_simple_file_system_protocol *file_system;
> +       struct efi_file_handle *root, *file;
> +
> +       ret = open_file_system(&file_system);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       /* Open volume */
> +       ret = file_system->open_volume(file_system, &root);
> +       if (ret != EFI_SUCCESS) {
> +               error(u"Failed to open volume\r\n");
> +               return ret;
> +       }
> +       /* Check if file already exists */
> +       ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
> +       if (ret == EFI_SUCCESS) {
> +               file->close(file);
> +               print(u"Overwrite existing file (y/n)? ");
> +               ret = efi_input_yn();
> +               print(u"\r\n");
> +               if (ret != EFI_SUCCESS) {
> +                       root->close(root);
> +                       error(u"Aborted by user\r\n");
> +                       return ret;
> +               }
> +       }
> +
> +       /* Create file */
> +       ret = root->open(root, &file, filename,
> +                        EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
> +                                EFI_FILE_MODE_CREATE,
> +                        EFI_FILE_ARCHIVE);
> +       if (ret == EFI_SUCCESS) {
> +               /* Write file */
> +               ret = file->write(file, &size, buf);
> +               if (ret != EFI_SUCCESS)
> +                       error(u"Failed to write file\r\n");
> +               file->close(file);
> +       } else {
> +               error(u"Failed to open file\r\n");
> +       }
> +       root->close(root);
> +
> +       return ret;
> +}
> diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
> index ff37f3413eb..77fe100afd9 100644
> --- a/lib/efi_loader/efi_app_common.h
> +++ b/lib/efi_loader/efi_app_common.h
> @@ -101,4 +101,31 @@ efi_status_t efi_input_yn(void);
>   */
>  efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size);
>
> +/**
> + * get_config_table() - get configuration table
> + *
> + * @guid:       GUID of the configuration table
> + * Return:      pointer to configuration table or NULL
> + */
> +void *get_config_table(const efi_guid_t *guid);
> +
> +/**
> + * open_file_system() - open simple file system protocol
> + *
> + * @file_system: interface of the simple file system protocol
> + * Return:       status code
> + */
> +efi_status_t
> +open_file_system(struct efi_simple_file_system_protocol **file_system);
> +
> +/**
> + * save_file() - save buffer to a file on the EFI system partition
> + *
> + * @filename:   file name
> + * @buf:        buffer to write
> + * @size:       size of the buffer
> + * Return:      status code
> + */
> +efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size);
> +
>  #endif /* _EFI_APP_COMMON_H */
> diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
> index 0a025c1a841..c3e6f2b683f 100644
> --- a/lib/efi_loader/initrddump.c
> +++ b/lib/efi_loader/initrddump.c
> @@ -19,9 +19,6 @@
>
>  static struct efi_system_table *systable;
>  static struct efi_boot_services *bs;
> -static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
> -static const efi_guid_t guid_simple_file_system_protocol =
> -                                       EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
>  static const efi_guid_t load_file2_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
>  static efi_handle_t handle;
>
> @@ -143,9 +140,6 @@ static efi_status_t do_load(void)
>   */
>  static efi_status_t do_save(u16 *filename)
>  {
> -       struct efi_loaded_image *loaded_image;
> -       struct efi_simple_file_system_protocol *file_system;
> -       struct efi_file_handle *root, *file;
>         void *initrd;
>         efi_uintn_t initrd_size;
>         efi_uintn_t ret;
> @@ -156,68 +150,13 @@ static efi_status_t do_save(u16 *filename)
>
>         filename = skip_whitespace(filename);
>
> -       ret = bs->open_protocol(handle, &loaded_image_guid,
> -                               (void **)&loaded_image, NULL, NULL,
> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -       if (ret != EFI_SUCCESS) {
> -               error(u"Loaded image protocol not found\r\n");
> -               goto out;
> -       }
> -
> -       /* Open the simple file system protocol */
> -       ret = bs->open_protocol(loaded_image->device_handle,
> -                               &guid_simple_file_system_protocol,
> -                               (void **)&file_system, NULL, NULL,
> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -       if (ret != EFI_SUCCESS) {
> -               error(u"Failed to open simple file system protocol\r\n");
> -               goto out;
> -       }
> -
> -       /* Open volume */
> -       ret = file_system->open_volume(file_system, &root);
> -       if (ret != EFI_SUCCESS) {
> -               error(u"Failed to open volume\r\n");
> -               goto out;
> -       }
> -       /* Check if file already exists */
> -       ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
> -       if (ret == EFI_SUCCESS) {
> -               file->close(file);
> -               efi_drain_input();
> -               print(u"Overwrite existing file (y/n)? ");
> -               ret = efi_input_yn();
> -               print(u"\r\n");
> -               if (ret != EFI_SUCCESS) {
> -                       root->close(root);
> -                       error(u"Aborted by user\r\n");
> -                       goto out;
> -               }
> -       }
> -
> -       /* Create file */
> -       ret = root->open(root, &file, filename,
> -                        EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
> -                        EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
> +       ret = save_file(filename, initrd, initrd_size);
>         if (ret == EFI_SUCCESS) {
> -               /* Write file */
> -               ret = file->write(file, &initrd_size, initrd);
> -               if (ret != EFI_SUCCESS) {
> -                       error(u"Failed to write file\r\n");
> -               } else {
> -                       print(filename);
> -                       print(u" written\r\n");
> -               }
> -               file->close(file);
> -       } else {
> -               error(u"Failed to open file\r\n");
> +               print(filename);
> +               print(u" written\r\n");
>         }
> -       root->close(root);
>
> -out:
> -       if (initrd)
> -               bs->free_pages((uintptr_t)initrd,
> -                              efi_size_in_pages(initrd_size));
> +       bs->free_pages((uintptr_t)initrd, efi_size_in_pages(initrd_size));
>         return ret;
>  }
>
> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
> index 351e103fb97..8aa6f594a07 100644
> --- a/lib/efi_loader/smbiosdump.c
> +++ b/lib/efi_loader/smbiosdump.c
> @@ -8,7 +8,6 @@
>   * clearing of the screen.
>   */
>
> -#include <part.h>
>  #include <smbios.h>
>  #include <string.h>
>  #include "efi_app_common.h"
> @@ -20,56 +19,6 @@ static efi_handle_t handle;
>  static struct efi_system_table *systable;
>  static const efi_guid_t smbios_guid = SMBIOS_TABLE_GUID;
>  static const efi_guid_t smbios3_guid = SMBIOS3_TABLE_GUID;
> -static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
> -static const efi_guid_t guid_simple_file_system_protocol =
> -                                       EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
> -static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
> -
> -/**
> - * open_file_system() - open simple file system protocol
> - *
> - * file_system:        interface of the simple file system protocol
> - * Return:     status code
> - */
> -static efi_status_t
> -open_file_system(struct efi_simple_file_system_protocol **file_system)
> -{
> -       struct efi_loaded_image *loaded_image;
> -       efi_status_t ret;
> -       efi_handle_t *handle_buffer = NULL;
> -       efi_uintn_t count;
> -
> -       ret = bs->open_protocol(handle, &loaded_image_guid,
> -                               (void **)&loaded_image, NULL, NULL,
> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -       if (ret != EFI_SUCCESS) {
> -               error(u"Loaded image protocol not found\r\n");
> -               return ret;
> -       }
> -
> -       /* Open the simple file system protocol on the same partition */
> -       ret = bs->open_protocol(loaded_image->device_handle,
> -                               &guid_simple_file_system_protocol,
> -                               (void **)file_system, NULL, NULL,
> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -       if (ret == EFI_SUCCESS)
> -               return ret;
> -
> -       /* Open the simple file system protocol on the UEFI system partition */
> -       ret = bs->locate_handle_buffer(BY_PROTOCOL, &efi_system_partition_guid,
> -                                      NULL, &count, &handle_buffer);
> -       if (ret == EFI_SUCCESS && handle_buffer)
> -               ret = bs->open_protocol(handle_buffer[0],
> -                                       &guid_simple_file_system_protocol,
> -                                       (void **)file_system, NULL, NULL,
> -                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -       if (ret != EFI_SUCCESS)
> -               error(u"Failed to open simple file system protocol\r\n");
> -       if (handle_buffer)
> -               bs->free_pool(handle_buffer);
> -
> -       return ret;
> -}
>
>  /**
>   * do_help() - print help
> @@ -81,24 +30,6 @@ static void do_help(void)
>         error(u"exit        - exit the shell\r\n");
>  }
>
> -/**
> - * get_config_table() - get configuration table
> - *
> - * @guid:      GUID of the configuration table
> - * Return:     pointer to configuration table or NULL
> - */
> -static void *get_config_table(const efi_guid_t *guid)
> -{
> -       size_t i;
> -
> -       for (i = 0; i < systable->nr_tables; ++i) {
> -               if (!memcmp(guid, &systable->tables[i].guid, 16))
> -                       return systable->tables[i].table;
> -       }
> -
> -       return NULL;
> -}
> -
>  /**
>   * checksum() - calculate checksum
>   *
> @@ -211,62 +142,6 @@ static efi_status_t do_check(void)
>         return EFI_SUCCESS;
>  }
>
> -/**
> - * save_file() - save file to EFI system partition
> - *
> - * @filename:  file name
> - * @buf:       buffer to write
> - * @size:      size of the buffer
> - */
> -static efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
> -{
> -       efi_uintn_t ret;
> -       struct efi_simple_file_system_protocol *file_system;
> -       struct efi_file_handle *root, *file;
> -
> -       ret = open_file_system(&file_system);
> -       if (ret != EFI_SUCCESS)
> -               return ret;
> -
> -       /* Open volume */
> -       ret = file_system->open_volume(file_system, &root);
> -       if (ret != EFI_SUCCESS) {
> -               error(u"Failed to open volume\r\n");
> -               return ret;
> -       }
> -       /* Check if file already exists */
> -       ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
> -       if (ret == EFI_SUCCESS) {
> -               file->close(file);
> -               print(u"Overwrite existing file (y/n)? ");
> -               ret = efi_input_yn();
> -               print(u"\r\n");
> -               if (ret != EFI_SUCCESS) {
> -                       root->close(root);
> -                       error(u"Aborted by user\r\n");
> -                       bs->free_pool(buf);
> -                       return ret;
> -               }
> -       }
> -
> -       /* Create file */
> -       ret = root->open(root, &file, filename,
> -                        EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
> -                        EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
> -       if (ret == EFI_SUCCESS) {
> -               /* Write file */
> -               ret = file->write(file, &size, buf);
> -               if (ret != EFI_SUCCESS)
> -                       error(u"Failed to write file\r\n");
> -               file->close(file);
> -       } else {
> -               error(u"Failed to open file\r\n");
> -       }
> -       root->close(root);
> -
> -       return ret;
> -}
> -
>  /**
>   * do_save() - save SMBIOS table
>   *
> --
> 2.53.0
>
