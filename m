Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1EECF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E8188FCF;
	Sun, 13 Oct 2024 21:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DDASAVes";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8DB088FEA; Sun, 13 Oct 2024 21:37:19 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9415988FC7
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-460371bfda4so30840781cf.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728848236; x=1729453036; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B00DG3RulDi8u9zhxCklWz7zuy/f9YHRT5Bt9r1ybmA=;
 b=DDASAVesGTyY1LwydBxq8Rs3aPP457M/H5133qwKJ0p6rMC75HI9jgFKbvdonWMItI
 5gtyRsonhnM/+GNP2nAIP5TqyelqburPkzC5UKFneS8gy7ONvDGiptudRw0USugkJe5Y
 WIHgkw3rP41SIOA2yUUB79q8rJpXtlBiK0Sdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728848236; x=1729453036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B00DG3RulDi8u9zhxCklWz7zuy/f9YHRT5Bt9r1ybmA=;
 b=PF9ory/17D8W19ZPZIUpqCHG7WxLnvEKyXmXi4oGX12gW2epgNnsWf3IHqIvsfs6gm
 net2JMRHA+pVX8+8RBkPJEvzcRTSreci0nGXDycRQXpCZI7vBKZqXbocyCfRwRIIYa7e
 CYMhoEcS+QcK5lDhlyGFkCqoIXypJLr3qTHdHIZr9/BoQar0Ir4zidAsQgUDTluKBM//
 pY9sWtsRvcLAJdlgCeShN6WGBN2fCfHuQYFSLV/VH/AmXgJJUqsJ6oxftJdv6ALntq+R
 twrERld/PrnopqaJNUQ+X+AgCASNIvSu/DFFapOO9NBV3VxYK7P60baUEdPU6tFgxqoO
 FfJQ==
X-Gm-Message-State: AOJu0YzoHMD7lhCrRH2k8c2AMFbBK/Nn/JiU3uehbrzFqy5Cbd1aROVn
 FbrnIbzlBwqnaNXY7HIKm47C5oeebBqxwwyzI6rOz0oxapZqrCPSDQ6ITSDe6+7710A2p+e8tk7
 8n/nmIiQWJ+hj6k4BClN+RLD98+wPbnwmAhByaYsM25P5g9Bhv9TG
X-Google-Smtp-Source: AGHT+IEkasB5EcvkY4U2EQbkZcENJz+r5dEwkXha3nmkadJxHMAK91YUt4Cvo6RIZza18LEJLx5doJxWx6PvqSMoZlQ=
X-Received: by 2002:a05:6214:5b82:b0:6cb:d512:e6ea with SMTP id
 6a1803df08f44-6cbeffff43bmr115985466d6.11.1728848236407; Sun, 13 Oct 2024
 12:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
 <20241011102419.12523-15-patrick.rudolph@9elements.com>
In-Reply-To: <20241011102419.12523-15-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 13 Oct 2024 13:37:04 -0600
Message-ID: <CAFLszThPjsk6SwicqAXQN7pci4HVhV4RhnMAXDm2iOKMHcJcHw@mail.gmail.com>
Subject: Re: [PATCH v7 14/37] acpi: Allocate and write ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Fri, 11 Oct 2024 at 04:34, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allocate memory for ACPI tables in generic acpi code. When ACPI wasn't
> installed in other places, install the ACPI table using either BLOBLISTs
> or EFI allocate pages.
>
> This allows non x86 platforms to boot using ACPI only in case the
> EFI loader is being used, since EFI is necessary to advertise the location
> of the ACPI tables in memory.
>
> TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  lib/acpi/acpi_table.c            | 80 +++++++++++++++++++++++++++++++-
>  test/py/tests/test_event_dump.py |  1 +
>  2 files changed, 80 insertions(+), 1 deletion(-)
>
> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> index d6357bdc4d..d8112e58ca 100644
> --- a/lib/acpi/acpi_table.c
> +++ b/lib/acpi/acpi_table.c
> @@ -5,8 +5,11 @@
>   * Copyright 2019 Google LLC
>   */
>
> -#include <dm.h>
> +#include <bloblist.h>
>  #include <cpu.h>
> +#include <dm.h>
> +#include <efi_api.h>
> +#include <efi_loader.h>
>  #include <log.h>
>  #include <mapmem.h>
>  #include <tables_csum.h>
> @@ -16,6 +19,14 @@
>  #include <acpi/acpi_device.h>
>  #include <asm/global_data.h>
>  #include <dm/acpi.h>
> +#include <linux/sizes.h>
> +#include <linux/log2.h>
> +
> +enum {
> +       TABLE_SIZE      = SZ_64K,
> +};
> +
> +DECLARE_GLOBAL_DATA_PTR;
>
>  /*
>   * OEM_REVISION is 32-bit unsigned number. It should be increased only when
> @@ -752,3 +763,70 @@ static int acpi_write_iort(struct acpi_ctx *ctx, const struct acpi_writer *entry
>  }
>
>  ACPI_WRITER(5iort, "IORT", acpi_write_iort, 0);
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
> +       } else if (IS_ENABLED(CONFIG_EFI_LOADER)) {
> +               pages = efi_size_in_pages(TABLE_SIZE);
> +
> +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> +                                        EFI_ACPI_RECLAIM_MEMORY,
> +                                        pages, &new_acpi_addr);
> +               if (ret != EFI_SUCCESS)
> +                       return log_msg_ret("mem", -ENOMEM);
> +
> +               addr = (void *)(uintptr_t)new_acpi_addr;

Please remove the else () part, as discussed before. We don't need it
as the bloblist is always used. We don't want it since EFI is not in
chanre of creating the tables. It also duplicates code in efi_acpi.c
which creates the mapping. You just need to set the table start and
end:

gd->arch.table_start = addr;
gd->arch.table_size = TABLE_SIZE;

> +       } else {
> +               return log_msg_ret("mem", -ENOMEM);
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
> index e282c67335..45143c1c7d 100644
> --- a/test/py/tests/test_event_dump.py
> +++ b/test/py/tests/test_event_dump.py
> @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
>  --------------------  ------------------------------  ------------------------------
>  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
>  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/acpi/acpi_table.c:.*
>  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
>  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
>  EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> --
> 2.46.2
>

Regards,
Simon
