Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AE7CA0ED2
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 22:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A5486F19;
	Tue, 12 Sep 2023 00:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BDB086F1E; Tue, 12 Sep 2023 00:16:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ABAC886EF6
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 00:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1619D75;
 Mon, 11 Sep 2023 15:16:56 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 718713F5A1;
 Mon, 11 Sep 2023 15:16:18 -0700 (PDT)
Date: Mon, 11 Sep 2023 23:15:10 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Hans de Goede <hdegoede@redhat.com>,
 u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>, Jarrah Gosbell
 <kernel@undef.tools>, Jernej =?UTF-8?B?xaBrcmFiZWM=?=
 <jernej.skrabec@gmail.com>, Vagrant Cascadian <vagrant@debian.org>, Jonas
 Smedegaard <dr@jones.dk>
Subject: Re: [PATCH] sunxi: board: provide CPU idle states to loaded OS
Message-ID: <20230911231510.46b248ac@slackpad.lan>
In-Reply-To: <ZPjm30KGDpY30D7k@skv.local>
References: <20230904205430.1647654-1-andrej.skvortzov@gmail.com>
 <20230905092712.6ba245bb@donnerap.manchester.arm.com>
 <ZPboy228t8rVajL8@skv.local> <20230906011232.05ee691a@slackpad.lan>
 <ZPjm30KGDpY30D7k@skv.local>
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

On Wed, 6 Sep 2023 23:53:51 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

we seem to have a very different approach to the whole booting process,
which makes this conversation quite involved.

I understand how things have been traditionally handled in the past, in
the embedded world (DTBs bundled with the kernel, distros installing
boot firmware), but we should really move on from this ill-fated
approach. For a while now we try hard to keep the DTs compatible across
several kernel version, making only compatible changes. In particular I
have been deliberately keeping compatibility with pre-v5.13 kernels in
the U-Boot copy of the Allwinner DTs, so you can always take the latest
version and boot that with a wide range of kernels.

> On 23-09-06 01:12, Andre Przywara wrote:
> > On Tue, 5 Sep 2023 11:37:31 +0300
> > Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > 
> > Hi,
> >   
> > > On 23-09-05 09:27, Andre Przywara wrote:  
> > > > On Mon,  4 Sep 2023 23:54:30 +0300
> > > > Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > > > 
> > > > Hi Andrey,
> > > >     
> > > > > When using SCPI as the PSCI backend, firmware can wake up the CPUs and
> > > > > cluster from sleep, so CPU idle states are available for loaded OS to
> > > > > use. TF-A modifies DTB to advertise available CPU idle states, when
> > > > > SCPI is detected. This change copies nodes added by TF-A to any new
> > > > > dtb that is used for loaded OS.    
> > > > 
> > > > Why do you need that, exactly? Why not just use $fdtcontroladdr for the
> > > > kernel? We now keep the U-Boot copy of the .dts files in sync with the
> > > > kernel. If you need to modify the DT in U-Boot, for instance by applying
> > > > overlays, you can copy that DTB into a better suitable location first:    
> > > > => fdt move $fdtcontroladdr $fdt_addr_r    
> > > > 
> > > > In any case, there shall be only one DT, that one in the U-Boot image. Why
> > > > do you need to load another one for the kernel?    
> > > 
> > > extlinux is used by distributions (sometimes with device-specific changes especially  
> > 
> > What distros are that? I guess some special ones, targeting embedded
> > devices, like the Pinephone?  
> 
> It's more likely universal operating system. In my particular case
> this is Mobian (several device-specific packages on top of
> Debian). It's very-very close to Debian with a goal to be
> pure Debian in the near future.
> 
> Rhino Linux is using extlinux as well and will benefit for this change
> as well.

We seem to have a very different understanding of "universal operating
systems" ;-)
You seem to talk about specific distros for embedded devices, whereas I
think of Ubuntu/Debian/Fedora/Arch/you-name-it.

And I still don't understand what a particular distribution has to do
with that: this is purely a question of boot firmware and who provides
the DTB.

> > And who is generating extlinux.conf then? Is that some distro specific
> > scripting, similar to how grub is configured?  
> 
> extlinux.conf is automatically generated by standard Debian
> u-boot-menu package. See [1] and [2]. 

Ah, thanks, I was looking for the extlinux package, which only seems to
exist for x86.

> > Honest questions, I am not a user of extlinux, I mostly use UEFI
> > booting, or type U-Boot commands directly for experiments, or use
> > boot.scr, as a quick-and-dirty hack.  
> 
> 
> > > for platforms not fully supported by mainline yet),  
> > 
> > Do you need any changes to the DT? Do you need to apply overlays?
> > If you run on a non-mainlined platform, you could still put your DT
> > into the U-Boot tree, then you wouldn't need to load another DTB, which
> > also simplifies the deployment on the kernel/distro side.  
> 
> Currently Mobian linux kernel for sunxi-devices contains 36 extra patches with DT

