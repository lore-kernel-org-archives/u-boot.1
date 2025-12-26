Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2EBE8FDA6
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 11:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEBE28431E;
	Fri, 26 Dec 2025 12:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sj1OFD4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C33A84327; Fri, 26 Dec 2025 12:13:28 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2E8D842F7
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 12:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B02FA43742;
 Fri, 26 Dec 2025 11:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5981C4CEF7;
 Fri, 26 Dec 2025 11:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766747603;
 bh=RZLw2wvB8QvvlihkwnGxQf4zbJp//b7qyRpbXLYf1+E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Sj1OFD4lja7Qgu+fi9C76MKs9NGcNtrSZDhN6BFTC8I9ki4OIUkDHDkjC+yyPeUHC
 Mv+/cHU2q5W365GNzRC6lVy5okhBDZH85x1DPN+zVN84hIIhy1DZwGeCZrrsA3mNg9
 fuHqDiGmCIFPowVcArADH5SMPXHWG6yodyiwzJXtDhEYx90Glk4JHaLeh6hZuoAmtt
 QVj698e0GkXGpUGthHfMppgctIUpN/R9sdjACaHfS8q/ezEPdIfDCuO5N56K7hbtBu
 UpYrnI1sF4pQAG5FUIyUb6Y1+av5Rcs8ceH3VcdY+6cHzpVecEXr8SxWDqwmDKHIah
 KHSSuoyjoxBBA==
Date: Fri, 26 Dec 2025 16:43:11 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 neil.armstrong@linaro.org, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 peng.fan@nxp.com, alif.zakuan.yuslaimi@altera.com,
 kory.maincent@bootlin.com, sjg@chromium.org,
 jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 4/7] arch: arm: mach-snapdragon: Make USB speed fixup
 configurable
Message-ID: <aU5tx8VkWCxwLbHN@sumit-xelite>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-5-balaji.selvanathan@oss.qualcomm.com>
 <15b7482e-166b-43df-8a76-cdf150575872@linaro.org>
 <69375261-2c75-4093-9dd3-a3a97505c417@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69375261-2c75-4093-9dd3-a3a97505c417@oss.qualcomm.com>
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

On Wed, Dec 03, 2025 at 04:51:20PM +0530, Balaji Selvanathan wrote:
> 
> On 11/26/2025 7:54 PM, Casey Connolly wrote:
> > Hi Balaji,
> > 
> > On 24/11/2025 16:55, Balaji Selvanathan wrote:
> > > Add CONFIG_QCOM_USB_FIXUP option to allow platforms to disable
> > > the USB speed limitation fixup when they have proper super-speed
> > > USB support in U-Boot.
> > In general, we prefer to handle cases like this at runtime rather than
> > compile time. Could you rework this to check for the "qcom,sc7280-dwc3"
> > compatible and just skip the check in that case? I would also propose
> > adding a log_warning() in the fixup case so that folks working on other
> > platforms know to add their compatible too.
> > 
> > Obviously that's still not an ideal solution, maybe it would be possible
> > to implement the Super Smart (tm) fix and actually check if a driver
> > /will/ bind to the ss-phy node before the fixup, it depends how slow
> > that would be.
> This is good idea. Actually, I have implemented the super smart fix rather
> than hardcoding
> 
> "qcom,sc7280-dwc3" in code. The respined code is here: https://lore.kernel.org/u-boot/20251203110735.1959862-5-balaji.selvanathan@oss.qualcomm.com/;
> The code checks if the SS PHY driver is indeed available and if it exists, then it skips doing
> USB HS fixup.
> The entire time to check if the SS PHY driver is available is ~125ms. Request to say if this is reasonable.

I don't think it's reasonable to add more than 125ms in boot for every
platform considering slower platforms as compared to RB3G2 where it will
be much worse.

Lets just rather add a static check for "qcom,sc7280-dwc3" to skip the
USB fixup.

-Sumit

> The power domain fixup is taking ~98us (mentioning just for comparison).
> Thanks,
> Balaji
> 
> > 
> > Kind regards,
> > 
> > > Currently, U-Boot limits USB to high-speed mode on all Qualcomm
> > > platforms by fixing up the device tree at runtime. This was
> > > necessary because most platforms lacked super-speed PHY drivers.
> > > 
> > > However, newer platforms now have proper QMP PHY drivers that support
> > > super-speed USB. For these platforms, the fixup is counterproductive
> > > as it prevents the hardware from operating at its full capability.
> > > 
> > > This change:
> > > - Adds CONFIG_QCOM_USB_FIXUP (default y) to maintain backward
> > >    compatibility with existing platforms
> > > - Wraps the fixup code with #ifdef to allow selective disabling
> > > - Allows platforms with super-speed support to disable the fixup
> > >    via their defconfig
> > > 
> > > Platforms without super-speed PHY drivers will continue to work
> > > as before with the fixup enabled by default.
> > > 
> > > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > > ---
> > >   arch/arm/mach-snapdragon/Kconfig    | 10 ++++++++++
> > >   arch/arm/mach-snapdragon/of_fixup.c |  4 ++++
> > >   2 files changed, 14 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> > > index 976c0e35fce..6c53aeef597 100644
> > > --- a/arch/arm/mach-snapdragon/Kconfig
> > > +++ b/arch/arm/mach-snapdragon/Kconfig
> > > @@ -29,6 +29,16 @@ config SYS_MALLOC_LEN
> > >   config LNX_KRNL_IMG_TEXT_OFFSET_BASE
> > >   	default 0x80000000
> > > +config QCOM_USB_FIXUP
> > > +	bool "Enable USB speed fixup for Qualcomm platforms"
> > > +	default y
> > > +	help
> > > +	  Enable runtime fixup of USB device tree nodes to limit USB to
> > > +	  high-speed mode. This is needed on some Qualcomm platforms where
> > > +	  U-Boot doesn't support super-speed USB.
> > > +	  Disable this for platforms that have proper super-speed USB support
> > > +	  in U-Boot.
> > > +
> > >   config SYS_BOARD
> > >   	string "Snapdragon SoCs based board"
> > >   	help
> > > diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> > > index eec2c0c757e..6a64168f67e 100644
> > > --- a/arch/arm/mach-snapdragon/of_fixup.c
> > > +++ b/arch/arm/mach-snapdragon/of_fixup.c
> > > @@ -27,6 +27,7 @@
> > >   #include <stdlib.h>
> > >   #include <time.h>
> > > +#ifdef CONFIG_QCOM_USB_FIXUP
> > >   /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
> > >    * USB controllers. Rather than requiring source level DT changes, we fix up
> > >    * DT here. This improves compatibility with upstream DT and simplifies the
> > > @@ -115,6 +116,7 @@ static void fixup_usb_nodes(struct device_node *root)
> > >   			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
> > >   	}
> > >   }
> > > +#endif
> > >   /* Remove all references to the rpmhpd device */
> > >   static void fixup_power_domains(struct device_node *root)
> > > @@ -157,7 +159,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
> > >   {
> > >   	struct device_node *root = event->data.of_live_built.root;
> > > +#ifdef CONFIG_QCOM_USB_FIXUP
> > >   	time_call(fixup_usb_nodes, root);
> > > +#endif
> > >   	time_call(fixup_power_domains, root);
> > >   	return 0;
