Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6849CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 09:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473EA86E73;
	Tue, 12 Dec 2023 10:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KpVPJysE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAFBB807E9; Tue, 12 Dec 2023 10:25:48 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37C3186E73
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 10:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d3644ca426so52946457b3.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 01:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702373144; x=1702977944;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4gRcyGGdKlPmDkFHkjXrnlocz6KgKc57z1UWGMEZ9U=;
 b=KpVPJysEVp8kDrbJ27HZWaof26kK0lmvaUF3YTey4JGICN2BmqbfdWaRhR9VkNeQ3G
 vmRYbM0j4Dom4lxfZu140uf7nKGh3aJ0xEIvvCCp/8og3QGTqGNVBnxeZ1Lk7RlSOGWZ
 ChVf2RpslIx9NQH3CfgttQevXLl1D3HgMeoSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702373144; x=1702977944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4gRcyGGdKlPmDkFHkjXrnlocz6KgKc57z1UWGMEZ9U=;
 b=NAdhF0yUUKzNmp009SCSG3tHYXPP0JNrOZOk+3Z0yTn7ChZcIvZuF84TdGoP3MEtC1
 hjzYiZp0od/TVEJQ7yl4tVAerjORSDagBJj+M0K0nTbXf+4LyndIEdn2nijL0EyghK8n
 MAVuZJMoE0A08IzsTsePDjGKpBh9UmUtHzBmxrgFYIsIAAFOARrKPjYJNy3BXivJWTVH
 kkxj00tl/hzMC0YsJvJUlmZGVG/ybSl4oheD85Gi+VI+O4oRUDGwqPQ7pxUEfRER4Io6
 ISRAp6c6hgqnru+9Z0w0326Elc18Ruu963c9lJ8+s6wXZQ12IkRNs00dWpa6nsn9YxFN
 uI8w==
X-Gm-Message-State: AOJu0YyPU3k+oPESGCp7E26mFbAO0EFIu7cgDLmqI3K6tzrj25ASmkmp
 eWJdyoWAL72K8mqdouJbT8TA4ywgndgfKS7imzjUZim9GfAc5uZuhcuCfg==
X-Google-Smtp-Source: AGHT+IFRjMsGq4/pKkhcRb7MfqKU1rG11T7W6ahtzQIfetp7eOyp2CAWNWdy6Fe9NR3oNirYVPt6iZXxGBRyqaVrlco=
X-Received: by 2002:a0d:c907:0:b0:5d7:1941:3578 with SMTP id
 l7-20020a0dc907000000b005d719413578mr3837377ywd.95.1702373143795; Tue, 12 Dec
 2023 01:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
 <20231211085939.5478-3-jagan@amarulasolutions.com>
 <a963f773-f17c-46e9-b468-ca9e6217ffce@linaro.org>
In-Reply-To: <a963f773-f17c-46e9-b468-ca9e6217ffce@linaro.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 12 Dec 2023 14:55:32 +0530
Message-ID: <CAMty3ZA7Z20wUzgJnu4rEwLBZhhizJaFVg5OEK4MpvmpMGk7DA@mail.gmail.com>
Subject: Re: [PATCH 02/17] video: dw_hdmi: Add Vendor PHY handling
To: neil.armstrong@linaro.org
Cc: Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
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

