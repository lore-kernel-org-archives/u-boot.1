Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7BCC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4027F8859A;
	Thu, 27 Jun 2024 13:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m/WZktci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFA7884F6; Thu, 27 Jun 2024 11:26:42 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F06968826B
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b4f7541d7eso35456426d6.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719480399; x=1720085199; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9HCQkxbz7QGTuVs+o2YIyzQ/LTHw4GzWIaZg3+8jgw0=;
 b=m/WZktci53UdXlXS2QcpcmDNCBVZP1ofHeoVcUAoBRBkT+JPTTAGoEOO9dlvqyGLhi
 VDdW6E87Od1+A1MbPaiSNwEVqLDaeWl8kv1CoC+CxlrlbOH5wOgQfcjYvwIKe8yggL//
 9ta721GOVBOMMCk4wlIzIy22quaVudiuNP0R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719480399; x=1720085199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9HCQkxbz7QGTuVs+o2YIyzQ/LTHw4GzWIaZg3+8jgw0=;
 b=rhJ9CP8HGlXzON/dsHWSPau4Dnm9cklVlu8arLQBvq5YvK6Ty0MH2KJ0eozTIQxqG2
 Gwfbfhw8dNhQyA//AbOxsyBxDIHDdLYGWsh3VysJggloN2dv8KXANBBLL8i4X+CWVa6V
 SG3YtdNKPksehgU6sFHgtErNjJQzgSfrpjodK1rNst2nX1NRWyvGFURBMZYp+K95/SlA
 LwK9+WxDIWZYCUvm0tQ1Yr70WlUJvDAjVelhFv5udqFOdITfKuWIDnA/g/MajZPhtcev
 3JkMF/il8cljzYiK7i9GqwhICv5rvW5u+k70xPHuGhW5khl5DTqttHv0AS78MWumX2Vj
 CGsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbvRoEmaGlBn3cbKCQZF1XvG1+I+Hrxmyl0X+5U1cbA23ZvYBbmV7K3Kv7g5Njn6b2u79m+YsPUlUfHe6dU//t3w+4Sw==
X-Gm-Message-State: AOJu0Yw0TafY23Z4v1xhhKnY3sF2OVlMwPaLnVZmPS95HK7ckRJB0xcE
 kSrjwuK6zgf578QS+JmIMyuU+iU2503ICc/6sVVsCMfWBEvKleuff0NnmNEWSchv4vVtxGNi0Ay
 1hXm6iOAw1H3fShqiBXNF4JY9v/BfIxlke/zI
X-Google-Smtp-Source: AGHT+IHjx8SlRRp5BuJIRV9LstlKWiXSSP60Vh8E7gab5ZtYSS89FtvFekbEHCF0KzVqKnCyoEl60+T6MbaZsk28Bfw=
X-Received: by 2002:a05:6214:5ed4:b0:6b2:d51c:f5b3 with SMTP id
 6a1803df08f44-6b58d36d1eamr23880166d6.18.1719480398847; Thu, 27 Jun 2024
 02:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
In-Reply-To: <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 10:26:28 +0100
Message-ID: <CAFLszTijRhB1dRraPBQSTU3ypJ_wJU7yghJ9c9Rk-XcbcfvkFg@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Ben Wolsieffer <benwolsieffer@gmail.com>,
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
X-Mailman-Approved-At: Thu, 27 Jun 2024 13:09:53 +0200
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

Hi Caleb,

