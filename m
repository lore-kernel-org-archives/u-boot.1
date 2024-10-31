Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC07D767E2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 16:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F9488E43;
	Thu, 31 Oct 2024 17:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wVKdGjqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAED488E6B; Thu, 31 Oct 2024 17:35:48 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0C4881A5
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 17:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49VGZg9g093302;
 Thu, 31 Oct 2024 11:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730392542;
 bh=7CjpqSzPeTrfftuFx03QWv9gDWwRGafQ49ns18odk0M=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wVKdGjqztzrG4rGNCqVTJ/Y5VJ8SIdlRfm/JUgpTF36cDvmbtpuqgjJI9jBKMrUAX
 Xe6uAGwK8U5JnrKjdQJBzU95Iwk+Uf4OdWBtLXz8L9IEwnwaOMfYpiAfpZ20LCtLHv
 c2+b2vdOhfWhLYRwbc3J0OQs+UvasWhTS5lDyycc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49VGZgGM052992
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Oct 2024 11:35:42 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Oct 2024 11:35:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Oct 2024 11:35:42 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49VGZfEX032740;
 Thu, 31 Oct 2024 11:35:41 -0500
Message-ID: <72769d4e-9f13-499f-b20c-b1c454a60066@ti.com>
Date: Thu, 31 Oct 2024 11:35:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: mach-k3: am62a7: Provide a way to obtain boot
 device for non SPLs
To: Garrett Giordano <ggiordano@phytec.com>, <trini@konsulko.com>, <bb@ti.com>,
 <w.egorov@phytec.de>, <vaishnav.a@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <a-nandan@ti.com>, <nm@ti.com>,
 <sjg@chromium.org>, <a-bhatia1@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
References: <20241031162103.2835289-1-ggiordano@phytec.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241031162103.2835289-1-ggiordano@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 10/31/24 11:21 AM, Garrett Giordano wrote:
> Introduce get_boot_device() to obtain the booting device. Make it also
> available for non SPL builds so u-boot can also know the device it
> is booting from.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> ---

Seems similar enough to what has been done already for AM64x, might
be good at some point to just do this for all the K3 SoCs. I wonder how
much of the contents of these functions are common across them all..

For now, LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

