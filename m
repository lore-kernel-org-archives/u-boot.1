Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15756CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 06:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD19881B3;
	Wed,  3 Apr 2024 08:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TW4cnBYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87787881D7; Wed,  3 Apr 2024 08:04:35 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4957487ECD
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 08:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43364RMx054395;
 Wed, 3 Apr 2024 01:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712124267;
 bh=dCkSLdDOMj5+Os8mSy+k7IQ6dawxg9dONChw6hY78yE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TW4cnBYOE25TR6/Dr7Q2iqMGEi7kX0Sdca6ckZ5PBmiLEx5OqP6yjQLVU/ntcRe3j
 cuhKPTPfhwfcf9FkW2KFtQmEHkq3ikRH3QuzmXaZK69xRKwO1y948+b6gr/zw0YQgc
 wbsx6igMyHamv7GVsCVQQpTcAjhCoA87UWIHoMHk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43364RUM120494
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 01:04:27 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 01:04:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 01:04:27 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43364LvP113615;
 Wed, 3 Apr 2024 01:04:22 -0500
Message-ID: <8d04c469-9afb-25b5-7fd7-bb786e9c2b66@ti.com>
Date: Wed, 3 Apr 2024 11:34:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/5] net: ti: icssg: Add ICSSG ethernet driver
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Maxime Ripard <mripard@kernel.org>, Nishanth Menon
 <nm@ti.com>, Roger Quadros <rogerq@kernel.org>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Devarsh Thakkar <devarsht@ti.com>, Aradhya
 Bhatia <a-bhatia1@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240327052841.1692469-1-danishanwar@ti.com>
 <20240327052841.1692469-5-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240327052841.1692469-5-danishanwar@ti.com>
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



On 3/27/24 10:58 AM, MD Danish Anwar wrote:
> This is the PRUSS Ethernet driver for TI AM654 Sr2.0 and laterSoCs with

s/Sr2.0/SR2.0
s/laterSoCs/later SoCs

> the ICSSG PRU Sub-system running EMAC firmware. ICSSG Subsystem supports
> two slices per instance. This driver caters to both slices / ports of
> the icssg subsystem.
> 
> Since it is not possible for Ethernet driver to register more than one
> port for a given instance, this patch introduces top level PRUETH as
> UCLASS_MISC and binds UCLASS_ETH to individual ports in order to support
> bringing up more than one Ethernet interface in U-Boot.
> 
> Since top level driver is UCLASS_MISC, board files would need to
> instantiate the driver explicitly.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm/mach-k3/common.c     |  11 +
>  drivers/net/ti/Kconfig        |  13 +
>  drivers/net/ti/Makefile       |   1 +
>  drivers/net/ti/icssg_prueth.c | 685 ++++++++++++++++++++++++++++++++++
>  drivers/net/ti/icssg_prueth.h |   3 +
>  5 files changed, 713 insertions(+)
>  create mode 100644 drivers/net/ti/icssg_prueth.c
> 

[...]

> @@ -7,3 +7,4 @@ obj-$(CONFIG_DRIVER_TI_EMAC) += davinci_emac.o
>  obj-$(CONFIG_DRIVER_TI_KEYSTONE_NET) += keystone_net.o cpsw_mdio.o
>  obj-$(CONFIG_TI_AM65_CPSW_NUSS) += am65-cpsw-nuss.o
>  obj-$(CONFIG_MDIO_TI_CPSW) += cpsw_mdio.o
> +obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg_prueth.o icssg_classifier.o icssg_config.o icssg_queues.o
> diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
> new file mode 100644
> index 0000000000..d22a56c217
> --- /dev/null
> +++ b/drivers/net/ti/icssg_prueth.c
> @@ -0,0 +1,685 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Texas Instruments K3 AM65 PRU Ethernet Driver
> + *
> + * Copyright (C) 2018-2024, Texas Instruments, Incorporated

URL is missing.

> + *
> + */
> +
> +#include <asm/io.h>
> +#include <asm/processor.h>
> +#include <clk.h>
> +#include <dm/lists.h>
> +#include <dm/device.h>
> +#include <dma-uclass.h>
> +#include <dm/of_access.h>
> +#include <dm/pinctrl.h>
> +#include <fs_loader.h>
> +#include <miiphy.h>
> +#include <net.h>
> +#include <phy.h>
> +#include <power-domain.h>
> +#include <linux/soc/ti/ti-udma.h>
> +#include <regmap.h>
> +#include <remoteproc.h>
> +#include <syscon.h>
> +#include <soc.h>
> +#include <linux/pruss_driver.h>
> +#include <dm/device_compat.h>
> +
> +#include "icssg_prueth.h"
> +#include "icss_mii_rt.h"
> +
> +#define ICSS_SLICE0     0
> +#define ICSS_SLICE1     1
> +
> +#ifdef PKTSIZE_ALIGN
> +#define UDMA_RX_BUF_SIZE PKTSIZE_ALIGN
> +#else
> +#define UDMA_RX_BUF_SIZE ALIGN(1522, ARCH_DMA_MINALIGN)

PKTSIZE is defined in include/net.h as below
#define PKTSIZE                 1522                                                                    
Please use the macro.

> +#endif
> +

[...]

-- 
Regards,
Ravi
