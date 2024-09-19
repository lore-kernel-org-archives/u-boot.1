Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10248CF3959
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C98C89211;
	Thu, 19 Sep 2024 16:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k7lklHa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81AC289217; Thu, 19 Sep 2024 16:40:07 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC6788BBC
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-206aee40676so9339185ad.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726756803; x=1727361603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6u7/Vnr4a/mp7aHAQFitBwfXpLqhjDhL6qKVbOWw4jM=;
 b=k7lklHa517BnDiFuoGRgBlW81JsaBQLHp+dZf3okaFN0Dy4kNSIS3nFWYQFoeag07N
 tesUumPJ9E7/H9VcM1QiOUErRAAGlu5U+sogdCSVA5BxJ0fsykmUOCjb1vbmPEfPXQDz
 /zADxN/Z73PjSTBZx8iVnGETSA3s688JucApb53I+LZh5ncm1a2PR2Yh7rMWyiBm08Mc
 w28meYI4OFdF6E/l6TtntSkj5iSom71FNh1FocdGAHGKSAmmZSAAYitg4EJGnsOo20il
 v8Oj6PCDQRICwQnS2SByCScEIztx9szNJtGrleD4hAwZ2TRm1EgO+Nfd7+NFG2I63xXH
 ETgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726756803; x=1727361603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6u7/Vnr4a/mp7aHAQFitBwfXpLqhjDhL6qKVbOWw4jM=;
 b=MLdj+QPgC+PXHDEmiFLINCA0m7PblBp9MmAQzm5AiPPYWvpfCfABUj6bA6F2zAGwXR
 Ki1DUENMDxH6kSxz8/axRTWlzgkpTWA7ykFCxVG0nIoKEHSbxN4zpKOUDdTjAIOqBzS2
 g5LOiU6CR1/ZaJF+iGEExcSeUkij0ojxN3F8mpD/8z6Bcv7ZH8TXq1LAk4Jqd8nuxM2p
 s2C+i9C+XC61t1LNcGCOKaPWGw8aKdBgtCQS7+0i/uMwgjao5SPAh+HKyGkaPYAUIDvD
 xAJU3v3NhjbzzLcln36JUr63co4NCXNbKWhMcsXcwHXQzW09Oo34wmcZn81dF1OREkIC
 P6BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUba7qOMIneM6EzoJG7f1ztEzk82C4677DFgyOdsE1g8h7FnknYfT8bMI8OgFE1z77Wi60f+2o=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/njxgLx+N92I2FoENgHaeLTsvUJR8ODDqUYg05ODbmlOFd0At
 na1Dw33FPbCswuypdYNCO7i0wD7zHzzXL7j2jQrKXggchX1BVgAWnrFCCuP6RUyao67Jnq7odjT
 yg5l8eVM2E4TCb2zTt7oyrRX+h/skiOr1YFa0M0Jv2xoshdQe
X-Google-Smtp-Source: AGHT+IFqZ/6wqLGuGU/4nPiNsTAky9qTo77XP5ct0dnExEQA07Lf9lj/kEEu3SGUeHbAFz3oaVbdXDyQRT2gkr6zLnc=
X-Received: by 2002:a17:902:ccd1:b0:205:8275:768 with SMTP id
 d9443c01a7336-20782943d29mr314356385ad.21.1726756803218; Thu, 19 Sep 2024
 07:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
In-Reply-To: <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 17:39:26 +0300
Message-ID: <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,


