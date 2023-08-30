Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DDBC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 19:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6A386526;
	Wed, 30 Aug 2023 21:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XC3UUk28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D068652D; Wed, 30 Aug 2023 21:43:56 +0200 (CEST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3F70863E7
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 21:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB9CF60005;
 Wed, 30 Aug 2023 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1693424632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L6hGeul3rdw1Ux5hLlduwK8cNHywzYtpdmdjpWMH7Cw=;
 b=XC3UUk28DksQAYnwr4vsdGcIo1HL5hQzUMMNxBjXrmodBFjeTuBJMogazlhU0waIzU1Z2A
 OARKUHTeKPh+YixGTASjSEWDtwMY+Xd7R0B5FIHB103SzUhqZgceVPgAtBLZqFr1qYYHsn
 QD+y1xD4774311f2YwT0geQKViAldumQLvX6VEa+Brps38ZfJvxcnH3LRcrS75OA3IyXj8
 +Jes69kDLNZWvOy4gqW8gm/AuvGoB+jeGzX5hbImnp6BAFL3C3XxcLFow7oFLJKNoY2SEr
 9rylsXswCBVYpKRkcNZyKxXRshPQ58MiXyAy8i7oF/B46pwA/emhd5uVF6YbZA==
Date: Wed, 30 Aug 2023 21:43:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: u-boot@lists.denx.de, Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Chris Packham <judge.packham@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/5] drivers: rtc: add rv3032 driver
Message-ID: <2023083019435131e3524a@mail.local>
References: <20230830140349.10801-1-lists@steffen.cc>
 <20230830140349.10801-2-lists@steffen.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830140349.10801-2-lists@steffen.cc>
X-GND-Sasl: alexandre.belloni@bootlin.com
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

Hello,

On 30/08/2023 16:03:30+0200, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> Based on linux driver, with these differences:
> - no support for trickle charger
> - no support for hwmon
> - no support for battery backed memory
> - dm_i2c instead of regmap
> - different tm_year and tm_mon
> 
> read/write access the user eeprom. The read and write functions access
> the user eeprom so it can be used for nvmem-cells. (like in
> arch/sandbox/dts/test.dts). This is currently different from linux as
> you'd get nvram using nvmem-cells. I'm hoping to switch the order there

I'm not sure I get this as both nvram and eeprom are exposed through
nvmem. The solution is not to reorder but instead to fix the nvmem core
so you can expose both using nvmem-cells as there are users that access
the nvram to handle A/B updates (bootcount, rescue mode,...)

