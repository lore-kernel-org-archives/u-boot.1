Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3A4E80A9E
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 07:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F2E86DC0;
	Wed, 27 Sep 2023 09:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="5GLrxiTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51BED86DC0; Wed, 27 Sep 2023 09:27:46 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B6C586D9E
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 09:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76345cf035=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QLHRuA011037; Wed, 27 Sep 2023 09:27:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=ir4VJ/5ocGMNRg1w35vnTx7rcYEd1p/RjR5qJ3vepek=; b=5G
 LrxiTHi9mzl0X/ZD6eaxmXgSlhaZdX/kZzhPkAIlp5oK+y09hnVVFqmsaWeCFLJd
 JNODrXS+LEvrzGrt8/9RrEKPNh0XqfSe2nbzmMTC5hAXZXCCEnvxFNQ4503ceZaJ
 fwYl78wZImRNqTJtrlWucINvMwGFcerFisAox9+sd2R6tmXpo5NlKfqooGqdX/q2
 I/5F8rS31aiHE+M850EY9drb+2PSjerxdMML8u0gxqUpo0bIS4kZrYHtDIakm3vL
 ko18NJ6SaAto6waRW+6JiX7ErxEStKRIohk+uqZo4AiN+jWvOFvSogeD/XFrO417
 LBWgkCxRAURY5gfhqYFA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9n54gt58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 09:27:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A080D100057;
 Wed, 27 Sep 2023 09:27:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98561214D0D;
 Wed, 27 Sep 2023 09:27:42 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 09:27:42 +0200
Message-ID: <9347aac5-7fc9-928d-7adc-eeda8e9813bd@foss.st.com>
Date: Wed, 27 Sep 2023 09:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 7/7] ARM: dts: stm32: add RNG node for STM32MP13x
 platforms
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230919152759.327420-1-gatien.chevallier@foss.st.com>
 <20230919152759.327420-8-gatien.chevallier@foss.st.com>
 <2ce2245d-6fee-f91c-86e3-1698a6c9c306@foss.st.com>
In-Reply-To: <2ce2245d-6fee-f91c-86e3-1698a6c9c306@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
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



On 9/27/23 09:11, Patrice CHOTARD wrote:
> 
> 
> On 9/19/23 17:27, Gatien Chevallier wrote:
>> Add RNG node for STM32MP13x platforms.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>> Changes in V2:
>> 	- Added Patrick's tag
>>
>>  arch/arm/dts/stm32mp131.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp131.dtsi b/arch/arm/dts/stm32mp131.dtsi
>> index d23bbc3639..bd7285053d 100644
>> --- a/arch/arm/dts/stm32mp131.dtsi
>> +++ b/arch/arm/dts/stm32mp131.dtsi
>> @@ -1208,6 +1208,14 @@
>>  			};
>>  		};
>>  
>> +		rng: rng@54004000 {
>> +			compatible = "st,stm32mp13-rng";
>> +			reg = <0x54004000 0x400>;
>> +			clocks = <&rcc RNG1_K>;
>> +			resets = <&rcc RNG1_R>;
>> +			status = "disabled";
>> +		};
>> +
>>  		mdma: dma-controller@58000000 {
>>  			compatible = "st,stm32h7-mdma";
>>  			reg = <0x58000000 0x1000>;
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
Apply on stm32/next

Patrice
