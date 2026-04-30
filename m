Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3407DCD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 17:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE51B803C6;
	Thu, 30 Apr 2026 19:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="iNOtzVSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD12E80433; Thu, 30 Apr 2026 19:26:53 +0200 (CEST)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49D3680086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 19:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Thu, 30 Apr 2026 19:26:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1777570009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6IqAZOjyNpHQ9weGtmta/kKo4bxsSZ8BGGB5ZRAqNW0=;
 b=iNOtzVSkDsztLsrrj4f560jFKgQ64FK0cfkNqrAxJu+pZy8IyFsnSLGnEPG/2NcLslW/8G
 bnfor3tlidWUJWFpvYyH75OvE1AXNcNNPqnDbLIPc7nqNeF+uSdAvPW1Wu+MK+jmEkPLNP
 YpbWIJOfs7FCZXpZUnbVN/luKGVbtfw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Lukas Timmermann <uboot@timmermann.space>
Subject: Re: [PATCH 1/4] mmc: exynos_dw_mmc: add proper init sequence for
 HS400 support
Message-ID: <20260430172638.GA17167@localhost>
References: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
 <20260427-dwmmc-exynos-hs400-es-v1-1-3495df40a9ac@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-dwmmc-exynos-hs400-es-v1-1-3495df40a9ac@disroot.org>
X-Migadu-Flow: FLOW_OUT
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

Hi Kaustabh,

