Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B227FC4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 23:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F5B9874CA;
	Mon, 27 Nov 2023 00:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964FB874BD; Mon, 27 Nov 2023 00:23:28 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1160C86E81
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 00:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C25352F4;
 Sun, 26 Nov 2023 15:24:10 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B30873F5A1;
 Sun, 26 Nov 2023 15:23:22 -0800 (PST)
Date: Sun, 26 Nov 2023 23:21:59 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Nils Le Roux <gilbsgilbert@gmail.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
Cc: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>
Subject: Re: [PATCH] net: designware: Support high memory nodes
Message-ID: <20231126232159.0627f20d@slackpad.lan>
In-Reply-To: <9c28e1d8-6306-4630-9049-52023efd1af5@gmail.com>
References: <20231111152619.95185-1-gilbsgilbert@gmail.com>
 <20231116232229.084127c9@slackpad.lan>
 <9c28e1d8-6306-4630-9049-52023efd1af5@gmail.com>
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

On Sun, 26 Nov 2023 16:58:52 +0100
Nils Le Roux <gilbsgilbert@gmail.com> wrote:

Hi Nils,

(adding back the list)

> Hi Andre,
> 
> Thank you for the code review and spot-on comments. I'll send a revised
> patch soon. In the meantime, I have some silly questions regarding your
> first point, please see below:
> 
> On 11/17/23 00:22, Andre Przywara wrote:
> > On Sat, 11 Nov 2023 16:26:14 +0100
> > Nils Le Roux <gilbsgilbert@gmail.com> wrote:
> > 
> > Hi Nils,
> >   
> >> Some platforms (such as the Lichee Pi 4A) have their dwmac device
> >> addressable only in high memory space. Storing the node's base address
> >> on 32 bits is not possible in such case.  
> > 
> > That's indeed true, so thanks for the patch.
> > Some comments below.
> >   
> >> Use platform's physical address type to store the base address.
> >>
> >> Signed-off-by: Nils Le Roux <gilbsgilbert@gmail.com>
> >> ---
> >>
> >>   drivers/net/designware.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> >> index a174344b3e..327732fbf7 100644
> >> --- a/drivers/net/designware.c
> >> +++ b/drivers/net/designware.c
> >> @@ -678,8 +678,8 @@ int designware_eth_probe(struct udevice *dev)
> >>   {
> >>   	struct eth_pdata *pdata = dev_get_plat(dev);
> >>   	struct dw_eth_dev *priv = dev_get_priv(dev);
> >> -	u32 iobase = pdata->iobase;
> >> -	ulong ioaddr;
> >> +	phys_addr_t iobase = pdata->iobase;
> >> +	phys_addr_t ioaddr;  
> > 
> > So I agree that iobase should be a phys_addr_t, since pdata->iobase is
> > of this type, but ioaddr seems to be a virtual address, not a physical
> > one. So either we make this a void*, or keep it at ulong.
> >   
> 
> How can you tell ioaddr is a virtual address?

Because the value gets assigned to the mac_regs_p and dma_regs_p
members of struct dw_eth_dev, and those are clearly pointers, and
they are dereferenced at some point.

> As far as I can see, it is
> only used as a temporary variable to hold iobase which is a physical

Well, this assignment is semantically problematic, but works in
practice, see below.

> address (that's how I inferred it should be the same type). Is virtual
> addressing a thing in U-Boot anyways, or are you just speaking of
> semantics? I feel like I'm missing something.

So conceptually U-Boot has the notion of virtual and physical addresses
being something different, but indeed most architectures only ever use
a 1:1 mapping when using the MMU, so in practice this doesn't fail.
There are exceptions, though, MIPS and some PowerPC builds on the
hardware side, and more prominently the sandbox.
So we have virt_to_phys() and phys_to_virt() to do conversions, even
though they just do casts for most architectures. grep'ing the code for
those functions might give you more hints.

So you should change the assignment to:
	ioaddr = phys_to_virt(iobase);
That might make it clearer what types are actually required.

> More directly: would it be wrong to remove the ioaddr variable and just
> set the registers pointers to iobase directly? Aren't they pointers to
> physical memory anyways?

It would work, and if you have a hardware driver that never runs on MIPS
or PPC you will get away with it. But it is of course much cleaner to
use the conversion functions.

Cheers,
Andre

> 
> Thank you again,
> Best regards,
> Nils
> 
> >>   	int ret, err;
> >>   	struct reset_ctl_bulk reset_bulk;
> >>   #ifdef CONFIG_CLK
> >> @@ -740,7 +740,7 @@ int designware_eth_probe(struct udevice *dev)
> >>   	 * or via a PCI bridge, fill in plat before we probe the hardware.
> >>   	 */
> >>   	if (IS_ENABLED(CONFIG_PCI) && device_is_on_pci_bus(dev)) {
> >> -		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, &iobase);
> >> +		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, (u32 *)&iobase);  
> > 
> > This looks sketchy, relies on little endian, and assumes that iobase
> > has been initialised to 0 before. Since the read is explicitly 32 bits
> > wide, I'd declare a new local u32 variable (inside this if-statement)
> > and read it into there, then assign this to iobase.
> >   
> >>   		iobase &= PCI_BASE_ADDRESS_MEM_MASK;
> >>   		iobase = dm_pci_mem_to_phys(dev, iobase);
> >>   
> >> @@ -748,7 +748,7 @@ int designware_eth_probe(struct udevice *dev)
> >>   		pdata->phy_interface = PHY_INTERFACE_MODE_RMII;
> >>   	}
> >>   
> >> -	debug("%s, iobase=%x, priv=%p\n", __func__, iobase, priv);
> >> +	debug("%s, iobase=%llx, priv=%p\n", __func__, (u64)iobase, priv);  
> > 
> > This assumes that u64 is always %llx, which is not universally true.
> > Fortunately we have %pa for that (see doc/develop/printf.rst), so you
> > can just use this and drop the cast.
> > 
> > Cheers,
> > Andre
> >   
> >>   	ioaddr = iobase;
> >>   	priv->mac_regs_p = (struct eth_mac_regs *)ioaddr;
> >>   	priv->dma_regs_p = (struct eth_dma_regs *)(ioaddr + DW_DMA_BASE_OFFSET);  
> >   

