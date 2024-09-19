Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA05ECDD578
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 13:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F74989128;
	Thu, 19 Sep 2024 15:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PeXCZ2kA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD1FF8917A; Thu, 19 Sep 2024 15:25:35 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1531D89111
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-710ddb52139so439850a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726752332; x=1727357132; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ic+BC+2cJxJrWeqUFs88F94OLfMuOc9g/txrr85b54=;
 b=PeXCZ2kA1MreNWwWusxNkpunL7bzz6wX0A6izawpQ+T+ZALzIQyiZY0jUDYr68QeSE
 BJRfaqxKs4/doL7Uu2Uokd8Boug08j/44o33ikj2MBZhUFvoQEHP7lhu3W4KAlLSCzc2
 BV5Jsms/RmD114hEEDYKK/G+g9mZ4GNyVbueo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726752332; x=1727357132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ic+BC+2cJxJrWeqUFs88F94OLfMuOc9g/txrr85b54=;
 b=WuvcWh5Q+teb4Hk7fu+79RmVa4XmJw27Eov1/RBglct6AEeZzzz/j+YZOXe7NdqAT/
 ayMxKXi293giVW7Bytglz8kwCHIqEgrBrnQ8pCRgaY6u6C3hMChZzp7UVhce5X/m0I1n
 W7wvd5f44IKlg2gJ1Bn3kawYswPpRvoH4YuQ2ZkdW+EgmuCN+sMebSokVd9XMV0BlEzq
 8Yzx2sLW43V+6IUlLdvHQt5yZPKmTKbxZeHQCzyk4bUINLju0nXFKumyvZt4rIEBByQ2
 YYlli6KH/JC6cOajXWR2Y3OAziaLdMoNd2OelJJHQoYLMylxOPOB5idIbY7dQYwFYoHu
 VJ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjtfPkMeZEI5forliP+S/JI8JQ46fIkXoSeW3RY3O+psKxvT2pe0wXt2V17oxpbbWZwyK7BzI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/kT05cOkMe8w+C3jonTjwu2YD0EzRbvkS93uD9ebjlIGLSyx3
 XbupvGXhO6ydvhwURwQwvqRCfGLCkv9uP219ZsA4YUJE9HZgga9EqFTnX6tse4K6Cb4EldCh3I6
 wxIpUH1cu4xXrmAutngfCm+V30I5fTzxz3zPF
X-Google-Smtp-Source: AGHT+IHq4T9eDlhmNJDyIn+3pzJV19Iv0hATF6hXIZm7Q0dYdYs3/l2YuofpICE16F5REBMIpwPY18jCh+3iN93M4E4=
X-Received: by 2002:a05:6358:d0e:b0:1aa:bad6:2ba7 with SMTP id
 e5c5f4694b2df-1bb23de02f2mr939284455d.25.1726752331688; Thu, 19 Sep 2024
 06:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
 <CAC_iWjLfbXHFd7zs0xsVamXua8GXsAbhBstgTQEQN1+t8Fr2QA@mail.gmail.com>
 <CALNFmy1b-tdn1DpJ2TpMV+2UU9u4chFcfzMq+-FCxL1VYx05-g@mail.gmail.com>
 <CAC_iWjK-U3R_8rZp37aTZtOSk=tSAa4dL3uFojG-QLJG9jBg+w@mail.gmail.com>
 <CAFLszTieB1RyPiEVdK+hAvitBAwyT95prGo8dAPp3mfU8Of+9Q@mail.gmail.com>
 <CAC_iWjL4wjMvne=0EQkOnT4GxZr=B6tWO2WQq8ZmTJO_OFY2zw@mail.gmail.com>
In-Reply-To: <CAC_iWjL4wjMvne=0EQkOnT4GxZr=B6tWO2WQq8ZmTJO_OFY2zw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 15:25:21 +0200
Message-ID: <CAFLszTiBDbeUx8Tq9uctDhCxXBhJfkm=nF14eoghpwSLM=rLdg@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Thu, 19 Sept 2024 at 15:18, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 19 Sept 2024 at 16:01, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 19 Sept 2024 at 09:30, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Thu, 19 Sept 2024 at 09:41, Patrick Rudolph
> > > <patrick.rudolph@9elements.com> wrote:
> > > >
> > > > On Thu, Sep 12, 2024 at 8:55=E2=80=AFAM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Patrick
> > > > >
> > > > > On Wed, 11 Sept 2024 at 09:25, Patrick Rudolph
> > > > > <patrick.rudolph@9elements.com> wrote:
> > > > > >
> > > > > > Allocate memory for ACPI tables inside the efi_loader and write=
 out
> > > > > > the tables similar to SMBIOS tables. When ACPI is enabled and w=
asn't
> > > > > > installed in other places, install the ACPI table in EFI. Since=
 EFI
