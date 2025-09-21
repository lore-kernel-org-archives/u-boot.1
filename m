Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED99CAC5A5
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 00:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E9F830B4;
	Sun, 21 Sep 2025 02:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD54830CA; Sun, 21 Sep 2025 02:55:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BCF6282B07
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 02:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B10B91655;
 Sat, 20 Sep 2025 17:54:48 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 209BA3F66E;
 Sat, 20 Sep 2025 17:54:56 -0700 (PDT)
Date: Sun, 21 Sep 2025 01:54:48 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Vladimir Panov <gbr@voidland.org>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Sunil
 Mohan Adapa <sunil@medhas.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] sunxi: OLinuXino-A64 needs the CONFIG_GMAC_TX_DELAY=4
 workaround.
Message-ID: <20250921015448.16ee4735@minigeek.lan>
In-Reply-To: <20250731082953.2006406-1-gbr@voidland.org>
References: <20250731082953.2006406-1-gbr@voidland.org>
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

On Thu, 31 Jul 2025 11:29:51 +0300
Vladimir Panov <gbr@voidland.org> wrote:

Hi Vladimir,

sorry for the delay, I somehow missed your email back in July.

> Olimex OLinuXino-A64's ethernet does not work reliably by default.
> 
> It needs the CONFIG_GMAC_TX_DELAY=4 workaround mentioned here:
> https://linux-sunxi.org/Olimex_A20-OLinuXino-Lime2#GMAC_quirks

Mmh, I am a bit confused: how is this supposed to work?
CONFIG_GMAC_TX_DELAY is only used in gmac.c, which is only for the A20
GMAC, but is not used or even built for the A64.
When I build an image for a64-olinuxino-emmc_defconfig, I get the exact
same binary with and without this patch.

So how does this fix anything?

Cheers,
Andre

> Signed-off-by: Vladimir Panov <gbr@voidland.org>
> ---
> 
>  configs/a64-olinuxino-emmc_defconfig | 1 +
>  configs/a64-olinuxino_defconfig      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/configs/a64-olinuxino-emmc_defconfig
> b/configs/a64-olinuxino-emmc_defconfig index a5989fab1c6..7f333011b48
> 100644 --- a/configs/a64-olinuxino-emmc_defconfig
> +++ b/configs/a64-olinuxino-emmc_defconfig
> @@ -7,5 +7,6 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SUPPORT_EMMC_BOOT=y
>  CONFIG_SUN8I_EMAC=y
> +CONFIG_GMAC_TX_DELAY=4
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_OHCI_HCD=y
> diff --git a/configs/a64-olinuxino_defconfig
> b/configs/a64-olinuxino_defconfig index 0b469c25d0d..0dd93ffa238
> 100644 --- a/configs/a64-olinuxino_defconfig
> +++ b/configs/a64-olinuxino_defconfig
> @@ -6,5 +6,6 @@ CONFIG_MACH_SUN50I=y
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SUN8I_EMAC=y
> +CONFIG_GMAC_TX_DELAY=4
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_OHCI_HCD=y

