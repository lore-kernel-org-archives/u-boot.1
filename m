Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84CEC3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 13:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78724885A3;
	Fri, 28 Jun 2024 15:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lxJ7CIdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA29885B3; Fri, 28 Jun 2024 09:33:05 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3080487E3F
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 09:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4463682e944so2094921cf.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719559982; x=1720164782; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KRuwi8DrHNH9PM7BQRvaS+69U0hYrnjGzRWy+oNkAKQ=;
 b=lxJ7CIdG2uVHkzxpgsE6Au6RBBDsm7l78w3ftiGjqexTO2NR8eXFDAPbVObJllJXvk
 XTx12oFjJ3Nm4aZ2b9F/tLCydhRxfo1lBCk9O2WO7GEqdFmclJnwmDqW0RlU71UdG5TP
 USmgX60it2+HXozg2+vn/0zKde8PqUzzw9m64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719559982; x=1720164782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KRuwi8DrHNH9PM7BQRvaS+69U0hYrnjGzRWy+oNkAKQ=;
 b=asjn9RS5+SLiIRRXZdhh2G8t/8O34jgtdEyk9zZAb1/iYLnoBe4b8eHV8QQpdVbIDf
 0guLedgexTZrHTZY6XdXwmE39tbBdtfaK/i1j/DoqwoXFgiOA6A3MfI7v5PTxgH0YZdE
 zFXb8F4B3riZNFRj/5iPMluTtqArJGFhBpQLCzA6GXsFve+BvqI6910zZz3avNGSQfDq
 6sT7pDp+yL53yv7HC8HRohgPbh0vOcVUjMwVP8pJCkP57mqONc06baBoXbikAAdqtCSm
 NZJ8urzKdXYKr/P/M11gNPuDbb3t++w2FSaRSkSE0Uyu5xV2jlgCO7xPTjS01O5J/qqE
 4H0g==
X-Gm-Message-State: AOJu0YzUHlyP6Jb9AtdMo+5smND4Le3c81eePrdwuTDdvuUZDL6X4dMy
 bSR+q5Yzh2jq+5ehwxzZkLa9TYAuTnnStTezoCKzZG+940pLgMHC1Dsq5bDv4Hl+YPqX/TJVXRm
 0YFMF4VS7tg5dxbsie3qKjG/1T2x7gQWnhn2I
X-Google-Smtp-Source: AGHT+IFvHS8F/jJHGPcQ4bZNB2icCP5fYXZEuEoijfxibR04ttx09THt4jWsZqzbSXConhwlFpuOZxRCLKW5++dpdpA=
X-Received: by 2002:a05:6214:2464:b0:6b5:88:7cc8 with SMTP id
 6a1803df08f44-6b54099e969mr225534066d6.7.1719559982078; Fri, 28 Jun 2024
 00:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
In-Reply-To: <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Jun 2024 08:32:50 +0100
Message-ID: <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
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
X-Mailman-Approved-At: Fri, 28 Jun 2024 15:00:50 +0200
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

On Thu, 27 Jun 2024 at 17:05, Marek Vasut <marex@denx.de> wrote:
>
> On 6/27/24 10:37 AM, Simon Glass wrote:
> > Hi Marek,
>
> Hi,
>
> [...]
>
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
> Actually, it is reading only the bare minimum very early in bind, the
> always-on and boot-on, the rest is in pre_probe, i.e. later.

Yes, I see that. Also it is inevitable that these properties need to
be read before probe(), since they control whether to probe().

>
> > Also this seems to happen in SPL and again pre-reloc and again in
> > U-Boot post-reloc?
>
> What does, the uclass post_bind ?

I mean that this code will be called in SPL (if the regulators are in
the DT there), U-Boot pre-reloc and post-reloc, each time turning on
the regulators. We need a way to control that, don't we?

>
> > Should we have a step in the init sequence where we set up the
> > regulators, by calling regulators_enable_boot_on() ?
>
> Let's not do this , the entire point of this series is to get rid of
> those functions and do the regulator configuration the same way LED
> subsystem does it -- by probing always-on/boot-on regulators and
> configuring them correctly on probe.
>
> To me regulators_enable_boot_on() and the like was always an
> inconsistently applied workaround for missing DM_FLAG_PROBE_AFTER_BIND ,
> which is now implemented, so such workarounds can be removed.

That patch seemed to slip under the radar, sent and applied on the
same day! We really need to add a test for it, BTW.

My concern is that this might cause us ordering problems. We perhaps
want the regulators to be done first. If drivers are probed which use
regulators, then presumably they will enable them. Consider this:

- LED driver auto-probes
   - probes I2C bus 2
   - probes LDO1 which is autoset so turns on
- LDO1 probes, but is already running
- LDO2 probes, which is autoset so turns on

So long as it is OK to enable the regulators in any order, then this
seems fine. But is it? How do we handle the case where are particular
sequence is needed?

Regards,
Simon