> > > > > > is necessary to pass the ACPI table location when FDT isn't use=
d,
> > > > > > there's no need to install it separately.
> > > > > >
> > > > > > When CONFIG_BLOBLIST_TABLES is set the tables will be stored in=
 a
> > > > > > bloblist. The tables are still passed to the OS using EFI.
> > > > > >
> > > > > > This allows non x86 platforms to boot using ACPI only in case t=
he
> > > > > > EFI loader is being used.
> > > > > >
> > > > > > TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
> > > > > >
> > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > ---
> > > > > > Changelog v3:
> > > > > > - Drop memalign and use efi_allocate_pages
> > > > > > - Use log_debug instead of debug
> > > > > > - Clarify commit message
> > > > > > - Skip writing ACPI tables on sandbox
> > > > > > - Rename function
> > > > > > - Add function comment
> > > > > > ---
> > > > > >  lib/efi_loader/efi_acpi.c        | 80 ++++++++++++++++++++++++=
+++++++-
> > > > > >  test/py/tests/test_event_dump.py |  1 +
> > > > > >  2 files changed, 79 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acp=
i.c
> > > > > > index 67bd7f8ca2..9d38d0060c 100644
> > > > > > --- a/lib/efi_loader/efi_acpi.c
> > > > > > +++ b/lib/efi_loader/efi_acpi.c
> > > > > > @@ -6,15 +6,23 @@
> > > > > >   */
> > > > > >
> > > > > >  #include <efi_loader.h>
> > > > > > -#include <log.h>
> > > > > > -#include <mapmem.h>
> > > > > >  #include <acpi/acpi_table.h>
> > > > > >  #include <asm/global_data.h>
> > > > > > +#include <asm/io.h>
> > > > > > +#include <bloblist.h>
> > > > > > +#include <linux/sizes.h>
> > > > > > +#include <linux/log2.h>
> > > > > > +#include <log.h>
> > > > > > +#include <malloc.h>
> > > > > > +#include <mapmem.h>
> > > > > >
> > > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > > >
> > > > > >  static const efi_guid_t acpi_guid =3D EFI_ACPI_TABLE_GUID;
> > > > > >
> > > > > > +enum {
> > > > > > +       TABLE_SIZE      =3D SZ_64K,
> > > > > > +};
> > > > > >  /*
> > > > > >   * Install the ACPI table as a configuration table.
> > > > > >   *
> > > > > > @@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
> > > > > >         return efi_install_configuration_table(&acpi_guid,
> > > > > >                                                (void *)(ulong)a=
ddr);
> > > > > >  }
> > > > > > +
> > > > > > +/*
> > > > > > + * Allocate memory for ACPI tables and write ACPI tables to th=
e
> > > > > > + * allocated buffer.
> > > > > > + *
> > > > > > + * Return:     status code
> > > > > > + */
> > > > > > +static int alloc_write_acpi_tables(void)
> > > > > > +{
> > > > > > +       u64 table_addr, table_end;
> > > > > > +       u64 new_acpi_addr =3D 0;
> > > > > > +       efi_uintn_t pages;
> > > > > > +       efi_status_t ret;
> > > > > > +       void *addr;
> > > > > > +
> > > > > > +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       if (IS_ENABLED(CONFIG_X86) ||
> > > > > > +           IS_ENABLED(CONFIG_QFW_ACPI) ||
> > > > > > +           IS_ENABLED(CONFIG_SANDBOX)) {
> > > > > > +               log_debug("Skipping writing ACPI tables as alre=
ady done\n");
> > > > > > +               return 0;
> > > > > > +       }
> > > > > > +
> > > > > > +       /* Align the table to a 4KB boundary to keep EFI happy =
*/
> > > > > > +       if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> > > > > > +               addr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, TA=
BLE_SIZE,
> > > > > > +                                   ilog2(SZ_4K));
> > > > > > +
> > > > > > +               if (!addr)
> > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > >
> > > > > This addr is not in ACPI_RECLAIM_MEMORY now. It might work since
> > > > > efi_acpi_register() adads it on the EFI memory map.
> > > > > In the last version, Simon replied something along the lines of  =
"This
> > > > > is how x86 works", but I don't understand why. U-Boot at this poi=
nt is
> > > > > the last bootloader you'll run and then jump to your EFI payload.=
 Can
> > > > > someone clearly explain what's going on here?
> > > > >
> > > > > > +       } else {
> > > > > > +               pages =3D efi_size_in_pages(TABLE_SIZE);
> > > > > > +
> > > > > > +               ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAG=
ES,
> > > > > > +                                        EFI_ACPI_RECLAIM_MEMOR=
Y,
> > > > > > +                                        pages, &new_acpi_addr)=
;
> > > > > > +               if (ret !=3D EFI_SUCCESS)
> > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > +
> > > > > > +               addr =3D (void *)(uintptr_t)new_acpi_addr;
> > > > >
> > > > > So this would be fine if we initialized the EFI subsystem early, =
but
> > > > > we don't.  On top of that the efi_acpi_register() call is trying =
to
> > > > > add the allocated memory to the efi memmap, so we don't need to d=
o
> > > > > that twice.
> > > >
> > > > Sounds like always using BLOBLIST would fix this issue. It would de=
couple
> > > > memory allocation and installation.
> > >
> > > bloblist is supposed to be used by early-stage bootloaders to pass
> > > information around and is an implementation of [0]. Why you would
> > > U-Boot need to add the item in a bloblist? There's no loader after
> > > U-Boot that can consume it.
> >
> > That is one use of bloblist.
> >
> > Within U-Boot proper, bloblist is used to hold all the tables
> > generated by U-Boot, so they are all in one place.
>
> What do you mean by 'tables'. That makes little sense to me,
> especially with the caveats it comes along. ACPI is an EFI construct
> and we should limit it there. I can understand this if a next stage
> loader needs the ACPI in a transfer list, but that use case does not
> exist.

