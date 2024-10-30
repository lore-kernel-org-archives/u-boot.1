Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1362CD6B6B3
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBFE89206;
	Wed, 30 Oct 2024 17:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QvIFLd3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA0D089221; Wed, 30 Oct 2024 17:56:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE17A88C05
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730307358; x=1730912158; i=xypron.glpk@gmx.de;
 bh=o8OZw5kV+jGFhKSuIs2RYlfbTry9KWRASoMv+6JZqrI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QvIFLd3/KRlCV+HsjusyJxP5jBGfoOX2JAKxV2I5kMFqoFZc2wshT+aJ/bIFrrPI
 VRnkBLGdA+VZFQvfQI7P2OJD7Lwz3VITNW6BNt+J3e4nBPWs7uGPoxJnP8ZF0aUze
 KtHRFIEpSe3zpKAMjdqyV0KxOO2ThySW+ZAXmR6f9HSB7TPGMNPfz13Q58/2V2OwS
 B9JNWLz3fmqaMkvJrIwTSQMciDXcS3hyZdNMf2xJjQyZpWG4bp8ATlv1ytscZdKeZ
 wJGJUBu5VgRCuAWmzbWMfdgGGxSgcm+AJ2riVfKOwMryCImRwsBu+UDheiwJEMZWl
 l7y5ZjkXxvJHdA0/4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.150.8.169] ([145.103.114.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1t1V9x0md1-004PHS; Wed, 30
 Oct 2024 17:55:58 +0100
Message-ID: <28e1ac54-c813-4b3d-b301-1bd408f29e28@gmx.de>
Date: Wed, 30 Oct 2024 17:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/11] efi_loader: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241029192222.362445-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:su8/10I9IBNvkeCf3PeROWwWOq3BQvBCLYTsQgXUrvhtD4wCZ+3
 TQ/ZudVzvCwr5xLSrlb/ZaBikb3O55II6Ran9rLVR3KO9jpmCSwD4LBLv7Xw949NLKasxOU
 5JORISN9XdQGPqB+99hSFrQEMTKiohYkjWqKpYag7NyT25OeidsoMLDHANMRgWDsN2NmRKc
 /foJODrX7DQBL58tOVGjA==
UI-OutboundReport: notjunk:1;M01:P0:MrBMxtAUMMo=;AXLoE1cuNuBgSp2dVGcxgBcmGFd
 m79St4eZINVjvDWTUBm4+6DGY5bMRwJw/eqFH9QwdUl9PM47EgIXwfrqPRZqAvfdV+LmYrIFj
 DNIFH73I1n87DTR9Q3UrpjHYLaTsWwfr8iOlNNAXizqGCNFxT1tyXzQRnuy7VTuRbfj9alBJL
 MQkdSW+kgQYG0y7xzjqYYBwppzASynlOasbZ1zL+w8VBqfJqbFDGELGtN3XKg06pYZM8apxaR
 2DSom9PiZ3EIK2APIpgrOJ/zPKKxfRKp3+XsCqmRTk8gH3XCirJldbllVYIUok+auAetV3tAV
 tMEwZoe968dDv3wTS4D+OXTrYLlEeW3dbHLbd/Db2EDNSYSBZZzjcyO/RrBkTYWrn1Lf0ZKLE
 htCFz1CK5L97TUUWTq33j0ouh/wS7WgZBEzCnF5scaUI/h84ACKpZh8H4EFXrz54QVbjjduNL
 vAPXLszO4YhqJgxfmNxaQJAyqiGOIaOP7NVVBo3O8cM60wUP2oYSMFCOMm43OuQi0YIqY77i4
 6xaYcOdNeEw6wUddfxah8pQWPY+NodZDfgltAh5lcPCRP93svMoJ5MLb4XRXZMc0RhneZUsbn
 0sU8GkFuaDS/vxo/7pvWVy7gvpeh1w/DZNM1AAXY9G9DuNcgT1OOgj01NH1yRRmPPgdf+iLx3
 a8sehaHH1JXh722cJA5StTqLN80Knm58h6MRmXxXcCrUlow5i0BoDmCLyIjlG33458VfZVJae
 vg2wsN7Oxn72+ZD4qUYOPY34HtaZGWLPIVF6XeiL74xngHwronLqwu/SC1xkohnv6LyK+MELD
 kTDAcjE5vIaH5Me2c8vaSWiQ==
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

On 10/29/24 20:22, Simon Glass wrote:
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
> Changes in v9:
> - Update license
> - Fix 'sevices' typo
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
> index 37572c82f54..44319729bda 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -584,6 +584,16 @@ config BOOTEFI_HELLO_COMPILE
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
> index 8ec240cb864..7c8b2dd1ad6 100644
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
> index 00000000000..a28fc17ce5b
> --- /dev/null
> +++ b/lib/efi_loader/testapp.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
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
> +	con_out->output_string(con_out, u"Exiting boot services\n");
> +
> +	/* exit boot services so that this part of U-Boot can be tested */
> +	boottime->exit_boot_services(handle, map_key);

Hello Simon,

I am not NAKing this patch. But maybe you could rethink if this call
tells us anything new about the correct function of ExitBootServices().

We already have a test of ExitBootServices() in lib/efi_selftest/ and
maybe we should extend that test to check more.

By removing ExitBootServices() we could keep U-Boot in a well defined
state which will allow us to run any number of bootmeth tests in
sequence and keep the EFI sub-system in a consistent state.

Best regards

Heinrich


> +
> +	/* now exit for real */
> +	ret =3D boottime->exit(handle, ret, 0, NULL);
> +
> +	/* We should never arrive here */
> +	return ret;
> +}

