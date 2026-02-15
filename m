Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BF2EF585E
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 08:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C3E83AA9;
	Sun, 15 Feb 2026 09:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BoqF1EhA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955F783AB7; Sun, 15 Feb 2026 09:48:50 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F7F80FA1
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 09:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771145321; x=1771750121; i=xypron.glpk@gmx.de;
 bh=8Aw0KID6weRQTgjI4ratmFs67REt8I4h2UVHOfCHjL0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BoqF1EhALH2GfnpuklL9juiiDpmWLVmJXzKlHkz4Xp3yuvd0plHTdNCeUkEKeMdX
 oOK85R44Cz9+voPZQdazEsZbH776JP5/w3uIRwI0pwvPb52oy6JarzmHZIZhcWsGS
 55BziArCJm/uopJPKmEbXNk788JgIJnDGM6PjAn4NTPjdGiHC+/i9finrHgkfodj/
 M4WE7UC8QFoU3Py7SVoGYZy4rRhgQzimtQ1NPzamnIod4iG8vksozsT0kfKmI2ZtT
 LAwFHj6bnohN9LcXTWih70wfSkIwZmUp0GSce1IlXwo9fF7Ex1ONCCY1hY3ttTZMy
 5a+ydZL5iXtK4LfrGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1vsvWB3QqV-005LGq; Sun, 15
 Feb 2026 09:48:41 +0100
Message-ID: <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
Date: Sun, 15 Feb 2026 09:48:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Shantur Rathore <i@shantur.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
References: <cover.1770825377.git.michal.simek@amd.com>
 <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Et0NkTTmFGhshbsHpRJHTUqh3Zi9FiMsrfihmW6+gR/Q7oiBYLa
 4KF+inImnsQNvOPetC9aiwMsD1ASVITQmxVWn7HlYmq6USBX8PG3XwiNVxmbEz8+MAQq6y5
 BQuTi7OlQuBf1M+CUNIELaYC4yVrdjIqonozt8vjalwQenL6VDW1Cn6STYRLWjuxOeEdlhA
 AQTe90wnSyxhmSXKpGK6g==
UI-OutboundReport: notjunk:1;M01:P0:w8UX2CWtxz8=;qzhRaOzn+CUtE3AS4gGCkkTrYxT
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

On 2/11/26 16:56, Michal Simek wrote:
> From: Shantur Rathore <i@shantur.com>
>=20
> Currently U-Boot uses ESP as storage for EFI variables.
> Devices with SPI Flash are used for storing environment with this
> commit we allow EFI variables to be stored on SPI Flash.
>=20
> https://github.com/rhboot/efivar
> is not updated to support this location that's why you can mimic it by
> running:
> dd if=3D/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e8=
18c3130c \
>     of=3D/tmp/vars skip=3D4 bs=3D1
> flashcp /tmp/vars /dev/mtdX
>=20
> where mtdX should match location defined by
> CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE.
>=20
> Signed-off-by: Shantur Rathore <i@shantur.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>=20
> ---
>=20
> Changes in v8:
> - Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVICE=
_INDEX
>=20
> Changes in v7:
> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>=20
> Changes in v6:
> - sed -i 's/efi_var_read/efi_var_from/g'
> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>=20
> Changes in v4:
> - Extend Kconfig description
> - Extend commit message and describe efivar missing part
> - use unify methods for reading/writing variable
>=20
> Changes in v3:
> - Fixed compiler warnings.
>=20
> Changes in v2:
> - Refactored efi_var_file to move common parts out as requested
> - Changed ifdefs to use CONFIG_IS_DEFINED
> - Fixed typos
>=20
>   lib/efi_loader/Kconfig      | 35 +++++++++++++-
>   lib/efi_loader/Makefile     |  1 +
>   lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 127 insertions(+), 1 deletion(-)
>   create mode 100644 lib/efi_loader/efi_var_sf.c
>=20
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 579eed658801..0f6f927ddaf1 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
>   	  Select this option if you want non-volatile UEFI variables to be
>   	  stored as file /ubootefi.var on the EFI system partition.
>  =20
> +config EFI_VARIABLE_SF_STORE
> +	bool "Store non-volatile UEFI variables in SPI Flash"
> +	depends on SPI_FLASH
> +	help
> +	  Select this option if you want non-volatile UEFI variables to be
> +	  stored in SPI Flash.
> +
> +	  Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use a=
s
> +	  the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
> +	  needed.
> +
> +	  Note that SPI Flash devices have a limited number of program/erase
> +	  cycles. Frequent updates to UEFI variables may cause excessive wear
> +	  and can permanently damage the flash device, particularly on SPI NAN=
D
> +	  or low-end SPI NOR parts without wear leveling. This option should b=
e
> +	  used with care on such systems, and is not recommended for platforms
> +	  where UEFI variables are updated frequently.
> +
>   config EFI_MM_COMM_TEE
>   	bool "UEFI variables storage service via the trusted world"
>   	depends on OPTEE
> @@ -153,7 +171,7 @@ endchoice
>  =20
>   config EFI_RT_VOLATILE_STORE
>   	bool "Allow variable runtime services in volatile storage (e.g RAM)"
> -	depends on EFI_VARIABLE_FILE_STORE
> +	depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE

Hello Michal,

If the backend store is SPI flash, we should not publish the variable=20
"RTStorageVolatile" at runtime as currently defined.

For the background see this commit for the efivar library:

