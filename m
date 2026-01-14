Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070A6D37E3A
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947B6830E4;
	Wed, 14 Jan 2026 15:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nFXtuRmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46295835B3; Wed, 14 Jan 2026 15:44:10 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E7B8063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so4650623f8f.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768401847; x=1769006647; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7yrBn7IgO40nE8JCoobzDvWtnOiUgspJih2I8UGjtwc=;
 b=nFXtuRmmppVY3chvF9MhSHSX0Ko/pSNgUXb+8e6uLBavaGtYyerozLLCXt4Dpxsm3b
 dPoQyFRQQZrSp/5V1IqPI9qsYHPlyYUQWfDf77lu4XE2wdoGfmCJnvWMWSzlRfefi6nN
 IjQRqkRE03GHngR9PRZ92b7Zn+b3Q07BbftISEdWY97Kb5wxTtEjmtXxpz9TDWS0/tGs
 5dZl1JJ2i3e1t20hmil5v2PuHJWnI0Hl0ad4mCKzqzD71HzvIlTevnE7e0p93kCf9ioD
 OuF95SJWpHLPsT4SDxNi3SXZC6WRlpjUZKFJg0rsMJxp2l0qzVjzcTuSfKy04SRtCqKT
 9WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768401847; x=1769006647;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yrBn7IgO40nE8JCoobzDvWtnOiUgspJih2I8UGjtwc=;
 b=bNwhljIe6ZmP6p/ISBQD4bcjgAncPUsd8Mnt02AMBhQGMVDzA5uA5xeNkYbLqP88f3
 hGe/QLrs3x5L0I6T33dHiMRC4YNf2aXkKcioiG46MSnxH5zuN457FNAEpkFmoocjTQtl
 +Ci9dVMuaGN2NdqnGbnAvt1K2SY6FIAWZV90Mb9RNtl8OX3jQOIus0RfD2yPmoUFspff
 fbs27lItdF3jN1OJmer5WNUeqRTWzrLGGvsZna72oZn+v8R5EyjndXZyYlkDT2DDA8Rq
 gz6LLpnZEVLXKPK6Rtt5GfbO+nZwtu91/TGXC9UY1rVbuf16+41lGwcGE6MFum6WEagr
 rEyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoto7JWQyeHIibYaSytqfUxjw9fywsNQw2opThN6Hp8lIfdxd8+RtjHtynGGB3Isi8x539mk4=@lists.denx.de
X-Gm-Message-State: AOJu0YxEx16CGsbmf28PYEEtnH8ToVuCvmMBV7bf5663b+xvfYzitpz7
 bktFnzgHOh7C6OCTY1P1IBTTgYcxb7gPqXVVv+L7eWyKTWGXwOojybxO/vJaVKouBPw=
X-Gm-Gg: AY/fxX58LYCUpe4KBQZHW0wtM6EQpovsVwYGQFKudpc5QTIkuzGV75IO33bd9cXNwmC
 1KpY+cnX9nmvpJv6+3kvCwOdicRkDV5sCBEil03aMQYIr+pRUFZnbJsBEoJb/CAKdXU3Yb2io4R
 qG9fQzlP4tkh1siML493C76vVRywwjQPBJVFC2otGXKYM6b2ANZktH1nA7vEKqA0rHWh3NMhUzI
 68rhrNMe8rz8YbA8KCCzQtf2D6USvhY6K30G3IDalGn5BQX2XQo6g5o9m+Ja4xAF7N2kT+TUNs+
 7ZM19w/lt1wlRiPJlDZQPrpV/anOADLl5P1tWOHCXG74FVh320EGkX5IMok+L8Y3AyxCpciacbr
 C7u0QpeYSKITtA5hO3AsP1sizYYuestKkLN3/NJ2mmq1Z7r9gXOlRS8dbR5pVn5ibQTaAvoE1dG
 qEUJKPXTw9ztpQOxvdJ/Oq04vtN0jYq4xSb43sT7gWdnjVQ5QatWs=
X-Received: by 2002:a05:6000:230d:b0:42f:b581:c69d with SMTP id
 ffacd0b85a97d-4342c4ef093mr3340634f8f.3.1768401847487; 
 Wed, 14 Jan 2026 06:44:07 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm50489151f8f.33.2026.01.14.06.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:44:06 -0800 (PST)
