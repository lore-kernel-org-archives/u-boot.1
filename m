Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52404CDB46B
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 09:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E8F84832;
	Mon, 22 Jun 2026 11:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VS7eFqqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0866784832; Mon, 22 Jun 2026 11:44:27 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FD9D846A4
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 11:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D86FF3F27B
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782121463;
 bh=jpck0L+EaLMuLKsMfBjcgnocBPsPU8WtFUzKNAF1Wb0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=VS7eFqqPEKFeHLg4WE2BPpSsBtTfGhuF8U7oYT+2z0nk+qO9r8ZDwbRJTxTxqhNjq
 XwTJezUc4ceqN6meTxXjaYm/hkEc3KplrRdjWZnco+J8omcDAkRrTd8fWg9B3HUj8b
 8m/f53SRE+on37g/7k3dC9M2k337kSsOTlUBq6akzhXTjbMuWrii79mI0kWy+CRy3d
 GGuRkyfSpOZWxbrFUCKc8veX8xdWYLkZeoaR6x2U6T2qrznoa/2Un+SVtKfXCuthfP
 REzQNgq8cJNAv9fpY1CCiCmncbzYuMaBVZzk55/2d6msPhfaIFbgK48w+bPbnWf5EW
 ZjfPOe0eG1rZ+dJBZq12zefRDokJ0/BFVln9/BcOtbkwaiOLlMh0gT20veAUhhLDHh
 +0EskfTFuQfrGxiMWs7jwwqTE1yx2Yno+gD2XeUa5QCAWMSMnklaRKAysA6+guKxmM
 jNDgDXnCwpQyti71uJQhLF0KouzGfSo+OrUNDnY7/fQkBYYiZZZ/2b3EHsVpjvYWY0
 urkY7IrzYhF3RqpJdcGfV6KIsrKaEZBKnBeJxNBXwHz2QYAi+xJsxqvNv56mZDZU+S
 rg+PaM3jb/WGRVMo1DaN3VkJu2rA93RV5KRG9Woot1tmrIO6BPNZnmcRLHj4S3ZfrU
 X6Hrc/NP6I0VeqYb/OBLgYgg=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-469675e37e8so330557f8f.1
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 02:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782121463; x=1782726263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jpck0L+EaLMuLKsMfBjcgnocBPsPU8WtFUzKNAF1Wb0=;
 b=ATZzsRQyc/e728ZBdYeGPB1i0pl43VL7aEqSztFWj/JIpEDjmmpvbFFjWoVj6iH0Hi
 8VKwD3xLhOj97Y5imzrxA8HfRptgNO1G7bWorWNd9py4sWpin4gOl7Ywpd1UYBcWlLUP
 eNBYJHQPXYUtT+zT+6JLOWfLfwdhO9D3Zz87O8Fs+PDOv0uMcrl2Xj4zLuL31OgkEJkE
 +wEWkPkrACBijbkAnzbDYocX1eh04MMQOFMYJ2CYqWrJ+VMtMmSISLFtzFZqvhK8bSyI
 bk/IMJOipqj9ix5B/BMoSYSxGbncdEeC14N3fOF94rTZsypxc8q1fANZTms3yEZb6Lxi
 p9TQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrx/MgS+qA/xG/xVijWqjDMNXgNzdpwDJbiVVcL+Wdj+RfbVE8RJtL6TUqFpI5wIbaTzyBZM6c=@lists.denx.de
X-Gm-Message-State: AOJu0Yybdrj22IDVXFJUrWwYG+Lntlyk1cYcBj1ZA6+864Th460DwkII
 Gy3j52AcbP81ivAB5YyNlCo3P2fjCoJDKBywlelXVJYiYVZ4n9dMb2oknr0MDu9kw7Y1R5Yr7L6
 z8R+6DMdPU8FXhGbipIGnXtxzpaEFRCMuMS+p0QiZhi8/hx8UipVayAvTemNmOXz5zFdV6o0=
