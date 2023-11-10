Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56F3C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 13:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A334B877B6;
	Fri, 10 Nov 2023 14:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="uQmjZdY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD36D8781A; Fri, 10 Nov 2023 14:23:55 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BFB6877B6
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 14:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAAkwMi030956; Fri, 10 Nov 2023 14:23:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=uJaz6nnf2Gn6y7t2bs1U95vkcv3zbnKLEbx5I0FsBYw=; b=uQ
 mjZdY8M6RQ/8MSSJ0dE2oblpbYqZY9WTTqlN5+t0PIeqHpW/hYFqxotSqwtYeQzP
 2bXuYZCCJfYJvYViAuBLQht3bITy9yn6JsjotBBGicYHh5vxwW9k6k8NjLbjE/HA
 9uPFeyS6IFr4CwsFMe2HV+KM5NBDJNMwx7XHqUeicjPpfPEffFmS7I1iiXWsgCx4
 cxkYzdL+u+oaNUY/Sm3zTh3ZYSG6j9YQLg+P5vn6/T0+oHyLwOuNC8I8kGFfOJK3
 sDr8Ll1h62l/TOH0NfbYmTJOXzW6iWV6MJsmIQdVoGb9whnuLun748U2FO254bCc
 RGa1MEjxvWHkWzw2xSlA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w26p8xm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 14:23:53 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AE27B10005F;
 Fri, 10 Nov 2023 14:23:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A72BE237D69;
 Fri, 10 Nov 2023 14:23:52 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 14:23:52 +0100
Message-ID: <f9809114-aad1-430b-8d56-460dc5bdf207@foss.st.com>
Date: Fri, 10 Nov 2023 14:23:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] pinctrl: pinctrl_stm32: Add stm32mp2 support
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-8-patrice.chotard@foss.st.com>
 <309f81b6-a9fc-4c80-937c-4874dff84ab6@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <309f81b6-a9fc-4c80-937c-4874dff84ab6@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_10,2023-11-09_01,2023-05-22_02
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



On 11/9/23 10:16, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/27/23 16:43, Patrice Chotard wrote:
>> Add stm32mp2 compatible.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   drivers/pinctrl/pinctrl_stm32.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
>> index 8bb7588714a..7120b8edba0 100644
>> --- a/drivers/pinctrl/pinctrl_stm32.c
>> +++ b/drivers/pinctrl/pinctrl_stm32.c
>> @@ -505,6 +505,8 @@ static const struct udevice_id stm32_pinctrl_ids[] = {
>>       { .compatible = "st,stm32mp157-pinctrl" },
>>       { .compatible = "st,stm32mp157-z-pinctrl" },
>>       { .compatible = "st,stm32mp135-pinctrl" },
>> +    { .compatible = "st,stm32mp257-pinctrl" },
>> +    { .compatible = "st,stm32mp257-z-pinctrl" },
>>       { }
>>   };
>>   
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/next

Thanks
Patrice
