Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042A6C369D5
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 09:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C8381E0F;
	Sun, 27 Apr 2025 11:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XetwQKR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF4D81F45; Sun, 27 Apr 2025 11:08:06 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3798810EB
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 11:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30a0c05e2c6so531490a91.2
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 02:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745744882; x=1746349682; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JLKTRvg7OFeQiuzaE8TKuFBSMrzExJFSlzoXugB5xuI=;
 b=XetwQKR6O74OmGadO9RzuRtgBZTp7XzdLVe9IVD0ihcWmvnAXzMapiR7bQm/X3jmK/
 Lc9F4SarxlDLBQZsA4PMGkm0UeQcj/b9RsXykXIqMkZF/SDpGIOuOnzRQ80tGsVs8SDL
 TVDnjRAuVFYpTodRZn4DXmnL4PHFTpC142cMxRD8/F6aLZhB8dFs3E6Ngj+0dG7bYX44
 C+QaMr3AFa/dNpM2KwHKAGyDN+yR7LoxFZoV/LqnH9TZfukHyVbX5Gv0cySymxyks5Yp
 29BhvuPO4iFko9L3caVRgD+opHIfhEdbsB3CIzBhlq1LfQ+KNp2+5n2oMPTrT+Oxl0bO
 14Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745744882; x=1746349682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLKTRvg7OFeQiuzaE8TKuFBSMrzExJFSlzoXugB5xuI=;
 b=g96c3wWbT8yV2zIvVnWAWObm0KxMuA8zuZ5988TKoZI09on7iadGSjaHnuGh6KJaVE
 HgbYfHzg2RCkh3gxmwN9OSZvEbrHVWB/nXhm1HdWQPvmjE+3zzA/o2vwZ62DIFpF96CL
 6XLYLCg8lo6k2tIbgtnkPsg1SU2RoEIpMGByMX6zMUgik45DJImwCanot0kDa+dcUReS
 DZjxvDu34otiPGNF8jgLZvIJP2UgHq3DNWxL/VF6iwq8pVBnRLEMoZVCl5HHIOw1fMaX
 Mawv4QkRKPlNR7cfjrgMU6WTDkxArlbiE5CLjZsuYKHeXKyJH9izTz06l4CqoctEXnAl
 dQGw==
X-Gm-Message-State: AOJu0Yw5iX/NdYzxVkh+8i92ae7ndkXIRPOmWuFSSt8NjVnbtEbnPgUw
 ooXPmC2DINFeTqQGK6QXLdP4PgYDqT7yXR2BUOIEkj3WhBMm/iHH
X-Gm-Gg: ASbGncsUmVF0sbHPHPcR30/kQJE5CeWAXGaUadX1LQ0E2DYd3OEVp3wXUw1uS46WE+O
 j95PzHISE3IRwyJJf84OLiiu1rJ/71c+6gbSknSO/g/dFHGwj1oOVCirfym6PKFUQwJJUw+gy96
 agwtrLS2t/0bz3ZOjfSoF7nUov25s3JUThIXMNTmoiK4yZuzGAgxmvCEXS8L/Mb2Sh1hm3tANDj
 MTpcyEQkUWkVRE9j/uO7WLRdcPB6bVOj4gRxOTkPwq/qrufcm133GqEy104SNZlw/vBwLljVnyh
 QurD1W08v4lez0gy1aiU0JwK3AJghSQ0MOvVAFtZAw==
X-Google-Smtp-Source: AGHT+IHxIDNHOSv7w0duMT8l6cmCkRNTFzKe0k2QIbWPEianrHm/vqHkiInhKs+rZwS3w/129y5FoQ==
X-Received: by 2002:a17:90b:4fc7:b0:2ff:5a9d:937f with SMTP id
 98e67ed59e1d1-309f7e67951mr13231335a91.24.1745744882229; 
 Sun, 27 Apr 2025 02:08:02 -0700 (PDT)
