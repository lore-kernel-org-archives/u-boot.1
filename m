Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F32CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 12:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 375F286B8B;
	Mon, 25 Sep 2023 14:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fEhb2bjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF7986BE6; Mon, 25 Sep 2023 14:37:52 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012A386B89
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 14:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3215f19a13aso6202839f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695645469; x=1696250269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=efXBsXXZEGTGTAmRwoweoFAUBoL1Hiw7PFka4kj0rIo=;
 b=fEhb2bjWYAL0eBorrfaOVPR3yP52YOw1+N6QQ/6TaANKXmim6KADiBJFu0GSavG3By
 g/BO/JXYHbrDCG9yFvZUBR+mpMR7Sc+MBzPauiXBHmnLr4VzAz+TCv7CSn6CdiGcuvVy
 dYg5Pfnn+5cyDox0AspusSs7BCgIasj0lazNIsOpf9algQMH661mJzJDW3FIo/M0VHtK
 NfpdRV1DM+1pvxD1h50iNoy4ofMaVbBX9gCcveZz0sdbxuyIxS/ZtwGpltubcny+Qx3D
 7scfPRqQXMd7OYHxPAB2rurkPF0sR0w3xDNEXQmly0Qj9yLPiC5aw6wZ7edK9NccPZNW
 NEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695645469; x=1696250269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efXBsXXZEGTGTAmRwoweoFAUBoL1Hiw7PFka4kj0rIo=;
 b=gt1dFjVMVKq3P/7CYl+5FljCbASnmq2YQSm/hikEyNX/21BYYpRorItANRVXNRv74Q
 Zj7VOl4OhMJTbegu/n8dSqUjhx90AftHZcOlUdk8QJf5kYlMlbfwzguYbU9lQV4vGl5I
 60S6jdLexSTPLVqCjZF4WLVEv5w+7CRW/e/bvbFXFU3aAV1nD2FeH3vtd2XuQsMZHkPx
 f4kqCd2PHJTYrMNuujt0hPodfXpFO0uNM9pWHdilPQU7b4jmEskrhbizJTpgRhpdUp/v
 njDKbLNHl0pbrWr4NkHxTWvPvpkZzkmX5i+1YvTZ63PsXm3pq8xYZKLYz17gb3NYUT+6
 qQaA==
X-Gm-Message-State: AOJu0Yy4rJdZfgf5xH91AtdkUvEEmGM/K6a26QpeUdKe1pbeQWXnsbqE
 cmE2aBgIMM9fXqj2CTDpRzCo5A==
X-Google-Smtp-Source: AGHT+IEiw/hhCbut3k4E1Oxqx8igYYV/ZvUXpQeaJJ37OQ8mlAMp3KxUPy02TXFxm3BXqkjQZZ8QbQ==
X-Received: by 2002:a5d:4802:0:b0:314:3fc0:ba82 with SMTP id
 l2-20020a5d4802000000b003143fc0ba82mr5936492wrq.37.1695645469366; 
 Mon, 25 Sep 2023 05:37:49 -0700 (PDT)
Received: from hera (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a5d400e000000b00321773bb933sm11833790wrp.77.2023.09.25.05.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 05:37:49 -0700 (PDT)
Date: Mon, 25 Sep 2023 15:37:47 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v4 4/8] efi_loader: support boot from URI device path
Message-ID: <ZRF/G1+qSllqoNYL@hera>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-5-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922071119.1439482-5-masahisa.kojima@linaro.org>
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

