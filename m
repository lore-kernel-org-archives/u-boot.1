Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC3C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A23080756;
	Sat, 15 Feb 2025 18:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TGLDcTo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C251809A4; Sat, 15 Feb 2025 18:42:08 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF5A80077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f2c4382d1so987503f8f.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739641326; x=1740246126; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DmrJar85BnBiRzkj/RQ1DCNGEJhTuh4/ZcS/01mIfU=;
 b=TGLDcTo+fdviTlaQMtV73wulvwc6DzXjG+hGfK7ocCrVQR4F81fkhODFExciEVFp6M
 d/QgR2P7NjnUIMTuGdgxs7TQ/B1o+eC0yjn6GU1TL9uVevxkJa0up24rH7ptPqrW2q42
 KkgRv58YIc3fHqHkHMoaFI/Yz0kNE50uGnAlokBCPeCCiD0SqARSSNBLNHXt5HEEsfxY
 UJC3+hjqvfyk7oDDRFHOpF2B0Emnpr/XfYunL2BYG8EBFpKwSuqOWnsnKz+pF48Kti26
 7lDE9FIGqEt45DaMKd/a77ks4UZwu0EPwp4XrtzxK6SZZMXsCo//azXlQQv+KmWurjFj
 bPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739641326; x=1740246126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DmrJar85BnBiRzkj/RQ1DCNGEJhTuh4/ZcS/01mIfU=;
 b=Rl97VHLCtIoweGhTsvgSaVmznDt6juYnI96nDvk7WtlJnNvUbaoT5WsAmuNkOeM+Pe
 OyOH6JcT1In81GqCnBKkhq8COjeZaJvzTfvDJf+7PiRwUzwCyva++oKkvpM5AE8juG2b
 gjkqe/NvCP+ADuiIBaA9uxx95GOgsa3SXmG9MmS9gdglvQ7BJEq5j1nSbUu8OjuD4MGA
 4Y8cR+muTin3Xr7yD4w+oGm8TfEnmLIhvvaiV4mX645mpAIa0ApbG7VB37MVcnikB1wQ
 BglNMhWg4Ec5ONct/hmH1hVUdfwdmjy+NULCEZ8pe3Re0lwIlttTbfjzMiAVZFPzlxLq
 XGlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Yzn3OGPwx5rIgP5ro+XxjQa8shHT0jpKK7V4K+UE4kDrDNqXCzO/mLEwBXEMaH/jijrLK+M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0bm9GCwXyPKlPcS/BStQ1S3A5qFLU4Zd7CI6a6DK1ygVry46d
 vgy3OvTlr1XpRx7u93T97qovpLPCH7VnHYxEs8qHP6KCRmi9grZP53HYPR0HqxJ+/bH/swtXI0h
 Dvpzs7JECb1kzsgU4u/lz9uhUBbY=
X-Gm-Gg: ASbGncu8pO4kGIhDSpM+QLRuEL0pUBmRSIBWnylmcRzFJfJZLRYMi4j4MpFCSxN9BI9
 Imz8iHk2xpFCkEToJuomIRcFcsE+HlRQtk72cDWPSjtuKKvfnL2W/0Iiwqj3lAy7riJBi7EU/lQ
 ==
X-Google-Smtp-Source: AGHT+IHoMWlgTpsAkkF5TvPkyi53cfQqkbP8UBjnQVUqzdJjkOzKwBgZ578rnTJOxCw4Wm4224PUAKda9rOdSCv0vxg=
X-Received: by 2002:adf:9bdd:0:b0:38d:dffc:c14f with SMTP id
 ffacd0b85a97d-38f24ce77dcmr11024100f8f.1.1739641325705; Sat, 15 Feb 2025
 09:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20250215155155.152271-1-clamor95@gmail.com>
 <20250215155155.152271-2-clamor95@gmail.com>
 <CAFLszThi+2xLxrGk-a6=dU1OUmEDJvcCBUQ9sWTpiHw55vF7WA@mail.gmail.com>
