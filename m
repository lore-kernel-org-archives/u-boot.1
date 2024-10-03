Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1718FCF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5236F88CFB;
	Thu,  3 Oct 2024 17:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kqhgfJQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3D488C0F; Thu,  3 Oct 2024 17:59:30 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC3488DB8
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20b7a4336easo7762775ad.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727971166; x=1728575966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iYq+FxS86Iv02dxkaMgQ/YXgZI+Jn36jTPzgB6IlzvI=;
 b=kqhgfJQJxY7Jz2GJ0CXFMTrsvLr+YaZjI3cPAsX55zkynB9Z+m+EVuClI0Y8O5j4lb
 NTgpl7r2yUUvBV/ute4gpzpONpWjWdxZh4ex7OGU4xn4p03DKpuMzvlAE5Ywpegcswhi
 yxuA2dinvFPif3U7VK9e4806wf+eNYmeitIGKVv/9+gJ8sG9nUlOYZGelRPrUe+PQE0C
 BXphp59nOgItdCscOV88u+xA2HH9TbfuDQUREJlre+SB7EHkizuR5UoikX1GwSZNI1ta
 xMkZuOfoXVE6y+D7BfvW6Y4K1rmh28DUneu9DZaaT7QZSukopagcgCOct06qq3LDJaJS
 iLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727971166; x=1728575966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iYq+FxS86Iv02dxkaMgQ/YXgZI+Jn36jTPzgB6IlzvI=;
 b=tLb9a4Hg3OXoUXNce8haVB+GyMRSBg+pKAzvr/2ymY47ThXBgkCBKSJvDdHml4RyMF
 hc6KQDLW/JtIfqCh6+vvNBQ7bFCbkJidG7CabGw6G+SMIUYudh2OrX3zvs2yWcCuB/b4
 qcKbQscBEPMK7abQBYA2AakBc1WkinXaNZPHGNfjFjTIO024YdypdP1KfWgJEWqaRyDS
 8CHDXH8IqDSJ7u5n52MXDxYXlqN6uymr2Hllid9b4z8pOSlHKjPiqaDQ2RXcWM600SsE
 05jMMb0zUFWCrNSx00O+dwUMkOOVhs6myF51ZhlFD9a2BtIgAt0XQPH5zLvWQsK+CH+R
 XUbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDBvBEzCx2IiiyHdgewOljzvq82VXPyyTB8uym89mHZ+nJIX1I4r5LmPp2TP6CE8gVA/6fAOI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyfr8M2cXkoCyZ7PtRZUOtecHTrzx5XM3kabQi2/RTj8WTfzqSZ
 M6D8PMjK+jnPaRsKa9sVWIH6PX+4qCJWUG8mom1crnypoIv0VIGulqtHeHhr/PEQgJSw09W8VOu
 0Ao2wtbwSWp9Kzsrl68M/qQDBs0CE79rlb747YzuunJ7eH7ZG
X-Google-Smtp-Source: AGHT+IH3BM/cW8+1Km1WwGMZyQmLPJkYFVOwTn1//fy93gBrRA1B2VqtqY7LXQq6xfIcxa7Li+RtGwrWZ7miOmjaNuo=
X-Received: by 2002:a17:902:d4c1:b0:20b:59ae:fe08 with SMTP id
 d9443c01a7336-20bc5a5cc27mr88148155ad.42.1727971166309; Thu, 03 Oct 2024
 08:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-15-patrick.rudolph@9elements.com>
 <CAC_iWj+7uvnJp17LiFpc7TZYGdoH9Y_kroWLPGVzC2m5BeTAhA@mail.gmail.com>
 <CAFLszTiKi7+8NmihLqdvuS6fH6Jp2+4PZG6GHK1wNoRnQZx0SA@mail.gmail.com>
In-Reply-To: <CAFLszTiKi7+8NmihLqdvuS6fH6Jp2+4PZG6GHK1wNoRnQZx0SA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Oct 2024 18:58:49 +0300
Message-ID: <CAC_iWjJDg+A4Gx5fcHSyyYX_0eEfXKojRJJG99_w3P-jLTGydw@mail.gmail.com>
Subject: Re: [PATCH v6 14/37] efi_loader: Allocate and write ACPI tables
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

On Thu, 3 Oct 2024 at 16:49, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 2 Oct 2024 at 23:45, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Patrick,
> >
> > We've been back and forth on this, but we still disagree on the
> > allocations etc, but I don't think it's that important to keep the
> > patch out due to this.
> >
> > Can we move the table generation to the ACPI subsystem?
> > efi_acpi_register() will convert the memory as needed, so I was
> > wondering why the creation itself can't be done there. If you simply
> > fill table_start_high/table_end_hi, EFI will install the config tables
> > properly
>
> Yes, that's a good idea. The whole function can just move to
> lib/acpi/acpi_writer.c perhaps?

I haven't chedk the ACPI stuff to have an opinion. The description on
that file matches that

