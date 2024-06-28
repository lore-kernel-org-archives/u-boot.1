Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A09EC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 15:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B17388239;
	Fri, 28 Jun 2024 17:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF7A0879AF; Fri, 28 Jun 2024 17:17:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 67E9588239
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 17:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BBD4106F;
 Fri, 28 Jun 2024 08:17:56 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2A2E3F73B;
 Fri, 28 Jun 2024 08:17:30 -0700 (PDT)
Date: Fri, 28 Jun 2024 16:17:27 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Marek
 Vasut <marex@denx.de>, John Watts <contact@jookia.org>
Subject: Re: [PATCH v2 2/2] usb: musb-new: sunxi: make compatible with
 UDC/DM gadget model
Message-ID: <20240628161727.5a2f6333@donnerap.manchester.arm.com>
In-Reply-To: <9716fa71-d010-4444-979f-d120c558426c@gmail.com>
References: <20230608195631.55364-1-CFSworks@gmail.com>
 <20230608195631.55364-3-CFSworks@gmail.com>
 <20240627160639.2353fd1e@donnerap.manchester.arm.com>
 <9716fa71-d010-4444-979f-d120c558426c@gmail.com>
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

On Thu, 27 Jun 2024 17:25:57 -0600
Sam Edwards <cfsworks@gmail.com> wrote:

Hi Sam,

thanks for coming back so quickly!

> On 6/27/24 09:06, Andre Przywara wrote:
> > On Thu,  8 Jun 2023 13:56:31 -0600
> > Sam Edwards <cfsworks@gmail.com> wrote:
> > 
> > Hi,
> > 
> > John asked me have a look at this.  
> 
> Hi Andre, it's good to hear from you again,
> 
> I'd first like to make sure you're aware that the date on this patch is 
> June *2023,* not June 2024. It's possible things have changed 
> substantially in the past year.

Not in the Allwinner MUSB driver, but indeed the gadget support in U-Boot
has changed since then.

> I do not know if this patch is still a 
> necessity; though if John is nudging about it, it probably is.

Yes apparently he needs it, though I am not entirely sure why.
USB gadget has worked for ages in sunxi, without DM_USB_GADGET support,
that's why I was a bit puzzled why this patch seems so important.

And secondly I was put off by John's initial reply that it would trigger
many USB errors for him. He later rectified it, but I must have missed
that message.

> >> Since many sunxi boards do not implement a `board_usb_init`, it's  
> > 
> > I am confused, what has this have to do with gadget support? *No* sunxi
> > board build provides board_usb_init(), but apparently this works fine for
> > now.
> > I am all for this converting to DM part, but the rationale seems a bit
> > off.  
> 
> For context, board_usb_init() is (was?) the non-DM entry point for USB 
> functionality;

I think board_usb_init() comes from the old days, to provide hooks in case
certain boards need something special to enable USB, like an extra
regulator, power domain or clock to toggle. These days this should all be
covered by DT properties, so we should not (and do not!) need it.
And there is an empty fallback implementation in common/usb.c.

> it is (was?) *the* implementation of 
> usb_gadget_initialize() when !DM_USB_GADGET.

Mmh, was that so? None of them seemed to call usb_gadget_initialize(),
though? I checked older releases, but usb_gadget_initialize() seemed to
have always been called by the respective gadget code (fastboot, ums,
ethernet)?

> > Also can you give some reason for this patch? What does this fix or
> > improve? "it's better" is a bit thin, "complying with DM" would already be
> > sufficient, but maybe there is more?  
> 
> Eh, yeah, "better" is something of a question-begging word isn't it? :)
> 
> The main point is to be compatible with DM's view of UDC, which as you 
> said is a worthy goal in itself. It's "better" because this allows using 
> DM's all-purpose implementation of usb_gadget_initialize(), which is 
> (was?) necessary for those targets lacking board_usb_init().

That's what triggered my confusion: there is no sunxi board as such that
implements board_usb_init(), and with our USB PHY code being DT driven, we
should not need it anyway.
There are empty fallback implementations in common/usb.c and
drivers/usb/gadget/g_dnl.c, and we pick up one of them, given the right
Kconfig symbols defined.

I just tried it: enabling the "ums" command, and it worked:

$ make orangepi_zero3_defconfig
$ scripts/config --enable CONFIG_CMD_USB_MASS_STORAGE
$ make olddefconfig
$ make

then, on the U-Boot prompt:
=> ums 0 mmc 0
and the SD card block device popped up on my host.

(That the ums command is useful enough to be enabled by default is a
separate story).
Gadget Ethernet and fastboot are even enabled by default, so whenever you
have a defconfig with CONFIG_USB_MUSB_GADGET=y, you should get this
functionality.

So can anyone tell why this patch is needed so desperately?

> >> better if we just make the sunxi USB driver compatible with the
> >> DM gadget model, as many other musb-new variants already are.
> >>
> >> This change has been verified working on a T113s.
> >>
> >> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> >> ---
> >>   drivers/usb/musb-new/sunxi.c | 50 +++++++++++++++++++++++-------------
> >>   1 file changed, 32 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
> >> index 510b254f7d..6658cd995d 100644
> >> --- a/drivers/usb/musb-new/sunxi.c
> >> +++ b/drivers/usb/musb-new/sunxi.c
> >> @@ -444,6 +444,16 @@ static struct musb_hdrc_config musb_config_h3 = {
> >>   	.ram_bits	= SUNXI_MUSB_RAM_BITS,
> >>   };
> >>   
> >> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)  
> > 
> > Please no more #ifdef's. Is there any reason to *not* force
> > DM_USB_GADGET now, for all sunxi boards, in Kconfig?
> > Either by "select"ing it in the USB Kconfig, or in arch/arm/Kconfig, like
> > other platforms do.
> > Then you don't need to care about the !DM_USB_GADGET definition of this
> > function and can drop the #ifdef.  
> 
> I wouldn't be the one to ask. I can't think of any such reason myself. 
> But to me it sounds like since *no sunxi board provides 
> board_usb_init()* the only way USB gadgets *could* work is with 
> DM_USB_GADGET? That'd be reason enough to force it.

