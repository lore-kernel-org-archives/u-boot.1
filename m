Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A035EC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 18:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CFBC87F69;
	Mon, 19 Feb 2024 19:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ldB0dHO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474A487F63; Mon, 19 Feb 2024 19:33:25 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0FE087DEB
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 19:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-59d78deb469so2959069eaf.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1708367575; x=1708972375;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvNPwkbblPXfY0RHMIbafQ2c4kOdJgIIVIfpVB0GVxc=;
 b=ldB0dHO/5D7qML+WHb4y2uqstdE8+hfH71aFloAdBVSV88hJ8f3YuZy7u5LvuiUP7I
 cC9privvkbCW1+5eZw9fTYrVYwys5m5SlIESGrjU/q7BS50PdnbRzCGHYd/hmDW7loeS
 pGNloQa9pkdnxEXcZyu4F5/bJaGZDW7iw2i7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708367575; x=1708972375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvNPwkbblPXfY0RHMIbafQ2c4kOdJgIIVIfpVB0GVxc=;
 b=p5fJTQDWXWnr1v+RpMIy8Po3UJyk7974/Qgd5CvONDP9h1CRkxQdrzRy4JjMowgAi2
 f+S0UKe1/IQpOnNtHJwfEAV3T+h0v0tHLwc33bj0A05zwe+bsGz77Mc1K+57lCnSNyLQ
 KtbE8dNpYWzYyjq6tUPHIl6VeTquV8wpzuj/zTXLYlhqvFa6y/2qkGfsBVjb8FafW7oi
 +6NnKoZmP1rbpHSPwkMpk4criBCHwNoKlherZmS8+S990ZapU5MsuCCak3ImmWYXHpao
 qcP5K6klm9dzr8kBAi5mcV4nbgmq+W+tMvUiyYu1hI4Do6GuknO8s9tCQYLaxwvWdTHg
 +45A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrDu9nOZlb3ZFFC8YF1Sba/SeCYE3vgg4Cs16Trs6ekW3zMWXpZJh9RxT76/gU1dDu61EQRfE1UPMlZD85ZjRGmChX/g==
X-Gm-Message-State: AOJu0Yy+EHXKbct8hY85IsM2pMpqOBBZ9jg8ubV5vhU7POI10symnqPu
 DNXIE5IulvhSilNAuXj435uAs4YO2rOvAcM3BS46mRnaB8KKuQRBnR4hyLxeYEAg/c0NqjaF9ea
 UTR4daVvbDkxMiz1D/x5R006t83rA3F0pFg8o6g==
X-Google-Smtp-Source: AGHT+IFV9YXiAdxWxyHln1qtXQNqg7m5dg5eyS1vfJm0UjhG5EWyHC7ms/0iZIskLREFIfupeQe5/2rS4eGvKRpSF60=
X-Received: by 2002:a05:6359:4c03:b0:17b:4a67:4e80 with SMTP id
 kj3-20020a0563594c0300b0017b4a674e80mr1579182rwc.11.1708367575598; Mon, 19
 Feb 2024 10:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
 <20240117075154.58747-15-jagan@amarulasolutions.com>
 <8facae6f-425b-4389-a826-8269eef92aa3@kwiboo.se>
In-Reply-To: <8facae6f-425b-4389-a826-8269eef92aa3@kwiboo.se>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 20 Feb 2024 00:02:44 +0530
Message-ID: <CAMty3ZCdyW-bPG4gdz=hAaJyxBS4aKh_VRmaFTDMA0wTAk7q9w@mail.gmail.com>
Subject: Re: [PATCH v3 14/17] ARM: dts: rk3328: Enable VOP for bootph-all
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, 
 Robin Murphy <robin.murphy@arm.com>, Da Xue <da.xue@libretech.co>,
 u-boot@lists.denx.de
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

Hi Jonas,

On Mon, Feb 19, 2024 at 10:51=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wr=
ote:
>
> Hi Jagan,
>
> On 2024-01-17 08:51, Jagan Teki wrote:
> > Model: Firefly roc-rk3328-cc
> > DRAM: 1 GiB (effective 1022 MiB)
> > Video device 'vop@ff370000' cannot allocate frame buffer memory -ensure=
 the device is set up before relocation
> > Error binding driver 'rockchip_rk3328_vop': -28
> > Some drivers failed to bind
> > initcall sequence 000000003ffcd5e8 failed at call 000000000021a5c4 (err=
=3D-28)
> >  ### ERROR ### Please RESET the board ###
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3, v2:
> > - none
> >
> >  arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-bo=
ot.dtsi
> > index a9f2536de2..5258fec566 100644
> > --- a/arch/arm/dts/rk3328-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> > @@ -68,3 +68,7 @@
> >  &spi0 {
> >       bootph-all;
> >  };
> > +
> > +&vop {
> > +     bootph-all;
>
> bootph-some-ram is better, TPL or SPL does not need or use the vop node.
>
> I am working on a cleanup series for rk3399 and that series will include
> a change from bootph-all to bootph-some-ram of vop nodes on rk3399.

Sure, we can even update the same later as these were in the ML from
months ago. I will mark them as well.

Jagan.
