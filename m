Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3F1CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 12:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A069D86B69;
	Mon, 25 Sep 2023 14:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KQQUElGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF20986B82; Mon, 25 Sep 2023 14:09:43 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F034C86B4E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 14:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4053c6f0d55so58057065e9.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695643781; x=1696248581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+5M+3OR3Z5Fu38IDYAKp0fcmUqN97xv2nuZO++jQSww=;
 b=KQQUElGEW/ellAs7pOPR93aMlqVbVIuxEuibfhjb8bUJpsr8FMoG5lcZXiHI1uEmmH
 qGLpSqfTgQv57dxkcGE+5ld7Psd6231xTuVC9VW2MOal4Wwwu1tc7cGUmtQ3KPuFgHpB
 9TBHtZTROVR9ts5t8rgXtvMqle931m+aVAiF5iRdeP8Hr3Y1O3eVss6GFh7bWT/lGPuX
 uGpRM0S6nEmsfPstqob5srJGPn3P3c2a5xrmQPU3KglMAzIVcEz6Z0x03FUCaYubQYpN
 RV7yTna9hTczxmVC5K9ZKGcBkLVtLO3PdhNMrjYkKZUVxOGGo/0lQnm42Ujqim+YScaF
 qLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695643781; x=1696248581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5M+3OR3Z5Fu38IDYAKp0fcmUqN97xv2nuZO++jQSww=;
 b=ClbExo/NV0K3SfdPXeaf892nUPa/OJC94qA4csILx57ktgw4l61bEpi9mo7SGl4d5c
 2Fle184SEOMoqeQZTJMPdeTuraOG1T7CjmVTPxVBRdtwajSp89W6/13EUNeDSf9vc4F7
 yrs26OHEOWd9YBD4dZw3sIuIvg54jm563ZTaNBL2OYX64tfvYUs0T/pHhvfRp9Uj7JjD
 fnr2mCbJ13TkUkbLhdYAalX3cB6bGCOOHzbh98WTWSNlPgNzPLB/8/eo1LyjrbsrW4e4
 x965W+I4ecevbJpIs+l/lACkaA5VbW03MXgWE6WzCG1+FcZ0Q8+oyArdAAaaZyc1+Rye
 4kww==
X-Gm-Message-State: AOJu0YzUESl5ezWXdDEmDRgnzoohlOo4N8y71j/n2AoJwNCU90Vx74tN
 BO86ZfUcWmM9VOigovU6mJMLxt45DUF2a62VjgU=
X-Google-Smtp-Source: AGHT+IGQLjQgYC06nbPPO1yDUVg6NCWR6p6RHExshtxMJQLFFqPC9xjlAYslyQNN4O046XhL8Y0+LA==
X-Received: by 2002:a7b:c417:0:b0:3ff:ca80:eda3 with SMTP id
 k23-20020a7bc417000000b003ffca80eda3mr5270180wmi.10.1695643781361; 
 Mon, 25 Sep 2023 05:09:41 -0700 (PDT)
Received: from hera (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a05600c0b4300b003fe1fe56202sm12188408wmr.33.2023.09.25.05.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 05:09:41 -0700 (PDT)
Date: Mon, 25 Sep 2023 15:09:38 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 3/8] blk: blkmap: add ramdisk creation utility function
Message-ID: <ZRF4gguigfY6Hnev@hera>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-4-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922071119.1439482-4-masahisa.kojima@linaro.org>
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

