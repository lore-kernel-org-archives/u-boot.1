Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC16DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD9C88836;
	Fri, 19 Apr 2024 14:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="6fLe5IIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC448883E; Fri, 19 Apr 2024 14:33:20 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF7688838
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9asir005484; Fri, 19 Apr 2024 14:33:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=mIu9SLEERNsX6QPu1TydiNjCmIc82l/sLVvztoPYPSw=; b=6f
 Le5IIMo66SeBftr7m4zGLSbh7vOZkIdcgi2m560gTywdPpbeFqDXOIf7DI1qut1o
 FVsmSn3o3vJlCMy5VQ5ZQtsY8urNVX3SmI9E0MbZd0tMxpe3LLSY6VhJoo4fVXv/
 khVQnUIM3Nc3j9vjA6om5+3sZPRo8eHCosbk6ynRcwzmNxdhJtgdZAKf035J7oYI
 jKHgu6aCT/0s74Ajz9XXFCypRHPyGAYP51nzdmlzCgK39nxX3W3i90gmbU2+6MHv
 Gho0uG1xYsOR8teWhuDf2y4CPcz2n6n8Tm9Xo4IiieE63PAW/YBrzlUrCIqZ7EPX
 NnIGIV2h9p/RDKlwirmQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg50j9g3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:33:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 317C840046;
 Fri, 19 Apr 2024 14:33:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA33A2194EF;
 Fri, 19 Apr 2024 14:32:40 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:32:40 +0200
Message-ID: <5a1b8a2a-d1f0-44bd-83d6-c581b293c442@foss.st.com>
Date: Fri, 19 Apr 2024 14:32:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: stm32_sdmmc2: Fix AARCH64 compilation warnings
Content-Language: en-US
To: Jaehoon Chung <jh80.chung@samsung.com>, 'Patrick DELAUNAY'
 <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: 'U-Boot STM32' <uboot-stm32@st-md-mailman.stormreply.com>, 'Peng Fan'
 <peng.fan@nxp.com>, 'Sean Anderson' <seanga2@gmail.com>, 'Simon Glass'
 <sjg@chromium.org>, 'Tom Rini' <trini@konsulko.com>
References: <20240308142614.2700185-1-patrice.chotard@foss.st.com>
 <20240308142614.2700185-2-patrice.chotard@foss.st.com>
 <CGME20240417090254epcas1p2141358dc9427f77a9bb8102d88bbff6c@epcas1p2.samsung.com>
 <8602799a-7c52-4308-a58e-4986de57210b@foss.st.com>
 <01e101da90b7$fe546690$fafd33b0$@samsung.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <01e101da90b7$fe546690$fafd33b0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 4/17/24 13:11, Jaehoon Chung wrote:
> 
> 
>> -----Original Message-----
>> From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
>> Sent: Wednesday, April 17, 2024 6:02 PM
>> To: Patrice Chotard <patrice.chotard@foss.st.com>; u-boot@lists.denx.de
>> Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>> Peng Fan <peng.fan@nxp.com>; Sean Anderson <seanga2@gmail.com>; Simon Glass <sjg@chromium.org>; Tom
>> Rini <trini@konsulko.com>
>> Subject: Re: [PATCH 2/2] mmc: stm32_sdmmc2: Fix AARCH64 compilation warnings
>>
>> Hi,
>>
>> On 3/8/24 15:26, Patrice Chotard wrote:
>>> When building with AARCH64 defconfig, we got warnings, fix them.
>>>
>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> ---
>>>
>>>   drivers/mmc/stm32_sdmmc2.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/stm32_sdmmc2.c b/drivers/mmc/stm32_sdmmc2.c
>>> index d4982a14281..39ae79ba129 100644
>>> --- a/drivers/mmc/stm32_sdmmc2.c
>>> +++ b/drivers/mmc/stm32_sdmmc2.c
>>> @@ -220,9 +220,9 @@ static void stm32_sdmmc2_start_data(struct udevice *dev,
>>>
>>>   	if (data->flags & MMC_DATA_READ) {
>>>   		data_ctrl |= SDMMC_DCTRL_DTDIR;
>>> -		idmabase0 = (u32)data->dest;
>>> +		idmabase0 = (u32)(long)data->dest;
>>>   	} else {
>>> -		idmabase0 = (u32)data->src;
>>> +		idmabase0 = (u32)(long)data->src;
>>>   	}
>>>
>>>   	/* Set the SDMMC DataLength value */
>>> @@ -463,8 +463,8 @@ retry_cmd:
>>>
>>>   	stm32_sdmmc2_start_cmd(dev, cmd, cmdat, &ctx);
>>>
>>> -	dev_dbg(dev, "send cmd %d data: 0x%x @ 0x%x\n",
>>> -		cmd->cmdidx, data ? ctx.data_length : 0, (unsigned int)data);
>>> +	dev_dbg(dev, "send cmd %d data: 0x%x @ 0x%p\n",
>>> +		cmd->cmdidx, data ? ctx.data_length : 0, data);
>>>
>>>   	ret = stm32_sdmmc2_end_cmd(dev, cmd, &ctx);
>>>
>>
>>
>>
>> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Thanks
>> Patrick
> 
> 

Applied on u-boot-stm32/master 
