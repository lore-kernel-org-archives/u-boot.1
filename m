Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A742C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 18:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC2580756;
	Sat, 15 Feb 2025 19:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AqzlmCFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6166280756; Sat, 15 Feb 2025 19:13:00 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2673880077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 19:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43978ae8d4fso1774845e9.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 10:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739643177; x=1740247977; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hv26eLUpcGWwgb93jOqcMmxIToRXn6wAOjXDSCCzXeg=;
 b=AqzlmCFtyZMlq60ifMBl7/3IZgYpFes2WYQ44gexDbezMQ4tXXjC1lAQVnOgD3hAwX
 qq5l6FAuQXU/3eKTm5StOjhQoL586ugYCMDcMTOE1yEwPZV183DypZ6IUNRDxhEx8YVi
 VrVrAtRBg311chZe93S1cgOmD0mLKMB3FdPYyuxIEPEQt5td2azrG2ygBXYpqN3NhGsP
 qGW6CVUZj/p3XphLU0uIgwRmNQjFAx3qrkq26yKFLbOIy+OTYlWT3DaGNYNBvCHmfJL0
 w1zBKFkyAayz/9P0GUycCTD/bvT6feCOLS5m7kQFzdFCqQxmzzZabnUNwGEV84YmzsiX
 n8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739643177; x=1740247977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hv26eLUpcGWwgb93jOqcMmxIToRXn6wAOjXDSCCzXeg=;
 b=oUgkTwl5bX3YU7H88b0ZHf/5X+2v5yrFz5Nbbmkhw2imu71f9lwpPLGU4yE2PReFlA
 d9g+zbypx1CM66hQLecDzRHjCJW7y+zkgHI7ECw5N64QBYZblCPtRn+1t7LiXGrtuFDt
 23JnZ21R4GhfstqnSn/FDlmjtwTK4QPonkjQjHeepPwuxlOg0MZAFbfQLNihfdyhDlsP
 liFvFMtd9feic3KKdqO+YmwkMFT4CqYnpIbd5TYmv/deN94+SfSPiL4ouK+D1BBPlfk0
 yTkpTpTu7SzL1eIQLP+vuZWmA4PMFyDgZxUbf4xo/wrWcqgF0JnXUNSsqQdvnR3wowrp
 TI4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGeIRBw5EtBBELsLXCQNYZkZikff85WP1w0cOdAdmaFIU2L6Sh5oh0qpOSSNq2SOjd7/0BNpY=@lists.denx.de
X-Gm-Message-State: AOJu0YyXMQ0MyB0kw/L+BHW7tMvIrCF4ZmoktyfqrUTug++Wo3kq7xjn
 VkoKs1wy6E9c+YwHakYd8+d6gC1+p3D6z1vnBs6hNCEVaKTpkALrKpMooqKlmOK+6dAXOP/O6BF
 a+xA1+b/0MJ4Wj+8SecrlH2U5JfAJVg==
X-Gm-Gg: ASbGncs3KKuOD/QpZHZ0QCEMLSuC17XTR6W8/Wa7wme40ivbfSqpv4NXcHt2L4VFnVm
 Ijy+kx07rqgiz9X0kmyLvLb47l94h5phIMvvnI0exmLLAUkMpPxejsH3UPlmIILDpH36zqSaRSw
 ==
X-Google-Smtp-Source: AGHT+IHBF5qErrZcyjBfGJsGuoxl4ZKOUdZXZNoyxTiLwdd/oVLxtLrXJ6My28r8VEKN9OcFCou7F4pklDgLES1OI7Q=
X-Received: by 2002:a05:600c:46cc:b0:439:643a:c8d3 with SMTP id
 5b1f17b1804b1-4396e73374bmr35281125e9.20.1739643177518; Sat, 15 Feb 2025
 10:12:57 -0800 (PST)
MIME-Version: 1.0
References: <20250215155155.152271-1-clamor95@gmail.com>
 <20250215155155.152271-2-clamor95@gmail.com>
 <CAFLszThi+2xLxrGk-a6=dU1OUmEDJvcCBUQ9sWTpiHw55vF7WA@mail.gmail.com>
 <CAPVz0n1bboNv7ULU026m-70w+A-4hcPSNBVvE_EO5AP_hVuW6g@mail.gmail.com>
 <CAFLszTiS7662=h6AfmciydT8BN2qMNtbTMZUn2Cocx3f_o8z0Q@mail.gmail.com>
