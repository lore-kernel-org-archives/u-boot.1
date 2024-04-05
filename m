Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3660C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 15:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88E34884C0;
	Fri,  5 Apr 2024 17:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="v5tKUmdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24D987DC7; Fri,  5 Apr 2024 16:54:59 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F228987D64
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 16:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48250e1be4=christophe.roullier@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4359kf1t021124; Fri, 5 Apr 2024 16:54:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:references:cc:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=IMwlZZT5Rt/ZDz8x3k2kcLnXQVKhi7HurYLd8iLceDM=; b=v5
 tKUmdyoVsAlXwbaSJ0q1Cvcz7QnzGacMKd40Wqwxmqh/QF/pfy63rCkG6W2N77uD
 9UnAIZjnmqDUQx3EzyMNzef0dJaXZnAyO1bBfUcahpYdNoeSvgq2faeP8xPoMrKi
 Stmw6gF9at5tAzYRCSiYebDlJTG0oSj/hQmKnGJg6X5DgRidxrIB0e5xX7GFUCHK
 Xpy/ltnFqCw3RTZ927lSdZPTNlwJ0iLSOkUo+cLzWMyqdtIbb7Xy1OBXoCLsoy1s
 NyxK8NMUWChpHqYkW0Ozb4GmRJmvNIAaUBvcRU+BZXo40phUDJYzqJ6kmoM/9JLx
 4b48ZO/uon/jskTRkqLA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x9emng8w3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Apr 2024 16:54:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 97EE44002D;
 Fri,  5 Apr 2024 16:54:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F2CDB2194C2;
 Fri,  5 Apr 2024 16:54:19 +0200 (CEST)
Received: from [10.252.15.227] (10.252.15.227) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 5 Apr
 2024 16:54:18 +0200
Message-ID: <54b1caf6-d807-42c7-a502-19a078cb7f19@foss.st.com>
Date: Fri, 5 Apr 2024 16:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] net: dwc_eth_qos: Request clk-ck earlier in probe
 on STM32
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-10-marex@denx.de>
 <d10d067d-ef53-490e-8383-b95f85234b6f@foss.st.com>
 <DU2PR10MB7787E4967183F1C3D45D16DF8F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
CC: "Cc: Patrice Chotard" <patrice.chotard@foss.st.com>, Patrick DELAUNAY -
 foss <patrick.delaunay@foss.st.com>, Joe Hershberger
 <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <DU2PR10MB7787E4967183F1C3D45D16DF8F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
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
>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>
>> Request the clk-ck earlier in probe in preparation for obtaining the
>> clock rate from these clk-ck in eqos_probe_syscfg_stm32() in the
>> follow up patch.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>> Cc: Christophe Roullier <christophe.roullier@st.com>
>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   drivers/net/dwc_eth_qos_stm32.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_stm32.c
>> b/drivers/net/dwc_eth_qos_stm32.c index 33477925ff1..4db18130765
>> 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -201,6 +201,11 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
>>                return -EINVAL;
>>        }
>>
>> +     /* Get ETH_CLK clocks (optional) */
>> +     ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
>> +     if (ret)
>> +             dev_dbg(dev, "No phy clock provided %d", ret);
>> +
>>        ret = eqos_probe_syscfg_stm32(dev, interface);
>>        if (ret)
>>                return -EINVAL;
>> @@ -223,11 +228,6 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
>>                goto err_probe;
>>        }
>>
>> -     /*  Get ETH_CLK clocks (optional) */
>> -     ret = clk_get_by_name(dev, "eth-ck", &eqos->clk_ck);
>> -     if (ret)
>> -             dev_warn(dev, "No phy clock provided %d\n", ret);
>> -
>>        dev_dbg(dev, "%s: OK\n", __func__);
>>
>>        return 0;

Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>

