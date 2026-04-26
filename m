Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCD8FF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 16:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E4983FDB;
	Sun, 26 Apr 2026 18:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F09A83FF5; Sun, 26 Apr 2026 18:32:51 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B595D839D9
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 18:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wH2P3-000000007wx-2PPQ; Sun, 26 Apr 2026 16:32:17 +0000
Date: Sun, 26 Apr 2026 17:32:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/7] fit: dm-verity support
Message-ID: <ae4-DA_TIVAEAaC3@makrotopia.org>
References: <cover.1776302805.git.daniel@makrotopia.org>
 <87wlxxltnc.fsf@prevas.dk> <aeocicfRVu7NuC6T@makrotopia.org>
 <cf943303-9f48-4cb0-b055-0c2115fceeac@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf943303-9f48-4cb0-b055-0c2115fceeac@mailbox.org>
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

On Sun, Apr 26, 2026 at 06:20:55PM +0200, Marek Vasut wrote:
> On 4/23/26 3:20 PM, Daniel Golle wrote:
> > On Thu, Apr 23, 2026 at 02:59:19PM +0200, Rasmus Villemoes wrote:
> > > On Thu, Apr 16 2026, Daniel Golle <daniel@makrotopia.org> wrote:
> > > 
> > > > This series adds dm-verity support to U-Boot's FIT image infrastructure.
> > > > It is the first logical subset of the larger OpenWrt boot method series
> > > > posted as an RFC in February 2026 [1], extracted here for independent
> > > > review and merging.
> > > > 
> > > > OpenWrt's firmware model embeds a read-only squashfs or erofs root
> > > > filesystem directly inside a uImage.FIT container as a FILESYSTEM-type
> > > > loadable FIT image. At boot the kernel maps this sub-image directly from
> > > > the underlying block device via the fitblk driver (/dev/fit0, /dev/fit1,
> > > 
> > > Can you show me where that fitblk driver lives, because I can't find
> > > anything like that in the linux source code. Grepping for 'fitblk' or
> > > 'dev/fit' turns up nothing.
> > 
> > The driver is currently downstream, but going to be (re-)submitted upsteam.
> > See below for more.
> > 
> > > 
> > > > ...), the goal is that the bootloader never even copies it to RAM.
> > > 
> > > Hm, how is that achieved? I.e., how do you load and boot the FIT image
> > > without loading that part, but still reading in e.g. the kernel?
> > 
> > The next series after this is going to suggest a way for on-demand
> > loading only the actually necessary FIT images from a storage backend.
> > See
> > https://github.com/u-boot/u-boot/pull/870
> 
> This should be posted on the ML, see .github/pull_request_template.md :
> 
> "
> Please do not submit a Pull Request via github.  Our project makes use of
> mailing lists for patch submission and review.  For more details please
> see https://u-boot.readthedocs.io/en/latest/develop/sending_patches.html
> "

I of course had also posted it to the mailing list back then.
I just thought it'd be easier to look at it on Github than in the list
archive:

https://lists.denx.de/pipermail/u-boot/2026-February/610274.html

> 
> That said, U-Boot SPL already handles on-demand loading of parts of
> fitImages generated with mkimage -E (fitImage with external data). There is
> no need to reinvent the wheel.

This has been discussed in detail already when the RFC series was
posted:

https://lists.denx.de/pipermail/u-boot/2026-February/611074.html

tl;dr:
|> So there really isn't much overlap other than the fact that there is a
|> struct with a priv pointer and a .read callback, and even that uses a
|> different addressing parameter (sectors vs. bytes).
