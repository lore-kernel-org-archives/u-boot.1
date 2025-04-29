Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26659C369CB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 08:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EFCA82075;
	Tue, 29 Apr 2025 10:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vNCx2b8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB09820EB; Tue, 29 Apr 2025 10:05:15 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D22F80BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 10:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-703cd93820fso49155237b3.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 01:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745913912; x=1746518712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5n3g9/gXeLpoCZdUVd6I7IpvXgfHQCsS2CixWa42Ua8=;
 b=vNCx2b8FdgahkJi7PtJk3mq+NAFpAJK3tQDW57H37HtaJzXHhQUqadlxfYMpZS5hUK
 ch5cjnsguScf9m6mALGQo0g3WVeBtsbLLFcWtSIFJfZv5o7UBBIf+yd9Q1BI/3iyqasI
 KOdysmcwSEkOtsYq3A8+6RuEPUJwywodY2C2jy4UxlzkqXJlb4zf5OTyw6tQEGJ+/+OL
 KSD2UkI7nR1SLqDBzzEZva4MiADjc8VBhgSpfOZhQm406TarKF4aWTxJG5CsXzIq4uLI
 4qzGAs9GLHm+iZnzU0Q17qugi1Hhqe6traXs/mRElujsa8CMDRmypxckcOK+B9GnSkzg
 l98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745913912; x=1746518712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5n3g9/gXeLpoCZdUVd6I7IpvXgfHQCsS2CixWa42Ua8=;
 b=T6AxiUG1wIRB8VtrK2ltluf6qATCgfdtNveNBqXObiULVMm/J18bgJkZh5uzdtj5zi
 oXBZoHNYODwYmHWEhSRVykstnxJHOhK1w/AKjQMSk0/1pmRw5mcWjGwGU5/BlaHMFLwM
 taGi7PwKxnKSkYNrAj6oG1HM/ezQN2QnhxJ7ZPIZjhABA0PK66itWSAT1wy6ww5mA86C
 fs1KnTNP1lU9J8jUqC3ztNXDj3dlalZmdhoRrSYyXQ5g8/y1kqMurhIMEOfVtHMdrZU6
 nvf+FWt6ElIFsbhrb4M8VldL2rPt8z7RdwgWVnv1RYBGELffd5c4PED6naW2RcgQHZ7m
 7Hog==
X-Gm-Message-State: AOJu0YwTivYb0KR/mlgCd8/FgpzCruhJvJRdU4SI2GXLJbbE8IIPRXIz
 U3SmBGa8Rdp+7tj4t5mvY7x/gPid58MpkZm12+LrgMgVCNfGCRQqZNN/ZpEGcTtkCwCX6DbOlFm
 BxNUEFqtaiXMVbPyjZboC6/brh81QigAHC+Yi/Q==
X-Gm-Gg: ASbGncvqPGaFJLm2Zp9i7H30KvdNWj6EWoPL9YdHpiFkjVfuWuX/JZiYHtC2NsPUEKv
 /PyZvTg5ImzI0Z2GvnJXdKkvqTNztf5KwlHc4NEwDANdZwDTBEmt2hYgFDhif28EhUszB6HvAkT
 OcHPZbxyUMV/DjR1PM1theN2KCDa6WnmErHA==
X-Google-Smtp-Source: AGHT+IFo9rZkmVAGCArBGv4NPsqWNC8el8aIxafLaJOPJsD3iPj7eR+0dCxSX7NEQDWhtxcmqdy8W2OUlGAjNK7/HEU=
X-Received: by 2002:a05:690c:3605:b0:6fd:4900:bae1 with SMTP id
 00721157ae682-7085f04b8b6mr175034217b3.1.1745913911907; Tue, 29 Apr 2025
 01:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250428080112.108658-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250428080112.108658-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Apr 2025 11:04:36 +0300
X-Gm-Features: ATxdqUGe4HbqUM8KIQAhimgHEkn3VFuqHZu0MU-9PrWuU3kYBqQIk31dPD4GE5k
Message-ID: <CAC_iWjJFHU+ysJKcFGM5829QqimQn6MdimiUhf8-chnwv0jPuQ@mail.gmail.com>
Subject: Re: [RFC 1/1] efi_loader: add dbginfodump.efi
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Ying-Chun Liu <paul.liu@linaro.org>
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