> too (there are currently no users) or to make a more specific binding.
> Currently this would also just work as is if used for mac addresses, as
> u-boot will put these into fdt before booting linux and linux will then
> prefer the u-boot provided mac.
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> ---
> 
>  drivers/rtc/Kconfig  |  10 ++
>  drivers/rtc/Makefile |   1 +
>  drivers/rtc/rv3032.c | 334 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/rtc/rv3032.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 23173139e0..a41ec9b6cc 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -172,6 +172,16 @@ config RTC_RV3029
>  	  This driver supports reading and writing the RTC/calendar and the
>  	  battery-baced SRAM section.
>  
> +config RTC_RV3032
> +	bool "Enable RV3032 driver"
> +	depends on DM_RTC
> +	help
> +	  The MicroCrystal RV3032 is a I2C Real Time Clock (RTC) with a 16-byte
> +	  battery-backed SRAM and a 32-byte user eeprom.
> +
> +	  This driver supports reading and writing the RTC/calendar and the
> +	  user eeprom.
> +
>  config RTC_RV8803
>  	bool "Enable RV8803 driver"
>  	depends on DM_RTC
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 308fab8da9..9c2d8c7aa9 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_RTC_PL031) += pl031.o
>  obj-$(CONFIG_RTC_PT7C4338) += pt7c4338.o
>  obj-$(CONFIG_RTC_RV3028) += rv3028.o
>  obj-$(CONFIG_RTC_RV3029) += rv3029.o
> +obj-$(CONFIG_RTC_RV3032) += rv3032.o
>  obj-$(CONFIG_RTC_RV8803) += rv8803.o
>  obj-$(CONFIG_RTC_RX8025) += rx8025.o
>  obj-$(CONFIG_RTC_RX8010SJ) += rx8010sj.o
> diff --git a/drivers/rtc/rv3032.c b/drivers/rtc/rv3032.c
> new file mode 100644
> index 0000000000..8d5d860c0a
> --- /dev/null
> +++ b/drivers/rtc/rv3032.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RTC driver for the Micro Crystal RV3032
> + *
> + * based on linux driver from
> + * Copyright (C) 2020 Micro Crystal SA
> + *
> + * Alexandre Belloni <alexandre.belloni@bootlin.com>
> + *
> + */
> +
> +#include <dm.h>
> +#include <i2c.h>
> +#include <linux/delay.h>
> +#include <regmap.h>
> +#include <rtc.h>
> +#include <time.h>
> +
> +#define RV3032_SEC			0x01
> +#define RV3032_MIN			0x02
> +#define RV3032_HOUR			0x03
> +#define RV3032_WDAY			0x04
> +#define RV3032_DAY			0x05
> +#define RV3032_MONTH			0x06
> +#define RV3032_YEAR			0x07
> +#define RV3032_ALARM_MIN		0x08
> +#define RV3032_ALARM_HOUR		0x09
> +#define RV3032_ALARM_DAY		0x0A
> +#define RV3032_STATUS			0x0D
> +#define RV3032_TLSB			0x0E
> +#define RV3032_TMSB			0x0F
> +#define RV3032_CTRL1			0x10
> +#define RV3032_CTRL2			0x11
> +#define RV3032_CTRL3			0x12
> +#define RV3032_TS_CTRL			0x13
> +#define RV3032_CLK_IRQ			0x14
> +#define RV3032_EEPROM_ADDR		0x3D
> +#define RV3032_EEPROM_DATA		0x3E
> +#define RV3032_EEPROM_CMD		0x3F
> +#define RV3032_RAM1			0x40
> +#define RV3032_PMU			0xC0
> +#define RV3032_OFFSET			0xC1
> +#define RV3032_CLKOUT1			0xC2
> +#define RV3032_CLKOUT2			0xC3
> +#define RV3032_TREF0			0xC4
> +#define RV3032_TREF1			0xC5
> +
> +#define RV3032_STATUS_VLF		BIT(0)
> +#define RV3032_STATUS_PORF		BIT(1)
> +#define RV3032_STATUS_EVF		BIT(2)
> +#define RV3032_STATUS_AF		BIT(3)
> +#define RV3032_STATUS_TF		BIT(4)
> +#define RV3032_STATUS_UF		BIT(5)
> +#define RV3032_STATUS_TLF		BIT(6)
> +#define RV3032_STATUS_THF		BIT(7)
> +
> +#define RV3032_TLSB_CLKF		BIT(1)
> +#define RV3032_TLSB_EEBUSY		BIT(2)
> +#define RV3032_TLSB_TEMP		GENMASK(7, 4)
> +
> +#define RV3032_CLKOUT2_HFD_MSK		GENMASK(4, 0)
> +#define RV3032_CLKOUT2_FD_MSK		GENMASK(6, 5)
> +#define RV3032_CLKOUT2_OS		BIT(7)
> +
> +#define RV3032_CTRL1_EERD		BIT(3)
> +#define RV3032_CTRL1_WADA		BIT(5)
> +
> +#define RV3032_CTRL2_STOP		BIT(0)
> +#define RV3032_CTRL2_EIE		BIT(2)
> +#define RV3032_CTRL2_AIE		BIT(3)
> +#define RV3032_CTRL2_TIE		BIT(4)
> +#define RV3032_CTRL2_UIE		BIT(5)
> +#define RV3032_CTRL2_CLKIE		BIT(6)
> +#define RV3032_CTRL2_TSE		BIT(7)
> +
> +#define RV3032_PMU_TCM			GENMASK(1, 0)
> +#define RV3032_PMU_TCR			GENMASK(3, 2)
> +#define RV3032_PMU_BSM			GENMASK(5, 4)
> +#define RV3032_PMU_NCLKE		BIT(6)
> +
> +#define RV3032_PMU_BSM_DSM		1
> +#define RV3032_PMU_BSM_LSM		2
> +
> +#define RV3032_OFFSET_MSK		GENMASK(5, 0)
> +
> +#define RV3032_EVT_CTRL_TSR		BIT(2)
> +
> +#define RV3032_EEPROM_CMD_UPDATE	0x11
> +#define RV3032_EEPROM_CMD_WRITE		0x21
> +#define RV3032_EEPROM_CMD_READ		0x22
> +
> +#define RV3032_EEPROM_USER		0xCB
> +
> +#define RV3032_EEBUSY_POLL		10000
> +#define RV3032_EEBUSY_TIMEOUT		100000
> +
> +#define OFFSET_STEP_PPT			238419
> +
> +static int rv3032_update_bits(struct udevice *dev, u8 reg, u8 mask, u8 set)
> +{
> +	u8 buf;
> +	int ret;
> +
> +	ret = dm_i2c_read(dev, reg, &buf, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((buf & mask) == (set && mask))
> +		return 0;
> +
> +	buf = (buf & ~mask) | (set & mask);
> +	ret = dm_i2c_read(dev, reg, &buf, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int rv3032_exit_eerd(struct udevice *dev, u32 eerd)
> +{
> +	if (eerd)
> +		return 0;
> +
> +	return rv3032_update_bits(dev, RV3032_CTRL1, RV3032_CTRL1_EERD, 0);
> +}
> +
> +static int rv3032_eeprom_busywait(struct udevice *dev)
> +{
> +	int ret;
> +	u8 status;
> +	unsigned long start = get_timer(0);
> +
> +	for (;;) {
> +		ret = dm_i2c_read(dev, RV3032_TLSB, &status, 1);
> +		if (ret < 0)
> +			break;
> +		if (!(status & RV3032_TLSB_EEBUSY))
> +			break;
> +		if (get_timer(start) > RV3032_EEBUSY_TIMEOUT)
> +			return -ETIMEDOUT;
> +		udelay(RV3032_EEBUSY_POLL);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rv3032_enter_eerd(struct udevice *dev, u32 *eerd)
> +{
> +	u8 ctrl1;
> +	int ret;
> +
> +	ret = dm_i2c_read(dev, RV3032_CTRL1, &ctrl1, sizeof(ctrl1));
> +	if (ret)
> +		return ret;
> +
> +	*eerd = ctrl1 & RV3032_CTRL1_EERD;
> +	if (*eerd)
> +		return 0;
> +
> +	ret = rv3032_update_bits(dev, RV3032_CTRL1,
> +				 RV3032_CTRL1_EERD, RV3032_CTRL1_EERD);
> +	if (ret)
> +		return ret;
> +
> +	ret = rv3032_eeprom_busywait(dev);
> +	if (ret) {
> +		rv3032_exit_eerd(dev, *eerd);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rv3032_get_time(struct udevice *dev, struct rtc_time *tm)
> +{
> +	u8 date[7];
> +	int ret;
> +	u8 status;
> +
> +	ret = dm_i2c_read(dev, RV3032_STATUS, &status, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (status & (RV3032_STATUS_PORF | RV3032_STATUS_VLF))
> +		return -EINVAL;
> +
> +	ret = dm_i2c_read(dev, RV3032_SEC, date, sizeof(date));
> +	if (ret)
> +		return ret;
> +
> +	tm->tm_sec  = bcd2bin(date[0] & 0x7f);
> +	tm->tm_min  = bcd2bin(date[1] & 0x7f);
> +	tm->tm_hour = bcd2bin(date[2] & 0x3f);
> +	tm->tm_wday = date[3] & 0x7;
> +	tm->tm_mday = bcd2bin(date[4] & 0x3f);
> +	tm->tm_mon  = bcd2bin(date[5] & 0x1f);
> +	tm->tm_year = bcd2bin(date[6]) + 2000;
> +
> +	return 0;
> +}
> +
> +static int rv3032_set_time(struct udevice *dev, const struct rtc_time *tm)
> +{
> +	u8 date[7];
> +	int ret;
> +
> +	date[0] = bin2bcd(tm->tm_sec);
> +	date[1] = bin2bcd(tm->tm_min);
> +	date[2] = bin2bcd(tm->tm_hour);
> +	date[3] = tm->tm_wday;
> +	date[4] = bin2bcd(tm->tm_mday);
> +	date[5] = bin2bcd(tm->tm_mon);
> +	date[6] = bin2bcd(tm->tm_year - 2000);
> +
> +	ret = dm_i2c_write(dev, RV3032_SEC, date,
> +			   sizeof(date));
> +	if (ret)
> +		return ret;
> +
> +	ret = rv3032_update_bits(dev, RV3032_STATUS,
> +				 RV3032_STATUS_PORF | RV3032_STATUS_VLF, 0);
> +
> +	return ret;
> +}
> +
> +static int rv3032_eeprom_write(struct udevice *dev, unsigned int reg,
> +			       const u8 *buf, unsigned int len)
> +{
> +	u32 eerd;
> +	int i, ret;
> +	u8 cmd;
> +
> +	ret = rv3032_enter_eerd(dev, &eerd);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < len; i++) {
> +		cmd	= RV3032_EEPROM_USER + reg + i;
> +		ret = dm_i2c_write(dev, RV3032_EEPROM_ADDR,
> +				   &cmd, 1);
> +		if (ret)
> +			goto exit_eerd;
> +
> +		ret = dm_i2c_write(dev, RV3032_EEPROM_DATA, &buf[i], 1);
> +		if (ret)
> +			goto exit_eerd;
> +
> +		cmd = RV3032_EEPROM_CMD_WRITE;
> +		ret = dm_i2c_write(dev, RV3032_EEPROM_CMD,
> +				   &cmd, 1);
> +		if (ret)
> +			goto exit_eerd;
> +
> +		udelay(RV3032_EEBUSY_POLL);
> +
> +		ret = rv3032_eeprom_busywait(dev);
> +		if (ret)
> +			goto exit_eerd;
> +	}
> +
> +exit_eerd:
> +	rv3032_exit_eerd(dev, eerd);
> +
> +	return ret;
> +}
> +
> +static int rv3032_eeprom_read(struct udevice *dev, unsigned int reg,
> +			      u8 *buf, unsigned int len)
> +{
> +	u32 eerd;
> +	int i, ret;
> +	u8 cmd, data;
> +
> +	ret = rv3032_enter_eerd(dev, &eerd);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < len; i++) {
> +		cmd = RV3032_EEPROM_USER + reg + i;
> +		ret = dm_i2c_write(dev, RV3032_EEPROM_ADDR,
> +				   &cmd, 1);
> +		if (ret)
> +			goto exit_eerd;
> +
> +		cmd = RV3032_EEPROM_CMD_READ;
> +		ret = dm_i2c_write(dev, RV3032_EEPROM_CMD,
> +				   &cmd, 1);
> +		if (ret)
> +			goto exit_eerd;
> +
> +		ret = rv3032_eeprom_busywait(dev);
> +		if (ret)
> +			goto exit_eerd;
> +
> +		ret = dm_i2c_read(dev, RV3032_EEPROM_DATA, &data, sizeof(data));
> +		if (ret)
> +			goto exit_eerd;
> +		buf[i] = data;
> +	}
> +
> +exit_eerd:
> +	rv3032_exit_eerd(dev, eerd);
> +
> +	return ret;
> +}
> +
> +static int rv3032_probe(struct udevice *dev)
> +{
> +	i2c_set_chip_flags(dev, DM_I2C_CHIP_RD_ADDRESS |
> +			DM_I2C_CHIP_WR_ADDRESS);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_ops rv3032_rtc_ops = {
> +	.get = rv3032_get_time,
> +	.set = rv3032_set_time,
> +	.read = rv3032_eeprom_read,
> +	.write = rv3032_eeprom_write,
> +};
> +
> +static const struct udevice_id rv3032_rtc_ids[] = {
> +	{ .compatible = "microcrystal,rv3032", },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(rtc_rv3032) = {
> +	.name	= "rtc-rv3028",
> +	.id	= UCLASS_RTC,
> +	.probe	= rv3032_probe,
> +	.of_match = rv3032_rtc_ids,
> +	.ops	= &rv3032_rtc_ops,
> +};
> -- 
> 2.42.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
