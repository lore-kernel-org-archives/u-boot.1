Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75530C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 15:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9650B884A5;
	Fri,  5 Apr 2024 17:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="WEEFnaQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B6F88413; Fri,  5 Apr 2024 16:52:06 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1283D88385
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 16:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48250e1be4=christophe.roullier@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4359aBQZ018708; Fri, 5 Apr 2024 16:51:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:references:cc:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=0MRAdKwO6Uj2GpOx+CQoiBR8jtWWINNy84ct9xPkc4U=; b=WE
 EFnaQ+RvfLOA5niHkxVug1MM5lKXvK3gpKykKuFJ6pu8RSQIdXLtkWYZIaRMN2dX
 TNoLOuNozJ6eDZ9gt5mJbQ8VRUcyVfFQF2d0L93geVy2VsnM+s4ONp/03SOQFMeu
 +Oy2uKxjkWZsMWNzU6cA7fXmkm2jk9L/Uo6DbDvhR8EQYQQ9bpgahWhExdCj6Z+r
 ii2QJ9OSQCT1JUsKADSC2xGemTtKV3hNWO+ZmFb5B9kIZf5AkFDsr1DW+WwXgfWF
 3KI8milO+IchV1ZNEnGUIQqR5TQNeYtJs3Cq0lSLY8KTEH0OpJDpapdP6FCuPXWe
 mwcET6Y83iAyswHopVDw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x9emwg0dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Apr 2024 16:51:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 775484002D;
 Fri,  5 Apr 2024 16:51:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D47042194C2;
 Fri,  5 Apr 2024 16:51:25 +0200 (CEST)
Received: from [10.252.15.227] (10.252.15.227) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 5 Apr
 2024 16:51:25 +0200
Message-ID: <f4081879-7d8b-4c08-8255-9bbecac18fc3@foss.st.com>
Date: Fri, 5 Apr 2024 16:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] net: dwc_eth_qos: Use consistent logging prints
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-8-marex@denx.de>
 <c28f304c-cb4d-4079-8a59-3a44e0c31c03@foss.st.com>
 <DU2PR10MB77879CD92B0C7F81461E14988F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
