Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639ECC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD09887DA;
	Fri, 19 Apr 2024 18:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kiKtOU+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86936887E4; Fri, 19 Apr 2024 18:37:56 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9185588742
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34a32ba1962so1170973f8f.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713544674; x=1714149474; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVMdpEl3o+JvqSWgyFBJI+iH5+KtNXAMnsFoeqkjO4Y=;
 b=kiKtOU+k8oA7cysPu4XPqfm3KOVdq4pHLwsYbr0AplbtUHPi6kZXRiThtNMgXF1BVP
 2OWphlNvSJCBork7rMhM6wttToHEjIJ6P8RI9nDlmb2FgvHIWUmV0jdadk+KTkTlpyeK
 CpRCigdG6vxgnnn2jKv34QwwBV7iNJ3+wMfzktHiLDWZVBkStJs9xe9+QQTz/0au+srl
 xaeFexbH8kbdeqdfKyxGwKsk7YsgdA+c6Fzwy1Oc7BUOAGxHWOeXvlbgRrnNd94mnrN1
 4QLTcDUEo+9vdGOW1qVG4sSP/EnvuJstGEjJo3neK2924zzAl7xapBji26th2E/li621
 MDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544674; x=1714149474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVMdpEl3o+JvqSWgyFBJI+iH5+KtNXAMnsFoeqkjO4Y=;
 b=qut5q19Mpte9V3U1aDXYzVnCi9z84VOKTdxU6StoVCeDMEHxtSujD9//mvSF/3aLsi
 wpzrmDBhk6U4b+RVNNKk58fJHdgVcKQfcZPIXJbujbOUn9dUVjv6NC8KOWFmtlbKf6i2
 lfN/0YqJidqJLBFQeOJBvS01qpKgN32wDxxW4zMf94/tom3RORQRaue4qWpxxFHpPVQ7
 3deL4YvsUDkk8vXvL50z+ULUptBfAu9kkBA9Rg713Vegta3Myz1oTEUIJtW3gsp75o0w
 JmkUOM9MaHEWZFQ7rOMMyr8oJC09Im1npG4XR1LNZlbjj1Z4ljtj7vGh5OzE+nh9t5tC
 OkKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPDIzYyIVEe5s2Pla8LKT71gx3H2bbhcth4PwODCMQNE27v1kjtpLHuWqbr0zc06+/8dIQmW0rD4FubsySgI8HQkEmxA==
X-Gm-Message-State: AOJu0YzVQMMqf6LL5VH65QkEdzn+eXw6UHtGNnCyRr6RRH/ujkLbvUMt
 F9q96epD8bhGNmKFdYlMrRf0NN28wotVgcd+jFyZMeguHUdYmqKiA8iWzhz2c0Ca3Mc/lxdc6IO
 Gi2sfqcVNUrxjbVq1TCmPnPCE8SHwpw==
X-Google-Smtp-Source: AGHT+IEAELqjW+3Xd6pU9WuQtyOv2ulUV8MTDCop8uCXm2SgULtA4ZmUT0qd7fwTvtSPUXhClFPI2gPOOSbGHTkyFKE=
X-Received: by 2002:a5d:6a07:0:b0:343:77f4:e663 with SMTP id
 m7-20020a5d6a07000000b0034377f4e663mr1845634wru.18.1713544673774; Fri, 19 Apr
 2024 09:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-7-clamor95@gmail.com>
 <D0O8720SNXUY.58M29AZIXYVC@gmail.com>
In-Reply-To: <D0O8720SNXUY.58M29AZIXYVC@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 19 Apr 2024 19:37:42 +0300
Message-ID: <CAPVz0n0UX1JOxyGbBgd430oMGUb7vDb5td3oZ2beMTVRa3tktQ@mail.gmail.com>
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

=D0=BF=D1=82, 19 =D0=BA=D0=B2=D1=96=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 19:0=
5 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> > Implement reset use to discard any changes which could have been
> > applied to DC before and can interfere with current configuration.
> >
> > Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
> > Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
> > Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1=
565
> > Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/video/tegra20/tegra-dc.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/t=
egra-dc.c
> > index 56a23b3c97..35abb6fe46 100644
> > --- a/drivers/video/tegra20/tegra-dc.c
> > +++ b/drivers/video/tegra20/tegra-dc.c
> > @@ -10,7 +10,9 @@
> >  #include <panel.h>
> >  #include <part.h>
> >  #include <pwm.h>
> > +#include <reset.h>
> >  #include <video.h>
> > +#include <linux/delay.h>
> >  #include <asm/cache.h>
> >  #include <asm/global_data.h>
> >  #include <asm/system.h>
> > @@ -342,6 +344,7 @@ static int tegra_lcd_probe(struct udevice *dev)
> >       struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
> >       struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
> >       struct tegra_lcd_priv *priv =3D dev_get_priv(dev);
> > +     struct reset_ctl reset_ctl;
> >       int ret;
> >
> >       /* Initialize the Tegra display controller */
> > @@ -349,6 +352,20 @@ static int tegra_lcd_probe(struct udevice *dev)
> >       funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
> >  #endif
> >
> > +     ret =3D reset_get_by_name(dev, "dc", &reset_ctl);
> > +     if (ret) {
> > +             log_err("reset_get_by_name() failed: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     clock_disable(priv->dc_clk[0]);
> > +
> > +     /* Reset everything set before */
> > +     reset_assert(&reset_ctl);
> > +     mdelay(4);
> > +     reset_deassert(&reset_ctl);
> > +     mdelay(4);
>
> Are you sure this works as intended? It's been a long time since I
> worked on this, but I seem to recall that most of these resets are
> actually synchronous, so in order for them to do what they're supposed
> to the clock needs to be kept running.
>
> The Linux driver certainly does this differently.

You have point, but I have tried to mostly adapt Linux tegra dc driver,
which has same logic in probe. Maybe I have not understood it properly.
Testing on T20, T30 and T114 passed without issues so far.

> Thierry
