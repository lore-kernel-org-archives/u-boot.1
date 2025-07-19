Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C93C83F17
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 02:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C0A83642;
	Sat, 19 Jul 2025 04:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 677048365C; Sat, 19 Jul 2025 04:05:56 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA1783612
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 04:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.48.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id C1B9C3408F9;
 Sat, 19 Jul 2025 02:05:51 +0000 (UTC)
Date: Sat, 19 Jul 2025 10:05:47 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 00/20] sunxi: Add Allwinner A523 support
Message-ID: <20250719020547-GYA702644@gentoo>
References: <20250717235455.32528-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717235455.32528-1-andre.przywara@arm.com>
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

Hi Andre,

On 00:54 Fri 18 Jul     , Andre Przywara wrote:
> Hi,
> 
> (Mikhail and Jernej: please reply with S-o-b: lines for your patches!)
> 
> this series introduces support for the Allwinner A523 SoC family.
> Compared to v1, a good chunk of those patches have been merged, so we are
> down from 34 to 20 patches now. There are some small fixes to the
> pinctrl driver, and the SPL clock bits got updated to fix the conflicts
> with the now merged A133 support. I rewrote the SPL watchdog code, to
> avoid the MMIO register C struct. The DRAM driver lost one MMIO register
> struct. The DT files have now landed in the DT rebasing repo, so we can
> cherry-pick them from there.
> 
> Otherwise this now based on latest U-Boot master, which hopefully makes
> testing easier. If people don't shout, I would like to merge it still
> during this merge window, since the patches have been around for a while,
> and people want to use them, alongside the now supported mainline Linux
> code. So please test and review!
> 
> ==================================
> This series introduces support for the Allwinner A523 SoC family. The
> same die is used in different packages: the A523, A527, T527, and H728:
> they connect a different set of peripherals to the pins, or enable extra
> goodies like an NPU. From a U-Boot perspective those chips do not differ
> much, all the differences are described in the board DT files.
> 
> To be able to share the SPL clock code, the existing H6 code gets
> refactored in patches 01-04. This unifies the (CPU) PLL handling across
> the SoCs supported by this code (H6, H616, A133), and adds support for
> the separate CPU PLLs on the A523.
> 
> Patches 05-10 extend the existing Allwinner U-Boot drivers to cope with
> some of the changed peripherals, this includes the mandatory clock and
> pinctrl drivers, but also some clock tweaks for the MMC controller
> driver, and support for the new-ish AXP323 PMIC used on most boards.
> 
> Patches 11 updates some SPL bits to be able to cope with the A523.
> Patches 12-15 add the new SPL bits for the A523, most prominently the DRAM
> initialisation code. Many thanks to Jernej and Mikhail for providing
> this part, there is a great reverse engineering and testing effort behind
> this.
> 
> Patches 16-19 cherry-pick the DT files from the DT rebasing repo. There
> are more fix patches queued, I will update them once they hit the repo.
> 
> The final patch adds defconfig files for the three boards that seem to be
> the most popular at the moment, they include two development boards and
> one TV box. The most interesting bits in there are the DRAM parameters.
> 
> Please have a look, review, and test.
> 
for the series, I've only got one clk warning, but otherwise works for me..

Tested-by: Yixun Lan <dlan@gentoo.org> # Radxa A5E

-- 
Yixun Lan (dlan)
