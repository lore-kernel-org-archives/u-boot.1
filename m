Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B2CCE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 10:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7EE286B69;
	Mon, 25 Sep 2023 12:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E527986BB4; Mon, 25 Sep 2023 12:30:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CFC9186ACC
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53775DA7;
 Mon, 25 Sep 2023 03:31:15 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 775073F59C;
 Mon, 25 Sep 2023 03:30:36 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:30:33 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Okhunjon Sobirjonov <okhunjon72@gmail.com>
Cc: jagan@amarulasolutions.com, u-boot@lists.denx.de, Okhunjon Sobirjonov
 <Okhunjon.Sobirjonov@Mec-electronics.com>
Subject: Re: [PATCH] sunxi: R528: add SMHC2 pin pull ups support
Message-ID: <20230925113033.4db2da19@donnerap.manchester.arm.com>
In-Reply-To: <20230924102116.59856-1-okhunjon72@gmail.com>
References: <20230721134606.4505-1-andre.przywara@arm.com>
 <20230924102116.59856-1-okhunjon72@gmail.com>
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

On Sun, 24 Sep 2023 13:21:16 +0300
Okhunjon Sobirjonov <okhunjon72@gmail.com> wrote:

Hi Okhunjon,

thanks for sending this!

> Added support for on-chip EMMC(SMHC2) pin pull ups
> for sunxi R528 board. Otherwise, "No pinmux setup
> defined for MMC2" appears. Moreover, adding
> CONFIG_MMC_SUNXI_SLOT_EXTRA=2 to defconfig might be
> needed in order to inform SPL code that another MMC instance on
> top of the default 0 for booting should be considered.

The patch itself looks alright, but sunxi_mmc_init() in
drivers/mmc/sunxi_mmc.c seems to enable 8-bit mode for MMC2. Can you
double check this?

> Signed-off-by: Okhunjon Sobirjonov <Okhunjon.Sobirjonov@Mec-electronics.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

I will integrate this patch into v2 of the T113s support series.

Cheers,
Andre

> ---
>  board/sunxi/board.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index f321cd58a6..764a1ea998 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -482,6 +482,13 @@ static void mmc_pinmux_setup(int sdc)
>  			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
>  			sunxi_gpio_set_drv(pin, 2);
>  		}
> +#elif defined(CONFIG_MACH_SUN8I_R528)
> +                /* SDC2: PC2-PC7 */
> +                for (pin = SUNXI_GPC(2); pin <= SUNXI_GPC(7); pin++) {
> +                        sunxi_gpio_set_cfgpin(pin, SUNXI_GPC_SDC2);
> +                        sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
> +                        sunxi_gpio_set_drv(pin, 2);
> +                }
>  #else
>  		puts("ERROR: No pinmux setup defined for MMC2!\n");
>  #endif

