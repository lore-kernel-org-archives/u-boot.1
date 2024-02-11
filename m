Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8445C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 23:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F269F87775;
	Mon, 12 Feb 2024 00:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88E687C94; Mon, 12 Feb 2024 00:25:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id F153F874ED
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 00:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1B90DA7;
 Sun, 11 Feb 2024 15:26:25 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6E853F5A1;
 Sun, 11 Feb 2024 15:25:42 -0800 (PST)
Date: Sun, 11 Feb 2024 23:24:32 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Samuel Holland <samuel@sholland.org>,
 u-boot@lists.denx.de, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Ondrej Jirman <megi@xff.cz>, Arnav Singh <me@arnavion.dev>, Samuel
 Dionne-Riel <samuel@dionne-riel.com>
Subject: Re: [PATCH RFC] sunxi: pinephone: detect existed magnetometer and
 fixup dtb
Message-ID: <20240211232432.102d8e43@minigeek.lan>
In-Reply-To: <ZclMbBOOxav9yC-X@skv.local>
References: <20240211092824.395155-1-andrej.skvortzov@gmail.com>
 <20240211131251.797abb61@minigeek.lan> <ZclMbBOOxav9yC-X@skv.local>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Mon, 12 Feb 2024 01:38:36 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

> thank you for the valuable feedback!
> 
> On 24-02-11 13:13, Andre Przywara wrote:
> > On Sun, 11 Feb 2024 12:28:24 +0300
> > Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > 
> > Hi Andrey,
> > 
> > thanks for taking care of this upstream!
> >   
> > > In newer 1.2 PinePhone board revisions LIS3MDL magnetometer was replaced by
> > > AF8133J. They use the same PB1 pin in different modes.  
> 
> > > 
> > > AF8133J's driver isn't upstreamed yet, but it will be soon. Therefore this
> > > is RFC patch. I'd like to know whether selected approach will be accepted
> > > in u-boot before submiting coresponding dts changes to the Linux kernel.
> > > Any feedback on this change would be very welcome.  
> > 
> > So I think this is the right approach: Since the SPL has no use of this
> > device, and it's a rather small DT change, we definitely want to do this
> > in U-Boot proper. And I believe that U-Boot (proper) is indeed the best
> > place to do those adjustments, since it's built for one board anyway,
> > so anything board specific belongs into there (and not into TF-A or the
> > SPL, which are more tailored to one *SoC*). Also we are not so size
> > sensitive in proper.
> > And I also like the fact that it's protected by a board specific
> > definition, and even better that it's an already existing one.
> > 
> > Oh, and I am not really convinced this is the right approach here, but
> > maybe have a look at doc/usage/cmd/extension.rst, for another related
> > mechanism.  
> 
> Thanks for the tip. I've looked at it after your suggestion and tried
> to implement the same logic using extension command. Here are my
> thoughts about that:
> 
> 1. integrated magnetometer is part of the device and making it
> extension with separate dtbo sounds a bit strange.
> 
> 2. if I'd create dtbo for new AF8133J magnetometer, then I'd call it
> like other dts files for the device:
> 'sun50i-a64-pinephone-1.2-af8133j.dtbo. This is 38 characters and 
> currently overlay name is limited to 32 bytes. What do you think about
> increasing overlay name?
> 
> 3. extensions are not supported for extlinux boot flow at all. This is Debian
> case, that I'm working with. And this is a major problem for me.
> 
> 4. I've looked how EFI boot flow is made and I see that extensions are
> not applied to fdtcontroladdr, only to loaded fdt to
> fdt_addr_r. Extlinux uses fdtcontroladdr always.
> 
> 5. When distribution supplies fdt with extlinux, when supplied fdt is
> used and no extensions are applied to it. This is my case as well.
> 
> 6. I can't apply extensions to fdtcontroladdr. When I've tried to
> apply working extension to fdtcontroladdr, then I get a crash.
> I have to copy fdt from fdtcontroladdr to fdt_addr_r
> and then apply extension to fdt_addr_r and when it works. Maybe this
> is something sunxi-specific.

Not really. The DTB is appended to the end of the U-Boot image, and I
believe there is something important immediately after it, like the
heap or the gd or something. Some years back this used to work, but not
anymore, for quite a while now.
So to apply overlays, do a "fdt move $fdtcontroladdr $fdt_addr_r"
first, then use $fdt_addr_r.
But that's just for clarification, nothing that solves the above
problems.

> Overall extensions seems like a nice feature for capes, extension boards for
> pogo pins and so on. But I'm not sure, that it's the right choice in
> this case.

Yeah, many thanks for the extensive research and nice summary! I was
already expecting something along those lines, but wasn't sure. So
thanks for saving me some time.

This confirms that we should go the route you already sketched.

