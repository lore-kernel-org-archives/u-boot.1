Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777D7FED2E4
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 08:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A7D83F6D;
	Thu, 12 Mar 2026 09:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MawhNrar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D0C783F9A; Thu, 12 Mar 2026 09:00:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A8583952
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 09:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773302443; x=1773907243; i=xypron.glpk@gmx.de;
 bh=EO/5pA9y9mOv6aJ+j+AlQIN2hf2IZ4d65CxGj5eNNts=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MawhNrarQF1+FfFwJvhfZPBcpfGkc6ecStbakWfx4ozW2gebkRFA3n1weCNrk0E9
 jGaFTB4gGywNjhaZ1VldxJc2vdLTvbKVv1M18K9tGsFKYUYJvKHCwCNad0XeUxKWb
 MvMotEim1fHlduVKdv9gIpg9gi9R3gGigKG+XRUMlyVXb9PsMONJ10OIA2wkdEwln
 xA4FYjSXdrMFKBMZKxsvu7rQVLgdRKl05dsP4QYZHSEg9GJCU0NCarzyd+S3XQwzj
 9kdXcN67zsHM68iY0Yame7DbzT9Xw8cHb1xd5tNo7f2E1jvKHEXCBEm6HmMkIWUaR
 8BkgjzfbcYn7/fcQVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1viVr72t86-00rDfP; Thu, 12
 Mar 2026 09:00:43 +0100
Message-ID: <d286fc0d-108d-4856-aafc-43122aa055e1@gmx.de>
Date: Thu, 12 Mar 2026 09:00:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>
Cc: Shantur Rathore <i@shantur.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
References: <f49e4ac8da5bae9252c79031f1661f386d17895f.1771247847.git.michal.simek@amd.com>
 <82aa8024-e80f-4db8-b0be-c8558c953c1b@gmx.de>
 <856a0d4d-4c5f-4028-ac0d-de279bd07c78@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <856a0d4d-4c5f-4028-ac0d-de279bd07c78@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+XzrBuWp1DrGKHm6Mzvd+45zNwQqrUs4VQqwNbAIrqXMXMM+b3j
 S6CTszlzdhi6LdZA0Z6S+KsVvPcefO1nefqb0vINoUJp1uzdCjjjpIWaiTvdJq15pi/NrgI
 mATLltrqUPBORGCCaG19pa/PxGK479rE/YnAo8lSK8EI4aRq5SY8KloWk80xHsHi1xSPMkP
 GHTYLR/CuiabmYcCKLmMA==
UI-OutboundReport: notjunk:1;M01:P0:fpTot0NfC/0=;DCDjtUTxUcaqZLSXsWf5pzu7dEH
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

On 3/11/26 17:26, Michal Simek wrote:
>=20
>=20
> On 3/11/26 16:08, Heinrich Schuchardt wrote:
>> On 2/16/26 14:17, Michal Simek wrote:
>>> From: Shantur Rathore <i@shantur.com>
>>>
>>> Currently U-Boot uses ESP as storage for EFI variables.
>>> Devices with SPI Flash are used for storing environment with this
>>> commit we allow EFI variables to be stored on SPI Flash.
>>>
>>> Signed-off-by: Shantur Rathore <i@shantur.com>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-=
CC
>>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>
>>> ---
>>>
>>> Changes in v9:
>>> - Remove EFI_RT_VOLATILE_STORE enabling
>>> - Cleanup commit message
>>>
>>> Changes in v8:
>>> - Add missing EFI_VARIABLE_SF_STORE dependency to=20
>>> EFI_VARIABLE_SF_DEVICE_INDEX
>>>
>>> Changes in v7:
>>> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>>>
>>> Changes in v6:
>>> - sed -i 's/efi_var_read/efi_var_from/g'
>>> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>>>
>>> Changes in v4:
>>> - Extend Kconfig description
>>> - Extend commit message and describe efivar missing part
>>> - use unify methods for reading/writing variable
>>>
>>> Changes in v3:
>>> - Fixed compiler warnings.
>>>
>>> Changes in v2:
>>> - Refactored efi_var_file to move common parts out as requested
>>> - Changed ifdefs to use CONFIG_IS_DEFINED
>>> - Fixed typos
>>>
>>> =C2=A0 lib/efi_loader/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +++++=
++++++++
>>> =C2=A0 lib/efi_loader/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 lib/efi_loader/efi_var_sf.c | 92 ++++++++++++++++++++++++++++++=
+++++++
>>> =C2=A0 3 files changed, 126 insertions(+)
>>> =C2=A0 create mode 100644 lib/efi_loader/efi_var_sf.c
>>>
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index 579eed658801..315dd4f3e794 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select this option if you w=
ant non-volatile UEFI variables to be
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stored as file /ubootefi.va=
r on the EFI system partition.
>>> +config EFI_VARIABLE_SF_STORE
>>> +=C2=A0=C2=A0=C2=A0 bool "Store non-volatile UEFI variables in SPI Fla=
sh"
>>> +=C2=A0=C2=A0=C2=A0 depends on SPI_FLASH
>>> +=C2=A0=C2=A0=C2=A0 help
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select this option if you want non-vol=
atile UEFI variables to be
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stored in SPI Flash.
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Define CONFIG_EFI_VARIABLE_SF_OFFSET a=
s offset in SPI Flash to=20
>>> use as
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the storage for variables. CONFIG_EFI_=
VAR_BUF_SIZE defines the=20
>>> space
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 needed.
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note that SPI Flash devices have a lim=
ited number of program/=20
>>> erase
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cycles. Frequent updates to UEFI varia=
bles may cause excessive=20
>>> wear
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and can permanently damage the flash d=
evice, particularly on=20
>>> SPI NAND
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or low-end SPI NOR parts without wear =
leveling. This option=20
>>> should be
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used with care on such systems, and is=
 not recommended for=20