Received: from ownia-Ubuntu ([217.140.96.52]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7737c88sm4808290a91.1.2025.04.27.02.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 02:08:01 -0700 (PDT)
Date: Sun, 27 Apr 2025 17:07:47 +0800
From: Weizhao Ouyang <o451686892@gmail.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 sjg@chromium.org, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH v2 2/3] efi_loader: binary_run: register an initrd
Message-ID: <xzymlhbywmmlczgqdleia5jieynvc5ev7gkyms5c3zzvrj5jhm@4ee4fsnkp7ec>
References: <20250319144501.32277-1-adriano.cordova@canonical.com>
 <20250319144501.32277-3-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319144501.32277-3-adriano.cordova@canonical.com>
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

On Wed, Mar 19, 2025 at 11:45:00AM -0300, Adriano Cordova wrote:
> Add support to install an initrd when running an EFI binary
> with efi_binary_run
> 
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Hi Adriano,

Recently I bumped U-Boot version on my Debian kit then it crashed while
booting linux kernel:

GRUB log:
Loading Linux 6.12.22-arm64 ...
Loading initial ramdisk ...
error: failed to install protocols.

Kernel log:
[    0.794160] VFS: Cannot open root device "UUID=ebb74af9-b4b8-45bf-b1b9-d30d094a071d" or unknown-block(0,0): error -6
[    0.795080] Please append a correct "root=" boot option; here are the available partitions:
[    0.795814] List of all bdev filesystems:
[    0.796168]  fuseblk
[    0.796170] 
[    0.796500] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    0.797226] CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.22-arm64 #1  Debian 6.12.22-1
[    0.797993] Hardware name: armsom ArmSoM Sige7/ArmSoM Sige7, BIOS 2025.04-g36835a9105cf-dirty 04/01/2025
[    0.798823] Call trace:
[    0.799041]  dump_backtrace+0xd8/0x130
[    0.799380]  show_stack+0x20/0x38
[    0.799675]  dump_stack_lvl+0x60/0x80
[    0.800003]  dump_stack+0x18/0x28
[    0.800298]  panic+0x164/0x378
[    0.800575]  mount_root_generic+0x200/0x2c8
[    0.800948]  mount_root+0x17c/0x1a8
[    0.801258]  prepare_namespace+0x1e0/0x250
[    0.801623]  kernel_init_freeable+0x2c4/0x2f0
[    0.802010]  kernel_init+0x28/0x150
[    0.802323]  ret_from_fork+0x10/0x20
[    0.802643] SMP: stopping secondary CPUs
[    0.803101] Kernel Offset: 0x48fed5ba0000 from 0xffff800080000000
[    0.803637] PHYS_OFFSET: 0xfff0f41e80000000
[    0.804005] CPU features: 0x18,00000017,00280928,4201720b
[    0.804482] Memory Limit: none
[    0.804756] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0) ]---

I git bisect it to this commit. I didn't dive into the details, just did
a workaround as below, please check it out:

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 2cf972343a45..cd947bb525c4 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -234,6 +234,9 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+	if (!initrd)
+		goto out;
+
 	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
 	if (!dp_initrd)
 		return EFI_OUT_OF_RESOURCES;
@@ -242,6 +245,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+out:
 	return efi_run_image(image, size, dp_dev, dp_img);
 }
 

BR,
Weizhao

