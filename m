Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AECCCE8D47
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 10:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD1A8937E;
	Fri, 20 Sep 2024 12:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726826409;
	bh=KJ03x+3W7Z5dnPwMULj6Zb1TvKEPVnDwo7FH+iV5SqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wCN1Smpf32k4IPgLSrzVNN03nP8ElZqG4oxy3azllZLPQV3eFujNw0nQPPrsApRks
	 Q3sVOY7lylPTbm1F6SE2QkpwoZtzktV4AHIOi/HPdOWD191iZTGRWc3ppEziCTCh4m
	 xx71ROV1u90uBkpstfahdNvbXLa8mqgD8d49E1zTZfKV0AXWPqQV9NWRA9i7TV/ZlN
	 qBl9/iM3WU3G8MOELGvuzxK9ElBQBzFNDT4M6LW7BkTQiC3a6iNb6h3uG4cr0qqT+y
	 B4NaIoZx9n1G50kWLlVH7h7Byth978NbML268jOeUyzuuB6p6s0uQLF9evBCCOY7YQ
	 gRuJbpzayztuQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D7489308; Fri, 20 Sep 2024 12:00:08 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7164B89398
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 12:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4X97D41y2zz9t2Q;
 Fri, 20 Sep 2024 12:00:04 +0200 (CEST)
Message-ID: <3ec25b5a-2c9b-46fe-a9b9-0b99f72d83a9@denx.de>
Date: Fri, 20 Sep 2024 12:00:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] da9063: Add watchdog support
To: Fabio Estevam <festevam@gmail.com>
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20240917135550.3164425-1-festevam@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240917135550.3164425-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4X97D41y2zz9t2Q
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

On 9/17/24 15:55, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The DA9063 PMIC is a multi-function device that provides
> regulator, watchdog, RTC, and ON key functionalities.
> 
> Add support for the DA9063 PMIC watchdog functionality.
> 
> Based on the 6.11 kernel drivers/watchdog/da9063_wdt.c driver.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v2:
> - Use u8 instead of char. (Stefan)
> - Keep the Copyright header from Linux. (Stfan)

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

