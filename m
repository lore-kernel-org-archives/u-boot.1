Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB760CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6166186F13;
	Thu, 12 Oct 2023 05:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YoE1lG1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F14D786E5B; Thu, 12 Oct 2023 05:45:29 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE2C86E1F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59e88a28b98so4162787b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082305; x=1697687105; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7CapNJkHOXHBXD/0GHB23tKTxdLmgi5G4nwKssO3VM=;
 b=YoE1lG1ma46tUm9m4SSRUIr4kL2PuL8VoyqG3hQLHaIZO98Zt9zgqdh+wB3TauxTVB
 vG/Ip83TX7DMT2u1PuXhMViFy202FwElNTSPyPaWPhvj27kwYEDBSRM+KUCUNgCEF68x
 Ibp+HadXgIHPvqcgM71XObUT52CJsquzICN7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082305; x=1697687105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q7CapNJkHOXHBXD/0GHB23tKTxdLmgi5G4nwKssO3VM=;
 b=eob0U7xebuPueB5UZOBzgIMMthqTALqDccNbNtscmIPL/cGMoxo2cNXQEnjD7bDvM9
 eTBp2DdqbTmuYvtxVJew8HVlxQXNSW+EsmVRCv3oxtsVHLdj8tZfTd/jhk4lf+cgaBT5
 esE+020PDqHX75SIQBeuQMRx614BE+9FjNREN+Ih1V8eC1dPLq5Qr0DB2QJU1CefAMJR
 21OhQPSoUB+2AgMCiCIXiB/64CGvagu8emRye4W12H0nb4WlOG2Pp2Kt4tm09kHdEWHL
 EYl4W0HPbN1JaIcCVCj4jQYZr9FzoMMcUu7XQjt4f9RTUn+7W3FTqMc9o8KixXlsmslw
 2ygg==
X-Gm-Message-State: AOJu0YzfM9Y2AMhHgaSQ+McNu5Q8dqLX2XojDP5G/If8ZyZXAueC/2Sk
 4ApXnM2vISp0mm1mImTt11yH5aS+0qk8SsJDlnwpTLsonGz1mGsmY14=
X-Google-Smtp-Source: AGHT+IEKZNs5DPDJNEvKVhxoXe+VkdBT8LrxBKauT9wKVPhJew5ghbWEDPd1wHkHJrm7Aud4WSlegQI/N8sXk3/+LX4=
X-Received: by 2002:a81:a155:0:b0:5a7:fb66:61ff with SMTP id
 y82-20020a81a155000000b005a7fb6661ffmr556476ywg.21.1697082305242; Wed, 11 Oct
 2023 20:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-4-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-4-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:23 -0700
Message-ID: <CAPnjgZ2RWZZbQMfF9_KUN+FsoVGoHKPq_sJ9=1GorNkrftwmbA@mail.gmail.com>
Subject: Re: [PATCH 03/26] spl: fit: Fix entry point for SPL_LOAD_FIT_FULL
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marex@denx.de>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> The entry point is not always the same as the load address. Use the value
> of the entrypoint property if it exists and is nonzero (following the
> example of spl_load_simple_fit).
>
> Fixes: 8a9dc16e4d0 ("spl: Add full fitImage support")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  common/spl/spl_fit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

The check for 0 makes me uneasy, but I can't imagine it being valid in practice.


>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index ce6b8aa370a..e3cdf8e5c05 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -884,8 +884,10 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
>                 return ret;
>
>         spl_image->size = fw_len;
> -       spl_image->entry_point = fw_data;
>         spl_image->load_addr = fw_data;
> +       if (fit_image_get_entry(header, ret, &spl_image->entry_point) ||
> +           !spl_image->entry_point)
> +               spl_image->entry_point = fw_data;
>         if (fit_image_get_os(header, ret, &spl_image->os))
>                 spl_image->os = IH_OS_INVALID;
>         spl_image->name = genimg_get_os_name(spl_image->os);
> --
> 2.37.1
>