That does not sound good. Why are those patches not upstream?

> modifications (add/remove nodes, modify existing properties). One of
> them unconditionally adds cpuidle states to DT, that I'm trying to fix
> upstream here with the proposed change.

That's very honourable, but not every patch that works(TM) is the right
approach to take upstream.

> DT overlays are not used.
> 
> Honestly I don't think that using dtb from u-boot will simplify
> distribution deployment and maintenance. IMHO, it will make things
> more complex. Currently on my device there are records in extlinux.conf
> for 5.9, 5.10, 5.15, several 6.1 kernels, that I'm working on. All of
> them have slightly (or sometimes more) different device-trees.

And why is that, exactly? The DT describes the *device*, so why do you
have different DTs for different kernels? Sure, they evolve, devices
get added and we will have fixes, but conceptually there should be one
best DT for each device, for every kernel, and that could be the one
in the U-Boot tree - or the one in the latest kernel *tree*.

And why do you have different kernels to begin with? Are those various
vendor kernels, for different SoCs, each with their own pile of
downstream patches?

> Having
> kernel and dtb deployed together makes life so much easier.

Easier in the long term, because you can make quick hacks, but it's all
getting a mess over time.

> Mobian's dtb can't be put into u-boot.

Why not? It's a matter of copying whatever .dts files you have into
U-Boot's arch/arm/dts directory and making sure the Makefile covers
every file. Ignoring the question what "Mobian's DTB" really is.

> Mobian doesn't provide
> device-specific bootloader (u-boot) and there is on-going work on
> making device-independent universal images.

With "universal image" you mean a single rootfs, and a single kernel for
every device? Of course, this is how Linux works everywhere, and the
arm64 kernel was a single-image kernel from day one (same as x86). And
taking the DTs out there and into firmware is just even more
consequential.

> As many other mobile Linux distributions Mobian relies on
> Tow-Boot. That is used as a cross-distribution firmware (u-boot/tf-a/crust). [3]

I don't know much about tow-boot, but it seems just like a U-Boot
*distribution*, so I don't see why you can't use upstream U-Boot
techniques like sharing U-Boot's control DTB with the kernel
(by using $fdtcontroladdr).

> > > then U-Boot loads DT defined in
> > > extlinux.conf file. u-boot scripts are not used in case of extlinux at all.  
> > 
> > That's fine, you don't need any U-Boot scripts for this to work. If
> > there is no "fdt" or "fdtdir" label in extlinux.conf, then the U-Boot
> > PXE code will eventually fall back to $fdtcontroladdr - I just tested
> > that.
> > So could you make that work for you? I guess all you need to change is
> > to remove any fdtdir label from extlinux.conf?
> > 
> > Cheers,
> > Andre  
> 
> Regardless proposed change. Changes to dtb nodes already copied in
> u-boot on the fly in boot/image-fdt.c:image_setup_libfdt. For example,
> created optee nodes are copied there.

Yes, that is an example, just not a particularly good one. This seems
to originate from 2019, again building on the idea that you need to load
a DTB for the kernel from somewhere. I don't like to proliferate those
ideas anymore.

> I've just put platform specific
> changes into platform specific ft_board_setup, that was made
> apparently exactly for that.

Not really, that's for platform specific runtime *adjustments*, like
adding a unique MAC address, or adding simplefb DT nodes.

Cheers,
Andre

> 1. https://packages.debian.org/trixie/u-boot-menu
> 2. https://salsa.debian.org/debian/u-boot-menu
> 3. https://tow-boot.org/
> 