> > Some smaller comments below ...
> >   
> > > 
> > >  board/sunxi/board.c         | 26 ++++++++++++++++++++++++++
> > >  configs/pinephone_defconfig |  1 +
> > >  2 files changed, 27 insertions(+)
> > > 
> > > diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> > > index 1305302060..a4bfa24400 100644
> > > --- a/board/sunxi/board.c
> > > +++ b/board/sunxi/board.c
> > > @@ -15,6 +15,7 @@
> > >  #include <dm.h>
> > >  #include <env.h>
> > >  #include <hang.h>
> > > +#include <i2c.h>
> > >  #include <image.h>
> > >  #include <init.h>
> > >  #include <log.h>
> > > @@ -920,6 +921,28 @@ static void bluetooth_dt_fixup(void *blob)
> > >  			   "local-bd-address", bdaddr, ETH_ALEN, 1);
> > >  }
> > >  
> > > +#ifdef CONFIG_PINEPHONE_DT_SELECTION  
> > 
> > Can you move that line into the function? That would for one avoid the
> > protection in the caller below, and secondly make it easier to add
> > other boards, if a need arises for them. The two #defines don't hurt or
> > change the code, so just keep them outside.  
> 
> > > +
> > > +#define PINEPHONE_LIS3MDL_I2C_ADDR	0x1E
> > > +#define PINEPHONE_LIS3MDL_I2C_BUS	1 /* I2C1 */
> > > +
> > > +static	void board_dt_fixup(void *blob)
> > > +{
> > > +	struct udevice *bus, *dev;
> > > +  
> > 
> > (have the #ifdef here)  
> 
> Ok, then I mark local variables with __maybe_unused and remove #ifdef
> at board_dt_fixup call.

Ah right, there are warnings.
I've got an even better idea, use:
      if (IS_ENABLED(CONFIG_PINEPHONE_DT_SELECTION) &&
          !fdt_node_check_compatible(blob, 0, "pine64,pinephone-1.2")) {

Then you can keep the variables without the tag, and avoid the #ifdef
altogether. The compiler optimises this away, for an unrelated board
"size board.o" reports exactly the same numbers.

> > > +	if (!fdt_node_check_compatible(blob, 0, "pine64,pinephone-1.2"))  
> > 
> > Please have curly braces around that.  
> 
> I'll fix that in v2. 
> 
> > So I'd say please send the (disabled) DT node addition patch to the
> > kernel MLs, then send this patch to U-Boot.  
> 
> Do you mean patch with disabled AF8133J DT node? Right?
> If so, then it was the plan.
> 
> 1. upstream AF8133J driver to the Linux kernel (on-going)
> 2. find acceptable solution for u-boot to handle different
>    magnetometers (on-going in this thread) 
> 3. upstream necessary dts changes to the Linux kernel

I'd say we settled 2., so feel free to append the DT change to the
series in 1), or send it as a follow-up patch if it's out there already.
This gives us also a user in the kernel DT tree.
You should add a comment to the disabled node, that this will be fixed
up in firmware.

Thanks,
Andre

> 4. upstream previously discussed changes to u-boot.
> 
> 
> > 
> > Cheers,
> > Andre
> >   
> > > +		if (!uclass_get_device_by_seq(UCLASS_I2C, PINEPHONE_LIS3MDL_I2C_BUS, &bus)) {
> > > +			dm_i2c_probe(bus, PINEPHONE_LIS3MDL_I2C_ADDR, 0, &dev);
> > > +			fdt_set_status_by_compatible(
> > > +				blob, "st,lis3mdl-magn",
> > > +				dev ? FDT_STATUS_OKAY  : FDT_STATUS_DISABLED);
> > > +			fdt_set_status_by_compatible(
> > > +				blob, "voltafield,af8133j",
> > > +				dev ? FDT_STATUS_DISABLED : FDT_STATUS_OKAY);
> > > +		}
> > > +}
> > > +#endif
> > > +
> > >  int ft_board_setup(void *blob, struct bd_info *bd)
> > >  {
> > >  	int __maybe_unused r;
> > > @@ -934,6 +957,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> > >  
> > >  	bluetooth_dt_fixup(blob);
> > >  
> > > +#ifdef CONFIG_PINEPHONE_DT_SELECTION
> > > +	board_dt_fixup(blob);
> > > +#endif  
> 
> I'll remove #ifdef here to make code a bit cleaner. I've applied all
> your suggestions and make it available here [1].
> 
> > >  #ifdef CONFIG_VIDEO_DT_SIMPLEFB
> > >  	r = sunxi_simplefb_setup(blob);
> > >  	if (r)
> > > diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> > > index eebc676901..457e7ee1e7 100644
> > > --- a/configs/pinephone_defconfig
> > > +++ b/configs/pinephone_defconfig
> > > @@ -12,6 +12,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
> > >  CONFIG_PINEPHONE_DT_SELECTION=y
> > >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> > >  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> > > +CONFIG_SYS_I2C_MVTWSI=y
> > >  CONFIG_LED_STATUS=y
> > >  CONFIG_LED_STATUS_GPIO=y
> > >  CONFIG_LED_STATUS0=y  
> >   
> 
> 1. https://github.com/AndreySV/u-boot/commit/84a9f1c14d1850c5559c5d888c814eee8886b04f
> 