Please take a look at the top of bloblist.h - this is how newer x86
platforms work and it has always been intended that way. It is not a
transfer list, but a bloblist, at least in U-Boot parlance.

Regards,
Simon

>
> Thanks
> /Ilias
> >
> > >
> > > >
> > > > >
> > > > > I think there's a cleaner approach overall to this which will all=
ow us
> > > > > to decouple the installation etc from EFI.
> > > > > You could allocate a piece of memory, assign it to
> > > > > arch.table_start/end and then tweak efi_acpi_register(). Instead =
of
> > > > > marking the table_end - table_start as ACPI_RECLAIM_MEMORY, alloc=
ate
> > > > > the pages there, where you know the EFI subsystem is up and copy =
it.
> > > > > It would then be the callers responsibilty to free that memory.
> > > > >
> > > > We cannot memcpy ACPI tables to a new location. For example the RSD=
T and XSDT
> > > > contain physical addresses to memory within the ACPI reclaim window=
,
> > > > which must be tweaked
> > > > when you copy tables. On x86 there's also the GNVS which is patched
> > > > into the DSDT, which points
> > > > to memory within the ACPI reclaim memory window.
> > > > There might be more places I'm not aware of as of now.
> > >
> > > Ok, that's fine though, we can just mark the memory as
> > > ACPI_RECLAIM_MEMORY, like we currently do, without allocating and
> > > copying over stuff.
> >
> > Regards,
> > Simon
> >
> >
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > > Heinrich, do you see a problem with that?
> > > > >
> > > > > Thanks
> > > > > /Ilias
> > > > >
> > > > > > +       }
> > > > > > +
> > > > > > +       table_addr =3D virt_to_phys(addr);
> > > > > > +
> > > > > > +       gd->arch.table_start_high =3D table_addr;
> > > > > > +
> > > > > > +       table_end =3D write_acpi_tables(table_addr);
> > > > > > +       if (!table_end) {
> > > > > > +               log_err("Can't create ACPI configuration table\=
n");
> > > > > > +               return -EINTR;
> > > > > > +       }
> > > > > > +
> > > > > > +       log_debug("- wrote 'acpi' to %llx, end %llx\n", table_a=
ddr, table_end);
> > > > > > +       if (table_end - table_addr > TABLE_SIZE) {
> > > > > > +               log_err("Out of space for configuration tables:=
 need %llx, have %x\n",
> > > > > > +                       table_end - table_addr, TABLE_SIZE);
> > > > > > +               return log_msg_ret("acpi", -ENOSPC);
> > > > > > +       }
> > > > > > +       gd->arch.table_end_high =3D table_end;
> > > > > > +
> > > > > > +       log_debug("- done writing tables\n");
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables)=
;
> > > > > > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/t=
est_event_dump.py
> > > > > > index e282c67335..459bfa26bb 100644
> > > > > > --- a/test/py/tests/test_event_dump.py
> > > > > > +++ b/test/py/tests/test_event_dump.py
> > > > > > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> > > > > >  --------------------  ------------------------------  --------=
----------------------
> > > > > >  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/v=
be_request.c:.*
> > > > > >  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/v=
be_simple_os.c:.*
> > > > > > +EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/ef=
i_loader/efi_acpi.c:.*
> > > > > >  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/ef=
i_loader/efi_smbios.c:.*
> > > > > >  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/s=
andbox/cpu/start.c:.*
> > > > > >  EVT_TEST              h_adder_simple                  .*test/c=
ommon/event.c:'''
> > > > > > --
> > > > > > 2.46.0
> > > > > >
> > >
> > > [0] https://github.com/FirmwareHandoff/firmware_handoff
