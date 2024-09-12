Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98369EE6451
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0907F88D9F;
	Thu, 12 Sep 2024 08:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kfz1WiKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95DE88DF0; Thu, 12 Sep 2024 08:55:08 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 517F988B67
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7093c94435bso213385a34.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124105; x=1726728905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sdu64N3q0NXhC4fi+YSG8L59nfGkJG78fY2TAQ7QBBY=;
 b=kfz1WiKmyTz+edd8eFBCnPvxW/10fXJ3QN3QbeMjGNwzTRs71AANX+VVzcXmFlwv82
 z1TuMaq0xqzgqJYmSc5FQ/2rHr1XL7wkwKNns8n8ufQxS8v/P5jDIITSE6gtD5L1Ya7p
 cEtPH0FzdPk+ZQ8iDlXoUPJjXd1MnkYWMFGG6ns02y7PVzCS5WEl/nes+ldM4sdboVHa
 sIF0T33sfqpCAZzmftvlZFJbMB0hI4mFtvqOAzUBy3exhKCpzDxDyBT1g/mWWG+bSNjh
 C9GsebfIcXGEUO5RGPUHo+Wiv4fvbl846q3PgJtHUkDnIkkzttEprvPj3xLcbTlwS61K
 VeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124105; x=1726728905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sdu64N3q0NXhC4fi+YSG8L59nfGkJG78fY2TAQ7QBBY=;
 b=u42CSug0rwQgxgCjwWk/kixuIrrz8XzIJwWGhcI4XWI6sbyt+XrxVJaFNQw20OqYxs
 3xqLzkSdAWWEEbSSMQPWZB65DgVxT85q9NG1hztrQabG4f4eAkswnHJFdmJm1ep4xXE3
 XYCyDZ4tLFi+xaSy++aLpDacscdcood6hPj6v+zQU40aEBbdKrmeVMDfTKfcq4cXmp/d
 1c+lEq6ONyTIdSWqAIsl1Bfgpg2n0bQSk06uCaa2PzaHQSMy7XlQNAfhnM6M86mxhkId
 2E3cGIu0wqR6X610cZX68j7rz7rEzwfbe5yMtvhFeN+4dCejv9ueH0zMImUIZx/Itn31
 CgeQ==
X-Gm-Message-State: AOJu0YxC7Z5jcuqeNH3CxQjaysYHIh4Gi17PxWek1yhtSh3oMJSiwwdm
 deKedOzdTGhaU9UDTHsPgCWjnIb7k1L5/suxdF8Pq5oVxFoUubQNTbg7O5KxfPZi99qI+YOAWV3
 MUkgY7rEOR2+Tj2LieZ6nWtEONwYFQ6cez1CTJ1vkv43XDBD2r9k=
X-Google-Smtp-Source: AGHT+IH3TGLs9+8k8gBO/DtOK/F+hf8gFpWxYniCpL+8Q3Lw1K9FeWqYqONZNDiUUxindNzqy5OCMwcZV50yuaCdsig=
X-Received: by 2002:a05:6830:4904:b0:703:5fbe:e0ca with SMTP id
 46e09a7af769-71109463365mr2059523a34.4.1726124104696; Wed, 11 Sep 2024
 23:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-15-patrick.rudolph@9elements.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Sep 2024 09:54:28 +0300
Message-ID: <CAC_iWjLfbXHFd7zs0xsVamXua8GXsAbhBstgTQEQN1+t8Fr2QA@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Patrick

On Wed, 11 Sept 2024 at 09:25, Patrick Rudolph
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

This addr is not in ACPI_RECLAIM_MEMORY now. It might work since
efi_acpi_register() adads it on the EFI memory map.
In the last version, Simon replied something along the lines of  "This
is how x86 works", but I don't understand why. U-Boot at this point is
the last bootloader you'll run and then jump to your EFI payload. Can
someone clearly explain what's going on here?

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

So this would be fine if we initialized the EFI subsystem early, but
we don't.  On top of that the efi_acpi_register() call is trying to
add the allocated memory to the efi memmap, so we don't need to do
that twice.

I think there's a cleaner approach overall to this which will allow us
to decouple the installation etc from EFI.
You could allocate a piece of memory, assign it to
arch.table_start/end and then tweak efi_acpi_register(). Instead of
marking the table_end - table_start as ACPI_RECLAIM_MEMORY, allocate
the pages there, where you know the EFI subsystem is up and copy it.
It would then be the callers responsibilty to free that memory.

Heinrich, do you see a problem with that?

Thanks
/Ilias

> +       }
> +
> +       table_addr = virt_to_phys(addr);
> +
> +       gd->arch.table_start_high = table_addr;
> +
> +       table_end = write_acpi_tables(table_addr);
> +       if (!table_end) {
> +               log_err("Can't create ACPI configuration table\n");
> +               return -EINTR;
> +       }
> +
> +       log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, table_end);
> +       if (table_end - table_addr > TABLE_SIZE) {
> +               log_err("Out of space for configuration tables: need %llx, have %x\n",
> +                       table_end - table_addr, TABLE_SIZE);
> +               return log_msg_ret("acpi", -ENOSPC);
> +       }
> +       gd->arch.table_end_high = table_end;
> +
> +       log_debug("- done writing tables\n");
> +
> +       return 0;
> +}
> +
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
> diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> index e282c67335..459bfa26bb 100644
> --- a/test/py/tests/test_event_dump.py
> +++ b/test/py/tests/test_event_dump.py
> @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
>  --------------------  ------------------------------  ------------------------------
>  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
>  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader/efi_acpi.c:.*
>  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
>  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
>  EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> --
> 2.46.0
>
