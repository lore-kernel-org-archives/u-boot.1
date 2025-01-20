Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66690C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 16:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B3D800C2;
	Mon, 20 Jan 2025 17:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KZIF7KfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DEEB801CF; Mon, 20 Jan 2025 17:30:17 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB4C800B6
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 17:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436341f575fso51630215e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737390614; x=1737995414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7byeOWj8mqd5liuAk8fmYt6myD3Cdui8rxJFtzetURM=;
 b=KZIF7KfC0GA5c9Wx/8/pHczZEuWQT/d+mXOMp8twHfRDAq4jbzpI1vIYNhvBZrPpU0
 W9tyX7oQLwtmQIV5Ddy6yhSaK2ReZ+JVUoOnz7JK7MuI4hzOH+bcL/+4ytLojOvLIsyx
 gK0PLH2w+lQfvGKzmI6zon7/Dfam+uIX8ElKJRg9Lf9pjTx6+cIuTjKmdQ9qo+LHHdHd
 3+sY8wrobw1j7nQ7nn8dys/SlzedPyU4JqQGLGPp+eBIf4qfKM+Zq4ag6XIAyvdUbngh
 gq4FxjbjLihxLybXxs+HiGXp4tEIubYdADX9zYxMeMh6BN//hm1VONCWz+saKnmfqrhg
 zjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737390614; x=1737995414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7byeOWj8mqd5liuAk8fmYt6myD3Cdui8rxJFtzetURM=;
 b=mCWaeX8i/jE7m/zqiEp1oYF3hgIOhIIlU0Nf50F5uoha3lv7dmusfZQRe9WR7tyfYn
 dmhtPu9xB7a2v/6/cc6s3Z6kUzR5ex2KdXa9HeM+04x30zW1DushMKk+vQBoU36dDtc0
 qQaG4rfrpEIo45rWg3WkpgXiPNlzL8xbOAQQ6IIpMOFbqFhTGxZf7BUWOerq5bOtNko1
 WsRGb6k7CK9e9AgH9/lURAxnr9qeoBenOcxOO0S+aexcNkSSWq8BZemcVIIp4SCa8Iaw
 OJx0WKkOp1kneNnIstlyQnxFJ5KDAfIxdVoNKVJIVtRavNBAhrV+Eb2AZxgHlz7oyQLQ
 epHg==
X-Gm-Message-State: AOJu0YwsyES2kiZEwqm9VYuMSY9C2kK4/NgpSIRuzhBLsMDTF+Y4SifK
 hfcCBGrH4Wkf5mfPOT3h2x9w6niDqDI6IhCOJ74Vh50JHon87HjB
X-Gm-Gg: ASbGncuhKFSDkBrN5bbijEyiGum414+fXAsstB9rRjuqf14PVICzuWahup5JtRtKvWd
 YraBP14wCBaK1MZP+ORUxQmnr9S35W1Z5T6VLZyFXtfs/ebBZfIojA5TIZRwTfcyTn76quqoI9Y
 oyteEJy6o3lDx7wwDNmxFhUP/W1rYSHWWsfyzKODQaY5sVo9AyWyGhKdWQK4S1yGInNrwbZHOC+
 98Lo4VZgj6jpFHi+eDpuohckQHk0luVDUHqizDzdJ19HYlY+ChD5qWCyTbQ/mfdiX2BMAE1S/h4
 Ew6xDGa/0Rl84LN0Qwtwi+ZrJoebsALvDlnP/86ArN5nXw==
X-Google-Smtp-Source: AGHT+IGYlwOfQTBmDV9p0BTI1YjPdzsF6tv3D14qBA8AJNB484oglkq19CNbBVhbNQMaMaUHsie6dQ==
X-Received: by 2002:a05:600c:3548:b0:434:a1d3:a321 with SMTP id
 5b1f17b1804b1-438913c6150mr127787055e9.3.1737390613990; 
 Mon, 20 Jan 2025 08:30:13 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389046bab0sm143119205e9.38.2025.01.20.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 08:30:13 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>,
 linux-sunxi@lists.linux.dev, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/3] suniv: switch Allwinner F1Cx00 boards to OF_UPSTREAM
