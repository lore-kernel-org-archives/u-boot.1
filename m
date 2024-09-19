Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C9ECDD573
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 13:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A278916E;
	Thu, 19 Sep 2024 15:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rm3QhW0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7B089163; Thu, 19 Sep 2024 15:18:07 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC4BC89128
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so673110a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751882; x=1727356682; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBh1KOHhErpm1A+WT7/euq+3BzRRSjqrnFNiGhUj0gw=;
 b=rm3QhW0lHwPPwR9DQWPbTCEBzLkoEtjObXm4YFDdaEN2dzQIEoMUebkgGNRQZI2ukb
 UsslQcSzxftOSKjKDkUtphS/RM48lcMptrcJVKZRoI/c7h/OUi/O36efFnNwTuT8v2Xp
 tfBW/O1RaM1YuaA2zIBbRESrWPWdIyQY3EBpRwQzE5BckFt3VcjVZjDEAIGOlmgmfKX+
 ZuiPVf2mXX16fWct259oySa2P/c3AwiksVVrYhc8kTW6D4lZQNGm2vbaZCtDoz9bFNJV
 3qTfcJ5JL1Jl86f04lMA1eV//wsjOb1+ZUtK9ORbRtzXmywg/yKyD6aoyUPgJYmYjSOJ
 nAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751882; x=1727356682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBh1KOHhErpm1A+WT7/euq+3BzRRSjqrnFNiGhUj0gw=;
 b=wGpLxMCTJMt0OLmFGYnPpydAcuvqBtoeV25K8k5XSEvhF164oGfMyR4nKYUvMxT8ZM
 M1/vhkrksZo9HVnX9XOTDCZqt2obzalvMsLTmVCRHzQzZLDIffm5iCdf1YH5mKskgO2k
 7kE4MbF2yy3Kzoo5Uu8UE//MBwkIZBD1dlQadGDVWO4np8lkDlv4af4+gM4GZ6nFegjk
 HRoigZ+TmwAoLOHe0jozAcsY5AkG3RUkkTEi3RkMhGGMvno1dTTFZBO4jXhUs/WOWJ0R
 X2GBDWtA667Ay8coyf960fzJuUCPqv+IDGLPZLzEPTYWsfTBy0iuRY57xGfithUaF00s
 jDpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2MOup55K/+1uPFC9ATyYu/jJyHP+JVvGtfHrrC5MFV7sUeJZ28JfNAOCb+M7Fxtg/BAKiREk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5S+uJpbzq/r7M6xrij3hhAs+SHCz1ntCejKvh54pH2n4kScoo
 4sZOHpF48P8rdxMRQBYHPxR/aMctOwYl5hQDDhQGeu6zEfL/M732fxjPUOpzwpZ7KPnQj70R22w
 JoodGtMSYt9XXBgOTrjG2zcVd3kobAoWeUiT49A==
X-Google-Smtp-Source: AGHT+IFUkdUvjQbf09FXSdUmxrP8QKHnGpeU4a0Lg5GbJ+t+a2jcBnzsOga1KSkqfMUO3a5mtTu6fnFhsO5HfIvzat0=
X-Received: by 2002:a05:6a21:38a:b0:1cf:4572:85d with SMTP id
 adf61e73a8af0-1cf75f28d20mr40316334637.24.1726751882171; Thu, 19 Sep 2024
 06:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
 <CAC_iWjLfbXHFd7zs0xsVamXua8GXsAbhBstgTQEQN1+t8Fr2QA@mail.gmail.com>
 <CALNFmy1b-tdn1DpJ2TpMV+2UU9u4chFcfzMq+-FCxL1VYx05-g@mail.gmail.com>
 <CAC_iWjK-U3R_8rZp37aTZtOSk=tSAa4dL3uFojG-QLJG9jBg+w@mail.gmail.com>
 <CAFLszTieB1RyPiEVdK+hAvitBAwyT95prGo8dAPp3mfU8Of+9Q@mail.gmail.com>
