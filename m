Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87204C36014
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 22:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FA381879;
	Tue,  1 Apr 2025 00:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hrZoIYhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B12281E5B; Tue,  1 Apr 2025 00:17:24 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C9D80FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 00:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-601c469cce3so1119642eaf.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743459439; x=1744064239; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jOqveghuNAVeQSg9mv6eNWNNPep5W9URDyOq4KFw2k=;
 b=hrZoIYhqd/2lHtUQQphtQA3KLSMTbkaDSojEMb7vOwGn3YSz+HQmujxsW1AUxfcian
 vQkJ4Gihs5w5+Snq0Wmu/619aiuXX/vU3+Ph98uHJsd1lYBdpUjrl+/hBUI4spAr6bBu
 DMKyWzKwRcrvrsO6n2b9wYLFuZq4Ov/3YiFs64r+YyKTWP0LjTCAyOS9CjsxFmAessoX
 3VcL9VhuLEtUSWVy/pdL3VB3Q82GkLX4Iw9y7BJWNZglpx7VTMLbfj33meOR9qbyW5OM
 1aK5mV4dMkl8Conc2fwPXdvG7DK3Ryn/McwKSpGYAZ8zy7iSdDSk3I5VBCt46ujkUbgU
 lKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743459439; x=1744064239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jOqveghuNAVeQSg9mv6eNWNNPep5W9URDyOq4KFw2k=;
 b=LQY1ZjeRpbGUU+19ngzw+EE8B/VbGnQCPnn7Evd8FxxXgYlRxI4jveL9ryD3QnU2Nx
 Jy6zIAVl6GeDO2+GFtcYzPnyLn80ZBX5dL1BhiVeBcBzZMt6OPEVTtT7BbbjitUJ8NOS
 hzm22hi9aLnYakcYoCQolf+3m05TWQL6BeAHm98oasCx48y6vN985L1lM6rQl3WyZHSC
 Q4YYx/GUUy/oSuXye+xEzlaG8LpAx3mzrus9VWMHN+mW0dsTG3QSE7EFnWgxV/i1iIKY
 Qi0SOB8EX1lVlyy4N/idfoK3/nbN6fuQ9EvX41AHNjP7ySRIM7PrtuGfuzO4g8WNbGYa
 wuzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB816Bk2bviizMssgHyYn0GP7gGi5tjXEzPDatQQ0trL9Oj1Z5aujqL4D07TWJyJABFNDp5rE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6O/GrKCOXYziML9d0tghbAZ9hr0FRZdGpnCp+GZhrOdqjRKWN
 k/Ug3FRmcqV+x/04g8XXhm8AqyzCTsH6KxDrk6n6tAled4XW/flqMak2wqAo6UpU7pergLzlg5e
 fbKM/gPLlnFR7PW3On/SLyTGJw1k=
X-Gm-Gg: ASbGncvLq22e/i0RnduEgVwsFuAUEHyGnZ1MEc4IkL6Ynsnz0JM4xD0ZXmyt3AhSSZK
 tJB3FVjO2LUsK5ZDgVpyGOcinOGB5DryxHs5KC8RvXBt2mC44Qkath3PPjgj6DGi6CUxR5nYHN3
 rLn/y/H7Lp6/WCWzCTjeoqEHj0GTtiKz/tEsMz0IXC/s3PFqj8kkrP2+Q3K28=
X-Google-Smtp-Source: AGHT+IFxls2P6uRfHrmhXOOUlSbA32tnOMZd6zTprrdG6clOmPCJAm/EVfE7/JtC/7KRAUf76pigEpK/ePmN/RHXCEs=
X-Received: by 2002:a05:6820:168b:b0:602:8be2:b9aa with SMTP id
 006d021491bc7-60290f7a7c4mr5279691eaf.7.1743459439068; Mon, 31 Mar 2025
 15:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250323225134.2369473-1-anarsoul@gmail.com>
 <20250323225134.2369473-3-anarsoul@gmail.com>
 <3819cbcb-5fa6-4939-a2b4-643cadcc50ff@kwiboo.se>
In-Reply-To: <3819cbcb-5fa6-4939-a2b4-643cadcc50ff@kwiboo.se>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 31 Mar 2025 15:16:52 -0700
X-Gm-Features: AQ5f1JqLIeNF5SZlvij7O7Xjrp4jj9mvcbljjztNhOgLoBf5ltM4wQHmC3rXt1A
Message-ID: <CA+E=qVdwL2JK7XpUvvwvs8R88Mx9nCpZc1TOf=EFYaNaVzi2JQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rockchip: rock64-rk3328_defconfig: enable HDMI
 output and USB keyboard
