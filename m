Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABEACA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 09:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C9888CAC;
	Wed,  4 Sep 2024 11:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDEE788C88; Wed,  4 Sep 2024 11:12:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E765888CAF
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 11:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68D22DA7;
 Wed,  4 Sep 2024 02:12:24 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D6153F73F;
 Wed,  4 Sep 2024 02:11:56 -0700 (PDT)
Date: Wed, 4 Sep 2024 10:11:50 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, jagan@amarulasolutions.com, trini@konsulko.com,
 ryan@testtoast.com, iuncuim@gmail.com, Chris Morgan
 <macromorgan@hotmail.com>
Subject: Re: [PATCH V3 7/9] arm64: dts: allwinner: h616: Add r_i2c pinctrl
 nodes
Message-ID: <20240904101133.56a97d99@donnerap.manchester.arm.com>
In-Reply-To: <CAFA6WYOQqt1qiN+B2jEDk2drtt2DxckO-yYwf+b58svFiSwR4g@mail.gmail.com>
References: <20240830155514.481410-1-macroalpha82@gmail.com>
 <20240830155514.481410-8-macroalpha82@gmail.com>
 <CAFA6WYOQqt1qiN+B2jEDk2drtt2DxckO-yYwf+b58svFiSwR4g@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 4 Sep 2024 10:02:16 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

Hi,

> Hi Chris,
> 
> On Fri, 30 Aug 2024 at 21:27, Chris Morgan <macroalpha82@gmail.com> wrote:
> >
> > From: Chris Morgan <macromorgan@hotmail.com>
> >
> > Add pinctrl nodes for the r_i2c node. Without the pinmux defined the
> > r_i2c bus may fail to work, possibly if the bootloader uses rsb mode
> > for the PMIC.
> >
> > Link: https://lore.kernel.org/linux-sunxi/172252952262.1669767.7675865282122079154.b4-ty@csie.org/
> >
> > [ upstream commit: 7c9ea4ab76176f65f4f55aa144f9145a4bccaacb ]
> >
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  arch/arm/dts/sun50i-h616.dtsi                     | 2 ++
> >  dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/dts/sun50i-h616.dtsi b/arch/arm/dts/sun50i-h616.dtsi
> > index 921d5f61d8..41f2c23e07 100644
> > --- a/arch/arm/dts/sun50i-h616.dtsi
> > +++ b/arch/arm/dts/sun50i-h616.dtsi
> > @@ -836,6 +836,8 @@
> >                         clocks = <&r_ccu CLK_R_APB2_I2C>;
> >                         dmas = <&dma 48>, <&dma 48>;
> >                         dma-names = "rx", "tx";
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&r_i2c_pins>;  
> 
> This change is sufficient with !OF_UPSTREAM.
> 
> >                         resets = <&r_ccu RST_R_APB2_I2C>;
> >                         status = "disabled";
> >                         #address-cells = <1>;
> > diff --git a/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi b/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
> > index 921d5f61d8..41f2c23e07 100644
> > --- a/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
> > +++ b/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
> > @@ -836,6 +836,8 @@
> >                         clocks = <&r_ccu CLK_R_APB2_I2C>;
> >                         dmas = <&dma 48>, <&dma 48>;
> >                         dma-names = "rx", "tx";
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&r_i2c_pins>;  
> 
> Please don't manually patch dts/upstream subtree. It is meant to be
> updated only with tools/update-subtree.sh script. Also, it isn't
> needed as well since you haven't converted to OF_UPSTREAM at this
> point. Same applies to patch #8 as well.

Yes, but the H616 OF_UPSTREAM patch is already on the list, and this
series will intersect at some point. The change above is already in the
queue for the kernel tree, so we will pick it up once it appears in the
repo.

I will sort this all out when merging, but meanwhile it's good to have
some functioning series on the list.

Cheers,
Andre

> 
> -Sumit
> 
> >                         resets = <&r_ccu RST_R_APB2_I2C>;
> >                         status = "disabled";
> >                         #address-cells = <1>;
> > --
> > 2.34.1
> >  

