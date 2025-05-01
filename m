Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDF0C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 07:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D9A8059D;
	Thu,  1 May 2025 09:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="I4wjY2bD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC6E8070C; Thu,  1 May 2025 09:15:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF3B8056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 09:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746083751; x=1746688551; i=xypron.glpk@gmx.de;
 bh=yluQnn95pJ29fkTmOv8MVp8vuLBN7ABQyB7rchNnx3c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=I4wjY2bDO0+g+uk5TfF/yUuPkb2nGqyATwaY7+fOMP9Q4RM177+Kc4MoLryI87+X
 XPS3bTefgnBnbWiYxPOWgY+xoPIL+8xti6a8HOiMFHwf1ywIley2WUemS9wDEKLwi
 ACG6PQ2UrPBfGUJ3IvblRmN25/W4F0ggRfnG4AKMVnLQnbRcqug/upeZKYLU9HUsF
 2DttWX4QTsJVxb9kTLcGBCaMwLZd98AjysgDcjCTJNZ7KmrDjcvftPWkjKayz21Gd
 y1J9cZWKt6ObteDJDVAgO7hM9nSCFCtLLGriCwWcSuQOpHMPWMpiEc2lsRorXjAn6
 Iys8GhwKH/iLBzOL2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.107.6]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1umjZS1Qg1-00arNl; Thu, 01
 May 2025 09:15:51 +0200
Message-ID: <4bbbb9dd-bbdb-4b57-9eb6-211e483915d5@gmx.de>
Date: Thu, 1 May 2025 09:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: bootbin: split initrd registration and
 installation
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250501011514.2209452-1-adriano.cordova@canonical.com>
 <20250501011514.2209452-2-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250501011514.2209452-2-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZMDUnEls8xvZGOPVW+lW/Ivl95V/EouoaLHTu+Rsf5uZIjYk4Bv
 ile3/m9kvqitJLbIgi/qKKhxlKStWRazlcxi/8p5NyAHSTN6hesvdobp4imZYZsMszMeuAq
 cfG1R86r3Xu82lWNGowxZLMLMpjpovGmVP6+mYoqBGaJaaJ5w+F3Agrr/xyWCUhS7Ou0jm0
 CazktQG4Ln24YHrnrt42A==
UI-OutboundReport: notjunk:1;M01:P0:Vw8wnj8kEcQ=;ga9rW1NN+jmd2pdJWsDhoIMmWcR
 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
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

On 5/1/25 03:15, Adriano Cordova wrote:
> Current support for initrd in EFI booting has two flaws:
>=20
> 1. Installs a NULL initrd via LoadFile2 protocol if `efi_binary_run_dp` =
does
>     not provide an initrd. In this case, a LoadFile2 should not be insta=
lled
>     at all.
> 2. Initrd is not properly uninstalled if booting fails at some point bet=
ween
>     initrd installation and the call to `do_bootefi_exec`. This affects =
both
>     booting via `efi_bootbin` and via `efi_bootmgr`.
>=20
> This commit splits the process of setting an initrd into two steps:
>=20
> First, `efi_initrd_set_from_mem` creates a memory-backed device path for=
 the
> initrd. (This step is not necessary when using `efi_bootmgr`, and for no=
w is
> only used when booting FIT images, but the `bootefi` command could now b=
e
> expanded to receive an initrd argument.)
>=20
> Second, `efi_initrd_install` creates an initrd handle and installs the
> LoadFile2 protocol exposing the initrd. This is needed both when booting=
 with
