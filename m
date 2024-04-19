Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2424C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E3A588787;
	Fri, 19 Apr 2024 14:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ylncWG77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD5788781; Fri, 19 Apr 2024 14:11:46 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E24F88782
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9DraA009768; Fri, 19 Apr 2024 14:11:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=ng/Vk3AAQSN3aXFRVwlurhQ2eMPepjAH4ECBSD+OuIo=; b=yl
 ncWG77CzY2U4iHN5izYhm8rkTRoY5U9oxmP2yuVllN3Tf+tutvNOumihcF7OTPql
 uVUnSzX+Pt4W/f6SFKnP02Q7Ro0X2YtpSjG/+suzxjmZ28mMRFxOJNL5ovBtaqTJ
 X1lIzkOT0jIdPczdQfBqXjlQcNNuv0G1gee+iioMg8rdZTWBrEwR8Mil/M8nZ4SW
 fFL1JOoS9hv2VcG3RXffak/tmcMlUc5sFixpUNHih/C4bfjkm/Y+aL93vHLwzzRe
 STuU+aRPW1WnM1h7PzbTBr0picgsgKBMDFyKNO3kGVhwua19VIdg9yRY3iYYqLsQ
 9OZKxp977iqHMaIArjag==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff64uspp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:11:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3379D40045;
 Fri, 19 Apr 2024 14:11:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4A86121861F;
 Fri, 19 Apr 2024 14:11:05 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:11:04 +0200
Message-ID: <6bfac1d3-50bf-4e38-a6d7-87a9bb98627e@foss.st.com>
Date: Fri, 19 Apr 2024 14:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] net: dwc_eth_qos: Add DT parsing for STM32MP13xx
 platform
Content-Language: en-US
To: Christophe ROULLIER <christophe.roullier@foss.st.com>, Marek Vasut
 <marex@denx.de>, <u-boot@lists.denx.de>
CC: Joe Hershberger <joe.hershberger@ni.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240326120745.27581-1-marex@denx.de>
 <20240326120745.27581-10-marex@denx.de>
 <DU2PR10MB7787F61FC3E236ED43D750418F002@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
 <e5230a47-e4ef-4f68-a3a0-006a3d2819ca@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <e5230a47-e4ef-4f68-a3a0-006a3d2819ca@foss.st.com>
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



