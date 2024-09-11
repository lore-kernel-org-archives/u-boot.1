Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40F9EE01EE
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 11:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE0389279;
	Wed, 11 Sep 2024 13:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cnnwobI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6EC58928A; Wed, 11 Sep 2024 13:12:26 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B491089270
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 13:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374c7d14191so485637f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726053144; x=1726657944; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+BLboQbXhdCwMl/iWzMvCQHIcbC1vAot4nazbVtFUk=;
 b=cnnwobI3HSEyFVo907K7qSpTFJ9hCnOEKHF9IltzYXc+mk3aSiV1G9JWj4TlGtTVzz
 ElTF4pcAQoBoyUrdZZ1928xXXOZSeM32DboCl3aXQ8HV4SjgPmzsacf+hjC2rwv6Fek5
 fH9b0i0y0XH6ucBLdA+VO9ZFOBbV3KppQ0evsPmTt2TPeIoHwyzYIa1BtH+FhrP2SQin
 LIkE7RaYkmFViocknHeQLNg/0xeWdVnSokBgbHTFOWGmGH/AYaZSNcRvDeHokJ7U7ir9
 Fiz/QeudAeCZXg9LZZt3v26cdfXrRBdTfh8+LBkfB1vJuzwY0PQV8NE7F2hpW7hmF1BP
 V9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726053144; x=1726657944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+BLboQbXhdCwMl/iWzMvCQHIcbC1vAot4nazbVtFUk=;
 b=EWIlK64+PpFhDVTmsVVg0lt5cK9+VLHZbnfxrrEE85uLs6yCfCfW53eiheVUqGaE1a
 zss+//enw58VhXZ+MujUvTwZkeZlXUYSgWpLS6vdxJiu2SUer9vhupjc6LsR+/fbilhE
 vBZsBdw2rcbnJcrYBCBzfla3l7Ey1efkPFJ6IOiPc6BRvnkke3/M85RGDvi1S6sJjSxv
 PJRtlWUfwuYCS/jkNjmoh2uoix/KwlYebOUIVvvK5Lb4L8MLtoy2jRiTC96yXlz7NNMy
 nTiO0cWjeTUYHKvW4UGEgqacot9piXiroDKP9dbj/kiM+lSSNVnUeXfbCcMxm0btL/Oi
 kBZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl7SatJfx8oRjvEk0X71QN6wyPoJ2nEB+/avs4fZjNiwDhq2DOA2kCPlXAR7HmGaBuSZ+7Frs=@lists.denx.de
X-Gm-Message-State: AOJu0YziyUnQxw+ElFUqy8pwwkuAhrmltIXXIzAQgc9qpdudTaieEF8P
 u9/e3AEwnU1AJd8fgvOmVm1kRRmd77rK5JNmfxLQXDngIKfsAtRWYdO9aDl263qE8aSaTvBBW0q
 ozyY5LDcm6QXMJ0I7YIhfjuTg9MI=
X-Google-Smtp-Source: AGHT+IEx7XOYNRr/D4/84V9Zzu5PALu3PVctmPJDfr8baDh0VkpsqYYqezSJYG5M7VZnIqag7EzaPUl1z1cAyLQPwD8=
X-Received: by 2002:adf:e8cd:0:b0:374:c33d:377d with SMTP id
 ffacd0b85a97d-378a8aae3ffmr3740551f8f.28.1726053143444; Wed, 11 Sep 2024
 04:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
 <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
 <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
 <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
 <CAPVz0n2Jzfih0Z85TSQbnz-8OrX4D6UN=anKGTJ=hckRt8f3xA@mail.gmail.com>
 <a95f0d60-2883-4c3d-8a53-ee3ef414cc32@denx.de>
 <CAPVz0n3Ji1sKQK+Lnq8rP3ZqwX3o-kXe2btj93UuVBa3T5C=qw@mail.gmail.com>
 <eced1020-2157-44a4-98a9-845e218529d9@denx.de>
 <45c74c58-98cf-43df-b837-c48b0341c551@denx.de>
 <CAPVz0n2-DCKDcVrAi00kF6yDcE2bN1mtUhzBcw7JDiZoXgzu0w@mail.gmail.com>
 <e5837ce4-0a14-4822-960d-6ab667a9f4b1@denx.de>
 <CAPVz0n323ktF6kb3WHR9JcE+xOzQr9-aWOR47+ZvwQr=ib18rg@mail.gmail.com>
 <f778366b-bdaf-415d-a94e-c995f62e8c71@denx.de>
 <CAPVz0n0ru1rPb9SNw515mkwfs4=nNSOPjZY74JVkqnGbEouSLQ@mail.gmail.com>
 <cfc1a158-6c35-4288-aed0-fcc78a8db832@denx.de>
In-Reply-To: <cfc1a158-6c35-4288-aed0-fcc78a8db832@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 11 Sep 2024 14:12:12 +0300
Message-ID: <CAPVz0n1Vh7Vgnt8_Lx6U8p42QvtVnHB9yvb=RmjYrS=w1G3u1A@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, uboot-stm32@st-md-mailman.stormreply.com
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

=D1=81=D1=80, 11 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 14:01 Mare=
k Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 9/11/24 7:57 AM, Svyatoslav Ryhel wrote:
>
> [...]
>
> >>>> You did mention something regarding I2C/PMIC driver probe timing, bu=
t it
> >>>> seems the I2C driver and PMIC drivers probe roughly around the same =
time
> >>>> in both pass and fail cases ?
> >>>
> >>> Yes, here I agree that they both probe and probe passes, but I assume
> >>> timing of i2c call is critical and there may be some dependency which
> >>> is not ready.
> >>
> >> My guess would be pinmux or clock, maybe the i2c controller is marked =
as
> >> bootph-* in DT and its pinmux/clock is not? Maybe the i2c on tegra wor=
ks
> >> by sheer coincidence right now? Can you have a look?
> >
> > Power i2c line (one that hosts PMIC) is configured extremely early in
> > SPL since it is needed for cpu and core voltage setup so even if, as
> > you say, tegra works by sheer coincidence, specifically this i2c line
> > should work non the less, since it has all its pre-requisites (clock
> > and pinmux) configured on early stage.
>
> Is it possible that this configuration is somehow reset or reconfigured
> from DT early on in U-Boot proper ?

No

> Do you have serial console output in board_f.c time in U-Boot proper ,
> possibly using DEUBG_UART , to check if there might be some prior
> failing I2C transfer at that board_f.c time ?

Haven't spotted anything weird there.

> > As I have told, I was not able to determine exact reason why this
> > happens, it should not and yet it does. This is why I have abandoned
> > my attempt to implement same changes you are currently proposing.
>
> If tegra has a problem, it should be fixed on tegra side and not block
> core plumbing. I am not seeing the problem on stm32 or imx systems, so I
> am banking toward tegra-specific issue.
>

And yet you are pushing tegra breaking stuff. I will insist on
reverting this is it passes.

> Are you able to debug this ?

No, I am not able find exact cuse of this behavior.
