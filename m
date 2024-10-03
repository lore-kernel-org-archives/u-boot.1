Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C7BCF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2248A88DD4;
	Thu,  3 Oct 2024 17:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WHk79nnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D98F88E19; Thu,  3 Oct 2024 17:03:37 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 872C388D9F
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb399056b4so8741946d6.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727967813; x=1728572613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xck8TEVEakZw6XXAH4TtRZLZvmFsSi/9xxxJWDIcIoc=;
 b=WHk79nnmRY7uauhEKW6FaJWJu1hy2JPTsOvrWX7YJd48izduzYz+omkQ9tTxxbnoug
 9Bqdtof30hPq3jknYLJTQhG7zKUHxj7YwDU0gNABlO2V8T9I/7q3Zp5DSZrAuhMQ6po1
 6jhvgwFqvviwOCJpOc7uo3wQFFB5vz9O81q14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727967813; x=1728572613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xck8TEVEakZw6XXAH4TtRZLZvmFsSi/9xxxJWDIcIoc=;
 b=sYdXKqaFyOIeIhwdMZAFtdkuqtNVRfV+LNfWzOW1xGjwPYXGlFd2uyUlQzS2WJ0qwp
 +ktzX1v3hw7YGXhwIFhm4LCFuKBiZkyj1IPWBJm1eVVF4ObIbZAj20cwUvv7DSBvKCx5
 JDdzBqQgPUUaVEon5VbaInWwOftoTfMwcPVmT3Ae0RodmPcXDy1BEcAcegh7PcwZ61K1
 f0EgWZqAAKlwCdEbDEX8xR+PPVC1RjkHsQlzW904CxdBRJX9oQartqbCBfnANT8V+trm
 AaLM7BA2y+wKQT16kW43s09/35uv+31euXyGNSm2n+2IDR2lHg1C56jnNebayW8PvF47
 8UFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsZa6KePt/LeUICjYZbQIPC3Q5lkfHltnJuN0cEng1e8HF7iMZtcb1bgXiMxBcKskTcraF1Pw=@lists.denx.de
X-Gm-Message-State: AOJu0YwLimaT+G6+fGnkj2Q+3N+XGfn1DkDECVZTIadRsfJ7ZeodKv9J
 nnctdhPNr75akaxK4+pu0X8EGOCXHm2mVs4fvqLKWwNRi1lu1HBu7KRTLi4RLoIypU53LmVNyN7
 DSqMex0OIRqpH9K9m8SBlGq0YwEka/+e3LuzC
X-Google-Smtp-Source: AGHT+IE+QRyARsoRaCYB6tQNlecqHjTlfcP+Kyk2IVOCMvrFm2dsTBn0aeztCGJwaKxtmnUs1c3RSifNTFmc7W2Smm4=
X-Received: by 2002:a05:6214:4890:b0:6b5:e2d9:cfb9 with SMTP id
 6a1803df08f44-6cb81b990bfmr103600146d6.39.1727967813377; Thu, 03 Oct 2024
 08:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240926231457.2933914-1-marex@denx.de>
 <20240926231457.2933914-2-marex@denx.de>
 <CAFLszThbZ5t+siC0Gz_7KaecTTwUA6J2uTdtHEaYoK+V6Rm_7A@mail.gmail.com>
 <20241003014042.GS4737@bill-the-cat>
