Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2AED3399B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 16:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB0389098;
	Mon, 28 Oct 2024 17:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PZRl5QSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C304D89098; Mon, 28 Oct 2024 17:47:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E71F88D3A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 17:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730134035; x=1730738835; i=xypron.glpk@gmx.de;
 bh=KgSbIMUReaMp6JqYJHLeAWSmKSzi48f2Se3jig/VMOM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PZRl5QSa8uOwzgpU6UA0qERzjcOqqCJittkDkeyhD00gM8ipJ/OKcTt140QaTiYZ
 J4s9YtO5L/YULq0hLZnnNtTx2lH+TMJwqx8Dc1doyPjgYV+12WLYPv4IWICCxEd8/
 Vpp/hCKOV1HsecmbNuUYEcOR5Wqnt/9Yy8ze1sZAdLCCmBjkQHbW1XKNbmH4mX5KV
 9qVEoM2Aifwsts0z8+1BxFy4LGPpCO4YM87/fR0phP8qNNEXlipjKPdxRPY32E/7L
 s7f9LGy2EpGSwHz50hUhevbxj7nBRGaUO3EDwdQfpZO1kf+XqaZmfHZ3noh86vuzS
 x+hCxMc7S7qWoLS1Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.42] ([176.3.75.45]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvqW-1tcslw3ias-00gSuC; Mon, 28
 Oct 2024 17:47:15 +0100
Message-ID: <aff49443-ab1d-44a9-ad61-64dfa6114e37@gmx.de>
Date: Mon, 28 Oct 2024 17:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
 <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
 <20241028151738.GO4959@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241028151738.GO4959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:voQJ99kam8dSNcl65QloW0Un3/HpjC9KyxGnFeL+FaCuE/pEGlW
 FwOu7B2eibyh6fCNbf7g3x7Gm1I5ctvtq1ojGRfSWBbVKufg8wn8u5gQjfNZYxzDpfRM8e0
 nrvLineIMgdBNn8D5p6fjQaKwghlge0SCQr23jfrXuGc2fiwqiz0NXkBwu+JJUvpeXStdEV
 HvSs8PmgvB5LpM2e5pWfA==
UI-OutboundReport: notjunk:1;M01:P0:Oxp3zMWn9sg=;wwNxlZCiU7KmXkgZi8e0sikOP4h
 Ev14c+4jW9Oz4ahGI4N4pe6Z4ARA2fSqRVwN8W2jEWEfBQATj3rqCsbrJMFtKg/B0w0ikXHI0
 qUxHZTQ30sxzcH06IeGuGh3z6uzymO43c3AW/S0tgFs2RMMIs4zkhnuPY/xL2S6ZN8xU6CYy0
 7wbH6q61MtEsghMec/YfVx+DJNuiJgeisZ5TMOPfqP8DpwoWRcvQhp7MjdDQdAsN723J5QXfl
 3FogyeHU8EyR4uQ99DG9jNGXbuBt1lI4yGGzcEavECEExv0Been5prHu24Z5p2gPX8AIpkHAw
 3FOLWyjWbpbWS/R+2YbK4AbAn8jXPiFixa6tkzIuDa9R+FtHvekQT/wQ9fKFINXJP6lIux+0q
 1vxY9K8xldTr5fj162T2nL7fGh4GZ8lGXMAkTwO39jGOF1jNptAfVlV9LhF3OSdaYG3lf6TRx
 G1skd6U7qmuNtVLf01v6AcK6yRl6/7pgw9tD2Ks91AYbLYdSloIDShl3i7NK/+uhhqimL9+he
 TqqA/sTeZTUm8Yu3mMnIN3SxwbUfZQaF862Fz7YZJ2nsHqoM3qhWyjiKZ6p05t0GPSvuI9pGF
 GpMpfFArVtNAoVDvJTYk69949KBlzzvWrqEUDuF1/ON1mxIz8Z9ep9azvGLPip4AKagOWcHUt
 lxRBTIR2wnPZkIVfYvO9jX9pt7ZkOW5GOJ1MtKrCbyuFNvk6LCOlhc8M7KIicSzbQQWtvAsSv
 GNeggL0Qi4Ycrz8ZotExeVMfLtNKsuBISR7NhOt//c46eor62hK+4RUPshcf+RR8DIa4qhcrM
 zXhkFixeQ7/nD+mpmREmFwhQ==
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

On 10/28/24 16:17, Tom Rini wrote:
> On Mon, Oct 28, 2024 at 06:59:10AM +0100, Heinrich Schuchardt wrote:
>> On 10/22/24 14:00, Simon Glass wrote:
>>> Add a simple app to use for testing. This is intended to do whatever i=
t
>>> needs to for testing purposes. For now it just prints a message and
>>> exits boot services.
>>>
>>> There was a considerable amount of discussion about whether it is OK t=
o
>>> call exit-boot-services and then return to U-Boot. This is not normall=
y
>>> done in a real application, since exit-boot-services is used to
>>> completely disconnect from U-Boot. However, since this is a test, we
>>> need to check the results of running the app, so returning is necessar=
y.
>>> It works correctly and it provides a nice model of how to test the EFI
>>> code in a simple way.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> (no changes since v7)
>>>
>>> Changes in v7:
>>> - Update commit message
>>>
>>>    lib/efi_loader/Kconfig   | 10 ++++++
>>>    lib/efi_loader/Makefile  |  1 +
>>>    lib/efi_loader/testapp.c | 68 +++++++++++++++++++++++++++++++++++++=
+++
>>>    3 files changed, 79 insertions(+)
>>>    create mode 100644 lib/efi_loader/testapp.c
>>>
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index 69b2c9360d8..6ced29da719 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
>>>    	  No additional space will be required in the resulting U-Boot bin=
ary
>>>    	  when this option is enabled.
>>>
>>> +config BOOTEFI_TESTAPP_COMPILE
>>> +	bool "Compile an EFI test app for testing"
>>> +	default y
>>> +	help
>>> +	  This compiles an app designed for testing. It is packed into an im=
age
>>> +	  by the test.py testing frame in the setup_efi_image() function.
>>> +
>>> +	  No additional space will be required in the resulting U-Boot binar=
y
>>> +	  when this option is enabled.
>>> +
>>>    endif
>>>
>>>    source "lib/efi/Kconfig"
>>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>>> index 00d18966f9e..87131ab911d 100644
>>> --- a/lib/efi_loader/Makefile
>>> +++ b/lib/efi_loader/Makefile
>>> @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrddump
>>>    ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>>>    apps-y +=3D dtbdump
>>>    endif
>>> +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
>>>
>>>    obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
>>>    obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
>>> diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
>>> new file mode 100644
>>> index 00000000000..feb444c92e9
>>> --- /dev/null
>>> +++ b/lib/efi_loader/testapp.c
>>> @@ -0,0 +1,68 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>
>> This is not a valid SPDX identifier. Please, use GPL-2.0-or-later.
>
> We should switch to the proper one here, but there are numerous examples
> of this today.
>
>>> +/*
>>> + * Hello world EFI application
>>> + *
>>> + * Copyright 2024 Google LLC
>>> + * Written by Simon Glass <sjg@chromium.org>
>>> + *
>>> + * This test program is used to test the invocation of an EFI applica=
tion.
>>> + * It writes a few messages to the console and then exits boot servic=
es
>>> + */
>>> +
>>> +#include <efi_api.h>
>>> +
>>> +static const efi_guid_t loaded_image_guid =3D EFI_LOADED_IMAGE_PROTOC=
OL_GUID;
>>> +
>>> +static struct efi_system_table *systable;
>>> +static struct efi_boot_services *boottime;
>>> +static struct efi_simple_text_output_protocol *con_out;
>>> +
>>> +/**
>>> + * efi_main() - entry point of the EFI application.
>>> + *
>>> + * @handle:	handle of the loaded image
>>> + * @systab:	system table
>>> + * Return:	status code
>>> + */
>>> +efi_status_t EFIAPI efi_main(efi_handle_t handle,
>>> +			     struct efi_system_table *systab)
>>> +{
>>> +	struct efi_loaded_image *loaded_image;
>>> +	efi_status_t ret;
>>> +	efi_uintn_t map_size;
>>> +	efi_uintn_t map_key;
>>> +	efi_uintn_t desc_size;
>>> +	u32 desc_version;
>>> +
>>> +	systable =3D systab;
>>> +	boottime =3D systable->boottime;
>>> +	con_out =3D systable->con_out;
>>> +
>>> +	/* Get the loaded image protocol */
>>> +	ret =3D boottime->open_protocol(handle, &loaded_image_guid,
>>> +				      (void **)&loaded_image, NULL, NULL,
>>> +				      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>>> +	if (ret !=3D EFI_SUCCESS) {
>>> +		con_out->output_string
>>> +			(con_out, u"Cannot open loaded image protocol\r\n");
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* UEFI requires CR LF */
>>> +	con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n=
");
>>> +
>>> +out:
>>> +	map_size =3D 0;
>>> +	ret =3D boottime->get_memory_map(&map_size, NULL, &map_key, &desc_si=
ze,
>>> +				       &desc_version);
>>> +	con_out->output_string(con_out, u"Exiting boot sevices\n");
>>
>> %s/sevices/services/g
>>
>>> +
>>> +	/* exit boot services so that this part of U-Boot can be tested */
>>> +	boottime->exit_boot_services(handle, map_key);
>>> +
>>> +	/* now exit for real */
>>> +	ret =3D boottime->exit(handle, ret, 0, NULL);
>>
>> As written before boot services are not available after
>> ExitBootServices(). Please, call the ResetSystem() service.
>
> Right, but the point is to not do that and instead test what happens. I
> think Ilias had said we need to make some big loud print on console that
> you must reset the system for it to be usable afterwards, would that
> be enough?
>

There is no point in testing what happens as this call is not allowable.

Do we really need to zero out the bootservices table for people who do
not read the spec to find out the hard way?

Best regards

Heinrich
