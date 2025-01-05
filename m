Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A541E77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 370EB805F7;
	Sun,  5 Jan 2025 23:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115130;
	bh=QGeDUvxslyIqX5NjM4pr9jxnyFxD00WBzDvtskSz6xo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ztc3Q3DdwfzngpUeJYwXMQ56M13kYLwluloxrq2qpMiEydPJcdoc71vcaA44jss5R
	 G9fgISoehLzc7aM9VkxiY5fxtOKcGwnGYtsAPQkE6zIFAYO05SPYdewrp179coPbwF
	 rR7l9aDikZqRSHaXFwQA3rRVlX/R6fROO45OXlZ9OSGIpixiRgVHg7gDaSQ3afVmQU
	 PeEYFYPMX/SqFABRMbC/XyBk4Eug8q3FvHlKJ2t3EGdHPTU0TI6rZ95dNq2tyRJsSK
	 ulDRQpZuq7P3vE8H2o6eFTebCKiJDeOZSu2l3zqQaQR2UFfcnlx5HOKqlt+iuFXdMC
	 uZOhLlshw6Now==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C71E805E9; Sun,  5 Jan 2025 23:12:07 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 745CC801CE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Xgbp1lSh"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E0756101ECBB3; Sun,  5 Jan 2025 23:12:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGeDUvxslyIqX5NjM4pr9jxnyFxD00WBzDvtskSz6xo=;
 b=Xgbp1lShiQV/ShN/3vESEFraUZgjsTm+UnQJcxbHDj96/D18pXBg36F+CjbHdWm/pT/2lz
 PAlN4LEpYgCFvrY5RnHNg6fCziWo6RJykCcYVopc27sZtwggS7lz+t3D1d3DnZfeaFM4LE
 +kSj8He7mspf5dQr4kPqBXkDQCj27sdtAD+tIP3JurZpp5gqbLllerhtnqpDgsjm0UE6iE
 2OHpSE+MJ/H/uk/vtHRhbL3AdM+Jkjru+sst5JEEAGpHlD5uXzE7+yIZZTKUWj/7N63Ve0
 XdGZgXRdPOBBs/lIxw8sFZbG8vi8vqmq+h8fUO3N5Gk0P3/W0IpoDX/XSb8Fxw==
Message-ID: <61075a72-7a89-4bcf-8d96-f9fc24dfd5a5@denx.de>
Date: Sun, 5 Jan 2025 22:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] pinctrl: nxp: add SCMI pin control protocol
 driver
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Peng Fan <peng.fan@nxp.com>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-3-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-3-6744df5dc020@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/3/25 7:45 AM, Alice Guo wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patch provides a driver for the SCMI pin control protocol which is
> based on ARM's System Control and Management Interface (SCMI) 3.2.
> Currently, only the PINCTRL_CONFIG_SET command is implemented.

What is the SCMI provider for this platform ?

> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> index 8c907c3b0328095c4b35ba089ed608fcda48b567..5f101f4ede8b585f8c562a42886ea7be4ef09953 100644
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> @@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
>   	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
>   		proto = priv->voltagedom_dev;
>   		break;
> +	case SCMI_PROTOCOL_ID_PINCTRL:
> +		proto = priv->pinctrl_dev;
> +		break;
>   	default:
>   		dev_err(dev, "Protocol not supported\n");
>   		proto = NULL;
> @@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
>   	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
>   		priv->voltagedom_dev = proto;
>   		break;
> +	case SCMI_PROTOCOL_ID_PINCTRL:
> +		priv->pinctrl_dev = proto;
> +		break;
>   	default:
>   		dev_err(dev, "Protocol not supported\n");
>   		return -EPROTO;
> @@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
>   				drv = DM_DRIVER_GET(scmi_voltage_domain);
>   			}
>   			break;
> +		case SCMI_PROTOCOL_ID_PINCTRL:
> +			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
> +			    scmi_protocol_is_supported(dev, protocol_id))
> +				drv = DM_DRIVER_GET(scmi_pinctrl_imx);

Generic code change, should be separate patch.

> +			break;
>   		default:
>   			break;
>   		}

...

> diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
> index 06c26f156f6c8f63204604d6065485629cfd9b61..0086f9825837bf568bd7633a21da860e410eeeee 100644
> --- a/drivers/pinctrl/nxp/Kconfig
> +++ b/drivers/pinctrl/nxp/Kconfig
> @@ -1,6 +1,19 @@
>   config PINCTRL_IMX
>   	bool
>   
> +config PINCTRL_IMX_SCMI
> +	bool "IMX pinctrl SCMI driver"
> +	depends on ARCH_IMX9 && PINCTRL_FULL
> +	select PINCTRL_IMX
> +	help
> +	  Say Y here to enable the imx pinctrl scmi driver

Make sure the abbreviations like SCMI are always in capitals.

