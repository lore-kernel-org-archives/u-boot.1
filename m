Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B11EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3152488D71;
	Thu, 12 Sep 2024 02:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NvTxYG5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC3D88D54; Thu, 12 Sep 2024 02:59:11 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5EB588D5C
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718e285544fso255409b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102747; x=1726707547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LRRBBmJ5r+yj0KP1WCGGTR2Q+QWtcbQ3uYjaXQ36w7A=;
 b=NvTxYG5aLbPiRsRHKxuN8b6e37AecCknJuGD5Mmvn0be7qs082Ot2IST2nIOaiFxzR
 U3RVwo/deyWh7h0xlHfsQs6oZoL6QAQjDFypcTA/4Tlh5JiP/ebaWceDFI/+HC9lZ0k1
 46AMIhFz4c6R1uo4ir6kyG5//Xwq6lfY2/ibg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102747; x=1726707547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRRBBmJ5r+yj0KP1WCGGTR2Q+QWtcbQ3uYjaXQ36w7A=;
 b=Y8dpivYqflfD7LddTaQQToZE59aPcwkE/yM3y8FzSzSvlsfwnm7Vt1B/98MS6Yj2IW
 r9Z7/pxOLdXRzCj/Jm272c3ja+vHB/VzW4cfp6W+UpS//mIhNmfts6aoE6QyT5YkAVBY
 04zvvPr9JFjk/7btjTlTy2a/wZgrAPAk/nSpHhkkQ+1AIewit10M1qbjGWl/sIdLtf4K
 NlK4c7f2P09O4+kEWA544RTQNwJHOpTdj8Dajz4gcxWqWRQdBkKa3BkJkuCAbiehVgSh
 w//hnsLRWLcS5DsSO+eRiCMkvaMDEzluhbDLYvGg+VGa9p/uZ6BWlkIqm/odWToiHCPo
 mtLQ==
X-Gm-Message-State: AOJu0YyIRYbdzU/0MCFh4LT4drG2VDSemdtgtQvQLsjmKQyKPkd3mIFC
 y0gXW3DZrdVMgrN6wywxUDe96mngXwTvgjZgJR5oMlC+4lVT7yMGlMtkYaLPYii7swcNP5gZNQI
 p1DfqJDWJKfhNjQFaoITrcKqur3yQUilYiH3kbh7IFUL4j+U=
X-Google-Smtp-Source: AGHT+IGm5GtPfVebOIbNORCxtuzyjwyg52ZE4wRxPZaCP6akOdwWTMkEwdwhf812iE1CY5+HpO5ug7G4Qg0NNYtPF6s=
X-Received: by 2002:a05:6a00:1955:b0:714:20a8:d79f with SMTP id
 d2e1a72fcca58-719260875f8mr1696946b3a.14.1726102747280; Wed, 11 Sep 2024
 17:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-15-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:20 -0600
Message-ID: <CAFLszTiaaP9goTUQiVJ3MQkzegDAmac-AWmtip38eLhMoC15xg@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
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

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
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
> +       } else {
> +               pages = efi_size_in_pages(TABLE_SIZE);
> +
> +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +                                        EFI_ACPI_RECLAIM_MEMORY,
> +                                        pages, &new_acpi_addr);

I know we are going to have a problem here since EFI memory-allocation
is a bit of a mess, and you got conflicting advice on the previous
version....

But we cannot call efi_allocate_pages() during U-Boot init. EFI may
not even be enabled. The allocation ends up being in the area between
the bottom of memory at the bottom of the stack, which is not supposed
to be used, at least until images are loaded.

I think in fact we should make this ACPI stuff depend on bloblist and
just put the tables there. So set up bloblist size to something small,
like 0x100 and set BLOBLIST_SIZE_RELOC to larger than you need (e.g.
68KB). Everything should work OK. I will do a bit of a tidy-up after
this series goes in.

> +               if (ret != EFI_SUCCESS)
> +                       return log_msg_ret("mem", -ENOMEM);
> +
> +               addr = (void *)(uintptr_t)new_acpi_addr;
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

Regards,
Simon
