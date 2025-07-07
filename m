Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0722C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 08:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3028083015;
	Mon,  7 Jul 2025 10:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SFrgZahA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E558B83043; Mon,  7 Jul 2025 10:03:20 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E37D82FC7
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 10:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e898fb745beso3284554276.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751875397; x=1752480197; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/gd8aHMFphpcyZX4PxWcmt+Bs3qksuApOnDGGtYsAXU=;
 b=SFrgZahA6OVVCUiPNwS5ti2b/WH2wfsI2kh8t9klq6l5ZkWwVNwo9JvzCFwV2v/r8A
 mW8lwGhODnrAPsE16lOV/IMx3dneC6AjDdJt0OpXpenJZtE234QSEaIXYppxJ8YCqy1L
 I9Rmd7Z4t6/N0uZNe+P9ybP2dw6b775oZTDa/MnVAaHg6jBmKN3q2qKPIYIwsheEhWoH
 XXIz3dSaSTU44AuGzEgct6+cIjjPXXm1hQ4qaEx+UIM7Jxn190sJy2tsqCOJKyzO2eVY
 NG58YA/3PPAs3cfpPcOmot0Jb8/BU/1KX9La5EGZvG8jdoQCWIs/D5hc8q5dn5lLao7u
 IA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751875397; x=1752480197;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/gd8aHMFphpcyZX4PxWcmt+Bs3qksuApOnDGGtYsAXU=;
 b=gsb7hlbSaQLbg2Smk1jkxtzSZotEPUfcYZqpMD2cnok7xmiJl88kfZif86BCyvVcvm
 GD5B8oq7gcm4/60sWWSZbrnW/qCyKgJebCUK+P6gxAd7s/DhWmpYZConHbTPhRTGSeQV
 FKdZit7Pi5pU4xpI7zBWi4Ri2/BG2bvnmCczLilRoPAUhK05qH7iorP8Zvyqc9jAGWVs
 eppTVsvt/OhTjS4xnzNDaEAMXhuzul9lK74DCHXNmqyjwNvFsLVUt1iR4wQ5oVBClali
 78W5q6FpTygyACMDItO72O9DjrCTVPYER2kp67fgt3inplp8Bnadm08EEm/1UWepm0g9
 aAUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs7R1pT9vVF9o8jNTZ9RFKeBw0rzk9pKSoVtqC4thTVD8Usq/K9cZrgHwAy7oTaLZrmCMJm5A=@lists.denx.de
X-Gm-Message-State: AOJu0YzZtP2+wfba+n5FlocDy9fEMa4f6hyW8FOe6QiUMk2jWygRH+La
 bwD4ay7h6aicJS7RGEcZeDcnl69vHDBGmtGyWw3j4fzooZWs6I0dziR+h2Rs9jFBitpVNCj4vTy
 9U4lnDzju/5QpvJR5UdTEtn7Jk4neD/dNKD7W1UwU1Q==
X-Gm-Gg: ASbGncuIi3dAp8ZEoiTLkAeHs44zPsZZ5P/AZRXesYBHbvXVMl7i8PM6oDC91Lxr1fV
 QcQYpE4tCEHvtVnuHZuLKsdhE2T9mmJdt2HiunAsm1wAGwqtaNff/uhoSql3y9Ot87+75kRjUQi
 kpZewsTSf7h6L/dT0VcH1LYDEHcCw4I5KEd3r/q84zZMU=
X-Google-Smtp-Source: AGHT+IEVQpnHfEmtd+bSnliPWYwVl9mk9HkTby8zGm1b+hHGcXFVUNkdYROIP/ECLAyeNVRFsz8A37zkZRHW+Sjz52w=
X-Received: by 2002:a05:690c:dc2:b0:70e:25e2:74cf with SMTP id
 00721157ae682-71667f04efbmr161192957b3.18.1751875397020; Mon, 07 Jul 2025
 01:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142212.186229-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250704142212.186229-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 7 Jul 2025 11:02:41 +0300
