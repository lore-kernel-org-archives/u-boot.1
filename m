Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9304ED3CCB2
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 06:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECD3D803F5;
	Thu, 15 Jan 2026 07:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qn93trTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71AF83015; Thu, 15 Jan 2026 07:49:04 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5444580325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 07:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-644715aad1aso653403d50.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 22:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768459741; x=1769064541; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v2BN7E53OuI8oNBemSz5ckfpzHkdBdac5FZhMU/JVEI=;
 b=qn93trTUkWF0SLuVn8wB5DlPvQn5Pw7lof7Nsh3lBGQSp23FUbjq6RSySfMRBtsTEu
 b1Gf8R8+WYmv9Hae0uqpvRjr6n4Z9nD5EVzyYHOldea1KHhZ0VsayzBOr2c/bLXGSuRO
 259LWIqM1W7DHQd5beRrNQQcySJYKzT0byEE0MBU0SMzDvrvIAZ+aRJeU8/zZtEiGNfC
 8xXWQu/NPKrpqyVLVF2Ejayxq2eDXfqNs4ri/80RQ7y+wC5oW35FH+kswAync6FuM1mZ
 VZ/X2fNVhgVSimHL+BQYtJnKg0J2Ki7TU5IfGfYF4K/d0KUOY0Xl+5hzqx52AsAKQT6O
 J2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768459741; x=1769064541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2BN7E53OuI8oNBemSz5ckfpzHkdBdac5FZhMU/JVEI=;
 b=h4faD/hEqHodAyCdwZlpi0wuH/hHVH2Bf2cphC43d/iKUUkapyoGFFN2N/4UIfDg0/
 RSgW0jw0/zKhU/Fe6ONjVt29NQpm1NNB2/bUL1h6fKV0DOrHfmgFLLaMtn9C2fWWV4qf
 c+P5EX4p2Vd9ppPPG1V/Hxa90u4eUgdi18gcO7cikoGaLkD10bzknrZalN6n3v+N8pU2
 U+n4wXGTWXRGphqpTtc93yfgWgptWT8gFyeQaoyS5y1TR5QG9aJYLN9JVzKSYnKCjdTt
 J7l0cLKjkn0ygB5dxSx/xhAdudBoH/dB4pWHiMBNFXSVU0sQdMt/sslRBfGedLzo8+4C
 7zzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFGiUhJjNn00CbDvqaoXiFoWtvAW67ozTs+e6/I7BthFmt5/cBZlbMzaxgv9UPoj9XuFtABQ4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/HTtvetLqUUehJRvMVVfL5q8esweZfjVl97VqvRNH6HV8kaRx
 DdcgWWR3evtIFMnMwg7WGiW0g95eDgOdUy+XD0lAUeVRZKwcLB3U94HHI5PSw1cbYNUrGsaR8+3
 qHA1VG2Nlu5ZMbZdf1L0j1oJqopkiii/Y5B0bQvmGLQ==
X-Gm-Gg: AY/fxX5Y26p8N/glqFl5yw+psr4sj57j9llvBHZcTY8w2MbcGKAEv4d+GoB31HoLGPJ
 qAiiJmiumlXyHlRV0F8DegcHnNHDs+EsgDXCoJZml1l0AdYnpDr7eXmjSDmYbzeP5vTf6xwqK1T
 3mNvTT8SgSvMRmbK3hPw3LHIEzMidZYfI/XJRUkOqNjSLs/ukZ/63RftMUQKywfkTpv9dlT/GUa
 AdHnOUREQwYP2UhfTztxLdnf1zGZur32uq6SKq/9mlJA2CLfOzUU9fVqlvTqqLZhoEQ4vE5DEB2
 c4U5CzqtzqkoZm520mzkDWNe7riNO196VYrDNc5G98+jUVZcs1Dm+w1RgPbo+K/tWZ2CVvkjgJ6
 hHlgPGJiNBJPMM4WbHvudcvDVqaFQM8Xpc8uCvbPG1+ib8SA9EmmRca89arYQ5de5Vlch5Mt4i3
 n/V5EGbYBi4BxOFXfZFafdZ7ELZSLPa72fx+AZpzo39BAAQKUoDNDumIj6/WZsl/hccF9IgXh/x
 2UcMnD2/+k87Z69vf8ECz62G5pL95Zmw1qZGNN00VaRlUXb6cLHsCYM3DtWYi3pE3y9riPCtgVJ
 Z7d7m2XgVek0eDV3/IE+eqC+Mc+eoPsah7z7vIrUTw==
X-Received: by 2002:a05:690e:130a:b0:644:7175:813d with SMTP id
 956f58d0204a3-6490a62238bmr1478518d50.21.1768459740757; Wed, 14 Jan 2026
 22:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20260107091406.2428132-1-balaji.selvanathan@oss.qualcomm.com>
 <c142ad26-e242-4bbe-a908-842c2076b2f1@linaro.org>
