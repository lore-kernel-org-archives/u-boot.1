Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81946D5E140
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 07:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E250488DFA;
	Fri,  8 Nov 2024 08:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="SKWT7+xR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA7B88F6C; Fri,  8 Nov 2024 08:10:22 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1AAF88DF1
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 08:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c77459558so17431645ad.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 23:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1731049817; x=1731654617; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gauJn1RJvpx+bQcm6ixMyei3BzAXWDokbZxwL0uwaEU=;
 b=SKWT7+xRfqO6dXnUizyVR1AAEjvyQ8KzDf/gfQZc04ucTwYZYpaNqwvjxsI/tSvwo2
 6uFyaFc2bVSLkPWQc3wNc57lPZZ9gJg0VoKXO/NUEqXu7cgHqcFhxXBhX40kJSds/jyh
 m+gzvV3rB2nHHtK9hv6NIjs+Oq1WjyUfYFMXbuaNdsPMw8gx/PNrGCgFsnIBFXPGnHdr
 dkW5N08gxtiPc3bwZPuDisCUp+6HxC6NO2itsqZqCNCxdPmIZHiwD2AjgTPrYoYECkCB
 lCoM61eAA+7m/Pk2dr2crAwXsNkAN58DGnqRmVQ7iFEBKHB3lO8nnnyTjA/+6ETIxqux
 L9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731049817; x=1731654617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gauJn1RJvpx+bQcm6ixMyei3BzAXWDokbZxwL0uwaEU=;
 b=Kz9p1lfeDXwh9Gm7aEv44VHHXOAZl/CO5hUAlc4giSeavZNzc4RiZcPmUMUwpPqO2v
 svP+tvPdCw11PI5crCUE3iYPG/HVsHNSKx9Lo1MFPGjlSS1JZx0pVbqTTsgyuExtIAsC
 cjoRJhnN8LHIGTSo9MOHDo2zEeGgVbULpL0hXB3Sagw2pBLDrBU7qC3+bkmsMi0VFSuy
 e/21qpiypMoSv6/8reeEyCPVUamjE2N/rlY1MTPn6OP62bY6XzY9lhbFADaX8EYvxxMB
 wJMLYBsdY+iWRlR3pkd7kRpNuFvh1BIpIiYrXUkeOzEvJX3nSmbyC9c5VdJnls+6LPo8
 j3RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPzAnislBScE4QOYH3nn9IJXaKoptxiQasBtaCRzwSrqRX+ps+73J0fEGwPMDklzsVawyYDHE=@lists.denx.de
X-Gm-Message-State: AOJu0YxliD2/2qSuOFeoSFjIaJKy83aBJCE7JhdmN7a+nxu3hxAsRvrz
 QrLJdJfBg6wHlWS1cRpI8WrIfG/LQR5RWIgOeoVDJYVp3oXiOZ+L/f7Rn6FFkKYLhZbZbDo+7Bp
 Ovze0rgMkk0gvc2tozwGUGpYjNHmQEi9r19RD0g==
X-Google-Smtp-Source: AGHT+IHzDBSBBDjSaH8Ce8SnPJ7ElJB2GJtGinQX11FRe5yXSkVkyuZcDI+RThKFUK3r/rKrZE/eCT1i8nRGJQ/RHvs=
X-Received: by 2002:a17:90b:4acb:b0:2e0:921a:3383 with SMTP id
 98e67ed59e1d1-2e9b16556d7mr3067145a91.1.1731049817168; Thu, 07 Nov 2024
 23:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
 <20241023132116.970117-3-patrick.rudolph@9elements.com>
 <4d55f212-ee39-4886-9246-3596fc4268f7@gmx.de>
In-Reply-To: <4d55f212-ee39-4886-9246-3596fc4268f7@gmx.de>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Fri, 8 Nov 2024 08:10:05 +0100
Message-ID: <CALNFmy3ZuZwzXUsFt5EN-5VndSP+cavkY0R5=bhYDWEexG_otg@mail.gmail.com>
Subject: Re: [PATCH v10 02/37] acpi: x86: Write FADT in common code
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Maximilian Brune <maximilian.brune@9elements.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
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

Hi Heinrich,
On Thu, Nov 7, 2024 at 10:19=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 10/23/24 15:19, Patrick Rudolph wrote:
> > From: Maximilian Brune <maximilian.brune@9elements.com>
> >
> > Write the FADT in common code since it's used on all architectures.
> > Since the FADT is mandatory all SoCs or mainboards must implement the
> > introduced function acpi_fill_fadt() and properly update the FADT.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Bin Meng <bmeng.cn@gmail.com>
>
> This merged patch breaks
>
> make qemu_riscv64_defconfig acpi.config
> make
I'm sorry, since the CI doesn't build that target, I was not aware of
build failures.

