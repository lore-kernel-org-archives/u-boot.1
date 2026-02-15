Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706D9E63F08
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 21:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E39E80B98;
	Sun, 15 Feb 2026 22:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jd3jUFnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 382F980B98; Sun, 15 Feb 2026 22:55:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35788063E
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 22:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771192534; x=1771797334; i=xypron.glpk@gmx.de;
 bh=6Z6NWkVgK7isVyMuZBVx+j77DZODfZqRD7IhFM9rydk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jd3jUFnB5k3DzBDdU+brW7mC7L2K/3YCC8+Q4zUi6hKQf+2mMu8fqntS73uIymVY
 0nlBXUmaq4agdC1DpafizFhYCTJI2ouc10UF7yC3nkOQOTodgHkWNrh8lTNzF/oLX
 zN/IxywiM6fdSPKnQui2i67jbYQ42jS3Wpr6jTI4CPxjHQcjm0PeNFbhSs1c3HG1J
 hcvEoknz3ZlDZwEi4K0eF+JaFS9yrR7wexcKdXxWJSx29YChbYeu1Ty1MiT9ERX43
 vR6kiffm3KJMbhc8Ske8CLIA8CAJ97INxbIWnFI74r4mirhTn6Ubj5+sd75M/zhMM
 bJxE8KYdyD1q8+NPGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3He-1vyOzt40xE-004wWN; Sun, 15
 Feb 2026 22:55:34 +0100
Date: Sun, 15 Feb 2026 22:55:30 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Michal Simek <michal.simek@amd.com>,
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Shantur Rathore <i@shantur.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v8 4/4] efi_vars: Implement SPI Flash store
User-Agent: Thunderbird for Android
In-Reply-To: <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
References: <cover.1770825377.git.michal.simek@amd.com>
 <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
 <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
Message-ID: <D64DEF29-9D57-4D9F-8BE8-331F3E940980@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P9i2/73R/pCKU1boDCLuLPnU8clbBdEWVTW+hteM47Io1eWGxtw
 sqD7A4SjMCP5oRUvfF5KdgO1d8Ff1Vihptb41lWvJ1IkGhsfDORyppgTjK8GEUcGBKhUiUZ
 mYXpoS/9kmYYF9s9Rpm7OANHOqHgQI9hWdevwNgcxcXU9fc4SJciJAw5879jL5mT99DXA6h
 N9zvrTzpJ/CVYgd4ZnJvA==
UI-OutboundReport: notjunk:1;M01:P0:/xsNstP/XPg=;E4XKlR3yQWk7FrTOE/fltldluv4
 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
 HtXhZ92DQOOXcibDb/Ln
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

