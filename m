Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EEEC36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 01:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E06BC80EEF;
	Tue, 25 Mar 2025 02:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5331806FC; Tue, 25 Mar 2025 02:14:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B411D806FC
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 02:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B3391596;
 Mon, 24 Mar 2025 18:14:05 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E37953F58B;
 Mon, 24 Mar 2025 18:13:57 -0700 (PDT)
Date: Tue, 25 Mar 2025 01:13:29 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: jagan@amarulasolutions.com, trini@konsulko.com, macromorgan@hotmail.com,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/2] sunxi: H616: dram: Improve address wrapping detection
Message-ID: <20250325011329.51176143@minigeek.lan>
In-Reply-To: <20250309063143.62859-3-jernej.skrabec@gmail.com>
References: <20250309063143.62859-1-jernej.skrabec@gmail.com>
 <20250309063143.62859-3-jernej.skrabec@gmail.com>
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

On Sun,  9 Mar 2025 07:31:43 +0100
Jernej Skrabec <jernej.skrabec@gmail.com> wrote:

Hi,

> It turns out that checking just one write is not enough. Due to
> unexplained reasons scan procedure detected double the size. By making
> 16 dword writes and comparisons that never happens.
> 
> New procedure is also inverted. Instead of writing two different values
> to base address and some offset and then reading both and comparing
> values, simplify this by writing pattern at the base address and then
> search for this pattern at some offset.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Thanks for improving this, I guess we want to eventually move this to
more generic code, and use this for more SoCs?

Anyway:
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/mach-sunxi/dram_sun50i_h616.c | 58 +++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index 6f84e59e39cd..1e21f5dd451f 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -1360,38 +1360,92 @@ static void mctl_auto_detect_rank_width(const struct dram_para *para,
>  	panic("This DRAM setup is currently not supported.\n");
>  }
>  
> +static void mctl_write_pattern(void)
> +{
> +	unsigned int i;
> +	u32 *ptr, val;
> +
> +	ptr = (u32 *)CFG_SYS_SDRAM_BASE;
> +	for (i = 0; i < 16; ptr++, i++) {
> +		if (i & 1)
> +			val = ~(ulong)ptr;
> +		else
> +			val = (ulong)ptr;
> +		writel(val, ptr);
> +	}
> +}
> +
> +static bool mctl_check_pattern(ulong offset)
> +{
> +	unsigned int i;
> +	u32 *ptr, val;
> +
> +	ptr = (u32 *)CFG_SYS_SDRAM_BASE;
> +	for (i = 0; i < 16; ptr++, i++) {
> +		if (i & 1)
> +			val = ~(ulong)ptr;
> +		else
> +			val = (ulong)ptr;
> +		if (val != *(ptr + offset / 4))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static void mctl_auto_detect_dram_size(const struct dram_para *para,
>  				       struct dram_config *config)
>  {
>  	unsigned int shift, cols, rows;
> +	u32 buffer[16];
>  
>  	/* max. config for columns, but not rows */
>  	config->cols = 11;
>  	config->rows = 13;
>  	mctl_core_init(para, config);
>  
> +	/*
> +	 * Store content so it can be restored later. This is important
> +	 * if controller was already initialized and holds any data
> +	 * which is important for restoring system.
> +	 */
> +	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> +
> +	mctl_write_pattern();
> +
>  	shift = config->bus_full_width + 1;
>  
>  	/* detect column address bits */
>  	for (cols = 8; cols < 11; cols++) {
> -		if (mctl_mem_matches(1ULL << (cols + shift)))
> +		if (mctl_check_pattern(1ULL << (cols + shift)))
>  			break;
>  	}
>  	debug("detected %u columns\n", cols);
>  
> +	/* restore data */
> +	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> +
>  	/* reconfigure to make sure that all active rows are accessible */
>  	config->cols = 8;
>  	config->rows = 17;
>  	mctl_core_init(para, config);
>  
> +	/* store data again as it might be moved */
> +	memcpy(buffer, (u32 *)CFG_SYS_SDRAM_BASE, sizeof(buffer));
> +
> +	mctl_write_pattern();
> +
>  	/* detect row address bits */
>  	shift = config->bus_full_width + 4 + config->cols;
>  	for (rows = 13; rows < 17; rows++) {
> -		if (mctl_mem_matches(1ULL << (rows + shift)))
> +		if (mctl_check_pattern(1ULL << (rows + shift)))
>  			break;
>  	}
>  	debug("detected %u rows\n", rows);
>  
> +	/* restore data again */
> +	memcpy((u32 *)CFG_SYS_SDRAM_BASE, buffer, sizeof(buffer));
> +
>  	config->cols = cols;
>  	config->rows = rows;
>  }

