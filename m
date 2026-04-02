Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D12D3943C
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D0E83CF5;
	Thu,  2 Apr 2026 17:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="GM52vJkC";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="DzY1hNs2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9588283CF5; Thu,  2 Apr 2026 05:33:58 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD1280212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 05:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dang.huynh@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1775100826; bh=6ndsqffAB2IrLCAgTy2tk3v
 h5JdeOEXV7+TVhRNoOsc=; b=GM52vJkCgGs/RoteY+xkNNHBRfR9sXI0eLEH2/cZ7Ugkrm4wY/
 cz4HMoftnpraLLeUeSPBK+cl7chV4kjFYe+AxBzSUrSLpNM+2ENSV/bYHtFbDdth4Hva4UcClgU
 OxAo/uQmzRAnU/d/oDpCrDvAAAB9A98Z0RHxYaKXdIUaIj5XEHQDxivk2CxsEWzq82h6rSOfRTI
 OAe5sAIkadmzxWvqffdzXCL/myzZedStwzF3rbkS1UzpWp/V5JMpN32DJiIZVU0TdG+/jdBLthl
 DKpHF3GHmWziFVMZWcHhZz+ZzWfyu4tbJP4Zx0irElmu+zRwVkVeXhK7Bt3P5gvEmxw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1775100826; bh=6ndsqffAB2IrLCAgTy2tk3v
 h5JdeOEXV7+TVhRNoOsc=; b=DzY1hNs2/jAw/MYN5g6KDsD42LL5ruJbfUVFPP0lHqCvSlrDrC
 YUpIiClx2IpmLlLO/8vCnhnyNh/2kDUi2jDA==;
Date: Thu, 2 Apr 2026 10:33:37 +0700
From: Dang Huynh <dang.huynh@mainlining.org>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ondrej Jirman <megi@xff.cz>,
 Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dragan Simic <dsimic@manjaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Piotr Zalewski <pZ010001011111@proton.me>
Subject: Re: [PATCH v6 07/12] video: rockchip: vop2: Add video bridge support
Message-ID: <ac3in2oxAtzvprak@meltbook-pro>
References: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
 <20251108-vop2-pt2-v6-7-d04c699262fb@mainlining.org>
 <CALeDE9OTnFa4gs1XnGsdN2X0Db2aYAsSLafr8pYf+MQuRSpuXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9OTnFa4gs1XnGsdN2X0Db2aYAsSLafr8pYf+MQuRSpuXQ@mail.gmail.com>
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:03:20 +0200
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

Hi Peter,

On Wed, Mar 04, 2026 at 12:29:27PM +0000, Peter Robinson wrote:
> Hey Dang,
> 
> Finally started to play with this patch set.
> 
> > From: Dang Huynh <dang.huynh@mainlining.org>
> >
> > Add support for video bridge to VOP2 so we can use the MIPI DSI
> > bridge driver that we have.
> 
> I see a link failure when using this patch set with the
> anbernic-rgxx3-rk3566_defconfig using 2026.04-rc3.
> 
> /usr/bin/ld.bfd: drivers/video/rockchip/rk_vop2.o: in function
> `rk_display_init':
> /builddir/build/BUILD/uboot-tools-2026.04-build/u-boot-2026.04-rc3/drivers/video/rockchip/rk_vop2.c:422:(.text.rk_vop2_probe+0x360):
> undefined reference to `display_in_use'
> /usr/bin/ld.bfd:
> /builddir/build/BUILD/uboot-tools-2026.04-build/u-boot-2026.04-rc3/drivers/video/rockchip/rk_vop2.c:437:(.text.rk_vop2_probe+0x388):
> undefined reference to `display_read_timing'
> /usr/bin/ld.bfd:
> /builddir/build/BUILD/uboot-tools-2026.04-build/u-boot-2026.04-rc3/drivers/video/rockchip/rk_vop2.c:492:(.text.rk_vop2_probe+0x794):
> undefined reference to `display_enable'

Interestingly on my machine, it shows:
/usr/lib/gcc/aarch64-linux-gnu/15.1.0/../../../../aarch64-linux-gnu/bin/ld: /tmp/cceER6YV.ltrans9.ltrans.o: in function `rk3568_vop_probe':
/media/LARGE_DATA/Work/pinetab2/u-boot/drivers/video/rockchip/rk_vop2.c:424:(.text.rk3568_vop_probe+0x43c): undefined reference to `display_in_use'
/usr/lib/gcc/aarch64-linux-gnu/15.1.0/../../../../aarch64-linux-gnu/bin/ld: /tmp/cceER6YV.ltrans9.ltrans.o:
/media/LARGE_DATA/Work/pinetab2/u-boot/drivers/video/rockchip/rk_vop2.c:439:(.text.rk3568_vop_probe+0x464): undefined reference to `display_read_timing'
/usr/lib/gcc/aarch64-linux-gnu/15.1.0/../../../../aarch64-linux-gnu/bin/ld: /tmp/cceER6YV.ltrans9.ltrans.o:
/media/LARGE_DATA/Work/pinetab2/u-boot/drivers/video/rockchip/rk_vop2.c:494:(.text.rk3568_vop_probe+0x88c): undefined reference to `display_enable'
collect2: fatal error: ld terminated with signal 11 [Segmentation fault], core dumped
compilation terminated.

Perhaps this is a linker bug? Removing rk_vop2.o from Makefile
makes it build perfectly fine though.