In-Reply-To: <CAFLszTieB1RyPiEVdK+hAvitBAwyT95prGo8dAPp3mfU8Of+9Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 16:17:25 +0300
Message-ID: <CAC_iWjL4wjMvne=0EQkOnT4GxZr=B6tWO2WQq8ZmTJO_OFY2zw@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Thu, 19 Sept 2024 at 16:01, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 19 Sept 2024 at 09:30, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 19 Sept 2024 at 09:41, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > On Thu, Sep 12, 2024 at 8:55=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Patrick
> > > >
> > > > On Wed, 11 Sept 2024 at 09:25, Patrick Rudolph
> > > > <patrick.rudolph@9elements.com> wrote:
> > > > >
> > > > > Allocate memory for ACPI tables inside the efi_loader and write o=
ut
> > > > > the tables similar to SMBIOS tables. When ACPI is enabled and was=
n't
> > > > > installed in other places, install the ACPI table in EFI. Since E=
FI
> > > > > is necessary to pass the ACPI table location when FDT isn't used,
> > > > > there's no need to install it separately.
> > > > >
> > > > > When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> > > > > bloblist. The tables are still passed to the OS using EFI.
> > > > >
> > > > > This allows non x86 platforms to boot using ACPI only in case the
> > > > > EFI loader is being used.
> > > > >
> > > > > TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
> > > > >
> > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > > Changelog v3:
> > > > > - Drop memalign and use efi_allocate_pages
> > > > > - Use log_debug instead of debug
> > > > > - Clarify commit message
> > > > > - Skip writing ACPI tables on sandbox
> > > > > - Rename function
> > > > > - Add function comment
> > > > > ---
> > > > >  lib/efi_loader/efi_acpi.c        | 80 ++++++++++++++++++++++++++=
+++++-
> > > > >  test/py/tests/test_event_dump.py |  1 +
> > > > >  2 files changed, 79 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.=
c
> > > > > index 67bd7f8ca2..9d38d0060c 100644
> > > > > --- a/lib/efi_loader/efi_acpi.c
> > > > > +++ b/lib/efi_loader/efi_acpi.c
> > > > > @@ -6,15 +6,23 @@
> > > > >   */
> > > > >
> > > > >  #include <efi_loader.h>
> > > > > -#include <log.h>
> > > > > -#include <mapmem.h>
> > > > >  #include <acpi/acpi_table.h>
> > > > >  #include <asm/global_data.h>
> > > > > +#include <asm/io.h>
> > > > > +#include <bloblist.h>
> > > > > +#include <linux/sizes.h>
> > > > > +#include <linux/log2.h>
> > > > > +#include <log.h>
> > > > > +#include <malloc.h>
> > > > > +#include <mapmem.h>
> > > > >
> > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > >
> > > > >  static const efi_guid_t acpi_guid =3D EFI_ACPI_TABLE_GUID;
> > > > >
> > > > > +enum {
> > > > > +       TABLE_SIZE      =3D SZ_64K,
> > > > > +};
> > > > >  /*
> > > > >   * Install the ACPI table as a configuration table.
> > > > >   *
> > > > > @@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
> > > > >         return efi_install_configuration_table(&acpi_guid,
> > > > >                                                (void *)(ulong)add=
r);
> > > > >  }
> > > > > +
> > > > > +/*
> > > > > + * Allocate memory for ACPI tables and write ACPI tables to the
> > > > > + * allocated buffer.
> > > > > + *
> > > > > + * Return:     status code
> > > > > + */
> > > > > +static int alloc_write_acpi_tables(void)
> > > > > +{
> > > > > +       u64 table_addr, table_end;
> > > > > +       u64 new_acpi_addr =3D 0;
> > > > > +       efi_uintn_t pages;
> > > > > +       efi_status_t ret;
> > > > > +       void *addr;
> > > > > +
> > > > > +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> > > > > +               return 0;
> > > > > +
> > > > > +       if (IS_ENABLED(CONFIG_X86) ||
> > > > > +           IS_ENABLED(CONFIG_QFW_ACPI) ||
> > > > > +           IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > +               log_debug("Skipping writing ACPI tables as alread=
y done\n");
> > > > > +               return 0;
> > > > > +       }
> > > > > +
> > > > > +       /* Align the table to a 4KB boundary to keep EFI happy */
> > > > > +       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> > > > > +               addr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, TABL=
E_SIZE,
> > > > > +                                   ilog2(SZ_4K));
> > > > > +
> > > > > +               if (!addr)
> > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > >
> > > > This addr is not in ACPI_RECLAIM_MEMORY now. It might work since
> > > > efi_acpi_register() adads it on the EFI memory map.
> > > > In the last version, Simon replied something along the lines of  "T=
his
> > > > is how x86 works", but I don't understand why. U-Boot at this point=
 is
> > > > the last bootloader you'll run and then jump to your EFI payload. C=
an
> > > > someone clearly explain what's going on here?
> > > >
> > > > > +       } else {
> > > > > +               pages =3D efi_size_in_pages(TABLE_SIZE);
> > > > > +
> > > > > +               ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES=
,
> > > > > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > > > > +                                        pages, &new_acpi_addr);
> > > > > +               if (ret !=3D EFI_SUCCESS)
> > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > +
> > > > > +               addr =3D (void *)(uintptr_t)new_acpi_addr;
> > > >
> > > > So this would be fine if we initialized the EFI subsystem early, bu=
t
> > > > we don't.  On top of that the efi_acpi_register() call is trying to
> > > > add the allocated memory to the efi memmap, so we don't need to do
> > > > that twice.
> > >
> > > Sounds like always using BLOBLIST would fix this issue. It would deco=
uple
> > > memory allocation and installation.
> >
> > bloblist is supposed to be used by early-stage bootloaders to pass
> > information around and is an implementation of [0]. Why you would
> > U-Boot need to add the item in a bloblist? There's no loader after
> > U-Boot that can consume it.
>
> That is one use of bloblist.
>
> Within U-Boot proper, bloblist is used to hold all the tables
> generated by U-Boot, so they are all in one place.

