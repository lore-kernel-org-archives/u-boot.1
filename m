Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE5CCDD548
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 16:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC5188B59;
	Wed, 18 Sep 2024 18:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HwDBlGDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B0888B59; Wed, 18 Sep 2024 18:02:34 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15ED3871C7
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 18:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7b0c9bbddb4so4731082a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726675350; x=1727280150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LeONlCAEI9T8kxMhfKIDbDy+8XSg4++Epw3pZGjhtwA=;
 b=HwDBlGDVtaVIspFipw+VP02T2+eTtb2Ze/GVwM5/1U26g2junAjyPKdFB/KW/m6s57
 7/d5Y+UobUKMP67GutjPic02QZR5nxrIdE9bISjgSte0eZKGFs4W333ZU2hagVJearkk
 BajUYTAi41ERPM8TWhiVYFLSdTBheN4fEBaUX/Ulax57vlHQOgMwhLwEd/PlhFkq0Evt
 XdIzArWtsa/LGF8rBpSvnfgRVzzZBowPXBXCucYmUDHR9Ki1xWBdWJTcmsQBRXOfv30R
 BjXLooJY7lpBLWZDo5HAcXpn9eqoyUi74NGJiiI9xtTglzVe/fiO481ggAAXWpuli1O/
 d0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726675350; x=1727280150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LeONlCAEI9T8kxMhfKIDbDy+8XSg4++Epw3pZGjhtwA=;
 b=joLk6Ok+xOEZ8SnA9Yz4/Y3IKiBaB5RTXHwfyDPeyS97DK0UdpFOjOtxARIeNfjDds
 eLtIHIwhx0OGsIbWLr+BYQU3ibitV/67kO30vyF3iXSSk0qoEyKTnr26Dio4mk/3L8Kn
 rEAhwN8h4CKjCGlfWljEl9WjKQS++W+Nt6U0g2jHSWBh/KJZaIYW9P1SbezzDTeeSPGo
 NrRCPREDfV7JqUXRmA5Di2kxMe7HJTUXYAybURgLCtuaThBy9ngYWTXHGHcYUqS5QXVd
 MaY0MeE5mux20+SNaxMylQBHZ+fQ/R6abk12garCefmzOBD8RS606+0+Pll+wcpR2WLD
 2jpQ==
X-Gm-Message-State: AOJu0YzWlldBe6E+HlVF9g64VQkwx8vcJWn4fS95O0lJKMPbb8zJ37RC
 j7fwmJjNe0vKw9l27pW0jntY30w5jAENt12WfytiR7z1tbXlhWx//fPLOAuWLbwNWLViBE7ViHJ
 FPEq1YW2x5PN8K3KiKRUx5JZPsvXpyqsNJpRJ7A==
X-Google-Smtp-Source: AGHT+IH49Dd+mh5CVRitNjCOnko3gKIuc34SG0FlsFu4RxBjpQsHWdpYb5zH6lEZNPu1C5vgWJHi+Jj6Hc203pOyjZk=
X-Received: by 2002:a05:6a20:2d0a:b0:1cf:2513:8a01 with SMTP id
 adf61e73a8af0-1cf75f0f0cfmr29906449637.26.1726675350204; Wed, 18 Sep 2024
 09:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-15-patrick.rudolph@9elements.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Sep 2024 19:01:53 +0300
Message-ID: <CAC_iWj+WmwK--1UTpEg4AhTzmNhz1+bHTXeXHuuEEM0BtQ9qUQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
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

Hi Partick,

I haven't seen any replies in [0]. The same comments apply to this version.
Also, the changelog seems like it's the v2 one?

On Wed, 18 Sept 2024 at 18:22, Patrick Rudolph
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

[0] https://lore.kernel.org/u-boot/CAC_iWjLfbXHFd7zs0xsVamXua8GXsAbhBstgTQEQN1+t8Fr2QA@mail.gmail.com/

Thanks
/Ilias
