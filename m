Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628DCC48BF6
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 01:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DCD687E63;
	Tue,  5 Mar 2024 02:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB7187FA1; Tue,  5 Mar 2024 02:22:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 63DE687E1E
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 02:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 326A52F4;
 Mon,  4 Mar 2024 17:22:33 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04C2D3F73F;
 Mon,  4 Mar 2024 17:21:55 -0800 (PST)
Date: Tue, 5 Mar 2024 01:21:33 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/2] sunxi: reorganize mctl_mem_matches_* functions
Message-ID: <20240305012133.3b6334e7@minigeek.lan>
In-Reply-To: <20231227212843.397349-2-andrej.skvortzov@gmail.com>
References: <20231227212843.397349-1-andrej.skvortzov@gmail.com>
 <20231227212843.397349-2-andrej.skvortzov@gmail.com>
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

On Thu, 28 Dec 2023 00:28:42 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi,

> mctl_mem_matches and mctl_mem_matches_base identical functions. To
> avoid code duplication move them to dram_helpers and make
> mctl_mem_matches use generic mctl_mem_matches_base.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

thanks for the changes, that looks good now!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Merged to sunxi/master.

Cheers,
Andre

> ---
>  arch/arm/include/asm/arch-sunxi/dram.h |  1 +
>  arch/arm/mach-sunxi/dram_helpers.c     | 20 ++++++++++++++------
>  arch/arm/mach-sunxi/dram_sunxi_dw.c    | 13 -------------
>  3 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/dram.h b/arch/arm/include/asm/arch-sunxi/dram.h
> index 682daae6b1..9d21b49241 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> @@ -40,5 +40,6 @@
>  unsigned long sunxi_dram_init(void);
>  void mctl_await_completion(u32 *reg, u32 mask, u32 val);
>  bool mctl_mem_matches(u32 offset);
> +bool mctl_mem_matches_base(u32 offset, ulong base);
>  
>  #endif /* _SUNXI_DRAM_H */
> diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
> index cdf2750f1c..661186b648 100644
> --- a/arch/arm/mach-sunxi/dram_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_helpers.c
> @@ -25,19 +25,27 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
>  }
>  
>  /*
> - * Test if memory at offset offset matches memory at begin of DRAM
> + * Test if memory at offset matches memory at a certain base
>   *
>   * Note: dsb() is not available on ARMv5 in Thumb mode
>   */
>  #ifndef CONFIG_MACH_SUNIV
> -bool mctl_mem_matches(u32 offset)
> +bool mctl_mem_matches_base(u32 offset, ulong base)
>  {
>  	/* Try to write different values to RAM at two addresses */
> -	writel(0, CFG_SYS_SDRAM_BASE);
> -	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
> +	writel(0, base);
> +	writel(0xaa55aa55, base + offset);
>  	dsb();
>  	/* Check if the same value is actually observed when reading back */
> -	return readl(CFG_SYS_SDRAM_BASE) ==
> -	       readl((ulong)CFG_SYS_SDRAM_BASE + offset);
> +	return readl(base) ==
> +	       readl(base + offset);
> +}
> +
> +/*
> + * Test if memory at offset matches memory at begin of DRAM
> + */
> +bool mctl_mem_matches(u32 offset)
> +{
> +	return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
>  }
>  #endif
> diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
> index 9382d3d0be..2e8dd40b97 100644
> --- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
> +++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
> @@ -652,19 +652,6 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
>  	return 0;
>  }
>  
> -/*
> - * Test if memory at offset offset matches memory at a certain base
> - */
> -static bool mctl_mem_matches_base(u32 offset, ulong base)
> -{
> -	/* Try to write different values to RAM at two addresses */
> -	writel(0, base);
> -	writel(0xaa55aa55, base + offset);
> -	dsb();
> -	/* Check if the same value is actually observed when reading back */
> -	return readl(base) ==
> -	       readl(base + offset);
> -}
>  
>  static void mctl_auto_detect_dram_size_rank(uint16_t socid, struct dram_para *para, ulong base, struct rank_para *rank)
>  {