On Mon, Apr 27, 2026 at 11:22:49AM +0530, Kaustabh Chakraborty wrote:
> HS400 support was added, but configuration necessary for HS400 support
> was left out. Add necessary changes, which includes:
> - Device tree properties, such as "samsung,dw-mshc-hs400-timing" and
>   "samsung,read-strobe-delay", which function as per dt-bindings.
> - Registers related to HS400, which are necessary to enable HS400+ support.
> - Appropriate timing tunings for the HS400 mode.
> 
> Note that these changes are loosely based off of its Linux kernel
> counterpart.
> 
> Fixes: bbe3b9fa0922 ("mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes")
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  arch/arm/mach-exynos/include/mach/dwmmc.h |  5 ++
>  drivers/mmc/exynos_dw_mmc.c               | 80 +++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-exynos/include/mach/dwmmc.h
> index 4432deedef7..50081326c25 100644
> --- a/arch/arm/mach-exynos/include/mach/dwmmc.h
> +++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
> @@ -15,6 +15,11 @@
>  #define DWMCI_SET_DRV_CLK(x)		((x) << 16)
>  #define DWMCI_SET_DIV_RATIO(x)		((x) << 24)
>  
> +/* HS400 Related Registers */
> +#define DWMCI_HS400_DQS_EN		0x180
> +#define DWMCI_HS400_ASYNC_FIFO_CTRL	0x184
> +#define DWMCI_HS400_DLINE_CTRL		0x188
> +
>  /* Protector Register */
>  #define DWMCI_EMMCP_BASE		0x1000
>  #define EMMCP_MPSECURITY		(DWMCI_EMMCP_BASE + 0x0010)
> diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
> index 7ccd113bd79..d5e90a9bd5c 100644
> --- a/drivers/mmc/exynos_dw_mmc.c
> +++ b/drivers/mmc/exynos_dw_mmc.c
> @@ -8,6 +8,7 @@
>  #include <dwmmc.h>
>  #include <asm/global_data.h>
>  #include <malloc.h>
> +#include <mmc.h>
>  #include <errno.h>
>  #include <asm/arch/dwmmc.h>
>  #include <asm/arch/clk.h>
> @@ -30,6 +31,14 @@
>  #define CLKSEL_UP_SAMPLE(x, y)		(((x) & ~CLKSEL_CCLK_SAMPLE(7)) | \
>  					 CLKSEL_CCLK_SAMPLE(y))
>  
> +/* RCLK_EN register defines */
> +#define DATA_STROBE_EN			BIT(0)
> +#define AXI_NON_BLOCKING_WR	BIT(7)
> +
> +/* DLINE_CTRL register defines */
> +#define DQS_CTRL_RD_DELAY(x, y)		(((x) & ~0x3FF) | ((y) & 0x3FF))
> +#define DQS_CTRL_GET_RD_DELAY(x)	((x) & 0x3FF)
> +
>  /**
>   * DOC: Quirk flags for different Exynos DW MMC blocks
>   *
> @@ -71,6 +80,11 @@ struct dwmci_exynos_priv_data {
>  	struct clk clk;
>  	u32 sdr_timing;
>  	u32 ddr_timing;
> +	u32 hs400_timing;
> +	u32 tuned_sample;
> +	u32 dqs_delay;
> +	u32 saved_dqs_en;
> +	u32 saved_strobe_ctrl;
>  	const struct exynos_dwmmc_variant *chip;
>  };
>  
> @@ -162,6 +176,27 @@ static u8 exynos_dwmmc_get_ciu_div(struct dwmci_host *host)
>  				& DWMCI_DIVRATIO_MASK) + 1;
>  }
>  
> +static void exynos_config_hs400(struct dwmci_host *host, enum bus_mode mode)
> +{
> +	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
> +	u32 dqs, strobe;
> +
> +	dqs = priv->saved_dqs_en;
> +	strobe = priv->saved_strobe_ctrl;
> +
> +	switch (mode) {
> +	case MMC_HS_400:
> +		dqs |= DATA_STROBE_EN;
> +		strobe = DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
> +		break;
> +	default:
> +		dqs &= ~DATA_STROBE_EN;
> +	}
> +
> +	dwmci_writel(host, DWMCI_HS400_DQS_EN, dqs);
> +	dwmci_writel(host, DWMCI_HS400_DLINE_CTRL, strobe);
> +}
> +
>  /* Configure CLKSEL register with chosen timing values */
>  static int exynos_dwmci_clksel(struct dwmci_host *host)
>  {
> @@ -170,6 +205,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
>  	u32 timing;
>  
>  	switch (host->mmc->selected_mode) {
> +	case MMC_HS_400:
> +		timing = CLKSEL_UP_SAMPLE(priv->hs400_timing, priv->tuned_sample);
> +		break;
>  	case MMC_DDR_52:
>  		timing = priv->ddr_timing;
>  		break;
> @@ -186,6 +224,8 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
>  
>  	dwmci_writel(host, priv->chip->clksel, timing);
>  
> +	exynos_config_hs400(host, host->mmc->selected_mode);
> +

This breaks emmc in Linux for existing devices without hs400 support:
exynos_config_hs400 is run no matter if the dt has the hs400
parameters, meaning 0x0 is written to DWMCI_HS400_DQS_EN and
DWMCI_HS400_DLINE_CTRL. U-boot does not seem to care, it loads the
kernel and initramfs without issues, but Linux later gives errors:

```
[   20.741025] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
[   20.886686] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[   20.895138] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
[   20.905990] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[   20.914988] mmc_host mmc0: Bus speed (slot 0) = 400000000Hz (slot req 200000000Hz, actual 200000000HZ div = 1)
[   21.099546] I/O error, dev mmcblk0, sector 1000001 op 0x1:(WRITE) flags 0x800 phys_seg 16 prio class 2
[   21.099853] I/O error, dev mmcblk0, sector 1000825 op 0x1:(WRITE) flags 0x800 phys_seg 8 prio class 2
[   21.107443] Buffer I/O error on dev mmcblk0p2, logical block 0, lost async page write
[   21.107473] Buffer I/O error on dev mmcblk0p2, logical block 1, lost async page write
[   21.116657] Buffer I/O error on dev mmcblk0p2, logical block 824, lost async page write
[   21.124408] Buffer I/O error on dev mmcblk0p2, logical block 2, lost async page write
[   21.132206] Buffer I/O error on dev mmcblk0p2, logical block 825, lost async page write
[   21.140178] Buffer I/O error on dev mmcblk0p2, logical block 3, lost async page write
[   21.147973] Buffer I/O error on dev mmcblk0p2, logical block 826, lost async page write
[   21.155960] Buffer I/O error on dev mmcblk0p2, logical block 4, lost async page write
[   21.163749] Buffer I/O error on dev mmcblk0p2, logical block 827, lost async page write
[   21.171720] Buffer I/O error on dev mmcblk0p2, logical block 5, lost async page write
[   21.200708] I/O error, dev mmcblk0, sector 1000873 op 0x1:(WRITE) flags 0x800 phys_seg 8 prio class 2
[   21.201043] I/O error, dev mmcblk0, sector 1000929 op 0x1:(WRITE) flags 0x800 phys_seg 8 prio class 2
[   21.218287] I/O error, dev mmcblk0, sector 1000945 op 0x1:(WRITE) flags 0x800 phys_seg 80 prio class 2
[   21.218623] I/O error, dev mmcblk0, sector 1001033 op 0x1:(WRITE) flags 0x800 phys_seg 24 prio class 2
[   21.236813] I/O error, dev mmcblk0, sector 1001097 op 0x1:(WRITE) flags 0x800 phys_seg 8 prio class 2
[   21.237146] I/O error, dev mmcblk0, sector 1001121 op 0x1:(WRITE) flags 0x800 phys_seg 24 prio class 2
[   21.255370] I/O error, dev mmcblk0, sector 1001161 op 0x1:(WRITE) flags 0x800 phys_seg 56 prio class 2
[   21.256253] I/O error, dev mmcblk0, sector 1001249 op 0x1:(WRITE) flags 0x800 phys_seg 8 prio class 2
```

Specifically it seems to be writing 0x0 to DWMCI_HS400_DQS_EN that is
the issue, if I comment out that line it works also for my odroid-xu4
in non-hs400 mode.

Tested on odroid-xu4 with odroid-xu3_defconfig after applying the
entire series, without any other changes.

Best regards,
Henrik Grimler
