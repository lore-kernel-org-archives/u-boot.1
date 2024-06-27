Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3F6C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D31068858C;
	Thu, 27 Jun 2024 13:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kXDet1IC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF386884A3; Thu, 27 Jun 2024 11:26:34 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CEB58826B
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-48f48ab80e3so1793373137.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719480391; x=1720085191; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1DkUuazq8vxodeJDVSZK5XFQNO6SO002ptc7qNZXWg=;
 b=kXDet1ICGeUFXT0/6qeqaVJKOCLo/iMX/tZy2/NQbA4ubAHpaaTXrlcnNcsc0BuEnV
 XzZgKCD6Ftt8gVkVUnyLwOBS4vtDXe7GM0t2WXbWFk6AG3WYOF1wPwf7qTmDTRERpuwV
 TFFQhMSQLT4Z7klfZC7iurHyM9IwNZcQI9WkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719480391; x=1720085191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1DkUuazq8vxodeJDVSZK5XFQNO6SO002ptc7qNZXWg=;
 b=QfJ7UHKpIo4imlXJVGjSRIiuv764/g5RwqmC35XazfSAtELMYrV+ARJg4Zlk3Y45DS
 sUKTfSEXSzDWVZJadnHwZkise2Ld71WA1m90aKHDVVu7uorS9l+zzzAwJ6AeQB5M/Y/4
 iIg/e/gTwiFpMTNyjah7gn5cDr/f3l87hQrDxd+sRuEw0JHdeTogr+YvgfupCnbuu/e4
 exP7MKlyaxK2Xb2B4j2AMxTIo5V2SbRWFLi7a1KV/VXd2qD4gwr1uCqFZXRoCGNmYJ8Z
 K0pSokZJpra2Z30MQsuKJ8GzzTIuEtS3w8RhChDFmA42g3pQpEc83qZH08CzKEZECJPt
 n3kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9NMBAZFronM4h+NOHj5lzVGwO+AaiU6GhdFTvLniLFNq8MXgPxotisYGzuNTjlJVNRPM63rKXiJM66fO6hZMQPxNdkQ==
X-Gm-Message-State: AOJu0Yy7kAHZt7PoHU50YLqYNdLUcmL+ZMa5UedB2rNOwyRKDvlTBe3A
 VFdkTGmQNj9X3kZLz2lsAbSV8UZnZRMxUo/Y0KM12pING7o9uePIMDilu4/Tnfa54S/HPAdSZ0f
 wemv2tWZxETch+39T4cE99WcwCJLg9HMxjbAD
X-Google-Smtp-Source: AGHT+IGJPN/7H22wI3Bm2sb0VeGg2njtL+j6FUyvh7/84X70PrkULQ9to/cjtl3hwGoYZRcQ9dxIHuJ4KznQPPmiAvg=
X-Received: by 2002:a05:6102:303c:b0:48f:408e:45ef with SMTP id
 ada2fe7eead31-48f5295781emr12817318137.7.1719480391172; Thu, 27 Jun 2024
 02:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
 <96AEFD59-B8D3-4298-8867-E94D474E16BE@gmail.com>
In-Reply-To: <96AEFD59-B8D3-4298-8867-E94D474E16BE@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 10:26:20 +0100
Message-ID: <CAFLszTgvEkunWE8apORsK0+PU7wjrWCVCR0F1qij=yo8nDLUNg@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Svyatoslav <clamor95@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
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
 Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>, 
 Tom Rini <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, 
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Svyatoslav,

On Thu, 27 Jun 2024 at 10:09, Svyatoslav <clamor95@gmail.com> wrote:
>
>
>
> 27 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 11:48:46 GMT=
+03:00, Caleb Connolly <caleb.connolly@linaro.org> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> >
> >
> >On 27/06/2024 10:37, Simon Glass wrote:
> >> Hi Marek,
> >>
> >> On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
> >>>
> >>> In case a regulator DT node contains regulator-always-on or regulator=
-boot-on
> >>> property, make sure the regulator gets correctly configured by U-Boot=
 on start