X-Gm-Gg: AfdE7clCmdI0cifmqilQl42XETEHX9JOy/cfTveD6DI/4VI3H+3Bp73CpZM4hQBVzmX
 xlwn+f01+WwgXZcrPUiiJCLMjHFhcRNLdZLbwajIrnznEEvMYFpUZkP7bjrWl7/sHmjJ3L8Eo94
 IZiNr+B26WiD/C+kaOFtA72QOVn/wumPgqaGdUQsaqjzi22MU6Vu6ganU9FBnAtOP9hyMa8zhCq
 7mEpCrv+wLqaCdgUKVbQgSd4bjO65K3Gk/7z9JUzbpTrrOK1z1TX9rv5Xc8FtL/iUje8fwlgG43
 nLCifvpaq+3twvBwvsALYjJdR8SLYbIGDkbvkpp9bQWpNliP6ytOdIl1Ntd8VFFeovPK8eo5qV5
 kzt7yQOcCLqnLuC+lrus0m06FBPaFRNm9UF9rM96NnEUgVDX76H+0dxYFs1ns4z+NFlu4pASu4W
 PRv7phHu9ZvFBVzD0JSmm9zmDObJXUzBOQEg==
X-Received: by 2002:a05:6000:4918:b0:469:763f:942d with SMTP id
 ffacd0b85a97d-469763f96e8mr3195484f8f.5.1782121463101; 
 Mon, 22 Jun 2026 02:44:23 -0700 (PDT)
X-Received: by 2002:a05:6000:4918:b0:469:763f:942d with SMTP id
 ffacd0b85a97d-469763f96e8mr3195419f8f.5.1782121462549; 
 Mon, 22 Jun 2026 02:44:22 -0700 (PDT)
