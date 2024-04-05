Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D907C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 15:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25863884B2;
	Fri,  5 Apr 2024 17:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="xtMu4LRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32805883E6; Fri,  5 Apr 2024 16:53:37 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B96388385
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 16:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48250e1be4=christophe.roullier@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 435EhSGs021122; Fri, 5 Apr 2024 16:53:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-type:message-id:date:mime-version:subject:to:references
 :cc:from:in-reply-to; s=selector1; bh=xWXnyIAdJLG04two6mGIBtRvez
 gNVzL7c3My80salaU=; b=xtMu4LRsnqQ/Q+6PUNv1cnoH6qJKIym/XcNk/K+/be
 X8dGERkNCkjEz2Z9df1en74rBayIYrDWtlUqI9IZdMB+mLXBS7bTi+/VVbtbGgfs
 fXob0imz1FjSCUomIau0349rUlV6r+Oo0nmWD1JMIKOq/M/9bO5drSTSCMA61HA0
 ktuBosAqsc9VXnm7qPDmF37o297q3K9uNApQPKYtWGAeOVT+wGRGWOIAU+fAA9SD
 i3We8FOVtINiqFaVf0zOYQ79PHjL6cBjHtFJhB9jkQbuyTF/EMo7Q39Zwz08u2hr
 kcdcZLT4IdPsRhmlob76YaziJByvRNYtdySRihIupmXg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x9emng8r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Apr 2024 16:53:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E6AFD4004A;
 Fri,  5 Apr 2024 16:53:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C5FB21A200;
 Fri,  5 Apr 2024 16:52:57 +0200 (CEST)
Received: from [10.252.15.227] (10.252.15.227) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 5 Apr
 2024 16:52:54 +0200
Message-ID: <a17945a0-c9a6-4589-94b0-3bfa1a18f06b@foss.st.com>
Date: Fri, 5 Apr 2024 16:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] net: dwc_eth_qos: Constify st,eth-* values parsed
 out of DT
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-9-marex@denx.de>
 <cb9ce060-5414-41f7-b195-d5186d05f156@foss.st.com>
 <DU2PR10MB7787A8BB0FFC662733B089BE8F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
CC: "Cc: Patrice Chotard" <patrice.chotard@foss.st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <DU2PR10MB7787A8BB0FFC662733B089BE8F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
X-Originating-IP: [10.252.15.227]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Mailman-Approved-At: Fri, 05 Apr 2024 17:32:01 +0200
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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
>> Use const bool for the values parsed out of DT. Drop the duplicate
>> assignment of false into those bool variables, assign them directly
>> with the content parsed out of DT. Abbreviate the variable name too.
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
>>   drivers/net/dwc_eth_qos_stm32.c | 18 +++++++-----------
>>   1 file changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_stm32.c
>> b/drivers/net/dwc_eth_qos_stm32.c index 72f65f80540..33477925ff1
>> 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -128,17 +128,13 @@ static int eqos_stop_clks_stm32(struct udevice
>> *dev)  static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>                                   phy_interface_t interface_type)  {
>> -     bool eth_ref_clk_sel_reg = false;
>> -     bool eth_clk_sel_reg = false;
>> +     /* Ethernet 50MHz RMII clock selection */
>> +     const bool eth_ref_clk_sel = dev_read_bool(dev, "st,eth-ref-clk-sel");
>> +     /* Gigabit Ethernet 125MHz clock selection. */
>> +     const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
>>        u8 *syscfg;
>>        u32 value;
>>
>> -     /* Gigabit Ethernet 125MHz clock selection. */
>> -     eth_clk_sel_reg = dev_read_bool(dev, "st,eth-clk-sel");
>> -
>> -     /* Ethernet 50Mhz RMII clock selection */
>> -     eth_ref_clk_sel_reg = dev_read_bool(dev, "st,eth-ref-clk-sel");
>> -
>>        syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
>>        if (!syscfg)
>>                return -ENODEV;
>> @@ -154,14 +150,14 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>                dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>> -             if (eth_clk_sel_reg)
>> +             if (eth_clk_sel)
>>                        value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>>                break;
>>        case PHY_INTERFACE_MODE_RMII:
>>                dev_dbg(dev, "PHY_INTERFACE_MODE_RMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_RMII);
>> -             if (eth_ref_clk_sel_reg)
>> +             if (eth_ref_clk_sel)
>>                        value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>>                break;
>>        case PHY_INTERFACE_MODE_RGMII:
>> @@ -171,7 +167,7 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>                dev_dbg(dev, "PHY_INTERFACE_MODE_RGMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_RGMII);
>> -             if (eth_clk_sel_reg)
>> +             if (eth_clk_sel)
>>                        value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>>                break;
>>        default:

Reviewed-by: Christophe ROULLIER<christophe.roullier@foss.st.com>
