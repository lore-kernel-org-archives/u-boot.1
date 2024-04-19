Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19063C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F92E88749;
	Fri, 19 Apr 2024 14:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ggfvg1ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56BAE8874D; Fri, 19 Apr 2024 14:11:30 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F5978873D
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J8F2Sr029437; Fri, 19 Apr 2024 14:11:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=G7RV6DgpgVpTfjzc7nHgkLril1adwAisD5qoBnwJFzU=; b=gg
 fvg1ho1zDMoxDmRsL7iGpQFOTCqXq1gQmmTyGHtRPpNzShw2JzqWrMKDrHR+H6UQ
 y2cNpTcKZpbqXnmNlf5CUZHMfhU2YpGG+fRMpDNY/sjBPqfig1yBHjvWtohPE92I
 v1JNDAbKfLytbxXi8R48J3KXfdrZidb6bU9NSIWNacRusOmKzw5hHkQBxoDuKN6p
 Q2b7ZvjBWLTXPfZ7KzqznEkNIlLOOnto4jzb1ZcHfWZ7WZXaliolpq0ONsEwQ00j
 DgKwCPjHMG9b23ARNbuAnlQGvhfZHUEJd/cB4uNe+06s2bzhEIgy57seDe9/Mw9B
 OFn4mvOjuN9hNLuog2Cw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecyraqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:11:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8F77540044;
 Fri, 19 Apr 2024 14:11:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 49C512194D5;
 Fri, 19 Apr 2024 14:11:14 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:11:13 +0200
Message-ID: <9392f75a-4cf8-4af8-b2fd-3c997f9721e4@foss.st.com>
Date: Fri, 19 Apr 2024 14:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] net: dwc_eth_qos: Add support of STM32MP13xx
 platform
Content-Language: en-US
To: Christophe ROULLIER <christophe.roullier@foss.st.com>, Marek Vasut
 <marex@denx.de>, <u-boot@lists.denx.de>
CC: Joe Hershberger <joe.hershberger@ni.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240326120745.27581-1-marex@denx.de>
 <20240326120745.27581-11-marex@denx.de>
 <DU2PR10MB7787E5DD3C53330D616436E68F002@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
 <62fb769e-51fd-4c07-9af6-da751f6f0736@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <62fb769e-51fd-4c07-9af6-da751f6f0736@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
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



On 4/8/24 17:51, Christophe ROULLIER wrote:
>> -----Original Message-----
>> From: Marek Vasut<marex@denx.de>
>> Sent: Tuesday, March 26, 2024 1:08 PM
>> To:u-boot@lists.denx.de
>> Cc: Christophe ROULLIER<christophe.roullier@st.com>; Patrice CHOTARD - foss<patrice.chotard@foss.st.com>; Marek Vasut<marex@denx.de>; Joe Hershberger<joe.hershberger@ni.com>; Patrick DELAUNAY - foss<patrick.delaunay@foss.st.com>; Ramon Fried<rfried.dev@gmail.com>;u-boot@dh-electronics.com;uboot-stm32@st-md-mailman.stormreply.com
>> Subject: [PATCH v2 10/11] net: dwc_eth_qos: Add support of STM32MP13xx platform
>>
>> From: Christophe Roullier<christophe.roullier@st.com>
>>
>> Add compatible "st,stm32mp13-dwmac" to manage STM32MP13 boards.
>>
>> Reviewed-by: Patrice Chotard<patrice.chotard@foss.st.com>
>> Signed-off-by: Christophe Roullier<christophe.roullier@st.com>
>> Signed-off-by: Marek Vasut<marex@denx.de>  # Rebase, reshuffle, squash code
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
>>   drivers/net/dwc_eth_qos.c       |  4 ++++
>>   drivers/net/dwc_eth_qos.h       |  1 +
>>   drivers/net/dwc_eth_qos_stm32.c | 11 +++++++++++
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c index 203bfc0848c..e02317905e5 100644
>> --- a/drivers/net/dwc_eth_qos.c
>> +++ b/drivers/net/dwc_eth_qos.c
>> @@ -1505,6 +1505,10 @@ static const struct udevice_id eqos_ids[] = {
>>          },
>>   #endif
>>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STM32)
>> +       {
>> +               .compatible = "st,stm32mp13-dwmac",
>> +               .data = (ulong)&eqos_stm32mp13_config
>> +       },
>>          {
>>                  .compatible = "st,stm32mp1-dwmac",
>>                  .data = (ulong)&eqos_stm32mp15_config diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h index bafd0d339fb..8b3d0d464d3 100644
>> --- a/drivers/net/dwc_eth_qos.h
>> +++ b/drivers/net/dwc_eth_qos.h
>> @@ -290,5 +290,6 @@ int eqos_null_ops(struct udevice *dev);  extern struct eqos_config eqos_imx_config;  extern struct eqos_config eqos_rockchip_config;  extern struct eqos_config eqos_qcom_config;
>> +extern struct eqos_config eqos_stm32mp13_config;
>>   extern struct eqos_config eqos_stm32mp15_config;  extern struct eqos_config eqos_jh7110_config; diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c index 5a20fe5bea2..435473f99a6 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -279,6 +279,17 @@ static struct eqos_ops eqos_stm32_ops = {
>>          .eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_stm32  };
>>
>> +struct eqos_config __maybe_unused eqos_stm32mp13_config = {
>> +       .reg_access_always_ok = false,
>> +       .mdio_wait = 10000,
>> +       .swr_wait = 50,
>> +       .config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
>> +       .config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
>> +       .axi_bus_width = EQOS_AXI_WIDTH_32,
>> +       .interface = dev_read_phy_mode,
>> +       .ops = &eqos_stm32_ops
>> +};
>> +
>>   struct eqos_config __maybe_unused eqos_stm32mp15_config = {
>>          .reg_access_always_ok = false,
>>          .mdio_wait = 10000,
>> -- 
>> 2.43.0
>>
> Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>


Applied on u-boot-stm32/master 
