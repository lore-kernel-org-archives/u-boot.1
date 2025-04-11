Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814D2C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 07:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D37183E78;
	Fri, 11 Apr 2025 09:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KfBCiM/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6413F82B18; Fri, 11 Apr 2025 09:47:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4607183EF5
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744357658; x=1744962458; i=xypron.glpk@gmx.de;
 bh=AkjnAeNnFK438Yz/256k8g790xb+3P33JDGysYb8s94=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KfBCiM/7gRKoiVXNHJnYPFgiZpIyS6EWh9dwHyAGE9T27nGQ3PKyTLcQXMWsa2/t
 7b8WI5cBIaXeFTnGu+ZjQcrhm1863iJ/vBdHB5K449YfeP9d79qewp5dcNwPYZiCV
 FHYZMYZ6OH9vwPAfgTZ3JDpLbwW7P8cAkH6IGx9k6n2I8wrKnNAbtbU5UiDp+vyhM
 mWIwHZdV7OYLyrMUcQ/zE4tuvZP3MsOWt6db3Qrc9KJGX+Uxh4BcxoScjlr8HB/Gu
 4BdDPIuV4lvUeypCXJGSRiNpNNLaPZuy4Oslppc6Xx0jcn57Yfth1jFDrYah67S6c
 fEcO+Pz3gye4SKurxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.163]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1tNUh63LI1-00nmXa; Fri, 11
 Apr 2025 09:47:37 +0200
Message-ID: <dece70a5-a0a4-4240-8517-252fb97eef7f@gmx.de>
Date: Fri, 11 Apr 2025 09:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi_loader: efi_load_initrd: provide a memory mapped
 initrd
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-2-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250318132347.646703-2-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SQ2/sSU/prZGg/XyvdcZkp+Q5nFSoEnajU8umJU24QdZIoqhwUk
 OY5YtXRZ3pJaxk1oATkFjrDn8EnFwGHYI/pIPciXvjcSKlKhNqXKjj3b4XUhzq73OCDNwsP
 7kSU6x435qNvT7iabon5qR/sJsEr3BJ0Ybwu0/ddOnNYvGQ+sMmyfT9SldsHO/uOjjxSjmD
 eesIbVqNauJa/hF1s47Hw==
UI-OutboundReport: notjunk:1;M01:P0:JSIbqs9smKg=;HzRfwcxJuJB0YlhYy50Hk5XW7oV
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

