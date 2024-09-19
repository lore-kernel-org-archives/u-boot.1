Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6384CCE8D7D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51E6884D2;
	Thu, 19 Sep 2024 14:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="YK1YSxoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41463890E9; Thu, 19 Sep 2024 14:45:45 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997CB8841E
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 14:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so7357465e9.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726749942; x=1727354742; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FSO1P/Giou6XFU9QUweimL5zJUkYUzqP2Z+MTVVsTI=;
 b=YK1YSxocEKmcNtcUfWn3vWkBQRkqyBplQh3U1ujxyYMYTB+bkcbMu4TLooZI8aOdkb
 zrUA0ZkFONq7C8JH6NR0SAnitLug5P98LWIpZC4/2dff6TMIe3IUr4bNdmpzUYnwjY40
 CJ/g4nhjKZa9sfOa4s8F8Yx72RzLYxH3YhDGRpqhAzwtZRhqOLcHptNLvLSYpbZB+jRC
 ycS44J9rcJx2yo7KqFnFzc75C4Kjo/LBgNTdeyFZX8JYem/yjBZ3TvpYIgQtpq6eTAHf
 eDVan5BDUqBqiXcRtGZVf5kRS3dP61aKl8muvgv5LAemnycdYuetNdkZ/zan+uhiacPu
 kzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726749942; x=1727354742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FSO1P/Giou6XFU9QUweimL5zJUkYUzqP2Z+MTVVsTI=;
 b=EW2S8eiPm+IPMp0KkZT49T+Pu0VwLlDHOBOjCP1DXjXtWPeFsy7hjCp5WL/csLmxx9
 faP0CHQubLqtCnb3tk5dUGyGl96jxXRASFs4bAgMMWixPhs9syIn2Dsq+S+VZrGXU6M7
 RCPHKrwi8kONR16OqRtHJ/mUER5ZBmP9QKmgtLlvZz8uC7OOoGXBqjjQgrof9ausuk/p
 /hbFmB8UuHo9axukuFgaFTea8jtRs/UHvIfK5slbU0ppkB37KRzNJQNr8Irw3BasVRjM
 dLnRDqVoiUfCoiXEwufJPeD3d9WEFWPGXNXVnoJt+ES9iaZ0+X4waPXqFPXTDpe7Olra
 ZmaA==
X-Gm-Message-State: AOJu0YwGEVasJpWND5NkSQBJuY5/DRo3F1DjI6zUhrEHNlqbrPKO7JO7
 F0fIygd8R5rN1CfguBOh2wKUYjKSU6s4T3y5zhQPbX7QFumrLcGoFi3FXHr2oBsJiZq/WhDuvGB
 anWnV06iwkveblH+2mY56zMtVwqatYHpVuflatA==
X-Google-Smtp-Source: AGHT+IEpEb3uPHlCv84Swy2j58txTQgaYw/mjMKtB0YIj8QRFqlfmjZLwSsZmQMsBSpo5AlzOWQ+VMxibZQ+JwhHvsg=
X-Received: by 2002:adf:ef87:0:b0:376:37e:2729 with SMTP id
 ffacd0b85a97d-378c2d1215fmr16735609f8f.31.1726749941995; Thu, 19 Sep 2024
 05:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
 <ce2fa4a5-bb75-4dae-b035-405af0870991@gmx.de>
In-Reply-To: <ce2fa4a5-bb75-4dae-b035-405af0870991@gmx.de>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 19 Sep 2024 14:45:30 +0200
Message-ID: <CALNFmy2B_iObakJ83eXYvPEOJ4Ecf20-8S=s30fpBQwnwPNhMQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 19, 2024 at 2:39=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 11.09.24 08:24, Patrick Rudolph wrote:
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
>
> Could you, please, describe how QEMU SBSA is passing the ACPI table to
> U-Boot and where you convert this to a bloblist. I could not find this
> in patches 1-13.

I doesn't. All ACPI tables are generated within U-Boot.

>
> Please, provide a test that we can run on our CI.
How would such a test look like?

