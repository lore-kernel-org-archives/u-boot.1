Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC23C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 04:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB2F879DB;
	Thu, 14 Dec 2023 05:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SuP1d8hP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DA3879DE; Thu, 14 Dec 2023 05:44:43 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15BBA879D8
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 05:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77f3c4914e5so412403885a.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702529080; x=1703133880;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+K9CK5NaNVTq4w92vxcis7PYF4T4IdWizYs1Jbbf77Q=;
 b=SuP1d8hPoHwG8+4/MR8jpd0z+Qz0cwfZgBr7dzUBOly7tE5pOZ9zZiadKVMxuj9rV4
 3vt4+/WbylxWjjuvqc9SogDd0lfLtZG2AYsfwCPcJSP+XHj8lPJdzhFa83xjcJa/Iwcb
 01DxoJZkz8PMrPQHYApb6tDfby7pTw57lrLvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702529080; x=1703133880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+K9CK5NaNVTq4w92vxcis7PYF4T4IdWizYs1Jbbf77Q=;
 b=Rg8rHbyQ4b90wCmuUMYbBHIg8kcdJpfHQkMtPBNgz0pAqlK5HvcgQvzGtRSAZ0C2pq
 IDaDcxXDB7MhKGmej8V5BWdDOjeZuE1K7D8/e78vTcSST/z8175bu+KKmu0IQxfXvCRA
 ZUxOsQB6nEHmvN1sdfl9UbxBH23AMOTlhzaoEqbap1393gzOraNr/dln+mNznir2tMcG
 x5kOHkhVoqFqQ6rdgPnfxC1KUsiMVIm4JIaWQSGwKzCQZfeeiuIOTx1McKBMx/UGOJwW
 IQy7CBVVfOMARKeblOzVAlgC+6qBntlyRnuK6hZlnJoZivlYOA4PI3fofhCvAJTRVJgV
 3zBA==
X-Gm-Message-State: AOJu0YzwAlXvhDf8t3CswsruAEhool1ArZ6inR1PXnnZjzCj3xJUcvnF
 H9rObpbzi/okfXFLmy3SexvKryL1TnUITDeg28z0ug==
X-Google-Smtp-Source: AGHT+IHhidFdSK0aK9Ri5gCYAqxAVI71tXLY6yK4HKKVbRrl+ZmeQ70ofM2fUNhKl9pN0P/U6cKMXlKvZdmSGOROBwM=
X-Received: by 2002:a05:620a:1a22:b0:779:f985:76bf with SMTP id
 bk34-20020a05620a1a2200b00779f98576bfmr12116527qkb.37.1702529079701; Wed, 13
 Dec 2023 20:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
 <20231211085939.5478-3-jagan@amarulasolutions.com>
 <CAPnjgZ1GxCLBjdB0TQQ-5jjNnpHE11iN6b9Mv2WOdP5pmQN-LA@mail.gmail.com>
In-Reply-To: <CAPnjgZ1GxCLBjdB0TQQ-5jjNnpHE11iN6b9Mv2WOdP5pmQN-LA@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Dec 2023 10:14:28 +0530
Message-ID: <CAMty3ZAXfzKF0r_jHf-Wist4FnMHCXggSOt3RpYPuOfADAQ9Bw@mail.gmail.com>
Subject: Re: [PATCH 02/17] video: dw_hdmi: Add Vendor PHY handling
To: Simon Glass <sjg@chromium.org>
Cc: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Kever Yang <kever.yang@rock-chips.com>,
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

Hi Simon,

On Thu, Dec 14, 2023 at 1:21=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Jagan,
>
> On Mon, 11 Dec 2023 at 02:00, Jagan Teki <jagan@amarulasolutions.com> wro=
te:
> >
> > From: Jagan Teki <jagan@edgeble.ai>
> >
> > DW HDMI support Vendor PHY like Rockchip RK3328 Inno HDMI PHY.
> >
> > Extend the vendor phy handling by adding platform phy hooks.
> >
> > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> > ---
> >  drivers/video/dw_hdmi.c              | 29 +++++++++++++++++++++++++++-
> >  drivers/video/meson/meson_dw_hdmi.c  | 11 ++++++++++-
> >  drivers/video/rockchip/rk3399_hdmi.c |  8 +++++++-
> >  drivers/video/rockchip/rk_hdmi.c     |  2 +-
> >  drivers/video/sunxi/sunxi_dw_hdmi.c  | 11 ++++++++++-
> >  include/dw_hdmi.h                    | 14 +++++++++++++-
> >  6 files changed, 69 insertions(+), 6 deletions(-)
> >
>
> Isn't there a PHY framework we should use in U-Boot?

