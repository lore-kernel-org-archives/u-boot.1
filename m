Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B002CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 07:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18BB4831BB;
	Tue, 12 Aug 2025 09:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J/kUmzxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69678319A; Tue, 12 Aug 2025 03:25:49 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54CE28312A
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 03:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-615622ed677so5984595a12.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754961947; x=1755566747; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6X/uYPl4nxEaUptH7OSLMTtMsCamcbCZRK2Q09ag2k=;
 b=J/kUmzxiaBVpxshPwcOUbJHvZxa+BsStKaT6Yq8CH7bGdfFHPi6wFHm3GK3trYyHW2
 vqo/8TasskIo6Z1LUyv9k2K2O95XIRh77tRIqokpkRJiuXyME0RHzlBDTy6KSj/jnjIW
 6I6CkpzhGpXtx7xweSWpuOCFSN9F0MCqMNHO+iL/5meDL/4tTOVhg2xjZqZZcouDeCXk
 wjXZay4orLgHF4YA31ZNmmybP06Tksv4Cw4me6KgF9m0wv8sFicUnPtgjtaMYf84P8QB
 yLXpagHWq5xJjyROc25EfnxzHz50JHE+GO7JSy4wgpUgWJv1d3soYTGbNlYq3LCcZrlJ
 ljyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754961947; x=1755566747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6X/uYPl4nxEaUptH7OSLMTtMsCamcbCZRK2Q09ag2k=;
 b=oitvZiksoPaQyqxPUvpEWbx6m5CgvYa77enEzL9PzP1HYuhQzokGbpv02ePwRzbW9j
 /pPy+E4VBlzSxTQYz0/6JW1ZJnR6em8Nikx5+fN8UWQjnWmz/ekkuQvr4xQ57cA7jYBh
 gGAbxNKBbJTePmpR+sptFlOE0GWKbv90CIbccG8E0pleXpkSyH7VMPrxDZ22srZxcB+f
 +Arv52lG50BF3TCclsCtxCDXoF3CydEWp3xIfvsasmOHhPn+pNgXBWjZQvKXqliTPbqh
 K5ADerBJ4UT/Pm+l6XEme+p/s/Wxy4mAouxU4wrdjEKNnl5putGKiD92xbSI4RGurO3P
 PApg==
X-Gm-Message-State: AOJu0YybL7sSBy3tic/09yJFuo4xR44RcsgF1M4L6sndyFiCkpPt4MnS
 cHN0e2bMt6le8FemVzmp0nIKT0HzOgwVZfhTs468hbKIWVD73go5un5qWl1NAuHzZuidPMrYaB6
 ZfwJiSHSsMi6rRtRLX8XLC2k5Uku8nzU=
X-Gm-Gg: ASbGncsno4Mx4czSmBuFMcLs7Kdl6kgUz5iBl0iGOeml0CdmRa+mf/PNPED3ccXYrNa
 wvUAfJkQQWqSrrQhW20ohaGAJME3IGUL65Nfj/eX+Ktu7/jknxYqWWdH8GIqtu8+8xgMY1OHYZk
 P2qdNSwxpTuZ3C23r7cjNMHbvQI5LZhFpXNd6GWAOw3GczIWvw7omRxnG7azfHDaePkvXfZKCpd
 B/P2PhXyWi8mRYBC4KLiZejbA==
X-Google-Smtp-Source: AGHT+IFpnEA2huZqlcDRwYD2t/cTp8enZjazDsg6quCQLAgZnza6UebxiENk8p2axkYanbxo3WhgAP/vxeGWfmYt/7A=
X-Received: by 2002:a17:907:a4a:b0:af9:57ae:dbb3 with SMTP id
 a640c23a62f3a-afa1dffcb78mr124248766b.22.1754961946344; Mon, 11 Aug 2025
 18:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
 <20250807074419.336752-11-cn.liweihao@gmail.com>
 <e19f94a0-4d69-4c63-bbdb-2598e3f5bf68@cherry.de>
In-Reply-To: <e19f94a0-4d69-4c63-bbdb-2598e3f5bf68@cherry.de>
From: =?UTF-8?B?5p2O57u06LGq?= <cn.liweihao@gmail.com>
Date: Tue, 12 Aug 2025 09:25:33 +0800
X-Gm-Features: Ac12FXyPOgiCXccvZA50R_zkqP26r9DGV0Aga9RCLOu2kIUoVDhGDQIk0YOvA_c
Message-ID: <CAPEOAkQS_0eHZ5ZKOGqj-+4bZfyXdBDpZSKsQfzxfxaVMei9aQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] board: rockchip: add rk3368 ymd8_mb support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, antonio.borneo@foss.st.com, mk7.kang@samsung.com, 
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org, 
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za, 
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com, 
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org, 
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com, 
 jerome.forissier@linaro.org, andrew.goodbody@linaro.org, 
 sumit.garg@kernel.org, ag.dev.uboot@gmail.com, rfried.dev@gmail.com, 
 joe.hershberger@ni.com, jh80.chung@samsung.com, peng.fan@nxp.com, 
 seanga2@gmail.com, lukma@denx.de, kever.yang@rock-chips.com, 
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com, 
 WeiHao Li <ieiao@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 12 Aug 2025 09:43:35 +0200
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

