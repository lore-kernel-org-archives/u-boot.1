Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5AFC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F22288816;
	Fri, 19 Apr 2024 18:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lm1d82AW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8947F8880E; Fri, 19 Apr 2024 18:53:20 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0CB88816
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-418c979ddd2so16239235e9.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713545597; x=1714150397; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHLXfrq4RFWt1N1ZA7MuKmCArmtD5w878hp85Pavtgk=;
 b=lm1d82AWb68Gz8r+5NKCBJ3eY0t/QZ9ocE1kncDTaMMtAN3cWetpYgVOLeLyLPYyur
 hWSOjqY91y3LEp7XqmZwu5f6H3CJn5gC7GTy4flXEX9mLmX+qjB/a7VBw4FQdYeaV/+a
 O4Z8xu7dO5oWzNmg/0aw1MFOITmo/jt9e/yO6IvXjsKI7P+q2bTms3/Q68gCu3ApETNJ
 qP3owlTuV3OpIVIsJ07pyfHvje6MB9PSnhyoJkQyNh0lQqxS4wp50Oy2/BJuCxFPGa52
 fVBHnb4KtUpcg0YoZoH60bRrNsg/3Jb7UNRKxQq8Nq8IHxwP9k+IOk/CuUIYPd3uWk9W
 LMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545597; x=1714150397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHLXfrq4RFWt1N1ZA7MuKmCArmtD5w878hp85Pavtgk=;
 b=UbWzVWvCi4BzYaD7GGhsWqfxxGYNVy+HzyCiT7hfQG1IVczS4cF2RJziaUifFur792
 vgzk9t3HNOAx1TFqdObDhfF69Ec2keqKBWIt7adjjL4SOM3nFD6c7Cds3DTUZx/Vm+iy
 cA7MO0vOtbxpwSj1rFr4WYLHww9kJIHomqNyrDmB72PkGJV+XHU/+IQ43p5TQrs2E8GR
 wLRfKLY6bDi3ztHN/Rs6U+RqValEDRV8sfAUQnRbOK41CtdAd2XTsimE2OnXd5y5MCRp
 6bD5yXtZgd6PrgPB5OcWE6MP+197SComPzGRc7pl6yFzkcpZR4QEQblY6weFks2d9Ity
 akng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUObxlFdXse/N7M912F+xkINIEoC8AIHA54AWGPaCn1SLOZjNYUXF/2qnYGm0FpX8KrGPYgfxu1zjLIGlOCCq8brTQxQw==
X-Gm-Message-State: AOJu0YyL0Nbdm0W0nXHUWM7ZAuCZluGPWN/D5r+HlPzFOVBLWNYK6Hel
 rP3WFF4+ZIdKtfsl4jXvQ4EA5vX3Dl6iOVcl2cF2gKxZxq3mippvCoTMDoO1DUbTsJi70qPdi4z
 +6aMqCjZNM9kVmbgJXreeXVnVBSs=
X-Google-Smtp-Source: AGHT+IGo4VHgSpSLBo4rYh6lxE2y99uJnSFyKu6pH+Immw587ySlIupcDdHFO0aeLNSDmC651wQRWyEuhi8zRA8b7eM=
X-Received: by 2002:a05:600c:4e8b:b0:419:9332:b87a with SMTP id
 f11-20020a05600c4e8b00b004199332b87amr1575892wmq.16.1713545597269; Fri, 19
 Apr 2024 09:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-7-clamor95@gmail.com>
 <D0O8720SNXUY.58M29AZIXYVC@gmail.com>
 <CAPVz0n0UX1JOxyGbBgd430oMGUb7vDb5td3oZ2beMTVRa3tktQ@mail.gmail.com>
 <D0O92LGLWMLP.34AR1F3WJZQCV@gmail.com>
In-Reply-To: <D0O92LGLWMLP.34AR1F3WJZQCV@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Apr 2024 19:53:06 +0300
Message-ID: <CAPVz0n20jmaj9pOdCnVapZeu9cf-PLN=ViscLkM2WzVLzMNfVA@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] video: tegra20: dc: add reset support
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

=D0=BF=D1=82, 19 =D0=BA=D0=B2=D1=96=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 19:4=
6 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri Apr 19, 2024 at 6:37 PM CEST, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 19 =D0=BA=D0=B2=D1=96=D1=82. 2024=E2=80=AF=D1=80. =D0=BE =
19:05 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> > > > Implement reset use to discard any changes which could have been
> > > > applied to DC before and can interfere with current configuration.
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
> > > >  drivers/video/tegra20/tegra-dc.c | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > >
> > > > diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra=
20/tegra-dc.c
> > > > index 56a23b3c97..35abb6fe46 100644
> > > > --- a/drivers/video/tegra20/tegra-dc.c
> > > > +++ b/drivers/video/tegra20/tegra-dc.c
> > > > @@ -10,7 +10,9 @@
> > > >  #include <panel.h>
> > > >  #include <part.h>
> > > >  #include <pwm.h>
> > > > +#include <reset.h>
> > > >  #include <video.h>
> > > > +#include <linux/delay.h>
> > > >  #include <asm/cache.h>
> > > >  #include <asm/global_data.h>
> > > >  #include <asm/system.h>
> > > > @@ -342,6 +344,7 @@ static int tegra_lcd_probe(struct udevice *dev)
> > > >       struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
> > > >       struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
> > > >       struct tegra_lcd_priv *priv =3D dev_get_priv(dev);
> > > > +     struct reset_ctl reset_ctl;
> > > >       int ret;
> > > >
> > > >       /* Initialize the Tegra display controller */
> > > > @@ -349,6 +352,20 @@ static int tegra_lcd_probe(struct udevice *dev=
)
> > > >       funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
> > > >  #endif
> > > >
> > > > +     ret =3D reset_get_by_name(dev, "dc", &reset_ctl);
> > > > +     if (ret) {
> > > > +             log_err("reset_get_by_name() failed: %d\n", ret);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     clock_disable(priv->dc_clk[0]);
> > > > +
> > > > +     /* Reset everything set before */
> > > > +     reset_assert(&reset_ctl);
> > > > +     mdelay(4);
> > > > +     reset_deassert(&reset_ctl);
> > > > +     mdelay(4);
> > >
> > > Are you sure this works as intended? It's been a long time since I
> > > worked on this, but I seem to recall that most of these resets are
> > > actually synchronous, so in order for them to do what they're suppose=
d
> > > to the clock needs to be kept running.
> > >
> > > The Linux driver certainly does this differently.
> >
> > You have point, but I have tried to mostly adapt Linux tegra dc driver,
> > which has same logic in probe. Maybe I have not understood it properly.
> > Testing on T20, T30 and T114 passed without issues so far.
>
> Maybe look again. What it does is (basically):
>
>         clock_enable();
>         mdelay(4);
>         reset_assert();
>         mdelay(4);
>         clock_disable();
>
> That should ensure that it's completely reset at that point. Now before
> any subsequent register accesses happen it will do this:
>
>         clock_enable();
>         reset_deassert();
>
> to take it out of reset again. Perhaps that's something you want to keep
> doing in probe() in U-Boot. In that case maybe you want something like
> this instead:
>
>         clock_enable();
>         mdelay(4);
>         reset_assert();
>         mdelay(4);
>         reset_deassert();
>

You are correct. I assume This patch may be dropped entirely. Thanks.

> Thierry