Yes, the driver is using generic PHY.

>
> Regards,
> Sim on
>
> > diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
> > index c4fbb18294..ea12a09407 100644
> > --- a/drivers/video/dw_hdmi.c
> > +++ b/drivers/video/dw_hdmi.c
> > @@ -988,7 +988,7 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const stru=
ct display_timing *edid)
> >
> >         hdmi_av_composer(hdmi, edid);
> >
> > -       ret =3D hdmi->phy_set(hdmi, edid->pixelclock.typ);
> > +       ret =3D hdmi->ops->phy_set(hdmi, edid->pixelclock.typ);
> >         if (ret)
> >                 return ret;
> >
> > @@ -1009,10 +1009,37 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const =
struct display_timing *edid)
> >         return 0;
> >  }
> >
> > +static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops =3D {
> > +       .phy_set =3D dw_hdmi_phy_cfg,
> > +};
> > +
> > +static void dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
> > +{
> > +       if (!hdmi->data)
> > +               return;
> > +
> > +       /* hook Synopsys PHYs ops */
> > +       if (!hdmi->data->phy_force_vendor) {
> > +               hdmi->ops =3D &dw_hdmi_synopsys_phy_ops;
> > +               return;
> > +       }
> > +
> > +       /* Vendor HDMI PHYs must assign phy_ops in plat_data */
> > +       if (!hdmi->data->phy_ops) {
> > +               printf("Unsupported Vendor HDMI phy_ops\n");
> > +               return;
> > +       }
> > +
> > +       /* hook Vendor HDMI PHYs ops */
> > +       hdmi->ops =3D hdmi->data->phy_ops;
> > +}
> > +
> >  void dw_hdmi_init(struct dw_hdmi *hdmi)
> >  {
> >         uint ih_mute;
> >
> > +       dw_hdmi_detect_phy(hdmi);
> > +
> >         /*
> >          * boot up defaults are:
> >          * hdmi_ih_mute   =3D 0x03 (disabled)
> > diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/=
meson_dw_hdmi.c
> > index 5db01904b5..63ca3ac52e 100644
> > --- a/drivers/video/meson/meson_dw_hdmi.c
> > +++ b/drivers/video/meson/meson_dw_hdmi.c
> > @@ -375,6 +375,15 @@ static int meson_dw_hdmi_wait_hpd(struct dw_hdmi *=
hdmi)
> >         return -ETIMEDOUT;
> >  }
> >
> > +static const struct dw_hdmi_phy_ops dw_hdmi_meson_phy_ops =3D {
> > +       .phy_set =3D meson_dw_hdmi_phy_cfg,
> > +};
> > +
> > +static const struct dw_hdmi_plat_data dw_hdmi_meson_plat_data =3D {
> > +       .phy_force_vendor =3D true,
> > +       .phy_ops =3D &dw_hdmi_meson_phy_ops,
> > +};
> > +
> >  static int meson_dw_hdmi_probe(struct udevice *dev)
> >  {
> >         struct meson_dw_hdmi *priv =3D dev_get_priv(dev);
> > @@ -397,7 +406,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
> >
> >         priv->hdmi.hdmi_data.enc_out_bus_format =3D MEDIA_BUS_FMT_RGB88=
8_1X24;
> >         priv->hdmi.hdmi_data.enc_in_bus_format =3D MEDIA_BUS_FMT_YUV8_1=
X24;
> > -       priv->hdmi.phy_set =3D meson_dw_hdmi_phy_init;
> > +       priv->hdmi.data =3D &dw_hdmi_meson_plat_data;
> >         if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A))
> >                 priv->hdmi.reg_io_width =3D 1;
> >         else {
> > diff --git a/drivers/video/rockchip/rk3399_hdmi.c b/drivers/video/rockc=
hip/rk3399_hdmi.c
> > index 3041360c6e..b32139a8a6 100644
> > --- a/drivers/video/rockchip/rk3399_hdmi.c
> > +++ b/drivers/video/rockchip/rk3399_hdmi.c
> > @@ -64,8 +64,14 @@ static const struct dm_display_ops rk3399_hdmi_ops =
=3D {
> >         .enable =3D rk3399_hdmi_enable,
> >  };
> >
> > +static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data =3D {
> > +};
> > +
> >  static const struct udevice_id rk3399_hdmi_ids[] =3D {
> > -       { .compatible =3D "rockchip,rk3399-dw-hdmi" },
> > +       {
> > +               .compatible =3D "rockchip,rk3399-dw-hdmi",
> > +               .data =3D (ulong)&rk3399_hdmi_drv_data
> > +       },
> >         { }
> >  };
> >
> > diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/=
rk_hdmi.c
> > index b75a174489..e34f532cd6 100644
> > --- a/drivers/video/rockchip/rk_hdmi.c
> > +++ b/drivers/video/rockchip/rk_hdmi.c
> > @@ -83,6 +83,7 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
> >         struct rk_hdmi_priv *priv =3D dev_get_priv(dev);
> >         struct dw_hdmi *hdmi =3D &priv->hdmi;
> >
> > +       hdmi->data =3D (const struct dw_hdmi_plat_data *)dev_get_driver=
_data(dev);
> >         hdmi->ioaddr =3D (ulong)dev_read_addr(dev);
> >         hdmi->mpll_cfg =3D rockchip_mpll_cfg;
> >         hdmi->phy_cfg =3D rockchip_phy_config;
> > @@ -90,7 +91,6 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
> >         /* hdmi->i2c_clk_{high,low} are set up by the SoC driver */
> >
> >         hdmi->reg_io_width =3D 4;
> > -       hdmi->phy_set =3D dw_hdmi_phy_cfg;
> >
> >         priv->grf =3D syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> >
> > diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/=
sunxi_dw_hdmi.c
> > index 0324a050d0..4b67a1614e 100644
> > --- a/drivers/video/sunxi/sunxi_dw_hdmi.c
> > +++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
> > @@ -369,6 +369,15 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev=
)
> >         return 0;
> >  }
> >
> > +static const struct dw_hdmi_phy_ops dw_hdmi_sunxi_phy_ops =3D {
> > +       .phy_set =3D sunxi_dw_hdmi_phy_cfg,
> > +};
> > +
> > +static const struct dw_hdmi_plat_data dw_hdmi_sunxi_plat_data =3D {
> > +       .phy_force_vendor =3D true,
> > +       .phy_ops =3D &dw_hdmi_sunxi_phy_ops,
> > +};
> > +
> >  static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
> >  {
> >         struct sunxi_dw_hdmi_priv *priv =3D dev_get_priv(dev);
> > @@ -379,7 +388,7 @@ static int sunxi_dw_hdmi_of_to_plat(struct udevice =
*dev)
> >         hdmi->i2c_clk_high =3D 0xd8;
> >         hdmi->i2c_clk_low =3D 0xfe;
> >         hdmi->reg_io_width =3D 1;
> > -       hdmi->phy_set =3D sunxi_dw_hdmi_phy_cfg;
> > +       hdmi->data =3D &dw_hdmi_sunxi_plat_data;
> >
> >         ret =3D reset_get_bulk(dev, &priv->resets);
> >         if (ret)
> > diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
> > index 8acae3839f..4ad8b39f84 100644
> > --- a/include/dw_hdmi.h
> > +++ b/include/dw_hdmi.h
> > @@ -534,6 +534,17 @@ struct hdmi_data_info {
> >         struct hdmi_vmode video_mode;
> >  };
> >
> > +struct dw_hdmi;
> > +
> > +struct dw_hdmi_phy_ops {
> > +       int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
> > +};
> > +
> > +struct dw_hdmi_plat_data {
> > +       bool phy_force_vendor;
> > +       const struct dw_hdmi_phy_ops *phy_ops;
> > +};
> > +
> >  struct dw_hdmi {
> >         ulong ioaddr;
> >         const struct hdmi_mpll_config *mpll_cfg;
> > @@ -543,8 +554,9 @@ struct dw_hdmi {
> >         u8 reg_io_width;
> >         struct hdmi_data_info hdmi_data;
> >         struct udevice *ddc_bus;
> > +       const struct dw_hdmi_phy_ops *ops;
>
> ??
>
> We should use phy.h I believe. Having said that, it sorely needs a
> proper conversion to driver model.

As I said, the driver uses generic phy with phy_ops. The above ops are
dw hdmi platform phy ops that driver uses internally for rk3328. DW
HDMI is also available for rk3228, so internal platform phy ops can
vary. The generic phy ops in the driver will call platform phy ops via
driver data.

Jagan.
