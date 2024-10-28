Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B254CD1358C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 05:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD8388FA8;
	Mon, 28 Oct 2024 06:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HpK7TRgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02CD68901F; Mon, 28 Oct 2024 06:59:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA1C88F0A
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 06:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730095151; x=1730699951; i=xypron.glpk@gmx.de;
 bh=cwH+cx3SqFv9I4wNuZdznwrzb5SaoNcpLqdhAkqGyyw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HpK7TRgqddOFpwrmpS3dJGtje24Lp9TK69b4hzRtS4/J5amBY3JPXVXG2xFSxIRX
 dalhc5PVBNHVq+WfZDRh1xv5HSE/FBEJwJZ1Dw63C0nkXIckBRW0adBOV7IwUiwmm
 7+ldw76Rs6tOqMGs3MJrMr8CA9O4aNqPTMijS2mTlBPbWik606ajW6BoT4XLWiZtc
 mSeHWCO/70VOcAHp3vk0eJkilGnii+hgHAv+8qtgayZz49iXGnTKTGqZ8r5LWTh0V
 7eZUh2KIWPMx9TsRZmufFFKmMSp9Z+uKrKf8phH84wqs2uV61dJOHti+C5UEf5UrQ
 j8ceHpX0So/ALiCNrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1swnGS028d-002qjf; Mon, 28
 Oct 2024 06:59:11 +0100
Message-ID: <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
Date: Mon, 28 Oct 2024 06:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241022120032.196311-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w3hcdlk2cfNHuzZeC6vUoA5qqa2+T10/XPQ+MIf9QsHMU72JPgi
 QLGwub4VKP/mQ+X/8Z1pU/nCs/2Ir6wL+msmN1tIkoSt/OkXUWXZzMWp++aRUfve3uIPRWB
 cHBvHGtoc8YaL33MXSmZnfb53zJdCICj+K5AEaaOQQtmD/FTmWdl99aY9dqEYy941m1q5wV
 hL8odA+zkYerepJ1baGUA==
UI-OutboundReport: notjunk:1;M01:P0:8CmrI92+kpg=;RZKxAsK7gQjT/Zd1wEmPwc37Hnv
 alMLUJyrx+BHQ/uEltNL7PEX5HCqRP8bMFm8rVWbBlI3x6sbDwFyjYIN0XW0hixxAt4V+fkcP
 AUgcX0rJK72NiRoDe0quIlcxqhwNe2yQGkeoT8n62WW6CWbzYr1gKTqyKt3gRHJOcFVmPyn4S
 6Ni+VIAT6/QxnV/HctA/W9nJIJNf0h16KTEHmWbeyvzLU+Naj2GxNYw+YuY1yGcEUr0WLjETO
 9r/K8ZEOpSm8WDfE+EjJJzyHxY9qLW/OlRZeI6KMasKMmE+qWZ8UzggzQ4nwPFrSu7PKqLHem
 +E/f0BQIXRv1aY7v3PLRbF379gV8Yd5v3h0pabykCdk/2iTt317WND1uTssJZZRpUYl+OO/Y6
 XNqzIHUVNtah/HJnWT4qfHg/0MMG3VIACZ07auVl8o19gcn8XbCgn0W4EZpN2lC8eFxKi2RDX
 +S8JrNLIIGeAgFtKPhPaoNPvuY4/k0yW8AjcuEac9p/AQyhF1KLKJ5Zib096sMUChnZ/TLJbO
 Z0NQqNOVTSmP4vefihv6y+OYzf/71a7+u4uE29SCq2LPqPhuFAOCNkpfDI+Zy9xUSHC3RIkwV
 XF+4Rug1pMZT0n79bnckXBbQRZT6uiPysgZxZAr8YGmDAMpsSQilniVvA0FPhivdKrYycoJ83
 pAVuOuhd1oYKR9AtTDNz0IuBowQFXC4U72e4/KAzvsl2Gn/J0Svx5+tBYxujVgUsB0HWjBj4J
 UqExEqPf7lTyoCtdxZ23HcuhccQaXIvPm+sdrQL7HxhCuiAaebnd8P+KK7ZpoYYnwrh1AUXYF
 bLf9MYYwdeQBULjYNs3tCkHQ==
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

