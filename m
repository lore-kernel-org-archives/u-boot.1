Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A113C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 15:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C49884D5;
	Fri,  5 Apr 2024 17:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Iy+YM4pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802AB883C9; Fri,  5 Apr 2024 16:56:27 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C5287ED0
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 16:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48250e1be4=christophe.roullier@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4359ouSi014926; Fri, 5 Apr 2024 16:56:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:references:cc:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=LDyWbV6b6TI1YeSq9HXpUIR2ZcVXUMVZycqYnJhGuPE=; b=Iy
 +YM4pd7eHKDeryvqinUkaTWawLsD/PAitsNYhpwxBBKDTUCI3SwLp3PXh1eFw7ow
 hUb+c/JF3dXY0/S0CN30uFY8ljRtQ0sbmLnjrjJ+/RwZyL/iVeR9EuYVxq7u3TRK
 aPR1z1QcU+zXfzCSJsu/y8MfDZEXcfmPS/dZhC1E9o2frQqmateyQGIyg/QfNEPD
 iC0exQPRHwSJOCp/3OOT2EdIgj09FeBmoxUkRy84apu0yVHlDePXFscrwl8oylQY
 cyymndfid75+9UATb/OY1mS4y0pEqEbVrzq6qH8Rm6+Qy8Edb2DbsqYlVtCzqaAB
 VqPopUzsHPanaxIquGtA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x9emv02ev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Apr 2024 16:56:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EA9A040044;
 Fri,  5 Apr 2024 16:56:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F09E1214534;
 Fri,  5 Apr 2024 16:55:44 +0200 (CEST)
Received: from [10.252.15.227] (10.252.15.227) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 5 Apr
 2024 16:55:44 +0200
Message-ID: <d8887bb5-f869-48e7-84fa-39c267679bb1@foss.st.com>
Date: Fri, 5 Apr 2024 16:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] net: dwc_eth_qos: Add DT parsing for STM32MP13xx
 platform
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-11-marex@denx.de>
 <dcff1154-a4e8-4a64-9929-0e4fff6fe85f@foss.st.com>
 <DU2PR10MB77874D22D7F790BFE22F86CA8F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
CC: "Cc: Patrice Chotard" <patrice.chotard@foss.st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <DU2PR10MB77874D22D7F790BFE22F86CA8F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.15.227]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Mailman-Approved-At: Fri, 05 Apr 2024 17:32:01 +0200
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

