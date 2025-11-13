Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310AECD98D0
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B922284014;
	Thu, 13 Nov 2025 20:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EsAJ9/88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF0084014; Thu, 13 Nov 2025 20:33:57 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB6184015
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-341988c720aso1051519a91.3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763062434; x=1763667234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KKS3ZOKelOfMRW8CVN/ynAi9vYcTh7nzwCkxYOxlw+Y=;
 b=EsAJ9/88fEG/jXBL2fOHgbQ0+mZCV7XW1o59W/0H8DcCbdMJa0ltrtnhIz7y0KLl/b
 TSqZ13oDjUjprECvUtG5JeG9xOUicAnKiA73iU0T47YEKo2ZbT3KvmCJALc5KP0GGk1/
 2uXrgIKmAPT2U0daNuBx6CcNbwTaghZLP2q9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763062434; x=1763667234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKS3ZOKelOfMRW8CVN/ynAi9vYcTh7nzwCkxYOxlw+Y=;
 b=OXM8bwbS+oKnANLEDge/sZjg2X0aQ0Dji9HWY0a65JBcfXiV9M94jmJkiQzrpwgVIX
 KV4LxMRa1THda9SDv3ssBYBECiSbihmFSiG8M9UbeV8K9hjRg/YWomMOum/YnF1Kkfo9
 I82l/iyydPm/ykUolmW9rjUs3QdiQ7ygrpD4LzILnsNEfdjNFiNoU1wva5R8FBqqmKbJ
 iGJUF/ffcKYPAXRkV8p3YgluuFRq2DJTM8WAIzv2swpzVos6DHdtdz8cOs/Zy/cXn7mh
 PH187VS2GkzcJ8Fzsui2D6mVD+vbgVFepWpf6XA1j8bRHxX1MQ84yEh/Aq7yV9ecPRza
 3xqA==
X-Gm-Message-State: AOJu0Yzd6xWxFM3xxa+e8RUqm2sARun0QOB4pk2/+GduSfgKNORG/xHW
 9RBFg7nNohssFYQ8PMzdssp0qTY7QYI86j1KU5iDbVLIjNZE2sXkhf0ZYcUVNj9kL1p8BXOQ+LB
 TLfnDPigJrNnEbCo0fMlhJGHv4ZY9kHXMcGfpUp3YLzo/nYUMaIs=
X-Gm-Gg: ASbGncvB+QvJVNOG6KCUsd+zKYYT4vJp5iSWSDdTlZzmyMkMR1gfkxque9m5fxqVHBW
 xhmuYWDNvJbgYQaQlBguGuu0DOC37xfkvi4kurzW//YpnLRRj5ogp+hWdAduHN9tEJLY1tQ2xN7
 M2gK6/q0emmeUNz0/CLPfVparHNmOHAM94jBSm5r4EYWkFlVpzW4V45XMNW6nouh6f/tRTuF+3V
 tFtG8g+d3QnkK4VNaF6/5W20cRe982995C6GDNcGLCyr8qeQ9Fd9pM0NUfrhe7H8tGbLIZnkzLS
 O4XQ
X-Google-Smtp-Source: AGHT+IHf0MHfy7phILdUlBKoiKNnOB+KyMhjzrbjXEXAlj5sCVBiShEFBhQ8NepN7x1EWzSDZggEOyGpyQ1sp2BlucI=
X-Received: by 2002:a17:90a:c2c7:b0:341:8bda:d0ae with SMTP id
 98e67ed59e1d1-343fa63366emr418329a91.20.1763062434113; Thu, 13 Nov 2025
 11:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 12:33:12 -0700
X-Gm-Features: AWmQ_bkorSq-5J_CN8gLgp5uR5nFsft-wM0uyLQdlw9JEPFO7kWEc7IZj-wxwto
Message-ID: <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

Hi Marek,

On Thu, 13 Nov 2025 at 04:55, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The fitImage may contain FDT at 4-byte aligned address, because alignment
> of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
> 8-byte aligned address. Make sure that the DTs embedded in fitImages are
> always used from 8-byte aligned addresses. In case the DT is decompressed,
> make sure the target buffer is 8-byte aligned. In case the DT is only
> loaded, make sure the target buffer is 8-byte aligned too.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> Cc: u-boot@lists.denx.de
> ---
>  boot/image-fit.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 2f2d3e9304d..cccaa48f683 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -23,7 +23,6 @@
>  #include <log.h>
>  #include <mapmem.h>
>  #include <asm/io.h>
> -#include <malloc.h>
>  #include <memalign.h>
>  #include <asm/global_data.h>
>  #ifdef CONFIG_DM_HASH
> @@ -36,6 +35,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  #include <bootm.h>
>  #include <image.h>
>  #include <bootstage.h>
> +#include <malloc.h>
>  #include <upl.h>
>  #include <u-boot/crc.h>
>
> @@ -2279,7 +2279,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>
>                 log_debug("decompressing image\n");
>                 if (load == data) {
> -                       loadbuf = malloc(max_decomp_len);
> +                       loadbuf = memalign(8, max_decomp_len);
>                         load = map_to_sysmem(loadbuf);
>                 } else {
>                         loadbuf = map_sysmem(load, max_decomp_len);
> @@ -2291,6 +2291,11 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>                         return -ENOEXEC;
>                 }
>                 len = load_end - load;
> +       } else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
> +                  ((uintptr_t)buf & 7)) {
> +               loadbuf = memalign(8, len);
> +               load = map_to_sysmem(loadbuf);
> +               memcpy(loadbuf, buf, len);
>         } else if (load != data) {
>                 log_debug("copying\n");
>                 loadbuf = map_sysmem(load, len);
> --
> 2.51.0
>

We really can't do a memory allocation in fit_image_load() !

The problem should be fixed higher up, in its callers, etc. For one
thing, the caller knows whether it is a DT or not, so putting this
logic here is messy. See boot_get_fdt_fit()

Regards,
Simon
