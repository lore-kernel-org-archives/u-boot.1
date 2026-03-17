Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726B8F3381B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 09:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C6F84120;
	Tue, 17 Mar 2026 10:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="sVkbxpWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A30AF8414B; Tue, 17 Mar 2026 10:20:54 +0100 (CET)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799F083DA7
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 10:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=TR+zoTCofV9+0y/7aG5f2LTbQaUo/UEBZPGuZDfK5Nk=;
 b=sVkbxpWfxWT1ySynuBBW9iCqGQ6u//g61mT3tqN4zqYyb44gAnmZJr0a9ZXn26oDtW1J/IcZcBKUEkn+7/Uycq/IW0HGyZgxWLfMQNf9M4OXuxtHtL7tPdh4QeuEVONHRZdphEdhKDmlc07tlf5eVOmoM4yh3hmmh2UeLa3q/x4pl7cUKYBeIJzNMBMU5b8xi8j3gQFOkZd4+f3dSYprdQYdlcKCuMSGdIXupA12dtsC492qv21IV4jg47
 4Nfh/XhUJVGPKeBTFiHcWkoNpS99EJqQgxWTmNcgvxV7FBwnhRu6FID0ToT3+HADzDTnF4/vUC8w4Ejicn1Y6PmWyFGQ==
Received: from GRAPHRT (188-24-192-137.rdsnet.ro [188.24.192.137])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Tue, 17 Mar 2026 09:20:41 +0000
Date: Tue, 17 Mar 2026 11:20:45 +0200
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] USB: dwc2: allow usb start even if usbphy is not found
Message-ID: <abkc7YaVNYXGR+jd@GRAPHRT>
References: <20260316092639.2377-1-m95d+git@psihoexpert.ro>
 <942c0020-e43d-4d86-b8c0-ccc8f7ed2b2c@kwiboo.se>
 <abgd9BByMlS6khBT@GRAPHRT>
 <822b68b9-e0a8-401f-a0b2-f4c66d1084d0@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822b68b9-e0a8-401f-a0b2-f4c66d1084d0@kwiboo.se>
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

