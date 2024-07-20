Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B8DC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07C1887F6;
	Sat, 20 Jul 2024 17:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D3yehzsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28108884BE; Sat, 20 Jul 2024 17:54:27 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06FB6887F6
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 17:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e02c4983bfaso3010938276.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721490864; x=1722095664; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PT2uhYLXhhluiwoo3Vad+G4PiVP1iCCnckt2fF0kros=;
 b=D3yehzsRkOZkJjnylZ4g/SIjH/bmn85RGoldHdWOZFis4+lvNAatWNNQKbKx522kTG
 6MM+bP4SWPeH32A0CEYUhs/1NMIFFSh1uDLgADUgLQ1bqvBk812kBG4YJqj9JHoivyCA
 QiSTrag1PnSffJ6U0SWfhUS62hh1PFKFbAyXt6GfTTJ6eBFgRM2F1DYfesWtAKxpXQ4w
 Y3i/Xonhn2N6tDxq0CeX2VSO+WGWw84XKyyupJSvoI8bvjLcOi1D4UFRFdaggv/Q/dOv
 j8goQ+MBZem1LAnL1V3o6sZV7yvv4ibEJ4EXCQMtZ2I8Sydganzx/WnZ7vk0VT0Wu66w
 dauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721490864; x=1722095664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PT2uhYLXhhluiwoo3Vad+G4PiVP1iCCnckt2fF0kros=;
 b=T3lF4oCpbzZk0BHcCgx05TpGkJyohyjyFllgzN6owoiATh5/GFwg/19UrEj8JCUs6E
 mkkIzq136OjwLzzRVs8q1TJWNPmUN1qwtOV5SZwmOhwvrLZhy9vnba4mqZHqKpB7cBrD
 Kvsji4iPjQqt3+Pryc/Z/GsIn8JAZI1c5eacH4sc62Lxf50+gtVHZfp2utqlcdpLCYqq
 j5pCHkAtYkagrnCP9jxg3thabv0MnItHPDcR9sXihgdRo1vIKiy61ohzt1EoTMmwFQ5N
 4NNXcfZH5EtKm334aIz4GSMlnuVlD/BZU3uOYmw+nn6yPLiNeBkg32fOIHfjdP1e1MKB
 m4HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeCRHGGiuHLrLNr8BNDkM4rH/il2ELCHqJIrwxWg2vkvq+WkwtrkJyJiDQ6L1rolwJ5hzUsJdMtBxuPqZjirG/j7FMgg==
X-Gm-Message-State: AOJu0YwfvqptWqLCdzQtgwNttERQrW2H3ld6h/j0HrToKBI1A94k8dwu
 dktMv/hy5MNI75lgKQgjLqG7UFzmR7aTYX6Sigbk7HAb6BRba7nm
X-Google-Smtp-Source: AGHT+IHw57h6bQOqpucRHw5opUPnrDsHgQvPz57Qx8SisFq99mGamYb7uCwLP12Wn4Y/hJ5lMvXE9A==
X-Received: by 2002:a05:6902:154c:b0:dff:3028:4631 with SMTP id
 3f1490d57ef6-e087b74ef25mr1830193276.33.1721490863872; 
 Sat, 20 Jul 2024 08:54:23 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a198fba365sm196603185a.28.2024.07.20.08.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 08:54:23 -0700 (PDT)
Message-ID: <3a97b3d7-a10f-2f72-230e-85fbe2701abc@gmail.com>
Date: Sat, 20 Jul 2024 11:54:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 08/14] spl: mmc: Drop checks for
 CONFIG_SPL_LIBCOMMON_SUPPORT
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-9-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-9-sjg@chromium.org>
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
> This check is not needed now, since printf() resolved to nothing if not
> available. Drop the #ifdefs
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   common/spl/spl_mmc.c | 20 +-------------------
>   1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> index ccab0be4be2..ddc85aaeda7 100644
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -51,9 +51,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
>   	load.read = h_spl_load_read;
>   	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
>   	if (ret) {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>   		puts("mmc_load_image_raw_sector: mmc block read error\n");
> -#endif
>   		return -1;
>   	}
>   
> @@ -70,9 +68,7 @@ static int spl_mmc_get_device_index(u32 boot_device)
>   		return 1;
>   	}
>   
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>   	printf("spl: unsupported mmc boot device.\n");
> -#endif
>   
>   	return -ENODEV;
>   }
> @@ -91,18 +87,14 @@ static int spl_mmc_find_device(struct mmc **mmcp, u32 boot_device)
>   	err = mmc_initialize(NULL);
>   #endif /* DM_MMC */
>   	if (err) {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>   		printf("spl: could not initialize mmc. error: %d\n", err);
> -#endif
>   		return err;
>   	}
>   	*mmcp = find_mmc_device(mmc_dev);
>   	err = *mmcp ? 0 : -ENODEV;
>   	if (err) {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>   		printf("spl: could not find mmc device %d. error: %d\n",
>   		       mmc_dev, err);
> -#endif
>   		return err;
>   	}
>   
> @@ -135,10 +127,8 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
>   
>   	err = part_get_info(mmc_get_blk_desc(mmc), partition, &info);
>   	if (err) {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>   		puts("spl: partition error\n");
> -#endif
> -		return -1;
> +		return -err;
>   	}
>   
>   #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
> @@ -164,9 +154,7 @@ static int mmc_load_image_raw_os(struct spl_image_info *spl_image,
>   		CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS,
>   		(void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
>   	if (count != CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS) {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>   		puts("mmc_load_image_raw_os: mmc block read error\n");
> -#endif
>   		return -1;
>   	}
>   #endif	/* CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR */
> @@ -368,9 +356,7 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>   		err = mmc_init(mmc);
>   		if (err) {
>   			mmc = NULL;
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>   			printf("spl: mmc init failed with error: %d\n", err);
> -#endif
>   			return err;
>   		}
>   	}
> @@ -387,9 +373,7 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>   			err = blk_dselect_hwpart(mmc_get_blk_desc(mmc), part);
>   
>   		if (err) {
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>   			puts("spl: mmc partition switch failed\n");
> -#endif
>   			return err;
>   		}
>   		/* Fall through */
> @@ -428,10 +412,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>   
>   		break;
>   #endif
> -#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
>   	default:
>   		puts("spl: mmc: wrong boot mode\n");
> -#endif
>   	}
>   
>   	return err;

Reviewed-by: Sean Anderson <seanga2@gmail.com>