Am 15=2E Februar 2026 09:48:39 MEZ schrieb Heinrich Schuchardt <xypron=2Egl=
pk@gmx=2Ede>:
>On 2/11/26 16:56, Michal Simek wrote:
>> From: Shantur Rathore <i@shantur=2Ecom>
>>=20
>> Currently U-Boot uses ESP as storage for EFI variables=2E
>> Devices with SPI Flash are used for storing environment with this
>> commit we allow EFI variables to be stored on SPI Flash=2E
>>=20
>> https://github=2Ecom/rhboot/efivar
>> is not updated to support this location that's why you can mimic it by
>> running:
>> dd if=3D/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e=
818c3130c \
>>     of=3D/tmp/vars skip=3D4 bs=3D1
>> flashcp /tmp/vars /dev/mtdX
>>=20
>> where mtdX should match location defined by
>> CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE=2E
>>=20
>> Signed-off-by: Shantur Rathore <i@shantur=2Ecom>
>> Signed-off-by: Michal Simek <michal=2Esimek@amd=2Ecom>
>> Tested-by: Neil Armstrong <neil=2Earmstrong@linaro=2Eorg> # on AML-S905=
D3-CC
>> Acked-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>>=20
>> ---
>>=20
>> Changes in v8:
>> - Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVIC=
E_INDEX
>>=20
>> Changes in v7:
>> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>>=20
>> Changes in v6:
>> - sed -i 's/efi_var_read/efi_var_from/g'
>> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>>=20
>> Changes in v4:
>> - Extend Kconfig description
>> - Extend commit message and describe efivar missing part
>> - use unify methods for reading/writing variable
>>=20
>> Changes in v3:
>> - Fixed compiler warnings=2E
>>=20
>> Changes in v2:
>> - Refactored efi_var_file to move common parts out as requested
>> - Changed ifdefs to use CONFIG_IS_DEFINED
>> - Fixed typos
>>=20
>>   lib/efi_loader/Kconfig      | 35 +++++++++++++-
>>   lib/efi_loader/Makefile     |  1 +
>>   lib/efi_loader/efi_var_sf=2Ec | 92 ++++++++++++++++++++++++++++++++++=
+++
>>   3 files changed, 127 insertions(+), 1 deletion(-)
>>   create mode 100644 lib/efi_loader/efi_var_sf=2Ec
>>=20
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 579eed658801=2E=2E0f6f927ddaf1 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
>>   	  Select this option if you want non-volatile UEFI variables to be
>>   	  stored as file /ubootefi=2Evar on the EFI system partition=2E
>>   +config EFI_VARIABLE_SF_STORE
>> +	bool "Store non-volatile UEFI variables in SPI Flash"
>> +	depends on SPI_FLASH
>> +	help
>> +	  Select this option if you want non-volatile UEFI variables to be
>> +	  stored in SPI Flash=2E
>> +
>> +	  Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use =
as
>> +	  the storage for variables=2E CONFIG_EFI_VAR_BUF_SIZE defines the sp=
ace
>> +	  needed=2E
>> +
>> +	  Note that SPI Flash devices have a limited number of program/erase
>> +	  cycles=2E Frequent updates to UEFI variables may cause excessive we=
ar
>> +	  and can permanently damage the flash device, particularly on SPI NA=
ND
>> +	  or low-end SPI NOR parts without wear leveling=2E This option shoul=
d be
>> +	  used with care on such systems, and is not recommended for platform=
s
>> +	  where UEFI variables are updated frequently=2E
>> +
>>   config EFI_MM_COMM_TEE
>>   	bool "UEFI variables storage service via the trusted world"
>>   	depends on OPTEE
>> @@ -153,7 +171,7 @@ endchoice
>>     config EFI_RT_VOLATILE_STORE
>>   	bool "Allow variable runtime services in volatile storage (e=2Eg RAM=
)"
>> -	depends on EFI_VARIABLE_FILE_STORE
>> +	depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
>
>Hello Michal,
>
>If the backend store is SPI flash, we should not publish the variable "RT=
StorageVolatile" at runtime as currently defined=2E
>
>For the background see this commit for the efivar library:
>
>https://github=2Ecom/rhboot/efivar/commit/68daa04654acbe1bbaa17ebfc23c371=
b39e69c6b
>
>The first three patches look correct to me and I will add them to a merge=
 request for efi-next=2E

The 3 prerequisite patches are now in origin/next=2E Just this one left to=
 be reworked=2E

Best regards

Heinrich


