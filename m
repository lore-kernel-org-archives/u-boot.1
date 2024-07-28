Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17782C3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E98D8880E;
	Sun, 28 Jul 2024 21:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z+zQr07K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0C888703; Sun, 28 Jul 2024 21:36:21 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC31884C6
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4f50c673e83so857034e0c.0
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195378; x=1722800178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QF88284mjSfC4P3azVfw2BBT9hrZnSbkemR8axNzIB8=;
 b=Z+zQr07K45atOqb+/Ch0EOUpHCgdND/oL0bV9s/LmiU7jyS92oyzsV4GujUAab/Qmm
 2UMdQx5KiGcyQtAYnpnRqF3eoOn6HzjjKGCt/0bpN2A8up8UPBPadIX4FxT0FoIyJqrI
 6+4q/HuFXiz0WKLYS+1qAQghO2SMynuWY9J5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195378; x=1722800178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QF88284mjSfC4P3azVfw2BBT9hrZnSbkemR8axNzIB8=;
 b=r6Y8MhNlBHh2pRYez0LCF6Oc2AXDOOa5gt9qDoI9JE9uNucrKaR2ZZK+rvgAZ7unDh
 1qs6n/YJpo3sFhHiDAX7BfDSaLMiFMKsQj2EaDTx6uHVYhs/qlLHU5J1hip+gFWX5yTY
 uc2cmJQ7TvWN9qW6YJ3AUR2d6KKF0wuhBFhMhTrx7aPqSa3w7zEEx4yUBTQ/Sp6VB6dT
 OfSXapE18zW5jsWdn1+qywXz26TNzlDTJqiijXMhY4tKMI7nPAo6NpwxknIiH6fpDMnM
 nxAika9K71Z9FGfyWWGLocPk0KIK64ExmsdJnskEclGmLSGnSOQFvUS2sq9WFVI64g2k
 +8sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtsDv9fYaAj95rGHZ6J3xTNZwyoG3pum+CLKDZl6a3a15uFEW4a2foj0o2jvfm4Y99zZnBw0f9NGUY41D6F31RI7LpQQ==
X-Gm-Message-State: AOJu0YytTpsPLL5njjGD4K9BwxDLns86yt23PFZCd5z6gO1N0QR4Nw4G
 ndeWE94oAbE9N22XPTFxVJALJPIzVvFKzr/7Cu9+iXaXceUi4VUAFYcgi+No+2X1lHF1JLPKCm5
 dH7LJ1smyRzzZPnlG3nn4XExCbJwqJKTIgfNh
X-Google-Smtp-Source: AGHT+IFCovSgs9lr0Ff03wu9ReySKVelR3wptstuEM+g14bfx1guHilc07MnI1EMXGz+V20oFq38Un7dA780WrNfz8E=
X-Received: by 2002:a05:6122:3bd1:b0:4ef:65b6:f3b5 with SMTP id
 71dfb90a1353d-4f6e6980cdbmr6073481e0c.10.1722195378411; Sun, 28 Jul 2024
 12:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240726230035.2339680-1-mwalle@kernel.org>
In-Reply-To: <20240726230035.2339680-1-mwalle@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:07 -0600
Message-ID: <CAFLszTi2OAbzun0Rf68W4a8cNGCS3OvpqHtwAwryF9KwpcEOwQ@mail.gmail.com>
Subject: Re: [PATCH] boot: android: fix booting without a ramdisk
To: Michael Walle <mwalle@kernel.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
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

Hi Michael,

On Fri, 26 Jul 2024 at 17:00, Michael Walle <mwalle@kernel.org> wrote:
>
> android_image_get_ramdisk() will return an error if there is no ramdisk.
> Using the android image without a ramdisk worked until commit
> 1ce8e10f3b4b ("image: Fix up ANDROID_BOOT_IMAGE ramdisk code") because
> that return code wasn't checked. Now that it is checked, don't return an
> error in the (valid) case that there is no ramdisk in the image.
>
> With this, I'm able to boot a linux kernel using fastboot again:
>
>   fastboot --base 0x41000000 --header-version 2 --dtb /path/to/dtb \
>   --cmdline "root=/dev/mmcblk0p1 rootwait" boot path/to/Image
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  boot/image-android.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 09c7a44e058..0900579ee8c 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -395,7 +395,7 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>
>         if (!img_data.ramdisk_size) {
>                 *rd_data = *rd_len = 0;
> -               return -1;
> +               return 0;
>         }
>         if (img_data.header_version > 2) {
>                 ramdisk_ptr = img_data.ramdisk_addr;
> --
> 2.39.2
>

Rather than squashing the information here, you should return a value
that indicates there is no ramdisk. Normally in U-Boot this is
-ENOENT. Then the caller can check it. Also please update the function
docs in the header.

I see that -EINVAL is returned for some other error, so the caller
should be careful to just allow -ENOENT.

Regards,
Simon