> On 3/9/24 03:11, Marek Vasut wrote:
>> From: Christophe Roullier <christophe.roullier@st.com>
>>
>> Manage 2 ethernet instances, select which instance to configure with
>> mask If mask is not present in DT, it is stm32mp15 platform.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
>> Signed-off-by: Marek Vasut <marex@denx.de> # Rework the code
>> ---
>> Cc: Christophe Roullier <christophe.roullier@st.com>
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   drivers/net/dwc_eth_qos_stm32.c | 82
>> ++++++++++++++++++++++++++-------
>>   1 file changed, 66 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_stm32.c
>> b/drivers/net/dwc_eth_qos_stm32.c index 4db18130765..00bf6d45568
>> 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -23,6 +23,7 @@
>>   #include <net.h>
>>   #include <netdev.h>
>>   #include <phy.h>
>> +#include <regmap.h>
>>   #include <reset.h>
>>   #include <syscon.h>
>>   #include <wait_bit.h>
>> @@ -33,11 +34,16 @@
>>
>>   /* SYSCFG registers */
>>   #define SYSCFG_PMCSETR               0x04
>> -#define SYSCFG_PMCCLRR               0x44
>> +#define SYSCFG_PMCCLRR_MP13  0x08
>> +#define SYSCFG_PMCCLRR_MP15  0x44
>> +
>> +#define SYSCFG_PMCSETR_ETH1_MASK     GENMASK(23, 16)
>> +#define SYSCFG_PMCSETR_ETH2_MASK     GENMASK(31, 24)
>>
>>   #define SYSCFG_PMCSETR_ETH_CLK_SEL   BIT(16)
>>   #define SYSCFG_PMCSETR_ETH_REF_CLK_SEL       BIT(17)
>>
>> +/* STM32MP15xx specific bit */
>>   #define SYSCFG_PMCSETR_ETH_SELMII    BIT(20)
>>
>>   #define SYSCFG_PMCSETR_ETH_SEL_MASK  GENMASK(23, 21)
>> @@ -45,6 +51,11 @@
>>   #define SYSCFG_PMCSETR_ETH_SEL_RGMII 0x1
>>   #define SYSCFG_PMCSETR_ETH_SEL_RMII  0x4
>>
>> +/* CLOCK feed to PHY */
>> +#define ETH_CK_F_25M         25000000
>> +#define ETH_CK_F_50M         50000000
>> +#define ETH_CK_F_125M                125000000
>> +
>>   static ulong eqos_get_tick_clk_rate_stm32(struct udevice *dev)  {
>>        struct eqos_priv __maybe_unused *eqos = dev_get_priv(dev); @@
>> -130,34 +141,65 @@ static int eqos_probe_syscfg_stm32(struct udevice
>> *dev,  {
>>        /* Ethernet 50MHz RMII clock selection */
>>        const bool eth_ref_clk_sel = dev_read_bool(dev,
>> "st,eth-ref-clk-sel");
>> +     /* SoC is STM32MP13xx with two ethernet MACs */
>> +     const bool is_mp13 = device_is_compatible(dev,
>> +"st,stm32mp13-dwmac");
>>        /* Gigabit Ethernet 125MHz clock selection. */
>>        const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
>> -     u8 *syscfg;
>> +     /* Ethernet PHY have no crystal */
>> +     const bool ext_phyclk = dev_read_bool(dev, "st,ext-phyclk");
>> +     struct eqos_priv *eqos = dev_get_priv(dev);
>> +     struct regmap *regmap;
>> +     u32 regmap_mask;
>> +     ulong rate = 0;
>>        u32 value;
>>
>> -     syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
>> -     if (!syscfg)
>> -             return -ENODEV;
>> +     regmap = syscon_regmap_lookup_by_phandle(dev, "st,syscon");
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     regmap_mask = dev_read_u32_index_default(dev, "st,syscon", 2,
>> +                                              SYSCFG_PMCSETR_ETH1_MASK);
>> +
>> +     if (clk_valid(&eqos->clk_ck))
>> +             rate = clk_get_rate(&eqos->clk_ck);
>>
>>        switch (interface_type) {
>>        case PHY_INTERFACE_MODE_MII:
>>                dev_dbg(dev, "PHY_INTERFACE_MODE_MII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>> -             value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>> +             /*
>> +              * STM32MP15xx supports both MII and GMII, STM32MP13xx MII only.
>> +              * SYSCFG_PMCSETR ETH_SELMII is present only on STM32MP15xx and
>> +              * acts as a selector between 0:GMII and 1:MII. As STM32MP13xx
>> +              * supports only MII, ETH_SELMII is not present.
>> +              */
>> +             if (!is_mp13)   /* Select MII mode on STM32MP15xx */
>> +                     value |= SYSCFG_PMCSETR_ETH_SELMII;
>>                break;
>> -     case PHY_INTERFACE_MODE_GMII:
>> +     case PHY_INTERFACE_MODE_GMII:   /* STM32MP15xx only */
>>                dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>> -             if (eth_clk_sel)
>> +             /*
>> +              * If eth_clk_sel is set, use internal ETH_CLKx clock from RCC,
>> +              * otherwise use external clock from IO pin (requires matching
>> +              * GPIO block AF setting of that pin).
>> +              */
>> +             if (rate == ETH_CK_F_25M && (eth_clk_sel || ext_phyclk))
>>                        value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>>                break;
>>        case PHY_INTERFACE_MODE_RMII:
>>                dev_dbg(dev, "PHY_INTERFACE_MODE_RMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_RMII);
>> -             if (eth_ref_clk_sel)
>> +             /*
>> +              * If eth_ref_clk_sel is set, use internal clock from RCC,
>> +              * otherwise use external clock from ETHn_RX_CLK/ETHn_REF_CLK
>> +              * IO pin (requires matching GPIO block AF setting of that
>> +              * pin).
>> +              */
>> +             if (rate == ETH_CK_F_50M && (eth_ref_clk_sel || ext_phyclk))
>>                        value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>>                break;
>>        case PHY_INTERFACE_MODE_RGMII:
>> @@ -167,7 +209,13 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>                dev_dbg(dev, "PHY_INTERFACE_MODE_RGMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_RGMII);
>> -             if (eth_clk_sel)
>> +             /*
>> +              * If eth_clk_sel is set, use internal ETH_CLKx clock from RCC,
>> +              * otherwise use external clock from ETHx_CLK125 pin (requires
>> +              * matching GPIO block AF setting of that pin).
>> +              */
>> +             if ((rate == ETH_CK_F_25M || rate == ETH_CK_F_125M) &&
>> +                 (eth_clk_sel || ext_phyclk))
>>                        value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>>                break;
>>        default:
>> @@ -177,13 +225,15 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>                return -EINVAL;
>>        }
>>
>> -     /* clear and set ETH configuration bits */
>> -     writel(SYSCFG_PMCSETR_ETH_SEL_MASK | SYSCFG_PMCSETR_ETH_SELMII |
>> -            SYSCFG_PMCSETR_ETH_REF_CLK_SEL | SYSCFG_PMCSETR_ETH_CLK_SEL,
>> -            syscfg + SYSCFG_PMCCLRR);
>> -     writel(value, syscfg + SYSCFG_PMCSETR);
>> +     /* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
>> +     value <<= ffs(regmap_mask) - ffs(SYSCFG_PMCSETR_ETH1_MASK);
>>
>> -     return 0;
>> +     /* Update PMCCLRR (clear register) */
>> +     regmap_write(regmap, is_mp13 ?
>> +                          SYSCFG_PMCCLRR_MP13 : SYSCFG_PMCCLRR_MP15,
>> +                          regmap_mask);
>> +
>> +     return regmap_update_bits(regmap, SYSCFG_PMCSETR, regmap_mask,
>> +value);
>>   }
>>
>>   static int eqos_probe_resources_stm32(struct udevice *dev)

Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>

