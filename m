Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED20C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A93F8801A;
	Tue, 27 Feb 2024 14:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nck8JZpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104DD88019; Tue, 27 Feb 2024 14:52:12 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFAA87FF7
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CF0346124B;
 Tue, 27 Feb 2024 13:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B457FC433F1;
 Tue, 27 Feb 2024 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709041925;
 bh=gS4YOr5KQ1zVfLrMwo5f6mcbsivoKo0b7LS9cyNzi9s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Nck8JZpkiv7jJjC8lp/NBvsRtKTrMrErDWg+TAz2uA2OksdVrxdyu6sryytz+KHs9
 ErIOsCVhhnkWHl2aVbvkBC6LswoF3D2c9/uzuxJXSdzls3vgh+DtLxlCZmo7dNfoe+
 tun6kdHVThewj4D8N4di5W+i1jGsEXPi25Isc4nfnKmymFXaPpgXW2GRTaCqz7NJEI
 LPA5lSGt9rD5UDskRuWaWbNsVNSKMl/PRgtPOz5XD+FG5rGvMPcHMWasvR1ru2wazT
 DDurQ7zkQrDZfus2RN5C6LBwRYS10rh/ttgRby0HHUpIJnrrEXQTpjoICOy8R1mRvh
 MFPCzgW6Wsw5w==
Message-ID: <e0435bc6-d874-4f0c-a23c-c929ba98b2bd@kernel.org>
Date: Tue, 27 Feb 2024 15:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: mdio: Handle bus level GPIO Reset
Content-Language: en-US
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, nm@ti.com
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, mripard@kernel.org,
 dannenberg@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
References: <20240219-for-2024-07-am65-cpsw-mdio-v1-0-afe9aaba5801@kernel.org>
 <20240219-for-2024-07-am65-cpsw-mdio-v1-1-afe9aaba5801@kernel.org>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240219-for-2024-07-am65-cpsw-mdio-v1-1-afe9aaba5801@kernel.org>
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



On 19/02/2024 17:33, Roger Quadros wrote:
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

azure pipeline failed for some platforms with this error

+In file included from include/net/ncsi.h:8,
+                 from cmd/net.c:24:
+include/phy.h:12:10: fatal error: asm/gpio.h: No such file or directory
+   12 | #include <asm/gpio.h>
+      |          ^~~~~~~~~~~~
+compilation terminated.
+make[2]: *** [scripts/Makefile.build:256: cmd/net.o] Error 1
+make[1]: *** [Makefile:1859: cmd] Error 2
+make: *** [Makefile:177: sub-make] Error 2

I'll fix this in v2

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
cheers,
-roger
