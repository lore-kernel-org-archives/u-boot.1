Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EC3C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 07:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C0A8824B;
	Tue, 28 May 2024 09:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="umT2EDki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F3088361; Tue, 28 May 2024 09:50:02 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5631F87F31
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-355080e6ff9so394149f8f.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716882600; x=1717487400;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cODXekoyEBFr0QmTm6E79RLEhHPogK/VnKynCNwAOTU=;
 b=umT2EDkiroAAnBGKRCzDh5KKl2+GAlFOehv8RWabxuBCxJgHWH7W326+KRj1qmQG88
 404jDu5sqg7Quk6FmILpQAfhd7mYAJjNJwjSe1ABfkK7H2dkdm34vFjmOro870jErJG/
 9kl+d7ypNqpnrbdaoxwAjDu+8OT36lQ5b5mq5lalkqNaLr+7Pl4SY5bOsrQaiOpeZ+Oy
 2qGDIXtz4D0Kip3VybSFQ2FY2E+h0IulRrPWX6esAZs+fBtd2IvVRvaV03ClyGqsai6D
 VC3cs2BxmxXuKtY+h6n6FHRz9SvGQCpE091P821WRy1tCm/a2a+fitBCnIFgX1sOvOx7
 w0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716882600; x=1717487400;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cODXekoyEBFr0QmTm6E79RLEhHPogK/VnKynCNwAOTU=;
 b=rIo8MDCKqup6dpOSDE8hSFRvs58xY3lhiAHb31/hYp5MlwQBVO/iDWOM2OWeHmmNMo
 QcYZ6K4MIR899srvCY2jd/E/MnPDQmPjAKGYNZagJVthz+XcqpDCP5/bzdRZWgko7/Mk
 qZ81bcIzfd9XWbO3nG7JBoullhbIHSUFm2PhE04d66/pb3EJIYBib03ncW4rhNwxyHAA
 rgavUIm5zwDzi/M8GC7arQpcUM+0Qiti45dhiijsPJ/c2g+FIg1smM4cjnyL8ZaiYEXj
 9AuBP91ZH4qiTItSjG0ejkcOnwTwswseicwJ8fMgC7AMoYdc301NK+DxoNIrVwtbnKTR
 YUcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX32KQCJnhBTwU1NkaiFOwdLQ321v6t2ms4kIgxESfFjjLTC46eS8fuGbPJbtnUh40N7qSm1Ar7cb4kFWePxobcdloKoA==
X-Gm-Message-State: AOJu0YyZkaoZlza4eYn7gu/LykgcSNOnRfMvngqw/nLw6IRCGflJR6Uj
 yRI1ddBpgIuIrrThqeFZS5gEyIL3mRFLSvmh5LUzvEr1x2tArfRO1Lgz4mzuR3w=
X-Google-Smtp-Source: AGHT+IEBzDyZXClybiWTKW3Bdjk1/AQ317BbFLweU4Yv0VN5Rtmfr7hhKyRWMH41B5KICLWEZufehQ==
X-Received: by 2002:adf:e40c:0:b0:354:e8f3:2a32 with SMTP id
 ffacd0b85a97d-35529c3c0bcmr7340147f8f.22.1716882599748; 
 Tue, 28 May 2024 00:49:59 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7da64sm11126130f8f.4.2024.05.28.00.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 00:49:59 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Roman Stratiienko <r.stratiienko@gmail.com>, r.stratiienko@gmail.com,
 igor.opaniuk@gmail.com, dsimic@manjaro.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, eajames@linux.ibm.com,
 marek.vasut+renesas@mailbox.org, paulerwan.rio@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] abootimg: Implement smart image load feature
In-Reply-To: <20240519191856.2582174-4-r.stratiienko@gmail.com>
References: <20240519191856.2582174-1-r.stratiienko@gmail.com>
 <20240519191856.2582174-4-r.stratiienko@gmail.com>
Date: Tue, 28 May 2024 09:49:56 +0200
Message-ID: <87r0dmgyu3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Roman,

Thank you for the patch.

On dim., mai 19, 2024 at 19:18, Roman Stratiienko <r.stratiienko@gmail.com> wrote:

> Load only part of the boot partition that contains valuable
> information, thus improving the boot time.
>
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  boot/image-android.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  cmd/abootimg.c       | 40 ++++++++++++++++++++++---
>  include/image.h      | 12 ++++++++
>  3 files changed, 118 insertions(+), 4 deletions(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index da8003f370..d00a896a40 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -204,6 +204,76 @@ bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
>  	return true;
>  }
>  
> +/**
> + * android_image_get_valuable_size() - get the size of the android image
> + *
> + * This function checks if the image is Android boot image and returns the
> + * valuable size of the image.
> + *
> + * @hdr_addr: Boot image header address (boot or vendor_boot)
> + *
> + * @return size of the image on success, 0 on failure
> + */
> +size_t android_image_get_valuable_size(const void *hdr_addr)

Can't we use a ssize_t to return a negative error code?
0 as error seems odd and not what is used in most functions in boot/image-android.c