On Mon, 2026-03-16 22.41.08 ++0100, Jonas Karlman wrote:
> Hi Marius,
> 
> On 3/16/2026 4:12 PM, Marius Dinu wrote:
> > On Mon, 2026-03-16 11.04.13 ++0100, Jonas Karlman wrote:
> >> Hi Marius,
> >>
> >> On 3/16/2026 10:26 AM, Marius Dinu wrote:
> >>> RK3288 uses rockchip_usb2_phy, but that driver doesn't register iself
> >>> as a usbphy driver and "usb start" fails with this error:
> >>>
> >>>   drivers/usb/host/dwc2.c:1254- dwc2_setup_phy() dwc2_usb usb@ff580000:
> >>>   Failed to get USB PHY: -19.
> >>>
> >>> Until a proper fix is made for rockchip_usb2_phy, this patch allows
> >>> usb start to continue even if usbphy is not found.
> >>>
> >>> Tested on Asus TinkerBoard.
> >>
> >> I am not seeing this issue on my TinkerBoard, what U-Boot version are
> >> you testing and have you made any config changes compared to
> >> tinker-rk3288_defconfig?
> > 
> > I'm using the github master branch pulled today + lots and lots of changes
> > in config. I didn't make a diff, but I expect it to be very very far from
> > tinker-rk3288_defconfig.
> > 
> >>
> >>   => usb start
> >>   starting USB...
> >>   USB DWC2
> >>   USB DWC2
> >>   Bus usb@ff540000: 2 USB Device(s) found
> >>   Bus usb@ff580000: 1 USB Device(s) found
> >>          scanning usb for storage devices... 0 Storage Device(s) found
> >>
> >>   => dm tree -e usb
> >>    Class     Seq    Probed  Driver                Name
> >>   -----------------------------------------------------------
> >>    usb           0  [ + ]   dwc2_usb              usb@ff540000
> >>    usb_hub       0  [ + ]   usb_hub               `-- usb_hub
> >>    usb_hub       1  [ + ]   usb_hub                   `-- usb_hub
> >>    usb           1  [ + ]   dwc2_usb              usb@ff580000
> >>    usb_hub       2  [ + ]   usb_hub               `-- usb_hub
> >>
> >> Have something changed recently that broke this?
> > 
> > Yes! but not exactly recently...
> > It broke since commit e17a4bf198510693967644c331ab621fc41ea8b5.
> > Here's a log on my system without my proposed fix. This is a log that I
> > saved while I was investigating the failed USB, about a year ago, I think.
> > But I checked and it still fails with today's git master, I just don't have
> > the time to enable all the debug options again. It's still ret -19 error.
> 
> I did a new runtime test on a Tinker Board R2.0 using master with
> tinker-rk3288_defconfig and I am not able to reproduce any issue. Maybe
> your config changes introduce a condition that causes an issue? Please
> share your savedefconfig.
> 
>
>
> I have re-run some tests with different Kconfig options related to
> GADGET and DWC2 and are not able to reproduce your issue.
> 
> As mentioned above, please share your config changes compared to tinker
> defconfig, maybe you have some Kconfig option enabled that make DWC2
> work differently?
> 
> 
>   U-Boot SPL 2026.04-rc4-00007-g010855c5005e (Mar 16 2026 - 21:33:53 +0000)
>   Trying to boot from RAM
>   ## Checking hash(es) for config conf-1 ... OK
>   ## Checking hash(es) for Image firmware-1 ... crc32+ OK
>   ## Checking hash(es) for Image fdt-1 ... crc32+ OK
>   spl_perform_arch_fixups: could not map BootROM boot device to ofpath
>   
>   
>   U-Boot 2026.04-rc4-00007-g010855c5005e (Mar 16 2026 - 21:33:53 +0000)
>   
>   SoC: Rockchip rk3288
>   Reset cause: POR
>   Model: Rockchip RK3288 Asus Tinker Board
>   DRAM:  2 GiB
>   PMIC:  RK808
>   Core:  221 devices, 27 uclasses, devicetree: separate
>   MMC:   mmc@ff0c0000: 1, mmc@ff0d0000: 2
>   Loading Environment from MMC... Card did not respond to voltage select! : -110
>   *** Warning - No block device, using default environment
>   
>   In:    serial,usbkbd
>   Out:   serial,vidconsole
>   Err:   serial,vidconsole
>   Net:   eth0: ethernet@ff290000
>   
>   Hit any key to stop autoboot: 0
>   => usb start
>   starting USB...
>   USB DWC2
>   USB DWC2
>   Bus usb@ff540000: 2 USB Device(s) found
>   Bus usb@ff580000: 1 USB Device(s) found
>          scanning usb for storage devices... 0 Storage Device(s) found
>   => usb tree
>   USB device tree:
>     1  Hub (480 Mb/s, 0mA)
>     |   U-Boot Root Hub
>     |
>     +-2  Hub (480 Mb/s, 100mA)
>           USB2.0 Hub
>   
>     1  Hub (480 Mb/s, 0mA)
>         U-Boot Root Hub
>   
>   => dm tree -e usb
>    Class     Seq    Probed  Driver                Name
>   -----------------------------------------------------------
>    usb           0  [ + ]   dwc2_usb              usb@ff540000
>    usb_hub       0  [ + ]   usb_hub               `-- usb_hub
>    usb_hub       1  [ + ]   usb_hub                   `-- usb_hub
>    usb           1  [ + ]   dwc2_usb              usb@ff580000
>    usb_hub       2  [ + ]   usb_hub               `-- usb_hub
>    pinconfig   130  [   ]   pinconfig             usb
>    pinconfig   131  [   ]   pinconfig             |-- host-vbus-drv
>    pinconfig   132  [   ]   pinconfig             `-- pwr-3g
>   =>
> 
> Regards,
> Jonas

I tested the tinkerboard defconfig. It does work. As far as I can tell, it
doesn't try to load the phy driver at all. The only significant difference
is that I didn't enable OTG/gadget in my config - it's just the usb-host
driver.

So the bug is still there, it's just that the OTG driver doesn't search for
a phy driver.

Marius


> 
> > 
> > Marius
> > 
> > PS: There is a duplicate of this email sent from the wrong address. Sorry.
> > 
> >>
> >> Anyway if something needs fixing it is probably rockchip_usb2_phy.
> >>
> >> Regards,
> >> Jonas
> >>
> >>>
> >>> Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
> >>> ---
> >>>  drivers/usb/host/dwc2.c | 5 ++---
> >>>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> >>> index 16f21fa9083..74d71f23d88 100644
> >>> --- a/drivers/usb/host/dwc2.c
> >>> +++ b/drivers/usb/host/dwc2.c
> >>> @@ -1329,7 +1329,7 @@ static int dwc2_usb_probe(struct udevice *dev)
> >>>  
> >>>  	ret = dwc2_setup_phy(dev);
> >>>  	if (ret)
> >>> -		return ret;
> >>> +		dev_dbg(dev, "Failed to setup PHY: %d. Continuing anyway...\n", ret);
> >>>  
> >>>  	return dwc2_init_common(dev, priv);
> >>>  }
> >>> @@ -1345,8 +1345,7 @@ static int dwc2_usb_remove(struct udevice *dev)
> >>>  
> >>>  	ret = dwc2_shutdown_phy(dev);
> >>>  	if (ret) {
> >>> -		dev_dbg(dev, "Failed to shutdown USB PHY: %d.\n", ret);
> >>> -		return ret;
> >>> +		dev_dbg(dev, "Failed to shutdown USB PHY: %d. Continuing anyway...\n", ret);
> >>>  	}
> >>>  
> >>>  	dwc2_uninit_common(priv->regs);
> >>
> > 
> 

