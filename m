Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0BFCE7B04
	for <u-boot@archiver.kernel.org>; Sat,  7 Sep 2024 00:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C671E88D23;
	Sat,  7 Sep 2024 02:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mJOzJNaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA11488D52; Sat,  7 Sep 2024 02:56:42 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A396888D23
 for <u-boot@lists.denx.de>; Sat,  7 Sep 2024 02:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c3552ce7faso24287616d6.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725670599; x=1726275399; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VVGvr37/j7MvNynfdIoAQJstHwQIqtac70aOwzsX01Y=;
 b=mJOzJNaMnVF5/F99uOOqDaSau52p9BpFJjnM0dgDnNbXbEJhCWU7Wl9cWsOOWf3Mvq
 jeAigP/eKibeMMzikYWFZ3KnLIRxjWyzfSXN9eaCxWtUA1RiuQk4pXqd3SFhBeh4llex
 YeazkKxcnW5A7i74Bj3H6+++S8y9zolMKVwJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725670599; x=1726275399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VVGvr37/j7MvNynfdIoAQJstHwQIqtac70aOwzsX01Y=;
 b=vDAcIp5T90xn62J8zFH6qwOqPO7tVOksGqC75NbKy2xzZKpwGbCmoSkg9cvJmXJmLu
 p9o+OAa3kFJG8KLhK45SnBuR/tWH+Z/vAcAIIqYQbFC6ycI0c2Cxerw2qAQjkPZXmGeQ
 OCSlzjK6CvYBIJct5viyotfX2LJURLa48gvQUlhFxocFh/CG79UlKw60gDDudmTYvZdy
 mtCn+s2WGUsymrwH+CTbj8ejfF7zy4uGjmyAa2JItc0RT0aEM2VFcNnA2D/Nvbqga+6s
 AbQYfxytTw8JocEjzLuWDmStg3diesRaHxYyCLlRLS+k26ZTqoeRW/P1qbHQiYY/xhzh
 dspg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl8fF5e6v/JCvfEQuCdjKTDigsPGyIiQVVElTCEHOI82SAzBl73GN+ltjH3asx2+YwLyL0mKw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg5rJmi4u2GeEpg8bCxvFtut2Di3QrFdEGogP10rBX3krJq1RY
 OSFl/ndzroxLN7QH283MCBGDU1VbI64s+MDPXdhLUlCXzENHt+sJwBuABd6m5+dWpKRAzTP6gyt
 khlxSmfRxbsI5V1UdjlCzytq4V7TxZK9xo7RP
X-Google-Smtp-Source: AGHT+IHC0k3ZpSbCrRmgJTTxrq1whjqHHJwlFweTLslmCJ3bWArenoqGeItAR/eBQym6o+JJpFXB2QQkcNilUWm33zQ=
X-Received: by 2002:a05:6214:2c04:b0:6c3:6414:7172 with SMTP id
 6a1803df08f44-6c528300033mr87817416d6.9.1725670599474; Fri, 06 Sep 2024
 17:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
 <20240906072231.2531491-15-patrick.rudolph@9elements.com>
 <adbefd8b-9d14-42f0-9a20-83416bf671c9@gmx.de>
In-Reply-To: <adbefd8b-9d14-42f0-9a20-83416bf671c9@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Sep 2024 18:56:28 -0600
Message-ID: <CAFLszTjsV6pGtP7RBwxEkvVVgRVwx8_r5tAQtjuGWA9UKhmmTQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/28] efi_loader: Install ACPI tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, bmeng.cn@gmail.com,
 trini@konsulko.com, sr@denx.de, pbrobinson@gmail.com, mbrugger@suse.com, 
 maximilian.brune@9elements.com, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Fri, 6 Sept 2024 at 04:56, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
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
> >
> > TEST: Booted QEMU SBSA using EFI and ACPI only.
>
> With this description it is unclear if you used QFW to install ACPI
> tables which would not test the code below.
>
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
>
> Please, cc maintainers as reported by scripts/get_maintainers in future.
>
> > ---
> >   lib/efi_loader/efi_acpi.c        | 57 ++++++++++++++++++++++++++++++--
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
> >   static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
> >
> > +enum {
> > +     TABLE_SIZE      = SZ_64K,
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
>              end = write_acpi_tables(addr);
>
> We should remove the redundant code from board/sandbox/sandbox.c with
> this patch.
>
> > +             return 0;
> > +
> > +     /* Align the table to a 4KB boundary to keep EFI happy */
> > +     if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
> > +             addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
> > +                                 ilog2(SZ_4K));
> > +     else
> > +             addr = memalign(SZ_4K, TABLE_SIZE);
>
> The UEFI specification wants ACPI tables to reside in
> EfiACPIReclaimMemory. Neither bloblist_add() nor memalign() should be
> used here.

I just want to address this and something below.

We do want to put tables in a bloblist. This is how x86 works
(although I haven't gone back and cleaned up all the boards) and I
think we should do it for all archs.

The memalign() here is fine too, since the actual setting of EFI
memory type is done later, when the table is registered.

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
>
> Please, use log_debug().
>
> > +     if (rom_table_end - rom_addr > TABLE_SIZE) {
> > +             log_err("Out of space for configuration tables: need %llx, have %x\n",
>
> This check is too late. We must ensure that write_acpi_table() does not
> overwrite unallocated memory.

That is not supported at present, unfortunately. I agree we should fix
it, but not in this series. For now we can set a size of 64KB which
should be plenty. The same bug exists in x86.

>
> > +                     rom_table_end - rom_addr, TABLE_SIZE);
> > +             return log_msg_ret("acpi", -ENOSPC);
> > +     }
> > +     gd->arch.table_end_high = rom_table_end;
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
> > diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
> > index e282c67335..88bbf34f71 100644
> > --- a/test/py/tests/test_event_dump.py
> > +++ b/test/py/tests/test_event_dump.py
> > @@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
> >   --------------------  ------------------------------  ------------------------------
> >   EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
> >   EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
> > +EVT_LAST_STAGE_INIT   install_acpi_table              .*lib/efi_loader/efi_acpi.c:.*
> >   EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
> >   EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
> >   EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
>

Regards,
Simon
