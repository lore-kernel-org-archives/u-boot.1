Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25509EE6451
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5BF88DF0;
	Thu, 12 Sep 2024 08:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZFXleyEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A5B88E29; Thu, 12 Sep 2024 08:56:42 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F64D88B67
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71911585911so492283b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124198; x=1726728998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+HfMsEfJxQDIodi+/lpYtwmOUSzNjsmHZizc8Ocy1/Y=;
 b=ZFXleyEtb2R0R4SkoQHBHEqFMgh3DFO76mrU31/N1vfJZ4yihh22N/YsgewDMr1kIj
 bha69NEc+LCjxL2n3XyjqOQrAeNKK5BSace4+GMQdBLpaz+EuL3AoWfBDVwQHaTTEkNM
 nem7UeZBuHDx6y5YlrUOLnNTdq6uC/j7C0qYnZyba2TbMB7HKdX7UPenykHup7W7EeLo
 KaPLSLs/T82EmcEmunOsVaKoEZ1vPGdf4KnmCFbMVY/F5AI2WoimMkBk5vs3NzvCmJ6Z
 mIghLAHu2vJTenkCUV5kZ7GEDqj+pkamQ72tgrRaez/UdJZwSqrimqGfzyTDqeRxraS0
 n8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124198; x=1726728998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+HfMsEfJxQDIodi+/lpYtwmOUSzNjsmHZizc8Ocy1/Y=;
 b=LS7XnlDpyNgTSe/k7WVyScpU+t33/Ofj8VbyVw5nU7p3iMUdS/pEslX2K33vD4HnFm
 DVrQ+ZW+4HecmOayIWwFs9UdquVnA6OCu2v+duxhyP0YEEZmEKYCZ8mSHRTGf1xuRvPq
 Fnwzh5fs0dR/dZR03XjbXmszDLWEHR5vMXUE4/PhPwLS1imlSPpRmkecuKskKEBxWmBS
 ullpSj2545Qk6/Tuz0t9KNeTX5pgQaXEPuaa5rLn8BZ8cGTyJRLJjRq8T57HZufthozY
 V1+nrwbYeV0M6KB5VqZU2nXeZq2FV1xlHw9NGH64EVdUf8qoP0EzyI8a7hbGW8i9A67d
 2Kdg==
X-Gm-Message-State: AOJu0YxItl2l6ApmLdNd60KYHKbOmPx0sjeRvffV9N5RQw3YzcBs0yF7
 s7op+y8wBn0FEJLrZh/MhkgvZZQTyIl9mgfgkXJlVqojqL8DprxuPFpxow173RH+On4ur/ONCEz
 A/chDMTgX3Xar4wwi3g/t6BKjQnk2LVy0Xzzdbg==
X-Google-Smtp-Source: AGHT+IHfGI7/9GDlfec7MMT2MxW+YPbUZSZGM/uzYzJ0yecEH7ALuHnlRsV3qnl2iFQhn9Eyh5wv2mS8hUKVClzqyE0=
X-Received: by 2002:a05:6a00:148d:b0:70d:2fb5:f996 with SMTP id
 d2e1a72fcca58-7192606e357mr2968634b3a.11.1726124197894; Wed, 11 Sep 2024
 23:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
 <CAC_iWjLfbXHFd7zs0xsVamXua8GXsAbhBstgTQEQN1+t8Fr2QA@mail.gmail.com>
In-Reply-To: <CAC_iWjLfbXHFd7zs0xsVamXua8GXsAbhBstgTQEQN1+t8Fr2QA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Sep 2024 09:56:01 +0300
Message-ID: <CAC_iWjJG9h=gcRG0+Y4HfYPSTzwduPzyeLcv7eU73YUF6+QMtQ@mail.gmail.com>
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

Oh and can you please cc me on the entire series, it's overall very
interesting to me

Thanks
/Ilias

On Thu, 12 Sept 2024 at 09:54, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Patrick
>
> On Wed, 11 Sept 2024 at 09:25, Patrick Rudolph
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
>
> This addr is not in ACPI_RECLAIM_MEMORY now. It might work since
> efi_acpi_register() adads it on the EFI memory map.
> In the last version, Simon replied something along the lines of  "This
> is how x86 works", but I don't understand why. U-Boot at this point is
> the last bootloader you'll run and then jump to your EFI payload. Can
> someone clearly explain what's going on here?
>
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
>
> So this would be fine if we initialized the EFI subsystem early, but
> we don't.  On top of that the efi_acpi_register() call is trying to
> add the allocated memory to the efi memmap, so we don't need to do
> that twice.
>
> I think there's a cleaner approach overall to this which will allow us
> to decouple the installation etc from EFI.
> You could allocate a piece of memory, assign it to
> arch.table_start/end and then tweak efi_acpi_register(). Instead of
> marking the table_end - table_start as ACPI_RECLAIM_MEMORY, allocate
> the pages there, where you know the EFI subsystem is up and copy it.
> It would then be the callers responsibilty to free that memory.
>
> Heinrich, do you see a problem with that?
>
> Thanks
> /Ilias
>
> > +       }
> > +
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
