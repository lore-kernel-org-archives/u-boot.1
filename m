Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDD6CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F76486AE9;
	Mon, 16 Oct 2023 11:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697446925;
	bh=3SKQgO62SxQ9MNrNJJQ6se33jo+2zRVNjduUgFTPdw8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kGrNfcDJJD8t37tVuXif68vjRdMz6VT/jBajdiUxIkQmlFyPHQ/yJ4gfbFi6h+95T
	 u02saQk8DSnVr1Y4VwUz5MAM3nKg6qg67YMDrn1p+7btbYt8wdOGHcnqxPquAnTkK8
	 K5CSU7aKuuX/6zhCu/x9qbiED03KqLqO5OKedMBaDgQVgUGgupHohggEXI9xU5pyrM
	 5lFEkW9R8zVyTFoFWYLqsCQA9VRTVS26K3K35TL9MKmrCWQD1AHPl+kjG/rAe5uHW2
	 1z+AgCwFjNcHgfLvtYQByjPPLHYdaRhxWdlIw+/QLZrGvb7oW8uekoePT8g7irkSvx
	 bdIcXywBXICtg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C24D86B71; Mon, 16 Oct 2023 11:02:02 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0398686784
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S8B1v3z7fz9sbp;
 Mon, 16 Oct 2023 11:01:55 +0200 (CEST)
Message-ID: <08d6a9b0-9b45-4d8c-8376-9e21bfd605a4@denx.de>
Date: Mon, 16 Oct 2023 11:01:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5] bootstd: sata: Add bootstd support for ahci sata
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231011202643.9194-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231011202643.9194-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S8B1v3z7fz9sbp
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

