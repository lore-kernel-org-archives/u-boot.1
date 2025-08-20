Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39001CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 12:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F8382F03;
	Wed, 20 Aug 2025 14:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bXe6sxWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2905801DD; Wed, 20 Aug 2025 14:29:02 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A5C8211F
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 14:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e95011504d4so205745276.3
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755692939; x=1756297739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pNpk2gSkCsjQ3XaZf1GQcYRuIDN7bHTemuu7jKX9Ucc=;
 b=bXe6sxWx2gkxwTVBOrkE+htCOFSa30z+HifKn1oSU42LTtwRAaQZvJAT6hRarCC3O4
 nRadbph8hjHfea5/Xg1Hnd71GX4fITvUdMLBB6KIpSL+gKf9XIrWX2iyt7Pgi+EPQHrq
 mnhn7PwyadxJA9bHOKP0SX+qIJKFzEFwzNzTTL4LMSc8s6WRQBmXoCAR9EJzW7XQaqZD
 GYvzQjd86W60j9fQNg53RUDJAveJzzZqtTGWBoc2am3MlZWEt+bzGqlIBERZ2bKcuxsC
 MLrr8K3+B9lEs4kVs5Pm02M+/5QZWfdaUgqlp9VDq+7b8r6+DhjmX8VBMTEExK0HPtmi
 H97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755692939; x=1756297739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pNpk2gSkCsjQ3XaZf1GQcYRuIDN7bHTemuu7jKX9Ucc=;
 b=Ub6nxsIo9grS1XfjoazmpaxRj1iSQJty9sWzBWC34zAa8NYSkys3KzXzFaRigan08B
 DjIV/UuAN3wA6aL+9e+hrH7iOp1UC7UDhFJUgHjynZLVqzJOxzG0gZK2mFhQofrNBKLF
 nzA1was2WcCnmmUiBtL7S1dfBzgbeLUtYnNZLIjuK+Z7+cBUcpta+nWD0wgNLyop5+zD
 XKUJ/MCiQxAK/fvdCekBzsrpV6qoZN/G8fNk0fD+gpceqmr7+1r8qI4wNsJPa8vFxc9r
 g6ZEBQHbD9/cDqUOdybZs667ltZv6PlTFVtWgKtZ0uRUpSVe+9LbBCH3wnGpkSSQpc5u
 Lp5g==
X-Gm-Message-State: AOJu0YyNtaW9+4yhBV0NtI8yTRTQcisjC/OjA/Pl1BJlc7kcsvHL/k0t
 bHxCsg88L0LX/QrvyaAODbplXaLR9TrUNImWEAeOzilcmayY0NBqp4vWTtzmibzOIKV93JsOQhG
 6uuBl+R7a5TX9I1lQWHbW0l5hYX8VIgy4XGLhDcfKqyzaFQHEAMbUr5vJMA==
X-Gm-Gg: ASbGncsVNjjhHVgbIDGzxc8AdbhYMvMLc0KPVG4FKYAm+TX2COFiJzzTGaJET3vaZMB
 LTrI6og6HkP3ayS/bw8OfhAe0S9yxv+JDvXoR19hCb1ZvCEhmyofE8/NxNVei5Rg3ehQB165hSj
 uwiIw1lGR4ldJkjGKt725fxiS10AHXkST8m9zHSr/9cSCGqwQG5OFptgjeDJAfuDTCvG2Gzt4Dq
 I6xsQ==
X-Google-Smtp-Source: AGHT+IHm1KZ8SoQAaBQk2vlFk37F44pRx6rEjBR1n7K+CITIwJPBkbkvBr2vfxZHKxqBwriETO5b0nW3PFUCuag4JhY=
X-Received: by 2002:a05:6902:5417:b0:e90:69a1:1786 with SMTP id
 3f1490d57ef6-e94f666aba1mr3381470276.43.1755692938769; Wed, 20 Aug 2025
 05:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
 <20250725155010.285831-13-abdellatif.elkhlifi@arm.com>
