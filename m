Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A621BC48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 06:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EFB387E0D;
	Thu, 22 Feb 2024 07:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WwrpZ1mB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B259B87E16; Thu, 22 Feb 2024 07:59:45 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC62587E03
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 07:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41M6xW8R079663;
 Thu, 22 Feb 2024 00:59:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708585172;
 bh=ZvHJga75iDm1t3nFFDvQukb5ZgmEUKeG2EqFYStoc5s=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=WwrpZ1mBQL1f+uAoVMs3KYA3jU87fzevm6wfrovcrE8AyVQlf+BknL6eD2GCTwkFy
 dhzJ3/oVUmAtyHJBMEp8RQ6e4X3v5shzUmr8DQ86EgbCtay4ynz9ezbbQWz9Xruket
 MG4i27kMCj8oGkeECg8eDjzfr3g9hX/n0CAUihvM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41M6xWWU109689
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 00:59:32 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 00:59:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 00:59:31 -0600
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41M6xRs8106699;
 Thu, 22 Feb 2024 00:59:28 -0600
Message-ID: <da78150d-add5-2d8b-9bb9-b66e336ea419@ti.com>
Date: Thu, 22 Feb 2024 12:29:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] net: mdio: Handle bus level GPIO Reset
To: Roger Quadros <rogerq@kernel.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom Rini
 <trini@konsulko.com>, <nm@ti.com>
CC: <srk@ti.com>, <s-vadapalli@ti.com>, <vigneshr@ti.com>,
 <mripard@kernel.org>, <dannenberg@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240219-for-2024-07-am65-cpsw-mdio-v1-0-afe9aaba5801@kernel.org>
 <20240219-for-2024-07-am65-cpsw-mdio-v1-1-afe9aaba5801@kernel.org>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240219-for-2024-07-am65-cpsw-mdio-v1-1-afe9aaba5801@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 2/19/24 9:03 PM, Roger Quadros wrote:
> Some platforms have bus level Reset controlled
> by a GPIO line. If available then handle bus reset
> via GPIO.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  include/phy.h     |  7 +++++++
>  net/mdio-uclass.c | 37 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/phy.h b/include/phy.h
> index e02cbdb58c..90a595cae4 100644
> --- a/include/phy.h
> +++ b/include/phy.h
> @@ -9,6 +9,7 @@
>  #ifndef _PHY_H
>  #define _PHY_H
>  
> +#include <asm/gpio.h>
>  #include <log.h>
>  #include <phy_interface.h>
>  #include <dm/ofnode.h>
> @@ -76,6 +77,12 @@ struct mii_dev {
>  	int (*reset)(struct mii_dev *bus);
>  	struct phy_device *phymap[PHY_MAX_ADDR];
>  	u32 phy_mask;
> +	/** @reset_delay_us: Bus GPIO reset pulse width in microseconds */
> +	int reset_delay_us;
> +	/** @reset_post_delay_us: Bus GPIO reset deassert delay in microseconds */
> +	int reset_post_delay_us;
> +	/** @reset_gpiod: Bus Reset GPIO descriptor pointer */
> +	struct gpio_desc reset_gpiod;
>  };
>  
>  /* struct phy_driver: a structure which defines PHY behavior
> diff --git a/net/mdio-uclass.c b/net/mdio-uclass.c
> index e758cc66d7..4500c50430 100644
> --- a/net/mdio-uclass.c
> +++ b/net/mdio-uclass.c
> @@ -14,6 +14,9 @@
>  #include <dm/of_extra.h>
>  #include <dm/uclass-internal.h>
>  #include <linux/compat.h>
> +#include <linux/delay.h>
> +
> +#define DEFAULT_GPIO_RESET_DELAY	10	/* in microseconds */
>  
>  void dm_mdio_probe_devices(void)
>  {
> @@ -80,6 +83,16 @@ int dm_mdio_write(struct udevice *mdio_dev, int addr, int devad, int reg,
>  int dm_mdio_reset(struct udevice *mdio_dev)
>  {
>  	struct mdio_ops *ops = mdio_get_ops(mdio_dev);
> +	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
> +	struct mii_dev *mii_bus = pdata->mii_bus;
> +
> +	if (dm_gpio_is_valid(&mii_bus->reset_gpiod)) {
> +		dm_gpio_set_value(&mii_bus->reset_gpiod, 1);

undefined reference to `dm_gpio_set_value'
Build fails for configs that don't have CONFIG_DM_GPIO defined.

We can have this under "if (IS_ENABLED(CONFIG_DM_GPIO))"

> +		udelay(mii_bus->reset_delay_us);
> +		dm_gpio_set_value(&mii_bus->reset_gpiod, 0);
> +		if (mii_bus->reset_post_delay_us > 0)
> +			udelay(mii_bus->reset_post_delay_us);
> +	}
>  
>  	if (!ops->reset)
>  		return 0;
> @@ -111,14 +124,36 @@ static int mdio_reset(struct mii_dev *mii_bus)
>  static int dm_mdio_post_probe(struct udevice *dev)
>  {
>  	struct mdio_perdev_priv *pdata = dev_get_uclass_priv(dev);
> +	struct mii_dev *mii_bus;
> +	int ret;
>  
> -	pdata->mii_bus = mdio_alloc();
> +	mii_bus = mdio_alloc();
> +	if (!mii_bus) {
> +		dev_err(dev, "couldn't allocate mii_bus\n");
> +		return -ENOMEM;
> +	}
> +	pdata->mii_bus = mii_bus;
>  	pdata->mii_bus->read = mdio_read;
>  	pdata->mii_bus->write = mdio_write;
>  	pdata->mii_bus->reset = mdio_reset;
>  	pdata->mii_bus->priv = dev;
>  	strlcpy(pdata->mii_bus->name, dev->name, MDIO_NAME_LEN);
>  
> +	if (IS_ENABLED(CONFIG_DM_GPIO)) {
> +		/* Get bus level PHY reset GPIO details */
> +		mii_bus->reset_delay_us = dev_read_u32_default(dev, "reset-delay-us",
> +							       DEFAULT_GPIO_RESET_DELAY);
> +		mii_bus->reset_post_delay_us = dev_read_u32_default(dev,
> +								    "reset-post-delay-us",
> +								    0);
> +		ret = gpio_request_by_name(dev, "reset-gpios", 0, &mii_bus->reset_gpiod,
> +					   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +		if (ret && ret != -ENOENT) {
> +			dev_err(dev, "couldn't get reset-gpios: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	return mdio_register(pdata->mii_bus);
>  }
>  
> 

-- 
Regards,
Ravi
