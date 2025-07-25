Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B16C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 23:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 770EE836A3;
	Sat, 26 Jul 2025 01:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 690B083710; Sat, 26 Jul 2025 01:50:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D262083693
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 01:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE681764;
 Fri, 25 Jul 2025 16:50:33 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B54073F66E;
 Fri, 25 Jul 2025 16:50:39 -0700 (PDT)
Date: Sat, 26 Jul 2025 00:48:31 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>, Yixun
 Lan <dlan@gentoo.org>, Paul Kocialkowski <paulk@sys-base.io>,
 linux-sunxi@lists.linux.dev, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 14/20] sunxi: A523: add DDR3 DRAM support
Message-ID: <20250726004831.5e2d90ff@minigeek.lan>
In-Reply-To: <20250717235455.32528-15-andre.przywara@arm.com>
References: <20250717235455.32528-1-andre.przywara@arm.com>
 <20250717235455.32528-15-andre.przywara@arm.com>
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

On Fri, 18 Jul 2025 00:54:49 +0100
Andre Przywara <andre.przywara@arm.com> wrote:

Hi Mikhail,

> From: Mikhail Kalashnikov <iuncuim@gmail.com>

many thanks for the Signed-off-by: line in the other mail, I added this
now. And also not sure I thanked you already for providing the code in
the first place, that's much appreciated, since it enables this neat TV
box ;-)

So when this was running in the U-Boot gitlab CI, which every patch has
to pass for getting merged, it complained about the compiler warnings,
which I was tempted to ignore before (because I saw they weren't easy to
fix). Since this isn't an option now (the CI runs with -Werror), I bit
the bullet and looked into the problem, see below ...
 
> Add reverse engineered code to add support for DDR3 DRAM chips on the
> Allwinner A523 DRAM controller.
> ---
>  arch/arm/mach-sunxi/Kconfig                  |   8 ++
>  arch/arm/mach-sunxi/dram_sun55i_a523.c       | 136 ++++++++++++++++++-
>  arch/arm/mach-sunxi/dram_timings/Makefile    |   1 +
>  arch/arm/mach-sunxi/dram_timings/a523_ddr3.c | 134 ++++++++++++++++++
>  4 files changed, 273 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a523_ddr3.c

[ .... ] 