Received: from ?IPV6:2a02:3035:605:b91c:8708:9b24:1b42:7a43?
 ([2a02:3035:605:b91c:8708:9b24:1b42:7a43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788282sm35306447f8f.17.2026.06.22.02.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 02:44:21 -0700 (PDT)
Message-ID: <7f8263b9-ee4e-46f5-a890-eee826fc9d85@canonical.com>
Date: Mon, 22 Jun 2026 11:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] efi_loader: move file-system helpers to
 efi_app_common
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, u-boot@lists.denx.de
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-9-heinrich.schuchardt@canonical.com>
 <CAC_iWjK_OLhXc7Z93_EW2ECWTEqSUnoqLE60=aa7FEv5vrqTVQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjK_OLhXc7Z93_EW2ECWTEqSUnoqLE60=aa7FEv5vrqTVQ@mail.gmail.com>
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

On 6/22/26 10:08, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Sun, 21 Jun 2026 at 11:19, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Move the shared file-system utilities to efi_app_common:
>>
>> * open_file_system() - open the simple file system protocol, first
>>    trying the partition the image was loaded from, then the UEFI system
>>    partition.
>> * get_config_table()  - look up an EFI configuration table by GUID.
>> * save_file()         - write a buffer to a named file, prompting for
>>    confirmation if the file already exists.
>>
>> get_config_table() supersedes the private get_dtb() in dtbdump and
>> get_dbg_info() in dbginfodump; both call-sites are updated to use it.
>>
>> dtbdump's do_save() and initrddump's do_save() are simplified to use
>> the common save_file(), eliminating duplicate file-open/write/close
>> sequences.
>>
>> smbiosdump's private get_config_table(), open_file_system() and
>> save_file() are removed; the common versions take their place.
>>
>> GUID declarations that are no longer referenced after these removals
>> are dropped from each app's file-scope variables.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
> 
> Don't we need the function description for the documentation now that
> it's in a common file?

Thank you for reviewing.

Exported functions have descriptions in efi_app_common.h.

Adding a chapter to the documentation to explain how to create a new app 
including a link to efi_app_common.h make sense. I guess this can be 
done in a follow up patch.

Best regards

Heinrich

> 
> In any case
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
>> v2:
>>          new patch
>> ---
>>   lib/efi_loader/dbginfodump.c    |  22 +-----
>>   lib/efi_loader/dtbdump.c        | 120 +-----------------------------
>>   lib/efi_loader/efi_app_common.c | 105 +++++++++++++++++++++++++++
>>   lib/efi_loader/efi_app_common.h |  27 +++++++
>>   lib/efi_loader/initrddump.c     |  69 +-----------------
>>   lib/efi_loader/smbiosdump.c     | 125 --------------------------------
>>   6 files changed, 141 insertions(+), 327 deletions(-)
>>
>> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
>> index 4808fe254fe..b54c3830a66 100644
>> --- a/lib/efi_loader/dbginfodump.c
>> +++ b/lib/efi_loader/dbginfodump.c
>> @@ -91,26 +91,6 @@ static void do_help(void)
>>          error(u"exit       - exit the shell\r\n");
>>   }
>>
>> -/**
>> - * get_dbg_info_table() - get debug info table
>> - *
>> - * Return:     debug info table or NULL
>> - */
>> -static void *get_dbg_info(void)
>> -{
>> -       void *dbg = NULL;
>> -       efi_uintn_t i;
>> -
>> -       for (i = 0; i < systable->nr_tables; ++i) {
>> -               if (!memcmp(&systable->tables[i].guid, &dbg_info_guid,
>> -                           sizeof(efi_guid_t))) {
>> -                       dbg = systable->tables[i].table;
>> -                       break;
>> -               }
>> -       }
>> -       return dbg;
>> -}
>> -
>>   /**
>>    * print_info() - print loaded image protocol
>>    */
>> @@ -144,7 +124,7 @@ static efi_status_t do_dump(void)
>>          struct dbg_info_header *dbg;
>>          u32 count;
>>
>> -       dbg = get_dbg_info();
>> +       dbg = get_config_table(&dbg_info_guid);
>>          if (!dbg) {
>>                  error(u"Debug info table not found\r\n");
>>                  return EFI_NOT_FOUND;
>> diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
>> index 559c64be7f7..0d56a41ecf6 100644
>> --- a/lib/efi_loader/dtbdump.c
>> +++ b/lib/efi_loader/dtbdump.c
>> @@ -7,7 +7,6 @@
>>    */
>>
>>   #include <efi_dt_fixup.h>
>> -#include <part.h>
>>   #include <linux/libfdt.h>
>>   #include "efi_app_common.h"
>>
>> @@ -18,14 +17,10 @@
>>
>>   static struct efi_boot_services *bs;
>>   static const efi_guid_t fdt_guid = EFI_FDT_GUID;
>> -static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
>> -static const efi_guid_t guid_simple_file_system_protocol =
>> -                                       EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
>>   static efi_handle_t handle;
>>   static struct efi_system_table *systable;
>>   static const efi_guid_t efi_dt_fixup_protocol_guid = EFI_DT_FIXUP_PROTOCOL_GUID;
>>   static const efi_guid_t efi_file_info_guid = EFI_FILE_INFO_GUID;
>> -static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
>>
>>   /**
>>    * print_char() - print character
>> @@ -66,27 +61,6 @@ static u32 f2h(fdt32_t val)
>>          return *(u32 *)buf;
>>   }
>>
>> -/**
>> - * get_dtb() - get device tree
>> - *
>> - * @systable:  system table
>> - * Return:     device tree or NULL
>> - */
>> -static void *get_dtb(struct efi_system_table *systable)
>> -{
>> -       void *dtb = NULL;
>> -       efi_uintn_t i;
>> -
>> -       for (i = 0; i < systable->nr_tables; ++i) {
>> -               if (!memcmp(&systable->tables[i].guid, &fdt_guid,
>> -                           sizeof(efi_guid_t))) {
>> -                       dtb = systable->tables[i].table;
>> -                       break;
>> -               }
>> -       }
>> -       return dtb;
>> -}
>> -
>>   /**
>>    * do_help() - print help
>>    */
>> @@ -98,52 +72,6 @@ static void do_help(void)
>>          error(u"exit       - exit the shell\r\n");
>>   }
>>
>> -/**
>> - * open_file_system() - open simple file system protocol
>> - *
>> - * file_system:        interface of the simple file system protocol
>> - * Return:     status code
>> - */
>> -static efi_status_t
>> -open_file_system(struct efi_simple_file_system_protocol **file_system)
>> -{
>> -       struct efi_loaded_image *loaded_image;
>> -       efi_status_t ret;
>> -       efi_handle_t *handle_buffer = NULL;
>> -       efi_uintn_t count;
>> -
>> -       ret = bs->open_protocol(handle, &loaded_image_guid,
>> -                               (void **)&loaded_image, NULL, NULL,
>> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> -       if (ret != EFI_SUCCESS) {
>> -               error(u"Loaded image protocol not found\r\n");
>> -               return ret;
>> -       }
>> -
>> -       /* Open the simple file system protocol on the same partition */
>> -       ret = bs->open_protocol(loaded_image->device_handle,
>> -                               &guid_simple_file_system_protocol,
>> -                               (void **)file_system, NULL, NULL,
>> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> -       if (ret == EFI_SUCCESS)
>> -               return ret;
>> -
>> -       /* Open the simple file system protocol on the UEFI system partition */
>> -       ret = bs->locate_handle_buffer(BY_PROTOCOL, &efi_system_partition_guid,
>> -                                      NULL, &count, &handle_buffer);
>> -       if (ret == EFI_SUCCESS && handle_buffer)
>> -               ret = bs->open_protocol(handle_buffer[0],
>> -                                       &guid_simple_file_system_protocol,
>> -                                       (void **)file_system, NULL, NULL,
>> -                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> -       if (ret != EFI_SUCCESS)
>> -               error(u"Failed to open simple file system protocol\r\n");
>> -       if (handle_buffer)
>> -               bs->free_pool(handle_buffer);
>> -
>> -       return ret;
>> -}
>> -
>>   /**
>>    * do_load() - load and install device-tree
>>    *
>> @@ -289,13 +217,11 @@ out:
>>    */
>>   static efi_status_t do_save(u16 *filename)
>>   {
>> -       struct efi_simple_file_system_protocol *file_system;
>> -       efi_uintn_t dtb_size;
>> -       struct efi_file_handle *root, *file;
>>          struct fdt_header *dtb;
>> +       efi_uintn_t dtb_size;
>>          efi_uintn_t ret;
>>
>> -       dtb = get_dtb(systable);
>> +       dtb = get_config_table(&fdt_guid);
>>          if (!dtb) {
>>                  error(u"DTB not found\r\n");
>>                  return EFI_NOT_FOUND;
>> @@ -308,45 +234,7 @@ static efi_status_t do_save(u16 *filename)
>>
>>          filename = skip_whitespace(filename);
>>
>> -       ret = open_file_system(&file_system);
>> -       if (ret != EFI_SUCCESS)
>> -               return ret;
>> -
>> -       /* Open volume */
>> -       ret = file_system->open_volume(file_system, &root);
>> -       if (ret != EFI_SUCCESS) {
>> -               error(u"Failed to open volume\r\n");
>> -               return ret;
>> -       }
>> -       /* Check if file already exists */
>> -       ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
>> -       if (ret == EFI_SUCCESS) {
>> -               file->close(file);
>> -               print(u"Overwrite existing file (y/n)? ");
>> -               ret = efi_input_yn();
>> -               print(u"\r\n");
>> -               if (ret != EFI_SUCCESS) {
>> -                       root->close(root);
>> -                       error(u"Aborted by user\r\n");
>> -                       return ret;
>> -               }
>> -       }
>> -
>> -       /* Create file */
>> -       ret = root->open(root, &file, filename,
>> -                        EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
>> -                        EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
>> -       if (ret == EFI_SUCCESS) {
>> -               /* Write file */
>> -               ret = file->write(file, &dtb_size, dtb);
>> -               if (ret != EFI_SUCCESS)
>> -                       error(u"Failed to write file\r\n");
>> -               file->close(file);
>> -       } else {
>> -               error(u"Failed to open file\r\n");
>> -       }
>> -       root->close(root);
>> -
>> +       ret = save_file(filename, dtb, dtb_size);
>>          if (ret == EFI_SUCCESS) {
>>                  print(filename);
>>                  print(u" written\r\n");
>> @@ -479,7 +367,7 @@ static efi_status_t do_dump(void)
>>          const char *strings;
>>          u32 level = 0;
>>
>> -       fdt = get_dtb(systable);
>> +       fdt = get_config_table(&fdt_guid);
>>          if (!fdt) {
>>                  error(u"DTB not found\r\n");
>>                  return EFI_NOT_FOUND;
>> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
>> index 6bd52e08d28..af9799557fc 100644
>> --- a/lib/efi_loader/efi_app_common.c
>> +++ b/lib/efi_loader/efi_app_common.c
>> @@ -6,6 +6,7 @@
>>    */
>>
>>   #include <efi_api.h>
>> +#include <part.h>
>>   #include "efi_app_common.h"
>>
>>   static efi_handle_t app_handle;
>> @@ -15,6 +16,9 @@ struct efi_boot_services *bs;
>>   static bool nocolor;
>>   static struct efi_system_table *systable;
>>   static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
>> +static const efi_guid_t guid_simple_file_system_protocol =
>> +       EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
>> +static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
>>
>>   static u16 *get_load_options(void)
>>   {
>> @@ -199,3 +203,104 @@ efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
>>                  }
>>          }
>>   }
>> +
>> +void *get_config_table(const efi_guid_t *guid)
>> +{
>> +       size_t i;
>> +
>> +       for (i = 0; i < systable->nr_tables; ++i) {
>> +               if (!memcmp(guid, &systable->tables[i].guid, 16))
>> +                       return systable->tables[i].table;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +efi_status_t
>> +open_file_system(struct efi_simple_file_system_protocol **file_system)
>> +{
>> +       struct efi_loaded_image *loaded_image;
>> +       efi_status_t ret;
>> +       efi_handle_t *handle_buffer = NULL;
>> +       efi_uintn_t count;
>> +
>> +       ret = bs->open_protocol(app_handle, &loaded_image_guid,
>> +                               (void **)&loaded_image, NULL, NULL,
>> +                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> +       if (ret != EFI_SUCCESS) {
>> +               error(u"Loaded image protocol not found\r\n");
>> +               return ret;
>> +       }
>> +
>> +       /* Open the simple file system protocol on the same partition */
>> +       ret = bs->open_protocol(loaded_image->device_handle,
>> +                               &guid_simple_file_system_protocol,
>> +                               (void **)file_system, NULL, NULL,
>> +                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> +       if (ret == EFI_SUCCESS)
>> +               return ret;
>> +
>> +       /* Open the simple file system protocol on the UEFI system partition */
>> +       ret = bs->locate_handle_buffer(BY_PROTOCOL, &efi_system_partition_guid,
>> +                                      NULL, &count, &handle_buffer);
>> +       if (ret == EFI_SUCCESS && handle_buffer)
>> +               ret = bs->open_protocol(handle_buffer[0],
>> +                                       &guid_simple_file_system_protocol,
>> +                                       (void **)file_system, NULL, NULL,
>> +                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> +       if (ret != EFI_SUCCESS)
>> +               error(u"Failed to open simple file system protocol\r\n");
>> +       if (handle_buffer)
>> +               bs->free_pool(handle_buffer);
>> +
>> +       return ret;
>> +}
>> +
>> +efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
>> +{
>> +       efi_uintn_t ret;
>> +       struct efi_simple_file_system_protocol *file_system;
>> +       struct efi_file_handle *root, *file;
>> +
>> +       ret = open_file_system(&file_system);
>> +       if (ret != EFI_SUCCESS)
>> +               return ret;
>> +
>> +       /* Open volume */
>> +       ret = file_system->open_volume(file_system, &root);
>> +       if (ret != EFI_SUCCESS) {
>> +               error(u"Failed to open volume\r\n");
>> +               return ret;
>> +       }
>> +       /* Check if file already exists */
>> +       ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
>> +       if (ret == EFI_SUCCESS) {
>> +               file->close(file);
>> +               print(u"Overwrite existing file (y/n)? ");
>> +               ret = efi_input_yn();
>> +               print(u"\r\n");
>> +               if (ret != EFI_SUCCESS) {
>> +                       root->close(root);
>> +                       error(u"Aborted by user\r\n");
>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       /* Create file */
>> +       ret = root->open(root, &file, filename,
>> +                        EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
>> +                                EFI_FILE_MODE_CREATE,
>> +                        EFI_FILE_ARCHIVE);
>> +       if (ret == EFI_SUCCESS) {
>> +               /* Write file */
>> +               ret = file->write(file, &size, buf);
>> +               if (ret != EFI_SUCCESS)
>> +                       error(u"Failed to write file\r\n");
>> +               file->close(file);
>> +       } else {
>> +               error(u"Failed to open file\r\n");
>> +       }
>> +       root->close(root);
>> +
>> +       return ret;
>> +}
>> diff --git a/lib/efi_loader/efi_app_common.h b/lib/efi_loader/efi_app_common.h
>> index ff37f3413eb..77fe100afd9 100644
>> --- a/lib/efi_loader/efi_app_common.h
>> +++ b/lib/efi_loader/efi_app_common.h
>> @@ -101,4 +101,31 @@ efi_status_t efi_input_yn(void);
>>    */
>>   efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size);
>>
>> +/**
>> + * get_config_table() - get configuration table
>> + *
>> + * @guid:       GUID of the configuration table
>> + * Return:      pointer to configuration table or NULL
>> + */
>> +void *get_config_table(const efi_guid_t *guid);
>> +
>> +/**
>> + * open_file_system() - open simple file system protocol
>> + *
>> + * @file_system: interface of the simple file system protocol
>> + * Return:       status code
>> + */
>> +efi_status_t
>> +open_file_system(struct efi_simple_file_system_protocol **file_system);
>> +
>> +/**
>> + * save_file() - save buffer to a file on the EFI system partition
>> + *
>> + * @filename:   file name
>> + * @buf:        buffer to write
>> + * @size:       size of the buffer
>> + * Return:      status code
>> + */
>> +efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size);
>> +
>>   #endif /* _EFI_APP_COMMON_H */
>> diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
>> index 0a025c1a841..c3e6f2b683f 100644
>> --- a/lib/efi_loader/initrddump.c
>> +++ b/lib/efi_loader/initrddump.c
>> @@ -19,9 +19,6 @@
>>
>>   static struct efi_system_table *systable;
>>   static struct efi_boot_services *bs;
>> -static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
>> -static const efi_guid_t guid_simple_file_system_protocol =
>> -                                       EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
>>   static const efi_guid_t load_file2_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
>>   static efi_handle_t handle;
>>
>> @@ -143,9 +140,6 @@ static efi_status_t do_load(void)
>>    */
>>   static efi_status_t do_save(u16 *filename)
>>   {
>> -       struct efi_loaded_image *loaded_image;
>> -       struct efi_simple_file_system_protocol *file_system;
>> -       struct efi_file_handle *root, *file;
>>          void *initrd;
>>          efi_uintn_t initrd_size;
>>          efi_uintn_t ret;
>> @@ -156,68 +150,13 @@ static efi_status_t do_save(u16 *filename)
>>
>>          filename = skip_whitespace(filename);
>>
>> -       ret = bs->open_protocol(handle, &loaded_image_guid,
>> -                               (void **)&loaded_image, NULL, NULL,
>> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> -       if (ret != EFI_SUCCESS) {
>> -               error(u"Loaded image protocol not found\r\n");
>> -               goto out;
>> -       }
>> -
>> -       /* Open the simple file system protocol */
>> -       ret = bs->open_protocol(loaded_image->device_handle,
>> -                               &guid_simple_file_system_protocol,
>> -                               (void **)&file_system, NULL, NULL,
>> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> -       if (ret != EFI_SUCCESS) {
>> -               error(u"Failed to open simple file system protocol\r\n");
>> -               goto out;
>> -       }
>> -
>> -       /* Open volume */
>> -       ret = file_system->open_volume(file_system, &root);
>> -       if (ret != EFI_SUCCESS) {
>> -               error(u"Failed to open volume\r\n");
>> -               goto out;
>> -       }
>> -       /* Check if file already exists */
>> -       ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
>> -       if (ret == EFI_SUCCESS) {
>> -               file->close(file);
>> -               efi_drain_input();
>> -               print(u"Overwrite existing file (y/n)? ");
>> -               ret = efi_input_yn();
>> -               print(u"\r\n");
>> -               if (ret != EFI_SUCCESS) {
>> -                       root->close(root);
>> -                       error(u"Aborted by user\r\n");
>> -                       goto out;
>> -               }
>> -       }
>> -
>> -       /* Create file */
>> -       ret = root->open(root, &file, filename,
>> -                        EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
>> -                        EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
>> +       ret = save_file(filename, initrd, initrd_size);
>>          if (ret == EFI_SUCCESS) {
>> -               /* Write file */
>> -               ret = file->write(file, &initrd_size, initrd);
>> -               if (ret != EFI_SUCCESS) {
>> -                       error(u"Failed to write file\r\n");
>> -               } else {
>> -                       print(filename);
>> -                       print(u" written\r\n");
>> -               }
>> -               file->close(file);
>> -       } else {
>> -               error(u"Failed to open file\r\n");
>> +               print(filename);
>> +               print(u" written\r\n");
>>          }
>> -       root->close(root);
>>
>> -out:
>> -       if (initrd)
>> -               bs->free_pages((uintptr_t)initrd,
>> -                              efi_size_in_pages(initrd_size));
>> +       bs->free_pages((uintptr_t)initrd, efi_size_in_pages(initrd_size));
>>          return ret;
>>   }
>>
>> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
>> index 351e103fb97..8aa6f594a07 100644
>> --- a/lib/efi_loader/smbiosdump.c
>> +++ b/lib/efi_loader/smbiosdump.c
>> @@ -8,7 +8,6 @@
>>    * clearing of the screen.
>>    */
>>
>> -#include <part.h>
>>   #include <smbios.h>
>>   #include <string.h>
>>   #include "efi_app_common.h"
>> @@ -20,56 +19,6 @@ static efi_handle_t handle;
>>   static struct efi_system_table *systable;
>>   static const efi_guid_t smbios_guid = SMBIOS_TABLE_GUID;
>>   static const efi_guid_t smbios3_guid = SMBIOS3_TABLE_GUID;
>> -static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
>> -static const efi_guid_t guid_simple_file_system_protocol =
>> -                                       EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID;
>> -static const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
>> -
>> -/**
>> - * open_file_system() - open simple file system protocol
>> - *
>> - * file_system:        interface of the simple file system protocol
>> - * Return:     status code
>> - */
>> -static efi_status_t
>> -open_file_system(struct efi_simple_file_system_protocol **file_system)
>> -{
>> -       struct efi_loaded_image *loaded_image;
>> -       efi_status_t ret;
>> -       efi_handle_t *handle_buffer = NULL;
>> -       efi_uintn_t count;
>> -
>> -       ret = bs->open_protocol(handle, &loaded_image_guid,
>> -                               (void **)&loaded_image, NULL, NULL,
>> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> -       if (ret != EFI_SUCCESS) {
>> -               error(u"Loaded image protocol not found\r\n");
>> -               return ret;
>> -       }
>> -
>> -       /* Open the simple file system protocol on the same partition */
>> -       ret = bs->open_protocol(loaded_image->device_handle,
>> -                               &guid_simple_file_system_protocol,
>> -                               (void **)file_system, NULL, NULL,
>> -                               EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> -       if (ret == EFI_SUCCESS)
>> -               return ret;
>> -
>> -       /* Open the simple file system protocol on the UEFI system partition */
>> -       ret = bs->locate_handle_buffer(BY_PROTOCOL, &efi_system_partition_guid,
>> -                                      NULL, &count, &handle_buffer);
>> -       if (ret == EFI_SUCCESS && handle_buffer)
>> -               ret = bs->open_protocol(handle_buffer[0],
>> -                                       &guid_simple_file_system_protocol,
>> -                                       (void **)file_system, NULL, NULL,
>> -                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>> -       if (ret != EFI_SUCCESS)
>> -               error(u"Failed to open simple file system protocol\r\n");
>> -       if (handle_buffer)
>> -               bs->free_pool(handle_buffer);
>> -
>> -       return ret;
>> -}
>>
>>   /**
>>    * do_help() - print help
>> @@ -81,24 +30,6 @@ static void do_help(void)
>>          error(u"exit        - exit the shell\r\n");
>>   }
>>
>> -/**
>> - * get_config_table() - get configuration table
>> - *
>> - * @guid:      GUID of the configuration table
>> - * Return:     pointer to configuration table or NULL
>> - */
>> -static void *get_config_table(const efi_guid_t *guid)
>> -{
>> -       size_t i;
>> -
>> -       for (i = 0; i < systable->nr_tables; ++i) {
>> -               if (!memcmp(guid, &systable->tables[i].guid, 16))
>> -                       return systable->tables[i].table;
>> -       }
>> -
>> -       return NULL;
>> -}
>> -
>>   /**
>>    * checksum() - calculate checksum
>>    *
>> @@ -211,62 +142,6 @@ static efi_status_t do_check(void)
>>          return EFI_SUCCESS;
>>   }
>>
>> -/**
>> - * save_file() - save file to EFI system partition
>> - *
>> - * @filename:  file name
>> - * @buf:       buffer to write
>> - * @size:      size of the buffer
>> - */
>> -static efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
>> -{
>> -       efi_uintn_t ret;
>> -       struct efi_simple_file_system_protocol *file_system;
>> -       struct efi_file_handle *root, *file;
>> -
>> -       ret = open_file_system(&file_system);
>> -       if (ret != EFI_SUCCESS)
>> -               return ret;
>> -
>> -       /* Open volume */
>> -       ret = file_system->open_volume(file_system, &root);
>> -       if (ret != EFI_SUCCESS) {
>> -               error(u"Failed to open volume\r\n");
>> -               return ret;
>> -       }
>> -       /* Check if file already exists */
>> -       ret = root->open(root, &file, filename, EFI_FILE_MODE_READ, 0);
>> -       if (ret == EFI_SUCCESS) {
>> -               file->close(file);
>> -               print(u"Overwrite existing file (y/n)? ");
>> -               ret = efi_input_yn();
>> -               print(u"\r\n");
>> -               if (ret != EFI_SUCCESS) {
>> -                       root->close(root);
>> -                       error(u"Aborted by user\r\n");
>> -                       bs->free_pool(buf);
>> -                       return ret;
>> -               }
>> -       }
>> -
>> -       /* Create file */
>> -       ret = root->open(root, &file, filename,
>> -                        EFI_FILE_MODE_READ | EFI_FILE_MODE_WRITE |
>> -                        EFI_FILE_MODE_CREATE, EFI_FILE_ARCHIVE);
>> -       if (ret == EFI_SUCCESS) {
>> -               /* Write file */
>> -               ret = file->write(file, &size, buf);
>> -               if (ret != EFI_SUCCESS)
>> -                       error(u"Failed to write file\r\n");
>> -               file->close(file);
>> -       } else {
>> -               error(u"Failed to open file\r\n");
>> -       }
>> -       root->close(root);
>> -
>> -       return ret;
>> -}
>> -
>>   /**
>>    * do_save() - save SMBIOS table
>>    *
>> --
>> 2.53.0
>>

