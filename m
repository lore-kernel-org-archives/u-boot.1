Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87CBC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3AD88829;
	Fri, 19 Apr 2024 18:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D1DjlKn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F366C88834; Fri, 19 Apr 2024 18:58:07 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BF3887E4
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-571e44067e0so93187a12.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713545885; x=1714150685; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l4ZjAG3rP4U/kOvDh5cGi3aCkejmQC0BVjnT5J5vOT8=;
 b=D1DjlKn7mQV/W7FuPRJo1BTXxlUaAaV1ASbg4wDmvJxJPy/wjAorIbLSiPIGrDIcjP
 tAYPa39RBD77OMutjgZy00L5cPT1RmRcU1BniuBBiD0PAdNk32e1jnGNLUamTQAE2C3A
 tH60sxgTlYrZjo6YdkY6ZZdHdXFdO5qAmCo4NpzacNSkmEhVPl47gvS2dS7aK7mRtT+R
 6EfGA7Jh4tIDMunEA+g2uyZen30X2u7nRWu3R944FUiCd0oCt6vLPnOgSUYd26GFmxTC
 zBGqUEe4qewmWKm/7EmrnNszIkRWkfIVv+IRrspZ87aljAiaEoNsls8biXp+zAhN4lS/
 QKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545885; x=1714150685;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l4ZjAG3rP4U/kOvDh5cGi3aCkejmQC0BVjnT5J5vOT8=;
 b=XzXR1YNUMkImcGvjvhpbI8UzycGtRuPlNzxsG/RiwL39yzY09G0+HbxNQVSdNoGoTo
 uiFC1raGFddLPdJcDuNPoZSZwZ9OXZU8Ld1cUET1G1iS+O5H+3pAwEv+jbwAX78JSsRY
 Z5xfszFJ3kxfv9JLiZdxvIyMbyqZWRJmvIKIMjpWm/uRqvHZ2xMp07veIwaI7jCa4q+u
 gxVUGJmA00nVDvwskwUeiYItDGIgUw3ph+buWzorG0OfY9T+ieo3WrfMrTeJNlnWnY5o
 D0g/UdIaL8jqqouin2tP905p/Yz/NrqFXCh11LTn03EWjpuBZ4EWQcnZjgmduAoznSuW
 6xDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM+y9rX8tVFPd5bGfvgOU4NV4eKQMOcSDuqgDpBf98sqYd5c04IwXPKsrGy+M9TVCykIESDFyK4z6tWGD5vxuj1oRK6g==
X-Gm-Message-State: AOJu0Yz9msgbes7L5/LvcccxohLqtC8R9HIsDK5I3W9dDM9A9Nc4vxbJ
 i8hN2diCL+/CO5+vNTyI8VLNXPe1XUoa7/Jz3DjVuOfbmFtJUqCT
X-Google-Smtp-Source: AGHT+IGnymodUHExA2RPRGvWkxyBiZQbS3BNR84fT84LTR16cbZ4RKunv3Z4c0QxcrJwOsm/VjjWvQ==
X-Received: by 2002:a17:906:d292:b0:a52:5125:9723 with SMTP id
 ay18-20020a170906d29200b00a5251259723mr1705015ejb.71.1713545885298; 
 Fri, 19 Apr 2024 09:58:05 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a1709060d8b00b00a525a18f748sm2396708eji.165.2024.04.19.09.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:58:04 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=0e8ae7b8ac1ecae429f5138b6498fcc0f0e8758c87acbf78460563aaf1d2;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:58:04 +0200
Message-Id: <D0O9BJY1DKQQ.A8OB5UNK1HM1@gmail.com>
Subject: Re: [PATCH v6 04/18] video: tegra20: dc: pass DC id to internal
 devices
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: "Thierry Reding" <treding@nvidia.com>, "Anatolij Gustschin"
 <agust@denx.de>, "Simon Glass" <sjg@chromium.org>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-5-clamor95@gmail.com>
 <D0O8WMHSVVCR.2AAWX7HDFZTDX@gmail.com>
 <CAPVz0n14o8ApBCq=vQga6fSkXg36r11Zp05ZAZ6=AO_85W_38w@mail.gmail.com>
