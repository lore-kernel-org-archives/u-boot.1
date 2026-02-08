Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42533EF06F8
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 23:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 709848341A;
	Mon,  9 Feb 2026 00:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Fy9Pzr6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA60C839FD; Mon,  9 Feb 2026 00:47:18 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4F6805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 00:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f4ed=AN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1770594434;
 bh=pypbuEbYuxFCkb3VXbuwMQ+TcH7hdIjoYQ6NVotPjkc=;
 b=Fy9Pzr6BmVrwtIG+S6K6mxfs7jysaTuYXsLmsRhGBzDpxYvsA57Wq4AxwMlm4c5FDEeAmRxa2
 QondD+njFhed7VUiNgPkNQETagE7z3MEcapycGSI3yYyzuVgBZnVPqOIN1H5U6Tw9V+cZYOgfG/
 1en1Q844XG8BL318I2sojs1gj4rIZhClrQ7lxbQzz+ImDi/oZ51+pVjJystgcZN3exVEIXlCX20
 kKrW+4CEp9CWmsOHTcqIeWR6ytPIVnqmrk3MxWQbyjE0GWIfMXVEO1U+YqEqtjxqFTo2cSMQfVV
 9RZgkrcc3sBcqVGLKuqwP+ruq4aBxgr+NwzZ3MjFG3ww==
X-Forward-Email-ID: 6989207fa6487c2810b21bd6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a174c0c4-2ebd-4d86-8d03-ee5b60aca216@kwiboo.se>
Date: Mon, 9 Feb 2026 00:47:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] spl: add SPI NAND support via MTD in SPL
To: Fabio Estevam <festevam@gmail.com>
Cc: kever.yang@rock-chips.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
 <20260208212624.3413494-7-festevam@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260208212624.3413494-7-festevam@gmail.com>
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
> Add support for booting U-Boot SPL from SPI NAND devices
> using the MTD subsystem.
> 
>  - Introduce CONFIG_SPL_SPI_NAND_LOAD to enable SPL loading
>   from SPI NAND flash.
>  - Implement spl_spi_nand.c as a dedicated SPL loader that
>   reads the FIT image from SPI NAND via MTD.
>  - Update common/spl/Kconfig and Makefiles to include the
>   new loader in SPL builds.
>  - Adjust drivers/mtd/Makefile and drivers/mtd/nand/Makefile
>   to build the necessary SPI NAND MTD objects only when
>   CONFIG_SPL_SPI_NAND_LOAD is enabled, avoiding size impact
>   on other boards.
> 
> This allows boards like the Omega4 RV1103 to boot SPL directly
> from SPI NAND, keeping the SPL small and avoiding unnecessary
> inclusion of SPI NOR code.

The content in this patch seem very generic and could possible be sent
as a separate series that adds a generic SPL MTD loader.

There also seem to be another SPL NAND loader part of the series at [1]
that may be related.

[1] https://lore.kernel.org/all/20260129050446.8858-1-dinesh.maniyam@altera.com/

> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - None.
> 
>  common/spl/Kconfig        | 10 ++++-
>  common/spl/Makefile       |  1 +
>  common/spl/spl_spi_nand.c | 82 +++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/Makefile      |  1 +
>  drivers/mtd/nand/Makefile | 13 ++++++-
>  5 files changed, 105 insertions(+), 2 deletions(-)
>  create mode 100644 common/spl/spl_spi_nand.c
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 2998b7acb75f..126855b804ce 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1576,13 +1576,21 @@ config SPL_SPI_LOAD
>  	  Enable support for loading next stage, U-Boot or otherwise, from
>  	  SPI NOR in U-Boot SPL.
>  
> +config SPL_SPI_NAND_LOAD
> +	bool "Support loading from SPI NAND flash"
> +	depends on SPL
> +	depends on MTD && DM_MTD
> +	help
> +	  Enable support for loading next stage, U-Boot or otherwise, from
> +	  SPI NAND in U-Boot SPL.
> +
>  endif # SPL_SPI_FLASH_SUPPORT
>  
>  config SYS_SPI_U_BOOT_OFFS
>  	hex "address of u-boot payload in SPI flash"
>  	default 0x8000 if ARCH_SUNXI
>  	default 0x0
> -	depends on SPL_SPI_LOAD || SPL_SPI_SUNXI
> +	depends on SPL_SPI_LOAD || SPL_SPI_NAND_LOAD || SPL_SPI_SUNXI
>  	help
>  	 Address within SPI-Flash from where the u-boot payload is fetched
>  	 from.
> diff --git a/common/spl/Makefile b/common/spl/Makefile
> index 4c9482bd3096..4628902e7e31 100644
> --- a/common/spl/Makefile
> +++ b/common/spl/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
>  obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
>  obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
>  obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
> +obj-$(CONFIG_$(PHASE_)SPI_NAND_LOAD) += spl_spi_nand.o
>  obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
>  obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
>  endif
> diff --git a/common/spl/spl_spi_nand.c b/common/spl/spl_spi_nand.c
> new file mode 100644
> index 000000000000..20b877f75a05
> --- /dev/null
> +++ b/common/spl/spl_spi_nand.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * SPL loader for SPI NAND devices using the MTD subsystem.
> + *
> + * Based on spl_spi.c, which is:
> + *
> + * Copyright (C) 2011 OMICRON electronics GmbH
> + *
> + * based on drivers/mtd/nand/raw/nand_spl_load.c
> + *
> + * Copyright (C) 2011
> + * Heiko Schocher, DENX Software Engineering, hs@denx.de.
> + */
> +
> +#include <config.h>
> +#include <image.h>
> +#include <log.h>
> +#include <errno.h>
> +#include <spl.h>
> +#include <spl_load.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <dm/ofnode.h>
> +#include <dm/uclass.h>
> +#include <mtd.h>
> +
> +static struct mtd_info *spl_spi_nand_get_mtd(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	for (ret = uclass_first_device_err(UCLASS_MTD, &dev);
> +	     dev;
> +	     ret = uclass_next_device_err(&dev)) {
> +		if (ret)
> +			continue;
> +		if (device_is_compatible(dev, "spi-nand"))
> +			return dev_get_uclass_priv(dev);

Is there a reason why you limit this to only spi-nand?

I think it would be better to pivot this into a more generic SPL MTD
loader.

> +	}
> +
> +	return NULL;
> +}
> +
> +static ulong spl_spinand_fit_read(struct spl_load_info *load, ulong offs,
> +				  ulong size, void *buf)

