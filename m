Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF7AC19F4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 12:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 069378843D;
	Wed,  8 May 2024 14:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jwdx74JN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9533F8844B; Wed,  8 May 2024 14:04:40 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCB588427
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 14:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51f2ebbd8a7so4992584e87.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 05:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715169878; x=1715774678; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gz/WTSyDN0ynjYAREnC4JZjrlUBE5BfWVuzuY5Lb8Rw=;
 b=jwdx74JNLrsYdaZ7Ifdn9XXXolnqhQixyyiQH3smbGwGGbQjkB7SOceyjsHMg2ptuh
 1hOb8z9GuzaH4W4Z0EoPisrofEXh1GdMFmz6omVG8NTxbEYHKYkvD4ds0C3D6chLb9Ya
 WWFqc+Kl0EJ6U41Eub7dMHQ5x4jWMGEYxbevXAUkEespZUtaBJXUaxEc/TtZpqpWMVVz
 C2pjPfO+odkwpdwRSqTWQP+TLZGyx8/JNvZ3G5IDFQgUwyDEFWpaFEYx062Tv5E4mzCf
 98qJuDdPz6SqIytMXrj9WAOtCcGz15tRGvsNQMtnpLOx0qDMexv9Y+pYouxQ0KFR/Uyg
 XIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715169878; x=1715774678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gz/WTSyDN0ynjYAREnC4JZjrlUBE5BfWVuzuY5Lb8Rw=;
 b=GIOXkYHYsSQANPbswzSXnqVaSZjs8oDhZsN+d6J9zn0fSw5SL1lf6fS/8JBBD7wW28
 1L2JIF4QSST/8lThVNlQBwoM85jvDAckmLbWZNO9eB59IxHsMH4imJM/foe5OjR/Vnbt
 nBpOX/F1PMCNU25tjPLV6X5nH0m80hFf/xEDdxMZyhtaPoJesXfKEH7bAPXNcsrxX/Dm
 fkHAjTN1KPPl032p25Vmf7neweMnvT7j4VxpLtEyWHudZ9qEkQvU6ushyGDmqVdZf91w
 ME+lhqijPSV9d862W5Wh5YkpYgIsApq4V7yIwB5HBra9xpZzNQRz5vDshNwvag++VM8p
 FLfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQkuj8kPnJ4jietQJncvcYck/vqMDlCHykwTWfb6qRXpPtoM7Hvc+uFzCMhvRDMFIWpyE3KqloG3PjQQv2HiwrqjRhmA==
X-Gm-Message-State: AOJu0Yz+D7glhVALQPz/EEC/IMkwZC6sy6SmtDlCvZ5b6D6jJ78kqAPv
 fn2dEsNsfdiwcV0oRA17DFXZAb/ag2RaXqD5uG2DHLLN92LyPLXMDWkaNiEH3LI=
X-Google-Smtp-Source: AGHT+IES1OlQcZpjKu56UrdnGHatvdw1HhHKTwczKGyUc7S0ycZwBODmbh20aUx0Rn0+vMLqU9Hlfw==
X-Received: by 2002:ac2:420a:0:b0:51e:eac7:d69b with SMTP id
 2adb3069b0e04-5217c566c78mr1457761e87.27.1715169877324; 
 Wed, 08 May 2024 05:04:37 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 d23-20020a170906345700b00a5a0c95bf93sm144695ejb.141.2024.05.08.05.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 05:04:37 -0700 (PDT)
Date: Wed, 8 May 2024 15:04:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] efi_loader: capsule: detect possible ESP device path
Message-ID: <c2323896-132a-4b02-86db-5cb62c6e1ba5@moroto.mountain>
References: <20240508112401.155528-1-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508112401.155528-1-o451686892@gmail.com>
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

