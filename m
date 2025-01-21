Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7F1C02181
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 01:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C44DE800CF;
	Tue, 21 Jan 2025 02:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DF3E801CF; Tue, 21 Jan 2025 02:08:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 695D7800C2
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 02:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B849106F;
 Mon, 20 Jan 2025 17:08:44 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663DD3F740;
 Mon, 20 Jan 2025 17:08:14 -0800 (PST)
Date: Tue, 21 Jan 2025 01:06:43 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Samuel Holland
 <samuel@sholland.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon
 Glass <sjg@chromium.org>, u-boot@lists.denx.de, Chen-Yu Tsai
 <wens@csie.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>
Subject: Re: [PATCH] sunxi: pinephone: detect existed magnetometer and fixup
 dtb
Message-ID: <20250121010643.2bd916f4@minigeek.lan>
In-Reply-To: <20241113222848.103032-1-andrej.skvortzov@gmail.com>
References: <20241113222848.103032-1-andrej.skvortzov@gmail.com>
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

On Thu, 14 Nov 2024 01:28:48 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

thanks for sending the patch and addressing this issue!

I wish board vendors would include a simple detectable revision
encoding, like three GPIOs each pulled either to GND or VCC, to make
detecting a board revision easier, but here we go ...

> In newer 1.2 PinePhone board revisions LIS3MDL magnetometer was replaced by
> AF8133J. They use the same PB1 pin in different modes.
> 
> LIS3MDL uses it as an gpio input to handle interrupt.
> AF8133J uses it as an gpio output as a reset signal.
> 
> It wasn't possible at runtime to enable both device tree
> nodes and detect supported sensor at probe time.
> 
> AF8133J has reset pin (PB1) connected to the SoC. By default AF8133J
> is in a reset state and don't respond to probe request on I2C
> bus. Extra code would be needed to handle reset signal. Therefore this
> code uses LIS3MDL magnetometer instead of AF8133J.
> 
> Introducing new dts 1.2b with AF8133J sensor would require probing in
> SPL. That would lead to pulling in into SPL I2C controller driver,
> RSB controller driver, introducing new AXP803 driver to power-up
> sensors for probe. It's working, but SPL is pretty size-constrained on
> A64 and doesn't have much space. Therefore fdt fixup is done in U-Boot
> proper without introducing new board revision and new dts.

That's completely fine, I like this solution better. First: the less
code we have in the SPL the better. And secondly: Yes, there is some
natural DT selection in the SPL, courtesy of the FIT image, but it's
quite wasteful, since we carry multiple almost identical DT copies.

So doing this kind of patching in U-Boot proper is the better solution
- as long as U-Boot doesn't depend on the patch (as in eMMC vs. SPI).
 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

I took the freedom to improve the formatting/line breaks a bit.

Queued for the next PR.

Cheers,
Andre

> Link: https://lore.kernel.org/all/20240908214718.36316-1-andrej.skvortzov@gmail.com/
> Link: https://lists.denx.de/pipermail/u-boot/2024-February/545700.html
> ---
> 
> This patch was discussed previously as RFC. [1]
> All relevant kernel device-tree changes are merged. [2]
> 
> 1. https://lists.denx.de/pipermail/u-boot/2024-February/545700.html
> 2. https://lore.kernel.org/all/20240908214718.36316-1-andrej.skvortzov@gmail.com/
> 
> 
> board/sunxi/board.c         | 23 +++++++++++++++++++++++
>  configs/pinephone_defconfig |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 824c322a0dc..703081b403f 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -14,6 +14,7 @@
>  #include <dm.h>
>  #include <env.h>
>  #include <hang.h>
> +#include <i2c.h>
>  #include <image.h>
>  #include <init.h>
>  #include <log.h>
> @@ -876,6 +877,27 @@ static void bluetooth_dt_fixup(void *blob)
>  			   "local-bd-address", bdaddr, ETH_ALEN, 1);
>  }
>  
> +#define PINEPHONE_LIS3MDL_I2C_ADDR	0x1E
> +#define PINEPHONE_LIS3MDL_I2C_BUS	1 /* I2C1 */
> +
> +static	void board_dt_fixup(void *blob)
> +{
> +	struct udevice *bus, *dev;
> +
> +	if (IS_ENABLED(CONFIG_PINEPHONE_DT_SELECTION) &&
> +	    !fdt_node_check_compatible(blob, 0, "pine64,pinephone-1.2")) {
> +		if (!uclass_get_device_by_seq(UCLASS_I2C, PINEPHONE_LIS3MDL_I2C_BUS, &bus)) {
> +			dm_i2c_probe(bus, PINEPHONE_LIS3MDL_I2C_ADDR, 0, &dev);
> +			fdt_set_status_by_compatible(
> +				blob, "st,lis3mdl-magn",
> +				dev ? FDT_STATUS_OKAY  : FDT_STATUS_DISABLED);
> +			fdt_set_status_by_compatible(
> +				blob, "voltafield,af8133j",
> +				dev ? FDT_STATUS_DISABLED : FDT_STATUS_OKAY);
> +		}
> +	}
> +}
> +
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
>  	int __maybe_unused r;
> @@ -889,6 +911,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  	fdt_fixup_ethernet(blob);
>  
>  	bluetooth_dt_fixup(blob);
> +	board_dt_fixup(blob);
>  
>  #ifdef CONFIG_VIDEO_DT_SIMPLEFB
>  	r = sunxi_simplefb_setup(blob);
> diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> index 9d39204a439..0f9ab0c4662 100644
> --- a/configs/pinephone_defconfig
> +++ b/configs/pinephone_defconfig
> @@ -11,6 +11,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>  CONFIG_PINEPHONE_DT_SELECTION=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> +CONFIG_SYS_I2C_MVTWSI=y
>  CONFIG_LED_STATUS=y
>  CONFIG_LED_STATUS_GPIO=y
>  CONFIG_LED_STATUS0=y

