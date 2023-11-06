Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7FFC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3764A863F7;
	Mon,  6 Nov 2023 12:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BT0y1WFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF67186A6B; Mon,  6 Nov 2023 12:58:53 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA77E8622B
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso33606735e9.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699271931; x=1699876731; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DCPL4M06Hz9PcdXwyTGLklHL0Rp6weSgTbwQRsEa1s=;
 b=BT0y1WFMJ+OPwFmWHa1UKRrsv/KNgAv4VM/kZmdHhsNi/MQO02fu7OsKJgApEPrRh/
 k2L4i5NJ7dql8sWwNWvi64Wvxz9HAE4nASA4alwIuwBDmY+Nb1KmCK1eFSiujpDzNZhs
 nuUPorMyda9pMpKMKuWlaI+A+FSIGh8+xOgYK15L8m0UuQ/4o99L9qBCD1LEZTqhT3T6
 sIt7lVW4R4jhtaVE9F4ecRnIQpIHH8qKvYkaXLKSkxd2uN767iazNho88cPrQQMfKbsx
 eyDsBkDvJ4xkaTPQrDg+d8+dLIFbX3fFcPm8u2xRiu0bvCNjzCeGC3geLGK5aRh4KKrs
 3f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271931; x=1699876731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DCPL4M06Hz9PcdXwyTGLklHL0Rp6weSgTbwQRsEa1s=;
 b=OKHlvnMI348+ZE2lxKIj04Yyx07UpqDyoKO3/jk+3cbntsrorzfVeGl0JUYit1vV+g
 K/gGlIzviWelibPpap08d+/TkVkaQn8EVxSNSP+b7zdH51QkgHsuIo1RxgZuKk2hNhGl
 r9RNSYKWVtED2nfyOa4++SM11ab2qRrMAX4OM1E2eeXWTGomftvm9mXoyfp+ANOpvW8q
 U0fiEqZ2DM8jYS4e0n6n+4SysvzX4vQcpDl1jNR7fOd7cPVubCiX0u93xpNlDJ1YQcWt
 q39ZxISaViQfBkqyLWZnD4HQqm7YEyduQMmwhtNF/AQ6qqHi8phGoDRubKvaUvSpbPIz
 Cbbg==
X-Gm-Message-State: AOJu0Yx2108LLtODN7pL/GW59Tv8+GSMLXVWEpFGpD9cg4e1WJNdZgyQ
 42Y+K8VD8KHXIea9d9D8xIU10OLlmzy4kUCxQd8=
X-Google-Smtp-Source: AGHT+IHdQYJai7qK20v+1yqElAjcrS+/ILfl0K+q0LFKMjNM0E8c9kd4+SjK4D6fy/cUyfsIrnk4/aFI2mJw13eCcrI=
X-Received: by 2002:a05:600c:548f:b0:408:4d0e:68b2 with SMTP id
 iv15-20020a05600c548f00b004084d0e68b2mr22830583wmb.36.1699271931028; Mon, 06
 Nov 2023 03:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
In-Reply-To: <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 6 Nov 2023 13:58:40 +0200
Message-ID: <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
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

=D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 13:46=
 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> > Since the proposed PMIC patches have been accepted, I see the need
> > to convert boards which I maintain to use DM drivers instead of board h=
acks.
> >
> > Svyatoslav Ryhel (5):
> >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
> >   board: endeavoru: convert HTC One X to use DM PMIC
>
> Is there a reason why the two above devices don't appear to have their
> .dts files in the upstream kernel?
>

Yes, there is a reason. Linux maintainers treat submitters as
existential enemies or as dirt at least. I was trying to work with
linux but I have no desire to spend any time to upstream endeavoru or
lg_x3.

> >   board: transformer-t30: convert ASUS Transformers to use DM PMIC
> >   board: grouper: convert ASUS Google Nexus 7 (2012) to use DM PMIC
> >   ARM: dts: tegra30: enable USB PHY node on some devices
> >
> >  arch/arm/dts/tegra30-asus-grouper-common.dtsi |   7 +
> >  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |   1 +
> >  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |   1 +
> >  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |   1 +
> >  arch/arm/dts/tegra30-asus-p1801-t.dts         |  17 ++
> >  arch/arm/dts/tegra30-asus-tf600t.dts          |  15 ++
> >  arch/arm/dts/tegra30-asus-transformer.dtsi    |   9 +
> >  arch/arm/dts/tegra30-htc-endeavoru.dts        |   8 +
> >  arch/arm/dts/tegra30-lg-x3.dtsi               |   9 +
> >  board/asus/grouper/Kconfig                    |   8 -
> >  board/asus/grouper/Makefile                   |   4 +-
> >  .../asus/grouper/configs/grouper_E1565.config |   6 +-
> >  .../asus/grouper/configs/grouper_PM269.config |   6 +-
> >  board/asus/grouper/configs/tilapia.config     |   6 +-
> >  board/asus/grouper/grouper-spl-max.c          |   2 +-
> >  board/asus/grouper/grouper-spl-ti.c           |   2 +-
> >  board/asus/grouper/grouper.c                  | 154 +-----------------
> >  board/asus/transformer-t30/Kconfig            |  10 --
> >  .../transformer-t30/configs/tf600t.config     |   2 +-
> >  .../transformer-t30/transformer-t30-spl.c     |   2 +-
> >  board/asus/transformer-t30/transformer-t30.c  | 121 +-------------
> >  board/htc/endeavoru/endeavoru-spl.c           |   2 +-
> >  board/htc/endeavoru/endeavoru.c               |  72 +-------
> >  board/lg/x3-t30/x3-t30-spl.c                  |   2 +-
> >  board/lg/x3-t30/x3-t30.c                      |  97 +----------
> >  configs/endeavoru_defconfig                   |   4 +
> >  configs/grouper_common_defconfig              |   1 +
> >  configs/transformer_t30_defconfig             |   5 +
> >  configs/x3_t30_defconfig                      |   4 +
> >  29 files changed, 128 insertions(+), 450 deletions(-)
> >
> > --
> > 2.40.1
> >