https://github.com/rhboot/efivar/commit/68daa04654acbe1bbaa17ebfc23c371b39=
e69c6b

The first three patches look correct to me and I will add them to a=20
merge request for efi-next.

The usage of efi_var_mem_ins() and efi_var_mem_del() when SetVariable()=20
does not change anything is not flash-friendly. Michal, do you want to=20
have a look at this area?

@Ilias, @Vincent:
We currently lack documentation for the 3 variables.
Would it make sense to add the definition of the variables to chapter=20
source/chapter5-variable-storage.rst.

Would an efivar helper for SPI flash make sense?
How should RTStorageVolatile describe a SPI flash location?

Best regards

Heinrich

>   	help
>   	  When EFI variables are stored on file we don't allow SetVariableRT,
>   	  since the OS doesn't know how to write that file. At the same time
> @@ -194,6 +212,21 @@ config FFA_SHARED_MM_BUF_ADDR
>   	  the MM SP in secure world.
>   	  It is assumed that the MM SP knows the address of the shared MM com=
munication buffer.
>  =20
> +config EFI_VARIABLE_SF_OFFSET
> +	hex "EFI variables in SPI flash offset"
> +	depends on EFI_VARIABLE_SF_STORE
> +	help
> +	  Offset from the start of the SPI Flash where EFI variables will be s=
tored.
> +	  This should be aligned to the sector size of SPI Flash.
> +
> +config EFI_VARIABLE_SF_DEVICE_INDEX
> +	int "Device Index for target SPI Flash"
> +	depends on EFI_VARIABLE_SF_STORE
> +	default 0
> +	help
> +	  The index of SPI Flash device used for storing EFI variables. This w=
ould be
> +	  needed if there are more than 1 SPI Flash devices available to use.
> +
>   config EFI_VARIABLES_PRESEED
>   	bool "Initial values for UEFI variables"
>   	depends on !COMPILE_TEST
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index ca1775eb03be..d73ad43951b1 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -54,6 +54,7 @@ obj-y +=3D efi_variable_tee.o
>   else
>   obj-y +=3D efi_variable.o
>   obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) +=3D efi_var_file.o
> +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) +=3D efi_var_sf.o
>   obj-$(CONFIG_EFI_VARIABLES_PRESEED) +=3D efi_var_seed.o
>   endif
>   obj-y +=3D efi_watchdog.o
> diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
> new file mode 100644
> index 000000000000..61d68f7c5c94
> --- /dev/null
> +++ b/lib/efi_loader/efi_var_sf.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SPI Flash interface for UEFI variables
> + *
> + * Copyright (c) 2023, Shantur Rathore
> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#define LOG_CATEGORY LOGC_EFI
> +
> +#include <efi_loader.h>
> +#include <efi_variable.h>
> +#include <spi_flash.h>
> +#include <dm.h>
> +
> +efi_status_t efi_var_to_storage(void)
> +{
> +	efi_status_t ret;
> +	struct efi_var_file *buf;
> +	loff_t len;
> +	struct udevice *sfdev;
> +
> +	ret =3D efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> +	if (len > EFI_VAR_BUF_SIZE) {
> +		log_err("EFI var buffer length more than target SPI Flash size");
> +		ret =3D EFI_OUT_OF_RESOURCES;
> +		goto error;
> +	}
> +
> +	log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->l=
ength);
> +
> +	if (ret !=3D EFI_SUCCESS)
> +		goto error;
> +
> +	ret =3D uclass_get_device(UCLASS_SPI_FLASH, CONFIG_EFI_VARIABLE_SF_DEV=
ICE_INDEX, &sfdev);
> +	if (ret)
> +		goto error;
> +
> +	ret =3D spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_V=
AR_BUF_SIZE);
> +	log_debug("%s - Erased SPI Flash offset %x\n", __func__, CONFIG_EFI_VA=
RIABLE_SF_OFFSET);
> +	if (ret)
> +		goto error;
> +
> +	ret =3D spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, =
buf);
> +	log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
> +
> +	if (ret)
> +		goto error;
> +
> +	ret =3D EFI_SUCCESS;
> +error:
> +	if (ret)
> +		log_err("Failed to persist EFI variables in SF\n");
> +	free(buf);
> +	return ret;
> +}
> +
> +efi_status_t efi_var_from_storage(void)
> +{
> +	struct efi_var_file *buf;
> +	efi_status_t ret;
> +	struct udevice *sfdev;
> +
> +	buf =3D calloc(1, EFI_VAR_BUF_SIZE);
> +	if (!buf) {
> +		log_err("%s - Unable to allocate buffer\n", __func__);
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	ret =3D uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
> +	if (ret)
> +		goto error;
> +
> +	ret =3D spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
> +				EFI_VAR_BUF_SIZE, buf);
> +
> +	log_debug("%s - read buffer buf->length: %x\n", __func__, buf->length)=
;
> +
> +	if (ret || buf->length < sizeof(struct efi_var_file)) {
> +		log_err("%s - buffer read from SPI Flash isn't valid\n", __func__);
> +		goto error;
> +	}
> +
> +	ret =3D efi_var_restore(buf, false);
> +	if (ret !=3D EFI_SUCCESS)
> +		log_err("%s - Unable to restore EFI variables from buffer\n", __func_=
_);
> +
> +	ret =3D EFI_SUCCESS;
> +error:
> +	free(buf);
> +	return ret;
> +}

