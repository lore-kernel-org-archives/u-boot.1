Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A042C4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 07:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB39287527;
	Fri,  2 Feb 2024 08:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cH4XdNdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273418753E; Fri,  2 Feb 2024 08:51:25 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C4F9874B1
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 08:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4127pDms078436;
 Fri, 2 Feb 2024 01:51:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706860273;
 bh=FgAOXbwVlBagsoi4TDN3iJVEfd3em1vCsq8B9rTnE4Y=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cH4XdNdSAw8KCST+SnXp06PoqGWnLwXcu3TzMSujgY6uMX6ror/9TFxaavv1hw48+
 QRQHniVe4JKhLgJNChV8HGfmdPAq82Iw4g8x2UGHt+VDtQNi5NXD937WJVs84D2Pwj
 LnPtJQGk2lKE4SMcagB5tahOjHJaBmjmnERzXTB8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4127pD6s004892
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 2 Feb 2024 01:51:13 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 01:51:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 01:51:13 -0600
Received: from [10.249.129.226] ([10.249.129.226])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4127p8uV125070;
 Fri, 2 Feb 2024 01:51:09 -0600
Message-ID: <bad6fe3f-2318-4fd7-98e1-b6f5c30e9fe2@ti.com>
Date: Fri, 2 Feb 2024 13:21:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240130063322.2345057-1-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240130063322.2345057-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 1/30/2024 12:03 PM, MD Danish Anwar wrote:
> Add APIs to set a firmware_name to a rproc and boot the rproc with the
> same firmware.
>
> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
> load the firmware file to the remote processor and start the remote
> processor.
>
> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
> Kconfig so that we can call request_firmware_into_buf() from remoteproc
> driver.
>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Changes from v3 to v4:
> *) No functional change. Splitted the patch out of the series as suggested
>    by Nishant.
> *) Droppped the RFC tag.
>
> v3: https://lore.kernel.org/all/20240124064930.1787929-4-danishanwar@ti.com/
>
>  drivers/remoteproc/Kconfig        |  1 +
>  drivers/remoteproc/rproc-uclass.c | 85 +++++++++++++++++++++++++++++++
>  include/remoteproc.h              | 35 +++++++++++++
>  3 files changed, 121 insertions(+)
>
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 781de530af..0fdf1b38ea 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -10,6 +10,7 @@ menu "Remote Processor drivers"
>  # All users should depend on DM
>  config REMOTEPROC
>  	bool
> +	select FS_LOADER
>  	depends on DM
>  
>  # Please keep the configuration alphabetically sorted.
> diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
> index 28b362c887..76db4157f7 100644
> --- a/drivers/remoteproc/rproc-uclass.c
> +++ b/drivers/remoteproc/rproc-uclass.c
> @@ -13,6 +13,7 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <virtio_ring.h>
> +#include <fs_loader.h>
>  #include <remoteproc.h>
>  #include <asm/io.h>
>  #include <dm/device-internal.h>
> @@ -961,3 +962,87 @@ unsigned long rproc_parse_resource_table(struct udevice *dev, struct rproc *cfg)
>  
>  	return 1;
>  }
> +
> +int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
> +{
> +	struct dm_rproc_uclass_pdata *uc_pdata;
> +	int len;
> +	char *p;
> +
> +	if (!rproc_dev || !fw_name)
> +		return -EINVAL;
> +
> +	uc_pdata = dev_get_uclass_plat(rproc_dev);
> +
> +	len = strcspn(fw_name, "\n");
> +	if (!len) {
> +		debug("can't provide empty string for firmware name\n");
> +		return -EINVAL;
> +	}
> +
> +	p = strndup(fw_name, len);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	uc_pdata->fw_name = p;
> +
> +	return 0;
> +}
> +
> +int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
> +{
> +	struct dm_rproc_uclass_pdata *uc_pdata;
> +	struct udevice *fs_loader;
> +	void *addr = malloc(fw_size);
> +	int core_id, ret = 0;
> +	char *firmware;
> +	ulong rproc_addr;
> +
> +	if (!rproc_dev)
> +		return -EINVAL;
> +
> +	if (!addr)
> +		return -ENOMEM;
> +

    addr is not freed.

> +	uc_pdata = dev_get_uclass_plat(rproc_dev);
> +	core_id = dev_seq(rproc_dev);
> +	firmware = uc_pdata->fw_name;
> +
> +	if (!firmware) {
> +		debug("No firmware set for rproc core %d\n", core_id);
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize all rproc cores */
> +	rproc_init();
> +
> +	/* Loading firmware to a given address */
> +	ret = get_fs_loader(&fs_loader);
> +	if (ret) {
> +		debug("could not get fs loader: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = request_firmware_into_buf(fs_loader, firmware, addr, fw_size, 0);
> +	if (ret < 0) {
> +		debug("could not request %s: %d\n", firmware, ret);
> +		return ret;
> +	}
> +
> +	rproc_addr = (ulong)addr;
> +
> +	ret = rproc_load(core_id, rproc_addr, ret);
> +	if (ret) {
> +		debug("failed to load %s to rproc core %d from addr 0x%08lX err %d\n",
> +		      uc_pdata->fw_name, core_id, rproc_addr, ret);
> +		return ret;
> +	}
> +
> +	ret = rproc_start(core_id);
> +	if (ret) {
> +		debug("failed to start rproc core %d\n", core_id);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> diff --git a/include/remoteproc.h b/include/remoteproc.h
> index 91a88791a4..e53f85ba51 100644
> --- a/include/remoteproc.h
> +++ b/include/remoteproc.h
> @@ -403,6 +403,7 @@ enum rproc_mem_type {
>   * @name: Platform-specific way of naming the Remote proc
>   * @mem_type: one of 'enum rproc_mem_type'
>   * @driver_plat_data: driver specific platform data that may be needed.
> + * @fw_name: firmware name
>   *
>   * This can be accessed with dev_get_uclass_plat() for any UCLASS_REMOTEPROC
>   * device.
> @@ -412,6 +413,7 @@ struct dm_rproc_uclass_pdata {
>  	const char *name;
>  	enum rproc_mem_type mem_type;
>  	void *driver_plat_data;
> +	char *fw_name;
>  };
>  
>  /**
> @@ -705,6 +707,35 @@ unsigned long rproc_parse_resource_table(struct udevice *dev,
>  struct resource_table *rproc_find_resource_table(struct udevice *dev,
>  						 unsigned int addr,
>  						 int *tablesz);
> +/**
> + * rproc_set_firmware() - assign a new firmware
> + * @rproc_dev: device for wich new firmware is being assigned
> + * @fw_name: new firmware name to be assigned
> + *
> + * This function allows remoteproc drivers or clients to configure a custom
> + * firmware name. The function does not trigger a remote processor boot,
> + * only sets the firmware name used for a subsequent boot.
> + *
> + * This function sets the fw_name field in uclass pdata of the Remote proc
> + *
> + * Return: 0 on success or a negative value upon failure
> + */
> +int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name);
> +
> +/**
> + * rproc_boot() - boot a remote processor
> + * @rproc_dev: rproc device to boot
> + * @fw_size: Size of the memory to allocate for firmeware
> + *
> + * Boot a remote processor (i.e. load its firmware, power it on, ...).
> + *
> + * This function first loads the firmware set in the uclass pdata of Remote
> + * processor to a buffer and then loads firmware to the remote processor
> + * using rproc_load().
> + *
> + * Return: 0 on success, and an appropriate error value otherwise
> + */
> +int rproc_boot(struct udevice *rproc_dev, size_t fw_size);
>  #else
>  static inline int rproc_init(void) { return -ENOSYS; }
>  static inline int rproc_dev_init(int id) { return -ENOSYS; }
> @@ -744,6 +775,10 @@ static inline int rproc_elf_load_rsc_table(struct udevice *dev, ulong fw_addr,
>  					   ulong fw_size, ulong *rsc_addr,
>  					   ulong *rsc_size)
>  { return -ENOSYS; }
> +static inline int rproc_set_firmware(struct udevice *rproc_dev, const char *fw_name)
> +{ return -ENOSYS; }
> +static inline int rproc_boot(struct udevice *rproc_dev, size_t fw_size)
> +{ return -ENOSYS; }
>  #endif
>  
>  #endif	/* _RPROC_H_ */

