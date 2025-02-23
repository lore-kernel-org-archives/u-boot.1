Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B80C021B3
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F6E80FD6;
	Sun, 23 Feb 2025 13:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DWgQjvxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4421A80FDA; Sun, 23 Feb 2025 13:48:57 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E47180F67
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f325ddbc2so2642665f8f.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740314934; x=1740919734; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooRYHS+FeNR865wTkFYFm8/id0nnZL0Vgf+WCjV3Pkw=;
 b=DWgQjvxS96sn3hmP2K7/iEuXhKoni9cwtaHN1U+tG2UmppudcHVLWkJUjXo1PowJWq
 MyUChXdRZ54Cz1fwiKaylpynYwOJZ1dDKT6XvfLbLCw25qGnOsTgIOlezopVk39Oo67K
 vftNtJjnMdx1++oeWzXxpq7RUGlvE5VTCZ8e9IR03jWu0WGZjnFnlbHWbyfP4bJcaUpK
 8BVc+dzXbpQ7J2TOfBK0vqiS10wXieRiGCfUotBURnkiPp5LZM2wc7i8CX9FNyAxR9kS
 kAkk/6Rez5tdGBgQaVIJqcrz5pXY2wpkzr3rtSJdRnN8nF44bn4yGLBAkQwLkr38uR4N
 QHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740314934; x=1740919734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooRYHS+FeNR865wTkFYFm8/id0nnZL0Vgf+WCjV3Pkw=;
 b=RKjbjqihIlUxdw+WbR8hoAm5hiOJsyN8E5o2ywtLevUWR8cDk0+P/Yo6WVNx4FOPUt
 OfrlwNOg1JJ169VU+v0fW48OETQQZpdRFnAkg2Wo4aIq9ME4wxycelSOeOycj7YdnlXN
 zNaXb6vX03splvIUFfZ8Xtg1OeXvbaVZdJBgKCWsV2dD6qqFGIMNH8XnKUlYHC8LmM//
 2LLGcC2GqHzJNuoCQT/e7rrGWUp2leVWKvwlcpFNGu2+jYWmjq2OxZgsTjmCzUGlvDTG
 nHKU9cWEQz09Wom0uBnCYBTk5jdX6OMZvz1vSpDJIRckkSM++5onHDRBu/nImTPuBdie
 8pHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvHOoTY/C1wL2iI05vxnCpAOF3gxraJZODEBeQgEs0ye16mI53hwmZGDYMZ+LDS9jicKy71g8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8tcrPUh164igKJ0vipVw6k8hLF6MFoaXFBZSWUUt3ac61jqcq
 taiI/6YeTO8nCFn0WxebRfENs3zdX5a6FeWb8Z6ontXVwPyfCiXPeQXAWSjbmGLhtfwpHpfSQp9
 d57+F7JNZidcQuMyZ7FtCPQbB1yU=
X-Gm-Gg: ASbGnctEdAhI63YajKDE7bBQB4NO8jDIfUpK5sMHJA8svqMmoF/4zmeYVuUUTeNqx/o
 FUVZqD27MSYC/Hc7C0NSilTh/IwHAQmcXsVxaxsqocHMoRcjK14YghgIz7mxmnZwvPCnNqHB69M
 jINICkRWkB
X-Google-Smtp-Source: AGHT+IH+vW9vhhIygucqcM0Xt9za6yukVaufS+KWp+3C4Q9O4oB6OWfJY0hZxruk5eHIqzPF+8BEmW+H/bcaN/DWJJc=
X-Received: by 2002:a5d:4890:0:b0:38d:b6a9:2cd2 with SMTP id
 ffacd0b85a97d-38f70858c0bmr5158008f8f.46.1740314933918; Sun, 23 Feb 2025
 04:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <20250223-vop2-pt2-v2-4-71350e482970@riseup.net>
In-Reply-To: <20250223-vop2-pt2-v2-4-71350e482970@riseup.net>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 23 Feb 2025 14:48:42 +0200
X-Gm-Features: AWEUYZn0ct7ZaHUMjGk4SxVabW_UUYK1MHlduteifpFjpdjdFX5a9Khc2-8qJCs
Message-ID: <CAPVz0n1Qq+Www0dBe_PNt7_oVi6OdtfoCnN+GyimCd1frhis_A@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] video: rockchip: dw-mipi-dsi: Add
 get_display_timing support
To: Dang Huynh <danct12@riseup.net>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
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

=D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:14 Dang=
 Huynh <danct12@riseup.net> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This allows video drivers to obtain display timings from the video
> bridge.
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/vide=
o/rockchip/dw_mipi_dsi_rockchip.c
> index 95e825eb3d6de7ef2836fa029927034394486e9c..d21ea7953a6003fa49da3e222=
20d3312109f600c 100644
> --- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> +++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
> @@ -224,6 +224,7 @@ struct dw_rockchip_dsi_priv {
>         struct mipi_dsi_device device;
>         void __iomem *base;
>         struct udevice *panel;
> +       struct display_timing timings;
>         void __iomem *grf;
>
>         /* Optional external dphy */
> @@ -709,7 +710,7 @@ static int dw_mipi_dsi_rockchip_attach(struct udevice=
 *dev)
>         struct dw_rockchip_dsi_priv *priv =3D dev_get_priv(dev);
>         struct mipi_dsi_device *device =3D &priv->device;
>         struct mipi_dsi_panel_plat *mplat;
> -       struct display_timing timings;
> +       struct display_timing *timings =3D &priv->timings;
>         int ret;
>
>         ret =3D uclass_first_device_err(UCLASS_PANEL, &priv->panel);
> @@ -724,10 +725,10 @@ static int dw_mipi_dsi_rockchip_attach(struct udevi=
ce *dev)
>         device->format =3D mplat->format;
>         device->mode_flags =3D mplat->mode_flags;
>
> -       ret =3D panel_get_display_timing(priv->panel, &timings);
> +       ret =3D panel_get_display_timing(priv->panel, timings);
>         if (ret) {
>                 ret =3D ofnode_decode_display_timing(dev_ofnode(priv->pan=
el),
> -                                                  0, &timings);
> +                                                  0, timings);
>                 if (ret) {
>                         dev_err(dev, "decode display timing error %d\n", =
ret);
>                         return ret;
> @@ -740,7 +741,7 @@ static int dw_mipi_dsi_rockchip_attach(struct udevice=
 *dev)
>                 return ret;
>         }
>
> -       ret =3D dsi_host_init(priv->dsi_host, device, &timings, 4,
> +       ret =3D dsi_host_init(priv->dsi_host, device, timings, 4,
>                             &dsi_rockchip_phy_ops);
>         if (ret) {
>                 dev_err(dev, "failed to initialize mipi dsi host\n");
> @@ -902,9 +903,19 @@ static int dw_mipi_dsi_rockchip_probe(struct udevice=
 *dev)
>         return 0;
>  }
>
> +static int dw_mipi_dsi_rockchip_get_dt(struct udevice *dev,
> +                                      struct display_timing *timings)
> +{
> +       struct dw_rockchip_dsi_priv *priv =3D dev_get_priv(dev);
> +
> +       memcpy(timings, &priv->timings, sizeof(*timings));
> +       return 0;
> +}
> +
>  struct video_bridge_ops dw_mipi_dsi_rockchip_ops =3D {
>         .attach =3D dw_mipi_dsi_rockchip_attach,
>         .set_backlight =3D dw_mipi_dsi_rockchip_set_bl,
> +       .get_display_timing =3D dw_mipi_dsi_rockchip_get_dt,
>  };
>
>  static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] =3D {
>
> --
> 2.48.1
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
