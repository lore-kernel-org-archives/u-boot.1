Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD69EE2085
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 10:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 553E5838FA;
	Fri,  6 Feb 2026 11:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WCEUp3Ms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D36C83A64; Fri,  6 Feb 2026 11:54:28 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C018352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 11:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 1F1DFC22F79
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 10:54:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9604F60729;
 Fri,  6 Feb 2026 10:54:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 29B84119D1C2E; Fri,  6 Feb 2026 11:54:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1770375264; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8pYXETqH4Y9NkpMpWwIjx0Py94J73StZx5dF+X6tAh0=;
 b=WCEUp3MsjI2JMB8kEIXJuPtROphi85IqGrxB4VN9PNnXAhyYsPOEkAQPF7k9ExOg1x/WW5
 krOhB+YwozQev3E3NTE/wg19PlN/R4Nga5AusQN+Yu1RPl35V/VPpshmNTGn0LobQnUVg8
 tA20WXGklY2xG78aRwxcgwlHj1LGhwS/9OCRv8TSLX81vOBFWMVXCvtQ36J0a5niCcDx71
 KQa8Kt7vY1uA7KKmIZ8YfvYYKrkngY8jAqzQ7DyDnRfeM1/mMY/A2dAlx2Zjmh6IDfPxzZ
 YZOW9WoAegD6obKvFdyN2jjA2hiZsZgAFNXx0ql9RMiYvwSCehBLJ1ZF/EM7nQ==
Message-ID: <2f27e752-026d-411a-8fab-4da27abae862@bootlin.com>
Date: Fri, 6 Feb 2026 11:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: j722s: Update SoC data to add wake-up I2C
 device
To: Chintan Vankar <c-vankar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: bb@ti.com, s-vadapalli@ti.com, p-mantena@ti.com, a-kumar2@ti.com,
 u-boot@lists.denx.de
References: <20260205121551.3619582-1-c-vankar@ti.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260205121551.3619582-1-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 05/02/2026 à 13:15, Chintan Vankar a écrit :
> Update dev-data and clk-data to include wake-up I2C device for J722s.
> 
Tested it on j722 evm, I can now access the PMIC via I2C

Thanks!

Tested-by: Richard Genoud <richard.genoud@bootlin.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> This patch is based on commit 'b5213bbfdcb1' of origin/master branch of
> U-Boot.
> 
>   arch/arm/mach-k3/r5/j722s/clk-data.c | 10 +++++++++-
>   arch/arm/mach-k3/r5/j722s/dev-data.c |  3 ++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/r5/j722s/clk-data.c b/arch/arm/mach-k3/r5/j722s/clk-data.c
> index cb3d864c5a3..de8c43314c7 100644
> --- a/arch/arm/mach-k3/r5/j722s/clk-data.c
> +++ b/arch/arm/mach-k3/r5/j722s/clk-data.c
> @@ -5,7 +5,7 @@
>    * This file is auto generated. Please do not hand edit and report any issues
>    * to Bryan Brattlof <bb@ti.com>.
>    *
> - * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <linux/clk-provider.h>
> @@ -159,6 +159,7 @@ static const struct clk_data clk_list[] = {
>   	CLK_FIXED_RATE("board_0_rmii1_ref_clk_out", 0, 0),
>   	CLK_FIXED_RATE("board_0_rmii2_ref_clk_out", 0, 0),
>   	CLK_FIXED_RATE("board_0_tck_out", 0, 0),
> +	CLK_FIXED_RATE("board_0_wkup_i2c0_scl_out", 0, 0),
>   	CLK_FIXED_RATE("cpsw_3guss_am67_main_0_cpts_genf0", 0, 0),
>   	CLK_FIXED_RATE("cpsw_3guss_am67_main_0_cpts_genf1", 0, 0),
>   	CLK_FIXED_RATE("cpsw_3guss_am67_main_0_mdio_mdclk_o", 0, 0),
> @@ -223,6 +224,8 @@ static const struct clk_data clk_list[] = {
>   	CLK_MUX("wkup_clkout_sel_io_out0", wkup_clkout_sel_io_out0_parents, 2, 0x43008020, 24, 1, 0),
>   	CLK_MUX("wkup_clksel_out0", wkup_clksel_out0_parents, 2, 0x43008010, 0, 1, 0),
>   	CLK_MUX("main_usart0_fclk_sel_out0", main_usart0_fclk_sel_out0_parents, 2, 0x108280, 0, 1, 0),
> +	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout1_clk", "pllfracf2_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040084, 0, 7, 0, 0),
> +	CLK_FIXED_RATE("mshsi2c_wkup_0_porscl", 0, 0),
>   	CLK_DIV("sam62_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
>   	CLK_DIV("sam62_pll_ctrl_wrap_mcu_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", 0x402011c, 0, 5, 0, 0),
>   };
> @@ -307,6 +310,11 @@ static const struct dev_clk soc_dev_clk_data[] = {
>   	DEV_CLK(102, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
>   	DEV_CLK(102, 1, "board_0_i2c0_scl_out"),
>   	DEV_CLK(102, 2, "hsdiv4_16fft_main_1_hsdivout0_clk"),
> +	DEV_CLK(107, 0, "wkup_clksel_out0"),
> +	DEV_CLK(107, 1, "hsdiv3_16fft_main_15_hsdivout0_clk"),
> +	DEV_CLK(107, 2, "hsdiv4_16fft_mcu_0_hsdivout0_clk"),
> +	DEV_CLK(107, 3, "board_0_wkup_i2c0_scl_out"),
> +	DEV_CLK(107, 4, "hsdiv4_16fft_mcu_0_hsdivout1_clk"),
>   	DEV_CLK(135, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
>   	DEV_CLK(146, 0, "main_usart0_fclk_sel_out0"),
>   	DEV_CLK(146, 1, "usart_programmable_clock_divider_out0"),
> diff --git a/arch/arm/mach-k3/r5/j722s/dev-data.c b/arch/arm/mach-k3/r5/j722s/dev-data.c
> index 5f7e2a44fed..0ffef09a1d5 100644
> --- a/arch/arm/mach-k3/r5/j722s/dev-data.c
> +++ b/arch/arm/mach-k3/r5/j722s/dev-data.c
> @@ -5,7 +5,7 @@
>    * This file is auto generated. Please do not hand edit and report any issues
>    * to Bryan Brattlof <bb@ti.com>.
>    *
> - * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include "k3-dev.h"
> @@ -42,6 +42,7 @@ static struct ti_dev soc_dev_list[] = {
>   	PSC_DEV(16, &soc_lpsc_list[0]),
>   	PSC_DEV(77, &soc_lpsc_list[0]),
>   	PSC_DEV(61, &soc_lpsc_list[0]),
> +	PSC_DEV(107, &soc_lpsc_list[0]),
>   	PSC_DEV(178, &soc_lpsc_list[1]),
>   	PSC_DEV(179, &soc_lpsc_list[2]),
>   	PSC_DEV(57, &soc_lpsc_list[3]),


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
