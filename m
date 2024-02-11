Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAC4C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 13:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E52587C69;
	Sun, 11 Feb 2024 14:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEBFB87C6D; Sun, 11 Feb 2024 14:14:33 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 52FD487C68
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 14:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C19BDA7;
 Sun, 11 Feb 2024 05:15:12 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EE4D3F5A1;
 Sun, 11 Feb 2024 05:14:29 -0800 (PST)
Date: Sun, 11 Feb 2024 13:13:08 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Samuel Holland <samuel@sholland.org>,
 u-boot@lists.denx.de, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Ondrej Jirman <megi@xff.cz>, Arnav Singh <me@arnavion.dev>, Samuel
 Dionne-Riel <samuel@dionne-riel.com>
Subject: Re: [PATCH RFC] sunxi: pinephone: detect existed magnetometer and
 fixup dtb
Message-ID: <20240211131251.797abb61@minigeek.lan>
In-Reply-To: <20240211092824.395155-1-andrej.skvortzov@gmail.com>
References: <20240211092824.395155-1-andrej.skvortzov@gmail.com>
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

On Sun, 11 Feb 2024 12:28:24 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

Hi Andrey,

thanks for taking care of this upstream!

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

Thanks for the research and explanation, that makes it much easier to
reason about!

> Introducing new dts 1.2b with AF8133J sensor would require probing in
> SPL. That would lead to pulling in into SPL I2C controller driver,
> RSB controller driver, introducing new AXP803 driver to power-up
> sensors for probe. It's working, but SPL is pretty size-constrained on
> A64 and doesn't have much space. Therefore fdt fixup is done in U-Boot
> proper without introducing new board revision and new dts.

I agree on that, especially if it's indeed just a matter of flipping
two "status" properties.

> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
> 
> AF8133J's driver isn't upstreamed yet, but it will be soon. Therefore this
> is RFC patch. I'd like to know whether selected approach will be accepted
> in u-boot before submiting coresponding dts changes to the Linux kernel.
> Any feedback on this change would be very welcome.

So I think this is the right approach: Since the SPL has no use of this
device, and it's a rather small DT change, we definitely want to do this
in U-Boot proper. And I believe that U-Boot (proper) is indeed the best
place to do those adjustments, since it's built for one board anyway,
so anything board specific belongs into there (and not into TF-A or the
SPL, which are more tailored to one *SoC*). Also we are not so size
sensitive in proper.
And I also like the fact that it's protected by a board specific
definition, and even better that it's an already existing one.

Oh, and I am not really convinced this is the right approach here, but
maybe have a look at doc/usage/cmd/extension.rst, for another related
mechanism.

Some smaller comments below ...

> 
>  board/sunxi/board.c         | 26 ++++++++++++++++++++++++++
>  configs/pinephone_defconfig |  1 +
>  2 files changed, 27 insertions(+)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 1305302060..a4bfa24400 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -15,6 +15,7 @@
>  #include <dm.h>
>  #include <env.h>
>  #include <hang.h>
> +#include <i2c.h>
>  #include <image.h>
>  #include <init.h>
>  #include <log.h>
> @@ -920,6 +921,28 @@ static void bluetooth_dt_fixup(void *blob)
>  			   "local-bd-address", bdaddr, ETH_ALEN, 1);
>  }
>  
> +#ifdef CONFIG_PINEPHONE_DT_SELECTION

Can you move that line into the function? That would for one avoid the
protection in the caller below, and secondly make it easier to add
other boards, if a need arises for them. The two #defines don't hurt or
change the code, so just keep them outside.

> +
> +#define PINEPHONE_LIS3MDL_I2C_ADDR	0x1E
> +#define PINEPHONE_LIS3MDL_I2C_BUS	1 /* I2C1 */
> +
> +static	void board_dt_fixup(void *blob)
> +{
> +	struct udevice *bus, *dev;
> +

(have the #ifdef here)

> +	if (!fdt_node_check_compatible(blob, 0, "pine64,pinephone-1.2"))

Please have curly braces around that.

So I'd say please send the (disabled) DT node addition patch to the
kernel MLs, then send this patch to U-Boot.

Cheers,
Andre

> +		if (!uclass_get_device_by_seq(UCLASS_I2C, PINEPHONE_LIS3MDL_I2C_BUS, &bus)) {
> +			dm_i2c_probe(bus, PINEPHONE_LIS3MDL_I2C_ADDR, 0, &dev);
> +			fdt_set_status_by_compatible(
> +				blob, "st,lis3mdl-magn",
> +				dev ? FDT_STATUS_OKAY  : FDT_STATUS_DISABLED);
> +			fdt_set_status_by_compatible(
> +				blob, "voltafield,af8133j",
> +				dev ? FDT_STATUS_DISABLED : FDT_STATUS_OKAY);
> +		}
> +}
> +#endif
> +
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
>  	int __maybe_unused r;
> @@ -934,6 +957,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  
>  	bluetooth_dt_fixup(blob);
>  
> +#ifdef CONFIG_PINEPHONE_DT_SELECTION
> +	board_dt_fixup(blob);
> +#endif
>  #ifdef CONFIG_VIDEO_DT_SIMPLEFB
>  	r = sunxi_simplefb_setup(blob);
>  	if (r)
> diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> index eebc676901..457e7ee1e7 100644
> --- a/configs/pinephone_defconfig
> +++ b/configs/pinephone_defconfig
> @@ -12,6 +12,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>  CONFIG_PINEPHONE_DT_SELECTION=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> +CONFIG_SYS_I2C_MVTWSI=y
>  CONFIG_LED_STATUS=y
>  CONFIG_LED_STATUS_GPIO=y
>  CONFIG_LED_STATUS0=y

