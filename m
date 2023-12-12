Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBDCC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 13:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC330877F4;
	Tue, 12 Dec 2023 14:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED38876CC; Tue, 12 Dec 2023 14:18:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 44E93877F4
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 14:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12402143D;
 Tue, 12 Dec 2023 05:18:45 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 132653F762;
 Tue, 12 Dec 2023 05:17:57 -0800 (PST)
Date: Tue, 12 Dec 2023 13:17:44 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] sunxi: restore modified memory
Message-ID: <20231212131744.166fda2e@donnerap.manchester.arm.com>
In-Reply-To: <20231206190633.131346-2-andrej.skvortzov@gmail.com>
References: <20231206190633.131346-1-andrej.skvortzov@gmail.com>
 <20231206190633.131346-2-andrej.skvortzov@gmail.com>
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

On Wed,  6 Dec 2023 22:06:32 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

thanks for respinning!

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

I don't think this commit message is really helpful. What about:

------------------------------
Our sunxi DRAM initialisation code does several test accesses to the DRAM
array to detect aliasing effects and so determine the correct row/column
configuration. This changes the DRAM content, which breaks use cases like
soft reset and Linux' ramoops mechanism.

Fix this problem by saving and restoring the content of the DRAM cells
that we use for the test writes.
------------------------------

> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  arch/arm/mach-sunxi/dram_helpers.c  | 16 ++++++++++++++--
>  arch/arm/mach-sunxi/dram_sunxi_dw.c | 16 ++++++++++++++--
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
> index cdf2750f1c..61a6da84e3 100644
> --- a/arch/arm/mach-sunxi/dram_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_helpers.c
> @@ -32,12 +32,24 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
>  #ifndef CONFIG_MACH_SUNIV
>  bool mctl_mem_matches(u32 offset)
>  {
> +	u32 val_base;
> +	u32 val_offset;
> +	bool ret;
> +
> +	/* Save original values */
> +	val_base = readl(CFG_SYS_SDRAM_BASE);
> +	val_offset = readl((ulong)CFG_SYS_SDRAM_BASE + offset);

I don't think we need the cast here. And everywhere else, actually.

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
> +	writel(val_base, CFG_SYS_SDRAM_BASE);
> +	writel(val_offset, (ulong)CFG_SYS_SDRAM_BASE + offset);
> +	return ret;
>  }
>  #endif
> diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
> index 9382d3d0be..905a43c918 100644
> --- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
> +++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c

I think it would be better to swap the two patches, so to unify the two
routines first, then to add the save/restore code. Otherwise you are
patching code here that you remove in the next patch.

> @@ -657,13 +657,25 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
>   */
>  static bool mctl_mem_matches_base(u32 offset, ulong base)
>  {
> +	u32 val_base;
> +	u32 val_offset;
> +	bool ret;
> +
> +	/* Save original values */
> +	val_base = readl(base);
> +	val_offset = readl((ulong)base + offset);

base is already ulong, so no cast needed, same below.

Cheers,
Andre

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
> +	writel(val_base, base);
> +	writel(val_offset, (ulong)base + offset);
> +	return ret;
>  }
>  
>  static void mctl_auto_detect_dram_size_rank(uint16_t socid, struct dram_para *para, ulong base, struct rank_para *rank)

