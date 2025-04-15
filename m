Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62528C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 23:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B902582C96;
	Wed, 16 Apr 2025 01:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C2682CA2; Wed, 16 Apr 2025 01:07:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 034A581F54
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 01:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C9C4339;
 Tue, 15 Apr 2025 16:06:58 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ECB53F59E;
 Tue, 15 Apr 2025 16:06:59 -0700 (PDT)
Date: Wed, 16 Apr 2025 00:06:00 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: jagan@amarulasolutions.com, trini@konsulko.com, macromorgan@hotmail.com,
 uwu@icenowy.me, u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/5] sunxi: H6: DRAM: Constify function parameters
Message-ID: <20250416000600.24fdc69f@minigeek.lan>
In-Reply-To: <20250411161439.4743-4-jernej.skrabec@gmail.com>
References: <20250411161439.4743-1-jernej.skrabec@gmail.com>
 <20250411161439.4743-4-jernej.skrabec@gmail.com>
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

On Fri, 11 Apr 2025 18:14:37 +0200
Jernej Skrabec <jernej.skrabec@gmail.com> wrote:

Hi,

> Constify parameters for two reasons:
> - Allow more compile time optimizations
> - It will allow later sharing of common code with H616 (when it will be
>   rearranged some more)
> 
> Commit does same kind of changes as 457e2cd665bd ("sunxi: H616: dram:
> const-ify DRAM function parameters")

Makes sense, and indeed all those functions only read from para:

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/mach-sunxi/dram_sun50i_h6.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> index 0adbda756639..24b2cb1579f4 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> @@ -34,13 +34,13 @@
>   * similar PHY is ZynqMP.
>   */
>  
> -static void mctl_sys_init(struct dram_para *para);
> -static void mctl_com_init(struct dram_para *para);
> -static bool mctl_channel_init(struct dram_para *para);
> +static void mctl_sys_init(u32 clk_rate);
> +static void mctl_com_init(const struct dram_para *para);
> +static bool mctl_channel_init(const struct dram_para *para);
>  
>  static bool mctl_core_init(struct dram_para *para)
>  {
> -	mctl_sys_init(para);
> +	mctl_sys_init(para->clk);
>  	mctl_com_init(para);
>  	switch (para->type) {
>  	case SUNXI_DRAM_TYPE_LPDDR3:
> @@ -150,7 +150,7 @@ static void mctl_set_master_priority(void)
>  	MBUS_CONF(HDCP2,  true,    HIGH, 2,  100,   64,   32);
>  }
>  
> -static void mctl_sys_init(struct dram_para *para)
> +static void mctl_sys_init(u32 clk_rate)
>  {
>  	struct sunxi_ccm_reg * const ccm =
>  			(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> @@ -171,7 +171,7 @@ static void mctl_sys_init(struct dram_para *para)
>  
>  	/* Set PLL5 rate to doubled DRAM clock rate */
>  	writel(CCM_PLL5_CTRL_EN | CCM_PLL5_LOCK_EN |
> -	       CCM_PLL5_CTRL_N(para->clk * 2 / 24), &ccm->pll5_cfg);
> +	       CCM_PLL5_CTRL_N(clk_rate * 2 / 24), &ccm->pll5_cfg);
>  	mctl_await_completion(&ccm->pll5_cfg, CCM_PLL5_LOCK, CCM_PLL5_LOCK);
>  
>  	/* Configure DRAM mod clock */
> @@ -196,7 +196,7 @@ static void mctl_sys_init(struct dram_para *para)
>  	writel(0x8000, &mctl_ctl->unk_0x00c);
>  }
>  
> -static void mctl_set_addrmap(struct dram_para *para)
> +static void mctl_set_addrmap(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_ctl_reg * const mctl_ctl =
>  			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
> @@ -282,7 +282,7 @@ static void mctl_set_addrmap(struct dram_para *para)
>  	mctl_ctl->addrmap[8] = 0x3F3F;
>  }
>  
> -static void mctl_com_init(struct dram_para *para)
> +static void mctl_com_init(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_com_reg * const mctl_com =
>  			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
> @@ -352,7 +352,7 @@ static void mctl_com_init(struct dram_para *para)
>  	}
>  }
>  
> -static void mctl_bit_delay_set(struct dram_para *para)
> +static void mctl_bit_delay_set(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_phy_reg * const mctl_phy =
>  			(struct sunxi_mctl_phy_reg *)SUNXI_DRAM_PHY0_BASE;
> @@ -411,7 +411,7 @@ static void mctl_bit_delay_set(struct dram_para *para)
>  	}
>  }
>  
> -static bool mctl_channel_init(struct dram_para *para)
> +static bool mctl_channel_init(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_com_reg * const mctl_com =
>  			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;