On Fri, Sep 22, 2023 at 04:11:14PM +0900, Masahisa Kojima wrote:
> User needs to call several functions to create the ramdisk
> with blkmap.
> This adds the utility function to create blkmap device and
> mount the ramdisk.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  drivers/block/Makefile        |  1 +
>  drivers/block/blkmap.c        | 15 ----------
>  drivers/block/blkmap_helper.c | 53 +++++++++++++++++++++++++++++++++++
>  include/blkmap.h              | 29 +++++++++++++++++++
>  4 files changed, 83 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/block/blkmap_helper.c
>
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index a161d145fd..c3ccfc03e5 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -15,6 +15,7 @@ endif
>  obj-$(CONFIG_SANDBOX) += sandbox.o host-uclass.o host_dev.o
>  obj-$(CONFIG_$(SPL_TPL_)BLOCK_CACHE) += blkcache.o
>  obj-$(CONFIG_BLKMAP) += blkmap.o
> +obj-$(CONFIG_BLKMAP) += blkmap_helper.o
>
>  obj-$(CONFIG_EFI_MEDIA) += efi-media-uclass.o
>  obj-$(CONFIG_EFI_MEDIA_SANDBOX) += sb_efi_media.o
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index 2bb0acc20f..4e95997f61 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -66,21 +66,6 @@ struct blkmap_slice {
>  	void (*destroy)(struct blkmap *bm, struct blkmap_slice *bms);
>  };
>
> -/**
> - * struct blkmap - Block map
> - *
> - * Data associated with a blkmap.
> - *
> - * @label: Human readable name of this blkmap
> - * @blk: Underlying block device
> - * @slices: List of slices associated with this blkmap
> - */
> -struct blkmap {
> -	char *label;
> -	struct udevice *blk;
> -	struct list_head slices;
> -};
> -
>  static bool blkmap_slice_contains(struct blkmap_slice *bms, lbaint_t blknr)
>  {
>  	return (blknr >= bms->blknr) && (blknr < (bms->blknr + bms->blkcnt));
> diff --git a/drivers/block/blkmap_helper.c b/drivers/block/blkmap_helper.c
> new file mode 100644
> index 0000000000..0f80035f57
> --- /dev/null
> +++ b/drivers/block/blkmap_helper.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * blkmap helper function
> + *
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <blk.h>
> +#include <blkmap.h>
> +#include <dm/device.h>
> +#include <dm/device-internal.h>
> +
> +int blkmap_create_ramdisk(const char *label, ulong image_addr, int image_size,
> +			  struct udevice **devp)
> +{
> +	int ret;
> +	lbaint_t blknum;
> +	struct blkmap *bm;
> +	struct blk_desc *desc;
> +	struct udevice *bm_dev;
> +
> +	ret = blkmap_create(label, &bm_dev);
> +	if (ret) {
> +		log_err("failed to create blkmap\n");
> +		return ret;
> +	}
> +
> +	bm = dev_get_plat(bm_dev);
> +	desc = dev_get_uclass_plat(bm->blk);
> +	blknum = image_size >> desc->log2blksz;
> +	ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr);
> +	if (ret) {
> +		log_err("Unable to map %#llx at block %d : %d\n",
> +			(unsigned long long)image_addr, 0, ret);
> +		goto err;
> +	}
> +	log_info("Block %d+0x" LBAF " mapped to %#llx\n", 0, blknum,
> +		 (unsigned long long)image_addr);
> +
> +	ret = device_probe(bm->blk);
> +	if (ret)
> +		goto err;
> +
> +	if (devp)
> +		*devp = bm_dev;
> +
> +	return 0;
> +
> +err:
> +	blkmap_destroy(bm_dev);
> +
> +	return ret;
> +}
> diff --git a/include/blkmap.h b/include/blkmap.h
> index af54583c7d..0d87e6db6b 100644
> --- a/include/blkmap.h
> +++ b/include/blkmap.h
> @@ -7,6 +7,23 @@
>  #ifndef _BLKMAP_H
>  #define _BLKMAP_H
>
> +#include <dm/lists.h>
> +
> +/**
> + * struct blkmap - Block map
> + *
> + * Data associated with a blkmap.
> + *
> + * @label: Human readable name of this blkmap
> + * @blk: Underlying block device
> + * @slices: List of slices associated with this blkmap
> + */
> +struct blkmap {
> +	char *label;
> +	struct udevice *blk;
> +	struct list_head slices;
> +};
> +
>  /**
>   * blkmap_map_linear() - Map region of other block device
>   *
> @@ -74,4 +91,16 @@ int blkmap_create(const char *label, struct udevice **devp);
>   */
>  int blkmap_destroy(struct udevice *dev);
>
> +/**
> + * blkmap_create_ramdisk() - Create new ramdisk with blkmap
> + *
> + * @label: Label of the new blkmap
> + * @image_addr: Target memory start address of this mapping
> + * @image_size: Target memory size of this mapping
> + * @devp: Updated with the address of the created blkmap device
> + * Returns: 0 on success, negative error code on failure
> + */
> +int blkmap_create_ramdisk(const char *label, ulong image_addr, int image_size,
> +			  struct udevice **devp);
> +
>  #endif	/* _BLKMAP_H */
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

