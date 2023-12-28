Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D747C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 985F487A03;
	Thu, 28 Dec 2023 14:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oIijzj6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 357C287A06; Thu, 28 Dec 2023 14:14:22 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 389E787A01
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so344047466b.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703769259; x=1704374059; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8azHen3wN1mqG5ulw1m4HXH+0Tk8NFaYbB0cZ5gx9s=;
 b=oIijzj6wtq3GyvHwCVQptAcEzbYFV37VHVQZP6KwCRaHMXAbv+PhJHi1oL9kcl9oON
 cuS16BEFseiJMa9XLXCgh1RJ7cHYUIZcIek2Fo/LA/zJH0MQE6dyrYwE9QB6LQXaqgtt
 Eo0S4FlG9ZPTiUBx/fJEdOavyFdAA4cXofyGmVjEXBu+prT151LUXd+zLrUXH6dVc5uj
 pq0IXNa/A1HZaUlXYb74QMINBceqrR3bdngoZ8XKEd07fjIjXITSwOzrNI7p9iZex8Op
 AiVr3Km0/4HtinRldawQewgs2Q0sNCHEZ7dSYaGZ0/sYegH/T42aqO6XeZCd7SCFTs2D
 eq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703769259; x=1704374059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8azHen3wN1mqG5ulw1m4HXH+0Tk8NFaYbB0cZ5gx9s=;
 b=HUoPURDpXTsNXKPcPFR207jfy80v31b94sHKYZu+2j1mJOHKoIcJiHyNKfVDmnZyXW
 kFUL2dqSHQfbEtZ34WP9GIe8Np7xfBj72zcDwTeK3y5EeA4FPccfiJOJrJw+O60HeF0V
 oimO18PCdQ+07iomP5m+Hy2QDsovWL1OHxnhfTxrQTf1ac+NTnNTaXO7miTZ+Fd2zJNA
 O9NcDaK30B9w+PX0daBJLkoJ5c+moHATaV2mFK6q1XEmHli5uZr77/0DyLIrWUr5pVa6
 5om/kWoTHZYxmHPn6Oq1Z5519+xLTIFdHBkel2da0481tAwTDztBhHjzvFla2CorssA0
 ufZg==
X-Gm-Message-State: AOJu0Yw8BS2eTPnjS+u6T5U2m9Ea7GjakuXf9xHF38Bs8BlFpUoYncVx
 Wc/AzfDVcHMy0nOLikbwDBZWJXDlF8USkg==
X-Google-Smtp-Source: AGHT+IGLryUsrRRxocJu9GGHoqSv4dmAxBp25t4NtT1J5P0BToSHoO6XiKy8WiBP42s4qh+CJtjlaQ==
X-Received: by 2002:a17:906:2932:b0:a26:f301:6b52 with SMTP id
 v18-20020a170906293200b00a26f3016b52mr1350401ejd.49.1703769259641; 
 Thu, 28 Dec 2023 05:14:19 -0800 (PST)
Received: from hades (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a170906495100b00a26b057df46sm3824755ejt.126.2023.12.28.05.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 05:14:19 -0800 (PST)
Date: Thu, 28 Dec 2023 15:14:16 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/2] efi_loader: auto-generate boot option for each
 blkio device
Message-ID: <ZY10qKZiGWrjQkUG@hades>
References: <20231226062820.722358-1-masahisa.kojima@linaro.org>
 <20231226062820.722358-2-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226062820.722358-2-masahisa.kojima@linaro.org>
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

[...]

>  /**
>   * try_load_entry() - try to load image for boot option
>   *
> @@ -594,7 +638,6 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
>  	}
>  
>  	if (lo.attributes & LOAD_OPTION_ACTIVE) {
> -		struct efi_device_path *file_path;
>  		u32 attributes;
>  
>  		log_debug("trying to load \"%ls\" from %pD\n", lo.label,
> @@ -611,10 +654,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
>  			else
>  				ret = EFI_LOAD_ERROR;
>  		} else {
> -			file_path = expand_media_path(lo.file_path);
> -			ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> -						      NULL, 0, handle));
> -			efi_free_pool(file_path);
> +			ret = try_load_from_media(lo.file_path, handle);
>  		}
>  		if (ret != EFI_SUCCESS) {
>  			log_warning("Loading %ls '%ls' failed\n",
> @@ -748,19 +788,19 @@ error:
>   * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
>   *
>   * @opt:		pointer to the media boot option structure
> - * @volume_handles:	pointer to the efi handles
> + * @handles:		pointer to the efi handles
>   * @count:		number of efi handle
>   * Return:		status code
>   */
>  static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boot_option *opt,
> -						      efi_handle_t *volume_handles,
> -						      efi_status_t count)
> +						      efi_handle_t *handles,
> +						      efi_uintn_t *count)
>  {
> -	u32 i;
> +	u32 i, num = 0;
>  	struct efi_handler *handler;
>  	efi_status_t ret = EFI_SUCCESS;
>  
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < *count; i++) {
>  		u16 *p;
>  		u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
>  		char *optional_data;
> @@ -768,8 +808,15 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
>  		char buf[BOOTMENU_DEVICE_NAME_MAX];
>  		struct efi_device_path *device_path;
>  		struct efi_device_path *short_dp;
> +		struct efi_block_io *blkio;
> +
> +		ret = efi_search_protocol(handles[i], &efi_block_io_guid, &handler);
> +		blkio = handler->protocol_interface;
>  
> -		ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
> +		if (blkio->media->logical_partition)
> +			continue;
> +
> +		ret = efi_search_protocol(handles[i], &efi_guid_device_path, &handler);
>  		if (ret != EFI_SUCCESS)
>  			continue;
>  		ret = efi_protocol_open(handler, (void **)&device_path,
> @@ -777,7 +824,7 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
>  		if (ret != EFI_SUCCESS)
>  			continue;
>  
> -		ret = efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
> +		ret = efi_disk_get_device_name(handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
>  		if (ret != EFI_SUCCESS)
>  			continue;
>  
> @@ -801,17 +848,20 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
>  		 * to store guid, instead of realloc the load_option.
>  		 */
>  		lo.optional_data = "1234567";
> -		opt[i].size = efi_serialize_load_option(&lo, (u8 **)&opt[i].lo);
> -		if (!opt[i].size) {
> +		opt[num].size = efi_serialize_load_option(&lo, (u8 **)&opt[num].lo);
> +		if (!opt[num].size) {

I am a bit lost here. Why are we using 'num' instead of 'i'? The opt
variable contains all media boot options with a block_io_protocol right?
Aren't we going to copy the wrong load options in optional_data if we don't use
'i'?

>  			ret = EFI_OUT_OF_RESOURCES;
>  			goto out;
>  		}
>  		/* set the guid */
> -		optional_data = (char *)opt[i].lo + (opt[i].size - u16_strsize(u"1234567"));
> +		optional_data = (char *)opt[num].lo + (opt[num].size - u16_strsize(u"1234567"));
>  		memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_guid_t));
> +		num++;
>  	}
>  
>  out:
> +	*count = num;
> +
>  	return ret;
>  }
>  

[...]

Thanks
/Ilias
