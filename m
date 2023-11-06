Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1075C4167D
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 13:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C70686E40;
	Mon,  6 Nov 2023 14:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LeEgejfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 596A786E05; Mon,  6 Nov 2023 14:28:04 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB809864C3
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 14:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507c78d258fso5791308e87.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 05:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699277280; x=1699882080; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0r3q9taDeXX4hLv3DLCyw/qqHiPEZKEgEgIV2RlUVE=;
 b=LeEgejfn5gFowmwgapucYeEPfwcAadD3Mt/jUBkgjdjOp2vmw2gCmF7s1NymI9un37
 0MKrNyyGytCTs+4A+N5g22FaPA8vDDdid/k7iBj8A3fATNJ7SpiFkTtt95z3YSusFUee
 5FNHV2to80BoCcJ8GDxN732tkfUs+DvLO5PAdPwpy5Nn9MXSHT3aK8Ota2UVfz7jEuOg
 jIaHmB/xPnhQh/pZthGGvPnzjyY+MFsnQv8XFtWf7f/FAPfp8VV2N6dq0523QHkTCfjq
 a/mzY587xX2wG7Xa8eIDbATwbyBFoos9mzwX2tEzmjL4GNvXWV543dk2aEEHlU2CQQId
 SztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699277280; x=1699882080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0r3q9taDeXX4hLv3DLCyw/qqHiPEZKEgEgIV2RlUVE=;
 b=O54iFriDIorwuUHyXTFSCakwv50si3vIHGmCR1uI1+ZoI8UX6ciekkdbKe6yUj9MoN
 3jv9wBVxrjL61LR7HdmOsw0k4xWtdHzCzpgRyeMKVNZu/HuMb6++hN4a4XyzcmJ1vzrg
 /fO9gpOk4Azj4ocaQmc3fsBt0nt7WFzOQo1pnqJKPJno3N4Zn8Vu0aa+gX+BrFgpObFg
 VU0MIm+geXcDCn+91vSz+wJEZ/DUe3Hc4tLIKXfoPlpXxSz5qxxQkaRfNEsmvewlevy2
 ZfwgfJgew+CfDfiNJgOSEsiSwMFrbU83Pv0mMtDXzPLNRA40UU5g0vn0gPj+bkk8pZNJ
 CnWQ==
X-Gm-Message-State: AOJu0YzGuo0bc4o+DQ2MPW3sAaqoc655bcdqaDZzp62TyBdyUvskkTI8
 nEuab+qSCVNm4rZMAutRUdwBb3t7c0JOOIkuCf0=
X-Google-Smtp-Source: AGHT+IGC8pSJ/0ZGJh7eFIcBiO6NUQD9KQQ4ZUJ0FPbP10yvsPbxzfMzKuPXkTN5Jxdp1MuxO2mFc5XqsoX4UNDZbMU=
X-Received: by 2002:a05:6512:1081:b0:507:9640:f256 with SMTP id
 j1-20020a056512108100b005079640f256mr25015603lfg.36.1699277279794; Mon, 06
 Nov 2023 05:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
In-Reply-To: <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 6 Nov 2023 15:27:48 +0200
Message-ID: <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
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

=D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 15:13=
 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 1=
3:46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > > Since the proposed PMIC patches have been accepted, I see the need
> > > > to convert boards which I maintain to use DM drivers instead of boa=
rd hacks.
> > > >
> > > > Svyatoslav Ryhel (5):
> > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
> > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > >
> > > Is there a reason why the two above devices don't appear to have thei=
r
> > > .dts files in the upstream kernel?
> > >
> >
> > Yes, there is a reason. Linux maintainers treat submitters as
> > existential enemies or as dirt at least. I was trying to work with
> > linux but I have no desire to spend any time to upstream endeavoru or
> > lg_x3.
>
> The usual policy for acceptance into U-Boot is to have upstream review
> in the kernel first.
>

May you point to a policy which clearly and explicitly states this as
a mandatory condition?

> > > >   board: transformer-t30: convert ASUS Transformers to use DM PMIC
> > > >   board: grouper: convert ASUS Google Nexus 7 (2012) to use DM PMIC
> > > >   ARM: dts: tegra30: enable USB PHY node on some devices
> > > >
> > > >  arch/arm/dts/tegra30-asus-grouper-common.dtsi |   7 +
> > > >  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |   1 +
> > > >  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |   1 +
> > > >  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |   1 +
> > > >  arch/arm/dts/tegra30-asus-p1801-t.dts         |  17 ++
> > > >  arch/arm/dts/tegra30-asus-tf600t.dts          |  15 ++
> > > >  arch/arm/dts/tegra30-asus-transformer.dtsi    |   9 +
> > > >  arch/arm/dts/tegra30-htc-endeavoru.dts        |   8 +
> > > >  arch/arm/dts/tegra30-lg-x3.dtsi               |   9 +
> > > >  board/asus/grouper/Kconfig                    |   8 -
> > > >  board/asus/grouper/Makefile                   |   4 +-
> > > >  .../asus/grouper/configs/grouper_E1565.config |   6 +-
> > > >  .../asus/grouper/configs/grouper_PM269.config |   6 +-
> > > >  board/asus/grouper/configs/tilapia.config     |   6 +-
> > > >  board/asus/grouper/grouper-spl-max.c          |   2 +-
> > > >  board/asus/grouper/grouper-spl-ti.c           |   2 +-
> > > >  board/asus/grouper/grouper.c                  | 154 +-------------=
----
> > > >  board/asus/transformer-t30/Kconfig            |  10 --
> > > >  .../transformer-t30/configs/tf600t.config     |   2 +-
> > > >  .../transformer-t30/transformer-t30-spl.c     |   2 +-
> > > >  board/asus/transformer-t30/transformer-t30.c  | 121 +-------------
> > > >  board/htc/endeavoru/endeavoru-spl.c           |   2 +-
> > > >  board/htc/endeavoru/endeavoru.c               |  72 +-------
> > > >  board/lg/x3-t30/x3-t30-spl.c                  |   2 +-
> > > >  board/lg/x3-t30/x3-t30.c                      |  97 +----------
> > > >  configs/endeavoru_defconfig                   |   4 +
> > > >  configs/grouper_common_defconfig              |   1 +
> > > >  configs/transformer_t30_defconfig             |   5 +
> > > >  configs/x3_t30_defconfig                      |   4 +
> > > >  29 files changed, 128 insertions(+), 450 deletions(-)
> > > >
> > > > --
> > > > 2.40.1
> > > >
