Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DE8CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D7A2605E1;
	Mon, 12 Oct 2026 09:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OrUZY1WDssbv; Mon, 12 Oct 2026 09:04:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8BCB7605F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791795883;
	b=s9rcxIAVRYcnhc1yldeoIVG8RtMtSWG1pwSNixZRAAyZmdbff29HpC7uQwRT4GSAgISa
	 SRxTbEP8lak/i5pHjwt4rKdlSay6pb2eXsPZwRWkr0kTTFbjh6IaQLCOZCmBVOKjQZy7N
	 kLKKv9HXFvBy655tYtvqLGsHxXo747pY3sdEKSxBrVILTRp5Toz26nNJe+jGg7fKc0Nrg
	 ubUX/3gA2It1y1wxYpaYBH6GKv/VbrNOavJm9b+WMdsyFeqp5PbZ6wHC/4z3gDx2RTbN1
	 JjDpRRpPWvge3ICbemPTrKkYq2aHev7SN1UKqF+ADCwJzlCm8sVVa1BVb1uXEsbouYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791795883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lSbnIlHG75e6RSZhc5aRE+EpNy4vCN1A7R5GRvmM18o=;
	b=JY2mvnYl/FsDczwMxoEaOqtgyG+B25AvrW/ZQYIbk9xBBQS2FBQUTgcUbmIMh8BUYqnd
	 5/f+YZK3yOHYONm3o4pFkX1Z5m4LbQCk2J6jz1uVXDPVAH/OpEkNV6ARd+frxfsx2y27g
	 WUQ2MTXk2whiyzSy7cpXOgdK7jAxgUCQCymkyymiEw0r1ZcJh6LCfn6mhHyEOYSSBbTnc
	 ugmirN7dHcbJkqWiefQBTArxnXXY8gwNCCNhz8+vWsFCNKRQp7FMOhsYe1Ec3ZiZIOEBt
	 HGjGIysArqvRhKWP4+hSEyNRKplTvjQoko5k1AhTfewcbxuEgXEDvQSc/lElZ9YV0Fw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791795883;
	bh=lSbnIlHG75e6RSZhc5aRE+EpNy4vCN1A7R5GRvmM18o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CbaeyB21ZIy2mSV1qBVdigBkwan7JcuTkLUpLIxQIapSk4FHgKF44hRs9ZQbojIbX
	 vancKrURTKekwLlgFMdmYPxomgoPRjP0+kKYwfk5Jo4wVtvAiDG1MqrMeg2Nb3P8Er
	 MGYkav4t6gfM2+8pq0/okXbC/LQVTNLQcLwwxu+MUV4mFoEMlJqFO3MReqlwQNJr/6
	 G7tXAFLwkv5WHG4VwRJ38ElE5AeyQ/RXg/fGeIt3Kr/vRZvilHTvVdX790BsWWhvpA
	 t0tiyQiCxGnc6Jl/4ZKBbmCM330CWGxLxoxYSFaVCSVoKy+J1im279KP0SL1wiNfu8
	 GOrQpt4vW/eWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BCB7605F4;
	Mon, 12 Oct 2026 09:04:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E1E79105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C785580BBD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D4gTRefQeZVm for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 41D3F80B80
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791795880;
 b=H3Ufi2PVhRjh5+eH8yNhuK9TcJaGE4b5k/Hqt09r18AekxDXQAjpoGZ3XeLNfRyiyC/D
 2j427upsdrnFX4I3qgM+Ah9XpVBdQDg0JDhBU3RNAPMTaan3hXy0nlszf0iQEN3gO/NqG
 rbYK683UKqDt76YVC8EuzGw8uqXeVEX3dK+6b6s1L6MD36SQAR61bBbwAtKhFgYSbNk1d
 7bmjywFMgWOJRaHhGR+S7ljxitxP0mO02C6h3zKMhsh9dLe54btqp70xyzNlK4DsC6nx1
 lg5tHpWImvUYidmYfj4jJPdz6JvKr/Bk5uMFZfGqY2/MaR1EkpBW7rzb1m4PzUDDQAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791795880;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=lSbnIlHG75e6RSZhc5aRE+EpNy4vCN1A7R5GRvmM18o=;
 b=ld3gBQ9mQvBnuZMvAKbJ/gIIB2sNxUO/hBqt+f3N0qPckdC6sFqhnbOtHyjQhaszjyJ/
 79wENR9s+b7TtRiO+B22OSYTotXSyB4tSnUqh29muI6YxnK7Rdlsgg57UVA2WElTvrmvW
 AzFlRToIQOveoDyBz2KPRILpazH98iIIj8dQ1d4zNaMVlLrfNUgBcTW9p/ZCBWTDj3HYs
 ggG0I75iX99vcWQFX29sknGqSJeD2gjtO03mn9zu7WWPKY1g/QKf4W6hpEDltfwZPE+Ih
 32f3pTKUTkWwJ2MpmMQgLfO377e4D+CtjgQH9+0/aZPke+4s8V/lC54PqGUwC+b0PgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PXCoBLGR; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PXCoBLGR
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41D3F80B80
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:04:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CA4B60DD4;
 Mon, 12 Oct 2026 09:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3FC1F008AB;
 Mon, 12 Oct 2026 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791795877;
 bh=lSbnIlHG75e6RSZhc5aRE+EpNy4vCN1A7R5GRvmM18o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PXCoBLGRjRW/tEZ56tFuSKhfMYGG+UhTYBt/M7MdkhFfvEMOe+bDYIlIvfQEKBu6X
 sogzhyFzaJQ407IY6gsYpBJnoO1BRQGWcgbmyny26udBmw/pD5jbHf7vezRGDrgBfb
 vGyRGyPJ9L1FTvjNS9MwqJGezDOjgVPSEwJlfFwDtAyVwQT0C8+DdOf+hVlJGIeJKt
 gGFmLkLaGoTkLyyPxTBUgo/ggLFKyRxToMXdHX+WjL5YXnBhP0CnyF8R8fWAc+y8hz
 4iV0Ady0yNDKf5Cv1bxV8P+LWe+1VQ5pTH6FJlkNeVHwdSOoB39Nuzbj/sw/c49zz/
 DDyQ6yYAozCow==
