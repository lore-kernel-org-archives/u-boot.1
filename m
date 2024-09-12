Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED87EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3F4388EA6;
	Thu, 12 Sep 2024 03:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kzgWuocC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF7988DCD; Thu, 12 Sep 2024 03:01:11 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B13D88DCF
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71798661a52so290836b3a.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102868; x=1726707668; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t5LnUs+3E25GlONNtCSTzMe04eZa+40fJGqgIpkNx7U=;
 b=kzgWuocC4IbPevLwIX/P57Tm/B9XJZJxPIXA5Zg1ChsPkL64D+Fcc0JWOpnYoy27kr
 Y44Ryg8yhggGBbIS5L3hd3N4sUxZ9tFYPYLaRg0sdFkQc5U2HH/7iQ8Koph1HwK4Uiqn
 cGTLCU7w4SdIPjyo2G9vh8CFgp8jqQUMqWksU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102868; x=1726707668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t5LnUs+3E25GlONNtCSTzMe04eZa+40fJGqgIpkNx7U=;
 b=N8pnVzp6bG26SYdnC8HARzbWBOXiLRxEVFWLVY9KIZWGQ8v/h3crI9D52JJbGeGfVt
 GXYhWy9ZOhE/efAwtShp/vdC2l3YRQOQJmiNnfZaneAGBYzRsD47419tHkOC9HXzDFBe
 n9RvmBuJb6+F7pw+zjVqToHQrExBefbrNGdisSZajqTUJEAZYnzd+1+UvaZRb4CnO5rK
 wiws3qMyenCRAs9PLDEVeDXgj7INROgI5JDox2dYMc332G0i/xTHG/y6mFmf4v1kkFg6
 iQ/688dTNh157z5XOzP2GUXtIheMUL7c8DU0mTSrXIfHJxvHr0ZbVMmKvxAYAtspUeJ+
 FrKQ==
X-Gm-Message-State: AOJu0YzFAeiBXRQBmMH1XYhZBVnkgyRynUcV4vdNNRNooQE194+FIRU7
 eXvxh4tY3lEi0ptEkUjpdju232kVv0Or4lkARdn4JOHz26dIt9/g9Zkkx9vmHZ+WsucnO9lF28r
 7awWqw8nKbajyGIRkpI1ualVb5ivt+q4/Zz1O
X-Google-Smtp-Source: AGHT+IGayIgO2cDB67qAr/r9Qm3MVp5BQGGEHNZGej4dF4Fh8qVqB5M2/R/eJKiw84ELwE+iwxDn0k2KG+AheTH83/E=
X-Received: by 2002:a05:6a00:8985:b0:718:dda3:d7fe with SMTP id
 d2e1a72fcca58-71907f718c9mr11800099b3a.12.1726102867602; Wed, 11 Sep 2024
 18:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
In-Reply-To: <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:00:56 -0600
Message-ID: <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 12 Sep 2024 03:02:52 +0200
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

Hi Marek,

On Fri, 28 Jun 2024 at 07:26, Marek Vasut <marex@denx.de> wrote:
>
> On 6/28/24 9:32 AM, Simon Glass wrote:
> > Hi Marek,
>
> Hi,
>
> [...]
>
> >>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
> >>>>                                                   -ENODATA);
> >>>>           uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
> >>>>                                                   -ENODATA);
> >>>> -       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> >>>> -       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
> >>>>           uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
> >>>>                                                       0);
> >>>>           uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>> This is reading a lot of DT stuff very early, which may be slow. It is
> >>> also reading from the DT in the bind() step which we sometimes have to
> >>> do, but try to avoid.
> >>
> >> Actually, it is reading only the bare minimum very early in bind, the
> >> always-on and boot-on, the rest is in pre_probe, i.e. later.
> >
> > Yes, I see that. Also it is inevitable that these properties need to
> > be read before probe(), since they control whether to probe().
> >
> >>
> >>> Also this seems to happen in SPL and again pre-reloc and again in
> >>> U-Boot post-reloc?
> >>
> >> What does, the uclass post_bind ?
> >
> > I mean that this code will be called in SPL (if the regulators are in
> > the DT there), U-Boot pre-reloc and post-reloc, each time turning on
> > the regulators. We need a way to control that, don't we?
>
> I would assume that if those regulators are turned on once in the
> earliest stage , turning them on again in the follow up stage would be a
> noop ? This is the point of regulator-*-on, to keep the regulators on.

No, there is sometimes a particular sequence needed.

>
> >>> Should we have a step in the init sequence where we set up the
> >>> regulators, by calling regulators_enable_boot_on() ?
> >>
> >> Let's not do this , the entire point of this series is to get rid of
> >> those functions and do the regulator configuration the same way LED
> >> subsystem does it -- by probing always-on/boot-on regulators and
> >> configuring them correctly on probe.
> >>
> >> To me regulators_enable_boot_on() and the like was always an
> >> inconsistently applied workaround for missing DM_FLAG_PROBE_AFTER_BIND ,
> >> which is now implemented, so such workarounds can be removed.
> >
> > That patch seemed to slip under the radar, sent and applied on the
> > same day! We really need to add a test for it, BTW.
>
> Which patch ? My recollection of DM_FLAG_PROBE_AFTER_BIND was that it
> took a while to get in.

[1]

>
> > My concern is that this might cause us ordering problems. We perhaps
> > want the regulators to be done first. If drivers are probed which use
> > regulators, then presumably they will enable them. Consider this:
> >
> > - LED driver auto-probes
> >     - probes I2C bus 2
> >     - probes LDO1 which is autoset so turns on
> > - LDO1 probes, but is already running
> > - LDO2 probes, which is autoset so turns on
> >
> > So long as it is OK to enable the regulators in any order, then this
> > seems fine. But is it? How do we handle the case where are particular
> > sequence is needed?
>
> Did we finally arrive at the point where we need -EPROBE_DEFER alike
> mechanism ?

Nope. But I am concerned that this patch is leading us there. bind()
really needs to be as clean as possible. It is one of the design
elements of driver model which Linux should adopt.

There is always a race to be the first to init something, move the
init earlier, etc... I don't see any general need to init the
regulators right at the start. It should be done in a separate
function and be optional. I am happy to send a patch if you like.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20220422131555.123598-1-marex@denx.de/
