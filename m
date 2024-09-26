Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7F5CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E84188E31;
	Thu, 26 Sep 2024 23:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AarW5QGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F0E88DFD; Thu, 26 Sep 2024 23:05:09 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6039488E61
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb3062d9b5so8781436d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727384706; x=1727989506; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jly9HS9JCyEWvO6LTycerWzlpD07oTNoOBloMS/IhRA=;
 b=AarW5QGhcKMr3tGgPOn2ynRRHvItyD5LSpL5PBajBet+U+Hsz4284IJ5jneV8QmZwP
 1kv4P+71Rj+/kNr0PNmiTUY24xoJP5d3lwyIsGZFGcj3r5nCV8mFhX212wpOTOsrwuLE
 cYXP/Agxt2QiVdjnUTYlYOo5VTa9zrj9LFK1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727384706; x=1727989506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jly9HS9JCyEWvO6LTycerWzlpD07oTNoOBloMS/IhRA=;
 b=OP9NXPJNCVdEpcCRgNaafQMlOISDBSutugbm2q4MqNdA5sDU2VCTZI9CTu8oQ0QFX5
 sOU5cnE8jdtTSPieSbNLXwybkQxOpqNJEIGFbTt3qt0kX0X6SW0y4U5M6Dg+WfOqIvQm
 D78b9eSIuYBW5mYPNhX1nxYb/mFMcgFo1G09wq0V6pyoHWRbliPykwkKbNr5mwHBXIfH
 0HNo69rT2SFQrZ8lPvmHk2vchKfbeH/bKZ962LPUgyM1GQ/DsEAKZEaLxM6lYitNVkwz
 H5iDZj7n2agMEUCtRDNOBAqHWPR7AkOCGxXUGAixR2GBbIOvf7AX4tw0ZznXdCZBlsjE
 eT6Q==
X-Gm-Message-State: AOJu0Ywrjj+8jLzytfkGjs1NFKel/8AsDWcHRbBJZPWUj1blyPSjNu1o
 r/ySl2StnK4ByeUtHGxxQ8UrvQdXsEH6CgMHfMoP57KOUldknRc0g5SevzGaHmFjF57bNS4vV+K
 o1RiihVjLgnSnCzEoGN5136D+km7Zs5RYN0z5
X-Google-Smtp-Source: AGHT+IHa0BP4NEwKWjM3A0kHWh6Zc9XsdJ5MrOvjd2HfPndmGUHmdA8NAhKdPt8attlHeVwrrqBXs7BBcyK1qySAOkE=
X-Received: by 2002:a05:6214:5911:b0:6c7:c615:4c2e with SMTP id
 6a1803df08f44-6cb3b65b3c7mr12381216d6.53.1727384706290; Thu, 26 Sep 2024
 14:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-15-patrick.rudolph@9elements.com>
In-Reply-To: <20240926080021.148031-15-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:04:54 +0200
Message-ID: <CAFLszThRmwr_58R7WONuHg1EchEboBEFtfqaYz0EzZVYutvMtw@mail.gmail.com>
Subject: Re: [PATCH v5 14/36] efi_loader: Allocate and write ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Thu, 26 Sept 2024 at 10:02, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allocate memory for ACPI tables inside the efi_loader and write out
> the tables similar to SMBIOS tables. When ACPI is enabled and wasn't
> installed in other places, install the ACPI table in EFI. Since EFI
> is necessary to pass the ACPI table location when FDT isn't used,
> there's no need to install it separately.
>
> When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> bloblist. The tables are still passed to the OS using EFI.
>
> This allows non x86 platforms to boot using ACPI only in case the
> EFI loader is being used.
>
> TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v3:
> - Drop memalign and use efi_allocate_pages
> - Use log_debug instead of debug
> - Clarify commit message
> - Skip writing ACPI tables on sandbox
> - Rename function
> - Add function comment
>
> ---
>  lib/efi_loader/efi_acpi.c        | 80 +++++++++++++++++++++++++++++++-
>  test/py/tests/test_event_dump.py |  1 +
>  2 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> index 67bd7f8ca2..9d38d0060c 100644
> --- a/lib/efi_loader/efi_acpi.c
> +++ b/lib/efi_loader/efi_acpi.c
> @@ -6,15 +6,23 @@
>   */
>
>  #include <efi_loader.h>
> -#include <log.h>
> -#include <mapmem.h>
>  #include <acpi/acpi_table.h>
>  #include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <bloblist.h>
> +#include <linux/sizes.h>
> +#include <linux/log2.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <mapmem.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
>  static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
>
> +enum {
> +       TABLE_SIZE      = SZ_64K,
> +};
>  /*
>   * Install the ACPI table as a configuration table.
>   *
> @@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
>         return efi_install_configuration_table(&acpi_guid,
>                                                (void *)(ulong)addr);
>  }
> +
> +/*
> + * Allocate memory for ACPI tables and write ACPI tables to the
> + * allocated buffer.
> + *
> + * Return:     status code
> + */
> +static int alloc_write_acpi_tables(void)
> +{
> +       u64 table_addr, table_end;
> +       u64 new_acpi_addr = 0;
> +       efi_uintn_t pages;
> +       efi_status_t ret;
> +       void *addr;
> +
> +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> +               return 0;
> +
> +       if (IS_ENABLED(CONFIG_X86) ||
> +           IS_ENABLED(CONFIG_QFW_ACPI) ||
> +           IS_ENABLED(CONFIG_SANDBOX)) {
> +               log_debug("Skipping writing ACPI tables as already done\n");
> +               return 0;
> +       }
> +
> +       /* Align the table to a 4KB boundary to keep EFI happy */
> +       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> +               addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> +                                   ilog2(SZ_4K));
> +
> +               if (!addr)
> +                       return log_msg_ret("mem", -ENOMEM);
> +       } else {
> +               pages = efi_size_in_pages(TABLE_SIZE);
> +
> +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +                                        EFI_ACPI_RECLAIM_MEMORY,
> +                                        pages, &new_acpi_addr);
> +               if (ret != EFI_SUCCESS)
> +                       return log_msg_ret("mem", -ENOMEM);
> +
> +               addr = (void *)(uintptr_t)new_acpi_addr;
> +       }

You can drop the if and the else, since bloblist is always enabled for
ACPI on Arm.

If you set gd->arch.table_start and gd->arch.table_end then efi_acpi.c
will add your ACPI table to the memory map.

[..]

Regards,
Simon
