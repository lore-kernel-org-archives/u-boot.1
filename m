Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3B7CD1284
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 15:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F3388497;
	Fri,  5 Apr 2024 17:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="pjv+l3ig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC12C883E6; Fri,  5 Apr 2024 16:51:05 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD0D688385
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 16:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48250e1be4=christophe.roullier@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 435EhSGV021122; Fri, 5 Apr 2024 16:50:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:references:cc:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=svKHz35YTytAV9cxzpnIuBFmI7mTc59mc8paEmiSiTY=; b=pj
 v+l3igaDdJpLe06SFfuEjHFEHQxiy7i22HAJVYjGUr7HkFu8Me3LepzMGI+g6Pxh
 p7dWKa5xP0dZNilXcp0yQYxcjTtgQk9FoY5eqoQAxzt6ge4TN3bmn09eJyMOcERd
 C5ZCKZ3Fehx+nHGRFnW9qZ0S6jeNxT/QU2jTyL57J13hc473oE3R7pPL1K5bL5JD
 Y41QO3wg8bL767xUrKk/fndQ7e371SDxzgKfHz63fwO44xYqxEo3gbsrWxcn8ABu
 B8gSEiLDZiCfR+hFiJakpcNhb2egIq1zmgDFxCgtMn5GqETn7nm1OW7vPgceKFTy
 f7grfBvZEfBwRoLLVaPQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x9emng8f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Apr 2024 16:50:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DC4364002D;
 Fri,  5 Apr 2024 16:50:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4A2CA2165FF;
 Fri,  5 Apr 2024 16:50:24 +0200 (CEST)
Received: from [10.252.15.227] (10.252.15.227) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 5 Apr
 2024 16:50:23 +0200
Message-ID: <e12a5ba9-77f7-42d0-a27e-7a7efbb474c5@foss.st.com>
Date: Fri, 5 Apr 2024 16:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] net: dwc_eth_qos: Move log_debug statements on top
 of case block
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-7-marex@denx.de>
 <a8b9ef7d-dd02-440c-a908-a9a3dc197329@foss.st.com>
 <DU2PR10MB7787B2068B63105DD92745108F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
CC: "Cc: Patrice Chotard" <patrice.chotard@foss.st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <DU2PR10MB7787B2068B63105DD92745108F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
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
>> Move the log_debug() calls on top of the bit manipulation code.
>> No functional change.
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
>>   drivers/net/dwc_eth_qos_stm32.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_stm32.c
>> b/drivers/net/dwc_eth_qos_stm32.c index 7545026b158..38037c47954
>> 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -143,34 +143,34 @@ static int eqos_probe_syscfg_stm32(struct
>> udevice *dev,
>>
>>        switch (interface_type) {
>>        case PHY_INTERFACE_MODE_MII:
>> +             log_debug("PHY_INTERFACE_MODE_MII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>>                value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>> -             log_debug("PHY_INTERFACE_MODE_MII\n");
>>                break;
>>        case PHY_INTERFACE_MODE_GMII:
>> +             log_debug("PHY_INTERFACE_MODE_GMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>>                if (eth_clk_sel_reg)
>>                        value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>> -             log_debug("PHY_INTERFACE_MODE_GMII\n");
>>                break;
>>        case PHY_INTERFACE_MODE_RMII:
>> +             log_debug("PHY_INTERFACE_MODE_RMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_RMII);
>>                if (eth_ref_clk_sel_reg)
>>                        value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>> -             log_debug("PHY_INTERFACE_MODE_RMII\n");
>>                break;
>>        case PHY_INTERFACE_MODE_RGMII:
>>        case PHY_INTERFACE_MODE_RGMII_ID:
>>        case PHY_INTERFACE_MODE_RGMII_RXID:
>>        case PHY_INTERFACE_MODE_RGMII_TXID:
>> +             log_debug("PHY_INTERFACE_MODE_RGMII\n");
>>                value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>>                                   SYSCFG_PMCSETR_ETH_SEL_RGMII);
>>                if (eth_clk_sel_reg)
>>                        value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>> -             log_debug("PHY_INTERFACE_MODE_RGMII\n");
>>                break;
>>        default:
>>                log_debug("Do not manage %d interface\n",
> Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>
