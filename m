Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB007C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 17:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFFBC871C0;
	Wed,  8 Nov 2023 18:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oI28Qqh9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14EBB871E7; Wed,  8 Nov 2023 18:30:39 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66489871AD
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 18:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A8HUR6G092393;
 Wed, 8 Nov 2023 11:30:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699464627;
 bh=QNHxvtCmmkwlXx3YL8SdsUt3IRUgdvHR2xsIYB9zyU8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oI28Qqh9M4jJHvquKW/d/1vasiJklyiFxdaBxg4tFN63vSrtTvw6xWxeZS/8xIsQA
 E/cQvIrkp6qxAY8iAUHUgfA5DPGbv6p8RvXJ8aUd2mnIkf4m0kHw7n06qd5Jpgom2X
 XCq3kkKjQGRXeOHUIZGODRrQPhLFpfDktXszNDyM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A8HURWm073180
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Nov 2023 11:30:27 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Nov 2023 11:30:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Nov 2023 11:30:27 -0600
Received: from [10.250.34.172] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A8HURjl120335;
 Wed, 8 Nov 2023 11:30:27 -0600
Message-ID: <a8ec9dbe-f3a9-4a4e-88b5-a297d576c075@ti.com>
Date: Wed, 8 Nov 2023 11:30:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] board: ti: j721e: During resume spl restores TF-A
 and DM-Firmware
Content-Language: en-US
To: Thomas Richard <thomas.richard@bootlin.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <thomas.petazzoni@bootlin.com>, <gregory.clement@bootlin.com>,
 <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
 <20231107161802.855154-8-thomas.richard@bootlin.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231107161802.855154-8-thomas.richard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 11/7/23 10:18 AM, Thomas Richard wrote:
> During the boot a copy of DM-Firmware is done in a reserved memory
> area before it starts.
> When resuming, R5 SPL uses this copy of DM-Firmware instead of the fit
> image.
> TF-A which saved itself in this same memory area, is restored in
> SRAM by R5 SPL.
> 
> Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> 
> ---
> 
> Changes in v2:
> - Check if TF-A is running in DRAM, if yes no need to restore it
> - Remove BL31_START macro, and get TF-A start address from the fit image
> 
>   arch/arm/mach-k3/common.c                 | 48 ++++++++++++++++++++++-
>   arch/arm/mach-k3/include/mach/j721e_spl.h | 28 +++++++++++++
>   arch/arm/mach-k3/sysfw-loader.c           |  9 +++--
>   3 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index a35110429b..737a1a28c6 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -26,6 +26,7 @@
>   #include <env.h>
>   #include <elf.h>
>   #include <soc.h>
> +#include <hang.h>
>   
>   #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
>   enum {
> @@ -221,6 +222,11 @@ void release_resources_for_core_shutdown(void)
>   	}
>   }
>   
> +__weak int board_is_resuming(void)
> +{
> +	return 0;
> +}
> +
>   void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>   {
>   	typedef void __noreturn (*image_entry_noargs_t)(void);
> @@ -235,6 +241,32 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>   	if (ret)
>   		panic("rproc failed to be initialized (%d)\n", ret);
>   
> +	if (board_is_resuming()) {
> +#if IS_ENABLED(CONFIG_SOC_K3_J721E)
> +		if (!valid_elf_image(LPM_DM_SAVE))
> +			panic("%s: DM-Firmware image is not valid, it cannot be loaded\n",
> +			      __func__);
> +
> +		loadaddr = load_elf_image_phdr(LPM_DM_SAVE);
> +
> +		/*
> +		 * Check if the start address of TF-A is in DRAM.
> +		 * If not it means TF-A was running in SRAM, so it shall be
> +		 * restored.
> +		 */
> +		if (*(ulong *)(LPM_BL31_START_SAVE) < CFG_SYS_SDRAM_BASE)
> +			memcpy((void *)*(uintptr_t *)(LPM_BL31_START_SAVE),
> +			       (void *)LPM_BL31_SAVE, BL31_SIZE);

This will not work. The memory where TF-A is running will be firewalled and
SPL absolutely cannot be securely trusted to load TF-A. Especially from an
unencrypted location in DDR. TF-A must be loaded as it is today using signed
certificate images. You should know this, I explained it all when you tried
the same in TF-A:

https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23992

NAK

Andrew

> +
> +		ret = rproc_load(1, *(ulong *)(LPM_BL31_RESUME_SAVE), BL31_SIZE);
> +		if (ret)
> +			panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
> +
> +		debug("%s: jumping to address %x\n", __func__, loadaddr);
> +		goto start_arm64;
> +#endif
> +	}
> +
>   	init_env();
>   
>   	if (!fit_image_info[IMAGE_ID_DM_FW].image_start) {
> @@ -250,6 +282,10 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>   		fit_image_info[IMAGE_ID_ATF].image_start =
>   			spl_image->entry_point;
>   
> +#if IS_ENABLED(CONFIG_SOC_K3_J721E)
> +	*(uintptr_t *)(LPM_BL31_START_SAVE) = fit_image_info[IMAGE_ID_ATF].image_start;
> +#endif
> +
>   	ret = rproc_load(1, fit_image_info[IMAGE_ID_ATF].image_start, 0x200);
>   	if (ret)
>   		panic("%s: ATF failed to load on rproc (%d)\n", __func__, ret);
> @@ -289,8 +325,18 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>   		loadaddr = load_elf_image_phdr(loadaddr);
>   	} else {
>   		loadaddr = fit_image_info[IMAGE_ID_DM_FW].image_start;
> -		if (valid_elf_image(loadaddr))
> +		if (valid_elf_image(loadaddr)) {
>   			loadaddr = load_elf_image_phdr(loadaddr);
> +#if IS_ENABLED(CONFIG_SOC_K3_J721E)
> +			if (fit_image_info[IMAGE_ID_DM_FW].image_len > (BUFFER_ADDR - LPM_DM_SAVE))
> +				log_warning("%s\n: Not enough space to save DM-Firmware",
> +					    __func__);
> +			else
> +				memcpy((void *)LPM_DM_SAVE,
> +				       (void *)fit_image_info[IMAGE_ID_DM_FW].image_start,
> +					   fit_image_info[IMAGE_ID_DM_FW].image_len);
> +#endif
> +		}
>   	}
>   
>   	debug("%s: jumping to address %x\n", __func__, loadaddr);
> diff --git a/arch/arm/mach-k3/include/mach/j721e_spl.h b/arch/arm/mach-k3/include/mach/j721e_spl.h
> index e8947917a6..8e0f141ed6 100644
> --- a/arch/arm/mach-k3/include/mach/j721e_spl.h
> +++ b/arch/arm/mach-k3/include/mach/j721e_spl.h
> @@ -42,4 +42,32 @@
>   #define K3_PRIMARY_BOOTMODE		0x0
>   #define K3_BACKUP_BOOTMODE		0x1
>   
> +/* Starting buffer address is 1MB before the stack address in DDR */
> +#define BUFFER_ADDR (CONFIG_SPL_STACK_R_ADDR - SZ_1M)
> +
> +/* This is actually the whole size of the SRAM */
> +#define BL31_SIZE    0x20000
> +
> +/* This address belongs to a reserved memory region for the point of view of
> + * Linux, U-boot SPL must use the same address to restore TF-A and resume
> + * entry point address
> + */
> +#define LPM_SAVE		0xA5000000
> +#define LPM_BL31_SAVE		LPM_SAVE
> +#define LPM_BL31_RESUME_SAVE	LPM_BL31_SAVE + BL31_SIZE
> +#define LPM_BL31_START_SAVE	LPM_BL31_RESUME_SAVE + __SIZEOF_POINTER__
> +#define LPM_DM_SAVE		LPM_BL31_START_SAVE  + __SIZEOF_POINTER__
> +
> +/* Check if the copy of TF-A and DM-Firmware in DRAM does not overlap an
> + * over memory section.
> + * The resume address of TF-A is also saved in DRAM.
> + * At build time we don't know the DM-Firmware size, so we keep 512k to
> + * save it.
> + */
> +#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_TARGET_J7200_R5_EVM)
> +#if ((LPM_DM_SAVE + SZ_512K) > BUFFER_ADDR)
> +#error Not enough space to save DM-Firmware, TF-A and context for S2R
> +#endif
> +#endif
> +
>   #endif
> diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
> index 9be2d9eaea..e6d452e590 100644
> --- a/arch/arm/mach-k3/sysfw-loader.c
> +++ b/arch/arm/mach-k3/sysfw-loader.c
> @@ -84,13 +84,16 @@ static bool sysfw_loaded;
>   static void *sysfw_load_address;
>   
>   /*
> - * Populate SPL hook to override the default load address used by the SPL
> - * loader function with a custom address for SYSFW loading.
> + * Populate SPL hook to override the default load address used by the
> + * SPL loader function with a custom address for SYSFW loading. In
> + * other case use also a custom address located in a reserved memory
> + * region. It ensures that Linux memory won't be corrupted by SPL during
> + * suspend to ram.
>    */
>   struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
>   {
>   	if (sysfw_loaded)
> -		return (struct legacy_img_hdr *)(CONFIG_TEXT_BASE + offset);
> +		return (struct legacy_img_hdr *)(BUFFER_ADDR + offset);
>   	else if (sysfw_load_address)
>   		return sysfw_load_address;
>   	else