In-Reply-To: <CAPVz0n14o8ApBCq=vQga6fSkXg36r11Zp05ZAZ6=AO_85W_38w@mail.gmail.com>
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

--0e8ae7b8ac1ecae429f5138b6498fcc0f0e8758c87acbf78460563aaf1d2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 19, 2024 at 6:44 PM CEST, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 19 =D0=BA=D0=B2=D1=96=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 19=
:38 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> > > Tegra SoC has 2 independent display controllers called DC_A and
> > > DC_B, they are handled differently by internal video devices like
> > > DSI and HDMI controllers so it is important for last to know
> > > which display controller is used to properly set up registers.
> > > To achieve this, a pipe field was added to pdata to pass display
> > > controller id to internal Tegra SoC devices.
> > >
> > > Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
> > > Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
> > > Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper =
E1565
> > > Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> > > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T1=
14
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/video/tegra20/tegra-dc.c | 6 ++++++
> > >  drivers/video/tegra20/tegra-dc.h | 3 +++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20=
/tegra-dc.c
> > > index 5d8874f323..0e94e665ef 100644
> > > --- a/drivers/video/tegra20/tegra-dc.c
> > > +++ b/drivers/video/tegra20/tegra-dc.c
> > > @@ -45,6 +45,7 @@ struct tegra_lcd_priv {
> > >       unsigned pixel_clock;           /* Pixel clock in Hz */
> > >       int dc_clk[2];                  /* Contains clk and its parent =
*/
> > >       bool rotation;                  /* 180 degree panel turn */
> > > +     bool pipe;                      /* DC controller: 0 for A, 1 fo=
r B */
> >
> > Bool is a poor choice, even if there's only two of them. This is a
> > proper index, so it should be some sort of integer.
> >
> > Also, the device tree bindings for the display controller specify a
> > "nvidia,head" property that can be used to identify these. If you add
> > that to the U-Boot DT you can avoid looking up by name to map this
> > value.
> >
>
> Thanks for pointing to this property. May we apply this patch set as is
> since it is well tested and confirmed to work and I will prepare a follow
> up patches to adjust device tree relations? Would what be ok?

Well, there's a few other things that I think should be addressed, but
if you'd like to keep this one patch as-is and clean this up later, I
guess that's fine.

Thierry

--0e8ae7b8ac1ecae429f5138b6498fcc0f0e8758c87acbf78460563aaf1d2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYiopwACgkQ3SOs138+
s6FrPg//XxoH827AUT9kE/wQAUMXEiA1K4wdaJga0F/RjQAHuEllee5K/4C4YVja
0G1e1vuKv/oUkOYzcsQhu6XsyDcWNGOzz3oG2mOHhGZwB2lk4k3SmDBd9qfrIbWq
dnLJJm9AVbbA+zuJrzEgx9F9e3m16VPjvVR2N/9GwNnMyokvLLclWv5teclXOxWM
cWXTE1ZPf/cCxqdyA8D5/zJqQl7f8ojbijxsCNHOE4R05hDvfIJutgHlSS9+MCqq
u/mlmL6gDWFk8er/JZSU05uW9VfJeM1z8NYSvDWzt0pbQoTGd9BPCWLsjrp+RNmb
0jVe2wiOHDjhMBP171FVV5sGzOvFfuMN4az/po+tJQOLnv3gZhaQYuK/PMn4GBhk
s9VJ64fde4WO2JrzWBn9J+3chw2RSCxlvRWi4rkTm5WhUWrA+3LEIUI1FNA18X/k
UkW9TklLihSzn/RfJ8u43gdV877KjfY0A6xezrSYTg69KxkGIVCDeIe0QUfNNRG6
2Ye0bTu5fm15x3QVWp3wNl2VSnl+VEnm6yyK/4XtTIudZdpQQf3HgPyFRtddDIoJ
bxHwoMq8E9fHeu5WT6Hk42aQ8/7p9luEKapv/BIK9jykZ0t2u/F+pO8whi8ziwX9
8LhFsTP+m0UniAW0/ICt95yXfvc+J4Z3FZnI9zrq8nNbtdEM8M8=
=feQb
-----END PGP SIGNATURE-----

--0e8ae7b8ac1ecae429f5138b6498fcc0f0e8758c87acbf78460563aaf1d2--
