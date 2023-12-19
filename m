Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7276EC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E2B875B5;
	Tue, 19 Dec 2023 12:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VcSRTk8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD9C874FB; Tue, 19 Dec 2023 12:51:29 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F819875B5
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e266e8d39eso34472047b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702986685; x=1703591485;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gf8woJugJKWgHdzVrIdj5Ye/2aqTMi3n3r2fJy3NBhw=;
 b=VcSRTk8i6b9nn8shoLhvKoZoNBL4M/fj1hiX/fZ1Qpb1vVfitCZPxX/ZtClF30BPRz
 V86bQREmI8ZlWEyZpUXq6j8Cde+Lf1uaHJUetVRu2ZcoW8X+JkdAhwdCnM7t/VLs6eGy
 xrbiS+AslxYweXHcDCjFT3+n/b7L092gSL1fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702986685; x=1703591485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gf8woJugJKWgHdzVrIdj5Ye/2aqTMi3n3r2fJy3NBhw=;
 b=a8C3XUECLnzlmJ5+RQLjLZ3FxIxNzwSukT5OA+PBuZrRd0xlb/o5yS3BqvEiTFeta4
 RhCvn2qQbQLXAvY33UVgHZAw638AZc/3KW0AqKpjZIf7DNKjwDmXx2pW3hScWzbRhyK3
 o9MQ6hXNhoFNbjLuu2l+dbtMNNhkqV5WVx2dIRbG3gD5OHZyG5i3I5z+lgmOqTgvzcN8
 iH+XCYVn8r4QkxWH+ZnjGcQs8kGEmOAuOgy4MZFDd4oJX6KfzEpwLx7A85Caze9458qC
 oqbnKnUXeiXo/yWrU9VOwJayZzUScy400L7M0Rc4rO/XhcKJscMksHTQo+blqzhel0tP
 tbBQ==
X-Gm-Message-State: AOJu0Yzvb4GepHxGsQ/zeRWU1fSqZeoyNrMB1dDAHFtA+KmzBfxN8a8i
 gJZe90jfVf8wljJm83ZLrUQ2p5Dpzgb5l0Bvuwvluw==
X-Google-Smtp-Source: AGHT+IGKiTeoUcgJoNcBpIddC0ceEMVi/duG3WsxC84jNSclEijI0tTK7WEv4IT0Ej3whT7oIah2TRhZ75YblB7mqxg=
X-Received: by 2002:a0d:d485:0:b0:5e8:11f5:5064 with SMTP id
 w127-20020a0dd485000000b005e811f55064mr98948ywd.81.1702986684915; Tue, 19 Dec
 2023 03:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
 <20231218191114.129329-3-jagan@amarulasolutions.com>
 <fbdad616-21a0-4fe1-84b8-a5110ca2cd7d@linaro.org>
In-Reply-To: <fbdad616-21a0-4fe1-84b8-a5110ca2cd7d@linaro.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 19 Dec 2023 17:21:13 +0530
Message-ID: <CAMty3ZDz2vyzxMSdvhXXZrh_J_PwFJxZ5bnQtpv8qZRAtB_b5w@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] video: dw_hdmi: Add Vendor PHY handling
To: neil.armstrong@linaro.org
Cc: Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Heiko Stuebner <heiko@sntech.de>, Robin Murphy <robin.murphy@arm.com>,
 u-boot@lists.denx.de, 
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

On Tue, Dec 19, 2023 at 2:34=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 18/12/2023 20:10, Jagan Teki wrote:
> > From: Jagan Teki <jagan@edgeble.ai>
> >
> > DW HDMI support Vendor PHY like Rockchip RK3328 Inno HDMI PHY.
> >
> > Extend the vendor phy handling by adding platform phy hooks.
> >
> > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> > ---
> > Changes for v2:
> > - fix meson cfg
> >
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
>
> Sorry but I still don't understand why you need phy_force_vendor & phy_op=
s,
> this code clearly fails if you have phy_force_vendor=3Dtrue && phy_ops=3D=
NULL,
> so drop phy_force_vendor and simply use phy_ops if !=3D NULL, and since i=
t's
> the only element of dw_hdmi_plat_data, drop dw_hdmi_plat_data and pass
> dw_hdmi_phy_ops directly in the dw_hdmi struct.
>
> So in dw_hdmi_detect_phy(), if hdmi->ops is NULL, set it to dw_hdmi_synop=
sys_phy_ops.

Let me elaborate more.

DW HDMI IP must have phy ops. It never be NULL. Either it uses
1. Internal PHY via DW called them Synopsys PHYs ops - for example, rk3399
2. Vendor PHY via vendor phy meson, sunxi, rk3328

For case 1) phy_force_vendor is false so it uses dw_hdmi_synopsys_phy_ops
For case 2) phy_force_vendor is true so it uses dw_hdmi_plat_data phy ops

dw_hdmi_detect_phy assigns internal phy ops first and then vendor phy
ops based on phy_force_vendor flag.

If we remove dw_hdmi_plat_data how can we assign or differentiate two
types of phy ops hooks? can you explain?

Thanks,
Jagan.
