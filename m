Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB8FC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 21:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D96858129B;
	Mon, 21 Apr 2025 23:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112308129F; Mon, 21 Apr 2025 23:30:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 90FD381273
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 23:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94CC112FC;
 Mon, 21 Apr 2025 14:30:37 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8772E3F59E;
 Mon, 21 Apr 2025 14:30:40 -0700 (PDT)
Date: Mon, 21 Apr 2025 22:29:39 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, Yixun Lan
 <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/3] sunxi: add "fake" FEL pin support
Message-ID: <20250421222939.69832f73@minigeek.lan>
In-Reply-To: <b7ffc468-1970-4eba-85e1-47aaced0161a@cherry.de>
References: <20250417000539.3709-1-andre.przywara@arm.com>
 <20250417000539.3709-3-andre.przywara@arm.com>
 <b7ffc468-1970-4eba-85e1-47aaced0161a@cherry.de>
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

On Fri, 18 Apr 2025 13:28:23 +0200
Quentin Schulz <quentin.schulz@cherry.de> wrote:

Hi Quentin,

thanks for having a look!

> Hi Andre,
> 
> On 4/17/25 2:05 AM, Andre Przywara wrote:
> > Some boards with Allwinner SoCs feature a "FEL" key, sometimes also
> > labelled "uboot", which triggers the BootROM FEL mode, when pressed upon
> > power-on or reset. This allows to access the SoC's memory via USB OTG,
> > and to upload and execute code. There is a tool to upload our U-Boot image
> > and immediately boot it, when the SoC is in FEL mode.
> > 
> > To mimic this convenient behaviour on boards without such a dedicated key,
> > we can query a GPIO pin very early in the SPL boot, then trigger the
> > BootROM FEL routine.  There has not been much of a SoC or board setup at
> > this point, so we enter the BROM in a rather pristine state still. On
> > 64-bit SoCs the required AArch32 reset guarantees a clean CPU state anyway.
> > 
> > Any GPIO can be used for that, the signal is expected to be active low,
> > consequently we enable the pull-up resistors for that pin. A board (or a
> > user) is expected to specify the GPIO name using the
> > CONFIG_SUNXI_FAKE_FEL_PIN Kconfig variable. When this variable is not set,
> > the compiler will optimise away the call.
> > 
> > Call the code first thing in board_init_f(), which is the first sunxi
> > specific C routine.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >   arch/arm/mach-sunxi/Kconfig | 10 ++++++++++
> >   arch/arm/mach-sunxi/board.c | 31 +++++++++++++++++++++++++++++++
> >   2 files changed, 41 insertions(+)
> > 
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index ab432390d3c..f1cfdb548bc 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -825,6 +825,16 @@ config USB3_VBUS_PIN
> >   	---help---
> >   	See USB1_VBUS_PIN help text.
> >   
> > +config SUNXI_FAKE_FEL_PIN
> > +	string "fake FEL GPIO pin"
> > +	default ""
> > +	---help---
> > +	Define a GPIO that shall force entering FEL mode when a button
> > +	connected to this pin is pressed at boot time. This must be an
> > +	active low signal, the internal pull-up resistors are activated.
> > +	This takes a string in the format understood by sunxi_name_to_gpio,
> > +	e.g. PH1 for pin 1 of port H.
> > +  
> 
> Why not use the DT for that? Then you wouldn't even need to assume the 
> polarity of the signal or whether pull-up/downs need to be activated, etc.

As Yixun Lan already pointed out, the DT is not available at this
point, and doing several pull-ups to get this information from the DT
into the SPL image are really over the top for this purpose.
This is more a sweet hacker device: I often have devices with eMMC and
SPI flash, but without a FEL button. So the idea was to just pick a
GPIO and use menuconfig to set it. Then I could just connect this pin
to GND during boot, to get into FEL and test-boot firmware. "Connect to
GND" could really be a jumper or even the tip of a screwdriver ;-)
So I don't think this qualifies to being defined in the DT, really.

> You can have the property in the -u-boot.dtsi then if you want?
> 
> While the FEL button on the X96 is "fake", it does what it says, just in 
> software, maybe that is close enough to "hardware definition" which 
> would make it suitable for the DT (well, we also store binman nodes in 

Yes, I have a patch to add this particular button as a GPIO button into
the DT, so people can use it for whatever they want in Linux (trigger
reboot, update, you name it). But this is rather orthogonal to this
problem, as mentioned above.

> the DT, which aren't strictly speaking hardware definition either :) ).

Please don't get me started on this, we don't need to make it worse ;-)

Cheers,
Andre
