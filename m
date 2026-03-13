Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA14105F7AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163F284309;
	Fri, 13 Mar 2026 15:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DHzgSb12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3098B84314; Fri, 13 Mar 2026 15:13:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADEF484308
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 15:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773411184; x=1774015984; i=xypron.glpk@gmx.de;
 bh=XhJxgJrsqmohAvNb+beLUSs5cTjgB+Z0GSWhum0Iedg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DHzgSb12hGkymzDb4wMqDCv5MaLbmpm4DAt5LVRVXzr6yDPiq0XaL3k5VkLzb50x
 7xBWIbNA64Ns0ta5UWGJHl7zcInCstf07vwZkSqxnJynzWcVOJSVwJepffIftwjuG
 jokr1vlkDUpRY/hlCNcnlfs90YfK/N6w88S3Q2aMkDyt1qOLw5o92KUON9uBCtMtc
 u6MghTrYPhHv46TvdEgzIcgzPva1D/BkfCpZix6bgYZhRJxwBqai2LlmRi8lnoHcz
 C4ltkuyQJSu5ZFkm0wvCQnm9RmFI90peA3Mkr3QIfk8eYBWNGkcsAkE6evtZcSZH0
 zQKfTzsGyUSs6HFz6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1vPUaN0YTH-00clwC; Fri, 13
 Mar 2026 15:13:04 +0100
Message-ID: <53839b34-f44e-43fe-bd43-e39635ee050f@gmx.de>
Date: Fri, 13 Mar 2026 15:12:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>
Cc: Shantur Rathore <i@shantur.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>, u-boot@lists.denx.de, git@amd.com
References: <1e8eb1c27210e3beb5d3f4402a40d2e8886bcf9f.1773304671.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <1e8eb1c27210e3beb5d3f4402a40d2e8886bcf9f.1773304671.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cp6k2KsK2IfGO6yvX85tATHucHs1UEBKsLIa3jE/5SOXRA11Vfu
 OOv8U9notncvizD1lJYeeyuN3HNcqhuzxqf5j2uTwsdHvxATJ33eHjjBiMxzmKywjm9qYay
 A8m0Dt0g5ylyZzGku10CKbwJAq7ynlh+YgbfrGhwA0R/NNGZgmoYE1+playwqoyiyoDhUJD
 4objOzlDDLmPX88vZDdTA==
UI-OutboundReport: notjunk:1;M01:P0:zzSIfcW5V5E=;6KZN/Fc9slj1cV95C014SyWoPYp
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

On 3/12/26 09:37, Michal Simek wrote:
> From: Shantur Rathore <i@shantur.com>
>=20
> Currently U-Boot uses ESP as storage for EFI variables.
> Devices with SPI Flash are used for storing environment with this
> commit we allow EFI variables to be stored on SPI Flash.
>=20
> Signed-off-by: Shantur Rathore <i@shantur.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>=20
> Changes in v10:
> - Clean log messages
> - separate return variables
> - Fix return value
> - Move length check to efi_var_restore()
>=20
> Changes in v9:
> - Remove EFI_RT_VOLATILE_STORE enabling
> - Cleanup commit message
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
> The patch depends on https://lore.kernel.org/u-boot/20260311173033.10002=
-1-heinrich.schuchardt@canonical.com
>=20
> ---
>   lib/efi_loader/Kconfig      |  33 ++++++++++++
>   lib/efi_loader/Makefile     |   1 +
>   lib/efi_loader/efi_var_sf.c | 105 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 139 insertions(+)
>   create mode 100644 lib/efi_loader/efi_var_sf.c
>=20
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 579eed658801..315dd4f3e794 100644
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
> index 000000000000..c0755c67cda9
> --- /dev/null
> +++ b/lib/efi_loader/efi_var_sf.c
> @@ -0,0 +1,105 @@
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
> +	struct efi_var_file *buf;
> +	struct udevice *sfdev;
> +	efi_status_t ret;
> +	loff_t len;
> +	int r;
> +
> +	ret =3D efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto error;
> +
> +	if (len > EFI_VAR_BUF_SIZE) {
> +		log_err("EFI var buffer length more than target SPI Flash size\n");

This function may be called by EFI applications. We should avoid console=
=20
output here. Let the EFI application write a message.

log_debug() is ok.

> +		ret =3D EFI_OUT_OF_RESOURCES;
> +		goto error;
> +	}
> +
> +	log_debug("Got buffer to write buf->len: %d\n", buf->length);
> +
> +	r =3D uclass_get_device(UCLASS_SPI_FLASH,
> +			      CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
> +	if (r) {
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto error;
> +	}
> +
> +	r =3D spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
> +			       EFI_VAR_BUF_SIZE);

We could use the buf->length rounded up to full sectors here to avoid=20
unnecessary SPI flash wear.

> +	if (r) {
> +		log_debug("Failed to erase SPI Flash at offset %x\n",

The offset is already written in spi_flash_erase_dm() by calling log_ret()=
.

> +			  CONFIG_EFI_VARIABLE_SF_OFFSET);
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto error;
> +	}
> +
> +	r =3D spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, bu=
f);
> +	if (r) {
> +		log_debug("Failed to write to SPI Flash: %d\n", r);
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto error;

This goto could be removed. But that is a matter of taste.

> +	}
> +
> +error:
> +	if (ret !=3D EFI_SUCCESS)
> +		log_err("Failed to persist EFI variables in SF\n");

We already created debug messages above and inside an API we don't want=20
to write to the console.

> +	free(buf);
> +	return ret;
> +}
> +
> +efi_status_t efi_var_from_storage(void)
> +{
> +	struct efi_var_file *buf;
> +	struct udevice *sfdev;
> +	efi_status_t ret;
> +	int r;
> +
> +	buf =3D calloc(1, EFI_VAR_BUF_SIZE);
> +	if (!buf) {
> +		log_debug("Unable to allocate buffer\n");
> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	r =3D uclass_get_device(UCLASS_SPI_FLASH,
> +			      CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
> +	if (r) {
> +		log_debug("Failed to get SPI Flash device: %d\n", r);
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto error;
> +	}
> +
> +	r =3D spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
> +			      EFI_VAR_BUF_SIZE, buf);
> +	if (r) {
> +		log_debug("Failed to read from SPI Flash: %d\n", r);
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto error;
> +	}
> +
> +	if (efi_var_restore(buf, false) !=3D EFI_SUCCESS) {
> +		log_debug("No valid EFI variables in SPI Flash\n");
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto error;
> +	}
> +
> +	ret =3D EFI_SUCCESS;
> +error:

This function is called when initializing the UEFI sub-system. log_err()=
=20
would be ok here.

Best regards

Heinrich

> +	free(buf);
> +	return ret;
> +}

