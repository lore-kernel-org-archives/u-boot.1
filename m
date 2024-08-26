Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D05C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60FAA889FC;
	Mon, 26 Aug 2024 16:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F+8zQ4Z3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0271588A13; Mon, 26 Aug 2024 16:43:21 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 950CE87E64
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20230059241so34841105ad.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724683397; x=1725288197; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k4/cd/aEFEt8x/J7HHUI4rkhnIBQrcLeyokIs0soPNs=;
 b=F+8zQ4Z3QHlfg0K+KieO9IXLc7TVw363pblI0KzwgZ/7NrE3JXAaAQBRykUcb0BndU
 OkQ/uo8bVyyYIDjmT7j95gVpn+kxSF4T+vjVvlwt+83gjkp6yBOmHiNtX/ghWaj/hq+o
 QLEXMLau+WH/QhKDpsPA8W9ErWogR0c5jcjhAcqFtQfdgpq4zuS82qUqWzl3aebfRSI8
 FxpJ4FE4T4wN/TeWSofqQZUN0XAKYHQQajoccUPsWl3Rh1UK3vLrre70eNxqwLamnhzH
 qhXOeweKu5/qE+ppMu7TLNmNPgQ0MXmlcg0Z8OSGoEGsfSVbHobwcv0MhYHVBpLMvzjn
 DwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724683397; x=1725288197;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k4/cd/aEFEt8x/J7HHUI4rkhnIBQrcLeyokIs0soPNs=;
 b=D4KgjDe/yW1t5Wg4G1Ohfyvyu0w165rFR5qYcfCsKT02SKaKDkFQVU4s/aDsDMEuoz
 36AaOugYSmNFlyZdezWYZ0IdORcHJZQ2UcOTvWn4Je3gUdmyC6nPS+d63VJrOxlVQPch
 qNpD7R20CdV0gpvvTAkg96MFHh+KMBK6rmnesVQrVapxL8/ilFpBgZfEaQ+yY8fkjgsz
 cNs/Dpvi2jP7D1Pxja4J6mrTDU7BMaEMb5wvXZbulnRG17mdmf0mivZqYIXsyo1zR3Eo
 IiLF0XAmXl7swzP5XbQGWyhuQv0lbsHzkPp1Cj9+oLyeqgPKqFUD5Z8iK3aSg92Ntxj9
 0GOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmSvbZwnD0HLdlpRvg+Yl6zLplF7LqebmHZbusgGo5ufAf9xuKs7mV2z85Bnhsr0ZslBny5Og=@lists.denx.de
X-Gm-Message-State: AOJu0YwfTzyOgCGThJu3LiUS9wZBWbjwflbAhiDGeO9kS5rfEOdFoLey
 7gZX8YJQZwFAJJFKhW2E90SktRzZfY4FZD4dwUdcDBUXZj9/MHVcXw7Z+/fyJgljtT+I77hbrER
 lZiIY8D/Fem16+wmWJcV5C9+wcmOJ8syTO1DJsQ==
X-Google-Smtp-Source: AGHT+IFL5bGb9uzhTBtcZcZra7A1O2haXTGVKV1ZMCvDr0FYsCs37jQnXu/MokmDFCS0cnc2eg8CvRJXLBKyxMjY2p0=
X-Received: by 2002:a17:903:41ca:b0:202:ac8:991f with SMTP id
 d9443c01a7336-2039e48b9a9mr100745605ad.26.1724683396836; Mon, 26 Aug 2024
 07:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
 <20240809-b4-dynamic-uuid-v7-3-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-3-8c44ab1f06a5@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 17:42:39 +0300
