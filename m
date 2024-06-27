Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB037C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B9B8852E;
	Thu, 27 Jun 2024 10:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i/4UCHuT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 842218852D; Thu, 27 Jun 2024 10:37:28 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2928A88549
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b56000f663so14312606d6.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477444; x=1720082244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pV3KqqS48+UWll0HtYqn95RtsL2CxRFyOSSoLP//l3w=;
 b=i/4UCHuT7AsU6T3JtxyqAZqiGNWM+P6aSNbyr3kaT0ZIRhek7CC/eQcCwoISHQt6MO
 c1FAxIOTg+HtIvWGSRFA57LwSBjN2Ojrr3b/xBi31fEzKv5nvPrzGB67EH8LFRyojRqB
 FUv+iStcBDNFdvpQvxoMehf2RLlia1ZlD8Z/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477444; x=1720082244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pV3KqqS48+UWll0HtYqn95RtsL2CxRFyOSSoLP//l3w=;
 b=PkDDKBzv+r9IvHxIanDFSXXTODrV57Hns8OhEZBuXO1C8cPLLrnhc9nYFZlU4omf+t
 YVdNkopqV/6fwkWutVTA9cgqcVX6MpNJZtuQHQdd4Yw15PMB2NhcTtD0CdSXNE4m1em6
 wwOV4pzRrisQoPZOFnfuQyjyaKhEEDf+PXW0kHlnNcYjU+YIux4UUL0s7FG5joealZU/
 MJGndZ64KO5Z2OYBIDVopeYlmjt4XRyMx8K/iUUaATyUlfBUz03Uu1BGn9G/IvG1Ry4e
 hjIn/ZU1vj3xA1rO8aoh/m9b4H3xLo5K7uxG164I/uZLX55PmP+RprYwirr5WGAzoWs5
 ENew==
X-Gm-Message-State: AOJu0Yx6sFWDW6rXrnLz3JhFkSNt9NcUhaAD40NXjjlRLUAJn4mtHBXr
 4OpVrMetI3j8e90DinnnvcGfMPMdgnRGq2OCSw1xcXHtKta0+8jnO2mS6IepuTSDwoD+LKMWmAG
 qZJeqntRan/erKKOR7jBFzXQot8SAveg4tbdv
X-Google-Smtp-Source: AGHT+IEe6dvy3dMSxXV9o2TrkIxWDOnEEsfTu5m9dwO152IZU2iGHK5JRL5HBlSMSti5g8A19DYsEXiivNJv8PjkUfM=
X-Received: by 2002:a05:6214:27c5:b0:6b5:7f22:d7c7 with SMTP id
 6a1803df08f44-6b57f22da77mr50608556d6.65.1719477444014; Thu, 27 Jun 2024
 01:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235857.272264-1-marex@denx.de>
In-Reply-To: <20240626235857.272264-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:37:13 +0100
Message-ID: <CAFLszTjskBvo9j=34sMHQgSy6LVwBGhYSAqt4s06H_-AFvdZ_A@mail.gmail.com>
Subject: Re: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Thu, 27 Jun 2024 at 00:59, Marek Vasut <marex@denx.de> wrote:
>
> Insert /u-boot,<dto-name> = <index> property into the U-Boot control DT
> during SPL DTO application process. This can be used by user to inspect
> which DTOs got applied by the SPL and in which order from running U-Boot.
>
> Example:
> ```
> u-boot=> fdt addr $fdtcontroladdr && fdt list /
> Working FDT set to aee9aeb0
> / {
>         u-boot,fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 = <0x00000005>;
>         u-boot,fdt-dto-imx8mp-dhcom-som-overlay-rev100 = <0x00000004>;
>         u-boot,fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast = <0x00000003>;
>         u-boot,fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast = <0x00000002>;
> ...
> ```
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Suniel Mahesh <sunil@amarulasolutions.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
>  common/spl/spl_fit.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 988125be008..261b72419b1 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -363,6 +363,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>  {
>         struct spl_image_info image_info;
>         int node, ret = 0, index = 0;
> +       char dtoname[256];
>
>         /*
>          * Use the address following the image as target address for the
> @@ -450,7 +451,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>
>                         /* Make room in FDT for changes from the overlay */
>                         ret = fdt_increase_size(spl_image->fdt_addr,
> -                                               image_info.size);
> +                                               image_info.size + strlen(str));

You may also need space for the string terminator (i.e. add 1 more byte).

>                         if (ret < 0)
>                                 break;
>
> @@ -464,6 +465,26 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>
>                         debug("%s: DT overlay %s applied\n", __func__,
>                               fit_get_name(ctx->fit, node, NULL));
> +
> +                       /*
> +                        * Insert /u-boot,<dto-name> = <index> property into
> +                        * the U-Boot control DT. This can be used by user
> +                        * to inspect which DTOs got applied by the SPL from
> +                        * a running U-Boot.
> +                        */
> +                       snprintf(dtoname, sizeof(dtoname), "u-boot,%s", str);
> +                       ret = fdt_setprop_u32(spl_image->fdt_addr, 0, dtoname,
> +                                             index);
> +                       if (!ret) {

This means there was no error, right?

> +                               /*
> +                                * The DTO itself was applied, do not treat the
> +                                * insertion of /u-boot,<dto-name> as an error
> +                                * so the system can possibly boot somehow.
> +                                */
> +                               debug("%s: DT overlay %s name not inserted into / node (%d)\n",
> +                                     __func__,
> +                                     fit_get_name(ctx->fit, node, NULL), ret);
> +                       }

log_debug()

>                 }
>                 free(tmpbuffer);
>                 if (ret)
> --
> 2.43.0
>

Regards,
Simon
