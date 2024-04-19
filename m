Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696CBC04FF6
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1799188761;
	Fri, 19 Apr 2024 14:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="6UZ6uIis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6128788760; Fri, 19 Apr 2024 14:06:25 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D5C088765
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9JctI005625; Fri, 19 Apr 2024 14:06:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=y+yAo/fVt2WjM2ffzSMlKRCiWZbHxrcEWX1Lat/6bVY=; b=6U
 Z6uIisgm7N7tsvrsLtB3jxT1cFQxm7K9+gnp4Kidhzu3gYWBROQSsHN+UabVCTzq
 ETbs+KkNaJWfZomsgZyB1zqQE8gnp49CbQXBYdfUgjhX1cUMwkiukUvpvMICDRuh
 fwbm3aV0hGS15JndRhKQvyukbpwi+fsqVdg2cikWZvTY0bTK+nO2xJ8FTpmVV1+f
 5Etn+ONoBI341auefjd8e8lfptQNrfNXzN3BmTbnKHEhYeQh6JJv78oeCltF3tRx
 ln3g/pGaHWqg5Y/Wp79Qu5d2F1GssPeWHHpCEhWzWWHO0Hu+OM7XkUxyeO+bLep6
 eK0tjFkRwtz5khGYkO6Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg50j9cpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:06:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C485440046;
 Fri, 19 Apr 2024 14:06:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2BCEF218626;
 Fri, 19 Apr 2024 14:05:42 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:05:41 +0200
Message-ID: <c392f789-5e04-4f4c-beb7-2af8078c945f@foss.st.com>
Date: Fri, 19 Apr 2024 14:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] net: dwc_eth_qos: Scrub ifdeffery
Content-Language: en-US
To: Christophe ROULLIER <christophe.roullier@foss.st.com>, Marek Vasut
 <marex@denx.de>, <u-boot@lists.denx.de>
CC: Joe Hershberger <joe.hershberger@ni.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240326120745.27581-1-marex@denx.de>
 <20240326120745.27581-5-marex@denx.de>
 <DU2PR10MB7787AAE9F658F688BE5E94F58F002@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
 <86655f6c-00b0-4cc3-a7ef-c0c971fa3d15@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <86655f6c-00b0-4cc3-a7ef-c0c971fa3d15@foss.st.com>
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



On 4/8/24 09:27, Christophe ROULLIER wrote:
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Tuesday, March 26, 2024 1:07 PM
>> To: u-boot@lists.denx.de
>> Cc: Marek Vasut <marex@denx.de>; Patrice CHOTARD - foss <patrice.chotard@foss.st.com>; Christophe ROULLIER <christophe.roullier@st.com>; Joe Hershberger <joe.hershberger@ni.com>; Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>; Ramon Fried <rfried.dev@gmail.com>; u-boot@dh-electronics.com; uboot-stm32@st-md-mailman.stormreply.com
>> Subject: [PATCH v2 04/11] net: dwc_eth_qos: Scrub ifdeffery
>>
>> Replace ifdef CONFIG_CLK with if (CONFIG_IS_ENABLED(CLK)) to improve code build coverage. Some of the functions printed debug("%s: OK\n", __func__); on exit with and without CLK enabled, some did not, make it consistent and print nothing if CLK is disabled.
>>
>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
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
>> V2: Add RB from Patrice
>> ---
>>   drivers/net/dwc_eth_qos_stm32.c | 25 ++++++++++++-------------
>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c index 7520a136ed0..d7ec0c9be36 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -46,21 +46,22 @@
>>
>>   static ulong eqos_get_tick_clk_rate_stm32(struct udevice *dev)  { -#ifdef CONFIG_CLK
>> -       struct eqos_priv *eqos = dev_get_priv(dev);
>> +       struct eqos_priv __maybe_unused *eqos = dev_get_priv(dev);
>> +
>> +       if (!CONFIG_IS_ENABLED(CLK))
>> +               return 0;
>>
>>          return clk_get_rate(&eqos->clk_master_bus);
>> -#else
>> -       return 0;
>> -#endif
>>   }
>>
>>   static int eqos_start_clks_stm32(struct udevice *dev)  { -#ifdef CONFIG_CLK
>> -       struct eqos_priv *eqos = dev_get_priv(dev);
>> +       struct eqos_priv __maybe_unused *eqos = dev_get_priv(dev);
>>          int ret;
>>
>> +       if (!CONFIG_IS_ENABLED(CLK))
>> +               return 0;
>> +
>>          debug("%s(dev=%p):\n", __func__, dev);
>>
>>          ret = clk_enable(&eqos->clk_master_bus);
>> @@ -89,12 +90,10 @@ static int eqos_start_clks_stm32(struct udevice *dev)
>>                  }
>>                  eqos->clk_ck_enabled = true;
>>          }
>> -#endif
>>
>>          debug("%s: OK\n", __func__);
>>          return 0;
>>
>> -#ifdef CONFIG_CLK
>>   err_disable_clk_tx:
>>          clk_disable(&eqos->clk_tx);
>>   err_disable_clk_rx:
>> @@ -104,20 +103,20 @@ err_disable_clk_master_bus:
>>   err:
>>          debug("%s: FAILED: %d\n", __func__, ret);
>>          return ret;
>> -#endif
>>   }
>>
>>   static int eqos_stop_clks_stm32(struct udevice *dev)  { -#ifdef CONFIG_CLK
>> -       struct eqos_priv *eqos = dev_get_priv(dev);
>> +       struct eqos_priv __maybe_unused *eqos = dev_get_priv(dev);
>> +
>> +       if (!CONFIG_IS_ENABLED(CLK))
>> +               return 0;
>>
>>          debug("%s(dev=%p):\n", __func__, dev);
>>
>>          clk_disable(&eqos->clk_tx);
>>          clk_disable(&eqos->clk_rx);
>>          clk_disable(&eqos->clk_master_bus);
>> -#endif
>>
>>          debug("%s: OK\n", __func__);
>>          return 0;
>> -- 
>> 2.43.0
>>
> Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>

Applied on u-boot-stm32/master 
