Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22202FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B40A84485;
	Sat, 25 Apr 2026 20:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="L6YqTbMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316CD84359; Sat, 25 Apr 2026 19:04:44 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C53D84314
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so7666966a91.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777136679; x=1777741479;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LP8RZxXgehMgGibw3rWAAAb+E8kNyuXwR2Bf7xWWQ4U=;
 b=L6YqTbMCsHZNV6KCVMXqbZ5q/kVyp7xctHwI1vzdsTF/NcAi/8IrI2XeMv1Px+lvje
 9gHPEAVMrV+uTYhaGBau3b9zAp4/SyHaDpoY/0be/SyIeIWmm936oJ7qW8/HaonGRcT0
 9t9IvRXUBnFtClFr2a5MxKM5paHvbeAgVDXi684jSN1VNTPbquKbgwbctcYIlm7WXWly
 IZIXxtTrOaLcedb8vECMwPDSXGlcm38r0L1xPvki5naBuMVk7sRIVLHY6EA+1+z5KdcC
 34h8CsOHP0mh3ag1o3KpATBcMtcrm12Yj/DRxuZFycXrrJGPNHUkKsCk7ot7xoeVAFW5
 9afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777136679; x=1777741479;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LP8RZxXgehMgGibw3rWAAAb+E8kNyuXwR2Bf7xWWQ4U=;
 b=Sd4V7FTwB4L5m+2f9XSoH2av9u59N2uxssqx2BS19y1dCcpyJ2gVCkV9uIEbB+ZwMr
 Xl50H9oYWF+JtxJE33TdHSxt9HuPWjgkuvM0RkOBZpJqbe4ThIAGgDU/1mG2qlzIWjhS
 6NSixufBKVnKPOCw6XpMc0vffipUFom89Wa/GAM+Ew1zmkSbRRTZe5RMYaJ6xhG2YdCZ
 kg5H8adbAKflUtgYYlF5+sXbT/tyWNbGckrYB71kmnX+SAhy6Fcr9mT5HE31dgTmk79v
 WJ071zPRXPo5wDXhZqmDCcFuxG/SO8Tf9vZfrEN5d1la8xBr7qXwAN8igTy/5o+cJc18
 szzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mxYuLsOXxU2WOGFRdyvBPCIts2o8EAo8nMpkA3WmUHbfRVYu9eZYR7Dqyxar2dCPaq8LynS8=@lists.denx.de
X-Gm-Message-State: AOJu0YwzVoSr/rdOT5IMVD/xEf5hQo/C5ZfSqkk8P23xUaWxmuvW98tH
 bTrFKoI3OuMwlS7wR3oGK5mK5E7eo8dADfRQwG3d0fvfBwwiHtNrWEw+I5yHkhBA11KDdOgZGi0
 k1c3u
X-Gm-Gg: AeBDieuXZB2ZJw+kL2nWM2Ogb1Bx9ngez0Lm2Uknq9HFhWn7ZMk158rTIbRH8a0EMnq
 slZkI8YfD31KUzORCUt3AvBUHu0+cUM2jNMY/5ApV6xGcjN7vkB2hkIFWj0ptEZFP9quZaa1fI2
 wKM/c24shIlICqbZMFxfxUTWvN4JiUlyBNPZq7P/lvLpkynnhlyrylyHr/m+FyU6AunDbLuUzlX
 nBGp7SJF8B/IX5VA9YQDqZVX6v8p2t1sctnzxZ57CF2IzoKXBRzvmgIrqDQEr7+rY5z8cSp+PlV
 aGI+fzt/rjkIyQW9pfcnro7ruGd66K3QV7vV8wQ7YBtWOx3RCKWZQJ7qlpRypOMla7aZO4VehL7
 7v+GGN64uY1m0KhwJt+nlud7mvh9a7auUQxw7CGAYvbE5T9IsAg7bzqRMsVSkJfeLXHrHc46e9J
 nsWtEUgix9vqpTsJv+luarvLohvzUjahyhCS3b2zKpSn1mdYdvJ12mS7MCgCbDQ2wsnvCIp0TA4
 ikHyszNqE4P