> diff --git a/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c b/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c
> new file mode 100644
> index 00000000000..6db0ea30f7c
> --- /dev/null
> +++ b/arch/arm/mach-sunxi/dram_timings/a523_ddr3.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * sun55i A523 DDR3 timings, as programmed by Allwinner's boot0
> + *
> + * (C) Copyright 2024 Mikhail Kalashnikov <iuncuim@gmail.com>
> + *   Based on H6 DDR3 timings:
> + *   (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
> + */
> +
> +#include <asm/arch/dram.h>
> +#include <asm/arch/cpu.h>
> +
> +void mctl_set_timing_params(u32 clk)
> +{
> +	struct sunxi_mctl_ctl_reg * const mctl_ctl =
> +			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> +	u8 tcl, tcwl, t_rdata_en, trtp, twr, tphy_wrlat;
> +	unsigned int mr1, mr2;
> +
> +	u8 tccd		= 4;
> +	u8 tfaw		= ns_to_t(40, clk);
> +	u8 trrd		= max(ns_to_t(10, clk), 2);
> +	u8 twtr		= max(ns_to_t(10, clk), 4);
> +	u8 trcd		= max(ns_to_t(18, clk), 2);
> +	u8 trc		= ns_to_t(65, clk);
> +	u8 txp		= max(ns_to_t(8, clk), 2);
> +	u8 trp		= ns_to_t(21, clk);
> +	u8 tras		= ns_to_t(42, clk);
> +	u16 trefi	= ns_to_t(3904, clk) / 32;
> +	u16 trfc	= ns_to_t(280, clk);
> +	u16 txsr	= ns_to_t(290, clk);
> +
> +	u8 tmrw		= max(ns_to_t(14, clk), 5);
> +	u8 tmod		= 12;
> +	u8 tcke		= max(ns_to_t(15, clk), 2);
> +	u8 tcksrx	= max(ns_to_t(2, clk), 2);
> +	u8 tcksre	= max(ns_to_t(5, clk), 2);
> +	u8 trasmax	= (trefi * 9) / 32;
> +
> +	if (clk <= 936) {

This and the even higher frequencies below make me think you copied
Jernej's LPDDR4 timings code, but the timing values, frequencies and
equation are LPDDR4 specific, and don't work for DDR3.
Which explains why ...

> +		mr1 = 0x34;
> +		mr2 = 0x1b;
> +		tcl = 10;
> +		tcwl = 5;
> +		t_rdata_en = 17;
> +		trtp = 4;
> +		tphy_wrlat = 5;
> +		twr = 10;
> +	} else if (clk <= 1200) {
> +		mr1 = 0x54;
> +		mr2 = 0x2d;
> +		tcl = 14;
> +		tcwl = 7;
> +		t_rdata_en = 25;
> +		trtp = 6;
> +		tphy_wrlat = 9;
> +		twr = 15;
> +	} else {
> +		mr1 = 0x64;
> +		mr2 = 0x36;
> +		tcl = 16;
> +		tcwl = 8;
> +		t_rdata_en = 29;
> +		trtp = 7;
> +		tphy_wrlat = 11;
> +		twr = 17;
> +	}
> +
> +	u8 tmrd		= tmrw;
> +	u8 tckesr	= tcke;
> +	u8 twtp		= twr + 9 + tcwl;
> +	u8 twr2rd	= twtr + 9 + tcwl;
> +	u8 trd2wr	= ns_to_t(4, clk) + 7 - ns_to_t(1, clk) + tcl;
> +	u8 txs		= 4;
> +	u8 txsdll	= 16;
> +	u8 txsabort	= 4;
> +	u8 txsfast	= 4;
> +
> +	/* set DRAM timing */
> +	// writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
> +	//        &mctl_ctl->dramtmg[0]);
> +	// writel((txp << 16) | (trtp << 8) | trc, &mctl_ctl->dramtmg[1]);
> +	// writel((tcwl << 24) | (tcl << 16) | (trd2wr << 8) | twr2rd,
> +	//        &mctl_ctl->dramtmg[2]);
> +	// writel((tmrw << 20) | (tmrd << 12) | tmod, &mctl_ctl->dramtmg[3]);
> +	// writel((trcd << 24) | (tccd << 16) | (trrd << 8) | trp,
> +	//        &mctl_ctl->dramtmg[4]);
> +	// writel((tcksrx << 24) | (tcksre << 16) | (tckesr << 8) | tcke,
> +	//        &mctl_ctl->dramtmg[5]);

... you ignore the calculated values right here ^^^, since they don't
match at all with what boot0 wrote into those registers. Instead those
values are hardcoded below here.

So I had a look at the H616 and H6 DDR3 code, and found the equations
much more meaningful there, to the point where they almost perfectly
match the values you force here.
So I went through all the registers, and corrected the calculation of
the timing parameters to match the other DDR3 code, so I could use the
commented lines above. As an example, those are the changes for the
first register:

-	u8 twtp		= twr + 9 + tcwl;
+	u8 twtp		= twr + 2 + tcwl;
-	u8 tfaw		= ns_to_t(40, clk);
+	u8 tfaw		= ns_to_t(50, clk);
-	u8 trasmax	= (trefi * 9) / 32;
+	u8 trasmax	= (clk / 2) / 15;		/* tREFI * 9 */
-	u8 tras		= ns_to_t(42, clk);
+	u8 tras		= ns_to_t(38, clk);
...
-	// writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
-	//        &mctl_ctl->dramtmg[0]);
-	writel(0x0e141a10, &mctl_ctl->dramtmg[0]);
+	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
+	       &mctl_ctl->dramtmg[0]);

I verified that the timing values now calculated for the used 792 MHz
were identical to those hardcoded before. Of course the values are
different for the preliminary 360 MHz setup during the probing runs,
but it still works nicely for me.
I even managed to boot with 912 MHz (DDR3-1866), and with slightly
shorter tCL and tCWL latencies (matching those described for
DDR3-1600), but haven't done any benchmarking or stability tests yet.

So I have changed your patch to accommodate the proper DDR3
calculations, which now compiles without warnings, so should pass the CI.

Hope that's fine for you, I will post the diff for your reference in a
separate reply mail.

Cheers,
Andre



> +	writel(0x0e141a10, &mctl_ctl->dramtmg[0]);
> +	writel(0x00040415, &mctl_ctl->dramtmg[1]);
> +	writel(0x0507050b, &mctl_ctl->dramtmg[2]);
> +	writel(0x0000400c, &mctl_ctl->dramtmg[3]);
> +	writel(0x06020406, &mctl_ctl->dramtmg[4]);
> +	writel(0x04040504, &mctl_ctl->dramtmg[5]);
> +	/* Value suggested by ZynqMP manual and used by libdram */
> +	writel((txp + 2) | 0x02020000, &mctl_ctl->dramtmg[6]);
> +	writel((txsfast << 24) | (txsabort << 16) | (txsdll << 8) | txs,
> +	       &mctl_ctl->dramtmg[8]);
> +	writel(0x00020208, &mctl_ctl->dramtmg[9]);
> +	writel(0xE0C05, &mctl_ctl->dramtmg[10]);
> +	writel(0x440C021C, &mctl_ctl->dramtmg[11]);
> +	writel(8, &mctl_ctl->dramtmg[12]);
> +	writel(0xA100002, &mctl_ctl->dramtmg[13]);
> +	//writel(txsr, &mctl_ctl->dramtmg[14]);
> +	writel(4, &mctl_ctl->dramtmg[14]);
> +
> +	//clrsetbits_le32(&mctl_ctl->init[0], 0xC0000FFF, 0x558);
> +	clrsetbits_le32(&mctl_ctl->init[0], 0xC0000FFF, 0x156);
> +	writel(0x01f20000, &mctl_ctl->init[1]);
> +	//writel(0x00001705, &mctl_ctl->init[2]);
> +	writel(0x00001700, &mctl_ctl->init[2]);
> +	writel(0, &mctl_ctl->dfimisc);
> +	//writel((mr1 << 16) | mr2, &mctl_ctl->init[3]);
> +	writel(0x1f140004, &mctl_ctl->init[3]);
> +	//writel(0x00330000, &mctl_ctl->init[4]);
> +	//writel(0x00040072, &mctl_ctl->init[6]);
> +	//writel(0x00260008, &mctl_ctl->init[7]);
> +	writel(0x00200000, &mctl_ctl->init[4]);
> +	writel(0, &mctl_ctl->init[6]);
> +	writel(0, &mctl_ctl->init[7]);
> +
> +	clrsetbits_le32(&mctl_ctl->rankctl, 0xff0, 0x660);
> +
> +	/* Configure DFI timing */
> +	//writel(tphy_wrlat | 0x2000000 | (t_rdata_en << 16) | 0x808000,
> +	//       &mctl_ctl->dfitmg0);
> +	writel(0x02898005, &mctl_ctl->dfitmg0);
> +	writel(0x100202, &mctl_ctl->dfitmg1);
> +
> +	/* set refresh timing */
> +	//writel((trefi << 16) | trfc, &mctl_ctl->rfshtmg);
> +	writel(0x008c0000, &mctl_ctl->rfshtmg);
> +}

