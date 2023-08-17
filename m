Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F37C2FC29
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E8E086B85;
	Thu, 17 Aug 2023 15:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OkZzGGY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE62386B84; Thu, 17 Aug 2023 15:43:07 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B9F86B85
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d6b0c2cca0aso3912814276.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279784; x=1692884584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8lxbpG2aIz/Q1AiOhCpYDr0O2X4IoD1bq+zSbSI7Fdw=;
 b=OkZzGGY63XzY3NCZezVMhYKl4JErD6R7LkIlNaQTF+RmXEY4a4cE0jpYdfiTOFExTw
 C3ZAouC8CWwHg7rzPSAUnft5cfFLo5gi6Sh3JA81sPb4A3uqb3e4KXDT6gE8kPfLKf2k
 YxTofL+N5M9LW13zq7Sjj15uQmh/9LelvZMdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279784; x=1692884584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8lxbpG2aIz/Q1AiOhCpYDr0O2X4IoD1bq+zSbSI7Fdw=;
 b=CcZ1E9PEAH2AyneSMU7xAiQVZrXqfeMl9uXkGNj+AnJjdPD//5JT8bkSotVgReFOBH
 A6IOPTXH8/NpH+z97trtg34xYWgzL6fKkOEs0zZ3OukG4/42NyVuOkN5uZqBaQleQhsS
 IFFHY/uCfsoRsLvityp8efSEvTWF6f/k+zdh7C9i/SVxqla5+Gy473vSY4MJT81Gklgu
 G2wN3dcTuc8RIiwg5TsV+RI0VsC5O2kX6wEN+8+pxT268MBSMJfqha7SQkERVjHtGQ8D
 cYyYD++oTNba2qz/E4chz9kL6KT6YfycW7H5WjZoRqSfKtTPFkrPvCX1fGJv7Q/Vezkh
 +DeQ==
X-Gm-Message-State: AOJu0Yxr+3CFA64xAYIHHu8oSygqpzab27X2Cae0KMx2/c4NvKyZTjmE
 p/YPrV8W8rK0NEuNAO1z7Hxh7uzfN+ZDGmOWM1bIXBw5bDvibJWm5/I=
X-Google-Smtp-Source: AGHT+IFwdEjF8fxVECQ6I6kAHMG5h27ciB322N2XAn67RR9D+TBJnq9HTA6oYKjNehekE/xNlsFQWCYUDciLcRIhXYg=
X-Received: by 2002:a25:2d10:0:b0:d0b:f845:c831 with SMTP id
 t16-20020a252d10000000b00d0bf845c831mr5057536ybt.13.1692279783511; Thu, 17
 Aug 2023 06:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
 <20230812002823.82576-4-seanedmond@linux.microsoft.com>
In-Reply-To: <20230812002823.82576-4-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:41:44 -0600
Message-ID: <CAPnjgZ2kQpcBzmPzmPPLiZHhHYAVdxb_Nnya-3pcb_qYbciKYw@mail.gmail.com>
Subject: Re: [PATCH 3/5] common: Add OS anti-rollback validation using
 security devices
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, stcarlso@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, abdellatif.elkhlifi@arm.com
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

Hi Sean,

On Fri, 11 Aug 2023 at 18:28, <seanedmond@linux.microsoft.com> wrote:
>
> From: Stephen Carlson <stcarlso@linux.microsoft.com>
>
> New config CONFIG_ARBP to enable enforcement of OS anti-rollback counter
> during image loading.
>
> Images with an anti-rollback counter value "arbvn" declared in the FDT will
> be compared against the current device anti-rollback counter value, and
> older images will not pass signature validation. If the image is newer, the
> device anti-rollback counter value will be updated.
>
> Signed-off-by: Stephen Carlson <stcarlso@linux.microsoft.com>
> ---
>  boot/Kconfig         |  9 +++++
>  boot/image-fit-sig.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
>  boot/image-fit.c     | 23 ++++++++++++
>  include/image.h      |  4 ++
>  4 files changed, 125 insertions(+)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index e8fb03b801..e08c274b7c 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -103,6 +103,15 @@ config FIT_CIPHER
>           Enable the feature of data ciphering/unciphering in the tool mkimage
>           and in the u-boot support of the FIT image.
>
> +config FIT_ARBP

FIT_ROLLBACK would be better

arbp is really horrible :-)

> +       bool "Enable Anti rollback version check for FIT images"
> +       depends on FIT_SIGNATURE
> +       default n
> +       help
> +         Enables FIT image anti-rollback protection. This feature is required
> +         when a platform needs to retire previous versions of FIT images due to
> +         security flaws and prevent devices from being reverted to them.
> +
>  config FIT_VERBOSE
>         bool "Show verbose messages when FIT images fail"
>         depends on FIT
> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> index 12369896fe..bf3b81a3a3 100644
> --- a/boot/image-fit-sig.c
> +++ b/boot/image-fit-sig.c
> @@ -11,6 +11,8 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <asm/global_data.h>
> +#include <dm.h>
> +#include <dm-security.h>

You don't need dm- in your headerfiles. I think this should be
rolllback.h and that should be the name of your uclass.

>  DECLARE_GLOBAL_DATA_PTR;
>  #endif /* !USE_HOSTCC*/
>  #include <fdt_region.h>
> @@ -63,6 +65,39 @@ struct image_region *fit_region_make_list(const void *fit,
>         return region;
>  }
>
> +#if !defined(USE_HOSTCC)

Can we drop that?

> +static int fit_image_verify_arbvn(const void *fit, int image_noffset)
> +{
> +       u64 image_arbvn;
> +       u64 plat_arbvn = 0ULL;
> +       struct udevice *dev;
> +       int ret;
> +
> +       ret = fit_image_get_arbvn(fit, image_noffset, &image_arbvn);
> +       if (ret)
> +               return 0;

?? Isn't this an error?

> +
> +       ret = uclass_first_device_err(UCLASS_SECURITY, &dev);
> +       if (ret)
> +               return -ENODEV;

return ret

> +
> +       ret = dm_security_arbvn_get(dev, &plat_arbvn);
> +       if (ret)
> +               return -EIO;
> +
> +       if (image_arbvn < plat_arbvn) {
> +               return -EPERM;
> +       } else if (image_arbvn > plat_arbvn) {
> +               ret = dm_security_arbvn_set(dev, image_arbvn);
> +               printf(" Updating OS anti-rollback to %llu from %llu\n",
> +                      image_arbvn, plat_arbvn);

So the update happens in U-Boot? Don't we want to update it when we
know it boots?

> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
>  static int fit_image_setup_verify(struct image_sign_info *info,
>                                   const void *fit, int noffset,
>                                   const void *key_blob, int required_keynode,
> @@ -175,6 +210,16 @@ static int fit_image_verify_sig(const void *fit, int image_noffset,
>                 goto error;
>         }
>
> +#if !defined(USE_HOSTCC)

Can you use

if (!tools_build())

?

This seems to be adding to FIT so the FIT docs should be updated.

Regards,
Simon