Regards
/Ilias
>
> Regards,
> SImon
>
> >
> > Thanks
> > /Ilias
> >
> > On Wed, 2 Oct 2024 at 12:52, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Allocate memory for ACPI tables inside the efi_loader and write out
> > > the tables similar to SMBIOS tables. When ACPI is enabled and wasn't
> > > installed in other places, install the ACPI table in EFI. Since EFI
> > > is necessary to pass the ACPI table location when FDT isn't used,
> > > there's no need to install it separately.
> > >
> > > When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> > > bloblist. The tables are still passed to the OS using EFI.
> > >
> > > This allows non x86 platforms to boot using ACPI only in case the
> > > EFI loader is being used.
> > >
> > > TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > ---
> > > Changelog v3:
> > > - Drop memalign and use efi_allocate_pages
> > > - Use log_debug instead of debug
> > > - Clarify commit message
> > > - Skip writing ACPI tables on sandbox
> > > - Rename function
> > > - Add function comment
> > >
> > > Changelog v6:
> > > - Update header order
> > >
> > > ---
> > >  lib/efi_loader/efi_acpi.c        | 76 ++++++++++++++++++++++++++++++++
> > >  test/py/tests/test_event_dump.py |  1 +
> > >  2 files changed, 77 insertions(+)
> > >
> > > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > > index 67bd7f8ca2..c11abe17b6 100644
> > > --- a/lib/efi_loader/efi_acpi.c
> > > +++ b/lib/efi_loader/efi_acpi.c
> > > @@ -6,15 +6,23 @@
> > >   */
> > >
> > >  #include <efi_loader.h>
> > > +#include <bloblist.h>
> > >  #include <log.h>
> > > +#include <malloc.h>
> > >  #include <mapmem.h>
> > >  #include <acpi/acpi_table.h>
> > >  #include <asm/global_data.h>
> > > +#include <asm/io.h>
> > > +#include <linux/sizes.h>
> > > +#include <linux/log2.h>
> > >
> > >  DECLARE_GLOBAL_DATA_PTR;
> > >
> > >  static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
> > >
> > > +enum {
> > > +       TABLE_SIZE      = SZ_64K,
> > > +};
> > >  /*
> > >   * Install the ACPI table as a configuration table.
> > >   *
> > > @@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
> > >         return efi_install_configuration_table(&acpi_guid,
> > >                                                (void *)(ulong)addr);
> > >  }
> > > +
> > > +/*
> > > + * Allocate memory for ACPI tables and write ACPI tables to the
> > > + * allocated buffer.
> > > + *
> > > + * Return:     status code
> > > + */
> > > +static int alloc_write_acpi_tables(void)
> > > +{
> > > +       u64 table_addr, table_end;
> > > +       u64 new_acpi_addr = 0;
> > > +       efi_uintn_t pages;
> > > +       efi_status_t ret;
> > > +       void *addr;
> > > +
> > > +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> > > +               return 0;
> > > +
> > > +       if (IS_ENABLED(CONFIG_X86) ||
> > > +           IS_ENABLED(CONFIG_QFW_ACPI) ||
> > > +           IS_ENABLED(CONFIG_SANDBOX)) {
> > > +               log_debug("Skipping writing ACPI tables as already done\n");
> > > +               return 0;
> > > +       }
> > > +
> > > +       /* Align the table to a 4KB boundary to keep EFI happy */
> > > +       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> > > +               addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> > > +                                   ilog2(SZ_4K));
> > > +
> > > +               if (!addr)
> > > +                       return log_msg_ret("mem", -ENOMEM);
> > > +       } else {
> > > +               pages = efi_size_in_pages(TABLE_SIZE);
> > > +
> > > +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > > +                                        pages, &new_acpi_addr);
> > > +               if (ret != EFI_SUCCESS)
> > > +                       return log_msg_ret("mem", -ENOMEM);
> > > +
> > > +               addr = (void *)(uintptr_t)new_acpi_addr;
> > > +       }
> > > +
> > > +       table_addr = virt_to_phys(addr);
> > > +
> > > +       gd->arch.table_start_high = table_addr;
> > > +
> > > +       table_end = write_acpi_tables(table_addr);
> > > +       if (!table_end) {
> > > +               log_err("Can't create ACPI configuration table\n");
> > > +               return -EINTR;
> > > +       }
> > > +
> > > +       log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, table_end);
> > > +       if (table_end - table_addr > TABLE_SIZE) {
> > > +               log_err("Out of space for configuration tables: need %llx, have %x\n",
> > > +                       table_end - table_addr, TABLE_SIZE);
> > > +               return log_msg_ret("acpi", -ENOSPC);
> > > +       }
> > > +       gd->arch.table_end_high = table_end;
> > > +
> > > +       log_debug("- done writing tables\n");
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
> > > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> > > index e282c67335..459bfa26bb 100644
> > > --- a/test/py/tests/test_event_dump.py
> > > +++ b/test/py/tests/test_event_dump.py
> > > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> > >  --------------------  ------------------------------  ------------------------------
> > >  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
> > >  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> > > +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader/efi_acpi.c:.*
> > >  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
> > >  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
> > >  EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> > > --
> > > 2.46.2
> > >