On 10/22/24 14:00, Simon Glass wrote:
> Add a simple app to use for testing. This is intended to do whatever it
> needs to for testing purposes. For now it just prints a message and
> exits boot services.
>
> There was a considerable amount of discussion about whether it is OK to
> call exit-boot-services and then return to U-Boot. This is not normally
> done in a real application, since exit-boot-services is used to
> completely disconnect from U-Boot. However, since this is a test, we
> need to check the results of running the app, so returning is necessary.
> It works correctly and it provides a nice model of how to test the EFI
> code in a simple way.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v7)
>
> Changes in v7:
> - Update commit message
>
>   lib/efi_loader/Kconfig   | 10 ++++++
>   lib/efi_loader/Makefile  |  1 +
>   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 79 insertions(+)
>   create mode 100644 lib/efi_loader/testapp.c
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 69b2c9360d8..6ced29da719 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
>   	  No additional space will be required in the resulting U-Boot binary
>   	  when this option is enabled.
>
> +config BOOTEFI_TESTAPP_COMPILE
> +	bool "Compile an EFI test app for testing"
> +	default y
> +	help
> +	  This compiles an app designed for testing. It is packed into an imag=
e
> +	  by the test.py testing frame in the setup_efi_image() function.
> +
> +	  No additional space will be required in the resulting U-Boot binary
> +	  when this option is enabled.
> +
>   endif
>
>   source "lib/efi/Kconfig"
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 00d18966f9e..87131ab911d 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) +=3D initrddump
>   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>   apps-y +=3D dtbdump
>   endif
> +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) +=3D testapp
>
>   obj-$(CONFIG_CMD_BOOTEFI_HELLO) +=3D helloworld_efi.o
>   obj-$(CONFIG_EFI_BOOTMGR) +=3D efi_bootmgr.o
> diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
> new file mode 100644
> index 00000000000..feb444c92e9
> --- /dev/null
> +++ b/lib/efi_loader/testapp.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0+

This is not a valid SPDX identifier. Please, use GPL-2.0-or-later.

> +/*
> + * Hello world EFI application
> + *
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + *
> + * This test program is used to test the invocation of an EFI applicati=
on.
> + * It writes a few messages to the console and then exits boot services
> + */
> +
> +#include <efi_api.h>
> +
> +static const efi_guid_t loaded_image_guid =3D EFI_LOADED_IMAGE_PROTOCOL=
_GUID;
> +
> +static struct efi_system_table *systable;
> +static struct efi_boot_services *boottime;
> +static struct efi_simple_text_output_protocol *con_out;
> +
> +/**
> + * efi_main() - entry point of the EFI application.
> + *
> + * @handle:	handle of the loaded image
> + * @systab:	system table
> + * Return:	status code
> + */
> +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> +			     struct efi_system_table *systab)
> +{
> +	struct efi_loaded_image *loaded_image;
> +	efi_status_t ret;
> +	efi_uintn_t map_size;
> +	efi_uintn_t map_key;
> +	efi_uintn_t desc_size;
> +	u32 desc_version;
> +
> +	systable =3D systab;
> +	boottime =3D systable->boottime;
> +	con_out =3D systable->con_out;
> +
> +	/* Get the loaded image protocol */
> +	ret =3D boottime->open_protocol(handle, &loaded_image_guid,
> +				      (void **)&loaded_image, NULL, NULL,
> +				      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +	if (ret !=3D EFI_SUCCESS) {
> +		con_out->output_string
> +			(con_out, u"Cannot open loaded image protocol\r\n");
> +		goto out;
> +	}
> +
> +	/* UEFI requires CR LF */
> +	con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n")=
;
> +
> +out:
> +	map_size =3D 0;
> +	ret =3D boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size=
,
> +				       &desc_version);
> +	con_out->output_string(con_out, u"Exiting boot sevices\n");

%s/sevices/services/g

> +
> +	/* exit boot services so that this part of U-Boot can be tested */
> +	boottime->exit_boot_services(handle, map_key);
> +
> +	/* now exit for real */
> +	ret =3D boottime->exit(handle, ret, 0, NULL);

As written before boot services are not available after
ExitBootServices(). Please, call the ResetSystem() service.


> +
> +	/* We should never arrive here */
> +	return ret;

After ExitBootServices() you must not return.

You can just do an endless loop if ResetSystem() fails:

for (;;);

Best regards

Heinrich

> +}

