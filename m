Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1847AC49EA1
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BBE888A68;
	Wed,  7 Aug 2024 03:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LiEJfrqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E953D88AD4; Wed,  7 Aug 2024 03:42:25 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6AF889AF
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722994922; x=1723599722; i=xypron.glpk@gmx.de;
 bh=43fsBuzLZej39CRfWP7X1Z2BDpE33qLZ97TVzF7KInA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LiEJfrqVyOh0mSnq7pN8BpNX1bJvn5i7igbGgBYKCE8G8OhEK59ifkYuSWAl0t3d
 WLbZcBln4xVhvdpoGbgD+33ap+OzjuyO36eZAM27Jpbjt+hn97P1dwU6db+UBrEi1
 pATLVQDvAadcsc60CPktJ3ixvTI0kIbgMll5WEqK0ZDYYknHOfwzqNuhS1MYIcNHi
 W6iMQIXLwEOe9J+tJgt1GkWvrhaNKUbCEMnhFndiLWPNMl506aAU3Rq/YvVFT/Rq+
 jEHgiI+9Y5SQg+zcCeHb5cH/jWcoXIZUBnGKHgjJlaIfW3v9XbEE+34bic2oQWwEI
 wSIBPlG0DUDMQpV4zQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1scLIj2Myt-006gWW; Wed, 07
 Aug 2024 03:42:02 +0200
Message-ID: <194083b4-07e1-4b3d-906b-6277d1d8cd0c@gmx.de>
Date: Wed, 7 Aug 2024 03:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 36/39] efi: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-37-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240806125850.2316956-37-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e6Bb3GxFqYikxsMjiBnr/HYnCFusGUgeOO2UwXAb+znb0fhld0I
 INgGRiVwHZtGWUWQMyRGQB0PCeeWNLvNXwaziHFbeLsvQ6t5LYYX2j6YCY1B8V47en+LAmE
 MgmxQ7UtMGEkcWOC3NCM/uqEuRRSpismmpZn9FDyoTN38+/kjivutx+S/5wIcP8/twRVCsR
 lM1Bb4J44cvMDKYUYYcpQ==
UI-OutboundReport: notjunk:1;M01:P0:t8tE3SRX2cs=;SjL2ccfe2kqvt0lc/spG4KXdlgT
 MkQq0wBdUTA8hvXkAkk1bVu8/s4vawit4MVTzOeiFMLbwid29knwS1YWht/DzbomXJYJfXiuG
 6lO4UQn+TI3UhHwZgCJXyZD8GbkvH8W/FxV2bznRHdaUd/DhoGsbp787URXBg+Qr9dpHprsJ7
 XP+3EByjwFB8xpnQ3Z+6Eh04KxYcFkpuOCFG+GxS0bhaCKrhtxBIE4KrigSPj+DracDOltJhq
 PYt1Yyr2THCoNmGTJZ6THLccaIQU2OSDRdBGsAoniDZ443G/uk/0y1kBuvsND/2gE6LWJdgOQ
 EDUKO4KPNPuNh7v6i+rD5X+t32DrDRVYeEw6ev9ggiBL40sJsYEuI8DOQ+1kwfgOdEqaqUIf/
 bTx1x6TdwIZkjUCNHLhiM41byPmH0zWxJUjSPLoiMtMjEUkrNJTkmUnsRErf9REpJIS3mRsMK
 sz6dIHo0R8OYxCp0a3op1p8HVY/XXomYEFDjsu9OPrj7xk8IWochAdaE4G+BIg/GkH8o8DCP0
 bPHpeaS39AOZRwOx1oqF4DYWZpb1x78wAaAjFM5eDw2aDaAX5h6RfHkU7VLrpv/WRESJTkh/U
 K9r+M7Z2O1uxP00mKLDp41R5sJrBGXqGf6gSVM7op5yI6Vq35b9sE6eFAXy7huLdLGgDuKMXN
 PigXNraX0mS0CpINNoxF2npecG+IBonIZGwjsi94s9EmTPFGVhU42R9IrTtp9qFajUAL3q83O
 bmhM+hgp6JXK8MKk0LHaP6WtxKCrAM3DJtq6+meEkXq4VxuMxHu0vG6xPxmQRQGlFuIgQCeWn
 FE+LvEnH+M1CKv/W5z8nVpTRmkKlccUyqd3kOjLl20gOc=
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

On 06.08.24 14:58, Simon Glass wrote:
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

Please, have a look at chapter 7.4.6,
"EFI_BOOT_SERVICES.ExitBootServices" of the UEFI specification.

After ExitBootServices() you cannot return anywhere. Boot services are
not available anymore. You can only invoke the UEFI runtime services
which include ResetSystem().

Best regards

Heinrich

> +
> +	/* We should never arrive here */
> +	return ret;
> +}

