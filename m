Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3E5D1CDD9
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 10:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B368888F50;
	Tue, 22 Oct 2024 12:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729593973;
	bh=rc6i4wCqQ3UpSL5O82X3IzQj1LHV9XL5VDb+RD2NYa8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VpWhBj0C39HzlUp9X5PF9kK9fN9PZKebOcCWEB6GjQfwwemwoEJid46YWw8QjdUKq
	 8IF/sk6jyQNyUB8M1mTDSik6e1UvARf/Nr4DWNm0kiDVlqq10KYBSj19u1962Bx0RW
	 Eprrbiqz7NpdxHcpfDtcRy2lvnTddTaX+U22HkXUcLuaouIRn3HoSNxHDz8XokD4qB
	 ocdarmMM0tuE4ENHXRo1uS9s37G27tO5RhYnh/4FoAW7Z585Dpdl59TDWAZiRyKOPd
	 RED797KPgDHu3WT7i2UeFdV0flwjB5gUsh36TrtQbGbNW9gdOb1Cy/hG3JeaaWuS+q
	 xy7uEQ0Fma/qg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B511088F99; Tue, 22 Oct 2024 12:46:12 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9605288C4D
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 12:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXpkS2TlMz9smy;
 Tue, 22 Oct 2024 12:46:08 +0200 (CEST)
Message-ID: <a1229732-a42d-471d-9914-07e459d51d25@denx.de>
Date: Tue, 22 Oct 2024 12:46:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] watchdog: Add a driver for the photonicat watchdog
To: Coia Prant <coiaprant@gmail.com>, u-boot@lists.denx.de
References: <20240829083035.227423-1-coiaprant@gmail.com>
 <20240829083035.227423-2-coiaprant@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240829083035.227423-2-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/29/24 10:30, Coia Prant wrote:
> This driver supports the photonicat watchdog timers.
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

Why did you send this driver twice? Please send only 1/1 patch next
time.

> ---
>   drivers/watchdog/Kconfig    |   6 +
>   drivers/watchdog/Makefile   |   1 +
>   drivers/watchdog/pcat_wdt.c | 218 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 225 insertions(+)
>   create mode 100644 drivers/watchdog/pcat_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0c3e9913..f0a52ecf 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -421,4 +421,10 @@ config WDT_FTWDT010
>   	help
>   	  Faraday Technology ftwdt010 watchdog is an architecture independent
>   	  watchdog. It is usually used in SoC chip design.
> +
> +config WDT_PCAT
> +	bool "photonicat board watchdog support"
> +	depends on WDT && SERIAL && DM
> +	help
> +	  Select this to enable watchdog timer on photonicat board.

What is a "photonicat board"? Which SoC is used? Manufacturer?

And empty line missing here?

>   endmenu
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 7b39adcf..829b5ed1 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -50,3 +50,4 @@ obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
>   obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
>   obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
>   obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
> +obj-$(CONFIG_WDT_PCAT) += pcat_wdt.o

Please sort alphabetically.

> \ No newline at end of file
> diff --git a/drivers/watchdog/pcat_wdt.c b/drivers/watchdog/pcat_wdt.c
> new file mode 100644
> index 00000000..cac07fb6
> --- /dev/null
> +++ b/drivers/watchdog/pcat_wdt.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <wdt.h>
> +#include <asm/gpio.h>
> +#include <linux/delay.h>
> +#include <serial.h>
> +#include <dm/device-internal.h>

Sorting of header includes looks not correct.

> +
> +struct pcat_wdt_priv
> +{
> +	struct udevice *serial_dev;
> +	struct dm_serial_ops *serial_ops;
> +	uint16_t packet_count;
> +};
> +
> +static uint16_t pcat_pmu_serial_compute_crc16(const uint8_t *data,
> +											  size_t len)

alignment?

