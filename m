Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EF5C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 12:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C37D5828AB;
	Sat,  5 Apr 2025 14:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29ADA82991; Sat,  5 Apr 2025 14:33:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 68DB68215B
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 14:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D89A1063;
 Sat,  5 Apr 2025 05:33:33 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A404A3F59E;
 Sat,  5 Apr 2025 05:33:30 -0700 (PDT)
Date: Sat, 5 Apr 2025 13:32:48 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Mikhail Kalashnikov
 <iuncuim@gmail.com>, u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 00/34] sunxi: clock refactoring and Allwinner A523 support
Message-ID: <20250405133248.62927bff@minigeek.lan>
In-Reply-To: <20250405024433-GYA8928@gentoo>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250405024433-GYA8928@gentoo>
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

On Sat, 5 Apr 2025 02:44:33 +0000
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> On 11:35 Sun 23 Mar     , Andre Przywara wrote:
> > This series introduces support for the Allwinner A523 SoC family. The
> > same die is used in different packages: the A523, A527, T527, and H728:
> > they connect a different set of peripherals to the pins, or enable extra
> > goodies like an NPU. From a U-Boot perspective those chips do not differ
> > much, all the differences are described in the board DT files.
> > These patches are not the most refined at the moment, but I hope that
> > people start reviewing them, so we can merge the ones that are ready,
> > to reduce their number.
> > 
> > To be able to share the SPL clock code, the existing H6 code gets
> > refactored in patches 01-13. This removes the C struct describing the
> > 127 clock registers, and replaces it with macros defining the register
> > offsets. For more rationale and explanation see the 01/34 commit message.
> > 
> > Patches 14-20 extend the existing Allwinner U-Boot drivers to cope with
> > some of the changed peripherals, this includes the mandatory clock and
> > pinctrl drivers, but also some clock tweaks for the MMC controller
> > driver, and support for the new watchdog and the AXP323 used.
> > 
> > Patches 21-23 update some SPL bits to be able to cope with the A523.
> > Patches 24-28 extend the FEL handling code: the A523 has a GICv3, which
> > requires saving some GICv3 system registers, plus the IRQ mode stack
> > pointer. Patches 25-27 refactor the CPU clock code, and add the new
> > clock bits required by the A523.
> > 
> > Patch 29-32 add the new SPL bits for the A523, most prominently the DRAM
> > initialisation code. Many thanks to Jernej and Mikhail for providing
> > this part, there is a great reverse engineering and testing effort behind
> > this.
> > 
> > Patch 33 copies the DT files from the proposed Linux patches. They have
> > not been merged yet, mostly due to one missing DT binding dependency in
> > the linux-next tree, but have otherwise been agreed upon, with almost
> > every used binding being already merged. Eventually we will use the copy
> > from the DT rebasing repo, but for now those files must do.
> > 
> > The final patch adds defconfig files for the three boards that seem to be
> > the most popular at the moment, they include two development boards and
> > one TV box. The most interesting bits in there are the DRAM parameters.
> > 
> > Please have a look, review, and test.
> > 
> > Thanks!
> > Andre
> >   
> 
> 
> Is there any docs about how to compile and run this patch series?
> I've got some complaint while apply to v2025.04-rc5 (not found correct base myself)

Yes, it's pretty much work in progress, I just wanted to get the
patches out on the list, to start the review process.
You should be able to base it on "sunxi-next" or U-Boot's main next
branch.

> 
> I'm following doc/board/allwinner/sunxi.rst to build and using sunxi-tools to run,
> but it seems stuck at running uboot (should pass SPL stage)
> 
> here are steps I tried
> 
> 1) build trust firmware
> $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> $ make CROSS_COMPILE=aarch64-unknown-linux-gnu- PLAT=sun50i_a64
> is sun50i_a64 correct for a527 SoC?

No, A64 will not work, as you figured ;-)
Jernej has a WIP branch for TF-A here:
https://github.com/jernejsk/arm-trusted-firmware/commits/a523/
Please use this and the "sun55i_a523" build target.

> besides, got a oversize error if DEBUG=1 enabled

Yes, this is a known issue, the available secure SRAM on the A64 is
just too small for all the features. Should not be a problem on other
SoCs including the A523/T527, though.

> 
> 2) build SCP

SCP is highly optional, and there is no port available anyway.
I would not know of someone working on it as well.

> 
> 3) build uboot
> $ export BL31=/home/work/trusted-firmware-a/build/sun50i_a64/release/bl31.bin  
> export SCP..
> $ make ARCH=arm CROSS_COMPILE=aarch64-unknown-linux-gnu- -j30 radxa-a5e_defconfig
> $ make ARCH=arm CROSS_COMPILE=aarch64-unknown-linux-gnu- -j30

Just use .../build/sun55i_a523/debug/bl31.bin, as mentioned above.

> 
> 4) run:  sunxi-fel -v uboot u-boot-sunxi-with-spl.bin
>  4.a) serial console from a527 board
> 
> U-Boot SPL 2025.04-rc5-00048-g432f0f975187 (Apr 05 2025 - 10:21:15 +0800)
> DRAM: 4096 MiB
> Trying to boot from FEL

Yes, this is the effect when TF-A is built for the wrong target,
normally you would see TF-A messages here.
 
>  4.b) from host which run sunxi-fel
> 
>  $ sunxi-fel -v uboot u-boot-sunxi-with-spl.bin
> found DT name in SPL header: sun55i-a527-radxa-a5e
> Stack pointers: sp_irq=0x00045400, sp=0x00060300
> MMU is not enabled by BROM
> => Executing the SPL... done.  
> loading image "ARM Trusted Firmware" (37076 bytes) to 0x54000
> loading image "U-Boot" (657216 bytes) to 0x4a000000
> loading DTB "sun55i-a527-radxa-a5e" (19024 bytes)
> Starting U-Boot (0x00054000).
> Store entry point 0x00054000 to RVBAR 0x08000040, and request warm reset with RMR mode 3... done.
> 
> is ATF loading address correct, 0x54000 here? which seems override sp address?

Yes, that's the correct address. Which SP would it collide with, anyway?

So in summary you did everything right, and the SPL is returning to FEL
with DRAM initialised, which is the biggest hurdle.
Just use the correct A523 TF-A branch and build target.

Cheers,
Andre.
