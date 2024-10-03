Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B280CF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 13:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C75888D14;
	Thu,  3 Oct 2024 15:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V/sEyano";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C169F885B3; Thu,  3 Oct 2024 15:49:32 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6843988D14
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 15:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-45d8f781d05so9569151cf.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727963369; x=1728568169; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y72AJbCrxDvMjkmg9IxxIQzqB708Ldx4RLybsBeW7Sc=;
 b=V/sEyanoZrrnFum6uvsC26uf+eN1dK/X7YhxjPm0g0mG+xWLXjmhx19yml5ZhuffVm
 tHNCM7j0Cz25h99NsJ2b+yZDcAGvXaZOY4bnBBvK2PX9ejiCRxlfsypc6UzoUggKyyni
 0BA5b6/u/i2c6Ku+lurNS94Cgn54nCAJhzW50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727963369; x=1728568169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y72AJbCrxDvMjkmg9IxxIQzqB708Ldx4RLybsBeW7Sc=;
 b=fn7yYA4lwP3wuAFoqNtCEX26GWP7z6vixNe8r4NN1StRWDcysNto+I16l/iAkvZ6pc
 PYdMLneEq1lJafTeMinpg7QXqPDkz4ld0ZA2Qf5XHk/7XCQm9ZYRrwtP36RtN8DXmm78
 /lPk46zJzSSTJYrqXhyTU6QD101Uzf6ioIN7SmLLr1qUpZy/XU7iERw5oKXedq7KYQ8r
 QNsVeS58KuYzZ0TvK6/epuaFku+6CC/wq1ZFe9JjQEpukiZ2CklzCmsVmeACIsHT6cg4
 kNf1RqNzk8GO12uCZ66meO/H/wf8X6nzoJ0kRGLBJGP2qhTS2w+ciEsH94pTG3JpXj+o
 A0Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYl+svZ0f9cuSHneGFRgAEBGmNddKDe2J2OLVrPJqxsfqEKPeFx2WztjhmjF0ZGPPI6xK8/SM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw99WUtp4swoz0yAwnzz9uWc6YXHPE3OCEHfL+Al4N3EXq3PTUs
 MllRwLyA2tIy/84vGMoml9f0OEPAp6X8FWB2m7ocu1hgI9A9ywDU5ypb19ZrhS6GDdWvWtcl26y
 yP/ayAa3AJ8K7jJqKMJeGeKy6ClDL9d1LJASu5jklVowVjpQ=
X-Google-Smtp-Source: AGHT+IEoq3cBBTsCiFXyMIHd2wElH3xqGKCtD6aDhZzXh/S5dq7+xfLRkbUXUqiJHrLJhGRTc4TIT2vb+UZXN2ogwYM=
X-Received: by 2002:a05:6214:3bc9:b0:6c6:9bb9:b435 with SMTP id
 6a1803df08f44-6cb81bba100mr81042696d6.53.1727963369206; Thu, 03 Oct 2024
 06:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-15-patrick.rudolph@9elements.com>
 <CAC_iWj+7uvnJp17LiFpc7TZYGdoH9Y_kroWLPGVzC2m5BeTAhA@mail.gmail.com>
In-Reply-To: <CAC_iWj+7uvnJp17LiFpc7TZYGdoH9Y_kroWLPGVzC2m5BeTAhA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 07:49:18 -0600
Message-ID: <CAFLszTiKi7+8NmihLqdvuS6fH6Jp2+4PZG6GHK1wNoRnQZx0SA@mail.gmail.com>
Subject: Re: [PATCH v6 14/37] efi_loader: Allocate and write ACPI tables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Wed, 2 Oct 2024 at 23:45, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Patrick,
>
> We've been back and forth on this, but we still disagree on the
> allocations etc, but I don't think it's that important to keep the
> patch out due to this.
>
> Can we move the table generation to the ACPI subsystem?
> efi_acpi_register() will convert the memory as needed, so I was
> wondering why the creation itself can't be done there. If you simply
> fill table_start_high/table_end_hi, EFI will install the config tables
> properly

Yes, that's a good idea. The whole function can just move to
lib/acpi/acpi_writer.c perhaps?

Regards,
SImon

>
> Thanks
> /Ilias
>
> On Wed, 2 Oct 2024 at 12:52, Patrick Rudolph
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
> >
> > Changelog v6:
> > - Update header order
> >
> > ---
> >  lib/efi_loader/efi_acpi.c        | 76 ++++++++++++++++++++++++++++++++
> >  test/py/tests/test_event_dump.py |  1 +
> >  2 files changed, 77 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > index 67bd7f8ca2..c11abe17b6 100644
> > --- a/lib/efi_loader/efi_acpi.c
> > +++ b/lib/efi_loader/efi_acpi.c
> > @@ -6,15 +6,23 @@
> >   */
> >
> >  #include <efi_loader.h>
> > +#include <bloblist.h>
> >  #include <log.h>
> > +#include <malloc.h>
> >  #include <mapmem.h>
> >  #include <acpi/acpi_table.h>
> >  #include <asm/global_data.h>
> > +#include <asm/io.h>
> > +#include <linux/sizes.h>
> > +#include <linux/log2.h>
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
> > 2.46.2
> >
