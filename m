Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A070C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 17:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6DCD88807;
	Fri, 19 Apr 2024 19:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qr2i6LSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB77E88800; Fri, 19 Apr 2024 19:02:24 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7861988807
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 19:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34a32ba1962so1184669f8f.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713546141; x=1714150941; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiSkm1yhXJqzU5BMWf4B86NZmY0Ecywx1vkdNxZwofc=;
 b=Qr2i6LSLoQojkpkoIz5FXtRuIw1yQ5DbkgFV+kfzVeC1sp2qhTnW9SL6nfx+shRdJe
 blrEOze7VAdBwUQNgxNbodmnvfmNUTIbxYxI88jQ02paU2MmX2ippPSo6UcEX2k0E92P
 g63Q41dk38yUPZ21hVbWNjOPaHrsQUcsQc/8GDyqPBbJEIqgGDsPz0BA8vDvx94lzuMW
 r+Y6FrkLP6rSkNRiPA5DLipXEmiv3o2JlGmabRvT7GZV8BIyTe5BgYTZ+qDM6RCXnRnq
 iXGrxhSBBgouiMMe6DgDY6wIFG2cZ2H3nByOUuxylPCJRDsjetHUOC8TQx9w0a7kH3na
 ioDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713546141; x=1714150941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiSkm1yhXJqzU5BMWf4B86NZmY0Ecywx1vkdNxZwofc=;
 b=EcmwsRKMPdKdpJTqu5T3nPlbZenz4FxTdBW085/KmTq7l4AAp3kSV4TlFP/RRINOHU
 gHmCmTaekUds7flJ0BOO13BYBDXIa68OBezUjoOJDL74H6T0Oyd/8BRmyFxqmG5L79pS
 FK1ige8sQXApRsomVijEEZP0ku4XZEx9pZnKLlU5y4vmstZSp4aZVvhcdvPO1t5hHqIc
 7EOSEd4L7j/1Jl7ecQnkCCQxmtEWCIoPrOIduNygAGKyWd9p3PtMUcg/RkxjLU6wzYi2
 GaXYGxaa/by04pU9jCt59jdktiDzHKXasD5HRD90ymeiOqRg+riwcbOcaB2XKsZa8k3i
 WZWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2R3MVAobvRJ/Y87BrrkyvPYhJ0OzSyFybHL56BPH4asst/JCOedQSe0eiZPJKkWggnlyt/CKqg2a+NVVjLVeG5RQxBA==
X-Gm-Message-State: AOJu0YxjEUd0Z6+jeu9i8WoHqlqzu0KrwxmvQGczEGrleQEfJJsLWbGX
 p4VjgfyJGjLnn24zXfU1+JxdV7U2ccHRltcGg1ePwBPG6eKZU+PlRUjrHgtworeSyRa+qhQim5r
 ciK+H2r4hiv0MzkGOLT0jUNNuKEU=
X-Google-Smtp-Source: AGHT+IFyyBAQyHOvK2fqzmb8k7WXaNZtk1KOxnTDts+6X2bKpIZsj7BxN1n/R8n9OYQYPKbZpfgr0W9l/3jPXq/chHs=
X-Received: by 2002:adf:eb0b:0:b0:349:cc20:2030 with SMTP id
 s11-20020adfeb0b000000b00349cc202030mr1812557wrn.51.1713546140723; Fri, 19
 Apr 2024 10:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-5-clamor95@gmail.com>
 <D0O8WMHSVVCR.2AAWX7HDFZTDX@gmail.com>
 <CAPVz0n14o8ApBCq=vQga6fSkXg36r11Zp05ZAZ6=AO_85W_38w@mail.gmail.com>
 <D0O9BJY1DKQQ.A8OB5UNK1HM1@gmail.com>
In-Reply-To: <D0O9BJY1DKQQ.A8OB5UNK1HM1@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Apr 2024 20:02:09 +0300
Message-ID: <CAPVz0n1Cyr-HyPhDu-FxDO8PSuL7_QgBA-zXYrzkm4e+h-8niw@mail.gmail.com>
Subject: Re: [PATCH v6 04/18] video: tegra20: dc: pass DC id to internal
 devices
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

=D0=BF=D1=82, 19 =D0=BA=D0=B2=D1=96=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 19:5=
8 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri Apr 19, 2024 at 6:44 PM CEST, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 19 =D0=BA=D0=B2=D1=96=D1=82. 2024=E2=80=AF=D1=80. =D0=BE =
19:38 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> > > > Tegra SoC has 2 independent display controllers called DC_A and
> > > > DC_B, they are handled differently by internal video devices like
> > > > DSI and HDMI controllers so it is important for last to know
> > > > which display controller is used to properly set up registers.
> > > > To achieve this, a pipe field was added to pdata to pass display
> > > > controller id to internal Tegra SoC devices.
> > > >
> > > > Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
> > > > Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
> > > > Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Groupe=
r E1565
> > > > Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> > > > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab =
T114
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/video/tegra20/tegra-dc.c | 6 ++++++
> > > >  drivers/video/tegra20/tegra-dc.h | 3 +++
> > > >  2 files changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra=
20/tegra-dc.c
> > > > index 5d8874f323..0e94e665ef 100644
> > > > --- a/drivers/video/tegra20/tegra-dc.c
> > > > +++ b/drivers/video/tegra20/tegra-dc.c
> > > > @@ -45,6 +45,7 @@ struct tegra_lcd_priv {
> > > >       unsigned pixel_clock;           /* Pixel clock in Hz */
> > > >       int dc_clk[2];                  /* Contains clk and its paren=
t */
> > > >       bool rotation;                  /* 180 degree panel turn */
> > > > +     bool pipe;                      /* DC controller: 0 for A, 1 =
for B */
> > >
> > > Bool is a poor choice, even if there's only two of them. This is a
> > > proper index, so it should be some sort of integer.
> > >
> > > Also, the device tree bindings for the display controller specify a
> > > "nvidia,head" property that can be used to identify these. If you add
> > > that to the U-Boot DT you can avoid looking up by name to map this
> > > value.
> > >
> >
> > Thanks for pointing to this property. May we apply this patch set as is
> > since it is well tested and confirmed to work and I will prepare a foll=
ow
> > up patches to adjust device tree relations? Would what be ok?
>
> Well, there's a few other things that I think should be addressed, but
> if you'd like to keep this one patch as-is and clean this up later, I
> guess that's fine.

May you send me a list of stuff which you think may be improved?
I would gladly adjust whatever I can in follow up.

> Thierry
