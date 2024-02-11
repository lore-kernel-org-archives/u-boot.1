Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D11C4829B
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 23:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0EC878E9;
	Mon, 12 Feb 2024 00:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D458786C; Mon, 12 Feb 2024 00:45:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E245F87971
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 00:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C53E2DA7;
 Sun, 11 Feb 2024 15:45:56 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2FB03F5A1;
 Sun, 11 Feb 2024 15:45:13 -0800 (PST)
Date: Sun, 11 Feb 2024 23:43:59 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Philippe Coval <rzr@users.sf.net>
Cc: u-boot@lists.denx.de, Olliver Schinagl <oliver@schinagl.nl>, Priit Laes
 <plaes@plaes.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Hans de Goede
 <hdegoede@redhat.com>, Jagan Teki <jagan@amarulasolutions.com>, Sam Edwards
 <CFSworks@gmail.com>, Samuel Holland <samuel@sholland.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2] arm: sunxi: Reduce inrush current on Olimex
 A20-OLinuXino_MICRO configs
Message-ID: <20240211234359.3d217873@minigeek.lan>
In-Reply-To: <20240211205227.503969-1-rzr@users.sf.net>
References: <20240211205227.503969-1-rzr@users.sf.net>
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

On Sun, 11 Feb 2024 21:52:13 +0100
Philippe Coval <rzr@users.sf.net> wrote:

Hi Philippe,

> This change fix reboot, both configurations
> were tested on my Olimex A20 Micro Rev E with debian-12.
> 
> This issue was also present and fixed on A20 Lime2 (in 8311e84b18),
> quoting Olliver Schinagl:
> 
>     The lime2 features a too large capacitor on the LDO3 output, which
>     causes the PMIC to shutdown when enabling power. To be able to still
>     boot up however, we must gradually enable power on LDO3 for this board.
>     We do this by enabling both the inrush quirk and the maximum slope the
>     AXP209 supports.
> 
> Link: https://bugs.debian.org/1060752
> Cc: Olliver Schinagl <oliver@schinagl.nl>
> Cc: Priit Laes <plaes@plaes.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Philippe Coval <rzr@users.sf.net>

Thanks for the changes, this looks good to me now.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

I will queue this for the sunxi/master.

Cheers,
Andre

> ---
> 
> Changes in v2:
> - Add qirk to eMMC configuration of same machine
> 
>  configs/A20-OLinuXino_MICRO-eMMC_defconfig | 1 +
>  configs/A20-OLinuXino_MICRO_defconfig      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/configs/A20-OLinuXino_MICRO-eMMC_defconfig b/configs/A20-OLinuXino_MICRO-eMMC_defconfig
> index ca5869f43d..2f26b0ca01 100644
> --- a/configs/A20-OLinuXino_MICRO-eMMC_defconfig
> +++ b/configs/A20-OLinuXino_MICRO-eMMC_defconfig
> @@ -20,6 +20,7 @@ CONFIG_ETH_DESIGNWARE=y
>  CONFIG_MII=y
>  CONFIG_SUN7I_GMAC=y
>  CONFIG_SUN7I_GMAC_FORCE_TXERR=y
> +CONFIG_AXP_ALDO3_INRUSH_QUIRK=y
>  CONFIG_AXP_ALDO3_VOLT=2800
>  CONFIG_AXP_ALDO4_VOLT=2800
>  CONFIG_SCSI=y
> diff --git a/configs/A20-OLinuXino_MICRO_defconfig b/configs/A20-OLinuXino_MICRO_defconfig
> index db4270f9b2..673ab85c8a 100644
> --- a/configs/A20-OLinuXino_MICRO_defconfig
> +++ b/configs/A20-OLinuXino_MICRO_defconfig
> @@ -20,6 +20,7 @@ CONFIG_ETH_DESIGNWARE=y
>  CONFIG_MII=y
>  CONFIG_SUN7I_GMAC=y
>  CONFIG_SUN7I_GMAC_FORCE_TXERR=y
> +CONFIG_AXP_ALDO3_INRUSH_QUIRK=y
>  CONFIG_AXP_ALDO3_VOLT=2800
>  CONFIG_AXP_ALDO4_VOLT=2800
>  CONFIG_SCSI=y

