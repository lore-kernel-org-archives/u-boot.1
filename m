Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B699C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 10:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C859882B5;
	Tue, 14 May 2024 12:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E509D877AF; Tue, 14 May 2024 12:16:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8923A882D7
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 12:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E05D11007;
 Tue, 14 May 2024 03:16:33 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE1953F762;
 Tue, 14 May 2024 03:16:07 -0700 (PDT)
Date: Tue, 14 May 2024 11:16:05 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Samuel Holland <samuel@sholland.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] clk: sunxi: add EMAC and EPHY clocks and resets for
 the V3s SoC
Message-ID: <20240514111605.0910744f@donnerap.manchester.arm.com>
In-Reply-To: <20240513205609.1872861-2-mwalle@kernel.org>
References: <20240513205609.1872861-1-mwalle@kernel.org>
 <20240513205609.1872861-2-mwalle@kernel.org>
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

On Mon, 13 May 2024 22:56:08 +0200
Michael Walle <mwalle@kernel.org> wrote:

Hi,

> Add the clock gate registers as well as the reset register bits for the
> EMAC and EPHY for the V3s. These are needed by the sun8i network driver.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Compared against the manual and the Linux driver:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre

> ---
>  drivers/clk/sunxi/clk_v3s.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/sunxi/clk_v3s.c b/drivers/clk/sunxi/clk_v3s.c
> index 6524c13540e..0402d5ed190 100644
> --- a/drivers/clk/sunxi/clk_v3s.c
> +++ b/drivers/clk/sunxi/clk_v3s.c
> @@ -17,6 +17,7 @@ static struct ccu_clk_gate v3s_gates[] = {
>  	[CLK_BUS_MMC0]		= GATE(0x060, BIT(8)),
>  	[CLK_BUS_MMC1]		= GATE(0x060, BIT(9)),
>  	[CLK_BUS_MMC2]		= GATE(0x060, BIT(10)),
> +	[CLK_BUS_EMAC]		= GATE(0x060, BIT(17)),
>  	[CLK_BUS_SPI0]		= GATE(0x060, BIT(20)),
>  	[CLK_BUS_OTG]		= GATE(0x060, BIT(24)),
>  
> @@ -31,6 +32,8 @@ static struct ccu_clk_gate v3s_gates[] = {
>  	[CLK_BUS_UART1]		= GATE(0x06c, BIT(17)),
>  	[CLK_BUS_UART2]		= GATE(0x06c, BIT(18)),
>  
> +	[CLK_BUS_EPHY]		= GATE(0x070, BIT(0)),
> +
>  	[CLK_SPI0]		= GATE(0x0a0, BIT(31)),
>  
>  	[CLK_USB_PHY0]          = GATE(0x0cc, BIT(8)),
> @@ -45,12 +48,15 @@ static struct ccu_reset v3s_resets[] = {
>  	[RST_BUS_MMC0]		= RESET(0x2c0, BIT(8)),
>  	[RST_BUS_MMC1]		= RESET(0x2c0, BIT(9)),
>  	[RST_BUS_MMC2]		= RESET(0x2c0, BIT(10)),
> +	[RST_BUS_EMAC]		= RESET(0x2c0, BIT(17)),
>  	[RST_BUS_SPI0]		= RESET(0x2c0, BIT(20)),
>  	[RST_BUS_OTG]		= RESET(0x2c0, BIT(24)),
>  
>  	[RST_BUS_TCON0]		= RESET(0x2c4, BIT(4)),
>  	[RST_BUS_DE]		= RESET(0x2c4, BIT(12)),
>  
> +	[RST_BUS_EPHY]		= RESET(0x2c8, BIT(2)),
> +
>  	[RST_BUS_I2C0]		= RESET(0x2d8, BIT(0)),
>  	[RST_BUS_I2C1]		= RESET(0x2d8, BIT(1)),
>  	[RST_BUS_UART0]		= RESET(0x2d8, BIT(16)),