> `efi_bootbin` and with `efi_bootmgr`, so it is called in `do_bootefi_exe=
c`,
> which is the first common point between the two bootflows.
>=20
> Also, as `do_bootefi_exec` is the only place where `efi_initrd_install` =
is
> called, the cleanup function `efi_initrd_uninstall` can be called before
> exiting `do_bootefi_exec` instead of using the event
> `efi_guid_event_group_return_to_efibootmgr`. (This also makes more sense=
 as
> now initrd is also used by `efi_bootbin`.)
>=20
> Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   include/efi_loader.h             |  8 ++-
>   lib/efi_loader/efi_bootbin.c     | 14 +++---
>   lib/efi_loader/efi_bootmgr.c     |  7 ---
>   lib/efi_loader/efi_helper.c      | 11 +++++
>   lib/efi_loader/efi_load_initrd.c | 84 +++++++++++++++++---------------
>   5 files changed, 68 insertions(+), 56 deletions(-)
>=20
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 144b749278a..0a3ca799287 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -597,6 +597,12 @@ efi_status_t efi_env_set_load_options(efi_handle_t =
handle, const char *env_var,
>   void *efi_get_configuration_table(const efi_guid_t *guid);
>   /* Install device tree */
>   efi_status_t efi_install_fdt(void *fdt);
> +/* Install initrd LoadFile2 protocol */
> +efi_status_t efi_initrd_install(void);
> +/* Uninstall initrd LoadFile2 protocol */
> +efi_status_t efi_initrd_uninstall(void);
> +/* Set an initrd */
> +efi_status_t efi_initrd_set_from_mem(void *initrd, size_t initd_sz);
>   /* Execute loaded UEFI image */
>   efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
>   /* Run loaded UEFI image with given fdt */
> @@ -667,8 +673,6 @@ efi_status_t efi_http_register(const efi_handle_t ha=
ndle,
>   			       struct efi_service_binding_protocol *http_service_binding);
>   /* Called by bootefi to make the watchdog available */
>   efi_status_t efi_watchdog_register(void);
> -efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd);
> -efi_status_t efi_initrd_deregister(void);
>   /* Called by bootefi to make SMBIOS tables available */
>   /**
>    * efi_acpi_register() - write out ACPI tables
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index d0f7da309ce..637f2c0d195 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -220,7 +220,6 @@ static efi_status_t efi_binary_run_dp(void *image, s=
ize_t size, void *fdt,
>   				      struct efi_device_path *dp_img)
>   {
>   	efi_status_t ret;
> -	struct efi_device_path *dp_initrd;
>  =20
>   	/* Initialize EFI drivers */
>   	ret =3D efi_init_obj_list();
> @@ -234,13 +233,12 @@ static efi_status_t efi_binary_run_dp(void *image,=
 size_t size, void *fdt,
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>  =20
> -	dp_initrd =3D efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, init=
d_sz);
> -	if (!dp_initrd)
> -		return EFI_OUT_OF_RESOURCES;
> -
> -	ret =3D efi_initrd_register(dp_initrd);
> -	if (ret !=3D EFI_SUCCESS)
> -		return ret;
> +	/* Set initrd if provided */
> +	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> +		ret =3D efi_initrd_set_from_mem(initrd, initd_sz);
> +		if (ret !=3D EFI_SUCCESS)
> +			return ret;
> +	}
>  =20
>   	return efi_run_image(image, size, dp_dev, dp_img);
>   }
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index c0df5cb9acd..19c7e16a25b 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -683,13 +683,6 @@ static efi_status_t try_load_entry(u16 n, efi_handl=
e_t *handle,
>   	if (ret !=3D EFI_SUCCESS)
>   		goto error;
>  =20
> -	/* try to register load file2 for initrd's */
> -	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> -		ret =3D efi_initrd_register(NULL);
> -		if (ret !=3D EFI_SUCCESS)
> -			goto error;
> -	}
> -
>   	log_info("Booting: Label: %ls Device path: %pD\n", lo.label, lo.file_=
path);
>  =20
>   	/* Ignore the optional data in auto-generated boot options */
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 3936139ca41..b4c207ea33f 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -658,6 +658,13 @@ efi_status_t do_bootefi_exec(efi_handle_t handle, v=
oid *load_options)
>   		goto out;
>   	}
>  =20
> +	/* Create initrd handle and install LoadFile2 protocol */
> +	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> +		ret =3D efi_initrd_install();
> +		if (ret !=3D EFI_SUCCESS)
> +			goto out;
> +	}
> +
>   	/* Call our payload! */
>   	ret =3D EFI_CALL(efi_start_image(handle, &exit_data_size, &exit_data)=
);
>   	if (ret !=3D EFI_SUCCESS) {
> @@ -683,6 +690,10 @@ out:
>   		}
>   	}
>  =20
> +	/* Destroy initrd handle with LoadFile2 protocol */
> +	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD))
> +		ret =3D efi_initrd_uninstall();
> +
>   	/* Control is returned to U-Boot, disable EFI watchdog */
>   	efi_set_watchdog(0);
>  =20
> diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_=
initrd.c
> index b5d58943a80..7210bf16d09 100644
> --- a/lib/efi_loader/efi_load_initrd.c
> +++ b/lib/efi_loader/efi_load_initrd.c
> @@ -74,7 +74,40 @@ static efi_status_t get_initrd_fp(struct efi_device_p=
ath **initrd_fp)
>   }
>  =20
>   /**
> - * efi_initrd_from_mem() - load initial RAM disk from memory
> + * efi_initrd_set_from_mem() - set initial RAM disk from memory
> + *
> + * Set efi_initrd_dp to a memory mapped device path pointing
> + * to @initrd. If @initrd is NULL then efi_initrd_dp gets cleared.
> + *
> + *
> + * @initrd:    address of initrd or NULL if none is provided
> + * @initrd_sz: size of initrd
> + * Return:     status code
> + */
> +efi_status_t efi_initrd_set_from_mem(void *initrd, size_t initd_sz)
> +{
> +	struct efi_device_path *old_initrd_dp;
> +
> +	old_initrd_dp =3D efi_initrd_dp;

In efi_initrd_uninstall() we free the device-path and set efi_initrd_dp=20
=3D NULL.
It seems you are handling the case of efi_initrd_install() failing here.

To me this looks a bit convoluted. Calling efi_initrd_register() as in=20
your v3 series would allow handling errors when they occur.

The static variable efi_initrd_dp should receive some documentation in=20
the code explaining how it is used. This could be in a separate patch.

I will merge your v3 series as it fixes the case of no initrd.

We can handle the uninstallation of the LoadFile2 protocol in a patch on=
=20
top of that.

Best regards

Heinrich

> +
> +	if (!initrd) {
> +		efi_initrd_dp =3D NULL;
> +		goto out;
> +	}
> +
> +	efi_initrd_dp =3D efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, =
initd_sz);
> +	if (!efi_initrd_dp) {
> +		efi_initrd_dp =3D old_initrd_dp;
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +out:
> +	efi_free_pool(old_initrd_dp);
> +	return EFI_SUCCESS;
> +}
> +
> +/**
> + * efi_initrd_get_from_mem() - get initial RAM disk from memory
>    *
>    * This function copies the initrd from the memory mapped device
>    * path pointed to by efi_initrd_dp
> @@ -84,7 +117,7 @@ static efi_status_t get_initrd_fp(struct efi_device_p=
ath **initrd_fp)
>    *
>    * Return:			status code
>    */
> -static efi_status_t efi_initrd_from_mem(efi_uintn_t *buffer_size, void =
*buffer)
> +static efi_status_t efi_initrd_get_from_mem(efi_uintn_t *buffer_size, v=
oid *buffer)
>   {
>   	efi_status_t ret =3D EFI_NOT_FOUND;
>   	efi_uintn_t bs;
> @@ -155,7 +188,7 @@ efi_load_file2_initrd(struct efi_load_file_protocol =
*this,
>   	}
>  =20
>   	if (efi_initrd_dp)
> -		return EFI_EXIT(efi_initrd_from_mem(buffer_size, buffer));
> +		return EFI_EXIT(efi_initrd_get_from_mem(buffer_size, buffer));
>  =20
>   	ret =3D get_initrd_fp(&initrd_fp);
>   	if (ret !=3D EFI_SUCCESS)
> @@ -224,14 +257,14 @@ out:
>   }
>  =20
>   /**
> - * efi_initrd_deregister() - delete the handle for loading initial RAM =
disk
> + * efi_initrd_uninstall() - delete the handle for loading initial RAM d=
isk
>    *
>    * This will delete the handle containing the Linux specific vendor de=
vice
> - * path and EFI_LOAD_FILE2_PROTOCOL for loading an initrd
> + * path and the installed EFI_LOAD_FILE2_PROTOCOL for loading an initrd
>    *
>    * Return:	status code
>    */
> -efi_status_t efi_initrd_deregister(void)
> +efi_status_t efi_initrd_uninstall(void)
>   {
>   	efi_status_t ret;
>  =20
> @@ -255,42 +288,22 @@ efi_status_t efi_initrd_deregister(void)
>   }
>  =20
>   /**
> - * efi_initrd_return_notify() - return to efibootmgr callback
> - *
> - * @event:	the event for which this notification function is registered
> - * @context:	event context
> - */
> -static void EFIAPI efi_initrd_return_notify(struct efi_event *event,
> -						  void *context)
> -{
> -	efi_status_t ret;
> -
> -	EFI_ENTRY("%p, %p", event, context);
> -	ret =3D efi_initrd_deregister();
> -	EFI_EXIT(ret);
> -}
> -
> -/**
> - * efi_initrd_register() - create handle for loading initial RAM disk
> + * efi_initrd_install() - create handle for loading initial RAM disk
>    *
>    * This function creates a new handle and installs a Linux specific ve=
ndor
>    * device path and an EFI_LOAD_FILE2_PROTOCOL. Linux uses the device p=
ath
>    * to identify the handle and then calls the LoadFile service of the
> - * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk. If dp_initrd i=
s
> - * not provided, the initrd will be taken from the BootCurrent variable
> - *
> - * @dp_initrd:	optional device path containing an initrd
> + * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk. If efi_initrd_=
dp
> + * is not set the initrd will be taken from the BootCurrent variable. I=
f
> + * an initrd is not found the handle is not created.
>    *
>    * Return:	status code
>    */
> -efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd)
> +efi_status_t efi_initrd_install(void)
>   {
>   	efi_status_t ret;
> -	struct efi_event *event;
>  =20
> -	if (dp_initrd) {
> -		efi_initrd_dp =3D dp_initrd;
> -	} else {
> +	if (!efi_initrd_dp) {
>   		/*
>   		* Allow the user to continue if Boot#### file path is not set for
>   		* an initrd
> @@ -314,12 +327,5 @@ efi_status_t efi_initrd_register(struct efi_device_=
path *dp_initrd)
>   		return ret;
>   	}
>  =20
> -	ret =3D efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
> -			       efi_initrd_return_notify, NULL,
> -			       &efi_guid_event_group_return_to_efibootmgr,
> -			       &event);
> -	if (ret !=3D EFI_SUCCESS)
> -		log_err("Creating event failed\n");
> -
>   	return ret;
>   }

