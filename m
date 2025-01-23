Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88252C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3135B801B0;
	Thu, 23 Jan 2025 15:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZlPMuNX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34F0080214; Thu, 23 Jan 2025 15:38:05 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C09280137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso430824866b.1
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643077; x=1738247877; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNJxby0fdzs+xbLUe+PsRRCOK2l4gyEDJNOl100PK4s=;
 b=fZlPMuNXJx2fpz4Hvr3SsAQnajwINnoRZeqL13ZpqsS6u+YmK0t6ODKT7KMlCLlHYv
 pA5FCxjpAvSyKg2tiEKPctTooBEvz2yCwDrOdEUgFeJB9BHx2T+IJAePI8uCUklpMrAD
 bybXVU9BfzBNNI6HtHcUwexrFIPnR8WxJ8Tfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643077; x=1738247877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vNJxby0fdzs+xbLUe+PsRRCOK2l4gyEDJNOl100PK4s=;
 b=BrBSXc8wlE0YHsdrUKOzLKL8qi4N8v4lPzO9+kfvJl7GTB5eUgjM7KlVfY6NgB/mab
 dnCGsGWLa0kxP7gr1txu7GFvmK4zBsTG3BgwrBIyRCpZKDNO5GPVkTsMXeUMhlL3b5Rb
 9eVfOSMDdcusQUfJ0XJ17kiVjPP3W8nFpuaxiJK7FkPwcaOQEgyoJkuz7sxuei+Dx965
 yJ8ZLAXDzz78W3+Eid832VTTGz3SU+a8VKmOPLAikGyreK2HVxDzM7qCJHY2PSrkcpPe
 8td0MrvZRTnf1Vg9QoQ+U0rpYU1wYQ/BpYL+A1gPmGRCeyfRnSBeK39rmNwb8JC461gY
 Z6kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCfZPnFuWIGC4axDtZgxB8GmxuTPlQU2BpT3vBMuNOlNAODQpLy5HhZuJXGB/bVec9+porads=@lists.denx.de
X-Gm-Message-State: AOJu0YxQlY5h1pi2//8Vyn6NXreOxcf1Dz00bIwcbaPscU4Oq055dYl1
 2jL+9QZNnwWKF1ZtGM4zh9BoATjVPy/QR+4MeYQsN4me+vMCoLcU5BaSMj6NQhCOF1f848EtSAX
 1YPNpFoIYabDEnsEaEnP6EZJfVG8depTOs+ma
X-Gm-Gg: ASbGncs70d5uaXyvg43K5bAMqjvnEXjYFZqOO0VT6gNmuwATwzMsA8ZL+KMPkNA+sTA
 o00Vu4rPtriYooza7EpsmAghxyQT4dtGOWn3otYNUveBbf1NOzNGFNsbu8cEBAg8=
X-Google-Smtp-Source: AGHT+IFdk1f9qOov+yfq1lcd1/rMNC9Ck0JFjhXOdIsS6isQZYf+dUpplD+hsv3DKDoj9KgWVnq9SdxxVZKq3crJtUI=
X-Received: by 2002:a17:907:7f1f:b0:aab:a02c:764e with SMTP id
 a640c23a62f3a-ab6629c61c4mr311370866b.14.1737643077007; Thu, 23 Jan 2025
 06:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <2352334.ElGaqSPkdT@jernej-laptop> <20250119222530.1fd97018@minigeek.lan>
 <4622391.LvFx2qVVIh@jernej-laptop>
 <CAFLszTjDq4E05Q_esYA2tAGOYdhgbRp3B38gAsF0hX44Nf-34A@mail.gmail.com>
 <20250121000508.22db819a@minigeek.lan>
In-Reply-To: <20250121000508.22db819a@minigeek.lan>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:37:37 -0700
X-Gm-Features: AbW1kvbsJlKKxvNpkzDdpPJMO_K3dpWam2d03x2L94NeiNAqJvL3guVXg4jgBo0
Message-ID: <CAFLszTg95xH08bVt_LnVO=Gu+dEQh1+vNAszxQv5a6Rdt3u8WA@mail.gmail.com>
Subject: Re: [PATCH 2/8] sunxi: pmic_bus: support alternative I2C address
To: Andre Przywara <andre.przywara@arm.com>
Cc: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
 u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, linux-sunxi@lists.linux.dev, 
 Parthiban <parthiban@linumiz.com>
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

