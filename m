Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8551C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 11:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322F3871C3;
	Wed, 20 Dec 2023 12:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF3886611; Wed, 20 Dec 2023 12:30:48 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA5E87702
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id BC66320144;
 Wed, 20 Dec 2023 12:30:43 +0100 (CET)
Date: Wed, 20 Dec 2023 12:30:39 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>, u-boot@lists.denx.de,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1 3/3] colibri-imx8x: configure usb hub to bypass mode
Message-ID: <ZYLQX+WzAlITahTH@francesco-nb.int.toradex.com>
References: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
 <20231220103811.228515-4-andrejs.cainikovs@gmail.com>
 <CAOMZO5ChYdS=V16TUjh1bevHXoTybRWk+uX4ir9Y9T7zzEvV7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5ChYdS=V16TUjh1bevHXoTybRWk+uX4ir9Y9T7zzEvV7g@mail.gmail.com>
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

Hello Fabio,

On Wed, Dec 20, 2023 at 07:48:50AM -0300, Fabio Estevam wrote:
> On Wed, Dec 20, 2023 at 7:39 AM Andrejs Cainikovs
> <andrejs.cainikovs@gmail.com> wrote:
> 
> > diff --git a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi b/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
> > index a6af4e5e2b7..6ab6b1f9ee6 100644
> > --- a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
> > +++ b/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
> > @@ -84,6 +84,21 @@
> >         bootph-some-ram;
> >  };
> >
> > +&gpio_expander_43 {
> > +       usb-bypass-n-hog {
> > +               gpio-hog;
> > +               gpios = <5 GPIO_ACTIVE_LOW>;
> > +               line-name = "usb-bypass-n";
> > +               output-high;
> > +       };
> > +       usb-reset-n-hog {
> > +               gpio-hog;
> > +               gpios = <4 GPIO_ACTIVE_LOW>;
> > +               line-name = "usb-reset-n";
> > +               output-low;
> > +       };
> > +};
> 
> Patch looks good from a U-Boot perspective, but just want to
> understand why the imx8qxp/imx8qm boards
> in U-Boot use devicetrees based on downstream NXP instead of the
> mainline kernel dts?
> 
> Shouldn't this 'hub out of reset' be added in mainline Linux first and
> then just sync the dts in U-Boot?

Valid point.

In general re-using the DTS for the kernel would not work.

The bypass and reset signals are part of the USB HUB node [1], and we
would need to add such a driver to U-Boot to be able to properly
implement it (despite the recent plans to make SPL a full blown
bootloader and U-Boot proper the operating system and kick out Linux I
would not go into that direction ;-)

Given that I believe that overriding the Linux DTS to use these 2
signals are simple GPIO HOG for U-Boot is the correct approach.

Francesco

[1] Linux: Documentation/devicetree/bindings/usb/smsc,usb3503.yaml
