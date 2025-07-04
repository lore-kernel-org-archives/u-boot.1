Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F949C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 11:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCC78091A;
	Fri,  4 Jul 2025 13:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qlDtgkhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF81782063; Fri,  4 Jul 2025 13:22:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44271806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 13:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751628116; x=1752232916; i=xypron.glpk@gmx.de;
 bh=dFtAaYUWyPu4u8CoSx//qctgEO3rTL9EZG5Lkw6am4c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qlDtgkheHJ1vno7KzZxXhIjvP+0gd3Im1PYArwUPm3toB6lnFB1X3rs6NIrhm+yq
 5fPoGLVLkMyWfiIqr2zSUAGldZh97AsaZ1yehgRAQyQCEHHxt1hrlEOX1/hOQ9NpJ
 fDTcrSW2BLi1ylgqj8Vl50diiUt2saawV0yg8gNuNIieuhmHeTlUGmJ+xy0jGU4CF
 mE0UZUQAN1mTkGTBOBfhfguvtnp0YOmHHhZxcs748tHTFXrDTV5cbfXzgi88sDGIw
 sx6R0po8S3bpMoVOW6Ekz45YIIDmKRRg7vUZNUeuSdp70vAzYzscCpGTb2m5pd3BD
 hazyzJNteyO3GMzC2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1ueE3w0nM0-005L4C; Fri, 04
 Jul 2025 13:21:56 +0200
Message-ID: <c5820e06-0d37-4ed4-969c-ff9b9d6bad51@gmx.de>
Date: Fri, 4 Jul 2025 13:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/25] efi_loader: fwu_arm_psa: Add set_image and
 get_image_info support
To: abdellatif.elkhlifi@arm.com
Cc: trini@konsulko.com, Davidson kumaresan <davidson.kumaresan@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
 <20250702152528.1180414-14-abdellatif.elkhlifi@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250702152528.1180414-14-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZChY2QUmyujxQWW22e+bO5qqDETE2UCN47SXByL7aPP8jg2G+AC
 V2GQg5H7p690/QaKI0f8NjlQHddfJjZwz/3RD1ijveS3Ha67d/ARBEnpGDO+OFWDAlfgKnt
 8b1V9IWm+SpOdzMT0cJElCrJaHoWA8GnT3mMeerGAhAZOh8tBok5CEL3darQVK2lYaqtAXo
 GbhvS2KFMUcr3kHCzbBhw==
UI-OutboundReport: notjunk:1;M01:P0:/DuCT86MuKM=;pfJt54E8uI2Rmg2T62Yf6oS93gK
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

