Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209B2EE49BC
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 15:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D891892C4;
	Wed, 11 Sep 2024 17:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cn4ZVMO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA18892C5; Wed, 11 Sep 2024 17:06:34 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84AB688ED7
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6c34dd6c21aso14783256d6.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726067189; x=1726671989; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=70A8IKpDsGwV5D+bLlAAl6IPOikF7m3iMwT/nLBRefU=;
 b=cn4ZVMO70r08iQiVgZ4rmTwXaPWVc8lrNPloKnZfaI4xcPwcDNCQ/hZ9JM/21HNJNd
 7qxNN5U0YDTo9kIM9ep4w3EkpG3A0+YOO/U/3jP7jLojHhl4bcwNbZlihTYUsgQQi5B6
 nefb62A5Vl79nBDZNb0fBy8QNP1sX1VvIxXG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726067189; x=1726671989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=70A8IKpDsGwV5D+bLlAAl6IPOikF7m3iMwT/nLBRefU=;
 b=o7WpIJM4Ek5GnbPDRZqyLQEhBQ+CyBwAUxcHbnwP4L+8++sHjvjxV2OIxoP9I0W7KC
 H++64zqP4D4yrDoNY2G46Hm2ZNvIe4jrTqOWYgqsZNUSrnz8uk2vdQWqvCHKmgt9YFGN
 C3flx+Hzh5EAR4CIgsc7UYE5bCh9XvZHH0i/FCVCLptfL3avJYVnBIWl1KK7YSvzhoiG
 3OfyevchwIBd3iqGbUHKDgTLuTxgujP+0cwByZFLhZfPyGWFmF9dTTC/TrzIwcTxxXAd
 dtSN8wu702vvOdFz7sG/WUGMtGzIe26nW4ssDm0cduRHRZ5BVX3NUlohl8hZGwzRQv1W
 vpdQ==
X-Gm-Message-State: AOJu0Yx5x2zAihvx/Olsydk03pHmRzDiyZanxGqmGXzvgov5+54APpR/
 4B4/MCNotAjoQl+onPICGVjLiEo0Z8a8D8y9duAFvYw3gMpjoCCBRZbP4H/cBKplXX9sJAEpqkV
 vENevG77OmwB/R+pw/hKDFGZ3Vy6zA/2FJreL
X-Google-Smtp-Source: AGHT+IEpc4vSUzSUbv8T/o2KJTzhXUZ1CHBRBCNdg3yexdF/vD8Jl0OA2dsy7DLc03Ek2dXXZvWiVE7y6yU9fbU2/yw=
X-Received: by 2002:a05:6214:5248:b0:6c5:e40:2540 with SMTP id
 6a1803df08f44-6c55fa0b60emr48016346d6.26.1726067189272; Wed, 11 Sep 2024
 08:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 09:06:18 -0600
Message-ID: <CAFLszTg18NGg8hfwPzc3qBEH+m6XG2OmzZqqZJvd-OLm_j++qw@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: Poll CD in case cyclic framework is enabled
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>
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

On Fri, 6 Sept 2024 at 11:11, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> In case the cyclic framework is enabled, poll the card detect of already
> initialized cards and deinitialize them in case they are removed. Since
> the card initialization is a longer process and card initialization is
> done on first access to an uninitialized card anyway, avoid initializing
> newly detected uninitialized cards in the cyclic callback.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: Move the cyclic registration/unregistration into mmc init/deinit
> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
>     does not work with structure members
> V4: Stuff the code with CONFIG_IS_ENABLED() variants to avoid #ifdefs
> V5: Rebase on u-boot/next
> V6: Rebase on u-boot/next
> ---
>  drivers/mmc/mmc.c | 25 +++++++++++++++++++++++++
>  include/mmc.h     |  3 +++
>  2 files changed, 28 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Some things below to do now or later.

> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 0b881f11b4a..c787ff6bc49 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -3039,6 +3039,20 @@ static int mmc_complete_init(struct mmc *mmc)
>         return err;
>  }
>
> +static void __maybe_unused mmc_cyclic_cd_poll(struct cyclic_info *c)

Add a comment here to explain what is going on - e.g. stuff from your
comment message.

> +{
> +       struct mmc *m = CONFIG_IS_ENABLED(CYCLIC, (container_of(c, struct mmc, cyclic)), (NULL));
> +
> +       if (!m->has_init)
> +               return;
> +
> +       if (mmc_getcd(m))
> +               return;
> +
> +       mmc_deinit(m);
> +       m->has_init = 0;
> +}
> +
>  int mmc_init(struct mmc *mmc)
>  {
>         int err = 0;
> @@ -3061,6 +3075,14 @@ int mmc_init(struct mmc *mmc)
>         if (err)
>                 pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
>
> +       if (CONFIG_IS_ENABLED(CYCLIC, (!mmc->cyclic.func), (NULL))) {
> +               /* Register cyclic function for card detect polling */
> +               CONFIG_IS_ENABLED(CYCLIC, (cyclic_register(&mmc->cyclic,
> +                                                          mmc_cyclic_cd_poll,
> +                                                          100 * 1000,
> +                                                          mmc->cfg->name)));
> +       }
> +

This seems a bit confusing. How about:

if (CONFIG_IS_ENABLED(CYCLIC) && !cyclic_mmc->cyclic.func)

then in cyclic.h something like

static inline bool cyclic_valid(struct cyclic *cyc)
{
#if CONFIG_IS_ENABLED(CYCLIC)
    return cyc->func;
#else
    return false;
#endif
}

We really should not have clients looking at the 'func' to decide if
something is active.

You can also turn cyclic_register into a macro (empty if cyclic not
enabled) to avoid the problem of ->cyclic not existing.

>         return err;
>  }
>
> @@ -3068,6 +3090,9 @@ int mmc_deinit(struct mmc *mmc)
>  {
>         u32 caps_filtered;
>
> +       if (CONFIG_IS_ENABLED(CYCLIC, (mmc->cyclic.func), (NULL)))
> +               CONFIG_IS_ENABLED(CYCLIC, (cyclic_unregister(&mmc->cyclic)));

Same comment here.

> +
>         if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
>             !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
>             !CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
> diff --git a/include/mmc.h b/include/mmc.h
> index f508cd15700..0044ff8bef7 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -14,6 +14,7 @@
>  #include <linux/sizes.h>
>  #include <linux/compiler.h>
>  #include <linux/dma-direction.h>
> +#include <cyclic.h>
>  #include <part.h>
>
>  struct bd_info;
> @@ -757,6 +758,8 @@ struct mmc {
>         bool hs400_tuning:1;
>
>         enum bus_mode user_speed_mode; /* input speed mode from user */
> +
> +       CONFIG_IS_ENABLED(CYCLIC, (struct cyclic_info cyclic));
>  };
>
>  #if CONFIG_IS_ENABLED(DM_MMC)
> --
> 2.45.2
>

Regards,
Simon
