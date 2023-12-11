Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972DBC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177B3877B0;
	Mon, 11 Dec 2023 18:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YAHJO2rp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BEB287796; Mon, 11 Dec 2023 18:53:12 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CBC1877A8
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-db979bbae81so3645280276.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317185; x=1702921985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O95U9jTlxYAefgSvkh8dskhNv4Ab9ZO/fQ12FLWvgb4=;
 b=YAHJO2rp7O7BfmxKBpbNYVYB+1pKIGHuf3ZaUsTA0CguuK/TlnM4Ps7oApZSTb804L
 XTVKhvg6XU9dD5ruUX3Y6CpSCAH6GLozkmUWA2Wyw8QZRIAxBnFrMQuafqLlrQnCMdJZ
 Tze6UWhs5vZL30Y9txEXwa2QdZyaTKJXKYfng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317185; x=1702921985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O95U9jTlxYAefgSvkh8dskhNv4Ab9ZO/fQ12FLWvgb4=;
 b=rb0YWFQLwZz6zTPZS2gEp2UbdA/lsSuHESz3apG19DQpcQJn1S6LtxErlYnFysGceX
 eLvEyUbDPyCgnV5H+2mkBw+RpKd32i3rGUtUzGq7UpKVsJqVvqHI24BjU4toBAlDZSVo
 lDBZ/9b6hZlu5iV60gQwmE6jfMDeWQcoWR2HUj2Dr7naoJckJWkcsmzqPr0j3h+GZDFP
 o2ygZOo9KVXzhF43LP9lwrUIfqsNgdmShyM/NMQedIbx7I1Ezm/aFRSrlxbSSELM7LCq
 T41JlyK30iyYnPU/2ZDyuM06LlzB+y7smo0PLfYuD+6UAO//vsyej+F2v1ckpBBe1szW
 q3ww==
X-Gm-Message-State: AOJu0Yw1jjkh1DxXx4i2rlWWup1LZIZ7n/1+LhqisSIZZLzsvtoT3pOp
 uUXx+kM9plY/LxjeLFhZyowprEWxu4TyJD8/ZD3iqg==
X-Google-Smtp-Source: AGHT+IE2xwVguDMKfG7VWw43veW4MbHHjsRY1uMYDJyole/KgsxtIYSBWlGF/qIRn+cQxBqgbshvgwdc9iI+aT8dCJw=
X-Received: by 2002:a25:ac46:0:b0:dbc:afb3:84c4 with SMTP id
 r6-20020a25ac46000000b00dbcafb384c4mr638286ybd.110.1702317184840; Mon, 11 Dec
 2023 09:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20231210150304.124458-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231210150304.124458-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:25 -0700
Message-ID: <CAPnjgZ10dpyK3qyoogTaabyH0sNsXRZReCGdvVhdO=0LG2DJWw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: Poll CD in case cyclic framework is enabled
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

On Sun, 10 Dec 2023 at 08:03, Marek Vasut
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
> ---
>  drivers/mmc/mmc.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/mmc.h     |  5 +++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index eb5010c1465..a5686dbc12e 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -2985,6 +2985,22 @@ static int mmc_complete_init(struct mmc *mmc)
>         return err;
>  }
>
> +#if CONFIG_IS_ENABLED(CYCLIC)
> +static void mmc_cyclic_cd_poll(void *ctx)
> +{
> +       struct mmc *m = ctx;
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
> +#endif
> +
>  int mmc_init(struct mmc *mmc)
>  {
>         int err = 0;
> @@ -3007,6 +3023,19 @@ int mmc_init(struct mmc *mmc)
>         if (err)
>                 pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
>
> +#if CONFIG_IS_ENABLED(CYCLIC)

We really shouldn't be adding new #ifdefs to the code.

If you really want to make put ->cyclic behind an #ifdef then how
about creating an accessor as is done in global_data.h ?

> +       if (!mmc->cyclic) {
> +               /* Register cyclic function for card detect polling */
> +               mmc->cyclic = cyclic_register(mmc_cyclic_cd_poll, 100 * 1000,
> +                                             mmc->cfg->name, mmc);
> +               if (!mmc->cyclic) {
> +                       printf("Failed to register %s CD poll function\n",
> +                               mmc->cfg->name);
> +                       err = -EINVAL;
> +               }
> +       }
> +#endif
> +
>         return err;
>  }
>
> @@ -3014,6 +3043,13 @@ int mmc_deinit(struct mmc *mmc)
>  {
>         u32 caps_filtered;
>
> +#if CONFIG_IS_ENABLED(CYCLIC)
> +       if (mmc->cyclic) {
> +               cyclic_unregister(mmc->cyclic);
> +               mmc->cyclic = NULL;
> +       }
> +#endif
> +
>         if (!CONFIG_IS_ENABLED(MMC_UHS_SUPPORT) &&
>             !CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) &&
>             !CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
> diff --git a/include/mmc.h b/include/mmc.h
> index 1022db3ffa7..4256d5567ef 100644
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
> @@ -739,6 +740,10 @@ struct mmc {
>         u8 hs400_tuning;
>
>         enum bus_mode user_speed_mode; /* input speed mode from user */
> +
> +#if CONFIG_IS_ENABLED(CYCLIC)
> +       struct cyclic_info      *cyclic;
> +#endif
>  };
>
>  #if CONFIG_IS_ENABLED(DM_MMC)
> --
> 2.42.0
>

Regards,
Simon
