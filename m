Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AF1C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 20:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28173801CF;
	Mon, 20 Jan 2025 21:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D4CC8032B; Mon, 20 Jan 2025 21:23:59 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2CF03800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 21:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5754106F;
 Mon, 20 Jan 2025 12:24:24 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AEB93F5A1;
 Mon, 20 Jan 2025 12:23:55 -0800 (PST)
Date: Mon, 20 Jan 2025 20:22:28 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, Samuel
 Dionne-Riel <samuel@dionne-riel.com>
Subject: Re: [PATCH v2] sunxi: defconfig: Add pstore support for pinephone
Message-ID: <20250120202228.64e75216@minigeek.lan>
In-Reply-To: <20241106074947.1296774-1-andrej.skvortzov@gmail.com>
References: <20241106074947.1296774-1-andrej.skvortzov@gmail.com>
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

On Wed,  6 Nov 2024 10:49:47 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

> pstore will allow users to catch kernel crashes and report them to
> developers. Modern (Android) phones have pstore usually enabled to get
> information about kernel crash, since it's the simplest way to get
> kernel backtrace on mobile device without serial console. Usually it's
> enabled by default in distribution kernels like Debian.
> 
> CONFIG_PSTORE=y
> CONFIG_PSTORE_RAM=m
> 
> systemd has service that automatically handles pstore and saves them
> in /var/lib/pstore for later usage.
> 
> In general any DRAM address, that isn't overwritten during a boot is
> suitable for pstore.
> 
> Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
> internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
> later in the boot process. Ramdisk start address is 0x4FF00000,
> initramfs for kernel with some hacking features and debug info enabled
> can take more than 100Mb and final address will be around 0x58000000.
> Address 0x61000000 will most likely not overlap with that.

Nice commit message, good rationale.
I briefly tested the part where U-Boot injects the DT, and that works.
I wonder if this could be rolled out to a wider audience, at least we
could move the address into the generic Kconfig file, for all ARMv8
sunxi SoCs. I will let it sit for a while, and let people test it, then
we can come back to this.

> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Queued for the next PR.

Cheers,
Andre

> ---
> 
> Changes since v1:
>  - updated description with pstore usage details
> 
>  configs/pinephone_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> index 9d39204a439..7b80cc3131b 100644
> --- a/configs/pinephone_defconfig
> +++ b/configs/pinephone_defconfig
> @@ -10,6 +10,8 @@ CONFIG_DRAM_ZQ=3881949
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>  CONFIG_PINEPHONE_DT_SELECTION=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_CMD_PSTORE=y
> +CONFIG_CMD_PSTORE_MEM_ADDR=0x61000000
>  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
>  CONFIG_LED_STATUS=y
>  CONFIG_LED_STATUS_GPIO=y

