Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8274C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 14:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F79F8704D;
	Mon,  6 Nov 2023 15:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G833Fjm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA53D8704F; Mon,  6 Nov 2023 15:11:30 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2EF287032
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 15:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-544455a4b56so3420096a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699279888; x=1699884688; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2qKpujdxNvzHB/4VbcqK8W2JkKy5j9omXhfY23+7uM=;
 b=G833Fjm0SjmKNepgI/p8YltgBdt8S3GTTBYYF26ZL7VxTITFHIPJXqWi7iWqhkzALc
 5Y8V5SIVpkZ8dV6VYPaGZy8Mn3Llc0Fai2/HzcJVQx8xhfnfamEYdmAp6Q2SaJut20v0
 cFaeZr8YOI1IAPiuHwHZe5ZXq3ZCKdd68sIFZ2t8oC8CgFaq6ZbiGs1KY90jh5HiqWyT
 VDBBg61xfRLFVaK7VX810tXp7sDIITdZyzNqK6cTAjK0CKS+iK1ToOSmurJJLLynS/Gn
 I2JHWT3KBPxD2JMGAXBWhqPYPJBn7tJcIOM5OQaZ7MMvqNr9UsYH1f3uqFT9ECQTYItW
 FVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699279888; x=1699884688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2qKpujdxNvzHB/4VbcqK8W2JkKy5j9omXhfY23+7uM=;
 b=H49OO9H1nkiqCKtIeTMxL6XSJd7on5VWSgLuYJuW4n+kwlZJEGquzbn83zABXiPGbd
 KY0bIVj2isOyBDGup3GQGeyO/+QkseDEQoaKToVLUMspzxoD3BKQxs/fJEoDUl2OwBfb
 BA0p4WPtQ7LORp6Uf5wH/iTTKL74hbkVwKK7lacdISCQs9F4l09cXaIUfbHXWnOFGSbA
 1f0oda0BlBaA73aWEhkfleHJLy1OoTGH536NdOGA4c8RwVW42p66tZTEC4Zz0ixC11Tx
 /fpjNJ3beVDaZwLI9uccewI2xzmAQ8lmr5o0R/YVnCnOSU3M7ehBmVkzjuZ359p0fAHk
 hnCg==
X-Gm-Message-State: AOJu0YyWVhhKDH4QExz/5ACwVEd9lJvoFCMc+aKq9RmCXda3yCqhqy3K
 gF3ot9IHkpGqKxEJv1o+4I4Sy9v+DLTP1Y6p/k4=
X-Google-Smtp-Source: AGHT+IHwXrLsWmv05q4s0Pg68jGy4hPm2GikgZg0ysCWK6zGi5aX0bk8I7bixl7xaXhn8rDig62RtSZdQHcDcsBcTj8=
X-Received: by 2002:a05:6402:b49:b0:53e:775e:9761 with SMTP id
 bx9-20020a0564020b4900b0053e775e9761mr23148905edb.36.1699279888110; Mon, 06
 Nov 2023 06:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
In-Reply-To: <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 6 Nov 2023 14:11:16 +0000
Message-ID: <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.com=
> wrote:
>
> =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 15:=
13 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmai=
l.com> wrote:
> > >
> > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE=
 13:46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > Hi Svyatoslav,
> > > >
> > > > > Since the proposed PMIC patches have been accepted, I see the nee=
d
> > > > > to convert boards which I maintain to use DM drivers instead of b=
oard hacks.
> > > > >
> > > > > Svyatoslav Ryhel (5):
> > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
> > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > > >
> > > > Is there a reason why the two above devices don't appear to have th=
eir
> > > > .dts files in the upstream kernel?
> > > >
> > >
> > > Yes, there is a reason. Linux maintainers treat submitters as
> > > existential enemies or as dirt at least. I was trying to work with
> > > linux but I have no desire to spend any time to upstream endeavoru or
> > > lg_x3.
> >
> > The usual policy for acceptance into U-Boot is to have upstream review
> > in the kernel first.
> >
>
> May you point to a policy which clearly and explicitly states this as
> a mandatory condition?

There have been a number of devices rejected in the past until their
DT are upstream but I'll leave Tom, who I've explicitly added on cc:,
to clarify the exact policy.

> > > > >   board: transformer-t30: convert ASUS Transformers to use DM PMI=
C
> > > > >   board: grouper: convert ASUS Google Nexus 7 (2012) to use DM PM=
IC
> > > > >   ARM: dts: tegra30: enable USB PHY node on some devices
> > > > >
> > > > >  arch/arm/dts/tegra30-asus-grouper-common.dtsi |   7 +
> > > > >  .../dts/tegra30-asus-nexus7-grouper-E1565.dts |   1 +
> > > > >  .../dts/tegra30-asus-nexus7-grouper-PM269.dts |   1 +
> > > > >  .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |   1 +
> > > > >  arch/arm/dts/tegra30-asus-p1801-t.dts         |  17 ++
> > > > >  arch/arm/dts/tegra30-asus-tf600t.dts          |  15 ++
> > > > >  arch/arm/dts/tegra30-asus-transformer.dtsi    |   9 +
> > > > >  arch/arm/dts/tegra30-htc-endeavoru.dts        |   8 +
> > > > >  arch/arm/dts/tegra30-lg-x3.dtsi               |   9 +
> > > > >  board/asus/grouper/Kconfig                    |   8 -
> > > > >  board/asus/grouper/Makefile                   |   4 +-
> > > > >  .../asus/grouper/configs/grouper_E1565.config |   6 +-
> > > > >  .../asus/grouper/configs/grouper_PM269.config |   6 +-
> > > > >  board/asus/grouper/configs/tilapia.config     |   6 +-
> > > > >  board/asus/grouper/grouper-spl-max.c          |   2 +-
> > > > >  board/asus/grouper/grouper-spl-ti.c           |   2 +-
> > > > >  board/asus/grouper/grouper.c                  | 154 +-----------=
------
> > > > >  board/asus/transformer-t30/Kconfig            |  10 --
> > > > >  .../transformer-t30/configs/tf600t.config     |   2 +-
> > > > >  .../transformer-t30/transformer-t30-spl.c     |   2 +-
> > > > >  board/asus/transformer-t30/transformer-t30.c  | 121 +-----------=
--
> > > > >  board/htc/endeavoru/endeavoru-spl.c           |   2 +-
> > > > >  board/htc/endeavoru/endeavoru.c               |  72 +-------
> > > > >  board/lg/x3-t30/x3-t30-spl.c                  |   2 +-
> > > > >  board/lg/x3-t30/x3-t30.c                      |  97 +----------
> > > > >  configs/endeavoru_defconfig                   |   4 +
> > > > >  configs/grouper_common_defconfig              |   1 +
> > > > >  configs/transformer_t30_defconfig             |   5 +
> > > > >  configs/x3_t30_defconfig                      |   4 +
> > > > >  29 files changed, 128 insertions(+), 450 deletions(-)
> > > > >
> > > > > --
> > > > > 2.40.1
> > > > >
