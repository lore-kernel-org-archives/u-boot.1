Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AE4C04FF6
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE01D8883D;
	Fri, 19 Apr 2024 14:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZeqUGoil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B34E8883A; Fri, 19 Apr 2024 14:33:34 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3268883C
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9dcoN007704; Fri, 19 Apr 2024 14:33:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=NQxjS3m+nKuMEvukuuCDZNQGhjufh5bqF3FnA/KHVv8=; b=Ze
 qUGoilDVCv/85aznnh6LauQRwUhXofunfptsnCcVYvdi6Fp6uFsm9jkdvcRuTg1A
 +JkoXEEFtB/gj5gsPEdj/fZsAVCpe8KISYbwZrHPZIqg+t8ssjMDSXJ4XtMdFaww
 cGxD+Gc0pQHyzqKw2N+3QrjZUM3mGu0BSAM9AVAYqtfvPQ1L8KIHygzVRt58g3ux
 ECFRKQntIXPwX8Y2zT9wsHomJkqlIXZt+Xvo9CE/KmKMIDy5Yyx/dcHLZfM6tqnM
 9gfPR9BIO1NyOfwDqwCmUPUcj8ySpNttb90YH46O/AcQynE4W58duAdPcwTqD+bU
 RCjGuRAYteCJWHUWJJ6g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff64uvh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:33:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 360AC40045;
 Fri, 19 Apr 2024 14:33:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C9AE21ADBC;
 Fri, 19 Apr 2024 14:32:54 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:32:53 +0200
Message-ID: <513a7e71-1326-4aa8-84bd-37c26f82b7bd@foss.st.com>
Date: Fri, 19 Apr 2024 14:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: stm32_sdmmc2: Add "st,stm32mp25-sdmmc2"
 compatible
Content-Language: en-US
To: Jaehoon Chung <jh80.chung@samsung.com>, 'Patrick DELAUNAY'
 <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: 'U-Boot STM32' <uboot-stm32@st-md-mailman.stormreply.com>, 'Peng Fan'
 <peng.fan@nxp.com>, 'Sean Anderson' <seanga2@gmail.com>, 'Simon Glass'
 <sjg@chromium.org>, 'Tom Rini' <trini@konsulko.com>
References: <20240308142614.2700185-1-patrice.chotard@foss.st.com>
 <CGME20240417090230epcas1p2688df3c6263283a23019c72b5553570a@epcas1p2.samsung.com>
 <79062d65-359c-4e1a-ae04-da5e9bea1ed6@foss.st.com>
 <01e001da90b7$ec103130$c4309390$@samsung.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <01e001da90b7$ec103130$c4309390$@samsung.com>
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



On 4/17/24 13:10, Jaehoon Chung wrote:
> Hi
> 
>> -----Original Message-----
>> From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
>> Sent: Wednesday, April 17, 2024 6:02 PM
>> To: Patrice Chotard <patrice.chotard@foss.st.com>; u-boot@lists.denx.de
>> Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>> Peng Fan <peng.fan@nxp.com>; Sean Anderson <seanga2@gmail.com>; Simon Glass <sjg@chromium.org>; Tom
>> Rini <trini@konsulko.com>
>> Subject: Re: [PATCH 1/2] mmc: stm32_sdmmc2: Add "st,stm32mp25-sdmmc2" compatible
>>
>> Hi,
>>
>> On 3/8/24 15:26, Patrice Chotard wrote:
>>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>
>>> Add compatible used for STM32MP25 family.
>>>
>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> ---
>>>
>>>   drivers/mmc/stm32_sdmmc2.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/stm32_sdmmc2.c b/drivers/mmc/stm32_sdmmc2.c
>>> index a2b111a8435..d4982a14281 100644
>>> --- a/drivers/mmc/stm32_sdmmc2.c
>>> +++ b/drivers/mmc/stm32_sdmmc2.c
>>> @@ -789,6 +789,7 @@ static int stm32_sdmmc2_bind(struct udevice *dev)
>>>
>>>   static const struct udevice_id stm32_sdmmc2_ids[] = {
>>>   	{ .compatible = "st,stm32-sdmmc2" },
>>> +	{ .compatible = "st,stm32mp25-sdmmc2" },
>>>   	{ }
>>>   };
>>>
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
>>
> 
> 

Applied on u-boot-stm32/master 
