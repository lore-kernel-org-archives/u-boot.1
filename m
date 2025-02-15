Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B00C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 18:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE5980756;
	Sat, 15 Feb 2025 19:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f2li0NwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EAA3809A4; Sat, 15 Feb 2025 19:07:38 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54BFF80077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 19:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ab7fa1bc957so545201966b.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 10:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739642856; x=1740247656; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rQW2/E49o+wku+fmk8Sm1h1+0kDHln7NZWp8nFwDzA=;
 b=f2li0NwTmDhJhyPV6S5n6+z2000lxt8sbMNjm9wkkZCPPhAZm7RLvOAXpIxt0s/k1K
 FmbkKyHgJL6jV/0PXAaIhgh1S+eCmuFz/uxqhWAAs2DwK4RrC2bZyYU/QyR+bmRJnAHF
 vJSqS49BtySibI4hqo+GZmqnhsTD0qBXf0F0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739642856; x=1740247656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rQW2/E49o+wku+fmk8Sm1h1+0kDHln7NZWp8nFwDzA=;
 b=e7NR3YDKblU1jbeE13qzhe7NjstBgUPDoRAG6gCsJZuMiAUZ1YF/MqzVF3Hz7A0nOZ
 iAC9L7Qyc0OriN74ukmRavNUBaj7+TtNFrPsf4qweVHF3vxCFJh12dBt1+lbB1j8+VkM
 CLhX7ecwiU1gRDdKt4lGptLmN0IgwlOT68EbXrn9LWrWelSldlnwS7pwGLtmXhyjfM6E
 jMYFPhawiZfe6ivqD8Uh1rodBs10oreIcB5FDgmKu+D1FojupZ7W9xMxNtt4pcf0cHK5
 1sbEbLheIrEPZethlUoWiU/w8dYbINSeri5lxbOO9QNv0scKQ8Tu76LEyipmkTzNNBAP
 rtMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPPm+oZx4X6eLbCXoMp0WkjxVD76i+UpRDRx7QHfWaggd0GnKOl54fk+qbhQ3u3q0ObEqQod0=@lists.denx.de
X-Gm-Message-State: AOJu0YzOkZBkk4TwSHgPW96BGEM91V2KyF/E6FX6GV+lA3tafrwXaNrq
 A77jfuaoClMazoQJSdysiHaF6E3zFO/o2jJya7TJOvy6JngqKMX4aprOUCQ5X0DKMIeiev1Rk3p
 YFC52yCAMOk5CDmNGneLraWfBiQPhHiiELZ8i
X-Gm-Gg: ASbGncuNvzRc8Tt9BMz9oTe/3Vst3bvf5XljI+K/SJqHaJAzAU6/cZ7525UhIvTup8l
 dNP9320BSaNHyFjClNzA8OC1f3kWiZIu1nT9wBR9rl227XJKCBcNSMqrZnJmW2dcmNAz5I3Ndag
 ==
X-Google-Smtp-Source: AGHT+IFYrMg6+EyPVBuJe4MQ3uDq42zxEzppuEj7ZFyv4o6zfXyJv2I0QB78rPs8HSkPUgZpVCBxzpUUyukvcRVW3sQ=
X-Received: by 2002:a17:906:6a03:b0:ab7:b41d:bdb5 with SMTP id
 a640c23a62f3a-abb7115d691mr365658566b.45.1739642855605; Sat, 15 Feb 2025
 10:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20250215155155.152271-1-clamor95@gmail.com>
 <20250215155155.152271-2-clamor95@gmail.com>
 <CAFLszThi+2xLxrGk-a6=dU1OUmEDJvcCBUQ9sWTpiHw55vF7WA@mail.gmail.com>
 <CAPVz0n1bboNv7ULU026m-70w+A-4hcPSNBVvE_EO5AP_hVuW6g@mail.gmail.com>
