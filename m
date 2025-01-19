Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DC4C02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 23:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD19801F5;
	Mon, 20 Jan 2025 00:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8332680586; Mon, 20 Jan 2025 00:43:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B4EC180085
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 00:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A9CF339;
 Sun, 19 Jan 2025 15:44:14 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D6913F5A1;
 Sun, 19 Jan 2025 15:43:44 -0800 (PST)
Date: Sun, 19 Jan 2025 23:42:19 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>,
 linux-sunxi@lists.linux.dev, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH 1/3] suniv: switch Allwinner F1Cx00 boards to OF_UPSTREAM
Message-ID: <20250119234219.1773070e@minigeek.lan>
In-Reply-To: <5850974.DvuYhMxLoT@jernej-laptop>
References: <20250119164157.23648-1-andre.przywara@arm.com>
 <20250119164157.23648-2-andre.przywara@arm.com>
 <5850974.DvuYhMxLoT@jernej-laptop>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sun, 19 Jan 2025 20:45:43 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

> Dne nedelja, 19. januar 2025 ob 17:41:54 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> > In contrast to some other Allwinner SoCs, there is no difference between
> > the DTs for the Allwinner F1C100/F1C200 SoCs (sunvi) between the U-Boot
> > and the Linux kernel repository.
> >=20
> > Remove the old copies of the F1Cx00 related .dts and .dtsi files, and
> > switch the whole suniv SoC over to use OF_UPSTREAM.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  arch/arm/dts/Makefile                        |   2 -
> >  arch/arm/dts/suniv-f1c100s-licheepi-nano.dts |  73 ----
> >  arch/arm/dts/suniv-f1c100s.dtsi              | 330 -------------------
> >  arch/arm/dts/suniv-f1c200s-lctech-pi.dts     |  76 -----
> >  arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts |  81 -----
> >  arch/arm/mach-sunxi/Kconfig                  |   1 +
> >  configs/lctech_pi_f1c200s_defconfig          |   2 +-
> >  configs/licheepi_nano_defconfig              |   2 +-
> >  8 files changed, 3 insertions(+), 564 deletions(-)
> >  delete mode 100644 arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
> >  delete mode 100644 arch/arm/dts/suniv-f1c100s.dtsi
> >  delete mode 100644 arch/arm/dts/suniv-f1c200s-lctech-pi.dts
> >  delete mode 100644 arch/arm/dts/suniv-f1c200s-popstick-v1.1.dts
> >=20
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index aef0425c967..5627daa94db 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -530,8 +530,6 @@ dtb-$(CONFIG_STM32H7) +=3D stm32h743i-disco.dtb \
> >  	stm32h743i-eval.dtb \
> >  	stm32h750i-art-pi.dtb
> > =20
> > -dtb-$(CONFIG_MACH_SUNIV) +=3D \
> > -	suniv-f1c100s-licheepi-nano.dtb
> >  dtb-$(CONFIG_MACH_SUN4I) +=3D \
> >  	sun4i-a10-a1000.dtb \
> >  	sun4i-a10-ba10-tvbox.dtb \


> > diff --git a/arch/arm/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/dt=
s/suniv-f1c100s-licheepi-nano.dts
> > deleted file mode 100644
> > index 43896723a99..00000000000
> > --- a/arch/arm/dts/suniv-f1c100s-licheepi-nano.dts
> > +++ /dev/null

 ....

> > diff --git a/arch/arm/dts/suniv-f1c100s.dtsi b/arch/arm/dts/suniv-f1c10=
0s.dtsi
> > deleted file mode 100644
> > index 3c61d59ab5f..00000000000
> > --- a/arch/arm/dts/suniv-f1c100s.dtsi
> > +++ /dev/null

...

> > diff --git a/arch/arm/dts/suniv-f1c200s-lctech-pi.dts b/arch/arm/dts/su=
niv-f1c200s-lctech-pi.dts
> > deleted file mode 100644
> > index 2d2a3f026df..00000000000
> > --- a/arch/arm/dts/suniv-f1c200s-lctech-pi.dts
> > +++ /dev/null

...

> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index 8065161e61e..866b55833c0 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -279,6 +279,7 @@ config MACH_SUNIV
> >  	select SUPPORT_SPL
> >  	select SKIP_LOWLEVEL_INIT_ONLY
> >  	select SPL_SKIP_LOWLEVEL_INIT_ONLY
> > +	imply OF_UPSTREAM
> > =20
> >  config MACH_SUN4I
> >  	bool "sun4i (Allwinner A10)"
> > diff --git a/configs/lctech_pi_f1c200s_defconfig b/configs/lctech_pi_f1=
c200s_defconfig
> > index e1e8d3aaaa3..1588b3b4955 100644
> > --- a/configs/lctech_pi_f1c200s_defconfig
> > +++ b/configs/lctech_pi_f1c200s_defconfig
> > @@ -1,6 +1,6 @@
> >  CONFIG_ARM=3Dy
> >  CONFIG_ARCH_SUNXI=3Dy
> > -CONFIG_DEFAULT_DEVICE_TREE=3D"suniv-f1c200s-lctech-pi"
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"allwinner/suniv-f1c200s-lctech-pi" =20
>=20
> What's with this board? I don't see it being removed from Makefile. If it
> is not there, then this board has been broken all along?

No, all defconfigs build fine, that's tested with CI on every PR merged.

As it turns out, the build system builds the DTs as listed in the
CONFIG_DEFAULT_DEVICE_TREE variable, but also in CONFIG_OF_LIST
automatically, so those lists in the Makefile are actually somewhat
redundant. I am not entirely sure if there are corner case when they
are needed, though, but even removing the whole Makefile stanza for
A64, for instance, builds those boards fine.

So the LCTech Pi build is fine, both with and without this patch.

Thanks,
Andre

>=20
> Best regards,
> Jernej
>=20
> >  CONFIG_SPL=3Dy
> >  CONFIG_MACH_SUNIV=3Dy
> >  CONFIG_DRAM_CLK=3D156
> > diff --git a/configs/licheepi_nano_defconfig b/configs/licheepi_nano_de=
fconfig
> > index d59affb0d9c..051b1901f20 100644
> > --- a/configs/licheepi_nano_defconfig
> > +++ b/configs/licheepi_nano_defconfig
> > @@ -1,6 +1,6 @@
> >  CONFIG_ARM=3Dy
> >  CONFIG_ARCH_SUNXI=3Dy
> > -CONFIG_DEFAULT_DEVICE_TREE=3D"suniv-f1c100s-licheepi-nano"
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"allwinner/suniv-f1c100s-licheepi-nano"
> >  CONFIG_SPL=3Dy
> >  CONFIG_MACH_SUNIV=3Dy
> >  CONFIG_DRAM_CLK=3D156
> >  =20
>=20
>=20
>=20
>=20
>=20