> +{
> +	int version, size;
> +
> +	if (is_android_boot_image_header(hdr_addr)) {
> +		const struct andr_boot_img_hdr_v0 *hdr = hdr_addr;
> +
> +		version = ((struct andr_boot_img_hdr_v0 *)hdr_addr)->header_version;
> +		if (version > 2) {
> +			const struct andr_boot_img_hdr_v3 *hdr = hdr_addr;
> +
> +			size = ALIGN(hdr->header_size, ANDR_GKI_PAGE_SIZE);
> +			size += ALIGN(hdr->kernel_size, ANDR_GKI_PAGE_SIZE);
> +			size += ALIGN(hdr->ramdisk_size, ANDR_GKI_PAGE_SIZE);
> +
> +			if (version > 3)
> +				size += ALIGN(hdr->signature_size, ANDR_GKI_PAGE_SIZE);
> +
> +			return size;
> +		}
> +
> +		size = hdr->page_size;
> +		size += ALIGN(hdr->kernel_size, hdr->page_size);
> +		size += ALIGN(hdr->ramdisk_size, hdr->page_size);
> +		size += ALIGN(hdr->second_size, hdr->page_size);
> +
> +		if (version > 0)
> +			size += ALIGN(hdr->recovery_dtbo_size, hdr->page_size);
> +
> +		if (version > 1)
> +			size += ALIGN(hdr->dtb_size, hdr->page_size);
> +
> +		return size;
> +	}
> +
> +	if (is_android_vendor_boot_image_header(hdr_addr)) {
> +		const struct andr_vnd_boot_img_hdr *hdr = hdr_addr;
> +
> +		version = ((struct andr_vnd_boot_img_hdr *)hdr_addr)->header_version;
> +		if (version < 3) {
> +			printf("Vendor boot image header version %d is not supported\n", version);
> +
> +			return 0;
> +		}
> +
> +		size = ALIGN(hdr->header_size, hdr->page_size);
> +		size += ALIGN(hdr->vendor_ramdisk_size, hdr->page_size);
> +		size += ALIGN(hdr->dtb_size, hdr->page_size);
> +
> +		if (version > 3) {
> +			size += ALIGN(hdr->vendor_ramdisk_table_size, hdr->page_size);
> +			size += ALIGN(hdr->bootconfig_size, hdr->page_size);
> +		}
> +
> +		return size;
> +	}
> +
> +	return 0;
> +}
> +
>  static ulong android_image_get_kernel_addr(struct andr_image_data *img_data)
>  {
>  	/*
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index 808c9c4941..fe7c5c5e2c 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -182,6 +182,35 @@ static int abootimg_get_dtb(int argc, char *const argv[])
>  	return CMD_RET_USAGE;
>  }
>  
> +static int abootimg_smart_load(struct blk_desc *desc, struct disk_partition *info, void *addr)
> +{
> +	int ret, size;
> +
> +	ret = blk_dread(desc, info->start, 4096 / info->blksz, addr);

Why 4096? Can we use #define for this or reuse an exising definition?

> +	if (ret < 0) {
> +		printf("Error: Failed to read partition\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	size = android_image_get_valuable_size(addr);
> +	if (size == 0)
> +		return 0;
> +
> +	ret = blk_dread(desc, info->start, DIV_ROUND_UP(size, info->blksz), addr);
> +	if (ret < 0) {
> +		printf("Error: Failed to read partition\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	memset(addr + size, 0, info->size * info->blksz - size);
> +
> +	printf("Loaded Android boot image using smart load (%d/%d MB)\n",

Why only boot image? Should this be more generic be passing the
partition name instead?

> +	       (int)DIV_ROUND_UP(size, 1024 * 1024),
> +	       (int)DIV_ROUND_UP(info->size * info->blksz, 1024 * 1024));
> +
> +	return size;
> +}
> +
>  static int do_abootimg_addr(struct cmd_tbl *cmdtp, int flag, int argc,
>  			    char *const argv[])
>  {
> @@ -299,10 +328,13 @@ static int do_abootimg_load(struct cmd_tbl *cmdtp, int flag, int argc,
>  		return CMD_RET_FAILURE;
>  	}
>  
> -	ret = blk_dread(desc, info.start, info.size, addr);
> -	if (ret < 0) {
> -		printf("Error: Failed to read partition %s\n", buf);
> -		goto fail;
> +	ret = abootimg_smart_load(desc, &info, addr);
> +	if (ret <= 0) {
> +		ret = blk_dread(desc, info.start, info.size, addr);
> +		if (ret < 0) {
> +			printf("Error: Failed to read partition %s\n", buf);
> +			goto fail;
> +		}
>  	}
>  
>  	sprintf(buf, "abootimg_%s_ptr", argv[3]);
> diff --git a/include/image.h b/include/image.h
> index c5b288f62b..7d8ff40c3f 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1826,6 +1826,18 @@ struct andr_image_data;
>  bool android_image_get_data(const void *boot_hdr, const void *vendor_boot_hdr,
>  			    struct andr_image_data *data);
>  
> +/**
> + * android_image_get_valuable_size() - get the size of the android image
> + *
> + * This function checks if the image is Android boot image and returns the
> + * valuable size of the image.
> + *
> + * @hdr_addr: Boot image header address (boot or vendor_boot)
> + *
> + * @return size of the image on success, 0 on failure
> + */
> +size_t android_image_get_valuable_size(const void *hdr_addr);
> +
>  struct andr_boot_img_hdr_v0;
>  
>  /**
> -- 
> 2.40.1