>>> platforms
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where UEFI variables are updated frequ=
ently.
>>> +
>>> =C2=A0 config EFI_MM_COMM_TEE
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "UEFI variables storage service vi=
a the trusted world"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on OPTEE
>>> @@ -194,6 +212,21 @@ config FFA_SHARED_MM_BUF_ADDR
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the MM SP in secure world.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It is assumed that the MM S=
P knows the address of the shared=20
>>> MM communication buffer.
>>> +config EFI_VARIABLE_SF_OFFSET
>>> +=C2=A0=C2=A0=C2=A0 hex "EFI variables in SPI flash offset"
>>> +=C2=A0=C2=A0=C2=A0 depends on EFI_VARIABLE_SF_STORE
>>> +=C2=A0=C2=A0=C2=A0 help
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Offset from the start of the SPI Flash=
 where EFI variables=20
>>> will be stored.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This should be aligned to the sector s=
ize of SPI Flash.
>>> +
>>> +config EFI_VARIABLE_SF_DEVICE_INDEX
>>> +=C2=A0=C2=A0=C2=A0 int "Device Index for target SPI Flash"
>>> +=C2=A0=C2=A0=C2=A0 depends on EFI_VARIABLE_SF_STORE
>>> +=C2=A0=C2=A0=C2=A0 default 0
>>> +=C2=A0=C2=A0=C2=A0 help
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The index of SPI Flash device used for=
 storing EFI variables.=20
