Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334C7C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD44F8128D;
	Thu, 27 Feb 2025 17:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kIrtgCcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77FAA8129F; Thu, 27 Feb 2025 17:27:07 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 276F0810F5
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f83a8afcbbso2204295a91.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673624; x=1741278424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kkAvdaQE7GCKDX+5f7i/9q1u/nrw4K3+5v/mpyfRKOQ=;
 b=kIrtgCcGxAz8yPvsudO5Ujn9BgF4AWBGQHaZwY1sSjQhT/t6Z41qo6dHsjLG4QMOlz
 Xew+1G66XQFiDr9/jGMlLbSkTwQxfxPH9CAHJo9rjuBTtjrG/iTgAQyGZSMSj6j6qqg+
 QzTVVxLvatW9AYc6SznoSgjsCBnpXR2Vu3CXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673624; x=1741278424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kkAvdaQE7GCKDX+5f7i/9q1u/nrw4K3+5v/mpyfRKOQ=;
 b=WNhZlKwOrNC77VaUoJmoq654OBNd4sWrJS/f2VMXO92iDKXKggwJvXZ6Jikwest1EY
 rAMDidGV4QATaWRdBDjMapPVX8iB1Cpljfo9X9rvyi5ZnX9nufhXzrgocCkWe5L8E9B0
 RkVkkfpC51ndl9sTvdzXjmonsTjtuLq4Rf3rKJzFbKjOp57T1YTCQ73WWFf3GG6n3K1S
 9KdT8LzMcX71W0J1rv/Sk0FEc3+LH695LFDR7x4fnsaAP8J8u+YAI2eJQ6Xbm01IxStP
 gnwjsgGJrpRhpYGbLzpnhK7X2eugCCCDoGOTiO/DGqJvSGRlm482UvOJYDltmf7ZsnsR
 Ea8Q==
X-Gm-Message-State: AOJu0YwuMkaQH4mbRUKETHnuLht/P8yDc4iFt0VMH5njR9ngodCM+xyh
 WgH43PFF+WzZzc6tMsQ0yqUoiUrBWgZIse++3fHovzGmsHmcxOpB0a9E9mqwXqlRoa3huABE1qG
 iRHopzFBoC3egLK9osXhiCYW99bVMtOt3gSMt
X-Gm-Gg: ASbGnctv7LpoDCiNdwuE/YWSv6HPH6B3ntpRoUeVFj3FkCOKyk7Qsi9Tyld3kiXXPvs
 NenXINwxuvLdb178ogIaxgWeni6akKnGXLbkg1BvUbYY41ew4uzUXOdYR4PcPkmSzU75H1X73ZC
 rAUO6ii7Xc
X-Google-Smtp-Source: AGHT+IE9bUZvahGNi6fNmGmD18HdMrBziFtVLrCyUbR+k8vtCXyUezCZk6Z72kscWMrP+Ub8AuLUJdpQzRvvprhi7pk=
X-Received: by 2002:a17:90b:17c2:b0:2fe:93be:7c9d with SMTP id
 98e67ed59e1d1-2feba5edb1fmr105796a91.7.1740673623681; Thu, 27 Feb 2025
 08:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-17-sjg@chromium.org>
 <1632d340-e117-41c1-a73b-beff118a1c28@kwiboo.se>
In-Reply-To: <1632d340-e117-41c1-a73b-beff118a1c28@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:26:41 -0700
X-Gm-Features: AQ5f1JpLWjVJtuMcUKzwRNL9TaQbyM8DsIwUei9ATvVeLdx80Om_OR7fl9mxGv4
Message-ID: <CAFLszTivF3dqRrpFvuGhetYcWGCt5-oRUoimfGBN0mq7p89mTg@mail.gmail.com>
Subject: Re: [PATCH v2 16/35] rockchip: Provide a bootstd configuration
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Mon, 17 Feb 2025 at 13:58, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 22:14, Simon Glass wrote:
> > Add bootstd information for VBE. Put it in a separate file to avoid
> > cluttering the main one.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Move VPL things into a separate file
> >
> >  arch/arm/dts/rockchip-u-boot.dtsi     |  4 ++++
> >  arch/arm/dts/rockchip-vpl-u-boot.dtsi | 31 +++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> > index c899e8e6005..10563e273a9 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -224,3 +224,7 @@
> >  #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
> >  };
> >  #endif /* CONFIG_SPL */
> > +
> > +#ifdef CONFIG_VPL
> > +#include "rockchip-vpl-u-boot.dtsi"
> > +#endif
> > diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..26b77e67c80
> > --- /dev/null
> > +++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
> > + */
> > +
> > +/ {
> > +     bootstd {
> > +             bootph-verify;
> > +             compatible = "u-boot,boot-std";
> > +
> > +             /*
> > +              * This is used for the VBE OS-request tests. A FAT filesystem
> > +              * created in a partition with the VBE information appearing
> > +              * before the partition starts.
> > +              *
> > +              * Offsets are aligned to the media block-size, typically 0x200
> > +              */
> > +             firmware0 {
> > +                     bootph-verify;
> > +                     compatible = "fwupd,vbe-abrec";
> > +                     storage = "mmc0";
>
> This is probably board specific and can mean either emmc or sd-card in
> Linux depending on the DT for the board. U-Boot will for most Rockchip
> SoCs always treat mmc0 as emmc and mmc1 as sd-card thanks to override
> in <soc>-u-boot.dtsi and/or driver code.

OK.

>
> > +                     skip-offset = <0x8000>;
> > +                     area-start = <CONFIG_SPL_PAD_TO>;
>
> SPL_PAD_TO is defined as "Image offset to which the SPL should be padded
> before appending the SPL payload." so should probably not be used to
> declare offset in storage.

OK, I'll use a separate value.

>
> > +                     area-size = <0x800000>;
> > +                     state-offset = <(CONFIG_SPL_PAD_TO - 0x400)>;
> > +                     state-size = <0x40>;
> > +                     version-offset = <(CONFIG_SPL_PAD_TO - 0x200)>;
> > +                     version-size = <0x100>;
>
> All these offsets and sizes seem a bit arbitrary without any context.
> Please add more details about the layout used in a comment and/or commit
> message.

Will do.

Regards,
SImon
