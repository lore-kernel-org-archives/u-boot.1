Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CF3C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A8588792;
	Fri, 19 Apr 2024 14:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="wsrs9X2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4308878E; Fri, 19 Apr 2024 14:21:41 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F32D887DA
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43JBefrw003792; Fri, 19 Apr 2024 14:21:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=07D7bYAMyxMBvS0hZBJYAfh+VDmKwgx3J45Lny48vkw=; b=ws
 rs9X2kXB7ZNivZ+2+++5GfBKzM5EwbI4/jSd+PxY7XdYgDbGUtcX+WH1qQHJujwQ
 Crm+369YGUtEyPX5rvDRppClIc36R1rwFC0Q0Ja1a2T/rVP2S2S7XXFuSOByEBjg
 DmuUv37TBbS/SZcyegUfYT1ipHVw8zzU0dhkpvzXwWnEUfdOnQCivBek79IsA91+
 w476Tb6XM6zvO7nwKyKesD0pryzQoZDFBG8cNCImpBW1f+xy3s27XCBJ4Z1JfJmP
 g5k47fgkolXPpvfJfdbl/jI7VVkk7Txb45oMZRd1tXWZc2J8VC9E3Nbs1UaTPAA8
 bqhPU3HANwvVIFkuPcvQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffffvrwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:21:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A9C0640045;
 Fri, 19 Apr 2024 14:21:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F092E21A21A;
 Fri, 19 Apr 2024 14:21:19 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:21:19 +0200
Message-ID: <36106eee-b907-4277-8af8-0130dc09cbbb@foss.st.com>
Date: Fri, 19 Apr 2024 14:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/25] ARM: dts: stm32: Add gpio-keys for
 stm32mp157a-dk1-scmi-u-boot
Content-Language: en-US
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-11-patrice.chotard@foss.st.com>
 <e0936c25-7d4b-4149-8709-6ae083c9448f@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <e0936c25-7d4b-4149-8709-6ae083c9448f@foss.st.com>
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



On 4/17/24 11:07, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/9/24 17:02, Patrice Chotard wrote:
>> Instead of using "st,fastboot-gpios" and "st,stm32prog-gpios", declare
>> 2 gpio-keys.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> index 20728f27ee1..5d49b09c35d 100644
>> --- a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
>> @@ -3,6 +3,7 @@
>>    * Copyright : STMicroelectronics 2022
>>    */
>>   +#include <dt-bindings/input/linux-event-codes.h>
>>   #include "stm32mp15-scmi-u-boot.dtsi"
>>     / {
>> @@ -16,8 +17,22 @@
>>           u-boot,error-led = "error";
>>           u-boot,mmc-env-partition = "u-boot-env";
>>           st,adc_usb_pd = <&adc1 18>, <&adc1 19>;
>> -        st,fastboot-gpios = <&gpioa 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>> -        st,stm32prog-gpios = <&gpioa 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>> +    };
>> +
>> +    gpio-keys {
>> +        compatible = "gpio-keys";
>> +
>> +        button-user-1 {
>> +            label = "User-1";
>> +            linux,code = <BTN_1>;
>> +            gpios = <&gpioa 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>> +        };
>> +
>> +        button-user-2 {
>> +            label = "User-2";
>> +            linux,code = <BTN_2>;
>> +            gpios = <&gpioa 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>> +        };
>>       };
>>         led {
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied on u-boot-stm32/master 
