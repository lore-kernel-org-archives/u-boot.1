Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1930C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 05:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2DA88308;
	Wed,  5 Jun 2024 07:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XQ5atXEk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2355C88096; Wed,  5 Jun 2024 07:52:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F1A8751B
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 07:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717566766; x=1718171566; i=xypron.glpk@gmx.de;
 bh=ut8P5+W/icFiuRaR2qagZpGMKVkDsX4uyZWMrFU/kPY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XQ5atXEkIoVi05CDeGkbh+NiKgCqF0Fl0d/E/wnJsRTMk1vtiVzdiOYabnwF7utF
 Ko4KrhA86lAlCWvGfbAzO9EsWtJMP5SB5cdf7mtlLQGV7hqbdIMLPPFE8gcdj2R3q
 SnI24MoLnmjdFD4dkxXH6DUkaV0RtNNt0/3QUXyzgPVLL8BbjyTMslLruqM4kqPhF
 NxkcyFWZqpfQxt/cmA/sBlrYYVMCk6nYhdji0vjS8vfCXgLEsCw7GlOxwUNLfwy3d
 x3ZdWK1DRZBAVUvcIMoRiZwvOR5y+bdREO+Ly5uLj5BzeqsL4AiF1awJInPA9cZzk
 TodsE883MzP+ode9qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1sMx2K0kYk-00Cmht; Wed, 05
 Jun 2024 07:52:46 +0200
Message-ID: <54c1e53b-a6a0-410c-b6de-ac9f7a492f76@gmx.de>
Date: Wed, 5 Jun 2024 07:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] efi: add a helper to generate dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-2-ca4a4865db00@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-2-ca4a4865db00@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9JWCkeHbaP9/E1EZZzS1kbO3nqOmP1U4qUjnq4PokJNd5Yhn1gg
 0LKyXiTPN33B1oZXkDE6ROA1yFZ6ETUytbym0/3ndeMr9RaecBrWnRmADX/gQ4UBfAVJ1jj
 zX6KhXrFyCuUAS0/sLMv4QG5TPmrqD11AMf+1AZ6N0kjPcCDY3ryQbFZGRpjgyB5wgzj/ve
 /SYd1khleuqNsO6RTwHRA==
UI-OutboundReport: notjunk:1;M01:P0:vflZdolTIcE=;6S27v3xOXEZRTmca4LQaZCBjnCp
 8TXRJ8f6DqMED6/PmWfzHaNXsIKfZxT/onkJyZig74ZNkd+jVpJMs+zFp4iVftd8TYXqfl3IN
 7EFFaxOYiyCyUsSpjZxY1Lp5SwjeKE24T9C6Uzc0yjZYyAYO7R0URfpxDckaADtI9dItHrqG+
 TAejmTsFqMZQXixKLVCxwpgCTzmYUtSe32RCYV69bzeTyY99uIeoOs3vsgkmPZua6gwQYUUhP
 QTvO7MjwgPVY35QuUhoG+1HP00z7PQHaXLDexUeDHku2hin3k07erfQzzLakSjickj2bFiccp
 K5rw75v7jzLnscAivQUpmE7sfszwbkkfk8F507Ro7PkcxB/74Ab0muaCQMSVhpdyuYsxfYw8X
 5NeOMapaHtlA4cH4+e0Hfe4Tt1qmKnYZApNvkLVqdYlliIxBwaN7X0JyU/7dXdZHCw1oQ0wHY
 s5+N0udtTpkdv77jI2YwKB//t97t2iQg4WSXT10IxLBYC/Gp87JRzqdVX7/NaD4djQhgMGH9E
 br75/EMkBEwGGq708XAc1Tf0kMezaeHYAOOcu38VGzpi6n0XogEwCmrovj8l82aueIINQOHW3
 jzsvTaP7K+Fc3EU2P9py2CG5taNMIuEOdFEbZ8S4cRaE+67e3nPxpAxUUOpjCZFC5tAWUonHg
 wbvaFcMy/B2APor1lg02PhHe5dHnhTEG/wsYEts7Oxt4nwvvmOgWc1Y+TaGePWJzKc/7Vl5xb
 u14kLWjFnfOyrwKFCmBuz8VQkR5a5V0S9ZIBqLVAhi2uUXMAGieWYVH2NkwAEg4rKdNwyhXnu
 0zCfHiEPuOjlrqrJVD2R8twPs/rfDZbpLNwMkZvcmRujs=
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

