Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69DCCF9C6D
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 21:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A2C88CF0;
	Sun, 22 Sep 2024 23:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727041318;
	bh=dXDB4uLw7cnkqbm0swAdpiW0E7463VNnYl8LrZUOVSs=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kqubMBGAhGwnMMO0ghhZbg8BArgx0rqb4Lcsx4AQx97VRqd1uBXPKw0eAlXtnSUJa
	 V5OQYVFKZT0m5POcrkOWKIw+SI28c82LLQGNoQV7lyY16xdY0KifqdyCy1zG8UCaz9
	 6IJKRcUBxdY6VGcNTzMKS/YPRjS68Yd6IlHLH5uopCajnX9RboJlBfMH9udoTDmZ3r
	 0QmCpoZQDX5ar8U8c9pdk7YcXCuOtGkgTH3EwAH9p6N9nhSYtOqBa716OdBq5cnojs
	 CEJbjKar+LAVsqh2Gw8s+fZFR+GFS0HVkfwzay62U2YLck0e0tCHcNM7tVBqrhtoy3
	 U+xoQy5iWGUKQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6753F88CB8;
 Sun, 22 Sep 2024 23:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727041316;
 bh=dXDB4uLw7cnkqbm0swAdpiW0E7463VNnYl8LrZUOVSs=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=tWtrtOJMtSx4RPuqCA+DSTz+zc6AYKebgU7/Wo2g1phtUr2dwB9xuYU2nacW+rf5a
 84rvIYyDcMMYR8GcchclYmTQKnvz6CJvLxA8PS+2xNrUba6Xl7cjHvJyx6jlTLbVO9
 +zJR4Eavlw+0Un8PWGGMRZ7MBwRynrHxQWVu36kpdxYnvJrATjFA91go0KnCibPhSZ
 8oxjvQTJ+cN57YPz0uU5mpuogk0/nfrURzXO1IjRoJ4oOQpSGM7ztaSiLn6RleweKj
 mnMqJucoRpEzFYzJ4ZzDixbuj9OPSYvAb+zEa+tCrGZHvztmTbbHWY+jbjHWnYfzBc
 Uyxa0/Y2B7p0Q==
Message-ID: <8d745de9-26da-4e0c-8393-fb2550c363b6@denx.de>
Date: Sun, 22 Sep 2024 23:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] ARM: socfpga: AA1: support MAC from secure eeprom
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240917062157.3181-1-l.rubusch@gmail.com>
 <20240917062157.3181-8-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240917062157.3181-8-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/17/24 8:21 AM, Lothar Rubusch wrote:

[...]

