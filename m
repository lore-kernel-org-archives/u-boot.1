Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DACCDD573
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 13:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E36589165;
	Thu, 19 Sep 2024 15:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P2P930FW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCAB38916B; Thu, 19 Sep 2024 15:23:16 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8559789128
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c3567a143eso6280396d6.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726752193; x=1727356993; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B6aJZwKyZHqR88AEvbkM61IAi2H7XUqSNinIvj6LCdM=;
 b=P2P930FWcUMKlMDEdcLNqNjHPPT5yHuITbm27919qSmAkPXcHk8G0Zj4EoaMsXnBRd
 GRzpdWm25L7md0aiqXgh5wuidyKEVqSeFrfiMmKmO4+qqHqJn0X7eEVbUCSBgfblUt0O
 L/fun9SdHnnTX8Wjzn/mmWjn0lRGjwGkStCZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726752193; x=1727356993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6aJZwKyZHqR88AEvbkM61IAi2H7XUqSNinIvj6LCdM=;
 b=N1i+cHATuFBJoCOBnBeg+KxERjHelsoqqr3SFXZ8E8DaUysH6Tw7vRW2aD3+GanoGZ
 AZpPeOCqxgzWQBp8w1YV7wYvRJlGZRjx+CPL7ke2DxG59jCmnIEkoaWlfFowZJkFMJSa
 Wq1IUwzkxpucByJKXiZSvFOTLRxJVCwBbk545uwb9Mz+CrVHFzLd3m1dRRNugUlkcca1
 jE6VuI5CQLZg0Ip5VcIAzKzfrN4SEUdwjl0splePXwrO84EiObxKb8NaKuzkd8s+l/oE
 WSTVhOshd1CbiwgwRRs1lYw/7NBQ294D07B3mCKW1VnB5XpegLOJePQ0fYWSLTY5ZQOc
 fdHA==
X-Gm-Message-State: AOJu0YzeO2NhUcJBNqgbcOE3LIiAS0IPO39Wf5eYLkmsRfssWSE3VM2U
 h/HvMs8m8P6/s+s8CzhKWZqxf/LWTB5v2Pe7byiW1/GvPEFA43WfeVDX/+MwTVibkoMTUJGA/4N
 1RQi1EmP35P/GEiusl/BUKi8UTMCQpaFKoTbi
X-Google-Smtp-Source: AGHT+IEztKZSRNAZMSIN6V7y7jUF497Mp6azGUiNMCZ7wi2u0/frCeV8ySpt5slerQTU7j1iYM4VuOroGLJJa6FapO8=
X-Received: by 2002:a05:6214:390a:b0:6bf:7d3c:a64d with SMTP id
 6a1803df08f44-6c573570b31mr363971196d6.32.1726752193263; Thu, 19 Sep 2024
 06:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
 <CAFLszTiaaP9goTUQiVJ3MQkzegDAmac-AWmtip38eLhMoC15xg@mail.gmail.com>
 <d33b38d1-830e-46f0-939d-c5f662bf4193@gmx.de>
In-Reply-To: <d33b38d1-830e-46f0-939d-c5f662bf4193@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 15:23:02 +0200
Message-ID: <CAFLszTjztGL1GLEyLjjW0D3amp6sNHBOoiw8a28cHLwhSXj4MA@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Heinrich,

