Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F05DC25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 12:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E70688473;
	Wed, 22 May 2024 14:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B614988490; Wed, 22 May 2024 14:14:55 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B240287E96
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 14:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i5e860cd9.versanet.de ([94.134.12.217] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1s9kro-0000KN-FB; Wed, 22 May 2024 14:14:48 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>,
 u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, jonas@kwiboo.se,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 00/10] rockchip: px30: migrate to common bss and stack
 addresses + UART fixes for evb-px30
Date: Wed, 22 May 2024 14:14:47 +0200
Message-ID: <2148002.OBFZWjSADL@diego>
In-Reply-To: <c9a78f7a-5b63-4d37-93d4-2c6bd8db0076@cherry.de>
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
 <20240521180444.GC2568172@bill-the-cat>
 <c9a78f7a-5b63-4d37-93d4-2c6bd8db0076@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Am Mittwoch, 22. Mai 2024, 10:39:25 CEST schrieb Quentin Schulz:
> Hi Tom,
> 
> On 5/21/24 8:04 PM, Tom Rini wrote:
> > On Tue, May 21, 2024 at 07:39:53PM +0200, Quentin Schulz wrote:
> >> PX30 Ringneck ran out of memory in the allocation pool of U-Boot proper
> >> pre-reloc. Something needed to be done. Jonas did migrate a few SoCs
> >> already to this common bss+stack addresses so it made sense to follow
> >> the same route for one additional SoC: PX30.
> >>
> >> While at it, also fix a few issues related to UART on the PX30 Mini EVB
> >> I could test.
> >>
> >> Boot (to U-Boot CLI) tested on PX30 Ringneck and PX30 Mini-EVB.
> >>
> >> Thanks to Jonas for hinting where to look at.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >> ---
> >> Quentin Schulz (10):
> >>        rockchip: px30: default TPL_SYS_MALLOC_F_LEN to 0x600 on PX30 Kconfig level
> >>        rockchip: Use common bss and stack addresses on PX30
> >>        rockchip: ringneck_px30: Use common bss and stack addresses
> >>        rockchip: evb-px30: Use common bss and stack addresses
> >>        rockchip: firefly-px30: Use common bss and stack addresses
> >>        rockchip: odroid-go2: Use common bss and stack addresses
> >>        rockchip: px30-core-*: Use common bss and stack addresses
> >>        rockchip: px30: make UART pinmux accessible to TPL/SPL DTB
> >>        rockchip: evb-px30: do not remove pinctrl nodes from SPL DTB
> >>        rockchip: evb-px30: make UART5 the debug UART
> >>
> >>   arch/arm/dts/px30-u-boot.dtsi                 | 16 ++++++++++++++++
> >>   arch/arm/mach-rockchip/px30/Kconfig           |  8 +++++++-
> >>   configs/evb-px30_defconfig                    | 23 +++++------------------
> >>   configs/firefly-px30_defconfig                | 19 +++----------------
> >>   configs/odroid-go2_defconfig                  | 19 +++----------------
> >>   configs/px30-core-ctouch2-of10-px30_defconfig | 19 +++----------------
> >>   configs/px30-core-ctouch2-px30_defconfig      | 19 +++----------------
> >>   configs/px30-core-edimm2.2-px30_defconfig     | 19 +++----------------
> >>   configs/ringneck-px30_defconfig               | 19 +++----------------
> >>   9 files changed, 46 insertions(+), 115 deletions(-)
> >> ---
> >> base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
> >> change-id: 20240521-px30-2024-07-rc-7136f6241d29
> > 
> > As I assume we want to fix the platforms for v2024.07, is this the level
> > of config changes everyone is comfortable with on the platforms? Or
> > should we just go with the minimum for release and the rest to -next?
> > 
> 
> I can tell you that Ringneck doesn't work anymore on v2024.07-rc, but 
> the PX30 Mini EVB was still reaching U-Boot CLI without the changes. I 
> don't know about the other boards.
> 
> So I could split this into two series, one for master, one for next.
> 
> I could suggest: patch 1 to 3 in master, the rest in next. Patch 1 is 
> just moving things around. Patch 2 is doing nothing if nobody uses 
> ROCKCHIP_COMMON_STACK_ADDR and SPL_SHARES_INIT_SP_ADDR (which is the 
> case for px30 boards). Patch 3 is for fixing Ringneck, which I know is 
> broken.
> 
> Heiko having access to the Odroid Go2, maybe he could test without my 
> patches and see if it reaches the CLI to know if we should pull it in 
> for master as well.

I did that yesterday evening. The Odroid Go2 also reached u-boot CLI
and also booted without these changes. So I guess it's small enough
or whatever.

So at least the Go2 is fine on 2024.07-rc3 either way with or without
this series.

Heiko


