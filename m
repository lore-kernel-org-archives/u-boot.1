Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D825CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64536836A6;
	Fri, 29 Aug 2025 16:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A782836A6; Fri, 29 Aug 2025 16:31:50 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 66CB8836D2
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 16:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EB2119F0;
 Fri, 29 Aug 2025 07:31:39 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C25623F694;
 Fri, 29 Aug 2025 07:31:46 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:31:24 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] Allwinner: fix booting on a number of devices
Message-ID: <20250829153124.55f35ac6@minigeek.lan>
In-Reply-To: <20250827075017.1583168-1-pbrobinson@gmail.com>
References: <20250827075017.1583168-1-pbrobinson@gmail.com>
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

On Wed, 27 Aug 2025 08:50:14 +0100
Peter Robinson <pbrobinson@gmail.com> wrote:

Hi Peter,

thanks for the report!

> Revert "sunxi: enable MMU_PGPROT proper page table protection"
> 
> This reverts commit 16cfccda4dbf0b53473b8212897f5c63bfbeb6e1.
> 
> This causes the follow issue on the A64 boards I have including
> Pine64+, Pine64-LTS and the Pinephone. Revert until the issue
> can be properly investigated.
> 
> CPU:   Allwinner A64 (SUN50I)
> Model: Pine64+
> DRAM:  2 GiB
> Insufficient RAM for page table: 0x5000 > 0x4000. Please increase the size in get_page_table_size()

Mmh, how did you get this? I just ran mainline on a Pine64-LTS, and
didn't see any issues. Are you running on some specific setup? I am on
GCC 11.2.0, TF-A is some v2.12.0-724-gf745e004a, and that's with
pine64-lts_defconfig.

> resetting ...
> System reset not supported on this platform
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  arch/arm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 40368abc297..b8be270e4d7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1207,7 +1207,6 @@ config ARCH_SUNXI
>  	select DM_SPI_FLASH if SPI && MTD
>  	select DM_KEYBOARD
>  	select DM_SERIAL
> -	select MMU_PGPROT if ARM64

Regardless that's quite a sledgehammer. If that's a real issue, we
could surely provide our own get_page_table_size() implementation which
is more generous?

Cheers,
Andre

>  	select OF_BOARD_SETUP
>  	select OF_CONTROL
>  	select PINCTRL

