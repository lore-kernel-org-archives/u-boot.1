Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9C1CD4F4C
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 06:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D2F88CFA;
	Mon,  9 Sep 2024 08:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="e3g/B9x5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5607688C70; Mon,  9 Sep 2024 08:43:38 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB15388CFA
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 08:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6bada443ffeso29087417b3.0
 for <u-boot@lists.denx.de>; Sun, 08 Sep 2024 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725864214; x=1726469014; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjdkCYolCAKwOap+AmD9wzn5b0eH/uRRM3huqiz0TDI=;
 b=e3g/B9x54gk12RXBFP0uZKJBtfTTJiRphfI7XWhUWLlZws7BLdmn/oeVf2pxr3gkaC
 hnsoFowZdXSHk96dKdOt2M01CV0whrdhiZqNvZWmrIc8HMvT+wHqmnOMFdBZf6lHBnXw
 9jjFlgq88k6h4vCHvzk6TU++X/wKUXT3WCRxni/puDpVs7/8rTOc2ptn0WBRclOMp1NM
 sdAPKYWZQoPcCs/xtzY+WXTJE9dcmZ0fhcht8p2jZRtpEO5mceRr1ZixaANWeuG0c0QZ
 2RN57OjreWYKiM+55TfxbL+N4c3r/cQdBlS4o+h6Be9P830op1bpj5tSxWiOhb3haS/+
 iArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725864214; x=1726469014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UjdkCYolCAKwOap+AmD9wzn5b0eH/uRRM3huqiz0TDI=;
 b=g6nPPhB8G/3B3lQlm6AKKjUOwbduyySwosq4EK6ye91XY5T3RtXIrlWwMZ4iKTGDAa
 66XVBZ4qfalRjAMl3TNWSb2Us8y7UWRejWdXBi96ELlI4re++gm4UpxN+adnzPUYd9VT
 lWPqSnTJCQ8E5MJWPduvLlOmj6Kvh8GjoYIU//ha6Zt9fi6pSQaghD57CbYm1SDvGOEV
 BrQbT8G0tCHEgCod6ou9IBOqxjJFM84GLPkMa01Wq9kjS+7tZCc1WJtp4GS3jOYv4bir
 ZegZWwZn7wA0qHl7L89kgTCk9GL1vWFSSU2M37BHIRZda5Lg9/EXfl0q4+COYuJgH25n
 R4Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9FVmtgirrYNgf/xA3JeMyfQqakJhWF+J6GZjcbRRkKF68snGkWxRIwHCsYRX+NDs44Q3rU1I=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3wUeERERJie3Ull4NfKwDRF7Hf8zvXAB6MtL3MLLxn1TGjD0o
 0s566gFwD+JltUf/8RJgGJbp/GGv7aArW4F4om4a/AFCevov5uZ3o8JhQvay3oRkcYtRGtbhCeM
 iCHyfTOBddUwjynZGtrji72Gu8686xkjoQj9w9Q==
X-Google-Smtp-Source: AGHT+IFaAPrQ9CW2WQKd7EB8ONz5CRUxIPLXZ5nHqlywkz0OkRtgdRnOAfAwSMQZio71x9nuRcjt3f+Nv0sVHYL6Cjk=
X-Received: by 2002:a05:690c:f0b:b0:6d0:f91e:2ffa with SMTP id
 00721157ae682-6db442a64a8mr80644787b3.3.1725864213751; Sun, 08 Sep 2024
 23:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
 <20240906072231.2531491-15-patrick.rudolph@9elements.com>
 <adbefd8b-9d14-42f0-9a20-83416bf671c9@gmx.de>
In-Reply-To: <adbefd8b-9d14-42f0-9a20-83416bf671c9@gmx.de>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 9 Sep 2024 08:43:22 +0200
Message-ID: <CALNFmy1+vkq2gQtO0LytKEA5cvKxEoG_u3TkkZhbLiYGMj0u6g@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] efi_loader: Install ACPI tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de, 
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com, 
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Fri, Sep 6, 2024 at 12:44=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 9/6/24 09:22, Patrick Rudolph wrote:
> > Install ACPI tables inside the efi_loader similar to SMBIOS tables.
> > When ACPI is enabled and wasn't installed in other places, install
> > the ACPI table in EFI. Since EFI is necessary to pass the ACPI
> > table location when FDT isn't used, there's no need to install it
> > separately.
> >
> > When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> > bloblist.
>
> The UEFI specification clearly describes how to hand over ACPI tables. I
> can't see why bloblists should be of any relevance in the UEFI context.
>
It's where tables are stored, not how to pass them to the OS.