On 02.07.25 17:25, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>=20
> Implement set_image and get_image_info through RAW functions
>=20
> The implementation is done using efi_firmware_raw_set_image()
> and efi_firmware_get_image_info()
>=20
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> ---
>   lib/efi_loader/efi_firmware.c | 97 ++++++++++++++++++++++-------------
>   1 file changed, 60 insertions(+), 37 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware=
.c
> index 75501e21557..dad80beb23e 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -4,6 +4,12 @@
>    *
>    *  Copyright (c) 2020 Linaro Limited
>    *			Author: AKASHI Takahiro
> + *
> + * Copyright 2025 Arm Limited and/or its affiliates <open-source-office=
@arm.com>
> + *
> + * Authors:
> + *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> + *   Davidson kumaresan <davidson.kumaresan@arm.com>
>    */
>  =20
>   #define LOG_CATEGORY LOGC_EFI
> @@ -14,6 +20,7 @@
>   #include <efi_variable.h>
>   #include <env.h>
>   #include <fwu.h>
> +#include <fwu_arm_psa.h>
>   #include <image.h>
>   #include <signatures.h>
>  =20
> @@ -601,10 +608,21 @@ efi_status_t EFIAPI efi_firmware_get_image_info(
>   	     !descriptor_size || !package_version || !package_version_name))
>   		return EFI_EXIT(EFI_INVALID_PARAMETER);
>  =20
> -	ret =3D efi_fill_image_desc_array(image_info_size, image_info,
> -					descriptor_version, descriptor_count,
> -					descriptor_size, package_version,
> -					package_version_name);
> +	if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
> +		ret =3D fwu_arm_psa_get_image_info(image_info_size, image_info,
> +						 descriptor_version,
> +						 descriptor_count,
> +						 descriptor_size,
> +						 package_version,
> +						 package_version_name);
> +	} else {
> +		ret =3D efi_fill_image_desc_array(image_info_size, image_info,
> +						descriptor_version,
> +						descriptor_count,
> +						descriptor_size,
> +						package_version,
> +						package_version_name);
> +	}
>  =20
>   	return EFI_EXIT(ret);
>   }
> @@ -749,48 +767,53 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>   	if (status !=3D EFI_SUCCESS)
>   		return EFI_EXIT(status);
>  =20
> -	/*
> -	 * dfu_alt_num is assigned from 0 while image_index starts from 1.
> -	 * dfu_alt_num is calculated by (image_index - 1) when multi bank upda=
te
> -	 * is not used.
> -	 */
> -	dfu_alt_num =3D image_index - 1;
> -	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> +	if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
> +		if (fwu_update_image(image, image_index, image_size))
> +			return EFI_EXIT(EFI_DEVICE_ERROR);
> +	} else {
>   		/*
> -		 * Based on the value of update bank, derive the
> -		 * image index value.
> +		 * dfu_alt_num is assigned from 0 while image_index starts from 1.
> +		 * dfu_alt_num is calculated by (image_index - 1) when multi bank upd=
ate
> +		 * is not used.
>   		 */
> -		ret =3D fwu_get_dfu_alt_num(image_index, &dfu_alt_num);
> -		if (ret) {
> -			log_debug("Unable to get FWU image_index\n");
> -			return EFI_EXIT(EFI_DEVICE_ERROR);
> +		dfu_alt_num =3D image_index - 1;
> +		if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> +			/*
> +			 * Based on the value of update bank, derive the
> +			 * image index value.
> +			 */
> +			ret =3D fwu_get_dfu_alt_num(image_index, &dfu_alt_num);
> +			if (ret) {
> +				log_debug("Unable to get FWU image_index\n");
> +				return EFI_EXIT(EFI_DEVICE_ERROR);
> +			}

This part looks like at two different changes mixed in a single patch:

* Add support for FWU_ARM_PSA
* Reading fwu_get_dfu_alt_num() even if neither of FWU_ARM_PSA and=20
FWU_MULTI_BANK_UPDATE is selected.

Please, separate the changes and describe the changes in the respective=20
commit messages.

Best regards

Heinrich

>   		}
> -	}
>  =20
> -	orig_dfu_env =3D env_get("dfu_alt_info");
> -	if (orig_dfu_env) {
> -		orig_dfu_env =3D strdup(orig_dfu_env);
> -		if (!orig_dfu_env) {
> -			log_err("strdup() failed!\n");
> -			return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> +		orig_dfu_env =3D env_get("dfu_alt_info");
> +		if (orig_dfu_env) {
> +			orig_dfu_env =3D strdup(orig_dfu_env);
> +			if (!orig_dfu_env) {
> +				log_err("strdup() failed!\n");
> +				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> +			}
> +		}
> +		if (env_set("dfu_alt_info", update_info.dfu_string)) {
> +			log_err("Unable to set env variable \"dfu_alt_info\"!\n");
> +			free(orig_dfu_env);
> +			return EFI_EXIT(EFI_DEVICE_ERROR);
>   		}
> -	}
> -	if (env_set("dfu_alt_info", update_info.dfu_string)) {
> -		log_err("Unable to set env variable \"dfu_alt_info\"!\n");
> -		free(orig_dfu_env);
> -		return EFI_EXIT(EFI_DEVICE_ERROR);
> -	}
>  =20
> -	ret =3D dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
> -			       NULL, NULL);
> +		ret =3D dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
> +				       NULL, NULL);
>  =20
> -	if (env_set("dfu_alt_info", orig_dfu_env))
> -		log_warning("Unable to restore env variable \"dfu_alt_info\".  Furthe=
r DFU operations may fail!\n");
> +		if (env_set("dfu_alt_info", orig_dfu_env))
> +			log_warning("Unable to restore env variable \"dfu_alt_info\".  Furth=
er DFU operations may fail!\n");
>  =20
> -	free(orig_dfu_env);
> +		free(orig_dfu_env);
>  =20
> -	if (ret)
> -		return EFI_EXIT(EFI_DEVICE_ERROR);
> +		if (ret)
> +			return EFI_EXIT(EFI_DEVICE_ERROR);
> +	}
>  =20
>   	efi_firmware_set_fmp_state_var(&state, image_index);
>  =20

