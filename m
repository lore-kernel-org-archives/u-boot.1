Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014A9D2C552
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707AE88EC9;
	Tue, 22 Oct 2024 15:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vggnr4kB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609BD88FA8; Tue, 22 Oct 2024 15:42:31 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B8E088D97
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 15:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-431481433bdso59852985e9.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729604548; x=1730209348;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mCqsTb28ZbhW68DmckG6fI0Q63gMSYjnDHsA3TMkaB8=;
 b=Vggnr4kBKDI1ZD5vXfyR0HCJQ3YVwZ/HyFHnuZOY8TeIncAE+NJ+0uDUXOH3c4Jk0H
 pNEfIROwV2jpppaLKg8W0YkxmHw35VKNXiSxX13gPD23e4aDph8RcuteiVpM0y6FmDjn
 ZOlOLmvfOTpMbMh3A6TheO2S4PFJu0LN2kRCdypLUq59cyUUwboUtBbi1wx8LEVP9ROR
 TPcyHPRSc3bim1FfESw5C6nHiPJiNhwthq9VLNV/dykHgqUvnRg2I83BmgzSeOCtl0NK
 FcOoypKzgnd84nq3yWfp3Ts7PPxNIablIAZ7Yow5aeklLuX4ekEIdZpLGQ0Ys6swyGmq
 c4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729604548; x=1730209348;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mCqsTb28ZbhW68DmckG6fI0Q63gMSYjnDHsA3TMkaB8=;
 b=rihrLwkX3XCoWhcu297Ve2kqo0kD3lBda0OhOF2AVAb8ffvNvhV9E6oeXzwbHAlMvM
 G5g+u99zfP83BMjWROtnMjs84xxozsOhC1gudXF2UEBabL5eqj7X9l/2mPK2nHi4LoJD
 j6n73Ch0l2BQOr0SiKxRRBorN3qc8OTqAAC+8PBnYZLDcffzLkdmVSzrrCqueyIOcAAV
 XQDyYIDhvjSzIgzS039pPa93620buhyMBMfmBNnAM+pH0oTFJqVRYQeDKH/xEXGrLQaD
 ffr29v3Q8wBPUXr4XjhS6vYdR1Cr3p3fAlCun2g6SVFinZzUAFnaCH7P/i9wYBRJNSj0
 e5yg==
X-Gm-Message-State: AOJu0Yzn2Zs6MdMHv0530na8Clsjx2OPcmP4s4cZMjUKOHh5KL5beC+H
 LeN+mQyDA0ZKlhqezZBliPHD2bZeDaz1G0/bqHLfIWkYS3E+2uyN5o7fA9Vfxlo=
X-Google-Smtp-Source: AGHT+IGyFrOGcnwR/8PPl4uzi4w+QKaffRn/jvMchR7CIkkxrMunj/j9A+BkcRjB2UQOQ8ygfCw5FA==
X-Received: by 2002:a05:600c:1907:b0:431:1512:743b with SMTP id
 5b1f17b1804b1-4317cac091bmr23276135e9.21.1729604548413; 
 Tue, 22 Oct 2024 06:42:28 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57b9fesm88865095e9.12.2024.10.22.06.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 06:42:27 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>,
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com,
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
Subject: Re: [PATCH 2/6] bootstd: android: add non-A/B image support
In-Reply-To: <20241017-adnroidv2-v1-2-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-2-781c939902c9@baylibre.com>
Date: Tue, 22 Oct 2024 15:42:24 +0200
Message-ID: <87o73cuudb.fsf@baylibre.com>
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

Hi Guillaume,