>   v2:
>     - Drop duplicate CONFIG_SOC_K3_AM62A7 entry from arch/arm/mach-k3/Makefile
> 
>   arch/arm/mach-k3/am62ax/Makefile      |   1 +
>   arch/arm/mach-k3/am62ax/am62a7_init.c |  97 +----------------------
>   arch/arm/mach-k3/am62ax/boot.c        | 106 ++++++++++++++++++++++++++
>   3 files changed, 108 insertions(+), 96 deletions(-)
>   create mode 100644 arch/arm/mach-k3/am62ax/boot.c
> 
> diff --git a/arch/arm/mach-k3/am62ax/Makefile b/arch/arm/mach-k3/am62ax/Makefile
> index e2ef88196f8..4e35e0c844d 100644
> --- a/arch/arm/mach-k3/am62ax/Makefile
> +++ b/arch/arm/mach-k3/am62ax/Makefile
> @@ -5,3 +5,4 @@
> 
>   obj-$(CONFIG_OF_SYSTEM_SETUP) += am62a7_fdt.o
>   obj-$(CONFIG_XPL_BUILD) += am62a7_init.o
> +obj-y += boot.o
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 0f62f39075b..5c0d3ee6869 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -171,102 +171,7 @@ void board_init_f(ulong dummy)
>   	debug("am62a_init: %s done\n", __func__);
>   }
> 
> -static u32 __get_backup_bootmedia(u32 devstat)
> -{
> -	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
> -				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
> -	u32 bkup_bootmode_cfg =
> -			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
> -				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
> -
> -	switch (bkup_bootmode) {
> -	case BACKUP_BOOT_DEVICE_UART:
> -		return BOOT_DEVICE_UART;
> -
> -	case BACKUP_BOOT_DEVICE_USB:
> -		return BOOT_DEVICE_USB;
> -
> -	case BACKUP_BOOT_DEVICE_ETHERNET:
> -		return BOOT_DEVICE_ETHERNET;
> -
> -	case BACKUP_BOOT_DEVICE_MMC:
> -		if (bkup_bootmode_cfg)
> -			return BOOT_DEVICE_MMC2;
> -		return BOOT_DEVICE_MMC1;
> -
> -	case BACKUP_BOOT_DEVICE_SPI:
> -		return BOOT_DEVICE_SPI;
> -
> -	case BACKUP_BOOT_DEVICE_I2C:
> -		return BOOT_DEVICE_I2C;
> -
> -	case BACKUP_BOOT_DEVICE_DFU:
> -		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
> -			return BOOT_DEVICE_USB;
> -		return BOOT_DEVICE_DFU;
> -	};
> -
> -	return BOOT_DEVICE_RAM;
> -}
> -
> -static u32 __get_primary_bootmedia(u32 devstat)
> -{
> -	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
> -	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
> -
> -	switch (bootmode) {
> -	case BOOT_DEVICE_OSPI:
> -		fallthrough;
> -	case BOOT_DEVICE_QSPI:
> -		fallthrough;
> -	case BOOT_DEVICE_XSPI:
> -		fallthrough;
> -	case BOOT_DEVICE_SPI:
> -		return BOOT_DEVICE_SPI;
> -
> -	case BOOT_DEVICE_ETHERNET_RGMII:
> -		fallthrough;
> -	case BOOT_DEVICE_ETHERNET_RMII:
> -		return BOOT_DEVICE_ETHERNET;
> -
> -	case BOOT_DEVICE_EMMC:
> -		return BOOT_DEVICE_MMC1;
> -
> -	case BOOT_DEVICE_SPI_NAND:
> -		return BOOT_DEVICE_SPINAND;
> -
> -	case BOOT_DEVICE_MMC:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
> -			return BOOT_DEVICE_MMC2;
> -		return BOOT_DEVICE_MMC1;
> -
> -	case BOOT_DEVICE_DFU:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
> -		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
> -			return BOOT_DEVICE_USB;
> -		return BOOT_DEVICE_DFU;
> -
> -	case BOOT_DEVICE_NOBOOT:
> -		return BOOT_DEVICE_RAM;
> -	}
> -
> -	return bootmode;
> -}
> -
>   u32 spl_boot_device(void)
>   {
> -	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
> -	u32 bootmedia;
> -
> -	if (bootindex == K3_PRIMARY_BOOTMODE)
> -		bootmedia = __get_primary_bootmedia(devstat);
> -	else
> -		bootmedia = __get_backup_bootmedia(devstat);
> -
> -	debug("am62a_init: %s: devstat = 0x%x bootmedia = 0x%x bootindex = %d\n",
> -	       __func__, devstat, bootmedia, bootindex);
> -	return bootmedia;
> +	return get_boot_device();
>   }
> diff --git a/arch/arm/mach-k3/am62ax/boot.c b/arch/arm/mach-k3/am62ax/boot.c
> new file mode 100644
> index 00000000000..af7fce1e5e9
> --- /dev/null
> +++ b/arch/arm/mach-k3/am62ax/boot.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <asm/io.h>
> +#include <asm/arch/hardware.h>
> +#include <asm/arch/am62a_spl.h>
> +
> +static u32 __get_backup_bootmedia(u32 devstat)
> +{
> +	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
> +				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
> +	u32 bkup_bootmode_cfg =
> +			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
> +				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
> +
> +	switch (bkup_bootmode) {
> +	case BACKUP_BOOT_DEVICE_UART:
> +		return BOOT_DEVICE_UART;
> +
> +	case BACKUP_BOOT_DEVICE_USB:
> +		return BOOT_DEVICE_USB;
> +
> +	case BACKUP_BOOT_DEVICE_ETHERNET:
> +		return BOOT_DEVICE_ETHERNET;
> +
> +	case BACKUP_BOOT_DEVICE_MMC:
> +		if (bkup_bootmode_cfg)
> +			return BOOT_DEVICE_MMC2;
> +		return BOOT_DEVICE_MMC1;
> +
> +	case BACKUP_BOOT_DEVICE_SPI:
> +		return BOOT_DEVICE_SPI;
> +
> +	case BACKUP_BOOT_DEVICE_I2C:
> +		return BOOT_DEVICE_I2C;
> +
> +	case BACKUP_BOOT_DEVICE_DFU:
> +		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
> +			return BOOT_DEVICE_USB;
> +		return BOOT_DEVICE_DFU;
> +	};
> +
> +	return BOOT_DEVICE_RAM;
> +}
> +
> +static u32 __get_primary_bootmedia(u32 devstat)
> +{
> +	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> +				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
> +	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
> +				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
> +
> +	switch (bootmode) {
> +	case BOOT_DEVICE_OSPI:
> +		fallthrough;
> +	case BOOT_DEVICE_QSPI:
> +		fallthrough;
> +	case BOOT_DEVICE_XSPI:
> +		fallthrough;
> +	case BOOT_DEVICE_SPI:
> +		return BOOT_DEVICE_SPI;
> +
> +	case BOOT_DEVICE_ETHERNET_RGMII:
> +		fallthrough;
> +	case BOOT_DEVICE_ETHERNET_RMII:
> +		return BOOT_DEVICE_ETHERNET;
> +
> +	case BOOT_DEVICE_EMMC:
> +		return BOOT_DEVICE_MMC1;
> +
> +	case BOOT_DEVICE_SPI_NAND:
> +		return BOOT_DEVICE_SPINAND;
> +
> +	case BOOT_DEVICE_MMC:
> +		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
> +				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
> +			return BOOT_DEVICE_MMC2;
> +		return BOOT_DEVICE_MMC1;
> +
> +	case BOOT_DEVICE_DFU:
> +		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
> +		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
> +			return BOOT_DEVICE_USB;
> +		return BOOT_DEVICE_DFU;
> +
> +	case BOOT_DEVICE_NOBOOT:
> +		return BOOT_DEVICE_RAM;
> +	}
> +
> +	return bootmode;
> +}
> +
> +u32 get_boot_device(void)
> +{
> +	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
> +	u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
> +	u32 bootmedia;
> +
> +	if (bootmode == K3_PRIMARY_BOOTMODE)
> +		bootmedia = __get_primary_bootmedia(devstat);
> +	else
> +		bootmedia = __get_backup_bootmedia(devstat);
> +
> +	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
> +	      __func__, devstat, bootmedia, bootmode);
> +
> +	return bootmedia;
> +}
> --
> 2.25.1
> 
