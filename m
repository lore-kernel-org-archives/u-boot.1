Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B215C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B11886A6;
	Fri, 19 Apr 2024 14:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="oR8BEZVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6758873A; Fri, 19 Apr 2024 14:04:43 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6648869E
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JAiQss020736; Fri, 19 Apr 2024 14:04:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=5dt9imA5geoLqQQYo7hmipESSFFlZLkPAiIFhfvVNUQ=; b=oR
 8BEZVNoBpiQ80J6qsE26pgidHouxKYB39o+5WN4MymNfcRlX/HNiGKLp/+Kg3bOZ
 S8dKwHZbnk07sO0Eo+wjTmHppLsR5nfWkNiHSPxEzk02YmSqPOxGwLDQJijqDqT/
 JmOGNCW/ZnEs4CJZ6jMrdfP7lcKgPDJ4uArbv5IWq0WkTaAxXB1vriHDIYmG5rj6
 aW0PE7W1Pu6xO8b35VMDxLSQpWhykTHM5bMYg4qc+qOIYn2o5iG7J0FsUzOHv6Jc
 7sCp1uGG6tKu6f3eib9RuDK0ttE8jKBD3E+aLLEvcgaTU2eLRWnuMNB+Ry8pgnSO
 dA4Lzf5jAUWW0/sYVVaA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m127g0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:04:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 41E1940044;
 Fri, 19 Apr 2024 14:04:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6FF8F218606;
 Fri, 19 Apr 2024 14:03:57 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:03:56 +0200
Message-ID: <b1b352c8-f90d-4b44-adfe-bc62e052c959@foss.st.com>
Date: Fri, 19 Apr 2024 14:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] net: dwc_eth_qos: Split STM32 glue into separate
 file
Content-Language: en-US
To: Christophe ROULLIER <christophe.roullier@foss.st.com>, Marek Vasut
 <marex@denx.de>, <u-boot@lists.denx.de>
CC: Joe Hershberger <joe.hershberger@ni.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240326120745.27581-1-marex@denx.de>
 <20240326120745.27581-2-marex@denx.de>
 <DU2PR10MB77878C017B43BB5074AD7CA38F002@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
 <1130a47f-e63d-47fe-929c-1c27a3fe617e@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <1130a47f-e63d-47fe-929c-1c27a3fe617e@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
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



