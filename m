Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FE4CD4F4C
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 06:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AAA388CC9;
	Mon,  9 Sep 2024 08:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="blcHQHn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD07B88CC9; Mon,  9 Sep 2024 08:29:15 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4AC88C4A
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 08:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e04196b7603so3787565276.0
 for <u-boot@lists.denx.de>; Sun, 08 Sep 2024 23:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725863351; x=1726468151; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tn+bR/O/t6PqolXwhF64RnqLCDAqntchgnxnD4TCVGU=;
 b=blcHQHn9N37Ydc7pL5EgbP8W4DPIEWnXugjQ6lzahGTTgNkungZRmuZ3vcj9EH7/Sf
 n/4gI9GNRxYGVBoA+PLNnRvCQQZGsGHv5QT1ORKBpBepeMfSYsKLSw2RapNRMNG09dxf
 Se7/lwP0WAC2ta7cfRCRGhOaJA+ZCT07XMQRZK6ITM7sSRzUzBKGX8RW47X0WeTzJKrE
 iJId6Fnz1w5GV3xjuJFRcAtUMY/9i2MZt4mm3ipnR08URwP+8w5af6fHjaLbk2s6US/+
 +goj1XevzGl8hFy+jrW3aVvGnxu4HsE5ZPA9MS5JWI1K7MZKIX4/DB/kU0+roV4EAbG4
 lT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725863351; x=1726468151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tn+bR/O/t6PqolXwhF64RnqLCDAqntchgnxnD4TCVGU=;
 b=odX1Rud7WO/4/u+ftzUTN0mZMwJl2Mr7y/GgJD5hzOgYGEF/FKVycYHfYooGoUMk9h
 8LGbHiTWiv2j9dHpWQQKe93RpMk90X0m24deZMkCtcEdIBgP1XmqrqoxAw67YiRt1hYM
 dOxV6icBinhMvQfoTkNALgKO4HJxikGe5t8A+FvzNlNVhLNzDlhQSTDe6UbK1Fb8wrSG
 J9gE++GXAV57gBM89n8beelNOleC0BrYcv+VEMreE2r7FwxYDKCWXzyzhdkR+o1TKlrT
 iBOIqzy7tZv25W3WH2f/UtxJm/ImTfzLYERzxKcIHPoOU37evL9nq5YtfEOQQldmguUi
 +RzQ==
X-Gm-Message-State: AOJu0YxxxY91bGqCm5cY1fz0e14fuuuvNdqi9yD6pLryzlzlruc3LqPX
 B0prDqFIRw7d7Wk9HSolBjOEfjk8yO8c7Vsf3cfNRcI/w/Y2/2oa/XPjQ0NfmqDEeoz2l+8svgo
 CIB1K05yzO9OpLV8WORRde7DX7RiMTmIEkOfM7w==
X-Google-Smtp-Source: AGHT+IHP5xk9m8sW42ToPNzYFHz+84oL17Sl8ghY2F5zNaF09dYDVySsN2h1z9ZR/9ECWVAq9Yr51jLmmfjJakLyiKo=
X-Received: by 2002:a05:6902:2685:b0:e1a:a6fe:71bd with SMTP id
 3f1490d57ef6-e1d34865f23mr8840332276.2.1725863351590; Sun, 08 Sep 2024
 23:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
 <20240906072231.2531491-15-patrick.rudolph@9elements.com>
 <ZtrWVOdnu0Py7KRs@hera>
In-Reply-To: <ZtrWVOdnu0Py7KRs@hera>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 9 Sep 2024 08:29:00 +0200
Message-ID: <CALNFmy2xnmoE5XhQBLvXbh3zRCjteze1BTQj-PhdNtry171CJQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] efi_loader: Install ACPI tables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, bmeng.cn@gmail.com, 
 trini@konsulko.com, sr@denx.de, pbrobinson@gmail.com, mbrugger@suse.com, 
 maximilian.brune@9elements.com
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