X-Gm-Features: Ac12FXyFs9WHo-Hb1cV4VYmUnlMs7TYSQ35hCBI2eHfU1vI1vKUh_KjTXGsi-y8
Message-ID: <CAC_iWjKLyM9quaw6ShnX2QFyi=Fv0CqVPCLvhJ6a8HS9uJo9Ew@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: check system table pointer
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

On Fri, 4 Jul 2025 at 17:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Enhance the debug support unit test.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> --

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_selftest/efi_selftest_debug_support.c | 68 ++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_debug_support.c b/lib/efi_selftest/efi_selftest_debug_support.c
> index 9ca8b3f82f5..ac77caaf561 100644
> --- a/lib/efi_selftest/efi_selftest_debug_support.c
> +++ b/lib/efi_selftest/efi_selftest_debug_support.c
> @@ -9,6 +9,7 @@
>
>  #include <efi_loader.h>
>  #include <efi_selftest.h>
> +#include <linux/sizes.h>
>
>  /**
>   * efi_st_debug_support_execute() - execute test
> @@ -21,6 +22,12 @@ static int efi_st_debug_support_execute(void)
>  {
>         struct efi_debug_image_info_table_header *efi_st_debug_info_table_header = NULL;
>         efi_guid_t efi_debug_image_info_table_guid = EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
> +       struct efi_mem_desc *memory_map;
> +       efi_uintn_t map_size = 0;
> +       efi_uintn_t map_key;
> +       efi_uintn_t desc_size;
> +       u32 desc_version;
> +       efi_status_t ret;
>
>         /* get EFI_DEBUG_IMAGE_INFO_TABLE */
>         efi_st_debug_info_table_header = efi_st_get_config_table(&efi_debug_image_info_table_guid);
> @@ -30,7 +37,66 @@ static int efi_st_debug_support_execute(void)
>                 return EFI_ST_FAILURE;
>         }
>
> -       return EFI_ST_SUCCESS;
> +       /* Load memory map */
> +       ret = st_boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
> +                                         &desc_version);
> +       if (ret != EFI_BUFFER_TOO_SMALL) {
> +               efi_st_error
> +                       ("GetMemoryMap did not return EFI_BUFFER_TOO_SMALL\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       /* Allocate extra space for newly allocated memory */
> +       map_size += sizeof(struct efi_mem_desc);
> +       ret = st_boottime->allocate_pool(EFI_BOOT_SERVICES_DATA, map_size,
> +                                        (void **)&memory_map);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("AllocatePool failed\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       ret = st_boottime->get_memory_map(&map_size, memory_map, &map_key,
> +                                         &desc_size, &desc_version);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("GetMemoryMap failed\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       /* Find the system table pointer */
> +       for (efi_uintn_t i = 0; map_size; ++i, map_size -= desc_size) {
> +               struct efi_mem_desc *entry = &memory_map[i];
> +               u64 end;
> +
> +               if (entry->type != EFI_RUNTIME_SERVICES_DATA)
> +                       continue;
> +
> +               end = entry->physical_start +
> +                     (entry->num_pages << EFI_PAGE_SHIFT);
> +               for (u64 pos = ALIGN(entry->physical_start, SZ_4M);
> +                    pos <= end; pos += SZ_4M) {
> +                       struct efi_system_table_pointer *systab_pointer =
> +                               (void *)(uintptr_t)pos;
> +
> +                       /* check for overflow */
> +                       if (pos < entry->physical_start)
> +                               break;
> +                       if (systab_pointer->signature ==
> +                           EFI_SYSTEM_TABLE_SIGNATURE) {
> +                               if (systab_pointer->efi_system_table_base !=
> +                                   (uintptr_t)st_systable) {
> +                                       efi_st_error("Wrong system table address\n");
> +                                       ret = EFI_ST_FAILURE;
> +                                       goto out;
> +                               }
> +                               ret = EFI_ST_SUCCESS;
> +                               goto out;
> +                       }
> +               }
> +       }
> +       efi_st_error("System table pointer not found\n");
> +       ret = EFI_ST_FAILURE;
> +
> +out:
> +       st_boottime->free_pool(memory_map);
> +
> +       return ret;
>  }
>
>  EFI_UNIT_TEST(debug_support) = {
> --
> 2.48.1
>