On Wed, May 08, 2024 at 07:24:01PM +0800, Weizhao Ouyang wrote:
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index de0d49ebebda..919e3cba071b 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -922,6 +922,105 @@ static bool device_is_present_and_system_part(struct efi_device_path *dp)
>  	return true;
>  }
>  
> +/**
> + * get_esp_from_boot_option_file_path - get the expand device path
> + *
> + * Get a possible efi system partition by expanding a boot option
> + * file path.
> + *
> + * @boot_dev	The device path pointing to a boot option
> + * Return:	The full ESP device path or NULL if fail
> + */
> +static struct efi_device_path *get_esp_from_boot_option_file_path(struct efi_device_path *boot_dev)
> +{
> +	efi_status_t ret = EFI_SUCCESS;
> +	efi_handle_t handle;
> +	struct efi_device_path *dp = boot_dev;
> +	struct efi_device_path *full_path = NULL;
> +
> +	ret = EFI_CALL(efi_locate_device_path(&efi_simple_file_system_protocol_guid,
> +					      &dp,
> +					      &handle));
> +	if (ret != EFI_SUCCESS)
> +		ret = EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &dp, &handle));
> +
> +	/* Expand Media Device Path */
> +	if (ret == EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {

Flip this around.  Always do failure handling.  Never do success
handling.  full_path is always NULL.  Just return that.  Delete
the variable.

	if (ret != EFI_SUCCESS ||
	    !EFI_DP_TYPE(dp, END, END))
		return NULL;


> +		struct efi_device_path *temp_dp;
> +		struct efi_block_io *block_io;
> +		void *buffer;
> +		efi_handle_t *simple_file_system_handle;
> +		efi_uintn_t number_handles, index;
> +		u32 size;
> +		u32 temp_size;
> +
> +		temp_dp = boot_dev;
> +		ret = EFI_CALL(efi_locate_device_path(&efi_simple_file_system_protocol_guid,
> +						      &temp_dp,
> +						      &handle));
> +		/*
> +		 * For device path pointing to simple file system, it only expands to one
> +		 * full path
> +		 */
> +		if (ret == EFI_SUCCESS && EFI_DP_TYPE(temp_dp, END, END)) {

"Always" was hyperbole.  This success handling is fine.

> +			if (device_is_present_and_system_part(temp_dp))
> +				return temp_dp;
> +		}
> +
> +		/*
> +		 * For device path only pointing to the removable device handle, try to
> +		 * search all its children handles
> +		 */
> +		ret = EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &temp_dp, &handle));

ret is not used.  Delete.

> +		EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
> +
> +		/* Align with edk2, issue a dummy read to the device to check the device change */
> +		ret = EFI_CALL(efi_handle_protocol(handle, &efi_block_io_guid, (void **)&block_io));
> +		if (ret == EFI_SUCCESS) {

	if (ret != EFI_SUCCESS)
		return NULL;

> +			buffer = memalign(block_io->media->io_align, block_io->media->block_size);
> +			if (buffer) {

	if (!buffer)
		return NULL;


> +				ret = EFI_CALL(block_io->read_blocks(block_io,
> +								     block_io->media->media_id,
> +								     0,
> +								     block_io->media->block_size,
> +								     buffer));

Delete the unused "ret = " assignment.

> +				free(buffer);
> +			} else {
> +				return full_path;
> +			}
> +		} else {
> +			return full_path;
> +		}
> +
> +		/* detect the default boot file from removable media */
> +		size = efi_dp_size(boot_dev) - sizeof(struct efi_device_path);
> +		EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
> +						  &efi_simple_file_system_protocol_guid,
> +						  NULL,
> +						  &number_handles,
> +						  &simple_file_system_handle));
> +		for (index = 0; index < number_handles; index++) {
> +			EFI_CALL(efi_handle_protocol(simple_file_system_handle[index],
> +						     &efi_guid_device_path,
> +						     (void **)&temp_dp));
> +
> +			log_debug("Search ESP %pD\n", temp_dp);
> +			temp_size = efi_dp_size(temp_dp) - sizeof(struct efi_device_path);
> +			if (size <= temp_size && !memcmp(temp_dp, boot_dev, size)) {
> +				if (device_is_present_and_system_part(temp_dp)) {

You could combine these conditions:

		if (size <= temp_size &&
		    memcmp(temp_dp, boot_dev, size) == 0 &&
		    device_is_present_and_system_part(temp_dp)) {
			efi_free_pool(simple_file_system_handle);
			return temp_dp;
		}


> +					efi_free_pool(simple_file_system_handle);
> +					return temp_dp;
> +				}
> +			}
> +		}
> +
> +		if (simple_file_system_handle)
> +			efi_free_pool(simple_file_system_handle);
> +	}
> +
> +	return full_path;
> +}
> +
>  /**
>   * find_boot_device - identify the boot device
>   *
> @@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
>  	int i, num;
>  	struct efi_simple_file_system_protocol *volume;
>  	struct efi_device_path *boot_dev = NULL;
> +	struct efi_device_path *full_path = NULL;

No need to initialize this to NULL, it disables static checker warnings
for uninitialized variables so it can lead to bugs.

>  	efi_status_t ret;
>  
>  	/* find active boot device in BootNext */
> @@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
>  			if (device_is_present_and_system_part(boot_dev)) {
>  				goto found;
>  			} else {
> -				efi_free_pool(boot_dev);
> -				boot_dev = NULL;
> +				full_path = get_esp_from_boot_option_file_path(boot_dev);
> +				if (full_path) {
> +					boot_dev = full_path;

Later, we free full_path but do we ever free the original boot_dev?

> +					goto found;
> +				} else {
> +					efi_free_pool(boot_dev);
> +					boot_dev = NULL;
> +				}

Better to delete indenting where you can:

			full_path = get_esp_from_boot_option_file_path(boot_dev);
			if (full_path) {
				boot_dev = full_path;
				goto found;
			}
			efi_free_pool(boot_dev);
			boot_dev = NULL;

regards,
dan carpenter


