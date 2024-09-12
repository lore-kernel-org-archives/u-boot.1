Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D3EED60D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 14:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7600B88EA3;
	Thu, 12 Sep 2024 16:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PozogxrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F206B88FEC; Thu, 12 Sep 2024 16:48:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F406F88E04
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 16:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726152496; x=1726757296; i=xypron.glpk@gmx.de;
 bh=15LG0yq8YB5DG4FxXShkUHyCm5miz5svW/E7dobmNGY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PozogxrDEjve0Qk3tbIzR1VxNJ0pmPTTVARIatxW0sm3iFckLmPqZdAJWgsXuox+
 JLOVaqXe8mugYcVJNDDeT+C5rGwrEBQPTV1ZgS+P8QgEGzb7mDw6CeLZmHgposPPS
 Iq37e/Utdf8D7uRxJXVUbh14Z7QXbMualpi9QAdaR4AmNwbs/2dfK30z6AI8MMAT3
 L5lDv8QuFvcEgx1Php9qO/WHFu8x4Ec2qeJE/ehO4I970QBNPhdKzjoX0g7xAMLr8
 HbF2GtIXx/eiHFoU7htMVte3gimKWvjSXc7S30NdwaW7hA5AVjTeyeqRSvN3yZ06y
 3SnfXposq7QaZ4xIWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKFk-1sfNBK1m9y-0038sK; Thu, 12
 Sep 2024 16:48:16 +0200
Message-ID: <fa819278-d099-49c4-ad87-5e97fc31e955@gmx.de>
Date: Thu, 12 Sep 2024 16:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/14] efi_loader: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-12-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240902011825.746421-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8pWB9rcMQDqr/6/RbCqQE7QYkfoXbJGnpGIhIJlp2Iu+6Me0hH4
 0B9dY7wGFBRYiNbflV6TOZBb+Z/NuDNJLdoz7oaAv8ENgvNmF9f5m5igtlwZhyP1C4Hfqt2
 c2cKne2rI+xrMB5l1I3Nx0iT1X45yPI72PwA6Npxoz846K53uswMxNvdcrWjCj1pDDTAWdM
 ebm6XJ/3LS+GTvlsrhnkA==
UI-OutboundReport: notjunk:1;M01:P0:e+Fvgc8V/5E=;wotj4JtwXjFuD5oSUYDemYipokC
 1t6jvR+tq4QpskYS0hJYqm06fynn5ojht5OhvMXWV4fmJv5BYgzfWmhLAUSyaY2ftOA2Guzto
 7fBpeZ226qsKH7Pk3QS1go8QI65EoxhEeod3nj2EiJiT5k7ndlLaPzY6JhkUYE5aV43nQJzlT
 +OotFSng9ArHhoDNLN8bjxQnkz3dU1EfpaBkKhbKxsX+k1M8e6x7P3MKWuBgIv5Gvl9bR10v7
 Os4+l27ASGRXhgcXwqAk1cT+fmM9ujMWyY4XudOSdNb58oHIN22E+X9v+77CjWD1Zchqlmr81
 s3W+W8hlVABFrOfNZG+cigQBYNjEOfG0RGHDm1OfFh0iwy9vcLPO3JkGv8t/G1s8t5DJXmojO
 TJC5R8AVqYa8pIIDz4JHhgMZ3JuevmI4xFbv9P+pPyDDZyBJhCifu4Pl04B1roSZeeDml0Qvt
 /LQ/6w8QGIjXVCCkBQj50VrKPOfTYwntWsDpyQj4sibvgwBQR3OavFD2MqRd4LMfDemaGBXoz
 Sb0cJmW0nIDSCtEYyV2AEfaaNBZg6S5rgCSioXePIaqNUEiCHAUPvPOh9tndm3dg4mZvd8Thh
 /fKCBgwQcWmIw5uVmERQ5iCXKTP3dUuG1HUOC/f3HfgO7URQmSgjV5jFH8etuBGbdj5QPwbFb
 bY4lfSA0bDBGZgspRy2fWuoSECG2OyHqvT942+6Y/K5EItC8o3zwT20v8ECqpdozIgbS0JKbk
 Cfw4+1maw83sHm5whniAVafaMMUJj9aBNTftWxPEEfVz65Gd6F8DoBCeAneQnyX1qgEeZaKed
 9j8ofXw1VazsWYXn2bJIri1A==
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

On 02.09.24 03:18, Simon Glass wrote:
> Add a simple app to use for testing. This is intended to do whatever it
> needs to for testing purposes. For now it just prints a message and
> exits boot services.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   lib/efi_loader/Kconfig   | 10 ++++++
>   lib/efi_loader/Makefile  |  1 +
>   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 79 insertions(+)
>   create mode 100644 lib/efi_loader/testapp.c
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index ab2c1c44364..4de05c6f2d6 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -528,4 +528,14 @@ config BOOTEFI_HELLO_COMPILE
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
> +
> +	/* exit boot services so that this part of U-Boot can be tested */
> +	boottime->exit_boot_services(handle, map_key);
> +
> +	/* now exit for real */
> +	ret =3D boottime->exit(handle, ret, 0, NULL);

You cannot call boot services after ExitBootServices().

Best regards

Heinrich

> +
> +	/* We should never arrive here */
> +	return ret;
> +}

