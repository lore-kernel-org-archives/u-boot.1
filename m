Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32FCC3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 22:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B714C88406;
	Mon, 15 Jul 2024 00:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF3F787E15; Mon, 15 Jul 2024 00:25:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7D7E2885C5
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 00:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D85F7FEC;
 Sun, 14 Jul 2024 15:25:40 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE8B93F762;
 Sun, 14 Jul 2024 15:25:14 -0700 (PDT)
Date: Sun, 14 Jul 2024 23:23:02 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: John Watts <contact@jookia.org>
Cc: Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de, Jagan Teki
 <jagan@amarulasolutions.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 2/2] usb: musb-new: sunxi: make compatible with
 UDC/DM gadget model
Message-ID: <20240714232302.46020b84@minigeek.lan>
In-Reply-To: <Zn7jNspTDhqJtZp9@titan>
References: <20230608195631.55364-1-CFSworks@gmail.com>
 <20230608195631.55364-3-CFSworks@gmail.com>
 <20240627160639.2353fd1e@donnerap.manchester.arm.com>
 <9716fa71-d010-4444-979f-d120c558426c@gmail.com>
 <20240628161727.5a2f6333@donnerap.manchester.arm.com>
 <Zn7jNspTDhqJtZp9@titan>
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

On Sat, 29 Jun 2024 02:22:14 +1000
John Watts <contact@jookia.org> wrote:

Hi,

> On Fri, Jun 28, 2024 at 04:17:27PM +0100, Andre Przywara wrote:
> > > I do not know if this patch is still a 
> > > necessity; though if John is nudging about it, it probably is.  
> > 
> > Yes apparently he needs it, though I am not entirely sure why.
> > USB gadget has worked for ages in sunxi, without DM_USB_GADGET support,
> > that's why I was a bit puzzled why this patch seems so important.
> > 
> > And secondly I was put off by John's initial reply that it would trigger
> > many USB errors for him. He later rectified it, but I must have missed
> > that message.  
> 
> This patch is necessary for gadget to work on the T113 board I have.
> Without it I get this error during fastboot:
> 
> Controller uninitialized
> g_dnl_register: failed!, error: -6

So I dug into this, and this is what I think is going on:

If you add "CONFIG_USB_MUSB_GADGET=y" to your *defconfig*, it should
work. If you just enable it via menuconfig or by editing .config, it
will not. Adding CONFIG_USB_ETHER to the mix should fix this.
This symbol is automatically selected in Kconfig when it sees
USB_MUSB_GADGET, but apparently only during a defconfig run, it's not
selected during the other methods. Not sure what causes this difference
in behaviour, but I have seen this in U-Boot before.

That being said: this is of course not a proper solution, the DM
support proposed in that patch is the right way to go, but it should
explain why it works for me, but not for you.

As for this patch: the problem is where the Ethernet gadget code
apparently grabs the UDC device, without actually using it already. This
prevents other gadgets like ums to be used, without unbinding the
Ethernet gadget with a non-obvious command first.
So I think we need a solution for this first, otherwise the user
experience would suffer.

Cheers,
Andre

