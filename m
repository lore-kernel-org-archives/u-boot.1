Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51E4D3CCAF
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 06:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D951803F5;
	Thu, 15 Jan 2026 07:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RJdGiYEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED9D82C7F; Thu, 15 Jan 2026 07:36:22 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19A580325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 07:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FAEF440E4;
 Thu, 15 Jan 2026 06:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E42AC19423;
 Thu, 15 Jan 2026 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768458978;
 bh=7Te/l0L8L8mzInk9017wKPBDCkcW9oYC4kFk9ep6/8c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RJdGiYEVznTGrCfSjQ4htRoStqPZb3wiXpARTmb9K06tLzpQ5IhNkBZ8xRb2pW5rO
 Unlz5XZ2CUC8qnHnmrvyFLcjkwBb9Xc7/N+cneEr8wwmwgH/Y5aTyhTy/RHdyq7r5w
 4QS6gR/XIKAaU1/xOJZM8lNnNhc7zDexjKqDt+H5ku6esmDwSU07+Gufm3x7xZnzo8
 /YopKUNXyAxV5UsusKrB3Vmtpg5dW77PyUzgP8bKY7Yc766SAnsLCasdx6isHMzxsH
 rQGsgHVOW4be/kAc8Rc86q5CKxcdiUDCtYYBLicizglZMeXhqxMNruMw1cfKkrDIuT
 QJuWy1JVKnw6w==
Date: Thu, 15 Jan 2026 12:06:11 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, me@samcday.com,
 sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 gchan9527@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: snapdragon: Add EFI reserved memory regions for
 QCS615/QCM6490
Message-ID: <aWiK29lyQFpy4YjC@sumit-xelite>
References: <20260107091406.2428132-1-balaji.selvanathan@oss.qualcomm.com>
 <c142ad26-e242-4bbe-a908-842c2076b2f1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c142ad26-e242-4bbe-a908-842c2076b2f1@linaro.org>
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

On Wed, Jan 14, 2026 at 03:44:05PM +0100, Casey Connolly wrote:
> Hi Balaji,
> 
> No, we aren't adding platform-specific hardcoded memory maps to U-Boot.
> Reserved memory should be specified in devicetree and added to the EFI
> memory map automatically (Ilias?).

Linux Qcom DT maintainers are trying to avoid reserved memory info being
added to DT (see thread here [1]). I suppose the pain comes in when some
firmware requirements change and the reserved memory layout needs
update.

Generally it's better for the UEFI firmware to communicate that info to
the OS via EFI memory map. However, you have a valid point that
hardcoding the reserved memory ranges in U-Boot is like shifting that
pain to U-Boot. IIUC, generally this memory reseversation on Qcom
platforms happens during the XBL phase for HYP/QTEE/PIL etc.

Balaji,

Is there a way for this reserved memory information passed via SMEM from
XBL for later stages to consume?

[1] https://lore.kernel.org/all/ahbbg3pffedrjzvksgz2jv7lwajwlcxc6nsmmtunwc4346eawa@xayff4ozvdbn/#t

-Sumit

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
> >  	}
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
> > +	qcom_add_reserved_memory_to_efi();
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
> > +	u64 start;
> > +	u64 size;
> > +	const char *name;
> > +};
> > +
> > +/* QCS615 reserved memory regions */
> > +static const struct reserved_mem_region qcs615_reserved[] = {
> > +	{ 0x80000000, 0x600000,    "hyp" },
> > +	{ 0x85D00000, 0x200000,    "boot" },
> > +	{ 0x85F00000, 0x20000,     "aop" },
> > +	{ 0x85F40000, 0x30000,     "xbl_dt" },
> > +	{ 0x86200000, 0x100000,    "tz_stat" },
> > +	{ 0x86300000, 0x1200000,   "tags" },
> > +	{ 0x87500000, 0x500000,    "tz" },
> > +	{ 0x87A00000, 0x1C00000,   "tzapps" },
> > +	{ 0x8AB00000, 0xCC17000,   "pil" },
> > +	{ 0xA0000000, 0x1600000,   "secure_dsp" },
> > +};
> > +
> > +/* SC7280/QCM6490 reserved memory regions */
> > +static const struct reserved_mem_region sc7280_reserved[] = {
> > +	{ 0x80600000, 0x100000,    "axon_dma" },
> > +	{ 0x80894000, 0x40000,     "xbl_dt" },
> > +	{ 0x84300000, 0x16B00000,  "pil_reserved" },
> > +	{ 0xE1000000, 0x2400000,   "display" },
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
> > +				    int count, const char *soc_name)
> > +{
> > +	int i;
> > +
> > +	log_debug("Adding %s reserved memory to EFI map (%d regions)\n",
> > +		  soc_name, count);
> > +
> > +	for (i = 0; i < count; i++) {
> > +		efi_status_t ret;
> > +
> > +		ret = efi_add_memory_map(regions[i].start,
> > +					 regions[i].size,
> > +					 EFI_RESERVED_MEMORY_TYPE);
> > +
> > +		if (ret != EFI_SUCCESS) {
> > +			log_err("%s: Failed to reserve %s (0x%llx-0x%llx): %lu\n",
> > +				soc_name, regions[i].name,
> > +				regions[i].start,
> > +				regions[i].start + regions[i].size,
> > +				ret & ~EFI_ERROR_MASK);
> > +		} else {
> > +			log_debug("%s: Reserved %s: 0x%llx-0x%llx (%llu KB)\n",
> > +				  soc_name, regions[i].name,
> > +				  regions[i].start,
> > +				  regions[i].start + regions[i].size,
> > +				  regions[i].size / 1024);
> > +		}
> > +	}
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
> > +	/* Detect SoC and add appropriate reserved memory */
> > +	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs615") == 0) {
> > +		add_soc_reserved_memory(qcs615_reserved,
> > +					ARRAY_SIZE(qcs615_reserved),
> > +					"QCS615");
> > +	} else if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcm6490") == 0 ||
> > +		   fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,sc7280") == 0) {
> > +		add_soc_reserved_memory(sc7280_reserved,
> > +					ARRAY_SIZE(sc7280_reserved),
> > +					"QCM6490/SC7280");
> > +	} else {
> > +		log_debug("No SoC-specific reserved memory to add\n");
> > +	}
> > +}
> 
> -- 
> // Casey (she/her)
> 
