Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B78DFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE6F84372;
	Sat, 25 Apr 2026 21:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD168843E8; Sat, 25 Apr 2026 21:15:08 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C5158442B
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wFtyc-000000005SN-1XVC; Thu, 23 Apr 2026 13:20:18 +0000
Date: Thu, 23 Apr 2026 14:20:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
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
Message-ID: <aeocicfRVu7NuC6T@makrotopia.org>
References: <cover.1776302805.git.daniel@makrotopia.org>
 <87wlxxltnc.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlxxltnc.fsf@prevas.dk>
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

On Thu, Apr 23, 2026 at 02:59:19PM +0200, Rasmus Villemoes wrote:
> On Thu, Apr 16 2026, Daniel Golle <daniel@makrotopia.org> wrote:
> 
> > This series adds dm-verity support to U-Boot's FIT image infrastructure.
> > It is the first logical subset of the larger OpenWrt boot method series
> > posted as an RFC in February 2026 [1], extracted here for independent
> > review and merging.
> >
> > OpenWrt's firmware model embeds a read-only squashfs or erofs root
> > filesystem directly inside a uImage.FIT container as a FILESYSTEM-type
> > loadable FIT image. At boot the kernel maps this sub-image directly from
> > the underlying block device via the fitblk driver (/dev/fit0, /dev/fit1,
> 
> Can you show me where that fitblk driver lives, because I can't find
> anything like that in the linux source code. Grepping for 'fitblk' or
> 'dev/fit' turns up nothing.

The driver is currently downstream, but going to be (re-)submitted upsteam.
See below for more.

> 
> > ...), the goal is that the bootloader never even copies it to RAM.
> 
> Hm, how is that achieved? I.e., how do you load and boot the FIT image
> without loading that part, but still reading in e.g. the kernel?

The next series after this is going to suggest a way for on-demand
loading only the actually necessary FIT images from a storage backend.
See
https://github.com/u-boot/u-boot/pull/870

And see here for an end-to-end demo:
https://github.com/openwrt/openwrt/pull/22177