>>> This would be
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 needed if there are more than 1 SPI Fl=
ash devices available to=20
>>> use.
>>> +
>>> =C2=A0 config EFI_VARIABLES_PRESEED
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Initial values for UEFI variables=
"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on !COMPILE_TEST
>>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>>> index ca1775eb03be..d73ad43951b1 100644
>>> --- a/lib/efi_loader/Makefile
>>> +++ b/lib/efi_loader/Makefile
>>> @@ -54,6 +54,7 @@ obj-y +=3D efi_variable_tee.o
>>> =C2=A0 else
>>> =C2=A0 obj-y +=3D efi_variable.o
>>> =C2=A0 obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) +=3D efi_var_file.o
>>> +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) +=3D efi_var_sf.o
>>> =C2=A0 obj-$(CONFIG_EFI_VARIABLES_PRESEED) +=3D efi_var_seed.o
>>> =C2=A0 endif
>>> =C2=A0 obj-y +=3D efi_watchdog.o
>>> diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
>>> new file mode 100644
>>> index 000000000000..61d68f7c5c94
>>> --- /dev/null
>>> +++ b/lib/efi_loader/efi_var_sf.c
>>> @@ -0,0 +1,92 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * SPI Flash interface for UEFI variables
>>> + *
>>> + * Copyright (c) 2023, Shantur Rathore
>>> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
>>> + */
>>> +
>>> +#define LOG_CATEGORY LOGC_EFI
>>> +
>>> +#include <efi_loader.h>
>>> +#include <efi_variable.h>
>>> +#include <spi_flash.h>
>>> +#include <dm.h>
>>> +
>>> +efi_status_t efi_var_to_storage(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 efi_status_t ret;
>>> +=C2=A0=C2=A0=C2=A0 struct efi_var_file *buf;
>>> +=C2=A0=C2=A0=C2=A0 loff_t len;
>>> +=C2=A0=C2=A0=C2=A0 struct udevice *sfdev;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D efi_var_collect(&buf, &len, EFI_VARIABLE_N=
ON_VOLATILE);
>>> +=C2=A0=C2=A0=C2=A0 if (len > EFI_VAR_BUF_SIZE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err("EFI var buffer le=
ngth more than target SPI Flash=20
>>> size");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D EFI_OUT_OF_RESOURC=
ES;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 log_debug("%s - Got buffer to write buf->len : %d\=
n", __func__,=20
>>> buf- >length);
>>
>> Hello Michal,
>>
>> Thank you for driving this.
>>
>> The log system is configurable to print file, line, function name if=20
>> wanted. We should not duplicate this here. Please, remove __func__=20
>> throughout the patch.
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (ret !=3D EFI_SUCCESS)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D uclass_get_device(UCLASS_SPI_FLASH,=20
>>> CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>
>> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIA=
BLE_SF_OFFSET,=20
>>> EFI_VAR_BUF_SIZE);
>>> +=C2=A0=C2=A0=C2=A0 log_debug("%s - Erased SPI Flash offset %x\n", __f=
unc__,=20
>>> CONFIG_EFI_VARIABLE_SF_OFFSET);
>>
>> A debug output if erasing failed would be more interesting.
>>
>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>
>> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D spi_flash_write_dm(sfdev, CONFIG_EFI_VARIA=
BLE_SF_OFFSET,=20
>>> len, buf);
>>> +=C2=A0=C2=A0=C2=A0 log_debug("%s - Wrote buffer to SPI Flash : %ld\n"=
, __func__, ret);
>>
>> The uclass_get_device() return code should be saved in an int variable=
=20
>> to avoid confusion.
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>
>> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D EFI_SUCCESS;
>>> +error:
>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err("Failed to persist=
 EFI variables in SF\n");
>>> +=C2=A0=C2=A0=C2=A0 free(buf);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>> +efi_status_t efi_var_from_storage(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct efi_var_file *buf;
>>> +=C2=A0=C2=A0=C2=A0 efi_status_t ret;
>>> +=C2=A0=C2=A0=C2=A0 struct udevice *sfdev;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 buf =3D calloc(1, EFI_VAR_BUF_SIZE);
>>> +=C2=A0=C2=A0=C2=A0 if (!buf) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err("%s - Unable to al=
locate buffer\n", __func__);
>>
>> This function may be called from an EFI GUI application. We should not=
=20
>> output any strings to the console from API functions. It is task of=20
>> the caller to take appropriate actions. E.g. show a pop-up if a=20
>> failure occurs. log_debug() is ok.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EFI_OUT_OF_RESOURCE=
S;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D uclass_get_device(UCLASS_SPI_FLASH, 0, &sf=
dev);
>>
>> efi_var_restore() returns a signed int and not an unsigned=20
>> efi_status_t. Please, define a separate variable.
>>
>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>
>> Please, return EFI_DEVICE_ERROR.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D spi_flash_read_dm(sfdev, CONFIG_EFI_VARIAB=
LE_SF_OFFSET,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 EFI_VAR_BUF_SIZE, buf);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 log_debug("%s - read buffer buf->length: %x\n", __=
func__, buf-=20
>>> >length);
>>
>> If spi_flash_read_dm() failed, you will just print some random value=20
>> for buf- =C2=A0>length. Please, print the return value instead.
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (ret || buf->length < sizeof(struct efi_var_fil=
e)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_err("%s - buffer read =
from SPI Flash isn't valid\n",=20
>>> __func__);
>>
>> If spi_flash_read_dm() fails we should return EFI_DEVICE_ERROR.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>
>> After erasing the SPI flash buf->length will be zero here. This should=
=20
>> not stop us from setting EFI variables.
>>
>> It is the task of efi_var_restore to check the validity of the buffer.=
=20
>> So the length check here should be removed.
>>
>> The missing check in efi_var_restore() is
>>
>> buf->length <=3D EFI_VAR_BUF_SIZE
>>
>> to avoid a buffer overrun when calculating the CRC32.
>=20
> I am not sure I understand this part.
> Where exactly should be this check?
>=20
> Thanks,
> Michal

See this patch:

https://lore.kernel.org/u-boot/20260311173033.10002-1-heinrich.schuchardt@=
canonical.com/T/#u

Best regards

Heinrich
