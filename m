Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C15DCFA74C
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 09:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DEE288B99;
	Fri,  4 Oct 2024 11:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q7RrOGVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC3888BDE; Fri,  4 Oct 2024 11:56:09 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5541A88B86
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 11:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2facf48157dso21387291fa.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728035767; x=1728640567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FwVakM+pkUcZkt4Atl/43RbWpjfUB5qyeLJY3QZvWI4=;
 b=Q7RrOGVSHEAjCDQyv/L5uPrUCJnkIngcarYFcA7u5MkNPq1qkVNHyd5A7gwZnFIgM1
 xxFJqpA4fzEbRX1m/OCvg4k7x/YeHN/rIDTu+23Nn8uKWxrRXs2Aq1qDz023JeAwAEfn
 5+Aj34y2u6u/4zkOhXtZqAAY9HZE2Ooy/WEtUSFv33tk8zjJ4Azqtax1zP+6lkCJVtwi
 vVdvWsuoutz0CkFjLUbFmYflPSjAqISFpPzRERuE7Ac5dwnx0WLYtu0cgqtlELWq6ifT
 TPYWNkkiLlrf7CZTv9uSuj3gcERQXT9gQSKZiNB7ZAEKdmP1Zx3IOH9isCEw4OiCgjoj
 Drow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728035767; x=1728640567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FwVakM+pkUcZkt4Atl/43RbWpjfUB5qyeLJY3QZvWI4=;
 b=GwH1X5UvDC1wJGeJ5O2wd5eXD2BafOKWDhGujru07iNHcLh2dGjJ1mrclo/agohgf7
 pogHv+Xb05UtbJjsYhqCIo/MDFhI9hLFtFCOUMDqS6+GEx6SSSeja0atKV27Gkyp00bb
 V/rBrzNb+K2a3Rxi1bCRrjdE3Kc3TBuRJ0FtRYt/OMGLpjVi/os7VOLhOC/U+KZa7gdn
 vLGdpM15fZo1PdOtbrQkDOIGNj0p6HEHPnPkPq0K9HOWy7YBKZ2XBqVsdhh/CnHyen4O
 kJfgwL9GHDm/IMtMUbknJtoxFpYyJyGTaTnXkoH0POrfuvJ5OGPtoEg90tHeUa05nwby
 UC7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3MVSRo29qBAgOF0OyjW59AYSnyNVW3DO3lz9gNbHnEmjfxp/AhS0tGbaeJYqX5vkmUOsfgfw=@lists.denx.de
X-Gm-Message-State: AOJu0YyxGhmYdvFAHEWIeazkeXqFLwzdyV+g9gI+8v3lJg7HpO8t7U9b
 ywaim14Z077CmL1CYIxAbe6QP7CfoisF34zAtuALhMBZlaG5H+OfitpirM6ncDxzcXDmhTJ9Sy1
 bhtE6Kw2YIaVtxFKVxCb/jklo1go8zw==
X-Google-Smtp-Source: AGHT+IHhnkNQIHa0SO2K43BDWx3i33oAk9w6i2jnP2G2F3qRHeCL2uJacA3mszoX2EETXxMqS0ThENQ26pQxa1yU6Ks=
X-Received: by 2002:a05:651c:316:b0:2fa:dc24:a346 with SMTP id
 38308e7fff4ca-2faf3c1c72bmr8677371fa.21.1728035766188; Fri, 04 Oct 2024
 02:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241002180853.227389-1-pbrobinson@gmail.com>
 <D4MWH0M95LGZ.2J0ZCBEC3YUJJ@cknow.org>
In-Reply-To: <D4MWH0M95LGZ.2J0ZCBEC3YUJJ@cknow.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 4 Oct 2024 10:55:54 +0100
Message-ID: <CALeDE9Oov_V+_BWVZX4fRxsxZsbpXh2B3XxmQ-aFPqsek5b5cQ@mail.gmail.com>
Subject: Re: [PATCH] Update the ARM trusted firmware git URL
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hey,

> > The primary upstream URL for tf-a has moved, in some cases
> > things like tags are not always pushed to the old URL so
> > update the URLs to the primary upstream project URL.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  board/rockchip/evb_rk3399/README       | 2 +-
> >  board/sunxi/README.sunxi64             | 2 +-
> >  common/spl/Kconfig                     | 2 +-
> >  doc/README.rockchip                    | 2 +-
> >  doc/README.uniphier                    | 2 +-
> >  doc/board/armltd/juno.rst              | 2 +-
> >  doc/board/bsh/imx8mn_bsh_smm_s2.rst    | 2 +-
> >  doc/board/hisilicon/hikey.rst          | 4 ++--
> >  doc/board/hisilicon/hikey960.rst       | 4 ++--
> >  doc/board/kontron/pitx-imx8m.rst       | 2 +-
> >  doc/board/rockchip/rockchip.rst        | 2 +-
> >  doc/board/variscite/imx8mn_var_som.rst | 2 +-
> >  include/atf_common.h                   | 2 +-
> >  tools/binman/entries.rst               | 2 +-
> >  tools/binman/etype/atf_bl31.py         | 2 +-
> >  tools/binman/fip_util.py               | 4 ++--
> >  16 files changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/board/rockchip/evb_rk3399/README b/board/rockchip/evb_rk3399/README
> > index c6f58203ebe..c7caf1756d6 100644
> > --- a/board/rockchip/evb_rk3399/README
> > +++ b/board/rockchip/evb_rk3399/README
> > @@ -31,7 +31,7 @@ Get the Source and prebuild binary
> >
> >    > mkdir ~/evb_rk3399
> >    > cd ~/evb_rk3399
> > -  > git clone https://github.com/ARM-software/arm-trusted-firmware.git
> > +  > git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
> >    > git clone https://github.com/rockchip-linux/rkbin.git
> >    > git clone https://github.com/rockchip-linux/rkdeveloptool.git
> >
>
> I already mentioned this on IRC, but figured that this may be a better
> way to communicate it.

Yes, you didn't mention me so I didn't see a ping on the channel :)

> This patch seems incomplete as the git repo's name has changed, but not
> all the instructions which reference it.

Thanks for catching this, will review and do a follow up.

> So for example in this patch, this is the code that follows:
>
> > Compile ATF
> > ===========
> >
> >   > cd arm-trusted-firmware
> >   > make realclean
>
> That ``cd`` command doesn't work as it should be ``cd trusted-firmware-a``.
>
> This is just an example as this issue is present in more files (which
> were modified by this patch).
>
> Optionally you could consider if in f.e. ``tools/binman/fip_util.py``
> ``srcdir (str): 'arm-trusted-firmware' source directory``
>
> should be updated to trusted-firmware-a. Not an error and probably
> everyone understands what is meant, but for consistency it could be
> beneficial if they're all updated.
>
> > diff --git a/doc/README.rockchip b/doc/README.rockchip
> > index 84caff8a24d..5fcbbd1d990 100644
> > --- a/doc/README.rockchip
> > +++ b/doc/README.rockchip
> > @@ -73,7 +73,7 @@ Building
> >
> >     - Compile ATF
> >
> > -     => git clone https://github.com/ARM-software/arm-trusted-firmware.git
> > +     => git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
> >       => cd arm-trusted-firmware
> >
> >       (export cross compiler path for Cortex-M0 MCU likely arm-none-eabi-)
>
> This is one of those others that should be updated (and is directly
> visible on
> https://source.denx.de/u-boot/u-boot/-/commit/0ec0207fe07356bddb10db717e21c261bebfb989
>
> Cheers,
>   Diederik