On Mon, Dec 11, 2023 at 2:38=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 11/12/2023 09:59, Jagan Teki wrote:
> > From: Jagan Teki <jagan@edgeble.ai>
> >
> > DW HDMI support Vendor PHY like Rockchip RK3328 Inno HDMI PHY.
> >
> > Extend the vendor phy handling by adding platform phy hooks.
> >
> > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> > ---
> >   drivers/video/dw_hdmi.c              | 29 +++++++++++++++++++++++++++=
-
> >   drivers/video/meson/meson_dw_hdmi.c  | 11 ++++++++++-
> >   drivers/video/rockchip/rk3399_hdmi.c |  8 +++++++-
> >   drivers/video/rockchip/rk_hdmi.c     |  2 +-
> >   drivers/video/sunxi/sunxi_dw_hdmi.c  | 11 ++++++++++-
> >   include/dw_hdmi.h                    | 14 +++++++++++++-
> >   6 files changed, 69 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
> > index c4fbb18294..ea12a09407 100644
> > --- a/drivers/video/dw_hdmi.c
> > +++ b/drivers/video/dw_hdmi.c
> > @@ -988,7 +988,7 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const stru=
ct display_timing *edid)
> >
> >       hdmi_av_composer(hdmi, edid);
> >
> > -     ret =3D hdmi->phy_set(hdmi, edid->pixelclock.typ);
> > +     ret =3D hdmi->ops->phy_set(hdmi, edid->pixelclock.typ);
> >       if (ret)
> >               return ret;
> >
> > @@ -1009,10 +1009,37 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const =
struct display_timing *edid)
> >       return 0;
> >   }
> >
> > +static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops =3D {
> > +     .phy_set =3D dw_hdmi_phy_cfg,
> > +};
> > +
> > +static void dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
> > +{
> > +     if (!hdmi->data)
> > +             return;
> > +
> > +     /* hook Synopsys PHYs ops */
> > +     if (!hdmi->data->phy_force_vendor) {
> > +             hdmi->ops =3D &dw_hdmi_synopsys_phy_ops;
> > +             return;
> > +     }
> > +
> > +     /* Vendor HDMI PHYs must assign phy_ops in plat_data */
> > +     if (!hdmi->data->phy_ops) {
> > +             printf("Unsupported Vendor HDMI phy_ops\n");
> > +             return;
> > +     }
> > +
> > +     /* hook Vendor HDMI PHYs ops */
> > +     hdmi->ops =3D hdmi->data->phy_ops;
> > +}
> > +
> >   void dw_hdmi_init(struct dw_hdmi *hdmi)
> >   {
> >       uint ih_mute;
> >
> > +     dw_hdmi_detect_phy(hdmi);
> > +
> >       /*
> >        * boot up defaults are:
> >        * hdmi_ih_mute   =3D 0x03 (disabled)
> > diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/=
meson_dw_hdmi.c
> > index 5db01904b5..63ca3ac52e 100644
> > --- a/drivers/video/meson/meson_dw_hdmi.c
> > +++ b/drivers/video/meson/meson_dw_hdmi.c
> > @@ -375,6 +375,15 @@ static int meson_dw_hdmi_wait_hpd(struct dw_hdmi *=
hdmi)
> >       return -ETIMEDOUT;
> >   }
> >
> > +static const struct dw_hdmi_phy_ops dw_hdmi_meson_phy_ops =3D {
> > +     .phy_set =3D meson_dw_hdmi_phy_cfg,
>
> Pretty sure this should be meson_dw_hdmi_phy_init

Correct, I will update this.

>
> > +};
> > +
> > +static const struct dw_hdmi_plat_data dw_hdmi_meson_plat_data =3D {
> > +     .phy_force_vendor =3D true,
> > +     .phy_ops =3D &dw_hdmi_meson_phy_ops,
> > +};
> > +
> >   static int meson_dw_hdmi_probe(struct udevice *dev)
> >   {
> >       struct meson_dw_hdmi *priv =3D dev_get_priv(dev);
> > @@ -397,7 +406,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
> >
> >       priv->hdmi.hdmi_data.enc_out_bus_format =3D MEDIA_BUS_FMT_RGB888_=
1X24;
> >       priv->hdmi.hdmi_data.enc_in_bus_format =3D MEDIA_BUS_FMT_YUV8_1X2=
4;
> > -     priv->hdmi.phy_set =3D meson_dw_hdmi_phy_init;
> > +     priv->hdmi.data =3D &dw_hdmi_meson_plat_data;
> >       if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A))
> >               priv->hdmi.reg_io_width =3D 1;
> >       else {
> > diff --git a/drivers/video/rockchip/rk3399_hdmi.c b/drivers/video/rockc=
hip/rk3399_hdmi.c
> > index 3041360c6e..b32139a8a6 100644
> > --- a/drivers/video/rockchip/rk3399_hdmi.c
> > +++ b/drivers/video/rockchip/rk3399_hdmi.c
> > @@ -64,8 +64,14 @@ static const struct dm_display_ops rk3399_hdmi_ops =
=3D {
> >       .enable =3D rk3399_hdmi_enable,
> >   };
> >
> > +static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data =3D {
> > +};
> > +
> >   static const struct udevice_id rk3399_hdmi_ids[] =3D {
> > -     { .compatible =3D "rockchip,rk3399-dw-hdmi" },
> > +     {
> > +             .compatible =3D "rockchip,rk3399-dw-hdmi",
> > +             .data =3D (ulong)&rk3399_hdmi_drv_data
> > +     },
> >       { }
> >   };
> >
> > diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/=
rk_hdmi.c
> > index b75a174489..e34f532cd6 100644
> > --- a/drivers/video/rockchip/rk_hdmi.c
> > +++ b/drivers/video/rockchip/rk_hdmi.c
> > @@ -83,6 +83,7 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
> >       struct rk_hdmi_priv *priv =3D dev_get_priv(dev);
> >       struct dw_hdmi *hdmi =3D &priv->hdmi;
> >
> > +     hdmi->data =3D (const struct dw_hdmi_plat_data *)dev_get_driver_d=
ata(dev);
> >       hdmi->ioaddr =3D (ulong)dev_read_addr(dev);
> >       hdmi->mpll_cfg =3D rockchip_mpll_cfg;
> >       hdmi->phy_cfg =3D rockchip_phy_config;
> > @@ -90,7 +91,6 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
> >       /* hdmi->i2c_clk_{high,low} are set up by the SoC driver */
> >
> >       hdmi->reg_io_width =3D 4;
> > -     hdmi->phy_set =3D dw_hdmi_phy_cfg;
> >
> >       priv->grf =3D syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> >
> > diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/=
sunxi_dw_hdmi.c
> > index 0324a050d0..4b67a1614e 100644
> > --- a/drivers/video/sunxi/sunxi_dw_hdmi.c
> > +++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
> > @@ -369,6 +369,15 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev=
)
> >       return 0;
> >   }
> >
> > +static const struct dw_hdmi_phy_ops dw_hdmi_sunxi_phy_ops =3D {
> > +     .phy_set =3D sunxi_dw_hdmi_phy_cfg,
> > +};
> > +
> > +static const struct dw_hdmi_plat_data dw_hdmi_sunxi_plat_data =3D {
> > +     .phy_force_vendor =3D true,
> > +     .phy_ops =3D &dw_hdmi_sunxi_phy_ops,
> > +};
> > +
> >   static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
> >   {
> >       struct sunxi_dw_hdmi_priv *priv =3D dev_get_priv(dev);
> > @@ -379,7 +388,7 @@ static int sunxi_dw_hdmi_of_to_plat(struct udevice =
*dev)
> >       hdmi->i2c_clk_high =3D 0xd8;
> >       hdmi->i2c_clk_low =3D 0xfe;
> >       hdmi->reg_io_width =3D 1;
> > -     hdmi->phy_set =3D sunxi_dw_hdmi_phy_cfg;
> > +     hdmi->data =3D &dw_hdmi_sunxi_plat_data;
> >
> >       ret =3D reset_get_bulk(dev, &priv->resets);
> >       if (ret)
> > diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
> > index 8acae3839f..4ad8b39f84 100644
> > --- a/include/dw_hdmi.h
> > +++ b/include/dw_hdmi.h
> > @@ -534,6 +534,17 @@ struct hdmi_data_info {
> >       struct hdmi_vmode video_mode;
> >   };
> >
> > +struct dw_hdmi;
> > +
> > +struct dw_hdmi_phy_ops {
> > +     int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
> > +};
> > +
> > +struct dw_hdmi_plat_data {
> > +     bool phy_force_vendor;
> > +     const struct dw_hdmi_phy_ops *phy_ops;
> > +};
>
> Why do you need a separate phy_ops and this phy_force_vendor ?
>
> Simply use the provided phy_ops is pointer !=3D NULL
>
> I think simply use a single struct passed as pdata to have:
>
> if (!hdmi->data)
>         hdmi->ops =3D &dw_hdmi_synopsys_phy_ops;
> else
>         /* hook Vendor HDMI PHYs ops */
>         hdmi->ops =3D hdmi->data;

This logic seems not proper according to DW HDMI vendor phy support.

phy_set -> dw_hdmi_phy_cfg in dw_hdmi.c is what synopsys default phy
ops set. and reset defined in their hdmi drivers are vendor-related.
So only rk3399 has default synopsys phy_set but meson, sunxi and this
rk3328 has vendor phy ops. We need to define plat_data with phy_ops
and phy_force_vendor flag to support this setup.

Thanks,
Jagan.
