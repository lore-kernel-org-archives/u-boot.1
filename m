Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB2FCCFA16
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 18:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63AF884DB;
	Mon, 30 Sep 2024 20:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LAbR9JHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AD589038; Mon, 30 Sep 2024 20:52:22 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A16087D1A
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 20:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb37b34a87so33737406d6.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727722339; x=1728327139; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qSITOuZPVlPn5Ks9kZmIh3FvpKjRICj1ug2Uc35WVYE=;
 b=LAbR9JHL0ken70/9H1NI0UstJU9KHaMvVm6zV5kIuilbddBjGWEHIX6IAB/j/yVcDO
 HCcIkhkFvSDLQuIcRlEF/9FB5PeH7I1cDxgmdYvrTBqvTECo254HfORsoGtTJ5pB+XS8
 rtk+vJdauxlwGKEEkI3LS/jYa65OroHcVMfMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727722339; x=1728327139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qSITOuZPVlPn5Ks9kZmIh3FvpKjRICj1ug2Uc35WVYE=;
 b=GnwQH3VksaTYwSTImBskkxBMfPhf+VL6YdvxSR5wiyX/tLQbwPm7eYYVY5pExrwZRh
 kNjJknjzRS2kkgWGV4cDXB3Lo9t24hiyM1ncXjXLwdWFMRJFgNJMD4fjEeiuxydJLH/v
 /Vu8bCDrz3ziWCXQwnIdhpHORsVO9rWzj/tyWn2e7amza7xvYskLKAt/+nxmL+6UuVI5
 bFsnDizMqhhZG8loiC5u8CSXFA4mg/7XWVnCLKn+DXSgpAFZvkvgMwck3h1Ropd9Mxyi
 h4Tv10NKaQ8zPoIUzWZNkbs2VhpVSkFD0umE42JT/HPaYXL39JpKsWtz5U+EfOJ1x9HJ
 PJfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUv0o5xwWf/Iv3XgcIEnpEXnmRmVJoVHor8HAR7V4ZG3eer4PNOz0g1wqoP1bk54e6Sffi9Ic=@lists.denx.de
X-Gm-Message-State: AOJu0YxBNxMD7vlzPBv/yncHt373yPP046SK9JKCcgk5ufYIJYSH9VYk
 DqfhazeHIaS3DIsebbt/zo/emHfVYTtMEyj0XrNl6ZockhHyIM8q1DWR3GAvwRPJjBFAX88HfbG
 8m8xUcsQJEr/D30efyUXkyGKSMo1jT3xZ9NV8MfV3J10CWW4=
X-Google-Smtp-Source: AGHT+IEp7dKZ0Ovf+zRZxpbBN0dLvZlz+wag5gY/1b4vlti3HGdY/ykqC17sp2lBWkR3zq8RoLqVOhk6TZPkYrJJ+jQ=
X-Received: by 2002:a05:6214:5990:b0:6cb:3925:ec95 with SMTP id
 6a1803df08f44-6cb3b66d1a1mr169722246d6.53.1727722338946; Mon, 30 Sep 2024
 11:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-3-paulk@sys-base.io>
 <CALeDE9NkpxES=SRKxH6=xk_94rRK9Y0gwuj=C-d+eddjOd_gkg@mail.gmail.com>
In-Reply-To: <CALeDE9NkpxES=SRKxH6=xk_94rRK9Y0gwuj=C-d+eddjOd_gkg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Sep 2024 12:52:08 -0600
Message-ID: <CAFLszTgqGGMm3Hxa2FmT9Z6-BFAR8J6cgb2PNBE8FR=S-X8c8A@mail.gmail.com>
Subject: Re: [PATCH 3/4] rockchip: rk3399-rockpro64: Disable bootstage
 instrumentation config
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>, u-boot@lists.denx.de, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Chris Morgan <macromorgan@hotmail.com>, Tim Lunn <tim@feathertop.org>, 
 Paul Kocialkowski <contact@paulk.fr>
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

Hi,

On Mon, 30 Sept 2024 at 03:03, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Thu, 26 Sept 2024 at 19:32, Paul Kocialkowski <paulk@sys-base.io> wrote:
> >
> > From: Paul Kocialkowski <contact@paulk.fr>
> >
> > The boot timing and reporting (bootstage) infrastructure is useful for
> > performance analysis and debug but adds overhead and console noise when
> > using the device normally. Remove it from the device config.
> >
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>
> This makes sense, for those that want this information will know how
> to build it for testing.

Can you just disable the report? There should be no need to disable
bootstage itself.

Regards,
Simon


> > ---
> >  configs/rockpro64-rk3399_defconfig | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
> > index fc0804a0b80d..095d27ffaa04 100644
> > --- a/configs/rockpro64-rk3399_defconfig
> > +++ b/configs/rockpro64-rk3399_defconfig
> > @@ -19,8 +19,6 @@ CONFIG_SPL_SPI=y
> >  CONFIG_SYS_LOAD_ADDR=0x800800
> >  CONFIG_PCI=y
> >  CONFIG_DEBUG_UART=y
> > -CONFIG_BOOTSTAGE=y
> > -CONFIG_BOOTSTAGE_REPORT=y
> >  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rockpro64.dtb"
> >  CONFIG_DISPLAY_BOARDINFO_LATE=y
> >  CONFIG_SPL_MAX_SIZE=0x40000
> > @@ -38,7 +36,6 @@ CONFIG_CMD_POWEROFF=y
> >  CONFIG_CMD_USB=y
> >  # CONFIG_CMD_SETEXPR is not set
> >  CONFIG_CMD_TIME=y
> > -CONFIG_CMD_BOOTSTAGE=y
> >  CONFIG_SPL_OF_CONTROL=y
> >  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> >  CONFIG_ENV_IS_IN_SPI_FLASH=y
> > --
> > 2.46.2
> >
