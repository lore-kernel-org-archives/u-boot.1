Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610BCC36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 01:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A256F80EEF;
	Tue, 25 Mar 2025 02:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB25E80F70; Tue, 25 Mar 2025 02:17:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 77B6B808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 02:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E38C51596;
 Mon, 24 Mar 2025 18:17:12 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4C233F58B;
 Mon, 24 Mar 2025 18:17:05 -0700 (PDT)
Date: Tue, 25 Mar 2025 01:16:41 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: eng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] sunxi: mmc: Improve reset procedure
Message-ID: <20250325011641.19b7d7e1@minigeek.lan>
In-Reply-To: <20250309061241.62170-1-jernej.skrabec@gmail.com>
References: <20250309061241.62170-1-jernej.skrabec@gmail.com>
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

On Sun,  9 Mar 2025 07:12:41 +0100
Jernej Skrabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

many thanks for your investigation and this fix here! Not having
working eMMC access was a major annoyance for those TV boxes, and this
indeed seems to be fixed now, judging by my experiments. Also checked
boot partition access, works fine (though data partitions seem to take
precedence on most devices).

> Cards should always be reset and threshold set. This fixes eMMC on H616.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/mmc/sunxi_mmc.c | 28 ++++++++++++++++++++++------
>  drivers/mmc/sunxi_mmc.h | 15 +++++++++++++--
>  2 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index 0b56d1405bee..335def4b9738 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -442,6 +442,26 @@ out:
>  	return error;
>  }
>  
> +static void sunxi_mmc_reset(struct sunxi_mmc *regs)
> +{
> +	/* Reset controller */
> +	writel(SUNXI_MMC_GCTRL_RESET, &regs->gctrl);
> +	udelay(1000);
> +
> +	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
> +		/* Reset card */
> +		writel(SUNXI_MMC_HWRST_ASSERT, &regs->hwrst);
> +		udelay(10);
> +		writel(SUNXI_MMC_HWRST_DEASSERT, &regs->hwrst);
> +		udelay(300);
> +
> +		/* Setup FIFO R/W threshold. Needed on H616. */
> +		writel(SUNXI_MMC_THLDC_READ_THLD(512) |
> +		       SUNXI_MMC_THLDC_WRITE_EN |
> +		       SUNXI_MMC_THLDC_READ_EN, &regs->thldc);
> +	}
> +}
> +
>  /* non-DM code here is used by the (ARM) SPL only */
>  
>  #if !CONFIG_IS_ENABLED(DM_MMC)
> @@ -489,9 +509,7 @@ static int sunxi_mmc_core_init(struct mmc *mmc)
>  {
>  	struct sunxi_mmc_priv *priv = mmc->priv;
>  
> -	/* Reset controller */
> -	writel(SUNXI_MMC_GCTRL_RESET, &priv->reg->gctrl);
> -	udelay(1000);
> +	sunxi_mmc_reset(priv->reg);
>  
>  	return 0;
>  }
> @@ -684,9 +702,7 @@ static int sunxi_mmc_probe(struct udevice *dev)
>  
>  	upriv->mmc = &plat->mmc;
>  
> -	/* Reset controller */
> -	writel(SUNXI_MMC_GCTRL_RESET, &priv->reg->gctrl);
> -	udelay(1000);
> +	sunxi_mmc_reset(priv->reg);
>  
>  	return 0;
>  }
> diff --git a/drivers/mmc/sunxi_mmc.h b/drivers/mmc/sunxi_mmc.h
> index f4ae5a790c87..9d55904c213c 100644
> --- a/drivers/mmc/sunxi_mmc.h
> +++ b/drivers/mmc/sunxi_mmc.h
> @@ -37,7 +37,9 @@ struct sunxi_mmc {
>  	u32 res0;		/* 0x54 reserved */
>  	u32 a12a;		/* 0x58 Auto command 12 argument */
>  	u32 ntsr;		/* 0x5c	New timing set register */
> -	u32 res1[8];
> +	u32 res1[6];
> +	u32 hwrst;		/* 0x78 Hardware Reset */
> +	u32 res5;
>  	u32 dmac;		/* 0x80 internal DMA control */
>  	u32 dlba;		/* 0x84 internal DMA descr list base address */
>  	u32 idst;		/* 0x88 internal DMA status */
> @@ -46,7 +48,8 @@ struct sunxi_mmc {
>  	u32 cbda;		/* 0x94 */
>  	u32 res2[26];
>  #if defined(CONFIG_SUNXI_GEN_SUN6I) || defined(CONFIG_SUN50I_GEN_H6) || defined(CONFIG_SUNXI_GEN_NCAT2)
> -	u32 res3[17];
> +	u32 thldc;		/* 0x100 Threshold control */
> +	u32 res3[16];
>  	u32 samp_dl;
>  	u32 res4[46];
>  #endif
> @@ -123,6 +126,9 @@ struct sunxi_mmc {
>  
>  #define SUNXI_MMC_NTSR_MODE_SEL_NEW		(0x1 << 31)
>  
> +#define SUNXI_MMC_HWRST_ASSERT		(0x0 << 0)
> +#define SUNXI_MMC_HWRST_DEASSERT	(0x1 << 0)
> +
>  #define SUNXI_MMC_IDMAC_RESET		(0x1 << 0)
>  #define SUNXI_MMC_IDMAC_FIXBURST	(0x1 << 1)
>  #define SUNXI_MMC_IDMAC_ENABLE		(0x1 << 7)
> @@ -133,6 +139,11 @@ struct sunxi_mmc {
>  #define SUNXI_MMC_COMMON_CLK_GATE		(1 << 16)
>  #define SUNXI_MMC_COMMON_RESET			(1 << 18)
>  
> +#define SUNXI_MMC_THLDC_READ_EN		(0x1 << 0)
> +#define SUNXI_MMC_THLDC_BSY_CLR_INT_EN	(0x1 << 1)
> +#define SUNXI_MMC_THLDC_WRITE_EN	(0x1 << 2)
> +#define SUNXI_MMC_THLDC_READ_THLD(x)	(((x) & 0xfff) << 16)
> +
>  #define SUNXI_MMC_CAL_DL_SW_EN		(0x1 << 7)
>  
>  #endif /* _SUNXI_MMC_H */