Message-ID: <CAC_iWj+dGepRp+BruAAY3wnUTbOwOvCzrDmY=3BS87czxdxAjw@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] efi: add a helper to generate dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 9 Aug 2024 at 03:56, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Introduce a new helper efi_capsule_update_info_gen_ids() which populates
> the capsule update fw images image_type_id field. This allows for
> determinstic UUIDs to be used that can scale to a large number of
> different boards and board variants without the need to maintain a big
> list.
>
> We call this from efi_fill_image_desc_array() to populate the UUIDs
> lazily on-demand.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  lib/efi_loader/Kconfig        | 12 ++++++++++
>  lib/efi_loader/efi_capsule.c  |  1 +
>  lib/efi_loader/efi_firmware.c | 55 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 1179c31bb136..85a31113fcf0 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -236,8 +236,20 @@ config EFI_CAPSULE_ON_DISK_EARLY
>           If this option is enabled, capsules will be enforced to be
>           executed as part of U-Boot initialisation so that they will
>           surely take place whatever is set to distro_bootcmd.
>
> +config EFI_CAPSULE_NAMESPACE_GUID
> +       string "Namespace for dynamic capsule GUIDs"
> +       # v4 UUID as a default for upstream U-Boot boards
> +       default "8c9f137e-91dc-427b-b2d6-b420faebaf2a"
> +       depends on EFI_HAVE_CAPSULE_SUPPORT
> +       help
> +         Define the namespace or "salt" GUID used to generate the per-image
> +         GUIDs. This should be a GUID in the standard 8-4-4-4-12 format.
> +
> +         Device vendors are expected to generate their own namespace GUID
> +         to avoid conflicts with upstream/community images.
> +
>  config EFI_CAPSULE_FIRMWARE
>         bool
>
>  config EFI_CAPSULE_FIRMWARE_MANAGEMENT
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index 635088f25a13..f3a2388506cc 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -19,8 +19,9 @@
>  #include <mapmem.h>
>  #include <sort.h>
>  #include <sysreset.h>
>  #include <asm/global_data.h>
> +#include <uuid.h>
>
>  #include <crypto/pkcs7.h>
>  #include <crypto/pkcs7_parser.h>
>  #include <linux/err.h>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index ba5aba098c0f..c0240e95cf13 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -244,8 +244,57 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
>
>         free(var_state);
>  }
>
> +/**
> + * efi_gen_capsule_guids - generate GUIDs for the images
> + *
> + * Generate the image_type_id for each image in the update_info.images array
> + * using the first compatible from the device tree and a salt
> + * UUID defined at build time.
> + *
> + * Returns:            status code
> + */
> +static efi_status_t efi_gen_capsule_guids(void)
> +{
> +       int ret, i;
> +       struct uuid namespace;
> +       const char *compatible; /* Full array including null bytes */
> +       struct efi_fw_image *fw_array;
> +
> +       fw_array = update_info.images;
> +       /* Check if we need to run (there are images and we didn't already generate their IDs) */
> +       if (!update_info.num_images ||
> +           memchr_inv(&fw_array[0].image_type_id, 0, sizeof(fw_array[0].image_type_id)))
> +               return EFI_SUCCESS;
> +
> +       ret = uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_GUID,
> +                       (unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
> +       if (ret) {
> +               log_debug("%s: EFI_CAPSULE_NAMESPACE_GUID is invalid: %d\n", __func__, ret);
> +               return EFI_INVALID_PARAMETER;
> +       }
> +
> +       compatible = ofnode_read_string(ofnode_root(), "compatible");
> +       if (!compatible) {
> +               log_debug("%s: model or compatible not defined\n", __func__);
> +               return EFI_INVALID_PARAMETER;
> +       }
> +
> +       for (i = 0; i < update_info.num_images; i++) {
> +               gen_v5_guid(&namespace,
> +                           &fw_array[i].image_type_id,
> +                           compatible, strlen(compatible),
> +                           fw_array[i].fw_name, u16_strlen(fw_array[i].fw_name) * sizeof(uint16_t),
> +                           NULL);
> +
> +               log_debug("Image %ls UUID %pUl\n", fw_array[i].fw_name,
> +                         &fw_array[i].image_type_id);
> +       }
> +
> +       return EFI_SUCCESS;
> +}
> +
>  /**
>   * efi_fill_image_desc_array - populate image descriptor array
>   * @image_info_size:           Size of @image_info
>   * @image_info:                        Image information
> @@ -271,9 +320,9 @@ static efi_status_t efi_fill_image_desc_array(
>         u16 **package_version_name)
>  {
>         size_t total_size;
>         struct efi_fw_image *fw_array;
> -       int i;
> +       int i, ret;
>
>         total_size = sizeof(*image_info) * update_info.num_images;
>
>         if (*image_info_size < total_size) {
> @@ -282,8 +331,12 @@ static efi_status_t efi_fill_image_desc_array(
>                 return EFI_BUFFER_TOO_SMALL;
>         }
>         *image_info_size = total_size;
>
> +       ret = efi_gen_capsule_guids();

ret should be efi_status_t

> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
>         fw_array = update_info.images;
>         *descriptor_count = update_info.num_images;
>         *descriptor_version = EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION;
>         *descriptor_size = sizeof(*image_info);
>
> --
> 2.46.0
>

with the fix above
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
