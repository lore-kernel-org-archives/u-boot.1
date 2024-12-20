Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EE7E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 20:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B065804F9;
	Fri, 20 Dec 2024 21:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mz3r1tA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25EB804FC; Fri, 20 Dec 2024 21:50:28 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B4A8048D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 21:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so1918866a91.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 12:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734727824; x=1735332624; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MSUjyeWZz/1L/CpIPVJhI9clMJOrCOv34U3TIzRHkgE=;
 b=Mz3r1tA+kudsZ6iTt3btLiUaKadrcrC/hEcp1eCOKaXFIn4rjUWrQ8pPzqAPq2AeoX
 f1GGyy1N1Mf7rMC9rxtdDjE/uyHmCLEM9Bps9LZCnIOWggl7i3iGfC7WRW6IVYU4izMO
 kRuO7fNGHgF13FsQipAo5pUkViz1kg1IvrL0JwO15SzK0Uk5VvP7WHYpttpZMP6wi/cr
 IIQdmygaMloX/DbkrLmsbd6vw/SIb/T2m4czfxa1MJwORfS/T2sEDutFb/OF0oyK4hcZ
 S+pMdUzryEB+uSw356YyiOC/ka5oru9EQl58YeDOdd/dq+799mZcOSNuA2EpfAlU+580
 wfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734727824; x=1735332624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MSUjyeWZz/1L/CpIPVJhI9clMJOrCOv34U3TIzRHkgE=;
 b=INtbUQKBCFOCboqQ7aRex9mRDQ4up+ycGfjSGOI0E75c43VXjMLtfhugZ0Di7PRXQ6
 ZXacUnEVDy0ltWBDYVkB0gq8GwUq1B6T412GZwpmJ3ksARs3fg5uLsaR51VOzB6LYxDr
 uw7mGSkYWl3AbkDaaGdlgMiQBH6Aw40AEdCChmPEqGywaOSNbyDmX8irvJ/H3JDQrrX1
 6IVQzEPfW2zyJTuMWn772hMm/m6QfpoUV/JYJASlwO8gXUy4LqWspNnsXXLKdOSRP8AH
 a1mzfwU33R0n85UXc+Pm8Z4LZr/+6WN+LW0fGxxvERxjPJNGOItDNC7SnaZFnD61xexE
 6iMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX7fz4K3QO1iEMY3X2Dnr9ayyzhEbHePgoQWj7bZxUexgMUxjLUbeCD3XUlh2Zk7YjZvX3i/8=@lists.denx.de
X-Gm-Message-State: AOJu0YzzmGyaLrAzvYB2hTA6I40JCvb7V4BFUcyC8V2reC94VuKpHJgp
 li/Nq3Ff+7Ui1n1hLgX+ifto/ZdAfTZA5PKRGPQh1v52eS2CaAjxXBUD2A6SVoO2KbmQNpc1fht
 VznmcXMj7woLsUEaVqZA78ZF6k11+C4jUMiLVog==
X-Gm-Gg: ASbGncur54sk5BGnhMicKCbbCI2Q6LyRoaFaAIMajjP22/ava5penFvDTviTMSroWJx
 WBLvy7IPN5EYlqQX1+3EeCJIN0SCKUasjmp+pZfwg0Oc+bTU8qAQZ2zaY9dxGGDZb3oyOm9Y=
X-Google-Smtp-Source: AGHT+IGFUrlWdOUsrzr+04KiZleLFRdbhpTCuv3egUChQaaFzY1Dsy56bE4Ev0LViHCIPWrj9m6WQBArWXITu+HWh8I=
X-Received: by 2002:a17:90b:2c8b:b0:2ee:edae:775 with SMTP id
 98e67ed59e1d1-2f4536030e3mr6012572a91.3.1734727823750; Fri, 20 Dec 2024
 12:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20241206225438.13866-1-raymond.mao@linaro.org>
 <20241206225438.13866-8-raymond.mao@linaro.org>
 <5b317e3d-7c1c-414e-9070-b76e306cca7f@gmx.de>