On 4/8/24 17:50, Christophe ROULLIER wrote:
>> -----Original Message-----
>> From: Marek Vasut<marex@denx.de>
>> Sent: Tuesday, March 26, 2024 1:08 PM
>> To:u-boot@lists.denx.de
>> Cc: Christophe ROULLIER<christophe.roullier@st.com>; Marek Vasut<marex@denx.de>; Joe Hershberger<joe.hershberger@ni.com>; Patrice CHOTARD - foss<patrice.chotard@foss.st.com>; Patrick DELAUNAY - foss<patrick.delaunay@foss.st.com>; Ramon Fried<rfried.dev@gmail.com>;u-boot@dh-electronics.com;uboot-stm32@st-md-mailman.stormreply.com
>> Subject: [PATCH v2 09/11] net: dwc_eth_qos: Add DT parsing for STM32MP13xx platform
>>
>> From: Christophe Roullier<christophe.roullier@st.com>
>>
>> Manage 2 ethernet instances, select which instance to configure with mask If mask is not present in DT, it is stm32mp15 platform.
>>
>> Signed-off-by: Christophe Roullier<christophe.roullier@st.com>
>> Signed-off-by: Marek Vasut<marex@denx.de>  # Rework the code
>> ---
>> Cc: Christophe Roullier<christophe.roullier@st.com>
>> Cc: Joe Hershberger<joe.hershberger@ni.com>
>> Cc: Patrice Chotard<patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay<patrick.delaunay@foss.st.com>
>> Cc: Ramon Fried<rfried.dev@gmail.com>
>> Cc:u-boot@dh-electronics.com
>> Cc:uboot-stm32@st-md-mailman.stormreply.com
>> ---
>> V2: - Drop unrelated clock frequency validation
>>      - Move "st,ext-phyclk" property support into separate patch
>>      - This leaves only the regmap parts here
>> ---
>>   drivers/net/dwc_eth_qos_stm32.c | 41 ++++++++++++++++++++++-----------
>>   1 file changed, 28 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c index 0b13d01346b..5a20fe5bea2 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -23,6 +23,7 @@
>>   #include <net.h>
>>   #include <netdev.h>
>>   #include <phy.h>
>> +#include <regmap.h>
>>   #include <reset.h>
>>   #include <syscon.h>
>>   #include <wait_bit.h>
>> @@ -33,11 +34,16 @@
>>
>>   /* SYSCFG registers */
>>   #define SYSCFG_PMCSETR         0x04
>> -#define SYSCFG_PMCCLRR         0x44
>> +#define SYSCFG_PMCCLRR_MP13    0x08
>> +#define SYSCFG_PMCCLRR_MP15    0x44
>> +
>> +#define SYSCFG_PMCSETR_ETH1_MASK       GENMASK(23, 16)
>> +#define SYSCFG_PMCSETR_ETH2_MASK       GENMASK(31, 24)
>>
>>   #define SYSCFG_PMCSETR_ETH_CLK_SEL     BIT(16)
>>   #define SYSCFG_PMCSETR_ETH_REF_CLK_SEL BIT(17)
>>
>> +/* STM32MP15xx specific bit */
>>   #define SYSCFG_PMCSETR_ETH_SELMII      BIT(20)
>>
>>   #define SYSCFG_PMCSETR_ETH_SEL_MASK    GENMASK(23, 21)
>> @@ -130,23 +136,30 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,  {
>>          /* Ethernet 50MHz RMII clock selection. */
>>          const bool eth_ref_clk_sel = dev_read_bool(dev, "st,eth-ref-clk-sel");
>> +       /* SoC is STM32MP13xx with two ethernet MACs */
>> +       const bool is_mp13 = device_is_compatible(dev, "st,stm32mp13-dwmac");
>>          /* Gigabit Ethernet 125MHz clock selection. */
>>          const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
>> -       u8 *syscfg;
>> +       struct regmap *regmap;
>> +       u32 regmap_mask;
>>          u32 value;
>>
>> -       syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
>> -       if (!syscfg)
>> -               return -ENODEV;
>> +       regmap = syscon_regmap_lookup_by_phandle(dev, "st,syscon");
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       regmap_mask = dev_read_u32_index_default(dev, "st,syscon", 2,
>> +                                                SYSCFG_PMCSETR_ETH1_MASK);
>>
>>          switch (interface_type) {
>>          case PHY_INTERFACE_MODE_MII:
>>                  dev_dbg(dev, "PHY_INTERFACE_MODE_MII\n");
>>                  value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                     SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>> -               value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>> +               if (!is_mp13)   /* Select MII mode on STM32MP15xx */
>> +                       value |= SYSCFG_PMCSETR_ETH_SELMII;
>>                  break;
>> -       case PHY_INTERFACE_MODE_GMII:
>> +       case PHY_INTERFACE_MODE_GMII:   /* STM32MP15xx only */
>>                  dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
>>                  value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                     SYSCFG_PMCSETR_ETH_SEL_GMII_MII); @@ -177,13 +190,15 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>                  return -EINVAL;
>>          }
>>
>> -       /* clear and set ETH configuration bits */
>> -       writel(SYSCFG_PMCSETR_ETH_SEL_MASK | SYSCFG_PMCSETR_ETH_SELMII |
>> -              SYSCFG_PMCSETR_ETH_REF_CLK_SEL | SYSCFG_PMCSETR_ETH_CLK_SEL,
>> -              syscfg + SYSCFG_PMCCLRR);
>> -       writel(value, syscfg + SYSCFG_PMCSETR);
>> +       /* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
>> +       value <<= ffs(regmap_mask) - ffs(SYSCFG_PMCSETR_ETH1_MASK);
>>
>> -       return 0;
>> +       /* Update PMCCLRR (clear register) */
>> +       regmap_write(regmap, is_mp13 ?
>> +                            SYSCFG_PMCCLRR_MP13 : SYSCFG_PMCCLRR_MP15,
>> +                            regmap_mask);
>> +
>> +       return regmap_update_bits(regmap, SYSCFG_PMCSETR, regmap_mask, value);
>>   }
>>
>>   static int eqos_probe_resources_stm32(struct udevice *dev)
>> -- 
>> 2.43.0
> Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>

Applied on u-boot-stm32/master 
