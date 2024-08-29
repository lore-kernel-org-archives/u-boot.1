Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E3CC83F26
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B0AD88C67;
	Thu, 29 Aug 2024 16:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jlmEUH+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDF188C69; Thu, 29 Aug 2024 16:06:01 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74B1988C86
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5dc93fa5639so404204eaf.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940355; x=1725545155; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HM7lAlFrQd5TSqUe7L0Xh4BQPf4zoK8a4yOS4kirctg=;
 b=jlmEUH+61qLFf6ht55T0CgGw7BzA5ZzuZUW+MOpwiiN8RgRnwd+9AmGPrYyzO0J/BF
 L42ArxjjReMZqHpquCxWcf8bFbL80vkTbvVVGyZJLlMHXsiruF9RySVnQRO50nZX7aLV
 Kcs6kDqMBiMIYIDqw660jJuKYjwWaXj98F37g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940355; x=1725545155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HM7lAlFrQd5TSqUe7L0Xh4BQPf4zoK8a4yOS4kirctg=;
 b=qmP2KyCKOYuZ+kGkNBWVfBtwNPksjteir/DrinvxdmIrIBd7m4T/CHJwVpzJwNFMsr
 m8rwpqzv4XJLmwe1+eV+chn7bymBaNQQTlkqQL7+SVznJMDAQZc0ct8fzpfw+8doq7SQ
 SszwBbqocsV/M4yo99ZLq1uXWB5vpKEqpseECovzJBcubTzKZ3jzPlfrTanSZUgdhfyh
 7wcvzfLn8XBlAaozXW+c2oyiwTkWwFXMvEiJOXLdKdrl/sRtodEfiJhHxXRk+YlABfS+
 1yhlg3Xgc3oOsUPDAwbghOtnM3H1w2ZYqkv0YebVR5i6cvuiqjpiPvXv7v2tUKdxl7IM
 1eiw==
X-Gm-Message-State: AOJu0YxU5P/cWxf7aNE/VrSVuKllpyJ6fn3xEsDbqtQ4nfuTZSTfhDYD
 3NSM6INVh+o9tACF2sf8EgJv5tGn1ZLm6zWuv81pnTy/D8oHERpUZF3b9nh3RE7WvB4xavW9qmv
 yFKNnLeD2d8BE1oZI5rTNVbIn+mmt8pMiftlv
X-Google-Smtp-Source: AGHT+IF50VhAxEzJeuPqPBYZ9LKr65hefD6bTZvK68reX7uePEur/rYnjjCx2IK95RoLhfceJ4xtAOhclzCN3EMx0aA=
X-Received: by 2002:a05:6358:7f1c:b0:1b6:3d:e42c with SMTP id
 e5c5f4694b2df-1b603c4dfd8mr341596055d.13.1724940355148; Thu, 29 Aug 2024
 07:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240724150922.2343249-1-sjg@chromium.org>
 <20240724150922.2343249-13-sjg@chromium.org>
 <c886cdcb395e842d179144e5fa1d8b0de41127d8.camel@siemens.com>
In-Reply-To: <c886cdcb395e842d179144e5fa1d8b0de41127d8.camel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:35 -0600
Message-ID: <CAFLszThiF=rbpCgVEc+D+R2xqP9jX2i_BiaRwdc2MkaNBDf2fQ@mail.gmail.com>
Subject: Re: [PATCH 12/35] global_data: Convert have_console into a flag
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>, 
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>, 
 "vitor.soares@toradex.com" <vitor.soares@toradex.com>,
 "clamor95@gmail.com" <clamor95@gmail.com>, 
 "sbabic@denx.de" <sbabic@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "afd@ti.com" <afd@ti.com>, 
 "ion@agorria.com" <ion@agorria.com>, "marex@denx.de" <marex@denx.de>, 
 "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, 
 "sean.anderson@seco.com" <sean.anderson@seco.com>,
 "noreply@example.com" <noreply@example.com>, 
 "Leto, Enrico" <enrico.leto@siemens.com>, 
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "mk7.kang@samsung.com" <mk7.kang@samsung.com>, 
 "devarsht@ti.com" <devarsht@ti.com>,
 "yangshiji66@outlook.com" <yangshiji66@outlook.com>, 
 "jonas@kwiboo.se" <jonas@kwiboo.se>, "danishanwar@ti.com" <danishanwar@ti.com>,
 "francis.laniel@amarulasolutions.com" <francis.laniel@amarulasolutions.com>,
 "nm@ti.com" <nm@ti.com>, 
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "festevam@gmail.com" <festevam@gmail.com>, 
 "raymond.mao@linaro.org" <raymond.mao@linaro.org>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
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

Hi Alexander,

On Fri, 16 Aug 2024 at 07:08, Sverdlin, Alexander
<alexander.sverdlin@siemens.com> wrote:
>
> Hi Simon,
>
> On Wed, 2024-07-24 at 09:08 -0600, Simon Glass wrote:
> > We don't need a full word for this boolean value. Convert it into a flag
> > to save space in global_data.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/cpu/arm926ejs/mxs/spl_boot.c |  2 +-
> >  arch/arm/mach-exynos/spl_boot.c       |  2 +-
> >  arch/arm/mach-k3/common.c             |  2 +-
> >  arch/arm/mach-k3/r5/sysfw-loader.c    |  2 +-
> >  board/siemens/common/board_am335x.c   |  2 +-
> >  common/board_f.c                      |  2 +-
> >  common/console.c                      | 14 +++++++-------
> >  common/spl/spl.c                      |  2 +-
> >  include/asm-generic/global_data.h     | 17 +++++++----------
> >  9 files changed, 21 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> > index 76a69d7f958..dd748328293 100644
> > --- a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> > +++ b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
>
> [...]
>
> > @@ -219,7 +210,7 @@ struct global_data {
> >  #endif
> >  #ifdef CONFIG_TIMER
> >       /**
> > -      * @timer: timer instance for Driver Model
> > +s     * @timer: timer instance for Driver Model
>
> an unintentional change?
>
> >        */
> >       struct udevice *timer;
> >  #endif
>
> the rest looks good to me and you can add my
> Reviewed-by: if you remove the above chunk.
>

Thank you. I'm not sure where that came from, but it seems to be gone now.

Regards,
Simon
