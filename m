Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26713C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A353D88794;
	Fri, 19 Apr 2024 18:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lnivtrNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3910388771; Fri, 19 Apr 2024 18:45:04 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4EB488794
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-418c2bf2f15so18887815e9.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713545100; x=1714149900; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYY6WvKTzUG4XY9pMAJTiyH/p2HZqJAY2lYg/LRx3mU=;
 b=lnivtrNdYCavtLE7O4AZr2VPweuaCH4vU7VMVcNHgCHYC15GZVdAPVoYpHRue7G/YZ
 gCCuvT9gjfAHtVqLigGnfLrOknBeBXG9Bad8znY6A1uS4UdOzPdVY28ubL60E/YvWBFe
 7uTEZA7Y9Q6wSC7/s/MYRqIvgQNhQYrE1AX7dWe7aOyNwIaWsathWrfEyWpxUbovM0cO
 7Lxc9Fp2DBM0v4xJGQG0tBRTDyPAfuI+gnqVk0WzgObuk3Gi1xC8U0kXK4zcm/9fwGJb
 z/NPACQIxnb+2Nb6FMClWUlKD7zEUoE670kPdXhFRVBPjj2zmwqsMcgthtFZPfGb3oLd
 i+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545100; x=1714149900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYY6WvKTzUG4XY9pMAJTiyH/p2HZqJAY2lYg/LRx3mU=;
 b=K+PJNp9s9TIK7QoFcjDwkTcHZkKc44KRsw7kki5Eo9BiGGrGlrBR4Egy2yGuRo6OLd
 BhpERrwvDR3j1Pt0AxIvBT9IC7GZeNtU7+foojD20GN4OuJaA8gyROW0214Xc2pt+FWa
 xdQhMtPabUQ1AIZwekMrkMyy4L4gkeehy8nP9/zc9kPkeh+klS3UN730kudRpVX6osc2
 A+iC/D0MyTIcFAMTKBDttS4t/9BaaiYlRj4eHE94KIhu4qjAIFeFSxsdw3ksKvhYz0/K
 tEkd4fMaD5UGA0mUY7ucrOT+3Io9T2z9k2/GIJ+d1dtTYjYQ0h41j/3m3OhZRtCPu3+Z
 WTvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkCeFtG8OKUO6zKRysJ5mJgkQpmSPtTc6Lz3Iyfzou0YnAX9gH7RJqSBM7DPYcKSTxLvKyzxoIOoN0Whg4xHf9yQtNCw==
X-Gm-Message-State: AOJu0Yx9dm0ocvpPQuJcc50dkkuwR07Ohn8OoxVLly06pXkNN+yv7ueD
 aExujJMU3pspS3hp/gxMQDDxSuTSnfSjCrdT2L1DQQhQnW0q11LjCIoBI/Sdp2nhZY+uoNe3Ggx
 Yktp639pUw1TUcUuhgqTL5r1gUCA=
X-Google-Smtp-Source: AGHT+IEjFoZKGmZECVU9SuXqO3zXp/eWGbNwlYDBvKeCL6IbrS0dgF96ce5d3N83IGBp+qYjG8UmtH9jAETdNAjSM2k=
X-Received: by 2002:a05:6000:b91:b0:33e:d448:e48c with SMTP id
 dl17-20020a0560000b9100b0033ed448e48cmr1588686wrb.15.1713545100000; Fri, 19
 Apr 2024 09:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-5-clamor95@gmail.com>
 <D0O8WMHSVVCR.2AAWX7HDFZTDX@gmail.com>
In-Reply-To: <D0O8WMHSVVCR.2AAWX7HDFZTDX@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Apr 2024 19:44:49 +0300
Message-ID: <CAPVz0n14o8ApBCq=vQga6fSkXg36r11Zp05ZAZ6=AO_85W_38w@mail.gmail.com>
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

=D0=BF=D1=82, 19 =D0=BA=D0=B2=D1=96=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 19:3=
8 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> > Tegra SoC has 2 independent display controllers called DC_A and
> > DC_B, they are handled differently by internal video devices like
> > DSI and HDMI controllers so it is important for last to know
> > which display controller is used to properly set up registers.
> > To achieve this, a pipe field was added to pdata to pass display
> > controller id to internal Tegra SoC devices.
> >
> > Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
> > Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
> > Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1=
565
> > Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/video/tegra20/tegra-dc.c | 6 ++++++
> >  drivers/video/tegra20/tegra-dc.h | 3 +++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/t=
egra-dc.c
> > index 5d8874f323..0e94e665ef 100644
> > --- a/drivers/video/tegra20/tegra-dc.c
> > +++ b/drivers/video/tegra20/tegra-dc.c
> > @@ -45,6 +45,7 @@ struct tegra_lcd_priv {
> >       unsigned pixel_clock;           /* Pixel clock in Hz */
> >       int dc_clk[2];                  /* Contains clk and its parent */
> >       bool rotation;                  /* 180 degree panel turn */
> > +     bool pipe;                      /* DC controller: 0 for A, 1 for =
B */
>
> Bool is a poor choice, even if there's only two of them. This is a
> proper index, so it should be some sort of integer.
>
> Also, the device tree bindings for the display controller specify a
> "nvidia,head" property that can be used to identify these. If you add
> that to the U-Boot DT you can avoid looking up by name to map this
> value.
>

Thanks for pointing to this property. May we apply this patch set as is
since it is well tested and confirmed to work and I will prepare a follow
up patches to adjust device tree relations? Would what be ok?

> Thierry
