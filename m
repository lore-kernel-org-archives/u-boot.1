Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CC5CF9C5F
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 20:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165CF88A24;
	Fri, 20 Sep 2024 22:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E0nuLmUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0ED88B08; Fri, 20 Sep 2024 18:40:52 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0FE88AB9
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso27089855e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726850448; x=1727455248; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjTpfrqYfPm0t81VoMBFCfW8GHAniRCwt4aYaCwgPC0=;
 b=E0nuLmUlUORJDkmeWDclcmQcnS4Fw5UgoN3krVjDY8Xm167zbO4ADLOq2LlDdzYveI
 tPFE8eBrO332gCKpNNExIfu92kcaHcN6eGli9RiaHwDR+NrbWcY/yzyS2uOYK8IvpBSt
 5kxZKkt50Mer/0JTlM/5Y/0bJ7zr5Pctwn4SSpNZrcSyudqS8nzCD/cobCTRSu+kwFls
 4xJbGPg7JqsIicp5mAXACipLMHWtqyirXWixjAkKtJdFHWBlzTAFSZHH86slwFZXAVxN
 UjbBVaHq7yhLl/4V7jWXQcjVPYxKNQGochq0XWtMlpGossUspymZnyQzacj/spg0b9hB
 ruAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726850448; x=1727455248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjTpfrqYfPm0t81VoMBFCfW8GHAniRCwt4aYaCwgPC0=;
 b=WDV9mUaahpsiIjcSH4F5gOSbcpdb/WHqWm62mlYQwLANcxqvzPo0gQ6Da9UzKGpOQv
 k9xIJm28yBzpUHOYKctGxXXvGgm80K/V7WBx8hQtm6YH3JdjEKy5iQL2TNfl7i9ySBKH
 PKHqWA3UeNtAoy2KVVwUuHAeUd+YYxfyJ6RA3HqIRzEcMfLJm0KzPNufbTRVZ+KVpKGq
 T2wBDTqfEBL+OvFXtyTz3wwvAiZtyEDEz5AyyIwF4NIxptkdrMDZUUeKBqq5cM7VlesK
 UR4htiUKgjF9rqQGhXzA4dPJRchWefYES2TsuDn4rFXgRrxjVuaTs3YV3ageYATV5OIN
 Z8+w==
X-Gm-Message-State: AOJu0YyawfDLTFhOeJvMUZR6O5hs5vOpSIS23NPPL/rpu99vAVCvlale
 WP+mmxZcxmn8kkt3f3qmDJveFbVCMNQp6dnrm+/FfTEbiH06mxrhHfSVmAZKl2s+Yug6lQrVHIJ
 UEJh7QerCKPyQ9UjK2O2mIuL9XUg=
X-Google-Smtp-Source: AGHT+IEsEXZntFy6xgwz/q/9vWCl6qOIitTPjYnk/mQkYzrjqD/JcYbc9Z6FOTI2qB1SHx8XX2O8rsySf8miAdxoDSs=
X-Received: by 2002:a05:6000:d8b:b0:374:c3e4:d6b1 with SMTP id
 ffacd0b85a97d-37a42367ed1mr2708320f8f.44.1726850447713; Fri, 20 Sep 2024
 09:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
 <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat>
In-Reply-To: <20240916162758.GE4252@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 20 Sep 2024 19:40:35 +0300
Message-ID: <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
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
 Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 20 Sep 2024 22:04:43 +0200
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

