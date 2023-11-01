Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D53FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A316B87B35;
	Wed,  1 Nov 2023 13:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0980F86A4B; Wed,  1 Nov 2023 13:35:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 91F5587B35
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEEE42F4;
 Wed,  1 Nov 2023 05:36:10 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2515D3F738;
 Wed,  1 Nov 2023 05:35:28 -0700 (PDT)
Date: Wed, 1 Nov 2023 12:35:25 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Samuel Holland <samuel@sholland.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH] clk: sunxi: Use the right symbol in the Makefile
Message-ID: <20231101123525.2aa95276@donnerap.manchester.arm.com>
In-Reply-To: <20231031044925.51756-1-samuel@sholland.org>
References: <20231031044925.51756-1-samuel@sholland.org>
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

On Mon, 30 Oct 2023 23:49:22 -0500
Samuel Holland <samuel@sholland.org> wrote:

> CONFIG_ARCH_SUNXI will not be enabled for RISC-V SoCs using this driver.
> Use the symbol for the driver itself instead.

That works, no changes at all in all sunxi binaries after this patch.

> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
> 
>  drivers/clk/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 26bf429acbc..af27ceb27da 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -27,7 +27,6 @@ obj-$(CONFIG_ARCH_ROCKCHIP) += rockchip/
>  obj-$(CONFIG_ARCH_SOCFPGA) += altera/
>  obj-$(CONFIG_ARCH_STM32) += stm32/
>  obj-$(CONFIG_ARCH_STM32MP) += stm32/
> -obj-$(CONFIG_ARCH_SUNXI) += sunxi/
>  obj-$(CONFIG_CLK_AT91) += at91/
>  obj-$(CONFIG_CLK_BCM6345) += clk_bcm6345.o
>  obj-$(CONFIG_CLK_BOSTON) += clk_boston.o
> @@ -43,6 +42,7 @@ obj-$(CONFIG_CLK_OWL) += owl/
>  obj-$(CONFIG_CLK_RENESAS) += renesas/
>  obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
>  obj-$(CONFIG_CLK_SIFIVE) += sifive/
> +obj-$(CONFIG_CLK_SUNXI) += sunxi/
>  obj-$(CONFIG_CLK_UNIPHIER) += uniphier/
>  obj-$(CONFIG_CLK_VERSACLOCK) += clk_versaclock.o
>  obj-$(CONFIG_CLK_VERSAL) += clk_versal.o

