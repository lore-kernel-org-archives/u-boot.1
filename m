Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E23CE7AFD
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 10:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE58588BAE;
	Fri,  6 Sep 2024 12:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LqrNZNJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 584DA88CE1; Fri,  6 Sep 2024 12:17:29 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1715988BAE
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 12:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so1465076a12.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725617845; x=1726222645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bHnBm26SeNs459BbyWO5pVFatBkeqVn6+dD198Yku5M=;
 b=LqrNZNJG7k41/8PDLZ4yoqZL8DfPZZoLRaQHDtGOWuJAH0GPhLuy266Vgn6CMvF+09
 msaAaz5aoY03LVzlTHYs9PQVdn+EMU+0oyI1OySGwFWodZj6JWnvXJG8l9LR/cZy2tbj
 M5FQNMIR7PYLo69MXIxJq1WdJHtaTsXD2qianhl+5L8l543Cclh7sjkxXnj6VKZKz4KB
 QCFXjbufVXXcW6Tf/9x3dF6K2qKmLyBIZlzYUT7Lz4UzzglBJp+BBerTyS4e8i9lBbvy
 JD1tCXLRHuSBplCRhZU/rOGQo6eC3LpxohbtDfGKwt9RqlIZQun99GOu9oYIVb67epwf
 qk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725617845; x=1726222645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bHnBm26SeNs459BbyWO5pVFatBkeqVn6+dD198Yku5M=;
 b=rbW/lM7mHlWf4QQ6XTqh65YM03fCT8vyghrWIhZMwsS79jz/0ZFGNTmIN0mvZf+hK4
 ShDYppH0ly2A7cPaL8hk44kUVELIqPOsWpgLdSS08q6F9Ryl5RU5CRhcClrDMsbWxp4d
 mtlAGS37aiJQR9FvuU/KVo/TNtkx1l5xE07ovIANJqhBCycx7/1YlmBmqk3IKUQPx85A
 nexXgYP4Ei5lA6LDirotcP3Sx84lxB9Sfxh283s5I4hrAyN1fsscDAOyd/Hq5MdRqoEd
 x2EL1xnRkroLpA8lFVhtaZC1sN/f+ad3MElijang+RXC1D3x5WCOG23yAwMFDliteBak
 MYmA==
X-Gm-Message-State: AOJu0YzA29/8GQz2FNuAUApc/V9cAUQOShz5f3fFAM3Wr0AXHYgET8eb
 MneuxIBLfVLb4kel4sMqZcup24efIN3R9gka8FKy3Jv6WLcx3qfAIepUayFWExHYVkExzeWRAYS
 VtMa0qXrJpEuteLvk3tYor6DcPSbJhd/LCS5i5w==
X-Google-Smtp-Source: AGHT+IEacr0fVLuDXqqoK9aaf+i0Pd8E0P0ADxl4Ltb6MCzODQnZ2mbAXuIX5HwqfvbMB7zDUbPnCiGhYlos9pYQd/c=
X-Received: by 2002:a17:902:c40d:b0:205:3e68:7367 with SMTP id
 d9443c01a7336-2053e68777dmr266217675ad.21.1725617845395; Fri, 06 Sep 2024
 03:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
 <20240906072231.2531491-15-patrick.rudolph@9elements.com>
 <ZtrWVOdnu0Py7KRs@hera>
In-Reply-To: <ZtrWVOdnu0Py7KRs@hera>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Sep 2024 13:16:48 +0300
Message-ID: <CAC_iWj+5uu14qgCRSh7_gYWKwQ7T9eY5trCPZFKUuAG5HjHUaQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] efi_loader: Install ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, sjg@chromium.org, bmeng.cn@gmail.com, 
 trini@konsulko.com, sr@denx.de, pbrobinson@gmail.com, mbrugger@suse.com, 
 maximilian.brune@9elements.com
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

Apologies for the noise
+cc Heinrich

On Fri, 6 Sept 2024 at 13:15, Ilias Apalodimas
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
> >  static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
> >
> > +enum {
> > +     TABLE_SIZE      = SZ_64K,
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
> > +             addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> > +                                 ilog2(SZ_4K));
> > +     else
> > +             addr = memalign(SZ_4K, TABLE_SIZE);
>
> The alignment is already taken care of in efi_acpi_register(). Also an
>
> > +
> > +     if (!addr)
> > +             return log_msg_ret("mem", -ENOBUFS);
> > +
> > +     rom_addr = virt_to_phys(addr);
> > +
> > +     gd->arch.table_start_high = rom_addr;
> > +
> > +     rom_table_end = write_acpi_tables(rom_addr);
> > +     if (!rom_table_end) {
> > +             log_err("Can't create ACPI configuration table\n");
> > +             return -EINTR;
> > +     }
> > +
> > +     debug("- wrote 'acpi' to %llx, end %llx\n", rom_addr, rom_table_end);
> > +     if (rom_table_end - rom_addr > TABLE_SIZE) {
> > +             log_err("Out of space for configuration tables: need %llx, have %x\n",
> > +                     rom_table_end - rom_addr, TABLE_SIZE);
> > +             return log_msg_ret("acpi", -ENOSPC);
> > +     }
> > +     gd->arch.table_end_high = rom_table_end;
> > +
> > +     debug("- done writing tables\n");
> > +
> > +     return 0;
> > +}
> > +
> > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_acpi_table);
>
> Why is this an event and how do you make sure it runs before
> efi_acpi_register()?. This should just run explicitly before that to prepare
> the ACPI tables and if it fails we shouldn't even try to install the config
> table
>
> /Ilias
> > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> > index e282c67335..88bbf34f71 100644
> > --- a/test/py/tests/test_event_dump.py
> > +++ b/test/py/tests/test_event_dump.py
> > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> >  --------------------  ------------------------------  ------------------------------
> >  EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
> >  EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> > +EVT_LAST_STAGE_INIT   install_acpi_table              .*lib/efi_loader/efi_acpi.c:.*
> >  EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
> >  EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
> >  EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
> > --
> > 2.45.2
> >