On 10/11/23 22:26, Tony Dinh wrote:
> Add ahci sata bootdev and corresponding hunting function.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
> Changes in v5:
> - In bootmeth_script script_boot(), it's unnecessary to check for ret so
> remove it. While we're here, also initialize ret in declaration.
> 
> Changes in v4:
> - Revise logic in bootmeth_script() to set devtype to sata for non-scsi
> SATA device
> - Rewrite sata_rescan() logic to properly remove all devices before probing
> - Add description to sata_rescan() header
> 
> Changes in v3:
> - Correct drivers/ata/Makefile to compile sata_bootdev only if
> ahci sata is enabled.
> 
> Changes in v2:
> - set devtype to sata in bootmeth_script for non-scsi SATA device.
> 
>   boot/bootmeth_script.c     | 16 +++++++---
>   drivers/ata/Makefile       |  2 +-
>   drivers/ata/sata.c         | 32 ++++++++++++++++++++
>   drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
>   include/sata.h             |  6 ++++
>   5 files changed, 113 insertions(+), 5 deletions(-)
>   create mode 100644 drivers/ata/sata_bootdev.c
> 
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index 345114dabf..06340e43d2 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -188,12 +188,20 @@ static int script_boot(struct udevice *dev, struct bootflow *bflow)
>   {
>   	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
>   	ulong addr;
> -	int ret;
> +	int ret = 0;
>   
> -	if (desc->uclass_id == UCLASS_USB)
> +	if (desc->uclass_id == UCLASS_USB) {
>   		ret = env_set("devtype", "usb");
> -	else
> -		ret = env_set("devtype", blk_get_devtype(bflow->blk));
> +	} else {
> +		/* If the uclass is AHCI, but the driver is ATA
> +		 * (not scsi), set devtype to sata
> +		 */
> +		if (IS_ENABLED(CONFIG_SATA) &&
> +		    desc->uclass_id == UCLASS_AHCI)
> +			ret = env_set("devtype", "sata");
> +		else
> +			ret = env_set("devtype", blk_get_devtype(bflow->blk));
> +	}
>   	if (!ret)
>   		ret = env_set_hex("devnum", desc->devnum);
>   	if (!ret)
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 6e30180b8b..0b6f91098a 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_SCSI_AHCI) += ahci.o
>   obj-$(CONFIG_DWC_AHSATA) += dwc_ahsata.o
>   obj-$(CONFIG_FSL_SATA) += fsl_sata.o
>   obj-$(CONFIG_LIBATA) += libata.o
> -obj-$(CONFIG_SATA) += sata.o
> +obj-$(CONFIG_SATA) += sata.o sata_bootdev.o
>   obj-$(CONFIG_SATA_CEVA) += sata_ceva.o
>   obj-$(CONFIG_SATA_MV) += sata_mv.o
>   obj-$(CONFIG_SATA_SIL) += sata_sil.o
> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> index ce3e9b5a40..f126b84e05 100644
> --- a/drivers/ata/sata.c
> +++ b/drivers/ata/sata.c
> @@ -15,6 +15,8 @@
>   #include <dm.h>
>   #include <part.h>
>   #include <sata.h>
> +#include <dm/device-internal.h>
> +#include <dm/uclass-internal.h>
>   
>   #ifndef CONFIG_AHCI
>   struct blk_desc sata_dev_desc[CONFIG_SYS_SATA_MAX_DEVICE];
> @@ -50,6 +52,36 @@ int sata_scan(struct udevice *dev)
>   	return ops->scan(dev);
>   }
>   
> +int sata_rescan(bool verbose)
> +{
> +	int ret;
> +	struct udevice *dev;
> +
> +	if (verbose)
> +		printf("Removing devices on SATA bus...\n");
> +
> +	blk_unbind_all(UCLASS_AHCI);
> +
> +	ret = uclass_find_first_device(UCLASS_AHCI, &dev);
> +	if (ret || !dev) {
> +		printf("Cannot find SATA device (err=%d)\n", ret);
> +		return -ENOSYS;
> +	}
> +
> +	ret = device_remove(dev, DM_REMOVE_NORMAL);
> +	if (ret) {
> +		printf("Cannot remove SATA device '%s' (err=%d)\n", dev->name, ret);
> +		return -ENOSYS;
> +	}
> +
> +	if (verbose)
> +		printf("Rescanning SATA bus for devices...\n");
> +
> +	ret = uclass_probe_all(UCLASS_AHCI);
> +
> +	return ret;
> +}
> +
>   #ifndef CONFIG_AHCI
>   #ifdef CONFIG_PARTITIONS
>   struct blk_desc *sata_get_dev(int dev)
> diff --git a/drivers/ata/sata_bootdev.c b/drivers/ata/sata_bootdev.c
> new file mode 100644
> index 0000000000..f638493ce0
> --- /dev/null
> +++ b/drivers/ata/sata_bootdev.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootdev for sata
> + *
> + * Copyright 2023 Tony Dinh <mibodhi@gmail.com>
> + */
> +
> +#include <common.h>
> +#include <ahci.h>
> +#include <bootdev.h>
> +#include <dm.h>
> +#include <init.h>
> +#include <sata.h>
> +
> +static int sata_bootdev_bind(struct udevice *dev)
> +{
> +	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
> +
> +	ucp->prio = BOOTDEVP_4_SCAN_FAST;
> +
> +	return 0;
> +}
> +
> +static int sata_bootdev_hunt(struct bootdev_hunter *info, bool show)
> +{
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI)) {
> +		ret = pci_init();
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = sata_rescan(true);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +struct bootdev_ops sata_bootdev_ops = {
> +};
> +
> +static const struct udevice_id sata_bootdev_ids[] = {
> +	{ .compatible = "u-boot,bootdev-sata" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(sata_bootdev) = {
> +	.name		= "sata_bootdev",
> +	.id		= UCLASS_BOOTDEV,
> +	.ops		= &sata_bootdev_ops,
> +	.bind		= sata_bootdev_bind,
> +	.of_match	= sata_bootdev_ids,
> +};
> +
> +BOOTDEV_HUNTER(sata_bootdev_hunter) = {
> +	.prio		= BOOTDEVP_4_SCAN_FAST,
> +	.uclass		= UCLASS_AHCI,
> +	.hunt		= sata_bootdev_hunt,
> +	.drv		= DM_DRIVER_REF(sata_bootdev),
> +};
> diff --git a/include/sata.h b/include/sata.h
> index d89f7a8a29..6111cf65d9 100644
> --- a/include/sata.h
> +++ b/include/sata.h
> @@ -21,4 +21,10 @@ extern struct blk_desc sata_dev_desc[];
>   int sata_probe(int devnum);
>   int sata_remove(int devnum);
>   
> +/*
> + * Remove existing AHCI SATA device uclass and all of its children,
> + * if any, and probe it again.
> + */
> +int sata_rescan(bool verbose);
> +
>   #endif

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
