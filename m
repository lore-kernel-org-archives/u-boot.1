Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4871C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 16:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 259CD883A4;
	Sat, 20 Jul 2024 18:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VbzHMiO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C21788354; Sat, 20 Jul 2024 18:12:01 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB612883A4
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 18:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4494d41090bso12773601cf.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721491918; x=1722096718; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XTpEEqwzRE6Mvy49wxFcVXwpS6OUCqpIGuLPMsvREx4=;
 b=VbzHMiO4tW+z5gNNS674RzzbZz+sejmAroHTF+EQ5glkLGPe+3fc8KZxnYSOlTpeZg
 X/7g3n6UmjhlBJzmzDadPXGSWYC0cBtVGp6IqwV7Hjfvx0hLNBffkyoqcurA0BXagwe5
 OX33LOKTbHKNuNA76d7JfHBOP/2kw3CORgtpZY972vzHf2mHBeTeBI+2RD1XBSK59z9i
 dYOFxl9z1bvn8vPNJJMjqjz5mg2hIO6RPCBwL0LdVD5LU29oGGhbBMzKbyEmBxB63ehC
 MwzbCF8q5PvVpAFOuzUdB2f1XQBsL9XHG4QkoL1bGwnI3oJvKOxBZOGCZ0G/65piUAbJ
 BdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721491918; x=1722096718;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XTpEEqwzRE6Mvy49wxFcVXwpS6OUCqpIGuLPMsvREx4=;
 b=LTp1I8MZXCUClx1ej+t40yKTqaNUNmZtrGb6b9SPup2Jnt1WJRLkSiM3rFBuLlJXon
 dLBYom/HjbW+Ryl4MEGXvWLKkmA3cXhZTFfQagBE1Z3qSQZtwCt6U5lRLDoWijYWLNg1
 xTNPuQ/QfeFsLPp78hQrgf7fFu8q1jLtfd0unzAFVGytMTfBeDzM/55N4BSnwiHQGGiG
 LulNBop4yRymoko4+5F+YOMn98sLuKFDxBjtcnwShwEq6SaFzoQ0AxyUMWv6RpWxSNbs
 PqrrX10f79bkCmLH1LP237wl3kjk4jZJWRNw/nm0QaRAGSOridlV9YphOk2+CzLeHgUD
 Y2+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4OWo6Dw1Rv/pwZXRvvRgi9GGYQDV1H1E6kipAC165q6HXCPU2ZtgFhkestYXXm7tbIbplezpnJHSs9H2p2C/cJhVcNw==
X-Gm-Message-State: AOJu0Yzwv7KO83o+YKFGjjfgpZDq9AuhQG38nBEaGf9NMjPJ/srt/JYu
 qUAg720MJJeZaE6eFjxIEtIcC7krr4dZVpxiXsqEx4RBj0tSBuBt
X-Google-Smtp-Source: AGHT+IFRHjnlZD1IP7swDT1tPokBDeO6PKI9Ds9CoDQctQrU5exIzfsxMSdeuIbUUiZdU04CDFv+cg==
X-Received: by 2002:ac8:5e08:0:b0:447:dc7f:f09a with SMTP id
 d75a77b69052e-44fa5287d01mr38582721cf.17.1721491917568; 
 Sat, 20 Jul 2024 09:11:57 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cbf236esm17963161cf.13.2024.07.20.09.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 09:11:57 -0700 (PDT)
Message-ID: <b3b642fd-fbf9-50e1-cc6b-8c52b551fd54@gmail.com>
Date: Sat, 20 Jul 2024 12:11:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 13/14] spl: Create a function to init spl_load_info
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Chanho Park <chanho61.park@samsung.com>, Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>, Stefano Babic <sbabic@denx.de>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-14-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/20/24 02:17, Simon Glass wrote:
> Rather than having every caller set this up individually, create a
> common init function. This allows new fields to be added without the
> risk of them being left uninited.
> 

What is the code size impact of this?