>
> Best regards
>
> Heinrich
>
> > ---
> > Changelog v3:
> > - Drop memalign and use efi_allocate_pages
> > - Use log_debug instead of debug
> > - Clarify commit message
> > - Skip writing ACPI tables on sandbox
> > - Rename function
> > - Add function comment
> > ---
> >   lib/efi_loader/efi_acpi.c        | 80 +++++++++++++++++++++++++++++++=
-
> >   test/py/tests/test_event_dump.py |  1 +
> >   2 files changed, 79 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > index 67bd7f8ca2..9d38d0060c 100644
> > --- a/lib/efi_loader/efi_acpi.c
> > +++ b/lib/efi_loader/efi_acpi.c
> > @@ -6,15 +6,23 @@
> >    */
> >
> >   #include <efi_loader.h>
> > -#include <log.h>
> > -#include <mapmem.h>
> >   #include <acpi/acpi_table.h>
> >   #include <asm/global_data.h>
> > +#include <asm/io.h>
> > +#include <bloblist.h>
> > +#include <linux/sizes.h>
> > +#include <linux/log2.h>
> > +#include <log.h>
> > +#include <malloc.h>
> > +#include <mapmem.h>
> >
> >   DECLARE_GLOBAL_DATA_PTR;
> >
> >   static const efi_guid_t acpi_guid =3D EFI_ACPI_TABLE_GUID;
> >
> > +enum {
> > +     TABLE_SIZE      =3D SZ_64K,
> > +};
> >   /*
> >    * Install the ACPI table as a configuration table.
> >    *
> > @@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
> >       return efi_install_configuration_table(&acpi_guid,
> >                                              (void *)(ulong)addr);
> >   }
> > +
> > +/*
> > + * Allocate memory for ACPI tables and write ACPI tables to the
> > + * allocated buffer.
> > + *
> > + * Return:   status code
> > + */
> > +static int alloc_write_acpi_tables(void)
> > +{
> > +     u64 table_addr, table_end;
> > +     u64 new_acpi_addr =3D 0;
> > +     efi_uintn_t pages;
> > +     efi_status_t ret;
> > +     void *addr;
> > +
> > +     if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> > +             return 0;
> > +
> > +     if (IS_ENABLED(CONFIG_X86) ||
> > +         IS_ENABLED(CONFIG_QFW_ACPI) ||
> > +         IS_ENABLED(CONFIG_SANDBOX)) {
> > +             log_debug("Skipping writing ACPI tables as already done\n=
");
> > +             return 0;
> > +     }
> > +
> > +     /* Align the table to a 4KB boundary to keep EFI happy */
> > +     if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> > +             addr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> > +                                 ilog2(SZ_4K));
> > +
> > +             if (!addr)
> > +                     return log_msg_ret("mem", -ENOMEM);
> > +     } else {
> > +             pages =3D efi_size_in_pages(TABLE_SIZE);
> > +
> > +             ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > +                                      EFI_ACPI_RECLAIM_MEMORY,
> > +                                      pages, &new_acpi_addr);
> > +             if (ret !=3D EFI_SUCCESS)
> > +                     return log_msg_ret("mem", -ENOMEM);
> > +
> > +             addr =3D (void *)(uintptr_t)new_acpi_addr;
> > +     }
> > +
> > +     table_addr =3D virt_to_phys(addr);
> > +
> > +     gd->arch.table_start_high =3D table_addr;
> > +
> > +     table_end =3D write_acpi_tables(table_addr);
> > +     if (!table_end) {
> > +             log_err("Can't create ACPI configuration table\n");
> > +             return -EINTR;
> > +     }
> > +
> > +     log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, table=
_end);
> > +     if (table_end - table_addr > TABLE_SIZE) {
> > +             log_err("Out of space for configuration tables: need %llx=
, have %x\n",
> > +                     table_end - table_addr, TABLE_SIZE);
> > +             return log_msg_ret("acpi", -ENOSPC);
> > +     }
> > +     gd->arch.table_end_high =3D table_end;
> > +
> > +     log_debug("- done writing tables\n");
> > +
> > +     return 0;
> > +}
> > +
> > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
> > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_even=
t_dump.py
> > index e282c67335..459bfa26bb 100644
> > --- a/test/py/tests/test_event_dump.py
> > +++ b/test/py/tests/test_event_dump.py
> > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> >   --------------------  ------------------------------  ---------------=
---------------
> >   EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_requ=
est.c:.*
> >   EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simp=
le_os.c:.*
> > +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader=
/efi_acpi.c:.*
> >   EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loade=
r/efi_smbios.c:.*
> >   EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/=
cpu/start.c:.*
> >   EVT_TEST              h_adder_simple                  .*test/common/e=
vent.c:'''
>