> +int enclustra_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
> +{
> +	struct udevice *dev;
> +	u32 hwaddr_h;
> +	u8 data[4];
> +	int i, j, eeprom_addr, mac_len, ret;
> +
> +	ret = uclass_get_device_by_name(UCLASS_MISC, alias, &dev);
> +	if (ret) {
> +		printf("%s: Failed, cannot find EEPROM! ret = %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	/* Make sure atsha204a is in a defined state (part of protocol) */
> +	if (atsha204a_sleep(dev)) {

Please propagate return values.

> +		printf("%s(): Failed to bring EEPROM in defined state\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	if (atsha204a_wakeup(dev)) {
> +		printf("%s(): Failed to wakeup EEPROM\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	/* Read twice portions of 4 bytes (atsha204 protocol). One from address 4

Use Linux comment style, not netdev:

/*
  * Read some
  * stuff
  * and so on
  */

> +	 * the other from address 5 of the OTP zone. Then convert the data to
> +	 * the 6 elements of the MAC address.
> +	 */
> +	eeprom_addr = 4;
> +	mac_len = 6;

These can be const variables assigned at the beginning of this function.

> +	for (i = 0; i < 2; i++) {
> +		eeprom_addr += i;
> +		if (atsha204a_read(dev, ATSHA204A_ZONE_OTP, false, eeprom_addr, data)) {
> +			printf("%s(): Failed to parse ATSHA204A_ZONE_OTP of EEPROM\n",
> +			       __func__);
> +			return -EFAULT;
> +		}
> +
> +		for (j = 0; j < 4 && j + i * 4 < mac_len; j++)
> +			enetaddr[j + i * 4] = data[j];
> +	}
> +
> +	/* Check if the value is a valid mac registered for
> +	 * Enclustra  GmbH
> +	 */
> +	hwaddr_h = enetaddr[0] | enetaddr[1] << 8 | enetaddr[2] << 16;
> +	if ((hwaddr_h & 0xFFFFFF) != ENCLUSTRA_MAC) {
> +		printf("%s(): Failed, parsed MAC is no Enclustra MAC\n", __func__);
> +		return -ENOENT;
> +	}
> +
> +	if (!is_valid_ethaddr(enetaddr)) {
> +		printf("%s(): Failed, address read from EEPROM is invalid!\n",
> +		       __func__);
> +		return -EINVAL;
> +	}
> +
> +	printf("ethaddr set to %02X:%02X:%02X:%02X:%02X:%02X\n",
> +	       enetaddr[0], enetaddr[1], enetaddr[2],
> +	       enetaddr[3], enetaddr[4], enetaddr[5]);

This should be:

debug("ethaddr set to %pM\n", ethaddr);

see lib/vsprintf.c for the formatting strings.

> +	return 0;
> +}
> +
> +__weak int enclustra_setup_mac_address(void)
> +{
> +	unsigned char enetaddr[6];
> +
> +	if (enclustra_mac_is_in_env("ethaddr"))
> +		return 0;
> +
> +	if (enclustra_get_mac_is_enabled("ethernet0"))
> +		return 0;
> +
> +	if (enclustra_get_mac_from_eeprom(enetaddr, "atsha204a@64"))

Please propagate return values, fix globally.

> +		return -ENXIO;
> +
> +	if (eth_env_set_enetaddr("ethaddr", enetaddr))
> +		return -ENXIO;
> +
> +	if (!enclustra_get_mac1_from_mac(enetaddr))
> +		return eth_env_set_enetaddr("eth1addr", enetaddr);
> +
> +	printf("%s(): Failed, unable to set mac address!\n", __func__);
> +	return -ENXIO;
> +}

[...]

> +int enclustra_get_mac1_from_mac(unsigned char *enetaddr)
> +{
> +	u32 hwaddr_h;
> +
> +	/* Increment MAC addr */
> +	hwaddr_h = (enetaddr[3] << 16) | (enetaddr[4] << 8) | enetaddr[5];
> +	hwaddr_h = (hwaddr_h + 1) & 0xFFFFFF;
> +	enetaddr[3] = (hwaddr_h >> 16) & 0xFF;
> +	enetaddr[4] = (hwaddr_h >> 8) & 0xFF;
> +	enetaddr[5] = hwaddr_h & 0xFF;
> +
> +	if (!is_valid_ethaddr(enetaddr)) {
> +		printf("%s(): Failed, address computed from enetaddr is invalid!\n",
> +		       __func__);
> +		return -EINVAL;
> +	}
> +
> +	printf("eth1addr set to %02X:%02X:%02X:%02X:%02X:%02X\n",
> +	       enetaddr[0], enetaddr[1], enetaddr[2],
> +	       enetaddr[3], enetaddr[4], enetaddr[5]);

debug("... %pM\n", enetaddr);

> +	return 0;
> +}
> diff --git a/board/enclustra/common/mac_ds28.c b/board/enclustra/common/mac_ds28.c
> new file mode 100644
> index 0000000000..9aed4f1de1
> --- /dev/null
> +++ b/board/enclustra/common/mac_ds28.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Enclustra GmbH
> + */
> +
> +#include <linux/compat.h>
> +#include <dm.h>
> +#include <i2c.h>
> +#include <net.h>
> +
> +#include "enclustra_mac.h"
> +
> +#define DS28_I2C_ADDR 0x5C
> +#define DS28_SYS_I2C_EEPROM_BUS 0
> +
> +int enclustra_get_mac_from_eeprom(unsigned char *enetaddr, const char *alias)
> +{
> +	struct udevice *dev;
> +	u32 hwaddr_h;
> +	struct dm_i2c_chip *chip;
> +	uint chip_addr = DS28_I2C_ADDR;
> +	int alen = 1;
> +	int ret;
> +
> +	if (i2c_get_chip_for_busnum(DS28_SYS_I2C_EEPROM_BUS, chip_addr,
> +				    alen, &dev))
> +		return -ENODEV;
> +
> +	chip = dev_get_parent_plat(dev);
> +	if (chip->offset_len != alen) {
> +		debug("I2C chip %x: alen %d does not match offset_len %d\n",
> +		      chip_addr, alen, chip->offset_len);
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	ret = dm_i2c_read(dev, 0x10, enetaddr, 6);
> +	if (ret) {
> +		printf("%s(): Failed reading EEPROM! ret = %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	/* Check if the value is a valid mac registered for
> +	 * Enclustra  GmbH
> +	 */
> +	hwaddr_h = enetaddr[0] | enetaddr[1] << 8 | enetaddr[2] << 16;

Better use () around the shifts, i.e. ... | (enetaddr[i] << 8) | ...

> +	if ((hwaddr_h & 0xFFFFFF) != ENCLUSTRA_MAC) {
> +		printf("%s(): Failed, parsed MAC is no Enclustra MAC\n", __func__);
> +		return -ENOENT;
> +	}
> +
> +	if (!is_valid_ethaddr(enetaddr)) {
> +		printf("%s(): Failed, address read from EEPROM is invalid!\n",
> +		       __func__);
> +		return -EINVAL;
> +	}
> +
> +	printf("ethaddr set to %02X:%02X:%02X:%02X:%02X:%02X\n",
> +	       enetaddr[0], enetaddr[1], enetaddr[2],
> +	       enetaddr[3], enetaddr[4], enetaddr[5]);
> +
> +	return 0;
> +}
> +
> +__weak int enclustra_setup_mac_address(void)

Is the __weak really necessary ?

> +{
> +	unsigned char enetaddr[6];
> +
> +	if (enclustra_mac_is_in_env("ethaddr"))
> +		return 0;
> +
> +	if (enclustra_get_mac_is_enabled("ethernet0"))
> +		return 0;
> +
> +	// NB: DS28 is still not available in official DT, so referencing
> +	// here by i2c busnumber and address directly
> +	// preparation for DT access here, though

Use C comment style /* */

> +	if (enclustra_get_mac_from_eeprom(enetaddr, ""))
> +		return -ENXIO;
> +
> +	if (eth_env_set_enetaddr("ethaddr", enetaddr))
> +		return -ENXIO;
> +
> +	if (!enclustra_get_mac1_from_mac(enetaddr))
> +		return eth_env_set_enetaddr("eth1addr", enetaddr);
> +
> +	printf("%s(): Failed, unable to set mac address!\n", __func__);

MAC address, MAC in capitals.

[...]

> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -73,7 +73,7 @@ config ATSHA204A
>   	help
>   	   Enable support for I2C connected Atmel's ATSHA204A
>   	   CryptoAuthentication module found for example on the Turris Omnia
> -	   board.
> +	   board and Enclustra SoC FPGA boards.
This change should be elsewhere in this series ?
