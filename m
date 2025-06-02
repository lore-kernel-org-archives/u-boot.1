Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5380CC5B543
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 00:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1AB882A8D;
	Mon,  2 Jun 2025 02:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7326182A25; Mon,  2 Jun 2025 02:41:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 781A282A76
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 02:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709481515;
 Sun,  1 Jun 2025 17:40:49 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12E483F673;
 Sun,  1 Jun 2025 17:41:04 -0700 (PDT)
Date: Mon, 2 Jun 2025 01:40:24 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/6] sunxi: pinecube: Enable EMAC and network support
Message-ID: <20250602014024.2476a87a@minigeek.lan>
In-Reply-To: <20250601153943.2690123-5-contact@paulk.fr>
References: <20250601153943.2690123-1-contact@paulk.fr>
 <20250601153943.2690123-5-contact@paulk.fr>
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

On Sun,  1 Jun 2025 17:39:41 +0200
Paul Kocialkowski <contact@paulk.fr> wrote:

Hi,

> The pinecube has an ethernet connector which uses the EMAC and internal
> PHY of the chip. Enable it in the config.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  configs/pinecube_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
> index ea40d227bd53..2741e7ed9079 100644
> --- a/configs/pinecube_defconfig
> +++ b/configs/pinecube_defconfig
> @@ -7,13 +7,13 @@ CONFIG_DRAM_CLK=504
>  CONFIG_DRAM_ODT_EN=y
>  # CONFIG_HAS_ARMV7_SECURE_BASE is not set
>  CONFIG_SPL_I2C=y
> -CONFIG_NO_NET=y
>  CONFIG_SPL_SYS_I2C_LEGACY=y
>  CONFIG_SYS_I2C_MVTWSI=y
>  CONFIG_SYS_I2C_SLAVE=0x7f
>  CONFIG_SYS_I2C_SPEED=400000
>  CONFIG_MTD=y
>  CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SUN8I_EMAC=y
>  CONFIG_AXP209_POWER=y
>  CONFIG_AXP_DCDC2_VOLT=1250
>  CONFIG_AXP_DCDC3_VOLT=3300

