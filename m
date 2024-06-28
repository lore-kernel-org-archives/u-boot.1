Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C06C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 13:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D744E885B5;
	Fri, 28 Jun 2024 15:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b1ZfQWpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4409B88027; Fri, 28 Jun 2024 09:33:07 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB10E8824A
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 09:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b56000f663so1564816d6.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719559983; x=1720164783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xOSKQsLRJGtNc9JM/GkjrdFacTmorGHY93zI8W//jw0=;
 b=b1ZfQWpIphhyBUQiuoFSSVivDBYyIdfe9fGLuiW0lmssvqS5AIVCFJHxGjzIkVW3uw
 hrPoeQAm2rflt2u7zEZoTQCrGTF6P5orMK8QCss2qIjL8EK4NU3JwVzgK1T1IeOZYJfG
 Qy5zzgqLmPBhw2hJvJozr8hqF83SLupUpJFYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719559983; x=1720164783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xOSKQsLRJGtNc9JM/GkjrdFacTmorGHY93zI8W//jw0=;
 b=V9zKmiNnQ0MSa8bjtdEyl0Dzpv3LxuxQ3E6YKSKvwTAl0kjiDsQdVgt4zNsGLx64U+
 2JJe4Js3Y2QE+Zorof1K+4oiSs6s2JsV750U0LcM+mEIRJFw2f4FNo5S506uFUXO/c03
 UVrhdGO5/AtqLUcQlmDB1u75W2fovXD4rVufDcWV/9Wh4NvTyA10QNPRXmOaHGwl6g6s
 5X+87e/L5LWCbgrmmiJ7YJrYS90OeCqH5JLsKCpksND/+QXaFnUcKEUUUxuCy7OOlojx
 bzpw6aq4V7XJFhoitWSwzc54CW50wX/y1JHQELt4ViNnhSS3cOjjIk2NQXYsHSoj9l1V
 oflQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF0d3OVyelZh8TA3iA6GY45/3w2tK9kedq6hpVIU/mmkZYdeeMgAE/NRDsg+q3wLuMmu5OIhzwL6Sh45Wa1M/5L4v0sw==
X-Gm-Message-State: AOJu0Ywi+iX1W9K6EiHrKxyf6oQiV1UIyPmL2ny0eIf+sbpX501bZom+
 yJcRyO6JGLouR7mK4nVYa1U+F9sPhQlR7CBdMuJajh9zOyoQ0Y//5R0bx/dLEc5yyuHpRZaCswD
 E3ndexx0+WmBr1ByXFciPQYUmD59hUyeb3cui
X-Google-Smtp-Source: AGHT+IFV/DgwFMjbibDzyUC5pb/VenCj6Ixf9HGX5T/Q4h61Vk9JrQnQk07O5g2L5HX/amlW+6XJs3yiPXjLlD9nv38=
X-Received: by 2002:ad4:5d4b:0:b0:6b5:9375:97bc with SMTP id
 6a1803df08f44-6b593759c8bmr65916616d6.43.1719559983707; Fri, 28 Jun 2024
 00:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
 <CAFLszTijRhB1dRraPBQSTU3ypJ_wJU7yghJ9c9Rk-XcbcfvkFg@mail.gmail.com>
 <38150a1b-6c71-4b42-a8ec-6b0de8ad6848@linaro.org>
In-Reply-To: <38150a1b-6c71-4b42-a8ec-6b0de8ad6848@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Jun 2024 08:32:52 +0100
Message-ID: <CAFLszTg078XuQ5WxUVvMktA95zZm+PHs+MtVu2eL-xZYYkHxFA@mail.gmail.com>
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

Hi Caleb,

