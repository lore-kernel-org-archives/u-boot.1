Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A98CC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 18:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682BA8753A;
	Tue,  2 Apr 2024 20:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MYeD2ObF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6B483348; Tue,  2 Apr 2024 20:57:11 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C1D8753A
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 20:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a47385a4379so33760166b.0
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712084229; x=1712689029; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zdopvwx5J1vuf/BfTSQRXRXkIaJDcBS6b58pu+RjDeo=;
 b=MYeD2ObFhirPYLP0csQoS1bb9eilM6HOorUH09eV/jRlfNxJn3oLe/sdJFmJYm4gff
 DT5IWcZL1+rcVU4pumcdg97te0KtPaNSzD2DICj3GVz7WMnsgf8PtOQD8498xM+x7mdU
 CK14sNfak6pgb2n2YP1l8prsdZxqI89C4Oy4QVb9s4OnPdcAIQMvhhIfkALBSqeY/xRs
 RVfB+i3DnFZ70f0xd7nVhk6CMlkO4kJs0XpZmMdyMWJ/TTS7B2IspBzSiFsI1ErmAcnM
 FpxZxtMhSLEKq2sy3Z8RJLz9TBAl+/Fzso4tYJQqjsNNFR6YmEa3Iyoesn42ior41Qc+
 YTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712084229; x=1712689029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zdopvwx5J1vuf/BfTSQRXRXkIaJDcBS6b58pu+RjDeo=;
 b=L6NquGKibqCtdHBjQVc7sO1uIYKwe7VAQgpdQ8IC7CaGmvzjIXMDPtPflsJciWzXws
 YZoabR101B9Je8zKBn4ycUKf0GXymBEV5ah9s3QTjgoj5WiPiBvSzpCTRd0lej0Un4kl
 w2/ZdwEQ7eGzf/O6qBf30qCG2ihuCAVMlePniTEg7xe25cretSnJCkre9/U4stoo+D1b
 tdTWez5mLCjs+FI1AD6ePJXr7JRYY+ueDssNDNI2O2a9BqGu6HDLeRC9DT0LbldDInfL
 14/8/gnel8LQolDjBE2j6w2o+jCPaNVa/8yMz6RJGLJRnLgPGoi+vp7eGl99NNzXvzr8
 DM7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAOkaHEQD/YG9g0zjrGYZNA4pppv+pReBpQivGkUBwaQPSJbDpAHPi9n4uBZaLbn/2r6Nn9jyUM/V34OsuN8I2RRj13Q==
X-Gm-Message-State: AOJu0YxpOJxoQmYl0OSWj9J3o9YpBz8+9uJsrVmyTAeZeMtsFZDmw/p3
 VWTJNg50vd1hoAGep/tb4wZVZwDkwTf5aXWbwvvTy+5nVL5ZomN5KcJ7s77yCeno6A8WXWbN6RK
 QlGwOm1KirxVx/vrZzYsVlbI/iF0=
X-Google-Smtp-Source: AGHT+IFPO0NqHq6hmKaeD9+mcJMm3ERv6YSI7QhMgRu1w48+dMtCyM71WCZKsUA6fIvP1wehgTnLDEJnBBCkKUQczno=
X-Received: by 2002:a17:906:b058:b0:a47:1f61:4d02 with SMTP id
 bj24-20020a170906b05800b00a471f614d02mr275385ejb.36.1712084228650; Tue, 02
 Apr 2024 11:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240330175948.80931-1-bigunclemax@gmail.com>
 <20240330175948.80931-2-bigunclemax@gmail.com>
 <04c61877-29ef-4a09-b003-eb36733ccca4@seco.com>
In-Reply-To: <04c61877-29ef-4a09-b003-eb36733ccca4@seco.com>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Tue, 2 Apr 2024 21:56:57 +0300
Message-ID: <CALHCpMhx_ViUXfgPPAHfn4jTp7X9grYCtAxH3pnz1bYjkUAg7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] mmc: snps_sdhci: Add sdhci driver support for
 TH1520 SoC
To: Sean Anderson <sean.anderson@seco.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Geis <pgwipeout@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
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

Hi, Sean

=D0=B2=D1=82, 2 =D0=B0=D0=BF=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 18:39, Sean=
 Anderson <sean.anderson@seco.com>:
>
> On 3/30/24 13:59, Maksim Kiselev wrote:
> > Add support for DesignWare SDHCI host controller on Alibaba TH1520 SoC
> >
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > ---
> > drivers/mmc/Kconfig | 12 +
> > drivers/mmc/Makefile | 1 +
> > drivers/mmc/snps_sdhci.c | 464 +++++++++++++++++++++++++++++++++++++++
> > 3 files changed, 477 insertions(+)
> > create mode 100644 drivers/mmc/snps_sdhci.c
> >
> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> > index cef05790dd..6936fa0928 100644
> > --- a/drivers/mmc/Kconfig
> > +++ b/drivers/mmc/Kconfig
> > @@ -671,6 +671,18 @@ config MMC_SDHCI_S5P
> >
> > If unsure, say N.
> >
> > +config MMC_SDHCI_SNPS
> > + bool "Synopsys DesignWare SDHCI controller"
> > + depends on MMC_SDHCI
> > + depends on DM_MMC
> > + help
> > + Support for DesignWare SDHCI host controller on Alibaba TH1520 SoC.
> > + This is a highly configurable and programmable, high performance
> > + Mobile Storage Host Controller (MSHC) with AXI as the bus interface
> > + for data transfer.
> > +
> > + If unsure, say N.
> > +
>
> Why not use MMC_DW?

That driver looks completely different. As I notice in the cover letter,
the MMC_SDHCI_ROCKCHIP driver is closer to TH1520 driver.
https://lore.kernel.org/u-boot/20240330175948.80931-1-bigunclemax@gmail.com=
/

Their IP blocks look very similar.
Moreover, on Linux, Rockchip SDHCI controllers (ex. rockchip,rk3588-dwcmshc=
)
and the TH1520 controller live in the same driver - sdhci-of-dwcmshc.c

We could do the same for U-boot. It will require to get rid of Rockchip
specific defines that come from asm/arch-rockchip/hardware.h.
And maybe rename the rockchip_sdhci.c driver to sdhci-of-dwcmshc.c.

That's why I mark this series as RFC. So I'm willing to discuss any option.

> --Sean
>
>
> [Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/emb=
eddedworld2024/Register/ew24517689>

Cheers,
Maksim