What do you mean by 'tables'. That makes little sense to me,
especially with the caveats it comes along. ACPI is an EFI construct
and we should limit it there. I can understand this if a next stage
loader needs the ACPI in a transfer list, but that use case does not
exist.

Thanks
/Ilias
>
> >
> > >
> > > >
> > > > I think there's a cleaner approach overall to this which will allow=
 us
> > > > to decouple the installation etc from EFI.
> > > > You could allocate a piece of memory, assign it to
> > > > arch.table_start/end and then tweak efi_acpi_register(). Instead of
> > > > marking the table_end - table_start as ACPI_RECLAIM_MEMORY, allocat=
e
> > > > the pages there, where you know the EFI subsystem is up and copy it=
.
> > > > It would then be the callers responsibilty to free that memory.
> > > >
> > > We cannot memcpy ACPI tables to a new location. For example the RSDT =
and XSDT
> > > contain physical addresses to memory within the ACPI reclaim window,
> > > which must be tweaked
> > > when you copy tables. On x86 there's also the GNVS which is patched
> > > into the DSDT, which points
> > > to memory within the ACPI reclaim memory window.
> > > There might be more places I'm not aware of as of now.
> >
> > Ok, that's fine though, we can just mark the memory as
> > ACPI_RECLAIM_MEMORY, like we currently do, without allocating and
> > copying over stuff.
>
> Regards,
> Simon
>
>
> >
> > Thanks
> > /Ilias
> > >
> > > > Heinrich, do you see a problem with that?
> > > >
> > > > Thanks
> > > > /Ilias
> > > >
> > > > > +       }
> > > > > +
> > > > > +       table_addr =3D virt_to_phys(addr);
> > > > > +
> > > > > +       gd->arch.table_start_high =3D table_addr;
> > > > > +
> > > > > +       table_end =3D write_acpi_tables(table_addr);
> > > > > +       if (!table_end) {
> > > > > +               log_err("Can't create ACPI configuration table\n"=
);
> > > > > +               return -EINTR;
> > > > > +       }
> > > > > +
> > > > > +       log_debug("- wrote 'acpi' to %llx, end %llx\n", table_add=
r, table_end);
> > > > > +       if (table_end - table_addr > TABLE_SIZE) {
> > > > > +               log_err("Out of space for configuration tables: n=
eed %llx, have %x\n",
> > > > > +                       table_end - table_addr, TABLE_SIZE);
> > > > > +               return log_msg_ret("acpi", -ENOSPC);
> > > > > +       }
> > > > > +       gd->arch.table_end_high =3D table_end;
> > > > > +
> > > > > +       log_debug("- done writing tables\n");
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
> > > > > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/tes=
t_event_dump.py
> > > > > index e282c67335..459bfa26bb 100644
> > > > > --- a/test/py/tests/test_event_dump.py
> > > > > +++ b/test/py/tests/test_event_dump.py
> > > > > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> > > > >  --------------------  ------------------------------  ----------=
--------------------
> > > > >  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe=
_request.c:.*
> > > > >  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe=
_simple_os.c:.*
> > > > > +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_=
loader/efi_acpi.c:.*
> > > > >  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_=
loader/efi_smbios.c:.*
> > > > >  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/san=
dbox/cpu/start.c:.*
> > > > >  EVT_TEST              h_adder_simple                  .*test/com=
mon/event.c:'''
> > > > > --
> > > > > 2.46.0
> > > > >
> >
> > [0] https://github.com/FirmwareHandoff/firmware_handoff