On Fri, 28 Jun 2024 at 01:09, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 27/06/2024 11:26, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Thu, 27 Jun 2024 at 09:48, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >>
> >>
> >> On 27/06/2024 10:37, Simon Glass wrote:
> >>> Hi Marek,
> >>>
> >>> On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> In case a regulator DT node contains regulator-always-on or regulator-boot-on
> >>>> property, make sure the regulator gets correctly configured by U-Boot on start
> >>>> up. Unconditionally probe such regulator drivers. This is a preparatory patch
> >>>> for introduction of .regulator_post_probe() which would trigger the regulator
> >>>> configuration.
> >>>>
> >>>> Parsing of regulator-always-on and regulator-boot-on DT property has been
> >>>> moved to regulator_post_bind() as the information is required early, the
> >>>> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
> >>>> slowing down the boot process.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>> ---
> >>>> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> >>>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> >>>> Cc: Chris Morgan <macromorgan@hotmail.com>
> >>>> Cc: Dragan Simic <dsimic@manjaro.org>
> >>>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> >>>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> >>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> >>>> Cc: Jagan Teki <jagan@amarulasolutions.com>
> >>>> Cc: Jonas Karlman <jonas@kwiboo.se>
> >>>> Cc: Kever Yang <kever.yang@rock-chips.com>
> >>>> Cc: Kostya Porotchkin <kostap@marvell.com>
> >>>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> >>>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >>>> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> >>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> >>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> >>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >>>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> >>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> >>>> Cc: Sam Day <me@samcday.com>
> >>>> Cc: Simon Glass <sjg@chromium.org>
> >>>> Cc: Sumit Garg <sumit.garg@linaro.org>
> >>>> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> >>>> Cc: Thierry Reding <treding@nvidia.com>
> >>>> Cc: Tom Rini <trini@konsulko.com>
> >>>> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> >>>> Cc: u-boot-amlogic@groups.io
> >>>> Cc: u-boot-qcom@groups.io
> >>>> Cc: u-boot@dh-electronics.com
> >>>> Cc: u-boot@lists.denx.de
> >>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
> >>>> ---
> >>>>    drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
> >>>>    1 file changed, 15 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> >>>> index 66fd531da04..ccc4ef33d83 100644
> >>>> --- a/drivers/power/regulator/regulator-uclass.c
> >>>> +++ b/drivers/power/regulator/regulator-uclass.c
> >>>> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
> >>>>           const char *property = "regulator-name";
> >>>>
> >>>>           uc_pdata = dev_get_uclass_plat(dev);
> >>>> +       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> >>>> +       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
> >>>>
> >>>>           /* Regulator's mandatory constraint */
> >>>>           uc_pdata->name = dev_read_string(dev, property);
> >>>> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *dev)
> >>>>                           return -EINVAL;
> >>>>           }
> >>>>
> >>>> -       if (regulator_name_is_unique(dev, uc_pdata->name))
> >>>> -               return 0;
> >>>> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> >>>> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> >>>> +                     property, dev->name, uc_pdata->name);
> >>>> +               return -EINVAL;
> >>>> +       }
> >>>>
> >>>> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> >>>> -             property, dev->name, uc_pdata->name);
> >>>> +       /*
> >>>> +        * In case the regulator has regulator-always-on or
> >>>> +        * regulator-boot-on DT property, trigger probe() to
> >>>> +        * configure its default state during startup.
> >>>> +        */
> >>>> +       if (uc_pdata->always_on && uc_pdata->boot_on)
> >>>> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> >>>>
> >>>> -       return -EINVAL;
> >>>> +       return 0;
> >>>>    }
> >>>>
> >>>>    static int regulator_pre_probe(struct udevice *dev)
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
> >> Could we set up the livetree pre-bind? What about MMU? On armv8 at least
> >> this would have a huge impact on performance. I've done some
> >> measurements and there is at least 1 order of magnitude difference
> >> between parsing FDT with no caches vs parsing livetree with, it's huge.
> >
> > That seems like a great idea to me, in general. The fact that SPL sets
> > up the MMU on armv8 makes it more practical.
>
> Well, on qcom we don't use SPL (yet?), we did have a cyclical dependency
> since we rely on DTB for the memory layout, although I have some patches
> to do all the memory parsing in board_fdt_blob_setup() since that's
> needed for multi-dtb FIT. So I guess we could enable caches at the same
> time.

Yes...it seems that enabling cache in SPL has become common on armv8.

As to the memory layout, I'm not sure what is happening there, but it
seems that the DT does not describe it in general (at least not until
U-Boot adds the nodes).

> >
> > But for this series I believe we are going to have to define what
> > happens in what phase. We have power_init_board() which is the old way
> > of doing this...but perhaps we could use that as a way to start up
> > regulators which are needed.
> >
> > As to my question about whether this happens in SPL / pre-reloc /
> > proper, I forgot that we have the bootph tags for that, so it should
> > be fine. The main issue is that in U-Boot proper we will re-init the
> > regulators even though that has already been done. Probably that can
> > be handled by Kconfig or a flag in SPL handoff.
>
> Ensuring that it isn't done multiple times sounds like the right
> approach to me.

OK...I wonder how we can solve this. Needs some though.


> >
> >
> >>>
> >>> Also this seems to happen in SPL and again pre-reloc and again in
> >>> U-Boot post-reloc?
> >>>
> >>> Should we have a step in the init sequence where we set up the
> >>> regulators, by calling regulators_enable_boot_on() ?

Regards,
Simon