X-Received: by 2002:a05:690c:c50d:b0:7ba:f858:1ece with SMTP id
 00721157ae682-7baf8581f61mr162481097b3.39.1776955277598; 
 Thu, 23 Apr 2026 07:41:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3cc7:689f:be44:d58a?
 ([2600:8803:e7e4:500:3cc7:689f:be44:d58a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7b9ee8be7b4sm80437577b3.13.2026.04.23.07.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 07:41:17 -0700 (PDT)
Message-ID: <46a97266-620e-41ca-972a-936a08904d5f@baylibre.com>
Date: Thu, 23 Apr 2026 09:41:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] net: phy: air_phy_lib: Factorize BuckPBus register
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Samuel Holland
 <samuel.holland@sifive.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tommy Shih
 <tommy.shih@airoha.com>, Kevin-KW Huang <kevin-kw.huang@airoha.com>
References: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
 <20260423-add-ethernet-support-for-genio-520-720-v1-5-47ca918e0017@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260423-add-ethernet-support-for-genio-520-720-v1-5-47ca918e0017@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

On 4/23/26 8:25 AM, Julien Stephan wrote:
> In preparation of Airoha AN8801R PHY support, move the BuckPBus
> register accessors and definitions, present in air_en8811h driver,
> into the Airoha PHY shared code (air_phy_lib), so they will be usable
> by the new driver without duplicating them.
> Also, update air_en8811h driver to use the new function names.
> 
> Adapted from [1].
> 
> [1]: https://lore.kernel.org/all/20260326-add-airoha-an8801-support-v2-2-1a42d6b6050f@collabora.com/

This can be written as a tag:


Link: https://lore.kernel.org/all/20260326-add-airoha-an8801-support-v2-2-1a42d6b6050f@collabora.com/ [1]
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  MAINTAINERS                          |   2 +-
>  drivers/net/phy/airoha/Kconfig       |   6 +
>  drivers/net/phy/airoha/Makefile      |   1 +
>  drivers/net/phy/airoha/air_en8811.c  | 276 +++++++----------------------------
>  drivers/net/phy/airoha/air_phy_lib.c | 221 ++++++++++++++++++++++++++++
>  drivers/net/phy/airoha/air_phy_lib.h |  39 +++++
>  6 files changed, 320 insertions(+), 225 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40ba3542ca3..4bda6b9e8c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -61,7 +61,7 @@ F:	lib/acpi/
>  AIROHA PHY
>  M:	Tommy Shih <tommy.shih@airoha.com>
>  S:	Maintained
> -F:	drivers/net/phy/airoha/air_en8811.c
> +F:	drivers/net/phy/airoha/
>  
>  ALIST
>  M:	Simon Glass <sjg@chromium.org>
> diff --git a/drivers/net/phy/airoha/Kconfig b/drivers/net/phy/airoha/Kconfig
> index da8747939e3..2a2f4f05bb2 100644
> --- a/drivers/net/phy/airoha/Kconfig
> +++ b/drivers/net/phy/airoha/Kconfig
> @@ -7,6 +7,12 @@ config PHY_AIROHA_EN8811
>  	depends on PHY_AIROHA
>  	depends on SUPPORTS_FW_LOADER
>  	select FW_LOADER
> +	select PHY_AIRONA_PHYLIB
>  	help
>  	  AIROHA EN8811H supported.
>  	  AIROHA AN8811HB supported.
> +
> +config PHY_AIRONA_PHYLIB
> +	tristate
> +	help
> +	  Airoha Ethernet PHY common library
> diff --git a/drivers/net/phy/airoha/Makefile b/drivers/net/phy/airoha/Makefile
> index 84d23b19ab0..cbf123986f2 100644
> --- a/drivers/net/phy/airoha/Makefile
> +++ b/drivers/net/phy/airoha/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_PHY_AIROHA_EN8811) += air_en8811.o
> +obj-$(CONFIG_PHY_AIRONA_PHYLIB) += air_phy_lib.o
> diff --git a/drivers/net/phy/airoha/air_en8811.c b/drivers/net/phy/airoha/air_en8811.c
> index 0b974472732..04b7282072d 100644
> --- a/drivers/net/phy/airoha/air_en8811.c
> +++ b/drivers/net/phy/airoha/air_en8811.c

...

> @@ -887,12 +725,12 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> -				     EN8811H_FW_CTRL_1_START);
> +	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +					 EN8811H_FW_CTRL_1_START);
>  	if (ret < 0)
>  		return ret;
>  
> -	return air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +	return air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>  				      EN8811H_FW_CTRL_1_FINISH);

Need to fix alignment?

>  }
>  
> @@ -1091,8 +929,8 @@ static int en8811h_config(struct phy_device *phydev)
>  		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
>  	else
>  		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
> -	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
> -				      EN8811H_POLARITY_RX_REVERSE |
> +	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
> +					  EN8811H_POLARITY_RX_REVERSE |
>  				      EN8811H_POLARITY_TX_NORMAL,
>  				      pbus_value);

And here?