On 5/31/24 15:50, Caleb Connolly wrote:
> Introduce a new helper efi_capsule_update_info_gen_ids() which populates
> the capsule update fw images image_type_id field. This allows for
> determinstic UUIDs to be used that can scale to a large number of
> different boards and board variants without the need to maintain a big
> list.
>
> We call this from efi_fill_image_desc_array() to populate the UUIDs
> lazily on-demand.
>
> This is behind an additional config option as it depends on V5 UUIDs and
> the SHA1 implementation.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   lib/efi_loader/Kconfig        | 23 +++++++++++++++
>   lib/efi_loader/efi_capsule.c  |  1 +
>   lib/efi_loader/efi_firmware.c | 66 +++++++++++++++++++++++++++++++++++=
++++++++
>   3 files changed, 90 insertions(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 430bb7f0f7dc..e90caf4f8e14 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -235,8 +235,31 @@ config EFI_CAPSULE_ON_DISK_EARLY
>   	  If this option is enabled, capsules will be enforced to be
>   	  executed as part of U-Boot initialisation so that they will
>   	  surely take place whatever is set to distro_bootcmd.
>
> +config EFI_CAPSULE_DYNAMIC_UUIDS
> +	bool "Dynamic UUIDs for capsules"
> +	depends on EFI_HAVE_CAPSULE_SUPPORT
> +	select UUID_GEN_V5

This select will create a build error if CONFIG_SHA1=3Dn as
CONFIG_UUID_GEN_V5 depends on it.

> +	help
> +	  Select this option if you want to use dynamically generated v5
> +	  UUIDs for your board. To make use of this feature, your board
> +	  code should call efi_capsule_update_info_gen_ids() with a seed
> +	  UUID to generate the image_type_id field for each fw_image.
> +
> +	  The CapsuleUpdate payloads are expected to generate matching UUIDs
> +	  using the same scheme.
> +
> +config EFI_CAPSULE_NAMESPACE_UUID
> +	string "Namespace UUID for dynamic UUIDs"
> +	depends on EFI_CAPSULE_DYNAMIC_UUIDS
> +	help
> +	  Define the namespace or "salt" UUID used to generate the per-image
> +	  UUIDs. This should be a UUID in the standard 8-4-4-4-12 format.

As UUIDs can be formatted low-endian or big-endian I would not know how
the value will be interpreted.

Why do we need a vendor specific name-space if we are using compatible
strings which are vendor specific themselves?

> +
> +	  Device vendors are expected to generate their own namespace UUID
> +	  to avoid conflicts with existing products.
> +
>   config EFI_CAPSULE_FIRMWARE
>   	bool
>
>   config EFI_CAPSULE_FIRMWARE_MANAGEMENT
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 0937800e588f..ac02e79ae7d8 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -19,8 +19,9 @@
>   #include <mapmem.h>
>   #include <sort.h>
>   #include <sysreset.h>
>   #include <asm/global_data.h>
> +#include <uuid.h>
>
>   #include <crypto/pkcs7.h>
>   #include <crypto/pkcs7_parser.h>
>   #include <linux/err.h>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware=
.c
> index ba5aba098c0f..a8dafe4f01a5 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -244,8 +244,71 @@ void efi_firmware_fill_version_info(struct efi_firm=
ware_image_descriptor *image_
>
>   	free(var_state);
>   }
>
> +#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
> +/**
> + * efi_capsule_update_info_gen_ids - generate GUIDs for the images
> + *
> + * Generate the image_type_id for each image in the update_info.images =
array
> + * using the first compatible from the device tree and a salt
> + * UUID defined at build time.
> + *
> + * Returns:		status code
> + */
> +static efi_status_t efi_capsule_update_info_gen_ids(void)
> +{
> +	int ret, i;
> +	struct uuid namespace;
> +	const char *compatible; /* Full array including null bytes */
> +	struct efi_fw_image *fw_array;
> +
> +	fw_array =3D update_info.images;
> +	/* Check if we need to run (there are images and we didn't already gen=
erate their IDs) */
> +	if (!update_info.num_images ||
> +	    memchr_inv(&fw_array[0].image_type_id, 0, sizeof(fw_array[0].image=
_type_id)))
> +		return EFI_SUCCESS;
> +
> +	ret =3D uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_UUID,
> +			(unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
> +	if (ret) {
> +		log_debug("%s: CONFIG_EFI_CAPSULE_NAMESPACE_UUID is invalid: %d\n", _=
_func__, ret);
> +		return EFI_UNSUPPORTED;
> +	}

You don't want end-users to be the first to find this issue. This must
be a build time check.

> +
> +	compatible =3D ofnode_read_string(ofnode_root(), "compatible");
> +
> +	if (!compatible) {
> +		log_debug("%s: model or compatible not defined\n", __func__);

You are not reading model here.

> +		return EFI_UNSUPPORTED;
> +	}
> +
> +	if (!update_info.num_images) {
> +		log_debug("%s: no fw_images, make sure update_info.num_images is set\=
n", __func__);

I thought we were using capsules without images in A/B updates and need
to process them?

> +		return -ENODATA;
> +	}
> +
> +	for (i =3D 0; i < update_info.num_images; i++) {
> +		gen_uuid_v5(&namespace,
> +			    (struct uuid *)&fw_array[i].image_type_id,
> +			    compatible, strlen(compatible),
> +			    fw_array[i].fw_name, u16_strsize(fw_array[i].fw_name)
> +				- sizeof(uint16_t),
> +			    NULL);
> +
> +		log_debug("Image %ls UUID %pUs\n", fw_array[i].fw_name,
> +			  &fw_array[i].image_type_id);
> +	}
> +
> +	return EFI_SUCCESS;
> +}
> +#else
> +static efi_status_t efi_capsule_update_info_gen_ids(void)
> +{
> +	return EFI_SUCCESS;

Why should we have a case were we don't generate the image UUIDs?
Don't we get rid of capsule GUIDs in the device-trees?

Best regards

Heinrich

> +}
> +#endif
> +
>   /**
>    * efi_fill_image_desc_array - populate image descriptor array
>    * @image_info_size:		Size of @image_info
>    * @image_info:			Image information
> @@ -282,8 +345,11 @@ static efi_status_t efi_fill_image_desc_array(
>   		return EFI_BUFFER_TOO_SMALL;
>   	}
>   	*image_info_size =3D total_size;
>
> +	if (efi_capsule_update_info_gen_ids() !=3D EFI_SUCCESS)
> +		return EFI_UNSUPPORTED;
> +
>   	fw_array =3D update_info.images;
>   	*descriptor_count =3D update_info.num_images;
>   	*descriptor_version =3D EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION;
>   	*descriptor_size =3D sizeof(*image_info);
>