Hi Quentin,

Thanks for your review.

Quentin Schulz <quentin.schulz@cherry.de> =E4=BA=8E2025=E5=B9=B48=E6=9C=881=
1=E6=97=A5=E5=91=A8=E4=B8=80 23:01=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi WeiHao Li,
>
> On 8/7/25 9:44 AM, WeiHao Li wrote:
> > [You don't often get email from cn.liweihao@gmail.com. Learn why this i=
s important at https://aka.ms/LearnAboutSenderIdentification ]
> >
>
> Please always include a few words in the commit log.
>

I will add some necessary description in the commit log.

> I believe the description of the board as told in the cover letter is
> good enough, so start with that maybe :)
>
> > Signed-off-by: WeiHao Li <ieiao@outlook.com>
> > ---
> >   arch/arm/dts/Makefile                   |   1 +
> >   arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi |  44 ++++
> >   arch/arm/dts/rk3368-ymd8-mb.dts         | 326 +++++++++++++++++++++++=
+
> >   arch/arm/dts/rk3368.dtsi                | 258 +++++++++++++++++++
> >   arch/arm/mach-rockchip/rk3368/Kconfig   |   6 +
> >   board/rockchip/ymd8_mb/Kconfig          |  12 +
> >   board/rockchip/ymd8_mb/MAINTAINERS      |   6 +
> >   board/rockchip/ymd8_mb/Makefile         |   7 +
> >   board/rockchip/ymd8_mb/README           |   1 +
> >   board/rockchip/ymd8_mb/ymd8_mb_rk3368.c |  19 ++
> >   configs/ymd8-mb_defconfig               |  72 ++++++
> >   include/configs/ymd8_mb.h               |  11 +
> >   12 files changed, 763 insertions(+)
> >   create mode 100644 arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
> >   create mode 100644 arch/arm/dts/rk3368-ymd8-mb.dts
> >   create mode 100644 board/rockchip/ymd8_mb/Kconfig
> >   create mode 100644 board/rockchip/ymd8_mb/MAINTAINERS
> >   create mode 100644 board/rockchip/ymd8_mb/Makefile
> >   create mode 100644 board/rockchip/ymd8_mb/README
> >   create mode 100644 board/rockchip/ymd8_mb/ymd8_mb_rk3368.c
> >   create mode 100644 configs/ymd8-mb_defconfig
> >   create mode 100644 include/configs/ymd8_mb.h
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 0dc7e190eb..1dfd1c5236 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -73,6 +73,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3368) +=3D \
> >          rk3368-sheep.dtb \
> >          rk3368-geekbox.dtb \
> >          rk3368-px5-evb.dtb \
> > +       rk3368-ymd8-mb.dtb
> >
> >   dtb-$(CONFIG_ARCH_S5P4418) +=3D \
> >          s5p4418-nanopi2.dtb
> > diff --git a/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi b/arch/arm/dts/rk3=
368-ymd8-mb-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..925264e620
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR X11
> > +/*
> > + * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
> > + */
> > +
>
> I'm quite sure Theobroma didn't work on that, and not in 2017 :)
>
> Please remove us (Theobroma got renamed to Cherry Embedded Solutions
> last year) from this copyright notice and provide the appropriate
> copyright holder there instead.
>

Got it.

> > +#include "rk3368-u-boot.dtsi"
> > +
> > +&pinctrl {
> > +       bootph-all;
> > +};
> > +
> > +&service_msch {
> > +       bootph-all;
> > +};
> > +
> > +&dmc {
> > +       bootph-all;
> > +       status =3D "okay";
> > +};
> > +
> > +&pmugrf {
> > +       bootph-all;
> > +};
> > +
> > +&cru {
> > +       bootph-all;
> > +};
> > +
> > +&grf {
> > +       bootph-all;
> > +};
> > +
> > +&uart2 {
> > +       bootph-all;
> > +       clock-frequency =3D <24000000>;
> > +};
> > +
> > +&pwm1 {
> > +       bootph-all;
> > +};
> > +
> > +&vop {
> > +       bootph-all;
> > +};
> > diff --git a/arch/arm/dts/rk3368-ymd8-mb.dts b/arch/arm/dts/rk3368-ymd8=
-mb.dts
> > new file mode 100644
> > index 0000000000..661390b9d5
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3368-ymd8-mb.dts
>
> Are you planning to support this board in upstream Linux as well? I'm
> sure Heiko would welcome it. If so, maybe think about selecting
> OF_UPSTREAM for your board once the device tree is merged upstream and
> appears in dts/upstream directory in U-Boot? It may not be easy to do as
> no RK3368-based board has been migrated to use OF_UPSTREAM yet.
>
> We typically do not allow (in Rockchip) to support new boards without
> OF_UPSTREAM, but considering how old and how little activity we see for
> RK3368 maybe Kever will let this pass?
>

Yes, I'm planning to suport this board in upstream Linux. but it may take s=
ome
time.