To: Jonas Karlman <jonas@kwiboo.se>
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Anatolij Gustschin <agust@denx.de>, Jagan Teki <jagan@edgeble.ai>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Mar 30, 2025 at 4:45=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Vasily,
>
> On 2025-03-23 23:50, Vasily Khoruzhick wrote:
> > Enable HDMI output and USB keyboard on Rock64 board
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> > v2: no change
> >
> >  configs/rock64-rk3328_defconfig | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_de=
fconfig
> > index 6d00b52e62f..ae3512625cf 100644
> > --- a/configs/rock64-rk3328_defconfig
> > +++ b/configs/rock64-rk3328_defconfig
> > @@ -21,7 +21,9 @@ CONFIG_FIT_VERBOSE=3Dy
> >  CONFIG_SPL_FIT_SIGNATURE=3Dy
> >  CONFIG_SPL_LOAD_FIT=3Dy
> >  CONFIG_LEGACY_IMAGE_FORMAT=3Dy
> > +CONFIG_USE_PREBOOT=3Dy
>
> This will add a large delay during boot as it forces a run of the slow
> "usb start" and is something we want to avoid for normal use, please
> drop this.

Well, I can just drop the patch altogether.

Personally, I do need USB and HDMI support, since it allows me to boot
from a secondary storage in case the OS on main storage doesn't boot.
Not having USB support defeats the purpose of this patch.

> >  CONFIG_DEFAULT_FDT_FILE=3D"rockchip/rk3328-rock64.dtb"
> > +# CONFIG_SYS_DEVICE_NULLDEV is not set
> >  # CONFIG_DISPLAY_CPUINFO is not set
> >  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> >  CONFIG_SPL_MAX_SIZE=3D0x40000
> > @@ -72,6 +74,7 @@ CONFIG_DM_ETH_PHY=3Dy
> >  CONFIG_PHY_GIGE=3Dy
> >  CONFIG_ETH_DESIGNWARE=3Dy
> >  CONFIG_GMAC_ROCKCHIP=3Dy
> > +CONFIG_PHY_ROCKCHIP_INNO_HDMI=3Dy
> >  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> >  CONFIG_PINCTRL=3Dy
> >  CONFIG_SPL_PINCTRL=3Dy
> > @@ -80,6 +83,8 @@ CONFIG_PMIC_RK8XX=3Dy
> >  CONFIG_SPL_DM_REGULATOR=3Dy
> >  CONFIG_DM_REGULATOR_FIXED=3Dy
> >  CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
> > +CONFIG_DM_REGULATOR_GPIO=3Dy
> > +CONFIG_SPL_DM_REGULATOR_GPIO=3Dy
>
> The ROCK64 does not use any regulator-gpio, this look unrelated and can
> be dropped?
>
> >  CONFIG_REGULATOR_RK8XX=3Dy
> >  CONFIG_PWM_ROCKCHIP=3Dy
> >  CONFIG_RAM=3Dy
> > @@ -104,6 +109,11 @@ CONFIG_USB_OHCI_GENERIC=3Dy
> >  CONFIG_USB_DWC2=3Dy
> >  CONFIG_USB_DWC3=3Dy
> >  CONFIG_USB_DWC3_GENERIC=3Dy
> > +CONFIG_USB_KEYBOARD=3Dy
> > +CONFIG_VIDEO=3Dy
> > +CONFIG_DISPLAY=3Dy
> > +CONFIG_VIDEO_ROCKCHIP=3Dy
> > +CONFIG_DISPLAY_ROCKCHIP_HDMI=3Dy
>
> This will force a small delay of at least a 300ms timeout for all users
> that does not have HDMI connected during boot.
>
> Maybe this could be extracted to a rockchip-hdmi.config-file to make it
> more optional?
>
> E.g. use "make rock64-rk3328_defconfig rockchip-hdmi.config" to build
> with something like:
>
>   > cat rockchip-hdmi.config
>   CONFIG_VIDEO=3Dy
>   CONFIG_DISPLAY=3Dy
>   CONFIG_VIDEO_ROCKCHIP=3Dy
>   CONFIG_DISPLAY_ROCKCHIP_HDMI=3Dy
>
> Regards,
> Jonas
>
> >  CONFIG_SPL_TINY_MEMSET=3Dy
> >  CONFIG_TPL_TINY_MEMSET=3Dy
> >  CONFIG_ERRNO_STR=3Dy
>