On Thu, 19 Sept 2024 at 17:10, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Patrick,
>
> On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Allocate memory for ACPI tables inside the efi_loader and write out
> > the tables similar to SMBIOS tables. When ACPI is enabled and wasn't
> > installed in other places, install the ACPI table in EFI. Since EFI
> > is necessary to pass the ACPI table location when FDT isn't used,
> > there's no need to install it separately.
> >
> > When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> > bloblist. The tables are still passed to the OS using EFI.
> >
> > This allows non x86 platforms to boot using ACPI only in case the
> > EFI loader is being used.
> >
> > TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> > Changelog v3:
> > - Drop memalign and use efi_allocate_pages
> > - Use log_debug instead of debug
> > - Clarify commit message
> > - Skip writing ACPI tables on sandbox
> > - Rename function
> > - Add function comment
> > ---
> >  lib/efi_loader/efi_acpi.c        | 80 +++++++++++++++++++++++++++++++-
> >  test/py/tests/test_event_dump.py |  1 +
> >  2 files changed, 79 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > index 67bd7f8ca2..9d38d0060c 100644
> > --- a/lib/efi_loader/efi_acpi.c
> > +++ b/lib/efi_loader/efi_acpi.c
> > @@ -6,15 +6,23 @@
> >   */
> >
> >  #include <efi_loader.h>
> > -#include <log.h>
> > -#include <mapmem.h>
> >  #include <acpi/acpi_table.h>
> >  #include <asm/global_data.h>
> > +#include <asm/io.h>
> > +#include <bloblist.h>
> > +#include <linux/sizes.h>
> > +#include <linux/log2.h>
> > +#include <log.h>
> > +#include <malloc.h>
> > +#include <mapmem.h>
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> >  static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
> >
> > +enum {
> > +       TABLE_SIZE      = SZ_64K,
> > +};
> >  /*
> >   * Install the ACPI table as a configuration table.
> >   *
> > @@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
> >         return efi_install_configuration_table(&acpi_guid,
> >                                                (void *)(ulong)addr);
> >  }
> > +
> > +/*
> > + * Allocate memory for ACPI tables and write ACPI tables to the
> > + * allocated buffer.
> > + *
> > + * Return:     status code
> > + */
> > +static int alloc_write_acpi_tables(void)
> > +{
> > +       u64 table_addr, table_end;
> > +       u64 new_acpi_addr = 0;
> > +       efi_uintn_t pages;
> > +       efi_status_t ret;
> > +       void *addr;
> > +
> > +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> > +               return 0;
> > +
> > +       if (IS_ENABLED(CONFIG_X86) ||
> > +           IS_ENABLED(CONFIG_QFW_ACPI) ||
> > +           IS_ENABLED(CONFIG_SANDBOX)) {
> > +               log_debug("Skipping writing ACPI tables as already done\n");
> > +               return 0;
> > +       }
> > +
> > +       /* Align the table to a 4KB boundary to keep EFI happy */
> > +       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> > +               addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> > +                                   ilog2(SZ_4K));
> > +
> > +               if (!addr)
> > +                       return log_msg_ret("mem", -ENOMEM);
> > +       } else {
> > +               pages = efi_size_in_pages(TABLE_SIZE);
> > +
> > +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > +                                        pages, &new_acpi_addr);
> > +               if (ret != EFI_SUCCESS)
> > +                       return log_msg_ret("mem", -ENOMEM);
> > +
> > +               addr = (void *)(uintptr_t)new_acpi_addr;
> > +       }
> > +
>
> The tables should be written regardless of whether EFI_LOADER is enabled.

*Why*? How do you expect to hand them over to the OS?

>
> Can we drop this else clause? We should always use the bloblist.

Both Heinrich and I said the exact opposite. Unless there's a
perfectly good reason why we should keep them in bloblist memory, I'd
like us to do that

Thanks
/Ilias
>
> We should use efi_add_memory_map() to add to the memory map.
>
> > +       table_addr = virt_to_phys(addr);
> > +
> > +       gd->arch.table_start_high = table_addr;
> > +
> > +       table_end = write_acpi_tables(table_addr);
> > +       if (!table_end) {
> > +               log_err("Can't create ACPI configuration table\n");
> > +               return -EINTR;
> > +       }
> > +
> > +       log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, table_end);
> > +       if (table_end - table_addr > TABLE_SIZE) {
> > +               log_err("Out of space for configuration tables: need %llx, have %x\n",
> > +                       table_end - table_addr, TABLE_SIZE);
> > +               return log_msg_ret("acpi", -ENOSPC);
> > +       }
> > +       gd->arch.table_end_high = table_end;
> > +
> > +       log_debug("- done writing tables\n");
> > +
> > +       return 0;
> > +}
> > +
> > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
> > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> > index e282c67335..459bfa26bb 100644
> > --- a/test/py/tests/test_event_dump.py
> > +++ b/test/py/tests/test_event_dump.py
> > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> >  --------------------  ------------------------------  ------------------------------
> >  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
> >  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> > +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader/efi_acpi.c:.*
> >  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
> >  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
> >  EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> > --
> > 2.46.0
> >
>
> REgards,
> Simon
