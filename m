Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4024CC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A886787FFC;
	Tue, 27 Feb 2024 14:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sNOdPV/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85EF388002; Tue, 27 Feb 2024 14:51:20 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3539387FF2
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0FBE6CE1B72;
 Tue, 27 Feb 2024 13:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CC2C433C7;
 Tue, 27 Feb 2024 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709041875;
 bh=09mlgvZXWs9luBnUX1/sK9XDz9LpgI98f1CX4MqlS6k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sNOdPV/Oye0xUyoBgIcyqgi1Ibcb+XubeaWQM1scM7ppzlxhJeY5SLqBiLBNbPunx
 1FZuQmJ6UNAn1qZamHJ5nOO9PwGw9R0tbqLmnXICYH7TY2uU2g4Cko0IudCM1R6z6c
 JonNi6puSNBUkmdraOOovfcdm6p7P4cuulcHdSvZpPGjuj+Xxk93v08fyV//OZ6JKD
 E8JSfyxLzB/peV3IFVht6Ig+3Vl7IjYQrLRtRSR/ghxghetr/RD8Bi81N3pEnYoYlY
 qLWtAQJb2nURE67EKL8nC+VN+5nQ5pRE+6y4Nsc4rFD1MClsiGtpvIiX++KhO9JdsA
 eyMScy8AMnKZw==
Message-ID: <4a5c8ac5-0423-4642-8972-f794da79b423@kernel.org>
Date: Tue, 27 Feb 2024 15:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: mdio: Handle bus level GPIO Reset
Content-Language: en-US
To: Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, nm@ti.com
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, mripard@kernel.org,
 dannenberg@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
References: <20240219-for-2024-07-am65-cpsw-mdio-v1-0-afe9aaba5801@kernel.org>
 <20240219-for-2024-07-am65-cpsw-mdio-v1-1-afe9aaba5801@kernel.org>
 <da78150d-add5-2d8b-9bb9-b66e336ea419@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <da78150d-add5-2d8b-9bb9-b66e336ea419@ti.com>
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



On 22/02/2024 08:59, Ravi Gunasekaran wrote:
> 
> 
> On 2/19/24 9:03 PM, Roger Quadros wrote:
>> Some platforms have bus level Reset controlled
>> by a GPIO line. If available then handle bus reset
>> via GPIO.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  include/phy.h     |  7 +++++++
>>  net/mdio-uclass.c | 37 ++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/phy.h b/include/phy.h
>> index e02cbdb58c..90a595cae4 100644
>> --- a/include/phy.h
>> +++ b/include/phy.h
>> @@ -9,6 +9,7 @@
>>  #ifndef _PHY_H
>>  #define _PHY_H
>>  
>> +#include <asm/gpio.h>
>>  #include <log.h>
>>  #include <phy_interface.h>
>>  #include <dm/ofnode.h>
>> @@ -76,6 +77,12 @@ struct mii_dev {
>>  	int (*reset)(struct mii_dev *bus);
>>  	struct phy_device *phymap[PHY_MAX_ADDR];
>>  	u32 phy_mask;
>> +	/** @reset_delay_us: Bus GPIO reset pulse width in microseconds */
>> +	int reset_delay_us;
>> +	/** @reset_post_delay_us: Bus GPIO reset deassert delay in microseconds */
>> +	int reset_post_delay_us;
>> +	/** @reset_gpiod: Bus Reset GPIO descriptor pointer */
>> +	struct gpio_desc reset_gpiod;
>>  };
>>  
>>  /* struct phy_driver: a structure which defines PHY behavior
>> diff --git a/net/mdio-uclass.c b/net/mdio-uclass.c
>> index e758cc66d7..4500c50430 100644
>> --- a/net/mdio-uclass.c
>> +++ b/net/mdio-uclass.c
>> @@ -14,6 +14,9 @@
>>  #include <dm/of_extra.h>
>>  #include <dm/uclass-internal.h>
>>  #include <linux/compat.h>
>> +#include <linux/delay.h>
>> +
>> +#define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
>>  
>>  void dm_mdio_probe_devices(void)
>>  {
>> @@ -80,6 +83,16 @@ int dm_mdio_write(struct udevice *mdio_dev, int addr, int devad, int reg,
>>  int dm_mdio_reset(struct udevice *mdio_dev)
>>  {
>>  	struct mdio_ops *ops = mdio_get_ops(mdio_dev);
>> +	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
>> +	struct mii_dev *mii_bus = pdata->mii_bus;
>> +
>> +	if (dm_gpio_is_valid(&mii_bus->reset_gpiod)) {
>> +		dm_gpio_set_value(&mii_bus->reset_gpiod, 1);
> 
> undefined reference to `dm_gpio_set_value'
> Build fails for configs that don't have CONFIG_DM_GPIO defined.
> 
> We can have this under "if (IS_ENABLED(CONFIG_DM_GPIO))"

Thanks. I'll check this.

> 
>> +		udelay(mii_bus->reset_delay_us);
>> +		dm_gpio_set_value(&mii_bus->reset_gpiod, 0);
>> +		if (mii_bus->reset_post_delay_us > 0)
>> +			udelay(mii_bus->reset_post_delay_us);
>> +	}
>>  
>>  	if (!ops->reset)
>>  		return 0;
>> @@ -111,14 +124,36 @@ static int mdio_reset(struct mii_dev *mii_bus)
>>  static int dm_mdio_post_probe(struct udevice *dev)
>>  {
>>  	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(dev);
>> +	struct mii_dev *mii_bus;
>> +	int ret;
>>  
>> -	pdata->mii_bus = mdio_alloc();
>> +	mii_bus = mdio_alloc();
>> +	if (!mii_bus) {
>> +		dev_err(dev, "couldn't allocate mii_bus\n");
>> +		return -ENOMEM;
>> +	}
>> +	pdata->mii_bus = mii_bus;
>>  	pdata->mii_bus->read = mdio_read;
>>  	pdata->mii_bus->write = mdio_write;
>>  	pdata->mii_bus->reset = mdio_reset;
>>  	pdata->mii_bus->priv = dev;
>>  	strlcpy(pdata->mii_bus->name, dev->name, MDIO_NAME_LEN);
>>  
>> +	if (IS_ENABLED(CONFIG_DM_GPIO)) {
>> +		/* Get bus level PHY reset GPIO details */
>> +		mii_bus->reset_delay_us = dev_read_u32_default(dev, "reset-delay-us",
>> +							       DEFAULT_GPIO_RESET_DELAY);
>> +		mii_bus->reset_post_delay_us = dev_read_u32_default(dev,
>> +								    "reset-post-delay-us",
>> +								    0);
>> +		ret = gpio_request_by_name(dev, "reset-gpios", 0, &mii_bus->reset_gpiod,
>> +					   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
>> +		if (ret && ret != -ENOENT) {
>> +			dev_err(dev, "couldn't get reset-gpios: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>>  	return mdio_register(pdata->mii_bus);
>>  }
>>  
>>
> 

-- 
cheers,
-roger