> +	  This provides a simple pinctrl driver for i.MX SoC which supports
> +	  SCMI. This feature depends on device tree configuration. This driver
> +	  is different from the linux one, this is a simple implementation,
> +	  only parses the 'fsl,pins' property and configure related
> +	  registers.
> +
>   config PINCTRL_IMX_SCU
>   	bool
>   
> diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
> index f10aa6ef188e37583b181bdf9d70ac191e506d75..3ec3e2a9c6fdb875da4ae9bf151df5666256883b 100644
> --- a/drivers/pinctrl/nxp/Makefile
> +++ b/drivers/pinctrl/nxp/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_IMX6)		+= pinctrl-imx6.o
>   obj-$(CONFIG_PINCTRL_IMX7)		+= pinctrl-imx7.o
>   obj-$(CONFIG_PINCTRL_IMX7ULP)		+= pinctrl-imx7ulp.o
>   obj-$(CONFIG_PINCTRL_IMX8ULP)		+= pinctrl-imx8ulp.o
> +obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-scmi.o
>   obj-$(CONFIG_PINCTRL_IMX_SCU)		+= pinctrl-scu.o
>   obj-$(CONFIG_PINCTRL_IMX8)		+= pinctrl-imx8.o
>   obj-$(CONFIG_PINCTRL_IMX8M)		+= pinctrl-imx8m.o
> diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
> index b1960c56b512cc113a810304dc3ac3f99b237a7e..3d53d0cd4b60c0685dd4c73c23e61cb712cda0ee 100644
> --- a/drivers/pinctrl/nxp/pinctrl-imx.c
> +++ b/drivers/pinctrl/nxp/pinctrl-imx.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
> + * Copyright 2024 NXP
>    */
>   
>   #include <malloc.h>
> @@ -65,7 +66,9 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>   
>   	npins = size / pin_size;
>   
> -	if (info->flags & IMX8_USE_SCU) {
> +	if (info->flags & IMX_USE_SCMI) {
> +		return imx_pinctrl_scmi_conf_pins(dev, pin_data, npins);
> +	} else if (info->flags & IMX8_USE_SCU) {
>   		imx_pinctrl_scu_conf_pins(info, pin_data, npins);
>   	} else {
>   		/*
> @@ -216,7 +219,7 @@ int imx_pinctrl_probe(struct udevice *dev,
>   	priv->dev = dev;
>   	priv->info = info;
>   
> -	if (info->flags & IMX8_USE_SCU)
> +	if ((info->flags & IMX8_USE_SCU) || (info->flags & IMX_USE_SCMI))

This works too:
if (info->flags & (IMX8_USE_SCU | IMX_USE_SCMI))

>   		return 0;
>   
>   	addr = ofnode_get_addr_size_index(dev_ofnode(dev), 0, &size);
> diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
> index fa4c084e2fc067fcb4e92c33312d4f430081fffd..b2f8865ded0ae380fc0156baa5eaea505c12f501 100644
> --- a/drivers/pinctrl/nxp/pinctrl-imx.h
> +++ b/drivers/pinctrl/nxp/pinctrl-imx.h
> @@ -1,6 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   /*
>    * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
> + * Copyright 2024 NXP
>    */
>   
>   #ifndef __DRIVERS_PINCTRL_IMX_H
> @@ -47,6 +48,7 @@ extern const struct pinctrl_ops imx_pinctrl_ops;
>   #define ZERO_OFFSET_VALID	0x2
>   #define CFG_IBE_OBE		0x4
>   #define IMX8_USE_SCU		0x8
> +#define IMX_USE_SCMI		0x10
>   
>   #define IOMUXC_CONFIG_SION	(0x1 << 4)
>   
> @@ -65,4 +67,13 @@ static inline int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
>   }
>   #endif
>   
> +#ifdef CONFIG_PINCTRL_IMX_SCMI

Use IS_ENABLED() or CONFIG_IS_ENABLED()

> +int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins);
> +#else
> +static inline int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
> +{
> +	return 0;
> +}
> +#endif
> +
>   #endif /* __DRIVERS_PINCTRL_IMX_H */
> diff --git a/drivers/pinctrl/nxp/pinctrl-scmi.c b/drivers/pinctrl/nxp/pinctrl-scmi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..19b1b433a5ced0bb85e52f4d19bdeab2825f275e
> --- /dev/null
> +++ b/drivers/pinctrl/nxp/pinctrl-scmi.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <errno.h>
> +#include <misc.h>
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +#include <asm/io.h>
> +#include <asm/mach-imx/iomux-v3.h>
> +#include <linux/bitops.h>

Keep the list sorted.

> +#include "pinctrl-imx.h"
> +
> +#if defined(CONFIG_IMX93)

Use IS_ENABLED() or CONFIG_IS_ENABLED()

> +#define DAISY_OFFSET	0x360

Why can this offset information not be queried from the firmware interface ?

> +#endif
> +#if defined(CONFIG_IMX95)
> +#define DAISY_OFFSET	0x408
> +#endif
[...]
