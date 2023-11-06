Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70758C4167D
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 13:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CC1386B0A;
	Mon,  6 Nov 2023 14:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6ua2SUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4589D86D0E; Mon,  6 Nov 2023 14:13:57 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6EB686406
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 14:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5441ba3e53cso4963704a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 05:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699276423; x=1699881223; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DC8WBXR0gVNgO60WafNsde6xJxPrJlpJgThK2PpFvoI=;
 b=W6ua2SUL4ssy5efx+ePuiOI3d0kNckC1NPKvHcLc7LKxgiKrrUhxapULjvNTR+fTTt
 ilxnBrZ7D5VDqrjlmvsavLI4dDZkwiOkBEesl/QGHChVPhK4R7P9EPIC5OuBNxhNr2Si
 19zkttmiNsWrxL0K+/E6hzHOF+S0i9cLaqjs5PxPPcrJqGO0w5faADkfT/+fB+rMVdrU
 jsCpo5+FhVtngsWIU9G4UQc8H7np4hJHKzJb/Gf5vOn4m6xLxOxqqi1AoBCIUYjMKWBe
 yTDQe693ZTmUOntlP6LBWSVHRbvQ/Jfuh0ER/SCm9AOWO3QtxBWuyjUoxvnnqbZL3jgh
 3USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699276423; x=1699881223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DC8WBXR0gVNgO60WafNsde6xJxPrJlpJgThK2PpFvoI=;
 b=Eoq4FUFNs3r8VK9zb1VGT4AJx6z7RS+CIiJxym2MHfpLf9MG4nspQVJPZq2LpPD8DO
 2JQik+ttVnBFt1tDWTZ5WgiwSMizNrxWIbGIQ2b2H83COZIIdZCxRx4YOg9i1a5SDE4u
 WHPjL5xt5IN1OddVupH+b3CjrIMgduHKM+GnwwXQqRB+ucvDJkM56N8lTp5JTkSSQH9e
 vEVo9A3pvl3XRDUGZMPbvXXNktLJbfShbQ6VQyX4dCzIzDJUaZw98LYxEhIgeFP0mtIs
 Ef5Uh52Zstuh/K1U0LL1t6HHbHW5WmaGrNbzGfGy9My8quaJqzFuH4AsL0/CwQGI2a6V
 6GYA==
X-Gm-Message-State: AOJu0Yx7hJrT2ydeEyiGVFPOeMlPkZOYHNC421ArKrTaZEjmtAwVrR1U
 7sNzrAiP1KpOba0Uru3U/oBdq/swZKwvEBnioGg=
X-Google-Smtp-Source: AGHT+IE9jWsJWdo39mK/H/tcJD87YSGQLC/jRQZ/8b6m2hPO3Ia+mPShrTDwVP1GbeQBollLQxC9dD/nHNoA4i1m8Ts=
X-Received: by 2002:aa7:d1c9:0:b0:53e:5dad:dce0 with SMTP id
 g9-20020aa7d1c9000000b0053e5daddce0mr24210928edp.3.1699276423272; Mon, 06 Nov
 2023 05:13:43 -0800 (PST)
MIME-Version: 1.0
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
In-Reply-To: <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 6 Nov 2023 13:13:32 +0000
Message-ID: <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
To: Svyatoslav Ryhel <clamor95@gmail.com>
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

On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 13:=
46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> >
> > > Since the proposed PMIC patches have been accepted, I see the need
> > > to convert boards which I maintain to use DM drivers instead of board=
 hacks.
> > >
> > > Svyatoslav Ryhel (5):
> > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
> > >   board: endeavoru: convert HTC One X to use DM PMIC
> >
> > Is there a reason why the two above devices don't appear to have their
> > .dts files in the upstream kernel?
> >
>
> Yes, there is a reason. Linux maintainers treat submitters as
> existential enemies or as dirt at least. I was trying to work with
> linux but I have no desire to spend any time to upstream endeavoru or
> lg_x3.

The usual policy for acceptance into U-Boot is to have upstream review
in the kernel first.

> > >   board: transformer-t30: convert ASUS Transformers to use DM PMIC
> > >   board: grouper: convert ASUS Google Nexus 7 (2012) to use DM PMIC
> > >   ARM: dts: tegra30: enable USB PHY node on some devices
> > >
> > >  arch/arm/dts/tegra30-asus-grouper-common.dtsi |   7 +
> > >  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |   1 +
> > >  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |   1 +
> > >  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |   1 +
> > >  arch/arm/dts/tegra30-asus-p1801-t.dts         |  17 ++
> > >  arch/arm/dts/tegra30-asus-tf600t.dts          |  15 ++
> > >  arch/arm/dts/tegra30-asus-transformer.dtsi    |   9 +
> > >  arch/arm/dts/tegra30-htc-endeavoru.dts        |   8 +
> > >  arch/arm/dts/tegra30-lg-x3.dtsi               |   9 +
> > >  board/asus/grouper/Kconfig                    |   8 -
> > >  board/asus/grouper/Makefile                   |   4 +-
> > >  .../asus/grouper/configs/grouper_E1565.config |   6 +-
> > >  .../asus/grouper/configs/grouper_PM269.config |   6 +-
> > >  board/asus/grouper/configs/tilapia.config     |   6 +-
> > >  board/asus/grouper/grouper-spl-max.c          |   2 +-
> > >  board/asus/grouper/grouper-spl-ti.c           |   2 +-
> > >  board/asus/grouper/grouper.c                  | 154 +---------------=
--
> > >  board/asus/transformer-t30/Kconfig            |  10 --
> > >  .../transformer-t30/configs/tf600t.config     |   2 +-
> > >  .../transformer-t30/transformer-t30-spl.c     |   2 +-
> > >  board/asus/transformer-t30/transformer-t30.c  | 121 +-------------
> > >  board/htc/endeavoru/endeavoru-spl.c           |   2 +-
> > >  board/htc/endeavoru/endeavoru.c               |  72 +-------
> > >  board/lg/x3-t30/x3-t30-spl.c                  |   2 +-
> > >  board/lg/x3-t30/x3-t30.c                      |  97 +----------
> > >  configs/endeavoru_defconfig                   |   4 +
> > >  configs/grouper_common_defconfig              |   1 +
> > >  configs/transformer_t30_defconfig             |   5 +
> > >  configs/x3_t30_defconfig                      |   4 +
> > >  29 files changed, 128 insertions(+), 450 deletions(-)
> > >
> > > --
> > > 2.40.1
> > >
