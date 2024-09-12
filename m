Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FECEE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5A888DB7;
	Thu, 12 Sep 2024 03:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KXejvkqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7555588DC7; Thu, 12 Sep 2024 03:00:18 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E0D88DAF
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718d704704aso292218b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102812; x=1726707612; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hYZHz9EHN009K2I0qPAX4OF1MfX3XqHVLffPXiN5Bu0=;
 b=KXejvkqXmiDNH7GdeB0RYu9y92oQfEgHqMuP36V9ryZ1qBfz6Mo/bp1i7s1H05ZbD0
 gy2AVPS3jR8+ohTkNztJ55DiElMYe37iaFBSDKd/9aA9d7s/kpBq6euV6IVRTPrlT2g2
 9fcOPgollhecSY6YdAqPOVaJ0dIo5ApsHqhRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102812; x=1726707612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYZHz9EHN009K2I0qPAX4OF1MfX3XqHVLffPXiN5Bu0=;
 b=E3uj8V/Nyxh0M+BuWRZgRtZtXlL5P/pKR3UEYeEMclPaA51dqxLMNRodTmyH+YTRof
 q/GOhUm5SLzo4N0Xyn5A0OeBoGTPqhph7gAL+tFk18ZRFKD30nqsNjGIVXYBSvZ6wsdI
 CuE4Z5oN718B2+RYfkqW5KD5LFFfDksv2Ho1Gp+1F2vDM2In7rFPIsZCZ/gMy3jAgXwf
 OfoYjbjTGlniNfIhAMX6SWBSoG2IfJnjXJqTRVf2KQgpoqG0/OZ0r6InAH+ria3LDueD
 TZPaOW2K0ojnU9d9Xe8O+IbkQ1cDiayK8vLZn+4sTBXJOZO2pGQmLZmmp7fNUmXFLXQK
 W7iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX84WG/cGxvlRH0viovd0XsZtc7/05n3NwZ7nPZrcZ7xcdhiRT7aARkJ7zWan7t8Ng39vyF0sc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxa/oQBqJOazy/Hxj7VKmHw+V7HQsKbw4Ks8veqQgyPAqLbi84+
 yFvMwMHAz8pren/okwhxIjhj7iXk+RGyL1+Tg16+kg96UfJHFoidcv7fEpwUuB5DJtdEcGvR7hI
 G+8xEMKBa8JlhAh85O1Soi/wQ6DelvdBwUMea
X-Google-Smtp-Source: AGHT+IGQ2Rd+dt3sKsFJ/12Hae6oX/mrMcApc9NS8olhq6iW1ORqeHMjNRSJN5kaZ+Fqh66vEAhdm3nXTL9rx1A/kIQ=
X-Received: by 2002:a05:6a00:b92:b0:717:8d81:e548 with SMTP id
 d2e1a72fcca58-7192606523bmr1880024b3a.1.1726102812226; Wed, 11 Sep 2024
 18:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240904-bootmeth-bootloader-version-v1-1-9979a8428566@baylibre.com>
In-Reply-To: <20240904-bootmeth-bootloader-version-v1-1-9979a8428566@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:49 -0600
Message-ID: <CAFLszTiKCbnqFv_nX4eH3n01LaHHwJstXLEpA3G6UXC7spZMxA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: android: Add U-Boot version to cmdline
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
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

Hi Mattijs,

On Wed, 4 Sept 2024 at 03:38, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> When booting into Android fastbootd (a subset of recovery), the default
> UI shows the bootloader version in the screen [1].
> This is done via the ro.bootloader property which should come from the
> bootloader.
>
> Provide the U-Boot version via a kernel commandline argument so that
> fastbootd can show it properly on the screen.
>
> [1] https://android.googlesource.com/platform/bootable/recovery/+/refs/heads/main/fastboot/fastboot.cpp#42
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/bootmeth_android.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 6e8d3e615db0..2fb82a5073de 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -22,6 +22,7 @@
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <part.h>
> +#include <version.h>
>  #include "bootmeth_android.h"
>
>  #define BCB_FIELD_COMMAND_SZ 32
> @@ -171,6 +172,12 @@ static int configure_serialno(struct bootflow *bflow)
>         return bootflow_cmdline_set_arg(bflow, "androidboot.serialno", serialno, false);
>  }
>
> +static int configure_bootloader_version(struct bootflow *bflow)
> +{
> +       return bootflow_cmdline_set_arg(bflow, "androidboot.bootloader",
> +                                       PLAIN_VERSION, false);
> +}
> +
>  static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  {
>         struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
> @@ -267,6 +274,8 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>         /* Ignoring return code: setting serial number is not mandatory for booting */
>         configure_serialno(bflow);
>
> +       configure_bootloader_version(bflow);

Error check? If for some reason you want to ignore the error, please
add a comment here.

> +
>         if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL) {
>                 ret = bootflow_cmdline_set_arg(bflow, "androidboot.force_normal_boot",
>                                                "1", false);
>
> ---
> base-commit: 360aaddd9cea8c256f50c576794415cadfb61819
> change-id: 20240904-bootmeth-bootloader-version-2a2b35fce4cf
>
> Best regards,
> --
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>

REgards,
Simon