In-Reply-To: <c142ad26-e242-4bbe-a908-842c2076b2f1@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 15 Jan 2026 08:48:24 +0200
X-Gm-Features: AZwV_QizMCCKI6Z1B83PEEnUm5aH7Kqr5WLHT2DjX3t1VqJf5xYwje25qfaFqS0
Message-ID: <CAC_iWjLE0Siz2NYTxh1AHwhpPbQOFvPfP=wb8jVApMD4PP0mqw@mail.gmail.com>
Subject: Re: [PATCH v1] arm: snapdragon: Add EFI reserved memory regions for
 QCS615/QCM6490
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, me@samcday.com, 
 sughosh.ganu@linaro.org, gchan9527@gmail.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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

On Wed, 14 Jan 2026 at 16:44, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> Hi Balaji,
>
> No, we aren't adding platform-specific hardcoded memory maps to U-Boot.
> Reserved memory should be specified in devicetree and added to the EFI
> memory map automatically (Ilias?).

Yes, the reserved memory regions should only be added to the DT. The
EFI subsystem will scan that and mark it as EiReserved
(efi_carve_out_dt_rsv()). We want to keep the DT and the efi memory
mnap in sync

Cheers
/Ilias

>
> Kind regards,
>
> On 07/01/2026 10:14, Balaji Selvanathan wrote:
> > Implemented platform-specific reserved memory registration for EFI on
> > Qualcomm Snapdragon platforms. This adds SoC-specific memory regions
> > to the EFI memory map.
> >
> > Added qcom_reserved_memory.c with predefined memory regions for QCS615
> > and QCM6490/SC7280 SoCs. The implementation detects the SoC type
> > from device tree and registers appropriate memory regions
> > via efi_add_memory_map().
> >
> > Implemented efi_add_known_memory() in board.c to hook into the EFI
> > memory initialization.
> >
> > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > ---
> >  arch/arm/mach-snapdragon/Makefile             |   1 +
> >  arch/arm/mach-snapdragon/board.c              |  15 +++
> >  arch/arm/mach-snapdragon/qcom-priv.h          |  10 ++
> >  .../mach-snapdragon/qcom_reserved_memory.c    | 114 ++++++++++++++++++
> >  4 files changed, 140 insertions(+)
> >  create mode 100644 arch/arm/mach-snapdragon/qcom_reserved_memory.c
> >
> > diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> > index 343e825c6fd..19820a075e8 100644
> > --- a/arch/arm/mach-snapdragon/Makefile
> > +++ b/arch/arm/mach-snapdragon/Makefile
> > @@ -4,4 +4,5 @@
> >
> >  obj-y += board.o
> >  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
> > +obj-$(CONFIG_EFI_LOADER) += qcom_reserved_memory.o
> >  obj-$(CONFIG_OF_LIVE) += of_fixup.o
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> > index 5fb3240acc5..0259623d382 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -709,6 +709,21 @@ static void carve_out_reserved_memory(void)
> >       }
> >  }
> >
> > +#ifdef CONFIG_EFI_LOADER
> > +/**
> > + * efi_add_known_memory() - Add platform-specific reserved memory to EFI map
> > + *
> > + * This function is called by the EFI memory initialization code to allow
> > + * platforms to add their reserved memory regions to the EFI memory map.
> > + * For Qualcomm platforms, this delegates to qcom_add_reserved_memory_to_efi()
> > + * which handles SoC-specific reserved memory regions.
> > + */
> > +void efi_add_known_memory(void)
> > +{
> > +     qcom_add_reserved_memory_to_efi();
> > +}
> > +#endif /* CONFIG_EFI_LOADER */
> > +
> >  /* This function open-codes setup_all_pgtables() so that we can
> >   * insert additional mappings *before* turning on the MMU.
> >   */
> > diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> > index b8bf574e8bb..b488516cfdb 100644
> > --- a/arch/arm/mach-snapdragon/qcom-priv.h
> > +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> > @@ -17,6 +17,16 @@ enum qcom_boot_source {
> >
> >  extern enum qcom_boot_source qcom_boot_source;
> >
> > +#if IS_ENABLED(CONFIG_EFI_LOADER)
> > +/**
> > + * qcom_add_reserved_memory_to_efi() - Add Qualcomm SoC reserved memory to EFI
> > + *
> > + * This function detects the SoC type and adds the appropriate reserved
> > + * memory regions to the EFI memory map. Called from efi_add_known_memory().
> > + */
> > +void qcom_add_reserved_memory_to_efi(void);
> > +#endif /* CONFIG_EFI_LOADER */
> > +
> >  #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> >  void qcom_configure_capsule_updates(void);
> >  #else
> > diff --git a/arch/arm/mach-snapdragon/qcom_reserved_memory.c b/arch/arm/mach-snapdragon/qcom_reserved_memory.c
> > new file mode 100644
> > index 00000000000..e670f74bc1f
> > --- /dev/null
> > +++ b/arch/arm/mach-snapdragon/qcom_reserved_memory.c
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#include <efi_loader.h>
> > +#include <fdt_support.h>
> > +#include <log.h>
> > +#include <linux/sizes.h>
> > +#include <asm/global_data.h>
> > +#include "qcom-priv.h"
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +/**
> > + * struct reserved_mem_region - Reserved memory region descriptor
> > + * @start: Physical start address of the region
> > + * @size: Size of the region in bytes
> > + * @name: Human-readable name for logging
> > + */
> > +struct reserved_mem_region {
> > +     u64 start;
> > +     u64 size;
> > +     const char *name;
> > +};
> > +
> > +/* QCS615 reserved memory regions */
> > +static const struct reserved_mem_region qcs615_reserved[] = {
> > +     { 0x80000000, 0x600000,    "hyp" },
> > +     { 0x85D00000, 0x200000,    "boot" },
> > +     { 0x85F00000, 0x20000,     "aop" },
> > +     { 0x85F40000, 0x30000,     "xbl_dt" },
> > +     { 0x86200000, 0x100000,    "tz_stat" },
> > +     { 0x86300000, 0x1200000,   "tags" },
> > +     { 0x87500000, 0x500000,    "tz" },
> > +     { 0x87A00000, 0x1C00000,   "tzapps" },
> > +     { 0x8AB00000, 0xCC17000,   "pil" },
> > +     { 0xA0000000, 0x1600000,   "secure_dsp" },
> > +};
> > +
> > +/* SC7280/QCM6490 reserved memory regions */
> > +static const struct reserved_mem_region sc7280_reserved[] = {
> > +     { 0x80600000, 0x100000,    "axon_dma" },
> > +     { 0x80894000, 0x40000,     "xbl_dt" },
> > +     { 0x84300000, 0x16B00000,  "pil_reserved" },
> > +     { 0xE1000000, 0x2400000,   "display" },
> > +};
> > +
> > +/**
> > + * add_soc_reserved_memory() - Add SoC-specific reserved memory to EFI map
> > + * @regions: Array of reserved memory regions
> > + * @count: Number of regions in the array
> > + * @soc_name: SoC name for logging
> > + *
> > + * This function iterates through the provided reserved memory regions and
> > + * adds them to the EFI memory map with type EFI_RESERVED_MEMORY_TYPE.
> > + */
> > +static void add_soc_reserved_memory(const struct reserved_mem_region *regions,
> > +                                 int count, const char *soc_name)
> > +{
> > +     int i;
> > +
> > +     log_debug("Adding %s reserved memory to EFI map (%d regions)\n",
> > +               soc_name, count);
> > +
> > +     for (i = 0; i < count; i++) {
> > +             efi_status_t ret;
> > +
> > +             ret = efi_add_memory_map(regions[i].start,
> > +                                      regions[i].size,
> > +                                      EFI_RESERVED_MEMORY_TYPE);
> > +
> > +             if (ret != EFI_SUCCESS) {
> > +                     log_err("%s: Failed to reserve %s (0x%llx-0x%llx): %lu\n",
> > +                             soc_name, regions[i].name,
> > +                             regions[i].start,
> > +                             regions[i].start + regions[i].size,
> > +                             ret & ~EFI_ERROR_MASK);
> > +             } else {
> > +                     log_debug("%s: Reserved %s: 0x%llx-0x%llx (%llu KB)\n",
> > +                               soc_name, regions[i].name,
> > +                               regions[i].start,
> > +                               regions[i].start + regions[i].size,
> > +                               regions[i].size / 1024);
> > +             }
> > +     }
> > +}
> > +
> > +/**
> > + * qcom_add_reserved_memory_to_efi() - Add Qualcomm SoC reserved memory to EFI
> > + *
> > + * This function detects the SoC type from the device tree and adds the
> > + * appropriate reserved memory regions to the EFI memory map.
> > + *
> > + * Supported SoCs:
> > + * - QCS615 (Talos)
> > + * - QCM6490/SC7280 (Kodiak)
> > + */
> > +void qcom_add_reserved_memory_to_efi(void)
> > +{
> > +     /* Detect SoC and add appropriate reserved memory */
> > +     if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs615") == 0) {
> > +             add_soc_reserved_memory(qcs615_reserved,
> > +                                     ARRAY_SIZE(qcs615_reserved),
> > +                                     "QCS615");
> > +     } else if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcm6490") == 0 ||
> > +                fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,sc7280") == 0) {
> > +             add_soc_reserved_memory(sc7280_reserved,
> > +                                     ARRAY_SIZE(sc7280_reserved),
> > +                                     "QCM6490/SC7280");
> > +     } else {
> > +             log_debug("No SoC-specific reserved memory to add\n");
> > +     }
> > +}
>
> --
> // Casey (she/her)
>
