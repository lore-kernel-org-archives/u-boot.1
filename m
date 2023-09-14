Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B8BEEAA40
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 13:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3BA086828;
	Thu, 14 Sep 2023 15:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GkB8Hg31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF5686F58; Thu, 14 Sep 2023 15:56:28 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3515867C7
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 15:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40472f9db24so5757005e9.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694699786; x=1695304586; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j4jzZ9qbKSvbvP2oRe4LOm+VcNd7Svmm6Ib7Nqp6cNs=;
 b=GkB8Hg312VVoeql/mo43ou0CG4LHrugNeyLu8ufGMMtPzQDKhzTs4O81nxjfK6szna
 eD9DFyYl8R/382/xrKF07vIa5RI1kWlIguO11S43Ghee8zDbUJB+hQ/NDTrHaEfnXbAR
 VUsa5QUGSwj3GVmpJH/JAHPl/Q0gLtB2ES6x6ltVcCpDzbTmh2Qgx7MAJrEa3epxTX7h
 UOHXwg0bC7qjn/XZK5ss+G03+sPyTeO1hvVVS0I+2oPRnDE/PcIjRtMN2BiOxVSYO/+N
 WAoYgm4YubVXyyMfTo6Ng3UGndlwhOml+CNY3X7z7LibG+kg1SssefLAX5gW+W5EuEN3
 a5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694699786; x=1695304586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4jzZ9qbKSvbvP2oRe4LOm+VcNd7Svmm6Ib7Nqp6cNs=;
 b=H8N+VVfY6nLxl1HBVubgfL90uf3rWh21e0puXgM5CMDIZyACbzsqnH1ljxA/hsNYDg
 8EOWYw34yAYHfHfU13gahbcLNh9Tf1gLqvf08ZHA8kX7f3xRrS3q4T/4QKSXRq7UJv8E
 DK53wNr9bs+72h4/F1pfE2PdGjHs+2H/uGsiDEcFLFPviHWcRlVydQ06afvZg0k4W7MB
 yOnbznb4qnFHhYtLwyA6uF38qIudVSxINSVnC9B91rS0FuqVQNiiba+H0IAtGLg6jHPX
 dovEEaeJvjTVwDUSyssZf0mcHoIaB7UhilTxUiAAFf1oRFoqWpBsmWEv+1k2aYEhk2qV
 uL3A==
X-Gm-Message-State: AOJu0YwLIJsMBGjMUMHA6OP/k4e4FIfH92YEJ62LgxLI5ZcMy0d6wHXx
 BVHufC8Ddl0OOlM9l7bSiWnjCw==
X-Google-Smtp-Source: AGHT+IFej7fLlA8zDjBoOL5J7xfmYyJ0c1tpcTGts3LLK+jLomGThQl3hGCGw96XmbOqRCN4i4hiIg==
X-Received: by 2002:a05:600c:230c:b0:402:ea9e:7d26 with SMTP id
 12-20020a05600c230c00b00402ea9e7d26mr4835491wmo.2.1694699786164; 
 Thu, 14 Sep 2023 06:56:26 -0700 (PDT)
Received: from hera (ppp089210246083.access.hol.gr. [89.210.246.83])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a05600c458a00b00403c8dde953sm4332139wmo.22.2023.09.14.06.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 06:56:25 -0700 (PDT)
Date: Thu, 14 Sep 2023 16:56:23 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>, f@hera
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v2 4/6] efi_loader: support boot from URI device path
Message-ID: <ZQMRB9allzBqrFGX@hera>
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-5-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901102542.609239-5-masahisa.kojima@linaro.org>
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

Kojima-san

On Fri, Sep 01, 2023 at 07:25:40PM +0900, Masahisa Kojima wrote:
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
>  lib/efi_loader/efi_bootmgr.c | 197 +++++++++++++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a40762c74c..0e8d2ca9d1 100644
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
> @@ -168,6 +172,193 @@ out:
>  	return ret;
>  }
>
> +#if (IS_ENABLED(CONFIG_BLKMAP) && IS_ENABLED(CONFIG_CMD_WGET) && IS_ENABLED(CONFIG_CMD_DNS))
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
> +	efi_status_t ret;
> +	efi_handle_t bm_handle;
> +	struct efi_handler *handler;
> +	struct efi_device_path *file_path;
> +	struct efi_device_path *device_path;
> +
> +	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&bm_handle)) {
> +		log_warning("DM_TAG_EFI not found\n");
> +		return EFI_INVALID_PARAMETER;
> +	}
> +
> +	ret = efi_search_protocol(bm_handle,
> +				  &efi_simple_file_system_protocol_guid, &handler);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	ret = efi_search_protocol(bm_handle, &efi_guid_device_path, &handler);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	ret = efi_protocol_open(handler, (void **)&device_path, efi_root, NULL,
> +				EFI_OPEN_PROTOCOL_GET_PROTOCOL);
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

We need to decide what we want here.  There were recently some patches from
Raymond [0] which piggybacked on your earlier eficonfig work.  I think the
last patch of this series hasn't been merged due to a test failing, but we
should fix it.
That patch has a different approach.  Everytime a disk appears it will add
a boot option if the default filepath is found and that's how we fixed the
behaviour of efibootmgr to adhere to the EFI spec.  This patch is doing the
opposite, trying to detect the BOOTAA64.EFI etc on the fly.  I think I
prefer the approach you have here, but we should end up with one solution
to solve both.

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

Don't we have a better way to validate isos and efi apps instead of
the extension?  The efi is checked against a valid PE/COFF image so I guess
we'll really on the mount to fail for isos?

> +	 * If the file is ".efi" and PE-COFF image, load the downloaded file.
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
> +	} else if (!strncmp(&uridp->uri[uri_len - 4], ".efi", 4)) {
> +		efi_handle_t mem_handle = NULL;
> +		struct efi_device_path *file_path = NULL;
> +
> +		ret = efi_check_pe((void *)image_addr, image_size, NULL);
> +		if (ret != EFI_SUCCESS) {
> +			log_err("Error: downloaded image is not a PE-COFF image\n");
> +			return EFI_INVALID_PARAMETER;
> +		}
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

[0] https://lore.kernel.org/u-boot/20230619212303.128288-1-raymond.mao@linaro.org/

Thanks
/Ilias