CC: "Cc: Patrice Chotard" <patrice.chotard@foss.st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <DU2PR10MB77879CD92B0C7F81461E14988F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
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
>> Use dev_*() only to print all the logs from this glue code, instead of
>> mixing dev_*(), log_*(), pr_*() all in one code.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Christophe Roullier <christophe.roullier@st.com>
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   drivers/net/dwc_eth_qos_stm32.c | 52
>> ++++++++++++++++++---------------
>>   1 file changed, 28 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_stm32.c
>> b/drivers/net/dwc_eth_qos_stm32.c index 38037c47954..72f65f80540
>> 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -63,36 +63,36 @@ static int eqos_start_clks_stm32(struct udevice *dev)
>>        if (!CONFIG_IS_ENABLED(CLK))
>>                return 0;
>>
>> -     debug("%s(dev=%p):\n", __func__, dev);
>> +     dev_dbg(dev, "%s:\n", __func__);
>>
>>        ret = clk_enable(&eqos->clk_master_bus);
>>        if (ret < 0) {
>> -             pr_err("clk_enable(clk_master_bus) failed: %d", ret);
>> +             dev_err(dev, "clk_enable(clk_master_bus) failed: %d\n", ret);
>>                goto err;
>>        }
>>
>>        ret = clk_enable(&eqos->clk_rx);
>>        if (ret < 0) {
>> -             pr_err("clk_enable(clk_rx) failed: %d", ret);
>> +             dev_err(dev, "clk_enable(clk_rx) failed: %d\n", ret);
>>                goto err_disable_clk_master_bus;
>>        }
>>
>>        ret = clk_enable(&eqos->clk_tx);
>>        if (ret < 0) {
>> -             pr_err("clk_enable(clk_tx) failed: %d", ret);
>> +             dev_err(dev, "clk_enable(clk_tx) failed: %d\n", ret);
>>                goto err_disable_clk_rx;
>>        }
>>
>>        if (clk_valid(&eqos->clk_ck) && !eqos->clk_ck_enabled) {
>>                ret = clk_enable(&eqos->clk_ck);
>>                if (ret < 0) {
>> -                     pr_err("clk_enable(clk_ck) failed: %d", ret);
>> +                     dev_err(dev, "clk_enable(clk_ck) failed: %d\n", ret);
>>                        goto err_disable_clk_tx;
>>                }
>>                eqos->clk_ck_enabled = true;
>>        }
>>
>> -     debug("%s: OK\n", __func__);
>> +     dev_dbg(dev, "%s: OK\n", __func__);
>>        return 0;
>>
>>   err_disable_clk_tx:
>> @@ -102,7 +102,8 @@ err_disable_clk_rx:
>>   err_disable_clk_master_bus:
>>        clk_disable(&eqos->clk_master_bus);
>>   err:
>> -     debug("%s: FAILED: %d\n", __func__, ret);
>> +     dev_dbg(dev, "%s: FAILED: %d\n", __func__, ret);
>> +
>>        return ret;
>>   }
>>
>> @@ -113,13 +114,14 @@ static int eqos_stop_clks_stm32(struct udevice *dev)
>>        if (!CONFIG_IS_ENABLED(CLK))
>>                return 0;
>>
>> -     debug("%s(dev=%p):\n", __func__, dev);
>> +     dev_dbg(dev, "%s:\n", __func__);
>>
>>        clk_disable(&eqos->clk_tx);
>>        clk_disable(&eqos->clk_rx);
>>        clk_disable(&eqos->clk_master_bus);
>>
>> -     debug("%s: OK\n", __func__);
>> +     dev_dbg(dev, "%s: OK\n", __func__);
>> +
>>        return 0;
>>   }
>>
>> @@ -143,20 +145,20 @@ static int eqos_probe_syscfg_stm32(struct
>> udevice *dev,
>>
>>        switch (interface_type) {
>>        case PHY_INTERFACE_MODE_MII:
>> -             log_debug("PHY_INTERFACE_MODE_MII\n");
>> +             dev_dbg(dev, "PHY_INTERFACE_MODE_MII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>>                value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>>                break;
>>        case PHY_INTERFACE_MODE_GMII:
>> -             log_debug("PHY_INTERFACE_MODE_GMII\n");
>> +             dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>>                if (eth_clk_sel_reg)
>>                        value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>>                break;
>>        case PHY_INTERFACE_MODE_RMII:
>> -             log_debug("PHY_INTERFACE_MODE_RMII\n");
>> +             dev_dbg(dev, "PHY_INTERFACE_MODE_RMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_RMII);
>>                if (eth_ref_clk_sel_reg)
>> @@ -166,15 +168,15 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>        case PHY_INTERFACE_MODE_RGMII_ID:
>>        case PHY_INTERFACE_MODE_RGMII_RXID:
>>        case PHY_INTERFACE_MODE_RGMII_TXID:
>> -             log_debug("PHY_INTERFACE_MODE_RGMII\n");
>> +             dev_dbg(dev, "PHY_INTERFACE_MODE_RGMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_RGMII);
>>                if (eth_clk_sel_reg)
>>                        value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>>                break;
>>        default:
>> -             log_debug("Do not manage %d interface\n",
>> -                       interface_type);
>> +             dev_dbg(dev, "Do not manage %d interface\n",
>> +                     interface_type);
>>                /* Do not manage others interfaces */
>>                return -EINVAL;
>>        }
>> @@ -194,12 +196,12 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
>>        phy_interface_t interface;
>>        int ret;
>>
>> -     debug("%s(dev=%p):\n", __func__, dev);
>> +     dev_dbg(dev, "%s:\n", __func__);
>>
>>        interface = eqos->config->interface(dev);
>>
>>        if (interface == PHY_INTERFACE_MODE_NA) {
>> -             pr_err("Invalid PHY interface\n");
>> +             dev_err(dev, "Invalid PHY interface\n");
>>                return -EINVAL;
>>        }
>>
>> @@ -209,39 +211,41 @@ static int eqos_probe_resources_stm32(struct
>> udevice *dev)
>>
>>        ret = clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
>>        if (ret) {
>> -             pr_err("clk_get_by_name(master_bus) failed: %d", ret);
>> +             dev_err(dev, "clk_get_by_name(master_bus) failed: %d\n", ret);
>>                goto err_probe;
>>        }
>>
>>        ret = clk_get_by_name(dev, "mac-clk-rx", &eqos->clk_rx);
>>        if (ret) {
>> -             pr_err("clk_get_by_name(rx) failed: %d", ret);
>> +             dev_err(dev, "clk_get_by_name(rx) failed: %d\n", ret);
>>                goto err_probe;
>>        }
>>
>>        ret = clk_get_by_name(dev, "mac-clk-tx", &eqos->clk_tx);
>>        if (ret) {
>> -             pr_err("clk_get_by_name(tx) failed: %d", ret);
>> +             dev_err(dev, "clk_get_by_name(tx) failed: %d\n", ret);
>>                goto err_probe;
>>        }
>>
>>        /*  Get ETH_CLK clocks (optional) */
>>        ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
>>        if (ret)
>> -             pr_warn("No phy clock provided %d", ret);
>> +             dev_warn(dev, "No phy clock provided %d\n", ret);
>> +
>> +     dev_dbg(dev, "%s: OK\n", __func__);
>>
>> -     debug("%s: OK\n", __func__);
>>        return 0;
>>
>>   err_probe:
>>
>> -     debug("%s: returns %d\n", __func__, ret);
>> +     dev_dbg(dev, "%s: returns %d\n", __func__, ret);
>> +
>>        return ret;
>>   }
>>
>>   static int eqos_remove_resources_stm32(struct udevice *dev)  {
>> -     debug("%s(dev=%p):\n", __func__, dev);
>> +     dev_dbg(dev, "%s:\n", __func__);
>>
>>        return 0;
>>   }
> Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>