Hi Andre,

On Mon, 20 Jan 2025 at 17:06, Andre Przywara <andre.przywara@arm.com> wrote=
:
>
> On Mon, 20 Jan 2025 12:21:28 -0700
> Simon Glass <sjg@chromium.org> wrote:
>
> Hi Simon,
>
> > On Mon, 20 Jan 2025 at 09:42, Jernej =C5=A0krabec <jernej.skrabec@gmail=
.com> wrote:
> > >
> > > Dne nedelja, 19. januar 2025 ob 23:25:30 Srednjeevropski standardni =
=C4=8Das je Andre Przywara napisal(a):
> > > > On Sat, 18 Jan 2025 08:21:31 +0100
> > > > Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
> > > >
> > > > Hi Jernej,
> > > >
> > > > many thanks for the review and your opinion.
> > > >
> > > > > Dne petek, 17. januar 2025 ob 02:45:31 Srednjeevropski standardni=
 =C4=8Das je Andre Przywara napisal(a):
> > > > > > Some of the X-Power AXP PMICs can be ordered with an alternativ=
e I2C
> > > > > > address, for instance an AXP717 could be shipped with address 0=
x34 or
> > > > > > with address 0x35.
> > > > > > The datasheets for the AXP717 and AXP803 list two possible addr=
esses,
> > > > > > and they are always consecutive. For DM (DT) based drivers this=
 is no
> > > > > > problem, but the Allwinner SPL code relies on a hardcoded addre=
ss.
> > > > > >
> > > > > > Add a Kconfig variable that will add "1" to the existing addres=
s if it
> > > > > > is set.
> > > > > > This enables to use the AXP717 as used on boards with the new A=
llwinner
> > > > > > A523 chip.
> > > > > >
> > > > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > >
> > > > > This works until some board vendor start mixing one or another ad=
dress
> > > > > PMIC. Note that BSP boot0 does address autodetection, so it's not=
 entirely
> > > > > out of the question. Anyway, let's hope we don't see anything lik=
e that.
> > > >
> > > > I looked at the datasheets for all supported PMICs, and they either
> > > > state one or two supported addresses, in the latter case both
> > > > consecutive. Autodetection sounds nice, but also unnecessary: we su=
rely
> > > > know what address it is for a certain board? And with those A523 bo=
ards
> > > > having two PMICs, autodetection might become sketchy, as we don't k=
now
> > > > for sure which PMIC we got?
> > >
> > > Speaking for T527 BSP boot0 - they check version register to make sur=
e that
> > > correct PMIC is installed.
> > >
> > > >
> > > > But that got me thinking: what about putting the I2C address in Kco=
nfig
> > > > directly, with defaults depending on the PMIC type?
> > > >
> > > > config AXP_I2C_ADDR
> > > >       hex "AXP PMIC I2C address"
> > > >       depends on ARCH_SUNXI && !SUNXI_NO_PMIC
> > > >       default 0x36 if AXP305_POWER
> > > >       ....
> > > >
> > > > That's should work seamlessly for all supported PMICs, and we just =
need
> > > > one line for the Avaota, same as with this patch here.
> > > >
> > > > What do you think?
> > >
> > > Yeah, looks more universal and avoids code changes in pmic_bus.c when
> > > adding support for new AXP PMIC, which is very nice indeed.
> >
> > Shouldn't this be in the devicetree?
>
> It is, and the DM based I2C driver used in U-Boot proper does this
> properly, and works fine. But this here is for the SPL, where we don't
> have DT support. We need just minimal support to adjust the regulator
> for the DRAMs. So far there is one fixed address used by each PMIC, so
> this is simply hardcoded, based on which PMIC is selected. The patch I
> am now proposing (snippet above) just moves that hardcoding into
> Kconfig.

I suppose you could use of-platdata?

Regards,
SImon
