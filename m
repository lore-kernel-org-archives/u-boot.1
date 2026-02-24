Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025E2E9B24E
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 12:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7458683642;
	Tue, 24 Feb 2026 13:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C2BF83D3D; Tue, 24 Feb 2026 13:01:09 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C94782BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 13:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vur64-000000004kG-0UF5; Tue, 24 Feb 2026 12:01:00 +0000
Date: Tue, 24 Feb 2026 12:00:57 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tommy Shih <tommy.shih@airoha.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien . Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 frank-w@public-files.de, u-boot@lists.denx.de,
 Lucien Jheng <lucien.jheng@airoha.com>
Subject: Re: [PATCH v1] net: phy: air_en8811: add support for Airoha AN8811HB
 PHY
Message-ID: <aZ2S-UhkJogfU0ug@makrotopia.org>
References: <20260224110403.418941-1-tommy.shih@airoha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224110403.418941-1-tommy.shih@airoha.com>
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

On Tue, Feb 24, 2026 at 07:02:50PM +0800, Tommy Shih wrote:
> Add support for the Airoha AN8811HB 2.5 Gigabit PHY to the existing
> en8811h driver. This PHY supports 10/100/1000/2500 Mbps speeds.
> 
> Update the driver to recognize the AN8811HB PHY ID and handle its
> specific firmware loading requirements. The firmware loading mechanism
> remains consistent with the existing implementation.
> 
> This driver is based on:
>   - Linux upstream PHY subsystem (v7.0-rc1)
>   - air_an8811hb v0.0.4 out-of-tree uboot driver written by
>     "Lucien.Jheng <lucien.jheng@airoha.com>"
> 
> Tested on MT7987 RFB board.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6f1769ec5892ac41d82e820d94dcdc68e904aa99
> Link: https://patchwork.kernel.org/project/netdevbpf/patch/20260122071601.1057083-3-bjorn@mork.no/
> Signed-off-by: Tommy Shih <tommy.shih@airoha.com>
> Reviewed-by: Lucien.Jheng <lucienzx159@gmail.com>
> 
> ---
> 
>  drivers/net/phy/airoha/Kconfig      |   2 +-
>  drivers/net/phy/airoha/air_en8811.c | 695 ++++++++++++++++++++++++++--
>  2 files changed, 652 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
> index 999564e4848..fcace9a24ac 100644
> --- a/drivers/net/phy/airoha/Kconfig
> +++ b/drivers/net/phy/airoha/Kconfig
> @@ -8,4 +8,4 @@ config PHY_AIROHA_EN8811
>  	select FW_LOADER
>  	help
>  	  AIROHA EN8811H supported.
> -
> +	  AIROHA AN8811HB supported.
> diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
> index 1a628ede82b..974887da33d 100644
> --- a/drivers/net/phy/airoha/air_en8811.c
> +++ b/drivers/net/phy/airoha/air_en8811.c
> @@ -1,46 +1,37 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Driver for the Airoha EN8811H 2.5 Gigabit PHY.
> + * Driver for the Airoha EN8811H and AN8811HB 2.5 Gigabit PHY.
>   *
> - * Limitations of the EN8811H:
> + * Limitations:
>   * - Only full duplex supported
>   * - Forced speed (AN off) is not supported by hardware (100Mbps)
>   *
>   * Source originated from linux air_en8811h.c
>   *
> - * Copyright (C) 2025 Airoha Technology Corp.
> + * Copyright (C) 2025, 2026 Airoha Technology Corp.
>   */
> -
>  #include <phy.h>
>  #include <errno.h>
>  #include <log.h>
>  #include <env.h>
>  #include <malloc.h>
> +#include <fs.h>

I don't see where you are using anything provided by the fs.h header.

>  #include <fw_loader.h>
>  #include <asm/unaligned.h>
> +#include <version.h>
> +#include <linux/delay.h>
>  #include <linux/iopoll.h>
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  #include <linux/compat.h>
> +#include <linux/kernel.h>

... and for sure you don't need that one.

>  #include <dm/device_compat.h>
>  #include <u-boot/crc.h>

Please carefully check which additional headers are actually needed.
