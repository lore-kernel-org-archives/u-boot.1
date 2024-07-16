Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9641C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35BC2889CE;
	Tue, 16 Jul 2024 09:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KaTEEuD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C33889BB; Tue, 16 Jul 2024 09:04:49 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EAFC889CE
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b5f128b199so30308106d6.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113485; x=1721718285; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xTRnsPBKeG7h7fn+nido/PZQSe7oh9yXObwyvG/m6L0=;
 b=KaTEEuD7qMEPjVaS5G4V+lGkvTIzDJMXqS+GTUj0smZ4dhDUvZCytmA0K47pu4pzFY
 ppToX63CUt315lDb83IxLKPmrPDRlLqnPxKD/MFwNT+KFmfzhdJVqrZBCMHnuQ/GSkQX
 nis1OoQD8Nii/MIX9VVn55u88x/GiD2EKufGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113485; x=1721718285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xTRnsPBKeG7h7fn+nido/PZQSe7oh9yXObwyvG/m6L0=;
 b=thjK7lnraQw5R2Rzu5s/QnT2g905nqGwxHKMNKfDzysB2ns3mZgZaPSfap2IRcuPFu
 T22ju6/dUJQUlT51ZpqA02Ki1unpFVTpoQdbTS2dMe5Sa4l/DaYsS5MJ/Z5FSC2hQimr
 Yb1/JiLYilI6nLa3Kc7TB4JcAiD1rpKrdMXK6R17lQ11sUAd0IIH70tq7eUi1bmw7QHN
 voLa8T5I392mXpfW0kc8ZGN8oGDa8v04wwVMnAYej3na6QuB9nnWQoB7yxu5pJUvZz5V
 0GY/86hX+/LgsbwKVWnUUyHkDtVEi+oM3R0Rvb4xKVwmHwZ8ZfMp4AthdruBtq8GzbOW
 EdJw==
X-Gm-Message-State: AOJu0YyjXpQsd+8+F2bkAzgcwh0qMks+jpyaa5zWAfL0pd0OI81Hd/Cv
 pB1kbTFidnrimL9hv6Ry0WYD7HRB469h3qT6eHO9N+GMYpqVa9bh63kwKYfi8/ebRKPKhiDaeCd
 CNMSltCflk6J0LT4wvBgfN9IqSx3QUoD7m+Vq
X-Google-Smtp-Source: AGHT+IFkEtcOUQJy1uSXvTOnRNUj6Opxt4vIgQcopFf/X8D+drD/o5TXETh3k4JtVVyrWqL5sbvPWg54KhCNIHSH/A4=
X-Received: by 2002:a05:6214:622:b0:6b5:d97b:7247 with SMTP id
 6a1803df08f44-6b77f625873mr16786006d6.52.1721113485215; Tue, 16 Jul 2024
 00:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-c68bf542-baa7-4122-858b-c6d5ef8bf843-1720619007870@3c-app-gmx-bs04>
 <CAFLszTiBhrQPMJNS8sjY-jnq8TFnqdWxutyU2NXPit2RZJczhA@mail.gmail.com>
 <trinity-eed391ff-b254-4e52-a79e-febc2d406618-1721076610706@3c-app-gmx-bs14>
In-Reply-To: <trinity-eed391ff-b254-4e52-a79e-febc2d406618-1721076610706@3c-app-gmx-bs14>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Jul 2024 08:04:34 +0100
Message-ID: <CAFLszTg0Bhs3PAUrkZWLp0Lzus4R_tMJK_TOzte2nCgPFjY4nw@mail.gmail.com>
Subject: Re: Re: avoid syscon fallback class for getting regmap
To: Frank Wunderlich <frank-w@public-files.de>
Cc: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>, 
 "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>,
 John Crispin <john@phrozen.org>
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

Hi Frank,

On Mon, 15 Jul 2024 at 21:50, Frank Wunderlich <frank-w@public-files.de> wrote:
>
> > Gesendet: Samstag, 13. Juli 2024 um 17:13 Uhr
> > Von: "Simon Glass" <sjg@chromium.org>
> > Betreff: Re: avoid syscon fallback class for getting regmap
> >
> > Hi Frank,
> >
> > On Wed, 10 Jul 2024 at 14:43, Frank Wunderlich <frank-w@public-files.de> wrote:
> > >
> > > Hi,
> > >
> > > i'm working on OF_UPSTREAM for mediatek boards and noticed missing syscon-fallback on some (mt7988) devicetree nodes.
> > >
> > > i know that u-boot uses this fallback to get the regmap shared across drivers, but only initializing once with the syscon_uclass.
> > >
> > > i tried adding the syscon-fallback to linux device tree and got pointed [1] back to uboot to solve the issue there...
> > >
> > > are there any ways to avoid syscon in device tree and get the regmap of different node?
> > >
> > > i guess i could use [2], but then it is possible to aquire same regmap multiple times which may result in issues (e.g. race-conditions).
> > > I also want to avoid creating multiple drivers doing the exactily same thing like syscon.
> > >
> > > one easy (but maybe unwanted way) is to add all compatibles for affected syscons to the syscon driver...but then it is no more generic (baed on compatibles then vendor-specific).
> >
> > One option is to create a new driver in a new file and have its ops
> > use the syscon ops. See for example
> > arch/arm/mach-rockchip/rk3399/syscon_rk3399.c
>
> Hi Simon,
>
> thanks for the suggestion, but i have not got it working yet
>
>
> still fails here (drivers/net/mtk_eth.c):
>
>                 priv->xfi_pll_regmap = syscon_node_to_regmap(args.node);

It isn't node, it's a 'driver data' value (see comments for
syscon_get_by_driver_data()). So:

syscon_get_regmap_by_driver_data(MEDIATEK_SYSCON_WDT)

>
> this is how i tried:
> https://github.com/frank-w/u-boot/commit/a1060c88152fe8aa8a092f087591240f930146b3
>
> do i miss something (i guess i do not need the data-field as i only need the regmap)?

The driver_data field is set automatically by driver model - see [1]

The data field is the thing being looked up by
syscon_get_regmap_by_driver_data(), so you do need it.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/driver-model/design.html#bind-stage