>   drivers/power/pmic/da9063.c   |  12 ++-
>   drivers/watchdog/Kconfig      |   6 ++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/da9063-wdt.c | 149 ++++++++++++++++++++++++++++++++++
>   4 files changed, 166 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/watchdog/da9063-wdt.c
> 
> diff --git a/drivers/power/pmic/da9063.c b/drivers/power/pmic/da9063.c
> index 7bd3df391421..59c65702863c 100644
> --- a/drivers/power/pmic/da9063.c
> +++ b/drivers/power/pmic/da9063.c
> @@ -7,6 +7,9 @@
>   #include <fdtdec.h>
>   #include <errno.h>
>   #include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/device_compat.h>
> +#include <dm/lists.h>
>   #include <i2c.h>
>   #include <log.h>
>   #include <linux/printk.h>
> @@ -86,6 +89,7 @@ static int da9063_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
>   static int da9063_bind(struct udevice *dev)
>   {
>   	ofnode regulators_node;
> +	struct driver *drv;
>   	int children;
>   
>   	regulators_node = dev_read_subnode(dev, "regulators");
> @@ -101,8 +105,12 @@ static int da9063_bind(struct udevice *dev)
>   	if (!children)
>   		debug("%s: %s - no child found\n", __func__, dev->name);
>   
> -	/* Always return success for this device */
> -	return 0;
> +	drv = lists_driver_lookup_name("da9063-wdt");
> +	if (!drv)
> +		return 0;
> +
> +	return device_bind_with_driver_data(dev, drv, "da9063-wdt", dev->driver_data,
> +					    dev_ofnode(dev), &dev);
>   }
>   
>   static int da9063_probe(struct udevice *dev)
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0c3e99133186..90bc5653ee33 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -169,6 +169,12 @@ config WDT_CORTINA
>   	  This driver support all CPU ISAs supported by Cortina
>   	  Access CAxxxx SoCs.
>   
> +config WDT_DA9063
> +	bool "DA9063 watchdog timer support"
> +	depends on WDT && DM_PMIC_DA9063
> +	help
> +	  Enable support for the watchdog timer in Dialog DA9063.
> +
>   config WDT_GPIO
>   	bool "External gpio watchdog support"
>   	depends on WDT
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 7b39adcf0ff4..6b564b7f96d2 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_WDT_BOOKE) += booke_wdt.o
>   obj-$(CONFIG_WDT_CORTINA) += cortina_wdt.o
>   obj-$(CONFIG_WDT_ORION) += orion_wdt.o
>   obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
> +obj-$(CONFIG_WDT_DA9063) += da9063-wdt.o
>   obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
>   obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
>   obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
> diff --git a/drivers/watchdog/da9063-wdt.c b/drivers/watchdog/da9063-wdt.c
> new file mode 100644
> index 000000000000..b7216b578630
> --- /dev/null
> +++ b/drivers/watchdog/da9063-wdt.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Based on the Linux drivers/watchdog/da9063_wdt.c file.
> + *
> + * Watchdog driver for DA9063 PMICs.
> + *
> + * Copyright(c) 2012 Dialog Semiconductor Ltd.
> + *
> + * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
> + *
> + * Ported to U-Boot by Fabio Estevam <festevam@denx.de>
> + *
> + */
> +
> +#include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/device_compat.h>
> +#include <dm/lists.h>
> +#include <i2c.h>
> +#include <linux/delay.h>
> +#include <wdt.h>
> +
> +#define	DA9063_REG_CONTROL_D		0x11
> +/* DA9063_REG_CONTROL_D (addr=0x11) */
> +#define	DA9063_TWDSCALE_MASK		0x0
> +#define DA9063_TWDSCALE_DISABLE		0
> +#define	DA9063_REG_CONTROL_F		0x13
> +/* DA9063_REG_CONTROL_F (addr=0x13) */
> +#define	DA9063_WATCHDOG			0x01
> +#define	DA9063_SHUTDOWN			0x02
> +
> +/*
> + * Watchdog selector to timeout in seconds.
> + *   0: WDT disabled;
> + *   others: timeout = 2048 ms * 2^(TWDSCALE-1).
> + */
> +static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
> +
> +#define DA9063_TWDSCALE_DISABLE		0
> +#define DA9063_TWDSCALE_MIN		1
> +#define DA9063_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
> +
> +static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
> +{
> +	unsigned int i;
> +
> +	for (i = DA9063_TWDSCALE_MIN; i <= DA9063_TWDSCALE_MAX; i++) {
> +		if (wdt_timeout[i] >= secs)
> +			return i;
> +	}
> +
> +	return DA9063_TWDSCALE_MAX;
> +}
> +
> +static int da9063_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
> +{
> +	return dm_i2c_read(dev->parent, reg, buff, len);
> +}
> +
> +static int da9063_write(struct udevice *dev, uint reg, const u8 *buff, int len)
> +{
> +	return dm_i2c_write(dev->parent, reg, buff, len);
> +}
> +
> +static int da9063_wdt_disable_timer(struct udevice *dev)
> +{
> +	u8 val;
> +
> +	da9063_read(dev, DA9063_REG_CONTROL_D, &val, 1);
> +	val &= ~DA9063_TWDSCALE_MASK;
> +	val |= DA9063_TWDSCALE_DISABLE;
> +	da9063_write(dev, DA9063_REG_CONTROL_D, &val, 1);
> +
> +	return 0;
> +}
> +
> +static int da9063_wdt_update_timeout(struct udevice *dev, unsigned int timeout)
> +{
> +	unsigned int regval;
> +	int ret;
> +	u8 val;
> +
> +	/*
> +	 * The watchdog triggers a reboot if a timeout value is already
> +	 * programmed because the timeout value combines two functions
> +	 * in one: indicating the counter limit and starting the watchdog.
> +	 * The watchdog must be disabled to be able to change the timeout
> +	 * value if the watchdog is already running. Then we can set the
> +	 * new timeout value which enables the watchdog again.
> +	 */
> +	ret = da9063_wdt_disable_timer(dev);
> +	if (ret)
> +		return ret;
> +
> +	udelay(300);
> +
> +	regval = da9063_wdt_timeout_to_sel(timeout);
> +
> +	da9063_read(dev, DA9063_REG_CONTROL_D, &val, 1);
> +	val &= ~DA9063_TWDSCALE_MASK;
> +	val |= regval;
> +	da9063_write(dev, DA9063_REG_CONTROL_D, &val, 1);
> +
> +	return 0;
> +}
> +
> +static int da9063_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
> +{
> +	return da9063_wdt_update_timeout(dev, timeout);
> +}
> +
> +static int da9063_wdt_stop(struct udevice *dev)
> +{
> +	return da9063_wdt_disable_timer(dev);
> +}
> +
> +static int da9063_wdt_reset(struct udevice *dev)
> +{
> +	u8 val = DA9063_WATCHDOG;
> +
> +	return da9063_write(dev, DA9063_REG_CONTROL_F, &val, 1);
> +}
> +
> +static int da9063_wdt_expire_now(struct udevice *dev, ulong flags)
> +{
> +	u8 val = DA9063_SHUTDOWN;
> +
> +	return da9063_write(dev, DA9063_REG_CONTROL_F, &val, 1);
> +}
> +
> +static const struct wdt_ops da9063_wdt_ops = {
> +	.start = da9063_wdt_start,
> +	.stop = da9063_wdt_stop,
> +	.reset = da9063_wdt_reset,
> +	.expire_now = da9063_wdt_expire_now,
> +};
> +
> +static const struct udevice_id da9063_wdt_ids[] = {
> +	{ .compatible = "dlg,da9063-watchdog", },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(da9063_wdt) = {
> +	.name = "da9063-wdt",
> +	.id = UCLASS_WDT,
> +	.of_match = da9063_wdt_ids,
> +	.ops = &da9063_wdt_ops,
> +	.flags = DM_FLAG_PROBE_AFTER_BIND,
> +};

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
