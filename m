Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9E3C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 00:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B80688C19;
	Tue, 20 Aug 2024 02:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9804688C19; Tue, 20 Aug 2024 02:04:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D5F1F881A1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB6C2339;
 Mon, 19 Aug 2024 17:04:30 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55C893F73B;
 Mon, 19 Aug 2024 17:04:03 -0700 (PDT)
Date: Tue, 20 Aug 2024 00:55:13 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jernej.skrabec@gmail.com,
 neil.armstrong@linaro.org, hdegoede@redhat.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 2/9] sunxi: H616: DRAM: Add alternative pin mapping
Message-ID: <20240820005513.3cd26601@minigeek.lan>
In-Reply-To: <20240819145938.503221-3-macroalpha82@gmail.com>
References: <20240819145938.503221-1-macroalpha82@gmail.com>
 <20240819145938.503221-3-macroalpha82@gmail.com>
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

On Mon, 19 Aug 2024 09:59:31 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

Hi,

> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> It seems that different dies need different PHY pin mapping. Select
> alternatives based on "bond ID".

Do we really need this to determined at runtime? I appreciate the idea
of making the code more versatile, but we have far more board specific
parameters fixed at build time, so detecting a SoC type at runtime
sounds a bit pointless. I am asking because this increases the SPL size
by like 115 bytes.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm/mach-sunxi/dram_sun50i_h616.c | 59 +++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index 5be2887a06..dfaa270d96 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -225,22 +225,43 @@ static void mctl_set_addrmap(const struct dram_config *config)
>  	mctl_ctl->addrmap[8] = 0x3F3F;
>  }
>  
> -static const u8 phy_init[] = {
> +static const u8 phy_addr_maps[2][27] = {
>  #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
> -	0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
> -	0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
> -	0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
> -	0x09, 0x05, 0x18
> +	{
> +		0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
> +		0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
> +		0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
> +		0x09, 0x05, 0x18
> +	}, {
> +		0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
> +		0x14, 0x07, 0x04, 0x13, 0x0c, 0x00, 0x16, 0x1a,
> +		0x0a, 0x11, 0x03, 0x10, 0x0e, 0x01, 0x0d, 0x19,
> +		0x06, 0x09, 0x0f
> +	}
>  #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
> -	0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
> -	0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> -	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
> -	0x17, 0x19, 0x1a
> +	{
> +		0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
> +		0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
> +		0x17, 0x19, 0x1a
> +	}, {
> +		0x18, 0x00, 0x04, 0x09, 0x06, 0x05, 0x02, 0x19,
> +		0x17, 0x03, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
> +		0x08, 0x01, 0x1a
> +	}
>  #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
> -	0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
> -	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> -	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
> -	0x18, 0x03, 0x1a
> +	{
> +		0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
> +		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
> +		0x18, 0x03, 0x1a
> +	}, {
> +		0x03, 0x00, 0x17, 0x05, 0x02, 0x19, 0x06, 0x07,
> +		0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
> +		0x18, 0x04, 0x1a
> +	}
>  #endif
>  };
>  
> @@ -887,6 +908,7 @@ static bool mctl_phy_init(const struct dram_para *para,
>  	struct sunxi_mctl_ctl_reg * const mctl_ctl =
>  			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
>  	u32 val, val2, *ptr, mr0, mr2;
> +	const u8 *map;
>  	int i;
>  
>  	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
> @@ -942,8 +964,15 @@ static bool mctl_phy_init(const struct dram_para *para,
>  	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x37c);
>  
>  	ptr = (u32 *)(SUNXI_DRAM_PHY0_BASE + 0xc0);
> -	for (i = 0; i < ARRAY_SIZE(phy_init); i++)
> -		writel(phy_init[i], &ptr[i]);
> +	val = readl(SUNXI_SID_BASE);
> +	if (((val & 0xfbff) == 0x5000) ||
> +	    ((val & 0xfeff) == 0x5c00) ||
> +	    ((val & 0xf7ff) == 0x2000))

so for the records, looking at
https://linux-sunxi.org/SID_Register_Guide#Currently_known_SID.27s
this means: H616, H313, H618, respectively. Which seems to be fixed for
each board.

> +		map = phy_addr_maps[0];
> +	else
> +		map = phy_addr_maps[1];
> +	for (i = 0; i < ARRAY_SIZE(phy_addr_maps[0]); i++)
> +		writel(map[i], &ptr[i]);

If I drop the SID read above, and replace this code with something
based on CONFIG_SUNXI_DRAM_H616_PHY_ADDR_MAP, it only grows by 35 bytes.
If I put #if's in the array definitions above, it stays entirely at the
old size, but at the cost of being hard to read - at least in the
version I came up with.

What do other people say here?

Cheers,
Andre

>  
>  	if (para->tpr10 & TPR10_CA_BIT_DELAY)
>  		mctl_phy_ca_bit_delay_compensation(para, config);