In-Reply-To: <CAPVz0n1bboNv7ULU026m-70w+A-4hcPSNBVvE_EO5AP_hVuW6g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 11:07:22 -0700
X-Gm-Features: AWEUYZl5UIGiOWed3jO3Z_uLAJgXVHtQ4GRov8tYZ2nG61emsCAMjmB0KLOxeZ0
Message-ID: <CAFLszTiS7662=h6AfmciydT8BN2qMNtbTMZUn2Cocx3f_o8z0Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] video: bridge-uclass: add get_display_timing ops
To: Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi Svyatoslav,

On Sat, 15 Feb 2025 at 10:42, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 19:24 Si=
mon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> >
> > On Sat, 15 Feb 2025 at 08:52, Svyatoslav Ryhel <clamor95@gmail.com> wro=
te:
> > >
> > > Add get_display_timing ops for internal bridges linked to
> > > panels that do not support EDID (MIPI-DSI panels for example)
> > > or have EDID not routed.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
> > >  include/video_bridge.h                     | 18 ++++++++++++++++++
> > >  2 files changed, 29 insertions(+)
> >
> > This should have a test, e.g. in test/dm/video.c or similar.
> >
>
> I totally agree, but it seems that there is no tests for
> UCLASS_VIDEO_BRIDGE unless I am missing smth. May you pls point me to
> it? Maybe I can add simple bridge analog of linux driver as sandbox
> test case?

Oh dear, that's my fault. Yes, please add something simple.

>
> > >
> > > diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/vid=
eo/bridge/video-bridge-uclass.c
> > > index 2084a2e03ee..1b8aa12b9e8 100644
> > > --- a/drivers/video/bridge/video-bridge-uclass.c
> > > +++ b/drivers/video/bridge/video-bridge-uclass.c
> > > @@ -33,6 +33,17 @@ int video_bridge_attach(struct udevice *dev)
> > >         return ops->attach(dev);
> > >  }
> > >
> > > +int video_bridge_get_display_timing(struct udevice *dev,
> > > +                                   struct display_timing *timings)
> > > +{
> > > +       struct video_bridge_ops *ops =3D video_bridge_get_ops(dev);
> > > +
> > > +       if (!ops->get_display_timing)
> > > +               return -ENOSYS;
> > > +
> > > +       return ops->get_display_timing(dev, timings);
> > > +}
> > > +
> > >  int video_bridge_check_attached(struct udevice *dev)
> > >  {
> > >         struct video_bridge_priv *uc_priv =3D dev_get_uclass_priv(dev=
);
> > > diff --git a/include/video_bridge.h b/include/video_bridge.h
> > > index 3b429eac578..3860bf2cfee 100644
> > > --- a/include/video_bridge.h
> > > +++ b/include/video_bridge.h
> > > @@ -53,6 +53,16 @@ struct video_bridge_ops {
> > >          */
> > >         int (*set_backlight)(struct udevice *dev, int percent);
> > >
> > > +       /**
> > > +        * get_display_timing() - Get display timings from bridge.
> > > +        *
> > > +        * @dev:        Bridge device containing the linked display t=
imings
> > > +        * @tim:        Place to put timings
> > > +        * @return 0 if OK, -ve on error
> > > +        */
> > > +       int (*get_display_timing)(struct udevice *dev,
> > > +                                 struct display_timing *timing);
> > > +
> > >         /**
> > >          * read_edid() - Read information from EDID
> > >          *
> > > @@ -98,6 +108,14 @@ int video_bridge_set_active(struct udevice *dev, =
bool active);
> > >   */
> > >  int video_bridge_check_attached(struct udevice *dev);
> > >
> > > +/**
> > > + * video_bridge_get_display_timing() - Get display timings from brid=
ge.
> > > + *
> > > + * @dev:       Bridge device containing the linked display timings
> > > + * Return: 0 if OK, -ve on error
> > > + */
> > > +int video_bridge_get_display_timing(struct udevice *dev,
> > > +                                   struct display_timing *timing);
> > >  /**
> > >   * video_bridge_read_edid() - Read information from EDID
> > >   *
> > > --
> > > 2.43.0
> > >
> >
> > Regards,
> > Simon

Regards,
Simon
