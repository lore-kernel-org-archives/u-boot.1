Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2FFC04FF6
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B92AF88788;
	Fri, 19 Apr 2024 14:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="vqiyemBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B0A88788; Fri, 19 Apr 2024 14:12:07 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838A888782
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JBeR1U019795; Fri, 19 Apr 2024 14:11:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=2Owq1sIcToq99KTElPC01MYU3JQQJVkxGzeBgG6HGPc=; b=vq
 iyemBaZYYf+T3AOkCNMlRn3FbSskYQGgvvHb6kh5NGb/3EqpTXiimHyn5OGu7UxX
 VLkA48gTlt4KpEolHtc/uIW7AW+o8GA6MgqVgfYtk1nYpNFFO/FNNqmkLigj5k7T
 O/jkMQy4B48QO4da1RaLuHex5DPgZp9OrOdURLS4EQTwA6CgKLs080p9ht4FmvDC
 5O8c2QLav5Nme/ZXD/9YrSWtSb8aR1I2xTElGum7SsSK3XxRnz5mzqhmzc3GVtqI
 eFU8b6gvuunij9WKHzskXA7oHMfGdB2FZ70GRbizIXF172dWwVou62PwM2cC5SU3
 H7jB51YyBUvglA+HNJWg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xfhcx43hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:11:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 907F740044;
 Fri, 19 Apr 2024 14:11:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A6C22194D8;
 Fri, 19 Apr 2024 14:11:26 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:11:25 +0200
Message-ID: <a2512ea7-c1e9-4d3e-8518-a05a6963c4d5@foss.st.com>
Date: Fri, 19 Apr 2024 14:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] net: dwc_eth_qos: Add support for st, ext-phyclk
 property
Content-Language: en-US
To: Christophe ROULLIER <christophe.roullier@foss.st.com>, Marek Vasut
 <marex@denx.de>, <u-boot@lists.denx.de>
CC: Joe Hershberger <joe.hershberger@ni.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240326120745.27581-1-marex@denx.de>
 <20240326120745.27581-12-marex@denx.de>
 <DU2PR10MB7787D22F0E32E7ADB04C3E9E8F002@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
 <f643acf7-bb3b-4e77-9a92-c65c24ff496e@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <f643acf7-bb3b-4e77-9a92-c65c24ff496e@foss.st.com>
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



On 4/8/24 17:52, Christophe ROULLIER wrote:
>> -----Original Message-----
>> From: Marek Vasut<marex@denx.de>
>> Sent: Tuesday, March 26, 2024 1:08 PM
>> To:u-boot@lists.denx.de
>> Cc: Marek Vasut<marex@denx.de>; Christophe ROULLIER<christophe.roullier@st.com>; Joe Hershberger<joe.hershberger@ni.com>; Patrice CHOTARD - foss<patrice.chotard@foss.st.com>; Patrick DELAUNAY - foss<patrick.delaunay@foss.st.com>; Ramon Fried<rfried.dev@gmail.com>;u-boot@dh-electronics.com;uboot-stm32@st-md-mailman.stormreply.com
>> Subject: [PATCH v2 11/11] net: dwc_eth_qos: Add support for st,ext-phyclk property
>>
>> The "st,ext-phyclk" property is a unification of "st,eth-clk-sel"
>> and "st,eth-ref-clk-sel" properties. All three properties define ETH CK clock direction, however:
>> - "st,eth-clk-sel" selects clock direction for GMII/RGMII mode
>> - "st,eth-ref-clk-sel" selects clock direction for RMII mode
>> - "st,ext-phyclk" selects clock direction for all RMII/GMII/RGMII modes The "st,ext-phyclk" is the preferrable property to use.
>>
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
>> V2: New patch
>> ---
>>   drivers/net/dwc_eth_qos_stm32.c | 30 +++++++++++++++++++++++++++---
>>   1 file changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c index 435473f99a6..9ee82b54c62 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -140,6 +140,8 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>          const bool is_mp13 = device_is_compatible(dev, "st,stm32mp13-dwmac");
>>          /* Gigabit Ethernet 125MHz clock selection. */
>>          const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
>> +       /* Ethernet clock source is RCC. */
>> +       const bool ext_phyclk = dev_read_bool(dev, "st,ext-phyclk");
>>          struct regmap *regmap;
>>          u32 regmap_mask;
>>          u32 value;
>> @@ -156,6 +158,12 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>                  dev_dbg(dev, "PHY_INTERFACE_MODE_MII\n");
>>                  value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                     SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>> +               /*
>> +                * STM32MP15xx supports both MII and GMII, STM32MP13xx MII only.
>> +                * SYSCFG_PMCSETR ETH_SELMII is present only on STM32MP15xx and
>> +                * acts as a selector between 0:GMII and 1:MII. As STM32MP13xx
>> +                * supports only MII, ETH_SELMII is not present.
>> +                */
>>                  if (!is_mp13)   /* Select MII mode on STM32MP15xx */
>>                          value |= SYSCFG_PMCSETR_ETH_SELMII;
>>                  break;
>> @@ -163,14 +171,25 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>                  dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
>>                  value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                     SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>> -               if (eth_clk_sel)
>> +               /*
>> +                * If eth_clk_sel is set, use internal ETH_CLKx clock from RCC,
>> +                * otherwise use external clock from IO pin (requires matching
>> +                * GPIO block AF setting of that pin).
>> +                */
>> +               if (eth_clk_sel || ext_phyclk)
>>                          value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>>                  break;
>>          case PHY_INTERFACE_MODE_RMII:
>>                  dev_dbg(dev, "PHY_INTERFACE_MODE_RMII\n");
>>                  value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                     SYSCFG_PMCSETR_ETH_SEL_RMII);
>> -               if (eth_ref_clk_sel)
>> +               /*
>> +                * If eth_ref_clk_sel is set, use internal clock from RCC,
>> +                * otherwise use external clock from ETHn_RX_CLK/ETHn_REF_CLK
>> +                * IO pin (requires matching GPIO block AF setting of that
>> +                * pin).
>> +                */
>> +               if (eth_ref_clk_sel || ext_phyclk)
>>                          value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>>                  break;
>>          case PHY_INTERFACE_MODE_RGMII:
>> @@ -180,7 +199,12 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>                  dev_dbg(dev, "PHY_INTERFACE_MODE_RGMII\n");
>>                  value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                     SYSCFG_PMCSETR_ETH_SEL_RGMII);
>> -               if (eth_clk_sel)
>> +               /*
>> +                * If eth_clk_sel is set, use internal ETH_CLKx clock from RCC,
>> +                * otherwise use external clock from ETHx_CLK125 pin (requires
>> +                * matching GPIO block AF setting of that pin).
>> +                */
>> +               if (eth_clk_sel || ext_phyclk)
>>                          value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>>                  break;
>>          default:
>> -- 
>> 2.43.0
>>
> Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>

Applied on u-boot-stm32/master 