IIRC the reason why I didn't do this is to avoid growing the code in
cases where priv is unused.

Although in some places there are memsets which should be removed anyway.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   arch/arm/mach-imx/spl_imx_romapi.c  | 14 ++-------
>   arch/arm/mach-sunxi/spl_spi_sunxi.c |  3 +-
>   common/spl/spl_blk_fs.c             |  9 ++----
>   common/spl/spl_ext.c                |  3 +-
>   common/spl/spl_fat.c                | 10 +++----
>   common/spl/spl_mmc.c                |  4 +--
>   common/spl/spl_nand.c               |  4 +--
>   common/spl/spl_net.c                |  3 +-
>   common/spl/spl_nor.c                |  6 ++--
>   common/spl/spl_ram.c                |  3 +-
>   common/spl/spl_semihosting.c        |  4 +--
>   common/spl/spl_spi.c                |  4 +--
>   common/spl/spl_ymodem.c             |  4 +--
>   drivers/usb/gadget/f_sdp.c          |  8 ++----
>   include/spl.h                       | 44 ++++++++++++++++++++---------
>   test/image/spl_load.c               |  4 +--
>   test/image/spl_load_os.c            |  6 +---
>   17 files changed, 55 insertions(+), 78 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
> index bdaea439d7f..3982f4cca18 100644
> --- a/arch/arm/mach-imx/spl_imx_romapi.c
> +++ b/arch/arm/mach-imx/spl_imx_romapi.c
> @@ -108,18 +108,13 @@ static int spl_romapi_load_image_seekable(struct spl_image_info *spl_image,
>   	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) && image_get_magic(header) == FDT_MAGIC) {
>   		struct spl_load_info load;
>   
> -		memset(&load, 0, sizeof(load));
> -		spl_set_bl_len(&load, pagesize);
> -		load.read = spl_romapi_read_seekable;
> +		spl_load_init(&load, spl_romapi_read_seekable, NULL, pagesize);
>   		return spl_load_simple_fit(spl_image, &load, offset, header);
>   	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
>   		   valid_container_hdr((void *)header)) {
>   		struct spl_load_info load;
>   
> -		memset(&load, 0, sizeof(load));
> -		spl_set_bl_len(&load, pagesize);
> -		load.read = spl_romapi_read_seekable;
> -
> +		spl_load_init(&load, spl_romapi_read_seekable, NULL, pagesize);
>   		ret = spl_load_imx_container(spl_image, &load, offset);
>   	} else {
>   		/* TODO */
> @@ -341,10 +336,7 @@ static int spl_romapi_load_image_stream(struct spl_image_info *spl_image,
>   		ss.end = p;
>   		ss.pagesize = pagesize;
>   
> -		memset(&load, 0, sizeof(load));
> -		spl_set_bl_len(&load, 1);
> -		load.read = spl_romapi_read_stream;
> -		load.priv = &ss;
> +		spl_load_init(&load, spl_romapi_read_stream, &ss, 1);
>   
>   		return spl_load_simple_fit(spl_image, &load, (ulong)phdr, phdr);
>   	}
> diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> index d7abdc2e401..5f72e809952 100644
> --- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
> +++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> @@ -390,8 +390,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
>   		struct spl_load_info load;
>   
>   		debug("Found FIT image\n");
> -		spl_set_bl_len(&load, 1);
> -		load.read = spi_load_read;
> +		spl_load_init(&load, spi_load_read, NULL, 1);
>   		ret = spl_load_simple_fit(spl_image, &load,
>   					  load_offset, header);
>   	} else {
> diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
> index bc551c5c074..bbf90a9741e 100644
> --- a/common/spl/spl_blk_fs.c
> +++ b/common/spl/spl_blk_fs.c
> @@ -80,11 +80,8 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
>   		return ret;
>   	}
>   
> -	load.read = spl_fit_read;
> -	if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
> -		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
> -	else
> -		spl_set_bl_len(&load, 1);
> -	load.priv = &dev;
> +	spl_load_init(&load, spl_fit_read, &dev,
> +		      IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN) ?
> +		      ARCH_DMA_MINALIGN : 1);
>   	return spl_load(spl_image, bootdev, &load, filesize, 0);
>   }
> diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
> index 76f49a5a8a6..c5478820a9b 100644
> --- a/common/spl/spl_ext.c
> +++ b/common/spl/spl_ext.c
> @@ -51,8 +51,7 @@ int spl_load_image_ext(struct spl_image_info *spl_image,
>   		goto end;
>   	}
>   
> -	spl_set_bl_len(&load, 1);
> -	load.read = spl_fit_read;
> +	spl_load_init(&load, spl_fit_read, NULL, 1);
>   	err = spl_load(spl_image, bootdev, &load, filelen, 0);
>   
>   end:
> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index bd8aab253a9..fce451b7664 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -83,12 +83,10 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
>   		size = 0;
>   	}
>   
> -	load.read = spl_fit_read;
> -	if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
> -		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
> -	else
> -		spl_set_bl_len(&load, 1);
> -	load.priv = (void *)filename;
> +	spl_load_init(&load, spl_fit_read, (void *)filename,
> +		      IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN) ?
> +		      ARCH_DMA_MINALIGN : 1);
> +
>   	err = spl_load(spl_image, bootdev, &load, size, 0);
>   
>   end:
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index 3cb4b698f7f..22714bc4d90 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -46,9 +46,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
>   	struct blk_desc *bd = mmc_get_blk_desc(mmc);
>   	struct spl_load_info load;
>   
> -	load.priv = bd;
> -	spl_set_bl_len(&load, bd->blksz);
> -	load.read = h_spl_load_read;
> +	spl_load_init(&load, h_spl_load_read, bd, bd->blksz);
>   	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
>   	if (ret) {
>   		puts("mmc_load_image_raw_sector: mmc block read error\n");
> diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
> index 5631fa6d563..22883f4e8b9 100644
> --- a/common/spl/spl_nand.c
> +++ b/common/spl/spl_nand.c
> @@ -71,9 +71,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
>   {
>   	struct spl_load_info load;
>   
> -	load.priv = &offset;
> -	spl_set_bl_len(&load, 1);
> -	load.read = spl_nand_read;
> +	spl_load_init(&load, spl_nand_read, &offset, 1);
>   	return spl_load(spl_image, bootdev, &load, 0, offset);
>   }
>   
> diff --git a/common/spl/spl_net.c b/common/spl/spl_net.c
> index be7278bb933..2be7b73ed35 100644
> --- a/common/spl/spl_net.c
> +++ b/common/spl/spl_net.c
> @@ -47,8 +47,7 @@ static int spl_net_load_image(struct spl_image_info *spl_image,
>   		return rv;
>   	}
>   
> -	spl_set_bl_len(&load, 1);
> -	load.read = spl_net_load_read;
> +	spl_load_init(&load, spl_net_load_read, NULL, 1);
>   	return spl_load(spl_image, bootdev, &load, 0, 0);
>   }
>   #endif
> diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
> index ed76b5e1293..1021d933999 100644
> --- a/common/spl/spl_nor.c
> +++ b/common/spl/spl_nor.c
> @@ -49,8 +49,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
>   			int ret;
>   
>   			debug("Found FIT\n");
> -			spl_set_bl_len(&load, 1);
> -			load.read = spl_nor_load_read;
> +			spl_load_init(&load, spl_nor_load_read, NULL, 1);
>   
>   			ret = spl_load_simple_fit(spl_image, &load,
>   						  CONFIG_SYS_OS_BASE,
> @@ -93,8 +92,7 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
>   	 * Load real U-Boot from its location in NOR flash to its
>   	 * defined location in SDRAM
>   	 */
> -	spl_set_bl_len(&load, 1);
> -	load.read = spl_nor_load_read;
> +	spl_load_init(&load, spl_nor_load_read, NULL, 1);
>   	return spl_load(spl_image, bootdev, &load, 0, spl_nor_get_uboot_base());
>   }
>   SPL_LOAD_IMAGE_METHOD("NOR", 0, BOOT_DEVICE_NOR, spl_nor_load_image);
> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> index 5a23841f698..71b7a8374bb 100644
> --- a/common/spl/spl_ram.c
> +++ b/common/spl/spl_ram.c
> @@ -69,8 +69,7 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
>   		struct spl_load_info load;
>   
>   		debug("Found FIT\n");
> -		spl_set_bl_len(&load, 1);
> -		load.read = spl_ram_load_read;
> +		spl_load_init(&load, spl_ram_load_read, NULL, 1);
>   		ret = spl_load_simple_fit(spl_image, &load, 0, header);
>   	} else {
>   		ulong u_boot_pos = spl_get_image_pos();
> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
> index 2047248f39b..f36863fe48d 100644
> --- a/common/spl/spl_semihosting.c
> +++ b/common/spl/spl_semihosting.c
> @@ -43,9 +43,7 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>   	}
>   	len = ret;
>   
> -	load.read = smh_fit_read;
> -	spl_set_bl_len(&load, 1);
> -	load.priv = &fd;
> +	spl_load_init(&load, smh_fit_read, &fd, 1);
>   	ret = spl_load(spl_image, bootdev, &load, len, 0);
>   	if (ret)
>   		log_debug("could not read %s: %d\n", filename, ret);
> diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
> index 8ab4803f7c4..691a431a926 100644
> --- a/common/spl/spl_spi.c
> +++ b/common/spl/spl_spi.c
> @@ -77,9 +77,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
>   		return -ENODEV;
>   	}
>   
> -	load.priv = flash;
> -	spl_set_bl_len(&load, 1);
> -	load.read = spl_spi_fit_read;
> +	spl_load_init(&load, spl_spi_fit_read, flash, 1);
>   
>   #if CONFIG_IS_ENABLED(OS_BOOT)
>   	if (spl_start_uboot()) {
> diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
> index 4c7222af612..2be957134c1 100644
> --- a/common/spl/spl_ymodem.c
> +++ b/common/spl/spl_ymodem.c
> @@ -132,11 +132,9 @@ int spl_ymodem_load_image(struct spl_image_info *spl_image,
>   		struct ymodem_fit_info info;
>   
>   		debug("Found FIT\n");
> -		load.priv = (void *)&info;
> -		spl_set_bl_len(&load, 1);
> +		spl_load_init(&load, ymodem_read_fit, (void *)&info, 1);
>   		info.buf = buf;
>   		info.image_read = BUF_SIZE;
> -		load.read = ymodem_read_fit;
>   		ret = spl_load_simple_fit(spl_image, &load, 0, (void *)buf);
>   		size = info.image_read;
>   
> diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
> index 89496917a61..8a962c038fe 100644
> --- a/drivers/usb/gadget/f_sdp.c
> +++ b/drivers/usb/gadget/f_sdp.c
> @@ -843,9 +843,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
>   				struct spl_load_info load;
>   
>   				debug("Found FIT\n");
> -				load.priv = header;
> -				spl_set_bl_len(&load, 1);
> -				load.read = sdp_load_read;
> +				spl_load_init(&load, sdp_load_read, header, 1);
>   				spl_load_simple_fit(spl_image, &load, 0,
>   						    header);
>   
> @@ -856,9 +854,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
>   			    valid_container_hdr((void *)header)) {
>   				struct spl_load_info load;
>   
> -				load.priv = header;
> -				spl_set_bl_len(&load, 1);
> -				load.read = sdp_load_read;
> +				spl_load_init(&load, sdp_load_read, header, 1);
>   				spl_load_imx_container(spl_image, &load, 0);
>   				return SDP_EXIT;
>   			}
> diff --git a/include/spl.h b/include/spl.h
> index 2f6a3e64c10..12bf308e890 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -282,28 +282,32 @@ static inline void *spl_image_fdt_addr(struct spl_image_info *info)
>   #endif
>   }
>   
> +struct spl_load_info;
> +
> +/**
> + * spl_load_reader() - Read from device
> + *
> + * @load: Information about the load state
> + * @offset: Offset to read from in bytes. This must be a multiple of
> + *          @load->bl_len.
> + * @count: Number of bytes to read. This must be a multiple of
> + *         @load->bl_len.
> + * @buf: Buffer to read into
> + * @return number of bytes read, 0 on error
> + */
> +typedef ulong (*spl_load_reader)(struct spl_load_info *load, ulong sector,
> +				 ulong count, void *buf);
> +
>   /**
>    * Information required to load data from a device
>    *
> + * @read: Function to call to read from the device
>    * @priv: Private data for the device
>    * @bl_len: Block length for reading in bytes
> - * @read: Function to call to read from the device
>    */
>   struct spl_load_info {
> +	spl_load_reader read;
>   	void *priv;
> -	/**
> -	 * read() - Read from device
> -	 *
> -	 * @load: Information about the load state
> -	 * @offset: Offset to read from in bytes. This must be a multiple of
> -	 *          @load->bl_len.
> -	 * @count: Number of bytes to read. This must be a multiple of
> -	 *         @load->bl_len.
> -	 * @buf: Buffer to read into
> -	 * @return number of bytes read, 0 on error
> -	 */
> -	ulong (*read)(struct spl_load_info *load, ulong sector, ulong count,
> -		      void *buf);
>   #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
>   	int bl_len;
>   #endif
> @@ -328,6 +332,18 @@ static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
>   #endif
>   }
>   
> +/**
> + * spl_load_init() - Set up a new spl_load_info structure
> + */
> +static inline void spl_load_init(struct spl_load_info *load,
> +				 spl_load_reader h_read, void *priv,
> +				 uint bl_len)
> +{
> +	load->read = h_read;
> +	load->priv = priv;
> +	spl_set_bl_len(load, bl_len);
> +}
> +
>   /*
>    * We need to know the position of U-Boot in memory so we can jump to it. We
>    * allow any U-Boot binary to be used (u-boot.bin, u-boot-nodtb.bin,
> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> index 7cbad40ea0c..3b6206955d3 100644
> --- a/test/image/spl_load.c
> +++ b/test/image/spl_load.c
> @@ -343,9 +343,7 @@ static int spl_test_image(struct unit_test_state *uts, const char *test_name,
>   	} else {
>   		struct spl_load_info load;
>   
> -		spl_set_bl_len(&load, 1);
> -		load.priv = img;
> -		load.read = spl_test_read;
> +		spl_load_init(&load, spl_test_read, img, 1);
>   		if (type == IMX8)
>   			ut_assertok(spl_load_imx_container(&info_read, &load,
>   							   0));
> diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
> index 7d5fb9b07e0..dc09ba191bf 100644
> --- a/test/image/spl_load_os.c
> +++ b/test/image/spl_load_os.c
> @@ -49,9 +49,7 @@ static int spl_test_load(struct unit_test_state *uts)
>   	int ret;
>   	int fd;
>   
> -	memset(&load, '\0', sizeof(load));
> -	spl_set_bl_len(&load, 512);
> -	load.read = read_fit_image;
> +	spl_load_init(&load, read_fit_image, &text_ctx, 512);
>   
>   	ret = sandbox_find_next_phase(fname, sizeof(fname), true);
>   	if (ret)
> @@ -64,8 +62,6 @@ static int spl_test_load(struct unit_test_state *uts)
>   	ut_asserteq(512, os_read(fd, header, 512));
>   	text_ctx.fd = fd;
>   
> -	load.priv = &text_ctx;
> -
>   	ut_assertok(spl_load_simple_fit(&image, &load, 0, header));
>   
>   	return 0;

