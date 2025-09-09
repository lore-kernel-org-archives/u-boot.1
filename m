Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22D2CAC587
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 15:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A95B830B4;
	Tue,  9 Sep 2025 17:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKN47VJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4848313B; Tue,  9 Sep 2025 17:44:59 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEB508309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 17:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3df726ecff3so3101165f8f.3
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757432697; x=1758037497; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICdwU3D5CLD3GV2eLGtbp/QwUPkj1ZEH1gOS1bdjzgs=;
 b=XKN47VJpLW0Epvxj3xxXCp803YVZvFk/gby4EpXNmkaT4Q00WY5RiLw6Cq12Uj/1+J
 vdtMDWHru2XYMH+xHupWM+rKF+gGebps/awlDoiYr/sc17eWejCYac2OnC5XOPhCX3GQ
 ENEQxnWB8rbxXI6Mpylw8HTu7GENP4oVaF3AIL9/beapgt041jEIJ63VRFHSaX7bLw4a
 P/FyL2n/52IpBGhlE+Z8JV5zcJ/hPBgDR+57YfpL1Zp9Eg82Qn45BZvxBeT1t/cb2YwD
 jyiBGhrIMlZTFY+K68PdlFaul72idBxdW7r7UaNlsFs8rUKKZfhEKyB8rem1a+BManRA
 n1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757432697; x=1758037497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICdwU3D5CLD3GV2eLGtbp/QwUPkj1ZEH1gOS1bdjzgs=;
 b=GVgWXzi663i5+y5sg1WsLUMN3+Q79omOc2N8vWiQcMHt6TG2vuwo+WUbYEsINd0zs3
 qPTSBTBvdDvJEE08yExsyDFYit86wlLi9usSrF+UQNaB55Eq2bzG5n19oO67O0KVOugK
 5VwzDNpnGSDt8Kw7l68y4uvBtk/lols+AeMi/oRc040G66mKEahfMFY7JHfk4oP/fDWe
 q4ArLasU75aAQRLFCZMEMhHwwEfWNKMxTNIS+S8ui4t+N8P3/KIAWXkNjH0e5HOsC1zV
 xwDOM2XDA5f0yuL1cxzGJMDUnk2UIsHIwK3BYKZ+ZoCExcuF1T7QXcAj1jld1kXDyreA
 8cYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS4zrKz55Du22dTbDmMj3cqXsndLrLnwFkzDh1fpUpfm5ezMWkGPIBCEYclegOIDdgQIMxF1o=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7xwOi8ZsfH0Jgxd+wEQgEEyt5H12hObHaWr1p6vkUtAvZcmlF
 guobeXMOuqHgKtl/k/cPMBjWcSx2EVUv12ceHNxjfgCllcoq6q2rL2W67C0OJkX9CIG7N0VsJYZ
 A6lUn/jNDwmN3hvChh27YwC65K8sFp+g5EQ==
X-Gm-Gg: ASbGncvC/FXgCjtm9kMMoG8Q2UVSj1Q+ZJurYdNA3Yc3RJW1IGQDTPNYN1TMhHfGN4p
 tzPHjnWG4ihfbZBjw2PC15OfK8g96tZuju0d1yTkG75tvf2xh949J0Fb1bblsinrB/DMwqIVb/j
 U2R54CW1BQ98t76fW9SJrLausMzXApfl3xAl418NSditPlqgFQcbx69VAuFEPfAUku6MCl0kAzA
 +dVpnpW
X-Google-Smtp-Source: AGHT+IEhrK5Cfp4/yqvIg5ZqQMt0INm79rGi3W13fylnTfZNR1jQThAlGGMOOr2Nfy2+jxIrxMrNpN8QJSe9RTuFzoo=
X-Received: by 2002:a05:6000:2912:b0:3e3:f332:7414 with SMTP id
 ffacd0b85a97d-3e6440f05b0mr8952371f8f.58.1757432697106; Tue, 09 Sep 2025
 08:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
 <20250909121537.1c2a95b1@wsk>
 <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
 <20250909153948.GY124814@bill-the-cat>
In-Reply-To: <20250909153948.GY124814@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 9 Sep 2025 18:44:45 +0300
X-Gm-Features: AS18NWASp2p86pp6zw000PXP60J4JxL4empVpnWZPnD0eQuV81h4ZZDhzVs10bg
Message-ID: <CAPVz0n1xCXPq6Qhd+EuJxkno=g8p5VXjxw0MaAz3ePumCzU4mg@mail.gmail.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node is
 processed
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>, 
 Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de, 
 Stephen Warren <swarren@nvidia.com>
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

=D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 18:39 Tom R=
ini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Sep 09, 2025 at 02:26:19PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:15 =
=C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > > =D0=BF=D0=BD, 8 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:=
41 =C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > Hi Svyatoslav,
> > > > >
> > > > > > =D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80.=
 =D0=BE 12:39 Lukasz Majewski <lukma@nabladev.com>
> > > > > > =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > > >
> > > > > > > The Tegra30 SoC is a bit special, as it doesn't have the
> > > > > > > separate IP block to provide watchdog functionality.
> > > > > > >
> > > > > > > Instead, timer IP block allows such functionality when proper=
ly
> > > > > > > configured.
> > > > > > >
> > > > > > > As in the tegra30.dtsi there is a timer node, which "covers" =
all
> > > > > > > timers, with 'nvidia,tegra30-timer' compatibility it was
> > > > > > > necessary to manually bind U-Boot's WDT driver (based on
> > > > > > > WDT_UCLASS).
> > > > > > >
> > > > > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > > > > ---
> > > > > > >  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
> > > > > > >  1 file changed, 18 insertions(+)
> > > > > > >
> > > > > >
> > > > > > What is the practical application for this diver in therms of
> > > > > > Tegra and U-Boot overall?
> > > > >
> > > > > You have the WDT functionality working. It uses the same DTS
> > > > > bindings as ones used in Linux.
> > > >
> > > > Why do we need WDT for Tegra in U-Boot at all?
> > >
> > > Can you correct me if I draw wrong conclusion - you ask why Tegra nee=
ds
> > > to support watchdog in u-boot bootloader ?
> > >
> > > > It is not used and has
> > > > no practical application.
> > > >
> > >
> > > Yes, it has ...
> > >
> > > Customer has number of Tegra30 colibri modules in the field. They wan=
t
> > > to switch to u-boot + linux kernel BSP.
> > >
> > > For their application - it would be welcome if the device could reboo=
t
> > > and start emergency procedure in the case of not being able to start
> > > Linux.
> > >
> > > The procedure is that we start Watchdog at very early boot - then we =
do
> > > have for example 30 seconds to "feed" the Watchdog in Linux
> > >
> > > When we fail, after watchdog reboot, we can switch to another rootfs
> > > partition (the A/B scheme of booting) or start emergency system.
> > >
> >
> > So when are you going to submit this board variant? If driver has no
> > users, it is removed.
>
> I assume it would be enabled on colibri_t30_defconfig.
>

T30 colibri does not need it and does not use it with current
configuration, hence I am asking about board submission.

> --
> Tom