See above.
So I think the only reason to *not* have DM_USB_GADGET in general is
because some driver is not ready for that yet, or there is some odd device
that requires some extra hacks that the DM implementation does not cover.

So with this patch we remove those reasons for sunxi, AFAICT. The Allwinner
MUSB driver is now DM ready, so there is no reason to not set it. Think of
it more as we are now declaring the sunxi MUSB driver as DM ready. That's
why I want to see it set unconditionally, as it's not a user choice per se.

Eventually this DM specific symbol will go away at some point, as it did
for other subsystems like Ethernet already.

> >> +int dm_usb_gadget_handle_interrupts(struct udevice *dev) {  
> > 
> > coding style  
> 
> Sentence fragments are harder to understand. I am assuming you are 
> saying, "Please put the opening '{' on its own line."

Funny enough I had these extra words, but then deleted them in fear it
would sound too patronising for this obvious typo ;-)

> >> +	struct sunxi_glue *glue = dev_get_priv(dev);
> >> +	struct musb_host_data *host = &glue->mdata;
> >> +
> >> +	host->host->isr(0, host->host);
> >> +	return 0;
> >> +}
> >> +#endif
> >> +
> >>   static int musb_usb_probe(struct udevice *dev)
> >>   {
> >>   	struct sunxi_glue *glue = dev_get_priv(dev);
> >> @@ -452,10 +462,6 @@ static int musb_usb_probe(struct udevice *dev)
> >>   	void *base = dev_read_addr_ptr(dev);
> >>   	int ret;
> >>   
> >> -#ifdef CONFIG_USB_MUSB_HOST
> >> -	struct usb_bus_priv *priv = dev_get_uclass_priv(dev);
> >> -#endif
> >> -
> >>   	if (!base)
> >>   		return -EINVAL;
> >>   
> >> @@ -486,23 +492,31 @@ static int musb_usb_probe(struct udevice *dev)
> >>   	pdata.platform_ops = &sunxi_musb_ops;
> >>   	pdata.config = glue->cfg->config;
> >>   
> >> -#ifdef CONFIG_USB_MUSB_HOST
> >> -	priv->desc_before_addr = true;
> >> +	if (IS_ENABLED(CONFIG_USB_MUSB_HOST)) {
> >> +		struct usb_bus_priv *priv = dev_get_uclass_priv(dev);
> >> +		priv->desc_before_addr = true;
> >>   
> >> -	pdata.mode = MUSB_HOST;
> >> -	host->host = musb_init_controller(&pdata, &glue->dev, base);
> >> -	if (!host->host)
> >> -		return -EIO;
> >> +		pdata.mode = MUSB_HOST;
> >> +		host->host = musb_init_controller(&pdata, &glue->dev, base);
> >> +		if (!host->host)
> >> +			return -EIO;
> >>   
> >> -	return musb_lowlevel_init(host);
> >> -#else
> >> -	pdata.mode = MUSB_PERIPHERAL;
> >> -	host->host = musb_register(&pdata, &glue->dev, base);
> >> -	if (IS_ERR_OR_NULL(host->host))
> >> -		return -EIO;
> >> +		return musb_lowlevel_init(host);
> >> +	} else if (CONFIG_IS_ENABLED(DM_USB_GADGET)) {
> >> +		pdata.mode = MUSB_PERIPHERAL;
> >> +		host->host = musb_init_controller(&pdata, &glue->dev, base);
> >> +		if (!host->host)
> >> +			return -EIO;
> >>   
> >> -	return 0;
> >> -#endif
> >> +		return usb_add_gadget_udc(&glue->dev, &host->host->g);
> >> +	} else {
> >> +		pdata.mode = MUSB_PERIPHERAL;
> >> +		host->host = musb_register(&pdata, &glue->dev, base);
> >> +		if (IS_ERR_OR_NULL(host->host))
> >> +			return -EIO;
> >> +
> >> +		return 0;
> >> +	}  
> > 
> > That looks like a good cleanup! Just need to test it briefly, but it seems
> > like the gist of this patch is fine.  
> 
> I think it would be wise to test it a little better than "briefly" given 
> the age of the patch. I'm not well-equipped to do any testing myself 
> right now or I'd volunteer.

So I gave it a spin on my OPi Zero 3. It seems to work(TM), although I
need to stop the connection to the Ethernet gadget:

=> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3af000
All UDCs in use (1 available), use the unbind command
g_dnl_register: failed!, error: -19
g_dnl_register failed
=> unbind ethernet 1
=> ums 0 mmc 0
=> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3af000
(works and waits at this point)

This seems like a quite annoying limitation, if anyone has an idea what
should be done here, I am all ears. Maybe dropping the default Ethernet
connection?

Thanks!
Andre

> > 
> >   
> >>   }
> >>   
> >>   static int musb_usb_remove(struct udevice *dev)  
> >   

