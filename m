Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35418CDD578
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 13:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB81789179;
	Thu, 19 Sep 2024 15:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PTKH0mxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 948E289181; Thu, 19 Sep 2024 15:23:23 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCD989128
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so651773b3a.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726752200; x=1727357000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SfL91N5lTGuSJmv4BMNOT0kwHW2KO49Jr7usolawaTo=;
 b=PTKH0mxApM8rhv8ODhAgKAMLK6QSdm/FJclpWBWquszULIzvKYZIP7Fn6qxx46+2wY
 uI83Fvzd/z9ifOZcAnT4HSs9QcSxtlmQaIOy/cgnjjps9htRBcTb5B5GRcORSQqcUV9L
 rbhQEZtdToIjMeoMED9IfoW28LsilXreoTI68FTJ0QL2nfftb+S4ghhBePpyWHcb7sZt
 f0J5nZ0eSX+IER1lAGUrhhrWNB67/1Uvt2EXDuaxlghlFpmmn65w8xTOYR/nIn11i0Bx
 VaHSpUnX1l7p70aGFx25UgGBYGITExDocrsqNtw6ADhSloDOur+xskBnbaoR8COewNTu
 webg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726752200; x=1727357000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SfL91N5lTGuSJmv4BMNOT0kwHW2KO49Jr7usolawaTo=;
 b=Ak88+tzTB+b/zHhFDLDziT/fcEWFqC0fhGDyCfXFsTxFXdk885zT7RiXuvhU+XhYXc
 zVGqcNlhsa1fJ8xP/TMa/0W3YEyrgaKg3BZmL56elnvixRewT6Tw8JGYIORBP56fUyaC
 xzbKFuTx45aO4Rpdp2U/aYR0rUdHO+VTLbhSux0lROWdCp+aXvt49WAYrM5GXP7r8+hz
 nTNzcYH3Uqq0rFp0SjaatuPVzH3LTGGXeHK4qU/xXv/XmLpSOu6okGjLrV3x+AHQXnzb
 IyFSAWKljm6M/geJ+R7s11Vn4K8FMvZbWCzCnclgm8d05ZBZF1FnpKnCTRD4gRlZVSFs
 uuew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5f72OES9/x7QoreSUVdToq+8xLvwGdDqBs8Dfh6qSGkt0JTdKKDgKHZAc5mEwvTY7hMyO+Tw=@lists.denx.de
X-Gm-Message-State: AOJu0YzvlFGYJlOKedUVwtMMHqaiOFtnxs69OoZ4Jwxqi+OZSKWTTxH1
 ApP445PEMQDP/rjCuvuJqFre1z8zBQNfeGoOGFbn4+4d7lMgMnMkbVnh58gMKUt8Ve/ARaH48Ti
 FLvLIRmyGA4Fb8IuoME/BpHxCwto2NHAd93dZog==
X-Google-Smtp-Source: AGHT+IGPfGms1Z54oqb/O8Y09Wr7Dsp7vbe8gQxCbXdr4DYL1WCNdwXvPBuxm/S/sDCwHpty+Tuj6IfsMSU6LJVHMgg=
X-Received: by 2002:a05:6a00:2381:b0:706:700c:7864 with SMTP id
 d2e1a72fcca58-7192605a15emr44502304b3a.4.1726752199679; Thu, 19 Sep 2024
 06:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
 <CAFLszTiaaP9goTUQiVJ3MQkzegDAmac-AWmtip38eLhMoC15xg@mail.gmail.com>
 <d33b38d1-830e-46f0-939d-c5f662bf4193@gmx.de>
In-Reply-To: <d33b38d1-830e-46f0-939d-c5f662bf4193@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 16:22:43 +0300
Message-ID: <CAC_iWjKfJbopOn4b7=9F7h0WHWXJ=Vafq8A-aK_4FR2MPWFLEg@mail.gmail.com>
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Thu, 19 Sept 2024 at 15:51, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
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

[...]

>
> Please, have a look at init_sequence_r[].
>
> The memory allocate for the EFI sub-system is initialized in
> efi_memory_init directly after initr_lmb.
>
> So for sure we can and should use efi_allocate_pages() here.

Ah thanks Heinrich. Yes we should, I wrongly remembered we init the
memory subsystem when we init the EFI one.


Thanks
/Ilias

>
> We must not use bloblist_add() as the memory allocation would not be
> reported as AcpiReclaimMemory.
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