In-Reply-To: <20241003014042.GS4737@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Oct 2024 09:03:22 -0600
Message-ID: <CAFLszTiawdOfoMx-ZmMLW77dBS11WWVpWHNF-KfPi86xEJB+rQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] power: regulator: Convert
 regulators_enable_boot_on/off() to regulator_post_probe
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thierry Reding <treding@nvidia.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 2 Oct 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 02, 2024 at 04:55:39PM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Thu, 26 Sept 2024 at 17:15, Marek Vasut <marex@denx.de> wrote:
> > >
> > > Turn regulators_enable_boot_on() and regulators_enable_boot_off() into
> > > empty functions. Implement matching functionality in regulator_post_probe()
> > > instead. The regulator_post_probe() is called for all regulators after they
> > > probe, and regulators that have regulator-always-on or regulator-boot-on DT
> > > properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being set on
> > > such regulators in regulator_post_bind().
> > >
> > > Finally, fold regulator_unset() functionality into regulator_autoset().
> > >
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> > > Cc: Caleb Connolly <caleb.connolly@linaro.org>
> > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > Cc: Dragan Simic <dsimic@manjaro.org>
> > > Cc: Eugen Hristev <eugen.hristev@collabora.com>
> > > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > > Cc: Jagan Teki <jagan@amarulasolutions.com>
> > > Cc: Jonas Karlman <jonas@kwiboo.se>
> > > Cc: Kever Yang <kever.yang@rock-chips.com>
> > > Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > > Cc: Max Krummenacher <max.krummenacher@toradex.com>
> > > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > > Cc: Sam Day <me@samcday.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Cc: Thierry Reding <treding@nvidia.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> > > Cc: u-boot-amlogic@groups.io
> > > Cc: u-boot-qcom@groups.io
> > > Cc: u-boot@dh-electronics.com
> > > Cc: u-boot@lists.denx.de
> > > Cc: uboot-stm32@st-md-mailman.stormreply.com
> > > ---
> > > V2: Rebase on current u-boot/next
> > > V3: No change
> > > ---
> > >  drivers/power/regulator/regulator-uclass.c | 60 +++++++---------------
> > >  1 file changed, 19 insertions(+), 41 deletions(-)
> > >
> > > diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> > > index 1a970004540..9fcc4bd85b9 100644
> > > --- a/drivers/power/regulator/regulator-uclass.c
> > > +++ b/drivers/power/regulator/regulator-uclass.c
> > > @@ -314,6 +314,11 @@ int regulator_autoset(struct udevice *dev)
> > >                         return ret;
> > >         }
> > >
> > > +       if (uc_pdata->force_off) {
> > > +               ret = regulator_set_enable(dev, false);
> > > +               goto out;
> > > +       }
> > > +
> > >         if (!uc_pdata->always_on && !uc_pdata->boot_on) {
> > >                 ret = -EMEDIUMTYPE;
> > >                 goto out;
> > > @@ -518,56 +523,28 @@ static int regulator_pre_probe(struct udevice *dev)
> > >         return 0;
> > >  }
> > >
> > > -int regulators_enable_boot_on(bool verbose)
> > > +static int regulator_post_probe(struct udevice *dev)
> > >  {
> > > -       struct udevice *dev;
> > > -       struct uclass *uc;
> > >         int ret;
> > >
> > > -       ret = uclass_get(UCLASS_REGULATOR, &uc);
> > > -       if (ret)
> > > +       ret = regulator_autoset(dev);
> > > +       if (ret && ret != -EMEDIUMTYPE && ret != -EALREADY && ret != ENOSYS)
> > >                 return ret;
> > > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > > -            dev;
> > > -            uclass_next_device(&dev)) {
> > > -               ret = regulator_autoset(dev);
> > > -               if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
> > > -                       ret = 0;
> > > -                       continue;
> > > -               }
> > > -               if (verbose)
> > > -                       regulator_show(dev, ret);
> > > -               if (ret == -ENOSYS)
> > > -                       ret = 0;
> > > -       }
> > >
> > > -       return ret;
> > > +       if (_DEBUG)
> > > +               regulator_show(dev, ret);
> > > +
> > > +       return 0;
> > >  }
> > >
> > > -int regulators_enable_boot_off(bool verbose)
> > > +int regulators_enable_boot_on(bool verbose)
> > >  {
> > > -       struct udevice *dev;
> > > -       struct uclass *uc;
> > > -       int ret;
> > > -
> > > -       ret = uclass_get(UCLASS_REGULATOR, &uc);
> > > -       if (ret)
> > > -               return ret;
> > > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > > -            dev;
> > > -            uclass_next_device(&dev)) {
> > > -               ret = regulator_unset(dev);
> > > -               if (ret == -EMEDIUMTYPE) {
> > > -                       ret = 0;
> > > -                       continue;
> > > -               }
> > > -               if (verbose)
> > > -                       regulator_show(dev, ret);
> > > -               if (ret == -ENOSYS)
> > > -                       ret = 0;
> > > -       }
> > > +       return 0;
> > > +}
> > >
> > > -       return ret;
> > > +int regulators_enable_boot_off(bool verbose)
> > > +{
> > > +       return 0;
> > >  }
> > >
> > >  UCLASS_DRIVER(regulator) = {
> > > @@ -575,5 +552,6 @@ UCLASS_DRIVER(regulator) = {
> > >         .name           = "regulator",
> > >         .post_bind      = regulator_post_bind,
> > >         .pre_probe      = regulator_pre_probe,
> > > +       .post_probe     = regulator_post_probe,
> > >         .per_device_plat_auto   = sizeof(struct dm_regulator_uclass_plat),
> > >  };
> > > --
> > > 2.45.2
> > >
> >
> > I thought I objected to this patch, but it seems to be in -next? Does
> > anyone know what has happened here?
>
> Yes, you missed me noting that this fixes real problems and has been
> needing to be fixed for a while. I said you should provide your
> alternative approach and we'll get this sorted out in -next and I took
> the work-around for master so the release wouldn't be broken.

OK ta. So long as we can revert/change that is fine.

>
> > I am seeing these errors now when running sandbox 'u-boot -D':
> >
> >        i2c_emul_find() No emulators for device 'sandbox_pmic'
> >   sandbox_pmic_write() write error to device: 0000000018c49db0 register: 0x0!
> >        out_set_value() PMIC write failed: -5
> >        i2c_emul_find() No emulators for device 'sandbox_pmic'
> >   sandbox_pmic_write() write error to device: 0000000018c49db0 register: 0x0!
> >        out_set_value() PMIC write failed: -5
>
> I suppose the good news is that perhaps this is also related to the
> problem that Svyatoslav was reporting.

OK, I actually never fully understood the problem, but yes, sandbox is
supposed to work similarly.

Regards,
Simon