On Thu, 19 Sept 2024 at 14:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12.09.24 02:58, Simon Glass wrote:
> > Hi Patrick,
> >
> > On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> >>
> >> Allocate memory for ACPI tables inside the efi_loader and write out
> >> the tables similar to SMBIOS tables. When ACPI is enabled and wasn't
> >> installed in other places, install the ACPI table in EFI. Since EFI
> >> is necessary to pass the ACPI table location when FDT isn't used,
> >> there's no need to install it separately.
> >>
> >> When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> >> bloblist. The tables are still passed to the OS using EFI.
> >>
> >> This allows non x86 platforms to boot using ACPI only in case the
> >> EFI loader is being used.
> >>
> >> TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
> >>
> >> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> ---
> >> Changelog v3:
> >> - Drop memalign and use efi_allocate_pages
> >> - Use log_debug instead of debug
> >> - Clarify commit message
> >> - Skip writing ACPI tables on sandbox
> >> - Rename function
> >> - Add function comment
> >> ---
> >>   lib/efi_loader/efi_acpi.c        | 80 +++++++++++++++++++++++++++++++-
> >>   test/py/tests/test_event_dump.py |  1 +
> >>   2 files changed, 79 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> >> index 67bd7f8ca2..9d38d0060c 100644
> >> --- a/lib/efi_loader/efi_acpi.c
> >> +++ b/lib/efi_loader/efi_acpi.c
> >> @@ -6,15 +6,23 @@
> >>    */
> >>
> >>   #include <efi_loader.h>
> >> -#include <log.h>
> >> -#include <mapmem.h>
> >>   #include <acpi/acpi_table.h>
> >>   #include <asm/global_data.h>
> >> +#include <asm/io.h>
> >> +#include <bloblist.h>
> >> +#include <linux/sizes.h>
> >> +#include <linux/log2.h>
> >> +#include <log.h>
> >> +#include <malloc.h>
> >> +#include <mapmem.h>
> >>
> >>   DECLARE_GLOBAL_DATA_PTR;
> >>
> >>   static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
> >>
> >> +enum {
> >> +       TABLE_SIZE      = SZ_64K,
> >> +};
> >>   /*
> >>    * Install the ACPI table as a configuration table.
> >>    *
> >> @@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
> >>          return efi_install_configuration_table(&acpi_guid,
> >>                                                 (void *)(ulong)addr);
> >>   }
> >> +
> >> +/*
> >> + * Allocate memory for ACPI tables and write ACPI tables to the
> >> + * allocated buffer.
> >> + *
> >> + * Return:     status code
> >> + */
> >> +static int alloc_write_acpi_tables(void)
> >> +{
> >> +       u64 table_addr, table_end;
> >> +       u64 new_acpi_addr = 0;
> >> +       efi_uintn_t pages;
> >> +       efi_status_t ret;
> >> +       void *addr;
> >> +
> >> +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> >> +               return 0;
> >> +
> >> +       if (IS_ENABLED(CONFIG_X86) ||
> >> +           IS_ENABLED(CONFIG_QFW_ACPI) ||
> >> +           IS_ENABLED(CONFIG_SANDBOX)) {
> >> +               log_debug("Skipping writing ACPI tables as already done\n");
> >> +               return 0;
> >> +       }
> >> +
> >> +       /* Align the table to a 4KB boundary to keep EFI happy */
> >> +       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> >> +               addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> >> +                                   ilog2(SZ_4K));
> >> +
> >> +               if (!addr)
> >> +                       return log_msg_ret("mem", -ENOMEM);
> >> +       } else {
> >> +               pages = efi_size_in_pages(TABLE_SIZE);
> >> +
> >> +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> >> +                                        EFI_ACPI_RECLAIM_MEMORY,
> >> +                                        pages, &new_acpi_addr);
> >
> > I know we are going to have a problem here since EFI memory-allocation
> > is a bit of a mess, and you got conflicting advice on the previous
> > version....
> >
> > But we cannot call efi_allocate_pages() during U-Boot init. EFI may
> > not even be enabled. The allocation ends up being in the area between
> > the bottom of memory at the bottom of the stack, which is not supposed
> > to be used, at least until images are loaded.
>
> Please, have a look at init_sequence_r[].
>
> The memory allocate for the EFI sub-system is initialized in
> efi_memory_init directly after initr_lmb.
>
> So for sure we can and should use efi_allocate_pages() here.

No, no. We need to keep the memory free for loading images. I am
working to drop all EFI allocations until an EFI app is actually
booted.

>
> We must not use bloblist_add() as the memory allocation would not be
> reported as AcpiReclaimMemory.

That is the purpose of the efi_add_memory_map() call in
lib/efi_loader/efi_acpi.c

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> >
> > I think in fact we should make this ACPI stuff depend on bloblist and
> > just put the tables there. So set up bloblist size to something small,
> > like 0x100 and set BLOBLIST_SIZE_RELOC to larger than you need (e.g.
> > 68KB). Everything should work OK. I will do a bit of a tidy-up after
> > this series goes in.
> >
> >> +               if (ret != EFI_SUCCESS)
> >> +                       return log_msg_ret("mem", -ENOMEM);
> >> +
> >> +               addr = (void *)(uintptr_t)new_acpi_addr;
> >> +       }
> >> +
> >> +       table_addr = virt_to_phys(addr);
> >> +
> >> +       gd->arch.table_start_high = table_addr;
> >> +
> >> +       table_end = write_acpi_tables(table_addr);
> >> +       if (!table_end) {
> >> +               log_err("Can't create ACPI configuration table\n");
> >> +               return -EINTR;
> >> +       }
> >> +
> >> +       log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, table_end);
> >> +       if (table_end - table_addr > TABLE_SIZE) {
> >> +               log_err("Out of space for configuration tables: need %llx, have %x\n",
> >> +                       table_end - table_addr, TABLE_SIZE);
> >> +               return log_msg_ret("acpi", -ENOSPC);
> >> +       }
> >> +       gd->arch.table_end_high = table_end;
> >> +
> >> +       log_debug("- done writing tables\n");
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
> >> diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> >> index e282c67335..459bfa26bb 100644
> >> --- a/test/py/tests/test_event_dump.py
> >> +++ b/test/py/tests/test_event_dump.py
> >> @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> >>   --------------------  ------------------------------  ------------------------------
> >>   EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
> >>   EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> >> +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader/efi_acpi.c:.*
> >>   EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
> >>   EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
> >>   EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> >> --
> >> 2.46.0
> >>
> >
> > Regards,
> > Simon
>
