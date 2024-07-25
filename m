Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F07C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 11:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE828789F;
	Thu, 25 Jul 2024 13:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BAfxjNxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB5B87C7E; Thu, 25 Jul 2024 13:58:27 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406BC8708B
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc47abc040so5302205ad.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 04:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721908704; x=1722513504; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pWayWdrgAYx0lVHNloxK5pXeuRWIIBYnBGE5JaM2h3c=;
 b=BAfxjNxkIHeZUi3PKrR1BRFDos9ZjVXH+3ITYJ9ws3WvLVPO92sXFccNqZVkHK2ZPd
 wOenfbyg5kcmtrai9smKzoxnTWNhK/6cH9h6MCuWC20mnyC7eb4T1YWYy66+hqA+BxyY
 MftWQWzSVlf/a21FFZ5deoFSYKoDWO/TNQ5CI5eeW1uDimVy3XvKms1LcYRTV5JzgufD
 f/yTwOzNpQ/sgwFR95VW8+qDpsBcKmHae3xlwyTONwBlHwPzpZBx4i2gv87g+4fz6yNn
 x055GoL2HcQi04X0CJsy2tePveiveQ4Sihurf5fvhjQFDclImyNH2tN3ZW+6d9dvX+Yp
 wq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721908704; x=1722513504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pWayWdrgAYx0lVHNloxK5pXeuRWIIBYnBGE5JaM2h3c=;
 b=UjCyTxdIYFkjX5PYTIMpaak23hZVPp0jG96Y48r6+6eEGnHHRqfT+O9/dJ4CtY4MK0
 6hKop24OPjnNxq8hY8tONKabS7gNH3l1quW06YCB9cQ8wbBT95aKCex4pk+Dj8q/069z
 n6UqnIyoyh6QwbUXh9R8Ij1l5OsxNXaIubsjn/6B0J3sbDZuSuzZXUYIVSaTZtynNY/o
 rIPDkYTVZwPtvdCZKuM+oWd9cqUzQud5XfqZQHS/SwFz0ig1JXb/59iO8gcWuHOw+oV4
 i8kpY486QDWt1pBrE9QWl8QKiZWgYIw2uaclDonRKBW/9ASCUvTHA39rNRNnSf1ngygW
 dHqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgw0+lFd5qThNHx+EOo4v9uUczwH4rOmEv83Id7mh1v/aW90MW8FqpycxtxFvz3yVAaKxBX1PZtBO2h1fN64pUAshm0g==
X-Gm-Message-State: AOJu0Yz8JUShAkfuNpftdcTYhW2cmbrRZvk96lbTKX6eFp7DrISpEcal
 +gC/ErNQUl7NmdQtsE1m9GTKlLUKMac0LAdVanTcFdnBdMEBs8XEpkXeH+TNrJ2Lvy3ESx1AGPJ
 aZJkNgAbDwW7Hk8BQnA1KjD9agb05KMrxX9eF2A==
X-Google-Smtp-Source: AGHT+IG7vxl6YoBHdOOWaGtE5DdQHCapu8vikBTRcKgV60FwykI4+KLnmWG2Vk0CTLwoLJwRsbPPYJLrnBt0u8UzFRc=
X-Received: by 2002:a17:90a:a08e:b0:2cb:5134:562a with SMTP id
 98e67ed59e1d1-2cf2377212bmr2815278a91.7.1721908703627; Thu, 25 Jul 2024
 04:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
 <20240719-b4-dynamic-uuid-v5-3-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-3-8a83de3fe3dc@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Jul 2024 14:57:47 +0300
Message-ID: <CAC_iWjL3Fk0MtX+=VmRZiN7zRDpgfGHtvKKEYGJi20CPCb-17A@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] efi: add a helper to generate dynamic UUIDs
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

Hi Caleb,


> +/**
> + * efi_capsule_update_info_gen_ids - generate GUIDs for the images
> + *
> + * Generate the image_type_id for each image in the update_info.images array
> + * using the first compatible from the device tree and a salt
> + * UUID defined at build time.
> + *
> + * Returns:            status code
> + */
> +static efi_status_t efi_capsule_update_info_gen_ids(void)

I think efi_gen_capsule_guids() is a better name

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
> +               return EFI_UNSUPPORTED;

EFI_INVALID_PARAMETER is a better return code for this and the check
that follows

> +       }
> +
> +       compatible = ofnode_read_string(ofnode_root(), "compatible");
> +       if (!compatible) {
> +               log_debug("%s: model or compatible not defined\n", __func__);
> +               return EFI_UNSUPPORTED;
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
> @@ -282,8 +331,11 @@ static efi_status_t efi_fill_image_desc_array(
>                 return EFI_BUFFER_TOO_SMALL;
>         }
>         *image_info_size = total_size;
>
> +       if (efi_capsule_update_info_gen_ids() != EFI_SUCCESS)
> +               return EFI_UNSUPPORTED;

When you make the changes above do
ret = efi_gen_capsule_guids()
if (ret != EFI_SUCESS)
    return ret;

> +
>         fw_array = update_info.images;
>         *descriptor_count = update_info.num_images;
>         *descriptor_version = EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION;
>         *descriptor_size = sizeof(*image_info);
>
> --
> 2.45.2
>

Other than that, this patch looks ok

Cheers
/Ilias
