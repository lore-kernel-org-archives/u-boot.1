Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8E5C4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 20:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1754F87729;
	Tue,  9 Jan 2024 21:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fYcubZAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D91888786E; Tue,  9 Jan 2024 21:04:57 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF1987509
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 21:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dbd029beef4so3387299276.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 12:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704830694; x=1705435494;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0I3+gx0YUCSFwqVvtkMOJL4PE2ISB9k3HLQ3gZvY2b8=;
 b=fYcubZAktYS9W5eR2DoG8voXM68JO1t0fJWA870ZwcYkgtOg7YzO1tUDm5T0Mvn/N4
 ZnHGvB2yKXq0U3VUz8lxjgNr8hVbpzNXccnYRGOQq9BR3+DAKRS2/ZI34i6T9MzMD6Ji
 2ldSR0Walv3BUCxNZA0H6OQoUD3xiI5/bJKxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704830694; x=1705435494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0I3+gx0YUCSFwqVvtkMOJL4PE2ISB9k3HLQ3gZvY2b8=;
 b=wHUg8F4g27s0xtiYFXwezWmBdsbBWhLT193OBLh903k8V2E2lMazZ4+uAwScb6ppYD
 srkW+7ygqOkpNRP0QA0iykVEU4B4gJQIpXyOWrPTVHb3LODkFQl2JzTHMHFpNUYphFhh
 nuVVuwIRK3F7Bsiz8c/oBinF6NS5v+fnBVxc5PD074hF2c3Kb5sJt7JfRisYW+cdK6oe
 SaBXEn+MZ7dTENp1tZxjTl6eZi1Cx6agfCiajqA0mqlsqcgHrFd7FDT4MhyWQT8IcLCO
 4IAp3fYJphfF/MBVVGx5fLlkgDNJuuk+VlnXI6M5ZeXL7/WmjVDbghFsMuYfHLNnZ/mB
 u+1w==
X-Gm-Message-State: AOJu0Ywylz8yVIwJDVVT6PRDYmpYTnPXxhlUIuOG/IQrvkYfJU0xdpdA
 ZHKklEQaiKOc4rbDP+6GyzpTbsrSF2oEoZ6ir9nB8EIZehr9Aw==
X-Google-Smtp-Source: AGHT+IH5E0kmpetX32z4gqvznfVaPobdGvkcADSa1oq/4eBC5LLaHiybNSBxnHS2PbQ9zJP2gHHeDiUJ907fuKsA8CM=
X-Received: by 2002:a05:6902:504:b0:dbd:d003:3c16 with SMTP id
 x4-20020a056902050400b00dbdd0033c16mr834597ybs.9.1704830694042; Tue, 09 Jan
 2024 12:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
 <20231218191114.129329-3-jagan@amarulasolutions.com>
 <fbdad616-21a0-4fe1-84b8-a5110ca2cd7d@linaro.org>
 <CAMty3ZDz2vyzxMSdvhXXZrh_J_PwFJxZ5bnQtpv8qZRAtB_b5w@mail.gmail.com>
In-Reply-To: <CAMty3ZDz2vyzxMSdvhXXZrh_J_PwFJxZ5bnQtpv8qZRAtB_b5w@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 10 Jan 2024 01:34:42 +0530
Message-ID: <CAMty3ZB9CBUAz9OdKpkirukwMSWtBGAMzL5ObJf4gsR6W7TCfw@mail.gmail.com>
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

Hi Neil,

On Tue, Dec 19, 2023 at 5:21=E2=80=AFPM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> On Tue, Dec 19, 2023 at 2:34=E2=80=AFPM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> >
> > On 18/12/2023 20:10, Jagan Teki wrote:
> > > From: Jagan Teki <jagan@edgeble.ai>
> > >
> > > DW HDMI support Vendor PHY like Rockchip RK3328 Inno HDMI PHY.
> > >
> > > Extend the vendor phy handling by adding platform phy hooks.
> > >
> > > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> > > ---
> > > Changes for v2:
> > > - fix meson cfg
> > >
> > >   drivers/video/dw_hdmi.c              | 29 +++++++++++++++++++++++++=
++-
> > >   drivers/video/meson/meson_dw_hdmi.c  | 11 ++++++++++-
> > >   drivers/video/rockchip/rk3399_hdmi.c |  8 +++++++-
> > >   drivers/video/rockchip/rk_hdmi.c     |  2 +-
> > >   drivers/video/sunxi/sunxi_dw_hdmi.c  | 11 ++++++++++-
> > >   include/dw_hdmi.h                    | 14 +++++++++++++-
> > >   6 files changed, 69 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
> > > index c4fbb18294..ea12a09407 100644
> > > --- a/drivers/video/dw_hdmi.c
> > > +++ b/drivers/video/dw_hdmi.c
> > > @@ -988,7 +988,7 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const st=
ruct display_timing *edid)
> > >
> > >       hdmi_av_composer(hdmi, edid);
> > >
> > > -     ret =3D hdmi->phy_set(hdmi, edid->pixelclock.typ);
> > > +     ret =3D hdmi->ops->phy_set(hdmi, edid->pixelclock.typ);
> > >       if (ret)
> > >               return ret;
> > >
> > > @@ -1009,10 +1009,37 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, cons=
t struct display_timing *edid)
> > >       return 0;
> > >   }
> > >
> > > +static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops =3D {
> > > +     .phy_set =3D dw_hdmi_phy_cfg,
> > > +};
> > > +
> > > +static void dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
> > > +{
> > > +     if (!hdmi->data)
> > > +             return;
> > > +
> > > +     /* hook Synopsys PHYs ops */
> > > +     if (!hdmi->data->phy_force_vendor) {
> > > +             hdmi->ops =3D &dw_hdmi_synopsys_phy_ops;
> > > +             return;
> > > +     }
> > > +
> > > +     /* Vendor HDMI PHYs must assign phy_ops in plat_data */
> > > +     if (!hdmi->data->phy_ops) {
> > > +             printf("Unsupported Vendor HDMI phy_ops\n");
> > > +             return;
> > > +     }
> > > +
> > > +     /* hook Vendor HDMI PHYs ops */
> > > +     hdmi->ops =3D hdmi->data->phy_ops;
> >
> > Sorry but I still don't understand why you need phy_force_vendor & phy_=
ops,
> > this code clearly fails if you have phy_force_vendor=3Dtrue && phy_ops=
=3DNULL,
> > so drop phy_force_vendor and simply use phy_ops if !=3D NULL, and since=
 it's
> > the only element of dw_hdmi_plat_data, drop dw_hdmi_plat_data and pass
> > dw_hdmi_phy_ops directly in the dw_hdmi struct.
> >
> > So in dw_hdmi_detect_phy(), if hdmi->ops is NULL, set it to dw_hdmi_syn=
opsys_phy_ops.
>
> Let me elaborate more.
>
> DW HDMI IP must have phy ops. It never be NULL. Either it uses
> 1. Internal PHY via DW called them Synopsys PHYs ops - for example, rk339=
9
> 2. Vendor PHY via vendor phy meson, sunxi, rk3328
>
> For case 1) phy_force_vendor is false so it uses dw_hdmi_synopsys_phy_ops
> For case 2) phy_force_vendor is true so it uses dw_hdmi_plat_data phy ops
>
> dw_hdmi_detect_phy assigns internal phy ops first and then vendor phy
> ops based on phy_force_vendor flag.
>
> If we remove dw_hdmi_plat_data how can we assign or differentiate two
> types of phy ops hooks? can you explain?

Let me know if you have any comments on this. I'm sending V3 would
probably hit in MW.

Thanks,
Jagan.
