Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91ECCCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 11:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8158883106;
	Tue,  9 Sep 2025 13:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jb2aL3QJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE788313B; Tue,  9 Sep 2025 13:26:33 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7EED830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 13:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3e7428c4cbdso1580222f8f.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757417191; x=1758021991; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYBosi4Ond0DYdGOwqVwxQ8HT5ER+bj9kB9+FsbHuTE=;
 b=Jb2aL3QJ6jipy+s/Rd64wNAYG7O0QM+JJe4ywWcPAoPhODtPDR2p+IENsk4CqzrpIe
 xmz34cmtcxy81CgF7v6lgTt/LH0bd8g4Qjkk6d2J3+QyEp+R8aten3tQg0eNdbpFH6sr
 GSN4AaRa6trYe5S0KtHYdGP9gvEgNJJvmrJt3gzXhYRmUyOH1MHxmuXcF40KTrrbAHCx
 JxmAkQCp3rUAohJOXtx1lJ9zhI/X7FXKz55Cchy67hPdQJ63kpzwQnjSTDOalqa1BFCu
 mDqe5NURO4QwYr0zKu2/H7xldoWHL4Mp0WgPUs7h4uaw9eVHpmtNk40gMznvpT3DrYZj
 z91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757417191; x=1758021991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYBosi4Ond0DYdGOwqVwxQ8HT5ER+bj9kB9+FsbHuTE=;
 b=og2DpxG0OlXS8t+Yq59QdWdXOwAf26PdpZW/9IdKpop4GeMyuRWzyUwrBiT8REHujf
 xMdi0k/DU5GlmyNy1sd30Ka9B4oW8srVwHqXGsPpx2m939it5rgIy6o3EzL3bmtIOFVx
 Yt/jkGbXq6uhAPzO45w50c/khkBoAFikxbfR/m+Jsk6jQpmhlhMRmVwDa4yVBmfCI6+s
 Us4dGUy4yenB7vjeh0231QRIMr3DnfWw/aWkiZ2XjxNDPmWjRwYF8blAgvlpmoB8WwT/
 b2UIWi1FLEP9PDXGqYOIFcOnijfYKIOlKdwiVCxAY+lryefntf+d69dO3xOl6/d5JRI/
 9wxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTgNQGKJUXCa2Eu915o5AqIud2sPiGmNwiffvTcpNwBCFwq9EfqmLiTT8AG3Xyl5WTDjGq8RQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6Pik+6IUgiSlQ8q5KDBnU5htMNbEtsY3xGaI3edkoC1ok51xD
 WnZr4GXACg/Rk/TLDDMcoQWWDAHLH8+wC1k3ejxEZkw+WQ6XtqXsZ6biMpKpC/g7F1I7+vO/vEH
 bReai3LSWwzVWBMxJIwUZHtjQCRgvPn8=
X-Gm-Gg: ASbGncutGypHT+O2E0QYam9/HlfHvO6Lpv+KVT14A0do+aPd31oQ/NX/GNzZElB5oYs
 I88u6jG0hDXp0Pxm2mPknSvchKDM0+eR0fBP5A8QZ2gPOg6CJYRtqqDIXJ7MHEwPdpcqXr3Njie
 R4R5nbQEf2SR5KXZok8Zy8A2KOYYpLFTauRG05dK9v8EFDzaE5K3ChKJ688TASLFywAwUPRu6Xs
 MjaA9LX
X-Google-Smtp-Source: AGHT+IGqKRuqWYxNJflgcGhznIyCCOJ7UH3VCtnzwaJEthw6JT0+PPx8iKH2V3EiQ3L1A2APr8YsvTysLL3isNQvEm8=
X-Received: by 2002:a05:6000:22c3:b0:3cb:e47c:5e4e with SMTP id
 ffacd0b85a97d-3e634aede67mr10170598f8f.24.1757417191013; Tue, 09 Sep 2025
 04:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
 <20250909121537.1c2a95b1@wsk>
In-Reply-To: <20250909121537.1c2a95b1@wsk>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 9 Sep 2025 14:26:19 +0300
X-Gm-Features: AS18NWAPRXdy-ShQmDghCncCT6Y48qwmw9tKTcKOABhvGUnG_tVeMA2YLXrp_dQ
Message-ID: <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node is
 processed
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 u-boot@lists.denx.de, 
 Tom Warren <twarren@nvidia.com>, Stephen Warren <swarren@nvidia.com>
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

=D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:15 =C5=
=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> > =D0=BF=D0=BD, 8 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:41 =
=C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > > =D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=
=BE 12:39 Lukasz Majewski <lukma@nabladev.com>
> > > > =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > The Tegra30 SoC is a bit special, as it doesn't have the
> > > > > separate IP block to provide watchdog functionality.
> > > > >
> > > > > Instead, timer IP block allows such functionality when properly
> > > > > configured.
> > > > >
> > > > > As in the tegra30.dtsi there is a timer node, which "covers" all
> > > > > timers, with 'nvidia,tegra30-timer' compatibility it was
> > > > > necessary to manually bind U-Boot's WDT driver (based on
> > > > > WDT_UCLASS).
> > > > >
> > > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > > ---
> > > > >  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
> > > > >  1 file changed, 18 insertions(+)
> > > > >
> > > >
> > > > What is the practical application for this diver in therms of
> > > > Tegra and U-Boot overall?
> > >
> > > You have the WDT functionality working. It uses the same DTS
> > > bindings as ones used in Linux.
> >
> > Why do we need WDT for Tegra in U-Boot at all?
>
> Can you correct me if I draw wrong conclusion - you ask why Tegra needs
> to support watchdog in u-boot bootloader ?
>
> > It is not used and has
> > no practical application.
> >
>
> Yes, it has ...
>
> Customer has number of Tegra30 colibri modules in the field. They want
> to switch to u-boot + linux kernel BSP.
>
> For their application - it would be welcome if the device could reboot
> and start emergency procedure in the case of not being able to start
> Linux.
>
> The procedure is that we start Watchdog at very early boot - then we do
> have for example 30 seconds to "feed" the Watchdog in Linux
>
> When we fail, after watchdog reboot, we can switch to another rootfs
> partition (the A/B scheme of booting) or start emergency system.
>

So when are you going to submit this board variant? If driver has no
users, it is removed.