>
>The usage of efi_var_mem_ins() and efi_var_mem_del() when SetVariable() d=
oes not change anything is not flash-friendly=2E Michal, do you want to hav=
e a look at this area?
>
>@Ilias, @Vincent:
>We currently lack documentation for the 3 variables=2E
>Would it make sense to add the definition of the variables to chapter sou=
rce/chapter5-variable-storage=2Erst=2E
>
>Would an efivar helper for SPI flash make sense?
>How should RTStorageVolatile describe a SPI flash location?
>
>Best regards
>
>Heinrich
>
>>   	help
>>   	  When EFI variables are stored on file we don't allow SetVariableRT=
,
>>   	  since the OS doesn't know how to write that file=2E At the same ti=
me
>> @@ -194,6 +212,21 @@ config FFA_SHARED_MM_BUF_ADDR
>>   	  the MM SP in secure world=2E
>>   	  It is assumed that the MM SP knows the address of the shared MM co=
mmunication buffer=2E
>>   +config EFI_VARIABLE_SF_OFFSET
>> +	hex "EFI variables in SPI flash offset"
>> +	depends on EFI_VARIABLE_SF_STORE
>> +	help
>> +	  Offset from the start of the SPI Flash where EFI variables will be =
stored=2E
>> +	  This should be aligned to the sector size of SPI Flash=2E
>> +
>> +config EFI_VARIABLE_SF_DEVICE_INDEX
>> +	int "Device Index for target SPI Flash"
>> +	depends on EFI_VARIABLE_SF_STORE
>> +	default 0
>> +	help
>> +	  The index of SPI Flash device used for storing EFI variables=2E Thi=
s would be
>> +	  needed if there are more than 1 SPI Flash devices available to use=
=2E
>> +
>>   config EFI_VARIABLES_PRESEED
>>   	bool "Initial values for UEFI variables"
>>   	depends on !COMPILE_TEST
>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> index ca1775eb03be=2E=2Ed73ad43951b1 100644
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -54,6 +54,7 @@ obj-y +=3D efi_variable_tee=2Eo
>>   else
>>   obj-y +=3D efi_variable=2Eo
>>   obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) +=3D efi_var_file=2Eo
>> +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) +=3D efi_var_sf=2Eo
>>   obj-$(CONFIG_EFI_VARIABLES_PRESEED) +=3D efi_var_seed=2Eo
>>   endif
>>   obj-y +=3D efi_watchdog=2Eo
>> diff --git a/lib/efi_loader/efi_var_sf=2Ec b/lib/efi_loader/efi_var_sf=
=2Ec
>> new file mode 100644
>> index 000000000000=2E=2E61d68f7c5c94
>> --- /dev/null
>> +++ b/lib/efi_loader/efi_var_sf=2Ec
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2=2E0+
>> +/*
>> + * SPI Flash interface for UEFI variables
>> + *
>> + * Copyright (c) 2023, Shantur Rathore
>> + * Copyright (C) 2026, Advanced Micro Devices, Inc=2E
>> + */
>> +
>> +#define LOG_CATEGORY LOGC_EFI
>> +
>> +#include <efi_loader=2Eh>
>> +#include <efi_variable=2Eh>
>> +#include <spi_flash=2Eh>
>> +#include <dm=2Eh>
>> +
>> +efi_status_t efi_var_to_storage(void)
>> +{
>> +	efi_status_t ret;
>> +	struct efi_var_file *buf;
>> +	loff_t len;
>> +	struct udevice *sfdev;
>> +
>> +	ret =3D efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
>> +	if (len > EFI_VAR_BUF_SIZE) {
>> +		log_err("EFI var buffer length more than target SPI Flash size");
>> +		ret =3D EFI_OUT_OF_RESOURCES;
>> +		goto error;
>> +	}
>> +
>> +	log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->=
length);
>> +
>> +	if (ret !=3D EFI_SUCCESS)
>> +		goto error;
>> +
>> +	ret =3D uclass_get_device(UCLASS_SPI_FLASH, CONFIG_EFI_VARIABLE_SF_DE=
VICE_INDEX, &sfdev);
>> +	if (ret)
>> +		goto error;
>> +
>> +	ret =3D spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_=
VAR_BUF_SIZE);
>> +	log_debug("%s - Erased SPI Flash offset %x\n", __func__, CONFIG_EFI_V=
ARIABLE_SF_OFFSET);
>> +	if (ret)
>> +		goto error;
>> +
>> +	ret =3D spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len,=
 buf);
>> +	log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
>> +
>> +	if (ret)
>> +		goto error;
>> +
>> +	ret =3D EFI_SUCCESS;
>> +error:
>> +	if (ret)
>> +		log_err("Failed to persist EFI variables in SF\n");
>> +	free(buf);
>> +	return ret;
>> +}
>> +
>> +efi_status_t efi_var_from_storage(void)
>> +{
>> +	struct efi_var_file *buf;
>> +	efi_status_t ret;
>> +	struct udevice *sfdev;
>> +
>> +	buf =3D calloc(1, EFI_VAR_BUF_SIZE);
>> +	if (!buf) {
>> +		log_err("%s - Unable to allocate buffer\n", __func__);
>> +		return EFI_OUT_OF_RESOURCES;
>> +	}
>> +
>> +	ret =3D uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
>> +	if (ret)
>> +		goto error;
>> +
>> +	ret =3D spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
>> +				EFI_VAR_BUF_SIZE, buf);
>> +
>> +	log_debug("%s - read buffer buf->length: %x\n", __func__, buf->length=
);
>> +
>> +	if (ret || buf->length < sizeof(struct efi_var_file)) {
>> +		log_err("%s - buffer read from SPI Flash isn't valid\n", __func__);
>> +		goto error;
>> +	}
>> +
>> +	ret =3D efi_var_restore(buf, false);
>> +	if (ret !=3D EFI_SUCCESS)
>> +		log_err("%s - Unable to restore EFI variables from buffer\n", __func=
__);
>> +
>> +	ret =3D EFI_SUCCESS;
>> +error:
>> +	free(buf);
>> +	return ret;
>> +}
>