>  	if (ret < 0)
> @@ -1142,12 +980,12 @@ static int an8811hb_config(struct phy_device *phydev)
>  		priv->mcu_needs_restart = true;
>  	}
>  
> -	ret = air_buckpbus_reg_read(phydev, AN8811HB_PRO_ID, &pbus_value);
> +	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_PRO_ID, &pbus_value);
>  	if (ret < 0)
>  		return ret;
>  	priv->pro_id = (pbus_value & AN8811HB_PRO_ID_VERSION) + 1;
>  
> -	ret = air_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
> +	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
>  	if (ret < 0)
>  		return ret;
>  	priv->pkg_sel = (pbus_value & AN8811HB_HWTRAP2_PKG) >> 12;
> @@ -1163,8 +1001,8 @@ static int an8811hb_config(struct phy_device *phydev)
>  		pbus_value |= AN8811HB_RX_POLARITY_NORMAL;
>  
>  	debug("1 pbus_value 0x%x\n", pbus_value);
> -	ret = air_buckpbus_reg_modify(phydev, AN8811HB_RX_POLARITY,
> -				      AN8811HB_RX_POLARITY_NORMAL, pbus_value);
> +	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_RX_POLARITY,
> +					  AN8811HB_RX_POLARITY_NORMAL, pbus_value);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1175,34 +1013,34 @@ static int an8811hb_config(struct phy_device *phydev)
>  		pbus_value |= AN8811HB_TX_POLARITY_NORMAL;
>  
>  	debug("2 pbus_value 0x%x\n", pbus_value);
> -	ret = air_buckpbus_reg_modify(phydev, AN8811HB_TX_POLARITY,
> -				      AN8811HB_TX_POLARITY_NORMAL, pbus_value);
> +	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_TX_POLARITY,
> +					  AN8811HB_TX_POLARITY_NORMAL, pbus_value);
>  	if (ret < 0)
>  		return ret;
>  
>  	/* Configure led gpio pins as output */
>  	if (priv->pkg_sel) {
> -		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> -					      AN8811HB_GPIO_OUTPUT_MASK,
> +		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> +						  AN8811HB_GPIO_OUTPUT_MASK,
>  					      AN8811HB_GPIO_OUTPUT_0115);
>  		if (ret < 0)
>  			return ret;
> -		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_1,
> -					      AN8811HB_GPIO_SEL_1_0_MASK |
> +		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_1,
> +						  AN8811HB_GPIO_SEL_1_0_MASK |
>  					      AN8811HB_GPIO_SEL_1_1_MASK,
>  					      AN8811HB_GPIO_SEL_1_0 |
>  					      AN8811HB_GPIO_SEL_1_1);

and here, and below...

>  		if (ret < 0)
>  			return ret;
>  
> -		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_2,
> -					      AN8811HB_GPIO_SEL_2_15_MASK,
> +		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL_2,
> +						  AN8811HB_GPIO_SEL_2_15_MASK,
>  					      AN8811HB_GPIO_SEL_2_15);
>  		if (ret < 0)
>  			return ret;
>  	} else {
> -		ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> -					      AN8811HB_GPIO_OUTPUT_345,
> +		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> +						  AN8811HB_GPIO_OUTPUT_345,
>  					      AN8811HB_GPIO_OUTPUT_345);
>  		if (ret < 0)
>  			return ret;
> @@ -1373,16 +1211,6 @@ static int en8811h_probe(struct phy_device *phydev)
>  	return 0;
>  }
>  
> -static int air_phy_read_page(struct phy_device *phydev)
> -{
> -	return phy_read(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS);
> -}
> -
> -static int air_phy_write_page(struct phy_device *phydev, int page)
> -{
> -	return phy_write(phydev, MDIO_DEVAD_NONE, AIR_EXT_PAGE_ACCESS, page);
> -}
> -
>  U_BOOT_PHY_DRIVER(en8811h) = {
>  	.name = "Airoha EN8811H",
>  	.uid = EN8811H_PHY_ID,
> diff --git a/drivers/net/phy/airoha/air_phy_lib.c b/drivers/net/phy/airoha/air_phy_lib.c
> new file mode 100644
> index 00000000000..133cba55bbf
> --- /dev/null
> +++ b/drivers/net/phy/airoha/air_phy_lib.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Airoha Ethernet PHY common library
> + *
> + * Copyright (C) 2026 Airoha Technology Corp.
> + * Copyright (C) 2026 Collabora Ltd.
> + *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> + *
> + * Adapated from https://lore.kernel.org/all/20260326-add-airoha-an8801-support-v2-2-1a42d6b6050f@collabora.com/
> + */
> +

...

> +int air_phy_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
> +			      u32 *pbus_data)
> +{
> +	int saved_page;
> +	int ret = 0;
> +
> +	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +
> +	if (saved_page >= 0) {
> +		ret = __air_buckpbus_reg_read(phydev, pbus_address, pbus_data);
> +		if (ret < 0)
> +			dev_err(phydev->dev, "%s 0x%08x failed: %d\n", __func__,
> +				pbus_address, ret);
> +	}
> +
> +	return phy_restore_page(phydev, saved_page, ret);
> +}
> +EXPORT_SYMBOL_GPL(air_phy_buckpbus_reg_read);

EXPORT_SYMBOL_GPL() is no-op in U-Boot. Should we just drop it?