=D0=BF=D0=BD, 16 =D0=B2=D0=B5=D1=80. 2024=E2=80=AF=D1=80. =D0=BE 19:28 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Sep 11, 2024 at 07:00:56PM -0600, Simon Glass wrote:
> > Hi Marek,
> >
> > On Fri, 28 Jun 2024 at 07:26, Marek Vasut <marex@denx.de> wrote:
> > >
> > > On 6/28/24 9:32 AM, Simon Glass wrote:
> > > > Hi Marek,
> > >
> > > Hi,
> > >
> > > [...]
> > >
> > > >>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevic=
e *dev)
> > > >>>>                                                   -ENODATA);
> > > >>>>           uc_pdata->max_uA =3D dev_read_u32_default(dev, "regula=
tor-max-microamp",
> > > >>>>                                                   -ENODATA);
> > > >>>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-al=
ways-on");
> > > >>>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot=
-on");
> > > >>>>           uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "re=
gulator-ramp-delay",
> > > >>>>                                                       0);
> > > >>>>           uc_pdata->force_off =3D dev_read_bool(dev, "regulator-=
force-boot-off");
> > > >>>> --
> > > >>>> 2.43.0
> > > >>>>
> > > >>>
> > > >>> This is reading a lot of DT stuff very early, which may be slow. =
It is
> > > >>> also reading from the DT in the bind() step which we sometimes ha=
ve to
> > > >>> do, but try to avoid.
> > > >>
> > > >> Actually, it is reading only the bare minimum very early in bind, =
the
> > > >> always-on and boot-on, the rest is in pre_probe, i.e. later.
> > > >
> > > > Yes, I see that. Also it is inevitable that these properties need t=
o
> > > > be read before probe(), since they control whether to probe().
> > > >
> > > >>
> > > >>> Also this seems to happen in SPL and again pre-reloc and again in
> > > >>> U-Boot post-reloc?
> > > >>
> > > >> What does, the uclass post_bind ?
> > > >
> > > > I mean that this code will be called in SPL (if the regulators are =
in
> > > > the DT there), U-Boot pre-reloc and post-reloc, each time turning o=
n
> > > > the regulators. We need a way to control that, don't we?
> > >
> > > I would assume that if those regulators are turned on once in the
> > > earliest stage , turning them on again in the follow up stage would b=
e a
> > > noop ? This is the point of regulator-*-on, to keep the regulators on=
.
> >
> > No, there is sometimes a particular sequence needed.
> >
> > >
> > > >>> Should we have a step in the init sequence where we set up the
> > > >>> regulators, by calling regulators_enable_boot_on() ?
> > > >>
> > > >> Let's not do this , the entire point of this series is to get rid =
of
> > > >> those functions and do the regulator configuration the same way LE=
D
> > > >> subsystem does it -- by probing always-on/boot-on regulators and
> > > >> configuring them correctly on probe.
> > > >>
> > > >> To me regulators_enable_boot_on() and the like was always an
> > > >> inconsistently applied workaround for missing DM_FLAG_PROBE_AFTER_=
BIND ,
> > > >> which is now implemented, so such workarounds can be removed.
> > > >
> > > > That patch seemed to slip under the radar, sent and applied on the
> > > > same day! We really need to add a test for it, BTW.
> > >
> > > Which patch ? My recollection of DM_FLAG_PROBE_AFTER_BIND was that it
> > > took a while to get in.
> >
> > [1]
> >
> > >
> > > > My concern is that this might cause us ordering problems. We perhap=
s
> > > > want the regulators to be done first. If drivers are probed which u=
se
> > > > regulators, then presumably they will enable them. Consider this:
> > > >
> > > > - LED driver auto-probes
> > > >     - probes I2C bus 2
> > > >     - probes LDO1 which is autoset so turns on
> > > > - LDO1 probes, but is already running
> > > > - LDO2 probes, which is autoset so turns on
> > > >
> > > > So long as it is OK to enable the regulators in any order, then thi=
s
> > > > seems fine. But is it? How do we handle the case where are particul=
ar
> > > > sequence is needed?
> > >
> > > Did we finally arrive at the point where we need -EPROBE_DEFER alike
> > > mechanism ?
> >
> > Nope. But I am concerned that this patch is leading us there. bind()
> > really needs to be as clean as possible. It is one of the design
> > elements of driver model which Linux should adopt.
> >
> > There is always a race to be the first to init something, move the
> > init earlier, etc... I don't see any general need to init the
> > regulators right at the start. It should be done in a separate
> > function and be optional. I am happy to send a patch if you like.
>
> Since we're currently stuck on the point where Marek has patches that
> fix a real problem, and Svyatoslav has a problem with them, but isn't
> currently able to debug it, yes, please put forward your patch that
> might address both sets of problems so we can all figure out how to
> resolve the problems, thanks!
>
> --
> Tom

With patches from Marek there is no i2c chip probe of PMIC, while
without i2c chip probe is called (probe_chip function). How this is
even possible?