>
> You are implementing function acpi_fill_fadt() only for x86 and call it
> in code that is used by all architectures.
>
acpi_fill_fadt() is called on all architectures that are ACPI enabled
and build by the CI.
There might additional ACPI enabled platforms, but since they are not
build tested,
they aren't officially supported, are they?

> ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
> makes no sense for CONFIG_QFW=3Dy because QEMU is providing the table.
Good catch. I'll send a follow up series.

>
> @Tom:
> After getting this fixed we should add a build with acpi.config into the =
CI.
>
> further comments below:
>
>
>
> >
> > ---
> > Changelog v4:
> > - Drop __weak attribute
> > ---
> >   arch/sandbox/lib/acpi_table.c     |  6 +++++
> >   arch/x86/cpu/apollolake/acpi.c    | 20 ++++------------
> >   arch/x86/cpu/baytrail/acpi.c      | 17 +-------------
> >   arch/x86/cpu/quark/acpi.c         | 19 +---------------
> >   arch/x86/cpu/tangier/acpi.c       | 25 ++------------------
> >   arch/x86/include/asm/acpi_table.h | 12 ----------
> >   arch/x86/lib/acpi_table.c         | 23 -------------------
> >   include/acpi/acpi_table.h         |  9 ++++++++
> >   lib/acpi/acpi_table.c             | 38 ++++++++++++++++++++++++++++++=
+
> >   9 files changed, 61 insertions(+), 108 deletions(-)
> >   create mode 100644 arch/sandbox/lib/acpi_table.c
> >
> > diff --git a/arch/sandbox/lib/acpi_table.c b/arch/sandbox/lib/acpi_tabl=
e.c
> > new file mode 100644
> > index 0000000000..10b7ce441a
> > --- /dev/null
> > +++ b/arch/sandbox/lib/acpi_table.c
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +#include <acpi/acpi_table.h>
> > +
> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
> > +{
> > +}
> > \ No newline at end of file
> > diff --git a/arch/x86/cpu/apollolake/acpi.c b/arch/x86/cpu/apollolake/a=
cpi.c
> > index 76230aea83..93040e7bb3 100644
> > --- a/arch/x86/cpu/apollolake/acpi.c
> > +++ b/arch/x86/cpu/apollolake/acpi.c
> > @@ -128,8 +128,10 @@ int arch_madt_sci_irq_polarity(int sci)
> >       return MP_IRQ_POLARITY_LOW;
> >   }
> >
> > -void fill_fadt(struct acpi_fadt *fadt)
> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
> >   {
> > +     intel_acpi_fill_fadt(fadt);
> > +
> >       fadt->pm_tmr_blk =3D IOMAP_ACPI_BASE + PM1_TMR;
> >
> >       fadt->p_lvl2_lat =3D ACPI_FADT_C2_NOT_SUPPORTED;
> > @@ -143,23 +145,9 @@ void fill_fadt(struct acpi_fadt *fadt)
> >       fadt->x_pm_tmr_blk.space_id =3D 1;
> >       fadt->x_pm_tmr_blk.bit_width =3D fadt->pm_tmr_len * 8;
> >       fadt->x_pm_tmr_blk.addrl =3D IOMAP_ACPI_BASE + PM1_TMR;
> > -}
> > -
> > -static int apl_write_fadt(struct acpi_ctx *ctx, const struct acpi_writ=
er *entry)
> > -{
> > -     struct acpi_table_header *header;
> > -     struct acpi_fadt *fadt;
> > -
> > -     fadt =3D ctx->current;
> > -     acpi_fadt_common(fadt, ctx->facs, ctx->dsdt);
> > -     intel_acpi_fill_fadt(fadt);
> > -     fill_fadt(fadt);
> > -     header =3D &fadt->header;
> > -     header->checksum =3D table_compute_checksum(fadt, header->length)=
;
> >
> > -     return acpi_add_fadt(ctx, fadt);
> > +     fadt->preferred_pm_profile =3D ACPI_PM_MOBILE;
> >   }
> > -ACPI_WRITER(5fadt, "FADT", apl_write_fadt, 0);
> >
> >   int apl_acpi_fill_dmar(struct acpi_ctx *ctx)
> >   {
> > diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.=
c
> > index 7821964f1f..7e1c2de3d3 100644
> > --- a/arch/x86/cpu/baytrail/acpi.c
> > +++ b/arch/x86/cpu/baytrail/acpi.c
> > @@ -15,20 +15,13 @@
> >   #include <asm/arch/iomap.h>
> >   #include <dm/uclass-internal.h>
> >
> > -static int baytrail_write_fadt(struct acpi_ctx *ctx,
> > -                            const struct acpi_writer *entry)
> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
> >   {
> >       struct acpi_table_header *header;
> > -     struct acpi_fadt *fadt;
> >
> > -     fadt =3D ctx->current;
> >       header =3D &fadt->header;
> >       u16 pmbase =3D ACPI_BASE_ADDRESS;
> >
> > -     memset(fadt, '\0', sizeof(struct acpi_fadt));
> > -
> > -     acpi_fill_header(header, "FACP");
> > -     header->length =3D sizeof(struct acpi_fadt);
> >       header->revision =3D 4;
> >
> >       fadt->preferred_pm_profile =3D ACPI_PM_MOBILE;
> > @@ -77,9 +70,6 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
> >       fadt->reset_reg.addrh =3D 0;
> >       fadt->reset_value =3D SYS_RST | RST_CPU | FULL_RST;
> >
> > -     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> > -     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
> > -
> >       fadt->x_pm1a_evt_blk.space_id =3D ACPI_ADDRESS_SPACE_IO;
> >       fadt->x_pm1a_evt_blk.bit_width =3D fadt->pm1_evt_len * 8;
> >       fadt->x_pm1a_evt_blk.bit_offset =3D 0;
> > @@ -135,12 +125,7 @@ static int baytrail_write_fadt(struct acpi_ctx *ct=
x,
> >       fadt->x_gpe1_blk.access_size =3D 0;
> >       fadt->x_gpe1_blk.addrl =3D 0x0;
> >       fadt->x_gpe1_blk.addrh =3D 0x0;
> > -
> > -     header->checksum =3D table_compute_checksum(fadt, header->length)=
;
> > -
> > -     return acpi_add_fadt(ctx, fadt);
> >   }
> > -ACPI_WRITER(5fadt, "FADT", baytrail_write_fadt, 0);
> >
> >   int acpi_create_gnvs(struct acpi_global_nvs *gnvs)
> >   {
> > diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
> > index 80e94600fc..0fe5f2bafb 100644
> > --- a/arch/x86/cpu/quark/acpi.c
> > +++ b/arch/x86/cpu/quark/acpi.c
> > @@ -11,23 +11,14 @@
> >   #include <asm/arch/iomap.h>
> >   #include <linux/string.h>
> >
> > -static int quark_write_fadt(struct acpi_ctx *ctx,
> > -                         const struct acpi_writer *entry)
> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
> >   {
> >       u16 pmbase =3D ACPI_PM1_BASE_ADDRESS;
> >       struct acpi_table_header *header;
> > -     struct acpi_fadt *fadt;
> >
> > -     fadt =3D ctx->current;
> >       header =3D &fadt->header;
> > -
> > -     memset(fadt, '\0', sizeof(struct acpi_fadt));
> > -
> > -     acpi_fill_header(header, "FACP");
> > -     header->length =3D sizeof(struct acpi_fadt);
> >       header->revision =3D 4;
> >
> > -     fadt->preferred_pm_profile =3D ACPI_PM_UNSPECIFIED;
> >       fadt->sci_int =3D 9;
> >       fadt->smi_cmd =3D 0;
> >       fadt->acpi_enable =3D 0;
> > @@ -73,9 +64,6 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
> >       fadt->reset_reg.addrh =3D 0;
> >       fadt->reset_value =3D SYS_RST | RST_CPU | FULL_RST;
> >
> > -     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> > -     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
> > -
> >       fadt->x_pm1a_evt_blk.space_id =3D ACPI_ADDRESS_SPACE_IO;
> >       fadt->x_pm1a_evt_blk.bit_width =3D fadt->pm1_evt_len * 8;
> >       fadt->x_pm1a_evt_blk.bit_offset =3D 0;
> > @@ -131,12 +119,7 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
> >       fadt->x_gpe1_blk.access_size =3D 0;
> >       fadt->x_gpe1_blk.addrl =3D 0x0;
> >       fadt->x_gpe1_blk.addrh =3D 0x0;
> > -
> > -     header->checksum =3D table_compute_checksum(fadt, header->length)=
;
> > -
> > -     return acpi_add_fadt(ctx, fadt);
> >   }
> > -ACPI_WRITER(5fadt, "FADT", quark_write_fadt, 0);
> >
> >   int acpi_create_gnvs(struct acpi_global_nvs *gnvs)
> >   {
> > diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
> > index d4d0ef6f85..1c73a9dbfe 100644
> > --- a/arch/x86/cpu/tangier/acpi.c
> > +++ b/arch/x86/cpu/tangier/acpi.c
> > @@ -16,21 +16,8 @@
> >   #include <asm/arch/iomap.h>
> >   #include <dm/uclass-internal.h>
> >
> > -static int tangier_write_fadt(struct acpi_ctx *ctx,
> > -                           const struct acpi_writer *entry)
> > +void acpi_fill_fadt(struct acpi_fadt *fadt)
> >   {
> > -     struct acpi_table_header *header;
> > -     struct acpi_fadt *fadt;
> > -
> > -     fadt =3D ctx->current;
> > -     header =3D &fadt->header;
> > -
> > -     memset(fadt, '\0', sizeof(struct acpi_fadt));
> > -
> > -     acpi_fill_header(header, "FACP");
> > -     header->length =3D sizeof(struct acpi_fadt);
> > -     header->revision =3D 6;
> > -
> >       fadt->preferred_pm_profile =3D ACPI_PM_UNSPECIFIED;
> >
> >       fadt->iapc_boot_arch =3D ACPI_FADT_VGA_NOT_PRESENT |
> > @@ -40,17 +27,9 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
> >               ACPI_FADT_POWER_BUTTON | ACPI_FADT_SLEEP_BUTTON |
> >               ACPI_FADT_SEALED_CASE | ACPI_FADT_HEADLESS |
> >               ACPI_FADT_HW_REDUCED_ACPI;
> > -
> > +     fadt->header.revision =3D 6;
> >       fadt->minor_revision =3D 2;
> > -
> > -     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> > -     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
> > -
> > -     header->checksum =3D table_compute_checksum(fadt, header->length)=
;
> > -
> > -     return acpi_add_fadt(ctx, fadt);
> >   }
> > -ACPI_WRITER(5fadt, "FADT", tangier_write_fadt, 0);
> >
> >   u32 acpi_fill_madt(u32 current)
> >   {
> > diff --git a/arch/x86/include/asm/acpi_table.h b/arch/x86/include/asm/a=
cpi_table.h
> > index e617524617..3988898f66 100644
> > --- a/arch/x86/include/asm/acpi_table.h
> > +++ b/arch/x86/include/asm/acpi_table.h
> > @@ -168,18 +168,6 @@ int acpi_create_dmar_ds_ioapic(struct acpi_ctx *ct=
x, uint enumeration_id,
> >   int acpi_create_dmar_ds_msi_hpet(struct acpi_ctx *ctx, uint enumerati=
on_id,
> >                                pci_dev_t bdf);
> >
> > -/**
> > - * acpi_fadt_common() - Handle common parts of filling out an FADT
> > - *
> > - * This sets up the Fixed ACPI Description Table
> > - *
> > - * @fadt: Pointer to place to put FADT
> > - * @facs: Pointer to the FACS
> > - * @dsdt: Pointer to the DSDT
> > - */
> > -void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
> > -                   void *dsdt);
> > -
> >   /**
> >    * intel_acpi_fill_fadt() - Set up the contents of the FADT
> >    *
> > diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
> > index 08fd1e54ce..ff02ce80d1 100644
> > --- a/arch/x86/lib/acpi_table.c
> > +++ b/arch/x86/lib/acpi_table.c
> > @@ -381,29 +381,6 @@ int acpi_write_hpet(struct acpi_ctx *ctx)
> >       return 0;
> >   }
> >
> > -void acpi_fadt_common(struct acpi_fadt *fadt, struct acpi_facs *facs,
> > -                   void *dsdt)
> > -{
> > -     struct acpi_table_header *header =3D &fadt->header;
> > -
> > -     memset((void *)fadt, '\0', sizeof(struct acpi_fadt));
> > -
> > -     acpi_fill_header(header, "FACP");
> > -     header->length =3D sizeof(struct acpi_fadt);
> > -     header->revision =3D 4;
> > -     memcpy(header->oem_id, OEM_ID, 6);
> > -     memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
> > -     memcpy(header->creator_id, ASLC_ID, 4);
> > -
> > -     fadt->x_firmware_ctrl =3D map_to_sysmem(facs);
> > -     fadt->x_dsdt =3D map_to_sysmem(dsdt);
> > -
> > -     fadt->preferred_pm_profile =3D ACPI_PM_MOBILE;
> > -
> > -     /* Use ACPI 3.0 revision */
> > -     fadt->header.revision =3D 4;
> > -}
> > -
> >   void acpi_create_dmar_drhd(struct acpi_ctx *ctx, uint flags, uint seg=
ment,
> >                          u64 bar)
> >   {
> > diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> > index a372435492..19cf0fb43c 100644
> > --- a/include/acpi/acpi_table.h
> > +++ b/include/acpi/acpi_table.h
> > @@ -954,6 +954,15 @@ void acpi_fill_header(struct acpi_table_header *he=
ader, char *signature);
> >    */
> >   int acpi_fill_csrt(struct acpi_ctx *ctx);
> >
> > +/**
> > + * acpi_fill_fadt() - Fill out the body of the FADT
> > + *
> > + * Must be implemented in SoC specific code or in mainboard code.
> > + *
> > + * @fadt: Pointer to FADT to update
> > + */
> > +void acpi_fill_fadt(struct acpi_fadt *fadt);
> > +
> >   /**
> >    * acpi_get_rsdp_addr() - get ACPI RSDP table address
> >    *
> > diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> > index c9ddcca8cb..9eb0b507a0 100644
> > --- a/lib/acpi/acpi_table.c
> > +++ b/lib/acpi/acpi_table.c
> > @@ -202,6 +202,44 @@ int acpi_add_table(struct acpi_ctx *ctx, void *tab=
le)
> >       return 0;
> >   }
> >
> > +int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *en=
try)
> > +{
> > +     struct acpi_table_header *header;
> > +     struct acpi_fadt *fadt;
> > +
> > +     fadt =3D ctx->current;
> > +     header =3D &fadt->header;
> > +
> > +     memset((void *)fadt, '\0', sizeof(struct acpi_fadt));
> > +
> > +     acpi_fill_header(header, "FACP");
> > +     header->length =3D sizeof(struct acpi_fadt);
> > +     header->revision =3D acpi_get_table_revision(ACPITAB_FADT);
> > +     memcpy(header->oem_id, OEM_ID, 6);
> > +     memcpy(header->oem_table_id, OEM_TABLE_ID, 8);
> > +     memcpy(header->creator_id, ASLC_ID, 4);
> > +     header->creator_revision =3D 1;
> > +
> > +     fadt->x_firmware_ctrl =3D map_to_sysmem(ctx->facs);
> > +     fadt->x_dsdt =3D map_to_sysmem(ctx->dsdt);
> > +
> > +     if (fadt->x_firmware_ctrl < 0x100000000ULL)
> > +             fadt->firmware_ctrl =3D fadt->x_firmware_ctrl;
>
> The ACPI spec requires fadt->firmware_ctrl to be ignored if
> fadt->x_firmware_ctrl is filled.
>
> > +
> > +     if (fadt->x_dsdt < 0x100000000ULL)
> > +             fadt->dsdt =3D fadt->x_dsdt;
>
> The ACPI spec requires fadt->dsdt to be ignored if fadt->x_dsdt is filled=
.
>
This quote is out of context. The ACPI 2.0 spec requires the OS to
ignore DSDT, when X_DSDT is filled.
U-Boot doesn't know which version of the ACPI spec is used by the OS,
thus it must support all versions.

> Overwriting the 32-bit fields if the 64-bit fields are 0 is the wrong
> thing to do. If the 64-bit fields are non-zero it is superfluous.
Since the initial content of DSDT is 0, it's the right thing to do in
order to support ACPI 1.0 OS.
When the OS is ACPI 2.0 compliant it will ignore the DSDT and use
X_DSDT. Does map_to_sysmem() ever
return NULL? It sounds like a bug to me that isn't going to work,
regardless how the pointer is passed to the OS.


>
> Please, remove these lines.
>
> Best regards
>
> Heinrich
>
> > +
> > +     fadt->preferred_pm_profile =3D ACPI_PM_UNSPECIFIED;
> > +
> > +     acpi_fill_fadt(fadt);
> > +
> > +     header->checksum =3D table_compute_checksum(fadt, header->length)=
;
> > +
> > +     return acpi_add_fadt(ctx, fadt);
> > +}
> > +
> > +ACPI_WRITER(5fadt, "FADT", acpi_write_fadt, 0);
> > +
> >   void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
> >                     int port_type, int port_subtype,
> >                     struct acpi_gen_regaddr *address, u32 address_size,
>