In-Reply-To: <CAFLszThi+2xLxrGk-a6=dU1OUmEDJvcCBUQ9sWTpiHw55vF7WA@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 15 Feb 2025 19:41:54 +0200
X-Gm-Features: AWEUYZn_kj1iUUUn2Cv6SQ8pCtVGiu9A7qU8NsvNxr_m0w6DrBvA9-P5qBLeQ7g
Message-ID: <CAPVz0n1bboNv7ULU026m-70w+A-4hcPSNBVvE_EO5AP_hVuW6g@mail.gmail.com>
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

=D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 19:24 Simo=
n Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Sat, 15 Feb 2025 at 08:52, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
> >
> > Add get_display_timing ops for internal bridges linked to
> > panels that do not support EDID (MIPI-DSI panels for example)
> > or have EDID not routed.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
> >  include/video_bridge.h                     | 18 ++++++++++++++++++
> >  2 files changed, 29 insertions(+)
>
> This should have a test, e.g. in test/dm/video.c or similar.
>

I totally agree, but it seems that there is no tests for
UCLASS_VIDEO_BRIDGE unless I am missing smth. May you pls point me to
it? Maybe I can add simple bridge analog of linux driver as sandbox
test case?

> >
> > diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/video=
/bridge/video-bridge-uclass.c
> > index 2084a2e03ee..1b8aa12b9e8 100644
> > --- a/drivers/video/bridge/video-bridge-uclass.c
> > +++ b/drivers/video/bridge/video-bridge-uclass.c
> > @@ -33,6 +33,17 @@ int video_bridge_attach(struct udevice *dev)
> >         return ops->attach(dev);
> >  }
> >
> > +int video_bridge_get_display_timing(struct udevice *dev,
> > +                                   struct display_timing *timings)
> > +{
> > +       struct video_bridge_ops *ops =3D video_bridge_get_ops(dev);
> > +
> > +       if (!ops->get_display_timing)
> > +               return -ENOSYS;
> > +
> > +       return ops->get_display_timing(dev, timings);
> > +}
> > +
> >  int video_bridge_check_attached(struct udevice *dev)
> >  {
> >         struct video_bridge_priv *uc_priv =3D dev_get_uclass_priv(dev);
> > diff --git a/include/video_bridge.h b/include/video_bridge.h
> > index 3b429eac578..3860bf2cfee 100644
> > --- a/include/video_bridge.h
> > +++ b/include/video_bridge.h
> > @@ -53,6 +53,16 @@ struct video_bridge_ops {
> >          */
> >         int (*set_backlight)(struct udevice *dev, int percent);
> >
> > +       /**
> > +        * get_display_timing() - Get display timings from bridge.
> > +        *
> > +        * @dev:        Bridge device containing the linked display tim=
ings
> > +        * @tim:        Place to put timings
> > +        * @return 0 if OK, -ve on error
> > +        */
> > +       int (*get_display_timing)(struct udevice *dev,
> > +                                 struct display_timing *timing);
> > +
> >         /**
> >          * read_edid() - Read information from EDID
> >          *
> > @@ -98,6 +108,14 @@ int video_bridge_set_active(struct udevice *dev, bo=
ol active);
> >   */
> >  int video_bridge_check_attached(struct udevice *dev);
> >
> > +/**
> > + * video_bridge_get_display_timing() - Get display timings from bridge=
.
> > + *
> > + * @dev:       Bridge device containing the linked display timings
> > + * Return: 0 if OK, -ve on error
> > + */
> > +int video_bridge_get_display_timing(struct udevice *dev,
> > +                                   struct display_timing *timing);
> >  /**
> >   * video_bridge_read_edid() - Read information from EDID
> >   *
> > --
> > 2.43.0
> >
>
> Regards,
> Simon
