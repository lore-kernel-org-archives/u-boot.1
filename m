Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7994C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 11:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A578144A;
	Sun, 30 Mar 2025 13:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RRjRZIHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DC2819D2; Sun, 30 Mar 2025 13:52:55 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9F180FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 13:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22928d629faso34050595ad.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743335572; x=1743940372; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAVN+RgPWeVM0OJaeSBAp4obMNJ0m+cM9cgG00cn6SM=;
 b=RRjRZIHB04Lum448WIsAY1nA9AS4UDzDtUwIYfahl9dOBFQj6g8oRRMe5ojiieIbO4
 MxBFsz7y4Gm5FNc0jOaFZTTJaTymHmX5VQmLUDM4C/nlBDqzmriSvAYdONnSGDO0Uhbb
 w6kHtG3Rfxcx/QBqmL5zHCIBjp98pg0Xn2YL3gHEHqT0PM7auzYMAb5c+utI12kZbH0z
 v0YlueoWdVoprvtf3LZHZYvyfsxf7mJJotjgX8rgy/0qmbxtEdI3DpZghpAHhAm5euC9
 5LBCdMi6wT1Bx4g0hBqt/BGMo9dyutUwlV9ZZpqg1WQsBCScFPHRULCOw3k0oP8NNnqS
 VXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743335572; x=1743940372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAVN+RgPWeVM0OJaeSBAp4obMNJ0m+cM9cgG00cn6SM=;
 b=kJRfNDS3Sioo4dErYbsB9X8rgY4jEY0ZSyAOLKmafoi7m0F+35uwCfW780SszI2e2h
 8YMuWqqTJLOlAHykXWkWz5v04FXs+4gua1ROQZ49ZwVv2tkC5gELrlabd1eZ3aCql2b9
 LxyT3zppdzwyFX35SH3tA7F34OP9Bc4fKFy2YURobiC9905+TShQRtx9KZNuQr8nIFTu
 E/W7KIM3A1WDhtQM1uWDYIT0EJWEAV37n7NUpcDlHJVcmN/WDyXV2pDkuwKdoqFfN5Li
 cfk4H9GcouCmgpBenQiTtJeKHwDt/bHv1SjZakJv6pwY89fR4IHkkuR0reUFNsaYvCrH
 nHfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCGgb3uF8idpuAuY7POadcO7qgc+tawTIL3BXXpvwvyYILJ7fqYqQjP1jUhkvjN+nRp2crSGM=@lists.denx.de
X-Gm-Message-State: AOJu0YyTmb3ePBcfdiZb2C/EH90d/20Y0AAvavczxjIwWZW4xFZSF5YG
 ld5OVUarJawZRqmR+jECR36UIKzSb2cdbWxLeRh/W1tIEpZJcWGXNPmxA4EcQZABbCuVOPW1nd0
 8w0VmjElpXOEuGBCgcQ6luQDIVYk=
X-Gm-Gg: ASbGncu7XWj/02Zg81RueQfNUJdK/oDQbE+eSu4mkb3pL6SYGJhpsQC6XhAJWCnrSYP
 S0VK8iDG1OzR3yUhDjeMkOSouaObZAJL2sASmqHBKbDOxyMtWKvE17chV660Q1AuMdghf8swsF4
 mE1twrpc4z+0F45EMWnVDUxl4pO/4zgSjUvksVtr0DLTA1EQPqRkzQiEuMrBlYPHn6hms=
X-Google-Smtp-Source: AGHT+IG8iQx6FVhG7HnqZar1CHIYd1db7XtBIe0u/qHZdKjsSuJa9/gfyPSr/LcAifxkl9f3dtysXeBni/wZZwfuVeY=
X-Received: by 2002:a17:90b:4f4b:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-3053214596cmr7520281a91.25.1743335571943; Sun, 30 Mar 2025
 04:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250323225134.2369473-1-anarsoul@gmail.com>
 <20250323225134.2369473-3-anarsoul@gmail.com>
 <3819cbcb-5fa6-4939-a2b4-643cadcc50ff@kwiboo.se>
In-Reply-To: <3819cbcb-5fa6-4939-a2b4-643cadcc50ff@kwiboo.se>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Sun, 30 Mar 2025 14:52:40 +0300
X-Gm-Features: AQ5f1JqGtjIt6-SLltuSlMQEOxvYYC8fwBAkKplxcynUIo5UDeXU-Wji79qkwTk
Message-ID: <CAJs94EZR5HZSoQFQH=ByoUeQzOk9VoQD7-td00wvCzpFWR4F=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rockchip: rock64-rk3328_defconfig: enable HDMI
 output and USB keyboard
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

=D0=B2=D1=81, 30 =D0=BC=D0=B0=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 14:45, Jon=
as Karlman <jonas@kwiboo.se>:
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
>
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

It already takes about 2 sec to initialize Ethernet. I would say that
nobody notices another 300ms.

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


--=20
With best regards,
Matwey V. Kornilov
