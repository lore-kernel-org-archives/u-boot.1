Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E69FC4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 12:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 781E587214;
	Sun, 26 Nov 2023 13:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E99F786501; Sun, 26 Nov 2023 13:35:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6831587252
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 13:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9576DA7;
 Sun, 26 Nov 2023 04:35:52 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8B2E3F6C4;
 Sun, 26 Nov 2023 04:35:04 -0800 (PST)
Date: Sun, 26 Nov 2023 12:33:51 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Bob McChesney <bob@electricworry.net>
Cc: electricworry <worryelectric@gmail.com>, u-boot@lists.denx.de,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, Mikhail
 Kalashnikov <iuncuim@gmail.com>, Jernej =?UTF-8?B?xaBrcmFiZWM=?=
 <jernej.skrabec@gmail.com>
Subject: Re: Adding support for Orange Pi Zero 3
Message-ID: <20231126123351.7275f4c7@slackpad.lan>
In-Reply-To: <ZWMs0z6ED1ukmRGU@BOB1>
References: <CABZPTZSQHhcVuqLmg6nEiKBfF4p+R+y5sDCGaa19qztSEs54BA@mail.gmail.com>
 <20231123151709.64002286@donnerap.manchester.arm.com>
 <ZWMs0z6ED1ukmRGU@BOB1>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Sun, 26 Nov 2023 11:32:35 +0000
Bob McChesney <bob@electricworry.net> wrote:

Hi Bob,

thanks for the reply!

CC:ing Jernej for the THS SRAM issue and the HDMI support mentioned
below.

> On Thu, Nov 23, 2023 at 03:17:09PM +0000, Andre Przywara wrote:
> > On Sat, 4 Nov 2023 19:17:44 +0000
> > electricworry <worryelectric@gmail.com> wrote:
> > 
> > Hi,
> >   
> > > I would like to contribute improvements u-boot to enable support for
> > > the Orange Pi Zero 3 board. I have already gained a good understanding
> > > of the project and the standards for changes, and so I have made
> > > modifications and tested them on my board.  
> > 
> > thanks for your interest and for reaching out!
> > 
> > I will answer your questions below, but for this particular topic there
> > are already support patches on the list (sorry for the disappointment!):
> > https://lore.kernel.org/u-boot/20231114013106.31336-1-andre.przywara@arm.com/  
> 
> That's good. I'm happy that more experienced people have been working on
> this. It's been a good learning experience nevertheless.
> 
> > Can you please apply those patches on top of mainline U-Boot and test
> > them? Then reply to patch 3/3 above with a Tested-by: line, stating your
> > name and email address?
> > Having independent reports of that working would make me more confident in
> > merging the series.  
> 
> I'm happy to do that and will be able to do it shortly. In this case
> would I be applying the patches on top of the next branch?

The normal master branch would be safer. I don't typically work on the
next branch, and there might be changes in there which subtly break
sunxi.
 
> > As a general advice: try to reach out early, to avoid working in parallel
> > on something, and also to avoid working in the wrong direction.
> > There is the #linux-sunxi IRC channel on the OFTC IRC network[1] (you can
> > join via any browser), also there is a mailing list for Allwinner related
> > upstream work: linux-sunxi@lists.linux.dev [2]
> > Another resource is our wiki: https://linux-sunxi.org
> > 
> > [1] https://www.oftc.net/WebChat/
> >     https://oftc.irclog.whitequark.org/linux-sunxi
> > [2] https://subspace.kernel.org/lists.linux.dev.html  
> 
> Thank you. I wasn't aware of this community and have been working alone.
> It will be more productive to work and discuss with others so I'll join
> that mailing list too.

Yeah, the IRC chat is the most responsive and most helpful, I find, so
try to join that.