> >
> > TEST: Booted QEMU SBSA using EFI and ACPI only.
>
> With this description it is unclear if you used QFW to install ACPI
> tables which would not test the code below.
>
QEMU SBSA implies that no QFW was used. Will update the commit message.

> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
>
> Please, cc maintainers as reported by scripts/get_maintainers in future.
>
Thanks, will do.

> > ---
> >   lib/efi_loader/efi_acpi.c        | 57 ++++++++++++++++++++++++++++++-=
-
> >   test/py/tests/test_event_dump.py |  1 +
> >   2 files changed, 56 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > index 67bd7f8ca2..9262f21ea6 100644
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
> > @@ -47,3 +55,48 @@ efi_status_t efi_acpi_register(void)
> >       return efi_install_configuration_table(&acpi_guid,
> >                                              (void *)(ulong)addr);
> >   }
> > +
>
> Please, provide a function description.
>
> > +static int install_acpi_table(void)
> > +{
> > +     u64 rom_addr, rom_table_end;
>
> There is no ROM involved here. Please, use meaningful variable names.
>
> > +     void *addr;
> > +
> > +     if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE) ||
> > +         IS_ENABLED(CONFIG_X86) ||
> > +         IS_ENABLED(CONFIG_QFW_ACPI))
>
> Why would you want to call write_acpi_tables() twice on the sandbox? See
>
> board/sandbox/sandbox.c:180:
>              end =3D write_acpi_tables(addr);
>
> We should remove the redundant code from board/sandbox/sandbox.c with
> this patch.
>
Missed that, thanks!

> > +             return 0;
> > +
> > +     /* Align the table to a 4KB boundary to keep EFI happy */
> > +     if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > +             addr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> > +                                 ilog2(SZ_4K));
> > +     else
> > +             addr =3D memalign(SZ_4K, TABLE_SIZE);
>
> The UEFI specification wants ACPI tables to reside in
> EfiACPIReclaimMemory. Neither bloblist_add() nor memalign() should be
> used here.
>
> > +
> > +     if (!addr)
> > +             return log_msg_ret("mem", -ENOBUFS);
> > +
> > +     rom_addr =3D virt_to_phys(addr);
> > +
> > +     gd->arch.table_start_high =3D rom_addr;
> > +
> > +     rom_table_end =3D write_acpi_tables(rom_addr);
> > +     if (!rom_table_end) {
> > +             log_err("Can't create ACPI configuration table\n");
> > +             return -EINTR;
> > +     }
> > +
> > +     debug("- wrote 'acpi' to %llx, end %llx\n", rom_addr, rom_table_e=
nd);
>
> Please, use log_debug().
>
> > +     if (rom_table_end - rom_addr > TABLE_SIZE) {
> > +             log_err("Out of space for configuration tables: need %llx=
, have %x\n",
>
> This check is too late. We must ensure that write_acpi_table() does not
> overwrite unallocated memory.
>
At least there's a check.
> > +                     rom_table_end - rom_addr, TABLE_SIZE);
> > +             return log_msg_ret("acpi", -ENOSPC);
> > +     }
> > +     gd->arch.table_end_high =3D rom_table_end;
> > +
> > +     debug("- done writing tables\n");
>
> ditto
>
> Best regards
>
> Heinrich
>
> > +
> > +     return 0;
> > +}
> > +
> > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_acpi_table);
> > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_even=
t_dump.py
> > index e282c67335..88bbf34f71 100644
> > --- a/test/py/tests/test_event_dump.py
> > +++ b/test/py/tests/test_event_dump.py
> > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> >   --------------------  ------------------------------  ---------------=
---------------
> >   EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_requ=
est.c:.*
> >   EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simp=
le_os.c:.*
> > +EVT_LAST_STAGE_INIT   install_acpi_table              .*lib/efi_loader=
/efi_acpi.c:.*
> >   EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loade=
r/efi_smbios.c:.*
> >   EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/=
cpu/start.c:.*
> >   EVT_TEST              h_adder_simple                  .*test/common/e=
vent.c:'''
>