On 4/8/24 09:24, Christophe ROULLIER wrote:
>> -----Original Message-----
>> From: Marek Vasut<marex@denx.de>
>> Sent: Tuesday, March 26, 2024 1:07 PM
>> To:u-boot@lists.denx.de
>> Cc: Marek Vasut<marex@denx.de>; Patrice CHOTARD - foss<patrice.chotard@foss.st.com>; Christophe ROULLIER<christophe.roullier@st.com>; Joe Hershberger<joe.hershberger@ni.com>; Patrick DELAUNAY - foss<patrick.delaunay@foss.st.com>; Ramon Fried<rfried.dev@gmail.com>;u-boot@dh-electronics.com;uboot-stm32@st-md-mailman.stormreply.com
>> Subject: [PATCH v2 01/11] net: dwc_eth_qos: Split STM32 glue into separate file
>>
>> Move STM32 glue code into separate file to contain the STM32 specific code outside of the DWMAC core code. No functional change.
>>
>> Reviewed-by: Patrice Chotard<patrice.chotard@foss.st.com>
>> Signed-off-by: Marek Vasut<marex@denx.de>
>> ---
>> Cc: Christophe Roullier<christophe.roullier@st.com>
>> Cc: Joe Hershberger<joe.hershberger@ni.com>
>> Cc: Patrice Chotard<patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay<patrick.delaunay@foss.st.com>
>> Cc: Ramon Fried<rfried.dev@gmail.com>
>> Cc:u-boot@dh-electronics.com
>> Cc:uboot-stm32@st-md-mailman.stormreply.com
>> ---
>> V2: Add RB from Patrice
>> ---
>>   drivers/net/Makefile            |   1 +
>>   drivers/net/dwc_eth_qos.c       | 165 ---------------------------
>>   drivers/net/dwc_eth_qos.h       |   1 +
>>   drivers/net/dwc_eth_qos_stm32.c | 196 ++++++++++++++++++++++++++++++++
>>   4 files changed, 198 insertions(+), 165 deletions(-)  create mode 100644 drivers/net/dwc_eth_qos_stm32.c
>>
>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile index 6677366ebd6..dc3404519d6 100644
>> --- a/drivers/net/Makefile
>> +++ b/drivers/net/Makefile
>> @@ -23,6 +23,7 @@ obj-$(CONFIG_DWC_ETH_QOS_IMX) += dwc_eth_qos_imx.o
>>   obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) += dwc_eth_qos_rockchip.o
>>   obj-$(CONFIG_DWC_ETH_QOS_QCOM) += dwc_eth_qos_qcom.o
>>   obj-$(CONFIG_DWC_ETH_QOS_STARFIVE) += dwc_eth_qos_starfive.o
>> +obj-$(CONFIG_DWC_ETH_QOS_STM32) += dwc_eth_qos_stm32.o
>>   obj-$(CONFIG_E1000) += e1000.o
>>   obj-$(CONFIG_E1000_SPI) += e1000_spi.o
>>   obj-$(CONFIG_EEPRO100) += eepro100.o
>> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c index 9b3bce1dc87..533c2bf070b 100644
>> --- a/drivers/net/dwc_eth_qos.c
>> +++ b/drivers/net/dwc_eth_qos.c
>> @@ -295,58 +295,6 @@ err:
>>   #endif
>>   }
>>
>> -static int eqos_start_clks_stm32(struct udevice *dev) -{ -#ifdef CONFIG_CLK
>> -       struct eqos_priv *eqos = dev_get_priv(dev);
>> -       int ret;
>> -
>> -       debug("%s(dev=%p):\n", __func__, dev);
>> -
>> -       ret = clk_enable(&eqos->clk_master_bus);
>> -       if (ret < 0) {
>> -               pr_err("clk_enable(clk_master_bus) failed: %d", ret);
>> -               goto err;
>> -       }
>> -
>> -       ret = clk_enable(&eqos->clk_rx);
>> -       if (ret < 0) {
>> -               pr_err("clk_enable(clk_rx) failed: %d", ret);
>> -               goto err_disable_clk_master_bus;
>> -       }
>> -
>> -       ret = clk_enable(&eqos->clk_tx);
>> -       if (ret < 0) {
>> -               pr_err("clk_enable(clk_tx) failed: %d", ret);
>> -               goto err_disable_clk_rx;
>> -       }
>> -
>> -       if (clk_valid(&eqos->clk_ck) && !eqos->clk_ck_enabled) {
>> -               ret = clk_enable(&eqos->clk_ck);
>> -               if (ret < 0) {
>> -                       pr_err("clk_enable(clk_ck) failed: %d", ret);
>> -                       goto err_disable_clk_tx;
>> -               }
>> -               eqos->clk_ck_enabled = true;
>> -       }
>> -#endif
>> -
>> -       debug("%s: OK\n", __func__);
>> -       return 0;
>> -
>> -#ifdef CONFIG_CLK
>> -err_disable_clk_tx:
>> -       clk_disable(&eqos->clk_tx);
>> -err_disable_clk_rx:
>> -       clk_disable(&eqos->clk_rx);
>> -err_disable_clk_master_bus:
>> -       clk_disable(&eqos->clk_master_bus);
>> -err:
>> -       debug("%s: FAILED: %d\n", __func__, ret);
>> -       return ret;
>> -#endif
>> -}
>> -
>>   static int eqos_stop_clks_tegra186(struct udevice *dev)  {  #ifdef CONFIG_CLK @@ -365,22 +313,6 @@ static int eqos_stop_clks_tegra186(struct udevice *dev)
>>          return 0;
>>   }
>>
>> -static int eqos_stop_clks_stm32(struct udevice *dev) -{ -#ifdef CONFIG_CLK
>> -       struct eqos_priv *eqos = dev_get_priv(dev);
>> -
>> -       debug("%s(dev=%p):\n", __func__, dev);
>> -
>> -       clk_disable(&eqos->clk_tx);
>> -       clk_disable(&eqos->clk_rx);
>> -       clk_disable(&eqos->clk_master_bus);
>> -#endif
>> -
>> -       debug("%s: OK\n", __func__);
>> -       return 0;
>> -}
>> -
>>   static int eqos_start_resets_tegra186(struct udevice *dev)  {
>>          struct eqos_priv *eqos = dev_get_priv(dev); @@ -493,17 +425,6 @@ static ulong eqos_get_tick_clk_rate_tegra186(struct udevice *dev)  #endif  }
>>
>> -static ulong eqos_get_tick_clk_rate_stm32(struct udevice *dev) -{ -#ifdef CONFIG_CLK
>> -       struct eqos_priv *eqos = dev_get_priv(dev);
>> -
>> -       return clk_get_rate(&eqos->clk_master_bus);
>> -#else
>> -       return 0;
>> -#endif
>> -}
>> -
>>   static int eqos_set_full_duplex(struct udevice *dev)  {
>>          struct eqos_priv *eqos = dev_get_priv(dev); @@ -1415,57 +1336,6 @@ err_free_reset_eqos:
>>          return ret;
>>   }
>>
>> -static int eqos_probe_resources_stm32(struct udevice *dev) -{
>> -       struct eqos_priv *eqos = dev_get_priv(dev);
>> -       int ret;
>> -       phy_interface_t interface;
>> -
>> -       debug("%s(dev=%p):\n", __func__, dev);
>> -
>> -       interface = eqos->config->interface(dev);
>> -
>> -       if (interface == PHY_INTERFACE_MODE_NA) {
>> -               pr_err("Invalid PHY interface\n");
>> -               return -EINVAL;
>> -       }
>> -
>> -       ret = board_interface_eth_init(dev, interface);
>> -       if (ret)
>> -               return -EINVAL;
>> -
>> -       ret = clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
>> -       if (ret) {
>> -               pr_err("clk_get_by_name(master_bus) failed: %d", ret);
>> -               goto err_probe;
>> -       }
>> -
>> -       ret = clk_get_by_name(dev, "mac-clk-rx", &eqos->clk_rx);
>> -       if (ret) {
>> -               pr_err("clk_get_by_name(rx) failed: %d", ret);
>> -               goto err_probe;
>> -       }
>> -
>> -       ret = clk_get_by_name(dev, "mac-clk-tx", &eqos->clk_tx);
>> -       if (ret) {
>> -               pr_err("clk_get_by_name(tx) failed: %d", ret);
>> -               goto err_probe;
>> -       }
>> -
>> -       /*  Get ETH_CLK clocks (optional) */
>> -       ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
>> -       if (ret)
>> -               pr_warn("No phy clock provided %d", ret);
>> -
>> -       debug("%s: OK\n", __func__);
>> -       return 0;
>> -
>> -err_probe:
>> -
>> -       debug("%s: returns %d\n", __func__, ret);
>> -       return ret;
>> -}
>> -
>>   static phy_interface_t eqos_get_interface_tegra186(const struct udevice *dev)  {
>>          return PHY_INTERFACE_MODE_MII;
>> @@ -1484,12 +1354,6 @@ static int eqos_remove_resources_tegra186(struct udevice *dev)
>>          return 0;
>>   }
>>
>> -static int eqos_remove_resources_stm32(struct udevice *dev) -{
>> -       debug("%s(dev=%p):\n", __func__, dev);
>> -       return 0;
>> -}
>> -
>>   static int eqos_probe(struct udevice *dev)  {
>>          struct eqos_priv *eqos = dev_get_priv(dev); @@ -1633,35 +1497,6 @@ static const struct eqos_config __maybe_unused eqos_tegra186_config = {
>>          .ops = &eqos_tegra186_ops
>>   };
>>
>> -static struct eqos_ops eqos_stm32_ops = {
>> -       .eqos_inval_desc = eqos_inval_desc_generic,
>> -       .eqos_flush_desc = eqos_flush_desc_generic,
>> -       .eqos_inval_buffer = eqos_inval_buffer_generic,
>> -       .eqos_flush_buffer = eqos_flush_buffer_generic,
>> -       .eqos_probe_resources = eqos_probe_resources_stm32,
>> -       .eqos_remove_resources = eqos_remove_resources_stm32,
>> -       .eqos_stop_resets = eqos_null_ops,
>> -       .eqos_start_resets = eqos_null_ops,
>> -       .eqos_stop_clks = eqos_stop_clks_stm32,
>> -       .eqos_start_clks = eqos_start_clks_stm32,
>> -       .eqos_calibrate_pads = eqos_null_ops,
>> -       .eqos_disable_calibration = eqos_null_ops,
>> -       .eqos_set_tx_clk_speed = eqos_null_ops,
>> -       .eqos_get_enetaddr = eqos_null_ops,
>> -       .eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_stm32
>> -};
>> -
>> -static const struct eqos_config __maybe_unused eqos_stm32_config = {
>> -       .reg_access_always_ok = false,
>> -       .mdio_wait = 10000,
>> -       .swr_wait = 50,
>> -       .config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_AV,
>> -       .config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
>> -       .axi_bus_width = EQOS_AXI_WIDTH_64,
>> -       .interface = dev_read_phy_mode,
>> -       .ops = &eqos_stm32_ops
>> -};
>> -
>>   static const struct udevice_id eqos_ids[] = {  #if IS_ENABLED(CONFIG_DWC_ETH_QOS_TEGRA186)
>>          {
>> diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h index e3222e1e17e..a6087f191ab 100644
>> --- a/drivers/net/dwc_eth_qos.h
>> +++ b/drivers/net/dwc_eth_qos.h
>> @@ -290,4 +290,5 @@ int eqos_null_ops(struct udevice *dev);  extern struct eqos_config eqos_imx_config;  extern struct eqos_config eqos_rockchip_config;  extern struct eqos_config eqos_qcom_config;
>> +extern struct eqos_config eqos_stm32_config;
>>   extern struct eqos_config eqos_jh7110_config; diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c new file mode 100644 index 00000000000..cfda757133e
>> --- /dev/null
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -0,0 +1,196 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024, Marek Vasut<marex@denx.de>
>> + *
>> + * This is code moved from drivers/net/dwc_eth_qos.c , which is:
>> + * Copyright (c) 2016, NVIDIA CORPORATION.
>> + */
>> +
>> +#include <common.h>
>> +#include <asm/cache.h>
>> +#include <asm/gpio.h>
>> +#include <asm/io.h>
>> +#include <clk.h>
>> +#include <cpu_func.h>
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <errno.h>
>> +#include <eth_phy.h>
>> +#include <log.h>
>> +#include <malloc.h>
>> +#include <memalign.h>
>> +#include <miiphy.h>
>> +#include <net.h>
>> +#include <netdev.h>
>> +#include <phy.h>
>> +#include <reset.h>
>> +#include <wait_bit.h>
>> +#include <linux/delay.h>
>> +
>> +#include "dwc_eth_qos.h"
>> +
>> +static ulong eqos_get_tick_clk_rate_stm32(struct udevice *dev) { #ifdef
>> +CONFIG_CLK
>> +       struct eqos_priv *eqos = dev_get_priv(dev);
>> +
>> +       return clk_get_rate(&eqos->clk_master_bus);
>> +#else
>> +       return 0;
>> +#endif
>> +}
>> +
>> +static int eqos_start_clks_stm32(struct udevice *dev) { #ifdef
>> +CONFIG_CLK
>> +       struct eqos_priv *eqos = dev_get_priv(dev);
>> +       int ret;
>> +
>> +       debug("%s(dev=%p):\n", __func__, dev);
>> +
>> +       ret = clk_enable(&eqos->clk_master_bus);
>> +       if (ret < 0) {
>> +               pr_err("clk_enable(clk_master_bus) failed: %d", ret);
>> +               goto err;
>> +       }
>> +
>> +       ret = clk_enable(&eqos->clk_rx);
>> +       if (ret < 0) {
>> +               pr_err("clk_enable(clk_rx) failed: %d", ret);
>> +               goto err_disable_clk_master_bus;
>> +       }
>> +
>> +       ret = clk_enable(&eqos->clk_tx);
>> +       if (ret < 0) {
>> +               pr_err("clk_enable(clk_tx) failed: %d", ret);
>> +               goto err_disable_clk_rx;
>> +       }
>> +
>> +       if (clk_valid(&eqos->clk_ck) && !eqos->clk_ck_enabled) {
>> +               ret = clk_enable(&eqos->clk_ck);
>> +               if (ret < 0) {
>> +                       pr_err("clk_enable(clk_ck) failed: %d", ret);
>> +                       goto err_disable_clk_tx;
>> +               }
>> +               eqos->clk_ck_enabled = true;
>> +       }
>> +#endif
>> +
>> +       debug("%s: OK\n", __func__);
>> +       return 0;
>> +
>> +#ifdef CONFIG_CLK
>> +err_disable_clk_tx:
>> +       clk_disable(&eqos->clk_tx);
>> +err_disable_clk_rx:
>> +       clk_disable(&eqos->clk_rx);
>> +err_disable_clk_master_bus:
>> +       clk_disable(&eqos->clk_master_bus);
>> +err:
>> +       debug("%s: FAILED: %d\n", __func__, ret);
>> +       return ret;
>> +#endif
>> +}
>> +
>> +static int eqos_stop_clks_stm32(struct udevice *dev) { #ifdef
>> +CONFIG_CLK
>> +       struct eqos_priv *eqos = dev_get_priv(dev);
>> +
>> +       debug("%s(dev=%p):\n", __func__, dev);
>> +
>> +       clk_disable(&eqos->clk_tx);
>> +       clk_disable(&eqos->clk_rx);
>> +       clk_disable(&eqos->clk_master_bus);
>> +#endif
>> +
>> +       debug("%s: OK\n", __func__);
>> +       return 0;
>> +}
>> +
>> +static int eqos_probe_resources_stm32(struct udevice *dev) {
>> +       struct eqos_priv *eqos = dev_get_priv(dev);
>> +       int ret;
>> +       phy_interface_t interface;
>> +
>> +       debug("%s(dev=%p):\n", __func__, dev);
>> +
>> +       interface = eqos->config->interface(dev);
>> +
>> +       if (interface == PHY_INTERFACE_MODE_NA) {
>> +               pr_err("Invalid PHY interface\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret = board_interface_eth_init(dev, interface);
>> +       if (ret)
>> +               return -EINVAL;
>> +
>> +       ret = clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
>> +       if (ret) {
>> +               pr_err("clk_get_by_name(master_bus) failed: %d", ret);
>> +               goto err_probe;
>> +       }
>> +
>> +       ret = clk_get_by_name(dev, "mac-clk-rx", &eqos->clk_rx);
>> +       if (ret) {
>> +               pr_err("clk_get_by_name(rx) failed: %d", ret);
>> +               goto err_probe;
>> +       }
>> +
>> +       ret = clk_get_by_name(dev, "mac-clk-tx", &eqos->clk_tx);
>> +       if (ret) {
>> +               pr_err("clk_get_by_name(tx) failed: %d", ret);
>> +               goto err_probe;
>> +       }
>> +
>> +       /*  Get ETH_CLK clocks (optional) */
>> +       ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
>> +       if (ret)
>> +               pr_warn("No phy clock provided %d", ret);
>> +
>> +       debug("%s: OK\n", __func__);
>> +       return 0;
>> +
>> +err_probe:
>> +
>> +       debug("%s: returns %d\n", __func__, ret);
>> +       return ret;
>> +}
>> +
>> +static int eqos_remove_resources_stm32(struct udevice *dev) {
>> +       debug("%s(dev=%p):\n", __func__, dev);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct eqos_ops eqos_stm32_ops = {
>> +       .eqos_inval_desc = eqos_inval_desc_generic,
>> +       .eqos_flush_desc = eqos_flush_desc_generic,
>> +       .eqos_inval_buffer = eqos_inval_buffer_generic,
>> +       .eqos_flush_buffer = eqos_flush_buffer_generic,
>> +       .eqos_probe_resources = eqos_probe_resources_stm32,
>> +       .eqos_remove_resources = eqos_remove_resources_stm32,
>> +       .eqos_stop_resets = eqos_null_ops,
>> +       .eqos_start_resets = eqos_null_ops,
>> +       .eqos_stop_clks = eqos_stop_clks_stm32,
>> +       .eqos_start_clks = eqos_start_clks_stm32,
>> +       .eqos_calibrate_pads = eqos_null_ops,
>> +       .eqos_disable_calibration = eqos_null_ops,
>> +       .eqos_set_tx_clk_speed = eqos_null_ops,
>> +       .eqos_get_enetaddr = eqos_null_ops,
>> +       .eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_stm32 };
>> +
>> +struct eqos_config __maybe_unused eqos_stm32_config = {
>> +       .reg_access_always_ok = false,
>> +       .mdio_wait = 10000,
>> +       .swr_wait = 50,
>> +       .config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_AV,
>> +       .config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
>> +       .axi_bus_width = EQOS_AXI_WIDTH_64,
>> +       .interface = dev_read_phy_mode,
>> +       .ops = &eqos_stm32_ops
>> +};
>> -- 
>> 2.43.0
>>
> Reviewed-by: Christophe ROULLIER<christophe.roullier@foss.st.com>

Applied on u-boot-stm32/master 
