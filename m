Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82025C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 00:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939E48813F;
	Mon, 15 Apr 2024 02:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E4788134; Mon, 15 Apr 2024 02:22:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5F1B287C7E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 02:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA2DA339;
 Sun, 14 Apr 2024 17:23:20 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9481D3F64C;
 Sun, 14 Apr 2024 17:22:51 -0700 (PDT)
Date: Mon, 15 Apr 2024 01:22:45 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: dazen@189.cn, Jernej =?UTF-8?B?xaBrcmFiZWM=?=
 <jernej.skrabec@gmail.com>, Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, trini@konsulko.com
Subject: Re: [PATCH] DRAM_SUN50I_H616_TRIM_SIZE
Message-ID: <20240415012245.75ccaa5b@minigeek.lan>
In-Reply-To: <20240413134352.46495-1-dazen@189.cn>
References: <20240413134352.46495-1-dazen@189.cn>
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

On Sat, 13 Apr 2024 21:43:52 +0800
dazen@189.cn wrote:

Hi,

thanks for sending a patch!

> From: lalakii <dazen@189.cn>
> 
> Add "DRAM_SUN50I_H616_TRIM_SIZE" option for 1.5gb board.
> 
> Signed-off-by: lalakii <dazen@189.cn>
> ---
>  arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h |  1 +
>  arch/arm/mach-sunxi/Kconfig                        |  7 +++++++
>  arch/arm/mach-sunxi/dram_sun50i_h616.c             | 11 ++++++++++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> index a8fdda124a..2d2526fead 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
> @@ -166,6 +166,7 @@ struct dram_config {
>  	u8 rows;
>  	u8 ranks;
>  	u8 bus_full_width;
> +	bool trim_size;
>  };
>  
>  static inline int ns_to_t(int nanoseconds)
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index fe89aec6b9..255a498557 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -108,6 +108,13 @@ config DRAM_SUN50I_H616_TPR12
>  	default 0x0
>  	help
>  	  TPR12 value from vendor DRAM settings.
> +
> +config DRAM_SUN50I_H616_TRIM_SIZE
> +        bool "H616 DRAM trim size"
> +        help
> +          Due to unknown issue, some H616 based boards may need to trim

Well, it's not really an unknown issue, is it? The problem seems to be
that the auto detection code cannot deal with the topology of the 1.5GB
DRAM chips.

The general problem with this approach is that it would need to be
enabled at build time, which means the generated image will always trim
the DRAM size, and would not be universal for each board anymore.

So we need something to auto-detect this situation. Can you describe
the failure mode, without this patch? Does the DRAM init code hang or
give up already, or does this all pass, and then later on the board
hangs or crashes when we try access the missing DRAM area?
Maybe a small test access beyond 1.5GB would be able to check for this
particular case?

Cheers,
Andre


> +          size a bit.
> +
>  endif
>  
>  config SUN6I_PRCM
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index 37c139e0ee..4598d60a57 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -1349,8 +1349,15 @@ static unsigned long mctl_calc_size(const struct dram_config *config)
>  {
>  	u8 width = config->bus_full_width ? 4 : 2;
>  
> +	unsigned long size;
> +
> +	size = (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
> +
> +	if (config->trim_size)
> +		size = (size * 3) / (width == 4 ? 4 : 8);
> +
>  	/* 8 banks */
> -	return (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
> +	return size;
>  }
>  
>  static const struct dram_para para = {
> @@ -1379,6 +1386,8 @@ unsigned long sunxi_dram_init(void)
>  	struct sunxi_prcm_reg *const prcm =
>  		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
>  	struct dram_config config;
> +	if (IS_ENABLED(CONFIG_DRAM_SUN50I_H616_TRIM_SIZE))
> +		config.trim_size = true;
>  	unsigned long size;
>  
>  	setbits_le32(&prcm->res_cal_ctrl, BIT(8));

