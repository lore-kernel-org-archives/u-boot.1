Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9300C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 09:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE5687641;
	Wed,  1 Nov 2023 10:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0034B87651; Wed,  1 Nov 2023 10:50:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A88F0875F1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 10:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8492F4;
 Wed,  1 Nov 2023 02:51:19 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF953F67D;
 Wed,  1 Nov 2023 02:50:36 -0700 (PDT)
Date: Wed, 1 Nov 2023 09:50:34 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>, Jagan Teki
 <jagan@amarulasolutions.com>
Subject: Re: [PATCH] sunxi: restore modified memory
Message-ID: <20231101095034.44d14187@donnerap.manchester.arm.com>
In-Reply-To: <20230721145721.616040-1-andrej.skvortzov@gmail.com>
References: <20230721145721.616040-1-andrej.skvortzov@gmail.com>
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

On Fri, 21 Jul 2023 17:57:21 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

sorry for the late reply!

> On A64 with 2G of RAM words at following addresses were modified with
> 'aa55aa55' value:
>  - 50000000
>  - 60000000
>  - 84000000
>  - 88000000
>  - 90000000
>  - A0000000
>  - A0000200
> 
> That made harder to pick memory range for persistent storage in RAM.

In general I now think this patch is fine, since DRAM content can indeed
be preserved across some reboot types.
Some things below:

> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  arch/arm/mach-sunxi/dram_helpers.c  | 16 ++++++++++++++--
>  arch/arm/mach-sunxi/dram_sunxi_dw.c | 16 ++++++++++++++--
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
> index 2c873192e6..e3d236a4b3 100644
> --- a/arch/arm/mach-sunxi/dram_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_helpers.c
> @@ -32,12 +32,24 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
>  #ifndef CONFIG_MACH_SUNIV
>  bool mctl_mem_matches(u32 offset)
>  {
> +	unsigned long tmp_base;
> +	unsigned long tmp_offset;

The type doesn't match the return type of readl.
Please use uint32_t here.
And the names are somewhat misleading, at least to my mind, since they are
not a base address and an offset, but rather just values at a base
address and at an offset from that.
So I think val_base and val_offset would be better.

> +	bool ret;
> +
> +        /* Save original values */
> +	tmp_base = readl(CFG_SYS_SDRAM_BASE);
> +	tmp_offset = readl((ulong)CFG_SYS_SDRAM_BASE + offset);
> +
>  	/* Try to write different values to RAM at two addresses */
>  	writel(0, CFG_SYS_SDRAM_BASE);
>  	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
>  	dsb();
>  	/* Check if the same value is actually observed when reading back */
> -	return readl(CFG_SYS_SDRAM_BASE) ==
> -	       readl((ulong)CFG_SYS_SDRAM_BASE + offset);
> +	ret = readl(CFG_SYS_SDRAM_BASE) == readl((ulong)CFG_SYS_SDRAM_BASE + offset);
> +
> +	/* Restore original values */
> +	writel(tmp_base, CFG_SYS_SDRAM_BASE);
> +	writel(tmp_offset, (ulong)CFG_SYS_SDRAM_BASE + offset);
> +	return ret;
>  }
>  #endif
> diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
> index 9107b114df..6245815fa2 100644
> --- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
> +++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
> @@ -657,13 +657,25 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
>   */
>  static bool mctl_mem_matches_base(u32 offset, ulong base)

Mmh, somehow I dimly remember commenting on this before (some other
patch?), but this function is essentially the same as above, isn't it?
If someone has some spare cycles, they could be merged, implementing
mctl_mem_matches() as a tiny wrapper around mctl_mem_matches_base(), to
preserve all callers.

Shouldn't block this patch, though.

Cheers,
Andre


>  {
> +	unsigned long tmp_base;
> +	unsigned long tmp_offset;
> +	bool ret;
> +
> +	/* Save original values */
> +	tmp_base = readl(base);
> +	tmp_offset = readl((ulong)base + offset);
> +
>  	/* Try to write different values to RAM at two addresses */
>  	writel(0, base);
>  	writel(0xaa55aa55, base + offset);
>  	dsb();
>  	/* Check if the same value is actually observed when reading back */
> -	return readl(base) ==
> -	       readl(base + offset);
> +	ret = readl(base) == readl(base + offset);
> +
> +	/* Restore original values */
> +	writel(tmp_base, base);
> +	writel(tmp_offset, (ulong)base + offset);
> +	return ret;
>  }
>  
>  static void mctl_auto_detect_dram_size_rank(uint16_t socid, struct dram_para *para, ulong base, struct rank_para *rank)