In-Reply-To: <CAFLszTiS7662=h6AfmciydT8BN2qMNtbTMZUn2Cocx3f_o8z0Q@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 15 Feb 2025 20:12:46 +0200
X-Gm-Features: AWEUYZl9mZcy9q5aL_ndAyI63G8bSX4zgxLbYDI6Y5lxLqv-E7a_pSy9yuuOirk
Message-ID: <CAPVz0n1kXy+x+d2WQynUf26eQu5rc3jEyFwV_kJ40y=XjKazHw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] video: bridge-uclass: add get_display_timing ops
To: Simon Glass <sjg@chromium.org>
Cc: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

=D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 20:07 Simo=
n Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sat, 15 Feb 2025 at 10:42, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
> >
> > =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 19:24 =
Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > On Sat, 15 Feb 2025 at 08:52, Svyatoslav Ryhel <clamor95@gmail.com> w=
rote:
> > > >
> > > > Add get_display_timing ops for internal bridges linked to
> > > > panels that do not support EDID (MIPI-DSI panels for example)
> > > > or have EDID not routed.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
> > > >  include/video_bridge.h                     | 18 ++++++++++++++++++
> > > >  2 files changed, 29 insertions(+)
> > >
> > > This should have a test, e.g. in test/dm/video.c or similar.
> > >
> >
> > I totally agree, but it seems that there is no tests for
> > UCLASS_VIDEO_BRIDGE unless I am missing smth. May you pls point me to
> > it? Maybe I can add simple bridge analog of linux driver as sandbox
> > test case?
>
> Oh dear, that's my fault. Yes, please add something simple.
>

Surely, but I would need ofnode graph merged in first. Then I can add
simple bridge and lvds encoder in linux style. And convert simple
panel to be able to work with graph. I assume that would be correct
course.

> >
> > > >
> > > > diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/v=
ideo/bridge/video-bridge-uclass.c
> > > > index 2084a2e03ee..1b8aa12b9e8 100644
> > > > --- a/drivers/video/bridge/video-bridge-uclass.c
> > > > +++ b/drivers/video/bridge/video-bridge-uclass.c
> > > > @@ -33,6 +33,17 @@ int video_bridge_attach(struct udevice *dev)
> > > >         return ops->attach(dev);
> > > >  }
> > > >
> > > > +int video_bridge_get_display_timing(struct udevice *dev,
> > > > +                                   struct display_timing *timings)
> > > > +{
> > > > +       struct video_bridge_ops *ops =3D video_bridge_get_ops(dev);
> > > > +
> > > > +       if (!ops->get_display_timing)
> > > > +               return -ENOSYS;
> > > > +
> > > > +       return ops->get_display_timing(dev, timings);
> > > > +}
> > > > +
> > > >  int video_bridge_check_attached(struct udevice *dev)
> > > >  {
> > > >         struct video_bridge_priv *uc_priv =3D dev_get_uclass_priv(d=
ev);
> > > > diff --git a/include/video_bridge.h b/include/video_bridge.h
> > > > index 3b429eac578..3860bf2cfee 100644
> > > > --- a/include/video_bridge.h
> > > > +++ b/include/video_bridge.h
> > > > @@ -53,6 +53,16 @@ struct video_bridge_ops {
> > > >          */
> > > >         int (*set_backlight)(struct udevice *dev, int percent);
> > > >
> > > > +       /**
> > > > +        * get_display_timing() - Get display timings from bridge.
> > > > +        *
> > > > +        * @dev:        Bridge device containing the linked display=
 timings
> > > > +        * @tim:        Place to put timings
> > > > +        * @return 0 if OK, -ve on error
> > > > +        */
> > > > +       int (*get_display_timing)(struct udevice *dev,
> > > > +                                 struct display_timing *timing);
> > > > +
> > > >         /**
> > > >          * read_edid() - Read information from EDID
> > > >          *
> > > > @@ -98,6 +108,14 @@ int video_bridge_set_active(struct udevice *dev=
, bool active);
> > > >   */
> > > >  int video_bridge_check_attached(struct udevice *dev);
> > > >
> > > > +/**
> > > > + * video_bridge_get_display_timing() - Get display timings from br=
idge.
> > > > + *
> > > > + * @dev:       Bridge device containing the linked display timings
> > > > + * Return: 0 if OK, -ve on error
> > > > + */
> > > > +int video_bridge_get_display_timing(struct udevice *dev,
> > > > +                                   struct display_timing *timing);
> > > >  /**
> > > >   * video_bridge_read_edid() - Read information from EDID
> > > >   *
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > Regards,
> > > Simon
>
> Regards,
> Simon