The _fit_ part can probably be dropped.

> +{
> +	struct mtd_info *mtd = load->priv;
> +	size_t retlen = 0;
> +	int ret;
> +
> +	ret = mtd_read(mtd, offs, size, &retlen, buf);
> +	if (ret && ret != -EUCLEAN) {

Maybe use mtd_is_bitflip(ret)

> +		printf("SPI NAND read failed offs=0x%lx size=0x%lx ret=%d\n",
> +		       offs, size, ret);
> +		return 0;
> +	}
> +	if (retlen != size)

Why do we need an error message above and not here?

> +		return 0;
> +
> +	return retlen;
> +}
> +
> +static int spl_spinand_load_image(struct spl_image_info *spl_image,
> +				  struct spl_boot_device *bootdev)
> +{
> +	struct spl_load_info load;
> +	struct mtd_info *mtd;
> +
> +	mtd = spl_spi_nand_get_mtd();
> +	if (!mtd) {
> +		puts("SPI NAND probe failed.\n");
> +		return -ENODEV;
> +	}
> +
> +	spl_load_init(&load, spl_spinand_fit_read, mtd, 1);

Should probably use mtd->writesize as bl_len.

	spl_load_init(&load, spl_mtd_read, mtd, mtd->writesize);

> +
> +	return spl_load(spl_image, bootdev, &load, 0, CONFIG_SYS_SPI_U_BOOT_OFFS);

Suggest you could use something like following to closer match SPL flash.

	offset = CONFIG_SYS_SPI_U_BOOT_OFFS;
	if (CONFIG_IS_ENABLED(OF_REAL))
		offset = ofnode_conf_read_int("u-boot,spl-payload-offset",
					      offset);

	return spl_load(spl_image, bootdev, &load, 0, offset);

> +}
> +
> +/* Use priority 1 so that boards can override this */
> +SPL_LOAD_IMAGE_METHOD("SPI NAND", 1, BOOT_DEVICE_SPI, spl_spinand_load_image);
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index ce05e206073d..a12d880a9e90 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -34,6 +34,7 @@ else
>  ifneq ($(mtd-y),)
>  obj-$(CONFIG_SPL_MTD) += mtd.o
>  endif
> +obj-$(CONFIG_SPL_SPI_NAND_LOAD) += nand/
>  obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
>  obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
>  obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index c8169cf73902..7cd2a5f1af9b 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -1,10 +1,21 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  
> -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
>  nandcore-objs := core.o bbt.o
> +
> +ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)

Having both XPL and TPL is redundant and could be cleaned up to just
have ($(CONFIG_XPL_BUILD),).

Regards,
Jonas

> +
> +# U-Boot proper
>  obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
>  obj-$(CONFIG_MTD_RAW_NAND) += raw/
>  obj-$(CONFIG_MTD_SPI_NAND) += spi/
> +
>  else
> +
> +# SPL / XPL / TPL
> +# SPL has no MTD_NAND_CORE symbol, so we must key off SPI NAND usage
> +obj-$(CONFIG_SPL_SPI_NAND_LOAD) += nandcore.o
> +obj-$(CONFIG_SPL_SPI_NAND_LOAD) += spi/
> +
> +# raw NAND still follows the normal SPL rule
>  obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += raw/
>  endif

