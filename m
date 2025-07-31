Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936B0C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 07:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8948334A;
	Thu, 31 Jul 2025 09:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IE9qBiJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73E7833C6; Thu, 31 Jul 2025 09:13:51 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DCC8318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V7Dijj2946607;
 Thu, 31 Jul 2025 02:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753946024;
 bh=nFrmXVUT+be1IK19r1/mIv+jytoBTYwWOx9fTa/SnfM=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=IE9qBiJuQMRh/5wxC8FFsSdwgwdud3m3SdDerV0m1n53SNMSyEGCEitSLn686sVui
 xR+13TenKUUNPytYAdiQM4qazQOyTQW0fVyK3sR4b/z2T08l+sBvTMW/uu1yHUyCMJ
 sGB5QaWPGNZPZM5AzZuC8DBkhAzZuOmqxgLyOY4M=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V7DiOh3139283
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 02:13:44 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 02:13:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 02:13:43 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V7Dflf2209713;
 Thu, 31 Jul 2025 02:13:42 -0500
Message-ID: <7195b4ed-541e-4886-8958-b81e5bbeb2cd@ti.com>
Date: Thu, 31 Jul 2025 12:43:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disk: efi_loader: Add function to detect disk image type
To: Javier Tia <javier.tia@linaro.org>, <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
References: <20250730224942.755510-1-javier.tia@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250730224942.755510-1-javier.tia@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Javier

On 31/07/25 04:19, Javier Tia wrote:
> This commit introduces a new function, detect_disk_image_type(), which
> checks if a buffer contains a disk image. This function is used to
> detect disk images based on their headers, rather than relying on file
> extensions.
> 
> The function checks for ISO 9660, DOS MBR, and GPT protective MBR
> signatures. It returns 1 if a disk image is detected, and 0 otherwise.
> 
> This function is then used in the efi_bootmgr.c file to determine if a
> downloaded file is a PE-COFF image or a disk image. This change
> improves the reliability of disk image detection, as it no longer
> relies on file extensions, which can be easily changed or omitted.
> 
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>  disk/part.c                  | 46 ++++++++++++++++++++++++++++++++++++
>  include/part.h               |  9 +++++++
>  lib/efi_loader/efi_bootmgr.c | 29 ++++++++++-------------
>  3 files changed, 68 insertions(+), 16 deletions(-)
> 
> diff --git a/disk/part.c b/disk/part.c
> index 66e2b3a7219..9d9483b216c 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -855,3 +855,49 @@ int part_get_bootable(struct blk_desc *desc)
>  
>  	return 0;
>  }
> +
> +/**
> +* detect_disk_image_type() - Detect if buffer contains a disk image
> +*
> +* @buffer:  Buffer containing potential disk image data
> +* @size:    Size of the buffer
> +* Return:   1 if disk image detected, 0 otherwise
> +*/
> +int detect_disk_image_type(void *buffer, size_t size)
> +{
> +	unsigned char *buf = (unsigned char *)buffer;
> +
> +	/* Need at least 512 bytes for basic checks */
> +	if (!buffer || size < 512)
> +		return 0;
> +
> +#if IS_ENABLED(CONFIG_ISO_PARTITION)
> +	/* Check for ISO 9660 signature "CD001" at offset 0x8001 */
> +	if (size > 0x8005) {
> +		if (buf[0x8001] == 'C' && buf[0x8002] == 'D' &&
> +		    buf[0x8003] == '0' && buf[0x8004] == '0' &&
> +		    buf[0x8005] == '1') {
> +			return 1;
> +		}
> +	}
> +#endif
> +
> +#if IS_ENABLED(CONFIG_DOS_PARTITION)
> +	/* Check for DOS MBR signature 0x55AA at offset 0x1FE */
> +	if (buf[0x1FE] == 0x55 && buf[0x1FF] == 0xAA) {
> +		return 1;
> +	}
> +#endif
> +
> +#if IS_ENABLED(CONFIG_EFI_PARTITION)
> +	/* Check for GPT protective MBR */
> +	if (buf[0x1FE] == 0x55 && buf[0x1FF] == 0xAA) {
> +		/* Check if partition type is 0xEE (GPT protective) */
> +		if (buf[0x1C2] == 0xEE) {
> +			return 1;
> +		}
> +	}
> +#endif
> +
> +	return 0;
> +}
> diff --git a/include/part.h b/include/part.h
> index b772fb34c8a..39c04e0c8f7 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -727,6 +727,15 @@ int part_get_type_by_name(const char *name);
>   */
>  int part_get_bootable(struct blk_desc *desc);
>  
> +/**
> + * detect_disk_image_type() - Detect if buffer contains a disk image
> + *
> + * @buffer: Buffer containing potential disk image data
> + * @size:   Size of the buffer
> + * Return:  1 if disk image detected, 0 otherwise
> + */
> +int detect_disk_image_type(void *buffer, size_t size);
> +
>  #else
>  static inline int part_driver_get_count(void)
>  { return 0; }
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 662993fb809..da63ad41b40 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -17,6 +17,7 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <net.h>
> +#include <part.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <asm/unaligned.h>
> @@ -407,7 +408,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>  	if (!ctx)
>  		return ret;
>  
> -	/* cleanup for iso or img image */
> +	/* cleanup for image file */
>  	if (ctx->ramdisk_blk_dev) {
>  		ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
>  					 EFI_CONVENTIONAL_MEMORY);
> @@ -466,7 +467,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>  {
>  	char *s;
>  	int err;
> -	int uri_len;
>  	efi_status_t ret;
>  	void *source_buffer;
>  	efi_uintn_t source_size;
> @@ -516,21 +516,10 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>  	image_size = ALIGN(image_size, SZ_2M);
>  
>  	/*
> -	 * If the file extension is ".iso" or ".img", mount it and try to load
> -	 * the default file.
> -	 * If the file is PE-COFF image, load the downloaded file.
> +	 * Check if the downloaded file is a PE-COFF image or a disk image.
> +	 * Use header-based detection instead of file extensions.
>  	 */
> -	uri_len = strlen(uridp->uri);
> -	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> -	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> -		ret = prepare_loaded_image(lo_label, image_addr, image_size,
> -					   &loaded_dp, &blk);
> -		if (ret != EFI_SUCCESS)
> -			goto err;
> -
> -		source_buffer = NULL;
> -		source_size = 0;
> -	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> +	if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
>  		/*
>  		 * loaded_dp must exist until efi application returns,
>  		 * will be freed in return_to_efibootmgr event callback.

I haven't done much on EFI loading, but was intrigued. Is there any
reason why you've also changed the ordering? It probably doesn't matter;
but I assume a disk image is more common than a PE-COFF image, at least
in U-Boot? Or is it not?

> @@ -544,6 +533,14 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>  
>  		source_buffer = (void *)image_addr;
>  		source_size = image_size;
> +	} else if (detect_disk_image_type((void *)image_addr, image_size)) {
> +		ret = prepare_loaded_image(lo_label, image_addr, image_size,
> +					   &loaded_dp, &blk);
> +		if (ret != EFI_SUCCESS)
> +			goto err;
> +
> +		source_buffer = NULL;
> +		source_size = 0;
>  	} else {
>  		log_err("Error: file type is not supported\n");
>  		ret = EFI_UNSUPPORTED;

-- 
Thanking You
Neha Malcom Francis
