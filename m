Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CC9C3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A13887F5;
	Sun, 28 Jul 2024 21:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XhxsMwQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BC288795; Sun, 28 Jul 2024 21:36:20 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD8F886F3
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b78c3670d0so14235506d6.1
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195377; x=1722800177; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mp+PeHAvgzgML4JuMLRlg4ilQZC2NM+FcSAFTsTDxrs=;
 b=XhxsMwQBd43b7VvM24hY/L1/cNUt1dkaj9ubHBonNT8X1YjbqZwI62Qmq4Mjc5iaEG
 eLN+fYGDpa1tCKfXSAqs971UZNjAmLmjDObctM34SugjNCikEaVAb4i2llMcUJy6d3dl
 mFBVxlwYe8YJ3KFwpjFJEKTg73y2cDPTmQ6CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195377; x=1722800177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mp+PeHAvgzgML4JuMLRlg4ilQZC2NM+FcSAFTsTDxrs=;
 b=hMEYRF7oJFMO68rsBisI5UhrB83x/pLJhw+ov3Ne3KVukLA4/p56LmxbOSTMWJZ5kY
 71gTnvvSnVOXPP8DdRulXAey74sQQw7CbEG/4Evy7xgToGVBtQ/1KhAqEo87hiDofbCG
 SaAU0GpcQhdOBoS22oFE9W8Bc/QnTsqQofUk44NTAWHMNsUVe0YPafHofY8vaf3PcvRd
 si4Yr1OcHsHFURzfjsSUcs2kX900Jb9OZDUCcd6DuWP980ajwxIAL02Gqy3oVRY4Qdt7
 qlHDYDPNpw+aqoCxX4UM9RhZrC5JhifU1n1yStzKiXpQ79jdlo1oGIyf69txmxiZqgrZ
 ZQhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSbDqApjwG/IlPVBuc7cdMW5PpcK9RGAuPHqDlQ9BpYOSwfhTDGwQPlVibKOgysb+OQe1CYyZj8nrUHo0q09zWQ5+unw==
X-Gm-Message-State: AOJu0YynVAkS6WKpsRdXnTYEK3Xz/oPMJB2Me6QwczokhYhYgCBrCpwR
 8ZAlvqbT3DPlsJG5C8GtIK7A2iNOREaZ4oYPSk+iqPDAl9lwRcOQkoE1NT5t2lnTUmv9txNxNGI
 kF0AMLRKYGrN8QR2SMwrzBUsyV48RkAfMpHKO
X-Google-Smtp-Source: AGHT+IFjNj7lbYmajQhmdWsTjb3gTjEDdS8NccsZdkJGN6V8ZwvrHhCxvL1EW86S9Z+uLD8D7YKykMtS1VJuVTIderM=
X-Received: by 2002:ad4:5c44:0:b0:6b5:de3b:dc10 with SMTP id
 6a1803df08f44-6bb55aba971mr103076446d6.35.1722195377537; Sun, 28 Jul 2024
 12:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-5-ddrokosov@salutedevices.com>
In-Reply-To: <20240725194716.32232-5-ddrokosov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:06 -0600
Message-ID: <CAFLszTiYyz-oa2vJUjsLj6auL8hU1XqfFw7fwPRP2++9akR02A@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] common: android_ab: fix slot suffix for abc block
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, trini@konsulko.com, colin.mcallister@garmin.com, 
 4.shket@gmail.com, avromanov@salutedevices.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com, rockosov@gmail.com
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

Hi Dmitry,

On Thu, 25 Jul 2024 at 14:55, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> To align with the official Android BCB (Boot Control Block)
> specifications, it's important to note that the slot_suffix should start
> with an underscore symbol.
>
> For a comprehensive understanding of the expected slot_suffix format in
> userspace, please refer to the provided reference [1].
>
> Links:
> [1] - https://source.android.com/docs/core/architecture/bootloader/updating#slots
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  boot/android_ab.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

(can the test cover this?)


>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index 359cc1a00428..45c154b10f1a 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -53,7 +53,7 @@ static int ab_control_default(struct bootloader_control *abc)
>         if (!abc)
>                 return -EFAULT;
>
> -       memcpy(abc->slot_suffix, "a\0\0\0", 4);
> +       memcpy(abc->slot_suffix, "_a\0\0", 4);
>         abc->magic = BOOT_CTRL_MAGIC;
>         abc->version = BOOT_CTRL_VERSION;
>         abc->nb_slot = NUM_SLOTS;
> @@ -319,7 +319,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>                  * or the device tree.
>                  */
>                 memset(slot_suffix, 0, sizeof(slot_suffix));
> -               slot_suffix[0] = BOOT_SLOT_NAME(slot);
> +               slot_suffix[0] = '_';
> +               slot_suffix[1] = BOOT_SLOT_NAME(slot);
>                 if (memcmp(abc->slot_suffix, slot_suffix,
>                            sizeof(slot_suffix))) {
>                         memcpy(abc->slot_suffix, slot_suffix,
> --
> 2.43.0
>
