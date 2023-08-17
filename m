Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8F8C2FC27
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6086F86B5C;
	Thu, 17 Aug 2023 15:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dqU5C0fO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E3686B5B; Thu, 17 Aug 2023 15:42:52 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE9A86B64
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58de42f9f05so9047507b3.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279769; x=1692884569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pdU8Z5dmee57Zo/4NMZT4ogw3GXURF5xcUDYLEHdNDo=;
 b=dqU5C0fOr1TIzXyDn7r+czW65YkDU/3kGLXFkDMFpDRACXcFfKY22/M+98xO+XrL38
 jSd2MHJsQMKo1G+L9kTTY8xaxnkly9QJNzrrrRzc8MzD9Ge80AMgKOV5odi9BwR0/jAv
 6LR8RIIjG052TOxqHBaeTIc3wynGnRBLSvris=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279769; x=1692884569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pdU8Z5dmee57Zo/4NMZT4ogw3GXURF5xcUDYLEHdNDo=;
 b=Ucqogqp22SbIU4c8BLbKCTohyrmduSRj95EwjPRO1zuyH9CqmOhm2g/ecHG/bXk/un
 +6O1nbWTb0vgiPCwhtzcpABBUhG7fnFLkBRhAYdpgcQ0rj4oM67nAyTO2Zq9HkNuucOV
 /mep3GUKg/8ZHaAf5sf4F0ZYolM3OqzWgZnQeGM6CD9PpryBwLoP539oDKa9N/+txCaF
 cES6FuaOUqa2vJzH7UJhfShxtUsv+Cevh2lX9BUywZf8V6Mzk7oD43h+eRrsgIjTnwMS
 VjGBFe8Zx82VQ7CAGB7bgZNOEQu2siSdhKfQ3rKRYhIUd43q6QNiEas/yiZf9NX1QxGw
 y/cw==
X-Gm-Message-State: AOJu0YxVoCbL+2AiwzEJiXfGM+M0gYoEp0xEkEe4+74arZ9OxbtAXpE7
 3tYzBCOr7+AfoCZKAIy4B//7Hx98GPzvarfJyWLkCw==
X-Google-Smtp-Source: AGHT+IGQWU5jLAMOC7AwIpH71nvgwhsqVlXmWaRC6oqDKkwYA3luCncCJlBOy4DsoKNpJO41RTJ8H5/CMy9u7lyM+Nw=
X-Received: by 2002:a25:cf0e:0:b0:c86:a5b6:cdff with SMTP id
 f14-20020a25cf0e000000b00c86a5b6cdffmr5292960ybg.19.1692279768679; Thu, 17
 Aug 2023 06:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
 <20230812002823.82576-5-seanedmond@linux.microsoft.com>
In-Reply-To: <20230812002823.82576-5-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:41:46 -0600
Message-ID: <CAPnjgZ3ycQ+_brkZ5Q87jgpticeFTF=QQe-iiqR045QMim6AJw@mail.gmail.com>
Subject: Re: [PATCH 4/5] common: Add OS anti-rollback grace period
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
> From: Stephen Carlson <stcarlso@microsoft.com>
>
> New config CONFIG_FIT_ARBVP_GRACE to add a one unit grace period to OS
> anti-rollback protection, allowing images with anti-rollback counters
> exactly one less than the platform value to still be loaded. No update to
> the platform anti-rollback counter will be performed in this case.

This seems like a grace version rather than a grace period? I'm not
sure if that is a better name, but I might imagine a grace period of
one month, for example.

>
> Signed-off-by: Stephen Carlson <stcarlso@microsoft.com>
> ---
>  boot/Kconfig         | 10 ++++++++++
>  boot/image-fit-sig.c |  7 ++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index e08c274b7c..cd16bb8e53 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -112,6 +112,16 @@ config FIT_ARBP
>           when a platform needs to retire previous versions of FIT images due to
>           security flaws and prevent devices from being reverted to them.
>
> +config FIT_ARBP_GRACE
> +       bool "Enable FIT Anti rollback grace period"
> +       depends on FIT_ARBP
> +       default n
> +       help
> +         Enables a one unit grace period for FIT image anti-rollback protection,
> +         where anti-rollback protection will still accept a FIT image with an
> +         anti-rollback version one less than the current number, but will not
> +         update the platform anti-rollback counter in that case.
> +
>  config FIT_VERBOSE
>         bool "Show verbose messages when FIT images fail"
>         depends on FIT
> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> index bf3b81a3a3..dc88a4b2cb 100644
> --- a/boot/image-fit-sig.c
> +++ b/boot/image-fit-sig.c
> @@ -70,6 +70,7 @@ static int fit_image_verify_arbvn(const void *fit, int image_noffset)
>  {
>         u64 image_arbvn;
>         u64 plat_arbvn = 0ULL;
> +       u64 target_arbvn;
>         struct udevice *dev;
>         int ret;
>
> @@ -85,7 +86,11 @@ static int fit_image_verify_arbvn(const void *fit, int image_noffset)
>         if (ret)
>                 return -EIO;
>
> -       if (image_arbvn < plat_arbvn) {
> +       target_arbvn = plat_arbvn;
> +       /* Calculate target ARBVN, including grace period if enabled */
> +       if (CONFIG_IS_ENABLED(FIT_ARBP_GRACE) && plat_arbvn > 0ULL)

> 0

> +               target_arbvn = plat_arbvn - 1ULL;
> +       if (image_arbvn < target_arbvn) {
>                 return -EPERM;
>         } else if (image_arbvn > plat_arbvn) {
>                 ret = dm_security_arbvn_set(dev, image_arbvn);
> --
> 2.40.0
>

Regards,
Simon