Hello Heinrich

On Mon, 28 Apr 2025 at 11:01, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a test application to dump the EFI_DEBUG_IMAGE_INFO_TABLE
> as implemented in EDK II.
>

I have no objections is adding the efi app. It won't break anything.

> The implementation in EDK II does not match the description in the
> UEFI specification:
>
> In EDK II field EfiDebugImageInfoTable in EFI_DEBUG_IMAGE_INFO_TABLE_HEADER
> is an array of pointers to EFI_DEBUG_IMAGE_INFO structures while the
> specification says "A pointer to the first element of an array of
> EFI_DEBUG_IMAGE_INFO structures."

Hmm where? The definition in EDK2 is

typedef struct {
  volatile UINT32         UpdateStatus;
  UINT32                  TableSize;
  EFI_DEBUG_IMAGE_INFO    *EfiDebugImageInfoTable;
} EFI_DEBUG_IMAGE_INFO_TABLE_HEADER;

So it's still a pointer to the first element and later EDKII treats it
as an array of EFI_DEBUG_IMAGE_INFO elements, which seems to be what
the spec expects.


Cheers
/Ilias

>
> EFI_DEBUG_IMAGE_INFO is not packed in contrast to many other EFI
> structures.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/Makefile      |   1 +
>  lib/efi_loader/dbginfodump.c | 340 +++++++++++++++++++++++++++++++++++
>  2 files changed, 341 insertions(+)
>  create mode 100644 lib/efi_loader/dbginfodump.c
>
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index cf050e5385d..0ff068b4307 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -21,6 +21,7 @@ ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>  apps-y += dtbdump
>  endif
>  apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
> +apps-y += dbginfodump
>
>  obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
>  obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
> new file mode 100644
> index 00000000000..8e6ed637836
> --- /dev/null
> +++ b/lib/efi_loader/dbginfodump.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
> + *
> + * dbginfodump.efi prints out the content of the EFI_DEBUG_IMAGE_INFO_TABLE.
> + * to a file.
> + */
> +
> +#include <efi_api.h>
> +
> +#define BUFFER_SIZE 64
> +
> +static struct efi_simple_text_output_protocol *cerr;
> +static struct efi_simple_text_output_protocol *cout;
> +static struct efi_simple_text_input_protocol *cin;
> +static efi_handle_t handle;
> +static struct efi_system_table *systable;
> +static struct efi_boot_services *bs;
> +
> +static efi_guid_t guid_device_path_to_text_protocol =
> +       EFI_DEVICE_PATH_TO_TEXT_PROTOCOL_GUID;
> +
> +static struct efi_device_path_to_text_protocol *device_path_to_text;
> +
> +/* EFI_DEBUG_IMAGE_INFO_TAB */
> +static const efi_guid_t dbg_info_guid =
> +       EFI_GUID(0x49152E77, 0x1ADA, 0x4764, 0xB7, 0xA2,
> +                0x7A, 0xFE, 0xFE, 0xD9, 0x5E, 0x8B);
> +
> +struct dbg_info {
> +       u32 type;
> +       struct efi_loaded_image *info;
> +       efi_handle_t handle;
> +};
> +
> +struct dbg_info_header {
> +       u32 status;
> +       u32 size;
> +       struct dbg_info **info;
> +};
> +
> +/**
> + * print() - print string
> + *
> + * @string:    text
> + */
> +static void print(u16 *string)
> +{
> +       cout->output_string(cout, string);
> +}
> +
> +/**
> + * error() - print error string
> + *
> + * @string:    error text
> + */
> +static void error(u16 *string)
> +{
> +       cout->set_attribute(cout, EFI_LIGHTRED | EFI_BACKGROUND_BLACK);
> +       print(string);
> +       cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
> +}
> +
> +/**
> + * printu() - print unsigned
> + *
> + * @val:       value to print
> + */
> +static void printu(u32 val)
> +{
> +       u16 str[19] = u"0x";
> +       u16 *ptr = &str[2];
> +       u16 ch;
> +
> +       for (ssize_t i = 8 * sizeof(u32) - 4; i >= 0; i -= 4) {
> +               ch = (val >> i & 0xf) + '0';
> +               if (ch > '9')
> +                       ch += 'a' - '9' - 1;
> +               *ptr++ = ch;
> +       }
> +       *ptr = 0;
> +       print(str);
> +}
> +
> +/**
> + * printp() - print pointer
> + *
> + * @p: pointer
> + */
> +static void printp(void *p)
> +{
> +       u16 str[19] = u"0x";
> +       u16 *ptr = &str[2];
> +       u16 ch;
> +
> +       for (ssize_t i = 8 * sizeof(void *) - 4; i >= 0; i -= 4) {
> +               ch = ((uintptr_t)p >> i & 0xf) + '0';
> +               if (ch > '9')
> +                       ch += 'a' - '9' - 1;
> +               *ptr++ = ch;
> +       }
> +       *ptr = 0;
> +       print(str);
> +}
> +
> +/**
> + * efi_input() - read string from console
> + *
> + * @buffer:            input buffer
> + * @buffer_size:       buffer size
> + * Return:             status code
> + */
> +static efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
> +{
> +       struct efi_input_key key = {0};
> +       efi_uintn_t index;
> +       efi_uintn_t pos = 0;
> +       u16 outbuf[2] = u" ";
> +       efi_status_t ret;
> +
> +       /* Drain the console input */
> +       ret = cin->reset(cin, true);
> +       *buffer = 0;
> +       for (;;) {
> +               ret = bs->wait_for_event(1, &cin->wait_for_key, &index);
> +               if (ret != EFI_SUCCESS)
> +                       continue;
> +               ret = cin->read_key_stroke(cin, &key);
> +               if (ret != EFI_SUCCESS)
> +                       continue;
> +               switch (key.scan_code) {
> +               case 0x17: /* Escape */
> +                       print(u"\r\nAborted\r\n");
> +                       return EFI_ABORTED;
> +               default:
> +                       break;
> +               }
> +               switch (key.unicode_char) {
> +               case 0x08: /* Backspace */
> +                       if (pos) {
> +                               buffer[pos--] = 0;
> +                               print(u"\b \b");
> +                       }
> +                       break;
> +               case 0x0a: /* Linefeed */
> +               case 0x0d: /* Carriage return */
> +                       print(u"\r\n");
> +                       return EFI_SUCCESS;
> +               default:
> +                       break;
> +               }
> +               /* Ignore surrogate codes */
> +               if (key.unicode_char >= 0xD800 && key.unicode_char <= 0xDBFF)
> +                       continue;
> +               if (key.unicode_char >= 0x20 &&
> +                   pos < buffer_size - 1) {
> +                       *outbuf = key.unicode_char;
> +                       buffer[pos++] = key.unicode_char;
> +                       buffer[pos] = 0;
> +                       print(outbuf);
> +               }
> +       }
> +}
> +
> +/**
> + * skip_whitespace() - skip over leading whitespace
> + *
> + * @pos:       UTF-16 string
> + * Return:     pointer to first non-whitespace
> + */
> +static u16 *skip_whitespace(u16 *pos)
> +{
> +       for (; *pos && *pos <= 0x20; ++pos)
> +               ;
> +       return pos;
> +}
> +
> +/**
> + * starts_with() - check if @string starts with @keyword
> + *
> + * @string:    string to search for keyword
> + * @keyword:   keyword to be searched
> + * Return:     true fi @string starts with the keyword
> + */
> +static bool starts_with(u16 *string, u16 *keyword)
> +{
> +       for (; *keyword; ++string, ++keyword) {
> +               if (*string != *keyword)
> +                       return false;
> +       }
> +       return true;
> +}
> +
> +/**
> + * do_help() - print help
> + */
> +static void do_help(void)
> +{
> +       error(u"dump       - print debug info table\r\n");
> +       error(u"exit       - exit the shell\r\n");
> +}
> +
> +/**
> + * get_dbg_info_table() - get debug info table
> + *
> + * Return:     debug info table or NULL
> + */
> +static void *get_dbg_info(void)
> +{
> +       void *dbg = NULL;
> +       efi_uintn_t i;
> +
> +       for (i = 0; i < systable->nr_tables; ++i) {
> +               if (!memcmp(&systable->tables[i].guid, &dbg_info_guid,
> +                           sizeof(efi_guid_t))) {
> +                       dbg = systable->tables[i].table;
> +                       break;
> +               }
> +       }
> +       return dbg;
> +}
> +
> +/**
> + * print_info() - print loaded image protocol
> + */
> +static void print_info(struct efi_loaded_image *info)
> +{
> +       print(u"  Address: [");
> +       printp(info->image_base);
> +       print(u", ");
> +       printp(info->image_base + info->image_size - 1);
> +       print(u"]\r\n");
> +       if (device_path_to_text && info->file_path) {
> +               u16 *string;
> +
> +               string = device_path_to_text->convert_device_path_to_text(
> +                                       info->file_path, true, false);
> +               if (!string) {
> +                       error(u"ConvertDevicePathToText failed");
> +               } else {
> +                       print(u"  File: ");
> +                       print(string);
> +               }
> +               print(u"\r\n");
> +       }
> +}
> +
> +/**
> + * do_dump() - print debug info table
> + */
> +static efi_status_t do_dump(void)
> +{
> +       struct dbg_info_header *dbg;
> +
> +       dbg = get_dbg_info();
> +       if (!dbg) {
> +               error(u"Debug info table not found\r\n");
> +               return EFI_NOT_FOUND;
> +       }
> +       if (dbg->status & 0x01) {
> +               error(u"Update in progress\r\n");
> +               return EFI_LOAD_ERROR;
> +       }
> +       if (dbg->status & 0x02)
> +               print(u"Modified\r\n");
> +       print(u"Number of entries: ");
> +       printu(dbg->size);
> +       print(u"\r\n");
> +
> +       for (u32 i = 0; i < dbg->size; ++i) {
> +               struct dbg_info *info = dbg->info[i];
> +
> +               print(u"Info type ");
> +               printu(info->type);
> +               print(u"\r\n");
> +               if (info->type != 1)
> +                       continue;
> +               print_info(info->info);
> +               print(u"  Handle: ");
> +               printp(info->handle);
> +               print(u"\r\n");
> +       }
> +
> +       return EFI_SUCCESS;
> +}
> +
> +/**
> + * efi_main() - entry point of the EFI application.
> + *
> + * @handle:    handle of the loaded image
> + * @systab:    system table
> + * Return:     status code
> + */
> +efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
> +                            struct efi_system_table *systab)
> +{
> +       efi_status_t ret;
> +
> +       handle = image_handle;
> +       systable = systab;
> +       cerr = systable->std_err;
> +       cout = systable->con_out;
> +       cin = systable->con_in;
> +       bs = systable->boottime;
> +
> +       cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
> +       cout->clear_screen(cout);
> +       cout->set_attribute(cout, EFI_WHITE | EFI_BACKGROUND_BLACK);
> +       print(u"Debug Info Table Dump\r\n=====================\r\n\r\n");
> +       cout->set_attribute(cout, EFI_LIGHTBLUE | EFI_BACKGROUND_BLACK);
> +
> +       ret = bs->locate_protocol(&guid_device_path_to_text_protocol,
> +                                 NULL, (void **)&device_path_to_text);
> +       if (ret != EFI_SUCCESS) {
> +               error(u"No device path to text protocol\r\n");
> +               device_path_to_text = NULL;
> +       }
> +
> +       for (;;) {
> +               u16 command[BUFFER_SIZE];
> +               u16 *pos;
> +               efi_uintn_t ret;
> +
> +               print(u"=> ");
> +               ret = efi_input(command, sizeof(command));
> +               if (ret == EFI_ABORTED)
> +                       break;
> +               pos = skip_whitespace(command);
> +               if (starts_with(pos, u"exit"))
> +                       break;
> +               else if (starts_with(pos, u"dump"))
> +                       do_dump();
> +               else
> +                       do_help();
> +       }
> +
> +       cout->set_attribute(cout, EFI_LIGHTGRAY | EFI_BACKGROUND_BLACK);
> +       cout->clear_screen(cout);
> +       return EFI_SUCCESS;
> +}
> --
> 2.48.1
>
