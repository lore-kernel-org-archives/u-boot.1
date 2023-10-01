Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABBBE748E9
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 13:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4AF186A94;
	Sun,  1 Oct 2023 15:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M4kmxmqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 619D186A94; Sun,  1 Oct 2023 15:50:47 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4026386A88
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 15:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59bf1dde73fso195296537b3.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696168244; x=1696773044; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=StVc46aKGYrA0NuQ2dGnkm5uANxlWZ5P7yPK595+afw=;
 b=M4kmxmqzmnKm8ELGNV2MytRBUrnYyRfjsIvClyaunuHOh3WmgiKDdhdVzrStjb9c4z
 5ed8TriDmkPm4XPocMwbaI3RaE4XXcNVaklpkAtuYx0u46XVm2GufIy+aG5Zm6mNmDYO
 MNo3QY8TtsISxpJmZEo+7s5qAlBG9kxDOnROjvgw31NQa9pFTzHihDHX4GFiIUb/W7LC
 J0TYFSpinfNb6Er34yIkje0T6DzCoHgEayQ1GoHymLJZYMiOold+b0S8btvLNspFqy7Q
 Mjhs4K8QlolfY2k5JQ5NTp95GqJf6huksAT+WYK6pcmZ1u4CjhhM1IZ5Do0yEnkbzoLe
 dRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696168244; x=1696773044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=StVc46aKGYrA0NuQ2dGnkm5uANxlWZ5P7yPK595+afw=;
 b=myJN/e7yl1clIgYU8cFK5EPody0gT26BkcqzAoJvFhKrysPIeDXHxy11PzY0Lwu2ht
 lAItqFV0nmmoF9k2L43nFzmx+oXPlOwg/BDrhSkvgPrs1RZ2HaS0+NRQjPmIqFjHjoLT
 eAzR47wPft72uwJMsVfUZArI+gWAtDUqIsxyeaQEnhuveW1bxRQzy8Vj1rQTjbLLxKqr
 aGP6V6drbzxf/QF3KP9gVfcgb/Q4vNCHWXtHG8Vbh5a4rAAQPepQKIerUXem8p8jr4et
 m7bVJqQkHYdwBsDVwVJBXyyPvxk6jzK/cDgKaCoISC6Eu6XmhD6JZF5VV9shH6AgMc2+
 mhUw==
X-Gm-Message-State: AOJu0YzFEj7IOig8nlCnlkSAQ+SLdmbBpkeyk8l9a8cI+r6Wknxm+/O8
 n1z9/f+SqQ/XoH/w3v5uEUGa62PpXEszoQmiCsA=
X-Google-Smtp-Source: AGHT+IGe+lVqWtTvKrhjDTQJE3MPf4poapIeLgXMH69GICwkSaxcUSI9A9XRYvBT1oTIyNKmOa4QMXdaAAHotoCGPeA=
X-Received: by 2002:a25:eb11:0:b0:d90:a7a4:7093 with SMTP id
 d17-20020a25eb11000000b00d90a7a47093mr1789994ybs.55.1696168243890; Sun, 01
 Oct 2023 06:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230902171507.351774-1-massimo.pegorer+oss@gmail.com>
 <bf49eebf-6a7e-555b-cf84-d96d9df8a32e@rock-chips.com>
In-Reply-To: <bf49eebf-6a7e-555b-cf84-d96d9df8a32e@rock-chips.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 1 Oct 2023 15:50:31 +0200
Message-ID: <CAC928HZEY0jO+n60D5FizUU+C0FeyKWVGRn1Rav2TAm-1Od6VA@mail.gmail.com>
Subject: Re: [PATCH 2/2] configs: rockchip: add DOS_PARTITION to RK3308 boards
 defconfig
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Akash Gajjar <gajjar04akash@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
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

Hi Kever,

Il giorno mer 27 set 2023 alle ore 05:10 Kever Yang
<kever.yang@rock-chips.com> ha scritto:
>
> Hi Massimo,
>
>      This patch is fine to me, but you can merge these two patch into
> one, because they
>
> are all rk3308 boards.

OK, I will merge them in a single v2 patch. Thanks.

I had split them because I had chance to test it only on rock-pi-s, so
I was not sure everybody would have agreed to change also evb and
firefly boards defconfigs.

Regards,
Massimo

>
>      And if you have more than one patch, it'd better to use
> --in-reply-to for follow up patches
>
> so that the mail system know this is a patch set and grab them together.
>
>
> Thanks,
>
> - Kever
>
> On 2023/9/3 01:15, Massimo Pegorer wrote:
> > Without DOS_PARTITION support U-Boot is not able to boot an OS stored
> > into an SD card with MBR partitions table. This is still a quite common
> > case, so add DOS_PARTITION (only for U-Boot proper build) to Rockchip
> > RK3308 EVB and Firefly roc-rk3308-cc board: they are the only RK boards
> > missing of DOS_PARTITION.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   configs/evb-rk3308_defconfig    | 2 +-
> >   configs/roc-cc-rk3308_defconfig | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> > index a13a809c1e..c6472a2c9c 100644
> > --- a/configs/evb-rk3308_defconfig
> > +++ b/configs/evb-rk3308_defconfig
> > @@ -47,7 +47,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
> >   # CONFIG_CMD_ITEST is not set
> >   # CONFIG_CMD_SETEXPR is not set
> >   # CONFIG_CMD_SLEEP is not set
> > -# CONFIG_DOS_PARTITION is not set
> > +# CONFIG_SPL_DOS_PARTITION is not set
> >   # CONFIG_ISO_PARTITION is not set
> >   CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
> >   CONFIG_SPL_OF_CONTROL=y
> > diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
> > index 9a789b212f..ca92b8f744 100644
> > --- a/configs/roc-cc-rk3308_defconfig
> > +++ b/configs/roc-cc-rk3308_defconfig
> > @@ -47,7 +47,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
> >   # CONFIG_CMD_ITEST is not set
> >   # CONFIG_CMD_SETEXPR is not set
> >   # CONFIG_CMD_SLEEP is not set
> > -# CONFIG_DOS_PARTITION is not set
> > +# CONFIG_SPL_DOS_PARTITION is not set
> >   # CONFIG_ISO_PARTITION is not set
> >   CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
> >   CONFIG_SPL_OF_CONTROL=y
