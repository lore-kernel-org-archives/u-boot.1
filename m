Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7B9D13569
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 14:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E629388EE3;
	Sun, 27 Oct 2024 15:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EvRsA/31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E0EF88E78; Sun, 27 Oct 2024 15:40:25 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F02588EE4
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 15:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilles.talis@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so4350878a12.2
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730040020; x=1730644820; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8llIp0Xuu8sk3H2YZ2/56yNl3JGuRKLymBRZrJq9ujA=;
 b=EvRsA/31EtG4mZZd9/zrFKkRvw/1aRSFUEyORXwspPOrsI9g1If4ECIRDA3XaUwSeA
 W4XoMKgsCO7ktFat1PiqnGJ+pii3oDtbSopxz5F5viP4oIr/oypuTNkGQc4b0CFD92T8
 i4fmn4b9BpWfvUJzK+41Fx7OHBmEEPnEMe3aQA3VbGEMYcLBdtrgal0AUBUSWTh3eLAZ
 8+pr4eOHxlQKb9Edl/boVTusbVtBtmP5Q8eig8Q9tLVBzf8jI6h1qpQh4MbysjlaxL5J
 bDl6uIHAtcsh7u2Q7a2YydUZBunRYwmknEx4waaHm513nMuo7eLfmoVAq8xYOjqXb8/K
 FkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730040020; x=1730644820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8llIp0Xuu8sk3H2YZ2/56yNl3JGuRKLymBRZrJq9ujA=;
 b=b+AyQ3/pECGP9QZIHaGvwSDkLIDW/PNMu0zq6hnbU0KiN/lX8Tl71+3dtRXkOla+jC
 aVbtn+wBmiiehfuRETNGeP31/RNtwyw+4PouNbkBa1BpJqLHskEYXgaMLjZ4NLvEfQU9
 M++CVeBqK7jKKB5ExnHaHByyAqNv0iTZE564WOAmjDPO/h84QwmljY+N7BqaMiUbfIiX
 2LN5bEnVZj2GZz2Nqb9q98LS+FLfk0OL+CfCieTVilw5NOMyRXsLUGIGEcXJyHXlnhQE
 KNsYxVkTNnJdksHujnPi+xl7JqW35Jc9ZS0iia5a9piCEmLrj9NeRcijqyCpNfEUwfJd
 0jDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj0bA9+Qyo1eTl74UycYdOWKKOA4qPtug9E5bSUNic12z1Cy4ELTXrGVdbfHEuNH7ylePsbIU=@lists.denx.de
X-Gm-Message-State: AOJu0YxZJtgyQPfgJazz51/13Tas+gqTZ9PYA3vK9xFP0j/GGUjtCEol
 kXYKm6DH6pTyUxJk37Eu6ENA0uQJVMMViJW3h9ZtVc5DnHxr6cCU6/c4XrW3kHK0sD+iCg3QJZM
 6wNRA6xDsaaP8khlXGqENi1TxKmBtJ7Pv
X-Google-Smtp-Source: AGHT+IEMDeyNvuIPx3xqMO71tNC/OBhd8WMcZDGApihE73xLe9zodDcq6rd4qwjRFzs5sZ6WjIZH5RdTWxxzUNpX3CQ=
X-Received: by 2002:a17:907:6d0e:b0:a99:f0d0:4ce3 with SMTP id
 a640c23a62f3a-a9de5d97f44mr463765566b.17.1730040019390; Sun, 27 Oct 2024
 07:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241025004411.585310-1-gilles.talis@gmail.com>
 <CAOMZO5BQoZ=MvRqmcZW8GsAGjfJsnev8dUwgLE1EOnO43c5ybQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BQoZ=MvRqmcZW8GsAGjfJsnev8dUwgLE1EOnO43c5ybQ@mail.gmail.com>
From: Gilles Talis <gilles.talis@gmail.com>
Date: Sun, 27 Oct 2024 10:40:07 -0400
Message-ID: <CAKcgs2y881Q1_Z7yC6vxqPm_i9050ajDDK-0vEDSHp_Wxar6Jw@mail.gmail.com>
Subject: Re: [PATCH v2] board: emcraft: Add support for Emcraft Systems NavQ+
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com
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

Hi Fabio,
thank you for the second review!

Le ven. 25 oct. 2024 =C3=A0 07:20, Fabio Estevam <festevam@gmail.com> a =C3=
=A9crit :
>
> Hi Gilles,
>
> On Thu, Oct 24, 2024 at 9:44=E2=80=AFPM Gilles Talis <gilles.talis@gmail.=
com> wrote:
> >
> > The Emcraft Systems NavQ+ kit is a mobile robotics platform
> > based on NXP i.MX8 MPlus SoC.
> >
> > The following interfaces and devices are enabled:
> > - eMMC
> > - Gigabit Ethernet (through eQOS interface)
> > - SD-Card
> > - UART console
> >
> > The device tree file is taken from upstream Linux Kernel
> > through OF_UPSTREAM
> >
> > Signed-off-by: Gilles Talis <gilles.talis@gmail.com>
> > ---
> > Changes v1 --> v2:
> > - Removed unused usdhc properties from dtsi
> > - Moved to correct ethernet PHY driver (REALTEK -> ATHEROS)
> > - Removed empty board_late_init() function
> > - Moved env variables to an env file
>
> This version looks better, thanks.
>
> CI reports an error.
>
> Warning, treated as error:
> 142/builds/u-boot/custodians/u-boot-imx/doc/board/emcraft/index.rst:6:toc=
tree
> contains reference to nonexisting document
> 'board/emcraft/imx8mp-navqp'
> 143make[1]: *** [doc/Makefile:70: htmldocs] Error 2
> 144make: *** [Makefile:2445: htmldocs] Error 2
>
> Please fix and resend.
Good catch! I will fix this.

>
> > +#include <miiphy.h>
> > +
> > +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
> > +int board_phy_config(struct phy_device *phydev)
> > +{
> > +       if (phydev->drv->config)
> > +               phydev->drv->config(phydev);
> > +
> > +       return 0;
>
> Can't board_phy_config() be removed now?
Indeed. Will do.

>
> > diff --git a/board/emcraft/imx8mp_navqp/imx8mp_navqp.env b/board/emcraf=
t/imx8mp_navqp/imx8mp_navqp.env
> > new file mode 100644
> > index 0000000000..a8b76574b4
> > --- /dev/null
> > +++ b/board/emcraft/imx8mp_navqp/imx8mp_navqp.env
> > @@ -0,0 +1,13 @@
>
> SPDX header is missing for this file.
OK. Will do.

>
> > +int board_fit_config_name_match(const char *name)
> > +{
> > +       if (is_imx8mp() &&
> > +           !strcmp(name, "imx8mp-navqp"))
> > +               return 0;
> > +
> > +       return -1;
>
> return -EINVAL;
OK.

>
> > +#if defined(CONFIG_CMD_NET)
> > +#define CFG_FEC_MXC_PHYADDR          1
>
> With DM, this is no longer used, right?
Indeed. Will remove.