On Thu, 27 Jun 2024 at 09:48, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 27/06/2024 10:37, Simon Glass wrote:
> > Hi Marek,
> >
> > On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
> >>
> >> In case a regulator DT node contains regulator-always-on or regulator-boot-on
> >> property, make sure the regulator gets correctly configured by U-Boot on start
> >> up. Unconditionally probe such regulator drivers. This is a preparatory patch
> >> for introduction of .regulator_post_probe() which would trigger the regulator
> >> configuration.
> >>
> >> Parsing of regulator-always-on and regulator-boot-on DT property has been
> >> moved to regulator_post_bind() as the information is required early, the
> >> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
> >> slowing down the boot process.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> ---
> >> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> >> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> >> Cc: Chris Morgan <macromorgan@hotmail.com>
> >> Cc: Dragan Simic <dsimic@manjaro.org>
> >> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> >> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> >> Cc: Jagan Teki <jagan@amarulasolutions.com>
> >> Cc: Jonas Karlman <jonas@kwiboo.se>
> >> Cc: Kever Yang <kever.yang@rock-chips.com>
> >> Cc: Kostya Porotchkin <kostap@marvell.com>
> >> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> >> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> >> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> >> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> >> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> >> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> >> Cc: Sam Day <me@samcday.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Sumit Garg <sumit.garg@linaro.org>
> >> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> >> Cc: Thierry Reding <treding@nvidia.com>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> >> Cc: u-boot-amlogic@groups.io
> >> Cc: u-boot-qcom@groups.io
> >> Cc: u-boot@dh-electronics.com
> >> Cc: u-boot@lists.denx.de
> >> Cc: uboot-stm32@st-md-mailman.stormreply.com
> >> ---
> >>   drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
> >>   1 file changed, 15 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> >> index 66fd531da04..ccc4ef33d83 100644
> >> --- a/drivers/power/regulator/regulator-uclass.c
> >> +++ b/drivers/power/regulator/regulator-uclass.c
> >> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
> >>          const char *property = "regulator-name";
> >>
> >>          uc_pdata = dev_get_uclass_plat(dev);
> >> +       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> >> +       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
> >>
> >>          /* Regulator's mandatory constraint */
> >>          uc_pdata->name = dev_read_string(dev, property);
> >> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *dev)
> >>                          return -EINVAL;
> >>          }
> >>
> >> -       if (regulator_name_is_unique(dev, uc_pdata->name))
> >> -               return 0;
> >> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> >> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> >> +                     property, dev->name, uc_pdata->name);
> >> +               return -EINVAL;
> >> +       }
> >>
> >> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> >> -             property, dev->name, uc_pdata->name);
> >> +       /*
> >> +        * In case the regulator has regulator-always-on or
> >> +        * regulator-boot-on DT property, trigger probe() to
> >> +        * configure its default state during startup.
> >> +        */
> >> +       if (uc_pdata->always_on && uc_pdata->boot_on)
> >> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> >>
> >> -       return -EINVAL;
> >> +       return 0;
> >>   }
> >>
> >>   static int regulator_pre_probe(struct udevice *dev)
> >> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
> >>                                                  -ENODATA);
> >>          uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
> >>                                                  -ENODATA);
> >> -       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> >> -       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
> >>          uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
> >>                                                      0);
> >>          uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
> >> --
> >> 2.43.0
> >>
> >
> > This is reading a lot of DT stuff very early, which may be slow. It is
> > also reading from the DT in the bind() step which we sometimes have to
> > do, but try to avoid.
>
> Could we set up the livetree pre-bind? What about MMU? On armv8 at least
> this would have a huge impact on performance. I've done some
> measurements and there is at least 1 order of magnitude difference
> between parsing FDT with no caches vs parsing livetree with, it's huge.

That seems like a great idea to me, in general. The fact that SPL sets
up the MMU on armv8 makes it more practical.

But for this series I believe we are going to have to define what
happens in what phase. We have power_init_board() which is the old way
of doing this...but perhaps we could use that as a way to start up
regulators which are needed.

As to my question about whether this happens in SPL / pre-reloc /
proper, I forgot that we have the bootph tags for that, so it should
be fine. The main issue is that in U-Boot proper we will re-init the
regulators even though that has already been done. Probably that can
be handled by Kconfig or a flag in SPL handoff.


> >
> > Also this seems to happen in SPL and again pre-reloc and again in
> > U-Boot post-reloc?
> >
> > Should we have a step in the init sequence where we set up the
> > regulators, by calling regulators_enable_boot_on() ?

Regards,
Simon