In-Reply-To: <20250725155010.285831-13-abdellatif.elkhlifi@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Aug 2025 15:28:22 +0300
X-Gm-Features: Ac12FXzFnhq2_aOHxzpUpYUn6x5U2uVpLUh4C4MHDVGBvvYSAZBrRIyo7lvcF4s
Message-ID: <CAC_iWjK2kuYtt-R7F52zDVTpaFj6=0R1AU+Dni+t+-4+yq3_=w@mail.gmail.com>
Subject: Re: [PATCH v4 12/24] efi_loader: fwu_arm_psa: Add set_image and
 get_image_info support
To: abdellatif.elkhlifi@arm.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Davidson kumaresan <davidson.kumaresan@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
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

Hi Abdelllatif

On Fri, 25 Jul 2025 at 18:50, <abdellatif.elkhlifi@arm.com> wrote:
>
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Implement set_image and get_image_info through RAW functions
>
> The implementation is done using efi_firmware_raw_set_image()
> and efi_firmware_get_image_info()
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
>
> ---
>
> Changelog of changes:
> ===========================
>
> v2:
>
> * Following Heinrich comment: The changes at efi_firmware_raw_set_image()
>     simplified by removing the "else" so it is clear we are just adding FWU_ARM_PSA
>     support and skipping the use of DFU in case of FWU_ARM_PSA
>
> v1:
>
> * Add set_image and get_image_info support for FWU_ARM_PSA
>
>  lib/efi_loader/efi_firmware.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 75501e21557..38945b34e7b 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -4,6 +4,12 @@
>   *
>   *  Copyright (c) 2020 Linaro Limited
>   *                     Author: AKASHI Takahiro
> + *
> + * Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + *
> + * Authors:
> + *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> + *   Davidson kumaresan <davidson.kumaresan@arm.com>

Copyright updates are usually done on significant contributions. I am
not this qualifies as such.
Tom is there a policy for that in U-Boot docs?

>   */
>
>  #define LOG_CATEGORY LOGC_EFI
> @@ -14,6 +20,7 @@
>  #include <efi_variable.h>
>  #include <env.h>
>  #include <fwu.h>
> +#include <fwu_arm_psa.h>
>  #include <image.h>
>  #include <signatures.h>
>
> @@ -601,10 +608,21 @@ efi_status_t EFIAPI efi_firmware_get_image_info(
>              !descriptor_size || !package_version || !package_version_name))
>                 return EFI_EXIT(EFI_INVALID_PARAMETER);
>
> -       ret = efi_fill_image_desc_array(image_info_size, image_info,
> -                                       descriptor_version, descriptor_count,
> -                                       descriptor_size, package_version,
> -                                       package_version_name);
> +       if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
> +               ret = fwu_arm_psa_get_image_info(image_info_size, image_info,
> +                                                descriptor_version,
> +                                                descriptor_count,
> +                                                descriptor_size,
> +                                                package_version,
> +                                                package_version_name);
> +       } else {
> +               ret = efi_fill_image_desc_array(image_info_size, image_info,
> +                                               descriptor_version,
> +                                               descriptor_count,
> +                                               descriptor_size,
> +                                               package_version,
> +                                               package_version_name);
> +       }

Since the functions above seem to accept the same arguments, why don't
we you define your own version of efi_fill_image_desc_array() if PSA
is enabled?
GetImageInfo() is defined by the EFI spec and I'd like to keep it as
abstracted as possible from the internal implementation details.


>
>         return EFI_EXIT(ret);
>  }
> @@ -749,6 +767,15 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>         if (status != EFI_SUCCESS)
>                 return EFI_EXIT(status);
>
> +       if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
> +               if (fwu_update_image(image, image_index, image_size))
> +                       return EFI_EXIT(EFI_DEVICE_ERROR);
> +
> +               efi_firmware_set_fmp_state_var(&state, image_index);
> +
> +               return EFI_EXIT(EFI_SUCCESS);
> +       }
> +
>         /*
>          * dfu_alt_num is assigned from 0 while image_index starts from 1.
>          * dfu_alt_num is calculated by (image_index - 1) when multi bank update
> --
> 2.25.1
>

Thanks
/Ilias