Date: Mon, 12 Oct 2026 09:04:34 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 1/2] phy: spacemit: add K1 USB 2.0 PHY driver
Message-ID: <20261012090434-GKF26088@kernel.org>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-0001.DaveWK225@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006T020608-0400.uboot-k1-usb-v2-0001.DaveWK225@protonmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Dave,

On 12:32 Tue 06 Oct     , Dave Klotz wrote:
> The UTMI PHY at c0a30000 ("spacemit,k1-usb2-phy") feeds the K1's DWC3
> USB 3 controller. Port the Linux driver: enable the PHY clock, program
> the PLL divider for the 24 MHz reference, wait for the PLL, then release
> the PHY's resets and enable its clocks, the HS TX clock and the
> automatic host-disconnect clear.
> 
..
> The divider has to be written before the PLL is polled. On the OrangePi
Right, the upstream kernel driver also did this way

> R2S under FreeBSD, a driver that polled first and never wrote it left
> the PLL stopped: the clock enables did not latch (0x60ef read back as
Sorry, I've not fully understood here, "polled first and never write"..
Could you elaborate more on this?

> 0x60e9), the PHY gave the controller no UTMI clock and the xHCI reset
> (USBCMD.HCRST) never completed. Warn if the enables do not latch.
Will comment at code below

> 
> Also apply the vendor's HS DAC current setting (+15 %), which the
> FreeBSD driver that runs the R2S port does.
> 
Any actual problem without above settings? I'm just curious,
as upstream code miss this part

> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  MAINTAINERS                        |   1 +
>  drivers/phy/spacemit/Kconfig       |   9 ++
>  drivers/phy/spacemit/Makefile      |   1 +
>  drivers/phy/spacemit/phy-k1-usb2.c | 173 +++++++++++++++++++++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/phy/spacemit/phy-k1-usb2.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e09f9506c..0af42acfbc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1517,6 +1517,7 @@ M:	Yixun Lan <dlan@kernel.org>
>  S:	Maintained
>  T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit.git
>  F:	arch/riscv/dts/k1-*-u-boot.dtsi
> +F:	drivers/phy/spacemit/phy-k1-usb2.c
>  N:	spacemit
>  K:	spacemit
>  
> diff --git a/drivers/phy/spacemit/Kconfig b/drivers/phy/spacemit/Kconfig
> index 3c47601c1f..7146965d92 100644
> --- a/drivers/phy/spacemit/Kconfig
> +++ b/drivers/phy/spacemit/Kconfig
> @@ -9,3 +9,12 @@ config PHY_SPACEMIT_K1_PCIE
>  	  ports B and C.  The combo PHY must be enabled even if port A
>  	  is not used for PCIe, because it provides calibration values
>  	  required by the other ports.
> +
> +config PHY_SPACEMIT_K1_USB2
> +	bool "SpacemiT K1 USB 2.0 PHY driver"
> +	depends on PHY && CLK
> +	help
> +	  Enable this to support the USB 2.0 (UTMI) PHY of the SpacemiT K1
> +	  SoC, used by its DWC3 USB 3 controller. The driver configures the
> +	  PLL for the 24 MHz reference clock, releases the internal resets
> +	  and enables the PHY clocks before the controller is started.
> diff --git a/drivers/phy/spacemit/Makefile b/drivers/phy/spacemit/Makefile
> index 3496c099cd..cad47d11bf 100644
> --- a/drivers/phy/spacemit/Makefile
> +++ b/drivers/phy/spacemit/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_PHY_SPACEMIT_K1_PCIE) += phy-k1-pcie.o
> +obj-$(CONFIG_PHY_SPACEMIT_K1_USB2) += phy-k1-usb2.o
> diff --git a/drivers/phy/spacemit/phy-k1-usb2.c b/drivers/phy/spacemit/phy-k1-usb2.c
> new file mode 100644
> index 0000000000..c4b438219b
> --- /dev/null
> +++ b/drivers/phy/spacemit/phy-k1-usb2.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SpacemiT K1 USB 2.0 (UTMI) PHY driver
> + *
> + * Ported from the Linux SpacemiT K1 USB 2.0 PHY driver:
> + * Copyright (C) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
> + * Copyright (C) 2025 Ze Huang <huang.ze@linux.dev>
> + *
> + * The HS DAC current setting and the clock-enable check follow the FreeBSD
> + * spacemit_usb2phy driver (BSD-2-Clause), which brought USB up on the
> + * OrangePi R2S:
> + * Copyright (c) 2026 Daniel Shue <dgshue@gmail.com>
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <generic-phy.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#define PHY_RST_MODE_CTRL		0x04
> +#define  PHY_PLL_RDY			BIT(0)
> +#define  PHY_CLK_CDR_EN			BIT(1)
> +#define  PHY_CLK_PLL_EN			BIT(2)
> +#define  PHY_CLK_MAC_EN			BIT(3)
> +#define  PHY_MAC_RSTN			BIT(5)
> +#define  PHY_CDR_RSTN			BIT(6)
> +#define  PHY_PLL_RSTN			BIT(7)
> +#define  PHY_HS_LINE_TX_MODE		BIT(13)
> +#define  PHY_FS_LINE_TX_MODE		BIT(14)
> +
> +#define  PHY_INIT_MODE_BITS		(PHY_FS_LINE_TX_MODE | PHY_HS_LINE_TX_MODE)
> +#define  PHY_CLK_ENABLE_BITS		(PHY_CLK_PLL_EN | PHY_CLK_CDR_EN | \
> +					 PHY_CLK_MAC_EN)
> +#define  PHY_DEASSERT_RST_BITS		(PHY_PLL_RSTN | PHY_CDR_RSTN | \
> +					 PHY_MAC_RSTN)
> +
> +#define PHY_TX_HOST_CTRL		0x10
> +#define  PHY_HST_DISC_AUTO_CLR		BIT(2)
> +
> +#define PHY_HSTXP_HW_CTRL		0x34
> +#define  PHY_HSTXP_RSTN			BIT(2)
> +#define  PHY_CLK_HSTXP_EN		BIT(3)
> +#define  PHY_HSTXP_MODE			BIT(4)
> +
> +#define PHY_PLL_DIV_CFG			0x98
> +#define  PHY_FDIV_FRACT_8_15		GENMASK(7, 0)
> +#define  PHY_FDIV_FRACT_16_19		GENMASK(11, 8)
> +#define  PHY_FDIV_FRACT_20_21		BIT(12)
> +#define  PHY_FDIV_FRACT_0_1		GENMASK(14, 13)
> +#define  PHY_DIV_LOCAL_EN		BIT(15)
> +
> +#define  PHY_SEL_FREQ_24MHZ		0x01
> +#define  FDIV_REG_MASK			(PHY_FDIV_FRACT_20_21 | PHY_FDIV_FRACT_16_19 | \
> +					 PHY_FDIV_FRACT_8_15)
> +#define  FDIV_REG_VAL			0x1ec4
> +
> +/* Vendor HS DAC current setting: +15 % drive, current regulator on */
> +#define PHY_ANALOG_REG14_13		0xa4
> +#define  PHY_HSDAC_ISEL			GENMASK(3, 0)
> +#define  PHY_HSDAC_ISEL_15_INC		0xc
> +#define  PHY_HSDAC_IREG_EN		BIT(4)
> +
> +#define K1_USB2PHY_PLL_TIMEOUT_US	50000
> +
> +struct spacemit_usb2phy {
> +	void __iomem *base;
> +	struct clk clk;
> +};
> +
> +static int spacemit_usb2phy_init(struct phy *phy)
> +{
> +	struct spacemit_usb2phy *sphy = dev_get_priv(phy->dev);
> +	void __iomem *base = sphy->base;
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_enable(&sphy->clk);
> +	if (ret) {
> +		dev_err(phy->dev, "failed to enable clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Let any controller reset settle before touching the PHY */
> +	udelay(200);
> +
> +	/*
> +	 * Program the PLL divider for the 24 MHz reference first. Until it is
> +	 * written the PLL does not run, the clock enables below do not latch
> +	 * and the PHY gives the DWC3 no UTMI clock, so the xHCI reset
> +	 * (USBCMD.HCRST) never completes. Found on the OrangePi R2S under
> +	 * FreeBSD, whose earlier driver polled for the PLL before this write.
> +	 */
> +	val = FIELD_PREP(FDIV_REG_MASK, FDIV_REG_VAL) |
> +	      FIELD_PREP(PHY_FDIV_FRACT_0_1, PHY_SEL_FREQ_24MHZ) |
> +	      PHY_DIV_LOCAL_EN;
> +	writel(val, base + PHY_PLL_DIV_CFG);
> +
> +	ret = readl_poll_timeout(base + PHY_RST_MODE_CTRL, val,
> +				 val & PHY_PLL_RDY, K1_USB2PHY_PLL_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(phy->dev, "PLL lock timeout\n");
> +		clk_disable(&sphy->clk);
> +		return ret;
> +	}
> +
> +	/* Release the PHY's internal resets and enable its clocks */
> +	writel(PHY_INIT_MODE_BITS | PHY_CLK_ENABLE_BITS | PHY_DEASSERT_RST_BITS,
> +	       base + PHY_RST_MODE_CTRL);
..
> +	val = readl(base + PHY_RST_MODE_CTRL);
> +	if ((val & PHY_CLK_ENABLE_BITS) != PHY_CLK_ENABLE_BITS)
> +		dev_warn(phy->dev, "clock enables did not latch (%#x)\n", val);
So read back and check.. if this situation is happening, a warning
message won't save life.

But, I need to check if the "enable bits" actually reflect the clock
enabling status from the hardware perspective.. but even leave that alone,
I think using a poll() instead of a readl() is a more proper way to go?
usually it will take few time for the hardware to settle down..

> +
> +	writel(PHY_HSTXP_RSTN | PHY_CLK_HSTXP_EN | PHY_HSTXP_MODE,
> +	       base + PHY_HSTXP_HW_CTRL);
> +
> +	clrsetbits_le32(base + PHY_ANALOG_REG14_13, PHY_HSDAC_ISEL,
> +			FIELD_PREP(PHY_HSDAC_ISEL, PHY_HSDAC_ISEL_15_INC) |
> +			PHY_HSDAC_IREG_EN);
> +
> +	/* Auto-clear the HS host disconnect state on reconnect */
> +	setbits_le32(base + PHY_TX_HOST_CTRL, PHY_HST_DISC_AUTO_CLR);
> +
> +	return 0;
> +}

-- 
Yixun Lan (dlan)