On 3/18/25 14:23, Adriano Cordova wrote:
> U-Boot can pass an initrd to subsequent boot stages via the
> EFI_LOAD_FILE2_PROTOCOL. The current implementation only supports
> this functionality via the efi boot manager: the initrd is taken
> from the load options of the BootCurrent variable. This commit adds
> support for registering a memory mapped initrd, e.g. loaded from a
> FIT image. For now this new method takes precedence over loading the
> initrd from the BootCurrent variable (if both are present) because
> the BootCurrent variable is not cleared on exiting the boot manager.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   include/efi_loader.h             |  2 +-
>   lib/efi_loader/efi_bootmgr.c     |  2 +-
>   lib/efi_loader/efi_load_initrd.c | 71 +++++++++++++++++++++++++++-----
>   3 files changed, 62 insertions(+), 13 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e9c10819ba2..cc732dc4807 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -667,7 +667,7 @@ efi_status_t efi_http_register(const efi_handle_t ha=
ndle,
>   			       struct efi_service_binding_protocol *http_service_binding);
>   /* Called by bootefi to make the watchdog available */
>   efi_status_t efi_watchdog_register(void);
> -efi_status_t efi_initrd_register(void);
> +efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd);
>   efi_status_t efi_initrd_deregister(void);
>   /* Called by bootefi to make SMBIOS tables available */
>   /**
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index c6124c590d9..6e66cf3793c 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -670,7 +670,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle=
_t *handle,
>
>   	/* try to register load file2 for initrd's */
>   	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> -		ret =3D efi_initrd_register();
> +		ret =3D efi_initrd_register(NULL);
>   		if (ret !=3D EFI_SUCCESS)
>   			goto error;
>   	}
> diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_=
initrd.c
> index fb8cc7bcbe3..74b92f8bd66 100644
> --- a/lib/efi_loader/efi_load_initrd.c
> +++ b/lib/efi_loader/efi_load_initrd.c
> @@ -42,6 +42,7 @@ static const struct efi_lo_dp_prefix dp_lf2_handle =3D=
 {
>   };
>
>   static efi_handle_t efi_initrd_handle;
> +static struct efi_device_path *efi_initrd_dp;
>
>   /**
>    * get_initrd_fp() - Get initrd device path from a FilePathList device=
 path
> @@ -72,6 +73,41 @@ static efi_status_t get_initrd_fp(struct efi_device_p=
ath **initrd_fp)
>   	return EFI_SUCCESS;
>   }
>
> +/**
> + * efi_initrd_from_mem() - load initial RAM disk from memory
> + *
> + * This function copies the initrd from the memory mapped device
> + * path pointed to by efi_initrd_dp
> + *
> + * @buffer_size:		size of allocated buffer
> + * @buffer:			buffer to load the file
> + *
> + * Return:			status code
> + */
> +static efi_status_t efi_initrd_from_mem(efi_uintn_t *buffer_size, void =
*buffer)
> +{
> +	efi_status_t ret =3D EFI_NOT_FOUND;
> +	efi_uintn_t bs;
> +	struct efi_device_path_memory *mdp;
> +
> +	mdp =3D (struct efi_device_path_memory *)efi_initrd_dp;
> +	if (!mdp)
> +		return ret;
> +
> +	bs =3D mdp->end_address - mdp->start_address;
> +
> +	if (!buffer || *buffer_size < bs) {
> +		ret =3D EFI_BUFFER_TOO_SMALL;
> +		*buffer_size =3D bs;
> +	} else {
> +		memcpy(buffer, (void *)mdp->start_address, bs);

This fails to build on 32bit:

+lib/efi_loader/efi_load_initrd.c: In function 'efi_initrd_from_mem':
+lib/efi_loader/efi_load_initrd.c:103:32: error: cast to pointer from
integer of different size [-Werror=3Dint-to-pointer-cast]
+  103 |                 memcpy(buffer, (void *)mdp->start_address, bs);
+      |                                ^

start_address is of type u64.

(void *)(uinptr_t) is the correct conversion.

Best regards

Heinrich

> +		*buffer_size =3D bs;
> +		ret =3D EFI_SUCCESS;
> +	}
> +
> +	return ret;
> +}
> +
>   /**
>    * efi_load_file2_initrd() - load initial RAM disk
>    *
> @@ -118,6 +154,9 @@ efi_load_file2_initrd(struct efi_load_file_protocol =
*this,
>   		goto out;
>   	}
>
> +	if (efi_initrd_dp)
> +		return EFI_EXIT(efi_initrd_from_mem(buffer_size, buffer));
> +
>   	ret =3D get_initrd_fp(&initrd_fp);
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
> @@ -209,6 +248,9 @@ efi_status_t efi_initrd_deregister(void)
>   							 NULL);
>   	efi_initrd_handle =3D NULL;
>
> +	efi_free_pool(efi_initrd_dp);
> +	efi_initrd_dp =3D NULL;
> +
>   	return ret;
>   }
>
> @@ -234,24 +276,31 @@ static void EFIAPI efi_initrd_return_notify(struct=
 efi_event *event,
>    * This function creates a new handle and installs a Linux specific ve=
ndor
>    * device path and an EFI_LOAD_FILE2_PROTOCOL. Linux uses the device p=
ath
>    * to identify the handle and then calls the LoadFile service of the
> - * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk.
> + * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk. If dp_initrd i=
s
> + * not provided, the initrd will be taken from the BootCurrent variable
> + *
> + * @dp_initrd:	optional device path containing an initrd
>    *
>    * Return:	status code
>    */
> -efi_status_t efi_initrd_register(void)
> +efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd)
>   {
>   	efi_status_t ret;
>   	struct efi_event *event;
>
> -	/*
> -	 * Allow the user to continue if Boot#### file path is not set for
> -	 * an initrd
> -	 */
> -	ret =3D check_initrd();
> -	if (ret =3D=3D EFI_INVALID_PARAMETER)
> -		return EFI_SUCCESS;
> -	if (ret !=3D EFI_SUCCESS)
> -		return ret;
> +	if (dp_initrd) {
> +		efi_initrd_dp =3D dp_initrd;
> +	} else {
> +		/*
> +		* Allow the user to continue if Boot#### file path is not set for
> +		* an initrd
> +		*/
> +		ret =3D check_initrd();
> +		if (ret =3D=3D EFI_INVALID_PARAMETER)
> +			return EFI_SUCCESS;
> +		if (ret !=3D EFI_SUCCESS)
> +			return ret;
> +	}
>
>   	ret =3D efi_install_multiple_protocol_interfaces(&efi_initrd_handle,
>   						       /* initramfs */