Though, I don't think there are any devices that uses VOP and
doesn't have a display, so I think we should make CONFIG_DISPLAY
a requirement.


> 
> Cheers,
> Peter
> 
> 
> > Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> > ---
> >  drivers/video/rockchip/rk_vop2.c | 81 +++++++++++++++++++++++++++++-----------
> >  1 file changed, 59 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/video/rockchip/rk_vop2.c b/drivers/video/rockchip/rk_vop2.c
> > index 992f215d416..156daafa0c3 100644
> > --- a/drivers/video/rockchip/rk_vop2.c
> > +++ b/drivers/video/rockchip/rk_vop2.c
> > @@ -13,10 +13,12 @@
> >  #include <dm/device_compat.h>
> >  #include <edid.h>
> >  #include <log.h>
> > +#include <panel.h>
> >  #include <regmap.h>
> >  #include <reset.h>
> >  #include <syscon.h>
> >  #include <video.h>
> > +#include <video_bridge.h>
> >  #include <asm/global_data.h>
> >  #include <asm/gpio.h>
> >  #include <asm/io.h>
> > @@ -291,6 +293,7 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
> >         int vop_id, port_id, win_id;
> >         struct display_timing timing;
> >         struct udevice *disp;
> > +       struct udevice *bridge;
> >         int ret;
> >         u32 remote_phandle;
> >         struct display_plat *disp_uc_plat;
> > @@ -357,8 +360,11 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
> >                         return -EINVAL;
> >                 }
> >
> > +               if (IS_ENABLED(CONFIG_VIDEO_BRIDGE))
> > +                       uclass_find_device_by_ofnode(UCLASS_VIDEO_BRIDGE, remote, &bridge);
> > +
> >                 uclass_find_device_by_ofnode(UCLASS_DISPLAY, remote, &disp);
> > -               if (disp)
> > +               if (disp || bridge)
> >                         break;
> >         };
> >         compat = ofnode_get_property(remote, "compatible", NULL);
> > @@ -390,27 +396,49 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
> >         if (ret < 0)
> >                 return ret;
> >
> > -       disp_uc_plat = dev_get_uclass_plat(disp);
> > -       debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
> > -       if (display_in_use(disp)) {
> > -               debug("   - device in use\n");
> > -               return -EBUSY;
> > -       }
> > +       if (bridge) {
> > +               /* video bridge detected, probe it */
> > +               ret = device_probe(bridge);
> > +               if (ret) {
> > +                       dev_err(dev, "Failed to probe video bridge: %d\n", ret);
> > +                       return ret;
> > +               }
> >
> > -       disp_uc_plat->source_id = vop_id;
> > -       disp_uc_plat->src_dev = dev;
> > +               /* Attach the DSI controller and the display to the bridge. */
> > +               ret = video_bridge_attach(bridge);
> > +               if (ret) {
> > +                       dev_err(dev, "Failed to attach video bridge: %d\n", ret);
> > +                       return ret;
> > +               }
> >
> > -       ret = device_probe(disp);
> > -       if (ret) {
> > -               debug("%s: device '%s' display won't probe (ret=%d)\n",
> > -                     __func__, dev->name, ret);
> > -               return ret;
> > -       }
> > +               ret = video_bridge_get_display_timing(bridge, &timing);
> > +               if (ret) {
> > +                       dev_err(dev, "Failed to read timings: %d\n", ret);
> > +                       return ret;
> > +               }
> > +       } else {
> > +               disp_uc_plat = dev_get_uclass_plat(disp);
> > +               debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
> > +               if (display_in_use(disp)) {
> > +                       debug("   - device in use\n");
> > +                       return -EBUSY;
> > +               }
> >
> > -       ret = display_read_timing(disp, &timing);
> > -       if (ret) {
> > -               debug("%s: Failed to read timings\n", __func__);
> > -               return ret;
> > +               disp_uc_plat->source_id = vop_id;
> > +               disp_uc_plat->src_dev = dev;
> > +
> > +               ret = device_probe(disp);
> > +               if (ret) {
> > +                       debug("%s: device '%s' display won't probe (ret=%d)\n",
> > +                             __func__, dev->name, ret);
> > +                       return ret;
> > +               }
> > +
> > +               ret = display_read_timing(disp, &timing);
> > +               if (ret) {
> > +                       debug("%s: Failed to read timings\n", __func__);
> > +                       return ret;
> > +               }
> >         }
> >
> >         /* Set clock rate on video port to display timings */
> > @@ -453,9 +481,18 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
> >
> >         rkvop2_mode_set(dev, &timing, vop_id, port_id, platdata);
> >
> > -       ret = display_enable(disp, 1 << l2bpp, &timing);
> > -       if (ret)
> > -               return ret;
> > +       if (bridge) {
> > +               /* Attach the DSI controller and the display to the bridge. */
> > +               ret = video_bridge_set_backlight(bridge, 60);
> > +               if (ret) {
> > +                       dev_err(dev, "Failed to start the video bridge: %d\n", ret);
> > +                       return ret;
> > +               }
> > +       } else {
> > +               ret = display_enable(disp, 1 << l2bpp, &timing);
> > +               if (ret)
> > +                       return ret;
> > +       }
> >
> >         uc_priv->xsize = timing.hactive.typ;
> >         uc_priv->ysize = timing.vactive.typ;
> >
> > --
> > 2.51.2
> >
> >
