Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93C1EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A62188E22;
	Thu, 12 Sep 2024 03:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O0zX6kM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D5888DF3; Thu, 12 Sep 2024 03:00:35 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93A588DC4
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-717849c0dcaso346208b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102831; x=1726707631; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qN9BG419/gWkhYof1uI+wL0WMyUhWbwlAHezuR7Fmkk=;
 b=O0zX6kM6n/9++kKSCd6Li8yygwven/m+Uj8Vzqu8sZycrVA2td9tVfpQits+n6OlvM
 wsBf0W4h9M8/VebKQaYXZDoQ9DyTWoV9+F2l+1fBz99NjFo0G8T6ShMmlSJgieXNMFVo
 0pQqiVSWkJiV4yplErKrQwbWJud4vX0is6Bds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102831; x=1726707631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qN9BG419/gWkhYof1uI+wL0WMyUhWbwlAHezuR7Fmkk=;
 b=eqiOkbiYC9+b5SogWrNCskwUDYWfkt0I4J1rINSpPWUJJWX4Bz9FUuQDSfVymPRcNa
 +0cl+QPbjTFCxcQuSx+N2B25f3U0Ua+fgqnDBH1xQvzpQu9UHGfg7z81B9mdtqLHnmYR
 WcDhu1C7YzzFmAoh0K1qTVyg9+ofYHrnt4pGtxjEM70I+GVQNa8L9qtSPfbsleOXtdEF
 OGkvVCpePRxqMvGxERS7r/g+/oxU+Cy1c6/JN0cBxY5F5x8q2EwRlr0IStXX02TYf2gy
 J1GspeGw9MbcEN+vsKhV0s9hmm3GLWqTxwo6YuHgIzZ2C7642cCoSUF7XzXYWFAVM7T+
 YABw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx6Qlq4lojX9SyE6vjyoXvzjwEcavG5FeVsgWYhWR/3FFoK7JYS1LYHiWhsMgEt5KdaWFetRU=@lists.denx.de
X-Gm-Message-State: AOJu0YxnlaTyV5gS1YAiG6LeV7Ao/BHpFSQuT02N8WtafBexBPDeSWNU
 0GX+qbAFrLk6nmxg8hacOubWh+Z5EQutUc8l3OU0UysPJzHE0AVq7DftECgFbEwi4nzks1b1YTG
 +jXEJqu0svz7qYhaUPgjrIJrtW8DodzhJ/2aKv5bSQz97YFA=
X-Google-Smtp-Source: AGHT+IHiZu33iyo5NkYXLR10lf3TGbBLsugivLlPbQCG8ZJQZRsS1XrZEVvn1jS5UzwjPUm7S+jbsNX9LD2ncgcyKAo=
X-Received: by 2002:a05:6a00:4f8b:b0:70d:2796:bce8 with SMTP id
 d2e1a72fcca58-719261e794fmr1813501b3a.20.1726102831104; Wed, 11 Sep 2024
 18:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPVz0n3Ji1sKQK+Lnq8rP3ZqwX3o-kXe2btj93UuVBa3T5C=qw@mail.gmail.com>
 <eced1020-2157-44a4-98a9-845e218529d9@denx.de>
 <45c74c58-98cf-43df-b837-c48b0341c551@denx.de>
 <CAPVz0n2-DCKDcVrAi00kF6yDcE2bN1mtUhzBcw7JDiZoXgzu0w@mail.gmail.com>
 <e5837ce4-0a14-4822-960d-6ab667a9f4b1@denx.de>
 <CAPVz0n323ktF6kb3WHR9JcE+xOzQr9-aWOR47+ZvwQr=ib18rg@mail.gmail.com>
 <f778366b-bdaf-415d-a94e-c995f62e8c71@denx.de>
 <CAPVz0n0ru1rPb9SNw515mkwfs4=nNSOPjZY74JVkqnGbEouSLQ@mail.gmail.com>
 <cfc1a158-6c35-4288-aed0-fcc78a8db832@denx.de>
 <CAPVz0n1Vh7Vgnt8_Lx6U8p42QvtVnHB9yvb=RmjYrS=w1G3u1A@mail.gmail.com>
 <20240911162503.GQ4252@bill-the-cat>
In-Reply-To: <20240911162503.GQ4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:59 -0600
Message-ID: <CAFLszTjsJFmdsTUEOC-uFKUMyQDJkLhzvcyrSTSFhLF4L=Cp6w@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sumit Garg <sumit.garg@linaro.org>, 
 uboot-stm32@st-md-mailman.stormreply.com
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

Hi Tom,

On Wed, 11 Sept 2024 at 10:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 11, 2024 at 02:12:12PM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 11 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 14:01 =
Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On 9/11/24 7:57 AM, Svyatoslav Ryhel wrote:
> > >
> > > [...]
> > >
> > > >>>> You did mention something regarding I2C/PMIC driver probe timing=
, but it
> > > >>>> seems the I2C driver and PMIC drivers probe roughly around the s=
ame time
> > > >>>> in both pass and fail cases ?
> > > >>>
> > > >>> Yes, here I agree that they both probe and probe passes, but I as=
sume
> > > >>> timing of i2c call is critical and there may be some dependency w=
hich
> > > >>> is not ready.
> > > >>
> > > >> My guess would be pinmux or clock, maybe the i2c controller is mar=
ked as
> > > >> bootph-* in DT and its pinmux/clock is not? Maybe the i2c on tegra=
 works
> > > >> by sheer coincidence right now? Can you have a look?
> > > >
> > > > Power i2c line (one that hosts PMIC) is configured extremely early =
in
> > > > SPL since it is needed for cpu and core voltage setup so even if, a=
s
> > > > you say, tegra works by sheer coincidence, specifically this i2c li=
ne
> > > > should work non the less, since it has all its pre-requisites (cloc=
k
> > > > and pinmux) configured on early stage.
> > >
> > > Is it possible that this configuration is somehow reset or reconfigur=
ed
> > > from DT early on in U-Boot proper ?
> >
> > No
> >
> > > Do you have serial console output in board_f.c time in U-Boot proper =
,
> > > possibly using DEUBG_UART , to check if there might be some prior
> > > failing I2C transfer at that board_f.c time ?
> >
> > Haven't spotted anything weird there.
> >
> > > > As I have told, I was not able to determine exact reason why this
> > > > happens, it should not and yet it does. This is why I have abandone=
d
> > > > my attempt to implement same changes you are currently proposing.
> > >
> > > If tegra has a problem, it should be fixed on tegra side and not bloc=
k
> > > core plumbing. I am not seeing the problem on stm32 or imx systems, s=
o I
> > > am banking toward tegra-specific issue.
> > >
> >
> > And yet you are pushing tegra breaking stuff. I will insist on
> > reverting this is it passes.
> >
> > > Are you able to debug this ?
> >
> > No, I am not able find exact cuse of this behavior.
>
> How do you propose we resolve this then, Svyatoslav? I threw this patch
> at some TI platforms as well and they're all fine. Are you unable to get
> some early debuging information out like Marek was asking? Thanks.

At this point I would like to have an optional Kconfig to enable the
always-on regulators in the init sequence, perhaps as part of
initf_dm(). It should not be in DM core, sorry.


> --
> Tom
