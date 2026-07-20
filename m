Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962F2C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3D7838D7;
	Mon, 20 Jul 2026 14:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MX/etbIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B21983E76; Mon, 20 Jul 2026 14:22:39 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15EDC80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 14:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-8efcfdb2b43so100523036d6.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 05:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784550156; cv=none;
 d=google.com; s=arc-20260327;
 b=Nu/3+2DVgnbmBjt+F0obW2AQ7RKVDT3sFPxUq8No3U+Hr4NOWPnlqFm1RZ7suoiY3y
 +lJJJeng+p6w6AQzkGSJS6Fxc+Yu5zbVrASNqCeUpiB+8FGmlXRY0NbUMnjvWUzxjGr2
 hHJ8zJXbzx1X4bFDa7+jptzf3bIKs1dlOGuE6T6YH9QHAssD2x4OoXKIlD67QGENKiuT
 JZMERCHA8/EoktJaP2Q41Qw/FvFErw8C4vvqXcPncECXjlhkLwUQs2mT3v6O7Eir4pBv
 doaSHEjU9YQbEC/N5WiVFDLTcZDvDwjwd+PCBYngrsL6JReXPP8cbmegYTwkeGymocuc
 HPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EI/lUQHpImFn4NOn+jIwX6aCdmiElIhkJOcThgO6CFk=;
 fh=GmsnL0P0wNkzxM292obuNTeTYIp70ra2G7YuZFjuoW8=;
 b=E4NhnMWIHhQXIiXmBYTh0yuX21S+jt8RsWGVcmWXyPL5k6MeL2Fc1na88SP1tmgY3y
 SjvcXtNEIImIiacWJ/Fd4xneGslDCyEvjd6FTLc8+zBoAF01G18yBrIPNK0/PyGMa8Fz
 QOumzYtV9w1bOHx3kFwpU6y6sub4o4bgwuR8tVHaeBpCU+awqNAkDZAa4nap2FUEtX3G
 svcIfCbuatiZZpPTFyNXRGSFonNdOOi2FbKdxI7njWwkKpvxEmdsGAkgbCR2sOH4DBkA
 dWkU6LzTK/71tY1p8b79HCpdAMqPwbSsY1MvAgAwUg024GnGPDIq5KSiYj+PwAajLSBq
 7sZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784550156; x=1785154956; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EI/lUQHpImFn4NOn+jIwX6aCdmiElIhkJOcThgO6CFk=;
 b=MX/etbIPSIWggY/ymFMbdiBVvjFCI/9gec+AoKJ90XzG34MfLowQCUrSPY6/XyOWyz
 L7cxzgsQQ7eYplN35VqSRcchq3kNAsoyZf3rUih+JDh77F1nwJ0KzzEWvPVG4OlM4g3N
 t9RvHFUtlYlL0j7TDQh4kfGqujq81jCZXSH5XjdXlAiGPHtTBmHxzohqjdi9hj440/9S
 QjIpVOnRiBdaYvYKA0q0FrJx2pFIHXB+egyJpERSrO37987OhOdaIs0SC4jqCLh8GS0c
 uE2hdDcizVqf9Oj4mfOW5EQtv46kHVr+Z19TtSbFztf3MsE/MxCSeLCp38ZeqhCYHUUj
 yWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784550156; x=1785154956;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EI/lUQHpImFn4NOn+jIwX6aCdmiElIhkJOcThgO6CFk=;
 b=VLYBjaLE44xEyYHgJ5Z7W9tacR2uO72gJ0Ql1JgFSEXGQzWacDvD9As1EOZFv3iBOf
 T2uLZUOw3PfvqTu4hXGV1O+BKc0qkg+a+KIDrE0jDjBEjW3/QYRj4qkhmyuVB5THPe7r
 mQyGC+r37f2YH1bZk/yVIwl/bVrgLaUiFFOrm3QrXoXpePyujmLcKWMlRJP5ebFSqmUM
 yB6T6h1WDzYkstbb8Tst94xU6G/KutF78BgPw0rqw06DaWURkYa0PupkzYO9/ORbSeM3
 Yhgd11aRR/gndrPubCvTPIfpRL6nSh94Qf8L5k4yZB/W0W2yTGJVZuKxfez730+jGpNQ
 pd6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RptReoaXK2q8bjgsvS6VBXYBM4+Dz+GpHk4r9/l8pEHz2jdPmhr4RlZiLtebOot/rP7er/bPjY=@lists.denx.de
X-Gm-Message-State: AOJu0YwhxsqGlh/biSAg9t9lg0Gc01lpKHVBcYknDmj+HYA4qnks2M95
 a4m+y0nca5csStYliUwdd21IihFqCoPLhrXe1vRg5zjyb4acDlezNIHwQbStEUgECehoRWrBhu7
 RAFx/eTWy18PB/fewE2wXqr6dNEbSmjc=