> ---
> 
> Changes in v2:
> - Change EFI_RESERVED_MEMORY_TYPE for EFI_LOADER_DATA for dp_initrd
> 
>  boot/bootm_os.c              |  3 ++-
>  cmd/bootefi.c                |  2 +-
>  include/efi_loader.h         |  2 +-
>  lib/efi_loader/efi_bootbin.c | 20 +++++++++++++++++---
>  4 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index e9522cd3299..f403f352be1 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -507,7 +507,8 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
>  
>  	ret = efi_binary_run(image_buf, images->os.image_len,
>  			     images->ft_len
> -			     ? images->ft_addr : EFI_FDT_USE_INTERNAL);
> +			     ? images->ft_addr : EFI_FDT_USE_INTERNAL,
> +				 NULL, 0);
>  
>  	return ret;
>  }
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index c1454ffb948..dce8285b047 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -211,7 +211,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
>  		}
>  	}
>  
> -	ret = efi_binary_run(image_buf, size, fdt);
> +	ret = efi_binary_run(image_buf, size, fdt, NULL, 0);
>  
>  	if (ret != EFI_SUCCESS)
>  		return CMD_RET_FAILURE;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index cc732dc4807..ad60805ae4f 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -600,7 +600,7 @@ efi_status_t efi_install_fdt(void *fdt);
>  /* Execute loaded UEFI image */
>  efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
>  /* Run loaded UEFI image with given fdt */
> -efi_status_t efi_binary_run(void *image, size_t size, void *fdt);
> +efi_status_t efi_binary_run(void *image, size_t size, void *fdt, void *initrd, size_t initrd_sz);
>  
>  /**
>   * efi_bootflow_run() - Run a bootflow containing an EFI application
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index deafb2ce1c2..2cf972343a4 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -204,6 +204,8 @@ out:
>   * @image:	memory address of the UEFI image
>   * @size:	size of the UEFI image
>   * @fdt:	device-tree
> + * @initrd:	initrd
> + * @initrd_sz:	initrd size
>   * @dp_dev:	EFI device-path
>   * @dp_img:	EFI image-path
>   *
> @@ -213,10 +215,12 @@ out:
>   * Return:	status code
>   */
>  static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
> +				      void *initrd, size_t initd_sz,
>  				      struct efi_device_path *dp_dev,
>  				      struct efi_device_path *dp_img)
>  {
>  	efi_status_t ret;
> +	struct efi_device_path *dp_initrd;
>  
>  	/* Initialize EFI drivers */
>  	ret = efi_init_obj_list();
> @@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>  	if (ret != EFI_SUCCESS)
>  		return ret;
>  
> +	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
> +	if (!dp_initrd)
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	ret = efi_initrd_register(dp_initrd);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
>  	return efi_run_image(image, size, dp_dev, dp_img);
>  }
>  
> @@ -239,13 +251,15 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>   * @image:	memory address of the UEFI image
>   * @size:	size of the UEFI image
>   * @fdt:	device-tree
> + * @initrd:	initrd
> + * @initrd_sz:	initrd size
>   *
>   * Execute an EFI binary image loaded at @image.
>   * @size may be zero if the binary is loaded with U-Boot load command.
>   *
>   * Return:	status code
>   */
> -efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> +efi_status_t efi_binary_run(void *image, size_t size, void *fdt, void *initrd, size_t initrd_sz)
>  {
>  	efi_handle_t mem_handle = NULL;
>  	struct efi_device_path *file_path = NULL;
> @@ -273,7 +287,7 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
>  		log_debug("Loaded from disk\n");
>  	}
>  
> -	ret = efi_binary_run_dp(image, size, fdt, bootefi_device_path,
> +	ret = efi_binary_run_dp(image, size, fdt, initrd, initrd_sz, bootefi_device_path,
>  				bootefi_image_path);
>  out:
>  	if (mem_handle) {
> @@ -355,7 +369,7 @@ efi_status_t efi_bootflow_run(struct bootflow *bflow)
>  		log_debug("Booting with external fdt\n");
>  		fdt = map_sysmem(bflow->fdt_addr, 0);
>  	}
> -	ret = efi_binary_run_dp(bflow->buf, bflow->size, fdt, device, image);
> +	ret = efi_binary_run_dp(bflow->buf, bflow->size, fdt, NULL, 0, device, image);
>  
>  	return ret;
>  }
> -- 
> 2.48.1
> 
