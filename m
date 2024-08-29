Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD368C83F27
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C1288C35;
	Thu, 29 Aug 2024 16:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BX8ZRgZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8F388C1C; Thu, 29 Aug 2024 16:05:18 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C118288C1B
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2020ac89cabso6976005ad.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940315; x=1725545115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JEW1B5sv3Qwk8GcduUrbZEWXlyX83YQ6Ix+HM1lohFE=;
 b=BX8ZRgZG3vLuRDNBJl9aqx19/vCpX8ztfWOvBH21WQ2CEHsAnGX65t+OoGUn7OoHU0
 /O/ZjKG5o1mQ7H1j1x/4IJz58/1C0cN8ObcJnWtj3bXXVY7dCeup8bAI64cuZ2Zpltur
 +ioXrYaPhCdITl558iqwKaAPgDwQLORAcgIWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940315; x=1725545115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JEW1B5sv3Qwk8GcduUrbZEWXlyX83YQ6Ix+HM1lohFE=;
 b=ck7BYw3xolWMBi3ob3sCbNLTcV6iKGwOx407EOPRxRrRSl5CGCU8yIR6bt9VFrsOGZ
 Bpsdkr8XbsFBbrfjhyvrQNX1WBPXP5IXZQ2s9Z4+0PEWgmXb1UftX9UxXg5OvtpWHRNV
 g9Xcrcun2YpAwApU0qZr5iXPx8ZMXuHJrxHoeqofJr581X8C0PFmFIu0HLKXdJHqzpgM
 /e3LW4Jg0E6b5wkWHbUNEq/03FFHqr33DJwqXFChyi4acZSeDXmFh+sMQtuu2awWsbOY
 JqmoC/pN6AasPRrkQjecqW05aQyI/j40+Gg8axgxuR8wlG2jN72zOk6vjde2OFXseanj
 P54A==
X-Gm-Message-State: AOJu0YzCcpDvopeWVCMIFpaBS0NLN6bDB8IbMqarldLWcj1FtRr2YKQL
 KUmZm8MT2c438L40iirdH+70ocp0XFVPtA4f/LCO16bywPl5DHwp+XCjl5aTHX0wT3EHmbzKm2E
 FppnpAETytAvySb1H9TO2K94jJO3cvwT60vBy
X-Google-Smtp-Source: AGHT+IEPqJYn4a+fSC5gah/dZBZQ/P41uKAIrlp1XRF+oQWQWQjgqql8i9jpJHKyMy1VFLhl9btAOqQQc83F77qftQE=
X-Received: by 2002:a17:902:da8c:b0:1fb:8cab:ccc9 with SMTP id
 d9443c01a7336-2050c423fabmr36470245ad.45.1724940314730; Thu, 29 Aug 2024
 07:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240828014538.3322013-1-sjg@chromium.org>
 <20240828014538.3322013-14-sjg@chromium.org>
 <9fb1c645-a5f0-48de-beb7-6351290db079@denx.de>
In-Reply-To: <9fb1c645-a5f0-48de-beb7-6351290db079@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:02 -0600
Message-ID: <CAFLszTg_Q_L3r4jaoQHbO1Ck=dekcpRWh-MVUV0BBSFeEh=jwg@mail.gmail.com>
Subject: Re: [PATCH 13/18] mmc: Add more debugging for SPL
To: Marek Vasut <marex@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Marek,

On Tue, 27 Aug 2024 at 22:10, Marek Vasut <marex@denx.de> wrote:
>
> On 8/28/24 3:45 AM, Simon Glass wrote:
> > When MMC booting fails it is sometimes hard to figure out what went
> > wrong as there is no error code. It isn't even clear which MMC device
> > was chosen, since SPL can have its own numbering.
> >
> > Add some debugging to help with this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   common/spl/spl_mmc.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
> > index 3fd81608e9f..c0e8d407e5d 100644
> > --- a/common/spl/spl_mmc.c
> > +++ b/common/spl/spl_mmc.c
> > @@ -50,6 +50,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
> >       ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
> >       if (ret) {
> >               puts("mmc_load_image_raw_sector: mmc block read error\n");
> > +             log_debug("(error=%d)\n", ret);
> >               return ret;
> >       }
> >
> > @@ -76,6 +77,12 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
> >       int ret;
> >
> >   #if CONFIG_IS_ENABLED(DM_MMC)
> > +     struct udevice *dev;
> > +     struct uclass *uc;
> > +
> > +     log_debug("Selecting MMC dev %d; seqs:\n", mmc_dev);
> > +     uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
> > +             log_debug("%d: %s\n", dev_seq(dev), dev->name);
> >       ret = mmc_init_device(mmc_dev);
> >   #else
> >       ret = mmc_initialize(NULL);
> > @@ -91,6 +98,10 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
> >                      mmc_dev, ret);
> >               return ret;
> >       }
> > +#if CONFIG_IS_ENABLED(DM_MMC)
>
> if (CONFIG_IS_ENABLED(...)) ?

We could, but don't need that?

Regards,
Simon