> +{
> +	uint16_t crc = 0xFFFF;
> +	size_t i;
> +	unsigned int j;
> +
> +	for (i = 0; i < len; i++)
> +	{

Coding style is wrong. Please use Linux coding style with U-Boot code as
well. scripts/checkpatch.pl will help you finding issues.

I'll stop the review here and will continue, once you've sent v2.

Thanks,
Stefan

> +		crc ^= data[i];
> +		for (j = 0; j < 8; j++)
> +		{
> +			if (crc & 1)
> +			{
> +				crc = (crc >> 1) ^ 0xA001;
> +			}
> +			else
> +			{
> +				crc >>= 1;
> +			}
> +		}
> +	}
> +
> +	return crc;
> +}
> +
> +static int pcat_wdt_reset(struct udevice *dev)
> +{
> +	struct pcat_wdt_priv *priv = dev_get_priv(dev);
> +	uint8_t packet[13] = "\xA5\x01\x81\x00\x00\x03\x00\x01\x00"
> +						 "\x00\x00\x00\x5A";
> +	uint16_t crc;
> +	int err = 0;
> +	unsigned int i;
> +
> +	packet[3] = priv->packet_count & 0xFF;
> +	packet[4] = (priv->packet_count >> 8) & 0xFF;
> +	priv->packet_count++;
> +
> +	crc = pcat_pmu_serial_compute_crc16(packet + 1, 9);
> +	packet[10] = crc & 0xFF;
> +	packet[11] = (crc >> 8) & 0xFF;
> +
> +	i = 0;
> +	while (i < 13)
> +	{
> +		err = priv->serial_ops->putc(
> +			priv->serial_dev, ((const char *)packet)[i]);
> +		if (!err)
> +		{
> +			i++;
> +		}
> +		else if (err == -EAGAIN)
> +		{
> +			;
> +		}
> +		else
> +		{
> +			pr_err("%s: unable to send watchdog setup "
> +				   "request: %d\n",
> +				   __func__, err);
> +			break;
> +		}
> +	}
> +	return err;
> +}
> +
> +static int pcat_wdt_setup(struct pcat_wdt_priv *priv, u64 timeout)
> +{
> +	uint8_t packet[16] = "\xA5\x01\x81\x00\x00\x06\x00\x13\x00"
> +						 "\x3C\x3C\x00\x00\x00\x00\x5A";
> +	uint16_t crc;
> +	int err = 0;
> +	unsigned int i;
> +
> +	if (timeout > 255)
> +	{
> +		pr_warn("%s: timeout cannot be more than 255s\n",
> +				__func__);
> +		timeout = 255;
> +	}
> +
> +	packet[3] = priv->packet_count & 0xFF;
> +	packet[4] = (priv->packet_count >> 8) & 0xFF;
> +	priv->packet_count++;
> +	packet[11] = timeout & 0xFF;
> +
> +	crc = pcat_pmu_serial_compute_crc16(packet + 1, 12);
> +	packet[13] = crc & 0xFF;
> +	packet[14] = (crc >> 8) & 0xFF;
> +
> +	i = 0;
> +	while (i < 16)
> +	{
> +		err = priv->serial_ops->putc(
> +			priv->serial_dev, ((const char *)packet)[i]);
> +		if (!err)
> +		{
> +			i++;
> +		}
> +		else if (err == -EAGAIN)
> +		{
> +			;
> +		}
> +		else
> +		{
> +			pr_err("%s: unable to send watchdog setup "
> +				   "request: %d\n",
> +				   __func__, err);
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static int pcat_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
> +{
> +	struct pcat_wdt_priv *priv = dev_get_priv(dev);
> +
> +	pcat_wdt_setup(priv, timeout);
> +
> +	return 0;
> +}
> +
> +static int pcat_wdt_stop(struct udevice *dev)
> +{
> +	struct pcat_wdt_priv *priv = dev_get_priv(dev);
> +
> +	pcat_wdt_setup(priv, 0);
> +
> +	return 0;
> +}
> +
> +static int dm_probe(struct udevice *dev)
> +{
> +	struct pcat_wdt_priv *priv = dev_get_priv(dev);
> +	struct udevice *serial_dev = NULL;
> +	struct dm_serial_ops *ops;
> +	int ret;
> +
> +	ret = uclass_get_device_by_phandle(UCLASS_SERIAL, dev, "port",
> +									   &serial_dev);
> +	if (ret)
> +	{
> +		pr_err("%s: unable to find serial port device: %d\n",
> +			   __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = device_probe(serial_dev);
> +	if (ret)
> +	{
> +		pr_err("%s: unable to probe serial port device: %d\n",
> +			   __func__, ret);
> +		return ret;
> +	}
> +
> +	ops = serial_get_ops(serial_dev);
> +	if (!ops)
> +	{
> +		printf("Cannot get ops for PMU serial port!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ops->setconfig)
> +	{
> +		ops->setconfig(serial_dev, SERIAL_DEFAULT_CONFIG);
> +	}
> +	if (ops->setbrg)
> +	{
> +		ops->setbrg(serial_dev, 115200);
> +	}
> +
> +	priv->serial_dev = serial_dev;
> +	priv->serial_ops = ops;
> +	priv->packet_count = 0;
> +
> +	pcat_wdt_stop(dev);
> +
> +	return 0;
> +}
> +
> +static const struct wdt_ops pcat_wdt_ops = {
> +	.start = pcat_wdt_start,
> +	.reset = pcat_wdt_reset,
> +	.stop = pcat_wdt_stop,
> +};
> +
> +static const struct udevice_id pcat_wdt_ids[] = {
> +	{.compatible = "linux,wdt-pcat"},
> +	{}};
> +
> +U_BOOT_DRIVER(wdt_pcat) = {
> +	.name = "wdt_pcat",
> +	.id = UCLASS_WDT,
> +	.of_match = pcat_wdt_ids,
> +	.ops = &pcat_wdt_ops,
> +	.probe = dm_probe,
> +	.priv_auto = sizeof(struct pcat_wdt_priv),
> +};
> \ No newline at end of file

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