In-Reply-To: <5b317e3d-7c1c-414e-9070-b76e306cca7f@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 20 Dec 2024 15:50:12 -0500
Message-ID: <CAEfUkUJudUwcUYT1TrVFERLJedG2DOdbqDcmC6a=Q8v3_8ieGQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] armv8: Add arch-specific sysinfo platform driver
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 19 Dec 2024 at 11:05, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 06.12.24 23:54, Raymond Mao wrote:
> > Add sysinfo platform driver for all armv8 platforms to retrieve
> > hardware information on processor and cache.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> > Changes in v2
> > - Combine with #8(v1) patch.
> > - Remove the handling of the common strings and values.
> > Changes in v3
> > - None.
> >
> >   arch/arm/cpu/armv8/Makefile  |   2 +
> >   arch/arm/cpu/armv8/sysinfo.c | 292 +++++++++++++++++++++++++++++++++++
> >   2 files changed, 294 insertions(+)
> >   create mode 100644 arch/arm/cpu/armv8/sysinfo.c
> >
> > diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> > index 2e71ff2dc97..b4126c61df1 100644
> > --- a/arch/arm/cpu/armv8/Makefile
> > +++ b/arch/arm/cpu/armv8/Makefile
> > @@ -46,3 +46,5 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
> >   obj-$(CONFIG_XEN) += xen/
> >   obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
> >   obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
> > +
> > +obj-$(CONFIG_SYSINFO_SMBIOS) += sysinfo.o
> > diff --git a/arch/arm/cpu/armv8/sysinfo.c b/arch/arm/cpu/armv8/sysinfo.c
> > new file mode 100644
> > index 00000000000..850142da37d
> > --- /dev/null
> > +++ b/arch/arm/cpu/armv8/sysinfo.c
> > @@ -0,0 +1,292 @@
> > +// SPDX-License-Identifier: GPL-2.0+
>
> GPL-2.0-or-later
> see https://spdx.org/licenses/LGPL-2.0-or-later.html
>
> > +/*
> > + * Copyright (c) 2024 Linaro Limited
> > + * Author: Raymond Mao <raymond.mao@linaro.org>
> > + */
> > +#include <dm.h>
> > +#include <smbios_plat.h>
> > +#include <stdio.h>
> > +#include <sysinfo.h>
> > +
> > +union ccsidr_el1 {
> > +     struct {
> > +             u64 linesize:3;
> > +             u64 associativity:10;
> > +             u64 numsets:15;
> > +             u64 unknown:4;
> > +             u64 reserved:32;
> > +     } no_ccidx;
> > +     struct {
> > +             u64 linesize:3;
> > +             u64 associativity:21;
> > +             u64 reserved1:8;
> > +             u64 numsets:24;
> > +             u64 reserved2:8;
> > +     } ccidx_aarch64;
> > +     struct {
> > +             u64 linesize:3;
> > +             u64 associativity:21;
> > +             u64 reserved:8;
> > +             u64 unallocated:32;
> > +     } ccidx_aarch32;
> > +     u64 data;
> > +};
> > +
> > +union midr_el1 {
> > +     struct {
> > +             u64 revision:4;
> > +             u64 partnum:12;
> > +             u64 architecture:4;
> > +             u64 variant:4;
> > +             u64 implementer:8;
> > +             u64 reserved:32;
> > +     } fields;
> > +     u64 data;
> > +};
> > +
> > +enum {
> > +     CACHE_NONE,
> > +     CACHE_INST_ONLY,
> > +     CACHE_DATA_ONLY,
> > +     CACHE_INST_WITH_DATA,
> > +     CACHE_UNIFIED,
> > +};
> > +
> > +enum {
> > +     CACHE_ASSOC_DIRECT_MAPPED = 1,
> > +     CACHE_ASSOC_2WAY = 2,
> > +     CACHE_ASSOC_4WAY = 4,
> > +     CACHE_ASSOC_8WAY = 8,
> > +     CACHE_ASSOC_16WAY = 16,
> > +     CACHE_ASSOC_12WAY = 12,
> > +     CACHE_ASSOC_24WAY = 24,
> > +     CACHE_ASSOC_32WAY = 32,
> > +     CACHE_ASSOC_48WAY = 48,
> > +     CACHE_ASSOC_64WAY = 64,
> > +     CACHE_ASSOC_20WAY = 20,
> > +};
> > +
> > +enum {
> > +     VENDOR_RESERVED = 0,
> > +     VENDOR_ARM = 0x41,
> > +     VENDOR_BROADCOM = 0x42,
> > +     VENDOR_CAVIUM = 0x43,
> > +     VENDOR_DEC = 0x44,
> > +     VENDOR_FUJITSU = 0x46,
> > +     VENDOR_INFINEON = 0x49,
> > +     VENDOR_FREESCALE = 0x4d,
> > +     VENDOR_NVIDIA = 0x4e,
> > +     VENDOR_AMCC = 0x50,
> > +     VENDOR_QUALCOMM = 0x51,
> > +     VENDOR_MARVELL = 0x56,
> > +     VENDOR_INTEL = 0x69,
> > +     VENDOR_AMPERE = 0xc0,
> > +};
> > +
> > +/*
> > + * TODO:
> > + * To support ARMv8.3, we need to read "CCIDX, bits [23:20]" from
> > + * ID_AA64MMFR2_EL1 to get the format of CCSIDR_EL1:
> > + *
> > + * 0b0000 - 32-bit format implemented for all levels of the CCSIDR_EL1.
> > + * 0b0001 - 64-bit format implemented for all levels of the CCSIDR_EL1.
> > + *
> > + * Here we assume to use CCSIDR_EL1 in no CCIDX layout:
> > + * NumSets, bits [27:13]: (Number of sets in cache) - 1
> > + * Associativity, bits [12:3]: (Associativity of cache) - 1
> > + * LineSize, bits [2:0]: (Log2(Number of bytes in cache line)) - 4
> > + */
> > +int sysinfo_get_cache_info(u8 level, struct cache_info *cinfo)
> > +{
> > +     u64 clidr_el1;
> > +     u32 csselr_el1;
> > +     u32 num_sets;
> > +     union ccsidr_el1 creg;
> > +     int cache_type;
> > +
> > +     sysinfo_cache_info_default(cinfo);
> > +
> > +     /* Read CLIDR_EL1 */
> > +     asm volatile("mrs %0, clidr_el1" : "=r" (clidr_el1));
> > +     debug("CLIDR_EL1: 0x%llx\n", clidr_el1);
> > +
> > +     cache_type = (clidr_el1 >> (3 * level)) & 0x7;
> > +     if (cache_type == CACHE_NONE) /* level does not exist */
> > +             return -1;
> > +
> > +     switch (cache_type) {
> > +     case CACHE_INST_ONLY:
> > +             cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_INST;
> > +             break;
> > +     case CACHE_DATA_ONLY:
> > +             cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_DATA;
> > +             break;
> > +     case CACHE_UNIFIED:
> > +             cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNIFIED;
> > +             break;
> > +     case CACHE_INST_WITH_DATA:
> > +             cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_OTHER;
> > +             break;
> > +     default:
> > +             cinfo->cache_type = SMBIOS_CACHE_SYSCACHE_TYPE_UNKNOWN;
> > +             break;
> > +     }
> > +
> > +     /* Select cache level */
> > +     csselr_el1 = (level << 1);
> > +     asm volatile("msr csselr_el1, %0" : : "r" (csselr_el1));
> > +
> > +     /* Read CCSIDR_EL1 */
> > +     asm volatile("mrs %0, ccsidr_el1" : "=r" (creg.data));
> > +     debug("CCSIDR_EL1 (Level %d): 0x%llx\n", level + 1, creg.data);
> > +
> > +     /* Extract cache size and associativity */
> > +     cinfo->line_size = 1 << (creg.no_ccidx.linesize + 4);
> > +
> > +     /* Map the associativity value */
> > +     switch (creg.no_ccidx.associativity + 1) {
> > +     case CACHE_ASSOC_DIRECT_MAPPED:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_DMAPPED;
> > +             break;
> > +     case CACHE_ASSOC_2WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_2WAY;
> > +             break;
> > +     case CACHE_ASSOC_4WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_4WAY;
> > +             break;
> > +     case CACHE_ASSOC_8WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_8WAY;
> > +             break;
> > +     case CACHE_ASSOC_16WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_16WAY;
> > +             break;
> > +     case CACHE_ASSOC_12WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_12WAY;
> > +             break;
> > +     case CACHE_ASSOC_24WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_24WAY;
> > +             break;
> > +     case CACHE_ASSOC_32WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_32WAY;
> > +             break;
> > +     case CACHE_ASSOC_48WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_48WAY;
> > +             break;
> > +     case CACHE_ASSOC_64WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_64WAY;
> > +             break;
> > +     case CACHE_ASSOC_20WAY:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_20WAY;
> > +             break;
> > +     default:
> > +             cinfo->associativity = SMBIOS_CACHE_ASSOC_UNKNOWN;
> > +             break;
> > +     }
> > +
> > +     num_sets = creg.no_ccidx.numsets + 1;
> > +     /* Size in KB */
> > +     cinfo->max_size = (cinfo->associativity * num_sets *
> cinfo->line_size) /
> > +                       1024;
> > +
> > +     debug("L%d Cache:\n", level + 1);
> > +     debug("Number of bytes in cache line:%u\n", cinfo->line_size);
> > +     debug("Associativity of cache:%u\n", cinfo->associativity);
> > +     debug("Number of sets in cache:%u\n", num_sets);
> > +     debug("Cache size in KB:%u\n", cinfo->max_size);
> > +
> > +     cinfo->inst_size = cinfo->max_size;
> > +
> > +     /*
> > +      * Below fields with common values are placed under DT smbios node
>
> As I have seen nodes /smbios and /smbios/smbios, please, be specific. Do
> you mean:
>
> The following properties are provided in the /smbios device-tree node:
>
>
Yes. I will add a description on the node name and expected structure into
the
commit message of the next version.
Actually you can find this in one of the patches of the series with a newly
created
dtsi file.


> > +      * socket-design, config
> > +      * Other fields are typically specific to the implementation of
> the ARM
> > +      * processor by the silicon vendor:
> > +      * supp_sram_type, curr_sram_type, speed, err_corr_type
>
> It is not clear what you mean.
>
> Don't these properties appear in the /smbios node? Where would they be
> found?
>
>
Ditto. They are in the smbios node. I will add this information into the
commit
message.


> > +      */
> > +
> > +     return 0;
> > +}
> > +
> > +int sysinfo_get_processor_info(struct processor_info *pinfo)
> > +{
> > +     u64 mpidr, core_count;
> > +     union midr_el1 midr;
> > +
> > +     /* Read the MIDR_EL1 register */
> > +     asm volatile("mrs %0, MIDR_EL1" : "=r"(midr.data));
> > +     /* Read the MPIDR_EL1 register */
> > +     asm volatile("mrs %0, MPIDR_EL1" : "=r"(mpidr));
> > +
> > +     debug("MIDR: 0x%016llx\n", midr.data);
> > +     debug("MPIDR: 0x%016llx\n", mpidr);
> > +     debug("CPU Implementer: 0x%02x\n", midr.fields.implementer);
> > +
> > +     switch (midr.fields.implementer) {
> > +     case VENDOR_ARM:
> > +             pinfo->manufacturer = "ARM Limited";
> > +             break;
> > +     case VENDOR_BROADCOM:
> > +             pinfo->manufacturer = "Broadcom Corporation";
> > +             break;
> > +     case VENDOR_CAVIUM:
> > +             pinfo->manufacturer = "Cavium Inc";
> > +             break;
> > +     case VENDOR_DEC:
> > +             pinfo->manufacturer = "Digital Equipment Corporation";
> > +             break;
> > +     case VENDOR_FUJITSU:
> > +             pinfo->manufacturer = "Fujitsu Ltd";
> > +             break;
> > +     case VENDOR_INFINEON:
> > +             pinfo->manufacturer = "Infineon Technologies AG";
> > +             break;
> > +     case VENDOR_FREESCALE:
> > +             pinfo->manufacturer = "Freescale Semiconductor Inc";
> > +             break;
> > +     case VENDOR_NVIDIA:
> > +             pinfo->manufacturer = "NVIDIA Corporation";
> > +             break;
> > +     case VENDOR_AMCC:
> > +             pinfo->manufacturer =
> > +                     "Applied Micro Circuits Corporation";
> > +             break;
> > +     case VENDOR_QUALCOMM:
> > +             pinfo->manufacturer = "Qualcomm Inc";
> > +             break;
> > +     case VENDOR_MARVELL:
> > +             pinfo->manufacturer = "Marvell International Ltd";
> > +             break;
> > +     case VENDOR_INTEL:
> > +             pinfo->manufacturer = "Intel Corporation";
> > +             break;
> > +     case VENDOR_AMPERE:
> > +             pinfo->manufacturer = "Ampere Computing";
> > +             break;
> > +     default:
> > +             pinfo->manufacturer = "Unknown";
>
> Should we write the numerical number to a string here? E.g.
>
> 'Manufacturer %d'
>
>
Do you mean for the default? Maybe not, since the spec does not describe
this. "Unknown" should be fine.


> > +             break;
> > +     }
> > +     debug("CPU part number: 0x%x\n", midr.fields.partnum);
> > +     debug("CPU revision: 0x%x\n", midr.fields.revision);
> > +     debug("CPU architecture: 0x%x\n", midr.fields.architecture);
> > +     debug("CPU variant: 0x%x\n", midr.fields.variant);
> > +
> > +     /* Extract number of cores */
> > +     core_count = (mpidr >> 0) & 0xFF;
> > +     pinfo->core_count = core_count + 1;
> > +     debug("CPU Core Count: %d\n", pinfo->core_count);
> > +
> > +     pinfo->core_enabled = pinfo->core_count;
> > +     pinfo->characteristics = SMBIOS_PROCESSOR_64BIT |
> > +             SMBIOS_PROCESSOR_ARM64_SOCID;
> > +     if (pinfo->core_count > 1)
> > +             pinfo->characteristics |= SMBIOS_PROCESSOR_MULTICORE;
> > +
> > +     /*
> > +      * Below fields with common values are placed under DT smbios node
> > +      * version, processor-type, processor-status, upgrade, family2,
> > +      * socket-design, serial, asset-tag, part-number
>
> The following properties are provided in the /smbios device-tree node:
>
> Yes, I can add this into the comment.

Regards,
Raymond