On Fri, Sep 6, 2024 at 12:15=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Patrick,
>
> On Fri, Sep 06, 2024 at 09:22:16AM +0200, Patrick Rudolph wrote:
> > Install ACPI tables inside the efi_loader similar to SMBIOS tables.
> > When ACPI is enabled and wasn't installed in other places, install
> > the ACPI table in EFI. Since EFI is necessary to pass the ACPI
> > table location when FDT isn't used, there's no need to install it
> > separately.
> >
> > When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> > bloblist.
> >
> > TEST: Booted QEMU SBSA using EFI and ACPI only.
> >
>
> Why none of the EFI maintainers were CC'ed into that?
>
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >  lib/efi_loader/efi_acpi.c        | 57 ++++++++++++++++++++++++++++++--
> >  test/py/tests/test_event_dump.py |  1 +
> >  2 files changed, 56 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> > index 67bd7f8ca2..9262f21ea6 100644
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
> >  static const efi_guid_t acpi_guid =3D EFI_ACPI_TABLE_GUID;
> >
> > +enum {
> > +     TABLE_SIZE      =3D SZ_64K,
> > +};
> >  /*
> >   * Install the ACPI table as a configuration table.
> >   *
> > @@ -47,3 +55,48 @@ efi_status_t efi_acpi_register(void)
> >       return efi_install_configuration_table(&acpi_guid,
> >                                              (void *)(ulong)addr);
> >  }
> > +
> > +static int install_acpi_table(void)
>
> This function doesn't install anything.  efi_acpi_register()
> nstalls the config tables for ACPI. This is just preparing and setting up
> correctly table_start_high/table_end_high AFAICT
>
It was copied from efi_smbios.c.
Please fix that file as well if you think it has the wrong name.

> > +{
> > +     u64 rom_addr, rom_table_end;
> > +     void *addr;
> > +
> > +     if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE) ||
> > +         IS_ENABLED(CONFIG_X86) ||
> > +         IS_ENABLED(CONFIG_QFW_ACPI))
> > +             return 0;
> > +
> > +     /* Align the table to a 4KB boundary to keep EFI happy */
> > +     if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > +             addr =3D bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> > +                                 ilog2(SZ_4K));
> > +     else
> > +             addr =3D memalign(SZ_4K, TABLE_SIZE);
>
> The alignment is already taken care of in efi_acpi_register(). Also an
>
When the caller does not align the memory it could happen that
efi_acpi_register() changes the
page attribute of an existing mapping, which might break on the OS side.

Please fix efi_acpi_register() to not assume anything and do not
silently modify mem-ranges.
An assert should be used instead to enforce proper alignment on page bounda=
ry.

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
> > +     if (rom_table_end - rom_addr > TABLE_SIZE) {
> > +             log_err("Out of space for configuration tables: need %llx=
, have %x\n",
> > +                     rom_table_end - rom_addr, TABLE_SIZE);
> > +             return log_msg_ret("acpi", -ENOSPC);
> > +     }
> > +     gd->arch.table_end_high =3D rom_table_end;
> > +
> > +     debug("- done writing tables\n");
> > +
> > +     return 0;
> > +}
> > +
> > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_acpi_table);
>
> Why is this an event and how do you make sure it runs before
> efi_acpi_register()?. This should just run explicitly before that to prep=
are
> the ACPI tables and if it fails we shouldn't even try to install the conf=
ig
> table
>
It's reusing the same mechanism as existing code to make sure it runs befor=
e
efi_acpi_register(). Existing code uses
EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT,...); to make sure it runs before
the tables are registered.

> /Ilias
> > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_even=
t_dump.py
> > index e282c67335..88bbf34f71 100644
> > --- a/test/py/tests/test_event_dump.py
> > +++ b/test/py/tests/test_event_dump.py
> > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> >  --------------------  ------------------------------  ----------------=
--------------
> >  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_reque=
st.c:.*
> >  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simpl=
e_os.c:.*
> > +EVT_LAST_STAGE_INIT   install_acpi_table              .*lib/efi_loader=
/efi_acpi.c:.*
> >  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader=
/efi_smbios.c:.*
> >  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/c=
pu/start.c:.*
> >  EVT_TEST              h_adder_simple                  .*test/common/ev=
ent.c:'''
> > --
> > 2.45.2
> >