> >>> up. Unconditionally probe such regulator drivers. This is a preparato=
ry patch
> >>> for introduction of .regulator_post_probe() which would trigger the r=
egulator
> >>> configuration.
> >>>
> >>> Parsing of regulator-always-on and regulator-boot-on DT property has =
been
> >>> moved to regulator_post_bind() as the information is required early, =
the
> >>> rest of the DT parsing has been kept in regulator_pre_probe() to avoi=
d
> >>> slowing down the boot process.
> >>>
> >>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>> ---
> >>> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> >>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> >>> Cc: Chris Morgan <macromorgan@hotmail.com>
> >>> Cc: Dragan Simic <dsimic@manjaro.org>
> >>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> >>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> >>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> >>> Cc: Jagan Teki <jagan@amarulasolutions.com>
> >>> Cc: Jonas Karlman <jonas@kwiboo.se>
> >>> Cc: Kever Yang <kever.yang@rock-chips.com>
> >>> Cc: Kostya Porotchkin <kostap@marvell.com>
> >>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> >>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >>> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> >>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> >>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> >>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> >>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> >>> Cc: Sam Day <me@samcday.com>
> >>> Cc: Simon Glass <sjg@chromium.org>
> >>> Cc: Sumit Garg <sumit.garg@linaro.org>
> >>> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> Cc: Thierry Reding <treding@nvidia.com>
> >>> Cc: Tom Rini <trini@konsulko.com>
> >>> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> >>> Cc: u-boot-amlogic@groups.io
> >>> Cc: u-boot-qcom@groups.io
> >>> Cc: u-boot@dh-electronics.com
> >>> Cc: u-boot@lists.denx.de
> >>> Cc: uboot-stm32@st-md-mailman.stormreply.com
> >>> ---
> >>>   drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++----=
---
> >>>   1 file changed, 15 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/pow=
er/regulator/regulator-uclass.c
> >>> index 66fd531da04..ccc4ef33d83 100644
> >>> --- a/drivers/power/regulator/regulator-uclass.c
> >>> +++ b/drivers/power/regulator/regulator-uclass.c
> >>> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *de=
v)
> >>>          const char *property =3D "regulator-name";
> >>>
> >>>          uc_pdata =3D dev_get_uclass_plat(dev);
> >>> +       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-=
on");
> >>> +       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on")=
;
> >>>
> >>>          /* Regulator's mandatory constraint */
> >>>          uc_pdata->name =3D dev_read_string(dev, property);
> >>> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *=
dev)
> >>>                          return -EINVAL;
> >>>          }
> >>>
> >>> -       if (regulator_name_is_unique(dev, uc_pdata->name))
> >>> -               return 0;
> >>> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> >>> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n"=
,
> >>> +                     property, dev->name, uc_pdata->name);
> >>> +               return -EINVAL;
> >>> +       }
> >>>
> >>> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> >>> -             property, dev->name, uc_pdata->name);
> >>> +       /*
> >>> +        * In case the regulator has regulator-always-on or
> >>> +        * regulator-boot-on DT property, trigger probe() to
> >>> +        * configure its default state during startup.
> >>> +        */
> >>> +       if (uc_pdata->always_on && uc_pdata->boot_on)
> >>> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> >>>
> >>> -       return -EINVAL;
> >>> +       return 0;
> >>>   }
> >>>
> >>>   static int regulator_pre_probe(struct udevice *dev)
> >>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *de=
v)
> >>>                                                  -ENODATA);
> >>>          uc_pdata->max_uA =3D dev_read_u32_default(dev, "regulator-ma=
x-microamp",
> >>>                                                  -ENODATA);
> >>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-=
on");
> >>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on")=
;
> >>>          uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "regulato=
r-ramp-delay",
> >>>                                                      0);
> >>>          uc_pdata->force_off =3D dev_read_bool(dev, "regulator-force-=
boot-off");
> >>> --
> >>> 2.43.0
> >>>
> >>
> >> This is reading a lot of DT stuff very early, which may be slow. It is
> >> also reading from the DT in the bind() step which we sometimes have to
> >> do, but try to avoid.
> >
> >Could we set up the livetree pre-bind? What about MMU? On armv8 at least=
 this would have a huge impact on performance. I've done some measurements =
and there is at least 1 order of magnitude difference between parsing FDT w=
ith no caches vs parsing livetree with, it's huge.
> >>
> >> Also this seems to happen in SPL and again pre-reloc and again in
> >> U-Boot post-reloc?
>
> Not so long ago I proposed a similar patchset with the same goal
> and I have discovered massive issues with SPL and relocation
> interfering with driver loading.
>
> The issue which I have personally encountered was i2c driver failure
> due to double probing. This behavior was triggered by
> always-on/boot-on regulators provided by pmic which in most
> cases is an i2c device.
>
> At that time everyone just ignored me, so idk if tegra i2c is the only
> driver which has this response or there are more, but be aware that
> this patch set may cause cascade failure on many devices.

I'm not sure if I remember this, but I can certainly see some problems
with it. Did we have drivers that probed in the bind() function,
perhaps?

>
> Best regards,
> Svyatoslav R.
>
> >>
> >> Should we have a step in the init sequence where we set up the
> >> regulators, by calling regulators_enable_boot_on() ?
> >>
> >> Regards,
> >> Simon
> >