X-Gm-Gg: AR+sD10W6R7mP69TwVRSXHwxSAFgy1/86CXjMXYtsYe5AYEIfmnPk1jPyl1Dolb+acE
 IvsIfFHKETTT/yfUWkqxGNk4EwBXlRhvngWoPyyluvrMQS3G7SXHBtyLPkCUjVE71Qvpr2Bo1x1
 1oijsVDWutHZsWJbTmtJXULbFJw7UL5lODthYotNmmZHaCLvRI36iSZG1q4AAxE0CRpj49S6zaX
 l5mqrbbDNCU5wZxH5kTcyKBxNlQLOG+sq6E/oHMuO2lJGcaVD9k2mVOC2U0T3uVSnEVKM/qLrKB
 cLHwzhXUxmxk/mgU+ZOBSv2ztizHUMzHG3L0lGTyctcAE3Mzagp3p20vGJNyrKIUw+wJQiyk7PI
 Hic/GTKSMoOc/h+bB5zgdIYc0pdBaHERLaJ7X58/HG4nwm4dXqG5q8m4bZVPtbF++2fo=
X-Received: by 2002:a05:6214:6002:b0:904:3227:18a8 with SMTP id
 6a1803df08f44-907783540d7mr134460066d6.7.1784550155973; Mon, 20 Jul 2026
 05:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <09e8f60c19d19b1bef47594e89de52585e6405ad.1784423890.git.daniel@makrotopia.org>
 <CAOP2_ThcJNDU1Q8Otvg37LXjOTZGVoR5XruDBBypGqJ3Q8E=KQ@mail.gmail.com>
 <CALeDE9MQsvqUryOeHogR87t8Et7JZ6NbzqjXknxz9ipcjOFxXw@mail.gmail.com>
 <553e5d2b-201d-43da-9c01-e5e699aeae47@cherry.de>
In-Reply-To: <553e5d2b-201d-43da-9c01-e5e699aeae47@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 20 Jul 2026 13:22:23 +0100
X-Gm-Features: AUfX_mw-wsqNEvADzL2Tkeogs-NrrKtgv2eMsSIZGgsdM3GrWAIB4zqcCQBGf6o
Message-ID: <CALeDE9OUMdos6fX3dJR+7E1X9uT8MV-FCPqWbNz7KuQU8gH6jA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: rk3568-nanopi-r5s: drop eMMC HS400 modes from
 the U-Boot FDT
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tianling Shen <cnsztl@gmail.com>, daniel@makrotopia.org,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Mon, 20 Jul 2026 at 12:07, Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
>
> Hi Peter,
>
> On 7/20/26 9:59 AM, Peter Robinson wrote:
> > On Mon, 20 Jul 2026 at 02:59, Tianling Shen <cnsztl@gmail.com> wrote:
> >>
> >> Hi Daniel,
> >>
> >> On Sun, Jul 19, 2026 at 9:53=E2=80=AFAM Daniel Golle <daniel@makrotopi=
a.org> wrote:
> >>>
> >>> U-Boot passes its control FDT to Linux, so the &sdhci override adding
> >>> mmc-hs400-1_8v and mmc-hs400-enhanced-strobe reached the kernel, whic=
h
> >>> unlike U-Boot actually drives those modes and then failed on the eMMC=
.
> >>> Keep HS200, which works, and leave HS400 out. Affects the R5C too, wh=
ich
> >>> includes this dtsi.
> >>>
> >>> Fixes: 0ef326b5e92e ("rockchip: rk3568: Add support for FriendlyARM N=
anoPi R5S")
> >>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >>> ---
> >>>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 2 --
> >>>   1 file changed, 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dt=
s/rk3568-nanopi-r5s-u-boot.dtsi
> >>> index 64c43374c04..7e0b2ba02e4 100644
> >>> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> >>> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> >>> @@ -15,8 +15,6 @@
> >>>   &sdhci {
> >>>          cap-mmc-highspeed;
> >>>          mmc-hs200-1_8v;
> >>> -       mmc-hs400-1_8v;
> >>> -       mmc-hs400-enhanced-strobe;
> >>>          pinctrl-0 =3D <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastro=
be>;
> >>>   };
> >>
> >> The whole sdhci node can be removed from u-boot.dtsi since these props
> >> are already included by upstream dts.
> >
> > I've already sent a patch to do exactly this, it was on my list to
> > chase up for this cycle:
> > https://lists.denx.de/pipermail/u-boot/2025-December/605369.html
> >
>
> I can merge that patch once my question there gets an answer :)

Replied, apologies, I must have read it as a statement and not a
question and as a result missed replying.

P
