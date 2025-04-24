Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5072C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 20:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06875809D4;
	Thu, 24 Apr 2025 22:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0705580BA8; Thu, 24 Apr 2025 22:33:10 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC2D28056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 22:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.25.173])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 1CCB5B4C1B9C;
 Thu, 24 Apr 2025 22:33:04 +0200 (CEST)
Message-ID: <f7bf68ad-a1c6-41fc-990a-b8a7ded69cea@freeshell.de>
Date: Thu, 24 Apr 2025 13:33:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] doc: starfive: use jh7110_common.rst
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
 <20250424121315.144549-8-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250424121315.144549-8-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
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

Milk-V Mars has some board revisions with a push-button and transistor
logic limiting boot source selection to just SPI NOR flash or UART, but
that's something I'll get into detail on when Mars CM/Lite are
re-introduced later on or if we add Pine64 PineTab-V which have similar
limits to boot source selection. Not needed to make a change for that now.

On 4/24/25 05:13, Heinrich Schuchardt wrote:
> To avoid duplicate maintenance just include jh7110_common.rst to describe
> the usage of the different boot sources.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
> 	no change
> v3:
> 	no change
> v2:
> 	new patch
> ---
>  doc/board/starfive/milk-v_mars.rst   | 12 +--------
>  doc/board/starfive/pine64_star64.rst | 18 +------------
>  doc/board/starfive/visionfive2.rst   | 39 +---------------------------
>  3 files changed, 3 insertions(+), 66 deletions(-)
> 
> diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
> index aba9c9c53d4..ce4539a46f1 100644
> --- a/doc/board/starfive/milk-v_mars.rst
> +++ b/doc/board/starfive/milk-v_mars.rst
> @@ -57,13 +57,6 @@ environment
>  or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
>  provide a default value.
>  
> -Boot source selection
> ----------------------
> -
> -The board provides the DIP switches MSEL[1:0] to select the boot device out of
> -SPI flash, eMMC, SD-card, UART. To select booting from SD-card set the DIP
> -switches MSEL[1:0] to 10.
> -
>  Preparing the SD-Card
>  ---------------------
>  
> @@ -105,7 +98,4 @@ Copy U-Boot to the SD card
>  	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
>  	sudo umount /mnt
>  
> -Booting
> --------
> -
> -Once you plugin the sdcard and power up, you should see the U-Boot prompt.
> +.. include:: jh7110_common.rst
> diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pine64_star64.rst
> index 1df4b68e4a0..d1752c452da 100644
> --- a/doc/board/starfive/pine64_star64.rst
> +++ b/doc/board/starfive/pine64_star64.rst
> @@ -55,19 +55,6 @@ environment
>  or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
>  provide a default value.
>  
> -Boot source selection
> ----------------------
> -
> -Boot mode is selected by an MSEL-DIP marked S1804 and GPIO_0 position adjacent
> -to the 40pin GPIO header. ON/ONKE and number markings of the MSEL-DIP are
> -misleading; Instead refer to the ``L`` (0) and ``H`` (1) silkscreen for
> -accurate selection.
> -
> -+ (QSPI) Flash: 00
> -+ SD: 01
> -+ EMMC: 10
> -+ UART: 11
> -
>  Preparing the SD-Card
>  ---------------------
>  
> @@ -109,10 +96,7 @@ Copy U-Boot to the SD card
>  	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
>  	sudo umount /mnt
>  
> -Booting
> --------
> -
> -Once you plugin the sdcard and power up, you should see the U-Boot prompt.
> +.. include:: jh7110_common.rst
>  
>  Serial Number and MAC address issues
>  ------------------------------------
> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
> index 44e7fcb3a48..6f3c572f1f8 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -132,13 +132,7 @@ Program the SD card
>  	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
>  	sudo umount /mnt
>  
> -Booting
> --------
> -
> -The board provides the DIP switches MSEL[1:0] to select the boot device.
> -To select booting from SD-card set the DIP switches MSEL[1:0] to 10.
> -
> -Once you plugin the sdcard and power up, you should see the U-Boot prompt.
> +.. include:: jh7110_common.rst
>  
>  Sample boot log from StarFive VisionFive2 board
>  -----------------------------------------------
> @@ -479,34 +473,3 @@ Sample boot log from StarFive VisionFive2 board
>  
>  	Welcome to Buildroot
>  	buildroot login:
> -
> -Booting from SPI
> -----------------
> -
> -Use Building steps from "Booting from MMC using U-Boot SPL" section.
> -
> -Partition the SPI in Linux via mtdblock. (Require to boot the board in
> -SD boot mode by enabling MTD block in Linux)
> -
> -Use prebuilt image from here [1], which support to partition the SPI flash.
> -
> -
> -Program the SPI (Require to boot the board in SD boot mode)
> -
> -Execute below steps on U-Boot proper,
> -
> -.. code-block:: none
> -
> -  sf probe
> -  fatload mmc 1:3 $kernel_addr_r u-boot.itb
> -  sf update $kernel_addr_r 0x100000 $filesize
> -
> -  fatload mmc 1:3 $kernel_addr_r u-boot-spl.bin.normal.out
> -  sf update $kernel_addr_r 0x0 $filesize
> -
> -
> -Power off the board
> -
> -Change DIP switches MSEL[1:0] are set to 00, select the boot mode to flash
> -
> -Power up the board.

With that,

Reviewed-by: E Shattow <e@freeshell.de>