On Fri, Sep 22, 2023 at 04:11:15PM +0900, Masahisa Kojima wrote:
> This supports to boot from the URI device path.
> When user selects the URI device path, bootmgr downloads
> the file using wget into the address specified by loadaddr
> env variable.
> If the file is .iso or .img file, mount the image with blkmap
> then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> If the file is .efi file, load and start the downloaded file.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  lib/efi_loader/efi_bootmgr.c | 189 +++++++++++++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a40762c74c..605be5041e 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -7,10 +7,14 @@
>
>  #define LOG_CATEGORY LOGC_EFI
>
> +#include <blk.h>
> +#include <blkmap.h>
>  #include <common.h>
>  #include <charset.h>
> +#include <dm.h>
>  #include <log.h>
>  #include <malloc.h>
> +#include <net.h>
>  #include <efi_default_filename.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> @@ -168,6 +172,182 @@ out:
>  	return ret;
>  }
>
> +/**
> + * mount_image() - mount the image with blkmap
> + *
> + * @lo_label	u16 label string of load option
> + * @image_addr:	image address
> + * @image_size	image size
> + * Return:	pointer to the UCLASS_BLK udevice, NULL if failed
> + */
> +static struct udevice *mount_image(u16 *lo_label, ulong image_addr, int image_size)
> +{
> +	int err;
> +	struct blkmap *bm;
> +	struct udevice *bm_dev;
> +	char *label = NULL, *p;
> +
> +	label = efi_alloc(utf16_utf8_strlen(lo_label) + 1);
> +	if (!label)
> +		return NULL;
> +
> +	p = label;
> +	utf16_utf8_strcpy(&p, lo_label);
> +	err = blkmap_create_ramdisk(label, image_addr, image_size, &bm_dev);
> +	if (err) {
> +		efi_free_pool(label);
> +		return NULL;
> +	}
> +	bm = dev_get_plat(bm_dev);
> +
> +	efi_free_pool(label);
> +
> +	return bm->blk;
> +}
> +
> +/**
> + * try_load_default_file() - try to load the default file
> + *
> + * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> + * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
> + *
> + * @dev			pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> + * @image_handle:	pointer to handle for newly installed image
> + * Return:		status code
> + */
> +static efi_status_t try_load_default_file(struct udevice *dev,
> +					  efi_handle_t *image_handle)
> +{

Maybe I misunderstood you on the previous series.  Wasn't the plan to merge
the patch that adds boot options automatically when a disk is scanned? This
code could only look for a boot option with '1234567' in its load options
instead of rescanning all devices with the EFI_SIMPLE_FILE_SYSTEM_PROTOCO
installed

> +	efi_status_t ret;
> +	efi_handle_t handle;
> +	struct efi_handler *handler;
> +	struct efi_device_path *file_path;
> +	struct efi_device_path *device_path;
> +
> +	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> +		log_warning("DM_TAG_EFI not found\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
> +	ret = efi_search_protocol(handle,
> +				  &efi_simple_file_system_protocol_guid, &handler);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> +					 (void **)&device_path, efi_root, NULL,
> +					 EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	file_path = expand_media_path(device_path);
> +	ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
> +				      image_handle));
> +
> +	efi_free_pool(file_path);
> +
> +	return ret;
> +}
> +
> +/**
> + * load_default_file_from_blk_dev() - load the default file
> + *
> + * @blk		pointer to the UCLASS_BLK udevice
> + * @handle:	pointer to handle for newly installed image
> + * Return:	status code
> + */
> +static efi_status_t load_default_file_from_blk_dev(struct udevice *blk,
> +						   efi_handle_t *handle)
> +{
> +	efi_status_t ret;
> +	struct udevice *partition;
> +
> +	/* image that has no partition table but a file system */
> +	ret = try_load_default_file(blk, handle);
> +	if (ret == EFI_SUCCESS)
> +		return ret;
> +
> +	/* try the partitions */
> +	device_foreach_child(partition, blk) {
> +		enum uclass_id id;
> +
> +		id = device_get_uclass_id(partition);
> +		if (id != UCLASS_PARTITION)
> +			continue;
> +
> +		ret = try_load_default_file(partition, handle);
> +		if (ret == EFI_SUCCESS)
> +			return ret;
> +	}
> +
> +	return EFI_NOT_FOUND;
> +}
> +
> +/**
> + * try_load_from_uri_path() - Handle the URI device path
> + *
> + * @uridp:	uri device path
> + * @lo_label	label of load option
> + * @handle:	pointer to handle for newly installed image
> + * Return:	status code
> + */
> +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> +					   u16 *lo_label,
> +					   efi_handle_t *handle)
> +{
> +	char *s;
> +	int uri_len;
> +	int image_size;
> +	efi_status_t ret;
> +	ulong image_addr;
> +
> +	s = env_get("loadaddr");
> +	if (!s) {
> +		log_err("Error: loadaddr is not set\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +	image_addr = hextoul(s, NULL);
> +	image_size = wget_with_dns(image_addr, uridp->uri);
> +	if (image_size < 0)
> +		return EFI_INVALID_PARAMETER;
> +
> +	/*
> +	 * If the file extension is ".iso" or ".img", mount it and try to load
> +	 * the default file.
> +	 * If the file is PE-COFF image, load the downloaded file.
> +	 */
> +	uri_len = strlen(uridp->uri); /* todo: directly use uridp->uri */
> +	if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> +	    !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> +		struct udevice *blk;
> +
> +		blk = mount_image(lo_label, image_addr, image_size);
> +		if (!blk)
> +			return EFI_INVALID_PARAMETER;
> +
> +		ret = load_default_file_from_blk_dev(blk, handle);
> +	} else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> +		efi_handle_t mem_handle = NULL;
> +		struct efi_device_path *file_path = NULL;
> +
> +		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> +					    (uintptr_t)image_addr, image_size);
> +		ret = efi_install_multiple_protocol_interfaces(
> +			&mem_handle, &efi_guid_device_path, file_path, NULL);
> +		if (ret != EFI_SUCCESS)
> +			return EFI_INVALID_PARAMETER;
> +
> +		ret = EFI_CALL(efi_load_image(false, efi_root, file_path,
> +					      (void *)image_addr, image_size,
> +					      handle));
> +	} else {
> +		log_err("Error: file type is not supported\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * try_load_entry() - try to load image for boot option
>   *
> @@ -211,6 +391,15 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
>  		if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
>  			/* file_path doesn't contain a device path */
>  			ret = try_load_from_short_path(lo.file_path, handle);
> +		} else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> +			if (IS_ENABLED(CONFIG_BLKMAP) &&
> +			    IS_ENABLED(CONFIG_CMD_WGET) &&
> +			    IS_ENABLED(CONFIG_CMD_DNS)) {
> +				ret = try_load_from_uri_path(
> +					(struct efi_device_path_uri *)
> +						lo.file_path,
> +					lo.label, handle);
> +			}

is ret initialized in this function?  Otherwise we need to initialize it if
one of the Kconfig options are disabled

>  		} else {
>  			file_path = expand_media_path(lo.file_path);
>  			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> --
> 2.34.1
>

Thanks
/Ilias