> 
> > > Before submitting patches for review I've got a few questions I'd like
> > > to discuss.
> > > 
> > > The board is an Allwinner H618. From what I can gather this is just an
> > > H616 with minor changes. The changes are so minor that I've been able
> > > to implement the support as changes to the existing files for H616.  
> > 
> > Just curious, what changes did you find in particular? So far we know
> > about the increased L2 cache, which is irrelevant from a software support
> > perspective, and the change of base address and layout of the CPUX_CFG
> > block, which is already covered by:
> > https://source.denx.de/u-boot/u-boot/-/commit/0a137ac5015933bf38ea2700abe70602ef63bbdd
> > Did you find anything else?  
> 
> I am not what anyone could call a hardware expert so I've just been
> working by diffing the codebase from the vendor against u-boot mainline.

Most of us are indeed curious software developers, and we typically do
a mixture of looking at vendor code, checking manuals, and doing live
experiments to figure things out.

> Changes that I've created patches for include their full dtb, the LPDDR4
> support, the AXP313A power, and - perhaps incorrectly - zeroing a
> register so that the thermal driver in the kernel works properly and
> doesn't get false high temperature readings.

Ah, glad I am not the only one seeing this!
I strangely haven't seen this all the time, but I indeed now need to do
a "mw.l 0x3000000 0x7ffeffff" in U-Boot, otherwise I see the kernel
screaming about +200C temperatures.

> I say "perhaps incorrectly"
> because I feel like the kernel driver should be doing that work itself
> and the comment in the vendor u-boot code suggests it's a hack: "The
> bit[16] of register reg[0x03000000] must be zero for the THS driver to
> work properly in the kernel. The BSP u-boot is putting the whole
> register to zero so we are doing the same."

Very good, you are exactly on the same path as I am! I have a patch for
the THS driver that tries to clear the bit, via using the regmap
exported by syscon, but I need to test this further (was my plan for
today). I think this was somehow not working properly the last time I
checked.
Another approach was trying to claim an SRAM region - as this is what
this register does for the video engine (VE). I figured that apparently
just bit 0 switches the SRAM to the VE, and flipping all 31 bits might
be some anachronism from the olden A10 days.
So we might claim that bit 16 switches the SRAM for THS, but then I am
not sure it really has something to do with SRAM, or if it's just
another Allwinner special of "oh, we have an unused bit in this
register" ;-)
We will see what the list has to say about this.

> > Out of interest, how did you do this? Disassembled the vendor boot0?
> > Dumping DRAM registers? We discussed and tested the LPDDR4 support already
> > a while ago, and support for that was merged recently:
> > https://source.denx.de/u-boot/u-boot/-/commit/4b02f0120a4bb2a5d7081aef8cef6a4ca57e9db2  
> 
> As above, I didn't do anything clever like probe hardware or
> disassemble binaries; it was just a brute force loop of cherry-picking,
> compiling and testing. And also doing it in a way that fitted the
> incumbent style and practices of mainline. e.g. making use of configs
> like CONFIG_DRAM_SUN50I_H616_DX_ODT for the board family rathern than
> having board specific ifdefs. The work done is available if anyone wants
> to see it, and I'd be happy to have it critiqued. Looking at the patches
> proposed here I'm happy to see that we've come to the same conclusion on
> some things (such as the above config) and others we diverge on, but as
> I can see from the discussion in linux-sunxi the feeling is that some of
> these difference don't matter.
> 
> > Hope that helps!
> > 
> > Cheers,
> > Andre  
> 
> Thanks for all of that good advice. It's immensely appreciated. I'll
> keep this as a guide for contibuting patches in the future.
> 
> Now that there's a working u-boot for the board - I've got two to choose
> from now :) - I'm going to be concentrating on trying to get the Mali
> graphics working as it's a requirement for my project. I've got a
> working kernel (6.1.31 with patches) but I can also see that work's been
> underway to bring the support to 6.7. I tested 6.7-rc2 today and can't
> get any output at all on the console after u-boot starts the kernel.

Yeah, that's because we don't have any video (HDMI) output support
(something completely unrelated to Mali, which is just a 3D renderer!)
yet in mainline. Jernej was sitting on *some* patches for a while, but
didn't have the time to upstream them, and IIUC there is something odd
to fix first before it's mainline ready.
There are some rough bits in here, and in other repos floating around:
https://github.com/jernejsk/linux-1/commits/h616-hdmi-v2

Cheers,
Andre
