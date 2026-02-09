Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87C6E7E0BA
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 09:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8EA6839A5;
	Mon,  9 Feb 2026 10:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ljl5v778";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530AD83BC9; Mon,  9 Feb 2026 10:56:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CF38397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 10:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f4ed=AN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1770630993;
 bh=+AZ1AsvTi01maTQeZFRM11/JVKNVUCW2rARgrqxT/ak=;
 b=ljl5v7789YzcQWtFsg3JW+hiPjWNYk7KC/OfA0fgBNGf8vj+afx0hDGyJggy9bnK4DMsk19W8
 mJrVuAF6HArJvftalNJvjWhpvbVogv9MMMG7pBhrOt2ybytGYAhmlhzIzk8b/PXjrhryuv648XM
 b53STxzqs7IrODvK6dGGyIoR936etVRyd5miT4vTdw8V4xLEkVPmyz2FDr6KZL8xSvZzjiOeJA8
 WeRsUvhtDZnX9L/Lj1iqioSv/uNtMmW5pSCvO08ZVcUXlqocEmJ03xz8CTHfxc3SI2l0v6L8NPn
 NVRquay4DJK9WwGGzBUex0XXbEPdz7YMo1P7csbztqrw==
X-Forward-Email-ID: 6989af4ede8d5e1b8dcf0aa8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9c37580c-07f0-4f1c-8c96-064d509365bc@kwiboo.se>
Date: Mon, 9 Feb 2026 10:56:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] rockchip: spl-boot-order: Add SPI NAND support
To: Fabio Estevam <festevam@gmail.com>
Cc: "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@nabladev.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
 <20260208212624.3413494-6-festevam@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260208212624.3413494-6-festevam@gmail.com>
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

Hi Fabio,

On 2/8/2026 10:26 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Make spl-boot-order to accept boot from SPI NAND as well.
> 
> With this change, it is possible to specify spi_nand
> as the boot medium like this:
> 
> u-boot,spl-boot-order = &spi_nand;

You should probably include something like following (after DT has been
updated as per DT review) in rv1103b.c to also allow "same-as-spl" to
work.

const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@20d30000",
	[BROM_BOOTSOURCE_SPINOR] = "/soc/spi@20d40000/flash@0",
	[BROM_BOOTSOURCE_SD] = "/soc/mmc@20d20000",
};

> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - None.
> 
>  arch/arm/mach-rockchip/spl-boot-order.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 6572dde29f65..e5897536934a 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dm.h>
> +#include <dm/device_compat.h>
>  #include <fdt_support.h>
>  #include <log.h>
>  #include <mmc.h>
> @@ -75,6 +76,8 @@ static int spl_node_to_boot_device(int node)
>  	 */
>  	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
>  		return BOOT_DEVICE_SPI;
> +	if (fdt_node_check_compatible(gd->fdt_blob, node, "spi-nand") == 0)
> +		return BOOT_DEVICE_SPI;

I think something like following will be better:

	if (!uclass_find_device_by_of_offset(UCLASS_MTD, node, &parent))
		return BOOT_DEVICE_MTD;

And possible also with a protect check (should probably be fixed for
MMC/SPI_FLASH in a separate future patch/series).

	if (CONFIG_IS_ENABLED(MTD_LOAD_SUPPORT) &&
	    !uclass_find_device_by_of_offset(UCLASS_MTD, node, &parent))
		return BOOT_DEVICE_MTD;

Or whatever Kconfig option is used to ensure both UCLASS and SPL loader
is supported in the build. To avoid error messages about missing UCLASS
like following (from a different rk soc/board):

  board_spl_was_booted_from: brom_bootdevice_id 3 maps to '/soc/spi@ffac0000/flash@0'
  Cannot find uclass for id 119: please add the UCLASS_DRIVER() declaration for this UCLASS_... id
  board_boot_order: could not map node /soc/spi@ffac0000/flash@0 to a boot-device
  Cannot find uclass for id 119: please add the UCLASS_DRIVER() declaration for this UCLASS_... id

>  
>  	return -1;
>  }
> @@ -221,8 +224,12 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
>  
>  			ret = uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &dev);
>  			if (ret) {
> -				debug("%s: could not find udevice for %s\n", __func__, conf);
> -				continue;
> +				ret = uclass_find_device_by_of_offset(UCLASS_MTD, node, &dev);
> +				if (ret || !device_is_compatible(dev, "spi-nand")) {

I do not think we need to check for spi-nand compatible here, make it
generic and only check for UCLASS_MTD. If the node binds to a UCLASS_MTD
driver it is likely we could use a generic SPL MTD loader that used mtd
read ops to load next stage.

With that we could possible also support SPI_FLASH_MTD and consolidate
and/or simplify SPL code, something that can be looked at in future once
we have a more generic SPL MTD loader in place.

Regards,
Jonas

> +					debug("%s: could not find udevice for %s\n",
> +					      __func__, conf);
> +					continue;
> +				}
>  			}
>  
>  			return ofnode_get_path(dev_ofnode(dev), buf, buflen);