Thank you for the patch.

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> Update android bootmeth to support non-A/B image.
> Enable AB support only when ANDROID_AB is enabled.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  boot/Kconfig                     |  1 -
>  boot/bootmeth_android.c          | 53 ++++++++++++++++++++++++++++++++++------
>  configs/am62x_a53_android.config |  1 +
>  configs/sandbox_defconfig        |  1 +
>  4 files changed, 47 insertions(+), 9 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 1d50a83a2d2f..fa0739ff05dd 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -500,7 +500,6 @@ config BOOTMETH_ANDROID
>  	bool "Bootdev support for Android"
>  	depends on X86 || ARM || SANDBOX
>  	depends on CMDLINE
> -	select ANDROID_AB
>  	select ANDROID_BOOT_IMAGE
>  	select CMD_BCB
>  	imply CMD_FASTBOOT
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 2e7f85e4a708..8fa4952df3f2 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -29,6 +29,7 @@
>  #define BCB_PART_NAME "misc"
>  #define BOOT_PART_NAME "boot"
>  #define VENDOR_BOOT_PART_NAME "vendor_boot"
> +#define SLOT_LEN 2
>  
>  /**
>   * struct android_priv - Private data
> @@ -42,7 +43,7 @@
>   */
>  struct android_priv {
>  	enum android_boot_mode boot_mode;
> -	char slot[2];
> +	char *slot;
>  	u32 header_version;
>  };
>  
> @@ -71,7 +72,11 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
>  	char *buf;
>  	int ret;
>  
> -	sprintf(partname, BOOT_PART_NAME "_%s", priv->slot);
> +	if (priv->slot)
> +		sprintf(partname, BOOT_PART_NAME "_%s", priv->slot);
> +	else
> +		sprintf(partname, BOOT_PART_NAME);
> +
>  	ret = part_get_info_by_name(desc, partname, &partition);
>  	if (ret < 0)
>  		return log_msg_ret("part info", ret);
> @@ -108,7 +113,11 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
>  	char *buf;
>  	int ret;
>  
> -	sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> +	if (priv->slot)
> +		sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> +	else
> +		sprintf(partname, VENDOR_BOOT_PART_NAME);
> +
>  	ret = part_get_info_by_name(desc, partname, &partition);
>  	if (ret < 0)
>  		return log_msg_ret("part info", ret);
> @@ -142,6 +151,11 @@ static int android_read_slot_from_bcb(struct bootflow *bflow, bool decrement)
>  	char slot_suffix[3];
>  	int ret;
>  
> +	if (!CONFIG_IS_ENABLED(ANDROID_AB)) {
> +		priv->slot = NULL;
> +		return 0;
> +	}
> +
>  	ret = part_get_info_by_name(desc, BCB_PART_NAME, &misc);
>  	if (ret < 0)
>  		return log_msg_ret("part", ret);
> @@ -150,6 +164,7 @@ static int android_read_slot_from_bcb(struct bootflow *bflow, bool decrement)
>  	if (ret < 0)
>  		return log_msg_ret("slot", ret);
>  
> +	priv->slot = malloc(SLOT_LEN);
>  	priv->slot[0] = BOOT_SLOT_NAME(ret);
>  	priv->slot[1] = '\0';
>  
> @@ -274,7 +289,7 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  	configure_serialno(bflow);
>  	configure_bootloader_version(bflow);
>  
> -	if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL) {
> +	if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL && priv->slot) {
>  		ret = bootflow_cmdline_set_arg(bflow, "androidboot.force_normal_boot",
>  					       "1", false);
>  		if (ret < 0) {
> @@ -323,14 +338,24 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
>  {
>  	struct disk_partition partition;
>  	char partname[PART_NAME_LEN];
> +	int partname_len;

Should be size_t since we compare it with the output of strlen().

>  	int ret;
>  	u32 n;
>  
>  	/* Ensure name fits in partname it should be: <name>_<slot>\0 */

The comment is not valid for non A/B. Maybe we can update it?

/*
 * Ensure name fits in partname.
 * For A/B, it should be <name>_<slot>\0
 * For non A/B, it should be <name>\0
 */

> -	if (strlen(name) > (PART_NAME_LEN - 2 - 1))
> +	if (CONFIG_IS_ENABLED(ANDROID_AB))
> +		partname_len = PART_NAME_LEN - 2 - 1;
> +	else
> +		partname_len = PART_NAME_LEN - 1;
> +
> +	if (strlen(name) > partname_len)
>  		return log_msg_ret("name too long", -EINVAL);
>  
> -	sprintf(partname, "%s_%s", name, slot);
> +	if (slot)
> +		sprintf(partname, "%s_%s", name, slot);
> +	else
> +		sprintf(partname, "%s", name);
> +
>  	ret = part_get_info_by_name(desc, partname, &partition);
>  	if (ret < 0)
>  		return log_msg_ret("part", ret);
> @@ -382,7 +407,7 @@ static int run_avb_verification(struct bootflow *bflow)
>  	AvbSlotVerifyData *out_data;
>  	enum avb_boot_state boot_state;
>  	char *extra_args;
> -	char slot_suffix[3];
> +	char *slot_suffix = "";

Why are we making this a char *?

Can't we keep slot_suffix[3] = ""; instead ?

It should work similarly and avoids using malloc() and free()
for a local variable.

>  	bool unlocked = false;
>  	int ret;
>  
> @@ -390,7 +415,10 @@ static int run_avb_verification(struct bootflow *bflow)
>  	if (!avb_ops)
>  		return log_msg_ret("avb ops", -ENOMEM);
>  
> -	sprintf(slot_suffix, "_%s", priv->slot);
> +	if (priv->slot) {
> +		slot_suffix = malloc(3);
> +		sprintf(slot_suffix, "_%s", priv->slot);
> +	}
>  
>  	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
>  	if (ret != AVB_IO_RESULT_OK)
> @@ -427,12 +455,18 @@ static int run_avb_verification(struct bootflow *bflow)
>  	if (ret < 0)
>  		goto free_out_data;
>  
> +	if (priv->slot)
> +		free(slot_suffix);
> +
>  	return 0;
>  
>   free_out_data:
>  	if (out_data)
>  		avb_slot_verify_data_free(out_data);
>  
> +	if (priv->slot)
> +		free(slot_suffix);
> +
>  	return log_msg_ret("avb cmdline", ret);
>  }
>  #else
> @@ -480,6 +514,9 @@ static int boot_android_normal(struct bootflow *bflow)
>  	}
>  	set_abootimg_addr(loadaddr);
>  
> +	if (priv->slot)
> +		free(priv->slot);
> +
>  	ret = bootm_boot_start(loadaddr, bflow->cmdline);
>  
>  	return log_msg_ret("boot", ret);
> diff --git a/configs/am62x_a53_android.config b/configs/am62x_a53_android.config
> index adbe2b8e126f..2aca51e3a107 100644
> --- a/configs/am62x_a53_android.config
> +++ b/configs/am62x_a53_android.config
> @@ -11,6 +11,7 @@ CONFIG_RANDOM_UUID=y # Needed for FASTBOOT_CMD_OEM_FORMAT
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>  # Enable Android boot flow
>  CONFIG_BOOTMETH_ANDROID=y
> +CONFIG_ANDROID_AB=y
>  CONFIG_SYS_BOOTM_LEN=0x4000000
>  CONFIG_SYS_MALLOC_LEN=0x08000000
>  CONFIG_AVB_VERIFY=y
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index d111858082d5..6b8dedf20712 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -50,6 +50,7 @@ CONFIG_LOG_DEFAULT_LEVEL=6
>  CONFIG_LOGF_FUNC=y
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_STACKPROTECTOR=y
> +CONFIG_ANDROID_AB=y
>  CONFIG_CMD_CPU=y
>  CONFIG_CMD_LICENSE=y
>  CONFIG_CMD_SMBIOS=y
>
> -- 
> 2.34.1