Message-ID: <c142ad26-e242-4bbe-a908-842c2076b2f1@linaro.org>
Date: Wed, 14 Jan 2026 15:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: snapdragon: Add EFI reserved memory regions for
 QCS615/QCM6490
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 me@samcday.com, sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 gchan9527@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260107091406.2428132-1-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260107091406.2428132-1-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Balaji,

No, we aren't adding platform-specific hardcoded memory maps to U-Boot.
Reserved memory should be specified in devicetree and added to the EFI
memory map automatically (Ilias?).

Kind regards,

On 07/01/2026 10:14, Balaji Selvanathan wrote:
> Implemented platform-specific reserved memory registration for EFI on
> Qualcomm Snapdragon platforms. This adds SoC-specific memory regions
> to the EFI memory map.
> 
> Added qcom_reserved_memory.c with predefined memory regions for QCS615
> and QCM6490/SC7280 SoCs. The implementation detects the SoC type
> from device tree and registers appropriate memory regions
> via efi_add_memory_map().
> 
> Implemented efi_add_known_memory() in board.c to hook into the EFI
> memory initialization.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Makefile             |   1 +
>  arch/arm/mach-snapdragon/board.c              |  15 +++
>  arch/arm/mach-snapdragon/qcom-priv.h          |  10 ++
>  .../mach-snapdragon/qcom_reserved_memory.c    | 114 ++++++++++++++++++
>  4 files changed, 140 insertions(+)
>  create mode 100644 arch/arm/mach-snapdragon/qcom_reserved_memory.c
> 
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 343e825c6fd..19820a075e8 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -4,4 +4,5 @@
>  
>  obj-y += board.o
>  obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
> +obj-$(CONFIG_EFI_LOADER) += qcom_reserved_memory.o
>  obj-$(CONFIG_OF_LIVE) += of_fixup.o
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..0259623d382 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -709,6 +709,21 @@ static void carve_out_reserved_memory(void)
>  	}
>  }
>  
> +#ifdef CONFIG_EFI_LOADER
> +/**
> + * efi_add_known_memory() - Add platform-specific reserved memory to EFI map
> + *
> + * This function is called by the EFI memory initialization code to allow
> + * platforms to add their reserved memory regions to the EFI memory map.
> + * For Qualcomm platforms, this delegates to qcom_add_reserved_memory_to_efi()
> + * which handles SoC-specific reserved memory regions.
> + */
> +void efi_add_known_memory(void)
> +{
> +	qcom_add_reserved_memory_to_efi();
> +}
> +#endif /* CONFIG_EFI_LOADER */
> +
>  /* This function open-codes setup_all_pgtables() so that we can
>   * insert additional mappings *before* turning on the MMU.
>   */
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index b8bf574e8bb..b488516cfdb 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -17,6 +17,16 @@ enum qcom_boot_source {
>  
>  extern enum qcom_boot_source qcom_boot_source;
>  
> +#if IS_ENABLED(CONFIG_EFI_LOADER)
> +/**
> + * qcom_add_reserved_memory_to_efi() - Add Qualcomm SoC reserved memory to EFI
> + *
> + * This function detects the SoC type and adds the appropriate reserved
> + * memory regions to the EFI memory map. Called from efi_add_known_memory().
> + */
> +void qcom_add_reserved_memory_to_efi(void);
> +#endif /* CONFIG_EFI_LOADER */
> +
>  #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>  void qcom_configure_capsule_updates(void);
>  #else
> diff --git a/arch/arm/mach-snapdragon/qcom_reserved_memory.c b/arch/arm/mach-snapdragon/qcom_reserved_memory.c
> new file mode 100644
> index 00000000000..e670f74bc1f
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/qcom_reserved_memory.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <efi_loader.h>
> +#include <fdt_support.h>
> +#include <log.h>
> +#include <linux/sizes.h>
> +#include <asm/global_data.h>
> +#include "qcom-priv.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/**
> + * struct reserved_mem_region - Reserved memory region descriptor
> + * @start: Physical start address of the region
> + * @size: Size of the region in bytes
> + * @name: Human-readable name for logging
> + */
> +struct reserved_mem_region {
> +	u64 start;
> +	u64 size;
> +	const char *name;
> +};
> +
> +/* QCS615 reserved memory regions */
> +static const struct reserved_mem_region qcs615_reserved[] = {
> +	{ 0x80000000, 0x600000,    "hyp" },
> +	{ 0x85D00000, 0x200000,    "boot" },
> +	{ 0x85F00000, 0x20000,     "aop" },
> +	{ 0x85F40000, 0x30000,     "xbl_dt" },
> +	{ 0x86200000, 0x100000,    "tz_stat" },
> +	{ 0x86300000, 0x1200000,   "tags" },
> +	{ 0x87500000, 0x500000,    "tz" },
> +	{ 0x87A00000, 0x1C00000,   "tzapps" },
> +	{ 0x8AB00000, 0xCC17000,   "pil" },
> +	{ 0xA0000000, 0x1600000,   "secure_dsp" },
> +};
> +
> +/* SC7280/QCM6490 reserved memory regions */
> +static const struct reserved_mem_region sc7280_reserved[] = {
> +	{ 0x80600000, 0x100000,    "axon_dma" },
> +	{ 0x80894000, 0x40000,     "xbl_dt" },
> +	{ 0x84300000, 0x16B00000,  "pil_reserved" },
> +	{ 0xE1000000, 0x2400000,   "display" },
> +};
> +
> +/**
> + * add_soc_reserved_memory() - Add SoC-specific reserved memory to EFI map
> + * @regions: Array of reserved memory regions
> + * @count: Number of regions in the array
> + * @soc_name: SoC name for logging
> + *
> + * This function iterates through the provided reserved memory regions and
> + * adds them to the EFI memory map with type EFI_RESERVED_MEMORY_TYPE.
> + */
> +static void add_soc_reserved_memory(const struct reserved_mem_region *regions,
> +				    int count, const char *soc_name)
> +{
> +	int i;
> +
> +	log_debug("Adding %s reserved memory to EFI map (%d regions)\n",
> +		  soc_name, count);
> +
> +	for (i = 0; i < count; i++) {
> +		efi_status_t ret;
> +
> +		ret = efi_add_memory_map(regions[i].start,
> +					 regions[i].size,
> +					 EFI_RESERVED_MEMORY_TYPE);
> +
> +		if (ret != EFI_SUCCESS) {
> +			log_err("%s: Failed to reserve %s (0x%llx-0x%llx): %lu\n",
> +				soc_name, regions[i].name,
> +				regions[i].start,
> +				regions[i].start + regions[i].size,
> +				ret & ~EFI_ERROR_MASK);
> +		} else {
> +			log_debug("%s: Reserved %s: 0x%llx-0x%llx (%llu KB)\n",
> +				  soc_name, regions[i].name,
> +				  regions[i].start,
> +				  regions[i].start + regions[i].size,
> +				  regions[i].size / 1024);
> +		}
> +	}
> +}
> +
> +/**
> + * qcom_add_reserved_memory_to_efi() - Add Qualcomm SoC reserved memory to EFI
> + *
> + * This function detects the SoC type from the device tree and adds the
> + * appropriate reserved memory regions to the EFI memory map.
> + *
> + * Supported SoCs:
> + * - QCS615 (Talos)
> + * - QCM6490/SC7280 (Kodiak)
> + */
> +void qcom_add_reserved_memory_to_efi(void)
> +{
> +	/* Detect SoC and add appropriate reserved memory */
> +	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs615") == 0) {
> +		add_soc_reserved_memory(qcs615_reserved,
> +					ARRAY_SIZE(qcs615_reserved),
> +					"QCS615");
> +	} else if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcm6490") == 0 ||
> +		   fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,sc7280") == 0) {
> +		add_soc_reserved_memory(sc7280_reserved,
> +					ARRAY_SIZE(sc7280_reserved),
> +					"QCM6490/SC7280");
> +	} else {
> +		log_debug("No SoC-specific reserved memory to add\n");
> +	}
> +}

-- 
// Casey (she/her)

