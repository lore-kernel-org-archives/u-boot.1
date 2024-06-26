Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA50C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 10:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63228884A9;
	Wed, 26 Jun 2024 12:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="bZJ+MgE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77FE884BC; Wed, 26 Jun 2024 12:31:22 +0200 (CEST)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9632C884A9
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 12:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H3XPnOQkil/YHi8HjScFiD2BTHEoHq0X6gTp4LjvgVo=; b=bZJ+MgE1XWTAo/fpXOGBxnuJCr
 ifmTij1fbtPPxQhNU5Q3nDhd8rAQ7hTHqkD1oqC2eYgMRIpq1I8flewPWLpQxy8aD6VF22biPBKzs
 CEdYCwjXnZl8G8AvXCdrwDJsOnTV3YQ6cxHw2rPW2fdQdN4swxh9RzK0hFS6CB/p1foFHQCcvdQOQ
 9LUfROhVGSXkepOYFqBjheAIloWRTeBq/0OT6RQW0dgfj2C5jBFDzjIk7Jr5/whH/trLd5MH2J5Is
 pzwOkR3fOE30M6AEDadlFy062mnjx2qEmcO4z8cbA7QSbMY5G0/9MuyYmbCzxPAZs8JNBGRFfwmXb
 w9qp2sXQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
 (envelope-from <phil@nwl.cc>) id 1sMPvr-000000002dQ-2IMY;
 Wed, 26 Jun 2024 12:31:19 +0200
Date: Wed, 26 Jun 2024 12:31:19 +0200
From: Phil Sutter <phil@nwl.cc>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] arm: mvebu: Enable bootstd and other modernization
 for Synology DS414 (Armada XP) board
Message-ID: <Znvt9_7xbdccZkFd@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Tony Dinh <mibodhi@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
References: <20240615220654.10648-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615220654.10648-1-mibodhi@gmail.com>
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

Hi Tony,

On Sat, Jun 15, 2024 at 03:06:54PM -0700, Tony Dinh wrote:
[...]
> diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
> index abe6f9eb5e..f0b55fa095 100644
> --- a/board/Synology/ds414/ds414.c
> +++ b/board/Synology/ds414/ds414.c
> @@ -181,18 +181,9 @@ int board_init(void)
>  	return 0;
>  }
>  
> -int misc_init_r(void)
> +int board_late_init(void)
>  {
> -	if (!env_get("ethaddr")) {
> -		puts("Incomplete environment, populating from SPI flash\n");
> -		do_syno_populate(0, NULL);
> -	}
> -	return 0;
> -}

Could you please leave misc_init_r() in place (along with MISC_INIT_R in
defconfig)? A closer look at doc/README.enetaddr suggests that
implementing this board-specific function which acts if the environment
does not have ethaddr defined already is exactly the right thing to do.
Also, it doesn't conflict with NET_RANDOM_ETHADDR: If do_syno_populate()
succeeds, no random MAC addresses are generated. If I manually remove
the call, random MACs come into play. So having this option enabled
serves as a fallback for boxes which lack the data in flash.

> -int checkboard(void)
> -{
> -	puts("Board: DS414\n");
> -
> +	/* Do late init to ensure successful enumeration of XHCI devices */
> +	pci_init();
>  	return 0;
>  }

FWIW, booting from rear USB port worked fine for me!

> diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
> index ecf9501ba5..501ed51129 100644
> --- a/configs/ds414_defconfig
> +++ b/configs/ds414_defconfig
[...]
> @@ -25,44 +26,40 @@ CONFIG_SPL_BSS_MAX_SIZE=0x4000
>  CONFIG_SPL=y
>  CONFIG_DEBUG_UART_BASE=0xf1012000
>  CONFIG_DEBUG_UART_CLOCK=250000000
> +CONFIG_IDENT_STRING="\nSynology DS214+/DS414 2/4-Bay Diskstation"
>  CONFIG_SYS_LOAD_ADDR=0x800000
>  CONFIG_PCI=y
>  CONFIG_DEBUG_UART=y
> +CONFIG_BOOTSTD_FULL=y
>  CONFIG_BOOTDELAY=3
>  CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="console=ttyS0,115200 ip=off initrd=0x8000040,8M root=/dev/md0 rw syno_hw_version=DS414r1 ihd_num=4 netif_num=2 flash_size=8 SataLedSpecial=1 HddHotplug=1"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="sf probe; sf read ${loadaddr} 0xd0000 0x2d0000; sf read ${ramdisk_addr_r} 0x3a0000 0x430000; bootm ${loadaddr} ${ramdisk_addr_r}"

So these should not be necessary anymore with BOOTSTD. I wonder if it is
possible to provide a static bootmeth (or bootflow?) with low priority
which boots the legacy OS from flash. It could hold all the details
instead of the *_legacy env vars introduced below.

A pending issue for me is inability to 'saveenv' - the flash seems
read-only in that spot. Does it work for you?

>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
> -CONFIG_MISC_INIT_R=y
> +CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SPL_MAX_SIZE=0x1bfd0
>  CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>  CONFIG_SPL_I2C=y
> +CONFIG_SYS_PROMPT="DS414> "

Can we detect whether it is 414 or 214, BTW? bootargs_legacy contains
414-specific info as well.

[...]
> diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> index 9446acba79..89e55bf0d4 100644
> --- a/include/configs/ds414.h
> +++ b/include/configs/ds414.h
[...]
> @@ -16,14 +17,9 @@
>   * U-Boot into it.
>   */
>  
> -/* I2C */
>  #define CFG_I2C_MVTWSI_BASE0		MVEBU_TWSI_BASE
>  
> -/*
> - * mv-common.h should be defined after CMD configs since it used them
> - * to enable certain macros
> - */
> -#include "mv-common.h"
> +#define PHY_ANEG_TIMEOUT	16000	/* PHY needs a longer aneg time */

AIUI, this is a limitation of my local NIC, not the DS414 one. It just
took too long for link detection and autoneg when directly connected. A
switch should have helped. Or do you have more details?

Cheers, Phil
