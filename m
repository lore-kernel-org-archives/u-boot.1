Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E8EC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 10:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E22881E1C;
	Fri, 28 Mar 2025 11:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F290081E1F; Fri, 28 Mar 2025 11:40:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DD73181CFD
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4EE71691;
 Fri, 28 Mar 2025 03:40:10 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CF133F58B;
 Fri, 28 Mar 2025 03:40:03 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:39:59 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Marek
 Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Bin Meng <bmeng.cn@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@denx.de>, Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
Subject: Re: [PATCH 00/18] Annotate switch/case fallthrough cases
Message-ID: <20250328103959.3980025b@donnerap.manchester.arm.com>
In-Reply-To: <734a1243-53d5-42da-8d51-bec687f83c5b@gmx.de>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <734a1243-53d5-42da-8d51-bec687f83c5b@gmx.de>
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

On Fri, 28 Mar 2025 11:28:05 +0100
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

Hi,

> On 27.03.25 16:32, Andre Przywara wrote:
> > C's implicit fallthrough behaviour in switch/case statements can lead to
> > subtle bugs. Quite some while ago many compilers introduced warnings in
> > those cases, requiring intentional fallthrough's to be annotated.
> >
> > So far we were not enabling that compiler option, so many ambiguities
> > and some bugs in the code went unnoticed.
> >
> > This series adds the required annotations in code paths that the first
> > stage of the U-Boot CI covers. There is a large number of cases left
> > in the libbz2 code. The usage of switch/case is borderline insane there,
> > labels are hidden in macros, and there are no breaks, but just goto's.
> > Upstream still uses very similar code, without any annotations. I still
> > am not 100% sure those are meant to fall through or not, and plan to do
> > further investigations, but didn't want to hold the rest of the patches
> > back. You can see for yourself by applying patch 18/18 and building for
> > sandbox64, for instance.  
> 
> Can we use something like
> 
> CFLAGS_REMOVE_bzlib.o = -Wimplicit-fallthrough

Ah, didn't know we have that in U-Boot as well! Sounds promising, and
fixes the sandbox build for me (when using bzlib_decompress.o). I will add
this to the last patch and will check what the CI has to say about this.

Thanks for the heads up!

Cheers,
Andre

> 
> in the Makefile if that module is too hard to fix?
> 
> Best regards
> 
> Heinrich
> 
> >
> > Because of this we cannot quite enable the warning in the Makefile yet,
> > but those fixes are worth regardless, and be it to increase readability.
> >
> > Please not that those patches do not fix anything, really, they just add
> > those fallthrough annotations, so the series is not really critical.
> >
> > Cheers,
> > Andre
> >
> > Andre Przywara (18):
> >    spl: mmc: properly annotate fallthrough
> >    zlib: annotate switch/case fallthrough cases
> >    gadget: f_thor: annotate switch/case fallthrough
> >    use proper fallthrough annotations
> >    net/net: fix switch/case fallthrough annotations
> >    fastboot: annotate switch/case fallthrough case
> >    net: sun8i-emac: annotate fallthrough
> >    usb: ohci-hcd: annotate switch/case fallthrough
> >    usb: xhci: annotate switch/case fallthrough properly (TBF)
> >    video: annotate switch/case fall-through
> >    net: e1000: annotate switch/case fallthrough
> >    mtd: ubi: annotate fallthrough (TBF)
> >    arm: mach-k3: am62p: annotate switch/case fallthrough
> >    mtd: spi-nor-tiny: annotate switch/case fallthrough
> >    mtd: rawnand: nand_base: annotate switch/case fallthrough
> >    cmd: pmic: annotate switch/case fallthrough
> >    cmd: spl: annotate switch/case fallthrough
> >    [DO NOT MERGE] Makefile: enable switch/case fallthrough warnings
> >
> >   Makefile                              |  1 +
> >   arch/arm/mach-k3/am62px/am62p5_init.c |  1 +
> >   cmd/pmic.c                            |  1 +
> >   cmd/spl.c                             |  2 ++
> >   common/command.c                      |  2 +-
> >   common/spl/spl_mmc.c                  |  1 +
> >   drivers/fastboot/fb_command.c         |  1 +
> >   drivers/mtd/nand/raw/nand_base.c      |  4 ++++
> >   drivers/mtd/spi/spi-nor-tiny.c        |  1 +
> >   drivers/mtd/ubi/attach.c              |  1 +
> >   drivers/mtd/ubi/build.c               |  3 +++
> >   drivers/net/e1000.c                   |  2 ++
> >   drivers/net/sun8i_emac.c              |  1 +
> >   drivers/usb/gadget/f_thor.c           |  1 +
> >   drivers/usb/host/ohci-hcd.c           |  3 ++-
> >   drivers/usb/host/xhci.c               |  2 +-
> >   drivers/video/video-uclass.c          |  2 ++
> >   lib/tiny-printf.c                     |  2 +-
> >   lib/zlib/inflate.c                    | 21 +++++++++++++++++++++
> >   net/net.c                             |  5 ++---
> >   20 files changed, 50 insertions(+), 7 deletions(-)
> >  
> 