Date: Mon, 20 Jan 2025 17:30:12 +0100
Message-ID: <2763817.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20250119234219.1773070e@minigeek.lan>
References: <20250119164157.23648-1-andre.przywara@arm.com>
 <5850974.DvuYhMxLoT@jernej-laptop> <20250119234219.1773070e@minigeek.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 20. januar 2025 ob 00:42:19 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> On Sun, 19 Jan 2025 20:45:43 +0100
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi Jernej,
>=20
> > Dne nedelja, 19. januar 2025 ob 17:41:54 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> > > In contrast to some other Allwinner SoCs, there is no difference betw=
een
> > > the DTs for the Allwinner F1C100/F1C200 SoCs (sunvi) between the U-Bo=
ot
> > > and the Linux kernel repository.
> > >=20
> > > Remove the old copies of the F1Cx00 related .dts and .dtsi files, and
> > > switch the whole suniv SoC over to use OF_UPSTREAM.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  arch/arm/dts/Makefile                        |   2 -
> > >  arch/arm/dts/suniv-f1c100s-licheepi-nano.dts |  73 ----
> > >  arch/arm/dts/suniv-f1c100s.dtsi              | 330 -----------------=
=2D-
> > >  arch/arm/dts/suniv-f1c200s-lctech-pi.dts     |  76 -----
> > >  arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts |  81 -----
> > >  arch/arm/mach-sunxi/Kconfig                  |   1 +
> > >  configs/lctech_pi_f1c200s_defconfig          |   2 +-
> > >  configs/licheepi_nano_defconfig              |   2 +-
> > >  8 files changed, 3 insertions(+), 564 deletions(-)
> > >  delete mode 100644 arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
> > >  delete mode 100644 arch/arm/dts/suniv-f1c100s.dtsi
> > >  delete mode 100644 arch/arm/dts/suniv-f1c200s-lctech-pi.dts
> > >  delete mode 100644 arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts
> > >=20
> > > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > > index aef0425c967..5627daa94db 100644
> > > --- a/arch/arm/dts/Makefile
> > > +++ b/arch/arm/dts/Makefile
> > > @@ -530,8 +530,6 @@ dtb-$(CONFIG_STM32H7) +=3D stm32h743i-disco.dtb \
> > >  	stm32h743i-eval.dtb \
> > >  	stm32h750i-art-pi.dtb
> > > =20
> > > -dtb-$(CONFIG_MACH_SUNIV) +=3D \
> > > -	suniv-f1c100s-licheepi-nano.dtb
> > >  dtb-$(CONFIG_MACH_SUN4I) +=3D \
> > >  	sun4i-a10-a1000.dtb \
> > >  	sun4i-a10-ba10-tvbox.dtb \
>=20
>=20
> > > diff --git a/arch/arm/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/=
dts/suniv-f1c100s-licheepi-nano.dts
> > > deleted file mode 100644
> > > index 43896723a99..00000000000
> > > --- a/arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
> > > +++ /dev/null
>=20
>  ....
>=20
> > > diff --git a/arch/arm/dts/suniv-f1c100s.dtsi b/arch/arm/dts/suniv-f1c=
100s.dtsi
> > > deleted file mode 100644
> > > index 3c61d59ab5f..00000000000
> > > --- a/arch/arm/dts/suniv-f1c100s.dtsi
> > > +++ /dev/null
>=20
> ...
>=20
> > > diff --git a/arch/arm/dts/suniv-f1c200s-lctech-pi.dts b/arch/arm/dts/=
suniv-f1c200s-lctech-pi.dts
> > > deleted file mode 100644
> > > index 2d2a3f026df..00000000000
> > > --- a/arch/arm/dts/suniv-f1c200s-lctech-pi.dts
> > > +++ /dev/null
>=20
> ...
>=20
> > > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > > index 8065161e61e..866b55833c0 100644
> > > --- a/arch/arm/mach-sunxi/Kconfig
> > > +++ b/arch/arm/mach-sunxi/Kconfig
> > > @@ -279,6 +279,7 @@ config MACH_SUNIV
> > >  	select SUPPORT_SPL
> > >  	select SKIP_LOWLEVEL_INIT_ONLY
> > >  	select SPL_SKIP_LOWLEVEL_INIT_ONLY
> > > +	imply OF_UPSTREAM
> > > =20
> > >  config MACH_SUN4I
> > >  	bool "sun4i (Allwinner A10)"
> > > diff --git a/configs/lctech_pi_f1c200s_defconfig b/configs/lctech_pi_=
f1c200s_defconfig
> > > index e1e8d3aaaa3..1588b3b4955 100644
> > > --- a/configs/lctech_pi_f1c200s_defconfig
> > > +++ b/configs/lctech_pi_f1c200s_defconfig
> > > @@ -1,6 +1,6 @@
> > >  CONFIG_ARM=3Dy
> > >  CONFIG_ARCH_SUNXI=3Dy
> > > -CONFIG_DEFAULT_DEVICE_TREE=3D"suniv-f1c200s-lctech-pi"
> > > +CONFIG_DEFAULT_DEVICE_TREE=3D"allwinner/suniv-f1c200s-lctech-pi" =20
> >=20
> > What's with this board? I don't see it being removed from Makefile. If =
it
> > is not there, then this board has been broken all along?
>=20
> No, all defconfigs build fine, that's tested with CI on every PR merged.
>=20
> As it turns out, the build system builds the DTs as listed in the
> CONFIG_DEFAULT_DEVICE_TREE variable, but also in CONFIG_OF_LIST
> automatically, so those lists in the Makefile are actually somewhat
> redundant. I am not entirely sure if there are corner case when they
> are needed, though, but even removing the whole Makefile stanza for
> A64, for instance, builds those boards fine.
>=20
> So the LCTech Pi build is fine, both with and without this patch.

Thanks for explanation. This is then:

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> Thanks,
> Andre
>=20
> >=20
> > Best regards,
> > Jernej
> >=20
> > >  CONFIG_SPL=3Dy
> > >  CONFIG_MACH_SUNIV=3Dy
> > >  CONFIG_DRAM_CLK=3D156
> > > diff --git a/configs/licheepi_nano_defconfig b/configs/licheepi_nano_=
defconfig
> > > index d59affb0d9c..051b1901f20 100644
> > > --- a/configs/licheepi_nano_defconfig
> > > +++ b/configs/licheepi_nano_defconfig
> > > @@ -1,6 +1,6 @@
> > >  CONFIG_ARM=3Dy
> > >  CONFIG_ARCH_SUNXI=3Dy
> > > -CONFIG_DEFAULT_DEVICE_TREE=3D"suniv-f1c100s-licheepi-nano"
> > > +CONFIG_DEFAULT_DEVICE_TREE=3D"allwinner/suniv-f1c100s-licheepi-nano"
> > >  CONFIG_SPL=3Dy
> > >  CONFIG_MACH_SUNIV=3Dy
> > >  CONFIG_DRAM_CLK=3D156
> > >  =20
> >=20
> >=20
> >=20
> >=20
> >=20
>=20
>=20




