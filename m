Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8412C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 13:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A418899D;
	Tue, 13 Aug 2024 15:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE548889A8; Tue, 13 Aug 2024 14:35:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 94E59889A1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A99F012FC;
 Tue, 13 Aug 2024 05:35:49 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 499DA3F73B;
 Tue, 13 Aug 2024 05:35:19 -0700 (PDT)
Date: Tue, 13 Aug 2024 13:35:16 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bin Meng <bmeng.cn@gmail.com>, Bryan
 Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>, Eddie James
 <eajames@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Maksim Kiselev
 <bigunclemax@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Michael Walle <mwalle@kernel.org>, Michal
 Simek <michal.simek@amd.com>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Sam Edwards <cfsworks@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Stefan Roese <sr@denx.de>, Sumit Garg
 <sumit.garg@linaro.org>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH 0/6] bootstd: sunxi: Migrate to standard boot
Message-ID: <20240813133516.20c04cea@donnerap.manchester.arm.com>
In-Reply-To: <CAFLszThv2wHzV6FStwb3qfrR+Qq82kdp7qynWC4=xsw5m-JVxg@mail.gmail.com>
References: <20240807205032.3745680-1-sjg@chromium.org>
 <20240812165952.7d0da18d@donnerap.manchester.arm.com>
 <CAFLszThv2wHzV6FStwb3qfrR+Qq82kdp7qynWC4=xsw5m-JVxg@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 13 Aug 2024 15:22:56 +0200
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

On Tue, 13 Aug 2024 06:17:17 -0600
Simon Glass <sjg@chromium.org> wrote:

Hi Simon,

I had a bit deeper look yesterday.

> Hi Andre,
> 
> On Mon, 12 Aug 2024 at 10:00, Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > On Wed,  7 Aug 2024 14:50:26 -0600
> > Simon Glass <sjg@chromium.org> wrote:
> >
> > Hey Simon,
> >  
> > > This series attempts to migrate all sunxi boards to use standard boot,
> > > along with a text environment.  
> >
> > Ah, many thanks for that! I figured that we need a bootmeth for FEL, but
> > never got around to have a closer look.
> > On a coarse glance, this looks roughly OK, and doing a super quick boot
> > test on one board, it seems to still work(TM), though the priority of the
> > FEL boot is not right?  
> 
> Does it need to be the top priority, perhaps?

Yes, please. It should only trigger when you a) do FEL booting and b)
upload a boot script via FEL, in which case you surely want to execute
that before anything else. From what I see the global EFI bootmeth is first
in the list, but I couldn't find an easy way to fix this in the source
file. Would that go through a platform specific bootmeths env variable?

> > And I guess ditching the old kernel support might be a bit controversial.
> > I think this is about the vendor kernels, which some people still rely on?  
> 
> OK, perhaps it is. It might be a little tricky to handle it, but I
> suspect another bootmeth might be enough.

Well, I had a look, and it looks like CONFIG_OLD_SUNXI_KERNEL_COMPAT
covers multiple things:
- it sets up some clocks slightly differently
- it enters the kernel (stays?) in secure mode
- it provides a custom boot script

I think the latter can be replaced quite easily with something custom, and
I guess it's the only one biting you? So I am OK with that going, but I
think we should keep the first two features (and thus the Kconfig symbol).


Another thing I discovered: we lose USB support with patch 3/6. The reason
is that USB support is enabled by having DISTRO_DEFAULTS. Just replacing
that with BOOTSTD_DEFAULTS didn't work, though, I get a (ridiculous) splat
about a circular Kconfig dependency. My hunch is that's something else not
right in Kconfig, but I need to have a closer look.

Cheers,
Andre

> 
> >
> > I will have a closer look this week and give you a review, just wanted to
> > acknowledge the series and thank you for your efforts.  
> 
> OK thank you.
> 
> Regards,
> Simon
> 
> 
> >
> > Cheers,
> > Andre
> >  
> > > Simon Glass (6):
> > >   sunxi: Drop BOOTCMD_SUNXI_COMPAT
> > >   sunxi: Add a bootmeth for FEL
> > >   sunxi: Move to bootstd
> > >   sunxi: Drop old distro boot variables
> > >   env: Provide a work-around for unquoting fdtfile
> > >   sunxi: Move to text environment
> > >
> > >  Makefile                                      |   1 +
> > >  arch/arm/Kconfig                              |   2 +-
> > >  arch/arm/include/asm/arch-sunxi/clock_sun4i.h |  10 -
> > >  arch/arm/mach-sunxi/Kconfig                   |  12 -
> > >  arch/arm/mach-sunxi/dram_sun4i.c              |   4 -
> > >  board/sunxi/sunxi.env                         | 138 ++++++++++
> > >  boot/Kconfig                                  |  14 ++
> > >  boot/Makefile                                 |   1 +
> > >  boot/bootmeth_fel.c                           |  81 ++++++
> > >  configs/icnova-a20-swac_defconfig             |   1 -
> > >  doc/usage/environment.rst                     |  12 +
> > >  include/configs/sunxi-common.h                | 238 ------------------
> > >  12 files changed, 248 insertions(+), 266 deletions(-)
> > >  create mode 100644 board/sunxi/sunxi.env
> > >  create mode 100644 boot/bootmeth_fel.c
> > >  
> >  