Maybe I can separate this patch serial to 2 set, one for driver fix, anothe=
r for
board support., the board support patchset submit after upstream Linux merg=
ed?

> > @@ -0,0 +1,326 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2025 Weihao Li
> > + */
> > +
> > +/dts-v1/;
> > +#include "rk3368.dtsi"
> > +#include <dt-bindings/input/input.h>
> > +
> > +/ {
> > +       model =3D "YMD8_MB";
> > +       compatible =3D "rockchip,YMD8_MB", "rockchip,rk3368";
>
> The first compatible isn't right if Rockchip isn't the actual
> manufacturer/seller of the whole product. I couldn't see anything on the
> PCB picture you posted on your wiki but maybe there's some information
> on the casing or elsewhere?

I do not find any manufacturer info for now, I will try to search later.

>
> [...]
>
> > diff --git a/arch/arm/dts/rk3368.dtsi b/arch/arm/dts/rk3368.dtsi
> > index 4c64fbefb4..77ff551681 100644
> > --- a/arch/arm/dts/rk3368.dtsi
> > +++ b/arch/arm/dts/rk3368.dtsi
>
> Nope, this we won't allow.
>
> If you add support for a board, don't modify the device tree of the SoC
> in the same patch. Please separate those changes from the patch adding
> supoprt for the board.
>
> Here, because the rk3368.dtsi already exists, you'll need a patch per
> logical thing you are adding. There are a few I could notice here:
> - hdmi
> - lvds
> - rgb
> - edp
> - dsi
> - vop
>
> First, only add what you tested. I believe this would be DSI+VOP only?
>

It's reasonable, I'll fix that.

> Second, where did you get all the info? I don't see anything in upstream
> Linux's rk3368.dtsi so it must come from somewhere else? Where? Please
> specify this in the commit logs. it would be very nice to have this sent
> and reviewed by the Linux kernel community as well.
>

I cross-referenced the downstream U-Boot and Linux repositories of
Rockchip and made some reasonable inferences based on drivers for the
same series of SoCs.

I will add this information to commit log at next submit.

> [...]
>
> > diff --git a/arch/arm/mach-rockchip/rk3368/Kconfig b/arch/arm/mach-rock=
chip/rk3368/Kconfig
> > index a7be30bbd8..1d05a6784f 100644
> > --- a/arch/arm/mach-rockchip/rk3368/Kconfig
> > +++ b/arch/arm/mach-rockchip/rk3368/Kconfig
> > @@ -21,6 +21,11 @@ config TARGET_EVB_PX5
> >            HDMI video input/output interface, audio codec ES8396,
> >            WIFI/BT (on RTL8723BS), Gsensor BMA250E and light&proximity
> >            sensor STK3410.
> > +
> > +config TARGET_YMD8_MB
> > +       select BOARD_EARLY_INIT_R
> > +       bool "YMD8_MB board"
> > +
>
> Please add a help text so we have some clue what this board actually is.
>

Got it.

> [...]
>
> > diff --git a/board/rockchip/ymd8_mb/MAINTAINERS b/board/rockchip/ymd8_m=
b/MAINTAINERS
> > new file mode 100644
> > index 0000000000..a5156b8be3
> > --- /dev/null
> > +++ b/board/rockchip/ymd8_mb/MAINTAINERS
> > @@ -0,0 +1,6 @@
> > +RK3368 YMD8_MB Board
> > +M:     Weihao Li <cn.liweihao@gmail.com>
> > +S:     Maintained
> > +F:     board/rockchip/ymd8_mb_rk3368/
>
> This is also missing the new device tree you added which you need to
> maintain.

Got it

>
> > +F:     include/configs/ymd8_mb.h
> > +F:     configs/ymd8-mb_defconfig
> > diff --git a/board/rockchip/ymd8_mb/Makefile b/board/rockchip/ymd8_mb/M=
akefile
> > new file mode 100644
> > index 0000000000..a3a34edb43
> > --- /dev/null
> > +++ b/board/rockchip/ymd8_mb/Makefile
> > @@ -0,0 +1,7 @@
> > +#
> > +# (C) Copyright 2016 Rockchip Electronics Co., Ltd
> > +#
> > +# SPDX-License-Identifier:     GPL-2.0+
> > +#
> > +
> > +obj-y  +=3D ymd8_mb_rk3368.o
> > diff --git a/board/rockchip/ymd8_mb/README b/board/rockchip/ymd8_mb/REA=
DME
> > new file mode 100644
> > index 0000000000..de980f2f23
> > --- /dev/null
> > +++ b/board/rockchip/ymd8_mb/README
> > @@ -0,0 +1 @@
> > +see board/rockchip/sheep_rk3368/README
>
> I don't think that's right.
>
> Remove this file and add a proper entry in doc/board/rockchip for this
> board (or its own documentation file like we did for Theobroma boards,
> up to you if there are important details that typically differ from
> other Rockchip boards).

I forgot to modify it when I separate patch, I'll adjust that.

>
> Cheers,
> Quentin

Best regards,
WeiHao
